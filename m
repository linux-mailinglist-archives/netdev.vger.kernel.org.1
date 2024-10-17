Return-Path: <netdev+bounces-136659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E475E9A29B7
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D3E282866
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A941E0B82;
	Thu, 17 Oct 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EVUffOhk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D911E1036;
	Thu, 17 Oct 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183994; cv=fail; b=g/wS37ldv98c5ovtpUapMlRTASFY78cu2H87Uu2ZBFSdu7/X0uGwn65+vugvYJNn5+ig8TdC4Ds8rkRNsVCGDm4h8sI2V3XgX+68ILzUxolsy5GghkeXkw8v5Ss364nslKWETdSGUtgRDiWVTDzW00091ZtvaHB3vuv7H8LwFbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183994; c=relaxed/simple;
	bh=T6Ig11DHJT8EIwQ9E0wmYkCRLCfPS6i3714CZD2uEpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=caz2rimvKLQA0OsBH13/8EKMUb+lB8U4LWOzZOt4Y1cd3aZ7GNH1ZY9xUc2JGfGbKCh3ocjh9rkwDmIvN6pWaCYHWVpEq33TWAl2LKM9s/1ktiUUTwE4s8ACldAiGU8WdNr2fgD22jo18cGkunKyZRAKidj+my8Ko/cl/58HRL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EVUffOhk; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSlF0c0kOc5u6XCydBxur4gJ9N6HN6pqIJ6SRoZWZhR/AZ30PWNPnFN+IrhSc/6X0M+3FXjbMART9UUf21V+ztrxZUt3g7jPX9wXkiQA7VXpF67bP7MG9chcu36d5lVRDCrijTUGRG8dDpFO48w6aLJr9En6sV3/QQetMVTenu0fibMrsrNLAbuv8ESdyfP7GLnbMb6B7BZZwjTbypzYMP+b9dFjwDQ8RxI4WsqzpcpsnhvB+rMo76TH4RuKx+K8/zostTNa5KZVTxz2AcwLWRyEQYPua4YAPRVU1lL0Lftl+szIbIfqtYVgWWRyM5kLwXJT9e+wDDX+rz5Y2AA8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhzlxU/Pro+meJHzcv0up5W96hJe0GH4HG1yRWby8uU=;
 b=biCbxH06Vpht/rSTLQ4UDIcYGmFsQq3DyR4/eAR57LN82X5vn9h6hJ6Dg4NDeE3+/ywVTsDl2ESBc925zZVqq5sHsuvKCsvel3O4rluzMQJbiPahwDL8OCU9s7PYP22/QCyAEi9wOt9zC6s1KbzM/JuU2hkRp1rOo9QxEu8WsTMmjd1pKfYFBF9pbxao+0CJyo/k2OQafi2d8OUCnvJRWyleVwI71JgvEOKrN6zx1+DsZfYu87RNMYFV4LLPHKqawmfqLalMwEjqVs055VAP+Z5cmFuqp8NxM+cH9MaJDcrhWD5OzFFxLHAUv08JLjBcJEheWo1C0wQPFk/qLCQQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhzlxU/Pro+meJHzcv0up5W96hJe0GH4HG1yRWby8uU=;
 b=EVUffOhkYBmTxXsb7EEXkNOoNYO+WkQ7Sl6FB/fkVlCckfWLY3rjZWo3uUDL4AgBnXVgkeggWLvcKlsGdDIQq8MiGzo3U280++bZ+8016WoJRlsjE9n5e1GeOrlKdH702IY+7imQFZXB1eXWJ34AyFchp3OyA6WFmMbZT8Fhv8Z8WCbjOcvV9jR5d7DBU+gktFA/Bjpcj0Z3bXzU0ol9QsVrbJ6VJGSjZg6c/X/iH8oxO7zMh43985fSS3ZdZ2x+SfNFD7dJ4r9DnG4Wkl6nmHCnsrmuKDVBxv7Y5QjRKWHSlBkvGYN/+bI7CtZr6yKv2fHcesoMd7yVs/kjlFZg3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7456.eurprd04.prod.outlook.com (2603:10a6:800:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 16:52:48 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:52:48 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 5/6] net: dsa: allow matchall mirroring rules towards the CPU
Date: Thu, 17 Oct 2024 19:52:14 +0300
Message-ID: <20241017165215.3709000-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
References: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0259.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af06c69-47cb-4df1-18bc-08dceecc215a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N/boNtQjfbpXU/QcfYP7nqosjVGs6DiuFxEx22IqXWK1iAd3sespI+DHrHYe?=
 =?us-ascii?Q?HcqgE97kgOfR6iMBVpWDIxe7pigr8S2GJ81NlQJMnfSm9tt1bWfCy7D2Qu3i?=
 =?us-ascii?Q?m6yOumTsCsIO7jprDm/An3UVzYPnwFjxIq/RNBvD+JlkfL9wBwVos46Cebvx?=
 =?us-ascii?Q?AcDSg/5qxlsWhH7P+a6Tiq+NBWANo+OyyDzkPC7QCXmYGJjUc5wcoXqTxkOi?=
 =?us-ascii?Q?zPyvNgRF5vtDc1ZcoZaUyn50J+4yrXKaBiZFIltMLycJL2yj5ny78u7cCzE5?=
 =?us-ascii?Q?ZGFgf1im1LuEUluaNqy4bqko3+7xHLz6j/iwFpmpH1dPno9KmWGX7uiq1HJI?=
 =?us-ascii?Q?IVB+EM419MKjPrV7fM3gxEVK8bbFrCQnZYTmXHNQ1buGFP9c+4c9gSYvF7gr?=
 =?us-ascii?Q?fS1xSEFXMRbJdJ69fpxIKGXXIa46978mUbvPqCue2gu8XhXyLWW1p13JHjcf?=
 =?us-ascii?Q?68nR9Laj6tvHeVwThjJIId0WDJffLTbCqWwPowcw1Ss5II5d7qZmtQd5gn0Y?=
 =?us-ascii?Q?umL9sEWebBES6ZWR+zOkVASg1yOgujH4SudIXpxcscV1ho3lFOFNsaZnVLG2?=
 =?us-ascii?Q?ppDyavWnPZ4/LFzNiS+amLOqb/+7bFXP6Slv1vUvSlKwWATfbVZe8Ub/qw91?=
 =?us-ascii?Q?OoiRcrwZyhNo5tmak/JDzdfoFwEpQ8V9OFzQcj/pRognnt2B6gM26ks7/tgI?=
 =?us-ascii?Q?lOBoEVIP5BMSZFC1TwfKuOOq3qjwoBXYFzsjuYTsgbFin/E+/rByHfn/Wdav?=
 =?us-ascii?Q?A0a1ohuLbkoIyAH86nrA1ydvucP3Yv4Hrl5S1X5Xry9ZH6xOeqyco7bgk1qe?=
 =?us-ascii?Q?45azl1WJDPGLlkWPRiu4qRGdtEtmHI22Ewe/zb28VjmktPwNUoaE71uXZv8U?=
 =?us-ascii?Q?G9Jvx9kA7n/C52zpB9CIkwLo7Au+zwgZx5Eyb5ffkveOMdE+FK9o9MVcPSvD?=
 =?us-ascii?Q?kLOXB6b0XZYgocut6phc9WjyAOtV8lnPvMRXJ7PaDvYApGMfjz3BPNyCXzZH?=
 =?us-ascii?Q?3NAVhRb9lNzuPgNnrCwB2mzZOncxqi9y/g+YONHq6qwRm/oXFdJN3I+/oU5l?=
 =?us-ascii?Q?R/5rki9GPxf7k1RTCubh7WgjSb2ruiSTuIAS63BpY5BAf2CxaLKTEY1gBnRV?=
 =?us-ascii?Q?H7+XG0V7QAIHd9XWXRfQ24+3p6OPUJQNYCKprEE6MbZRddqA/O8eR0LL7vdu?=
 =?us-ascii?Q?7kY12vhiwxq+IEPkcn2INvkJ3bTkfioRIDzd4zKTXpC/7l3sOkkCbt4g5P55?=
 =?us-ascii?Q?Eeonf7j7rWBbAY97pwypzn+n+URNhNZgdNdlLWFJd9Qe3a8KiMJciGkf7mi4?=
 =?us-ascii?Q?H/jzOPcfBVv6FsteDwpgaxj/TBYcGaZofSgPSaN4kwCf9VZpacWrJvze+Gpb?=
 =?us-ascii?Q?PJHgSeXFcohZNKOH+6/yD1ITEPAJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nRuuVUDwKrqt5geaYuHjE+AyC/qadtwsFStQM1d5xVAsAcloi3+qUYh98cPd?=
 =?us-ascii?Q?3bF2SMZPfxLd/oxgqYwtOITgmS/3vHDoq10rxHboYYkurNNrB0ieCy5ixEML?=
 =?us-ascii?Q?KUBwGZuR5MY+AnFdnXUGfNDrtWOXJh16VQHkQ6qSOH8GMm+SMSKIiy7rrC2V?=
 =?us-ascii?Q?VTqLabBYygvHhe8V4xmPxbHV4+faVaMd/qP6MQV2jRfkiuAsU0Lpnqg8fBgN?=
 =?us-ascii?Q?fSISJKLjFopEIPsYLEVEpNxIN8z2BLhu+pb8ZAAiuWEDcEw5+RRUVzx7KliX?=
 =?us-ascii?Q?X57CXITWaVtubWxS3htKjFUk5U2I/LqIV3EacrOovyp+s8HJZUlkCO+LBMn/?=
 =?us-ascii?Q?v3QCgv7AFnvuDdB1KlWrPym57Jzqat4jVAbwFPErGX0RHcvObnrXENCKoXHb?=
 =?us-ascii?Q?JKM0FcOgnel3VDYyeiimpCcZyzQ/EJvqKwrUeutRlQYrJgXIP0pKxc7vdC38?=
 =?us-ascii?Q?SOUkT1D8AFB4s5jqJQdQQ4WmB+RLy+6T5X2laWXvYUqj7IidQPF83CtYg/Yd?=
 =?us-ascii?Q?dEHibBA7E9QtrKH018slFsg03dQ7vF+PKHhnmKN9S1uusdCnJhg/4i7/0ntf?=
 =?us-ascii?Q?fzwqVfP8sfJQRpGbL7fzRucRgTLLwu47EXYlHqh4k0en3+f5CM8/oUU3bPLl?=
 =?us-ascii?Q?TWOYBW0sSqhA1og1q6kuDOv9hgwMsTahyOi0abYwJwETAeQVV23YBAGPd07+?=
 =?us-ascii?Q?fDVpHvqMPdFFz0RPeXSFgc8gtiFukDZZhmVvvC5naMjP1ysZvYCpZcJ07K5d?=
 =?us-ascii?Q?KqVrRXP+FHRcAgzKsWwphK7RZtvz4JqeEI6XFN9sX19FqrR5bGGLvLkHt+jY?=
 =?us-ascii?Q?wC5pb33Mjxm18jLLXg2OASQeWzNySKqi9k5/VKLw5OKA106LHKWVyvVeqLNn?=
 =?us-ascii?Q?nBQeAMYwf6eB/QSkzzsAHuGkQ7GJi5VuuLtjFp79drVIC6aYXpFXpJUxilQC?=
 =?us-ascii?Q?dGB8+R5XaxZHHR9TIpnAsab9Ux4KuvEKFcj6pYlsSRM2m30jNf+YqqM9QrNf?=
 =?us-ascii?Q?yEjjHZfDV0s4GTagW1czuqW4CsGWhU5/I88zwL8q33BgQ0nXsE1GHAh4K8WG?=
 =?us-ascii?Q?6zo0l3InIvcnRJ4dGsir3MfAkiUr/uE59Lo5I4KoJOJbDCL9nOETreE2jCDI?=
 =?us-ascii?Q?OASXw55jVpvzxRNL6UdHMznU/Cl9FG845bzOsWE850dU3yeKUfmkPtTj+U7n?=
 =?us-ascii?Q?pfrTYN7m1PXJga+HfS5myoXz+E83RufyM7vR1B/yyrewwVIvq+AHXJ2ltalf?=
 =?us-ascii?Q?uUSVHh5p65Yis8yB4gyBGZfZ5yJpVLewYcOushAJHJx7+0PO1uvQALsmeDhO?=
 =?us-ascii?Q?NRNOd5G0Bl9hJkzTKgDh5xb4+UKn+IXKLiIK0Gy9toboGaBTHYV407R052N8?=
 =?us-ascii?Q?/zQ12UABWH0Ku5GQAJAzdPtLBWL8bXKlc7g6oM0cBZe0Y24aMBb64MMbgQfE?=
 =?us-ascii?Q?DCxsThcvEIaSp3V8yqBnxoIPQerme7zVFHRoAjk0bLmS51YsAhlBd0kLcA25?=
 =?us-ascii?Q?C84WT0Vn5vEd4HXNXJDizoi/nSHrJUOlmMjF1iykg2nFovMee4t1+43IBb0Q?=
 =?us-ascii?Q?xT1zVEF8vOIAK2AwkbRk59EyinZRbBul1NMZQ/ZiKO1TWgACSNjrC4TfFp1q?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af06c69-47cb-4df1-18bc-08dceecc215a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:52:48.1388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gi4L28zqBaMYpAsaRbPzybIC6MnMHzARnPXijGzIsINU6IlBXx1Bz5MrFgryhhpNZosrTIres5cDef6APo0SGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7456

If the CPU bandwidth capacity permits, it may be useful to mirror the
entire ingress of a user port to software.

This is in fact possible to express even if there is no net_device
representation for the CPU port. In fact, that approach was already
exhausted and that representation wouldn't have even helped [1].

The idea behind implementing this is that currently, we refuse to
offload any mirroring towards a non-DSA target net_device. But if we
acknowledge the fact that to reach any foreign net_device, the switch
must send the packet to the CPU anyway, then we can simply offload just
that part, and let the software do the rest. There is only one condition
we need to uphold: the filter needs to be present in the software data
path as well (no skip_sw).

There are 2 actions to consider: FLOW_ACTION_MIRRED (redirect to egress
of target interface) and FLOW_ACTION_MIRRED_INGRESS (redirect to ingress
of target interface). We don't have the ability/API to offload
FLOW_ACTION_MIRRED_INGRESS when the target port is also a DSA user port,
but we could also permit that through mirred to the CPU + software.

Example:

$ ip link add dummy0 type dummy; ip link set dummy0 up
$ tc qdisc add dev swp0 clsact
$ tc filter add dev swp0 ingress matchall action mirred ingress mirror dev dummy0

Any DSA driver with a ds->ops->port_mirror_add() implementation can now
make use of this with no additional change.

[1] https://lore.kernel.org/netdev/20191002233750.13566-1-olteanv@gmail.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: allow mirroring to the ingress of another DSA user port
        (using software)

 net/dsa/user.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 2fead3a4fa84..8be2e39c14e3 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1365,7 +1365,7 @@ dsa_user_mall_tc_entry_find(struct net_device *dev, unsigned long cookie)
 static int
 dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 				 struct tc_cls_matchall_offload *cls,
-				 bool ingress)
+				 bool ingress, bool ingress_target)
 {
 	struct netlink_ext_ack *extack = cls->common.extack;
 	struct dsa_port *dp = dsa_user_to_port(dev);
@@ -1397,10 +1397,30 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	if (!act->dev)
 		return -EINVAL;
 
-	if (!dsa_user_dev_check(act->dev))
-		return -EOPNOTSUPP;
-
-	to_dp = dsa_user_to_port(act->dev);
+	if (dsa_user_dev_check(act->dev)) {
+		if (ingress_target) {
+			/* We can only fulfill this using software assist */
+			if (cls->skip_sw) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Can only mirred to ingress of DSA user port if filter also runs in software");
+				return -EOPNOTSUPP;
+			}
+			to_dp = dp->cpu_dp;
+		} else {
+			to_dp = dsa_user_to_port(act->dev);
+		}
+	} else {
+		/* Handle mirroring to foreign target ports as a mirror towards
+		 * the CPU. The software tc rule will take the packets from
+		 * there.
+		 */
+		if (cls->skip_sw) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Can only mirred to CPU if filter also runs in software");
+			return -EOPNOTSUPP;
+		}
+		to_dp = dp->cpu_dp;
+	}
 
 	if (dp->ds != to_dp->ds) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -1504,7 +1524,11 @@ static int dsa_user_add_cls_matchall(struct net_device *dev,
 
 	switch (action->entries[0].id) {
 	case FLOW_ACTION_MIRRED:
-		return dsa_user_add_cls_matchall_mirred(dev, cls, ingress);
+		return dsa_user_add_cls_matchall_mirred(dev, cls, ingress,
+							false);
+	case FLOW_ACTION_MIRRED_INGRESS:
+		return dsa_user_add_cls_matchall_mirred(dev, cls, ingress,
+							true);
 	case FLOW_ACTION_POLICE:
 		return dsa_user_add_cls_matchall_police(dev, cls, ingress);
 	default:
-- 
2.43.0


