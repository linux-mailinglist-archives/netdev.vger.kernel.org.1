Return-Path: <netdev+bounces-221851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B05DB52172
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 21:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3407A6954
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 19:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C1826B75C;
	Wed, 10 Sep 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y2cimDcU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129C2DBF5B
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533853; cv=none; b=PEBohgekXsZXOqfUYt/xy25CjUW8qPJiSeztRD2XGDtrk9QQikcrxoFRZlsYBIhKN1HYSlYepeREPemSqBGwTvHDVEaWDE14Rfjysl56iDjbMXLftNoxuM8pBKbRIJhWfq4edjxyTVrDMk35cPJHGoecuhZrp9O4GasV6knSWFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533853; c=relaxed/simple;
	bh=cXtG1Ihht7jXBzzURMLt8xqVtyvQ0BjnJbfbN1jlXAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDF/DRK7Ctkwd5ipHYwwOYxovqUvNlpExClUsWqTOiqAsHT4tamXBfBC63T0z+P2adnSxYh8P7B3AUzWVZhJ39LgfFq1lCWSMq463xXf61InYnTkeIgoQcIAScuhIhdI75B6UKDRiPa1IjuW1KUsmU+KXNehg2TiH6cth4q1OHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y2cimDcU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfk0Z009842;
	Wed, 10 Sep 2025 19:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=+nPHluCtmPz/tz4X5ZgEnL99tvHjz
	Ls1kb1DDghsUVA=; b=Y2cimDcUm6G33n1Ixew26pkQLMlze0NFK4COqwaGlIjRL
	WSfpD6esnSxzcIniMh3tprwewIEKiKLMwgjpOCRpV00vvMwDtu9TLsIGnbbadBLP
	tSCn+m42AfL7LglAgKZTNBbpaFbasUcoyDjxkp5f6tJ98EN0C+s/q5EWSPDbseCI
	CU1SKVDJf7ylR0Gp2/Px6IGqRvPHJon7EZUDdScbFw0g/38l9dEwrTvPD2t19lqr
	Xffp0YRehbsZsTeIWG5XPYMcxBcbjWRpRE6lVZ4cYURb4EYi0YBqPd2ecY7su5+i
	wufA6/QBg4l0SswO5eEiSTLHQpiZMk+8MiZ1Vs6EA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shvtfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 19:50:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AIn0uQ038749;
	Wed, 10 Sep 2025 19:50:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdbfs76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 19:50:35 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58AJoYYT017128;
	Wed, 10 Sep 2025 19:50:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 490bdbfs6a-1;
	Wed, 10 Sep 2025 19:50:34 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH v3 net-next] udp_tunnel: use netdev_warn() instead of netdev_WARN()
Date: Wed, 10 Sep 2025 12:50:26 -0700
Message-ID: <20250910195031.3784748-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100184
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c1d68d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=szbEjYlwAJ6rEAnA0VQA:9
 cc=ntf awl=host:12083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX8TGuKX4mYd/L
 TYRIGbfXhpbNGHoFa6WnOcSvCqunDmkVpO0kKkPcN5iASB1zBmFQ2iaZiFtWXzdqw2PhbDohTrl
 QHOiSRtYEmFaQtKLOcQpNddFnK7If9ZbLabCzNy1voqbbo2wkvGzU5IWyhJx+ejZwBdbQ2VX5m9
 zczRs/y90ev7V7Eb8B1YctFre7EFxu7mjo8PQhcD5grVvW+irLdxJsitQpetszNEpbMNnQdzaNn
 UzAsCjfW7r8aTvY+UwtRBo/u6kbBtlgMlPRrYv+8whp75sAKrVWG1rlFc0317ufO9qH7tAn69/H
 UF4CYNSIvdx9cwBXqKAKwzCOYrMgyVglwUK3haXL0qQXaI+JxV6XM1fMsaIrIRyb4Q9O7D1WG7K
 4UwSzTXnbk7vAFj4QAh9yIkV1LFsrg==
X-Proofpoint-GUID: HhTM1OVbpukVelqOEvQ0O9yjmUFCd1tw
X-Proofpoint-ORIG-GUID: HhTM1OVbpukVelqOEvQ0O9yjmUFCd1tw

netdev_WARN() uses WARN/WARN_ON to print a backtrace along with
file and line information. In this case, udp_tunnel_nic_register()
returning an error is just a failed operation, not a kernel bug.

udp_tunnel_nic_register() can fail in two ways:
1. "-EINVAL":
Invalid or inconsistent udp_tunnel_nic_info provided by the driver
(e.g. set_port without a matching unset_port, missing sync_table,
first table with zero entries). These paths already trigger an
internal WARN_ON(), so misuse is caught and logged with a backtrace.

2. "-ENOMEM":
Memory allocation failure (kzalloc() or udp_tunnel_nic_alloc()).
This is a normal runtime error and not a kernel bug.

Since the -EINVAL paths already warn internally(use WARN()), and
-ENOMEM is a routine failure, the notifier should not escalate
with netdev_WARN(). A plain netdev_warn() is sufficient to
report the error.

Replace netdev_WARN() with netdev_warn() accordingly.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2 -> v3 
added Reviewed-by Simon
Rephrase commit message after Jakub comment and added more context
for removing netdev_WARN wrt udp_tunnel_nic_register
https://lore.kernel.org/all/20250908182809.3e5a9fdf@kernel.org/
v1 -> v2
Modified commit message as discuss with Simon.
https://lore.kernel.org/all/20250903195717.2614214-1-alok.a.tiwari@oracle.com/
---
 net/ipv4/udp_tunnel_nic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index ff66db48453c..944b3cf25468 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -930,7 +930,7 @@ udp_tunnel_nic_netdevice_event(struct notifier_block *unused,
 
 		err = udp_tunnel_nic_register(dev);
 		if (err)
-			netdev_WARN(dev, "failed to register for UDP tunnel offloads: %d", err);
+			netdev_warn(dev, "failed to register for UDP tunnel offloads: %d", err);
 		return notifier_from_errno(err);
 	}
 	/* All other events will need the udp_tunnel_nic state */
-- 
2.50.1


