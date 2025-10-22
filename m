Return-Path: <netdev+bounces-231790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E147BFD8A0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC03440478C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE492BDC15;
	Wed, 22 Oct 2025 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U6EhOVuj"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F2D2853F7;
	Wed, 22 Oct 2025 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151857; cv=fail; b=iGSI9r+8zJwOSZRM4R5sHjp1ih/3O7ixssCDXfFmh/OfLW10wWfrgkrSLKQe1iJ1g6HyFqpRjgqK4XgmUNnGsNHSsS/rKDd5wCW/pHdam0EqWwd8SeyzvkkGqvrAoM0tgvDpMzYK1fndfSDFsn2DzFGm44EsKAE3gXMnQJ2p0NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151857; c=relaxed/simple;
	bh=rCXH8qyHyUG2ZMZ211STrGGjMnV/HfAktzHe6TPYbKM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=n2R7CtAmDHv3fxjT0IJsK8cix09rbwclIAG5N7S9bXkYGIiQdQS/1W0SYaZvq+eQnJaA/0ifrNhflUj2UofZ9VNhZK+dinDeCkRfyazKSentD7ChZNVVnFVUzt5cuJFxve8g3VWnqFTHw/SI8GWXTKznB1ylDCJ1xMB3aHecvYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U6EhOVuj; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va1kWt4D7cXUnljQxBuvNlNUC/BTMxsPP9n/f8FWVt571iHKIvbKWX4O3mMhbbuEY4qwUIvkuNoJeJ6TZUU8FX0LZwRyJzW/xj7MTwuEiqd3ynd0DJmC++K9sDibZaD69jH7YXBGof8nvc32be1DRUkl9tdwT77tQfmm6sOWgUGE+QNZGVrLQ9Kw4UkUf8SU9uW5Zu9VR5WsPGfwgF58V4wFWfGZfpoavHnVTpvcDWQwf0PITiSC2qtO3Sq8MgXHKHQHOYzHsubDYpBErpXsygl5FIkzx3vIBaiTJRUA7YckpdfWKIxmouIqIGIwPBzzaYrQNiLsp7QWuI5f9h9hKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZqfZ3Sx0toAHbiREkI+mE+XeHlb2E9RF49DNJAxxU4=;
 b=hSf9w+zjxcCvT3M1tAJqNEKi2hLn0KslmUKqdskiztevrs7QNOzmINHUQCCnOBQWlLtCGrgbjirdLHoFSivTPY6+DyY4j4cRIX/OqOOvLGDpg7F+eMFZtT9GAjur8vgsy4DRglG6lc8Daqg6YBOxg6KEcW/Uj7rXmy/VlCC1ozRglfTTno0G21r39UZOc+r7/22JHFV8eRIhgw37C18IeMUk3kTkoWGd7x+T1YGWNkvaRB85AqxzwiAWg4Qs4TSigewHcgQXa4hZmr9Dp2g0/2QPv4yjkIq13p7GH1ZqmzAWyQXPAJCYzdcyFr9LbB2ifHne7BQeO4aXrBjzHDkt0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZqfZ3Sx0toAHbiREkI+mE+XeHlb2E9RF49DNJAxxU4=;
 b=U6EhOVujrWUEJV0St1sO/9eLG2WJgT83gk9+z1ydZgBspBkIgInolYaMYcRN34tW/Z2oyYGJBZlMmQE3AK+bqXbwKFIlRGs8+ppqvDj46GboNPBjKQmBz3hIf4eUkKmEeNbhVERKO1cxAy1vynkLGhv9rdheuUIPkacfvCbN/78pAfjXDSxDvw7FZZRGfhUAiKOfpEDjr71cTqjJUGfu6fkzh90K1Jo5+ewaOprCahbc+YWwpqLgC7VpXCzG6w6thQBslb8KZTxWeurhYJUmH1kX+jgoSb8yqDp1RX4SERKuVQ01mjK9ImtRc8Jng9zq3/LrZPRVC4CWj2zn6/bYMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 22 Oct
 2025 16:50:53 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:50:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 22 Oct 2025 12:50:25 -0400
Subject: [PATCH 5/8] arm64: dts: imx8: add default clock rate for usdhc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-dxl_dts-v1-5-8159dfdef8c5@nxp.com>
References: <20251022-dxl_dts-v1-0-8159dfdef8c5@nxp.com>
In-Reply-To: <20251022-dxl_dts-v1-0-8159dfdef8c5@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761151835; l=1632;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=upJw64mzK2Vfly8GHUYKiD6RaHVo4ZXI+OiITDAiOk0=;
 b=gV7kaEE5K0+s/asHLVAxENWU6/C56ZX8vwvAOxStb8/sybTbKxHJZR1qUhVxxO7l3TMJ79I8J
 2r0byPutMW3Bn/9QLOPCLZNwQ6+N5gyf2ZclLyIR5kLp/F/TVIl3x1S
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CH2PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:610:56::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU4PR04MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: ba82ed3d-cea6-498a-45d4-08de118b29bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFZ4MVhaeTBzZXBBT3R0QzI0QnZoQVRydGg0QmpxS3o3em9CMitvTE9NOGwz?=
 =?utf-8?B?ZTdySUJ5R3NNOHJ4TVF3UU1EK0M2d2JieTFTWWIzYjhzMHhWOWcyS3dwSDRX?=
 =?utf-8?B?bVZFYzJtSFJ3cEkxV3B4akpXbmZJQ21hZ3c3anNIbVpUbWxGWVIyT2tJSHlP?=
 =?utf-8?B?UEl6RDR2ekR1V1VTSGZETTczM0M2ZzllNE9RMkp0TDFwKzE1QWxvd2k0TXdP?=
 =?utf-8?B?K1UyQit6dU1OSTNmT09VSHBjeXBXRnNFMjZoWkswUmdWUzZPaklad2kxejVQ?=
 =?utf-8?B?cHlOSVlpb0Vvdi83MkFPU0dTTUl0dzJuL01sU0EwY1VoTTg1QVZBbmRwaE1K?=
 =?utf-8?B?NzR3SFczNGo5ci9CeEduY3lxck15ZTNjRklXQTA2T1QrSWNxV3JkZ0FJVkdz?=
 =?utf-8?B?cEtuZHRhT3hITzZxUGNYS2tKZVd1SEdNaEEvaW81WTlYbVZWaUd0TFFaZzRw?=
 =?utf-8?B?L0M0TERDZ09QWXhnUlFGSENyd3N2TXFUYmtPVUZ6OGxha3ZLUk9lc0tyQkdK?=
 =?utf-8?B?SURZUjdPM0NjY2RwUW5yVWcrZXZLNVFhd1IrRGh6WGtQVzRiQXNRWjJSNE1L?=
 =?utf-8?B?YUYvYm96ZXJkelhjVlFRMXVMdktqVXJzZDZpNE16U01COHFZTWVSV2pVdDE3?=
 =?utf-8?B?M0c0NnRiOGVHUndXVkV3ZGtVc1JQZlVwZ2VwbTFSdE85STUxOU5FT0M1YWI4?=
 =?utf-8?B?OWtrUURaMGNNS1VXNUI2VGN2bk9JUWFpbnk0L04xUHU4dTJ0K01HYitCL2pH?=
 =?utf-8?B?QnBYQzFRUmVYVXl5bkY0R0ZIa1BjR1lSQ0NrYnZnbmZ0VHFWMThrd1hDWHRR?=
 =?utf-8?B?Q2tRaFZhVWc2bHVWaXBWc3lNcktnbWJ3SUtudEQ3N3lQMWF4Vjl6Y0RDSms2?=
 =?utf-8?B?QnRuWVlVTktOd1dadlVQcE5LaHV0T3hRbmhJaVV2QjBHa2RySkRQNENHc0Q5?=
 =?utf-8?B?dVdPeVFoUHZMV1VqS1RFR01KREZvZjRBblkyKzhVNzJGbnFGZFRWRERVcTRa?=
 =?utf-8?B?MjFVSDRqYzN6UkwzRTFYYVNQb2MxWHN6clhaVGc3czEvakRCcTloRTd4S2dw?=
 =?utf-8?B?QXVhbDY5RDhoUzRtaWxFTWR5eC9SN3RmRHZwTmlSbnE2WFpETi9qT1hSamxB?=
 =?utf-8?B?ZGhLWUIxTVhzZVlFL0FBZklvWjlRZjFwVno5UVFqM2grRmVIcjFoRGwvdmEr?=
 =?utf-8?B?UmpQRkxpeG10QnhOSkRqUzR3di9HYURzUlB3c2ZCNTFhQ0FQSllUY1FDbSs4?=
 =?utf-8?B?aEd2UHBHVk9WRG9RMnE0OCtIVjE5Y1lxbThjVUVWdDkrTm9mVGhMN2hXQnBn?=
 =?utf-8?B?OWlob0VkM3FscnZVRjR4alhGUUFHQ0NlSE9ZaEVxTlZBOTdGTjlrVnZqT2Mx?=
 =?utf-8?B?ak5CVkVWOHRUN1JlUkw4QlZWWWU0c2hYZUVWK3JrZ0w4QmY2aUxRdDNNeFJw?=
 =?utf-8?B?UHJib21rcmI3ajlUdnpXeGczQ1g4N3greFJOS250MUszOExYRHUwamFyU3Ny?=
 =?utf-8?B?bWo3SUJRTTFXRElLWHFtanRKd1R6UzZTR3pLelljczFxdFV0L2pQZ1NjTUMz?=
 =?utf-8?B?NVcvcm0vMjljSFQzZzA0eU1tdGpMUHhoSFBjQktYQVQxS0F3YnNSaUw4Tlk5?=
 =?utf-8?B?eVIzUHNmVitIclV6VXNXdlh3YlNwRHExNDZWMDJ2U2tiOE5NYXVmUUtCdUxl?=
 =?utf-8?B?K1JjOW80am1hTTgxaWp6RmIxOHR0L09RbHp4ZGxvcCtJekpKa2svcmUreWlI?=
 =?utf-8?B?UlpmRWJPTFFqd0l4VlI5czdmc3RDVEU4Y0FNSnlUNkRpMC9FVy9MK1ZEaFg5?=
 =?utf-8?B?Q0ZiOVJxR3pTODQ5V1RoYi8rdWVDU2N4NzhuaXZNREpvSDFNejRma3pBd2hx?=
 =?utf-8?B?VjZWclYvN3J3Z3NjWFhMZXB4ZGF5Zi90YXQyQnp0eTdQZTNZUWNkY2VmS05s?=
 =?utf-8?B?RU85T3pKOVhuQ0xpQ2ljb2UzekJobFo0dUxmenk5UkRLbWVkZll0YnR6cmZt?=
 =?utf-8?B?Rm9jV0lBa3dRSzBTc09iT3R6OVdKZVorRXY0VUFpK3pDb0Rwem8wT3FzREVt?=
 =?utf-8?Q?yNwY2f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmQ2RUdnaWZTOGltcnJtam9WejgxazRkeGlFMTQ1V2Y3bXJwRTMxZ0VWS1Y4?=
 =?utf-8?B?a0tUdHhlSldwb25EMDN1VDBzbmFnVGZ6WkZhT2x6OGplN1l2eFI1c05BTXlj?=
 =?utf-8?B?d2s1MUY3NjNUMjRUc25nY2VHV09NVEVSdjU5dCttTmtWM2szTGlOZ09BMTZM?=
 =?utf-8?B?OC9tQjhkUjZTd1hhTEQ2VkZxYWVWMWRmWWVpWGx6ZklHaWFFUHlKd1lzSUJW?=
 =?utf-8?B?VVJwTVdySTZyby9heUVjMFBtRXEyV3RJSTZyRGEwQWp5UDhnbkdlcDd2cVRX?=
 =?utf-8?B?Qm82UVNid2hva1BBamVSUzdkUmx2Rk1qTy9KOXZWWGVJbHI0UFJjVytvRHF4?=
 =?utf-8?B?czhLWG1udk15bDgyWG0vWE4rUG1xQzR5Y1BuVk9BT2laTGcwSU5idEk3Smdl?=
 =?utf-8?B?cHplMWY4ZUp1Qnl2VUM4V2gvR3lVU2MxLzRsa0NhVFlaamQzcDZ5VnlIS2F3?=
 =?utf-8?B?YVEzSkFkUHN0TGZWaFpWSmxsV2UwcFE0TkxBajU4MmxQTVZTMnQ4SW1xcE1C?=
 =?utf-8?B?eEkyL0QyQ1ZwVVhUa2U0RFVLMjhHa0NRQm9FR282VS9SSlRnSW1VS0dJNExZ?=
 =?utf-8?B?L0FzRzhoSGE1TFlmbld4VHl6dHZja0lxSnNNcDRaQXd6K3pTbmlrNVdmbnhn?=
 =?utf-8?B?NWljZ3h3RjlzaVBYTlFtcTRiU29WS2M1Nlp4Q284MHZ4b3ViSHI0c0dkc1lP?=
 =?utf-8?B?SllTL0ZRZWdtQk9PbWVWZVdFMEQwL3B6OVdCNVJ0WXdZMFIxYmJydURJMFVB?=
 =?utf-8?B?ZEgrK25rbkNOQ1pVYzRmNlJHNHlNNlBWaUNIN1Q0aFZvODFpOWZNSkNnT1VD?=
 =?utf-8?B?SGszV3lRN2ZKR1VLRVhGU3J6c2hIazcvVjkvWm5QdGRCUlVDNnc0bmMyZWVw?=
 =?utf-8?B?UkEwQy93czVnYkNYR3F6cWlpZ2hvNy9oK090eXd1K2RMZGNmSGpZOTBzNDJp?=
 =?utf-8?B?Uk1FUFZYc2lCbGQyRzM0eXNIam1aQUFLRUZJNWhPdlo5czRnTGpRWVdldnBW?=
 =?utf-8?B?WUt3aTlnOWkwSFk0WHlmTmtlTnRZc2l4VWt5S00rZTRQZmVJZXRDdWtlWnBo?=
 =?utf-8?B?LzNBOE9pK0NGaHQzRitEWk5aSnBNUDh2WDVBY1NudkVwckxkL2g3Z3FiRUh5?=
 =?utf-8?B?SlRqZWtJencxREJqem5oR1k0TUVnYnZ4MHJ5RU5vNjI1KzJMbW9nYW1xT0FN?=
 =?utf-8?B?WHkzY1JIRStKMG5tOXg5TStFaTFGNVlXbnF0Y1BiNFJLbENxUkdXa3dNY21R?=
 =?utf-8?B?K0gxckFGcWhCTDVuKzFDd2VQazJpUGJIeU1Zblk5S3JKSFMxUWs0L1E5Sk1o?=
 =?utf-8?B?SFRaejZ3c3QvT2pGVmVNbnlCek00MmtZdEVKUVBZbzhnZTdvbkdQNDRGRElD?=
 =?utf-8?B?UU1YaFJzRnlqeFFucUtqYnBqQ1RUVWFHcG40d0xVRWpPcXNwTDZjT1g3ZEdj?=
 =?utf-8?B?S3JBYkhUajE2aDVVRzU4QXVwUU1uMFFtWDR6TjR2ei9vOGhPQm5Tbnk2TzhL?=
 =?utf-8?B?M0Raa0loaEtFZ3FielVHaS9BU3dwUmowWHBpWHRCUUtsd1hScHlxL0NBOVNL?=
 =?utf-8?B?SUs4SDdMRys0aTNVdTNaTXczNXhwY0xLVlpWek11WHpGUk9WelFsT0NuNjZp?=
 =?utf-8?B?U3QyekF0ZmFXOTA4c2xKdEQ4TmlRSEtyWFd6R085RTZoTmY5QWRWaWV3ZUJv?=
 =?utf-8?B?aVFXSnRhNWcrQmd6amdsaDk2ai9TSGxhRGZmc3l3dTd0WGZMdEU2TVRaWS9P?=
 =?utf-8?B?THdOYktOaGFqYU9JUlFodW9QNTNlSklGekQ2bTN5YVN6M1A5enduc1VjSk1U?=
 =?utf-8?B?aVR0TWNVcURpSXU1WEV3TnBCeHJyS0ZUdjNPSUFIVUcyQVZtQkdzUGliQ0gr?=
 =?utf-8?B?KytRVWVMWjl6dUQ4bXRSOWdVS3F1Z0plSm1NbEorWG5rTWhJOExlRCs5a2JL?=
 =?utf-8?B?NFFmM0JoTFlSZ1FZMG9DSGtPTG9WNG41T0YwanFzSW8xVXRCdmk4NXJ5VUJD?=
 =?utf-8?B?RVU0c1FrN0hPOEdiRUpvTWFuNVJRM20vTHRaNWJUMnlxY3ZwcXo1TXVoU2Nj?=
 =?utf-8?B?UVRiazc4S0dPODZQcHg5RzdNa2VyQnFiSHZldXQydkdzQzhETm9KTXVPdms0?=
 =?utf-8?Q?bqOE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba82ed3d-cea6-498a-45d4-08de118b29bb
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:50:53.5220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6lGrIokXy5W7iAnt5votRV/jVFAi0ex5+jJ+WR4akyuXUmhYDF2llGizE96bE2NcVFs6LyzjmsQgpiNw7XA9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

From: Shenwei Wang <shenwei.wang@nxp.com>

Add default clock rate for usdhc nodes to support higher transfer speed.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index ce6ef160fd5506cf6430be321ca75cb658669335..0b8b32f6976813515bc8d9dce5486074d0ec8b7e 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -77,6 +77,8 @@ usdhc1: mmc@5b010000 {
 			 <&sdhc0_lpcg IMX_LPCG_CLK_5>,
 			 <&sdhc0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "ahb", "per";
+		assigned-clocks = <&clk IMX_SC_R_SDHC_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <400000000>;
 		power-domains = <&pd IMX_SC_R_SDHC_0>;
 		status = "disabled";
 	};
@@ -88,6 +90,8 @@ usdhc2: mmc@5b020000 {
 			 <&sdhc1_lpcg IMX_LPCG_CLK_5>,
 			 <&sdhc1_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "ahb", "per";
+		assigned-clocks = <&clk IMX_SC_R_SDHC_1 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <200000000>;
 		power-domains = <&pd IMX_SC_R_SDHC_1>;
 		fsl,tuning-start-tap = <20>;
 		fsl,tuning-step = <2>;
@@ -101,6 +105,8 @@ usdhc3: mmc@5b030000 {
 			 <&sdhc2_lpcg IMX_LPCG_CLK_5>,
 			 <&sdhc2_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "ahb", "per";
+		assigned-clocks = <&clk IMX_SC_R_SDHC_2 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <200000000>;
 		power-domains = <&pd IMX_SC_R_SDHC_2>;
 		status = "disabled";
 	};

-- 
2.34.1


