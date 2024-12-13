Return-Path: <netdev+bounces-151921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DDF9F1A0C
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 00:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEB2188DF0E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 23:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A081F472A;
	Fri, 13 Dec 2024 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O90NrWUd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349011F4293
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132615; cv=none; b=aeaQ3gz7zagDzVQe3Wm32MhtalZ/usPFQouUHWutpowVKqOrdTVzgsetg1WS4IkvCP+++uwr7xoJUflANZAmz2M1KvJPKQAgYo4mcN7Knh7NY9ZHyw5SxQ2qTHCHiMDe6qdMCMQL2tuDEFDoQuOlkwt0Sp7pFsKGmAMDL8TIAsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132615; c=relaxed/simple;
	bh=X+t8gDEwNbFCtVM95/5isGpSKd5GAziNVGIkVSSzfPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YjR2f+zX00XgJCKf8jxoYwJIG6fjJzhO0TD9jeQ0mqxgvr4Bk9b57ZcaeTkvsLpxI5QocW2FXWj5++6Jmz1FlqxL/+HchJhDIog3QB3w3onwSpAGF63c2nqsOU4MabkDDHNt2NPIfxuEaRn8yeYBLnLh0Qii+tH9gBDdG0/G3Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O90NrWUd; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b1601e853eso180576685a.2
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132611; x=1734737411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exqCsIoLkuY4OTkf+/hY3xBxRD9kSVmRMozwdnr8pz8=;
        b=O90NrWUd4Bnr8pX5fjseoTNFdwK+KJvnmyvPupOeSzTDY2osw7LwnZb+/MSHO58Idw
         l2meNhiaJ3qBlBG6g2UrF7ZVe3ilKU3j/PM9h6Cp4Miq07WhZW0FsE7yvLcAvBKzgeYU
         Lska9uXft6POELeMJ9agF1go82UslmttA6wbaaPHbUcsIJSDrpA35hi+x+keeeX7ZXiX
         UI2Ld4Ywd9JqD5L7DbOWxFNoarQO7NVW+SCwKVfVTWT1oYPhpRSv3JOYHcbxUfIpLZzL
         DtyT2euuaFXOlTzv9vR3IaHMPTHfEjtOem12q2k7X83TFRk2CKseB1BfJ1kMtPFLGyRt
         uMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132611; x=1734737411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exqCsIoLkuY4OTkf+/hY3xBxRD9kSVmRMozwdnr8pz8=;
        b=ludLqhjh+9SNgRYbuy9PcAt5RtsLvWTVh3jp4ZzpTEiyejA4xFJqayuIBkgYu23+ZW
         Xfpto/aHQGUzQa7HdD7w37EFpIEny4R9OxnEKdRjSJD3TdWnizcu3HXIK/HFvJ55L3JA
         47pUrhZpghVQxf+lVnz47O6Hd1091nxVeKGujGf2UN2g6txvCmXFYSy9ANm29dSJrTNm
         fmgbKXuMTq2X9JdQJl9CEHabW/WDVtb+ZoxZFC+NUU1rWodcTwAcB9j3b6bOTtFDUTzh
         xZQT8dG3ksxXAVBGVHPeEhGBYw9YMWC5X09BhOInVANjas1MSl1zZ8umbYqjpDcXITbH
         FH8w==
X-Gm-Message-State: AOJu0Yy4YnMARG2vtkNCLXcN65lY9oRSuF/7g0RcqDNGT/S+AVRkxNCy
	2P7EcOPQsnv237CjH+Au+LGeOep182dsBrj4QlDZ52IDjYghHd2/4mf11+oRGbKjchWde45CWvn
	j3oY=
X-Gm-Gg: ASbGncsRWEl+YjfF3/2NSgirP4qZ00mcmPW0kQYC283r/7ugBd52y7qXNB/0fE6vZG2
	ffJtoACmSUxFMCuJwAz+hB2aXxheCVmUbLr7Jbu+mGGZfq4sq1GgK29Um89Tilg/vflR/Jo24Nz
	gpIWrIRlI0A5+wiksUqGzRelAmCCUv4LWMmwFZ6CWh/MdxUf1NxIDJRl8Bg/c5kL2TYEIDcZrGr
	CizdVjGOxCWijGdfuAgw0pqTV3HLtrx3AMdLb/KPqC/Hku6pfVMWWidXE3f7VFZJrzSPZH8J4Wm
X-Google-Smtp-Source: AGHT+IHabF5pqAFjUWYISSxmqI352ucWV5AJ52EofqpegSXFLtjrENmjqVDxwaeJ37QzD1+hNQ84fA==
X-Received: by 2002:a05:620a:28cc:b0:7b6:6ffc:e972 with SMTP id af79cd13be357-7b6fbec7990mr742243185a.5.1734132611374;
        Fri, 13 Dec 2024 15:30:11 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:11 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 09/13] bpf: net_sched: Support updating qstats
Date: Fri, 13 Dec 2024 23:29:54 +0000
Message-Id: <20241213232958.2388301-10-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241213232958.2388301-1-amery.hung@bytedance.com>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow bpf qdisc programs to update Qdisc qstats directly with btf struct
access.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 53 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index b5ac3b9923fb..3901f855effc 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -57,6 +57,7 @@ bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
 	}
 }
 
+BTF_ID_LIST_SINGLE(bpf_qdisc_ids, struct, Qdisc)
 BTF_ID_LIST_SINGLE(bpf_sk_buff_ids, struct, sk_buff)
 BTF_ID_LIST_SINGLE(bpf_sk_buff_ptr_ids, struct, bpf_sk_buff_ptr)
 
@@ -81,20 +82,37 @@ static bool bpf_qdisc_is_valid_access(int off, int size,
 	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
 }
 
-static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
-					const struct bpf_reg_state *reg,
-					int off, int size)
+static int bpf_qdisc_qdisc_access(struct bpf_verifier_log *log,
+				  const struct bpf_reg_state *reg,
+				  int off, int size)
 {
-	const struct btf_type *t, *skbt;
 	size_t end;
 
-	skbt = btf_type_by_id(reg->btf, bpf_sk_buff_ids[0]);
-	t = btf_type_by_id(reg->btf, reg->btf_id);
-	if (t != skbt) {
-		bpf_log(log, "only read is supported\n");
+	switch (off) {
+	case offsetof(struct Qdisc, qstats) ... offsetofend(struct Qdisc, qstats) - 1:
+		end = offsetofend(struct Qdisc, qstats);
+		break;
+	default:
+		bpf_log(log, "no write support to Qdisc at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log,
+			"write access at off %d with size %d beyond the member of Qdisc ended at %zu\n",
+			off, size, end);
 		return -EACCES;
 	}
 
+	return 0;
+}
+
+static int bpf_qdisc_sk_buff_access(struct bpf_verifier_log *log,
+				    const struct bpf_reg_state *reg,
+				    int off, int size)
+{
+	size_t end;
+
 	switch (off) {
 	case offsetof(struct sk_buff, tstamp):
 		end = offsetofend(struct sk_buff, tstamp);
@@ -136,6 +154,25 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
+static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
+				       const struct bpf_reg_state *reg,
+				       int off, int size)
+{
+	const struct btf_type *t, *skbt, *qdisct;
+
+	skbt = btf_type_by_id(reg->btf, bpf_sk_buff_ids[0]);
+	qdisct = btf_type_by_id(reg->btf, bpf_qdisc_ids[0]);
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+
+	if (t == skbt)
+		return bpf_qdisc_sk_buff_access(log, reg, off, size);
+	else if (t == qdisct)
+		return bpf_qdisc_qdisc_access(log, reg, off, size);
+
+	bpf_log(log, "only read is supported\n");
+	return -EACCES;
+}
+
 __bpf_kfunc_start_defs();
 
 /* bpf_skb_get_hash - Get the flow hash of an skb.
-- 
2.20.1


