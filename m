Return-Path: <netdev+bounces-230977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EDBBF29CD
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 19:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395693A573C
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1607274B5F;
	Mon, 20 Oct 2025 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DoEeg3GZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B8A1C8611
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980172; cv=none; b=XS1aei4xbekxuO7fJ0OMNbisiP0eUVcYR4oB9DgUjilckK4P+jgmB+A1X+KKIXBtrQ/rH+NW1pdO+Ks7weryDCHcmfHqKWuHSDERSP6tNK9/J3WQT5kzGV+H67dmxf/r2A1p0Ti2oAHOeJ2u4i4okv1nN124XDhrgXYDMSZouoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980172; c=relaxed/simple;
	bh=go1by5Ry6lk6J2cr5Y7jodPXuOAEw/2lxnlqfFj5bEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMpEmBndAjhuLYBUgai4+ZCCmMIbOUh/WYrNRnAmJspcqToS7wGgfRLLnLo3ctEQPrOAz7wtkd5CCwrNCOWL8jMdzXwtKU2mB1rDeHQSqUlAaxOBAMgx94JpFODyJUP1N6SnuT+df+McvhRPOOjUtGF3O/jxJdm3P0AQaSWOxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DoEeg3GZ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFk121021398;
	Mon, 20 Oct 2025 17:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=C9G/u0Yyyasi/9GSR/js1vNHyKhH/
	kYBSSBBLRz4P9g=; b=DoEeg3GZwNAfcM1FyFuiAMo4PdBL2VHuuY29M0HyuJYTY
	vulpzumM4KvTsNG6styT2CNNdO3J/+n6FTm+up/TxqeJtcPNYmqAiIKRh8KyaapI
	b2zfYiZmOrqN53G93Rq8wZ6jnmEbicgxptPnGGvfov9LKqfhWYRDaOdS7mY6qKBh
	7+ThpVxt4QFhdUPqA94VYtgkW4+r0pfWQmllcbSTaT/4fKWIGIGBifhu4wlGXPEw
	XNYGyVn9fOPVVbyuw4cmTC5fBwFcViULE/M6W+Xtp/lFUWcO2eYB6kYDjDRdgPmS
	ssr2mhteKxpJcRQUQcNznrwZaIHWFfqZBOzJSxTQQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vvtpue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 17:09:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFn97I025427;
	Mon, 20 Oct 2025 17:09:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bax2n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 17:09:18 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59KH96ol033195;
	Mon, 20 Oct 2025 17:09:18 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49v1bax2mb-1;
	Mon, 20 Oct 2025 17:09:18 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jiri@resnulli.us, jiri@nvidia.com, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, alok.a.tiwari@oracle.com
Cc: alok.a.tiwarilinux@gmail.com
Subject: [PATCH net-next v2] devlink: region: correct port region lookup to use port_ops
Date: Mon, 20 Oct 2025 10:09:13 -0700
Message-ID: <20251020170916.1741808-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510200142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1M5JJe5eKplY
 DN9gzYh0tcR4nWyYHXLDllUOvGBi2KQv17pShh34GkJbDdqNOk2fxUHsY5OabVkStlAgVspn69y
 rra/W2/acUXA0VsNtSeWeBy9/CYaB3myzP+wYN18cNmFm5N7uuhSNevpeeUywL4SeQnc4jHxB//
 OADnT3NqpdrxWA05K2uxlobSSRmkDOjHbS+c8hMQW7wAk3pBWnl/3XWQpXjmGXdWGs48Se9xOeY
 xAcSzTPIHeChKQ9TwK8Fj82Cx9ktU4N9y5n+apuEvK7eQtGRjGXYdmoDCdn5Xe/uVCiASQw5VFu
 KHSvg2kWac/3O5o12czxrCHnc7aNkjRDXcykxFmITGD4i04biSjh2qw4OUR4ohzi6d1IB+WKf1D
 7AdIXjouRKv1s0ABdBGtkhHzBB3rSQ==
X-Proofpoint-ORIG-GUID: qGka3YTbcfSFLPNA37Y33dDh2g08KF59
X-Proofpoint-GUID: qGka3YTbcfSFLPNA37Y33dDh2g08KF59
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68f66cc0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=UfRTzp-lEnWZV1Yto5EA:9 a=cPQSjfK2_nFv0Q5t_7PE:22

The function devlink_port_region_get_by_name() incorrectly uses
region->ops->name to compare the region name. as it is not any critical
impact as ops and port_ops define as union for devlink_region but as per
code logic it should refer port_ops here.

no functional impact as ops and port_ops are part of same union.

Update it to use region->port_ops->name to properly reference
the name of the devlink port region.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
v1 -> v2
fix typo in commit message and added Reviewed-by: Jiri
---
 net/devlink/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/region.c b/net/devlink/region.c
index 63fb297f6d67..d6e5805cf3a0 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -50,7 +50,7 @@ devlink_port_region_get_by_name(struct devlink_port *port,
 	struct devlink_region *region;
 
 	list_for_each_entry(region, &port->region_list, list)
-		if (!strcmp(region->ops->name, region_name))
+		if (!strcmp(region->port_ops->name, region_name))
 			return region;
 
 	return NULL;
-- 
2.50.1


