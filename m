Return-Path: <netdev+bounces-157880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B67E3A0C216
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B6C3A355C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4DF1D278A;
	Mon, 13 Jan 2025 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvgtU/XB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8191CD213;
	Mon, 13 Jan 2025 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797842; cv=none; b=VFGlN9mkWsp3jra3Hjfg4cMt+HjM4v8PNts1sBUZuc9/UiBXX503vBflyWqr5sNJ83+v1CmgjlgaxW/bqQqgS2glcxZl6Elb+u/d0Gq9A+wKBchAr19ZucaIhh1xV4ztOLmxXpkMZBmVXHqmeUn6qzxYrWDYdBVzkO5mW8zq9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797842; c=relaxed/simple;
	bh=pyu2xTBoW0aEgzWqoq+ogFmvWnrczqCiTxJZuk2iYfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoFEjZtMICaFPDFe3Uu4Z+hZ2BZBIId158aRZxwHKDQISbL5lqMMMdUq2rEhfgl8u4t2T/Cip6JFUntrTYKjM7c0kcT2ldoqhBGea5D2lAwmwXDD5QiITT8hWNShECShgQioaGjQJV920PENNmRpGpEvX7DNfPIxlgZad0k68yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvgtU/XB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2164b1f05caso82209735ad.3;
        Mon, 13 Jan 2025 11:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736797839; x=1737402639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ocUJiUS9yIM24+kENHgiOqFr2KEH4eFueUUh/y9LGGE=;
        b=JvgtU/XBOfOyF7+GL7hhTnt/OK4cTih5JxAq16X+IYjq12R593mGfMHAT45dlnR0KJ
         puqojsONdzJOAQg7NtLOmoKKA9CpwD1dnVgnMlg8qq0ODDnznSyUPmTidJN8PsBDBb//
         aGw6NvfQutTjhKqQNHPsnH1J/Pu2KVrvPkuXRV17AA89W9cjit2bO3Ba8AyEogUS3IJ9
         z5Reh6+1sDkbNb0h09YUrtgqpDNzo4+PgLNEU19BIit7be/RQ0zY9SPmzJJPw/U0XBjp
         rE/I63Yg25TzxB4MYZSTJ+qXNmMgUYKhkU1I4DxJZMl2fM0GHCrdxRSRhJYdI2TnMRtb
         jLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736797839; x=1737402639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocUJiUS9yIM24+kENHgiOqFr2KEH4eFueUUh/y9LGGE=;
        b=X0pw+7YbBN6ryTqkKnmIkOTr97Gb41XLNXTcgQORow2NLEA07ITymS0LRQQo5GCtT4
         9NiKq8On5WDkxvELimdMST8npo62sBUtd+Mg3sN3+5Ab6mgsxBtM/MRlQhi49C1e3b1c
         hDzKYxtR6isAnJnM4mJ7YAV31wg4I7Eyqxh33/FZ62QyIOU7nHT+MRUq7TjJPSOSv1KH
         h7JTuGogCaG1yzqKXsET6SKu1enjH1DYIYexguiGV1fcDDwD90VO9XeEeX+dFNMNauzN
         HC0XO20mC+tIdsktulLIudYB+o7nMNJHFhD/L3A7d8wSZN/9ft79dvNZIaOxiXfGbWSU
         54lg==
X-Forwarded-Encrypted: i=1; AJvYcCUafUv+KjxALZ4hudjXFRA6qUo7ioSJ9GNJ7+VpUqeiqVU6Co3LNAng3cRPWOJqRCXEbySCcQ1PAa7XQWU=@vger.kernel.org, AJvYcCXdIoih2S1PQU+T/xKFzmcZB0nh3AyMxjpAc3d8mwaIGkDF95RUv/ekVMSXSYCQ6vsMp85xsXD1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7IZsylDAiJf0rEnRRbHcUyIiMpvVxIAktJv5nZ0LaT5+ii23R
	8cQS6b/AS19fX9mQDHGSH8Xp4l0x0wf6IUSC4zuD826bAX4JZFY0CyaL2Q==
X-Gm-Gg: ASbGnctg6V6N8ogbrtmTmQnb2vvDo2t62mpg+jAxw4JK9B743ISXKQi3OnVVQHJxpht
	3Jdl2fjp4zm99w1khtMMJIux9T0XjYM91zYk0oHTzcpwa7ipTEfKGF+W4gj1QvOE5orXXpg+G3C
	GpxbXED1GxZUg5mjJw4G+K9GJYUjj88g/39ksTYsZIvteKfY22y3wSFuvGIFdEE9unlSh5XLk/8
	gw41eS2LyjU37iLz24ix1NpcjwD5vfbfwqN2sO8JfZ31JHkjEEv5IWDFMGSpN+O48LbBg==
X-Google-Smtp-Source: AGHT+IFBra9R4T4Kd4oXD6zB5rJnh64n+ccFajkICWNTz+jDdqfekIc/1PEFw+jG9T+Vl9e7u9RTMA==
X-Received: by 2002:a17:902:e88c:b0:216:7ee9:2227 with SMTP id d9443c01a7336-21a83fc73efmr349773885ad.36.1736797839366;
        Mon, 13 Jan 2025 11:50:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22dcf5sm56650305ad.181.2025.01.13.11.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:50:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 13 Jan 2025 11:50:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>, Tejun Heo <tj@kernel.org>,
	Hao Luo <haoluo@google.com>, Josh Don <joshdon@google.com>,
	Barret Rhoden <brho@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Message-ID: <6a0b432d-284a-45eb-991a-c7bba2c93e0b@roeck-us.net>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>

Hi,

On Thu, Nov 28, 2024 at 04:16:25AM -0800, Breno Leitao wrote:
> Move the hash table growth check and work scheduling outside the
> rht lock to prevent a possible circular locking dependency.
> 
> The original implementation could trigger a lockdep warning due to
> a potential deadlock scenario involving nested locks between
> rhashtable bucket, rq lock, and dsq lock. By relocating the
> growth check and work scheduling after releasing the rth lock, we break
> this potential deadlock chain.
> 
> This change expands the flexibility of rhashtable by removing
> restrictive locking that previously limited its use in scheduler
> and workqueue contexts.
> 
> Import to say that this calls rht_grow_above_75(), which reads from
> struct rhashtable without holding the lock, if this is a problem, we can
> move the check to the lock, and schedule the workqueue after the lock.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

With this patch in linux-next, I get some unit test errors.

[    3.800185]     # Subtest: hw_breakpoint
[    3.800469]     # module: hw_breakpoint_test
[    3.800718]     1..9
[    3.810825]     # test_one_cpu: pass:1 fail:0 skip:0 total:1
[    3.810950]     ok 1 test_one_cpu
[    3.814941]     # test_many_cpus: pass:1 fail:0 skip:0 total:1
[    3.815092]     ok 2 test_many_cpus
[    3.822977]     # test_one_task_on_all_cpus: pass:1 fail:0 skip:0 total:1
[    3.823100]     ok 3 test_one_task_on_all_cpus
[    3.829071]     # test_two_tasks_on_all_cpus: pass:1 fail:0 skip:0 total:1
[    3.829199]     ok 4 test_two_tasks_on_all_cpus
[    3.830914]     # test_one_task_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
[    3.830914]     Expected IS_ERR(bp) to be false, but is true
[    3.832572]     # test_one_task_on_one_cpu: EXPECTATION FAILED at kernel/events/hw_breakpoint_test.c:320
[    3.832572]     Expected hw_breakpoint_is_used() to be false, but is true
[    3.833002]     # test_one_task_on_one_cpu: pass:0 fail:1 skip:0 total:1
[    3.833071]     not ok 5 test_one_task_on_one_cpu
[    3.834994]     # test_one_task_mixed: EXPECTATION FAILED at kernel/events/hw_breakpoint_test.c:320
[    3.834994]     Expected hw_breakpoint_is_used() to be false, but is true
[    3.835583]     # test_one_task_mixed: pass:0 fail:1 skip:0 total:1
[    3.835638]     not ok 6 test_one_task_mixed
[    3.837131]     # test_two_tasks_on_one_cpu: EXPECTATION FAILED at kernel/events/hw_breakpoint_test.c:320
[    3.837131]     Expected hw_breakpoint_is_used() to be false, but is true
[    3.837827]     # test_two_tasks_on_one_cpu: pass:0 fail:1 skip:0 total:1
[    3.837882]     not ok 7 test_two_tasks_on_one_cpu
[    3.839868]     # test_two_tasks_on_one_all_cpus: EXPECTATION FAILED at kernel/events/hw_breakpoint_test.c:320
[    3.839868]     Expected hw_breakpoint_is_used() to be false, but is true
[    3.840294]     # test_two_tasks_on_one_all_cpus: pass:0 fail:1 skip:0 total:1
[    3.840538]     not ok 8 test_two_tasks_on_one_all_cpus
[    3.843599]     # test_task_on_all_and_one_cpu: EXPECTATION FAILED at kernel/events/hw_breakpoint_test.c:320
[    3.843599]     Expected hw_breakpoint_is_used() to be false, but is true
[    3.844163]     # test_task_on_all_and_one_cpu: pass:0 fail:1 skip:0 total:1
[    3.844215]     not ok 9 test_task_on_all_and_one_cpu
[    3.844453] # hw_breakpoint: pass:4 fail:5 skip:0 total:9
[    3.844610] # Totals: pass:4 fail:5 skip:0 total:9
[    3.844797] not ok 1 hw_breakpoint

Sometimes I also see:

[   12.579842]     # Subtest: Handshake API tests
[   12.579971]     1..11
[   12.580052]         KTAP version 1
[   12.580410]         # Subtest: req_alloc API fuzzing
[   12.582206]         ok 1 handshake_req_alloc NULL proto
[   12.583541]         ok 2 handshake_req_alloc CLASS_NONE
[   12.585419]         ok 3 handshake_req_alloc CLASS_MAX
[   12.587291]         ok 4 handshake_req_alloc no callbacks
[   12.589239]         ok 5 handshake_req_alloc no done callback
[   12.590758]         ok 6 handshake_req_alloc excessive privsize
[   12.592642]         ok 7 handshake_req_alloc all good
[   12.592802]     # req_alloc API fuzzing: pass:7 fail:0 skip:0 total:7
[   12.593185]     ok 1 req_alloc API fuzzing
[   12.597371]     # req_submit NULL req arg: pass:1 fail:0 skip:0 total:1
[   12.597501]     ok 2 req_submit NULL req arg
[   12.599208]     # req_submit NULL sock arg: pass:1 fail:0 skip:0 total:1
[   12.599338]     ok 3 req_submit NULL sock arg
[   12.601549]     # req_submit NULL sock->file: pass:1 fail:0 skip:0 total:1
[   12.601680]     ok 4 req_submit NULL sock->file
[   12.605334]     # req_lookup works: pass:1 fail:0 skip:0 total:1
[   12.605469]     ok 5 req_lookup works
[   12.609596]     # req_submit max pending: pass:1 fail:0 skip:0 total:1
[   12.609730]     ok 6 req_submit max pending
[   12.613796]     # req_submit multiple: pass:1 fail:0 skip:0 total:1
[   12.614250]     ok 7 req_submit multiple
[   12.616395]     # req_cancel before accept: ASSERTION FAILED at net/handshake/handshake-test.c:333
[   12.616395]     Expected err == 0, but
[   12.616395]         err == -16 (0xfffffffffffffff0)
[   12.618061]     # req_cancel before accept: pass:0 fail:1 skip:0 total:1
[   12.618135]     not ok 8 req_cancel before accept
[   12.619437]     # req_cancel after accept: ASSERTION FAILED at net/handshake/handshake-test.c:369
[   12.619437]     Expected err == 0, but
[   12.619437]         err == -16 (0xfffffffffffffff0)
[   12.621055]     # req_cancel after accept: pass:0 fail:1 skip:0 total:1
[   12.621119]     not ok 9 req_cancel after accept
[   12.622342]     # req_cancel after done: ASSERTION FAILED at net/handshake/handshake-test.c:411
[   12.622342]     Expected err == 0, but
[   12.622342]         err == -16 (0xfffffffffffffff0)
[   12.623547]     # req_cancel after done: pass:0 fail:1 skip:0 total:1
[   12.623608]     not ok 10 req_cancel after done
[   12.625297]     # req_destroy works: ASSERTION FAILED at net/handshake/handshake-test.c:469
[   12.625297]     Expected err == 0, but
[   12.625297]         err == -16 (0xfffffffffffffff0)
[   12.626633]     # req_destroy works: pass:0 fail:1 skip:0 total:1
[   12.626696]     not ok 11 req_destroy works
[   12.626837] # Handshake API tests: pass:7 fail:4 skip:0 total:11
[   12.627298] # Totals: pass:13 fail:4 skip:0 total:17
[   12.627446] not ok 90 Handshake API tests

The log is from a test with x86_64, but other architectures are affected
as well. Reverting this patch fixes the problem.

Bisect log is attached for reference.

Guenter

---
# bad: [37136bf5c3a6f6b686d74f41837a6406bec6b7bc] Add linux-next specific files for 20250113
# good: [9d89551994a430b50c4fffcb1e617a057fa76e20] Linux 6.13-rc6
git bisect start 'HEAD' 'v6.13-rc6'
# good: [25dcaaf9b3bdaa117b8eb722ebde76ec9ed30038] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 25dcaaf9b3bdaa117b8eb722ebde76ec9ed30038
# bad: [c6ab5ee56509953c3ee6647ac9f266a7c628f082] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
git bisect bad c6ab5ee56509953c3ee6647ac9f266a7c628f082
# good: [39388d53c57be95eafb0ce1d81d0ec6bd2f6f42d] Merge tag 'cgroup-dmem-drm-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux into drm-next
git bisect good 39388d53c57be95eafb0ce1d81d0ec6bd2f6f42d
# bad: [0f8b2b2250abe043cef890caa378bebe5c4f5d88] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
git bisect bad 0f8b2b2250abe043cef890caa378bebe5c4f5d88
# good: [67fcb0469b17071890761d437bdf83d2e2d14575] Merge branch 'spi-nor/next' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
git bisect good 67fcb0469b17071890761d437bdf83d2e2d14575
# bad: [7fd4a4e4c397fc315f8ebf0fb22e50526f66580a] Merge branch 'drm-next' of https://gitlab.freedesktop.org/agd5f/linux
git bisect bad 7fd4a4e4c397fc315f8ebf0fb22e50526f66580a
# good: [e2c4c6c10542ccfe4a0830bb6c9fd5b177b7bbb7] drm/amd/display: Initialize denominator defaults to 1
git bisect good e2c4c6c10542ccfe4a0830bb6c9fd5b177b7bbb7
# bad: [5b7981c1ca61ca7ad7162cfe95bf271d001d29ac] crypto: x86/aes-xts - use .irp when useful
git bisect bad 5b7981c1ca61ca7ad7162cfe95bf271d001d29ac
# good: [ce8fd0500b741b3669c246cc604f1f2343cdd6fd] crypto: qce - use __free() for a buffer that's always freed
git bisect good ce8fd0500b741b3669c246cc604f1f2343cdd6fd
# good: [5e252f490c1c2c989cdc2ca50744f30fbca356b4] crypto: tea - stop using cra_alignmask
git bisect good 5e252f490c1c2c989cdc2ca50744f30fbca356b4
# good: [f916e44487f56df4827069ff3a2070c0746dc511] crypto: keywrap - remove assignment of 0 to cra_alignmask
git bisect good f916e44487f56df4827069ff3a2070c0746dc511
# bad: [b9b894642fede191d50230d08608bd4f4f49f73d] crypto: lib/gf128mul - Remove some bbe deadcode
git bisect bad b9b894642fede191d50230d08608bd4f4f49f73d
# bad: [e1d3422c95f003eba241c176adfe593c33e8a8f6] rhashtable: Fix potential deadlock by moving schedule_work outside lock
git bisect bad e1d3422c95f003eba241c176adfe593c33e8a8f6
# first bad commit: [e1d3422c95f003eba241c176adfe593c33e8a8f6] rhashtable: Fix potential deadlock by moving schedule_work outside lock

