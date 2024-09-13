Return-Path: <netdev+bounces-128231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51903978A0F
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 22:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD2B1C20FBD
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08543149C4A;
	Fri, 13 Sep 2024 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GALKLioD"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A434CD8;
	Fri, 13 Sep 2024 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259786; cv=fail; b=g3W7K4MQU3qsXc0qq/czd9oS8ccQ7pyxaoKFrhW5xp2iP0bZCjCcYB0F/7MFgM4FrAkGyFNcn8BemTPYrjYc+ctJEcXRdIBoBI7NT742hy822Xnx1BJ5dLnOAmh3W7BVgWiq5MyhUl6SD6uXx24SgOStiJE82q1SBqYHjTd4JN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259786; c=relaxed/simple;
	bh=vei3TeN59cYpuMge5e2pIH64RU1J1tjtPZ4/EkVLh/s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JNsKjkBrS/STny1vJjMj8+kBFHCak5SQBdpkoHN5mzF+3li6KYQXeYCe64GNjEMxspauB1PHe/gOR1os+R1Fzob+Br+q+rvDnQJlR6hKKI1viTwrRj8wkho53JYOr1ZCM590GHG8Y6MO0mPI8exPSZDlUQmyIH5u3iXO9Kid7IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GALKLioD; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VANyGhJ7ZTsQivajj4fYHe7sTv4nG4lyTuGCQdM1FqiJMbd40cSgSNirsG37AH02mrb6Oniwos8Bvhy+w0iSsNbrFkOq2n6k8BgIY1ENuVzsyxjriD/PA7AiHvPntHhZ/+2TguTX+8HKO4LlhLrSXlRuIWPVvLijpMpzJ2LFaArinD9U62K19+EbhmrX6E+W6w9rh968fOGHEigQqpPmFPCr2c5p6DpSN3oTMZU7l0I3AQhPx2Q13SbLKZ21Cf4jSKucXdmRAdQowU5FsXpXyHyQ4p0Sno7Y4SWmxfxs+9n/jmfNcH4n+3Hs+ISA5p9C3AMjW87ucZjI3GKTWeeXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tb3YY66fp1hv7U8JumWMB5DmfjugNsrwqltbzz7763A=;
 b=BsYCcIc8oqowFohLYfNhwwuHgX3QETFQtJyBg1ePp88CXTtePmOUzNAF0dULh/v8mmUF2e2t2bK8udMVdjIS9qd/AHcfkn8dKIgyo55GLVfiXjDjQIm9jJMYZVteDN8kzSOKysYHZ0N+8EVbMYHfZfszzBtLBVleqJ4+96DYmn/mM/fH6RsymAIg/Wzw4ZbSULb1LzPHxVv+IkOGBdzmUCvB1NXgdo5ztxqf0i2cyRaS7EPYcPvmW9/84eZd14ZiRULwkERTGIhxLbxrarbp4Px2uZJkVxq9vGmot2t5vHuSI+RzWk6pVh9lL54xmwOLl9TzmDET/y//OqrDz6q+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb3YY66fp1hv7U8JumWMB5DmfjugNsrwqltbzz7763A=;
 b=GALKLioDcwRoRyY4AGdp+uiJs7oGR1OeBoWOflrj6lHwHrjC7+BpXeotPMN+HGlN4yvX49QF7Qf2Q6UX93uJYtWyd96CuGUFkB+EKrk4hgH3ndwHzmMX+Pb5k+5Ghk+C1//0x1OdgIoEUdqilY5pjsrqMdv01Yj9IfOU/Je/4yqzDfrVPGNy9H/7tK5CnaJ7DdTB7+dgvJcENZxGaBVovA/uFnzQKxXbgO9CdOA7EWEGlxZB6tegs0Dktjd7JBKgqw6+cwXYjHYViwrT1x/JvmpYTrtaNzO1lbbqg5NXF+QKK29Q4f6SkDBIQVkE4fs3sG+ZknugWpECkKVS0znqJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB9818.eurprd04.prod.outlook.com (2603:10a6:10:4ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 13 Sep
 2024 20:36:22 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 20:36:21 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: improve shutdown sequence
Date: Fri, 13 Sep 2024 23:35:49 +0300
Message-Id: <20240913203549.3081071-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::30) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d139d5-a41a-4abb-4486-08dcd433ba7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I3iJ+BLa45Uqpxmqf0z5JxFg0eP+nlE9XAZceRirUvtwuI++KVdnDiDr34xz?=
 =?us-ascii?Q?QB0hdMreBMpQR2mbgHsfA6dQbbgLV956qXah6ixnwe+qCj+yg9hpd46twZ7B?=
 =?us-ascii?Q?9klB04oLX2NXyGGlbtCGraqqXAPY2UQaEUNQA8MvOfufbJ9NXeQwksGHCRyP?=
 =?us-ascii?Q?Vefs7WOqwnP0+EbyecwbWTt1xFwRNDa7C+HbXQrCSMwsOpY1sa4UBm/YJMjS?=
 =?us-ascii?Q?9svPKoadlmQTIIzy5hR3wQmu6ll3K7E3aX/7s+kQxuIVvBAY7bg4lHkyt2Qc?=
 =?us-ascii?Q?EiENS/Z1aLSud9V6SpgyUrxp+ht5LdZglSUqUUMZ3trvumFHhSr7TmO5fMGH?=
 =?us-ascii?Q?YDzQBT4Z5NAB7KpCttnn3zfhX5xWoTl2M0fj7kbAssC6q18loXC9YhOIQyVB?=
 =?us-ascii?Q?GFrIs0xzY9ahPL20pufsQa7Rch2+c0Q4YRyp4ub2jg4QA0ugeFumyUzNH9Yw?=
 =?us-ascii?Q?lTQgnOJAJHdM79fcVw/hALHkyU1b2C8pj139ozJ0Z6dCHXAwBb+HP7clmdwT?=
 =?us-ascii?Q?cRFBGK8K0AzOpe5WfGKXSBR5NwhM4CfNpB5f40T9XKFnrLu8o8OZycmNg76z?=
 =?us-ascii?Q?WWP4lgK+Cl/sNvOqZD8EVDoRTHyk1pNMDAQ3swFfGIEdfGRfGCdpdox24Det?=
 =?us-ascii?Q?4e3w8fPbRqfTeHvCkvKNY11OSG23O+EhcLh/3gppUTKdVIUzcqJu8KUznYZy?=
 =?us-ascii?Q?ayAebhY/L21Afx5eEuxFpPOz31XRnQ2FBAjoWbO+qvrpQIfbjdlDbwinpFuG?=
 =?us-ascii?Q?MzhCDuuFEByYRU6Bc7IBQ6XAmVIVyOa3oFvqBIOsJsEVVJHAip4T8wCcBEuV?=
 =?us-ascii?Q?iVKsn2IusdazzLTbi7uZGlg+3eVoBJ7Ng3IDaXEZS/1Jq/SgEqJWWSibYAeb?=
 =?us-ascii?Q?zszSG4KDgbCN4RVbObzglNcnNTqbVAdZ3vDj4O7TX8D2cViu3K9GtXgrZkXv?=
 =?us-ascii?Q?CJzytmPnhBeqs5oUxdhW87syOqqxYc7yPVvLKJ1YFz0meI+bRfZ2lQG3mBcE?=
 =?us-ascii?Q?7OfkArRQk+0NEKvUpMMAyCewb//meqJoU60jZklFttvotJrFmcwI9anveIe9?=
 =?us-ascii?Q?Ixs5W9vew2NS3ZCG4Yz1IuNANdnULVNl4dYPrbK3FWBgVwm5NvagQl1hrSnD?=
 =?us-ascii?Q?TcJ1BYDp6lVvH0rSGvVaeTM7ZbMz8FwAXYhOwJjVi5KIuSO8MGJUvC84B/if?=
 =?us-ascii?Q?FS8sCCwWjc0FQ8q0+DPF6ZLUzfTXwCbGPr2n/P12MzbsH3wOjbX9pRcRBKIE?=
 =?us-ascii?Q?8ozV1EGYbRcoHLOsVhSs0G+hGx1evUY5sla5RqQWYu77Ke4olzBw5CHd8Qm+?=
 =?us-ascii?Q?DuhiVS8WP6fIsTXlpQcluoIjnWmMspI4yTu1aQ4rn62tum4WODKSQQq/17/2?=
 =?us-ascii?Q?UPwQgyRnj6F/ZzaBcmxJBnWINm9myjtKpDUwv/eQrjq/745KxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sa9G4QqN70C3ZDqABE13oOMKv1JIb/k5fYrH7fDtcUJ+fWvQKq8q/LVx2JTF?=
 =?us-ascii?Q?h9WNvSk1/qR3KaQMVhCZyZ67LAstIcx7UFWSo1IP/2eLbtzdDS22TWFLMmhF?=
 =?us-ascii?Q?0W/FxiY92Q9ZQnbdSyY5HdovXr/HIIrOSLy5ZfIceIFpJgATDEMx1NycXd8m?=
 =?us-ascii?Q?jIuBV1cQ7UdZQlrpGwwuwze+cX1V9+CU1QFchguBs6/yZeHzu4hSbHFsK7jG?=
 =?us-ascii?Q?3Nq5WU4cvWwY7vJN1P2d7odnGwAFeVtu+73FgWbjFDIaja6S89AJZZPIChaF?=
 =?us-ascii?Q?k24KhsGygCTHSeV32ogjUgDW1+SLVer7yuECjxKQ0mLStEkY+XT+wj1n3GnV?=
 =?us-ascii?Q?VK2PqfrZj4FByTylQzn17xuZXI5CQc8WE/RTQ6u0GZJSjdjj0Hbqyir7LYDB?=
 =?us-ascii?Q?XimZIymdNOsqe+iPHwRLIuCXu8VimfGBQZyJPjYnPHW9VtyXtSXuP6e7MLhT?=
 =?us-ascii?Q?ZwP0qow9RfvwSbMre/Gec+gJWyQhGFmxAfEsb0xDgMpHVoHhEa0BzwTZXP9a?=
 =?us-ascii?Q?DO8TIx+bNEshb1XixuZ5MJXVaIVxOxVoOwUBiNGu9hysTo0iOpeSbcFSdo16?=
 =?us-ascii?Q?CDhmDHkjWZMZbrGwAJKoVlqypvS5Z5jv3LKIwJWlSLesSa7MaW6rCdfuAZHN?=
 =?us-ascii?Q?g80jRmVTfI/Z6AbS2Qq2IFW3pP2ca96S7Sg8DegstbSmlinXleIqGWIiaDh2?=
 =?us-ascii?Q?yAiEeYdvJsl2AluMXnEtyQmrIrbB7K9m+RgB3ZXFUJtYsbGNVZeBsAUKBgIK?=
 =?us-ascii?Q?h4+mMYHiEuKrc+10YZkNReDar8HBXG2pfY+Xruu2MRvJqnkFUkO+TajuoIa+?=
 =?us-ascii?Q?GsRaoSDDX+kXZJ8sqwLutJwCy+vpGZ4I4IjbuWvWASIF179JryUzaLySZmnO?=
 =?us-ascii?Q?hnKe4AFX3IU50HhfpUqCpoJLiZF3GInOI1v+HaQ4jNJ/80FubzzEMVcNQuYO?=
 =?us-ascii?Q?JsfAq7XiVXZL1K0LkEogmGESOOQRtbc14lknaANMlEH9KFIc24e83t51MWX0?=
 =?us-ascii?Q?EH8EFtmkO4ZozFzjGbRfqT/pOWV0YqwApkRxhs+37vVbbmi4PRLJSU2KTSTw?=
 =?us-ascii?Q?XzHg2GBsDtl4PuWw5CPGVoRg6UiDK0Vory/kVrghoKmu7vQMtZYhfm5CBH6/?=
 =?us-ascii?Q?dm6q5Qynh5v/BTgbqR7WyvuRtoezcQ5P4p4bP3ZUpXfzzNdEL/KTMrk5Z+uu?=
 =?us-ascii?Q?7jAC5Hz+M9lH2HMlcGWHFwPdUhUDXqxBi5dRH08hs9INKyjWwdmB6DVzs6T0?=
 =?us-ascii?Q?FyaT3LiazWc9eRNE6A1UdFcaOfvABlXTvBcW0odqZFoWsb7Ua0DST8f3jBsg?=
 =?us-ascii?Q?XST6FkOVe95+iDduC931BCfGze/yNfTfSzX86XhyYuAB3h4BFUBSb/FTDkNP?=
 =?us-ascii?Q?S7EwXodH8DX9QwaRS5Iyj1yhX8LZaeaeJZtnVfpgS3eGjf/j3gt9zHpEP/q7?=
 =?us-ascii?Q?B5PieJ3mcNzrMIM6X3eAuPLrClBJCvzVxF6hQwVcN0yu8yFm+H7apf9WAoDb?=
 =?us-ascii?Q?9zT+7qJMoIaIZUTNAB5EMUl47HhwcFHXWltiViS3OS2fKx6OxlokdOXElUtN?=
 =?us-ascii?Q?+wdn5SXY6d1OQZUiAGMEg34+EeFZJ8cjpI7hSZfaAJIPniMvfktwA+JLqrHC?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d139d5-a41a-4abb-4486-08dcd433ba7c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 20:36:21.8545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZ9GLDJPbuDtFzjbvIhyZo4FWk2jQ19Pt7kwwxk6F69g2ifM0UyszIQ+sjx0oknnXqHOH2wVZpJYbWBLSL1urg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9818

Alexander Sverdlin presents 2 problems during shutdown with the
lan9303 driver. One is specific to lan9303 and the other just happens
to reproduce there.

The first problem is that lan9303 is unique among DSA drivers in that it
calls dev_get_drvdata() at "arbitrary runtime" (not probe, not shutdown,
not remove):

phy_state_machine()
-> ...
   -> dsa_user_phy_read()
      -> ds->ops->phy_read()
         -> lan9303_phy_read()
            -> chip->ops->phy_read()
               -> lan9303_mdio_phy_read()
                  -> dev_get_drvdata()

But we never stop the phy_state_machine(), so it may continue to run
after dsa_switch_shutdown(). Our common pattern in all DSA drivers is
to set drvdata to NULL to suppress the remove() method that may come
afterwards. But in this case it will result in an NPD.

The second problem is that the way in which we set
dp->conduit->dsa_ptr = NULL; is concurrent with receive packet
processing. dsa_switch_rcv() checks once whether dev->dsa_ptr is NULL,
but afterwards, rather than continuing to use that non-NULL value,
dev->dsa_ptr is dereferenced again and again without NULL checks:
dsa_conduit_find_user() and many other places. In between dereferences,
there is no locking to ensure that what was valid once continues to be
valid.

Both problems have the common aspect that closing the conduit interface
solves them.

In the first case, dev_close(conduit) triggers the NETDEV_GOING_DOWN
event in dsa_user_netdevice_event() which closes user ports as well.
dsa_port_disable_rt() calls phylink_stop(), which synchronously stops
the phylink state machine, and ds->ops->phy_read() will thus no longer
call into the driver after this point.

In the second case, dev_close(conduit) should do this, as per
Documentation/networking/driver.rst:

| Quiescence
| ----------
|
| After the ndo_stop routine has been called, the hardware must
| not receive or transmit any data.  All in flight packets must
| be aborted. If necessary, poll or wait for completion of
| any reset commands.

So it should be sufficient to ensure that later, when we zeroize
conduit->dsa_ptr, there will be no concurrent dsa_switch_rcv() call
on this conduit.

The addition of the netif_device_detach() function is to ensure that
ioctls, rtnetlinks and ethtool requests on the user ports no longer
propagate down to the driver - we're no longer prepared to handle them.

The race condition actually did not exist when commit 0650bf52b31f
("net: dsa: be compatible with masters which unregister on shutdown")
first introduced dsa_switch_shutdown(). It was created later, when we
stopped unregistering the user interfaces from a bad spot, and we just
replaced that sequence with a racy zeroization of conduit->dsa_ptr
(one which doesn't ensure that the interfaces aren't up).

Reported-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Closes: https://lore.kernel.org/netdev/2d2e3bba17203c14a5ffdabc174e3b6bbb9ad438.camel@siemens.com/
Closes: https://lore.kernel.org/netdev/c1bf4de54e829111e0e4a70e7bd1cf523c9550ff.camel@siemens.com/
Fixes: ee534378f005 ("net: dsa: fix panic when DSA master device unbinds on shutdown")
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/dsa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 668c729946ea..1664547deffd 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1577,6 +1577,7 @@ EXPORT_SYMBOL_GPL(dsa_unregister_switch);
 void dsa_switch_shutdown(struct dsa_switch *ds)
 {
 	struct net_device *conduit, *user_dev;
+	LIST_HEAD(close_list);
 	struct dsa_port *dp;
 
 	mutex_lock(&dsa2_mutex);
@@ -1586,10 +1587,16 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 
 	rtnl_lock();
 
+	dsa_switch_for_each_cpu_port(dp, ds)
+		list_add(&dp->conduit->close_list, &close_list);
+
+	dev_close_many(&close_list, true);
+
 	dsa_switch_for_each_user_port(dp, ds) {
 		conduit = dsa_port_to_conduit(dp);
 		user_dev = dp->user;
 
+		netif_device_detach(user_dev);
 		netdev_upper_dev_unlink(conduit, user_dev);
 	}
 
-- 
2.34.1


