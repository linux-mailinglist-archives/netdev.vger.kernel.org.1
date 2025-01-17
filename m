Return-Path: <netdev+bounces-159155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B45A14878
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 04:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C19D169BEC
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 03:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288DF1E1C0F;
	Fri, 17 Jan 2025 03:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2k/u/DsV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861F15852E
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 03:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737084066; cv=none; b=ZDYgtn/MxRV+keet6D8EPMyzqVNeREkKZ+VNpG11/WCvg5Egl7+XtQcQUIAgW4o8jEQs5extVze/lwM5a+YZSSui3FutGjI0MPAWEERfpxAuwuWNpUW59kb1igoQLUkQQ9O1D7M/QqVZt0ZTzOWpKFmKV3FwK5Ig9ZQlmd74r2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737084066; c=relaxed/simple;
	bh=JvIyAuBydC5IAJguV7aMVKBZwkO41750fj3I/avcWZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SrMz5eju/ikS4AUZ9JlCaeBUO1k0nv2UqdZ9kisG8HTCQi63YhbwOmO+pRDH28hPmRuKLG7o1sbxQMJ7JRWzQigBFMW+fLCxj51MhkCf3dcR4AFxzauC7gpangUcpyvICYWbyrF0lezR3Vz3hA+RXpxtEUlTx+dGM7NgFPvkmHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2k/u/DsV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee8ced572eso3382332a91.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737084064; x=1737688864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5veukhpj4uZXGaHUg2R7rO4ahGvmkNOdHypTdSvIys=;
        b=2k/u/DsVfmet6ZfGDNWhGEwUwUuE/CZzOp2QQPBiY7C/pv7yuTQWmeElv+zBOkdS2I
         mnGPnIeFLR1HN692sjUT//3mHBYHq9kH2JQPAvSqz02UWwu7jhTPwZzEfmsliOa9zWK0
         r6btAjyckTuzUQyCZXtcrCWS7LBWR2N/EPrPLGRtWonWAlME0pS5TvgwvTF3E97XwvLx
         vNEN71dnXhC81P3i8iEGd4ld5WM4uaiRpne8P7m7iqcEYW++lexPmqjmeCltaWP2LFWQ
         sEzBMDRVgWAHSZKYaYolrPPiGmVdE76Jjr36zZVlPOuu+hOPCW1jis5QsVpIJ1937/nZ
         JE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737084064; x=1737688864;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G5veukhpj4uZXGaHUg2R7rO4ahGvmkNOdHypTdSvIys=;
        b=cJFPqQaiFAdtICAfAW9DOqj/TEyzd1Gi3A7tTWldSbdby3HwWu7KFXwRs6SWIV866J
         tQANbDtxzZsanTqPTymcHgh1Snx5gF+XKx2HmnoN9wCjhWYX7paCiCoBdeSU0WF/+Hmj
         b7M2zawB+VKIk2lRhBMnX3J3Wh15mH4PSFV2uFYDK3k53KCJ5pjsOMmC/aomO4BncvGg
         DAmC5LCFuw3nEq8osmpi/QOLmbLhUkkCQDmW1iCOm0c0eZcKbn/FeDFNwicnB/q3iJ08
         ddn1nUFpeKhTJ6jdXiC/XmM6SPgg58rsztQC2wOCRQwV6XZOz1rV2mTDBGMY1sm9ADyz
         N62A==
X-Forwarded-Encrypted: i=1; AJvYcCXo5KwM35Z2o315wHfpKxUoRr0qpacJfsS5dFouOGOUxrIg8LZq88+hswc49WfekTxPUhTJp0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdA9yw3I0eykLu2IlcxuXzAjmS2mDe0bkKEK67HaPn14rWRR2U
	u/xwt+C6sWldMbUOjwS0sJLKAXHDVDV7NcIkcuC3/OXNZjPshg3fiR6zYMNHglyr7Tc38xFjrsi
	FsEerbi9mYK/3N3e1HUSbVQ==
X-Google-Smtp-Source: AGHT+IEcD+Q/JGIec65s7xCFmjFn8F6w5dVFiye0MfGVJY6X5owQRvrJi6FtfWADENrBS2ZnnWQ9m3MCnbKsP3CxAQ==
X-Received: from pjbsh1.prod.google.com ([2002:a17:90b:5241:b0:2ee:4b69:50e1])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e18f:b0:2ee:693e:ed7a with SMTP id 98e67ed59e1d1-2f782d8651amr1448319a91.35.1737084063752;
 Thu, 16 Jan 2025 19:21:03 -0800 (PST)
Date: Fri, 17 Jan 2025 12:20:41 +0900
In-Reply-To: <20250117032041.28124-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250117032041.28124-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250117032041.28124-3-yuyanghuang@google.com>
Subject: [PATCH RESEND iproute2-next 2/2] iproute2: add 'ip monitor acaddress' support
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
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
2.48.0.rc2.279.g1de40edade-goog


