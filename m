Return-Path: <netdev+bounces-67555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F262844053
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 14:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8453E1C264E3
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A26E7BB05;
	Wed, 31 Jan 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZ85Z57A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25ED7B3EC
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707047; cv=none; b=Y/g5JMNyo76EYrZPLy1SaOyQRX91l5WRaZvhoRi55ToyTEGGl4QYBkyVSb1qR+31CN9gbrL6hCjHsdIAspGkzJZNREoMKVJ0dQrzApYxQ4Hp9R8xwmBxO26ViRn2x4sdBl+FNCiGI+uFfGdKCcc8yXwVUKcO8eSuI89djH7fuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707047; c=relaxed/simple;
	bh=vcKD5as0/agScWGjpQcJGFm+oQZmpJjE2XYTKul8TNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDWJPe3nBnneMMsnKSI+jACLmLeRA/VEgPoN+MCfI+NB2TL+YmgVJfM2kTnlLHEK8YwGs7xKCpQSIBPgqtNP8V3im76WQxXsT8CF5Q7ktf1h2E3Bf1ZxfCk/ZeH2qh2Qu7+SjW28j3+w7WhDFJA8g++FSIsGCXRucH/liqWC9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZ85Z57A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706707044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=//z4Y/BgNHdCR9hM9Ii+VZgxSjTBvGsBMSlKT9iydbU=;
	b=ZZ85Z57Abwf9H7iQPzrounpMGGLsmoRj7A32pa3zwzlltG9qK0NrPRwscaYSZ8xeXoZuTI
	DGgu40T/ef+fqKThmHhev9kXwAyZr9yPOzf+V5/KBAMgxI41u6saHFuh8GJitJUcawCQ4q
	M2vyqUmB1XBtwTCWpjWQepu+ZFXL8Vo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-99WzZMLDNzuiVzbZ1JrgMA-1; Wed, 31 Jan 2024 08:17:18 -0500
X-MC-Unique: 99WzZMLDNzuiVzbZ1JrgMA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A22C835381;
	Wed, 31 Jan 2024 13:17:17 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.38])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3FCF7400DF3E;
	Wed, 31 Jan 2024 13:17:15 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] i40e: Do not allow untrusted VF to remove administratively set MAC
Date: Wed, 31 Jan 2024 14:17:14 +0100
Message-ID: <20240131131714.23497-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Currently when PF administratively sets VF's MAC address and the VF
is put down (VF tries to delete all MACs) then the MAC is removed
from MAC filters and primary VF MAC is zeroed.

Do not allow untrusted VF to remove primary MAC when it was set
administratively by PF.

Reproducer:
1) Create VF
2) Set VF interface up
3) Administratively set the VF's MAC
4) Put VF interface down

[root@host ~]# echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
[root@host ~]# ip link set enp2s0f0v0 up
[root@host ~]# ip link set enp2s0f0 vf 0 mac fe:6c:b5:da:c7:7d
[root@host ~]# ip link show enp2s0f0
23: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 3c:ec:ef:b7:dd:04 brd ff:ff:ff:ff:ff:ff
    vf 0     link/ether fe:6c:b5:da:c7:7d brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off
[root@host ~]# ip link set enp2s0f0v0 down
[root@host ~]# ip link show enp2s0f0
23: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 3c:ec:ef:b7:dd:04 brd ff:ff:ff:ff:ff:ff
    vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off

Fixes: 700bbf6c1f9e ("i40e: allow VF to remove any MAC filter")
Fixes: ceb29474bbbc ("i40e: Add support for VF to specify its primary MAC address")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 38 ++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 908cdbd3ec5d..b34c71770887 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2848,6 +2848,24 @@ static int i40e_vc_get_stats_msg(struct i40e_vf *vf, u8 *msg)
 				      (u8 *)&stats, sizeof(stats));
 }
 
+/**
+ * i40e_can_vf_change_mac
+ * @vf: pointer to the VF info
+ *
+ * Return true if the VF is allowed to change its MAC filters, false otherwise
+ */
+static bool i40e_can_vf_change_mac(struct i40e_vf *vf)
+{
+	/* If the VF MAC address has been set administratively (via the
+	 * ndo_set_vf_mac command), then deny permission to the VF to
+	 * add/delete unicast MAC addresses, unless the VF is trusted
+	 */
+	if (vf->pf_set_mac && !vf->trusted)
+		return false;
+
+	return true;
+}
+
 #define I40E_MAX_MACVLAN_PER_HW 3072
 #define I40E_MAX_MACVLAN_PER_PF(num_ports) (I40E_MAX_MACVLAN_PER_HW /	\
 	(num_ports))
@@ -2907,8 +2925,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		 * The VF may request to set the MAC address filter already
 		 * assigned to it so do not return an error in that case.
 		 */
-		if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) &&
-		    !is_multicast_ether_addr(addr) && vf->pf_set_mac &&
+		if (!i40e_can_vf_change_mac(vf) &&
+		    !is_multicast_ether_addr(addr) &&
 		    !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
 			dev_err(&pf->pdev->dev,
 				"VF attempting to override administratively set MAC address, bring down and up the VF interface to resume normal operation\n");
@@ -3114,19 +3132,29 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 			ret = -EINVAL;
 			goto error_param;
 		}
-		if (ether_addr_equal(al->list[i].addr, vf->default_lan_addr.addr))
-			was_unimac_deleted = true;
 	}
 	vsi = pf->vsi[vf->lan_vsi_idx];
 
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 	/* delete addresses from the list */
-	for (i = 0; i < al->num_elements; i++)
+	for (i = 0; i < al->num_elements; i++) {
+		const u8 *addr = al->list[i].addr;
+
+		/* Allow to delete VF primary MAC only if it was not set
+		 * administratively by PF or if VF is trusted.
+		 */
+		if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
+		    i40e_can_vf_change_mac(vf))
+			was_unimac_deleted = true;
+		else
+			continue;
+
 		if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
 			ret = -EINVAL;
 			spin_unlock_bh(&vsi->mac_filter_hash_lock);
 			goto error_param;
 		}
+	}
 
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
 
-- 
2.39.3


