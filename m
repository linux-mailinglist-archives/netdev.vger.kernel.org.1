Return-Path: <netdev+bounces-203294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C9AF1343
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0425A1C40796
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D3C2673AF;
	Wed,  2 Jul 2025 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IvhPlfBp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BF825D219;
	Wed,  2 Jul 2025 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454374; cv=none; b=irFtYN/Ch8u66DipR1a5nbWuRpWZiqDd/gNtaXlafAEzDl1PIPD14dP5/w+8Ig6b5NjNiWhGw0IIhsv7xxGzLi0xWk5KniNNC8ROJAXPNquO9YL0e62t4up1zn92gIkiECiqoKj+rhBtlnel1ooAl1zHZa9hL3LuQgzLNTAQxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454374; c=relaxed/simple;
	bh=Eez1dR8Ja0WCksBqGOS9F6pQVdzXRglmE+Ms+VEMiyA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OWmc9zm6WHpPIgjTffW3I6COVM5tqqQfvGgo5SvvxHgqZDMgxU2cx8W2dlUwh8oOSvcRVoEo+80f5B60wJUgckkhcVV9/ZIu4x/sJm3VGNzRnCZVZV7UwmIjySwrHmYnts2y6YRYMaCu8lIsKxmWhONiLHAzbDn58LdmBG/KtUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IvhPlfBp; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5629RIiN025991;
	Wed, 2 Jul 2025 04:05:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=bC0WdFWQhpiy7p5SL6ixF74
	LH4LZWzWGEM3UCiZ/vxA=; b=IvhPlfBpW+K3S6XaR+Erit3lw7p1vmYjjIydCMr
	VI6r4HHKetPrrwLvZgPZbhgwIearIg20h9MHHrT6WpVzIqkMmFKLWH4V3plbDRvW
	pcQnCoR8CSfRFTg1SGjmT2BNVwlxLOBNhTAktbC8soPKrjy+b6a2O9sK9MnXSezJ
	ToFexZBjAmyrLqDYh2qoZe6oHoMlnwSXKqJS5Cyu0N2XQVutBNdO5kGjG7MBBegM
	45gA8iLaDV/pFimjZH3Nc2+98hUv+Y7yrCtYLp/FX/+AVr6/uuaVHA0HSOysCFRU
	XmEQWlNgBMi5srBlgvTO7u6Iz6Dd+UEVGt0S8pxPdILG8DA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47mscq16h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 04:05:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 2 Jul 2025 04:05:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 2 Jul 2025 04:05:49 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id CEE555B692A;
	Wed,  2 Jul 2025 04:05:45 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Tomasz Duszynski
	<tduszynski@marvell.com>
Subject: [net] Octeontx2-vf: Fix max packet length errors
Date: Wed, 2 Jul 2025 16:35:18 +0530
Message-ID: <20250702110518.631532-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wJJl6SlSnkd-Ld5lkG7ovL8M0nnxGp9z
X-Authority-Analysis: v=2.4 cv=L98dQ/T8 c=1 sm=1 tr=0 ts=6865128f cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=Jid5xGn13soyQvd6F5IA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: wJJl6SlSnkd-Ld5lkG7ovL8M0nnxGp9z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5MCBTYWx0ZWRfX2XddZHyjGKh3 W2jyk4erqzaZqKsY6x5MOOY03gfudf4gmDZXB3Gmxs0OMEly48RdP26lIE0A6k+GnAW3AAQNyo1 +FUiI711q+hiXz/G81nuJarzuLesYfmoXKVK0Us9ig4f03TRHsSLlH8thAyp7zqvcvwUJOheYCe
 1CwO/s6jZan1H0cnjStlYCg/Xf1pgGvzog6SU7MzHjyfh9JFrp0wS73Q/EziTVEalLpLqZ2ht+S 9dfhz/dj599ZJB4tM9uLIbgy4FoGd+mzqUu8MVqlo0ohUDl6Ct3XpyUGvWho9Lv641bOD7jrat2 FfNH3HqMgQGU8lWysajWyZBkfnvaf6RsXOVmiC61/rZPC4JsS2knmthONFxpP4dLLAaJDNZa5Od
 bfhCRPMGEU52oN0qXGFIrfIXJDVxvs3ZMULldixEOz/UriONIAMz6E78ZSkLaurKBVhnX41n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01

Implement packet length validation before submitting packets to
the hardware to prevent MAXLEN_ERR.

Fixes: 3184fb5ba96e ("octeontx2-vf: Virtual function driver support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 8a8b598bd389..766237cd86c3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -394,6 +394,13 @@ static netdev_tx_t otx2vf_xmit(struct sk_buff *skb, struct net_device *netdev)
 	struct otx2_snd_queue *sq;
 	struct netdev_queue *txq;
 
+	/* Check for minimum and maximum packet length */
+	if (skb->len <= ETH_HLEN ||
+	    (!skb_shinfo(skb)->gso_size && skb->len > vf->tx_max_pktlen)) {
+		dev_kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	sq = &vf->qset.sq[qidx];
 	txq = netdev_get_tx_queue(netdev, qidx);
 
-- 
2.34.1


