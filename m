Return-Path: <netdev+bounces-205880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0507DB00A08
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642FB5A64E4
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0435D284669;
	Thu, 10 Jul 2025 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MVBf/IEN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5373112B71;
	Thu, 10 Jul 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169175; cv=none; b=jyHefC7LBNLDTQD6GB9sQLxhjuDvQWA9xR+c5Ho0YULSOm3VDQUlWAEuFZ8DXIk9NLnWJVIQ7gtO70nEtVtgEZkUmcuaqIfYEHO6M49Dz3Ul54wYcA4fv3ZI9DIac2BfVv164ZfxnxUc6sI+wS7xkroiWSsweJL7ymckxnYfl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169175; c=relaxed/simple;
	bh=zLub8N//C+GGcogUcLGBKxJjGKX4CYLw9ra/Jl4VpzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=px61i3I47abYS/B3fUXEyLu9l4SCitfZ34nuo+tY9pHziD5A1Z5mmxKkZuDgZn8t4LAd1EqYgA24LcfFq/w5b/x0vaZw3bu1aqmsFfLky0nb5I0cj6BruAJXGDnkg/ygd+3wBve1HCDdnPR/IUb79dn+x2kSf6epNXBFeSdCudg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MVBf/IEN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AHYxFm008594;
	Thu, 10 Jul 2025 17:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=c8FeSJ9m13CyoarXH4iTrYZVBXZu3
	gJ4ofG/36xGTbU=; b=MVBf/IENqHqT0eCGYLzf+aow/dkLl2x/0UpAjSFMQEayf
	5b3fs6tzYjgxR7bRuqfenEz0/zcqc+0ZD18BcbuIF6bHOjMJNK0GwMG9uWqgQy9L
	y1+73aeW8Gogih3GExXJ5JmnDYXoSQYudXxWnG5aQjMwHybGx71preSq4gmRMH8x
	AZY8VhjE0QW+7XNW3+uFxsRUcrNtSetkaMsoKdC6oKCa4YcZjD3/7rsy4u8sTnQ0
	xzuIiVBCEVhRodVtDpyt0wxzdCLcN54TmQTDm4OVhm1R8ud2flXdwcfa3T6IT9qK
	FjH104KFKeS4KW0e0J5YSigJIqHuu8pB2zCRXnv0Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47thb884gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 17:39:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AG02XZ024219;
	Thu, 10 Jul 2025 17:39:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgctvwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 17:39:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56AHbwtn003025;
	Thu, 10 Jul 2025 17:39:19 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ptgctvv7-1;
	Thu, 10 Jul 2025 17:39:19 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: abin.joseph@amd.com, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, darren.kenny@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: emaclite: Fix missing pointer increment in aligned_read()
Date: Thu, 10 Jul 2025 10:38:46 -0700
Message-ID: <20250710173849.2381003-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100150
X-Proofpoint-GUID: 5k9rPI_JtGZ6kdUU9BmPnape8Ja8n8aB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE1MCBTYWx0ZWRfX7DTJhPPI5/tw W9W/UlUKHqCUvjRlBAla9Rqn6sZLYF1V0GdLUrr5VFTyDeO5bxrJyTE+Bsz7ksoLmgR/ox5HEQr +N6Kmd0LStUwtYQAZNUVB+0VXS8oLgcSiWDCAVsyCzDVuMYqDSc6Gbv2BraXruovJVrXa1sGclu
 TKUS2Tuc6YZbh7q2DTeN1kiXjPY17IjFtZwiY69FSkAEuAX3pSro8o0oAe3tWzjPfBvH3eLZbRr besFlLznpphU//ar+/7vQBxXexHW4GTADoEkf5aJVz6uT4WIJeXuFJb/hQ09HG6JdNyVPEKBFm/ QmH/+ifoQLHjzIIQqiyA96Ndz4c3cSDyAjQriPaCa7137cSgKPY7900uGD/8zWE0UbZhjuSj/tT
 Vsy5aDLlfST2Rvk+zcTSI/KSefqHOAb2Ff63Pv9wJuhSggwKx/JuEIP8Caa1nfVppEMYle7+
X-Authority-Analysis: v=2.4 cv=U9iSDfru c=1 sm=1 tr=0 ts=686ffac9 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=GbX1-k0q0cNaDmerjHAA:9
X-Proofpoint-ORIG-GUID: 5k9rPI_JtGZ6kdUU9BmPnape8Ja8n8aB

Add missing post-increment operators for byte pointers in the
loop that copies remaining bytes in xemaclite_aligned_read().
Without the increment, the same byte was written repeatedly
to the destination.
This update aligns with xemaclite_aligned_write()

Fixes: bb81b2ddfa19 ("net: add Xilinx emac lite device driver")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index ecf47107146dc..4719d40a63ba3 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -286,7 +286,7 @@ static void xemaclite_aligned_read(u32 *src_ptr, u8 *dest_ptr,
 
 		/* Read the remaining data */
 		for (; length > 0; length--)
-			*to_u8_ptr = *from_u8_ptr;
+			*to_u8_ptr++ = *from_u8_ptr++;
 	}
 }
 
-- 
2.46.0


