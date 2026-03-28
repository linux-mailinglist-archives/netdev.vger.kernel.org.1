Return-Path: <netdev+bounces-272724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGHuFR9Vx2lTVgUAu9opvQ
	(envelope-from <netdev+bounces-272724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 05:12:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D8D34D3F9
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 05:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F4303021E58
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409D34DB4E;
	Sat, 28 Mar 2026 04:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue2LQzYb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10DF347537
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 04:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774671088; cv=none; b=sQVgLGrmISGuyUQ6n5TSBMidguzLTfRCz4a8MUH97zAZnL6GmzjnlrJHhWdDbFYVSBxpBW3W8SE43mas8GZL5FT4iKDsYdD+j+BukNGIqGxTeB7IEhvjHlAMlVrgQOFg1UuwJeSazhJ+c6GSJd+sxCEpwLTBVW8Al8KuYwYQjJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774671088; c=relaxed/simple;
	bh=cmbr4FCwCjngkOU6MuNJzZqttx+8aObH23hMMJBfdX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGpYd+ofpilC/P38F0x7KNB6RMxPOTMEPjqTSIDSoN8B+Va84aBPg6fLB2X6ZwgeTFruYJLwrc0g3725gsezO5cbfJfhEyyXnB70y9VvoTYxDrtPxf6x3pR0oIfZQ7+LG+laPOJmRwRjykHrNUf7Wl1hwyxQgTZ1tUh6ZF5TAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue2LQzYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15F1C4CEF7;
	Sat, 28 Mar 2026 04:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774671088;
	bh=cmbr4FCwCjngkOU6MuNJzZqttx+8aObH23hMMJBfdX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ue2LQzYbj/mSlaJqDNBVHLS3W5qkghp8C7Gb4MjT/f5WFqfTwRLSXRC/8ROtsvmVp
	 JJTDFHliYjWoDYgbAWDPVL67FpYvDwpJFlMBWY4XLa59xjx6g0zg4bm/yQMoV+07FP
	 eVwtIKF+l7iEF6WgDnbg21xDYdOW77ig7/VgyT+QOJpRsIfrYlzp+pshQY7FzBMaKo
	 bHOUOt3Z0X+eMXgdqvdjMkaPOBZo0tqxGXZq4KkOXoWNx0nkros2rlx3OeDkgKMi43
	 wV6hFu/THS0ZpnuwvwdXxupSq1yWkvpN7vJrpenWikIV97B3Tp+p1aElFypGN5qRj6
	 sx29tVdVAYhfA==
Date: Fri, 27 Mar 2026 21:11:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: justin.chen@broadcom.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 opendmb@gmail.com, nb@tipi-net.de
Subject: Re: [PATCH net 1/2] net: bcmgenet: fix leaking free_bds
Message-ID: <20260327211127.7e9317b3@kernel.org>
In-Reply-To: <20260326184529.1393438-2-justin.chen@brodcom.com>
References: <20260326184529.1393438-1-justin.chen@brodcom.com>
	<20260326184529.1393438-2-justin.chen@brodcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,google.com,davemloft.net,lunn.ch,broadcom.com,gmail.com,tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272724-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: B3D8D34D3F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 11:45:28 -0700 justin.chen@broadcom.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> While reclaiming the tx queue we fast forward the write pointer to
> drop any data in flight. These dropped frames are not added back
> to the pool of free bds. We also need to tell the netdev that we
> are dropping said data.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 482a31e7b72b..3e1fc3bb8297 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -1985,6 +1985,7 @@ static unsigned int bcmgenet_tx_reclaim(struct net_device *dev,
>  		drop = (ring->prod_index - ring->c_index) & DMA_C_INDEX_MASK;
>  		released += drop;
>  		ring->prod_index = ring->c_index & DMA_C_INDEX_MASK;
> +		ring->free_bds += drop;
>  		while (drop--) {
>  			cb_ptr = bcmgenet_put_txcb(priv, ring);
>  			skb = cb_ptr->skb;
> @@ -1996,6 +1997,7 @@ static unsigned int bcmgenet_tx_reclaim(struct net_device *dev,
>  		}
>  		if (skb)
>  			dev_consume_skb_any(skb);
> +		netdev_tx_reset_queue(netdev_get_tx_queue(dev, ring->index));
>  		bcmgenet_tdma_ring_writel(priv, ring->index,
>  					  ring->prod_index, TDMA_PROD_INDEX);
>  		wr_ptr = ring->write_ptr * WORDS_PER_BD(priv);

AI says you may be off by one here?

  Does this loop miss the oldest dropped descriptor and leak its SKB and
  DMA mapping?

  Since bcmgenet_get_txcb() increments write_ptr after a transmission,
  write_ptr always points to the next available empty slot.

  When this loops backwards drop times, the first iteration retrieves that
  empty descriptor (where cb->skb is NULL), and the loop will finish before
  reaching the oldest uncompleted descriptor at c_index.

  When write_ptr is rolled back to c_index, won't subsequent transmissions
  overwrite the descriptor at c_index and permanently leak the unmapped DMA
  buffer and SKB memory?

