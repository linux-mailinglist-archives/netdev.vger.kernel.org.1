Return-Path: <netdev+bounces-116700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D052F94B63A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880331F21BA7
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37108145B21;
	Thu,  8 Aug 2024 05:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQZpZ19z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501014F9EA
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094652; cv=none; b=J+B0oRS9Ysy/2GaZuP07RJnGJXe5DStr/b30AhIbdxtiXvXpxY6oTkFlaEa7eJ4HV+KV3+tGmuqhjh5YCOm/UQ/ED0aoEzko+q5WX009mFrBwhjoLpzq6Dj/pyGvQb/mP7PydEUxta4fCPa4CDHqvz94CLfi7PFMxCI5467PiQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094652; c=relaxed/simple;
	bh=iAAFSdBbW3gyvts12CR9n+czDvSbUBQLaIszXbkaVAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aozBH255JphrNto+UutPK0QEOu9i0bRMelTUhKbpcaUgSA0MXsoMSLZyP97eoKGBR5Z5DOIbylZgultp9sxa6kF5nEtzq+SkazBsTAfsWL/6no7OIhnfFxoW2IAhJ9+4njU8uaed1OLq2x66sJ0XKwz49nLEFMnN1chbBnTbIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQZpZ19z; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so704793e87.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 22:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723094648; x=1723699448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C12iZwSge7otyZfEgKE+Bmbrs1Mfe38hW/ndlSie0+Q=;
        b=cQZpZ19zPo4bBEd4GET/W+vU76vfaW5EHlWCQNfNOtjxGhBV5fKPXurPOLSA6QO95W
         pAYVADsxJA7egeyb6cwBC+pB2UZ+4gRw6PUBAEq+qQyQhB2pTtyx2sLKQP0xqZl39BVN
         +sms/t79m3SWo/QHg6PozsfcNkA94j0SLtmZKWtrCfKInZzjTFNRoOpsVzUFLvdMBPZK
         WGMHSIgaIsQnsuxTGb4z2XvJVuh7AsoZgjCHQ+gjmZgb73LQR3iWAlk0yBAcbACxpdSj
         ggGrPkskg5zMGqLevQr3sOcf2GQ1XHt0irbMq87o+FyfgI9bMumvI7APHdemwJhbMu9z
         /UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723094648; x=1723699448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C12iZwSge7otyZfEgKE+Bmbrs1Mfe38hW/ndlSie0+Q=;
        b=Lbn6n0h2YdYboZGN3yUp9HOr0GNp7MLlGxzDQl8+6m901q+zBhg234tjO9WBmk2VOE
         uVMFzn/1O9mUm6tQTHTE+sRs1jk0mYVVPPQBz0zxFo5463zQ+hzyy9qL9qrsDE7hQcmc
         8HZemt0XP8eczrN/LrxxLa2ZNIsrJbtfKUBIVxNUXXID0BbJN3fwDPc1SPw7DOCyBOho
         /+36kt3IAZYGWL2xLlntMTaoUPc90PCe73leJTbu3zkfRuI8Q7ra6JZATuFULlkljGQ2
         kcZe6XIFu04WkiXR6egkAN1xqr689iMK1w/m16R4/n0ZQ4OqvBJMb7W++rvHJl0zgMYc
         1wKQ==
X-Gm-Message-State: AOJu0YwMQtaeFK2oGiPu2rrahi7MGTLvViaZD8iA59t77PcdlyPU3f9Z
	MTVJXKfVkdz1NrEJH/zbwDiGZvkrOJUOkOaUVawvahWGrw6ruRnEYVK2FNKsmR9TPaHlNfF5bJ1
	1u7E9C4fwlBy8Y3a6Ec4pA5eJpO2iYoIrE2U=
X-Google-Smtp-Source: AGHT+IGxUj1ttcR2Om8MQOnK9QVMwue/iJ8EzPhIgIxMzMQe4iC85OArGncfSBMC9Qj7s5Fn/651Wo5qRR85cphn728=
X-Received: by 2002:a05:6512:e98:b0:52d:6663:5cbe with SMTP id
 2adb3069b0e04-530e5811269mr459853e87.12.1723094648039; Wed, 07 Aug 2024
 22:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALttK1TYZURJo8AKtGQFcKKMvzssy3mF=iG9rODqvEiPw_qqpg@mail.gmail.com>
In-Reply-To: <CALttK1TYZURJo8AKtGQFcKKMvzssy3mF=iG9rODqvEiPw_qqpg@mail.gmail.com>
From: Duan Jiong <djduanjiong@gmail.com>
Date: Thu, 8 Aug 2024 13:23:56 +0800
Message-ID: <CALttK1QuYdki3pcd_kVe=feb-XKTSfgxyZCA18DrTBmYN3v9=Q@mail.gmail.com>
Subject: Re: [PATCH] veth: Drop MTU check when forwarding packets
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There's a problem with the patch formatting, so ignore it and send the
v2 version later.

Duan Jiong <djduanjiong@gmail.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=888=E6=97=
=A5=E5=91=A8=E5=9B=9B 12:32=E5=86=99=E9=81=93=EF=BC=9A
>
> From dcf061830aba15b57819600b5db782981bab973a Mon Sep 17 00:00:00 2001
> From: Duan Jiong <djduanjiong@gmail.com>
> Date: Thu, 8 Aug 2024 12:23:01 +0800
> Subject: [PATCH] veth: Drop MTU check when forwarding packets
>
> When the mtu of the veth card is not the same at both ends, there is
> no need to check the mtu when forwarding packets, and it should be a
> permissible behavior to allow receiving packets with larger mtu than
> your own.
>
> Signed-off-by: Duan Jiong <djduanjiong@gmail.com>
> ---
>  drivers/net/veth.c        | 2 +-
>  include/linux/netdevice.h | 1 +
>  net/core/dev.c            | 6 ++++++
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 426e68a95067..f505fe2a55c1 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -317,7 +317,7 @@ static int veth_xdp_rx(struct veth_rq *rq, struct
> sk_buff *skb)
>  static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
>                             struct veth_rq *rq, bool xdp)
>  {
> -       return __dev_forward_skb(dev, skb) ?: xdp ?
> +       return __dev_forward_skb_nomtu(dev, skb) ?: xdp ?
>                 veth_xdp_rx(rq, skb) :
>                 __netif_rx(skb);
>  }
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d20c6c99eb88..8cee9b40e50e 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3943,6 +3943,7 @@ int bpf_xdp_link_attach(const union bpf_attr
> *attr, struct bpf_prog *prog);
>  u8 dev_xdp_prog_count(struct net_device *dev);
>  u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
>
> +int __dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb)=
;
>  int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
>  int dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
>  int dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index e1bb6d7856d9..acd740f78b1c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2190,6 +2190,12 @@ static int __dev_forward_skb2(struct net_device
> *dev, struct sk_buff *skb,
>         return ret;
>  }
>
> +int __dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb)
> +{
> +       return __dev_forward_skb2(dev, skb, false);
> +}
> +EXPORT_SYMBOL_GPL(__dev_forward_skb_nomtu);
> +
>  int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb)
>  {
>         return __dev_forward_skb2(dev, skb, true);
> --
> 2.38.1

