Return-Path: <netdev+bounces-61959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 117D3825593
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 15:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FDBB221F2
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5072AE74;
	Fri,  5 Jan 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0CS9W304"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A42DF66
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso12100a12.0
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 06:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704465613; x=1705070413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jZtkdk7JJkshJv1ec+QQ3WWMundFT0jFhuRL4iB/oQ=;
        b=0CS9W304QSFenN+4N53eDEg6hHvPj2Vi8WudytIKSrzaWLRXXzylVWFuYtuABtFxnG
         hadpWt0VCecrZIMKp08GKTcwV+IIa+XaGkzKyFGYR24s8c1um5nICxQ2Diq+wdC5zS1A
         5YjzF88eg5lSDn6ysTFWJOrBFN0k7uvHICCYb1mKEgQD6GIduoXIL5CPZTKzyTvanSTa
         c8RiZx6k6tbg4TNy1ffzbhiwmlLY1hBgbjvgu1dabU3lpPVZjM+VRW2zvRxhjpxI8ZYj
         bFot6tXSceFDdWbq9gVK7UzcjNpHGul22VJjQ2n6LOQ1CB6thtUTtzUuInMFeQhraSxL
         xlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704465613; x=1705070413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jZtkdk7JJkshJv1ec+QQ3WWMundFT0jFhuRL4iB/oQ=;
        b=r3TusOpeA4lX7Gt1EktmFDV8lpAM4U0QQzT0lqUXKcHtj1FxCGd4QPPv2DQXqx0mvy
         6YmYiw1RiMMET7byLiP5k5CFMjWWudSWA5XZEBnqMRK5+KzY4chDdT/eXBTYRwHvJPxm
         cIqbesufk6MU/6YNJsTW4+n5vX+W6RJdff46XowkYIKZYDGHMKLCf3E/XjhWI88kpvzL
         su4jlty0iAP+lCLrpR64dQp6EaPI7Z0wjUrkYz03hQ+YTlQKtDsI1VOwzTV//vRCphQF
         YAJwsEgvZN5ZmA+aYLMb/v4AkzJTOvpQcF8oE7qgWo0dhF1Rt1kkYfsW5xSOKKYCyDEe
         8o6w==
X-Gm-Message-State: AOJu0YzERXF/ThqNJogYYDEDToRbyGXtQusPl/KPxmNWM6Z8lqAaMaLI
	h9JYYHbhtgNZEGvaGdjjApsMczswcwZiqsBoEC1Fa2UDYWPB
X-Google-Smtp-Source: AGHT+IGjzNTb0wXowITaFjaRFpqnxEKsfroHyxU2BIh4GF0oOq5lrHeiWO5o0Wq0CiC5990KiUGxgbGVAR0UKfQEJcA=
X-Received: by 2002:a50:d7d4:0:b0:553:b7c6:1e47 with SMTP id
 m20-20020a50d7d4000000b00553b7c61e47mr169651edj.2.1704465612572; Fri, 05 Jan
 2024 06:40:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
 <20240102-new-gemini-ethernet-regression-v5-1-cf61ab3aa8cd@linaro.org>
In-Reply-To: <20240102-new-gemini-ethernet-regression-v5-1-cf61ab3aa8cd@linaro.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Jan 2024 15:40:01 +0100
Message-ID: <CANn89iKPA7DdiZpGy95udBZcf58AxWO-ZUUgNAPaQPDTHSRr9A@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] net: ethernet: cortina: Drop software checksum
 and TSO
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Household Cang <canghousehold@aol.com>, Romain Gantois <romain.gantois@bootlin.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 9:34=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> The recent change to allow large frames without hardware checksumming
> slotted in software checksumming in the driver if hardware could not
> do it.
>
> This will however upset TSO (TCP Segment Offloading). Typical
> error dumps includes this:
>
> skb len=3D2961 headroom=3D222 headlen=3D66 tailroom=3D0
> (...)
> WARNING: CPU: 0 PID: 956 at net/core/dev.c:3259 skb_warn_bad_offload+0x7c=
/0x108
> gemini-ethernet-port: caps=3D(0x0000010000154813, 0x00002007ffdd7889)
>
> And the packets do not go through.
>
> After investigating I drilled it down to the introduction of the
> software checksumming in the driver.
>
> Since the segmenting of packets will be done by the hardware this
> makes a bit of sense since in that case the hardware also needs to
> be keeping track of the checksumming.
>
> That begs the question why large TCP or UDP packets also have to
> bypass the checksumming (like e.g. ICMP does). If the hardware is
> splitting it into smaller packets per-MTU setting, and checksumming
> them, why is this happening then? I don't know. I know it is needed,
> from tests: the OpenWrt webserver uhttpd starts sending big skb:s (up
> to 2047 bytes, the max MTU) and above 1514 bytes it starts to fail
> and hang unless the bypass bit is set: the frames are not getting
> through.
>
> Drop the size check and the offloading features for now: this
> needs to be fixed up properly.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 35 ++++-------------------------=
------
>  1 file changed, 4 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet=
/cortina/gemini.c
> index 78287cfcbf63..5e399c6e095b 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -79,8 +79,7 @@ MODULE_PARM_DESC(debug, "Debug level (0=3Dnone,...,16=
=3Dall)");
>  #define GMAC0_IRQ4_8 (GMAC0_MIB_INT_BIT | GMAC0_RX_OVERRUN_INT_BIT)
>
>  #define GMAC_OFFLOAD_FEATURES (NETIF_F_SG | NETIF_F_IP_CSUM | \
> -               NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
> -               NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6)
> +                              NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM)
>
>  /**
>   * struct gmac_queue_page - page buffer per-page info
> @@ -1143,39 +1142,13 @@ static int gmac_map_tx_bufs(struct net_device *ne=
tdev, struct sk_buff *skb,
>         struct gmac_txdesc *txd;
>         skb_frag_t *skb_frag;
>         dma_addr_t mapping;
> -       unsigned short mtu;
>         void *buffer;
> -       int ret;
> -
> -       mtu  =3D ETH_HLEN;
> -       mtu +=3D netdev->mtu;
> -       if (skb->protocol =3D=3D htons(ETH_P_8021Q))
> -               mtu +=3D VLAN_HLEN;
>
> +       /* TODO: implement proper TSO using MTU in word3 */

I would not use MTU in this comment, but gso_size (or flow MSS).

>         word1 =3D skb->len;
> -       word3 =3D SOF_BIT;
> -
> -       if (word1 > mtu) {
> -               word1 |=3D TSS_MTU_ENABLE_BIT;
> -               word3 |=3D mtu;
> -       }
> +       word3 =3D SOF_BIT | skb->len;

Probably word3 could be left with SOF_BIT ?
I am guessing the 'length' would only be used by the NIC if TSO is requeste=
d.

>
> -       if (skb->len >=3D ETH_FRAME_LEN) {
> -               /* Hardware offloaded checksumming isn't working on frame=
s
> -                * bigger than 1514 bytes. A hypothesis about this is tha=
t the
> -                * checksum buffer is only 1518 bytes, so when the frames=
 get
> -                * bigger they get truncated, or the last few bytes get
> -                * overwritten by the FCS.
> -                *
> -                * Just use software checksumming and bypass on bigger fr=
ames.
> -                */
> -               if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> -                       ret =3D skb_checksum_help(skb);
> -                       if (ret)
> -                               return ret;
> -               }
> -               word1 |=3D TSS_BYPASS_BIT;
> -       } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +       if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
>                 int tcp =3D 0;
>
>                 /* We do not switch off the checksumming on non TCP/UDP
>
> --
> 2.34.1
>

