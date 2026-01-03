Return-Path: <netdev+bounces-246683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C84DCF05D5
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 22:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A2AD301D9CE
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 21:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D1F2BE05B;
	Sat,  3 Jan 2026 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DfE7r1x0"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276EC2836B1;
	Sat,  3 Jan 2026 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767474298; cv=fail; b=DgaLHPKhQHffypgDbJPDONurAnAaiJ7ZXdV7JbCuWg3pWsmcJjOfQa/P4u5Daas9ec5UROmRKGPtHAeUBlukZF8nk0B7GHgKIEEZuhSJTvFBbkae4KJAG4bNzMf4FQKHahdKZi0/gSCB3nqwt9v0NDZ7krDvifVAzBvMMoWwkSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767474298; c=relaxed/simple;
	bh=SdbBMDsiU2sTIguJkFOI75PX+UBWwrrM302OFFPSM88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=drwtS1GaDces8DIYRyM7FHODVQuH7G/zsv75qz5c0bSQsjxtTOI+fPtxs2SM3vX6U4C/V83BAO+rbmnTxWLRoQtLrK9wcigysp5R5qQmmYGz9H69ClQ4/fnavkuwdNjfZq1sjRddy1ZDNeXyaG0xIo5kJggATRSjmfpoIlX9/fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DfE7r1x0; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEBmMgZ5i/f49IHE1GIEa8cMYLESTwIaD1RBDJXSaoywPka+YI1LNj4ZYV2/pYtoCmdrrgJwUcdNj7PZopyo9J+DIhnR4vZjYrG6H0WOaBVBImHEvL7RghZBKlr2fGaTJGI2Feb9ujQVDJ4Vvf23VtPcyy4uLzBFMl12fsaJotqf0PELYugLqhLUZOuPpML2XPZ5NMGFvWX2gt6WwTOtEe6OpHnzlMeFWbqDGh69Aa9pXluf9y7lJ8HnVX0sgMM/TdIPplVFYb5sV449O4kFuGTXAydulTPPJcI54C+Q1Qry2ErWggS43WzxJCS6sUM2qfzHH+rvSaJjbRGGbnIOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+NAymAaqlOGPZuwxeo/7VlnqTUzkMT1Ho3qoJMbjHI=;
 b=ecupom8WQjmLsF06ZFe3O4EVALTfY/gNlCI0Q5gOpJA7SQ4mXttiAuQ22uk7YcIuNGCr2rHKqeLUCyw2U//3OqlU9yVFY/Lw2lu5/cyIGV3u6c9buc3PBWWP9CO1pEEUxXxnOyW/J0P0neV0ro9eOkrV5HU89vx1ti3g5lBDOvOgmnjwJaQ0TqJU428V4+uhiJUz0zONxl8OtUl82xJlqk1a4MGd7TquMdO4EPj3JP+HL8e8NV6w2yeP2csj8uHZ23cCkjgPrSpqZfP1Tr9XiU/vU8kXmCqN7+KjC31ChpZrRIpm3BhnuhDf9KrbL2f8T5snwRt5TuutSttnsuiOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+NAymAaqlOGPZuwxeo/7VlnqTUzkMT1Ho3qoJMbjHI=;
 b=DfE7r1x0L+sc4ReTVg1eQ+CYXMePM3DOqdYyZHigoT9DTpAEg8pGIBus/7BtbJDey5S1QXLY5wXuW+bAglGx3MqUt8CRlZRXz8ronCpfc0/4I4AtTHakJc0ztQ7BUoyD6wHpk6a5/a1grTWndIudFfIPYbrbYuuhVGDeAsqLgJE52OgD+u34og0WR93BDPr1MUFDgyouS7xOFCtYuCqs4QyXURcMctl4M/Bd1aT0I+YAfp0oe0LaXfufmKG83lFC8rzITp1g9RGmR7FuR1pY6cZEzQCp7nWqKd4zVZgYD+5znP0CkfdIaL1me9832cIF6cd1XquGZRRWSGCkPQIMpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 21:04:52 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9456.013; Sat, 3 Jan 2026
 21:04:52 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 net-next 01/10] dt-bindings: phy: rename transmit-amplitude.yaml to phy-common-props.yaml
Date: Sat,  3 Jan 2026 23:03:54 +0200
Message-Id: <20260103210403.438687-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103210403.438687-1-vladimir.oltean@nxp.com>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::16) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|AS8PR04MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0cf2fa-85ea-4a63-d484-08de4b0bbcc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXM5TytDK09OUVphMHlHSFBPRlBseTYyS0xsUEF4eWFhYjZodVJMVVFzNDFS?=
 =?utf-8?B?YU1wK1JHYUZqckx0aVNNU0lGcWZQbnNzY1BWWTM2SEttQkorVzc1dG95Ukgv?=
 =?utf-8?B?T09zNW0zTzJYYUVjV293UmwxS0FrZVRYM2tXbFNqeVRwM2JER2gvSWkxcVJN?=
 =?utf-8?B?VTcrditseDltZENFbnU4blA0T1B2NE5pMWxMQ20yaWtOSXVOeEtaUlNoaWtl?=
 =?utf-8?B?UGRvM0NUQXB5L1BzNEs4WEpRcXhKaXQ2R0xFOElFUTNsZWVtT05rK0xMYkJm?=
 =?utf-8?B?TFgraTN5YlNnZUVPSkZySXU0U0JFQU5PT1FtZFRLWjBPVzl4MnNwZFhyZThX?=
 =?utf-8?B?V251SHJQSml2eU9IUnBoTm8wMUxybVhxMStNcklESE05cDVvL1czUUZGMWFw?=
 =?utf-8?B?M1NzSGlzVkxpSE9jbzMrQ29FLzZtaTRNd0dOWG5tTzFmNnlnbFVqNEh2RlJa?=
 =?utf-8?B?b1dWRmZoRGM5UjF4M0JDY2ZHNEkxRnpQSGJVTStCWTlKdXVaSlBCa0RIK2ta?=
 =?utf-8?B?Ny90QTB3dndaUG5pd0FqNHdIUWMyNUNGeXFaL1BOamwwMUw5bmJDVm1PdkFY?=
 =?utf-8?B?Zk0yMWxCN3JsSWhsNUQzcWx2eFN3c1dUSVowOHNrMmIvcFlKRGc2UkdBMnZ6?=
 =?utf-8?B?V1NjUW9QLy9SbUZoVHNYV2JPNFJYdUl6S3k2akdmWE4vRVgxb3J5Uk4vT2ZO?=
 =?utf-8?B?d0hFaVVmazVORkFZNWJlTmhXSGM5SkhaUktwZWdyeURxMjJaVGpXbXZvdkdz?=
 =?utf-8?B?UDRUZDQ1WVNmRkJ6c0pHc0ZRV0RIMnZaY0htcE5FZDVVVWlqdmg0bnQ5N2du?=
 =?utf-8?B?ckNMa3ZqU3FLS0p3NWo5QjB4YXBLWnlVdkJiSFhUYU1QK3JlYWg5YnN5SUk2?=
 =?utf-8?B?MUJ5VXYyd1JBWkNiMGpGZmExeFIwVzdBeVlnS0ZLZ2hPWkl3NW1ERjhMRzRl?=
 =?utf-8?B?T01nV2FGWVFmUHBFRDR5TmJsYkVqZjlORkZ4UXN2Z1RnM3pRSDBJUVc1aTJT?=
 =?utf-8?B?VDNENWFhUFJHTjBBUHpOU1hkWDZ2SDJKSUdKZTYwNUlLdEgrQnkyRkdPemRP?=
 =?utf-8?B?WnZHYW1VQmFGR0ZBNHNnemVuTUdyVGpRWTdSWVZTa3VyZ1pSbmtVR0ZVZU1I?=
 =?utf-8?B?Z0c0Q0JrTnJvdnhtSUQ5ZWxsemswQVdKN0didEtnSkQrUHBOM291a05WOElI?=
 =?utf-8?B?QnFIaHB4YldiK1NYRnpheC9YL0dFSWQ5V0laRS9zdmF3YU5qT1kxcHl2UUlK?=
 =?utf-8?B?dFRwMG8ySjJpbENJd2VQNThEOFJZS3VGdXF0bmNORFRjZEx6bG5rbDkrVWd2?=
 =?utf-8?B?dlFhYlhPQjdiOVZYQ0lydmdwclM1LzZKYVYzbFNiRE9LSW5DRUdKTW1aa0Ir?=
 =?utf-8?B?bUN0ZWFndmVEckQ2THB5ck5EUnFmMk9UbXFOM1dieU9RUVdHTGZyL1VWY0w0?=
 =?utf-8?B?SXZaM205TTV3U2c1Q1Z6emVzK21VUGVMaS9TYmtXenN4VHhkcXFFVnhzcE16?=
 =?utf-8?B?Sk5yZCs1RVV5czlqdWVneTlSY00xWGRMckpnalNKaFMySERZR1BTTFlmVEVF?=
 =?utf-8?B?ZTNqKzdMWGhkaklPYm1OcHBQNUZqVnZ2U0M5SlRyZndTZytBRWFOUkFMOHF2?=
 =?utf-8?B?SDZkdkRzd1owT2ZsV3BBR0p5WVVJaGJWNjJtdmNtY1EyTFB3eHdjQ3dCVU54?=
 =?utf-8?B?N1crV3RTcGJKNmVsTFdNaGx1WnBNNHBoVVdhcSsyWTFDQ2pVcG8vMFdyL00r?=
 =?utf-8?B?dHJMOUsySC9nck42eWZUeHhrcnV4M1BseVorakV6YVlYWkphRHVHemJIckhR?=
 =?utf-8?B?anRCQTZwbmI3bTloRkNNR2x3Nm1hTEx0aXZ3d0ZmOUJSSEl4Ni8vY3htbjZD?=
 =?utf-8?B?R1ZZbkVyTjBtS0RJN0NIQTVhM0t5MFVOS3VzV25oSS8waEN2NmREc2hXZHdP?=
 =?utf-8?B?RTI4THFxd2drRjBxN1lxSWtIcmZmSU55dXgwMi8ydXZKejJsc0IyWmx1QjFL?=
 =?utf-8?B?ajczSUVwMS9MZU1xK2h1eENPY2VZVFhBeDNtS3Y3Vzdodnk0aUdpalRDK3Fv?=
 =?utf-8?B?cEF6cERnOW5lY1VtWHJkWlZkZEU3dFhPdzQvQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWVVQzh5d1piYjQ5bzcrdUVBRnFPSUtIZ3E0RlVxeXV6ZlBKaDc3QWVndkp0?=
 =?utf-8?B?cTN1cHVKcktjZDBBaS9sbU5hNnRpQXBwMUF6QUl0c2VpZHVZZno0SDRrdTlM?=
 =?utf-8?B?RGhNQVdWQU1rR3JJNk5qQ0h2cU1TVmFSMDU0QkNFMVhnR0hrN0dwVDJFalVH?=
 =?utf-8?B?eHVEMGRldEsxeU04ODNUdVZoczdQM3k4NXlRdm9veHNQYmdDdEExVVJycGps?=
 =?utf-8?B?WkgxMk5iQzQ5ZTJDY1E3Wm5hakJYNnluZTV2K3NOaW5ySlJvUWFXSm11dCtU?=
 =?utf-8?B?Q0VPUm5mNG0rNkYzT2tpYTNQb1BHMStieVAyNzhHQ2xwZ0Rud2VWbWkzb0NU?=
 =?utf-8?B?cUtiZWFJTElwaWd5NUpFY0N3ajFlQVBPVjlDVENnU2hSejA1L2ZZbmt6SjRU?=
 =?utf-8?B?NmxWcStuVGNSSmZNSWtEdzZoQXpJbTNBWnEwQVJmQXpidzdXTTBWK00vd3Ja?=
 =?utf-8?B?MFZteVZFdWw0V3owdVlublY4bnVOcTBsTEU5b0ZHT1c1U25XV1ozT1pZUUNp?=
 =?utf-8?B?RE5sUVFHVDFudVhVcmcxcXJjYlQzaCsyNVR4TFhDVDBkM1R6dXB6eC95TVVr?=
 =?utf-8?B?TmRFYnI4ZWdPd1V1dFM0aFhRQlplMHpUNXc1dklNNzRGdkY0L3E5Y0Fxd0Fj?=
 =?utf-8?B?ZXlwSnBpZU5IWjdXNlRJSFV2dFZmTUhJU1VWYzVnbUt0emNheG1qLzZtdUt6?=
 =?utf-8?B?UElSZG9zS2hveWczOHRETEtVeEdtYzBsTDJKNWN0bWNXVCsvVUF5L1hRUFVG?=
 =?utf-8?B?cmUvR2cxMldBeHIzNXVUSjkvQVFrSU9DY2hYU3hpV2FjM1RmK0dIeDUyaDhP?=
 =?utf-8?B?bk1rZGhmR3BIb01Nck02QzlBWmtaSnBoTmhOMGJsNnZXL2dyR29abWdDUXdN?=
 =?utf-8?B?YkRJN1lrRXFDN3BJL090UmJ0VW1KL1A3blRCeVRpVVhVRTNYMStxVWVJMTJF?=
 =?utf-8?B?U3hYbkRhUmYzREE3RDl5aE9ORzFVTm1pZDJzN21CWDliZ2hxZ1p4Z2oxU0xi?=
 =?utf-8?B?RjlNNjlDU3JmZUREZjRtNDlRMmpTRmVXdlhXMVJoSlNqT2RGMWc0dzQvQ2t4?=
 =?utf-8?B?OUN2R3V3K20zbENNdU14YkYrTVlsTTlVSFozczFjVjcweU5CcWxjNU9IUEli?=
 =?utf-8?B?RjdqeXNsS0ZBMGtFczNraXNUVGRzU3lBY2wzQ3k4bTFFRzAza2JWVFhBYUlV?=
 =?utf-8?B?MnF1a2NuaHZZVTNLWU5VVkRNeFlVdDZjVDJEY21EZjRXZFFXTFhLVEp0WjBq?=
 =?utf-8?B?aVpBV3ZWN1ZDNHFuVUZ2YzFSMzJIdXg5a3hPampadDVLT2Z1TlBneUk4YnRi?=
 =?utf-8?B?VzdVeTVVMHE0TFM4dFBEbVdRazU1VHV3RE4xLzRBNnpwZ2lvUkNtRit1MDhn?=
 =?utf-8?B?UWEvbTUvRk1UaGpkQUJxdHFkaFFZc1FJbklkTHhkbUhzYjQvUUFmTjBNbDFo?=
 =?utf-8?B?bE01NVdST2E1QmdPSTNjTkE1L2tKTFM3NmMxSkpMTWdocXdDRm9LTWJjWlBS?=
 =?utf-8?B?Q2dWcTRta3lkQW02MXhPWDNGbE83U0prR2F5cmxMeDAvMFNhL1MyekRqOVBW?=
 =?utf-8?B?OWpnbTlWQVJWY2FYUlh2ZVNmV3p3TTN5TVRlYjkxdXdwRENjaTNFdlJQYitQ?=
 =?utf-8?B?SlRRVnRMc3FQZDNNRGt6N3RXQXNoby8zajRVK1gzTzN1SnBScStPYnBsZGJv?=
 =?utf-8?B?Nmh5NmRPcFFqWDB4Z01oZVRUOTVtcGg5OVB0ZFdlMHc5MTVlNjRHSVAwcFNZ?=
 =?utf-8?B?end3Sk9vU2FaM2ZlYlJZM2U3cGdubGVQaVlJeUJ2azBwRG1Balp5cnJUeklY?=
 =?utf-8?B?REVJRGU3OXNNenlpaW14eXk3TWp2dHZycFM0d3NTLzJpVEphMVFwaDNYdnc1?=
 =?utf-8?B?ZStGZ1gvR2IrWW13TW1hcGRVcUVWRW5meVVHczlxa2ZXOVdLV09Ick9JS0Rn?=
 =?utf-8?B?d0ZnZE5QNHBsM3ZyaUtnVHplYWY1WGR2R0x5MzMwZTEyekNsY3pOTk1tQUV2?=
 =?utf-8?B?WklJMEhLUSswa2FDZGlDMFIyczFsUzB5NGpQbTFVRStlSk9QSUdVZ3F0VElL?=
 =?utf-8?B?VXJIZVpPdDZCekEwRjRMUlI2c0xIa1lmaVN2QjBobzRJS2liTENuSitXYWh3?=
 =?utf-8?B?SGhXdkliQUZ4YWJ2VEpnc1BzR1drVE9kSUdMSzBXb0pKVEcyNHRXZnZzdWxV?=
 =?utf-8?B?VzR5M2hXUjNZZW0vSlpQSSt2L0p2cEEvdzMwTzNGN3hzSmJhTkNzVUU5Ymky?=
 =?utf-8?B?L3F6R0N1c0RrazZzbjFWaEd6NjdqK2tjRVRVZ2pNNms1NnZPQUZrRU9DditV?=
 =?utf-8?B?Mmh0WjJIbVFRb1lTOWRsSDBCL0txd3FuVzF5QXV3ZGtIc0M5dG5UQ2xnQU8r?=
 =?utf-8?Q?Nf2305JuWgUrN+5o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0cf2fa-85ea-4a63-d484-08de4b0bbcc4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 21:04:52.3362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yH1yl5aWkKNnlExB/Ak38cfgAwJm62fif5ZziM8m/ICigjSXGbOHDwbHU5pWEo35sTQrVxCCfrUMUDeARhQxQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088

I would like to add more properties similar to tx-p2p-microvolt, and I
don't think it makes sense to create one schema for each such property
(transmit-amplitude.yaml, lane-polarity.yaml, transmit-equalization.yaml
etc).

Instead, let's rename to phy-common-props.yaml, which makes it a more
adequate host schema for all the above properties.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none

 .../{transmit-amplitude.yaml => phy-common-props.yaml}    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/phy/{transmit-amplitude.yaml => phy-common-props.yaml} (90%)

diff --git a/Documentation/devicetree/bindings/phy/transmit-amplitude.yaml b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
similarity index 90%
rename from Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
rename to Documentation/devicetree/bindings/phy/phy-common-props.yaml
index 617f3c0b3dfb..255205ac09cd 100644
--- a/Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/phy/transmit-amplitude.yaml#
+$id: http://devicetree.org/schemas/phy/phy-common-props.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Common PHY and network PCS transmit amplitude property
+title: Common PHY and network PCS properties
 
 description:
-  Binding describing the peak-to-peak transmit amplitude for common PHYs
-  and network PCSes.
+  Common PHY and network PCS properties, such as peak-to-peak transmit
+  amplitude.
 
 maintainers:
   - Marek Behún <kabel@kernel.org>
-- 
2.34.1


