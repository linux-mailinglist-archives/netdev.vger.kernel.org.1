Return-Path: <netdev+bounces-59490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1825C81B0B3
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 09:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D731F23710
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542D91BDCC;
	Thu, 21 Dec 2023 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJPyDYAt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0AF1A72A
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so5335a12.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703148653; x=1703753453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxeQfvnCBnaZ8++DLAlIrocYAzvJAHlnYm0p+yFeEsY=;
        b=MJPyDYAt1tdvjnxlviPPTCfT42VUZJ5HDTMP36pq/Gf/Jv4vuyEUOk26+dNwTUM6IW
         APgdU2aFGyCqAx5FFtbRkBbVgVqSpNT74wC4Evr0NurAAlrwFVLeJiRRgn8APW7JpoEW
         gWp5swyZWKqLvoruAxtlbutoSB0VY6oajalpQVHJ8vHluD2rmT2YZ20VOC9FN4RzO7VE
         jCYq37dgn3BCZeA+TjTE/ESTdCJ4sbc6MTzucVlptpRvxyqB4tCs0gZSCVg/gI8RS1J0
         Y7cXt5y7pIPYPNWwbv+z1PE7E3K8/Q/ixOkDzXkGG3w4TWgLPqDN78yni7HtRXBNA97n
         O30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703148653; x=1703753453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxeQfvnCBnaZ8++DLAlIrocYAzvJAHlnYm0p+yFeEsY=;
        b=AR/gL42VTJJ9JhQkdudau7t7r6I69wW6SLrEmGzhrNY5vXpG14bQyrp6c+qPnvaakG
         7iHHNQKw44xLHIwjzOGy7PQxKO+SyiJjVZu1CFXs5J8QyOEaKQDPYj8eCbTP0lOm/bhU
         hQRFZXRDHxmKpxsLou7h0ssyt+x0mBM53n6MASGRGcNfSBOtzUg/V/yqS+PIlWrTxwiO
         9vLFTl2hcWRPvnnHzv4VFqbbbZfr102IcXlGjes1nbv1KIC0IgR4d2wS0iwDGRb27MKD
         zYH5CPxsYZvvYYG0ipNepeQbBxpioVP+1Yxf+XdoFMoFHHgxnJeFd35by3iilsyl6YS/
         Z7NQ==
X-Gm-Message-State: AOJu0Yzkq99foCJ9m7KpjLKWepggRFqv5HYzeaJMszX+lIdSeVOFPrHV
	p6EJUI7S6vUkzE4aYr4HDl30AO4oJEeUR7ci1rDW5v/9Cso1
X-Google-Smtp-Source: AGHT+IEPIHV7FPF0HuFB4FWmA1mH7dNRiHFovozWu+/N1J+btrlqagdPmE1tdLxP/25ujXezzvUBc730iLU+EfdBmwU=
X-Received: by 2002:a50:d48f:0:b0:553:b7c6:1e47 with SMTP id
 s15-20020a50d48f000000b00553b7c61e47mr58178edi.2.1703148652516; Thu, 21 Dec
 2023 00:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-new-gemini-ethernet-regression-v3-0-a96b4374bfe8@linaro.org>
 <20231221-new-gemini-ethernet-regression-v3-3-a96b4374bfe8@linaro.org>
In-Reply-To: <20231221-new-gemini-ethernet-regression-v3-3-a96b4374bfe8@linaro.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Dec 2023 09:50:41 +0100
Message-ID: <CANn89iLuRKOeUGUV+X3fqAe+9gvLfqj5dCfbqqE78FYL+E2MRQ@mail.gmail.com>
Subject: Re: [PATCH net v3 3/3] net: ethernet: cortina: Bypass checksumming
 engine of alien ethertypes
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 1:02=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
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
> index ecc247acac39..6d153eba8e81 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -29,6 +29,7 @@
>  #include <linux/of_net.h>
>  #include <linux/of_platform.h>
>  #include <linux/etherdevice.h>
> +#include <linux/if_ether.h>
>  #include <linux/if_vlan.h>
>  #include <linux/skbuff.h>
>  #include <linux/phy.h>
> @@ -1143,6 +1144,7 @@ static int gmac_map_tx_bufs(struct net_device *netd=
ev, struct sk_buff *skb,
>         skb_frag_t *skb_frag;
>         dma_addr_t mapping;
>         unsigned short mtu;
> +       u16 ethertype;
>         void *buffer;
>
>         mtu  =3D ETH_HLEN;
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
> +       ethertype =3D skb_eth_raw_ethertype(skb);
> +       /* This is the only VLAN type supported by this hardware so check=
 for
> +        * that: the checksumming engine can handle IP and IPv6 inside 80=
2.1Q.
> +        */
> +       if (ethertype =3D=3D ETH_P_8021Q)
> +               ethertype =3D vlan_get_protocol(skb);

You meant : ethertype =3D __vlan_get_protocol(skb, ethertype, NULL);

Otherwise skb->protocol could be something unexpected, according to
your comments.

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

