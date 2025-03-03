Return-Path: <netdev+bounces-171188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9DA4BCE2
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 11:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA8A1886528
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4FB1EB192;
	Mon,  3 Mar 2025 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQQwPxps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7241E376C
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999025; cv=none; b=N4UIrVS1nY4f6ZD0ItyskeXHUN3AdI0ALUwqySof0jIhfFxR9MAqY3hX1LkRshktgGt7pqotsFnQz35BlXo6QCjqOTQKc1s/J5VxC1ZusMF05XcWsfKZp9gl+PUA+EoIqmV2zfoUB15kDwYtu+dX+AGCKcNWMH8JtKSetaUfXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999025; c=relaxed/simple;
	bh=1NAQ11QPR8QFSoBVQ5tKsmm65Ls0z2T4J5Vj+n5q2XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvo351ns1rCXne3nBPMcspRFa4FoLjhF5bgfDDp0hx5NjKv/SQcRss+sj0fObsBHhIW2jpvDQ2XSRuNNySWxp+fBeDbZlDcSs4ZgFv2C2KhV17xR/ilwDQ6rOSQ6NG2iywFliQ8KIzlIwAi+SpgMquUt3OxlKJrmK4xPIviRUzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQQwPxps; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d2acdea3acso12780355ab.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 02:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740999023; x=1741603823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NAQ11QPR8QFSoBVQ5tKsmm65Ls0z2T4J5Vj+n5q2XI=;
        b=dQQwPxpsa0MlazHh8UaxYYOv842LiAimp2pMoIwUzTgry0pE3ie/82um67n+4eGY7W
         cuzESrG5RQ6FSUjKt1GSkndd5GHf4ckPwyLVwm06ZlrY3p4gx3PBc/YwcxEKZdeyVei9
         xruvYSu+Wxh8JvAGcnkd955ZvpdzTH4zBaGtbtqyNEukydP9Nml+j5Iy5FoIk178J5SD
         NL4GAprdwbBXLAXSdCT6uUDPSzbkm4rsNOAZyg02oACxhQmKhLwol6TUhQqvAifwsLhT
         5VtqE4IZQlatGMs9ehRCZKe0fsCI05X1rceHBEhel9WuB/4bEZHVIkWM2wkhT8IVy1GA
         RL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740999023; x=1741603823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NAQ11QPR8QFSoBVQ5tKsmm65Ls0z2T4J5Vj+n5q2XI=;
        b=iSixIJCchl6/fhkZSOBzKrXdbGubdYJC8e5w9532bIX/XocU4QzkKFvnHfIeQ0wgn5
         r51WFxhn3H9bl/+18RRoDr20hPPzeie3JhELUIsmm+DMKj2bs987aWhRLHlfROBph0k6
         fniaucpRS2eqGEbmFQKCWRQ6z3ium/4WMCA/qf56xucUbnnLkgbVFFoEdf2LhIja6tDU
         8sPN5vHa1F+lzPHnsGuRzoS/AhZ9q4u50/dapL8hHXJpnvNUvHP06btrYq6UBOW7ktD6
         eD0xPNQP76u0pxTslXTzEkc7ZaYajSVpZqd+dRPmw/HiL7aeZwVFuM1R0bkLgvYoEhZu
         JZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCXKFa5ObsIPe2rFmxR/8U+JDxQql52Kyz8MSbR/t/gLGXrh4HL5Y69/DGclTEZ6SXKhU1xcOdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJGQoCof3QTbYRG8q5qFp1C+Q34NoHc7WgPh6Zl5kEirSGiAL
	0gklIKBH5/XXQtY9vDo+pTWFTnh8kGN0UrQDTSgGzNQWQEaqYNOsG89OjZBbe42eARflGAbus3y
	PvYrrRcpdVeW8xWsoh4bPe5u1PZI=
X-Gm-Gg: ASbGnct9YCe3YPaHe9o3SCiYGkfdTVXAQtoSEtzjzwxMKxNbvvFvOsq/uJCHWIMV2gu
	g3PrS0z6KgYM6MPfct8IVYOMlL1ZFJ+qDoG7bvjrCkV8g6Xfd+msksxPJFhksShaOzfnHjijt8C
	WsCEjT4shpfXA5yTi0FjMw7+OZNQ==
X-Google-Smtp-Source: AGHT+IEWDBei9XqPO9VcD3g4oPdPjOOm2A993Cd5mQaCs0NbX/6v5oXLjpZFkGAKIwc0yCfQ2p3310dEqiJZLowvSFs=
X-Received: by 2002:a05:6e02:1ca8:b0:3cf:f844:68eb with SMTP id
 e9e14a558f8ab-3d3e6e21084mr109377615ab.4.1740999023063; Mon, 03 Mar 2025
 02:50:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301201424.2046477-1-edumazet@google.com> <20250301201424.2046477-6-edumazet@google.com>
In-Reply-To: <20250301201424.2046477-6-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Mar 2025 18:49:46 +0800
X-Gm-Features: AQ5f1Joy67mT1NkPh6Xk05u5pHKvCOnxj4KCNQ2vpSgGcO8bMse3T81v2frU_EY
Message-ID: <CAL+tcoBnY9Ss=DiAPJOuGaGtX8-Yq_ANyqAWNOf_qNp0ZbJe-w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 5/6] tcp: remove READ_ONCE(req->ts_recent)
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Wang Hai <wanghai38@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 4:15=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> After commit 8d52da23b6c6 ("tcp: Defer ts_recent changes
> until req is owned"), req->ts_recent is not changed anymore.
>
> It is set once in tcp_openreq_init(), bpf_sk_assign_tcp_reqsk()
> or cookie_tcp_reqsk_alloc() before the req can be seen by other
> cpus/threads.
>
> This completes the revert of eba20811f326 ("tcp: annotate
> data-races around tcp_rsk(req)->ts_recent").
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Wang Hai <wanghai38@huawei.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

