Return-Path: <netdev+bounces-276164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGSCKBJ11WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:20:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F833B4F57
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDA31301B4FF
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA70D37C91E;
	Tue,  7 Apr 2026 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fl7IU4Om"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693E37BE9E
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596807; cv=none; b=LYE+XmTKHUBhZC5m+QzmdoO0zwcS4Rk2BDIGOGGccmobYFYaZXIedxoPgTjx+BU2qlNgUGK8LtvG05cDBXJE7HuIIX0T9ojHcJyOEjo09eChNbFIaVX8Q4swxNlUyFyXtiLsNyBB082JC9vIEqQT+3jwNFQWMtNF9dosOK5xQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596807; c=relaxed/simple;
	bh=xVT/XZnSRrIDVpvbY3KXoxLurmbeZotULvEpGJ02geI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k2Y383fUcxmDCbIRj7bndF41v3Hfs31PlJaFklAC7hD7VlK9XnrcONXE33tJPf3YTh1w/WPHId0EXellI3+qGF67r1ei3L5YZoLZK/PYaemdAgSsecnDHpjQ7+Ysx+BUx+YWO0CeEyW0sYN6QmVq/MYnGzvrtvkFTKHwwF6BRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fl7IU4Om; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b242cbb97aso44133645ad.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596806; x=1776201606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+l6+TXy4b6dxMhG7gjvJQhnzsnvatK2g7FUHSpTF1s=;
        b=Fl7IU4OmRqGoOwxYlhmkZEvb3kVgrQV2AF+F9tttFLtSokNuAo3RGgwkyr/fR4yhus
         PJN/XFYdz6IC16Wv58d8q+jbw79/r73ifK+lmQg9ttLaGt84X7Ba9fR7iRAjtAhsb5Vy
         xvfiIkds3cuw504JdbzNRAZQnhI6SfEspc3VslpnRLINR0F+NVz4NyVrL37VpMSlBx/+
         HgM8FV/Vc33RTgu5ZgiNA7KP8wUt57jHrOfTUl/eqTzS1sQ9qJOAY1KvtpqQw65nxFzU
         Nz+jukNRa26NNmkzQSdzzlZN28vf7FQUV+hb+TUT1gsL46F01Ox0qAx0Hu97QEb8duO9
         lcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596806; x=1776201606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+l6+TXy4b6dxMhG7gjvJQhnzsnvatK2g7FUHSpTF1s=;
        b=jgU93sXWvCp41lGB1ZjjRVCjt+RAZXgVuORpr0HCqveELXYRZaCUzOXCrHeYKhz5Av
         fQoj9oMw1Qrv28UCGcDoHWUZiTqg5+KjQum4FTBs4My+sFhfzwsOZWjbK5pfNwqiENRf
         39bPMGSnNgeVRJ4gM/Ues19N7X4H79U3qbyqm9cYz08PcJKpiNZE3+7TIagXsOcEhIBh
         VINb5cgXdJn8CPJVenY5chAOErb0D2XPDnibdjkOi/1lD48V1+G9okObxLLZu2lcjTp3
         GE8etacq9svRIrf1JA+fMGU6dhbr869K/BXAE5zDUd2/GUgCW7gLTFZ5O2MchPQW7MVq
         qpWw==
X-Forwarded-Encrypted: i=1; AJvYcCXSjmN1oD4i4Y8P3D4FT7w+0gFZuk/TWxUpSJz64FliSd58zUno9518kBdq/xao4cgCACjjZ/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjuk9SdnqYDQ9ohHAyQ4uBBpsJtMTjJEhBnH+h4DksVvFkD6Z2
	jP1tnZedXT7rTp9x9cmOZqRzl2Gg4aQIEymgliQN5B02NQjU8YooO7umbbPRsLbIroTg8cO/jrS
	OpJzZXA==
X-Received: from pfbdh21.prod.google.com ([2002:a05:6a00:4795:b0:829:f706:70e4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:94c7:b0:39b:f0a1:1495
 with SMTP id adf61e73a8af0-39f2f286fd8mr18258275637.52.1775596805396; Tue, 07
 Apr 2026 14:20:05 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:34 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 01/15] selftest: net: Extend ipmr.c for IP6MR.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276164-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26F833B4F57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This commit extends most test cases in ipmr.c for IPV6MR.

Note that IP6MR does not provide rtnetlink interface for MFC,
so such tests will be skipped.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/forwarding/ipmr.c | 163 ++++++++++++------
 1 file changed, 110 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/ipmr.c b/tools/testing/selftests/net/forwarding/ipmr.c
index df870aad9ead..cfd00173bcd6 100644
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
@@ -25,6 +35,11 @@ FIXTURE_VARIANT(ipmr)
 	int protocol;
 	int level;
 	int opts[MRT_MAX - MRT_BASE + 1];
+	int vif_size;
+	char vif_check_cmd_pimreg[64];
+	char vif_check_cmd_veth[64];
+	int mfc_size;
+	char mfc_check_cmd[1024];
 };
 
 FIXTURE_VARIANT_ADD(ipmr, ipv4)
@@ -47,6 +62,39 @@ FIXTURE_VARIANT_ADD(ipmr, ipv4)
 		MRT_DEL_MFC_PROXY,
 		MRT_FLUSH,
 	},
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
+		MRT_FLUSH,
+	},
+	.vif_size = sizeof(struct mif6ctl),
+	.vif_check_cmd_pimreg = "cat /proc/net/ip6_mr_vif | grep -q pim6reg",
+	.vif_check_cmd_veth = "cat /proc/net/ip6_mr_vif | grep -q veth",
+	.mfc_size = sizeof(struct mf6cctl),
+	.mfc_check_cmd = "cat /proc/net/ip6_mr_cache | "
+		"grep -q '0000:0000:0000:0000:0000:0000:0000:0000 0000:0000:0000:0000:0000:0000:0000:0000'",
 };
 
 struct mfc_attr {
@@ -144,6 +192,18 @@ FIXTURE_SETUP(ipmr)
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
@@ -169,41 +229,39 @@ TEST_F(ipmr, mrt_init)
 
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
@@ -213,23 +271,18 @@ TEST_F(ipmr, mrt_del_vif_unreg)
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
@@ -237,49 +290,49 @@ TEST_F(ipmr, mrt_del_vif_netns_dismantle)
 
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
 
+#define SKIP_IPV6()						\
+	do {							\
+		if (variant->family == AF_INET6)		\
+			SKIP(return,				\
+			     "no netlink MFC interface");	\
+	} while (0)
+
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
@@ -289,15 +342,17 @@ TEST_F(ipmr, mrt_add_mfc_netlink)
 	};
 	int err;
 
+	SKIP_IPV6();
+
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
-			 &vif,  sizeof(vif));
+			 &self->vif, variant->vif_size);
 	ASSERT_EQ(0, err);
 
 	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
 	ASSERT_EQ(0, err);
 
-	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	err = system(variant->mfc_check_cmd);
 	ASSERT_EQ(0, err);
 
 	err = nl_sendmsg_mfc(_metadata, self, RTM_DELROUTE, &mfc_attr);
@@ -306,11 +361,6 @@ TEST_F(ipmr, mrt_add_mfc_netlink)
 
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
@@ -320,15 +370,17 @@ TEST_F(ipmr, mrt_add_mfc_netlink_proxy)
 	};
 	int err;
 
+	SKIP_IPV6();
+
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
-			 &vif,  sizeof(vif));
+			 &self->vif, variant->vif_size);
 	ASSERT_EQ(0, err);
 
 	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
 	ASSERT_EQ(0, err);
 
-	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	err = system(variant->mfc_check_cmd);
 	ASSERT_EQ(0, err);
 
 	err = nl_sendmsg_mfc(_metadata, self, RTM_DELROUTE, &mfc_attr);
@@ -345,6 +397,8 @@ TEST_F(ipmr, mrt_add_mfc_netlink_no_vif)
 	};
 	int err;
 
+	SKIP_IPV6();
+
 	/* netlink always requires RTA_IIF of an existing vif. */
 	mfc_attr.ifindex = 0;
 	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
@@ -378,6 +432,8 @@ TEST_F(ipmr, mrt_del_mfc_netlink_netns_dismantle)
 	};
 	int i, err;
 
+	SKIP_IPV6();
+
 	for (i = 0; i < 2; i++) {
 		/* Create 2 VIFs just to avoid -ENFILE later. */
 		err = setsockopt(self->raw_sk,
@@ -390,7 +446,7 @@ TEST_F(ipmr, mrt_del_mfc_netlink_netns_dismantle)
 	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
 	ASSERT_EQ(0, err);
 
-	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	err = system(variant->mfc_check_cmd);
 	ASSERT_EQ(0, err);
 
 	/* Remove mrt->vif_table[0]. */
@@ -398,7 +454,7 @@ TEST_F(ipmr, mrt_del_mfc_netlink_netns_dismantle)
 	ASSERT_EQ(0, err);
 
 	/* MFC entry is NOT removed even if the tied VIF is removed... */
-	err = system("cat /proc/net/ip_mr_cache | grep -q '00000000 00000000' ");
+	err = system(variant->mfc_check_cmd);
 	ASSERT_EQ(0, err);
 
 	/* ... and netlink is not capable of removing such an entry
@@ -412,11 +468,6 @@ TEST_F(ipmr, mrt_del_mfc_netlink_netns_dismantle)
 
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
@@ -436,11 +487,17 @@ TEST_F(ipmr, mrt_table_flush)
 
 	err = setsockopt(self->raw_sk,
 			 variant->level, variant->opts[MRT_ADD_VIF - MRT_BASE],
-			 &vif,  sizeof(vif));
+			 &self->vif,  variant->vif_size);
 	ASSERT_EQ(0, err);
 
-	mfc_attr.table = table_id;
-	err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	if (variant->family == AF_INET) {
+		mfc_attr.table = table_id;
+		err = nl_sendmsg_mfc(_metadata, self, RTM_NEWROUTE, &mfc_attr);
+	} else {
+		err = setsockopt(self->raw_sk,
+				 variant->level, variant->opts[MRT_ADD_MFC - MRT_BASE],
+				 &self->mfc, variant->mfc_size);
+	}
 	ASSERT_EQ(0, err);
 
 	/* Flush mrt->vif_table[] and all caches. */
-- 
2.53.0.1213.gd9a14994de-goog


