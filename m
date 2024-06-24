Return-Path: <netdev+bounces-106059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B019147A3
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8770B22CDD
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8487C137767;
	Mon, 24 Jun 2024 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="id3bcHAx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294D6137760;
	Mon, 24 Jun 2024 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225451; cv=none; b=L/3JThBwbW6LbmHyZn+9pNzTidpfkMd0Xbx+6H/gUFnKQuAAMk3OX6NPsLjStJz8tmgV2WpK0UbkTTvimJyZbqirXOlupbFTxjfAC+6n8BuK4izxsfAuI/RZTIT1xB2sV6B9Xcwmp7ioWBo1yWKcC70SLu7kz+fLdP78Lkk1jps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225451; c=relaxed/simple;
	bh=CGU1QDWJ43M2oPhIs6csvBX3BUAXD5cKzEdP97LkVCI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNO+w7wvUukQd75W+p8JvgQY9bKVu+UvU3Scs4QzjmXOgtPwrR2HkXfkONmgL1b3rSaHYB1vEdyjjX2iOZYBdyYry0RnwRuYF2QSNBDXMisONfUXGzmUUdLXHs3Qk7YdBwbdTc86JxIr2GfZUtbeYkaZp1Gcx44Shf1JFVp0jlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=id3bcHAx; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OARoRK022321;
	Mon, 24 Jun 2024 03:37:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
	kSPZPyYXBBKGIFp7BdKNA4qxQ5UjkS8ZofaFxdyy9w=; b=id3bcHAxABAlK6+1I
	TNCXRgE1MagC2xb2B3ZEbhAH4z36upMrpLQH4z5epJlji0WZTCH+MGePwJUsr8Ld
	LjBGNMTb7FSG1pU4MRBnFJmIcnV4sYqaP+O7NwVZokFukK1/rAPxfdS11X3Yw2UF
	uZgEzNkPIytpnQhPrTdcCwfYmVOM7QQmg58YWtB10V56Y6YvwiJSlVGHCuthLtld
	L/+hOV9NJkY10ve5JKKUa/UW4+E6cNp7/BhFMLGG/Ej5aW/Mm0liMji+7eof3g/n
	temdau7EUHxlpmSC1GIBs/UwXxz+GzStzBG50bYk1b5wjEDAeSeJf3M+WpiySRfO
	gjjvg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yy72f00v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 03:37:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 03:37:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 03:37:23 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id EBDF73F7077;
	Mon, 24 Jun 2024 03:37:19 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH 7/7] octeontx2-af: Fix klockwork issue in rvu_npc.c
Date: Mon, 24 Jun 2024 16:06:38 +0530
Message-ID: <20240624103638.2087821-8-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624103638.2087821-1-sumang@marvell.com>
References: <20240624103638.2087821-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Fbqnz4JDvStzsYQpK6EMeXaXcwZVwmaj
X-Proofpoint-GUID: Fbqnz4JDvStzsYQpK6EMeXaXcwZVwmaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-24_01,2024-05-17_01

These are not real issues but sanity checks.

Fixes: 5d16250b6059 ("octeontx2-af: load NPC profile via firmware database")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 97722ce8c4cb..a69438921a8e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1765,6 +1765,7 @@ static void npc_load_kpu_profile(struct rvu *rvu)
 				rvu->kpu_prfl_addr = NULL;
 			} else {
 				kfree(rvu->kpu_fwdata);
+				rvu->kpu_fwdata = NULL;
 			}
 			rvu->kpu_fwdata = NULL;
 			rvu->kpu_fwdata_sz = 0;
-- 
2.25.1


