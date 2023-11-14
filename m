Return-Path: <netdev+bounces-47788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AA27EB637
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F541C20B94
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63C326AFB;
	Tue, 14 Nov 2023 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AiUU9Z/I"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5A26AC9
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8C2132
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985723; x=1731521723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iob+Pu94U2ok8s4p7lnzO3sR8X3LvOV2ZQxcsVXfyPs=;
  b=AiUU9Z/I91EiE3KIuZ/GWCVNbzmcTXsNjaJS0NkUZrS8Vc0iJVoyrabu
   2drXD/4uLjE9zmi+efuADXpPyr3ZGsQGKdj4FNKrQnYtW6W6yRd1BbBpP
   Avft5LsO6an5wS0SfU9//FabZCAZyvE2k/gF6mur0QlJMNRto4u3aFYyu
   8+WiFvKND/LDMB0d/0LbEWCGuWHj/cDIpv6OL2UZD2RfE2IxIpE6Ns5iz
   6ac003YTamyJ+Nk7AX6HO60KJtscm4jgDMKFcQX/VyOLITE8la8Q8A1io
   UVJWFXnsZk83Yc0idmXzQ64JgYrum1pj0HUa/n8kNG1Wbyq+2lS2yBHBR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514504"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514504"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160954"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160954"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:15:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	piotr.raczynski@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 09/15] ice: return pointer to representor
Date: Tue, 14 Nov 2023 10:14:29 -0800
Message-ID: <20231114181449.1290117-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

In follow up patches it will be easier to obtain created port
representor pointer instead of the id. Without it the pattern from
eswitch side will look like:
- create PR
- get PR based on the id

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index fce25472d053..b29a3d010780 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -382,7 +382,7 @@ ice_repr_add(struct ice_pf *pf, struct ice_vsi *src_vsi, const u8 *parent_mac)
 	return ERR_PTR(err);
 }
 
-static int ice_repr_add_vf(struct ice_vf *vf)
+static struct ice_repr *ice_repr_add_vf(struct ice_vf *vf)
 {
 	struct ice_repr *repr;
 	struct ice_vsi *vsi;
@@ -390,11 +390,11 @@ static int ice_repr_add_vf(struct ice_vf *vf)
 
 	vsi = ice_get_vf_vsi(vf);
 	if (!vsi)
-		return -EINVAL;
+		return ERR_PTR(-ENOENT);
 
 	err = ice_devlink_create_vf_port(vf);
 	if (err)
-		return err;
+		return ERR_PTR(err);
 
 	repr = ice_repr_add(vf->pf, vsi, vf->hw_lan_addr);
 	if (IS_ERR(repr)) {
@@ -416,13 +416,13 @@ static int ice_repr_add_vf(struct ice_vf *vf)
 
 	ice_virtchnl_set_repr_ops(vf);
 
-	return 0;
+	return repr;
 
 err_netdev:
 	ice_repr_rem(&vf->pf->eswitch.reprs, repr);
 err_repr_add:
 	ice_devlink_destroy_vf_port(vf);
-	return err;
+	return ERR_PTR(err);
 }
 
 /**
@@ -432,6 +432,7 @@ static int ice_repr_add_vf(struct ice_vf *vf)
 int ice_repr_add_for_all_vfs(struct ice_pf *pf)
 {
 	struct devlink *devlink;
+	struct ice_repr *repr;
 	struct ice_vf *vf;
 	unsigned int bkt;
 	int err;
@@ -439,9 +440,11 @@ int ice_repr_add_for_all_vfs(struct ice_pf *pf)
 	lockdep_assert_held(&pf->vfs.table_lock);
 
 	ice_for_each_vf(pf, bkt, vf) {
-		err = ice_repr_add_vf(vf);
-		if (err)
+		repr = ice_repr_add_vf(vf);
+		if (IS_ERR(repr)) {
+			err = PTR_ERR(repr);
 			goto err;
+		}
 	}
 
 	/* only export if ADQ and DCB disabled */
-- 
2.41.0


