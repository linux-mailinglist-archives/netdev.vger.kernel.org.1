Return-Path: <netdev+bounces-111249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C6C93060D
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 16:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75A81F219DC
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9203113959D;
	Sat, 13 Jul 2024 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRh+ow9R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8460313B280
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720882622; cv=none; b=rYtznmPSs42aMRn+cRz47HGEUTZCiltOcPbNXV6vGsZUL3tz6YbalL0eCLHcSI1X6zrhvjThl9n2MIuCi38MBjbLusRZ/LvWrq4snB4XuxN6IUaXD1izOuM8Hicbeusr+3kdup63738pahcvUUr3xFDgh7gdrdQpwhpXAoszoWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720882622; c=relaxed/simple;
	bh=xR97UIM0WGMFBJ5Qe9bW6eWvx9XSNruL32Sqfhb31wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGhwE9Vm/4/9+1lgiZ4yizt7W4DO+3SuRs28MrbSd/3/Rc1l+6DK4ycp2kiQAkRvc/rtZrg/eYiH4YuvyL5frdLDLY8G52+YB+llNjXG5+k09oTa3usR/OBtGDz1uOU23blekTMYUSgsyHOXhMNkJvIZF+CrBMV1/M+V5eCDcSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRh+ow9R; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77c7d3e8bcso389744166b.1
        for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720882619; x=1721487419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ght833ORDiFTHYs04+9JwB5nNoYiTAZVa6Un44WWdyA=;
        b=LRh+ow9R4Y67/0SPM+X+L8TQJl960SYONzfzUKiwRQptiOe7RmbiYPxvNnfPo8IMOO
         /miPjBryMmQn8L5PRoG47ZmcrT6dUr+2gXZfhN60rZyunrXq7aYplI38Aeqpq6N8XWHt
         udxTPJoUGNQltQx0LB62qxa9Is+HhXRjb8/RxN8zC5yBYHjpHsV03+mCMxb94a7ek2ln
         fWmxjIFoVHsZ20H4+3/RnyruagLBIcjTsCx7RpVrMcIKECqclabmEnl9DA2iJI8txsel
         s8Y0eFN6UTWkRnT5tVptDwowI4HkKaq39wodcIAN+QhkRT+c4Uqv2R72BcvbPkPwqOCX
         ELLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720882619; x=1721487419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ght833ORDiFTHYs04+9JwB5nNoYiTAZVa6Un44WWdyA=;
        b=FnZTOlEL9yz0QemtCkpMWkrPwvtOnC0pkakB56BoZ0Wu5nCn+NKPoSeHhIopGcLXac
         gARVyq3sBiSPlWIyhEPG4J6GyTxzL9wWjXnZb0AhbD1UdUvfbJMSaYtpUffACY0+Am6L
         royZLoNesSp4yICK/tKzITjN3/WXKkxD8CLCZ0/6ABcpK18yZc52EDiM/1B0PvmxgLFD
         oqt5fW/9jyugPyGoPDC1tncwJJCDokCTdta1KS/fTOMWd9NL1yqC7HmfAYMdARxEphRO
         uhzv6X+hG0DIxyx3eKXsuP3DvzGnXTuc/SygyuepT+9wAj46ohxc+Di/6pOwATotPwnN
         Dgtw==
X-Gm-Message-State: AOJu0YxVg+v9PBanQUMyf+E3ctwGaVGNKIaBcQcCicybgLxuRRBlkxwe
	k9svZjInai9z9f96MXrQFsAZ+8vZpIVowMmkzeMf1b/YlU41pmOrbzIrWA==
X-Google-Smtp-Source: AGHT+IEfCRxP0+erw3/7zJI0K/NXe/Z1rw7ppLWRnNMuWuSjp9r7JgAg9qmXMaJXnoNcE5WZrpp+1Q==
X-Received: by 2002:a17:907:868e:b0:a72:603f:1ea2 with SMTP id a640c23a62f3a-a780b8834f8mr1140564266b.62.1720882618537;
        Sat, 13 Jul 2024 07:56:58 -0700 (PDT)
Received: from tp.home.arpa (host-79-37-135-162.retail.telecomitalia.it. [79.37.135.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1d91sm57208766b.118.2024.07.13.07.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 07:56:58 -0700 (PDT)
From: Beniamino Galvani <b.galvani@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next] ip: do not print stray prefixes in monitor mode
Date: Sat, 13 Jul 2024 16:56:41 +0200
Message-ID: <20240713145641.4145324-1-b.galvani@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running "ip monitor", accept_msg() first prints the prefix and
then calls the object-specific print function, which also does the
filtering. Therefore, it is possible that the prefix is printed even
for events that get ignored later. For example:

  ip link add dummy1 type dummy
  ip link set dummy1 up
  ip -ts monitor all dev dummy1 &
  ip link add dummy2 type dummy
  ip addr add dev dummy1 192.0.2.1/24

generates:

  [2024-07-12T22:11:26.338342] [LINK][2024-07-12T22:11:26.339846] [ADDR]314: dummy1    inet 192.0.2.1/24 scope global dummy1
       valid_lft forever preferred_lft forever

Fix this by printing the prefix only after the filtering. Now the
output for the commands above is:

 [2024-07-12T22:11:26.339846] [ADDR]314: dummy1    inet 192.0.2.1/24 scope global dummy1
       valid_lft forever preferred_lft forever

See also commit 7e0a889b5494 ("bridge: Do not print stray prefixes in
monitor mode") which fixed the same problem in the bridge tool.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 ip/ip_common.h   |  1 +
 ip/ipaddress.c   |  4 ++++
 ip/ipaddrlabel.c |  3 +++
 ip/ipmonitor.c   | 27 +++++++++++----------------
 ip/ipmroute.c    |  2 ++
 ip/ipneigh.c     |  2 ++
 ip/ipnetconf.c   |  2 ++
 ip/ipnetns.c     |  2 ++
 ip/ipnexthop.c   |  5 +++++
 ip/ipprefix.c    |  2 ++
 ip/iproute.c     |  2 ++
 ip/iprule.c      |  2 ++
 ip/ipstats.c     | 10 ++++++----
 13 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/ip/ip_common.h b/ip/ip_common.h
index d3645a2c..625311c2 100644
--- a/ip/ip_common.h
+++ b/ip/ip_common.h
@@ -232,4 +232,5 @@ void print_stats64(FILE *fp, struct rtnl_link_stats64 *s,
 		   const struct rtattr *carrier_changes, const char *what);
 void print_mpls_link_stats(FILE *fp, const struct mpls_link_stats *stats,
 			   const char *indent);
+void print_headers(FILE *fp, const char *label);
 #endif /* _IP_COMMON_H_ */
diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index e3cb7541..4e1f934f 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -1052,6 +1052,8 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 	if (filter.slave_kind && match_link_kind(tb, filter.slave_kind, 1))
 		return -1;
 
+	print_headers(fp, "[LINK]");
+
 	if (n->nlmsg_type == RTM_DELLINK)
 		print_bool(PRINT_ANY, "deleted", "Deleted ", true);
 
@@ -1598,6 +1600,8 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
 			return 0;
 	}
 
+	print_headers(fp, "[ADDR]");
+
 	if (n->nlmsg_type == RTM_DELADDR)
 		print_bool(PRINT_ANY, "deleted", "Deleted ", true);
 
diff --git a/ip/ipaddrlabel.c b/ip/ipaddrlabel.c
index b045827a..0f49bbee 100644
--- a/ip/ipaddrlabel.c
+++ b/ip/ipaddrlabel.c
@@ -46,6 +46,7 @@ int print_addrlabel(struct nlmsghdr *n, void *arg)
 	struct ifaddrlblmsg *ifal = NLMSG_DATA(n);
 	int len = n->nlmsg_len;
 	struct rtattr *tb[IFAL_MAX+1];
+	FILE *fp = (FILE *)arg;
 
 	if (n->nlmsg_type != RTM_NEWADDRLABEL && n->nlmsg_type != RTM_DELADDRLABEL)
 		return 0;
@@ -56,6 +57,8 @@ int print_addrlabel(struct nlmsghdr *n, void *arg)
 
 	parse_rtattr(tb, IFAL_MAX, IFAL_RTA(ifal), len);
 
+	print_headers(fp, "[ADDRLABEL]");
+
 	open_json_object(NULL);
 	if (n->nlmsg_type == RTM_DELADDRLABEL)
 		print_bool(PRINT_ANY, "deleted", "Deleted ", true);
diff --git a/ip/ipmonitor.c b/ip/ipmonitor.c
index 9b055264..de67f2c9 100644
--- a/ip/ipmonitor.c
+++ b/ip/ipmonitor.c
@@ -22,6 +22,8 @@
 static void usage(void) __attribute__((noreturn));
 static int prefix_banner;
 int listen_all_nsid;
+struct rtnl_ctrl_data *ctrl_data;
+int do_monitor;
 
 static void usage(void)
 {
@@ -34,16 +36,19 @@ static void usage(void)
 	exit(-1);
 }
 
-static void print_headers(FILE *fp, char *label, struct rtnl_ctrl_data *ctrl)
+void print_headers(FILE *fp, const char *label)
 {
+	if (!do_monitor)
+		return;
+
 	if (timestamp)
 		print_timestamp(fp);
 
 	if (listen_all_nsid) {
-		if (ctrl == NULL || ctrl->nsid < 0)
+		if (ctrl_data == NULL || ctrl_data->nsid < 0)
 			fprintf(fp, "[nsid current]");
 		else
-			fprintf(fp, "[nsid %d]", ctrl->nsid);
+			fprintf(fp, "[nsid %d]", ctrl_data->nsid);
 	}
 
 	if (prefix_banner)
@@ -55,6 +60,8 @@ static int accept_msg(struct rtnl_ctrl_data *ctrl,
 {
 	FILE *fp = (FILE *)arg;
 
+	ctrl_data = ctrl;
+
 	switch (n->nlmsg_type) {
 	case RTM_NEWROUTE:
 	case RTM_DELROUTE: {
@@ -71,11 +78,9 @@ static int accept_msg(struct rtnl_ctrl_data *ctrl,
 
 		if (r->rtm_family == RTNL_FAMILY_IPMR ||
 		    r->rtm_family == RTNL_FAMILY_IP6MR) {
-			print_headers(fp, "[MROUTE]", ctrl);
 			print_mroute(n, arg);
 			return 0;
 		} else {
-			print_headers(fp, "[ROUTE]", ctrl);
 			print_route(n, arg);
 			return 0;
 		}
@@ -83,32 +88,27 @@ static int accept_msg(struct rtnl_ctrl_data *ctrl,
 
 	case RTM_NEWNEXTHOP:
 	case RTM_DELNEXTHOP:
-		print_headers(fp, "[NEXTHOP]", ctrl);
 		print_cache_nexthop(n, arg, true);
 		return 0;
 
 	case RTM_NEWNEXTHOPBUCKET:
 	case RTM_DELNEXTHOPBUCKET:
-		print_headers(fp, "[NEXTHOPBUCKET]", ctrl);
 		print_nexthop_bucket(n, arg);
 		return 0;
 
 	case RTM_NEWLINK:
 	case RTM_DELLINK:
 		ll_remember_index(n, NULL);
-		print_headers(fp, "[LINK]", ctrl);
 		print_linkinfo(n, arg);
 		return 0;
 
 	case RTM_NEWADDR:
 	case RTM_DELADDR:
-		print_headers(fp, "[ADDR]", ctrl);
 		print_addrinfo(n, arg);
 		return 0;
 
 	case RTM_NEWADDRLABEL:
 	case RTM_DELADDRLABEL:
-		print_headers(fp, "[ADDRLABEL]", ctrl);
 		print_addrlabel(n, arg);
 		return 0;
 
@@ -122,18 +122,15 @@ static int accept_msg(struct rtnl_ctrl_data *ctrl,
 				return 0;
 		}
 
-		print_headers(fp, "[NEIGH]", ctrl);
 		print_neigh(n, arg);
 		return 0;
 
 	case RTM_NEWPREFIX:
-		print_headers(fp, "[PREFIX]", ctrl);
 		print_prefix(n, arg);
 		return 0;
 
 	case RTM_NEWRULE:
 	case RTM_DELRULE:
-		print_headers(fp, "[RULE]", ctrl);
 		print_rule(n, arg);
 		return 0;
 
@@ -143,18 +140,15 @@ static int accept_msg(struct rtnl_ctrl_data *ctrl,
 
 	case RTM_NEWNETCONF:
 	case RTM_DELNETCONF:
-		print_headers(fp, "[NETCONF]", ctrl);
 		print_netconf(ctrl, n, arg);
 		return 0;
 
 	case RTM_DELNSID:
 	case RTM_NEWNSID:
-		print_headers(fp, "[NSID]", ctrl);
 		print_nsid(n, arg);
 		return 0;
 
 	case RTM_NEWSTATS:
-		print_headers(fp, "[STATS]", ctrl);
 		ipstats_print(n, arg);
 		return 0;
 
@@ -196,6 +190,7 @@ int do_ipmonitor(int argc, char **argv)
 	int ifindex = 0;
 
 	rtnl_close(&rth);
+	do_monitor = 1;
 
 	while (argc > 0) {
 		if (matches(*argv, "file") == 0) {
diff --git a/ip/ipmroute.c b/ip/ipmroute.c
index b6d9e618..da58d295 100644
--- a/ip/ipmroute.c
+++ b/ip/ipmroute.c
@@ -97,6 +97,8 @@ int print_mroute(struct nlmsghdr *n, void *arg)
 	if (inet_addr_match_rta(&filter.msrc, tb[RTA_SRC]))
 		return 0;
 
+	print_headers(fp, "[MROUTE]");
+
 	family = get_real_family(r->rtm_type, r->rtm_family);
 
 	open_json_object(NULL);
diff --git a/ip/ipneigh.c b/ip/ipneigh.c
index ee14ffcc..bd7f44e1 100644
--- a/ip/ipneigh.c
+++ b/ip/ipneigh.c
@@ -383,6 +383,8 @@ int print_neigh(struct nlmsghdr *n, void *arg)
 			return 0;
 	}
 
+	print_headers(fp, "[NEIGH]");
+
 	open_json_object(NULL);
 	if (n->nlmsg_type == RTM_DELNEIGH)
 		print_bool(PRINT_ANY, "deleted", "Deleted ", true);
diff --git a/ip/ipnetconf.c b/ip/ipnetconf.c
index a0c7e051..77147eb6 100644
--- a/ip/ipnetconf.c
+++ b/ip/ipnetconf.c
@@ -78,6 +78,8 @@ int print_netconf(struct rtnl_ctrl_data *ctrl, struct nlmsghdr *n, void *arg)
 	if (filter.ifindex && filter.ifindex != ifindex)
 		return 0;
 
+	print_headers(fp, "[NETCONF]");
+
 	open_json_object(NULL);
 	if (n->nlmsg_type == RTM_DELNETCONF)
 		print_bool(PRINT_ANY, "deleted", "Deleted ", true);
diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index 594b2ef1..972d7e9c 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -289,6 +289,8 @@ int print_nsid(struct nlmsghdr *n, void *arg)
 		return -1;
 	}
 
+	print_headers(fp, "[NSID]");
+
 	open_json_object(NULL);
 	if (n->nlmsg_type == RTM_DELNSID)
 		print_bool(PRINT_ANY, "deleted", "Deleted ", true);
diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index 8aa06de0..91b731b0 100644
--- a/ip/ipnexthop.c
+++ b/ip/ipnexthop.c
@@ -799,6 +799,9 @@ int print_cache_nexthop(struct nlmsghdr *n, void *arg, bool process_cache)
 		fprintf(stderr, "Error parsing nexthop: %s\n", strerror(-err));
 		return -1;
 	}
+
+	print_headers(fp, "[NEXTHOP]");
+
 	__print_nexthop_entry(fp, NULL, &nhe, n->nlmsg_type == RTM_DELNEXTHOP);
 	print_string(PRINT_FP, NULL, "%s", "\n");
 	fflush(fp);
@@ -839,6 +842,8 @@ int print_nexthop_bucket(struct nlmsghdr *n, void *arg)
 
 	parse_rtattr_flags(tb, NHA_MAX, RTM_NHA(nhm), len, NLA_F_NESTED);
 
+	print_headers(fp, "[NEXTHOPBUCKET]");
+
 	open_json_object(NULL);
 
 	if (n->nlmsg_type == RTM_DELNEXTHOP)
diff --git a/ip/ipprefix.c b/ip/ipprefix.c
index c5704e5a..4ec30524 100644
--- a/ip/ipprefix.c
+++ b/ip/ipprefix.c
@@ -58,6 +58,8 @@ int print_prefix(struct nlmsghdr *n, void *arg)
 
 	parse_rtattr(tb, RTA_MAX, RTM_RTA(prefix), len);
 
+	print_headers(fp, "[PREFIX]");
+
 	if (tb[PREFIX_ADDRESS]) {
 		fprintf(fp, "prefix %s/%u",
 			rt_addr_n2a_rta(family, tb[PREFIX_ADDRESS]),
diff --git a/ip/iproute.c b/ip/iproute.c
index 44666240..9520729e 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -818,6 +818,8 @@ int print_route(struct nlmsghdr *n, void *arg)
 			return 0;
 	}
 
+	print_headers(fp, "[ROUTE]");
+
 	open_json_object(NULL);
 	if (n->nlmsg_type == RTM_DELROUTE)
 		print_bool(PRINT_ANY, "deleted", "Deleted ", true);
diff --git a/ip/iprule.c b/ip/iprule.c
index e503e5c6..81938f2e 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -250,6 +250,8 @@ int print_rule(struct nlmsghdr *n, void *arg)
 	if (!filter_nlmsg(n, tb, host_len))
 		return 0;
 
+	print_headers(fp, "[RULE]");
+
 	open_json_object(NULL);
 	if (n->nlmsg_type == RTM_DELRULE)
 		print_bool(PRINT_ANY, "deleted", "Deleted ", true);
diff --git a/ip/ipstats.c b/ip/ipstats.c
index 3f94ff1e..cb9d9cbb 100644
--- a/ip/ipstats.c
+++ b/ip/ipstats.c
@@ -741,7 +741,7 @@ static void ipstats_show_group(const struct ipstats_sel *sel)
 }
 
 static int
-ipstats_process_ifsm(struct nlmsghdr *answer,
+ipstats_process_ifsm(FILE *fp, struct nlmsghdr *answer,
 		     struct ipstats_stat_enabled *enabled)
 {
 	struct ipstats_stat_show_attrs show_attrs = {};
@@ -763,6 +763,8 @@ ipstats_process_ifsm(struct nlmsghdr *answer,
 
 	dev = ll_index_to_name(show_attrs.ifsm->ifindex);
 
+	print_headers(fp, "[STATS]");
+
 	for (i = 0; i < enabled->nenabled; i++) {
 		const struct ipstats_stat_desc *desc = enabled->enabled[i].desc;
 
@@ -845,7 +847,7 @@ ipstats_show_one(int ifindex, struct ipstats_stat_enabled *enabled)
 	ipstats_req_add_filters(&req, enabled);
 	if (rtnl_talk(&rth, &req.nlh, &answer) < 0)
 		return -2;
-	err = ipstats_process_ifsm(answer, enabled);
+	err = ipstats_process_ifsm(stdout, answer, enabled);
 	free(answer);
 
 	return err;
@@ -856,7 +858,7 @@ static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
 	struct ipstats_stat_enabled *enabled = arg;
 	int rc;
 
-	rc = ipstats_process_ifsm(n, enabled);
+	rc = ipstats_process_ifsm(stdout, n, enabled);
 	if (rc)
 		return rc;
 
@@ -1352,7 +1354,7 @@ int ipstats_print(struct nlmsghdr *n, void *arg)
 	FILE *fp = arg;
 	int rc;
 
-	rc = ipstats_process_ifsm(n, &enabled);
+	rc = ipstats_process_ifsm(fp, n, &enabled);
 	if (rc)
 		return rc;
 
-- 
2.45.2


