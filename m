Return-Path: <netdev+bounces-215163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A431B2D4A3
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DA3720154
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 07:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D642D3738;
	Wed, 20 Aug 2025 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vhh7YVLM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E82D3231;
	Wed, 20 Aug 2025 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674074; cv=fail; b=tW8BBPtPr3SKJKSF4ZfskAzvbs4ZuklMakNUrbQ6liZH166C0cF2Bt9UAUcjJMWTs9m8MXuHTqGKHTC552jBxwydwsjD+zo6gWkUghT83VfU/lScCmtCBz2kRdreQghztJufREKRvKtLuBeabsCX33rQC5lzpAr8jZrixhuzTRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674074; c=relaxed/simple;
	bh=q89oqyUe0jJkN+qrZEyVKyZaxTqLyuO0AYpbxeEnq9A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cR7Lj3xhqsbH89nXMi3oGXs/g9oGx/lKU+Zn1x88zleI8+2iSf1lcko3RD4u9XYtN8KnFUEl583j5wjqLIAboE5sHxtwupHVKeTa6MYGbcXiDoRsQ3oCzVHpNTjsc/FVGBdMELb16DXVollEBym5aISP7deQrktmKB/AMwhBva4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vhh7YVLM; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a99GnpDyY+J7YRU/rUMZbsxZDkBIli6V5lwNvH7T9CI+3Cnk36sdWF5xguPKRLBtMkuf64i3GBWaGWvP2l4RZPOntes0TTP9rdu8x6SeVLLkUaXTyF41JVW/XsnyueUm+k492ubwcYL6KVtddxFLhZT3wdHcw7tC4Rkhn1hkaxlI8BEG6wCItL5XGe4nMXG2hoKNoRlDUjoe5HPftdgZEv6hy6kiARv35EuFhIIkvwc2SJrazdS0eo0uxhZxyDof88kRWhw4R7r6hGBMWWMpWa71Zdr6Fw3VGHrY70FrBETJy4MmcsW8/R2p9tl/UJgbllrL8xDaMXtKTBD2SVUjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEIduxkyvYB1UrnQwuoHt/wafRl83R4zgGp3JJoSfUo=;
 b=TuZD8yjHVWvsi8aO8JEKsTdp1TsegRTEw4si4d6KG8DBRUsvfawSXNyqJsLbEC9N4bBFGw9AxQ9sLXgppEZE1V0fx7+4YSsg+nV4pEeFeSXkhFAzuCiPoenSpS3x0ioH5EEeTvZsx5Q5eXu8vBzZrH5Siwrxu3qb3lgCuSzIAg8E2NGg7Vb5dj5ZAxni9b5Xb4/Qzs0B63oGIs7Yc9ErZUCP0QuioXBCIC+T0nX5dDYnQYKLqTESD6kQPb0EfOBYI0+UpzaBcfBrtGY9IijBlNXzMF567UVUQfDDUfjeIu1nLMNcERaqqOZr1e6qvuzQPykm8YLwiRG3xFn5C2GVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEIduxkyvYB1UrnQwuoHt/wafRl83R4zgGp3JJoSfUo=;
 b=vhh7YVLMPVC6Uzd6ZyC4srSsSZYPfWTb/4aLq+XTyOJM0l9znwF498ub5l5PTfvNEvM+VviFU3sNGAudwre0hZgywGW5PTIKw2eFJWC57R43OT3kY7XZN7YETdoQpYvFegeVfV6CLTRy9skaBSpkCrmWBVFoFf+9BzC8J8ttzpSfmDhdMTGOL+2ePkD5nV8oczhImXlHqmJuOYc5UE74kUNUihoA8JvNwrd5QK6j5n1TKsQFUSCtTwzBa1zqLiQn0pcPvSlfPtFnzKAXva+qHjQyTFQ3IA3FInVyday5dMEg/C8iFg3Yr67Jjqh7EQAWrILTw2sW14ZMjVQfFDIjXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by DM4PR03MB6079.namprd03.prod.outlook.com (2603:10b6:5:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Wed, 20 Aug
 2025 07:14:30 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 07:14:30 +0000
Message-ID: <22947f6b-03f3-4ee5-974b-aa4912ea37a3@altera.com>
Date: Wed, 20 Aug 2025 12:44:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: Set CIC bit only for TX
 queues with COE
To: Jakub Kicinski <kuba@kernel.org>,
 Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
 <20250816-xgmac-minor-fixes-v2-3-699552cf8a7f@altera.com>
 <20250819182207.5d7b2faa@kernel.org>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <20250819182207.5d7b2faa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::11) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|DM4PR03MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 2affa9c2-6e8a-4817-258c-08dddfb9346c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjBOUUNOejdOS3ZpQmJ2MDlhRjBlVy84VlpPWDN1d01DcjYvVjVwUGJuNFJT?=
 =?utf-8?B?VWl5NjU0RTBGblVRdXNTTEcrVmFRUFBVRmZ6cGdpVjQ2bVI5TlNVR1M4MVJ5?=
 =?utf-8?B?ckVFSGovc2VTM09rZ29qV01nRzZrNlJkN3gwZ25vYUdpZHcyZTZ2djRPOW5Y?=
 =?utf-8?B?cGNLdTdvRzhyR2NFMklUbnVpU2RaSXdldFhqVnQ4N09EaUhvOTRaaGdtNWtL?=
 =?utf-8?B?V2xHbFR4dkoxNStrSlRCZDFhdktwc01sSjRPSURLSGwrbVF0Y3hwTU0xWk1U?=
 =?utf-8?B?Z1NIRTJyd3JFN0VNUG9JZWMvT21qUEMvM0lMTFlWak9OeXpUQ0s3WmVWTG1K?=
 =?utf-8?B?MlF1WDE0ZmN0a1NMVVdZdWVtK05BUE8zWk1MVTZXYWdGank3UlpQemNyUmJx?=
 =?utf-8?B?VDhBK3MxR3grZUxaTGx4QitVd2d0K1hlNTdYTzNRZlJodW51ZGJreUFzZ0Rr?=
 =?utf-8?B?blJZYkxibW4zR0Myaytzc01xamZzb3NFTzByRm40S2E2WWk4cGJta1M5ZFd0?=
 =?utf-8?B?V1VVeDR1Q2NacUQzUksyUkJmejRHbDc0ZXFOOVdKN3JDQkxIVnNpQnZBU0lE?=
 =?utf-8?B?RkJ4VkY4aG9kU3FVNjhMaXBmQjgwd2JWR0tjVjcxL3NYY0NCNnJEVGZqc1NG?=
 =?utf-8?B?SEp3MHFpWFZTcHR0VkEvdy85WFVPU2xGQmhXdVc2TUQyVDhCYllreDdnZlRh?=
 =?utf-8?B?cThWTXd1S2htUEJQV0VHNXlKejg0dkJueVVlYURGbTI3TWRVekZNOUE1ZjA3?=
 =?utf-8?B?Z3VTZHZrR3pNamVxUTdaNmFXeTJKdkhnSjRRM2VaWWZkcnprU2R1Qmkwc3Jk?=
 =?utf-8?B?a3YrdE01bkJVb1NINDRsa2lCdWhFRGp5NE1zeENRYUgzNi9CZnBscVBURmww?=
 =?utf-8?B?ZUpsRmN3QWJ4Zis4YWhWZTJLRGU5QlN5OTlJVW9MbHdCK2tQWHIvNGxsdWJm?=
 =?utf-8?B?cWhsZVlITmNuZTByZm5FT1l1ck41eHYrNDlhSUUxd3Z6bEVGNWkxYXQ4dGRB?=
 =?utf-8?B?cFB3a1h0QmFncS91TDBDQVBnKytGbVBZVkNzcWg4ZGwwWitOak80MVY5QnR5?=
 =?utf-8?B?WlhFR3V1MWFieVZSWVpIQVBCUFhiNHRnVTBseEozaGRkaDBMcWo5UTI2SzZ3?=
 =?utf-8?B?SDVJZ0daeFZrVDhCa3V4OGcxWlhZeFlrOWFYdm03azM2VjRRbDFkWCtmSkNp?=
 =?utf-8?B?aDl6TmprSUVFcm5sT3RwcWwyNjNuYnFWQnpSQWltcFByd1c1cmZGOS9LOTYy?=
 =?utf-8?B?QU1tNnd5eFIvc2NxZkxOaXN1UXFvcXZiT05oaE5rbERKYnBsK1NYWFFma08v?=
 =?utf-8?B?eFFWUEVDWlBYbEx1YWxZeE8zTlB2b0J4Wk1KMldyMUVseWs3L000TTZvSE00?=
 =?utf-8?B?K1YrdEF1RjgxN3BiWmRlUmZwbEF0cGtJSWR6THI4NzBrTW1SZitPcWtoWWtx?=
 =?utf-8?B?Mm15aGN4RXNKUVdhdk5NMGtDbXhKcFQwc0ZENFN5MURnVXAydG5HOUh5TG1q?=
 =?utf-8?B?U1A1MmpkR3J2bUlOVXArMWNwa2ZndzRoTGc4QVpFLzlYOVArOFRWODBBNCtG?=
 =?utf-8?B?UVNlbjQ3N0c3VTlCVHNYcGRmdEJrOU1kRzZmWU11NW1zS1FHc0tuRVo5dTc5?=
 =?utf-8?B?THFhK0Y5NWdsR1JjcDdtNXV5Y0JEUmdiZlN3R3grVVR2c1l6WXpkZmJ5WE0z?=
 =?utf-8?B?Tm4wRXNwTE5ZWGNRMDY1OEV0dk9nakoyTkR1eVIyREx1aElxUm80Z1FuRW9T?=
 =?utf-8?B?ZDNJVjVWaUlNZDZJQlI1dkUyTWNHM2dNVXJMYSsrQUJzVEw3NlJjd29GMFBG?=
 =?utf-8?B?ZU9ZTkxiZnF4ekRtcHROcTZHcDFqUVM3cTNSS095aVFNUHMrZHdmbHdGZWtz?=
 =?utf-8?B?RE51Z3hjWE80ejhZNGFQVjlpSkltVGp4ZXJNS2JnRC9BQmVHamJDWldTR1RS?=
 =?utf-8?Q?oZFNaHwZBtI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXRyMW9lT3FudjlwNDJXS05EczhxK1haS3ROdUtWblhKMG1nS29zeVlGQnZk?=
 =?utf-8?B?amY2Y3RoYXpic0Y1ZDJnWFhGYUxvSVZkMk5lZDVNTGhEQVpxZXkvV0YxZVNT?=
 =?utf-8?B?ckQybUxGVDRSbHFkOWVhN2xjRXRXWS80MzZKVDhNZk5pUFZxdUc5OXZ0Y2V3?=
 =?utf-8?B?KzFiOVNZUExPeHVEYjNhVWozZGlUQThWMDZ0UmNRcksyZHRjNGJyYW1lR2Ru?=
 =?utf-8?B?V3BzUDMrUWxyYUR2eWZzbTR2ZzhUZWhEdE1IN3pvWmlFb240aTVFUk95VFE4?=
 =?utf-8?B?UEFqQmZMRTJmQ0c2Y1M0ekljQzZOcU9ubVRSQVhSODdDK1RMUEZWNTdWT3Vw?=
 =?utf-8?B?R2g3VUh5czFTSTI3WXhCQ3RTUnlUUWNKQjAxbTNDMEw4S1U0ekp3cEZRSHQ4?=
 =?utf-8?B?REV1eU1NNFZyUVozTng3R2Y4dzFJYk0vell2a0pyc2kzTnhHRUhDYjYwOTFz?=
 =?utf-8?B?ZGhxWUgzQ0RHZFVzWjFSdWVzakF2SFVoMGVmNWt5Y0VxVmxyNWV6VlJZK2Iy?=
 =?utf-8?B?aUJxNisvVTh0WTduUkM5ZCsrRlU0L1JKRVVoeHF1MnJvQzl3RnZWYk5rUlhX?=
 =?utf-8?B?bStKL09iUmdFRjVBWkJXL09ZbElZWEVOd3prUmxQaTkxMEN2bEl0bFhBRk8w?=
 =?utf-8?B?bzhHb3ZWRTJUbXJ4cDdOcHY2TEhOVXF4aXJiYWVQbTd3cU4vYmMrZHlIQ3JL?=
 =?utf-8?B?VjRjOFZGWEI0L0V1Q0FLckxSNkduU1JsRmdSdmN6MkxqeHFMYlJTWERsWWhF?=
 =?utf-8?B?c0VwWTljY1JxTDJ6M2oxTFRqQklGZ2cxaWpyNlp5WG5BUnVXWHhIbThTYWht?=
 =?utf-8?B?SmM5cmtDYk0zdFhRcUpuNEh1b3pWMnZLbXliU05CeWpVZXlEUEN5aXdicTFJ?=
 =?utf-8?B?S3ZrZlZtN3dJWlc5YjZwbjhqYW8xMnpOVHBMZlc1ZldrSlRYZ2dXOXF1emFm?=
 =?utf-8?B?YnBxY3A0OG9wWG40MEI0aFBDc3ZRWVVDcDNxQ0lHZytOd2h1WnZMRDdBbnpv?=
 =?utf-8?B?Y3RvQXJ5SjQyalYxbVFUMlZXSERNT2czUURVYTdsQk1wOUNETVhNei9qVVVw?=
 =?utf-8?B?UUlpRE41bGVwOEVQQTJPVi9wYTVhM3ovN0pzTzc5SVhBZnVrTjc0ZHIvQWhO?=
 =?utf-8?B?ZjFSY20rS1YxT3RPd2g5K1VhUnZoYmFOdy95aFRnOE1FTzlNSFpSRkduU2Ev?=
 =?utf-8?B?WEVSOFpuVUpqTGxqamNBWGZnaUl3bVdKQkFWNnE1a2ZhenJaUFQ0aFNOaUN1?=
 =?utf-8?B?MmVXVS9GMEkvT0haUlJXWHNDQTNzTGxVUEZOT0FkdVphcTQ1Q05MalBXc1FB?=
 =?utf-8?B?RUVCMjZpeG5xWVFyaGs5V1FVaGxCUWhFM29nWVpXRkJlU2tZSm5WMmRtQ0Q4?=
 =?utf-8?B?d2dENE1ZL3JSWUNkN3Z0eTV1S1V2V0NPbEMyYmZXRkhPZnpydmZBUHkwL0RN?=
 =?utf-8?B?K1FodGNMQVdwYitJL1h5L1RrSnNrTzNBcTl6ZGsvdVNJRDU3aktTVTd4WHU3?=
 =?utf-8?B?bzl3UlVuTi9QZVJoalY4UVZBakRrUVg0bHJCVXNLS2Q1b0g3N1M4L3p2TDlD?=
 =?utf-8?B?YnFKL3JLLy8vWDhtajZiSG5XYi85WFNUaGUrdGw4YW9PRU1LQXY0a3VvR0dM?=
 =?utf-8?B?SjZBY3dsTTZqbmZDZDgybHFuVWd1WitmM0duQXNkQzRBdTQxaXpDTGNwVzRG?=
 =?utf-8?B?RUpoRUdIejRQcEZJWDZiUlBLR3V5bVk5NjhHNHJXczBIbllzYnlEdnNNckli?=
 =?utf-8?B?WXR5SW1qeVBlRXFtVXNZUW8rSmQ1dVRmRVpieDBXOGpZZzBSUmVOczNuSjF3?=
 =?utf-8?B?NzIyQklFSk9UUGtmRnpWSFRzOXJFUzZOY2RBcnN6alRPYVphRFNoU3B3RUJo?=
 =?utf-8?B?MTNxQmp2MlNkM2JmcGFKQ0NtVmVyYnVTZW9NM0xiTytRNWlxY00vMFBaM05J?=
 =?utf-8?B?cEdTblh5NTNxaUxMME1Ya09ELzFGZTVObTZiaERYZ2h2WTlqQkF1UlAwK2RH?=
 =?utf-8?B?L2QwSXhhOXNDdGZTSnAvQ0FXODh0Z2JITlBIR3lNTWFwSjFRN3lsdVM4MlVV?=
 =?utf-8?B?OEtMaTRqRlF0ejB1aVBRSzdId2VaYis0M0NzWm9KNk9EMGhlbHFoT2NhbFhi?=
 =?utf-8?B?eTRnMmlrMjZ5WVdVQmo1b3pzMS9FeEJmN1dLb0tGSi94MVk2UlNWTlpsdERn?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2affa9c2-6e8a-4817-258c-08dddfb9346c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 07:14:30.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLA7RfhkexzdUA3E7OxpPVITcglESC0/2ygPYKwR92yyuHq0iaDMDFO0D0wL+ET1Kol65KXGescZoEs41lznKrUUd9wVhUKK3AFQxhf1CZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6079

Hi Jakub,

Thanks for reviewing the patch.

On 8/20/2025 6:52 AM, Jakub Kicinski wrote:
> On Sat, 16 Aug 2025 00:55:25 +0800 Rohan G Thomas via B4 Relay wrote:
>> +	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
> 
> Hopefully the slight pointer chasing here doesn't impact performance?
> XDP itself doesn't support checksum so perhaps we could always pass
> false?

I'm not certain whether some XDP applications might be benefiting from
checksum offloading currently, and so passing false unconditionally
could cause regressions.

Best Regards,
Rohan


