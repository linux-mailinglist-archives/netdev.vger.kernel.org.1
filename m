Return-Path: <netdev+bounces-295452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VLYHDrwAImrqRQEAu9opvQ
	(envelope-from <netdev+bounces-295452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A51F6643DC3
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=WnhiddlQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295452-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295452-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A19E3010169
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E3B30594E;
	Thu,  4 Jun 2026 22:47:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64227587D
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613238; cv=none; b=Et/XPGZu6Rr9X55qmNY4LpmoTWMolQCNGP0iZTqOnh5YGL9KaCePMP5KGJnG0VJxObTaX2E1Yq12hfP/KhizdH4ewMfPqUmFzfw4onFBbiQYFZC3wUWFGuiJhzcQ16o3lP9+qlhwyrvqntbHtebMR9qQmpRXmF8Sras2FLxRohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613238; c=relaxed/simple;
	bh=C5fXWhk5lurpZjrYcDHzfX6WLd88F01FYW6bHyNAqqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IsXK+DCPuPL8Tdh9cH6pl9iG5sPhQNtWxO4/5jl0+HGRs8HSBidYmppqlswK3EH1afWXge0cqsdZ/mbfelfkWG3UEkZFhj3Zbnma3tikZuOjPUmGbB2xkVtTimk/P3vEPx7MAfbG6Cch62T3JufVAEOYxMuX5HX3sCy/NLy/9CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WnhiddlQ; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f6247c6so1388903b3a.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613236; x=1781218036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ckMGYrLNPmSPBTOMkJvXMGXX8VPHPT+B0jzcw9eZxog=;
        b=WnhiddlQSbhZLn8ErB0tpi+/RGhWrV7CgirpOGkfq3B1s25DhIyXTueyAVDmnarDX9
         LWdFlYRJZGWPylX1J7UHndDUfnuCoKX8Bd0kC/Nx5GYlj8TshTVCIpKXk2o4fzeAwRHL
         ZB5xEPFcOql6dV8IsTAz4oG9jeeyTNgr9QV+f07HtVJe2ITJ+/9fbADQ/jiGF12KLQX6
         5eN7HIhb427vC7Z0e68N7ws/q89sd7YU/HfYcSZ+BwvnvDYvTuF6DUr31L6q2aWrXa5A
         xAEKb4TUJvToTYCGG3M5qYWdlBAtRmbxDmTAUcjEFDvAUZCBGDYXanJ9iv/GlX+GJE2l
         d2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613236; x=1781218036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckMGYrLNPmSPBTOMkJvXMGXX8VPHPT+B0jzcw9eZxog=;
        b=fs3j/WHHF7UxhGPlzz97g96dwPSBYbhMWTj+jxJtjs8hvYwm8rJoU97/E8fDb2888Q
         AGujzgeido4885mme7jIs4qwAyaz+bBlDNs75/+u/ZlWvqn835FFJcen6Q6oC4ERbP8N
         J3LnWTJ4Ev4KgygC08wGOHNTDypjccKR0Wu8aKYJM6mhOiee9io2+0yF+cv+x2ni+Hld
         IjXN9xjronOiKkwMQrKHBmi5lj4jAgp7QmUoGV9RlScdYfMH57mTTmLA6Ve8jkXzztd9
         tJtxHWiRio6ID5iCxFzpuheJ82dyImuq77XTn7jZkqgPwdeU9lze1P4EZM5Y8QauIJCK
         56JQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DdHMxuA6FNpEJXCJTQIBH0dRKALtPY0EEQJiEliWwYNPcAfJyGcQwsg0C+TUTn7kInazb55M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlE3N9RhDEj2OBEOq+lATvCpN1i/DIMDaAe0tUo89lhnken8Uz
	53Po+YPU3l/BFvYNO9OwaYlAI5Mz6XX6waeq/K4o/ng6PQJqmgUHBDimknhxnYMNvxXro3U1Dl+
	JMdSqtA==
X-Received: from pfbgc3.prod.google.com ([2002:a05:6a00:62c3:b0:842:3963:226a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a205:b0:82f:425b:4c27
 with SMTP id d2e1a72fcca58-842b0de3d8cmr598094b3a.14.1780613235326; Thu, 04
 Jun 2026 15:47:15 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:19 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 01/15] selftest: net: Extend ipmr.c for IP6MR.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295452-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A51F6643DC3

This commit extends most test cases in ipmr.c for IPV6MR.

Note that IP6MR does not provide rtnetlink interface for MFC,
so such tests are added to XFAIL_ADD().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/forwarding/ipmr.c | 189 +++++++++++-------
 1 file changed, 122 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/ipmr.c b/tools/testing/selftests/net/forwarding/ipmr.c
index df870aad9ead..9cd9f70de132 100644
--- a/tools/testing/selftests/net/forwarding/ipmr.c
+++ b/tools/testing/selftests/net/forwarding/ipmr.c
@@ -2,7 +2,9 @@
 /* Copyright 2026 Google LLC */
 
 #include <linux/if.h>
+#include <linux/in6.h>
 #include <linux/mroute.h>
+#include <linux/mroute6.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
 #include <linux/socket.h>
@@ -17,6 +19,14 @@ FIXTURE(ipmr)
 	int netlink_sk;
 	int raw_sk;
 	int veth_ifindex;
+	union {
+		struct vifctl vif;
+		struct mif6ctl vif6;
+	};
+	union {
+		struct mfcctl mfc;
+		struct mf6cctl mfc6;
+	};
 };
 
 FIXTURE_VARIANT(ipmr)
@@ -24,7 +34,14 @@ FIXTURE_VARIANT(ipmr)
 	int family;
 	int protocol;
 	int level;
+	int rtm_family;
 	int opts[MRT_MAX - MRT_BASE + 1];
+	int flush_flags;
+	int vif_size;
+	char vif_check_cmd_pimreg[64];
+	char vif_check_cmd_veth[64];
+	int mfc_size;
+	char mfc_check_cmd[1024];
 };
 
 FIXTURE_VARIANT_ADD(ipmr, ipv4)
@@ -32,6 +49,7 @@ FIXTURE_VARIANT_ADD(ipmr, ipv4)
 	.family = AF_INET,
 	.protocol = IPPROTO_IGMP,
 	.level = IPPROTO_IP,
+	.rtm_family = RTNL_FAMILY_IPMR,
 	.opts = {
 		MRT_INIT,
 		MRT_DONE,
@@ -47,6 +65,44 @@ FIXTURE_VARIANT_ADD(ipmr, ipv4)
 		MRT_DEL_MFC_PROXY,
 		MRT_FLUSH,
 	},
+	.flush_flags = MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC |
+		MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC,
+	.vif_size = sizeof(struct vifctl),
+	.vif_check_cmd_pimreg = "cat /proc/net/ip_mr_vif | grep -q pimreg",
+	.vif_check_cmd_veth = "cat /proc/net/ip_mr_vif | grep -q veth",
+	.mfc_size = sizeof(struct mfcctl),
+	.mfc_check_cmd = "cat /proc/net/ip_mr_cache | grep -q '00000000 00000000'",
+};
+
+FIXTURE_VARIANT_ADD(ipmr, ipv6)
+{
+	.family = AF_INET6,
+	.protocol = IPPROTO_ICMPV6,
+	.level = IPPROTO_IPV6,
+	.rtm_family = RTNL_FAMILY_IP6MR,
+	.opts = {
+		MRT6_INIT,
+		MRT6_DONE,
+		MRT6_ADD_MIF,
+		MRT6_DEL_MIF,
+		MRT6_ADD_MFC,
+		MRT6_DEL_MFC,
+		MRT6_VERSION,
+		MRT6_ASSERT,
+		MRT6_PIM,
+		MRT6_TABLE,
+		MRT6_ADD_MFC_PROXY,
+		MRT6_DEL_MFC_PROXY,
+		MRT6_FLUSH,
+	},
+	.flush_flags = MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC |
+		MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC,
+	.vif_size = sizeof(struct mif6ctl),
+	.vif_check_cmd_pimreg = "cat /proc/net/ip6_mr_vif | grep -q pim6reg",
+	.vif_check_cmd_veth = "cat /proc/net/ip6_mr_vif | grep -q veth",
+	.mfc_size = sizeof(struct mf6cctl),
+	.mfc_check_cmd = "cat /proc/net/ip6_mr_cache | "
+		"grep -q '0000:0000:0000:0000:0000:0000:0000:0000 0000:0000:0000:0000:0000:0000:0000:0000'",
 };
 
 struct mfc_attr {
@@ -71,7 +127,9 @@ static struct rtattr *nl_add_rtattr(struct nlmsghdr *nlmsg, struct rtattr *rta,
 	return RTA_NEXT(rta, unused);
 }
 
-static int nl_sendmsg_mfc(struct __test_metadata *_metadata, FIXTURE_DATA(ipmr) *self,
+static int nl_sendmsg_mfc(struct __test_metadata *_metadata,
+			  FIXTURE_DATA(ipmr) *self,
+			  const FIXTURE_VARIANT(ipmr) *variant,
 			  __u16 nlmsg_type, struct mfc_attr *mfc_attr)
 {
 	struct {
@@ -87,7 +145,7 @@ static int nl_sendmsg_mfc(struct __test_metadata *_metadata, FIXTURE_DATA(ipmr)
 		},
 		.rtm = {
 			/* hard requirements in rtm_to_ipmr_mfcc() */
-			.rtm_family = RTNL_FAMILY_IPMR,
+			.rtm_family = variant->rtm_family,
 			.rtm_dst_len = 32,
 			.rtm_type = RTN_MULTICAST,
 			.rtm_scope = RT_SCOPE_UNIVERSE,
@@ -144,6 +202,18 @@ FIXTURE_SETUP(ipmr)
 	ASSERT_EQ(0, err);
 
 	self->veth_ifindex = ifr.ifr_ifindex;
+
+	if (variant->family == AF_INET) {
+		self->vif = (struct vifctl){
+			.vifc_flags = VIFF_USE_IFINDEX,
+			.vifc_lcl_ifindex = self->veth_ifindex,
+		};
+	} else {
+		self->vif6 = (struct mif6ctl){
+			.mif6c_flags = 0,
+			.mif6c_pifi = self->veth_ifindex,
+		};
+	}
 }
 
 FIXTURE_TEARDOWN(ipmr)
@@ -169,41 +239,39 @@ TEST_F(ipmr, mrt_init)
 
 TEST_F(ipmr, mrt_add_vif_register)
 {
-	struct vifctl vif = {
-		.vifc_vifi = 0,
-		.vifc_flags = VIFF_REGISTER,
-	};
 	int err;
 
+	memset(&self->vif, 0, variant->vif_size);
+
+	if (variant->family == AF_INET)
+		self->vif.vifc_flags = VIFF_REGISTER;
+	else
+		self->vif6.mif6c_flags = MIFF_REGISTER;
+
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
-			 &vif,  sizeof(vif));
+			 &self->vif,  variant->vif_size);
 	ASSERT_EQ(0, err);
 
-	err = system("cat /proc/net/ip_mr_vif | grep -q pimreg");
+	err = system(variant->vif_check_cmd_pimreg);
 	ASSERT_EQ(0, err);
 
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_DEL_VIF - MRT_BASE],
-			 &vif,  sizeof(vif));
+			 &self->vif,  variant->vif_size);
 	ASSERT_EQ(0, err);
 }
 
 TEST_F(ipmr, mrt_del_vif_unreg)
 {
-	struct vifctl vif = {
-		.vifc_vifi = 0,
-		.vifc_flags = VIFF_USE_IFINDEX,
-		.vifc_lcl_ifindex = self->veth_ifindex,
-	};
 	int err;
 
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
-			 &vif,  sizeof(vif));
+			 &self->vif,  variant->vif_size);
 	ASSERT_EQ(0, err);
 
-	err = system("cat /proc/net/ip_mr_vif | grep -q veth0");
+	err = system(variant->vif_check_cmd_veth);
 	ASSERT_EQ(0, err);
 
 	/* VIF is removed along with its device. */
@@ -213,23 +281,18 @@ TEST_F(ipmr, mrt_del_vif_unreg)
 	/* mrt->vif_table[veth_ifindex]->dev is NULL. */
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_DEL_VIF - MRT_BASE],
-			 &vif,  sizeof(vif));
+			 &self->vif,  variant->vif_size);
 	ASSERT_EQ(-1, err);
 	ASSERT_EQ(EADDRNOTAVAIL, errno);
 }
 
 TEST_F(ipmr, mrt_del_vif_netns_dismantle)
 {
-	struct vifctl vif = {
-		.vifc_vifi = 0,
-		.vifc_flags = VIFF_USE_IFINDEX,
-		.vifc_lcl_ifindex = self->veth_ifindex,
-	};
 	int err;
 
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
-			 &vif,  sizeof(vif));
+			 &self->vif,  variant->vif_size);
 	ASSERT_EQ(0, err);
 
 	/* Let cleanup_net() remove veth0 and VIF. */
@@ -237,49 +300,42 @@ TEST_F(ipmr, mrt_del_vif_netns_dismantle)
 
 TEST_F(ipmr, mrt_add_mfc)
 {
-	struct mfcctl mfc = {};
 	int err;
 
 	/* MRT_ADD_MFC / MRT_ADD_MFC_PROXY does not need vif to exist (unlike netlink). */
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_ADD_MFC - MRT_BASE],
-			 &mfc,  sizeof(mfc));
+			 &self->mfc, variant->mfc_size);
 	ASSERT_EQ(0, err);
 
 	/* (0.0.0.0 -> 0.0.0.0) */
-	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	err = system(variant->mfc_check_cmd);
 	ASSERT_EQ(0, err);
 
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_DEL_MFC - MRT_BASE],
-			 &mfc,  sizeof(mfc));
+			 &self->mfc, variant->mfc_size);
 }
 
 TEST_F(ipmr, mrt_add_mfc_proxy)
 {
-	struct mfcctl mfc = {};
 	int err;
 
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_ADD_MFC_PROXY - MRT_BASE],
-			 &mfc,  sizeof(mfc));
+			 &self->mfc, variant->mfc_size);
 	ASSERT_EQ(0, err);
 
-	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	err = system(variant->mfc_check_cmd);
 	ASSERT_EQ(0, err);
 
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_DEL_MFC_PROXY - MRT_BASE],
-			 &mfc,  sizeof(mfc));
+			 &self->mfc, variant->mfc_size);
 }
 
 TEST_F(ipmr, mrt_add_mfc_netlink)
 {
-	struct vifctl vif = {
-		.vifc_vifi = 0,
-		.vifc_flags = VIFF_USE_IFINDEX,
-		.vifc_lcl_ifindex = self->veth_ifindex,
-	};
 	struct mfc_attr mfc_attr = {
 		.table = RT_TABLE_DEFAULT,
 		.origin = 0,
@@ -291,26 +347,21 @@ TEST_F(ipmr, mrt_add_mfc_netlink)
 
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
-			 &vif,  sizeof(vif));
+			 &self->vif, variant->vif_size);
 	ASSERT_EQ(0, err);
 
-	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	err = nl_sendmsg_mfc(_metadata, self, variant, RTM_NEWROUTE, &mfc_attr);
 	ASSERT_EQ(0, err);
 
-	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	err = system(variant->mfc_check_cmd);
 	ASSERT_EQ(0, err);
 
-	err = nl_sendmsg_mfc(_metadata, self, RTM_DELROUTE, &mfc_attr);
+	err = nl_sendmsg_mfc(_metadata, self, variant, RTM_DELROUTE, &mfc_attr);
 	ASSERT_EQ(0, err);
 }
 
 TEST_F(ipmr, mrt_add_mfc_netlink_proxy)
 {
-	struct vifctl vif = {
-		.vifc_vifi = 0,
-		.vifc_flags = VIFF_USE_IFINDEX,
-		.vifc_lcl_ifindex = self->veth_ifindex,
-	};
 	struct mfc_attr mfc_attr = {
 		.table = RT_TABLE_DEFAULT,
 		.origin = 0,
@@ -322,16 +373,16 @@ TEST_F(ipmr, mrt_add_mfc_netlink_proxy)
 
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
-			 &vif,  sizeof(vif));
+			 &self->vif, variant->vif_size);
 	ASSERT_EQ(0, err);
 
-	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	err = nl_sendmsg_mfc(_metadata, self, variant, RTM_NEWROUTE, &mfc_attr);
 	ASSERT_EQ(0, err);
 
-	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	err = system(variant->mfc_check_cmd);
 	ASSERT_EQ(0, err);
 
-	err = nl_sendmsg_mfc(_metadata, self, RTM_DELROUTE, &mfc_attr);
+	err = nl_sendmsg_mfc(_metadata, self, variant, RTM_DELROUTE, &mfc_attr);
 	ASSERT_EQ(0, err);
 }
 
@@ -347,12 +398,12 @@ TEST_F(ipmr, mrt_add_mfc_netlink_no_vif)
 
 	/* netlink always requires RTA_IIF of an existing vif. */
 	mfc_attr.ifindex = 0;
-	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	err = nl_sendmsg_mfc(_metadata, self, variant, RTM_NEWROUTE, &mfc_attr);
 	ASSERT_EQ(-ENFILE, err);
 
 	/* netlink always requires RTA_IIF of an existing vif. */
 	mfc_attr.ifindex = self->veth_ifindex;
-	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	err = nl_sendmsg_mfc(_metadata, self, variant, RTM_NEWROUTE, &mfc_attr);
 	ASSERT_EQ(-ENFILE, err);
 }
 
@@ -387,10 +438,10 @@ TEST_F(ipmr, mrt_del_mfc_netlink_netns_dismantle)
 	}
 
 	/* Create a MFC for mrt->vif_table[0]. */
-	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	err = nl_sendmsg_mfc(_metadata, self, variant, RTM_NEWROUTE, &mfc_attr);
 	ASSERT_EQ(0, err);
 
-	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	err = system(variant->mfc_check_cmd);
 	ASSERT_EQ(0, err);
 
 	/* Remove mrt->vif_table[0]. */
@@ -398,13 +449,13 @@ TEST_F(ipmr, mrt_del_mfc_netlink_netns_dismantle)
 	ASSERT_EQ(0, err);
 
 	/* MFC entry is NOT removed even if the tied VIF is removed... */
-	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	err = system(variant->mfc_check_cmd);
 	ASSERT_EQ(0, err);
 
 	/* ... and netlink is not capable of removing such an entry
 	 * because netlink always requires a valid RTA_IIF ... :/
 	 */
-	err = nl_sendmsg_mfc(_metadata, self, RTM_DELROUTE, &mfc_attr);
+	err = nl_sendmsg_mfc(_metadata, self, variant, RTM_DELROUTE, &mfc_attr);
 	ASSERT_EQ(-ENODEV, err);
 
 	/* It can be removed by setsockopt(), but let cleanup_net() remove this time. */
@@ -412,11 +463,6 @@ TEST_F(ipmr, mrt_del_mfc_netlink_netns_dismantle)
 
 TEST_F(ipmr, mrt_table_flush)
 {
-	struct vifctl vif = {
-		.vifc_vifi = 0,
-		.vifc_flags = VIFF_USE_IFINDEX,
-		.vifc_lcl_ifindex = self->veth_ifindex,
-	};
 	struct mfc_attr mfc_attr = {
 		.origin = 0,
 		.group = 0,
@@ -424,7 +470,7 @@ TEST_F(ipmr, mrt_table_flush)
 		.proxy = false,
 	};
 	int table_id = 92;
-	int err, flags;
+	int err;
 
 	/* Set a random table id rather than RT_TABLE_DEFAULT.
 	 * Note that /proc/net/ip_mr_{vif,cache} only supports RT_TABLE_DEFAULT.
@@ -436,20 +482,29 @@ TEST_F(ipmr, mrt_table_flush)
 
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
-			 &vif,  sizeof(vif));
+			 &self->vif,  variant->vif_size);
 	ASSERT_EQ(0, err);
 
-	mfc_attr.table = table_id;
-	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	if (variant->family == AF_INET) {
+		mfc_attr.table = table_id;
+		err = nl_sendmsg_mfc(_metadata, self, variant, RTM_NEWROUTE, &mfc_attr);
+	} else {
+		err = setsockopt(self->raw_sk,
+				 variant->level, variant->opts[MRT_ADD_MFC - MRT_BASE],
+				 &self->mfc, variant->mfc_size);
+	}
 	ASSERT_EQ(0, err);
 
 	/* Flush mrt->vif_table[] and all caches. */
-	flags = MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
-		MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC;
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_FLUSH - MRT_BASE],
-			 &flags,  sizeof(flags));
+			 &variant->flush_flags,  sizeof(variant->flush_flags));
 	ASSERT_EQ(0, err);
 }
 
+XFAIL_ADD(ipmr, ipv6, mrt_add_mfc_netlink);
+XFAIL_ADD(ipmr, ipv6, mrt_add_mfc_netlink_proxy);
+XFAIL_ADD(ipmr, ipv6, mrt_add_mfc_netlink_no_vif);
+XFAIL_ADD(ipmr, ipv6, mrt_del_mfc_netlink_netns_dismantle);
+
 TEST_HARNESS_MAIN
-- 
2.54.0.1032.g2f8565e1d1-goog


