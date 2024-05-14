Return-Path: <netdev+bounces-96310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17438C4E90
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468B7B20958
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244822374E;
	Tue, 14 May 2024 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uO2ONjId"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F11D54B
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678181; cv=none; b=X5nRI28+pd9AiR+J1K69HQ/YOma4SIhY3fytLK9gw0gYICgw/4yffU7RD6W/1R4ZRBxw9LnaXJDGumRnB0lg2WUVzTp8BEKRnJcYu81O7TaiOl0rw0rLbIKu4ocOWCDxj1mLqHuPt/WB6RnfDvyShRvBoveAnAelLER6NjOeKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678181; c=relaxed/simple;
	bh=7rB8w6V83K8NHEiFJNT9Xi9facuEdrhPZ83pwNKjBOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b61LMfJgS3rlCgjGPqFLg3Nm0ujC1O+GJdA5f4Feb8dqHwhhSvIEnOgqhAvKcKv3cip3A6Lv5reXgYicEv1g2u+DgPVbieTsEqKD6ySWH6VRA3wSJjzTwVm0RHKDhTjV4aRVfxFuQLxQsCp7OZGeuySFfsgE8LC+7LQR9W+NCQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uO2ONjId; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso8905a12.1
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 02:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715678178; x=1716282978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rrc3cB93ySQ5ey2MwTRFouZs9rlJllYFzqJKP9lCI68=;
        b=uO2ONjIdThUfCstBLvZU29m3CHmzEsXqWqyAVPEmubFRANOc57f05+lDzw35IicnQ/
         8/Ok/2UwSfbYnjZ9QChAlDSUNtUrpgmSzU+qfZoaUxiAWUGOKwHt5EXPhKqKWA/5sNac
         aPy0bMfEJdsNks8gmUMzfELAOmCv8EO5khTlbYpzJS42NV3Xzq7di3GwqVpcb0Q8Hs9Y
         73QDI4xPmpgVR8WWyo9UOfA1k0vY7h7lqbI7X4OAn7cMPTbvnbGmh2b6oi9j45/pLLih
         18SHkchnq1AQwWA9b+22nw3lK1TbtTu1JWqRP6b2Mzrg7WKn3oydBzjpQB52JZRApDLp
         JjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715678178; x=1716282978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rrc3cB93ySQ5ey2MwTRFouZs9rlJllYFzqJKP9lCI68=;
        b=EXvXH8Shw0N/k1AgDGe/AbOiS92s2IbKp+Fvq3pMQzonpn6PwYJONhAKxMU7seKOds
         IA4HcNKu2C6t3jnqUb5r0Fpf505nNhngvgQt+UTiwGvTNCE4CGZLyPNQKB9CfNugMc7V
         RreWo4MaQ1lACpcrMHPe9N4VH58h7FiS2Or7QLKIRr13LQ9gslmB+Ks5bv7VEw4pk5hY
         gRkBSutaPyE8MqcGKVNs8xWY3LC24+qDyK9zlthqPe/6I+UXCCkASUatZu07aVclnafi
         OoBW2gBR9yZWVnAI0aVMZnX/kajBkjMWGt765z9TDnpww+NkDJze+TBT3XKAg2aHiNQj
         /Pkw==
X-Forwarded-Encrypted: i=1; AJvYcCVxcX8MjGHohzg606DFzgvEFPFRwiHxBzFuqHl/Z8J94J6TaTKSffCYU4qOOHZRmUCuwVeLZfy7PKgAGWNPJ4G15UH2AgZq
X-Gm-Message-State: AOJu0YwUYXMYDkvtsbo+EfywO/jPnlu1d1t/HjqFRTvbWOcjcVPO6Kw/
	pj9pRckeJpq0ko21GpX+xB45DKE3oW45aET1wp4xMdTULbBUKR2SV9w/x9fCB60x58VNyjPM8AE
	ZzYA10C8k48ixc4rp1ZOj/7ZgFvp43eClW0+v
X-Google-Smtp-Source: AGHT+IEMA9CuecwBGougNp/hLmSh5IuqNFiWlyl40ICaXHIp1nwfezdzRcYtjQMmGyw7O6JnN3ioioIfQytxLxpxgKQ=
X-Received: by 2002:a05:6402:907:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-57443d4d9c7mr495313a12.6.1715678177468; Tue, 14 May 2024
 02:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org> <20240513-gemini-ethernet-fix-tso-v3-2-b442540cc140@linaro.org>
In-Reply-To: <20240513-gemini-ethernet-fix-tso-v3-2-b442540cc140@linaro.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 May 2024 11:16:04 +0200
Message-ID: <CANn89iJ9t5MYEBh_ztib22Ozz4t50ADekbqShpqQSJb9r5x52g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/5] net: ethernet: cortina: Use TSO also on
 common TCP
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 3:38=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> It is possible to push the segment offloader to also
> process non-segmented frames: just pass the skb->len
> or desired MSS to the offloader and it will handle them.
>
> This is especially good if the user sets up the MTU
> and the frames get big, because the checksumming engine
> cannot handle any frames bigger than 1518 bytes, so
> segmenting them all to be at max that will be helpful
> for the hardware, which only need to quirk odd frames
> such as big UDP ping packets.
>
> The vendor driver always uses the TSO like this, and
> the driver seems more stable after this, so apparently
> the hardware may have been engineered to always use
> the TSO on anything it can handle.

We do not copy what vendor drivers do.

Please send the first patch as a standalone one, instead of sending a
series with controversial changes.

>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 31 ++++++++++++++++++++++++-----=
--
>  1 file changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet=
/cortina/gemini.c
> index b2ac9dfe1aae..3ba579550cdd 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1148,6 +1148,7 @@ static int gmac_map_tx_bufs(struct net_device *netd=
ev, struct sk_buff *skb,
>         struct gmac_txdesc *txd;
>         skb_frag_t *skb_frag;
>         dma_addr_t mapping;
> +       bool tcp =3D false;
>         void *buffer;
>         u16 mss;
>         int ret;
> @@ -1155,6 +1156,13 @@ static int gmac_map_tx_bufs(struct net_device *net=
dev, struct sk_buff *skb,
>         word1 =3D skb->len;
>         word3 =3D SOF_BIT;
>
> +       /* Determine if we are doing TCP */
> +       if (skb->protocol =3D=3D htons(ETH_P_IP))
> +               tcp =3D (ip_hdr(skb)->protocol =3D=3D IPPROTO_TCP);
> +       else
> +               /* IPv6 */
> +               tcp =3D (ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_TCP);
> +
>         mss =3D skb_shinfo(skb)->gso_size;
>         if (mss) {
>                 /* This means we are dealing with TCP and skb->len is the
> @@ -1167,6 +1175,20 @@ static int gmac_map_tx_bufs(struct net_device *net=
dev, struct sk_buff *skb,
>                            mss, skb->len);
>                 word1 |=3D TSS_MTU_ENABLE_BIT;
>                 word3 |=3D mss;
> +       } else if (tcp) {

Please do not do this.

Let the packet be dropped as it should.

Can you share how this path is hit and how you tested it ?


> +               /* Even if we are not using TSO, use the segment offloade=
r
> +                * for transferring the TCP frame: the TSO engine will de=
al
> +                * with chopping up frames that exceed ETH_DATA_LEN which
> +                * the checksumming engine cannot handle (see below) into
> +                * manageable chunks. It flawlessly deals with quite big
> +                * frames and frames containing custom DSA EtherTypes.
> +                */
> +               mss =3D netdev->mtu + skb_tcp_all_headers(skb);

This is broken anyway.   if netdev->mtu is 1500, and
skb_tcp_all_headers(skb) is 94,
we would ask the NIC to send packets of 1594 bytes...

> +               mss =3D min(mss, skb->len);
> +               netdev_dbg(netdev, "botched TSO len %04x mtu %04x mss %04=
x\n",
> +                          skb->len, netdev->mtu, mss);
> +               word1 |=3D TSS_MTU_ENABLE_BIT;
> +               word3 |=3D mss;
>         } else if (skb->len >=3D ETH_FRAME_LEN) {
>                 /* Hardware offloaded checksumming isn't working on frame=
s
>                  * bigger than 1514 bytes. A hypothesis about this is tha=
t the
> @@ -1185,21 +1207,16 @@ static int gmac_map_tx_bufs(struct net_device *ne=
tdev, struct sk_buff *skb,
>         }
>
>         if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> -               int tcp =3D 0;
> -
>                 /* We do not switch off the checksumming on non TCP/UDP
>                  * frames: as is shown from tests, the checksumming engin=
e
>                  * is smart enough to see that a frame is not actually TC=
P
>                  * or UDP and then just pass it through without any chang=
es
>                  * to the frame.
>                  */
> -               if (skb->protocol =3D=3D htons(ETH_P_IP)) {
> +               if (skb->protocol =3D=3D htons(ETH_P_IP))
>                         word1 |=3D TSS_IP_CHKSUM_BIT;
> -                       tcp =3D ip_hdr(skb)->protocol =3D=3D IPPROTO_TCP;
> -               } else { /* IPv6 */
> +               else
>                         word1 |=3D TSS_IPV6_ENABLE_BIT;
> -                       tcp =3D ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_TCP=
;
> -               }
>
>                 word1 |=3D tcp ? TSS_TCP_CHKSUM_BIT : TSS_UDP_CHKSUM_BIT;
>         }
>
> --
> 2.45.0
>

