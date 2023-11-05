Return-Path: <netdev+bounces-46098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E992B7E153C
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 17:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7A31F215C7
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794EB154B4;
	Sun,  5 Nov 2023 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaPLWjxo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6B1FD5
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 16:46:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80B8FA
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699202769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eC7KMeIBQqNk/V3RXfwXIU+MwIED52IGZpLe2RUKxaU=;
	b=CaPLWjxok/M9oEaTwhA7+jU7BawpdUY0UOFlXZQ7yhoCPtyRYnAG93iUi8icvZM/0+Z67b
	N+2FM5yfNST/JNWb8E4C1RALIiuuJUS0sSRbWMVL18qt+R/6exylcBq/8wt8+sJ5tTSPux
	o3mZKDdjzDEAgcCg/qOyisWU6qbOGKs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-cwp2luAZMS6wp8sRjoORrA-1; Sun, 05 Nov 2023 11:46:07 -0500
X-MC-Unique: cwp2luAZMS6wp8sRjoORrA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8578D185A780;
	Sun,  5 Nov 2023 16:46:06 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6C71340C6EB9;
	Sun,  5 Nov 2023 16:46:03 +0000 (UTC)
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
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] i40e: Fix adding unsupported cloud filters
Date: Sun,  5 Nov 2023 17:46:02 +0100
Message-ID: <20231105164602.1107498-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

If a VF tries to add unsupported cloud filter through virchnl
then i40e_add_del_cloud_filter(_big_buf) returns -ENOTSUPP but
this error code is stored in 'ret' instead of 'aq_ret' that
is used as error code sent back to VF. In this scenario where
one of the mentioned functions fails the value of 'aq_ret'
is zero so the VF will incorrectly receive a 'success'.

Use 'aq_ret' to store return value and remove 'ret' local
variable. Additionally fix the issue when filter allocation
fails, in this case no notification is sent back to the VF.

Fixes: e284fc280473be ("i40e: Add and delete cloud filter")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c   | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 08d7edccfb8ddb..3f99eb19824527 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3844,7 +3844,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = NULL;
 	int aq_ret = 0;
-	int i, ret;
+	int i;
 
 	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_ACTIVE)) {
 		aq_ret = -EINVAL;
@@ -3868,8 +3868,10 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 	}
 
 	cfilter = kzalloc(sizeof(*cfilter), GFP_KERNEL);
-	if (!cfilter)
-		return -ENOMEM;
+	if (!cfilter) {
+		aq_ret = -ENOMEM;
+		goto err_out;
+	}
 
 	/* parse destination mac address */
 	for (i = 0; i < ETH_ALEN; i++)
@@ -3917,13 +3919,13 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 
 	/* Adding cloud filter programmed as TC filter */
 	if (tcf.dst_port)
-		ret = i40e_add_del_cloud_filter_big_buf(vsi, cfilter, true);
+		aq_ret = i40e_add_del_cloud_filter_big_buf(vsi, cfilter, true);
 	else
-		ret = i40e_add_del_cloud_filter(vsi, cfilter, true);
-	if (ret) {
+		aq_ret = i40e_add_del_cloud_filter(vsi, cfilter, true);
+	if (aq_ret) {
 		dev_err(&pf->pdev->dev,
 			"VF %d: Failed to add cloud filter, err %pe aq_err %s\n",
-			vf->vf_id, ERR_PTR(ret),
+			vf->vf_id, ERR_PTR(aq_ret),
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 		goto err_free;
 	}
-- 
2.41.0


