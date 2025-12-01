Return-Path: <netdev+bounces-242960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A667DC9738F
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 13:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBF80344E15
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 12:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3377230BB8C;
	Mon,  1 Dec 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0weWGSb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6375030BB95
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591686; cv=none; b=NGApUUcmTBuXR7vaQzhLsdJWCWFMFUvSxUupsuyNQWhX4u6UIdny/RtIlig1rlFtrOnyilnhTqmsl1WsRDQ1jdJ+fkyAFgDtILczUIVGHNiCKajcl8/RlsgI2qvsGvlx/1Qe0OSCchqWd+yes09f0rnOxO5Y8RDst8IF3Qm6wi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591686; c=relaxed/simple;
	bh=yFz5w6YuNoKDAlcwaV0adz7wHb0Pc+rSdGZGyZU3IbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sl6oT+ybF62++XQPp7dtuiz+MllollRaGKaP8E6GLtguJ4IgRGJIn2dYgWeXPrUQgG23o/93ecz7FtxGgDVX/I3PR8fV6aU1CzhAn+hTwtp0zfOzG6iREo26E4iLJdQr88UGrBB+0Df8ikSVzjBYMrxxAMgo8qCi0XBlT+pW4dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0weWGSb; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so38918201cf.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 04:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764591683; x=1765196483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHSqneXWA/+e/VX0oEH2ml6TjosRQ2kB8OsriSGB1x0=;
        b=R0weWGSb1Wil0Xhr2AMg2TABsf5y3StQUHdjMFlQCLB6o40moiU8fHY92rkLRuIHsM
         v8K3vbFC3jB+jSgMsdr45aFvBVoxFVTVoAWwXXtITUEFq6x5pUNpblGJ7AH2NTtA7EB8
         GVfdXbTznZgRgBz1D6DHa6tT/gnNJiqlTEkZnNYP+fZ/CqBEfmdhlDlItb7dwjANf3C1
         88945tLcuVvRYh9WM5vDqDWIWZAbBadIKNm19OkpMwiPZFYDbMLsdajM8M/95rGtr/8O
         PZZlLlJ5SvV45/e3LJm9B2xfXVhElkRTqVvAlIrV59rT7Zs1l0YcVYcvo0HH1e7Rgq/V
         9doQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764591683; x=1765196483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lHSqneXWA/+e/VX0oEH2ml6TjosRQ2kB8OsriSGB1x0=;
        b=Q+XRosU+TGOIH3Ti9Idz1WG8zFEN7kCblABmxnF7eSdnyk7oVvE4LT/G/ouJ7lgQRM
         oE3/TMby+OplQ7DRZ+fMbZlXXpwGCkL4zyV9fT20c374ameqnw63qk4s4Kdiek4GlfWQ
         I/nxu3qpEqaY1ZaiAKgJOifcNlO+3/MBec6R+YjcpMz2of7rl9rea0rfGCMM1WDgawXL
         OQyCq8z2DzhuNn6wbsh0m8ztOXPWwmyZCiAmLyS6x2t91paJAmFeqkJ+c1WS8qausd9p
         auktBVnvXTJ20wDcpPiQiKi5jt8lWcIdNXLVUfRLcArca2P6OhhrjL9g1RLMZjRTRBpM
         0/SQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Cx2QlsH1VqaoBN8hHDE4/j3aHR1r805TsMiA1CMmVLnQ9sCwG44/hAuyhCvelj16gmQ0VOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3xFOkyhF1IYbSK0J43F6BmGIsweNrlATs5rNs+wV6wJ9qZe05
	mzaUnya6416ESaeP4hcII6W53TrBIeeXkiw9RkC/Lo+5VGqOWsFz3j6n2pyJSgJThMgd+ZKhDxS
	BZGJ94VeWMA7ld5+kqW8fswx2s42q553yVtUbk3Fl
X-Gm-Gg: ASbGncvJecLjEi1SSSN7deKG9vqnIgmAsl4Rwbp6kZcsIL++OXbEaKYkKi8BqjuyzO8
	ASe3jwK9kFL4IfWRuOLID4N6HDLEVqxTYtFbEWgPehPPqDUfcU6Oa/q8B0iyCY+icVF5dfcwzEt
	uGkDCqx6aMflGzzDy7Ox3cXgdCb2J10fNwP9QV3rvDXfTQhcKbuRGiBK1qaoFKbycTkPidj/A6u
	5i4nSga+gwes9yEUvJ+g/AiqDaVGAj0aD+PUJV43tHBg9Ji7uSvN96tX1FMT2982rYQIeo=
X-Google-Smtp-Source: AGHT+IH9eYypkeN98zOYpGsp9E+99suemEUInG07xexLsbvPVRpjPCVn1S17NsmjJ+JrurGEFPKeljMRG5rPSCN7HsE=
X-Received: by 2002:ac8:5f93:0:b0:4ee:12e0:f071 with SMTP id
 d75a77b69052e-4efbda335afmr343293061cf.20.1764591682796; Mon, 01 Dec 2025
 04:21:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_22959DC8315158E23D77C14B9B33C97EA60A@qq.com>
In-Reply-To: <tencent_22959DC8315158E23D77C14B9B33C97EA60A@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Dec 2025 04:21:11 -0800
X-Gm-Features: AWmQ_blG6Z6aHaozr9InEEx8bN5Cx9HWRtVXhn_CY4qP5mLQlVGzSHj8vESPhx0
Message-ID: <CANn89iLW+68YE9s9dChEcQYbmwXSBzWRPzFH50+--Kw3XNZXEQ@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: Modify the judgment condition of "tx_avail"
 from 1 to 2
To: 2694439648@qq.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	hailong.fan@siengine.com, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, inux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 6:57=E2=80=AFPM <2694439648@qq.com> wrote:
>
> From: "hailong.fan" <hailong.fan@siengine.com>
>
>     Under certain conditions, a WARN_ON will be triggered
>     if avail equals 1.
>
>     For example, when a VLAN packet is to send,
>     stmmac_vlan_insert consumes one unit of space,
>     and the data itself consumes another.
>     actually requiring 2 units of space in total.
>
> Signed-off-by: hailong.fan <hailong.fan@siengine.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7b90ecd3a..b575384cd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4529,7 +4529,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>                 }
>         }
>
> -       if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
> +       if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 2)) {
>                 if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queu=
e))) {
>                         netif_tx_stop_queue(netdev_get_tx_queue(priv->dev=
,
>                                                                 queue));

Drivers should stop their queues earlier.

NETDEV_TX_BUSY is almost always wrong.

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7b90ecd3a55e600458b0c87d6125831626f4683d..6dcc7b84a8759763b6471a48a6c=
80b1f17cd937c
100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4675,7 +4675,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff
*skb, struct net_device *dev)
                print_pkt(skb->data, skb->len);
        }

-       if (unlikely(stmmac_tx_avail(priv, queue) <=3D (MAX_SKB_FRAGS + 1))=
) {
+       if (unlikely(stmmac_tx_avail(priv, queue) <=3D (MAX_SKB_FRAGS + 2))=
) {
                netif_dbg(priv, hw, priv->dev, "%s: stop transmitted packet=
s\n",
                          __func__);
                netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));

