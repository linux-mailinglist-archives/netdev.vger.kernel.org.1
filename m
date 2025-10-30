Return-Path: <netdev+bounces-234255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E31C1E27C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C70F189540B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FB72DC359;
	Thu, 30 Oct 2025 02:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+mKzZzq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08732A3FD
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 02:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792171; cv=none; b=uvC0aauw4J0jbJZSIRM0TCw9PfcVV9PhFUj1HqebV1vp/t5+qw7zWHbI4lJ5dhsJNbMVLUM/i00npN7LeiqS87OkIasDmIxQ4iSkVEsQEndX6kGeUAt6rFPtPNQSdoNS36CLCnGj1Gqkl3qUF48r9nE4IzuScjMDmvEpwEnmev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792171; c=relaxed/simple;
	bh=eEnpiMSXYQvSVbkRm+5dPeWzUqqgY5BA2tW5hs88yxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noIev4tpOeLVAQ5G5xW8RmQLziVy4c5Izva0EnYE7LIPeSymrTJb6i4BB1FfRgvXw8YrgyLyBvNmuftTgiRR/0DCifqIuEqMKg9ATeCaNT1QATRLuod8dnXNmk5keEIwFtptM2/hkra5GTxgRfzG4LQO3+VIGQ+kCq5Psxl8zZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+mKzZzq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761792167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/ZCYcZbkclIBTLFnAz2fA6NECmLLYytFhAcPGYaB5Y=;
	b=X+mKzZzqqssblBVZkppnLdb1S51GNZnEwpkvSXpGoQV/gqfHZGUwLpf0PvtdveHECgs0eO
	XidYLiI/cs/R7/l6OV6j56w64/wt9k7VSnnmDnnsvMwBxGR0D46hVv5MPSnfl3bzxgyEC2
	E5yvqCuZtdAGIY9wih5uJY5koU1vhmQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-9ywcAlhYN9-Ky1AWabbRLw-1; Wed, 29 Oct 2025 22:42:44 -0400
X-MC-Unique: 9ywcAlhYN9-Ky1AWabbRLw-1
X-Mimecast-MFC-AGG-ID: 9ywcAlhYN9-Ky1AWabbRLw_1761792162
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34029cbe2f5so1374345a91.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761792162; x=1762396962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/ZCYcZbkclIBTLFnAz2fA6NECmLLYytFhAcPGYaB5Y=;
        b=rJMZUyBrw0BJMrAn8aHPR96rMitEJgBgiIyeaNx8mq+BH5YnHz+lU7Wzo26abAu5OK
         Uo/UgDIDYBbNyGzmbvKU2rl8Q6MuQIZH/txr8n9FzrjdpMabfDAB/b+EbI5gotJ/1kAH
         NSzzSPekry3Op9Ze575g4kMfFBwwfq/A8cOI3mWm/DtFiqZKRxmlWNRg5GBqTdQmQAdL
         a9HTcwwGugbN1V//YaXTrhqg6KuspBmS9pBtTgAOrGjeqFa71Fzg7a/31VEIZUzkYXnv
         nCVq8XGgP7l7awjpXx9gaQal49SPW1jZHj6PEMEQedlNw4ge6qHT/jhjpRwv/GcKYdsq
         ZIqA==
X-Gm-Message-State: AOJu0YzYjbI3oxLxhnV/TGE9mdRqT/FF+cmMpUTVdeQn6YWuZfCiqgt5
	R8VJwH8RzntlNI7+oHx+QWSq0FapVCAr228O3Jt0BomrPiGmgqHQ06Ji9HWnrYSqqPnleZndlum
	fjmzHuen70NAM/dF2DhHimLG7PyPFBHUKczdjum0DIozJa/S0IOynJ+Bd6tjO6qX5ctjG4EWB//
	52xKtB9gnrhEpecJwyKqVxcz5oL04S0lVc
X-Gm-Gg: ASbGncsZh5l5lTZGNfQvOCtzCKJfJt2iIT4mxxBuNLB65ErmSY91LFSYdg+BJNw4tuM
	zdVsze+MCqSjwRR+E5ovrm8BAgRqXxkWNIOMRnHTbRLC6NAFohWs8lipgT7HaGZzTaMlvk+4JTH
	ltR66d8f5tPvqrCviCqwNhNgBRiohn/38yeKLiU/OPpIWEZU1u51IKoiiG
X-Received: by 2002:a17:90b:2802:b0:33f:ebc2:634 with SMTP id 98e67ed59e1d1-3404c3f4a5cmr1771784a91.9.1761792162284;
        Wed, 29 Oct 2025 19:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIVn1Bb5rNjXC5IPex9+DZAuDNurvVlJkJYxl4qjxLsMlWBCjHB2c4xxBH7QS96+rjUVkYNMjDamTWV5i87o4=
X-Received: by 2002:a17:90b:2802:b0:33f:ebc2:634 with SMTP id
 98e67ed59e1d1-3404c3f4a5cmr1771757a91.9.1761792161884; Wed, 29 Oct 2025
 19:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com> <20251029030913.20423-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20251029030913.20423-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Oct 2025 10:42:28 +0800
X-Gm-Features: AWmQ_bny5IxrU5zz8cJv4O8XuvV3My3M8eqi2dffdnZElWpOCXh_fsT9qM8wFG4
Message-ID: <CACGkMEszWAc_552TmyqH1grZLDK7ZO_dJ7mr1JD+YK=BphFJZQ@mail.gmail.com>
Subject: Re: [PATCH net v4 2/4] virtio-net: Ensure hdr_len is not set unless
 the header is forwarded to the device.
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, Willem de Bruijn <willemb@google.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:09=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Although `virtio_net_hdr_from_skb` is used in several places outside of
> `virtio-net.c`, the `hdr_len` field is only utilized by the device
> according to the specification. Therefore, we do not need to set
> `hdr_len` unless the header is actually passed to the device.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

I wonder if this will cause any issue consider hdr_len is just a hint.

E.g device needs to survive from hdr_len =3D 0.

> ---
>  include/linux/virtio_net.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4d1780848d0e..710ae0d2d336 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -218,9 +218,14 @@ static inline int virtio_net_hdr_from_skb(const stru=
ct sk_buff *skb,
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
>
> -               /* This is a hint as to how much should be linear. */
> -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> -                                                skb_headlen(skb));
> +               /* In certain code paths (such as the af_packet.c receive=
 path),
> +                * this function may be called without a transport header=
.
> +                * In this case, we do not need to set the hdr_len.
> +                */
> +               if (skb_transport_header_was_set(skb))
> +                       hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> +                                                        skb_headlen(skb)=
);
> +
>                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
>                                                   sinfo->gso_size);
>                 if (sinfo->gso_type & SKB_GSO_TCPV4)
> --
> 2.32.0.3.g01195cf9f
>

Thanks


