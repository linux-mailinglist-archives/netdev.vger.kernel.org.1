Return-Path: <netdev+bounces-253035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEBNAedkdGnb5AAAu9opvQ
	(envelope-from <netdev+bounces-253035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:21:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 570B27CA79
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C87E2300A8D6
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677BE269B01;
	Sat, 24 Jan 2026 06:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPOGpSqp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C1242D78
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 06:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235633; cv=none; b=PglNyyCUvp1/yw2m85/OcD870osVCJRI2UGi/4HgvMUQTBMwvxQOn1idsvZkDSYY1kB0YZ/GZpvWLSwJws561HnJXC+aVnMwPVhxfy/rwK4jnneaUbl/eog3RbEgUerGMYbCPrC/s6A8PfKiPcN9SLF62tNOAP+rUXBFQuLvlFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235633; c=relaxed/simple;
	bh=wwBM4KNzRljNZStnUWhG7h/qOqs25RK0YzU3W4PEVTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4+0NlET+oxxxhT/8efDYhJZp68JXJqKKXW+GEJ7QGDJZknVxKlUOhxZ24ZdwhbBuXEccvKdPx34+8KelrrrI/9AOj8xii+WDxS+uNk3ISFFvwZS+EEvbOWHvbf2iIktumnHCeVu9bFYpieg6w7q7cr+q9T9g63Qp5PFf44cXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPOGpSqp; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-350fe1f8ea3so1435330a91.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 22:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235631; x=1769840431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaONV4URFGPh7x7Ej+eVXTWdZoGaQBVfVQGzpGIPLXA=;
        b=LPOGpSqpo7911czCctV7dSiClXyrkrlVuCUp140h1SWlRRkJVQxM213niQppQwffxp
         ajRXfO+Np1kF7tIhozjjYm0QN61TRS1Zi3nGYoEzHIwIoui9mdueBw/G9KkBiK1uqEK9
         UoE9qWTuCNpr5Je6ywfU3YBLptmSE1lIx7KFUdFDEnesGqIaDtz/JYLMKC/FRxUftsM6
         x19Th3ob1+B6qwJT0SI2j7FG5sRjuRmdPe1jj/ajZHUSRr9SzDYnKKu+hjiUPvYw26Uh
         YkD515KCnWjfxKwzb/MyO4Kn92jXQvrqUUiWhXZGzlXPfMADx44zUwvC6qwlWmEzxLiW
         mQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235631; x=1769840431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AaONV4URFGPh7x7Ej+eVXTWdZoGaQBVfVQGzpGIPLXA=;
        b=r3EXjMpdf35mOufiTdTu5KqWbjrbuNCQ+TC36JVfdccnVdz3bRSeCR4jxcqINAtQRq
         lKLzTfmVqBrZEmK6TvStTQmQP5XatXKx74m341JjZIn4wMQMv+84AyvXJkiswmELHNXt
         SzLx8JQQ/9BDxl1vqZD6g3SP9r1BmH7A6rP5lKYez4CIHZU0ggkCbo29C7Gud4uqyR/e
         38PkvQV7MMGvpRkLFyA1fd+u+wHIJ/LmMmvjTyfsFVLpUjS9ne5TlULhdT0lINY0Md/a
         vzRVKcOaw2Uzn+eJSGqX6AsJK8ysIU0uHuRc9jOaA5KBs+Vk+uG0k8mil9IuxywBdWST
         arGw==
X-Forwarded-Encrypted: i=1; AJvYcCXImTfOdSYdwRKh5hoVA8s0wewjR87taSqNZj2yW+3HT516LyOmnnf7Oa0xrho+ytfDXfVQO1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPHU5Z7UkcNDKQpC0/Q3DaTNjew7t0HcPy+XaPOHgvICBKMHaB
	AQwWS/ybc52fykyMFkzuGLxzo/E5Pc4cs/ksUofjj1RddityAXpSsvE3
X-Gm-Gg: AZuq6aJez8Vk5cnUOZyRr0WcPKGUL8i0uJ+OxQueDqSDFpETPfqJbfdQy0Xik77rKjg
	lHdlVAM8w8NFQXasvNFV18CgX1+EkR2eo+NDlsA5zmjJhMPVgv6throgIYG52QDAh0Xb4x2xXzU
	9zqGyKifXNCVQwJpdASc4epHUj5ubxghCpDV4Ig4S0T9I9Y6/0fQgMetIVr0n/nPomTjenRFgpu
	KJl5xzl7h1jR0fZLj39hMFVpST7eFOIPmVtX6e3RJvAqrCRp8NW6u/G163x5VCubLSx1zj7CdPV
	l2NahA+iUL83cvKTyQUcnieqr7dnq8SuW4p2YugA3bWkF/yPhiZ2j4Mfv//2yTWpEl6fZjoNvhd
	s8W+IC7nA+j6TcZJPrurWaAP+t+JVvL95IRbIEMtQuZ13rhvDC2guCgR6VzPLGN+qQwHVdoRQfC
	rTQAqqI0fb
X-Received: by 2002:a17:90b:1f88:b0:353:5c16:aa7 with SMTP id 98e67ed59e1d1-3536894f763mr4442765a91.25.1769235631049;
        Fri, 23 Jan 2026 22:20:31 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:20:30 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v13 01/13] bpf: add fsession support
Date: Sat, 24 Jan 2026 14:19:56 +0800
Message-ID: <20260124062008.8657-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	URIBL_RED(0.50)[chinatelecom.cn:mid,chinatelecom.cn:email];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253035-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.977];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,chinatelecom.cn:email,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 570B27CA79
X-Rspamd-Action: no action

The fsession is something that similar to kprobe session. It allow to
attach a single BPF program to both the entry and the exit of the target
functions.

Introduce the struct bpf_fsession_link, which allows to add the link to
both the fentry and fexit progs_hlist of the trampoline.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v10:
- use switch in bpf_prog_has_trampoline()
- some nits adjustment

v5:
- unify the name to "fsession"
- use more explicit way in __bpf_trampoline_link_prog()

v4:
- instead of adding a new hlist to progs_hlist in trampoline, add the bpf
  program to both the fentry hlist and the fexit hlist.
---
 include/linux/bpf.h                           | 19 +++++++
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/btf.c                              |  2 +
 kernel/bpf/syscall.c                          | 18 ++++++-
 kernel/bpf/trampoline.c                       | 53 ++++++++++++++++---
 kernel/bpf/verifier.c                         | 12 +++--
 net/bpf/test_run.c                            |  1 +
 net/core/bpf_sk_storage.c                     |  1 +
 tools/include/uapi/linux/bpf.h                |  1 +
 .../bpf/prog_tests/tracing_failure.c          |  2 +-
 10 files changed, 97 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5936f8e2996f..41228b0add52 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1309,6 +1309,7 @@ enum bpf_tramp_prog_type {
 	BPF_TRAMP_MODIFY_RETURN,
 	BPF_TRAMP_MAX,
 	BPF_TRAMP_REPLACE, /* more than MAX */
+	BPF_TRAMP_FSESSION,
 };
 
 struct bpf_tramp_image {
@@ -1875,6 +1876,11 @@ struct bpf_tracing_link {
 	struct bpf_prog *tgt_prog;
 };
 
+struct bpf_fsession_link {
+	struct bpf_tracing_link link;
+	struct bpf_tramp_link fexit;
+};
+
 struct bpf_raw_tp_link {
 	struct bpf_link link;
 	struct bpf_raw_event_map *btp;
@@ -2169,6 +2175,19 @@ static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_op
 
 #endif
 
+static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
+{
+	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
+	int cnt = 0;
+
+	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
+		if (fentries.links[i]->link.prog->expected_attach_type == BPF_TRACE_FSESSION)
+			cnt++;
+	}
+
+	return cnt;
+}
+
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 			       const struct bpf_ctx_arg_aux *info, u32 cnt);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2a2ade4be60f..44e7dbc278e3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1145,6 +1145,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_FSESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d10b3404260f..8959f3bc1e92 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6219,6 +6219,7 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_FSESSION:
 			/* allow u64* as ctx */
 			if (btf_is_int(t) && t->size == 8)
 				return 0;
@@ -6820,6 +6821,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			fallthrough;
 		case BPF_LSM_CGROUP:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FSESSION:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
 			 * int LSM hooks, they use MODIFY_RETURN trampolines.
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3c5c03d43f5f..b9184545c3fd 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3577,6 +3577,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	case BPF_PROG_TYPE_TRACING:
 		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
 		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+		    prog->expected_attach_type != BPF_TRACE_FSESSION &&
 		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
 			err = -EINVAL;
 			goto out_put_prog;
@@ -3626,7 +3627,21 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
 	}
 
-	link = kzalloc(sizeof(*link), GFP_USER);
+	if (prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		struct bpf_fsession_link *fslink;
+
+		fslink = kzalloc(sizeof(*fslink), GFP_USER);
+		if (fslink) {
+			bpf_link_init(&fslink->fexit.link, BPF_LINK_TYPE_TRACING,
+				      &bpf_tracing_link_lops, prog, attach_type);
+			fslink->fexit.cookie = bpf_cookie;
+			link = &fslink->link;
+		} else {
+			link = NULL;
+		}
+	} else {
+		link = kzalloc(sizeof(*link), GFP_USER);
+	}
 	if (!link) {
 		err = -ENOMEM;
 		goto out_put_prog;
@@ -4350,6 +4365,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 	case BPF_MODIFY_RETURN:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 2a125d063e62..edf9da43762d 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -109,10 +109,17 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 	enum bpf_attach_type eatype = prog->expected_attach_type;
 	enum bpf_prog_type ptype = prog->type;
 
-	return (ptype == BPF_PROG_TYPE_TRACING &&
-		(eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
-		 eatype == BPF_MODIFY_RETURN)) ||
-		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
+	switch (ptype) {
+	case BPF_PROG_TYPE_TRACING:
+		if (eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
+		    eatype == BPF_MODIFY_RETURN || eatype == BPF_TRACE_FSESSION)
+			return true;
+		return false;
+	case BPF_PROG_TYPE_LSM:
+		return eatype == BPF_LSM_MAC;
+	default:
+		return false;
+	}
 }
 
 void bpf_image_ksym_init(void *data, unsigned int size, struct bpf_ksym *ksym)
@@ -559,6 +566,8 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
 		return BPF_TRAMP_FEXIT;
+	case BPF_TRACE_FSESSION:
+		return BPF_TRAMP_FSESSION;
 	case BPF_LSM_MAC:
 		if (!prog->aux->attach_func_proto->type)
 			/* The function returns void, we cannot modify its
@@ -594,8 +603,10 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 				      struct bpf_trampoline *tr,
 				      struct bpf_prog *tgt_prog)
 {
+	struct bpf_fsession_link *fslink = NULL;
 	enum bpf_tramp_prog_type kind;
 	struct bpf_tramp_link *link_exiting;
+	struct hlist_head *prog_list;
 	int err = 0;
 	int cnt = 0, i;
 
@@ -621,24 +632,43 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 					  BPF_MOD_JUMP, NULL,
 					  link->link.prog->bpf_func);
 	}
+	if (kind == BPF_TRAMP_FSESSION) {
+		prog_list = &tr->progs_hlist[BPF_TRAMP_FENTRY];
+		cnt++;
+	} else {
+		prog_list = &tr->progs_hlist[kind];
+	}
 	if (cnt >= BPF_MAX_TRAMP_LINKS)
 		return -E2BIG;
 	if (!hlist_unhashed(&link->tramp_hlist))
 		/* prog already linked */
 		return -EBUSY;
-	hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind], tramp_hlist) {
+	hlist_for_each_entry(link_exiting, prog_list, tramp_hlist) {
 		if (link_exiting->link.prog != link->link.prog)
 			continue;
 		/* prog already linked */
 		return -EBUSY;
 	}
 
-	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
-	tr->progs_cnt[kind]++;
+	hlist_add_head(&link->tramp_hlist, prog_list);
+	if (kind == BPF_TRAMP_FSESSION) {
+		tr->progs_cnt[BPF_TRAMP_FENTRY]++;
+		fslink = container_of(link, struct bpf_fsession_link, link.link);
+		hlist_add_head(&fslink->fexit.tramp_hlist, &tr->progs_hlist[BPF_TRAMP_FEXIT]);
+		tr->progs_cnt[BPF_TRAMP_FEXIT]++;
+	} else {
+		tr->progs_cnt[kind]++;
+	}
 	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 	if (err) {
 		hlist_del_init(&link->tramp_hlist);
-		tr->progs_cnt[kind]--;
+		if (kind == BPF_TRAMP_FSESSION) {
+			tr->progs_cnt[BPF_TRAMP_FENTRY]--;
+			hlist_del_init(&fslink->fexit.tramp_hlist);
+			tr->progs_cnt[BPF_TRAMP_FEXIT]--;
+		} else {
+			tr->progs_cnt[kind]--;
+		}
 	}
 	return err;
 }
@@ -672,6 +702,13 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 		guard(mutex)(&tgt_prog->aux->ext_mutex);
 		tgt_prog->aux->is_extended = false;
 		return err;
+	} else if (kind == BPF_TRAMP_FSESSION) {
+		struct bpf_fsession_link *fslink =
+			container_of(link, struct bpf_fsession_link, link.link);
+
+		hlist_del_init(&fslink->fexit.tramp_hlist);
+		tr->progs_cnt[BPF_TRAMP_FEXIT]--;
+		kind = BPF_TRAMP_FENTRY;
 	}
 	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c7f5234d5fd2..41bbed6418b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17848,6 +17848,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		switch (env->prog->expected_attach_type) {
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FSESSION:
 			range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
@@ -23774,6 +23775,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
+			    eatype == BPF_TRACE_FSESSION ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -24725,7 +24727,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog_extension &&
 		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -24740,7 +24743,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			 * beyond reasonable stack size. Hence extending fentry
 			 * is not allowed.
 			 */
-			bpf_log(log, "Cannot extend fentry/fexit\n");
+			bpf_log(log, "Cannot extend fentry/fexit/fsession\n");
 			return -EINVAL;
 		}
 	} else {
@@ -24824,6 +24827,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -24990,6 +24994,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
+		case BPF_TRACE_FSESSION:
 			return true;
 		default:
 			return false;
@@ -25071,9 +25076,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 			tgt_info.tgt_name);
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		   prog->expected_attach_type == BPF_TRACE_FSESSION ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
-		verbose(env, "Attaching fexit/fmod_ret to __noreturn function '%s' is rejected.\n",
+		verbose(env, "Attaching fexit/fsession/fmod_ret to __noreturn function '%s' is rejected.\n",
 			tgt_info.tgt_name);
 		return -EINVAL;
 	}
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 26cfcfdc45eb..178c4738e63b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -685,6 +685,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 		if (bpf_fentry_test1(1) != 2 ||
 		    bpf_fentry_test2(2, 3) != 5 ||
 		    bpf_fentry_test3(4, 5, 6) != 15 ||
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 850dd736ccd1..de111818f3a0 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -365,6 +365,7 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 		return true;
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 		return !!strncmp(prog->aux->attach_func_name, "bpf_sk_storage",
 				 strlen("bpf_sk_storage"));
 	default:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b816bc53d2e1..3ca7d76e05f0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1145,6 +1145,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_FSESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
index 10e231965589..f9f9e1cb87bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -73,7 +73,7 @@ static void test_tracing_deny(void)
 static void test_fexit_noreturns(void)
 {
 	test_tracing_fail_prog("fexit_noreturns",
-			       "Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.");
+			       "Attaching fexit/fsession/fmod_ret to __noreturn function 'do_exit' is rejected.");
 }
 
 void test_tracing_failure(void)
-- 
2.52.0


