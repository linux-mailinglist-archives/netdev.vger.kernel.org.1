Return-Path: <netdev+bounces-61712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6EC824B54
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 00:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282201F23198
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 23:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64DE2C872;
	Thu,  4 Jan 2024 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbw1CruV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF912D03B
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 22:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA43AC433C7;
	Thu,  4 Jan 2024 22:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704409196;
	bh=dpXp7/k+iBbZO+MMQPecNkFHokAj0snGHBPbTe9RyzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bbw1CruVCR0cDzvfNZ47gev9Nc37sCG/UXH8JKDFI4axJXCIc0kbzOBMH9ZX5kgvy
	 6wuZouu79VW3iI7KMHNxitulVSprCPM6Ox3cYUn629fuG+u/jTDMjDlyrFZhzPCebD
	 6oSspFCD3fjtfuhXxZ1SYvVzuJn2aVGOBMq7B/f6gtcADdIxVPYa2nHnf2gdj2EwYe
	 Wpi440f79G06s6n19RM+E1Yu9bxqKk3BTwpxccjixGhM2IXQNvV5GugdtxRXVj9OV0
	 cWkibY6NNFE92V21QQ1wBWyFR+SoZS/V/tj6Qdox5Ky0jfzVCjlCkXqsmOgbR78HAs
	 zJS+22T7IvHLg==
Date: Thu, 4 Jan 2024 14:59:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 13/13] bnxt_en: Add support for ntuple
 filter deletion by ethtool.
Message-ID: <20240104145955.5a6df702@kernel.org>
In-Reply-To: <20231223042210.102485-14-michael.chan@broadcom.com>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
	<20231223042210.102485-14-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 20:22:10 -0800 Michael Chan wrote:
> +	if (fltr_base) {
> +		struct bnxt_ntuple_filter *fltr;
> +
> +		fltr = container_of(fltr_base, struct bnxt_ntuple_filter, base);
> +		rcu_read_unlock();
> +		if (!(fltr->base.flags & BNXT_ACT_NO_AGING))
> +			return -EINVAL;

This looks pretty suspicious, you drop the RCU lock before ever using
the object. I'm guessing the filter may be form aRFS and that's why
we need RCU? Shouldn't you hold the RCU lock when checking that
NO_AGING is set? If it's an aRFS flow it may disappear..

