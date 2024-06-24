Return-Path: <netdev+bounces-106058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9E79147A1
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCD61C232AC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBB9137750;
	Mon, 24 Jun 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TewndWyE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FCB137742;
	Mon, 24 Jun 2024 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225445; cv=none; b=NrsOT+CB/oWTbsD8GzmuYazJvZq+A5i1qoXaFHIkZaaHZ2TbslGU9MdjK5OhzDwJaxIPicytUw5dZc7jwmj+8rfzJmzWWbTedN0gl6Rgh2WaX2d4AxvTi0Qnf8UdkEAPiowHMAdhaySvUlGWBsOiq63pOBE8G9J8G6e/Je9spIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225445; c=relaxed/simple;
	bh=JzOAxrvnDCro6ZKATyZ6sXjEYK2nMcJJWQc6rGq+ao0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvoUuZRfXtil6v1BnA8lO5HIkZZLkjhfcRuH3bn63LCxpwXRLj148hWapwulYYRtUFIe5u2rxFg5ONbmuOmmblDtqqiH31PgK4xqb3MAPiJr0Z99PsaVwb5uOGtgf+l2QLGO1ugjddLkyZAdS/7S5WzTDEmPXJm5gG583qZQ+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TewndWyE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OARDOR022070;
	Mon, 24 Jun 2024 03:37:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
	6ZgSlapbPS4lQlMstbCCO/YB/W8/coa4qYjkTwj3tg=; b=TewndWyE4iVoBA253
	wuOeuFm7UeTaG2xjEsbiRkg/gb18HsD4KRFQQyIjP29aThjVSe3cbf6hwjltOxy+
	OZ3/UUilVxRfJWzF+6kPQngjU9bERt2p9cwapEbcJoBEc1Purto9bsqPwwtZxw8p
	tlU/tkFNcYsMEzHbrmCWDXeXMJ3n875tSelnwMbCeSOsS0Dmpp9p/XeNC9Lq8k38
	TcHZTfBHuQEvSfrsSjIJimv3D8FZ3NIAQqDhDYkBnb1PX1bY1uLY1syNNsLEpZmc
	njxeh/hmeUdeS1fqJywoOl2sZSyo+n5hDUdeHVYx02hTPRvqeTn0ofe4E0qJ3LCy
	EOF1A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yy72f00us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 03:37:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 03:37:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 03:37:17 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 869083F7079;
	Mon, 24 Jun 2024 03:37:13 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH 6/7] octeontx2-af: Fix klockwork issue in rvu_nix.c
Date: Mon, 24 Jun 2024 16:06:37 +0530
Message-ID: <20240624103638.2087821-7-sumang@marvell.com>
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
X-Proofpoint-ORIG-GUID: abERue6nrrPh4FPYqDtwR9ae7ZvTxlqz
X-Proofpoint-GUID: abERue6nrrPh4FPYqDtwR9ae7ZvTxlqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-24_01,2024-05-17_01

These are not real issues but sanity checks.

Fixes: 4b5a3ab17c6c ("octeontx2-af: Hardware configuration for inline IPsec")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 00af8888e329..0c59295eaf9d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5375,7 +5375,7 @@ static void nix_inline_ipsec_cfg(struct rvu *rvu, struct nix_inline_ipsec_cfg *r
 				 int blkaddr)
 {
 	u8 cpt_idx, cpt_blkaddr;
-	u64 val;
+	u64 val = 0;
 
 	cpt_idx = (blkaddr == BLKADDR_NIX0) ? 0 : 1;
 	if (req->enable) {
-- 
2.25.1


