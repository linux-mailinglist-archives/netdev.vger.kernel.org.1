Return-Path: <netdev+bounces-223986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 497CFB7CA0D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3BB17CC5E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E105F284880;
	Wed, 17 Sep 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rSWmhwBv"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4EE1D516F;
	Wed, 17 Sep 2025 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108663; cv=fail; b=UOGgd50UZu+lZhxoZRBSLZmwuGFQGPcVQBf11rCrOZrq25sOJRDLF+sBWKBta98MOirvLgkAtQ2scqHrephDUAUwSmXsg59AwjkEYP02UqyIafcMP7El8aerCrSXBHDb4KEHsjdeWn3hX2muvyPSakjdm8dUtoqMEBJqLTrtcDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108663; c=relaxed/simple;
	bh=jMAXLmpuU/82mgrpLltGbFXwg7tNG9JC+72SFG+6kL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M28EWfu/6ktwerNC4ukOMdq31PRa6HJqkjWMLOk2slQWW9h9ns5Io5l12nftWAcW6l1VZGPpPmXriwGqv6VAQ5sz8/DysHCL28D0RpWGOaYWRGhqzQ8cTibQXuDfx0dwcYR/O7pUX74WMxP9wrglzvRByWLHY2IHkEF+8ah3bAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rSWmhwBv reason="signature verification failed"; arc=fail smtp.client-ip=40.107.208.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxuzoUKpmNc4695V9yMF6OgHFdfbyLbCwvhbfTG4TbuYulxLbGWmeXeILrBFZPE/XRIIcJmbjvSTWNIjsmc4yjWbKrJ2ewSn7yM4bzpx4viplVL+IiZmQuAmfbG/wkmCpsElEyfTlWnSirWQHNRf2ROi1JGRLKOr8opif+nMLDbiEaOcDXV8N7k6OZ+fponhl2Ensq4S18H74lcVJ/hqgzzI0dM9FJm/fpE0GUx05z9x3LLRMVrRBwee/XyotW8YmBbeIEEM7CBe9NKWtCX8qqiuM+wXUTfX4UWRf9cRzma/NsXk/GWl2cQEfhRCAABgLBLGAWfoEv3yKJY4tQu9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPSoQgkEFYCr0gi3flFOY7hzz5vT2FJWMhdZAFZQieU=;
 b=FGggVdNowTt8Ozth7RqPLmGVpqktYgAwC0zqjJab/w4McFAXg4vpoHvAM4XtTDh00AHoHMiLVU6GRo/rmAoI2TYBdtuDj035znSaW0Zlrr2/2Zly8h/gM5T9CVlZUabGwD0XpxAV+PqDClElz4kX+uQtalCpjsfbcDZsMzgH1auImBB9MLNzPEc6JQoXmDJTzWfXhQkHvkDcPqicaJr3751VkKRtdI86QxNFsTEHGf72MhF1j5/wLgTqE9CHkSUgw7xc2VAfwonw7TTFbZx4UGsgeJM0XnX6Y9WYebC0MDZ6s32U6KkLIsgdnhXKO+lriu6cZN61pLkn8qATvQAuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPSoQgkEFYCr0gi3flFOY7hzz5vT2FJWMhdZAFZQieU=;
 b=rSWmhwBvUXcSw7GYNbUXiPEYRZiWsFkHDD87WxDlFj36P5t8q0dJPWD2kAXtRvbN51j+BR4SCFX10P+k5WstIlUQgj8NFgCV/shIIZgXHy30r0r4dhzo3CQLW2DQDCcjgssrXxMpXbU7dMmnxRo5t2nzRBWVbRE2+SbE7LPk6EnAqwnTIuvj8yZ9gn9IN2UIEviXYCI/6arD6zU8lLjYJVnYr9ofhq4iPpcvrzyY7+9EdP3CNjNZD8NX7H1tSG4eouejLDprbzIaiahrx39QPX0+zwvOwVgKCy4TY0ASJH9UaWTm3E6ZJxM7zhmZdbTJyAI1h5CQg7G469A9Oz8DRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 11:30:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 11:30:59 +0000
Date: Wed, 17 Sep 2025 14:30:51 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Huang, Joseph" <joseph.huang.at.garmin@gmail.com>,
	linus.luessing@c0d3.blue
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH net] net: bridge: Trigger host query on v6 addr valid
Message-ID: <aMqb63dWnYDZANdb@shredder>
References: <20250912223937.1363559-1-Joseph.Huang@garmin.com>
 <aMW2lvRboW_oPyyP@shredder>
 <be567dd9-fe5d-499d-960d-c7b45f242343@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be567dd9-fe5d-499d-960d-c7b45f242343@gmail.com>
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 6922c96a-7f7f-47f4-820c-08ddf5ddace2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Xjsi71E3YurfAe3Bthdme86kpXzxupwrc9rjkWujaCEwgr7OiB6oprEKBd?=
 =?iso-8859-1?Q?ag1k6kErlCrg4jXnWRMuIoTEj+47+o56mmcglUtp7/qbraPuPu6iNa4Kd9?=
 =?iso-8859-1?Q?88d437RWmD86ojbRRRbryBIK0gaYA1Nb8pqA/zUVMQ7EC2k9HM/HKk+VPs?=
 =?iso-8859-1?Q?NWxBNzcqp00ebB7rp1hhsxPMpKI0eQcAAnQ7prvP4LDWBcwGIZpl5csz+4?=
 =?iso-8859-1?Q?bKSEdhiHvgIAVGyrNEUAXJj1uzWRuhJoHTCuRp+I/d5aONZlE2yCqcQJWb?=
 =?iso-8859-1?Q?tDY6kpVB5SwaQPTBgolysb/p+wzO5Ogfv3vVg++iqukNtojzqXNLMkCg+4?=
 =?iso-8859-1?Q?0pUlSaX5cRc4W0WtdLUVZrkfVLlDTdQ8rIm/SOAo7lK027l5Py9HId9BzJ?=
 =?iso-8859-1?Q?cs8CWzQeLM5RMS1FGdaZY4/YeY6moFHKalxsdqZYmVHy42BBiDuF21NRJy?=
 =?iso-8859-1?Q?1tDSzaME4r8BCi1Bi3m07ZlM2OVPPfUqsFiOp+CCJk5hJJHw6cKPAZRXhq?=
 =?iso-8859-1?Q?oijip9g8CXdL3IXZgut0HRa/ro4avF2xxDUtZpEVHseunrAdWLd0TSyYSY?=
 =?iso-8859-1?Q?3l5j8ZnQY9aLV8Z6tgTdeOnK9fdIbyMiSxXnQ7YRnSw8s1kYAag1tDjSGi?=
 =?iso-8859-1?Q?a2fnL12sq8Fx8jYZ1/pwZ5eim3kFmWfb8+GEt8VyLSF/jnW8dI8e9UI8Yd?=
 =?iso-8859-1?Q?5upD36lz9FUOTm1ch8EZ+GA6NT3aNVTD4zP6kwau5lNvi1vvgdKfgINtz1?=
 =?iso-8859-1?Q?2T9io8lxhPGet3jh4zsn8jMHnRVp3EOjdmkioXFR01FgcjVl0piRdIAtOb?=
 =?iso-8859-1?Q?24OSB1sh1OKWvwD2kQBYdcWjn9IJQ6sM/jXsDzgKGsUFG7kf1uuce+swIX?=
 =?iso-8859-1?Q?mFhtzue1iFddevuO3abATiKptv1NJjO/aU6S+0Sw3LR2etaPUFnTT3UzYI?=
 =?iso-8859-1?Q?PUUwGrEncnGFeR3unUPKO1j1KHhHePXH+4khf1WuA6albZYaD658d9a+XD?=
 =?iso-8859-1?Q?wIM7WgtW3PFSCzQaCcuxX+8xH/rVnGdmn0AKMTRpNf7EKVkifQ/vnKAfrl?=
 =?iso-8859-1?Q?gI53uSWdXg6CVHBmg4dfRJ0XXaTXJcYZpbX0bs0zMo3oVtuioT1JUIooKE?=
 =?iso-8859-1?Q?5F0hTtPqN2J9HCJuWtW3no3z+K/Vs9HL6ujyXmywql5ygLBFV+CSmrh2NC?=
 =?iso-8859-1?Q?900PVFViOUxcaOtD5xxdPGenPvYU3o0JEKeuKi5o/3FgRkdxWbzgPNT9Ze?=
 =?iso-8859-1?Q?PorMPn8jJJfgwPfdNoNmnnS53+K0eQ5JTQkHmm0eqOrxKvSoyGrAgfL19I?=
 =?iso-8859-1?Q?CWUHzc3Ft3fiKyuBZ2JtRGFbMb/PLx2oAHTmXFOjSEBq/VkEsO5FJoa6tP?=
 =?iso-8859-1?Q?XekGzgeBCcrc9XbGxfV2wo1hvIMTwLW8CkOnkRpQovNCxE67uP+Hc2e1GZ?=
 =?iso-8859-1?Q?pMcMTSgSCH8lEpxzrdLYlvvo5r3VThZrMjUqKXc/FCOrh03x8guVFKbTMh?=
 =?iso-8859-1?Q?w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?rYa8CXAirueSVIKi3oMwabCjOSf8sUeNn5AtAj1IBXfWlmaKYzVBSgHICD?=
 =?iso-8859-1?Q?xxGTQSFatMZ+fT1TYWdATw4LhEhC4ErrgnL4iydUs+atqO9vJQzLBybeQm?=
 =?iso-8859-1?Q?ft6V7JNcrqqM94nAgiF0HHvXclnG502gwwL8UWqHbSf8kstmF103BBi3uk?=
 =?iso-8859-1?Q?gjfR11VFEUgNFUhP99SA4I6w58lM90f6IBTmaItIwWArPAxTKoCQv1Cx6T?=
 =?iso-8859-1?Q?wZ6YkM3xFdDq/rODhnv1h9UyhVUDK9EuKZ96/8d4iXzxxEoiKi+kjOmcv+?=
 =?iso-8859-1?Q?YsB7tud4p7ZG/S1CRxf8c636ltw7PiOmKvspBUBRoIN8UdhWqWszg9sfg2?=
 =?iso-8859-1?Q?SYrvYq09XmFxll/bj73zqm7cEszLCy3c0ZDeVzpyF1mHfahmg2vE/oEgmK?=
 =?iso-8859-1?Q?nH0d6izuV9Ax7OnSUwB6v51y6g+Vu2OIjImExbh6CN+vsC4E6KJ1SD2Tk2?=
 =?iso-8859-1?Q?PLp1EhGmSdrZ6SWlVQx1Xh21yMKCdLIY39Xlo/+bGaUKM4K63CqTucpSro?=
 =?iso-8859-1?Q?9ZWUOrrZWnVirm0C1DwuLDdOA6hkDLIBNAvSTrczfB/JJqvnArIy2d0bb8?=
 =?iso-8859-1?Q?hn30Vta2XtIsy74uhBlJd39eLHK5Z7g8lj2T21U7xhKzYu8mEYh6wQ9Pt+?=
 =?iso-8859-1?Q?GvMGAHdVHV9VpbYvMO0l71QZusk+PgLgKv3Lz63nUj5O1E5BX8YjM7Chq8?=
 =?iso-8859-1?Q?O57VIUnBJ/vw+PY1sUOqdmEpsNLlULn4Fhmx6HyTLomAj+nRu/gt1wJ9wE?=
 =?iso-8859-1?Q?rtX+SmvGweyrRA8AI38VFeA/A5V1gs1IQuaY9ArGpWlfLjjW7IWUJwDVck?=
 =?iso-8859-1?Q?k/u+70qnP2jGlTc8nm5/UUKILnHM8r9EPN/s4G5QGJs21WF6dJo6NQValU?=
 =?iso-8859-1?Q?/nlWtGEDUpVLsETR+cuVzQduGyyztAhf1Vj2bcZVhOPKUF/tLAVP7imcgY?=
 =?iso-8859-1?Q?ug+coBak9IKH5s2uaMDBVUpv3I9j6usDveFSUtZVwEZ+uML0MR4IylTmAE?=
 =?iso-8859-1?Q?Y0GgwekALSTcYsPdtNErtEcBEk2APB1fSXSzvXdIyvr3LUvgPrPAPnSrLt?=
 =?iso-8859-1?Q?/77aCJpxNPBSNysXxmeVnybI1jMY5jttyj7AlaQmCZ37wbkrtpPPSQYsQM?=
 =?iso-8859-1?Q?StcAiVsGaDZBXr9O2pJzMUrdvRKIiGiznL5VG3qQkVM+ZfXj4VcS+iFx+n?=
 =?iso-8859-1?Q?aHY6N6TH+PrVYiwH3TFooypwhls/zlwiS4hj0694irXb/ZKPbduAQZ3D18?=
 =?iso-8859-1?Q?4qjANWEzyD8d8NJcdPVpA7lJ8n7WCHD1y/fuTLsDBFb82sbmfBMru8enIQ?=
 =?iso-8859-1?Q?wtwpwztsvigTJHM+/+NT8adA6DtTIBtRYMFyx5t2Yw98ihVKqTwl+yZ8Ki?=
 =?iso-8859-1?Q?YdcAcrWhEwK1V7KuJg71iOboRt84RS6vmeOKuL2W26KiDKYhEfrUh0ilxo?=
 =?iso-8859-1?Q?avbF5gxr+msXV6kMkQnaNtrrwdkr29IB13U3z6JKg+Fi7J05Acl9wUpsD3?=
 =?iso-8859-1?Q?J8qa5sWaV5IBWo+pzgUyIg1g0qkFEVuLau2l/HMfPv98ZNFqb8tzXL3jee?=
 =?iso-8859-1?Q?T+xA5ODmMfWV+Y9Rjxl/EcOtgv5VkKVHQvs7lR/ihLB7LRKsvuFHCSSJp7?=
 =?iso-8859-1?Q?8vXBVNCAnjsJJb6EZSZGRdsNs/oapDgAje?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6922c96a-7f7f-47f4-820c-08ddf5ddace2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 11:30:59.5508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLlNnMVdjaDIZqq1AA+ukfunasKWx4FvEPyLJa5WTEhnvqqAli2O3xVB6tqHC6ChtkHhChJzI9O725bcplKpXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990

+ Linus Lüssing

Original patch: https://lore.kernel.org/netdev/20250912223937.1363559-1-Joseph.Huang@garmin.com/

On Mon, Sep 15, 2025 at 06:41:19PM -0400, Huang, Joseph wrote:
> It seems that inet6addr_notifier_call_chain() can be called when the address
> is still tentative, which means br_ip6_multicast_alloc_query() is still
> going to fail (br_ip6_multicast_alloc_query() calls ipv6_dev_get_saddr(),
> which calls __ipv6_dev_get_saddr(), which does not consider tentative source
> addresses).
> 
> What the bridge needs really is a notification after DAD is completed, but I
> couldn't find such notification. Or did you mean reusing the same
> notification inet6addr_notifier_call_chain() but with a new event after DAD
> is completed?

Adding a new event to the inet6addr notification chain makes more sense
than adding a new event to the netdev notification chain.

But before making changes, I want to better understand the problem you
are seeing. Is it specific to the offloaded data path? I believe the
problem was fixed in the software data path by this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0888d5f3c0f183ea6177355752ada433d370ac89

And Linus is working [1][2] on reflecting it to device drivers so that
the hardware data path will act like the software data path and flood
unregistered multicast traffic to all the ports as long as no querier
was detected.

As a temporary workaround, you can either configure an IPv6 link-local
address on the bridge before opening it:

 # ip -6 address add fe80::1/64 dev br0 nodad

Or enable optimistic DAD:

 # sysctl -wq net.ipv6.conf.br0.optimistic_dad=1

[1] https://lore.kernel.org/netdev/20250522195952.29265-1-linus.luessing@c0d3.blue/
[2] https://lore.kernel.org/netdev/20250829085724.24230-1-linus.luessing@c0d3.blue/

