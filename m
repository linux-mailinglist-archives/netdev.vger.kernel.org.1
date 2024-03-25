Return-Path: <netdev+bounces-81818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9760A88B64C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECCB4B2CD08
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2E46DCE8;
	Mon, 25 Mar 2024 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NytJMmSf"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D841C6D1A3;
	Mon, 25 Mar 2024 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402527; cv=none; b=oMuKzWoUTl6ZVZmABHXbkZTiafCXBq7zPYMrBHvlfiF3M2BQUA26kGF3u2SeFwU8pyxJQjcEnCVP/s94ri008t10aIIkyTfa4E41u1IALSxSHmu7Yk9e7ubvOgEH0etLL0FvLguJ54EOXsl555hbffvTMlZp0afAzpkba8/8Bxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402527; c=relaxed/simple;
	bh=z8rW+gaJh9oEjZWVYfIeBs5QTUurns59h3Zl/6mhWOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ep44cd+6oduypGNRNT2yG0c85xt3g51TZWPGimz/ErFSCFSFjsypTjGXXFXnCYWv8qaB/CHVUAPMwdRnBCuHGa7zEfiaMtJguATQ0662JWG7V2rbBQdfFPMJ73s3KaPoJHi8mWU1hoQXORKroCLXzNGZTMmRKqFVwg+Ke/lr3UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NytJMmSf; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=/7uCFdLyUcSLoN2CO/QqYsxgNqqrS5ZwWh/yFNNxePU=; b=NytJMmSfMiiFMWamhvlDYQ6iay
	ZsVdGDTH+EVwLu2HILHKGji4/EXQDmdQfH+cfUIS1kC7vF58F/BIuctmhXSSWeOtUSboiS1WSBDoN
	JTlY7vo/qKYafRYN2smHEO40gakwc2vSoT8wC4hbj8cVxAfflIIH2LRqvNX6NpKDvq1arYWTohHA0
	MW1uJxtpSfsS68dZoAXMq6iMdmQVZsjTeXl7OWp1K4g9dpvSGBxV1jJ0UzdlftD2GkJbycpV/5Hzx
	1rvKK4UfH8XoSFF7bbK2asjQN6VRNF3uldnhUQFp3amdlYNoKXuSs5KfFqxZ3yxsFrsj21IiNoJ6B
	5qgQAgsA==;
Received: from 30.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.30] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1roryT-000IF1-DU; Mon, 25 Mar 2024 22:35:21 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf 2024-03-25
Date: Mon, 25 Mar 2024 22:35:20 +0100
Message-Id: <20240325213520.26688-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27225/Mon Mar 25 09:30:27 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 17 non-merge commits during the last 12 day(s) which contain
a total of 19 files changed, 184 insertions(+), 61 deletions(-).

The main changes are:

1) Fix an arm64 BPF JIT bug in BPF_LDX_MEMSX implementation's offset handling
   found via test_bpf module, from Puranjay Mohan.

2) Various fixups to the BPF arena code in particular in the BPF verifier and
   around BPF selftests to match latest corresponding LLVM implementation,
   from Puranjay Mohan and Alexei Starovoitov.

3) Fix xsk to not assume that metadata is always requested in TX completion,
   from Stanislav Fomichev.

4) Fix riscv BPF JIT's kfunc parameter incompatibility between BPF and the riscv
   ABI which requires sign-extension on int/uint, from Pu Lehui.

5) Fix s390x BPF JIT's bpf_plt pointer arithmetic which triggered a crash when
   testing struct_ops, from Ilya Leoshkevich.

6) Fix libbpf's arena mmap handling which had incorrect u64-to-pointer cast on
   32-bit architectures, from Andrii Nakryiko.

7) Fix libbpf to define MFD_CLOEXEC when not available, from Arnaldo Carvalho de Melo.

8) Fix arm64 BPF JIT implementation for 32bit unconditional bswap which
   resulted in an incorrect swap as indicated by test_bpf, from Artem Savkov.

9) Fix BPF man page build script to use silent mode, from Hangbin Liu.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alejandro Colomar, Daniele Salvatore Albano, Kumar Kartikeya Dwivedi, 
Puranjay Mohan, Quentin Monnet, Ryan Eatmon, Stanislav Fomichev, xingwei 
lee, Xu Kuohai, yue sun

----------------------------------------------------------------

The following changes since commit e30cef001da259e8df354b813015d0e5acc08740:

  net: txgbe: fix clk_name exceed MAX_DEV_ID limits (2024-03-14 13:49:02 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 443574b033876c85a35de4c65c14f7fe092222b2:

  riscv, bpf: Fix kfunc parameters incompatibility between bpf and riscv abi (2024-03-25 11:39:31 -0700)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (4):
      bpf: Clarify bpf_arena comments.
      libbpf, selftests/bpf: Adjust libbpf, bpftool, selftests to match LLVM
      selftests/bpf: Remove hard coded PAGE_SIZE macro.
      selftests/bpf: Add arena test case for 4Gbyte corner case

Andrii Nakryiko (2):
      Merge branch 'bpf-arena-followups'
      libbpf: fix u64-to-pointer cast on 32-bit arches

Arnaldo Carvalho de Melo (1):
      libbpf: Define MFD_CLOEXEC if not available

Artem Savkov (1):
      arm64: bpf: fix 32bit unconditional bswap

Hangbin Liu (1):
      scripts/bpf_doc: Use silent mode when exec make cmd

Ilya Leoshkevich (1):
      s390/bpf: Fix bpf_plt pointer arithmetic

Pu Lehui (1):
      riscv, bpf: Fix kfunc parameters incompatibility between bpf and riscv abi

Puranjay Mohan (5):
      bpf: Temporarily disable atomic operations in BPF arena
      bpf, arm64: fix bug in BPF_LDX_MEMSX
      bpf: verifier: fix addr_space_cast from as(1) to as(0)
      selftests/bpf: verifier_arena: fix mmap address for arm64
      bpf: verifier: reject addr_space_cast insn without arena

Quentin Monnet (1):
      MAINTAINERS: Update email address for Quentin Monnet

Stanislav Fomichev (1):
      xsk: Don't assume metadata is always requested in TX completion

 .mailmap                                           |  3 +-
 MAINTAINERS                                        |  2 +-
 arch/arm64/net/bpf_jit_comp.c                      |  4 +-
 arch/riscv/net/bpf_jit_comp64.c                    | 16 +++++
 arch/s390/net/bpf_jit_comp.c                       | 46 +++++++--------
 include/net/xdp_sock.h                             |  2 +
 kernel/bpf/arena.c                                 | 25 +++++---
 kernel/bpf/verifier.c                              | 22 ++++++-
 scripts/bpf_doc.py                                 |  4 +-
 tools/bpf/bpftool/gen.c                            |  2 +-
 tools/lib/bpf/libbpf.c                             | 10 +++-
 tools/testing/selftests/bpf/bpf_arena_common.h     |  2 +-
 .../testing/selftests/bpf/prog_tests/arena_htab.c  |  8 ++-
 .../testing/selftests/bpf/prog_tests/arena_list.c  |  7 ++-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |  2 +
 tools/testing/selftests/bpf/progs/arena_htab.c     |  2 +-
 tools/testing/selftests/bpf/progs/arena_list.c     | 10 ++--
 tools/testing/selftests/bpf/progs/verifier_arena.c | 10 +++-
 .../selftests/bpf/progs/verifier_arena_large.c     | 68 ++++++++++++++++++++++
 19 files changed, 184 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_large.c

