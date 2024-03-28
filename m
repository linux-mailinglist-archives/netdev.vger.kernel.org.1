Return-Path: <netdev+bounces-82816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A727E88FDD8
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6179B29866F
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D197D3E3;
	Thu, 28 Mar 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jcm+N0+f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49097C0A9
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624369; cv=none; b=RqHiEqvKienTSs7hrOr88rgMg8evZww5Yi0WGaJ1G5Fwou9uhwDtr5APRw9UFPQk6bDfjxtW7ChJLO7o/ACM8HbAhSifRbo6COM2fSVAZoKkiIms2BXtiuix8o4xdpkg6RENj/16PvIs8K+2dCOw+GrZtdGGzMm+3IlYmby9DC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624369; c=relaxed/simple;
	bh=u+g5JV3dgjP5NYQzQsQ7r4GLVqTCrbDI+EJT794pShc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttmiXVqAM5BcKzdDTdwnQxNgwXwY05X016zLigjj6fftZfs56phrVvi+Rb9HZOpgjCfFQD5STrutp4/k4WJiFGdAiKJdpJQjNoHUJBiGHLWaMkW+dna8TcGmlhw0clkPFniQGqbMBhMjXxysT6SVxqgtJU5ceryp3pnVikWtMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jcm+N0+f; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so8517a12.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711624366; x=1712229166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXkJgYJkm6X6atjbKwYYosHGwuHpFWHulFgrfAukLyU=;
        b=Jcm+N0+fS1NJUwK4kY5DS6i6xEDP/oml/VNNyCovsTxYq8sUDHiseL76hNudIAEJbP
         SNeUXGhQhmuJCbj2SSRqiPEs0SE96m6NmK3IlXq8p3s9FuvezztecjAOKKD5okBAb4Tm
         0T1Td5wcL8xn3+PNQqa0oFQkJXXcOaaYICcmWwX47Xn9eWvSzgDnInigl8xXQJoKWwp7
         C+XsRhxQsSwgCuE2iQcEF5gvGH8MCSB6UvCT+Ue6t7wnAd5Wqr7NTeKCfoWp4nHpJurJ
         bDXZiRVuWwiM3leWW/jibok98JfpjiwGLGIhwfckurkGr2ijkNfJfhGyLQuUXE5i51AM
         egrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711624366; x=1712229166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXkJgYJkm6X6atjbKwYYosHGwuHpFWHulFgrfAukLyU=;
        b=VMl0LJw0frMBTHgVh/del9UpmNo/LBte3XA619Vxk6p0n9Mr6po0l3qTFnwbyqA6a/
         y+1FVdsa+2Wyr0lDjImn7SEnARhl3tXRn48ri5EmxRLkiU1wAKmlGabmkWcTyszf6qfU
         iVMcY2i4Su6t/r8YEoFXLfp89/R63m6oeQw8fbxUhDmner3633YBHb2WoOR34NJKx5dM
         vkZElz5reazbFK5MrEd9Pi4n8cnnf+MHVzIa6i3ui98nKbwL7hehl2y+nFYzWhh0Ne1m
         HSvGKz/pVS4ir2k0zhcso/KpyxFm9EiP5184Xrxd/ppOhbnW7hR8L4XbanHqk7mnV/ck
         07ZQ==
X-Gm-Message-State: AOJu0YygOTFoX2udAkupPx1E+HsNzF90jfSCiZnuX22ZUZwwYCDhRj14
	EgnlpJ1cfLNy7J10u60nbdLb4EPnGHRtRFn8Ezmt+67CjGIMLbt8RSa5wnTSp0D1tSXUeJ4XCOA
	jhPxaOkDBjL5bYohvogsn9ZAmvXfIKDs56Od1
X-Google-Smtp-Source: AGHT+IE2IWpmmEWSV5xIvMQMwum/x/Xee9Znpdiw242Hp6MVfJFgVinhO7Q+xp+2iSYJjTAD7VsBpIMbYkYYj4BgVC8=
X-Received: by 2002:aa7:c3c5:0:b0:56c:3260:a698 with SMTP id
 l5-20020aa7c3c5000000b0056c3260a698mr175406edr.0.1711624366005; Thu, 28 Mar
 2024 04:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328110955.1026716-1-edumazet@google.com>
In-Reply-To: <20240328110955.1026716-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Mar 2024 12:12:31 +0100
Message-ID: <CANn89iKU=5ht9u398f5cK=eEb_SVCJHQeah0yV8oqO1nrKNK5Q@mail.gmail.com>
Subject: Re: [PATCH net] erspan: make sure erspan_base_hdr is present in skb->head
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+1c1cf138518bf0c53d68@syzkaller.appspotmail.com, 
	Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:09=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> syzbot reported a problem in ip6erspan_rcv() [1]
>
> Issue is that ip6erspan_rcv() (and erspan_rcv()) no longer make
> sure erspan_base_hdr is present in skb linear part (skb->head)
> before getting @ver field from it.
>
> Add the missing pskb_may_pull() calls.
>
> [1]
>
>
> CPU: 1 PID: 5045 Comm: syz-executor114 Not tainted 6.9.0-rc1-syzkaller-00=
021-g962490525cff #0
>
> Fixes: cb73ee40b1b3 ("net: ip_gre: use erspan key field for tunnel lookup=
")
> Reported-by: syzbot+1c1cf138518bf0c53d68@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/000000000000772f2c0614b66ef7@googl=
e.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/ipv4/ip_gre.c  | 4 ++++
>  net/ipv6/ip6_gre.c | 3 +++
>  2 files changed, 7 insertions(+)
>
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 7b16c211b904473cc5e350aafdefb86fbf1b3693..56982d6fb0cd6c39a0e769e13=
0fd47460873b0d4 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -280,6 +280,10 @@ static int erspan_rcv(struct sk_buff *skb, struct tn=
l_ptk_info *tpi,
>                                           tpi->flags | TUNNEL_NO_KEY,
>                                           iph->saddr, iph->daddr, 0);
>         } else {
> +               if (unlikely(!pskb_may_pull(skb,
> +                                           gre_hdr_len + sizeof(*ershdr)=
)))
> +                       return PACKET_REJECT;

Sorry, I have to reload iph at this point, I will send a v2.

> +
>                 ershdr =3D (struct erspan_base_hdr *)(skb->data + gre_hdr=
_len);
>                 ver =3D ershdr->ver;
>                 tunnel =3D ip_tunnel_lookup(itn, skb->dev->ifindex,
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index ca7e77e842835a6d153891fdca7dc8f196e0a2ba..c89aef524df9a2039d223fd2d=
d7566a9e1f7d3f4 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -528,6 +528,9 @@ static int ip6erspan_rcv(struct sk_buff *skb,
>         struct ip6_tnl *tunnel;
>         u8 ver;
>
> +       if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr))))
> +               return PACKET_REJECT;
> +
>         ipv6h =3D ipv6_hdr(skb);
>         ershdr =3D (struct erspan_base_hdr *)skb->data;
>         ver =3D ershdr->ver;
> --
> 2.44.0.396.g6e790dbe36-goog
>

