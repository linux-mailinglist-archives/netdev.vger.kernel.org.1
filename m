Return-Path: <netdev+bounces-160623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F184A1A8EF
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 18:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D365167918
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98380145B39;
	Thu, 23 Jan 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="8XbaWT/e"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021090.outbound.protection.outlook.com [52.101.57.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C016CDAF;
	Thu, 23 Jan 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653301; cv=fail; b=K4VNU3Ey/UIOEM2kaG3PHzIxTnjH8JTjIQCbc/TgwSO8IybjNc5hDz+vpoEAWwY4JYFWS+CP+htrpsrfHrEddNA+2k9YgRa6sOq1sqDPkwJEoW0X/DfIAcBJbZ8DrgW8LomcvVwW4MFespajLyAlYp+TjjUzhyIM0+cuPk9bENM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653301; c=relaxed/simple;
	bh=aPz+/VLy1gkqPN9Yos+fq7QH51MWd4DXyQyeDpKNGq8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=seKlPZzBE6bDZ7Au9cGNmZizVVZ8jzT3NU8Kl0Q5Xffet3HHpFkJXijOcCw/CpAeGPNdRzyUGrOeTRDoICBMxGaZWwHYZTwb9eyOvrsVIA75lfDJ0w1E+SMWYIPGbNkoRQrU7IMfyozYl5lcvco3660t6RNegqNe4hnZ053r+iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=8XbaWT/e reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.57.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNELLoZO1NrvoSzD8BiT9NDEIgO9S5ibkRQdkgOAd5w6BEFLHL080uV+Vq+C8egEj62DzHwi2zpZ4jFP33rke1HLdSwmC60fax3FP9Ev1I2I8le63imXjWNW8pUdAjqr4wTuE/d0LmpF4n0OAHVrPdLLvBvWjiAHs1upo+FRVWfjWj2bhfXQAXeTAaazkXHCOoaXAYjZ2WmJ9k9/lRB5XBdpK3u5YzsGjhsW+Jh+1wTICXEmIVvnIUxYkb5wMKNhn15JkO13AhKpnd6cEwJBBbDLYqub9xUADWn8se0cZfSJTNMAtHAhZ4NAPI5pEWpujpFghFyrLweFS1eg0ozbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ1NQSF/B1zzxHNfcrPhCgNwGRKjG4iF+PRroEa+vec=;
 b=aRwgBfRYi4CKGErwY0ZBbRNjYoAtfZp6Dy1yquyivwoiD+EUIh8LNtQ7kefSVCntso//X4sVory3miPWE8j8NymfORQYI0fnLlzoN8YcCbWGrygub/F4vgIZ6K1bharC9TNBn1k6Z1epQPiCpgsOBZOfH+murTcNwU3r7OPGbCui3ix2HgetpayatK++wOaeamp0aMhIN/JeDb7tHlWy8Qb/LdBBbzvej5rBmNDrGy0rXD7/vUrHrA4ZGxvH5OnFBkIuJyVxje3WQjrIHqM6pzwTyrwVjh1TuBjyOhX+uH+ejVg1V2Fpaq8JWdCarc636/D8lU5Fv4Rtisd7VleKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ1NQSF/B1zzxHNfcrPhCgNwGRKjG4iF+PRroEa+vec=;
 b=8XbaWT/e1oh2R36lpKjUuUaKK4W+K34A5e32aKjRM53/wFVouewb1DxHW/BqF/+BZYyZVbDn5mKgSKHXpbxMbfNQRkf97ABEugryHlTly0IsiWFykdwEAYfa1lrAXRSd/rCGiQd0zx9h2qPLGgCQLVpLbR36B3vOa/VGTKzEQ2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from MW4PR01MB6163.prod.exchangelabs.com (2603:10b6:303:71::9) by
 SJ0PR01MB8156.prod.exchangelabs.com (2603:10b6:a03:4e3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.15; Thu, 23 Jan 2025 17:28:13 +0000
Received: from MW4PR01MB6163.prod.exchangelabs.com
 ([fe80::c474:10df:672a:55d7]) by MW4PR01MB6163.prod.exchangelabs.com
 ([fe80::c474:10df:672a:55d7%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 17:28:13 +0000
Message-ID: <587d6384-fcde-4bfa-b342-66d87ee5f1ef@amperemail.onmicrosoft.com>
Date: Thu, 23 Jan 2025 12:28:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/1] MCTP Over PCC Transport
To: Joe Damato <jdamato@fastly.com>, admiyo@os.amperecomputing.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250122153549.1234888-1-admiyo@os.amperecomputing.com>
 <Z5Ffi4PSf5LH0vOS@LQ3V64L9R2>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <Z5Ffi4PSf5LH0vOS@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::17) To MW4PR01MB6163.prod.exchangelabs.com
 (2603:10b6:303:71::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6163:EE_|SJ0PR01MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dd0cdd-c787-4143-237d-08dd3bd350ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nko4RDZHdE9IMk1CTVhVdGJMcm5uVmlqcGZxU0gwV0xCVjRnQXBqZUlTaDZo?=
 =?utf-8?B?NHd0RFNZRkkzdDhyZGRxcmFLNWl1b0tkcWV0STVzcWdIbUFJL0wwUlowYUlN?=
 =?utf-8?B?SjB3SDBZUUVHSzVLNWozblJEWHNBMGVkaHdRSnJxRnp3b2MvZDc2bEQxZ1Ax?=
 =?utf-8?B?dWMvWFZzQWRnRmZUbm5NRDRwYnJScnVrUS83SlNBUUVCRFM4WGdNOXBGcG13?=
 =?utf-8?B?dk9UWEVsNXVEaktDWnRpNXhKOVdNMzBaY3F5eWRYcmxraFE0bStYY2w0VXAx?=
 =?utf-8?B?bjNvSUhqMFd0b0R1bVU5TnhvWm9Vem1lei9MZGEwL3kzczNBckZlN1dPeXFu?=
 =?utf-8?B?QjZSSXVGcFluSVgvcjlaU3F2WDZoVFh1bWJwd3ZDY0M0SUZZRExIRVR2U2Jl?=
 =?utf-8?B?M3ZrNWRGQjZRS2o5bGdxZGlVanRBeFp2UDJKSEpwazAzR2p6TWRCeHl1L2JW?=
 =?utf-8?B?V09uZ3RmaGE0OHdtK3JTaDBFbHlrZUxuemphUm1ZdkszaUh2ajJtWENFNit0?=
 =?utf-8?B?RjFUdGpBZjV2TVhUR0RmRm84NFMwbmtmakJNallRUkkxRWRQZTBnYTY5bzFM?=
 =?utf-8?B?SVBSTGtQNG9pUW9pTzlIaEZJWUZVQnBac09WNHRmVnRtNm5LY3c5N243WFJm?=
 =?utf-8?B?dUpzK3ZiTFM2dHp0Q1U4eHlRZlY1VDQ2ODhDc0paRjZUVTZuU2pzMml4SDN3?=
 =?utf-8?B?aWpYY3ZHVVZqbXFhTGd4NmpVa1RCaWJNcTFFRjNRQ3JQWktSMXhneC9oS1pN?=
 =?utf-8?B?N2NJQTNYM0xwaW9JL0lsMllSeUZTMU0rL2RsK09VTVdsc2JQUzJKOWQ1L3Vz?=
 =?utf-8?B?OU1JdVErUkk0TXM3Y21kRTU2Q09PaWxpRjZuS0NWaWVaNmVFajkyMjJHSWNR?=
 =?utf-8?B?MlNPbVY5ZEdPNjVrTFEzbUMxdEhld1liWVkwZFhMUUY2NEVLZnNkK0YzR0tl?=
 =?utf-8?B?andhTTNlb2RwdWg3a21RdmZjb1RKaUFyOGRHK0creEtKS3lBZ0plSGhqL2NJ?=
 =?utf-8?B?RlVrODRBRDM1NXhseXNWN2Z0U0ExV2hwYzVIVjA5cHpaeWpDUjNMVmFUR1pY?=
 =?utf-8?B?NVloVlloN0ZFTGVqU3BzamhNMW1kYWdOcVc4ZEpwdDNGZExHc3J0S1lHM2pX?=
 =?utf-8?B?cmlhdVB6N2VWc1ZCYXVhL0huTE9Ld3dDMHB4dzdYWVVHWHkvYnBTbnNIMzhO?=
 =?utf-8?B?Y1JZRmlXenJKVHhrMjVkL0tqcmNwc2pVV1piK1loZDk0ejNVUksxYWRKUkZW?=
 =?utf-8?B?STB6bm40ZmFsQ2dzNXBycGhIcEdmUWI5Wklpd09wY3JsM3ZDN1RqVFdTNzNv?=
 =?utf-8?B?dnpZczRhbGJMaG5FOW9iNU1hSW1SMjUvZWlXT2ZnS05VYytJanZDTWRsczNU?=
 =?utf-8?B?eFVZTXIwUzJPZ1VoWGhwZGppNXNzSUxWVEFLQkRuYVRNQ1lBSVprNms1NWZX?=
 =?utf-8?B?blpyNmVHVUxuZUZkdEtTK2FzZmIweUVUTkEwWTl1dW9CQTBUQ3ZZVmdQODRQ?=
 =?utf-8?B?dDhEZVNDeWVsaE0xYmViaXIyb3doNG1FTExSQy9EclNLd1RxN0psVE1qZ2l3?=
 =?utf-8?B?Um85dEdDdi9rSDQ3bFpGSGQ5OUpXbmdlYmtZbTdPdUZrczZHeHRSV1QrWk1X?=
 =?utf-8?B?bFdNN2N2M2ExY1hFTi9kend3SzhYOFJLS1QyYmVZaGdXcjAway8raDJLUlNF?=
 =?utf-8?B?Zjl5SmkvT2YxUTBtN0YrQ3VUUXA2RW9NUTZGYWJWdVVkdWpmRFFaakRITWZV?=
 =?utf-8?B?TE9hTDhwTDdRREhpYUNIRktjeWNXUHJ2MXZTdUNoTU5SK1oycEhOME0yUHla?=
 =?utf-8?B?ak5vTWhINFJsQ3d1YVNybEIzYlRFaWNQekM3K2dnaDcweDJ0Qlg4RUk0OTUx?=
 =?utf-8?B?VnZuaUtUeE1XVFdpamhuYnNvM3lrUk1hREpnVnBaRS9qRTdlQ0VjTmErMy9G?=
 =?utf-8?Q?8n/LbUo2CnI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6163.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlJ5dHZsTkorRUlFbVVGMWo1UkRVVlRTS3dCdGRVRmFmUzY4NzFCbVN0N0Fi?=
 =?utf-8?B?ZVBPbFUwSXVRNGJzdGRDYi9wR3RSS1I0Yk1XQjNIblJQQzBEam5aYVM5ejBl?=
 =?utf-8?B?OCtzOWxqQjdtWEdyUkNQNEtpYzRIemNSRkJlYjUxZzlRVnB0dFRUMm5xRWxR?=
 =?utf-8?B?c1k0aTRIdE1LYVUzakRPbXFDU2Jvc2lVNjRia3JVU0JrMlliZmdjMGw4OTNU?=
 =?utf-8?B?NDdIY0JSUHBXV0RqWjZxRkJWTFBrK0JhV0xsaDVKNjJtOEV5ckxSRDFFOEdq?=
 =?utf-8?B?eFQ1SXJIUlpPWkFtd1h1S1A1SEllQmxHb3d4bm5RYkpTNll6TU02UlpsYjJP?=
 =?utf-8?B?SERielBUbndnZUpkTmxObVdrRmd3MWx1RmRyMUloZUJ1Mko1ZjBOMmFhVjdG?=
 =?utf-8?B?eVZnekFwcVNacHhYK2NNVzUyVzFUOGo1dzA4UC9oRnJRdE9mdW1sdGdFVkp6?=
 =?utf-8?B?eUJRbytiNUxPdk1uV2RETG9sK2trQlFQZ2c0UzQ1K0wwN2ZZS1NkRlI0Yjd2?=
 =?utf-8?B?cDFnb1luSVI3NHVORmRSWjJQRUs0OHh0WDFtMXVqNkxweFdNLzUzaTJtSHor?=
 =?utf-8?B?VnZOMlZEL2ZqajlmcmZ1eHJOamFVWlNpZzR6WS9KSVJvTVRWYzBXK0xyOFVQ?=
 =?utf-8?B?TVk0VGFUSjk3L2FJcHNmbDBpbWRHNDhqMUJXR3ZZV2d3K2MrenIyVDM3dkVB?=
 =?utf-8?B?SWgwT0d5TnF5QWpHUjFOdnFocm1GZ1lJRmoxVEROeXIvbnVtYjZNcjNmdDJR?=
 =?utf-8?B?OTlNV3Zrb3hZMFpobFF1Wmg2a1prcGpjV3huUTJHMng0S2o2OFRNWmVhMTJo?=
 =?utf-8?B?VktaajFlUlNHbG5KRERRdzFLVTVCdDBiQVFnUXYyTVZtbzgxeUJraWxDeE0r?=
 =?utf-8?B?ckE3cVFQTnMyNEVSK1pRY3dQT0J3bjEzNWt4WWVuUlh4Z2ZwcWNES01iaGdX?=
 =?utf-8?B?ZS9waXN1dlQzMXQxeEVVeDVEc3hNVkY1WTltb2Y0RWorSUdLVTAvNmxuZVJ3?=
 =?utf-8?B?bnd4YmpyZXhIUWlJa3RQYnFxamVuc1IzTEM3TzN2azNZQ0dHSEYyMnRaRy8w?=
 =?utf-8?B?dklvNnNDenAvWThIUWtyTGVtQVJCUDh6aThsNVh6a2RlT2FPY2xyc3pJUERM?=
 =?utf-8?B?RE9LQW9qZHgyc1QxaHJYZ1Jjd2tpQzR3TGhrRkkrOW1RL0hyS0FHWkFkN2RQ?=
 =?utf-8?B?eTArK3FOZEdWWUZmc1Q0b2dacVY2Q2t5S1hCT0pDMVAxQWF6MXVZdlVudVgv?=
 =?utf-8?B?M3AvZFdRZTRiN0JQL0FROTAwb0kyN2xGWHA2QStlaTEzWVI5YWZDK2g0QlZa?=
 =?utf-8?B?QjVpbHFYbHBNSFFRUndXZENDcHJ4aFRxUG50WG91VXhFV1JhamdMVmIxNmlu?=
 =?utf-8?B?MHczQTVuOWJvQTd5SjRNVTU0bmZaczNCRTBZeXpaTVlnTW9MV0pRWHhsZ1Fz?=
 =?utf-8?B?WkQzeEhvVnVjQUZvTHpyQ1orZWV1aHVTWU81N1FmelpmODAzVXI3U3lSMVQv?=
 =?utf-8?B?U1Y0RlZRVlFlbktjQ1Axd3JUdXlHYXZRQXMzVW9BRGhmM2RkNUEvWk5MMHl0?=
 =?utf-8?B?T0VEWmFoWTVZblRTS2ZYMUhvbXkzMmI0b2xScW5lQWE1VHFGTmtIMmNOSk5H?=
 =?utf-8?B?bFdiTUJBR3NHNWpqZEpPbFdJcU4xYmlUY3hYSjNNM1piZ0s0cmlEUi9DUm1q?=
 =?utf-8?B?YjBxY3hkWm91UGlNdmptTzRBRzBzVnRBN3AyZy9wbnh0RG5vN3pWS1dNOWh4?=
 =?utf-8?B?andiNjB2dkxmb0xHVEZhRHZnTi95V3FGdkRlc1plVXhwdXo3L281WHMwRTFX?=
 =?utf-8?B?b3BpMVNZbUx3WVNQVFFoN3B3N1hsUEdSK0Q5cm5SNjVHMXF0UWtuajA1VW5k?=
 =?utf-8?B?b1k2aFdURXVVVDVrN1dablVmT0JpN0lCM21xTkM3TlA4OVhPb1ZUMy9YUndQ?=
 =?utf-8?B?WEUvMXpHYzNBMDZMeS9GU0dtczVPV3BrTlNlYWVCTHpkSGV0YUt5QUx4NFZ2?=
 =?utf-8?B?azRjcVFVSmdaaEk3WDZNeTI1SGp4RUtwR1o5Rzc4bWJ0UVNuSFBIdE8yOC8w?=
 =?utf-8?B?NW8vZm16dGE5RkFqTVBxNVJVYzZxMEE3Q2d5cFNkd2RzOHRFUXY5bHBON0Jj?=
 =?utf-8?B?eTBoK2NmclVqQzFmZXJTMy9LRnJYR3R4NTRjV0NhYWlmYlJidGdEVXRlQ0U0?=
 =?utf-8?B?Skl6K0dSRDUrVEZjVGVXUUpNdjZYbU1iOTdSNEtzczdlS29BTk10REdIK1Nx?=
 =?utf-8?Q?uw5Jil9zFh1xv5irzdVI+jXhgVOqjgBOC1iYGFuxSA=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dd0cdd-c787-4143-237d-08dd3bd350ae
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6163.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 17:28:13.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VbThKmtOrAyayrO9XCYwsEVf5fWv8aK1CrJ0yJBfqk2SrMFogLvtyWMRarfWdaHDvWmGB1YuL9C8bF/VMVqT3dqH3wVjVEwkkuqXWn6yni9+7f6ZrIASMysc5HcWWfL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB8156


On 1/22/25 16:13, Joe Damato wrote:
> On Wed, Jan 22, 2025 at 10:35:47AM -0500, admiyo@os.amperecomputing.com wrote:
>> From: Adam Young <admiyo@os.amperecomputing.com>
>>
>> This series adds support for the Management Control Transport Protocol (MCTP)
>> over the Platform Communication Channel (PCC) mechanism.
> FYI net-next is currently closed [1], so this will have to be
> re-posted when it re-opens.
>
> This could be reposted as an RFC, though, until net-next reopens if
> you want to go that route.
>
> [1]: https://lore.kernel.org/netdev/20250117182059.7ce1196f@kernel.org/

Considering the time it has taken to get through code review, I think it 
is safe to leave here as is.
There is very little touched outside of the new file, and a rebase 
should be automatic.

As far a I know, I have addressed all issues found and posted.

I would be thrilled if this could get ACKed and added when net-next gets 
reopened.



