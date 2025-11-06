Return-Path: <netdev+bounces-236413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D77C3BF8D
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210E9426C9C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE7B348883;
	Thu,  6 Nov 2025 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a9bm1TeC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82637347FE1;
	Thu,  6 Nov 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441427; cv=none; b=A+UYGPI+zliuzTGdgr9EGUpAnWzfTnD4KM1Q/GHHc00+wYq/IUsAQN0Zv005+hxSdFcw41C/Sw5ek6EO7VhOkCNIigQw1fjeDX1risiqdNC65PubKrDXt9Ze7DFVi5iB0DP3jDYstpZIA74/0M/EEtpXoBBX9DmLia48RoVA/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441427; c=relaxed/simple;
	bh=1823u8KRe/ONh/WmG9lBb2e09kzb6Napfw7/Jwvac1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txMh/z7gzFfHaDtpGZcOoGUCxis4eo2juHzdZ6BthRa7iYWjR6WKqcZSqfPdC0bRVcQp9h+gALiyhvvyXcvb4NTGqaWWPVrWmP7C5EP426zI6IL5r00gMMTL2UdBLnrPkWo9FFpIs71fKuy5nkpbrVsLSNm9EpaKrBD/3G9P0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a9bm1TeC; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6CPwab030120;
	Thu, 6 Nov 2025 15:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=2WHwFdzou0yMBZ8omfQgd6mfERlDv
	S6LcZV2FHcMa6U=; b=a9bm1TeCZM2ss5uu1sEL84V3ec2zD4Sta8Iw2aCjqbrNd
	sZeLuRd3vy1+ZxRSln+KLZdejNjDzXy1yU0xh99kFvVPnfCixeXqbJSZzSCyN+kz
	Nd6siV1QDl3IoQqAKGv8bbCUX9pFO4OgSZ+v/VtljlZXP5K6MGbq9VNm3bZbZ28z
	0lq3pHyhnY/UPcKtX2b1yMr+ph+npugEB80Fhmvq4SPNWu/bzW8nUCBGfHa9QWO3
	qWEkSK53ax7KoGKZ/ag9gmUm05ToVAyBWpfASr8dXX3Y0bd/fxTQxi9kBuYCpZh2
	fjDUwCmlfqyTDl9/29z6YOzOXINX5iwKdNL7g+oHA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8anjj6q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 15:03:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6EUtqI039457;
	Thu, 6 Nov 2025 15:03:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc8m9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 15:03:05 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A6ExlIV013458;
	Thu, 6 Nov 2025 15:03:05 GMT
Received: from oracle (dhcp-10-154-170-248.vpn.oracle.com [10.154.170.248])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58nc8m6b-1;
	Thu, 06 Nov 2025 15:03:04 +0000
From: gregory.herrero@oracle.com
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregory Herrero <gregory.herrero@oracle.com>
Subject: [PATCH 0/1] i40e: additional safety check
Date: Thu,  6 Nov 2025 16:02:46 +0100
Message-ID: <20251106150248.721025-1-gregory.herrero@oracle.com>
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
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfXyATL4TW4viBi
 R7i9Ozw+XQ1f5Q1U9MNwxh2zoDQf0yXc7O/qanAts0MwGstRPcE7roARziQfc+Saci6mmBx3wTo
 gsdy5YrYw09cA/EAwjOlKxW9QAJu+yOr3jEhAZ9PK2Iy4CbzAHMVgAnv08KuesD9HuAwHn2wcZH
 xtv1zM0gfKO5cL4uV4ZYQkzXQkjbUPjJ1bhn5Pp/ab6tDHW3dBVBQdLQDpL7bszwv8J0RlpiCYz
 QtVyIv4OPNI7zbiKfGcrELHDaK6vjUnDSmzq5n8ApxppxIYmo0X+zSsVoDCwIj+VFvI4xH7SecZ
 h1YHXmbzVu/nQJ8z4q3KZfsTEatfqF88gJdh4rAYgb6hpVrtNEdZ92Ykah3Waa7ukdVfQAHufv0
 b7oFQ9n3HiN4vV4FWQF2fytU4iwinA==
X-Authority-Analysis: v=2.4 cv=dfqNHHXe c=1 sm=1 tr=0 ts=690cb8aa cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=0R6e6KIkVPPXZogJ048A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ppc1stTjZJLpVYHYjIeytU9Ifjiv8IFk
X-Proofpoint-ORIG-GUID: ppc1stTjZJLpVYHYjIeytU9Ifjiv8IFk

From: Gregory Herrero <gregory.herrero@oracle.com>

On code inspection, I realized we may want to check ring_len parameter
against hardware specific values in i40e_config_vsi_tx_queue() and
i40e_config_vsi_rx_queue().

Gregory Herrero (1):
  i40e: validate ring_len parameter against hardware specific values.

 drivers/net/ethernet/intel/i40e/i40e.h         | 18 ++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ------------
 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 ++--
 3 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.51.0


