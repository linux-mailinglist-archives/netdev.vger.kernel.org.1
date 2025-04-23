Return-Path: <netdev+bounces-184935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8180A97BE8
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B75E7A5C51
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991821F78E0;
	Wed, 23 Apr 2025 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Isq7gYRe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9272AF1C;
	Wed, 23 Apr 2025 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745370116; cv=none; b=IGNYmswdhj5tZPjifgFP4A8yDqdCCX2mC9OJa6A4148CX4hLFbSkoil5tLOt6vu5/FRXuKscNwib1b2eI61c9WwHD5LA1x9d0ZYiQS56r/Tp9g8BzYliLY4qe6SdlqhAgceSY1QRJYmUXgf6Pzv3IFmZIp3xlp3jqMn4lBVlWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745370116; c=relaxed/simple;
	bh=MGbPXiW4nYV+zqOefAawrUbkXEem0Jp3jVqvvM3VUzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W35TEE7FdOjbdVqtpYTpFJnBOg3P8L4N0NzNLIi/rpionPyVjO7/rqD1qPFr3+/gIur7CtwYAi0PFFwa3t5Nl5KoN5pe9RK1FrhYExub7ga11AUTo9+Xod4/Z5OkWWaKjJfzz8sPdpse9tOAfQMJEbmRK2qP7+eblLTU+ow3bfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Isq7gYRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E23C4CEEE;
	Wed, 23 Apr 2025 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745370115;
	bh=MGbPXiW4nYV+zqOefAawrUbkXEem0Jp3jVqvvM3VUzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Isq7gYReI5v/tc9LGTxDMm77yuZn/B9d9Tp4LpEPn3HPZV6HthvUEMRVad/h/pxhX
	 nUxOcO4nfjhiruaNj4JFeVeL5mI5N53wnn575kRwGUh/vYEAdX86qUBdcgNt+yjyiN
	 3sbtcxaPvBuiGfY2gT9N5yji7P2NcjQy09XV4LAy5Ehu/ed3vncdsHmjzKr+mIw39o
	 urEiOIbNWnQQb5pWH2pPulAEO4MNLbBLaWWzIgACHfd/YcJpQQiQBoPHFQerOmUn1d
	 fb+Jk8ooIYLNklPM5RROjJ0XYqD4TIlYXIZkeONeeHsnSLPEglbjTKT29IGOaXTAQU
	 DkzePLzWMf1Og==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-acae7e7587dso779119366b.2;
        Tue, 22 Apr 2025 18:01:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5PMz8QsfUJQTn+pCWAyV99nT5KqzUftE3T1TSQ5MVjTZ6w8KDXUrze6gNEBcXZycsJo7OWCqpspt526o=@vger.kernel.org, AJvYcCXykejFFsolR88gYXRLeSYFrq2rPCbM5SMJwGXM5lv4+sR8EAZ08M1dv57nBhJvpmDqma9nYQXP@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwPYUhblOYem78trt4d1Mk9fAQRHzOgug0yQjzG5yNmgiJeNO
	8IorVTqpa63/ZVt4iiEKrWrAqvTyVJbmfp1QPuuLiOfi3JXytZCHKGbUA2lCZ8chNWMm7braNEd
	7BI07jHyaeERTdp1BAUUlo5aazr8=
X-Google-Smtp-Source: AGHT+IFmOqFprNvXKjhlL+mH7JCjSOPD9Sd9LOXsLFEcq5n3t5ZXVfO0rZboDAM2ZHI8hxFfupsHfi0/0yZrtBJKmoU=
X-Received: by 2002:a17:907:7288:b0:aca:a383:b0c9 with SMTP id
 a640c23a62f3a-acb74afba44mr1547979266b.13.1745370114471; Tue, 22 Apr 2025
 18:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416144132.3857990-1-chenhuacai@loongson.cn>
 <20250416144132.3857990-3-chenhuacai@loongson.cn> <fe0a5e7a-6bb2-45ef-8172-c06684885b36@linux.dev>
 <CAAhV-H5ELoqM8n5A-DD7LOzjb2mkRDR+pM-CAOcfGwZYcVQQ-A@mail.gmail.com>
 <99ae096a-e14f-44bc-a520-a3198e7c0671@linux.dev> <845bd2b4-a714-4ddd-8ace-a45dcdbd486c@redhat.com>
In-Reply-To: <845bd2b4-a714-4ddd-8ace-a45dcdbd486c@redhat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 23 Apr 2025 09:01:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6RS7CZOzggJOxRg9gR8rHA=7Bd54FBapEtyap26+7rPg@mail.gmail.com>
X-Gm-Features: ATxdqUF4HVkgTC9wEST7kxdvVnHFhQ_vu_Vlbf-v4LZpKszb1HsAE8QY-5LzkG4
Message-ID: <CAAhV-H6RS7CZOzggJOxRg9gR8rHA=7Bd54FBapEtyap26+7rPg@mail.gmail.com>
Subject: Re: [PATCH net-next V2 2/3] net: stmmac: dwmac-loongson: Add new
 multi-chan IP core support
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yanteng Si <si.yanteng@linux.dev>, Huacai Chen <chenhuacai@loongson.cn>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Feiyang Chen <chris.chenfeiyang@gmail.com>, loongarch@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Henry Chen <chenx97@aosc.io>, Biao Dong <dongbiao@loongson.cn>, 
	Baoqi Zhang <zhangbaoqi@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 9:27=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 4/22/25 4:29 AM, Yanteng Si wrote:
> > =E5=9C=A8 4/21/25 12:20 PM, Huacai Chen =E5=86=99=E9=81=93:
> >> On Mon, Apr 21, 2025 at 10:04=E2=80=AFAM Yanteng Si <si.yanteng@linux.=
dev> wrote:
> >>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/=
drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >>>> index 2fb7a137b312..57917f26ab4d 100644
> >>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> >>>> @@ -68,10 +68,11 @@
> >>>>
> >>>>    #define PCI_DEVICE_ID_LOONGSON_GMAC 0x7a03
> >>>>    #define PCI_DEVICE_ID_LOONGSON_GNET 0x7a13
> >>>> -#define DWMAC_CORE_LS_MULTICHAN      0x10    /* Loongson custom ID =
*/
> >>>> -#define CHANNEL_NUM                  8
> >>>> +#define DWMAC_CORE_MULTICHAN_V1      0x10    /* Loongson custom ID =
0x10 */
> >>>> +#define DWMAC_CORE_MULTICHAN_V2      0x12    /* Loongson custom ID =
0x12 */
> >>>>
> >>>>    struct loongson_data {
> >>>> +     u32 multichan;
> >>> In order to make the logic clearer, I suggest splitting this patch.=
=EF=BC=9A
> >>>
> >>>
> >>> 2/4  Add multichan for loongson_data
> >>>
> >>> 3/4 Add new multi-chan IP core support
> >> I don't think the patch is unclear now, the multichan flag is really a
> >> combination of DWMAC_CORE_MULTICHAN_V1 and DWMAC_CORE_MULTICHAN_V2.
> > OK, please describe this code modification in the commit message.
>
> @Huacai, please extend the commit message, as per Yanteng's request.
Sure, will do later.

Huacai

>
> Thanks,
>
> Paolo
>

