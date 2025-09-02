Return-Path: <netdev+bounces-219362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F88B410B5
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B19D1B64551
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2162127FB03;
	Tue,  2 Sep 2025 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mj593zAU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DED27CCF2
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855303; cv=none; b=VC//gBTe7k9Ck69ZdveA3TgRCfFOukowq1UlejIHB+AtB40IhGuXtaIeLJm5dmNKf6DHtJb2GIxyFxMcPmX7yaZ+ZDtOH3H8krVXt+up+dwAZ+CPkxEc2epXAVyBjdiprPIKrXHQeYU321F9xJLDi2uM6JO9kohqJ5BhZ8+/oxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855303; c=relaxed/simple;
	bh=jRbiQrb5Lcl1NdOnDP3M8Iq2O09EqOZ8BwGy3kYxyYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diFZBPymHp4shAboLJ4d09FPq23AiC4JLL8/DOa75N8Ecerhx3yIO8eqmHxlehXfMhdLD8YASdegUcjvrU4pMGpwUqnplYoy0uw1C/LmYt5s6yOC/3twWOiCVmfbyjh0qTCn8izDfPIZkErwWu12+ebF/O8lMpRBIPn1ltQmLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mj593zAU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756855301; x=1788391301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jRbiQrb5Lcl1NdOnDP3M8Iq2O09EqOZ8BwGy3kYxyYk=;
  b=mj593zAUi7+zdVZ1uALUuVoRc/E/4J7SsVuc7D2F+8jKWJgDFsPR0IOj
   J7/ibjhyMvxMPJo//2IeB0Hp//nkOt0i9fVypKEwMAXcTIZU4UqTQL9+A
   vqJ9ReTchjJO/BLWEu5gd2ZauZBOvI6tAiW/ZN+djDo3NUErisLnY9nJo
   WP8tCc8CI/9yI4QGn1QmuGUGIW596flPtydkTAoTK/U949chsR5vuS6Lp
   cwNg/dIjqY7uxtvqrY94EaltAEHGKLFQS5adgEtHMgNppNr2dU0JAuRIR
   2aALhJOBM5yLD6rvjl48mzthz3dV5mXvaRv2CIzWAE0KnNreSQip8CLIw
   A==;
X-CSE-ConnectionGUID: VhNJlWnVQgSmWQ9Tw7KSiw==
X-CSE-MsgGUID: SUjEqjc3TB2k94eFmdPwZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69767208"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69767208"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 16:21:38 -0700
X-CSE-ConnectionGUID: rr70bJJQTfSyXjP+DGSLPQ==
X-CSE-MsgGUID: aE0RVOpZRdWZ0vJ5fSuApg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171575899"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2025 16:21:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	decot@google.com,
	willemb@google.com,
	Jian Liu <jianliu@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 4/8] idpf: set mac type when adding and removing MAC filters
Date: Tue,  2 Sep 2025 16:21:24 -0700
Message-ID: <20250902232131.2739555-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
References: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

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
just clears the entry from the internal list. This avoids an error on DEL
as it attempts to remove an address already cleared by the preceding ADD
opcode.

Fixes: ce1b75d0635c ("idpf: add ptypes and MAC filter support")
Reported-by: Jian Liu <jianliu@redhat.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c      |  9 ++++++---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 12 ++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 2c2a3e85d693..513032cb5f08 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2344,6 +2344,7 @@ static int idpf_set_mac(struct net_device *netdev, void *p)
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_config *vport_config;
 	struct sockaddr *addr = p;
+	u8 old_mac_addr[ETH_ALEN];
 	struct idpf_vport *vport;
 	int err = 0;
 
@@ -2367,17 +2368,19 @@ static int idpf_set_mac(struct net_device *netdev, void *p)
 	if (ether_addr_equal(netdev->dev_addr, addr->sa_data))
 		goto unlock_mutex;
 
+	ether_addr_copy(old_mac_addr, vport->default_mac_addr);
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
+	if (is_valid_ether_addr(old_mac_addr))
+		__idpf_del_mac_filter(vport_config, old_mac_addr);
 
-	ether_addr_copy(vport->default_mac_addr, addr->sa_data);
 	eth_hw_addr_set(netdev, addr->sa_data);
 
 unlock_mutex:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index a028c69f7fdc..6330d4a0ae07 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3765,6 +3765,16 @@ u32 idpf_get_vport_id(struct idpf_vport *vport)
 	return le32_to_cpu(vport_msg->vport_id);
 }
 
+static void idpf_set_mac_type(struct idpf_vport *vport,
+			      struct virtchnl2_mac_addr *mac_addr)
+{
+	bool is_primary;
+
+	is_primary = ether_addr_equal(vport->default_mac_addr, mac_addr->addr);
+	mac_addr->type = is_primary ? VIRTCHNL2_MAC_ADDR_PRIMARY :
+				      VIRTCHNL2_MAC_ADDR_EXTRA;
+}
+
 /**
  * idpf_mac_filter_async_handler - Async callback for mac filters
  * @adapter: private data struct
@@ -3894,6 +3904,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 			    list) {
 		if (add && f->add) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
+			idpf_set_mac_type(vport, &mac_addr[i]);
 			i++;
 			f->add = false;
 			if (i == total_filters)
@@ -3901,6 +3912,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 		}
 		if (!add && f->remove) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
+			idpf_set_mac_type(vport, &mac_addr[i]);
 			i++;
 			f->remove = false;
 			if (i == total_filters)
-- 
2.47.1


