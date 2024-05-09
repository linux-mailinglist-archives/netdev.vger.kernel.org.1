Return-Path: <netdev+bounces-94821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3227E8C0C76
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC021F211EA
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436AC149C7B;
	Thu,  9 May 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwORTE6R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70779C2C6
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242878; cv=none; b=dedCnyaGIib5+2GLbxkNVXLA1aWcpRzhIii7G3cOSgRNmIQ2bYvZCrxqBCxn/cdlDZtrJmuk4AsEgK1ZQqsOC//1lx3lt79JVmM+4yA9p2UQksZlTSdkeInHyYIjW5k25XK2qU0xm6xqyF92JwiEkStUs4V6nEu8PuBcrhK/qtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242878; c=relaxed/simple;
	bh=iG9VVOrijn53CgkcMK0RROsKN/bN0in5V7bDNVUALrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bt4DPdxM/vx/JdVmrQz2uI2fzdNYjtBv/O1+GTd0etGcCDNeSQLc35i5MLCaoPXavmKNSf4lV8Gel3IJAJ99Y6lK2xXFyyWFtGbksbetpNSoQgqb9NB25ajVmzPSIbLqFDWuWGapx7oc6TKAZ5HsZwGpYoiEQJjNVYdKLY/9eFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwORTE6R; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso5814a12.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715242875; x=1715847675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWFVBEXCXfK7vdwBOGwn0fjnnLAnlLcXwW+BmXXp6+M=;
        b=cwORTE6REQD++RbWm05kGcsPlRAO7yVwfDUUVYueHam02EDdwugJuTJ1+3AtqfOjth
         F0ZEnjes1wCtR4O9G3S7iQ3dnFXGjS6jkbOA+axCYGgKUln9Jc8WyIOYN3z6I8XjlnCz
         ZO6C8Tl0SPHNx7N0a28rLb3ojWjMLjXHHw+8s6OID5vSS03hf0Thfg65dmPenayvjUwt
         qle2vjXTGZDCvTs5UjGkuu39KHSd2L2jTJ1kd5O1irYoRWvjqp6gb6sBUtNyNpf5qwSX
         1wGPDuCb5474gfzQCltGLhuzgPjy1uN5rdzXBsVNC4dhBbHKNSp6nP6bh7DEubvvHwHW
         mDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715242875; x=1715847675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWFVBEXCXfK7vdwBOGwn0fjnnLAnlLcXwW+BmXXp6+M=;
        b=OeWMZVbIZraqlQ7TaPNR6XtshS1zCNnv+Vpc3qeaHozJWQ3r9/yo1WJOohKKOCsKb7
         ce66ExbJ5WlB0O+py+zdIUkmfj8JEAkXBJY/IeCA0DXW56AImWWGilGS2som3ihZbPpb
         OTVyeVWXCVIWmaOTtcb+ch0RPeZoG5eCRqBOSWbVyv5fcIWc3ZN+xifzRNQ80FqW12nA
         1q796qajDrj1fhwTRu6eZHDVj2gGbOMHiF3jhPsGlmVz4y7rodFtk/do8IcVcFfbygWx
         UU0K1O3pIioyMZ0RKu9w19/byBWNE3y+z2B9aHE1hIWDtCTZqZ+YMijv9FCsfk5l6att
         icUA==
X-Forwarded-Encrypted: i=1; AJvYcCVUfbyM1qm2C/CHu6wW6JcgjFYUvoscARSOLOQkGMYocpWekbJCgDFkj+XLVn5jEQqmfdNa0VS4gKkci82J+8sWuvzDYko0
X-Gm-Message-State: AOJu0YyJ4jab4hDFAhVX646eApglPdclwJeFoth0D97zZ3WHpbWG27TS
	C/e1KJg1Tnvh8nFiz7HCoev8+AECTFiZUdq/gwbg5aeYAPyiQgyE5efXPI/d+JwiePyr6UN8Ohz
	Ngc8Hl5bC1rqthh6lI+YP41bPq6Te/z/7hSl4GBQnC8k/zaeEQw==
X-Google-Smtp-Source: AGHT+IGWPVw8+oDEFcPbeqmGHQW38UWR2GrflwGLvWu4D5nSKRDvyiuBiNQsjWPu6TwfkWCel1trKAJrO6rY7Bh9c/8=
X-Received: by 2002:a05:6402:3c5:b0:572:5597:8f89 with SMTP id
 4fb4d7f45d1cf-57334333ademr135428a12.6.1715242874436; Thu, 09 May 2024
 01:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org> <20240509-gemini-ethernet-fix-tso-v1-1-10cd07b54d1c@linaro.org>
In-Reply-To: <20240509-gemini-ethernet-fix-tso-v1-1-10cd07b54d1c@linaro.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 May 2024 10:21:01 +0200
Message-ID: <CANn89iKgi6yEEenSy1M-PVRYWz=Ri9UorV7irCywOZ8xTbNk_A@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: ethernet: cortina: Restore TSO support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 9:48=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> An earlier commit deleted the TSO support in the Cortina Gemini
> driver because the driver was confusing gso_size and MTU,
> probably because what the Linux kernel calls "gso_size" was
> called "MTU" in the datasheet.
>
> Restore the functionality properly reading the gso_size from
> the skbuff.
>
> Tested with iperf3, running a server on a different machine
> and client on the device with the cortina gemini ethernet:
>
> Connecting to host 192.168.1.2, port 5201
> 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D1c8a
> 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D1c8a
> 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D27da
> 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D0b92
> 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D2bda
> (...)
>
> It also performs well: ~268 MBit/s.

This does not look very good to me ?

What number do you have when/if TSO is turned off ?


>
> Fixes: ac631873c9e7 ("net: ethernet: cortina: Drop TSO support")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet=
/cortina/gemini.c
> index c569e5615ecf..599de7914122 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -79,7 +79,8 @@ MODULE_PARM_DESC(debug, "Debug level (0=3Dnone,...,16=
=3Dall)");
>  #define GMAC0_IRQ4_8 (GMAC0_MIB_INT_BIT | GMAC0_RX_OVERRUN_INT_BIT)
>
>  #define GMAC_OFFLOAD_FEATURES (NETIF_F_SG | NETIF_F_IP_CSUM | \
> -                              NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM)
> +                              NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
> +                              NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TS=
O6)
>
>  /**
>   * struct gmac_queue_page - page buffer per-page info
> @@ -1148,13 +1149,29 @@ static int gmac_map_tx_bufs(struct net_device *ne=
tdev, struct sk_buff *skb,
>         skb_frag_t *skb_frag;
>         dma_addr_t mapping;
>         void *buffer;
> +       u16 mss;
>         int ret;
>
> -       /* TODO: implement proper TSO using MTU in word3 */
>         word1 =3D skb->len;
>         word3 =3D SOF_BIT;
>
> -       if (skb->len >=3D ETH_FRAME_LEN) {
> +       mss =3D skb_shinfo(skb)->gso_size;
> +       if (mss) {
> +               /* skb->len will be all segments in this case */
> +               netdev_dbg(netdev, "segment offloading mss =3D %04x len=
=3D%04x\n",
> +                          mss, skb->len);
> +               word1 |=3D TSS_MTU_ENABLE_BIT;
> +               word3 |=3D mss;
> +       } else {
> +               mss =3D skb->len;
> +       }
> +
> +       /* Translate to link layer size */
> +       mss +=3D ETH_HLEN;
> +       if (skb->protocol =3D=3D htons(ETH_P_8021Q))
> +               mss +=3D VLAN_HLEN;

Are you sure this is needed at all ?
Why not include IP and TCP header sizes as well, if the datasheet
mentions 'link layer size' ?

To double check, please disable GRO on the receive side and verify the
packet sizes with tcpdump.

Typically, for MTU=3D1500, IPv4, and TCP timestamp enabled,
skb_shinfo(skb)->gso_size is 1448

(Because 20 (ipv4 header) + 32 (tcp header with TS option) + 1448 =3D 1500)






> +
> +       if (mss >=3D ETH_FRAME_LEN) {
>                 /* Hardware offloaded checksumming isn't working on frame=
s
>                  * bigger than 1514 bytes. A hypothesis about this is tha=
t the
>                  * checksum buffer is only 1518 bytes, so when the frames=
 get
> @@ -1169,7 +1186,9 @@ static int gmac_map_tx_bufs(struct net_device *netd=
ev, struct sk_buff *skb,
>                                 return ret;
>                 }
>                 word1 |=3D TSS_BYPASS_BIT;
> -       } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +       }
> +
> +       if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
>                 int tcp =3D 0;
>
>                 /* We do not switch off the checksumming on non TCP/UDP
>
> --
> 2.45.0
>

