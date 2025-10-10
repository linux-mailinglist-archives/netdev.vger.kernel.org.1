Return-Path: <netdev+bounces-228556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68975BCE26E
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 19:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E979254439A
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9460726F2B2;
	Fri, 10 Oct 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGxNgNJc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED330265632
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118596; cv=none; b=HyKtCgxxi4ki6mLwDriDgdjyBRiSDVmfQTz6+ULnzXrQFMrV05FK+iWSJ6CrcINbqquyBWEgQ6mkEljJ608d70hLP5a9d7Js1E5pjBzhVQobzbH1A3Rpz2FtSPJHGYUvCgv+L460yzpkfc42xKMHUDwbUcveoWzE3zgcRb0CThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118596; c=relaxed/simple;
	bh=eBp2ssxwsF1pZwgDQ9cLPLnXL+8ZI1Iu0jA8ietJkBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BfkndzSRUkDgFK8ezkgt6RRv7fMiEk0S2NupWhOWpgumYDZ/iF3UJHLEEm0F845yEdz7sQ8x6f2bzVgKhYqoB2He0RTf17RcF83b+7vNAC7Lqx1wBuzs9G/h/U2DXChYGkF/f+BKyRSD65p3EbFv/RT+/2pGnjWUiWSAcvNvidw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGxNgNJc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-28a5b8b12a1so22594445ad.0
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760118594; x=1760723394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qMo5V/Vxbx71O095m+8nAL8clgVCoteS7dV1qcc7Luw=;
        b=SGxNgNJcJplIIzfrznChYfM06bte0NvJAnssx+olLyxWuCAUqkFCSafxS7ZrXDQK92
         gml3RKXPRwry091hfKUL7+xrO8gmXvOWTIJEo8ZClm7klXyZim1RhMPAbY674SL1ktxU
         elxBSiqLZqeH5ySbeqS8gC+aGJcfZWSePKjJTulnehfYWeTJdfu/4oona9A9kVJIxMzv
         TdfBa7vzZfn5l2VcWPvK0YNsrwARqYEP0CY8Q6+GLqIqQs9mB9FnTp4ErZqjHVAYyZq8
         umU5vS9WbnNb3Ct41v3EzG97cks/HkWLI4HCGX4d3bMmO8STofJTcYTOA7vCue8shUTu
         UjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118594; x=1760723394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMo5V/Vxbx71O095m+8nAL8clgVCoteS7dV1qcc7Luw=;
        b=Ers/zMOasre+mOuk10M3ohOaFNbhXEFAaJUMvIHl/ooTLg3B/Tle7j1myNefg8dLPh
         0jeo6G7y5JuWOuyV8HeaBuZThvQnvSlFdQNLzmnRMSQFX/IMd6+CnwsvvS3Gf8teBf6x
         a4rhR3A6L/TaHHIlOv2LmCDouG9Ge5OC7E9aPvJhaLoO4NSlp0PgyZ7tHLcoI6PN4x6p
         SBMiBqwIhIZJhfoJ52OuhSfbL/1RpxsOJogH0kIUosMzM+g64QBMYHC93RJlmisTIlH+
         h7TE11E1e9sAmuxoAH7f/ua0PyjNC+wCTUUkQcV1Gu9xqJ641EdgS6xLi1JwI7Sgyjm5
         xr8Q==
X-Gm-Message-State: AOJu0Yw2YGkSQepl+VyhOXuZezWhGPDfwaXMyNT799tH2C6px4ccmJzl
	APMnUCDQnQdQMQWP3Z8vUxNYEE4p++HEF9y0PP/9PmvmGdLKSVMTDe+z7lFwlQ==
X-Gm-Gg: ASbGnctPmbJLcsr5tmWuQggi8IFvn0snlb30qKx2DAq2oKlGgvgfTkthXv+D0Ef8mJl
	x04aqHd/3ygvFrqlemTq8l+oyeDUkvItHPU1K2HINJOFVO9MIWrM/wWdcEbaSi0qyekfT7VRsV2
	oWEIuFP5G9OBoWnySThef7A1tbXi7ugjcHYDgDR59TwLl4AUNvHvg3h55CR1dcKOTmg3lVYAG/d
	uMTZIe7v2jOt+FO/Hw4jyBpz/3cdS7R02qFwuEUxz3yqvaX0y+w69XxI9SplKK8eeFMGSU35q1s
	rzPKq3/v5fh7hOMnyo8T1TtgDcGziBTjWEn+smevZK4Z86Wsnvq2vFVBawIpYn+q0/nl8qUb7Wb
	C4rDqR+EpLlstCfFbURFmIBjz8K39U1pBfrSXT9TYWQ==
X-Google-Smtp-Source: AGHT+IGsK2HfpVGy7KMPx41unTLhbLvJuGTfgRaNkTG6p/BSSP+IjJqbe7jRAMthiqnHS25/SgiOgQ==
X-Received: by 2002:a17:902:f64a:b0:277:9193:f2da with SMTP id d9443c01a7336-29027356c8emr164710415ad.5.1760118594125;
        Fri, 10 Oct 2025 10:49:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e4930esm62384125ad.54.2025.10.10.10.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:49:53 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH v1 bpf-next 0/4] Support associating BPF programs with struct_ops
Date: Fri, 10 Oct 2025 10:49:49 -0700
Message-ID: <20251010174953.2884682-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds a new BPF command BPF_STRUCT_OPS_ASSOCIATE_PROG to
the bpf() syscall to allow associating a BPF program with a struct_ops.
The command is introduced to address a emerging need from struct_ops
users. As the number of subsystems adopting struct_ops grows, more
users are building their struct_ops-based solution with some help from
other BPF programs. For exmample, scx_layer uses a syscall program as
a user space trigger to refresh layers [0]. It also uses tracing program
to infer whether a task is using GPU and needs to be prioritized [1]. In
these use cases, when there are multiple struct_ops instances, the
struct_ops kfuncs called from different BPF programs, whether struct_ops
or not needs to be able to refer to a specific one, which currently is
not possible.

The new BPF command will allow users to explicitly associate a BPF
program with a struct_ops map. The libbpf wrapper can be called after
loading programs and before attaching programs and struct_ops.

Internally, it will set prog->aux->st_ops_assoc to the struct_ops
struct (i.e., kdata). struct_ops kfuncs can then get the associated
struct_ops by adding a "__prog" argument. The value of the speical
argument will be fixed up by the verifier during verification.

The command conceptually associates the implementation of BPF programs
with struct_ops map, not the attachment. A program associated with the
map will take a refcount of it so that st_ops_assoc always points to a
valid struct_ops struct. However, the struct_ops can be in an
uninitialized or unattached state. The struct_ops implementer will be
responsible to maintain and check the state of the associated
struct_ops before accessing it.

We can also consider support associating struct_ops link with BPF
programs, which on one hand make struct_ops implementer's job easier,
but might complicate libbpf workflow and does not apply to legacy
struct_ops attachment.

[0] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c#L557
[1] https://github.com/sched-ext/scx/blob/main/scheds/rust/scx_layered/src/bpf/main.bpf.c#L754

Amery Hung (4):
  bpf: Allow verifier to fixup kernel module kfuncs
  bpf: Support associating BPF program with struct_ops
  libbpf: Add bpf_struct_ops_associate_prog() API
  selftests/bpf: Test BPF_STRUCT_OPS_ASSOCIATE_PROG command

 include/linux/bpf.h                           |  11 ++
 include/uapi/linux/bpf.h                      |  16 +++
 kernel/bpf/bpf_struct_ops.c                   |  32 ++++++
 kernel/bpf/core.c                             |   6 +
 kernel/bpf/syscall.c                          |  38 +++++++
 kernel/bpf/verifier.c                         |   3 +-
 tools/include/uapi/linux/bpf.h                |  16 +++
 tools/lib/bpf/bpf.c                           |  18 +++
 tools/lib/bpf/bpf.h                           |  19 ++++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../bpf/prog_tests/test_struct_ops_assoc.c    |  76 +++++++++++++
 .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  17 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
 14 files changed, 357 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c

-- 
2.47.3


