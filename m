Return-Path: <netdev+bounces-247958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A938AD00F8E
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 05:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8054430049EA
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 04:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D61296BD6;
	Thu,  8 Jan 2026 04:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+SjRlxU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSnix7w5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C80291864
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 04:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847078; cv=none; b=YL5EtSGhUEmQvTJPsgZJIWN6ebupPWMxbTFiBtxC1/UnisvSPjOFI7FOnKvQrfD1vkvoxs5u10FE0DAOtA+c5zlB8X4XYMeC69ZQlCHwOgOzTplhuFiBifzQ/EAx8QPD7KvV2SfCo3eyfB5UKmjXV1viwpVtNrRQXu2zOpVJmW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847078; c=relaxed/simple;
	bh=EHUBmEarbkqeknUga6s29EH7ucSXyuJH72yRaZDXOAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fi08slK19LGH3geHsR+WsU6tVFiU/E863OZqGJCTO4+DCZARJaRNf8uZpmuLBEP7RVsrGuembZLr8ijJUE/0iOLqhlpinayXexWdmLzp3isU8ZVBx+7kgSDOO+ceobe7SR3djh2cardVonsqZgAlNGj2A5DLxyg+ljIymTrn0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+SjRlxU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSnix7w5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767847076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGJJ3mghZGQyoRGajBObKXNhhk9ab2WcIcydiR3jcw4=;
	b=K+SjRlxUsdJlomJ6iEKBvtU4xv0Q16aISZTGhe06JO/OpgPqA+OPhVV6PrJIzyZ5fl372I
	7fhik7u1Qkld9U6SuxE0Ex9ckqdZ71lV17Vy9N9FPoqUclRqrgRn8qTlfC+h9WZUTevHQq
	RwRCnTrZM9l/lj1LuXzaPbuyrkf3xYg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-SvPLMlNUOTqY32vc2sjz6w-1; Wed, 07 Jan 2026 23:37:52 -0500
X-MC-Unique: SvPLMlNUOTqY32vc2sjz6w-1
X-Mimecast-MFC-AGG-ID: SvPLMlNUOTqY32vc2sjz6w_1767847072
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34ab459c051so6514186a91.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 20:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767847072; x=1768451872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGJJ3mghZGQyoRGajBObKXNhhk9ab2WcIcydiR3jcw4=;
        b=KSnix7w5wJ4AfIiytZ5NoETEwEz5NCEsDeuELbBgf1W5w+aG8uy21LIDTqjcK7C5Ct
         oe/KE82Zga7PS69f3zPfJy5nOvbqXMG7lGp8SdeVmOahemVCJPqXdXVJrB2omSSlWiCC
         Mw4vV+jzB0eoItq0fPpbg8eh/GRS/eR1j/av8i1tnIhibj0dyVk57B8zZeKbd103Hwk4
         kimmJCVUB8r0lEJNVVChVP2RlBb/MD94aLV9qKk+uw6JeDKhCGqqicks1RdchWu6qUxW
         aKIIatSJH6I2FhPx4DSmRW5V30TTxkrGz/WFmLpIqM8/ma5pFA+OySa61Dx1zwEwIvGa
         AebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767847072; x=1768451872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nGJJ3mghZGQyoRGajBObKXNhhk9ab2WcIcydiR3jcw4=;
        b=aSLb3ikR7Qcu34xHGIyM0hf7FNERj0pYI4p3U6aWecF4l54W9R5LMmujuBfL4so5/1
         DbfZ1TkTY4mTPoIrk7dZ8iFDD8ZTavHZUBCV+J6hHo7kjVDqSIyNzS8YetM9k/DrKhp+
         mWlZ3Z66tvRnnvpze4QysgFnDZe0c3cO1oqphIZw4Atrux4ZTHTVJZrHbw3YAM9tE44d
         YsPm07+ur/eGQunkgzAzy6GevwYnjYap/ImPdYCzxDzqRmQktECiaY2ZWJpoE7dTzBx/
         v/feI4Z0+Tq5kJ68cHnSRhMq6/tMnnuPdzpR5D9YS2KtpDmWjCluxT63zUFxoseai9if
         Ac/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoVOeMiYIzbvoP/Qb+fQCKzYxbPrn7s3iJEh00Pf2K0WXOlkoVmzq1/1HXvOsX/L1QHjDweK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNj3U/yrZkJ8wXRc6vhDIjSvkCX3M65VXKZbwBhPreTYTn7yT7
	lL6BNkEkVBt+hv6DhKfxnUjWBTVV7THo71B7xTvni6T00ZoBPVs2FFgnvIQfk5I6707Dc5Raogw
	i5s4RXeqm09b+HQ7oe+/uRlRfE/RbJfOJhroMnwfD4BEcHHLV5YvSPEiRa7y5y8c7smUssgJeHw
	1kKh/r9l+pakEAP20kXaaaO+tlaqXIPSAE
X-Gm-Gg: AY/fxX5yFFmahJXd50cJDVCSyj2teqvGAnC/fNmpZv/nL7qRFPMqD58OEthrFFUjWtB
	Q+2+ImAjYyVHhyjSueGm+v2chDge8pnyaIGbu4NqLNPGE5j0CpYiECnlp1LQOEzPf2LPnZbtw8h
	MQBe6IRtk6o3s/wn/ruBrVNoTJmPJWz8k0rEzNnA5derKCn/IL5CiKGLmv/dY37mM=
X-Received: by 2002:a17:90b:560b:b0:349:7fc6:18 with SMTP id 98e67ed59e1d1-34f68b9a22fmr4745640a91.13.1767847071694;
        Wed, 07 Jan 2026 20:37:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECns7jouA7f2VNHsoSXSn1GwNS9wwLb0mzRo21rU5B9H5vGzwBZRLYUrbrNqFBS4uDGJcoRqYkbR+MEJG9hv8=
X-Received: by 2002:a17:90b:560b:b0:349:7fc6:18 with SMTP id
 98e67ed59e1d1-34f68b9a22fmr4745605a91.13.1767847071303; Wed, 07 Jan 2026
 20:37:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de> <20260107210448.37851-10-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260107210448.37851-10-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jan 2026 12:37:39 +0800
X-Gm-Features: AQt7F2qCw4tSinw_uRQv6jndxzlecHSCxyFfKRavPy7gsUnUcdmHs2F5zxEB4h4
Message-ID: <CACGkMEuQikCsHn9cdhVxxHbjKAyW288SPNxAyXQ7FWNxd7Qenw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 9/9] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when qdisc is present
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> becomes full. Once an entry is successfully produced and the ptr_ring
> reaches capacity, the netdev queue is stopped instead of dropping
> subsequent packets.
>
> If producing an entry fails anyways, the tun_net_xmit returns
> NETDEV_TX_BUSY, again avoiding a drop. Such failures are expected because
> LLTX is enabled and the transmit path operates without the usual locking.
> As a result, concurrent calls to tun_net_xmit() are not prevented.
>
> The existing __{tun,tap}_ring_consume functions free space in the
> ptr_ring and wake the netdev queue. Races between this wakeup and the
> queue-stop logic could leave the queue stopped indefinitely. To prevent
> this, a memory barrier is enforced (as discussed in a similar
> implementation in [1]), followed by a recheck that wakes the queue if
> space is already available.
>
> If no qdisc is present, the previous tail-drop behavior is preserved.
>
> +-------------------------+-----------+---------------+----------------+
> | pktgen benchmarks to    | Stock     | Patched with  | Patched with   |
> | Debian VM, i5 6300HQ,   |           | noqueue qdisc | fq_codel qdisc |
> | 10M packets             |           |               |                |
> +-----------+-------------+-----------+---------------+----------------+
> | TAP       | Transmitted | 196 Kpps  | 195 Kpps      | 185 Kpps       |
> |           +-------------+-----------+---------------+----------------+
> |           | Lost        | 1618 Kpps | 1556 Kpps     | 0              |
> +-----------+-------------+-----------+---------------+----------------+
> | TAP       | Transmitted | 577 Kpps  | 582 Kpps      | 578 Kpps       |
> |  +        +-------------+-----------+---------------+----------------+
> | vhost-net | Lost        | 1170 Kpps | 1109 Kpps     | 0              |
> +-----------+-------------+-----------+---------------+----------------+
>
> [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.org/
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 71b6981d07d7..74d7fd09e9ba 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1008,6 +1008,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb=
, struct net_device *dev)
>         struct netdev_queue *queue;
>         struct tun_file *tfile;
>         int len =3D skb->len;
> +       bool qdisc_present;
> +       int ret;
>
>         rcu_read_lock();
>         tfile =3D rcu_dereference(tun->tfiles[txq]);
> @@ -1060,13 +1062,38 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *s=
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
> +               netif_tx_stop_queue(queue);
> +               /* Avoid races with queue wake-up in
> +                * __{tun,tap}_ring_consume by waking if space is
> +                * available in a re-check.
> +                * The barrier makes sure that the stop is visible before
> +                * we re-check.
> +                */
> +               smp_mb__after_atomic();
> +               if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> +                       netif_tx_wake_queue(queue);

I'm not sure I will get here, but I think those should be moved to the
following if(ret) check. If __ptr_ring_produce() succeed, there's no
need to bother with those queue stop/wake logic?

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


