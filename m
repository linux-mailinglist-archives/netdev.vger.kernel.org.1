Return-Path: <netdev+bounces-134509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8B8999EAB
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B2928291A
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608D420ADC7;
	Fri, 11 Oct 2024 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm+WuRfd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC25920A5FA
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633695; cv=none; b=AZZo7y64HxXSR8upCqHKT3EAIdId5p4f73U8jHnO2+DG3mktoeRKUPSpaMJxz2jkP9MRPdchP3n98o/c+fCDgcseLmuVnVm8V4xLEC/SNPeGuDfBJ6SCNYdHtdjCGotY9EYHqMJlhAbSr6eAXpbrPREl+9o6fQ4GDq1oy298xVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633695; c=relaxed/simple;
	bh=bQ1U7FMoKyxmOaJGDLz2OydB7yXq3H1wx77FlrNphK4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgYs8pVZ44CGMQzkUyTzjam3jGoa5haQA4J+EKKoZ0u0eoZBTn4T4/nI3fR5OIjIqfRZs2yEb0NQThrF/GqtLRD+dwMfF9bfJ7GKdM4XPtZ6Bstqx9Av2BhjAKRZ1z3xpmr8vOmcCj3pALdGCIJAy9H1sRVcIQ9svSX5g1vRHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm+WuRfd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71df67c67fcso1343176b3a.2
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728633693; x=1729238493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Zx1nxBtgn7NWS2XbEDdXzhu+nkPhEjrFTGR71Ez+rc=;
        b=Tm+WuRfdl2sKCoWq+9gapmEcyBM7sa7PP+CcPg0a/fZB4k0rqn5zwIuwxCaF1Wn2g5
         dyJy1LzsY3bVQmikJOAExp0xaeIFrvylJaTdomnXlHAjZUTxza7nTv+eOy4FBYWAdmfv
         Sv1wDty7q/YCuE0mUlnxXjozmajMbhg4FPVzJlkAzs4eGSgtG0lxloLgSplSPi/PCOZV
         9QVXaUaJ5GRXGGu/iiCsSSmBhaKFjcGrm7NdDUQAYWsYDsOspsbKouZEL7lkXGXbq7p5
         kK6q/8vccatL+Tqv/2JR49DPJCTzF8JyYOqmoFFOrcu10PWfG8E7fdg/EGvK++kMVXbx
         2ToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728633693; x=1729238493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Zx1nxBtgn7NWS2XbEDdXzhu+nkPhEjrFTGR71Ez+rc=;
        b=YbLTS/kAImJh7g9TNuCQkP01nDtyo0QM2lNeqcq1Rzm/YMVJACnJc4qp6FcNopEAZq
         yO0KjFDdvQQgX+Rik6I63qo4eKkKQq3k3I24HL85bFVm8KmLOqWx9g8s06Hlr3HklpN4
         I2wA/+OZrVcs+ZXoGad8Kh7XW13zJrPrLHWIgRsMbP++0nswOgrrXqu5KOO+AID7RcZ/
         kVkvhod4dzEaeWIzWZ77w8yP3oNGQc7XcFbHf0V/cbMfdLBSYbYqM3HprvCdXVcheqyq
         LReL1IY2F3dB4jeUlCYCjonSpX4ZS2X8UP0d5dNnlfRK2j/VhnqZkN2ccTe/wXxJOxw9
         W/kg==
X-Forwarded-Encrypted: i=1; AJvYcCVHn9LYb2bQbb1FJ00GUxEN/ZLcyZ3sK2FKG3hnu7dhRj2/vfl4IonhLQVnVSjXr8VP6txxhts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk5TKdZdqYX9xGOSobfu+DuZQwHZ8ZRIEe9Yto0b/cdbNKkE6K
	lOtO57oYMqG9MFYV91ZrU9y1n+DSSvbfzwButuzPiU09HIMbXIT2t2GM+rD5
X-Google-Smtp-Source: AGHT+IF6dFfvNw34oWaXPkKw0M69dpFXzdSf540hMIVa1G8Q/RRVOBmuyNE53l1r+8k62Z4/npO3Gw==
X-Received: by 2002:a05:6a00:3d14:b0:71d:f15e:d023 with SMTP id d2e1a72fcca58-71e37e52e22mr3158014b3a.11.1728633692887;
        Fri, 11 Oct 2024 01:01:32 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b5dfsm2126908b3a.199.2024.10.11.01.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:01:32 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org
Subject: [PATCH v2 iproute2 1/2] ip: Move of set_netnsid_from_name() to namespace.c
Date: Fri, 11 Oct 2024 16:01:08 +0800
Message-ID: <20241011080111.387028-2-shaw.leon@gmail.com>
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

Move set_netnsid_from_name() outside for reuse, like what's done for
netns_id_from_name().

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/namespace.h |  2 ++
 ip/ip_common.h      |  2 --
 ip/iplink.c         |  6 +++---
 ip/ipnetns.c        | 28 +++-------------------------
 lib/namespace.c     | 27 +++++++++++++++++++++++++++
 5 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/include/namespace.h b/include/namespace.h
index 86000543..98f4af59 100644
--- a/include/namespace.h
+++ b/include/namespace.h
@@ -60,6 +60,8 @@ struct netns_func {
 };
 
 int netns_id_from_name(struct rtnl_handle *rtnl, const char *name);
+int set_netns_id_from_name(struct rtnl_handle *rtnl, const char *name,
+			   int nsid);
 char *netns_name_from_id(int32_t id);
 
 #endif /* __NAMESPACE_H__ */
diff --git a/ip/ip_common.h b/ip/ip_common.h
index 625311c2..726262ab 100644
--- a/ip/ip_common.h
+++ b/ip/ip_common.h
@@ -63,8 +63,6 @@ void netns_nsid_socket_init(void);
 int print_nsid(struct nlmsghdr *n, void *arg);
 int ipstats_print(struct nlmsghdr *n, void *arg);
 char *get_name_from_nsid(int nsid);
-int get_netnsid_from_name(const char *name);
-int set_netnsid_from_name(const char *name, int nsid);
 int do_ipaddr(int argc, char **argv);
 int do_ipaddrlabel(int argc, char **argv);
 int do_iproute(int argc, char **argv);
diff --git a/ip/iplink.c b/ip/iplink.c
index 0dd83ff4..c9168985 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -819,11 +819,11 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 			NEXT_ARG();
 			if (link_netnsid != -1)
 				duparg("link-netns/link-netnsid", *argv);
-			link_netnsid = get_netnsid_from_name(*argv);
+			link_netnsid = netns_id_from_name(&rth, *argv);
 			/* No nsid? Try to assign one. */
 			if (link_netnsid < 0)
-				set_netnsid_from_name(*argv, -1);
-			link_netnsid = get_netnsid_from_name(*argv);
+				set_netns_id_from_name(&rth, *argv, -1);
+			link_netnsid = netns_id_from_name(&rth, *argv);
 			if (link_netnsid < 0)
 				invarg("Invalid \"link-netns\" value\n",
 				       *argv);
diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index 972d7e9c..5c943400 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -104,7 +104,7 @@ static int ipnetns_have_nsid(void)
 	return have_rtnl_getnsid;
 }
 
-int get_netnsid_from_name(const char *name)
+static int get_netnsid_from_name(const char *name)
 {
 	netns_nsid_socket_init();
 
@@ -896,33 +896,11 @@ out_delete:
 	return -1;
 }
 
-int set_netnsid_from_name(const char *name, int nsid)
+static int set_netnsid_from_name(const char *name, int nsid)
 {
-	struct {
-		struct nlmsghdr n;
-		struct rtgenmsg g;
-		char            buf[1024];
-	} req = {
-		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct rtgenmsg)),
-		.n.nlmsg_flags = NLM_F_REQUEST,
-		.n.nlmsg_type = RTM_NEWNSID,
-		.g.rtgen_family = AF_UNSPEC,
-	};
-	int fd, err = 0;
-
 	netns_nsid_socket_init();
 
-	fd = netns_get_fd(name);
-	if (fd < 0)
-		return fd;
-
-	addattr32(&req.n, 1024, NETNSA_FD, fd);
-	addattr32(&req.n, 1024, NETNSA_NSID, nsid);
-	if (rtnl_talk(&rth, &req.n, NULL) < 0)
-		err = -2;
-
-	close(fd);
-	return err;
+	return set_netns_id_from_name(&rth, name, nsid);
 }
 
 static int netns_set(int argc, char **argv)
diff --git a/lib/namespace.c b/lib/namespace.c
index d3aeb965..74b7e7ca 100644
--- a/lib/namespace.c
+++ b/lib/namespace.c
@@ -189,6 +189,33 @@ out:
 	return ret;
 }
 
+int set_netns_id_from_name(struct rtnl_handle *rtnl, const char *name, int nsid)
+{
+	struct {
+		struct nlmsghdr n;
+		struct rtgenmsg g;
+		char            buf[1024];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct rtgenmsg)),
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.n.nlmsg_type = RTM_NEWNSID,
+		.g.rtgen_family = AF_UNSPEC,
+	};
+	int fd, err = 0;
+
+	fd = netns_get_fd(name);
+	if (fd < 0)
+		return fd;
+
+	addattr32(&req.n, 1024, NETNSA_FD, fd);
+	addattr32(&req.n, 1024, NETNSA_NSID, nsid);
+	if (rtnl_talk(rtnl, &req.n, NULL) < 0)
+		err = -2;
+
+	close(fd);
+	return err;
+}
+
 struct netns_name_from_id_ctx {
 	int32_t id;
 	char *name;
-- 
2.47.0


