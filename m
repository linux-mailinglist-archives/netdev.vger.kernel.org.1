Return-Path: <netdev+bounces-189893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD22AB45F8
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 23:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D6C7A5C4C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6F0299942;
	Mon, 12 May 2025 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mlR+vg8T"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26330171CD
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747084190; cv=fail; b=spLN82R3S501mVippPMl5sRQZp4SFYLPn0EGg+IXioUHBec08/0arfitPCq9Wlmy9lK5ue/QT8iH8Qe5w1NEUnaVu5vdOUS/wVO0dSoKqfLZHR8pOMevKtW+NKnRxjXgDIFRONyE/KsILT4mMONLRShDQdsMhYe1q8lZCYIiwvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747084190; c=relaxed/simple;
	bh=CXpkVfBJuwCL7TsSzDiOncNrlGK+CU3Il6aKDEE812I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ni2Jo41mCJaZPfE3PlvDD/apdvi0j/lMgBkYRmqCcuTMXkWIn2N+DD+ks77VRjw1IDYsVtQcsGPd0++VZogL6fae+HVKq2v9LrVO91b9mX12g/oWSB3IyvJfV88rtBZFec5CqUWwOcMWU1NwnED22MtpBhznUb9itIsyCYChh7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mlR+vg8T; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFP0RMv9doBY/gZ3d8OU3dBTpcNonIH8pIOiX5UcZ8UFWzEILQVZmZVE1o3abOhZnm+tbhDKUqS4xIKer/f2oc95j6d4VelWRkhW0b87kDxloVUbnnpyLxqV2XxdZADy6orkszd+yjA0EDI79uQnS+vgfXsmwNfJRnb6fdQ3nMijlXh64VEQ7kSv3uMwMJPbhjCssIbXDmHUmH2deo+QTWIf3R4VPNAeaxhiy5eRE0mCSVwdsRsRhY8gN1/z4hsAcGkma2c689P+gbfmvj4l+2yn+b5W+GE+MoN6jU7jYRxIKG/Icym99HPSpS8ia2tziniLXBprgLscOijSTMA1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op69KttYOEFt6w3NBSM8itWFKMv7c7YqxwIiib2mH3Q=;
 b=ZxGJIHdxpmOAKnaLiSHyUDuUW4nHwO6Nof/3oDVBYzuxy4/ulz6lVqIEdYJVqNddElNFSfiRAzXFZ7k/x8zewLRul2XVS8NPN/DhPU4JQS+lD09aGOiisayT/itqLZcaDhX4DI2X6uCo17zoZ/X+2b0vCRiruPdz4u1L2VMCuYLZs8mPCZMf0H47t3wRjgS+wCUjDZgT4MikIy1dxsHsoPCBYesS/qBHL8tKVwyAtVyexPyG8mpKrTP/sDkNEO68svuCzLMhv95eD4JrQzznY0DKzgnMHWL43F1LJ1fofcq04mW2ZW4UeYMv2y2TcyL9Rv69Gf9H7NvBVZ25ZwbB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op69KttYOEFt6w3NBSM8itWFKMv7c7YqxwIiib2mH3Q=;
 b=mlR+vg8TXHYLu7sSzL/nf2GKzLqOcMsToMsZKttpqGo590fFan1NISjDgPR2XzWp4z+88+Zm9bnK3mTHN74bRpnyFDkQbUj4mZ+X3CgPWTY8bRigUG1+07UtVLVgNbnZOoE/vVmcsF02c5rmV2hntuZWpbNsH6YLSccm3SZXm3bKcauJeVOdmB1ffkssXCH0oEn0amdLpbF0ha/+ZkNClItqqy4R/O45ikkBJCjjvNpOaq+ny6yVb/RCUO56ExqBG4rBdTD0zi/Gu+LOf+SeCpVFJ8EHrcjuq08Cq0kBJKfSj6cJcLssGkld/eu0h2K5tFV04s2X8W1/CTEy9ohFWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM9PR04MB8601.eurprd04.prod.outlook.com (2603:10a6:20b:438::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 21:09:45 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 21:09:45 +0000
Date: Tue, 13 May 2025 00:09:42 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: tsnep: fix timestamping with a stacked DSA
 driver
Message-ID: <20250512210942.2bvv466abjdswhay@skbuf>
References: <20250512132430.344473-1-vladimir.oltean@nxp.com>
 <532276c5-0c5f-41dd-add9-487f39ec1b3a@engleder-embedded.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <532276c5-0c5f-41dd-add9-487f39ec1b3a@engleder-embedded.com>
X-ClientProxiedBy: VI1PR06CA0190.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::47) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM9PR04MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: eb71d7da-c5a1-4a5b-3ce8-08dd9199520d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jcECE1rgroqj59G3IAnBKg+mLwk1bnCzKpfA9C1FmRUIkEE6Reg3MDaxcWK/?=
 =?us-ascii?Q?uxV1m2wGV3WHjxUvB+WWzs7aM06+JzfzoaHoIXH/29b0UT3OJoKuLnV1Ru0X?=
 =?us-ascii?Q?3mwb0pkGGIzk+tHurlz9kNcrWAiz7eD6XxCaGHqmZbHLphbl/5jSAec1fmCK?=
 =?us-ascii?Q?3HGnpPUEUv8Kggx11H+oxl6cAgjV7M7VLJkn7fZS2CI4oXpi/1TKb8uXhOIu?=
 =?us-ascii?Q?dStShTl6TOwm25NxnTswdD5/6j3vpwtFVHtXZ80IjuHuVs8S/PwTQN4XMsLA?=
 =?us-ascii?Q?RFEhgAlTP20JoUcF+X6L6z1K3OMRf41P/kJBMobU297U0T/BuTTemFE92mUl?=
 =?us-ascii?Q?A5a3sLBQ+B2OXjs4cgoRISUKGYa5g31XKqkF14evIdQQYdUqSIic4cOPIYmh?=
 =?us-ascii?Q?xzAG6xB0+C/180k51iT7LoR56WD+KyeJQ5GvbfBRvR03G03cDLCbakh1rHsR?=
 =?us-ascii?Q?ENUqLFxQqc1+SfkM9tn9/WATO7JI/GEKW5pYCSbBRJNAbcK2VfMx9+b74v/1?=
 =?us-ascii?Q?ZSdJp8W+6vA1XtTU63PznoM6h0LfeDaf9P4vCxi575Pq1Q0s7gPnVliI/nDH?=
 =?us-ascii?Q?R87oMrZtCT08i0EtTHY6R9DP9I+H2iKO4mGt+9/rd7PUrpFJnfHEhk86dIeY?=
 =?us-ascii?Q?yp3MbIII0x2kbuCch6rjRt+Kpix5bYOb+jWyj9vktx+NIndQw48wywt68aBN?=
 =?us-ascii?Q?nhxXgmUzvfvHHeSxQp2DDgV2Pash2dQe0CroRyjAwg9FU+VjmhVG2GnI27h5?=
 =?us-ascii?Q?XxPJgUY2osj3wwOEcaW6MVi02vH7ET3e5vbqbh3/FI7FCGtA5MeDrIUOcBU7?=
 =?us-ascii?Q?Qfrk7g6xUGDw8EpRSJD/y3bErZ7NAGPB+DxBvYImuAEQLufpAXmVZn9Be7dG?=
 =?us-ascii?Q?1+yyYLV/dSAmxOL6/TNS9lY301Tfdvec0cc+He2cZtydDbSpoYQQoPk8yzkn?=
 =?us-ascii?Q?zxg7yn7j8b52DFSkfxHJx7KczYJ8kKbYDundQIGzjy3aHzZHk19kKPhxmSlZ?=
 =?us-ascii?Q?rwM6XlyQ825j/ES9F+Ng3dQe7S9BYFMqzHk3Yj7p3sN/5U76EnundlNU8Yht?=
 =?us-ascii?Q?sqcmafEto4Q1MM/kiDnkkqw06Z1mG3qQGKQH9ZKKq50icAxJWklwAyhnF8eh?=
 =?us-ascii?Q?J+8MmJC0OCn4tXYPIzafPTMNtqxdvSspV7FaUgNVyd/+WmGbCdWMJiLqJo7I?=
 =?us-ascii?Q?Qy1X5GclELVzDBHxYFNS+rm4BPlJPm3yBT4wNVcZGSCfJq4sdqSwZH+9osVG?=
 =?us-ascii?Q?T3GumL2K5BPDYO/8rdaPXvalVRkZm15pMAUrQc8PW7xNF1eOw3O1TTpEyWdb?=
 =?us-ascii?Q?MeFVMiisAzfj16AxzwwfyrRKXrl4cPRHfYPfk0JA9v2l7Ejny3+PS8AlMrsc?=
 =?us-ascii?Q?kRRHd/yLvtUPUhSPYXZ0jdfT0unYQ8tP7u6l57hWZA8nOg5V1SZNOm6zbeaZ?=
 =?us-ascii?Q?KxIXqh/ObSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ex7bb5koAgHTGzJo45d4TVw7ToQpjNIugTnJl0rHrLO1qZSQaRtUMie6Whe?=
 =?us-ascii?Q?DQ8qu2Br5IuTiYBZdTQeT5rH4vrKyCBZbL9Uwxejs+xs5jTUndKKCMtm0jF1?=
 =?us-ascii?Q?U3fhWGT7lTEazTxX5rW9c59vpZwgzvdl6+MSBiN1In5CLREVdYMvhgl8tCWQ?=
 =?us-ascii?Q?Fdb/SM/L505MkjGlTxS8+UtiWGCNImz06JOzcKlZ2LLcTvg/AR+0acS+HaR9?=
 =?us-ascii?Q?8Fh8sK0RczL95OgLiR2q5HER9Rr0NF5S5p/BhjG9qeUj5eeIDf4s49uEl5Pc?=
 =?us-ascii?Q?NMbKVRMS/ajiYD25SDhL1wKTo+UrqODyHbvq1QWqWm9IX0nZ/fDEnP2MEM6/?=
 =?us-ascii?Q?6uxXNtbvteLW0qVYrtPVhPvtCI6sUWOZpvas04+YS9jgyd8OrmoVFaRptbuI?=
 =?us-ascii?Q?6XaqDtpKEFYfo3f7llXizBvTVlTJlcYMBPMbHaoL9MLIl2Z6DHm7BAa4AVG+?=
 =?us-ascii?Q?vbTtaUMMPtwAtTt//8Vas7uChkniTRZU0U7AGG75ClAqGltwoq05oXef3zBv?=
 =?us-ascii?Q?EB0dbjprfrseVfFp6GYo/MGRRxRK0WBNOquMA4X8SFFdyNb/H3YvHFHecoNt?=
 =?us-ascii?Q?nzfF4s2wWgOqN7rSZh+6BKL3sek0h+u3friuMS3eiUivDeW+ymeQHalAOUyd?=
 =?us-ascii?Q?YGB+sA+42ZOicxDchLag0WvvOAbinTa4+ZBdbls4F/Z+K7w3dwDMampCdwNX?=
 =?us-ascii?Q?pkgyNM7HAMx0KmrMkPkNLrI6DErtMAdoYnRz3ihcQO0KT1CKfeQWftoyRAyy?=
 =?us-ascii?Q?zDPAuE4p6GNBlbdiBNOsl52yReXDlC0+breyFtBWyWz2POvBoJEeh9hQ1kfx?=
 =?us-ascii?Q?invaeVfSfzMuA1Vk+KSD/CBY8Oe+hKMkACGuJYs73yfGy8+jWo4YKGYltS8h?=
 =?us-ascii?Q?YXPNKenu77VTA1TOK+IsCi/L3QqaPUVWmBYfR3x8knpNnZLsqnEb6z+LPfrp?=
 =?us-ascii?Q?JtbZzKVaj4iFQTktmUnuR85aNlhe6EpIX6y/22y1YqClBTPqSESBUT7/cR4c?=
 =?us-ascii?Q?GdLh/CB6//P70Oof0FU6Bj3I7JHIhhutCrsZ+kL8XqTgslbuR4ZdkLFoS6Wk?=
 =?us-ascii?Q?DEWJkT6lNWQfg4vcRRSPJa/7T2Lu61lMP4nD4JiUvsCSMqBRnFGPQEZWHQgU?=
 =?us-ascii?Q?qpPw+Ljj7CWH4dQtTrIbHtchyl+f1kSQiLA3HF0enkLrJBAB5JAMSswSUT4J?=
 =?us-ascii?Q?b1fRB16iVI2z9Zmf2bseyT8X/VkpH8QfDD1GhFTC5VEXZKUk9ICe/MNa9hpe?=
 =?us-ascii?Q?F+qdn6bI8v0VUZBzDRAOiwBARAy+sHVMAPKhxLH3/YIkTGadcVsiE4OEB2GS?=
 =?us-ascii?Q?INZWR6W3kLeM8DQddedw2Jj/BoLLm6ny63ru8HfoioGoJXzinNjPNWRLcN7E?=
 =?us-ascii?Q?GCWKLNoJPzhxgLfWD00STOXiUSroclqQkqVJq2ZKKYwerhUfldEP/rr1aKpy?=
 =?us-ascii?Q?KchD7HIn9Tmm/uA3CfUtR1HqKtCBpNSnj0zx6fqGZ2vjB3FXSfkYRCe25UGG?=
 =?us-ascii?Q?bykfWevDhaO8MqAOViFkp+ul7yskhuW1Do/DZXtRYEl7SKfnQYfNQ1C6EdmV?=
 =?us-ascii?Q?cYDKI3rC2ref6oZMZPoOR/cLHdAYx8BOsq1oiAE8vlkldBBGThzxdGWb0+7/?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb71d7da-c5a1-4a5b-3ce8-08dd9199520d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 21:09:45.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6H+xFshXY2xqU+/PPJWKBh3aZmqkgDnHNIn7BDHHMPs3N1KutgBpX09I2Oyv2ZiqXM4hKb6f7NWOiqtwM5bsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8601

On Mon, May 12, 2025 at 10:07:52PM +0200, Gerhard Engleder wrote:
> On 12.05.25 15:24, Vladimir Oltean wrote:
> > This driver seems susceptible to a form of the bug explained in commit
> > c26a2c2ddc01 ("gianfar: Fix TX timestamping with a stacked DSA driver")
> > and in Documentation/networking/timestamping.rst section "Other caveats
> > for MAC drivers", specifically it timestamps any skb which has
> > SKBTX_HW_TSTAMP, and does not consider adapter->hwtstamp_config.tx_type.
> 
> Is it necessary in general to check adapter->hwtstamp_config.tx_type for
> HWTSTAMP_TX_ON or only to fix this bug?

I'll start with the problem description and work my way towards an answer.

The socket UAPI doesn't support presenting multiple TX hardware timestamps
for the same packet, or better said, user space has no way of distinguishing
the source of a hardware timestamp other than assuming it comes from the
PHC reported by the ethtool get_ts_info() of the driver. If the kernel
delivers multiple hardware timestamps to the socket error queue for the
same packet, nothing good comes out of that, so we expect there to be
filtering somewhere to avoid that.

The way DSA switches are hooked up is by presenting themselves as a
collection of N MAC interfaces (possibly with hardware timestamping
capabilities of their own) stacked on top of the host port like VLANs,
with their ndo_start_xmit() doing some packet processing and ultimately
calling the ndo_start_xmit() of the tsnep driver.

DSA is supposed to work with any MAC driver as host port as long as it
is fairly well behaved, and as a MAC driver you don't really get to
choose if you support it or not. One of the expectations is that the
host port driver should only provide hardware TX timestamps only if it
is the active TX timestamping layer for the packet. That is one level of
filtering.

DSA will prevent adapter->hwtstamp_config.tx_type from ever being
changed from the default value by blocking driver calls to
SIOCSHWTSTAMP, and that is another level of filtering. See
dev_set_hwtstamp() -> dsa_conduit_hwtstamp_validate() -> ... ->
__dsa_conduit_hwtstamp_validate().

Another case where the packet visits your ndo_start_xmit() but the
timestamping duty is "not for you" is with PHY timestamping. To user
space, it looks the same (for better or for worse), so SKBTX_HW_TSTAMP
is set by the usual place in __sock_tx_timestamp(), and can be found set
during ndo_start_xmit().

I didn't mention this because as opposed to DSA, PHY timestamping needs
explicit MAC driver cooperation, and the tsnep driver does not currently
fulfill the requirements for supporting PHY timestamping - so no user
visible bug exists there.
(1) the control path operations, SIOCSHWTSTAMP and SIOCGHWTSTAMP, are
    always processed by tsnep_ptp_ioctl() and never passed on to
    phy_mii_ioctl() -> phydev->mii_ts->hwtstamp(). So it never gives
    timestamping PHY drivers a chance to set themselves up.
(2) the data path hook is in skb_tx_timestamp(), which tsnep calls from
    tsnep_xmit_frame_ring(). That part is fine, but in the future it may
    result in one of the drivers from drivers/net/phy/ setting
    SKBTX_IN_PROGRESS even when tsnep_xmit_frame_ring() didn't do that.

(1) is something that in the new API based on ndo_hwtstamp_set() changes
radically. After converting to the new API, the core, in dev_set_hwtstamp(),
decides now whether to pass the SIOCSHWTSTAMP call to the MAC driver or
to the PHY driver, it is no longer the MAC driver's choice. So it
becomes more like DSA, you need to comply with a basic set of principles
and then you may support stacked timestamping layers without even
knowing it. It boils down to the same thing, only provide a timestamp
if you're the active layer.

> In Documentation/networking/timestamping.rst section "Hardware
> Timestamping Implementation: Device Drivers" only the check of
> (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) is mentioned.

Yeah, a more complete picture is built later on in the document, in the
section immediately following the one you quoted.

> > Evaluate the proper TX timestamping condition only once on the TX
> > path (in tsnep_netdev_xmit_frame()) and pass it down to
> > tsnep_xmit_frame_ring() and tsnep_tx_activate() through a bool variable.
> 
> What about also storing the TX timestamping condition in TX entry and
> evaluating it in tsnep_tx_poll() instead of checking
> adapter->hwtstamp_config.tx_type again? This way the timestamping
> decision is only done in tsnep_netdev_xmit_frame() and tsnep_tx_poll()
> cannot decide differently e.g. if hardware timestamping was deactivated
> in between.

That would be a lot better indeed. I didn't want to make a clumsy
attempt at that.

> Also this means that SKBTX_IN_PROGRESS is only set but never evaluated
> by tsnep, which should fix this bug AFAIU.

SKBTX_IN_PROGRESS is part of the problem (and in case of gianfar was the
only problem), but tsnep has the additional problem of not evaluating
adapter->hwtstamp_config.tx_type even once, in the TX path. I've explained
above the results I expect.

> > Also evaluate it again in the TX confirmation path, in tsnep_tx_poll(),
> > since I don't know whether TSNEP_DESC_EXTENDED_WRITEBACK_FLAG is a
> > confounding condition and may be set for other reasons than hardware
> > timestamping too.
> 
> Yes, there is also some DMA statistic included besides timestamping so
> it can be set for other reasons too in the future.
> 
> I can take over this patch and test it when I understand more clearly
> what needs to be done.
> 
> Gerhard

It would be great if you could take over this patch. After the net ->
net-next merge I can then submit the ndo_hwtstamp_get()/ndo_hwtstamp_set()
conversion patch for tsnep, the one which initially prompted me to look
into how this driver uses the provided configuration.

