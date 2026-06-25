Return-Path: <netdev+bounces-302009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eOR6HkhLPWqs0wgAu9opvQ
	(envelope-from <netdev+bounces-302009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:37:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAA96C71E0
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:37:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=RcbsbG3y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302009-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302009-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20F2330FEB9B
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E30C26ED5D;
	Thu, 25 Jun 2026 15:32:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023076.outbound.protection.outlook.com [40.107.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305127057D;
	Thu, 25 Jun 2026 15:32:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401579; cv=fail; b=euDSEGg/sXuBDQw197jejdxiqE4N8pPqL533Duop6QLmjJZcgyhuByLUb7IE/CRHGnaUrudlBpMAKQPKr3JeD9PWHMqGO4xrItGwtT8YNkM2jNvi/RuIKxsnTVsr1qXJpUrpKr+eJHe2/WtT7YZDpUXRHudwXjUH9O6XOKCItsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401579; c=relaxed/simple;
	bh=FijUo7oWPxBj1GxODqA7RUcbZ1VYT/OZRm/0iu9crX0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lheKxuFB2bUVKY/8hW4w9ytLmP1P6bJdDqaXc8zvldBpKxO49198A7ypGhad87C5UhkTtt2IR/5hMlT8s5JKTB0XCdeKZYuLfpg84AwEvapI22Hn/L4wuVcHsjy77iGzXCVP75MzDFSO+FKjrPS/Y37reah0ZoUYJMJuPZ3PcYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=RcbsbG3y; arc=fail smtp.client-ip=40.107.159.76
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPW5e2W8uY4Q9X0sZOZF6D4b7taHAXIJrfxXRnV6MKgzLXWHXaBoEdAzZSFQnbdUN4o+PecG1lTAnAO6b5NP+LZWPYqw0EVgnGTgtat7hGPow2ZjZx1mv+P3/iufx2iZbTqz8ZG00a+JBV1Lbu7nJID5znzblXJXYn2YPzhX2PoI8MHhX7uqCpMMNo4KzNjY9EKDZb9qchNvAz0VVxgPBsHhmyRdzk3Nan6sCW8LKNn2xVFoUIna+OPzcxxzPZHW8FXKm8l24WXZPZOucNblf15TUR/TZBY3WW5B/RCXsrRLva/Jg2NAR4PyirrCaq1R4RNfTbCpqwNNcgPiomJiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3GugCxv1fRDW+o6MSGauG176DxdFfjvO4gKbfDYelc=;
 b=WjUM+nIyFylESpbnTRc14sUkPzAjaQSHhCrKxseTIWVv35DPJ+6dbmOFFERGi+EleopUNaZl83IAZYzDdeYjoKO+NRmBTqNBt2NH4LlK4SHB3iTunYKoVtD0nQp92e7Mfct8tS/LCod14HWNOCjSdw82dHEb8Uy2PS8awYwAvLFRkdO+JJBmpi8p6WBexAEGhGFZXuHqljpehtP7qCifll/TjRGElIfixOlDGnCO7+MpFhjOr8oqLpRFoSkr1fwNiSbLLBT4Xhuqf+IEUz0LlTPxbxUE6VIg7Wcg033BCAZobVOEi7eXt+Z3ICcx3/mSHuEsWbHvctK8uSt04ZLF4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3GugCxv1fRDW+o6MSGauG176DxdFfjvO4gKbfDYelc=;
 b=RcbsbG3ypvQxJrQ+RQBX+jOEw4F7sA0hjDVxpOG+jKPdcP57vN123mtygJgn3VFW3OXmrYaRRrVPQaLy9WdfZ0ScfJyqPpnymC84BpYdcxOEVV9aJkn6evkCd1PNOeorL8dBh2WC+ZJWSAlItfsAcQPQMcu7O9cEQ+DxzFbr9QjD8oCPlbUFH4sN2anE9ZQwMNnRncYhhnRqQrv0ujuBV7rf57hjrBgvkT2FsqnBeQM15zajVtuba8k1qvdqJx+i3f2Z70bvBBieyFD2cIw3+7C459gtYU/Sa8cl7CejoAhSPM3wIeIbUqnmNFZD7w132JVuUhwTliv+EtvglG7WhA==
Received: from AM0PR08MB11804.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::14) by GVXPR08MB10573.eurprd08.prod.outlook.com
 (2603:10a6:150:14b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 15:32:52 +0000
Received: from AM0PR08MB11804.eurprd08.prod.outlook.com
 ([fe80::bf46:f137:f6d2:5b3a]) by AM0PR08MB11804.eurprd08.prod.outlook.com
 ([fe80::bf46:f137:f6d2:5b3a%6]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 15:32:52 +0000
Message-ID: <9fd63541-dcc0-4478-a9de-f0444f2c86f5@virtuozzo.com>
Date: Thu, 25 Jun 2026 17:32:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] vhost/vsock: add support for VHOST_RESET_OWNER and
 CPR migration
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, sgarzare@redhat.com, mst@redhat.com,
 stefanha@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260622175808.508084-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20260622175808.508084-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0401.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::16) To AM0PR08MB11804.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB11804:EE_|GVXPR08MB10573:EE_
X-MS-Office365-Filtering-Correlation-Id: 950c3b63-5ebf-4a17-d2a6-08ded2cf0553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|7416014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	MNKa3nSUIEcJt76TW5Ly4g9jS6Hxxw+veryFW+RNpkJ8kQsauD+Y1YU/+fBBu3HhIy5Vz9NMAMbbql83rjrWjd8GGhVYNx0XCvfLe0n0kuCvTAoEuWbjWFw8ZQv6yQFoWoi59SQSYiNq+n70pP9LNby2Q5m6+D0rZFUUIJ9BahQIHf1Ek4W08EzixDrJ2nmojZdSxTPgFS5QvWZ6305yIKd/KaF2eokMGIAvCFk/s8tYUfLjuRuFX6pn3fN+ivm37bNqdSUNI0wz9aRxKGeQKVvSFn/33kNR29yrJx80AaV39Aq8MFFU9+bZNs0hUGx1Ip1xr6HIYE/N3rK1h9rQGOwXn8vNXCttexq5BuWpeQ63UwbP3UdVOS2wM/QJdh3vzBs76c6WLyX+6bE6pyuVDetcEdtH+EFiY/F5ZZeFi5lxEHG+cna5iypjup1BGwXQZnHvpQAcQmQzkxsqF3ROQECYbrk3T2lbBJUYbZQ5Hmf3QjYl/LvBkk9QCdcdl6knS3XQojtijXdMJZRjTphnM4KoJ01BnQgOkCKerIMJKvg7u0Lr9iBhnhuAmy0RyTRJu7Ar9M8iAbkvmdTwYshCODVb7AgkF+iz7y+Mma5sbBFtuikBkcyrvhWcgrE0oeIL0tRZo4KwFgjnnF5wR2AoaZcqQTSobKtbtjy3B0Wl/+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB11804.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWpGbyt1cmZXWGxkWmpBSFdueUNyUUNjdUZkdXlQTGdvVWFPOHlNemo1ZlVG?=
 =?utf-8?B?d1lYMjJEM3JCM1dwMmlpUjFNY0NiK0ZMVWpEMDluRHZ3K0ViY2ZUMVRtYnJS?=
 =?utf-8?B?YjN0Z2VrSTVjUzNBUDlLL1NwaGxlVGlCTVN5WUxsUUtjd0xjSnFWNHJaV0VE?=
 =?utf-8?B?SmVhVkpEWDJRSk04UDlVVi9ubEljalMwVFI0aWRNNHE0SUxSb2x1cXJuOVpR?=
 =?utf-8?B?S3Y5azB2ekJITHI3TUR4djk0dVRldFNxbWFnbHJYREMvWWZuMkE5aWlQS2FL?=
 =?utf-8?B?T1ArWEExeUpwNEtkMldaalVnVG5kWnlTYk5rZ0lpU3NGRU9reUZ0NFRyTkd2?=
 =?utf-8?B?bVhsMlBwakVaS3loV05mNjNzK3E5UzJwQjNuU1k3UGlkWmpxS2dpRzlYaXgx?=
 =?utf-8?B?UytQMnYxQzNoaFdyenljK0sxTFJGUXhKYmtCaFl0WjB3MVdRREMxQkVvNDRU?=
 =?utf-8?B?RFB6djllQXhKdjlnYTBKcDcrZk5odjc1Z0cyM3ZXd3Bsc1ZFUUxEN2JGZnlt?=
 =?utf-8?B?Wk02OG4yMHNuWXNiUG02b1JPS0h5a3lWZEh3RS9jTE5Bd2cxWmVaZ29mNVZD?=
 =?utf-8?B?b1hsSmtDcTBQN3loUndBZnMrWithNDkwTnhJVGlFVVlkc1drS3l5S1cxeFAy?=
 =?utf-8?B?cmdjYXU3ZnFKNlN3NnEvaXBCYW1OWEdCTHJwalQ3eWxYazNydXp4cUNVaXB3?=
 =?utf-8?B?NXhPMEFDNkcxbUliWnVnaW8zVmxUblQ1N0Q0YlplMElrZ3hNNm1mcW91cDg5?=
 =?utf-8?B?cTR0TGZtb0ZoNENkV0FFUDM1MElJOFhnWTFOZ3RpSUdpNU4vYUJHTWFKR0dz?=
 =?utf-8?B?UmpOc0hvMXg4Ky9LRGM4dTZuMGE4dFV4d01lSXBPQlVLcDFkaEI0L3hhb1Z2?=
 =?utf-8?B?WURjNFZQM2YvT1BhOHAzWGlFQnB0MG50U1RNZUZhd0F6dC9DMFFjR3JTVE5Y?=
 =?utf-8?B?L1FzeEhwQXJjNEVES3hKdVRydmlnQnB2UXJPamJ2WlFJbkZ1RHByWDdiWUlE?=
 =?utf-8?B?NCtqdGdwQk41a3dUak1jUEZzZFJBMTVZYVpGbFF0ZkFNZ2pZdE5tZUlwMHNu?=
 =?utf-8?B?Z0w2WXpXaUJ0M2dEV0JGTE1zdEdpOUJ4RG5sS2IyemtqVWdLN2xlVFFrb1NI?=
 =?utf-8?B?Qng2SVZpOGlON1Zqbmh6SDlaUkhYVjlmaERsemJhRXZUdzhhMVNFYk9oN1FU?=
 =?utf-8?B?SXRCSzZHcDRaZStudnZiRGZOSXJhRjVpNGY3b05Zd1I5eDRpMVoxcHBxK0Qr?=
 =?utf-8?B?SVlhSTcyWSs5bXJPOGZPTTMvZTk2OWVnY3Z5RkNGdVNrUURKUTNCNGgrYm42?=
 =?utf-8?B?dzRBeWkzbnUzaVB2M2tBTXdxSFh4aWVONzFwQlVmYm5odFBMUFRzVHlHL3Z2?=
 =?utf-8?B?Vk9vV09SREVqRmx1Nzk2U0grRWUyOFZYbXlEbXJCZThpVVJwcjB6VC9mSzVh?=
 =?utf-8?B?OXIvYndpeGpqeDRBUkFYNXVEMFRZMm9uQ1RIampIQ3FHdFFWWWdOT2V0clZG?=
 =?utf-8?B?U05SYkY3R2R1TW5EbWdsMkkyQVNOb01oUEdLdXliTy9JOWd5UTlQcm4wdUdE?=
 =?utf-8?B?VS9sUE03bkVoSlptYStHbDlEcndhRzZkMWdROHBlcUNjdnNpS1RxVUc1NjI5?=
 =?utf-8?B?TVNWZzFpR010akM5NjVZRm9aK2xqTERlQ1BITnpZTFBKbHZSdmhVdzQwbWN1?=
 =?utf-8?B?Uk1lSDdGSjUxbFREVTZsQ3E2clQ4UkFCVG5xeFZ2STB4Zm44cGw5bmNGVWUw?=
 =?utf-8?B?c010akt4YmVNd0ZjbXNZYjVuMml0OU11SEpLMFR3WWtFSGllejY2UHFkdXlG?=
 =?utf-8?B?TDFmT3JsdktqRmI5WjBLOUVTRFNKWEw0MlB0REVtZVlFNmlpS0xmM0pPMDlJ?=
 =?utf-8?B?VkVYVzV5NzU1RTRycnF5QkpFK3hMV2ozd2ZJWWVzbGJwdUdYMVpOckF1Skto?=
 =?utf-8?B?TlZoNWg1aUk1Q1VJaXJXcVhGMTFVdHFVYzEwckpxUDlleXFRaE92Z2paTyty?=
 =?utf-8?B?WktoVURaNGRjS3dpOVhrN0JYb3o1TmU2VmVZcVRnYXd5Sk1abHRRR0xtazhm?=
 =?utf-8?B?NTBBdEUwZUdLMkRZaUtCZW9UL0FhSkxvMUJiclZoa1RodWtmVGxBd2dkdSt0?=
 =?utf-8?B?TllmczR6emF4SlZ6N0NXOG55azFndVpvNUhjVDlrV2JSdmNhcDg0NFpMT2Rl?=
 =?utf-8?B?eCszb3hxTFo3bjlMVUpPbFB2bzVkRlk4MExyMUN0dFR4ZkhEZDVwNUNiSUgx?=
 =?utf-8?B?UUZ0ZlJHbVpUMjd2Ty9XeGJHZ1MzbzZ3Q29uajNVMVNISjR3SHZFUlNJcEM2?=
 =?utf-8?B?eGpISWNaTUg3RTN5TU10dU1hUGhPQUJ5N1N2eHRQaFdsa21BZE92TVVaamlz?=
 =?utf-8?Q?MZLyPP04EMeAEGtyb0MoKGlPt1aQQ/rhEYdso803XIxSw?=
X-MS-Exchange-AntiSpam-MessageData-1: UaWS+Q4t6ZeBUTM2NOwItOPK+YqSaR2TIuo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950c3b63-5ebf-4a17-d2a6-08ded2cf0553
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB11804.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:32:52.3574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUOWWOUd+mlrFfzrKvwQ6mTr2Kt7l1ughuwCk1XATOUA34N0xvn4DDRnpVdaLgFsV5m6wjLfAy+CDYBsg4RgGOKJkPnHD4jZxYNy5s3DRR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10573
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302009-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrey.drobyshev@virtuozzo.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:den@openvz.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ptikhomirov@virtuozzo.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptikhomirov@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEAA96C71E0

Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

On 6/22/26 19:58, Andrey Drobyshev wrote:
> v1 -> v2:
> 
>   * Patch 2 (suppress EHOSTUNREACH): replace 'cpr_paused' + backend check
>     with a single 'started' latch;
>   * Patch 3 (re-scan TX virtqueue): reword commit message;
>   * Patch 4 (VHOST_RESET_OWNER):
>       - fix a vhost_worker use-after-free / stuck VHOST_WORK_QUEUED stall
>         against the lockless send path;
>       - drop the no-op vsock_for_each_connected_socket() iteration;
>   * Shuffle the patches, keep RESET_OWNER implementation last to preserve
>     bisectability;
>   * Reword the cover letter.
> 
> v1: https://lore.kernel.org/virtualization/20260612165718.433546-1-andrey.drobyshev@virtuozzo.com
> 
> Host<-->guest connections via AF_VSOCK sockets aren't supposed to
> outlive VM migration, since VM is moving to another host.  However
> there's a special case, which is QEMU live-update, or CPR
> (checkpoint-restore) migration.  In this case, VM remains on the same
> host, and we'd like such connections to persist.
> 
> For this to work, we need to be able to transfer device ownership from
> source QEMU to dest QEMU.  Namely, source needs to reset ownership by
> issuing VHOST_RESET_OWNER ioctl, and then target has to claim it by
> calling VHOST_SET_OWNER.
> 
> Since VHOST_RESET_OWNER isn't yet implemented for vhost-vsock, let's add
> such implementation.  Patch 1 is a preliminary helper.  Patches 2 and 3
> fix the pre-existing issues which do manifest during CPR / RESET_OWNER.
> Patch 4 is the ioctl's implementation itself - we keep it last to
> preserve bisectability.
> 
> There's a complementary series for QEMU [0] adding support of vhost-vsock
> devices during CPR migration.
> 
> I've tested this (patched QEMU + patched kernel) approximately as follows:
> 
>   * Run listener in the guest:
>   socat -u VSOCK-LISTEN:9999 - >/tmp/recv.bin
> 
>   * Run data transfer from host to guest:
>   socat -u FILE:/root/bigfile.bin VSOCK-CONNECT:CID:9999
> 
>   * Perform CPR migration during transfer (either cpr-exec or cpr-transfer)
>   * Check that file hash sum matches
> 
> [0] https://lore.kernel.org/qemu-devel/20260619105514.128812-1-andrey.drobyshev@virtuozzo.com
> 
> Andrey Drobyshev (2):
>   vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
>   vhost/vsock: re-scan TX virtqueue on device start
> 
> Pavel Tikhomirov (2):
>   vhost/vsock: split out vhost_vsock_drop_backends helper
>   vhost/vsock: add VHOST_RESET_OWNER ioctl
> 
>  drivers/vhost/vsock.c | 96 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 76 insertions(+), 20 deletions(-)
> 

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.


