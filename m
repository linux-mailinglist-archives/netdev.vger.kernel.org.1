Return-Path: <netdev+bounces-81857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D85588B56E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 00:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818C01C372B1
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF45983A08;
	Mon, 25 Mar 2024 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="pBgMAGXi"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A218AF8;
	Mon, 25 Mar 2024 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409989; cv=none; b=Qrn70c/0kGY+IswgPuae1vFQtcwr1JcpO5AbfN3fWdozBAoE9KKi4pi+3wSz6ZvXazJWzHu+PyqixVoazvdZNMCgMX+kwORl3Mxxxwq+wNDrts81p3RyxQA+hY31nxnwv812MTFR/jlTZQcZtc/wVE4aCqEGh+fIOVlI3UOwJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409989; c=relaxed/simple;
	bh=XnKuWUJDo7LOxnwLI7qOPjUeET9scrnc2Hnlx/dHh2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hDljWQ1T8JLBmD6xlCsmNL/4xrkox8vQjnV7feX/WidehnS8ZUNqcFDjQDr4yadKQ7ORrGl5fENUi3/Og0fDPe803iFQKKsZSHZLDh3D1xQTSyTDWCdDf7+wjDltwAmQ8fVvqmPpWkUpH7wtoIoMUQ5zzFyd0lEWK3JGMw39Aqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=pBgMAGXi; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=cPfFo5gbrfOC5nG2rK6QxTkgqWk1UOdiNStdjxJwjRM=; b=pBgMAGXieBY8nCZqarecCKtgy5
	VNtgy7Q4XqHh/0WxiMhJ6Jmn47C9KsgPzzkOlTAsL30ASpYV3Loy32un92f4DBwk+/T/WxUtdL751
	xRwS9gd6yfgxQsiGJKnVY2PZofGOi0beud6FCZ5WnPsAE32vrQ6NlC34trt77lcmiBKtdqWoQGEZJ
	6uMg7qmn5nJdTjSG9QOGoFdrc5D+Se6vCEheuDH+tZKLLb4E3hUIe0ooiq+rLPE5Nb7q/S9JKv6Tf
	txrF1jiH+8Xw9M7ojXi4ZBhR8kZcVTm6qUEg7EahhQCTDcnpQmUyBYCWEzTeJU3Dndyshbg2Fgpvm
	tCDnK9Nw==;
Received: from 30.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.30] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rotum-0006ZA-Qv; Tue, 26 Mar 2024 00:39:40 +0100
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
Subject: pull-request: bpf-next 2024-03-25
Date: Tue, 26 Mar 2024 00:39:40 +0100
Message-Id: <20240325233940.7154-1-daniel@iogearbox.net>
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

The following pull-request contains BPF updates for your *net-next* tree.

We've added 38 non-merge commits during the last 13 day(s) which contain
a total of 50 files changed, 867 insertions(+), 274 deletions(-).

The main changes are:

1) Add the ability to specify and retrieve BPF cookie also for raw tracepoint programs in
   order to ease migration from classic to raw tracepoints, from Andrii Nakryiko.

2) Allow the use of bpf_get_{ns_,}current_pid_tgid() helper for all program types and
   add additional BPF selftests, from Yonghong Song.

3) Several improvements to bpftool and its build, for example, enabling libbpf logs when
   loading pid_iter in debug mode, from Quentin Monnet.

4) Check the return code of all BPF-related set_memory_*() functions during load and bail
   out in case they fail, from Christophe Leroy.

5) Avoid a goto in regs_refine_cond_op() such that the verifier can be better integrated
   into Agni tool which doesn't support backedges yet, from Harishankar Vishwanathan.

6) Add a small BPF trie perf improvement by always inlining longest_prefix_match,
   from Jesper Dangaard Brouer.

7) Small BPF selftest refactor in bpf_tcp_ca.c to utilize start_server() helper instead
   of open-coding it, from Geliang Tang.

8) Improve test_tc_tunnel.sh BPF selftest to prevent client connect before the server
   bind, from Alessandro Carminati.

9) Fix BPF selftest benchmark for older glibc and use syscall(SYS_gettid) instead of
   gettid(), from Alan Maguire.

10) Implement a backward-compatible method for struct_ops types with additional fields
    which are not present in older kernels, from Kui-Feng Lee.

11) Add a small helper to check if an instruction is addr_space_cast from as(0) to as(1)
    and utilize it in x86-64 JIT, from Puranjay Mohan.

12) Small cleanup to remove unnecessary error check in bpf_struct_ops_map_update_elem,
    from Martin KaFai Lau.

13) Improvements to libbpf fd validity checks for BPF map/programs, from Mykyta Yatsenko.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Daniel Borkmann, Eduard Zingerman, Ilya Leoshkevich, 
Jiri Olsa, Johan Almbladh, Kees Cook, Masami Hiramatsu (Google), 
Puranjay Mohan, Quentin Monnet, Stanislav Fomichev, Tiezhu Yang, 
Yonghong Song

----------------------------------------------------------------

The following changes since commit 9187210eee7d87eea37b45ea93454a88681894a4:

  Merge tag 'net-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2024-03-12 17:44:08 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 14bb1e8c8d4ad5d9d2febb7d19c70a3cf536e1e5:

  selftests/bpf: Fix flaky test btf_map_in_map/lookup_update (2024-03-25 17:25:54 +0100)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alan Maguire (1):
      selftests/bpf: Use syscall(SYS_gettid) instead of gettid() wrapper in bench

Alessandro Carminati (Red Hat) (1):
      selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh

Alexei Starovoitov (1):
      Merge branch 'bpf-raw-tracepoint-support-for-bpf-cookie'

Andrii Nakryiko (10):
      Merge branch 'ignore-additional-fields-in-the-struct_ops-maps-in-an-updated-version'
      bpf: preserve sleepable bit in subprog info
      Merge branch 'current_pid_tgid-for-all-prog-types'
      bpf: flatten bpf_probe_register call chain
      bpf: pass whole link instead of prog when triggering raw tracepoint
      bpf: support BPF cookie in raw tracepoint (raw_tp, tp_btf) programs
      libbpf: add support for BPF cookie for raw_tp/tp_btf programs
      selftests/bpf: add raw_tp/tp_btf BPF cookie subtests
      selftests/bpf: scale benchmark counting by using per-CPU counters
      bpf: Avoid get_kernel_nofault() to fetch kprobe entry IP

Christophe Leroy (4):
      bpf: Take return from set_memory_ro() into account with bpf_prog_lock_ro()
      bpf: Take return from set_memory_rox() into account with bpf_jit_binary_lock_ro()
      bpf: Remove arch_unprotect_bpf_trampoline()
      bpf: Check return from set_memory_rox()

Colin Ian King (1):
      selftests/bpf: Remove second semicolon

Geliang Tang (1):
      selftests/bpf: Use start_server in bpf_tcp_ca

Harishankar Vishwanathan (1):
      bpf-next: Avoid goto in regs_refine_cond_op()

Jesper Dangaard Brouer (1):
      bpf/lpm_trie: Inline longest_prefix_match for fastpath

Jiri Olsa (1):
      selftests/bpf: Mark uprobe trigger functions with nocf_check attribute

Kui-Feng Lee (3):
      bpftool: Cast pointers for shadow types explicitly.
      libbpf: Skip zeroed or null fields if not found in the kernel type.
      selftests/bpf: Ensure libbpf skip all-zeros fields of struct_ops maps.

Martin KaFai Lau (1):
      bpf: Remove unnecessary err < 0 check in bpf_struct_ops_map_update_elem

Mykyta Yatsenko (1):
      libbpbpf: Check bpf_map/bpf_program fd validity

Puranjay Mohan (1):
      bpf: implement insn_is_cast_user() helper for JITs

Quentin Monnet (4):
      libbpf: Prevent null-pointer dereference when prog to load has no BTF
      bpftool: Enable libbpf logs when loading pid_iter in debug mode
      bpftool: Remove unnecessary source files from bootstrap version
      bpftool: Clean up HOST_CFLAGS, HOST_LDFLAGS for bootstrap bpftool

Yonghong Song (9):
      bpftool: Fix missing pids during link show
      bpf: Allow helper bpf_get_[ns_]current_pid_tgid() for all prog types
      selftests/bpf: Replace CHECK with ASSERT_* in ns_current_pid_tgid test
      selftests/bpf: Refactor out some functions in ns_current_pid_tgid test
      selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test
      selftests/bpf: Add a sk_msg prog bpf_get_ns_current_pid_tgid() test
      libbpf: Add new sec_def "sk_skb/verdict"
      bpf: Sync uapi bpf.h to tools directory
      selftests/bpf: Fix flaky test btf_map_in_map/lookup_update

 arch/arm/net/bpf_jit_32.c                          |  25 ++-
 arch/arm64/net/bpf_jit_comp.c                      |   7 +-
 arch/loongarch/net/bpf_jit.c                       |  22 ++-
 arch/mips/net/bpf_jit_comp.c                       |   3 +-
 arch/parisc/net/bpf_jit_core.c                     |   8 +-
 arch/s390/net/bpf_jit_comp.c                       |   6 +-
 arch/sparc/net/bpf_jit_comp_64.c                   |   6 +-
 arch/x86/net/bpf_jit_comp.c                        |  10 +-
 arch/x86/net/bpf_jit_comp32.c                      |   3 +-
 include/linux/bpf.h                                |   9 +-
 include/linux/filter.h                             |  20 +-
 include/linux/trace_events.h                       |  36 ++--
 include/trace/bpf_probe.h                          |   3 +-
 include/uapi/linux/bpf.h                           |   6 +-
 kernel/bpf/bpf_struct_ops.c                        |  10 +-
 kernel/bpf/cgroup.c                                |   2 -
 kernel/bpf/core.c                                  |  32 ++-
 kernel/bpf/helpers.c                               |   4 +
 kernel/bpf/lpm_trie.c                              |  18 +-
 kernel/bpf/syscall.c                               |  22 +--
 kernel/bpf/trampoline.c                            |  15 +-
 kernel/bpf/verifier.c                              |  31 +--
 kernel/trace/bpf_trace.c                           |  52 +++--
 net/bpf/bpf_dummy_struct_ops.c                     |   4 +-
 net/core/filter.c                                  |   2 -
 tools/bpf/bpftool/Makefile                         |  14 +-
 tools/bpf/bpftool/gen.c                            |   3 +-
 tools/bpf/bpftool/pids.c                           |  19 +-
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c          |   4 +-
 tools/include/linux/compiler.h                     |   4 +
 tools/include/uapi/linux/bpf.h                     |   6 +-
 tools/lib/bpf/bpf.c                                |  16 +-
 tools/lib/bpf/bpf.h                                |   9 +
 tools/lib/bpf/libbpf.c                             | 111 +++++++++--
 tools/lib/bpf/libbpf.h                             |  11 ++
 tools/lib/bpf/libbpf.map                           |   2 +
 .../bpf/benchs/bench_local_storage_create.c        |   2 +-
 tools/testing/selftests/bpf/benchs/bench_trigger.c |  48 ++++-
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  | 114 ++++++++++-
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |  13 +-
 .../selftests/bpf/prog_tests/btf_map_in_map.c      |  26 +--
 .../selftests/bpf/prog_tests/ns_current_pid_tgid.c | 214 ++++++++++++++++++---
 .../bpf/prog_tests/test_struct_ops_module.c        |  47 +++++
 tools/testing/selftests/bpf/progs/iters.c          |   2 +-
 .../selftests/bpf/progs/struct_ops_module.c        |  16 +-
 .../testing/selftests/bpf/progs/test_bpf_cookie.c  |  16 ++
 .../selftests/bpf/progs/test_ns_current_pid_tgid.c |  31 ++-
 tools/testing/selftests/bpf/progs/trigger_bench.c  |  39 ++--
 tools/testing/selftests/bpf/test_cpp.cpp           |   5 +
 tools/testing/selftests/bpf/test_tc_tunnel.sh      |  13 +-
 50 files changed, 867 insertions(+), 274 deletions(-)

