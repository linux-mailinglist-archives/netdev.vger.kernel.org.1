Return-Path: <netdev+bounces-224654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EFFB877F3
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 02:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56DA1C84B8B
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 00:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C1024DCE6;
	Fri, 19 Sep 2025 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1DlWSeR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B46322D7B6;
	Fri, 19 Sep 2025 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242061; cv=none; b=dbYaDpaFxVDidyEhFgy3LwW2Qmp5LGLlVn7FXK57X5C5rcBCSED60N/blkkU98C39ZNeEkbjFJuz9YefVzp2fLPj9cZLIRBeuH+KO6LsCxxFpj5TfVbDpYE8p8IkBEWHDvHuYO2f6uG/Ssi9nygXhwJGi4hb6BJugs/3xvEP9iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242061; c=relaxed/simple;
	bh=xXwKD+ifDBVBCrB7b6koLwrJ7phZIeOxsP1/aBvt6lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rU6j2QwC6WC07c/iyREmPfyE1mppQ2QxIgEmq0z0ROGeWTILzot2+H2Z7a0iX/z7PajAZ7fbcseIuTgGPv8rkp8vyzdKW3Qz+OmeSpZk1KStEgfOJYrVCBG6a+IkQTq4adJ84AVmBQFiXqtn4/+ky09be4wMyQR+BGWw5Vh9kbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1DlWSeR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758242060; x=1789778060;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xXwKD+ifDBVBCrB7b6koLwrJ7phZIeOxsP1/aBvt6lQ=;
  b=I1DlWSeR3pML0uAt90ZgLRJm4lBwk9kkH3tmLbTWP101+t4bkzQUiwei
   xhFiFDH95ejGuI07hn6OFglarU2rBzkolJXDJK5vWXv5LRTwy3LNZgevS
   0pIZD2wedu+71k1q0MiBRi+Qa8baLlT0pbvBSryaH16X6qkOEGXf3/CC9
   ZfNtNDZRwPSSxr7nrPgS8Zt8u4oo0oaWkU+RnEFeBkBx2LE+r+tbrLsLj
   znbQ45bT5TSJmRI4hX049mTVspN7AJkbPxoX5Zw0En8WSqMcCiSn46qGc
   6Vd7+9dnafz0+XhucDDZFt7Ejt6YTCEIMjppYLOfCg04pjR13xnmABUBa
   Q==;
X-CSE-ConnectionGUID: Sel4FJQ3QQKTBQmaT+VfTQ==
X-CSE-MsgGUID: 6G0ZbZ0SSYGqQqf4jUi+VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60517631"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="60517631"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 17:34:19 -0700
X-CSE-ConnectionGUID: xzZf/9wESjKMTD+65Dk/dA==
X-CSE-MsgGUID: iaK5QreVTCim4C5yw28pOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="180119989"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 17:34:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 18 Sep 2025 17:33:16 -0700
Subject: [PATCH net 1/3] broadcom: fix support for PTP_PEROUT_DUTY_CYCLE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-jk-fix-bcm-phy-supported-flags-v1-1-747b60407c9c@intel.com>
References: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
In-Reply-To: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Richard Cochran <richardcochran@gmail.com>, 
 Yaroslav Kolomiiets <yrk@meta.com>, James Clark <jjc@jclark.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=xXwKD+ifDBVBCrB7b6koLwrJ7phZIeOxsP1/aBvt6lQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowzSzm27kj3bzwpF7zPZgdvP0OIpsSixXOereAqdzoic
 0tZoul2RykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABOZzcXIsKD6/K9OBzFvTfPC
 3RaSV0ofac8K3LDz4PodKSWqpU+Nwxj+KTYJn58qHr9C5QPj4k6tDyK2ChNzXB/JMC2x4t9ZeLG
 OGQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The bcm_ptp_perout_locked() function has support for handling
PTP_PEROUT_DUTY_CYCLE, but its not listed in the supported_perout_flags.
Attempts to use the duty cycle support will be rejected since commit
d9f3e9ecc456 ("net: ptp: introduce .supported_perout_flags to
ptp_clock_info"), as this flag accidentally missed while doing the
conversion.

Drop the unnecessary supported flags check from the bcm_ptp_perout_locked()
function and correctly set the supported_perout_flags. This fixes use of
the PTP_PEROUT_DUTY_CYCLE support for the broadcom driver.

Reported-by: James Clark <jjc@jclark.com>
Fixes: d9f3e9ecc456 ("net: ptp: introduce .supported_perout_flags to ptp_clock_info")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/phy/bcm-phy-ptp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
index eba8b5fb1365..1cf695ac73cc 100644
--- a/drivers/net/phy/bcm-phy-ptp.c
+++ b/drivers/net/phy/bcm-phy-ptp.c
@@ -597,10 +597,6 @@ static int bcm_ptp_perout_locked(struct bcm_ptp_private *priv,
 
 	period = BCM_MAX_PERIOD_8NS;	/* write nonzero value */
 
-	/* Reject unsupported flags */
-	if (req->flags & ~PTP_PEROUT_DUTY_CYCLE)
-		return -EOPNOTSUPP;
-
 	if (req->flags & PTP_PEROUT_DUTY_CYCLE)
 		pulse = ktime_to_ns(ktime_set(req->on.sec, req->on.nsec));
 	else
@@ -741,6 +737,7 @@ static const struct ptp_clock_info bcm_ptp_clock_info = {
 	.n_pins		= 1,
 	.n_per_out	= 1,
 	.n_ext_ts	= 1,
+	.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE,
 };
 
 static void bcm_ptp_txtstamp(struct mii_timestamper *mii_ts,

-- 
2.51.0.rc1.197.g6d975e95c9d7


