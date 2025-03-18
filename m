Return-Path: <netdev+bounces-175708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3B3A6733F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52977A4060
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF22A20B7F2;
	Tue, 18 Mar 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iiCrhLY7"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2084.outbound.protection.outlook.com [40.107.103.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBF20AF77
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299060; cv=fail; b=lBjE1TtIUYT96zelUpyMTYPw1SzgvbCtOW17pquNCb7oEUuGITUK+Bb/vBuUujIuCLZnc5CXYheA4z1gJ9kWy+2+/bX77oUw992rLtKWozROXH895gh77t/MAc0RyYGMGI5Wkv1AkyfVUCV1Eveo95/fkBQZMpW8c8MO5YQxZK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299060; c=relaxed/simple;
	bh=+IYw6H5CCWA12wAgSxIDjoIWYFv3BvmB/JoH1BMyYmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p0JxmhHJOoA5troYhTDKP/RAWdrXErUZY2/yaNPkEsWvbDTtXgm9NqK0CpF2Ltri4+Lzx0idgZvrNnT6+haTxAKilWUVisTTRyjFbEDJ0zYIU4pWH9y1NT+/1hD3ekKRBv2SxsSrpmcGYhJ8ZuBHT9TLFl77Ny6hq2Da2UVJYdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iiCrhLY7; arc=fail smtp.client-ip=40.107.103.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1nqVh7Wd2wsMVOZUCBoErwq3VumE4RA2IDEsEc5a+4PZDxt7juLQZ0l5Bsh9mBGpzCqRdX00e5bXPqDmq3/rHBUHj5T/0Q4gb6TTTcBOVLxzCuYQXaVkRY6xQ7WtOqu37FgmW0eC+Y4an7KbBH6nDdUrmm5J2TPr/bp261TTgW6v7w413Sck6Z/3EHf3XYDbfBObmrufSe7ZOqNiGcGbxrT+u7XlanZPfss9rsBvX4kyKBHEcoDRQ8j/f4MWVf10VzoVUGswerdGPhOEzIuz+TbyXLK/zE7BUVBkHG/0N/uuYZ/uyHzrrR1A4FT+0jpUWTk8UlumdI2KEbkCzgqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lE8MuB4UAo6Urji1B/Oconyn6h8YV7extukzH5qNGoc=;
 b=IDvyiMUtX4mOCSvNkCOrMf0klCPD8jENkNqPUoJ7FM4hs2+ipWbxoOBDrAxhCWSyXniXR7BuirYS4ydc0VWHeShaGskUduGXRj+sn8ROwgwpQifjyBthgEGerbk6RUadBNZBFqHUA6HSm7+PWPOGZTOea3i5H1qFLH9dUxqgf2On9d1dQOf6qAShnYxyagOeTa7OAcmk1fhvZrVu49e0Y+KWhZTryS1L9p9ACrTAnPQXTu44APGI2ZOS6Y37dHJsx+mRkA/IYzLYNHkj0r68o1uvuMmaS56ObvABYcu5kIY/XR9MZIDFCQosU3gnf89xruuJXNKrQt90XYHVuXgY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE8MuB4UAo6Urji1B/Oconyn6h8YV7extukzH5qNGoc=;
 b=iiCrhLY72oeVte40psrwBix9FInTo60ktbDBvuNNxdH4VrCkL8Zywjz3WkczUdHGBBEny950nItIkktIN91TvNTEeNHkG2svVm7vQCsENkZjyEHBq9KqGIbmXimlF/NB4Gq2ewybxIkdsSPwQ5qHI0jIro13wU3Eghjkmh/WhHuJP/FtijJ7miUUcXCeIsnuvj6DsGbgqlV7qlYGK3v7jWfqZIDfrJ15G5XciNkOgpDi173fp18h13SvPTlqYRE5qDUoPbzLkNVdfVQfe+SsYzhyieAg2nyOQ1zTT7ElnnApoT4x124Y3Zg8/JKYoqFkiL8a4Ov8qjw/GT4dnnv8CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB6926.eurprd04.prod.outlook.com (2603:10a6:803:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:57:32 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 11:57:32 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net 3/3] net: dsa: sja1105: fix kasan out-of-bounds warning in sja1105_table_delete_entry()
Date: Tue, 18 Mar 2025 13:57:16 +0200
Message-Id: <20250318115716.2124395-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318115716.2124395-1-vladimir.oltean@nxp.com>
References: <20250318115716.2124395-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0042.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d760e2d-1f9f-4e57-18b8-08dd661410a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qw1itP7O7unubQDxg1y4gWWC5kFspQmWFWMaMAhlViJareIhnj/jyQGen8Fk?=
 =?us-ascii?Q?eHmFeILh07HgvD74tZSkmmuFTZR2W8M5SrF3TpXnGDDxIyKA8s/AIDPKvasw?=
 =?us-ascii?Q?GyoXePpAhvgns6a00iWYsQ7tRbKA86JYAm5UzwThCjsaT/Tl1FkpAWXr4AIa?=
 =?us-ascii?Q?eXfzLfZ60WOWkKL85Jbh6pxEGW2bxToEfjs+hVM4ucBCtj0iWbWKniQAe7sj?=
 =?us-ascii?Q?6a5mGs2gjRo1quVyhunVv1i7cUChRJpflu9tFC/AMmjlQuF6CTJKsjowo/o5?=
 =?us-ascii?Q?I/K7q7y/YKD7XPzX8GZf0NjTb/Y+sEcfdXtMytlWghNZ1gtHv5toVZ42JPsJ?=
 =?us-ascii?Q?KIacKBUCbqlJxaWtP0056+Qiuc56/w1PB4iGASNbYj5JIiDJYxhXZ1rjHPt+?=
 =?us-ascii?Q?nY8qbtRfWQQU+VJ3BUT9/p2ZvBuXX+o6Zq0DBaM9do/JOfkQ4llCxYVC69M7?=
 =?us-ascii?Q?gt4DjtzxR30qypO4eJTAh7kQg+VXACdK4HFTNDjvpkLFJeyEiyPQJqFsiZvd?=
 =?us-ascii?Q?YFIlQVRZ59UvTMSIzovhuyJf6bqI2gveD6ocChmL+quQJ5rrBgvJqOPYLhpJ?=
 =?us-ascii?Q?A00w0K3FFvLLVUpHwEZCIpFJsRpj127hjQg4Fp08htxb5fIs8ZB2i7zez+zU?=
 =?us-ascii?Q?6nvU+HSTYjcgxdtYZNY2m34yCUzWeG6f8nKKyCpcO05LF9bKt7pzYGPtZiQA?=
 =?us-ascii?Q?5Sw28Xfa5qiNerHOmlQc2OPhwZfLWqDpCBw1U2ybqIusDdHr6ly9xFXAAdOs?=
 =?us-ascii?Q?oaeqEk/gnT+UwWd59xLAYEwczcTBwNzkCRwr3omTNM35oD7tthSk6W/RIw61?=
 =?us-ascii?Q?NRU0juuIHEUd4/dfZ4AjlmkWAqzv2UA+jTcQNAHZF4XjZ+X/8dr/D3dV4A9E?=
 =?us-ascii?Q?dkj/KR5CDqeYx84U67lzMe10rtFYcjdtsYMVnGwAoo/SsQtoQPv+M9uEK22Z?=
 =?us-ascii?Q?Dh5tiEGsH8wjVForxIFKBgsXKXqK7r6ifM9s2bAizb5FxkRRDv2dAIhcgIks?=
 =?us-ascii?Q?3RAWHdm/BPip0/7OALP6xA57o/bZcuQtH0ccvlEPJ3IJs7WEvtGnfn7Yu4zK?=
 =?us-ascii?Q?gOht0GssnDWb36ZAsFTYuHONK6y7nIpUibMPErVLP2vu1WiCeWuRw7Fa0L1q?=
 =?us-ascii?Q?PWgvNbprBP5mT0TVgptUPrGfCmSBHmWGZRZu3CoLpkJLk9vBDc97Qyu0ioxy?=
 =?us-ascii?Q?KMoUXybUgJvfNtB/ouDAQ/vrFfDI5UT5//OOpzojIMNPQkSAvcZ88VBVTuwg?=
 =?us-ascii?Q?AqKdu3cR7HgbAkm/coLZjRRrZO21YHN7glVROHfS9hOr2GwTCN3+11pK2OjD?=
 =?us-ascii?Q?QrKMngvzfk3y47aLxLL0OOrtkHaJBeEfmsnzudeHNCzU0uGGfzCwsj6+M5UV?=
 =?us-ascii?Q?sdop5HiquuuONGya6RyKA3i1IiZMr+VCKG3uZRcDo2giQv3I7iOLGZ8WRHsf?=
 =?us-ascii?Q?RfUiU4xxl9UySM/ozUZWfgNrG7EV+MZ8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kklies/1/FJMnN1Y9+7vvmn0Whpu2bqvVMnzibeI6zDc3pAVVWNLXccNF+jf?=
 =?us-ascii?Q?6MKt95NE66XeJkELvbidm0TWjol1zh2Nnxl5lXfR+WsYH6qgQ2MZVtN0eQEq?=
 =?us-ascii?Q?pKcL2XxROUf7STfkz4r9L4Hs9U6fbh43hp8KPKwcoN3WuAv/MFzjy+jGpkAN?=
 =?us-ascii?Q?/qsZzlF1NQ/UFXkWIn8sc/vfJVTnJPc9VjXJJujBumspv77byTO3gTdSW1t8?=
 =?us-ascii?Q?lsXcfQgQfvz+TS7QVNfPyEudNlnycSuYBj3fYPFLsIS8TxQbrq/CRp8jI35H?=
 =?us-ascii?Q?v0Slo8UNfgvu3QDCXn5Gw+1LDBT2Y7QgTaNm52OcMNz3ttA71Bai23PGeu5y?=
 =?us-ascii?Q?cE54YmySRAqVIDWwvHw1si5a1516Xw0fH0DdC40zUgq7HbVyrUqoIkXx9FKi?=
 =?us-ascii?Q?OpDNrTPyi5R/KFk+FbMoPRwwlsro2SEPe6SEhHCIzmc6d5fjfjdGtx5mWqzk?=
 =?us-ascii?Q?XuvoQzsCYO8/xKw1jWmgDgmvNrGPoGkODn6avdYAlmN/fhFOR2p072Jqks3S?=
 =?us-ascii?Q?p2YBI8ijOEuknNZii3//AtyLUlfeN6rLi/2U+U3XNNpMfxSoyy8N3E9TR/GC?=
 =?us-ascii?Q?tANj2Seb5T8BFXSZU+Lv37XFaswA/02poYPqI4YZSr8rFvTVFMfbUQiFirir?=
 =?us-ascii?Q?NHua91ZX9mGa1HYRMOsWccn/SdzXmLXg483KsxVA9FPqSxswvhXtl7v7p5VJ?=
 =?us-ascii?Q?1/qelv4gIy/w76mKNVVeHGEuMhHQ+ifXqqAXPsZfzvl4QOVB4QssTVcy68+/?=
 =?us-ascii?Q?egYvadWvwq76kjQL1r2wCMtWqlZn2lgyWY02PszPMVBxxtwCpwYBb6XdD6Bh?=
 =?us-ascii?Q?Yj0p2vhpIe1LoxBkmw4kd4cYJ1LYDKelBGTmwKkcJSMbPoY3cnakw70frkCp?=
 =?us-ascii?Q?d6R/12UwobNlqR0pFzpwGmhzXncau8TLKFsC/qQ7ZBXdOLVsvAGAShWIwQFy?=
 =?us-ascii?Q?lkV4BWjn2L3/kfddEwiw/XGck8Vb+ydn1s/kxOvxYD4YrGzM43UfqbcZSN3L?=
 =?us-ascii?Q?Rn6SDTkoFNZAVbH9pMOqfywj1WeYQTJDIdC0f2Nh/i9vzmK5xIEDDl8vaOvr?=
 =?us-ascii?Q?g5JuK+eWI/GF9VECxoJuLbh/2JGQAjP65rLgJQt6018/sH+Ti85A29PMYdxs?=
 =?us-ascii?Q?NmYHE0RIEIJ46x/wigQLgzo2+eSV00vZTFzagSQ+RJO8M3sQRP+hoNB8gmo6?=
 =?us-ascii?Q?eEHnWjE5SkgbEsOnNHQf2W0fTgsBlmUbZuD1u9fOj6zf9bbJVyeMZT/Kxx3k?=
 =?us-ascii?Q?2oYkPgP9OsBOeKeGFaaa6vcohOVPeMK2QzxLoHV1sbONxqqjo2Pc64pR57u/?=
 =?us-ascii?Q?PWv0ticOVEmuFAEdPoCH+t0B/82qxKaW2geO7A7amqrDigrHUnYDdSs24U/f?=
 =?us-ascii?Q?d8m4Pw6a7Yx3ueMyNV0A2VoXQA75z3fP4I275BrKZ1WXy008kzIAN2IFfjK5?=
 =?us-ascii?Q?W1/+Vbj9JnA/d6Pf7b+N0mtN4KoaG1wqfboHPVRK9zYw221TgJ35WSPDV2hK?=
 =?us-ascii?Q?Ylzizt9Ntrdc/jmy8RrhvRy/QWUTxP3jELjzJQ41K2G2R5+idJ9xNOf/JXXo?=
 =?us-ascii?Q?T42KO8YhPJoNXtYBbgCxWk3PdL/pUh/5C5AtcdKk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d760e2d-1f9f-4e57-18b8-08dd661410a3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 11:57:32.2907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8U4bs80LAMctsH2/P/MkFi7s6unB0f1v/51PnNfosdjX973Fd2iMQ5+tNZdvMUAMq9MQyt0Q/dd0nfz6kcVrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6926

There are actually 2 problems:
- deleting the last element doesn't require the memmove of elements
  [i + 1, end) over it. Actually, element i+1 is out of bounds.
- The memmove itself should move size - i - 1 elements, because the last
  element is out of bounds.

The out-of-bounds element still remains out of bounds after being
accessed, so the problem is only that we touch it, not that it becomes
in active use. But I suppose it can lead to issues if the out-of-bounds
element is part of an unmapped page.

Fixes: 6666cebc5e30 ("net: dsa: sja1105: Add support for VLAN operations")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_static_config.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_static_config.c b/drivers/net/dsa/sja1105/sja1105_static_config.c
index 3d790f8c6f4d..ffece8a400a6 100644
--- a/drivers/net/dsa/sja1105/sja1105_static_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_static_config.c
@@ -1917,8 +1917,10 @@ int sja1105_table_delete_entry(struct sja1105_table *table, int i)
 	if (i > table->entry_count)
 		return -ERANGE;
 
-	memmove(entries + i * entry_size, entries + (i + 1) * entry_size,
-		(table->entry_count - i) * entry_size);
+	if (i + 1 < table->entry_count) {
+		memmove(entries + i * entry_size, entries + (i + 1) * entry_size,
+			(table->entry_count - i - 1) * entry_size);
+	}
 
 	table->entry_count--;
 
-- 
2.34.1


