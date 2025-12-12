Return-Path: <netdev+bounces-244564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CF6CB9D9A
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 22:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAAC9305FAA3
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 21:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5F22FFFB9;
	Fri, 12 Dec 2025 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gn7LRjDT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015577262F;
	Fri, 12 Dec 2025 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573631; cv=none; b=VrE+OWzWVNmOcQftX/5ZJ4YiPL0ACtyLMgH7vuQbJGjvdM9EnK4IuR4ay1F4Vkz7d68MIxkCJxpk8Mg4MEKYTE6poiXb+XGvsYk/8/Fd/Lo1Ew5KFXOwp8AdKK0b48d19XhdjFtndOhC2hdHoDUjq9hyNIoQ9gNmYZLQegJsx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573631; c=relaxed/simple;
	bh=x6TGV0ofNp6QLey7TSuZCPJzqXH1o0W0zkmX6vsMzMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fw2Wdku4Uq0N5T2ZfiTalrTZDo81jeEE8+F9+usTRB7ctgOBQEdms/SD+rNJ78cAgyuhJ+V3ICyitNKpPIs2AcaSbNu/56bgXg+Lt8DPizWPx2Ge3GxTjuLG7ZAgJ5MFI79/b/KZq/+U8TrVup49Ty6XBHkM4FmgazsPifVFSho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gn7LRjDT; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BCKgDZV355566;
	Fri, 12 Dec 2025 21:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=VXTfbOvl4jHwCS1MMKU9RzvB58zQY
	WO3bQ66LrCeB7c=; b=Gn7LRjDT4PtJnBLSAt4wrRgDylVIEb1iUBweunwJXT3QR
	ImxRpTwmwwHbXVVN5Rz8LD3QO+Hdsf9gkxKmRbHX2HdawGsJpsdyUylH5DMEbq1e
	mtrLKPRN0kqLMbOWtubaTXQPo+zZ4ZDvS/OOspUxzIMrg1wPM5g7faqWTkUjhius
	xtIlXTBHFizThaORB62nAzKqqWJOm7ey7KKpmCivLo/lS/iNpXPcBwKCGTO1pipf
	E2gQeFTbhwisXmPQMExT1kAhCQ/rWwkhJemL4BdhoCKX+tCnsDGIf0+SGGl1PAty
	AZEonlUPt6fmIxxTuBZFXBvWAADAgcmvfXzgVpWZg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ayd1mbuw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 21:06:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCK7LGG039851;
	Fri, 12 Dec 2025 21:06:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxq9swn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 21:06:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BCL6thv002146;
	Fri, 12 Dec 2025 21:06:55 GMT
Received: from oracle (dhcp-10-154-164-6.vpn.oracle.com [10.154.164.6])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxq9sve-1;
	Fri, 12 Dec 2025 21:06:54 +0000
From: gregory.herrero@oracle.com
To: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
        przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregory Herrero <gregory.herrero@oracle.com>
Subject: [PATCH v5 0/1] i40e: additional safety check
Date: Fri, 12 Dec 2025 22:06:42 +0100
Message-ID: <20251212210643.1835176-1-gregory.herrero@oracle.com>
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
 definitions=2025-12-12_06,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512120169
X-Proofpoint-GUID: ABSMda4Hs0gfgUUPPT8SgMTFSb76Uje_
X-Authority-Analysis: v=2.4 cv=HvZ72kTS c=1 sm=1 tr=0 ts=693c83f0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=6XBYZHheHbEpf8W9LPYA:9 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: ABSMda4Hs0gfgUUPPT8SgMTFSb76Uje_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDE3MCBTYWx0ZWRfX2FkTy0YpMuWo
 I+bQxkA8IFk7USA5EKqAEgEd1/1lKIZhCaXSW58V5dZ/M/WwrEcOpf8ctT1p114LBP4naV9eq/b
 eEeV+YnHEcBwvTdrLJ9n/BW7DjD4aH2UuN8ARYOCKCkeEecLnaKXdch/FASHPGvBPr8tDcZDqnj
 jbH2au4DKTtWogwnLihoSUcoqhh3lV+ovAuvPvj/2MhUb+YyRm/m5YUh5enepEXpM+qY6dMQubh
 MDudOtp0+/1rdFhTUims7miyd5VXzXPI6LW2eKOxTM/CK67OMFYoCi1BH8QHTCaczFUNssdLl84
 qWMZvwsteWl/084t5LT0XE+UDGyLAVH2RmO9lYZL4eNO6j9U0jkD5ky1+8we57DCQZb4K4wrJej
 7LsBtwKLeV8Q7T4Xz/HP/r1Folq135g6G7TOmm+P0uQ1dnQPrvc=

From: Gregory Herrero <gregory.herrero@oracle.com>

On code inspection, I realized we may want to check ring_len parameter
against hardware specific values in i40e_config_vsi_tx_queue() and
i40e_config_vsi_rx_queue().

v5:
- use "hardware-dependent" in commit description
- add Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
- get rid of i40e_get_max_num_descriptors() documentation as it's self explanatory
v4:
- remove u32 cast in i40e_config_vsi_tx_queue() too and don't mention it
  anymore in commit description.
- wrap i40e_get_max_num_descriptors() description
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

 drivers/net/ethernet/intel/i40e/i40e.h             | 11 +++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 12 ------------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 ++--
 3 files changed, 13 insertions(+), 14 deletions(-)

-- 
2.51.0


