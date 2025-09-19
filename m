Return-Path: <netdev+bounces-224833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD8EB8ADD5
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C52E162F3D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064F24BD0C;
	Fri, 19 Sep 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYIyJdII"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024B1A2392
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305370; cv=none; b=smDHBa7UWD2ETVmiq0arY6rivMGsjLRilIGik+FpON4rFGWcXVVb0fZTyKWT/jNkr+jcWxRCU2nS0QNdDcvrGhKtaKWyM7sefx2jGBnkG5mZL3QPwHnteWJT1bbclYpB8CixIEoocBiiS2QPlMGPzfssoX3i6XJGjxZahthnfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305370; c=relaxed/simple;
	bh=wt3AuhBxvcVL1P1Aj0dCyPrtsq234uq/pypnZ//yoYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKrScPuzG2SM+ADnCNkOoyQEliPY5hHUXI+jumaXIOjmGz8zXz0z6dVyUe9tNnGHaKGRSoqXJt1rfXY2yUuqfSPz9mvyKDECa1xBltY8PtVmkJsLjQG25s0PkiYdkwAnUjsB0/vmN+Po9hUqYY+6nAVuCIaqLUx5py+bfT9PloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYIyJdII; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5524c0ed94so546740a12.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305367; x=1758910167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lhFhuvjcD2znhDPzXvfCXa5O+O+dmP6JWKyMh1YLGSw=;
        b=nYIyJdIIzIK0lhs6zwQPpyDcYbzrbOz3kPFu2yKfN82BlzlqB+kdsxsCpiPPWtoHrU
         MuVfv9LsxNZ7wyzoKz6MkH5mZJitS4wka/ggQTSNvXpKnMll4TbVGtxwIMCqgShQhiwq
         g9Uqw2SIhCRB2e6lZnGwxerJwK0x6HR2wc6NxPAfALYDdP9EezSJ7g90u1KMNPfZGSD8
         suaQgLVKMJgAzvs1Ux1gRkg9qrxUV/Ygp/dgi1R0A95PeXBhpJw6fYyfTT8qUyzclKu0
         fNMpJqdM7I57Rz0zKDO0RhBDyHFxbrBQXas2dcn7dTns1lxwZAMFd+y7csm4ds5RlkPj
         WhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305367; x=1758910167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhFhuvjcD2znhDPzXvfCXa5O+O+dmP6JWKyMh1YLGSw=;
        b=udj9Glxhauha+obE8ChrFmstWTn+weUwsiM6PmIiPQ2DcuJEHygFDjmB7XB9z7v9gf
         GZ4i7uRRxdrX8O9tcIM4reF0yBbPZ1KrmVdgnnTKuoDvuPvof/wXTH4JZb+0eD/uGMwn
         iBK2y6qjYz6S1V3tWF8VJxyA84UsAhS1Uaw5kdCKGshKdXQePpmob6gPBAB/JtaQV8aZ
         NhDzAdeYlSNgcphPF+GnZ3SRKiVqFQQXtS09uMenq9Te0oPEGQJMdkGbi9+petoVnomh
         jTlm+kdbEH1fMu+RgWLdTbTaZMOxRW+DPV7u2dT9pIy+jab3B8h97LgPe1izCbgKZFwI
         JA5Q==
X-Gm-Message-State: AOJu0YwnfvImkleuYHyTjQX/MOPh2ShDpTlt1HjuCw15g0dRK/tm4X0Q
	BzAu0Z+vgdApI7sTBKs8PjJNn+dr1MRiyK6LyHTQY48jUHUQnbAsDbZv
X-Gm-Gg: ASbGncsal3dVblLvXdYR3bp2TcRdmhulsjrYfAusjPL1Eot69I2JUHSbam0EJ+RDaOL
	VI0TTMeawbVeHgkHPrXgb6/9rkLTzv+E/20MnmI8I3nMmjh/YSMv5ZjFAuxjZpcO1uw8opDoGd5
	v2GAi5zXAT43i5vMZNfPo/8UnLgkGFagqRUP6UiC4HX2VCG7nY39cWS+MJnT14qwUZ10eXGoGJp
	ulHSu8vlO0WGvSgihMmRPjxGsS/gDT48g/dHD8xzUQfoAKCrsnnVKDEr70tJjtFiRMqkEUnqabd
	PIWjhCS0FqQOOdph+kxpjJayCYKqU4vXNCxZRlv16HCW374HSaBsZ/YuuGUw/OIrf9fP/pErL0K
	cpEr367FFbJ/2
X-Google-Smtp-Source: AGHT+IFBmImHKIomCIAeYE2WjtEz6ppxJP9ckJpfmnydk+sHXpBsi6ahjP27SR7sxy+yjGGjAK7QQw==
X-Received: by 2002:a17:903:2a8e:b0:267:e09c:7ea3 with SMTP id d9443c01a7336-269ba467aaamr62394935ad.13.1758305367525;
        Fri, 19 Sep 2025 11:09:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698030fff0sm60925195ad.105.2025.09.19.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:09:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/6] Add kfunc bpf_xdp_pull_data
Date: Fri, 19 Sep 2025 11:09:20 -0700
Message-ID: <20250919180926.1760403-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 net/bpf/test_run.c                            |   9 +-
 net/core/filter.c                             | 119 ++++++++++--
 .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c  | 176 ++++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
 .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--
 8 files changed, 445 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

-- 
2.47.3


