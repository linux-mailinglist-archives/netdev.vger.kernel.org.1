Return-Path: <netdev+bounces-86375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A5B89E858
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 05:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0239AB252F6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 03:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F113C443D;
	Wed, 10 Apr 2024 03:05:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ADB20EB
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712718354; cv=none; b=GhvX3y6Od92lHxU5ZF9CDSn0ASchUjSho6iY2Fhxqp1vC24WSGg++Bf26ppogb9LIuB14PKxjhdGj9cChWNoczZLEFgBdQDyTld7XukMwioj7jKuAr/k/2iu3fkQgVdikm+9sLua+FyEDFZrQeSOHoSOtIbGOHBTSJlUOLCuJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712718354; c=relaxed/simple;
	bh=qr+czvvOi8+atJOWDXkO3Ph3RY4ClK3lDnKfM6yA/Bo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j4xcGqJgzWXdkKdpQ5pL7IzsbNgIMqxzzFRlrl2lybTWtY+A2eVEs5iqihYMb29gyvq0kpldzHLzxgnlRqJ7uo4cjCv7Hh5fYSmOHSqfmez4rdu5z6Pj6R6Ngb5dowhph/xqqSRioaMptV3rTMuX06ggG31gQEgW+/yiJeJkZWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VDnhj6nsBz1ymWL;
	Wed, 10 Apr 2024 11:03:33 +0800 (CST)
Received: from dggpemd100005.china.huawei.com (unknown [7.185.36.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AF52140410;
	Wed, 10 Apr 2024 11:05:49 +0800 (CST)
Received: from localhost.huawei.com (10.137.16.203) by
 dggpemd100005.china.huawei.com (7.185.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 11:05:48 +0800
From: renmingshuai <renmingshuai@huawei.com>
To: <netdev@vger.kernel.org>, <stephen@networkplumber.org>,
	<dsahern@gmail.com>
CC: <renmingshuai@huawei.com>, <yanan@huawei.com>, <liaichun@huawei.com>
Subject: [PATCH] ip: Support filter links with no VF info
Date: Wed, 10 Apr 2024 10:51:54 +0800
Message-ID: <20240410025154.55242-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd100005.china.huawei.com (7.185.36.102)

Kernel has add IFLA_EXT_MASK attribute for indicating that certain
extended ifinfo values are requested by the user application. The ip
link show cmd always request VFs extended ifinfo.

In this case, RTM_GETLINK for greater than about 220 VFs truncates
IFLA_VFINFO_LIST due to the maximum reach of nlattr's nla_len being
exceeded. As a result, ip link show command only show the truncated
VFs info sucn as:

    #ip link show dev eth0
    1: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 ...
        link/ether ...
        vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff ...
    Truncated VF list: eth0

This patch add novf to support filter links with no VF info:
ip link show novf

v1->v2:
  - use a one word option instead of an option with on/off.
  - fix the issue that break the changes made for the link filter
    already done for VF's.

Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/ip_common.h        |  1 +
 ip/ipaddress.c        | 15 ++++++++++-----
 ip/iplink.c           |  2 +-
 man/man8/ip-link.8.in |  7 ++++++-
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/ip/ip_common.h b/ip/ip_common.h
index b65c2b41..d3645a2c 100644
--- a/ip/ip_common.h
+++ b/ip/ip_common.h
@@ -30,6 +30,7 @@ struct link_filter {
 	int target_nsid;
 	bool have_proto;
 	int proto;
+	int vfinfo;
 };
 
 const char *get_ip_lib_dir(void);
diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index e536912f..e7e5ce76 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -2029,10 +2029,11 @@ static int ipaddr_flush(void)
 
 static int iplink_filter_req(struct nlmsghdr *nlh, int reqlen)
 {
-	__u32 filt_mask;
+	__u32 filt_mask = 0;
 	int err;
 
-	filt_mask = RTEXT_FILTER_VF;
+	if (!filter.vfinfo)
+		filt_mask |= RTEXT_FILTER_VF;
 	if (!show_stats)
 		filt_mask |= RTEXT_FILTER_SKIP_STATS;
 	err = addattr32(nlh, reqlen, IFLA_EXT_MASK, filt_mask);
@@ -2070,12 +2071,13 @@ static int ipaddr_link_get(int index, struct nlmsg_chain *linfo)
 		.i.ifi_family = filter.family,
 		.i.ifi_index = index,
 	};
-	__u32 filt_mask = RTEXT_FILTER_VF;
+	__u32 filt_mask = 0;
 	struct nlmsghdr *answer;
 
+	if (!filter.vfinfo)
+		filt_mask |= RTEXT_FILTER_VF;
 	if (!show_stats)
 		filt_mask |= RTEXT_FILTER_SKIP_STATS;
-
 	addattr32(&req.n, sizeof(req), IFLA_EXT_MASK, filt_mask);
 
 	if (rtnl_talk(&rth, &req.n, &answer) < 0) {
@@ -2139,6 +2141,7 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
 	ipaddr_reset_filter(oneline, 0);
 	filter.showqueue = 1;
 	filter.family = preferred_family;
+	filter.vfinfo = 0;
 
 	if (action == IPADD_FLUSH) {
 		if (argc <= 0) {
@@ -2221,6 +2224,8 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
 				invarg("\"proto\" value is invalid\n", *argv);
 			filter.have_proto = true;
 			filter.proto = proto;
+		} else if (strcmp(*argv, "novf") == 0) {
+			filter.vfinfo = -1;
 		} else {
 			if (strcmp(*argv, "dev") == 0)
 				NEXT_ARG();
@@ -2274,7 +2279,7 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
 	 * the link device
 	 */
 	if (filter_dev && filter.group == -1 && do_link == 1) {
-		if (iplink_get(filter_dev, RTEXT_FILTER_VF) < 0) {
+		if (iplink_get(filter_dev, filter.vfinfo < 0 ? 0 : RTEXT_FILTER_VF) < 0) {
 			perror("Cannot send link get request");
 			delete_json_obj();
 			exit(1);
diff --git a/ip/iplink.c b/ip/iplink.c
index 95314af5..1bb4a998 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -111,7 +111,7 @@ void iplink_usage(void)
 		"		[ gro_max_size BYTES ] [ gro_ipv4_max_size BYTES ]\n"
 		"\n"
 		"	ip link show [ DEVICE | group GROUP ] [up] [master DEV] [vrf NAME] [type TYPE]\n"
-		"		[nomaster]\n"
+		"		[nomaster] [ novf ]\n"
 		"\n"
 		"	ip link xstats type TYPE [ ARGS ]\n"
 		"\n"
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 31e2d7f0..066ad874 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -202,7 +202,8 @@ ip-link \- network device configuration
 .IR ETYPE " ] ["
 .B vrf
 .IR NAME " ] ["
-.BR nomaster " ]"
+.BR nomaster " ] ["
+.BR novf " ]"
 
 .ti -8
 .B ip link xstats
@@ -2898,6 +2899,10 @@ output.
 .B nomaster
 only show devices with no master
 
+.TP
+.B novf
+only show devices with no VF info
+
 .SS  ip link xstats - display extended statistics
 
 .TP
-- 
2.33.0


