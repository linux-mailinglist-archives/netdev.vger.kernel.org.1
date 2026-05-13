Return-Path: <netdev+bounces-287676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNYWFDisBGrIMwIAu9opvQ
	(envelope-from <netdev+bounces-287676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:52:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FED353773A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 019AC32D6108
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA36C472766;
	Wed, 13 May 2026 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcv2C2Pb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7F32E0B58
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689230; cv=pass; b=luXq58BxzpgEk5nowZENzx+NC9mKyX8qoVBZ9R54oHL/N+/ohJ94uzxj2DqckrlZg8y0WPKE1ZMmUaGh5rNCLI2bjKl+veHEUQ6Rg8yUU1xdoxYrSKZJ6xSVS24oeFTGaUpeXrhcr6K+mgQShArH8L3imGoCeV5RzK4+ixW0Kts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689230; c=relaxed/simple;
	bh=eAJTGuNjyeN1H0W0agKrLwMo2FHLEctrW7qpgWkMFd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haI7N2SlpWH98zin43SW/V9Wem0Iy1iHZJqk/yBzvZqC9SL4z6KnTzh+w+ponmvPbfNPHmkpNuumSkDYc+pbeatGSTjHPLE66ksmVGD8K/AW0TWb/lEtSWC7lzsDpIihJrX1NU6eW5twWEkUwLMPbLjoMp5EszFNnxG/tcdBYo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bcv2C2Pb; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so413a12.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778689228; cv=none;
        d=google.com; s=arc-20240605;
        b=bfMwlA39TWQjIhbOV/puK83dRsdkGt+pv2yY3LoOEIvMvzg9c0OIhd86VkFXfdWhMr
         FW6QFmic3kp43rRBUBvP/jsM4BoPuYH3qQ1zWhJX5vahNYYKwauxg5R374CRGtyO6fOr
         P23TfKbGs++VP83Q/u0cagUOK3J8qr/4rBMv0pRqkWLyV7Axz+EgcpQHvZ66lhUwhbub
         o0KRD07CbSJBbK/11Tn2QKPevyt8EiGC/HxJj6P3QJk1Xs2okJB6xx+bdhPE8P7tJxER
         HkKKmV60xafbwHY/ZqjJ4BTqCV0na4vwLFIKcA+JNWoK/rimW0Bpcr/evW78p6N7gcV6
         PbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eAJTGuNjyeN1H0W0agKrLwMo2FHLEctrW7qpgWkMFd8=;
        fh=+AyL+Uw0aiqSkJuFINLU0pdH2dA29+E5/xd3vwcCwMA=;
        b=HQIH77WDE+pjeWbsMa+g8ezY9lH7F+QELb8msbJgH5L12NGiTbul7Rkds7V5YQTN85
         rKOOkIVZpPNk/f0LJt+gDqKIvYwRYAXLKg8KTuVPHcZr9Aj/gBCPlzUVg/7jDWSQNR0+
         zy/AwSrjemnSunQl+3+YBguZof//UL2Pud/+gvScz7Zy289mVmcUG01xkGedNpvDp9mw
         mFlZ0gvjkELIAOK48xd6HLHNewJzSZohpx7szAk2xZe9zHNlO+fh+UDq8Tei6iGHZ0Jy
         mC5W/YIFOK1X8svQZO1PLmGtc9ixkXpNjIJx7qBWjV4b7POrofSEhFl3iGUKD+x+uXFi
         00jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778689228; x=1779294028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAJTGuNjyeN1H0W0agKrLwMo2FHLEctrW7qpgWkMFd8=;
        b=bcv2C2Pb5BbAxkjDGC/Ls88uXgGODKKzM6B6ZJ+ZTPGGvpKaPY4erLix8MH4+WUDFM
         rc02AfmZo5Y4xBo6l3X116tYg3xWV1J/yycnEHuJEgrtJ4cziwL2NxUULPaujYjU1UVK
         ECQ1Af4dPWBH9uWNH5zphhUSVbeP9Z3eDQ/d6aaTYkJhoF3kwC3n5kEWjnWSLr8hQrBc
         6IOzYomk+KR6h5Uh6bwengHL0SuXn0IF5D1zGwkfFD7Va6EiOKtm4P0FI12051jFNAPI
         UXh0ArEI1bSzIptkLpkBLek3/GFqWZhnQmqMG+ZW2Jn/9CoA5nJzGh65rjdd/QuN4KXQ
         4DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689228; x=1779294028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAJTGuNjyeN1H0W0agKrLwMo2FHLEctrW7qpgWkMFd8=;
        b=ODw3xENVWHkAFKpfapzc5IH6AtYYGEkVdA1/vOSXw3JYZ2c8uZYhiPzZOUZM/XAmLX
         hgkZLV9kwi6m4W1ndFeoPBPssbimU6oqvFMI0KGSL/HQ+e1IBoWwi5W2KTu0UIXVdCC7
         2qVz8QL5s6Rz4uvEgtB5mowc7SjPAQUQjAc2vi0AESXzkTy67SoBEcpV38uVPVKZ/yj5
         kX4RMDI/hVlH97mSyN6idBU53CwME5WlpBx/7P+hkordSvAB6172d9ddKz0ewMP/5uOA
         9Bf6KgyHOPWCChSSPT7h8ZyIGIBXFiDRuTG/iBaMraGg9zj2/IWRdta7MuyjrWlrCip9
         Nc9g==
X-Forwarded-Encrypted: i=1; AFNElJ/EVYPisyMBLD4q10C70agcgvS6LqUEZN99Nq7G8X6tJWYM8Tjm+6BcsEoSjB3Tz9hzOvQu0lM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgp142xzkDAF2CbMO/gMXlptwaAYTQtuVHfbAqJzrZ6ABMYfH4
	2nqTz6J/jRHQkHSucTXJFfGuNGK3zLzeHZz+vB10KW9YEAx3l47dUEkMNO6vLiuDtLDw38JBiZl
	09dW1Y/XZp1ddJ1ymB1dcKloaUvjk2tLg3b2eiKMd
X-Gm-Gg: Acq92OH5dfukQs77ScJUYmwcKqbpBPBzImTmStY5Ds4bGC3kIt2/WAFFkBib1yjFNHc
	oisUuw82Ky0AeUm9B1K4y46B53/dIC1ZmB4fw1coEE5Kz8FNhHAw7fFyjK9yJkLXiEiiHGd09Gn
	3goARoG55JW8wjOOFRqs/Xb3WRk2vc63C6SWGR1icdaUADNzGXTaaCXN+torBOOGix1Bn2/tSfy
	U/Hc9U8gzJiX8ke2MSyNq2f1Zv41L4O3s1fzmCEwqTJd2TUgupmpirLIqH86W7iEA2kPqurNrfX
	Ssq3NS/4258h1+9PDk6OgsAzWu1HAsU8VP/QVyjbvMzYnDixM1iAoEkmGioJSDbvMwweiTNr0jR
	vkw==
X-Received: by 2002:a05:6402:a554:10b0:682:a2f:a15c with SMTP id
 4fb4d7f45d1cf-6827c43e148mr52503a12.11.1778689227392; Wed, 13 May 2026
 09:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-mlx5_vxlan-v1-1-cf666d042618@google.com>
 <20260428184631.40f1f1b7@kernel.org> <CANkEMgkBnuRfurKcFEUAZcJcX1XYSnHbBozZGP8DpnKq--tWbw@mail.gmail.com>
 <20260429190150.417b0302@kernel.org> <CANkEMg=Xc9jN8McZmLerK_ffOwRFfX+yO=4Ha6+umVogbkBj3A@mail.gmail.com>
 <20260504181022.60ee2a1a@kernel.org> <c2258e70-4c2e-4999-8876-ad98f4259eda@nvidia.com>
In-Reply-To: <c2258e70-4c2e-4999-8876-ad98f4259eda@nvidia.com>
From: Marc Harvey <marcharvey@google.com>
Date: Wed, 13 May 2026 11:20:16 -0500
X-Gm-Features: AVHnY4LR-7un0veJqtGYLAWCLE6dTqG73RIFCxJa315MJ-hSMZ1fDaAXA4SUzUo
Message-ID: <CANkEMgmhh40uE8asRO3WJpAtDZWDcSjJNVCzh54TgwcMUonhdA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5: Add MLX5_VXLAN config option
To: Gal Pressman <gal@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9FED353773A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287676-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 5, 2026 at 1:21=E2=80=AFAM Gal Pressman <gal@nvidia.com> wrote:
>
> Hi Marc,
>
> On 05/05/2026 4:10, Jakub Kicinski wrote:
> >
> > Sorry, I don't know mlx5 very well. Sounds like you have to talk
> > to nVidia or/and run some experiments. The current patch is a no-go.
> >
>
> The hardware offloads 4789 by default, hence the
> UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN, you cannot simply remove it.
>
> Have you tried disabling tx-udp_tnl-segmentation through ethtool?

Thanks for the responses.

Gal, by "the hardware offloads 4789 by default," does that mean the
hardware offloads 4789 even without an explicit command from the
driver? I ask because mlx5 does send a command to offload 4789, but
perhaps this command is redundant and only for bookkeeping purposes.

I haven't tried changing the offload related ethtool parameters, and I
will, but I suspect it won't help in this specific case since the
perceived regression involved non-tunneled traffic.

If the hardware indeed offloads 4789 autonomously, then the perceived
regression we saw might not have been real or related to enabling
vxlan.

