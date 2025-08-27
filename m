Return-Path: <netdev+bounces-217426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A0CB38A32
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650AF3A4838
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E932E7F30;
	Wed, 27 Aug 2025 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n9F0PtY5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CA678F3A
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756322823; cv=none; b=rIHvqOoWlcsvKc2UcIcJ/fv0JsBbki0rosX4k9G+CVzka2nsCqh5peQGybJ6GNV4+WVw97v1i0ubLaYdKHU5oTs/HQwhHr+W8I7VdWQaCrcNYfOimP1Bls/qc6EQPkc4J9f4ZBStAbCmqEoImmOGhNvRPnSYO0Pxwo95Ur9YzoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756322823; c=relaxed/simple;
	bh=QcpqAbnTqfxHsRcjcPpQnxx6enlS0d0Wo0k3ovoUYBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUEVNKsIbgCd8VFyN4+k/0LavpYqry0k3fDRjwgEmGreMWHkdGzLakdfU0uGsmKE9a6ob/rmMbCtc7PkSgV/FdXDvAMLABcHXNM1VOC7odemuvhgaUih9njl9tH0UoFSNBHJ5WDgh3u+tQfDNe62tpS/YTtXGc82z5TS3is7Wao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n9F0PtY5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RJCbho022054;
	Wed, 27 Aug 2025 19:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=iM+BXoLDrhbWUODrI0/Dg7hs1YMdc
	nmX57YS1dkaVmM=; b=n9F0PtY5x9pXL6HWGyUM5zNN++5JupM57c2ktTv2PpvU9
	+DyPW5kT2U//ox3vyfs7h3ob0tIgMjWUgrjPorB8swpkCkA/vWLkTzgdCq3obJu6
	GZyq401jisuqUT7uiv/ct3E6Px9q1IxC40uU8zqAuyOWXibKkTtBq8OjTHbMYp5W
	LeNCRNk1B71DD7xzU1CM58J1a9z+QppUyhjA5H2z+Ny5wWfGqYIWys0rKuhVDkQS
	F/cx+6elStXmtV/ZF9+alh7ghwxJSaP9kik33SrlBJ30TWCdhREowood6gwQTj4f
	dqvcav9k14kUV+heTkvGCjIu/KOpV6eUxBjgzVhPg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e278gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 19:26:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RHo3U8005057;
	Wed, 27 Aug 2025 19:26:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43b65sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 19:26:50 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57RJQolL028974;
	Wed, 27 Aug 2025 19:26:50 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48q43b65sa-1;
	Wed, 27 Aug 2025 19:26:50 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net] xirc2ps_cs: fix register access when enabling FullDuplex
Date: Wed, 27 Aug 2025 12:26:43 -0700
Message-ID: <20250827192645.658496-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270166
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX6dp1dFECcI5P
 5z4hUXnfytgjQPkM1nrTUH2eraByL8CtcVid38bLpXg3KoVjVy6to8E9vzIBPk3Y2E2pWJsDi5e
 Pv8kPq6a8dhGFzBnIffhZTSbdug0vOEvpFBnD5A5a0KWUZXNGosSZlWhpO2LqbaHZAnDGyoVGcx
 gpoVnVedbOlyK/8K/O1+Jptln+bOeafdGx3UeagvytGhIXubssjImSX5KlhYJmU+wpSNUArS+xV
 1rg0Hi670B0IaMNXwU6gQFw7ZMeCXa0KEh9VyiWUEprTNk67aQcTNJROQGcmMMqexnY2hYqRd5r
 Ovd1BMjVZmOiru9huNHTPVSWVhJv3dIhe2NbMLZMkOEsjMUWVhIwOm5qsM1ObORVWlCX6JvQweC
 SuSP/nPA
X-Proofpoint-ORIG-GUID: -xIsqNf5iy2iTmF3O7zacHD-JyNno30s
X-Proofpoint-GUID: -xIsqNf5iy2iTmF3O7zacHD-JyNno30s
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68af5bfb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=FubU-Gr50uYrcFs4EBUA:9

The current code incorrectly passes (XIRCREG1_ECR | FullDuplex) as
the register address to GetByte(), instead of fetching the register
value and OR-ing it with FullDuplex. This results in an invalid
register access.

Fix it by reading XIRCREG1_ECR first, then or-ing with FullDuplex
before writing it back.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
This patch is untested due to hardware limitations.
If the Fixes tag is not required, it can be removed.
---
 drivers/net/ethernet/xircom/xirc2ps_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xircom/xirc2ps_cs.c b/drivers/net/ethernet/xircom/xirc2ps_cs.c
index a31d5d5e6593..97e88886253f 100644
--- a/drivers/net/ethernet/xircom/xirc2ps_cs.c
+++ b/drivers/net/ethernet/xircom/xirc2ps_cs.c
@@ -1576,7 +1576,7 @@ do_reset(struct net_device *dev, int full)
 	    msleep(40);			/* wait 40 msec to let it complete */
 	}
 	if (full_duplex)
-	    PutByte(XIRCREG1_ECR, GetByte(XIRCREG1_ECR | FullDuplex));
+	    PutByte(XIRCREG1_ECR, GetByte(XIRCREG1_ECR) | FullDuplex);
     } else {  /* No MII */
 	SelectPage(0);
 	value = GetByte(XIRCREG_ESR);	 /* read the ESR */
-- 
2.50.1


