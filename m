Return-Path: <netdev+bounces-246682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A33CF05C9
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 22:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED30B300941F
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 21:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0587324E4D4;
	Sat,  3 Jan 2026 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QdcDJOzm"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA201D432D;
	Sat,  3 Jan 2026 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767474295; cv=fail; b=TV9NJsq5AUl0ToxDTptYZhIjCIFUG1lzvhS8LAma3x+lcOby0Ac4FbcTHWZ9k/AKhm+wt2kIoKb/1zeqSPVX2Z+v5mK+Sv2d1gY/8Q6GhenYP5GoqOVDbNppnQxQC6hohnCuBlaaIA89h2DvNepm+ZG84DJlhewcj2xlGwBbQlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767474295; c=relaxed/simple;
	bh=lVqryZpqnPIYt/8kTsi4BGt9Om0agiBQ8RroS5kaQXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hJRr4+B+WNaRTohDzMeI+O6lsvE9J9LBv1mA8xKyt1agXg0uHl3D97HPWcDjQj3OuRA4tbviYS8fLvpyKeAjnWMQBtlvPMUy9i7m0s8uwFkMT8TTC6bvStSzXgqHAtdNpon5VPiD/R05ru9c6fUNuuFy1/nlSFYNSY/rlvWR8Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QdcDJOzm; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqxrLxvUnpbuud4U7BxAmu5HgWIkO90FkWsXrxhQwDp3CbLxb6DjrrcpFnns4MJh8Zzljgvvknmk2M8syLmY4Oqpj+NLhFWaT6nzh0Y85iqHS4pr74JEjm4UBSnVd6LP+QutrmbnPJiQM12so7D8e5SXwZ83kGhayEhGkUGMzmwteLnainGRu3/C11Gs6H9Yl6vt3ke5QZ8pnQNwKbplkagaKHeZSbq3rU1xz8ur0D2DKL5wHY+aMVI56oscafIiot58buCfWhkUpKwI/ULLAnIbmPbVwO+QUSp+PEvTCUZoEjmuXq20EA0zBNhaqnKK/Ts8fUCbI/Yu4NgJFGx9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/Mfkmd8JjVHQSB8FzrtF0IU8AwkarkjebLLOc6bWMQ=;
 b=zPG+ryAjwMNEPzz+XrEnzk3AXnrChd1hJjobj3AmNqxoh0ynwVlYhsSCTjhXXGlqAPdvDmBC9aEh93SBwPOU2rUQFOg3Cj1AoBfQx3j5Qv9bgzhOV2TeyP2nODxyaPBfYMczs/f4mT9OZieB2jJVy4eV6UKkaoI4hbaeCTnZeqe88hbB8Azd1GtzdsmfeE1IYClonmb/LCGqZJ/AYXl6YUzosO4SGhodOpdQJ9OAVT1KVaQWs5TPU/b0HYUbCgxbUYHmWDJ+PuoGm8MTWDdcazEVqm9bI6JFoQL7ha95YvvLnJso1xORiudIjOyzC/vFXDJooYW+u91E04FyvKCOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/Mfkmd8JjVHQSB8FzrtF0IU8AwkarkjebLLOc6bWMQ=;
 b=QdcDJOzmtBWDGshFADvlbWa4rMoMczginR69F1LnBsL0sPAkGlpjKm51PhF3IC4As4M7ZvWOyj56i7Eq0haJ0dcHyGj4g4XoEM/nowXnXr7++QnjnjrZEgW0t++VIqdjry4m3w2iLTrOX8xR1q72I5m7Rk76RxWwqv5sBUDHT6d21twDVbfLcHR6uZE9pdRl7twbTd4EV11mJUpuPihs2lFi+ngONZLX2s1hAx0gvrgUsTe/OSf9Zb3m5S0eRoSttHs+niCdBq3nfBPGo5eYhUuWzQqZPjMgOgjBu5Ld9d/9+7aVNS9kh5zeiT1ZzX2jScGyBFBCDGheRYp1gqNohQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 21:04:49 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9456.013; Sat, 3 Jan 2026
 21:04:49 +0000
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
Subject: [PATCH v2 net-next 00/10] PHY polarity inversion via generic device tree properties
Date: Sat,  3 Jan 2026 23:03:53 +0200
Message-Id: <20260103210403.438687-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: b3f6a792-bd70-4e3f-0228-08de4b0bbb06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enpvVFBJcDNPZm02bVFBdmVrNEZmN2RlcjZmOVFBSzdaK1JpVVpISnliSTVq?=
 =?utf-8?B?aUV2K2ovN29ydHZrZk1NaFhlSVFDYUFIR1d0ek9iTGNCaVJNRGRjOTJGcFBn?=
 =?utf-8?B?MlIwV1NpUWJGUWsxTlcwN1BJV1BNYlY4T0U4YTJrR1RpWmRXL3VCMWY5MWpr?=
 =?utf-8?B?dTBjckpCbzRNNC9JdDN3WWZNZ3VqTGRpaVBXV21tSW4vLzErbzJtZkZmbUxR?=
 =?utf-8?B?aUJPcEdvbjcwNTQwSGxFK3BvQjVBcDM2ZForM21XTG1lR0liVU1ob0RLODdC?=
 =?utf-8?B?cTU3VUVJc01qbGdUc0pjSWZuUDNJRm12eHQyQVZHMDFGalRXcjZmSE54UDUy?=
 =?utf-8?B?eldTVnc5NCs5YnBIUmNscnQreHNJcWFtTlR1TTVvWmIza0hKWjQ2czNrNXpT?=
 =?utf-8?B?ckR4MS9HcU9iN0orYitrZDM5SytyY0x2eEJRMktNeXY1cG5sQlhialY3TEF5?=
 =?utf-8?B?UTZEayt4OWRSRlBPaUI3eG5Yb3pZMzVBTUxzcUxFREg4eXdtdG1zQWVjUjIx?=
 =?utf-8?B?cjZGNEZSaGR2N1l6RlRBUmd0Kzd6TTlWVGZrNU53b0E4R0RMVEtaS3ZaSEpj?=
 =?utf-8?B?UUZ4bnExazJ1UHJ5MThodnpPaHp3aTRiblp0THM0eEZRa2hPaURqaWppaVl2?=
 =?utf-8?B?V01ZTXZoRngybElkajNwRGl1YjNFTXEzZnV1cDhmaktsS2F5NmdxNEFlWVlq?=
 =?utf-8?B?dWgxR1BrbTlIVTNjL2FKc3E3Y2g0aWM1VXFuNDJKSXFQakxoK3dXSXBSdFZu?=
 =?utf-8?B?Ri9RQkhyTmFnS2VUUEJmTzU2ejlueVVRdzdUOVFmUjQrV2w4VHlIOWtyN2Jx?=
 =?utf-8?B?b1NidXhWQVNxNXFJYkJHZlNCYnpkdTk2U3dLY0tvQUFFbzBvdVp5RTVDOTBp?=
 =?utf-8?B?QnNiWG4xUStnTm5sN2JQb1Y4cVY1MHowN3dabFp0QjdOaTdYT0tIaDIzcEJX?=
 =?utf-8?B?Nk10alRoTW1rV1ZCS0xXRTl2eWUrbktyQkNpbFhxVGU3ZEQ4c2h0UStjaFZH?=
 =?utf-8?B?OEZrNkdGYjBXaXRtcWliRURSd2Npd055Qi9nVWpLbWkwdWRvZlF5aVVUMWVM?=
 =?utf-8?B?OHVma0VwSnRvNG53VXBnMlFsQjZIWFFUdXVDcWZYWjF2S2E5MnhjQXA3VE9Q?=
 =?utf-8?B?RGptNG9TMDBFcHY1bU16T2JndUpPSE1DTU5CSGRXRXpmeG1XOXl4bGp3R2Jn?=
 =?utf-8?B?WlNwcDdUT296MFh1UnJTRFpzMEt3Zm1KUTY5VENqdXppMkZMMUJqeFVBWmRN?=
 =?utf-8?B?Lzl1NnV3RHVrR2V0eXhIcmJzbmVmUHJhVU1Da0lkbktOSDhydVBWbGd5NmhE?=
 =?utf-8?B?ZG9VSEo5UFdKQk8yLzJscFprRnh5WEY3Wk92Q1QySWNEL2p6TXlGOFM2T0Ur?=
 =?utf-8?B?ak5wMnZwVmFoaEpzRS9OUDhSZVZGY0Z3ZHhMSnAwWG82S2xMTnI0dUdKU2Fi?=
 =?utf-8?B?cklvWWtQYnRQL3dTalpabzNRdnpDK21hK3I4V1ZzSzMwNi9TZGlCM1YyWWo0?=
 =?utf-8?B?MmpvcldDSStvMkRjRW9zZXNpMHExdENWWi9VZys4ZDJmK0dISkMwQWUvdnNI?=
 =?utf-8?B?Rjlrd2Q0YjNWTVAwQlVtenl0UXJkNE0xRlBEUGYyOTZTVTMwVlFQcVZCTUsw?=
 =?utf-8?B?aHhTOTN0Z1dhYVN2enN3NDhzU3pURTFXU3pLSGo4UndaWXMwUHlDcnE4b1lJ?=
 =?utf-8?B?T2t5K1hGRGEzb0VxRWVYcmNvb1NtRXVRa3hheFg2V2V1MGNnelZpU3o1eVhi?=
 =?utf-8?B?TTlzYmxaQ2Qvbk85REVaU0I1M011akxQVmVNSlpYUkhUWmg0cXhxOE1mdm14?=
 =?utf-8?B?NkR5UmVXLzFRellLWm9iaVF3NnBvdmVWZkJVMUNnTlZ6ZmV1K3BySVhiSjFC?=
 =?utf-8?B?WTFUc1VoNysxUml0UWxzcmlEMFdTcFlkMDEyZjd2bGdheFVKb1QzUUIrTWc4?=
 =?utf-8?B?UHBlWjdtVmFRRXhJL3J6VnUrbFduc2FWTzRvZlFjRGdQSXlYcWlmSklLWmFS?=
 =?utf-8?B?bnBIWjFadGNLWDZ2V3pkQzFLWGdCbFNZWXBBaU9idFNyZTdRSVlscWhFdzR5?=
 =?utf-8?B?R1BBNnpLRjZqMmNIem5hUVBYUnVxcVBZTHNXUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU1MMk95WStDdThtMXl0QzJ1dGdneWZzODRKTjVhcGFkcE9JbitHVUU0Y3c1?=
 =?utf-8?B?Y0ZOcG9qamYraWFERGh2cC9YUUVxZTR5aWtHZzFIV3pyY3h4VUtWMjVOcDFq?=
 =?utf-8?B?RmZEbEpTZ0x1eGhEeThqcVNKaVJiRmVvbFNzZFpHM1NjWnRuOVNnNGNwbHVz?=
 =?utf-8?B?RTZGbU1uVlRTRmtKTEE5US9vMmFNVi8yb3piTUF2SEl5YXpKaTFyaWxQbmpU?=
 =?utf-8?B?VHRvT0x0K0FIQ1lIUUdmdG15aS9aUWJqcVlnR1g2UTM4WjQ0eHQ1TFNPOGZm?=
 =?utf-8?B?VDM2MUdqM05USkRkUHdHd0pUUG9zaWVXUFVKY1d4QVcxREREUitwWXk4dzlj?=
 =?utf-8?B?TDZjc0IxMjdQS0Jta3RobmppeVNqcENxK01HS3JMZGtQVys1RncxUWdYVHFu?=
 =?utf-8?B?emExeXRBWm5QQ2lFODFjV0MwOUxxc0VML3kwblJLSUtiUTZmYXdzV0VWUFFS?=
 =?utf-8?B?NTd5Q1o1V2hnVFlnYmhBQW9MdmMxeThvM0NxRmZQVDVJanEva251d2tqdHdL?=
 =?utf-8?B?SWk2WHlXK3o1Tld4QmdweTFsY2JtRUduUXpqNTQ0em9ZNlQvZllJaXNVV0sy?=
 =?utf-8?B?QnVEcElRaU9IbXpyMVVCZVNySmYwNFJaR0g1MStBOTJCUFdkazNqZjBCc3Nk?=
 =?utf-8?B?YW1PdHpBUWNUdzJCUlFpN0NWYWlzU3JaZ3NYOU41MWQ0UnY4Y3F3VlRjbnJI?=
 =?utf-8?B?RWl5ZER3dk9adjRmaXc0L0h2WlhVeEdPb2VXWnRTTVRzVVZ1VDBlOU5xLzZ3?=
 =?utf-8?B?MzY0Y1Nmdi9uaENNd2F1SkEvT1BMcnVMbWd5TUZpNm9iQ1A1c2V5cTFOMmlY?=
 =?utf-8?B?WUhKSVh3ZWgzbXhDZy9mTGcwc0lrZnpSREZhanlsc3VZV2ROazg3RUwvOEhm?=
 =?utf-8?B?SGE2Ujcya3Z2SmNXZEQ1SzRCZlZMTGJvdllrTHRQWFBmQ2NLN1F5WlJzZ0J5?=
 =?utf-8?B?QVBVTXVNQmluMmlka0p5MzRsL1dNc1A2WkxVQTg3YmxxdXBacFpFMnFjVW5B?=
 =?utf-8?B?b21kRVFiayt4Z3hPa2V6NllRVGxWcWsyNjdNK1hXLzJtSXpaRnFZbWNrVWd3?=
 =?utf-8?B?ak52MUlzR0MzYnZ4aGZlQkwyVlVneVZxMWtURis5OVdobTJLdFZnSTRybGxC?=
 =?utf-8?B?N1pLM3hKdEMyaitoNHFCcnlsZGJTZkpma2l5dTJJcUNhb2JPSTM5emI4SFVo?=
 =?utf-8?B?ajZMbW14aG9vUTgvRkV2M09lQ0xPQmtpQ1RleUd1dE5wTys2VUF5amhWUXFj?=
 =?utf-8?B?Q3NFc0c4TnBZSmxtTWdFMHYxcFlQVTBrdGNHU0tVdGN2QzQ3WTFSb0pJTnp0?=
 =?utf-8?B?N1ZLb1ZSYWZZNWNyZ010TzIrQS95eGhEUkFPdXRsdmxJcm1ORkhkVnFwZkhG?=
 =?utf-8?B?U09JT1VHN1ZtNUJqUGFxdVY4a2VkellMVkVDNUpjbTJXK01oRnJGRFpTbXRZ?=
 =?utf-8?B?NGR6dUVkclVPUitXSzJobGw0eC9tSDZFQ0FiTnJWbkw4S0V4dmpaaVk3Qy9t?=
 =?utf-8?B?RStYNGdUYkliZW1uTFhnVkFQdndiNHlnQlFYNmpMcEoxUG56dHdIK3JzUHFK?=
 =?utf-8?B?ajNKeDRqTDFjY3hHRko2UVJVdzBneHpFcmlKRWV3TzBnVUFhR1VpLytTeWtv?=
 =?utf-8?B?MnZXZ1BaZVdRckFmOTkxM1d2ZGthSU51a0NnNDdHYy9HZDhvUmxqOG1OZDFv?=
 =?utf-8?B?Tk9EVDM2UkZxN3l1NGJCWlRzbng3K2llYXJ0OERaYjZ1eUw3K1VDYVZKZXRB?=
 =?utf-8?B?OXlMMmpUM1FXcWUwd092U3Urb0c1Z3lJbFpVVHJDV01HQXhBbytHSXlQd2dq?=
 =?utf-8?B?ZVF4QXpIK3lOVTYvQi9iQ1E3LzczREk5T2N2VDRCYU5QMmV5SFZJUzhTSy92?=
 =?utf-8?B?emdMSGZyWnJtN2NBREVmNjc2Ni8yRmhXNVR1MXpTenJDZGpjZ0Y4QWlRSmFB?=
 =?utf-8?B?dlRzZlNXakk0SmFoK005bGtHdU9aQU5USUVTeU1SQWJSa3MxUUIwTjFMSjlo?=
 =?utf-8?B?UllqOHFFeklXd05GWkhoZEMxYkd2TVpJTUswZ2ljczdrSUdUU3I0ZXhMYUV6?=
 =?utf-8?B?cUJJaEZ6RmRPRVltMndrTUhTQkIxazFwNGdpTmVWRW9aKzNLNnVIT3BnQ0dM?=
 =?utf-8?B?bHV2Mlk3ZzJTNGM1Z0MyL2l3MjFvMlFjSmp0RGxRNU9wZHFmcGFyQVJyR2wx?=
 =?utf-8?B?OE5iZGVJTFIxeUdaVVlOOXNlZTVhYVlXeEdlc1NwV0xJWkdTU0dNNHdSL3Qv?=
 =?utf-8?B?M2gvSVhmWm4wL2pqSFErWi9KSDg4d2kzZTJ3bWl2dmg2N25BVDBVVDNCNmVU?=
 =?utf-8?B?MVArVjNCODFYRHJ3RTBUSXdqUlcrN3N3ZlJFYW14ekduNS82dXlpM1h6Smwr?=
 =?utf-8?Q?QayGH8JGvnQmqOxk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f6a792-bd70-4e3f-0228-08de4b0bbb06
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 21:04:49.0675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fr9AyTXZPtohn3Wpg/P5f8Ym0/gVyI/ie7drAPnEBt/ey3aEcXxABkXLynSmyAo/d1lPYXYAVDMhvZQN1QUIHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088

Introduce "rx-polarity" and "tx-polarity" device tree properties.
Convert two existing networking use cases - the EN8811H Ethernet PHY and
the Mediatek LynxI PCS.

Requested merge strategy:
Patches 1-5 through linux-phy
linux-phy provides stable branch or tag to netdev
patches 6-10 through netdev

Changes since v1:
- API changes: split error code from returned value; introduce two new
  helpers for simple driver cases
- Add KUnit tests
- Bug fixes in core code and in drivers
- Defer XPCS patches for later (*)
- Convert Mediatek LynxI PCS
- Logical change: rx-polarity and tx-polarity refer to the currently
  described block, and not necessarily to device pins
- Apply Rob's feedback
- Drop the "joint maintainership" idea. The request is for patches 1-6
  to be applied through linux-phy, then provide a stable PR branch, then
  apply patches 7-12 through netdev.

(*) To simplify the generic XPCS driver, I've decided to make
"tx-polarity" default to <PHY_POL_NORMAL>, rather than <PHY_POL_NORMAL>
OR <PHY_POL_INVERT> for SJA1105. But in order to avoid breakage, it
creates a hard dependency on this patch set being merged *first*:
https://lore.kernel.org/netdev/20251118190530.580267-1-vladimir.oltean@nxp.com/
so that the SJA1105 driver can provide an XPCS fwnode with the right
polarity specified. All patches in context can be seen at:
https://github.com/vladimiroltean/linux/tree/phy-polarity-inversion

v1 at:
https://lore.kernel.org/linux-phy/20251122193341.332324-1-vladimir.oltean@nxp.com/

Original cover letter:

Polarity inversion (described in patch 4/10) is a feature with at least
4 potential new users waiting for a generic description:
- Horatiu Vultur with the lan966x SerDes
- Daniel Golle with the MaxLinear GSW1xx switches
- Bjørn Mork with the AN8811HB Ethernet PHY
- Me with a custom SJA1105 board, switch which uses the DesignWare XPCS

I became interested in exploring the problem space because I was averse
to the idea of adding vendor-specific device tree properties to describe
a common need.

This set contains an implementation of a generic feature that should
cater to all known needs that were identified during my documentation
phase.

Apart from what is converted here, we also have the following, which I
did not touch:
- "st,px_rx_pol_inv" - its binding is a .txt file and I don't have time
  for such a large detour to convert it to dtschema.
- "st,pcie-tx-pol-inv" and "st,sata-tx-pol-inv" - these are defined in a
  .txt schema but are not implemented in any driver. My verdict would be
  "delete the properties" but again, I would prefer not introducing such
  dependency to this series.

Vladimir Oltean (10):
  dt-bindings: phy: rename transmit-amplitude.yaml to
    phy-common-props.yaml
  dt-bindings: phy-common-props: create a reusable "protocol-names"
    definition
  dt-bindings: phy-common-props: ensure protocol-names are unique
  dt-bindings: phy-common-props: RX and TX lane polarity inversion
  phy: add phy_get_rx_polarity() and phy_get_tx_polarity()
  dt-bindings: net: airoha,en8811h: deprecate "airoha,pnswap-rx" and
    "airoha,pnswap-tx"
  net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and
    "airoha,pnswap-tx"
  dt-bindings: net: pcs: mediatek,sgmiisys: deprecate "mediatek,pnswap"
  net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to PCS
  net: pcs: pcs-mtk-lynxi: deprecate "mediatek,pnswap"

 .../bindings/net/airoha,en8811h.yaml          |  11 +-
 .../bindings/net/pcs/mediatek,sgmiisys.yaml   |   7 +-
 .../bindings/phy/phy-common-props.yaml        | 157 ++++++++
 .../bindings/phy/transmit-amplitude.yaml      | 103 -----
 MAINTAINERS                                   |  10 +
 drivers/net/dsa/mt7530-mdio.c                 |   4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |  19 +-
 drivers/net/pcs/Kconfig                       |   1 +
 drivers/net/pcs/pcs-mtk-lynxi.c               |  63 ++-
 drivers/net/phy/Kconfig                       |   1 +
 drivers/net/phy/air_en8811h.c                 |  53 ++-
 drivers/phy/Kconfig                           |  22 +
 drivers/phy/Makefile                          |   2 +
 drivers/phy/phy-common-props-test.c           | 380 ++++++++++++++++++
 drivers/phy/phy-common-props.c                | 216 ++++++++++
 include/dt-bindings/phy/phy.h                 |   4 +
 include/linux/pcs/pcs-mtk-lynxi.h             |   5 +-
 include/linux/phy/phy-common-props.h          |  32 ++
 18 files changed, 944 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-common-props.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
 create mode 100644 drivers/phy/phy-common-props-test.c
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/linux/phy/phy-common-props.h

-- 
2.34.1


