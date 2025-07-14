Return-Path: <netdev+bounces-206553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559BDB03710
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 08:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28AB3AEE77
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 06:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85945221280;
	Mon, 14 Jul 2025 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="SonpvYYC"
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811D421858E;
	Mon, 14 Jul 2025 06:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474468; cv=none; b=MWOnXUla8NMvbdxd9hBKYg5CYl3BRgMiUoTsMPyn55hIhzq0zqS7xix4DcR3qzz9noZKNPXUqt6ac3j7udoZ0kHN50TnsdLUwhrjM4iir0aJyH3OEw4CpHOOTznhx7hnkery7NAWpqn6XdviBbGVAzusUU47MQdCMWsZ8m8W8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474468; c=relaxed/simple;
	bh=FokIb/jsQEmBa3MveOcLQeQ5FcS9JKxSSYV1cXqWoyI=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=U8VFd2GVH5Mir0S5tpJkhzJAbBM7PMS8hVm8eqcVVUU0gNCW///IAezRVSHZo6FJVbFEt4pxj4g0oJt+F0tTlEtQ9yJo2f+A67TShVZ9G+uH5zNbT1Ka/QFOhxBrlakULRXmKFCRpannrhomPqGl3SH8lmNSXWnJGSCEUgdOK7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=SonpvYYC; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=5304a106dc=ms@dev.tdt.de>)
	id 1ubCPo-008vkV-Br; Mon, 14 Jul 2025 08:11:52 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1ubCPn-003z0h-4E; Mon, 14 Jul 2025 08:11:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1752473510;
	bh=0+9k2CPi1wzcWs6e7GPr7hixdhS1n+Z8U0EKokBj2LU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SonpvYYC2v4hw3y55rz75vTgWjRVNDCVoag/JL2Pfgdk83IuTLgR6oDkbDcSfEQ8p
	 QCbV/Kx+krEYGvSF0l6yLyB7cV4h7gFH/SdiECkhpSwxspORDO5DJ58jRCQ8GGrRVS
	 Qe5Kl/ldjT0qLU3kKBIcqibpDHb4SsWmx+kxv9cFVaoXpnLRLsW7YcjSzAqFwTX/Mv
	 gTvK1bjU7USyv/a8fKNI0hHlb8zhHVdCoE1ERDhxvTRM6r5gf00QMu8y3hyhI9KiEI
	 J57OUy0bF52g8DRheDcZhVGwv+42EaPmj4prpxZ+B0iX5FBIOVEVOcJvIO8cytVtSL
	 971g8LZecMN6A==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 9859F240040;
	Mon, 14 Jul 2025 08:11:50 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 88C61240036;
	Mon, 14 Jul 2025 08:11:50 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id BCF7E214EB;
	Mon, 14 Jul 2025 08:11:49 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 14 Jul 2025 08:11:49 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: linux@treblig.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-x25@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/x25: Remove unused x25_terminate_link()
Organization: TDT AG
In-Reply-To: <20250712205759.278777-1-linux@treblig.org>
References: <20250712205759.278777-1-linux@treblig.org>
Message-ID: <6c677b5f49f57abdaaf499db719131f8@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1752473511-AE7FA327-B4D8B24F/0/0

On 2025-07-12 22:57, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> x25_terminate_link() has been unused since the last use was removed
> in 2020 by:
> commit 7eed751b3b2a ("net/x25: handle additional netdev events")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  include/net/x25.h |  1 -
>  net/x25/x25_dev.c | 22 ----------------------
>  2 files changed, 23 deletions(-)
> 
> diff --git a/include/net/x25.h b/include/net/x25.h
> index 5e833cfc864e..414f3fd99345 100644
> --- a/include/net/x25.h
> +++ b/include/net/x25.h
> @@ -203,7 +203,6 @@ void x25_send_frame(struct sk_buff *, struct 
> x25_neigh *);
>  int x25_lapb_receive_frame(struct sk_buff *, struct net_device *,
>  			   struct packet_type *, struct net_device *);
>  void x25_establish_link(struct x25_neigh *);
> -void x25_terminate_link(struct x25_neigh *);
> 
>  /* x25_facilities.c */
>  int x25_parse_facilities(struct sk_buff *, struct x25_facilities *,
> diff --git a/net/x25/x25_dev.c b/net/x25/x25_dev.c
> index 748d8630ab58..fb8ac1aa5826 100644
> --- a/net/x25/x25_dev.c
> +++ b/net/x25/x25_dev.c
> @@ -170,28 +170,6 @@ void x25_establish_link(struct x25_neigh *nb)
>  	dev_queue_xmit(skb);
>  }
> 
> -void x25_terminate_link(struct x25_neigh *nb)
> -{
> -	struct sk_buff *skb;
> -	unsigned char *ptr;
> -
> -	if (nb->dev->type != ARPHRD_X25)
> -		return;
> -
> -	skb = alloc_skb(1, GFP_ATOMIC);
> -	if (!skb) {
> -		pr_err("x25_dev: out of memory\n");
> -		return;
> -	}
> -
> -	ptr  = skb_put(skb, 1);
> -	*ptr = X25_IFACE_DISCONNECT;
> -
> -	skb->protocol = htons(ETH_P_X25);
> -	skb->dev      = nb->dev;
> -	dev_queue_xmit(skb);
> -}
> -
>  void x25_send_frame(struct sk_buff *skb, struct x25_neigh *nb)
>  {
>  	unsigned char *dptr;

Acked-by: Martin Schiller <ms@dev.tdt.de>

