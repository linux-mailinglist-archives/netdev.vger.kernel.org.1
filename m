Return-Path: <netdev+bounces-304010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vr2jJrkQRmp7IwsAu9opvQ
	(envelope-from <netdev+bounces-304010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:18:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C7B6F416C
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:18:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=geUO8Lq4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304010-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304010-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A3C0300E620
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 07:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59C42D63E5;
	Thu,  2 Jul 2026 07:18:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664822E7F39
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 07:18:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976693; cv=fail; b=LntfopF/XObkpqz4Kz/nFhkKLSXRG9eLSwxKdGYoxdwRpkRDxIh5pI2RihiSQ2KtNYlWsYuUzBp7/AKniQPTAwuBStdMbIFboU40cD89+WcLu4KK+qfC+T8PNZyZ73aPBe/Me0FQzm7giItOoxF55qfqs3pAgocw8WCErquEEy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976693; c=relaxed/simple;
	bh=IPUQigrnqDT5wzLsTwuJS6UOkIZ0ZmVZNHvRqMDeTXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z2PPflxpGi8LeDoM4ewS+vQugiikVcxJKTOLTHexL9DSsjxD1D1gY20jL/Q1hlfJTam1gI5ZXR8Zaf6G1aVR78/7TJs0YaE5IzWKnT0Wz30tdFHNh7Gim10nzB6zPInygQ1SJtrW4N9GvngmYKcPu8yFwg71cSJmtuQW5jI+fd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=geUO8Lq4; arc=fail smtp.client-ip=40.107.209.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/Cprs+aAwScvtLLvwROXaU9myyU77MeRnI/S3l5B6iqwZ319+AO4h94N/lmhfOqgj+Y/EpqsJ2Y341DQ6Bt3gGuld5tgXJuzg0RHkdjCI7S+IsuxCXCmwyHVtd+5mawbAUd6eP/LW/LaQH6VbKJ8Pl79jqVJba3ijqPeUvMFw3QL1PfCuoX0e1SQ4xqcyd8cabRzYTqp1WJdsszpdybujgRkEdhPhqc48iWI7+vXp/TJwDS8xyeq3s4fVb0guRf/H5P8M6xTAI7x1RR3DCIfaYmcxOVjQKBSAeQoEJAOEcnSOcZ9NyNON9K8K1Kj2WaMrzXRn68W2NnSEoIAbJIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od76FlCP4WUnsM2JUc+KF/IrvW1D6M55MZKffgUEkIk=;
 b=wOYxphF4LEPtEoBiuOjdkhxFCxqFxbM9Ut8V6c9K/srr4CXobeZTFxJMzFWQgsVQR5VzPObalYjDes+GxFdx+nYQ//uaFSzc3V9Q2KnLOS54WrkhqZcUXVeeq376D5Ed+lPk9G5aNnPj32EQuMvShf3TYwtpmZN21yiFKPN0zOaBRwKfUd+Vltwz5eBx2MFBhEexa3HckwYmoftTK+wCQ5f5Tu9cEGih9MOyE2P8rhC2EkWta2o3qDcImqQZE+jboHCImXd3m7qkeh+IweRVIWLCjVLBWQNO1Pfn9Jt/LQjVHBWLQUWsfVaT0zh2WTGqSj6QfVyBFx0k28awgXusKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od76FlCP4WUnsM2JUc+KF/IrvW1D6M55MZKffgUEkIk=;
 b=geUO8Lq4bqqpY8Z88r6R36mD/cH/20kh5zHdqzGs9z2crtb17j5BklF7zT8kjzrcnsF3nipsEI04JZ1f/+gHbRmUssRvK/+vSv8k5q0W0J5VnElXM1xHkIZVtqk4DRPfpP4sb8YL/w0B3sAI1L319nXLFEOk3jIRuulk6Rjn2qQPVoGjvAeHTxU7pE5Ga1KQJ4nMb5cUvrYY4YUkwCc1x8Xqn2p0rdOst4e8rUZ3F26jQ+BiLY179f0x4mfYx0awsxZsvC6PAQRw5lEmmrlBvFM20vpzp2798Ta0lbsRH3swm8RixbowW6vkypzMPLIZ39Pe1UCu84IuSGn9ScgvEQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 07:18:06 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 07:18:06 +0000
Date: Thu, 2 Jul 2026 10:17:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 1/2] ipv4: fib: Define fib_table_hash_lock
 under CONFIG_IP_MULTIPLE_TABLES.
Message-ID: <20260702071754.GB1544468@shredder>
References: <20260702044437.591864-1-kuniyu@google.com>
 <20260702044437.591864-2-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702044437.591864-2-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 813b1829-55b1-4132-88f7-08ded80a0fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	5enuYWeLrdFKeLD2YqKLRkQUMrP9/ZD+1CIpRl8q0QJbV0jtjtU6RXGLM+vWeBNs0muSgg1bcspJROS8bL2ENvWJR9nY1Ykwk37fYObVmVNQ38xSlLvh+h9iX5Q9VaOvFiJaFZK61BEeQpXt8uVAr/9W/K9N37m0/MHgASfru8C+QDU3uOUr4VFpT4Rv3tp2bSuZRueLoERYq8xTJnQ5eko2NOAI7zjsz7AVepQCPLVXuit4YsO3jM12YhXOrdWwlZ3JsIldyREHTsucVb0XyDIUFugl0Ckr9ynpk+dMFhPknUpDNuKM8ry73//cPdAgSeA4imUcZ49ajNVd/gXzDMgKy5zGp5fi4+9nHA+NBuu5LOv72YAYEvSwxMpfjdrWZyFBiNzmsrWV87xvdRhIS5sV0hYIbNISOYjCYS9XBUizCxp+T+qdvin1dbqysV84XjTVzxHgWzLnqxbN8PdEmFVqwsuGr0+WUbfL24vNJ4lqRsTl+TXetAKdkOwm/kqvw1CcM6GLuW3EB2GwKNZ65yM6CaXPX1m25dCU7kIRB6u9/plAq6oWbGEwyRwsdsQJPMD3BDyhFsU+1tH8ppzi5VS8/27j0Gquljz8ruyN5LgEPhq0YS3F+Af4ERAfaQ2oAhdS0NvxlKFk34Bzztzs5yVwKlfkAVp6PwqMkdajNz0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Ui1U6zmq5vG1UbCREyh88gHf+T2c72Ky80nFeXPrXAlX5/nUSAd5OnI3hAE?=
 =?us-ascii?Q?RN1ooLxv6B8Up2OGHvaC5MEM7DR89VGjYprf12tU3oWJhyY29gGPqhl560h/?=
 =?us-ascii?Q?AuP+L57jRADCialagQi1UmYUK46ntVcXh4MGi4XURal5odSLdRvyu7a2mQHq?=
 =?us-ascii?Q?apbMHMcYa786FQGLk0dgg7tCVMFuYOzrCNmqzY/o7eIjJIN3zncDY+t68fLQ?=
 =?us-ascii?Q?9XACih8+chHUi1X213dQiadBiZ+wruo8yItKL77CXC8INl062dzY1j0PSo45?=
 =?us-ascii?Q?6Atm/1MSUQvHtOKtJicSysVoXFlp8EATaiLKJK3L1YBDiFJFXR2tGuEhWZGW?=
 =?us-ascii?Q?GH2b7ixwxNfaVWwbIav+lECyjaVZXThfdc/GNY8wdRNhLxcmdEHxbi3neX/R?=
 =?us-ascii?Q?LbhWcGQUnHIBLpE+1tiKnHPVL+PgAFGwzjiXmPrh5KYOERPIW4sVw1CPVTGK?=
 =?us-ascii?Q?YeYOx3O8lsBRCnrcHJmtDUCQ/qdOX5RAupo7FxZu7FH2aRhWQDOhR9300s0u?=
 =?us-ascii?Q?A2vBcnqSdEdMqbuv5FO//PMXxibo52LCy5tCdLzT100NkJeZ6WJzCnsxi/Op?=
 =?us-ascii?Q?nOpct7bmQ1VIcscFe0dW4TWLA9qW81rfSI8LXUA9JdNXj3TRI+q5RymTgS0S?=
 =?us-ascii?Q?3603obX6iOoTGPr4Yj7d3r4XOBAOgbsK0/PPxlUypwJczrX9EveunXKqM3Xg?=
 =?us-ascii?Q?YhE9/oMremUt/e1a+lG3PQFtVBYW9woojmyayA8bFoi+gR2IINsxay18EZnC?=
 =?us-ascii?Q?tUXLkojfVfE8mRl0E1Va5dyLtBuWfeY9YcbYLGc/CtggUqRkYbV4JeLlquZF?=
 =?us-ascii?Q?wwmjpkubNoMdeXf9zgs9gs3Nj74FsgD2ThAJU+dfTw2zcCSXEWkUB2fyYjmz?=
 =?us-ascii?Q?AKQZvSMdsQSlrWsvRdI4uo5anl34SU619H9Top5lcwPAdHrVKqNEwicahSU/?=
 =?us-ascii?Q?4yvIk0enV4q1yA/1s1I2TuAFLLQj8cR5+avLm8EpPTnpxau27y6CKAySlfDq?=
 =?us-ascii?Q?WTcCeAHl5yFHTq1fF2MFqF2C9rNLnLubD411CLP16pI/9bfEYoxJV7qvQmXE?=
 =?us-ascii?Q?56cMv3JxXcyhMSq6F0iBSg70aBALkpm+zX43/cbx2GRSAoVktSBF3VnOW6Ur?=
 =?us-ascii?Q?7l2f2Fr86YzYF8Xb1W37TK+Tm6mfSAalI0lbaWHODO6XbUmFmewdOD3/wxa3?=
 =?us-ascii?Q?S/QCEc3mJDv7TvYkNphS0x0F8OtGym417kdzmk6AWbeING7e6SpTdMISKyot?=
 =?us-ascii?Q?Cc+SRDWfcJkLAHX5ISbwCS2plql4msABJdUyKWND41cZeymI9J+9AcemOBVd?=
 =?us-ascii?Q?x8mHP8jYmQUGWNegXYurr5bTAw1+yADq/H2jSVcqiyx94ZWcGQxhq+M8JP+7?=
 =?us-ascii?Q?Ew3mTW5U/7rLaHHDF82FFjfXo8d8ER0bMFJ5DsFiPRwKIWczMUNjn/vVc9op?=
 =?us-ascii?Q?FdaIe8LMlE6e8Exi+1vfLKWfneTp/5tP7C9GcR0wP7ped7iuVqWq7mNb6hRs?=
 =?us-ascii?Q?seWwvtpUCBa3gmQngByecMiz4hVKcT73bEThO9/t36pCJ2xdfldZ7KvctgJ6?=
 =?us-ascii?Q?brXI2A9thNLRivVzVQ5EmurZ4LVeujEK/MzGOx6MzR2Yt/sNamPm/pp1LCRj?=
 =?us-ascii?Q?8EcEnwHG8GVD+SGzmxudpncpF6Kv4KWgGiBpOEpHl/tijtfp2fPrkArpt8tr?=
 =?us-ascii?Q?ZhH7MFtZdqMYX6uN6iaZfIkTX7ILFm+YX1K2GdIREcRcLQP6+SShDt85Ne0e?=
 =?us-ascii?Q?0cUspjZVEw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813b1829-55b1-4132-88f7-08ded80a0fd8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:18:06.1962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DS4U/xGOvGCF5Adc6seIQn15W84TRFzlTnHftWuElSQovr7I2j6CuDha1W1QhyjOpOxtZS88ovGgoOlX1TRxJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304010-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11C7B6F416C

On Thu, Jul 02, 2026 at 04:44:14AM +0000, Kuniyuki Iwashima wrote:
> When CONFIG_IP_MULTIPLE_TABLES is disabled, fib_new_table()
> is fib_get_table(), and no new table is created.
> 
> Let's move net->ipv4.fib_table_hash_lock under
> CONFIG_IP_MULTIPLE_TABLES.
> 
> While at it, netns_ipv4_sysctl.rst is updated.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

