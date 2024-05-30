Return-Path: <netdev+bounces-99499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E1B8D511E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0CF28343D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9EF46521;
	Thu, 30 May 2024 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2pyHE8k9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0518757F
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090734; cv=none; b=hU6P7fghCLYdR4jYEzKcCfXmx9ce5cJYFK9ao6bplj5+mwlHo5zgTOmgCSn/KDN/0ZJrRPzSTah4isCDyRZt2nJWXwf2mh96wRPp8W080tfOTO6F2Lv+Zh65aO9V/U4GFHXU7szXRd5nt2z+g1taWx7QMJS19ri/s+jrDUfziA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090734; c=relaxed/simple;
	bh=mi9zV5y50BYmzSatp20dGoOtZTzkd3IYofryuQjtfkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fU6r9M+PtVJ3mflBrE00fcAdQ3yMEOInxGSdMgeftHcoGynduyKiSU+O2MXz8BhV3M2c+GH7FFr6Ydpho/JmPiafqlG1rJMwfwQDTRqA/JzqBMlJipICz7OMYk74vT+ia2nCprSH+tuyI2bE9Zy0McfpKIFWsKDHHNpFLEMOzcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2pyHE8k9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so1613a12.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717090731; x=1717695531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1Qb7akEq5yCmelTDmjxq7mBISC0Z5mjD3Lgkgcz6kw=;
        b=2pyHE8k9b+slg0RTrs04Dr+maRnN80IV57RQgQlFWTFWIZwDd6o8qR/Fu9QMOL9DKN
         Dt4VRUH7OVbFvlsRek5pigY3oW9TI/qibimwyGnLcjCJKeVDFHl6MmBJfD1Ov4cwqFpK
         Kr14VmEIpZSGx4vITBNRI+4qNPBkIWTS5SZa1R09zMajLjb2LQeUMaj/d3WCbWuEpLWz
         dj/0m6G2RgUz4QSYzEdBlNhFUEuHt4dkrJpbBMxilVeEV7ugdbkd8qXAcgO/UOKBDWWD
         XEJMBy8gdoUifOJUb8RNyW2Ijx+MN8sbDmppMtF7rxvyanF2OsrAl/Dq5CZY0l93lemy
         g3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717090731; x=1717695531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1Qb7akEq5yCmelTDmjxq7mBISC0Z5mjD3Lgkgcz6kw=;
        b=T0oiN2mLom6FvYFN3GwzuUJ6Mkh+VAbLK97DOOtlwnZP4I5R+2wg7swmgeOJkcCT0Y
         o5efOdrx0IX0sjrr5w5ghLwpDcy6gXAPvW5vfVkNPSOmHqbu9aMNPfOJElp6wfBKxnoj
         DHiUhZWW4e++iuLh555qXVfBPiTReEATzZ2/EUjz3et269AC8h32KA8+0IrCOlXlnINq
         UBPJczeHpkggDIDVQNZ20hYG4mwEZaBSaTe0RL+QgrJaU+YDg2KDdTreLHPx/olByxpn
         lVOlxaUmHJ18ByA7Qef4cDVlp92izHlO3QT3xWsA5MJ7mZPRdm0nCiCPhi27nSVJaEj2
         iyCw==
X-Gm-Message-State: AOJu0YwVT9aw/RGGM8+38SkbiWz7bGlXQoXS6wmi2igN5UvFUT+3cTMl
	2lwB+NOFAzO017ggXUSiF+ognrHm0LsqaQpQz6NpHDpYu1W7B47lrm+SyIYHHimnKMQVtRMXg0S
	X4pPmRpzCjTu0/mpPzn0pHInp8T4V5M9eDZqp
X-Google-Smtp-Source: AGHT+IFfBLLIwisiQNM9r3xLxxbuwPZQAO+IdpMQxPWTlVp2BJtmXBRmHrZyszeSziU893PnpKJrDxd5ptqkaabDiSg=
X-Received: by 2002:a50:ee87:0:b0:57a:2398:5ea2 with SMTP id
 4fb4d7f45d1cf-57a239860f9mr138520a12.3.1717090730693; Thu, 30 May 2024
 10:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717087015.git.pabeni@redhat.com>
In-Reply-To: <cover.1717087015.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 May 2024 19:38:39 +0200
Message-ID: <CANn89iJusnd3fEr5U47iOPmH8joRohOcD==Q4vVLrM+c808i0g@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] dst_cache: cope with device removal
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 7:21=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Eric reported a net device refcount leak and diagnosed the root cause
> as the dst_cache not coping well with the underlying device removal.
>
> To address such issue, this series introduces the infrastructure to let
> the existing uncached list handle the relevant cleanup.
>
> Patch 1 and 2 are preparation changes to make the uncached list infra
> more flexible for the new use-case, and patch 3 addresses the issue.
>
> ---
> Targeting net-next as the addressed problem is quite ancient and I fear
> some unexpected side effects for patch 2.

Thanks Paolo, I am going to test this ASAP.

BTW I found suspect dst_cache uses from lwtunnel in the output path.
AFAIK lwtunnel_output() does not block BH.
Either we change lwtunnel_output() or replace some of the ->output
methods to use local_bh_disable() ?

If BH is already held, I do not think
preempt_disable()/preempt_enable(); pairs are necessary.

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 7563f8c6aa87cf9f7841ee78dcea2a16f60ac344..bf7120ecea1ebe834e70073710b=
e0c1692d7ad1d
100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -351,9 +351,9 @@ static int ioam6_output(struct net *net, struct
sock *sk, struct sk_buff *skb)
                goto drop;

        if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
-               preempt_disable();
+               local_bh_disable();
                dst =3D dst_cache_get(&ilwt->cache);
-               preempt_enable();
+               local_bh_enable();

                if (unlikely(!dst)) {
                        struct ipv6hdr *hdr =3D ipv6_hdr(skb);
@@ -373,9 +373,9 @@ static int ioam6_output(struct net *net, struct
sock *sk, struct sk_buff *skb)
                                goto drop;
                        }

-                       preempt_disable();
+                       local_bh_disable();
                        dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
-                       preempt_enable();
+                       local_bh_enable();
                }

                skb_dst_drop(skb);

