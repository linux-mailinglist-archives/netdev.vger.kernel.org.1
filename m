Return-Path: <netdev+bounces-100369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DE48DDEFF
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDF1285D0D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3742C13C80C;
	Mon,  3 Jun 2024 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uvkz1e85"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6613C3FD;
	Mon,  3 Jun 2024 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450083; cv=none; b=qMS49FXYBvA2JcW9hNIx67HdowUwEI5Mwa0FvGQHat2WxOQ9iTvN1NiWkbTv1QPNi1HclNSfu03VG00zc6QXB0KfqoqlzA40bJOTD8m9fxq6ZX1XFzxbGvJdz+uW1DcbeQiG8vCgtKy5ALTv4lcXxJhlhg5DuyjxClKjHigHNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450083; c=relaxed/simple;
	bh=sJn8dFZQLw2fmK2rJKb/aIWYwv735vUTvmHjnnVa8SM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXZSLwRszdVmwqQo8kH5DHcwjiYmmgDQBeXw7xE3VbBGSOcmaq05JMSZewDOFjohcg+wWM2vy1HxOCgF4RG8iAZ6RcfO6DdMkH6tB6dVMwRNWm5yKacz2DFSIlVsh94SyvHzOK6PuB1H2qlMIHogV/a5A9fnH75s6HqTmklg3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uvkz1e85; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453LKVbf004773;
	Mon, 3 Jun 2024 21:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=pp1;
 bh=8S6scMshr6tSq+DiziFQE+WxeVKxyQiLKP2e8PnBO60=;
 b=Uvkz1e85Hs9TxxEOjuFwWMq7fOYXVN+iNZEh9IDa6SZjDA3bB8I2R+oteKPmD8XWAsA4
 6O0bX7f796Qd43uudriRLWhbDN49IqHE1Ns+WiOZ9Gpj+QJqYwrq5CDgcd5exs/GRKK+
 /QhuX1/aFsOjN1zUJl8XADeunG3sRru/dAVQEtNz46Wzs4pao2YrVGmo9P+PSnFLjDW5
 74EEy45fIZneuz9jXPxzS4/V/88w+awVmZCO0POMkSRIFzImRRVinR9FzUW0GuHFLag4
 GD0gVnG5JHZfkUPQSYKAk4sLSeXE6g2TBwCwYaX6YHdIRY3Ml8dUYnDZR1G+pWT+9EWy +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhnf981et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 21:27:54 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 453LRsMl016080;
	Mon, 3 Jun 2024 21:27:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhnf981eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 21:27:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 453Ji6xs026628;
	Mon, 3 Jun 2024 21:27:52 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygffmt4y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 21:27:52 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 453LRoUe14025424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Jun 2024 21:27:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8421A58060;
	Mon,  3 Jun 2024 21:27:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5AB45805E;
	Mon,  3 Jun 2024 21:27:49 +0000 (GMT)
Received: from ltcwspoon18.bm.com (unknown [9.40.194.38])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Jun 2024 21:27:49 +0000 (GMT)
From: David Christensen <drc@linux.ibm.com>
To: Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>,
        drivers@pensando.io (supporter:PENSANDO ETHERNET DRIVERS),
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Christensen <drc@linux.ibm.com>,
        netdev@vger.kernel.org (open list:PENSANDO ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] ionic: advertise 52-bit addressing limitation for MSI-X
Date: Mon,  3 Jun 2024 17:27:41 -0400
Message-ID: <20240603212747.1079134-1-drc@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530214026.774256-1-drc@linux.ibm.com>
References: <20240530214026.774256-1-drc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cmtwd-_6opUdRXMsHcHFevFRVV6SKc1b
X-Proofpoint-ORIG-GUID: dMg9qzWn0gWnPL_IrE_FJbqkg08Gr8_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=889 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030173

Current ionic devices only support 52 internal physical address
lines. This is sufficient for x86_64 systems which have similar
limitations but does not apply to all other architectures,
notably IBM POWER (ppc64). To ensure that MSI/MSI-X vectors are
not set outside the physical address limits of the NIC, set the
no_64bit_msi value of the pci_dev structure during device probe.

Signed-off-by: David Christensen <drc@linux.ibm.com>
---
v2: Limit change to ppc64 systems as suggested
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 6ba8d4aca0a0..a7146d50f814 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -326,6 +326,11 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out;
 	}
 
+#ifdef CONFIG_PPC64
+	/* Ensure MSI/MSI-X interrupts lie within addressable physical memory */
+	pdev->no_64bit_msi = 1;
+#endif
+
 	err = ionic_setup_one(ionic);
 	if (err)
 		goto err_out;
-- 
2.43.0


