Return-Path: <netdev+bounces-13163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F8A73A86B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD8E1C21088
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFBB2107A;
	Thu, 22 Jun 2023 18:41:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4228200D3
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:41:12 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650C8F1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687459271; x=1718995271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qnjRk7JHHUA3sx/puJNUxF6wyBqfzYjGqwu18b1xf1k=;
  b=ScKAhXjnp1jhFxQ1ijd4BiZq8Aw7LrbNN48d2tfA0owc2vwO2WjLQaJJ
   yiiV35B8rKP5DrZ6930SWWTk5tQr6SyqIrBdc+omgbpU3tXqxg2EEIKSI
   gKqE+NnS2DTcqZHkOoaoPRQeNVv+WhmWteqMISg7yfVoEZZKs0wvfQwbG
   iPjjkHccdSZwFPQiWd09oW7PokSCdoHLa2/Mwyv7vCNxB3Uq9dsajm8zV
   omjuztVqfyd/1Jb1o/a104WEl5kWhzuvuZDGeYyRRjNM14ZqeygWnTPGT
   jWfYLTmGcVEd4R24gc/gf9w8QwnVw7dC/RV/M00kLnl8AC/Fz4WGJhr27
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340917819"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="340917819"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:41:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="961687060"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="961687060"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2023 11:41:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <simon.horman@corigine.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 6/6] ice: use ice_down_up() where applicable
Date: Thu, 22 Jun 2023 11:36:01 -0700
Message-Id: <20230622183601.2406499-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
References: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

ice_change_mtu() is currently using a separate ice_down() and ice_up()
calls to reflect changed MTU. ice_down_up() serves this purpose, so do
the refactoring here.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5dd88611141e..93979ab18bc1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7412,21 +7412,9 @@ static int ice_change_mtu(struct net_device *netdev, int new_mtu)
 	}
 
 	netdev->mtu = (unsigned int)new_mtu;
-
-	/* if VSI is up, bring it down and then back up */
-	if (!test_and_set_bit(ICE_VSI_DOWN, vsi->state)) {
-		err = ice_down(vsi);
-		if (err) {
-			netdev_err(netdev, "change MTU if_down err %d\n", err);
-			return err;
-		}
-
-		err = ice_up(vsi);
-		if (err) {
-			netdev_err(netdev, "change MTU if_up err %d\n", err);
-			return err;
-		}
-	}
+	err = ice_down_up(vsi);
+	if (err)
+		return err;
 
 	netdev_dbg(netdev, "changed MTU to %d\n", new_mtu);
 	set_bit(ICE_FLAG_MTU_CHANGED, pf->flags);
-- 
2.38.1


