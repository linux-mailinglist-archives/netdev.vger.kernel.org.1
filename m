Return-Path: <netdev+bounces-211698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA51EB1B4E0
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8229A1891ECF
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC50E246BB6;
	Tue,  5 Aug 2025 13:27:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from alt22.smtp-out.videotron.ca (alt22.smtp-out.videotron.ca [70.80.0.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3237D15C15F
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=70.80.0.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400440; cv=none; b=cZoF3rSfWzaZKne07xF4x/3rQqv/lSUyibSB9vMmL6U/aVQ9nDbaR0kW39W2QmccMR4YXWbKHjWY0rcqFjxAPem6fWVDG/OmWKZiqufZTOYz4/vmHmypnTFFhAOF9L3RI8eUS8TVScKSkq7aL/BX6mc4nzzheFvB6ffc1YUhdxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400440; c=relaxed/simple;
	bh=O7zxHYQBP4r1blYzmk5/ehXT3Nic071pBH3ClmJBZ+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gmsq4oUvmR7E/zsUQdJcRuUUduhI45S3v6zjZ8midBNTd95ja+BBO64WZIr23MN7nQEN4v8AYTPKnmhZOtBSRlazC1XOWiJ4ZACBKj7JwHuNbaDTVec3QKAjxbDbAY6PlANmSQravV6fc6ExZbiSkz3y0zAbXK8DpMI2w9nqjbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; arc=none smtp.client-ip=70.80.0.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Received: from zappa.orion ([24.201.91.161])
	by Videotron with ESMTP
	id jHfeuqfDX0d8ejHfeuHuwm; Tue, 05 Aug 2025 09:25:41 -0400
X-ORIG-RCPT: davem@davemloft.net,edumazet@google.com,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,horms@kernel.org,kuba@kernel.org,andrew+netdev@lunn.ch,dhill@redhat.com,pabeni@redhat.com,netdev@vger.kernel.org
X-Authority-Analysis: v=2.4 cv=I/zGR8gg c=1 sm=1 tr=0 ts=68920655
 a=OPdtphJVnnJ7kPN51veEEg==:117 a=OPdtphJVnnJ7kPN51veEEg==:17
 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=B84hUlnxZVGoqRvv9U4A:9
Received: from knox.orion (unknown [192.168.1.37])
	by zappa.orion (Postfix) with ESMTP id 224071036;
	Tue, 05 Aug 2025 09:25:05 -0400 (EDT)
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
Subject: [PATCH] PATCH: i40e Improve trusted VF MAC addresses logging when limit is reached
Date: Tue,  5 Aug 2025 09:25:02 -0400
Message-ID: <20250805132502.2602549-1-dhill@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Binarystorm-MailScanner-Information: Please contact the ISP for more information
X-Binarystorm-MailScanner-ID: 224071036.AC969
X-Binarystorm-MailScanner: Found to be clean
X-Binarystorm-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-0.01, required 7, ALL_TRUSTED -0.01)
X-Binarystorm-MailScanner-From: dhill@redhat.com
X-CMAE-Envelope: MS4xfFeWlbpwk7R9Vnw7LBlxDI/2EMTSC54CC8fybPDAyOWdb6IrhM5GKCbK0DyEykmRgpL2geZmV/nlAxVMC0InVU9iH5haZETbUzPX9qtb0qXBCL8NocR0
 3KXtuMrVgvt+/JK+y3KPI/we/u/vNiRMlFLuQk6NXbhElFM/bRjGcQ/JFe340zxwZQG+8Trdu6D4RAhupQhZ2kdIRXdsv4pwQzjl0A+fNC1bafyjqYbySz2K
 uZ4DLgCc8Np60EIsFS77vINxFbnGvI1PLxNDkg37CeOIqRDLYm+I3anZ0tHS9a4ABn95CJ5kgCgg6PLG/duV4sbzKJx96B1kEMiUvLjQT3JFMhmhPdDSkt3C
 9t87Cv2C1Fkm5wg5xLdRFKOW/ajXztvWad668AkR6drpQZSwgOBxduMbTGEfF0zDrTAYKWbJRhTgReYGSsdzvhq9UaDMCPQUrXtBgSlycvwwQXWCimA=

When a VF reaches the limit introduced in this commit [1], the host reports
an error in the syslog but doesn't mention which VF reached its limit and
what the limit is actually is which makes troubleshooting of networking
issue a bit tedious.   This commit simply improves this error reporting
by adding which VF number has reached a limit and what that limit is.

[1] commit cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every
trusted VF")

Signed-off-by: David Hill <dhill@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 9b8efdeafbcf..c66c8bbc3993 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2932,13 +2932,14 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 			++mac2add_cnt;
 	}
 
+	int new_count = i40e_count_filters(vsi) + mac2add_cnt;
+	int max_macvlan = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);
 	/* If this VF is not privileged, then we can't add more than a limited
 	 * number of addresses. Check to make sure that the additions do not
 	 * push us over the limit.
 	 */
 	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
-		if ((i40e_count_filters(vsi) + mac2add_cnt) >
-		    I40E_VC_MAX_MAC_ADDR_PER_VF) {
+		if ( new_count > I40E_VC_MAX_MAC_ADDR_PER_VF) {
 			dev_err(&pf->pdev->dev,
 				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
 			return -EPERM;
@@ -2949,11 +2950,10 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 	 * all VFs.
 	 */
 	} else {
-		if ((i40e_count_filters(vsi) + mac2add_cnt) >
-		    I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
-						       hw->num_ports)) {
+		if (new_count > max_macvlan) {
 			dev_err(&pf->pdev->dev,
-				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
+				"Cannot add more MAC addresses, trusted VF %d uses (%d/%d) MAC addresses\n",
+				vf->vf_id, new_count, max_macvlan);
 			return -EPERM;
 		}
 	}
-- 
2.50.1


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


