Return-Path: <netdev+bounces-96438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBAF8C5CA7
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 23:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639B71F22224
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2FB180A6A;
	Tue, 14 May 2024 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcXru1my"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D189C1DFD1
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721094; cv=none; b=grIwEVPCeUbnn57hEV3duxRQkr3McQJqPgFhlMikZvcjkd1vIJkBWU9NSgyi3+gABq502J9z5Wh9q2X4+7Ac1adLZ4y1hLxXKc2Et9iimVxSm4xPHrOgKA+k6s+wYMoAivDqrV13O8DYA/TND3pNak11XDKYa+zN5eBG1nKDp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721094; c=relaxed/simple;
	bh=OCLHiCxay7TOEqRKdZWqiYpRxBX4fxlZvhZv7VYkT7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eh/f/u7GTzBEXIjszM7dguLMTz9ZSVjsEL4Q+rmEn87AWCv5tDXSL1a8PlM1v+wOr8w+gnnuXDxkSOwukO8Yqy9ICoTresgWFUCh15ilvg9rYM4f6Vlr3gN2o+mK/k4XGtC0x8vc8cqWGej14Mi0cYnCBrTvAP5ZSdxT0uAuvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AcXru1my; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61be613d903so69373127b3.0
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 14:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715721092; x=1716325892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeqUWUBtoU4bMa9Lxi5euIfW3GqIJlQ4EugoOdAtQzQ=;
        b=AcXru1myLbwtaKalc1qfSfDtBqhU+QESZfnXskkf9lg8J8EDpPJHhKpIf526ej3eyY
         ZRcaNb/XPJeaZtNzKVCPuT5by8qtM6F7nHWiTAWIrYMxEJPekYLAr59g+j1DFw8YL67E
         3WrwuwIwaryOXawBSCXKP1Pbl9C0XoMHV0BfSXqRWep4eRbE67my5oLdugPQ87jWECLy
         MOon/0+SfHN2rLVS1HeNGv85Eg9kJ3bk1LPy8vGp/BgIz00IQw7gio/cvwMJNF8KGWJT
         9Lg9A3tPItL8wTtTLTpVyP32UvSLrH44A8BnWu//SCYqUWvs4O4t/LwBI+HrsHoqN8E4
         LO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715721092; x=1716325892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeqUWUBtoU4bMa9Lxi5euIfW3GqIJlQ4EugoOdAtQzQ=;
        b=YcD+qEA7POvmbgE486OczHW1QLXW8G5UeVywNnisDMrQWXzkZMGny15rzEyC3TKgnq
         mIh8yQ1UrhjBjRoEhfsJaOfW+2QLDCxTAYHm9f5OS7Mznbfk+n6/FrPc5KeRMJW+JHtI
         h7UzOh7C1GsfVULsCtHIQunLdoF7SIFX9rdGCDgpYnBJPb33Wtwe0R+lK8u/DG01gdSV
         wuNeEy4UHEYrEgN4PUxbk+hbgwAWnLsOpGNd6OiNzVyjZmnzhABE9KfbrrD9XFl9/iCe
         xn63PAibjv5EI7FZE+ZGhXBUceLnwYIlPuDmdFUidO+pQm4BrW6zW/+njSJuk0i+OIcT
         vbog==
X-Forwarded-Encrypted: i=1; AJvYcCX2XzLsH7SpkoyMZVkxKskHW0k+rh6cdmsFt9awR9rPqJUrcb9ZsfeaZBfV9o+u/pMxp/gDSs5JYG2LOfrtZS+7L2HRikOo
X-Gm-Message-State: AOJu0Yxwpe1T724YdJfN79lohfQ/dCXuuFKGjcpMyQzBtfvavHHEVTGi
	lTpPnoq0TVlVryo/2tds1G2KIMbImcdOiJD156gbOHtG0qfkemKydEHijwI84zYzytScPMqV7AY
	bWGbzhXUaPJ2qwh8YOtiPE7nCNhkBT5nCr/C6lA==
X-Google-Smtp-Source: AGHT+IGqetqyYKnNmlSlwKMNO9V81bSM4JJ5hEqXM/wqOcHGvvnOBBuHY8oWwyn6TkiCGgkyjC88q/62ssruzpaSb20=
X-Received: by 2002:a05:6902:311:b0:dd0:97e8:74e6 with SMTP id
 3f1490d57ef6-dee4f387774mr13951820276.55.1715721091789; Tue, 14 May 2024
 14:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
 <20240513-gemini-ethernet-fix-tso-v3-1-b442540cc140@linaro.org> <CANn89iKX0Gk8J=QVe5JwNi39zNzzfb2mP9tD4E5NLdimfrj5-w@mail.gmail.com>
In-Reply-To: <CANn89iKX0Gk8J=QVe5JwNi39zNzzfb2mP9tD4E5NLdimfrj5-w@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 May 2024 23:11:20 +0200
Message-ID: <CACRpkdYPS7ox=rkAwwF3UCnh-HXqKmMh0CUmeG1QQMLTeQsZ9Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/5] net: ethernet: cortina: Restore TSO support
To: Eric Dumazet <edumazet@google.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:13=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> On Mon, May 13, 2024 at 3:38=E2=80=AFPM Linus Walleij <linus.walleij@lina=
ro.org> wrote:

> > +               mss +=3D skb_tcp_all_headers(skb);
> > +               netdev_dbg(netdev, "segment offloading mss =3D %04x len=
=3D%04x\n",
> > +                          mss, skb->len);
> > +               word1 |=3D TSS_MTU_ENABLE_BIT;
> > +               word3 |=3D mss;
> > +       } else if (skb->len >=3D ETH_FRAME_LEN) {
>
> Note that this code path should be dead, because the upper layers
> should drop the packets before reaching this point.
> I wonder how you have tested it.

It's actually easy to provoke with UDP jumboframes.

Bump the device with gemini ethernet MTU to max:
# ifconfig eth0 mtu 2029

Bump on the receiving side so jumbo frames will be used across
the network:
# ifconfig enp2s0 mtu 9193

Add a patch:

diff --git a/drivers/net/ethernet/cortina/gemini.c
b/drivers/net/ethernet/cortina/gemini.c
index 4ae25a064407..06f2d30179c1 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1185,6 +1185,7 @@ static int gmac_map_tx_bufs(struct net_device
*netdev, struct sk_buff *skb,
                word1 |=3D TSS_MTU_ENABLE_BIT;
                word3 |=3D mss;
        } else if (skb->len >=3D ETH_FRAME_LEN) {
+               netdev_info(netdev, "skb length: %d\n", skb->len);
                /* Hardware offloaded checksumming isn't working on frames
                 * bigger than 1514 bytes. A hypothesis about this is that =
the
                 * checksum buffer is only 1518 bytes, so when the frames g=
et

Ping with something big:
# ping -s 1800 192.168.1.2
PING 192.168.1.2 (192.168.1.2): 1800 data bytes
gemini-ethernet-port 60008000.ethernet-port eth0: skb length: 1842
1808 bytes from 192.168.1.2: seq=3D0 ttl=3D64 time=3D46.127 ms
gemini-ethernet-port 60008000.ethernet-port eth0: skb length: 1842
1808 bytes from 192.168.1.2: seq=3D1 ttl=3D64 time=3D38.329 ms
gemini-ethernet-port 60008000.ethernet-port eth0: skb length: 1842
1808 bytes from 192.168.1.2: seq=3D2 ttl=3D64 time=3D38.859 ms
gemini-ethernet-port 60008000.ethernet-port eth0: skb length: 1842

This kind of big frames is what upsets the checksumming hardware over
a certain size as we discussed in the earlier patches when we eventually
disabled TSO and how I ran into the problem.

> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks, I will send this separately once net-next opens again in
two weeks, then split off the phy stuff in its own series and
send the controversial patch as RFC or something.

Yours,
Linus Walleij

