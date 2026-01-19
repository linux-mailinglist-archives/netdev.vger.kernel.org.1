Return-Path: <netdev+bounces-251276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E70EAD3B7AE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A343130010E8
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC312DF138;
	Mon, 19 Jan 2026 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IvGhHEDq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C670296BD6
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852438; cv=none; b=o5u0a0VcnUdswKmHsL4UafIieHt9hoUugSXsuHDQXz9bghM2g//aByuAkCX3JM0yzgXcKHh8kM6ENb/0hJHuGq1PpCyROEKKUvqfrhAA0knfTWS0Jk18viBZKoYDGt5wrggtfT73MM0Ar29K3rtlL3TOSEcUyD2RKTKHCMpSWSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852438; c=relaxed/simple;
	bh=90QMWnjCg4N0niL+RNXlsTEjnabJWT8FcDlgDnSm+Rk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GFDBvMUfJRTBh47ZgHwZKl5PtTrxvvfsmr+0LrYmWCIu8IfyYF4ad4tHQOCcmg33XNe1kRwgAdlG4xWkrDBwKSvR7D9Xx0QxzjUDFPPQLKJ0FaO/q0J72vdUYmoSVtVYQY84TkNH3j7eeNvlnVLQiL1b5bkjSAAnR8mp0iuVJow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IvGhHEDq; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so8008935a12.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768852436; x=1769457236; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGl2ih0bFcK2HkHqlgtrfAO45PgnsB0zF3nmRHfuZNo=;
        b=IvGhHEDqd61MVjuwsISaO2md8KuMFiN1SP+/5r8P9Hs1iPHEkkH5aSHJFzXSrQBmSj
         /eR2Uv9W1I0MO1g32GP04H9HsvOnSkdHmr4Wm9qB5DD2ijzPq2+ju3D9gxPmDEzT4zId
         4X2hJfDuMty7a2pqBryuFN0OTV6ayl2dQqg7V56aCVDhGaRobma18QhnKvzfCXRfvgR0
         +Sn0m5Y/66G04TbQh8bkOouT2MMiusFLtLhqgDmOZ9ZeLuAlQ2UuooOsvxDU/R6nrU0d
         kwmAWVG9aTr2tSLX1thnHJNEsDdfzdG8S6doeadNZNi15pN+YSxzRPWz2AdSwxR6IHzh
         MRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768852436; x=1769457236;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGl2ih0bFcK2HkHqlgtrfAO45PgnsB0zF3nmRHfuZNo=;
        b=pWp3jylxciGQpiFeD4Hf1hdevqeRvFZXlijwLdgdtRUW7pQoZs4NsHIZrWSWFmxWVJ
         RRs0vDHZIy1d57WGft61491dbvk69WLksCxzBms4DETu+iVPgkZ/JZDGtSq/m7E4qc4l
         rWpNdrBwKxtRBKvKZRJJDGy7+hHITr+J+L7o9osvwQqKeNLBb3QRLPl/vJnuBmjXVNNL
         6bx4gfWnljF19mM88gwjadu1LHP/G+athezT6k9gDvUh2dEBGuA+E2XixJS3q2CIHPaw
         m1sn2PJ5XROKIfQd29sJJoFcCdurR2gsg7k4OCDfLSXMKhmIvMdOPWzfAMAPgspuxcOB
         a6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCNFqRi0hto1VkrARjO4N4zPt3ZX98U6pR/ed3oK9z1LuR2i45i47ef/YFvvvs5S4DXg+C2Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyokuIOn3TPNGRy7xB0j0g9PNSrq1UDihASvMTPZon6WKonCZJL
	NHzg2GASephjCs96dNT2A/6wtJgl9zmKS5qyRDeBlCJQlX12Xr3yiEnFjnZSV9A3iYM=
X-Gm-Gg: AZuq6aKQ34/BkEW8qUvuuJYA4lkmAurYZvPuWrBHAQ9wfSjFfzgvr1oWYkYeWMVYIjJ
	Ucxdh1t+tVdvsWXOQjB+qfBlXymDbqk8Uph0VS+BqFyansBpga3Jm0sEhb1ABaB6TOc6y27VS27
	qjUEqVui/Z6Yk5vMvhzAaJSqiloRFrs4mqbydIe8PVMW7q07X3l6SqvKpASEj7kYbSGm23crbo3
	pbEkiSmzroLozu/nhyyEbe2ofoBUF/VaOGsbHB9Hx3yk0udSY9ftqA7qQ+5PTa0SyBBtieHabZI
	nsmqNw+d6yTPFY2hCkA3lksctkqBBUGVTkMNluxYv6SUrPbB6pqzyPyADHIrAr4JupvYQeDsHtL
	DREX9NBEaxlIz5UlODCUsSDKw/42OYhRuaylBrg2OwnHj48PwWn2ULZcUfIpD13yvQpQQ1OgUrY
	OFB0RQdDfGSocV/SRToDVjY+DQVHPriT5m1AuOX/xGfFW/ChdPaEaeXaSXwzs=
X-Received: by 2002:a17:907:d03:b0:b87:892:f43f with SMTP id a640c23a62f3a-b87969386d0mr1039368166b.29.1768852435761;
        Mon, 19 Jan 2026 11:53:55 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959fbefdsm1165986966b.55.2026.01.19.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:53:55 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next 0/4] Switch from kfuncs to direct helper calls in
 prologue/epilogue
Date: Mon, 19 Jan 2026 20:53:50 +0100
Message-Id: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM6LbmkC/x2NywrCMBAAf6Xs2YUmgkZ/RTyk6aYu5sUmlULpv
 xs9zmFmdqgkTBXuww5CH66cUwd1GsC9bFoIee4MetSXUSmN9T1hpGZxKh4pckNnQ0AvOWKRHPK
 yEs7a3Yw6e2OuFnqqCHne/psH/MREW4PncXwB963tXIAAAAA=
X-Change-ID: 20260112-skb-meta-bpf-emit-call-from-prologue-d2c9813f887a
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

This series enables direct helper calls using BPF_EMIT_CALL from prologue
and epilogue code generated by verifier ops. The goal is to simplify the
calling convention and remove kfunc support from prologue/epilogue, as
suggested by Alexei [1].

Patch 1 adds the infrastructure to mark direct helper calls as finalized
(already resolved) so the verifier skips the imm fixup.

Patch 2 converts bpf_qdisc to use BPF_EMIT_CALL instead of BPF_CALL_KFUNC
for the init prologue and reset/destroy epilogue helpers.

Patch 3 removes the now-unused kfunc support code from prologue/epilogue
handling in the verifier.

Patch 4 removes the corresponding selftests that exercised kfuncs in
prologue/epilogue.

[1] https://lore.kernel.org/bpf/CAADnVQJ=kmVAZsgkG9P2nEBTUG3E4PrDG=Yz8tfeFysH4ZBqVw@mail.gmail.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (4):
      bpf, verifier: Support direct helper calls from prologue/epilogue
      bpf: net_sched: Use direct helper calls instead of kfuncs in pro/epilogue
      bpf: Remove kfunc support in prologue and epilogue
      selftests/bpf: Remove tests for prologue/epilogue with kfuncs

 include/linux/bpf_verifier.h                       |  1 +
 kernel/bpf/verifier.c                              | 47 +++++------
 net/core/filter.c                                  |  3 +-
 net/sched/bpf_qdisc.c                              | 76 ++++++++----------
 .../selftests/bpf/prog_tests/pro_epilogue.c        |  2 -
 .../selftests/bpf/progs/pro_epilogue_with_kfunc.c  | 88 ---------------------
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 92 ----------------------
 7 files changed, 61 insertions(+), 248 deletions(-)


