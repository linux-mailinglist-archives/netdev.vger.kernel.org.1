Return-Path: <netdev+bounces-130956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EE798C37D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4301F22CB3
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7638D1C9DCD;
	Tue,  1 Oct 2024 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oec7xlXb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420111C9DC0
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800340; cv=none; b=BE5oGj8Ud4bQOdt99maSUcZfCTzhHo41CE0veD0XWYkhZbiJgSvt5psU5VqMPS3QGJud4RcEyZRVqsu0Nv4fSpfQUPcg/WL0rDNUhIw5Yjus3XnYOhDwzVtrLVBkw2UMRX8bbkrha1NErc5XmXF1twnj+7cXUYmW5Y1guWa3xdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800340; c=relaxed/simple;
	bh=oYIH0lWrFLEVJSYTaFL2gjODFr0y2w1vRtyBYQnkRSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sON2rt+Ca/bivwgqmnwCUY5+nvLLuIkyx19jd2tHZu1XL7HW7IFvrDog06kytRI9FsfpxRRxPPVvDO3knKpyPPu99m+Lhzy5LdBMW50gayxSKZVYtWa30su6rgQp67H7vqrWmZlUpxcTsQl5bykFd9CVWluIZxW5j/xYylvVHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oec7xlXb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491GLYNI014035;
	Tue, 1 Oct 2024 16:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=hZ1LZEgCHYb5ge2wV/1o/sbVr1
	FCgkjsIIm09zA2WRA=; b=oec7xlXb0ROt9j4xZqMJS5RiLjMkhNbZkw6Yyx5Xmu
	+n5ODtVxLRfAqwT7eKcgmK06CFJBRD1ndWer3yJY5iJPDr5cR0OCQDKj+zctxdGn
	eu9OuZzi7Ls8wIoaW2Qll2MAtRuHYQ61ldYYgTMPs7e+SWyP9ZAdmP8p1i6KlU3X
	lz7CH2abXKMSocaFXPEjsOpyMjM4e34t4bmedjM8CrcXFYKjIgZb2vBXWb2tCON5
	mJ9TNY/gKRh87QskHo1lNw0IHmOqO25C3QwrvtGV3CwGaUbni6GkY1O9g0rz9QY+
	awVcHbnqij8kAnf/khoKG8Ec0NdQWN7ziQ4FAGB6+tBg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420mhfg25j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:32:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491GFZir013017;
	Tue, 1 Oct 2024 16:32:12 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbjd98j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:32:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491GW9OY37487002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 16:32:09 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 535715805A;
	Tue,  1 Oct 2024 16:32:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F6D858056;
	Tue,  1 Oct 2024 16:32:09 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.141.187])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 16:32:09 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net v2 0/1] ibmvnic: Fix for send scrq direct
Date: Tue,  1 Oct 2024 11:31:59 -0500
Message-ID: <20241001163200.1802522-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ojdv9X-nQ37spT9oSabDpxVAMc-7ekN-
X-Proofpoint-ORIG-GUID: ojdv9X-nQ37spT9oSabDpxVAMc-7ekN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_13,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 impostorscore=0 phishscore=0 priorityscore=1501 mlxlogscore=885
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010105

This is a v2 of a patchset (now just patch) which addresses a
bug in a new feature which is causing major link UP issues with
certain physical cards.

For a full summary of the issue:
  1. During vnic initialization we get the following values from vnic
     server regarding "Transmit / Receive Descriptor Requirement" (see
      PAPR Table 584. CAPABILITIES Commands):
    - LSO Tx frame = 0x0F , header offsets + L2, L3, L4 headers required
    - CSO Tx frame = 0x0C , header offsets + L2 header required
    - standard frame = 0x0C , header offsets + L2 header required
  2. Assume we are dealing with only "standard frames" from now on (no
     CSO, no LSO)
  3. When using 100G backing device, we don't hand vnic server any header
     information and TX is successful
  4. When using 25G backing device, we don't hand vnic server any header
    information and TX fails and we get "Adapter Error" transport events.
The obvious issue here is that vnic client should be respecting the 0X0C
header requirement for standard frames.  But 100G cards will also give
0x0C despite the fact that we know TX works if we ignore it. That being
said, we still must respect values given from the managing server. Will
need to work with them going forward to hopefully get 100G cards to
return 0x00 for this bitstring so the performance gains of using
send_subcrq_direct can be continued.

Thanks Simon for review on v1 [1]. Much appreciated.

Changes in v2:
 - drop the statistics tracking patch (send to net-next)
 - Fix formatting and commit of Fixes tag


Nick Child (1):
  ibmvnic: Inspect header requirements before using scrq direct

 drivers/net/ethernet/ibm/ibmvnic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.43.5


