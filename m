Return-Path: <netdev+bounces-79101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AB3877CFD
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 10:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCB4281AAD
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235EB3B1AB;
	Mon, 11 Mar 2024 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZE9HCwZy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE42231C
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149710; cv=none; b=KFTguU50qav73r+V5cIfHorqG5/Zgc0bl/bt8MEmyVr+JA8ibZAw/9ABv0A76bCx1j1diyhGePJ0z3/UmvjCXgADo5ZywnyRW8OAgEq9SrdY4vCW2s6Xxia9gOqvonFNNzHQWKMJw0emmilhohi0JkKUGaPfDmhZ/elgPZ1bJS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149710; c=relaxed/simple;
	bh=rlgHAktRXh8Arz+mICUGBGJaAN9yHmzX0MUr6JUJO9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SjueD177jib9d46dc6Yf4O+vBG1EbE3F8O+zK/yFv32xzJ5V9WWMHMYWgzJIV5Pxz+2BJwB9TSKIg8pPWt36GXGhil/FaGNeaxdPdNzNqTVCrBDQDL21ApApEdRnyRsd5JY19lykqPVwvwHehY8p2eKkrjNUnuBBU3kXyVm0H94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZE9HCwZy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dbd32cff0bso30393255ad.0
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 02:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710149706; x=1710754506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrO/qg8uwgz9YPMWghckYtP0xPd/PM4sF9e4mk1PfXk=;
        b=ZE9HCwZy187GBNAo7g/OJQlPcb4GhJhGQc0rFJPUD2DvjDdE+ImM5bbI6PUvrYGBSr
         74xxLoDX+jpOIBahy6mpRFevTRPdp0bRgxv+E7sUMIo3zkCfLKQ0dhzjlrMj0BDFO69E
         /LSzq+NljuvIdKTfXvuIBZQLq0StFInFpadfnHWDPuDs+pa2//gW0+zf0Jmz3GMbWZpy
         3dBTvokDItedaJNKlzeVt7rpk/gvUs3RKcPvNVD4p0vEswbahWT/JaW83Z61D/4mSwQq
         1ePC74X4Zyn+KzpYPrgLz+sQbsXDvg5sc/4o9AkDCOwIVMNS3S/buhrhRmB9lURF82Bp
         bZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149706; x=1710754506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrO/qg8uwgz9YPMWghckYtP0xPd/PM4sF9e4mk1PfXk=;
        b=kMS6t5UBFnaWj/arpVt8214ItqC8E9+fGYk22E8VXWES3/zEtRGcWDLGq2PcONaC1n
         IbvnOSq0sj+R7+u5LnLvwC1MFZnt28gWBcIf4juBZs5n9e7nCbPi+qDpZ8cv5Sl8ppLh
         VQbLmJ9DcxVgNAizYev1k6PN0AMTrnQCkb883qK27hozrMMBMnUAc9bsRBDRHtRBCqFK
         /Hb18b76JER+BuNpEsK+Mpet2notM+Swip21aLWTjxW+GJMDsBVrKq2L14EXt7O7RpiQ
         K30+iEXGM7XiN4CnXpZnRk5Byubx6I19Tb6ZJP1jotw6HE/goH6441+lhYYdk4melPaB
         fZhA==
X-Forwarded-Encrypted: i=1; AJvYcCWQThxiksUF3okh4ov1AP2J4+Q6Jcc5XG4h3VM/pvDXd8JvhvLDkzeDkW0oY5a5SnXq2FvbqzakBg2gHX55cbWvplrCvMf+
X-Gm-Message-State: AOJu0YxrfXqPr4Gmlro/Xx+RyBf+TVq3Yg8RxMAC8lzT5fXL5Q49f2Lz
	NL7l8fPWM/1V+3kUS++Gyd9yOLt3nK0Bb5y2NQCeQXfU+NGyaoWaF+/EJzlSJP0=
X-Google-Smtp-Source: AGHT+IGdSAmTRkYfDKtyWphJJzXlBtH2IoijdRXhZZCIJP7eVn99sHsdiqYvOsYl4WPd5euBmexj4g==
X-Received: by 2002:a17:902:bcc6:b0:1dc:f803:85b3 with SMTP id o6-20020a170902bcc600b001dcf80385b3mr4689221pls.43.1710149706575;
        Mon, 11 Mar 2024 02:35:06 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001dcad9cbf8bsm4253365plw.239.2024.03.11.02.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:35:06 -0700 (PDT)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	quentin@isovalent.com,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Menglong Dong <dongmenglong.8@bytedance.com>
Subject: [PATCH bpf-next v2 5/9] bpf: verifier: add btf to the function args of bpf_check_attach_target
Date: Mon, 11 Mar 2024 17:35:22 +0800
Message-Id: <20240311093526.1010158-6-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add target btf to the function args of bpf_check_attach_target(), then
the caller can specify the btf to check.

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/syscall.c         | 6 ++++--
 kernel/bpf/trampoline.c      | 1 +
 kernel/bpf/verifier.c        | 8 +++++---
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4b0f6600e499..6cb20efcfac3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -811,6 +811,7 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
+			    struct btf *btf,
 			    u32 btf_id,
 			    struct bpf_attach_target_info *tgt_info);
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d1cd645ef9ac..6128c3131141 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3401,9 +3401,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 * need a new trampoline and a check for compatibility
 		 */
 		struct bpf_attach_target_info tgt_info = {};
+		struct btf *btf;
 
-		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
-					      &tgt_info);
+		btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
+		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf,
+					      btf_id, &tgt_info);
 		if (err)
 			goto out_unlock;
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 2167aa3fe583..b00d53af8fcb 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -747,6 +747,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	int err;
 
 	err = bpf_check_attach_target(NULL, prog, NULL,
+				      prog->aux->attach_btf,
 				      prog->aux->attach_btf_id,
 				      &tgt_info);
 	if (err)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bf084c693507..4493ecc23597 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20613,6 +20613,7 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
+			    struct btf *btf,
 			    u32 btf_id,
 			    struct bpf_attach_target_info *tgt_info)
 {
@@ -20623,7 +20624,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	const struct btf_type *t;
 	bool conservative = true;
 	const char *tname;
-	struct btf *btf;
 	long addr = 0;
 	struct module *mod = NULL;
 
@@ -20631,7 +20631,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		bpf_log(log, "Tracing programs must provide btf_id\n");
 		return -EINVAL;
 	}
-	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
 	if (!btf) {
 		bpf_log(log,
 			"FENTRY/FEXIT program can only be attached to another program annotated with BTF\n");
@@ -20940,6 +20939,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	struct bpf_attach_target_info tgt_info = {};
 	u32 btf_id = prog->aux->attach_btf_id;
 	struct bpf_trampoline *tr;
+	struct btf *btf;
 	int ret;
 	u64 key;
 
@@ -20964,7 +20964,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	    prog->type != BPF_PROG_TYPE_EXT)
 		return 0;
 
-	ret = bpf_check_attach_target(&env->log, prog, tgt_prog, btf_id, &tgt_info);
+	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
+	ret = bpf_check_attach_target(&env->log, prog, tgt_prog, btf,
+				      btf_id, &tgt_info);
 	if (ret)
 		return ret;
 
-- 
2.39.2


