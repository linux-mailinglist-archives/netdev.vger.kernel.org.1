Return-Path: <netdev+bounces-271269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNDMHc3twmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:02:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E59CB31C095
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71462300DF75
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E222D877D;
	Tue, 24 Mar 2026 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QL5/zCQz"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0711DA92E;
	Tue, 24 Mar 2026 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382470; cv=fail; b=hmv3u2uYFM+rFQLrLT1JMQf61OaQeLZ97R5l9sZWaf51CY8j/mwIhikpK8pLF2Bjdp3K8r0TOZGdpwHM1E9fiHMT6D8BER8kYDsu9kjGtl2CGDoqmvjuv78/SZ7dwHuHBjKzW/+eUrcv9rV8pHm0zsQfCq26nZDnQwkZiFbqLEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382470; c=relaxed/simple;
	bh=uQYIl/7HWjryp4fuNu7jcD+9TZdCFWRzZACaigi/LFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XWbBSPFrT+C+AszFoeznbeVckjWC22uPleBZN7QVUUmVyb+fMVbMgeu5+nv3kUqNIF/xiqf/uwRTgzkars/mEgdrW/IHDZky865emrjWSFNi6GyJs/TiJl3yiQgzMbXyIq6fHtlaofeYMxnmrf4yWB+Ppf1eH9iWM1PRszHU6lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QL5/zCQz; arc=fail smtp.client-ip=40.107.200.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yufm27snDSbm9yO4w0lsPjIRIsNHuHcfHfYAqCdOLCu/P6xN+vaheRgF+zk0axSArOFbC/cxU2+DjXen7tUzyYn/nsQix+2kDzH2p4F5SxvxgEtrCG7zNByL9b1UnKr+//Hi7KtRZlPh4X0DsTT1gI38Q1FV/blomTN6ZewnMkwnomXhrx/M6L+DLicDOCtfc8FIDJoocdiDut4CQutPyBUPOQYZg29gMEQkCyyuJh4CZMVZt+eLESA1jLo8b9vnice+yJp9SO7Og+5RjPQ7gnCdFdIZ/vUvnAx35ATIGKcA8DRYnGYnPEskby0lEDTYRZQAEgLI+sZfZserucDHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vgm0Gab+3jfImyEXQChuxm3brIsTsYut/O6K6LXkKS4=;
 b=PRYBhvogOcHYytjToBmPzJ59Tz/Xr21TxKz0M+nKcE0wrVQDiwovsFcsA7z7fiGVGthTqnm3KcE9jcS81AEXXxiXN5NQXN+gWnJE/TKT6lT7I9dOb6Yw4T0Zw5O4dznST2eTPRmt+roPjiovRKjqaL7UESSMqjFIjeA5rYF8k+Rlb5uOmaW6eAyNdzLCP1db9F50NzaiqWoFKWzCHviaAn49HXEeLsKIELLy8nWBwy2AhJFO7HXVtYwVaUv7tTqjXuyqV0CtuMLKWcVNnocZ1X6y78etQQQRg5jalbalI+Jshw+7DWizd9MIMzlrCSPmlywePFNoEg13OVvRkwrOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vgm0Gab+3jfImyEXQChuxm3brIsTsYut/O6K6LXkKS4=;
 b=QL5/zCQzqLzu9TVAuN3rIXApAI2MeVNow837RsMuSEJSiwS8chuEpoRwpFvd4C+vWeT+ZFiQ/iyKaAYs9bm+pxU5VP8W1a0d1LV/k3/IsUZRySYTiDhp8SDLutTykB8jk7aNSwlv0E//ZrfS1qa+fvhBwGT4frtsDxwm3MNCjD8aBu2KO7/ZrPlus55nO5VbMTRCk3hJL+JzfIvGGP76rNePzGxQPKQJYhNZGRz9vGQhy2+Xy17Gt/OeZdegig2ocN/jYpz970F/2bsEmElwlXMNWg3CpGfoMUVoAqPUbWuWeRuu52MCuqca/l0oy9Z9bPnudAgMQEznHWwVvYfoKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CY8PR12MB8267.namprd12.prod.outlook.com (2603:10b6:930:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 20:01:02 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 20:01:01 +0000
Date: Tue, 24 Mar 2026 22:00:51 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Andy Roulin <aroulin@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: bridge: add stp_mode attribute for STP
 mode selection
Message-ID: <20260324200051.GA572287@shredder>
References: <20260324184942.2828691-1-aroulin@nvidia.com>
 <20260324184942.2828691-2-aroulin@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324184942.2828691-2-aroulin@nvidia.com>
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CY8PR12MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e0f3bb-cbaa-42ea-3286-08de89e0129a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TLddKbbx7gQ3CWrhOSeWZOaVs2u91CQ3JGf/HXmLZeYaD5sXQhealr6T7BWptjqwfGOq1a5XKU+nmItId/4vXfAlhOfUex+9/YX6EbHnbbltEnoClhRs3OnnAleSMzVh0dHnjhWK7/GtK+asps6IqpIBGSliHm7M3oF4E0SVe9Zsk+QXt48VcHb/nH06XEOdloFktn/UOStkj9rbmG5qwqgtDR0rR+8f5OOklyxKgZ7pTn85suxED+g8+1r0udKa4DPMIttw7HRFxH5tQRPadAatsCSZNnxGbjuKwPIe2SHcotcjl2uIc4qvRwufLJxN9DdU/+hj7RpZhe2Npgy12e4nF6Gw2/5d7+XDd2j9v9Vxh0jhdekUmm55h82k1zxhR8NgxQEMKLlugWFuRwRBzuMKT+Qe65cwGs2JBcrGS8GdGRxAY4Mv/tUrtzvCi54SsnDJJnwqbxlzEgHM1mK4od1O8e2MkF2W8ckHMzhJTul/U5vfKtr8IvmkTvBMZzGZs53Z9gvZN2aylzlRcriyYRUaTavaWIoI7S5eLGVj/RtPxiYoSo90tfV2Ppb0QKwbZmN13kosdbDj9AaRwNnIpLNF7dYTCzEQ9YlwqBpjnQz26dLUY0CNbnOeBzgiMyM1DZLStkEc4ItDYhnE86oFvi7pn5pWMRBjQwuVwPJ9+5WiqNQL9ls/EicwEFMEwzezsE43d2CB04od2Hq9WukxTqjskfGU2c9B7nSE449265k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KWteE59vxy6R4iW7PaH5gK0MhG6UzXdYTDodGMfwufIupvWnqOIiDvnZF/CY?=
 =?us-ascii?Q?EG7zCEt+WRHB+MtbrPo5U63D1af99Vx4W4RxMiHGxYkFjdVFzJ6tCsgQuGtz?=
 =?us-ascii?Q?c6QRx6d6VF4eLVPMcOSX206FB88aGX39Jh+QIN1/WyEtw7aLk8r9KuVjgK07?=
 =?us-ascii?Q?OO41EaniUAXpC/0awIqHYEEOURFSFZOnssMv7xU3HYUy+C2TCXtgJOO8xEnW?=
 =?us-ascii?Q?CNH9QNFqDlrX3mfnaBa1g9VK+OukpHza4JlP2PNP+FBSVfWGpcUIM23sO7AR?=
 =?us-ascii?Q?5wk+b3U0GBpgCbnU3HLKDE53BVTunkOKYaA2PpKV8tISLhwZmDQ76lwBODS6?=
 =?us-ascii?Q?TCwkkWP8AKMSNiQ73toUtOE24OfR7/37r/bBH8bC3WSj3hnDU3DCKmuBMnTK?=
 =?us-ascii?Q?AZ9ugNSDT98N5gxkSvRgu7VT3XFbnn7bueMHYpXzLSjW5Psup+O5YOBLig5E?=
 =?us-ascii?Q?FjMP/Dr67Gl5Ew8GibanC2DpcrBhinXnLL/JaphmY/Sa961jS+2+PeH5m+g5?=
 =?us-ascii?Q?c9YPLjtDzoIALxcJJGC43R+5hnPRND30fcz7oh3Jolo2hg6UwemNnA0X5iNJ?=
 =?us-ascii?Q?Koeav8a4hE0TUrPLElux2dkNSPchLhFHB8xSb9FliQQLc2C9J8mzyUvc+Phk?=
 =?us-ascii?Q?bHkEnDuEU8xeSx58aZE2o5x4LM/36nBDe4DU7HLbedBsW+OtCMFqn9q6zmnJ?=
 =?us-ascii?Q?mfn+/fTgi0rSjPs1hn+YSMhRTo+Yh8EKJxpdko8dufk6NnxQzPmEVvykx0mJ?=
 =?us-ascii?Q?bHVBSWlAP7v73ap1a67e++r1CtRh9vdfWKaQZpGAR2PyNQSA8B2iyFFTKtB8?=
 =?us-ascii?Q?1hMZfovfdG4j1uhnk4eMWcHL0bou3HywmGYloIHZZPtKKgZvVpc/gxgZZM1W?=
 =?us-ascii?Q?SXsD5JoxGxjPlT36dmXkUKz8F0BKSSL6mvYWu4WpM/SrFZVqEzCKF2lK3a5H?=
 =?us-ascii?Q?37OtMqzSPSXiV3ZiKBT3RuTBumnLohsNaoYw6IazRqGzcXCoa2zS7hf334vo?=
 =?us-ascii?Q?LZhApdHQ6ZYHjC70OXXFNh9G5tW77fmk4QMJtgsOSyJgVosQRRUv0/rcsyft?=
 =?us-ascii?Q?G/wHhdooehqTrfBLDB4ZBFDlNVSaCAB5u+NiPJNeo3FhMGc3amPUhpKHzDrS?=
 =?us-ascii?Q?4Yu1H1FQ6xJrJkLEHmk96R4t8tuRBbh95PLk4/h0XVrkST5O9oC6UJPr1Opg?=
 =?us-ascii?Q?LGwYs0TiCcklau6vTJJgH4Achp4vpMGbli+WppBnqPgXEWBOs90xxSRSaQhf?=
 =?us-ascii?Q?9B6jzmgqGLpd/brNzp9uqQTWEfJEhIBVQ/tLgmyFPZ9t4Rq1L7jtDAFMkim+?=
 =?us-ascii?Q?Ic3z3Nnazazs2H21HMbsVPa2ued6ngDkBpTwtY7BTCH2QNSwWrDZ/lqu/Idg?=
 =?us-ascii?Q?BVY/xsghfeoxl83dGWAPuM8a/yzXCWBXqvh8UmBHbn9bGhvCpILLd1T9Y/7n?=
 =?us-ascii?Q?+PsWWxlfG23sYb3dWiYL5QTn6/ykTZznoekb9UBh9WohrxC0DvPgzcfCw8+i?=
 =?us-ascii?Q?q06gw0U6HtOG5LBGbCUyP1W8Z+k3toUCh7SWuzHHsX6TcsP/9skEtqEoVx6v?=
 =?us-ascii?Q?CyPjyzJioYwivZ7INHac3uFBnHow8QzIVjFMQewZY41U0CSgg6/W38JmRDUA?=
 =?us-ascii?Q?v/5rOMSbkWs2WHFmS1NusWIOMsZ0bN4RCTlJdRYjYl07oo1tx7JI5qaxjUk5?=
 =?us-ascii?Q?2Ef82vVB5KPQZU0xq3un3DR5kDo/gjQz/4xjNIp5bER146kxmzgl+gExfMAR?=
 =?us-ascii?Q?LGM+6q8sYw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e0f3bb-cbaa-42ea-3286-08de89e0129a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 20:01:01.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnrLcLgrhqQ6UkV8OPuLy3rFGdW1Z1EZo+mtpwIIzpMXrkTwI3bmNrlI/IUlXdxW5bjwu++/0tZKM1iCvyIWTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8267
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271269-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: E59CB31C095
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:49:40AM -0700, Andy Roulin wrote:
>  include/uapi/linux/if_link.h | 40 ++++++++++++++++++++++++++++++++++++

I forgot that this requires a spec update. See:

Documentation/netlink/specs/rt-link.yaml

But wait at least 24h before posting v2.

>  net/bridge/br_device.c       |  1 +
>  net/bridge/br_netlink.c      | 18 +++++++++++++++-
>  net/bridge/br_private.h      |  1 +
>  net/bridge/br_stp_if.c       | 17 ++++++++-------
>  5 files changed, 69 insertions(+), 8 deletions(-)

