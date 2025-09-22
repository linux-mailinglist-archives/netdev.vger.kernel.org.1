Return-Path: <netdev+bounces-225417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233B0B938FB
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2EAF447F52
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF0326E708;
	Mon, 22 Sep 2025 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HQl757o1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E13EA8D
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583207; cv=none; b=by7d2m2XsF6Z1n1IhAqagpWlhiQfHdT6EJU2opNOgYbppCcDpas5c9cuVCiW35Xf1gxRL07/RJqueSIS/eR1cNt/e/B90xQIefghK2lGOm8EhywClBOKUioW5ghverdQVI9+06MPyU39ExyvJ/RDmcSjReFPEaxhcVuoNAmA7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583207; c=relaxed/simple;
	bh=8JYsolQV8+WxGROUSnVohRT4frDKDcRgEtMSZII8Gfs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IaoCujo/mjzppslpeWbbN7wlizaSR8CPT1tFeSp4cz9fwNQI77c7qRvPG8wtPqSwLRlItpSljtJzD31YLmVBfVFQyZBSRDo0/7tMDWkut+0nf+UsgzQQKzgqQ2nAzK2f8T8LoMs8tjHm5VctmxRVo3xzr0pMNzS7AJDyzA5wREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HQl757o1; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58MJ683e3845103;
	Mon, 22 Sep 2025 16:19:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=2kJl7iipR9Glfv1MKp
	FRMCR4Wgd971sZ4g4GoPXRdz8=; b=HQl757o173fCBKx5omFJ0pze8n2r2IYngV
	aps0QPInTyjHJPI+pMJUfvTKpJ/W1feR+uYX8Sf05iI03LLUD011cH+xbUH38YGs
	9AM+T7pB8apYYy3m5MnYr8fAgPgWCPe+eD6sy/eXiRDLfahM9TTcFhTrlJ8q4v1x
	TYIfdGEDY1OBDJVMGpg9XFJIJE5jdSTpiypvy+Uai5bA68HKd/b3+pUC+2qjHSna
	LKJaxiKcypXt1ryeZgYgEMxKYATbUDinefsGrE+FchzuobHf8sSmGrOzlH+5eZwS
	QsXD7yLpZYpGXwNotmpjT36cRYTqowdDOujKSgHVfVzkEOXpywsg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49bav1jm9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 22 Sep 2025 16:19:39 -0700 (PDT)
Received: from devvm31871.cln0.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 22 Sep 2025 23:19:38 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        Jakub Kicinski <kuba@kernel.org>
CC: Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric
 Dumazet <edumazet@google.com>,
        Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net] net: ethtool: tsconfig: set command must provide a reply
Date: Mon, 22 Sep 2025 16:19:24 -0700
Message-ID: <20250922231924.2769571-1-vadfed@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QMtoRhLL c=1 sm=1 tr=0 ts=68d1d98b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=yJojWOMRYYMA:10 a=VabnemYjAAAA:8 a=CYwhSE0vfx3Pr_cQCEwA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: OrT7HaSHstvJVli8iacHrpcineUJDgsf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDIyNiBTYWx0ZWRfX+aFLL8H3wKML
 h6ZPHaoMYpdy7vUDQYPEy3shLbm+x2w7AlAMcvf+WAa1/RAjkPvk2YICJXSqy+1A7vjdoXY5e0P
 XoNK4fCyyGRUWfffsfls5UyVjHS/fOUKmJtTy1ABWb74Dou+jcJw63pIMqyt7D+iico/qsQAmAL
 oLrU0Bkw9hpeEkGDDcyOZyINvgpEKZwuAzEUedxVljMqOeuMxgqX7mCvoZN5bc1MpBAl03iIg1q
 EFcjEWy6+yp92WZLc+yqYyUfd4JJDHhr9biKxnkStFjkb+r0o0FWX6um9gZ8V6BedSkp2RF58Jz
 jTgbQ/UBOOV5FRWKF6la3VOlM13Kfmo0jqZg1Hzj/z5Yi8N+TXIWflQdW5pt7E=
X-Proofpoint-GUID: OrT7HaSHstvJVli8iacHrpcineUJDgsf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01

Timestamping configuration through ethtool has inconsistent behavior of
skipping the reply for set command if configuration was not changed. Fix
it be providing reply in any case.

Fixes: 6e9e2eed4f39d ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 net/ethtool/tsconfig.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index 2be356bdfe873..169b413b31fc5 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -423,13 +423,11 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 			return ret;
 	}
 
-	if (hwprov_mod || config_mod) {
-		ret = tsconfig_send_reply(dev, info);
-		if (ret && ret != -EOPNOTSUPP) {
-			NL_SET_ERR_MSG(info->extack,
-				       "error while reading the new configuration set");
-			return ret;
-		}
+	ret = tsconfig_send_reply(dev, info);
+	if (ret && ret != -EOPNOTSUPP) {
+		NL_SET_ERR_MSG(info->extack,
+			       "error while reading the new configuration set");
+		return ret;
 	}
 
 	/* tsconfig has no notification */
-- 
2.47.3


