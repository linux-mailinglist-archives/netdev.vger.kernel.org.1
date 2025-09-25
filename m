Return-Path: <netdev+bounces-226239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED446B9E687
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 285B67B7D6E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4C2E8DED;
	Thu, 25 Sep 2025 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsHSPkon"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF52701DC
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792972; cv=none; b=tWh/Li3kKUprDytppS/3KFjMRTB967M2xM0Vdma4K786kq6SZ6XvCexcIyI1J7o5UkONAidtJAujwWfgdzXuhXudc6pGMsV26EvxkYpQzs7gcO8E78PbJUKOs6SRNPjmhXU2zQVDJhZzC5ELgUSAhDP5FbSkUEHdNAYXKDLrIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792972; c=relaxed/simple;
	bh=rvmn/9fNBwLXiR/naWUZlKBH+/yw0HMGHd9myyptFrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JB5eZtFs+NcPeK7J0QzVOqVmNSF1Qyz8+sp8jCKYfRK2nfEiq9teGu7pB8kYhhyFFlJIdwNDDrfMQduQ2QOfH0Dby8MxQDhbIKp3Y99XI88Si1oyKbI1ZjRvPO5GzjDu8U7RW4rt1qqEctJVLREPPnGsQvl6JMzI9cJP0e1PLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsHSPkon; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-633b4861b79so88998a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 02:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758792969; x=1759397769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JrLk5BVUfi64hDu8MSXp4iRz7KC+EB7RrIoytg966TM=;
        b=hsHSPkoniy4OM3osSYrthKjNlU3U8eRIKniZJr+FZNd9fkcLB/uwwvTJd3uKtY8c1E
         YUE2361b46Ye8Lr0720uCToRQEc6e8+4Wl+aGmLcr1iIYE0WMnklFDXmyMeQAyeYzbQQ
         uaRVeEKdAcoCQTu4N2kau8It8VrdxJWkBtfVnA+QzPrcDwWc23VwnhgOBTslar2Qukk8
         c5Vzfo3X1Ys4yQ7UKdJSg27RgDXt1XmFMPsAXDqr6tg4JUk7gKh5GkOI29KEPS+nOLQn
         4R1rHedWPpuUC4DXV7BA6DcZOpM5Go3jQgxhGLr1NO8m/jhhRtenf9evBMgW/nxx6RfN
         FBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792969; x=1759397769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrLk5BVUfi64hDu8MSXp4iRz7KC+EB7RrIoytg966TM=;
        b=RZ0UMQhwECN7Jg4DsbgGAv1frFjZwlLnMnLF7OIlrMhVLFuFtNYf5VhGvOfC5ckpwa
         ZDX3He5LW4oPXriQ1NW4S+LfZdmcSlD3IolkjYzRWYJp9brgMhwyecpcoZn5+ed/iDkn
         qpPbPlgXeX5yeDcSUNQl8a2vlhBr7HMAD/ovMyrOesWPU9SgOqtvJGmAgn/SBkgyFdzw
         PD8X0sHV1ejQdWlBxb4I+/1mMH7qTC9o1k8dfbRZXuVbB1QcNUa+bHjt4rtq3wO1+Hc3
         KUWqVfFZJB3bAsd9nKNRk60h/UhFhJW8DGhKB6i2T6RwYnlLMEDb/JYw9lG4wJUeRULJ
         /hAA==
X-Forwarded-Encrypted: i=1; AJvYcCUk4IsizE5C8VxG1yB3ihX1r5YVGVDyicyqk+PYh9gZC4ZWxooU7vn1AxbxdwSJ2wLGaQ88UFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTUAf2JcntcnFqDLkVChqaqsXhEhcmkYSpzngoxsCqsaQTwWt4
	NgO7MGmnjxUy7dn05U/2xXF2JcmOCwcaL1WVq9xQEcw8GSdcvF5jCkNr
X-Gm-Gg: ASbGncsVR2QlN0swOgpOaxSa5ESxw8FRYp7FW3LjtguiPeDEnnDBxPIYXWLJTZQN59A
	25c7qdwZWSPczhnILLRoODQPUzjzzk7NMOQyWVxe/jflm6fGKiPRWY3YgogvH1f8xyD1aVpM8G2
	Ka9Y7JPIz1QYW3pmq21zL9PyhjeF7waACrtdbEqouXE7cDOop9UCGPBXQocLFG+ZgCQh4e3H6qe
	iKVHPxPIPVHICJa70N6Avu/eqopgJpgGBUyHPQoMSM/RyVTFcoozhOkpNKoiR9HhnrsrE8icziS
	1iZMsuV6wi5frW0/5gDsd7KumEZDwXI4JStvXtzT6UQQ6qQF4Anddw/xvmEnAc85hp5ObU9uVsA
	GhB/t37zHL0GEVhUmH1EwmZKCwXZGeo2fmuy5VQ==
X-Google-Smtp-Source: AGHT+IEn+TRY3f3rNpLqKcwo/IFO0X1TqRBrGc61qVTD+XlR37lk96NhcpagZXDaWeHbktL+5wxb3A==
X-Received: by 2002:a05:6402:4389:b0:628:d1b5:d207 with SMTP id 4fb4d7f45d1cf-6349f9d26b0mr1238596a12.2.1758792969099;
        Thu, 25 Sep 2025 02:36:09 -0700 (PDT)
Received: from bhk ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae321csm941225a12.24.2025.09.25.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:36:08 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	linux@jordanrome.com,
	ameryhung@gmail.com,
	toke@redhat.com,
	houtao1@huawei.com,
	emil@etsalapatis.com,
	yatsenko@meta.com,
	isolodrai@meta.com,
	a.s.protopopov@gmail.com,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	vmalik@redhat.com,
	bigeasy@linutronix.de,
	tj@kernel.org,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	mrpre@163.com,
	jakub@cloudflare.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v3 0/3] selftests/bpf: Prepare to add -Wsign-compare for bpf selftests
Date: Thu, 25 Sep 2025 11:35:38 +0100
Message-ID: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is preparing to add the -Wsign-compare C compilation flag to
the Makefile for bpf selftests as requested by a TODO to help avoid
implicit type conversions and have predictable behavior.

Changelog:

Changes from v2:

-Split up the patch into a patch series as suggested by vivek

-Include only changes to variable types with no casting by my mentor
david

-Removed the -Wsign-compare in Makefile to avoid compilation errors
until adding casting for rest of comparisons.

Link:https://lore.kernel.org/bpf/20250924195731.6374-1-mehdi.benhadjkhelifa@gmail.com/T/#u

Changes from v1:

- Fix CI failed builds where it failed due to do missing .c and
.h files in my patch for working in mainline.

Link:https://lore.kernel.org/bpf/20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com/T/#u

Mehdi Ben Hadj Khelifa (3):
  selftests/bpf: Prepare to add -Wsign-compare for bpf tests
  selftests/bpf: Prepare to add -Wsign-compare for bpf tests
  selftests/bpf: Prepare to add -Wsign-compare for bpf tests

 tools/testing/selftests/bpf/progs/test_global_func11.c       | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func12.c       | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func13.c       | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func9.c        | 2 +-
 tools/testing/selftests/bpf/progs/test_map_init.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c   | 2 +-
 .../selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c      | 2 +-
 tools/testing/selftests/bpf/progs/test_skb_ctx.c             | 2 +-
 tools/testing/selftests/bpf/progs/test_snprintf.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_sockmap_strp.c        | 2 +-
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c           | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp.c                 | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_dynptr.c          | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_loop.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_noinline.c        | 4 ++--
 tools/testing/selftests/bpf/progs/uprobe_multi.c             | 4 ++--
 .../selftests/bpf/progs/uprobe_multi_session_recursive.c     | 5 +++--
 .../selftests/bpf/progs/verifier_iterating_callbacks.c       | 2 +-
 18 files changed, 22 insertions(+), 21 deletions(-)

-- 
2.51.0


