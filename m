Return-Path: <netdev+bounces-53211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B13A801A36
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 04:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049951F20C74
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB46137;
	Sat,  2 Dec 2023 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYm906j5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3323AF
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 03:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49AAC433CA;
	Sat,  2 Dec 2023 03:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701487533;
	bh=O/MVqfvmW+AqFIkFNvJJTYHRWHCtq611suoFas+OBRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OYm906j5CrzRp1d+UIEEJTuG+cx7K4mJ1aRl+BUhtMxb1TkAoIMg8xTYcm0SBFay8
	 ElWW3LfKyu8PRg/iQ6QTuA1N643QeLgQXNKQ8OQpYd+SlfAFB8Ka98nuFTALguwlJX
	 26Mg3k9nbGQ77TxHwXZr9ltgmjNIhVCWvmwy9X4CRun6ijDk7/sc12TsEW0RN1PMsL
	 ocmG4ZSfpqlhKkaD0zuYy7yfz6Ve3qsDoTfd1zGmvRFlBcIektlyn7NzYgo5LxgXzF
	 9OuyLRHItM+8K2Q/A0VEPZQvT1+EHW8gp+86GhdJpw8yzDEpSP3gbLkst7ASSjpzV1
	 vG0RPw/73auiA==
Date: Fri, 1 Dec 2023 19:25:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alex Austin <alex.austin@amd.com>
Cc: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>,
 <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>, <lorenzo@kernel.org>, <memxor@gmail.com>,
 <alardam@gmail.com>, <bhelgaas@google.com>
Subject: Re: [PATCH net-next 1/2] sfc: Implement ndo_hwtstamp_(get|set)
Message-ID: <20231201192531.2d35fb39@kernel.org>
In-Reply-To: <20231130135826.19018-2-alex.austin@amd.com>
References: <20231130135826.19018-1-alex.austin@amd.com>
	<20231130135826.19018-2-alex.austin@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 13:58:25 +0000 Alex Austin wrote:
> -	struct hwtstamp_config config;
> +	struct kernel_hwtstamp_config config;

> +	*config = efx->ptp_data->config;

Do we have a lot of places which assign the new structure directly 
like this?

There's a bit of "request state" in it:

struct kernel_hwtstamp_config {
	int flags;
	int tx_type;
	int rx_filter;
	struct ifreq *ifr;             <<<
	bool copied_to_user;           <<<
	enum hwtstamp_source source;
};

Maybe keep the type of config as was, and use
hwtstamp_config_to_kernel() to set the right fields?

