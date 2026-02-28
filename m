Return-Path: <netdev+bounces-262234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCrCE7Bpo2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:18:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F5A1C9702
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E30D3056164
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4813D3CFD;
	Sat, 28 Feb 2026 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZU10YED"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAEB3D410E
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317087; cv=none; b=NpWew6SiGm+MhXdW6/Ufuz85W1W8MYSOzpmBgYUY9mJnRQi88y7BcQ0R6ej8kRULxwJF5xwuwPjxfWOFml2Og/4vezQIIBrQOm6QUdB89qjhclUMulY4vGvhI5Ne9wudg1EPDMAH50hfw2F5DCbDGjgOzqDmoDEEhp06JofLDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317087; c=relaxed/simple;
	bh=rE0N5rEPdp1YidW5cLLJyoc6gm4/qfDpDATuCEGep9Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uprPPuWMw33UPCpVNVBg++QvbT2+6AdPXFsDcv6n6U1F+wYRyE1YPKMLaCFtnPl8l578vonMsZDM/xww+IdMkfitXd2wjdHJO1OKwlMnfwZqkS1oDdstNMOrzMUqsvBMb/qOdwT+snYkiOr35NCLCdA02WKsKHTSaMY0Jr+lIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZU10YED; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2adba04421eso203468525ad.3
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772317085; x=1772921885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZJIsYyhTjzM2SzhXTReAkIkHVWLHiDOSiwF7dP5XHw=;
        b=PZU10YED6NKriCh65+1HSl4dg4XA1ru5gkSFk1BVK7pJ33mF+o8LHk5JGDoYUapzr4
         mN5KB8pQLGKdxlzLZbytw47TqwXNxWh+nOYsUYzFQ6bc/PPT9bxn9fAWDdUds2EOhubU
         otWS1Ta4O+/P4lRkx60PmhsmQBX170umO4VH+UwvFT62MEKvglWALBKVwMTzJ5tz5zrO
         Euz5K+myue4Qoa4oq5EEGbN7UYCUOanKOhAXQ5EajBshQc1Lb6XVYwiZNYKRDSn9qXyy
         hGT94R5hSgFHgIq8oCUSH3pa5rfaupI+miVxmcy5MR0PZBOGAlHCbOApyWK7bOCZbEKz
         Cedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317085; x=1772921885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZJIsYyhTjzM2SzhXTReAkIkHVWLHiDOSiwF7dP5XHw=;
        b=Qb8GU5ovdT+LEkvTRlEvUxSKP9jAbG2GGnzef5eS89fw2dXvw1RQfNECqg2DXFG+Wo
         4ownal5Z+lDjsVNhS1Dz2zTUPXqb2lctj05VNlJjQZNSRCQ5ocWjUheK+e4B0JZR96u5
         2gMwsmXVcgzraptaNbFIqFokc/9FmQsPV6r4qoX7VRcP79klRT4eKLAdtSqapVQeo2cT
         6cMoD1WHSxjSNeDJYoe9oqeZwIhmfuNWfkDRdFp8fGhBq3tqlBoGFjYO5DJNU3vCLRf7
         upPx50UPXiCu+k7Mw9OdF2OnyqJs9H3hnuP1C9b8/vejeaBJ7qbkb0dK7xtxB25wDq6y
         dUPg==
X-Forwarded-Encrypted: i=1; AJvYcCWmaTNbunvrZP4QNXC8GVtvCeRxYFXkKNv3qVM9g/etFHborLR2a2nRCWs2crrG68XnUIPt65I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs9osIPQSrfOEQj3j2CFIYA1cmDScFNymA+YidOxvXdVHdbvad
	3P4fOhlQFqCXdSxifx5wBlQoxm19b8KVhXM8t13BCWLthcYgQSsPWDW2Yh61io9w3vyg9wHiqjG
	bRVweQA==
X-Received: from plbkh6.prod.google.com ([2002:a17:903:646:b0:29f:bf99:8c9f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d58c:b0:2ae:48c6:65f6
 with SMTP id d9443c01a7336-2ae48c6690bmr3480245ad.25.1772317084630; Sat, 28
 Feb 2026 14:18:04 -0800 (PST)
Date: Sat, 28 Feb 2026 22:17:19 +0000
In-Reply-To: <20260228221800.1082070-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228221800.1082070-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228221800.1082070-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 01/15] selftest: net: Add basic functionality
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
	TAGGED_FROM(0.00)[bounces-262234-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9F5A1C9702
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v3: Init @unused in nl_add_rtattr().
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
index 000000000000..df870aad9ead
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
+	int unused = 0;
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


