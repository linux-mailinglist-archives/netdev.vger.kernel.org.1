Return-Path: <netdev+bounces-224918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ABAB8B9A6
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 01:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F2E1894E6C
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 23:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E06256C6F;
	Fri, 19 Sep 2025 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekGm6keo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3092AD24
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323395; cv=none; b=b8lRXHwt8UKYAdW8nnsnY8Ga9Ra+69I5NQpSmwmWNGDJ8fcXZlP9IXteKDT6xEslxB7jKaem4wLXOU73EB8FUf1EANPc02Ui/O4X8Ey9N801LGcsggbDpCQuko8rXFWMfIhlgBLRCJO/sEgGXA/KRDpUIMTA1lszNGSFL0kJuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323395; c=relaxed/simple;
	bh=HY9tKDOUJ7QjRHaaoRji1oijbaIozebjreGllM14yTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ouxnsiklvdlobnBcDkZNv1+vjKU6ruMMghtjeF+kBQov1xC4qGwIH1bne7Xn8lvLJBFL06m6iaq7qVuWYzSK4MpYlAIwOPFV0PRreXQTxWl3E9pHo2MwZJqxB3S/wbJi941Bf5z2laNVLbVREJd4bMsww/sMr0MpDyGS2/Jlwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekGm6keo; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b550a522a49so1951912a12.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323393; x=1758928193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/L7k1EaQS0ZD0+t3qmhtzo/Q2KAQtQIeCgBHKEa6ORk=;
        b=ekGm6keo99H3fOSY1H8Ls+gyC2Om+SMR8daEx3Hyxk+BB1oWYlglHDTnsLR0mJJHKN
         IdG4HMVdZg3RMzWe+/jgRf4NiJKkZ2CE5rKDvhxow20wPPbwVOi1+35toWFnn8JmoE6h
         Gb8wpPcFd1AW2FPr7rfS4Wcq1SrLbiJtKTbPzO7qC/Ue8h3QsMR1MLRuCW+4ZMThWOQ7
         X8NqP4WT0qw2DCPhw6xA2ahlg1q3IFBaYv/zwDd3vT9wehZ4Ll3vDWeAgktGjm1Ii/ZK
         a69dN7WNWYfFNLOZ5lniBq01CvNAQ62lohav8+bjNxG7CcPo3EZc2HN7KzmCOZI5W5sU
         wONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323393; x=1758928193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/L7k1EaQS0ZD0+t3qmhtzo/Q2KAQtQIeCgBHKEa6ORk=;
        b=CTbGvQtf/cWYEoFUaXZeD2eyQAdXsKZcJabgxtDtbDkRkE/jgrfgYlekFe+dT2g/fb
         P9J/1KeiWuXR/CdxWWB8Pt/6cRXDyZo8BBlROWN4hzECHElD7/OCPscDeZ0E6P/+OQ0F
         KMwTf23ZfPJ1b6/MctWfaz4Zz+iO2VHvApSTG9Qed+PKPMir0z3+2X9KDu0gvjMF7uYo
         subvgf6mjQocd3h9baRS3Dah76sXrj8+ofUvECWFDH1ohTzNSHdg9enTgoD8B6xKHldp
         yU3FqiFn5oKQV/cfZj72sTenMOhIQEVwORyVkXw0cIQEH8tqBdJraOjety+dg7ZFJbr6
         oawQ==
X-Gm-Message-State: AOJu0YzX/J0dHnLpZ/6+bZQn4z70MK8795RaBSeh8cm7Q4C395xM4eVf
	Grr5qyr6vcvGQ5kdkpTn7FFm8/LIb0Le4AXKJ5Ng9BED3JHJ3I5GyxbU
X-Gm-Gg: ASbGncvan/WX9Vp4FThpN1SYYZNaks7Zdjnjwm4d+VwGbOdueWf5WJKLpkC1KBBeKzs
	uNn7dQhhcaDPz3M9k8F1sygvG/GG5UcAgqXrddEqRB/2hTKaaxK5Uou9LZse7pIp3lcpans+mEL
	s7w/7du92gAPVJRtUtjXAqHgIa+I+f6grLicSdUhVG4Mi8ipzkDu66NTb6SNdiI7DTsaJaGQhd9
	8/ClJz2D5OmzYd/38M6z0Aojyyv/BdhaE99iQkll/LAVh+lehrIGfF6LNQ0++xZ8mh/yaZtin3e
	VewVY96gQTa4g2M30pyKclFr07MfkJodX2v2ppJqPmMJ1/tlJ+4fcJ1er9fhkYaPMpcRVCrPLQh
	xNUgDMRmCKZwftrDLmtlOd+Y=
X-Google-Smtp-Source: AGHT+IFLpeOrj/nM+g1tMb8cPBc/YjoloBZYqdtW8eereIYIr/KyYHj23arg+PRGEX534VD6XTHt5A==
X-Received: by 2002:a17:902:db10:b0:266:272b:7277 with SMTP id d9443c01a7336-269ba58f44bmr78810725ad.59.1758323393062;
        Fri, 19 Sep 2025 16:09:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bf8bsm66067135ad.44.2025.09.19.16.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:09:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/7] Add kfunc bpf_xdp_pull_data
Date: Fri, 19 Sep 2025 16:09:45 -0700
Message-ID: <20250919230952.3628709-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v6 -> v5
  patch 6
  - v5 selftest failed on S390 when changing how tailroom occupied by
    skb_shared_info is calculated. Revert selftest to v4, where we get
    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) by running an XDP
    program

v5 -> v4
  patch 1
  - Add a new patch clearing pfmemalloc bit in xdp->frags when all frags
    are freed in bpf_xdp_adjust_tail() (Maciej)

  patch 2
  - Refactor bpf_xdp_shrink_data() (Maciej)

  patch 3
  - Clear pfmemalloc when all frags are freed in bpf_xdp_pull_data()
    (Maciej)

  patch 6
  - Use BTF to get sizes of skb_shared_info and xdp_frame (Maciej)

  Link: https://lore.kernel.org/bpf/20250919182100.1925352-1-ameryhung@gmail.com/

v3 -> v4
  patch 2
  - Improve comments (Jakub)
  - Drop new_end and len_free to simplify code (Jakub)

  patch 4
  - Instead of adding is_xdp to bpf_test_init, move lower-bound check
    of user_size to callers (Martin)
  - Simplify linear data size calculation (Martin)

  patch 5
  - Add static function identifier (Martin)
  - Free calloc-ed buf (Martin)

  Link: https://lore.kernel.org/bpf/20250917225513.3388199-1-ameryhung@gmail.com/

v2 -> v3
  Separate mlx5 fixes from the patchset

  patch 2
  - Use headroom for pulling data by shifting metadata and data down
    (Jakub)
  - Drop the flags argument (Martin)

  patch 4 
  - Support empty linear xdp data for BPF_PROG_TEST_RUN

  Link: https://lore.kernel.org/bpf/20250915224801.2961360-1-ameryhung@gmail.com/

v1 -> v2
  Rebase onto bpf-next

  Try to build on top of the mlx5 patchset that avoids copying payload
  to linear part by Christoph but got a kernel panic. Will rebase on
  that patchset if it got merged first, or separate the mlx5 fix
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

Tested with the added bpf selftest using bpf test_run and also on
mlx5 with the tools/testing/selftests/drivers/net/{xdp.py, ping.py}.
mlx5 with striding RQ enabled always passse xdp_buff with empty linear
data to xdp programs. xdp.test_xdp_native_pass_mb would fail to parse
the header before this patchset.

Thanks!
Amery

Amery Hung (7):
  bpf: Clear pfmemalloc flag when freeing all fragments
  bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
  bpf: Support pulling non-linear xdp data
  bpf: Clear packet pointers after changing packet data in kfuncs
  bpf: Support specifying linear xdp packet data size for
    BPF_PROG_TEST_RUN
  selftests/bpf: Test bpf_xdp_pull_data
  selftests: drv-net: Pull data before parsing headers

 include/net/xdp.h                             |   5 +
 include/net/xdp_sock_drv.h                    |  21 +-
 kernel/bpf/verifier.c                         |  13 ++
 net/bpf/test_run.c                            |   9 +-
 net/core/filter.c                             | 135 +++++++++++--
 .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 179 ++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
 .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--
 9 files changed, 463 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

-- 
2.47.3


