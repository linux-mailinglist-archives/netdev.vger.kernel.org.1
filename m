Return-Path: <netdev+bounces-130861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0A098BC61
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701732868F2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240261BFE0E;
	Tue,  1 Oct 2024 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQReRPJK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7F1BCA11
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786448; cv=none; b=mHilYC5Ve9hrsAKotXvF9W9HlDDehxoEGhXk9kARw3vmxdp4jcJfilLcLi0QR2pH14Efndpv3o34smo960Q3zfNCa7xD4T7lcp5wkSus3qY5Ixb82IHNbOK3TocKKlBFo3UkcQI2A+7hULTia0q7dXsugShy65YRfRVA7qerO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786448; c=relaxed/simple;
	bh=bn4DAh/wiK1gF5nn8LRM2PD9SAeCatNfsRdyCCRKOTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXr9dVuzZGJr/3KjGHeSHxH95SMd9IVJ1iT/gZt02Sl1l1RxvxjMxJXqXMEssWDKVfu3h9a7muDFj74GMDM1YWTWfPqfsLLFLsn0OloxMK5ucLeHpJSiT/KTKtSS2AZn/bcY1VR6cnSlPa1aajhLw1T9fbJ4YLPG0YI4gFJE9sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQReRPJK; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53959a88668so4857320e87.2
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727786444; x=1728391244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFyB/HT0qBJorBVbNkBb40TzbbvQ3wXX8vx4mwLOaJ4=;
        b=bQReRPJKKFZu16HYzHUbuKAXJ2j2ISAdTVVa0ogmAOVMD81sYFw3xK2vmzjwRWaZ8f
         gGep3gSvAkHd/Kg69yMajYNaSUeebnmH3jQ2Er+hyjj6WinpLFQVwH2JNoR6rONX7B1I
         xfo6sUVV8s+XeW+q5273b23Z2gKENYXRHGAnus6VqEBWyC1tKakr3x5vyAlA+ZH7EhAH
         HTjk4/6fWAKhiTtuvJLAHeJfn69F6vsBcn40AnHFVJQdcX/+8BlVwIFElc5QlP0ZwukE
         764HXOppRLjaqc/HqNi03pZlmsWzzT6kfMHSNZgYZzXU7buk0v3K2PHjQNaDZQ7cq/W3
         nizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786444; x=1728391244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFyB/HT0qBJorBVbNkBb40TzbbvQ3wXX8vx4mwLOaJ4=;
        b=qiL6UX1I1Y9kdvep7xEAt5CuTKozoRwwn/0DvmMl4pdkBIuymrK39EEEaBDjLkB+1s
         gMbfSNeUjz7yeTn6cqfz6vCleOnpOcLHuoOEKgO5XX0f1Ii5gKnR9dgL8bBRsGXZB1xt
         tOjWxgyIZUEXpWpC9B6DirB/IMiBTc0Gv/7Rv1TmvU14o0wf19/3LljvRKj93RtHBq40
         I/lB9HMMRSL744rWyFHqLX4ZbKLPmuFFoKGyS90xtDnkd96bpLsfbrszDyP7VniXbh7A
         8dGxUGtwKPUmeISw94ci92fyVYMI5JJ1eiOA1Id+Su2TmHY+IMdmbG1U9qjhx6ZZ0YaQ
         faLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3DrLgOHOah9CyBMzb9e8OkacDuSTAMG7LpAp5F5msvagTZ5pbrE0T7kFg0Es0lNChruKFBIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx18GOvMDnTteo60IoZpVffUv9gSFKFCKv/SUppONjVUws+pdi
	1HSvAcv749d3ZauTC2aZYXmLor5QPwyPA6TUcIC7HYo574rw2Icl8HaVZNZGRYJ39xiH3MpTtNG
	nA3mYLrb3AoCcRGAjuWgfrtrt1W+3B4gxnMSJ
X-Google-Smtp-Source: AGHT+IGY/VdpTg7bXYdmdu76Sfkguu21uPw1h+lTZoasfm+lNQF6XjQF3PI2yMku7NuEOEWa3TDHvF8C1xoDb3fBIAo=
X-Received: by 2002:a05:6512:3f07:b0:536:54df:bffa with SMTP id
 2adb3069b0e04-5389fc7fefemr8669795e87.45.1727786444212; Tue, 01 Oct 2024
 05:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001024837.96425-1-kuniyu@amazon.com> <20241001024837.96425-4-kuniyu@amazon.com>
In-Reply-To: <20241001024837.96425-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 14:40:33 +0200
Message-ID: <CANn89iJW6vhKDYb0t-ntjhSd3oNf=QRhoS0viY3goK4jZu4uCw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/5] ipv4: Namespacify IPv4 address GC.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:50=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> Each IPv4 address could have a lifetime, which is useful for DHCP,
> and GC is periodically executed as check_lifetime_work.
>
> check_lifetime() does the actual GC under RTNL.
>
>   1. Acquire RTNL
>   2. Iterate inet_addr_lst
>   3. Remove IPv4 address if expired
>   4. Release RTNL
>
> Namespacifying the GC is required for per-net RTNL, but using the
> per-net hash table will shorten the time on the hash bucket iteration
> under RTNL.
>
> Let's add per-net GC work and use the per-net hash table.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

