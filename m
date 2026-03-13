Return-Path: <netdev+bounces-267409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGK/J1nus2m4dQAAu9opvQ
	(envelope-from <netdev+bounces-267409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:00:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB16281DAA
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E32143169EE0
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215D938B7D5;
	Fri, 13 Mar 2026 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="mpmXzv0D"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010059.outbound.protection.outlook.com [52.101.84.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598DD38F636;
	Fri, 13 Mar 2026 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399467; cv=fail; b=fU5m/eOQkcriu//abTrH6MZ6HJvxWzmVRxKM8prgoBrUQtrhgi9L77cXrH8xAUjdi4d8irWRGO3iBGdfHNJP/hxt4ooOAr3/zXp/f+kHBnByrb/QuOH77bkDaHuyXcth0/3CUCSV2XeTQbvXmx/mGaCeK9hgyF82E+l69UDqr6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399467; c=relaxed/simple;
	bh=ePSYKNyDMpsxtBRToMf3IPMuA7CVN3airfEMnHhSbQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QLNCESFWPENyai4E4NNguDxlRKQRl8093Q4Xu/4GJUUvYamX1KNrhqpI0fTr3BGHfZWkd1raBOA3XQaJQ91i+IHRL60u53Y8KFhmcYC5BpJZS4hJ+tvvd5dENWHHB0xgGih08Fz3cJO67qFy/fTu6OyT9zNrbq49ONgKJmQr4Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=mpmXzv0D; arc=fail smtp.client-ip=52.101.84.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrP6BSL+TlpZ65ZNPWdrXI5Npj175rj3GzU4v2tdrFEfZCeJ3u3Fc4qO79qeHWXWRecUhFER898rQcOLcJpuj0k+ao3jgX6nDEFOA41JS4S++kLm9+WfGiw+sMpa8UBN3U7XSVzis0nY8eUZJuqV565x4n7ezojhOIqnKh94hFyGdLKZElDX1GEdt1OFSQww6OHWv1YRSNalJqAAzQ+9nowitJkycujZTapdHGP6jqTfG5ri9wC7cntKMG5iCCa33GZ7Xkqua5DHCEEOtYOQORNZgykAhVde006FLCkVr5OqVE2U8dbm2+Y+/95b9lPzU0knQwcMt1p6rtfU/uTB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGQpx+AJllAdYpO+If5LgpzDRd1knbEJnsP2b/jmHxQ=;
 b=jLRcpSjGaGRa9wM9RDZNMAv2M5DyK71H1haqAkIAuf5o5ir+BValVvcISKH1iAJ+3+SYaJYRrqTKFUdxHpH1zi7TFGbrJXhQdLLAVR52//KG6GiGQTyzUvSkTP907CyelmKg1Sujx4rO5MzqPAixT3wRodnYoZJCM/2pCd+mPa6SHRZwLYFOW+1XakJc++yS2+Twfk3XGGseISTvhtNcJP3nvZuqBqyW/NnUtIbjzxhNo9CboIs66MdgoGGytO9cIOl2risVj6wN3RNPb8DbdThTfhdCHS5bFeLcVwSQngJsVuExINFye8gYOb/k1eC3j/vzKD0CvdjbHPth3gSvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGQpx+AJllAdYpO+If5LgpzDRd1knbEJnsP2b/jmHxQ=;
 b=mpmXzv0DkQfyrKa/Fp7Fzf5sRm7fj7VF/Am8aEgfVsHRVsL9UfGMHeWuYeRO+rxYalqDpEQ2ye+bntm5VQitw1/H4QfccKcfWByCEHXG6YMbYW4McSJfEaOuLSDBtiN2nN8aUKs2VpkAxlf7Pi0QolAb5PgN3wFb4ldd3kV/IrV0uj8gb/91fmcDGiHWbnGnyZLEWhB+BjwLCq5F9iJOVerUFwjhFbB6jdZXmkg2S+fjOGFlDa+YZwZ7GZt9v4m5kj3vOhnjuN7B7OBISDRFGuXCDpf1eWlu0GZSLcBYd0W18B29Ihj/ejVq2gHYTXXT+J/iSn1ZLZabU8EzH3hItA==
Received: from DB8P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::29)
 by AM7PR10MB3159.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 10:57:40 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::29) by DB8P191CA0019.outlook.office365.com
 (2603:10a6:10:130::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 10:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 13 Mar 2026 10:57:38 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 13 Mar
 2026 11:59:54 +0100
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
Subject: [PATCH v2 0/2] Fixes for stmmac driver
Date: Fri, 13 Mar 2026 11:57:15 +0100
Message-ID: <20260313105718.359614-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EE:EE_|AM7PR10MB3159:EE_
X-MS-Office365-Filtering-Correlation-Id: a88ba5a4-722a-483d-4061-08de80ef57a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ln6eSKLWpkC6Xk6yVUZhcWlsu3PMSHb2SBCBGBesEthiUflMkW7u2ZNqh6c6t07VBDSNbkG66S5J5EniyYx0daoMyDHiBuV+wBnAq9lqc1+1R5A6SPCOcK8+JKCkpauCOeCd0me39NP2wIV1pNg7unC+Xg3C2PKEsDDE1KU6ApLwH3LepTMEk/XQMtislUcIzgARaC8dTvWOMlqACxDAF+x/qHd0qeGmCb+nGuBl2XXKVOKIFqspJpoTLGtdZoJurhqZ/cqr4ZsAq9Bvz1g7m7S74pituGR9/wM3AqAdasMgbvFisMWXeUlwB3Z+qrvQHVwNLa9Wv32niiSvYni8ATOLdDvxA00jSJk81EhE4F71AKnIVueZKvXSQIvfk78ZOc5NuuILO1CtUtIVEssVtkvIchdHQY2wdw09i/LyzhvRcogYnw4KBkfPNbyerfytJ6n9sh0XCjwOw2Hx5X2P89NAnzxTzT4DXHVIVevrgex3Ohei33O7X+Fz0rUS2yt7FmkcykJobm1gyUqg6M5y84htJy2FzhbnW6uZaKYbEoZfV9P3bcfynKRevbbk5MT/h2E9fxsDeQa44O5JfKGgVJdRYg5rJ7ZSwMs3l/TvIMjiUOWgc9NOjb8FBX4TYPBt9gif2TTgYaQNbkmbTOyRI597x0npiPdlHWiVEgpP+6GjiqgBUTCzIZcz8HR0kbNQBfNyuKIqShnIGxr8PHukq9ZT6y5sDxkv6NzVtVWGwSRK1Ry1APDUD5VJKie8upl0oANlOUeTzGzoSdI4Mwuks+KgRzICAwbZvR2YSF19nCt7j0ABHS1ZAbdY+2nGYKH5
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nOOcSDqhZdurerV5KiA1Cj19yUYeZZASr+rxZWp0WsEHwqGlrtsuTP7FFm6qa3GY3vl4H53oUk5MnnhwHRlTJ3K9IipRppADGtBx6jB+c2ANws4CWV4y27wKOHCebkJ2/dznyRfkhBJI9kqQ4ekJsWJIhvQ21vdhzOMLvvz6DgHFO5opVVIqeG1kJX8v2mRYetl274ungG/lLDcdm3RI6xiqJkFS/I2p6Dj3ma7RRHuzr8BTWbuwOYNjwgGZkOpu0mZcBtNxZawWibNhjqcXYS7dTbipoKxtjuyz9nvsgYTv9oGLJujn4pDu8pxPck3vrSH7QuFW7Igy1yvhksLQpvkFE0UMuQJ01uuPOcJL4YZAyVQ/dwcPSSH1fwMJbkBecTO87Y6k70zowTUBsmKRttt7r2OJ3Sta8sfSO4xkciduzv5cJfvoRh350kAuaL4u
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 10:57:38.7989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a88ba5a4-722a-483d-4061-08de80ef57a4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3159
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267409-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,nxp.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,foss.st.com:dkim,foss.st.com:mid];
	DKIM_TRACE(0.00)[foss.st.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.roullier@foss.st.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3EB16281DAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

First commit fix error when :
1 - Deactivated eth0 (ip link set eth0 down)
2 - Perform low power procedure
3 - Reactivate eth0 (ip link set eth0 up)
=> eth0: stmmac_hw_setup: DMA engine initialization failed
         stm32-dwmac 5800a000.ethernet eth0: stmmac_open: Hw setup failed

Second commit fix bad cleaning when error during stmmac_mdio_register.

V2: - put Reviewed-by from Russell for second commit.
    - update first commit with Russell'remark.
    - Dropped the third patch from v1. It requires additional work on the
      pinctrl framework to add a new state, and I don’t want this to
      block the other two patches.
      I do not intend to drop this change; I will follow up on it in a
      separate thread together with Antonio Borneo.

Christophe Roullier (2):
  net: stmmac: fix pinctrl management during suspend/resume
  net: stmmac: manage error case during stmmac_dvr_probe

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.43.0


