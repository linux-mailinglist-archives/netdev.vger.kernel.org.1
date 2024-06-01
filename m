Return-Path: <netdev+bounces-99904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 475888D6F58
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 12:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D3D283E44
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDA079949;
	Sat,  1 Jun 2024 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlbC5hHi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470FBAD59;
	Sat,  1 Jun 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717237176; cv=none; b=JaWtYEGNZ75dxR/lE+t4TAOEgPpSecszZzAZHHVUwK9AIDgx2a5hO+XtqSlE72/CvxAUbalL1JY9h0Pgmna3iWE/YO11tNocZ+rms+Xkd0HFr5C3yWLuSWt3ETU5q4EbVwzir/nZK9xaMYTP73nKzhjJugPjyh9fKU2g5sXVJPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717237176; c=relaxed/simple;
	bh=sMFhjPh7JDKJ1MjejY8b9DGy1ZvZd+eBy+OfIkYL1e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpddA1gyY9YOcktHezi8J/ct/oKhYLqs67PLfW4eoqgKuJxFmZ+oGbRVSMu4j1S7h02Sn8nxdZsgPzwv45fHrWoJBwgjFKz57LkZrUkQitn2PswyDBSCZB9WMo7jQ4PXwzJMNpO8MIUkwXcnqTBt1zvvlcseu/PYAJsnyWGFo7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlbC5hHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC06BC116B1;
	Sat,  1 Jun 2024 10:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717237175;
	bh=sMFhjPh7JDKJ1MjejY8b9DGy1ZvZd+eBy+OfIkYL1e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlbC5hHi5JsXsNZTldG4HACIMBwI2931rl1FnngOMBCoooNYUwYYyoLii092jhhQr
	 0JLu8MhI/da2xOxoop9FSCaZXplPzPGV1rNvK1aBb6+DB7JgV3yIqAOtRl340r1bvb
	 y8aXw/ickHFoEsUSrgsBMzaZtuJE+qtBXhjZGZVpRqKcVuCscr8k3c9wVQ2ifzbamn
	 FeHk8XYRfati+QSzyfI00jdH5Jb5Vs+KJjGZhY4DF8WGFhR9yEdYpnXx1ypExvycY5
	 FvSLopPKSTVNajvqS9EmJFW7n16Z4ikuoGJcB7+ega1OSwVs/4To1xgNrMI3UhR8vv
	 wMoXGI1dcdFiw==
Date: Sat, 1 Jun 2024 11:19:30 +0100
From: Simon Horman <horms@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com,
	lcherian@marvell.com, richardcochran@gmail.com
Subject: Re: [net-next,v3 6/8] cn10k-ipsec: Process inline ipsec transmit
 offload
Message-ID: <20240601101930.GB491852@kernel.org>
References: <20240528135349.932669-1-bbhushan2@marvell.com>
 <20240528135349.932669-7-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528135349.932669-7-bbhushan2@marvell.com>

On Tue, May 28, 2024 at 07:23:47PM +0530, Bharat Bhushan wrote:
> Prepare and submit crypto hardware (CPT) instruction for
> outbound inline ipsec crypto mode offload. The CPT instruction
> have authentication offset, IV offset and encapsulation offset
> in input packet. Also provide SA context pointer which have
> details about algo, keys, salt etc. Crypto hardware encrypt,
> authenticate and provide the ESP packet to networking hardware.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>

Hi Bharat,

A minor nit from my side as it looks like there will be a v4 anyway.

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c

...

> +bool cn10k_ipsec_transmit(struct otx2_nic *pf, struct netdev_queue *txq,
> +			  struct otx2_snd_queue *sq, struct sk_buff *skb,
> +			  int num_segs, int size)
> +{

...

> +	/* Check for valid SA context */
> +	sa_info = (struct cpt_ctx_info_s *)x->xso.offload_handle;
> +	if (!sa_info || !sa_info->sa_iova) {
> +		netdev_err(pf->netdev, "Invalid SA conext\n");

nit: context

     checkpatch.pl --codespell is your friend.

> +		goto drop;
> +	}

...

