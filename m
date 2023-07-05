Return-Path: <netdev+bounces-15643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D0A748EBC
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 22:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048AC2810CD
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AB0156CE;
	Wed,  5 Jul 2023 20:19:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC9154BB
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 20:19:15 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703FB198D
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688588354; x=1720124354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gPMgHZ5KXd5ShHPZWmVJMOZm5XFDYCTkuBsB5SIwEjs=;
  b=dXmOiCJFxocrt6AS/B3k5iBIUjADw5TGmlKMoQvdBdAj+8eZgRV+dGi3
   Fo53d94fsfJ/CELb7ixU9QRA+2zY2KV38bQZC8LpD9X23IgHSfWzHuv7x
   l/0d8ilDzDfdTDRT+xyxLPwYCJLG+nOqrKKnL+tTjzCg2cPYX49JTNq8K
   YbR/qh3azb/wsO90lX3qJLeEO7KvnA3KkXuaXSeCVl8xMupJf1dtkawJy
   LZSOjCo143CAa+RkLRqZS3RbFFapd9ejT7v31NuE+jvgYsApVfvOpXruQ
   uptDITd9u9EA176MwtwSVFenxjj410PSemiuY0WNNk9R8wEDia9AKofrR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="427117967"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="427117967"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 13:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="965944742"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="965944742"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2023 13:19:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	anthony.l.nguyen@intel.com,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	Bharathi Sreenivas <bharathi.sreenivas@intel.com>
Subject: [PATCH net 1/2] ice: Fix max_rate check while configuring TX rate limits
Date: Wed,  5 Jul 2023 13:13:45 -0700
Message-Id: <20230705201346.49370-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230705201346.49370-1-anthony.l.nguyen@intel.com>
References: <20230705201346.49370-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Sridhar Samudrala <sridhar.samudrala@intel.com>

Remove incorrect check in ice_validate_mqprio_opt() that limits
filter configuration when sum of max_rates of all TCs exceeds
the link speed. The max rate of each TC is unrelated to value
used by other TCs and is valid as long as it is less than link
speed.

Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 93979ab18bc1..64efe4c83a3e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7872,10 +7872,10 @@ static int
 ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 			 struct tc_mqprio_qopt_offload *mqprio_qopt)
 {
-	u64 sum_max_rate = 0, sum_min_rate = 0;
 	int non_power_of_2_qcount = 0;
 	struct ice_pf *pf = vsi->back;
 	int max_rss_q_cnt = 0;
+	u64 sum_min_rate = 0;
 	struct device *dev;
 	int i, speed;
 	u8 num_tc;
@@ -7891,6 +7891,7 @@ ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 	dev = ice_pf_to_dev(pf);
 	vsi->ch_rss_size = 0;
 	num_tc = mqprio_qopt->qopt.num_tc;
+	speed = ice_get_link_speed_kbps(vsi);
 
 	for (i = 0; num_tc; i++) {
 		int qcount = mqprio_qopt->qopt.count[i];
@@ -7931,7 +7932,6 @@ ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 		 */
 		max_rate = mqprio_qopt->max_rate[i];
 		max_rate = div_u64(max_rate, ICE_BW_KBPS_DIVISOR);
-		sum_max_rate += max_rate;
 
 		/* min_rate is minimum guaranteed rate and it can't be zero */
 		min_rate = mqprio_qopt->min_rate[i];
@@ -7944,6 +7944,12 @@ ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 			return -EINVAL;
 		}
 
+		if (max_rate && max_rate > speed) {
+			dev_err(dev, "TC%d: max_rate(%llu Kbps) > link speed of %u Kbps\n",
+				i, max_rate, speed);
+			return -EINVAL;
+		}
+
 		iter_div_u64_rem(min_rate, ICE_MIN_BW_LIMIT, &rem);
 		if (rem) {
 			dev_err(dev, "TC%d: Min Rate not multiple of %u Kbps",
@@ -7981,12 +7987,6 @@ ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 	    (mqprio_qopt->qopt.offset[i] + mqprio_qopt->qopt.count[i]))
 		return -EINVAL;
 
-	speed = ice_get_link_speed_kbps(vsi);
-	if (sum_max_rate && sum_max_rate > (u64)speed) {
-		dev_err(dev, "Invalid max Tx rate(%llu) Kbps > speed(%u) Kbps specified\n",
-			sum_max_rate, speed);
-		return -EINVAL;
-	}
 	if (sum_min_rate && sum_min_rate > (u64)speed) {
 		dev_err(dev, "Invalid min Tx rate(%llu) Kbps > speed (%u) Kbps specified\n",
 			sum_min_rate, speed);
-- 
2.38.1


