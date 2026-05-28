Return-Path: <netdev+bounces-292723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDJzEKhUGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:43:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B51E85F3DF5
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D55B303A666
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8792EFD9B;
	Thu, 28 May 2026 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jjCGj4KX"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9590C21E097;
	Thu, 28 May 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978769; cv=fail; b=aWHB7As+WnBmo7rh+Uyvzj7QucZfW2hEwPngeWEjgQ8xbTrS9GV+/csKIYZFI0YD2JikoONMhJx70xzaj0su2PdxtC/1Lhrp2cRapaRYAeomgwgu6+a380yE4KwKkxt7/j3/wXBeQsXmXy91yZiReC1Zch7YV258MNaYqY8726M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978769; c=relaxed/simple;
	bh=2PETeqj6pC6Ms73tOtNCtlr+SeEc5NxZfu53Kh8eqEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MAErX/TIMp1I15SXgW21qqKx/edVj7Jb2LoRuThpUTPut19c/hDLYnxcskRygRhsL/lQL+b6V0OfgDXFl0KLpHbsCpF+FM/vPIB2eXszyAcHLw9EEWAHBN2RYheCy1Q9FUVVshXCAeEw4JtQo9+3RE4aqD2jXVWeiBz7BG1Qh1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jjCGj4KX; arc=fail smtp.client-ip=52.101.61.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXTM+ZUVriKXUniDSu8D04ozs3/QPefo/HKv4bjVTqx0ky34ycXxtyVCYy750mdZ2roUjuAKAmGvsDEFmVjvSUX8skIg3BrnbUcZoKfunrZA1W6dstzwdJvOMywBlpMvj4naOBad4HOcPg9OIGPkh7KVuntm0SnU8Aqg5jjvQ3/rfLLuBXkYYWnxl8aNI/xN/ksNL7tyOUuuZky5rA/QL6bVZCXa9UhY5ujZTcIkOJNbu4EVsS2SQge4hYOjKGWH8dKvi6N2cFxBIfXiNwU1MUS6+D8MlD0SemsbuDUDn/D7F4pRiZKOUAUCKlcDJnUi6Q9k9RbiW6P1F/3Ws59HFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PETeqj6pC6Ms73tOtNCtlr+SeEc5NxZfu53Kh8eqEM=;
 b=id1hjnTbfKY0MmG6/cmvJOBuXVxzBTm2V88jw8bdR+kNGhdiXBs8DshPkKyzes24JZal/zhnQXWr73shAnqVQUS22w6kKJ0uLrRqPeJweGXMfM3hImeyYneonD8RLdOELNshDaESZrlLcxfkSamdYQDzK5c2iTpsyR+/eHbM20C0ybpyvrkd5lrsFJXrU9iB59CoOW0TKh2SnQiCBRcObTYhcecFadLCStY0BZY7ezXOaXJ/AXNRANq5oNestN3vrAI/1PeBLM92mCPRkmeYasx86Y8XN3fwd+y8Fyx+AqbNPLHvemBGlZspCIjqZGmEHz4h4VT9Vg6TlN5k1wsOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PETeqj6pC6Ms73tOtNCtlr+SeEc5NxZfu53Kh8eqEM=;
 b=jjCGj4KXL6CIcbPDjMrs/h+b7/KsPoBHiC245ZYUlxKNQAGeE/0sew9FeIuuqphqnbrzdw7/cZ/XtoQnBbRR2iKWTrOQl/ygviWfqbi1ezInlKGKj2p1Xz0TLC5AlDKKU52tYUwQgRklDDwwGnGx+9HWYSMyZQPbeNyzvZEq+Daf7+2gAXJXMVCOdPbqmWqVLsok4LXgh2kBEbCEs7X2mHhbEadDvnr+lXugNIeh4pZmp5Ln0cHaY/9B2A3VSlNLi6PjuMnDA1s9mmlTjS3IJUQk+1LaZfP7xIv0zsLL9Ss8t1gak0XX2ErbmOR2hyeG2mhY0rg+7jKXqgNKR4v8MQ==
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 14:32:42 +0000
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb]) by SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 14:32:42 +0000
From: David Thompson <davthompson@nvidia.com>
To: Jacob Keller <jacob.e.keller@intel.com>, "bryan.whitehead@microchip.com"
	<bryan.whitehead@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 1/2] net: lan743x: add "message level" module
 parameter
Thread-Topic: [PATCH net-next v2 1/2] net: lan743x: add "message level" module
 parameter
Thread-Index: AQHc7gVgeIZjzHa9dUehXJYPFzSSqrYiVMYAgAEq4+A=
Date: Thu, 28 May 2026 14:32:42 +0000
Message-ID:
 <SJ0PR12MB81139D9B36AEAD34E0A54894C7092@SJ0PR12MB8113.namprd12.prod.outlook.com>
References: <cover.1779903597.git.davthompson@nvidia.com>
 <4c240063db57c93541e3de61900a5d7adffdfd27.1779903597.git.davthompson@nvidia.com>
 <9bfaf886-3aad-4ea1-b576-f822666316e6@intel.com>
In-Reply-To: <9bfaf886-3aad-4ea1-b576-f822666316e6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8113:EE_|MW4PR12MB7483:EE_
x-ms-office365-filtering-correlation-id: 2ec6f216-fdc3-4591-aafb-08debcc5fa42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|3023799007|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 XyKhOBxRdlgT2sZzaJ2Fzv4Z12swtiBrEb06sc/5FXXu3yI8BQ+zF+V5SkXV+zF9hpvsM2lIsBi+ulZBa0aHKdvhEkpKkJtj91R4hluEVinep6LJ0TZVuNeB7lhDEcr+PYtBPtZoWBEq5TO66Jllm82PrPqrz5wvyYGKvhZaXS0K2B4e9UJ7OxvEpaMevy2Kzb6vnkZ0bv5/I15jL4GRgYHeMhYY6LIsd+0ZqCpJ8plrtvYStbcMOm1Vq+nND/qydgejsepm6X8LUxY6dDns3o9uVXXPnPNANrNRhLV3L8R6tDdMdBes1/MuQNva8EJlKDiOwfV/JFhtFZU/dHMqm8yxiFMMgEWJurBLPGQ/yjCD1/+4HGZsm838QZG6AsSO5zrGU5aCM8S07JwCfj/+LfloQcY7Sqy13xtxXiffrHRJLiqodWDz0hDA3Vq6vzgFU0XFAXCCDXMhp4xi7h6a5kDFNJjcg54p7VBiZt4oiwjS9S17DK+2BFH495TutDuc15ZYaHYlnBSgnpb1+Ftt6wD3MzrdGvoE5LG2ZCh4nGqjLfmwaHR5WYx1uzvh4oPXfDrmFDxX5hhDvDB/akis25GsIO27EbxGYuxmHTsQVo16X+25IErwZdaH8ewFb74tkp2Xx39RQII5/bFxEsJ3FSF0vwE29V3xC3X0gdOWUxjmFeiNLFWQgU96XWvnHGzmXF3unz3vD5RO7/4f9X86IFTm3aW0Sku8yAJWEQ0HMw/M4OuSUZHNaLTw63RXHRYI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8113.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(3023799007)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1VzYWUwTXpFb1FXWFdXWHBGUDBiTWdWcHllZVRRUlRRRlhFQnlXY0Npb201?=
 =?utf-8?B?N0E0UjEwZmNHY2hKTTJNcC9Sbk8rNWgrUGtvR0hwb2lXK3p0V3pydGJBakVN?=
 =?utf-8?B?dXZ6bWVRdmkvTmZEcXFzeFJrRi9tekdBVkJHTThVNEdIbWJXSTUwM21mSENa?=
 =?utf-8?B?WXhCWGFmNS9iOGFPME9MUnNjVDJxYnRUVndLUFY2bkRRcDJ6MkdSbEJiT2Rk?=
 =?utf-8?B?L2JEb1BaUk5nbThXSy9zMlpRWFMwQ21MV3FlWVFzQ1ViOHJJZW1TS0NUaVNJ?=
 =?utf-8?B?akQvWThWSVMzRlpBNjRuaG9vQWl0dnkyaVBiWlZBTEp3c3F2YXBwR1BQc3hI?=
 =?utf-8?B?OW9RNi84U2EySnA4NVVNL0ZDQmtxemRDaU1EbVBvR1BJQ2pkRGlyVUk3WmE1?=
 =?utf-8?B?ZWptZFo0MWZrN1NNcXJldUtSSmxyYUdQdkZVb0cyWWVid2orNnV1dStneVZY?=
 =?utf-8?B?WHl2cmpDOXN5L3drMDZjSHdReXc3c0FUdWRPQVVSaWZsRjFlTmY5K3FCbkg0?=
 =?utf-8?B?L2xHS1lpWWFZaDdqRVhpUEw2b2dJbGpCV0kvMWoyM2dNYUdnV3J0MlFyY21v?=
 =?utf-8?B?aGlkdDZHZGNidldJTHZxRVVDWDR6VWVKamN6bUdxTzJWR2xUdnhuY1ZJSmZO?=
 =?utf-8?B?OWppWkltWHJ4clUydjZnS0ZZQWRTUDM0RlhKQkx0VW5vUk5UeERNaS9RbHBS?=
 =?utf-8?B?dmtLSTVWc2xKR2NsaUx5MjhIK1B6NUF1ZGNFQ1ZqTDFZaTYwdHgzYndNNHNG?=
 =?utf-8?B?QzhkdXIwN0VzeXdpc0pFaHR0aFJIUkRzVUo2bDVuQ0gwdHU4cWErWnFPSUty?=
 =?utf-8?B?NjhwR1pVMUh2TDdkaDQ2M2JWNzFONWlISEtjdFhrUG5sNERMR2JOUmJ5MjBG?=
 =?utf-8?B?eFZkcTFKeHRLYUpyclErZXZQMWhMVDlMNjdwV2dZT3FZekU1K2FRdExtd0Qv?=
 =?utf-8?B?NnUvNkxOdVIrM2Z6cysrSk9IVzJsbTBTVTN2QVBlQnRpaXJTd3pYZ2cxWGR6?=
 =?utf-8?B?SXBHZVBQRlAzSmtpbEdmSXhuUjNmUUpnWUR4K0lBc0R4SDNMdXBQZkwyVUVO?=
 =?utf-8?B?aDJrd1VINVZtd3BnaytUT2pDUjlCcGVuMCswWWJZRUprc1lOWElybDlGV1ll?=
 =?utf-8?B?bUE1Skx1YlFwVFUwb284U1lHRWNweWdOS01qYWtPdjRCQU9CTThaVTBBbXRq?=
 =?utf-8?B?dWJERno0aGs0RmVQQ0JmcSt1TFFId05yYTZQQTNmQThuKzJrdWJITnlmdmRS?=
 =?utf-8?B?QTF2ZUg3WmFsVVhBKzJDWGVicTVpRHplbStDSnV5dkdSY05uTjZwV1JQOFFJ?=
 =?utf-8?B?NlIrOEZVVzl3NG8wSFp5STV1ZHd0eC9pck9rdExuRHA1dnpGSGp3Nm4rNUhY?=
 =?utf-8?B?UHBiTlBqUXZlbEJncWlCSzJPUmdiekx6YkxmSWNINTMwOXRobDFpL2dWUmhD?=
 =?utf-8?B?L01HWWJEc3lWck44ZUhSM1JNeEQ4S05aNDJrRDlvY1p6OFM0U0wvMXZIV3BK?=
 =?utf-8?B?akxCa0JOb2s2TitBU092ZE9GWis4djl1OG1oZkI4eFhIaGFXQlQrYkxsT3Vy?=
 =?utf-8?B?S01SeU1OcUxlczFrV0pocDRZYTZ1a1pURVRHZTJCamtBa3dyODBYd3dld1ow?=
 =?utf-8?B?b2MzTXF3VGFNVWtGL3MvQTArNERCUGZpaFBWeWlYUnhzQW0vSFRPNmxvM1Rw?=
 =?utf-8?B?NVJ4ZEh1R3ZkVkY1NlpaRWN1Y2N4VmlqdmxneWFDRXhTNHoydVR1Wk9oU1dI?=
 =?utf-8?B?eFdmbGcweFFmRVZNUWI1Z3FpZTZXZm8rNHo3WUs4SzVDR0ZxL2hOc2V6K2x0?=
 =?utf-8?B?S3ZjbWhOUWF4aUg5YWxva0dyWTByUTI3L2xTRks1SThQalpkOUVQc1F0cDBm?=
 =?utf-8?B?a1UxV3c3aStoZE9lOHZmSjc5cFlSNmxkNlVEZEhNby9FOEhFeDJoOEk5SzJB?=
 =?utf-8?B?ek41ZXhJRXNwTDB4NVNjcDZ5cUwvc01Fa2lFd2FRUkdKY2xVRmVTaU1BZ25C?=
 =?utf-8?B?SnVzZklRNzVobjlSOEcwV2RYaXNFd05VUVhlN1NJZVlyUFVFUE9qZ081VDlT?=
 =?utf-8?B?S1g0dTFKcmVmajg1MmR3SFRPU0ViT2dqWkxPUnFyQkV3azNFSlM4ZGxjNEw3?=
 =?utf-8?B?T2lnb1hLWUhDRm1GTXZwenJuNGZUVzJ4NW9xWVZocUdxWjRwbE9CRTB2WWhs?=
 =?utf-8?B?ZXFCRkRYMFhBVXdSK2QvRlRIenExQXhDdGFqU25WL3BDZ01uQU8yZFRBWGhX?=
 =?utf-8?B?a2VpaUZrVDMzTS8wN25qaGpKUXlHS1QzK2o0SlJuT1lpakF1ZkRKY2lNUVF6?=
 =?utf-8?B?cVM4dFBEQmlIQUtCUmQ5L0xEK2JjcVREWGNYbzBybitiNTdjb3AzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8113.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec6f216-fdc3-4591-aafb-08debcc5fa42
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 14:32:42.6356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2paBXRb7+l8lPHtHVcpBPltajSaao15C0EHOH3MhIpyutZC7GdDxjvPJZra8RG04E/ZPMOD01k+KaR2FcfrgZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292723-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: B51E85F3DF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgS2VsbGVyIDxq
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDI3LCAyMDI2
IDQ6MzYgUE0NCj4gVG86IERhdmlkIFRob21wc29uIDxkYXZ0aG9tcHNvbkBudmlkaWEuY29tPjsN
Cj4gYnJ5YW4ud2hpdGVoZWFkQG1pY3JvY2hpcC5jb207IFVOR0xpbnV4RHJpdmVyQG1pY3JvY2hp
cC5jb207DQo+IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1
bWF6ZXRAZ29vZ2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbQ0K
PiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHYyIDEvMl0gbmV0OiBsYW43NDN4OiBh
ZGQgIm1lc3NhZ2UgbGV2ZWwiIG1vZHVsZQ0KPiBwYXJhbWV0ZXINCj4gDQo+IE9uIDUvMjcvMjAy
NiAxMToxOCBBTSwgRGF2aWQgVGhvbXBzb24gd3JvdGU6DQo+ID4gVGhlIGxhbjc0M3ggZHJpdmVy
IGN1cnJlbnRseSBoYXJkY29kZXMgdGhlIGluaXRpYWwgdmFsdWUgb2YgdGhlDQo+ID4gbXNnX2Vu
YWJsZSBwYXJhbWV0ZXIgZHVyaW5nIHByb2JlKCksIGFuZCB1c2VzIHRoaXMgdmFsdWUgZm9yIG5l
dGRldg0KPiBtZXNzYWdlIGxvZ2dpbmcuDQo+ID4gSW5zdGVhZCwgdGhlIGRyaXZlciBzaG91bGQg
cHJvdmlkZSBhICJtZXNzYWdlIGxldmVsIiBtb2R1bGUgcGFyYW1ldGVyDQo+ID4gdG8gYWxsb3cg
dXNlcnMgdG8gY29uZmlndXJlIHRoZSBsb2dnaW5nIGxldmVsIGF0IGxvYWQgdGltZS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFRob21wc29uIDxkYXZ0aG9tcHNvbkBudmlkaWEuY29t
Pg0KPiA+IC0tLQ0KPiA+IHYyOg0KPiA+IC0gbmV3IHBhdGNoIGFkZGVkIGluIHYyDQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4X21haW4uYyB8IDE1
ICsrKysrKysrKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9taWNyb2NoaXAvbGFuNzQzeF9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21p
Y3JvY2hpcC9sYW43NDN4X21haW4uYw0KPiA+IGluZGV4IGYzMzMyNDE3MTYyZS4uNzkzNjMzY2Nl
ZDE5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43
NDN4X21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43
NDN4X21haW4uYw0KPiA+IEBAIC0yOCw2ICsyOCwxNyBAQA0KPiA+DQo+ID4gICNkZWZpbmUgUkZF
X1JEX0ZJRk9fVEhfM19EV09SRFMJMHgzDQo+ID4NCj4gPiArI2RlZmluZSBMQU43NDNYX0RFRl9N
U0dfRU5BQkxFIFwNCj4gPiArCShORVRJRl9NU0dfRFJWICAgICAgfCBcDQo+ID4gKwkgTkVUSUZf
TVNHX1BST0JFICAgIHwgXA0KPiA+ICsJIE5FVElGX01TR19MSU5LICAgICB8IFwNCj4gPiArCSBO
RVRJRl9NU0dfSUZVUCAgICAgfCBcDQo+ID4gKwkgTkVUSUZfTVNHX0lGRE9XTiAgIHwgXA0KPiA+
ICsJIE5FVElGX01TR19UWF9RVUVVRUQpDQo+ID4gK3N0YXRpYyBpbnQgbGFuNzQzeF9tc2dfZW5h
YmxlID0gLTE7DQo+ID4gK21vZHVsZV9wYXJhbShsYW43NDN4X21zZ19lbmFibGUsIGludCwgMCk7
DQo+ID4gK01PRFVMRV9QQVJNX0RFU0MobGFuNzQzeF9tc2dfZW5hYmxlLCAiRGVidWcgbWVzc2Fn
ZSBsZXZlbCIpOw0KPiA+ICsNCj4gDQo+IEkgZ3Vlc3MgbWFueSBkcml2ZXJzIGhhdmUgbXNnX2Vu
YWJsZSBwYXJhbWV0ZXJzIGFscmVhZHkgc28gIHRoaXMgaXNuJ3QgIm5ldyIsDQo+IGJ1dCB0aGUg
bmV0ZGV2IG1haW50YWluZXJzIGhhdmUgZnJvd25lZCBvbiBhZGRpbmcgYW55IG1vZHVsZSBwYXJh
bWV0ZXJzDQo+IGZvciB5ZWFycy4NCj4gDQoNClRoaXMgcGF0Y2ggaGFzIHJlY2VpdmVkIHR3byBi
aXRzIG9mIG5lZ2F0aXZlIGZlZWRiYWNrOg0KDQoxKSBJdCBjYXVzZXMgYSBDSSB0ZXN0IGZhaWx1
cmU6DQoJbmV0ZGV2L2RlcHJlY2F0ZWRfYXBpCWZhaWwJRm91bmQ6ICdtb2R1bGVfcGFyYW0nIHdh
czogMCBub3c6IDENCg0KMikgQWxzbywgSmFrdWIgS2ljaW5za2kgYXNrZWQgbWUgdG8gbm90IHB1
cnN1ZSB0aGlzIHR5cGUgb2YgY2hhbmdlDQoNClNvLCB0aGlzIHBhdGNoIHdpbGwgYmUgcmV0cmFj
dGVkIGZyb20gdGhlIHBhdGNoIHNlcmllcy4NCg0KSSB3aWxsIGNyZWF0ZSBhIHYzIHBhdGNoIGZv
ciBuZXQtbmV4dCB0byBhZGRyZXNzIGFsbCBmZWVkYmFjay4NCg0KLSBEYXZlIA0K

