Return-Path: <netdev+bounces-207228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2103BB064D7
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291A51AA6403
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CC3277C96;
	Tue, 15 Jul 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iejwvZ39"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36062417F8
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598998; cv=none; b=by5SZmSYHdOMs4bkE9rANtdfHR4g//LjbLIUMv9TjYjX73Y0lt2xgIBlz1h40zGEZsY8VFEPLEB4BdJDDSvduaN3ru6US2hZinrwDkRYdlpkjljfCRjdNKrpG5Bs86iwF95WEDNZ48972y9RC7M112rhCHMwdG6ehEhCo5/THnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598998; c=relaxed/simple;
	bh=H5/0qhNfRtIQcPtpcRQ5QirUHLaPsai5PTwqOwbiZz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtaxypBxhGK9mtKh++DWwZmkDCM6i9XDbfzlelRav/kDSZWkGnqe0C0wAl5PN9n26HySCDEziuOE8d4itIjZdEkSBXM8yvyWpnVzN8LEzfWMKtWAzsD8NWdLNXJkXdbFuhdZntgXZFmdJGCr4AxVGV8zDpcMgx8yeYBZjvxYHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iejwvZ39 reason="signature verification failed"; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FBng0f032125;
	Tue, 15 Jul 2025 10:03:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Vh4x0pPGp67ljpFx8eyJ0n6O+
	Ac9ibnppD7wBlRK8as=; b=iejwvZ39oEs4SkMd7621Dcl+XAACdEF6QP48+Sh9l
	pQWDtH2zXSf2xq95EebDW+/VWGzD/kkBFc20SVcl5Zjrm8WNWmilBbCLxxpq2gFh
	tWQJPmfn5XDVbpbTpAmdqOlbLeZ/O2sTY46ok907JOzKENPZqZdh10LAOYK4Bqfi
	u0KSsJdI2Aj5Jssk9+Km8v7t0azV+0oXHu8rr3qnY/wZfRhy/rsyzPH43u+w6PGR
	O/HJIJSh6jXU6b0434/MLraspeMFn6ZDYwW/lRH/jcmtNwXxtzOOvOM7I726SVCn
	DpOh8POj15V/nWynQFL0r1fvj0vaBc/9pqlYczimqwsrQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47wpevgr3t-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:03:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Jul 2025 10:03:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Jul 2025 10:03:06 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id BC52A5B692E;
	Tue, 15 Jul 2025 10:03:02 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, pabeni4redhat.com@mx0b-0016f401.pphosted.com,
        <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v2 10/11] octeontx2-af: Display new bandwidth profiles too in debugfs
Date: Tue, 15 Jul 2025 22:32:03 +0530
Message-ID: <1752598924-32705-11-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1752598924-32705-1-git-send-email-sbhatta@marvell.com>
References: <1752598924-32705-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: I8-eJ2jaiOJhhLQf9cvpP7x_W5HXJduQ
X-Proofpoint-ORIG-GUID: I8-eJ2jaiOJhhLQf9cvpP7x_W5HXJduQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NiBTYWx0ZWRfX5PUoJWZO+ncL nVeuBYfdSCPbHxxJSumzQtKghnPMczrxZFPJh+Rm16jc39AWtLK1uwY1DRQne1lDpxijsxXjV5z CQi2i51Lw/U3rauXty4Utz8kySakdaC+oOEvDHBuq+D3f01RC8O/2ggcf+AWF1fJbTL5x8L8+C0
 5/PfO170nCu8wokAvu0PzAEZx+LWzwOgHwYIv0KU28TggoiHg2skfVaG/hlXrEkga7d9V8B+BOz plieGJztcf6+36IZvup6adyfYUmbqqiYxruHV/j2sQ8oaFtDI//WXbZBu5oMInIEI6XemPF3nRN RShY41Z6LqKhShgoK23Hc/e1PDbJMY4U4ADZz28KYoAnGioq6wSSJt42mFzT7pfXduxajCmYkec
 eWi7583OciOrrgR7dicynfb1DIlfdEBB4HII9ifK9RzEtwMT3zhNEegQxgcOcRn0dz+/X1ss
X-Authority-Analysis: v=2.4 cv=Pav/hjhd c=1 sm=1 tr=0 ts=687689cb cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=RZIP-wGVsQArKk7uDzMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01

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


