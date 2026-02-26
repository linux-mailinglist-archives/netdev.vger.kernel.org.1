Return-Path: <netdev+bounces-261210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHRpLsP9n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:01:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FE51A2327
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2CBD3006222
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFD7392809;
	Thu, 26 Feb 2026 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Upzz2aXo"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2599277C86;
	Thu, 26 Feb 2026 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092851; cv=fail; b=e4qHfb8MkmTwEzGkJJ31uo71xb0/96jMFBfaX3wqIu7lmY3Fwq+GTAKRwYS/mjd7ULIA091QBLI0S3BIm8GUMdcRJ4uLyBMM/t0cs3WIlOZBfb6QaXnBp/ZtfUBv6gmXkiBGDG3JZsyXRf275cT3kUu7YChstBxI/px0Ki4HSEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092851; c=relaxed/simple;
	bh=gWNOr1i4YQZx6sTAGTBQpDRrTP+ohb0Jv+UT1K/klxs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rjSjWXXgsaM/UNnuHTHdCxebvSBUc8WSn+F5XHghBHNx4EgGULZ6f8eLI0SAAZKuwq6C7dWaYPQlXmhHvUgySxLv692SohS1SuC5vxMCPT3at4tPTaZYrN5vC2iVujEilkxL5hAVQZC1eHDs60WwK7adurjVr9oXrfk6ZhBHnq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Upzz2aXo; arc=fail smtp.client-ip=52.101.193.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcDax5CPwq/CKYMX/CqwKW8wTrAlJ8SEn3EgTulGPmKCM0cCKR+C7EFxjZgPC7a/Q5DkaVd6XHR8eMMAqrkbTaP+JYY0uC8Axmo2euLmNQywNGknMkXTdsyzjiZ5j0KijNC1mriKe9yBiqYQFANV3KKtoBAisd0A0oOK2+OPkGEkoVAcShyh0clcN79FL9mATGyOU4k4dPdOJV24sZjxQJ/F/nhF6Bpc1FW0GfLdbWHvzxzTW/6qF0K2AVwJWlhT3Pggo4A0T7HJQQkE5y9V9VJGjVQ/Oh2wUG4ls+RvP3TxhY3qKASySzIGiI/cukH3FDsFDueY/6NsqZn7Izmn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbrSP/PxVpe/9RVg0I1UeGbr8h3niVWwjsBR13qBsDY=;
 b=gN/c34pnj6TEpH4rzSz5UTV/Hs513lCKhguxa4+4UQyR04ddPyOIRScjsjFJmtNhwi4vTjSyeChektwO0dxxHUaEBH/SBVdSTyZprssiVpyaiJnQZPKVsMojXEULNMoiylhppqDYLcGCtrB2fKwj5RPHwef9LwgCYYoapFunFxCgcZxMmzB3pa3bE28ByiKFXpcNlaHQGmN69YTOLJZSW6UFs1cbN3122dQH6CLEEqciNKh1WVlcYUgWiHbthuRecYoBOsqHEebYtts5r/Hp+gFj4sSpAJsHC40drniP4QGdEAwjU/boax2Mbd9IkduGYusBcf5RMM/XO0meKjl6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbrSP/PxVpe/9RVg0I1UeGbr8h3niVWwjsBR13qBsDY=;
 b=Upzz2aXoUz8PN/Y09GeR2Y9mpCgyzNsSi7TYupF6sv5oU9HfjW5cwKr32fgY2lDO+1G/ogmhn1K09/1NgVPvv3yz771b5P+kUZROjDJapxn6KbNNvrA38sEVYDhZkx3BLeR5GpaEYmGXgtcb5guBSpb+GzdGgUAq1xTapNL1raHMcjPOS/d7qpbMRYTdlAt68GDkGj1rZJhr7XnzBW6rSPxAvl7ishTBEwXIH8vnkKaB1ujc57i/eBbFV1hGVo606I9KiwueaeDIxkf1+cLuCQx+rWzEmFyWnAPR2DpuvymLMr/qMV+ISlqJQLPDIscaGgsswjMe9ijx4N3PPWseCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 08:00:43 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Thu, 26 Feb 2026
 08:00:42 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@gmail.com,
	petrm@nvidia.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH bpf-next 0/9] bpf: fib_lookup: IPv6 output routes enhancements
Date: Thu, 26 Feb 2026 09:59:54 +0200
Message-ID: <20260226080003.524935-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::20) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a97b2dd-8586-4fb2-68fb-08de750d2395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	D8Bz3SEHiVaZHeT9yPP3FeSBEM2MXaKhk+7VyxqUmAfDSAed5C3dXEWbDd5bBmwlUsVOiBodvP6MTrYJQ1MmlJpRe+Y8kMyVyU3lESjGhB2azyyOG+m67yEilrKArzchS2l1bvtB5o7Stpx4voyI7+Xa/q+dx6kPlIwEmqp0C7FPlauNbFe+qb3a2rxrAm2AuGLowOdcIKwRJ7XAfmSzvQXsu8FccFWEYpiBKnurcPkxyUoWzmfCw/XHa5aB4l81C7AvO3NfTuCzdFts5ghLqdrVgacAvWXJfD5MuFpWqvBtBpCPBP+jTg6smLE/SZ5Mty/6y8FaFtA0YkR+mH4d69GLx0s/DbCfZw/mESFqf3G9aygIH5J2HfjES+SMHh6YNP7j6ZCp2FBATBsljV+IebOqA6mkngMNiG0yPiaJAqFcX6bZ3hI0y1VBDQw/R7yXmJVGoci2YSS6T96JMwHnf3+cCfZL8wMINcgFg42UzEcbteEGZXrZ9F+t0k/0hP+bBKteEx1eUxAUvQIb4rZx1ip28TnkFAR4kVDbniSZTTn49YXwJBnFL2ELCJtYY3iTJArWyvzvru9h/7926+zbIDFr/7XMKHla0C0gvITkxJU+mt0PIGirbq4Y5dBvNEMbw0/OFCA6hZByr//ULuuDIMcwFwbLEYRBX8Pdi0d2v4pGU5/jpd3RwPMX0qqDr5uJEh6yLVDkhgkTdQQH3vXHHY0qm99klmxAmedFtnDczDg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDNCS3JsNHNBVWhNTHlONExubm9lTlhESUVSVDhodEdCOGlHREhsVGtycjJ6?=
 =?utf-8?B?Y3pkTFgyaVRYKzk2b2QwWUtNZ1JkY0NSMnRXa0I0SzJtZkdyY0IzU1hWOFkx?=
 =?utf-8?B?V05ydlJwSFU3ZDJVdGRYSDdVZG1Wb0tXWEJRUUZ5Yi80UWF2SXhxcitLV0Ir?=
 =?utf-8?B?NGNKalZBSnU4UitaM3dWVHdpRFBTOU9rcjQ4NVVOd3hvU0k5SStYb0lGSmN6?=
 =?utf-8?B?QzkrWk1pY0R5bWhkME9hRzg5K1c1SktvVFg1MjRHZG50T3JyTXJrY2NoVFVn?=
 =?utf-8?B?Ry9RclJWeFcvanB3ajBzQ0NoeTFFb0NScVRDYXdWMHcvcjFER0grU3ZUeUtN?=
 =?utf-8?B?ancwcjlkSi9ZY1BIQ21vbE9aUU5vRlFBOWhvYlZpelBhb0pYTWxvTEFtcFpn?=
 =?utf-8?B?ZTVVelY4S3VkMm1sNU84N2E1NU81MEhWbzFzOHNxeFdYbjh1VWhrREhrSU1K?=
 =?utf-8?B?ZkVsa0c4WnRIVGc0WkVDVTA4UEIzWTlUSUFoRlVkQnByT0pnN3VqMUhoMU9o?=
 =?utf-8?B?dDE3VmpsTDIrN2dLUEF3ek1oR0VXclVGbWluVGtYSmlpM2RIckM4QWhJS0FR?=
 =?utf-8?B?RDFrVGNRODF4cVZhUDJzblVsTG44czgxdUhrWnh3UDNzZHVhbmtmUUVTOTFU?=
 =?utf-8?B?S2JSQnRwSTdsZzNYek91bWxhUFdhMGFlRVZ3akVQWllWd2lFalZTM0p1R1ZI?=
 =?utf-8?B?MnQ4ZGdJTDljZXZEU01KUEJvZzBPb3JUOVlzN213RnF3WldMeXVNM0dhZitD?=
 =?utf-8?B?cnhkcEd5MVpobmZETC96OG5MZG05ejZnSURpRk9CbUYxWXRlUmcxTFpJOHJK?=
 =?utf-8?B?c2NnTXBQdXJVYlV1Y1pGVHNJdmlITDM5dUxCSzJPRTUzUVcvMEhoRWEyMWZN?=
 =?utf-8?B?MHNzM2hQdzlDUXVmZXJleEZMSmRwRFRreU9zMU42b005ZlFSSXl3dTJBTXNn?=
 =?utf-8?B?NDgzU3NEa01QNzluc3RCaGp1WGh3ZzlQby9WR0RDQXlDenJQMXlSUGdJcTk2?=
 =?utf-8?B?SnBtSEpkWC9RTXpRczhsdXBSQmxhZUxJQW0rZVdWcG1vU1RuVUhHekh5YnBl?=
 =?utf-8?B?VTduTURVT2xUTlN3bDdhc1Y3dytINXd4Y1A1WXRZVXZOYTVobXVGbjZZMlJm?=
 =?utf-8?B?ZGY5dkZSUFY0VHdNWUYzc3V5SmZ1VVdYcFI4ZWJZWTlLTzUyR04zTEw5ckFl?=
 =?utf-8?B?SEw1QU02WDJjeWtwTnFSNHR6QlJlRHJHeVF0SmRRUmZUcmhSM1g0WE5yU2ZS?=
 =?utf-8?B?eUlvbkNVVzJyK0szay9VcUpoZlEzOUhTbnNXM0x4eHVnMVpUTk8rY1FwVzRR?=
 =?utf-8?B?Z2FObE9GK0pJNEZNQTl1aVFUS0JWcHFvRkZhbFJPbnBKMUJoRHdYM0dGRTFJ?=
 =?utf-8?B?UElWaU5rTUx6eG9JOEJPOTlRY2tZay9KSC9xMVkwSFV6NFkzcXdNSjN0UENS?=
 =?utf-8?B?R0Z0UFRGMVF4RGM5ZkZuVjVzQ1lhT0Mwc0tUV1EwRVFxZTArNmJNb3k1TnRZ?=
 =?utf-8?B?QVB5SG5sMGdsSVgzcVVxODRnYWZkaCtyVG5QZlFrZmNpME81SW5xWXZMNDRk?=
 =?utf-8?B?YmpNREJQQlBrN2ZCRW5HYWJaSnZuN1lEZVI5M3paU1JKMWxyeGtUZ3kwb2tS?=
 =?utf-8?B?bVJwYVp6eDRNRFZEYmZyUkxzZXhOaXVHY1Q3SDlxYm1NNUk4WVdHWGljZGNi?=
 =?utf-8?B?M3RRdXI5SnpqSGRYc2RYa0JXNEduZExVTEhEVFM3QkUzbUVHQy84SGlMOE0r?=
 =?utf-8?B?WlpFMVhKd1NMc0xxZThRNng1Z1NhZjF2M3VlM1I0UmhCZGpwNm00TmppZkNK?=
 =?utf-8?B?Tm13RlJ4bm9NMURCSGgvNHM5NE9lU3k1bVBDVzVGeUJ4czRqeGFINEpRSE9w?=
 =?utf-8?B?dG9qMDZMMkJUNlVvNU5Tc0VoTlNwNmpzTG55OHZ0ejQyY0RwNWJUVWtqS2JS?=
 =?utf-8?B?K0dWMVFPUXVrc3d4b0E3OEIra3k1WmRidUNwQjZPLytURndkNjBscGhBMXA5?=
 =?utf-8?B?Q3ZZMmxRanBQVTZhV29Kb1NkR3RGQkVLVDJSNWoxcncreUdWTnR4WWIvVHJq?=
 =?utf-8?B?RDNhYXB4ZVA4TzNKSjRQdjRaV1hSVUlHYWIyNnAwR2IwMlVlRWVQeWNURTY2?=
 =?utf-8?B?OHkzcThrTmtBamV3dzJKS2l1U1VXMk11M2ROWTZLT3RXYWswUmRINW1UMkdQ?=
 =?utf-8?B?Y0Q5THRldWpIYTAwNHNSdmFFSEp6Y2sxWUVVTVc0anpRbCtOTFB5ZEc5TzMr?=
 =?utf-8?B?d3hMaXZ3dFNlV29rRjJQdXVpdzIyeFFqZkxLTXJNNitOYmpseXBVdUxsOEhz?=
 =?utf-8?Q?QDVhcZNa2+DH2Rw4Bh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a97b2dd-8586-4fb2-68fb-08de750d2395
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:00:42.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiM4IwhTjiZzSg4CNQqJtynfeZUr9g49cosRaBuzgc6TwXUr0JOTdUyu0vnwgUHayuuT2L6GP4e8KbQN9lDIHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261210-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[frrouting.org:query timed out,ietf.org:query timed out,Nvidia.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,nvidia.com,iogearbox.net,linux.dev,fomichev.me];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 24FE51A2327
X-Rspamd-Action: no action

This patchset performs two changes in the bpf_fib_lookup() helper:

1. Patch #6: Aligns IPv6 with IPv4 with regards to output route lookups
(i.e., BPF_FIB_LOOKUP_OUTPUT) so that it always resolves a route whose
nexthop device matches the specified oif.

2. Patch #8: Allows output route lookups for IPv6 link-local addresses.

The rest of the patches perform small changes in the existing
bpf_fib_lookup() selftest (patches #1-#4) and add tests for the new
functionality (patches #5, #7 and #9).

I believe the patches stand on their own, but below is the motivating
use case:

We are researching the possibility of offloading the data plane of the
Bidirectional Forwarding Detection (BFD) protocol [1][2][3] from user
space (i.e., FRR) to the kernel using BPF. FRR already supports the
delegation of the data plane logic to a different daemon via the
"Distributed BFD" protocol [4].

When used in asynchronous mode, the per-session Tx logic of the protocol
boils down to periodically sending a packet to the BFD peer according to
the negotiated Tx interval. The simplified diagram below explains how
this can be implemented in the kernel using BPF:

         bpf_redirect()
     +--------------------+
     |                    |
     |                    ▼
     |           +-----------------+    bpf_fib_lookup() +
     |           |                 |  bpf_clone_redirect()
     |           |    BPF clsact   +-------------------------► swpX
     |           |                 |
     |           +--------+--------+
     |                    |  skb->tstamp set according
     |                    |  to per-session Tx interval
     |                    |
     |                    ▼
     |           +-----------------+
     |           |                 |
     |           |    fq qdisc     |
     |           |                 |
     |           +--------+--------+
     |                    |  skb dequeued according to
     |          veth      |  skb->tstamp
     |         bfd_tx     |
     |       -------------|-------------
     |          veth      |
     |         bfd_rx     |
     |                    |
     |                    ▼
     |           +-----------------+
     |           |                 |
     |           |    BPF clsact   |
     |           |                 |
     |           +--------+--------+
     |                    |
     +--------------------+

Missing from the diagram are RPS on bfd_rx and XPS + mq + fqs on bfd_tx
in order to spread the BFD sessions (can be thousands with milliseconds
Tx intervals) across all available CPUs. Also missing is the handling of
neighbour resolution (i.e., upon BPF_FIB_LKUP_RET_NO_NEIGH) which is
deferred to user space.

The per-session BFD packet will be injected into this loop by user space
when the BFD session is first created.

The above loops works well, but we have identified two gaps with respect
to the bpf_fib_lookup() helper:

1. Forcing a lookup via a specific interface. User space can ask to form
a BFD session over a specific interface. In this case, we need the
bpf_fib_lookup() to resolve the destination MAC for us. This works well
with IPv4 when the BPF_FIB_LOOKUP_OUTPUT flag is specified, but IPv6
does not honor the oif and simply resolves the most specific route. This
is handled in patch #6.

2. Lookup for an IPv6 link-local address. Related to the previous gap,
user space can ask to form a single-hop BFD session over a specific
interface and specify an IPv6 link-local address as the remote peer
address. The bpf_fib_lookup() helper currently forbids lookups towards
such addresses. This is handled in patch #8.

[1] https://datatracker.ietf.org/doc/html/rfc5880
[2] https://datatracker.ietf.org/doc/html/rfc5881
[3] https://datatracker.ietf.org/doc/html/rfc5883
[4] https://docs.frrouting.org/en/latest/bfd.html#distributed-bfd

Ido Schimmel (9):
  selftests/bpf: fib_lookup: Force specific interface indexes
  selftests/bpf: fib_lookup: Enable forwarding on second net device
  selftests/bpf: fib_lookup: Allow parametrizing ifindex
  selftests/bpf: fib_lookup: Allow testing for expected ifindex
  selftests/bpf: fib_lookup: Add IPv4 output route tests
  bpf: fib_lookup: Honor oif in IPv6 output route lookups
  selftests/bpf: fib_lookup: Add IPv6 output route tests
  bpf: fib_lookup: Allow output lookups for IPv6 link-local addresses
  selftests/bpf: fib_lookup: Add IPv6 link-local tests

 net/core/filter.c                             |  12 +-
 .../selftests/bpf/prog_tests/fib_lookup.c     | 117 ++++++++++++++++--
 2 files changed, 118 insertions(+), 11 deletions(-)

-- 
2.53.0


