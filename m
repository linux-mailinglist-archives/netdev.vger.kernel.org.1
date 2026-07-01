Return-Path: <netdev+bounces-303814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lDkFM59zRWoFAgsAu9opvQ
	(envelope-from <netdev+bounces-303814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 22:07:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0AC6F147D
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 22:07:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=VGs6QfqQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303814-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303814-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 050F231961A4
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 19:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE474CA26E;
	Wed,  1 Jul 2026 19:34:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA6431E58;
	Wed,  1 Jul 2026 19:34:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934483; cv=fail; b=iYdEf+nPCKgo/zEteeUxu4SaEKdFUQaZTyX3joJL0QZbykztoMvWKfhjEHdZUfXFEWISKIn0gYhvgYnZCBzmwgr+vWWeFAuIe4z3Hm5V/kX7lRjQSn8hwL1T8+eYrF009sqVQ2LlBa+rlPDsAP/Xuec9XDfkflEiC7zSbOxHTE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934483; c=relaxed/simple;
	bh=K22a+HUE6K96iH/3TM41ZNdUpFH0cln27jfzpO2gSec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BrnjVyEohTaAhaPQTkWeUw30ofdDm4iFtmMe0Ys7DHQ7XbbwUZyRhUuAnB50v46al/GeMdepGtdMhVKgMJKmLjySGcWOEB4Nm2wBJ7uitxL28CC5MLEK+Q5xvIyAi/vXrNvinBSmzSKA0y/0B+N8kC+LekJ0gJoOeRXG3twLjXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VGs6QfqQ; arc=fail smtp.client-ip=52.101.56.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocqIhhXR6aRy8wZEMQ5v0THsuKgZg3nk7jH9sVc9p2xoq+51faHvo+VHvt6tFnOr3n6f9F7JIpnZUOcE2pmwRuz3O504R4PModpRGDgsJ9762xMuPyMOIihEHe5klhteRd4WGpH0INLKAWWOYE3Tz0qReMoit94xfj+7u4TRcow6F0/g+sKGr/b/c/fBYI7PmVnWY28Nq31M0lMaioz9OeyZeEWN8H/LK1FdrD00wLPkXObFCkj48+hnrrA4Tl/YHxcNeLAT7+MeuytM572cTcgfMgE6/hHxLIyznsm7/Rbj+lmMvqYZjrKC4R3gdRqhwW+Yl9I4HRKtCajARhlafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rADsiBZSkpYyPJhkP/oytoG1xdgcFn2QRbNkV5A7yM=;
 b=BokEu67POXq4WWB7NSkSc6kK/vsMQpqX+E3HdH1vEzX66gsHPsfDVIeVb4WEFrWLlWvtwu/xiMsvnovBnGGgr/W0O9xNletUOdImiqbQlZAtmewri5v6r/N52lgrZthF13Egl07NWm9zU/QK+FOMXMNE9M322pXz9EP4dGZXA+Dw8O5r5pg/LSRokeWaMAMy8oCV3CjJcVdAVF1o3ut1MtNZM2Xbht3r2PyS7sO4Cm62aZtfLAO8gwUYHpjZVvWauGvEAXDppCAsuyiirnDW67195L6Gf7ngfRSwe7yhtHRhhyddQLJbV8XFb/QB5JdNd97fto5szCGI86QhMbnNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rADsiBZSkpYyPJhkP/oytoG1xdgcFn2QRbNkV5A7yM=;
 b=VGs6QfqQG0Yi8nROqZDYYTG5LMOguuVb7As9Rq/Bzu2hscu8qD5qcTFPhBbQyoDDL2Tm0xarPy0sESgfqNr6CcgbD1bZ6JgvVIB8gVansGdaA52e0OCrO2WAFx/L5uq7FXreYvh1wUGQrr6XHRwooMm11oVNSuDWmp6WifhE1THlIMA/3pYHHPuZUdJIChvRlczwE2rfHHFDK6pDCCuY2UuYQeuCjVDSgQziopzMLHavx7K2Lg9qi3DegDlRwUP1YlfzM+91pxSe4HXrC/3VYsJFkqoYr8EvRScAw5hV7lFUHgzUNa9I8CfBS3RNwe4KZlhG/CqneZeWqY1afNzWCg==
Received: from MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 19:34:30 +0000
Received: from MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e]) by MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 19:34:27 +0000
Message-ID: <210e28c3-07d2-4370-a44d-9db561da3cc5@nvidia.com>
Date: Wed, 1 Jul 2026 22:34:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: bump default cmd() timeout to 20
 seconds
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, petrm@nvidia.com,
 leitao@debian.org, dw@davidwei.uk, noren@nvidia.com, gal@nvidia.com,
 linux-kselftest@vger.kernel.org
References: <20260629233348.2145841-1-kuba@kernel.org>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260629233348.2145841-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7086:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e15ad9-e64b-4649-ce86-08ded7a7c39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|1800799024|376014|3023799007|5023799004|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	GxMO57GRNIJBVWx/14qm6dw9ZwUydoJSBqHZe1foCmBk4piSVtCcX5hOLE8JBuARDUCkS0oJ/PYF6N6OtwnJsyje3xEa+PIzqNFAqStnTXciOE4qNZsKx/6LtwlSDSov2ahjWBW6XkpeSrVMBKTIUzf9Cj/9HlhkhwpTfcujtvObgiSpXoEGWcDvYzGJiN204h49f8a5cOKfjAhuDvPtK7hEtzGDTZj+l85febHD75epmdUxTrLEa44HOCKPuFs1diSVVuSDqoOrahlJHgADpFmTXdO+EWQxqW33gsNHCXya2WT1uWtgjTYUyl3div1qu5vfZjQxqbSHaFpFKG2EQnF7HxXEF3ByfvUzK9+u5feSiUfl5X1Me3OZ0uOPJv4fYQ6u42gd1f/LoL2/8ExyQj1ODM+w9Jk6vjfLlsE4htq6wkrwEoi1JY++8kHZpxgEOKyEg7AJgSbIssLVQmnEtG0PsKDvqlviEyRR6fDzvs2E/16o8gnSxEZ+6xCzzRe3WMaw3eT7vH+e4z5EOuuWpyO/6KdEGYjRG+HbINIXe6Wk1G/ZTSC1kwjCv4M2JK/Hm0mK7oGJuEE3bfaADFbSyv5A2GlWEdINC5Y8m/QeO2YnnLpEAXMoBTBA8bGoizY1Io0rlUao5/HeM5omcBJaMQMkF5hkjSjFREN5Sg+/t1Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(376014)(3023799007)(5023799004)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWZnVklVNHJrL0VPZjBQRjdCQ3NkdUNXQXVtdVkzNExjM0RHNVFMRG1MQkxY?=
 =?utf-8?B?cER1ZFV6M3pkK012U1JSS3V5M2ZCTkU4YTVOVVlJakZ4Wjd5eFp1anlVb1lx?=
 =?utf-8?B?UkpiTXA2MnZWZVpsRVI3NnhtbWJXUzY0M3ludERkUkpNeTJoWXZNL3NwSmlm?=
 =?utf-8?B?Z1RFWUxxU1pSNGdFa0xXazE4Yi9WdyszOW5vcXlWVjU3enhJdmVtZ0NaK2l5?=
 =?utf-8?B?NlArVXptbllQNExUUkNXNzBWTTBWdTBHSWlmdFNsSzZPMDhTNVNvNjJlMHNr?=
 =?utf-8?B?NERmR0pKd3J3OE5sVHZqeTByRTFOWjFCOEZXczlXTjRpejhOMzV0Zndib2pR?=
 =?utf-8?B?QjVqVHFLUlpwR09IVGx3ZDBoRVpSNjBrckZmSVBMcGM1S3Fmek9hZE9Eckpm?=
 =?utf-8?B?bHdQcG9ZbVJpaDJCSmNaQXJtMEMxYVBDOCtzM2ZwWGswMmxGMmJPaFR3czNB?=
 =?utf-8?B?Skd0RkhON05yMmh4cU9rMmtTM0hJdzFsK081TDIvR1NnZXBQd0VudWRmY0lM?=
 =?utf-8?B?UTlVYys2cWIvNDlvOERQUTZ0UittRmZ3NDFJK2h0MzVSY1FlOVVvb2h5M2g1?=
 =?utf-8?B?MlN3ckJNNFhzNU01TytXMEkxMlprTUphMEJuZ1RKc2RWU2R0N2RheDVFc0VI?=
 =?utf-8?B?bFJVTVNUaHhFVGZTM3RpL3NjbmVNdThGdU51RElEL0ZXaHk4K1p1MjYvVWlk?=
 =?utf-8?B?all6SEZ6d1pNMTdoejRDR0R4aVkxVkQ3b0RheFU1YXd4QVFCZUQwZXI2by80?=
 =?utf-8?B?VTdIaGd0TU1XNEp2c1I4QjFDK0U4UUwyM29SdGh0b2doUEJSMCt1YVJjSE1y?=
 =?utf-8?B?K3VkL0dzcGlKWEV3a0dUUFdGR2gxZ0lXZXZRMzFHbk5LbTIvSGpobzJpT3Ry?=
 =?utf-8?B?UDFBcFFVdlplOUlxRUlvdzBlQlhqUExZVXVXZ21aTWRmQVJQTkRVRWdTZnpr?=
 =?utf-8?B?U0ZlQ29aQ3Y0MURPK3ZnTGNQWWdOcDgzTmp5NXh6UVR3KzVOWVliV2pZZ0tt?=
 =?utf-8?B?R3A0ajg2aFU1VzdRTUJzUnJuRVJzWVBtYm00NDV1NHNoSWNmNzB5L2FkNEwz?=
 =?utf-8?B?dEo4T1JGYzIwMjBoZHF1R0U5TmIrL1M1V1pmb2xvZklzUDFTampaNm53RW5G?=
 =?utf-8?B?SHRydndNdWpIc0lpYnh0d2xpdnVJNWIzZmR1dzNiU1BMUmRQa2piV3M2Mkhm?=
 =?utf-8?B?aFFKMkFmWURlWG01NDlhVmlNYXlnb0NQaldkK01MQWY2N3RIZW91ZUhocklj?=
 =?utf-8?B?WkJTVG5JdGcvZUpsQzEyMGxKVG56TFNlTGdSTnRqTHBjREEzRmVXeG1XLytQ?=
 =?utf-8?B?dFFEaFNLN2VUWVpFcFkwNlc4WWpjYjZjZ1MvYjVZd0dJb2JHbmV4YnJpTkl4?=
 =?utf-8?B?cU44T05tUUhnR0FHWWhUclN0ZmlPRmxRZHU2MDRQY1lnS0FSNkE3QUx3VWlJ?=
 =?utf-8?B?MTlsSUFGWjhhVFBmcEZtTjhPalNMdys5OEtNOGtkb3ArKzl3bzVPQlc3b1Nt?=
 =?utf-8?B?UUY0QTIvVndEd2FJUzh3YWFIck5yaTBBSUJ6Y3lPLzJJTWE3Slp6Z0orc2Q1?=
 =?utf-8?B?UUx4STJ3bC9STEpLZUhOeldXZ2dLdC9KNjVsSjl6dWcxZWlXcHdtck9HclRH?=
 =?utf-8?B?eXNVaEFGdFh6cHRrNzc2QXdleUkvOEU2Y0U4aC9YRCs2Zyt0blcwREZRcHhY?=
 =?utf-8?B?U0JqSkJJWDc3V3NLbGpZbFlkMW9sQXBwaU1XNmZqSmtpOVEzQ0JocUZmbDFV?=
 =?utf-8?B?MmlSRU1NdXlSZVR2NjcvM0NYRjJ0RitrSDlRWG1EVHNzakVZSldpNStkajUw?=
 =?utf-8?B?aDJHZFk0OTArQmJYTk5RVTFNTlZ5SXBXRThMMUZ1U1kraG9mV1gxZUNpcDV6?=
 =?utf-8?B?WU5KNXl0M3JQRmdqbjhBZVFiaTQ1STJCSDZpanBtM0dVdmJqN2F4UmQ2QzZu?=
 =?utf-8?B?TjM4NWxzMExnbDhuV0p4WW14RFlOYkpXSWhZUkp1S2pOV2NBT1oyeVZYSVNM?=
 =?utf-8?B?OVRVb1N1cy9UcjJ1aWg5NTFVdmJYZnZjMW5uY0xPSmpuQVNYblVOTi8zSERa?=
 =?utf-8?B?eHJMYm8xN1E4Nm14NXFoeFVUTXU0ZGp2dzRCZmZ3UVZINEhaTzlUUDRIQVFB?=
 =?utf-8?B?akJIS2gwSTJtVWhwZHJpb1pvQi9lTU9RNG00U1BuaHZJQ1lTMFFycFFTd3lQ?=
 =?utf-8?B?MHBPaE4zSjRDV1ZnclBqOStlanJtV0dPemVYN0dEalhrUXdDM0JvdTk5c0lR?=
 =?utf-8?B?ZnRWeTArREVvbWRPd29oZUhvZkk4TFJ5RDQ1WjJrZXpsSENmODZadWZjKzkv?=
 =?utf-8?B?d2FjUHJXMmZtS2hhRmhmMjY5RkhiSEJZdjlKT2x0ZisrcGpkaVlKZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e15ad9-e64b-4649-ce86-08ded7a7c39c
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 19:34:27.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdHLV04m49I5/KfW+uoauh7rV7i90s6uYya78wM+6o7ZoTiBgmxW2MhV+Kc+YFTp895QNxEyDijQMMXzbnhIvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303814-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shuah@kernel.org,m:petrm@nvidia.com,m:leitao@debian.org,m:dw@davidwei.uk,m:noren@nvidia.com,m:gal@nvidia.com,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA0AC6F147D



On 30/06/2026 2:33, Jakub Kicinski wrote:
> We always used 5 sec as the default command timeout. But soon after
> it was introduced, David effectively made us ignore the timeout
> (it was passed to process.communicate() as the wrong argument).
> Gal recently fixed that, but turns out the 5 sec is not enough
> for a lot of tests and setups. The fix regressed regressions.
> 
> In particular running reconfig commands (e.g. XDP attach) on mlx5
> with 32 rings and 9k MTU, on a heavily-debug-enabled kernel takes
> more than 5 sec. The XDP installation command will time out after
> 5 sec but since the sleeps in the kernel are non interruptible
> the command finishes anyway, leaving the XDP program attached,
> but with non-zero exit code. defer()ed cleanups are not installed,
> breaking the environment for subsequent tests.
> 

Hi Jakub,

We've improved the performance of configuration change operations over 
the past 2 years. We have more patches to be submitted soon, in addition 
to planned ones.

I'd be glad if you could share some details about the NIC and FW version 
for which you hit this 5sec timeout.

Patch LGTM.
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

> Since "install XDP" is a pretty normal command a "point fix"
> does not seem appropriate. 32 rings is a fairly reasonable
> config, too, so we should just increase the timeout to 20 sec.
> 
> There's no real reason behind the value of 20.
> 
> Fixes: 1cf270424218 ("net: selftest: add test for netdev netlink queue-get API")
> Fixes: f0bd19316663 ("selftests: net: fix timeout passed as positional argument to communicate()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: petrm@nvidia.com
> CC: leitao@debian.org
> CC: dw@davidwei.uk
> CC: noren@nvidia.com
> CC: gal@nvidia.com
> CC: linux-kselftest@vger.kernel.org
> ---
>   tools/testing/selftests/net/lib/py/utils.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 308c91833239..9b40049e2dbb 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -44,7 +44,7 @@ import time
>       Use bkg() instead to run a command in the background.
>       """
>       def __init__(self, comm, shell=None, fail=True, expect_fail=False, ns=None,
> -                 background=False, host=None, timeout=5, ksft_ready=None,
> +                 background=False, host=None, timeout=20, ksft_ready=None,
>                    ksft_wait=None):
>           if ns:
>               if hasattr(ns, 'user_ns_path'):
> @@ -113,7 +113,7 @@ import time
>   
>           return stdout, stderr
>   
> -    def process(self, terminate=True, fail=None, expect_fail=False, timeout=5):
> +    def process(self, terminate=True, fail=None, expect_fail=False, timeout=20):
>           if fail is None:
>               fail = not terminate
>   


