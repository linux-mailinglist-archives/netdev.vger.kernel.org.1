Return-Path: <netdev+bounces-193268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F3AC35D4
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 19:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB251665B5
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5501F7092;
	Sun, 25 May 2025 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GXTbaVio"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B25FEE6;
	Sun, 25 May 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748193239; cv=fail; b=lQlVhDJNmyMksPrufFkcdnHAwdC7DICmL52FRvd1UR6QJTL9W9JDeod9cBYAngJm/y5hli5XwEpNZfmbKEQshmAo+FwnweuikjgwU4yZQQTx+QOcFnshrp80rx2HJhgTYkTJw08Dqx9UYbB5Di2wD70viU1HZ0E2ZeMeJp02P4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748193239; c=relaxed/simple;
	bh=xLtmexhRYaw8Ta6ViQMJwKQ5sJG5dp7qONd+FXV6Uo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MRLXad7AMd1fh5oe4GPPciiVDlc4VpF136T9pq/16BGnZvhWgwORqhcEMFpgm2Ldwdke3+/c9tEys20vzi7UD0IhQhBeZMIqSKR6RUQqU2kO//Pr4t9Z26r2/TejL7+H+SNWmfdB0cJTymfwGYv4NxhzNfT9mEb9nhIyuHlEyOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GXTbaVio reason="signature verification failed"; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfxF1/8yNIeQMQwJPgsYOwQTmVdJN6civ3CCCeQtXuNeil3+BJqWnE72wVdXFU/b1yVXfqfVTpjHZ0q6g+A76e+hx20TWmwI3q2nOYPhnSgqtySGztfTghAciSQNrSyNQlCuXeokWc4vBNfNGzIgLWRCQF86Ki0nVfP599opbpcvZ1JscX9tLLeyhO6VwdWLhPkWahfIHKAJYYcVJTySDFAziAxtM+/lQhB5HLp6PT35nngAYiw5W8APpHBWzLQlGN1Wftj+ooy0zywSEShz0TCZ0yfSCoyE5f3JzOiodFZD0iC00HujTT71rS0JjcbZbYQAOvcy6GSYmwBKD6XEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Og6HeZtebOUlSU4jHWgPGowptUW2QyoxUpNo+10FQg=;
 b=my4cI3MheGfhlGsOb7VUDhomTiWLHCu9EgXEZJf3n+FHgDtSkhcbNaeH0keVYxSKDmBzxnxG+ntU08Y3ugReXRotkxYP2MORc2z5evZNpR6XmZEgpqwZAxJp3UFEFOX0c0ed/2FwEMgbtOFQ7+47eHTp7mN1R9z0umB+589BKHa7/PfhlZlmQS4MACLDBeIe7As7jvABhTVFYRj7HTrfdKxLiJTetofBO1I2Lc5PEoUNGfTbmk2UFxm/RclJ4Z8l5D9moRpZRY90A/hDqJKGjhLL1QExAfIdNxhXUUOrEvIduGcg0LnFglZbkGKCAgLSCn4A6smLSA+4nvNtbeuKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Og6HeZtebOUlSU4jHWgPGowptUW2QyoxUpNo+10FQg=;
 b=GXTbaViotaM5waBWnN0EhzCcbV892Nxe5IK8SJqUUX2YB+HQP3juRcv47WPq7qRFvn3JFqend7xW2AmJn4WCZYl26njvt5khHHtpJ3CIcsRTGxilG7HvkJz34I8WQkmus4FHTQm749lNK/d/BuzjOJOFEYK8+D+boSNrj/kebLj47+cAGfAfG2WqIKRf8NaWRXJIIoWTONvesXzgDlFe7eEGUGiOHubYKHSeYtJzbXHgtREyCRhBK75HIDPJ22cVthRoNqtTgZRsz2NXmVyMVBshtGCHVAL13eCj3vkiOwO8S1ALGczsJThIpNxczePud/2r5H8W/qgO77jtjcwC5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.24; Sun, 25 May 2025 17:13:51 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8769.019; Sun, 25 May 2025
 17:13:51 +0000
Date: Sun, 25 May 2025 20:13:41 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	openwrt-devel@lists.openwrt.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ivan Vecera <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Jan Hoffmann <jan.christian.hoffmann@gmail.com>,
	Birger Koblitz <git@birger-koblitz.de>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next 1/5] net: bridge: mcast: explicitly track active
 state
Message-ID: <aDNPxdmDPYwasUEM@shredder>
References: <20250522195952.29265-1-linus.luessing@c0d3.blue>
 <20250522195952.29265-2-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250522195952.29265-2-linus.luessing@c0d3.blue>
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: a3deecac-c571-429a-840b-08dd9baf8551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?cvQ1DNuV82ltLziCIvdfRcT+Ocb3ZMRJitQ/YEr9qnVMQDeUMIN45KEcrN?=
 =?iso-8859-1?Q?c67HLr11lcWQ4Zel2+84Bo3sCx6Ev6qhQWYqMuTAzhUYmS+qHTSyZQIPuB?=
 =?iso-8859-1?Q?HQ+r8rfalCXsWvf1n/T08u/dLzWcQ66O8dGgO1c+4oOOlTLFWD3bCsn0Qz?=
 =?iso-8859-1?Q?kt6KcjGTwYaS/CYnO36H5bVTRdzPjZtno3E6RwZrQ8sKWdRtB97Jw3bZa8?=
 =?iso-8859-1?Q?B5O11asJ/+1klMTyaev19v1WoMmfFie8spDwTlkiKAxGxmktF6+jvYJMXP?=
 =?iso-8859-1?Q?lAAMwdpOIl8pVKTds25t8yKZZHJl8EhF+8S3ohXq2rgrRgz6dqoeZzQSFS?=
 =?iso-8859-1?Q?8hhYqtZumCKy2XeXkJPzegfmZJ2uik2ox/JlGfqLlKwf+dcxWa2E4XO3QC?=
 =?iso-8859-1?Q?BZxq2yzggpOaI+mkXN3Oso7WAb4rZ7Vvu636zxyj1k/JkY38YPKZ7Co4pJ?=
 =?iso-8859-1?Q?hkOLnoAKwj8j56mlWPAuE6bkKGVMlGw1pyeuR3thJkGAepmF4EpPLkZ70z?=
 =?iso-8859-1?Q?RNcaHhmrlgMIKA/TuRROJKbMqZP2cqoHSA5WZybJAAlmDyjPNkwYiJ1trP?=
 =?iso-8859-1?Q?+sGyQB5y7rkkH651v4L/6hZEHGpZfmqsRgAD+E/o6JEFjrc+ZcI5fSTbY1?=
 =?iso-8859-1?Q?+7VF32zzzSsRsQhXllxBAeHtmtoA2zSrrGIwQixKwg5A2da1QF2HJHgcPN?=
 =?iso-8859-1?Q?LDqgIbx2qbe0upx8X8Uwf7K13PveU0MXVyH2Tv505uiMBQLoS0pB3tUG7d?=
 =?iso-8859-1?Q?nIVO13C6Hs2c9qAI9R8psDgpIF/f6RlLQl1EtkKxvnh6itUoC/QHkvs0/y?=
 =?iso-8859-1?Q?L7+/u458a8JlGp3cK/5Cqbg6cL9bpoqip8UG8Z2baL83deJhJiROoU4oXe?=
 =?iso-8859-1?Q?W7QqcxoZCFTteSni3n0NiAZD4dKYwH2rgTsXK0XdLDWCgszj23P8BSQCBX?=
 =?iso-8859-1?Q?NeKrqWDkZVeBczrWhsDvh6kv+dRMz/c3Msij9dmU4CcJSH6Z+W4Ahmxi9E?=
 =?iso-8859-1?Q?hwPy1PGcSeiqiXhhMrIVWmcrErKMSGyjSkuHsi/nhnXDqMO7oeiAgL+/1a?=
 =?iso-8859-1?Q?1upfbXHZHRzgBPblm/xCSavMs+THP+R8SCjE6OscnEkQGH+iEITanRlMgd?=
 =?iso-8859-1?Q?U7bTW2rwaDKqCe9Zgdoz8Jru1nK92AMoWbdU4MoWbW04iLUCQDognn5FUp?=
 =?iso-8859-1?Q?fAcGwrYPcJCpmNvE7GY4sJvpJK6jCEdpF3V6wCF1HudrkcFflZExZQbsLW?=
 =?iso-8859-1?Q?npr8NtyEUr9Hbwn9+LPqEExZTzLWg501e79nMWfMQQy2iXNWJWKtMdWO1B?=
 =?iso-8859-1?Q?L7LMaU+QcWSj6WhLMopkHafezCpVi8J0I5mF2PeZ/bc4GKbuhJEo9uDYJx?=
 =?iso-8859-1?Q?aeEjJIyqYJDLInuf0KYYAefD62iOuJNA3j4UcwkGZUTwasnoXktURL5F/j?=
 =?iso-8859-1?Q?+ABe06s2skM3PMEACW3sHHFAjBywS/AzMOrhvbIPn4/myliTxSgYn3BmMw?=
 =?iso-8859-1?Q?Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Vo1Q7j2KDy5rtcsMnCCgoPn7cZOyFtmry9tgaOkQOJCT18Q7OOcZL/VRg7?=
 =?iso-8859-1?Q?eP7n3AAqDhGqZ+3IJjeIWA4u81qlR2m4JGeG1sO1vFXIxNUR7pS9SDT1is?=
 =?iso-8859-1?Q?LghGExpceyELFEVL06n/GLEFNgQ5e5rtuIg+jM7XuRJ8KV+QI2uFwjBVgo?=
 =?iso-8859-1?Q?Ox0ZR9xAgMrf9/yeCmrkJ+DQp51xBb/dBXirMtq4z29/tGUwW3B0Y2yfQm?=
 =?iso-8859-1?Q?XGtRb2sMq+vysAJTXT7APRiceWFYNcKcfoIoGhg49I7sOs56EyDd7jYQo4?=
 =?iso-8859-1?Q?ZPTl6oywvePjvE8f8MemBM7UU+bCr1l+0JVLsGpf0v5YWCO/N8bx9QJ7dA?=
 =?iso-8859-1?Q?u0HZKQqanNd47Eda8HEPUA5FYaxIq+KD8+4Y+oStWBlavh+k0ijALvY9mV?=
 =?iso-8859-1?Q?DhTEstq++/t3+a9JwT2a30DtllSLmK5+IWw1N8mZfFNf9LKgo5qj5dZ07l?=
 =?iso-8859-1?Q?+ATvIpxrJSglJH+4nmhs/3jbXEBarYFL/FgXBukwmqqs6krwrdoGpdgubR?=
 =?iso-8859-1?Q?dTY0rr8idm8HHIAVmL2wm7hKrcJ/+Awe9r2WgyYUS7tghmU2zRkM5JprZR?=
 =?iso-8859-1?Q?Ih7aNRxF2XXoIVhvDElp27/n5vFz++yUh899/mGK+vmZKwI2vDdFOyadPm?=
 =?iso-8859-1?Q?edB+4OgbA4AEsGRtae+5xWDtDe6l88mXvIBEVv2PhWpA46DqsqyJOexZuL?=
 =?iso-8859-1?Q?0/O9DNV6K5PEQnot6b4GxWhFI471qLuIwC7yAV36w+wWocYU9neY3CwZ9m?=
 =?iso-8859-1?Q?ukATFQJkAWfdxD3hBMeim2hTmwdg5BcQMTnHTbEoTCCOnNJ/2XO3xHbhMj?=
 =?iso-8859-1?Q?tP9xvz8p0OQ57kIknb+jCtV8QT7VrdxSIMgKRGTj4GmXE69oiUGbaY3ICl?=
 =?iso-8859-1?Q?fLxpcAHQ+r1lozKLykVILlPCwhEOldU0+OLM9T7sJ9G586PcrC1prToiXt?=
 =?iso-8859-1?Q?h7e/zygsy+94TUQKvVuqHmrKuEIC4wwQyGJ+o0NbIaKLOby2NgQ+DK6n19?=
 =?iso-8859-1?Q?mnv5gSWJj+SHx66ovYuTfXdvHqMRnix324jgAgQx9wKG/y8vFT32agqtVL?=
 =?iso-8859-1?Q?bcex90sreXhgn34hBzhcd/76Yj94EZTSDjNMyccV+unwEq84VAm6yfOtZX?=
 =?iso-8859-1?Q?Hv0wvXudt6OWmcLJbFb8Nfi+kcGPnPnl2k0x5+H60Bc38dpp/yC6pQsz0Q?=
 =?iso-8859-1?Q?XwGW7WM+2qDKNWkl/+X0ClJDNsaK0mA2xboD42XJqICGg6jXhd3oxhGtxv?=
 =?iso-8859-1?Q?lIY8cIw+tcWQq+NMVnLesRhj3UA9lm0AOETi9BbiAyYY3uM69OjstWq5DQ?=
 =?iso-8859-1?Q?tz7VZ3IMgARPR+l6hXQtEtqZm5zqx5hgRyQYMmrJ8bLi5ibczARpI41B4m?=
 =?iso-8859-1?Q?ErqiL9U/rQt/pqrb2vUGgW0MfBXDWpvsFziK18RfDTyVE3MwN6lQO1W+C2?=
 =?iso-8859-1?Q?k0y0WjpDdF0iLz3uAN5fX+leOZVxWJIIiIB6pIjadD/om7bKsE3BYIqYUk?=
 =?iso-8859-1?Q?ytrZ5Ld9JqCA3196hfcq7+1AeQMluB/+BJXE9hOF+rw9UkZHGG5CdEINDt?=
 =?iso-8859-1?Q?fuBOdEotLXQIAgE7IXWq+Tt9oXMwSepGn3DuRDUMPU+6zw9CJZr1g3ENvV?=
 =?iso-8859-1?Q?AP66YXakoNUQaaY4WcY04jZWKDSLfdc2o7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3deecac-c571-429a-840b-08dd9baf8551
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 17:13:51.7266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbLuABGoWiuNuig/seuTmQrdMLLGxLgR4w8d1pwu1biho/dzzlJKNheV5/89va2BMuz7pZIikbutEGAhrublrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389

On Thu, May 22, 2025 at 09:17:03PM +0200, Linus Lüssing wrote:
> Combining and tracking the active state into new, per protocol family
> variables.
> 
> For one thing this slightly reduces the work and checks in fast path
> for multicast payload traffic. For another this is in preparation to
> be able to notify DSA/switchdev on the (in)applicability of multicast
> snooping on multicast payload traffic. Especially on vanishing IGMP/MLD
> queriers.

Adding more code in the control path in order to simplify the data path
makes sense, but IMO this patch is difficult to review and should be
split into smaller patches. At the very least the patch can be split
into a control path patch and a data path patch. The latter simplifies
the data path by making use of the new multicast states maintained by
the control path.

The control path patch can be split into smaller patches where each
patch updates the multicast states from the different places that affect
them:

1. When the delay timer expires.
2. When we stop getting queries.
3. When the bridge gains or losses an IPv6 address.
4. When "mcast_querier" is changed (globally or per-VLAN).
5. When "mcast_snooping" is changed (globally or per-VLAN).

Given the number of patches, consider splitting the offload changes into
a separate patchset. It would probably be merged faster that way.

See more comments below.

> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_device.c    |   5 +-
>  net/bridge/br_input.c     |   2 +-
>  net/bridge/br_multicast.c | 179 +++++++++++++++++++++++++++++++++++---
>  net/bridge/br_private.h   |  33 ++-----
>  4 files changed, 180 insertions(+), 39 deletions(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index a818fdc22da9..315ed3d33406 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -102,7 +102,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
>  		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
> -		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst))
> +		    br_multicast_snooping_active(brmctx, eth_hdr(skb), mdst))
>  			br_multicast_flood(mdst, skb, brmctx, false, true);
>  		else
>  			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
> @@ -168,7 +168,10 @@ static int br_dev_open(struct net_device *dev)
>  	netdev_update_features(dev);
>  	netif_start_queue(dev);
>  	br_stp_enable_bridge(br);
> +
> +	spin_lock_bh(&br->multicast_lock);
>  	br_multicast_open(br);
> +	spin_unlock_bh(&br->multicast_lock);
>  
>  	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
>  		br_multicast_join_snoopers(br);
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 232133a0fd21..0c632655d66c 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -187,7 +187,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  	case BR_PKT_MULTICAST:
>  		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
>  		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
> -		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
> +		    br_multicast_snooping_active(brmctx, eth_hdr(skb), mdst)) {
>  			if ((mdst && mdst->host_joined) ||
>  			    br_multicast_is_router(brmctx, skb)) {
>  				local_rcv = true;
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index dcbf058de1e3..b66d2173e321 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1069,6 +1069,125 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
>  	return skb;
>  }
>  
> +static bool
> +__br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> +			      struct bridge_mcast_other_query *querier,
> +			      const bool is_ipv6)

Remove the const?

> +{
> +	bool own_querier_enabled;
> +
> +	if (brmctx->multicast_querier) {
> +		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
> +			own_querier_enabled = false;
> +		else
> +			own_querier_enabled = true;
> +	} else {
> +		own_querier_enabled = false;
> +	}
> +
> +	return !timer_pending(&querier->delay_timer) &&
> +	       (own_querier_enabled || timer_pending(&querier->timer));
> +}
> +
> +static bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> +					struct ethhdr *eth,

Make this const or just pass the EtherType?

> +					const struct net_bridge_mdb_entry *mdb)
> +{
> +	switch (eth->h_proto) {
> +	case (htons(ETH_P_IP)):
> +		return __br_multicast_querier_exists(brmctx,
> +			&brmctx->ip4_other_query, false);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case (htons(ETH_P_IPV6)):
> +		return __br_multicast_querier_exists(brmctx,
> +			&brmctx->ip6_other_query, true);
> +#endif
> +	default:
> +		return !!mdb && br_group_is_l2(&mdb->addr);
> +	}
> +}
> +
> +static bool br_ip4_multicast_check_active(struct net_bridge_mcast *brmctx,
> +					  bool *active)
> +{
> +	if (!__br_multicast_querier_exists(brmctx, &brmctx->ip4_other_query,
> +					   false))
> +		*active = false;
> +
> +	if (brmctx->ip4_active == *active)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int br_ip6_multicast_check_active(struct net_bridge_mcast *brmctx,
> +					 bool *active)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (!__br_multicast_querier_exists(brmctx, &brmctx->ip6_other_query,
> +					   true))
> +		*active = false;
> +
> +	if (brmctx->ip6_active == *active)
> +		return false;
> +
> +	return true;
> +#elif
> +	*active = false;
> +	return false;
> +#endif
> +}
> +
> +/**
> + * __br_multicast_update_active() - update mcast active state
> + * @brmctx: the bridge multicast context to check
> + * @force_inactive: forcefully deactivate mcast active state
> + * @extack: netlink extended ACK structure
> + *
> + * This (potentially) updates the IPv4/IPv6 multicast active state. And by
> + * that enables or disables snooping of multicast payload traffic in fast
> + * path.
> + *
> + * The multicast active state is set, per protocol family, if:
> + *
> + * - an IGMP/MLD querier is present
> + * - for own IPv6 MLD querier: an IPv6 address is configured on the bridge
> + *
> + * And is unset otherwise.
> + *
> + * This function should be called by anything that changes one of the
> + * above prerequisites.
> + *
> + * Return: 0 on success, a negative value otherwise.
> + */
> +static int __br_multicast_update_active(struct net_bridge_mcast *brmctx,
> +					bool force_inactive,
> +					struct netlink_ext_ack *extack)
> +{
> +	bool ip4_active, ip6_active, ip4_changed, ip6_changed;
> +	int ret = 0;
> +
> +	lockdep_assert_held_once(&brmctx->br->multicast_lock);
> +
> +	ip4_active = !force_inactive;
> +	ip6_active = !force_inactive;
> +	ip4_changed = br_ip4_multicast_check_active(brmctx, &ip4_active);
> +	ip6_changed = br_ip6_multicast_check_active(brmctx, &ip6_active);

ip{4,6}_changed aren't really used in this patch. I suggest adding them
when you need them. In addition, br_ip{4,6}_multicast_check_active() are
quite confusing to me. They return a bool, but also modify a bool
argument. It would be clearer to derive the existing states from
brmctx->ip{4,6}_active and then derive the new states from something
like br_ip{4,6}_multicast_can_activate(brmctx)

> +
> +	if (ip4_changed)
> +		brmctx->ip4_active = ip4_active;
> +	if (ip6_changed)
> +		brmctx->ip6_active = ip6_active;
> +
> +	return ret;
> +}
> +
> +static int br_multicast_update_active(struct net_bridge_mcast *brmctx,
> +				      struct netlink_ext_ack *extack)
> +{
> +	return __br_multicast_update_active(brmctx, false, extack);
> +}
> +
>  #if IS_ENABLED(CONFIG_IPV6)
>  static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brmctx,
>  						    struct net_bridge_mcast_port *pmctx,
> @@ -1147,10 +1266,12 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
>  			       &ip6h->daddr, 0, &ip6h->saddr)) {
>  		kfree_skb(skb);
>  		br_opt_toggle(brmctx->br, BROPT_HAS_IPV6_ADDR, false);
> +		br_multicast_update_active(brmctx, NULL);
>  		return NULL;
>  	}
>  
>  	br_opt_toggle(brmctx->br, BROPT_HAS_IPV6_ADDR, true);
> +	br_multicast_update_active(brmctx, NULL);
>  	ipv6_eth_mc_map(&ip6h->daddr, eth->h_dest);
>  
>  	hopopt = (u8 *)(ip6h + 1);
> @@ -1762,10 +1883,28 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
>  }
>  #endif
>  
> -static void br_multicast_query_delay_expired(struct timer_list *t)
> +static void br_ip4_multicast_query_delay_expired(struct timer_list *t)
>  {
> +	struct net_bridge_mcast *brmctx = from_timer(brmctx, t,
> +						     ip4_other_query.delay_timer);
> +
> +	spin_lock(&brmctx->br->multicast_lock);
> +	br_multicast_update_active(brmctx, NULL);
> +	spin_unlock(&brmctx->br->multicast_lock);
>  }
>  
> +#if IS_ENABLED(CONFIG_IPV6)
> +static void br_ip6_multicast_query_delay_expired(struct timer_list *t)
> +{
> +	struct net_bridge_mcast *brmctx = from_timer(brmctx, t,
> +						     ip6_other_query.delay_timer);
> +
> +	spin_lock(&brmctx->br->multicast_lock);
> +	br_multicast_update_active(brmctx, NULL);
> +	spin_unlock(&brmctx->br->multicast_lock);
> +}
> +#endif
> +
>  static void br_multicast_select_own_querier(struct net_bridge_mcast *brmctx,
>  					    struct br_ip *ip,
>  					    struct sk_buff *skb)
> @@ -3981,16 +4120,13 @@ static void br_multicast_query_expired(struct net_bridge_mcast *brmctx,
>  				       struct bridge_mcast_own_query *query,
>  				       struct bridge_mcast_querier *querier)
>  {
> -	spin_lock(&brmctx->br->multicast_lock);
>  	if (br_multicast_ctx_vlan_disabled(brmctx))
> -		goto out;
> +		return;
>  
>  	if (query->startup_sent < brmctx->multicast_startup_query_count)
>  		query->startup_sent++;
>  
>  	br_multicast_send_query(brmctx, NULL, query);
> -out:
> -	spin_unlock(&brmctx->br->multicast_lock);
>  }
>  
>  static void br_ip4_multicast_query_expired(struct timer_list *t)
> @@ -3998,8 +4134,11 @@ static void br_ip4_multicast_query_expired(struct timer_list *t)
>  	struct net_bridge_mcast *brmctx = from_timer(brmctx, t,
>  						     ip4_own_query.timer);
>  
> +	spin_lock(&brmctx->br->multicast_lock);
>  	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query,
>  				   &brmctx->ip4_querier);
> +	br_multicast_update_active(brmctx, NULL);
> +	spin_unlock(&brmctx->br->multicast_lock);
>  }
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -4008,8 +4147,11 @@ static void br_ip6_multicast_query_expired(struct timer_list *t)
>  	struct net_bridge_mcast *brmctx = from_timer(brmctx, t,
>  						     ip6_own_query.timer);
>  
> +	spin_lock(&brmctx->br->multicast_lock);
>  	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query,
>  				   &brmctx->ip6_querier);
> +	br_multicast_update_active(brmctx, NULL);

It is not clear to me why the new states are updated from
br_ip{4,6}_multicast_query_expired(). These functions are called when
the bridge is the querier and it is time to send a new query.

Did you mean to place these in br_ip{4,6}_multicast_querier_expired()
which are invoked when the other querier expired?

> +	spin_unlock(&brmctx->br->multicast_lock);
>  }
>  #endif
>  
> @@ -4044,11 +4186,13 @@ void br_multicast_ctx_init(struct net_bridge *br,
>  	brmctx->multicast_membership_interval = 260 * HZ;
>  
>  	brmctx->ip4_querier.port_ifidx = 0;
> +	brmctx->ip4_active = 0;
>  	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
>  	brmctx->multicast_igmp_version = 2;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	brmctx->multicast_mld_version = 1;
>  	brmctx->ip6_querier.port_ifidx = 0;
> +	brmctx->ip6_active = 0;
>  	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
>  #endif
>  
> @@ -4057,7 +4201,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
>  	timer_setup(&brmctx->ip4_other_query.timer,
>  		    br_ip4_multicast_querier_expired, 0);
>  	timer_setup(&brmctx->ip4_other_query.delay_timer,
> -		    br_multicast_query_delay_expired, 0);
> +		    br_ip4_multicast_query_delay_expired, 0);
>  	timer_setup(&brmctx->ip4_own_query.timer,
>  		    br_ip4_multicast_query_expired, 0);
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -4066,7 +4210,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
>  	timer_setup(&brmctx->ip6_other_query.timer,
>  		    br_ip6_multicast_querier_expired, 0);
>  	timer_setup(&brmctx->ip6_other_query.delay_timer,
> -		    br_multicast_query_delay_expired, 0);
> +		    br_ip6_multicast_query_delay_expired, 0);
>  	timer_setup(&brmctx->ip6_own_query.timer,
>  		    br_ip6_multicast_query_expired, 0);
>  #endif
> @@ -4171,6 +4315,8 @@ static void __br_multicast_open(struct net_bridge_mcast *brmctx)
>  #if IS_ENABLED(CONFIG_IPV6)
>  	__br_multicast_open_query(brmctx->br, &brmctx->ip6_own_query);
>  #endif
> +
> +	br_multicast_update_active(brmctx, NULL);
>  }
>  
>  void br_multicast_open(struct net_bridge *br)
> @@ -4209,6 +4355,10 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
>  	timer_delete_sync(&brmctx->ip6_other_query.delay_timer);
>  	timer_delete_sync(&brmctx->ip6_own_query.timer);
>  #endif
> +
> +	spin_lock_bh(&brmctx->br->multicast_lock);
> +	__br_multicast_update_active(brmctx, true, NULL);
> +	spin_unlock_bh(&brmctx->br->multicast_lock);
>  }
>  
>  void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
> @@ -4234,10 +4384,13 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
>  		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
>  		spin_unlock_bh(&br->multicast_lock);
>  
> -		if (on)
> +		if (on) {
> +			spin_lock_bh(&br->multicast_lock);
>  			__br_multicast_open(&vlan->br_mcast_ctx);
> -		else
> +			spin_unlock_bh(&br->multicast_lock);
> +		} else {
>  			__br_multicast_stop(&vlan->br_mcast_ctx);
> +		}
>  	} else {
>  		struct net_bridge_mcast *brmctx;
>  
> @@ -4298,10 +4451,13 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
>  	br_opt_toggle(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED, on);
>  
>  	/* disable/enable non-vlan mcast contexts based on vlan snooping */
> -	if (on)
> +	if (on) {
>  		__br_multicast_stop(&br->multicast_ctx);
> -	else
> +	} else {
> +		spin_lock_bh(&br->multicast_lock);
>  		__br_multicast_open(&br->multicast_ctx);
> +		spin_unlock_bh(&br->multicast_lock);
> +	}
>  	list_for_each_entry(p, &br->port_list, list) {
>  		if (on)
>  			br_multicast_disable_port(p);
> @@ -4663,6 +4819,7 @@ int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val)
>  #endif
>  
>  unlock:
> +	br_multicast_update_active(brmctx, NULL);
>  	spin_unlock_bh(&brmctx->br->multicast_lock);
>  
>  	return 0;
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index d5b3c5936a79..3d05895a437f 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -158,12 +158,14 @@ struct net_bridge_mcast {
>  	struct bridge_mcast_other_query	ip4_other_query;
>  	struct bridge_mcast_own_query	ip4_own_query;
>  	struct bridge_mcast_querier	ip4_querier;
> +	bool				ip4_active;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	struct hlist_head		ip6_mc_router_list;
>  	struct timer_list		ip6_mc_router_timer;
>  	struct bridge_mcast_other_query	ip6_other_query;
>  	struct bridge_mcast_own_query	ip6_own_query;
>  	struct bridge_mcast_querier	ip6_querier;
> +	bool				ip6_active;
>  #endif /* IS_ENABLED(CONFIG_IPV6) */
>  #endif /* CONFIG_BRIDGE_IGMP_SNOOPING */
>  };
> @@ -1144,37 +1146,16 @@ br_multicast_is_router(struct net_bridge_mcast *brmctx, struct sk_buff *skb)
>  }
>  
>  static inline bool
> -__br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> -			      struct bridge_mcast_other_query *querier,
> -			      const bool is_ipv6)
> -{
> -	bool own_querier_enabled;
> -
> -	if (brmctx->multicast_querier) {
> -		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
> -			own_querier_enabled = false;
> -		else
> -			own_querier_enabled = true;
> -	} else {
> -		own_querier_enabled = false;
> -	}
> -
> -	return !timer_pending(&querier->delay_timer) &&
> -	       (own_querier_enabled || timer_pending(&querier->timer));
> -}
> -
> -static inline bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> -					       struct ethhdr *eth,
> -					       const struct net_bridge_mdb_entry *mdb)
> +br_multicast_snooping_active(struct net_bridge_mcast *brmctx,
> +			     struct ethhdr *eth,
> +			     const struct net_bridge_mdb_entry *mdb)
>  {
>  	switch (eth->h_proto) {
>  	case (htons(ETH_P_IP)):
> -		return __br_multicast_querier_exists(brmctx,
> -			&brmctx->ip4_other_query, false);
> +		return brmctx->ip4_active;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	case (htons(ETH_P_IPV6)):
> -		return __br_multicast_querier_exists(brmctx,
> -			&brmctx->ip6_other_query, true);
> +		return brmctx->ip6_active;
>  #endif
>  	default:
>  		return !!mdb && br_group_is_l2(&mdb->addr);
> -- 
> 2.49.0
> 

