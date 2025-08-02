Return-Path: <netdev+bounces-211463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C19B18F14
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 16:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E87D1609FC
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6065E41C72;
	Sat,  2 Aug 2025 14:15:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from alt32.smtp-out.videotron.ca (alt32.smtp-out.videotron.ca [24.53.0.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE85C96
	for <netdev@vger.kernel.org>; Sat,  2 Aug 2025 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.53.0.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754144146; cv=none; b=KusQDpnvO7OPONsJon/HOKx1vYf9FiduUkOtbKhtuV1oivswMzozZB141mpSRhfpUo/p2gWPlz0k0oPclqqaG/4VHhHw/KuWTWU2kYW1RHquM0L1DgFqP4zYOsjoklR7WOuXCLIp63DhjaI+s09sbGw+Iv59c16fKgFYAfWGKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754144146; c=relaxed/simple;
	bh=GgqnLNRzhfR4Aalq/zIgg7bHTOTwMXGWl7svCv55p/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7j7a8ydxt9L18ZDltY/KpQo8yesQt6nmnd45nWrf/Lsop70glQ05KZTFKE4knA1EEcSBk8V5ZNcYm6EmdSmCdlAevarKJqqkkLTNhxWxyST7rJQOnVvIff6O9die2zr5kXBvR0xj4MZaWqlqfY+bhCTAdebPAhnBZAJVcqyP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; arc=none smtp.client-ip=24.53.0.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Received: from zappa.orion ([24.201.91.161])
	by Videotron with ESMTP
	id iCzquCSIaJQOJiCzquf9j8; Sat, 02 Aug 2025 10:14:06 -0400
X-ORIG-RCPT: davem@davemloft.net,edumazet@google.com,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,kuba@kernel.org,andrew+netdev@lunn.ch,dhill@redhat.com,pabeni@redhat.com,netdev@vger.kernel.org
X-Authority-Analysis: v=2.4 cv=YI08ygGx c=1 sm=1 tr=0 ts=688e1d2e
 a=OPdtphJVnnJ7kPN51veEEg==:117 a=OPdtphJVnnJ7kPN51veEEg==:17
 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=KgM5TV4k-OYgtHylTX4A:9
Received: from knox.orion (unknown [192.168.1.37])
	by zappa.orion (Postfix) with ESMTP id 68322D25;
	Sat, 02 Aug 2025 10:13:27 -0400 (EDT)
From: David Hill <dhill@redhat.com>
To: netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	David Hill <dhill@redhat.com>
Subject: [PATCH] PATCH: i40e Improve trusted VF MAC addresses logging when limit is reached
Date: Sat,  2 Aug 2025 10:13:22 -0400
Message-ID: <20250802141322.2216641-1-dhill@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Binarystorm-MailScanner-Information: Please contact the ISP for more information
X-Binarystorm-MailScanner-ID: 68322D25.AFC28
X-Binarystorm-MailScanner: Found to be clean
X-Binarystorm-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-0.01, required 7, ALL_TRUSTED -0.01)
X-Binarystorm-MailScanner-From: dhill@redhat.com
X-CMAE-Envelope: MS4xfOJtXWZXz0kC1iBmGNYDsC19QtdMogqrvZG1jltGeneNi8XgdfcUG4mXBQYlRpleFdwOf+Sl+5jwAcyeIofaxKTfKfMUbQNAtUtU6krOLIm6nsbsQMtQ
 9eh9034/79TWKI9r8XLallaBTEkU6Q2j5G68CKqee4M3UF5QrdM36/VoWQbRSelc3OQYcSXl3DaYWth8ScuqOSvEolGE6RDkP0WOxyY1kAfMu3ZIo7xAQfGH
 /K77Oi5ThVXtODoAsTG7ipZlL8V5FnVj1ypvAh83EbL2YjSXwUxfow965Re3N9voEoOc6N82QiuP2//8V1GW8nD6CECmLOGzL22uyuKpzTrbaE5O9dK3usAC
 MbCflbCkilTLhY5IlovOeMPRGC3/a1gENLbwKUYbxRpek7QcHKZ3UsWuAVrtWRlhZUDrsQzPyQxZm+kMRfIAHyXX8zE+IQ==

When a VF reaches the limit introduced in this commit [1], the host reports
an error in the syslog but doesn't mention which VF reached its limit and
what the limit is actually is which makes troubleshooting of networking
issue a bit tedious.   This commit simply improves this error reporting
by adding which VF number has reached a limit and what that limit is.

Signed-off-by: David Hill <dhill@redhat.com>

[1] commit cfb1d572c986a39fd288f48a6305d81e6f8d04a3
Author: Karen Sornek <karen.sornek@intel.com>
Date:   Thu Jun 17 09:19:26 2021 +0200
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 9b8efdeafbcf..44e3e75e8fb0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2953,7 +2953,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		    I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
 						       hw->num_ports)) {
 			dev_err(&pf->pdev->dev,
-				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
+				"Cannot add more MAC addresses, trusted VF %d uses %d out of %d MAC addresses\n", vf->vf_id, i40e_count_filters(vsi) +
+          mac2add_cnt, I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,hw->num_ports));
 			return -EPERM;
 		}
 	}
-- 
2.50.1


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


