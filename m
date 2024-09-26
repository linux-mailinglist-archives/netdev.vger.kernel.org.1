Return-Path: <netdev+bounces-129898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E498986F20
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF00DB21A7C
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 08:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3451A7260;
	Thu, 26 Sep 2024 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGrWXqv7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C81A706D
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340245; cv=none; b=TCR1R7vVS5LgCWp2a4go9bMf3drHbv4BkvPJQmtY75wSqwoj99KMrad06mlinnmtl6Gr3vkmkEliP5rJxgDeiFPRY3biF1d+G6MIcIbrhppfKL782kU2oXtbpzf+TWNMHNbiR1QPJgPADpipIjKCAZSMGq/eij9goDQ3S+YjVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340245; c=relaxed/simple;
	bh=Bmyp04RcVzf6Hq3YStrF+QLUZ7qU9TwnwthI3fYtCUI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwogpyGtgm4Ym9vw9/MmGaDbVQ1fNaAT7362h/FhOvSDpAQwXkcm4Qlam9jZ3Lb5uDXUIh4cTGl0pNGQHq+E9oEVKynSbej1+IigRD6SrssKHRrTHGuEvYOdHwbz2jgIalwgNjIhGbcgdkT80ocNKpNXTN9AUK3mZWiTPpeveQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGrWXqv7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71b0722f221so572157b3a.3
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727340243; x=1727945043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxVjn5t56zA9a6EAuFRO/uy4lNosCb/qPAWhgZ4PzS0=;
        b=QGrWXqv7wNCwM4LcvtkMnqtk976UM203zNbD5M5Z/IY1i0P2KXsDKZ2ibHbHArsXFk
         9HofyhGHroxBKk7JeQaHZeXWDBbjcxzKykkZkD/KAm/Jhzm0JnkUGlpJILNRlgA5g4CD
         PqI1AJGdLeu1PGo8eqY1sOGN+E9PIe0UJgDGUgbgE5UFECOG3Vmbe5sJcNWFgm3c0gG7
         bT785Ei8i8fOAAnmOymxRb1hP/fSjHMzZZ7xLc/3ob8UmWTXCDyoDSb5gRKmb/kwwc9R
         tGE4nfFT6/iYEG0C7oWHP8GaX7mABl/m8Rft/VqjUZHt+Vy6+hbHJLprj4RLm3T+2Y02
         hHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727340243; x=1727945043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxVjn5t56zA9a6EAuFRO/uy4lNosCb/qPAWhgZ4PzS0=;
        b=qxqk4jNapkEK+ROgvmLDaxM1z/cfZ1e+4XO7JhDaR1jljP+d3yZl+ymSkjaMHrgMae
         sK8TcbwvONXkgGGKssg9zPJp1j+KYIwE+z7RBUCWrRsOrRKdWII/OwNIzbU5lvJUdUih
         9SBTDroIdPKdWTxn5Qf83E2djcsYbFv5RENUZibnLJWmxEHFy3ETa0JbJ8DXT6+5PFEY
         KWEAISaQ4DwDCmuKuDtmCcS8PN5TvalSVz/owOkvTIJhkqKj3tbvKtG/poZ1B/ANuLNC
         j1Vxmk+8d5znv+Bt6msAfn2fVNxZyGR+hQl4Sly/Eq1KvD57wNwFNqsS+C7/Blce3xZg
         5UAA==
X-Forwarded-Encrypted: i=1; AJvYcCX4GCl6D/9CR1+TY2kHV/3K/VfqdAHt/jPOTCccW4I5ho28rCUMFWvinUyZHu8lERBPiZXZm5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+zcGfgEPdaZPlvRp2zApLE+Acblpzhlk7xsgTweJQi9zAv4A6
	gZFjqENpOcQ05+3pPWTrqtkm+uYeaGXLDhqCTgcyKWZDgwEnnQJSL2z8Il41
X-Google-Smtp-Source: AGHT+IG5ROEK5AGfu6SA7/0f4Wd1262BM+WnVtpYnSvZ29Qza0wH6T8DzGxFshxy9pCxESYTbA5LIQ==
X-Received: by 2002:a05:6a00:8a81:b0:717:9754:4ade with SMTP id d2e1a72fcca58-71b0ac43ebamr5284076b3a.22.1727340242684;
        Thu, 26 Sep 2024 01:44:02 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc93903asm3875888b3a.113.2024.09.26.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:44:02 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 2/2] iplink: Fix link-netns id and link ifindex
Date: Thu, 26 Sep 2024 16:43:40 +0800
Message-ID: <20240926084344.740434-3-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240926084344.740434-1-shaw.leon@gmail.com>
References: <20240926084344.740434-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When link-netns or link-netnsid is supplied, lookup link in that netns.
And if both netns and link-netns are given, IFLA_LINK_NETNSID should be
the nsid of link-netns from the view of target netns, not from current
one.

For example, when handling:

    # ip -n ns1 link add netns ns2 link-netns ns3 link eth1 eth1.100 type vlan id 100

should lookup eth1 in ns3 and IFLA_LINK_NETNSID is the id of ns3 from
ns2.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 ip/iplink.c | 143 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 119 insertions(+), 24 deletions(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index fd7fc44a..d46338e2 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -240,6 +240,38 @@ static int nl_get_ll_addr_len(const char *ifname)
 	return len;
 }
 
+static int get_ifindex_in_netns(struct rtnl_handle *rtnl, int netnsid,
+				const char *ifname)
+{
+	struct {
+		struct nlmsghdr		n;
+		struct ifinfomsg	ifm;
+		char			buf[1024];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.n.nlmsg_type = RTM_GETLINK,
+	};
+	struct nlmsghdr *answer;
+	int ifindex;
+
+	addattr32(&req.n, sizeof(req), IFLA_TARGET_NETNSID, netnsid);
+	addattr_l(&req.n, sizeof(req),
+		  !check_ifname(ifname) ? IFLA_IFNAME : IFLA_ALT_IFNAME,
+		  ifname, strlen(ifname) + 1);
+
+	if (rtnl_talk(rtnl, &req.n, &answer) < 0)
+		return 0;
+
+	if (answer->nlmsg_len < NLMSG_LENGTH(sizeof(struct ifinfomsg))) {
+		free(answer);
+		return 0;
+	}
+	ifindex = ((struct ifinfomsg *)NLMSG_DATA(answer)) -> ifi_index;
+	free(answer);
+	return ifindex;
+}
+
 static void iplink_parse_vf_vlan_info(int vf, int *argcp, char ***argvp,
 				      struct ifla_vf_vlan_info *ivvip)
 {
@@ -536,12 +568,16 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 	int vf = -1;
 	int numtxqueues = -1;
 	int numrxqueues = -1;
+	char *link_netns = NULL;
 	int link_netnsid = -1;
+	struct rtnl_handle netns_rtnl;
+	struct rtnl_handle *rtnl = &rth;
 	int index = 0;
 	int group = -1;
 	int addr_len = 0;
 	int err;
 
+
 	ret = argc;
 
 	while (argc > 0) {
@@ -618,18 +654,24 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 			if (offload && name == dev)
 				dev = NULL;
 		} else if (strcmp(*argv, "netns") == 0) {
+			int pid;
+
 			NEXT_ARG();
 			if (netns != -1)
 				duparg("netns", *argv);
 			netns = netns_get_fd(*argv);
-			if (netns >= 0)
-				addattr_l(&req->n, sizeof(*req), IFLA_NET_NS_FD,
-					  &netns, 4);
-			else if (get_integer(&netns, *argv, 0) == 0)
-				addattr_l(&req->n, sizeof(*req),
-					  IFLA_NET_NS_PID, &netns, 4);
-			else
+			if (netns < 0 && get_integer(&pid, *argv, 0) == 0) {
+				char path[PATH_MAX];
+
+				snprintf(path, sizeof(path), "/proc/%d/ns/net",
+					 pid);
+				netns = open(path, O_RDONLY);
+			}
+			if (netns < 0)
 				invarg("Invalid \"netns\" value\n", *argv);
+
+			addattr_l(&req->n, sizeof(*req), IFLA_NET_NS_FD,
+				  &netns, 4);
 			move_netns = true;
 		} else if (strcmp(*argv, "multicast") == 0) {
 			NEXT_ARG();
@@ -815,21 +857,12 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 			addattr_nest_end(&req->n, afs);
 		} else if (matches(*argv, "link-netns") == 0) {
 			NEXT_ARG();
-			if (link_netnsid != -1)
+			if (link_netnsid != -1 || link_netns)
 				duparg("link-netns/link-netnsid", *argv);
-			link_netnsid = netns_id_from_name(&rth, *argv);
-			/* No nsid? Try to assign one. */
-			if (link_netnsid < 0)
-				set_netns_id_from_name(&rth, *argv, -1);
-			link_netnsid = netns_id_from_name(&rth, *argv);
-			if (link_netnsid < 0)
-				invarg("Invalid \"link-netns\" value\n",
-				       *argv);
-			addattr32(&req->n, sizeof(*req), IFLA_LINK_NETNSID,
-				  link_netnsid);
+			link_netns = *argv;
 		} else if (matches(*argv, "link-netnsid") == 0) {
 			NEXT_ARG();
-			if (link_netnsid != -1)
+			if (link_netnsid != -1 || link_netns)
 				duparg("link-netns/link-netnsid", *argv);
 			if (get_integer(&link_netnsid, *argv, 0))
 				invarg("Invalid \"link-netnsid\" value\n",
@@ -981,6 +1014,53 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 		}
 	}
 
+	if (netns != -1 && (link_netnsid != -1 || link_netns)) {
+		int orig_netns;
+
+		/*
+		 * When both link-netns and netns are set, open an RTNL in
+		 * target netns, to
+		 *   1) get link-netns id from the view of target netns, and
+		 *   2) get link ifindex from link-netns.
+		 */
+		orig_netns = open("/proc/self/ns/net", O_RDONLY);
+		if (orig_netns == -1) {
+			fprintf(stderr, "Cannot open namespace: %s\n",
+				strerror(errno));
+			exit(-1);
+		}
+		if (setns(netns, CLONE_NEWNET) < 0) {
+			fprintf(stderr, "Cannot set namespace: %s\n",
+				strerror(errno));
+			exit(-1);
+		}
+		if (rtnl_open(&netns_rtnl, 0) < 0) {
+			fprintf(stderr, "Cannot open rtnetlink\n");
+			exit(-1);
+		}
+		if (setns(orig_netns, CLONE_NEWNET) < 0) {
+			fprintf(stderr, "Cannot set namespace: %s\n",
+				strerror(errno));
+			exit(-1);
+		}
+		close(orig_netns);
+		rtnl = &netns_rtnl;
+	}
+
+	if (link_netns) {
+		link_netnsid = netns_id_from_name(rtnl, link_netns);
+		/* No nsid? Try to assign one. */
+		if (link_netnsid < 0) {
+			set_netns_id_from_name(rtnl, link_netns, -1);
+			link_netnsid = netns_id_from_name(rtnl, link_netns);
+		}
+		if (link_netnsid < 0)
+			invarg("Invalid \"link-netns\" value\n",
+			       *argv);
+		addattr32(&req->n, sizeof(*req), IFLA_LINK_NETNSID,
+			  link_netnsid);
+	}
+
 	if (!(req->n.nlmsg_flags & NLM_F_CREATE)) {
 		if (!dev) {
 			fprintf(stderr,
@@ -989,8 +1069,10 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 		}
 
 		req->i.ifi_index = ll_name_to_index(dev);
-		if (!req->i.ifi_index)
-			return nodev(dev);
+		if (!req->i.ifi_index) {
+			ret = nodev(dev);
+			goto out;
+		}
 
 		/* Not renaming to the same name */
 		if (name == dev)
@@ -1008,9 +1090,17 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 		if (link) {
 			int ifindex;
 
-			ifindex = ll_name_to_index(link);
-			if (!ifindex)
-				return nodev(link);
+			if (link_netnsid == -1)
+				ifindex = ll_name_to_index(link);
+			else
+				ifindex = get_ifindex_in_netns(rtnl,
+							       link_netnsid,
+							       link);
+
+			if (!ifindex) {
+				ret = nodev(link);
+				goto out;
+			}
 			addattr32(&req->n, sizeof(*req), IFLA_LINK, ifindex);
 		}
 
@@ -1022,6 +1112,11 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 			  IFLA_IFNAME, name, strlen(name) + 1);
 	}
 
+out:
+	if (rtnl == &netns_rtnl) {
+		rtnl_close(rtnl);
+	}
+
 	return ret;
 }
 
-- 
2.46.2


