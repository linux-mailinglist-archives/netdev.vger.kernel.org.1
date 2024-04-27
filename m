Return-Path: <netdev+bounces-91877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41D18B44CF
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 09:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B27B1F22E85
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 07:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E834437D;
	Sat, 27 Apr 2024 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hhovfexu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FDA3BBDC
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714202788; cv=none; b=ID2msLOBsJn8P4wUyLMI80Uha03VGISRYcQHzTdfzCj3TqbKpOSsUuYY1tf1EMzqqHstHuTlATDwMzPx9l1t1PVAH4o6ibSoCFpJT1NAq7QLUEch7lFfllCdvdQ2Qc4jZ7EbjsxFkQo1gVDH/mh+ADwijbZtA65UnfS8JTagjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714202788; c=relaxed/simple;
	bh=XT74XaJOVieTwYLi9yfVtdKUY8VEOf2QpNA1rlYMrFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg6tzn8Fdc8Ar8kfgOw7oTHQvid0ZSASI5dVgcvWdIyVRcw/diQjbpjQQR2nXNi99NU4Pz8PnXsde4YizEyQgePEzqqgZCa1BG8q82jvNSyPPlTSQxZVnwY0e7baptHoMTxt7D5tX2ym2t55KnD3+rGWi/sbb/LlDJfWB/KdLAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hhovfexu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714202786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOHA/dhI682qxnt6YVYVrkfHm66+2a3hHeQGS6dadHI=;
	b=HhovfexuhKQDVYp1/FIdG+CuIImXiSHu39WZIC08KQC3f5QQ2jjqu+y9GHbI0T1JZpkp2S
	hJpf7hLaSme+O8i+xDJJCWNPKv/GXACfLdkDpHgqyASd1FV59pzOOyafR0oJfCEhQFeXw9
	KWbHgkxK5DMZViFues4UpHna9kHTPRs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-8YDEEIMBOv6DROVZNJIVvA-1; Sat, 27 Apr 2024 03:26:21 -0400
X-MC-Unique: 8YDEEIMBOv6DROVZNJIVvA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DC0B8AAD41;
	Sat, 27 Apr 2024 07:26:21 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2A8AA492BC7;
	Sat, 27 Apr 2024 07:26:19 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 1/7] i40e: Remove flags field from i40e_veb
Date: Sat, 27 Apr 2024 09:26:02 +0200
Message-ID: <20240427072615.226151-2-ivecera@redhat.com>
In-Reply-To: <20240427072615.226151-1-ivecera@redhat.com>
References: <20240427072615.226151-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

The field is initialized always to zero and it is never read.
Remove it.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  3 +--
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 13 +++++--------
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 2fbabcdb5bb5..5248e78f7849 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -788,7 +788,6 @@ struct i40e_veb {
 	u16 stats_idx;		/* index of VEB parent */
 	u8  enabled_tc;
 	u16 bridge_mode;	/* Bridge Mode (VEB/VEPA) */
-	u16 flags;
 	u16 bw_limit;
 	u8  bw_max_quanta;
 	bool is_abs_credits;
@@ -1213,7 +1212,7 @@ void i40e_vsi_stop_rings(struct i40e_vsi *vsi);
 void i40e_vsi_stop_rings_no_wait(struct  i40e_vsi *vsi);
 int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi);
 int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count);
-struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags, u16 uplink_seid,
+struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 uplink_seid,
 				u16 downlink_seid, u8 enabled_tc);
 void i40e_veb_release(struct i40e_veb *veb);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index f9ba45f596c9..6147c5f128e8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -867,7 +867,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			goto command_write_done;
 		}
 
-		veb = i40e_veb_setup(pf, 0, uplink_seid, vsi_seid, enabled_tc);
+		veb = i40e_veb_setup(pf, uplink_seid, vsi_seid, enabled_tc);
 		if (veb)
 			dev_info(&pf->pdev->dev, "added relay %d\n", veb->seid);
 		else
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bcc99a6676f9..e27b2aa544b6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13127,7 +13127,7 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 
 		/* Insert a new HW bridge */
 		if (!veb) {
-			veb = i40e_veb_setup(pf, 0, vsi->uplink_seid, vsi->seid,
+			veb = i40e_veb_setup(pf, vsi->uplink_seid, vsi->seid,
 					     vsi->tc_config.enabled_tc);
 			if (veb) {
 				veb->bridge_mode = mode;
@@ -14383,10 +14383,10 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 		}
 
 		if (vsi->uplink_seid == pf->mac_seid)
-			veb = i40e_veb_setup(pf, 0, pf->mac_seid, vsi->seid,
+			veb = i40e_veb_setup(pf, pf->mac_seid, vsi->seid,
 					     vsi->tc_config.enabled_tc);
 		else if ((vsi->flags & I40E_VSI_FLAG_VEB_OWNER) == 0)
-			veb = i40e_veb_setup(pf, 0, vsi->uplink_seid, vsi->seid,
+			veb = i40e_veb_setup(pf, vsi->uplink_seid, vsi->seid,
 					     vsi->tc_config.enabled_tc);
 		if (veb) {
 			if (vsi->seid != pf->vsi[pf->lan_vsi]->seid) {
@@ -14780,7 +14780,6 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 /**
  * i40e_veb_setup - Set up a VEB
  * @pf: board private structure
- * @flags: VEB setup flags
  * @uplink_seid: the switch element to link to
  * @vsi_seid: the initial VSI seid
  * @enabled_tc: Enabled TC bit-map
@@ -14793,9 +14792,8 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
  * Returns pointer to the successfully allocated VEB sw struct on
  * success, otherwise returns NULL on failure.
  **/
-struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
-				u16 uplink_seid, u16 vsi_seid,
-				u8 enabled_tc)
+struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 uplink_seid,
+				u16 vsi_seid, u8 enabled_tc)
 {
 	struct i40e_vsi *vsi = NULL;
 	struct i40e_veb *veb;
@@ -14826,7 +14824,6 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 	if (veb_idx < 0)
 		goto err_alloc;
 	veb = pf->veb[veb_idx];
-	veb->flags = flags;
 	veb->uplink_seid = uplink_seid;
 	veb->enabled_tc = (enabled_tc ? enabled_tc : 0x1);
 
-- 
2.43.2


