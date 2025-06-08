Return-Path: <netdev+bounces-195570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD1BAD1439
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 22:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DA518890A0
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 20:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61F21CEACB;
	Sun,  8 Jun 2025 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrTR4ANk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551891372;
	Sun,  8 Jun 2025 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749414658; cv=none; b=rDew2abIO4voEMQ53k3+EJyp3tOomUpoesReHW+6x8+B3099pW2eil54C67iqNG1DgHsKeV/nho9awqs0LFqolRR8fVhSk1HgPYlYyYIeczDal7IbCRzSEqjOCAIS/SEspdIRKqrZ90uyA//ZnF3qdPl89T4gSvFJQFhoOjUWqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749414658; c=relaxed/simple;
	bh=paJQsm8VjqkQeElUHQdhqGI3+WnM0KsTXGD75t0j5tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEKTmgO/jsnAoIPfHjcCMeacfAv0hWXe93y2puoOVKXOyqsUXQWZtqh02tSm/nkFj9M42sh+Bw+EmsMWvqDOzZ7g+bhT+CSBrKvgJlA8A7o/t4Na1bNZJLPLqQ7MRc9g7+YGH3Not89J8VGX1r7XkZNWOwtxsEX86gZCAt+4Qc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrTR4ANk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235e1d4cba0so27768715ad.2;
        Sun, 08 Jun 2025 13:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749414656; x=1750019456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9aCplgkp0V+7+yNOgN7cid7kDTOh/cSiZAss2NRX2s=;
        b=ZrTR4ANkvt3rlwAkuKBxXX/WJZW3DiFa4jb052y4JWa7l6oMbz7FSQePXn8mICEjpB
         Yi3761wt63Uyky3n22z8mg3+A4NYNZOLhJFJydLQccBKHPPZFbot7g90m8NZKxGe4W1y
         trZs1zJCEMq+Y5R2T1LnZ0ZielbhBAW97C8w9mFqe2nkl74lwlMBwaWgj6mBGPbyVZlS
         OaeQy1KVgwDsIDCbDlnfY2LMJ3Gx/CbaTK5D9hJs6SBWucts8V9sV7HFv3nothihl9W0
         /6YCL/UF3c/OyBYmhTRhPz/GXumlgtgL4AIJGRAuSb6xSfGSuKpsy5wBj5kEkTSAUmks
         zAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749414656; x=1750019456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9aCplgkp0V+7+yNOgN7cid7kDTOh/cSiZAss2NRX2s=;
        b=KaQPCkgOvCPc03l1LtV5YtJSEMTwkA722knU2vFtg8SP0LLbdAuBZeBDWVw3m+cIjw
         Errcw3sOf+QDKMVLq6yIjJ7z/HMBnwPsK0keElfsOnGod22EdbzYLUPQGS5XUZNAyQzo
         t3OJFzpoNAj3HDNy8anOkgGhx4MRH7toyEJUs8LKuOUInIxRU2eYskBo0vmAZAAcFDdM
         0KkxjLDTWxSzISzc3FdAzIl0cgzFO0LobkfeATKblzRaR0vWr4/lCWhirmCAmYCQvZ6j
         OcJXvuQdj4E4nrcYpRsE7IZjmg1h4j7TcSNyG7/2+50Z4LeVNzxGCFPGeK+82WxDfqbW
         ATZw==
X-Forwarded-Encrypted: i=1; AJvYcCV7h7Kw+J/OuNdCBufTxtkbeTHGdSuNyqa1DNAnq7jB3MJJS7Ws/9kP5SEwIG+qNWlPEyZBv2ve@vger.kernel.org, AJvYcCX+bi7wf62Gdhcu+PlYuDK71Q1LwUNrUY5WdSm3tzBOwZCMpUxU38netW/nhvDx3NGUFmE59wBE61ZKlew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfCksmlhASbfeKG3YvgBPmcLixO7GnofomTFRmYAHQwVUAx8w3
	v3bd9PnyjEZoLYdIoKhej9hvgsSoNYGuly7LR6igcFiuVFY4svL/gfY=
X-Gm-Gg: ASbGnctz6uJTYd9w6CQOabShPoHZBV6JWClooUwKdtjPxDBbUiTmC7Fu5sEEE7K5h3O
	zUZL76d/QaR8kKhwRliXgCLpKGYWvdxpWIQoTHjJWz14mKKvGj0FNGMxgCxE7biOV4sls7FGCUr
	N3+kTZPyC8tbsVwZOkpBzkPTdCyQdmn6E1fGnkuLPGq2ZuGiIqxVDcfGqeqbdYhZblRze6ukBBN
	VdCwuH7x2ULSn05/e/ImaVWtC3YU+KDZM7L6Cl0e1N/1BFbM8p2PI6G7qRlJlU+i5uSBX4I0Z3N
	USSWQJJA9/NSpESeMVKssdMFcwZ5H9D+19ac5so=
X-Google-Smtp-Source: AGHT+IFc0GXXFM0S7BM66k77mQmeDxGNeGyEjOIpwCp2uK7mlnuXSQ+Nl2QHhuJl0ddM21M0YVbyzw==
X-Received: by 2002:a17:902:d48f:b0:234:b41e:37a4 with SMTP id d9443c01a7336-23601cf5aadmr113552755ad.6.1749414656594;
        Sun, 08 Jun 2025 13:30:56 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030789c2sm42380285ad.29.2025.06.08.13.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 13:30:56 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: kuni1840@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	farbere@amazon.com,
	kuba@kernel.org,
	kuniyu@amazon.com,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sashal@kernel.org,
	yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] net/ipv4: fix type mismatch in inet_ehash_locks_alloc() causing build failure
Date: Sun,  8 Jun 2025 13:30:18 -0700
Message-ID: <20250608203054.3982608-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608201227.3970666-1-kuni1840@gmail.com>
References: <20250608201227.3970666-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuni1840@gmail.com>
Date: Sun,  8 Jun 2025 13:11:51 -0700
> From: Eliav Farber <farbere@amazon.com>
> Date: Sun, 8 Jun 2025 06:07:26 +0000
> > Fix compilation warning:
> > 
> > In file included from ./include/linux/kernel.h:15,
> >                  from ./include/linux/list.h:9,
> >                  from ./include/linux/module.h:12,
> >                  from net/ipv4/inet_hashtables.c:12:
> > net/ipv4/inet_hashtables.c: In function ‘inet_ehash_locks_alloc’:
> > ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
> >    20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> >       |                                   ^~
> > ./include/linux/minmax.h:26:18: note: in expansion of macro ‘__typecheck’
> >    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
> >       |                  ^~~~~~~~~~~
> > ./include/linux/minmax.h:36:31: note: in expansion of macro ‘__safe_cmp’
> >    36 |         __builtin_choose_expr(__safe_cmp(x, y), \
> >       |                               ^~~~~~~~~~
> > ./include/linux/minmax.h:52:25: note: in expansion of macro ‘__careful_cmp’
> >    52 | #define max(x, y)       __careful_cmp(x, y, >)
> >       |                         ^~~~~~~~~~~~~
> > net/ipv4/inet_hashtables.c:946:19: note: in expansion of macro ‘max’
> >   946 |         nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
> >       |                   ^~~
> >   CC      block/badblocks.o
> > 
> > When warnings are treated as errors, this causes the build to fail.
> > 
> > The issue is a type mismatch between the operands passed to the max()
> > macro. Here, nblocks is an unsigned int, while the expression
> > num_online_nodes() * PAGE_SIZE / locksz is promoted to unsigned long.
> > 
> > This happens because:
> >  - num_online_nodes() returns int
> >  - PAGE_SIZE is typically defined as an unsigned long (depending on the
> >    architecture)
> >  - locksz is unsigned int
> > 
> > The resulting arithmetic expression is promoted to unsigned long.
> > 
> > Thus, the max() macro compares values of different types: unsigned int
> > vs unsigned long.
> > 
> > This issue was introduced in commit b53d6e9525af ("tcp: bring back NUMA
> > dispersion in inet_ehash_locks_alloc()") during the update from kernel
> > v5.10.237 to v5.10.238.
> 
> Please use the upstream SHA1, f8ece40786c9.
> 
> > 
> > It does not exist in newer kernel branches (e.g., v5.15.185 and all 6.x
> > branches), because they include commit d53b5d862acd ("minmax: allow
> 
> Same here, d03eba99f5bf.
> 
> But why not backport it to stable instead ?

I just checked the 5.10.238 thread.
https://lore.kernel.org/stable/2025060412-cursor-navigate-126d@gregkh/

---8<---
> > For both of these, I'll just let them be as they are ok, it's just the
> > mess of our min/max macro unwinding causes these issues.
> > 
> > Unless they really bother someone, and in that case, a patch to add the
> > correct type to the backport to make the noise go away would be greatly
> > appreciated.
> 
> Yeah that's a reasonable resolution, I will try to track down the missing
> patches for minmax.h so we are warning free for the stable kernels.

I tried in the past, it's non-trivial.  What would be easier is to just
properly cast the variables in the places where this warning is showing
up to get rid of that warning.  We've done that in some backports in the
past as well.
---8<---

So this should be fixed up in the backport, and I guess this patch
targeted the stable trees ?

If so, please clarify that by specifying the stable version in the
subject and CCing the stable mainling list:

  Subject: [PATCH 5.10.y] tcp: ...
  Cc: stable@vger.kernel.org, ...

