Return-Path: <netdev+bounces-99562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A378D54B0
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3D11F25438
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 21:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE80181D03;
	Thu, 30 May 2024 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TwH5JCYw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB2180A92;
	Thu, 30 May 2024 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105250; cv=none; b=ZfDspEE5zBsqPoYGEY1g/EFjyi51ZFesTJXxNICjt8c4XbkhiE5/c5ycfq1vUzMbSdOrRbNKfqGcKrVh9pUepgRgwMWBhkFse0BYKzMXq5hprZdXsjKcu6q+9FbPqZepP8BfbMeKgATEigYTOUKGkX7+OPSdyWBFoI/YR6f1MAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105250; c=relaxed/simple;
	bh=1w2qN10WOqvuZQeu6VvgnNDi3oQj5EaJz95IcVWuFvo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SOqrdml24jhVJ4IKUyryjPXtSCJ/2iRjizQvyk7ICAnmvwZXi8M/VthQvjC2pJgalQ1DNo1uSaBtz24V86BlKDjg28eZ7WkYWkuHjzekuUtgztpcNLekMBUmp41IcwLHceatfSStClsY3pM9zkgoyNo+vp7yq8GZSOvwUSHhR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TwH5JCYw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44ULRZDY032634;
	Thu, 30 May 2024 21:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=pp1; bh=1rytHSjc5j7es5kFgrgVdsI3VdYT1M/6yMPekap969A=;
 b=TwH5JCYwf77iQTVGhYmoILo+DSPUrBzdPlxxDK7SvYt9sSEzhnEo+gTJ+/JdRuHXxdZc
 fO6xg/5tOk/i+kekBiZqdwv7lqKgbGNMq/Q1FezYXUQ1nga/oVd8/SvZPXEYJTxFk4G5
 MEUfr9fUYRAGC9xkQAQZK7CnY3DpPjb3fcp3psZp15jKQLsKfX+O53w73/dBDKtyksa+
 7E7BPiotnunHblWvQwSl1SrZ/ckIAxnHfHTzS2YJe6zx4Znv5wH9S/X7yAG2n0VM+ND0
 7BicAXqXY5doxKh5IGW2SZqaslcbADP+jjEKKL9tTlb1NaCYz2WNOKFxxsLz+mK05qBi xw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yf1cn0136-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 21:40:42 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44ULef9E022058;
	Thu, 30 May 2024 21:40:41 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yf1cn0133-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 21:40:41 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44UIptMF002437;
	Thu, 30 May 2024 21:40:40 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ydpb0v9mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 21:40:40 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44ULebeF27984224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 21:40:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C060D5805A;
	Thu, 30 May 2024 21:40:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EA7558052;
	Thu, 30 May 2024 21:40:37 +0000 (GMT)
Received: from ltcwspoon18.bm.com (unknown [9.40.194.38])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 May 2024 21:40:37 +0000 (GMT)
From: David Christensen <drc@linux.ibm.com>
To: Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>,
        drivers@pensando.io (supporter:PENSANDO ETHERNET DRIVERS),
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Christensen <drc@linux.ibm.com>,
        netdev@vger.kernel.org (open list:PENSANDO ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] ionic: advertise 52-bit addressing limitation for MSI-X
Date: Thu, 30 May 2024 17:40:20 -0400
Message-ID: <20240530214026.774256-1-drc@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J2-TfskN_QWrdP5zpeRJQ-LdwR5YL2ka
X-Proofpoint-ORIG-GUID: tM5MTeu0JewSnauJjzVyQbhgNvnIKFVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxlogscore=743 suspectscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300162

Current ionic devices only support 52 internal physical address
lines. This is sufficient for x86_64 systems which have similar
limitations but does not apply to all other architectures,
notably IBM POWER (ppc64). To ensure that MSI/MSI-X vectors are
not set outside the physical address limits of the NIC, set the
recently added no_64bit_msi value of the pci_dev structure
during device probe.

Signed-off-by: David Christensen <drc@linux.ibm.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 6ba8d4aca0a0..1e7f507f461f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -326,6 +326,10 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out;
 	}
 
+	/* Ensure MSI/MSI-X interrupts lie within addressable physical memory */
+	if (IONIC_ADDR_LEN < 64)
+		pdev->no_64bit_msi = 1;
+
 	err = ionic_setup_one(ionic);
 	if (err)
 		goto err_out;
-- 
2.43.0


