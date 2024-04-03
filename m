Return-Path: <netdev+bounces-84269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E65896303
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 05:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1191F22F0D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 03:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89B32E636;
	Wed,  3 Apr 2024 03:34:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554E2374D
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115266; cv=none; b=Axn/2pEhnd9IXo+GJxmj0RNUlz+hsNqS4ymzJL6yiHr1YkNQT9jF+caZVio9fDvj7g5ZxtmRnxrePLyj02r5dqQ8eI6eesQiSlVtaD2e05FB8J3NhpytF8wqpH02ywYKgkI1eHuPa9q/zv4TcB5FyRocJRuc3py/YVN3vNyla0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115266; c=relaxed/simple;
	bh=5dNF6dSZ14vqJVlmaM0SaxAxh/CADSNhP/SRyFnWHjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cg2aq8VOTUawEq0pBwh5tJxd1fJ7LU2lwzkNsrCSf/1uSndCT75fFPPg/8Wd+dIDIRn7tfPa6S6Jb7ByopONtRtmsTnE/GY35GFeJLM20xIV4aA89ZKu3s7XlOvXPY4N9JsDz2t4fN/DXWAmuV9XVl1/L+pYn/I5WSEqHkQ3UpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V8VfP5614ztRVS;
	Wed,  3 Apr 2024 11:31:41 +0800 (CST)
Received: from dggpemd100005.china.huawei.com (unknown [7.185.36.102])
	by mail.maildlp.com (Postfix) with ESMTPS id A683318005C;
	Wed,  3 Apr 2024 11:34:15 +0800 (CST)
Received: from localhost.huawei.com (10.137.16.203) by
 dggpemd100005.china.huawei.com (7.185.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 11:34:15 +0800
From: renmingshuai <renmingshuai@huawei.com>
To: <netdev@vger.kernel.org>, <stephen@networkplumber.org>,
	<dsahern@gmail.com>
CC: <renmingshuai@huawei.com>, <yanan@huawei.com>, <liaichun@huawei.com>
Subject: [PATCH] iplink: add an option to set IFLA_EXT_MASK attribute
Date: Wed, 3 Apr 2024 11:20:21 +0800
Message-ID: <20240403032021.29899-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd100005.china.huawei.com (7.185.36.102)

Kernel has add IFLA_EXT_MASK attribute for indicating that certain
extended ifinfo values are requested by the user application. The ip
link show cmd always request VFs extended ifinfo.

RTM_GETLINK for greater than about 220 VFs truncates IFLA_VFINFO_LIST
due to the maximum reach of nlattr's nla_len being exceeded.
As a result, ip link show command only show the truncated VFs info sucn as:

    #ip link show dev eth0
    1: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 ...
        link/ether ...
        vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff ...
    Truncated VF list: eth0

Add an option to set IFLA_EXT_MASK attribute and users can choose to
show the extended ifinfo or not.

Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
---
 ip/ip_common.h        |  1 +
 ip/ipaddress.c        | 23 +++++++++++++++++------
 ip/iplink.c           |  5 +++--
 man/man8/ip-link.8.in |  7 +++++++
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/ip/ip_common.h b/ip/ip_common.h
index b65c2b41..d6a36845 100644
--- a/ip/ip_common.h
+++ b/ip/ip_common.h
@@ -30,6 +30,7 @@ struct link_filter {
 	int target_nsid;
 	bool have_proto;
 	int proto;
+	bool ext_info;
 };
 
 const char *get_ip_lib_dir(void);
diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index e536912f..b533c0fc 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -2035,9 +2035,11 @@ static int iplink_filter_req(struct nlmsghdr *nlh, int reqlen)
 	filt_mask = RTEXT_FILTER_VF;
 	if (!show_stats)
 		filt_mask |= RTEXT_FILTER_SKIP_STATS;
-	err = addattr32(nlh, reqlen, IFLA_EXT_MASK, filt_mask);
-	if (err)
-		return err;
+	if (filter.ext_info) {
+		err = addattr32(nlh, reqlen, IFLA_EXT_MASK, filt_mask);
+		if (err)
+			return err;
+	}
 
 	if (filter.master) {
 		err = addattr32(nlh, reqlen, IFLA_MASTER, filter.master);
@@ -2075,8 +2077,8 @@ static int ipaddr_link_get(int index, struct nlmsg_chain *linfo)
 
 	if (!show_stats)
 		filt_mask |= RTEXT_FILTER_SKIP_STATS;
-
-	addattr32(&req.n, sizeof(req), IFLA_EXT_MASK, filt_mask);
+	if (filter.ext_info)
+		addattr32(&req.n, sizeof(req), IFLA_EXT_MASK, filt_mask);
 
 	if (rtnl_talk(&rth, &req.n, &answer) < 0) {
 		perror("Cannot send link request");
@@ -2139,6 +2141,7 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
 	ipaddr_reset_filter(oneline, 0);
 	filter.showqueue = 1;
 	filter.family = preferred_family;
+	filter.ext_info = true;
 
 	if (action == IPADD_FLUSH) {
 		if (argc <= 0) {
@@ -2221,6 +2224,14 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
 				invarg("\"proto\" value is invalid\n", *argv);
 			filter.have_proto = true;
 			filter.proto = proto;
+		} else if (strcmp(*argv, "extinfo") == 0) {
+			NEXT_ARG();
+			if (strcmp(*argv, "on") == 0)
+				filter.ext_info = true;
+			else if (strcmp(*argv, "off") == 0)
+				filter.ext_info = false;
+			else
+				invarg("must be \"on\" or \"off\"", "extinfo");
 		} else {
 			if (strcmp(*argv, "dev") == 0)
 				NEXT_ARG();
@@ -2274,7 +2285,7 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
 	 * the link device
 	 */
 	if (filter_dev && filter.group == -1 && do_link == 1) {
-		if (iplink_get(filter_dev, RTEXT_FILTER_VF) < 0) {
+		if (iplink_get(filter_dev, filter.ext_info ? RTEXT_FILTER_VF : 0) < 0) {
 			perror("Cannot send link get request");
 			delete_json_obj();
 			exit(1);
diff --git a/ip/iplink.c b/ip/iplink.c
index 95314af5..97f26e5d 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -111,7 +111,7 @@ void iplink_usage(void)
 		"		[ gro_max_size BYTES ] [ gro_ipv4_max_size BYTES ]\n"
 		"\n"
 		"	ip link show [ DEVICE | group GROUP ] [up] [master DEV] [vrf NAME] [type TYPE]\n"
-		"		[nomaster]\n"
+		"		[nomaster] [ extinfo { on | off } ]\n"
 		"\n"
 		"	ip link xstats type TYPE [ ARGS ]\n"
 		"\n"
@@ -1115,7 +1115,8 @@ int iplink_get(char *name, __u32 filt_mask)
 
 	if (!show_stats)
 		filt_mask |= RTEXT_FILTER_SKIP_STATS;
-	addattr32(&req.n, sizeof(req), IFLA_EXT_MASK, filt_mask);
+	if (filt_mask)
+		addattr32(&req.n, sizeof(req), IFLA_EXT_MASK, filt_mask);
 
 	if (rtnl_talk(&rth, &req.n, &answer) < 0)
 		return -2;
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 31e2d7f0..c2a59ff7 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -203,6 +203,7 @@ ip-link \- network device configuration
 .B vrf
 .IR NAME " ] ["
 .BR nomaster " ]"
+.RB "[ " extinfo " { " on " | " off " } ]"
 
 .ti -8
 .B ip link xstats
@@ -2898,6 +2899,10 @@ output.
 .B nomaster
 only show devices with no master
 
+.TP
+.BR "extinfo on" or "extinfo off"
+specifies whether to show the extended ifinfo.
+
 .SS  ip link xstats - display extended statistics
 
 .TP
-- 
2.33.0


