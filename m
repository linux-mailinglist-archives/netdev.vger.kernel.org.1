Return-Path: <netdev+bounces-84446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04883896F1F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38ADBB283DB
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D50256B64;
	Wed,  3 Apr 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PIYQRvai"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2105.outbound.protection.outlook.com [40.107.243.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96681B66E
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148331; cv=fail; b=HMj3q1sdZll0jutkt8eVDCStbdcY3rON6GgeIjKFMaClgyj0X/D/MSKchomdljf9vVJsF6+e9W6rLycZxCzUb5ktj1dhV2UQZR183ZL4iI3uotKL800puVtg61SP1l7agTbmpGU97vLZxWrPEXf/wwadAvLU3d8xmqqZQjmr258=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148331; c=relaxed/simple;
	bh=Zov/SNLTB0z9kbg/Q4WlP5E8H9DsfyGmfdW9hi3dgGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f0nGQaNcziVT3RndJDU+/ViACjrP3J1D74dI8tl+GzuKUXwx5naqYtvSQ88f61LFQp7NfgHXVMlqa2Cj0vuDJoSoXJxJYc+zruOqveyAqCZx5GPEAiNNCwwbFYzF4oalT9GIL0sG3IRnko+AjgenoSJ92ZkBidP8JjQhXelkN8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PIYQRvai; arc=fail smtp.client-ip=40.107.243.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLR9FMaOSYji9goCfUC+28EKC3d2AdWnztCG620CSTDJZiyyQRAzhdj0YtNigEWiJ7xjH9RN3aLk/+cgT90G9/xw0W9esW6ZNnlSxtrZeQ1Rk3QERLe1vmNTJyzPX6IuPxXDfp4KKcZt9mt7bREXe1fE2aeKgf5g5qGFU8SgTIvKMP39tF+EzKQu0fcVaIzkWqJnFCuk9MPzTjWFmiT5rHZ9YBp0e63n26iFxmV6s+JIr9sD/4JbL2Lmw9qNCEKTiJl++1w9Ucyh9O5ZT/6rGnc5sijqJejR1XabbGU/VoqKseTF3TAI3t802nK0bstgaO0GW3QoxspboIeMh+5xzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//9Ct3f+BADY+Fowt4tss4/NoEFMbM8XRXH9dX6+gv4=;
 b=hLSdlb+0IGxs9oeqyUsLFqaaxmJdMDdnaBPp5TklCj+5Ry02Hda5392tJhlgqL66OaFwIqOKDMHi6emxQz4zwiuTIzZOdC7lwpALyabH4pVirE1o8h/9wSaIUVo8rK4oKLbtsTPGUE5HoE1y+cMHSlyvn/sQC3JSXaAHJx/h00azBuJwRH7NHFQ0qAEnr7Zx0qYQBIAFK0W+ixKOY7VtmKQ2pms5iBNxUPcxgOxqdsXj8W3bauWZaV7RdirNyl8CDKILDxLFwXRWrPIG+uL+D+cecrQPIdSz0wUjTrKLcCgfoDhutwzsjfVbmSN9cb95PgJnDzB9U8u7eRHUSQ/wBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//9Ct3f+BADY+Fowt4tss4/NoEFMbM8XRXH9dX6+gv4=;
 b=PIYQRvaiMhb96RPLqB2F9oBSiLyLughUL4ou/ia0j/HWm5QAeH2CJ5hY8EMQOS2jCkSvt8NZxNMyml5ONaDF9byd1TueLK6CmVhs0N4wVF3zN1Lp9zVQ8X7EDPihpKo2ELc/DnW286Sj4ElUuKwtzZOEfZfDDQCUjBtXZwXaPAFEcr+w3/Rzk6kQNly99OJUovzlnN8SOkT2MbrjX8hM30dFFl6bA4J7s7ipSZXc02JaYSy/hTUgE3NiuOWOuJQDOXoJaw1FJYDnpLshn9PFLJE0qo4yMBmAjs+koimGIX+yeGaHF9fTGKGEZWTTwDmMe+ZvM1KLi+xS8/PKhZC1YQ==
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 12:45:25 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 12:45:25 +0000
Date: Wed, 3 Apr 2024 15:45:20 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Simon Horman <horms@kernel.org>, mail@david-bauer.net
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, amcohen@nvidia.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] vxlan: drop packets from invalid src-address
Message-ID: <Zg1PYMUh6FCT5FQ2@shredder>
References: <20240331211434.61100-1-mail@david-bauer.net>
 <20240402180848.GT26556@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402180848.GT26556@kernel.org>
X-ClientProxiedBy: FR4P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::6) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DM4PR12MB7597:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vtSYc0AQfhzF3cWbJyWrchpk/B6MslOJ8SqorxKjZNow0mr4SH8hrzfTWhVkxq/LQrdQ5rd3BBSaOCVmEW6d5sJNJPW/lkv2JVHEQtbw+WZRZdiXIAE9RiU6HWd2wufmPqckWl+agRPyHDVlDajJAGunV4TjFVcuV5X968++gDy4eIv9ce9G9/2mhzfhmx94X5cOXvpAfniKPFfdXqXrRJ765fpqM8+MtLNBVJ4tJNGA6t+Kyn4bHT4ExUiika3gfcjDanxj0c/dcQnLm3cOsLZk0zdTHcjFtLk8fpc8rbhKTXPAqRjB9n3IXpg4wBGlXNUD2wDu/D22ntMUZqUP6FsUpxfeiTluy19iE6c5NuUTgJztiyxz+iCjIilHNILKgS0ALHU3s/yrsMVEvzfY1gR4egSDIrqJDNbjHAqOcTNTPLr5L+KrfH7y7CFYXh2Jh+QIuDvA7psJpCdGodSKgly5NE8cVMxJLjQKONLmT3Hh5DkgnARFPPNWWBh7rvUo+gu8yMhSv4hESnDCHhDTag8eNkqrm6QutclRwfuPkyoi84EKQn3yoYoAsRjoPmib7wFHPvvTaW1ACJpdHH1RTWTjKChJvUCZHbtT8c9YNVjKxEeRm5aGWSBbXtOEQx/b7c/HMQ2GWcsl+osOzcLmmqTfGvxaeM0WyN1/d/ynrBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KhdYPsP+Bw60uhvOWdAZUybtS6+9LFdRgeZZtpy1/2PAHXL2B1UmgMYqTqTH?=
 =?us-ascii?Q?hxOv/VbYFEKOaU0v84MDxhKiYiHMkYJKfEpN3d4G9QeNFQNyVDWKridRFLw2?=
 =?us-ascii?Q?XynXTI306EXq/OVJMJgYk/N3CKRArGooe0noyQ0XT1wp0LVpF0VgZZzGh771?=
 =?us-ascii?Q?V506uVFigXXDPcvGWpVVZviL3+34Fwx+CP0fivlKS9Ug9SnFOuwvLA6Bqhmf?=
 =?us-ascii?Q?lWzv4j3VFJoP87koBgOAo8Bg0HMoJpaosb6lmlU9K+WWYASA0ta0rc6fY2vQ?=
 =?us-ascii?Q?kfzoPS12d8ZxZ+SHbG3Uq/OJxGfb0e4yHNW5XxuImpv3wSEHRJ/82cPL1tAd?=
 =?us-ascii?Q?bCDQleff01SgtS383QTqbJLJWR2p3sbwMIcxdKrmgyuKZYMXBaqrWBmUisrQ?=
 =?us-ascii?Q?kjOqttfieSvLlS6O5jwOvy9OisbqJpoaJYAPOHBJ4QczyhkX6qvXrIlZQWM3?=
 =?us-ascii?Q?SGtkJzrDR/XdPzEMiLqy2ZoxI1KTMCT9hp7eQkvPoaLnNPkJ3HeBBHTbZJWu?=
 =?us-ascii?Q?w5bh7643if/owJq/8A4UDQSP/JvNyCRRytYDsMY+Zhfsb4SJmcS+8SBo/cla?=
 =?us-ascii?Q?0wiItX+KvY/amzw0p8mn/2s+Mh1J+oPWfwvI5xV4MgDuJEXydMws9+I67XaU?=
 =?us-ascii?Q?3ZejP2Ow3a08C87BK//UDYOMsCYsvzfFoVcURg5b/sBpavnCU0zdVzpctyy1?=
 =?us-ascii?Q?p1Avx+o+LMZz9PHm9hYnwpOi5lmIvdk2oiXcT6SlD8k/l/+Vwgntf77NV90Z?=
 =?us-ascii?Q?1JWD3jRd54lLAPz43BB4QgjO1zBLCvbQhuGffMTG9umU7sIW8pZs+0Za222v?=
 =?us-ascii?Q?jmQvM4lPy0Fy8aJh6yAZXkdTZxbKQzT+RPq1+ztr/r3VTeIS89bgac7eO+li?=
 =?us-ascii?Q?M/YyA8AloFzkjL5ERh+FJZ23JAVPlLZ2KboFls5SCyATSchurM9qFR96z80i?=
 =?us-ascii?Q?pGxm3Z4LxlW8Ervb+SF2U42076yRMRvUkpn+Mw5FJ+qs2lnfHAsgzqVx1Us1?=
 =?us-ascii?Q?0JVuz7p4I7gzKbxkhfa4HB4wb8dLz6i7yMYLiF/uffLfrggZSGOFEk00ps9R?=
 =?us-ascii?Q?PgZfAzwQM5PDKVMSQfEAXjwUz1peUgf2+FtVkUEN7to6Z0RuanyQk7o/2P5c?=
 =?us-ascii?Q?8yNfTZqlT2K29PXglloJFgQsc5dX1XbUYSlFZiwofKlKIGMSHD06qVislFYC?=
 =?us-ascii?Q?NI4jBLu1KDsd0UIWSAMtKzYavyQJV1Ze/Fus5LZkWhspF9PHhu+K3GRIFKiu?=
 =?us-ascii?Q?PhMaWUL0yl9jM2Oh3tOJ0psUbMbJL4G8Wne5yiViB2dp37s0HKeuLe9/KF3d?=
 =?us-ascii?Q?02VUE1weXyN8KLW1aPuMwnLC24qmsMD5F6cAZ8/t26AWEe9CgSR4hTOeECjI?=
 =?us-ascii?Q?HjbN0zne3k1u4Toc4kPUgBCHQH+5aRCv7qoOZlDxfyYNlzRwcLilH01rgoWJ?=
 =?us-ascii?Q?Kj/j0t6l9u4E2sBfnrB1qXvR38lqBB9TiAKeQVH1ELAoLufj6PsfbeRWPLPY?=
 =?us-ascii?Q?2Dj/rvlUkWcoXwZ0ti/C1IpYOFz0ObGJGvx2865CXjQux4EkCRssg25+ae2J?=
 =?us-ascii?Q?vZGWNeLvROzkogkVCuqTncfjeNnuq1BZoHo+Ii92?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ffc706-44ce-4e8d-4534-08dc53dbef2f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 12:45:25.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cw2xKfcs1piShkN3gklMC4fJi+JdfY1R9EJBiIgC+e+Jaycq7SLAvDah1MkVoKr6TkHOJJI5y3DhfZHonpyj5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597

On Tue, Apr 02, 2024 at 07:08:48PM +0100, Simon Horman wrote:
> On Sun, Mar 31, 2024 at 11:14:34PM +0200, David Bauer wrote:
> > The VXLAN driver currently does not check if the inner layer2
> > source-address is valid.
> > 
> > In case source-address snooping/learning is enabled, a entry in the FDB
> > for the invalid address is created with the layer3 address of the tunnel
> > endpoint.
> > 
> > If the frame happens to have a non-unicast address set, all this
> > non-unicast traffic is subsequently not flooded to the tunnel network
> > but sent to the learnt host in the FDB. To make matters worse, this FDB
> > entry does not expire.
> > 
> > Apply the same filtering for packets as it is done for bridges. This not
> > only drops these invalid packets but avoids them from being learnt into
> > the FDB.
> > 
> > Suggested-by: Ido Schimmel <idosch@nvidia.com>
> > Signed-off-by: David Bauer <mail@david-bauer.net>
> 
> Hi David and Ido,
> 
> I wonder if this is an appropriate candidate for 'net', with a Fixes tag.
> It does seem to address a user-visible problem.

I'm OK with targeting the patch at 'net'. Looking at git history, the
issue seems to be present since initial submission so Fixes tag should
be:

Fixes: d342894c5d2f ("vxlan: virtual extensible lan")

David, can you please re-submit with "[PATCH net]" prefix and the above
tag?

Thanks

