Return-Path: <netdev+bounces-84286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1463689665D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383671C20A1B
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 07:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122E55A0F3;
	Wed,  3 Apr 2024 07:27:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDF858AAC;
	Wed,  3 Apr 2024 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129229; cv=none; b=NRqK+kNRNG3G29syBEdCgFuW9N3ecCVdk4oO7mEJYxlKX4xZk6He9x19OJCjiSorEG3c6GxmFyaTUEvUQGn8abLESI0bLPwYfBfoANKppOFjoeNIKr1wG+HT866pjwOc6qgUOmLC/SwZe6j2K7BcKRVR/BmZD6MjFeEThoTqmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129229; c=relaxed/simple;
	bh=SPkEj7+81Z3bJXQlr0TkCgBWY25z97JBlVQbzAv3ss4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiTmteEY3pVfACG3nPl2skuGUZqIql+JSDwE64bncF2+6E/4KeNCEFwEIi7Wsi7iNLz4vAexMAOThbyxJRTZSpuDsrcYGn+/8p51SvVJVhqYFhI0juUOK9ju0iZExs8iZHtJFOGM+EaU+1GLgRgUZDr7d6cWPnkhuBthXj7oqlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V8bsq5Qmmz4f3nJc;
	Wed,  3 Apr 2024 15:26:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2367A1A0176;
	Wed,  3 Apr 2024 15:27:04 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgDnVQm9BA1mGuZmJA--.61978S3;
	Wed, 03 Apr 2024 15:27:03 +0800 (CST)
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
Subject: [PATCH bpf-next v3 1/2] riscv, bpf: Add 12-argument support for RV64 bpf trampoline
Date: Wed,  3 Apr 2024 07:28:17 +0000
Message-Id: <20240403072818.1462811-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403072818.1462811-1-pulehui@huaweicloud.com>
References: <20240403072818.1462811-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnVQm9BA1mGuZmJA--.61978S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar15Jw13Kr13WFWDGr4fGrg_yoWxGw1xp3
	WDKrsxAF9YqF47Ga92ga1UXF1ayan0v343KFW7Gas3uayYqr98GayFkF4jyry5GryrAw1f
	Ars0vr95K3W7CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUCVW8JwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjFdgJUU
	UUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

This patch adds 12 function arguments support for riscv64 bpf
trampoline. The current bpf trampoline supports <= sizeof(u64) bytes
scalar arguments [0] and <= 16 bytes struct arguments [1]. Therefore, we
focus on the situation where scalars are at most XLEN bits and
aggregates whose total size does not exceed 2×XLEN bits in the riscv
calling convention [2].

Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6184 [0]
Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6769 [1]
Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/download/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf [2]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 65 +++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 77ea306452d4..00723ac6cd1a 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -14,6 +14,7 @@
 #include <asm/cfi.h>
 #include "bpf_jit.h"
 
+#define RV_MAX_REG_ARGS 8
 #define RV_FENTRY_NINSNS 2
 
 #define RV_REG_TCC RV_REG_A6
@@ -688,26 +689,44 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 	return ret;
 }
 
-static void store_args(int nregs, int args_off, struct rv_jit_context *ctx)
+static void store_args(int nr_arg_slots, int args_off, struct rv_jit_context *ctx)
 {
 	int i;
 
-	for (i = 0; i < nregs; i++) {
-		emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
+	for (i = 0; i < nr_arg_slots; i++) {
+		if (i < RV_MAX_REG_ARGS) {
+			emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
+		} else {
+			/* skip slots for T0 and FP of traced function */
+			emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
+			emit_sd(RV_REG_FP, -args_off, RV_REG_T1, ctx);
+		}
 		args_off -= 8;
 	}
 }
 
-static void restore_args(int nregs, int args_off, struct rv_jit_context *ctx)
+static void restore_args(int nr_reg_args, int args_off, struct rv_jit_context *ctx)
 {
 	int i;
 
-	for (i = 0; i < nregs; i++) {
+	for (i = 0; i < nr_reg_args; i++) {
 		emit_ld(RV_REG_A0 + i, -args_off, RV_REG_FP, ctx);
 		args_off -= 8;
 	}
 }
 
+static void restore_stack_args(int nr_stack_args, int args_off, int stk_arg_off, struct rv_jit_context *ctx)
+{
+	int i;
+
+	for (i = 0; i < nr_stack_args; i++) {
+		emit_ld(RV_REG_T1, -(args_off - RV_MAX_REG_ARGS * 8), RV_REG_FP, ctx);
+		emit_sd(RV_REG_FP, -stk_arg_off, RV_REG_T1, ctx);
+		args_off -= 8;
+		stk_arg_off -= 8;
+	}
+}
+
 static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_off,
 			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
 {
@@ -780,8 +799,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 {
 	int i, ret, offset;
 	int *branches_off = NULL;
-	int stack_size = 0, nregs = m->nr_args;
-	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
+	int stack_size = 0, nr_arg_slots = 0;
+	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, stk_arg_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -827,20 +846,21 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	 * FP - sreg_off    [ callee saved reg	]
 	 *
 	 *		    [ pads              ] pads for 16 bytes alignment
+	 *
+	 *		    [ stack_argN        ]
+	 *		    [ ...               ]
+	 * FP - stk_arg_off [ stack_arg1        ] BPF_TRAMP_F_CALL_ORIG
 	 */
 
 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
 		return -ENOTSUPP;
 
-	/* extra regiters for struct arguments */
-	for (i = 0; i < m->nr_args; i++)
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			nregs += round_up(m->arg_size[i], 8) / 8 - 1;
-
-	/* 8 arguments passed by registers */
-	if (nregs > 8)
+	if (m->nr_args > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
 
+	for (i = 0; i < m->nr_args; i++)
+		nr_arg_slots += round_up(m->arg_size[i], 8) / 8;
+
 	/* room of trampoline frame to store return address and frame pointer */
 	stack_size += 16;
 
@@ -850,7 +870,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		retval_off = stack_size;
 	}
 
-	stack_size += nregs * 8;
+	stack_size += nr_arg_slots * 8;
 	args_off = stack_size;
 
 	stack_size += 8;
@@ -867,8 +887,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	stack_size += 8;
 	sreg_off = stack_size;
 
+	if (nr_arg_slots - RV_MAX_REG_ARGS > 0)
+		stack_size += (nr_arg_slots - RV_MAX_REG_ARGS) * 8;
+
 	stack_size = round_up(stack_size, 16);
 
+	/* room for args on stack must be at the top of stack */
+	stk_arg_off = stack_size;
+
 	if (!is_struct_ops) {
 		/* For the trampoline called from function entry,
 		 * the frame of traced function and the frame of
@@ -904,10 +930,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		emit_sd(RV_REG_FP, -ip_off, RV_REG_T1, ctx);
 	}
 
-	emit_li(RV_REG_T1, nregs, ctx);
+	emit_li(RV_REG_T1, nr_arg_slots, ctx);
 	emit_sd(RV_REG_FP, -nregs_off, RV_REG_T1, ctx);
 
-	store_args(nregs, args_off, ctx);
+	store_args(nr_arg_slots, args_off, ctx);
 
 	/* skip to actual body of traced function */
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
@@ -947,7 +973,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(nregs, args_off, ctx);
+		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
+		restore_stack_args(nr_arg_slots - RV_MAX_REG_ARGS, args_off, stk_arg_off, ctx);
 		ret = emit_call((const u64)orig_call, true, ctx);
 		if (ret)
 			goto out;
@@ -982,7 +1009,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(nregs, args_off, ctx);
+		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
 
 	if (save_ret) {
 		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
-- 
2.34.1


