Return-Path: <netdev+bounces-115083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5CF9450D2
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E4FB29588
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83521BB68E;
	Thu,  1 Aug 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJQERPfX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4525760
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530043; cv=none; b=VwiGRilvoBLeuMzF9DhwGv7sNVdJ8ITqBXtG5E9vKJVxkOdO3D4k9EMTEb/NLXhUENA9o8IjoouSGrfggQhpSo9V3SHWbt6bPgARajIRTbQmZz/N4dkKtsEukZyhCzpoiBOHoITp6C2YpIUC+yQixNj2Q0tiBNRRlyGRQvWF2UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530043; c=relaxed/simple;
	bh=3ciQu7WWltiFa4GFgVLnzzxvlDoyDdi47Ktr2b5oogk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNlxxvLPzcyXqLbOSDxS9S62Cs5AD6giekDRGurMqKXPFad5ECqWGNV1/dgZrgrSUP9JsDSIvMK9WSfYhSk03WtM1bHqaNAkxv89ADguVsAXYdiRsPJoKr89O1Dp+jgEXFtEbuWXC1iRPRqHgUb8btt8kK2lcGaFeWPrQG585BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJQERPfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BB8C32786;
	Thu,  1 Aug 2024 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722530043;
	bh=3ciQu7WWltiFa4GFgVLnzzxvlDoyDdi47Ktr2b5oogk=;
	h=From:To:Cc:Subject:Date:From;
	b=tJQERPfXnK1LGNgrsBq8z5YW80wAHOQy9HIzPBWpn9f4J6gWqO68tU/d8XZukLQ0x
	 ML8wjJEMvh59N58Vuqe59WSIlSaIQUhe0pMdJgBhWmK5jl8TyaIdKLbOVClXZqlMLz
	 lHjg2AzOF0vuzPhrlrtsf60vB9DGIDeLNrUtSEuFdz632WUssjem9l6hDl2KIOZjES
	 5rVGtqZsv5bQY9QIuNzKw4VGCCBEy7bBLekbQqlKvRE+gs1rXbhLBq5XCU2xwjycyX
	 5D1UKEHE2zyBkboMjtwHsIpp7T1fKsvCQ6K5Ow6RfIw/Vx8rLI5AFkvCh94C5fJuyH
	 pmZZlhpi0niNA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: remove IFF_* re-definition
Date: Thu,  1 Aug 2024 09:34:01 -0700
Message-ID: <20240801163401.378723-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We re-define values of enum netdev_priv_flags as preprocessor
macros with the same name. I guess this was done to avoid breaking
out of tree modules which may use #ifdef X for kernel compatibility?
Commit 7aa98047df95 ("net: move net_device priv_flags out from UAPI")
which added the enum doesn't say. In any case, the flags with defines
are quite old now, and defines for new flags don't get added.
OOT drivers have to resort to code greps for compat detection, anyway.
Let's delete these defines, save LoC, help LXR link to the right place.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 607009150b5f..0ef3eaa23f4b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1689,38 +1689,6 @@ enum netdev_priv_flags {
 	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
 };
 
-#define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
-#define IFF_EBRIDGE			IFF_EBRIDGE
-#define IFF_BONDING			IFF_BONDING
-#define IFF_ISATAP			IFF_ISATAP
-#define IFF_WAN_HDLC			IFF_WAN_HDLC
-#define IFF_XMIT_DST_RELEASE		IFF_XMIT_DST_RELEASE
-#define IFF_DONT_BRIDGE			IFF_DONT_BRIDGE
-#define IFF_DISABLE_NETPOLL		IFF_DISABLE_NETPOLL
-#define IFF_MACVLAN_PORT		IFF_MACVLAN_PORT
-#define IFF_BRIDGE_PORT			IFF_BRIDGE_PORT
-#define IFF_OVS_DATAPATH		IFF_OVS_DATAPATH
-#define IFF_TX_SKB_SHARING		IFF_TX_SKB_SHARING
-#define IFF_UNICAST_FLT			IFF_UNICAST_FLT
-#define IFF_TEAM_PORT			IFF_TEAM_PORT
-#define IFF_SUPP_NOFCS			IFF_SUPP_NOFCS
-#define IFF_LIVE_ADDR_CHANGE		IFF_LIVE_ADDR_CHANGE
-#define IFF_MACVLAN			IFF_MACVLAN
-#define IFF_XMIT_DST_RELEASE_PERM	IFF_XMIT_DST_RELEASE_PERM
-#define IFF_L3MDEV_MASTER		IFF_L3MDEV_MASTER
-#define IFF_NO_QUEUE			IFF_NO_QUEUE
-#define IFF_OPENVSWITCH			IFF_OPENVSWITCH
-#define IFF_L3MDEV_SLAVE		IFF_L3MDEV_SLAVE
-#define IFF_TEAM			IFF_TEAM
-#define IFF_RXFH_CONFIGURED		IFF_RXFH_CONFIGURED
-#define IFF_PHONY_HEADROOM		IFF_PHONY_HEADROOM
-#define IFF_MACSEC			IFF_MACSEC
-#define IFF_NO_RX_HANDLER		IFF_NO_RX_HANDLER
-#define IFF_FAILOVER			IFF_FAILOVER
-#define IFF_FAILOVER_SLAVE		IFF_FAILOVER_SLAVE
-#define IFF_L3MDEV_RX_HANDLER		IFF_L3MDEV_RX_HANDLER
-#define IFF_TX_SKB_NO_LINEAR		IFF_TX_SKB_NO_LINEAR
-
 /* Specifies the type of the struct net_device::ml_priv pointer */
 enum netdev_ml_priv_type {
 	ML_PRIV_NONE,
-- 
2.45.2


