Return-Path: <netdev+bounces-251021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9683D3A28D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 681FA300E4C0
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127F352FB6;
	Mon, 19 Jan 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KIFDv6UO"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D58352F81;
	Mon, 19 Jan 2026 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813974; cv=fail; b=tQK3jaKdTKTS5NepvCO+eqiHJyLBc+NZ7JLTSKOty+HJHkcfi1vlp1+kBfDYpK9JwOGbGo/XKVfmFbmQ990GsH3WkWYkv9YpU+O0P+Jc42XvmAUaqpTLsMucXv/ygArWtw/6RYZAKZnIMu0Vx7dVUrVPD+PGhw2nSWvEmwU9gY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813974; c=relaxed/simple;
	bh=kttKVrNCeWyATq/SNMy6HGxRXH9rE+12KyaG5kr1XEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QVLA44YAMRqV3UlJ0+p8WE0nuFPj6g81llXUx7YbDmCeNbQl6LV2982991a6ODtfBwpW1DvLYIYJubtFaLqikqc+4tPLIRyIUw0O0YB788C5oKc2hw9Cox1kB2gaNch/eswS0WHeXcoNx/Sd+dnSM/d0xCxCOgXiyo9WxmI3XKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KIFDv6UO; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmHylDHYhARJ1D/W+AmgXMlqvHhwHTS2HSg+Ovnhdw8RFfZwKBAqw/Iy7OquR9EAoLA0eUPPPAakecuZvKIMbIlEfqNiR5I8sTJSWccfNVj97J5KgV4Aept240QjIPR093Df8PxjkDnQK/uTXTy/H6L5bOfLWL7ewhFXLURolrE5kNG/Qv5lnPkesTJqB2DYYuPc83lLv4RjPcWGUzZ6UKlZeZIz3njas0IbBvBrrPa/GrN5/3bB/kXJtXCgq3TZYJvDCFmtAy/SRtAk7XnucDI8YGPmndXfPN3yZwxVTk4nGJIEPIaZKz5zhfAcMa4PlRlqrPynlkjmqCivqRk3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+6I410eRdgke0DERiNtBfKG3Un4h8KpWeJcu5/z050=;
 b=qJCNBgehTbmeDL75EAXZoBgRAHilRsaiyCn49VrC/vpGsOaf5OP6BeK+EJBlKXK7mRXXrn7pEVLNlAkBw68Zjziki0eR93et/YUzjOTSswN4t8eTULiFEeixdC2FZhk8CPufFU64vO3fBCRVV6Ewjo1VrbI3R+XRDBODcoxTbt23y6jTUQYXkrn+8GTo5E5ylR99UOeIwI45Bk7P1Ge+F8CDPX51Xx05L2b1Bv/Xr2MD+BjbSlvep5ohHyHxwvI4jkDa8eeFB99dWFuwklT+aaAmcLwLfHMeJLj0PBnXwD8tyDNsd5eO7+O3XpD6UaNNyb4nwSWUVXQxf30vM20O6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+6I410eRdgke0DERiNtBfKG3Un4h8KpWeJcu5/z050=;
 b=KIFDv6UOKSHvoqHpcfBYPL0+a89bWN4SRn3UhdsWRpWrst5GsNAQnFpu7YR/1u3mZhV1BYB+UOukOKnxJuxjMWd3ShUz8q9x3FVPkkUhdYZSejcwTcVFU8RdO3UJp6SCy4M+yKcpsCsRX4T3t9FYP4C+KeTUY6gR/b69daXXilzKeKDaJU08Bn2cXb0Hrt1/WJptUfpp+9pJeS+dEr3Dgo/xHbnr72Ynxsl0O+lkKwQV/PTsnZ2Ut/XG4d/ZbMkdtPHXgBj0bhT0ZTUEXleglglefyMp6S13Ohr/+nnOL8lsdI6+sxNudvXQShVrkVgXFV8q3grXTvHzeikv6sbB3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI2PR04MB10762.eurprd04.prod.outlook.com (2603:10a6:800:26e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 09:12:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:12:40 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH v4 net-next 4/5] net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to PCS
Date: Mon, 19 Jan 2026 11:12:19 +0200
Message-Id: <20260119091220.1493761-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
References: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0170.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI2PR04MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: cd644bf4-4aab-42fb-2a5d-08de573ae570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kXSGD5zpmUKHlNS13RYwzeFCpdlEBx1xr0BNJP8dE5165y2nzmOd0FngLs4Z?=
 =?us-ascii?Q?9FRZtUj9HhILybA6GAh+nnBFsYihtADods2mOdbeJgMp4HjpBVb9fv8KZaKb?=
 =?us-ascii?Q?ERorL+WQpGt6zV2rIKQxw+oVart09zjgj0bMCanoO+qWzOHHuPu8Kr7hDvlP?=
 =?us-ascii?Q?i6wu+TjI2S/uNVhs4zDdG7+0BaXu2qVawTnPno7e1kcsho73/UH0Jtpmv3ZL?=
 =?us-ascii?Q?PIYUWFndKC+kc1bq3obxlXSL4WZIr5RCFAtaCp2jMTcrl3LszA6KDaugdFKk?=
 =?us-ascii?Q?No/cs+Mu72x4ttUFl93imYA3lMyd0ZBMPKIjstfD68hhNlTsh+Ymp/YEDNRQ?=
 =?us-ascii?Q?/r2da2FkuuS77xpsuSmMbPXgYkJLwUyDpYoI6gzjR5/+/wyN6LH2jmiYwL5V?=
 =?us-ascii?Q?ITOHAdVuBmf39GlE/kJvdpH0sSpUlIi1UEx0K3dZyKv2edfsIkJo5dIX+R7m?=
 =?us-ascii?Q?+0+QlH8xtCM5/3gQntbbHEpNAJ9skxR7DymF1/8YYP3Mfco+NeiqdpvEc8+N?=
 =?us-ascii?Q?Ki4aByi102GfzNZ08JvR9TWPgWPVtDaYlWCQWjPNxISqfxfCqyp6boi9Z9V/?=
 =?us-ascii?Q?XnsxjfVJIfgz0vHZSJx9KiKbpSoI/EeR/kkZbXFi/dzNgC+xQMaHFrTIUjpT?=
 =?us-ascii?Q?8WQj1qaiicP8BiIwfWqskAKFJhb+RP2Vux6JLYEL3cE0kXsVdvbbL371yAEs?=
 =?us-ascii?Q?xP2FSDuwJhKmMwTtRRm5DneXKPv5qnNr9kK0ZW6aIqpBKzyinmr3NWSldl7M?=
 =?us-ascii?Q?Fl5yJB9tbFHGcYutPkUnBFIvmkE3qNKR01cJOSq1HCvl8IVlocjkBa/eghtj?=
 =?us-ascii?Q?3/4A49IWswN83RqXAaWanTUUXxDMuMJWswPj549HiezuuaEv6i8AY75zklYc?=
 =?us-ascii?Q?+Ttfeld8rqCr+BK5umveL+cgWKwuaDM4JsWCxiqUyOEQDUJEWYyUdzCxp1d7?=
 =?us-ascii?Q?ux2v0iLP6/4s+e8GlOhgSj34VUr16RdR8yMHfCAUX0zpk2oyLLffl/oqSKWv?=
 =?us-ascii?Q?wSsN905Pwzdt2zzo+r2AvMgrZJ3OqyijRiU8VBrpMp5+e6fPPpzwNUXVb1Z1?=
 =?us-ascii?Q?gAQ7qvXFrHw7+W9OpfAXFC0btzuXzJ2QGvabruUzaFXMYVaSf7pElF8osqjT?=
 =?us-ascii?Q?7Q8HU0OilCGkgG2uTeS9WDPgH3GZ0aFafWlSdgDCHJqK0NqZuO+g7A/Btxt9?=
 =?us-ascii?Q?mFH6wfoe4mnKM1N/j6sw3Cbp9yAOC2W3U63SyXDHCIYpzVHafvwYZCWqBpEo?=
 =?us-ascii?Q?2g633BPpqMCQq/9rETDInOdNnnIHGdltNBh8i8+T4uCsT2SMsUcomQcww/Mx?=
 =?us-ascii?Q?KKGk8rcoy1yd2hZ0uZqOCBaHMLdl965YscJhrplaB3rNVwb8fCJUNwmwolAs?=
 =?us-ascii?Q?ADkhgbyS8fVs/y59TiyEDFgTJPxfka+AUXSN2xnUJOEKOL6XHcbjawumlfJP?=
 =?us-ascii?Q?DRasEIVOyQT2QmGWiY05tlfqPJDRGd56FFfT6xxI+f7kOeWzpZzTP6E2rrjF?=
 =?us-ascii?Q?iOmLbR+MciogN93Q/ofiPC0qMDEyMXWILmoyGvlexIYfK5E4g203KpnLjSkQ?=
 =?us-ascii?Q?0nGsKR/uG2lh4MCrIkAEq9nEPZm0mJYeLIkIi3n3AWfPZO9XgunN5c+tzNHT?=
 =?us-ascii?Q?TzgQcUxMXhMCXjKLy+zmZc8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HciBche/BbWk2uIuSdgLrXRyP0b2a5Zr+y8RalMOAXt6jdh1oZHfLac7up6a?=
 =?us-ascii?Q?rWm0xu9JrJ5KKeNZS6WfXovBeiAPDeGAvs6obnlk+SHREQH61OIBlysYrWCO?=
 =?us-ascii?Q?r3xq/xN9Ae6kw0iPGM1rWMffq3r+GLFYhubRCLYHigXfNaGtIHDy1e+Dwm18?=
 =?us-ascii?Q?CkLaBZyz/0TzdlzXl3hm7rZpkKJt72Gpy3N+KXqfozYPl7zFdWsE5l9Jf3zA?=
 =?us-ascii?Q?BcWCPVHFuYfPVoJ+KyOUQmMAnmu7hAFXF3a7nDaF4OQMHVvrnfjyyY3HRzfn?=
 =?us-ascii?Q?MBmEtk1WOIUCUZUf3CGd5PGsmeDvK0bwvMhdSNRunmMKDNiPpf2JWJF++of/?=
 =?us-ascii?Q?V8DKdyXec9kd1lGAEZ/0MxYKthz88Z7K5rKYhYV/lNMiHr3Fp0oBmAfvLqJF?=
 =?us-ascii?Q?GTF5fL4y2AuwCVlifEaiuZ63uUCmjMpo5k91lv+4iwfSivTD3wNWmhhjvczn?=
 =?us-ascii?Q?fqvW1n2ZiYQlVAXo+nqN8ikoUrnmAKleSgtDFtXke0/KfgtH9/OBC5HzdLR8?=
 =?us-ascii?Q?JdMNIlNHb3jru3hBOxC5lLwxl3Izh+W0KHqdJPtgf0+fuVxI1B+gwpkMroq+?=
 =?us-ascii?Q?UN9TQWyfaRG8hgjkO+SFtmv2uqXR/vdkyrvb+SueG2SmL+a3Zf5OHXYq2xOK?=
 =?us-ascii?Q?URibi89ThnHhqlG0QCVnOy/aP24teZEjbnI9sr7OxeBBhNjYFNE6P+t/vwBn?=
 =?us-ascii?Q?MPUcRkfBneoi6l9ILBu9+Q/rKYdE/uoNpAJujacbsMIghiHu6f4ufnaBkPDS?=
 =?us-ascii?Q?5gPdveEwE4yXCWunjyux1QZBj4D9ZmCPNtB3OEdMtI/AJ0l2hGYwO2Fo1W8I?=
 =?us-ascii?Q?WiorXzMi40pJzwBrjlU8JO7CZTWLVsxIxOB68DyXetFWKBiTAYB54lWhmste?=
 =?us-ascii?Q?ny2U+gmUWqVM/EhO1Jcw5c6QIwm9Su9X2m2fnZFQPtgDyuBY0b/a3XrzFf25?=
 =?us-ascii?Q?Goe9HddDqrUDw1OkU1O4j+H+Miqs89Qv5/VFWwpk9YJoCyHDUTteLcM3pW51?=
 =?us-ascii?Q?4V0LgdhZivVuqO8lPxOyLN4dBNAO97L2r3wtKVCTNW2lf+/KIaXCXDpOZnd3?=
 =?us-ascii?Q?3A6kYypNwdNSRgRT6OtObLPY5U2S1gUn0Ao2PpzWXuW+xQpz/qYdwhHC6CV2?=
 =?us-ascii?Q?I4smS3VWuJy3hLimLCyp3ccULwXQNMovVNAns3gvRLJaue82+6RYzzgVtwn+?=
 =?us-ascii?Q?a6s6gFEg0ntBP69yy8szKnmIW0Eqt5DbrS4/7GPBEdzln8tg+69dGKZs66gv?=
 =?us-ascii?Q?wU8J2z9gZ7s7ckUKRvOBiQm2xfUTA1wGQ6O6YjwYjV+7ajjXCEqVYd3VDGcu?=
 =?us-ascii?Q?5kd8QV6YChGjkJ1WSLeCz3LNEgsWmhHP9EDLdOrp5+KqY2xb7OgjSTCITpPd?=
 =?us-ascii?Q?iwH3RvzX0wVJh5ZjHNhOo/0/0JdmzGxOzwMdfNLVXbjDmWrfp1964aTxkjHM?=
 =?us-ascii?Q?/NXw9DQRUb8K6v5ksqUKfZO8C6td9ds9V5uZicPriBmla3Hb+hRcFI0yE7JR?=
 =?us-ascii?Q?9s35rrDUP1BpjAhSMxc0N6LRIsU+FatS+jYZb3jJOL2RTZkd+iCBfaDNrfPc?=
 =?us-ascii?Q?bUtIq8h81hHdb8EeEKztiZDNDXSk++Yfp4qKvj4Ar1Isn/ZF4rV561al85js?=
 =?us-ascii?Q?xW5fAPb6QLQC8YxBvujn4/0mu2FWsd7kYCLqGjjs1qa51NSY0G951TTVZQkQ?=
 =?us-ascii?Q?wZxW09tCE705qoQqfyB8UPUbzd1X7WkQ0erqHgiH3o5i7RZEJ3Y/m8XAtgW2?=
 =?us-ascii?Q?DxoB1J3Aog=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd644bf4-4aab-42fb-2a5d-08de573ae570
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:12:40.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2LgzO0A/PQ30TZreRMnLfUpoK7rlnYPnPlkCV7tFE6I4vG4ySdLf4nRHbXL+PNaR8Cef6uyOmzTzI+dKdrHFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10762

The Mediatek LynxI PCS is used from the MT7530 DSA driver (where it does
not have an OF presence) and from mtk_eth_soc, where it does
(Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
informs of a combined clock provider + SGMII PCS "SGMIISYS" syscon
block).

Currently, mtk_eth_soc parses the SGMIISYS OF node for the
"mediatek,pnswap" property and sets a bit in the "flags" argument of
mtk_pcs_lynxi_create() if set.

I'd like to deprecate "mediatek,pnswap" in favour of a property which
takes the current phy-mode into consideration. But this is only known at
mtk_pcs_lynxi_config() time, and not known at mtk_pcs_lynxi_create(),
when the SGMIISYS OF node is parsed.

To achieve that, we must pass the OF node of the PCS, if it exists, to
mtk_pcs_lynxi_create(), and let the PCS take a reference on it and
handle property parsing whenever it wants.

Use the fwnode API which is more general than OF (in case we ever need
to describe the PCS using some other format). This API should be NULL
tolerant, so add no particular tests for the mt7530 case.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v4: none
v1->v2: patch is new

 drivers/net/dsa/mt7530-mdio.c               |  4 ++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 19 ++++++++-----------
 drivers/net/pcs/pcs-mtk-lynxi.c             | 15 ++++++++++-----
 include/linux/pcs/pcs-mtk-lynxi.h           |  5 ++---
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 0286a6cecb6f..11ea924a9f35 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -113,8 +113,8 @@ mt7531_create_sgmii(struct mt7530_priv *priv)
 			ret = PTR_ERR(regmap);
 			break;
 		}
-		pcs = mtk_pcs_lynxi_create(priv->dev, regmap,
-					   MT7531_PHYA_CTRL_SIGNAL3, 0);
+		pcs = mtk_pcs_lynxi_create(priv->dev, NULL, regmap,
+					   MT7531_PHYA_CTRL_SIGNAL3);
 		if (!pcs) {
 			ret = -ENXIO;
 			break;
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 99abec2198d0..35fef28ee2f9 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4994,7 +4994,6 @@ static int mtk_sgmii_init(struct mtk_eth *eth)
 {
 	struct device_node *np;
 	struct regmap *regmap;
-	u32 flags;
 	int i;
 
 	for (i = 0; i < MTK_MAX_DEVS; i++) {
@@ -5003,18 +5002,16 @@ static int mtk_sgmii_init(struct mtk_eth *eth)
 			break;
 
 		regmap = syscon_node_to_regmap(np);
-		flags = 0;
-		if (of_property_read_bool(np, "mediatek,pnswap"))
-			flags |= MTK_SGMII_FLAG_PN_SWAP;
-
-		of_node_put(np);
-
-		if (IS_ERR(regmap))
+		if (IS_ERR(regmap)) {
+			of_node_put(np);
 			return PTR_ERR(regmap);
+		}
 
-		eth->sgmii_pcs[i] = mtk_pcs_lynxi_create(eth->dev, regmap,
-							 eth->soc->ana_rgc3,
-							 flags);
+		eth->sgmii_pcs[i] = mtk_pcs_lynxi_create(eth->dev,
+							 of_fwnode_handle(np),
+							 regmap,
+							 eth->soc->ana_rgc3);
+		of_node_put(np);
 	}
 
 	return 0;
diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 149ddf51d785..7f719da5812e 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -81,6 +81,7 @@ struct mtk_pcs_lynxi {
 	phy_interface_t		interface;
 	struct			phylink_pcs pcs;
 	u32			flags;
+	struct fwnode_handle	*fwnode;
 };
 
 static struct mtk_pcs_lynxi *pcs_to_mtk_pcs_lynxi(struct phylink_pcs *pcs)
@@ -168,7 +169,7 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		regmap_set_bits(mpcs->regmap, SGMSYS_RESERVED_0,
 				SGMII_SW_RESET);
 
-		if (mpcs->flags & MTK_SGMII_FLAG_PN_SWAP)
+		if (fwnode_property_read_bool(mpcs->fwnode, "mediatek,pnswap"))
 			regmap_update_bits(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL,
 					   SGMII_PN_SWAP_MASK,
 					   SGMII_PN_SWAP_TX_RX);
@@ -268,8 +269,8 @@ static const struct phylink_pcs_ops mtk_pcs_lynxi_ops = {
 };
 
 struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
-					 struct regmap *regmap, u32 ana_rgc3,
-					 u32 flags)
+					 struct fwnode_handle *fwnode,
+					 struct regmap *regmap, u32 ana_rgc3)
 {
 	struct mtk_pcs_lynxi *mpcs;
 	u32 id, ver;
@@ -303,10 +304,10 @@ struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
 
 	mpcs->ana_rgc3 = ana_rgc3;
 	mpcs->regmap = regmap;
-	mpcs->flags = flags;
 	mpcs->pcs.ops = &mtk_pcs_lynxi_ops;
 	mpcs->pcs.poll = true;
 	mpcs->interface = PHY_INTERFACE_MODE_NA;
+	mpcs->fwnode = fwnode_handle_get(fwnode);
 
 	__set_bit(PHY_INTERFACE_MODE_SGMII, mpcs->pcs.supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_1000BASEX, mpcs->pcs.supported_interfaces);
@@ -318,10 +319,14 @@ EXPORT_SYMBOL(mtk_pcs_lynxi_create);
 
 void mtk_pcs_lynxi_destroy(struct phylink_pcs *pcs)
 {
+	struct mtk_pcs_lynxi *mpcs;
+
 	if (!pcs)
 		return;
 
-	kfree(pcs_to_mtk_pcs_lynxi(pcs));
+	mpcs = pcs_to_mtk_pcs_lynxi(pcs);
+	fwnode_handle_put(mpcs->fwnode);
+	kfree(mpcs);
 }
 EXPORT_SYMBOL(mtk_pcs_lynxi_destroy);
 
diff --git a/include/linux/pcs/pcs-mtk-lynxi.h b/include/linux/pcs/pcs-mtk-lynxi.h
index be3b4ab32f4a..1bd4a27a8898 100644
--- a/include/linux/pcs/pcs-mtk-lynxi.h
+++ b/include/linux/pcs/pcs-mtk-lynxi.h
@@ -5,9 +5,8 @@
 #include <linux/phylink.h>
 #include <linux/regmap.h>
 
-#define MTK_SGMII_FLAG_PN_SWAP BIT(0)
 struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
-					 struct regmap *regmap,
-					 u32 ana_rgc3, u32 flags);
+					 struct fwnode_handle *fwnode,
+					 struct regmap *regmap, u32 ana_rgc3);
 void mtk_pcs_lynxi_destroy(struct phylink_pcs *pcs);
 #endif
-- 
2.34.1


