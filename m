Return-Path: <netdev+bounces-213165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBF6B23E51
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 04:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2093B16969A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4341E520B;
	Wed, 13 Aug 2025 02:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9oKOIIV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A28248C
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755052976; cv=none; b=bNXbyVSsAoMN7pFyz90f9+NH/kPdhiG/KPit2U+2KIp1yu8J8W2ltjpRAmajR7xbmBh2x0pS8Cc1QymgAlthy9wXgWye1pl+QaNi+XndAgTNYfZUmHDo1tAFLQicdBrjk4hiJXxCkcsbgSebM8FBUxI6ERJNj4z3lF1QwKXvEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755052976; c=relaxed/simple;
	bh=bsDqEcUEhyGBeE03BX4IqJtXgAjkY+sTyHKAFEqzH88=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RHs7K74gyAR//G9eZQcu+5ZmVaX0H4YfyWJWY0RkF+yv0x27POsiXUbkszZk4nl575NrO9SWT9kb9bzJ2/QNWpz5CUDMsx/bx8LoPeUxZJY9/G86LSh3lELmB/bsyAe76Nf3aiX3j2/tD0Yk0oMPhzkuZAuLhWpd8FCWZ2nJq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9oKOIIV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755052974; x=1786588974;
  h=from:to:cc:subject:date:message-id;
  bh=bsDqEcUEhyGBeE03BX4IqJtXgAjkY+sTyHKAFEqzH88=;
  b=W9oKOIIV/psQXdXluofZf1xqqu7lcGm0tI7eYd2g0PID24yYNjLrtv0y
   olrXptWJEB8pdciupxY7T6no1jkqX10vqJE3gZP4z1RA78UsjAmJjcSvu
   gSGfmGy2Vnko38LVPe6mfixkvIdJCzqapqL7re5jQvyTCyfHuDCNJt9k5
   lnZHUm1KAEz5i9JFE2PlwtvMIhGraC6tWQKaEEqzYUKg4FbNYMnA4O5l8
   Yrs74YmX/jDub19x02nveUn0f5RWX3l6CJ1it+wu2Mn5U9uAefmRxhNGG
   ft5NcsMOVAx7PqTk5BHx4uHAJ4xwf+xO+QDEIKsna1jsAoCk3lPZy2APj
   A==;
X-CSE-ConnectionGUID: cXz+Y96MQJqOQwD7DpRN6g==
X-CSE-MsgGUID: zoBjY/aMQCq879ce0NixJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74785356"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="74785356"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 19:42:54 -0700
X-CSE-ConnectionGUID: cKdMxiGXTgO7DxB7JnfSSQ==
X-CSE-MsgGUID: DkZ39xtTQHW0+UC4EVDSKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170797073"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa004.jf.intel.com with ESMTP; 12 Aug 2025 19:42:54 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jianliu@redhat.com,
	mschmidt@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com
Subject: [PATCH iwl-net v2] idpf: set mac type when adding and removing MAC filters
Date: Tue, 12 Aug 2025 19:42:02 -0700
Message-Id: <20250813024202.10740-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On control planes that allow changing the MAC address of the interface,
the driver must provide a MAC type to avoid errors such as:

idpf 0000:0a:00.0: Transaction failed (op 535)
idpf 0000:0a:00.0: Received invalid MAC filter payload (op 535) (len 0)
idpf 0000:0a:00.0: Transaction failed (op 536)

These errors occur during driver load or when changing the MAC via:
ip link set <iface> address <mac>

Add logic to set the MAC type when sending ADD/DEL (opcodes 535/536) to
the control plane. Since only one primary MAC is supported per vport, the
driver only needs to send an ADD opcode when setting it. Remove the old
address by calling __idpf_del_mac_filter(), which skips the message and
just clears the entry from the internal list.

Fixes: ce1b75d0635c ("idpf: add ptypes and MAC filter support")
Reported-by: Jian Liu <jianliu@redhat.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
Changelog:
v2:
- Make sure to clear the primary MAC from the internal list, following
  successful change.
- Update the description to include the error on 536 opcode and
  mention the removal of the old address.

v1:
https://lore.kernel.org/intel-wired-lan/20250806192130.3197-1-emil.s.tantilov@intel.com/
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c      |  9 ++++++---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 11 +++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 2c2a3e85d693..26edd2cda70b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2345,6 +2345,7 @@ static int idpf_set_mac(struct net_device *netdev, void *p)
 	struct idpf_vport_config *vport_config;
 	struct sockaddr *addr = p;
 	struct idpf_vport *vport;
+	u8 old_addr[ETH_ALEN];
 	int err = 0;
 
 	idpf_vport_ctrl_lock(netdev);
@@ -2367,17 +2368,19 @@ static int idpf_set_mac(struct net_device *netdev, void *p)
 	if (ether_addr_equal(netdev->dev_addr, addr->sa_data))
 		goto unlock_mutex;
 
+	ether_addr_copy(old_addr, vport->default_mac_addr);
+	ether_addr_copy(vport->default_mac_addr, addr->sa_data);
 	vport_config = vport->adapter->vport_config[vport->idx];
 	err = idpf_add_mac_filter(vport, np, addr->sa_data, false);
 	if (err) {
 		__idpf_del_mac_filter(vport_config, addr->sa_data);
+		ether_addr_copy(vport->default_mac_addr, netdev->dev_addr);
 		goto unlock_mutex;
 	}
 
-	if (is_valid_ether_addr(vport->default_mac_addr))
-		idpf_del_mac_filter(vport, np, vport->default_mac_addr, false);
+	if (is_valid_ether_addr(old_addr))
+		__idpf_del_mac_filter(vport_config, old_addr);
 
-	ether_addr_copy(vport->default_mac_addr, addr->sa_data);
 	eth_hw_addr_set(netdev, addr->sa_data);
 
 unlock_mutex:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index a028c69f7fdc..e60438633cc4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3765,6 +3765,15 @@ u32 idpf_get_vport_id(struct idpf_vport *vport)
 	return le32_to_cpu(vport_msg->vport_id);
 }
 
+static void idpf_set_mac_type(struct idpf_vport *vport,
+			      struct virtchnl2_mac_addr *mac_addr)
+{
+	if (ether_addr_equal(vport->default_mac_addr, mac_addr->addr))
+		mac_addr->type = VIRTCHNL2_MAC_ADDR_PRIMARY;
+	else
+		mac_addr->type = VIRTCHNL2_MAC_ADDR_EXTRA;
+}
+
 /**
  * idpf_mac_filter_async_handler - Async callback for mac filters
  * @adapter: private data struct
@@ -3894,6 +3903,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 			    list) {
 		if (add && f->add) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
+			idpf_set_mac_type(vport, &mac_addr[i]);
 			i++;
 			f->add = false;
 			if (i == total_filters)
@@ -3901,6 +3911,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 		}
 		if (!add && f->remove) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
+			idpf_set_mac_type(vport, &mac_addr[i]);
 			i++;
 			f->remove = false;
 			if (i == total_filters)
-- 
2.37.3


