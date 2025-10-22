Return-Path: <netdev+bounces-231793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E76CEBFD7A9
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08488568E04
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF0D2D23B9;
	Wed, 22 Oct 2025 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bW4kTCIY"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013014.outbound.protection.outlook.com [40.107.162.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC52C21D4;
	Wed, 22 Oct 2025 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151867; cv=fail; b=SVthxegq4NPIkY8SByihnC7qcpsCidscf1csoSkVv+o3XjugOuekHEW19fia04o3Q6UuZSr0+7NAxojLOpATjltN6atwW29ErOgrfHv3jztmwsDBJMI5PuCyvJU7Wt+4FVV9hDWI1/smPaFEpRWBsFHdgdQ/plzLaTMt+0WZpiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151867; c=relaxed/simple;
	bh=UlggR4rCVyTJy5OocdFOpwOfQqszgEbe60v9QhMyfos=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PRJKdwZqfgqgjhbEgA6w9jc4fCGeM6pYBPQaGBHqhMyp42VxlNUYuM3qggRVRN/LI2PQgiPbu+e/kR8hJbw55PD5sbnoAvXrX9m0mncH6MDRZsYU4ijCAeVteG7+mAGuBAstmnu7cEQFKzsRUhq7N/fRex9/NCuenHsCSGzucqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bW4kTCIY; arc=fail smtp.client-ip=40.107.162.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKwW/0UtF5N4GQLNLYAf4B/lGE/biS2rnl5KMX2GFVLx1RkV6xdY6VaamQdGAz4c0kczQoRdUjZEJbtAYDngIyKYUFUt7/PPGJsZrJROYaxviTdiF5fIaVDkUX6+kK85Hjixs4tg5yqqZYtiWIgNHjRCO9D2qDJ09EzGqlNUcWVof5YVVSrPeP9SYbfm2gsDSeSEnjpU6yWUZZSpQEoXNIa52BD6+gfWOkfzp8q6xhbcpp4QtBQsQjuHN+byl/xQrTTT+sV4T2HFMR1hWgww3+LidCXmJIiD74FKIPIr4yTvKA8Ka9nvYbsNTr1h0xIpdVd4QPAaw6+58C2X5vH1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cb5Mf6uEowkFE9tQQbw/xVpXI2jLAef/r6fnGIr3ko=;
 b=CbmuaT+A/EzWcNg3DWj8eb2r+WH01tGMS/EEKOZVDi5QvE6dnWM13aP3X9wIHc6OWGT00p414rAy0BtCxePAA3Scrki7iLwKZAFW47ieM4fkG3wcSRTsJUq3RfCh4sGhNcQLFfRx16YvPks/wSqGOrBj2sZ9581I7uIEFS5RLJSjIkwXDSnvGvWA1FuzfNOmtDPdIU7jN6fWQzj9GqUs1k4+1nYYcHJ/+t+nIalKg9CG+K/Vhfpot0mw862TlqvMp3fMA23DdQcYYTIT+u79aHEu22w8GcPF5Xw8p2XTwa3bf0+zSISkwdPIuaCy6g2dy1/w4oOL7IBipGvPLxt7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cb5Mf6uEowkFE9tQQbw/xVpXI2jLAef/r6fnGIr3ko=;
 b=bW4kTCIYUq+9g02zc0Dp7+zJf9SWENyhTrvGaT0dlyR1zST55Pnha+UdU4ry0+YY/U8Tey9xc+MG1H1CIArjf4azh38DtT15Wk6Stg59ADf8Jrj0g7ZBIQS8IXSe2FPTTVWkA33GxJm1CKDh7mSyfO1vwFB27/AvG8OfnEBUn40boPmP6BklyfoMxZ7TMI7U3/GWFu0soxEN8gGBlG4mYzJybfBwxtUH7XP1L9Q6J6QKqdJeuDyCnTbOcgNSlL3L5URFxkU3b2SZbixKwZSyPKvVzA9gtCLk83E5035Jkzh44ylBdrDowXZzT90yi2w7LlVmUhc+OliHd0nN0b7w8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 22 Oct
 2025 16:51:03 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:51:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 22 Oct 2025 12:50:28 -0400
Subject: [PATCH 8/8] arm64: dts: imx8dxl-ss-conn: delete usb3_lpcg node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-dxl_dts-v1-8-8159dfdef8c5@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761151835; l=740;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UlggR4rCVyTJy5OocdFOpwOfQqszgEbe60v9QhMyfos=;
 b=fqVtsSWLHnzoPbBqb6DrfPM2qWTsDJmtv/EOJrX0pZHKZ/MftjlrOBvn71BPB338RbeW74sEh
 /+ioEKSpRq0DllcscKInKANg4Mxs/Iqfgs+XVzg5Hu8gI2kK5R9P0nA
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
X-MS-Office365-Filtering-Correlation-Id: 498335f6-3f59-4d4f-6259-08de118b2f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmRIbVlpalo0OHN3MktSN2NGM0o4UXNvQlMvdGdKTU9EYTRLMVdUZWNEKzFK?=
 =?utf-8?B?MEhZeUNaYUJRMjJ3aXh1d3d1UUJISXp6b1BpVktnYnRJRzFvMWNaL1Z3MUJW?=
 =?utf-8?B?ejFnVDJqUFhaOEZkbDdMRnJJOVlITmluREtVMEpuWllrYlV2KzlhVzl4bEtt?=
 =?utf-8?B?L0tFYjh6KzhERmRJNWhWTXUxWXovZlQ5K3FwaVdRVllhV3M0VHNVVWhROXBI?=
 =?utf-8?B?TzRrOHdQb0FsQlN0T2RTV0RacGhIYmhVT3V5N0dvK0dDTTA1QzFnZGxyelFH?=
 =?utf-8?B?Sm14Y0NHdnpsYXNCeUl4RXAzYk04ZHpTVDU0WmUyZld0ckEzamd2ejdyb0RZ?=
 =?utf-8?B?SWxRODQxM0lZNFhPc2R6RXo0bTNwZExneXJHcjdKNTBScHVpdHFJUUVnLzdJ?=
 =?utf-8?B?MklIZmZUMHI2MXAxSlZhSmkvRVB2Z0RRb2JHS0wrRzlDUThZb2c0VlQraFli?=
 =?utf-8?B?QzRNdkNvNG0vbjBpdkMxZGdGb052b0c2TnJFWHlpbmE2VlpQclRuS1FrdGFu?=
 =?utf-8?B?cVp0eURZU2NPUzBPZkhaZ0xObVpoUHZLMmN3bkZpSGdkQzVuOVl3VDhvTGdh?=
 =?utf-8?B?MkkzM1hOUjE5Y3NHRHpMazFGN0toYlNidit6NklhZ1lZdWJhR0JSZ0gydk9C?=
 =?utf-8?B?TE5maTg2ZlFaWGYrRVNBSFBSdnRwWkFBcW1hNCtBdEtSUTN5SU9RSDZjU3Rp?=
 =?utf-8?B?UUZyQzBmNUUrckZCWHdTTFVrMStyUEVnVGoxM0RTWG1taStmNk9vUVJRTmNs?=
 =?utf-8?B?YVpkQ1Y5Mk9mWHJWOHlKZkxIdmhkeXpOcmhmRnBtMmt1V0ZhYzBSK296eFp5?=
 =?utf-8?B?THB0cWpoblZPdlN3WHhsUU1EbU5UZVhaSisyaVNQTWlGdGVwNDgvMUZmYmFF?=
 =?utf-8?B?NWpSZ1JWSWFCTnYzWjdabXIweE5MWFIvVmYxSW0vZ1hneXVVZEFjeG9tbk80?=
 =?utf-8?B?Nm14YTNlNkZRT2phdnIxRWMxaGtFOEsvd2xkN0UzUUp3VE52bnBReUhjVHdy?=
 =?utf-8?B?Zk52SURLR3g5SExQell4U3p4TzBQdXhRa1VTTHF1bGo3bWVwQjhrU1NqUFNE?=
 =?utf-8?B?UHh1Z096bVRoR0dNeTA0UTNBNkZjSFptbGRzMmMxYnZIUVh4RENNRjFJbk1r?=
 =?utf-8?B?SnpYbUJrYjhVaTNLZ3hhMGlNSFJ6SGhRSTNqNzFxeGNQUXhhdmgxakdiZnlu?=
 =?utf-8?B?Y1RTWVVwRUxJNGl5MU9tRU82RUVOVjd5ZUFnRFdDRXRsSEV2bGNTVmVmcmx1?=
 =?utf-8?B?Z28zTzZxZ1JJelR2bGdFVURlUkIxTnE2VG1WRWIvRGxhZXB6RE1jWlJFUkFz?=
 =?utf-8?B?L3Noa1hzR0tUQlJqT1VvMHo0Z2NsS0V4QjhvSW1FM3Jud0NFbi80eGhJRWNO?=
 =?utf-8?B?Skw5a1kzTDZZZVg5ZHBKK0ZJU0VldjJ1Y1N1bzRYSUlycUpJZ0M0V1dMY21G?=
 =?utf-8?B?bkhKT2tWNXJUSVFyNzdNT3k1M3JzMHFqZEJFUUtLUE1vd01LZ1BuOFVZQi9P?=
 =?utf-8?B?T1RvdVZhakRWOTBId1o5QVlId1hMeUN1cHdFeU40cm4rYVl1Y1ZuWWgrdUNo?=
 =?utf-8?B?MEozbUJ2VFgzaDJnN3BWN1MvbHBlZkdHSDFDRkRCbjRXZEpOVmdhMXFSS3JI?=
 =?utf-8?B?blowQTFUdzU4d0Jncis5L3BQVUZkMTdGT0ZyZEYvZWpTWmZlWHlPT04vc1Bi?=
 =?utf-8?B?MnRkK0FtclJCR1UwaE9XUzQ0OURlQVZRUnhyUnFheEo4bTMzOFg2dFYzZzFX?=
 =?utf-8?B?dytZcGYremtOZmF2Smkyc0RSNnYxL2g5TFdmZ0VmV0FYUkdiOTNCVmFnbURM?=
 =?utf-8?B?NUZJRWIxQWx6VkZrVmlnK0pzSUoxTEduUVlWZmQxUzJrQzUwMmc1TmdJR0V1?=
 =?utf-8?B?MVNUbmFTTXlpKzRka3NGN2ExVFV3Z3BvM1dGbXFBaUFmbUNvcVptMDZnZDY5?=
 =?utf-8?B?UmtuUjBOdm1rLzdzUTRpMXBPL1FWWnJZeHZaQ1V5bkZKWGhzMXhveTJGalQ5?=
 =?utf-8?B?SGorT004Zk9HZDFYUVY5OEZtbGZia1ZmTU1GbjRHNmxzWS9ubnpLREdDRUk4?=
 =?utf-8?Q?qStT/k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG9CemV0aDRVejFTUmNyRzZFbVM5SFhFdWdiUkRuQzArS1NlMVZNcXltY2Vr?=
 =?utf-8?B?T1BrUjJudWh1U3Y3Zno3cE91YzcvbXpkNUJVRmdqNDFpZ3dtRnlJRHhwUGxI?=
 =?utf-8?B?eWFtL01ZdEt3MXJGczlsaXZmQk5QbTJWTlB2RVFtVGphR3pzanByUTc2cktn?=
 =?utf-8?B?TEd4Z1Q2TG5YOG50a2FyVGhFZEVpa2luL3VhcVhiaUNaSGpPVitWZHlpYlBE?=
 =?utf-8?B?VjFZTTJKaS9HMjd3K2hzTjRXeFNYeDhObU8yeWJjdXdxZGNNTjd5NHB0azAz?=
 =?utf-8?B?STJFam14OHo5My9XWHQrNHlsMUJBNnkzNHZNd2dJV2cwVWFMKzlUSUZhSTVl?=
 =?utf-8?B?TU1pbnk1U09qZXhRakdTYTBlWmxkWll5WDVzbEVTY0VyRjVFdjRRczQzam5X?=
 =?utf-8?B?cDdjZDNMRytET2hpNm1oajdVc0xJbFJxWjBqU1ZFcEFSWkJVQlVzaWNIMHJs?=
 =?utf-8?B?eHIzNWdqRlQ1YlVHZW5tL0FKVndZVHZzUE8wcWlyVVM5QiszaDhDVE9uZ2c2?=
 =?utf-8?B?bERjK1MraFRUQkgyWjNGK0xIMFc1aWU0cyt5L3RHL0RvcXdQdHhKV21pVGZa?=
 =?utf-8?B?V0tYMENXdzRpdTNBYUQ1NnZyeUg0N0R6USt3WTNDcXY3anRKWDJqZ3g5OE9o?=
 =?utf-8?B?amdUNGxUUjlMTE1kSjZKbC9CSjhydmhkdEVYQmZrb3VLRVVSWHRSM3hGREsv?=
 =?utf-8?B?RDJtRzRuMFlDdDk2Rjd0MWlURVhPWmhiTjlmTmNOSHUyQXp3R3R2ZzlNVW1N?=
 =?utf-8?B?R04yYjFpdDB3QTBMcHJtMmRyaGwrOUlXbTNjNTVYL244MmJobWowR1dHRkMw?=
 =?utf-8?B?VE85ZGxoRkxheE14WjBpZDRydHBsWS9OV3pvd2NKZjNSSHU5VWJzaGVCb2tD?=
 =?utf-8?B?aUV0YUttc2RHaEtiTTNQdzhGU05ZdnFXeVM3MW92by9kTUtGbVdNNjB2bmdj?=
 =?utf-8?B?bkhVdkFyaHpsYythZTkzZGtXRHI0MHkrYUxjaXZ1dVh1eWpYRWg4UUhvK2hZ?=
 =?utf-8?B?NWFiRU1IWFBBcGFrd0lyTXpQOWlWUFptMXdhNGNaZlZLREU1L0NDN0ZsbTRw?=
 =?utf-8?B?U0FmekdHZW8zK1ZKcDlOV0MwR1pIdDdBc3RqL0x2T2xjRFVxQmdIRmtWM0J0?=
 =?utf-8?B?dWc4ZC9PVUFYbUNwKzZRZGNrL2pNbTJMWHhrUkR3MXRZdkpqMGpkUWVPTFlr?=
 =?utf-8?B?NGFCL3ZycE5QZ0FtaTRqNUxZajI0dk10UUkyZTZyZ0pjSzhQV0FQeXJPSjd1?=
 =?utf-8?B?TlVrdURUUmo1eFNvNmNvOHg3T0NtREdnZXB6NXJRT0tvSUFIU2Q0ZmxsT3dL?=
 =?utf-8?B?M09GRE9NdktBZjQ3cmZLMXFwcXZqSWs4dGxpTG9tQnUxemJQeWE2ZGxQQXlP?=
 =?utf-8?B?c3dLeU04QkNtVGRLN2VpZlFXWWZDUk5XdTJGWThqeC9TWDh3dkVFV1d3U09Z?=
 =?utf-8?B?UzYrZUgvTDlpS1JqUUQvay9DNWcvcTlFR1poOGhCUlR5WUppeWhjbUNOdU9k?=
 =?utf-8?B?c0RCcStPL0RwbXRPRWFpNk1naEMzY2lodDZaRlhKN1p4N2doYXhZWDVES2V1?=
 =?utf-8?B?WkRZcHZtRGJzVVBLTlh2VmVVRGlGTFFOV3VjUWtraTBMd0dJd21GVThjSmJu?=
 =?utf-8?B?QXBUc2V3MmJwSDJ2cUhnSzM0aDdHN2s4cysrczg1RUpWN1hxWHZpTUNDcUVT?=
 =?utf-8?B?UHpHQ1VZUzdDcVcxRUZLTW5TT1c2U1E0ejRIRmVDYVo3TFcvYU5Jd2ZNNklC?=
 =?utf-8?B?Rmk4VjZFNk9Bcnd3WmRJQzJGYkxiSWZVdnhML2I4WGQ3VnRpMzJndW05bTRI?=
 =?utf-8?B?MWhHcHVWS25LTjRlRm9tanpnaG5BUExFTStPaUJxdG80bS81K3BNT0RyaEJU?=
 =?utf-8?B?bXFhZFJEdURRRHJtbmc1ejYxL0gzNkhFQjRLQUJGNlpRcFhxN05QS0l2SGJx?=
 =?utf-8?B?R2l5RWN5L292YjNrNXZhNVRPa2lxckFkdFRDazRNQktLbkZ3bXIvcFhDZEVo?=
 =?utf-8?B?QTl5Qi94SHZDWWpQaEc5dnhpNk5FaURET0VYNXFVbHgxc1ZFMWVTNTFPd2Ni?=
 =?utf-8?B?RnRoQmZvVFp5b3BwL05JOUx6ZWhmanNmLzg3RWJJbHdrL1Z1aUxJbENkOVRW?=
 =?utf-8?Q?4u6k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498335f6-3f59-4d4f-6259-08de118b2f38
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:51:02.8875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OruJ+7pssDlq9buoKnhmGrsdP3s8iRWNNgrgnV3SVhN5mKvIuRBaCPlpTFCJubum5XlUYYH7q2oBsPtAVwUNEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

Delete usb3_lpcg node for imx8dxl because not exist at such hardware.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
index da33a35c6d4660ebf0fa3f7afcf7f7a289c3c419..74f9ce493248ee9431e81f23bdd9125c832c02f4 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
@@ -7,6 +7,7 @@
 /delete-node/ &fec2;
 /delete-node/ &usbotg3;
 /delete-node/ &usb3_phy;
+/delete-node/ &usb3_lpcg;
 
 / {
 	conn_enet0_root_clk: clock-conn-enet0-root {

-- 
2.34.1


