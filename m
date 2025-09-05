Return-Path: <netdev+bounces-220230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFF1B44D1E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 07:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EE11C225CA
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 05:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1FB21B9DB;
	Fri,  5 Sep 2025 05:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JmdFvnl1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0F9211460
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 05:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049509; cv=none; b=rvueaD4DRV32+pOYtr9h8UDHf1OK3bBz4cDG4/QB5nWxSbN8nVmvvOs52GjbaDZatyY0YKU75ixWBxQ1RG5l+e7ij9jdQjPkCZ3qQbdz4faPINoZUkH2KQWfWH2YYlgNc9nruD9Q5lC+et2xGDPLifcWfGrgIrx0cQLnsdimsc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049509; c=relaxed/simple;
	bh=ygTZIPfgCo6hNG+cPV9VDgeofT3k1nLuYT1YU2g1kQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5yeND1Yg3VnUrqkDIcbSSyaJSugBMAN0V26mcH1bkp1Z068ZQFQF6xsT7BtPGur1k5xu8BbZfBlmlsQAGh8C4CIQstnjVbykdXFycbg9g3DMxGy+d7HmlBvTRXhxXTvIeg7fAqnKmpd7N5qudy7kx9W5u7pN35EQEkY6IY3yzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JmdFvnl1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso1378756f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 22:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757049504; x=1757654304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KbidYaPpONskm2RHlehMffMFV6QihoSSM5d6KYCHNk0=;
        b=JmdFvnl16+cYHRk1Bvoh0HvzNM2zfOOjT7obNjzXDoIfAiDnWv21pItK5XT9P5lhXj
         YCELLl2FTc5s6uhDaofDLTw4GaBUiD2Bl2A0AlfY1yvbGBS40CLeHS9k60+aN4rYt03/
         umGtR/DVWLshNGN9HNjV/3PGdecfl0WrRDweRexz52ldM8teKFyxLDMV/twf3WWMF3Ly
         znQa21NpWij9uBchc1kVBI+1iuhcMBvbeq5UjFxWtaN5d2Yak7AMa3pSVPnRnU6W78NP
         mG23bazweJxSs4L1kE3R3j+qrRme+LwJ5uKTsKjBKhvvyW5hFfYPv2oDsIxRCBwV+4TT
         xHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757049504; x=1757654304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbidYaPpONskm2RHlehMffMFV6QihoSSM5d6KYCHNk0=;
        b=MojO9cKqIgoBrQ+b2/LaTiAz/V1qqdZ/EdRYwDENFByliB+CCU4RCDz700q5/Enps5
         Q8wSmfGZdX5NY8M1n8ThiI5nzJQIsVhkK3UtKFcPdPpzZgfHoMokCO8lE3WCuvOPinbP
         6vZkwHXmnckWhsPS4eW8L0pn9KRlQvQJOcuII8+MOzr6RGA6e+uYsy7sUrTPy6R57gcZ
         72WGFB74sSjo6D563OximnTA1QgAEhMpdlglljlqL6xIWwCBYhKYzTMJs0s3/SkMFqwx
         dQF0KfHcg5Z7St/eTgRHY0HopTgWXeIlS3ibK+YVw+PlE/vfioHdX3XWhzk+UXHQQU+2
         O80g==
X-Gm-Message-State: AOJu0YzMEw0qdZbKTX2AsDeYJJQBRJM8/6rJyuFbDiDwKzEBF0+ltSCT
	5SNatV0MSbKqoDrij1p+aHVCFp3Viuk2G3VK0AzmfE91vQ9vKi1kvbdZ/lST68LvpHwPJbCE6Lt
	LtT7Mx5qbfQ==
X-Gm-Gg: ASbGncuNQpLEPj/MMdR7cuPvsY/lhKrS9Qk3HxrBauSy1sG+K06uueXGAygWFlid/bx
	WCCzEkoGISGUkp+u9wGHl9wMY0010+CgvBx93miNPogdJ+UTq7jpNcDzkUvY9TmZRnLFvygi+ou
	BF2TafRQvVvvLaRBOt0fYEj3pMtTr6UjNfe8g9QmFObWZ/danUrZdbFOWew29JKztANftikyOHb
	BSBhkrbmGfKPKPFtD3M6f9kb33pmDCmdkrKs3O6iky3pUpa3hJbr8obpRhp/d4lqXGTFx8bHprh
	5jyZ1Nu2U6Z7iJL0KEIyyBeZHrvjbakkNeyhaF35QevgaPXTAYbsvrWxq5FbXSLvffSqqo6vA9j
	G5baG9ZyX3yMUwjdP1icynruEDUICDf77xehZew==
X-Google-Smtp-Source: AGHT+IFVJ7Ek9klNQOz86proipcWUUpbFNH1LIRA+A1sQqLYNggp1aEWZp2EFhKAmEv4xD4F+marag==
X-Received: by 2002:a5d:64c7:0:b0:3d0:ae58:e337 with SMTP id ffacd0b85a97d-3d1dcb76478mr17958366f8f.14.1757049504225;
        Thu, 04 Sep 2025 22:18:24 -0700 (PDT)
Received: from F5.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcf04b8sm27410154a91.26.2025.09.04.22.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 22:18:23 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: 
Cc: netdev@vger.kernel.org,
	Hoyeon Lee <hoyeon.lee@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf)),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [RFC bpf-next v2 0/1] libbpf: add compile-time OOB warning to bpf_tail_call_static
Date: Fri,  5 Sep 2025 14:18:11 +0900
Message-ID: <20250905051814.291254-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC adds a compile-time check to bpf_tail_call_static() to warn
when a constant slot(index) is >= map->max_entries. This uses a small
BPF_MAP_ENTRIES() macro together with Clang's diagnose_if attribute.

Clang front-end keeps the map type with a '(*max_entries)[N]' field,
so the expression

    sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)

is resolved to N entirely at compile time. This allows diagnose_if()
to emit a warning when a constant slot index is out of range.

Example:

    struct { /* BPF_MAP_TYPE_PROG_ARRAY = 3 */
        __uint(type, 3);             // int (*type)[3];
        __uint(max_entries, 100);    // int (*max_entries)[100];
        __type(key, __u32);          // typeof(__u32) *key;
        __type(value, __u32);        // typeof(__u32) *value;
    } progs SEC(".maps");

    bpf_tail_call_static(ctx, &progs, 111);

produces:

    bound.bpf.c:26:9: warning: bpf_tail_call: slot >= max_entries [-Wuser-defined-warnings]
       26 |         bpf_tail_call_static(ctx, &progs, 111);
          |         ^
    /usr/local/include/bpf/bpf_helpers.h:190:54: note: expanded from macro 'bpf_tail_call_static'
      190 |          __bpf_tail_call_warn(__slot >= BPF_MAP_ENTRIES(map));                  \
          |                                                             ^
    /usr/local/include/bpf/bpf_helpers.h:183:20: note: from 'diagnose_if' attribute on '__bpf_tail_call_warn':
      183 |     __attribute__((diagnose_if(oob, "bpf_tail_call: slot >= max_entries", "warning")));
          |                    ^           ~~~

Out-of-bounds tail call checkup is no-ops at runtime. Emitting a
compile-time warning can help developers detect mistakes earlier. The
check is currently limited to Clang (due to diagnose_if) and constant
indices, but should catch common errors.

---
Changes in V2:
- add function definition for __bpf_tail_call_warn for compile error

Hoyeon Lee (1):
  libbpf: add compile-time OOB warning to bpf_tail_call_static

 tools/lib/bpf/bpf_helpers.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--
2.51.0

