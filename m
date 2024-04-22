Return-Path: <netdev+bounces-90229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA9A8AD338
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 19:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2051E1C20FEE
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321D0153BC9;
	Mon, 22 Apr 2024 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo8loNqB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB27146A6A
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806259; cv=none; b=CLeIlbRnBOklioFd7QmuX5omO88aXV/fYccC2ihSbJmXOZf+S1aKu8v6gjuDJv0koJGnTJFjk4Jjx9SQzUthmNwdFPjtAchHC2cSoyDksFKZL4PRq1Va847zTUDcSgvyPB4zuJ1d6uPcl6Tx/WC6HUKaTh3uI2bHMGGDHON0G1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806259; c=relaxed/simple;
	bh=3nJ6+hZKfHxCRKFyn7lieKLntV/eqdbSRDmmg5CaoGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww2ZjHHbPbIHT685pTvsqi0H3IfINsXAkkSyk8aZTyD2YdCpGk2OQVZCZ7c09mTqgflpHNqIGTRCwsv1Bfx6d8bxvOxBcaHrYHje5GoaP+ZYcuF4X3LHGkTO/HfhBUjphqG2Ot3nWsxTqF4WSwbUd6ew3MziAAWMg5qohlkwMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wo8loNqB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a559928f46so3040827a91.0
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 10:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713806257; x=1714411057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GfkfMM0Gd7QcKtCwQ7pRhrklxD1aCU/CWRwllYd5MuI=;
        b=Wo8loNqB9blsVRqGW66reMxcGXJH6ba+07R2iNUNoJiYZ9zN0yyV32ZaMclM2DDipi
         tCkpD5ZAL87ZpGB7+9eot3/lrvDwGrnQi8LApK1598Abls/OA+FJWrD9kLxni4RIKPJ6
         alA9gb4UcbOysiIJP1QxD3ku8e0mAgAFRFMh3wccNe4VFoGPy7Th5WWuoODKk5+TyTZl
         Vo5fBzVNRDW9+ITwWDZIBtT92eLudYUKPG6OY6w8D0wHdoazZCf6bK7p5drdyCWrj7zY
         s0VYTiaVL9xtvcdWABf7oTZ9Gt7Z1zoEH2B6s6sN5LhLrmz1Lj83ubSanwebQwReV8Zx
         7xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713806257; x=1714411057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfkfMM0Gd7QcKtCwQ7pRhrklxD1aCU/CWRwllYd5MuI=;
        b=vNk+vqjdRngkVPfM2GTIqvIf/T+7Qlq3eatSYck++yJvOBI2KY6QYI79RvYkryE79X
         /b+ZGtyt6HqVjb6aakHxOVtpZlSCAIWJksNiqQvj6oHqMebORWW3Vt0B9VhHfZGnA3jL
         +1Ca+j9vKR0UZNL58D5dk/RIGYKJ6FWa2iYEwaaw09nrqmE8YKC7l8t47gYhi/fw9jva
         tUJJz0CKiqiD7dCpwAuNfe8zkUbpD8V6jCLbAoq6Zp35wh9ek8mlY3FmQjQH8dH1ZPXV
         gIQaclnDaiGuunrAetSlDqeAew/mzUpQmUAeyvuZQVeMjneYdmZd5AAj0TwvFoViLlT1
         m8Rg==
X-Forwarded-Encrypted: i=1; AJvYcCU7TBBU4I9LpZNVAGp5a/kMw7vuyO6SsK/YRpEl5YUt45rTRv4ffZANlyorknMMJcfNoBdzekFK1wv6X5Z7nMzDO7P6zvAq
X-Gm-Message-State: AOJu0YwEh7TY/UmGCqwYW3s2V4HUL/X+CXxlOQGY0edHoepH9seCPSb8
	ja/WNkqrEQsYXfj/vaYyVofb13HZg9H5YQTAK52hTXsN0tII+4SHWpTL8lb2L1VZweMZ+m9fRqP
	TcfOLhsLt+ZWwc/X7Bco8aqFKk8Y=
X-Google-Smtp-Source: AGHT+IGPky+Vq52g9Z2lHtIKPek4u8RvACyM+G9UsNqAU6wtPgV9tbVZqORhjep+U/OtFKqHjFR3kR4uAFEmvwVpMck=
X-Received: by 2002:a17:90a:d990:b0:2ab:ca7d:658b with SMTP id
 d16-20020a17090ad99000b002abca7d658bmr8889234pjv.4.1713806257020; Mon, 22 Apr
 2024 10:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZiYu9NJ/ClR8uSkH@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <ZiYu9NJ/ClR8uSkH@v4bel-B760M-AORUS-ELITE-AX>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Mon, 22 Apr 2024 18:17:25 +0100
Message-ID: <CAJwJo6aYsC9yDWLpuyPDuEObVk3sxeRgOmoJgRgwwn-7OBKH3w@mail.gmail.com>
Subject: Re: [PATCH] tcp: Fix Use-After-Free in tcp_ao_connect_init
To: Hyunwoo Kim <v4bel@theori.io>
Cc: edumazet@google.com, imv4bel@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Apr 2024 at 10:33, Hyunwoo Kim <v4bel@theori.io> wrote:
>
> Since call_rcu, which is called in the hlist_for_each_entry_rcu traversal
> of tcp_ao_connect_init, is not part of the RCU read critical section, it
> is possible that the RCU grace period will pass during the traversal and
> the key will be free.
>
> To prevent this, it should be changed to hlist_for_each_entry_safe.
>
> Fixes: 7c2ffaf21bd6 ("net/tcp: Calculate TCP-AO traffic keys")
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>

Thank you,

Acked-by: Dmitry Safonov <0x7f454c46@gmail.com>


> ---
>  net/ipv4/tcp_ao.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index 3afeeb68e8a7..781b67a52571 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -1068,6 +1068,7 @@ void tcp_ao_connect_init(struct sock *sk)
>  {
>         struct tcp_sock *tp = tcp_sk(sk);
>         struct tcp_ao_info *ao_info;
> +       struct hlist_node *next;
>         union tcp_ao_addr *addr;
>         struct tcp_ao_key *key;
>         int family, l3index;
> @@ -1090,7 +1091,7 @@ void tcp_ao_connect_init(struct sock *sk)
>         l3index = l3mdev_master_ifindex_by_index(sock_net(sk),
>                                                  sk->sk_bound_dev_if);
>
> -       hlist_for_each_entry_rcu(key, &ao_info->head, node) {
> +       hlist_for_each_entry_safe(key, next, &ao_info->head, node) {
>                 if (!tcp_ao_key_cmp(key, l3index, addr, key->prefixlen, family, -1, -1))
>                         continue;
>
> --
> 2.34.1
>


--
             Dmitry

