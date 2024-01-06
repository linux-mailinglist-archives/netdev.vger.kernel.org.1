Return-Path: <netdev+bounces-62155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 772B6825F09
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 10:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA072B22E87
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE2763AD;
	Sat,  6 Jan 2024 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FPCgewiI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541763A8
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so3364a12.1
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 01:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704534035; x=1705138835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY6ni409hKcH1lh6Va5aOe0fuYUH7Bpp+RiVXrSU4PE=;
        b=FPCgewiIBPh7Coj7hUM6jefR/v8Y2CsaR+ZSf7wAtHot/e6b/xPkG6VgqGp7X+crbC
         aDu4NsUnbs9M6sTxFyD/F05G39jmHmvcXKGpXRl6vgUibY47njnCB2vvEERuA5yer2oR
         wlqZj//GKYudhasg2qvIzIcBMmNp4Da+iLNt2Dp8U6W1a6ni3h/g1NEnQGvL+dpxTZl1
         S79N/m+pub6ew2wjJ05MwbSIWZRohArWabuzIAtwyDZl+FMetQGPgEx1r78nWuIMlLTb
         08LFfCluEdx6hYimAtl0cwY/Js32WK431HLuHgthLIG2cwESHYmsLC/pJLxksZVSL31E
         Ft8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704534035; x=1705138835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY6ni409hKcH1lh6Va5aOe0fuYUH7Bpp+RiVXrSU4PE=;
        b=hQKeT9g3DW2YWU9IHbEl5WiKCvRVqiBqAbU3dbc+zH8/v83+nIn/w1F8wqtLv9Hx8b
         Q9xm4ZovRdoUryqS5ZvbYdFsPkT4KGnfPH0GVe+y2+URkMlVPDJygUhQ7uwjBJMMnw7D
         E5f0Qnw3SbknselMgLLhm+euTLifgSex3w2pXi3SLoGNmIl/oW+KnMQqXfSUMldxPo3v
         9+Ixi/YBdRrcnOMaC5YxcW/p3zd2Wozq75cI9P0dSDHNP3RmhLbsFUW6FWcEpNvRnRQz
         1m4y5pOG2UyEm0iMEmZl/JO6eEgufa21jLMq5jjLJrmdRO5SLcYQSvPG4dQ9IC3hi4pc
         njFg==
X-Gm-Message-State: AOJu0YwhfN4/Blc1qw+D1TznNUv3tI71w0tNv3EaQL2CUyficQjuVlQP
	iDsRXIF4NzjEjYuSx02qkmJKPzR7sDXbW5MHUiMJd34T9REe
X-Google-Smtp-Source: AGHT+IHAH2ha145LOuNHiaEH18wbUByU0Yy5RX/KUHZwsgbXcfl0txfcZbr8o/kl4uvq08eaMROmIeJb+QKBY+xLqCI=
X-Received: by 2002:a50:8751:0:b0:557:3e55:41e3 with SMTP id
 17-20020a508751000000b005573e5541e3mr92687edv.0.1704534034713; Sat, 06 Jan
 2024 01:40:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106-new-gemini-ethernet-regression-v6-1-889e98d3deb7@linaro.org>
In-Reply-To: <20240106-new-gemini-ethernet-regression-v6-1-889e98d3deb7@linaro.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 6 Jan 2024 10:40:21 +0100
Message-ID: <CANn89iK7peY2MbquAmU3QN0hCXYMNoMv672ayjneioT=ts7HNA@mail.gmail.com>
Subject: Re: [PATCH net v6] net: ethernet: cortina: Drop TSO support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Household Cang <canghousehold@aol.com>, Romain Gantois <romain.gantois@bootlin.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 1:12=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
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
> The TSO implementation is bogus: a TSO enabled driver must propagate
> the skb_shinfo(skb)->gso_size value to the TSO engine on the NIC.
>
> Drop the size check and TSO offloading features for now: this
> needs to be fixed up properly.
>
> After this ethernet works fine on Gemini devices with a direct connected
> PHY such as D-Link DNS-313.
>
> Also tested to still be working with a DSA switch using the Gemini
> ethernet as conduit interface.
>
> Link: https://lore.kernel.org/netdev/CANn89iJLfxng1sYL5Zk0mknXpyYQPCp83m3=
KgD2KJ2_hKCpEUg@mail.gmail.com/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This fix was developed on top of the earlier fixes.
>
> Finding the right solution is hard because the Gemini checksumming
> engine is completely undocumented in the datasheets.
> ---
> Changes in v6:
> - Keep the software checksum on larger frames, just drop the
>   TSO support which is bogus anyway.
> - Drop the heuristics in the second patch. Just dropping TSO
>   makes everything work right.
> - Drop adding the length in word3.
> - Link to v5: https://lore.kernel.org/r/20240102-new-gemini-ethernet-regr=
ession-v5-0-cf61ab3aa8cd@linaro.org
>
> Changes in v5:
> - Drop the patch re-implementing eth_header_parse_protocol()
> - Link to v4: https://lore.kernel.org/r/20231222-new-gemini-ethernet-regr=
ession-v4-0-a36e71b0f32b@linaro.org
>
> Changes in v4:
> - Properly drop all MTU/TSO muckery in the TX function, the
>   whole approach is bogus.
> - Make the raw etherype retrieveal return __be16, it is the
>   callers job to deal with endianness (as per the pattern
>   from if_vlan.h)
> - Use __vlan_get_protocol() instead of vlan_get_protocol()
> - Only actively bypass the TSS if the frame is over a certain
>   size.
> - Drop comment that no longer applies.
> - Link to v3: https://lore.kernel.org/r/20231221-new-gemini-ethernet-regr=
ession-v3-0-a96b4374bfe8@linaro.org
>
> Changes in v3:
> - Fix a whitespace bug in the first patch.
> - Add generic accessors to obtain the raw ethertype of an
>   ethernet frame. VLAN already have the right accessors.
> - Link to v2: https://lore.kernel.org/r/20231216-new-gemini-ethernet-regr=
ession-v2-0-64c269413dfa@linaro.org
>
> Changes in v2:
> - Drop the TSO and length checks altogether, this was never
>   working properly.
> - Plan to make a proper TSO implementation in the next kernel
>   cycle.
> - Link to v1: https://lore.kernel.org/r/20231215-new-gemini-ethernet-regr=
ession-v1-0-93033544be23@linaro.org
> ---
>  drivers/net/ethernet/cortina/gemini.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet=
/cortina/gemini.c
> index 78287cfcbf63..705c3eb19cd3 100644
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
> @@ -1143,23 +1142,13 @@ static int gmac_map_tx_bufs(struct net_device *ne=
tdev, struct sk_buff *skb,
>         struct gmac_txdesc *txd;
>         skb_frag_t *skb_frag;
>         dma_addr_t mapping;
> -       unsigned short mtu;
>         void *buffer;
>         int ret;
>
> -       mtu  =3D ETH_HLEN;
> -       mtu +=3D netdev->mtu;
> -       if (skb->protocol =3D=3D htons(ETH_P_8021Q))
> -               mtu +=3D VLAN_HLEN;
> -
> +       /* TODO: implement proper TSO using MTU in word3 */

Okay, but you still kept this wrong comment.

MTU refers to the device MTU, which is very often bigger than the MSS
of the flow.

Hopefully the comment will be removed soon when TSO is properly implemented=
.

Reviewed-by: Eric Dumazet <edumazet@google.com>

