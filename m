Return-Path: <netdev+bounces-128734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F90F97B44B
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 21:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211D91F23C18
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 19:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1405D189B8A;
	Tue, 17 Sep 2024 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OA4qe+aG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD24187851;
	Tue, 17 Sep 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726600394; cv=none; b=LzIlzQCxs3V572F3g49ZFY49gIRBtw2BDhTvXl30arfqYMtFGoaN7474LYEAVzVY5Tp+Tdzo+u/lP0IixGDlHJxLT44Ts67vNOue0DBtzHvqYTB0uMnrivM089T2PQm8kCWIizmDSCNn4+zSkAfXy6uIJ/AECk6/AVZuc3ogNhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726600394; c=relaxed/simple;
	bh=gK0z35wo4sEinJ2IRbgB2seiC4GbJWilR01Jv0BXbAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BswNkayH6Aiy9NuZ94Vxm5fOnuBusuX+hP1QkdlQ8lgeJcx36FCrZObrqcJ6o7w3f1b2myeol8PtuCjyZtR0aIpDPzp4T3UGZFmJ89vK4qyeGU75Bw0KT6VbELajOq7NdwVdk58mAE/ThCy7vmOOEj1Qxy/F2X9qNhy1mwM9O7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OA4qe+aG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HHq550030256;
	Tue, 17 Sep 2024 19:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=tTTPe2EwMxGkXu3+quNIYQ4sUe
	qo69/BDRNt3fBrhKw=; b=OA4qe+aGN3rq6Aj6j0hwlUV6ckM82I9Kj4vK7xE435
	Z4m6TYeql/Myw+hxUSpgdTWX27GlxBpy6yi3u57jS0dB9l5ZmAFjg34+OzyRbPmr
	5waBWe7uieQ3tFh+iT68O600F9xJnRYMlwykWBVT4dsUiVO/hbrvjPLeUWBcZ93l
	7hfuMb1cZZJDxx3KPrFU22I55e2AL6s99dHaisZvXvUVgflvG5cMZFqCwzJY5imI
	EEphnR0zFdeVYmJ//D9DZ0WJBdlNaisa3HC3JEB4sver/tDoqYQYZ762QATjkTUn
	tavE5PU6Z2Evl9ruA41soqecVyc9fKbWXS1Ys+bTlQmQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht8gydw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 19:12:58 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48HJCv4L032258;
	Tue, 17 Sep 2024 19:12:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht8gydr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 19:12:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HIgii7000642;
	Tue, 17 Sep 2024 19:12:57 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nn7176tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 19:12:57 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HJCuZt28312284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 19:12:56 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D66F58054;
	Tue, 17 Sep 2024 19:12:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 061185803F;
	Tue, 17 Sep 2024 19:12:56 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.93.228])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 19:12:55 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: sam@mendozajonas.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, gwshan@linux.vnet.ibm.com, joel@jms.id.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH] net/ncsi: Cancel the ncsi work before freeing the associated structure
Date: Tue, 17 Sep 2024 14:12:55 -0500
Message-ID: <20240917191255.1436553-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rRR6VCjfQVnDeWQofMo0WN-evbbJJWpl
X-Proofpoint-ORIG-GUID: M-jZJrKOnE4X_Gt79SxMxjZB64N-TqW0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_09,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=772 mlxscore=0 clxscore=1011 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170134

The work function can run after the ncsi device is freed, resulting
in use-after-free bugs or kernel panic.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 net/ncsi/ncsi-manage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5ecf611c8820..3eda24eac668 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1954,6 +1954,8 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
+	cancel_work_sync(&ndp->work);
+
 	kfree(ndp);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
-- 
2.43.0


