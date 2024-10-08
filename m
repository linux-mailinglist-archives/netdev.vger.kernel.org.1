Return-Path: <netdev+bounces-133067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAFB994690
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C511C22CBC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7091D799E;
	Tue,  8 Oct 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEE4iL7D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5671D3653
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386485; cv=none; b=O4lXdQealn21ebUihRx+FviKe/TCoKepGQl8yRzESmnOiW0mzbJQJmIn+TocFgi+C6K6q1+PLAeaApO/mi2hP6e/qymFfiJiYGrBBH8ybaFO9oxroutltLEOkK/AsPFud3uOIXcKyvfLrr1wWwcttdnjFOFC9EEnD5SKjufMOIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386485; c=relaxed/simple;
	bh=xfU+QL4oYIJMBjTtd3onmHwCv7vshzQgBsh+hft2krM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggtpwIgAyrZQan+kZgMvocOsEHQCCHNc9+Cox/VWTI+l72o1IRE8w+NN7OeCeFDhnNq/hdXOc0UaRxYAUCSXYRpjHtxSqHuYU5B807npoOzsKCWJba0jpGne45ERyxHmHFZKX1XMZVhOtyRmVZhLFG/FzRHVKc4CQU50bByPIrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEE4iL7D; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso75534361fa.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728386481; x=1728991281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npnvrZS63SKDTvS9UgOBWk+GwJ0fvs52L9qXHQeiWfw=;
        b=DEE4iL7DBpZ/KWwcPsstTjULnVhS5U0y+jAHokWuuJLd7mpC8oqJ7IawoIu3luIf7k
         tB4DoQhYsy0vYn+rbXMBrIvFsqUts/x9OB/0bC6V4NzlKN4nWs3gJ0IE0rGn0amlGIYF
         W1+Hkn57OnfS/l5BRkgIDS4QbJiVIIDDApScQQW44SNdMQYRusSg/D2z5eo6IUMtujgM
         JSimm2hFK7lhfe5ZC25T2Y6dUeWHy1Yq2EKy/oH5yGO0QIc1rOo8vYYA+oO/iywA3eUU
         Qwstv++u/bgcwaJYddJbZ14DQgyWPyzVHiIyzXWRFd7nXmtEydVZAnJnvVsKJRRzh4J8
         3RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728386481; x=1728991281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npnvrZS63SKDTvS9UgOBWk+GwJ0fvs52L9qXHQeiWfw=;
        b=M5r+XHYaA8Nwe7GiLMP/d55i7Hz0pxBXmXoLXOeHtj/+DWUDH0xqGMet9K/WIKjT5z
         sBJvxaHVZMLPKJ09cNVevMgdvbqeNGiiN/xRbpcMf2o2zps9bGdKUSsypGaY8fg/nwjI
         +ZrXIV5vpD+MM5urBMBRhy29T0ilZN8M18T2kPQMwCgc0zsbg2SHyr9nng2g3T4hDK2J
         pr/4c3+HjWlhH8L6L7bZHHApIUOJPM02jz2P446WhLsNbBY+uU/NMoPt2kE9y8w5/16i
         LvwSvvCSRRvHoLyFRKQPikwGc5i4Gp2F4VW2HPToAvpuUKU51+k9ct7MRmeqkRV8szoK
         L/ug==
X-Forwarded-Encrypted: i=1; AJvYcCUwnabB68WUJl/AclioSklOvY+tbI6Xv7ejUm9g4VIzOCXZmK8V4QJa4hq2AfniCFdEw5+JlF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxdMSdUB0xMKKBIewKEpW7zw9xhd8X3isW5rR+S6TwKmbQ7Ru
	zTpyNbQVMFIP5GOqcBtyzY0pyISc6Q3krf9S8Qi2uziUvi/BMR2wZDNgf7RnEurCHKNLiaGN9HH
	L8aj6Fp2nlGQGgCOKu+pFMmmuC+fPH8mDtchI
X-Google-Smtp-Source: AGHT+IHCTu7ZGRzfoJP/AQCKUKHAqMvaIdZ/JoqASHRIF4hLTo4R09xHLqJ0UyAf0R9hlHZlNzxAZLxSXh9xuNVAt28=
X-Received: by 2002:a05:651c:2126:b0:2fa:d84a:bda5 with SMTP id
 38308e7fff4ca-2faf3c0c416mr96106491fa.7.1728386481106; Tue, 08 Oct 2024
 04:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004195958.64396-1-kuniyu@amazon.com> <20241004195958.64396-5-kuniyu@amazon.com>
 <810bc6e9-1872-4357-a571-2ed4837b74f9@redhat.com>
In-Reply-To: <810bc6e9-1872-4357-a571-2ed4837b74f9@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Oct 2024 13:21:08 +0200
Message-ID: <CANn89iJKu_ZnkP0WjDXmFQpBKK=LRPvsoPiHiv8hkmoq123K0w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/4] ipv4: Retire global IPv4 hash table inet_addr_lst.
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 1:10=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/4/24 21:59, Kuniyuki Iwashima wrote:
> > No one uses inet_addr_lst anymore, so let's remove it.
> >
> > While at it, we can remove net_hash_mix() from the hash calculation.
>
> Is that really safe? it will make hash collision predictable in a
> deterministic way.
>
> FTR, IPv6 still uses the net seed.

I was planning to switch ipv6 to a safer hash, because the
ipv6_addr_hash() is also predictable.
It is easy for an attacker to push 10000 ipv6 addresses on the same slot.

We have netns isolation for sure, but being able to use a big amount
of cpu cycles in the kernel is an issue.


diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 94dceac528842c47c18e71ad75e9d16ae373b4f2..f31528d4f694e42032276ddd623=
0b23911c480b5
100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1016,7 +1016,7 @@ ipv6_link_dev_addr(struct inet6_dev *idev,
struct inet6_ifaddr *ifp)

 static u32 inet6_addr_hash(const struct net *net, const struct in6_addr *a=
ddr)
 {
-       u32 val =3D ipv6_addr_hash(addr) ^ net_hash_mix(net);
+       u32 val =3D __ipv6_addr_jhash(addr, net_hash_mix(net));

        return hash_32(val, IN6_ADDR_HSIZE_SHIFT);
 }

