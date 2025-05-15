Return-Path: <netdev+bounces-190758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1722AB8A10
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E9162FE1
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6171FF1B4;
	Thu, 15 May 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbQ6Mm/y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D013B7A3;
	Thu, 15 May 2025 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321128; cv=none; b=mpWOW1KrTgpdgKVCQE/uTtHbRViKkPFbXOIsgpdlx0fHQB35GCxb0KxPoQ7Dym3zZb6rZ90cjVMYELuwOFhA5vla2k86oePduWl6RQjMyVtfpso8AroU19iqiJkHwnHMTDDWDqMQcPdZLXNu2N9PcdpGW0U6k/7hRLGkEvJRyhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321128; c=relaxed/simple;
	bh=m1jfScZCo8k+5goQ6NMvir+lyNDlszbRbw3Ck1Hx5zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUzkW4GQQReagHm6moJVB2C8YBrDCZB+XHmlizY9kEEw5tEjkb1RJwb+os8v+poFQpRVJsfrvStC7E5Op48bvAZ0uIBz74Jpq+aBju5A0LOZ5wTke8lEeZkEL9N9AmTht/IeRVCbZK5omhEt5sLnLG71Qy2AEaNWfe9m6AXn5wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbQ6Mm/y; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a1fb17a9beso597468f8f.3;
        Thu, 15 May 2025 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747321125; x=1747925925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yRwIHNdNZHSHt6Sv0Ytj1R1VTPxHlVjg3ZwEgvmiCDs=;
        b=gbQ6Mm/y8D5d9Gio3cAad0yyjLjnBNY6YvbQF3Pcr712hke/IzxCxjC6AYG1kxT2SW
         dqzoedgkkmobiq4sE89RCZx7vOelB8caiCLBuxhTNPGly9VkhPQAlRve7z4+nQ6k3o/h
         54J+KpmwkSlq/xVIg/QTEj4+ZlAXP7AKqbHHl7o9QKbp9nFtAY0XT2dqIb3gQQPFBwMC
         HhSTs5R+8rQHqsMd5EOG/+hh/KogqjFnbEUaOLeg0h/bbCdhJIsll3BuEjmYnqkTzzu6
         RvPjPZYZ4W5t2qkqtyd0RAmmTxk4cLuO/2vCAWuSQNuQoT/ejus/FJve++yA//C7jwef
         7g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747321125; x=1747925925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRwIHNdNZHSHt6Sv0Ytj1R1VTPxHlVjg3ZwEgvmiCDs=;
        b=D5y+y3R/QwG10/PC8BSfAK8ST3yAmMC5Kth8hO/BXRvtxFZEwMUrd/dnTIMLTwceVh
         MviB7OoQWj9ioWtQ6IaqfWjcuwj/vd6fr6s66YYPzpW+OP+DYHORSRIVgQzayJ43o1eC
         5PYjXktMF+f7bJ7Z34wk4lZdZufFg6dViqGUYb/UtOQtRthwFGfJcxCPwA5y/7C3/W4R
         i0ppt+WvTSYhGyQnN5k6iQkJhdGNFqAPWskLT74po2DvV+Fhn0r+LxoYZRVz2nuC6sGo
         av4tz946MrgWRv47hT9p7wnCrP+Oif5U6k2l4Qp87jTkyatqSH/fwTp69klsW4gEEcPo
         IEJg==
X-Forwarded-Encrypted: i=1; AJvYcCUdivydE6MOdJdcjkrvAZGQu9zfzvlRd+zDwfl/PXoxb7Qvwl1g5IYhpkoxh0lwNrUyZ2p5+i7j@vger.kernel.org, AJvYcCX5CF+P1hIw2GaVYTE1SyAzpdin1KkRuVMN1EbaUJ82zzybUOTsgwHwThi8uJMnMeJRl6hmR9ZZBWm7m6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyviqX20XiG2Nok8NjeQaJetYUlM1QD87AaMUaM+drqBDeasJ5j
	32C9MxhTh9jcOSONH+KI4ySJN9d6PiTXNzqrZYpGMXvpsrldG2KhdC8+UzyIHPBCUrctf1ne/na
	iwFskD8sKqCaGZNbJEVy1Of0gmSSXMQM=
X-Gm-Gg: ASbGncsy4WUd/OhkW1t48BipF/4zQ+v3EjBUsKW0tVWuQ/k7HdW2dFWtrUNwdQe6FgP
	jLThJEcI2GtNvcaVgUBC6+8Tszvl5x06to6yfzWUs/kAcVaoA9YwdNpxq0BMGqBHTtm27nAEQSm
	N/EJQ1r+KerRNcu6x9KEuQPjvgtdH3IGV/PwxTNHUWTZlVOgzinS6LYtfvGzGjbRM=
X-Google-Smtp-Source: AGHT+IHs4E6pGZWrxMY84w1MnyLhh+j/JZlBjLB86phT8Zh9bL6wKxJXEzDNMG/VfavPc0nFxVKoTn3ltyM+qQJlp+I=
X-Received: by 2002:a05:6000:2288:b0:3a0:b9a9:2fd9 with SMTP id
 ffacd0b85a97d-3a35c84fc91mr41988f8f.51.1747321125166; Thu, 15 May 2025
 07:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513144107.1989-1-zakkemble@gmail.com> <20250513144107.1989-2-zakkemble@gmail.com>
 <b37ea0be-0f37-4a78-b6ce-fc49610c00cc@broadcom.com>
In-Reply-To: <b37ea0be-0f37-4a78-b6ce-fc49610c00cc@broadcom.com>
From: Zak Kemble <zakkemble@gmail.com>
Date: Thu, 15 May 2025 15:58:32 +0100
X-Gm-Features: AX0GCFtGV6Cxv68ATXT1sFH1jvc1ekiTxfyS7hzPq4u4DHxQXYYVxdEenQ9Cidw
Message-ID: <CAA+QEuRRanG=grXRM09U7YFYhxek=J3GY6otKXMvD0E_FFVmhg@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: bcmgenet: switch to use 64bit statistics
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Doug Berger <opendmb@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

v2 is here https://lore.kernel.org/all/20250515145142.1415-1-zakkemble@gmail.com/

Thanks!


On Wed, 14 May 2025 at 09:45, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
>
>
> On 5/13/2025 4:41 PM, Zak Kemble wrote:
> > Update the driver to use ndo_get_stats64, rtnl_link_stats64 and
> > u64_stats_t counters for statistics.
> >
> > Signed-off-by: Zak Kemble <zakkemble@gmail.com>
> > ---
>
> [snip]
>
> >
> > +
> > +
>
> This is unrelated to your changes.
>
> >   static void bcmgenet_get_ethtool_stats(struct net_device *dev,
> >                                      struct ethtool_stats *stats,
> >                                      u64 *data)
> >   {
> >       struct bcmgenet_priv *priv = netdev_priv(dev);
> > +     struct u64_stats_sync *syncp;
> > +     struct rtnl_link_stats64 stats64;
> > +     unsigned int start;
> >       int i;
> >
> >       if (netif_running(dev))
> >               bcmgenet_update_mib_counters(priv);
> >
> > -     dev->netdev_ops->ndo_get_stats(dev);
> > +     dev_get_stats(dev, &stats64);
> >
> >       for (i = 0; i < BCMGENET_STATS_LEN; i++) {
> >               const struct bcmgenet_stats *s;
> >               char *p;
> >
> >               s = &bcmgenet_gstrings_stats[i];
> > -             if (s->type == BCMGENET_STAT_NETDEV)
> > -                     p = (char *)&dev->stats;
> > +             if (s->type == BCMGENET_STAT_RTNL)
> > +                     p = (char *)&stats64;
> >               else
> >                       p = (char *)priv;
> >               p += s->stat_offset;
> > -             if (sizeof(unsigned long) != sizeof(u32) &&
> > +             if (s->type == BCMGENET_STAT_SOFT64) {
> > +                     syncp = (struct u64_stats_sync *)(p - s->stat_offset +
> > +                                                                                       s->syncp_offset);
>
> This is a bit difficult to read, but I understand why you would want to
> do something like this to avoid discerning the rx from the tx stats...
>
> > +                     do {
> > +                             start = u64_stats_fetch_begin(syncp);
> > +                             data[i] = u64_stats_read((u64_stats_t *)p);
> > +                     } while (u64_stats_fetch_retry(syncp, start));
> > +             } else if (sizeof(unsigned long) != sizeof(u32) &&
> >                   s->stat_sizeof == sizeof(unsigned long))
> >                       data[i] = *(unsigned long *)p;
>
> >               else
> > @@ -1857,6 +1881,7 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
> >                                         struct bcmgenet_tx_ring *ring)
> >   {
> >       struct bcmgenet_priv *priv = netdev_priv(dev);
> > +     struct bcmgenet_tx_stats64 *stats = &ring->stats64;
> >       unsigned int txbds_processed = 0;
> >       unsigned int bytes_compl = 0;
> >       unsigned int pkts_compl = 0;
> > @@ -1896,8 +1921,10 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
> >       ring->free_bds += txbds_processed;
> >       ring->c_index = c_index;
> >
> > -     ring->packets += pkts_compl;
> > -     ring->bytes += bytes_compl;
> > +     u64_stats_update_begin(&stats->syncp);
> > +     u64_stats_add(&stats->packets, pkts_compl);
> > +     u64_stats_add(&stats->bytes, bytes_compl);
> > +     u64_stats_update_end(&stats->syncp);
> >
> >       netdev_tx_completed_queue(netdev_get_tx_queue(dev, ring->index),
> >                                 pkts_compl, bytes_compl);
> > @@ -1983,9 +2010,11 @@ static void bcmgenet_tx_reclaim_all(struct net_device *dev)
> >    * the transmit checksum offsets in the descriptors
> >    */
> >   static struct sk_buff *bcmgenet_add_tsb(struct net_device *dev,
> > -                                     struct sk_buff *skb)
> > +                                     struct sk_buff *skb,
> > +                                     struct bcmgenet_tx_ring *ring)
> >   {
> >       struct bcmgenet_priv *priv = netdev_priv(dev);
> > +     struct bcmgenet_tx_stats64 *stats = &ring->stats64;
> >       struct status_64 *status = NULL;
> >       struct sk_buff *new_skb;
> >       u16 offset;
> > @@ -2001,7 +2030,9 @@ static struct sk_buff *bcmgenet_add_tsb(struct net_device *dev,
> >               if (!new_skb) {
> >                       dev_kfree_skb_any(skb);
> >                       priv->mib.tx_realloc_tsb_failed++;
> > -                     dev->stats.tx_dropped++;
> > +                     u64_stats_update_begin(&stats->syncp);
> > +                     u64_stats_inc(&stats->dropped);
> > +                     u64_stats_update_end(&stats->syncp);
> >                       return NULL;
> >               }
> >               dev_consume_skb_any(skb);
> > @@ -2089,7 +2120,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
> >       GENET_CB(skb)->bytes_sent = skb->len;
> >
> >       /* add the Transmit Status Block */
> > -     skb = bcmgenet_add_tsb(dev, skb);
> > +     skb = bcmgenet_add_tsb(dev, skb, ring);
> >       if (!skb) {
> >               ret = NETDEV_TX_OK;
> >               goto out;
> > @@ -2233,6 +2264,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
> >   {
> >       struct bcmgenet_priv *priv = ring->priv;
> >       struct net_device *dev = priv->dev;
> > +     struct bcmgenet_rx_stats64 *stats = &ring->stats64;
> >       struct enet_cb *cb;
> >       struct sk_buff *skb;
> >       u32 dma_length_status;
> > @@ -2253,7 +2285,9 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
> >                  DMA_P_INDEX_DISCARD_CNT_MASK;
> >       if (discards > ring->old_discards) {
> >               discards = discards - ring->old_discards;
> > -             ring->errors += discards;
> > +             u64_stats_update_begin(&stats->syncp);
> > +             u64_stats_add(&stats->errors, discards);
> > +             u64_stats_update_end(&stats->syncp);
> >               ring->old_discards += discards;
>
> Cannot you fold the update into a single block?
>
> >
> >               /* Clear HW register when we reach 75% of maximum 0xFFFF */
> > @@ -2279,7 +2313,9 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
> >               skb = bcmgenet_rx_refill(priv, cb);
> >
> >               if (unlikely(!skb)) {
> > -                     ring->dropped++;
> > +                     u64_stats_update_begin(&stats->syncp);
> > +                     u64_stats_inc(&stats->dropped);
> > +                     u64_stats_update_end(&stats->syncp);
> >                       goto next;
>
> Similar comment as above, this would be better moved to a single
> location, and this goes on below.
> --
> Florian
>

