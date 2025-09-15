Return-Path: <netdev+bounces-223239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7F5B587C6
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46FD07A5685
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2582C08A8;
	Mon, 15 Sep 2025 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApcF3/lm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459013FBB3
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976484; cv=none; b=cQ6aYnlxJk1b8gjOmE41WBZnG9Prj3kNcYmO4go08f6+DZV/ujJYh31NoxTuxhHASQojk+4MZZYHWbCA+CvesYESpn8SeeIJHChplv2wAqL1wqNXucKAGZVIzdSXG6enoSYTb0H6U3iiOPVwlRt5vPkQRW8XSDPk/odcgWwtDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976484; c=relaxed/simple;
	bh=5UqF3Ysp9JENJ7uuLz3lTDyBwWGPJsirLelAb96xPRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OsmtIkrT45/WzgyRuz3XAWb4DNhHdGeKXEnqTevuu6WOWJfWBeSsidAOvr2Dm7f8WGYKTFq1bnYRkOkDazJICXm3W1hXKgaBy43IDGCT4Ji2Con/Tfsj24EjmTsC4wNJyajZ6so2vPoCDR9uF8VRVZUcTWrINNpyShC6DJ3aLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApcF3/lm; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so3147186a12.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757976482; x=1758581282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8K+vUyHnagTGCHkW/l0LZwpJ9q9Aeei9zIs+piSAMHw=;
        b=ApcF3/lmNvLsXvjsfu4LF7jS7lU5AgMU7Pug+RgcQZEF/BpcMewGf9u4vUrwvz30p/
         2j64n7afSH7myiRg0C6UPbKr1VlR55Om8aZon3IOzJSZLaPRxnWQx5XMfiAVYoGfkbVm
         6qf6H0omoLUZfauHPFTFp9LoSKSFOUSt1v8R13zGeHBv14IJSefCnEapVLNEYWybLniG
         +PZ44H4UDKvY/SDe1A0rQU7JDq6NNzSvBNuOO+Sp/ed6wm5uti5joshaDMeaZhFNU8SP
         vQ4RDVDHUDO4aCfSrjHoLEkkluy+CYyz2n6QH+mmUAL99IE9i4RHgXx9ILxXp4HeGfe8
         R/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976482; x=1758581282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8K+vUyHnagTGCHkW/l0LZwpJ9q9Aeei9zIs+piSAMHw=;
        b=RbtAiBkjH8cXiFe1wT3LdMH5ySgEO4vEay2BqceuU0sGp2uXEbvNojDR7k56fkV0UN
         u/c6QlXMj0fSSB/1xt8a+HKDzOlCt0ujGO9MZ/QNK36cNHmEe7v3z90+7qb/II0+Q95r
         B9szt8M1wGYo0UR9eKQoBkhqeXDtjnnXhXFqV8Y9URAqsm4N+DwvEzRtnX190MyrTSvh
         yeSJv6vMcuXARZBlnGgqFaQkoIreIddDupIC05A9NSKw5FCt1ANECZJPZxqm3GxazhoX
         MOsXbuhNKJeCewYyFB/TLE1FvuDfdyYpjUsF/YH7pTsvFQcbRqu2HyAzXpGk/SnWAZvc
         rZ0w==
X-Gm-Message-State: AOJu0YxeLxsyoG7cLwWkB6hX2wkwGegm+MTj1S9t03m2+IohXnshY4ZZ
	IL67AznkPtQgZqa2DyLjy4fKrJQO+dTQoMBFigAa9AalDcZ0GymUD3CJ
X-Gm-Gg: ASbGncunNykXhKQQdYWfZlavxmpTRNAaY/GwljmygCb0o9cqDfdU6mjlBCFrJelpyH2
	467xiejL6AKu3P3TfSdt9BjndTSBg5J15C+6EKbQYCWbaMrXOOlR0a/OMvnYM0F3IV/IIISmWiU
	CQk+10wyE4UjI+B4qycFAiw+XcPA9S0VpDsjN/d6Umm+GmUgw2MZ5u/pps6nggj0EPvNU+b2URJ
	XQdmxsSvyQpmv6fYZApzAgUU1eMcBSB9Z2TjLyo7yXmfjmFRGscy9qaeXaobXZ5yft79QIT6pX9
	AnUBrW6EAPWMIs8Q7itKbW7D3VyhmurzuwsNeTV8UvtdYEnkh/XmHj0Erw5w+Wmaoc0n0qvjDHL
	27O9IOqQlRvHlxbKtCMFpLZNy
X-Google-Smtp-Source: AGHT+IFj4Kb0bj2s7cASfusQq0lXXQW/RqCm9lTCjvMdEqDtDDqv3xwiA9bm2QBvz8klP9UvpGSqog==
X-Received: by 2002:a17:90b:4d06:b0:32d:e780:e9d5 with SMTP id 98e67ed59e1d1-32de780ec01mr13932391a91.22.1757976482407;
        Mon, 15 Sep 2025 15:48:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:15::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b43a7sm15682797a91.13.2025.09.15.15.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:48:02 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/6] Add kfunc bpf_xdp_pull_data
Date: Mon, 15 Sep 2025 15:47:55 -0700
Message-ID: <20250915224801.2961360-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 -> v3
  Separate mlx5 fixes from the patchset

  Patch 2
  - Use headroom for pulling data by shifting metadata and data down
    (Jakub)
  - Drop the flags argument (Martin)

  Patch 4 
  - Support empty linear xdp data for BPF_PROG_TEST_RUN

v1 -> v2
  Rebase onto bpf-next

  Try to build on top of the mlx5 patchset that avoids copying payload
  to linear part by Christoph but got a kernel panic. Will rebase on
  that patchset if it got merged first, or seperate the mlx5 fix
  from this set.

  patch 1
  - Remove the unnecessary head frag search (Dragos)
  - Rewind the end frag pointer to simplify the change (Dragos)
  - Rewind the end frag pointer and recalculate truesize only when the
    number of frags changed (Dragos)

  patch 3
  - Fix len == zero behavior. To mirror bpf_skb_pull_data() correctly,
    the kfunc should do nothing (Stanislav)
  - Fix a pointer wrap around bug (Jakub)
  - Use memmove() when moving sinfo->frags (Jakub)

  Link: https://lore.kernel.org/bpf/20250905173352.3759457-1-ameryhung@gmail.com/
  
---

Hi all,

This patchset introduces a new kfunc bpf_xdp_pull_data() to allow
pulling nonlinear xdp data. This may be useful when a driver places
headers in fragments. When an xdp program would like to keep parsing
packet headers using direct packet access, it can call
bpf_xdp_pull_data() to make the header available in the linear data
area. The kfunc can also be used to decapsulate the header in the
nonlinear data, as currently there is no easy way to do this.

This patchset also tries to fix an issue in the mlx5 driver. The driver
curretly assumes the packet layout to be unchanged after xdp program
runs and may generate packet with corrupted data or trigger kernel warning
if xdp programs calls layout-changing kfunc such as bpf_xdp_adjust_tail(),
bpf_xdp_adjust_head() or bpf_xdp_pull_data() introduced in this set.

Tested with the added bpf selftest using bpf test_run and also on
mlx5 with the tools/testing/selftests/drivers/net/{xdp.py, ping.py}. mlx5
with striding RQ always pass xdp_buff with empty linear data to xdp
programs. xdp.test_xdp_native_pass_mb would fail to parse the header before
this patchset.

Grateful for any feedback (especially the driver part).

Thanks!
Amery

Amery Hung (6):
  bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
  bpf: Support pulling non-linear xdp data
  bpf: Clear packet pointers after changing packet data in kfuncs
  bpf: Support specifying linear xdp packet data size for
    BPF_PROG_TEST_RUN
  selftests/bpf: Test bpf_xdp_pull_data
  selftests: drv-net: Pull data before parsing headers

 include/net/xdp_sock_drv.h                    |  21 ++-
 kernel/bpf/verifier.c                         |  13 ++
 net/bpf/test_run.c                            |  26 ++-
 net/core/filter.c                             | 123 +++++++++++--
 .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 174 ++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
 .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--
 8 files changed, 456 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

-- 
2.47.3


