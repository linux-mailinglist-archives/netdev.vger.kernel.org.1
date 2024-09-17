Return-Path: <netdev+bounces-128655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF497ABAC
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 08:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6991F249D7
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 06:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B8171750;
	Tue, 17 Sep 2024 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="h3vanqhz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f227.google.com (mail-lj1-f227.google.com [209.85.208.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9004F56B8C
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726555951; cv=none; b=JxclS/VSMKzERiqCj8vY0kJeOvYsGCsfz/8hI8vogg9uwo+rf3kZ1rCafGUCh8eAi5eq6wG0iTdZqunV7mVRggsP19NOifNgy5M6QovRN32NeXiEdp9P//Udsvfacc2tzG/DWzlPXPnlhgY6L2s5CM9hkQFc+k1xDS75JhpPQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726555951; c=relaxed/simple;
	bh=OO9fhEripkPAsVTXeNHCYIvsHZVJ6TWetFMUyMUc/us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Je/goCA86crvS5UtAaycL9or13M2VKjuYM5nbtShs3P5Fk1kWCsrPzXUxSzIyt6rJiNWChGoZbXWyhLYLuKmARyNt6egeFuTcu7+823DMrtpx6aYxMHtXj/9sHryeeqZSyZOaM7nJ7+y0T+SgaL0e+wyL7atS4Gyv/n1i7sZB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=h3vanqhz; arc=none smtp.client-ip=209.85.208.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f227.google.com with SMTP id 38308e7fff4ca-2f75d0441a8so5769861fa.0
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 23:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1726555946; x=1727160746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NDfJ+s5p54oIoJi/w/L3tzBTyYn1pCZ0cIMt/TzmVmo=;
        b=h3vanqhzXfiK7R/ailUiqBXvaZSJlTmQgEpBr60WzLLki1Hp4fa1wLVOlc6vDbToYh
         ec7CoYqIfCIwFXJrStm5f+tHNgYWStyYecLpnJ4kciKMMw5sM/BqlMg5fV53IKACugEo
         23LMjD7r87pjsehlxwd3RaXf9KdwZNkpZ3MlPrTZ8V1h9QDNlKQj5Q5ECRamfsyELAgt
         RQ+AUEYhkC18c1IU75aAJl4AQHfLyncb/6cHwCzK62/fFPuyNvfewgPeJtryCZMHp75G
         BZBJJXDpbCGYeX0hKHbnsRVE8Wh05WXiL8QuyfLupKoz2jNNbBkfCjhn5LipYnWVHfFF
         IfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726555946; x=1727160746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDfJ+s5p54oIoJi/w/L3tzBTyYn1pCZ0cIMt/TzmVmo=;
        b=NFrn0V4x+Hr9hR2juob/Q+x8Bl8YOp200XRkmJfE4PiWHHB7lIFMt12ixTyHKzrUoM
         9lm3E82ABOVCT354EMAcoWhvb5TzvKUfiayC4dj5+VhhlBJfZ+glyxU3vBIdGHRH47im
         uXWi7RFQVgotQVM1nxbrs7yGcXfmZR4Nlnj2I9MDAg8N7WeV1Ep79g0uEIFToNYsl4bg
         MEjx0ul6Fcu+qSnukJkJDwXCrXwncKiI8S9X8vYAEPgs1rf0Z3xm0vnT3aszvsK+j98g
         0t0qmmmRW/mfiO4+fJ27ru4XBsvsXQATvze8Ff77IOM1+FYA14K79Z31Wh+gMPCEevFv
         qLbg==
X-Forwarded-Encrypted: i=1; AJvYcCXNX6mA0XzwxvMGt3Y1QgRroWIFinEMmBZeXlacUW3kdFjhGEpXSJjt7IiXX8kWw03uos5d+DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjki34uaEP4oHo2CvCMvC4tg4IgeAM8jY9HCbsNy/PKN6WzCHt
	MfeCYlfRIrh+kCmOBt7ykm7x7/M5hs6wWutQlZ90+TUFvJ60U5JEXQ0qHGMEjco8/ZNd6PI9X56
	hYttuupQQEtj2+9aV9/aF2Dpo7mDT9pgN
X-Google-Smtp-Source: AGHT+IGTXNueMlaFJFMjgMG+qsYJXuAhXyqX5lGnVRmOQYQg85Bvr1HZnD6Pshvs3z/wmZDwVtsjeL7l9qxL
X-Received: by 2002:a05:651c:1507:b0:2ee:d55c:255f with SMTP id 38308e7fff4ca-2f787f44d14mr27008151fa.7.1726555945652;
        Mon, 16 Sep 2024 23:52:25 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 38308e7fff4ca-2f79d35f0c9sm276581fa.45.2024.09.16.23.52.25;
        Mon, 16 Sep 2024 23:52:25 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 14A9912DB3;
	Tue, 17 Sep 2024 08:52:25 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sqS4W-00BriV-QR; Tue, 17 Sep 2024 08:52:24 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Subject: [PATCH iproute2] iplink: fix fd leak when playing with netns
Date: Tue, 17 Sep 2024 08:51:58 +0200
Message-ID: <20240917065158.2828026-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command 'ip link set foo netns mynetns' opens a file descriptor to fill
the netlink attribute IFLA_NET_NS_FD. This file descriptor is never closed.
When batch mode is used, the number of file descriptor may grow greatly and
reach the maximum file descriptor number that can be opened.

This fd can be closed only after the netlink answer. Let's pass a new
argument to iplink_parse() to remember this fd and close it.

Fixes: 0dc34c7713bb ("iproute2: Add processless network namespace support")
Reported-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Tested-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
---
 ip/ip_common.h           |  4 ++--
 ip/iplink.c              | 16 ++++++++++++----
 ip/iplink_amt.c          |  2 +-
 ip/iplink_bareudp.c      |  2 +-
 ip/iplink_batadv.c       |  2 +-
 ip/iplink_bond.c         |  2 +-
 ip/iplink_bond_slave.c   |  2 +-
 ip/iplink_bridge.c       |  2 +-
 ip/iplink_bridge_slave.c |  2 +-
 ip/iplink_can.c          |  2 +-
 ip/iplink_dsa.c          |  2 +-
 ip/iplink_geneve.c       |  2 +-
 ip/iplink_gtp.c          |  2 +-
 ip/iplink_hsr.c          |  2 +-
 ip/iplink_ipoib.c        |  2 +-
 ip/iplink_ipvlan.c       |  2 +-
 ip/iplink_macvlan.c      |  2 +-
 ip/iplink_netkit.c       |  5 +++--
 ip/iplink_rmnet.c        |  2 +-
 ip/iplink_vlan.c         |  2 +-
 ip/iplink_vrf.c          |  2 +-
 ip/iplink_vxcan.c        |  5 +++--
 ip/iplink_vxlan.c        |  2 +-
 ip/iplink_wwan.c         |  2 +-
 ip/ipmacsec.c            |  2 +-
 ip/link_gre.c            |  2 +-
 ip/link_gre6.c           |  2 +-
 ip/link_ip6tnl.c         |  2 +-
 ip/link_iptnl.c          |  2 +-
 ip/link_veth.c           |  5 +++--
 ip/link_vti.c            |  2 +-
 ip/link_vti6.c           |  2 +-
 ip/link_xfrm.c           |  2 +-
 33 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/ip/ip_common.h b/ip/ip_common.h
index 625311c25bce..e643b89ffd88 100644
--- a/ip/ip_common.h
+++ b/ip/ip_common.h
@@ -125,7 +125,7 @@ struct link_util {
 	const char		*id;
 	int			maxattr;
 	int			(*parse_opt)(struct link_util *, int, char **,
-					     struct nlmsghdr *);
+					     struct nlmsghdr *, int *);
 	void			(*print_opt)(struct link_util *, FILE *,
 					     struct rtattr *[]);
 	void			(*print_xstats)(struct link_util *, FILE *,
@@ -139,7 +139,7 @@ struct link_util {
 
 struct link_util *get_link_kind(const char *kind);
 
-int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type);
+int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type, int *netns_fd);
 
 /* iplink_bridge.c */
 void br_dump_bridge_id(const struct ifla_bridge_id *id, char *buf, size_t len);
diff --git a/ip/iplink.c b/ip/iplink.c
index 3bc75d243719..c2b63999daee 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -522,7 +522,7 @@ static int iplink_parse_vf(int vf, int *argcp, char ***argvp,
 	return 0;
 }
 
-int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
+int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type, int *netns_fd)
 {
 	bool move_netns = false;
 	char *name = NULL;
@@ -622,9 +622,11 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 			if (netns != -1)
 				duparg("netns", *argv);
 			netns = netns_get_fd(*argv);
-			if (netns >= 0)
+			if (netns >= 0) {
+				*netns_fd = netns;
 				addattr_l(&req->n, sizeof(*req), IFLA_NET_NS_FD,
 					  &netns, 4);
+			}
 			else if (get_integer(&netns, *argv, 0) == 0)
 				addattr_l(&req->n, sizeof(*req),
 					  IFLA_NET_NS_PID, &netns, 4);
@@ -1034,9 +1036,10 @@ static int iplink_modify(int cmd, unsigned int flags, int argc, char **argv)
 		.n.nlmsg_type = cmd,
 		.i.ifi_family = preferred_family,
 	};
+	int netns_fd = -1, netns_fd2 = -1;
 	int ret;
 
-	ret = iplink_parse(argc, argv, &req, &type);
+	ret = iplink_parse(argc, argv, &req, &type, &netns_fd);
 	if (ret < 0)
 		return ret;
 
@@ -1064,7 +1067,7 @@ static int iplink_modify(int cmd, unsigned int flags, int argc, char **argv)
 
 			data = addattr_nest(&req.n, sizeof(req), iflatype);
 
-			if (lu->parse_opt(lu, argc, argv, &req.n))
+			if (lu->parse_opt(lu, argc, argv, &req.n, &netns_fd2))
 				return -1;
 
 			addattr_nest_end(&req.n, data);
@@ -1088,6 +1091,11 @@ static int iplink_modify(int cmd, unsigned int flags, int argc, char **argv)
 	else
 		ret = rtnl_talk(&rth, &req.n, NULL);
 
+	if (netns_fd >= 0)
+		close(netns_fd);
+	if (netns_fd2 >= 0)
+		close(netns_fd2);
+
 	if (ret)
 		return -2;
 
diff --git a/ip/iplink_amt.c b/ip/iplink_amt.c
index 3a35bd9df9d1..9d7f991d12e3 100644
--- a/ip/iplink_amt.c
+++ b/ip/iplink_amt.c
@@ -55,7 +55,7 @@ static void check_duparg(__u64 *attrs, int type, const char *key,
 }
 
 static int amt_parse_opt(struct link_util *lu, int argc, char **argv,
-			 struct nlmsghdr *n)
+			 struct nlmsghdr *n, int *netns_fd)
 {
 	unsigned int mode, max_tunnels;
 	inet_prefix saddr, daddr;
diff --git a/ip/iplink_bareudp.c b/ip/iplink_bareudp.c
index aa3111068788..b21f962b1ba1 100644
--- a/ip/iplink_bareudp.c
+++ b/ip/iplink_bareudp.c
@@ -46,7 +46,7 @@ static void check_duparg(__u64 *attrs, int type, const char *key,
 }
 
 static int bareudp_parse_opt(struct link_util *lu, int argc, char **argv,
-			     struct nlmsghdr *n)
+			     struct nlmsghdr *n, int *netns_fd)
 {
 	bool multiproto = false;
 	__u16 srcportmin = 0;
diff --git a/ip/iplink_batadv.c b/ip/iplink_batadv.c
index 27d316762e70..481bfb4e5920 100644
--- a/ip/iplink_batadv.c
+++ b/ip/iplink_batadv.c
@@ -29,7 +29,7 @@ static void explain(void)
 }
 
 static int batadv_parse_opt(struct link_util *lu, int argc, char **argv,
-			    struct nlmsghdr *n)
+			    struct nlmsghdr *n, int *netns_fd)
 {
 	while (argc > 0) {
 		if (matches(*argv, "ra") == 0) {
diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 19af67d001f0..0e1303834219 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -174,7 +174,7 @@ static void explain(void)
 }
 
 static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
-			  struct nlmsghdr *n)
+			  struct nlmsghdr *n, int *netns_fd)
 {
 	__u8 mode, use_carrier, primary_reselect, fail_over_mac;
 	__u8 xmit_hash_policy, num_peer_notif, all_slaves_active;
diff --git a/ip/iplink_bond_slave.c b/ip/iplink_bond_slave.c
index ad6875006950..52a8ba076013 100644
--- a/ip/iplink_bond_slave.c
+++ b/ip/iplink_bond_slave.c
@@ -148,7 +148,7 @@ static void bond_slave_print_opt(struct link_util *lu, FILE *f, struct rtattr *t
 }
 
 static int bond_slave_parse_opt(struct link_util *lu, int argc, char **argv,
-				struct nlmsghdr *n)
+				struct nlmsghdr *n, int *netns_fd)
 {
 	__u16 queue_id;
 	int prio;
diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index f01ffe15d7e8..debc804986ac 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -81,7 +81,7 @@ void br_dump_bridge_id(const struct ifla_bridge_id *id, char *buf, size_t len)
 }
 
 static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
-			    struct nlmsghdr *n)
+			    struct nlmsghdr *n, int *netns_fd)
 {
 	struct br_boolopt_multi bm = {};
 	__u32 val;
diff --git a/ip/iplink_bridge_slave.c b/ip/iplink_bridge_slave.c
index 3821923b5da5..5ce9d5d2cbdc 100644
--- a/ip/iplink_bridge_slave.c
+++ b/ip/iplink_bridge_slave.c
@@ -327,7 +327,7 @@ static void bridge_slave_parse_on_off(char *arg_name, char *arg_val,
 }
 
 static int bridge_slave_parse_opt(struct link_util *lu, int argc, char **argv,
-				  struct nlmsghdr *n)
+				  struct nlmsghdr *n, int *netns_fd)
 {
 	__u8 state;
 	__u16 priority;
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index f2967db5d2b6..957356f5959b 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -124,7 +124,7 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
 }
 
 static int can_parse_opt(struct link_util *lu, int argc, char **argv,
-			 struct nlmsghdr *n)
+			 struct nlmsghdr *n, int *netns_fd)
 {
 	struct can_bittiming bt = {}, dbt = {};
 	struct can_ctrlmode cm = { 0 };
diff --git a/ip/iplink_dsa.c b/ip/iplink_dsa.c
index e3f3f8aca13c..cabccd909d53 100644
--- a/ip/iplink_dsa.c
+++ b/ip/iplink_dsa.c
@@ -12,7 +12,7 @@ static void print_usage(FILE *f)
 }
 
 static int dsa_parse_opt(struct link_util *lu, int argc, char **argv,
-			 struct nlmsghdr *n)
+			 struct nlmsghdr *n, int *netns_fd)
 {
 	while (argc > 0) {
 		if (strcmp(*argv, "conduit") == 0 ||
diff --git a/ip/iplink_geneve.c b/ip/iplink_geneve.c
index 62c61bce138b..2c693bb25f01 100644
--- a/ip/iplink_geneve.c
+++ b/ip/iplink_geneve.c
@@ -54,7 +54,7 @@ static void check_duparg(__u64 *attrs, int type, const char *key,
 }
 
 static int geneve_parse_opt(struct link_util *lu, int argc, char **argv,
-			  struct nlmsghdr *n)
+			    struct nlmsghdr *n, int *netns_fd)
 {
 	inet_prefix daddr;
 	__u32 vni = 0;
diff --git a/ip/iplink_gtp.c b/ip/iplink_gtp.c
index 086946b62ede..7774acce6a64 100644
--- a/ip/iplink_gtp.c
+++ b/ip/iplink_gtp.c
@@ -32,7 +32,7 @@ static void check_duparg(__u32 *attrs, int type, const char *key,
 }
 
 static int gtp_parse_opt(struct link_util *lu, int argc, char **argv,
-			 struct nlmsghdr *n)
+			 struct nlmsghdr *n, int *netns_fd)
 {
 	__u32 attrs = 0;
 
diff --git a/ip/iplink_hsr.c b/ip/iplink_hsr.c
index 42adb43009b7..9fb8ac93af29 100644
--- a/ip/iplink_hsr.c
+++ b/ip/iplink_hsr.c
@@ -45,7 +45,7 @@ static void usage(void)
 }
 
 static int hsr_parse_opt(struct link_util *lu, int argc, char **argv,
-			 struct nlmsghdr *n)
+			 struct nlmsghdr *n, int *netns_fd)
 {
 	int ifindex;
 	unsigned char multicast_spec;
diff --git a/ip/iplink_ipoib.c b/ip/iplink_ipoib.c
index 7bf4e3215dd2..37e5a57e6d5e 100644
--- a/ip/iplink_ipoib.c
+++ b/ip/iplink_ipoib.c
@@ -38,7 +38,7 @@ static int mode_arg(void)
 }
 
 static int ipoib_parse_opt(struct link_util *lu, int argc, char **argv,
-			  struct nlmsghdr *n)
+			   struct nlmsghdr *n, int *netns_fd)
 {
 	__u16 pkey, mode, umcast;
 
diff --git a/ip/iplink_ipvlan.c b/ip/iplink_ipvlan.c
index f29fa4f9e3eb..ba2b81ee94e0 100644
--- a/ip/iplink_ipvlan.c
+++ b/ip/iplink_ipvlan.c
@@ -26,7 +26,7 @@ static void print_explain(struct link_util *lu, FILE *f)
 }
 
 static int ipvlan_parse_opt(struct link_util *lu, int argc, char **argv,
-			    struct nlmsghdr *n)
+			    struct nlmsghdr *n, int *netns_fd)
 {
 	__u16 flags = 0;
 	bool mflag_given = false;
diff --git a/ip/iplink_macvlan.c b/ip/iplink_macvlan.c
index 6bdc76d1a700..2d4419c04053 100644
--- a/ip/iplink_macvlan.c
+++ b/ip/iplink_macvlan.c
@@ -75,7 +75,7 @@ static int bclim_arg(const char *arg)
 }
 
 static int macvlan_parse_opt(struct link_util *lu, int argc, char **argv,
-			  struct nlmsghdr *n)
+			     struct nlmsghdr *n, int *netns_fd)
 {
 	__u32 mode = 0;
 	__u16 flags = 0;
diff --git a/ip/iplink_netkit.c b/ip/iplink_netkit.c
index a838a41078f9..e2e6cd2941d1 100644
--- a/ip/iplink_netkit.c
+++ b/ip/iplink_netkit.c
@@ -38,7 +38,7 @@ static void explain(struct link_util *lu, FILE *f)
 }
 
 static int netkit_parse_opt(struct link_util *lu, int argc, char **argv,
-			    struct nlmsghdr *n)
+			    struct nlmsghdr *n, int *netns_fd)
 {
 	__u32 ifi_flags, ifi_change, ifi_index;
 	struct ifinfomsg *ifm, *peer_ifm;
@@ -97,7 +97,8 @@ static int netkit_parse_opt(struct link_util *lu, int argc, char **argv,
 			if (seen_peer) {
 				data = addattr_nest(n, 1024, IFLA_NETKIT_PEER_INFO);
 				n->nlmsg_len += sizeof(struct ifinfomsg);
-				err = iplink_parse(argc, argv, (struct iplink_req *)n, &type);
+				err = iplink_parse(argc, argv, (struct iplink_req *)n, &type,
+						   netns_fd);
 				if (err < 0)
 					return err;
 				if (type)
diff --git a/ip/iplink_rmnet.c b/ip/iplink_rmnet.c
index 1d16440c6900..ca5afe0579ce 100644
--- a/ip/iplink_rmnet.c
+++ b/ip/iplink_rmnet.c
@@ -27,7 +27,7 @@ static void explain(void)
 }
 
 static int rmnet_parse_opt(struct link_util *lu, int argc, char **argv,
-			   struct nlmsghdr *n)
+			   struct nlmsghdr *n, int *netns_fd)
 {
 	__u16 mux_id;
 
diff --git a/ip/iplink_vlan.c b/ip/iplink_vlan.c
index 4ac5bc03f2b3..6d029297da7a 100644
--- a/ip/iplink_vlan.c
+++ b/ip/iplink_vlan.c
@@ -73,7 +73,7 @@ static int vlan_parse_qos_map(int *argcp, char ***argvp, struct nlmsghdr *n,
 }
 
 static int vlan_parse_opt(struct link_util *lu, int argc, char **argv,
-			  struct nlmsghdr *n)
+			  struct nlmsghdr *n, int *netns_fd)
 {
 	struct ifla_vlan_flags flags = { 0 };
 	__u16 id, proto;
diff --git a/ip/iplink_vrf.c b/ip/iplink_vrf.c
index 9474a2b78c5f..ef6a93561abc 100644
--- a/ip/iplink_vrf.c
+++ b/ip/iplink_vrf.c
@@ -26,7 +26,7 @@ static void explain(void)
 }
 
 static int vrf_parse_opt(struct link_util *lu, int argc, char **argv,
-			    struct nlmsghdr *n)
+			 struct nlmsghdr *n, int *netns_fd)
 {
 	while (argc > 0) {
 		if (matches(*argv, "table") == 0) {
diff --git a/ip/iplink_vxcan.c b/ip/iplink_vxcan.c
index e0f9bacbd3db..1154fea9fdb1 100644
--- a/ip/iplink_vxcan.c
+++ b/ip/iplink_vxcan.c
@@ -27,7 +27,7 @@ static void usage(void)
 }
 
 static int vxcan_parse_opt(struct link_util *lu, int argc, char **argv,
-			  struct nlmsghdr *n)
+			   struct nlmsghdr *n, int *netns_fd)
 {
 	char *type = NULL;
 	int err;
@@ -52,7 +52,8 @@ static int vxcan_parse_opt(struct link_util *lu, int argc, char **argv,
 
 	n->nlmsg_len += sizeof(struct ifinfomsg);
 
-	err = iplink_parse(argc - 1, argv + 1, (struct iplink_req *)n, &type);
+	err = iplink_parse(argc - 1, argv + 1, (struct iplink_req *)n, &type,
+			   netns_fd);
 	if (err < 0)
 		return err;
 
diff --git a/ip/iplink_vxlan.c b/ip/iplink_vxlan.c
index 7781d60bbb52..e9e19ef27b43 100644
--- a/ip/iplink_vxlan.c
+++ b/ip/iplink_vxlan.c
@@ -92,7 +92,7 @@ static void check_duparg(__u64 *attrs, int type, const char *key,
 }
 
 static int vxlan_parse_opt(struct link_util *lu, int argc, char **argv,
-			  struct nlmsghdr *n)
+			   struct nlmsghdr *n, int *netns_fd)
 {
 	inet_prefix saddr, daddr;
 	__u32 vni = 0;
diff --git a/ip/iplink_wwan.c b/ip/iplink_wwan.c
index 3510477a16ca..26ad47a3fe87 100644
--- a/ip/iplink_wwan.c
+++ b/ip/iplink_wwan.c
@@ -22,7 +22,7 @@ static void explain(void)
 }
 
 static int wwan_parse_opt(struct link_util *lu, int argc, char **argv,
-			  struct nlmsghdr *n)
+			  struct nlmsghdr *n, int *netns_fd)
 {
 	while (argc > 0) {
 		if (matches(*argv, "linkid") == 0) {
diff --git a/ip/ipmacsec.c b/ip/ipmacsec.c
index fc4c86314fab..f074f7deff87 100644
--- a/ip/ipmacsec.c
+++ b/ip/ipmacsec.c
@@ -1344,7 +1344,7 @@ static void usage(FILE *f)
 }
 
 static int macsec_parse_opt(struct link_util *lu, int argc, char **argv,
-			    struct nlmsghdr *n)
+			    struct nlmsghdr *n, int *netns_fd)
 {
 	int ret;
 	__u8 encoding_sa = 0xff;
diff --git a/ip/link_gre.c b/ip/link_gre.c
index 010b4824b809..d2a45b740cb1 100644
--- a/ip/link_gre.c
+++ b/ip/link_gre.c
@@ -63,7 +63,7 @@ static void gre_print_help(struct link_util *lu, int argc, char **argv, FILE *f)
 }
 
 static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
-			 struct nlmsghdr *n)
+			 struct nlmsghdr *n, int *netns_fd)
 {
 	struct ifinfomsg *ifi = NLMSG_DATA(n);
 	struct {
diff --git a/ip/link_gre6.c b/ip/link_gre6.c
index fc3e35f7e83f..1b6f00c47160 100644
--- a/ip/link_gre6.c
+++ b/ip/link_gre6.c
@@ -66,7 +66,7 @@ static void gre_print_help(struct link_util *lu, int argc, char **argv, FILE *f)
 }
 
 static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
-			 struct nlmsghdr *n)
+			 struct nlmsghdr *n, int *netns_fd)
 {
 	struct ifinfomsg *ifi = NLMSG_DATA(n);
 	struct {
diff --git a/ip/link_ip6tnl.c b/ip/link_ip6tnl.c
index c2a05cee35bb..5b94855be586 100644
--- a/ip/link_ip6tnl.c
+++ b/ip/link_ip6tnl.c
@@ -59,7 +59,7 @@ static void ip6tunnel_print_help(struct link_util *lu, int argc, char **argv,
 }
 
 static int ip6tunnel_parse_opt(struct link_util *lu, int argc, char **argv,
-			       struct nlmsghdr *n)
+			       struct nlmsghdr *n, int *netns_fd)
 {
 	struct ifinfomsg *ifi = NLMSG_DATA(n);
 	struct {
diff --git a/ip/link_iptnl.c b/ip/link_iptnl.c
index 49c3ae2612ca..97922f85a626 100644
--- a/ip/link_iptnl.c
+++ b/ip/link_iptnl.c
@@ -60,7 +60,7 @@ static void iptunnel_print_help(struct link_util *lu, int argc, char **argv,
 }
 
 static int iptunnel_parse_opt(struct link_util *lu, int argc, char **argv,
-			      struct nlmsghdr *n)
+			      struct nlmsghdr *n, int *netns_fd)
 {
 	struct ifinfomsg *ifi = NLMSG_DATA(n);
 	struct {
diff --git a/ip/link_veth.c b/ip/link_veth.c
index 6da5b64f73ce..4c60f7cecb7b 100644
--- a/ip/link_veth.c
+++ b/ip/link_veth.c
@@ -24,7 +24,7 @@ static void usage(void)
 }
 
 static int veth_parse_opt(struct link_util *lu, int argc, char **argv,
-			  struct nlmsghdr *n)
+			  struct nlmsghdr *n, int *netns_fd)
 {
 	char *type = NULL;
 	int err;
@@ -49,7 +49,8 @@ static int veth_parse_opt(struct link_util *lu, int argc, char **argv,
 
 	n->nlmsg_len += sizeof(struct ifinfomsg);
 
-	err = iplink_parse(argc - 1, argv + 1, (struct iplink_req *)n, &type);
+	err = iplink_parse(argc - 1, argv + 1, (struct iplink_req *)n, &type,
+			   netns_fd);
 	if (err < 0)
 		return err;
 
diff --git a/ip/link_vti.c b/ip/link_vti.c
index 2106a9d2cee3..03823528ea38 100644
--- a/ip/link_vti.c
+++ b/ip/link_vti.c
@@ -35,7 +35,7 @@ static void vti_print_help(struct link_util *lu, int argc, char **argv, FILE *f)
 }
 
 static int vti_parse_opt(struct link_util *lu, int argc, char **argv,
-			 struct nlmsghdr *n)
+			 struct nlmsghdr *n, int *netns_fd)
 {
 	struct ifinfomsg *ifi = NLMSG_DATA(n);
 	struct {
diff --git a/ip/link_vti6.c b/ip/link_vti6.c
index 7362f336a895..26dad8c11294 100644
--- a/ip/link_vti6.c
+++ b/ip/link_vti6.c
@@ -37,7 +37,7 @@ static void vti6_print_help(struct link_util *lu, int argc, char **argv,
 }
 
 static int vti6_parse_opt(struct link_util *lu, int argc, char **argv,
-			  struct nlmsghdr *n)
+			  struct nlmsghdr *n, int *netns_fd)
 {
 	struct ifinfomsg *ifi = NLMSG_DATA(n);
 	struct {
diff --git a/ip/link_xfrm.c b/ip/link_xfrm.c
index d76398cd3283..dd96f0504784 100644
--- a/ip/link_xfrm.c
+++ b/ip/link_xfrm.c
@@ -25,7 +25,7 @@ static void xfrm_print_help(struct link_util *lu, int argc, char **argv,
 }
 
 static int xfrm_parse_opt(struct link_util *lu, int argc, char **argv,
-			  struct nlmsghdr *n)
+			  struct nlmsghdr *n, int *netns_fd)
 {
 	unsigned int link = 0;
 	bool metadata = false;
-- 
2.43.1


