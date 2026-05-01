Return-Path: <netdev+bounces-283057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LLmLkj/82n99QEAu9opvQ
	(envelope-from <netdev+bounces-283057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:18:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 569764A9894
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E250330488EA
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311651E1E04;
	Fri,  1 May 2026 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvN/xE2O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B82D5436
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598181; cv=none; b=ern2gCjg6zc/kjw5OlcoeGVC9dSSUpc73q0Ew07UyVlxJwYC8HlVxOwag8y1CMuKaFrczWbOXZLLlyBZXDNGwbnjItwVeCXs/P2F0Je97i9956/f+QVSbwzgKh/Q1dsZwFtnahsr1/WU0dt9MDJm0mG02pAcAo/WB/gfdA/6YBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598181; c=relaxed/simple;
	bh=07TjzL2oVJExjVmJrVmA1U/ABU7FDg0bndC+c14Yj9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qi5Sb3Qlw+56wobGhojFh3FXLNQROlD4bvse53IyEDit6g66k2NbUPZ0oxkRhieVRNJBBv+Wk2K8UwwH9xX1Cq7WRW+0HiH7r2YeKdHJ0NFznjLoDPFtKp0AUci66R6vALeHeKLOv8f17LY1tXcsOPBx859KEPe3JVi32ABa7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvN/xE2O; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so21645085e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 18:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777598178; x=1778202978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P3mwB5zn6zCWdiX+lH7lZlwJPcN0c53T4YUn73J7gI=;
        b=NvN/xE2OUBRPAyzhY/cPABy14EMI5AX++tyS01Ou+HGY/P4zOqlKXVnv2c2sc3aWG2
         nv1H+gqwiC4+TagcNb+f+mVAzHjjIVyDtbjeOqkahxJiTcilqVOSgBP4XXeFHwi75DLo
         7r45S56W0/OZHP4p6xVy3pSNtNdDGb9F3GwapSkPIn15VOxJHAG4pRj0e9NjPhwjT2s3
         a930ga7QjrYZhq8a6tOsUt2PTAul1WhJjnliWARhFENxeTS8p8DMmkquvpgW4CAHyM6J
         ZEhhjIiWJiGryoynWqfru2kGuGHo5Ykyvy/BTNtImxeU51+lIodZU9wwg+zSvnYwKwn2
         BJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777598178; x=1778202978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4P3mwB5zn6zCWdiX+lH7lZlwJPcN0c53T4YUn73J7gI=;
        b=pjur72zOkpve5on3u4FOeRAfeY5k7USVZxWEt8FNGXUpwR1h8k15s/kGg263XSYyN4
         W+D5aJpNQe9D+ho5ePgLn+Z09fjbEXqtOIfTX6UifhXYTRMGbFDLC4TkOfdjdfhK3HYC
         KqBrQwFEVjUd+qmVIlde4O8mBSgPH6XfYorRbrQ3bSjcuSGG1NNKdAEw88FDHTDmE0HB
         sCANellHck5+MMJMucZDyg7r8/OHlyvLzDo2u61+UloFv8v2NzeBXtnBLxW5ZIxCkCwF
         5utlyU9YwAY1BGsMjmvKBNR3vAj23BxNZFoz7STB1teBaVAtvCuh/OjEipMqxG8fNG+N
         y/tw==
X-Gm-Message-State: AOJu0Yxjr9/LwErMVjONa/D3AbYNG44AE8zUlJrJnHWlIvYoKOQo6qpt
	Oe4yvV7ssVuEtAEP4k8tXB6Inm2dxkzwKap9nvLrq/q0X0Pqo0D+Om7w4mFYb4w0
X-Gm-Gg: AeBDieusCpYbkVJRdiXB0M332xBknYcNilK6fCNKkqZ/Rl6W5B6NjqhszsMay38KrPt
	1ygPz4nLIaFqtYBKahf06Hm6KYfWEOP48kcshbMmVjJlaaO/DbxLApZfQaGGbFHJ9AnO7alavX8
	Pl2X70YgXYP2tv0ZDUygt/wO61AvtgQKfDy1mt+Da70J6qX2z3417jGkHtP9xP5q0d6H9OVMPnj
	5tGlnhxMhiQQ6cXPpDn4+76Jbx3rE7gNoFnjaMBhgSclj8zCfYCAMjACSQltk7MgewPq+CiV7xx
	29wFvbtIqf0mmCloXBuBvi/B9G0keBTkARLFoJ67cdDVKH+JAJualHN58BQK2xFh0qGt5o2x50E
	qDuWH1xDiMIrQI+MRJGIZpPlSSL5eVxG4DntnbN1k/z1491+wBaND5lRti5C5c27S2ueGymtzAd
	v0PzzDo9S6d/XJtSjrS2+WFfbraQxUH+M=
X-Received: by 2002:a05:600c:26d2:b0:48a:89d9:a419 with SMTP id 5b1f17b1804b1-48a89d9a46emr34894615e9.11.1777598177801;
        Thu, 30 Apr 2026 18:16:17 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:35::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82307f28sm165629135e9.13.2026.04.30.18.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 18:16:17 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [PATCH iproute2-next 1/5] netshaper: Extract parse_scope() and parse_rate() helpers
Date: Thu, 30 Apr 2026 18:16:07 -0700
Message-ID: <20260501011611.3533573-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
References: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 569764A9894
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-283057-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add parse_scope() and parse_rate() helpers in preparation for
adding the group command which will need scope and rate parsing
at various places in the code. This patch will help to avoid
code duplication.

Verify that the tool works as before:
./netshaper set dev eth2 handle scope queue id 0 bw-max 100kbit
./netshaper delete dev eth2 handle scope queue id 0 bw-max 100kbit

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 netshaper/netshaper.c | 65 +++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 47fb805e..1603e6e5 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -47,6 +47,28 @@ static const char *net_shaper_scope_names[NET_SHAPER_SCOPE_MAX + 1] = {
 	"node"
 };
 
+static int parse_scope(const char *str)
+{
+	if (strcmp(str, "netdev") == 0)
+		return NET_SHAPER_SCOPE_NETDEV;
+	if (strcmp(str, "queue") == 0)
+		return NET_SHAPER_SCOPE_QUEUE;
+	if (strcmp(str, "node") == 0)
+		return NET_SHAPER_SCOPE_NODE;
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
+	*rate_bps *= 8;
+	return 0;
+}
+
 static void print_netshaper_attrs(struct nlmsghdr *answer)
 {
 	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
@@ -117,12 +139,8 @@ static int do_cmd(int argc, char **argv, int cmd)
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
@@ -134,34 +152,24 @@ static int do_cmd(int argc, char **argv, int cmd)
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
@@ -173,9 +181,6 @@ static int do_cmd(int argc, char **argv, int cmd)
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
2.52.0


