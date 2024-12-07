Return-Path: <netdev+bounces-149892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD3F9E7F5A
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 10:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8E61689BA
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648213D53A;
	Sat,  7 Dec 2024 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IIv8tNb6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1BA200A0
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733563219; cv=none; b=AHK3Wv+c4HVUgswwMGliYTObsgwL0TGzKpeynpCW0UxOyC/nGb+zQvl5+ispmK3rm+2PCFE5NsSGLsBFlkY7awBR91XRXtxdMxECoZ2qFzL21qdL18mbmkn4lGSeIeZFVwIG8tXvnVlyz4oitTzlYngWTsbDGSG2dkycQ8rlQ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733563219; c=relaxed/simple;
	bh=xyd5FUbiPaY8jcTOneSCg5PU2GDZlgdzlsid8WJRkfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G9k2Jhx+7nkFu9dsr/D0c1EGY5Glh9SoX+jMXHbQzmCX5qkneoN/GoMXcPzNdr922UsrriBsI8uDEAs3uYwiPyw+iwbHIe6MGcMHwejwgxvwyoBGteimoDAuK3YaPbMjwfseZkCT/Tp/fL+NEkqboGKO9VCro/lSA5RdsyerI4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IIv8tNb6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-725b37e2b0cso1735772b3a.1
        for <netdev@vger.kernel.org>; Sat, 07 Dec 2024 01:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733563217; x=1734168017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uk9wnwTSIk7cVUU2owv63/jU7AlcpZe40VG3CwPRjKc=;
        b=IIv8tNb6kP6NYubP77YpScWhFz+rEM6aQOnTce5yoRAt5awsjkKaqyZPmKbx496mn7
         agJdS0hOzBlsYoyWxtfmZzXNpObP6dFlY21Zyzilvw/Orl8OH1SJ1EUx3+DY56MqBOB8
         /YaUDk6EKY1Q8U7vnHH6E2Jy35mifwdbzYUV+PE4erksYzNLzF99W51KRtygqTdPxQyj
         OOs3FVY2bSaC8zeHE5xTqaf0xP+Y9cPDjzGv704ba4ipQvciKt2KT7NVTaqgSKE5OM8k
         K/52q6tT6TnIeYnv+T9XaRVaCDQYKQTs4FqE6tCzlfzytRKXBpEJWQtZH/q0UiLu3bn0
         GOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733563217; x=1734168017;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uk9wnwTSIk7cVUU2owv63/jU7AlcpZe40VG3CwPRjKc=;
        b=tbJvc4TYSz5pLoMYlM4uMdyavDFKZpWqpN2aZ3c2QZBmuqHBMGqFvRyAhcC3SL0Qyf
         YLeupt+1NPrSd32tCWuNOig/MdUKaaQ0xVkcujFnRNxBFTpHdWAv63mpkqWH7n9b5tN7
         L41hF+jjW7qm4XqlpGCQuPaft69l8lJ7clzbf0oKUR1WNcxtdV/pdxwCjKyrftOMuseJ
         HO2zKyi3kmGjM4q9qZ9ijziZg/Z9uPysZ3+9aARaDx9lPPguTql2PNHfTPa5jkhn9pIe
         zmSPFh3Dmpf0x3FzVm7AkctkoIlRdBuJnepD0151y7RIwfDLBorjjQOociyeuNtTMdvt
         xiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWum6bN0taj6mZnb+DBigswQRqGoV4r7tyncDDx+jEz2E6TZ3ndGJ+kpg7y2/r7YVW0MCyJQhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJPX12ylvAciLC4JGlFzbETnMU7u8Bxam2mYhVX1cHoM5qkyCd
	u6wtx+C2dhKvvmqa9rjOiiiDyYaqaLbZlt7ND+tTQVe3+Hihjjg7sl59CbE372ZUS5IjTYpJr+b
	wOZrHFNi8ni4Ru+Ig8af4QQ==
X-Google-Smtp-Source: AGHT+IExRxG2yOaDU+FNIOKgen7ualB/CTMcfn9SYPqXnvtaX8OXyD3XgyYCNsKBhhkMknoYRxqQccTX0Y2GsxMBFQ==
X-Received: from pfbeg11.prod.google.com ([2002:a05:6a00:800b:b0:724:df8b:ae66])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:c8a:b0:725:9cc4:2354 with SMTP id d2e1a72fcca58-725b8100b9emr9697085b3a.10.1733563217245;
 Sat, 07 Dec 2024 01:20:17 -0800 (PST)
Date: Sat,  7 Dec 2024 18:20:08 +0900
In-Reply-To: <20241207092008.752846-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241207092008.752846-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241207092008.752846-2-yuyanghuang@google.com>
Subject: [PATCH iproute2-next, v5 2/2] iproute2: add 'ip monitor maddress' support
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
2.47.0.338.g60cca15819-goog


