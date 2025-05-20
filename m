Return-Path: <netdev+bounces-191746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B65FEABD083
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E495C1B63923
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990225D535;
	Tue, 20 May 2025 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UlM1NZ4q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74B25D1E9;
	Tue, 20 May 2025 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747726559; cv=none; b=WJXa9/ckZdHE5Kp/yQsXMeWsb2zWmc4i7izvk4YfIKY83JnuZ/wCFn3QbZxjLEONQth2mj2RHwBuuDb56WIYTDQTWb9oGghLUL36s2v39fhrZdB62whZeP1mh+EkYkBlD1GnMJDKpARyfRcMyelmhEPY95SSFKfhicWoYP6NY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747726559; c=relaxed/simple;
	bh=8b8jRm/hMR0lYCWgz/NyIci8Ed/fqS3mheFPeywVdS4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j4h7GSYRs/SHUp7IvSyjOgsHKQM0rOCWKiCjPb+/G6z6jiu00Ar7QW4sJNnwM51cUC3GZklStOJ+9/3KXEosBu1dJ0gh/ERB6C4lYNhsU2QR3baTpO0isroRlDP9lO28fkNmeBKhz6ST60ZlSx/YCvvcJW6MIrrT1yHHYZMvABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UlM1NZ4q; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JM3nUW010827;
	Tue, 20 May 2025 00:35:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=iovtrQ4hy+FP1s1iBdQc+Kp
	0xTG731YDxr2HDQ4/40s=; b=UlM1NZ4quhcN9U9Jt/rEwpcI0oKD0HDVSmGkKVQ
	dQCPllxBr7K+9G3PkHlm9Pxnk+Wwyl5Cpc7Vo5ye+0dfQIEKRCwPXGEQhE9jOxBZ
	/NRJttKw5MCIgAPfjht4Lsio3pP7aUBzMav9JHZGroyq3eHrd+EoLmUTeZSEyGo3
	yvHQPwSVgXbqEzbiHZbi+qEo0K9cWXbeK5vqoMULfTx8C45CuH1vC+ZYUPommpmb
	mN8f3mRT7lIglSExgMtgnpzBn0FM00d9BP7DG2fUo1B5pyvaFi34vF7wvDl8XKRp
	kSuy1AZyH+S9/LycOYZYobOANAJehcd+pcsPGpUegc2P97A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46rd3u0ujx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 00:35:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 20 May 2025 00:35:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 20 May 2025 00:35:36 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 4E5C43F7055;
	Tue, 20 May 2025 00:35:32 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: [net] octeontx2-pf: QOS: Fix HTB queue deletion on reboot
Date: Tue, 20 May 2025 13:05:23 +0530
Message-ID: <20250520073523.1095939-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: gesUmRLYVoplpJLFvCSKFEKfsrP0dXb4
X-Proofpoint-ORIG-GUID: gesUmRLYVoplpJLFvCSKFEKfsrP0dXb4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA2MSBTYWx0ZWRfX/tAs70h8GG5M ewHynREH6LHrNbqOrKoxAfnN5sFzeIyT1V56tDjxCCdBt1jvYehZjqU2P0r7Ydn4wd+isL+Gp9N RJ9BOFgbI743wIWfdciYMM9BqZj2QaWYnAkZmai6bjqDRAf8jzDpZdwfIXclnWcCWsleBRlS2Mk
 i6igluCeo394FroB2QnEXUUkoJvoCbOYvF/sdNOZ7cV0MvKlAhelEkP6KA6mMJasnzKOSgGeSJ+ fI/ROZGQaigQaEwn4Fj32sCT91qXxfgRwtv58JD2A5+5gZT4rYiBm/kSI31ggRx0qGkd7yrP0F3 aBGQwE5ZkJQdrINKVWNo0ZHH/IBBb6jr+j/0dhp9S1pEBRJd1ShleG2jcPcEckAOSqa0T09zQm6
 QoF/wqwKVOfWPMKf6a6MKBUfySsDsy6jMUvOMmPblTdNvZiGGm42t6ik6rBGV9XSZt+oIVlk
X-Authority-Analysis: v=2.4 cv=f7NIBPyM c=1 sm=1 tr=0 ts=682c30c9 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=e9Hc4YhzQbOalJZutbUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_03,2025-05-16_03,2025-03-28_01

During a system reboot, the interface receives TC_HTB_LEAF_DEL
and TC_HTB_LEAF_DEL_LAST callbacks to delete its HTB queues.
In the case of TC_HTB_LEAF_DEL_LAST, although the same send queue
is reassigned to the parent, the current logic still attempts to update
the real number of queues, leadning to below warnings

        New queues can't be registered after device unregistration.
        WARNING: CPU: 0 PID: 6475 at net/core/net-sysfs.c:1714
        netdev_queue_update_kobjects+0x1e4/0x200

Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 35acc07bd964..5765bac119f0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -1638,6 +1638,7 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
 	if (!node->is_static)
 		dwrr_del_node = true;
 
+	WRITE_ONCE(node->qid, OTX2_QOS_QID_INNER);
 	/* destroy the leaf node */
 	otx2_qos_disable_sq(pfvf, qid);
 	otx2_qos_destroy_node(pfvf, node);
@@ -1682,9 +1683,6 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
 	}
 	kfree(new_cfg);
 
-	/* update tx_real_queues */
-	otx2_qos_update_tx_netdev_queues(pfvf);
-
 	return 0;
 }
 
-- 
2.34.1


