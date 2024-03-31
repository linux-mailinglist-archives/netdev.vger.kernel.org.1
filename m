Return-Path: <netdev+bounces-83612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9224B893319
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B663A1C22416
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D517D1514D5;
	Sun, 31 Mar 2024 16:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D914D43C;
	Sun, 31 Mar 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902491; cv=fail; b=XyC8dpB73/apZtoW/lkKcPKg/qOTYw2ZvMLgGeR/cyDxIvteCa0OoCoSOZWxWuyvIWO0ziJDIxIydSYGUJl5afQ1AjeVOOpfNBeONKKbpKe4P1lXgWWVu7j4gB5yMNZLpqcMQSPv6K172dIaK8UyIvzaxKXgycp4hCSZgvfNuUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902491; c=relaxed/simple;
	bh=lxdlk9jfPzMxUWRkL5fxXBcQWBmKGUTXM5mEyWmp80k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huQyBghRjg7ayBAcIBnRDx8vyD4+hgvr8OPPjieTHnN5lsQ8Fib4Ljg/WuOWdXTZcJhXCxKu/pOsjfNKr8jqethNMX2qZVU9kmIw9BnyDXz0LiAtnyiiNzloaVTrLrgGD8eq3H+D2Msf7LuBQl87p76FWDDj0gK6BDLf2Kj4JmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=fail smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=huaweicloud.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 28A1A20185;
	Sun, 31 Mar 2024 18:27:14 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1J2iHdlZ6JU0; Sun, 31 Mar 2024 18:27:10 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 93591208B8;
	Sun, 31 Mar 2024 18:27:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 93591208B8
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 862D2800051;
	Sun, 31 Mar 2024 18:27:10 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:27:10 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:24:03 +0000
X-sender: <netdev+bounces-83574-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAM8xAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBRAAAAr4oAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 22185
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83574-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3233C207D8
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711876971; cv=none; b=hv2V0jigilROcK8EYto6mRFG8DmuWtzxXZdqHtz9fMG0J+dkwO3J41ISZ+hTRcRxWrMDvtPfqrGiOO2Pa5vS9Hw9hNW0+rcY8I0q3N1C1xYo9KnGofkVAWYNtZ045WxaXdk92DZrHEodFCKU10wDs2vIdFY6zGSn/djqvoiqa+0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711876971; c=relaxed/simple;
	bh=NU/seP21mtWkdilB97nH/1Auom8uGHKorbHfj6W3x1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5VU4JM9HWfq6ydlfdq15M8AHsNevxb1HZ/WRW7e5KCGFbuynlYb35Qx1hbwhN8rTBK/vhMo3wMg6IQKk1cvjnlml0wLsB2fxmf42iOXZsYiZWVGRgHzQLCt/253/+2SOkeNOhmEUNNNocVPFZzGfHby5lZfh2NLhB8+aGYDVJ8=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
From: Pu Lehui <pulehui@huaweicloud.com>
To: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
	<pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 1/2] riscv, bpf: Add 12-argument support for RV64 bpf trampoline
Date: Sun, 31 Mar 2024 09:24:04 +0000
Message-ID: <20240331092405.822571-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240331092405.822571-1-pulehui@huaweicloud.com>
References: <20240331092405.822571-1-pulehui@huaweicloud.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: gCh0CgCH2WtkKwlmesQWIw--.11467S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar15Jw13Kr1kAF13Cr45ZFb_yoWxJr4Dpa
	1DKrsxAFyvqa17Xa97WF1UXF1aya1qva43CFW7Gas3uFWYqr98GayFkF4jyry5GryrAw1f
	AFs0vF98KF17GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSYLPUUUUU
	=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Pu Lehui <pulehui@huawei.com>

This patch adds 12 function arguments support for riscv64 bpf
trampoline. The current bpf trampoline supports <=3D sizeof(u64) bytes
scalar arguments [0] and <=3D 16 bytes struct arguments [1]. Therefore, we
focus on the situation where scalars are at most XLEN bits and
aggregates whose total size does not exceed 2=C3=97XLEN bits in the riscv
calling convention [2].

Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6184 [=
0]
Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6769 [=
1]
Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/downloa=
d/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf [2]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 63 +++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp6=
4.c
index 77ea306452d4..2aec69e4c116 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -14,6 +14,7 @@
 #include <asm/cfi.h>
 #include "bpf_jit.h"
=20
+#define RV_MAX_ARG_REGS 8
 #define RV_FENTRY_NINSNS 2
=20
 #define RV_REG_TCC RV_REG_A6
@@ -688,26 +689,43 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_t=
ype poke_type,
 	return ret;
 }
=20
-static void store_args(int nregs, int args_off, struct rv_jit_context *ctx=
)
+static void store_args(int nr_arg_slots, int args_off, struct rv_jit_conte=
xt *ctx)
 {
 	int i;
=20
-	for (i =3D 0; i < nregs; i++) {
-		emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
+	for (i =3D 0; i < nr_arg_slots; i++) {
+		if (i < RV_MAX_ARG_REGS) {
+			emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
+		} else {
+			emit_ld(RV_REG_T1, 16 + (i - RV_MAX_ARG_REGS) * 8, RV_REG_FP, ctx);
+			emit_sd(RV_REG_FP, -args_off, RV_REG_T1, ctx);
+		}
 		args_off -=3D 8;
 	}
 }
=20
-static void restore_args(int nregs, int args_off, struct rv_jit_context *c=
tx)
+static void restore_args(int nr_args_reg, int args_off, struct rv_jit_cont=
ext *ctx)
 {
 	int i;
=20
-	for (i =3D 0; i < nregs; i++) {
+	for (i =3D 0; i < nr_args_reg; i++) {
 		emit_ld(RV_REG_A0 + i, -args_off, RV_REG_FP, ctx);
 		args_off -=3D 8;
 	}
 }
=20
+static void restore_stack_args(int nr_args_stack, int args_off, int stk_ar=
g_off, struct rv_jit_context *ctx)
+{
+	int i;
+
+	for (i =3D 0; i < nr_args_stack; i++) {
+		emit_ld(RV_REG_T1, -(args_off - RV_MAX_ARG_REGS * 8), RV_REG_FP, ctx);
+		emit_sd(RV_REG_FP, -stk_arg_off, RV_REG_T1, ctx);
+		args_off -=3D 8;
+		stk_arg_off -=3D 8;
+	}
+}
+
 static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int ret=
val_off,
 			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
 {
@@ -780,8 +798,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tra=
mp_image *im,
 {
 	int i, ret, offset;
 	int *branches_off =3D NULL;
-	int stack_size =3D 0, nregs =3D m->nr_args;
-	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
+	int stack_size =3D 0, nr_arg_slots =3D 0;
+	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, stk_a=
rg_off;
 	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -827,20 +845,21 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im,
 	 * FP - sreg_off    [ callee saved reg	]
 	 *
 	 *		    [ pads              ] pads for 16 bytes alignment
+	 *
+	 *		    [ stack_argN        ]
+	 *		    [ ...               ]
+	 * FP - stk_arg_off [ stack_arg1        ] BPF_TRAMP_F_CALL_ORIG
 	 */
=20
 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
 		return -ENOTSUPP;
=20
-	/* extra regiters for struct arguments */
-	for (i =3D 0; i < m->nr_args; i++)
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			nregs +=3D round_up(m->arg_size[i], 8) / 8 - 1;
-
-	/* 8 arguments passed by registers */
-	if (nregs > 8)
+	if (m->nr_args > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
=20
+	for (i =3D 0; i < m->nr_args; i++)
+		nr_arg_slots +=3D round_up(m->arg_size[i], 8) / 8;
+
 	/* room of trampoline frame to store return address and frame pointer */
 	stack_size +=3D 16;
=20
@@ -850,7 +869,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tra=
mp_image *im,
 		retval_off =3D stack_size;
 	}
=20
-	stack_size +=3D nregs * 8;
+	stack_size +=3D nr_arg_slots * 8;
 	args_off =3D stack_size;
=20
 	stack_size +=3D 8;
@@ -867,8 +886,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tr=
amp_image *im,
 	stack_size +=3D 8;
 	sreg_off =3D stack_size;
=20
+	if (nr_arg_slots - RV_MAX_ARG_REGS > 0)
+		stack_size +=3D (nr_arg_slots - RV_MAX_ARG_REGS) * 8;
+
 	stack_size =3D round_up(stack_size, 16);
=20
+	stk_arg_off =3D stack_size;
+
 	if (!is_struct_ops) {
 		/* For the trampoline called from function entry,
 		 * the frame of traced function and the frame of
@@ -904,10 +928,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im,
 		emit_sd(RV_REG_FP, -ip_off, RV_REG_T1, ctx);
 	}
=20
-	emit_li(RV_REG_T1, nregs, ctx);
+	emit_li(RV_REG_T1, nr_arg_slots, ctx);
 	emit_sd(RV_REG_FP, -nregs_off, RV_REG_T1, ctx);
=20
-	store_args(nregs, args_off, ctx);
+	store_args(nr_arg_slots, args_off, ctx);
=20
 	/* skip to actual body of traced function */
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
@@ -947,7 +971,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tra=
mp_image *im,
 	}
=20
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(nregs, args_off, ctx);
+		restore_args(min_t(int, nr_arg_slots, RV_MAX_ARG_REGS), args_off, ctx);
+		restore_stack_args(nr_arg_slots - RV_MAX_ARG_REGS, args_off, stk_arg_off=
, ctx);
 		ret =3D emit_call((const u64)orig_call, true, ctx);
 		if (ret)
 			goto out;
@@ -982,7 +1007,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tr=
amp_image *im,
 	}
=20
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(nregs, args_off, ctx);
+		restore_args(min_t(int, nr_arg_slots, RV_MAX_ARG_REGS), args_off, ctx);
=20
 	if (save_ret) {
 		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
--=20
2.34.1


X-sender: <netdev+bounces-83574-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAM8xAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBSAAAAr4oAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 22207
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sun, 31 Mar 2024 11:23:15 +0200
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Fronte=
nd
 Transport; Sun, 31 Mar 2024 11:23:15 +0200
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E0867207D8
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 11:23:15 +0200 (CEST)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -4.951
X-Spam-Level:
X-Spam-Status: No, score=3D-4.951 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001,
	SPF_PASS=3D-0.001] autolearn=3Dunavailable autolearn_force=3Dno
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FgcpQXHOp7KE for <steffen.klassert@secunet.com>;
	Sun, 31 Mar 2024 11:23:12 +0200 (CEST)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83574-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 48F6220892
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 48F6220892
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 11:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D836A2828E6
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78147764E;
	Sun, 31 Mar 2024 09:22:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228B6E5E8;
	Sun, 31 Mar 2024 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D45.249.212.51
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711876971; cv=3Dnone; b=3Dhv2V0jigilROcK8EYto6mRFG8DmuWtzxXZdqHtz9fMG=
0J+dkwO3J41ISZ+hTRcRxWrMDvtPfqrGiOO2Pa5vS9Hw9hNW0+rcY8I0q3N1C1xYo9KnGofkVAW=
YNtZ045WxaXdk92DZrHEodFCKU10wDs2vIdFY6zGSn/djqvoiqa+0=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711876971; c=3Drelaxed/simple;
	bh=3DNU/seP21mtWkdilB97nH/1Auom8uGHKorbHfj6W3x1U=3D;
	h=3DFrom:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=3Dt5VU4JM9HWfq6ydlfdq15M8AHsNevxb1HZ/WRW7e5K=
CGFbuynlYb35Qx1hbwhN8rTBK/vhMo3wMg6IQKk1cvjnlml0wLsB2fxmf42iOXZsYiZWVGRgHzQ=
LCt/253/+2SOkeNOhmEUNNNocVPFZzGfHby5lZfh2NLhB8+aGYDVJ8=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dnone (=
p=3Dnone dis=3Dnone) header.from=3Dhuaweicloud.com; spf=3Dpass smtp.mailfro=
m=3Dhuaweicloud.com; arc=3Dnone smtp.client-ip=3D45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dnone (p=3Dnone di=
s=3Dnone) header.from=3Dhuaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dhuaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V6pZh3SXWz4f3lgR;
	Sun, 31 Mar 2024 17:22:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B51391A0DDA;
	Sun, 31 Mar 2024 17:22:44 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCH2WtkKwlmesQWIw--.11467S3;
	Sun, 31 Mar 2024 17:22:44 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: =3D?UTF-8?q?Bj=3DC3=3DB6rn=3D20T=3DC3=3DB6pel?=3D <bjorn@kernel.org>, A=
lexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
	<pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 1/2] riscv, bpf: Add 12-argument support for RV64 =
bpf trampoline
Date: Sun, 31 Mar 2024 09:24:04 +0000
Message-ID: <20240331092405.822571-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240331092405.822571-1-pulehui@huaweicloud.com>
References: <20240331092405.822571-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"UTF-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH2WtkKwlmesQWIw--.11467S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar15Jw13Kr1kAF13Cr45ZFb_yoWxJr4Dpa
	1DKrsxAFyvqa17Xa97WF1UXF1aya1qva43CFW7Gas3uFWYqr98GayFkF4jyry5GryrAw1f
	AFs0vF98KF17GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSYLPUUUUU
	=3D
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
Return-Path: netdev+bounces-83574-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 31 Mar 2024 09:23:15.9421
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: d051c5e4-93c2-4f22-1379-08dc=
51643222
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.409|SMR=3D0.346(SMRDE=3D0.036|SMRC=3D0.30=
9(SMRCL=3D0.103|X-SMRCR=3D0.309))|CAT=3D0.062(CATOS=3D0.016
 (CATSM=3D0.016(CATSM-Malware
 Agent=3D0.015))|CATRESL=3D0.020(CATRESLP2R=3D0.001)|CATORES=3D0.023
 (CATRS=3D0.023(CATRS-Index Routing Agent=3D0.022)));2024-03-31T09:23:16.39=
2Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 13819
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.040|SMR=3D0.023(SMRPI=3D0.021(SMRPI-FrontendProxyAgent=3D0.021))=
|SMS=3D0.017
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAa4MAAAPAAADH4sIAAAAAAAEAM1Ze1Mb=
yRGf1VsCgU3Z5t
 4Z31VdAL2FLInzo8wRuLgOYwpw6q5clGq1GomNJa1qd4VxEn+D/J9P
 kk+QL5bumX3MrlYWnLlUtiiY7enpx697enqWf7cOTGP0Az2e0kN2Md
 Xpk8l0iIPnF1P1HdPLmjF6ls/lc2cXukUnqq1dULXXs2itTvvTsWbr
 xpiq5mA6YmPbotZ0MjFMm/YNk5q6pV02G7Q76edztqmOJsZQH7MyPb
 tgVJuaJqzASerPuest+uQptfS/MaO/MW02Nmn3vc2sfM7S1KFqSvre
 VM+pOu4he60puKhlm1PNlplq51ypycAsVqTvWD7XN7SpRcF2G4yxdH
 uqck/eIRcVaiwQwahq05Fh2fSXw/0j2tVBHOjL59TBwGQDFfW9uzAs
 Rm3DVofcZtozgDo2bMquNMZ6tP6ff/mrdaGSg5PPgSLwe0A1Y3wJtq
 IJb+rnZQT8UB+//YFe2PbE+qFSYUP9SjfLXcOwYQFGpQJ/p1eVy2a5
 XbGMqamxyltmjtmwAphWuna/rH132Ky1GwjSbYlrNXcQzrC4gW5fTL
 tcDHesNDbGJd1SnTc27JcmltrVSz1Dq5hsyFSLWZWe8W48NNRepWeq
 fbtUr9a3qzv1nRJ7pLWrVdZs1tRH26zPtrV6s9XutWrqdrW5Xd/uNq
 usW9vuOtJBbnnS6yNw+dypPhizXsno90vd9wvTulQq5XMQZu1CyKqM
 mY3+dv6q2x1gmTQbZY3+gza3aSH6KXkPCKrRvj6E3L5QxwPWK9JGA8
 JtMRPjam0UNou0tkN74L4glDYxzj2936elEkBI1coiU7qLOPI5fdxj
 V7TVYohW41G91yiX6yrTmjusodVgl9SqQG9w5xdrzOfAyeuoff6clm
 qNYpMW4HeLPn8OeHynj7XhtMfoE9UaVbS+Xr54JpO/dcSUL75FJArf
 9Vgfq8DJXzovd3/p7J781DnZ/+mUtnGRP3ewf3R28mvn6MXR6dEpre
 NSeRqWdM729tzhblMY12y3i3Uwr9neKTa2wUCIDa8/HfStY7MruzMx
 3rKNS0Pv0S19UqRsPB1xDm+yY7+fMOqNiqDZeUxmT80x/nkMxA9oVM
 myoapolAu0bKg9oGpgbaDeMVQPq8hNQFoHErboVi7z0sF2jHrplmZf
 QaYUPioNxx1raNg3E0r/7nuAy/TH3HCHglV8Q6dPafUxhS0kjIZhob
 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
 goeVE3RPnyx466xNei8Lrnn7BhldsA0MXIXQ5vnEuGcTKDmQawg4Wr
 mJ+iLDhOQb3NiB2RRvBXJZt9C5MIVEogluKSA744bCuzwv0t72y95U
 +QLxNXQl6nSE5Q7nBKiqyFGJIkG6TcDTG4WtKCvu7IgZqfn1fSrxeO
 O1IxQRv4gVVPkHu88ie8HiVLHrkV+2UwUVMufQWI97lktwX5mrcyeJ
 A9kOgQU6B84VJ4A/BVimQy5DPRDIiDMksehPaglAmw8EFMJBJGR4hK
 CgPcpuQbUJ1E10SzgpwZvi8cmU4Oi/Ga6BmyPFK8T0D5XmLEAtoRw7
 vOoQBurnPj7y+w1j9frmEVWRMNnGjyvDbRa7/S5J6bzBke+tyn7cr7
 btp70fzKHWQ8EDzK7MbxSp/Lc9czj5uUnjXvJlmaD0iLUhcLnOCZqA
 rsIkay8zmF/FWXM+1FyjUgxc2+E5X/azFeIvK8GYuTL4VM4Q54x3vd
 L73uGYgZt99Dyvze7JoRjDxQvJIVPE2+imIWvcFq5FSwQ4vkCdRJSZ
 ebCfzolE4fD+SkLFxiuCe2gEDPRew+tzMTLinK0qfl/xee2GAF+9xr
 hIK2rfsNEujgt4l40JFg6xhe6zUqc1PRbycCxw0sj/Mp3oSnxP3Ce0
 3g6zqH/RtuW1aGJUmgyqR+GyyfubCk0ev13wEW3MLua3RD6B3NgQQT
 N2clJjYOjv8LqELODXIrAAABCtgBPD94bWwgdmVyc2lvbj0iMS4wIi
 BlbmNvZGluZz0idXRmLTE2Ij8+DQo8RW1haWxTZXQ+DQogIDxWZXJz
 aW9uPjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8RW1haWxzPg0KICAgID
 xFbWFpbCBTdGFydEluZGV4PSIxNiI+DQogICAgICA8RW1haWxTdHJp
 bmc+cHVsZWh1aUBodWF3ZWkuY29tPC9FbWFpbFN0cmluZz4NCiAgIC
 A8L0VtYWlsPg0KICA8L0VtYWlscz4NCjwvRW1haWxTZXQ+AQurBTw/
 eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg0KPF
 VybFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+DQog
 IDxVcmxzPg0KICAgIDxVcmwgU3RhcnRJbmRleD0iNDEzIiBQb3NpdG
 lvbj0iT3RoZXIiIFR5cGU9IlVybCI+DQogICAgICA8VXJsU3RyaW5n
 Pmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2Ljgvc2
 91cmNlL2tlcm5lbC9icGYvYnRmLmMjTDYxODQ8L1VybFN0cmluZz4N
 CiAgICA8L1VybD4NCiAgICA8VXJsIFN0YXJ0SW5kZXg9IjQ5MiIgUG
 9zaXRpb249Ik90aGVyIiBUeXBlPSJVcmwiPg0KICAgICAgPFVybFN0
 cmluZz5odHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni
 44L3NvdXJjZS9rZXJuZWwvYnBmL2J0Zi5jI0w2NzY5PC9VcmxTdHJp
 bmc+DQogICAgPC9Vcmw+DQogICAgPFVybCBTdGFydEluZGV4PSI1Nz
 EiIFBvc2l0aW9uPSJPdGhlciIgVHlwZT0iVXJsIj4NCiAgICAgIDxV
 cmxTdHJpbmc+aHR0cHM6Ly9naXRodWIuY29tL3Jpc2N2LW5vbi1pc2
 EvcmlzY3YtZWxmLXBzYWJpLWRvYy9yZWxlYXNlcy9kb3dubG9hZC9k
 cmFmdC0yMDIzMDkyOS1lNWM4MDBlNjYxYTUzZWZlM2MyNjc4ZDcxYT
 MwNjMyM2I2MGViMTNiL3Jpc2N2LWFiaS5wZGY8L1VybFN0cmluZz4N
 CiAgICA8L1VybD4NCiAgPC9VcmxzPg0KPC9VcmxTZXQ+AQzaAzw/eG
 1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg0KPENv
 bnRhY3RTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW9uPg
 0KICA8Q29udGFjdHM+DQogICAgPENvbnRhY3QgU3RhcnRJbmRleD0i
 NiI+DQogICAgICA8UGVyc29uIFN0YXJ0SW5kZXg9IjYiPg0KICAgIC
 AgICA8UGVyc29uU3RyaW5nPlB1PC9QZXJzb25TdHJpbmc+DQogICAg
 ICA8L1BlcnNvbj4NCiAgICAgIDxFbWFpbHM+DQogICAgICAgIDxFbW
 FpbCBTdGFydEluZGV4PSIxNiI+DQogICAgICAgICAgPEVtYWlsU3Ry
 aW5nPnB1bGVodWlAaHVhd2VpLmNvbTwvRW1haWxTdHJpbmc+DQogIC
 AgICAgIDwvRW1haWw+DQogICAgICA8L0VtYWlscz4NCiAgICAgIDxD
 b250YWN0U3RyaW5nPlB1IExlaHVpICZsdDtwdWxlaHVpQGh1YXdlaS
 5jb208L0NvbnRhY3RTdHJpbmc+DQogICAgPC9Db250YWN0Pg0KICA8
 L0NvbnRhY3RzPg0KPC9Db250YWN0U2V0PgEOzgFSZXRyaWV2ZXJPcG
 VyYXRvciwxMCwwO1JldHJpZXZlck9wZXJhdG9yLDExLDE7UG9zdERv
 Y1BhcnNlck9wZXJhdG9yLDEwLDA7UG9zdERvY1BhcnNlck9wZXJhdG
 9yLDExLDA7UG9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZXJhdG9y
 LDEwLDM7UG9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZXJhdG9yLD
 ExLDA7VHJhbnNwb3J0V3JpdGVyUHJvZHVjZXIsMjAsOQ=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 4852
X-MS-Exchange-Forest-EmailMessageHash: 7B5AE8ED
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

From: Pu Lehui <pulehui@huawei.com>

This patch adds 12 function arguments support for riscv64 bpf
trampoline. The current bpf trampoline supports <=3D sizeof(u64) bytes
scalar arguments [0] and <=3D 16 bytes struct arguments [1]. Therefore, we
focus on the situation where scalars are at most XLEN bits and
aggregates whose total size does not exceed 2=C3=97XLEN bits in the riscv
calling convention [2].

Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6184 [=
0]
Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6769 [=
1]
Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/downloa=
d/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf [2]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 63 +++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp6=
4.c
index 77ea306452d4..2aec69e4c116 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -14,6 +14,7 @@
 #include <asm/cfi.h>
 #include "bpf_jit.h"
=20
+#define RV_MAX_ARG_REGS 8
 #define RV_FENTRY_NINSNS 2
=20
 #define RV_REG_TCC RV_REG_A6
@@ -688,26 +689,43 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_t=
ype poke_type,
 	return ret;
 }
=20
-static void store_args(int nregs, int args_off, struct rv_jit_context *ctx=
)
+static void store_args(int nr_arg_slots, int args_off, struct rv_jit_conte=
xt *ctx)
 {
 	int i;
=20
-	for (i =3D 0; i < nregs; i++) {
-		emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
+	for (i =3D 0; i < nr_arg_slots; i++) {
+		if (i < RV_MAX_ARG_REGS) {
+			emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
+		} else {
+			emit_ld(RV_REG_T1, 16 + (i - RV_MAX_ARG_REGS) * 8, RV_REG_FP, ctx);
+			emit_sd(RV_REG_FP, -args_off, RV_REG_T1, ctx);
+		}
 		args_off -=3D 8;
 	}
 }
=20
-static void restore_args(int nregs, int args_off, struct rv_jit_context *c=
tx)
+static void restore_args(int nr_args_reg, int args_off, struct rv_jit_cont=
ext *ctx)
 {
 	int i;
=20
-	for (i =3D 0; i < nregs; i++) {
+	for (i =3D 0; i < nr_args_reg; i++) {
 		emit_ld(RV_REG_A0 + i, -args_off, RV_REG_FP, ctx);
 		args_off -=3D 8;
 	}
 }
=20
+static void restore_stack_args(int nr_args_stack, int args_off, int stk_ar=
g_off, struct rv_jit_context *ctx)
+{
+	int i;
+
+	for (i =3D 0; i < nr_args_stack; i++) {
+		emit_ld(RV_REG_T1, -(args_off - RV_MAX_ARG_REGS * 8), RV_REG_FP, ctx);
+		emit_sd(RV_REG_FP, -stk_arg_off, RV_REG_T1, ctx);
+		args_off -=3D 8;
+		stk_arg_off -=3D 8;
+	}
+}
+
 static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int ret=
val_off,
 			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
 {
@@ -780,8 +798,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tra=
mp_image *im,
 {
 	int i, ret, offset;
 	int *branches_off =3D NULL;
-	int stack_size =3D 0, nregs =3D m->nr_args;
-	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
+	int stack_size =3D 0, nr_arg_slots =3D 0;
+	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, stk_a=
rg_off;
 	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -827,20 +845,21 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im,
 	 * FP - sreg_off    [ callee saved reg	]
 	 *
 	 *		    [ pads              ] pads for 16 bytes alignment
+	 *
+	 *		    [ stack_argN        ]
+	 *		    [ ...               ]
+	 * FP - stk_arg_off [ stack_arg1        ] BPF_TRAMP_F_CALL_ORIG
 	 */
=20
 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
 		return -ENOTSUPP;
=20
-	/* extra regiters for struct arguments */
-	for (i =3D 0; i < m->nr_args; i++)
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			nregs +=3D round_up(m->arg_size[i], 8) / 8 - 1;
-
-	/* 8 arguments passed by registers */
-	if (nregs > 8)
+	if (m->nr_args > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
=20
+	for (i =3D 0; i < m->nr_args; i++)
+		nr_arg_slots +=3D round_up(m->arg_size[i], 8) / 8;
+
 	/* room of trampoline frame to store return address and frame pointer */
 	stack_size +=3D 16;
=20
@@ -850,7 +869,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tra=
mp_image *im,
 		retval_off =3D stack_size;
 	}
=20
-	stack_size +=3D nregs * 8;
+	stack_size +=3D nr_arg_slots * 8;
 	args_off =3D stack_size;
=20
 	stack_size +=3D 8;
@@ -867,8 +886,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tr=
amp_image *im,
 	stack_size +=3D 8;
 	sreg_off =3D stack_size;
=20
+	if (nr_arg_slots - RV_MAX_ARG_REGS > 0)
+		stack_size +=3D (nr_arg_slots - RV_MAX_ARG_REGS) * 8;
+
 	stack_size =3D round_up(stack_size, 16);
=20
+	stk_arg_off =3D stack_size;
+
 	if (!is_struct_ops) {
 		/* For the trampoline called from function entry,
 		 * the frame of traced function and the frame of
@@ -904,10 +928,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im,
 		emit_sd(RV_REG_FP, -ip_off, RV_REG_T1, ctx);
 	}
=20
-	emit_li(RV_REG_T1, nregs, ctx);
+	emit_li(RV_REG_T1, nr_arg_slots, ctx);
 	emit_sd(RV_REG_FP, -nregs_off, RV_REG_T1, ctx);
=20
-	store_args(nregs, args_off, ctx);
+	store_args(nr_arg_slots, args_off, ctx);
=20
 	/* skip to actual body of traced function */
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
@@ -947,7 +971,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tra=
mp_image *im,
 	}
=20
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(nregs, args_off, ctx);
+		restore_args(min_t(int, nr_arg_slots, RV_MAX_ARG_REGS), args_off, ctx);
+		restore_stack_args(nr_arg_slots - RV_MAX_ARG_REGS, args_off, stk_arg_off=
, ctx);
 		ret =3D emit_call((const u64)orig_call, true, ctx);
 		if (ret)
 			goto out;
@@ -982,7 +1007,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tr=
amp_image *im,
 	}
=20
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(nregs, args_off, ctx);
+		restore_args(min_t(int, nr_arg_slots, RV_MAX_ARG_REGS), args_off, ctx);
=20
 	if (save_ret) {
 		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
--=20
2.34.1



