Return-Path: <netdev+bounces-200174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5DCAE38E3
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2D5172E11
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C6922F74F;
	Mon, 23 Jun 2025 08:48:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33276219A91
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668492; cv=none; b=lz1RT2ueHlYvd1a3qSDZ3gdaTz4onOiNMKjkf5VrSqHhjTsFOmK9giwgn+SVqx93WG8xv//onkV3TKyK9UN/XLu3v0I772vf8ETB0yuL9s3WPhi84Zluct5VXNU5sqerwqgE0UzhH15Nguca89LldmFEi7unHTAXiJyhopLwEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668492; c=relaxed/simple;
	bh=qdCNAIukvetacEnzH582AOFjHGWS81JfZDBaR94wtDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIXxCc4Sa4BYCrAO5mlBWcXx6NaNCLL7mvBQUdFDdOIxA24MLrmfKQMHc6diutnfVkE1x4O+gHieZY/8lBpTR6eUF2+4oTetkUUVDyDARZbu38S5a1XXdxyvqVu1met6upnzxknVEso3KIIcFxvG637E6SRG/9esglBtq2pkRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcqX-0002an-Ef; Mon, 23 Jun 2025 10:48:09 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcqX-004uxT-0U;
	Mon, 23 Jun 2025 10:48:09 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTcqX-004eCa-0H;
	Mon, 23 Jun 2025 10:48:09 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	razor@blackwall.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH iproute2-next v4 2/3] bridge: dump mcast querier per vlan
Date: Mon, 23 Jun 2025 10:45:20 +0200
Message-Id: <20250623084518.1101527-3-f.pfitzner@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623084518.1101527-1-f.pfitzner@pengutronix.de>
References: <20250623084518.1101527-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: fpf@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Dump the multicast querier state per vlan.
This commit is almost identical to [1].

The querier state can be seen with:

bridge -d vlan global

The options for vlan filtering and vlan mcast snooping have to be enabled
in order to see the output:

ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1

The querier state shows the following information for IPv4 and IPv6
respectively:

1) The ip address of the current querier in the network. This could be
   ourselves or an external querier.
2) The port on which the querier was seen
3) Querier timeout in seconds

[1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---
 bridge/vlan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 14b8475d..d2770eff 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -852,6 +852,10 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
 		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
 			   rta_getattr_u8(vattr));
 	}
+	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
+		struct rtattr *attr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE];
+		bridge_print_mcast_querier_state(attr);
+	}
 	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
 		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
 		print_uint(PRINT_ANY, "mcast_igmp_version",
--
2.39.5


