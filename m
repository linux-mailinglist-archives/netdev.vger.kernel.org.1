Return-Path: <netdev+bounces-39347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4328F7BEE55
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749E31C209DA
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D19450E9;
	Mon,  9 Oct 2023 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBvuOgf2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE9450F6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 22:29:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B803A3;
	Mon,  9 Oct 2023 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696890592; x=1728426592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CGI8OCuYRAuMfp/tnwmDEDUqTneEivLAfZlSuk7iWVc=;
  b=LBvuOgf2JmAaHBXNvyont6ulNM+hr5EhjmXWp98DV/XXtFaRFC4gZ4+y
   pWWBcHvXhd0Y+15dUNH0Rp1lqCJhFKiQo8c/EmjNPVFIH8YRcmk7yskAw
   tHImt0jUMILWTna7WKcF9Xvmq+M/HM3uCoqKil4cNW3l+OSfPfe2Ei1m6
   NfI1AFHUHZjHh9VIzZCuOXt2N0sQKUedayo2KEev9N0sfPLYHIMCXsQGS
   a5wLyzWrZlQcLhBr9MlorIwee3GjmxdpxEzqzP0HangcVlPGPpesDHY4+
   cS9O7U32hngQ+7wIvjzclubwhZJzKU7s22z1JJ07yjyBKYjxHU8UCFrRX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="2849442"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="2849442"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 15:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="843876605"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="843876605"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Oct 2023 15:29:02 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	corbet@lwn.net,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v4 5/5] dpll: netlink/core: change pin frequency set behavior
Date: Tue, 10 Oct 2023 00:26:16 +0200
Message-Id: <20231009222616.12163-6-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
References: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Align the approach of pin frequency set behavior with the approach
introduced with pin phase adjust set.
Fail the request if any of devices did not registered the callback ops.
If callback op on any pin's registered device fails, return error and
rollback the value to previous one.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/dpll/dpll_netlink.c | 50 +++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 09a6c2a1ea92..a6dc3997bf5c 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -615,8 +615,10 @@ static int
 dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		  struct netlink_ext_ack *extack)
 {
-	u64 freq = nla_get_u64(a);
-	struct dpll_pin_ref *ref;
+	u64 freq = nla_get_u64(a), old_freq;
+	struct dpll_pin_ref *ref, *failed;
+	const struct dpll_pin_ops *ops;
+	struct dpll_device *dpll;
 	unsigned long i;
 	int ret;
 
@@ -626,19 +628,51 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 	}
 
 	xa_for_each(&pin->dpll_refs, i, ref) {
-		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
-		struct dpll_device *dpll = ref->dpll;
-
-		if (!ops->frequency_set)
+		ops = dpll_pin_ops(ref);
+		if (!ops->frequency_set || !ops->frequency_get) {
+			NL_SET_ERR_MSG(extack, "frequency set not supported by the device");
 			return -EOPNOTSUPP;
+		}
+	}
+	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
+	ops = dpll_pin_ops(ref);
+	dpll = ref->dpll;
+	ret = ops->frequency_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
+				 dpll_priv(dpll), &old_freq, extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack, "unable to get old frequency value");
+		return ret;
+	}
+	if (freq == old_freq)
+		return 0;
+
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		ops = dpll_pin_ops(ref);
+		dpll = ref->dpll;
 		ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
 					 dpll, dpll_priv(dpll), freq, extack);
-		if (ret)
-			return ret;
+		if (ret) {
+			failed = ref;
+			NL_SET_ERR_MSG_FMT(extack, "frequency set failed for dpll_id:%u",
+					   dpll->id);
+			goto rollback;
+		}
 	}
 	__dpll_pin_change_ntf(pin);
 
 	return 0;
+
+rollback:
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		if (ref == failed)
+			break;
+		ops = dpll_pin_ops(ref);
+		dpll = ref->dpll;
+		if (ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
+				       dpll, dpll_priv(dpll), old_freq, extack))
+			NL_SET_ERR_MSG(extack, "set frequency rollback failed");
+	}
+	return ret;
 }
 
 static int
-- 
2.38.1


