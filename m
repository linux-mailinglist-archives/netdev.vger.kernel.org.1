Return-Path: <netdev+bounces-129897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE56986F1F
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B871C2269B
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 08:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F771A7048;
	Thu, 26 Sep 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj058Qsy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D381A4E9C
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340242; cv=none; b=skTE8L0D7f9s3QFgzu8h/zlXyLNSt0NhHwwYBdgjddEfTWW39G3bGoY96GgkahNlQI9HQ3tvDpwRqKb+hC3RKbbqsmEbou14dUQrBEmEaMBdRoIkQFEh0wsh94+XXL/+l1eWXpLQIdvdZaVnS4vnv9gvgzoCC3beZIDXhJm8Jj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340242; c=relaxed/simple;
	bh=YxDZzaTR+p8zgrGAd/zAggXRdq8j4M7yvh8AREinvqc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvOk+M1NY2+W1A+mptKp1Jsk4x/oSGXHr+qD9Lqsyblk/y4Hs7L04dFYhe8KYnVkwMTJFrmTdmCUq7naRqHA3dDaWOsVkzeJjo8WCYe17JLuUmSKAzpZmSttpyltcy+/P54aM48CHj237UJjie6YrMO/d6Qt2plAFg+epIOjzJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj058Qsy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso485754a12.0
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727340241; x=1727945041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kw4R85P0OiKFUFdklWi6vUuH2mzjFxuon5M5/G3zCLo=;
        b=Tj058Qsyym8fd/YYfH2vYQ18VuR4vY6ihF3UMJMCMacaN+XGEqAj/zYfRiP80luRnF
         wTUL7RBNPawdKNbtKVpXsrbgc4vKtDlgvXu+kcq8sM/9IpyYonNWlp57UOCxDor7NSk5
         1tzJkcYVKGTWUbsNU9msakzx6mp+DOm9fDPgcGrWClmACOtnI5VUuH5av4lbULdWun1U
         UzXv9HSsHeu9TkriRaWCFrLs7KIcFhN5j9RbL1XyrugbvOS1mSI9FSbRDnMnh5RXSL2q
         Q1A8i3rfPMWdoV7bzzN4SdbyMaoVaKEgkSbAXzOzvWurkBrDYbLdDKKELYSM4FsYrOuC
         shiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727340241; x=1727945041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kw4R85P0OiKFUFdklWi6vUuH2mzjFxuon5M5/G3zCLo=;
        b=I/9dm7PA67NAA3hRmHbxzdPRXxXLDS6qxO7DFB/kIrzg6MdKNDIQITt+730aSMbhTl
         aKcN6BHy9KxEX8ZhBFOfM3cJ4PI3mDetZA5YGOb6/vYeMiS7aSeguNsP3sqKQ1WAkfXq
         H/BYPs6fhyXvqp5N/aRP/54iHcQOvHHEa9Wnbth8Qtvu7LwZQ6qJV2EWseAJCywAnFlC
         hCboZd/Wk9OXkyd0juA59EMLYjcxzSJbWeMiM4WIrXbzrMLoGzPX/dzLAztr4oGLhbwJ
         AJGCEN/3XJOTXo3nF0uwobl2A57s8oH0s9n3jAHDz5Jr0s3/qQ4CpW0CD9itlL64MVdI
         1zrA==
X-Forwarded-Encrypted: i=1; AJvYcCVEWI7nenbJeNlUTubAo+ZPGVJoHZP92N4PXqvQCQ9syNBK6QvcR8ixD/BnvLqGsoa5VnBSktU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAU0G4dtp34279ManAK93wIGArOvj5TKaoczb1VIGHtQdWkrc+
	Xz1rQCI+SxlQfCBa5cG9l8YMkmRrF23f9wIZ4tYNvI0KekNVFMQIXA9VVYYa
X-Google-Smtp-Source: AGHT+IER7rJTzlO4Dh3yiQoWVHITBfJDb8iikqJpPTL9F73N4uxli8hE5i00qTrJqjyJAYtplAUo9A==
X-Received: by 2002:a05:6a21:b8b:b0:1cf:53ea:7fbc with SMTP id adf61e73a8af0-1d4d4aaf486mr7520097637.18.1727340240595;
        Thu, 26 Sep 2024 01:44:00 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc93903asm3875888b3a.113.2024.09.26.01.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:44:00 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 1/2] ip: Move of set_netnsid_from_name() to namespace.c
Date: Thu, 26 Sep 2024 16:43:39 +0800
Message-ID: <20240926084344.740434-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240926084344.740434-1-shaw.leon@gmail.com>
References: <20240926084344.740434-1-shaw.leon@gmail.com>
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
index 3bc75d24..fd7fc44a 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -817,11 +817,11 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
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
2.46.2


