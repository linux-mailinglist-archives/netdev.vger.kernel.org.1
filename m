Return-Path: <netdev+bounces-169815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984C5A45CD7
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26134177789
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E80B20E31F;
	Wed, 26 Feb 2025 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zVK3tAAg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F01632E6
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568421; cv=none; b=dQVqlrf3q+a/GIQ4WDUBQjjt50DP4o9O1YvsupK5JkA5ttj3FOedIeTadLbY/E2rd5LAHH2ypMOieC5j9zruk7FKYHAXNxxADGHTOrZSYWD9/GHO+dtFQ1HXr3LiQ4dva/gX/v9Ba7xt7hy3STTQxZndaFEchvgliLD/muKNW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568421; c=relaxed/simple;
	bh=BR0KAThpEksuO0Zdxp6bIrwoIa/tcVke/tqVtFYFjng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkRcQ/Zu0Q6Zr8l+S+C4gsS0NQScygT92SC81Ix3sbNtip6eFNlnoST+UPJpIcetOvogiNKJ1ssMVbnW077HDGOFH/dgGyyh2HF11GUDIQr2eQ7GG0fy7xAJMNiMynWtD1tu4z10Uj/M9LBxoMvA0yGp3PdJYIfYTd/QYMabCJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zVK3tAAg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so12028647a12.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740568417; x=1741173217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR0KAThpEksuO0Zdxp6bIrwoIa/tcVke/tqVtFYFjng=;
        b=zVK3tAAgJWz168nFc4A/JMHy9FKHIczuXWHvviq7wtPkx+xyPUErZAZENwXnjotse/
         9DhEmsydsivND1USbyvPNEkgWRfkhFsWF3cvI30HudwvDMtACk/Amtt5vJOcqDMvxZev
         hwN4+aBIpFmpNnsEBHCZES91u1XPzPNpogvSlS6draRjXBc4Bwrxy0YHQ+2OVO6lSXH6
         0/yBOu9oeqGXlmbkgs41P0gKIeki6Eai3VF0LOdLVuA3ltC3ctg3VMNst1uitmdXsigv
         pi3/D5Eie3gpbkre6cvmshMBylIBJ38rRi5s/YsTpr98N5QkXE/ZO7Tj8UZbe2s6V3Bx
         hgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740568417; x=1741173217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BR0KAThpEksuO0Zdxp6bIrwoIa/tcVke/tqVtFYFjng=;
        b=vILVuIBvsi1TcI0EF1Tz9sTia9A/DFuPVHGX7Brma/LhGHHIhThYDS1YdKgNrMs30e
         51DeYw3qNF014NEGeP8lcdG1ucqmK9h4WiRzb2+IvH3QSz8rqeB/13nR+MataRMQdm5R
         4TibBHf9a/ZD+l5QFJP4IcVa7tzQ8NEdBi2C7IfMwjdNsfcvHmJwlw/WHyKJ7LyQoP6e
         z94YuWyZ6EU1QqoG6y5fP/F6ssGBMD3M5LrDitkzx0qGCsuf0w/mHqVtEH1SM5YlpGlp
         cLPkRWk5MHfY8ptKxEsLbCLCdUC2fm9GaSISKY/FmHyyOKmtH8Q1FPk9lYmvZu5YMePp
         1X5g==
X-Forwarded-Encrypted: i=1; AJvYcCWQwkE1CdCiHaYcB9/rThlzPlAIWao+stNBR/skNy3Tj5CvY0zIDM9euWqprYNFiR+FUhfRKfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxh9k2uKNB58ra7aE9bp7liV3cWsY9UD9hvm/qBaHXKVIjE1ky
	71H+Tr06qaTFXG56hUxwXPOQpe11T99gikQQv2ZeiQKGINxfN53fzmYlEEJUirjb/4BPFlCTRZY
	mjDOVs5mol1NYUetHUcMGpeDWJnMaL9+UTNhK
X-Gm-Gg: ASbGncvzJswzWWMCWpVujve9/csfBAwTLjaYK8UDyfswFM4g4DXsCxgLIBHOXWhHfGb
	U0VDuodduOPHw3hKttqPfs581cVbASiqx1CUsXi+LsGnsExWshRmQyHAKOoGiATQuHKXsUM9O/a
	/LkGw/EsE=
X-Google-Smtp-Source: AGHT+IHuoWtVo2XweZv3wSmKmkLv81mqas4sodkL8k0KUw9/zgTFDXMoArultwDS9uiqX4U7Pq3pyJj5ilG4w64Vs3Y=
X-Received: by 2002:a05:6402:13cd:b0:5e0:8261:ebb2 with SMTP id
 4fb4d7f45d1cf-5e4a0d71c4fmr3459376a12.12.1740568416668; Wed, 26 Feb 2025
 03:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225182250.74650-1-kuniyu@amazon.com> <20250225182250.74650-5-kuniyu@amazon.com>
In-Reply-To: <20250225182250.74650-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 12:13:25 +0100
X-Gm-Features: AQ5f1JrerZRWk9L93PvMeSdTUvAGNroFHU0RoRYB02CNiz7sxM2Xm4Qiim9gE_s
Message-ID: <CANn89iJXmQaZ7Ar+HGx1eZuH9TQwZ_BhVYEhgwE6re7uU8Dteg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 04/12] ipv4: fib: Make fib_info_hashfn()
 return struct hlist_head.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:24=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Every time fib_info_hashfn() returns a hash value, we fetch
> &fib_info_hash[hash].
>
> Let's return the hlist_head pointer from fib_info_hashfn() and
> rename it to fib_info_hash_bucket() to match a similar function,
> fib_info_laddrhash_bucket().
>
> Note that we need to move the fib_info_hash assignment earlier in
> fib_info_hash_move() to use fib_info_hash_bucket() in the for loop.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Nice !

Reviewed-by: Eric Dumazet <edumazet@google.com>

