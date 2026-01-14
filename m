Return-Path: <netdev+bounces-249924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6650ED20BA4
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 19:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D20B63010A8A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4792FFDFC;
	Wed, 14 Jan 2026 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JobFciBA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED817A309
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414043; cv=none; b=W8+30JWXUQe5B2IDOQZgxT4KDNRZtKmIW2r1o6g6wzrvCbuAh4R2PvYaBVfspUfoEWLZoxuo4hv2uKSIafp4+aqk1TalJO9uQG7G/MA3sive+jTBRfFe7vi6JYUL0xT6zUSu2NPiPeXDX1/2sHgBsFhRQSfc3y2zzDiO5Hnlyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414043; c=relaxed/simple;
	bh=rAA0hfnYW/g3iYZ/x9yjGCX4k7/q0bDFC6BHR2C+Xsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liqANc5qawNsBA/qrwJEqYD54F0vLZzruSNx4JY6DaacMKTzdF5M4ECYhAkZE0uij1FvASkXt0gb5L7tHb3NEu7Qh/JyUsBHx6xShgXQHwQe+v6CJEiS0HcHXVzrfMJ2tuQGL2yv3WY2ZaZLiiHdoKj9v0RvcCxBT4WxZwCFbG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JobFciBA; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a32bf0248so331876d6.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 10:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768414041; x=1769018841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXnvVQQge95JJk0l6ClBVGN7ircNBoD+M2yk74abE8k=;
        b=JobFciBA+W69WB4jRjDwHs4+JAq7P/1HGn07UM2EO+CqGN7Tz7imrWzXqQCwCUkbAU
         Ye9PC3k9Z9Hc4UdA1qqjmx2Fc9a7+o+pioZ2fRMrqmsNOeEf9jCm0O1yxN9Z5HQ6Tb0p
         B/ADI2myZ3vAytBuOw98vAbs91ni4uyMpvZFmavVDqzyJc+7zw2ptMgwD4vPF47Q3947
         HVMHkK46p5CMt8vL2MmYNSxlLngQUi7nEe6fXsXRtSHi2xqGXAWKAG5XRG8Jf53ARHbF
         8619Tq4rJ5OWT0SxmJ6J1wgnPRM9vLF3Vja26wZc0zpwZD3Worj+NDzl07dSHhZ1ZYO9
         BTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414041; x=1769018841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXnvVQQge95JJk0l6ClBVGN7ircNBoD+M2yk74abE8k=;
        b=ESw4yFpD3WBY8MMJ0cOsuKKRaAnuPa2sC7LenUDh8gFsDmkmV6K3THq2v4yj7ARkAo
         KDK4moun6B3sWTpDqIIJgVX+h/DvtQBGKNGQca8TlAq4EcIMYLn7VO/pKTNgUZ4+qi/R
         KJRzyD/VOO2IzV1h7kZ9VPa+iLQf4YQ9xNYhZSFIPl0Wansv7vV/VKwGHc88s0iBy6Q0
         kicxEJG/v32wKCPXMVF+/Sj+0jsBVWbNzePticVGf/hoBfoXvHViN7wK4a9EUOriF8ka
         B4IhM5ty306jYsLUCS0xTSpPqcHgz0X/z4Um5HMUMwGwBcCzG9rz6jq+JXR5EtMWuZwz
         mD+g==
X-Gm-Message-State: AOJu0Yz6uOpPnSPykqyHqgyuPKHXUbJ1cNzj0O9iKeFQltTel5ZrWr/1
	utQb83QGi0ZCmz3+t9wJ4M6ggLfvaTrMHyoYz94svpXDDoGy0o/gH99RsOI1/5oZe4ODhMiysW+
	JpenVB3Fslc5wXeNNiCpCBVKxCbcTNl9Km8oCb0qoadTwZlb6cexofmtN6yU=
X-Gm-Gg: AY/fxX4YdRxdUfcuDfUauzEvYdL0uOI8s1a+0g9TrDqhwOCIZg19caDkgn8PMSRJGUX
	1reuLIACDmT8vVFr1rOo35dgZz1Xr4jBOA+ic8u+9Yi/Akk4XXoJseGbo18VYkplf9bri+IiqFk
	SYz1E+VCnWXJICk/JqYcDoFAHCRPJc2BkiaDcIv9rSQJRE2/GFjnLRbjC9gXGEwEuJJVOqVjmm3
	9UOcQACfCC8YjLA6o3HIXI4FKB4AHZxUkUjXIzTJu8Aqwu8SHZGsXwoix+rSO+UWxkrvA==
X-Received: by 2002:a05:622a:1892:b0:4e8:96ed:2e65 with SMTP id
 d75a77b69052e-501481fa1ebmr52824681cf.22.1768414040117; Wed, 14 Jan 2026
 10:07:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768410519.git.pabeni@redhat.com> <70afe1dc4404ef46154b684b12c59d4bc523477c.1768410519.git.pabeni@redhat.com>
In-Reply-To: <70afe1dc4404ef46154b684b12c59d4bc523477c.1768410519.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Jan 2026 19:07:08 +0100
X-Gm-Features: AZwV_QhtilMGxV-G2_E50OsKGlThJ7vXvrtgxSmll1Uj35mny0M0gsLb2OwMVaM
Message-ID: <CANn89iKk+BPOxCYr1+w85+hd3j7ugLB7EYmm+NdN=4XCsecAig@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 01/10] net: introduce mangleid_features
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, sdf@fomichev.me, 
	petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 6:21=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Some/most devices implementing gso_partial need to disable the GSO partia=
l
> features when the IP ID can't be mangled; to that extend each of them
> implements something alike the following:
>
>         if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
>                 features &=3D ~NETIF_F_TSO;
>
> in the ndo_features_check() op, which leads to a bit of duplicate code.
>
> Later patch in the series will implement GSO partial support for virtual
> device, and the current status quo will require more duplicate code and
> a new indirect call in the TX path for such devices.
>
> Introduce the mangleid_features mask, allowing the core to disable NIC
> features based on/requiring MANGLEID, without any further intervention
> from the driver.
>
> The same functionality could be alternatively implemented adding a single
> boolean flag to the struct net_device, but would require an additional
> checks in ndo_features_check().
>
> Also note that the above mentioned action is incorrect if the NIC
> additionally implements NETIF_F_GSO_UDP_L4, mangleid_features
> transparently handle even such a case.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/linux/netdevice.h | 5 ++++-
>  net/core/dev.c            | 4 +++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
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
> index c711da335510..6154f306ed76 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3788,8 +3788,10 @@ static netdev_features_t gso_features_check(const =
struct sk_buff *skb,
>                 struct iphdr *iph =3D skb->encapsulation ?
>                                     inner_ip_hdr(skb) : ip_hdr(skb);
>
> -               if (!(iph->frag_off & htons(IP_DF)))
> +               if (!(iph->frag_off & htons(IP_DF))) {
>                         features &=3D ~NETIF_F_TSO_MANGLEID;

Nit : We could avoid the above line, if we always make sure
NETIF_F_TSO_MANGLEID is set in dev->mangleid_features

> +                       features &=3D ~dev->mangleid_features;
> +               }
>         }
>
>         /* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
> --
> 2.52.0
>

