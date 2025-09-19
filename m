Return-Path: <netdev+bounces-224655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6E9B877FD
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 02:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC637B34D8
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 00:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B689254848;
	Fri, 19 Sep 2025 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dscAKGfF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5521424676D;
	Fri, 19 Sep 2025 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242063; cv=none; b=mchrdHrPTefMqI0icFFL8Dvqq/qkhLzYsz53YB0fDejsI1HJ+9lvyLWDFlGiOoHk2qWfr2tjlU3O/ZOcGBc6TSuKNtXTmxqlPtH6ABDMrL5ADsxu0o20KjYr+gTV9suZ3pbQr95z8uXqP4DSUbmqaqM1Pfrf9C8tYedhrSNMqI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242063; c=relaxed/simple;
	bh=05qhcsF549Kc/bC4QjL3n33An/vk2zGxYzvD5IR6WXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4gtqGljWtck97UeGdGNvObYT9oM6gWRf86/hoKwetxAviDnC39LZ9f299jEBtawjffolYFc5DNaOBEvRFptwRPzXWQDylMydxKQJ4ep/11WZwq0cYmIA2wN2JpYjTTVHZ+6pzUftJ/l43VTGqbt7KRV2Mc6PzguO+tj5P3opsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dscAKGfF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758242061; x=1789778061;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=05qhcsF549Kc/bC4QjL3n33An/vk2zGxYzvD5IR6WXI=;
  b=dscAKGfFKwaVG5kBbUwkmqGWyyQ/0o7TVp+zsMaTI12ZLTwIR1SZ5WL0
   NBXtubxKMnPl+vXI4ofrqPRa90CFS0EZY5yGAZ9IlC2w2IR/VbSaNDFgd
   ujUc61KZnFI/LCz9dQMUJjzymGdPdfIPbZhIEvZDuBybnJ/AbNl/o7zfC
   p2CTV91A8cGY9gH7FsmHW3ztV1TKQcM5SmIP5nNsbUtuRDsY1dWc22MPX
   psA+vuAdfO0ji469DJfauNdHC0lPQ36qDGrMwKfoxV+XCVeIJku53wNwb
   hCCw4Ypxutp1aPAc9GL3z3rtz/gkZIq6Y3jk7G2X3ucLQ64u/j2pW17aV
   g==;
X-CSE-ConnectionGUID: uvudV7wNTHmvA3QyUBCGYw==
X-CSE-MsgGUID: KuVvF2sUSjqrS40a3/iveA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60517644"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="60517644"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 17:34:19 -0700
X-CSE-ConnectionGUID: EmUhBRHySjy02h9Y2zF6Pw==
X-CSE-MsgGUID: b2gT0LmIRMiQ8uf7wnKx4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="180119992"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 17:34:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 18 Sep 2025 17:33:17 -0700
Subject: [PATCH net 2/3] broadcom: fix support for PTP_EXTTS_REQUEST2 ioctl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-jk-fix-bcm-phy-supported-flags-v1-2-747b60407c9c@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=05qhcsF549Kc/bC4QjL3n33An/vk2zGxYzvD5IR6WXI=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowzSznrWSxvWrMbpfxvaf7w7PD+L/5NP1/8s7255VDqC
 peSH0pnOkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZiI4glGhudvxPylL97i31Du
 UaQQtkFofpiuUP+jso1lD1+kv5ixeycjw7K6iU+abT71zUpq+Tg59O3Mf1PqFq5w4f8usP9evtu
 BF0wA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
ptp_clock_info") modified the PTP core kernel logic to validate the
supported flags for the PTP_EXTTS_REQUEST ioctls, rather than relying on
each individual driver correctly checking its flags.

The bcm_ptp_enable() function implements support for PTP_CLK_REQ_EXTTS, but
does not check the flags, and does not forward the request structure into
bcm_ptp_extts_locked().

When originally converting the bcm-phy-ptp.c code, it was unclear what
edges the hardware actually timestamped. Thus, no flags were initialized in
the .supported_extts_flags field. This results in the kernel automatically
rejecting all userspace requests for the PTP_EXTTS_REQUEST2 ioctl.

This occurs because the PTP_STRICT_FLAGS is always assumed when operating
under PTP_EXTTS_REQUEST2. This has been the case since the flags
introduction by commit 6138e687c7b6 ("ptp: Introduce strict checking of
external time stamp options.").

The bcm-phy-ptp.c logic never properly supported strict flag validation,
as it previously ignored all flags including both PTP_STRICT_FLAGS and the
PTP_FALLING_EDGE and PTP_RISING_EDGE flags.

Reports from users in the field prove that the hardware timestamps the
rising edge. Encode this in the .supported_extts_flags field. This
re-enables support for the PTP_EXTTS_REQUEST2 ioctl.

Reported-by: James Clark <jjc@jclark.com>
Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/phy/bcm-phy-ptp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
index 1cf695ac73cc..d3501f8487d9 100644
--- a/drivers/net/phy/bcm-phy-ptp.c
+++ b/drivers/net/phy/bcm-phy-ptp.c
@@ -738,6 +738,7 @@ static const struct ptp_clock_info bcm_ptp_clock_info = {
 	.n_per_out	= 1,
 	.n_ext_ts	= 1,
 	.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE,
+	.supported_extts_flags = PTP_STRICT_FLAGS | PTP_RISING_EDGE,
 };
 
 static void bcm_ptp_txtstamp(struct mii_timestamper *mii_ts,

-- 
2.51.0.rc1.197.g6d975e95c9d7


