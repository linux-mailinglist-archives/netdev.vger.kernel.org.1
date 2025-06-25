Return-Path: <netdev+bounces-201073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F1AE7FD5
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271C417B5FC
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1F529C33C;
	Wed, 25 Jun 2025 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsbOkdtR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3529B224;
	Wed, 25 Jun 2025 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848223; cv=none; b=hxcKOK39sKLS3FrcQ21FJo11ON8cwoPgYD/2Njsl7lkeKigSjmnVnDuXCje2wwCvJKQ/oumIRS3BVRK9y0Dd5d+rb/vVnqqLaB/lDj6nHKv+90wAtqWE1w8cQgYaXHR7nrnCcy/Z9TMEDhw2CHHEtB4nJSTvTSooc4gRhYHzogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848223; c=relaxed/simple;
	bh=bPlTIiXfUd4DLH+842hTOjtrbMNlSyt5bBcTD2L4g3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUYmI73qDVAIX3czKnT+vaWdnUwMm07UQp6aumqK8j/NU9Zu+5pQa+Q2KUyINFIlvvxP/bBVJG1NFtNtO9Ot8Db2Ouv1l6MxQVchqF8tTdf1F0xYVs3rqU6pNm1uygSrogKIEUZaW55rudx3KF+x7UQKOtFMCqKvumKXxJzneUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsbOkdtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FCDC4CEEA;
	Wed, 25 Jun 2025 10:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750848223;
	bh=bPlTIiXfUd4DLH+842hTOjtrbMNlSyt5bBcTD2L4g3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsbOkdtRLcaCkhOSZ8PRBUBq4c+P+L+UO4z98C/dRX0wUePeojz9BlUORQiBXp9Hl
	 GxyZ3y6AlTCECjQdrxyY8fAuIfETAGYJSfOkR6dQDvYJSrSADahMGM/eFH+6A+nBrk
	 SBLenAr6ocFh+GCFOBZtPoA3gehv46YWP+91u+jtedI/d3Gb3m9xuIbKSJar2C6mcR
	 mq5xlRvjUL3UtgUsHk5Oyd8/zH1FPR72UjEceTWTr2xoKA7JGM2xlD/MsaNry1z+2g
	 OFTTJX7RNvDrggZEJa4nYlOEODnGL07FHLEdACCcjneHewzIrajDwaKR1mX4VcbBvZ
	 170u8DL6DKGiQ==
Date: Wed, 25 Jun 2025 11:43:39 +0100
From: Simon Horman <horms@kernel.org>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: ioana.ciornei@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] dpaa2-eth: fix xdp_rxq_info leak in
 dpaa2_eth_setup_rx_flow
Message-ID: <20250625104339.GW1562@horms.kernel.org>
References: <20250624144235.69622-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624144235.69622-1-wangfushuai@baidu.com>

On Tue, Jun 24, 2025 at 10:42:35PM +0800, Fushuai Wang wrote:
> When xdp_rxq_info_reg_mem_model() fails after a successful
> xdp_rxq_info_reg(), the kernel may leaks the registered RXQ
> info structure. Fix this by calling xdp_rxq_info_unreg() in
> the error path, ensuring proper cleanup when memory model
> registration fails.
> 
> Fixes: d678be1dc1ec ("dpaa2-eth: add XDP_REDIRECT support")
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Thanks, I agree this is needed.

Reviewed-by: Simon Horman <horms@kernel.org>

But I wonder how these resources are released in the following cases:

* Error in dpaa2_eth_bind_dpni() after at least one
  successful call to dpaa2_eth_setup_rx_flow()

* Error in dpaa2_eth_probe() after a successful call to
  dpaa2_eth_bind_dpni()

* Driver removal (dpaa2_eth_remove())


