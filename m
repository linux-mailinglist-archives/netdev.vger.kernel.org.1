Return-Path: <netdev+bounces-97833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 165298CD6DC
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4506EB20E5F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3696110A14;
	Thu, 23 May 2024 15:17:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643901097B
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477466; cv=none; b=T1x96B73k624mwA5hljWUgZ0sBwL9aML8tPH+EzZ2773yXveILn8BDkC6tLvL/m3hIy6mSngwhDJknDsKcfP0C3uyaSnIZo0f6EzY90lu6H9cgXjbYqgwl+iWMev35eUYRNRe4UsnLAHaSfV0sZWDUPdjrS+MIslODcrZIO5P1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477466; c=relaxed/simple;
	bh=hYidbwjXluppPYstbkqkrMPBL8NgiMHPqnaN7SRr2MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekTGG+hbWn1qeG5tEEqwlVrRqHDkrfCeISMSux3mL2k9ll+0CwTQ0XVk79HHd1pllualpd29Q9BYiFsm8AmXlD8apfOHEL1/vGjahlPzQq/5pY1DU+5/PRFslyTVVApIG8QsG1g2Wo0zXdytdYh5QaC7lgt09XCs4r7M798k5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from coffee.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	by smtp.chopps.org (Postfix) with ESMTP id 46C627D127
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 15:17:38 +0000 (UTC)
Received: by coffee.chopps.org (Postfix, from userid 1004)
	id 25713180EAB; Thu, 23 May 2024 11:17:38 -0400 (EDT)
X-Spam-Level: 
Received: from labnh.int.chopps.org (labnh.int.chopps.org [192.168.2.80])
	by coffee.chopps.org (Postfix) with ESMTP id 96746180EA9;
	Thu, 23 May 2024 11:17:36 -0400 (EDT)
Received: by labnh.int.chopps.org (Postfix, from userid 1000)
	id 8C84DC035DA30; Thu, 23 May 2024 11:17:36 -0400 (EDT)
From: Christian Hopps <chopps@labn.net>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	devel@linux-ipsec.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>,
	Antony Antony <antony.antony@secunet.com>
Subject: [PATCH iproute-next v1 1/2] xfrm: add SA direction attribute
Date: Thu, 23 May 2024 11:17:06 -0400
Message-ID: <20240523151707.972161-2-chopps@labn.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523151707.972161-1-chopps@labn.net>
References: <20240523151707.972161-1-chopps@labn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for new SA direction netlink attribute.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Co-developed-by: Christian Hopps <chopps@labn.net>
Signed-off-by: Christian Hopps <chopps@labn.net>
---
 include/uapi/linux/xfrm.h |  6 +++++
 ip/ipxfrm.c               | 12 ++++++++++
 ip/xfrm_state.c           | 49 ++++++++++++++++++++++++++-------------
 3 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 43efaeca..dccfd437 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -141,6 +141,11 @@ enum {
 	XFRM_POLICY_MAX	= 3
 };
 
+enum xfrm_sa_dir {
+	XFRM_SA_DIR_IN	= 1,
+	XFRM_SA_DIR_OUT = 2
+};
+
 enum {
 	XFRM_SHARE_ANY,		/* No limitations */
 	XFRM_SHARE_SESSION,	/* For this session only */
@@ -315,6 +320,7 @@ enum xfrm_attr_type_t {
 	XFRMA_SET_MARK_MASK,	/* __u32 */
 	XFRMA_IF_ID,		/* __u32 */
 	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
+	XFRMA_SA_DIR,		/* __u8 */
 	__XFRMA_MAX
 
 #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
diff --git a/ip/ipxfrm.c b/ip/ipxfrm.c
index b78c712d..90d25aac 100644
--- a/ip/ipxfrm.c
+++ b/ip/ipxfrm.c
@@ -904,6 +904,18 @@ void xfrm_xfrma_print(struct rtattr *tb[], __u16 family, FILE *fp,
 		fprintf(fp, "tfcpad %u", tfcpad);
 		fprintf(fp, "%s", _SL_);
 	}
+	if (tb[XFRMA_SA_DIR]) {
+		__u8 dir = rta_getattr_u8(tb[XFRMA_SA_DIR]);
+
+		fprintf(fp, "\tdir ");
+		if (dir == XFRM_SA_DIR_IN)
+			fprintf(fp, "in");
+		else if (dir == XFRM_SA_DIR_OUT)
+			fprintf(fp, "out");
+		else
+			fprintf(fp, "other (%d)", dir);
+		fprintf(fp, "%s", _SL_);
+	}
 }
 
 static int xfrm_selector_iszero(struct xfrm_selector *s)
diff --git a/ip/xfrm_state.c b/ip/xfrm_state.c
index 9be65b2f..fbb1f913 100644
--- a/ip/xfrm_state.c
+++ b/ip/xfrm_state.c
@@ -40,7 +40,7 @@ static void usage(void)
 {
 	fprintf(stderr,
 		"Usage: ip xfrm state { add | update } ID [ ALGO-LIST ] [ mode MODE ]\n"
-		"        [ mark MARK [ mask MASK ] ] [ reqid REQID ] [ seq SEQ ]\n"
+		"        [ mark MARK [ mask MASK ] ] [ reqid REQID ] [ dir DIR ] [ seq SEQ ]\n"
 		"        [ replay-window SIZE ] [ replay-seq SEQ ] [ replay-oseq SEQ ]\n"
 		"        [ replay-seq-hi SEQ ] [ replay-oseq-hi SEQ ]\n"
 		"        [ flag FLAG-LIST ] [ sel SELECTOR ] [ LIMIT-LIST ] [ encap ENCAP ]\n"
@@ -49,7 +49,7 @@ static void usage(void)
 		"        [ output-mark OUTPUT-MARK [ mask MASK ] ]\n"
 		"        [ if_id IF_ID ] [ tfcpad LENGTH ]\n"
 		"Usage: ip xfrm state allocspi ID [ mode MODE ] [ mark MARK [ mask MASK ] ]\n"
-		"        [ reqid REQID ] [ seq SEQ ] [ min SPI max SPI ]\n"
+		"        [ reqid REQID ] [ dir DIR ] [ seq SEQ ] [ min SPI max SPI ]\n"
 		"Usage: ip xfrm state { delete | get } ID [ mark MARK [ mask MASK ] ]\n"
 		"Usage: ip xfrm state deleteall [ ID ] [ mode MODE ] [ reqid REQID ]\n"
 		"        [ flag FLAG-LIST ]\n"
@@ -251,22 +251,20 @@ static int xfrm_state_extra_flag_parse(__u32 *extra_flags, int *argcp, char ***a
 	return 0;
 }
 
-static bool xfrm_offload_dir_parse(__u8 *dir, int *argcp, char ***argvp)
+static void xfrm_dir_parse(__u8 *dir, int *argcp, char ***argvp)
 {
 	int argc = *argcp;
 	char **argv = *argvp;
 
 	if (strcmp(*argv, "in") == 0)
-		*dir = XFRM_OFFLOAD_INBOUND;
+		*dir = XFRM_SA_DIR_IN;
 	else if (strcmp(*argv, "out") == 0)
-		*dir = 0;
+		*dir = XFRM_SA_DIR_OUT;
 	else
-		return false;
+		invarg("DIR value is not \"in\" or \"out\"", *argv);
 
 	*argcp = argc;
 	*argvp = argv;
-
-	return true;
 }
 
 static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
@@ -429,13 +427,8 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
 
 			NEXT_ARG();
 			if (strcmp(*argv, "dir") == 0) {
-				bool is_dir;
-
 				NEXT_ARG();
-				is_dir = xfrm_offload_dir_parse(&dir, &argc,
-								&argv);
-				if (!is_dir)
-					invarg("DIR value is invalid", *argv);
+				xfrm_dir_parse(&dir, &argc, &argv);
 			} else
 				invarg("Missing DIR keyword", *argv);
 			is_offload = true;
@@ -462,6 +455,9 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
 			NEXT_ARG();
 			if (get_u32(&tfcpad, *argv, 0))
 				invarg("value after \"tfcpad\" is invalid", *argv);
+		} else if (strcmp(*argv, "dir") == 0) {
+			NEXT_ARG();
+			xfrm_dir_parse(&dir, &argc, &argv);
 		} else {
 			/* try to assume ALGO */
 			int type = xfrm_algotype_getbyname(*argv);
@@ -587,7 +583,7 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
 	}
 
 	if (req.xsinfo.flags & XFRM_STATE_ESN &&
-	    replay_window == 0) {
+	    replay_window == 0 && dir != XFRM_SA_DIR_OUT ) {
 		fprintf(stderr, "Error: esn flag set without replay-window.\n");
 		exit(-1);
 	}
@@ -601,7 +597,7 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
 
 	if (is_offload) {
 		xuo.ifindex = ifindex;
-		xuo.flags = dir;
+		xuo.flags = dir == XFRM_SA_DIR_IN ? XFRM_OFFLOAD_INBOUND : 0;
 		if (is_packet_offload)
 			xuo.flags |= XFRM_OFFLOAD_PACKET;
 		addattr_l(&req.n, sizeof(req.buf), XFRMA_OFFLOAD_DEV, &xuo,
@@ -763,6 +759,14 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
 	if (rtnl_open_byproto(&rth, 0, NETLINK_XFRM) < 0)
 		exit(1);
 
+	if (dir) {
+		int r = addattr8(&req.n, sizeof(req.buf), XFRMA_SA_DIR, dir);
+		if (r < 0) {
+			fprintf(stderr, "XFRMA_SA_DIR failed\n");
+			exit(1);
+		}
+	}
+
 	if (req.xsinfo.family == AF_UNSPEC)
 		req.xsinfo.family = AF_INET;
 
@@ -792,6 +796,7 @@ static int xfrm_state_allocspi(int argc, char **argv)
 	char *maxp = NULL;
 	struct xfrm_mark mark = {0, 0};
 	struct nlmsghdr *answer;
+	__u8 dir = 0;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "mode") == 0) {
@@ -823,6 +828,9 @@ static int xfrm_state_allocspi(int argc, char **argv)
 
 			if (get_u32(&req.xspi.max, *argv, 0))
 				invarg("value after \"max\" is invalid", *argv);
+		} else if (strcmp(*argv, "dir") == 0) {
+			NEXT_ARG();
+			xfrm_dir_parse(&dir, &argc, &argv);
 		} else {
 			/* try to assume ID */
 			if (idp)
@@ -875,6 +883,15 @@ static int xfrm_state_allocspi(int argc, char **argv)
 			req.xspi.max = 0xffff;
 	}
 
+	if (dir) {
+		int r = addattr8(&req.n, sizeof(req.buf), XFRMA_SA_DIR, dir);
+
+		if (r < 0) {
+			fprintf(stderr, "XFRMA_SA_DIR failed\n");
+			exit(1);
+		}
+	}
+
 	if (mark.m & mark.v) {
 		int r = addattr_l(&req.n, sizeof(req.buf), XFRMA_MARK,
 				  (void *)&mark, sizeof(mark));
-- 
2.45.1


