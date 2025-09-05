Return-Path: <netdev+bounces-220233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E7BB44DC1
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 07:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A29567886
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 05:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC39279335;
	Fri,  5 Sep 2025 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k+2M1dSY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0610A1E
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051979; cv=none; b=D7NTQ/G97+mPEvLvDhiVY0RcKTtJlFqLffN8MaDGf+FhJ/6h6DtzPcQkKlO37ZMohOA69bJzdtLXcKB2fjkubA/GgiPYyhODL52c+Mmj9RuBQeTTJtMnSF299GORsc2e/joAOB6V3ePvgvTg7vPDF1QO/IBgF4U51XDxaJKQa68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051979; c=relaxed/simple;
	bh=Anxw3wclbtDzd3mK5N6VZfo1Qbpc6hU3js2s8YCa0KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lKMODhZ3pLQ3EPngvQn1ZKQXuvlkaRMMXj9XihvTOCIYQqhPG7S6r0B9bxLUbEvW15LJT2joeQmquW+C7jjEAbXwTfE4V+PIzd38emt3B9g+uEWM3DkJ6tovLtaaa6WYAcjeWMRxcXkrwwkrd9BiVGJA41YXaFed5ay94sk2ywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k+2M1dSY; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5855tuoA008919;
	Fri, 5 Sep 2025 05:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Rp8vg1KEvf+qfoZMJLIT8T6PkY2q/
	2fx87Xix4MNuzw=; b=k+2M1dSYIt8UwtO+jC6FPcIVX8+KX0NPjtXjy0hV2/eZu
	gQqHVYJ4x9cjv2mYP2tUrQzRpw6WZ2Sk/GE3oqLl8wiFaq2OAFmb39TPocR9AOdH
	u0d/eFgvElMwDtUfKv4vnNn6hav7bitpG3uZUSy0EkddaZSN73TkizDOpqVo3xLx
	/stOzPMvfg2Dce3J3iadvs4Ab5KJrkp+sJNVnyymkgfGyQBh7y2xMrV0UjWeI6Zz
	N1emmrID8jquf+HGM06hluAmbRRqiCktvTNnlskCiGAgnJuxyNvg/lcISF5pZEK0
	2J0iCjWZ5omy8GRiwZS64/36QW2kdfxI/He3kwslg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yt4kr05j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 05:59:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5854TGIA036227;
	Fri, 5 Sep 2025 05:59:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcem22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 05:59:30 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5855xTVL009289;
	Fri, 5 Sep 2025 05:59:29 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcem1h-1;
	Fri, 05 Sep 2025 05:59:29 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH v2 net-next] udp_tunnel: use netdev_warn() instead of netdev_WARN()
Date: Thu,  4 Sep 2025 22:59:22 -0700
Message-ID: <20250905055927.2994625-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050056
X-Proofpoint-ORIG-GUID: vCKMi_KfYlkC3ei9XJkTu5L5tpVnt_8f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDA1NiBTYWx0ZWRfX1ERLz0Roxub0
 5YRAw+/czEgKnE6gVBzflcONsDFB/JEUENornby6SID0UpRS4Hc/RtTUa3WuHsNUehez4wLc4TU
 GdhAYhEKIWlqos3EyE/pFN+LEEAOdft1LXCqDKYz3tm7Z/U2LFGphq0+kaWm7eTpl6AsL9h8K1N
 aCAaqEeaLmIwmfQtZbrjzgYVDQt6FudJJILMIkHjiSCqPO9bbkWIJQf3wV504dO5u3ABJvYY1XT
 dOdXfmjX+siGI446Yq4/6LSNL19T+2ToKCw4AW3gwBSNC6lViofYL58S5W31x5UXTeWMjfNJ+Jk
 VUU0gHLRhd6cPSRuD4ux+ksYD+VjJiMINWtsr0F5VJvx95SPGbqrNmq8WQbUG5HoLX/zhVwTOF8
 o1jNRqlw
X-Authority-Analysis: v=2.4 cv=btxMBFai c=1 sm=1 tr=0 ts=68ba7c43 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=cSIRN-z-uJ5EfsQj34QA:9
X-Proofpoint-GUID: vCKMi_KfYlkC3ei9XJkTu5L5tpVnt_8f

netdev_WARN() uses WARN/WARN_ON to print a backtrace along with
file and line information. In this case, udp_tunnel_nic_register()
returning an error is just a failed operation, not a kernel bug.

A simple warning message is sufficient, so use netdev_warn()
instead of netdev_WARN().

The netdev_WARN use was a typo/misuse.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
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


