Return-Path: <netdev+bounces-210209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2430AB1262E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE061C2689D
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 21:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C4124E4A8;
	Fri, 25 Jul 2025 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvxfWT7m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BAC1465A5
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753479859; cv=none; b=NfdKwGwmnFCsDHpTW6KSOUr4ZlDRNqXg3g2yR4am6SvWf9dHoXuq5+AJJllGjY8Cys98Qp35mZ5cLcR0AA5r5QuiTdc9Gu1kPgA9bR/Ga0TW24LAAWiFU7owLgSrlBRYmSBkPXMnStEdEq2Q/LzFWhx55H6XrP7H7mmUCxrYYJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753479859; c=relaxed/simple;
	bh=bUkj5xSp80OkF0SzfWqXezoXWmIJiBEemdW6yxCyQ8U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EmLbaaVMteNSY87uHKw3dnSUCZsTy7Uj+cElpMqz6xG+duFyndciIw6AoxZVbgitsxFwGqbOk7GHGIgdS7V38cT4MnU6aifcyzNIg2+NJLg/PZFJd0nMRpybvCjhnY9MCsUJIaMvpC4DGqJnkvoOqg3x34LMQ2DDMjI2AtNWmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvxfWT7m; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74928291bc3so2422358b3a.0
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753479857; x=1754084657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3+PZlLRGqHNoXRhoksTGR7fQVcc2exxerOsCnlgIDHE=;
        b=rvxfWT7mdZSZuqRPl53uJgdlMOsOq7P5UiaqgWkcdhaVRUPjYx03hRwtZSxMPsIcLk
         oEJDXSgL9wT8WhcdvPEAmXeXCccbXhoTIY62nErGYkRX2oKFzaC2nlzZPsm+xTp9eVVt
         t8igYZjFe+HpMAVkYOYGQ0NWF+tMlbRu733lz44+rv0IgoI2oUpuEpU/Ipojc0hhSi5x
         gWMdT3z82+P37tZRMLKkG8mgj1KTE/TJJwUjDII4ju3rSulZGOvxx356T6yVIvctk6vY
         Ha4eqqu+Dx7Nsf7HD1hn6GfnUo60ok7aI8aQXjNFfpXmk9Gs6IRFomO/wwDckPRCUPvi
         bjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753479857; x=1754084657;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+PZlLRGqHNoXRhoksTGR7fQVcc2exxerOsCnlgIDHE=;
        b=mp/frKHmg23U4aowhsrPRKv5gCujXBMRmi9AaB5lDdYyFvQyxNYPLFKrP9zXdvhMTi
         UYloN1XbRYxJ0LZcIlud1ck0Rxte5EODrOFmUGgD+/iy3sRocTJ6PVDVe3zzyUHJGO1P
         jdZo80Snv+AqsBeKJjC5M7ZARRD1zUvZpEOwRg6nPub5Dd5iGEk6VqoKq1Z5uGqRGEcz
         F79hXFvsdChtef0wG24rUMmOIvlCQwHkU88aEA3gOPhIe8gzyVlweKQ91iuA1wxTqjyO
         xOcKgV2BqGxbLLKU+JfFo5nGDV9MUFmUMLaXTTDwS486O0kFc+SA2+IgvbbXwAteNqDK
         5J0g==
X-Forwarded-Encrypted: i=1; AJvYcCUlwm51gqYZT7euWd3tqozjENGiZJW5mFzTJkoq6gQEUbT9WZguUboCWRQybtvfQM+QKtt1Szg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+j1UP+cdLRr2sSWsgVLISjzpIFcs8Ts8zyd+jJhGGZbzplADW
	g2phNBCiQwussLb9WRPviqQ4pLTOKJdKTjiVFZi5Xm/sp3wL3WEOBJOWCzSkJW043/u1zICel4C
	h2SRPataSAN4MLeZYLnbjBiqbGDeimQ==
X-Google-Smtp-Source: AGHT+IHihIHLR4bcIDbb4J6+u+bWCkyh8D4Hmzl4BF/uzSbYsdSRlthrIlvEZfBIKL44Yz2X0fpgKx1CWMfeddpUGn0=
X-Received: from pfjx28.prod.google.com ([2002:aa7:9a5c:0:b0:746:3162:8be1])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2394:b0:75f:8239:5c25 with SMTP id d2e1a72fcca58-7633286328dmr4966711b3a.10.1753479856833;
 Fri, 25 Jul 2025 14:44:16 -0700 (PDT)
Date: Fri, 25 Jul 2025 21:44:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773; i=samitolvanen@google.com;
 h=from:subject; bh=bUkj5xSp80OkF0SzfWqXezoXWmIJiBEemdW6yxCyQ8U=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBnNvxb+YQ17aCm5yrPc9GnL5Dsy4YIRamm+PiIZmokfH
 x9Yd8Sno5SFQYyLQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAEzE4wIjwz3X5/6F9vqbJm6Y
 EKUpXL8kUWqZVJ6s5p5Fc/bHNtwz1GT4ze501aLVQP3FhL8L5LuaTd5uY67bd/vIJIdXnGanbWV VuQE=
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725214401.1475224-6-samitolvanen@google.com>
Subject: [PATCH bpf-next v2 0/4] Use correct destructor kfunc types
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

While running BPF self-tests with CONFIG_CFI_CLANG (Clang Control
Flow Integrity) enabled, I ran into a couple of CFI failures
in bpf_obj_free_fields() caused by type mismatches between
the btf_dtor_kfunc_t function pointer type and the registered
destructor functions.

It looks like we can't change the argument type for these
functions to match btf_dtor_kfunc_t because the verifier doesn't
like void pointer arguments for functions used in BPF programs,
so this series fixes the issue by adding stubs with correct types
to use as destructors for each instance of this I found in the
kernel tree.

The last patch changes btf_check_dtor_kfuncs() to enforce the
function type when CFI is enabled, so we don't end up registering
destructors that panic the kernel. Perhaps this is something we
could enforce even without CONFIG_CFI_CLANG?

Sami

---
v2:
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
 kernel/bpf/crypto.c                                  | 9 ++++++++-
 net/sched/bpf_qdisc.c                                | 9 ++++++++-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 9 ++++++++-
 4 files changed, 31 insertions(+), 3 deletions(-)


base-commit: 95993dc3039e29dabb9a50d074145d4cb757b08b
-- 
2.50.1.470.g6ba607880d-goog


