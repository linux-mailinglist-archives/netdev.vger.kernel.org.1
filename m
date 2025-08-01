Return-Path: <netdev+bounces-211359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319AAB1827F
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 15:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AFF586E9C
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7693B22759B;
	Fri,  1 Aug 2025 13:32:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from alt42.smtp-out.videotron.ca (alt42.smtp-out.videotron.ca [23.233.128.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0CF33D8
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.233.128.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055158; cv=none; b=EgEDYPx6I0KzVo9PHaAM41ulZE3DvEa5Ai6IBieakFvdV3ojM8MYf2motTdgeRwn+cepP5kKSOTFrWNiPDMdoIvh2QePTM3Cehtk7/3J3bDrZv3gxDnKDnwix4GaG3mCbi3rCrjLSq/2FRYq+itBnXif1OgnHXafapPd/PHx1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055158; c=relaxed/simple;
	bh=FhZoHEfxKzxylPJtES6oYDqZnyO9ZWHiN0t00emboHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OkBMo760qzpp7cQF1+ojkK9AxdGVZ+VBk6Q91CsVu1w9qwmz0rVHaDsbHXavLzl81iVjOsXtuWGBbqGbC64POXKwXqf2YtGpf18MCHVhfpFM9jQRB4PSqFbuNuDIuJuSDMtun+5mPfByzmXYYNXyL9SHQiQBcB9L2ZhMOM6wmRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; arc=none smtp.client-ip=23.233.128.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Received: from zappa.orion ([24.201.91.161])
	by Videotron with ESMTP
	id hpqZu9Bk9MJQQhpqZuv0wZ; Fri, 01 Aug 2025 09:30:58 -0400
X-ORIG-RCPT: davem@davemloft.net,edumazet@google.com,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,kuba@kernel.org,andrew+netdev@lunn.ch,dhill@redhat.com,pabeni@redhat.com,netdev@vger.kernel.org
X-Authority-Analysis: v=2.4 cv=CICJXgrD c=1 sm=1 tr=0 ts=688cc192
 a=OPdtphJVnnJ7kPN51veEEg==:117 a=OPdtphJVnnJ7kPN51veEEg==:17
 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=KgM5TV4k-OYgtHylTX4A:9
Received: from knox.orion (unknown [192.168.1.37])
	by zappa.orion (Postfix) with ESMTP id E21023FC;
	Fri, 01 Aug 2025 09:30:18 -0400 (EDT)
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
Date: Fri,  1 Aug 2025 09:30:17 -0400
Message-ID: <20250801133017.2107083-1-dhill@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Binarystorm-MailScanner-Information: Please contact the ISP for more information
X-Binarystorm-MailScanner-ID: E21023FC.A15A1
X-Binarystorm-MailScanner: Found to be clean
X-Binarystorm-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-0.01, required 7, ALL_TRUSTED -0.01)
X-Binarystorm-MailScanner-From: dhill@redhat.com
X-CMAE-Envelope: MS4xfCKvs5SDCQBQxFoP8Uvt8RWwsKLq+7bwhCzr79jgLIfGDWx1Ajp+Mc/ESgR+xBGrCRPV5Aqzl++ZTf1e5LsQ9fUrIBrPC7+CPKbwv3++alkmwziktFWR
 Ma/9PE3g0rxkkxz1P0hVJHCbeK0F0RBUIbr1bF0NUoUUQQTUAVN1jjGjAYfO2m6HGy+Z3NPSFVuY6AjRSml11qOG8Btq1gQXFDYSclKtEQmJencIr4sDV4yb
 JWWTwyg/4+A9KG4JprRpKLs7Ckfgv/JjqwBPlrsajCcgY52an0l0FOw+RDVvJQK4vEMI24rZ0Pi9ZfCFR4Pz71Ytj9GcB3e9F3fFgxH6UVlhh9LaaMfcG8e3
 SvBeATEK/9/2G6iQJlM3Y3Qm+wlr7R097pd2YYsW9T+kkNeStDIJMsATuwS92eFkpOLWg2gsN48IR+VFTibE84acUIiUbw==

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
index 9b8efdeafbcf..dc0e7a80d83a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2953,7 +2953,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		    I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
 						       hw->num_ports)) {
 			dev_err(&pf->pdev->dev,
-				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
+				"Cannot add more MAC addresses, trusted VF %d uses %d out of %d MAC addresses\n", vf->vf_id, i40e_count_filters(vsi) +
+          mac2add_cnt, I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,num_ports)));
 			return -EPERM;
 		}
 	}
-- 
2.50.1


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


