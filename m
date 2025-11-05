Return-Path: <netdev+bounces-235909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE59C36FD8
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 18:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E080C501455
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 17:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EB133CE8D;
	Wed,  5 Nov 2025 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qmypr00p"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83BB33C51B
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362001; cv=fail; b=ilbWf/8GP5tVzjzKZt+pwiGiHy/KG1rbr7ft8MXRvYjo60PNbvNWnkVi/51mEZ1Q/ZTqwiDhawhuZdtIXB32uxVsL7n3HIk8ohUXqftTtdjCl4bwFCdYZfppOySmvsR/zIYH4aGldvKUeysXbVZnzMQ7y3AtrHyyGthCPy3tMy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362001; c=relaxed/simple;
	bh=UTfTzM92X1V/7tB4jIJ2iMIcwNeUyJtkwURna6nMycg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XkUhX53m9t/vcWXovtJmN0hKP7f2OXEuLXsVnV//xFJC6dS//koZSFnkDShSLEpvKtlWs9u7MsxL/o5qHw5cbscBHV7ZzJ8EM28jaCpGVtr5E5TyFixTJTvRKRFLj2If1nc32n7Cam2V8qX5yLIilDeHoe2bYSzh6WjmaQNLZB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qmypr00p; arc=fail smtp.client-ip=52.101.85.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZa3oodar4aNPI3PHXlMFA+RJfi0Vvef2nBCMdmOKoJHBWgPfcBoMhMbIt9zglTLxWf2OZb5BxjEOx6U3byfYtV3VTsbBUb3KtdBBk/NpRS7QbYgIyA4gfNKJFGZwZFeu3QQ5IwbF+PoGlgMM8bj/UBSoA2Ubjk8qdE1SSSEh9iWdAtMiHcWBGd9gIcPSbq84mDuruSbsKCC4BPYZ1E/oIGxaOKIWos+hmqtGoEeuT890UJYhPEQ339NMDN1RqO01TyhAczL62fuPIn1uPadpKPeiEkXyTxugdI0JETFeRvpSmoZuU38gUCAS4zPC03EVQmqkaV6JJm5zZPFKyREZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1dIHVXcX0iujnBJkM7Q/rl98EThwNvw8IAWWGHWZ5s=;
 b=R6ys3doxIZs9i540CdZehuSwR0fCR2xVnxarfIOGCxbppGT2Zm1hgDm9hPJ/jNnHUrc+DcObAYEKREBCkJGk8GDGi2sAFUc1iaWSKRouxAC4NOUpyjMfUMVO6sbLiCpYUj0rqYy85Re59hDCaIubLgzBV9/OG32nxzeKBD0J63RaDsE2+LvDI1Cbgu0ApTH2tQLAxeN1uPeEiA10OdWduwvxi7oe3svZCPjLnF5DhNDJ8TLfiBwB44cYeXGFww3fifS0X64IOxefYs9FhIWb/UpRrUBiwBudXnM+5PF690VMFPm9wwQf90qHQquTUKhD7uDSrSyMBIkAS2Le0KZ4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1dIHVXcX0iujnBJkM7Q/rl98EThwNvw8IAWWGHWZ5s=;
 b=qmypr00p/vYX2pdybQ+io6qoqvClMlnoy+vyyNqUdw41BW6tAaxBRBdbuL/JHIP9ngfxvZB7FYx4AR5C84X25r7S7ByquQrmVPVz56rDKDPtW+pSEHqFIa3m4AdyBrwmeZZw0t0srFjpSL97rAHSvPPf2z5SyhMCqEgBGx2hxfSnE7n3y1ozAemW+sXFZqfq5bmNCyH3sE6QC1NEJh10Jvdmt+8MfphORF7n+5V4q++rTxet6WJIDnjF4mBAN/49kpRh7D9/0+hOUsW48GG4rB+CKupazH10+jzq6h4SGp+d76pV/dNIH6tpzF36cQRXMKC131lB4SuShOjMUTgyvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 16:59:55 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 16:59:55 +0000
Date: Wed, 5 Nov 2025 18:59:42 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tobias@waldekranz.com, kuba@kernel.org,
	davem@davemloft.net, bridge@lists.linux.dev, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, petrm@nvidia.com,
	syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2 1/2] net: bridge: fix use-after-free due to MST
 port state bypass
Message-ID: <aQuCfmZix1qlbFEZ@shredder>
References: <20251105111919.1499702-1-razor@blackwall.org>
 <20251105111919.1499702-2-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105111919.1499702-2-razor@blackwall.org>
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 735375f2-42bc-40b7-7875-08de1c8cbeb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bp/6RJGEpicHUpBZWUAwtvF7BkV6EKiizQwH70JD0tvM+gos4kO+RLEqKk0e?=
 =?us-ascii?Q?a9FJOzTInCDg5OgAD9nmRNvDaNaxtjNLRv0JBHmod/Z8N1ceRXgPSLCYCLJy?=
 =?us-ascii?Q?HIXB9Lf8kXO+Dt1kNDh/Rv9W9jcKClNJLroHgkeUIXYc6pgKbntFVntFaFRD?=
 =?us-ascii?Q?4G3i0h2akgT/VpkhvXhDrNXlDXrr8AMJ8CbQME6OmqD8Fq5JtZCN19zlU7Ee?=
 =?us-ascii?Q?uK/f1+ewKvbjP+rIeBn/DcbBBw5RxbKdrRs5AJ1kSs5cE41X8iNr2aNUYsNb?=
 =?us-ascii?Q?7hgiAhd24wQir964lHMCezyoIcmP71AHogLnHf3xJbmQMx906Sm0tzBu6xRA?=
 =?us-ascii?Q?QXbcLYlYcxTWbp382jFsNBVRQRoaPF0NjHQcsVCNjbs6k63jyPHWc8rkKk6h?=
 =?us-ascii?Q?7BiX81uwjs0DsyiapEJMZlYyqkH447hdWDfWkKN8fTTBi9wjBj5R3kU75org?=
 =?us-ascii?Q?EtWhhAL3iAW8NiBcymmJgX+rFK+XpdpPd7Ha+kTSXUPRtkfFGQgEGgLicwwR?=
 =?us-ascii?Q?eLO0B3RHitXtMwQ6kfYmCfthXQJTofu2lhk/XXM+O5ch+XqX2ZyahzORr3Ox?=
 =?us-ascii?Q?iZqzkmlRgZMRAJ+FR4MJIluGSohLDXvIaSssHKkN0sHugY14itvuYUu1uRGS?=
 =?us-ascii?Q?eRnXcxtdwMwMms3NbwB630pCbLP5wkrKSBv1PAMKqL15umyvYbXG7gbb/cHL?=
 =?us-ascii?Q?TRX4oTkpkC7tmJEu+URtb84Y/3oovEDOhSAuxaR3DMoJjGpba/mkLNx4SMKz?=
 =?us-ascii?Q?4pmsOh92sRHUaUYmr4YG5SqaP3NaNTB/YsR8srVQYi+KXP41fAhmKphCgKEw?=
 =?us-ascii?Q?bZ8dYY/gYCLObFH66gg8EtJWHO6x7wcMEcLwDr7gMnvO+ZeGzJBf7Q+qzYOJ?=
 =?us-ascii?Q?YDD2WHk/gRP1jjRn2zFgsbERPD/Iu7WkwIfsxiotgRaHztcUUQGXjriN3FoY?=
 =?us-ascii?Q?fBFoJS5mikyr0VuvmIexq2IGcx9EntV38JwkGgaEukp6pjDzRTZnGOofXY/Y?=
 =?us-ascii?Q?dmjt2f5HsDXQD46CD23xHW2/Ec83Qt6+gDUoO/K9vXzZptDMRXB4mZmXiuof?=
 =?us-ascii?Q?j+J/TcqTLiMoAcrZ9BZI4y6QRrYxa3qep/exoZIQWBJVsjmtsTwumu0qqmFj?=
 =?us-ascii?Q?46VSXlC4D+1JgpLZbagkjEOytxRJdPY1yGlfwOdzlwYo/k4I9D6uRw3NICMZ?=
 =?us-ascii?Q?1nSpxtKtq0kXXesJm7Tqws2KQdVuSJc4v9hl5siLJE6pSTa20DHxzXoDxtfL?=
 =?us-ascii?Q?QIPsI8Tcdlvapjm6K2Y5yIAynmU5PC+8myod7O++cNuOxy4bMA/jDGOjzEss?=
 =?us-ascii?Q?kxoCibvwiIyQg0NVQS0MP5R3ELvPEb5uxRJB5d8dVtHxGcxCaHvf/mbXeHvF?=
 =?us-ascii?Q?LHNyHip/bpxi697ZadtXz7ix3OaQQE4emFflhF9j00mXIBgpGS9NhBqwwJmo?=
 =?us-ascii?Q?j67xMkVUQNZnkMWuydPQE9XcP10b2Wxo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qXb9+uXeHp7ViEGi1BfY/oqa8v00SjjK4vwdVzvSomTwLjUaU3M08NtVhHGV?=
 =?us-ascii?Q?EGA/OTeltL40xHHEnYIvvjWh8o6q+rBeK5cUZ6DXm4Db2J80ZPyQYf0zXeSS?=
 =?us-ascii?Q?D/gUxCnWllvocdqBO0PCdSVmG9XKKTCFSSfPVwHvzKYhUicgXHoWD0p7yIIX?=
 =?us-ascii?Q?IlBicFdpxYokzu+wEeAo4h3rc1+eNM+VLiLjO4tmo3zr1PBl5oulJ6zZEC2q?=
 =?us-ascii?Q?Y6qVjFLZhYfdlWbo2nYYuQ6R/aux9nS6gfs0BBZm7tMbEBp8KD+AHsGjKmpG?=
 =?us-ascii?Q?8kqzL8+PfD9LDF6uaZB2xcP5laV2w6okm2MvtISKN7ijJjqHj7qI06anCTTE?=
 =?us-ascii?Q?cXRsQS6DVGfSPxytNP/7mO9KxNGQo84o21hcYNQB6baMSOo+lH/yuarju6Dd?=
 =?us-ascii?Q?Tas36zq3XyMm2byd/Zq3/5dgpSR2+oqYJoi86PNim/mWELZReMaERUTZ+leT?=
 =?us-ascii?Q?TzpsflJJgMs2YWIPg57et60Eka0m345xx8jaehB/NzyDuW5UwdlUplCWjQPb?=
 =?us-ascii?Q?wTMlAuDGMAXJSj76w/a//1IZEmI3otzTS/zD5YIRQPslhLLG/BLNvcxWiju9?=
 =?us-ascii?Q?lWZwELECgyNNN9lxqjYYFsmscNSDrUsSJT468jD4mSTjR93w+mbZPG3/87Ty?=
 =?us-ascii?Q?ME1NBmMFpLxTxypBpbUOhOLPb1u10yyUglG/qtTtRKqhxPKuZOmLhmOm6uqk?=
 =?us-ascii?Q?ryRrcjjbflHORTMaeE0LtVnRelWPkjDD1tt5fh+5izDnYgIkKTjTtgI8xy2r?=
 =?us-ascii?Q?kQUxtj3zeP3ew3cQK6l3NlM/7z69tRSS4j5MrsbUGIifPy37RLWztaVCL8+R?=
 =?us-ascii?Q?wPBOCdg01c5izq79G6AaZKZh3eNPlLEX6ti2y7QAYKdSbdqTPA6vs+Y4SFrz?=
 =?us-ascii?Q?+56OUPa0jrsSfVbYRl8rBaFvHUQWsk+0/JCUgXNH4oMS7y1YgiGDeNyZ3qV6?=
 =?us-ascii?Q?sltCgxuoVhUmIC+D/SuuIG8OmTYOzceoLwJKunGcPPeNHOuzGXOTZkVed9Ox?=
 =?us-ascii?Q?juBHFBAl56yHTBUC/w6ZlKSIEcViul8yhDLh9dPghOnrBvVfVnfog2kKh2Z2?=
 =?us-ascii?Q?5bM5DRyrxuIyGNmBnlgopCJlVZ8sO5eDB7HhGTkz9JolBZQSVucLp0pR0dB+?=
 =?us-ascii?Q?VGW2gQXmQ6kC1Z31XaBUbw6nxWRCb9U1RHWVZ7oAai5ntgn6I1RuZNdz1qTg?=
 =?us-ascii?Q?LHZGuoIdsBVaDiEyse6x2Q/U9JY/5mwHF+paAWfXvQdNP1y83aD3drYbcaKO?=
 =?us-ascii?Q?FEptnxbD76uSRMtoSsw2VBqYEoceK6Xapmj+Ia9d4yaAnLhR3WyYRDIDplfN?=
 =?us-ascii?Q?A8OJtpv6fGXM9D1zJG+b2CjdKHYxxEIWtbcieyIoxTqOCa8/pLhUf230cJQW?=
 =?us-ascii?Q?ol9qqzdZr2lXkpB1w9h2s+RaQLa+UlWn1PQhR36OlnAoB4cgSLD7tiT/7GW1?=
 =?us-ascii?Q?zNeCmRap8iq88WKfXsq8M9Lgh6QawLxgZsKRSBH8ODRA2e2JFqseknWo0QF+?=
 =?us-ascii?Q?Qfd6m/iaJgCMSiyZRxf/DI4Je/q8Mgq2ExqN8oR9QmHxPiB1AkGmcYAAjjPM?=
 =?us-ascii?Q?8wu7IaXDu0L8fTgmmI9vyhQGcvfvh/lHpce7WJ/r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735375f2-42bc-40b7-7875-08de1c8cbeb8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:59:55.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9jKhFKrw/ik+Jey0aYlu8MN4vrKhhIyVI9LcfXkxJVoz52Tcy7w8L4OLj258mpudTayQ+obY8DUmUTJIp0tzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874

On Wed, Nov 05, 2025 at 01:19:18PM +0200, Nikolay Aleksandrov wrote:
> syzbot reported[1] a use-after-free when deleting an expired fdb. It is
> due to a race condition between learning still happening and a port being
> deleted, after all its fdbs have been flushed. The port's state has been
> toggled to disabled so no learning should happen at that time, but if we
> have MST enabled, it will bypass the port's state, that together with VLAN
> filtering disabled can lead to fdb learning at a time when it shouldn't
> happen while the port is being deleted. VLAN filtering must be disabled
> because we flush the port VLANs when it's being deleted which will stop
> learning. This fix adds a check for the port's vlan group which is
> initialized to NULL when the port is getting deleted, that avoids the port
> state bypass. When MST is enabled there would be a minimal new overhead
> in the fast-path because the port's vlan group pointer is cache-hot.
> 
> [1] https://syzkaller.appspot.com/bug?extid=dd280197f0f7ab3917be
> 
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Reported-by: syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69088ffa.050a0220.29fc44.003d.GAE@google.com/
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

