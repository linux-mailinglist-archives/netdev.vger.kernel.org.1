Return-Path: <netdev+bounces-248680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B00D0D319
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 09:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E33F9301585F
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D4C2C21DD;
	Sat, 10 Jan 2026 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNaipUC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613824A02
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033557; cv=none; b=MlNqxqBgMLroa8SSphJIPlPD8qDHH2CCSTHpt7WNkxU7cXdDtq55WQmv10PLUccUC8uMHvY9HnhyFloGoAnMufEPwmlkMrLqd7xmYa4TIMJCsC/x0j5fj8NFBirPHjbjRRUko4ScRR+0jddsckNS7W45YvpW/YQB1Uty8W6E7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033557; c=relaxed/simple;
	bh=+WCxHkobeBiamCzOgNQN1b1ukkZevHJDtSyFuYSqpzE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZenD7VP+QkNQxJRjp8Xkq0aPLnc2mYe4wv5Y1rduXCE7ilVXzB3TYwpasrhCEUGk70wDssmyAQBR8rh3UconNEk6ZEE7gm2PULE/ylfpMkUZNYNCpnKtI0THf+mNMFDOT4Gm5h4rRlQjFGgXbH69ZCCJv5IVHikxqu6dNOp3X2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNaipUC5; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1219f27037fso20891231c88.1
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 00:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768033555; x=1768638355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iWBBLHK2sr+uF7Yqahqe2lWrrVOJVg2mMFqkCxu3N3o=;
        b=SNaipUC55GiHgkC1YHM9Rh+nRa7JWnZvYS+k79rdbunryZU8U1Ap1OspaCWFYL2fRb
         /5IEFLT4D1jh7s0RdceTj+KrPU/czdgFVTgKcpipfk6m8CzXIj0W8fUwIDxsDuAZomjl
         BKmgpX/7c78+5YQJZ1/yRHutQZobYl6b8ZaQ1sLtf4+ZhkfhU047bKlwXDzk86xRIsVm
         WFaDCBvpHCGv7rQ5u6Kz53MaYoomQb3eW7dautFCc3wu5LkL8kcv/t/Wn5PdJrw0nePj
         Pagr87qAcioLbvc3ZaBadgkQsxLdmMKkEKubtv4rsc7WGjnHoQdBLaijpsOYwSb0OciS
         trVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033555; x=1768638355;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iWBBLHK2sr+uF7Yqahqe2lWrrVOJVg2mMFqkCxu3N3o=;
        b=rQEOyxf9UdteuLK7cKerNUcdP2yHQMKJoiIcOPiUeuKxaA/gWeqdtNLg1zwd7WiQo4
         dgdzm1mPRnr7366Y1ANJKauUKZyChlON113MDnxU4OE5jpDtOJIiD1k2SujpPbakTECW
         oIABhDbECoyDdr0OJmN+OHz2MrwQKXcLtAKi/wmzEef2cOG7m2cfLIsSGlHEtr8nlJ6g
         OkS5624HBIlghalZ3o0qPsdVjXuAFEnYQ6MabFk2h4pT6Ie7i7/TJQO/ZVWan63xUx1N
         X169lG7WLXhgxL7/Edb4wbSsj/8T0FJfbTdaqd/JNvI1TjOW2OOPkqvItWrodJR3h59k
         U6JA==
X-Forwarded-Encrypted: i=1; AJvYcCVoA1xaUvvuZBL5Ri/ZYqWcdUcQ3/CuQ+2xcVFFLkYaTXm4OmhjA7/5rT0UEGQ3sAtfwwhuQ5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Bv7wXgQFhy5EFcTWF7JKwIc45sbAveR19xNqXSyu78vGzuoI
	wBgiArwgWJi8YuUXdKCayzsLowTSFTGag7imCKmdi3lJCX9FThfZjUY2/AmJ6eZe3590+Zwh17g
	At1dnMf2OYsU/fu9xLJIUCFK1/AFhTg==
X-Google-Smtp-Source: AGHT+IHxLIJv96PRs95CR1ojfDI8HdfrX1TZOcGlAqJf2BSMh2rHldiYFXn4BO9stMSyoMeJTnQ+6APQ3tlZrxv0GZg=
X-Received: from dlbuy4.prod.google.com ([2002:a05:7022:1e04:b0:11f:3f33:f0a5])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:fb09:b0:122:153:d161 with SMTP id a92af1059eb24-1220153da5emr7432434c88.17.1768033555440;
 Sat, 10 Jan 2026 00:25:55 -0800 (PST)
Date: Sat, 10 Jan 2026 08:25:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; i=samitolvanen@google.com;
 h=from:subject; bh=+WCxHkobeBiamCzOgNQN1b1ukkZevHJDtSyFuYSqpzE=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJlJvLwTHZam71i8x/P7m0IpH+kVFtG6tncamdXv8U5fe
 r+9OcS8o5SFQYyLQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAExkgS8jw6/UNYqCixJVfn1d
 GfBQdj7T58bcx41aN74tnfWIv+aB9wqG/3Enpx2OCHm6+/hBEwsVj4a4K2ohDH9zWqw2bHm6Qvr yER4A
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260110082548.113748-6-samitolvanen@google.com>
Subject: [PATCH bpf-next v5 0/4] Use correct destructor kfunc types
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Viktor Malik <vmalik@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

While running BPF self-tests with CONFIG_CFI (Control Flow
Integrity) enabled, I ran into a couple of failures in
bpf_obj_free_fields() caused by type mismatches between the
btf_dtor_kfunc_t function pointer type and the registered
destructor functions.

It looks like we can't change the argument type for these
functions to match btf_dtor_kfunc_t because the verifier doesn't
like void pointer arguments for functions used in BPF programs,
so this series fixes the issue by adding stubs with correct types
to use as destructors for each instance of this I found in the
kernel tree.

The last patch changes btf_check_dtor_kfuncs() to enforce the
function type when CFI is enabled, so we don't end up registering
destructors that panic the kernel.

Sami

---
v5:
- Rebased on bpf-next/master again.

v4: https://lore.kernel.org/bpf/20251126221724.897221-6-samitolvanen@google.com/
- Rebased on bpf-next/master.
- Renamed CONFIG_CFI_CLANG to CONFIG_CFI.
- Picked up Acked/Tested-by tags.

v3: https://lore.kernel.org/bpf/20250728202656.559071-6-samitolvanen@google.com/
- Renamed the functions and went back to __bpf_kfunc based
  on review feedback.

v2: https://lore.kernel.org/bpf/20250725214401.1475224-6-samitolvanen@google.com/
- Annotated the stubs with CFI_NOSEAL to fix issues with IBT
  sealing on x86.
- Changed __bpf_kfunc to explicit __used __retain.

v1: https://lore.kernel.org/bpf/20250724223225.1481960-6-samitolvanen@google.com/

---
Sami Tolvanen (4):
  bpf: crypto: Use the correct destructor kfunc type
  bpf: net_sched: Use the correct destructor kfunc type
  selftests/bpf: Use the correct destructor kfunc type
  bpf, btf: Enforce destructor kfunc type with CFI

 kernel/bpf/btf.c                                     | 7 +++++++
 kernel/bpf/crypto.c                                  | 8 +++++++-
 net/sched/bpf_qdisc.c                                | 8 +++++++-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 8 +++++++-
 4 files changed, 28 insertions(+), 3 deletions(-)


base-commit: 5714ca8cba5ed736f3733663c446cbee63a10a64
-- 
2.52.0.457.g6b5491de43-goog


