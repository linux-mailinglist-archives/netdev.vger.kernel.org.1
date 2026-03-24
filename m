Return-Path: <netdev+bounces-270841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E8RJ9ruwWkgYAQAu9opvQ
	(envelope-from <netdev+bounces-270841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:54:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 078A9300BFD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B2083114D22
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8B637AA6C;
	Tue, 24 Mar 2026 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPsSJDai";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n9UiJwaw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367537B3FD
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316883; cv=pass; b=etEeHiWRBaEw2xoJ6YZQ9jgnifv209+t4rz2C/3f1ZM3v787IdDqpPCBW9UctHrolnRcOR+gpylmgls++lmTbUO1Yv0mAl6CLF9026VAE/S8+kxKFRlIFmmPAhJnXBEgCfS7agXsaxjyQqACKOilDWxaIOpJ4TkwKzG5TzWeE2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316883; c=relaxed/simple;
	bh=7QxO8eHrVmNb4hinylW2JuP41va0K5ItDexCfV6jw5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iaf5gAB7xbWngziXNQF8N0PuxkYkdsSOjfV8HJEUyLUgDRXIteUFZEhf5bXys4S0ukpFrPXTKPL13UnZ87r17hS8V9y4ow4x1asLzlLiDl1Jr8aX+Z2Q3P8uOQVlbFqxP/575jxKzqfREMPXiPegLYvFub12D76gYD1bgsEFl1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPsSJDai; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n9UiJwaw; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774316881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCRJDsZtO6H+FDHmSMe8GvNuh3MZqp6KwaA8GF6tbWo=;
	b=NPsSJDaiKvrufBZ/PnB2KXpvmWixzCsg9eyOtofLyDiJRuU8rvOopTm2E61gwrSTnvxtwt
	hLL8ri7A0LnRSDED5nKf+Fi7zzwMWCwQvlpLryrF1KbaVhgyMs/ZypGgLzorpp/0tLk+6k
	uIYuStnVZsVAKR7DYiD1G+0CtzkVSEM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-rcIbJQxdOfmOCa2OhF8hZA-1; Mon, 23 Mar 2026 21:47:57 -0400
X-MC-Unique: rcIbJQxdOfmOCa2OhF8hZA-1
X-Mimecast-MFC-AGG-ID: rcIbJQxdOfmOCa2OhF8hZA_1774316877
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35b977ffbcdso813040a91.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316876; cv=none;
        d=google.com; s=arc-20240605;
        b=VMcVfVibAnTVWYZFYKdtPz6cSGE3s5Kps2DSE3ZQd0H2iLO7c8qlLSan5xiQDMcqhV
         0l5mxO/seITcrqKTzb0gEDQ5rL8iuPqhIFy8hr/m3OlXF6RRVf2LH5zVI3m5ME8J+Dd1
         80MJoI+bEXUcUtifpZqdIVGrFvM84yZmwWHWjL1BEPcDAL9+6pubzZLYkOVjxh4TJpI2
         pnFY01k3wLXb44KvceZlqKVTymzQYALLEaFQGtFYND/+YlSQ5ODa4dm7Et0PThk3/XCl
         BGYKNXHueYNzIyzcWG1a1A9T09DjXbHOWNv/D609KOXx4PCaWUkEOV4/8lMpxUmj5sLd
         WIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yCRJDsZtO6H+FDHmSMe8GvNuh3MZqp6KwaA8GF6tbWo=;
        fh=BrYD/vjunf6ztiXI6Vcwe3WoyCmYVs22o61KVYu4Rd8=;
        b=il/ENV+V5bQ+I6wGbb32GhLmmC5tXKKnL/9PqdfOtEyrhOHiKfQoIsyn9/L8Rr3bJa
         NK/ohnYtIzzAipk6APBjBWEFyyXzsDX/uU/KyRmFtJUaCdN5ZqETSSVaVaBakWXd9sCd
         VqVCz7aUm+BHx0yyoCOVTOXaW/BouFVaG+cPcCpSPsmOMfdFPsuMS51rfdsBftHTXO3I
         m1vfOHx/yfiW6x2vee6WOD+xhw0b1mRtyKTXD7zjqI+GdUxblBzVSaYyn0dXVWmNyGkO
         z2lRzgKxIBx4pviFzFwKVJzXKIMsFdge/uNhUnHYAHqCg0V9Lx1VkjHbK4Wv5M/iRt/4
         SQSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774316876; x=1774921676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCRJDsZtO6H+FDHmSMe8GvNuh3MZqp6KwaA8GF6tbWo=;
        b=n9UiJwawp9alEMNphphRPEDTFP0LmLg6HUUnPm9+1+rfVCak7EnydsEeb3St01c4ZY
         DLgVn49d22yqbpn1fFNl+k6DDzy1ULdlnZSslfRonn9XTBfUZyc5oXpBSZHKhTHWoUFu
         pNFuK5c+/F7tnHVU/+BsCA/uaL1+vnIAPdk73GouoNJdkgSgbgB5mRErU2rNXJxar+jD
         QPw4Gu5U/Odf8xOkQwid8/H7mEQsdCZYKDtiFsiAayzYO3zOe5H0UReA+vjhjMZwE6vW
         KPllukNMkbkMf9Hzx3ymN8Npd5pVVsbsLvY6/fW0jpiXOxxHblNQFbYdnbYdupsHSqtf
         H2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316876; x=1774921676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yCRJDsZtO6H+FDHmSMe8GvNuh3MZqp6KwaA8GF6tbWo=;
        b=FGre+r6u7igolx1Gw+fSRAE0L2SaSjl2deL67vRVkQT66XECHQ30VckaMGm7Jlp2ah
         liwqkIwJhqDpbC0KX/A8vCD5LvHGD7Q/efP066sGzYB5D9XvlvTUUvocLc44WGFGao19
         ViDHaxrpvWAkYjdGW6+nu3msXpiFyn1dkGAVxiiHCeNZGW+ECAvBr4pK9VIFGs4wI17w
         Jh+fXI2XiLWEoLijg3BNFIOdY0pvGpmPvhkMdw0gD1Wo8rXLq/mLKGxCPVVtvLO9rnfK
         Hv/VJ+tZuk7pkgFplR337qWF9pAGkOXNVRH9bmIym8LLwpTczVdlcZGf6nIW/DY6OrIy
         +HBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkg2IdKR4+hN9x+87XVTpoOfIKEFcypwm/8o0oHpxru55yRtS0R9wVImwvXR+lOc2Zz1mLolI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV2PP9dcq/2p8hPALG1phROJkO2+Zx+L0uJc8092mVR+YgqpSr
	gSdIMhKKZnAxKlfGPhelCDMbiub+1VmIPQb2sJFMzCaUX9fMOXdXMTKRxBxHEdlvD6gHjPDxBC8
	P9W2130uDuWKHpVOpk6AxzlLYk3V5R5EYa8kBEIHA3etSFeC4/kW//57W2coHgGPk2C2fJFQxLQ
	JrfYQbEUE5lNLRXfi4bfci2FCywGyH351I
X-Gm-Gg: ATEYQzwbZUYsJ2vkXMTt5qh7x2cYxF/sxfS1+C+GX+ZakIaM6PP1yvwQ//7a/eV9y1U
	wkMtAD473y+Z9t7sKJP3uoKEr/xAdH7mEuJGAm+oLMv6mBDFCcglLRC5lsyW5P2RxugzthnPkVQ
	slE9ebC9lPoyF7E0RO2K3qN/wHN7/RQs3bn/uxOenlr0469nC6L5c6UH7WxAa9clxU0754hMTBv
	nlhvvo=
X-Received: by 2002:a17:90b:4c52:b0:35b:e529:2d60 with SMTP id 98e67ed59e1d1-35be5292d67mr7009881a91.8.1774316876464;
        Mon, 23 Mar 2026 18:47:56 -0700 (PDT)
X-Received: by 2002:a17:90b:4c52:b0:35b:e529:2d60 with SMTP id
 98e67ed59e1d1-35be5292d67mr7009867a91.8.1774316875980; Mon, 23 Mar 2026
 18:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de> <20260312130639.138988-5-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260312130639.138988-5-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Mar 2026 09:47:43 +0800
X-Gm-Features: AaiRm53PVQkrGcklsZUJS-7XPhfayXnRAumXm5C_-oefvGMMXn3FtKJ6Q_kdnQ0
Message-ID: <CACGkMEtN9XgYPGHQg4TEWEsa_UcMbcnzO=VaTFT=0Tn4BayMDw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270841-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 078A9300BFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 9:07=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> becomes full. Once an entry is successfully produced and the ptr_ring
> reaches capacity, the netdev queue is stopped instead of dropping
> subsequent packets.
>
> If producing an entry fails anyways due to a race, tun_net_xmit returns
> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
> LLTX is enabled and the transmit path operates without the usual locking.
>
> The existing __tun_wake_queue() function wakes the netdev queue. Races
> between this wakeup and the queue-stop logic could leave the queue
> stopped indefinitely. To prevent this, a memory barrier is enforced
> (as discussed in a similar implementation in [1]), followed by a recheck
> that wakes the queue if space is already available.
>
> If no qdisc is present, the previous tail-drop behavior is preserved.

I wonder if we need a dedicated TUN flag to enable this. With this new
flag, we can even prevent TUN from using noqueue (not sure if it's
possible or not).

>
> Benchmarks:
> The benchmarks show a slight regression in raw transmission performance,
> though no packets are lost anymore.
>
> The previously introduced threshold to only wake after the queue stopped
> and half of the ring was consumed showed to be a descent choice:
> Waking the queue whenever a consume made space in the ring strongly
> degrades performance for tap, while waking only when the ring is empty
> is too late and also hurts throughput for tap & tap+vhost-net.
> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> 1/2 was chosen for the sake of simplicity for both tun/tap and
> tun/tap+vhost-net.
>
> Test setup:
> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> Average over 20 runs @ 100,000,000 packets. SRSO and spectre v2
> mitigations disabled.
>
> Note for tap+vhost-net:
> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
>
> +--------------------------+--------------+----------------+----------+
> | 1 thread                 | Stock        | Patched with   | diff     |
> | sending                  |              | fq_codel qdisc |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Transmitted | 1.151 Mpps   | 1.139 Mpps     | -1.1%    |
> |            +-------------+--------------+----------------+----------+
> |            | Lost/s      | 3.606 Mpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Transmitted | 3.948 Mpps   | 3.738 Mpps     | -5.3%    |
> |            +-------------+--------------+----------------+----------+
> | +vhost-net | Lost/s      | 496.5 Kpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
>
> +--------------------------+--------------+----------------+----------+
> | 2 threads                | Stock        | Patched with   | diff     |
> | sending                  |              | fq_codel qdisc |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Transmitted | 1.133 Mpps   | 1.109 Mpps     | -2.1%    |
> |            +-------------+--------------+----------------+----------+
> |            | Lost/s      | 8.269 Mpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Transmitted | 3.820 Mpps   | 3.513 Mpps     | -8.0%    |
> |            +-------------+--------------+----------------+----------+
> | +vhost-net | Lost/s      | 4.961 Mpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
>
> [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.org/
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index b86582cc6cb6..9b7daec69acd 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb=
, struct net_device *dev)
>         struct netdev_queue *queue;
>         struct tun_file *tfile;
>         int len =3D skb->len;
> +       bool qdisc_present;
> +       int ret;
>
>         rcu_read_lock();
>         tfile =3D rcu_dereference(tun->tfiles[txq]);
> @@ -1063,13 +1065,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *s=
kb, struct net_device *dev)
>
>         nf_reset_ct(skb);
>
> -       if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> +       queue =3D netdev_get_tx_queue(dev, txq);
> +       qdisc_present =3D !qdisc_txq_has_no_queue(queue);
> +
> +       spin_lock(&tfile->tx_ring.producer_lock);
> +       ret =3D __ptr_ring_produce(&tfile->tx_ring, skb);
> +       if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {

So, it's possible that the administrator is switching between noqueue
and another qdisc. So ptr_ring_produce() can fail here, do we need to
check that or not?

> +               netif_tx_stop_queue(queue);
> +               /* Avoid races with queue wake-ups in __tun_wake_queue by
> +                * waking if space is available in a re-check.
> +                * The barrier makes sure that the stop is visible before
> +                * we re-check.
> +                */
> +               smp_mb__after_atomic();

Let's document which barrier is paired with this.

> +               if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> +                       netif_tx_wake_queue(queue);
> +       }
> +       spin_unlock(&tfile->tx_ring.producer_lock);
> +
> +       if (ret) {
> +               /* If a qdisc is attached to our virtual device,
> +                * returning NETDEV_TX_BUSY is allowed.
> +                */
> +               if (qdisc_present) {
> +                       rcu_read_unlock();
> +                       return NETDEV_TX_BUSY;
> +               }
>                 drop_reason =3D SKB_DROP_REASON_FULL_RING;
>                 goto drop;
>         }
>
>         /* dev->lltx requires to do our own update of trans_start */
> -       queue =3D netdev_get_tx_queue(dev, txq);
>         txq_trans_cond_update(queue);
>
>         /* Notify and wake up reader process */
> --
> 2.43.0
>

Thanks


