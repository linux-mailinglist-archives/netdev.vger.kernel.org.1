Return-Path: <netdev+bounces-241715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880EDC878EC
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 01:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414293B1D9E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3A94C9D;
	Wed, 26 Nov 2025 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="075yzUg6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C236B
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764115861; cv=none; b=Rlhuts+6RruN0ZKRPvOiWTye3BMRF3ZW/edVvHQBzMCsiemSGoxpVGrbBoaXaU24ELSwaHn/DOIiit9RH5SYzLYYyygQ18KjX0cNDtCL2zkoga6ZiyleJEIM1LC8amW/SY4kv+/hc2snCLmPoWsOytHICF6zP6tsDqLhg69/Hxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764115861; c=relaxed/simple;
	bh=gODh8Zu7RLttp8lsBH32/FVlUAlTwV1OAiFGxrGKVrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iL7NgDQ/Z4LXpbbcAOlvwPxPD9S8wCqUvSw+2YONeJBXgA2fCWlph5/xqz4qb70Typ/6ZZ8NrCTP/+Ly5FEK3XHEJf7Lx9jhUutrF184/eIPBWGaVit5Ax7GURBtCq7G4M5CIfW6EW2BPgzHE7h7n/4JYM5DyNZVwup9aCq0XSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=075yzUg6; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11beb0a7bd6so385599c88.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764115859; x=1764720659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gODh8Zu7RLttp8lsBH32/FVlUAlTwV1OAiFGxrGKVrw=;
        b=075yzUg6gx8r8eYcWwXJXojIDNwAiSlK0aKNh9/SNWrO9odZzieDpEQMCM/OUUAchS
         mSmG4VI4yYnay7L/+N/WwJaB0ABu6itboJ0Z7RbdaX8IeWsrM9+XgyasAAaPe1HfFjkY
         0Ej+wYHpQtpJ6cRdwRDkqgaHf2eaGzCqEqlkaeyEN+tqrfIYwfeWxn+YDgutBrfOkb+J
         D+E1XEd86JFGisXsdDnyBw6xiiAj1hgHdbFB9DaEkfEAm/LRJp2Sxmz2vwS9reilECQK
         53TgoHSM9X5bJBDKfQDJzKOX1qyLhIz7J8k8UKwnTOTnN9zhdcOGgwuW7/5LN65cUbz8
         1Pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764115859; x=1764720659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gODh8Zu7RLttp8lsBH32/FVlUAlTwV1OAiFGxrGKVrw=;
        b=OiBYTAa2rYPVWBDpcTEQAYySpDPmGaD1JPKq2U3pIQzWl+dfMBsPz53CZDlKC7Crah
         qoWnED+AexZ6RrTH4KBAW/fP4y9Yt4/stV5ugQJ1QuwTVcrH5Ku9+p9zFIE0FUmxV4qs
         7uJUHiJw8PVLsiNiD3o+v/mhYhOBAAM5rZgNgSXrrXZMzaGFGzalqI6t6tQiGbj1jLtJ
         5ZNDHPFM3EX6do1KtlgXbYcBy8LOAK5SO0Of3gpkHZG+MFmwy6X7XB/a9Dj6q8Jq4a7y
         /QohSdlYZ70TD+rUuudlnGYvK7OurzmATceq7j6+xoVCyyKLZ6JmnR3MfcjAwcxWjA65
         KwTA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3jQQnZYYwDH0hXRUvWVC0gcLBL2uMN0eVUklKFsKF34xHE2FNQ3mkAZEPJvazI7NjEjml+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUWK1Rt2NJtuzQ3RxK7wYhQzMLLTWyR8kgKBHbVEESoBdsaME
	8N/NPCVzwxUrtU2RxvWzxWeAx07jKJHNa9Yn7CMdJiHoXQRVlOPMd2QPn1Op/7jzp7Q2soJ3M6P
	zycR7pWq8Na2JGZZ1DscW3V/DZXhy14H4e3z3wp1P
X-Gm-Gg: ASbGncsnAqK4+JYEQwbYMDdGRnavFZG069yRDCPKq96LtSLoiDClB0Fyx+WpWcR7ZJT
	Glj/XEOvAgzLFgjyvLhMiK3qT0219OXTCoMOv3PQY0BEh/6gy/UfG6XI1K5kRCVYhEZH3i2PZEj
	1RtV/skYdLERY5B1Zdzw2te1Mu6b45NLWe5uvSg+IIuEyhWOKSjvbqV2ojAlBTjwmHTViqj3Tpj
	iXOneILsVObwOvxRZx/Poq4okYkY5IiRU/2jmpFEDuC6LIg7xR3ig6ivXSCEiEsxYVpyyWEHh5H
	a9mX8nuYsiClAn38pI3kZgNdsHBZEGOOhl+61TzwsorBqMXl6GhUI87fUA==
X-Google-Smtp-Source: AGHT+IGQ0dgSPVWCWB7XslBCnVXDm88kb6OhvqzpprTDTuDDDAG28TlQ3SVHjpoitfKMmJErqISdYtJ0cFv3UGok5Ec=
X-Received: by 2002:a05:7022:ec17:b0:11b:9386:a382 with SMTP id
 a92af1059eb24-11c9cabc4f0mr11821377c88.21.1764115859091; Tue, 25 Nov 2025
 16:10:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124175013.1473655-1-edumazet@google.com> <20251124175013.1473655-5-edumazet@google.com>
In-Reply-To: <20251124175013.1473655-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 25 Nov 2025 16:10:47 -0800
X-Gm-Features: AWmQ_bmE2jOvEwigEAInzjOpzdyRR_3K3x2eeIM0nTn4H9zU2LwfJFcI32fnpoU
Message-ID: <CAAVpQUA6OyOKzYt6Eiv9iC1hSdjs-i_yJpqiC8p-BbfCgxzM3Q@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] tcp: remove icsk->icsk_retransmit_timer
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 9:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Now sk->sk_timer is no longer used by TCP keepalive, we can use
> its storage for TCP and MPTCP retransmit timers for better
> cache locality.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

