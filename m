Return-Path: <netdev+bounces-238716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 890E6C5E7BD
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0AF73A0A8B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5169D32D7DB;
	Fri, 14 Nov 2025 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j8UpDDNZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE032D449;
	Fri, 14 Nov 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136219; cv=none; b=IlF880fYH63aSgwEtin9erpbTEVkeCxCT3C8EYuAEFNNOzXrPn2OTCAkKYY6Xhs2qsB4X6qLacjAtINOWjljcmPdHNnSlB7WdlIYbWCc3y0ElLV+GK0Yw1wJyJ1MUMz4c5N32Ujoc186e91AMkM+lCMiyXXw/Uk40axsyk4FoBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136219; c=relaxed/simple;
	bh=UQvfqMIxn+7USSiP0F4nA0IVKN2RF+Ag4N9jiQjtM9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAqTiLWyt/VUT8nzgldwgHDiE2srzifVYgeWXn41dbRr9Mz5Jlb22wq3aX1ySAt+ZnLmh84zuylWEUrbsDByowiVfWuF1UQINJpOKmONBwsa5h3Vifet1/yw3Beva06b0vE6eUDEALFTB75iNCTtfIRqTenQvB3IrU+7++cATnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j8UpDDNZ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECv49t001403;
	Fri, 14 Nov 2025 16:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=7KBzqYMar8raGBq7LNnXBQEaX4aZg
	mfqEFaee1HkP1E=; b=j8UpDDNZ5kEeIq5rUuBeGby6b1wCNOurvgomGcEig/1mS
	9C978H3HfKuQYrfafb+sDcVaMEr5nBrbLJaYts3Y0+4Qdg6avSYgiWQ4gnlUYfGk
	IF9S4DoVurTJjZmRAFGxrcG3Mp4MWHpp2urgnN/b12oLze/OqtwJxf7rQ47nrNGh
	SqWg4DoysO6pjPR/DSW21bcqrrf+0OqMvy3tMMamQ6wgk9pDlyTEYxaJ5YbN9t+W
	IN4lcWmgsPi89Ms1sJcCU4BZiopMutOL1JXjdpVLWSAdKIXjxcz52jShdMVBK+ut
	7jtwQ1v0hNC6HpqD5t/SH1l+8BuEcEjGNrKvcz3oQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8s9edn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 16:03:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEEFS15022034;
	Fri, 14 Nov 2025 16:03:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vadpv3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 16:03:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AEG3IZB029266;
	Fri, 14 Nov 2025 16:03:18 GMT
Received: from oracle (dhcp-10-154-173-166.vpn.oracle.com [10.154.173.166])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vadpv0s-1;
	Fri, 14 Nov 2025 16:03:18 +0000
From: gregory.herrero@oracle.com
To: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
        przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregory Herrero <gregory.herrero@oracle.com>
Subject: [PATCH v3 0/1] i40e: additional safety check
Date: Fri, 14 Nov 2025 17:03:03 +0100
Message-ID: <20251114160304.2576306-1-gregory.herrero@oracle.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511140129
X-Authority-Analysis: v=2.4 cv=VqQuwu2n c=1 sm=1 tr=0 ts=691752c8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=9rXuIt3xGVaoFKTACzIA:9
X-Proofpoint-ORIG-GUID: vU9oM9JmRxHYy9ZW7VZbdLPD5efe2-wm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX2uMUE8vU6QV5
 i66lk5VJa8+3tuHNR1Xi599A0zy3PId/Kjp3pVY4X9KleMk/1EiEJ4deidUe3VtY0Cn3bsXhzwd
 3plo10r7ZLDrrH3jsZmMlFwrfDWxcnJQsJRwzd6gJo/fArDEKhSwCkuB359HFuDybWfJfkVnGoX
 83FHnkBnfskpVBb8TohlX4Mwwuj8yGlvlcEA25Elbo8LEaXi0AlbAcIYZDuEeVjvtb4UDM+lnx5
 fYUskLrjwdJbGyq51/6aFw6I9MgOl/tarK7UOtSFubglzTqMOdBsG5Vvh/Fc8Hbzhy6XXpJgU6R
 pDDP4JnkEP1Imi24eACDbxQ9UvG9PkLNPEo/UPd8xgf2vT2Ccky0eoJc9/S3pdz8G2Uk4wLmwF9
 OChzwnnyugfPPO4wa1rETR0kglikPQ==
X-Proofpoint-GUID: vU9oM9JmRxHYy9ZW7VZbdLPD5efe2-wm

From: Gregory Herrero <gregory.herrero@oracle.com>

On code inspection, I realized we may want to check ring_len parameter
against hardware specific values in i40e_config_vsi_tx_queue() and
i40e_config_vsi_rx_queue().

v3:
- drop trailing period from the subject
- reword commit description
- remove u32 cast in i40e_config_vsi_rx_queue()
v2:
- make i40e_get_max_num_descriptors() 'pf' argument const.
- reword i40e_get_max_num_descriptors() description.
- modify commit description to explain potential behavior change.

Gregory Herrero (1):
  i40e: validate ring_len parameter against hardware-specific values

 drivers/net/ethernet/intel/i40e/i40e.h          | 17 +++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c  | 12 ------------
 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c  |  4 ++--
 3 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.51.0


