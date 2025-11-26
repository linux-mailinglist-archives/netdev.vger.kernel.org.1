Return-Path: <netdev+bounces-241909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2598AC8A26C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 15:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06D434E18E9
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FABA23EAA4;
	Wed, 26 Nov 2025 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ik2ExVWA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D018239E9D
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764166060; cv=none; b=QObONOBPsmahBWD8SOwS1rWDkwbByW93Vic+kddc5kWi/pPr83ct1P0XGbMP8TDxGvnPu+nkbEjKknIIgFx3UUjd+dmq4rMOWroPVzTUF2Qn3PClit7yE2+L1aMScbHQAM57DKlONchrhRktL+eCphqm7aTiSnoSjB0X+7xh4so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764166060; c=relaxed/simple;
	bh=q9HOcrwi7Haw2ytHuo2gSjLCj5PCL85TRl8EQvv+5E0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ClgL4SmUepQADCeBEOktMfInepH8kFe28g20wiivHiFk3BjpOab6ZaIsPsPCSvz9jlCMUTP1dhlczw9XSaB6ECzrvJjVUERS8bZS7hrj/CmJ3gydq9ScE45L7YwvCvzlvHq+8Vx5rGnz9Yh22O9vDvZx1+8tu08cwRXJfV60BPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ik2ExVWA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQDhr61015937;
	Wed, 26 Nov 2025 14:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZEq0SaYrYACBGpEVid5+cuxIYf1ieg+Pj2BO6NAYb
	H8=; b=Ik2ExVWAenSGZ2LUBFBs/KCRdYeLrVjY21uvUesYe+cshj/7uvU7d3/Uj
	k5U8B1RZ6VSP8Vn6E59nTQZVXn+d/EuO9FbTFximjBAwwjUqB01WYjKacKfcdrZt
	HOt6NuTattGJ6FwnNJyPMbK4V3Mvh5WyahInS9QcDr7xkDF7MEkySmdqe+ReYjKs
	KhYbLt033BkfYLXd2cYi4A6Az1gYjTb87kW7zs0VOS92P442wGkDamj2lYgCvA41
	VgOhil/P8iWDNGsAc2UrEv7OZL4ZlKHPDDpFB4/P55ALo83WLjqxvnmIg3VWi1xZ
	/r8hz7kpOBnAKHOxVujwXEJPp1tFQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9mjbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 14:07:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQDtWxr005670;
	Wed, 26 Nov 2025 14:07:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9mjbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 14:07:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQBmBJw016415;
	Wed, 26 Nov 2025 14:07:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aks0kaukm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 14:07:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQE75Gf26280516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 14:07:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7946F20040;
	Wed, 26 Nov 2025 14:07:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39A0020043;
	Wed, 26 Nov 2025 14:07:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Nov 2025 14:07:05 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next] net: Remove KMSG_COMPONENT macro
Date: Wed, 26 Nov 2025 15:07:05 +0100
Message-ID: <20251126140705.1944278-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX3WU2edIt/v38
 6c3wIW2fWzZUsvODaNqBn/Dt8MS2tWvPe3RsNkKXY/saZudsNf8R4EwVlfVhol/bK3R3+0UTisW
 ZduDDg8o3BBHKqIu4JVPzuu0+PRLmdbfsJhc4jRDREg7fnOhiwMqYCRZpSkAngSTMyTZg0NsxQj
 VHnT13rpTB7jJT/Kp2DaxhJYp4SoHIrB5EO7t8fmCJ8CPFt3WbxD2wW4GLHU0NqhzNu1YqqiSB2
 i/blxXuhvEB/x7MbCaaU+MoIhR4IVO63/hNjYfFMaZ65baHaVcqOH9hcaeJyUrFEvtuZkQQ7PQ7
 p63Ww+L61EW94o77wGNjSv42q/yAm0+/CzRfa2Mu0Wlh0ICwUlxHsbeodx7Gz7rSxzvk4hoRyIY
 S3qWCeIZl7vRSLrl1FkRNY1wYxGK2Q==
X-Proofpoint-ORIG-GUID: wDfiO-adFXPDFaQ0wHa5HCMxWTMK_GfF
X-Proofpoint-GUID: 8RDqae6alA__ES6B3WcMZt2nzpTDLdxv
X-Authority-Analysis: v=2.4 cv=TMJIilla c=1 sm=1 tr=0 ts=6927098f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=07d9gI8wAAAA:8 a=VnNF1IyMAAAA:8
 a=NsJvohJoAAAA:8 a=UOZ5hxCXAAAA:8 a=94yH14jbCm0jEWaC9TwA:9
 a=e2CUPOnPG4QKp8I52DXD:22 a=EhyWc6Ge1J1sLbzhIhWN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 clxscore=1011
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021

The KMSG_COMPONENT macro is a leftover of the s390 specific "kernel message
catalog" from 2008 [1] which never made it upstream.

The macro was added to s390 code to allow for an out-of-tree patch which
used this to generate unique message ids. Also this out-of-tree patch
doesn't exist anymore.

The pattern of how the KMSG_COMPONENT macro is used can also be found at
some non s390 specific code, for whatever reasons. Besides adding an
indirection it is unused.

Remove the macro in order to get rid of a pointless indirection. Replace
all users with the string it defines. In all cases this leads to a simple
replacement like this:

 - #define KMSG_COMPONENT "af_iucv"
 - #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 + #define pr_fmt(fmt) "af_iucv: " fmt

[1] https://lwn.net/Articles/292650/

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 net/iucv/af_iucv.c                      | 3 +--
 net/iucv/iucv.c                         | 3 +--
 net/netfilter/ipvs/ip_vs_app.c          | 3 +--
 net/netfilter/ipvs/ip_vs_conn.c         | 3 +--
 net/netfilter/ipvs/ip_vs_core.c         | 3 +--
 net/netfilter/ipvs/ip_vs_ctl.c          | 3 +--
 net/netfilter/ipvs/ip_vs_dh.c           | 3 +--
 net/netfilter/ipvs/ip_vs_est.c          | 3 +--
 net/netfilter/ipvs/ip_vs_fo.c           | 3 +--
 net/netfilter/ipvs/ip_vs_ftp.c          | 3 +--
 net/netfilter/ipvs/ip_vs_lblc.c         | 3 +--
 net/netfilter/ipvs/ip_vs_lblcr.c        | 3 +--
 net/netfilter/ipvs/ip_vs_lc.c           | 3 +--
 net/netfilter/ipvs/ip_vs_mh.c           | 3 +--
 net/netfilter/ipvs/ip_vs_nfct.c         | 3 +--
 net/netfilter/ipvs/ip_vs_nq.c           | 3 +--
 net/netfilter/ipvs/ip_vs_ovf.c          | 3 +--
 net/netfilter/ipvs/ip_vs_pe.c           | 3 +--
 net/netfilter/ipvs/ip_vs_pe_sip.c       | 3 +--
 net/netfilter/ipvs/ip_vs_proto.c        | 3 +--
 net/netfilter/ipvs/ip_vs_proto_ah_esp.c | 3 +--
 net/netfilter/ipvs/ip_vs_proto_tcp.c    | 3 +--
 net/netfilter/ipvs/ip_vs_proto_udp.c    | 3 +--
 net/netfilter/ipvs/ip_vs_rr.c           | 3 +--
 net/netfilter/ipvs/ip_vs_sched.c        | 3 +--
 net/netfilter/ipvs/ip_vs_sed.c          | 3 +--
 net/netfilter/ipvs/ip_vs_sh.c           | 3 +--
 net/netfilter/ipvs/ip_vs_sync.c         | 3 +--
 net/netfilter/ipvs/ip_vs_twos.c         | 3 +--
 net/netfilter/ipvs/ip_vs_wlc.c          | 3 +--
 net/netfilter/ipvs/ip_vs_wrr.c          | 3 +--
 net/netfilter/ipvs/ip_vs_xmit.c         | 3 +--
 net/smc/af_smc.c                        | 3 +--
 33 files changed, 33 insertions(+), 66 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index a4f1df92417d..1e62fbc22cb7 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -10,8 +10,7 @@
  *		Ursula Braun <ursula.braun@de.ibm.com>
  */
 
-#define KMSG_COMPONENT "af_iucv"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "af_iucv: " fmt
 
 #include <linux/filter.h>
 #include <linux/module.h>
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 008be0abe3a5..da2af413c89d 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -20,8 +20,7 @@
  *    CP Programming Service, IBM document # SC24-5760
  */
 
-#define KMSG_COMPONENT "iucv"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "iucv: " fmt
 
 #include <linux/kernel_stat.h>
 #include <linux/export.h>
diff --git a/net/netfilter/ipvs/ip_vs_app.c b/net/netfilter/ipvs/ip_vs_app.c
index fdacbc3c15be..d54d7da58334 100644
--- a/net/netfilter/ipvs/ip_vs_app.c
+++ b/net/netfilter/ipvs/ip_vs_app.c
@@ -13,8 +13,7 @@
  * Author:	Juan Jose Ciarlante, <jjciarla@raiz.uncu.edu.ar>
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index 37ebb0cb62b8..50cc492c7553 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -17,8 +17,7 @@
  * Changes:
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/interrupt.h>
 #include <linux/in.h>
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 5ea7ab8bf4dc..90d56f92c0f6 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -19,8 +19,7 @@
  *	Harald Welte			don't use nfcache
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 4c8fa22be88a..068702894377 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -13,8 +13,7 @@
  * Changes:
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/net/netfilter/ipvs/ip_vs_dh.c b/net/netfilter/ipvs/ip_vs_dh.c
index 75f4c231f4a0..bb7aca4601ff 100644
--- a/net/netfilter/ipvs/ip_vs_dh.c
+++ b/net/netfilter/ipvs/ip_vs_dh.c
@@ -30,8 +30,7 @@
  *
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/ip.h>
 #include <linux/slab.h>
diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
index 93a925f1ed9b..77f4f637ff67 100644
--- a/net/netfilter/ipvs/ip_vs_est.c
+++ b/net/netfilter/ipvs/ip_vs_est.c
@@ -12,8 +12,7 @@
  *              get_stats()) do the per cpu summing.
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/kernel.h>
 #include <linux/jiffies.h>
diff --git a/net/netfilter/ipvs/ip_vs_fo.c b/net/netfilter/ipvs/ip_vs_fo.c
index ab117e5bc34e..d657b47c6511 100644
--- a/net/netfilter/ipvs/ip_vs_fo.c
+++ b/net/netfilter/ipvs/ip_vs_fo.c
@@ -8,8 +8,7 @@
  *     Kenny Mathis            :     added initial functionality based on weight
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/net/netfilter/ipvs/ip_vs_ftp.c b/net/netfilter/ipvs/ip_vs_ftp.c
index 206c6700e200..b315c608fda4 100644
--- a/net/netfilter/ipvs/ip_vs_ftp.c
+++ b/net/netfilter/ipvs/ip_vs_ftp.c
@@ -16,8 +16,7 @@
  * Author:	Wouter Gadeyne
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index 156181a3bacd..e6c8ed0c92f6 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -34,8 +34,7 @@
  * me to write this module.
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/ip.h>
 #include <linux/slab.h>
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index a021e6aba3d7..a25cf7bb6185 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -32,8 +32,7 @@
  *
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/ip.h>
 #include <linux/module.h>
diff --git a/net/netfilter/ipvs/ip_vs_lc.c b/net/netfilter/ipvs/ip_vs_lc.c
index c2764505e380..38cc38c5d8bb 100644
--- a/net/netfilter/ipvs/ip_vs_lc.c
+++ b/net/netfilter/ipvs/ip_vs_lc.c
@@ -9,8 +9,7 @@
  *     Wensong Zhang            :     added any dest with weight=0 is quiesced
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/net/netfilter/ipvs/ip_vs_mh.c b/net/netfilter/ipvs/ip_vs_mh.c
index e3d7f5c879ce..f61f54004c9e 100644
--- a/net/netfilter/ipvs/ip_vs_mh.c
+++ b/net/netfilter/ipvs/ip_vs_mh.c
@@ -17,8 +17,7 @@
  *
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/ip.h>
 #include <linux/slab.h>
diff --git a/net/netfilter/ipvs/ip_vs_nfct.c b/net/netfilter/ipvs/ip_vs_nfct.c
index 08adcb222986..81974f69e5bb 100644
--- a/net/netfilter/ipvs/ip_vs_nfct.c
+++ b/net/netfilter/ipvs/ip_vs_nfct.c
@@ -30,8 +30,7 @@
  * PASV response can not be NAT-ed) but Active FTP should work
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/types.h>
diff --git a/net/netfilter/ipvs/ip_vs_nq.c b/net/netfilter/ipvs/ip_vs_nq.c
index ed7f5c889b41..ada158c610ce 100644
--- a/net/netfilter/ipvs/ip_vs_nq.c
+++ b/net/netfilter/ipvs/ip_vs_nq.c
@@ -26,8 +26,7 @@
  *
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/net/netfilter/ipvs/ip_vs_ovf.c b/net/netfilter/ipvs/ip_vs_ovf.c
index c7708b809700..c5c67df80a0b 100644
--- a/net/netfilter/ipvs/ip_vs_ovf.c
+++ b/net/netfilter/ipvs/ip_vs_ovf.c
@@ -12,8 +12,7 @@
  * active connections
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/net/netfilter/ipvs/ip_vs_pe.c b/net/netfilter/ipvs/ip_vs_pe.c
index 166c669f0763..3035079ebd99 100644
--- a/net/netfilter/ipvs/ip_vs_pe.c
+++ b/net/netfilter/ipvs/ip_vs_pe.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/spinlock.h>
diff --git a/net/netfilter/ipvs/ip_vs_pe_sip.c b/net/netfilter/ipvs/ip_vs_pe_sip.c
index e4ce1d9a63f9..85f31d71e29a 100644
--- a/net/netfilter/ipvs/ip_vs_pe_sip.c
+++ b/net/netfilter/ipvs/ip_vs_pe_sip.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/net/netfilter/ipvs/ip_vs_proto.c b/net/netfilter/ipvs/ip_vs_proto.c
index a9fd1d3fc2cb..fd9dbca24c85 100644
--- a/net/netfilter/ipvs/ip_vs_proto.c
+++ b/net/netfilter/ipvs/ip_vs_proto.c
@@ -8,8 +8,7 @@
  * Changes:
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/net/netfilter/ipvs/ip_vs_proto_ah_esp.c b/net/netfilter/ipvs/ip_vs_proto_ah_esp.c
index 89602c16f6b6..44e14acc187e 100644
--- a/net/netfilter/ipvs/ip_vs_proto_ah_esp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_ah_esp.c
@@ -6,8 +6,7 @@
  *		Wensong Zhang <wensong@linuxvirtualserver.org>
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/in.h>
 #include <linux/ip.h>
diff --git a/net/netfilter/ipvs/ip_vs_proto_tcp.c b/net/netfilter/ipvs/ip_vs_proto_tcp.c
index 7da51390cea6..f68a1533ee45 100644
--- a/net/netfilter/ipvs/ip_vs_proto_tcp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_tcp.c
@@ -13,8 +13,7 @@
  *              protocol ip_vs_proto_data and is handled by netns
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/kernel.h>
 #include <linux/ip.h>
diff --git a/net/netfilter/ipvs/ip_vs_proto_udp.c b/net/netfilter/ipvs/ip_vs_proto_udp.c
index 68260d91c988..0f0107c80dd2 100644
--- a/net/netfilter/ipvs/ip_vs_proto_udp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_udp.c
@@ -9,8 +9,7 @@
  *              Network name space (netns) aware.
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/in.h>
 #include <linux/ip.h>
diff --git a/net/netfilter/ipvs/ip_vs_rr.c b/net/netfilter/ipvs/ip_vs_rr.c
index 6baa34dff9f0..4125ee561cdc 100644
--- a/net/netfilter/ipvs/ip_vs_rr.c
+++ b/net/netfilter/ipvs/ip_vs_rr.c
@@ -14,8 +14,7 @@
  *     Wensong Zhang            :     added any dest with weight=0 is quiesced
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/net/netfilter/ipvs/ip_vs_sched.c b/net/netfilter/ipvs/ip_vs_sched.c
index d4903723be7e..c6e421c4e299 100644
--- a/net/netfilter/ipvs/ip_vs_sched.c
+++ b/net/netfilter/ipvs/ip_vs_sched.c
@@ -12,8 +12,7 @@
  * Changes:
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/spinlock.h>
diff --git a/net/netfilter/ipvs/ip_vs_sed.c b/net/netfilter/ipvs/ip_vs_sed.c
index a46f99a56618..245a323c84cd 100644
--- a/net/netfilter/ipvs/ip_vs_sed.c
+++ b/net/netfilter/ipvs/ip_vs_sed.c
@@ -30,8 +30,7 @@
  *
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/net/netfilter/ipvs/ip_vs_sh.c b/net/netfilter/ipvs/ip_vs_sh.c
index 92e77d7a6b50..0e85e07e23b9 100644
--- a/net/netfilter/ipvs/ip_vs_sh.c
+++ b/net/netfilter/ipvs/ip_vs_sh.c
@@ -32,8 +32,7 @@
  *
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/ip.h>
 #include <linux/slab.h>
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 5a0c6f42bd8f..54dd1514ac45 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -32,8 +32,7 @@
  *					Persistence support, fwmark and time-out.
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/slab.h>
diff --git a/net/netfilter/ipvs/ip_vs_twos.c b/net/netfilter/ipvs/ip_vs_twos.c
index 8d5419edde50..dbb7f5fd4688 100644
--- a/net/netfilter/ipvs/ip_vs_twos.c
+++ b/net/netfilter/ipvs/ip_vs_twos.c
@@ -4,8 +4,7 @@
  * Authors:     Darby Payne <darby.payne@applovin.com>
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/net/netfilter/ipvs/ip_vs_wlc.c b/net/netfilter/ipvs/ip_vs_wlc.c
index 9fa500927c0a..9da445ca09a1 100644
--- a/net/netfilter/ipvs/ip_vs_wlc.c
+++ b/net/netfilter/ipvs/ip_vs_wlc.c
@@ -14,8 +14,7 @@
  *     Wensong Zhang            :     added any dest with weight=0 is quiesced
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/net/netfilter/ipvs/ip_vs_wrr.c b/net/netfilter/ipvs/ip_vs_wrr.c
index 85ce0d04afac..99f09cbf2d9b 100644
--- a/net/netfilter/ipvs/ip_vs_wrr.c
+++ b/net/netfilter/ipvs/ip_vs_wrr.c
@@ -13,8 +13,7 @@
  *                                    with weight 0 when all weights are zero
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 95af252b2939..3162ce3c2640 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -21,8 +21,7 @@
  * - the only place where we can see skb->sk != NULL
  */
 
-#define KMSG_COMPONENT "IPVS"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e388de8dca09..f97f77b041d9 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -16,8 +16,7 @@
  *              based on prototype from Frank Blaschka
  */
 
-#define KMSG_COMPONENT "smc"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "smc: " fmt
 
 #include <linux/module.h>
 #include <linux/socket.h>
-- 
2.51.0


