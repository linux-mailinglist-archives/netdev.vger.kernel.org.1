Return-Path: <netdev+bounces-206417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69603B030C9
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 13:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F3017A0D8
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F74228C9D;
	Sun, 13 Jul 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kSVPpYXk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0307A1C3C1F
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752405059; cv=fail; b=phit6Y7r36n1MRBYwlo+tuA8YkT1O4Y2NGGBv/TPhxHffWuWCT7gpDB5pGDg+tVQ8CTgO+k8HccVN/xIs42xKDtNIt9uDuFjElKwkgluET0eggDnh49aFDLFDwDrLnsNk06r4VnbuF/Tz6TdgSMmMHqqijP0/zogpE4ykERnRtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752405059; c=relaxed/simple;
	bh=cupHKiS9PFeCAROED+zVpz3IvsbsrdX0d6PcBp5J5bE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VF8Jz3QJWfmDJK+ikXQ0xxFfWeb4mYYMd+0HRXRwVOT5m2FjgkRpoOmPq36rD3qbgC1HLR3hDDSIcS4qXqC4rOXYpXqsryZ4ZOFcVEhPJ6YrxvsezgmUI2RCFGRNjpDL5MY4FVZBYXpcybMU5nNLNYWoz/aHktDgAMOs0ttFSIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kSVPpYXk; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYCyMceUJJ8YzHjdGU9KspXRPM31lL2JjQIty5jP+Oa8hG/GRaRfGckhy/BjsFGKy5mLvor5Yswxo9QQCblqC8SAEKjy+Mns5PH6SJcxZwvRF96Mbvq++D59LKtjGtZ4LNQIRrYyFWEVOe4OVEz0HvaUx8myfIzgAIv8po/ALoelUaJdm+cCYUOtFvk3ZEIbk9LsktDOuugmehpfpIk+aXGNoS6Pr7K0A3EaVi/QupsWzE5MCqKeOglaZBCHJNiBA3gQOMoCPvhG1IWMIZOpKo/Offwdl/FAjVqm7ch8DqYvKZ7pS59UFsp7c1Jkp6AB5UI2z0RX6W8TFRFh7SWfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMeLLYQz56lci9kxjngJrtrCbBr1feYCz3ku0rRw7ts=;
 b=edcHQcUOlPTQ1A7oS7LjJTyQW5IIKDKD4CLcfUpErRgayV9MZQr/pOsMX27rTZcn/3A8k/GEgy1HPUxaY2lKVz/xnTP4+qhq6/f/8N8qagHeRCJW/ABD46z7FsCcQlRNqVHQLAJEFI8SFEOmT+3R5sbjYMMC4SxxwM1JTT8oE9vIrQWIfKdxTf9mv6JKLKX0dNiQFLYa5B0oEM3dsOCzhFNXCgP6QeCEYf6D/F4KImCGgia2hsUFNjs+wSird+cHupAW8pEw+jgH6oDQD2CrfJOllo4Xe3BNMQhdl9yAmaeCm3U22/c3pD1bM+iJakEET3ucPJFWqHPgruIMpBXh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMeLLYQz56lci9kxjngJrtrCbBr1feYCz3ku0rRw7ts=;
 b=kSVPpYXkWJjtGUkLK9/xGRw2wkrXpb6iZs7ZrW0pTDfL8HAz+TWpyxPRLpW+mM2kLzSdzg/d3slPliGVf6zIKAGy/abR6p4/1nX2vNIMOeMQsYoY2RF7iGaeSThOjy+TYWv0XKn4MczmYhq3WKAI5mQ07sRuXv1qUxMcmit0X4u7/U62MSaeCG7eIeHPJivN+QeUmRa9aNfq6dlT0l8oSI5V9+9OwkcWrZqpQNsY3V6Epe8Pt3BpPBIYt87zUTMQJeuiZz5eKm5qtaRZaFlR6YpGZ5nvlWc1bAdohYkT2cnmQj2Zx8W/58AWOLL0/zmL2iGQlKL4C2Mxjm9Nl5P1Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sun, 13 Jul
 2025 11:10:56 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Sun, 13 Jul 2025
 11:10:56 +0000
Message-ID: <f80a0316-8bfe-41d7-9ebc-b1457f35a0cf@nvidia.com>
Date: Sun, 13 Jul 2025 14:10:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/11] ethtool: rss: support setting hkey via
 Netlink
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250711015303.3688717-1-kuba@kernel.org>
 <20250711015303.3688717-7-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250711015303.3688717-7-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 9413c174-dbd7-4264-4dbc-08ddc1fdf040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDAxNnFRVDlrbGh2RFR3VkdHNmE3L2wya3RSTUJnTjlvRkxXZDRVeXlkYVNy?=
 =?utf-8?B?N1d1Y2RGZVJQQU4vTHBFTTdrTUdmVWNNUlphR0RhQTEwUjBuL3d2aXBmMUEz?=
 =?utf-8?B?Tm1wUjdNNENjSGs3MFBpdW9CbDlEQnkybFN2aHozYlQvR0VIMVl4OURiQ1Zr?=
 =?utf-8?B?U3dyajBxN2Q1WmZTNUxZY3pmQ1Nsb3oxUkRmcWVxaU11eEhTWUV3VEJPZE80?=
 =?utf-8?B?SkRFQnVmT3FmSlhDZ0FmZkVSQ2NEZXhpYlppc1dkR05YcEoyaFN5dUFoUGlG?=
 =?utf-8?B?Q296N0IzTmJHa1NUNk1zdkRKMW55MmhtT1lQKzdXVFRzaU53NU9rMVVMUkhr?=
 =?utf-8?B?LzdIUEZwVzFsTlljelk5TFZuMnorZmF6R0gxb2hNNUk1SFhLckZQZTdzMFM1?=
 =?utf-8?B?THFIZklSanJLdUpBTnAzUlIzNXA5UkxBL3Z0U0hYY3NodnUyTDdqYXVmdmNU?=
 =?utf-8?B?a1kyOWNSU3o2VFh1OXB1aThiTU52OG10QzdIUG96YWZIMU1WcW9yb3gzZG91?=
 =?utf-8?B?b0Z1QXdHMHUrc2pTMDdSMUdQUWd3RytOQkVHUjJVeGVqL0h3bG5rRkliQTRO?=
 =?utf-8?B?dEVUQ1RTN0crMWJWV3FLUzBhOUxaK0o1dEMvWmlpbFNhNEp2dnU4aTVGRUhB?=
 =?utf-8?B?enRNcm5EREMzeU45cDM3eXBLbXpFNFpOcmdodzMrTk9oNkQwaUcwZC9tMHlx?=
 =?utf-8?B?aXpvcU1RU3c1QjlaRGc5SjcwWHJXa3NWZElCWTl0cm5taEdWTVE5dFZkbXZa?=
 =?utf-8?B?dWdEMmFiWTJ5MjAwYWtwK25Ya2RZbGlpdW95UUVBNWR5cXlxdlBGckkwQUxQ?=
 =?utf-8?B?dWdpcjY3endCZXRQa2pQc3RmZDFUSW1DNndxQkdYcW9iRk9hQ3F1WVp1elk1?=
 =?utf-8?B?UWs3T0hGNFVTV1JySkd5cTZmRkdPaWtPd2xqbFBJbDN5dVVnQU1wZzlaZng3?=
 =?utf-8?B?YVAreit5ZGE2UTZFZmxMNkRYV2ZYVE82ZVF1SFZ1MkE0QW96cFNDMzlzWVIx?=
 =?utf-8?B?WkJzeklHYnhkMDRSTHlJNGNiaE9BQklWWmkxQkl0a1ErWTdMTVJXM1UrVnp6?=
 =?utf-8?B?bjdWZWVPbEczR0Q2TE9qazVJcEpWNDBHQzArbUt6SXdKdm81VTBYT3poZHhq?=
 =?utf-8?B?aXVPVkFlQUlncDlScy81MEFhazNOVDJwUVE2SUVpVWVEdFFNQnJQU3JxT29j?=
 =?utf-8?B?eCtRNHRNNXFDK0ViS0dSaE0vUWtWWHNlcXJDOWpzWm5IT2RDQmZiZWxWVmNh?=
 =?utf-8?B?K0c2L1BtczNHMjJPQkhub2pyd2wxTko1RzFrUDlVVWZnOGE3VlV0bHVFNW1x?=
 =?utf-8?B?Sm9vNG5rSXNGU3FGRFZvTHRhMHdoTEVVR2NMYlNtYitIbm9LSmtlbXNreWh4?=
 =?utf-8?B?QUFSYjJPaGlRV1ZxcXJMcndtb2ZGVUZWZEtNS1EreWM0R01XKzFJSUhVdFkz?=
 =?utf-8?B?SnhsZEdwV0Q4cFVET1lXdUZxV1c1RVZySE91Y25nY3lTb0Z0SXJZUDliRE9n?=
 =?utf-8?B?UENzZFhLcnhQZXljQzRYWlpxTXcvY3NNeHNCSDR2Mk1QQXhNWEJ1a0hDZlNi?=
 =?utf-8?B?czlMS1RUdUo2TG9tb0ZibmwvcDRGMFo3OTE1enJuWjVuZUZFeWwvZUFjZjgw?=
 =?utf-8?B?RHBxcjk2eWcrUDBFaisybjFwN05VTEkyV1Q1UUgwNzd3MWxPMVBMdTg2alA3?=
 =?utf-8?B?aHQrOWtJZndxU2poRGRCM3pONFgrVm9hMjR6T054dWJzeEVLYzhlazhYclFO?=
 =?utf-8?B?b0c5RmhHMlZVS1pTT2ROQlNDdkw5QTRzNGl1bWZmcHQxeklKbHZYQVRDUHhM?=
 =?utf-8?B?UDdXRjl6aVRkYWdBS0hYNmtpUk5VeDB5d2V5NkRGNTM1NFcvNFpnRDl1MWhj?=
 =?utf-8?B?YmYwYTRqN3UzRFFNQVIzVE1aTkg3WE42bzFtVGt6ZkVObG1kREcyY1BlNDBP?=
 =?utf-8?Q?chPhGz24PZ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K01vSmFweG0wODJlSU5LSENNazNIRVpjNEozdkV3NFZBMlZvOFdUZ0RDVTdh?=
 =?utf-8?B?YUVQaExBN1RYRjQ0UFVlU2JIZ1U0TFVJbklZT0tDbmJIVTdrOGUydU9qTHFk?=
 =?utf-8?B?Z0wvaFRNcFlrSnpGWkdySXk3R3dPVGlNS3dlcC9GbENOTXhIcEJVT0hzc3hR?=
 =?utf-8?B?NTlGaEhFMjNzMDN1RG9DemkxZVZDaG80cUV3TWNWQ2FWck0yTkZiMVh0S29Q?=
 =?utf-8?B?RGlhSXFCWWJ4NUs5ZmNNOWdsNnJ3RFdSczNTek54QWl4bXNGRkRlVTYwdFls?=
 =?utf-8?B?SzYvNmRZM3c4a3FuSmxVL0RMVHNJbENBUDBobWNjb29GcC9xVHp0U0diWFFG?=
 =?utf-8?B?RnJUdGZrRVpieG1hOWh2ODNSaTlUZ2x3d3VreTJTZ1RNMGRHVzNpTDVmUHBL?=
 =?utf-8?B?Q3A1UW4yTzY2REF3UmVyVWhqVXFrT1FhRnllOE9NemxOY0Y0UkZrRUhIZndF?=
 =?utf-8?B?V1VqeWNLd1FwVTJqRWh4MVIzNHU0V1BpcTFRTWhaSHhVT1RQSzg3LzZyWnIx?=
 =?utf-8?B?U2pnSWNxY0pqczJVNTVPeFdmWm9uMFVVb0IrL2owR0s1ZjRLWk1tWVhLdG1t?=
 =?utf-8?B?SmhoZEZoc2E4QklHb004RVZWVWQ3VFVZWGtKbFduWWNoWUd2Yy9NY2NzdHoz?=
 =?utf-8?B?MEVaSmZHM21tbTJiaFBWOVh1U1F0M3pTU0lNc2lkNUxRT1FoRWk0VmpmanJK?=
 =?utf-8?B?TC82ellRc0NWZ05Fay9BTkJMdGhOVjZTVVB6eUkzQXdxQ1RqQnJrOFo0eFh2?=
 =?utf-8?B?d2t4KytUeWNpWUtGSXhtajdmY3BjaVkwTEVDNFBDamJTNzU5UWp5bUNDS3hZ?=
 =?utf-8?B?NHBQdHhGYlhmVUVSeFZQMk5XOGRiRkhWMVV0MnlaaUVvS0pab245SjBIVUdp?=
 =?utf-8?B?blpmNWw0MmNXTkMzcXNzTjBJazd0RlVab3BNdG5tNzRwWnBWRXZHZm0wd2lH?=
 =?utf-8?B?NHhsaGJNRUZ0dnN5cUFNNWo4NkhQejRxT3AzcklaUjhSd3UzV05oSEU4dkkw?=
 =?utf-8?B?aU5zbHVnNmJVem92UC83ZDVXMXo5MHJNU1U1ek1BSnNwWkNUb01DRkgwUnJv?=
 =?utf-8?B?Nm04Rktvbmp4cmxvSTJ3cEhTb1RJL0o5MTFySDhYaUpRQXorMHlpZ2c0M28z?=
 =?utf-8?B?U2hHVUlZRFprQW5VWGdBUUI5TnBDS3ZDakM4dTFxaGh3a3hMbXBUclkvNFNP?=
 =?utf-8?B?QUdEcm5EajU3RHVGQlpZVlBMRjB0cHpOZnZ1Um9QUU5sNjQxaW5iQnNvQTl6?=
 =?utf-8?B?VHpoNzNmQzZqSzVKUmhHRTd4QURFcWROdjlaUUkvVkRmbVdGbkdJcGlKdlBt?=
 =?utf-8?B?WXdFRGxrbStPc2pjcER0bzUxVTQ5aWhJTmJNWld1ZFlNSmVHd3RZQ2oxczZT?=
 =?utf-8?B?VzJZck9pY2lTT3VHSFk1emMzODRQR2hsdXoyWlY4NXMwSkNsSGtxT2tjTUd0?=
 =?utf-8?B?RjArd0pkTHV2SFVjYVpLRlB5WnR6eVFlelNQNjlMeXU1SUNZdm5NZjN0aTBG?=
 =?utf-8?B?a0t0UkhDVjhjcXlIQml4MGsxTVcyUU10ZVExakxKN0tscTQ2d0QvTkFESEVW?=
 =?utf-8?B?UkZobVltZS8yVkF2R3gwalkwS0pIVkNIQWFaSkdkUlQ4QU43VUk2RTBwUmc4?=
 =?utf-8?B?YXZ3bU1oeDlsbXF0R2l0SlJxRko2ODZvbzMydHVQcTRhTXBJRndLWmwzejVS?=
 =?utf-8?B?aENTNGdweWQ2cnlJUktRRXo4REdFbE8ySDZ3TnVOYlh2SDl2NE02UTg0MjBx?=
 =?utf-8?B?MGhVK3RPUnBmM2U2NWFpalNJeTdEZDNhaHFkVGxaOEJaV0pUQUZqUzM3UnlR?=
 =?utf-8?B?bUN4WW9UY1dpSVZRcFlBY2tEZldTbXA2WFlaMHdYRC83T00xN1BjZ0thbHRF?=
 =?utf-8?B?ZjhiakVyb0g1Y0twN1FKSFlwYUFTQmFHOC93NmFoa2tXc1FrbFBhMEhaMHo4?=
 =?utf-8?B?ME9JUTgyL1lqREdtWjJ5YlBzQ0VGbDE2UTYyYW5SNFViSWJUNzJKejZPNEVJ?=
 =?utf-8?B?eVc2NksyVjFvZmg1S1hLb3grclNiaGowOFI5RUlycHNsd0pucHVYUnpvVWNt?=
 =?utf-8?B?SlFVSXpGOXNSVGhQdkExZDdFZWNyWEx1RVJuSlVsRi9OU09TTlhGMFJWL3oy?=
 =?utf-8?Q?Axpw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9413c174-dbd7-4264-4dbc-08ddc1fdf040
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 11:10:56.0581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djU2JKeOFdCajVfCwAD0MueVSkisdJ5P70hgk+cJESZTNx71LiwN4HfH3dZFJl0O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513

On 11/07/2025 4:52, Jakub Kicinski wrote:
> Support setting RSS hashing key via ethtool Netlink.
> Use the Netlink policy to make sure user doesn't pass
> an empty key, "resetting" the key is not a thing.

Makes sense.

> +static int
> +rss_set_prep_hkey(struct net_device *dev, struct genl_info *info,
> +		  struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh,
> +		  bool *mod)
> +{
> +	struct nlattr **tb = info->attrs;
> +
> +	if (!tb[ETHTOOL_A_RSS_HKEY])
> +		return 0;
> +
> +	if (nla_len(tb[ETHTOOL_A_RSS_HKEY]) != data->hkey_size) {
> +		NL_SET_BAD_ATTR(info->extack, tb[ETHTOOL_A_RSS_HKEY]);
> +		return -EINVAL;
> +	}
> +
> +	rxfh->key_size = data->hkey_size;
> +	rxfh->key = kzalloc(data->hkey_size, GFP_KERNEL);
> +	if (!rxfh->key)
> +		return -ENOMEM;
> +
> +	nla_memcpy(rxfh->key, tb[ETHTOOL_A_RSS_HKEY], rxfh->key_size);
> +
> +	*mod |= memcmp(rxfh->key, data->hkey, data->hkey_size);

ethnl_update_binary()?

> +
> +	return 0;
> +}

