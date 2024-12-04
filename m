Return-Path: <netdev+bounces-148993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341669E3C00
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3FF16A146
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6817D1FBEBF;
	Wed,  4 Dec 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWNo3kY4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D891FE444
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320942; cv=none; b=mPAoFwaNC5xk82t23aUGQKH/6l/3kVAXXqvy7bxKz5X36UIsWheDe3j2OYPthhIlBVUBWakbVdYEX22g8zqNpHHswyuelhJrsN7vcTxAiR6UpgsAALZYUWVQwokjHKfg05OJ7ZmpTBKfN+Ei2QH82G1ijbPfPhJsQtGSU/IFUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320942; c=relaxed/simple;
	bh=1wM0WDuV5V94OxCNQLDI2O+YQYh+UWUwxu4FRerbMjk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nrcTTOBwz1wyiMLNR3o6q58xqkcw+YulH3Pli3XWHoPo5YU2d2Gp63A2NAc4taHgQUJxo94j13Qitw8yT3PPAqf7iH3sdgDUf1+gyVwHbcOwA58zUrmQ3Jqt6k1IF5Lejj4jdnjKVD88tUkLTh2Xlyjyh2+l+SXLbhgWa7gkhro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HWNo3kY4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2158c589cd0so36182735ad.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 06:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733320940; x=1733925740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHNdmNDMtPaWmA8LMhB2fS18TWlGBB16yfWTVr8FLt8=;
        b=HWNo3kY4Zdjz/k7x4s4D9xDT+SzYAbu8KEGdfiB56c7GR7WRm5H8rUx5KckKGJMAHH
         ahVJa7aU73ImICaP4cRKXZzcu+ZSqCqrcbahDLHZDsjafEg2jiojGCyCAUpD4h/naT8o
         oZt0WFa0PAgHZGJafiB92X8zpuweJHXN+IXnXbz7cC8heEEXtq5Cg7qdzLy2bZkXsCWN
         Pb+RqgORamZg4xx8G24R9Hn7qTKA1YL7k9BIXGOYTmSHYGtWbG36RxuJHXyJVQUt1jgM
         OrF11sHBm7+eG3/7mpu1wsJrod0Q9U/8HOX4T5IUaSJM3cvk+JBhZVGfzT/ZKwDzGLFV
         IW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320940; x=1733925740;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UHNdmNDMtPaWmA8LMhB2fS18TWlGBB16yfWTVr8FLt8=;
        b=EuHmggWtllPPwky/+024b/R5q3BdsAdAIPYjSm8TNbKsFklb1Irm0czck0owqdzu6y
         49csrQLBsxrdyLaOdj3BWxacy+onmJvvZIHzDH2Dgi5tL1eZERunleBbMyGoMFAoWR+7
         WEBssZcpxPRkeezKimdLtW1xNH/GQwr3QC7dNnO83V140M4tvafkq4RdUORF3Pclxr5R
         hpjscXKqNaKcCCzoOwFtR8tnqwGNyjQM1trTx7eT7JhFFbnK8sKz6+4IQboDRU5Yatom
         oHWciRgInMK8we7IlumNejhWkI/cahfObR0KPDCHL1ezZBuVozFwwMFyq/q/IQwZZ/hM
         NGwg==
X-Forwarded-Encrypted: i=1; AJvYcCX07bCXBQZpUwkJLRv/0DttQVIM6GF45lw5v4Krb9wV2i1IaoLmwGMkWCXYPsROfuHCq+lSo2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUaea7fKslsvXTsPHFR8kWyBl2tLk+QZFdJdBKVyY8t36YYuRt
	ECJR24Sq4cuTl6tgcx9vH7WbxQrm1UKz64T6uJ+Nf+y08ZnwYYgdKMxYddx4sjQ2UsS6Hn7W9Mh
	hnFPT1xJ3utfTPpIqkyGPZg==
X-Google-Smtp-Source: AGHT+IH9aQ5wZjRyiZ6KI60pX7ycY2gorhMVpdBr27K5u1/f8PhfN11oazwUtKN1R3rMAuqgMYQY6B98pX3m4ROsvg==
X-Received: from plbme8.prod.google.com ([2002:a17:902:fc48:b0:215:4daf:8d9b])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:228c:b0:215:58f0:2620 with SMTP id d9443c01a7336-215bd0ce98bmr100748985ad.30.1733320939989;
 Wed, 04 Dec 2024 06:02:19 -0800 (PST)
Date: Wed,  4 Dec 2024 23:02:08 +0900
In-Reply-To: <20241204140208.2701268-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204140208.2701268-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204140208.2701268-2-yuyanghuang@google.com>
Subject: [PATCH iproute2-next, v3 2/2] iproute2: add 'ip monitor mcaddr' support
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
8: nettest123    inet mcast 224.0.0.1 scope global
8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
Deleted 8: nettest123    inet mcast 224.0.0.1 scope global
Deleted 8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
Deleted 8: nettest123    inet6 mcast ff02::1 scope global

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v1:
- Move the UAPI constants to a separate patch.
- Update the commit message.
- Fix the indentation format.

 ip/ipaddress.c | 17 +++++++++++++++--
 ip/ipmonitor.c | 25 ++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 3 deletions(-)

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
index de67f2c9..4743b3e1 100644
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
--=20
2.47.0.338.g60cca15819-goog


