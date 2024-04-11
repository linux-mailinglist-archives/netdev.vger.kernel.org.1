Return-Path: <netdev+bounces-86838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113F18A0647
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFED1C238E2
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFB75D8EE;
	Thu, 11 Apr 2024 02:57:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42F13B794
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804274; cv=none; b=WoO+xKCfiZb5lrZ7EfFssuI9YfH/jW5XqUWO8GVslfwf/TFN0CnlA42Jcii3/WmMNqzI59CN5F8ABHy7fkUuT380dhZ3bIzPkWi5kVd5l7bm5LJcqQIiLdCNNdc1VJJmt35i3hKrXoCIgRP/nhVvqC51mSD8c/F3S0iDZTgw9A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804274; c=relaxed/simple;
	bh=1XyqhEpurEFagJBSneO979ILwszqD4MBbk4WK7h+s/k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oLsWCEewcMQkytKsFwzHILq/Jaj3shuQoSz9XeTZS9LjXNZrKfwWe3/6hUSkzphzoIeS+IwqIBKBquzVO3dCIe5xyZgRJjDCklV1B+BmSwBTg/C5QiPpbV0yoR45dU2fsrytmQd3libn3i/CGH6gUTZOUISTgj/iRkQxnyXAryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VFPVX1WjKz1wqyH;
	Thu, 11 Apr 2024 10:56:52 +0800 (CST)
Received: from dggpemd100005.china.huawei.com (unknown [7.185.36.102])
	by mail.maildlp.com (Postfix) with ESMTPS id ECF2818001A;
	Thu, 11 Apr 2024 10:57:47 +0800 (CST)
Received: from localhost.huawei.com (10.137.16.203) by
 dggpemd100005.china.huawei.com (7.185.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 10:57:47 +0800
From: renmingshuai <renmingshuai@huawei.com>
To: <netdev@vger.kernel.org>, <stephen@networkplumber.org>,
	<dsahern@gmail.com>
CC: <renmingshuai@huawei.com>, <yanan@huawei.com>, <liaichun@huawei.com>
Subject: [PATCH v3] ip: Support filter links with no VF info
Date: Thu, 11 Apr 2024 10:43:19 +0800
Message-ID: <20240411024319.58939-1-renmingshuai@huawei.com>
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

v2:
- use an one word option instead of an option with on/off.
- fix the issue that break changes made for the link filter
  already done for VF's.

v3:
- "novf" set vfinfo to 0 and the RTEXT_FILTER_VF flag is not added.

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
index e536912f..e3cb7541 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -2029,10 +2029,11 @@ static int ipaddr_flush(void)
 
 static int iplink_filter_req(struct nlmsghdr *nlh, int reqlen)
 {
-	__u32 filt_mask;
+	__u32 filt_mask = 0;
 	int err;
 
-	filt_mask = RTEXT_FILTER_VF;
+	if (filter.vfinfo)
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
 
+	if (filter.vfinfo)
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
+	filter.vfinfo = 1;
 
 	if (action == IPADD_FLUSH) {
 		if (argc <= 0) {
@@ -2221,6 +2224,8 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
 				invarg("\"proto\" value is invalid\n", *argv);
 			filter.have_proto = true;
 			filter.proto = proto;
+		} else if (strcmp(*argv, "novf") == 0) {
+			filter.vfinfo = 0;
 		} else {
 			if (strcmp(*argv, "dev") == 0)
 				NEXT_ARG();
@@ -2274,7 +2279,7 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
 	 * the link device
 	 */
 	if (filter_dev && filter.group == -1 && do_link == 1) {
-		if (iplink_get(filter_dev, RTEXT_FILTER_VF) < 0) {
+		if (iplink_get(filter_dev, filter.vfinfo ? RTEXT_FILTER_VF : 0) < 0) {
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


