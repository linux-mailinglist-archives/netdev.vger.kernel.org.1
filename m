Return-Path: <netdev+bounces-227957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BDBBBE0DA
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 14:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A987A4ED486
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D58280338;
	Mon,  6 Oct 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bivaAA6j"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD427FD5B
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754350; cv=none; b=aNjZneRbvsQr2qag/LIdpMDaNkdFNWzmRzkg3+w3UbfGFUBQni4UwBj+zEgdPKHZRvIIg/B3AJEFjqBYqxvsa+fc1Ux7Tjq2lChMsQ87/uwF1YtEPsqKPk52Vk5sn9hMUkI4ROps3eq1dAuVHwrs9yA9DaCeiGeMzj5IkKq1s9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754350; c=relaxed/simple;
	bh=UgS1T3L/1Bhs51eXw2IzOOwJV72XJxev8LFTplWv1Os=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uysR8Tgf9J1fcHO/+nN3OHlpT6u4O97tOtXBHa2Clg1HHD1lKwlfYICDUleetwwoHTgYKxZSDvlgBrYepTMUiBiJe2x8y/raGxGPbQr+I5G2KYbACa13+DJFbuPvt7OspUj/F6oQSz5bMk3ecBXDyPJ6kjw0ViVSjfmazLWRKJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bivaAA6j; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759754349; x=1791290349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Mj6DyHT3p5mzeAzaSt+CxCS4GcrrIvBBI+kZriszA4=;
  b=bivaAA6jpt0kS2NFOZlva9PbkOKap3uxhoZWU84r/x/M3wRPI2F7M3oK
   hSk9SG7jl2lsYPvoNr8gKJoFCPsdbq0jGEEmWplPSyc8hS4n2/7dDCUCp
   uZixCA/wbEK5bnIK1PACnE6JRYtAFG6ivNUwKGRbVtJsy15azMhPSUR5y
   fdhG7UCKEXARiNkecWGmt/mi1mfFamwRWk7OSOGYW48Xwy4gCi7DUDv4J
   6wyuK2/5IAtI5zVDb0VN3JOIZUmlW1jcxoZjxfoFDwI2r4ytY5Rcb860q
   hwEOnv7tMUGRTbMKwHNvdTeWbooe0cwK2ZbYqgqQQWckRuFOMImwolDHr
   Q==;
X-CSE-ConnectionGUID: to7BJQWcQC6u5VydU6PuLg==
X-CSE-MsgGUID: p4V9+/vURF+S4NvZsXVZUg==
X-IronPort-AV: E=Sophos;i="6.18,319,1751241600"; 
   d="scan'208";a="4177632"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 12:39:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:8047]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.225:2525] with esmtp (Farcaster)
 id f1ee6362-a1f5-40f4-90a8-4d52248e5d16; Mon, 6 Oct 2025 12:39:08 +0000 (UTC)
X-Farcaster-Flow-ID: f1ee6362-a1f5-40f4-90a8-4d52248e5d16
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 12:39:07 +0000
Received: from b0be8375a521.amazon.com (10.37.244.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 12:39:05 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Auke Kok
	<auke-jan.h.kok@intel.com>, Jeff Garzik <jgarzik@redhat.com>, Sasha Neftin
	<sasha.neftin@intel.com>, Richard Cochran <richardcochran@gmail.com>, "Jacob
 Keller" <jacob.e.keller@intel.com>, <kohei.enju@gmail.com>, Kohei Enju
	<enjuk@amazon.com>
Subject: [PATCH iwl-net v1 3/3] ixgbe: use EOPNOTSUPP instead of ENOTSUPP in ixgbe_ptp_feature_enable()
Date: Mon, 6 Oct 2025 21:35:23 +0900
Message-ID: <20251006123741.43462-4-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251006123741.43462-1-enjuk@amazon.com>
References: <20251006123741.43462-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

When the requested PTP feature is not supported,
ixgbe_ptp_feature_enable() returns -ENOTSUPP, causing userland programs
to get "Unknown error 524".

Since EOPNOTSUPP should be used when error is propagated to userland,
return -EOPNOTSUPP instead of -ENOTSUPP.

Fixes: 3a6a4edaa592 ("ixgbe: Hardware Timestamping + PTP Hardware Clock (PHC)")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 114dd88fc71c..6885d2343c48 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -641,7 +641,7 @@ static int ixgbe_ptp_feature_enable(struct ptp_clock_info *ptp,
 	 * disabled
 	 */
 	if (rq->type != PTP_CLK_REQ_PPS || !adapter->ptp_setup_sdp)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (on)
 		adapter->flags2 |= IXGBE_FLAG2_PTP_PPS_ENABLED;
-- 
2.48.1


