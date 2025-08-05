Return-Path: <netdev+bounces-211697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE2AB1B4D8
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1741887BC4
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B1D275113;
	Tue,  5 Aug 2025 13:24:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from alt12.smtp-out.videotron.ca (alt12.smtp-out.videotron.ca [135.19.0.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395B72750E3
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.19.0.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400253; cv=none; b=LeCb+vz6MSYr8WeI3WnKtaenjCcPdpm56WMNuwAfR0E4M/vuolBs+4wHKzdxnj/dVbMWORCPmShSK0KXDpdApnJ3GiG6Z4S8oIPZottbp56gleS2Gd+eeQssuplojroZDFtU/+GO0iAEQnPEbRYkYZK/lywFahbNCRm3oEHANjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400253; c=relaxed/simple;
	bh=g+m/Uo0DITnACavjUWGJ8scSwkJC1S4pNHPbGcI27WU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJYXtQ/nSwRZvQsQM5G/4bYbtr8pKdnjksuUkWY4LD0rfQSRvjQ94p6VfeMdNmwQk30OIWyQBqZfkhQBTP2zOaLtcQicgbvdRKWm65S2oEE8Y99lbQVLL76Ss5YfOCokdoGA1J6BkziQIU2gJP2DpERrDkIA2XSrAdOYNRUvCt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; arc=none smtp.client-ip=135.19.0.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Received: from zappa.orion ([24.201.91.161])
	by Videotron with ESMTP
	id jHcbuxpWVQQxnjHcbufsGB; Tue, 05 Aug 2025 09:22:33 -0400
X-ORIG-RCPT: davem@davemloft.net,edumazet@google.com,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,horms@kernel.org,kuba@kernel.org,andrew+netdev@lunn.ch,dhill@redhat.com,pabeni@redhat.com,netdev@vger.kernel.org
X-Authority-Analysis: v=2.4 cv=CpwccW4D c=1 sm=1 tr=0 ts=68920599
 a=OPdtphJVnnJ7kPN51veEEg==:117 a=OPdtphJVnnJ7kPN51veEEg==:17
 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=B84hUlnxZVGoqRvv9U4A:9
Received: from knox.orion (unknown [192.168.1.37])
	by zappa.orion (Postfix) with ESMTP id A52EACEE;
	Tue, 05 Aug 2025 09:21:52 -0400 (EDT)
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
Date: Tue,  5 Aug 2025 09:21:49 -0400
Message-ID: <20250805132149.2601995-1-dhill@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Binarystorm-MailScanner-Information: Please contact the ISP for more information
X-Binarystorm-MailScanner-ID: A52EACEE.A2EA8
X-Binarystorm-MailScanner: Found to be clean
X-Binarystorm-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-0.01, required 7, ALL_TRUSTED -0.01)
X-Binarystorm-MailScanner-From: dhill@redhat.com
X-CMAE-Envelope: MS4xfC3RC9UUwsuJaHoCQVS6+5sVOvmuiuFLlIPVF1ev8DXT0mTDKPdwwUFZOB/QrvjmUtQhUXsUHjXBhQ3Je786g3c5WfL/xhCqx+aNzCBHjrFn+tUAWXtk
 bv7K9Bk8Gr1ypYFObVR8Qs8bHLBq0LBsf+ZOky2VJ7bgvMNrL+HyP+khmyaXjScRYdkQU2cq8N01+r+T95xrS6vtnZIuRAfLcvZxmcqP9wxxPcHFcVLETENe
 FuilqTj/iHnfYesMT1bcXUvLP85AuN1JjFrva0kV7NSjXAsapZEiOs5W2hQABt2WNZ2n2n0xQVuXS7JqG4w1EcneIAJkdx54EAgChsSiMzOvFaihix7MK5yJ
 bVYKLqV1aQwWVvoxg+Wq2ZdwKwWS9EEOGRjOkHjQhO0gMRlNxXWHkaABdOiwd90Izi7e1oSzjIn76BoOxRLGdNl0VWRnU4mgNdrkqcSXuuyse3DRdPs=

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
index 9b8efdeafbcf..eb587e2bb35f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2911,6 +2911,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 			return -EINVAL;
 		}
 
+		int new_count = i40e_count_filters(vsi) + mac2add_cnt;
+		int max_macvlan = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);
 		/* If the host VMM administrator has set the VF MAC address
 		 * administratively via the ndo_set_vf_mac command then deny
 		 * permission to the VF to add or delete unicast MAC addresses.
@@ -2937,8 +2939,7 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
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


