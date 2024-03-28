Return-Path: <netdev+bounces-82858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D8A88FF79
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 13:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0270B1C25908
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE378004F;
	Thu, 28 Mar 2024 12:48:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDFE657CD;
	Thu, 28 Mar 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630088; cv=none; b=fJ+FBmAbBWrO4e9OXuix9mmjd5WRNuD54D8r6or5AXeHy6cP7g/UJVsiMFYJKxf9OgyFrS0e0GEEctmOkA4utj2eIFi7cpFkq+EX2YlsJ/ymGPaT3cV/cM7eIc4Jjfkf0yG3SwCjWutillNf6uORid+3kTwzE/UZk5Umrd02pcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630088; c=relaxed/simple;
	bh=OgO1GsL8qftPMfPPK/fGbrA4YVQqWlSQWsd0qsF9aTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XyuR2QPq+Ag6xoZV3LOXGDAknp7Ykv4ZpRVOFNP0Vx5VDiBuU3t98ZTULMRAUAPjqhd7WC8SiKjmeVxdlsW+KGzTM+GeZj5nOs5sOSfsL42rvXs9MHYFJF/3uIES/u/5pG07C4/x7DMy0dTEx/HGJZOw2TOJ+KoAHEBjwaU5wFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V53Gw4dH2z4f3mHG;
	Thu, 28 Mar 2024 20:47:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CC07E1A0A9E;
	Thu, 28 Mar 2024 20:48:00 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgAnlQj+ZgVmTvYNIg--.31354S2;
	Thu, 28 Mar 2024 20:47:59 +0800 (CST)
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
	Mykola Lysenko <mykolal@fb.com>,
	Manu Bretelle <chantr4@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 0/5] Support local vmtest for riscv64
Date: Thu, 28 Mar 2024 12:49:11 +0000
Message-Id: <20240328124916.293173-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnlQj+ZgVmTvYNIg--.31354S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47tr13tr43CryxGFyDZFb_yoW8AFWkpa
	y8Gw1Ykry0gF13tr17CrWUWFWfXFs5Zr43Gw18Xry5ZFyDtrWkJrn2kF4SqwnxurZ8Xrs0
	ya4SgF15uw18ZwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UQvtAUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

Patch 1 is to enable cross platform testing for local vmtest. The
remaining patch adds local vmtest support for riscv64. It relies on
commit [0] [1] for better regression.

We can now perform cross platform testing for riscv64 bpf using the
following command:

PLATFORM=riscv64 CROSS_COMPILE=riscv64-linux-gnu- \
    tools/testing/selftests/bpf/vmtest.sh -- \
        ./test_progs -d \
            \"$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 \
                | cut -d'#' -f1 \
                | sed -e 's/^[[:space:]]*//' \
                      -e 's/[[:space:]]*$//' \
                | tr -s '\n' ','\
            )\"

The test platform is x86_64 architecture, and the versions of relevant
components are as follows:
    QEMU: 8.2.0
    CLANG: 17.0.6 (align to BPF CI)
    OpenSBI: 1.3.1 (default by QEMU)
    ROOTFS: ubuntu jammy (generated by [2])

Link: https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?id=ea6873118493 [0]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=443574b033876c85 [1]
Link: https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh [2]

Pu Lehui (5):
  selftests/bpf: Enable cross platform testing for local vmtest
  riscv, bpf: Relax restrictions on Zbb instructions
  selftests/bpf: Add config.riscv64
  selftests/bpf: Add DENYLIST.riscv64
  selftests/bpf: Add riscv64 configurations to local vmtest

 arch/riscv/net/bpf_jit.h                     |  2 +-
 tools/testing/selftests/bpf/DENYLIST.riscv64 |  5 ++
 tools/testing/selftests/bpf/config.riscv64   | 85 ++++++++++++++++++++
 tools/testing/selftests/bpf/vmtest.sh        | 48 ++++++++---
 4 files changed, 127 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.riscv64
 create mode 100644 tools/testing/selftests/bpf/config.riscv64

-- 
2.34.1


