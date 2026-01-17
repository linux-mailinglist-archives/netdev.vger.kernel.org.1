Return-Path: <netdev+bounces-250724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B8FD39016
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 18:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A3393002153
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B266288530;
	Sat, 17 Jan 2026 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Azsokahx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315102459CF
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768671238; cv=none; b=XmW+N07SV+mPBNXTnufzKRP5NK8u0MXtUnBwQWB6zge+37rwUV/qoykDE+ZReoiYZAABjInlc577SGI7ipogmB+KQSytgFMT3deLcVVgsJfPVFj40Bxp4fzz9Go5OaAHzhsVFJXvXxSaXmBoQSapjeZV//jYpW/7FpiJHNHJLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768671238; c=relaxed/simple;
	bh=tlBjuA5xfR5tuefAO46JbRQJcsmLlI8yfq+b7MeWLEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pfrfp2OMHE+mpdgG7P4uGPVgCG9jkgqmv40vZ3SsaEJdzPhHM10dnXS33mRjh0MSRE/NVfVlETTLAjOjKdsOJsqNR3qJorSig0HNdMFykPGUpGT35bXQ8g/3wVjXpHahufjTVeyVlakt3Fg44eRf6X5+Rmv5kAjslehQi2lfdX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Azsokahx; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5eea6f90d7fso2209602137.3
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 09:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768671236; x=1769276036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DeAqZXahHzqa6kJPzha4YSPb4VXznhEtP56Z4rFZLGA=;
        b=Azsokahx3e7LrP3J7DybNydoQq+JBLyRRjk7aAOqUj5/72KB4ZtGHjYZ8BTG8lJ4aL
         sAu/GR4bdktvfo30+m9D6SlefDJ4th6C3Qb4N/5P8L3ILvOMjEcIBdDgkaZNs52am2fN
         3cOAH409It0HydWTU4EcX4Hx6lJIPWMarn0UzqO+3AyjeWy+zw3edcTD2zldCxFH9rug
         qEbj2j3SU+yP7HXu+P0zBM6m1tLJPPUEvZB0DeLVurQVvHtJYJ8fYtjASqch14s/Uaea
         i21JYbMNc3a8iBjhHZWVY5BfGOj26TSho1Wu4iscp7qHpFT3c1DF4Pwygu5pTnwssUf7
         q74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768671236; x=1769276036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeAqZXahHzqa6kJPzha4YSPb4VXznhEtP56Z4rFZLGA=;
        b=nT8D3nWDOdvKzJfbam+URohRIn5dz3iBb4UW/EVqvbVCQOxrj7FnTPHFRBonTS3Rnq
         ue7HqD3MZmOOoA2iVapqUKICLE3J4Rx2geAzj5LGc55Pi5NXXNsjhTGNnElrtwRIPF+Q
         D1zBgCiclCoAkrVkukXXYp1CR1bFYZh5cHKXoryyG4VmwA+VNRjkriYtXzGNrcY4/6Qt
         boFTGaoseONAy8nnQzBrY4/0Uad9KMrkyYWa4gWtnlhwzlz/L6njIcrXV9fQ90ZGlVYJ
         srqpEvlDjL+smbk6Kc2bVeZf4q0s6FHTnk7Xq8j8qzmzbnHnLk0a0xQmaj/Eh7PPkIDa
         HTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpoQg1u5AM80seUs3aNxXEhs/7Jk/Zkv0L1Ascm4fE1OIcQ0KhLkxv5ZN189hyvEthKNjpjew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/uvNRAS/53fZOuG3QpeBP1MjkskMriD2Zsog57PB2Dssvm2l
	8fDJy8YXTjLKYYSfhG8ggj+x7ZcLu1e+pfTjnLLVh/v2QPZRGDKy5Az1NS4LU3DpHlFlKAZ6xXz
	zh3SVnf+JFo2/xys7TLbe1B0NeWbunC8=
X-Gm-Gg: AY/fxX4r87Ug3BMTkvJztMf2aeib9xae0gDO9RvrG/LjA21A2SwpMzAhfCSQCkpxdI6
	L+di/2jNpGqFAV5MDZ5JCpigNeuutjAJQVvTfLFBbZfs4tCpxxDXU8PyhGsLEgCI930aAxDcyxh
	IsguMmzfI1FwjDXxrzSrtiQUj91xk9ZpEVf76CUHN4goZT4mVQ+mBysuo/JrmH2q3uea30o0Gwn
	tdMDZzyiNOt23kuTULJhELtUsjr0re7IHXwD6Fs1O6XIHMPegt41KR4hOYJsDfkrmP+siI=
X-Received: by 2002:a05:6102:1611:b0:5e5:7055:66f5 with SMTP id
 ada2fe7eead31-5f1a5512e54mr2482685137.27.1768671235999; Sat, 17 Jan 2026
 09:33:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122003720.16724-1-scott_mitchell@apple.com>
 <aWWQ-ooAmTIEhdHO@chamomile> <CAFn2buDeCxJp3OHDifc5yX0pQndmLCKc=PShT+6Jq3-uy8C-OA@mail.gmail.com>
 <aWketzn78tzo5anB@strlen.de>
In-Reply-To: <aWketzn78tzo5anB@strlen.de>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Sat, 17 Jan 2026 09:33:45 -0800
X-Gm-Features: AZwV_Qg7qTIftU8j3tbHTZvqgIuaPVcLE_E-_VQsq9p3KEg55n-yTqR0tUYuZYc
Message-ID: <CAFn2buB-Pnn_kXFov+GEPST=XCbHwyW5HhidLMotqJxYoaW-+A@mail.gmail.com>
Subject: Re: [PATCH v5] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, kadlec@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Thanks for the clarification on the options. I'd like to propose going
with a refined version of the v5 approach (per-instance hlist_head
with auto-resize). Approach is to submit a v6 series with 2 commits:
1. Refactor instance_create() locking to enable GFP_KERNEL_ACCOUNT
instead of GFP_ATOMIC
2. Add per-instance hash table with auto-resize (no uapi changes)

Rationale for per-instance approach over shared rhashtable:
1. Resize algorithm matched to nfqueue behavior: outstanding packet
count depends on verdict/traffic rate. rhashtable resizes based on
element count, which for nfqueue means resize-up during bursts
followed by resize-down as verdicts drain the queue to zero. This
burst-drain pattern would cause repeated resize operations. The resize
approach can be tailored to nfqueue use case to reduce resize
thrashing.
2. Per-queue memory attribution/limits:  With GFP_KERNEL_ACCOUNT, hash
table allocations are charged to the cgroup that triggered the resize,
so memory consumption is bounded by cgroup limits rather than
requiring an additional kernel-internal limit.
3. Simpler key structure: Avoids composite keys (net, queue_num,
packet_id) needed for a shared hash table

I'm open to reconsidering the shared rhashtable approach if you feel
the benefits outweigh these tradeoffs.

