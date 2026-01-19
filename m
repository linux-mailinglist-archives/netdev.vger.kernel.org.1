Return-Path: <netdev+bounces-251197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEA8D3B4A7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CD21300C621
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8E9326D4F;
	Mon, 19 Jan 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dwa+jPfv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80C324712
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843079; cv=none; b=tUF/7tN/Uh4+zJAZcN+5SKs7yDe+a8j4n82CUoMALl0QAyj1X/y6+aIeJ2s9nRailFFNERckVYJEp9D6sDxKJ5Vosx1LdvgsjvMAp4tQIfSxzTNjVSY6G6A4ldNS7VpmWe3vpFfTgG/I4D5l8ybio7UQDGnrO1O7HShtQqui+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843079; c=relaxed/simple;
	bh=ADvx/vtkJQObKzKCefW3y94i48pRPTxXZghaI4g7rWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0uNTdgtPRDYS4DArNzMoKnRmOzrR3iF10wdk/YP5n8YO+Vym0SME+2Yt6+tqxI9hIO5l6B+ScxNMyIw1Mm6shoKpxUj4k/Wl3eVrXecJaWx9pG1VZ4Xjs80t5L2zhBakIjwYq9cgL2FSEb8Z8GqU2Fbjhq7xbFSylWRYrfYTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dwa+jPfv; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-502b0aa36feso19175871cf.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768843076; x=1769447876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UN/1ZXBVkE0YCxV+8LGTP1CpvjdUshk+ugxYnLOMxIs=;
        b=Dwa+jPfvDN93FV4MmW94Yz4BAxkXjFro1xSFl2vd8t/J8aIbmiXXagAbIxFnB91DVx
         HNT8KjvuGq7h6MpArJOXq6eUFLVCz9H+Jopc9IKwgVdYfSO1AHoM70Q4+XA4lW5Kub5f
         RRLR46W9U+VizNjjsnxzmdxycjclXyVzSJ0S+qfm7+S0XqHw53dG1LwzY2b5uaoXLxFs
         /j/0Wh5Fi/LyL75n3WOaCKpsYfbvvHcrwpSKisb/GW7qFs6IUjkft5uh3djeXyLFYdh3
         inUHSkPngGlrNMSbTS2H77ntKR0ALsA183ZLXgRjRsWxYMKBgFk/9LL33/Xjy3zn1crj
         7a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768843076; x=1769447876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UN/1ZXBVkE0YCxV+8LGTP1CpvjdUshk+ugxYnLOMxIs=;
        b=SZGzBmlG/RrjGZL5h8LOreux1W/JEsSHyEuuYQ3gPeUAlvhjP+F8+7r39Bn5Wgz3X8
         hofIC5kRa1EBkg/WATmAMriZflVf2dp/WtS79t+FTyfxj5q1DhZO5hJprnREVuMlM2xZ
         MVcJI5IEMxDhsbs1HrVLaq3VMeoZBlg7Eq/wALlCfaCjcZAC3ifRpslvi/giNRyBliSt
         6dIDPK+ZR3tGZiRyBFlfPNxe9/3E8+USPa+j8utWAX4G7Kgt2iHaD/GyyS8utEaSa02o
         n9V1fut+9RgHaXhj7DKIFJcex9XS12GjF1IoJ9SgTHb78o0HVJu9PSVLX6KpJboGdG35
         7+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT6KK+jdm6nxN91+iix6a80Xr6UIQ3/m/imS3Iq0mcR6XZ2GFmn1FWoRkoJzECAwR38nHfAJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlEHJPqhTVA6zv+0IBuWnG4TTA9AESQCsWTLFYXbgZNNbR6Xt
	c4YBTo1blB20NypvRihDTCq+84wDUy2WOwNw06z3vIUO3NV97Ex4Cs0X2tFG1f574EJ2uiF4LZ4
	yxckSK+o7iWpFPk19GeDnVA2JyE8Nz0bd8wTIPNGl
X-Gm-Gg: AY/fxX7fjSX2DVA0p9kfanMe30Tj8S347EoQDV7BQRQiDVcaBMKWRNG8bocNt8x3YY2
	zybbs0pJQrTY5WSi85sAOm9FfPouq4O738Ft8NytM1H5CBQVieSP91+jr7J4Jbhho/NUBDgVVMf
	93A6I83dt+F5o8FSfALp6z8M5HcLFOhO0IyTRZVRxelvV/WZ9wWXJYW3eibycIzN880rDZhELHW
	YImbP38atoKdyFEggtX35YHwK4v3giJOydJhowPy0PzI8Z4ieGHFUta9s7NYt4uucxvfe+V
X-Received: by 2002:a05:622a:413:b0:4f3:4b53:a914 with SMTP id
 d75a77b69052e-501982dc9f0mr215552691cf.9.1768843076064; Mon, 19 Jan 2026
 09:17:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119112512.28196-1-fw@strlen.de> <20260119090629.20d202e8@kernel.org>
In-Reply-To: <20260119090629.20d202e8@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Jan 2026 18:17:45 +0100
X-Gm-Features: AZwV_QiqHWKN3sEVuusxtOhhrgwgF5YU6jgo4I56r-kpc9W-dTXzNXF7TB_IiBE
Message-ID: <CANn89iJOz_PQ_N4e=FS+toEDfLw-Ei9SwV6LU9Jmsvhtyxb7SQ@mail.gmail.com>
Subject: Re: [PATCH net v3] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, davem@davemloft.net, 
	Mazin Al Haddad <mazin@getstate.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 6:06=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 19 Jan 2026 12:24:57 +0100 Florian Westphal wrote:
> > From: Eric Dumazet <edumazet@google.com>
> >
> > I added skb_vlan_inet_prepare() helper in the cited commit, hinting
> > that we would need to use it more broadly.
>
> I _think_ this makes GRE forwarding tests a bit unhappy:
>
> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2026-01-19--=
12-00&executor=3Dvmksft-forwarding&pw-n=3D0&pass=3D0
> --

I was unsure about ip6erspan_tunnel_xmit() change, I think I started
full tests days ago but probably was distracted.

I had :

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index d19d86ed43766bbc8ec052113be02ab231a5272c..9e214c355e6ce15fa828866ae20=
fa8fe321b4bf7
100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -881,7 +881,7 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *s=
kb,
        __be16 payload_protocol;
        int ret;

-       if (!pskb_inet_may_pull(skb))
+       if (skb_vlan_inet_prepare(skb, true))
                goto tx_err;

        if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
@@ -929,7 +929,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct
sk_buff *skb,
        __u32 mtu;
        int nhoff;

-       if (!pskb_inet_may_pull(skb))
+       if (skb_vlan_inet_prepare(skb, false))
                goto tx_err;

        if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))

