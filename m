Return-Path: <netdev+bounces-84287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A66B89665E
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35570287DDB
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 07:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC765B053;
	Wed,  3 Apr 2024 07:27:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E359B4A;
	Wed,  3 Apr 2024 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129229; cv=none; b=sRS11M1Mt9QZYTnb+Zz3DhKoqknBs5GLUYXjh39T3JwA+phpC4I6T3J1rRJOsGW3upjF9XX3Dg3o5tDa1Ju088rEabyLdtOcFT+i2eAMi1vvQt8YRzHrkJAwkN5w75ioHvNr+RK5N1JElKvBdW+jjWV+HiLGrkyeLuBYuil72Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129229; c=relaxed/simple;
	bh=L4rgKuVRSBngb0+Lrjuoo/eYL8Q5uNKypIFRw2Srb0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LIIHcAdSHfzkGDJPTjQkv0UDWXyeW7YSoc/MpBqtXtgVQYsD+UqkKtfi/8c62yNdYaS2tVBdXSXLfiF1Lk8Gtb3TU36H2bPxeQNJBkjMcYgPmy2j6eh89FLLnpnteHHgSfrGQbM8KKTNdZ1bg8YonXouHfFdwVrWXA58Fqakvos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V8bsq4lnjz4f3nJS;
	Wed,  3 Apr 2024 15:26:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0B3F81A1025;
	Wed,  3 Apr 2024 15:27:04 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgDnVQm9BA1mGuZmJA--.61978S2;
	Wed, 03 Apr 2024 15:26:54 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v3 0/2] Add 12-argument support for RV64 bpf trampoline
Date: Wed,  3 Apr 2024 07:28:16 +0000
Message-Id: <20240403072818.1462811-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnVQm9BA1mGuZmJA--.61978S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF45KF1xuF4fXryktF4fXwb_yoW8Cw18pa
	1xWw13uFn5KF42q347Ja1UuryFqr4rW345ur47J34FkayDtryYyr1I9ayYvw15Wr1ru3yI
	y34a9F98uF1DZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	QVy7UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

This patch adds 12 function arguments support for riscv64 bpf
trampoline. The current bpf trampoline supports <= sizeof(u64) bytes
scalar arguments [0] and <= 16 bytes struct arguments [1]. Therefore, we
focus on the situation where scalars are at most XLEN bits and
aggregates whose total size does not exceed 2×XLEN bits in the riscv
calling convention [2].

Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6184 [0]
Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6769 [1]
Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/download/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf [2]

v3:
- Variable and macro name alignment:
  nr_reg_args: number of args in reg
  nr_stack_args: number of args on stack
  RV_MAX_REG_ARGS: macro for riscv max args in reg

v2: https://lore.kernel.org/all/20240403041710.1416369-1-pulehui@huaweicloud.com/
- Add tracing_struct to DENYLIST.aarch64 while aarch64 does not yet support
  bpf trampoline with more than 8 args.
- Change the macro RV_MAX_ARG_REGS to RV_MAX_ARGS_REG to synchronize with
  the variable definition below.
- Add some comments for stk_arg_off and magic number of skip slots for loading
  args on stack.

v1: https://lore.kernel.org/all/20240331092405.822571-1-pulehui@huaweicloud.com/

Pu Lehui (2):
  riscv, bpf: Add 12-argument support for RV64 bpf trampoline
  selftests/bpf: Add testcase where 7th argment is struct

 arch/riscv/net/bpf_jit_comp64.c               | 65 +++++++++++++------
 tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 19 ++++++
 .../selftests/bpf/prog_tests/tracing_struct.c | 13 ++++
 .../selftests/bpf/progs/tracing_struct.c      | 35 ++++++++++
 5 files changed, 114 insertions(+), 19 deletions(-)

-- 
2.34.1


