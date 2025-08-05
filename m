Return-Path: <netdev+bounces-211702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AB2B1B51C
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B75962291B
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD8A27510D;
	Tue,  5 Aug 2025 13:41:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from alt12.smtp-out.videotron.ca (alt12.smtp-out.videotron.ca [135.19.0.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83691274658
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.19.0.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401288; cv=none; b=E4F/Lqj8V6/YHr45qrfAxKUVLtMwd/E218Cb2mUr1Rcw+R+Hyo+4v9nDiHAsawzsGR32HV7P6m6uPc8s2nlqKftelQfAjb/FFMPiF2uvruYLR6v1i8cBT3T9w+wSHhpBw+TZ5SPhBbKFMjuv3hUXZpn6xgIGO6pKVszYf3Uyw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401288; c=relaxed/simple;
	bh=F9tcQjwEt/W15+T72cIlqFpsrTG7SV0JZM918Mn0ZBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvS/sux5HfRUosHNNl9L5cl5+Jr/wMKpSnYMhzECrKihbqZw/8MrJmnP3I50nKZZRWnmvP6Shv8+uiEG6+fH7Kg/wPeeMfyFXSh7c8EAG94r9Am0ilhBX2o+Kkq0+kgqTEN5W7td8vD6sMBGtZA/mRCenYdSdpXjV8moUMM5Suo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; arc=none smtp.client-ip=135.19.0.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Received: from zappa.orion ([24.201.91.161])
	by Videotron with ESMTP
	id jHuruxrfKQQxnjHusuft1t; Tue, 05 Aug 2025 09:41:25 -0400
X-ORIG-RCPT: davem@davemloft.net,edumazet@google.com,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,horms@kernel.org,kuba@kernel.org,andrew+netdev@lunn.ch,dhill@redhat.com,pabeni@redhat.com,netdev@vger.kernel.org
X-Authority-Analysis: v=2.4 cv=CpwccW4D c=1 sm=1 tr=0 ts=68920a05
 a=OPdtphJVnnJ7kPN51veEEg==:117 a=OPdtphJVnnJ7kPN51veEEg==:17
 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=TPf_-WkaaP5K8a5Ti-kA:9
Received: from knox.orion (unknown [192.168.1.37])
	by zappa.orion (Postfix) with ESMTP id F033D1132;
	Tue, 05 Aug 2025 09:40:45 -0400 (EDT)
From: David Hill <dhill@redhat.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	David Hill <dhill@redhat.com>
Subject: [PATCH 2/2] PATCH: i40e Add module option to disable max VF limit
Date: Tue,  5 Aug 2025 09:40:42 -0400
Message-ID: <20250805134042.2604897-2-dhill@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250805134042.2604897-1-dhill@redhat.com>
References: <20250805134042.2604897-1-dhill@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Binarystorm-MailScanner-Information: Please contact the ISP for more information
X-Binarystorm-MailScanner-ID: F033D1132.A0518
X-Binarystorm-MailScanner: Found to be clean
X-Binarystorm-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-0.01, required 7, ALL_TRUSTED -0.01)
X-Binarystorm-MailScanner-From: dhill@redhat.com
X-CMAE-Envelope: MS4xfHvmsiVNkZFfBM7uVYjYJmmt7Dagx5uf6yO0Bh753kBjLJB7GTk58X/9cScqrDA9UyoyOr7+7UZCOtdZzgcaEtpktNxXMjbrRvJHIo27iM0EA3cDNG4D
 xolHayRvYcdoazUeFEUw6XONwmd5FMK9ag3PkQ3biQoafGEb3mbAhTB5gNX1PynREY7gUJd/LxnuvjtmJrRFWJYJtvlFUJikNCaRK2hzrvWQoURiJQfXaWYB
 FCK0V1fH4zhiD+dVLLXWZX8iXsW3bVKcqMjxRJXs+Z9MOAxMPu2nNlnz9FazKlQ0fUHQ2lC6EJ9XYTchh/bQ7S82wil/BRdG/yBO2OXdAmxWT8odwYsc7alY
 kmgj+VNlT8Ias8kim0ay6Ovo924koyzRsNVyLE9ku+cWpflFBWB7guzS2IiiDau69xX86Slz8rTGXgwiIeSf6Y/RXBpn8bckE7ujIhvTKnPi8opKlws=

When a VF reaches the limit introduced in this commit [1], the driver
refuses to add any more MACs to the filter which changes the behavior
from previous releases and might break some NFVs which sometimes add
more VFs than the hardcoded limit of 18 and variable limit depending
on the number of VFs created on a given PF.   Disabling limit_mac_per_vf
would revert to previous behavior.

[1] commit cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every
trusted VF")

Signed-off-by: David Hill <dhill@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index c66c8bbc3993..fb9eb4a80069 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4,6 +4,10 @@
 #include "i40e.h"
 #include "i40e_lan_hmc.h"
 #include "i40e_virtchnl_pf.h"
+#include <linux/moduleparam.h>
+
+bool __read_mostly limit_mac_per_vf = 1;
+module_param_named(limit_mac_per_vf, limit_mac_per_vf, bool, 0444);
 
 /*********************notification routines***********************/
 
@@ -2950,7 +2954,7 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 	 * all VFs.
 	 */
 	} else {
-		if (new_count > max_macvlan) {
+		if (new_count > max_macvlan && limit_mac_per_vf) {
 			dev_err(&pf->pdev->dev,
 				"Cannot add more MAC addresses, trusted VF %d uses (%d/%d) MAC addresses\n",
 				vf->vf_id, new_count, max_macvlan);
-- 
2.50.1


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


