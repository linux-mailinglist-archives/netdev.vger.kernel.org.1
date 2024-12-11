Return-Path: <netdev+bounces-151024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219AD9EC70D
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6B5188C182
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CB01D7E57;
	Wed, 11 Dec 2024 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4zUZC+lE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3BB1D6194
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905504; cv=none; b=hVuQI9W17WBx9Lq2AHa+UJd1/nEtCYJeermOvG8TwJ0H4PgR3uXVu8j724X3NgSVoB7tdZvoc3upjwLXHWxbU7FqWWeb+jEpq2CeIPkIsUijsTPcSOS8r44M88NxFXYbm88qQFTjfbuka/H3/P5YkrSwLqe+tiy/gYoVeVxi73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905504; c=relaxed/simple;
	bh=KpypP8jfdcT5H9t7MQBkl87Jf+bFiVQuFDsZY/s2u9Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u3C81hW30GAurr7zHe20aZxLU4kcPip7rYUUvvNtc5GBkHQgEi9+jKpExKga9vnNAkuVUMI6D4LzRiBuN88HLGlna05ucXIlyuQaUmhcfGscP8O96hE1nApthMfUoxNGV3ALOFnOUprDyhP1hHSt9eWSLIcLQd4YaXz/oDMCPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4zUZC+lE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-72726ced3f3so2241689b3a.2
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 00:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733905502; x=1734510302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXzVO7EBUGo8DViGVDs1gG/V7NgMFoaYUtCIjwyiqOo=;
        b=4zUZC+lElu+Pf1kA8pPT7LF4XEfGQpuKtTt0IengF2pHYmxIMdkkVmpRSNEjVs7jNS
         d58cibpe3OYLmea+yk6cdD7qC/0wB7ho0ETQMKRkjLbT5KJ1DanrdPGO0htmxlFCsI4B
         eFTVhiXNkO0SpH6TWAas9sfZT3q1A87nnmisXnI04XbpKmTA5asBkSIrDXFBEs1aJjFT
         kr0ufkZgsC2X952TimRb8e7zjYFd6xVBKvntPHKY4PBsgXv6dZZH2D28FVwSeg6aq0OO
         PQXcCf/wOWf9N9jiQOYa87BKdVyB1+xqhIsu8nJyO0OrpaKueZgioMXWZ1BC4azX1iVO
         Hv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905502; x=1734510302;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GXzVO7EBUGo8DViGVDs1gG/V7NgMFoaYUtCIjwyiqOo=;
        b=raywjk63RLViOEcpc0Dq7xDOPQ//gb1oSCiZfk96dOS6ZvbnkRPVZbCOFBcFU91pDD
         zY7SDy3Jp6V1lRpJ/qUGnCfJN1Em/ZswWC/VJU60XhxvqXp6ztThRLPu+sn+Gug1VvAm
         qYEeyT3p48Xnp76M5CFLd6uQSqYjxUDBmNCw4OqdHxquu1CTCDKrnbHFJ9VQf1v3lTGw
         68TY3244OTxs9l7ekUz/PtWgnZ2XQcVTx45SVzwMVtUY+rz7++WhHLc5v77h9RDh0ODG
         BEyXrAu3nf8cwfApjW0VtXAiWaI4bEoIy63MEo6+S5hDpbGiSM4MMQlSaxfBw6ztAdEJ
         0SCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsQmx/BHRyMpS43oCeVAc4HRjPS7oekClqszZnHdDYgV3SGFYxr/VH+Gpcy5Kfj4oSEeVHl7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YycHsoQ183qybcBv51pqy69dq67JtXgjXlmT4I+othxniCG5qaq
	KmFCXNiHl0HwIbdmMdPv0gM8lwzu8Wmn4yI2+FLxu7lWn3fMf5r3kITTWtSVD4rW6/PjTjUB1Ta
	q6xT7q/zeVR2z+LKOObgjzg==
X-Google-Smtp-Source: AGHT+IExNm/6vTJNv3G3nV2Qm49caqqbwaGOw+C4aXxC77oa2BbmF+etj57Sj5tSvPt8PzffZUFWNOVATMcgxXKiOg==
X-Received: from pfbc4.prod.google.com ([2002:a05:6a00:ad04:b0:727:3b66:ace])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2284:b0:725:e73c:c415 with SMTP id d2e1a72fcca58-728ed48a02cmr2945495b3a.18.1733905502164;
 Wed, 11 Dec 2024 00:25:02 -0800 (PST)
Date: Wed, 11 Dec 2024 17:24:53 +0900
In-Reply-To: <20241211082453.3374737-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211082453.3374737-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241211082453.3374737-2-yuyanghuang@google.com>
Subject: [PATCH iproute2-next, v6 2/2] iproute2: add 'ip monitor maddress' support
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

root@uml-x86-64:/# ip monitor maddress
9: nettest123    inet6 mcast ff01::1 scope global
       valid_lft forever preferred_lft forever
9: nettest123    inet6 mcast ff02::1 scope global
       valid_lft forever preferred_lft forever
9: nettest123    inet mcast 224.0.0.1 scope global
       valid_lft forever preferred_lft forever
9: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
       valid_lft forever preferred_lft forever
Deleted 9: nettest123    inet mcast 224.0.0.1 scope global
       valid_lft forever preferred_lft forever
Deleted 9: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
       valid_lft forever preferred_lft forever
Deleted 9: nettest123    inet6 mcast ff02::1 scope global
       valid_lft forever preferred_lft forever

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v5:
- Revise the commit message example to align with the recent kernel notific=
ation
  patch updates.

Changelog since v4:
- To match the existing code style, move the boolean operator to the end of=
 the
  line.
- To match the existing naming pattern, use 'maddress' instead of 'maddr'.

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
index d90ba94d..679b4c00 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -1504,7 +1504,10 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
=20
 	SPRINT_BUF(b1);
=20
-	if (n->nlmsg_type !=3D RTM_NEWADDR && n->nlmsg_type !=3D RTM_DELADDR)
+	if (n->nlmsg_type !=3D RTM_NEWADDR &&
+	    n->nlmsg_type !=3D RTM_DELADDR &&
+	    n->nlmsg_type !=3D RTM_NEWMULTICAST &&
+	    n->nlmsg_type !=3D RTM_DELMULTICAST)
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
index de67f2c9..b28faa20 100644
--- a/ip/ipmonitor.c
+++ b/ip/ipmonitor.c
@@ -30,7 +30,7 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage: ip monitor [ all | OBJECTS ] [ FILE ] [ label ] [ all-nsid ]\n"
 		"                  [ dev DEVICE ]\n"
-		"OBJECTS :=3D  address | link | mroute | neigh | netconf |\n"
+		"OBJECTS :=3D  address | link | mroute | maddress | neigh | netconf |\n"
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
@@ -202,6 +208,8 @@ int do_ipmonitor(int argc, char **argv)
 			lmask |=3D IPMON_LLINK;
 		} else if (matches(*argv, "address") =3D=3D 0) {
 			lmask |=3D IPMON_LADDR;
+		} else if (matches(*argv, "maddress") =3D=3D 0) {
+			lmask |=3D IPMON_LMADDR;
 		} else if (matches(*argv, "route") =3D=3D 0) {
 			lmask |=3D IPMON_LROUTE;
 		} else if (matches(*argv, "mroute") =3D=3D 0) {
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
index ec033c69..a3c099ae 100644
--- a/man/man8/ip-monitor.8
+++ b/man/man8/ip-monitor.8
@@ -54,7 +54,7 @@ command is the first in the command line and then the obj=
ect list follows:
 .I OBJECT-LIST
 is the list of object types that we want to monitor.
 It may contain
-.BR link ", " address ", " route ", " mroute ", " prefix ", "
+.BR link ", " address ", " route ", " mroute ", " maddress ", " prefix ", =
"
 .BR neigh ", " netconf ", "  rule ", " stats ", " nsid " and " nexthop "."
 If no
 .B file
--=20
2.47.1.613.gc27f4b7a9f-goog


