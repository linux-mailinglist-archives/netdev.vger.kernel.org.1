Return-Path: <netdev+bounces-181080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FFAA83A40
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066884A3AD7
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4475020B7F4;
	Thu, 10 Apr 2025 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mIL/TZVv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0F204F6A
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268738; cv=fail; b=Boav7QiwM0HU4qMxWBzuPDc/X7lAB6IC9urSTAqg7Rvq+q41NKtuOftiOR4Nk+IXlgTwjiY+WjBLYOdzEAyZiaKg8rNOH4micUe/CQNFYMTFO30kMq5+LEXybYFVTSBK6zSwHJUqs32EsIaB1gIaEyEe3iMllxU9Q2eS4wQuF24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268738; c=relaxed/simple;
	bh=mOgwEBWzcFmLEWW1fuATMvgvPlPr9Fy77nqwknPuGxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mbk3s8gC9n1x7PuqyV5lp0zrTHXkm+lt3CgTdhLqMfTB/+4f/P9VqTmR10RMMbYABcrIl/Bhza5KDOiatK6x16px1YDSAqfPLpH8T4CPWPDlt/QCGCWpZqj8FATSuhhdbhTuzpvQRLuGZotIzG2WJRdJ9KtE8HrQTq9hqayjlQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mIL/TZVv; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/POwywcgUGOpqOyYIhHss94ULhVCSu7BBBpUSAOwymGPWEP5sfJyK27g2W2pZ3WLP9SBwfZ3KFCvBg1LKdMX3BA31XBQR2N6c/0cAwk3RrSRDbZ7OUYo3+ekB8a5OsXIoR0MBKKTxyweLTrgp1R87wl3eRqsfMJnrzn4yHpIBo8HjBUgBFlcYNO+bh1oYjlvsqlqYbpIP5q+zD18l+9G42paGEFHVP3kCF/F+E4jAfLajMY84DypPu9C1TTds2Upj+xzhIffJe6ayffcWhpTJ7bPgrLDqkI6HxAn/dcpkbzTP+DOeFhZg25z71CZuTrl+C5TZ+vzEb+imo4jQKtEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGmIG1iGJfQi8aEWMCqm9i0n6B7Y/Pw5XllxODB3Aew=;
 b=bc4s1XWjkewDZlrlvzSDt3bXfH+cXfKltuOOvWxytfMJdvKUFlumQsefKccoseetOEsYhsdIS5eyjIZj4VzR50ES+A1KrIFziX9GjEBE/v8eJAe0jqQ0TsquAvuVoxVth25BGm+GvgVK5ULC0lR1dHpwekJYWHvaBcwbAUYbbD7Bg+LSbyYMwwiIhu2WMspjC1feXjivDkzOf5839FUqbkSQmmd9Z43iJ5X4gvfsrcJOzJgGnZlEYJvRaPcbdH61VbHyDZSp2lXOy3aPZJswGnpZt5awEVVn7OFyNTAi3VnjjP2tV44qrI6ISNpp/CHDoFY6vBhi5mQP6/njFj0LDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGmIG1iGJfQi8aEWMCqm9i0n6B7Y/Pw5XllxODB3Aew=;
 b=mIL/TZVvfPxt5cjYPhO24k3cgdixciFflmXr9ICZTcvw8glGsy7r3be64CSq9ke2Vhb4M+l/9oAn4O/2kUzSyxx2lzCtY5xgDmDusSZBFhWiC0P7gIWi0pjNPWvOZAt6Nwnhp2SJ/TbjDXDC8tpVpkCJLVw30AUG+k4ZibuTIcCHyH8mPu3OSRzbV0qezcGZ6Uy7lkF8vBC4AouQpFJ72E1LkfUlMcTHGMXEJBeTq4PYEH293Lv2iPiT9ZKz489Q2T59RKrTtI9wRjTdCk+z+D4OXK3mmsUjrf1U1JX0M7KFUeiQPr+/43eoTgchVRj4nqb/BsxkIfJVnVpXpysbiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 07:05:30 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 07:05:30 +0000
Date: Thu, 10 Apr 2025 10:05:19 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH v1 net-next 09/14] bridge: Convert
 br_net_exit_batch_rtnl() to ->exit_rtnl().
Message-ID: <Z_dtr9ZuArqIpvmo@shredder>
References: <20250410022004.8668-1-kuniyu@amazon.com>
 <20250410022004.8668-10-kuniyu@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410022004.8668-10-kuniyu@amazon.com>
X-ClientProxiedBy: LO6P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: 9033249a-6ba9-4307-f35d-08dd77fe1454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O8XotiNTpEA4P+wwYY1gSY6Cm2P3DHnpLhRzhXjHhehTMCDz2lTEw03hzfCV?=
 =?us-ascii?Q?2VP2+Sce9o43tdES2VeVCRBcSD97L6A3CFE/Zes3bWZXgvwi7x/z0tNAbfwB?=
 =?us-ascii?Q?+herWwECrrK/v9nDkR90jPGR/sNOlA4VprskQGrVUaZzN0NBiz8YD3oG9b0D?=
 =?us-ascii?Q?C0SmkgbojRyFsrZI+jW7HHaZZDKKuhRP32IXUpT4jXH++WvFLz3qp4kPY1FD?=
 =?us-ascii?Q?7cBNHA1/MDC0HvoFaLo3JKTXKEws96M6ChG/lguVACoSzEgc2MP3vAoWSPJ3?=
 =?us-ascii?Q?JXviS1emcMlB0I2MO2jinb+T6ccfZW9Qvhllb7Cffx2vKJepFfGwTe6Feke7?=
 =?us-ascii?Q?7xA/6sL002K5JpByLx5A6TaMMFsw/VgADiJUf8pWOHkxhDkB86kzQk5hnVQ0?=
 =?us-ascii?Q?tYum4bXbpJInL4s+1BFxqWZKoFB+YNtS8U096K8i7BlacJHd+C+k+RqM0lex?=
 =?us-ascii?Q?/aArmtVuAtYZIwn/84VtAKFhfFsXMEevwP+aYad+imyJ8xhrfGEDebw/lQr4?=
 =?us-ascii?Q?tgW/X2W30GNCDE2+TFcxkvrSeQ72yw0g6xg8QQYmhqExRjPpApL0MICKQwsm?=
 =?us-ascii?Q?6C/TuWyGdpMiaffG4dgK2sBdCDIk7uEcUt0sGRE/Cc/JGjzEfk/ACzqW4YAD?=
 =?us-ascii?Q?22Jx3L6rsynyUtoc1fySgGu9O/feWyD83oWM39GW58mKH5NtMZJsHmkTVleH?=
 =?us-ascii?Q?+eVyPixTmjCQ5CTjV3dN/2x903PHwdqGs0u8kzTNrtfofVxm4E2XbZqDIYWb?=
 =?us-ascii?Q?ZoyzMCymA/IWxrpQ29XYrIfc8opAHGgq9DMfZs5YEJ1y9Q6ZD/vktUxR3kxn?=
 =?us-ascii?Q?g7FOsp6ytQ9am5UL6SDA+rr9lZYUMiyEQyVVVIYr5pllYjbROcjNd4i6XkWV?=
 =?us-ascii?Q?tW1SuKVVKovsIHdyjX6tAMcjF5Qmk8lSLW/doNwFbB//ttHjtdyPl7ZLWeYw?=
 =?us-ascii?Q?bvsX92csSFDMPkiTCfFmbWKF8xFf0Izp7eJUMUtGKTIU8lNU39+ZOMocpnZs?=
 =?us-ascii?Q?U1vPqlnSKQeXppXdnNHtjj23fPCOANUxfzRSLOr9my91Q2rMq/K1cMeixnoM?=
 =?us-ascii?Q?HH3Ws5uSiLvsZU+CQkdtBcnzjZ+wayXMlYEIgCF/qk+U1ZNb4J9bLt0wRJj6?=
 =?us-ascii?Q?MEOgMDZMg98eaFLgq3Q197SqpVLBllOXsxzkDc+1RJWwd1PU6jRhaSBx0juc?=
 =?us-ascii?Q?PivUe6Swnb6++NZ5OtLMnp6hHCmx9CKP52OwRdJBfmd0PswPFaDGa0hQIlp7?=
 =?us-ascii?Q?s/ffaoL872nGab7bCMA1B7quoNYvo78WHiPr53Y0VXazhMxK7INZdsU/hI+l?=
 =?us-ascii?Q?atKywK8lptNKR2eqxustIn5aJ9XC5gwjwv07lQ9EV//xvYSaSV+5aHDq6pkf?=
 =?us-ascii?Q?PZSLA5eit9paVqyZPY2gCwAxbLkA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3kUpOEF11gSW95FpngTodPyL3409RKNybXIKZt2EoiH69I5OFXbOmCchaYKa?=
 =?us-ascii?Q?TBqB28uELxUAUpJpMxREaSLUx9z9hW+Y2MPsnnW+8SCecpkx7kyJ+r6top9v?=
 =?us-ascii?Q?rKZDydQUKT9fBk5kTqJ/kdYywz5WenNiJ9IT+/jl6e37gaF/a9Z6gC7iglko?=
 =?us-ascii?Q?PWwh+6Jjhu42i+lYQrP6x8HvSDA/wNiI5PutScu1Ulj7UHak+5LttBEsmyFa?=
 =?us-ascii?Q?wMCnG0suijV6N1taUrR77lo5rjx57p/pYTDNoPju2fjeISfKZGBuLlkGTRf7?=
 =?us-ascii?Q?0JZTcjHWWAyOKl6mRcn0TssIOQMzzsop1Af4KnJDBqXftrWrt1b236LVB3F4?=
 =?us-ascii?Q?rtjvIl+xSsW0ZlgJ5WR9RiVFpUWj/ICI20MBnEFmjI7wGaF+sB98xRo63CT5?=
 =?us-ascii?Q?3vTR1oK5IAfbhEHfvHNR9Z2If5OT0Bg0pHh3QPMDHQ6rsQAcbQ+p9lG9zinT?=
 =?us-ascii?Q?Dg/ob0f5q6OqS3e9UIwvuRxrI7sMi0ckPiCmj17Ttx7Y/snCXKkpyE7ZQWvm?=
 =?us-ascii?Q?ndncfTsmkFkcuZYKg+VFlKLLTgKgmbmJjfNeJl91ccTY7B8c1ML/ms7FaGyr?=
 =?us-ascii?Q?qhwkC6g6+DXsg98+d+3PUOSogqRKDEFhOFXJbKLzJJsIFaiTtcMcdsY0EhCt?=
 =?us-ascii?Q?70tW8YjXclCuzZ2kQab9LNJ+Fdbd9r3bofjncGAiv1OQ8D3vRsgjfbfS6lEf?=
 =?us-ascii?Q?cJtKpBgzdJsYwuE+pMf1JMoXMljNKUHCw9o3YMXzxt0MX8EkBACPOMDoBL5L?=
 =?us-ascii?Q?AJQDRAvHsMjRbXNPZqvem2MLlTvETUuiSw9S8OGXb0kx5vPlb9pDi+TMcp37?=
 =?us-ascii?Q?vQwaOZ85oS/JjX5WA2/KnODctVOrCZ03PMeqPpoOVlptneuSCElmzCZiPuae?=
 =?us-ascii?Q?hQXLsg9QstRqd9OnUO5C8n6VA6Yk/5aDVw3J/hCYSiqYdPCoSu4yllIZRwEl?=
 =?us-ascii?Q?MuBles8bPDr/7RSx+coXTSa/EVRtg7UkS6bdpWCPx9QTt4AWmPCftKt+qNIr?=
 =?us-ascii?Q?VziB0dMp1S9K0b1fu32ngH9yC/K/cUisIFuTFA7sYnWXR74QsqPgYQjM3typ?=
 =?us-ascii?Q?WD7eC+Rn+bRMKz1W4po3NNHHPdeWhQI58inckCGDpcjPi9gEdwtZlwuk50cN?=
 =?us-ascii?Q?x5aEB6+rEqDhjRl4UghfDXO87Z/Hz5NB0iO6/fI8Qel7rmMrlb7cWJ6bOBd1?=
 =?us-ascii?Q?0OHW+7obOFqIqDdf7Th7zkzgh4Rplw6OVZqK8ovmfPbfTb/Ha98G5hvYK0m1?=
 =?us-ascii?Q?YZh1MsGgPiUoOkuogs8V/69BIJhYcGbCrSKKYDFKjpU6BU4uSlHRi/8xVRxL?=
 =?us-ascii?Q?vNRLDSW1JYtkb48ZG+buhAcO7QT59HyNf4kOadG+f0XZP2q+XdhiQ7W9+JCp?=
 =?us-ascii?Q?KCzExlVFxZObPoLhRfFDj5Gvh+R5Epwboilrsr7LDF45bKwGlP2B+WscbeMo?=
 =?us-ascii?Q?LgLNbMQ64xPzabtFGkAnc/bgp4UvFwrJp2MaHOCu5cVWROoPzwpBSaoQ3Ddn?=
 =?us-ascii?Q?mc06BovA7r9AwamW0uNrxxSEBSwR3CT6O1XHrJLm7IkPmAlAog10QJBa2HXU?=
 =?us-ascii?Q?35EN62GveNxAadhB7yCoZAc3K5YHX5fnhJ05wMTM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9033249a-6ba9-4307-f35d-08dd77fe1454
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 07:05:30.4778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+GK8SLkBw6xELKOHHWNbk10FHbFdju3xFY2vxzZtMKMpXEVxFDPcgwAgVoNQ9a9BfgQ1x7+RYou9KXJkcPN9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812

On Wed, Apr 09, 2025 at 07:19:30PM -0700, Kuniyuki Iwashima wrote:
> br_net_exit_batch_rtnl() iterates the dying netns list and
> performs the same operation for each.
> 
> Let's use ->exit_rtnl().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

