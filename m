Return-Path: <netdev+bounces-153953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E989FA337
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 02:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9478E1889E7E
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 01:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA26D944F;
	Sun, 22 Dec 2024 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0C9Cdijl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D336A35
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734829560; cv=none; b=uERiL0QlrDNfvnmbfRmYNovTTgl37EA8gCMD0xLk0/yxbVZPtrCTy0UGaMKzQ8nK+rU0EpJ0opsoMspJgQpiF0XtdSwBTY3xDLRNi3Sa+VLXhvGMf9aFJ+ikJWM0gIQtpbdSKaA4kG0McWqChyWMzgoyUh7WbJpmIApGGL79iyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734829560; c=relaxed/simple;
	bh=+qGrks+uyLQLas9NBDcBG4u9F439P7UZtFfqWBV1bac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HajR9FBXfVyPqlRCyQ9jPo0MQXWw3fQoCV+qOiVZUaW8SafhQNOSx9octQQHQgc4NkdP1yFWDr+BMrscKaWET+PnayeF805O9OQcosoZkXP91h2RCcco7RVn43unfj1NCcVY15YbdQbuWF9zcqI0Ci/I9Ih3qLcLkWwipLSPrVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0C9Cdijl; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-728eda1754eso4235557b3a.2
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 17:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734829558; x=1735434358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YawHiG3JIeegYRVjqdd7y7CVotwKx+gKxbQBIqJzU0o=;
        b=0C9CdijlAryFnBkorcN5oFm6IgOhqDk8PSHeHfG0tNJ5rAF5y35lqjitOS8Pq4EWO7
         87qHRlXrICtRu0xsNFYKF8tW0jhFYu/2KubpiNeV8WSInkAJ2Z3AyEqYqL2/bXmcL0k5
         53yFGoEyvy7yEAQQk0qaKy1VL/lMoIaLXD+v3lvLss3iLcyAHQ49N3goJqy3B++T1HAu
         JOK1Uo9nCYnUEVsbvfA1DhMLXtdyl9D7LCdSGGgJqWXZ6kq8DFxkXLnZJ/1ZTl0tmpo6
         3NMcyTwN5Rl09IFjys/KwlNDf73+Q62cCwGG8fCDQIoAKLj00k+QKq78iywzZX4w/FpQ
         X8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734829558; x=1735434358;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YawHiG3JIeegYRVjqdd7y7CVotwKx+gKxbQBIqJzU0o=;
        b=vv6stJRnMM22t114H0PeDt7rdjp++aPg/Q+ZyMG32lnr7ZVPT0ZnZdysXy4fVX8rDn
         FGeJIVG4ZLJXl7K/dZW/d7ASWMSkxgZyLuMrI8LZ9HlYX84twV5+ct6s/qFgnn4nMWxW
         8beRWnz6gIVH4iCYOEWwCPvCMUFx/s67YQTfVY75WGrSQGX5zLW6QqnZfsKNLB77B7kp
         heGchurp1f3i6Pyi2KUuJOrH4x84MQIBhh5o/ICXsI/i9aJ6qigUwmiA4Bptd5M/OyYK
         fmP/aaehiP20OPS955YMz7ZNq2IkSvjH7iV9//uUaDQo8wp4OaBx/MWbUkmYSn/cAPvg
         VFHg==
X-Forwarded-Encrypted: i=1; AJvYcCVOja25Ypg5Lxy0YubYaphOR8VG9WeG2iJ9jIahCKoqyeKTkGB1ztezJY+QCKCqtfAbZQgGjqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtnHzvYL8pv4/FA3NNRSZsgUR80p5MynveCI8AgKHVWwFj8xGN
	ueikQGuDjnGqQFr/8VRHYbIldmJCy4tlNsvlKIo5vMybhptqnbC0jFN8Rp2zrCM19ouuWLZtA/k
	OKV6e910OC1cfVUYnBAgD3A==
X-Google-Smtp-Source: AGHT+IFjiSJ0FTZv8Ho4KY6EjLk2tByZnqElXOjNvddlOXI2nWtmpEUT3S/brwoIIroHIaki47BpHZ3m2yoMNMeeiA==
X-Received: from pfbds10.prod.google.com ([2002:a05:6a00:4aca:b0:725:defb:79b1])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a91:b0:726:c23f:4e5c with SMTP id d2e1a72fcca58-72abdd20f88mr11526283b3a.1.1734829558338;
 Sat, 21 Dec 2024 17:05:58 -0800 (PST)
Date: Sun, 22 Dec 2024 10:05:48 +0900
In-Reply-To: <20241222010548.2304540-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241222010548.2304540-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241222010548.2304540-2-yuyanghuang@google.com>
Subject: [PATCH iproute2-next 2/2] iproute2: add 'ip monitor acaddress' support
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

Enhanced the 'ip monitor' command to track changes in IPv6
anycast addresses. This update allows the command to listen for
events related to anycast address additions and deletions by
registering to the newly introduced RTNLGRP_IPV6_ACADDR netlink group.

This patch depends on the kernel patch that adds RTNLGRP_IPV6_ACADDR
being merged first.

Here is an example usage:

root@uml-x86-64:/# ip monitor acaddress
2: if2    inet6 any 2001:db8:7b:0:528e:a53a:9224:c9c5 scope global
       valid_lft forever preferred_lft forever
Deleted 2: if2    inet6 any 2001:db8:7b:0:528e:a53a:9224:c9c5 scope global
       valid_lft forever preferred_lft forever

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 ip/ipaddress.c        |  8 ++++++--
 ip/ipmonitor.c        | 18 ++++++++++++++++--
 man/man8/ip-monitor.8 |  5 +++--
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 679b4c00..70b3d513 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -1507,7 +1507,9 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
 	if (n->nlmsg_type !=3D RTM_NEWADDR &&
 	    n->nlmsg_type !=3D RTM_DELADDR &&
 	    n->nlmsg_type !=3D RTM_NEWMULTICAST &&
-	    n->nlmsg_type !=3D RTM_DELMULTICAST)
+	    n->nlmsg_type !=3D RTM_DELMULTICAST &&
+	    n->nlmsg_type !=3D RTM_NEWANYCAST &&
+	    n->nlmsg_type !=3D RTM_DELANYCAST)
 		return 0;
 	len -=3D NLMSG_LENGTH(sizeof(*ifa));
 	if (len < 0) {
@@ -1567,7 +1569,9 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
=20
 	print_headers(fp, "[ADDR]");
=20
-	if (n->nlmsg_type =3D=3D RTM_DELADDR || n->nlmsg_type =3D=3D RTM_DELMULTI=
CAST)
+	if (n->nlmsg_type =3D=3D RTM_DELADDR ||
+	    n->nlmsg_type =3D=3D RTM_DELMULTICAST ||
+	    n->nlmsg_type =3D=3D RTM_DELANYCAST)
 		print_bool(PRINT_ANY, "deleted", "Deleted ", true);
=20
 	if (!brief) {
diff --git a/ip/ipmonitor.c b/ip/ipmonitor.c
index b28faa20..eec48d83 100644
--- a/ip/ipmonitor.c
+++ b/ip/ipmonitor.c
@@ -30,8 +30,8 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage: ip monitor [ all | OBJECTS ] [ FILE ] [ label ] [ all-nsid ]\n"
 		"                  [ dev DEVICE ]\n"
-		"OBJECTS :=3D  address | link | mroute | maddress | neigh | netconf |\n"
-		"            nexthop | nsid | prefix | route | rule | stats\n"
+		"OBJECTS :=3D  address | link | mroute | maddress | acaddress | neigh |\=
n"
+		"            netconf | nexthop | nsid | prefix | route | rule | stats\n"
 		"FILE :=3D file FILENAME\n");
 	exit(-1);
 }
@@ -154,6 +154,8 @@ static int accept_msg(struct rtnl_ctrl_data *ctrl,
=20
 	case RTM_DELMULTICAST:
 	case RTM_NEWMULTICAST:
+	case RTM_DELANYCAST:
+	case RTM_NEWANYCAST:
 		print_addrinfo(n, arg);
 		return 0;
=20
@@ -184,6 +186,7 @@ static int accept_msg(struct rtnl_ctrl_data *ctrl,
 #define IPMON_LNSID		BIT(9)
 #define IPMON_LNEXTHOP		BIT(10)
 #define IPMON_LMADDR		BIT(11)
+#define IPMON_LACADDR		BIT(12)
=20
 #define IPMON_L_ALL		(~0)
=20
@@ -210,6 +213,8 @@ int do_ipmonitor(int argc, char **argv)
 			lmask |=3D IPMON_LADDR;
 		} else if (matches(*argv, "maddress") =3D=3D 0) {
 			lmask |=3D IPMON_LMADDR;
+		} else if (matches(*argv, "acaddress") =3D=3D 0) {
+			lmask |=3D IPMON_LACADDR;
 		} else if (matches(*argv, "route") =3D=3D 0) {
 			lmask |=3D IPMON_LROUTE;
 		} else if (matches(*argv, "mroute") =3D=3D 0) {
@@ -349,6 +354,15 @@ int do_ipmonitor(int argc, char **argv)
 		}
 	}
=20
+	if (lmask & IPMON_LACADDR) {
+		if ((!preferred_family || preferred_family =3D=3D AF_INET6) &&
+		    rtnl_add_nl_group(&rth, RTNLGRP_IPV6_ACADDR) < 0) {
+			fprintf(stderr,
+				"Failed to add ipv6 acaddr group to list\n");
+			exit(1);
+		}
+	}
+
 	if (listen_all_nsid && rtnl_listen_all_nsid(&rth) < 0)
 		exit(1);
=20
diff --git a/man/man8/ip-monitor.8 b/man/man8/ip-monitor.8
index a3c099ae..6cb585ba 100644
--- a/man/man8/ip-monitor.8
+++ b/man/man8/ip-monitor.8
@@ -54,8 +54,9 @@ command is the first in the command line and then the obj=
ect list follows:
 .I OBJECT-LIST
 is the list of object types that we want to monitor.
 It may contain
-.BR link ", " address ", " route ", " mroute ", " maddress ", " prefix ", =
"
-.BR neigh ", " netconf ", "  rule ", " stats ", " nsid " and " nexthop "."
+.BR link ", " address ", " route ", " mroute ", " maddress ", " acaddress =
", "
+.BR prefix ", "neigh ", " netconf ", "  rule ", " stats ", " nsid " and "
+.BR nexthop "."
 If no
 .B file
 argument is given,
--=20
2.47.1.613.gc27f4b7a9f-goog


