Return-Path: <netdev+bounces-226121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24565B9C72A
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F542E58CF
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 23:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ABF27F724;
	Wed, 24 Sep 2025 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0l+cKGd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726E1F91D6;
	Wed, 24 Sep 2025 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755513; cv=none; b=eZrfmO8xCdZ+Gh/1hRdi7W51pzTTX/mC/J8FXDsi3852nk3U97BGiOD20hzROXRAiX+CqUfSG0+qen2MDrm7yAmgzavhuWgAs+9Y0CKdGkQCxdevCxD+IJ5kKR8SliMnh+UVTxpER/+V1xwrKSDouj/kV9WryosR8tVOFKCFkVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755513; c=relaxed/simple;
	bh=DNAVGkbi5Yhvp2bXzfZFpJDUGypA5Y8AoL9yvckkCNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1Vh8VyZh5uwr+w12qQkhZnRuosEFtLDm+AwssJeb2ukDWET7D76tqrz6c/vduuaBUrxyYbe+m+qTkFiXIJnnFZkC74ta4RPwdvFrR6h2Yxo5ejJR/FpVcrm+/wYp5QTQJvunzsR++7ZXsuCB+MfGfHNCZMadprkiC6akE2A9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0l+cKGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B19C4CEE7;
	Wed, 24 Sep 2025 23:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758755512;
	bh=DNAVGkbi5Yhvp2bXzfZFpJDUGypA5Y8AoL9yvckkCNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L0l+cKGd4FvmVyjI5vbZFJ+sH6K/0Rlc90YXdZe+QYhau0C+StgZblXWVDSzljftw
	 KuXi3sKwSTGNywRrsyn460bNKPWiyMB5s3TDzNIZJvoAqiBZGdITgIXAqIP8gdavYO
	 IQSySr4gqwi1NT7zrZIbNLJ3IjjMWSkxvByMNU9MYUGn76KANIEw96G5pnkSOh4ytz
	 qqkzJgsqc8R/VkP5TWK05N5lkYtMi5ak9O5WOYD6YkptdEUCHGsPynGoox5PCAwUda
	 K88GIQqJtrS/nH1A6jVuFTHrjTpkwKObzPwN1LjWOq1P3dEFlgcv8V9n0ExHQamFo9
	 rrYwx50ah6yPw==
Date: Wed, 24 Sep 2025 16:11:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Yeounsu Moon" <yyyynoom@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] net: dlink: handle copy_thresh allocation
 failure
Message-ID: <20250924161151.7d6054c2@kernel.org>
In-Reply-To: <DD16EAXYP4SM.1JYDYPDJ4I7VV@gmail.com>
References: <20250916183305.2808-1-yyyynoom@gmail.com>
	<20250916183305.2808-3-yyyynoom@gmail.com>
	<20250917160924.6c2a5f47@kernel.org>
	<DD16EAXYP4SM.1JYDYPDJ4I7VV@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 01:36:57 +0900 Yeounsu Moon wrote:
> > On Wed, 17 Sep 2025 03:33:05 +0900 Yeounsu Moon wrote:  
> >> @@ -965,14 +965,11 @@ receive_packet (struct net_device *dev)
> >>  			struct sk_buff *skb;
> >>  
> >>  			/* Small skbuffs for short packets */
> >> -			if (pkt_len > copy_thresh) {
> >> -				dma_unmap_single(&np->pdev->dev,
> >> -						 desc_to_dma(desc),
> >> -						 np->rx_buf_sz,
> >> -						 DMA_FROM_DEVICE);
> >> -				skb_put(skb = np->rx_skbuff[entry], pkt_len);
> >> -				np->rx_skbuff[entry] = NULL;
> >> -			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
> >> +			if (pkt_len <= copy_thresh) {
> >> +				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
> >> +				if (!skb)
> >> +					goto fallback_to_normal_path;  
> >
> > The goto looks pretty awkward.
> >
> > 	skb = NULL;
> > 	if (pkt_len <= copy_thresh)
> > 		skb = netdev_alloc_skb_ip_align(dev, pkt_len);
> > 	if (!skb) {
> > 		// existing non-copy path
> > 	} else {
> > 		// existing copybreak path
> > 	}  
> 
> I totally agree with your point. However, the two cases handle `skb` and
> `rx_skbuff` differently depending on the `copy_thresh` condition,
> regardless of whether `skb` is NULL or not.

I don't understand.

