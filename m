Return-Path: <netdev+bounces-47787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225D57EB635
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5212B1C20B28
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164DD26AE7;
	Tue, 14 Nov 2023 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERliy9MF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A665741774
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F593130
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985722; x=1731521722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TpHFqILVWxBY6wN2TbeigiPQoz4ReR8ZKczxS3AohzU=;
  b=ERliy9MFTrFCx75JWENS38sktbNvkXsmxxdfdfHgyLPcvY4gZ/rziXTw
   fW3FhqNOigg/hXjL8EZrdM1WjZnsovH05iQNKfQHCej68C7SRZKEPQQwA
   XAM5+YRkCHWwpjUiroPIpv7EfN+ePE/nsZPwdLFLLvXPXd8BXxZZrtzML
   o0ksxi8uwliGuZfynbJZjRBn7ND/jhhviBUqMWSGTihOe1BCI9ohzgc37
   uJacbe3M5tkn/9NVTLsIJ5uPGmznAjjVrck6moaKeGni6asp+3w33QfS/
   01/6N+WWG900xwyAMwfLUN8MkHArJ2kHChhiCc8m0Sd2WgQJHphyPOJYv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514469"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514469"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160938"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160938"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:15:01 -0800
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
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 05/15] ice: use repr instead of vf->repr
Date: Tue, 14 Nov 2023 10:14:25 -0800
Message-ID: <20231114181449.1290117-6-anthony.l.nguyen@intel.com>
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

Extract repr from vf->repr as it is often use in the ice_repr_rem().

Remove meaningless clearing of q_vector and netdev pointers as kfree is
called on repr pointer.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index a2dc216c964f..903a3385eacb 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -355,16 +355,16 @@ static int ice_repr_add(struct ice_vf *vf)
  */
 static void ice_repr_rem(struct ice_vf *vf)
 {
-	if (!vf->repr)
+	struct ice_repr *repr = vf->repr;
+
+	if (!repr)
 		return;
 
-	kfree(vf->repr->q_vector);
-	vf->repr->q_vector = NULL;
-	unregister_netdev(vf->repr->netdev);
+	kfree(repr->q_vector);
+	unregister_netdev(repr->netdev);
 	ice_devlink_destroy_vf_port(vf);
-	free_netdev(vf->repr->netdev);
-	vf->repr->netdev = NULL;
-	kfree(vf->repr);
+	free_netdev(repr->netdev);
+	kfree(repr);
 	vf->repr = NULL;
 
 	ice_virtchnl_set_dflt_ops(vf);
-- 
2.41.0


