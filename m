Return-Path: <netdev+bounces-195955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862C9AD2E43
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D5916E4D3
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2410279354;
	Tue, 10 Jun 2025 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UwuAdE+m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C52AD21
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749538999; cv=fail; b=Bf4jo7z5uUUUvFIl/PqBcSfgRbPilWx7aGUz6hFLOw49GPDmYjGXuVvTbqB8UkNtJJt3XiQTZ06ziSd7LJC02R7fkDH/kktJcPcP3bliVx6Lq6f38yNIxg9ibp5BN7AL9B6cb7wEep19QU1mqitDo6RA1kfGGR6huD3oEOUQO14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749538999; c=relaxed/simple;
	bh=oXSSCRkQ5yw6q57LdFML5zQmCog/3QvK5JLaQcEITsI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnc5o7eKQzhh8i6G9ggOK4Ye5heH+rj0UyJ8VRiKH9ms41EI5bp9CO2wubsG1lvIBcohbWzHyqdf0o7l7LhN8gDyROanD3Fs2XdNTXbZTdiIB+jUzHg8W/FK+yWHH6K0LKGeTHQeg1AejhVGULHqQZpX3mrV3V41dFqcCifaif0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UwuAdE+m; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoNKZjTMXwLT3Ss2NLYItgYxzyvkce+k9YXRnEwWAd9nbUCq+Wk0bWZquHWfN3GQVQPk+zoSVmuf59GTB6Oxyhyzn6LvWUlrlBYywCpmnwT1QedXupRq8ZlNVblb/wSnHm1ikGnhKBEYp0WUc0fwrUy3P632AJgtAD+sJqqik9zr5s36K6QQqzF3/NugZc5a9GzUPa/j+1p+ie3u2o0c2prAE/Xzxgq7AuxT14PQlSl73g+KHzUm0kk2QSX2Nr39JQq+INZ4HA1OQoa3CInmVua35yWy8X8Dza9Sa+NuP922YqLMpYuIBjnSifgMcXse6/RBi7/uavbJzCSTPnkJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tzz95YeN2URzVZl/LqJeooqNvYD3KFFXDMtVbziAZv0=;
 b=IQAQRT0GE+k/7jZL3JiqTvCztIV0dGuLJsEsmttJgfUTYThlTDp6PMLj0JPwgRszmtG74/vOovJQhjW9l7AmDsP1W2eR0Uj2+cJupdI5aDJuFqxO1wU7tka6nOU1AdPNgPpQZDDC5Az8b7WA/J6fP00CwSdff28keFv1NVMrnZMqpymZrewayVI4iJBJ9uU0nnunxdx6g168YzB4Xj6SNBkbWfoT9ch9OiYlPZxOwgcQTg6OTmSYn6xNqvM8VDCNgMUx6GygYntmSVn909jTL0mt4zfZAnKfWF8yXR3QaGaCmTP9Y1GK9XbdoIKQZHjVDw7MkgQDQXFxnuGiTo3FVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzz95YeN2URzVZl/LqJeooqNvYD3KFFXDMtVbziAZv0=;
 b=UwuAdE+mLHJWSy8Nx+xSOnaxH6+JRMimqDzJnIuxAP1gcTSA2xDObec1gmq1my0DVYa+POlLX1MJ76RzBWvE673RIMUWfhca3V6WCQKqC6wagXCluonS8aFNxXL+E2sb0xW4JQhKxnZeU396DIW8BbGY7hFenWlXKnDE2JLcD/898Ii1c1TReAadUOu/PD4509D4COuW8/kzXrsWAd/BnNmVUkWRAHxMCoGlUKhzr4CIntRZ+uPvZ8pvZcKEoA9RinLbfKDJnNbsccRq9h+jd5/qOF6AOTqVXh2F3gS8nc5zactrH+tfDA8I2YoFSrMS67QVeyYZJS90tDsUf++jyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 07:03:15 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 07:03:15 +0000
Message-ID: <63dcf1ff-7690-4300-8f76-30595c14fec1@nvidia.com>
Date: Tue, 10 Jun 2025 10:03:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] Revert openvswitch per-CPU storage
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Simon Horman <horms@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, dev@openvswitch.org,
 linux-rt-devel@lists.linux.dev
References: <20250610062631.1645885-1-gal@nvidia.com>
 <20250610064316.JbrCJTuL@linutronix.de>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250610064316.JbrCJTuL@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0022.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::7)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: d787eb8a-1ccc-4a17-123f-08dda7ecdeef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmRoeStwYWZ4cm56NS9KMFhaaDhDQ29sUExDV29SWElmUnhhSFM3QU8vRG5L?=
 =?utf-8?B?QjFhQUhVcllnb21sTTFKcXlJL3F2TXVyUDU4d0xSVXdZcDJ3anp5UCtQRHpv?=
 =?utf-8?B?cnhMdmxubUh2T1NqQ0trRmRQblA5L1Ewam9JbW1lY3Z4b256QVNneEdzMmpv?=
 =?utf-8?B?K01IR2ZiWWVJMUFhV09CV1BlWnlRci9uN2VaL21CdkhvdTBraFlUQm5WaGE0?=
 =?utf-8?B?ZVV1M1A0Y1dzUmJoWHFxN1RZbUlSQnBrdHB4QW9JYnEveHNDWk9Ydm9GR0xQ?=
 =?utf-8?B?Uk82dVVkSFdWVTFoVWNpMUsyZEl3b0cwak00bUlQUytUMmpldU1TODV0L3Br?=
 =?utf-8?B?aDVjb2ttcy9oUjRMeFRJcFdzSWpaaitrTURxUTFiNUtwb1dhU2V2Y0ZzaFRp?=
 =?utf-8?B?OGVmcFFaRUZPb3FYRnh1dVJEWTdISGpmQTVaQm50b28wSy9tcmJIUk1zMlR4?=
 =?utf-8?B?Z05MaEFGblhYWnhXWnh2N1hEaVBZbXRiSHNaem8xYm1KdnZRVzh6ZG1pRTZv?=
 =?utf-8?B?NG95NGczcDlwaVk4WE5rendMVXV2OGJHay8zZ1RoS0xQdkM4VWlRSER0cjB3?=
 =?utf-8?B?d0hWV0pEa3ZEOXJrUzBCaTdiQ3kzNkZJNkxKR3djak1Fbi9OcFR1VjdtbDZW?=
 =?utf-8?B?NFpzaHhQTUlDdWowTjJRVHdOV1NZN0Z5UmVzTjVBYTBCMDhucnJldWxwWXBq?=
 =?utf-8?B?WDlUNUQ1Sk4wTFIxSkFTcStPOFEzQUFTS1hGT2ZKZlpZUW9lYzhvMHFUVkQ4?=
 =?utf-8?B?dEdqZ1V4SDFLaEVZcE9pd28yU3lhb3VuMVBxd0wycmVHbUp4djc2WXhoMC95?=
 =?utf-8?B?bGJ4NlFERVQzSHdNbk1lcHFyZFZYT3JucldmNnFBa3llbVBOUm9sQlg2eWUy?=
 =?utf-8?B?VFdTbVdlc0lBRDZ1WElGc1ZEYnV0dWJyN0t3NmM5ZWJuYUhWMHVoWlNmYXR0?=
 =?utf-8?B?cXY5SEFGSXBvOFcwQVZMN0J4alBCeS84RVVWVXhwc3NNQUdCeWw5cVVJQVJq?=
 =?utf-8?B?RUlncHZlUnJzSjRtVVZvd3ZPYVAzRmdiaW5nOVVkQmQzQm9YcStvdVlESStp?=
 =?utf-8?B?VzVodDFTczBSTU90bW9MOEdobXZ0T3doYjZ2MHJRVlZnSFNONTV1S0k4cHA2?=
 =?utf-8?B?bW1sZ3NzdHZEM2JyZzFTVHdOUkJ6b0U4eHBFUHhKWmg3Wmg5R1Q2M3o2UGdE?=
 =?utf-8?B?VExrSG9ZVHBlc3hLSVFFeXoxYWVHSVBXZ3dpdHo1cVphY0FyVWdWTVZqSmlk?=
 =?utf-8?B?c1A1NmZibkt6K1dIVDAzNG91ajNLTnJGeDFiWFVqcU5sUVo4aEQ0aEp2N0JJ?=
 =?utf-8?B?ODJTdWhJNEtiRndUMnE2V3E2NElLQ0tFVlFPMm5oWUxZZUhvYy9FWUtkWHhM?=
 =?utf-8?B?L1BHWDcyVUF0cnVrYlZ4N1FVbllyY215ZnN2c2c1dFJnZHNOTyt2dnNONmg3?=
 =?utf-8?B?V3RYdzByQVMyODNNVjVyVDZWbjUyR2NpV09XeENDcGpPcXBBenRoNXQxY0FU?=
 =?utf-8?B?Ymt1L2FRaERzSjhUbFo1Mll6R2Y5cktiZjcwVUVoUFFrNmZqbHZuWGp2L0JM?=
 =?utf-8?B?TzI3SU10ck1GL1NKUG5Rd2NiQVBvTGZ0RnBxOWIyUkt2NTE3dXNyM2pXTFdi?=
 =?utf-8?B?OEs4UERVNFJjZE1xYW82YlpYaC9PY0RoVDlMMWVkZXdvMmdxektkQUFpeUlr?=
 =?utf-8?B?bFVNOXYzNk8zaFhNSEJwVFJPS0pWMzBWcDdlaUJWZEMyMVdDMG5oVkxqUjln?=
 =?utf-8?B?a0VYR0lRZTQxbDR1V1FrS1Y4eHRTN3pZOExoM2hGbk94NHBqcS9lVFNIbzdq?=
 =?utf-8?B?K3JUOE1YSTZNSnZ0UUJGYVQ4U0prL3hHRFNMTEc1cU1lemplOEttaEhaMkNN?=
 =?utf-8?B?VnZxNW1vdnlOckNPaG9XYTZYck5Xd3M3ZlJHcDg1NGNnNkovK3U3TTE5SjQz?=
 =?utf-8?Q?A88hu0WV4zs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enRqSWhTZUgzdjI4NFRRcmc1MzVxdTltalZ4U2NYNTZEbHRNRHc2elFEdHhn?=
 =?utf-8?B?QTZta1h3VGFVNkY2aDRuS29keGQwWkozSHl1NXBzMjMyWEdGZjkvWi9oZEtm?=
 =?utf-8?B?cXpOaGx4b1AvelY2a2xRbG1pUmlibDBGWnBHZGI3RU9Qa3JYUGNENHU4V2FR?=
 =?utf-8?B?blZaRWE5Vm5oZDhQZEloOXppSjlvaGF1YUVHbnBVdXlldGg3WUNUR1FLZzkz?=
 =?utf-8?B?RlQ4RGNHT0hvZEM0WTNkOUUvWmhyU2hxNDg3YTdWME81MUJrWkNxZWpoSW5S?=
 =?utf-8?B?VjFKVEJMczJTOHkyWlZvRS9QdXNUYURZVyt1d0doMmVPY2NwRXNES1p5OXFP?=
 =?utf-8?B?WHpmQkY2TDBxZDNpUTRxSEJJRzU0UmxvbVpZWjVMcTZhQitYT25xTzJLMVkr?=
 =?utf-8?B?bENhamU5YStHbmNtb01xbnBYbmU3SGlBNEVPKy9KTFRRdnNveTJXeC9xa0Zz?=
 =?utf-8?B?dGg0U1RWRUxSZ1lUY2h1SnVLN1NzTFgrY3JNOGdSUnhTZWYzUTFWZGVGTStJ?=
 =?utf-8?B?RzBFNG5KUnhtWi9sOGQwMXdFWU8rV1RFRmR1NDJQd2cxSGdEb3FOT2tDUTM4?=
 =?utf-8?B?eUd3VTJkQnFFYVpFdkpacFRLZ0xtM20rOTlqNVFDcTloZy9YVlg2Zis0Wm5P?=
 =?utf-8?B?c0pLUTB6SzlvWUI4b3RSelFFb1VpUUtoek1zY1V6QzBVcTNma09oVUVsRksz?=
 =?utf-8?B?dkxGSUwzRTM5N2xzdnpYWUxHZjJlOGhxalBRV3p2QUVja0ovNzRXSnpLeGlp?=
 =?utf-8?B?N1RVUlkrUDJBWklIMlVHem5RY2ZFSEFpNTNGQmZtZTBlS0ZEc2hRWVJieGUz?=
 =?utf-8?B?UU8zUGFtNG03Rnp2MDhsUm1rdFJEMzZOQTNUMWZEdEdYb2lQQm1ZT3VOajE3?=
 =?utf-8?B?OFUxd2dZWWprV1hSZVhSc29jYjQvNDFhcmRHcnZ4MzNwMmFhdm16Mkx4cys5?=
 =?utf-8?B?R1VZWGZJQm8vMDRSTS9mWnR6SmV1R3hrd2M4WVcrMkhYTWN3VkltMUNxM3BF?=
 =?utf-8?B?ZjlUaUo1QmNDaXFEYmdTdzlFUGs1eGZTaGMxdWVXUm9CMjBmSnlJNW5HU201?=
 =?utf-8?B?d1h1T2JwUHBFdk1ueUdzWDhwZXNRNk9uOXZKdjVUSDNKSCtrdUFXYk5TalZP?=
 =?utf-8?B?eWlwUUpTUElHZmtJdFZvLy9jeGVTd1plSEZHaW14Q3FWb0xBSkpnZGNyUFMv?=
 =?utf-8?B?dGIreTBYdGYxMGloVWM0d3dGcUtVb1MzKzdMNlFlb0dwVW10c0tOenZjYjFh?=
 =?utf-8?B?Z3lSWmE4NGVKUERFMEY1TmRWMi9jdURpNjZiSCt5ODBHSXVvRlpQWUhRTzZZ?=
 =?utf-8?B?b0ZHUmYyWDFGR2dFa0ROVmE3R3lISUhldG0xODM4ZXFwbTNvZDVTelJZc2ts?=
 =?utf-8?B?WXFWbXJjYkpxd0FMdStOMDdFWTBYc01aQjBXMlNtSVhwNWQyMHVieGc2QlpD?=
 =?utf-8?B?cTRhWEFnVzE3aE9xSG1VbVFyUFhYeTZ5NFFaMWFaSHVDZE1JUWdCVElDZVRD?=
 =?utf-8?B?TVUxM2RQT0xEcHBJMjA0UWlFYWo0WVFaNFNCUktXdzhTbit3UWhMQmNua0dC?=
 =?utf-8?B?VnhFSkU0YmZ4VThFNkZKN2wwVkcxbUV6Ynh4dnBia3RhVTZORVJKalRkanhL?=
 =?utf-8?B?czNEWmt5L2lRWVp0elIyRUJIZDk5TDV6OXdtNEhjZEVQNVhsbWJkTEZBaFRy?=
 =?utf-8?B?NngzM2JZM1dtakwvVFhmVEdMUHZXM0dnUHNDaDhRS1dJZUsvNnBMdjNORzhO?=
 =?utf-8?B?dWprT1pTU2UrN3hXVXJnTm1qR252ZTNCbC9ydXhENTFXWWpSY3pTOHBybkw4?=
 =?utf-8?B?cmh6MGVycUhaSURZUjZDVlNMbHVlZnJyaHpLWC84SmtCeUt6Z2V4cCtGaEYy?=
 =?utf-8?B?aHF1emo0bnpaVTRWTFVKVlZQMEV2T2RXekNkUGtHTWJyYXZMa2Jibm9yMDNh?=
 =?utf-8?B?WTY4aE8yWnZXWWZ3MFJpSUkxdDhUV21Ca2xDWVNTWVlVblhBVG9lK2RRbGhq?=
 =?utf-8?B?YnM2a3hqTDdJM0NGOC9ZUTdsRHdBc1N6b3B4SkpyQ2hrMExMWGRxUDFQbEkx?=
 =?utf-8?B?L1c2SlNZRE1pYXkxZG42WWNpUUJlZXFMWUhlWGYzSE5OcDFSdUdsL3hWWk5D?=
 =?utf-8?Q?qUv3FhK07xT4mkxS2c43yoa9v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d787eb8a-1ccc-4a17-123f-08dda7ecdeef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:03:15.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RP40vFlMJo7mLev0BaxZiQA/VCXOcHdnyEnhmvAB+HJ1cnahDspsVJUhJmKh4kS3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735

On 10/06/2025 9:43, Sebastian Andrzej Siewior wrote:
> On 2025-06-10 09:26:28 [+0300], Gal Pressman wrote:
>> This patch series reverts a set of changes that consolidated per-CPU
>> storage structures in the openvswitch module.
>>
>> The original changes were intended to improve performance and reduce
>> complexity by merging three separate per-CPU structures into one, but
>> they have changed openvswitch to use static percpu allocations, and
>> exhausted the reserved chunk on module init.
>> This results in allocation of struct ovs_pcpu_storage (6488 bytes)
>> failure on ARM.
>>
>> The reverts are applied in reverse order of the original commits.
> 
> Is the limited per-CPU storage the only problem? If so I would towards a
> different solution rather than reverting everything.

I don't know if this is the only problem, we can't load the module
starting with these patches.

I suggest continuing with the reverts as I assume your new solution will
be net-next material, no?

