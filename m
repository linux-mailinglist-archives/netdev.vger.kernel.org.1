Return-Path: <netdev+bounces-286793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHCJN5ciAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:40:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 461B55148C6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C3AC302A516
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB8D496913;
	Mon, 11 May 2026 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQBmukcs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7C4A2E05
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524768; cv=none; b=Kb/T88/3Aa5qCKqmZmtoZe13J5N2QNl9GiVECmh18pegfcz31T+k8l6BV2zkqxqtdtP952BPAx9Dfv52ItZLh+1jz1MyLRhwAujnjZm2CCtY/1UPGUQyZpj84ZOvItM25MQXkJG/jeOk/uEdeTwkgboq5KLv32xVr3HMqkKNPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524768; c=relaxed/simple;
	bh=wTUycWqwx+BBu7XtVRkfd3+3Pagutf/iGRT/dLzjBZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItUJjDvzw7kt3JgCLP8s7QsQMU9NBXF4ZxLcO5v75IDHmD2uPbr+Kaeg85r5IZvh+w0IrR9jz7NanpayN+y1tr6i+Cr1Bd+XzZzSVOrZQ8dOea33Pr+dws8lUgLLVXrDDy2ih/grs/9ttpj5k3C4KdEwHTvMMe8/evExc7yzr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQBmukcs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d73422431so3625820f8f.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778524760; x=1779129560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=669Hd88+bDZuIuiQNEdjW+Rdcaq1lVY93PReBLQWHSs=;
        b=bQBmukcsNB+Oy46FSM/E9YSk189pTXQn06Abq9+RhzkzqvGoYMN3R7D6DdANoqoWgu
         MLyRN6xEJ0YkulPWrWj99r8pZTt8nM53GHCl+0Qeb262WH269lO5Xftv+bqHm9HgLuAN
         CT16lUb3rSfm5XyV7bs/CBybQybhCzkiC28czBh9OkaaxoP5pZOhAx8q2Fk16vkkW9bS
         VSxSiG5L8wj+VaZ4cpdkhDjqntj3Hl6UNAEHAJcOOt0ikrb30FNhEwwkNF+QmbM0+Emt
         nRX1uJs3Zzn99EFNbeqSALJ1Ypf+DjdItWJL5sLTgRZNgTrtFH3Zlu25Ouf657P+hXJ7
         1Fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778524760; x=1779129560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=669Hd88+bDZuIuiQNEdjW+Rdcaq1lVY93PReBLQWHSs=;
        b=ocFfhvE9Wh57x3OiU0XigX7XVyObDOCdhXLw6qyQ671CtuOsE3Jrag1NjejOq10AM4
         /RE59/HaLFzQKWfRzoes/a/u8LCvLNZVsFP0as7ylNHDm/05d6qTTKzBgtlZxz6qs+II
         n56zNOpDmrB8YVHQkyczfNVvuOvAwj562no8KwsxOYMaspiL2Zz3nwB/OdmGBLPgrZlU
         YJxkMRn3KPTYvKBmMQy3JzGU9XCMLPBWe0nMSemH5BqK1yTXzCn9zdXRkOjoolMl4pjW
         k8zLA4ocf2HYhigKPb5xVOeQtRG4bys1X2WCFeOOqui7VhTGmmv1471a5hUP7WGQ2BC1
         HE8g==
X-Gm-Message-State: AOJu0YwXw6zsycjRy6x57S84vs7tIm2lA02fMtECF2D80RomVJZnSGv2
	J9H36CgN5Cz2vTUH4cBYB17V68841vLlIPHF86tG2WwbB4wveOz/W+39WrJX3Q==
X-Gm-Gg: Acq92OEERb10DZMZqTvgq3lh5I8duRX1/qcSE/sM3mKuALBiPS25ckYZ3nteqaZRFu4
	HkkPIJge1n0arLG88bUp9UyGIVN2o/AtLeAlXuAeUDtaAxeRhfBxFWXAtqL8ttlpbW0cntZ9gkH
	qe9dx9qsnQmKNF/5YhG/J48T5tRDiT8zz6SF9jr+ciJJKuPuN00bCJiqqPKgM+Pl+4aFCtTpGSd
	It3dbbbBzMGkhvJ/cUu0I6zyXFAkB83bHpuBWgRGyowVmNJ/2w0GAtIxnE3hSQSkyG5MNxAS3j9
	VKsqUtHNbDZCy88sXGc5p+dpP6EqLKq/ovjTk+01FQ5/FamgLin5duYXa94tU9+pMD/mzpGyJ3A
	xw2k7sUD8cJW8OKjOZN/2ZonsuFkjqJFtmPq5pHtJYhvifo21cTKNB3yYBJJwAWW3R5UFFBsKuu
	VFq9FZbdJVQRhz4rSK49Wa
X-Received: by 2002:a05:6000:2689:b0:44a:2555:f8a9 with SMTP id ffacd0b85a97d-4515b524014mr39298504f8f.10.1778524760468;
        Mon, 11 May 2026 11:39:20 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1f::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491da03a7sm27579490f8f.33.2026.05.11.11.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:39:20 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com,
	alexanderduyck@gmail.com,
	Claude Assistant <noreply@anthropic.com>
Subject: [PATCH iproute2-next v3 1/6] netshaper: Extract parse_scope() and parse_rate() helpers
Date: Mon, 11 May 2026 11:39:10 -0700
Message-ID: <20260511183915.797792-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511183915.797792-1-mohsin.bashr@gmail.com>
References: <20260511183915.797792-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 461B55148C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286793-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com,anthropic.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anthropic.com:email]
X-Rspamd-Action: no action

From: Mohsin Bashir <hmohsin@meta.com>

Add parse_scope() and parse_rate() helpers in preparation for
adding the group command which will need scope and rate parsing
at various places in the code. This patch will help to avoid
code duplication.

Verify that the tool works as before:
./netshaper set dev eth2 handle scope queue id 0 bw-max 100kbit
./netshaper delete dev eth2 handle scope queue id 0 bw-max 100kbit

Reviewed-by: Claude Assistant <noreply@anthropic.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 include/utils.h       |  1 +
 netshaper/netshaper.c | 63 ++++++++++++++++++++++---------------------
 2 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index e4e318e2..f0d45bad 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -260,6 +260,7 @@ unsigned int print_name_and_link(const char *fmt,
 	__attribute__((format(printf, 1, 0)));
 
 
+#define BITS_PER_BYTE           8
 #define BIT(nr)                 (UINT64_C(1) << (nr))
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 47fb805e..f90ceb11 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -47,6 +47,26 @@ static const char *net_shaper_scope_names[NET_SHAPER_SCOPE_MAX + 1] = {
 	"node"
 };
 
+static int parse_scope(const char *str)
+{
+	for (int i = 1; i <= NET_SHAPER_SCOPE_MAX; i++) {
+		if (strcmp(str, net_shaper_scope_names[i]) == 0)
+			return i;
+	}
+	return -1;
+}
+
+static int parse_rate(const char *str, __u64 *rate_bps)
+{
+	if (get_rate64(rate_bps, str)) {
+		fprintf(stderr, "Invalid rate value \"%s\"\n", str);
+		return -1;
+	}
+	/* get_rate64 returns bytes/sec, convert to bits/sec */
+	*rate_bps *= BITS_PER_BYTE;
+	return 0;
+}
+
 static void print_netshaper_attrs(struct nlmsghdr *answer)
 {
 	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
@@ -117,12 +137,8 @@ static int do_cmd(int argc, char **argv, int cmd)
 			ifindex = ll_name_to_index(*argv);
 		} else if (strcmp(*argv, "bw-max") == 0) {
 			NEXT_ARG();
-			if (get_rate64(&bw_max_bps, *argv)) {
-				fprintf(stderr, "Invalid bw-max value\n");
+			if (parse_rate(*argv, &bw_max_bps))
 				return -1;
-			}
-			/* Convert Bps to bps */
-			bw_max_bps *= 8;
 		} else if (strcmp(*argv, "handle") == 0) {
 			handle_present = true;
 			NEXT_ARG();
@@ -134,34 +150,24 @@ static int do_cmd(int argc, char **argv, int cmd)
 			}
 			NEXT_ARG();
 
-			if (strcmp(*argv, "netdev") == 0) {
-				handle_scope = NET_SHAPER_SCOPE_NETDEV;
-				/* For netdev scope, id is optional - check if next arg is "id" */
+			handle_scope = parse_scope(*argv);
+			if (handle_scope < 0) {
+				fprintf(stderr, "Invalid scope \"%s\"\n", *argv);
+				return -1;
+			}
+
+			if (handle_scope == NET_SHAPER_SCOPE_NETDEV) {
+				/* For netdev scope, id is optional */
 				if (argc > 1 && strcmp(argv[1], "id") == 0) {
-					NEXT_ARG(); /* move to "id" */
-					NEXT_ARG(); /* move to id value */
+					NEXT_ARG();
+					NEXT_ARG();
 					if (get_unsigned(&handle_id, *argv, 10)) {
 						fprintf(stderr, "Invalid handle id\n");
 						return -1;
 					}
 				}
-			} else if (strcmp(*argv, "queue") == 0) {
-				handle_scope = NET_SHAPER_SCOPE_QUEUE;
-				/* For queue scope, id is required */
-				NEXT_ARG();
-				if (strcmp(*argv, "id") != 0) {
-					fprintf(stderr, "What is \"%s\"\n", *argv);
-					usage();
-					return -1;
-				}
-				NEXT_ARG();
-				if (get_unsigned(&handle_id, *argv, 10)) {
-					fprintf(stderr, "Invalid handle id\n");
-					return -1;
-				}
-			} else if (strcmp(*argv, "node") == 0) {
-				handle_scope = NET_SHAPER_SCOPE_NODE;
-				/* For node scope, id is required */
+			} else {
+				/* For queue/node scope, id is required */
 				NEXT_ARG();
 				if (strcmp(*argv, "id") != 0) {
 					fprintf(stderr, "What is \"%s\"\n", *argv);
@@ -173,9 +179,6 @@ static int do_cmd(int argc, char **argv, int cmd)
 					fprintf(stderr, "Invalid handle id\n");
 					return -1;
 				}
-			} else {
-				fprintf(stderr, "Invalid scope\n");
-				return -1;
 			}
 		} else {
 			fprintf(stderr, "What is \"%s\"\n", *argv);
-- 
2.53.0-Meta


