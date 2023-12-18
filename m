Return-Path: <netdev+bounces-58583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ABE817434
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 15:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5211F227B5
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29CB37892;
	Mon, 18 Dec 2023 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIJ66g5R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338A3A1B1
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so9637a12.1
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 06:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702911057; x=1703515857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8ZQj9/D92P7IY3Kk+XT+YYBPxAlu2nHXSwxNxt87to=;
        b=OIJ66g5R6b3TedTJVcGT1sVTrBQ5V/KoovDmoxPw7uYPn9m2s2s/fT8BoHTKfio6pd
         XMaxXr70KVghcx30ElEfzLV1By41aXXruaWu4wZ2SmyTvc56Tccms8X6li7bH7ZilyLd
         LK6ObiYC9E7C3rcq/ihh1d0AZRGT0eSUkzKVWfaoSpvKxyxabv2483Slq/OckGwuRf3B
         ZsBXcg/kCgNJAg3YUMQIrQeiXOdrYc8ZZ/48GrMlJQEcg8VrQCLzbLXQcIOruVOh3pd1
         GODRiajoqahAvZjmCvukOyZPbtk44XvQ0zmKFp9ylThhZfaDlVYMZ+fyKIjN7qiPkNRu
         QRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911057; x=1703515857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8ZQj9/D92P7IY3Kk+XT+YYBPxAlu2nHXSwxNxt87to=;
        b=p6qu75I73G/vVtZrMTKAXUasFa7rkz3dHeNxldFZAIq5kMmxPdYDonCK8ttAfe/HEl
         hI8gTbLzV69N36S7FSyiMJsPZW1xZ3p+OnCUQzFaatR1Gt2HcuhPoC7TCIDV2oTLQH6G
         5uDsE6bvaIBxqv5+bit6H3Pk9vR6Uh8U5Kwtl38MpujqoR3p9W4JwrH30RULK/zipUfV
         TXM7eDJ5qYhWgvNTfJN+NZEoOiBKDgx9J4OnGtrEkHWrDEIbOtc44K9pYbrWuSw7KlJT
         8HpEbrntnzQAdzlOm4zB0hZiues66cEyO3UBn4tFTMRwj7Qbsas9MVpoZz7E+jsjwJsh
         Zsjg==
X-Gm-Message-State: AOJu0Yze/zpf826JmuAJ83czYQzFQd5z9XkqOEet/fWW7kI3miRHEanL
	zXNpdx/9EUA7J9piczGh9w5Y+0fdjaLE2kjL2K5Sw3ta82TS
X-Google-Smtp-Source: AGHT+IEe3MhrDOHARQuDm6EZaCthAy9zohdGI49oRYSQJIkLkFc3hrp2Xu/UKgOpZu6SbJn2iWVPBUk4+1/NDiJgv0k=
X-Received: by 2002:a05:6402:5216:b0:553:6de7:43d7 with SMTP id
 s22-20020a056402521600b005536de743d7mr86122edd.6.1702911057043; Mon, 18 Dec
 2023 06:50:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org>
 <20231216-new-gemini-ethernet-regression-v2-2-64c269413dfa@linaro.org>
In-Reply-To: <20231216-new-gemini-ethernet-regression-v2-2-64c269413dfa@linaro.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Dec 2023 15:50:43 +0100
Message-ID: <CANn89iLu_vE_S++5Q6Re4c6DZOD7GD-pLFC61VjYGcjFnKDWCw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: ethernet: cortina: Bypass checksumming
 engine of alien ethertypes
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 8:36=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> We had workarounds were the ethernet checksumming engine would be bypasse=
d
> for larger frames, this fixed devices using DSA, but regressed devices
> where the ethernet was connected directly to a PHY.
>
> The devices with a PHY connected directly can't handle large frames
> either way, with or without bypass. Looking at the size of the frame
> is probably just wrong.
>
> Rework the workaround such that we just bypass the checksumming engine if
> the ethertype inside the actual frame is something else than 0x0800
> (IPv4) or 0x86dd (IPv6). These are the only frames the checksumming engin=
e
> can actually handle. VLAN framing (0x8100) also works fine.
>
> We can't inspect skb->protocol because DSA frames will sometimes have a
> custom ethertype despite skb->protocol is e.g. 0x0800.
>
> After this both devices with direct ethernet attached such as D-Link
> DNS-313 and devices with a DSA switch with a custom ethertype such as
> D-Link DIR-685 work fine.
>
> Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet=
/cortina/gemini.c
> index 6a7ea051391a..1400f19bf05b 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1143,7 +1143,9 @@ static int gmac_map_tx_bufs(struct net_device *netd=
ev, struct sk_buff *skb,
>         skb_frag_t *skb_frag;
>         dma_addr_t mapping;
>         unsigned short mtu;
> +       u16 ethertype;
>         void *buffer;
> +       __be16 *p;
>
>         mtu  =3D ETH_HLEN;
>         mtu +=3D netdev->mtu;
> @@ -1158,7 +1160,24 @@ static int gmac_map_tx_bufs(struct net_device *net=
dev, struct sk_buff *skb,
>                 word3 |=3D mtu;
>         }
>
> -       if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +       /* Dig out the the ethertype actually in the buffer and not what =
the
> +        * protocol claims to be. This is the raw data that the checksumm=
ing
> +        * offload engine will have to deal with.
> +        */
> +       p =3D (__be16 *)(skb->data + 2 * ETH_ALEN);
> +       ethertype =3D ntohs(*p);
> +       if (ethertype =3D=3D ETH_P_8021Q) {
> +               p +=3D 2; /* +2 sizeof(__be16) */
> +               ethertype =3D ntohs(*p);
> +       }

Presumably all you need is to call vlan_get_protocol() ?

> +
> +       if (ethertype !=3D ETH_P_IP && ethertype !=3D ETH_P_IPV6) {
> +               /* Hardware offloaded checksumming isn't working on non-I=
P frames.
> +                * This happens for example on some DSA switches using a =
custom
> +                * ethertype. Just bypass the engine for those.
> +                */
> +               word1 |=3D TSS_BYPASS_BIT;
> +       } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
>                 int tcp =3D 0;
>
>                 /* We do not switch off the checksumming on non TCP/UDP
>
> --
> 2.34.1
>

