Return-Path: <netdev+bounces-182130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C50A0A87F68
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF8F1894D9D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ED5298CA8;
	Mon, 14 Apr 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PVGReD3l"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3829899D;
	Mon, 14 Apr 2025 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630799; cv=fail; b=rIBRU2+aYdD7e2oa4VXrDoKkbj9RIlAR8CnHQBKLRTebI5md+2cSTEUiQ5C/ThGePUw8Vm/nJejH6ucq7BiDG/0ZLl3dXB2RAW9rhROIJsSRATdRiQDZHofsxYMJtftNq2I8brKucISelCFcfC3ycH9qvDdkV3w3Ugow/ysHcCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630799; c=relaxed/simple;
	bh=+YtDkMN63IlI4jnt1sTJiOvnpWs2eAaODUjqtu/x2KM=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WZYOvK8HE2VLPp3HJkNXd8U08r5Z1t0+HmQFtn+6ETZz1aEtlkfXXa3lixQXK4pTKZq97yFC0Hze8vt6mdVuP5/LTIb2YLswxH+coRVyAKOQhMtiLa6RsuwtA3lGOgCypiQNXfSACWAGGs4dWMAuEDmMuAGADYetPVhKzaiFxU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PVGReD3l; arc=fail smtp.client-ip=40.107.241.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdblmIRX1wx29YkzKrz+E4ZDImz/6Ls24on/7KSGJ/K9BNGor25i/+jlB70O1aGhq4hl15KuCR2NDceiPhqLGEZzR/VoNQ89l0zvzldLF0v+qIDeQimLNjb3M3hY9DE474W25f+QohareEOj1rfeIDa3MLPHeDwouGiUH2/ShIIKPjB4hpic0tdTESf0nAN5YRzhI33GsyyqUPrF1SQJRFVS0B3ub4QDV01Zl6c+dFaH5x7nPu0Y9EmIhPw87TbomyxFgdpaZ6yuqHPMJQsyeNyol6fnnPCkH78BUquvqvGiDO16i1wv0mAcA9spLgIUTd9yV6oy32J8AZkorssOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUIwtuzolwBXhMhy6wF3zDniUResV9/+Il7oSUYpVUo=;
 b=by/FZz+Pwi/H0BziPOSXkVN8uCvmUyQsMqzStQ7Gd0Wzfjr5FWSfglq9sFXmjENfGTDF8+g+6/gUT4IV84QKjwP8u9sWRChQhItKSlfS85KDzDDRxaQnW//N1SyjHoljkz5AunCEw+rxxuU29OVHMC/Dhuebgg16I4YVp7t8yIUFsnksPV/KD50aupJ1+u2jBzMnKAwUvkhBiyNzfIfb9sV1Rjq/IzzwPHu7JEYxWsIiA53erjYX5b0Npx/bgW7XbMhunyDcM3H8V129Bj3K405nb4obvMuDexulAPDT7uFn3xISu1TfZE6Us4fHcp1+t4pvHWYKo1f39Uh5FtAOSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUIwtuzolwBXhMhy6wF3zDniUResV9/+Il7oSUYpVUo=;
 b=PVGReD3leOLIREmwbRgc4TIShF9GbwFQWnfAXL6fqDsK0RFNCpHMw8TDxQzZyPYhlT8BQcPfxQDT4I9KDYzR1RuNYkoEwf6upSc4zGVvneKHimBtVUq2859/w71RwHi7SOhpgtWrbooTuYd8G4xlKL9SR52Avwa/Au9yrZQ8rQb7r6cakEBC7Kr3lSYrUgA0NbBT+o2rau5odtLh1n6PJqH6cBtUq3/brCo6JYYyzmD6izz+Z9TuzFgrXUCNxWLscF4utUp2fhoI9EQ3/WZ285haTTJopNLDo9pNM5YqYafdNEaS+P1jO/avNuctZvcUtQs6GETmkfRsR8e96+SKvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB9205.eurprd04.prod.outlook.com (2603:10a6:20b:44c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 11:39:51 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 11:39:29 +0000
Date: Mon, 14 Apr 2025 14:39:26 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net 1/2] net: bridge: switchdev: do not notify new
 brentries as changed
Message-ID: <20250414113926.vpy3gvck6etkscmu@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412122428.108029-2-jonas.gorski@gmail.com>
X-ClientProxiedBy: PA7P264CA0227.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: cca9df4c-4a73-40f1-c662-08dd7b490443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqWE6rk8DldIWygFkqGlxeGLsJKfZ+HgKlvo1UuskNg/4R3P3tUdPHLqWlwi?=
 =?us-ascii?Q?N7K9k5tCYmdlzjn8tpQOTe4nMwH5jICTDTRSr/KFla1XQNVB/IdZuVXKZTB2?=
 =?us-ascii?Q?KzkSvXqVknuwgWXhQKon6w+ga7aUTLvtucDRLk2kauJOQyVnX+HdZSs13dRx?=
 =?us-ascii?Q?LxrTVVtKBK6uExxcUz6ASWdwTKNSSxmzm0Y7bYnk4m39lXLB1ZYfZttn9C4q?=
 =?us-ascii?Q?r8s+yfNcDBtb9A/tcgY4C5KbNwXycqhDjZU3Dn1lwu6ei1LGN+i4fiv4FOl1?=
 =?us-ascii?Q?FV6xex4wcYTr5u50hh3nat+/umXwJrA5BSpOGboamoK7SDXS5qp4RuqPTjBn?=
 =?us-ascii?Q?VFbRye1msvn3m77cbHTeUNccrMjwgHZb2cuuzWRsUyqQaUxA0upbkAIEuKeB?=
 =?us-ascii?Q?mAa0bBmYJFXhH4VZnAS2lX0Sjh5lG6vWaZVRAhl9Xzp7mixUK7tKc5R+4ngx?=
 =?us-ascii?Q?U+Ih4ITomasm+APU2myEmgAuDyXQ0lTuMi9uQiP2Ye5QbRk3uSOJ4GXHDJlT?=
 =?us-ascii?Q?FgYRwC5T8ibRXpY4MndggJARzSqwVUEljyXq5wb1T07gGV2cuyOtky5VhL9u?=
 =?us-ascii?Q?nIm+J3737eetZAvWG0P95j0w7QRp+sDJlvMOckr6fX66imrIGyB4WQv9olWS?=
 =?us-ascii?Q?0pZDSt0XmwLrAEcZfXPvM+NHjpZF749r3gVAHHQnphZTjh7u/Tr4c9aX0PWE?=
 =?us-ascii?Q?WiIw4jgwkjKNitKSxuh3GctY14aQ6rr/+ZVVhJkWlOiGuWnKRirC8SnNB20D?=
 =?us-ascii?Q?zLMGbJKm7pJO9XRsygCYRyEblr9uzNqWbiz6XYZ6AzRcq6x69uk4GMXvhJOr?=
 =?us-ascii?Q?+ZMpphB1RmQQtTSb6GrY7pK74y4iGWjaTit+YP4NC4ONoXE/hTEkBKLh4SB3?=
 =?us-ascii?Q?ceKzIVe+sC/C0EYpvOXL5IHQ5vNx/nF8CTnK8MK1Osjhh//kr0KCjiuM0PwD?=
 =?us-ascii?Q?F/nEtJaLrmHsFmDDvDQjZ2elyQo3qfxhuBh/P8o2D3jfyrWFuSZvvchmlF24?=
 =?us-ascii?Q?fRqMvcoP29gHjVI/8Z4an7J3vvTNqrmRC14aMxZWTLIYmOfFgqylVzVNbRcy?=
 =?us-ascii?Q?v4G2M/eg61sjmZDQoY7Lmtm2PAkMYG3ipFM134OnFfKGvCnEZe5ptqg+vHV9?=
 =?us-ascii?Q?x1wo4GbBhdO2syB0eIMjtNeBF+BzfyCEKW3ki13/r7t3LTKuL9bH5VKQ7Ir8?=
 =?us-ascii?Q?6aKDfo1H3f8Z/QtfuL+Zlpb5VkQWoHu0DDoMrkzVUbf+FipNe7RIdRB10ak5?=
 =?us-ascii?Q?V6D7X7NGwpR0kea1N6ID5E6pawEOpfq5HpW7a3CwV9LXYUM93ZJohXXQ7ltM?=
 =?us-ascii?Q?EhP4MqczCUWXWzoJe51C+DFMR5Tk/zuXgtEbUOkYgfxrASAfka2tdN43MRkR?=
 =?us-ascii?Q?s0B9rdODcL/ts/LajlbnxRJIGqqFerz7lm5AnRvan/AWhwKCE6MjJkv5W+6t?=
 =?us-ascii?Q?w1gJQ/6jwik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Fb3F+hO9hwUG5/XCdXBDUXXXNJ1fOFKN4jtUsxZ4bP0jR4BZrMP22PCnxP4?=
 =?us-ascii?Q?850yxmytA7GcqzKhWQWluTR1n9M1A+0fsyG5b5UeIHhcBEwmlAOSYJc4aOcO?=
 =?us-ascii?Q?iApMaOuFmeEcKT6eoRZ8WcPVDgF2VT83P9MlmJpbHuwP4mdu2Fvl3NQD48cW?=
 =?us-ascii?Q?MhkVveS0gOF8G0OMJdREDpdE6+6+TisPyg/G1jlCzA+4RGvTdPO84eDvp8Fy?=
 =?us-ascii?Q?GPH7Gp2uTmmqGedMMLnfBrW/dEdFSCSDJ7hWbJEAb42TpHFWDcogH8Gy+Ob/?=
 =?us-ascii?Q?a+F2w79+pcvXedy1ODnPJow+A9CMTRFcPm5C9BHSB//15BcJ1+XO6KhOKlXN?=
 =?us-ascii?Q?J3xTVuYmpZfPmzKYM7gi6VekUWhoCruYnQMjKsTECK+QMhpAlIxiVikYJ7MA?=
 =?us-ascii?Q?UqFH+gKVsufq7SuOquEHvDKXOBOxEb6WNUqMbyg8wXxAXv6bqCnAU3XvB9Df?=
 =?us-ascii?Q?gaydE3+Q5sTBuo3CH/4t+rLNuipcfc4r3mxIM0xZlkxLe/cKztnUripnLOA5?=
 =?us-ascii?Q?y3m5n78z0yl3Mh/QFg0xj8nh6ocTw3PMNllhzg7FHjoFamfYUOP/xqg5SkQd?=
 =?us-ascii?Q?y6ZtBg9dLQmhRqW6QotQRHg6xRPvdjeQ4WZIUIBHsSZ+CsdlZ5P5OV5Rz0z3?=
 =?us-ascii?Q?Ynig0FsgPinOuHTSWVDq8AamJwQqB0vXzZ3pv5n0lE0ZwUkbzZDc59L197AD?=
 =?us-ascii?Q?n7xjcqUyTDnjgp8nKG8rpRi9PLA+tEa7MEKYW5hzlLof2gr5GFSvIgRidXML?=
 =?us-ascii?Q?vHgVt6NdaIZlBXrpTjiRrWaOuPLzECEMQiMBGmT+EPSBZoMMqJmkUVzCeXC2?=
 =?us-ascii?Q?kOD9eICAw/wxRhFKEYzVHfXt1Bq8MMcRa/lJHiQGC10kAuoJKoRCdZcQ3JUK?=
 =?us-ascii?Q?hq+z8ol66zTlCf19OpKCe9JJkVbzGyTKvWjqcGn207h/HXPgcIs5tleBCySh?=
 =?us-ascii?Q?n8YHGVOEI6+2WCEFKCFri6zIj10clConOXcr5PbhDXJvMFL6syCgcvkh0lNW?=
 =?us-ascii?Q?OIfv+dCd8rFlvCCOHlzmDQ6O8XvfqDgrw8sXEGVyMAOdHMLDd+kpfagwr8BB?=
 =?us-ascii?Q?OE9Ei/RjxDXQHzr7wSL1Wde5SmJbQASANqsgFPY2WkuCWvxH5qWT5LcDIsZy?=
 =?us-ascii?Q?Nm72iDZhYAeBcUPYSAyminTSQlrQxlBQbpjFuUwjVIzfrWABWBu9va6It+4V?=
 =?us-ascii?Q?wHVLOrhxBXNoGfTlN4+DywJfWPvGavjMCehYzOqYbIeNXVz11BI4LP7PQQ5/?=
 =?us-ascii?Q?cf3iFAl4ha4rxo6SZp21lJ/oeaeK5O+KcUjRiC7K0DV78K2OrzWUJBotPfVX?=
 =?us-ascii?Q?21Sl318a3aPzxsDHcSV72HBcA5XjuvlbBjznsyp1XY+X7zChNowZ9tARaPAb?=
 =?us-ascii?Q?g0TS0GaF05ldU4DGUPtVEeGJgl8gVnovpfatbxvz8meYLtYoLBcDsXfk6SvW?=
 =?us-ascii?Q?tnlPpP2PFyqlH9TTf63SMm/yn/P35F/P0sjZ5PTwL3G7X8NKpOrE9WMp/epH?=
 =?us-ascii?Q?yiNd6fnKi+8kLx8EKRzM7StZTjOVCgdQb8IlIPc/O1knY2hRicgaHYNuGFbO?=
 =?us-ascii?Q?sGU66gOxl7Vyo15aSYZp1HzOe4SUNWD0CH/7keHlluAxNkx+wZFvQbiJgce0?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca9df4c-4a73-40f1-c662-08dd7b490443
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 11:39:29.2703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0SoJgZuOgAstLrBYv8VQ59xDeh3ICPLETOURn44tRIKebcor65xltp7oaFm+93GQS3C6x9e33wNGESwf4yNgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9205

On Sat, Apr 12, 2025 at 02:24:27PM +0200, Jonas Gorski wrote:
> When adding a bridge vlan that is pvid or untagged after the vlan has
> already been added to any other switchdev backed port, the vlan change
> will be propagated as changed, since the flags change.
> 
> This causes the vlan to not be added to the hardware for DSA switches,
> since the DSA handler ignores any vlans for the CPU or DSA ports that
> are changed.
> 
> E.g. the following order of operations would work:
> 
> $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
> $ ip link set lan1 master swbridge
> $ bridge vlan add dev swbridge vid 1 pvid untagged self
> $ bridge vlan add dev lan1 vid 1 pvid untagged
> 
> but this order would brake:

nitpick: s/brake/break/

> 
> $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
> $ ip link set lan1 master swbridge
> $ bridge vlan add dev lan1 vid 1 pvid untagged
> $ bridge vlan add dev swbridge vid 1 pvid untagged self
> 
> Additionally, the vlan on the bridge itself would become undeletable:
> 
> $ bridge vlan
> port              vlan-id
> lan1              1 PVID Egress Untagged
> swbridge          1 PVID Egress Untagged
> $ bridge vlan del dev swbridge vid 1 self
> $ bridge vlan
> port              vlan-id
> lan1              1 PVID Egress Untagged
> swbridge          1 Egress Untagged
> 
> since the vlan was never added to DSA's vlan list, so deleting it will
> cause an error, causing the bridge code to not remove it.
> 
> Fix this by checking if flags changed only for vlans that are already
> brentry and pass changed as false for those that become brentries, as
> these are a new vlan (member) from the switchdev point of view.
> 
> Fixes: 8d23a54f5bee ("net: bridge: switchdev: differentiate new VLANs from changed ones")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  net/bridge/br_vlan.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index d9a69ec9affe..939a3aa78d5c 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -715,8 +715,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
>  				u16 flags, bool *changed,
>  				struct netlink_ext_ack *extack)
>  {
> -	bool would_change = __vlan_flags_would_change(vlan, flags);
>  	bool becomes_brentry = false;
> +	bool would_change = false;
>  	int err;
>  
>  	if (!br_vlan_is_brentry(vlan)) {
> @@ -725,6 +725,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
>  			return -EINVAL;
>  
>  		becomes_brentry = true;
> +	} else {
> +		would_change = __vlan_flags_would_change(vlan, flags);
>  	}
>  
>  	/* Master VLANs that aren't brentries weren't notified before,
> -- 
> 2.43.0
> 

You might want to mention that "bool *changed" is used later in
br_process_vlan_info() to make a decision whether to call
br_vlan_notify(RTM_NEWVLAN) or not. We want to notify switchdev with
changed=false, but we want to keep notifying the change to rtnetlink.

The rtnetlink notification still happens even if we don't set
would_change here, because it depends on this code snippet:

	if (becomes_brentry) {
		...
		*changed = true;
		...
	}

and not on this one:

	if (would_change)
		*changed = true;

That was my only concern with this change (I had missed the first snippet
when initially reading the code), and I didn't see in the commit log
some sort of attention paid to this detail.

With that:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

