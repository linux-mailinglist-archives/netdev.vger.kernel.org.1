Return-Path: <netdev+bounces-169643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE15EA45084
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 23:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4B57A5FC8
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 22:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5919230D0D;
	Tue, 25 Feb 2025 22:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gr2CvU9l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA01C84C8
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523976; cv=fail; b=ZVYNEasssrt1IrUPcsfnaEM8twpkGH8+0zOsOd39sAAoDKWApFdqWjqFVVHsWDY6LTQPMtHX1hbWaMAewdi5A1pJIXDr/nkQF3RBFNV/yBFI6UrsjwklPwDsJiEn2YoSKwKWPHUPJj63rGUm6lfuC7o23V7+vMAjg7f2X4pHv68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523976; c=relaxed/simple;
	bh=Y+L1mUo4t/DIrnW0fTMPzWzSiCv7h2fMMk2WKvEGi7k=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ewPvhHR5oRDutuaWswV8KR0wBBQXqyHNwNhW6ryoUvARLndHiN+8UCBicoYwsLE+8XRspCm7SRtyBMqOTmj9otxzhDRunwSb2IXzoCFCAuidSiErjgzG1zn84e6Dmpl38SJ2LFBH9dZCqzBsuFTmPMA64zYGrbcpLlYYdOksdlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gr2CvU9l; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHLULFAypOXYbiEzdSWY8k+QddEpCCipwvf33UG+Z4HKI7PITWqmM9tj2jeqz7LfBfRbg2M9PXlqF6QDyi3UhUS8FsMmEUdIW/mW6501j0FzCF8hrgWS2S5/maLPt0+1eMGI9ah2N71c7I2NmC5GYA6HkrScQXiVdGPRJqLmbo5mnOCg3i4ckgMTkhBlujuA8Wy2ZtQpEEG069gxFu+lejv/n+k+nBSFdLgIV1CB9KyyQy9hHmSM1LHQNPh78oI9LT5jmT10dj5kMbyGaK4s3fumX6USGHEgSV1hkCY+FBtf62aIn6z3wPTIxf1a66ac2eWOx+AIpR0dYb9s/TCnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpaqqfaStFXmM+uKstCF4XOOqXNTmpwXiBP1j14QfAE=;
 b=xyNWcIQhIznVly1MIa9Aevwxi+bOmSjU9OYT/WmAS9df6S9I9fObjQV+nMJEeMoMZMuyMAZctapLIal7+/442Drr9ipWy3LDbB6aEFAbWejdDXoVQHqD+fdbhiDcADW+T/uh86JyuDuBiZIX3CiHs+9qZbNakX9DcRKI4RJYesx/mFNhFtPHAydGw2frhMWAWa4b12hKBh5+ojWTpAVnovI3WisW6CT9GBGBJd/tn0+zrokLixFBmjuA59DRziMB+q90t1NQ/EjdtaH5XbA1ROFiCz5vZ+t3tae+tcNtpcy/x3h9zsdUklmsnmqjK+41XWQ12D8ghpjVlLtMRKYSrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpaqqfaStFXmM+uKstCF4XOOqXNTmpwXiBP1j14QfAE=;
 b=gr2CvU9l414b6fsVoTmQYBcusbOHQxHiHRtGJ39zwOscMK/9t9/64i6nla0cKDUzcHIL4utq3HPkbX7RbCXuATxu32xvDJQwN13SOj5zNAmOmis70kcbSS+5yTGAnfqBJq435zYdbGVN/XERvFI4XLtTV3/DTeUic4iH7ggIIwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Tue, 25 Feb 2025 22:52:52 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 22:52:52 +0000
Message-ID: <40a9cd1f-790e-49a0-a99b-d6223c836780@amd.com>
Date: Tue, 25 Feb 2025 14:52:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: Clear old fragment checksum value in
 napi_reuse_skb
To: Mohammad Heib <mheib@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20250225112852.2507709-1-mheib@redhat.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250225112852.2507709-1-mheib@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::27) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d6c19f-4de6-4fd2-ea11-08dd55ef229e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzNLck5ZSkpabDRQWmZpM2kyMk5BZjI2Qm5ZSXZsOHNQZzBmQjRuMFpFOE96?=
 =?utf-8?B?amdZeStwMno0dmtFU3pUMFVaN0lTMndNdHdEczVJRjY2SEFqbTVwdXB5V3NF?=
 =?utf-8?B?NXlqU0kvN04wWG1nWkFISGc4WVlHcFpSd3JCZVlaWkdFSXp2cjFJYzFUOXVr?=
 =?utf-8?B?KzRXZmtwU3JIT3dhRE9NYmxqR2Z0SlI5ZlhQQkRhRDBzNTF3UllzNnZvVEI0?=
 =?utf-8?B?VTdCelRhbnVqQ29PdENmbXJMZDZOMlBqdjBVb204UGF0akdLWEtZU1hEMzBU?=
 =?utf-8?B?WmxGN3hvbVI2alZZY2JscDRMYUFvMmZ3anVoWmJVbTk0WWpFQXVXeVpMS1pl?=
 =?utf-8?B?Vnp5a25YVmdSU2JIWGhJNmNBR0ZEYmlSNE9zYkFoUXZoSEprcXZ5V1JBOWx4?=
 =?utf-8?B?SStGeTVlTTJ6TVBoTG8rTmtGSTBpVGRDb20vQ2djSDdlOTRrV1hncWZyZjRH?=
 =?utf-8?B?d1l6dW1Ic1oxcndSSStBMWNTMWd6V0pZczhnem05WDBMNTErSVhiTXN1VVcz?=
 =?utf-8?B?NmpERzI1N1N4ZWNPL05jMVVYbFR4emppR1ppUFBiTzZ1Q045MUtYNndmUDZ4?=
 =?utf-8?B?RVFnTVFnTDZZUFc0NGg3VEVLZUhzenRoMFM0ZXFtODVVb1ZraWNZdDNFQUFT?=
 =?utf-8?B?bmFwUWtjdDhOSHp1N2hnZ0tqSDVyMFczNkdoWlNEdmdQVlhpQTB6NkZoNzIx?=
 =?utf-8?B?SmpTeEM5cVlOVVN0MDdiVGRtZXBtZDBYN05aci91eFgyemt3c1dZZ2ZBUnRw?=
 =?utf-8?B?U3VrNlBnTnBiQk1XQWxsK1o1UUtKekdadzhnN0dOY0VFRmNJSGx0NFZOem9G?=
 =?utf-8?B?RmNkc1drZ0NXUE05dStDTFNtV3lOUnVpeEd2cjZVTEUybzVEMThYRkRib25S?=
 =?utf-8?B?YkF2U29xdjBUejBqSVBpUllQcHpScVVGSENmRDRwcDZjdys2NnA4bEYweFY2?=
 =?utf-8?B?VEpFRDdYL3haajZSMStoSXJJUTRIYmw5T0dtaU9rRFpSQ0pjbGtqRmtDMlhQ?=
 =?utf-8?B?akIwKytXKy9QYzhQTU9mWnd5b2wwQnVlVWg5eldtcHl4U1BoSDlSTnJJNDND?=
 =?utf-8?B?TGNIMTF3WFByRUVnYU5VKytnR0lhcUp2c09BMFhJdk1mL2JhdXRBbzdCd1Yw?=
 =?utf-8?B?M1grK3RSVXA4NEYyZDZDeDA5VWd4YzBmeTdUeSttbEtRajBFS2VKMjRUQkFZ?=
 =?utf-8?B?dk9vd3ZRWEJHVTRJd0dYL3pvaWFqdWI5QXR5TXZiZHFVK3pKcGpUMlZlNUhh?=
 =?utf-8?B?VkJVN0UzRi9zSk8wOS9ra05pcEtQUFRuWTRZVjRKUm1MeEVocGJpV2M1VU9C?=
 =?utf-8?B?VDhoVWF3WkpuZmVpanQzejdkTmFkMGVqK3JyZERpRklyUXptZy9PKzNiT2tI?=
 =?utf-8?B?cWlVbFBQdmhIeHBRbkJidjJxeDJaZml2WnNVRk84cnkvZkZvbTMwUXlSdUhZ?=
 =?utf-8?B?QVlOdHFIVkY2aG1uQVNWMnVzMmw1Wk1YMjZpcms4MStBT09LSy9BZGNzb3Ux?=
 =?utf-8?B?UDNKNW05REVJYnpDM2tYQ2JvODdVWjhsaEF4WStSY2ZOdUpTaFBUZU9GQ2tI?=
 =?utf-8?B?Vy9razkyY04zTUJEcEFBeVRRNm1zZVpNR3hkZ2ttMTdIZldzek1VdURJcmZQ?=
 =?utf-8?B?YWhYN2RYQit3Vk9nUUIyU21yWEFPK1BHV0dDMktNWG1ESzcvb3pUN1VQVUdZ?=
 =?utf-8?B?TTJSRGtXNXhlT0JscVlrdGVYcWp1NUhUZkF1T2NSSDlkdWs3emE1NzAzT0lq?=
 =?utf-8?B?VzVseERheUROZHF3ZWVML2xJa3MxR0hOcWlZSGV5L1k5b0R2TlIzMVIvUjJ0?=
 =?utf-8?B?RzFtWEVzL3JHaGo5ZlVOd3dRbncyU0J4RFhaZjBGZUJhYTlUekZldWlIRVJs?=
 =?utf-8?Q?Rd4dGjc/tfGKU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVFXdE4yRFl6aVpOT05TVVoxSCtXM2dVMlhZWDFLVzVUR1BDUld2S0x1ekdr?=
 =?utf-8?B?Rk4rVmhZdkxzKzFNZy9GSkgvZkkwY2N4R2ZaSGdCUnVnUHlFNTcvVHFZYUx1?=
 =?utf-8?B?NjlFT0Q0YjBCamNNRnlMbHVxWkk0RnpUc2tueHBuWVRuKzY2WVdHWW1Gd0JJ?=
 =?utf-8?B?WXVLaElaOGkzK0djNzQ5M2R0R1ZEVFRWZDlHd1ZUT1RWaDJuK0lYcHhWNWRB?=
 =?utf-8?B?YWRmTElXazdMYzdESFJjdkpUdE1Ha2h6c25xS3g3emRVdWt0VTl4Q1RtQS9k?=
 =?utf-8?B?Rk8rWStVQUUrcVAzRkdhbUd3SUZHZlVVamg4Q21FVmUzRmRXT0VQaitYakUx?=
 =?utf-8?B?ZDQrVTlxK2E5a2xySWtUa01uZVRtWnhSQVVIVXg4eUJMemphSmF3WndwS1RB?=
 =?utf-8?B?QTVHOXo4ODI2Snk4V2t1V0drWmJocG1WaEdhQ0RvTUNVZjd1RlhpUnlwUFY2?=
 =?utf-8?B?QWVtTGRGQlJzbDVkTWlDMllNV0cxSDBwTTRocVZEWkxnK04yZWlYSEg5T1BL?=
 =?utf-8?B?Rmt1S2pwcG1FQWxoN0hDbmVWVE9xVWltWWtZcE16OU5GLzZ4VjhiVmtVZ2tV?=
 =?utf-8?B?clkzRnlvZWdIdno5ZjVkYnZqajl4NnZhWk5yUVNXYVp6LzRWakdkVjJ0STFl?=
 =?utf-8?B?TE12dVY5SXB4NDRCRUJLcWIrUjNjMlJlOHFpemgwQXpVWlhqWW1Hd0RsY0FL?=
 =?utf-8?B?eVZOWTA5WDV3K1VFUWFvZXJIeUZmWXpkRU5UOGNVcGVBbkJkZ0VYbkRFZnI3?=
 =?utf-8?B?YWVrSW1sVUxsZzYrYVVwNFR3cFMzTnFvOUxRSytYeGNYZ3h5TmQrdTVqcEJU?=
 =?utf-8?B?T0xmZ1FDV0hPOEV3MHk1OHp0ZER5WTl2T0lnZWpESXhZTTYzSEhNcHBxSERN?=
 =?utf-8?B?NDZaNENSeDk1M0ZrN2hmM0hXQjRmMzU5STdITUlWSGYyM0t0Ym9TbDZVR0k5?=
 =?utf-8?B?MXIvUWNmaFl3dUpGdXVuaGJwSTQ5TExVY0Zlb3A1MWdmYk5ka25wODJ6bjMr?=
 =?utf-8?B?V3hFQnRyZVFoVzlZVEhTTGlEaFVVRy9iQTBiTWhqS2JDZXkwcllKWC81TS9y?=
 =?utf-8?B?RWpIQUUwOVJRb250UnR4ZkE4RDVSMlYzdUN2dy9JOVd2UEszUHlUcUdYNmkz?=
 =?utf-8?B?cnRqUXVmaVlkR2VrN29UYnRQNWM2NzlxdjdEZHpkUmxnam9rQnNKd01SNkNI?=
 =?utf-8?B?RytoNUtLd1FQZ1A0NkxQVDE2V3V5NkpaSk1hRUFXYWloNGo3WWJXYWx2aEp5?=
 =?utf-8?B?QnFkcUY4Uk1YMm14VUMvZGpKQkNCMVBQL1pxWXVHYlhCb3FEdmc1N1hSS1hm?=
 =?utf-8?B?U0ZVYTg4TDd2R3ovaFgvVFdybWcwd3BnNEVOdFdsRVBsekZGbGdncmdTVk5l?=
 =?utf-8?B?TUZ5UmZqK2pTSzNqblNIT3IvNUE4WVIraWQ3MGg2TXl0WmZ4bnhvczY0ZGQy?=
 =?utf-8?B?ZXZURkF2MHk5WFFnQmlsV1c4c0tIeHpsKzA0cXJDRDU2UjZNMXJlSGl1TnVY?=
 =?utf-8?B?ZDNTaklUSjVYQTdvSkhlOFVSaUw5VlZMSVFKcW1PNCszSTNpUkczcDBVZlli?=
 =?utf-8?B?UXhwdTVySC9YSlNxK2RUb0VCcGJ4R2tVRThSOUNUQ0FYYWgxSENnbDBFRVdI?=
 =?utf-8?B?VkNFVVdBV2cvUm01blgrbGtuUS9lWFllYTh5R1AxckdvdFB1b2x0QStjY0VK?=
 =?utf-8?B?L0xkOHVyVWZBMjlqSjRsRzhHNFZhL0RyVm5FQ3hOVFN5N0dWWHpqRXk3bTI5?=
 =?utf-8?B?VFBWR0Zaam0yMWNJVDMyWVIvdUhlNWFEL1lCQ2VvSU1tRW85TVpIUm5GME1P?=
 =?utf-8?B?akRJK1h0Smhwb0lQTFM3YTl1alc0d21aOENPYkZHb2dIeWdodTRQamZ5Vmh5?=
 =?utf-8?B?TXpuSGhEQzVVcWo5REZ5VkxybDBUZndzZ2tTWW4rTHpGb1h2TldiRlJqaVJm?=
 =?utf-8?B?U3A0Tnp1UGpIdWdXWjBGL0JMUFExeGpheW1PNEJXaEVpK0Y3dC9iNzY5TmZi?=
 =?utf-8?B?VHdXd3E3MnI0L0tQeHFPc2Z1b3p5Lzc5OWJxdVg2WE5SbXp6ODZlaUxWSHVK?=
 =?utf-8?B?WGJtUCt6bkMyS2E5WnNYdzlqeGNlYWdUc1dOTEFyN3VIdFF4RTMvRUdZd1Zt?=
 =?utf-8?Q?3k1DWOk2rUNhGfRdxSuuUaxXJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d6c19f-4de6-4fd2-ea11-08dd55ef229e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 22:52:52.4983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvv8fnblzTBOfKi0SYJH/4FulT1U2LBBY0S1w4wiaSO3cm8lynZA6XKq0iCs3NFFN2F81qaX6zwvgpNvL3q5oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145

On 2/25/2025 3:28 AM, Mohammad Heib wrote:
> 
> In certain cases, napi_get_frags() returns an skb that points to an old
> received fragment, This skb may have its skb->ip_summed, csum, and other
> fields set from previous fragment handling.
> 
> Some network drivers set skb->ip_summed to either CHECKSUM_COMPLETE or
> CHECKSUM_UNNECESSARY when getting skb from napi_get_frags(), while
> others only set skb->ip_summed when RX checksum offload is enabled on
> the device, and do not set any value for skb->ip_summed when hardware
> checksum offload is disabled, assuming that the skb->ip_summed
> initiated to zero by napi_reuse_skb, ionic driver for example will
> ignore/unset any value for the ip_summed filed if HW checksum offload is
> disabled, and if we have a situation where the user disables the
> checksum offload during a traffic that could lead to the following
> errors shown in the kernel logs:
> <IRQ>
> dump_stack_lvl+0x34/0x48
>   __skb_gro_checksum_complete+0x7e/0x90
> tcp6_gro_receive+0xc6/0x190
> ipv6_gro_receive+0x1ec/0x430
> dev_gro_receive+0x188/0x360
> ? ionic_rx_clean+0x25a/0x460 [ionic]
> napi_gro_frags+0x13c/0x300
> ? __pfx_ionic_rx_service+0x10/0x10 [ionic]
> ionic_rx_service+0x67/0x80 [ionic]
> ionic_cq_service+0x58/0x90 [ionic]
> ionic_txrx_napi+0x64/0x1b0 [ionic]
>   __napi_poll+0x27/0x170
> net_rx_action+0x29c/0x370
> handle_softirqs+0xce/0x270
> __irq_exit_rcu+0xa3/0xc0
> common_interrupt+0x80/0xa0
> </IRQ>
> 
> This inconsistency sometimes leads to checksum validation issues in the
> upper layers of the network stack.
> 
> To resolve this, this patch clears the skb->ip_summed value for each
> reused skb in by napi_reuse_skb(), ensuring that the caller is responsible
> for setting the correct checksum status. This eliminates potential
> checksum validation issues caused by improper handling of
> skb->ip_summed.
> 
> Fixes: 76620aafd66f ("gro: New frags interface to avoid copying shinfo")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>

Thanks!

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


> ---
>   net/core/gro.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 78b320b63174..0ad549b07e03 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -653,6 +653,7 @@ static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
>          skb->pkt_type = PACKET_HOST;
> 
>          skb->encapsulation = 0;
> +       skb->ip_summed = CHECKSUM_NONE;
>          skb_shinfo(skb)->gso_type = 0;
>          skb_shinfo(skb)->gso_size = 0;
>          if (unlikely(skb->slow_gro)) {
> --
> 2.48.1
> 
> 


