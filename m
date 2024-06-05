Return-Path: <netdev+bounces-100842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7F98FC40A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 08:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361351C223A9
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 06:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0B3169381;
	Wed,  5 Jun 2024 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="la0CqVF5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D419046C
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717570792; cv=none; b=Nqnse0xMjj+QaDMHbe0T/izgsLFNzWyuuELL/dw/bznJWGHTlyfgHp7kJjns6Es35ruSRVyuIH0KINgxx1xj9L87PetWSSfgMf6Ksbc91gfNY+nDNAPoSsTWSv5PPoHahk0A7PK5zi1632OG47H6WjfWB/eZhhJ3rCiZzFq8hGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717570792; c=relaxed/simple;
	bh=kEKA5Y6rrxbuntbj/gj7TG6Es4qe7YRdQpVkjZWVZHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faovUBD0X7uqiDe4GpSwMGfDk9eKcgJmNZhofXiXZGEK1wqhIAUwfdHuReZwsPkLmTFTRmI7O2uY2XG0764+0s0sXOP4kxN7dfas6Rn+noHRNYB56xMEJN6Wz7/PnQilCNF61aM7u2S0fGpHHnHG/PVtw2DgtCxXJD7g6CBb35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=la0CqVF5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a1b122718so4678a12.1
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 23:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717570789; x=1718175589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEKA5Y6rrxbuntbj/gj7TG6Es4qe7YRdQpVkjZWVZHQ=;
        b=la0CqVF5eniZsU17f1D27L9xw4oln1uoD6Zijto9QhGkJkFoM+Gh/iQRvllajBQ9U5
         EjwRQ4mGRXzubiVk0Dct2MPZHDs1kcX1EO0NnMoMSNVwuNPzYVxBmIhJML1ny5kt8IDp
         uELZIBoOMlMGTGpHLwO4+j7GPNjkok0Hz6387S4lvhCSHRvVvgbM0TS28sKB45OnqBUF
         xjECHZ2FqxFBO0NYQ4bk4ai25NDi9nbwjGB9AKStKkUZiOJOTKXki/tRCIvNSG/ziZbK
         3Xfj7nnX8CJk+V1JilCfJCSR9ys0NwT3+GtP5QYifNkVmKiJHX+GPFXosbLMkbkUoWnl
         ruMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717570789; x=1718175589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEKA5Y6rrxbuntbj/gj7TG6Es4qe7YRdQpVkjZWVZHQ=;
        b=iwyqk6ynSeswmto8g7fYxijaw/Hsy4vcj9lJ5SbPxkAJ8F71y3TLoka1ozWnW4xsQu
         y9g0QyjO5k5mxpD566gpVGjchH+y9bNra1o5dW+CTBH8/tEOYj1VqUzD/13xYwJIQkwY
         n6CWM/xs7iKkkbNnOTHxHYyWgrFrcVUSQNMEuXhMi8NtF594Jz25wYZems3zgmhmB+Ym
         0L+8S535uBI3iqgTK1LBSToMQ82iA8zV2qQ8r4G5QzGnnaWr0DaWMak/HNGKm8dlbEO8
         7o2Fi+HBFpHRv1/BEKQbVDagd7EB8j/ajcMB1nQJ3MNV+p3ywofkEQ0Zjl7Di3FPPoQw
         iJ1g==
X-Gm-Message-State: AOJu0YzOLmSmz5l1x6jF8QG2PKXa2XDEfjQftHJVZxZWVEOs51yniG1X
	CSa2eGhVX+f5KeCjw3izWZIdYXtYfJNqR7u80GETUb8qoP/iC2B4uVNAbNInYdoRKRYXIMs9TDo
	Lwo0UBHcdvM9Dy8TTzRrfY/HZ2C8eDrrFj9ud
X-Google-Smtp-Source: AGHT+IESKhtVWeZ9LDJqEzR7Y+OSO2tqcGWjH2pKBHbBB3rdsXgsKBGHp49zmBCMeAyskr8g5X+HM36IS5YxGk4Zoy4=
X-Received: by 2002:a05:6402:3594:b0:576:b1a9:2960 with SMTP id
 4fb4d7f45d1cf-57a94fe8ce3mr97165a12.5.1717570789077; Tue, 04 Jun 2024
 23:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604140903.31939-1-fw@strlen.de> <20240604140903.31939-3-fw@strlen.de>
In-Reply-To: <20240604140903.31939-3-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Jun 2024 08:59:38 +0200
Message-ID: <CANn89iJ+JzSdK2_N5+D3S33+txwEFyKgp_3Ofg1hHt5OC=3ScA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/3] net: tcp: un-pin the tw_timer
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, vschneid@redhat.com, 
	tglozar@redhat.com, bigeasy@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 4:11=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> After previous patch, even if timer fires immediately on another CPU,
> context that schedules the timer now holds the ehash spinlock, so timer
> cannot reap tw socket until ehash lock is released.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Eric Dumazet <edumazet@google.com>

