Return-Path: <netdev+bounces-146579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A449D475F
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 06:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13146282029
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 05:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090B11AA1FB;
	Thu, 21 Nov 2024 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvboM6Dr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4FE2309B6
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732168587; cv=none; b=S8gvTk5YpWNekSPrAsO9ey4pxrSXiBVChJt5WuUFxHukTY5Q7xIJemMGc11o9gAI6z0SNhWxQ/5fBWtadV/DLUHsXNWm3O28uunjDxXrNtTzqcz7cS29+tq2vj2bwRYTmnRS4m6g4xKKmud+L2feNK1TtOdnrozW9W1MaQcBIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732168587; c=relaxed/simple;
	bh=VNx8I/juCIHP0kztyYJX441I+5TTY8l1myOYu29viAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RMp24fv1jhwoigqydbQtCSetMjv6l4iCkS9E8Utu3iOQH7BXIBY3QG3cXQS0N4oAxmKBQaMhri3RBTl2P6j4DvnG/GBSPCiMPlmv45ExigcYrsS/hkAUPssqylktfg9V7BX0NclCMs9rXIGWX4HWMXJOiQOZPjVj3kkYeThfD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LvboM6Dr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2971589916so873292276.3
        for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 21:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732168585; x=1732773385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gpQHyvdz3/cQZhC+wn7EctdgPhoza9EHtNYdRv78gg=;
        b=LvboM6Drrcy4KZz1qnYqKN3c3C7pWv6orZlhZ4gz1/ueBkR9/tRNq+GTeP14zZnxyf
         4hTBw8Bv/SbAm1btZbbhU28RPpJu9yghK5UF6w7xPzyipDLS1nc8BQRkdwx0ozkQooAj
         wuoanBPlc+qrLKyIqN1dbtn93e5LLGYua9P13XfeJ2AWXMXxsv9DmMGIf+UB/P0CfQBZ
         npqFhzBFwFtzbgBjzEfHZsaY6hd+wV4J4rTypvHbO8zx+elZGoiEGY+rLpndWE06WLPu
         KqCdrO5JBSNxYa1xfX0lrv0AqbTPDJ0aDdyhMFa6R7eDzmwrglXuE9HjdzAKJw8M8ho9
         Inqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732168585; x=1732773385;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6gpQHyvdz3/cQZhC+wn7EctdgPhoza9EHtNYdRv78gg=;
        b=p1lWyXg1SGjT4f6wavMP1bdGyt3wLHLiSETcAcwCz+d6oGoq/Rg9/b/yMu74Faml9o
         KEjknQgTij6vbfliOjK5WZI+rcPgYF17I+QlZI394wMxpm/bP9UXvFhkbSMI0QCkN/Qu
         NX3mUc22nX1/jMSwSPUImDKoacM85YtzYu9SNdlmnIk8gqs0E+Xnj4kHSwwusdJEVIQL
         XazYXnOxH6jMjFwl8jk3CO6MhbRkq8kG0u6AAIMYLQ3fZJTZt6/UbIorGnq3RKOa59Fp
         W7l483S8q1ncgHZelTiplIAIvTytb2iwLkyPCnLvT6qSTXAvdp6s5Kb8bVn0lGwVdyMe
         MyQw==
X-Forwarded-Encrypted: i=1; AJvYcCWKw65//4NMLU1rKktzT+Ng7/51ZIRU9GkIu0dHKxwjWTyF+Wv4jTUErVpvYT+oSVTvMFgZC6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVTqGLI3ryCgRtDGR/5/u4gJY63JAQXnsm1kdS8GcgLF3r00a7
	EHN+mYmwH4Y4VF0jAIS8go7DdDzLPyhQrofasq4d/5GyO+uqx438uUtlbYLxee3XouDWPQ+jZZv
	2ygLwxFdxV8u1OyQ5vMs+qA==
X-Google-Smtp-Source: AGHT+IHLlWE5euc6o4hH0upicx6wBJNeZKmVtgPxJBJDrlJ8T0GuAJjERbIWp3nedsgnJdu4L+ACCyIbsWiocXI62g==
X-Received: from yuyanghuang.tok.corp.google.com ([2401:fa00:8f:203:b514:d526:a415:3fd7])
 (user=yuyanghuang job=sendgmr) by 2002:a25:d60f:0:b0:e38:bd8b:df20 with SMTP
 id 3f1490d57ef6-e38cb797158mr2205276.9.1732168585198; Wed, 20 Nov 2024
 21:56:25 -0800 (PST)
Date: Thu, 21 Nov 2024 14:56:15 +0900
In-Reply-To: <20241121055615.826882-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121055615.826882-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121055615.826882-2-yuyanghuang@google.com>
Subject: [PATCH iproute2-next, v2 2/2] iproute2: add 'ip monitor mcaddr' support
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
2.47.0.371.ga323438b13-goog


