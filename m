Return-Path: <netdev+bounces-207384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BED4B06F40
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566DD1A6193A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2228265CA7;
	Wed, 16 Jul 2025 07:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iT7J2B17"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49775374D1
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651833; cv=fail; b=A3kG0oHTWx7uKLrIRRvXDQLD2BYxL+nJ0s2mkes2Dn0dhi/xNnca4HV7TLqJJTAmrJIrwc/sasE+tRjiYfNVwQQzzMPQ628gnXyTItHIq6S67BC38HNwzxUGlwe8v8DRI6AMJRSMEOyZFg3Lio5QvM13Sq5dZ0YjQ+n79ZvNT2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651833; c=relaxed/simple;
	bh=ufftkwvvzV9/5edDYP9558HecqtO9JHyzkGuRfRq6Wg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rme5UZYpL4miFWSN5s1gdnKbheH93ZBBItEOFvgDeqe8Xq0MKP8eOYqEs+9lU7TsPEeANUQO0hBTxeyKbeLH5b/KpAmEbDkEApONuZsy4ckcYaGfAN62mjJjPr5wfhusGQ/tRlqyWppslZYDHtwO7RwppawiLgMsuXBMN48Q5KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iT7J2B17; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3iQZib8k20EkdDLFXcPKlMhXAc1P+AarujE3E+QmcZ+i4PkXiz6n6gM6lynZpatquHxrcnrcLL/sYWoVITQH8ZAqIb4uaMZFWlBBDT2TEgsfLpydWYEcchfYH7wEwEGrsMCfStmOFkgAA7Prl/DJUfKpgZB3BXrCSN/fV2reMMddeiY7zrgi+Y0QyFyk1PRnZC4a/22/D8lj54rL8AFeEfCvbJU9bFVAkMV6i0PbB2Rv+K3AXLbWYn8E6cCzMD/4AwsbEYtVRSXsjybR7aaES6kvuu8kZqo3BnuQWQnKNZY/x+CMC612oNi7Mf/0pqGnrXyGLIRYI5VJFGoHkCUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deZk4YmEWpLJeB9oAsSXlM5We8QlaOAOQpni87KLDsI=;
 b=AX/rSPAFnVXpLk33SycW9VnLmCc/O28lvlRKD0T4k+ygFV701KSDrwMwfJXok6sWGg+vGRfqcagXYtFXDrwRA3tqXuz7myeyLJffploHy7VOt8+FFOZoOvHL2tytCS4VtFEzJeZzKT6jqruTOUBqj2ltUlpP3SKKgPa4ak5Ces+r1MqWDMP/Avnf5bF4X2PVtWdUWJW0yIPlktaF7gOkjZgftXTQQVByzfzC8+q9CyyXojgeGUKYKauWDVHLHstlQAECN4fT9LggiOI5P+hq34CoEjWvlLS27e7TeaZSrKhe8IKr6/MLZ0vzGdMwjxyBRqqydotu7gjdZgKO8pJ0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deZk4YmEWpLJeB9oAsSXlM5We8QlaOAOQpni87KLDsI=;
 b=iT7J2B17Ke35G6mDPTd5pUABC20cuvl8b3I1y9qvL825sY5VuBOtNbdwW7XKQHcexj/Kk6xoX1/3K1vi2YyKuQ4x/Ejhat93pZUc3SH0A9TA0XRGPc/OJd9DboDjU0QAy2sFZ33ViGtHCas10iCxXLTFiBUm7iiWK8OhhdNcU3Zg2Kh8KDTKf/WCmaB27yFz8DCL+GlT3ZDKJ0mG/ZWoCZXtkIPXbEa96oMezlJPPBAH6MmlZxmPtCMfGmj1XgIppJPs78lB8E080l0kiTGpt/SZ6FeV+qyifIJOj0H5FLWhy0PsJXq8lLPIXmjnpLvpoBrl0ZuFRivonWV9pD53+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 16 Jul
 2025 07:43:47 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 07:43:47 +0000
Message-ID: <021a8ffa-f567-45e9-a081-f6c0f885eee0@nvidia.com>
Date: Wed, 16 Jul 2025 10:43:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/11] netlink: specs: define input-xfrm enum
 in the spec
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com, jdamato@fastly.com, andrew@lunn.ch
References: <20250716000331.1378807-1-kuba@kernel.org>
 <20250716000331.1378807-9-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250716000331.1378807-9-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 271b2fa6-ee40-4d50-bd39-08ddc43c7f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFVGZThJdDF0cSs5QTJrWFpUMS90NkFTVTFBd0xrTWh0VmtRczJnbzJXUm9n?=
 =?utf-8?B?RC9QRVJVRWZhYWEwVVU3Y1lOak9UaS9PNjRaZWFYVlorWmszZzdjTmlHRG9X?=
 =?utf-8?B?Z2RjRlBrMnA3RTg2SUNXWTNoY2VZVTQ0YWtUVERldjJWVUlIeGJPQzBpdnJQ?=
 =?utf-8?B?M2FmWDFsRm1IcVhrdi9kRUs0N0lZUmpHWkV5QkUvUTBmSE9QU1lMS013QStR?=
 =?utf-8?B?Zng0Yy9OSlk3cE9WQlV5ZWR4dFU0VGZSVmdQeFovR3JXdWMxVFREbG1MbDRD?=
 =?utf-8?B?b1BUQXVIV2M5eGVwSjd2cXZRRUNnbDE2RjYxeU0wOXhVcUh6NERHZzBGNGZr?=
 =?utf-8?B?U0FtMnFLQzNKRTFKMHI1MlpqaVVrK0t6WUx5V3g4dEQ0SVNPQ0o3N0tQZkVa?=
 =?utf-8?B?RGJvbWFKWnF5MjlvMHV1SGFQM21tbzlGUSs1UnBvVFlVdkx3bXVtYmYxSjBj?=
 =?utf-8?B?akJ1SG5zU2VXVUt0b2VNay9YMjFmam1BY2cxOGJNcXdScTZjQ1VFNWEwZWth?=
 =?utf-8?B?SG1Ncmw3RGNzL0Y5OVFrbVl3Vjd4cG1jc1M1UFB6LzlGYWZ5U0d3OFVxbmRM?=
 =?utf-8?B?Q0lKRGVFeXRrekV4UnlwNVJMMHdNRkZ0ck91QjBJSlUvUHoxT3drREFoTFIz?=
 =?utf-8?B?T3FoYU1YMitTMXVCOHo3QlQyWlBqQTBDY3JvV1hrMjVPQml5N3I4QXFyL3Br?=
 =?utf-8?B?ZmNzbUdYM2lTZnR2K2pocCtBRlBMNmVMZGpVM2NqR1FKMEhzbExZbi8zMHkr?=
 =?utf-8?B?cTNjK1hpaHJBazVNejV6TnZmczRlNUhMQjFWclpXcnJ3L3RGWFdmSktlQkY1?=
 =?utf-8?B?WVVhbGhrdkZLT1p0NUsyYVNpQ3ZxYzRIV2FGUDNYMXJud2xFNHpxUVhmNFgz?=
 =?utf-8?B?a054ZWFzRi8wSkpnWDhxbWhpWGtueDJURCs3YzFvU0lma1NabUpFTk1YdFBu?=
 =?utf-8?B?ZHlFTkRTb1lQSzRHeHZvbmJsZWpPUytMOW1HVjZLUWNoZ01NWTV5L0dsNEVZ?=
 =?utf-8?B?Z2VYTFNiL0NjWXN3YVliY2s0bDh6VUJwaktIdncwUTIzVHdZYldIRVhiRUtR?=
 =?utf-8?B?OG05TjJZZXpmdFNVS0IwVi93Qmx1YWRXaGtWclBLQkZqcEI4RUFDdWhKY0la?=
 =?utf-8?B?NlRWSXd3c2huWTA4aEdSUStjVDAydW0zSU5pQU02M1g2czBXN08xZEpwdEFW?=
 =?utf-8?B?ekRoOGhleUNJdnd6amt3OCthU2w4NUhaQXR1T29kbExDN05OSzZRTzBTTW1F?=
 =?utf-8?B?Q1FXOTBtaGhhcFU2SXgvVmRWYmROZGRXUDZQSmU2KzN5V3huOHRwU2UzWkhW?=
 =?utf-8?B?cUx4VkovMXhQdnNSSHJnZHcwbWt6VUNLNEQvUnZZcTMwSkxVcWhvYVZMcjFO?=
 =?utf-8?B?U2tTYzhoN1NQR0pnOXNCUXhhWm5SbXhFbmdQVC9XNGRFUjB4UDVkemVUTFJQ?=
 =?utf-8?B?NnF0S3lNdjZNQVVEM1JmcU5LdVQvdXZwNktrU2xkUlVBcnRZYVc4RTAzMU0x?=
 =?utf-8?B?MFcwOGZlQzJ4dGx4N1NLWHlDcXdRQ3NlNUo0MWVLSmRLZjlMOUhGWVJwQUc3?=
 =?utf-8?B?b0pTbzZXYXdiVnI1dUlDcVlDQzhDRXVuS0V6Q0hxR2hsbEJyaHMyK2Nkb0JU?=
 =?utf-8?B?T2ptejNxL3lCK0lieGt3dW9Rc3U5WGJjVTVvcWhBaEhOOTFDcXNMWkJRdS8x?=
 =?utf-8?B?OE9Rc3d3ckU3bEVnd2F2c3VrWXBBZU9paS9jM3ZXb3dWcUlEWUN6MVBmVnRO?=
 =?utf-8?B?S09GWkVnVlEyMTJWWlMxSW9DUkdlcXFudHZnV2dCNHpNZjhhRXdMSlFTSW5h?=
 =?utf-8?B?K3hxTzNEZU1CL0dUUjVIQktoOEUxN2xWcWdkQTE5dHBZVXpmT1RXcGxYanJW?=
 =?utf-8?B?bXNMWWt4L0N1S2pybFhHdUM5N1FyUldZbStmVVN2cXhPVWZxU3Y0RnhaRGN3?=
 =?utf-8?Q?vL8dMy7F82A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1h2NXU4V3RuRmlSdDZzYU9HU1NVV2ZIUEw4Qm9uSm9XRGNHUkxGbHBVSzc3?=
 =?utf-8?B?ZFcyNU5DbDNOZlU4djR6bU1kNFVwek02L2M1Z1NuZ2R4T3d6NFB1cFVOK1Av?=
 =?utf-8?B?YTJSWXVlQkFCVU9LeGhZSTdsT1J6VnV0UE04Nk5zR0kxblVvbXo2dkYvVmNF?=
 =?utf-8?B?OG1zZDl6ZTNDc0crMFQwTXozKyt1MUQzVTFSNkhGQ01YMHlWMGpjR0NhOE0w?=
 =?utf-8?B?S2tNNnFwVVBXeGYrclQzdm1kbkZ5YXYrcVBoWnRBQ3ZSR3QwRVBIdHRUWUJN?=
 =?utf-8?B?cWh3NmFNTW1OUWd2OENhcHFCbzd6OTA1VTgyb3FMOGt2djFDYzNHMXpiOERY?=
 =?utf-8?B?WGVjNWxkdHo3Q3NCaXo4SSt5cjdrN1k0akxrbGR3cDdOeXpOdis1WWEvRUgv?=
 =?utf-8?B?MzJMQUs0alRwTnNydDI0cEYyUUFlNWVjdEY5RVRabGpwRUZEQ3ZEMGJWbmlp?=
 =?utf-8?B?N0VBLzNhdXl0UlVYbW8rRFJWWEhxWHc1ZVpNdVV4Ti9OUEYrM0VvVzhYYnVT?=
 =?utf-8?B?QVBFQmN6eXlLUHV6WVlOQnRsTkFmL1RUQzBQSHNjUE05WUp2czRtSnFWbUFu?=
 =?utf-8?B?MGpHWTRHeFI3RzRSTG8wL0FGYlRtVmczNTNUUjRYWWNpc0Vvdy9GdlA4d1po?=
 =?utf-8?B?Q2ZmbzR4andhYndiNXdFQThYd0t4ekVXOUNEc2hCSEJzTnU5czVtNHpEa3dK?=
 =?utf-8?B?R3FUMWNOWHlWdFJZb0RYV21PVlVMbWVkS1RqMVdxbXRCSVYraHd3OExBUHp5?=
 =?utf-8?B?RmJ2ai90VW9vTDJGTVkyTGM3WE9GTC9FOE9kSjVLMlhNZk1DRlU0Q2lGOFUw?=
 =?utf-8?B?WXJXM0NtN0t6VzBqNkdwSS9NeW03Mk5rbi9wSVZXMkY0YVJ6bmlmckFucVNn?=
 =?utf-8?B?Q080dkVCVVBON3JqdlpKcjhDSDNMME94MEExSDdOMnMza25xeGNrc0FzcVJG?=
 =?utf-8?B?a1FEOUFhMG05VlZQdzZOUHB1Qk1GUHUydzNYWTM1c1A1Z2d1T0xwQzFyWm8v?=
 =?utf-8?B?SE9FcDdIV09DbE1Kei9RMGgyd3dUUFNvMGIvbE1CWkM0SmJtTEpFQnVjb1hN?=
 =?utf-8?B?VmhlM1Qza2NXQ2dIU1F2b3JCeS8vT3RHNlQ4bGdtbXk1V0pOMlJGVVNpV1M0?=
 =?utf-8?B?TTJXRGwvTjRoc1Z3Q0l1YVF0THc2WjZZdGFEOXRTL2V2V00zMSt5V0l1cmda?=
 =?utf-8?B?TWpBUktRd0FOYWRqWXpLb21BU2t1c0pGNEd0SkJSYU95Vk9kZ1lwSWQ5MXM1?=
 =?utf-8?B?MVRNMStoRWwrTVNTS1BVa3grbjBOSUxuSlE3elFOZnFHbkNJNnRDeFViOUNt?=
 =?utf-8?B?ZHlhMXpvUXFBWGdvaHhqSVJsSlYzT3pBc0Qvb1B1dEJ0Z3VWVGdSSVVyMjcv?=
 =?utf-8?B?YWhBMGxpK3ZzRFRtWTB1Rzh5dnpaZThOcldKcFQ0aGtpTDFtTUlZNzRITHlL?=
 =?utf-8?B?aFg2dmlKU1Nma3Jud0NiSm13TjNuQTNsanZObnpYN25NWlZnTXZMNEsxQkZ0?=
 =?utf-8?B?Vk5LQkhRcFhNZ2djVHE5S2t4amFOcWF1V1pZWHJreEh0SldzdUJSU1N1R2ts?=
 =?utf-8?B?bDV0TG1IOWVXbFM3YVRkMHppWDBKaDg1U093WUJGWmZhY0V3WXBOVlROcGxZ?=
 =?utf-8?B?V1liNnlWWDNpN05Jd1hpMjc5UW5vYXdsVkl6YjM2bVk3aE1rQkZNdFlmTzdj?=
 =?utf-8?B?MElidmdrTS9nT2M5L1JsKy9TTlFYbWJDcEhxVVBoaTM3SGc0ejVKejUwZC9w?=
 =?utf-8?B?MCtidkRRYk9laW9ZdWNFZ2orZGxXU0FsM0prZ0RZSGVjV2ZTUEtYNHRDVXJQ?=
 =?utf-8?B?djhCa0ZWc3l1dTRiQ293SHRDRFlWeHJtajdTa1ZibFJ2cXNvK1pmY3RGZXg3?=
 =?utf-8?B?cDYzdnNjaDBqeU05bFdEekJJUVlyeTVCc1dBemVXQTAzYWdMNVZ4YmNGbk1V?=
 =?utf-8?B?TXpGTEVMbkdpUVJhaCs3NXJ6OUI4ZmZLN0xJUkFDcFN0SzZkVUR0MnlsV0lm?=
 =?utf-8?B?OEhBUFU2dDl4UzRJZ1JHTkFCZ1phK3l1NVhKTDhEd3cyd1dIRTF5Yk8wVEJZ?=
 =?utf-8?B?OWtTQW4zaUdDa0RFUmVuVU44eWtsTncyeGlQaFpPUjYxUHhpRVhUR0h0a0oy?=
 =?utf-8?Q?L1mfLPtYbWC8b4V2ACacztZt3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271b2fa6-ee40-4d50-bd39-08ddc43c7f72
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:43:47.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgusnfbbzHCVXuLTie0kiho1fCjkcRQVJ424uOHO90HrEdga4e8scouQo7T4Ax0z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424

On 16/07/2025 3:03, Jakub Kicinski wrote:
> Help YNL decode the values for input-xfrm by defining
> the possible values in the spec. Don't define "no change"
> as it's an IOCTL artifact with no use in Netlink.
> 
> With this change on mlx5 input-xfrm gets decoded:
> 
>  # ynl --family ethtool --dump rss-get
>  [{'header': {'dev-index': 2, 'dev-name': 'eth0'},
>    'hfunc': 1,
>    'hkey': b'V\xa8\xf9\x9 ...',
>    'indir': [0, 1, ... ],
>    'input-xfrm': {'sym-or-xor'},                         <<<
>    'flow-hash': {'ah4': {'ip-dst', 'ip-src'},
>                  'ah6': {'ip-dst', 'ip-src'},
>                  'esp4': {'ip-dst', 'ip-src'},
>                  'esp6': {'ip-dst', 'ip-src'},
>                  'ip4': {'ip-dst', 'ip-src'},
>                  'ip6': {'ip-dst', 'ip-src'},
>                  'tcp4': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'},
>                  'tcp6': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'},
>                  'udp4': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'},
>                  'udp6': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'}}
>  }]
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Gal Pressman <gal@nvidia.com>

