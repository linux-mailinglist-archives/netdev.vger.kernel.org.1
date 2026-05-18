Return-Path: <netdev+bounces-289167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHGkL2Z1C2oZIAUAu9opvQ
	(envelope-from <netdev+bounces-289167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:24:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C18A57355C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A72ED3018D61
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00098391845;
	Mon, 18 May 2026 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMaLvqmB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160A36215A
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135843; cv=none; b=bSPgPunt322MCl/kAFqLoYGcpsuCXLGIEbbk6o3cyJzwTetNUityoB1xoe5qufJ4eOniV771+uptHEts0+LWhvERnlvc+JL3S3Fqc8OQaNAHiOaApeufw1d+QvFkytq2t7npRPKGSuyDcXgEWq0VcAEpLSILryjta/ZQOtG/EKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135843; c=relaxed/simple;
	bh=Cb3Y5BGaVIlJIov2YzhlUaBkFOPAH0FCxsmdNd2HdLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzTQjdUGk0HdPNn0hQ0q6DMcuhFJnkGvYGyfu8txXkRW+Guf4TAiDeNYJHGC+EdXV7Wy07TPdHW8f+DM591x+Nx+McjJq+9h1DuIOasDYymylL45G9r+f7PUXDTet3iP4th44bfYHKq0gpkTRHyGQu6spB8yip0JgI2pTppAecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMaLvqmB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd4f7f05e90so549112466b.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135840; x=1779740640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfsRpZQb8rcXe++da52ZntazG2eXuyUWfsPru973jIM=;
        b=RMaLvqmBd2k76fgGv/6g9CAA4GeYfYcANhgrNPHk/Pr9u3jT5FqcbpLO6BrAk2Vbhp
         NMVPqeQBCBiLR/uR8mag9r0aslX0b90/7fg0HyvrSLRj+mPtnqxeGE1b7Odtz9TbkATR
         /WK5iMjAREOtM91Yn2H9N+O5DzzmR8S+rfhFEaRprnIN3tPdQa4fFPs94lOJB7tg8gXd
         bk/geyfOmvnb8T8dwvsoQL57p4T8jYTGXtFLrK4RPEeVR4OKB8VEGtBSAv0dUbOdlG5U
         NKIU6AwqiaWxcttXkI9Hh5gGUqpd9mqhVuSdCU9oJU4ii0kxuXVkc+SNTLajvVmrntXZ
         9rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135840; x=1779740640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IfsRpZQb8rcXe++da52ZntazG2eXuyUWfsPru973jIM=;
        b=ehZbE7j41J7yKxDqFlwC5m5iLyW4n3k0yGGmkdexMvBKJC8VxtUaCrjg45qYzb68iQ
         LNSYqwprrwCaY10G8tLNjwSCmlNgcNHNvQjLtljLLn+Il+3bEH1XjtagcUc5b7FEcc6I
         22CPlFP07OrK0r/SqsFYT7D8qiyk3RNbIUaw0d84QTbs9isST6iF7/EnCXubDm67jTfA
         aDKFc5WfzeT5ClDamAbzS2lStDbcjlavtRjX7wjDNefxEgmVHnVXegHN0GcK0VtlxdBr
         SWNGIdK7gL3zUMqkcXu4VILiRguPGIVCBfQbCdLeEh5yl4sP2wwgI4ga7xZCkresjYMT
         SW/Q==
X-Gm-Message-State: AOJu0Yyf3zejpHzrSv6ZtraFkz1L3Fx+ki30mNMd4ViRRjZiiPb/AJ/t
	pTfaB8NJOHWQeSrrzrGbwWzJTJZSMsmcvleljxxr35dyFLxRMt8Bt6KxLYKBP6vxnIQ=
X-Gm-Gg: Acq92OFu138/0J6K93FjCNxypz00ozOkf99J237ybTAsM5IvOy9KUXMbQDO0UEOjd0R
	asXZ1BsJBCo3AXC3MVLCSHqqnlS9e26u19Oevzoynr1quMl1PATUZyAxj1NI8GJBg4Y60spcp25
	kWNGOYOOktq8jMRa/cpxwwuahWuYeeKWhNXRJcWuyy4MUdORbfMEXvslphaMiDuCmQYvl/u/8uM
	JvX66/DwpePyIobNlcHbwD1S1/fkaftMEHlyeoi7tJZJTz87qUQ/aeC3OdDpAlzfSuoDZzWPqwR
	ZCkWB3fsnwuL8Esdq5AAvn79gNBoMpAQMZidP6Kfzt+b+liOSaPrjWXloQ2c4Tqicz9PX2LzsQH
	H4IDF2shZ9cLDTrw9w5dGiuzbpzZCrgyaTyGfLCmPx5/w5hgCv2aEsYNvwYq4FjXaNC7AxGr5Kc
	M8918F/vca+JSpYv/4MeVhv1EuHtJ8woPZSqc/IuATIA==
X-Received: by 2002:a17:907:8b85:b0:bd4:f7ee:d334 with SMTP id a640c23a62f3a-bd517966f7dmr916688166b.26.1779135840170;
        Mon, 18 May 2026 13:24:00 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:38::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e68fa6sm618296866b.54.2026.05.18.13.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:23:58 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexander.duyck@gmail.com,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [iproute2-next V4 1/6] netshaper: Extract parse_scope() and parse_rate() helpers
Date: Mon, 18 May 2026 13:23:48 -0700
Message-ID: <20260518202353.390827-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260518202353.390827-1-mohsin.bashr@gmail.com>
References: <20260518202353.390827-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289167-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,networkplumber.org,redhat.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6C18A57355C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mohsin Bashir <hmohsin@meta.com>

Add parse_scope() and parse_rate() helpers in preparation for
adding the group command which will need scope and rate parsing
at various places in the code. This patch will help to avoid
code duplication.

Verify that the tool works as before:
./netshaper set dev eth2 handle scope queue id 0 bw-max 100kbit
./netshaper delete dev eth2 handle scope queue id 0 bw-max 100kbit

Assisted-by: Claude:claude-opus-4.7
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


