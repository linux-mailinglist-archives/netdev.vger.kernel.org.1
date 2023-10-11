Return-Path: <netdev+bounces-39953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7707C4FD7
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8562821F0
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A2F1DA4B;
	Wed, 11 Oct 2023 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnTcXD4Q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13441DA49;
	Wed, 11 Oct 2023 10:15:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9981C92;
	Wed, 11 Oct 2023 03:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697019336; x=1728555336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CGI8OCuYRAuMfp/tnwmDEDUqTneEivLAfZlSuk7iWVc=;
  b=SnTcXD4Q6Hul3893D3CLAQS5g+XIw8Oe7MR4qc0vPFHr02OKTPRO1Jen
   iDlX1zvsGegnzWhhH7WQpFZ9BMVhRvMqcQqlRCzPVBTX4JhdcO7sHC7WH
   RFnST+U5ZIIRnKxMfGRVVrLdEmm2kJQfd35UrX53X3qcsrrdS2jZ9wMDv
   +FPV9KiJjbB6B9F5pUMZEugYVgv+N55Chp6pLCba3+Je64Dw6O/sz3CBD
   RwMCLy4/7JjqZlIvNP7TCKX8t1z5PnUyT4ru6aEHOgXyuqsmsJ76n+6VC
   2Y62dkqtZ8FXg2n5PS67uf1QXnosFr4c36mUId2nfnQB1RM0NXcVTzDBu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415672231"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415672231"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897576455"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="897576455"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2023 03:13:48 -0700
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
Subject: [PATCH net-next v5 5/5] dpll: netlink/core: change pin frequency set behavior
Date: Wed, 11 Oct 2023 12:12:36 +0200
Message-Id: <20231011101236.23160-6-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011101236.23160-1-arkadiusz.kubalewski@intel.com>
References: <20231011101236.23160-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
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


