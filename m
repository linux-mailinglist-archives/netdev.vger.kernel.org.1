Return-Path: <netdev+bounces-83656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5403893451
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 19:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8527F2861CF
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF2B15B567;
	Sun, 31 Mar 2024 16:42:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092215A4B6;
	Sun, 31 Mar 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903342; cv=fail; b=G5eOiYVywV1YlKTwarCz8MG8Px3Zfv9jCGDo6h8y+ILDH/xuFybcl/IpDr2DYxgg55ghEico0YAv1wzLNJgT3LWeymoODhkLSp7KSuM6H20fUNglkwGrXFwYZfzPQ+FoNIbi4d/VKWnoQxTpfP1mgUkGPqhoU679fOnw+fGovwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903342; c=relaxed/simple;
	bh=PQc/GZlJdy2wQCpG3P25fWw8d/nM2cnDg0EbtlbI6dc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjnUlQLPHyHKNg18vw3ebV0wpc87qerunyQlDJ2iliqdYuFiixM4X5HpnTHUGUht2Q3Ywv/MdwMLMW5uU9DhnoGgKQOZyMK6QDbzcibro9T57BVvb0XSWoLVXqw+l6+3PwEp494QqRfpgUxz9TSoiaHmFhrSJ+y+m1JKJdh858U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=fail smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=huaweicloud.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 810F7208C8;
	Sun, 31 Mar 2024 18:41:30 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UhGMyAIsQ6TG; Sun, 31 Mar 2024 18:41:29 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id AB63E208B2;
	Sun, 31 Mar 2024 18:41:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com AB63E208B2
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 9E1CE80005E;
	Sun, 31 Mar 2024 18:41:29 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:41:29 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:13 +0000
X-sender: <netdev+bounces-83573-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-essen-01.secunet.de
X-ExtendedProps: BQBjAAoA3nYFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.197
X-EndOfInjectedXHeaders: 13282
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83573-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 4F748202D2
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711876970; cv=none; b=pqv0fOh1BRUwnqb31m/vKdSpalyuojaeQUUQUdp6s1Dj4SzY+JgF53xpy0r1anznOxmJFxAbLeE0ew/dBkD+dB2zE+Mn0KakNY8wNsCWX24pUOJ+HsbEtqZyp46LaeFnLWIKkhDB0Ocv8sGaFvosjJ4zSImuCz3k0dwc9uRGP5o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711876970; c=relaxed/simple;
	bh=PQc/GZlJdy2wQCpG3P25fWw8d/nM2cnDg0EbtlbI6dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RlDzTyVB0FWIJ758WIsM18DrQRZ56G3nWzbs6izsegxDnqtZnP3zpsO0YKz4jNPXYeu9Lf5FJxJqMUPQUi9FlVyBBuppgwqKcO1cRoXlYGLAFdIWE27d1meKBKM5qc6r66l9//qY3ZfQPpRb2GO4qC00qc+fIBedC4Xt1iRjI6o=
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add testcase where 7th argment is struct
Date: Sun, 31 Mar 2024 09:24:05 +0000
Message-ID: <20240331092405.822571-3-pulehui@huaweicloud.com>
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH2WtkKwlmesQWIw--.11467S4
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWDWr1UCF4rZFy7XF4DCFg_yoW7Wr4xpa
	48Xw1jyFWrJr48Wry7GF4UZr4S9rZ3Xr1UJF47J3s0vry0q34DtF18KF1jy3Z5G3y5ur1a
	ya98KrZxCa17JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFrcTDUUU
	U
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Pu Lehui <pulehui@huawei.com>

Add testcase where 7th argument is struct for architectures with 8
argument registers, and increase the complexity of the struct.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 19 ++++++++++
 .../selftests/bpf/prog_tests/tracing_struct.c | 13 +++++++
 .../selftests/bpf/progs/tracing_struct.c      | 35 +++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 39ad96a18123..4973d9de10af 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -41,6 +41,13 @@ struct bpf_testmod_struct_arg_4 {
 	int b;
 };
 
+struct bpf_testmod_struct_arg_5 {
+	char a;
+	short b;
+	int c;
+	long d;
+};
+
 __bpf_hook_start();
 
 noinline int
@@ -98,6 +105,15 @@ bpf_testmod_test_struct_arg_8(u64 a, void *b, short c, int d, void *e,
 	return bpf_testmod_test_struct_arg_result;
 }
 
+noinline int
+bpf_testmod_test_struct_arg_9(u64 a, void *b, short c, int d, void *e, char f,
+			      short g, struct bpf_testmod_struct_arg_5 h, long i)
+{
+	bpf_testmod_test_struct_arg_result = a + (long)b + c + d + (long)e +
+		f + g + h.a + h.b + h.c + h.d + i;
+	return bpf_testmod_test_struct_arg_result;
+}
+
 noinline int
 bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmod_struct_arg_1 *a) {
 	bpf_testmod_test_struct_arg_result = a->a;
@@ -254,6 +270,7 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	struct bpf_testmod_struct_arg_2 struct_arg2 = {2, 3};
 	struct bpf_testmod_struct_arg_3 *struct_arg3;
 	struct bpf_testmod_struct_arg_4 struct_arg4 = {21, 22};
+	struct bpf_testmod_struct_arg_5 struct_arg5 = {23, 24, 25, 26};
 	int i = 1;
 
 	while (bpf_testmod_return_ptr(i))
@@ -268,6 +285,8 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 					    (void *)20, struct_arg4);
 	(void)bpf_testmod_test_struct_arg_8(16, (void *)17, 18, 19,
 					    (void *)20, struct_arg4, 23);
+	(void)bpf_testmod_test_struct_arg_9(16, (void *)17, 18, 19, (void *)20,
+					    21, 22, struct_arg5, 27);
 
 	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
index fe0fb0c9849a..5a8eeb07a6ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -74,6 +74,19 @@ static void test_fentry(void)
 	ASSERT_EQ(skel->bss->t8_g, 23, "t8:g");
 	ASSERT_EQ(skel->bss->t8_ret, 156, "t8 ret");
 
+	ASSERT_EQ(skel->bss->t9_a, 16, "t9:a");
+	ASSERT_EQ(skel->bss->t9_b, 17, "t9:b");
+	ASSERT_EQ(skel->bss->t9_c, 18, "t9:c");
+	ASSERT_EQ(skel->bss->t9_d, 19, "t9:d");
+	ASSERT_EQ(skel->bss->t9_e, 20, "t9:e");
+	ASSERT_EQ(skel->bss->t9_f, 21, "t9:f");
+	ASSERT_EQ(skel->bss->t9_g, 22, "t9:f");
+	ASSERT_EQ(skel->bss->t9_h_a, 23, "t9:h.a");
+	ASSERT_EQ(skel->bss->t9_h_b, 24, "t9:h.b");
+	ASSERT_EQ(skel->bss->t9_h_c, 25, "t9:h.c");
+	ASSERT_EQ(skel->bss->t9_h_d, 26, "t9:h.d");
+	ASSERT_EQ(skel->bss->t9_i, 27, "t9:i");
+	ASSERT_EQ(skel->bss->t9_ret, 258, "t9 ret");
 	tracing_struct__detach(skel);
 destroy_skel:
 	tracing_struct__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct.c b/tools/testing/selftests/bpf/progs/tracing_struct.c
index 515daef3c84b..bfe96bab94c0 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct.c
@@ -23,6 +23,13 @@ struct bpf_testmod_struct_arg_4 {
 	int b;
 };
 
+struct bpf_testmod_struct_arg_5 {
+	char a;
+	short b;
+	int c;
+	long d;
+};
+
 long t1_a_a, t1_a_b, t1_b, t1_c, t1_ret, t1_nregs;
 __u64 t1_reg0, t1_reg1, t1_reg2, t1_reg3;
 long t2_a, t2_b_a, t2_b_b, t2_c, t2_ret;
@@ -32,6 +39,7 @@ long t5_ret;
 int t6;
 long t7_a, t7_b, t7_c, t7_d, t7_e, t7_f_a, t7_f_b, t7_ret;
 long t8_a, t8_b, t8_c, t8_d, t8_e, t8_f_a, t8_f_b, t8_g, t8_ret;
+long t9_a, t9_b, t9_c, t9_d, t9_e, t9_f, t9_g, t9_h_a, t9_h_b, t9_h_c, t9_h_d, t9_i, t9_ret;
 
 
 SEC("fentry/bpf_testmod_test_struct_arg_1")
@@ -184,4 +192,31 @@ int BPF_PROG2(test_struct_arg_15, __u64, a, void *, b, short, c, int, d,
 	return 0;
 }
 
+SEC("fentry/bpf_testmod_test_struct_arg_9")
+int BPF_PROG2(test_struct_arg_16, __u64, a, void *, b, short, c, int, d, void *, e,
+	      char, f, short, g, struct bpf_testmod_struct_arg_5, h, long, i)
+{
+	t9_a = a;
+	t9_b = (long)b;
+	t9_c = c;
+	t9_d = d;
+	t9_e = (long)e;
+	t9_f = f;
+	t9_g = g;
+	t9_h_a = h.a;
+	t9_h_b = h.b;
+	t9_h_c = h.c;
+	t9_h_d = h.d;
+	t9_i = i;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_struct_arg_9")
+int BPF_PROG2(test_struct_arg_17, __u64, a, void *, b, short, c, int, d, void *, e,
+	      char, f, short, g, struct bpf_testmod_struct_arg_5, h, long, i, int, ret)
+{
+	t9_ret = ret;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1



