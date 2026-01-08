Return-Path: <netdev+bounces-247955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D2BD00E43
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 04:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12452303804D
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 03:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F692367A2;
	Thu,  8 Jan 2026 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHFl4hVp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="alvwLLpP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34B218AAB
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843506; cv=none; b=r5sN367TJOa63Igvi0zbMqus0k6DYxMRpc2Sr+lWct/t8bwGTQ0FAofegDtUniDsNLWIi1d44YUZVsBGu10+xo8hm6UwdVkf1w1zbQIZr6PBxvH9mc3tCZLzgKVixYtehy8hheqxZDkznbkNGUsnnFg1wqubiKGkCHmI77RKCo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843506; c=relaxed/simple;
	bh=08ZpgLtfSYqi4+i/U9XHqQzEVglXimSDYNawkficNd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e79ljny0WN8z7lOp68mwEy+AT9lVe0+CY1eJDbbbrufEh1M49+tFNeV2uwlLQKeoc3Dbd/jr06wxEjuNldpAIwO7DUZ964nbreNkyhxl1MbY0Tck6i1aV/WNqvjuDBgIbmdq5qwQ9ZAFx+4R0nAttpS0tz6nYEeNln30PYWYGP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHFl4hVp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=alvwLLpP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767843503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v58SV4sfp1KPqLP1VgpxZ6XDQOK5uoDM/ahl82LBf0w=;
	b=fHFl4hVpIn+4EDsh/c+9YiwPOnbRjZG16zCKis+gQ5srcnkUun+DhNKqofoRxYZEOrTvVt
	gLNW72TlaURxyUSGEcXmkGYvYxbcgmmWN+LBZzX41ZMXLJU6KpTXBCg4sKWgm8sjoX2NWj
	6FPT/gtOvbS0izEZfGSr8MWMn1yi5WI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ExDI6WN6MuCJMwMn-3XDGw-1; Wed, 07 Jan 2026 22:38:22 -0500
X-MC-Unique: ExDI6WN6MuCJMwMn-3XDGw-1
X-Mimecast-MFC-AGG-ID: ExDI6WN6MuCJMwMn-3XDGw_1767843501
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso3258808a12.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 19:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767843496; x=1768448296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v58SV4sfp1KPqLP1VgpxZ6XDQOK5uoDM/ahl82LBf0w=;
        b=alvwLLpPcpjziBsb4+U8q9Vw1Km2zMugspWA77mNR8e/ZG1wNe2Ve7C0a7wUx1HP6a
         LjmIsAlH4eQDs7VeDBJgCfkXRqz4MQIMEmxWQFG9Sk8Yb2VnFk0ti+bA/+j3NTAzsJUG
         LXt1yXW/SWZNDZHUQ6aGNskDbcBxlrQeV+htxd1N8/nqRrZYM+bfzOxxiwZiD73ApZF2
         1BUjdlZ4yn7UMsaKA8E24G5LzjoulBtunqK6JaBQ/DcormkGqkpXhnrd1N6MAvGFOGjR
         ln3aLNVIuz5y84alVLpMbgPa3z//yXaXzeLd5Dj7XOwqHEr0OXtPS7bRawYh6Sln5qie
         8KfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767843496; x=1768448296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v58SV4sfp1KPqLP1VgpxZ6XDQOK5uoDM/ahl82LBf0w=;
        b=gBHVlVZhTnh68xZMwBBQ8vcJN6g9yVD5hoUiBlUJBQj7zuzNy+lJv6kUaxrxq9pNOv
         j95BQX3uaKZInqEaHHFqFrKdhaPzav9WbJ6du2VQD5xuunMUMBw8nPiJcPR9Ftvv7xK7
         I29uLEHni49CgEOih67CklHKTSO+/FAiRHAFuG87vStsRuyaVvqUCFZEap/oz99DCnBt
         CSLQ3Dx6FzC9uTSFEJuENkP2bt+2KLOK9I8dOlonCN7r9FUA/7LskIgrmcDu6yXpFsx8
         RJemtqPHiBxe/MKSVW1idEN7Qyd0v9l98SwcUDBaCsg/ia7h4CTAAoemqlT0CQHn/Op6
         5ozg==
X-Forwarded-Encrypted: i=1; AJvYcCXRt/9Y1D7MOEWkvvSSHMgM7wZFyodNfU3Y3Cc/GzS6Ye4adwaJX0t2LRrvV9G4VnnWECZIHXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxszaxSRUtFETW+QUUcgBL6hqzjt6mveZwMmhwgaWIpvagXUa8q
	E0WgeY+/xjqw7BXzqYj2CNgk+7cX5sgyo7axN9fdceyocal7AWHyTJaBtmEOUc7PYapM6NkBJsD
	UEEWvCn38GNad0rnI/mQ1h6DQzuZIWD+MOT52T/Y0HjnXtfCfAxmy8nUbTM1ETg/wnQzJbiTGPe
	U3RRKTrQ8NXmzAxocIZAR2mLFOGVWdqOcS
X-Gm-Gg: AY/fxX4XFo2KNM+YdeLBG01wGxDIqwRSSR0rb0OOvewhUsHexznIAuz/4S2MOcYTiA1
	vAnNJ7T914Qmc0gnEw6gp6S2GnMT/nTc/YcEn2ou++0R2zpHi35fgdFcpFGPDlbV316DQ4CVY2U
	M0Kyy9H/cHMFcz9NMszG57rhL6avpw/b1dMTrrCu02DjtUWLPUq9Z0EgjRFDiRNyE=
X-Received: by 2002:a05:6a21:116:b0:35e:11ff:45c0 with SMTP id adf61e73a8af0-3898fa226d1mr4400193637.55.1767843496438;
        Wed, 07 Jan 2026 19:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrINQzJlx78fjSA9ruvmWJu0w8vOPujfDqFXxbDJsjPnMqr1tJkD5ak8/7tV8xdLw9u0H5oRpbFtVWYj1SfYw=
X-Received: by 2002:a05:6a21:116:b0:35e:11ff:45c0 with SMTP id
 adf61e73a8af0-3898fa226d1mr4400161637.55.1767843496025; Wed, 07 Jan 2026
 19:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de> <20260107210448.37851-4-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260107210448.37851-4-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jan 2026 11:38:02 +0800
X-Gm-Features: AQt7F2pYgxF0Jvdv3uPx8yLVba1YerHhPNETBcotNKOEiOav4ZMJyA2wFtENvzw
Message-ID: <CACGkMEuSiEcyaeFeZd0=RgNpviJgNvUDq_ctjeMLT5jZTgRkwQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper with
 netdev queue wakeup
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
> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr_ring_consume()
> and wake the corresponding netdev subqueue when consuming an entry frees
> space in the underlying ptr_ring.
>
> Stopping of the netdev queue when the ptr_ring is full will be introduced
> in an upcoming commit.
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 1197f245e873..2442cf7ac385 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct tap_queue *q,
>         return ret ? ret : total;
>  }
>
> +static void *tap_ring_consume(struct tap_queue *q)
> +{
> +       struct ptr_ring *ring =3D &q->ring;
> +       struct net_device *dev;
> +       void *ptr;
> +
> +       spin_lock(&ring->consumer_lock);
> +
> +       ptr =3D __ptr_ring_consume(ring);
> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring, 1))) {
> +               rcu_read_lock();
> +               dev =3D rcu_dereference(q->tap)->dev;
> +               netif_wake_subqueue(dev, q->queue_index);
> +               rcu_read_unlock();
> +       }
> +
> +       spin_unlock(&ring->consumer_lock);
> +
> +       return ptr;
> +}
> +
>  static ssize_t tap_do_read(struct tap_queue *q,
>                            struct iov_iter *to,
>                            int noblock, struct sk_buff *skb)
> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_queue *q,
>                                         TASK_INTERRUPTIBLE);
>
>                 /* Read frames from the queue */
> -               skb =3D ptr_ring_consume(&q->ring);
> +               skb =3D tap_ring_consume(q);
>                 if (skb)
>                         break;
>                 if (noblock) {
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 8192740357a0..7148f9a844a4 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct tun_struct *tu=
n,
>         return total;
>  }
>
> +static void *tun_ring_consume(struct tun_file *tfile)
> +{
> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> +       struct net_device *dev;
> +       void *ptr;
> +
> +       spin_lock(&ring->consumer_lock);
> +
> +       ptr =3D __ptr_ring_consume(ring);
> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring, 1))) {

I guess it's the "bug" I mentioned in the previous patch that leads to
the check of __ptr_ring_consume_created_space() here. If it's true,
another call to tweak the current API.

> +               rcu_read_lock();
> +               dev =3D rcu_dereference(tfile->tun)->dev;
> +               netif_wake_subqueue(dev, tfile->queue_index);

This would cause the producer TX_SOFTIRQ to run on the same cpu which
I'm not sure is what we want.

> +               rcu_read_unlock();
> +       }

Btw, this function duplicates a lot of logic of tap_ring_consume() we
should consider to merge the logic.

> +
> +       spin_unlock(&ring->consumer_lock);
> +
> +       return ptr;
> +}
> +
>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err=
)
>  {
>         DECLARE_WAITQUEUE(wait, current);
>         void *ptr =3D NULL;
>         int error =3D 0;
>
> -       ptr =3D ptr_ring_consume(&tfile->tx_ring);
> +       ptr =3D tun_ring_consume(tfile);

I'm not sure having a separate patch like this may help. For example,
it will introduce performance regression.

>         if (ptr)
>                 goto out;
>         if (noblock) {
> @@ -2131,7 +2152,7 @@ static void *tun_ring_recv(struct tun_file *tfile, =
int noblock, int *err)
>
>         while (1) {
>                 set_current_state(TASK_INTERRUPTIBLE);
> -               ptr =3D ptr_ring_consume(&tfile->tx_ring);
> +               ptr =3D tun_ring_consume(tfile);
>                 if (ptr)
>                         break;
>                 if (signal_pending(current)) {
> --
> 2.43.0
>

Thanks


