Return-Path: <netdev+bounces-207974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C377B092DD
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9335A4211E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D202FE387;
	Thu, 17 Jul 2025 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IWuhr0ac"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8754C2FD5B2
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772231; cv=none; b=LhmMqkZ9a/8GhMA4M+45csQq8oI09V3cxsGNWcQW8SV1K4XHqJqSsCtmFh59+NJ7QV9q8VRfys1BMMvSvl1AXoFgoViIYiOaWxyXgYnrttx/6vUfsR5uenVWuRKsAVRkjSnVIZ073msht4dZzDWMUkaSZE+bmdrD0RIkXJ16tKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772231; c=relaxed/simple;
	bh=H5/0qhNfRtIQcPtpcRQ5QirUHLaPsai5PTwqOwbiZz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MySe6KXLBxTi3bzJfgrSX6fwhstBUYE+gK2bxOIlYRptbSgUL/w3/yfQ4ECE5dUbdFcJRlEINzPCGqVGL2GuxAo49ham9/ZaZje5SGqMJ3KfJhER8SJIAHeqk6RQqjEcXIMRlVGvxGtgpK7UmQ/U1/HLFu/RYmo+yV/AGh+w2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IWuhr0ac; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9e664019647;
	Thu, 17 Jul 2025 10:10:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Vh4x0pPGp67ljpFx8eyJ0n6O+
	Ac9ibnppD7wBlRK8as=; b=IWuhr0ac73pRjCF2yWVJVDBta1u9pMNLl4zVunc4A
	DzO0ooZIS+Mcy2PS7jdBBCGVCP5w2yIZz24S4PZBchcPKlkW4CBEEzw1iI7enm+V
	YQd9mVZJS/ZW+/gpJ/xmeDUh3B3CrDD53cKFobR18JjnZEp/6nynVaUxTRIjBUeG
	YFQFkOVqbNGJXj6TVpFrA98VVOz7LKrl3zcPU2W3uULlNJU/oi7qiWB6THNci81q
	YLz8Zzb6QQyCwX0hw3D10HFZy1ACYJrvxoM1jqPMMGcj6zlXQWqPcZT2wqyUhWoO
	47p785G3d6CJ3lTehGfNZqAlnmYZnOCnUN2AmYILhSkjQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47xvpc96um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:10:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Jul 2025 10:10:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Jul 2025 10:10:17 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 125633F7058;
	Thu, 17 Jul 2025 10:10:12 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 10/11] octeontx2-af: Display new bandwidth profiles too in debugfs
Date: Thu, 17 Jul 2025 22:37:42 +0530
Message-ID: <1752772063-6160-11-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=U8ySDfru c=1 sm=1 tr=0 ts=68792e7a cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=RZIP-wGVsQArKk7uDzMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: wwVstKZ0tANE2nbPRNNkHDohWBEkUZL3
X-Proofpoint-ORIG-GUID: wwVstKZ0tANE2nbPRNNkHDohWBEkUZL3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MiBTYWx0ZWRfX/m/uCiIKDDlB YZ8j8zqbgQWyhctIv2pKbc2enTKwar8x7RGO7TRvyGCGeERBBSrfazylA+PIwbiPkg/oCj4ORCS rGuOreqTBUSMYd+0HLznSvBxYr8h7ycUH2egYzqe3lU8XBHRgo+AL2sm3s1fR9FK15FzQ0AXs1u
 wPRFEnSusQlsqBZKjAfKXhVSVBWSD6JUiU7vvMgqP5bb5inousJlJTvacfj4gOtMfb7CcgZOpza 6EJAacPfucnJsdoV+VB6MO/8yCEmcZO0gcax9HYYCb+vdb6uD/cjI2isnTuTMiVKOHsGpuCo1HP 9jmwe0QhVfpulmpEY3ayoS4VhRkuENptWEBIgmPUR85koczOeyGSMMXXGjrH3w5Rs6kRGldtbag
 QyUYQJ0Z4FfpggD2Vxqdt6ZgCQ5t/5F8g23KRGBR79G4YXyma4SBwsPg6Rzuero1uS+fjzqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01

Consider the new profiles of cn20k too while displaying
bandwidth profile contexts in debugfs.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 7243592f0e43..ed502ca0c927 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2056,7 +2056,9 @@ static void print_nix_cn10k_rq_ctx(struct seq_file *m,
 	seq_printf(m, "W1: ipsecd_drop_ena \t\t%d\nW1: chi_ena \t\t\t%d\n\n",
 		   rq_ctx->ipsecd_drop_ena, rq_ctx->chi_ena);
 
-	seq_printf(m, "W2: band_prof_id \t\t%d\n", rq_ctx->band_prof_id);
+	seq_printf(m, "W2: band_prof_id \t\t%d\n",
+		   (u16)rq_ctx->band_prof_id_h << 10 | rq_ctx->band_prof_id);
+
 	seq_printf(m, "W2: policer_ena \t\t%d\n", rq_ctx->policer_ena);
 	seq_printf(m, "W2: spb_sizem1 \t\t\t%d\n", rq_ctx->spb_sizem1);
 	seq_printf(m, "W2: wqe_skip \t\t\t%d\nW2: sqb_ena \t\t\t%d\n",
@@ -2574,7 +2576,10 @@ static void print_band_prof_ctx(struct seq_file *m,
 		(prof->rc_action == 1) ? "DROP" : "RED";
 	seq_printf(m, "W1: rc_action\t\t%s\n", str);
 	seq_printf(m, "W1: meter_algo\t\t%d\n", prof->meter_algo);
-	seq_printf(m, "W1: band_prof_id\t%d\n", prof->band_prof_id);
+
+	seq_printf(m, "W1: band_prof_id\t%d\n",
+		   (u16)prof->band_prof_id_h << 7 | prof->band_prof_id);
+
 	seq_printf(m, "W1: hl_en\t\t%d\n", prof->hl_en);
 
 	seq_printf(m, "W2: ts\t\t\t%lld\n", (u64)prof->ts);
-- 
2.34.1


