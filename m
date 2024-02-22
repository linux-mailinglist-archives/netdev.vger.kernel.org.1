Return-Path: <netdev+bounces-74069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23E785FCEB
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3EAD1C222F8
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD13314F9EF;
	Thu, 22 Feb 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="pLLmwLsT"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707CE14E2C5
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616759; cv=none; b=QXCQ641qiqr5fQbx0rfTLo5kzGIS64HYLjHC09QzZ2TIzWipND0cCdFgFpgzfYWoE9zh5ampV/ZwmR0Euzc5Gl8kD/xUqN4cKmw6cP9l+0jmCs4RCReRPc8qOGo6NoAf+fkALt3on5lUCCkaWugawcZpdpdI5GA8Zh+MzHLBYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616759; c=relaxed/simple;
	bh=DWfN+ub8JzxBgHo4elvPZ+E7R4ZeqyqTB5A93HT1bLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tz4uniWDE+YCNKriP41AC3HfgAj9JCi5AUyBwN6W6DtAslEq7UopIR7gWk+GOjG7kgLacEUrIRcKnsoXzElBhawLbSWiJTTtqiM1NwSKn+txsc9UjsmFt2qfrVrk7wrh3OLxr1vYcTthXviwrfoNC/Fsn4GO4kSJWMWdM98By5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=pLLmwLsT; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id DD7E0200E2A4;
	Thu, 22 Feb 2024 16:45:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be DD7E0200E2A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708616754;
	bh=QHuT45n/6TzcrfWhY4CVsY6433V6+fEwM7nIlB/RN7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pLLmwLsTRz2YTI2wIzwEsUC/RdMThgygpdgJwxqFv+rFs608PCGoqoZPZ0/Y6zs0m
	 U7adBm9Cp4x0T6Ndt4ArxEpN6r/yaXOVSbuEle8GhJSG58GTOuPnBnU+kdUPQcofk8
	 kESuZ4U7avWP6ag9UsXJQ95KbzvGiiYFH0D4CdYpCU2EJo7C3X1lzQnBmBFGX14z3f
	 XiJdV9TXTBrunFxhegmdDAuJ53uNqgaOoSlbfvS4JRcz8QRqcJDxRRzKjF+BvAmWkD
	 JKatSdjUMyE49DiJmfjzjlY5NfpaZTWYPAP0is2TPmAPlx/Dx01Z9VH33KJ32djx/8
	 /4v1lZLzjlnkw==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next 2/3] ip: ioam6: add monitor command
Date: Thu, 22 Feb 2024 16:45:38 +0100
Message-Id: <20240222154539.19904-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222154539.19904-1-justin.iurman@uliege.be>
References: <20240222154539.19904-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the "ip ioam monitor" command to be able to read all IOAM data
received. This is based on a netlink multicast group.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 ip/ipioam6.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/ip/ipioam6.c b/ip/ipioam6.c
index b63d7d5c..18860989 100644
--- a/ip/ipioam6.c
+++ b/ip/ipioam6.c
@@ -13,6 +13,7 @@
 #include <inttypes.h>
 
 #include <linux/genetlink.h>
+#include <linux/ioam6.h>
 #include <linux/ioam6_genl.h>
 
 #include "utils.h"
@@ -30,7 +31,8 @@ static void usage(void)
 		"	ip ioam schema show\n"
 		"	ip ioam schema add ID DATA\n"
 		"	ip ioam schema del ID\n"
-		"	ip ioam namespace set ID schema { ID | none }\n");
+		"	ip ioam namespace set ID schema { ID | none }\n"
+		"	ip ioam monitor\n");
 	exit(-1);
 }
 
@@ -42,6 +44,7 @@ static int genl_family = -1;
 				IOAM6_GENL_VERSION, _cmd, _flags)
 
 static struct {
+	bool monitor;
 	unsigned int cmd;
 	__u32 sc_id;
 	__u32 ns_data;
@@ -96,6 +99,37 @@ static void print_schema(struct rtattr *attrs[])
 	print_nl();
 }
 
+static void print_trace(struct rtattr *attrs[])
+{
+	__u8 data[IOAM6_TRACE_DATA_SIZE_MAX];
+	int len, i = 0;
+
+	printf("[TRACE] ");
+
+	if (attrs[IOAM6_EVENT_ATTR_TRACE_NAMESPACE])
+		printf("Namespace=%u ",
+		       rta_getattr_u16(attrs[IOAM6_EVENT_ATTR_TRACE_NAMESPACE]));
+
+	if (attrs[IOAM6_EVENT_ATTR_TRACE_NODELEN])
+		printf("NodeLen=%u ",
+		       rta_getattr_u8(attrs[IOAM6_EVENT_ATTR_TRACE_NODELEN]));
+
+	if (attrs[IOAM6_EVENT_ATTR_TRACE_TYPE])
+		printf("Type=%#08x ",
+		       rta_getattr_u32(attrs[IOAM6_EVENT_ATTR_TRACE_TYPE]));
+
+	len = RTA_PAYLOAD(attrs[IOAM6_EVENT_ATTR_TRACE_DATA]);
+	memcpy(data, RTA_DATA(attrs[IOAM6_EVENT_ATTR_TRACE_DATA]), len);
+
+	printf("Data=");
+	while (i < len) {
+		printf("%02x", data[i]);
+		i++;
+	}
+
+	printf("\n");
+}
+
 static int process_msg(struct nlmsghdr *n, void *arg)
 {
 	struct rtattr *attrs[IOAM6_ATTR_MAX + 1];
@@ -126,6 +160,32 @@ static int process_msg(struct nlmsghdr *n, void *arg)
 	return 0;
 }
 
+static int ioam6_monitor_msg(struct rtnl_ctrl_data *ctrl, struct nlmsghdr *n,
+			      void *arg)
+{
+	struct rtattr *attrs[IOAM6_EVENT_ATTR_MAX + 1];
+	const struct genlmsghdr *ghdr = NLMSG_DATA(n);
+	int len = n->nlmsg_len;
+
+	if (n->nlmsg_type != genl_family)
+		return -1;
+
+	len -= NLMSG_LENGTH(GENL_HDRLEN);
+	if (len < 0)
+		return -1;
+
+	parse_rtattr(attrs, IOAM6_EVENT_ATTR_MAX,
+		     (void *)ghdr + GENL_HDRLEN, len);
+
+	switch (ghdr->cmd) {
+	case IOAM6_EVENT_TRACE:
+		print_trace(attrs);
+		break;
+	}
+
+	return 0;
+}
+
 static int ioam6_do_cmd(void)
 {
 	IOAM6_REQUEST(req, 1056, opts.cmd, NLM_F_REQUEST);
@@ -134,6 +194,19 @@ static int ioam6_do_cmd(void)
 	if (genl_init_handle(&grth, IOAM6_GENL_NAME, &genl_family))
 		exit(1);
 
+	if (opts.monitor) {
+		if (genl_add_mcast_grp(&grth, genl_family,
+					IOAM6_GENL_EV_GRP_NAME) < 0) {
+			perror("can't subscribe to ioam6 events");
+			exit(1);
+		}
+
+		if (rtnl_listen(&grth, ioam6_monitor_msg, stdout) < 0)
+			exit(1);
+
+		return 0;
+	}
+
 	req.n.nlmsg_type = genl_family;
 
 	switch (opts.cmd) {
@@ -325,6 +398,9 @@ int do_ioam6(int argc, char **argv)
 			invarg("Unknown", *argv);
 		}
 
+	} else if (strcmp(*argv, "monitor") == 0) {
+		opts.monitor = true;
+
 	} else {
 		invarg("Unknown", *argv);
 	}
-- 
2.34.1


