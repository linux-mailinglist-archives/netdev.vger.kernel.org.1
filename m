Return-Path: <netdev+bounces-43330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29F57D27E7
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 03:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AED2812FB
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 01:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DACEA9;
	Mon, 23 Oct 2023 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA4A4E
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 01:21:25 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 6E796C2;
	Sun, 22 Oct 2023 18:21:23 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 157906047A509;
	Mon, 23 Oct 2023 09:20:59 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com
Cc: Su Hui <suhui@nfschina.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 RESEND] i40e: add an error code check in i40e_vsi_setup
Date: Mon, 23 Oct 2023 09:20:25 +0800
Message-Id: <20231023012024.18757-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check the value of 'ret' after calling 'i40e_vsi_config_rss'.

Signed-off-by: Su Hui <suhui@nfschina.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Resend to hit the intel0wired-lan list.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index de7fd43dc11c..4904bc8f5777 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14567,9 +14567,13 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	if ((pf->hw_features & I40E_HW_RSS_AQ_CAPABLE) &&
 	    (vsi->type == I40E_VSI_VMDQ2)) {
 		ret = i40e_vsi_config_rss(vsi);
+		if (ret)
+			goto err_config;
 	}
 	return vsi;
 
+err_config:
+	i40e_vsi_clear_rings(vsi);
 err_rings:
 	i40e_vsi_free_q_vectors(vsi);
 err_msix:
-- 
2.30.2


