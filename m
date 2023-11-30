Return-Path: <netdev+bounces-52643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2526B7FF90A
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 19:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55A41F20F65
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BFE59147;
	Thu, 30 Nov 2023 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="df01U5kt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77FD10F9
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 10:06:00 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b4142so1182a12.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 10:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701367559; x=1701972359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WO1WFnPIWCBL5yBZd28EEa/FyIEYhdOG4SzevStvSI=;
        b=df01U5kt9pplP5v/5l/T304BIVlIPj27R5ejOZZzT2OjeI1PoTVXxiIk+vXWvej+mh
         dcUvhX3GE9xQBLxuicN6v8aQWsh1PjoN0qOOLNI8F+CGrUdKrviLxxUrPEoObp2LOvsK
         mv8XKWaSWJ7AZEtAnPLTmq0fczfkJTG5iPsET+lFjaXdOs3t18Od1G1skHnMsqVuHF9A
         foWJyQ8UD5KCL5RYCNYxa9+f2P1OvNezdpZBgRQXyFSCSdeQNlOjDsBwDA4FzHVaK3RX
         i/MDDapowb5y4nFPWK9EHUjunq4IJgJiGSqgZxSP4Lr8/pGygxBATyW5/CNbmBkjbC5i
         k1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701367559; x=1701972359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WO1WFnPIWCBL5yBZd28EEa/FyIEYhdOG4SzevStvSI=;
        b=rMhNuBixSi5tbaZa75XM3t/Ns6Xmy6ca5yubTPVUg0MsJsI3UeRMxWFx3I0PoJVc8b
         iJ/l3KCxseUsTTMg+rkMPorA2vvZzb7+HJJ6vHIkxaKkvdz5mnkm5ALK0o1CKwPXVK/H
         z6AfTWYIRGu0OderW/bZmnGHqAnoz4Nt7kcE11cyZJ9aOL3ZMNqr3slUmZNrCKGsxTVC
         EilFSbjZfbdgIC1fVfDYFvcC0zc/StcddmkU9EyzLUxylMy50khtsMjLhshK4BkTjD1h
         BBPlFCeEeC16FrV2sktump4g6SMOvHirhz0/i/1xzvo1mO4cMy/fMveTN5/BXan11ssy
         2vnw==
X-Gm-Message-State: AOJu0YyRVFtd6E4aZL73AEEA+rTuejFyhIpNrQpEBJDT5Usg340mJnec
	dnPL3oLQlShMkhuJ57o/X+eH31ky4Uby5lg3s51FiA==
X-Google-Smtp-Source: AGHT+IGQwDV5m0gxdJmYmPkKKffJ64xEF4QEe+7MBQY4H9rVIHGXPAWLILF2xh3q0sEwGjMus8I+SV79d0CPv2P+BQA=
X-Received: by 2002:a50:ef07:0:b0:54a:ee8b:7a99 with SMTP id
 m7-20020a50ef07000000b0054aee8b7a99mr206353eds.0.1701367559069; Thu, 30 Nov
 2023 10:05:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130030225.3571231-1-shaozhengchao@huawei.com>
In-Reply-To: <20231130030225.3571231-1-shaozhengchao@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 19:05:45 +0100
Message-ID: <CANn89iKhtEcZm4g_xykYQDjeT90EeWCWFTUDLr-T9yxr0gqH3g@mail.gmail.com>
Subject: Re: [PATCH net-next] ipvlan: implemente .parse_protocol hook function
 in ipvlan_header_ops
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, fw@strlen.de, luwei32@huawei.com, weiyongjun1@huawei.com, 
	yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 3:50=E2=80=AFAM Zhengchao Shao <shaozhengchao@huawe=
i.com> wrote:
>
> The .parse_protocol hook function in the ipvlan_header_ops structure is
> not implemented. As a result, when the AF_PACKET family is used to send
> packets, skb->protocol will be set to 0.
> The IPVLAN device must be of the Ethernet type. Therefore, use
> eth_header_parse_protocol function to obtain the protocol.
>

Please add a Fixes: tag

Also, why macvlan would not need a similar patch ?

> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/net/ipvlan/ipvlan_main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan=
_main.c
> index 57c79f5f2991..f28fd7b6b708 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -387,6 +387,7 @@ static const struct header_ops ipvlan_header_ops =3D =
{
>         .parse          =3D eth_header_parse,
>         .cache          =3D eth_header_cache,
>         .cache_update   =3D eth_header_cache_update,
> +       .parse_protocol =3D eth_header_parse_protocol,
>  };
>
>  static void ipvlan_adjust_mtu(struct ipvl_dev *ipvlan, struct net_device=
 *dev)
> --
> 2.34.1
>

