Return-Path: <netdev+bounces-281156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Jd1J3gQ7mndqQAAu9opvQ
	(envelope-from <netdev+bounces-281156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 15:17:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAC3469EFE
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 15:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8CCD3001A5F
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 13:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD8335E93C;
	Sun, 26 Apr 2026 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BFSqUIBx"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4081454723
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777209452; cv=fail; b=UkqJ6dIx4UOfH8JueuLC3Wxa897tiP2vugpMnGQ+5/ZIXys2t5AYeMXl4R07wh1i3HH+VBwsBJDK0TKH595+FlpAagl7BN2cTctMsXUtHvlT0gPPMOodsQLuczgapPGjdJmPCsh9bbFj3c/pCR1vJzGrdT0K4aNl8MOuMr4hmJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777209452; c=relaxed/simple;
	bh=NS5u6b8rCg4gthZoBQ/StNfH9CNMWrS0zY4QpQN3Il0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g/g2T0wCUj4gTdfrSQYxHDB+WxeHIoFXaJfHLVpE/thR+DC2N0gguelAt/1GL5nS1VLKlxY863SmG//WWgUmixGUOYFmWpYGOqEeFlkYbQlYwAJquD1zSbRegbykH+EV68YY12ILjQ8uM0DUqoHUK9OPhml3O6F//REGgIKX6E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BFSqUIBx; arc=fail smtp.client-ip=52.101.48.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQd1+N+lZfQKWgtS3IzKVZy9WdpuB5VZmqfsIjXWKC7CkRlK5Ln+GJY1B/tZ/oRcCat93dIlxMtj15w4ZlkUXg8KNpDTNM2RBvsb3ODSyUD0cQe0q3hImk4CC/wInXGuRthYsVLAmCRPwKwkE2lJGif2nFlqeWjQTS6hc4HnMqzzrheZ7lFKf0scWWllcoUtezv/VYKwtKFqGOmzHywf3w3Xi6mlDHTzOpss3sXOq5c+raY7pXBd3Uzk3ZyEmb0k0dZ3vQJhXBgaqFpszQ0r7WU9gJl6Qp993QqzAR5ZxF2Yg3ZwSuFF/xfBZQuKwwsmfY66q5SKVbc/3lq1t+brGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQnKugBwUdhP6wa4HcbxntLbAec7+BT/koDkixcmlCk=;
 b=YlRi6/xzhMSgljzjDNtKU7xPY87B2czoe9xSm44QRWYdE2yY9LG/A09jF+vx7gZXHtD6UWTQO6y4QkIE8fGi+XQCyDehSpQaV/rv4T/rDdVYCJkjwCpMUHg3AheLDubh9uH4HGRxQV/SI1p+CoNHrqVhwQHIw0H70dA8jRaGxCKwy6QeMdQxr6OLb8EmMqsmYoQeRMGyu5KR3DCX6XBo64BjF+M/v4DfuDr3Qlp1BJgzwyZCesKzK77KK/zLg7UTBRVg5z9SRItXcrWihnn+EzxuR62hZ++JR/BNlXgFkCyub1Q5/ouva6nmxlH4I0kykXqigwaq8rzxU1bjH2Bqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQnKugBwUdhP6wa4HcbxntLbAec7+BT/koDkixcmlCk=;
 b=BFSqUIBxNgxaJEaaK14OgygU7Jy4V0hKsRv61RT44IHm4UlASdJ8Wgx9XRu62avn6xvq7qUM1VWJzBghmRblgE9p/7lZR62Vn2ZdFsenUTlVJ5qRAuLcBZoVntb/ZmFYAcxCc/NKRqNNN2lm4sw93L559Dkst9eDJv9O4goi31CMa3RwuGX0bUEr1eARBFL+z2/rgx4hTVJSMzr6huj0eig9bND5bxTbiMWnFZLPNfG0hYV7OsnUC1TqWTDBJlNkijLf2gyJ1Km6OKzXSvxs817IsehqAfB8cZ3V11XiQDukHCpyYsdpSBrBAYBwu8VZaMVHm/4KAgpr8aSLTW8yOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS4PR12MB9794.namprd12.prod.outlook.com (2603:10b6:8:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Sun, 26 Apr
 2026 13:17:26 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.013; Sun, 26 Apr 2026
 13:17:26 +0000
Date: Sun, 26 Apr 2026 16:17:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daniel Borkmann <daniel@iogearbox.net>, tom@herbertland.com,
	justin.iurman@gmail.com
Cc: Justin Iurman <justin.iurman@gmail.com>, kuba@kernel.org,
	edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
	willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: Implement limits on extension header parsing
Message-ID: <20260426131714.GA180947@shredder>
References: <20260425075521.736328-1-daniel@iogearbox.net>
 <b50025ba-c59d-4575-a790-fdaf0a48961d@gmail.com>
 <90c7de29-2641-413d-9d5f-5eb323cf875c@iogearbox.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c7de29-2641-413d-9d5f-5eb323cf875c@iogearbox.net>
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS4PR12MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f44ed3-a254-4ebf-0f9b-08dea3962937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P60w2X2XoUVGLQI+TTDHitRWbRzYQUE162X/SQ/21yIGUpMo9jPVta/dfOoYLwiqd3y6DylzZnFx9kWT78F7/w6rqFlJDFCLw+b1FszwZ4RZvBH3WZx6jiyBZ7xtWK2WpxvNNXWLWevCDPYgh6qdhHrt+sljMcQ+/45cClR4QImxvTTN9JVREt2+GFNKqLIuky4wdTXymXNnux2peSrNPYLHPcUbcC12jeJS4fuknmbG8bgVh8sruqz8V+RMB3mPZXf4NvqCn6gzszkzIFaMmYnOURd0pq1u9fLF/NTlyOA7S4uy7EQhM7bWBfVUazvLgX1CFOpqzEaOCirEgfzwuGSiVnPWCYtBIXNSTfw71gfCNdDcxRhfBoAZsJC3rTLomRaw9w5lJCFjH6oesVH6Zf4g/TGFFVmb0ifXS3bqSNIVRowuRx/vS+Co8GSeqBQmOaOG1i11xfG9R8Av4UwugU1z2IC+pC54YPe5dNTzm6iK8/T4Z9xuJQegFikjJWzFNsPF60T77n6lDghwvG+rPh71YlfzJkZBijbjebu7E+gN/FWrUiDwdAhCmkO3OfXYZJWVDs4fa9UVvCEYvCLvGkWxQia4SiNKoZtpLOnzkaxOFDoo17XEWl7r9yQqkbGwaOj8CYZluCA8hDAOYlCc6Z1RbunKdL8bvcEnXMe+C4xHn8N0K8Duq8J7ypOSeE3su/hx6crKGImXbSJDLl9aiJk3CM23wY8BYB/CTf3hHmUtNgbHJFouc5ehWhASMchH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rvFldd8ou4IOuGSyRU/8uksx0jonP1rXmWg/10fhZbfmp0OLUWmh294na2Ul?=
 =?us-ascii?Q?nSm/Ts+SH/OyRWwzrZfaDzTctsx+WZcD3RZbcigev36QMCH3je06zdbhR9yl?=
 =?us-ascii?Q?lBVw3flvskoBFld1zIaJy+Q/6WJH5y5HOZz2GQ67O9ghfJWYFU5yS3GYksiH?=
 =?us-ascii?Q?Rv13bb2TBk+TbEyIvFKnBnx8bYwFL0wd5epsjvuLJm65eomkYn6uuDy2MHJV?=
 =?us-ascii?Q?deucmSTr0aS9ilWjDdrHWfH5haF2qN3vasf6iWqiHlRZDGuZcgr2fM921HO7?=
 =?us-ascii?Q?5VktoM1mhdXFKbAFW2EgL1tvNoEqULiajh6TAp9YCfcgFUj3Z7cgCcd8+SLE?=
 =?us-ascii?Q?b4GM0pdimwZf8e+/D7WaKfUxeLZKMDvMzZ4xevi0/pxzVbhJFyixsqYOXuRn?=
 =?us-ascii?Q?BXzcGs8XXudpdA7vsUaCEzhiNikOorPm/R0EWcnvpacsjZuhMMQLTwMegw3D?=
 =?us-ascii?Q?PTvsE5dMVbqVxuHUSEY4ybnYjZl8jf2IERbvF+r8mt7OCY+2P/T3YiGyQfOE?=
 =?us-ascii?Q?0TlXq1GD2HfvNO3mFKeC2atziNoyfwHf9Tlf4M68kbfFFaPd6LHlwmCo+Dq0?=
 =?us-ascii?Q?UsrdITPYXBRCVjIMKw4m5C1qGHrlBj4prCGu2GoGJ4ti6Qvhhqu9Cse0AZJr?=
 =?us-ascii?Q?K1idh9/53NscLFIwLwwZlCjC+bB+Zysz9Kr6vzAKq1Ri/bhnd1RzDERbqb5F?=
 =?us-ascii?Q?QOY81FabPqW++dgj+llF7CSiEBNcCWPjyUydLfrQ+5xVdFOR0tdgB4Dn0xKn?=
 =?us-ascii?Q?ctNcVSEYGsWDhqANz49Y/b3aC4yT/PugbjyprYeTJaojv8HXeCyMxzQWDBnN?=
 =?us-ascii?Q?CGHK7hJedLLE9NBvJQG8oIrXm+66Cy5IvTzlR3J6xoDT0T91RVGc+x8ZUGk+?=
 =?us-ascii?Q?S8KvVvRmk/RrkFfJPKUrjxnjLhmYpoqKIUi2MwyV8ohfyH2DUuK95ajJ8+8/?=
 =?us-ascii?Q?NUoUIg56wRjLck9Vy6oy0WkynGXjpGg4aBilpL3WNlCqqy6I41/Saj1E5Zw9?=
 =?us-ascii?Q?kpAL/vVqqDAg9r92agfgzwxcF30z6iT/fCM2Q5EKZOsNFqALD+X+qEcPW/aS?=
 =?us-ascii?Q?Oxm/G7+OgZW8CA2PMTXGryb/93FjQc6p4mzerojHsyrh4LaV6JhL/jNtaZIh?=
 =?us-ascii?Q?GrDIWnTgscRHVKxBK012aHyGDk5svmh0rdRUXX59ARFY8MewAC4hvgKKrEG7?=
 =?us-ascii?Q?S2BEItjFK19ZrfFqNJLUE0Q78xMQiMuXJHkuer9w996wZ0pGqtVgZHDYeCxv?=
 =?us-ascii?Q?oSXZqsCHdoghWdpybZgR8yibBt2lgn/3E3QdxFI4jKloXWg/7E6KDk7DJKbi?=
 =?us-ascii?Q?LUOJLCK3+jVcapJ5yERQf4DL3OrJlw5P9nRYquWGvaH4fOywkX9Zq2Fpvk8z?=
 =?us-ascii?Q?zXHHn0xsDdfZSfV/9im+1epiyugr+FT0397Nr5CnCOJAHdMuq5YNE/6T+MtV?=
 =?us-ascii?Q?Cd5Z99EjQ06GBIsXBYR9Z1qWYDRZIBlUd61Kcvwcc6XZ1UUfe0LvYl/UIbvo?=
 =?us-ascii?Q?K8SdbAr/xaUXbH4Qxbr4UmaxZUmGY6aeIgTh5qAUi1VULQiz7jVVai1WUIo/?=
 =?us-ascii?Q?T8RD9JHI/LSg74AexWBvqh91wcp3m5sDfA940VgyX40TMbeq2n1V+/duPtpX?=
 =?us-ascii?Q?NvsxWHOwPHE+0uhviaGPi9/SMMrWQs2fg5T209BvVc3qFEwFZYPzVntimfVB?=
 =?us-ascii?Q?dA7mGA6n8VJZwt5672Pfq+rSRQFG6t4ySVS9T5xvO01HraQn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f44ed3-a254-4ebf-0f9b-08dea3962937
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 13:17:26.7546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvF5Lo2P3xW9Vp5zyVE6Pf17Xj2q1cyGb8jHUknQzIC4HP8Jk2iG4RCXa43VBHuzvyRGbgnSEsX5JV9Wzxz0Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9794
X-Rspamd-Queue-Id: 8BAC3469EFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281156-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[iogearbox.net,herbertland.com,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,herbertland.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim]

On Sun, Apr 26, 2026 at 12:38:31PM +0200, Daniel Borkmann wrote:
> On 4/25/26 12:19 PM, Justin Iurman wrote:
> > I've given it a lot of thought. I came to the conclusion that we
> > should use a hard-coded value here as well (just like we did for
> > 076b8cad77aa, with the same logic), not a sysctl. IMO, the main
> > reason is that it provides as is a suitable security fix to be
> > backported, i.e., the max value is the max number of EHs allowed by
> > RFC 8200, Section 4.1. Also, we remain consistent with
> > draft-iurman-6man-eh-occurrences (I think Tom is about to send a
> > revision of the series soon for net-next). What this series does is
> > not only enforcing ordering, but also verifying the specific number
> > of occurrences for each type of Extension Header. Which is totally
> > compatible with what this patch does, i.e., limiting the total
> > number of Extension Headers (regardless of their types) to 8. I
> > guess what I'm trying to say is that it seems like a good
> > plan/compromise and that the aforementioned series would build
> > perfectly on top of this fix.
> 
> Initially, I had a hard-coded constant (when it was still 32), but Eric's comment
> was to rather go with a sysctl, such that if someone unexpectedly complains, then
> there is still a chance for that person to fix it up via sysctl without having to
> rebuild the kernel. I'm okay either way, but presumably given we're now being more
> "aggressive" into lowering the default to 8 rather than 32 then having such a fall-
> back is probably better.

I also think that 32 without a sysctl knob is fine (just so that we have
some upper bound), but if we go with a sysctl then let's make sure that
it's compatible with Tom's series [1] (I assume he is going to send a
new version).

AFAICT it's possible to create conflicting configuration with both
sysctls (e.g., "enforce_ext_hdr_order" is set to 1 and
"max_ext_hdrs_number" configured to less than 8). The documentation
should make the relation between both sysctls clear to users. It can
also mention that "max_ext_hdrs_number" might be useful when users are
forced to turn "enforce_ext_hdr_order" off when dealing with hosts that
send extension headers in an unexpected order. That way, they still have
an upper bound on the maximum number of extension headers.

[1] https://lore.kernel.org/netdev/20260314175124.47010-1-tom@herbertland.com/

