Return-Path: <netdev+bounces-273849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMOBLqmCzGkFTgYAu9opvQ
	(envelope-from <netdev+bounces-273849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:27:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F39373D83
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 663793019E37
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7198F318B85;
	Wed,  1 Apr 2026 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bBilbsEL"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4091632E7;
	Wed,  1 Apr 2026 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010468; cv=fail; b=rGMaXUmmG20QC2wW4bhPdknIarc4qS6/GP4Cjspthk4OiGc+3jCPca/lrwuf+QBiYC7oz7ArhuNsnYZ/VymyzTTs8dJi4KpQLlVgs6aSzL/yhqPdEjsg+MB6NexBJjrl/srGI44fTZ06i7ii7HhFm+9goTGdz0o0f0Z2po49918=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010468; c=relaxed/simple;
	bh=pntJOPeEpE/kWSxe+8hOwS4MLBM3LKIr2PZ3c6Ci0ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RetYOpn5pVb3I4MMdLUxKxx2D9le2MHjIIom1uYERfZAzzverMzWCemxpyMosDgg0FG8OVTIcAduTRmgw8GVdncrWYH4RYZdGNmHX5IVOJNIc6CIc7PGelrnJ1ytZQm/iY49agx7vX+vAANlS+5SjpeHmRdLnfKH6nveYkVQZog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bBilbsEL; arc=fail smtp.client-ip=52.101.53.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j05fEy0w0JrlYEynux80UE4msZG8/rp4RfahYRuVu55+v53Y34Qzv84G4A1ao2sjUl3oIRHSgiLGfdM4GLHvNqh04TKmTMVQZIEdte1chprbpVFC0dnwlMv7xQkl4fEbpuFCzllOneK0QVSPJIPftuzC5zOxAZC2zkQczgGZSE/sgR/ZXyhOvRcXmC/lfKCtt+YG2aVClWE1ZlkU7g1LsOSQkJ9ZhpJ6YzDlgyzkRDzU/16KGLgDEHN/8oL3Zu+b/6BzcA+jfSJHdWP3/E7mw0MobJQ//Yaw/7YdD0u5+z68c9xX30rVLOy68hKSR70LWSBYDoLgxoV5DlgsMeqQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v+Dr/GyVgs/U6BCPqXyzLmWyUSfUKc+I1QOr1dl7yE=;
 b=cA43+6zCus8c+g5ARoOGT/OtlzC/o6GE7QMXDozV98i14S0QBmxp4rDCoD/cwbHGl081TcLBD68cfJNjkJSFBEHB4aZKH8Ei2OcX1s98T4NFm/+128GCJwTxR3jIbTE1YIMcEtctoEquT8MT8HWg6mTBkTAUusP3s+eNO4LL2ohShHK7pt59FdzyM9WpRiFwl6PgSjHURqgbOiKsvKT9KaTYhABFSWcl4h16WDn88j1rNEcqfK46uLtgLCd1SNCTwFPfy2siZ08+dpiqCjPF09QWWXmMhv8RfGXUGqhfmFt7F0/izCfO3uWLdO2TFQzmmEwtJFxtKjmMzn9kD8dp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v+Dr/GyVgs/U6BCPqXyzLmWyUSfUKc+I1QOr1dl7yE=;
 b=bBilbsELbsbcTKA0jBu8vQuFCxokb5eKKPmYc9DwpLJ94h2afrTR0KYj85SqcDW9tuXR6+ToV027+y2JJxRY0eWZfFMKWxj5yvQLiOF262HaUd1HLQFoKAq/Y2HGA0cFTMk3FIthWXP11fetPwW706irDmAhk0lkgzX1O+1g5rEJkyKoCupAYwJGGDgr+3Mu//yuWLrG671aM/WvLRTfUG6BlSbqyK/yVb06djUUshNqGmXlzMMtJm1qUHoxauQYlLjKi0qhPvX9TmrxZI7OcQRr5AqD+VHh7IrMKWjsvo7oo1sCnYPBoJKhOYtPfC6d3EA94c9kzIj+hTBicmzgEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 02:27:38 +0000
Received: from CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9]) by CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9%4]) with mapi id 15.20.9769.011; Wed, 1 Apr 2026
 02:27:38 +0000
Date: Tue, 31 Mar 2026 22:27:36 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 06/10] net: dsa: realtek: rtl8365mb: add VLAN
 support
Message-ID: <acyCmHh1IAykwycy@yury>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com>
X-ClientProxiedBy: BN9P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::18) To CY8PR12MB7171.namprd12.prod.outlook.com
 (2603:10b6:930:5c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7171:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d11e20-b0a0-484e-c402-08de8f963dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FdmG8xjfN+r2TrmAXELbxgffQzckbVypV4YgzwGIz0S4ilOW3KgSdUg8vuog3PNvGHaFQzXhoeoWL+cEJZ9OjVNvAuOpdwX7PX9c+tBL7sEcouEBViuDLGEFIA98qIhWm214vtmlg53o9pnEUdd15mMfXA/oKp6042f/7QIk1oY/nVL5h+vHP5vGgP2758Y8FEbBpGvRVzk8iiHyrmHQ9EaHPATtgSUz8xL1ebt4tWAgNMMuaOL6nvUZAKDhHXqlfxvqQZ0lmBUWOP2UfFgcOQAVA2t1qxDe3729F3AUmFk3E0c4WFfq4Zl6GOrw02/7j5xqhf2A3c1phf7O9FGjvDO4AQ/Me8EbRoJVCiLn2PLfqyOSgt5qS67ZRZLfl0inBGSAEGbHK+P/aupfdeRCebYDzS/Ej9hNOtftD2+bw+E/N3eEmFGgRRjCpzm5bI+7MGUZKy7dsAC4aOnXSoQUsTWrgKRtH+bQiY0uyHkmbogjhPYGUCU7ZJ5z7TfWUsoJT1WvMFQ9HwcufXAO+PWW7DrMawRn9xxBTf3ykdgIp7f49C+s2iuf2LefV220JkIy1om/DfxKtffSgvR1i+uFU/5pr88c4O+x0APb0ZGiMIv2gveWLUKXLLRs6VlNCllN4CQIDEJzPPMZFd1epJTpk9VBxKOfoq2bU/mEIl6uhKpoM/KtV/zHRSzibuwErSs58nO6nDZOb29pLiSrD+7XkIuzxbCCQX+v1vBHjXfxtqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHdNN05Jclg5WnpnWU5PSll4eWpmejdQeVcyMzN6dFdDcWN6a2UvTExNTVJW?=
 =?utf-8?B?NjhYRytPRE5ONkRseEl5V0FEMUowT0svMWFaR3NBYW9jOEQyR1BnbjR2bUhY?=
 =?utf-8?B?bUVtWlhMVzN0b2hBeVFsRzlxeWF3a0hBK1pwY01VdmhFbGVnQWVGZ2dIc2ox?=
 =?utf-8?B?MXBDVVhVa0R3SmhKSDFxMVJLTVBhQW96UzE0bWJvWjhnRlgrUnlNc0VhY29S?=
 =?utf-8?B?Y3ZnaHYxK1FrMUJ2RWhkbGhqakxTSDRNVkRYZWsrL1ZUL1pJaVZ6bHdkbXVj?=
 =?utf-8?B?RmdrZy9mWmRZcU5jY3FZRVZTa0pBci96dUZQaktQV0JZNnI0dzROd2lZTEJj?=
 =?utf-8?B?UXNON2c1dzlPcVN4V3RWOUloVFRhNzQzY0V0QnhtQ2IyblZGNFBnMXZWcmFW?=
 =?utf-8?B?T1Flc005Wjk3Vi9IS3gxOWxwL0dIM3pJS3NHdmJsK1RrS05hVWZTOTlCWW9a?=
 =?utf-8?B?Um5GT0hWVm1mWWh4TWNNdTdDeGdFQXJ2NE80VW9oNkhqOXZEbGNzUWp6bHRO?=
 =?utf-8?B?R3FuNEsxd0JlMitxeXc1aFBEZHdZMU1HNmNWUnlzTXcwNnRpUmJYalFxYkww?=
 =?utf-8?B?WnU5MXlTQW1xc1FlajJ0bmJucDVuWWhNKyswMW45R2E3bG1NSDJzL25Fdm96?=
 =?utf-8?B?TENnanhlblpDTHFpbEwyT2RLTVhwNzRvSmd4MTFLaUFoMGo3NkZJV3EyVWtu?=
 =?utf-8?B?MEM2NTQ5WXZIejhML3VJcHZ5RWhCVk1TeVFpQU5XSXMzeFZ4a0FwYVErNE1k?=
 =?utf-8?B?ZGJ4ajloM1d6by85dTJjczRZcC9UUkorak1ydzl2SlUwdWhJVDM0dGJvYXVN?=
 =?utf-8?B?czVEeXJPajdHbzVoMU80MGpZd2pkY3BnYk93aVYwRGlwK0NRcnRNUjNFTHR6?=
 =?utf-8?B?SmoxOW5wdlo0aThqSWZ0Z1phWEh4NmNSeXhWaDF3b3FiejhLUlRUaWw3SkxN?=
 =?utf-8?B?NExubU5aRHJnV3dVUmtEV3VZWlFjekVwUXVWZzhMTUlEdEZlYlZLTmxKSzlL?=
 =?utf-8?B?bUFzR1loQ0VmK0pWSzVHUU9ybG9KLzIrQ1F1V2FHcHpmVUEvNVQ2RWlUeUo4?=
 =?utf-8?B?Nk5NaitDQ1J5WU5Ra0ZoQ3FsMDMycmJoeXdGcnR2YWFadXhCd1IwVUxyUjhw?=
 =?utf-8?B?Uko4dVNJN2VieDVoTGRzOGZVNHJiaEtZQ2FqMWhaeHhzWnUzYWNONlFFR0Fk?=
 =?utf-8?B?Q1F6T2NwSVR5V25GZStJNElCWWtyWnhFM3dYREZJbWo4ckFWZHpGb3YwU2JX?=
 =?utf-8?B?eDhiMHNrSjNtbzFjSXpxTW96RVpMUXU4eFE1aVBTSU5HSTZ1Rm5HeEQwVXB5?=
 =?utf-8?B?eXZ0dit4V01JK01tUjUySXF3RTZSanhmUlA5Z3ZpdEU0WDBoNCt3ZnhtSHJP?=
 =?utf-8?B?YW40NGs0UzViaG02d2VyQStpUmF5Vm16akRVcnIvbE5KN1E0dzBjWjVzOVR0?=
 =?utf-8?B?bE40bmZQT3JRNHVFcENSZnNmRCszdCsraGVsOFhBcHFEVjdjZmt0UG1xRkxv?=
 =?utf-8?B?NUJndlYzbW5EWlJHZStQamExUlpvM1FBdkV3NGU3VXlPUW13ME45V0xobXNU?=
 =?utf-8?B?MVJ0MDJZOVlJWWFaMWRGRW9FZlk1UnQrUDM0QVpKU1kxNXJQblVmNXVZeEhl?=
 =?utf-8?B?a0FTZ1JaZHluQjdwbm5wZW8vTWxGY1NVdjRXZWNHa3pGTktLbEtsbG1yMHpD?=
 =?utf-8?B?ako0dmtGb2NkU1lOS3BocUFxUks5M3haR1kyNkFxeHpGWC9Tc0JMVjhJbnBy?=
 =?utf-8?B?VDEzSFQrVkJhTTlNNUVIY0Vpb2U0Z1dlbC8ycUo1SGdqSkdvQ0Q3K1Bjc0lK?=
 =?utf-8?B?eno0NzFwT2ZPalViMkdyak9XeWZ4QnVEUnRFeTc1cUE1SWtUOExiWWRSUTNZ?=
 =?utf-8?B?bE9LSk5uQVZscm9MOUVUaURCS0Q5OXdGTGc4NkdvVDVrYUh4NzQwRkh2ckhZ?=
 =?utf-8?B?aXZqSStQTEVwNWpxMUJqWlJTS3NqTjBjdm5uZlFTQldDeDhydVNEU1VJR1M1?=
 =?utf-8?B?YWdML3pQblhDZ2J6MGVmWlMzdlpadVdxbmRtZnd0b1J2LytaMHBnejVHK0xa?=
 =?utf-8?B?U1g0aHlZaVRQQUVEdDN2MExZQitFbDc4b1lJWituR2g4SzdxdnprQ3NEdE5O?=
 =?utf-8?B?Y05FemxsOGNFMWdLTWE2US9oanBQUDd1QndyU2w4K1RBVUNJZk5Mb2ZHRDlx?=
 =?utf-8?B?T1Y5R3BGUkQ1RDV5YmlTVEF0ZVhLRDBYV3BoNGhNVWxvZGxCbXo5aEMyY3B3?=
 =?utf-8?B?N2xTY1Q2QWxBNzhzK05hZllkOGNCa1JDNnFhNzNtZlZJQnN4c2R1c1hHY0VW?=
 =?utf-8?B?TGEzcFF1UUYvWmoxRUhqcmJaUTJzMzlPeEphRVhybTBxdys0K2tMMVVtemFY?=
 =?utf-8?Q?xtrLiYxFJoIn1JOdrs571whOrV7ThKk9c6Ob4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d11e20-b0a0-484e-c402-08de8f963dc9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 02:27:38.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97GZicEPsGA24+mTg5kxPIAkV5GRGUFkrJIy5/XAJpknwnh2oQlwqkWXkv3pIUypjpf2LyrNLT0io/KiqZVWQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273849-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,armlinux.org.uk:email,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: A1F39373D83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 08:00:06PM -0300, Luiz Angelo Daros de Luca wrote:
> Walleij <linusw@kernel.org>, 
>  =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
>  Yury Norov <yury.norov@gmail.com>, 
>  Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
>  Russell King <linux@armlinux.org.uk>
> Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
>  Luiz Angelo Daros de Luca <luizluca@gmail.com>
> X-Mailer: b4 0.15.1
> Status: O
> Content-Length: 40249
> Lines: 1202
> 
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> Realtek RTL8365MB switches (a.k.a. RTL8367C family) use two different
> structures for VLANs:
> 
> - VLAN4K: A full table with 4096 entries defining port membership and
>   tagging.
> - VLANMC: A smaller table with 32 entries used primarily for PVID
>   assignment.
> 
> In this hardware, a port's PVID must point to an index in the VLANMC
> table rather than a VID directly. Since the VLANMC table is limited to
> 32 entries, the driver implements a dynamic allocation scheme to
> maximize resource usage:
> 
> - VLAN4K is treated by the driver as the source of truth for membership.
> - A VLANMC entry is only allocated when a port is configured to use a
>   specific VID as its PVID.
> - VLANMC entries are deleted when no longer needed as a PVID by any port.
> 
> Although VLANMC has a members field, the switch only checks membership
> in the VLAN4K table. However, when a corresponding VLAN entry also exists
> in VLANMC, this driver keeps both membership configurations in sync.
> 
> VLANMC index 0, although a valid entry, is reserved in this driver as a
> neutral PVID value for ports not using a specific PVID.
> 
> In the subsequent RTL8367D switch family, VLANMC table was
> removed and PVID assignment was delegated to a dedicated set of
> registers.
> 
> All ports start isolated, forwarding exclusively to CPU ports, and
> with VLAN transparent, ignoring VLAN membership. Once a member in a
> bridge, the port isolation is expanded to include the bridge members.
> When that bridge enables VLAN filtering, the VLAN transparent feature is
> disabled, letting the switch filter based on VLAN setup.
> 
> Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>  drivers/net/dsa/realtek/Makefile         |   1 +
>  drivers/net/dsa/realtek/rtl8365mb_main.c | 256 ++++++++++
>  drivers/net/dsa/realtek/rtl8365mb_vlan.c | 805 +++++++++++++++++++++++++++++++
>  drivers/net/dsa/realtek/rtl8365mb_vlan.h |  30 ++
>  4 files changed, 1092 insertions(+)
> 
> diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
> index 99654c4c5a3d..b7fc4e852fd8 100644
> --- a/drivers/net/dsa/realtek/Makefile
> +++ b/drivers/net/dsa/realtek/Makefile
> @@ -18,3 +18,4 @@ endif
>  obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
>  rtl8365mb-objs := rtl8365mb_main.o \
>  		  rtl8365mb_table.o \
> +		  rtl8365mb_vlan.o \
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 530ff5503543..c604bd744d38 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -104,6 +104,7 @@
>  #include "realtek-smi.h"
>  #include "realtek-mdio.h"
>  #include "rtl83xx.h"
> +#include "rtl8365mb_vlan.h"
>  
>  /* Family-specific data and limits */
>  #define RTL8365MB_PHYADDRMAX		7
> @@ -292,6 +293,67 @@
>  #define   RTL8365MB_MSTI_CTRL_PORT_STATE_MASK(_physport) \
>  		(0x3 << RTL8365MB_MSTI_CTRL_PORT_STATE_OFFSET((_physport)))
>  
> +/* Miscellaneous port configuration register, incl. VLAN egress mode */
> +#define RTL8365MB_PORT_MISC_CFG_REG_BASE			0x000E
> +#define RTL8365MB_PORT_MISC_CFG_REG(_p) \
> +		(RTL8365MB_PORT_MISC_CFG_REG_BASE + ((_p) << 5))
> +#define   RTL8365MB_PORT_MISC_CFG_SMALL_TAG_IPG_MASK		0x8000
> +#define   RTL8365MB_PORT_MISC_CFG_TX_ITFSP_MODE_MASK		0x4000
> +#define   RTL8365MB_PORT_MISC_CFG_FLOWCTRL_INDEP_MASK		0x2000
> +#define   RTL8365MB_PORT_MISC_CFG_DOT1Q_REMARK_ENABLE_MASK	0x1000
> +#define   RTL8365MB_PORT_MISC_CFG_INGRESSBW_FLOWCTRL_MASK	0x0800
> +#define   RTL8365MB_PORT_MISC_CFG_INGRESSBW_IFG_MASK		0x0400
> +#define   RTL8365MB_PORT_MISC_CFG_RX_SPC_MASK			0x0200
> +#define   RTL8365MB_PORT_MISC_CFG_CRC_SKIP_MASK			0x0100
> +#define   RTL8365MB_PORT_MISC_CFG_PKTGEN_TX_FIRST_MASK		0x0080
> +#define   RTL8365MB_PORT_MISC_CFG_MAC_LOOPBACK_MASK		0x0040
> +/* See &rtl8365mb_vlan_egress_mode */
> +#define   RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK		0x0030
> +#define   RTL8365MB_PORT_MISC_CFG_CONGESTION_SUSTAIN_TIME_MASK	0x000F
> +
> +/**
> + * enum rtl8365mb_vlan_egress_mode - port VLAN engress mode
> + * @RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL: follow untag mask in VLAN4k table entry
> + * @RTL8365MB_VLAN_EGRESS_MODE_KEEP: the VLAN tag format of egressed packets
> + * will remain the same as their ingressed format, but the priority and VID
> + * fields may be altered
> + * @RTL8365MB_VLAN_EGRESS_MODE_PRI_TAG: always egress with priority tag
> + * @RTL8365MB_VLAN_EGRESS_MODE_REAL_KEEP: the VLAN tag format of egressed
> + * packets will remain the same as their ingressed format, and neither the
> + * priority nor VID fields can be altered
> + */
> +enum rtl8365mb_vlan_egress_mode {
> +	RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL = 0,
> +	RTL8365MB_VLAN_EGRESS_MODE_KEEP = 1,
> +	RTL8365MB_VLAN_EGRESS_MODE_PRI_TAG = 2,
> +	RTL8365MB_VLAN_EGRESS_MODE_REAL_KEEP = 3,
> +};
> +
> +/* VLAN control register */
> +#define RTL8365MB_VLAN_CTRL_REG			0x07A8
> +#define   RTL8365MB_VLAN_CTRL_EN_MASK		0x0001
> +
> +/* VLAN ingress filter register */
> +#define RTL8365MB_VLAN_INGRESS_REG				0x07A9
> +#define   RTL8365MB_VLAN_INGRESS_MASK				GENMASK(10, 0)
> +#define   RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_OFFSET(_p)	(_p)
> +#define   RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_MASK(_p)	BIT(_p)
> +
> +/* VLAN "transparent" setting registers */
> +#define RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG_BASE	0x09D0
> +#define RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG(_p) \
> +		(RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG_BASE + (_p))
> +
> +/* Frame type filtering registers */
> +#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_BASE	0x07aa
> +#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_REG(port) \
> +		(RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_BASE + ((port) >> 3))
> +/* required as FIELD_PREP cannot use non-constant masks */
> +#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_MASK(port) \
> +		(0x3 << RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_OFFSET(port))
> +#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_OFFSET(port) \
> +		(((port) & 0x7) << 1)
> +
>  /* MIB counter value registers */
>  #define RTL8365MB_MIB_COUNTER_BASE	0x1000
>  #define RTL8365MB_MIB_COUNTER_REG(_x)	(RTL8365MB_MIB_COUNTER_BASE + (_x))
> @@ -1196,6 +1258,183 @@ static void rtl8365mb_port_stp_state_set(struct dsa_switch *ds, int port,
>  			   val << RTL8365MB_MSTI_CTRL_PORT_STATE_OFFSET(port));
>  }
>  
> +static int rtl8365mb_port_set_transparent(struct realtek_priv *priv,
> +					  int igr_port, int egr_port,
> +					  bool enable)
> +{
> +	dev_dbg(priv->dev, "%s transparent VLAN from %d to %d\n",
> +		enable ? "Enable" : "Disable", igr_port, egr_port);
> +
> +	/* "Transparent" between the two ports means that packets forwarded by
> +	 * igr_port and egressed on egr_port will not be filtered by the usual
> +	 * VLAN membership settings.
> +	 */
> +	return regmap_update_bits(priv->map,
> +			RTL8365MB_VLAN_EGRESS_TRANSPARENT_REG(egr_port),
> +			BIT(igr_port), enable ? BIT(igr_port) : 0);
> +}
> +
> +static int rtl8365mb_port_set_ingress_filtering(struct realtek_priv *priv,
> +						int port, bool enable)
> +{
> +	/* Ingress filtering enabled: Discard VLAN-tagged frames if the port is
> +	 * not a member of the VLAN with which the packet is associated.
> +	 * Untagged packets will also be discarded unless the port has a PVID
> +	 * programmed. Priority-tagged frames are treated as untagged frames.
> +	 *
> +	 * Ingress filtering disabled: Accept all tagged and untagged frames.
> +	 */
> +	return regmap_update_bits(priv->map, RTL8365MB_VLAN_INGRESS_REG,
> +			RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_MASK(port),
> +			enable ?
> +			RTL8365MB_VLAN_INGRESS_FILTER_PORT_EN_MASK(port) :
> +			0);
> +}
> +
> +static int rtl8365mb_port_vlan_filtering(struct dsa_switch *ds, int port,
> +					 bool vlan_filtering,
> +					 struct netlink_ext_ack *extack)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +	struct dsa_port *dp;
> +	int ret;
> +
> +	dev_dbg(priv->dev, "port %d: %s VLAN filtering\n", port,
> +		vlan_filtering ? "enable" : "disable");
> +
> +	/* (En|dis)able incoming packets filter, i.e. ignore VLAN membership */
> +	dsa_switch_for_each_available_port(dp, ds) {
> +		/* after considering port isolation, if not filtering
> +		 * allow forwarding from port to dp->index ignoring
> +		 * VLAN membership.
> +		 */
> +		ret = rtl8365mb_port_set_transparent(priv, port, dp->index,
> +						     !vlan_filtering);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* If the port is not in the member set, the frame will be dropped */
> +	return rtl8365mb_port_set_ingress_filtering(priv, port,
> +						    vlan_filtering);
> +}
> +
> +static int rtl8365mb_port_vlan_add(struct dsa_switch *ds, int port,
> +				   const struct switchdev_obj_port_vlan *vlan,
> +				   struct netlink_ext_ack *extack)
> +{
> +	bool untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
> +	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
> +	struct realtek_priv *priv = ds->priv;
> +	int ret;
> +
> +	dev_dbg(priv->dev, "add VLAN %d on port %d, %s, %s\n",
> +		vlan->vid, port, untagged ? "untagged" : "tagged",
> +		pvid ? "PVID" : "no PVID");
> +	/* add port to vlan4k. It knows nothing about PVID */
> +	ret = rtl8365mb_vlan_4k_port_add(ds, port, vlan, extack);
> +	if (ret)
> +		return ret;
> +
> +	/* VlanMC knows nothing about untagged but it is required for PVID */
> +	ret = rtl8365mb_vlan_mc_port_add(ds, port, vlan, extack);
> +	if (ret)
> +		goto undo_vlan_4k;
> +
> +	/* Set PVID if needed */
> +	if (pvid) {
> +		ret = rtl8365mb_vlan_pvid_port_add(ds, port, vlan, extack);
> +		if (ret)
> +			goto undo_vlan_mc;
> +	}
> +
> +	return 0;
> +
> +undo_vlan_mc:
> +	(void)rtl8365mb_vlan_mc_port_del(ds, port, vlan);
> +
> +undo_vlan_4k:
> +	(void)rtl8365mb_vlan_4k_port_del(ds, port, vlan);
> +	return ret;
> +}
> +
> +static int rtl8365mb_port_vlan_del(struct dsa_switch *ds, int port,
> +				   const struct switchdev_obj_port_vlan *vlan)
> +{
> +	bool untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
> +	bool pvid = !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
> +	struct realtek_priv *priv = ds->priv;
> +	int ret1, ret2, ret3;
> +
> +	dev_dbg(priv->dev, "del VLAN %d on port %d, %s, %s\n",
> +		vlan->vid, port, untagged ? "untagged" : "tagged",
> +		pvid ? "PVID" : "no PVID");
> +
> +	ret1 = rtl8365mb_vlan_pvid_port_del(ds, port, vlan);
> +	ret2 = rtl8365mb_vlan_mc_port_del(ds, port, vlan);
> +	ret3 = rtl8365mb_vlan_4k_port_del(ds, port, vlan);
> +
> +	return ret1 ?: ret2 ?: ret3;
> +}
> +
> +static int
> +rtl8365mb_port_set_vlan_egress_mode(struct realtek_priv *priv, int port,
> +				    enum rtl8365mb_vlan_egress_mode mode)
> +{
> +	u32 val;
> +
> +	val = FIELD_PREP(RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK, mode);
> +	return regmap_update_bits(priv->map,
> +			RTL8365MB_PORT_MISC_CFG_REG(port),
> +			RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK, val);
> +}
> +
> +/* VLAN support is always enabled in the switch.
> + *
> + * All ports starts with vlan-unaware state, letting non-bridge port forward
> + * to CPU.
> + *
> + */
> +static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +	enum rtl8365mb_vlan_egress_mode mode;
> +	struct dsa_port *dp;
> +	int ret;
> +
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		/* Disable vlan-filtering for all ports */
> +		ret = rtl8365mb_port_vlan_filtering(ds, dp->index, false, NULL);
> +		if (ret) {
> +			dev_err(priv->dev,
> +				"Failed to disable vlan filtering on port %d\n",
> +				dp->index);
> +			return ret;
> +		}
> +
> +		/* The switch default is RTL8365MB_VLAN_EGRESS_MODE_REAL_KEEP,
> +		 * that forwards the packet as it was received. However,
> +		 * different untag settings will require the switch to update
> +		 * the tag.
> +		 */
> +		mode = RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL;
> +		ret = rtl8365mb_port_set_vlan_egress_mode(priv, dp->index,
> +							  mode);
> +		if (ret) {
> +			dev_err(priv->dev,
> +				"Failed to set port %d egress mode\n",
> +				dp->index);
> +			return ret;
> +		}
> +	}
> +
> +	/* VLAN is always enabled. */
> +	ret = regmap_update_bits(priv->map, RTL8365MB_VLAN_CTRL_REG,
> +				 RTL8365MB_VLAN_CTRL_EN_MASK,
> +				 FIELD_PREP(RTL8365MB_VLAN_CTRL_EN_MASK, 1));
> +	return ret;
> +}
> +
>  static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
>  				       bool enable)
>  {
> @@ -2014,6 +2253,20 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
>  	if (ret)
>  		goto out_teardown_irq;
>  
> +	/* vlan config will only be effective for ports with vlan filtering */
> +	ds->configure_vlan_while_not_filtering = true;
> +	/* Set up VLAN */
> +	ret = rtl8365mb_vlan_setup(ds);
> +	if (ret)
> +		goto out_teardown_irq;
> +
> +	/* Set maximum packet length to 1536 bytes */
> +	ret = regmap_update_bits(priv->map, RTL8365MB_CFG0_MAX_LEN_REG,
> +				 RTL8365MB_CFG0_MAX_LEN_MASK,
> +				 FIELD_PREP(RTL8365MB_CFG0_MAX_LEN_MASK, 1536));
> +	if (ret)
> +		goto out_teardown_irq;
> +
>  	ret = rtl83xx_setup_user_mdio(ds);
>  	if (ret) {
>  		dev_err(priv->dev, "could not set up MDIO bus\n");
> @@ -2124,6 +2377,9 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
>  	.teardown = rtl8365mb_teardown,
>  	.phylink_get_caps = rtl8365mb_phylink_get_caps,
>  	.port_stp_state_set = rtl8365mb_port_stp_state_set,
> +	.port_vlan_add = rtl8365mb_port_vlan_add,
> +	.port_vlan_del = rtl8365mb_port_vlan_del,
> +	.port_vlan_filtering = rtl8365mb_port_vlan_filtering,
>  	.get_strings = rtl8365mb_get_strings,
>  	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
>  	.get_sset_count = rtl8365mb_get_sset_count,
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> new file mode 100644
> index 000000000000..1ac36c06dcf7
> --- /dev/null
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> @@ -0,0 +1,805 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* VLAN configuration interface for the rtl8365mb switch family
> + *
> + * Copyright (C) 2022 Alvin Šipraga <alsi@bang-olufsen.dk>
> + *
> + * VLAN configuration takes place in two separate domains of the switch: the
> + * VLAN4k table and the VLAN membership configuration (MC) database. While the
> + * VLAN4k table is exhaustive and can be fully populated with 4096 VLAN
> + * configurations, the same does not hold for the VLAN membership configuration
> + * database, which is limited to 32 entries.
> + *
> + * The switch will normally only use the VLAN4k table when making forwarding
> + * decisions. The VLAN membership configuration database is a vestigial ASIC
> + * design and is only used for a few specific features in the rtl8365mb
> + * family. This means that the limit of 32 entries should not hinder us in
> + * programming a huge number of VLANs into the switch.
> + *
> + * One necessary use of the VLAN membership configuration database is for the
> + * programming of a port-based VLAN ID (PVID). The PVID is programmed on a
> + * per-port basis via register field, which refers to a specific VLAN membership
> + * configuration via an index 0~31. In order to maintain coherent behaviour on a
> + * port with a PVID, it is necessary to keep the VLAN configuration synchronized
> + * between the VLAN4k table and the VLAN membership configuration database.
> + *
> + * Since VLAN membership configs are a scarce resource, it will only be used
> + * when strictly needed (i.e. a VLAN with members using PVID). Otherwise, the
> + * VLAN4k will be enough.
> + *
> + * With some exceptions, the entries in both the VLAN4k table and the VLAN
> + * membership configuration database offer the same configuration options. The
> + * differences are as follows:
> + *
> + * 1. VLAN4k entries can specify whether to use Independent or Shared VLAN
> + *    Learning (IVL or SVL respectively). VLAN membership config entries
> + *    cannot. This underscores the fact that VLAN membership configs are not
> + *    involved in the learning process of the ASIC.
> + *
> + * 2. VLAN membership config entries use an "enhanced VLAN ID" (efid), which has
> + *    a range 0~8191 compared with the standard 0~4095 range of the VLAN4k
> + *    table. This underscores the fact that VLAN membership configs can be used
> + *    to group ports on a layer beyond the standard VLAN configuration, which
> + *    may be useful for ACL rules which specify alternative forwarding
> + *    decisions.
> + *
> + * VLANMC index 0 is reserved as a neutral PVID, used for vlan-unaware ports.
> + *
> + */
> +
> +#include "rtl8365mb_vlan.h"
> +#include "rtl8365mb_table.h"
> +#include <linux/if_bridge.h>
> +#include <linux/regmap.h>
> +
> +/* CVLAN (i.e. VLAN4k) table entry layout, u16[3] */
> +#define RTL8365MB_CVLAN_ENTRY_SIZE			3 /* 48-bits */
> +#define RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK		GENMASK(7, 0)
> +#define RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK		GENMASK(15, 8)
> +#define RTL8365MB_CVLAN_ENTRY_D1_FID_MASK		GENMASK(3, 0)
> +#define RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK		GENMASK(4, 4)
> +#define RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK		GENMASK(7, 5)
> +#define RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK		GENMASK(8, 8)
> +#define RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK		GENMASK(13, 9)
> +#define RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK		GENMASK(14, 14)
> +/* extends RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK */
> +#define RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK		GENMASK(2, 0)
> +/* extends RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK */
> +#define RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK		GENMASK(5, 3)
> +/* extends RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK */
> +#define RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK	GENMASK(6, 6)
> +
> +/* VLAN member configuration registers 0~31, u16[3] */
> +#define RTL8365MB_VLAN_MC_BASE				0x0728
> +#define RTL8365MB_VLAN_MC_ENTRY_SIZE			4 /* 64-bit */
> +#define RTL8365MB_VLAN_MC_REG(index) \
> +		(RTL8365MB_VLAN_MC_BASE + \
> +		 (RTL8365MB_VLAN_MC_ENTRY_SIZE * (index)))
> +#define   RTL8365MB_VLAN_MC_D0_MBR_MASK			GENMASK(10, 0)
> +#define   RTL8365MB_VLAN_MC_D1_FID_MASK			GENMASK(3, 0)
> +
> +#define   RTL8365MB_VLAN_MC_D2_VBPEN_MASK		GENMASK(0, 0)
> +#define   RTL8365MB_VLAN_MC_D2_VBPRI_MASK		GENMASK(3, 1)
> +#define   RTL8365MB_VLAN_MC_D2_ENVLANPOL_MASK		GENMASK(4, 4)
> +#define   RTL8365MB_VLAN_MC_D2_METERIDX_MASK		GENMASK(10, 5)
> +#define   RTL8365MB_VLAN_MC_D3_EVID_MASK		GENMASK(12, 0)
> +
> +/* Some limits for VLAN4k/VLAN membership config entries */
> +#define RTL8365MB_PRIORITYMAX	7
> +#define RTL8365MB_FIDMAX	15
> +#define RTL8365MB_METERMAX	63
> +#define RTL8365MB_VLAN_MCMAX	31
> +
> +/* RTL8367S supports 4k vlans (vid<=4095) and 32 enhanced vlans
> + * for VIDs up to 8191
> + */
> +#define RTL8365MB_MAX_4K_VID	0x0FFF /* 4095 */
> +#define RTL8365MB_MAX_MC_VID	0x1FFF /* 8191 */
> +
> + /* Port-based VID registers 0~5 - each one holds an MC index for two ports */
> +#define RTL8365MB_VLAN_PVID_CTRL_BASE			0x0700
> +#define RTL8365MB_VLAN_PVID_CTRL_REG(_p) \
> +		(RTL8365MB_VLAN_PVID_CTRL_BASE + ((_p) >> 1))
> +#define   RTL8365MB_VLAN_PVID_CTRL_PORT0_MCIDX_MASK	0x001F
> +#define   RTL8365MB_VLAN_PVID_CTRL_PORT1_MCIDX_MASK	0x1F00
> +#define   RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(_p) \
> +		(((_p) & 1) << 3)
> +#define   RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_MASK(_p) \
> +		(0x1F << RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(_p))
> +
> +/* Frame type filtering registers */
> +#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_BASE	0x07aa
> +#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_REG(port) \
> +		(RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_BASE + ((port) >> 3))
> +/* required as FIELD_PREP cannot use non-constant masks */
> +#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_MASK(port) \
> +		(0x3 << RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_OFFSET(port))
> +#define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_OFFSET(port) \
> +		(((port) & 0x7) << 1)
> +
> +/**
> + * struct rtl8365mb_vlan4k - VLAN4k table entry
> + * @vid: VLAN ID (0~4095)
> + * @member: port mask of ports in this VLAN
> + * @untag: port mask of ports which untag on egress
> + * @fid: filter ID - only used with SVL (unused)
> + * @priority: priority classification (unused)
> + * @priority_en: enable priority (unused)
> + * @policing_en: enable policing (unused)
> + * @ivl_en: enable IVL instead of default SVL
> + * @meteridx: metering index (unused)
> + *
> + * This structure is used to get/set entries in the VLAN4k table. The
> + * VLAN4k table dictates the VLAN configuration for the switch for the
> + * vast majority of features.
> + */
> +struct rtl8365mb_vlan4k {
> +	u16 vid;
> +	u16 member;
> +	u16 untag;
> +	u8 fid : 4;
> +	u8 priority : 3;
> +	u8 priority_en : 1;
> +	u8 policing_en : 1;
> +	u8 ivl_en : 1;
> +	u8 meteridx : 6;
> +};
> +
> +/**
> + * struct rtl8365mb_vlanmc - VLAN membership config
> + * @evid: Enhanced VLAN ID (0~8191)
> + * @member: port mask of ports in this VLAN
> + * @fid: filter ID - only used with SVL (unused)
> + * @priority: priority classification (unused)
> + * @priority_en: enable priority (unused)
> + * @policing_en: enable policing (unused)
> + * @meteridx: metering index (unused)
> + *
> + * This structure is used to get/set entries in the VLAN membership
> + * configuration database. This feature is largely vestigial, but
> + * still needed for at least the following features:
> + *   - PVID configuration
> + *   - ACL configuration
> + *   - selection of VLAN by the CPU tag when VSEL=1, although the switch
> + *     can also select VLAN based on the VLAN tag if VSEL=0
> + *
> + * This is a low-level structure and it is recommended to interface with
> + * the VLAN membership config database via &struct rtl8365mb_vlanmc_entry.
> + */
> +struct rtl8365mb_vlanmc {
> +	u16 evid;
> +	u16 member;
> +	u8 fid : 4;
> +	u8 priority : 3;
> +	u8 priority_en : 1;
> +	u8 policing_en : 1;
> +	u8 meteridx : 6;
> +};
> +
> +enum rtl8365mb_frame_ingress {
> +	RTL8365MB_FRAME_TYPE_ANY_FRAME = 0,
> +	RTL8365MB_FRAME_TYPE_TAGGED_ONLY,
> +	RTL8365MB_FRAME_TYPE_UNTAGGED_ONLY,
> +};
> +
> +static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
> +				  struct rtl8365mb_vlan4k *vlan4k)
> +{
> +	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE];
> +	int ret;
> +
> +	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_CVLAN,
> +				    RTL8365MB_TABLE_OP_READ, &vid, 0, 0,
> +				    data, ARRAY_SIZE(data));
> +	if (ret)
> +		return ret;
> +
> +	/* Unpack table entry */
> +	memset(vlan4k, 0, sizeof(*vlan4k));
> +	vlan4k->vid = vid;
> +	vlan4k->member =
> +		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, data[0]) |
> +		(FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2])
> +		 << FIELD_WIDTH(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK));

This FIELD_GET() << FIELD_WIDTH() resembles FIELD_PREP(), except that
you skip some checks. Is that intentional?

