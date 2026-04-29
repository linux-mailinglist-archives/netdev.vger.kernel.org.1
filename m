Return-Path: <netdev+bounces-282514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEYxMgx+8mmmrwEAu9opvQ
	(envelope-from <netdev+bounces-282514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:54:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A34949ABD3
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C303301C90A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D1379EEC;
	Wed, 29 Apr 2026 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P67qq8Cr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6356E2749D6;
	Wed, 29 Apr 2026 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499656; cv=none; b=Mn9uyrii4e3KYQCmXdKcWeuO0toSPXvzA8aiPA2ZpOHqR2LUYUk3CM7gTyB48dZ9Yv4XIsLcTSxONPP0tjJYjUz9PLZtCJNLfA4OvEgWQYlo2/wrHOL2VIxaluU4sA33M+9y91Ku1T124/ASPRuDSV1pZc9iH27ayGID2DLf/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499656; c=relaxed/simple;
	bh=bsaeh1g7HsSHpY8faUX1qXJdUYghqfwLHKYIHWf7EhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EbLTCUi/6opObFDyh6mfxGYQdm4QJq4AZi3/Qfe0r9eIenBDZsSxgVdiQe/il6wSSA7a8MEad9/94e+FHESqp1+XVXgthCl+wyNFC4FOn7u/atGRmnUOVsVEIV8WftJyLkXV6UYwcgFbsQOfTQWpOYrx5tlJgr1RGBRTuNp/fh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P67qq8Cr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09690C19425;
	Wed, 29 Apr 2026 21:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777499656;
	bh=bsaeh1g7HsSHpY8faUX1qXJdUYghqfwLHKYIHWf7EhA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=P67qq8CrNASOVlJ/IGZeYFRD7MfpmPmUHDvighV+JwPHW4rWMvinatqhvKAxE3cIy
	 fJa2aL2a8xRM1dHyDecb5AHOKX5RD3s/9zkl5o1xCY++1Y/J2icOw42ZlfmMVOjP4j
	 3nwRXv+nd1osYWRey5EdFDSZstGJVUUW2Zg0Mpfgox7Jx2o8Lvk/pRRMPYdZ2SKw7I
	 noiqzd/ODc3mAaMrueClHL1eVepnz5K8cxmX9yWE49qfCLdr4KkCrEnNy8DEtKH9N6
	 lUyX84yPEfQeVL5L99Ix3xC7tGKg1yTsVdxzDvbcf2H7bnktKVmvLrxbks1o2OG9hx
	 60GRrNI/tMrcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6CFFF887E;
	Wed, 29 Apr 2026 21:54:15 +0000 (UTC)
From: Gregory Fuchedgi via B4 Relay <devnull+gfuchedgi.gmail.com@kernel.org>
Date: Wed, 29 Apr 2026 14:54:14 -0700
Subject: [PATCH] amd-xgbe: fix PTP addend overflow causing frozen clock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-fix-xgbe-ptp-addend-v1-1-fca5b0ca5e62@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAV+8mkC/x2MQQqAMAzAviI9W9AiU/yKeHBrnb3MsYkIsr87P
 AaSvJAlqWSYmxeS3Jr1DBX6tgF3bMELKlcG6sh0A02464OPt4LxirgxS2B0zva8GxoNEdQyJqn
 af13WUj5Pv04MZQAAAA==
To: Raju Rangoju <Raju.Rangoju@amd.com>, 
 Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gregory Fuchedgi <gfuchedgi@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777499655; l=2038;
 i=gfuchedgi@gmail.com; s=20250811; h=from:subject:message-id;
 bh=Cw28xQLOHUHtos1dic3d/FADE55TTbWnyZfMkX9S3cY=;
 b=2iJIHjvr4n+p0miuEdP5oBsAcJJ7E1suy1Np1mk0fMWu8OgBrHPkKGWiIbuPZbGQyBsxafxs9
 RedEe1CdjBlDAaLlrHQs+QG5qNwfNuHHt6DidbU9v0WFAbmQFq80VQF
X-Developer-Key: i=gfuchedgi@gmail.com; a=ed25519;
 pk=J3o48+1a2mUIebH8K4S3SPuR5bmamUvjlsf8onoIccA=
X-Endpoint-Received: by B4 Relay for gfuchedgi@gmail.com/20250811 with
 auth_id=484
X-Original-From: Gregory Fuchedgi <gfuchedgi@gmail.com>
Reply-To: gfuchedgi@gmail.com
X-Rspamd-Queue-Id: 4A34949ABD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282514-lists,netdev=lfdr.de,gfuchedgi.gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[amd.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[gfuchedgi@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.982];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Gregory Fuchedgi <gfuchedgi@gmail.com>

XGBE_PTP_ACT_CLK_FREQ and XGBE_V2_PTP_ACT_CLK_FREQ were 10x too
large (500MHz/1GHz instead of 50MHz/100MHz), causing the computed
addend to overflow the 32-bit tstamp_addend. In the general case
this would result in the clock advancing at the wrong rate. For v2
(PCI), ptpclk_rate is hardcoded to 125MHz, so the addend formula
(ACT_CLK_FREQ << 32) / ptpclk_rate yields exactly 8 * 2^32, and
when stored to the 32-bit tstamp_addend the value is zero. With
addend = 0 the hardware accumulator never overflows and the PTP
clock is fully stopped. For v1 (platform), ptpclk_rate is read from
ACPI/DT so the exact overflow behavior depends on the
firmware-reported frequency.

Define the constants as NSEC_PER_SEC / SSINC so the relationship is
explicit and cannot drift out of sync.

Fixes: fbd47be098b5 ("amd-xgbe: add hardware PTP timestamping support")
Tested-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
---
Tested by running ptp4l and verifying successful clock synchronization on v2
(PCI) hardware.
---
 drivers/net/ethernet/amd/xgbe/xgbe.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 60b7e53206d1..3d3b09010d48 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -135,11 +135,11 @@
  */
 #define XGBE_TSTAMP_SSINC	20
 #define XGBE_TSTAMP_SNSINC	0
-#define XGBE_PTP_ACT_CLK_FREQ	500000000
+#define XGBE_PTP_ACT_CLK_FREQ	(NSEC_PER_SEC / XGBE_TSTAMP_SSINC)
 
 #define XGBE_V2_TSTAMP_SSINC	0xA
 #define XGBE_V2_TSTAMP_SNSINC	0
-#define XGBE_V2_PTP_ACT_CLK_FREQ	1000000000
+#define XGBE_V2_PTP_ACT_CLK_FREQ	(NSEC_PER_SEC / XGBE_V2_TSTAMP_SSINC)
 
 /* Define maximum supported values */
 #define XGBE_MAX_PPS_OUT	4

---
base-commit: 0c7a5ba011d336df4fcd1f667fcc16ea5549be12
change-id: 20260428-fix-xgbe-ptp-addend-ccb1df627622

Best regards,
-- 
Gregory Fuchedgi <gfuchedgi@gmail.com>



