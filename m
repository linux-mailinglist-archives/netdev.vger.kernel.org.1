Return-Path: <netdev+bounces-45978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8219E7E0A6D
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 21:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0ABEB20FCD
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 20:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734BE1D557;
	Fri,  3 Nov 2023 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCxA7rPv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B4224ED
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 20:42:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0B2D53
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699044147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pzoYxr3bqaj9J8o6w9KSItY5CaVEMiyYip8XBCOjU7A=;
	b=VCxA7rPv0H132J8+OcR/f/W12klYvmXjM+UkYYZ8CQmjcCxVjR3n0tHUUWRjqSBxjRqFAk
	v8qmgi28oUUZND0Ub2tYxXxbDNzJGBjCZ37CWIx6dfwN6W/x1tXoluaZCd7W2fNJCLe8+K
	omx7jMXrjuicU9WtH14jNIvaqbqS8QA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-GCm0XO-jMfWFr0uynWPCMA-1; Fri, 03 Nov 2023 16:42:20 -0400
X-MC-Unique: GCm0XO-jMfWFr0uynWPCMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22D5C101A529;
	Fri,  3 Nov 2023 20:42:20 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3E5D51121309;
	Fri,  3 Nov 2023 20:42:17 +0000 (UTC)
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
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net] i40e: Fix adding unsupported cloud filters
Date: Fri,  3 Nov 2023 21:42:16 +0100
Message-ID: <20231103204216.1072251-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

If a VF tries to add unsupported cloud filter through virchnl
then i40e_add_del_cloud_filter(_big_buf) returns -ENOTSUPP but
this error code is stored in 'ret' instead of 'aq_ret' that
is used as error code sent back to VF. In this scenario where
one of the mentioned functions fails the value of 'aq_ret'
is zero so the VF will incorrectly receive a 'success'.

Use 'aq_ret' to store return value and remove 'ret' local
variable. Additionally fix the issue when filter allocation
fails, in this case no notification is sent back to the VF.

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


