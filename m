Return-Path: <netdev+bounces-272236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGhyOAKYxWmK/wQAu9opvQ
	(envelope-from <netdev+bounces-272236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:33:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E370733B756
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1036300F79A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F53537D3;
	Thu, 26 Mar 2026 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nRTKs5Qt"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197AB1427A
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557182; cv=fail; b=cpin0E6ZH9SvW0H4ZAlBJPf/Yju6P4ZdTvhieCzyHpZggWsKzGTVVi6fCnzAoQbdWx5+LbYVfq/FWN0vLHWFDqLNFnlFNpQsUabqHzv9uVvdQUCvbTnBwFkatyDOsYMFqHWon98K9FlY83aJzPYUQuBmS1GXdWqJMGF3un4md6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557182; c=relaxed/simple;
	bh=V/U0l3HynyaPejo8hTmNofQR/7U+3FzJf9AsPv/lXJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GU7O9oFvunQeKmllcoj+Oz8agy/lvyeXbFgNMqX0VKThT7QqhN4baofloQoMA3eDDlnJ/lLZGn8aq8UQoaN0jRMfsB//KD7vyZbWA/XVcU1Vrrr/Dcczubc5ZrnpjjXkHqtKF9q8DRfF8SVxqoBoKyJtlIibJlYgqs6Wi6wAVBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nRTKs5Qt; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFalBmKzspKoG0GFvx9SiEgC1YFRQ8EOwXD/T0lK6kWomRsLyWZGzCQqBWTVA3zAN+m/cly2YieYsp0Wp83uiwHwV1P4kvs26lC79CXyLErc6fbdSMJcunisqAsKctDUfNJ5BBTDcyW4X0n6iNoSxnefoeJLRCgKrlkR19u5Wt5QXQ5+/T0vkr80YAgCiG7RsEWmBG1an9GRJKF7MhndM3l9vsuJjsvNBy92KaBlbyVlY9uZ+NRWTtpuulEs25GMSp7pNmMU81Ib+fHMz1UvmG9syQUvpOQduwzXZ49GERFjOzWTaYlmSTccXpvBVLErnyiUgdQU4ekxU+HKZizlsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iNag45YRsAPz2h7pnErkq9BGZMLUpfgq3sJFMJoE5Q=;
 b=wcnaW13OshkRQVjCQMnoJiVLwgzBWcK1P+Oclq7cPC0Od2NwNpP8rul9L0b9R6XWCQknF7cDUpnSRbCdTSYLR3f52sv/GGTXokM2qJcTmweiUyUuRFmzoa06eW1HNLgcNM/JM+oZVymAVHpQyEDxV0WhSadedQGEtbvpCsC12nDRXdJ7c693KcXyKNCv0DSD1fGOKHmV0/+yUb2tP4qwgXSP7afX8Xqv+P+Ta64V+l7l5NKyPhXdwoN7ct+PGGgaXb1B+Y169sN+2fWkssB7jGa2vXYit9hy7V22grD8YQKaTQxl+6dLWADPYSpReqHlDpEISh+puo5kiYrpnW3lsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iNag45YRsAPz2h7pnErkq9BGZMLUpfgq3sJFMJoE5Q=;
 b=nRTKs5Qt0ULW+32G3F9ogycuQM30LPWO9MVha18Xk6Fefb/OkWerxZxQ4DjqScsaTHN/MtzP6hjSM+Ds9wKiRlUdw7m79ff+im6wd7cYWhL86gV6svJVwZW3SDjmNdqYUqCu72/RkPXZhYRoOmNXgj9YHm2b6/WI97B1l4UanLOw+FCZN7R1ojIyFqffCck8PoXGZrasEwwPaLCpT3WDYl8kn4drxtlpkdUT8yCPIayoGZpLnS+RNmTp9HuaEVWrYMdFeMkEuwUW2KPqiGAYB+61D+dtTHqEUAjaFPQFimliwjrX5cOBcdcX6nBhkXtE7U95F8r0oxdoW7NurkLXvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 20:32:51 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 20:32:51 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com,
	lirongqing@baidu.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 0/3] vrf: A few cleanups
Date: Thu, 26 Mar 2026 22:32:30 +0200
Message-ID: <20260326203233.1128554-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 468cdc56-ca55-4dcd-3302-08de8b76d9ce
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8sWke+MsGGJfrX3M4AgnRtoUGa+M11l7Ghy8iXONuAIjH+27IxzpTBGG40gRNsN57LGV35Hxo+A/C3sxunF0GhYZoMUcMasy+F7HVw2rn4be2NJkIz10DAIrzB/zO23eEL3yz17fE0yLJVzR4ONfqA/j9AORj17OxZonlWzB//2TGRifniicoovUA4eMEuOnMfKF4GZCDyyVS/AU3pw2wbicaPvEekH0LTmAQCxFOqwmhKnI3zyy9scsNdEjfOF50NTP3AXpOPa0WI7g87djR1O9S0AkYgiKUCIRTY8XIR6kR6qzGAR97I72+JY0XGIxoqoJ8eSpvLwdqlpOKBF1PkK6OCuyLImeUCGEShOkgA85Qv87wbsX3MlLo/K26ajF3xD/5UcHcwsWk+Lckv7PNQn1aFR3ETAP+KCOXEo5xAkTh30xCAJlaB5gv3XehxKA1f6rybLYfcD4Y1TrwpJha+xwIlqHinslweyyiuw3ojK84n4hIxSscMdOuC2uRbRhKze5f4nCmGOKzf64eQg2vA46joUGwt9Po91bn1CjbuMLVkqtt/qezjEGSNddYLBd63ntQLmspNurfk7hXTjVzR3CqeBGJJhILr6t4yoFPeOeOy1rRE1RmkslpMOsBUHdSjfzTALlCnNScE5LsLcG0btF1nYR6yhiOiSZP0dOkmVjAvy3D7gpzkgMoWjHZjmfxvBMXMGaOOawePL9QCVHTNaNa8iB/lkgOWHjPvDbE2HGFeJ1hZioUpTAPJTbi/+m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VPP3LoKxdtC0/k6UfiB55LvMF9MljFzYL5vJbLSxBvz3DovfBka4AfNHe1bG?=
 =?us-ascii?Q?wDkZAXaeKeaPmEE+53FVgVOSkdEaJ2OsNMBn4JO5rQBnRcKeFNVY7CcyMTCm?=
 =?us-ascii?Q?Di2Qn97LP+lkqkAH5orSDW3Y0l880UVsNZz/eoixsPCHzuUZ1aIjXhh/NtrP?=
 =?us-ascii?Q?PyHxJrwQiYpMKysqprt9g+PWsfyqnLQms+IV2M0ys1ulS5Zl8caU8xuCGmkW?=
 =?us-ascii?Q?c9Jg4D7Rw0WdzaIJiMlHOPEhmtlyWFUeMjauGwYibFe3KTICNwxguat99zGV?=
 =?us-ascii?Q?x04p++/VyzxDxu3At3dB4tT6GxYsM8+QfaKxMkPBAfvVL9j18vcesTFc6nwU?=
 =?us-ascii?Q?5U3Mg5zYxovtuArWUo1usztQit/ax00WWl9Agu/JaResjM4lG4ntyCav7pyA?=
 =?us-ascii?Q?Fi92gCf5kUnXAJfn+Je5M/kQkZdhGbXLEoKRGSa+DE4wSR2ZN9hyPLDf/2ET?=
 =?us-ascii?Q?tOLFdyWC2yn6lFy+7DAo2NWs4DYvawXlsb/YOx7TOhJS66uGNZDBVDMwHyVL?=
 =?us-ascii?Q?X/V7WMyfx/2MdgXeCaBXEuOxwB7I9I/Oupd6jn4L1QFNMuu9OvowO7Ce9f91?=
 =?us-ascii?Q?jcZyS2SOotxK7OoeFW9kRl05Gv0FHvfpJbn952atZ4l1lgK5+uWhxJqaZheZ?=
 =?us-ascii?Q?Yw3QOjQ0E52xAMTmafVNjOG3KWskAQ8dIl14g11qLVCl7MPSuRMFHyJMd9UL?=
 =?us-ascii?Q?UOblBRjUFYQtsDURl9FXdmNu80iOdBe+EreiCCTAom2JTFoecyYxWk5oLyXg?=
 =?us-ascii?Q?4c6X9AJeLXkhmKmzae7vhfKaNtqUJtwmeImokebYhXV5ar/MNuApUs8tNoVi?=
 =?us-ascii?Q?W+x0/Em7mkUvLn0G8Ts8wlq4xyaC7oaRUEDZesqXD5AczfgiXNzEbwspVWTn?=
 =?us-ascii?Q?B8S+AlY17ZpFxNp1W7PrRp/D0YI6SR7hea4g2D6a0ZyOu9YfplsA1mp4Az9I?=
 =?us-ascii?Q?g+mbVmL6AxL87q0MCdtSoiAk/7DboytPayMObySS2t7KwxHtlhqUcUmMofOn?=
 =?us-ascii?Q?BHt83IpyxPEib2SjKZjOyNR9oyj0A7CxmFg+vDS7V9zQSW6wepBYAYfMklg0?=
 =?us-ascii?Q?zDDm1DPSljq7VMTRJfhcgCM7FL+lKewAF8lf0avrMpfLB54X7MGHD19plaDw?=
 =?us-ascii?Q?ytfLLCk7OpIH4m20x+bOk6Sdy6iWEZiO1GczQnwAAQRnBHJ8CwvIGVFiaFuT?=
 =?us-ascii?Q?Rqax3/3UYKbpi8WGlfXtj0InJPxteRGPU43xIA3zLBADrjvF2iDJ4i3neTi7?=
 =?us-ascii?Q?P/oFwxtl2qj8qKfKGGLDxLI6JHG3i+BpxTtE6Pc/lXDKPWZYRjQhGsQZ1UE6?=
 =?us-ascii?Q?yQXTHBXVDfoKAh+DRJnSJSXnDU/cF5tP1nU5/3yx3fKXQquezCoR+3t3dugo?=
 =?us-ascii?Q?HQK4XtavbHwdBC16qHIqkkseXi+TlIcPPQnQ6RmKxHzX6BztLfYm05L5avms?=
 =?us-ascii?Q?zf6vgjR+i62DUbKhDZBCPebDmMrnpcKTl+HuGIvFCTDvLnKfujMPTtmsKV8f?=
 =?us-ascii?Q?g/TUUZ95krDqL4isBLb42B0zM2lDreB8SzcQtDNasxq+7PqWfhXY/Z8Zcgvp?=
 =?us-ascii?Q?hmqjPNB3MyS86K4D+qLwxi41EG2g4OLgKZLZXXfATPjkzY9HxZQG+xWVOPgM?=
 =?us-ascii?Q?qBUl6WPboiP3cSvM7h7NjdMltC3J7elihLqnRwUhaQ8XLEUXfXvo4+BhpHTI?=
 =?us-ascii?Q?PQGQogX2JBLbCo825j+gHfX2FIgLUOKGnACes0S4xrHR/nVGZJJikNIdSJks?=
 =?us-ascii?Q?sOETl0t0QQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468cdc56-ca55-4dcd-3302-08de8b76d9ce
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 20:32:51.1010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6g9NRoZMpp5dxwgcI1gOhfclmI0DF9lDyn2X4EjitX0i5MB4O5pJWhqkrA6NQLz701S1hITTHhaKEyxk7RmEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272236-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E370733B756
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Perform a few cleanups in the VRF driver. Noticed these while reviewing
a recent patch [1]. See individual patches for more details.

[1] https://lore.kernel.org/netdev/20260310105331.2371-1-lirongqing@baidu.com/

v2:
* In patch #3, remove RCU protection around dst entries instead of just
the synchronize_rcu() calls.

v1: https://lore.kernel.org/netdev/20260324155521.525292-1-idosch@nvidia.com/

Ido Schimmel (3):
  vrf: Remove unnecessary NULL check
  vrf: Use dst_dev_put() instead of using loopback device
  vrf: Remove unnecessary RCU protection around dst entries

 drivers/net/vrf.c | 82 +++++++++--------------------------------------
 1 file changed, 16 insertions(+), 66 deletions(-)

-- 
2.53.0


