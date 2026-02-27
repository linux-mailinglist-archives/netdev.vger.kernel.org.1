Return-Path: <netdev+bounces-261697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGRHHe4RoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:39:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F7D1B250A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06F8530E6FD8
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955A3332EA4;
	Fri, 27 Feb 2026 03:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsUJWZUs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7853328F8
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163549; cv=none; b=RVH9J6D1bWWnu8LILZ8bNPW+TbVY4jNCMtD0pkGHJ9NNn0p0VURkloWd+Z7bMUKfE9vlzBxWVXyLdoe16Tox53pzzAbRY3acpjniaNuTSVgsaxD2V3XqR16SW5bmBYqsoJI/272FMHw+uXAbr8V8395IGWUWGQHMR8rgiNka3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163549; c=relaxed/simple;
	bh=mLsFahYH4ZBMsdVu2MlB2+J1jI91a0VT09hwjskKyag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ExKy/dBriEG6r8NphQasBD/d/9/UiltIEYSs7ZyHzmHdI33+wnu1C8+6le3fekUf/JN4XmKR5a+yzutZx0eDzqKxwAQxdjmNZHHTNwr7K8gkUrqOyVPXTrffU4eRSCP1XP8HwO0tZTN9zoyA67fVW63Et8a7nBgiYaf88SKehCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsUJWZUs; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354bc535546so1262071a91.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163547; x=1772768347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JWpBkH1jAIPsojAU7ObskyofAr5jmn3nHxDwCWQ5tcU=;
        b=tsUJWZUs1qYfOAoU/NQzPcD+vxO+3RFm2EhIlolbXmQvx005SCSQ+s+/sJDiAIl3TG
         ofDsRcQIM6v+X8MeuSacydBz/kqYgQG9otGRColzdwYi7zv8SmwsYaGNim0bCzcCBGoB
         jVFw0r+TdMMvZSm1HUUZNGsVhS53+01VJgBBAL7wapptTJiooOYGQ5AytAd5xpzbfAfJ
         7dlHkqxxMxj74WSea8fSqhHzc9Tp5nQi+2No4S9KlRribkaPHyZaB3tWF2hFY497+77H
         GtT5++SG6rP1PZb8EkBdq6llfxE0I39TKbSP+uekJUfz5gz5lxcKFUGwX+aZN4NtnblB
         facg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163547; x=1772768347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWpBkH1jAIPsojAU7ObskyofAr5jmn3nHxDwCWQ5tcU=;
        b=uNE1yCfeBD6bhFfm+JKCRT7LC7MweHUjOALP+2IctTMnxpgr88Jm3XFsSib6bN6qOI
         xX8NCxvxaCBeaTIaOyXNFzxYqbBg8OeFr+Czd5L4e7TN9d6TEBl7tIjQGwAJ31Fn2S/y
         HaWgPUs3TKuX/KlrvC7JxDPTOmbXIgOoWs9gslOa3koBgPpcEFoGEDBCFjHMZChdzKMX
         glaAO7t8lUfpCguj2qgPydSOTKpAe3DokGWGCM/VQagFGhoTbH+Bwb3Pgeqq0ZKMN9hw
         Uf7LZInLKzRSQ75u0AaYAX6cqnDsskOZsDxZ0zcYSNmojgFt/A1zy3940pxgGDVYpdMx
         gNfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbBxA6+gvjwG3x8ZN+fxWDDMM0IZHERIMs8G1h65ki41t0pTji4hhsvKPJ11OgJPTtrEJj8iY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx036AvdLdQ7V7QDF5XNl5A5WT0l7Bt4d9uXIqw2p/dd3zDY72/
	w6PTTY6h8SSSsblvyeWx/aHhZcSlzi8pUqgnvz6i+KM5uKkl3lTKpjSA7x8ohtm39c+E2zUfo63
	dy3Y5TA==
X-Received: from pjbbf12.prod.google.com ([2002:a17:90b:b0c:b0:358:b621:29b7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f8a:b0:34c:35ce:3c5f
 with SMTP id 98e67ed59e1d1-35965c1708amr1081853a91.5.1772163547078; Thu, 26
 Feb 2026 19:39:07 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:24 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 01/15] selftest: net: Add basic functionality
 tests for ipmr.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261697-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8F7D1B250A
X-Rspamd-Action: no action

The new test exercise paths, where RTNL is needed, to
catch lockdep splat:

  setsockopt
    MRT_INIT / MRT_DONE
    MRT_ADD_VIF / MRT_DEL_VIF
    MRT_ADD_MFC / MRT_DEL_MFC / MRT_ADD_MFC_PROXY / MRT_DEL_MFC_PROXY
    MRT_TABLE
    MRT_FLUSH

  rtnetlink
    RTM_NEWROUTE
    RTM_DELROUTE

  NETDEV_UNREGISTER

I will extend this to cover IPv6 setsockopt() later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Add ipmr to .gitignore
---
 .../selftests/net/forwarding/.gitignore       |   1 +
 .../testing/selftests/net/forwarding/Makefile |   4 +
 tools/testing/selftests/net/forwarding/ipmr.c | 455 ++++++++++++++++++
 3 files changed, 460 insertions(+)
 create mode 100644 tools/testing/selftests/net/forwarding/ipmr.c

diff --git a/tools/testing/selftests/net/forwarding/.gitignore b/tools/testing/selftests/net/forwarding/.gitignore
index 2dea317f12e7..418ff96c52ef 100644
--- a/tools/testing/selftests/net/forwarding/.gitignore
+++ b/tools/testing/selftests/net/forwarding/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 forwarding.config
+ipmr
diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index ff4a00d91a26..bbaf4d937dd8 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -133,6 +133,10 @@ TEST_FILES := \
 	tc_common.sh \
 # end of TEST_FILES
 
+TEST_GEN_PROGS := \
+	ipmr
+# end of TEST_GEN_PROGS
+
 TEST_INCLUDES := \
 	$(wildcard ../lib/sh/*.sh) \
 	../lib.sh \
diff --git a/tools/testing/selftests/net/forwarding/ipmr.c b/tools/testing/selftests/net/forwarding/ipmr.c
new file mode 100644
index 000000000000..b6b00e36b3ce
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/ipmr.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2026 Google LLC */
+
+#include <linux/if.h>
+#include <linux/mroute.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/socket.h>
+#include <sched.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+
+#include "kselftest_harness.h"
+
+FIXTURE(ipmr)
+{
+	int netlink_sk;
+	int raw_sk;
+	int veth_ifindex;
+};
+
+FIXTURE_VARIANT(ipmr)
+{
+	int family;
+	int protocol;
+	int level;
+	int opts[MRT_MAX - MRT_BASE + 1];
+};
+
+FIXTURE_VARIANT_ADD(ipmr, ipv4)
+{
+	.family = AF_INET,
+	.protocol = IPPROTO_IGMP,
+	.level = IPPROTO_IP,
+	.opts = {
+		MRT_INIT,
+		MRT_DONE,
+		MRT_ADD_VIF,
+		MRT_DEL_VIF,
+		MRT_ADD_MFC,
+		MRT_DEL_MFC,
+		MRT_VERSION,
+		MRT_ASSERT,
+		MRT_PIM,
+		MRT_TABLE,
+		MRT_ADD_MFC_PROXY,
+		MRT_DEL_MFC_PROXY,
+		MRT_FLUSH,
+	},
+};
+
+struct mfc_attr {
+	int table;
+	__u32 origin;
+	__u32 group;
+	int ifindex;
+	bool proxy;
+};
+
+static struct rtattr *nl_add_rtattr(struct nlmsghdr *nlmsg, struct rtattr *rta,
+				    int type, const void *data, int len)
+{
+	int unused;
+
+	rta->rta_type = type;
+	rta->rta_len = RTA_LENGTH(len);
+	memcpy(RTA_DATA(rta), data, len);
+
+	nlmsg->nlmsg_len += NLMSG_ALIGN(rta->rta_len);
+
+	return RTA_NEXT(rta, unused);
+}
+
+static int nl_sendmsg_mfc(struct __test_metadata *_metadata, FIXTURE_DATA(ipmr) *self,
+			  __u16 nlmsg_type, struct mfc_attr *mfc_attr)
+{
+	struct {
+		struct nlmsghdr nlmsg;
+		struct rtmsg rtm;
+		char buf[4096];
+	} req = {
+		.nlmsg = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(req.rtm)),
+			/* ipmr does not care about NLM_F_CREATE and NLM_F_EXCL ... */
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+			.nlmsg_type = nlmsg_type,
+		},
+		.rtm = {
+			/* hard requirements in rtm_to_ipmr_mfcc() */
+			.rtm_family = RTNL_FAMILY_IPMR,
+			.rtm_dst_len = 32,
+			.rtm_type = RTN_MULTICAST,
+			.rtm_scope = RT_SCOPE_UNIVERSE,
+			.rtm_protocol = RTPROT_MROUTED,
+		},
+	};
+	struct nlmsghdr *nlmsg = &req.nlmsg;
+	struct nlmsgerr *errmsg;
+	struct rtattr *rta;
+	int err;
+
+	rta = (struct rtattr *)&req.buf;
+	rta = nl_add_rtattr(nlmsg, rta, RTA_TABLE, &mfc_attr->table, sizeof(mfc_attr->table));
+	rta = nl_add_rtattr(nlmsg, rta, RTA_SRC, &mfc_attr->origin, sizeof(mfc_attr->origin));
+	rta = nl_add_rtattr(nlmsg, rta, RTA_DST, &mfc_attr->group, sizeof(mfc_attr->group));
+	if (mfc_attr->ifindex)
+		rta = nl_add_rtattr(nlmsg, rta, RTA_IIF, &mfc_attr->ifindex, sizeof(mfc_attr->ifindex));
+	if (mfc_attr->proxy)
+		rta = nl_add_rtattr(nlmsg, rta, RTA_PREFSRC, NULL, 0);
+
+	err = send(self->netlink_sk, &req, req.nlmsg.nlmsg_len, 0);
+	ASSERT_EQ(err, req.nlmsg.nlmsg_len);
+
+	memset(&req, 0, sizeof(req));
+
+	err = recv(self->netlink_sk, &req, sizeof(req), 0);
+	ASSERT_TRUE(NLMSG_OK(nlmsg, err));
+	ASSERT_EQ(NLMSG_ERROR, nlmsg->nlmsg_type);
+
+	errmsg = (struct nlmsgerr *)NLMSG_DATA(nlmsg);
+	return errmsg->error;
+}
+
+FIXTURE_SETUP(ipmr)
+{
+	struct ifreq ifr = {
+		.ifr_name = "veth0",
+	};
+	int err;
+
+	err = unshare(CLONE_NEWNET);
+	ASSERT_EQ(0, err);
+
+	self->netlink_sk = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+	ASSERT_LE(0, self->netlink_sk);
+
+	self->raw_sk = socket(variant->family, SOCK_RAW, variant->protocol);
+	ASSERT_LT(0, self->raw_sk);
+
+	err = system("ip link add veth0 type veth peer veth1");
+	ASSERT_EQ(0, err);
+
+	err = ioctl(self->raw_sk, SIOCGIFINDEX, &ifr);
+	ASSERT_EQ(0, err);
+
+	self->veth_ifindex = ifr.ifr_ifindex;
+}
+
+FIXTURE_TEARDOWN(ipmr)
+{
+	close(self->raw_sk);
+	close(self->netlink_sk);
+}
+
+TEST_F(ipmr, mrt_init)
+{
+	int err, val = 0;  /* any value is ok, but size must be int for MRT_INIT. */
+
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_INIT - MRT_BASE],
+			 &val,  sizeof(val));
+	ASSERT_EQ(0, err);
+
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_DONE - MRT_BASE],
+			 &val,  sizeof(val));
+	ASSERT_EQ(0, err);
+}
+
+TEST_F(ipmr, mrt_add_vif_register)
+{
+	struct vifctl vif = {
+		.vifc_vifi = 0,
+		.vifc_flags = VIFF_REGISTER,
+	};
+	int err;
+
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
+			 &vif,  sizeof(vif));
+	ASSERT_EQ(0, err);
+
+	err = system("cat /proc/net/ip_mr_vif | grep -q pimreg");
+	ASSERT_EQ(0, err);
+
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_DEL_VIF - MRT_BASE],
+			 &vif,  sizeof(vif));
+	ASSERT_EQ(0, err);
+}
+
+TEST_F(ipmr, mrt_del_vif_unreg)
+{
+	struct vifctl vif = {
+		.vifc_vifi = 0,
+		.vifc_flags = VIFF_USE_IFINDEX,
+		.vifc_lcl_ifindex = self->veth_ifindex,
+	};
+	int err;
+
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
+			 &vif,  sizeof(vif));
+	ASSERT_EQ(0, err);
+
+	err = system("cat /proc/net/ip_mr_vif | grep -q veth0");
+	ASSERT_EQ(0, err);
+
+	/* VIF is removed along with its device. */
+	err = system("ip link del veth0");
+	ASSERT_EQ(0, err);
+
+	/* mrt->vif_table[veth_ifindex]->dev is NULL. */
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_DEL_VIF - MRT_BASE],
+			 &vif,  sizeof(vif));
+	ASSERT_EQ(-1, err);
+	ASSERT_EQ(EADDRNOTAVAIL, errno);
+}
+
+TEST_F(ipmr, mrt_del_vif_netns_dismantle)
+{
+	struct vifctl vif = {
+		.vifc_vifi = 0,
+		.vifc_flags = VIFF_USE_IFINDEX,
+		.vifc_lcl_ifindex = self->veth_ifindex,
+	};
+	int err;
+
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
+			 &vif,  sizeof(vif));
+	ASSERT_EQ(0, err);
+
+	/* Let cleanup_net() remove veth0 and VIF. */
+}
+
+TEST_F(ipmr, mrt_add_mfc)
+{
+	struct mfcctl mfc = {};
+	int err;
+
+	/* MRT_ADD_MFC / MRT_ADD_MFC_PROXY does not need vif to exist (unlike netlink). */
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_ADD_MFC - MRT_BASE],
+			 &mfc,  sizeof(mfc));
+	ASSERT_EQ(0, err);
+
+	/* (0.0.0.0 -> 0.0.0.0) */
+	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	ASSERT_EQ(0, err);
+
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_DEL_MFC - MRT_BASE],
+			 &mfc,  sizeof(mfc));
+}
+
+TEST_F(ipmr, mrt_add_mfc_proxy)
+{
+	struct mfcctl mfc = {};
+	int err;
+
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_ADD_MFC_PROXY - MRT_BASE],
+			 &mfc,  sizeof(mfc));
+	ASSERT_EQ(0, err);
+
+	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	ASSERT_EQ(0, err);
+
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_DEL_MFC_PROXY - MRT_BASE],
+			 &mfc,  sizeof(mfc));
+}
+
+TEST_F(ipmr, mrt_add_mfc_netlink)
+{
+	struct vifctl vif = {
+		.vifc_vifi = 0,
+		.vifc_flags = VIFF_USE_IFINDEX,
+		.vifc_lcl_ifindex = self->veth_ifindex,
+	};
+	struct mfc_attr mfc_attr = {
+		.table = RT_TABLE_DEFAULT,
+		.origin = 0,
+		.group = 0,
+		.ifindex = self->veth_ifindex,
+		.proxy = false,
+	};
+	int err;
+
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
+			 &vif,  sizeof(vif));
+	ASSERT_EQ(0, err);
+
+	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	ASSERT_EQ(0, err);
+
+	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	ASSERT_EQ(0, err);
+
+	err = nl_sendmsg_mfc(_metadata, self, RTM_DELROUTE, &mfc_attr);
+	ASSERT_EQ(0, err);
+}
+
+TEST_F(ipmr, mrt_add_mfc_netlink_proxy)
+{
+	struct vifctl vif = {
+		.vifc_vifi = 0,
+		.vifc_flags = VIFF_USE_IFINDEX,
+		.vifc_lcl_ifindex = self->veth_ifindex,
+	};
+	struct mfc_attr mfc_attr = {
+		.table = RT_TABLE_DEFAULT,
+		.origin = 0,
+		.group = 0,
+		.ifindex = self->veth_ifindex,
+		.proxy = true,
+	};
+	int err;
+
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
+			 &vif,  sizeof(vif));
+	ASSERT_EQ(0, err);
+
+	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	ASSERT_EQ(0, err);
+
+	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	ASSERT_EQ(0, err);
+
+	err = nl_sendmsg_mfc(_metadata, self, RTM_DELROUTE, &mfc_attr);
+	ASSERT_EQ(0, err);
+}
+
+TEST_F(ipmr, mrt_add_mfc_netlink_no_vif)
+{
+	struct mfc_attr mfc_attr = {
+		.table = RT_TABLE_DEFAULT,
+		.origin = 0,
+		.group = 0,
+		.proxy = false,
+	};
+	int err;
+
+	/* netlink always requires RTA_IIF of an existing vif. */
+	mfc_attr.ifindex = 0;
+	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	ASSERT_EQ(-ENFILE, err);
+
+	/* netlink always requires RTA_IIF of an existing vif. */
+	mfc_attr.ifindex = self->veth_ifindex;
+	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	ASSERT_EQ(-ENFILE, err);
+}
+
+TEST_F(ipmr, mrt_del_mfc_netlink_netns_dismantle)
+{
+	struct vifctl vifs[2] = {
+		{
+			.vifc_vifi = 0,
+			.vifc_flags = VIFF_USE_IFINDEX,
+			.vifc_lcl_ifindex = self->veth_ifindex,
+		},
+		{
+			.vifc_vifi = 1,
+			.vifc_flags = VIFF_REGISTER,
+		}
+	};
+	struct mfc_attr mfc_attr = {
+		.table = RT_TABLE_DEFAULT,
+		.origin = 0,
+		.group = 0,
+		.ifindex = self->veth_ifindex,
+		.proxy = false,
+	};
+	int i, err;
+
+	for (i = 0; i < 2; i++) {
+		/* Create 2 VIFs just to avoid -ENFILE later. */
+		err = setsockopt(self->raw_sk,
+				 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
+				 &vifs[i],  sizeof(vifs[i]));
+		ASSERT_EQ(0, err);
+	}
+
+	/* Create a MFC for mrt->vif_table[0]. */
+	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	ASSERT_EQ(0, err);
+
+	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	ASSERT_EQ(0, err);
+
+	/* Remove mrt->vif_table[0]. */
+	err = system("ip link del veth0");
+	ASSERT_EQ(0, err);
+
+	/* MFC entry is NOT removed even if the tied VIF is removed... */
+	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	ASSERT_EQ(0, err);
+
+	/* ... and netlink is not capable of removing such an entry
+	 * because netlink always requires a valid RTA_IIF ... :/
+	 */
+	err = nl_sendmsg_mfc(_metadata, self, RTM_DELROUTE, &mfc_attr);
+	ASSERT_EQ(-ENODEV, err);
+
+	/* It can be removed by setsockopt(), but let cleanup_net() remove this time. */
+}
+
+TEST_F(ipmr, mrt_table_flush)
+{
+	struct vifctl vif = {
+		.vifc_vifi = 0,
+		.vifc_flags = VIFF_USE_IFINDEX,
+		.vifc_lcl_ifindex = self->veth_ifindex,
+	};
+	struct mfc_attr mfc_attr = {
+		.origin = 0,
+		.group = 0,
+		.ifindex = self->veth_ifindex,
+		.proxy = false,
+	};
+	int table_id = 92;
+	int err, flags;
+
+	/* Set a random table id rather than RT_TABLE_DEFAULT.
+	 * Note that /proc/net/ip_mr_{vif,cache} only supports RT_TABLE_DEFAULT.
+	 */
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_TABLE - MRT_BASE],
+			 &table_id,  sizeof(table_id));
+	ASSERT_EQ(0, err);
+
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
+			 &vif,  sizeof(vif));
+	ASSERT_EQ(0, err);
+
+	mfc_attr.table = table_id;
+	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	ASSERT_EQ(0, err);
+
+	/* Flush mrt->vif_table[] and all caches. */
+	flags = MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
+		MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC;
+	err = setsockopt(self->raw_sk,
+			 variant->level, variant->opts[MRT_FLUSH - MRT_BASE],
+			 &flags,  sizeof(flags));
+	ASSERT_EQ(0, err);
+}
+
+TEST_HARNESS_MAIN
-- 
2.53.0.473.g4a7958ca14-goog


