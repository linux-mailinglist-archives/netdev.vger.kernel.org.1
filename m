Return-Path: <netdev+bounces-110510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7748092CC42
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F981C23011
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 07:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75CF84D37;
	Wed, 10 Jul 2024 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cDI2ka7l"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC6F84A35;
	Wed, 10 Jul 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597974; cv=none; b=scmRdzcCEXxyPMNGN+LviVV10/DClWXQmjoQ4AHc4TRrKjUbJLs7F1vkX+n2dv+afnekoW2xoA44L3lwsapo8VNL+jKnrHE8rWUsTZvEbYTbQ9Kr/S4CHHvPOG6oRNKX03P1j+vPAU/JT7fsMj66vZkp/tAH3nu/m1C3eIi0XHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597974; c=relaxed/simple;
	bh=eIVbos2XD4Je6J+mf78B3iFFLsBdefQ6yifI0hbuD5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVP1+PbGNGJFllzmOEatOkIfRl6pTeDWlYcVmzls5UWyrGZHnP2KHsp1YCr4X8ALre5KyvZjNmD79hEr2rsGK51wn3kxbFeaSymtKJm+/c0CmSABWAa7ep3eH/9SyBtS+SEHOjeDRdaTk4GG/YBOxGf/W6V939xrv498yxi5cBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cDI2ka7l; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469MQ88G022710;
	Wed, 10 Jul 2024 00:52:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
	S4YU6KdoF8N9+LP2mHo9d//wu3XtoCeyxcLahOE++s=; b=cDI2ka7lflnbfDtit
	9hVD/8+o6SHcNHKXK68Yi800ZGupVwgNoi8Fc+S9pFaqa/oqiJmLU6YoDhM0UhRp
	WGKwZZBI6OCVSXNo5aOPeC2BlJKFt0v2sIZIrkLkaC9ki1jfGMT7U5xPWrVEJnXD
	S1xPAPqdBfffvvc4bGt7BA/BMaoosarxNpnN8lBUUMqkN3BysMn4MpzlMwI3NEBx
	KDyJKj56kZcma8Tt/dPjZcRN8BWt9Po6ucd7bHZGRTAxIcrDUgAFyrbOUeyJn/cn
	r0RaQSw7CBfaV4G3lMfbRwDgp2WzAxkRNwlM39PhZzU2u0MGwGZ8D1WNhM8oYi6s
	yM8kQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 409e061p0j-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 00:52:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Jul 2024 00:51:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 10 Jul 2024 00:51:41 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 020573F7053;
	Wed, 10 Jul 2024 00:51:36 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <ndabilpuram@marvell.com>,
        <schalla@marvell.com>
Subject: [PATCH net,v2,2/5] octeontx2-af: fix a issue with cpt_lf_alloc mailbox
Date: Wed, 10 Jul 2024 13:21:24 +0530
Message-ID: <20240710075127.2274582-3-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240710075127.2274582-1-schalla@marvell.com>
References: <20240710075127.2274582-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 09NRuJwtDUXMw5gTKtX-LlYFXp5KOpXo
X-Proofpoint-GUID: 09NRuJwtDUXMw5gTKtX-LlYFXp5KOpXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_04,2024-07-09_01,2024-05-17_01

This patch fixes CPT_LF_ALLOC mailbox error due to
incompatible mailbox message format. Specifically, it
corrects the `blkaddr` field type from `int` to `u8`.

Fixes: de2854c87c64 ("octeontx2-af: Mailbox changes for 98xx CPT block")
Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 4a77f6fe2622..05b84581d5c5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1745,7 +1745,7 @@ struct cpt_lf_alloc_req_msg {
 	u16 nix_pf_func;
 	u16 sso_pf_func;
 	u16 eng_grpmsk;
-	int blkaddr;
+	u8 blkaddr;
 	u8 ctx_ilen_valid : 1;
 	u8 ctx_ilen : 7;
 };
-- 
2.25.1


