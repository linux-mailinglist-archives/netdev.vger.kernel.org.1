Return-Path: <netdev+bounces-267411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIzXCKfus2m4dQAAu9opvQ
	(envelope-from <netdev+bounces-267411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:01:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 911FD281DC8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E173166C79
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3751938B7D5;
	Fri, 13 Mar 2026 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MRBRSX6f"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013032.outbound.protection.outlook.com [52.101.83.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8052BEFF5;
	Fri, 13 Mar 2026 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399479; cv=fail; b=eHw5hcnTFe73p0R6972c0EbQhntbgYRfj8fpgCaunyetSstk8dyVwKFWfffhXlKE0wNsEMnGOiDTbamOmvKS7G68Ctkg6F125perBAX5kbbTYAoZhM8FBt1J/TVz6oWYH+hl21/ApOLORYiakOXby0IrgD/dp+VmkidFahqT6EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399479; c=relaxed/simple;
	bh=YWeBnTeTg8WTqjzsdS/gx3ClSbXF8kH4ZhieGAJoNPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3gjeS3O4TuLOygytuYVZMhaAGIszHQD5CmS5Nj9x7Qk5Iv755RjYNbkbdte5Wy0duzqyrlRFl4NEZJmuv0Kn8I44XQUolU2QCDVqeZCxU384N6Hgnr0x7PBFIcpiXUpRENiMmyIX2P6T9MGJ9E30lpME2avR6AvT/OIUqfZ2no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MRBRSX6f; arc=fail smtp.client-ip=52.101.83.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbWxVOXLGqBzlDN66dhLIWD/1IXzKKx/ugPXaMy3BlUw9cctQRFZymgMdURUspzZLD8aM/NkB8rkiEHm0Dj/CqtCsd0DDqo1wk8bI/EcBh7Fh7D80NdZDnl+2yxy1Of6Psf0L/agDbAnLAzYdyKVhhdT2+DctxnsHCFZrxBRxgmlZVfxuB/yUVOr/h1SO0mn95OC4Ru6DT74ek0tvfRtWQCWTEHv34FSTs1XDSrrhlD1Q+NKAgAHHpQbvxmBDcldRUkOIIQUI5WqhQkU2TzKUDeQmgL6rTi9Now1YSX9Flv1Jo9LCH4PhHLbcaCdy7PkS3l1pfHlJVjrDfJAq5i/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51vt+44h+IDY5mYqvB7015hSbJwP2stAqIgMEc1EQwc=;
 b=WWhMRnzgQnyM14n2dTm4PTEQAn1w0ByKiJET0PN9Q5yJe9adJSPFBwOycTpbuBDADcXORfPCwgalKBymskEQC4VKNY5KJ4JwkSxZKOz3iBUMyKIRgBlvG1UhCGQMUJEgOfzAAwIo2NNgvIH7/Bet2uI/3E4+QfyNr7GHgDk5Boe65gDWaGKbIqDSKaD5W0Ghjt0cI0bRSy7wshrbpc+m6y8f3NDgaLul+/kcEE9P+gzs/26ylbfYnE6CPYiXcwOZDOwTq+4CNZKFIJlxeiqMFw3t2Cg7IdLtOZM7ZxS0iMXVZrXsEx/KaFCp4RFxsmJLiSRo8nT3b8wqHu6lEUxFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51vt+44h+IDY5mYqvB7015hSbJwP2stAqIgMEc1EQwc=;
 b=MRBRSX6fcmkZ63Q8EWq3mzrmk7ADfCU7dBeX661UreH52U339OIhSnTdJoqhAeY2qiGgI/aYda7cvh1cEvLQnhavDtOa3du1mu8f0CGT+jarYDI+t0afqkg8KvtmVjIeb+H3dtaxkz9DffTAEWHxHhdyWjMs2azX2ek0e/5ZpWKy9nBXhl+RwihWqlEAZEX3bw57zyfen0IXxlvUuvusgeqGf/zAjyhnmd8SkZg2JekFqGBCUqbsw0H9GMSPF7qaijy8zQiZglTfHNpt9j0v+qL8fCEn0FfausTi0P84vuAIHX1HZzRXleFMNe0ZhLsi/c0e8pugv3dJkGb7QMlvwA==
Received: from DUZPR01CA0215.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::9) by AS8PR10MB6889.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5b5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 10:57:52 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::51) by DUZPR01CA0215.outlook.office365.com
 (2603:10a6:10:4b4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Fri,
 13 Mar 2026 10:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 10:57:51 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 13 Mar
 2026 12:00:09 +0100
Received: from localhost (10.48.87.194) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 13 Mar
 2026 11:57:38 +0100
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, <linusw@kernel.org>,
	<antonio.borneo@foss.st.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] net: stmmac: fix pinctrl management during suspend/resume
Date: Fri, 13 Mar 2026 11:57:16 +0100
Message-ID: <20260313105718.359614-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313105718.359614-1-christophe.roullier@foss.st.com>
References: <20260313105718.359614-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|AS8PR10MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: f3cbec5e-0f8b-420a-cd68-08de80ef5f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/OQ2Nq9xYUzSMQASEDONwGmUG98QIREmOK4GuhmOSPAtBPO6ZkkolXWjiTxJ+XGJInHnNYAw/OWTYzdjwhoqvKW54SVRiZXkVcokupWgkK93jffVrv4heuqgbTZSXRGsLPOXodRZ8uLb6ue5uAxzMjpj5TWYoNP5tPSRQsE9dMAm5IF/8fOv6rDIXw3JbEQp556U86IQiEjLnjD9gjRXdwmbGd/Jtsffgan/mBsjBNBYyX7xx7f+B2B8oioXSOcOTMKWoPRq/2xK1Fr5Gr+teRneIi+XOZ3xr1UF0V+Z7C3xI2TP0Mhr4NiH6Q6L/7Q7YLy8EVAnrXDlZSixWmh+JEqpILj5gkor7UbSSiqa80idMMEKlg8IWSGzA8y1YDVuPH0sK39SU5P3Gsgj13Gmn88TO5gCJxSKkJeVo2x5jYrI5xGJ6d2LqO9bErS2PbrwOHq0ofuq+8rrb5aDNTT14wHtousY4gn7TZ+PtA4lrckycNMfcI1QVyVYTnoE2x2r21FgW/bH65PvaaIXP/8Atyq60ivZdzfZmaiJdtKn34uriTO+YU0rkymWO7B0Kgh7VnNX/X8cY62lH3MkQW0UX9lfBDebehDs/JueseMNIV6oif8w6l95EHBpXlZcpuWrTCopkamwzxtQ+AQ50S7FTa56unPsQQsGP8XowMx8/IUqhO5EQRPlVN/gAEdhVmq4ngPf0OE8y22UKzXQLChRNfq5g20I7AgjFstoxZ20pNdyAHxGRJlFssC3+SvEkg66S2Y1ScMg4IQEoyczFtTpbMTJ7bKoXTqmv3fbogSqwlNvzSdLigkOPjJVuNvz9aYi
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TJcSO0XGfJSQua/kvGSpwp/pvv7qa4B7ADZg4MivnXBMEzwf2cQ5k2I6ZyuqKuHffPcLn38zNfSkb6Fw/lE2xrOSP5kNTW8QHe/rpsKRCNgjEiFRgiRuXN39JPe4QBo6XMIHnrwxN1c0JCRfFwouYg5jYe7G+bY6GwqeHGIa+E/uS5XfJOPz5odDXIEkF20lTs6lKyBiQ3jgPaDjleGaYIQAWsMKLReVdlHsF0/IXdx5doJfkE769LKdBOp6U9Wi30TWM17z+MGGfHm9SDDE+w077E3UPtwbxVYT6GAfvQMg78cGsjGfSYuVe310gXBoc07HXg4ZiZLG1DnF7V3syYx48jtpiBGdgPPeWsqrn1Tya1iFNXW6euySCfONauco9mRXfqasy+f6qWYql3G10pCy0UXqVrrcOgdWudJVAirxek+mQ7LyBYXwY8Yzj7QL
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 10:57:51.7913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cbec5e-0f8b-420a-cd68-08de80ef5f61
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6889
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267411-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.roullier@foss.st.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foss.st.com:dkim,foss.st.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,st.com:email];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 911FD281DC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the deepest low-power modes, the pinctrl configuration is lost
and is never restored if the interface is down.
This commit ensures that the pinctrl state is set in all cases.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 11150bddd8726..26ac1cdc561c2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8150,8 +8150,11 @@ int stmmac_suspend(struct device *dev)
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	u8 chan;
 
-	if (!ndev || !netif_running(ndev))
+	if (!ndev || !netif_running(ndev)) {
+		/* Select sleep pin state */
+		pinctrl_pm_select_sleep_state(dev);
 		goto suspend_bsp;
+	}
 
 	mutex_lock(&priv->lock);
 
@@ -8252,8 +8255,11 @@ int stmmac_resume(struct device *dev)
 			return ret;
 	}
 
-	if (!netif_running(ndev))
+	if (!netif_running(ndev)) {
+		/* Select default pin state */
+		pinctrl_pm_select_default_state(priv->device);
 		return 0;
+	}
 
 	/* Power Down bit, into the PM register, is cleared
 	 * automatically as soon as a magic packet or a Wake-up frame
-- 
2.43.0


