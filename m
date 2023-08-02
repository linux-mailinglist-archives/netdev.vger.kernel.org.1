Return-Path: <netdev+bounces-23601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409AC76CABA
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED40281D0D
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE01663DE;
	Wed,  2 Aug 2023 10:22:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C082F6AA1
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:22:57 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5454691;
	Wed,  2 Aug 2023 03:22:35 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372AGpSt004509;
	Wed, 2 Aug 2023 10:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=1cNoGJVZF125rBY9OnJDl+Fdl0aPVj1gEkmPLfHnzVU=;
 b=jyuLNcPjucKRDl4Khvz4jAJYexfGm6X0Eb2jFeiXA21h1A1N0zV/S6mv82bO9mALFVRb
 0OG51DH4GgVfqns1C7XBV1qW/Nu8ifUpZaspCxE0FR2nQgZhNY7o4HOKbPfqTjK1y7PU
 4nmI6r3Ow7TM/U39Pw4wmNPUTRcM0/c4mJvLsltImt4+vUYFtmkLOpexvGYIVkvmaPTH
 DT+TwatCE2HT7fjJ4uEfMgO4JdPQaSbDgZafDFVlmGOM84/UirPRp8jRs5TV6zUOYOll
 M7hnOj0g16F6IHaggCWN5caEaOR5rV5NrCjOLc5f3jQ0/GKb9Nl4R5uzAmLtWcQVGnOD gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s7n8cr5pw-46
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Aug 2023 10:21:35 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 372A3fuK020068;
	Wed, 2 Aug 2023 10:10:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s7n1u8anw-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Aug 2023 10:10:49 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3728xff8015481;
	Wed, 2 Aug 2023 09:33:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5e3n3c4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Aug 2023 09:33:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3729XFIJ23528092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Aug 2023 09:33:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1923B2004B;
	Wed,  2 Aug 2023 09:33:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F72320043;
	Wed,  2 Aug 2023 09:33:14 +0000 (GMT)
Received: from dilbert5.fritz.box (unknown [9.171.33.230])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Aug 2023 09:33:14 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Karsten Graul <kgraul@linux.ibm.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net/smc: Fix effective buffer size
Date: Wed,  2 Aug 2023 11:33:11 +0200
Message-ID: <20230802093313.1501605-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HUvwGmNfuYDcpw6zsOQC0S1wlYgbMK-4
X-Proofpoint-GUID: Dl7yEQ6PuQkpfQEpYv8n95HfRyvGks56
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_05,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=838 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308020089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,

commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock
and make them tunable") started to derive the effective buffer size for
SMC connections inconsistently in case a TCP fallback was used and
memory consumption of SMC with the default settings was doubled when
a connection negotiated SMC. That was not what we want.

This series consolidates the resulting effective buffer size that is
used with SMC sockets, which is based on Jan karcher's effort (see 
[1]). For all TCP exchanges (in particular in case of a fall back when
no SMC connection was possible) the values from net.ipv4.tcp_[rw]mem
are used. If SMC succeeds in establishing a SMC connection, the newly
introduced values from net.smc.[rw]mem are used.

net.smc.[rw]mem is initialized to 64kB, respectively. Internal test 
have show this to be a good compromise between throughput/latency 
and memory consumption. Also net.smc.[rw]mem is now decoupled completely
from any tuning through net.ipv4.tcp_[rw]mem.

If a user chose to tune a socket's receive or send buffer size with
setsockopt, this tuning is now consistently applied to either fall-back
TCP or proper SMC connections over the socket.

Thanks,
Gerd 


[1] https://lore.kernel.org/netdev/20221123104907.14624-1-jaka@linux.ibm.com



Gerd Bayer (2):
  net/smc: Fix setsockopt and sysctl to specify same buffer size again
  net/smc: Use correct buffer sizes when switching between TCP and SMC

 net/smc/af_smc.c     | 80 +++++++++++++++++++++++++++++++-------------
 net/smc/smc.h        |  2 +-
 net/smc/smc_clc.c    |  4 +--
 net/smc/smc_core.c   | 25 +++++++-------
 net/smc/smc_sysctl.c | 10 ++++--
 5 files changed, 79 insertions(+), 42 deletions(-)

-- 
2.41.0


