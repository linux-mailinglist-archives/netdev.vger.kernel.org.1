Return-Path: <netdev+bounces-211701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77958B1B51B
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E60E3B8557
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C4274FE8;
	Tue,  5 Aug 2025 13:41:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from alt42.smtp-out.videotron.ca (alt42.smtp-out.videotron.ca [23.233.128.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45326CE12
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.233.128.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401288; cv=none; b=ggjPNDvUWc6P9LCeN9LzM273/YlsyRn/r4aygD9enKrFbPsTeghIE0Irk/+t/V+XqfGcn+AjNQKFhWzoylMzw2s43NbZt980vwYxITf8qiMRB/X9J1sQU6kYfMbXIpKhcI/gPGmqxFM2MrIDI9rOHG21Ro2/cJJoqRaTAWqJSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401288; c=relaxed/simple;
	bh=O7zxHYQBP4r1blYzmk5/ehXT3Nic071pBH3ClmJBZ+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a7goOd3RnYWfByyzQvZy/mzoTx8f60FsdTdUUXwd5bp5puZSbcPkIeAaHK6pSDpmpeDrISO2QGC4JHj9nIHjeHqHFbY225yYbskMP6W97ryUvC9B/jDfCpWAQBhpNt8dqF8K4I2usuxjn6hCuUei2vDmXrpL083AyBT7VBLUjHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; arc=none smtp.client-ip=23.233.128.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Received: from zappa.orion ([24.201.91.161])
	by Videotron with ESMTP
	id jHuluhl5MrTATjHulu2f37; Tue, 05 Aug 2025 09:41:18 -0400
X-ORIG-RCPT: davem@davemloft.net,edumazet@google.com,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,horms@kernel.org,kuba@kernel.org,andrew+netdev@lunn.ch,dhill@redhat.com,pabeni@redhat.com,netdev@vger.kernel.org
X-Authority-Analysis: v=2.4 cv=WMPcXWsR c=1 sm=1 tr=0 ts=689209fe
 a=OPdtphJVnnJ7kPN51veEEg==:117 a=OPdtphJVnnJ7kPN51veEEg==:17
 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=B84hUlnxZVGoqRvv9U4A:9
Received: from knox.orion (unknown [192.168.1.37])
	by zappa.orion (Postfix) with ESMTP id E2357A97;
	Tue, 05 Aug 2025 09:40:43 -0400 (EDT)
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
Subject: [PATCH 1/2] PATCH: i40e Improve trusted VF MAC addresses logging when limit is reached
Date: Tue,  5 Aug 2025 09:40:41 -0400
Message-ID: <20250805134042.2604897-1-dhill@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Binarystorm-MailScanner-Information: Please contact the ISP for more information
X-Binarystorm-MailScanner-ID: E2357A97.AFDD9
X-Binarystorm-MailScanner: Found to be clean
X-Binarystorm-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
	score=-0.01, required 7, ALL_TRUSTED -0.01)
X-Binarystorm-MailScanner-From: dhill@redhat.com
X-CMAE-Envelope: MS4xfI2B174Vqrt2hqKbThbc1lPzLyVuemsgDtQYiRSpe5hrSRI0kN5FuArtimkLhiqXZOQNHu8OHHT3Etc7/azVdmekrjdev8MEI0lB8R+hBH7Tj5UrCtUy
 RW4VQSWKUx3Isl/oDVGYkKq5gMEoc3rwQ5pmH6w8VIr1FfBzx8RfocvekWcSjqG80zMUmNrStGcpMu7xxAHlan6l1mSQ7i/nW0J0/cqwP5t92ioRRVJRrVCp
 SYVMpQDpv6WKf+VJla2Uk/h6nAfdLwR28/i+XrF/ReEabCUa4EKewrybrELyXlYfaagN7lGdGkEjYSSxcbuyIhSI5H1O9bJxfQ+J74nMGxGPNtORFE1FH+l6
 wppkmf0NNkO+5Z+3BhMZSpQ668pIjAPTarQH78y4ozH7jAVdKtfZ744LJTPhNbhxHhQ7ZfqVQ0IdvNrJBJPRtLdFkFrD/gYyN5vKDKIgeokM8G7p3Js=

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


