Return-Path: <netdev+bounces-144373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D80069C6D84
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F86D1F261CF
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB3420011F;
	Wed, 13 Nov 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="R02wgCr2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65231FEFC8;
	Wed, 13 Nov 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496424; cv=none; b=OQ9SvpBIOqMyWas1ygT7THcetDfNsYHP013AyQu2ixo/GHYzB3wOP+ow418dvvXGSPf+V2ZUGB3ly2KiLATqITjeKD544Srf36xqAg8BuOkoRQsRFrLJV+ckFBt45Yz93JV67/I11/U8Q4vffMDHFyZ2XZwTXSVbOBeBnatApFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496424; c=relaxed/simple;
	bh=MwdtHh/UdhLoNVhfaMc2nF6UrHhs/5DLwVhQU1QNX3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDRMGNqX+2AfoAAlxj59cEurwNVJ1rrq9Dzldovq/PFRhhTCRqkv/giz+l0TJxjBz6xcZeOuzqhrCHA/Ykbzpuc6reuV1msYMacyMoE5ksZnIAqQRKG9gMBEU/X9YrDYE/3DqNcSdonYQZZ5Bwmf0P0jW0uKJpazzQ0lr6qV+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=R02wgCr2; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD8WPYB001685;
	Wed, 13 Nov 2024 03:13:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=M
	9c3vgHxrcorH42bwjyISL3+E2/jASHcL8EdxTbUmxw=; b=R02wgCr22stgHH76E
	rYTcqZ0nzUbBLPI5b7ZIUqUK5NYYi70D9/AGgecR2gye3jP5r1pqXJepM80F+zXY
	VP1K74lmMSh/vzOeB+F35pRqRqnKfUPx43ogksIWmv+YDKTxrXxqTcnoNPuzt6jv
	d930aN6/WaRqtRISbbrnrC/z+tKXInGbMijeFhlhUFSxSyCnrpn3y6/DZTXkxOQt
	IhHZJkiuBPmEO57P8J0ve00hAVea+gdkV8uUKFfpVQT5rExFwOPopezlNbx4F3Td
	a9Po4fPBSNl285BH1C8bom4jlcvoO+5IJzsi9AHR9OnUbmoo8yvB5QR9JZyb3RoE
	PnhPA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42v5s2tqff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 03:13:27 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 03:13:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 03:13:25 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 7A67F3F7040;
	Wed, 13 Nov 2024 03:13:25 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: [PATCH net v4 2/7] octeon_ep: Fix null dereferences to IQ/OQ pointers
Date: Wed, 13 Nov 2024 03:13:14 -0800
Message-ID: <20241113111319.1156507-3-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241113111319.1156507-1-srasheed@marvell.com>
References: <20241113111319.1156507-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0QeGa7ySTxn2oklJq1rQwkyFv-XAfxal
X-Proofpoint-ORIG-GUID: 0QeGa7ySTxn2oklJq1rQwkyFv-XAfxal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

During unload, sometimes race scenarios are seen wherein
the get stats callback proceeds to retrieve the IQ/OQ stats,
but by then the IQ/OQ might have been already freed.

Protect against such conditions by defensively checking if
the IQ/OQ pointers are null before dereference.

Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V4:
  - No change

V3: https://lore.kernel.org/all/20241108074543.1123036-3-srasheed@marvell.com/
  - Added back "Fixes" to the changelist

V2: https://lore.kernel.org/all/20241107132846.1118835-3-srasheed@marvell.com/
  - Split from earlier patch into a separate patch
  - Added more context

V2: https://lore.kernel.org/all/20241101103416.1064930-3-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 29796544feb6..3cea7811e48d 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1015,6 +1015,9 @@ static void octep_get_stats64(struct net_device *netdev,
 		struct octep_iq *iq = oct->iq[q];
 		struct octep_oq *oq = oct->oq[q];
 
+		if (!iq || !oq)
+			return;
+
 		tx_packets += iq->stats.instr_completed;
 		tx_bytes += iq->stats.bytes_sent;
 		rx_packets += oq->stats.packets;
-- 
2.25.1


