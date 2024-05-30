Return-Path: <netdev+bounces-99288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DD38D449E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 06:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFDC1F21F63
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671AD14387B;
	Thu, 30 May 2024 04:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GVZ3/4mU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9E1143724
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 04:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717044544; cv=fail; b=rDmzQZy6DNxb97MKLQqOWUAPLV7cse4CnJT+GHY9t4xFhUUevXoWBdw2GyqOi5y1Rc3Cw7U0zfVmn66G35YrR9dbARuu+e0/QqEPVwvkI6MAwNoIsIuivZn/Nscj672JMxBc7xx2KtPHjEpIrSWISYKKJCwxhMez5IQRz7H0m2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717044544; c=relaxed/simple;
	bh=Tmz6JhFdI6qIbH9kvARE6DomViIn6L8i9md86D7fdUQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=Gg4roRbEsLxswUFGbbtj0vUIv2FODRbzA1ALHZB/bfTg5a9RdiMK/7wTADVsLc4+cJPzD3eklu+jHmzv3JPmHLvllfy9rPcZL4Es+Id/VDPd7BWqOQYP9YjElPbWsVOc5biz74nDvGAQFKDQ8Dt0xacAEVR+t974k2v5ZiFu3tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GVZ3/4mU; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/PaOebaGBVUBI2L94CeW1+Q80pUuaxFjlvPxrRHntKezENOCqaVJx4ZY/LWcmmUAs7QjoELgOu41BwWgu7mi5jLVFvR0BI0vgYfFH4vCho5DiRtVgDk5KadbUk49kBUaFyD6QK6pEmWe8hP+eP2NsBcytrdgm+k6wXMIYCa5Du02oVN4M55lJHi/14iQh8V8F/s1jPS5qV2d+DE/y3381sEbTud+Hkg3sTOD3pKria2/fWx3oz3iR+hzomexkn9sqOpKfKIvzLeYOcTdR/a+lzh2Je97Xb0Txeiu9w7HOS0dRhhegUc0mw+4BVcg+G2n411LOog4UYJ+WgNiddjIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC6/vDArSNtAPAZRf1HYNW3z7Ho3sxsHVnBHMOlPr14=;
 b=HTj/smVw496xJkt3xBLY+pPvKtVLnmirDkbL2p8rZ1gMSh9reTtrRaCyJ9klgF4QRR/zLeUQ8gebXRTxD8BMyCaCCuIMsQeIRo1OSTpJVjkkZaGQow0spCsEXIlxOGyCdR2TgS0hXb9UTjRzQMBHLR1B99uEgqub6GkQG4qxBhnP/uDI2pEL09yh7u2f0Ay4kMvfqCHor95Y39ZgQ/4kF5GPJmWviyJ8RYphVPTlQbcW9s/U4esgMrhMFA6YXFvpElUlTlApXj13zrC2yNpTSsvSSCOh6Nk/aJeRl/AA4X3jfJV14ffeHkfbE/pW93Y+bx3Frs+9QQnZ3v6yRBh/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC6/vDArSNtAPAZRf1HYNW3z7Ho3sxsHVnBHMOlPr14=;
 b=GVZ3/4mUFMzLGTLsIDNp6lYqnSBlWw6JtXcZXax3CvLtlfwIrivN3RfjDhPH0ucopxdKel++nv+nqfW2eyfUJ3wyjpntasIuPjCEJtiZVLMbJWv5THa5lrfBhy7KkCK4ibZ9MOCrGWftTz7xbdSdGbLmZ/bTYMi6AqdUDDDdbwUy/GBwZi5eWs08dSMU8R6Y1KXf19DZFxqsxy9HBicHTgNI04MRJ5/D2KtqWkSlTrArHkPCIn63tv1k9pSjCOMULaHV0Q0Ikx9yZz3oNmO5kRwoOQwYb6YCWYbotIYv9yfoy/YnZsssZdXOaX6oYWwvjk25NQW0wDcFl4ZXQpEs5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 04:48:56 +0000
Received: from PH0PR12MB8775.namprd12.prod.outlook.com
 ([fe80::bce1:cfa8:f5cc:dcfe]) by PH0PR12MB8775.namprd12.prod.outlook.com
 ([fe80::bce1:cfa8:f5cc:dcfe%7]) with mapi id 15.20.7611.016; Thu, 30 May 2024
 04:48:56 +0000
References: <20240530040814.1014446-1-vadfed@meta.com>
 <877cfbrjo5.fsf@nvidia.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Vadim Fedorenko <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri   Pirko <jiri@resnulli.us>, Vadim
  Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org, Michal
 Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH net] ethtool: init tsinfo stats if requested
Date: Wed, 29 May 2024 21:47:38 -0700
In-reply-to: <877cfbrjo5.fsf@nvidia.com>
Message-ID: <8734pzrjk8.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::10) To PH0PR12MB8775.namprd12.prod.outlook.com
 (2603:10b6:510:28e::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8775:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e07a086-3300-4e57-78fb-08dc8063d041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1phq5CBTLkx+mrDm0blqE4mzETVCCfQfR95U817QYw3b8mR57bqpMmv09ebX?=
 =?us-ascii?Q?/4pFEuxdPfGdJ6xlrdkXKhEodD4LbDW/aulpeQUNUobpN9r7vyWVv+VnzvcP?=
 =?us-ascii?Q?fJbhRdyI075WdmagtXN3E4ersNY3vW1VKfKA2ooeJydgic8oXEcm9CPDId0S?=
 =?us-ascii?Q?oGadKb//IV0l5n+8tPt2h+S6G09il3H73CKHHqe7BDXmQhVhx0+UmAGGYSK3?=
 =?us-ascii?Q?ASl7jVWnYAyp/Rrrr/MC7pJwwtaunbfrvly+LwR+M/SsO9whBq8+nrGPONzj?=
 =?us-ascii?Q?biHJ4VaA8yI4e6+P75i6aXJesKMtvvZ4tLsm7o9CaIJ6m19u5sLLXCP8sxPY?=
 =?us-ascii?Q?IPLJoVUD45nV+cTjPWH6ooMX9OQ6i8AdCpzYdASvY6ppEzyiCyUFKOlaDkAT?=
 =?us-ascii?Q?T4oCN1PR79vY7ail52iGnbY1elGWIj53L2K2pA2mm/ntBmiSP0tIuzmElRpD?=
 =?us-ascii?Q?s6gyiHY8C5dF09KXR97XI7a4BRmXEwfTI84aiGBwfeUgcRQKc6R7trSaG/2O?=
 =?us-ascii?Q?kyPeFaeIdYWsK1KLE/w+CgXz1H9dGinlq9rNibGHhbCQhG0JoLBRjIm4QT2N?=
 =?us-ascii?Q?jgq+Bg4hQqvIUjfvFyppsqwQMOhmODHQ9jC5VkE4rJLOBYRKwDjFRj4OPPRN?=
 =?us-ascii?Q?cGYXNEXoKM/1xqG7XdwRBFS3Oe/TaHFyhZ2FK3lKg1h9D5/6W26sCDLBH8Wo?=
 =?us-ascii?Q?Dkc/a9TlXaAcEnose1w5eFe6kFM2unvbJE7CVIvyw0vuEGUejCo5+Ij35uas?=
 =?us-ascii?Q?SLXmHXfPLRrENKHHVe+ek7gUXWOT7qb7NIifkXfxT0ulJBZueLLX0aOAzhNC?=
 =?us-ascii?Q?OwtwzVYAAlbUChdpt2KoJVpG5qUoloHml4UiCKUkiJ8wHin8iOTDTJfQ8sBF?=
 =?us-ascii?Q?37d1WE4j36HjjxlDWY7uWkRpsfZc4DFz/pdaljvBhveyb34W0UCPCik/PycD?=
 =?us-ascii?Q?MVu/sV+9G83uqR1y3qEjICpfq1VKbdAzTa6e44E7wTJCpyZdMUwXidFiGLGw?=
 =?us-ascii?Q?iVBF7JAjWZDp9pmghx3l0ir+UHoIeYJhI1pz+W8h99Dn94PkV0rD/2/fAqGf?=
 =?us-ascii?Q?xRiDkFyw988JRUAN+aPelGg9M7j/4od9tlu6itNi5x7hETlPdFKatrb5rdOQ?=
 =?us-ascii?Q?mGFVXglT07w5oce5YOYEZ5L77H8bi4SI5SqtjNmijR728YYsZgHqKhSiDwoB?=
 =?us-ascii?Q?18xulL0AjXnajPupYNHUrGLdP6th6Yat0+MBI2EW86rYHPgnkwugC+kBux7I?=
 =?us-ascii?Q?VqossGtHL2ciCYI0EcAX9j9PFuI449d0i3KRBN7ciw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kd6bHkb+5q0spgO2H/fW99bIrf1Ym0wUmbFJ/5b3fgfpW5e/6uuRXQE8ORhd?=
 =?us-ascii?Q?R9e/ZjqnanbF4tcmdDnJN13PLGJJuGBAqJaC2GP6fmmYA4f8Dv96kkdMFlec?=
 =?us-ascii?Q?4rpltJPtHheDxZ4lI0KY1mqNe2kFUbnl040vUZlYaQ3d7qxuXxwdGDP3mmX2?=
 =?us-ascii?Q?HYtlBFEduNMHANGxNq+XU0kzOGCsUe4i5vj86hlRT+719Ji0K5sruB8Y2xD+?=
 =?us-ascii?Q?mYS7a3wZ1xjsPNteEG5I21fwIOeY94hIDMu6d38b/+1DGlQl5xATN+uxrrSK?=
 =?us-ascii?Q?OZM9i9r5Z0nF1rU7e+XngrYOStAQNRWCoGNAJ+zIMJo+z3poMJdVADwsdgH6?=
 =?us-ascii?Q?i7jfNJSh1fTRt926sr+3qP7fgzTNjdnDZdHCISWA8MNBfUbiC8z5y2dJjtUk?=
 =?us-ascii?Q?p/8o05AdqNPPESDttScXyFmnJPVsLocQyXztoI8J9wq7npBTsP+l+VOu21Mz?=
 =?us-ascii?Q?UBMp/uo9emfTcK3i1JUmDYrVKE91oAl5u+lBw4oKWjr9ZAsuCXncQ8Mntud+?=
 =?us-ascii?Q?n+pIGA73ZxVTAdg2sy7qS8iMf8Vp8MCh+CJ5odcGJz2HSRMj7GasEsgQ/sSh?=
 =?us-ascii?Q?o8Uu01QUL6HMzciOATSggfsjHJDSMYmIjRrls5yq5vYRzBWyTCtQ1wEl7zYD?=
 =?us-ascii?Q?WnyeClXvARFoMM34HJBRIn3wf7mjpv+vYddM0METa8jASIXFtAR2Hp/t0Dr5?=
 =?us-ascii?Q?9IHmlw4bz8D4ie1nZtTq5/zoP5a/zFXHlcx+XC3Ouczyq7k2UvYD/gocL+DJ?=
 =?us-ascii?Q?jhKuV4YVXaSwrSOhXf/wzxsn6c4KvUFPIrowkGqrbpnwWiWaoFOUu39vRC4N?=
 =?us-ascii?Q?C1J1yY7wufAxq+LgSc35+CvjGwwehShRJGy5C9xhJLEkfVR/qaLVlCd7WtmB?=
 =?us-ascii?Q?8bWJjVcQ50i5KFxHnGlGmf2i2hJcsRjSlHICQx4LzReJ3vJ9bqSeGbNriX3+?=
 =?us-ascii?Q?4SkSZdzurJhziNBD3ATvKajU6a5zvPqQnuKgdvR+FSmCTihVIUrzr4OdTDfk?=
 =?us-ascii?Q?9NRFGBa7FqjTUyAiF9asiIGIFWTAEWq9LB//fwpUf8sCoK6AfN8ZtkO5SlOz?=
 =?us-ascii?Q?7OAz/A+CvEzF82SYq7AilNQ9P1qKG+lwp4hHiAqLjwA2B8iz5juym5sjG5Fn?=
 =?us-ascii?Q?NAu6FYOd0ZuNNYla19ZFr9Z8MXLsW+jz9TUnD/AkGtO2dW3JI09DBCGnaWMZ?=
 =?us-ascii?Q?M9CZSmpPYLzqXTJHhRY2is9+az7Zu8NULSxDPJAL1xoKRAdPsn/RyaDn27DJ?=
 =?us-ascii?Q?yXAFfeqffWpE+K+sPVmtjwQ643yNgPQDGzVN8gh0T+/rtilPWvGWoEjfgOUr?=
 =?us-ascii?Q?mu6BKfkSHy9XX94P6dGHWiAwDr1dWyBM/V+Tcy0zw35e8k7o+TLDUviTZHgY?=
 =?us-ascii?Q?JYacnaYprRlGmKffDwhiYKQe0WdSSsCg6veZKN5nBJtLeVKA77OzJJoxK3Ad?=
 =?us-ascii?Q?ZrA+DQru2XlP3ENCco/p9xU2T8k1zsOTA3tIJIX9xsf1YM6xXG4Il+DTeNlV?=
 =?us-ascii?Q?bcg9MV/Y7MmiJeuZQFHswA73+M7ZhaIH/qqRX6mcjNeslgxWmWAF0E381iDb?=
 =?us-ascii?Q?f50rO8eibZrGrJa3fntIc0wKLsKjZHNqymz3+KTBRyCkLNzJE4O99ttoRx52?=
 =?us-ascii?Q?LWsGySMpa5RY+3e5ZxBQtfSqTelwG7ieymZlRZ6KKlt0/QX03fUappxu1lPz?=
 =?us-ascii?Q?zoc9Qg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e07a086-3300-4e57-78fb-08dc8063d041
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 04:48:56.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8i64Hvbkil1bqN6soRi3QbECNElOJGMI1kdDKnt36l8rCtn6+BLtS1GhnQ72p9e7NS1HsS+0kF9NBxXxoMCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607

On Wed, 29 May, 2024 21:42:05 -0700 Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:
> On Wed, 29 May, 2024 21:08:14 -0700 Vadim Fedorenko <vadfed@meta.com> wrote:
>> Statistic values should be set to ETHTOOL_STAT_NOT_SET even if the
>> device doesn't support statistics. Otherwise zeros will be returned as
>> if they are proper values:
>>
>> host# ethtool -I -T lo
>> Time stamping parameters for lo:
>> Capabilities:
>> 	software-transmit
>> 	software-receive
>> 	software-system-clock
>> PTP Hardware Clock: none
>> Hardware Transmit Timestamp Modes: none
>> Hardware Receive Filter Modes: none
>> Statistics:
>>   tx_pkts: 0
>>   tx_lost: 0
>>   tx_err: 0
>>
>> Fixes: 0e9c127729be ("ethtool: add interface to read Tx hardware timestamping statistics")
>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>  net/ethtool/tsinfo.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
>> index be2755c8d8fd..57d496287e52 100644
>> --- a/net/ethtool/tsinfo.c
>> +++ b/net/ethtool/tsinfo.c
>> @@ -38,11 +38,11 @@ static int tsinfo_prepare_data(const struct ethnl_req_info *req_base,
>>  	ret = ethnl_ops_begin(dev);
>>  	if (ret < 0)
>>  		return ret;
>> -	if (req_base->flags & ETHTOOL_FLAG_STATS &&
>> -	    dev->ethtool_ops->get_ts_stats) {
>> +	if (req_base->flags & ETHTOOL_FLAG_STATS) {
>>  		ethtool_stats_init((u64 *)&data->stats,
>>  				   sizeof(data->stats) / sizeof(u64));
>> -		dev->ethtool_ops->get_ts_stats(dev, &data->stats);
>> +		if (dev->ethtool_ops->get_ts_stats)
>> +			dev->ethtool_ops->get_ts_stats(dev, &data->stats);
>>  	}
>>  	ret = __ethtool_get_ts_info(dev, &data->ts_info);
>>  	ethnl_ops_complete(dev);

<snip>

>I think the patch should target "ethtool" instead of "net".
> Also added Michal, the ethtool maintainer.

Ignore. Was thinking for some reason this would end up in the ethtool
tree. The patch is correct in targeting net.

>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>


-- 
Thanks,

Rahul Rameshbabu

