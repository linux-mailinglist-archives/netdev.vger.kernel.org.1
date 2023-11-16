Return-Path: <netdev+bounces-48379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C2A7EE31F
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155751F270D0
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0437F2A1D5;
	Thu, 16 Nov 2023 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flczT2p+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A703AD50
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700145692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stbGOODh8tk5o2GOe6PswSyEphSUMG8TxPvMULqhYkI=;
	b=flczT2p+sHtVURQjme3nq5z34BohQ2phLP0OkTCRWGG6BiJBytITkGKIynerlSJ+64AlAb
	u1K4AHmdMTONATAcvnelmt7y/qBSsUeDWh7qtVDVi5oZB4/nBAYJsEWWQieZQizMwNTZgm
	6NYiztYXUGxdd0KU+efQPMOZliYuR8k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-rnCZXfM5OzC_5CJ9gk4SAg-1; Thu, 16 Nov 2023 09:41:29 -0500
X-MC-Unique: rnCZXfM5OzC_5CJ9gk4SAg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5640185A784;
	Thu, 16 Nov 2023 14:41:28 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.144])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1647D1121306;
	Thu, 16 Nov 2023 14:41:26 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	mschmidt@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 3/5] i40e: Add helpers to find VSI and VEB by SEID and use them
Date: Thu, 16 Nov 2023 15:41:17 +0100
Message-ID: <20231116144119.78769-4-ivecera@redhat.com>
In-Reply-To: <20231116144119.78769-1-ivecera@redhat.com>
References: <20231116144119.78769-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
VEB or VSI by their SEID value and use these helpers to replace
existing open-coded loops.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 34 +++++++++
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 38 ++--------
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 76 ++++++-------------
 3 files changed, 64 insertions(+), 84 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 1e9266de270b..3fe628515fc9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1360,4 +1360,38 @@ static inline struct i40e_pf *i40e_hw_to_pf(struct i40e_hw *hw)
 
 struct device *i40e_hw_to_dev(struct i40e_hw *hw);
 
+/**
+ * i40e_pf_get_vsi_by_seid - find VSI by SEID
+ * @pf: pointer to a PF
+ **/
+static inline struct i40e_vsi *
+i40e_pf_get_vsi_by_seid(struct i40e_pf *pf, u16 seid)
+{
+	struct i40e_vsi *vsi;
+	int i;
+
+	i40e_pf_for_each_vsi(pf, i, vsi)
+		if (vsi->seid == seid)
+			return vsi;
+
+	return NULL;
+}
+
+/**
+ * i40e_veb_get_by_seid - find VEB by SEID
+ * @pf: pointer to a PF
+ **/
+static inline struct i40e_veb *
+i40e_veb_get_by_seid(struct i40e_pf *pf, u16 seid)
+{
+	struct i40e_veb *veb;
+	int i;
+
+	i40e_pf_for_each_veb(pf, i, veb)
+		if (veb->seid == seid)
+			return veb;
+
+	return NULL;
+}
+
 #endif /* _I40E_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index b236b0f93202..399988073928 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -24,37 +24,13 @@ enum ring_type {
  **/
 static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
 {
-	struct i40e_vsi *vsi;
-	int i;
-
 	if (seid < 0) {
 		dev_info(&pf->pdev->dev, "%d: bad seid\n", seid);
 
 		return NULL;
 	}
 
-	i40e_pf_for_each_vsi(pf, i, vsi)
-		if (vsi->seid == seid)
-			return vsi;
-
-	return NULL;
-}
-
-/**
- * i40e_dbg_find_veb - searches for the veb with the given seid
- * @pf: the PF structure to search for the veb
- * @seid: seid of the veb it is searching for
- **/
-static struct i40e_veb *i40e_dbg_find_veb(struct i40e_pf *pf, int seid)
-{
-	struct i40e_veb *veb;
-	int i;
-
-	i40e_pf_for_each_veb(pf, i, veb)
-		if (veb->seid == seid)
-			return veb;
-
-	return NULL;
+	return i40e_pf_get_vsi_by_seid(pf, seid);
 }
 
 /**************************************************************
@@ -701,7 +677,7 @@ static void i40e_dbg_dump_veb_seid(struct i40e_pf *pf, int seid)
 {
 	struct i40e_veb *veb;
 
-	veb = i40e_dbg_find_veb(pf, seid);
+	veb = i40e_veb_get_by_seid(pf, seid);
 	if (!veb) {
 		dev_info(&pf->pdev->dev, "can't find veb %d\n", seid);
 		return;
@@ -853,7 +829,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 
 	} else if (strncmp(cmd_buf, "add relay", 9) == 0) {
 		struct i40e_veb *veb;
-		int uplink_seid, i;
+		int uplink_seid;
 
 		cnt = sscanf(&cmd_buf[9], "%i %i", &uplink_seid, &vsi_seid);
 		if (cnt != 2) {
@@ -875,12 +851,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			goto command_write_done;
 		}
 
-		i40e_pf_for_each_veb(pf, i, veb)
-			if (veb->seid == uplink_seid)
-				break;
-
-		if (i >= I40E_MAX_VEB && uplink_seid != 0 &&
-		    uplink_seid != pf->mac_seid) {
+		veb = i40e_veb_get_by_seid(pf, uplink_seid);
+		if (!veb && uplink_seid != 0 && uplink_seid != pf->mac_seid) {
 			dev_info(&pf->pdev->dev,
 				 "add relay: relay uplink %d not found\n",
 				 uplink_seid);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c410fc31a051..897b3395afb6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13120,18 +13120,14 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 	struct i40e_pf *pf = vsi->back;
 	struct nlattr *attr, *br_spec;
 	struct i40e_veb *veb;
-	int i, rem;
+	int rem;
 
 	/* Only for PF VSI for now */
 	if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
 		return -EOPNOTSUPP;
 
 	/* Find the HW bridge for PF VSI */
-	i40e_pf_for_each_veb(pf, i, veb)
-		if (veb->seid == vsi->uplink_seid)
-			break;
-	if (i == I40E_MAX_VEB)
-		veb = NULL; /* No VEB found */
+	veb = i40e_veb_get_by_seid(pf, vsi->uplink_seid);
 
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
 	if (!br_spec)
@@ -13197,17 +13193,14 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_veb *veb = NULL;
-	int i;
 
 	/* Only for PF VSI for now */
 	if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
 		return -EOPNOTSUPP;
 
 	/* Find the HW bridge for the PF VSI */
-	i40e_pf_for_each_veb(pf, i, veb)
-		if (veb->seid == vsi->uplink_seid)
-			break;
-	if (i == I40E_MAX_VEB)
+	veb = i40e_veb_get_by_seid(pf, vsi->uplink_seid);
+	if (!vsi)
 		return 0;
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode,
@@ -14382,8 +14375,8 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	struct i40e_vsi *vsi = NULL;
 	struct i40e_veb *veb = NULL;
 	u16 alloc_queue_pairs;
-	int ret, i;
 	int v_idx;
+	int ret;
 
 	/* The requested uplink_seid must be either
 	 *     - the PF's port seid
@@ -14398,18 +14391,10 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	 *
 	 * Find which uplink_seid we were given and create a new VEB if needed
 	 */
-	i40e_pf_for_each_veb(pf, i, veb)
-		if (veb->seid == uplink_seid)
-			break;
-	if (i == I40E_MAX_VEB)
-		veb = NULL;
-
+	veb = i40e_veb_get_by_seid(pf, uplink_seid);
 	if (!veb && uplink_seid != pf->mac_seid) {
-		i40e_pf_for_each_vsi(pf, i, vsi)
-			if (vsi->seid == uplink_seid)
-				break;
-
-		if (i == pf->num_alloc_vsi) {
+		vsi = i40e_pf_get_vsi_by_seid(pf, uplink_seid);
+		if (!vsi) {
 			dev_info(&pf->pdev->dev, "no such uplink_seid %d\n",
 				 uplink_seid);
 			return NULL;
@@ -14437,10 +14422,8 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 			}
 			i40e_config_bridge_mode(veb);
 		}
-		i40e_pf_for_each_veb(pf, i, veb)
-			if (veb->seid == vsi->uplink_seid)
-				break;
-		if (i == I40E_MAX_VEB) {
+		veb = i40e_veb_get_by_seid(pf, vsi->uplink_seid);
+		if (!veb) {
 			dev_info(&pf->pdev->dev, "couldn't add VEB\n");
 			return NULL;
 		}
@@ -14835,7 +14818,7 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 {
 	struct i40e_veb *veb, *uplink_veb = NULL;
 	struct i40e_vsi *vsi;
-	int vsi_idx, veb_idx;
+	int veb_idx;
 	int ret;
 
 	/* if one seid is 0, the other must be 0 to create a floating relay */
@@ -14848,23 +14831,16 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 	}
 
 	/* make sure there is such a vsi and uplink */
-	i40e_pf_for_each_vsi(pf, vsi_idx, vsi)
-		if (vsi->seid == vsi_seid)
-			break;
-
-	if (vsi_idx == pf->num_alloc_vsi && vsi_seid != 0) {
-		dev_info(&pf->pdev->dev, "vsi seid %d not found\n",
-			 vsi_seid);
-		return NULL;
+	if (vsi_seid) {
+		vsi = i40e_pf_get_vsi_by_seid(pf, vsi_seid);
+		if (!vsi) {
+			dev_err(&pf->pdev->dev, "vsi seid %d not found\n",
+				vsi_seid);
+			return NULL;
+		}
 	}
-
 	if (uplink_seid && uplink_seid != pf->mac_seid) {
-		i40e_pf_for_each_veb(pf, veb_idx, veb) {
-			if (veb->seid == uplink_seid) {
-				uplink_veb = veb;
-				break;
-			}
-		}
+		uplink_veb = i40e_veb_get_by_seid(pf, uplink_seid);
 		if (!uplink_veb) {
 			dev_info(&pf->pdev->dev,
 				 "uplink seid %d not found\n", uplink_seid);
@@ -14886,7 +14862,8 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 	ret = i40e_add_veb(veb, vsi);
 	if (ret)
 		goto err_veb;
-	if (vsi_idx == pf->lan_vsi)
+
+	if (vsi && vsi->idx == pf->lan_vsi)
 		pf->lan_veb = veb->idx;
 
 	return veb;
@@ -14933,13 +14910,10 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
 			int v;
 
 			/* find existing or else empty VEB */
-			i40e_pf_for_each_veb(pf, v, veb)
-				if (veb->seid == seid) {
-					pf->lan_veb = v;
-					break;
-				}
-
-			if (pf->lan_veb >= I40E_MAX_VEB) {
+			veb = i40e_veb_get_by_seid(pf, seid);
+			if (veb) {
+				pf->lan_veb = veb->idx;
+			} else {
 				v = i40e_veb_mem_alloc(pf);
 				if (v < 0)
 					break;
-- 
2.41.0


