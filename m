Return-Path: <netdev+bounces-151794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D219F0EAE
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F3228216F
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF221E22EF;
	Fri, 13 Dec 2024 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tw+nyDPN"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF321E2306
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098962; cv=fail; b=t6Wv5QLxmfoTByTrUCFch/CVcx4KSKNiyMfUfbIQBqQunX9Bh9MX6g/4qB++slDf+hc8qwGSel4/LsyZxb5j9uT0tX/UdKj+lN65aMeQkUsiIkyM819Tu/BP+1nB8vRHg3p4ZQtn4+x1tRWk3UnRtmO9ycAy9GA4K0kyLe6FqBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098962; c=relaxed/simple;
	bh=jYwJBYsGYT5FmRpEVBhrbWLEZyY0x98Gw4s8jQVcpxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oS19fW3lT3kluESC3VAwk2XvmPlmaQR3eLEyGjrDjtO4uI3IpfBsm/2FmKEQWwqmXLjh9chiuRa2Z+D+D1ppVF8Wy56/lOOUPiYaDkPq/bDdTg5nHArPdtlZAuqkqErJQ3sm0CTUqwWznN8ybxyvxsjBG9940VhNSRrSQQxpZpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tw+nyDPN; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TglOxqokyWwC76Hm7rMn4ZxHM39ltPk7hWwYAahHVnq7ai0dXKMYCBdA0IavXOoG67eBLJpMQSlFSeHKsTmTI/yJelzSvj3dhOmO9OMcNiUtSU0qBj3JV7PuR7rCTfiSdgDNFQKT4An/yq0UEGORydodzXVEThkkAZZc2vKaA1ck9SvMpEi/PciJ0g+li8oBiyADAp7pROd65sQUM/yvQyp7mG19znB3doDMCHhxsdT5Q3qee1UL1n4Vpx1d+sF5bL9qK0sDUUScJtbBeGNPRl6Ls51jl6n1Cx6c5Fo/HmrJcY83kvctsQd0BWNQK7gcFms3hSjuX8vS25K74p6JPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI6HnD1jMiigyngiX+wUxmrW2+5JaGt/Tob+BHC49Ic=;
 b=zBsehEjlzi2Mn7HKNfp7GCTrjxvwQMVj2ghifCdC+qniUkMOopMa8hpHw5Ja3NUzShk2aZfmlz4BBAvzhhE/JexhpxwJ7uJ7fu5XY6QHsvGrlRwv7aqra0pw/X/0mCeYt3aj2KiwhjqI2HmKHGe9eOHQWmtoUQBPsVHeZm5tfl6VRovBVgtDwWK9VYHIhjrzjS/df3DpNsBjlDWvR1ad3TrDrlzC1oQnfaaaKOkA1rIyr6qxnq10lGnTqHj5qVE0qy3VoXbYrIGNGuExIMXoCS5bGtI6O+3xTYYtXiF1ppcIkBRv1uPapKkgsaZd0/Yjz8frsK9lw0DmimiddprF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI6HnD1jMiigyngiX+wUxmrW2+5JaGt/Tob+BHC49Ic=;
 b=Tw+nyDPNVLcH63KiRXd8yCX0JrLJ6E1CKxPKGfxscNTt7sDi/f2p5mMZNkMwLeAhJy7138ntIflUammGyG88mCM8GOXV6QZe+uFMQE3aC97KbQQtcKmtJCcP6JM52W61eJyr6iGHEVFoQzpHbzffIMF3/lXdtmaf7kdSQ64KurSWmaC/jFcbbFGU7uwEppUbJKG9OuubpvnnNkl0nW7Tw9mJ1hrX8mgxonlM0IjShfB6WLE//ocP8GE3KrAjphTZIRcU+NUyD1QL+mGt608ncBmJBMr2l75Z9HY8yPeyjNYcdYAx3rvIv0aMhL3n2WfBfQWlI5H/gPLTYDotxNIN9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8780.eurprd04.prod.outlook.com (2603:10a6:20b:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 14:09:14 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:09:14 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next 1/4] net: ethtool: ts: add separate counter for unconfirmed one-step TX timestamps
Date: Fri, 13 Dec 2024 16:08:49 +0200
Message-ID: <20241213140852.1254063-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213140852.1254063-1-vladimir.oltean@nxp.com>
References: <20241213140852.1254063-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df670a9-276e-437b-3139-08dd1b7fb960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+5rsL9hOOM+RjES+FU8EcXwwYCGxExEArvImGVBaTX+0t52nZ7fK44APsXS1?=
 =?us-ascii?Q?+AFKTIQRfAoyuuNEczgEhTs2yQ9SfxelpYcpKMYhrg+4WPE7g/UaioSL5jaW?=
 =?us-ascii?Q?4Vk5hBbMDrokL4bNf274Rr94W7w5IDa8qC/kkRDT0JET+5BWBbx33Ec03vrj?=
 =?us-ascii?Q?iEL7wZc8Qu9mrqcl3+UunpfIdITc1L6CcHpGcPBz0AjTZsSeVmngMAUZM7S1?=
 =?us-ascii?Q?YZgPhyLmHUybZraG+z2OpDDTj7AAJCdV4TzzHbaKQ5FcGCRN3FW0990GIqtx?=
 =?us-ascii?Q?Z+mLRBoG+Oe+Iymj/k9bTtO5onsChP51zekcTBBQxbCDnuLpb6RnMU/rz8Rl?=
 =?us-ascii?Q?waQKAlHShaIRum3ri4101ENtRQlgAlLhol/Yi3R3uFHpekESlQrUijUTFrRc?=
 =?us-ascii?Q?+vim80ckZu9eXCLjJuRaWBSNiOgDmni6L9aODJu74hmnvQyBfD/8zygdN50u?=
 =?us-ascii?Q?W9psz8SKtJdVvuPUfjUUKFWcYdASF59ittM0Xt3rNyzUK8owiGQffJh7GkkM?=
 =?us-ascii?Q?J7CMBg7JSIZHieDBxsr3k8V3GgUmUgncWGAslyYBo0SPuw2hXz+s+BWgnDhu?=
 =?us-ascii?Q?7s+SiOTi/Bc4/Mp5k55ch06uH4iORpuO/siF8EwLyq8ZmyqmGO203k3g4DSD?=
 =?us-ascii?Q?9ow3kY3LVcvqRCXtj9Awhp9bG+85yHew/Vueggx6tHJTtkvcgV+qto2pGFAO?=
 =?us-ascii?Q?5cjcIeOI260SqmM1dTBmmRMag9eNhQJWPiAHWwFpqzPtARM/ZcwBy4rQy/ui?=
 =?us-ascii?Q?gz3M7JmnHs+194HK5tnL3OxBsdDunN1R7kfUVPNoARZV66nGXV+GLvdZL9G5?=
 =?us-ascii?Q?psfNAkKOiccrgJ3mdpfU5HnJPzGzG0W38QGYIyZUOvtIMFbm55fsefiOpeHj?=
 =?us-ascii?Q?DjSCTuIj7r0B/yeKp6j6TS0pUziVo3o8kzLkK1WHtjg0XLZfXvNK7MGuHi0d?=
 =?us-ascii?Q?8vFa9jFKr+B52kPT1256irDWdEZrC73DuMDcsgviAFGRFTrAwRui7CG9IlEq?=
 =?us-ascii?Q?diA9j4eYTuMI8K9Vv5/KFJIF3rtr68Gjii3BKrehYAWodoAFZe7Y64GneSRa?=
 =?us-ascii?Q?pJBvRv5IGdBHcNRXl7jluhUFp8Y0boWUfiftG4pPlWS8FxzECOLSOHAXXg2m?=
 =?us-ascii?Q?Y87Dy/F0SVUc+mRGHXRa/VAacgyqSMGqR8/B+pu5rTT6eTRj2q5JJ3Kh7ASU?=
 =?us-ascii?Q?b4kFhEMrFzanWYCgz0fk8L4E3rRKE88vg179xEgFHTGgkvmgaxFYI8jwj9vr?=
 =?us-ascii?Q?d+YOr8h100phig9CgiimWSnUwCDBfOoJ7fYoLaSHaLfu9QXZt2bETOBn5K/M?=
 =?us-ascii?Q?1Uj9xmDTgmVFaZzg6vjpxHrtlqbCAxKhxkJNL4QhS3G15NNUc9eJNx83UdPk?=
 =?us-ascii?Q?mTLu707KB+ZseLlJmhiC0dAVh99bqYToy76Z/4n6WhdEQvkfeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ptuXJxnt2A7e8UrvqBFgBfy+JeHnJuyM3idRDIWJnV8UXpoz3hGy87BQmU6K?=
 =?us-ascii?Q?bUpi9KY8D3zC4UuYcGj1TnByNveMV0vYN3BhqaRMQo4I1dZnCKBdS+7Nlm4M?=
 =?us-ascii?Q?dcvkvthcNrd+bXv8uHhLWhDdk/N42o/hE19ORRyECAjwzARZVNCe3PsQB8F2?=
 =?us-ascii?Q?eh2i+Eoq+AIhd/e2mt1NCLgLTkMQkQ0shRA0S0tHvqGl2B+0k5my2yjZPyOb?=
 =?us-ascii?Q?7sohde5BYkI/3Q2hGWHjQUN+Q+6Ok9GrCwyCs0N/Hhj0ftfWd2GQjtsZfrXt?=
 =?us-ascii?Q?ErihGIFIu0TcKX41oH+pZKn9Pi7t89opJpkjFssef7u/Un9FRHLJxy21lE0Y?=
 =?us-ascii?Q?pMRVE97cZpp/LW9hbu64kIHQBHx43lvlYU6mXR6j+6qDoXAoCLxtzI4/UYyv?=
 =?us-ascii?Q?Kn5fd9LuqWlNxXZ2WFEDmx7GBsXpvJHYBZ+PAVtfGznawtl8sJqDQ7A7SAkc?=
 =?us-ascii?Q?+7Ia7BxNLAObXx5dlgG1NxwWlOXur0Vxue6fVS9QzTmfSvgHLHeb5eNX798p?=
 =?us-ascii?Q?X47frsioMr6YKZ+bCx8y2vhJchZ2yG8Ctfsat0T77F251C7GmWwZIck63n5O?=
 =?us-ascii?Q?FxKgmy7qgOpWFbeb5qonigMV+Rmqz1Wa7h6vq/turqujEjza9GNNmN8QBSRR?=
 =?us-ascii?Q?cNAdJtrHxymlQt3DT6pT1hFpxT5T/Rbg5JBgdZGysEIPzYDW7pvUznTE/Wvr?=
 =?us-ascii?Q?Jr4qyjOFbUigK8Fi8SH/VPBubXm2YRqDcdVcSwRXtdYNGzZTjdL5+IbLR2ej?=
 =?us-ascii?Q?cMFvSL6EMnZWErjeJHXKf+8T5sUUHOkRN+qpn/eWAWv7UjRCy2fUh99V/z95?=
 =?us-ascii?Q?PUgvv+6UPZVNfeQltp8KBaYasdcgmj1W6DYStN4uLQhtLN+trpYOKQqD5/pK?=
 =?us-ascii?Q?T0jcmgoG7nfTh7XvmaQ83AarTeBpk5qdBVcly1PgxVJbcgZTUnkUNL+SrSOk?=
 =?us-ascii?Q?Y12QSGDNF2saA3CWCAtzNHemZNGNO80eEsRpaU4XZhu1gu6cWA/08I6tJP1m?=
 =?us-ascii?Q?sKcTdjNPeXyTrf6NqLI2sJItVh/Gkh4XXzMkGGR+MBswWJj1UhHuCOwkv9gl?=
 =?us-ascii?Q?kloiFzDs2+6a9pRHEQX+3m9kqBpgLX8wiZj2UfcrxZEDO0st3pG2aPB7oBkQ?=
 =?us-ascii?Q?XtYg+J+bQUYIxbTDNMIL8GiThJt20Nf58C1CQXkDzpvTPcZz+ocMahrfnq3g?=
 =?us-ascii?Q?2PVOL8AtxOhNy11lBmeKNvKE59XXR9bMVUU2s3zAcv4UimJwg9p6WSdZ65KW?=
 =?us-ascii?Q?njHYlqVz6A73Ga5EVkmYDC/zWOTgoq93yby7kXJPZiPXTu/7W2v8qfN0WPZs?=
 =?us-ascii?Q?nl4oHpL6cs+RZ1d44luhSQ9lbFlsZWtvzuii6R5H3s7R03Xyf/fv+YekiHap?=
 =?us-ascii?Q?dtjZsDMuwNJQHDWMCb9cZ+GUlpT31tnOMUMeBMNq2OR7Py/O2/AbonY9iBca?=
 =?us-ascii?Q?ARvz6Pi7kajliGJuKEQax+UxcUnNw6RkbPefI8/0qc7jiGPCalZw98i/ZpK8?=
 =?us-ascii?Q?DeqeU4WC38Lt1BRQZC7EDj/rd851E17en8c9egy/tfnttWCSoPPepdhjDOxT?=
 =?us-ascii?Q?zZmNm2RAHptQitK5XkfQoZeMlWMebl5/0wsQV9XGzwOd2PNphzKct5iCTGVL?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df670a9-276e-437b-3139-08dd1b7fb960
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:09:14.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSrgOB+PWEcM2vRX+1ySU+T/LbyBf+5xNd5zMXCImQJRTNT7Gne0HdOHLv9ofXAOuT/byC2Xx6F2bL/ZlvuWfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8780

For packets with two-step timestamp requests, the hardware timestamp
comes back to the driver through a confirmation mechanism of sorts,
which allows the driver to confidently bump the successful "pkts"
counter.

For one-step PTP, the NIC is supposed to autonomously insert its
hardware TX timestamp in the packet headers while simultaneously
transmitting it. There may be a confirmation that this was done
successfully, or there may not.

None of the current drivers which implement ethtool_ops :: get_ts_stats()
also support HWTSTAMP_TX_ONESTEP_SYNC or HWTSTAMP_TX_ONESTEP_SYNC, so it
is a bit unclear which model to follow. But there are NICs, such as DSA,
where there is no transmit confirmation at all. Here, it would be wrong /
misleading to increment the successful "pkts" counter, because one-step
PTP packets can be dropped on TX just like any other packets.

So introduce a special counter which signifies "yes, an attempt was made,
but we don't know whether it also exited the port or not". I expect that
for one-step PTP packets where a confirmation is available, the "pkts"
counter would be bumped.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 Documentation/netlink/specs/ethtool.yaml       |  3 +++
 Documentation/networking/ethtool-netlink.rst   | 16 +++++++++++-----
 include/linux/ethtool.h                        |  7 +++++++
 include/uapi/linux/ethtool_netlink_generated.h |  1 +
 net/ethtool/tsinfo.c                           |  2 ++
 5 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index c7634e957d9c..977cf0153dc5 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -836,6 +836,9 @@ attribute-sets:
       -
         name: tx-err
         type: uint
+      -
+        name: tx-onestep-pkts-unconfirmed
+        type: uint
   -
     name: tsinfo
     attr-cnt-name: __ethtool-a-tsinfo-cnt
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index b25926071ece..8becd2b3a744 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1266,11 +1266,17 @@ would be empty (no bit set).
 
 Additional hardware timestamping statistics response contents:
 
-  =====================================  ======  ===================================
-  ``ETHTOOL_A_TS_STAT_TX_PKTS``          uint    Packets with Tx HW timestamps
-  ``ETHTOOL_A_TS_STAT_TX_LOST``          uint    Tx HW timestamp not arrived count
-  ``ETHTOOL_A_TS_STAT_TX_ERR``           uint    HW error request Tx timestamp count
-  =====================================  ======  ===================================
+  ==================================================  ======  =====================
+  ``ETHTOOL_A_TS_STAT_TX_PKTS``                       uint    Packets with Tx
+                                                              HW timestamps
+  ``ETHTOOL_A_TS_STAT_TX_LOST``                       uint    Tx HW timestamp
+                                                              not arrived count
+  ``ETHTOOL_A_TS_STAT_TX_ERR``                        uint    HW error request
+                                                              Tx timestamp count
+  ``ETHTOOL_A_TS_STAT_TX_ONESTEP_PKTS_UNCONFIRMED``   uint    Packets with one-step
+                                                              HW TX timestamps with
+                                                              unconfirmed delivery
+  ==================================================  ======  =====================
 
 CABLE_TEST
 ==========
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index e217c6321ed0..bbcd2861d74b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -529,6 +529,12 @@ struct ethtool_rmon_stats {
 /**
  * struct ethtool_ts_stats - HW timestamping statistics
  * @pkts: Number of packets successfully timestamped by the hardware.
+ * @onestep_pkts_unconfirmed: Number of PTP packets with one-step TX
+ *			      timestamping that were sent, but for which the
+ *			      device offers no confirmation whether they made
+ *			      it onto the wire and the timestamp was inserted
+ *			      in the originTimestamp or correctionField, or
+ *			      not.
  * @lost: Number of hardware timestamping requests where the timestamping
  *	information from the hardware never arrived for submission with
  *	the skb.
@@ -541,6 +547,7 @@ struct ethtool_rmon_stats {
 struct ethtool_ts_stats {
 	struct_group(tx_stats,
 		u64 pkts;
+		u64 onestep_pkts_unconfirmed;
 		u64 lost;
 		u64 err;
 	);
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index b58f352fe4f2..9a781265af98 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -380,6 +380,7 @@ enum {
 	ETHTOOL_A_TS_STAT_TX_PKTS,
 	ETHTOOL_A_TS_STAT_TX_LOST,
 	ETHTOOL_A_TS_STAT_TX_ERR,
+	ETHTOOL_A_TS_STAT_TX_ONESTEP_PKTS_UNCONFIRMED,
 
 	__ETHTOOL_A_TS_STAT_CNT,
 	ETHTOOL_A_TS_STAT_MAX = (__ETHTOOL_A_TS_STAT_CNT - 1)
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 03d12d6f79ca..fe1880164a1d 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -116,6 +116,8 @@ static int tsinfo_put_stats(struct sk_buff *skb,
 
 	if (tsinfo_put_stat(skb, stats->tx_stats.pkts,
 			    ETHTOOL_A_TS_STAT_TX_PKTS) ||
+	    tsinfo_put_stat(skb, stats->tx_stats.onestep_pkts_unconfirmed,
+			    ETHTOOL_A_TS_STAT_TX_ONESTEP_PKTS_UNCONFIRMED) ||
 	    tsinfo_put_stat(skb, stats->tx_stats.lost,
 			    ETHTOOL_A_TS_STAT_TX_LOST) ||
 	    tsinfo_put_stat(skb, stats->tx_stats.err,
-- 
2.43.0


