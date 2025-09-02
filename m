Return-Path: <netdev+bounces-219212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59934B40789
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFA31B651E3
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F78313523;
	Tue,  2 Sep 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="dltZUKRV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F1C271443;
	Tue,  2 Sep 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824434; cv=fail; b=EhrNR1b9ds+hag8NZJ34jRIbTWyCR/HGFvGVq5hrYTfc/fL3Fm0QrWJFk+M6IBCFpjsyOm7gGM5P5YWv0gOTX2jK6gV26382r3OGsvweeevnmDYbB3iN7RudWQZ3fnlWM20u4TtH763kBW5+w4nO3WPXrIiAzrI35TJJnHapCog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824434; c=relaxed/simple;
	bh=RVqXJbQ/5k1/3V6pXemIhgYCldtyPIPlL40pij+nhaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uO+nBmcAKuR1MM12e49ECmXnN9K0pqqY5DEvdaif6t7+QoTWq/9D+r9cEIJaa0nxElNp0IyK/njU4ZEZUTLA3bEotbvlNICOoRYOhEwxb1kvO2AM3aMKzcmrJ51hZJbug+GTigfYVr8wc1Iuub8G2G1XQamyUkElW9sNKT04+Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=dltZUKRV; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0fxTSHFPuSFgsiJ/jr/691I0ozJr82g1qUI8G89rJFcEu15FPU2tvzsvsDPORR3qxFT7VEtiQj2qq1K/rSonhKr1EpiD6a3t68yjq/Da3n3PmQQFl+aGwGTQwZdLKclW47NT/q9+kuTlBtbK5VEVUPrz0waCuZwrkrY1dfWtyAQGbWIslnzdeZtdb+wlFO6lLjDFDvhXmdc5sHYjwk2nVqa57Nm2EIC4NhjfXw7578mWJUefmyJ91zbeZW8AzloELk/uyg2Hhqp6eEENiJFE0Za3YM55f+c9VdvuaT4A5iBHrKPazfBkraWl5GTMG+bz025nQXcniE6gb2gP2TKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfW5iILLoswE/qBKd5VVJoRji/GgQVikUpYa4xyNzSA=;
 b=UaTh1qG4jDlNiGdnpavPx+EcRzphn07DYcOmhBsoGOTsv3UkwhNHzKaeZzRGxSQrhEoevogVVbYHgG/Dx+EnUfwHM9sItlOZveQQQUV3eT9EZ8GgIcLP9+36M+zwsyOrrQuEHa0BaRbrjAZdCEg97RmP2HywjrC2M+fT6pMAuUQRvsS1Ueq63Xduu+jfGbx+bB5rUo71DMq7bey6oTx7yFbn6XSateCbXhRq/BeDX4k1b1apc4/a9I8B8bkaG4yz0eZh6uHkb46t3NCHveKH/MYA2UqdYIjeo2bsDgOQ6upxptIcFGlQswoI9w42hkPLwD3scyDYVPTwa9+pscPSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfW5iILLoswE/qBKd5VVJoRji/GgQVikUpYa4xyNzSA=;
 b=dltZUKRVcShiKLkngxUTpNnum+XyMfnqSAP+AKD+/6PILd1KmwUpiEDVxuDpnIYTAEqC/kRPoqSZnDaGDqZHGlm7qCHZE0TpI+tRqaJXjD07YauntYWKXeSd5LV+4iu/P9fQhSEtNtZQQeEmLgl64nqr/uCYCdEVChHs5f9vcSSImWV9eehR/bPl7pUPLHKW3MCdmipAVOTUl4U8+6xYo1PzRdqg+gN7NJwORYJDCUpHy+vR9UWcft8lJR814WY3HeyYvK9tCgmSSnBS7VKoSfBMS0FHNkb117G3EsR9NIx1afWcm6oq9g+HPbZ0HbOSsbv3V+OxRwLR6GnTgQzgvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by SA6PR03MB7638.namprd03.prod.outlook.com (2603:10b6:806:43a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 14:47:11 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.9094.016; Tue, 2 Sep 2025
 14:47:10 +0000
Message-ID: <7b799cb3-ba9f-464e-a0a6-cad151742aab@altera.com>
Date: Tue, 2 Sep 2025 20:15:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: marvell: Fix 88e1510 downshift counter
 errata
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250902-marvell_fix-v1-1-9fba7a6147dd@altera.com>
 <aLbyju1nKm5LXDDX@shell.armlinux.org.uk>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <aLbyju1nKm5LXDDX@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|SA6PR03MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e63a3c-3ca5-4877-a2ab-08ddea2f98d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1VQNnZLUjhCY2QxSXduQTZCbXRNL1Z4LzBXWWExRHgyeHpodUpXWGljeGVi?=
 =?utf-8?B?S3kyNnpIbitheHpoUXZtTllOV1VRWnhMV1BTWXgzeGhmcGhYVGJ0VTE1UnFV?=
 =?utf-8?B?RFRBNUo4K1l0OGYrMCtvaXJ4T05SVFErVnNpSnJSSDVFcXVQVnpTZjdrWjBB?=
 =?utf-8?B?dU5vRnIyUXhGcUtkYkdOOC93SEZzalNPZ25PYmpTZHZVdEFWL2EyQU9jZTl5?=
 =?utf-8?B?cVdlTktTcmExcTl3RTNldW9RRHhLRGt4d1pHayt5UldoVEpkQzBHN1JJRlJR?=
 =?utf-8?B?TGd4bUt1aFZ4YVJ5QUV5WnpnUVNsU2orUnNwM2hZeVpYaTBiRytuL00rc0lr?=
 =?utf-8?B?dXRLcGxoZWF2Y1pXOFl6d0RldDZRV3NDTkF6UjN6RWx0QkJNMVJ2SXg3bzVT?=
 =?utf-8?B?c3EvdEtWaXR1dnF2VWtJMDFpaTZEOThObHVXeXBsOXdCa1Z4K1dmM2tkM0pB?=
 =?utf-8?B?YmJEaVZKTWZCQjNYVVBqMU1TVFk5ak1VaWJURXRReXNlNnBvSHFRZmt6VkJ2?=
 =?utf-8?B?aXNzU3BMbG9GQXZjMmtFYjcrM3hqQVlHQ2NBcFNjcmxmcHZBMHdJejVhcFM3?=
 =?utf-8?B?NzNXUWdTOStKQVlGNzVlMGhjdzdLWlNhM0craTU1emNFV1NsLzV1N3luUHUr?=
 =?utf-8?B?TzVSWG1EakNJUGVSTmFXb0FTWEc1RjdrWGdiZXFwY1JLVklhMjUvU3Fod2hO?=
 =?utf-8?B?dFhQMVFrQno0Y0V1VnBMdW5LVUl6SEM4WFJuVXhERUJ0UmNYYkM1TlVHUVpk?=
 =?utf-8?B?MUpITlg5ZVFnblBCclJBZGJUTjluN3lOM2sySzVaNTZXRDBpbkVwMi9peEs5?=
 =?utf-8?B?d1BWUHZCKzNVYThxYWd3a2JIMmdWUWFJcGE5Z21BU0I0MGxUaVhiUWw4ckZr?=
 =?utf-8?B?S3BzYkVkUFdXMUhNd0xQSjBua0FFVnhHTUhWOUpZc2VFWGMvNTBhUTBsWEs1?=
 =?utf-8?B?RFgwRzZMQnRhQ3R5T0ZZV3RVbEJLTmtLUmhabDNubVhtd3JxaHJaUnlhK0lw?=
 =?utf-8?B?ZUxYcGtNVityVS9NWUtWVWVpa1BMenFRaEw3aUpvMitYUWZkWGx1RDEvTE9l?=
 =?utf-8?B?dGUxenlVNFI2cjVjaHVuakQ4WFViWnFydmowdGgwd3lITkZHMnl4Q1FlYy81?=
 =?utf-8?B?bmhZN2VIYjlzOUFSVG82aEhEVXcwc1JyeHJURFI3UnllempBOGlwdm8yK2pC?=
 =?utf-8?B?cTVVWkJpS01LbUdybkFEb2Z4YkQxM0Jod0Yrb25tdk1heTdSbHVpMDQ2Sm96?=
 =?utf-8?B?Zm5rSVJyc01rNUtIOGZZUUJiM0xrYkNoOTBEN0lRSXVVcTJPN2N0TXZpaWxk?=
 =?utf-8?B?cVl3SFpOdDFTR251cC95MFg0Mys2Z2V3Ty9veFdzV2xuTFhLQzI5Q1ZMdE9j?=
 =?utf-8?B?NUdoMDloY1lYVXZDNm1mUEVOWXR4c1pPeVpKTkZ2MVBISEdOdDdRRFVaaW1x?=
 =?utf-8?B?cFR5eUVEVWdyaGtqZ3VaeDJaMS9neTNVYzlMMFhGRXdERmFkaTlCcWp0cEpU?=
 =?utf-8?B?QXhibkNCVGQxaWh5RWdGNUJScjNReS8rdDlFZ0F2TFdiSFNmNFpZNGVxZzFV?=
 =?utf-8?B?aE9ib1VoRVpwZG9xODF5cVNqMzNBcEdGTVNiMHdYa2ZKNE5yY1NhRXRiWEZr?=
 =?utf-8?B?cWZ0bHRZYTh0bEN1RThDYXB0byt1TWp3MklPVEdyOHNnZHZydU90a21NNncv?=
 =?utf-8?B?c1F2MktDNEExWHcySnN0endwWWpUaldYUmt6SVdNb0NnVDNDUHMyb1F2K0dw?=
 =?utf-8?B?YlF4RjJZWUxwSDhGbXlLREdyY016aHhYRHo3Qm9XTjNyMU9XSW1pY0ZPSjRs?=
 =?utf-8?B?VVMxR1hDRHVXMGVlcU9HYWJsRHpad2srSVRjRUxJL3pJUHdWOGRwVE9WWHpM?=
 =?utf-8?B?aEpxWkRobTZ6ck1vWUI2UnlONThJcHpwcG9Va29tb21uNDVzTEJIWFRiUDNu?=
 =?utf-8?Q?bjExKP9Ul78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE9VeWNOSkdoUzRJNTdZaGdsNEl1NXlndlowL2QrMHdqaHlPZTFqN1QrcExp?=
 =?utf-8?B?WmNhUFMxV1FVV3pVUHlpR1JRZi8wdDBCSW9JYkdFTU15ZGlrL0trZzBLbGZi?=
 =?utf-8?B?UXk3WlhjeTdqR0svQVErMGVDRDI1L00xaEdrbmpyRUNXTmQ5WGoyQ2ZUb01j?=
 =?utf-8?B?bHc4ZGpzakdySWUrTmxNRFNtdllMM1lXV1g2QWtzcTVMTDNkdW9Qc1QwOGtT?=
 =?utf-8?B?SHBsUEx3c0UwaEV3aXJ5OVVzV01abWxrTEE4Ylo3R2FYaGZORHhzTDVJQ2FK?=
 =?utf-8?B?VW1pUDRGMkpxYlBtV1o1NTllN3NhR1l6YXRMSllzdXkySnpHQ0tGK284d3FO?=
 =?utf-8?B?NkkydnE0ZGVQYTJTRk0xOHpCR0phVHdvSDZyMUdla1ArT1J5ZkpqQ29abUl6?=
 =?utf-8?B?NDNoNHV4UVFLdHJ2L05TNXN0Tk9CbVRDdlB2Y3o4VlFOSjJoOXVmaGdTWGs4?=
 =?utf-8?B?NFVBdkZKeWNuMW9Hb1pZNE8wUnlheXBkNmxpVG1PUlZGaGJIbFJ6RGFFcHNr?=
 =?utf-8?B?NDhXVG5Ua1dycmxIMC8wOEhtdy9vakFmRE92OEtnL2RST2ZwSUwrem9aLzZF?=
 =?utf-8?B?N3BmSENIamJuK2ZITy9MU0RFQTNGTGVzL2pDSTFJdVBYbEc1Wks3ZVJsb1VB?=
 =?utf-8?B?THQ1T21jeHNBR3dCbmxJMlM4SkE2Rnp4Nm1kZzdjQjVGZDNSN3VsYklOZXIz?=
 =?utf-8?B?WGF6WnJmZFJSM0U0dVN0bEV0VzNidW1jRW1rNEpqYnhhUHlvUTlERVR3NFg5?=
 =?utf-8?B?WGJPUWd0ZUFVWlhxZjVQdXlFZ05QVWxhV0x6NlN4RlRGUVpoRDFhYkRCc3ZS?=
 =?utf-8?B?UDJsYXd2Z21POEYxenduVEl6S3VlaWtrbTVGYVFuZDY2S1dtbWpRSVRwZkFP?=
 =?utf-8?B?YWlBMFNDVU1PQkRvdnBodE5pTFRzYTRJVEc5UEJrM1hQcFVUQ1JueEE2UXpw?=
 =?utf-8?B?aVVCMkNJWTF1QkJCYk5POVI4akNHc2xsc3UyUTZXNTlER3E2UEpBNEJxVzdh?=
 =?utf-8?B?YnFRYUIzNkVlOCtYQUlOcFo5NGFXc2ZNcS83aytTbk82R05Xem5aS3BjWGJy?=
 =?utf-8?B?M3dRWGhqU2pCNG81NUhpNUNkWC9rV21wVEV2YUlJSlBYTkdvY2NveWRrQ3VG?=
 =?utf-8?B?Uzl2WEFzak4vQmxlZTBPbmp4M2JmNDBZcGhacTRBTVNGL1RMRGNTNjB3Ynp3?=
 =?utf-8?B?S1Q1Zm5uajlreW5zaHVHQVdGRWpaOElNbXphdkJiMjQwcEplVVVYMm1Kd1V3?=
 =?utf-8?B?SVFid0o1UlFrczZuUkhQTFprbHdLbUl1RTYybHE3SkVQTDZjYlUrK1ZMVGVn?=
 =?utf-8?B?MUN0b0hhQkM2UVJBc0RFSDNzZU9GUlN2Z1JHVTBjL2QwU0d5a2dDMVpSTXlp?=
 =?utf-8?B?Q28wdGNDWVYvUjJhaVBSYzRwKzM5Vno2ZzhlRWhTTlkxZW13UDdWVm1TUFNx?=
 =?utf-8?B?NXI0YXBKVXowRFB1elFRcWxCKzU0eFRadThWbDdRcTJBWjFyNnJyOGx2Q2Mx?=
 =?utf-8?B?V1BxSGNMc3RiMjhlNXkwVHk2K0tJTUJzaVA5WWtaRFV3bThubnRxREtLYUxj?=
 =?utf-8?B?VUsrbVRIakdEemVYZVJUTm83UU5ReGs2dnYxVVFyUjdEaGh4eGg3NzIvaEdT?=
 =?utf-8?B?STRwK3VONmJmQkliYS93dFFlUlErNmxBUkpBd3ZWSGtmRU5hQ000RE8vZVNE?=
 =?utf-8?B?MUo3OURzK3R3NHlFOEdRaitJQUVoSjg5V1M0QUZ2RU9NMjc5WVNmazNyMHdx?=
 =?utf-8?B?WVVyb2N1RDhGaUlvc094S3UyemwvemsvN1NHK1pJS3RlUlB6QzBwcXRyWXVP?=
 =?utf-8?B?MkFIR1R1UGVyaVNVR1BzZjU2Z0FxM05PdTFublA0M1FERFZwelZ3eHlRUkp6?=
 =?utf-8?B?bWtPeU52ZGNKTWFpcm4vWHkydW16bWMzaWwwcWQ3aExmbitHZnFZMGQ1emk0?=
 =?utf-8?B?cU1UaGM1QzF5b2Y3UFZmUUFCNGk2VS83RDVqS20zTURSbWcyT2lKWkN6elpm?=
 =?utf-8?B?cFpiZklFc25hMFE4Y0JsV2NwOXdzR0o5TmpaY2l2c0ZZaHdmM2d3cVI2K1Mw?=
 =?utf-8?B?ak9LQ0ZSTWgxbTVidndLbXM0M1MvQXlDbDhmKzM3Sis5ZGJ0eUs3dDBteVRD?=
 =?utf-8?B?MjVKdGhncUdOdWdrcUdJakQ3Y1psTlB2QUQvTWhESlVqYXFpdzY3MUJ1M1NU?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e63a3c-3ca5-4877-a2ab-08ddea2f98d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:47:10.7534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pAzMX1qCeIf7Fl6IAbz/wn2zPFxkOXCWmTwm0m3DIUKf7Oq/me32BIeOFja/UqQEqSgro4iBLC1J1xsk7rO0Sj4lK/I88KM9aXIxWOzQLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7638

Hi Russell King,

Thanks for reviewing the patch.

On 9/2/2025 7:05 PM, Russell King (Oracle) wrote:
> On Tue, Sep 02, 2025 at 01:59:57PM +0800, Rohan G Thomas via B4 Relay wrote:
>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>
>> The 88e1510 PHY has an erratum where the phy downshift counter is not
>> cleared on a link power down/up. This can cause the gigabit link to
>> intermittently downshift to a lower speed.
> 
> Does this apply to all 88e1510 PHYs or just some revisions?

I'm not entirely sure on this. But, based on 88E151x A0 "Errata and
Hardware Release Notes" from Marvell, no revision plans or fixes
mentioned for this issue but only the workaround is suggested for the
downshift feature. So, I think it is applicable for all 88e151x PHY
revisions.

> 
> Also, what is a "link power down/up" ? Are you referring to setting
> BMCR_PDOWN and then clearing it? (please update the commit description
> and repost after 24 hours, thanks.)
> 

Yes, I'm referring to setting and the clearing BMCR_PDOWN. Will update
the commit description in the next version.

Best Regards,
Rohan

