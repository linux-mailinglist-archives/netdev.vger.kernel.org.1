Return-Path: <netdev+bounces-81400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A2E887C43
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 11:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0AE281CF7
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F4017559;
	Sun, 24 Mar 2024 10:32:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE817991;
	Sun, 24 Mar 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711276325; cv=none; b=nrq+SjdTDDbNgMheMVzdHz2e/gZ8juckGCAzYrfa5FxHVk+4B6EC5Zm8mYq1MC0EEvAjJiDVpBb5jK91ueO6JTfioeL/1KuUhV5XLJoGpbepBRMjs+0FbcwdLzNR31fc1CLMLf//1FNqQN/iMRq3b2sbG2l0eIfOaOAhMhPhPzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711276325; c=relaxed/simple;
	bh=JaLRqPL2VdDNRB2V7rpBmRl8eSyG0Sse/khcixW7Dtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OEAQMBXQ1SjSU/lkl0DS2C6SV1Rttx6mmYrHdFPpBO9SAXDnckGgWwiN852JG8P8KWHXp5edIFZrF0boHI7O2ZQg9PCUwgehq6jqWaZni3CYMW+nyvST+ITah9+Z+ny34oZWNwbTJr4R319odJe+xBLV646mbTpUcxek0axOHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V2XRn2YDDz4f3jk6;
	Sun, 24 Mar 2024 18:31:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 518181A0B85;
	Sun, 24 Mar 2024 18:31:53 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgAXI5sXAQBmLI08Hw--.23015S2;
	Sun, 24 Mar 2024 18:31:53 +0800 (CST)
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
	Luke Nelson <luke.r.nels@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf] riscv, bpf: Fix kfunc parameters incompatibility between bpf and riscv abi
Date: Sun, 24 Mar 2024 10:33:06 +0000
Message-Id: <20240324103306.2202954-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXI5sXAQBmLI08Hw--.23015S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW5Xw13GF13Xr48uw4kJFb_yoW8tFy5pF
	45Gr1Ykr4kXw1xZrnayF48Jr1fCr4v9a1avFyxWFy5GrZFgay5Jr4Yk3yYva45Cr15Wa4a
	yrWDWrn0k34kA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	QVy7UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

We encountered a failing case when running selftest in no_alu32 mode:

The failure case is `kfunc_call/kfunc_call_test4` and its source code is
like bellow:
```
long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
int kfunc_call_test4(struct __sk_buff *skb)
{
	...
	tmp = bpf_kfunc_call_test4(-3, -30, -200, -1000);
	...
}
```

And its corresponding asm code is:
```
0: r1 = -3
1: r2 = -30
2: r3 = 0xffffff38 # opcode: 18 03 00 00 38 ff ff ff 00 00 00 00 00 00 00 00
4: r4 = -1000
5: call bpf_kfunc_call_test4
```

insn 2 is parsed to ld_imm64 insn to emit 0x00000000ffffff38 imm, and
converted to int type and then send to bpf_kfunc_call_test4. But since
it is zero-extended in the bpf calling convention, riscv jit will
directly treat it as an unsigned 32-bit int value, and then fails with
the message "actual 4294966063 != expected -1234".

The reason is the incompatibility between bpf and riscv abi, that is,
bpf will do zero-extension on uint, but riscv64 requires sign-extension
on int or uint. We can solve this problem by sign extending the 32-bit
parameters in kfunc.

The issue is related to [0], and thanks to Yonghong and Alexei.

Link: https://github.com/llvm/llvm-project/pull/84874 [0]
Fixes: d40c3847b485 ("riscv, bpf: Add kfunc support for RV64")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 869e4282a2c4..e3fc39370f7d 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1454,6 +1454,22 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (ret < 0)
 			return ret;
 
+		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
+			const struct btf_func_model *fm;
+			int idx;
+
+			fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
+			if (!fm)
+				return -EINVAL;
+
+			for (idx = 0; idx < fm->nr_args; idx++) {
+				u8 reg = bpf_to_rv_reg(BPF_REG_1 + idx, ctx);
+
+				if (fm->arg_size[idx] == sizeof(int))
+					emit_sextw(reg, reg, ctx);
+			}
+		}
+
 		ret = emit_call(addr, fixed_addr, ctx);
 		if (ret)
 			return ret;
-- 
2.34.1


