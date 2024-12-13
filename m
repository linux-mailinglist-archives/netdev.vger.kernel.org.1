Return-Path: <netdev+bounces-151918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D889F1A00
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 00:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3682F7A047E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 23:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542011F3D42;
	Fri, 13 Dec 2024 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FHk21L4C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F131E25FE
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132611; cv=none; b=lyF7EWdqxRxrHqw6wvhfqUUcS1bGdCJvWljlkmv8P37AVFJwHf1xt4VRH7xonVvcbSdupPEjqtS3rDIJMXL2kpVtY/VEFXlqAY3clTC6zD44eVuaYmQA9I+gDZ/C/1UwJTSrVSJFL50/EWoZqRpa99+z9XyxdGFh9LVVQBoVea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132611; c=relaxed/simple;
	bh=YKCb30RDsE4+Fn8NS6P9LGffDPMtCrO9o2BAMrFfjR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J7SABAZSBiRTzHunAdHguNI2QTvoa345Wx9SHeCTzI55HhAyPT5Irkt9waACNaq7+dg3SWuu5WWWDNgLK9PH0ss9hNZx1HAJKhu3vfCebmhq9ta7rAHhbH7ULPi7m4sraKXZ126MciI3OemgSA2l0/RmiebSkuFERqdOaOrc+kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FHk21L4C; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6e24aa0dbso174716685a.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132607; x=1734737407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWEnUr44gSryBgOiEp4wVFPMwX6gdjGF4VTepdjaT5k=;
        b=FHk21L4CrMDB19lpEfW1QAhIPATOV7Pz3rilQsN0Tcxj+TEeb/ptbFDTZlSp1rgkse
         SMFNoJfocVVhF8KR5SaLM0aSWih6RNs86risSX6mU4l65mpNcEAXkjoKOQnOqiQ4cqNP
         fPO+lbdY0pZ4lhYdsdNUIPqyEmxxCpYQO3xiRxgGrcLZLf8Hve5SvVY48vD7IZTq2/gv
         sdvEJZdaXs5WsEmOt/BymBdaeC75UlkMwakBozUOrQOpOuMGX0u0uhfOZdlo6K3tbejv
         kusx8YwxF6JS3Eqm96sZ1qgcS/eQFdlb/INSxdUe5FYydmhv3ksa0d/G5O1gt4kHk5Z8
         D7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132607; x=1734737407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWEnUr44gSryBgOiEp4wVFPMwX6gdjGF4VTepdjaT5k=;
        b=kzvTDzExRG72H4kkcG9YHkqSdaWMAXAjDny4oHqzDD5RUsq7xRA89qpr66CW+/syYQ
         gk7EYzlpomgYhb6FbVVslDxYHL5H5SCfxIbJlDq025dNoxZ+DiUAb2tD6GhSa4WUiUbn
         Vi5RwgGXuoQdj4xXdBGa2leD7LOBg3I1HDr0WqWHDKmR5wmWDCMeemeMz0OQZx9EUYBL
         KUoOioUcFAAJg6lWcIIUl9bX9BCa9h603psBc6JeRRcgkn0zA8KjRwNzCOJfuRLZji63
         xnfZW9hhgVQa4nghARkhiCLwTY2Y4F2J5My/40muBwe6G86RKlzbteM4liBp3Ad4b0pE
         8Yxg==
X-Gm-Message-State: AOJu0Yxx5REt9Xq7k75Y3EWs+rRNzWryMwHoSSBYuUaoSBTS88YKwYXg
	b1gdktEq/TNzPXIr5OIyGq3wxlFZQUgl17CM7xihDvdSM5dcv5pex0tDykcETOg/0xBbsgEQV5K
	WmMOpAA==
X-Gm-Gg: ASbGncvMd4S4OflVZhgtwodVA0EJQpgJKkVFrkqkbeYqzO5YkiNTxH3mOFE1mJzncgf
	O0MYFbJDdJ6RWtQpNC6m7ZOWmiAAzUj97VvC4e2bvdMcTz3xSj3Rgmi2uNRWWttTcmC4Jf4qdZV
	unuGpKKIaEbXeOfnRVKNKhvovhSjpvVG0KHf9/MB1i9o9tSA28Dxxs/AvORM56qcTVdx6oZQ7qA
	Xf5FocHZ9qJ2p/6qFG55r49IsfQGiWFOtCiX31PnxAjHm6Ha5yzTOLzdkMWiNCH2gK82rjhiORv
X-Google-Smtp-Source: AGHT+IEyRb6FE8d7V1uY6ACdJfdv+7fIlx8XcwfjROlargKGqIuaz7lKkL5OgtyP5OkF2N6nxKLFbA==
X-Received: by 2002:a05:620a:19a0:b0:7b6:ece3:827f with SMTP id af79cd13be357-7b6fbeca4a1mr726463285a.2.1734132607669;
        Fri, 13 Dec 2024 15:30:07 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:07 -0800 (PST)
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
Subject: [PATCH bpf-next v1 06/13] bpf: net_sched: Add basic bpf qdisc kfuncs
Date: Fri, 13 Dec 2024 23:29:51 +0000
Message-Id: <20241213232958.2388301-7-amery.hung@bytedance.com>
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

Add basic kfuncs for working on skb in qdisc.

Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to release
a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
in .enqueue where a to_free skb list is available from kernel to defer
the release. bpf_kfree_skb() should be used elsewhere. It is also used
in bpf_obj_free_fields() when cleaning up skb in maps and collections.

bpf_skb_get_hash() returns the flow hash of an skb, which can be used
to build flow-based queueing algorithms.

Finally, allow users to create read-only dynptr via bpf_dynptr_from_skb().

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 77 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index a2e2db29e5fc..28959424eab0 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -106,6 +106,67 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
+__bpf_kfunc_start_defs();
+
+/* bpf_skb_get_hash - Get the flow hash of an skb.
+ * @skb: The skb to get the flow hash from.
+ */
+__bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *skb)
+{
+	return skb_get_hash(skb);
+}
+
+/* bpf_kfree_skb - Release an skb's reference and drop it immediately.
+ * @skb: The skb whose reference to be released and dropped.
+ */
+__bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
+{
+	kfree_skb(skb);
+}
+
+/* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free list.
+ * @skb: The skb whose reference to be released and dropped.
+ * @to_free_list: The list of skbs to be dropped.
+ */
+__bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
+				    struct bpf_sk_buff_ptr *to_free_list)
+{
+	__qdisc_drop(skb, (struct sk_buff **)to_free_list);
+}
+
+__bpf_kfunc_end_defs();
+
+#define BPF_QDISC_KFUNC_xxx \
+	BPF_QDISC_KFUNC(bpf_skb_get_hash, KF_TRUSTED_ARGS) \
+	BPF_QDISC_KFUNC(bpf_kfree_skb, KF_RELEASE) \
+	BPF_QDISC_KFUNC(bpf_qdisc_skb_drop, KF_RELEASE) \
+
+BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
+#define BPF_QDISC_KFUNC(name, flag) BTF_ID_FLAGS(func, name, flag)
+BPF_QDISC_KFUNC_xxx
+#undef BPF_QDISC_KFUNC
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_qdisc_kfunc_ids)
+
+#define BPF_QDISC_KFUNC(name, _) BTF_ID_LIST_SINGLE(name##_ids, func, name)
+BPF_QDISC_KFUNC_xxx
+#undef BPF_QDISC_KFUNC
+
+static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (kfunc_id == bpf_qdisc_skb_drop_ids[0])
+		if (strcmp(prog->aux->attach_func_name, "enqueue"))
+			return -EACCES;
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_qdisc_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_qdisc_kfunc_ids,
+	.filter = bpf_qdisc_kfunc_filter,
+};
+
 static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
 	.get_func_proto		= bpf_qdisc_get_func_proto,
 	.is_valid_access	= bpf_qdisc_is_valid_access,
@@ -209,6 +270,20 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 
 static int __init bpf_qdisc_kfunc_init(void)
 {
-	return register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
+	int ret;
+	const struct btf_id_dtor_kfunc skb_kfunc_dtors[] = {
+		{
+			.btf_id       = bpf_sk_buff_ids[0],
+			.kfunc_btf_id = bpf_kfree_skb_ids[0]
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_qdisc_kfunc_set);
+	ret = ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
+						 ARRAY_SIZE(skb_kfunc_dtors),
+						 THIS_MODULE);
+	ret = ret ?: register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
+
+	return ret;
 }
 late_initcall(bpf_qdisc_kfunc_init);
-- 
2.20.1


