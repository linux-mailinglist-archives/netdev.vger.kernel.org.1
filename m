Return-Path: <netdev+bounces-134510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E30999EAC
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E272828D5
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C069A20A5FA;
	Fri, 11 Oct 2024 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQB/cZ3M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF320ADDE
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633697; cv=none; b=H9XeRIug+kxla8CwSlyga7wXsijazHQcqndB492reiGHgOETJE4xdYxyXCgioi8ExoHXkcDbcwK7yAoJnJOgkjpOGyyy6q5Jw4z0/rTsI+6WjpKu1hb1k4wPoIS6fxjeu7FUECoj/y8s1Fgux2l99VjR7ynNEaoi8H/Ju56ZK9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633697; c=relaxed/simple;
	bh=hZc4iccOeziC/FK/ZUoE+bwy6dTziB8ALPcnuzBpoII=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1sUxPng7n4dqit3nxaDKGltsSuPv3OrZlxkkoFM94/KN+MRzxDcxb901isAmptloN9IemtXHasUtFh/eBOZVwsg5qIMLbD8NdzSqPKc1cwt3t385VQ22os68CFHWKI/ABMKtR7zGDRjlM4FE3jfHbD4Nt0eQz4S5t/uxaCvnt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQB/cZ3M; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so1098289a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 01:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728633695; x=1729238495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dxktlx5j7SK3d83gJf5bzIo9DXB971U8e6n2fUHqnc=;
        b=TQB/cZ3MshwUpyl18DeyI6bT3EDNmFLyv/nZvEPBCZHBARWA7alHVcNpvdVz3nwLyY
         /h18av2cOFS8lZsLQaCbwRuWos+VlG7b9Ibzys29SdUo95dURyNoqi2gab+Yx/s7UaVX
         1YiSK7+85/paicIB64USAv5C5jVboOMnDR8AAT4RGPq6Jlp/w4CivRp8pM1gnInLWJ+A
         bEpnQtPZZfwIUeO1KYk2h9IeyKmkL7xsI67NBACYkNrHeJ8VEu26tyUd+QdzOhfQsuDY
         CaR3YpmK6j8E8xJkTuMLuBAwuHmZOiOSuWMSVCnqwbxDLX1VYszAj83UkzeFLWHJ+wKE
         ySpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728633695; x=1729238495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dxktlx5j7SK3d83gJf5bzIo9DXB971U8e6n2fUHqnc=;
        b=fkCj/GBPxLkPxo35kaBJ8lA+Wcn+Yv3F7FwFtNk+ttoocmE4DSpEELQBa5TA0gcMLK
         8G1AdlMtR9ZOzt0+A2rMYqKT5MB+X7Tr2xs3ArwpIf2pDRK+8IIC+kI/nHOdImXMRXgV
         DkihkirV7sTu12U0ipIzdwW81DauxUM2h5YcqVH+kx7+FsinvXMiXtlm2rEDsUtNNheY
         VtDCdHuUgydL9n/Lr/yOuJJIO3ohbqEflaUhIZdDSuW4aH83nNVKJvhr3yfK/Pp/x3J1
         uy51EdrHTXH4KSK8ZSrSGioWgpkKgUDnU6VG/ylN2QUl05J+yenG/2NVSUDSiu0gtItH
         Cd/w==
X-Forwarded-Encrypted: i=1; AJvYcCW0B/7cMSKAJj3kimsIc8Dk+XXzXUz7Kva+F5lZQ8shQItRb60MMiCC4peFPyItm1wUwwRmwCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/d8akWXy1DZTrHMLb/UrY+YMmK2ZaDdR+yaC7vj5svtvov3x
	jDF4cRKfacq1FOlZyAYH8j9JET4EfRvJ9FOIw/N475G6O1/YiaQH1GErfxVZ
X-Google-Smtp-Source: AGHT+IEkulzpPzACP8URla5leVU+Sn/xTzZjKdw+MtO5k6B0mBO3NSZhSUy8J+RHezKHkVyTNjNtAg==
X-Received: by 2002:a05:6a21:118a:b0:1d8:a13d:d6b4 with SMTP id adf61e73a8af0-1d8bcf06da2mr2525108637.4.1728633695135;
        Fri, 11 Oct 2024 01:01:35 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b5dfsm2126908b3a.199.2024.10.11.01.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:01:34 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org
Subject: [PATCH v2 iproute2 2/2] iplink: Fix link-netns id and link ifindex
Date: Fri, 11 Oct 2024 16:01:09 +0800
Message-ID: <20241011080111.387028-3-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011080111.387028-1-shaw.leon@gmail.com>
References: <20241011080111.387028-1-shaw.leon@gmail.com>
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
 1 file changed, 118 insertions(+), 25 deletions(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index c9168985..c2c0e371 100644
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
+	ifindex = ((struct ifinfomsg *)NLMSG_DATA(answer))->ifi_index;
+	free(answer);
+	return ifindex;
+}
+
 static void iplink_parse_vf_vlan_info(int vf, int *argcp, char ***argvp,
 				      struct ifla_vf_vlan_info *ivvip)
 {
@@ -536,7 +568,10 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
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
@@ -618,20 +653,25 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 			if (offload && name == dev)
 				dev = NULL;
 		} else if (strcmp(*argv, "netns") == 0) {
+			int pid;
+
 			NEXT_ARG();
 			if (netns != -1)
 				duparg("netns", *argv);
 			netns = netns_get_fd(*argv);
-			if (netns >= 0) {
-				open_fds_add(netns);
-				addattr_l(&req->n, sizeof(*req), IFLA_NET_NS_FD,
-					  &netns, 4);
+			if (netns < 0 && get_integer(&pid, *argv, 0) == 0) {
+				char path[PATH_MAX];
+
+				snprintf(path, sizeof(path), "/proc/%d/ns/net",
+					 pid);
+				netns = open(path, O_RDONLY);
 			}
-			else if (get_integer(&netns, *argv, 0) == 0)
-				addattr_l(&req->n, sizeof(*req),
-					  IFLA_NET_NS_PID, &netns, 4);
-			else
+			if (netns < 0)
 				invarg("Invalid \"netns\" value\n", *argv);
+
+			open_fds_add(netns);
+			addattr_l(&req->n, sizeof(*req), IFLA_NET_NS_FD,
+				  &netns, 4);
 			move_netns = true;
 		} else if (strcmp(*argv, "multicast") == 0) {
 			NEXT_ARG();
@@ -817,21 +857,12 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
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
@@ -983,6 +1014,53 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
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
@@ -991,8 +1069,10 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
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
@@ -1010,9 +1090,17 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
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
 
@@ -1024,6 +1112,11 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
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
2.47.0


