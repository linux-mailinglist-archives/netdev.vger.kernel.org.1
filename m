Return-Path: <netdev+bounces-53305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD2D802298
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 12:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E331C20847
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5608F69;
	Sun,  3 Dec 2023 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9cUoLd7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA1F9C
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 03:03:23 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b422a274dso50095e9.0
        for <netdev@vger.kernel.org>; Sun, 03 Dec 2023 03:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701601402; x=1702206202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCN0TPEmvd7kz6bn2yXvkGu2UfPcBGCxL6UVnP3vpy8=;
        b=o9cUoLd7MO5O5rbJ9tUNfdXVMWL3FZWkNZVsp6WhPX85pcCMMTFBLhWPNzUl9gumDl
         pCxLK9xZAHgkEDfgnQg2z08jUlc/XBCy1d4U4u5cpjSa+3daEEZAaGCdb7ZPJc41dpX4
         EhrfGaAKAnaE0uiEg/LZnGVng12WB9fc5scWIiNbwXgETSVJgX0qUK18Rc8hdLeUl/hF
         0BrlriZQ5Znuh2KBUCZ+f/SC8AvYVfQ8ECfL47/LimF70OcWniahiOKzbr3QtRk7mvzh
         cRinldanYOIinS7ii9KKwaTmvZc0d0kSyK5oIxGS07h4/RqShhNMehI+Fhime+osFhms
         mawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701601402; x=1702206202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCN0TPEmvd7kz6bn2yXvkGu2UfPcBGCxL6UVnP3vpy8=;
        b=cvQzZNYltfb62gxe95haFXiXGzEI6WITTjbdDa3aRcIQiuDWjfwTFT7im2RJcXjfjX
         6dDRl3hC1iF802X+sb3v9LFiPhUdI/auRJ7rsTsdPuAzfAh0OTND0ukFMHh7F9sRKvTj
         nhtD2MPeqhep75BAVSBdjNqeJ12sOMMe57q/q8p5WSqHdEH6y2JRx+hsU5wq+ETm1IM7
         lG6+7FjqDYaEi4XFA8ZKbHBxau2L9wPOkbcO7MQ+IwSoD2AmkXfA/9jze52mGXptFMRZ
         Pd84k2GohDPA99EY08kGdQ0SXFy8yhQbfyvaonCoi0YcBV3vB0DUmUMcNMTZCQqOi080
         67xg==
X-Gm-Message-State: AOJu0YzQkq0bhfujyLW+MgbtYHA/t+e9eudYOmcaPuOdHVk+LADj7ZU8
	L+tFv0wdKsN8+5kKQxPV3JS4Ryt8p5NMg8S/+AHuNA==
X-Google-Smtp-Source: AGHT+IE0KN4b9aaj2wD7bazxbAvpF1Tq2GT2htP8uJF2FlWkS0/LH9Tyg9iBYM/JWXLWrAZFQzYXC3RCTk2hVy7qttw=
X-Received: by 2002:a05:600c:54e7:b0:3f7:3e85:36a with SMTP id
 jb7-20020a05600c54e700b003f73e85036amr301125wmb.7.1701601401537; Sun, 03 Dec
 2023 03:03:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202161441.221135-1-syoshida@redhat.com> <SJ0PR18MB5216A25BD74AE376FB1E536BDB87A@SJ0PR18MB5216.namprd18.prod.outlook.com>
In-Reply-To: <SJ0PR18MB5216A25BD74AE376FB1E536BDB87A@SJ0PR18MB5216.namprd18.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 3 Dec 2023 12:03:07 +0100
Message-ID: <CANn89iLaCrBGdtVSPZMLM7tnixFfy3wF98aojxkcoXoXEit6og@mail.gmail.com>
Subject: Re: [EXT] [PATCH net v2] ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()
To: Suman Ghosh <sumang@marvell.com>
Cc: Shigeru Yoshida <syoshida@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 3, 2023 at 7:58=E2=80=AFAM Suman Ghosh <sumang@marvell.com> wro=
te:
>
> Hi Shigeru,
>
> >diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c index
> >22a26d1d29a0..5169c3c72cff 100644
> >--- a/net/ipv4/ip_gre.c
> >+++ b/net/ipv4/ip_gre.c
> >@@ -635,15 +635,18 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
> >       }
> >
> >       if (dev->header_ops) {
> >+              int pull_len =3D tunnel->hlen + sizeof(struct iphdr);
> >+
> >               if (skb_cow_head(skb, 0))
> >                       goto free_skb;
> >
> >               tnl_params =3D (const struct iphdr *)skb->data;
> >
> >-              /* Pull skb since ip_tunnel_xmit() needs skb->data pointi=
ng
> >-               * to gre header.
> >-               */
> >-              skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
> >+              if (!pskb_network_may_pull(skb, pull_len))
> [Suman] Since this is transmit path, should we add unlikely() here?

Adding unlikely() is not needed, it is already done generically from
the inline helpers.

Reviewed-by: Eric Dumazet <edumazet@google.com>

