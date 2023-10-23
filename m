Return-Path: <netdev+bounces-43528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8F37D3C7D
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4F11C2087C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798091D554;
	Mon, 23 Oct 2023 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AN4hUxFA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00B1C6BD
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:29:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1556810E
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698078578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySn2xd4o2SRieO3w/gOx9FSSOOAh0/Mb2wK/qV0NTLY=;
	b=AN4hUxFAak8i8BlYmdlk8eWQUeLd4d2MrAJiBfZCkhiDYI5FtsjzY4bOibetXMDZQjC8Jk
	Onx93Pwn/KbiTd4JKkm6j6Dk2OkUCECbcknwelmtsOtkCM3tQiaoTUxlJ5Mg4modxK9YXN
	rsBv83MuHi+BC6sKWvdm1DmV0K6nzTk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-YKU2tQtgMlyogavkyFa4wQ-1; Mon, 23 Oct 2023 12:29:35 -0400
X-MC-Unique: YKU2tQtgMlyogavkyFa4wQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C83880F925;
	Mon, 23 Oct 2023 16:29:34 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7A4A525C0;
	Mon, 23 Oct 2023 16:29:31 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	mschmidt@redhat.com,
	dacampbe@redhat.com,
	poros@redhat.com
Subject: [PATCH iwl-next 1/3] i40e: Move i40e_is_aq_api_ver_ge helper
Date: Mon, 23 Oct 2023 18:29:26 +0200
Message-ID: <20231023162928.245583-2-ivecera@redhat.com>
In-Reply-To: <20231023162928.245583-1-ivecera@redhat.com>
References: <20231023162928.245583-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Move i40e_is_aq_api_ver_ge helper function (used to check if AdminQ
API version is recent enough) to header so it can be used from
other .c files.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 23 ++++---------------
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 14 +++++++++++
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 7fce881abc93..df7ba349030d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1749,21 +1749,6 @@ int i40e_aq_set_phy_debug(struct i40e_hw *hw, u8 cmd_flags,
 	return status;
 }
 
-/**
- * i40e_is_aq_api_ver_ge
- * @aq: pointer to AdminQ info containing HW API version to compare
- * @maj: API major value
- * @min: API minor value
- *
- * Assert whether current HW API version is greater/equal than provided.
- **/
-static bool i40e_is_aq_api_ver_ge(struct i40e_adminq_info *aq, u16 maj,
-				  u16 min)
-{
-	return (aq->api_maj_ver > maj ||
-		(aq->api_maj_ver == maj && aq->api_min_ver >= min));
-}
-
 /**
  * i40e_aq_add_vsi
  * @hw: pointer to the hw struct
@@ -1890,14 +1875,14 @@ int i40e_aq_set_vsi_unicast_promiscuous(struct i40e_hw *hw,
 
 	if (set) {
 		flags |= I40E_AQC_SET_VSI_PROMISC_UNICAST;
-		if (rx_only_promisc && i40e_is_aq_api_ver_ge(&hw->aq, 1, 5))
+		if (rx_only_promisc && i40e_is_aq_api_ver_ge(hw, 1, 5))
 			flags |= I40E_AQC_SET_VSI_PROMISC_RX_ONLY;
 	}
 
 	cmd->promiscuous_flags = cpu_to_le16(flags);
 
 	cmd->valid_flags = cpu_to_le16(I40E_AQC_SET_VSI_PROMISC_UNICAST);
-	if (i40e_is_aq_api_ver_ge(&hw->aq, 1, 5))
+	if (i40e_is_aq_api_ver_ge(hw, 1, 5))
 		cmd->valid_flags |=
 			cpu_to_le16(I40E_AQC_SET_VSI_PROMISC_RX_ONLY);
 
@@ -2000,13 +1985,13 @@ int i40e_aq_set_vsi_uc_promisc_on_vlan(struct i40e_hw *hw,
 
 	if (enable) {
 		flags |= I40E_AQC_SET_VSI_PROMISC_UNICAST;
-		if (i40e_is_aq_api_ver_ge(&hw->aq, 1, 5))
+		if (i40e_is_aq_api_ver_ge(hw, 1, 5))
 			flags |= I40E_AQC_SET_VSI_PROMISC_RX_ONLY;
 	}
 
 	cmd->promiscuous_flags = cpu_to_le16(flags);
 	cmd->valid_flags = cpu_to_le16(I40E_AQC_SET_VSI_PROMISC_UNICAST);
-	if (i40e_is_aq_api_ver_ge(&hw->aq, 1, 5))
+	if (i40e_is_aq_api_ver_ge(hw, 1, 5))
 		cmd->valid_flags |=
 			cpu_to_le16(I40E_AQC_SET_VSI_PROMISC_RX_ONLY);
 	cmd->seid = cpu_to_le16(seid);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 22150368ba64..050d479aeed3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -594,6 +594,20 @@ static inline bool i40e_is_vf(struct i40e_hw *hw)
 		hw->mac.type == I40E_MAC_X722_VF);
 }
 
+/**
+ * i40e_is_aq_api_ver_ge
+ * @hw: pointer to i40e_hw structure
+ * @maj: API major value to compare
+ * @min: API minor value to compare
+ *
+ * Assert whether current HW API version is greater/equal than provided.
+ **/
+static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
+{
+        return (hw->aq.api_maj_ver > maj ||
+		(hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
+}
+
 struct i40e_driver_version {
 	u8 major_version;
 	u8 minor_version;
-- 
2.41.0


