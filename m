Return-Path: <netdev+bounces-282613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCTtGsPC8mkjuAEAu9opvQ
	(envelope-from <netdev+bounces-282613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:47:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0670449C72D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62656300647F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AA732C92D;
	Thu, 30 Apr 2026 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YexDwnxB"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013038.outbound.protection.outlook.com [52.101.83.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C53290C9;
	Thu, 30 Apr 2026 02:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517248; cv=fail; b=QjX1mT29xlomvbc+ho43I/JlXzNYmX0ozlTTlZLRW4jyoUbeYW/zp0UN3VAY4Z+hDMjCGnHNoUd/38EqO41/BjD44OqCzKVTq1hPPETq0ZMHRbKZYbg6+3wBWxuCF2o1F/7sgMixjcIct4LwXJyvLCq4iRsGooPx4OBvGSV+qm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517248; c=relaxed/simple;
	bh=zI8JMJANLw0r8xMjRsKKA9Qtem7noTY/8y4gj0VWORs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=piOGS0Tsn5+Uo7wh9U1sMc5ua02j7GD8PBoXiz5t8Pl7S3aGE8pj7mZLbKDbIgIpbBpnm15O6jl7qkn2JCgnBsUphT1YWWwD6/4aJoz8+yMDgP6LBEop+FSnlCF3IqUeskV8e9qigRTnJiX1e3XNRzPoe2zaWCUXAncevuAR62o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YexDwnxB; arc=fail smtp.client-ip=52.101.83.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MB6AhAQ+theklGpVR9xpWefdD4nQFf2z23kx4OrZ3FVLVw3D6wxpymS3K7kvPHqj5XlxanlWEnqsU4uyGOvS6tT5zJ2+vWmRMl53CpycWIvu5tmYeS6Js71tkLTgZzai6ZZcf72s8kNv7j/IL9uKxz6b0XfaGpyNrscYks3NplUNfCo1qoN1moJpkVWG8bx9OXPJKOwKw0OoRnz4gh3R6MD+zOkOwuhuyORylGSrqEZG1oh3ROZxUu9Aut/WANd9GKnUjFOirvTHYwe+O/y5w5CS/HEnZSVEsNi6s+f7+9Kssm/2IyFoDNVUX6ohrD9RmUap7XTNdglKtGQgN/bKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1Axx6TpUYkImaS13VL+XPq2+hIeUZ9serlJOfJQmNw=;
 b=ycgEhe70v8VjkNioxqgFUFNIuv7t2InGXsQhvC8cZqqaoFEtdAF3G1A5tlEa3tPGmLakvzHK6PNbTL0iTaR3KhmwSq1V65+emJT6a+3mKXjck5L5o+3eZD5S7LCy18LA1HnzgMnOpdqWpD2dQShIFD5oAMSHeXH5TIXXO+JAFyy/Wl6Y9U7ww7ejnIXKtKnU42+7dChkDyeiYEdTKvSjkeYsHxtFUVy6BGqT1KAhOwW+N4oEm4+LVPaloLXiuKOUAmH4MTIY+90aOaD+ggJ6/awK4hvi3s2+rIT2c6tBfCRzr4trDm6k17Qyas+t1LsRMDVygozqd2D5F6/9iln0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1Axx6TpUYkImaS13VL+XPq2+hIeUZ9serlJOfJQmNw=;
 b=YexDwnxBsEYrdiGs/9GzdSE0Plj/0Mr3XPvPIjel3sMq9kbrT45kpsN9YR+WvUYWDcRHSz4OEHuOO3cB8MizwYY7M2/IMG1bCTXy1iwJnMq48XJTorSiwjto/Yqvlfa/bLhTZhvW1TGzwPHB5TAu9dJZHWOjeTnbonurcmywFqhd+HIl2A1oyD1j4ZaXMVFCpchYaKFjxjwyIS6sk4xcdZp7/iBPxThymx6JGHjVrUawTEWH416TcdzMqZts/72zBOUwbR/UO2Lt2H5NtiCkQQSasDX89XRQ8SmGNrcX1EBHiIoj01DkVsmw1NTBE7w6spcbmmJ9/YatPrlz3NDTOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:47:22 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:47:22 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 00/15] Add preliminary NETC switch support for i.MX94
Date: Thu, 30 Apr 2026 10:49:30 +0800
Message-Id: <20260430024945.3413973-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b51a31-b7b0-401e-b2ba-08dea662cd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J9BexuhWVLGFXRby80dlYNru4rgRMDKpwCJknwFHbM03/JV+6+HlDGR4fuiuNUjAlR1OoBaZdEMx7dIqaPX1+OobcllBSGQKeeEI8HaXujKCyGnNKeA2+5GBBdXFfaJxNjRanEz+j9DPXpqiFm9nijULEpaVp1M41gsRyM3sycSqVJZ37bXS9XMmex0WjTBh8E8oSCdgFGOw/3hL68Mh7vxFoTBU85MKGdW02xvYx8AyCyZuVpLxk5F4WZPpLoPwJ1j0tol7rIF6lxIVdYKW0b0/j2PQH0zIkcifM1MDfukCrAmk8ohieNdcG96Djrrgvm0dzOfj/IpS/4HItF9yr6FpYUh2HbhH/z0h+2rJPwA8UuWFn86KqUMgT3xEJ6XGawpL79x+JAJXK4ONUnMuPLLEY4JIPA/L4CmH/lXIvSwwB9dG2ubHqC+zegyzHiJ+g4NQnqjbRwcCVMJ+AFh9kOhbwrI0/zomjwZLOg+IrVvRK3AjJBjZJTaNfUF10U2JxHjos9/upo1iVCN1MkQr4VvoXKInhWdyL01+SriYWk8UPC8yg5DYzVp6fuPkx6fPC+rKBGuYyjk3+o7KKCgkDm4WHE1LXUfNXIbiY+3gQUkzSDOJbwqGCYNeCOoE9NB6E9jvTAr8Kcl8XKJdvUTij5eXyUHLU2etYrFuGxu7HFbyNqGz4E/DaWPAm8bnop+eDsZgx8ayZuw4XUKFbp3tkKUV+ci5/IbTrIdczDQSl84C4vAmxJ+hsw+mBAIOTvqsi3TXp5OFp/Xha/dmyudA8lSE7lBQFC4+bQp92TkCt9UfY3l1fg4uw+zil1Zj0tMx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kxzhiAyGeRK4MBQfR2rpG2JNcjjbizkQw5GhoEPg8ERGnIAvphPKIwrI9SJ5?=
 =?us-ascii?Q?aO9qy0VJifpwkCPImI2Mx2UxUCH7RisvreU8TGSqlOTf7gKlo/qEhtRoA+Vr?=
 =?us-ascii?Q?3IFwHskyvMGantY+kw0vV1mPQK0fM622Sqy+E9rqUxWy4My7iDZSqugLea2w?=
 =?us-ascii?Q?rZ4Z59Bm3vRh0w7/lX4+NEY9j+k1NUSHxyPKwng5eYjmhjuKYkCx59NpQ1Wg?=
 =?us-ascii?Q?cmTTxS3lg0YuhNoPNq80jBwJTV1ya9jzTeilY65zOqvq/B15TePHvlryFtQ8?=
 =?us-ascii?Q?NaqgARVR9WRF2yn0qrtDluXIoNSrvWY/XshaQ0DjWmFcBhR+H76URoZLMyDp?=
 =?us-ascii?Q?IWQS1KrlK92NmdwPx6TQvGuZv5qur43H1L8OYygOi0s4vxuB4Xz/AT2qIwCu?=
 =?us-ascii?Q?3d3QG7LWyc4n159yuVfyyVpjCvjZvsJBFjn29a1C+1SDbSYl404HgGQFLxjq?=
 =?us-ascii?Q?FYxThZNF3BotL/DVW9yhWTvZMhLn/kzFK7gTrW9PFZAbvPd9+m6QnIGe2ddj?=
 =?us-ascii?Q?clyo08c4TyORfl4DgiA8QcuALWZQt1QUHs+CEZPROLwhm1ekcte9C6Es4cnl?=
 =?us-ascii?Q?soYRuxywRgEmVCzDMIMBIR9UkAcgmAMfdXvnI+AS+FN6Qku96A+mtCDNfKCz?=
 =?us-ascii?Q?4DwzjDHIrC0EyDBJFtOcDpT450WgU2olp8nGUJ9Qp94dpqhpJy0gs5dzjum6?=
 =?us-ascii?Q?WP2PmB8HYY4+nCSFaWPrFxu/FfnyJiXYUHtp8+liobwfiCsUXmLJi3+RRyUQ?=
 =?us-ascii?Q?j9+OoSXEQVDUpNbT3whkkPqThFIKBkI+ntzvzxY70uo6ejEBXV+ncLhqg24j?=
 =?us-ascii?Q?knAgjXa1m7vx5sGdH+14jtGgOH0ZQvBGvNmxjaYRV9huvrBu+Xg1ZOJFayOj?=
 =?us-ascii?Q?tmaJxP60PayVP9FtlKoK36gIEu3ThoAT8k175hCakAKlXphLWRzZWFY0jb9D?=
 =?us-ascii?Q?j6IoB6hMkWXKRucjNY73d6SVooZHRu+orO7MzGp7+o6y9cZ7QXnMd6FzHjxP?=
 =?us-ascii?Q?n/a0NfOcYVfACyI2g7b5ECNyPD/YqH+5+D6gHeUq3PwQptw2SBxw8oltxYnd?=
 =?us-ascii?Q?LOgYbECnMEyZKaTrwZc1PzCybP2sQAbqcBOq/mGk//XL3TXcsLDpRtEHqaLd?=
 =?us-ascii?Q?KLCcw4gsFsvpUpSIXedzop1R9ut9Jx5tBkTKTME3l5oQjumtlouhBk++BBBG?=
 =?us-ascii?Q?hCjjWVr6ouIOvBCq8KwG1cpOjeTM2RIqapbHpYZH0nyINwnxWJ0VyjSNiudJ?=
 =?us-ascii?Q?O/05aeQTIeVTPNR2SH9NJZUOq9P1X68fTrekEI60BlfpOSVZvR3+hmkYQS3D?=
 =?us-ascii?Q?onOGy+MTKYt8UtohS5XhqUaQMuq8nMrx4HgizfF8O1JZ4rhKdwcnVkDM9Clc?=
 =?us-ascii?Q?4fHjLoQ/siwy/taNZt9u/n75VSQ8oFvQw7nVRrAYmELbXxUmnt0mG6kq2J4H?=
 =?us-ascii?Q?fpEgxjtNBchpXm3eJ6aTM6ghQZqFtGuKCdmwQHuup2H7No3cu7sb4LZOZf9P?=
 =?us-ascii?Q?TcKo5HmYLJNen9ymDufijq1i5dzu7ZYzLmM8kzr/3p7/7BRBY8UMs+RSglV5?=
 =?us-ascii?Q?PYMzwGUCK8waca+rj69ym0M1gn0DOrtw1QIpcdyWSqFqZTeC5P2X0vTSDR6k?=
 =?us-ascii?Q?yXnXeZT/TSZmHnI1fguQYJX77YvMn9jas91nZeYYtGRVc3wasVdfgkTCihT3?=
 =?us-ascii?Q?W7era01in9aEEv0iS2VJ9bYxM46jxBrd+Rw5gESrU8lTcv+u2/aYXxDpud/n?=
 =?us-ascii?Q?A6dxDl8qdQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b51a31-b7b0-401e-b2ba-08dea662cd94
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:47:22.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3Av3gkEXmdff4S+6lKJ/KyqOkzc2nA1HTcY61Hd3BRJecnwRWR/OeXeXQKX04+kN3Jic9IHRuMywQ72sVowDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608
X-Rspamd-Queue-Id: 0670449C72D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-282613-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

i.MX94 NETC (v4.3) integrates 802.1Q Ethernet switch functionality, the
switch provides advanced QoS with 8 traffic classes and a full range of
TSN standards capabilities. It has 3 user ports and 1 CPU port, and the
CPU port is connected to an internal ENETC through the pseduo link, so
instead of a back-to-back MAC, the lightweight "pseudo MAC" is used at
both ends of the pseudo link to transfer Ethernet frames. The pseudo
link provides a zero-copy interface (no serialization delay) and lower
power (less logic and memory).

Like most Ethernet switches, the NETC switch also supports a proprietary
switch tag, is used to carry in-band metadata information about frames.
This in-band metadata information can include the source port from which
the frame was received, what was the reason why this frame got forwarded
to the entity, and for the entity to indicate the precise destination
port of a frame. The NETC switch tag is added to frames after the source
MAC address. There are three types of switch tags, and each type has 1
to 4 subtypes, more details are as follows.

Forward switch tag (Type = 0): Represents forwarded frames.
  - SubType = 0 - Normal frame processing.

To_Port switch tag (Type = 1): Represents frames that are to be sent to
a specific switch port.
  - SubType = 0. No request to perform timestamping.
  - SubType = 1. Request to perform one-step timestamping.
  - SubType = 2. Request to perform two-step timestamping.
  - SubType = 3. Request to perform both one-step timestamping and
    two-step timestamping.

To_Host switch tag (Type = 2): Represents frames redirected or copied to
the switch management port.
  - SubType = 0. Received frames redirected or copied to the switch
     management port.
  - SubType = 1. Received frames redirected or copied to the switch
    management port with captured timestamp at the switch port where
    the frame was received.
  - SubType = 2. Transmit timestamp response (two-step timestamping).

Currently, this patch set supports Forward tag, SubType 0 of To_Port tag
and SubType 0 of To_Host tag. More tags will be supported in the future.

In addition, the switch supports NETC Table Management Protocol (NTMP),
some switch functionality is controlled using control messages sent to
the hardware using BD ring interface with 32B descriptors similar to the
packet Transmit BD ring used on ENETC. This interface is referred to as
the command BD ring. This is used to configure functionality where the
underlying resources may be shared between different entities or being
too large to configure using direct registers.

For this patch set, we have supported the following tables through the
command BD ring interface.

FDB Table: It contains forwarding and/or filtering information about MAC
addresses. The FDB table is used for MAC learning lookups and MAC
forwarding lookups.

VLAN Filter Table: It contains configuration and control information for
each VLAN configured on the switch.

Buffer Pool Table: It contains buffer pool configuration and operational
information. Each entry corresponds to a buffer pool. Currently, we use
this table to implement flow control feature on each port.

Ingress Port Filter Table: It contains a set of filters each capable of
classifying incoming traffic using a mix of L2, L3, and L4 parsed and
arbitrary field data. We use this table to implement host flood support
to the switch port.

The switch also supports other tables, and we will add more advanced
features through them in the future.

---
v5:
1. Move '$ref: dsa.yaml#' under the 'allOf'
2. Change '^(ethernet-)?ports$' to 'ethernet-ports'
3. Change '^(ethernet-)?port@[0-9a-f]$' to '^ethernet-port@[0-9a-f]'
4. Update node names in the DT example
5. Change port_id type from int to u32
6. Remove netc_get_switch_ports()
7. Remove unused inline functions from ntmp.h
8. Refactor the implemention of new tables due to ntmp.c is updated
8. Correct the definition of IPFT_DSCP_MASK
9. Check the return value of netdev_txq_to_tc()
10. Use pcim_* functions for automatic resource cleanup and remove
    netc_switch_pci_destroy()
11. Simplify error handling paths in probe function
12. Remove PHY_INTERFACE_MODE_1000BASEX from the driver
13. Add vid check to netc_port_fdb_add/del()
14. Move netc_mac_port_rmw from patch 10 to patch 11
15. Delete the old host flood entry after adding a new one to avoid
    losing the configuration if the new rule fails
16. Add netc_get_switch_capabilities() to get the FDB table capability
17. Add a maximum query count check to netc_port_fdb_dump() to prevent
    infinite loops caused by hardware malfunctions.
18. Remove netc_get_buffer_pool_num(), the logic is moved to
    netc_get_switch_capabilities()
19. Remove enum netc_port_mac
20. Move some register definitions from patch 14 to patch 15, as they
    are not used in patch 14.
21. Patch 15 is a new patch
22. Update commit message, correct typos and add some comments
v4 link: https://lore.kernel.org/imx/20260331113025.1566878-1-wei.fang@nxp.com/
v3 link: https://lore.kernel.org/imx/20260326062917.3552334-1-wei.fang@nxp.com/
v2 link: https://lore.kernel.org/imx/20260323060752.1157031-1-wei.fang@nxp.com/
v1 link: https://lore.kernel.org/imx/20260316094152.1558671-1-wei.fang@nxp.com/
---

Wei Fang (15):
  dt-bindings: net: dsa: update the description of 'dsa,member' property
  dt-bindings: net: dsa: add NETC switch
  net: enetc: add pre-boot initialization for i.MX94 switch
  net: enetc: add basic operations to the FDB table
  net: enetc: add support for the "Add" operation to VLAN filter table
  net: enetc: add support for the "Update" operation to buffer pool
    table
  net: enetc: add support for "Add" and "Delete" operations to IPFT
  net: enetc: add multiple command BD rings support
  net: dsa: add NETC switch tag support
  net: dsa: netc: introduce NXP NETC switch driver for i.MX94
  net: dsa: netc: add phylink MAC operations
  net: dsa: netc: add FDB, STP, MTU, port setup and host flooding
    support
  net: dsa: netc: initialize buffer pool table and implement
    flow-control
  net: dsa: netc: add support for the standardized counters
  net: dsa: netc: add support for ethtool private statistics

 .../devicetree/bindings/net/dsa/dsa.yaml      |    6 +-
 .../bindings/net/dsa/nxp,netc-switch.yaml     |  127 ++
 MAINTAINERS                                   |   11 +
 drivers/net/dsa/Kconfig                       |    2 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/netc/Kconfig                  |   14 +
 drivers/net/dsa/netc/Makefile                 |    3 +
 drivers/net/dsa/netc/netc_ethtool.c           |  297 ++++
 drivers/net/dsa/netc/netc_main.c              | 1566 +++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c          |   87 +
 drivers/net/dsa/netc/netc_switch.h            |  172 ++
 drivers/net/dsa/netc/netc_switch_hw.h         |  361 ++++
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  |  185 +-
 drivers/net/ethernet/freescale/enetc/ntmp.c   |  381 +++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  122 +-
 include/linux/dsa/tag_netc.h                  |   14 +
 include/linux/fsl/netc_global.h               |    6 +
 include/linux/fsl/ntmp.h                      |  187 +-
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |   10 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_netc.c                            |  193 ++
 23 files changed, 3719 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
 create mode 100644 drivers/net/dsa/netc/Kconfig
 create mode 100644 drivers/net/dsa/netc/Makefile
 create mode 100644 drivers/net/dsa/netc/netc_ethtool.c
 create mode 100644 drivers/net/dsa/netc/netc_main.c
 create mode 100644 drivers/net/dsa/netc/netc_platform.c
 create mode 100644 drivers/net/dsa/netc/netc_switch.h
 create mode 100644 drivers/net/dsa/netc/netc_switch_hw.h
 create mode 100644 include/linux/dsa/tag_netc.h
 create mode 100644 net/dsa/tag_netc.c

-- 
2.34.1


