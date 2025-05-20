Return-Path: <netdev+bounces-191897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BDFABDCBB
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667934E47B5
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C126248867;
	Tue, 20 May 2025 14:12:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE275247DE1
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750335; cv=none; b=VLZkw4ZxG0DhEbjTsNvsyG7bI6rbN9OwpbdUIKsd2nPbmB/UH2S7q8/IYKJCxUAi/Iq1zxHHPDb2ltt92KMHIDQqg64EGUhrn3b+H7gD5p2/eM/4St53cS1FDpF/aRHYVV5NAK+LqXs6eVkuGMlpr6dQf9LF5aF8kC6RvtXvYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750335; c=relaxed/simple;
	bh=T5eSWDc6jD/eXskMKPVQ8MY8L5WFTPqU2Dds8Pt+DYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ghRHkKt3lYaVrGDvFf4+GqZJE17mQM9rFNCGBktTnvHk5OOhNvgrlFM06exKfZC2mB6JSZ1W008S9AHM2pqnKZaCumU9UW7ovQRB+BLqPVSn7yqRRJWyr2Y5UA3RE1rPNIX43uAntJ003+lgFIR9KTUuOri5sQwyWFEYqMI6F7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wifirst.fr; spf=fail smtp.mailfrom=wifirst.fr; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wifirst.fr
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=wifirst.fr
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 497D5DF8D1E
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:03:30 +0200 (CEST)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:36d:2a10:f4ea:eebd:4645:edc2])
	(Authenticated sender: isaias57@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 9A39119F57B;
	Tue, 20 May 2025 16:03:20 +0200 (CEST)
From: jean.thomas@wifirst.fr
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	Jean Thomas <jean.thomas@wifirst.fr>
Subject: [PATCH iproute2-next] ip: filter by group before printing
Date: Tue, 20 May 2025 16:02:48 +0200
Message-Id: <20250520140248.685712-1-jean.thomas@wifirst.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean Thomas <jean.thomas@wifirst.fr>

Filter the output using the requested group, if necessary.

This avoids to print an empty JSON object for each existing item
not matching the group filter when the --json option is used.

Before:
$ ip --json address list group test
[{},{},{},{},{},{},{},{},{},{},{},{}]

After:
$ ip --json address list group test
[]

Signed-off-by: Jean Thomas <jean.thomas@wifirst.fr>
---
 ip/ipaddress.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 91d78874..bbe48a47 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -959,12 +959,25 @@ static void print_proto_down(FILE *f, struct rtattr *tb[])
 	}
 }
 
+static int get_rtattr(struct nlmsghdr *n, struct rtattr **tb)
+{
+	int len = n->nlmsg_len;
+	struct ifinfomsg *ifi = NLMSG_DATA(n);
+
+	len -= NLMSG_LENGTH(sizeof(*ifi));
+	if (len < 0)
+		return -1;
+
+	parse_rtattr_flags(tb, IFLA_MAX, IFLA_RTA(ifi), len, NLA_F_NESTED);
+
+	return 0;
+}
+
 int print_linkinfo(struct nlmsghdr *n, void *arg)
 {
 	FILE *fp = (FILE *)arg;
 	struct ifinfomsg *ifi = NLMSG_DATA(n);
 	struct rtattr *tb[IFLA_MAX+1];
-	int len = n->nlmsg_len;
 	const char *name;
 	unsigned int m_flag = 0;
 	SPRINT_BUF(b1);
@@ -973,8 +986,7 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 	if (n->nlmsg_type != RTM_NEWLINK && n->nlmsg_type != RTM_DELLINK)
 		return 0;
 
-	len -= NLMSG_LENGTH(sizeof(*ifi));
-	if (len < 0)
+	if (get_rtattr(n, tb) < 0)
 		return -1;
 
 	if (filter.ifindex && ifi->ifi_index != filter.ifindex)
@@ -984,8 +996,6 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 	if (filter.down && ifi->ifi_flags&IFF_UP)
 		return -1;
 
-	parse_rtattr_flags(tb, IFLA_MAX, IFLA_RTA(ifi), len, NLA_F_NESTED);
-
 	name = get_ifname_rta(ifi->ifi_index, tb[IFLA_IFNAME]);
 	if (!name)
 		return -1;
@@ -2121,6 +2131,28 @@ static int ip_addr_list(struct nlmsg_chain *ainfo)
 	return 0;
 }
 
+static void group_filter(struct nlmsg_chain *linfo)
+{
+	struct nlmsg_list *l, **lp;
+
+	lp = &linfo->head;
+	while ((l = *lp) != NULL) {
+		struct nlmsghdr *n = &l->h;
+		struct rtattr *tb[IFLA_MAX+1];
+
+		if (get_rtattr(n, tb) < 0)
+			return;
+
+		if (tb[IFLA_GROUP]) {
+			if (rta_getattr_u32(tb[IFLA_GROUP]) != filter.group) {
+				*lp = l->next;
+				free(l);
+			} else
+				lp = &l->next;
+		}
+	}
+}
+
 static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
 {
 	struct nlmsg_chain linfo = { NULL, NULL};
@@ -2299,6 +2331,9 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
 		ipaddr_filter(&linfo, ainfo);
 	}
 
+	if (filter.group != -1)
+		group_filter(&linfo);
+
 	for (l = linfo.head; l; l = l->next) {
 		struct nlmsghdr *n = &l->h;
 		struct ifinfomsg *ifi = NLMSG_DATA(n);
-- 
2.39.5


