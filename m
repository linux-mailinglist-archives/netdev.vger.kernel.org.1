Return-Path: <netdev+bounces-261124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJKCJOuxn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B131A024E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E809302BB84
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7350837473B;
	Thu, 26 Feb 2026 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5ijIyyc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF2378825
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073404; cv=none; b=Krz/SdjvkPRyMt3bpqr0Ef0kh2tcc6Ct0M7yDoIN0uzSJ6pgbC3gdWFgAHPvlDxRGcCBwzDqjYjtIY2nyx5MT73neK0jUB2jymRI+X8rR+E/s1KFEWycZW/+KTlR1wjKhNb81SHf5q5Q9INFsy+FHm4Av20UnN20hIX8xrGbRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073404; c=relaxed/simple;
	bh=KpI86Fjh38rTUPhVOuXf1aBu1HC3m1EAkkxXpL34l18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pv+bB3x1w4Kiz3sGIngViaHMNTTSlcj1j4u80aeg5PG7KbcCWZEWM69FrzLN21GjUak/l956FiXClHw6UqAiODAQdYkCSFKGHeb9ZVD+9Z/5GzblncgmUGl6DxxqIBwYblXc9y4hL3ZY13U3fStMAUJDU54hxFkzl7HwkUXWkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5ijIyyc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354bee18a62so182502a91.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073402; x=1772678202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCo8fElmcfnQTvaa2KqdjtmbrMexRVGvzZFU2vExcjc=;
        b=P5ijIyycneVyKBQeF7djMPkwxTm/jB/egIBQGMcDWCAqXmMwTXkVcVZSmIy11NXERp
         /dhVCfxMkHUHFDCO5Ik0ClEAq5c5Qkuo66tL7Ag1HbriEdLZQEo2REMB+W1FkgMSOqnN
         kDRN5Tqn6Kwsq6cA78NMyLTKslxuIi8JBHxUnmw2i0wmjHvzjxkKM+Aj6W3W3Rrq6a9c
         ewJdCuPrcYZ6wCaMp62yjBAtn8Qs/1/gb3Fv9Ht/r8LAHlmW7PyVQrCvxWmwzLc0um8I
         U02M6q+ZImROw+5NYeJArcn7t4T7Bc4GZkAXyDSZzTJ2DJBJ4vpz1OgDkvjfSN7ydbgh
         ovnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073402; x=1772678202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCo8fElmcfnQTvaa2KqdjtmbrMexRVGvzZFU2vExcjc=;
        b=tFRa8A9Dd8u3bITnAv7+m9xoJcTAL2qQMSPBW5d0rT1liucVJpgux9M8H7mo9+1JMg
         vp6/g7PMgdPh0+5i/Vg/2/vJBBqsGwJJg7LSlBNzBFUjj0ln8CY0Jk/dQ6C572kJXxCy
         ujh2TZ+fabFwA10xRWSpi5lF2lXstr0qsxkzc+jj7oghckcMkw7o+qcIRz9NbT7O1BNQ
         UCJ+qkR8YNVO4AolbIJ6T/PkHYn107SuKWM0Fp9JuVdvQfdG1PjGABRq7PTkJiCiVfU7
         AP+DdE9owDOK7HEoJVpaLSCmozjA1Wkw0y5BzadVzJKnI3x0xq/PqmzB2XLA/XpILwkc
         4/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCV2mJBj2K0l4/e4MLe9E8iinMcPQOKpFA9jIPMFk3bnoFScYVN9puYk8MHipMmaCGpyawii7BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrZakHWVZXMz047v9zLjn0MYjdH2zZRPVpu4DMHrq272jVKeUd
	ydAMia+krLs2n/i/WbRIGuofNeGkhEscnGVIeGfmRYvUPqefzNZLw9JMDFZ/Le1ctweOP90Y7On
	caPwoUg==
X-Received: from pjvc14.prod.google.com ([2002:a17:90a:d90e:b0:353:28b4:c297])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2507:b0:359:2204:a29
 with SMTP id 98e67ed59e1d1-35922040d96mr1620928a91.27.1772073401997; Wed, 25
 Feb 2026 18:36:41 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:13 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 01/15] selftest: net: Add basic functionality
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261124-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3B131A024E
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
 .../testing/selftests/net/forwarding/Makefile |   4 +
 tools/testing/selftests/net/forwarding/ipmr.c | 455 ++++++++++++++++++
 2 files changed, 459 insertions(+)
 create mode 100644 tools/testing/selftests/net/forwarding/ipmr.c

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
index 000000000000..699d8237d226
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
+			/* ipmr does not care about NLM_F_CREATE and NLM_F_EXCL ... */
+			.nlmsg_len = NLMSG_LENGTH(sizeof(req.rtm)),
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
2.53.0.414.gf7e9f6c205-goog


