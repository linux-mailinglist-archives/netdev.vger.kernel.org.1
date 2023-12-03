Return-Path: <netdev+bounces-53333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE89D80263D
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 19:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE701C20510
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 18:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F017748;
	Sun,  3 Dec 2023 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="tl09dOUN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB476E8
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 10:29:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d06819a9cbso7453595ad.1
        for <netdev@vger.kernel.org>; Sun, 03 Dec 2023 10:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701628172; x=1702232972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pA2wQusCa3mEFSQCIOUMKEO9j9Qlgp+vDTS9msuYbVM=;
        b=tl09dOUNcEWLcdugW2KgEwijMktTMLNM5ph/JyhHFRrB1v/UHzVB5jxf4Lyaym6JkX
         ix3lcCF9qUU3A2Vtd7RsFGsWpKlmDF6Vzk1R30WbUrtBFahGCU2s7NPuwaTj4hXVw0uI
         j3Xmb7Lz95U9uKh3JgYaeZ/MiOsElXHfhTHW0FiqIG6rq/P9FO8vTaUJl+Fr1iB9Xq0F
         M6RXUubWX2pLvdk+bhw3/UsNije1i1gpESNAuJNp9SWZg9HN29dpR54AuVLgcZEpIl6n
         CPednGSiOPtRciPIA//YKB9rMBRUIQ9a9PJpmot2Hjp+MDEV7QusSz/tRawewRQqGAHa
         qpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701628172; x=1702232972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pA2wQusCa3mEFSQCIOUMKEO9j9Qlgp+vDTS9msuYbVM=;
        b=swjWEY+isTbDeAB/KOGxJtn8mz8SlUwLASsnvt6EUQC4avGL35DOJnIUJJxQh2doHm
         ztPOD1BFqTZbbnsBJg08LMrr3AZluMSRkn5dRv3jDXzD/vAj0nVsJJYim24dOqS1NxR0
         m+K8Vt6FtUz+OAeCdhpdm2Gx9pO/ewfG/u3Wu5T1y5HsCv4bzsV8786XpKOQGF21D1Se
         lJASiesTOUI22GSunBFzMRsKnvJmLxutN5K18v+e3WjOpryAsA68ID4rlhyKXfSI1Xsj
         sdFIpdSFH9Qfg5Xtoby3PkQuY5OLmRdmv7bOfClWM3x/UbpmmYBAXVfzlU1m/PS9Fal8
         4Gcg==
X-Gm-Message-State: AOJu0Yx7DIDBuBMIe9CCwzhUPvRzW1leGNlMIZ8g7wolUHrFU0kY3rgl
	SilDm7IGRpwAqiBYGC2ryEbD4xsiiPsHageq1rjvMQ==
X-Google-Smtp-Source: AGHT+IECEUAPQhhySRoU6FEvDHO4NwG5OYTZUnV0lts6UaIISHIZMGITlYth3SBDJi+I3B6by0BCGA==
X-Received: by 2002:a05:6a20:431c:b0:166:82cf:424a with SMTP id h28-20020a056a20431c00b0016682cf424amr909374pzk.33.1701628172206;
        Sun, 03 Dec 2023 10:29:32 -0800 (PST)
Received: from hermes.lan (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id jm7-20020a17090304c700b001d07d83fdd0sm2373860plb.238.2023.12.03.10.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 10:29:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] ip: require RTM_NEWLINK
Date: Sun,  3 Dec 2023 10:29:14 -0800
Message-ID: <20231203182929.9559-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel support for creating network devices was added back
in 2007 and iproute2 has been carrying backward compatability
support since then. After 16 years, it is enough time to
drop the code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/iplink.c | 492 ++++------------------------------------------------
 1 file changed, 37 insertions(+), 455 deletions(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index 3ec4d9698b72..b02b940812e5 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -28,15 +28,12 @@
 #include "ip_common.h"
 #include "namespace.h"
 
-#define IPLINK_IOCTL_COMPAT	1
-
 #ifndef GSO_MAX_SEGS
 #define GSO_MAX_SEGS		65535
 #endif
 
 
 static void usage(void) __attribute__((noreturn));
-static int iplink_have_newlink(void);
 
 void iplink_types_usage(void)
 {
@@ -54,26 +51,22 @@ void iplink_types_usage(void)
 
 void iplink_usage(void)
 {
-	if (iplink_have_newlink()) {
-		fprintf(stderr,
-			"Usage: ip link add [link DEV | parentdev NAME] [ name ] NAME\n"
-			"		    [ txqueuelen PACKETS ]\n"
-			"		    [ address LLADDR ]\n"
-			"		    [ broadcast LLADDR ]\n"
-			"		    [ mtu MTU ] [index IDX ]\n"
-			"		    [ numtxqueues QUEUE_COUNT ]\n"
-			"		    [ numrxqueues QUEUE_COUNT ]\n"
-			"		    [ netns { PID | NETNSNAME | NETNSFILE } ]\n"
-			"		    type TYPE [ ARGS ]\n"
-			"\n"
-			"	ip link delete { DEVICE | dev DEVICE | group DEVGROUP } type TYPE [ ARGS ]\n"
-			"\n"
-			"	ip link set { DEVICE | dev DEVICE | group DEVGROUP }\n"
-			"			[ { up | down } ]\n"
-			"			[ type TYPE ARGS ]\n");
-	} else
-		fprintf(stderr,
-			"Usage: ip link set DEVICE [ { up | down } ]\n");
+	fprintf(stderr,
+		"Usage: ip link add [link DEV | parentdev NAME] [ name ] NAME\n"
+		"		    [ txqueuelen PACKETS ]\n"
+		"		    [ address LLADDR ]\n"
+		"		    [ broadcast LLADDR ]\n"
+		"		    [ mtu MTU ] [index IDX ]\n"
+		"		    [ numtxqueues QUEUE_COUNT ]\n"
+		"		    [ numrxqueues QUEUE_COUNT ]\n"
+		"		    [ netns { PID | NETNSNAME | NETNSFILE } ]\n"
+		"		    type TYPE [ ARGS ]\n"
+		"\n"
+		"	ip link delete { DEVICE | dev DEVICE | group DEVGROUP } type TYPE [ ARGS ]\n"
+		"\n"
+		"	ip link set { DEVICE | dev DEVICE | group DEVGROUP }\n"
+		"			[ { up | down } ]\n"
+		"			[ type TYPE ARGS ]\n");
 
 	fprintf(stderr,
 		"		[ arp { on | off } ]\n"
@@ -126,13 +119,12 @@ void iplink_usage(void)
 		"	ip link property add dev DEVICE [ altname NAME .. ]\n"
 		"	ip link property del dev DEVICE [ altname NAME .. ]\n");
 
-	if (iplink_have_newlink()) {
-		fprintf(stderr,
-			"\n"
-			"	ip link help [ TYPE ]\n"
-			"\n");
-		iplink_types_usage();
-	}
+	fprintf(stderr,
+		"\n"
+		"	ip link help [ TYPE ]\n"
+		"\n");
+	iplink_types_usage();
+
 	exit(-1);
 }
 
@@ -206,51 +198,6 @@ static int get_addr_gen_mode(const char *mode)
 	return -1;
 }
 
-#if IPLINK_IOCTL_COMPAT
-static int have_rtnl_newlink = -1;
-
-static int accept_msg(struct rtnl_ctrl_data *ctrl,
-		      struct nlmsghdr *n, void *arg)
-{
-	struct nlmsgerr *err = (struct nlmsgerr *)NLMSG_DATA(n);
-
-	if (n->nlmsg_type == NLMSG_ERROR &&
-	    (err->error == -EOPNOTSUPP || err->error == -EINVAL))
-		have_rtnl_newlink = 0;
-	else
-		have_rtnl_newlink = 1;
-	return -1;
-}
-
-static int iplink_have_newlink(void)
-{
-	struct {
-		struct nlmsghdr		n;
-		struct ifinfomsg	i;
-		char			buf[1024];
-	} req = {
-		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
-		.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
-		.n.nlmsg_type = RTM_NEWLINK,
-		.i.ifi_family = AF_UNSPEC,
-	};
-
-	if (have_rtnl_newlink < 0) {
-		if (rtnl_send(&rth, &req.n, req.n.nlmsg_len) < 0) {
-			perror("request send failed");
-			exit(1);
-		}
-		rtnl_listen(&rth, accept_msg, NULL);
-	}
-	return have_rtnl_newlink;
-}
-#else /* IPLINK_IOCTL_COMPAT */
-static int iplink_have_newlink(void)
-{
-	return 1;
-}
-#endif /* ! IPLINK_IOCTL_COMPAT */
-
 static int nl_get_ll_addr_len(const char *ifname)
 {
 	int len;
@@ -1181,363 +1128,6 @@ int iplink_get(char *name, __u32 filt_mask)
 	return 0;
 }
 
-#if IPLINK_IOCTL_COMPAT
-static int get_ctl_fd(void)
-{
-	int s_errno;
-	int fd;
-
-	fd = socket(PF_INET, SOCK_DGRAM, 0);
-	if (fd >= 0)
-		return fd;
-	s_errno = errno;
-	fd = socket(PF_PACKET, SOCK_DGRAM, 0);
-	if (fd >= 0)
-		return fd;
-	fd = socket(PF_INET6, SOCK_DGRAM, 0);
-	if (fd >= 0)
-		return fd;
-	errno = s_errno;
-	perror("Cannot create control socket");
-	return -1;
-}
-
-static int do_chflags(const char *dev, __u32 flags, __u32 mask)
-{
-	struct ifreq ifr;
-	int fd;
-	int err;
-
-	strlcpy(ifr.ifr_name, dev, IFNAMSIZ);
-	fd = get_ctl_fd();
-	if (fd < 0)
-		return -1;
-	err = ioctl(fd, SIOCGIFFLAGS, &ifr);
-	if (err) {
-		perror("SIOCGIFFLAGS");
-		close(fd);
-		return -1;
-	}
-	if ((ifr.ifr_flags^flags)&mask) {
-		ifr.ifr_flags &= ~mask;
-		ifr.ifr_flags |= mask&flags;
-		err = ioctl(fd, SIOCSIFFLAGS, &ifr);
-		if (err)
-			perror("SIOCSIFFLAGS");
-	}
-	close(fd);
-	return err;
-}
-
-static int do_changename(const char *dev, const char *newdev)
-{
-	struct ifreq ifr;
-	int fd;
-	int err;
-
-	strlcpy(ifr.ifr_name, dev, IFNAMSIZ);
-	strlcpy(ifr.ifr_newname, newdev, IFNAMSIZ);
-	fd = get_ctl_fd();
-	if (fd < 0)
-		return -1;
-	err = ioctl(fd, SIOCSIFNAME, &ifr);
-	if (err) {
-		perror("SIOCSIFNAME");
-		close(fd);
-		return -1;
-	}
-	close(fd);
-	return err;
-}
-
-static int set_qlen(const char *dev, int qlen)
-{
-	struct ifreq ifr = { .ifr_qlen = qlen };
-	int s;
-
-	s = get_ctl_fd();
-	if (s < 0)
-		return -1;
-
-	strlcpy(ifr.ifr_name, dev, IFNAMSIZ);
-	if (ioctl(s, SIOCSIFTXQLEN, &ifr) < 0) {
-		perror("SIOCSIFXQLEN");
-		close(s);
-		return -1;
-	}
-	close(s);
-
-	return 0;
-}
-
-static int set_mtu(const char *dev, int mtu)
-{
-	struct ifreq ifr = { .ifr_mtu = mtu };
-	int s;
-
-	s = get_ctl_fd();
-	if (s < 0)
-		return -1;
-
-	strlcpy(ifr.ifr_name, dev, IFNAMSIZ);
-	if (ioctl(s, SIOCSIFMTU, &ifr) < 0) {
-		perror("SIOCSIFMTU");
-		close(s);
-		return -1;
-	}
-	close(s);
-
-	return 0;
-}
-
-static int get_address(const char *dev, int *htype)
-{
-	struct ifreq ifr = {};
-	struct sockaddr_ll me = {
-		.sll_family = AF_PACKET,
-		.sll_protocol = htons(ETH_P_LOOP),
-	};
-	socklen_t alen;
-	int s;
-
-	s = socket(PF_PACKET, SOCK_DGRAM, 0);
-	if (s < 0) {
-		perror("socket(PF_PACKET)");
-		return -1;
-	}
-
-	strlcpy(ifr.ifr_name, dev, IFNAMSIZ);
-	if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
-		perror("SIOCGIFINDEX");
-		close(s);
-		return -1;
-	}
-
-	me.sll_ifindex = ifr.ifr_ifindex;
-	if (bind(s, (struct sockaddr *)&me, sizeof(me)) == -1) {
-		perror("bind");
-		close(s);
-		return -1;
-	}
-
-	alen = sizeof(me);
-	if (getsockname(s, (struct sockaddr *)&me, &alen) == -1) {
-		perror("getsockname");
-		close(s);
-		return -1;
-	}
-	close(s);
-	*htype = me.sll_hatype;
-	return me.sll_halen;
-}
-
-static int parse_address(const char *dev, int hatype, int halen,
-		char *lla, struct ifreq *ifr)
-{
-	int alen;
-
-	memset(ifr, 0, sizeof(*ifr));
-	strlcpy(ifr->ifr_name, dev, IFNAMSIZ);
-	ifr->ifr_hwaddr.sa_family = hatype;
-	alen = ll_addr_a2n(ifr->ifr_hwaddr.sa_data, 14, lla);
-	if (alen < 0)
-		return -1;
-	if (alen != halen) {
-		fprintf(stderr,
-			"Wrong address (%s) length: expected %d bytes\n",
-			lla, halen);
-		return -1;
-	}
-	return 0;
-}
-
-static int set_address(struct ifreq *ifr, int brd)
-{
-	int s;
-
-	s = get_ctl_fd();
-	if (s < 0)
-		return -1;
-	if (ioctl(s, brd?SIOCSIFHWBROADCAST:SIOCSIFHWADDR, ifr) < 0) {
-		perror(brd?"SIOCSIFHWBROADCAST":"SIOCSIFHWADDR");
-		close(s);
-		return -1;
-	}
-	close(s);
-	return 0;
-}
-
-static int do_set(int argc, char **argv)
-{
-	char *dev = NULL;
-	__u32 mask = 0;
-	__u32 flags = 0;
-	int qlen = -1;
-	int mtu = -1;
-	char *newaddr = NULL;
-	char *newbrd = NULL;
-	struct ifreq ifr0, ifr1;
-	char *newname = NULL;
-	int htype, halen;
-
-	while (argc > 0) {
-		if (strcmp(*argv, "up") == 0) {
-			mask |= IFF_UP;
-			flags |= IFF_UP;
-		} else if (strcmp(*argv, "down") == 0) {
-			mask |= IFF_UP;
-			flags &= ~IFF_UP;
-		} else if (strcmp(*argv, "name") == 0) {
-			NEXT_ARG();
-			if (check_ifname(*argv))
-				invarg("\"name\" not a valid ifname", *argv);
-			newname = *argv;
-		} else if (matches(*argv, "address") == 0) {
-			NEXT_ARG();
-			newaddr = *argv;
-		} else if (matches(*argv, "broadcast") == 0 ||
-			   strcmp(*argv, "brd") == 0) {
-			NEXT_ARG();
-			newbrd = *argv;
-		} else if (matches(*argv, "txqueuelen") == 0 ||
-			   strcmp(*argv, "qlen") == 0 ||
-			   matches(*argv, "txqlen") == 0) {
-			NEXT_ARG();
-			if (qlen != -1)
-				duparg("txqueuelen", *argv);
-			if (get_integer(&qlen,  *argv, 0))
-				invarg("Invalid \"txqueuelen\" value\n", *argv);
-		} else if (strcmp(*argv, "mtu") == 0) {
-			NEXT_ARG();
-			if (mtu != -1)
-				duparg("mtu", *argv);
-			if (get_integer(&mtu, *argv, 0))
-				invarg("Invalid \"mtu\" value\n", *argv);
-		} else if (strcmp(*argv, "multicast") == 0) {
-			NEXT_ARG();
-			mask |= IFF_MULTICAST;
-
-			if (strcmp(*argv, "on") == 0)
-				flags |= IFF_MULTICAST;
-			else if (strcmp(*argv, "off") == 0)
-				flags &= ~IFF_MULTICAST;
-			else
-				return on_off("multicast", *argv);
-		} else if (strcmp(*argv, "allmulticast") == 0) {
-			NEXT_ARG();
-			mask |= IFF_ALLMULTI;
-
-			if (strcmp(*argv, "on") == 0)
-				flags |= IFF_ALLMULTI;
-			else if (strcmp(*argv, "off") == 0)
-				flags &= ~IFF_ALLMULTI;
-			else
-				return on_off("allmulticast", *argv);
-		} else if (strcmp(*argv, "promisc") == 0) {
-			NEXT_ARG();
-			mask |= IFF_PROMISC;
-
-			if (strcmp(*argv, "on") == 0)
-				flags |= IFF_PROMISC;
-			else if (strcmp(*argv, "off") == 0)
-				flags &= ~IFF_PROMISC;
-			else
-				return on_off("promisc", *argv);
-		} else if (strcmp(*argv, "trailers") == 0) {
-			NEXT_ARG();
-			mask |= IFF_NOTRAILERS;
-
-			if (strcmp(*argv, "off") == 0)
-				flags |= IFF_NOTRAILERS;
-			else if (strcmp(*argv, "on") == 0)
-				flags &= ~IFF_NOTRAILERS;
-			else
-				return on_off("trailers", *argv);
-		} else if (strcmp(*argv, "arp") == 0) {
-			NEXT_ARG();
-			mask |= IFF_NOARP;
-
-			if (strcmp(*argv, "on") == 0)
-				flags &= ~IFF_NOARP;
-			else if (strcmp(*argv, "off") == 0)
-				flags |= IFF_NOARP;
-			else
-				return on_off("arp", *argv);
-		} else if (matches(*argv, "dynamic") == 0) {
-			NEXT_ARG();
-			mask |= IFF_DYNAMIC;
-
-			if (strcmp(*argv, "on") == 0)
-				flags |= IFF_DYNAMIC;
-			else if (strcmp(*argv, "off") == 0)
-				flags &= ~IFF_DYNAMIC;
-			else
-				return on_off("dynamic", *argv);
-		} else {
-			if (strcmp(*argv, "dev") == 0)
-				NEXT_ARG();
-			else if (matches(*argv, "help") == 0)
-				usage();
-
-			if (dev)
-				duparg2("dev", *argv);
-			if (check_ifname(*argv))
-				invarg("\"dev\" not a valid ifname", *argv);
-			dev = *argv;
-		}
-		argc--; argv++;
-	}
-
-	if (!dev) {
-		fprintf(stderr,
-			"Not enough of information: \"dev\" argument is required.\n");
-		exit(-1);
-	}
-
-	if (newaddr || newbrd) {
-		halen = get_address(dev, &htype);
-		if (halen < 0)
-			return -1;
-		if (newaddr) {
-			if (parse_address(dev, htype, halen,
-					  newaddr, &ifr0) < 0)
-				return -1;
-		}
-		if (newbrd) {
-			if (parse_address(dev, htype, halen,
-					  newbrd, &ifr1) < 0)
-				return -1;
-		}
-	}
-
-	if (newname && strcmp(dev, newname)) {
-		if (do_changename(dev, newname) < 0)
-			return -1;
-		dev = newname;
-	}
-	if (qlen != -1) {
-		if (set_qlen(dev, qlen) < 0)
-			return -1;
-	}
-	if (mtu != -1) {
-		if (set_mtu(dev, mtu) < 0)
-			return -1;
-	}
-	if (newaddr || newbrd) {
-		if (newbrd) {
-			if (set_address(&ifr1, 1) < 0)
-				return -1;
-		}
-		if (newaddr) {
-			if (set_address(&ifr0, 0) < 0)
-				return -1;
-		}
-	}
-	if (mask)
-		return do_chflags(dev, flags, mask);
-	return 0;
-}
-#endif /* IPLINK_IOCTL_COMPAT */
 
 void print_mpls_link_stats(FILE *fp, const struct mpls_link_stats *stats,
 			   const char *indent)
@@ -1831,29 +1421,21 @@ int do_iplink(int argc, char **argv)
 	if (argc < 1)
 		return ipaddr_list_link(0, NULL);
 
-	if (iplink_have_newlink()) {
-		if (matches(*argv, "add") == 0)
-			return iplink_modify(RTM_NEWLINK,
-					     NLM_F_CREATE|NLM_F_EXCL,
-					     argc-1, argv+1);
-		if (matches(*argv, "set") == 0 ||
-		    matches(*argv, "change") == 0)
-			return iplink_modify(RTM_NEWLINK, 0,
-					     argc-1, argv+1);
-		if (matches(*argv, "replace") == 0)
-			return iplink_modify(RTM_NEWLINK,
-					     NLM_F_CREATE|NLM_F_REPLACE,
-					     argc-1, argv+1);
-		if (matches(*argv, "delete") == 0)
-			return iplink_modify(RTM_DELLINK, 0,
-					     argc-1, argv+1);
-	} else {
-#if IPLINK_IOCTL_COMPAT
-		if (matches(*argv, "set") == 0)
-			return do_set(argc-1, argv+1);
-#endif
-	}
-
+	if (matches(*argv, "add") == 0)
+		return iplink_modify(RTM_NEWLINK,
+				     NLM_F_CREATE|NLM_F_EXCL,
+				     argc-1, argv+1);
+	if (matches(*argv, "set") == 0 ||
+	    matches(*argv, "change") == 0)
+		return iplink_modify(RTM_NEWLINK, 0,
+				     argc-1, argv+1);
+	if (matches(*argv, "replace") == 0)
+		return iplink_modify(RTM_NEWLINK,
+				     NLM_F_CREATE|NLM_F_REPLACE,
+				     argc-1, argv+1);
+	if (matches(*argv, "delete") == 0)
+		return iplink_modify(RTM_DELLINK, 0,
+				     argc-1, argv+1);
 	if (matches(*argv, "show") == 0 ||
 	    matches(*argv, "lst") == 0 ||
 	    matches(*argv, "list") == 0)
-- 
2.42.0


