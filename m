Return-Path: <netdev+bounces-228699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2AFBD26C2
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 12:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89D394EACA7
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 10:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37202FD7BC;
	Mon, 13 Oct 2025 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rgim7a8c"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450352222C0
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349702; cv=none; b=Ej86pegW2JblBgTCfHlfrLAIUtqN+U2+xIt5d45VFrffgeNspm+kXrrRR0f7dowFOJq551hN/MCA70BSyNMK/3lmUnzYBuRYsacCiNL36Z+MYuVDWbaFTUSaim5dZBLyFeAdLwssxlUfKsR1u/bGxFGyI56F/+ey7H/QH3N8afs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349702; c=relaxed/simple;
	bh=/zdJXVFTAP0rj7Un0FncCHRVdbesmAVrUUjkLHMoUo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dLR3XbE0vY2iCYp6zCSMz2quHXzCSnTBzTmbAiP+iRd5MiAESXU2Kt/4baR06robSEgMnBXyVbi84kCOLy141KZuDigZoSrBUZwy+LczZdMTF9IQBac52DmvHCHfTTCxWcItEEBnZYh79KhtfhpsJI1bx2fmMOzS0NWWolE6sAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rgim7a8c; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D7uVUR019185;
	Mon, 13 Oct 2025 10:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ppB0pofodMEoaF2947nwe6O/II/zm
	V5RcebdR6t19+8=; b=rgim7a8cKV1Tk6vrZdO9VJK+cDE3cQ7HPUkRxwSm2HAd0
	NantyIl2GQtwt1qyXAglCAWiCXGurADdywY1YTGj3186K5TwkNoKwJWaEPbMg9Vo
	fwyxON40o1s5+9zmNDBeY119zapxr40zFjGL04eVo2jHFBFsrUWN7NS/El4XtNqp
	dO3FvcEAKCa03N3iL5/uINJ3L1anBjAyFJwJIN2pAtF74s5dzoeIck0jOCcZweov
	6XovzMfi3RDZA4k3Rb6XUvzl4WPNt6Iz2wMKGTa0q6Ou1f/BuhDV3jQOuRAUIf5L
	Y2Z2RMq+WQ4wXHO/bBUS58gGwAA8bbkcXPoEsC4bQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1q90sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 10:01:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59D92kvu026300;
	Mon, 13 Oct 2025 10:01:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp737vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 10:01:25 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59DA1O5C004981;
	Mon, 13 Oct 2025 10:01:24 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49qdp737ty-1;
	Mon, 13 Oct 2025 10:01:24 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: idosch@nvidia.com, razor@blackwall.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, bridge@lists.linux.dev, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] net: bridge: correct debug message function name in br_fill_ifinfo
Date: Mon, 13 Oct 2025 03:01:16 -0700
Message-ID: <20251013100121.755899-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510130046
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfXzVXbMS2smh7x
 7+vK+8mOoWtIFNqIvJvOxXBVmDTA7OyrQJFmLMgGsgB3nVwZMOZYKhYEo5f+SVGKZxw/1YGLXKF
 uvd4NzJaB5WW2P2eBU7rPb5rizxc+oVXWpXzYyuZHTPYvHO7dOFYuxtlkJ4nfJil2rdx9IFmWgw
 fss8bO0g07WZX5M6ZPTwhotsx0eH2uDX6U5DR/U+qMybEWcA7ewqDSWATsIb1fpHCrPonqiuTva
 V/V1zzxtMpvZ1DYW+80aalC/NaV4mnyVv/QZgYarH6NIfFK4eLoPdvgtFNJH3gbQWwZNgG5HPQ/
 eGA6nE9xFZNedhdLOx4bS0ytUPhvzvwfYmzXMU6OTXN9d8kO4Yw0YGuu5HdZkIEvBLh5QuEwVAi
 WdChwES0L7FiZGExd175bDf40J3J1K2SfCUDNvT4i98sTJwMuKI=
X-Proofpoint-GUID: 2GGuzYTQmhMJ-nX8VFdWKUhP0KRE3I4I
X-Proofpoint-ORIG-GUID: 2GGuzYTQmhMJ-nX8VFdWKUhP0KRE3I4I
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68eccdf6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=wHK_iL5GPdzSbBCK7koA:9 cc=ntf
 awl=host:13624

The debug message in br_fill_ifinfo() incorrectly refers to br_fill_info
instead of the actual function name. Update it for clarity in debugging
output.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 net/bridge/br_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 4e2d53b27221..0264730938f4 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -467,7 +467,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 	else
 		br = netdev_priv(dev);
 
-	br_debug(br, "br_fill_info event %d port %s master %s\n",
+	br_debug(br, "br_fill_ifinfo event %d port %s master %s\n",
 		     event, dev->name, br->dev->name);
 
 	nlh = nlmsg_put(skb, pid, seq, event, sizeof(*hdr), flags);
-- 
2.50.1


