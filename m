Return-Path: <netdev+bounces-110832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4801B92E764
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AD1284189
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 11:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EB8145B38;
	Thu, 11 Jul 2024 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A++KpmG1"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EDB83CA3
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698343; cv=fail; b=m7zi/d5hnknWVpezsBPnkhNmwTcHBnNvrSW88DEN5bpYSccixUhC5lxXFt9n7k89EYQOlbVqPKmHD8N/4vven6vMFJDVeJtW4tYhPN87LmSFsFNwL5iG1riKC6+Cq98FmdLmUOlX1O9ZD5gbYjU9SlgHECL42wsD+MvpoCEw2b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698343; c=relaxed/simple;
	bh=oJ80oAZOKrQMu+2uEvUbBACUksMl9TSbLz+ucrHekBE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=R2c+CTxqXtoeeJeZfSSTMQ38/kmQdF5sPndPZH/9Xm0VJYNKi4bVrmqIUZOEnKBaAWKiX3UxIXLc5Srhrcg2UVDvsY4ajiJaQXerWbR6vztZbkEk1CapEOI+zppew3c4hNl6NZZj+OV3xAaHo0INq0GcL6+YNm0pR78rS9iFD8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=A++KpmG1; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3ySuUpBUq5mwrfMNnq6ZCsDhePkiE3znSQX3aXV8JTaksYQTuQ01uwWT6PGrx3xVuTzZnZR6HXUJGZVtw3ecgiFCi4MKrP96UReKtS02Ob2fonYVwnByZt7RZJrE2hjoqwrFizmgtl07sp3EvYjUoMSH8I8NjDXb+/pJo2nFRXMwkH3L8uVnsvRUlnGEMl07bb/ACwclD9Dj3+KwNDW3yNWe2pcuu8AV97Dr10KvBbxJbmChKcoC/GHF/DEGywuzSKxC+0zNw/4Zfc/w2ZmAhSWCZCtOiKCM9icI/+v3u+OzUtUMUOqRXfY9zc+1UY8qIl0bxJ32FOAe7OySavU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuIxWT2ek3ZQiduiWf1zeCygu+0cHrM7XjgcbQ2elWc=;
 b=TWcnqxYXmcQ2oZk3B4nG7FqXDhEcGS70eCMGm8+5VpjIUO1Mdr1SJucZ+CVmZWqGBdkE2FOPtr+22S6ESxqg8o/CSd+SirgoRkoDBt1/0Na9Pz+U/0/Ka/Gsc8hUr+HOiWKupJBlXnFZikwvOSm9A+xXZ0IKtt+rXpiB+ax+/sE1IOLHovXamAlMgRCUrrHoU6Yp24QQCJ5JORERiDxrk6ddoTtPh+ZbFN4P3ANYLJYr4C/PbCRm5g5S8+xB34aCSkoaVqf+ygbAHsx44xOaNHOl0FrrcbTEgHrqrtw5gUKtl34yIIY6Lv3pVtMb/BlETYuGc66/OJy2L0e6srN0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuIxWT2ek3ZQiduiWf1zeCygu+0cHrM7XjgcbQ2elWc=;
 b=A++KpmG1WFLMkhrUo/8x+qldA1nPnIQlyxkMFnRL0C/fo1Sea2K1sfcpiGJV71TNPsLiUcDpab+Y9VHIFP6F7gcUbCntRjkCyZM9JsVrf8kjGY/kWh9zEia/n0Yuh6uIFw3QxgUaTpP1DqArg995j56k3svO3Y642ivFdwLYX9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DB9PR04MB9555.eurprd04.prod.outlook.com (2603:10a6:10:303::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Thu, 11 Jul 2024 11:45:38 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%4]) with mapi id 15.20.7741.017; Thu, 11 Jul 2024
 11:45:38 +0000
Date: Thu, 11 Jul 2024 14:45:35 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Michal Kubecek <mkubecek@suse.cz>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	netdev@vger.kernel.org
Cc: Wei Fang <wei.fang@nxp.com>
Subject: Netlink handler for ethtool --show-rxfh breaks driver compatibility
Message-ID: <20240711114535.pfrlbih3ehajnpvh@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BE0P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::12) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|DB9PR04MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0d5eb9-1694-4878-8610-08dca19efbe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gpnIjkSvxZC7KIHQk2Bm6noHbMGzZKRnIaK+w9IDWc7b7pR0FBgRLRtljdNr?=
 =?us-ascii?Q?lwIsGbKZOWQk6IkIY7e9mOpttnERGEsnOxMZZEirc7469a9Oaiqo6rIaQBiR?=
 =?us-ascii?Q?bBWso1ZarQOeKGXLVO4B1zvV3uqaD+E53NDtynRPbMgSQEqMsd5HvNnwgXQH?=
 =?us-ascii?Q?wPxuFeJzIU4e38hioKndjXJVio6zI398hQPiobqBFzMsdXO0e0Fm610OPvSj?=
 =?us-ascii?Q?+qcvn/rxwCDuY9owF4Dx37O/hLS/yZnVK5Q9J0aisSLm92drUvIVhRN41LxQ?=
 =?us-ascii?Q?Ekgi1l63j7+4ebEUFJoR7w/lIw4Qi+N5GE17Nn/ATFmbKkjv/qftwGMPoVYm?=
 =?us-ascii?Q?Jx4CBrOVucXhFEg9SuJpckAYTprLq38c4u5UynKEbeSuaDuIUuCy4n0Fq227?=
 =?us-ascii?Q?mcHfEqaQ7Dl9oc3XJ6f1cYFIw8WJXOwMFktQw8O3apbDH9yqsspTMRMYnxMR?=
 =?us-ascii?Q?qdhyFRy/M3epdoNdt0aco5sg78hgzXFAhjoUDv80aQ9gbZYuAaslDy8c8Xka?=
 =?us-ascii?Q?agBOxZdNHJk/DRVlnfNNQMFPaSKDLRmdyngz2F0W5wv+cgYnBDOpE6lzEF6i?=
 =?us-ascii?Q?7DYiR/y58Oc53oP1kdRIr8dhUtReE1jQvo55fQxdtTy44OpLHexM9vdYDt92?=
 =?us-ascii?Q?xNAJRmOt+RkjLvo7edZWOJPIIWlC4ogHESGQN15aNNVCAGIhNcE4kDP18+Qv?=
 =?us-ascii?Q?b7D4jB3Exm8GKQmFiw2Tywb+NdR1xtKL+FNyRlKQW/sAjEKqrxjmaSPa4oIn?=
 =?us-ascii?Q?0I1WOg3+aphdyIL3T57rX4Ev0Wklh30/YmY23dEQDxCg49ts4XtbvFlJuJX/?=
 =?us-ascii?Q?b4ePnMvt3BmpiHy0T3zooVlmf2ZlmjvpaOJ5bL37/s15AkfqyDbvKpvCLupP?=
 =?us-ascii?Q?Xk6CPBcBN3xaCdI8n3Igg+jbasHYbEyfH/NOYl/8WBs+4xsOBcW1vsBaw/Yl?=
 =?us-ascii?Q?r6rsCWaOFWHyCGLtxoMinxMwhiEaDjUveDoRYNEwCC/o3jdUaiaef37e98dz?=
 =?us-ascii?Q?4iuKrPAfCrUXUTCzGWKV4QyYlcQeoVWAWJ3tcq1vathXxLRN7uKJQ8xj0lU0?=
 =?us-ascii?Q?+iDr+xJ3STEmmTXlgAdyqiz2hyOYCESx+H/TOYhnQp3vrTm+Aec8q3xOdkst?=
 =?us-ascii?Q?FlWPOLXlga/98oI0dbtf9zM2yBC6HoT/I+QoBdlOamRhJYLUWD+DqcRzypvQ?=
 =?us-ascii?Q?8aiw8EJz1nSVMDc+TkuhKUzSxYvr9Ph1nI6FsBNnV7ASrs1vwtsCJI7kPxgF?=
 =?us-ascii?Q?d3VmBsPJ568q2xl/wKJ0iXj47ZmQUN7ShPkbHYbLdyBh6uTFI8qtYhcEQU0D?=
 =?us-ascii?Q?QoRsDRqoFKwzIYPykgoKL6ki3M9TYn8RREs/cKIGudb2vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QM9TY1362RSPyeSX+SwZYHzH46PPrcO8AVkpBk/kQvg2kVcBEzXz0OrOpYBQ?=
 =?us-ascii?Q?1KFCOfagRMP2uNyUuZLq6IxwNgOXNLn5wMyKuOQUpzIXr0xyYfCNIHTJ1gzm?=
 =?us-ascii?Q?LJjR+zqtf6FKwYhzjgbt1Dn8wdzzU0JfBd1BCKIqlt77Y2HfXYF6NwyTA+WW?=
 =?us-ascii?Q?Rw+EFacSMwK5WcGjBXlGyiwbw8n04+S571tc/8v5lWKvqAfoWvy+BdDhy35w?=
 =?us-ascii?Q?3+3yi3mIEEi6XG2kW9b3h2mskKcKPEkvCotXc6qVO9PTn9HdznP/00eYu+cF?=
 =?us-ascii?Q?tmdwlDEbkkBOxm0Qm3IFlTZZv4RWS311aHHdUegF43ZljAM4Rgm7Z/F+BYie?=
 =?us-ascii?Q?wr2gJu6c+659utlwL/EjzuC4efaks1PJ1BePepf2kiJ+vvwSpRlE6mSNJPCh?=
 =?us-ascii?Q?D3/4vL4ft5ZEuMWAuSJdzvz28QiUF0RJOzs0rr4hk3rt1aBpOjzcv4bf4NaV?=
 =?us-ascii?Q?r0+Iiepry0pe1GPmRkDYsVnyTGpS49h3tCPlG9y70cXhbWnAsEGvmU4AG5uy?=
 =?us-ascii?Q?mMpbkR9L8AWmGYxOGINfLb+odCyBC9s1e/A5EA72AYL3Z3zLOnm0XQV1GybZ?=
 =?us-ascii?Q?RCYzK29dMGreUgLAD+ZUjLnpY1YfRpYY1Ktntq7R4WJbofBXh5F83dQgNNM/?=
 =?us-ascii?Q?wfZdorU8wJusx2oRAe5AXE/J+ttV1duJSv7CpFa+rjiUkwIV8INAp3Iuufjf?=
 =?us-ascii?Q?wGMGSMUVkuEsLrKVQYqtqwgWuydlonUen8bV2IBSQtL8kzxiKGlmaMFDzaY4?=
 =?us-ascii?Q?xylEz/M0oXuuKMYTSPB8SfASJV2HRjcYo7DT/OO/F7Q5z3WwxG88TTv7RNrV?=
 =?us-ascii?Q?GuQr3KqkBsynGUoREHI5EtCFvS2PegA1miJo8ZTPUJYpTY5sHvVKeMWfDrFU?=
 =?us-ascii?Q?B54VUsBC9sqtrB+H5hW3YMj0O0YPIZQhX+RmghVxm+pXscZENQQ7pv+qKqAY?=
 =?us-ascii?Q?LsdOmd7DvD7tGmjsmtoGBFc0TF6CM4W0xCT3aN6sf/anEsm28OuXooB5iI/a?=
 =?us-ascii?Q?bXEerSQCttNRD+HJ6SshIxqPPBq1/riDi8Dn2opK9Uwv1AyTtoQzyXeA5Y/i?=
 =?us-ascii?Q?bi6xbNZz/yYryrZVACjp+AOsZ3UrqC2zdD49HafnMthMd3nIFZC4xeQeaAEx?=
 =?us-ascii?Q?Rt9b7uPdAzQWUVlvVyJ8sTQzscAZkPcSQENxH2eAYd7VuU7XELUDhsQA7is0?=
 =?us-ascii?Q?2BmjG5mLHFNVR1z1Ej/TT3iqH4rq6cc2fWit5jZfvmcDUrtZim2ZTryahxZF?=
 =?us-ascii?Q?vcqmlZOZKT6hW0fV6pRrKjTeD5X4+eW7deUAqbFRq8fe/CtMmsXWsGkPxFGK?=
 =?us-ascii?Q?Fd6DxS5CTWWFpb0Ydz1sP+nAbywrbsijzX1SxP/5D9o+TpfoVEientF5aVUH?=
 =?us-ascii?Q?IfkhcJo0BjlPE5GNo25nutsJrT4KYaA0mJtIiDcetGzxIcCrnOavKWa1vVT0?=
 =?us-ascii?Q?g4PJCgDJj2Ia4HdEWTazXXqgw3gkTWKQ3Kzi36WURXUXZPqpaX52h9eyzjXw?=
 =?us-ascii?Q?e/RRbXKM5hewvcntq+f03u5swplANyb+sT0lJUiGpv8CCsMXaPyESqJzrAuA?=
 =?us-ascii?Q?yJvTBWq9A0SfKBDAYumnOgoulyv1lVskd7RGh/aeOFb/gsNdf6tDGPZs4t2p?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0d5eb9-1694-4878-8610-08dca19efbe7
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:45:38.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1idwWdAmZrtbnJF+k86va3OXTKtfmb6TUWrso6U+zp01EWIBg/UU7BTGgAVO9bwGP1JKRulT5iTozjENTGaVnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9555

Hi,

Commit ffab99c1f382 ("netlink: add netlink handler for get rss (-x)") in
the ethtool user space binary breaks compatibility with device drivers.

Namely, before the change, ethtool --show-rxfh did not emit a
ETHTOOL_MSG_CHANNELS_GET netlink message or even the ETHTOOL_GCHANNELS
ioctl variant. Now it does, and this effectively forces a new
requirement for drivers to implement ethtool_ops :: get_channels() in
the kernel.

The following drivers implement ethtool_ops :: get_rxfh() but not
ethtool_ops :: get_channels():
- drivers/net/ethernet/microchip/lan743x_ethtool.c
- drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
- drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
- drivers/net/ethernet/marvell/mvneta.c
- drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
- drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
- drivers/net/ethernet/sfc/ef100_ethtool.c
- drivers/net/ethernet/sfc/falcon/ethtool.c
- drivers/net/ethernet/sfc/siena/ethtool.c
- drivers/net/ethernet/sfc/ethtool.c
- drivers/net/ethernet/intel/ixgbevf/ethtool.c

Thus, for them, this is a breaking ABI change which must be addressed.

A demo for the enetc driver.

Before:
  $ ethtool --show-rxfh eno0
  RX flow hash indirection table for eno0 with 2 RX ring(s):
      0:      0     1     0     1     0     1     0     1
      8:      0     1     0     1     0     1     0     1
     16:      0     1     0     1     0     1     0     1
     24:      0     1     0     1     0     1     0     1
     32:      0     1     0     1     0     1     0     1
     40:      0     1     0     1     0     1     0     1
     48:      0     1     0     1     0     1     0     1
     56:      0     1     0     1     0     1     0     1
  RSS hash key:
  0d:1f:cb:76:88:82:dd:ea:70:c9:ef:53:3e:f3:bf:60:5c:79:60:09:32:ff:88:fa:aa:39:63:31:ef:ad:31:e4:ac:57:ec:d2:09:4d:9a:01
  RSS hash function:
      toeplitz: on
      xor: off
      crc32: off

After:
  $ ethtool --show-rxfh eno0
  netlink error: Operation not supported

Sadly, I do not have the time to investigate a possible fix for this
issue, but I am more than happy to test out proposals.

Thanks,
Vladimir

