Return-Path: <netdev+bounces-281723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK02Nsxx8GldTgEAu9opvQ
	(envelope-from <netdev+bounces-281723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:37:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7C48044A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 972A93175E66
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1643D75DD;
	Tue, 28 Apr 2026 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mguRKT73"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1523D75C6
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364935; cv=none; b=uOU3Fm84lxYuhdfctEF4+2N+F4rJnmU6DBfsDPc8AiflNhBbY76lUD+i9yuNs8t17Yy+EHdc2j/C5kVuKdwalWQ7VqaXHFY5svKwnGXB9w/vXyV751g+ghm55b/m0nnYzJ38G9GymD12pstuw3UXRyHMOemUkQWpNys+Asqm5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364935; c=relaxed/simple;
	bh=XhJcrSJ5j1XR3kI25yvETY77CY8uis/clrpe5Cu19ns=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z0i2vAjwUDnK0TCemhIWxHajlNTMV9Zs3DX4QELbj1+iUsHOVGLk/NuzO7M73eFrEU2j7oUjkjGu4Ld0XPD1Z2lueByK3TvdW8CXzOS3+X1BAxpA3SMbepZ03dkTyYhRZ19BVs6xqeqD6Ux6MyYNRh764DPr65tvDWmzGRfMvxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mguRKT73; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50d812c898cso295212701cf.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777364933; x=1777969733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AZ7AM4sUTj1CsDlwy22BwmLFhBvxq226uLWhzfZ1iUw=;
        b=mguRKT73Lhrp131LzAIOUjvp4Ra1iQQPciutSrlWS/29TZuPmowgk2DU4PQjht+kvh
         HyP84aY+xIwBnLjNTWtduvxas5uJlSYKq1xdCQSe0q/LKO5dHSQ5lHck3hxlIyjDuNie
         GMAMt6og/Su+GVumFy40dJmqploPmfgnVQFOU3lfc2zVgO5icow4+n9jdfF2yeWnHwg5
         4s2cGP237A9Sd34hqyGqE0h4XO2ekPgCp047B+DJgyQHXFDrG5kicmffluXaxzV+OhQK
         oFt24/AyRMRNSO6sSJXtGv4blkii/ZbUft0c6Rhcf8oRATE9X2kbhjeFmJYQOUCrgzaf
         b0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364933; x=1777969733;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZ7AM4sUTj1CsDlwy22BwmLFhBvxq226uLWhzfZ1iUw=;
        b=Ixh+bNz6iwf7mebeNxfPGTqqJgtbn2VQ116aNB/risWnsujkmwWBA5CTQuB6IGw2IZ
         MfxdAEL3cUHhudS5Klwz2LH2lzDKf5RtA0pvZYVaHhSp0sCOSWmfGYjMiMeDd95qqBOd
         jS7vv64IUYPZKnkr/LSj+f6WGPtw/d8mk13QdrkKyzZvmJ0Qk0nwfblk0Yhdqs9DZTtG
         4J2FtuxpUkzK1ucemKKEi9pDBUzm//2QJxRrpdXe27cDWLtrTUC4L1UOgBNd+Ifx9gpd
         dDsgyprXoqGg2Nr+hOI3ngZLVUtFe1kwckxiFvhh75hpYkBEioDDQFU7MVB+FvVz7r0q
         QZ2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9n0iHAHuebmWYHoW3dclUgpT48g1qOeBCfoBwlloyaIprhh3l544SLa1qGYxi1HVajMD0nvMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSFop5gZtcOBrwo/a5/EfLE0WPtVt6Ya0ThojTEuFswXNmZ2kb
	0+SfJ7n4X64VSa2yebQgK+FL2wfrqDMHqQEwEh0kNNsicpPATp20/Ql8zSPlePrq1gvMneQVKda
	lDPss1qmdt3tTMw==
X-Received: from qtbce13.prod.google.com ([2002:a05:622a:41cd:b0:50f:c3ab:2ee9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:10a:b0:50d:efc1:841d with SMTP id d75a77b69052e-5100e13f4e3mr25680781cf.23.1777364932985;
 Tue, 28 Apr 2026 01:28:52 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:28:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428082851.3240821-1-edumazet@google.com>
Subject: [PATCH iproute2-next] tc: use ll_init_map() only when needed
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 69E7C48044A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281723-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Some setups can have thousands of devices.

ll_init_map() is rather expensive for them.

Only call ll_init_map() in the following cases:

1) tc runs in batch mode.
2) tc runs in monitor mode.
3) tc dumps qdiscs/classes/filters for all netdev.

This greatly reduces RTNL pressure on common operations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 tc/f_route.c   |  1 -
 tc/m_mirred.c  |  2 --
 tc/tc.c        |  1 +
 tc/tc_class.c  |  6 ++----
 tc/tc_filter.c | 32 ++++++++++++++++----------------
 tc/tc_qdisc.c  |  5 ++---
 6 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/tc/f_route.c b/tc/f_route.c
index 96b99b06be179c90dfb0d24d9577b5206dd98ef1..c234ddf0cb9309556844c85047d0f9ef53a2fd7b 100644
--- a/tc/f_route.c
+++ b/tc/f_route.c
@@ -76,7 +76,6 @@ static int route_parse_opt(const struct filter_util *qu, char *handle, int argc,
 			__u32 id;
 
 			NEXT_ARG();
-			ll_init_map(&rth);
 			if ((id = ll_name_to_index(*argv)) <= 0) {
 				fprintf(stderr, "Illegal \"fromif\"\n");
 				return -1;
diff --git a/tc/m_mirred.c b/tc/m_mirred.c
index f4da3c76284460d7f4bb73c7c3c172732f054632..e9ae5199432e828026f15ce226c5f5f84998c660 100644
--- a/tc/m_mirred.c
+++ b/tc/m_mirred.c
@@ -213,8 +213,6 @@ parse_direction(const struct action_util *a, int *argc_p, char ***argv_p,
 	if (d[0])  {
 		int idx;
 
-		ll_init_map(&rth);
-
 		idx = ll_name_to_index(d);
 		if (!idx)
 			return nodev(d);
diff --git a/tc/tc.c b/tc/tc.c
index 0fc658c881f0f553f1f1f8d87b46943d4d0eed8f..7d69e4d533a98b9c071cb954443a049a52252f2c 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -243,6 +243,7 @@ static int batch(const char *name)
 		return -1;
 	}
 
+	ll_init_map(&rth);
 	ret = do_batch(name, force, tc_batch_cmd, NULL);
 
 	rtnl_close(&rth);
diff --git a/tc/tc_class.c b/tc/tc_class.c
index 6d707d8c924f4b5e90201d4de8e9779f82ce17f3..9aace019e6c8b96fb51edb4fe89bea5b7469beed 100644
--- a/tc/tc_class.c
+++ b/tc/tc_class.c
@@ -136,11 +136,11 @@ static int tc_class_modify(int cmd, unsigned int flags, int argc, char **argv)
 	}
 
 	if (d[0])  {
-		ll_init_map(&rth);
-
 		req.t.tcm_ifindex = ll_name_to_index(d);
 		if (!req.t.tcm_ifindex)
 			return -nodev(d);
+	} else {
+		ll_init_map(&rth);
 	}
 
 	if (rtnl_talk(&rth, &req.n, NULL) < 0)
@@ -437,8 +437,6 @@ static int tc_class_list(int argc, char **argv)
 		argc--; argv++;
 	}
 
-	ll_init_map(&rth);
-
 	if (d[0]) {
 		t.tcm_ifindex = ll_name_to_index(d);
 		if (!t.tcm_ifindex)
diff --git a/tc/tc_filter.c b/tc/tc_filter.c
index 7db850bda11a3408ec66b457c9fc590f3a734f65..be70e360849e5058192640da0f061810a99e2ea8 100644
--- a/tc/tc_filter.c
+++ b/tc/tc_filter.c
@@ -188,16 +188,17 @@ static int tc_filter_modify(int cmd, unsigned int flags, int argc, char **argv)
 		addattr_l(&req.n, sizeof(req), TCA_KIND, k, strlen(k)+1);
 
 	if (d[0])  {
-		ll_init_map(&rth);
-
 		req.t.tcm_ifindex = ll_name_to_index(d);
 		if (req.t.tcm_ifindex == 0) {
 			fprintf(stderr, "Cannot find device \"%s\"\n", d);
 			return 1;
 		}
-	} else if (block_index) {
-		req.t.tcm_ifindex = TCM_IFINDEX_MAGIC_BLOCK;
-		req.t.tcm_block_index = block_index;
+	} else {
+		ll_init_map(&rth);
+		if (block_index) {
+			req.t.tcm_ifindex = TCM_IFINDEX_MAGIC_BLOCK;
+			req.t.tcm_block_index = block_index;
+		}
 	}
 
 	if (q) {
@@ -539,8 +540,6 @@ static int tc_filter_get(int cmd, unsigned int flags, int argc, char **argv)
 	}
 
 	if (d[0])  {
-		ll_init_map(&rth);
-
 		req.t.tcm_ifindex = ll_name_to_index(d);
 		if (!req.t.tcm_ifindex)
 			return -nodev(d);
@@ -704,21 +703,22 @@ static int tc_filter_list(int cmd, int argc, char **argv)
 
 	req.t.tcm_info = TC_H_MAKE(prio<<16, protocol);
 
-	ll_init_map(&rth);
-
 	if (d[0]) {
 		req.t.tcm_ifindex = ll_name_to_index(d);
 		if (!req.t.tcm_ifindex)
 			return -nodev(d);
 		filter_ifindex = req.t.tcm_ifindex;
-	} else if (block_index) {
-		if (!tc_qdisc_block_exists(block_index)) {
-			fprintf(stderr, "Cannot find block \"%u\"\n", block_index);
-			return 1;
+	} else {
+		ll_init_map(&rth);
+		if (block_index) {
+			if (!tc_qdisc_block_exists(block_index)) {
+				fprintf(stderr, "Cannot find block \"%u\"\n", block_index);
+				return 1;
+			}
+			req.t.tcm_ifindex = TCM_IFINDEX_MAGIC_BLOCK;
+			req.t.tcm_block_index = block_index;
+			filter_block_index = block_index;
 		}
-		req.t.tcm_ifindex = TCM_IFINDEX_MAGIC_BLOCK;
-		req.t.tcm_block_index = block_index;
-		filter_block_index = block_index;
 	}
 
 	if (filter_chain_index_set)
diff --git a/tc/tc_qdisc.c b/tc/tc_qdisc.c
index 7eb9a31baa31fb91a8141c9eca1135e76a52fa8b..252ea861f249a5a71cf782389776e68c3e48c6cc 100644
--- a/tc/tc_qdisc.c
+++ b/tc/tc_qdisc.c
@@ -193,8 +193,6 @@ static int tc_qdisc_modify(int cmd, unsigned int flags, int argc, char **argv)
 	if (d[0])  {
 		int idx;
 
-		ll_init_map(&rth);
-
 		idx = ll_name_to_index(d);
 		if (!idx)
 			return -nodev(d);
@@ -411,13 +409,14 @@ static int tc_qdisc_list(int argc, char **argv)
 		argc--; argv++;
 	}
 
-	ll_init_map(&rth);
 
 	if (d[0]) {
 		req.t.tcm_ifindex = ll_name_to_index(d);
 		if (!req.t.tcm_ifindex)
 			return -nodev(d);
 		filter_ifindex = req.t.tcm_ifindex;
+	} else {
+		ll_init_map(&rth);
 	}
 
 	if (dump_invisible) {
-- 
2.54.0.545.g6539524ca2-goog


