Return-Path: <netdev+bounces-223098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F7B57F56
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D337A622A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B4B316905;
	Mon, 15 Sep 2025 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ez5eOSg7"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4121A459
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947476; cv=fail; b=fHArPXPXPddNI4z9f5sG0q/9LZkwLbCILXA5z8yQBc5fECUjmmCXUMxwddWlxOyrv+WHd2RzO4Qe8nDTQTVftBrONVMMmFDII5JteSIlAqIYz/r1UzuctHNKCHagcsTiL648nzrKjA8IV07O+4Jwmh+0HAXaRt1zUU3zVht7qQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947476; c=relaxed/simple;
	bh=DTiY6gzL01r8deC1sMx0lacXGgMTfVSRF0H+H6546ww=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IHweiku7aYVEF8Q8WcR1kqsruzauO6UTSmoNAGoCquq7iZPKmGdbW1v44UBwayjO1CRtw66JDGG2Uz0H68YPRGbG0LoSR9pf+sVlkG6f8sLNbZW3d5OdGMazBA2U0bCuAPhEahiFDHHWxbtxZ2QzMBxnzCAp9I1Wn92GWMadNV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ez5eOSg7; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZgqyiU3Hb2n4drhEFM9eppWrpk8+mpAmPz62VVWIMoxyWcj9JnHnQmHGCpPdb8wJ6ms7ToJ2/wGDneil7NVR3XhwWaM8G/Y2rfZYg4ahLYlcDtlDZm1ocZfJOS+WXjC9CCvYxfXj2qpXOJNV9+Itq29jP6fNmhAlvahEeyDUEt2ZblGgLZVMC1ETFZVaI77Bu+JECQoyvwUGsXDdo7nup3BtS/R6KdewJ2/HDrUy0nx1TLpKpogRfz1RvKmnmWOWfchbPwzXk9bGixTp6pqY08UUxHVkEXQh/pwRL22ak5rcPtlkOODpRLofc1JfszsUjPJSXIXm0/2TwILVP9nxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAjnTtz0KuGxbDZHqurAXu/XAmCxE8Nbhouef/HC9U4=;
 b=Mdi/dGIYuSP56xB/ey/SDKEjI6lZJMSb9efIzbGRFzaVjxVzixJNNlZ0N7PiB2XaRWBA2lKgArwxHxsQsrAGe+J9s8M31s0b3Q52IFkF9yk0nbYL9+Oi0MtFDKAQTKUYloxNwOzPT534vvjBG94ecJQSNIJdNYIARUbFA/0e5c5KbikZRId5jTih19CXI5tEGE029wTLZWlYEiQT2War2afMwbcyf6OjqO3oQxVg158LmDk5ncfRgRn8zk3lpSgka4gOo1fK2pxbuWuwr7RGIzB/tJRN6yLrsYrBiyUgQmmuulaa313isBs6L/XfJra23wMEJ69o/38VVe/VFwhxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAjnTtz0KuGxbDZHqurAXu/XAmCxE8Nbhouef/HC9U4=;
 b=ez5eOSg7Y+fz9P5O4b9Ldlbvy+ZznOSXWGTHzMCiBnyaEz7PTaoxPsLXvesvFu2bf9A3pO7wFKQ5sOVgV5ZLx0dyAjVhpkvLTfa/3qqA8RNoW26Ac8EpSHIuD/RfDGl7XLONWR7j7Cfp95Sh2XHxC+UjWYd7BuinqB8gH20ZGqxJT2DHjFtycHJznyhcFtFfYka9kTRX+KPOeKIaHG0Ng7ddBXYb+kQicBUyQJycDxvtUicgxzrDyz2gLt/kuNa98BjfgldZu2RsYstyqlJLQcfliUd+g1l0ivEiExmA0F1D34iCI1lXJzPXbEeMp1v/gx1LjRELfzHJ7LqMol0/wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10723.eurprd04.prod.outlook.com (2603:10a6:102:491::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 14:44:31 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 14:44:31 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] tools: ynl: avoid "use of uninitialized variable" false positive in generated code
Date: Mon, 15 Sep 2025 17:44:14 +0300
Message-Id: <20250915144414.1185788-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10723:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1307ef-20de-4e68-c01c-08ddf466617f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVZOWmxndUsxdzlFTEdCck1TZ0J4dlZNRDltbHQvcWp3UGlHbnE3RHI2ZUVp?=
 =?utf-8?B?T3RnUG5Tak1oYlRKVGNyNW9RZXlJa1JNQUh3Q2o3OXd3QVlDTnFDM1Q1NmpQ?=
 =?utf-8?B?NHM1TWxqd3ZLeEkvTWFmeGwwSjc3V1hRMmlOcm1EbHVxc1NZU2k2K1c3MnlF?=
 =?utf-8?B?TXBVUnlOc3RyOGtsZEpmeHo3SHJRZjQ5dEhKN3ZxNFBUU2oyaXBTZFdPeTVD?=
 =?utf-8?B?Rm5LVmMvb1FOYWlLd1BvUVFDa2FkNDI2YmM1L05kVUZncXVrMHhQeWp6L3hL?=
 =?utf-8?B?L1BKM3R0SmhGVlVJM1VmRm9vS0hoTFMzOWI4VGFsMXJKOXpVSGhwRzBuOXZm?=
 =?utf-8?B?emErL21jRmV1SnRVMGN0UlBRRzdZUjVkYkFKV085L2oxdEhZbUI5WDJSaHBz?=
 =?utf-8?B?VmdiR3V2d1FzV25lTnBuVklrZFl6cWd6bWZoU2tFUEZHS2NweGo4N1dzSXlB?=
 =?utf-8?B?bjFIMlRTY1VGU0MzNTIvbEVXOEtYVEIwaW5IOExNc29UQ2IwQTZ1S3lrYy9s?=
 =?utf-8?B?N1ZMemVUNWI2Y2F1WEszK0VieGpESER4L3drdFNwSzd5RmdWWU9XNXhMREhx?=
 =?utf-8?B?cHZnb1o5cjEwK1JWUnlhN1EzMVNaTkNVL2hkK2dxOGNXK0pmWk5teldjLzU2?=
 =?utf-8?B?QVI4RkRkWm9YQmZZWWpZTS9rMStvRXF6ZEY3eTU4QlllS2FNdnNlbk43MEJG?=
 =?utf-8?B?OEdXajl1aGxGZWxGTkxIRDZ1RitTbVJIU0VJUHhTSDRleG1PWFZuY1Q0ODZ1?=
 =?utf-8?B?U3I3UVFwZEhZVlJUbSt0WG1xVVNxKytPMTc0VTN6Njl6bk9DVGNiOUpyZzBp?=
 =?utf-8?B?aE5uVnJ6WWlkcHM1aWYvZi9Ea3VLWFU5b2tWdjZicnFMemVveGZGbEZybHpZ?=
 =?utf-8?B?bXMyY2lFc1BseC8zTmhjeUVZWmI1OGl0Ty9uY0FmMjd6dHphcUhVQ21RcG04?=
 =?utf-8?B?ZC9tU1NNdWQyMXRBb0lXNXVlVG11b3Y3bmdnZXU4VTV0dnVNRk1OS213Y1pH?=
 =?utf-8?B?MWExY3gwQ0xmQXFxN0lvK25oU1o3N1R6YjNNUE8rWWpxckN1U0hrd3pROFFw?=
 =?utf-8?B?cnVxT29kY1QvdThGMmQyZFl1ajQxU002OGZqcmw3empxL1FuN2dZOFUzNWRp?=
 =?utf-8?B?Q01wK01tcTg0aU5QYUpWbXFmbkdoenQyd3FZdndMWGJZMWVjWlNva1h2T1hR?=
 =?utf-8?B?cUQ5dlZUazg0bFZxSTg2R0FST0FLWjAwOFljWGVyWis1eG96U3kvbFVERWVC?=
 =?utf-8?B?dlA5QXBYUGExeW53RmZHRG1PYnRCMy9rVmRTdHJydWtmVnRCbFBsQVVLellt?=
 =?utf-8?B?R083NUVNRlhBWll1SHEvZ1c4TnljaXlEVE1DM0c2QWVzKzZJRVpkK1VVYlhV?=
 =?utf-8?B?TTUxbVdSY1U1cTZBVXVhVkNnQW9aQ2F0ZFAyajMvTXhYejFaeXc5QnNwVmtQ?=
 =?utf-8?B?Mndqa0dBd0V4UUFPWkdXb05FTFBxYmhjd3R3T1UzWFFjY04wSm9tSFhsby9t?=
 =?utf-8?B?NC9aU2dNd1dSR2Z0RWVOeE9TMnZhZ3NVdTQ4cWJSTHpDZG1lakovSFpWZjdB?=
 =?utf-8?B?aFFIVk9DVlhUZkJ5ZDJsMUFQYXVFU1JjdVhVeFVIRjVhajJWdE5EaDJmdnVE?=
 =?utf-8?B?akpyYjRnRHRYbDNaTmN2WkVlODc4bTBpVUZscmpqUTVYWVZYdGtoazFuRFFW?=
 =?utf-8?B?MDhqRzhjM0oyY0EyYk51TkxTWERhcmM0NnUzS0gwVkpoLzd2M2txRUtKSWdP?=
 =?utf-8?B?RFNHeFloUVQyUjJsWlVKNDlPTGkzdkNPcmtTM1JYMVVCaU9ZODdjYnFob1F1?=
 =?utf-8?B?anpwS1VraktSQU9rRkhIOFZxbk5ZNmVrT2t2aHJ2bkVGNEFGRDJWOWJXRVdR?=
 =?utf-8?B?Umg0OHRaWVBQVW5tZnpQNXlveGJTUkk5clZaWmt3amxkQ3FIdlMvODVOVnhp?=
 =?utf-8?B?RlVnYXJtSHJSMUFzK3N2QWVOMnVoZWkxcnpYcHU4SEZyK0hJb3Z2eFEyQ0Zp?=
 =?utf-8?B?Wk05R2Z6eUZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGdicW1DSWRlVnZhMERTTW4vN0RzWnh0M2lVMFFEcjU1OXVaWS9VNUtCZUZW?=
 =?utf-8?B?U0hTTjhudGJoRnBSOTBjOXY3TDJxMHg5SXFVTnUwaGxRZDBsMm5vbzJMdEdN?=
 =?utf-8?B?Y1N5bHRCTzJWQkN3Wms0TThVZGlJdVhSam9rZEpRbFVlRmt0aVhCSDFIaDVs?=
 =?utf-8?B?L1Z0aVBGYy9hTFZ0MWRRMk1LamNycmxjVjR5L1FIRUYwWFBMMWF2ek8yYWNP?=
 =?utf-8?B?NEUzcTczVlF1Z2Z1ajNyRWorZE9oZXRMUWc2V0hxTzhDOHdPTWxoTVhLbEJF?=
 =?utf-8?B?VnFKOTB3TnNRVm5YT3hRcWtqK3hLQXBVRzcrUmlFbm9OdzR0SWZBOHk2TS80?=
 =?utf-8?B?c3BhTUYycGsvODRneHBnOHVEVXJrdUFtV0xlZDhLdm5yWnJsakpvUVoxTFg4?=
 =?utf-8?B?ajBDWmp5aVZaeHVEcmxiOGFqeDF4Smxxcy91RGh1Y3Z4RDF2WHkxbmcxVlVr?=
 =?utf-8?B?VGVna0VwZ1U2SXlwSllWSmF6YUpYNmVmNjJpbXRPSG5hREM4S2tjcDJsa2dv?=
 =?utf-8?B?V2FoSjFUTFRrR0YxNWlBTEVTcTFTaTNRZDJhTWZwb1Rpa1J0SERPUzd3UFFS?=
 =?utf-8?B?bEJteEpWOWI1MC91Nk9qOXprcEI2eDJxN2JwVVFpQUFma3BSbk5CK3ZxUjI5?=
 =?utf-8?B?dGx4Qnp5aWR0Z2o4WHVOS1lJMjFwZGZmVTJMMFFoWnRTZ1g0R2hXMFFUeElw?=
 =?utf-8?B?K0pHN0hXYjhCQ2NBM0RLSlJrV3RGeTd3ZTllRmRvRVRidHpRT3B6VThLanV0?=
 =?utf-8?B?aHJwV3dValpzWTJLK2JxdXM1NGdwb0w5czJHalo2N1Zka2dkeHdKRG00TzBj?=
 =?utf-8?B?S2R3THlDcFNLb3k0QTltNUI2clNhSjJUN2EyQWRwVStwYk4zNjRJemRpNXBN?=
 =?utf-8?B?bXBTb3NPQXc1a0ZpdHBxYVRWSklndy9ZMlZTSzlwSXU0b2FVWmdvb2tPOXJm?=
 =?utf-8?B?R004dmxIekRWSk1aY2duR21NM29YeTRLelVlM3RFZm9nL0lBMXpyNFlQcGFa?=
 =?utf-8?B?ZnJUb2IwL2xCOTlsekJJNEw0UXcvbE42OEVQRXpBT0k1WVlWQk1MMmpkNXhm?=
 =?utf-8?B?ZEtpQ25pRlpudDFhN2FHbXJxOGppbXk0ZWpRVzBrZzhMd04zSVVDZnRqVlpC?=
 =?utf-8?B?cjl0bnBrNDVDS0FlNVpyYWsxaGVtRWcwTVg4U3F1TjNpbVRHNTBNeUt3YWVj?=
 =?utf-8?B?UXJ5RW9zUUcrTUJGWCt1c0luckE5clYyUVJOaENOMlBFL00xN3RvMmY1dGpk?=
 =?utf-8?B?cTRoL3lHT0htR0w4NHNGcGoxMDE0azBUQWxZSVBWMXh1WjE3RGFoUkRWa0hP?=
 =?utf-8?B?R0R2RkJmbUtkQjB4Z0ZnSnppSStkRk9oQVdZbnZKTndvZUNyMlVaOEV5bWV1?=
 =?utf-8?B?OXkyUmRvK1R1YnFLQnE2MzU3a2w5R2QrNHJVZzJvRWQ5Q2F1OWVYZTVnTXcv?=
 =?utf-8?B?MjREUWEzak55Z3d5OHhIcENkNERvWFJ4TkJmc2ErWFZZUWIxV0VjNlZTWkpV?=
 =?utf-8?B?RFdlTWU1YnZKTktNZk10TUZtNndGVG9JcWhaUHEwVVlxWTh3UTF5ZFVXakFV?=
 =?utf-8?B?L3VSUlh0YWVsdTRqUHg4UEVhTzdLeTNhMEN1VFFqUWx6aFhhcDd5NXlIYWZq?=
 =?utf-8?B?citPNnRDZWVISlp0VUplN3dnalF0Z3V1L3dlYkdmREQxcFdPQTRyenRuOGJQ?=
 =?utf-8?B?MmFCbHZucU90ZkhXRjBLaTJaRUZhOVdobWdWZ21UNkRkN2dRVzNnWStGWDYz?=
 =?utf-8?B?YzNweVpQK1RRTDRoRExzUitGNnRyTzdGUDUrRFR0VlNNQjZ2SklwNUpOWTlo?=
 =?utf-8?B?U3lEeGhRM3ZLWXNuWGRvVWhXZlhxbVZRcERXK0pIdG40NzA0OG5NOWorUHhC?=
 =?utf-8?B?UjhWTHR5cmJsU2VsR0c4NUNhK0o4elY4T3Z0ZFB3QWo5YWJTcGxQUDhEUDZX?=
 =?utf-8?B?NS8rWE4yRFdURFNsVXkzYlhLT1g3N1ZydStZZzRNOGllWmVPQ1Qrc0dRM0Fp?=
 =?utf-8?B?RU42MER3TlhMcEZEODZpL0lVRlNiRmYzb25SQkRJODFkcnNHUUxPc0lPNjJZ?=
 =?utf-8?B?TFpnOUtHQ3FkbDZCSjNTMCtOWWYrVlM3aVFDTnUvQ1pPb3RSb3RGbnNRVzdG?=
 =?utf-8?Q?L01E4mbR/DhhjXOyyhznKfpyq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1307ef-20de-4e68-c01c-08ddf466617f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:44:31.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPL3wcVBmSTkAfD+QivWOImP3TDIFmAtdIDVvXq1JudDWlkUvE7lRT8MuYxp6xjPwyOZlfUtt7nBRDfRlp5QXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10723

With indexed-array types such as "ops" from
Documentation/netlink/specs/nlctrl.yaml, the generator creates code
such as:

int nlctrl_getfamily_rsp_parse(const struct nlmsghdr *nlh,
			       struct ynl_parse_arg *yarg)
{
	struct nlctrl_getfamily_rsp *dst;
	const struct nlattr *attr_ops;
	const struct nlattr *attr;
	struct ynl_parse_arg parg;
	unsigned int n_ops = 0;
	int i;

	...

	ynl_attr_for_each(attr, nlh, yarg->ys->family->hdr_len) {
		unsigned int type = ynl_attr_type(attr);

		if (type == CTRL_ATTR_FAMILY_ID) {
			...
		} else if (type == CTRL_ATTR_OPS) {
			const struct nlattr *attr2;

			attr_ops = attr;
			ynl_attr_for_each_nested(attr2, attr) {
				if (ynl_attr_validate(yarg, attr2))
					return YNL_PARSE_CB_ERROR;
				n_ops++;
			}
		} else {
			...
		}
	}
	if (n_ops) {
		dst->ops = calloc(n_ops, sizeof(*dst->ops));
		dst->_count.ops = n_ops;
		i = 0;
		parg.rsp_policy = &nlctrl_op_attrs_nest;
		ynl_attr_for_each_nested(attr, attr_ops) {
			...
		}
	}

	return YNL_PARSE_CB_OK;
}

It is clear that due to the sequential nature of code execution, when
n_ops (initially zero) is incremented, attr_ops is also assigned from
the value of "attr" (the current iterator).

But some compilers, like gcc version 12.2.0 (Debian 12.2.0-14+deb12u1)
as distributed by Debian Bookworm, seem to be not sophisticated enough
to see this, and fail to compile (warnings treated as errors):

In file included from ../lib/ynl.h:10,
                 from nlctrl-user.c:9:
In function ‘ynl_attr_data_end’,
    inlined from ‘nlctrl_getfamily_rsp_parse’ at nlctrl-user.c:427:3:
../lib/ynl-priv.h:209:44: warning: ‘attr_ops’ may be used uninitialized [-Wmaybe-uninitialized]
  209 |         return (char *)ynl_attr_data(attr) + ynl_attr_data_len(attr);
      |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
nlctrl-user.c: In function ‘nlctrl_getfamily_rsp_parse’:
nlctrl-user.c:341:30: note: ‘attr_ops’ was declared here
  341 |         const struct nlattr *attr_ops;
      |                              ^~~~~~~~

It is a pity that we have to do this, but I see no other way than to
suppress the false positive by appeasing the compiler and initializing
the "*attr_{aspec.c_name}" variable with a bogus value (NULL). This will
never be used - at runtime it will always be overwritten when
"n_{struct[anest].c_name}" is non-zero.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index fb7e03805a11..0155695d1842 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2107,10 +2107,10 @@ def _multi_parse(ri, struct, init_lines, local_vars):
     for arg, aspec in struct.member_list():
         if aspec['type'] == 'indexed-array' and 'sub-type' in aspec:
             if aspec["sub-type"] in {'binary', 'nest'}:
-                local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
+                local_vars.append(f'const struct nlattr *attr_{aspec.c_name} = NULL;')
                 array_nests.add(arg)
             elif aspec['sub-type'] in scalars:
-                local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
+                local_vars.append(f'const struct nlattr *attr_{aspec.c_name} = NULL;')
                 array_nests.add(arg)
             else:
                 raise Exception(f'Not supported sub-type {aspec["sub-type"]}')
-- 
2.34.1


