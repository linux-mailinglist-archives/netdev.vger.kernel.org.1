Return-Path: <netdev+bounces-211815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1DCB1BC6D
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 00:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF7687A8BB7
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 22:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE62125B309;
	Tue,  5 Aug 2025 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RS9j2JTb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0CD200127
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754431827; cv=fail; b=NJPeqz8zEt/xx/zLjIi9GczPR2QUSkldfvsspw/hlWClYdpnUY5UN46D339IgoKKN7q+Zn/b1CZ6mf+eO25fRjFWS7NI9QDE/a6qleAUs/SyRmZtchAjZAgfkkWe5r5ePypa/MiAl8w4G0SCHKT4435S4MvyVrJUaIwSd6Malt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754431827; c=relaxed/simple;
	bh=+N13PunmnS2RytG/bZw4T+i1BHwQjW0H026rZPALrwA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BfBEwXHofdbplszaCmDznVesahSyjLxElf/WkmPX775ybUZhaX4HXkzjXkjcyeKrNGmOLrRnGDt1WpdMw3E0ATgR7LiLwovUYgg/hdKO6QUMB8KyVF5oIX8NvTom0wrowqd+pfAuIKMjNflIx8p9IP6PWHeJkwCkWTel5t39OtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RS9j2JTb; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgz2P2R5njocWF0/U4hhhxWbb1xbNaeHca8Jdsc7vxGJA37BZ2z5vfwIjF1GU8VmbDbir/sVnZiWA2waCTf8IlCldwKIGhddLelTSUV7JgRiJ0PXiWH50iHCePix/r6Y7Cj4+0+SduuaM/iFqtfxWaVZpAKbRp01zH6sPz0pO0iBkgMU7OjfiTz2QggTtwDrS2YiREux3qLyM0XMtOMl+biB/UVhDkcmNkLfKwKrxiJyYZbRGOx8nOp7w3pdwoUrXFPYtpPb+CF+kZNzrQyiw5dD1jG8WGVsvHchiAi9LOYghRA7GVHAE9rDyWxR0NRotTHcNchgIZRmUM1yRhbRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1gH2Tz5Irs8/twhY92677vEcUEBgO2MzKhLyLaXdJA=;
 b=qvYs2MsFSsw184ygFXyNjXWcn/XCpmYdBECQ447fpLi2DuvOP+WwG36Q924330MM7oErhWjDdpU/0pS2rvNsLhUF4zzo6DQWIQCcrAGykDzY0m/yDjrSKjcp19IPhxySXThO5W/ityI0fIPI/dCu1eP13U49bVS2Luq1Pnz60/v2LX8rc8wTUw2hRAKPihdTuwjcu20+jHEnytSVhNewOnIg9gF//45V3qK2TKZDADGuyx60qddqsPHP8sqedzO4Sbq4GhnuRQvn5VuuAgvBP/d1zmB8Ug+SY0STFEggGl2ak0i26d+9Gns+qqOwUmHY7iqZvCXN630eBYyLv7eJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1gH2Tz5Irs8/twhY92677vEcUEBgO2MzKhLyLaXdJA=;
 b=RS9j2JTbkICs7By6oxMNUUmMRO5A9CeBUnxItoCpmibJg26Lz7iL/sJVUOo9eN5SzbxfmIdZZuSOsJgoI+kiN50iOctmpQkUUwZhmxbbIXC8f6BPp1OsFiI8paxq4CX4upClmndu91lRLqu3eePdw+91r+pW700H6o+uf+pHRyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 22:10:21 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 22:10:21 +0000
Message-ID: <48ffde5c-084f-4ad6-8be7-314afb14b2ac@amd.com>
Date: Tue, 5 Aug 2025 15:10:19 -0700
User-Agent: Mozilla Thunderbird
From: Brett Creeley <bcreeley@amd.com>
Subject: Re: [PATCH net-next 1/3] pds_core: add simple AER handler
To: Lukas Wunner <lukas@wunner.de>, Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
 drivers@pensando.io
References: <20240216222952.72400-1-shannon.nelson@amd.com>
 <20240216222952.72400-2-shannon.nelson@amd.com> <aJIcyjyGxlKm382t@wunner.de>
Content-Language: en-US
In-Reply-To: <aJIcyjyGxlKm382t@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::28) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: bb26fb22-9110-4f5c-71b7-08ddd46cde47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnVsYkNJRTA4dFR6cUxpckp5UThNUEErNnVXSDgvMDRadE96OE5Gam5QcHI4?=
 =?utf-8?B?MlU0aW45WTEvWFlFU1V2T2lQMy83ZHJQd0RhMGhuTHBPY1lacUp6eVJ1eEhC?=
 =?utf-8?B?SjFCeFFDblhjVW1kSCs2Y0FSQTdwb3NQRG5iYXZsSVRzcWt6Q3BVZlBNaHZF?=
 =?utf-8?B?a2xzOWdBNDlnUG1xSUhBR3lyOVRHbTNIbWh3bm83dGJvM21RYjBzSlUzaDQr?=
 =?utf-8?B?RVAxdDdiZXZ4eUxXZldWT2dVc2ppcE1WaUtBV1NtMU9mTUh5VU5ORW9YUWx5?=
 =?utf-8?B?bmNEbUl3UjJ1TTRPZXZxT3l0TFFnUWF3c0F1ZzRXekdRazVjandDMXZvd0ly?=
 =?utf-8?B?b01MK2pVQzJrRThMUlhVRllBM0pLV0tReXZhTHd5T0JtWkJWS2Nub2o0WG5P?=
 =?utf-8?B?eHZxcW53RC9rRVFmNnNQaStsdzdGREUydjJWcnZIZ0ZuelNLLzVzVDBCSWhz?=
 =?utf-8?B?Ykxhd1g0cC92MWQ1NHk5WllnaCtoNEZtT0R6b1p3dnBWbnJLQ0Iyd1BUNnkw?=
 =?utf-8?B?Vkx0OUwzcVovbTFkWFBvdHh1d0hCSG1kcVRkSzZnU0pmNkhWV0grMG1NLzY3?=
 =?utf-8?B?dnM5bE1OaGZYaWdKWUo2WGhVbXVtSHd6S252UG1uQUJtY3JhV3hSeGZGdkZa?=
 =?utf-8?B?VEJ6RlVDMmI1blAyR2R5ME5wRW5uVU9udGxmalJKdisyYzdXbVloeVJ1cWRI?=
 =?utf-8?B?dnlIRlhMYUU2VHptaUVPYTZWVzVaa3YwMmdydms4VXRSMkp1dzQrbFczeER0?=
 =?utf-8?B?MUdVNHNseG5VRjdTcWlIb2pQSmNFZHd4cUVZVmI1ZktkM3M4TWZPajg5R2Jh?=
 =?utf-8?B?R0ovSGlWcjNJc05zd3B1QytETTFuQis2UGZiZ0tCWk1UZDVyY0RCa2JJQkEz?=
 =?utf-8?B?VGNwU3hDZW8wUzAyNGEwcUJ2S1c5cTI0Z1JMWWFyc1pxa210M0t1VDY1UGgy?=
 =?utf-8?B?S2RXU3FyOVVLbVQvalY4RU1ZZUxBL0JmcThxdVhpQnc1dGsvZkhpTzhlMXpL?=
 =?utf-8?B?RFROQ0s2eGlucW9FdzlwdGRtWjRId21VNTRDVWNSOVhPQzJxWHNSTlZXSUlV?=
 =?utf-8?B?ZUY0ZHlUSEdMTGh2MHgwTk00YUIxQjRJTzdLWjlNN1AxcXFlZDc1R01RaWdl?=
 =?utf-8?B?dS9ZTHR1dEthSzAwSEx5azNQMEU5bWlHWCtmRklBWitZbHVQRG9sd2Q5MDRZ?=
 =?utf-8?B?SUhFaHdJZ2JHbzdoYnF5eDg2TG5HSUZSckFzcVNSdzRHZlJoVCtVVEZGSWpt?=
 =?utf-8?B?RnJuLzBXQU5KaHZzcmZsWThUcVRPWFNuMUlZYXc2Rng0ZWc2UWRFaThNR3lo?=
 =?utf-8?B?N0NJd2svNE1YS1hBaCtrRGhENExQajFOZWZGRXI0Q3Z4YWwxT3BkUkhMMkF6?=
 =?utf-8?B?QTNzOEoxcUxISU4rcDJManRUenk1TTcxM3J6ejFhc3dCRTkxVkdFQTAzc08x?=
 =?utf-8?B?QWdQNVNsNW1RdEZGMzZBUzd1K21QZjVwTXRPdE1JcEtBVld2UXRxd3FSUTdz?=
 =?utf-8?B?U1dFem4xVUJjQmdDNTZsdlZNZFc4TDRFc1E5RkVwNzJzVXRqMjlqaVZyWkdL?=
 =?utf-8?B?amhBK0xPZXZ2NkF0b05uMW9DL0xtYjUyUFl3V01UZkkxS3dUTk5WWkozd0xh?=
 =?utf-8?B?KzdZQUJuVHRRNzNIZlM3M1BoUWNpNGtZSjNtc1FQdUo4RGVwMmlaSFY0OVlG?=
 =?utf-8?B?ZUpnd0ErSkxuU3BPOEtrV0NCNG5hTmNvRU8xOGc1UFBXSmRXTFNFcThkazdo?=
 =?utf-8?B?N2orbXFTSWJwUVB2UGlkaTN2REFESFg0bTdLcGpwUnRJVS9xZ0hMNzVNUS8v?=
 =?utf-8?B?L002K0ljeFhPK1UxVzQ5ZmZyeU1yV2kxdk5aalNDeEltRnFmYnlqaEJRcnRO?=
 =?utf-8?B?Q21Bakp4VlNhSTFLdGVCSHFuTzd0WWxwd2ROQzYwcys5TXlMdmIydkhoMm5V?=
 =?utf-8?Q?sPb9CV0rCaY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzBHYURBL0cxTGNhZ08zYnhRM2VIM0VVaWNrWk9vRVFlREVldHBMK3lOazBX?=
 =?utf-8?B?b295RkVidE9yUisxY0xTUlgzeE43SGU0dnpiVE10ZWdZdjQxd0ZBeGpEaXlZ?=
 =?utf-8?B?NUlGeTFUN2ZpaHZsV2o2S1VjdG8yL1VPRjkwdWVoNnozVjlHT1RaU1dxeWE0?=
 =?utf-8?B?amdaVVd1ZitLa1prcUFuRHNPc3dDbENXZFZweGVUUjJyUk12VVFRMytVRjA1?=
 =?utf-8?B?U2VxM21CZ1JEVEtMSHZaRmg3cVVWdll6SFAyMmFoYU5EUHFMdGJQc3ZQRnF5?=
 =?utf-8?B?eDczcUEwVlRzajFxZHRkNUNGQ2JTZllTa01yS29uZnh1bElQV3Ezd0IxY012?=
 =?utf-8?B?c1p4WndGNHNRUC9Ia1hpTUZnN0FwWk5td2l0TWFiU25nMkpmRGZCMWgrOU1h?=
 =?utf-8?B?cm1tbloyVkhwMXUySktnODJJK2l2aWFPaERRNGd1c3hpaC9mR2NwUCtZdEps?=
 =?utf-8?B?cWNyalFReTJDTzlKdVBhaEltV1UrckRQendXeTVNbzlpTjM3Y05Jc3lNbElm?=
 =?utf-8?B?ekZFcnl2eG4vSStGaWFSZVc5LzU2OEZqZGtoT2xJeEcxdFl4VkV0TmROcU1w?=
 =?utf-8?B?eVIyVU9zNDZKcm9PR0RDVWJLRkE4blBHenVkc2dPdm9Ja1N3NVhBamtDT2hw?=
 =?utf-8?B?K3dVTGU2R1JETFVKRnkydEEyOEM1Qm5ZR04xMG83UHFGRitHRDdsY29OZkpX?=
 =?utf-8?B?VGNCbDV4R3l2ZTlVME52WGJPQWg3aDdZRDFTUTI4cEdVVEJFZXZ0dDRNZWxS?=
 =?utf-8?B?c2I2amVPakROYWU0akltY0lKNUpTai9JUmFLeUU1NUw1emR3aWJxVFplV1B3?=
 =?utf-8?B?ZUgvYnNKMlRBMjBjQ2lCMndUNE9QRXVYc3pMZ05KRzd4K0drNUhFVzg0YTRQ?=
 =?utf-8?B?NlVKd2FnK2hleUlPQS9CTFFQMTNGMENRWVdWK3hNMDN0Z1MzZkJOZXhoMExE?=
 =?utf-8?B?SG8wdEFkWVFTclNEOWRGQ3llbFpmbDRrWFJwOENLMExFZGxzNnU0bDVNUTBZ?=
 =?utf-8?B?enVBdDhPdlpMc29vOUUxUFo1U0ljQlI3ZGp2a1ZJSzY0TDg1Nit0TG9kcEFk?=
 =?utf-8?B?NktmWWpPVVE5SHBzSXZjWFp6ZHJKTDVHdkJoWXEwWGJ2UnI3K01qY1pERytX?=
 =?utf-8?B?ZUVQNHJ1UHFBQzI0cThURkNvbVZSdHgwZFF1RGNCSkZXWVp6K2xBOWxPYnpY?=
 =?utf-8?B?YUxCc2xJZlI2aVpjQmlmZHJjNnkyTG9hR3ZtcHh4cjA2bTV4a3M1TVlBTUw2?=
 =?utf-8?B?OUxERkY4VU85K3NIRDNUSGlYNGR4YzZUWHlYN2VZdlZXTWU4Q254Z21mRi8y?=
 =?utf-8?B?MXZOVW52WVA2NEhWeDEzcnFMaWpSWmYzT3VNWThjR1pIVnphWmhrbDhreXRv?=
 =?utf-8?B?TERPOThsd2pWOGxYbFN4bG1Rd2VXUEllRFpVNlA4TE4rN2d6Qm0vTlNybXF2?=
 =?utf-8?B?WU5SVXhnZjRaKy90YXVISXYzSDNxSTFKeHlRaGpHMXJ4YTh5VTRSL29jbUtU?=
 =?utf-8?B?SFROVjRiaUdRSEthSGhyR3J3dmlhQ29ZUWpGOUNsUTlEdFFkc29ySnNqS2hH?=
 =?utf-8?B?SUFaNWgyMHlkQnBhdTArRU1PcUtaSHpZeXppd0JzdDZVeVE3Z0U4cnMzY0Nj?=
 =?utf-8?B?dVA5d1EwT2RZSjN5ZmRtN2xJOG5UcGlDWGhXNzJyeWN0bVBrTlB5dE1uczFk?=
 =?utf-8?B?YXFaQUo4KzN6T2ttOUlsZjNxR1UrYVFUcTZEbkZiMEVnNGxmajVwaWJCVnA5?=
 =?utf-8?B?Y1RncUpRVWlmVld5VjBvNWplWGtKcVpnZzBEM0NxTG4vb21QZUZkcWt6UmZ5?=
 =?utf-8?B?UGVxSXhkbS9JZm1IM1JpdzBqZlNFZW1GSzk1SUhJek1sb3FWSWlVYWRTWElt?=
 =?utf-8?B?SkYwd1Z5WklKVzI1YlV4OVhWY3lYRU01Ym5lZ1UrVnZmekZvU1JDL2RVYk9w?=
 =?utf-8?B?TXhxUnA1djVVUFhtenRMSmtTWVE3RUV2Q1ZXcE1NWTJ5Vis5MEk3dTdlbDV0?=
 =?utf-8?B?SDlrNnB4M2dhR0FxbS91NkNqLzhkMEJNR0JHTWVSdEJEUzhmWTNWNk5qMExi?=
 =?utf-8?B?YnVrQmhMRVFYOXZtSW0xbTBLUDdkL2h6MmNNcENlSEgyRTNpYVFHNEhEK3ha?=
 =?utf-8?Q?21az2GHUyz2MVRkKAPmakvEDp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb26fb22-9110-4f5c-71b7-08ddd46cde47
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 22:10:20.9151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxIvGUfc15WreT5XQ1h2WZ2TwBRcnUVUC50VrolqQKE/UwIAUDxSlOaMYr9OsP86rQXZhwdpuhFdOy25Xhagxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826


On 8/5/2025 8:01 AM, Lukas Wunner wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Fri, Feb 16, 2024 at 02:29:50PM -0800, Shannon Nelson wrote:
>> Set up the pci_error_handlers error_detected and resume to be
>> useful in handling AER events.
> 
> The above was committed as d740f4be7cf0 ("pds_core: add simple
> AER handler").
> 
> Just noticed the following while inspecting the pci_error_handlers
> of this driver:
> 
>> +static pci_ers_result_t pdsc_pci_error_detected(struct pci_dev *pdev,
>> +                                             pci_channel_state_t error)
>> +{
>> +     if (error == pci_channel_io_frozen) {
>> +             pdsc_reset_prepare(pdev);
>> +             return PCI_ERS_RESULT_NEED_RESET;
>> +     }
>> +
>> +     return PCI_ERS_RESULT_NONE;
>> +}
> 
> The ->error_detected() callback of this driver invokes
> pdsc_reset_prepare(), which unmaps BARs and calls pci_disable_device(),
> but there is no corresponding ->slot_reset() callback which would invoke
> pdsc_reset_done() to re-enable the device after reset recovery.
> 
> I don't have this hardware available for testing, hence do not feel
> comfortable submitting a fix.  But this definitely looks broken.

Hi Lukas,

Thanks for the note. It's been a bit since I have looked at this, but I 
believe that it's working in the following way:

1. pds_core's pci_error_handlers.error_detected callback returns 
PCI_ERS_RESULT_NEED_RESET
2. status is initialized to PCI_ERS_RESULT_RECOVERED in the pci core and 
since pds_core doesn't have a slot_reset callback then status remains 
PCI_ERS_RESULT_RECOVERED
3. pds_core's pci_error_handlers.resume callback is called, which will 
attempt reset/recover the device to a functional state

I also know that, at the very least, Shannon tested this when adding it 
to the driver.

Let me know if you still think otherwise.

Thanks again for the feedback,

Brett


