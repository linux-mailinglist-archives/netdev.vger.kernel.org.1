Return-Path: <netdev+bounces-251398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA8AD3C30E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E05634C6F9A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6303B95E1;
	Tue, 20 Jan 2026 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SgaExgCt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8708A36C5A2
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899536; cv=pass; b=ql4OFwXDq1nuZw1y0/tTiOPj5kolVJ7aDgJOeK8XNMegeRg8cahjXRwMIME9GHTKgbiBlpWkhL4pUMDAiE6UeobPKS5+0eIDBeYx1vkLIe4aR2kChH8zruAljFv6RYsLELGmwcjtPY2r2kkx2SYXfMsmgj4/c0Ygb5LebU5HDzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899536; c=relaxed/simple;
	bh=h165TuRJW9FjE57mMdfwxufQ/20l+c36z+6txXFw0Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0rDA/IEPX34+1eVXim2j/OmxvQJpC5eR2wPMWWjoO+NAqf1/3kxGUSUjBlHWbiGkYvgqcor64lB3ruMukzSIof8SQCNI2BDkbpPyqCCtvlIefh7ey8yWLVtNTuN/4U4exh/2Ak4y7dwzNrezhJyyg4HinRxbWnwLICERr9k9Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SgaExgCt; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5029901389dso32704551cf.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 00:58:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768899533; cv=none;
        d=google.com; s=arc-20240605;
        b=XviIFrW1TPlD0D0WOVTAU8VIw+WKkOre4fZSWhSA8On9HLV3gA6T3RFALdbnl8S9+b
         jQT9NxE0fSoAasBLrdCSc4tJT2fCh5MYX3SR1tPgRL3BTaSug89NQgBgfO72gtfkas7a
         AQy9siq9jFRlhiOdXyVDPoA0komIibhGXepYONbQGvHvg+c+XDBE8YxyyKDGiAmGlkUX
         1ddPEn45KuJmMBXzXq1lfIzw3f/P2z76+z6qtMOSrzEHi469f/QXg9D7zMLoXP/83b2l
         v4uTKyYnJ3OHqabXfFytp1b93LqfF6vLvfJiuo+tNIiP4TjKuckJzrtGsAbPQFCNnv02
         zgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l+agG2OZwmk/+ua1s4s74T98J3xHS11obEy2hTP/NnE=;
        fh=IPAvFu7bmBd59IBE9ZPym+fJHZnrULi85wCGeenxvHI=;
        b=eaObzYJng2ErJG3SKZXBFUOvojwoQnhU+kq1wYLMKQKp4AyN9XeKShIadwTRnqBpor
         iqe9TmaQa19FT9xR5J1gvFdwGI/EklrAGx99kbO6wv/uIysLYP1C2jQXvaVKPdNfHzWB
         i3NLtySTeF/4cQIyTekimrgtVC7SrxMV1shaMt0qWIv59KrzSHNRTa5xYkVIrfkphgjU
         1LDlJ9+0esKyKt87xg7lwrGXr1IPe+WE+b7NNL16sqx9UUOmWSw0CLm/Z7ndEL7xihxb
         jNqZsdwMLKDkQLm0f9o48BAVld48inpkL0MrQXBtdeIvjD3ZGe+itHpI5qgxIyAGoIiO
         xp2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768899533; x=1769504333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+agG2OZwmk/+ua1s4s74T98J3xHS11obEy2hTP/NnE=;
        b=SgaExgCt+bgToS9pHPtaUPYCe4+VWG66AKaRQHS2i8O0mU2Om0wzGNqH1oMT8qpJ8o
         wv3n0Ip4jAdtKefIa721L2J6bOgo42wZJlCoHNknQHin4pCTcL6ZEP13w4FxGCb/YeAc
         b2R819NYYGwibuUeZSI2AyzrsLmckUGSK7p6XIMatya3ZANua+LnUgs6vJEAv5IHwEvh
         m2hltJBBzphBnpfztWpIu48GTfg07kkZifCTtdvAcjGerCP+bk4aJE17Eeyi0ZQfDLRR
         k6dq0dXEypjDJPr7kFsW0HRkHiZ76KkjaO8iwsvnyUVii82js6EUg0wwL+iX/OBaZjtx
         r9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768899533; x=1769504333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l+agG2OZwmk/+ua1s4s74T98J3xHS11obEy2hTP/NnE=;
        b=D2vf4TbSF+rGNRsoM43cxwK81YgaHAJxbSos95abu6AtSg1lwb+16UI4sQMFfowt4L
         rQkI7Tfjkphz40dHH1SIidVcvVzSizb5t54SRX5o4xFki+ore6XU7eF5s9EepMD1x/Wz
         ETCU91eiIbqalV/t+WNQXJulLSAlboE4gHkyRNelcli7nWhhNd8j0WQhI/MG9CImrRSU
         8+Sw4WzozoNVEnwvJB1x3X2PtpTIkonOP519G+tf98xKy8ds1C9u1Q0aESHjAb4osivH
         Kxb4W7Zg21b61K5YasP4OMzA2YuS2BVvxsch3aD3qK9kpoDOI5i2DAaE6Sz2E0ra46Fs
         Zehw==
X-Gm-Message-State: AOJu0YzIv4WAgP2T0zTKJmfDv3I2zlrZO4kRB0oJJtAzcd2lR7RKm6vu
	/Aib5sjolccHTzEsXmoJTPbtSaqBEy7MgbnhqKmM5VBdyXSksiP4peqb+fbBKByDWEzmNRugo85
	qgeQpik/XuioK/We9YTjOYy5M3Ejea1uIk6yV4x71W7Rcs+lU2QH0HRN4+6Y=
X-Gm-Gg: AY/fxX7RtyUoYiaZvNgObzUNC5LFoqre0l5bL8r/rbyhxaDPT1lGseYEvolNgyb8xvl
	QpHJWMWhHfhhGR1zAC355VDu5d0uJfJvbtC95a4UCg4Ku6zYcumjVKFJOqOxmZDl4CDxvSadZNH
	eAry+0+VD2Kvnwgg5gM77U+hihVXhBl+BP/Lg9D6fabUxBxDgAHEK8S9HSopXOyQlhayhXnC7dI
	kobzIp3t4fqW2KPnBwqgnQN9+7UFDiIiwB5Db5SzpfzCZgTYN4KKD3Zi73FLtR+MC+i9ww=
X-Received: by 2002:ac8:5f82:0:b0:502:9e4c:266b with SMTP id
 d75a77b69052e-502d8560e2dmr10841571cf.42.1768899532882; Tue, 20 Jan 2026
 00:58:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768820066.git.pabeni@redhat.com> <ec64bb86298c31608eee9558842da25c47669f9c.1768820066.git.pabeni@redhat.com>
In-Reply-To: <ec64bb86298c31608eee9558842da25c47669f9c.1768820066.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 09:58:41 +0100
X-Gm-Features: AZwV_QgNfvS4_jxtO5G6uMaor-6jBeCWF-VU-bdvUtQVmKAFWu1Q4WoObk1cRJg
Message-ID: <CANn89iL1sJMe-j9n6--gdRwwkjpAD0TdDrS43N5g3=9HWUCOtQ@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 01/10] net: introduce mangleid_features
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, sdf@fomichev.me, 
	petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 4:10=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Some/most devices implementing gso_partial need to disable the GSO partia=
l
> features when the IP ID can't be mangled; to that extend each of them
> implements something alike the following[1]:
>
>         if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
>                 features &=3D ~NETIF_F_TSO;
>
> in the ndo_features_check() op, which leads to a bit of duplicate code.
>
> Later patch in the series will implement GSO partial support for virtual
> devices, and the current status quo will require more duplicate code and
> a new indirect call in the TX path for them.
>
> Introduce the mangleid_features mask, allowing the core to disable NIC
> features based on/requiring MANGLEID, without any further intervention
> from the driver.
>
> The same functionality could be alternatively implemented adding a single
> boolean flag to the struct net_device, but would require an additional
> checks in ndo_features_check().
>
> Also note that [1] is incorrect if the NIC additionally implements
> NETIF_F_GSO_UDP_L4, mangleid_features transparently handle even such a
> case.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>  - ensure mangleid_features includes TSO_MANGLEID for better code
>    in gso_features_check() - Eric
>  - some changelog clarifications.
> ---
>  include/linux/netdevice.h | 5 ++++-
>  net/core/dev.c            | 8 +++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d99b0fbc1942..23a698b70de1 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1830,7 +1830,9 @@ enum netdev_reg_state {
>   *                             and drivers will need to set them appropr=
iately.
>   *
>   *     @mpls_features: Mask of features inheritable by MPLS
> - *     @gso_partial_features: value(s) from NETIF_F_GSO\*
> + *     @gso_partial_features: value(s) from NETIF_F_GSO
> + *     @mangleid_features:     Mask of features requiring MANGLEID, will=
 be
> + *                             disabled together with the latter.
>   *
>   *     @ifindex:       interface index
>   *     @group:         The group the device belongs to
> @@ -2219,6 +2221,7 @@ struct net_device {
>         netdev_features_t       vlan_features;
>         netdev_features_t       hw_enc_features;
>         netdev_features_t       mpls_features;
> +       netdev_features_t       mangleid_features;
>
>         unsigned int            min_mtu;
>         unsigned int            max_mtu;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 2661b68f5be3..3f12061ae474 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3802,7 +3802,7 @@ static netdev_features_t gso_features_check(const s=
truct sk_buff *skb,
>                                     inner_ip_hdr(skb) : ip_hdr(skb);
>
>                 if (!(iph->frag_off & htons(IP_DF)))
> -                       features &=3D ~NETIF_F_TSO_MANGLEID;
> +                       features &=3D ~dev->mangleid_features;
>         }
>
>         /* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
> @@ -11385,6 +11385,12 @@ int register_netdevice(struct net_device *dev)
>         if (dev->hw_enc_features & NETIF_F_TSO)
>                 dev->hw_enc_features |=3D NETIF_F_TSO_MANGLEID;
>
> +       /* Any mangleid feature disables TSO_MANGLEID; including the latt=
er
> +        * in mangleid_features allows for better code in the fastpath.
> +        */
> +       if (dev->mangleid_features)
> +               dev->mangleid_features |=3D NETIF_F_TSO_MANGLEID;
> +

It is a bit unclear why you test for anything being set in mangleid_feature=
s

I would force here the bit, without any condition ?

      dev->mangleid_features |=3D NETIF_F_TSO_MANGLEID;



>         /* Make NETIF_F_HIGHDMA inheritable to VLAN devices.
>          */
>         dev->vlan_features |=3D NETIF_F_HIGHDMA;
> --
> 2.52.0
>

