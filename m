Return-Path: <netdev+bounces-176710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE714A6B8E0
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738BB188F1D4
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24FD1F4C9B;
	Fri, 21 Mar 2025 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I34AwKyj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F11B6CE0
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553465; cv=none; b=pcU3j7A4rWU1ZkbEdL3QdUx6Ou5JUreXOlYwtN6wBbInzi0QNq2X+AbEEo9mLJB7tV+mhNTttFIV4UTPe+pCoP0vnFFyJtKQdpbRMBX5Y18EdG9gCHSGY1+VWuWMpLYkZnbz10z3/GoNPi+qrWsF+p4+pXOVH2sVrqZr+Y+5KVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553465; c=relaxed/simple;
	bh=8qr8uTeaqr+p8zD9zlmtfx52Qsx4YWp+5OcFR7qoSm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfkXK2qCSAPWjL/LyX8OGtGgscPGtupAtMklzU57rpwPUebBBBWuJjccpU/XWydBnk4peBSS3NghLeakc8ANxJIkYu9MTsumx9m7r2pGl/FQSJgNOG/UUTGymXdXMppy4QW+vlbzQXVD/4XnjWrl0HNOAvgR0zPjWM/EKzg78X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I34AwKyj; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4767e969b94so34298261cf.2
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 03:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742553463; x=1743158263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18OouvJG6zVbvjzM1FOGerTElGKBPuwHf+zVIFYJM8o=;
        b=I34AwKyjsACN65RVsGqLk8bFXNoo84ZCQhYqd8Pln2Fshhj8R1md8FI0AxJHOF46uI
         PJqudQU/PM6S9SdHmR7TZ1ANteE5PPZ5GKlhgAaxk/tVAKYtI6qjhFrFCQQ+BTqHzVNu
         22mLZ0lGl5y18/jX1TDqNW11Mgw/LvIMsHYg1lfB8kuynVpG8K4511eQfGgxJ7EKbUvL
         KIlvzDDtdP+5bikJusfVjMe1pAdi+MRxRZNCtGtSyTB9ur44bjCKTvyRl1OwyGE5HdEy
         grICTxnZWTxewvEGC4w7i4Cf8MaPZUWtcb6VDDi1w5zlWA4eSBoafIu/hHM3Nz2972C4
         8PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742553463; x=1743158263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18OouvJG6zVbvjzM1FOGerTElGKBPuwHf+zVIFYJM8o=;
        b=FNyBc945PgD+0mKkoNqrLzs7TsMFcneB4joIfGg4zonGGP687gAzQ+Dwn7auDiOEqw
         1ZnI9lRvfk06Z+wUgbVlSu4UHBkbb6OfsTBMQ2V/4kzthAierxL5k9vtJnoV/KYj74QG
         +BrcD76J4mcN7k+kIprsYUjy0mXNxngVA/x5ktUy59byoQ6CBjh+HVzlbpVV3TnNQlHb
         ty/HTq7RhBA+PGlVZEnT4DLg5EQxtXVduuUjc89RZzV3NNPl8lgxab2792oT8I1JqHMQ
         1+clmycY+KURhjFAWJ4TAOW5mz746uuvmKUkJal0bsdkB5glwrsLlOFknxXhLqe0mFb5
         iSOw==
X-Forwarded-Encrypted: i=1; AJvYcCVjQZ/J5LUH54beNox8rcXt/vgbe16GJMNQjN2PH6jl0ISXwXa0M8xuTH8GJVB/MYAcnApQ7WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNDNT3LJJmtjSbXj1bi0Oaf7RcpU7OfLEEvcQ8pjdnyU90uhXq
	nbBwqOXE/CrxBYtENFFYHmwNeeqq93vVzqRb9NGr8CvI2NUuDB2KLc6Z9tkHYT1scsXMgqCK6of
	n1LSQN917WAY3jBmfE+ugRbGorFVt2tGts/YG
X-Gm-Gg: ASbGncu9PoFnrmtKUCs7F0K9Uw3NBjTWBl7zO8/oTy5K0dJsRk7YsiXYyGuRv8K6B/T
	joK2XCNf3GdgSMkChDT5sV1YkrYSFblpgxbTifhHVVNv9r6/rAIHP0cPoWnUnN1RJyPGlNeDxVz
	xMa87UYD84/SK6zCjOzKZmTDhu
X-Google-Smtp-Source: AGHT+IEhqDKb0COnjB68TZ5TBEYvhp3OeCzpUhByZrB+edRRw7lwSaoQkN+wLQkdmuZcX0/594UU6lyrbiuq/pE5gxo=
X-Received: by 2002:a05:622a:59c5:b0:476:6f90:395e with SMTP id
 d75a77b69052e-4771dd94fcbmr41742221cf.21.1742553462772; Fri, 21 Mar 2025
 03:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
In-Reply-To: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Mar 2025 11:37:31 +0100
X-Gm-Features: AQ5f1JoTxQA7eKStn8Kp_wSo6MddPCNrZiUCY5HsiPv1Z7ZL_xYt8c7-8UKvdz4
Message-ID: <CANn89iLpON7eV9rHvErsoEu+GqDz18uYMv6M_4TLsh+WX9VQeg@mail.gmail.com>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	aeh@meta.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	jhs@mojatatu.com, kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 10:31=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> lockdep_unregister_key() is called from critical code paths, including
> sections where rtnl_lock() is held. For example, when replacing a qdisc
> in a network device, network egress traffic is disabled while
> __qdisc_destroy() is called for every network queue.
>
> If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key(),
> which gets blocked waiting for synchronize_rcu() to complete.
>
> For example, a simple tc command to replace a qdisc could take 13
> seconds:
>
>   # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
>     real    0m13.195s
>     user    0m0.001s
>     sys     0m2.746s
>
> During this time, network egress is completely frozen while waiting for
> RCU synchronization.
>
> Use synchronize_rcu_expedited() instead to minimize the impact on
> critical operations like network connectivity changes.

Running 'critical operations' with LOCKDEP enabled kernels seems a bit
strange :)

Reviewed-by: Eric Dumazet <edumazet@google.com>

