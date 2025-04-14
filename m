Return-Path: <netdev+bounces-182156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C883FA880CD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE44B1897D26
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA2A29DB80;
	Mon, 14 Apr 2025 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EKTr8CTM"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC02BF3C5;
	Mon, 14 Apr 2025 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634980; cv=fail; b=FnY27eLeFTFkwjnXkhieexd2fRRrM+q7XfYoXKxBfEOkxoEedGkMB73l8arkB9NnKi+Pz8hFa92dHgBmCym1F6z2P3/hDPZEguZAnrrxMVXZ7881SzauTKfliXda0DPH16hsXhxEV3BrfETAMBX5DzNBYBkPxv8ao8W3NsKVgZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634980; c=relaxed/simple;
	bh=xevKO1RsEPlxooes/u1ay21jR8eYtSIf6iGg8Ma4YdQ=;
	h=Date:From:Cc:Subject:Message-ID:Content-Type:Content-Disposition:
	 In-Reply-To:MIME-Version; b=TxmN+Tmp65VXmXahGsNgeuGQxrJuzaoP2V17OT/wuuMd1Qp8B8DAJsWwcUnLFFabN6Nh82f0tPlB4msiFxovY4S323XLkRc4hC7R94fqmzH8eIWUP2kzjcI0jNGzc/C6O8xrtuH1KZxrgLXlxnB4zJV0pUUHzS30EcuvGIOfMQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EKTr8CTM; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJbDVax9M2xeyTRpx1wWIHtU17wkzV+6TNg5kbNcIa0scQCaJA2cnretogyt/rLiOA2BfleEA0mpWveYReozY0u5s7+LgAcG9elRqGxgvrbV8/ezhCjzNUycNv8YwlqiJeb3clJMgA1sKgeTAo7ynGfqyfa/E6IblRvNO0sa8jRotFzP+TUCP43myylLvyG+ArnfxfUka514V1xSH5QB9U9BZORVQKVr0uqkAas2lDdyA0ZAXZPJ2n0dpMewJdHj/ikVrC+pGLX8EgWSB9SBfDbdW2qixCgqOcUYwSuFkCZr9/BKHLrIUhLr2tX8fO7iqth2J511dIrugeuDViyMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHL3ACAMjGdfjpMLN+ZHvnKPbf8y++fpU2kIyEuO1Qw=;
 b=IybI56bMT/Dk9P6cP6HW1mVFTGouJ3sn/97OGipa8EUfL8kkhqzYZvsi4Kjx9YXJO4tZAPIrSYmKcUu3iFjIvt9kaziMyqOn2a6c65yK36myzOlWRxMqU/Cbrx08RGC6svvRn21UzIJ260wkhr6vEMp7ZH1BTO+SVadZf1hQV6/ZmUtgcXUQzdtb8QeaB5uMT524phqSKlZHc2YYeWGNDmSMY0twMzQ5Z2jlCfRCto9PCZk5xgjWuQrhwbO9LZgAiB8fXak67VsBzlVzMehlVzcLE1OyBFypzMjVSZuoBvqr56j+oQoP7dgCUr8QWSb6c+gmZQO9P8uvCkAiLQeZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHL3ACAMjGdfjpMLN+ZHvnKPbf8y++fpU2kIyEuO1Qw=;
 b=EKTr8CTMgH6qTbl8Ruf6FjNwkdlAjaRz6E3SecnCRzsVrc/g/N/PYrbKN0SdmLMsDIpKEEX4DbgGoMnAmpt83TLA5Fs/RcRM2IVzwfJk20PAKi8jP7xpgRb7uSV47iK7EXqSjCPSEhRI7l7FBq8l0yX44XRk27PCtyN/hU4VdSja/Ptv6pvuFP0XN7cquGiwGf6XsAh2zEcja+7h9nWn0EQyZpaovnXGQFgYRY/sVWiZFRnu+2OJxA2MVHzJggjl/IHDTkFUacAGDk36L19kj+Ydjnmae6kFG6+WfGBDPwC4ucDSV1iS6GPUy/ERiUYvDAXUC8pvbfn00hPtlxafwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8977.eurprd04.prod.outlook.com (2603:10a6:20b:42c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 12:49:34 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 12:49:34 +0000
Date: Mon, 14 Apr 2025 15:49:30 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net 2/2] net: dsa: propagate brentry flag changes
Message-ID: <20250414124930.j435ccohw3lna4ig@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412122428.108029-3-jonas.gorski@gmail.com>
 <20250412122428.108029-3-jonas.gorski@gmail.com>
X-ClientProxiedBy: PA7P264CA0216.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9a1f32-e26d-4777-863c-08dd7b52ce49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H1QI/BBzLRV8G2qXz7LZnA5ExFXliU/CJ+7iXvRjxkru8XUdnIYfvYFs3UD1?=
 =?us-ascii?Q?dtnB+18K/td6QuOC+8bgHePV6CY7fVRzRAppQsXYZ0cS1ZISkFpxQG1KE1Iv?=
 =?us-ascii?Q?IxaVbTPoFOVLqp0Vsoc7tdlhk3Gd+zvhe3zjiLFriJPzW7EzRL+YEiRZe1BX?=
 =?us-ascii?Q?ns9+eJ8oConFdgiH/Dlxx7aCXA1SUhmn1b4wmjuJBPHqUr1kkWDbTlqJFlde?=
 =?us-ascii?Q?aGld4uJQj6SHAYT+5GgrrpMcDo35ECdOm8Fdj7+uK7MNvSG9iUPrG3kwjqTC?=
 =?us-ascii?Q?UdtHcxvqLtXw5bdvj4GovVN6Nyrrm5jqVwpflrMEk7LoBLyTfvZvxyxIcmLS?=
 =?us-ascii?Q?kiTRWQMs2qTBVgU8CC9hi7Ji5EKKv2OZeLEq4ocKQerIItI2nrEOboi59AZu?=
 =?us-ascii?Q?tmBmqSoFLYxKQA+oFvE9ofin10mauzFLdm89Smkyh9x/huAZ+1lMnHPaDJvf?=
 =?us-ascii?Q?NXFgKBMpOws74UgOlaqwnmvraNF9AfmW2XCUzzmJXyP3Vgm872vhWpfZlmGk?=
 =?us-ascii?Q?bbsMJ5Oj1k3raeZ8fqEYGqpsxJJ/eo7E2YgiOX8KDfDF0ogUPKNhI0jwxOFt?=
 =?us-ascii?Q?YcA4xY4fFkmfbrACYJuUd4TN1DfECDeiANDABvKRbqqCPcYEL/7RkYK4MMJw?=
 =?us-ascii?Q?xOtjEyy+nVT1UBCWvcsl3zIo9HS9wJjXPAQ9yqNckw80fCXJBpJCpDwhviNr?=
 =?us-ascii?Q?B7L8ntnwBrZu+yS0wJBEQ8Haaa5wYy3oTCZqAcYe8UBxdcytqiOLUrLlYZXL?=
 =?us-ascii?Q?ylsPJmWeqzW+MS+tEO4WI608JOFm7U9FZSKAD69THDuZiUJ9Py6Zo9vLD1lA?=
 =?us-ascii?Q?tnIk19HWQ4cEJQOn2quFssNJlDy6aOcI89EIuz1CJolhvZfkyk623eqeG5zP?=
 =?us-ascii?Q?sGqSh99fYSMQ2filjsFKni8Y6P/HjVN+eIwzKvsffsSINXhHIqAo9wdyRNor?=
 =?us-ascii?Q?S3gMzu8pXQMQIpZc1d7c+J8tQo3o862Cxg0yJTQ7NOV31mOLwaOizH/h8zBR?=
 =?us-ascii?Q?h3EsvE8CNk0JoLNQkJpXllVp6WBDnPur8Y8BUYUwePjHGyq+53XIoyotwWsg?=
 =?us-ascii?Q?dS6N3Mu7hEGCyyO2PfYtCBE/aSqQjy/aXU03UFYo1RkVP8R6/OI9Z+gDi3B6?=
 =?us-ascii?Q?YiMinU3I/Jf9WR5fI4/3be9I50QSUuulS/DOKZ3TumjjtB282X35zQmyAAO4?=
 =?us-ascii?Q?5dZklRZYDUfGHduE7a5iicC0jNw3ikZp6NExR9zovg0U7erY9We/0ij1UIls?=
 =?us-ascii?Q?+tdRH+9Xm9iP1nlkA2OrrH/ppKf90lEsBT8RbikMgoRkTOntvStD7YMjMNOS?=
 =?us-ascii?Q?CQxoGfivUPV8JDg1wpcsBikJB+k7xU07eh3gT9KLlDtRO4Vjdibc0kNkTzfJ?=
 =?us-ascii?Q?fqE/uShiZBG1377+pQ0pUgW9aAmwvG5sRdERIi1k16/e7u7DDDAGpNMr3Lml?=
 =?us-ascii?Q?fgf3tvs7cHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SESL8W7TezzadUP2ajiXZYVICQ5FtGGz9t/3G7LQ3wIFB4g0WlAgBpB+JMGg?=
 =?us-ascii?Q?JZyQrDCGBGtAE0IWncCpkJtIwjb00S0OmF5TpjhOcKSiRWc2JiD0xHDALG9r?=
 =?us-ascii?Q?/oalQYrcDNANJDEEMTvq6t/NC1PAtX9SEIcmwzT7KNSlFtsDvTQM7pqwxaya?=
 =?us-ascii?Q?izBtz8ytCVq0NwhayrVMM1FGiG10wgqpkx7QkVam5d420yDLkV5jBdROtQJz?=
 =?us-ascii?Q?6drPgusCrf3V7tQtaR01wPejhohPHUFWyTTqwFUxlh4sX/f/MXvnTfg5uX+A?=
 =?us-ascii?Q?Sr/dhEIzQPUgNWuMluiiuU0NTJGjb5jjwIYzTBGE7wq7CiwPuuObXgYoJtEu?=
 =?us-ascii?Q?GKLKdsjNziWNYhPtmRA+leA9dE2gsKv4VXRqjbfTCmjfJOm0jnRF8O2MAcVe?=
 =?us-ascii?Q?sd+hwKFuAk9L48FVqVmMgkKiVea97wezi5ffO9UyVzDc+r+JnTnfFG3NnghM?=
 =?us-ascii?Q?seV/9KHcggGJmfsMcM2dg6Ns284PnsZ8rKLcKPFPuJw0b2qeHZFLIlbCNEt4?=
 =?us-ascii?Q?sKdBX2MG6o9fGTvlGa/dcWIVL3vOynB7R3lIgi2FU6QiFpNgUnCexfVtGdcH?=
 =?us-ascii?Q?qU93gmh+1nZ9y0WCyWby0w0BsPRuPTmgHzxRwJaiK3zCz7EjYmte3t0mQKyn?=
 =?us-ascii?Q?wGqmasiPDOzVk9VIOa2IC2p6OpLLFw/qjw63u4KnBPca2xmfw/z8hqzbcyH7?=
 =?us-ascii?Q?kaLBNNXknAGHq7/KdpT3OFb1TVCF1m/QsMwx4YBWfhSFboAECVbfJUWBtaeW?=
 =?us-ascii?Q?49Vh/qevkWphlQvnD8EwtsaUrKy4cdqUrZ5ln5S/Dqpn0axc7yQtqxBwTotM?=
 =?us-ascii?Q?z40zdS7TrPKfHA2Xx4osodUleXLTEzRnZlDbM87o+FGMy1gSLmEKMUun48IZ?=
 =?us-ascii?Q?WGplqaqrZpDO3FM6+ufS5HYGdwioDzzr6DcsJI/QrPhU8GuMDtHG5slYINGS?=
 =?us-ascii?Q?jooRUFjOShHdLV1G9LkzCalo7dflTVkuYnNB0e0BG+DZccsVm+Sp1vOvcXwV?=
 =?us-ascii?Q?6TtF8g/KAmrkRjte4sK2UeQQSZbncEbFT/iYX4k6Rx/ThyLCKkU7XMgvCwSc?=
 =?us-ascii?Q?h6n7UQqg+uLj9hdqBFEiW2ySV3X88wg6mHVBp/j/h2vOEJ6TVjuVZma4h3I0?=
 =?us-ascii?Q?RR1Og+6zOcas/StlF0OT7HC1RNBbZqSrPZcufevVxs5kzSO6u4cNb9hZ/DLW?=
 =?us-ascii?Q?w/7jIHtCABWi9w5XbllyKO/JN4G5ZgYwqal94cH3ojMTm64aU/55tjTNtjI2?=
 =?us-ascii?Q?ZqLijlzUuMdrb9lzmbBPQNE6ziyVKUfN+6171qC+FGEOoDtSsAmYWd3PI7S+?=
 =?us-ascii?Q?J30+eFY8qORiiek02ES8UB+KRfW7zOCI5TtuxajQyT1PJeAvQM7MDyfDbfzD?=
 =?us-ascii?Q?anUriZK5iuHjztonjUyf1kU7/UYuzJ9aJwwnZJ/xbVW5fHUzSTXMG35X6g29?=
 =?us-ascii?Q?cG0wX14Rv38cBrQE4WDs1cCJuc5HYbIS5s6b5KlsNFpDBnYbH0+kID2bYoxr?=
 =?us-ascii?Q?Oyo2zLl6FBEjOSlESEjt+4T2RY0oRGP7bSOv0/YqWBq2Muq6AnS/wQikvcNJ?=
 =?us-ascii?Q?8C5LZ3regBttCQOLA2F2K08qSple3OU6uNB5lQfFHtMAEREv8UoXsj3iynbi?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9a1f32-e26d-4777-863c-08dd7b52ce49
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 12:49:34.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOHvcto8C4U0ZdJhahl4MurFBdyx61OSSsZyFKSEooB3FkU9VZkQ+kIWeysmvzxd8740GivyMa1LzWj2sq3vPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8977

On Sat, Apr 12, 2025 at 02:24:28PM +0200, Jonas Gorski wrote:
> Currently any flag changes for brentry vlans are ignored, so the
> configured cpu port vlan will get stuck at whatever the original flags
> were.
> 
> E.g.
> 
> $ bridge vlan add dev swbridge vid 10 self pvid untagged
> $ bridge vlan add dev swbridge vid 10 self
> 
> Would cause the vlan to get "stuck" at pvid untagged in the hardware,
> despite now being configured as tagged on the bridge.
> 
> Fix this by passing on changed vlans to drivers, but do not increase the
> refcount for updates.
> 
> Since we should never get an update for a non-existing VLAN, add a
> WARN_ON() in case it happens.
> 
> Fixes: 134ef2388e7f ("net: dsa: add explicit support for host bridge VLANs")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---

I think it's important to realize that the meaning of the "flags" of
VLANs offloaded to the CPU port is not completely defined.
"egress-untagged" from the perspective of the hardware CPU port is the
opposite direction compared to "egress-untagged" from the perspective of
the bridge device (one is Linux RX, the other is Linux TX).

Additionally, we install in DSA as host VLANs also those bridge port VLANs
which were configured by the user on foreign interfaces. It's not exactly
clear how to reconcile the "flags" of a VLAN installed on the bridge
itself with the "flags" of a VLAN installed on a foreign bridge port.

Example:
ip link add br0 type bridge vlan_filtering 1 vlan_default_pvid 0
ip link set veth0 master br0 # foreign interface, unrelated to DSA
ip link set swp0 master br0 # DSA interface
bridge vlan add dev br0 vid 1 self pvid untagged # leads to an "dsa_vlan_add_hw: cpu port N vid 1 untagged" trace event
bridge vlan add dev veth0 vid 1 # still leads to an "dsa_vlan_add_bump: cpu port N vid 1 refcount 2" trace event after your change

Depending on your expectations, you might think that host VID 1 would
also need to become egress-tagged in this case, although from the
bridge's perspective, it hasn't "changed", because it is a VLAN from a
different VLAN group (port veth0 vs bridge br0).

The reverse is true as well. Because the user can toggle the "pvid" flag
of the bridge VLAN, that will make the switchdev object be notified with
changed=true. But since DSA clears BRIDGE_VLAN_INFO_PVID, the host VLAN,
as programmed to hardware, would be identical, yet we reprogram it anyway.

Both would seem to indicate that "changed" from the bridge perspective
is not what matters for calling the driver, but a different "changed"
flag, calculated by DSA from its own perspective.

I was a bit reluctant to add such complexity in dsa_port_do_vlan_add(),
considering that many drivers treat the VLANs on the CPU port as
always-tagged towards software (not b53 though, except for
b53_vlan_port_needs_forced_tagged() which is only for DSA_TAG_PROTO_NONE).
In fact, what is not entirely clear to me is what happens if they _don't_
treat the CPU port in a special way. Because software needs to know in
which VLAN did the hardware begin to process a packet: if the software
bridge needs to continue the processing of that packet, it needs to do
so _in the same VLAN_. If the accelerator sends packets as VLAN-untagged
to software, that information is lost and VLAN hopping might take place.
So I was hoping that nobody would notice that the change of flags on
host VLANs isn't propagated to drivers, because none of the flags should
be of particular relevance in the first place.

I would like to understand better, in terms of user-visible impact, what
is the problem that you see?

