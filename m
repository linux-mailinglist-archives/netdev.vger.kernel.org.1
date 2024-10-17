Return-Path: <netdev+bounces-136635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 567339A281E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85A31F20C96
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8861D1DE4CB;
	Thu, 17 Oct 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QqtQUHu4"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013046.outbound.protection.outlook.com [52.101.67.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5CDC147;
	Thu, 17 Oct 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181470; cv=fail; b=Q2li3jdPaZbGfveZ95Qe18KzARC5yek8Qvfw1QAVDH48KpHE8hC75VgW1aIgHsSfmo4geaZtTREtVhwIYE5RlAQDe4llQJBBFDgNLouvvZZ1qGJjI6wrymYkblSx3AWdvlDB8eaQXSipvrvcMVet6Cj5M+MhUknaMx0wkFboPcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181470; c=relaxed/simple;
	bh=MI5dMlzqA2RKLYrzcQ8NJMS2H78fonFD/h+t5yNWVmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AuRZrnuWzaJ1n+xJTd3lqVTHtyBt1wLOSCvB+OK7wxbiiVXV4/Vdj2FJzzggeuDsqQPWCE27ZRvuXufA2N9RxiZmJ+t6Z9+O4HcVqbH9yLIsFysMyAEUKHftlnYmCxfoKNFIRqJA7k7jUa7FPd0SvSq1sRizOW79EfNim9hIDV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QqtQUHu4; arc=fail smtp.client-ip=52.101.67.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rp+hC5bKckks6d7nTRvxXfCY0UEuNJ0VNq3wqXX2Ov31YL77Tv0CU7pndCu0KYRt3uOZYDmE7BXPBWFNne4H5tVGbF8eAVTqa3UjSUY7lJ158krPc6yBSh/4/Jf/hvpvYlR9x4HP8eSAN6hwzsRKhO51kRrIx6oAB80NKnB4+aHnSqNdTs/ZN7BfaRYOimaBxaaoUAryZdR2UN9X/xbPblNCihFLmvYztSjPC+pHR4GQLL4jO3Qg0mGYhWzRmBlQFjwLcnJ4hvXjifiWQ4j82ygkdwFlaIc7QRpLEGoyRNBn/2O6FH1OIU7SbibHySucZqTHoIqZk/i4WJEFnMEAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HzlQyfAM6W/d8GxqbYq1Hh7xWwKiFs2JJ+4jQ9QYbE=;
 b=AzfkoMeFVxAMxtOazjSnhxoOxJdiRmMpP/CfnelFoWYg+Qn8VrkijqCKqQ4hgS58mZkI2GPG0x312c7lKmnFuwvFeOQzKPH6+uWzOu3MaPnGJ9D2/qWd8loIBkIcTFzAhRMSAy9XIE/6Lb0i9RdxzEvlB7XkTo3UDBGpGCv3QUyBYgZkbe77uPRY0aTfc32HRLzfvcEQ5XK6XRUgeiYtobQ2jFb8MrFxocSR55M87Gnf3RE1ePsxARP+tJg9+9ZpnEM2fS91kzvlWhsFawEV63Cz0/fr0btpjaTw8wz68UpUb0xPixPN4so9fqUu3YhEEjpCcltQxzMNNeAakUyyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HzlQyfAM6W/d8GxqbYq1Hh7xWwKiFs2JJ+4jQ9QYbE=;
 b=QqtQUHu44Paks0sQGoWA/HBUHnKFb8Mr7dKooEwZ9XqD2eFWZ9y+sSILajKFNNjsl+mqKmO3ewBqpOSuFUiEXmcbDUQRtXLacksM7f8L5cEdeQUquzf6DX8UEYdOO28DstbDBym/MMUmXRYBjPn3ZELMkzVNP8omPB10a2bnZTxiz81pAKkgAgjWGQp6SHBXISFPIhlxSUBQ94TvhNTNXCvcXHXCFruwi5nqBhc5SNHYMSAlrjG5rj1J4A0JVFgvHhFj7is8KYrA3jfmGJZiZ/hCunPOIqMkA5k0a7YvpFi3LJ/UBPaR8TbnoYHkgsBwAD5DwA13Y0xqmK1vw3PB/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB8855.eurprd04.prod.outlook.com (2603:10a6:10:2e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 16:11:02 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:11:01 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Baowen Zheng <baowen.zheng@corigine.com>,
	Simon Horman <horms@kernel.org>,
	Pedro Tammela <pctammela@mojatatu.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/sched: act_api: deny mismatched skip_sw/skip_hw flags for actions created by classifiers
Date: Thu, 17 Oct 2024 19:10:48 +0300
Message-ID: <20241017161049.3570037-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0015.eurprd05.prod.outlook.com
 (2603:10a6:803:1::28) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1b16a4-d646-4827-25ad-08dceec64b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gVqoP+nrzA2mvYJyOB4IfGtN9gyhPLN68VJNLNeVs9cmUHkNzarZ6LjL6WmQ?=
 =?us-ascii?Q?4Ay5KkUS1j5GLC7jyH9qMFwFKZrtdw4cKvWxEttcFITfR0coLYFYLCvTlIL+?=
 =?us-ascii?Q?9obAXbU/xq+gtjEIaqPu7QXNfKeO49Ycw+3E86bRYzqdAG3TrDIpLotHuwaI?=
 =?us-ascii?Q?jvDVifvNDOMsITW5bOCx1yo/nHjoT7meHcgCeN/yNjS5QWdgQa+sKu1UnzDa?=
 =?us-ascii?Q?GNLhV6V9MUXTOXphf/WgzQa18YJA0H5tdZZeUOrpFm6Nr9z+rFcpzkUhKtJj?=
 =?us-ascii?Q?qYBU3l/Te5ecqSGrDdocbbNrCHJvo3LpDTDbC6pv7h/uwnUxyzGfaWbUc/ta?=
 =?us-ascii?Q?ljQxGZ6bF6nkmA5w5194Ugb7kj+g7RBdlZzEIwT+mJh9pQRKIzo74WEh8vws?=
 =?us-ascii?Q?FlEueZWcXF9/bk1Gqg05ssVKg/6fYaW0J759RJRIwu56ceeYD+jNXUK1j1Yz?=
 =?us-ascii?Q?AUd0BeXDBiFjSTUOH20pDn1K09TEqtcVu+hx4yHGQuZKCmrdVyC3vu6gKlwN?=
 =?us-ascii?Q?cIKjMbetXEuTMMCQXfPvxa2r9lsBQkEh/XwxUUONWDDH/YqFtsl8V6fweFy/?=
 =?us-ascii?Q?g/oVqEnd31w8skG/nBUOYkw6q8wM8HK+sIlTm13sMwed3Mu5FjMPJrFIrDql?=
 =?us-ascii?Q?dIr0IHtzzydDPMxa3DmBcvlFxR9VsxEktStJjdTf5uHOC1dZxg2fbm8NnIP1?=
 =?us-ascii?Q?aYMrO/VgxcY0+H7TX8ZKpJykC7qh6nAd4yFDi/1q49NwQOf2AixBKGzSWV83?=
 =?us-ascii?Q?O9QigEqbITHVnRmS6CNp26Ft1gNf7TytyFXp1D7lZQUwLaXviVuENlHFPD+e?=
 =?us-ascii?Q?oSVIyGeQLr/2ffJUpilpYXsHie/mVASGIHOUD1ue9QH8BM9zmHN8aoDJQXQO?=
 =?us-ascii?Q?mlGyy2zz+6ertds5uAX4ieIhJqUZiASDjKjrsul0sPx69fKWzewU1tDM3pZ2?=
 =?us-ascii?Q?Fvpc5sagHhnTnrnkOQyGqtSlOHXlvYqrm8WmXZfO6+SqG18hLm2sNBd2vuJK?=
 =?us-ascii?Q?/M7e59M81nC9NsPLD9dcGIX21Cylb1aB0R6aMotiTuvzhjzrYM8E4+SIOasU?=
 =?us-ascii?Q?3UauS+obC2DOXTsdL7V3wEw1/emxxs7H1l46Rmhim2ghLiQBRAS2DccKxTCc?=
 =?us-ascii?Q?InMZT7ydzdUjyGSkynqthJdXgumFUAITZDNzCGAwV9UAKokwkfADdCg5LlfB?=
 =?us-ascii?Q?OyJ8VXiU60PIBSIkfki5VsCm1nlZQ8vlKIbDPLOQ4lJh5lOORogruDHDg8B2?=
 =?us-ascii?Q?xQMrqaiyMF8F1mFTCQu6Njlag0r3AhpGZLt5+LQ5B7/evwGoRpyO6grukXm4?=
 =?us-ascii?Q?UPuYjimuov+IV2GLIvakpOQ/85IOjCrHmxFPYoSSy6TEF5r9q6x2Os4zc0z7?=
 =?us-ascii?Q?JowIHQ+OjnHf/Cw449P8xl5HI5kq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQWeLLfs2PQx1F5HDAvkrLIB1u3fHK5ltC2TP18IzRutCJJDBA1zg5U8+XBq?=
 =?us-ascii?Q?q+mETxnN5cS8h0AIr5kW9jEMOWvr8CnrmVI6hN3/4BPoFfg276jkiDJZBI1O?=
 =?us-ascii?Q?8J1yCMyVoBd7vaW3Hcy5zB6Frj5D9Tfpi4pWo/yHAiSmP/15lV2ae5D/11Vo?=
 =?us-ascii?Q?VsarJXounAG+g+4yr8g5fkdaFZfSpeYSiGD8U6UBLBofOrdHumkJJ8c9jUWU?=
 =?us-ascii?Q?3/j0m7vK+OloVcGVrG1VxX4HvGvsu7fk6Ltq9cisPza6BqyNrzeSXZWQhxXv?=
 =?us-ascii?Q?3MMuLRnx8PunknoJ02+1/9UzVtEmgdRFjSp2hxFLumw2uH/OeVnaBi4eed1C?=
 =?us-ascii?Q?fIts/k3g8dXQpVqcqL3yabSmFv8FGI4IUhkqvokq8nnxFVG5D4vTIrPkheW8?=
 =?us-ascii?Q?HRBUC5PcZtMlpMIJkdclb/0eVS+TyTZBEyv+0rjiUfsBNt5QNOf82dqcsecE?=
 =?us-ascii?Q?HtzfKp+HpByOoid4fdMlT/fPQf1S6ltkGW7iGaxVHxK5XWwQjP1K+qVkX1dU?=
 =?us-ascii?Q?dlYOxhQFrv5RKT+tlpTuBg0wx8tC0UyLs/ywrFx8M15EB2J3gHM0HZdAVlaA?=
 =?us-ascii?Q?mt9ePlsfdQz1w6zJ4rodybIyhCyIio+ZPCRsr2trJk3jQlgaON/jDe6lg7ZU?=
 =?us-ascii?Q?mGzBeheMgDn3aDVevcHiTRM7PH0FX44RSsVBiEnB3BCP03t3fA+TfsDrl9MN?=
 =?us-ascii?Q?5Hm+uADvBCBrjY7xVEDmlHGQT9UGb/E7T2B0i7DRFdi+DTSb3rkwDB2ru4bR?=
 =?us-ascii?Q?JOS2qjdJL/tjDu4UIt+kqxemgCsQczUvsho/PxJ2ILISONXpyjNew5qoZ23N?=
 =?us-ascii?Q?MQ4S79zPyEvxEl9Zpdli7miBEHjo1Gkc7/iOC6ASUK7XQYmnU+BAVEgOjDiL?=
 =?us-ascii?Q?U3ZNl6DKrtXX27jHZMRNc7VWRaAa9xXwAS7PtMzrlgpR4mOokI1RxG7YqfsG?=
 =?us-ascii?Q?rfAMFY4Jm/pB+88PR6kz2xbL/NbuuGjdxCNaCjzUW+B8R8UEjzQKy3Idl6Yl?=
 =?us-ascii?Q?sBgbKxkJxGbG6/x6VlszgkAYbpF0CLfoUVonmu8HqKjwMeaMkCVXlxCG7MoH?=
 =?us-ascii?Q?4TULzudZIr9SikjnctZtC4IolkbGMIYGjSj3R6Ob6xYfwLqmg2ho/29l6bSZ?=
 =?us-ascii?Q?on1cjLinKRDhjALyzSMvbEbd+l0b+7RW1B2xwi6WgOi/bZsHVRUmvKrbgnYB?=
 =?us-ascii?Q?TiqivvmkasSGwRpcr1ngSp1OyXUu1dHpRcOLTYIc3vNkTlSlIT2TzHijIkyz?=
 =?us-ascii?Q?sBZ10Qnzs+ImXQxgHSmDgyA5XHhZ6q32dQIJ1Dook9boJPk7grGg9ELH7wHZ?=
 =?us-ascii?Q?jC6tOPMHkijpWvPXxQn689ywy+AErgi1lUysCQ7nl1p9LfkSmIB0ZCoV+84j?=
 =?us-ascii?Q?xn0RkQx/5urX0m+ADR0edys2gwLdONe94q8wXJ0pxgaADYhq7JmNnLY0mUwf?=
 =?us-ascii?Q?XTkC7FOcnawGWp/VC+NTsMNUMIAnmPIt1wTcNNzTDabXbQwYs1fUwazWUyHG?=
 =?us-ascii?Q?c3JHHaxDNDOBSIA8VU6mIdbp5048DgrlUFiDY2xBgQVu5uanNmyxxmu0f0DQ?=
 =?us-ascii?Q?hnQV7iYSOg03mXf+2zKA3e+OTFk0WmcKxdFbsw7n8Lk0aTuyIZb7+FsdZ2l4?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1b16a4-d646-4827-25ad-08dceec64b6c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:11:01.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMrzHbaFS+v38RWFSX47QcD+d+Qd+ViTeTdg6Srgmg/kCxpi2gOunQwFcXXUZz5+FqHHlVItR7nw/XOGiSJCvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8855

tcf_action_init() has logic for checking mismatches between action and
filter offload flags (skip_sw/skip_hw). AFAIU, this is intended to run
on the transition between the new tc_act_bind(flags) returning true (aka
now gets bound to classifier) and tc_act_bind(act->tcfa_flags) returning
false (aka action was not bound to classifier before). Otherwise, the
check is skipped.

For the case where an action is not standalone, but rather it was
created by a classifier and is bound to it, tcf_action_init() skips the
check entirely, and this means it allows mismatched flags to occur.

Taking the matchall classifier code path as an example (with mirred as
an action), the reason is the following:

 1 | mall_change()
 2 | -> mall_replace_hw_filter()
 3 |   -> tcf_exts_validate_ex()
 4 |      -> flags |= TCA_ACT_FLAGS_BIND;
 5 |      -> tcf_action_init()
 6 |         -> tcf_action_init_1()
 7 |            -> a_o->init()
 8 |               -> tcf_mirred_init()
 9 |                  -> tcf_idr_create_from_flags()
10 |                     -> tcf_idr_create()
11 |                        -> p->tcfa_flags = flags;
12 |         -> tc_act_bind(flags))
13 |         -> tc_act_bind(act->tcfa_flags)

When invoked from tcf_exts_validate_ex() like matchall does (but other
classifiers validate their extensions as well), tcf_action_init() runs
in a call path where "flags" always contains TCA_ACT_FLAGS_BIND (set by
line 4). So line 12 is always true, and line 13 is always true as well.
No transition ever takes place, and the check is skipped.

The code was added in this form in commit c86e0209dc77 ("flow_offload:
validate flags of filter and actions"), but I'm attributing the blame
even earlier in that series, to when TCA_ACT_FLAGS_SKIP_HW and
TCA_ACT_FLAGS_SKIP_SW were added to the UAPI.

Following the development process of this change, the check did not
always exist in this form. A change took place between v3 [1] and v4 [2],
AFAIU due to review feedback that it doesn't make sense for action flags
to be different than classifier flags. I think I agree with that
feedback, but it was translated into code that omits enforcing this for
"classic" actions created at the same time with the filters themselves.

There are 3 more important cases to discuss. First there is this command:

$ tc qdisc add dev eth0 clasct
$ tc filter add dev eth0 ingress matchall skip_sw \
	action mirred ingress mirror dev eth1

which should be allowed, because prior to the concept of dedicated
action flags, it used to work and it used to mean the action inherited
the skip_sw/skip_hw flags from the classifier. It's not a mismatch.

Then we have this command:

$ tc qdisc add dev eth0 clasct
$ tc filter add dev eth0 ingress matchall skip_sw \
	action mirred ingress mirror dev eth1 skip_hw

where there is a mismatch and it should be rejected.

Finally, we have:

$ tc qdisc add dev eth0 clasct
$ tc filter add dev eth0 ingress matchall skip_sw \
	action mirred ingress mirror dev eth1 skip_sw

where the offload flags coincide, and this should be treated the same as
the first command based on inheritance, and accepted.

[1]: https://lore.kernel.org/netdev/20211028110646.13791-9-simon.horman@corigine.com/
[2]: https://lore.kernel.org/netdev/20211118130805.23897-10-simon.horman@corigine.com/
Fixes: 7adc57651211 ("flow_offload: add skip_hw and skip_sw to control if offload the action")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/sched/act_api.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 5bbfb83ed600..8e705b212c14 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1498,8 +1498,29 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 			bool skip_sw = tc_skip_sw(fl_flags);
 			bool skip_hw = tc_skip_hw(fl_flags);
 
-			if (tc_act_bind(act->tcfa_flags))
+			if (tc_act_bind(act->tcfa_flags)) {
+				/* Action is created by classifier and is not
+				 * standalone. Check that the user did not set
+				 * any action flags different than the
+				 * classifier flags, and inherit the flags from
+				 * the classifier for the compatibility case
+				 * where no flags were specified at all.
+				 */
+				if ((tc_act_skip_sw(act->tcfa_flags) && !skip_sw) ||
+				    (tc_act_skip_hw(act->tcfa_flags) && !skip_hw)) {
+					NL_SET_ERR_MSG(extack,
+						       "Mismatch between action and filter offload flags");
+					err = -EINVAL;
+					goto err;
+				}
+				if (skip_sw)
+					act->tcfa_flags |= TCA_ACT_FLAGS_SKIP_SW;
+				if (skip_hw)
+					act->tcfa_flags |= TCA_ACT_FLAGS_SKIP_HW;
 				continue;
+			}
+
+			/* Action is standalone */
 			if (skip_sw != tc_act_skip_sw(act->tcfa_flags) ||
 			    skip_hw != tc_act_skip_hw(act->tcfa_flags)) {
 				NL_SET_ERR_MSG(extack,
-- 
2.43.0


