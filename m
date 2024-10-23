Return-Path: <netdev+bounces-138116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 385259AC04D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF2E285333
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898F6155391;
	Wed, 23 Oct 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wdMYAkeZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF753155359;
	Wed, 23 Oct 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668742; cv=fail; b=OEzwmvO5R41Fu4OAbr1AJzvELra+Wpiy/tAI50gLwtQpV97DB22iKPx0vdjsum4M21yrn/N7HirTrcn2FjWOYs6bjjxH+hmdK5dw3KnOkk27X0MEwt3C98qVJcXdZFqwg5zBzbt/B7g9Negi0lBiGTZqU7bCsusB8uNsmxK586Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668742; c=relaxed/simple;
	bh=ss6Bno/IJ52LVu7sRwQKMKO56qRoKTQH+GcFWdBlUwc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R0rArNuYtLaMhXqdpkrv9dJbKavLX7l6SYPL7tUtkVqsVZl5F4RxWDebaaJVWox1nnoAyXLvk5xPf4JtA+5NjlvG64PnvM+VPrF124TYmUSIDJtDDDFySQ/i8rgJU50fgPEhZlQCHDcfxaM9wjfJouz4Bnybajk+R6Mqr9kwy6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wdMYAkeZ; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PakeHZ9B4kRoGDWOPH1rEyBo4vqvUyu6ugVXdEa9x2z9VvJzH55tDMX+UdUHvt5/inAsu9HXv0nE0cv65BMAzD2PJdsguWUuBUkPEASX942TBuIr6G78G2ILp73ZUlySr0Rv38o8z+N5+1hbtp8AcUqI8vZlS3lp+TXa04Qtpn95X8TYGwqPGkg5oCC/YWOOHRM8YAabRbH7grmM+X/g8YGDHQK1KjqY9VQAprx4AEYYYjxWW9FVq4kan8KCcUbFJWqyj/MfeCR7XeF/wUNnj/out3Km5pVQD4p6I5HO18k4aNSfW+UPx1+X/8XlAS6I1F/fK9moxFX8Hsrap9Q29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN35MkpBzjq7wxXdvoEuSZTGleFTOglngtlyUK1Yq4I=;
 b=DbiALl+bAsaI/RIMhjtHtcfWTZHYDnxjRBy1mH4HYs71QCSrsproXT+PnwkbBbs6O9taDQUV9gqx0dElJMZe8acycjT0LXclK9CWAJhjNs7SVZDfKg2RuxHvSV7N8Ev9j4OZ6vC9mvmEbaRQsGvjioJjFmCIGmrh/s6vwRPgw2fVdAAW6Bh5xbaJSG0KK+VriTmjWfBb7ObqIWNVwNAaOO4w3QGF21xvA34tOPYpTSvmZJYwfeV8WA6nf9gKIMyEDy3Zok77egi7PZ4uK1GQlIveDfigrJPQt183c70kUI5cjxsS3uKSpLJ9n9Z3WtUgRr2ylxBvyNNXOLebZdVmuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN35MkpBzjq7wxXdvoEuSZTGleFTOglngtlyUK1Yq4I=;
 b=wdMYAkeZBb31V3uYlhqF9FXqnkLKp8Hh7TO5SHsBgB4pqFxAEl8fGLI85YhC0CdN32kWfHjsmv7+EVhwso4MtoAq8+b5zsVLg4RG/69ybSiQPCoH4jCuSQMq/V2Mwk+MoU3zpwY8VgIKgv1JCNy3LanO2Lcyfk/wzQLMT655WI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19; Wed, 23 Oct
 2024 07:32:18 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 07:32:16 +0000
Message-ID: <73040aee-7584-4d7e-a3c1-edc12a85f5e1@amd.com>
Date: Wed, 23 Oct 2024 13:02:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] amd-xgbe: use ethtool string helpers
Content-Language: en-US
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20241022233203.9670-1-rosenp@gmail.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20241022233203.9670-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::11) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 045ec45b-3985-42e4-0876-08dcf334d18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlNCV3dNRXNWamZuN3hvTWIvVmhrZE9Pcmw3RzQ4dE80WU9Edy8rRVlOaENZ?=
 =?utf-8?B?OGdJb092YXZGNjlkTG5mQmVyTEFzSkpsdkQyMkRuQk1lQ01PL2VwZWR4V3Nt?=
 =?utf-8?B?SnFKNWFNeXJPZjdmTkhNMG1WclEwQ2duaGRVcENOamJPRXpGbTFMcy90allq?=
 =?utf-8?B?YkRLRXNsb1g1U01CRWhlYWxtRmg5alcwNVFVL1kxbnpIUjREU1lMcWRaV09t?=
 =?utf-8?B?Wmd5cnpmcytqRHRURGh0NEtQeS9FeWc3UExpNTE2amxlVWY4TmI1MGJKVXZ0?=
 =?utf-8?B?NG5oNGhVaFNSbWxDQ1lDNlB4VkgraVBwaU14MHhwSnUreEtXclF0UXdHNkpC?=
 =?utf-8?B?eUJjMk9ZUVVwRjN1R1MyZ1Z3MUVueXBQbWpYRXZ6MThYSVo5N25SM3hSdUJO?=
 =?utf-8?B?emN1OVU5QXAyRTRqRitkdEgrbTBPVzBvbkNhYjcrVkcvRmxyTHA2SitpZDUv?=
 =?utf-8?B?UDFJQVNhWExKc2NlL00vREwvZXF0NWRHandWT0owMWQ1eThHdmVuYnEyckw1?=
 =?utf-8?B?REg4eTFRQnl4d01IcmxFZG01R0FPT3phcXRTaU05MENmTWxxNmZDSDVPY3c2?=
 =?utf-8?B?S0VyN3JuL0JxQVhtM1F3TXo3VGVuQUtKL0o0SDVoRkJLK1pDWENQb3dUanZi?=
 =?utf-8?B?YTl1Y1dYWWJsWGlKbmMzMGI4YVpQUlBydlEwdVZsbk9JMm9CNVU2REN0TGpM?=
 =?utf-8?B?aUhzaDZxK2diVG5HcmFsVVg1YVI3Z2NBV053NDFTS3FlWlYxL2RYS09oZFM2?=
 =?utf-8?B?NzJhUlppbS84UG1qejBNTjYwUGF1L1dtMHc0d2JlMk1WUVJGaW9JU1Y2YXpW?=
 =?utf-8?B?ZUE5MEVHUVB0V3dJZnA4RkhvU0hUNFFUcHAwb2ZsSXRnTU5OVWxCaTFIV3Np?=
 =?utf-8?B?L05IVXI4bXhCaytpaGtrZmd5WS9KVkhFaWpIV25xV2lVS1JpeXhuS0wrTGhn?=
 =?utf-8?B?QSsxQWJYd3VFUkRIcmJZRVdnck95Qis4Y3ZzeVgrVktuQTFoU1lQWHB2ek04?=
 =?utf-8?B?cjZTQkpJZS85dE04WUMrdU1RQUZzOUNxMEdmaVVlc1IvdkRqaWRlVVp1L3Bz?=
 =?utf-8?B?QWRUZXJkcDlrKzg2ZmMrYWkrRzE3ZmFPcFEvOVRFWHVaOWxoRFJ6WDE3N2I2?=
 =?utf-8?B?eTBoQy8wNVZEc2xUWisyOEQyQWZhMlUydkNCdis5QWVzVEpUNVk3V2pVcFV4?=
 =?utf-8?B?Ykx3NDI0VVh5bktlMGxtSjdqam94TXZySy9XYkV4c3VLZFV4NEZJSjRBK1Ez?=
 =?utf-8?B?Q1hTOFYzZ2pnR2gvS1NyNVV3bU41NnFFdSsySElQdHo0OVlENHRtaVh0dFhX?=
 =?utf-8?B?Ykxsb3pzNEg1MnFQNUlXcm1JdXRpbU5wOVNKSVlsY1Z0Zktvb2ovTTRlVEYw?=
 =?utf-8?B?cmVqTHQrUVIySzdwbmR5dkRpRk4vZ1QvZzAzMURnT0pTY1kxeS9GOG8zK2JL?=
 =?utf-8?B?WnBXTWZEd0hiUXRuVjlQU0JrZ0FIMHE0eC9GeHAvL3plV056UjlqMm9NTkhK?=
 =?utf-8?B?QUM5c3hKK2g2MTFNT3Q2aVdFbzZjVzU0Z1hNcEZIdk5hODJNUjhmM2ZMYzA3?=
 =?utf-8?B?UDhPZWYzaWZXK2JoaFNWRVFzemFMS1E0cEdJTjFoYzdnQ2RlMGRrckticms4?=
 =?utf-8?B?NUpiVzVSaDF4YW1OVE1xUFM4WmZub2tKMjFvQSttZUMvcUVudE1IQlE5eGti?=
 =?utf-8?B?SElsbDEvV2tUTE12SzNTVUxUekllaGdSa0xBVkVueklQWUQrVmpGODVtNXUv?=
 =?utf-8?Q?2ZHcsLuUH8bjyTM346jxe9+5tPSFJYJcxzPQbAz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHE5Z3F1bTltTVhUaVFSRHdwOE1wMVBiWVVpcE5KbkpIWVhVazY4YVZCNnp2?=
 =?utf-8?B?VTFOLytTYy9SWFk0Z0JEbUVxcDdZMjJseVFwT1RUVzIzU2NKWVB3KzkxcURk?=
 =?utf-8?B?dUM3KzNLSS84UmpZR0tJU2xjTE5UQktLaGl5cmJKMXBRc3JCUGVmWHhFbzQ3?=
 =?utf-8?B?djlIZkJlKzlUaW91QWJadXZnaFhiYjNjMHczdyttVVhFUkJFOWg1dlpPQzY3?=
 =?utf-8?B?NVlEdTc1YTZzd201Q2JhekdWYmhmVDVyUXBsQkR2VG8yWnNDNy9xOG00OTlm?=
 =?utf-8?B?cmdoOE5YMVZpRDkwT0dDYjZBM3VwNzJrKzdMa3JZVHdFL29WSWE5aWd0VFlo?=
 =?utf-8?B?Z2lndlUxRjdiU05kOUt6M0xJdExBQ0xUVEFVSlA0UThjZ0ZKcE54WFVvU28z?=
 =?utf-8?B?SWRxUldEMGVQVVNmY1doRkV6ZDFMNG5palZkRDE4c0pUaFVJTWhac0JMV3Ax?=
 =?utf-8?B?SjlXK3psUGhaWjBSYVgrdWFQL1RhRkYyY2hFbHVuM1VPUml1cHgvY3ZYclI0?=
 =?utf-8?B?dTNIdWc1cVZoTzVqTTYwLzBaRm44TVZzWmZEMGlhZE5VS1YxL0hQak5zakRt?=
 =?utf-8?B?ZjFmVFZUZzlXUUdzMUE2SG13LzV5WW5rT1Y2aWZIbFU0eWpTV1Rnd0Z0c2hO?=
 =?utf-8?B?R2JtcmZGRnFEcWM0OGtXVUV3UkZpRkJLeFFucWpFaTBydi9JcjlUNFY0b0Yv?=
 =?utf-8?B?NSsvU3Z1UjlPeVBORVZtKytEb0xCY2FqR3JQOHVWVitaSnBrRTlHdTgveFZp?=
 =?utf-8?B?WTQrWU9NK2lobWk2aisyWTcrSlRQRFE3VC84QmJYOVoreFZhOTZNRjd0Wkh0?=
 =?utf-8?B?cGRQMkJVMEtSMXNiR3BNaEtoM05lUVQyK04rVDlmR1ZGZkQ2RVlTalJlZWF4?=
 =?utf-8?B?MUtUYTQ3bkd1c1QwekJDcjMwaE5NVkpBVEI4OU5BekdEYlg5YzNrUFNublla?=
 =?utf-8?B?SmIwYUc4NDlEcWlSUnVKMExaWFlXbmt0ZC9PanJNV1V1VzFadmgvVUVmQUhx?=
 =?utf-8?B?cDhuWVYvODNoVzBVVGRHK1BRczRvRHhhLzVacDZjYmJvelQ0V205TUkwbUhS?=
 =?utf-8?B?K2M0aGh5TGZ5Y092L3VlV1V3eTRFN1FZZEJHSndGSU8vSjN1UTF4U0M4WFo3?=
 =?utf-8?B?NXpvamxrdFpMYmJoWlhJaGZWc2FGL0JkSXpkZVZYWTYvUm9ON1RJcjFPa1Jv?=
 =?utf-8?B?ckVZQ0lTUThFNXkrVkhpY0RSSHEyRWcza1hSWU04NTlGMWdXZkdER29ENW1T?=
 =?utf-8?B?TS93VnprcURnRkVTQkljc3p1ZlF4RmdDdVY2NUtUdlFHZWp1OFdTTVhzOGgy?=
 =?utf-8?B?ejkzN29INUN2eG5nQkFPbE9nckNNTjZya0J4U1Z4T1ovWFJoNkpCL3BzdFp2?=
 =?utf-8?B?ZHVwNFh5K25WZnlrdi9tVjhFUEJNdXlweHJxaGFXVVhpbXk0Q1ovbXFFMDlM?=
 =?utf-8?B?VlVXNWRZSlh3OG93UHBhNmpROWp3RmxMdlU4YlBTbTNmUTBxQkt3TEF4dlpM?=
 =?utf-8?B?cVFkOC8vTWNGaUZWbXhwM3czVEo1S0FGa1NWTG1ycEVSRkpuaXBQL2NWYm9v?=
 =?utf-8?B?eU5WekpKTWVhcFViYjNIcm04UmthcVpiWVkweHBtZGc1aVNDdGwwKzZscVNw?=
 =?utf-8?B?TGtRSHE1em11Z2M5dmlaTkEwZVhyUUVxTU45MmxZdnFFb200bXFmdEx4aStK?=
 =?utf-8?B?ZlB2cDduODJlTUxVNDZUV2wzUGZJakd6bmFDTkthZkczcXEwbW5SQ3BvWEdH?=
 =?utf-8?B?TmdyeXZ3d2ZPQkZmWTNuREM4d3pCQWhxUzQyRXhiRWJZK0JNcmpmSTBmWHhR?=
 =?utf-8?B?cUNVT0s4QTd0cCtrcDVvZUQxTkhmQjhBVnU0bnhOMGJpYzR2Y3dVbXlSNHh5?=
 =?utf-8?B?SnhIbnE3Rkp5bWZ1QVpqQzN5Mk1KRVBkZGlMeGxJdnRPMy85YXlGdHJEdlVy?=
 =?utf-8?B?bG9VV1Y0UHdOZFFtTFBSM0Q5SGw1UWp2SVBZWWxibTBXNEh0aWtHNlpaS3pP?=
 =?utf-8?B?dHBBNGhhc2Y1b1JKenhLcjIwaHBaWTNKMGlvZmIxeTNQQUlSeWJLd2Z4ZjZl?=
 =?utf-8?B?NVpYbEV0NVd5aVNyWVlNYS9qcTRnSVRKN2dvKzFqMDlDM0RXNTFsYkk5RzY5?=
 =?utf-8?Q?a/zygIIlA7p8/FpTRIGzbJ/ux?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045ec45b-3985-42e4-0876-08dcf334d18b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 07:32:16.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hn/mlm49oQ4CXbT5VN4+JaaKE19wI4tGtKNWeJQYKdjdXyEQSCHd32aDhD85uApvjZCSW9K0JJJ/fSQgwJ0kRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977



On 10/23/2024 05:02, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Looks good to me.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Thanks,
Shyam

> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 22 ++++++++------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> index 5fc94c2f638e..4431ab1c18b3 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> @@ -195,23 +195,19 @@ static void xgbe_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>  
>  	switch (stringset) {
>  	case ETH_SS_STATS:
> -		for (i = 0; i < XGBE_STATS_COUNT; i++) {
> -			memcpy(data, xgbe_gstring_stats[i].stat_string,
> -			       ETH_GSTRING_LEN);
> -			data += ETH_GSTRING_LEN;
> -		}
> +		for (i = 0; i < XGBE_STATS_COUNT; i++)
> +			ethtool_puts(&data, xgbe_gstring_stats[i].stat_string);
> +
>  		for (i = 0; i < pdata->tx_ring_count; i++) {
> -			sprintf(data, "txq_%u_packets", i);
> -			data += ETH_GSTRING_LEN;
> -			sprintf(data, "txq_%u_bytes", i);
> -			data += ETH_GSTRING_LEN;
> +			ethtool_sprintf(&data, "txq_%u_packets", i);
> +			ethtool_sprintf(&data, "txq_%u_bytes", i);
>  		}
> +
>  		for (i = 0; i < pdata->rx_ring_count; i++) {
> -			sprintf(data, "rxq_%u_packets", i);
> -			data += ETH_GSTRING_LEN;
> -			sprintf(data, "rxq_%u_bytes", i);
> -			data += ETH_GSTRING_LEN;
> +			ethtool_sprintf(&data, "rxq_%u_packets", i);
> +			ethtool_sprintf(&data, "rxq_%u_bytes", i);
>  		}
> +
>  		break;
>  	}
>  }

