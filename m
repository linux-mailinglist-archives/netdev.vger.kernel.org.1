Return-Path: <netdev+bounces-250110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC9BD24239
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B02D3009D44
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31EC378D91;
	Thu, 15 Jan 2026 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKk57M6V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8836D4F8
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476196; cv=none; b=M0Q+2/1xIZ99aBz3en+Rg7u8mAd3zP+AvZ1iIH5XVoG/ZaqGmJJ3sRJqkMeOMzXld/gaYBVqhvUp8IBHuF+yD4rQdCbsV9/WxsHVqhDGq60sVLgzXuaL92NyWCpJLZth1h+yeAXgS5pac2s9KL+CEuE4NC/ucJ+BA8H2JTYZu1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476196; c=relaxed/simple;
	bh=00w0MOz6qEM52/kfa89FqXu7nJiCVo3MmPq7aLYNJoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qn/dvNQo90IM0yP9T3nyQIw024rZB3a5pdUG05ChwfZCVcSEIzXS3wTXw7x2tt411pcVR/4DE0y2SOD8F9SPmUOQXfvnW8ODqD0QHkZ9v0WPGXMW7r27ntiCHUsi7GFJ1jDFlTUwyh8IC70CD414DEINav1n00PVqRrP71c4/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKk57M6V; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0a33d0585so5466995ad.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476193; x=1769080993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvO0gu/3jAHo9i8JrJZC4gNrHLLl0/wsBx50HymDBuY=;
        b=nKk57M6VOSctCFLiNS9+GdWVUYCPzUZkccKVM7Kzlfg3JxcFDuBTm+OzLrT3uhbnmE
         NXThOX207Zd17ynBs7eWsPZEcZYQi2pQIqhCbZveHV2AADRPszTORR8oJG3n0kzbeSKn
         PngJGZb4Nyed5tUxwnLgTTlvyLPt0pBTqFh9x4jrhnzahWNdjl4yrKOF+OlMdbIN4lsP
         WL6vjQ0goo0/khXSmEjGbKNetjupHxr2ZDYgzz9/Sd/4Ygv5CqKaEGNWQpn10Kzyb9wG
         Dhz3GcAGln6TH5V2BsZPLlNsMQWyd7wsCatspHkmcggGaISM61+DzZgQ3NQj5eZW2A7Z
         Ek9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476193; x=1769080993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QvO0gu/3jAHo9i8JrJZC4gNrHLLl0/wsBx50HymDBuY=;
        b=CykufMvKQWFoPwBELqspKBYOeLK+FnxWjzGuaUvaQyyL/Zh4J+/7Lfuk3XalBU7cVj
         J+i3+3MpRtGsIi3j29Y6ZSxzNmnVFPvOg9rBIMK1nH+Svmuu3NK/NQ5JUoG1G0Tsr+Aw
         p47A6P1GLohMQ1aI1zJuc9eR8s9VS6EVQ7WSsnUW+IILVb9NIXLE8Mz0KD1K1cCN0JdM
         yrp74ZZNP568SSA+OIaRfcWYR9ruJqPyFAAOE2sxACVbyhjzepC8AAp5GQv39N86iVj9
         9zawijpP6GKDuNq4CKr8uUgQnUhlmB2Heq2eIhFHr7Q+bZ//9h55LUTWa1vjxIwMkvtc
         iLhw==
X-Forwarded-Encrypted: i=1; AJvYcCWXrI6MkBTanDNa678I5Y294jiZzJ8WMNQdLIygDsjel6hGMvGUQyzGHdn9T584Kw0zouU2KeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0is0WmlczLxxw+tHSCKGmtlTvIPjMWwUXtQHHtA2/dCCCbua
	gDrPuRJzU/PLKXoSHzXXNj3TUHlS1jcdQl2Vb98ILtxxKL2W1odw7zoS
X-Gm-Gg: AY/fxX65UXxdj3tMmvmuD4E3HNu+dmw5wp6h3uZ/5yzZN9r/zKXHLuB1Hzeg2qLYrO0
	j0oSbud5i1jAh3MjS01OOQDW7wn7qwQpNT7Z1ASSt/vbaLg2n5IRa5L/DA6CPJLjTp70QGU1SRE
	nsnVcKnxG2nqBPJx+ZFlzqEz96ZK8G3KM8tne2bvdaDxAJBuYTR4ECfW2R7IS2Y4eqxHfwzPHmq
	AymU7pa47yt7ox1sHXKKxril+LGcS50z2Nlkp3x0nmOmHChZ04fYmIlbrlz9GIhDCRAm9c3a2U8
	G4+lKPvH29Qx/VbmzTLubVXslM6qsHumc7yN7G9CG2TB68/XPZYhoIpsVKm3cfcerSe0QxR31xg
	F0/vdRVbJKJguC2F7KWHqpJnurcd3AXGPH0d1E1GLwxcTgaHT2+bQCD+2D1Ms6DQBHP6OY7u8Pe
	qwaB+JVBE/aoC827pDvw==
X-Received: by 2002:a17:902:cecb:b0:2a0:9759:66fe with SMTP id d9443c01a7336-2a599e348a7mr57431705ad.32.1768476193146;
        Thu, 15 Jan 2026 03:23:13 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:23:12 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v10 01/12] bpf: add fsession support
Date: Thu, 15 Jan 2026 19:22:35 +0800
Message-ID: <20260115112246.221082-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 364dd84bfc5a..c820ac79efe0 100644
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
index ecc0929ce462..c65e7a70cb78 100644
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
index faa1ecc1fe9d..db935eaddc2d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17450,6 +17450,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		switch (env->prog->expected_attach_type) {
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FSESSION:
 			range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
@@ -23342,6 +23343,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
+			    eatype == BPF_TRACE_FSESSION ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -24286,7 +24288,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog_extension &&
 		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -24301,7 +24304,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			 * beyond reasonable stack size. Hence extending fentry
 			 * is not allowed.
 			 */
-			bpf_log(log, "Cannot extend fentry/fexit\n");
+			bpf_log(log, "Cannot extend fentry/fexit/fsession\n");
 			return -EINVAL;
 		}
 	} else {
@@ -24385,6 +24388,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -24551,6 +24555,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
+		case BPF_TRACE_FSESSION:
 			return true;
 		default:
 			return false;
@@ -24632,9 +24637,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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
index 655efac6f133..3b0d9bd039de 100644
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


