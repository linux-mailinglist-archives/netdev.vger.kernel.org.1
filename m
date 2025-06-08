Return-Path: <netdev+bounces-195569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C5FAD1425
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 22:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD0B7A4DF4
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 20:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9225484B;
	Sun,  8 Jun 2025 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6AWvpH8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E70250BEC;
	Sun,  8 Jun 2025 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749413551; cv=none; b=Hyra2DDgeZPc3upzP5EM0BmVEhobdbgsn7TyqmtL+bThKtAP4YYv5aQ7Tgo3b5E/qmcda5TZnKGKuR26LBjFLOX6LBM9PuSky48TFpvC5H/x6E4PSI6X4gNFMFVYOrEzru9EHHVtfYdxz8RmKFxdYTc/nBy32eDkSrvwLdO2vpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749413551; c=relaxed/simple;
	bh=N1eSTFvJKNoqU8AEqaskHYhTlh2oo+27+yZhAYeBUio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VN5CBXowZ1Hnk8EyY6IRGG+1jiMn7B0jx/8vgzzfIx7B/+MWg7a1IwXvdI6zgUPJkcgoqQUDBhWd8ew8RsTqVBCnfgZawzG+B/i4p/PBurHbHr3Eb3SWnjBO7v5WPqxy64LBLVFeVeCTn/XrMfSkBQojrK6/TqwX1hG/av6F1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6AWvpH8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234f17910d8so35342785ad.3;
        Sun, 08 Jun 2025 13:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749413549; x=1750018349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxHLeyRnsKqoym12d89ymZgGhfKHaU9GX2ztWPNSHWk=;
        b=V6AWvpH8poD7nljNK/+kWPtTgYd/8WnNsARwv+9A4s6wXHddxHJra1b2ghI4uIF/Mw
         nEVNTnxGnaC8i3dwOBSItDYO5oaNdODRLBYzb7sWBBzk8iwvhxS2ZNrApwpY78wFSG4p
         rD8zWdMUjBZHVa3RVy3WqrhJgZfKRG9ka5swr2rX8oUpHRuVPd8NO7ZJlbsf5740CekZ
         lkZMkq+D+JIj4quC1CO+PDVmv4r9H9RYzqHEDq7sBmmEg5sB2CGnlMUZF0UhpSssmIBC
         NSxjIAdS5BaTlWrW0qlqLRkSlsnuQZg0pIh6q/4IXkBmKUyPCJP+Xv9NHAJ0Qal1eAu+
         2UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749413549; x=1750018349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxHLeyRnsKqoym12d89ymZgGhfKHaU9GX2ztWPNSHWk=;
        b=JxXRuMNcwekAHV5d0cbubed6Jd5T2TGNPwcTKEpjSjifQFtHYW9ULaanbRUtTUaHJW
         jduF/Q1YLsr89xB6GWj/VN3pXHVnw0vhG2yurS84UQvof3b1tJa2FgruIPEjGMbh9ZiL
         1gwKR8tZqb6cRQPlblIehieF2cT4/eGet+OGKI9YFuPYZtTJGGkVb/tGDLhHTian+P9r
         RuntLicPgGKUs+LGUUCQ421AHg87z7yLiPFLnLUFJjIUTPrABw4huwX2uwb92VnSMixQ
         Zkr9rS1RgROSP5ok0L3XWUhFOaR54RGOes97qOA4EMucucP+sg/Vkb/9PBmLOKIuR9y2
         Gs4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3yNX9avkx9Xb1QEn8CdIq0RO8pdeVBvrHL+o/WOc9aK9t1eZ468KyotPLR7NWRgiPvJ/j2DHk@vger.kernel.org, AJvYcCWKd9ZAkqN88TRWdhXHnRhmtB2ih5IRC24yTY5wRsxHMuk6SP20ErJxnXX5y66xIDqV5XfI9fUUTJzdTbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+pHdK3+58S9fXOKPG81ZwVd0ZtlXkEzTXJxW8GAww9QAHBlEc
	qdFL+L2SOolXfD8cDw0G0M2xT9eZPxd66WnZrc6MpbkQwF/Yjx/8IsLRvXoQA1uX4Q==
X-Gm-Gg: ASbGncuSQnAfW2jK8QydQpjYleCCXDb74fG2NF8f8iups8GY4ajru+0UAhbr/n7KvzY
	RaCRJETA6Xbm3PBXTNbXooLeFI2ZKTcSa0ArV0bJcy99rrwOX984z2515Be262gXURcNCdrIoy2
	Pe/kvTZBAXXcIO/tPxjAVc3MyIgxqpr3Tz41t2edR8gd1Ab1YH1d15UOruv0tCtjJ+oN9FApDg+
	HRjnHs0TPHD764LOtMMwWO9DG6TqswNGgJY6ZydRX7Udur3fxrFQiTZIy5UaMrl2d4tuY5Biep3
	WAlkCxsWMgXcPB95UPpuHc4kP8UeLNqv+CopdFw=
X-Google-Smtp-Source: AGHT+IG5U06yyoQPCY2LojyGdsbBtg78ndpLkKTR8tlgEcN1NTJBSMqDq1y6/hy9dPqPQNAUjhiOag==
X-Received: by 2002:a17:902:da84:b0:22f:c19c:810c with SMTP id d9443c01a7336-23601debfabmr132882975ad.51.1749413548965;
        Sun, 08 Jun 2025 13:12:28 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236037ae33dsm41967515ad.206.2025.06.08.13.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 13:12:28 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: farbere@amazon.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	kuniyu@amazon.com,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sashal@kernel.org,
	yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] net/ipv4: fix type mismatch in inet_ehash_locks_alloc() causing build failure
Date: Sun,  8 Jun 2025 13:11:51 -0700
Message-ID: <20250608201227.3970666-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608060726.43331-1-farbere@amazon.com>
References: <20250608060726.43331-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Eliav Farber <farbere@amazon.com>
Date: Sun, 8 Jun 2025 06:07:26 +0000
> Fix compilation warning:
> 
> In file included from ./include/linux/kernel.h:15,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/module.h:12,
>                  from net/ipv4/inet_hashtables.c:12:
> net/ipv4/inet_hashtables.c: In function ‘inet_ehash_locks_alloc’:
> ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
>    20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>       |                                   ^~
> ./include/linux/minmax.h:26:18: note: in expansion of macro ‘__typecheck’
>    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>       |                  ^~~~~~~~~~~
> ./include/linux/minmax.h:36:31: note: in expansion of macro ‘__safe_cmp’
>    36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>       |                               ^~~~~~~~~~
> ./include/linux/minmax.h:52:25: note: in expansion of macro ‘__careful_cmp’
>    52 | #define max(x, y)       __careful_cmp(x, y, >)
>       |                         ^~~~~~~~~~~~~
> net/ipv4/inet_hashtables.c:946:19: note: in expansion of macro ‘max’
>   946 |         nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
>       |                   ^~~
>   CC      block/badblocks.o
> 
> When warnings are treated as errors, this causes the build to fail.
> 
> The issue is a type mismatch between the operands passed to the max()
> macro. Here, nblocks is an unsigned int, while the expression
> num_online_nodes() * PAGE_SIZE / locksz is promoted to unsigned long.
> 
> This happens because:
>  - num_online_nodes() returns int
>  - PAGE_SIZE is typically defined as an unsigned long (depending on the
>    architecture)
>  - locksz is unsigned int
> 
> The resulting arithmetic expression is promoted to unsigned long.
> 
> Thus, the max() macro compares values of different types: unsigned int
> vs unsigned long.
> 
> This issue was introduced in commit b53d6e9525af ("tcp: bring back NUMA
> dispersion in inet_ehash_locks_alloc()") during the update from kernel
> v5.10.237 to v5.10.238.

Please use the upstream SHA1, f8ece40786c9.

> 
> It does not exist in newer kernel branches (e.g., v5.15.185 and all 6.x
> branches), because they include commit d53b5d862acd ("minmax: allow

Same here, d03eba99f5bf.

But why not backport it to stable instead ?

In the first place, f8ece40786c9 does not have Fixes: and seems
to be cherry-picked accidentally by AUTOSEL.


> min()/max()/clamp() if the arguments have the same signedness.")
> 
> Fix the issue by using max_t(unsigned int, ...) to explicitly cast both
> operands to the same type, avoiding the type mismatch and ensuring
> correctness.

The cover letter of d03eba99f5bf says:
https://lore.kernel.org/all/b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com/

---8<---
The min() (etc) functions in minmax.h require that the arguments have
exactly the same types.

However when the type check fails, rather than look at the types and
fix the type of a variable/constant, everyone seems to jump on min_t().
In reality min_t() ought to be rare - when something unusual is being
done, not normality.
---8<---

So, the typecheck variant should be rare, and it was merged 2 years ago,
so there should be more places depending on the commit.

Once someone backported such a change to stable trees again and required
this type of "fix", it would revert the less-typecheck effor gradually,
which should be avoided.


> 
> Fixes: b53d6e9525af ("tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()")
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  net/ipv4/inet_hashtables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index fea74ab2a4be..ac2d185c04ef 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -943,7 +943,7 @@ int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
>  	nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U) * num_possible_cpus();
>  
>  	/* At least one page per NUMA node. */
> -	nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
> +	nblocks = max_t(unsigned int, nblocks, num_online_nodes() * PAGE_SIZE / locksz);
>  
>  	nblocks = roundup_pow_of_two(nblocks);
>  
> -- 
> 2.47.1

