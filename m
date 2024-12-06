Return-Path: <netdev+bounces-149718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842299E6E8C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C523D188677A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536402066EC;
	Fri,  6 Dec 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="deuNbvJG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988902066DF
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489167; cv=none; b=QdvtXdUA0EFsaF6UkskeTcyT4+S6x5aLvK38M58KQW45JHQQQtlezmZMtaSKYVJ9JRla/GN3Gn9QOZ66+gOxHPzll1kwgY8vJSdZniD7ljXgDW8xBuAx8O0tqSL9hVa54PUUhmDbu9ypFo180FjWL5qAVBI6gjlVNOdu9wAcilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489167; c=relaxed/simple;
	bh=E0ugjVuZL+e/brxaVlQMiBGQsJRKtvhaVYwOgFd0MDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pVhY/+dumb2YhJLzaMUnd8+QJhSpR6zcRGM8iJHtangWXSbSeCC5xIQEdn5gw0w5vdnnSci4VONHfGsyo6fn1lX3v3OHoNN1mxnj+ZmGQ2BuPgIIH9KBwzTBYIKQ86FpGBUseiZmrZl5oqQKwolL2FliV+o4llXkvMiShAs1NjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=deuNbvJG; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7f72112de23so1450980a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 04:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733489165; x=1734093965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kTFHzK1eep9BLyZk/fJs/6IZ4S2YrFlaQS83bWBwPE=;
        b=deuNbvJGHkvWa2EEFXM7iel42T/R+zw4JuaeTY0eM2UoR3+kDW4yQY+TimIknlr/ke
         ON/hOFJSif8Q1i99kwtaRhmSqEms+8Ua7r6x15kytQXNeS151Y7bRCH+gq1A1srW3Sv9
         xsQ5E91g2xEF9p8GTALHS+IJCqsAxolPnK/RzJiH2v0ZEkY5g61RxmWcGZMoDNjy07N0
         yDVnDQA7l29YGsxlAua5Am4uzaMQkE47fvk8R9G2ddZHdY4yqlaZLbChU2r0oFg9VClx
         jf9YMPR/1UDnsB3z5PywT0AgMgYmiNIU78O3s3+1rcebmTBoS+7nP6s6dCrOc/zIZa5i
         YdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733489165; x=1734093965;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/kTFHzK1eep9BLyZk/fJs/6IZ4S2YrFlaQS83bWBwPE=;
        b=wDL65Bu4kNgB3bxDTMNABkaT0bM+aFCn3S796l+Z6wNWBl1ZAr55VKg2SnME37uI3E
         lj1qHcAvp848ORzZ//iQ82KqomwkofUWY1zWnReVi6BA+VwhnH32RYIF67I3ZlLH09Dz
         z4q1Dauy4kwigchwG5xqcakXe0vtHeXK78dVXhfNukSC1L5nD2cQ/HLkHruASlPp8vP5
         TEmX7JOmgjrXUuLAfa3KhACMtqsWbKWyFOA/tmNl7NI9ZTVto9dl2CTCiQlaL6qf82JD
         ZkL/BoLQznqsf11pCbrGJ1HSZHKO2gkfI3RTymsbM6SiT8llDqObf/MUp8ejLYUUJ4y8
         5aPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHU47AkFlTboczsPR1kKUD2Zh764welvUoCOjsvcx9gBOmuj9lzhtmPR21xPYx5IL0wE0wgU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8t4f3aBtHUVoCwIUgQHZZ180T75uDiRdRheFxJOOvV5rndDo
	IGXn4CIXhZcYbXR1smpQ5ZLQHUsEvEieoqKBB5lcH6/7/gaBZMwCbMd+Debq614QvvXO6J4/pqM
	kIhmmyX4MrzBiAhbNRa4AYg==
X-Google-Smtp-Source: AGHT+IESHISnuabBDgjJWu+PJp3VLTzFBuxX+P2iAerhu9lR8ExoxYc2gfkSqjelYz2XsWg3u9i6zqP7dKnB0wbbLw==
X-Received: from pgbfm24.prod.google.com ([2002:a05:6a02:4998:b0:7fc:2c85:2d52])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:734f:b0:1d9:3acf:8bdc with SMTP id adf61e73a8af0-1e187151d84mr4779577637.46.1733489164918;
 Fri, 06 Dec 2024 04:46:04 -0800 (PST)
Date: Fri,  6 Dec 2024 21:45:54 +0900
In-Reply-To: <20241206124554.355503-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206124554.355503-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206124554.355503-2-yuyanghuang@google.com>
Subject: [PATCH iproute2-next, v4 2/2] iproute2: add 'ip monitor maddr' support
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

root@uml-x86-64:/# ip monitor maddr
8: nettest123    inet6 mcast ff01::1 scope global
8: nettest123    inet6 mcast ff02::1 scope global
8: nettest123    inet mcast 224.0.0.1 scope global
8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
Deleted 8: nettest123    inet mcast 224.0.0.1 scope global
Deleted 8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
Deleted 8: nettest123    inet6 mcast ff02::1 scope global

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v3:
- Update man/man8/ip-monitor.8 page.
- Use 'ip monitor maddr' for naming consistency with 'ip maddr' command.

Changelog since v1:
- Move the UAPI constants to a separate patch.
- Update the commit message.
- Fix the indentation format.

 ip/ipaddress.c        | 17 +++++++++++++++--
 ip/ipmonitor.c        | 25 ++++++++++++++++++++++++-
 man/man8/ip-monitor.8 |  2 +-
 3 files changed, 40 insertions(+), 4 deletions(-)

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
index de67f2c9..beefba4a 100644
--- a/ip/ipmonitor.c
+++ b/ip/ipmonitor.c
@@ -30,7 +30,7 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage: ip monitor [ all | OBJECTS ] [ FILE ] [ label ] [ all-nsid ]\n"
 		"                  [ dev DEVICE ]\n"
-		"OBJECTS :=3D  address | link | mroute | neigh | netconf |\n"
+		"OBJECTS :=3D  address | link | mroute | maddr | neigh | netconf |\n"
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
+#define IPMON_LMADDR		BIT(11)
=20
 #define IPMON_L_ALL		(~0)
=20
@@ -220,6 +226,8 @@ int do_ipmonitor(int argc, char **argv)
 			lmask |=3D IPMON_LNEXTHOP;
 		} else if (strcmp(*argv, "stats") =3D=3D 0) {
 			lmask |=3D IPMON_LSTATS;
+		} else if (strcmp(*argv, "maddr") =3D=3D 0) {
+			lmask |=3D IPMON_LMADDR;
 		} else if (strcmp(*argv, "all") =3D=3D 0) {
 			prefix_banner =3D 1;
 		} else if (matches(*argv, "all-nsid") =3D=3D 0) {
@@ -326,6 +334,21 @@ int do_ipmonitor(int argc, char **argv)
 		exit(1);
 	}
=20
+	if (lmask & IPMON_LMADDR) {
+		if ((!preferred_family || preferred_family =3D=3D AF_INET) &&
+		    rtnl_add_nl_group(&rth, RTNLGRP_IPV4_MCADDR) < 0) {
+			fprintf(stderr,
+				"Failed to add ipv4 mcaddr group to list\n");
+			exit(1);
+		}
+		if ((!preferred_family || preferred_family =3D=3D AF_INET6) &&
+		    rtnl_add_nl_group(&rth, RTNLGRP_IPV6_MCADDR) < 0) {
+			fprintf(stderr,
+				"Failed to add ipv6 mcaddr group to list\n");
+			exit(1);
+		}
+	}
+
 	if (listen_all_nsid && rtnl_listen_all_nsid(&rth) < 0)
 		exit(1);
=20
diff --git a/man/man8/ip-monitor.8 b/man/man8/ip-monitor.8
index ec033c69..076e4a11 100644
--- a/man/man8/ip-monitor.8
+++ b/man/man8/ip-monitor.8
@@ -54,7 +54,7 @@ command is the first in the command line and then the obj=
ect list follows:
 .I OBJECT-LIST
 is the list of object types that we want to monitor.
 It may contain
-.BR link ", " address ", " route ", " mroute ", " prefix ", "
+.BR link ", " address ", " route ", " mroute ", " maddr ", " prefix ", "
 .BR neigh ", " netconf ", "  rule ", " stats ", " nsid " and " nexthop "."
 If no
 .B file
--=20
2.47.0.338.g60cca15819-goog


