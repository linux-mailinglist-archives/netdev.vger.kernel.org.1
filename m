Return-Path: <netdev+bounces-294090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB7mEjicHmpVCgAAu9opvQ
	(envelope-from <netdev+bounces-294090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:02:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE53562B041
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EAAC30BB806
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014C83C81BF;
	Tue,  2 Jun 2026 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA6ptgz2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53023C8C48
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390495; cv=none; b=UOe317xLxc5T85X6NmNycYa6Kabs+ePr94X6PCOqAUW7B1GkkUK+UZZe7q2Du0mfg4L2fhjX5KdS5gEDPwTW2etsth/9wZDTiUY9OwZnX17sEFzHi3F64ZOcC565IXiXbrurUYVaXH6gWhmDxLpNUKsQpXlTcRfeYGT4zwlSwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390495; c=relaxed/simple;
	bh=DLj7BE2ekL+bk1M0X6Y16mRyytL1h03u6lYj8UEV2II=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnYUSK2uWiOyVeXfA+7weX1g3FFRGG2t4DcfLgJbDlWHqSd2Yv2CFyYQv4DsOxT7AcPZOuVHTii2ovjIHkUnDSW9UkAZButm1KhPaeCnkii7iKQwR0MzoxeSy6IgXM9LciyqswjwPOVr7eodY4yUHKsGmykoUn/K/L5q1gZDuH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AA6ptgz2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490afc47455so5437075e9.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 01:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780390491; x=1780995291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+IHc3AVptUQmwL1qHHLr/+oupduZrd30cSPwYMmLI8=;
        b=AA6ptgz2c/a7eSh6Y/qrAPymGVO1KhzZQK6zw1U9nA0ph2lYdvCSzYZ9Yncmq8zGCq
         3NQnp5BFm3G8v5JD2js/QiyrWq9VosmM7uiS7vRluKla2ECndkehqYNKNlXFT7eMELiV
         Eoaq4zJD11eGAOYM5Yx7AoLzmQ4DDpPmcznYP/ltToD6Vd49M3fndTQxWXKbmLcQuMwP
         A9S++seSKZoG1XboA1U352PDoI47T+N0l8VK2gDxM5Tp9fN6PqQqfU8RbZwQIoe4NpV/
         mQOu3UFSYRb43znrBNE2JqQ4cAeIq4xmTGKTbfESCP7qWuL/FQNThGAKcX9H7lI0opJW
         PUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780390491; x=1780995291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R+IHc3AVptUQmwL1qHHLr/+oupduZrd30cSPwYMmLI8=;
        b=bzJGAlV7zdRZUXPqN+dI6yKQsGvrdBF5QSzQW2lzr8ReRsfGXaMJkOVwjdlOAV35fJ
         v9tAu8aLLH3DPD9d0XInvxpvISn0zplykdAn1nMHFVTkadKT6mQ5qDsJotg2xwSgtZun
         TehZ1dg7h0k/Xv6A44RfZxsRxwOp7d4evkE8y5fpRolCebPgqZ5MMBy7Pu9kYrufj1fS
         O6on34hW31SvwgH+8bzscAUmqqUrHt5lel1os32SZUftOh0IjUrf4zfFm0ghWGsbtSh7
         yH+wwkZCNIghdXuxZsVg7343A66PExWRvPAE3YtxBAQa6soPYwkwvDxw9Aa47Bjx1Eq5
         Y9bQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RkKHDG3ERXKcoXahIqs5oAyO5f95rMRRV08RylU7hdZOu2cEYuLdDVtogcOfc4qaVlq8wVmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyfgFU/+H/qZJdkKMSDR9G2hB03pPYya/SbTzpVn21FKHhtlX
	xy4DsXXBmOQlvDZDvRr3RoF1CBFUggwFjpSgWTTemu9+c9KCUJZeHVED
X-Gm-Gg: Acq92OGkUVDWUwPV8YrBeiqwIsCTeoP3IsHsRcXFV/72UJd0SfbBCsp8Bjz7ws/i5bX
	JVVG4BHwHlJI26cAeY+EtyvF59/8vCsQJe6YWb5CAhQpddaR9dqq6UboMgRdju/3CT7qC+oBp8U
	SyDblOnFlzueJK2tNSHE2BdEoA5xQpPGZOjwpD5k7GP7fq9gClECIKBUDY3/502lLMkZ/r9bP5K
	1ENNJanWw+f+YxihfBHTGiiJ0myUHbY8q3hv2A6XIJD4nHpdh1J1PTKbg0VGlPkWfaJJ29/5k46
	UNPzRZt3rphjUPKNa0H5b5jNP2jXCZLc7la/D82L6UJJ7g6L4shGhKE2Vt2WlgIOid/0TxdNXVG
	wmV7TNqnyj6xeDyzscZ7qR8J12DgtLZnw5Sm+QoTWGO1aZ3OumMbD/as+3PvLB5BTAFQp+QNcQg
	vN/WGqA68xInGdWGjJpWEHLz7XaFGzLCZaC1HPP5RhJY5f5/56URC4ILw8KnJ83rYDer/lZJU=
X-Received: by 2002:a05:600c:c492:b0:490:9d1b:f088 with SMTP id 5b1f17b1804b1-490a29e4383mr256152055e9.2.1780390490919;
        Tue, 02 Jun 2026 01:54:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e20bacsm50440695e9.6.2026.06.02.01.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 01:54:50 -0700 (PDT)
Date: Tue, 2 Jun 2026 09:54:49 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next v2] eth: bnxt: disable rx-copybreak by default
Message-ID: <20260602095449.5192535e@pumpkin>
In-Reply-To: <20260602003759.1545645-1-kuba@kernel.org>
References: <20260602003759.1545645-1-kuba@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CE53562B041
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294090-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[209.85.128.49:received,172.105.105.114:from,100.90.174.1:received,82.69.66.36:received];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Action: no action

On Mon,  1 Jun 2026 17:37:59 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> rx-copybreak requires an extra slab allocation. Since bnxt uses
> page pool frags and HDS by default, the rx-copybreak doesn't
> buy us anything. The extra pressure on slab causes overload
> on pre-sheaves kernels on modern AMD platforms.

Confused.
Isn't rx-copybreak also about limiting the amount of kernel memory
that gets queued on sockets for small messages?
(see skb->truesize)

There should also be the advantage that the memory the frame is read
into can be re-used for another receive frame without having to change
the iommu.

For systems with an iommu I'd guess that it is worth copying packets
that are even a few 100 bytes long.

Isn't allocating the new skb for the copy just a simple kmalloc().
That ought to be taking items of a per-cpu list and be cheap.
If there is serious pressure on sub-page kmalloc() you've got
bigger problems.

-- David

> 
> In synthetic testing on net-next this patch shows little difference
> but I think copybreak is "obvious waste" at this point.
> 
> Default rx-copybreak threshold to 0 / disabled.
> 
> The "copybreak" defines are really the size bounds for the Rx header
> buffer. Rename them.
> 
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - rename the defines instead of changing the DEFAULT to 0,
>    we only want the default setting to change, but the define
>    is also used as min rx buffer bound in the code
> v1: https://lore.kernel.org/20260529205553.999672-1-kuba@kernel.org
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 4 ++--
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 6 +++---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 61c847b36b9f..1920a161841e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -36,8 +36,8 @@
>  #include <linux/firmware/broadcom/tee_bnxt_fw.h>
>  #endif
>  
> -#define BNXT_DEFAULT_RX_COPYBREAK 256
> -#define BNXT_MAX_RX_COPYBREAK 1024
> +#define BNXT_MIN_RX_HDR_BUF	256
> +#define BNXT_MAX_RX_HDR_BUF	1024
>  
>  extern struct list_head bnxt_block_cb_list;
>  
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index d4f93e62f583..3587f39202d2 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4846,11 +4846,11 @@ static void bnxt_init_ring_params(struct bnxt *bp)
>  {
>  	unsigned int rx_size;
>  
> -	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
> +	bp->rx_copybreak = 0; /* rx-copybreak disabled by default */
>  	/* Try to fit 4 chunks into a 4k page */
>  	rx_size = SZ_1K -
>  		NET_SKB_PAD - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -	bp->dev->cfg->hds_thresh = max(BNXT_DEFAULT_RX_COPYBREAK, rx_size);
> +	bp->dev->cfg->hds_thresh = max(BNXT_MIN_RX_HDR_BUF, rx_size);
>  }
>  
>  /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
> @@ -4911,7 +4911,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
>  				  ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) -
>  				  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  		} else {
> -			rx_size = max3(BNXT_DEFAULT_RX_COPYBREAK,
> +			rx_size = max3(BNXT_MIN_RX_HDR_BUF,
>  				       bp->rx_copybreak,
>  				       bp->dev->cfg_pending->hds_thresh);
>  			rx_size = SKB_DATA_ALIGN(rx_size + NET_IP_ALIGN);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 9b14134d62d2..edafa79f636c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -4594,7 +4594,7 @@ static int bnxt_set_tunable(struct net_device *dev,
>  	switch (tuna->id) {
>  	case ETHTOOL_RX_COPYBREAK:
>  		rx_copybreak = *(u32 *)data;
> -		if (rx_copybreak > BNXT_MAX_RX_COPYBREAK)
> +		if (rx_copybreak > BNXT_MAX_RX_HDR_BUF)
>  			return -ERANGE;
>  		if (rx_copybreak != bp->rx_copybreak) {
>  			if (netif_running(dev))
> @@ -5172,7 +5172,7 @@ static int bnxt_run_loopback(struct bnxt *bp)
>  	cpr = &rxr->bnapi->cp_ring;
>  	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
>  		cpr = rxr->rx_cpr;
> -	pkt_size = min(bp->dev->mtu + ETH_HLEN, max(BNXT_DEFAULT_RX_COPYBREAK,
> +	pkt_size = min(bp->dev->mtu + ETH_HLEN, max(BNXT_MIN_RX_HDR_BUF,
>  						    bp->rx_copybreak));
>  	skb = netdev_alloc_skb(bp->dev, pkt_size);
>  	if (!skb)


