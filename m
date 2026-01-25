Return-Path: <netdev+bounces-253168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCVdEYkJdmnKKwEAu9opvQ
	(envelope-from <netdev+bounces-253168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 13:16:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE34807A3
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 13:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABC303004256
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6D12309B9;
	Sun, 25 Jan 2026 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nOa1gDfl"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707FF513
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769343365; cv=fail; b=AjMXBo59gRtmjYpEYRfGR9ndoyKQTMc1yUxCzvPSe6v3EXN0lA0gGREFTZVUxdIFHYfL3hDOKTuvIXFvp8T+z1W1Wj9n/KeXIUoz4kWCsm9jDpwvzqV0MTMJheIYej4sjaZbtbzOyEYA7Um7rovug4Rt0Dz3IkieEnMQuHS/UgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769343365; c=relaxed/simple;
	bh=mZla7okCHRoBJMJRDHSqX/zpci518EmFMl16ajgwhuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UwejTou7AfDBef8SSsUW1x6Tq+Yq+U47EYdK+OpUdSPcN2ayNSeD8HuvyqAgjz+bQ64g/YM9EJm+0A4eYYRcfs02nuMBRi7uxv5pk1CDe4ctCn/+HjCge6R3p9RSZSwxPHZr9RonJhYBDIJLOmSIeFntQXVS7KVRGCnAfIQmJv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nOa1gDfl; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i50qv7Xp0KrqQ0xqlwSg2+CJRaed78YusOltbwdcpesu9oD40RRrTDs5AVgHxVSuqxO+gJ70P4DixpAgoch5KZi5jxxI0k5InpChGOQkzunxbNpgkqdDe0mrDqGU5w/TOV90jJD1cjTzb6NnyXCO3gz7Q6tCe+R4WYxkuzq4IHKBQP2BBQHyp4rd6tiLi7VwfJgIh+t3tFDSoI2onjrNFMTJPKHlpcy2qKlsoThUfG/CkpWatNvP/neRhKc7C1P8nMA/AtxHeuXm3eJBpJ5CGCE9AGzJdhdAy7hzH6FC+Fq0yoQqiQhLuXw0mAbQDCO0OeQTnHlf+4t/V9NeMdZm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZla7okCHRoBJMJRDHSqX/zpci518EmFMl16ajgwhuI=;
 b=EGNdRFKNVJrN4/I3e/KCk21ZMwLyKVeZ6RvmnLDetOm9hjph6VY3zHE0r14tnVlFQYIV5Fb9mPl4d9T2JVzYWUd2Bkd5JO8vXsqPHhbAXeCzK/GQ7eW49jPuqsH1JxWYkqkfuRgA0UMIeSwcgtX+PO+ycGDKDrgG6iCpv8VeNRUhwgfbwNbGJWFYfmbciYEacJSJUY002IQbyzJ3YaBtuXDZUcrkLnVL9YQ4b6a3g2M4Qt/dX2CbbUBm1GuWosaGgEPxrSl3V7S5wq9PZzTHgD3BXOkB0CY6tlsCu4VlrwqR4MqKeFGSz/P7pGVcJw3lXpj+Ri0nIzZ6L0/KGh+21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZla7okCHRoBJMJRDHSqX/zpci518EmFMl16ajgwhuI=;
 b=nOa1gDfl9V2pzO5JWpJbhfWN0qaGOR6760h+RyThaANVrI3t4LG0ww//EM3aCbUqgbtQP/NBdFEkOBwYb8UMvmrRQm7e17KTl/608q5bZNSkcZScs1ULjXB5nGUClO4OAZze/ksVlvzOaNctN0+5JDaJ/TELi3lhsroeuhKWRm3h99KcjtZ6kNyzed/G+YYYdkz0Ar6MxtSEvvr1L5m4dTDvPYyF0M2krwl1XDQAWd/5WpNHIpEHRzVBi8zOG/EkvR2M7Vm0MYpUV9qASBYzUPRUPBeUwXN855o5Pb7HzH4zwi5hKfBIugFtSeImbMcK3vl6sLdseOv9OAPGqeu2KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 12:16:01 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 12:16:00 +0000
Date: Sun, 25 Jan 2026 14:15:51 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Pirko <jiri@resnulli.us>, Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] ipv4: don't call inetdev_init() if device is no longer
 registered
Message-ID: <20260125121551.GA83275@shredder>
References: <7fe2645c-680d-4fbe-981b-67a041f0d9c9@I-love.SAKURA.ne.jp>
 <20260125085835.GA54633@shredder>
 <29ffd5ac-07b1-4424-ad3f-8304a28d2946@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ffd5ac-07b1-4424-ad3f-8304a28d2946@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ce7cbf-6c07-40f1-5e9b-08de5c0b80c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?36EZS9IW2Zl0GSlLVGq8PwaOAR62OYeqUaNZTltJqPWAldHXEcq+cvuYWRzt?=
 =?us-ascii?Q?T0tmmHkgakiUbnImR7wfOy7aO2SBk3Ex5FB/ZfQPrmqxEgeEI4LYgzOws21t?=
 =?us-ascii?Q?CPNUA2QL/VjIEYPmHEH0jYv/0QOmxF4B582n+eoRa3vi1w1sgDvDn7jyZTZc?=
 =?us-ascii?Q?7sqDwuhNJLcIdsbHuhxnh3I16zCLa4lTXj2mgbPaqk1y/odnQgexppPblWUU?=
 =?us-ascii?Q?cZR2mwhIZV3m8uZ3q3DhXC3FBwwP9LLsY5Eji/o3ViQLDJm2Td/DjjuAMCrG?=
 =?us-ascii?Q?OGBway88qiwZNMYjSqz35RGjmoy/XV3jFoN6pKuXTkvL/e83t5yTQBGuvLvv?=
 =?us-ascii?Q?g5ktzVmgDBcX22TsynVvXNfjU5RZPN26dLd0nZEuqiJZJ9WaCPhXnSLqr+nI?=
 =?us-ascii?Q?ZRukR3kGxJxeLKtjg8Cv1JVml7j4DcFFz2KqSZPedskpCi3SBo5NCG9OrhyY?=
 =?us-ascii?Q?l2PSpVfQBwazchiNHo2U92Ks795+/bV9x0t7GjhU2VzN/r3NFgnd4yY1TUhK?=
 =?us-ascii?Q?LbjKPFTS7/nsltLFnUMdIIav+27FNHDkCcsbWOhNURbf7IRFrOLMI1Il4jlW?=
 =?us-ascii?Q?mbgZFl1MGmxE8CxvWraLjJUp6e2ntsveb7BdTuIAUwIEWJ/vdha2Y9jyRYf7?=
 =?us-ascii?Q?qPo1ES4gF9SsNFFxP0Eo5ocvCgE4e+oFxnw/KNdsMCtWCHloYHAuW4mS1HWL?=
 =?us-ascii?Q?gZrdtC7a/mkGcCJcPtruXe5NKtHcPaTyP55wTFsaeOXPIMldbC7bgzjMDmYR?=
 =?us-ascii?Q?ZsT3melf/e+1vka5G7D2pFN6DOAvBtUepbpQO9TTJ7RXJ2MTdW0b04byvsjt?=
 =?us-ascii?Q?y5zKxBdjSg6bN6yEfFbKaT3IFX89XEOZnBzta6JjKm9L1BZ3AAT8jVoKZSHw?=
 =?us-ascii?Q?b4LfmpRL6KN4mAvgZFy81I2unWQrpD2/LWn1GFcVCoB6rJaFVvHwj4zQQmeb?=
 =?us-ascii?Q?IlD8bcO4W965K5J2qY7fRtKxywcv5qvhgmlavn5SGHi3mWynx+T0xgvXUifh?=
 =?us-ascii?Q?2xPGll05qz+skmkpD6ENnmrMcwUx7U1/0PTkkwba+o7fZ9qKBlEkKxtEJUC+?=
 =?us-ascii?Q?5QpjhwNcdZgTtAFWcNzV9o9GXvjahw+w7bonbyOlQWab6ABK2wO0W6KxAfJx?=
 =?us-ascii?Q?VELvs+dhP8/Ikqcspx+S1iWSUwuZiIMf1mjzahR7vzLDKPmIi+Jt2sa0ZHmx?=
 =?us-ascii?Q?8qJHOTU9Lg5sKdCkAyARCkXnZImg0al6UF9GDwz0JPmEpJJCPK32AmMf+Sy3?=
 =?us-ascii?Q?fCm4LFTcBL2CjmYBOH7dUfuG6sSEFtyskuofK3UpH5UAmrPGAg9kEfZ/SMfF?=
 =?us-ascii?Q?x41rREvwSFzUWw8/u9Pb3vIPUWM/HQwi0EuWQus0K/gxHAPBDzTGvhE67UE4?=
 =?us-ascii?Q?+4eA/5mpvzS401a7Lk30WuAOF01kaqWgY/jNC88pJvnrX+GrQoVra8syY8hH?=
 =?us-ascii?Q?NwplflDcOVoDZkt09acLP7aBxsizBuSyw6ig9Q1G2Si45AhHo5IXm76rTH3M?=
 =?us-ascii?Q?ZmjUbmhnoUyfOBQ+Wvm4DDDsGIpiGMlbtiZ6zBVn/uVhR0AgDGZvyl8zVhmy?=
 =?us-ascii?Q?SQDyAq8X+cMpD59oy8I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?37XZ4PFSTdUzz+ZwZKVWtcNHrLbdtvhFKc4eFeUxG1y+r40TmylUrUjpboqA?=
 =?us-ascii?Q?P+4yfUCQsB/nCwkBhWffmIVStucc4u+yits70eO2LzndZOYmY6F06ffZHdV1?=
 =?us-ascii?Q?1OKk8ZTH+c+5hwSQfAxfYO/wVdIgqDkQJRps36FXr+VNbekkO2RFtSb/6CVd?=
 =?us-ascii?Q?VRMzvMlczHBPQ8N1OiPYmtrimrT7He4kxlUbn6FnR65EHVG1gcjbu9Ndgz9v?=
 =?us-ascii?Q?fdniuUQJvdiQKqyN/KtpfOAmQ/sc1iFGQJeuyjvdivOeHECK+DJicrQRd1md?=
 =?us-ascii?Q?cvrmFSDZ0lS7pVd9iAbhlcYK3k5bnj+OglEdPwfRyg0n9h6GewLMP2Xu02jp?=
 =?us-ascii?Q?Pgw8mMp7q4NtymjauiLv6p6wkdXSm8N1ME0Aygx3Mrj9TnPJbXAQSaWm1AoS?=
 =?us-ascii?Q?cFR8yVN+Lp7CNQvoUzJlBTZhYJ1WGZzr0oHTrrkw4b5AJX0Ingf9J8teOcVC?=
 =?us-ascii?Q?M69VthtINDS1ouuBjutPrFQ3NvBCVcmPMBnkoGkmJodjSpei+fKb9EkhAYSz?=
 =?us-ascii?Q?Nkotiv6a0te8DhsGZsR+hYV18QpuiHqhkLEiwjz48Doz4gDUxyxE2tH9M61M?=
 =?us-ascii?Q?2BGfYUtDRvP7QJXx4y9UKXPOJfacaUFFq+rTVmswJjNzWlRj3OyXB25f6xBw?=
 =?us-ascii?Q?JQq5I3O/OL/b33tC3zoyBAvQtXNdAyV/RUzPMLl4C5qvRvVxAEtkn8YGC6PR?=
 =?us-ascii?Q?sdj1xurvE9ZsBBcwoF9Ku+B+XVl315cMkWQW2Ouq0AueqNnpJFxWA9EAZdDe?=
 =?us-ascii?Q?dHW+S84NjmQiswL02eOgEuNJgJDPV+77a/03MF82AUTbB6Q4tKodopSFl01P?=
 =?us-ascii?Q?MXGSbESLOdrVov+c/v/sankxun+6iWn/d4tJV6m9Vs6nOKT6jbW5H7Mmpiiw?=
 =?us-ascii?Q?CMGLNXrzOIypbTlRlgIOYmtT5hHtVoiFmMlTfPDHfe+Kapj+FfQ+8FPRNxiR?=
 =?us-ascii?Q?Tx/uONa0LyZcy6lLoVeCVqhedSsYHq1PXgvVtm/Mm4S6UhWedtBnc1ukeKBP?=
 =?us-ascii?Q?x9tSuFjWZcRVdgsPcHpM+Hky8bqemt0+Q3pH5auv4GHK5abtrDuJVkW18V7f?=
 =?us-ascii?Q?dMCLWbrKyQAAX6Fwo9DXEfOj8r7g2n19LwECvkcOeBb3FalIY2kcVExPf+r0?=
 =?us-ascii?Q?iSaZUesuE9RevyLVaT29Y8cF5GOr7wl239E09jdkFGdA83kLhycTfCiuh5dz?=
 =?us-ascii?Q?i+2xAmoqudP6I5TtSizDk2NWEIuQKNOW/8gZhssHhWwjtT+NtqJVUuqE32fi?=
 =?us-ascii?Q?vCl2OMH63Bqj2rG/7MWS5NwQxwpdTSEEPYG8p3cEUdC0jowTVh0k7rhWg9dp?=
 =?us-ascii?Q?T7r1C+nm1CN+ctvobIXIBaGkg7N8ryA9MAKW1fcsrLjX+UM+RHVhHG3Jkm9D?=
 =?us-ascii?Q?feu538pkDcFFVy/2+jbNt20YIx9TQeDUCnGc9QJ0EARTYQEcyNPaJoafN/4q?=
 =?us-ascii?Q?/CrML1XB0U2ydPK0+s6hQ2P52+nXK8tKCXzmYoF/m9vBldHWpSLt1hhI0f90?=
 =?us-ascii?Q?ggftxuPAytg2nWtABU4Nr/qILeCNssKsH1RkwrQcpIdEX+fM0SrLzJxlZx6j?=
 =?us-ascii?Q?eThcgvUr/Wj2xZ78uc7zHrHOrTXU+tvQq5r8ce+8Uwv6yKTSSrxa4q6eHcRE?=
 =?us-ascii?Q?XVFAfZvn2yO2vrjY/lxD+L9WbUghKzcYHwOR3XsnA3ldmpvcGU2LUI/hcMs4?=
 =?us-ascii?Q?ojD/BQB8D4H7DGb7G6+WlDJj9VAtFpYbIXcWsREXl00DJe0x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ce7cbf-6c07-40f1-5e9b-08de5c0b80c4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 12:16:00.8933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xa4iJdycxQW6yc8xyHixVM2Xw7vgVEvYYxZhNH0YoVhALlDfWbkPJ0u8ZZ5UAZdbulBgZGXD8MwPOvh7q+OIWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253168-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: BBE34807A3
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 08:21:08PM +0900, Tetsuo Handa wrote:
> We would need to update team driver side not to trigger dev_set_mtu().
> Below diff passed the reproducer, but I don't know whether it is safe
> to trigger dev_set_mtu() for team_uninit() and team_del_slave() and
> the err_port_enter: label of team_port_add()...

I just checked and the same issue was fixed in the bond driver in commit
f51048c3e07b ("bonding: avoid NETDEV_CHANGEMTU event when unregistering
slave"), so I would try a similar fix in team.

A solution in the core would be better, but I don't know if it's
possible and the blast radius would also be bigger, so it's something to
think about for net-next.

