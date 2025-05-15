Return-Path: <netdev+bounces-190816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8DAAB8F2D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A341895034
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A04F269B07;
	Thu, 15 May 2025 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgQDn6s8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D28253F21
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747334221; cv=none; b=dJzMxDWDGi+zLQdeSHHT4zymajWGaHqMYQqPdb9OtVO7THka/cwKRg2rkLiCJHC+2DFq8or/0BAmmdstsgaXTOqhrbUZdSgw2DE9wl9FMsTFThwln1VfNljENK/7NGBQxzdP35BVFuorzmYJg+yPlh4ardOIKXqvBzoJNCfAoLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747334221; c=relaxed/simple;
	bh=jmUqIUHlnXIFR+CtffBOJ8klcx+8qVBg9cKcuoX6nJs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BqhtJRJRw/4qjvjmB6ucMOqdvaDWpwT9QD18ebS9CQEUTjif8c1Il5jklGS6E5CLDUmTYDVphT3bo8k2ZiQz9h8OTguXodHqArHYI7YF3qLwJZ2UdB3eEdBggHyXJEK5eO8tnWTOzaCWQECjCo7rt55YMaAiC2EfnXMPmXZlJo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgQDn6s8; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c54f67db99so263948685a.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747334219; x=1747939019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5aUZzcF4X63uHuPJYbhnY3LNo6CFmNdHXMG7tamSU8=;
        b=XgQDn6s888svFCms8YeO7FUJLphGAKmwA5Z1JIFq+lyy3ZSBPiRlWhJaROd99wWWhr
         LEk8rsB5cBDcXe+B/2dNGaBt814/RqUDU4IWgnRJ0Gaj9kDNlkgVtpvGl4ThqM8emALS
         OtzZ7XGuy4XzHeGXHdFkzP7/9bBQ2XNYthqIVUM9vqSRrIyyD1tVZtNe7jZZs4RZYHNY
         4TrU6KNk+dPzZFEKQI4wIK6XpQDTCIvQ8p1K1uclkunB4q5bRIKk3M0MHaEDm3GqJm83
         2PDK0xMkiGonLTZcFjh+YQn/8W06T8/iuZQ+IrJKlndfOXUhMXkx8kgHyKsCWTjZgLeh
         ENgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747334219; x=1747939019;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G5aUZzcF4X63uHuPJYbhnY3LNo6CFmNdHXMG7tamSU8=;
        b=NJK2hVqug3lJ7g4A+VnyMfWxSM9BMA41Pl4YmQxNJqYc+nL5RUrDpB8jE0gogBcC7F
         +fJ+GwAcugXs+sO9Q8Dlwtu3M/MpfA2DZQDk7/ZTr3jjXW50918nvDppV20k0dtsqjgb
         5aVv1P0SIDQmgjkgXmvj5bCrE4oLTc9xbpzkDtyz/3aGKnOtGYsphYW1n2s6ubniNH4u
         OScHXqVrihX3rZIDSqwUH90CGnjo+845Np2RyGQfN8dWPLJONXzC9eoObNpD8lbkNdAc
         RMU6/XhAMLAInf4H7WgEq2WxFybBWc7bKbiAw+AIOLio3bb+afVeRwGDNPGs2LMHwnQD
         m3eg==
X-Forwarded-Encrypted: i=1; AJvYcCU+wIM32aTtg9Qf+m/ljUzf1BoLZyQ9WkT6vYKMMmKOTSO85XUmn7Od/GgyfbktszlqlNptiiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVzy2jC5ellVolcHxle7IsHyth5SjGFCxgz+EnxV7FA0mHxK0q
	27tMBclmJ5mT2k/VvALE1KP1PZe30yUwVT3GE177B8Xwm1R2RMDPwJQo
X-Gm-Gg: ASbGncsserFksnpsxQnsk3Kr4XerB8Nv6jV1hGkI6KEHYkzi3cTpWH3r5bw7KyU9LHH
	is4cwF4uKdeexfJdl4MYO0ey26kIIEliBnsrJ34EaDmgAdknU3eKg3PjScJzOTypVuzmXYpPhFo
	QLgXpGvN6LEcPakNPIwQHgJiQ6msftG84g4AWCBgfdyxwhu64Htv4t6GCZOALMm0KcgdTX9ALbn
	SAUNREqa7ZI0ysErGgPXI7jcSAmWNAGsVrQ8cbSXoV9ZRb/84JUbpZzUHEuFfWIZODhG7nsr7zJ
	JiG0kDGZ28I6Bum2IbGu8jrRumTyJb3OHke+kwf4/iC3HO4smD+Ryh3Td0+lCk/qMjuLOyl28pF
	OexWY49ZYQgWRzOCYJXQRxcc=
X-Google-Smtp-Source: AGHT+IEIhB9XZJYbjzPCUwpa/OBekmaFWwSaQx2O4xvmln4JCmgUGKGu11+K0QLjbYHASdDfEX2xkg==
X-Received: by 2002:a05:620a:43a2:b0:7c9:64b9:6391 with SMTP id af79cd13be357-7cd46b9718fmr62167785a.28.1747334218649;
        Thu, 15 May 2025 11:36:58 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd467d814bsm17866085a.28.2025.05.15.11.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:36:58 -0700 (PDT)
Date: Thu, 15 May 2025 14:36:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <68263449bf933_25ebe5294e3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250514165226.40410-6-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
 <20250514165226.40410-6-kuniyu@amazon.com>
Subject: Re: [PATCH v3 net-next 5/9] net: Restrict SO_PASS{CRED,PIDFD,SEC} to
 AF_{UNIX,NETLINK,BLUETOOTH}.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> SCM_CREDENTIALS and SCM_SECURITY can be recv()ed by calling
> scm_recv() or scm_recv_unix(), and SCM_PIDFD is only used by
> scm_recv_unix().
> 
> scm_recv() is called from AF_NETLINK and AF_BLUETOOTH.
> 
> scm_recv_unix() is literally called from AF_UNIX.
> 
> Let's restrict SO_PASSCRED and SO_PASSSEC to such sockets and
> SO_PASSPIDFD to AF_UNIX only.
> 
> Later, SOCK_PASS{CRED,PIDFD,SEC} will be moved to struct sock
> and united with another field.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

