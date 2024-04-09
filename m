Return-Path: <netdev+bounces-85952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795DF89D039
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 04:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089BC28495A
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 02:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFDD4EB41;
	Tue,  9 Apr 2024 02:07:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7E4EB3A
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628469; cv=none; b=uvin5k77G91qFgpQliuqTcHDi12t1EPIOAbUBXugYTqJ73cBallOwLum9ly5ZdvUICoxv+FtB6uOyQSPOcgbx5jJe6XAva2Frn2jRNEqbHhap7e2VivIckWJ3H/eUONjAoKLjpzo9e8RwH8LfSjz4SIPAaRnKSwwZlo8+P9yWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628469; c=relaxed/simple;
	bh=TOuiGi6IkRgg2lEXRK7f5/JPL/u4/yYafD7FOpHuVa4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poUMrkXfN1CjfoSUvxlexaxEqkicqdu3B+Oq8RU5M7InKvfMfsmZt3idEr4yNuZBPF8Arwzdy+10J77WxRCCaK8yTzQT9ApA1ppeSxgKtl5rpCdQiC7U2pvlZR8RhnflZ+jGuUG6Jh5xLEqOkxASY3le8wYDzwTUffd3ezCQrk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VD8S941qJz1ylT4;
	Tue,  9 Apr 2024 10:05:29 +0800 (CST)
Received: from dggpemd100005.china.huawei.com (unknown [7.185.36.102])
	by mail.maildlp.com (Postfix) with ESMTPS id BF9CF1A0172;
	Tue,  9 Apr 2024 10:07:43 +0800 (CST)
Received: from localhost.huawei.com (10.137.16.203) by
 dggpemd100005.china.huawei.com (7.185.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 10:07:43 +0800
From: renmingshuai <renmingshuai@huawei.com>
To: <stephen@networkplumber.org>
CC: <dsahern@gmail.com>, <liaichun@huawei.com>, <netdev@vger.kernel.org>,
	<renmingshuai@huawei.com>, <yanan@huawei.com>
Subject: Re: [PATCH] iplink: add an option to set IFLA_EXT_MASK attribute
Date: Tue, 9 Apr 2024 09:53:50 +0800
Message-ID: <20240409015350.52377-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240408172955.13511188@hermes.local>
References: <20240408172955.13511188@hermes.local>
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

> > >> Kernel has add IFLA_EXT_MASK attribute for indicating that certain
> > >> extended ifinfo values are requested by the user application. The ip
> > >> link show cmd always request VFs extended ifinfo.
> > >> 
> > >> RTM_GETLINK for greater than about 220 VFs truncates IFLA_VFINFO_LIST
> > >> due to the maximum reach of nlattr's nla_len being exceeded.
> > >> As a result, ip link show command only show the truncated VFs info
> > >> sucn as:
> > >> 
> > >>     #ip link show dev eth0
> > >>     1: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 ...
> > >>         link/ether ...
> > >>         vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
> > >>         ...
> > >>     Truncated VF list: eth0
> > >> 
> > >> Add an option to set IFLA_EXT_MASK attribute and users can choose to
> > >> show the extended ifinfo or not.
> > >> 
> > >> Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>  
> > >
> > > Adding a new option with on/off seems like more than is necessary.
> > > If we need an option it should just be one word. Any new filter should
> > > have same conventions as existing filters.  Maybe 'novf'
> > > 
> > > And it looks like not sending IFLA_EXT_MASK will break the changes
> > > made for the link filter already done for VF's.  
> > 
> > Thanks for your reply. As you suggested, I've added an option
> > named noVF, which has same conventions as existing filter.
> > Also, this new patch does not send RTEXT_FILTER_VF instead of
> > IFLA_EXT_MASK, and it does not break the changes made for the link
> > filter already done for VF's.
> > Please review it again.
> 
> Did you read my comment. Any new option should look the same as all
> the other options in the command.  Is there any option to ip commands
> that uses mixed case? No. Please stick to lower case.

Apologies for not considering the use of lower case. I have replaced noVF with novf.
Please review it again. Thanks a lot.
By the way, do I need to submit a new patch?

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


