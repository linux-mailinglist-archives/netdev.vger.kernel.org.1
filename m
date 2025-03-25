Return-Path: <netdev+bounces-177520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5443A706C4
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7663A92F9
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D697E25E81B;
	Tue, 25 Mar 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="08dYNj65"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ACE1922FA
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919885; cv=none; b=hPLELCAHCpQ3QHhnGIj58mTMvr9QNrFo5NXokImn1xoSXIBxmwxG5BG+oOk2Vzg+ZP0jWwo6pAlf20N5y+6O20ZbwLUxixbc5BCKTtQ0bnGGYAkxnEAFryjWW9iO94BGaYzbmfEuftg4h5qObI1BVzKWOVBFljatwiSO/5VzISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919885; c=relaxed/simple;
	bh=aABXwU5R0ILq7uxgpbObKg27b4KoIj9H58o5NOF4ORI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDfL32bIs3pp39GMJkYrooV5OHbL0SDdsQN0cBouxSqY7SgI00+GtSC+E0lk6ifTFjFIwr2ZtVmx0F8wg779vWNr92CFf4WrwHXI3i2PH3MxCm6B0lFA9ebkgu3KXuK2UkkICK+Q3zWksI63Rlj65NvxI6jmQWjF0oAjEKFGSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=08dYNj65; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2242ac37caeso209345ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742919882; x=1743524682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9PaJ8TFOD4jbo+ONuB2YqXVV4qevZ+8lQ6iqerNolQ=;
        b=08dYNj65imgL7Y9yVFy0e6vmQJCu/w3itXzZMzyBYQ4fho6hPPwac6Ur0WNklvBNLH
         OovSgmdxX3ZutQUWr969VZgWgxzG9hpkw7q0yKZ2QWqB00JZIDW1eo+6qU3fc/pkiCqn
         CmpRBOzfw0EGqRDrgYeOmaAKpezNMy0WbFv++7ON1L3TJDKJ7HE2ROC4LN7dbGDEUEyW
         ibFUvUJ2Jj7VAgA0yN7pvO+198MpDl2HMgYyKBpsT3EJ+e6LJ0mBBFjf0C3QpICi6ADF
         pj4QN7+Ia6dRomEz0/aXT0Ql+YKKZFBIkecNSRDPdkO3UjRobWM7NDLU+Hhsmn/+3N9U
         8BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742919882; x=1743524682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9PaJ8TFOD4jbo+ONuB2YqXVV4qevZ+8lQ6iqerNolQ=;
        b=R/uTWi3VSCxnj9YbrHC3GXUXZjQLcSxbgcCnIS07T0aUMhA82zVItxHdFHzDuNfsZq
         CGh2/hjbzt0T7Loo7udMhYP5Hhu3hzQU3T5kd657DBTFSgNKcMa5+fk9bS0HDttdhAWh
         YapbW34g5F7ebWHJl7palmdpei6qCvdxo1tbjMZjckaN1S9uqFkKDau6eGrPDr7yMm12
         ZQpumoj+Q4KDMQ4cqCRBdGdBoeDlyHIUeE687FroCYkcPd63Sq33c9z2ApYlw4W4NFeY
         aD8Ej2EEkPgy71MWjUg172OxvMLPrfmqBXEZIH9jhscChtZ93q7oZZIjsBKKJD1q/C9d
         CQzw==
X-Gm-Message-State: AOJu0YzuXQF8sS3Qg0vp0uNZ/Cdc0p0c001t/he1t9kuOo5JYS2CBxr2
	pwu6UppDZxKj3V5xXVHjMrktnJsb8xt2XeSndkbrKVN1u2I4XXEucLOG1sjp3ZihdqYa0/XFPS1
	9DlVWzjkuIIHNPpbCNY9iwWzg4y4FSscvhb8d
X-Gm-Gg: ASbGncucyY5W874fF9HYqToTxcjxad1kf0/k/RWJFMEESCKy3/fYqJ5064hGiY3c8Ec
	Q/ysenhXJeU14LvlRzyvHDRTU0sv0DFnUm8m40/HvEgo4CjhuOxgy9La3LdffZRVG3oihNouITr
	1DknOqz5FkicJl501gTPpnNicB7aGbWdXErNxkbNPSYjvrl4ms2DLtzA==
X-Google-Smtp-Source: AGHT+IGp3F6dI4GsKKxNZwECD4hVfKZkyjmSjaSkkB5nxDq6v9EUh1g9I3wDE3mV3MoSgyiEtKlfWC3ea+RECCfhxbk=
X-Received: by 2002:a17:903:190:b0:215:7ced:9d67 with SMTP id
 d9443c01a7336-2279831db41mr7591495ad.24.1742919881891; Tue, 25 Mar 2025
 09:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325044358.2675384-1-skhawaja@google.com>
In-Reply-To: <20250325044358.2675384-1-skhawaja@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 25 Mar 2025 09:24:30 -0700
X-Gm-Features: AQ5f1JqHqYdO4UrTg0kneUBBDM21SWRB_yym2Dq69fh4DvLR8--UpNememre3z4
Message-ID: <CAAywjhSEjaSgt7fCoiqJiMufGOi=oxa164_vTfk+3P43H60qwQ@mail.gmail.com>
Subject: Re: [PATCH net-next] xsk: Bring back busy polling support in XDP_COPY
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 9:43=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> Commit 5ef44b3cb43b ("xsk: Bring back busy polling support") fixed the
> busy polling support in xsk for XDP_ZEROCOPY after it was broken in
> commit 86e25f40aa1e ("net: napi: Add napi_config"). The busy polling
> support with XDP_COPY remained broken since the napi_id setup in
> xsk_rcv_check was removed.
>
> Bring back the setup of napi_id for XDP_COPY so socket level SO_BUSYPOLL
> can be used to poll the underlying napi.
>
> Tested using AF_XDP support in virtio-net by running the xsk_rr AF_XDP
> benchmarking tool shared here:
> https://lore.kernel.org/all/20250320163523.3501305-1-skhawaja@google.com/=
T/
>
> Enabled socket busy polling using following commands in qemu,
>
> ```
> sudo ethtool -L eth0 combined 1
> sudo ethtool -G eth0 rx 1024
> echo 400 | sudo tee /proc/sys/net/core/busy_read
> echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> ```
>
> Fixes: 5ef44b3cb43b ("xsk: Bring back busy polling support")
> Fixes: 86e25f40aa1e ("net: napi: Add napi_config")
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  net/xdp/xsk.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index e5d104ce7b82..de8bf97b2cb9 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -310,6 +310,18 @@ static bool xsk_is_bound(struct xdp_sock *xs)
>         return false;
>  }
>
> +static void __xsk_mark_napi_id_once(struct sock *sk, struct net_device *=
dev, u32 qid)
> +{
> +       struct netdev_rx_queue *rxq;
> +
> +       if (qid >=3D dev->real_num_rx_queues)
> +               return;
> +
> +       rxq =3D __netif_get_rx_queue(dev, qid);
> +       if (rxq->napi)
> +               __sk_mark_napi_id_once(sk, rxq->napi->napi_id);
> +}
> +
>  static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 =
len)
>  {
>         if (!xsk_is_bound(xs))
> @@ -323,6 +335,7 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct =
xdp_buff *xdp, u32 len)
>                 return -ENOSPC;
>         }
>
> +       __xsk_mark_napi_id_once(&xs->sk, xs->dev, xs->queue_id);
>         return 0;
>  }
>
> @@ -1300,13 +1313,8 @@ static int xsk_bind(struct socket *sock, struct so=
ckaddr *addr, int addr_len)
>         xs->queue_id =3D qid;
>         xp_add_xsk(xs->pool, xs);
>
> -       if (xs->zc && qid < dev->real_num_rx_queues) {
> -               struct netdev_rx_queue *rxq;
> -
> -               rxq =3D __netif_get_rx_queue(dev, qid);
> -               if (rxq->napi)
> -                       __sk_mark_napi_id_once(sk, rxq->napi->napi_id);
> -       }
> +       if (xs->zc)
> +               __xsk_mark_napi_id_once(sk, dev, qid);
>
>  out_unlock:
>         if (err) {
> --
> 2.49.0.395.g12beb8f557-goog
>

The original commit 5ef44b3cb43b ("xsk: Bring back busy polling
support") has landed in 6.13 so I will revise this and resend it to
the net. Thanks

