Return-Path: <netdev+bounces-137290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C8F9A54AD
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B2C1F21D4E
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D583193427;
	Sun, 20 Oct 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QJFtGuNq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B7183CA5;
	Sun, 20 Oct 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435958; cv=fail; b=Cq71ksUHQl/G2I1TM+kgpi2FnPTBrqeBy6KIXiDlMNAyUBAz5sC48s4htMKIvgGX/nqjF+Rm5hTzwOcOF4rwxhSzes4HoqvHSu3f+eoaLGGDRR7EuzTBLo0J4TV9aX5akLUy87m+5Vo0MDnWUYr5LsdPsy7TDZ5JkVt1IwZcyok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435958; c=relaxed/simple;
	bh=k3uG8qL0A4lKLqGBX3xt7j30gHsN/TMK3r5y598Z/Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A/eneZ+to28v/18q0rLZtzq1GK+NxaAJIXqMkhA6RdtGFvODNs6VhYg80PImxIAY3w/iBYLdnp7YlojdMu0iMAAxd+J4I2RAGxzuEZwo6FS3cnjy9esqZDfHW4kopyDa2qX4cyZxKevu/QuwPnFoVUKy2hu35/4a3sOUSE27UOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QJFtGuNq; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiXYVuxwNDZe2HmKNbzxo+EmaTCLGPFWvZ3AVOLGNoJFu72DCgoQ6AQiSOPXUi+gw+X2s9BZRQA6S41SbYmCmhIxwPoZ7BmNgwCQIu+onT/dOKIjoAn75k3XYlWw9GzCfT3Jscp39yOtzcURohs5EQ+o/9eTKWehu0hQ7ErE+A2sCWc2pL3QqxCZbwh+npEkVJZMmoY5eegg2GZhf8HnxH5JOzMXrcqWBnKB/ibyvtSHH49jFkF/oM82Wmal1vn9rdvWB/dYQZ1eLXd9PoeH1cnPBkUeco3lzJdMBUblXB/nGMHRro/KWe4xtexl6TL81qJg6XTOMENyillTgGCBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CUUftnT13BMh3UoD2DpHNMweTjtJ7NFkeD7IUHv8lU=;
 b=eEG+KGZuINZB/WyQA3D6NtF+XC7I4cojKOGjaQtYkgaCBXkOFIBowNJE0Hk0fpcWPnf3sN7rk1DzATlJ7OxJ1FBjVJ9Qyn+ehkTnwBaiD32iU+T3CIUxK6ZO/cSECisX1tcp1l0Opg4JWirCQC2cAhIMUxkUkoyB62oupU+Web2XSeyvsBz1LEzlIjrqrcZfL/zVmeeDYSzIZGiPyTzPJwmKQpC/jblKz+8c5EghUdtmvg4xy+JcpTXTtSZdG6bBjKtvqPRMlPLzvy/D6QydFK3HhKKXGvDYVCd9do1zu7HVV8OqLK00q1gTojsQS5XFK0SuO83gzVuLqJ7utgzE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CUUftnT13BMh3UoD2DpHNMweTjtJ7NFkeD7IUHv8lU=;
 b=QJFtGuNqpuzcok0cnkXgwRpPm3OYEh+w25lN8qWQAnRgx87byf6POXWOj77ymkyii3O2hmARYDOHDqOm91P08vDIopSe/Zbzim515XO8ZHFqB0JAjzpxHpCZWtS5UVLyOeuk1AhMjKORl5Qz7esg/RyQcba3EfSDPkQ8c6dVepsJhnZFpR4JjPBChs7r7IrAT3TM6WhA7LSrOFI1UEwiX1cEaIQvR6JL5ERgwnJmbxaeW92tyFes70HIvgMzVSkyidGzxkT4m9ODX9XwsI5mS42vvIzL55hlwyPWlifcTcsoUKBBh9FgJ6BoEqsWl7ZywRV7lNO2eIjjPq/fqYfj5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sun, 20 Oct
 2024 14:52:32 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8069.024; Sun, 20 Oct 2024
 14:52:31 +0000
Date: Sun, 20 Oct 2024 17:52:21 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Petr Machata <petrm@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Baowen Zheng <baowen.zheng@corigine.com>,
	Simon Horman <horms@kernel.org>,
	Pedro Tammela <pctammela@mojatatu.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: act_api: deny mismatched skip_sw/skip_hw
 flags for actions created by classifiers
Message-ID: <ZxUZJUdC0Ac8-gVd@shredder.mtl.com>
References: <20241017161049.3570037-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017161049.3570037-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: FR5P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 435433b2-8908-40f8-a83b-08dcf116d30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CbfsaJuJURLfG4VFhQZlCBX7czBrz1C6Tl6ZxbYuybySKULQjiruHC5AcTVT?=
 =?us-ascii?Q?+B+jRKPZkLThyHDRmZpr99NGuPQp23QHmkG82JZgismXZDoMhz54duhXXNfc?=
 =?us-ascii?Q?CnDTyESPbxT7xjTE4ub0Uog2c73v/4BOpjvsZojAoc6qn8iBYIC405bsyw3j?=
 =?us-ascii?Q?+VeqZWIeq36YpQ6vVqwG/pxIH/5Vg3sOkzLlR2weG48/vb7cdtPHnWZFzB3z?=
 =?us-ascii?Q?olDFMjZgqA884/CgH5qmVEuP7lFyNIttjpwPEe2IKIlZ3Tgaz0ZX7cbYytUx?=
 =?us-ascii?Q?bVxpQfFXydce4+mA2d1DXhhe/mDM+voEZDv6uOuC2rnRi07ab2gP3XotWcAs?=
 =?us-ascii?Q?ULvuVLfHG9jO+RlE2ScVUpsJsM48G4p5QIMOEBAAI+Ubp4yLzxoy2lGkH0gd?=
 =?us-ascii?Q?s2WTsoa8gci0pEFiLveiB6ScLf9ZCeogu2phqjAEgt8z9Yax4f9w+SWaiKiX?=
 =?us-ascii?Q?T6JatEYPzTKUH40Ues1SBJyhjeAvQ0CnRzhH3Kp8Ss0jxOUg5S4/R+oFVOdU?=
 =?us-ascii?Q?Kq2kSUWCCDI5/byuj14g4l4V9KvZVt6btQq87LwT3H1l3+/Xoq3jkOaYQcVs?=
 =?us-ascii?Q?VsVHPF7mleMZKsFon5gIRifeuwOVBGyL3C2ZYT1m02RWDOBDtcysJu2wxHkq?=
 =?us-ascii?Q?G52HDRChE8ii6ixr/OgrCHRN6iTdyvidr6yLlaa+9jSM1EuzuTY7MlSCRPpM?=
 =?us-ascii?Q?johvlKrwk8/eS8O7X/a2gBL1l2U4hUJy2BiV86Lb5PaENdicd/uTwE04/k0f?=
 =?us-ascii?Q?SufqyR4UDMd/0L6M9r+k/WaGDaCECNNg9mS/jLtxynTEzjiOpk6DF9AvV4SR?=
 =?us-ascii?Q?INaH69hV54811+5QxIPEsvGYDEblRyakUS6g9yu9SNOCBn45wqhTOSGGKuTw?=
 =?us-ascii?Q?wfx0KB8SDyJFdmM8zlHyMPw9a95rZVZlsUBeMeh7nIw5xygC/hXasLGVbMrT?=
 =?us-ascii?Q?bdw7MUGaH/P3QA9fXUj+FjPCxBW01JABrA9ymuqMRLDAA5vvnPy+W6CSTi2i?=
 =?us-ascii?Q?ze/FRuXn+/pxLoJxD6+uRmQS5FT+uq7i8gFCcPCCFcQ1CuhCA/LI57GKOKmj?=
 =?us-ascii?Q?l1ZE6LFybsMlzHypb0JYyonepF5uVa9+xGOzFqWbGw9EyjayfWXEH06HqVar?=
 =?us-ascii?Q?lf8WKBJNO43O996wX7RZjXeBg0t8V6Q2eMe2BDjr1dSE4/860NLUm45vFfBS?=
 =?us-ascii?Q?lq/cb3l4q7btqF9FAWwtP6l5APRpqJ7He6GBI+g4y0TrpY11waYhRLDDYx1h?=
 =?us-ascii?Q?GjniLzbI0YLHtLOFB2zo1vmYng83he3OIYqz0pS+jcjwlWtIZyeOkZ3DIcgI?=
 =?us-ascii?Q?Lk5YE2XJP53KprSesYPbol5g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JR5/MVpBT+O5nlGSnYr93kjLuQNKuhoqzMgcfWaPMUzxeGccPk5C/n+t4WRf?=
 =?us-ascii?Q?DKsNISQVkAaQ1PlFtD/r0RRbr9JTQ4caCghGZqZlQLr+Py56X4rGl7omwWg3?=
 =?us-ascii?Q?8xWTms3Byt7tNoOuoWaoDq/v7ujccv3ZkTv7y9m2NOv7hXEyyywJZdC5CZ50?=
 =?us-ascii?Q?/SNGDpjwUCnIs3/kTkw80jmxJn/sDUfltGL8oIGnqTmkjTi606T4uDHPeQRi?=
 =?us-ascii?Q?W4wYas9dVeMejD+eV1rt6FvYLF83YdkLE2/sMGt5qLqITEmFjgJNhJJMFOf9?=
 =?us-ascii?Q?wnxBzQhI7p7+OLp1G89U1i/nC/6YZPjzsoS1PDyONt+3tGJs1drcTrTS2fZ4?=
 =?us-ascii?Q?CRHrZsgJnL1SKihl4daLG2ak+fCWfo4Oy30iRcxabmII5u9aSuUiCNs3NCvC?=
 =?us-ascii?Q?niaEKmzLzi5pR4/dCJ9aOwhOns+rE6+8NMQLiiynGo7bGMAPgVUr1A8O1wo5?=
 =?us-ascii?Q?hDYB7HzsgkTLi/+V309OJE0fsL9EbK1kXgsEMK9LocTl5GhcOgi9ap413YrL?=
 =?us-ascii?Q?QKFc70ah5CCnULoFWN0vDXiF24gWKzds2y6cvFZBFmE6RpCjd4hlLLKzzZYy?=
 =?us-ascii?Q?7tUjpMXXihTJjt69wZ38tbp1oBV9Z1lFRwL6DROyHmwVlm64QB4tW9GFiVIk?=
 =?us-ascii?Q?6sZKIKSpcnHO/weKozB6LeQE9+RxZSgttTzkG8MfHaC7xPUnnFajCXFD7Ji9?=
 =?us-ascii?Q?ErkCZtmipqr8ivzVExjVE4K5vbdHXOq5cgynnhce5jK74GYx/xJbt+gIHJm7?=
 =?us-ascii?Q?VpTSNs6PwnhHGhMlIsoozBYVbYLwkbBEw3xbv0YompGGuBblqH5a+Tufv8zI?=
 =?us-ascii?Q?0CDZCxpSD8hIWzYgyuD69CJ+cfwHH8IFTVd0HxgE6BXbjpBtR3Yzl9qHKjoj?=
 =?us-ascii?Q?tWkGilR4tu6YfQMunvgLj+PMcOgwqAs06Xm8TUowFhbWD/BWeJUdKEGCnFaX?=
 =?us-ascii?Q?AYUMSO/gdyrzhW7N0Kl8AIGGPhrRJ3pRZMysKmAihbIcy+Fnw8gmbYnakks3?=
 =?us-ascii?Q?2mg01idXDpt9H7glsJwVrKyRl0nMq6eOTuEwqc1UvUVBfUBvOFuqGed8tGkB?=
 =?us-ascii?Q?UOEYCVFaPjsIxMZaYsd1ZN5cGB56PsSfKE6P3DwFvJUfAi3m3Iah0UJq71WE?=
 =?us-ascii?Q?p3Fk3P3GlZGNykbZgN9c/mZaXXIv8KfFx8xztTLnGILKzVAj48ahCrtG5gTw?=
 =?us-ascii?Q?qzqeL/hyy7YPgS2mBw3Ipr+MwrX1EcD6S4a9WGLqv6/XkF+59Lx7gBw74BxV?=
 =?us-ascii?Q?6bGERuoelVvkZ3gSpAfanmHCRrCKpLdmXqZjVOrrBC7pR6iSAxsvETxqIJuR?=
 =?us-ascii?Q?xzgcI4IBBWcRoJJ1Dn5MZOb2ep0sL/5OApTNqZ2ePiEd7af5GjrfV9AMbLfV?=
 =?us-ascii?Q?UejZXp0SPnzyX7JUAXptB7aWzxaYEY6T/boVw+G6p3cUQmN89ozi5FnjRTzB?=
 =?us-ascii?Q?fwEluTe1h59jtWeE8glR837khfxpvQKF4jEz6XnpfennkcbJidMBVkM6I4e+?=
 =?us-ascii?Q?cuDjqGZW+J0xuBw+48zIp0UjjXGupE8SMtuo6coIjAW21JGish1VOWU14doF?=
 =?us-ascii?Q?qAD38qox/T7Ba62Wa/NvTHrvg0KBHdOeVPufJi8c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435433b2-8908-40f8-a83b-08dcf116d30c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 14:52:31.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTn0CtJJhBrnuQu+Z+156j4JdwhOB+gOAURwouHC9FbdnjYrhcWk00PTb7NltxH/fPSyXkz9eVn1ark7a9P4Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002

On Thu, Oct 17, 2024 at 07:10:48PM +0300, Vladimir Oltean wrote:
> tcf_action_init() has logic for checking mismatches between action and
> filter offload flags (skip_sw/skip_hw). AFAIU, this is intended to run
> on the transition between the new tc_act_bind(flags) returning true (aka
> now gets bound to classifier) and tc_act_bind(act->tcfa_flags) returning
> false (aka action was not bound to classifier before). Otherwise, the
> check is skipped.
> 
> For the case where an action is not standalone, but rather it was
> created by a classifier and is bound to it, tcf_action_init() skips the
> check entirely, and this means it allows mismatched flags to occur.
> 
> Taking the matchall classifier code path as an example (with mirred as
> an action), the reason is the following:
> 
>  1 | mall_change()
>  2 | -> mall_replace_hw_filter()
>  3 |   -> tcf_exts_validate_ex()
>  4 |      -> flags |= TCA_ACT_FLAGS_BIND;
>  5 |      -> tcf_action_init()
>  6 |         -> tcf_action_init_1()
>  7 |            -> a_o->init()
>  8 |               -> tcf_mirred_init()
>  9 |                  -> tcf_idr_create_from_flags()
> 10 |                     -> tcf_idr_create()
> 11 |                        -> p->tcfa_flags = flags;
> 12 |         -> tc_act_bind(flags))
> 13 |         -> tc_act_bind(act->tcfa_flags)
> 
> When invoked from tcf_exts_validate_ex() like matchall does (but other
> classifiers validate their extensions as well), tcf_action_init() runs
> in a call path where "flags" always contains TCA_ACT_FLAGS_BIND (set by
> line 4). So line 12 is always true, and line 13 is always true as well.
> No transition ever takes place, and the check is skipped.
> 
> The code was added in this form in commit c86e0209dc77 ("flow_offload:
> validate flags of filter and actions"), but I'm attributing the blame
> even earlier in that series, to when TCA_ACT_FLAGS_SKIP_HW and
> TCA_ACT_FLAGS_SKIP_SW were added to the UAPI.
> 
> Following the development process of this change, the check did not
> always exist in this form. A change took place between v3 [1] and v4 [2],
> AFAIU due to review feedback that it doesn't make sense for action flags
> to be different than classifier flags. I think I agree with that
> feedback, but it was translated into code that omits enforcing this for
> "classic" actions created at the same time with the filters themselves.
> 
> There are 3 more important cases to discuss. First there is this command:
> 
> $ tc qdisc add dev eth0 clasct
> $ tc filter add dev eth0 ingress matchall skip_sw \
> 	action mirred ingress mirror dev eth1
> 
> which should be allowed, because prior to the concept of dedicated
> action flags, it used to work and it used to mean the action inherited
> the skip_sw/skip_hw flags from the classifier. It's not a mismatch.
> 
> Then we have this command:
> 
> $ tc qdisc add dev eth0 clasct
> $ tc filter add dev eth0 ingress matchall skip_sw \
> 	action mirred ingress mirror dev eth1 skip_hw
> 
> where there is a mismatch and it should be rejected.
> 
> Finally, we have:
> 
> $ tc qdisc add dev eth0 clasct
> $ tc filter add dev eth0 ingress matchall skip_sw \
> 	action mirred ingress mirror dev eth1 skip_sw
> 
> where the offload flags coincide, and this should be treated the same as
> the first command based on inheritance, and accepted.
> 
> [1]: https://lore.kernel.org/netdev/20211028110646.13791-9-simon.horman@corigine.com/
> [2]: https://lore.kernel.org/netdev/20211118130805.23897-10-simon.horman@corigine.com/
> Fixes: 7adc57651211 ("flow_offload: add skip_hw and skip_sw to control if offload the action")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

Verified that after the patch the second case fails and the other two
pass.

