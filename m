Return-Path: <netdev+bounces-187134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8092AA525B
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93DE3A6FE6
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338718641;
	Wed, 30 Apr 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SJduNDtg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D3AB674
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746032647; cv=none; b=N+iiLu0THqeFDm8OAFmqyFTKTc/i646ErSOiYjkkIs8DvA4BneEfl0cdJESQGrwIRs0FUHBZTLIRHudRmMiNtSbJyg2paHCmO7J1RJEppwnybHAnvcfxcUpiOBPXZHHri5mii2cvH5BfE1dd5p1HM+IHdSDmNOYzgq5KnbOqzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746032647; c=relaxed/simple;
	bh=YZO3E9AsFY+QqbcA3/kZPd7pDePkBOnC+lkEm6F5+Z4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cVLN48tmavzQQ5SWdyOhgSN2kjqbSND5dfaJXm4VgrAadd/Ihj9D1NKwrq522UwikWSnOaKnEk2Fisk9QpyWVMx0FXLy7ShYl5mcfgV1OviXbarNaXuh/Ilv7R/pTWd+FpsaRsPH3lnIOnAP+nTNNKGqi6WyDZSr9LOCMHiFZJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SJduNDtg; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UGSmIi011522;
	Wed, 30 Apr 2025 10:03:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=srB/Zo2Wh4OIEHPRt0
	uL0W3NMGjc3ajCFpcPm51w17k=; b=SJduNDtg3J5EpnSH+tsmgr15TZJWij/yji
	asGjVULonK98+4Klgzt82Npi8HLxAvYMbYY7l66ATOG4AjcROpUcVUcVGEipCnFY
	Lm1VjQt2rYwhoNzbd6sIBXlOcOW/a5lGvqyt1rMnjPjwmguL/HcrqoGMSVn6EU3P
	LrKxRaN9qvRlIE9eI/LWFT1mqTkhwQfT0mMbUhytoikye0H6XAGanAAoS1WBIwDd
	/+QFOMyg54fr5olWwVKqM+Z/0ELLRZ/83v9txpyKLodkqqj9fErB4nXU7yOFfamq
	uhz14hoFkXemQnjupKNvxTYsyymZ0KH2g3DOPgnAkKtDVQgUsSUw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46bgr63j4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 30 Apr 2025 10:03:59 -0700 (PDT)
Received: from devvm31871.cln0.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 30 Apr 2025 17:03:56 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Michael Chan
	<michael.chan@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Jakub
 Kicinski <kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>,
        Taehee Yoo
	<ap420073@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net] bnxt_en: fix module unload sequence
Date: Wed, 30 Apr 2025 10:03:43 -0700
Message-ID: <20250430170343.759126-1-vadfed@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=WesMa1hX c=1 sm=1 tr=0 ts=681257ff cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=5KUBzR2mnxRsGDPJcH4A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEyMyBTYWx0ZWRfX8RunBnce6P43 pAFxC8luZpoYOPLgzz0v0pSSw01x1E9bFk+ibIAxO9x/T44fXQznji4ko+guU87s+IQ+qBnQhxq 894PpDhawLK81ZoSU1VTBy8Hmw5APb5SXoMs+swz2VNaR4IRc0+0QI4eof4wkeOc0AZ3j/usmEG
 9SRbIyGf6hx2hJKAHWy2h1Z/FkbHVVbpI3yqeh+0HNIqY54M81CblSVEpvBi9exxKaJThhq97Dd v2YnpIi2mANpTiv059l/2kxosiDw4XqgIRuCqFnN/7TkTvGAjD+38Z52WTrrSxuMggK+U+Ph9f6 kQBSP4UUeBGs/+IeK+7KAHWPjNWZRuL9enJxKnR6VlqgXIJuUjfZLBFS1xQnje5gA19GqXzKnkD
 V8mMjlHOpxM+/BQV1Wryw2HPbWDG7OcKklncgzGcd6Z9wxIYk2X6aiWVXApZguJ3hMcnW8/p
X-Proofpoint-ORIG-GUID: Xi3IJyrO_EFVUwoXlRkQMraV3wlEUGIZ
X-Proofpoint-GUID: Xi3IJyrO_EFVUwoXlRkQMraV3wlEUGIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_05,2025-04-24_02,2025-02-21_01

Recent updates to the PTP part of bnxt changed the way PTP FIFO is
cleared, skbs waiting for TX timestamps are now cleared during
ndo_close() call. To do clearing procedure, the ptp structure must
exist and point to a valid address. Module destroy sequence had ptp
clear code running before netdev close causing invalid memory access and
kernel crash. Change the sequence to destroy ptp structure after device
close.

Fixes: 8f7ae5a85137 ("bnxt_en: improve TX timestamping FIFO configuration")
Reported-by: Taehee Yoo <ap420073@gmail.com>
Closes: https://lore.kernel.org/netdev/CAMArcTWDe2cd41=ub=zzvYifaYcYv-N-csxfqxUvejy_L0D6UQ@mail.gmail.com/
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 78e496b0ec26..86a5de44b6f3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16006,8 +16006,8 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 
 	bnxt_rdma_aux_device_del(bp);
 
-	bnxt_ptp_clear(bp);
 	unregister_netdev(dev);
+	bnxt_ptp_clear(bp);
 
 	bnxt_rdma_aux_device_uninit(bp);
 
-- 
2.47.1


