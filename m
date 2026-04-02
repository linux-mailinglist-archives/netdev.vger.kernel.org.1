Return-Path: <netdev+bounces-274570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF+INkR7zmmMnwYAu9opvQ
	(envelope-from <netdev+bounces-274570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:20:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD35038A62B
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B36373001CE7
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E673BF67E;
	Thu,  2 Apr 2026 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rsFAeEyW"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023121.outbound.protection.outlook.com [52.101.72.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8A3AC0FB;
	Thu,  2 Apr 2026 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138969; cv=fail; b=d2lItgmkxFBvSu6Peojrb7X79Wm9Z2rIoS9dGrirnPSZ3pNPOq+ZakZa4w6ZMKlyEG0Bfb9K45EMuBCJR+H2La8cP+/Jh0iP7vi6C4G7/Q53lCdomsuvQqaSdmtxDta9tG7lRzeU4y2jHOMH2ndN83o5+Rsokfw4pSd9Z4cS3zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138969; c=relaxed/simple;
	bh=VTPG0/vje0jrOGfCNuAg3RawctOkJD/pGLzfJ4OwMA8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pUcTF/J/UbBJuxu+54tJW7xJuzBuB9OSKm57zF66L6+F0KflEr/yC5yUaVWiIZT9HWo++Z3u+4XEN7HtBr9cRR+aUILdao+5etd+I9ymlAyej4SCwUrp5mUjF+BZbN5AnkajPGimUbsqY04+RxGtEeqmbhtxvsrwCrvZjb+IpsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=rsFAeEyW; arc=fail smtp.client-ip=52.101.72.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAOElV6rYuij6Dig/7j99gqBk3slxysiUZuRM+j1evnttsywdyAkfWIELoduvCAb7X/CrkJZe7G+7p+N3kAyPL7muNR/PrUkrGQt3UGnlscvANETv/cBBotySPxuJIBhbhlick5Eu9u2rmTDEHu5/binQ10zN0rv2ZFrA/slCkshC/ZaAR5BKFfykvVjUW+m0OAJRlIOytZMJkB5oxS6mQ5CvxvU0RfmQzhwlxVrZPuEeuCPSbtu87swsCQqyhOxKEWMNoJbQZnUZ00Y2L2yuqccejKt8uSKj1z+Yj2gvG/VNp1Mu1VqD1DFt36584E6+ADqmNEYfJ9QqnRV24lSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22/pmAGHW3fbgUIIC/kLxJCjQGEvyGAHjwESg2NmE3g=;
 b=MLYArhAc+uJUhO7iAyLvZ2onatWlVF3QOC1rfMbE9UKLfr2RPd0YFu/N6IIMwTSsjyNZKYP5Qr5SWgvqH1IABjyxx6XIxGQq4CT0Absbj2hlqid9+EOrZFd5nYaS8Oo1hkjT1T95CebZYwrFtyMCBsfAzoZKeKhYFUojbOgQ2UBMJ+ACoDSfIzd2WyfV1NqdZEZGX3QRe6qDjitJdICI6dKdY8G7F4y8iezzAu5up3sMsIP/N/oiPKE9BF9WDmWLE7hYqnYlP/LYTo+JJb0PkL3QM9oejBfAp9bEgjntgdz96JQAEGqE0t0SGHEH2X/Qdrb4+meQJ1hAsawQqHGHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22/pmAGHW3fbgUIIC/kLxJCjQGEvyGAHjwESg2NmE3g=;
 b=rsFAeEyW+LFOW2ttCk5pFw9JFzzOIqsH9/MwNaD9eTHcgBJDuA0+hyPDu60LAQhGfW+1yhh6ui4V3mtzZoN7FVrNE5xDLcS8gOwRVk8S9jO85xgUvavWo/1i2nrjqQWMTE4rCULKXYCm3itFnQvbKi8+cl9zaa8RIfUbT2J+f/u1dWvlhIXjZq3v/IlM1De69pPL9NgDsSDrJq2L2TJn2ll/82/e0If4WXPApD6p8bRM6xWtuAJaORgT+3i/PCgmFw+dB9hBCL+UZDFbDXXwBDleEE765RN9P+KKdZUgK18wYUFuxEBtBgDED9u/r/fZbthurXvyuHxVaLpgqxp6JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6942.eurprd08.prod.outlook.com (2603:10a6:102:15d::17)
 by DB9PR08MB11545.eurprd08.prod.outlook.com (2603:10a6:10:606::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 14:09:24 +0000
Received: from PAXPR08MB6942.eurprd08.prod.outlook.com
 ([fe80::fe53:d5e4:a1c8:61e6]) by PAXPR08MB6942.eurprd08.prod.outlook.com
 ([fe80::fe53:d5e4:a1c8:61e6%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 14:09:24 +0000
Message-ID: <4acba480-3728-4453-86b1-32200d804217@virtuozzo.com>
Date: Thu, 2 Apr 2026 16:09:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: fix skb_ext_total_length() BUILD_BUG_ON with
 CONFIG_GCOV_PROFILE_ALL
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Arnd Bergmann <arnd@arndb.de>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Mikhail Zaslonko <zaslonko@linux.ibm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: <20260402140558.1437002-1-khorenko@virtuozzo.com>
 <20260402140558.1437002-2-khorenko@virtuozzo.com>
Content-Language: en-US
From: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
In-Reply-To: <20260402140558.1437002-2-khorenko@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0048.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::13) To PAXPR08MB6942.eurprd08.prod.outlook.com
 (2603:10a6:102:15d::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6942:EE_|DB9PR08MB11545:EE_
X-MS-Office365-Filtering-Correlation-Id: 06769621-89b5-4624-3452-08de90c171aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mG/HcT94IsBn6M6OPK7r7vVwj7RPzWKCmxuPDIXeS3lMyERng1b3fWm0lg5hFFML3tbEWYa56IOl64IclHN/8kJHksQeuzUw40MitmnKiUdzvN13DNukKil/0JuF450eOYGEugJDc7ihaH2DYDwrmXSsq54JPlPYFmzF1/o/zxRaGMZh5C4JWk7XGrvC6tzC5wNzHkmliZR8F97juWjlGQX3AXVevP6BEc0DXDb1hFcG3El4SJbZizNQbHaCC3evS6tNRyUQS6/y1EQ3ZkxmgH8MxQtx0fhDpzeKkJyK1SvHXHOZsgMseKC5DZNUycD2VehAGc2nx2NtU2npKelYgGY/uOHuv51/i388zugig0S4slkZYzEAcbBs/VSzOfOnJnmxPaPu6Zgf3RKPqsh4HZuFuQuOk9Wfc7h2Tu08R3JsClDIwpDLQLq/zhQsrshielxgRMYuAI1YwiFxuLwGtSAcQuNRU5bu9SnqDEvT0APmzfZJf9QF/SHjtvc4v03bDkLbs+7FTqgo+fp3y68zXps6LTT/VZ+uya+1LqsMC3OHLr6SiGIAU/ZcrK6kLYEjMlke0KxKpSR16BxXovkmKQ0DO7HebB8WQ5p9yGQmI587lVjKGxvkhPFRDvRNszNtlHvtS2jUZy/ZkLr4H/6f2MvT4Y+WTKZUrxlWpYXwaubb/EHc5cZAdjVwlsD9CAXIkF+xwPYuBrQU3B77aa0lyMp2k5Hq0rRlz80+Nt06+iA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6942.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW5Vbm9lSjlzd3padEkzYTFMTmRXLzdBWmtRaGtQWElMVmJFOUJXRzlqK21D?=
 =?utf-8?B?bzVNa0RlT3NJbXdYMDFKQUVLVGE1Q1lBZUFiTmJDRkJvbmdBMzRvZXBlN3p1?=
 =?utf-8?B?bXZhQ1FlZnZOYnpIODJBNUsySGN5VGVNOFNLVmR5OE9PeGt3Yjd1Wm8vcmhO?=
 =?utf-8?B?dkhkTUsyNGZhUHRsRUhTUWRBMTlDcVNhZVdNbWg2VXNZY25USmhleWRwZm5Z?=
 =?utf-8?B?YVNPS2VaZUkxMGVjdVEydkxoSWVneTlUNFBwVWpmVzVObmhXTFc5R2Y4Z3dL?=
 =?utf-8?B?R0NxK3RSNlZ3K2liRzArSWwzblM1U1VJdnlSbTM0dFFSVmlVSVZRQjBDTERp?=
 =?utf-8?B?bTE0MmswVGtJOE9tcmpYS3kwaDNPZTVBR1d6bmcrNlkyd3JvNTd1emZjVDl2?=
 =?utf-8?B?b1RhZ0tES21tdHVZbjEyWng1NnNSdU5TMjI1TVNIYldiV3pyRGdDQXByTW9I?=
 =?utf-8?B?ZkNPcXJrYStaK0hNQUxxdXFZNnYrc09qRjBJQ3BOc3JjL0pxL1A1amtYcXAw?=
 =?utf-8?B?ZGNaanU1eFUrMW1VTXpzTEkvbmV0bzRHK0xSalEvV1JXNVJvQ2RFQUxZdXo0?=
 =?utf-8?B?bjYwaGszN2lzSHp6d1dZcWZHU2NweTB2a3Z3VXN0NjdjWlVVSG9EdWFoUlNx?=
 =?utf-8?B?MGVPTG5xbkRZNnBOT3lBamR1Z0gvZEQvYU1iVmJwcHFKSzR4S1J4dnE1aDNw?=
 =?utf-8?B?YlVBZ0V3b01YaWtDNGZZNUtVdWRRMlA1VUZNdjh3Qm1HZTJkbUNhOGZLL3hR?=
 =?utf-8?B?U2E3aDJZc0lDOVIwM09UL2diOWMzaUdIOGtLNmQ1QThqaHMvSm4rcWx2bW1X?=
 =?utf-8?B?d3EyaitucVh2QUI3RENxRGNGdG9WNmZrcmNIZWZ2RThuS0xWOStwNHV0TWF2?=
 =?utf-8?B?UFI4bmcrZktFQjV3V2g4aVdmWGh6N0FMNzVrczhLekdFckM4TWZyNjFEbkkr?=
 =?utf-8?B?cUQrenNWamYyLzdYUW5id21FbEl2Q2ZDQzRYREM3MDdtR1psdktpZEx3eEg2?=
 =?utf-8?B?WEtOdTRsN0ZHZ1FnUHVpM2FreHRBYjNVOFBHWllwK3gxZDJ3L2FIZ0lYY1py?=
 =?utf-8?B?emY5M0w5N25NY2RnZzRsc201R2txaU5MeHlEK3dGVWhKNjRib1dRNDhrK2dv?=
 =?utf-8?B?ZmdKMVhSYTJTTFQwak83Mk1DUHZtdWVkSVZnYTRJaDA1Yi9VODRqYVVJMHpr?=
 =?utf-8?B?ZDRzaE1EcC9DdTJobVlSQ2FFd3FReS83WkVWY1I0Qy9ydmdzTkJLWmMzWjJy?=
 =?utf-8?B?WjMya0J2S0lmbHRXdWNOekkwYTlYRC81SlhVWjlDOWJKOWtZb3B2VjI0Qi83?=
 =?utf-8?B?V1hkTmI4bU94bjNYNDBHRmdMRnQwcDc3MEJBcXRCOU5EY1dDM3NXTzNnR0Zk?=
 =?utf-8?B?eTdJdVlobTBFazVzTkhDT3BnRXd2byt0Q3h2MlJDaTlNaWcyQkNvUURPWGJN?=
 =?utf-8?B?K1RmaDRKZDlGYmlQRHQvVmE3Q2ZLelZndmYrR29DUW9ETlVHeGtRT05SK3lo?=
 =?utf-8?B?QXRqR0dnd01yL3Jydm54TmpWWFpsOTBVb3RYM1pWVTNjVk95bDdRQ1FBV1hl?=
 =?utf-8?B?TmtudFhBenVjUU1rbmJRbldOS2RCRDcrVlJ4VzBCMFNWRFdLWlErbmhkNXRi?=
 =?utf-8?B?RmFRV3NnU28rSXBmeDhNT1JpbTA3aHlyWC9kekF0Nk1HRFZRKzgweHo4N3Bt?=
 =?utf-8?B?aTQ5LzFWUU90bVZvd2YvZnYzNFg1azNMSFdTM1RNMm5GeCtWZ0FVbmM1ODBO?=
 =?utf-8?B?NSszZUsyVCtaZm9jNmwzL3VHazFsZTJBV1ZGMVBmWVdaNjZleGtNSldvSUpy?=
 =?utf-8?B?VTFSSWRsVEduU0x6bUpGWG4rLy83YVNuVnoyRmJXN0hrVW0rUmhzYm0ybzJa?=
 =?utf-8?B?V2lzcTJQbVN4YTJub0Y2Vm5UYVZCTm9meGdpclU0ZENLejZiYWdMaFFhYTRG?=
 =?utf-8?B?SjQxR3hpYktUSkUxMnQ1ZGpLS1dRQ2E1WTdkV0kycVY2Rnp3UWpIdTU3eFJv?=
 =?utf-8?B?R1Zoa1lQdEFZQ3haVXZVeWk3UlltanBFbWtlZlJidGVQdllzSHc2SnRUZzBi?=
 =?utf-8?B?OFM1UmdDdE1JMHR4ZGtHMEZIVGFKNFFEc3RyWDBVby9MbkFsVklrRFVQOFJV?=
 =?utf-8?B?TEVIZFBQOXY3TnNOYmlEelhSNmViY2JYeXAyM2lwWnFHMFFJVzVIeXpDTmdP?=
 =?utf-8?B?WWtXNURMUVMyaDA1L01TZE9DSlNCOXEvaDJpRE1oVTc2ZG1NOHVRM1R6eHp6?=
 =?utf-8?B?bUNWS3FYdFBjcXB1SmNoN3Q4ZjRkZERSdFlUVHBxbG04QWJrQkZDejYzbWdS?=
 =?utf-8?B?eDhEazIrMEg5c2c2VDgzYS93OS9kYlBXcXk3SlRyZHNQb0t0ZGlTR0NSOTVx?=
 =?utf-8?Q?/11RgG+W7VeECNmcf4QcoOKGZMUjyXoD074Qe?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06769621-89b5-4624-3452-08de90c171aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6942.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 14:09:24.4474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xvQIn9cIJJ3SUMN7k+fzfXw4j89bFLvnnOPlowTmXGh+cjcI9349/dK/Mg/SDCi2vRIAkarA2j/f8X0CAaMStXVfAToFZAU+4xrvXc9rjbpH7UY1hnl5HicZIQUij3y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11545
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274570-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasileios.almpanis@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD35038A62B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>

On 4/2/26 4:05 PM, Konstantin Khorenko wrote:
> When CONFIG_GCOV_PROFILE_ALL=y is enabled, the kernel fails to build:
>
>    In file included from <command-line>:
>    In function 'skb_extensions_init',
>        inlined from 'skb_init' at net/core/skbuff.c:5214:2:
>    ././include/linux/compiler_types.h:706:45: error: call to
>      '__compiletime_assert_1490' declared with attribute error:
>      BUILD_BUG_ON failed: skb_ext_total_length() > 255
>
> CONFIG_GCOV_PROFILE_ALL adds -fprofile-arcs -ftest-coverage
> -fno-tree-loop-im to CFLAGS globally. GCC inserts branch profiling
> counters into the skb_ext_total_length() loop and, combined with
> -fno-tree-loop-im (which disables loop invariant motion), cannot
> constant-fold the result.
> BUILD_BUG_ON requires a compile-time constant and fails.
>
> The issue manifests in kernels with 5+ SKB extension types enabled
> (e.g., after addition of SKB_EXT_CAN, SKB_EXT_PSP). With 4 extensions
> GCC can still unroll and fold the loop despite GCOV instrumentation;
> with 5+ it gives up.
>
> Mark skb_ext_total_length() with __no_profile to prevent GCOV from
> inserting counters into this function. Without counters the loop is
> "clean" and GCC can constant-fold it even with -fno-tree-loop-im active.
> This allows BUILD_BUG_ON to work correctly while keeping GCOV profiling
> for the rest of the kernel.
>
> This also removes the CONFIG_KCOV_INSTRUMENT_ALL preprocessor guard
> introduced by d6e5794b06c0, as __no_profile handles both GCOV and KCOV
> instrumentation at the root cause level rather than just disabling the
> check.
>
> Fixes: 5d21d0a65b57 ("net: generalize calculation of skb extensions length")
> Fixes: d6e5794b06c0 ("net: avoid build bug in skb extension length calculation")
>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   net/core/skbuff.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0e217041958a..47c7f0ab6e84 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5145,7 +5145,7 @@ static const u8 skb_ext_type_len[] = {
>   #endif
>   };
>   
> -static __always_inline unsigned int skb_ext_total_length(void)
> +static __always_inline __no_profile unsigned int skb_ext_total_length(void)
>   {
>   	unsigned int l = SKB_EXT_CHUNKSIZEOF(struct skb_ext);
>   	int i;
> @@ -5159,9 +5159,7 @@ static __always_inline unsigned int skb_ext_total_length(void)
>   static void skb_extensions_init(void)
>   {
>   	BUILD_BUG_ON(SKB_EXT_NUM > 8);
> -#if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL)
>   	BUILD_BUG_ON(skb_ext_total_length() > 255);
> -#endif
>   
>   	skbuff_ext_cache = kmem_cache_create("skbuff_ext_cache",
>   					     SKB_EXT_ALIGN_VALUE * skb_ext_total_length(),

