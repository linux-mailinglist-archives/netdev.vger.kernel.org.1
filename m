Return-Path: <netdev+bounces-20940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C7C761F99
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F99281600
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EFE2418E;
	Tue, 25 Jul 2023 16:53:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E41F927
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B8FC433C8;
	Tue, 25 Jul 2023 16:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690304009;
	bh=IxAEg/zFNLeaSOZ2+I4D9yyaJpFMEaswtXPaBzxnKgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SxH+OGq4T9EJ5mb76lXK+oW2BxdhHd7R3WW97C3AISLcrhGM+/cY0HhzoDLq99fnR
	 pqWDGfjsnv8PloQmggBJAcbzdordfUmLHnkgmXKBBfRAP/elOmTlMf17KHF5uCZlSk
	 YN7ACW+2ggKI5Cvv4kxqEMhIqelM6jJYzC0EaBxvdZly6Xd52r1ZqFeBTiC+l351ao
	 9Tbt+epizrET4rBKIrKL29eZed29GvBaq2ZXiJyrxO7RpTDFpkzd+ztPU+zJksn2lE
	 baNiQvt2HO1/JIJ9gLCDCMDZarJRm6gFWd0/JCCPwT8oDbt+6LDYn5kY0mLce97t88
	 rrm+EMRUjvb1A==
Date: Tue, 25 Jul 2023 09:53:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Lin Ma <linma@zju.edu.cn>, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i40e: Add length check for IFLA_AF_SPEC parsing
Message-ID: <20230725095327.385616f1@kernel.org>
In-Reply-To: <20230725054046.GK11388@unreal>
References: <20230723075042.3709043-1-linma@zju.edu.cn>
	<20230724174435.GA11388@unreal>
	<20230724142155.13c83625@kernel.org>
	<20230725054046.GK11388@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 08:40:46 +0300 Leon Romanovsky wrote:
> > Empty attributes are valid, we can't do that.  
> 
> Maybe Lin can add special version of nla_for_each_nested() which will
> skip these empty NLAs, for code which don't allow empty attributes.

It's way too arbitrary. Empty attrs are 100% legit, they are called
NLA_FLAG in policy parlance. They are basically a boolean.

