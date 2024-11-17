Return-Path: <netdev+bounces-145645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FD59D0433
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 15:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA591281FC7
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC4B1CB51F;
	Sun, 17 Nov 2024 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITgHGIIH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE51D31A8
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853026; cv=none; b=BuicVuEnth61/zi9jhh+JoaZGG8e0zryqTr2qlE3C0LhjUZkqwFnsD2SJhoh1wgu8k7E4CSNiLaXESSwuz/NqwBge4cb/yqRUhDhJ66j8iOiNzhHbliegbovci5kNG03faF2ynXwM+cPI/yAZ5L2sWnowDaD2hHWximynHiKMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853026; c=relaxed/simple;
	bh=6vC63aIkUn1OkU4SNt//axZ3I8ZlYXQT1KeLQGC0/5Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mQEXb5d40vidmnWJuoXI5Az7MBFIBf1uPlj2ft8utAp7mHsilNnBeR6OBO62AteXcYr7bHWzjUmIC/cR0kHXE0L4wXma+y9GNFjBtPdHo9FjWoWCGykn/4VAjgFi7E0t6OmsemAxdd7eGRbqTKDT20V6Ygzrngrkv8/InR4Snnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITgHGIIH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e35e9d36da3so5395252276.1
        for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 06:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731853024; x=1732457824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GR6xIYzEWfsMmCNK2+CfVPo1A6vVtMXj+YdcBkG2KUY=;
        b=ITgHGIIHfKk/6MTUVW1MoB3ViFNv7geKNl7mwUXJzbOdFvfG3CRVdwU4PXdU56bsez
         /+r+lAa0+jh5KtJlXKtAfWknnRNOuNcIS6WpnQliKCDEUeDNJQ/jENHDfsrwiXoL+NNL
         HlCIoGMLvKK8Jbx2IiXe/PNfEVfiqSeN8U0IAS3htIj+uRI7u99XDE1lSes8+AmlIa7P
         mf920sA5ystlxISZSiMekyGUr7DicRYiwydVsupoHTtJMm+KYCsp9wFPzszhzl4ov+iu
         ka0E8KeHHYkQFsuoYXO4ItmYUVnhwmaMU7laWSz0tao+Ua/jhAXFIcLr6dPi8sPnRbmk
         rkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731853024; x=1732457824;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR6xIYzEWfsMmCNK2+CfVPo1A6vVtMXj+YdcBkG2KUY=;
        b=hto04u3mWYAq8g3ZM6iLO6cfA9tfuayr1umuBWfX/W1mBaR8T5yyB4SUGQWFP/81s8
         QPwEe4GsIYR83BzgwZ6VGeN/MNITj+0phiHUhkGW0lTkMdq5CmKOZxb9xAmi5dZfE8wP
         18QHH534Y6TNgijwsKdJ/T6tHa+t/fEW4B3OUmgR87owejvHJ/9gk8pemXszLS+aLNxr
         C4AWZWs8a1uIDyT0UBHYGlffZNRr/hywd1ZLfzSxqjy6wFHdVisCEt67PYjeDDC1Mp5x
         8zrrwJMSphgREKl+GqcCxBLo9w/M80PblLYI5rasXchC0qjQVtq12NFCLHcFF745pJB2
         daow==
X-Forwarded-Encrypted: i=1; AJvYcCWuc7W5v//rC4cVCOLHN7IoTHZ/Yrk0grlkIzlpC8LJ+ecBoPOZvZuBXTgMCIoI8+exT9E5Yks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nxYpEK44xLscDatO8igkVD3F/cope6lLOaQXr4PmHilAjWHA
	lc2ddEli9kbYE/Fw6zk5yuA36MZyoipqFnT8ZO5LOb5FRcsQEngS1zrKVWVfNnlSLa92Pxh2EGE
	zdEkFJVmVNODRuHwUjFpn4w==
X-Google-Smtp-Source: AGHT+IFXmZGxihNiA2gwPzTqRvFnvv/SpT8DMOwFLMX4bZ0vaqADDvJcmobKvkDhZN/8ezi3Rpcn3qRQUZPXQDaZlg==
X-Received: from yuyanghuang.tok.corp.google.com ([2401:fa00:8f:203:ad20:df6a:3bc0:bc2d])
 (user=yuyanghuang job=sendgmr) by 2002:a25:ae9f:0:b0:e30:c868:1eba with SMTP
 id 3f1490d57ef6-e3825d252eemr201206276.2.1731853023808; Sun, 17 Nov 2024
 06:17:03 -0800 (PST)
Date: Sun, 17 Nov 2024 23:16:55 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241117141655.2078777-1-yuyanghuang@google.com>
Subject: [PATCH iproute2-next] iproute2: add 'ip monitor mcaddr' support
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com, 
	liuhangbin@gmail.com, nicolas.dichtel@6wind.com, andrew@lunn.ch, 
	netdev@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Enhanced the 'ip monitor' command to track changes in IPv4 and IPv6
multicast addresses. This update allows the command to listen for
events related to multicast address additions and deletions by
registering to the newly introduced RTNLGRP_IPV4_MCADDR and
RTNLGRP_IPV6_MCADDR netlink groups.

This patch depends on the kernel patch that adds RTNLGRP_IPV4_MCADDR
and RTNLGRP_IPV6_MCADDR being merged first.

Here is an example usage:

root@uml-x86-64:/# ip monitor mcaddr
8: nettest123    inet6 mcast ff01::1 scope global
8: nettest123    inet6 mcast ff02::1 scope global
8: nettest123    inet mcast 224.0.0.1 scope link
8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
Deleted 8: nettest123    inet mcast 224.0.0.1 scope link
Deleted 8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
Deleted 8: nettest123    inet6 mcast ff02::1 scope global

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 include/uapi/linux/rtnetlink.h |  8 ++++++++
 ip/ipaddress.c                 | 17 +++++++++++++++--
 ip/ipmonitor.c                 | 25 ++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.=
h
index 4e6c8e14..ccf26bf1 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -93,6 +93,10 @@ enum {
 	RTM_NEWPREFIX	=3D 52,
 #define RTM_NEWPREFIX	RTM_NEWPREFIX
=20
+	RTM_NEWMULTICAST,
+#define RTM_NEWMULTICAST RTM_NEWMULTICAST
+	RTM_DELMULTICAST,
+#define RTM_DELMULTICAST RTM_DELMULTICAST
 	RTM_GETMULTICAST =3D 58,
 #define RTM_GETMULTICAST RTM_GETMULTICAST
=20
@@ -772,6 +776,10 @@ enum rtnetlink_groups {
 #define RTNLGRP_TUNNEL		RTNLGRP_TUNNEL
 	RTNLGRP_STATS,
 #define RTNLGRP_STATS		RTNLGRP_STATS
+	RTNLGRP_IPV4_MCADDR,
+#define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
+	RTNLGRP_IPV6_MCADDR,
+#define RTNLGRP_IPV6_MCADDR    RTNLGRP_IPV6_MCADDR
 	__RTNLGRP_MAX
 };
 #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)
diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index d90ba94d..373f613f 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -1504,7 +1504,10 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
=20
 	SPRINT_BUF(b1);
=20
-	if (n->nlmsg_type !=3D RTM_NEWADDR && n->nlmsg_type !=3D RTM_DELADDR)
+	if (n->nlmsg_type !=3D RTM_NEWADDR
+	    && n->nlmsg_type !=3D RTM_DELADDR
+	    && n->nlmsg_type !=3D RTM_NEWMULTICAST
+	    && n->nlmsg_type !=3D RTM_DELMULTICAST)
 		return 0;
 	len -=3D NLMSG_LENGTH(sizeof(*ifa));
 	if (len < 0) {
@@ -1564,7 +1567,7 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
=20
 	print_headers(fp, "[ADDR]");
=20
-	if (n->nlmsg_type =3D=3D RTM_DELADDR)
+	if (n->nlmsg_type =3D=3D RTM_DELADDR || n->nlmsg_type =3D=3D RTM_DELMULTI=
CAST)
 		print_bool(PRINT_ANY, "deleted", "Deleted ", true);
=20
 	if (!brief) {
@@ -1639,6 +1642,16 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
 						   rta_tb[IFA_ANYCAST]));
 	}
=20
+	if (rta_tb[IFA_MULTICAST]) {
+		print_string(PRINT_FP, NULL, "%s ", "mcast");
+		print_color_string(PRINT_ANY,
+				   ifa_family_color(ifa->ifa_family),
+				   "multicast",
+				   "%s ",
+				   format_host_rta(ifa->ifa_family,
+						   rta_tb[IFA_MULTICAST]));
+	}
+
 	print_string(PRINT_ANY,
 		     "scope",
 		     "scope %s ",
diff --git a/ip/ipmonitor.c b/ip/ipmonitor.c
index de67f2c9..3690515d 100644
--- a/ip/ipmonitor.c
+++ b/ip/ipmonitor.c
@@ -30,7 +30,7 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage: ip monitor [ all | OBJECTS ] [ FILE ] [ label ] [ all-nsid ]\n"
 		"                  [ dev DEVICE ]\n"
-		"OBJECTS :=3D  address | link | mroute | neigh | netconf |\n"
+		"OBJECTS :=3D  address | link | mroute | mcaddr | neigh | netconf |\n"
 		"            nexthop | nsid | prefix | route | rule | stats\n"
 		"FILE :=3D file FILENAME\n");
 	exit(-1);
@@ -152,6 +152,11 @@ static int accept_msg(struct rtnl_ctrl_data *ctrl,
 		ipstats_print(n, arg);
 		return 0;
=20
+	case RTM_DELMULTICAST:
+	case RTM_NEWMULTICAST:
+		print_addrinfo(n, arg);
+		return 0;
+
 	case NLMSG_ERROR:
 	case NLMSG_NOOP:
 	case NLMSG_DONE:
@@ -178,6 +183,7 @@ static int accept_msg(struct rtnl_ctrl_data *ctrl,
 #define IPMON_LRULE		BIT(8)
 #define IPMON_LNSID		BIT(9)
 #define IPMON_LNEXTHOP		BIT(10)
+#define IPMON_LMCADDR		BIT(11)
=20
 #define IPMON_L_ALL		(~0)
=20
@@ -220,6 +226,8 @@ int do_ipmonitor(int argc, char **argv)
 			lmask |=3D IPMON_LNEXTHOP;
 		} else if (strcmp(*argv, "stats") =3D=3D 0) {
 			lmask |=3D IPMON_LSTATS;
+		} else if (strcmp(*argv, "mcaddr") =3D=3D 0) {
+			lmask |=3D IPMON_LMCADDR;
 		} else if (strcmp(*argv, "all") =3D=3D 0) {
 			prefix_banner =3D 1;
 		} else if (matches(*argv, "all-nsid") =3D=3D 0) {
@@ -326,6 +334,21 @@ int do_ipmonitor(int argc, char **argv)
 		exit(1);
 	}
=20
+	if (lmask & IPMON_LMCADDR) {
+		if ((!preferred_family || preferred_family =3D=3D AF_INET) &&
+			rtnl_add_nl_group(&rth, RTNLGRP_IPV4_MCADDR) < 0) {
+			fprintf(stderr,
+				"Failed to add ipv4 mcaddr group to list\n");
+			exit(1);
+		}
+		if ((!preferred_family || preferred_family =3D=3D AF_INET6) &&
+			rtnl_add_nl_group(&rth, RTNLGRP_IPV6_MCADDR) < 0) {
+			fprintf(stderr,
+				"Failed to add ipv6 mcaddr group to list\n");
+			exit(1);
+		}
+	}
+
 	if (listen_all_nsid && rtnl_listen_all_nsid(&rth) < 0)
 		exit(1);
=20
--=20
2.47.0.338.g60cca15819-goog


