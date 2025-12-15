Return-Path: <netdev+bounces-244758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BE4CBE550
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD9B307B0B1
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5E430B509;
	Mon, 15 Dec 2025 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzCdn3Ss"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8184230ACE3
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807286; cv=none; b=bKQVcREX/8cumV4i2JwuZdS135oOhuHpXfcMjhwGJzhsOAbQWcosM+BPYjWGmOIW8TcBd7x6wN81wzOBEY5Xx02gGl/5OaJphDUfO+1XikHxtoNN3Cgyo5xCG73rZL3sQZ1vdV7/VXF79vgotdSU9DZh8cxvxZx292Z+SKFBQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807286; c=relaxed/simple;
	bh=kmuP8MMWK4aEuy7vFru3hFE7uw7OZnYNOMyaSAG5PS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHRzmh8neyqIaxrdboOHEsoaGUJ4teOoxvVv9sGqxHL9uBjV+FBB5xZNw5HPLN6vjF+PW7pgXqxVS0QaWrAPaRX9JZo9JSOgX1Tii2aT1YOBunDi0wpcGJxf+KxbNAyFUzcpBYqkuy/UO9lTTK3JWzDaJOllK6KGzFu6m1+umPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzCdn3Ss; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4eda26a04bfso41691271cf.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 06:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765807283; x=1766412083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SPO0uPcx426hWHahgG9ImqhyoeQJpO3h5lar/hdBpJI=;
        b=mzCdn3SsyZVsUaWVtQF/UtHfJxbM+S0BhiCq0eNpM8ZGQMh6EY91raNZOjqWXEWpQ5
         HftbXwnT5+w33M0+EhA2tO6nIVmJq0vElB2pczffNZawRE9bsd6jrgGhKB5xHbGjsxq/
         IYYA0jLW3HDI6o+qSsPaJbZ6xXjhrvugRm3diXAmlmDksADCOUGfT/bDkvdtxM7Bf5fW
         jcrEzT9je0duco4guiMu9i9/UzMhknNQ6e8V2ddGJ3xVmccr1Iqk8/fc2G5RCyFFw591
         a80dfxwI0WYt+SbYF8g/qIwrlcVglWbhEh3CKs6cGzk3OdB5rNDvOrl5rP02nkA5tnnZ
         bAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765807283; x=1766412083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPO0uPcx426hWHahgG9ImqhyoeQJpO3h5lar/hdBpJI=;
        b=B4CeHdII9x8lfjuNHjdnFxP3c1B/+o8AZOn3rtK6ndUu6eze4nhMSiw38MYs9MWdTI
         gnP/Nt4CJCe3XH+bLUX/q7aQk5fm2fa7L2ly1JQPQOIWTpP7vYNxe+BcqMylr4FRxJfg
         m68G3+WyTPJcOzriTd5GYh6iK0JsU56p+yh54orE4HiZy2Mhz8NRifsAv/l+9YIlPESk
         RwpLZp/fFnU19YW+L/a2Z730sxYTrvBWKDGGppt6beIN2Cvvn9sB7V/HtKyP/ka7XQpP
         Thert0LT2qAjejK5m1U2QTLy788IUZiEw/jxZ79IQe898fUecxTP/GwWAPdYbo+NwQD7
         d/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO1vQFfGY5tCMlyjUSlNYSTPV3IJti4bm/QeX2ekyZxLD+Rkyc1ctm+45zgxxGEtDVCSanDks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+Gutn4d6iGuOmcIbN1VQbz27y13CcyQeaiCjQOLSmC5yTjml
	ESTYYYxP37di6P2I95RX8PPefSB+bk6yDgZetdjtnvEOuO3PHAaInmyuYCsxcsST7UQuwrezYQN
	GlOGJiJWU4o++UCyqVxGFOipB+u8sedE=
X-Gm-Gg: AY/fxX5l9NHW59Xju0pX4n3e6QijRn87ZnuyBy5hS3Wt5QwKffyV1OTk6MbdlfNP6QB
	gQQAJ57ee7yXbfMk8P+IymcncgRpi6aeumM1yZqskiyW3e49JNx5gT7NPks5pkYqtwbFmZL8SrH
	vUIPkKDIV/m76Nk/ImLyw3OTDzi3/BZIs2nSCA5SoedAZQCCp9pxSoFAsmoQ0oxHCPYqduDpcaC
	bmUXkRLAeRZ545tr/IqnyLw8o48lyH0zzLnPhpfJ3tImIhMU8nU6S5rlm5XntwdO8+CRQ==
X-Google-Smtp-Source: AGHT+IGWvgG+PrqyPjgSyyDJipFK80SMlXFidZdqVH9PAbqjJjeB8AUiqA8gNsXzB3i6TjakiGDcsIb5tyseRVogTBU=
X-Received: by 2002:a05:622a:2610:b0:4e8:af8a:f951 with SMTP id
 d75a77b69052e-4f1d0673565mr154282801cf.83.1765807283233; Mon, 15 Dec 2025
 06:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215121258.843823-1-anders.grahn@westermo.com> <aUAAuyGGhDjyfNoM@strlen.de>
In-Reply-To: <aUAAuyGGhDjyfNoM@strlen.de>
From: Anders Grahn <anders.grahn@gmail.com>
Date: Mon, 15 Dec 2025 15:01:10 +0100
X-Gm-Features: AQt7F2pRgRiYkigqJCTjnWvcQG7aWllGf2Zl0MizbkiJv08wGMdAQXlJccLZAXE
Message-ID: <CAE-Z64Fpq8ZG9CSiKS7QS0Oa_qHQyWhTeOJy3wTEy2BJorFNcQ@mail.gmail.com>
Subject: Re: [PATCH] netfilter: nft_counter: Fix reset of counters on 32bit archs
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Anders Grahn <anders.grahn@westermo.com>, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> That still truncates val on 32bit.  Maybe use "s64 val"?

Agree. Thanks for the feedback.

On 32bit archs, you're definitely right. It would truncate the counter value on
32bit. However, the problem I intended to fix was the fact that, previously, a
negative value was passed to u64_stats_add() which always wrapped.

Initially, I was a bit reluctant to use s64 for u64_stats_sub() as I wanted to
keep the signature the same as the existing u64_stats_add(). As u64_stats_add()
is used in a lot of places, I was not sure about the effect of this.

However, I can prepare a v2 with just u64_stats_sub(u64_stats_t *, s64).

