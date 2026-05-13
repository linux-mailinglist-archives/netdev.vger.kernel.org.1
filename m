Return-Path: <netdev+bounces-287396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEqLC/zpA2rNAQIAu9opvQ
	(envelope-from <netdev+bounces-287396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:03:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DEE52C869
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C6F3034A9C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CFA35C185;
	Wed, 13 May 2026 03:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P0YBwcrr"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2D530B50D;
	Wed, 13 May 2026 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778641358; cv=fail; b=Yi32YqRS9esP8pGgQ6rQqfhkayQo6vR9TLjWcybVqRpGTJgpVkxzQIik5a3+YEz/Wh9fXObQOFlD3oYh9h72y1v6FUNPeIMPVPDK8owMU8wt0B7gY8V7+dmtyG8lYZ7HpRjSV3XJ/mibQ9Dhu4meAJB0OIBYeqI600ZMkXXoZsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778641358; c=relaxed/simple;
	bh=/1pDAF+SAKlVRDdkPramdtJ0qI7RXu9owhlnSywD0RY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LZCTWazGzKTUfdSPB9lKe8PxcxEYET4kxA3UyzFe8882+5hXttTuIR0MhCrspbtmTUZWt7v6siO+yFbAvBuOtS7j2F2d3wAgXIM/6G9DYQcDND5k6W1KwkD9a1Kf9xWL0GVDyYCudCuFGzR7pGtI7tSii+e3scAfkZS+4+YLDv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P0YBwcrr; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTtmsUTO+0/XWSEboReFQB1iB34WQGs7W3H09MqbDDDQhDaGPco3t74OpmpoGUiLmmGSANaOceVe5iDRP7MJ92cluzSwRpPVbq/y6mC/ktrYX7xU4Q5niIyPhtggJV/KQRfvhZVoBqhg5mrHCY9vAV0d7PhyNimJ9Hps5goTaz2GKefXSLjNieGDsszZwkDjatyWa7nFeLgL3Umm7ediltAOEyXDfUafoqFpiXSB5ulLlnTYwioyGhZkB/ehHsGzoLtQCHC8kjAYB4EIo38p/C2bkIujMb6KwFQiNhG5sgzFghQSTt2H52TB+gDLgzZjLU8g60yZC/ft5GxYHP0gdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QIpneJD6m/S/80aesbxQwAdUvv860RySfeuq8k7Lt4=;
 b=KPzDrifZe5yb/e4o/mQSaKky3+qMALFhhG7imLUdzhm43bl8taXkpLSdJmdAY7ki6ySsukzwrDEiLC8XAJPlzFM75x4cdV0jKBcy8/hzg45SsZ0L92Bv5q6sqZM5hRoYb1SoOWJR8JIQib0/A87MjW2rrpN6c6LHUo2TU/CajMPsf1usMVn00oTssG0bA5w5pyNvHYkhhSt5aMCeNBnErSZpc40bmndlb2wNCtTcZV16H+NAiEc61VqUfX4vaAWDtYwm9ax7TjAfATUDiyznXoCwoienIleKvkomyATNdqiNKuqi9Av1tSTpRgKaMrzReOhJTYHy0uJiePfSERAA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QIpneJD6m/S/80aesbxQwAdUvv860RySfeuq8k7Lt4=;
 b=P0YBwcrred70V7nmYsdavVDNOyqI/OkiTpOgj6ydwXWbx+rlI4pQb7G5S2tCJKeemoibAoZKT+5XOisKA0zOLm6xhUmBqsfgV0PdjJNSHcU9aqR+tFnJQT+FhOQkZpL66JXIPRUJTfk0MRaFsn+qLOw9VZS3tuH+W1RPOR62ljvWFxBskzEsvggcxk7/RpKFk8mq5YfziW7oEcH0A3Vc0nIftTVoiw+x0n7iPwTLVZMyPiBjYWOUpJc1npcKtgAh5BB4lTFkKSp2aZQygsLGmeJjlXtsvr+X55upknWQj9pEsj1SgUd3FwszAnk1vkA/bre8lgo3nu0DPP0Z9IonOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:02:34 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:02:33 +0000
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
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 01/15] dt-bindings: net: dsa: update the description of 'dsa,member' property
Date: Wed, 13 May 2026 11:04:40 +0800
Message-Id: <20260513030454.1666570-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513030454.1666570-1-wei.fang@nxp.com>
References: <20260513030454.1666570-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB11525:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ba4dd0-0fd3-47d2-954c-08deb09c1469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|3023799003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	Npy6ZV3gINmtg5MjKbOACmQPJyUwmVYwQPL9k8ayANTHVdxOR5esF2cq5xKpUyUU371VNCZ9ECH7hjnR7ZSC15LKJy/HSjVRHfwTgRZDvKi6IOBMKqzchfbDNoeGsiqwjPBBl7QQmZmdqAme/PyufyVTcRf5v/SPGIeMZIfIaLnLlCBy236wIBnA5VKR6sQEmybrF17bLagWQyFS2/n7FeCao4bObMJfYQl9VlRbjyNmOsq4trQWi/44iTUJmTj8DOvW4g5Z0ujWzM7ejoZMQ3QqqBgD0mzFWUIZkPOEK/XwEzWKYtwQGL8uJNgU2ZRXrvexGInX2Yf14D2oFQJwdUwvybDfWpNL893nduGGlwi+dJXwfM62/v0rygkvcpsJfj/PfQ6NI93SXes+djgeM5IJ0ii2eMiTSVPariYBcGfsBthrZ03elWH2GGjVjyiFuVrgQ4m1fAwiRXP/jiSSdl6L1Y8a3V/OiiFnUxLIamWxPDQaT3YNtDtcq/5G7ULpqOD7rhOhBQI/NBfvboUQLllA/At6RhclotAL0F+em7BHFrxJvFXYi490RHbJDrFD5sge8tEr2zhzf4f9XF0NYqWJKangANqvLYMl195TMymOs9oo4HgNbuLP8Fz9JHz0dHOAQ0WQo7pdHgGzAKp40vO10oeBhJB4quD+1euL3/M2PbU9N+0tmTrqNUFf+Lx/APVoKjpq1ByPbQsSUhN+wJP0Yl+x+vCdoh+TCckVGluCP6EgwtDygopwZkZQ65RSzny8f2G8NKX5fcrxvCeX/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(3023799003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jijq1dExi4na1XEdVonc3Vhu4Vvje7Rqw4+YndnFxEvWVZBTUjNCDlFY6Xfe?=
 =?us-ascii?Q?rSw/EBcwGo2becs9acHTS7HiRSMOdOOziCYlnYjga7uP/pWo0SKlRGltLBKX?=
 =?us-ascii?Q?SGY7z5UdaN5O4eOXQI5tnd2zCsojz8MPOPWlkQ58se31CjH8sLtBtOWsistR?=
 =?us-ascii?Q?vsXPeIozvyauohkUOz4okptOD7JjaZuuvqZ62NAalBYrIttSORorYJNMbBf3?=
 =?us-ascii?Q?r2CvKvkFg8rcibJgaQt1wQ5IfT1Cqrl66qS0ieXVq47Pt1iQHKolM+RfRHC9?=
 =?us-ascii?Q?WOmiqwYuhUiobQxeVdYn5+fHQR2/rF0HG8Q+mEoa1lPlAvFzZXq+6M35nrCL?=
 =?us-ascii?Q?JwkYBFE3ltgbp1BpVVsu5wrF+v6ikwmFObDAGVdEhh1RuH5prJQVmTX+KJZ1?=
 =?us-ascii?Q?ROWw4Ta28qGOu5hIqbxXgO2+PMfhmydTAKUE1Ob/rd1ZynOc/XWFZQ5qW9lh?=
 =?us-ascii?Q?pkycL+rLxXCbLhDN8p5/f2Y2BUmNLMFLpPFG81ViR3/YZU0VprkoIFG1EHAH?=
 =?us-ascii?Q?iCutTf248AZlnCuQSZhEmi62M8HTrg6wotteyPd3QPPIyBKbt7/+w28C9xPN?=
 =?us-ascii?Q?//EM+yqvWfMhEkOpQE0NVA+XIFLlryiflwGkPIDP+mQaNcncngO+oa+0xx6X?=
 =?us-ascii?Q?/IlVewdHW1LCrFnEeuGlnEv8HSqBvT1Teafy5Z6b3VN9oc+vuaDnMS5wWoUT?=
 =?us-ascii?Q?fM/4VSpGolEMQZIYPv0u+u4sQm5OM6S5gSosKODxRtWWjcn/E/WXHhthlL46?=
 =?us-ascii?Q?NPZkxQIwXR5XfjFgTijMkYh5/lZhXAjpaUXMyv0684cq6uqmT8DlEIElYZZT?=
 =?us-ascii?Q?pZLPg9y5WBCfXXT0wR27j1On8WhoSu3Q+m7iiu9znpGurR9rHy23rX/opfrQ?=
 =?us-ascii?Q?J7uCz9B0MzKzn4EGLsAFyhwxDLcN6KJIxXcbdiwEA4T943sNwkEqYVYhV18H?=
 =?us-ascii?Q?+kFjbvwAr/7pF6eYVSfb8z2KmuL8SyBxJzGkAv9H7mHTbDxx+8IeV2ptQSq3?=
 =?us-ascii?Q?TnGlLwpPyUsGnPtuQrx8QDFLzkVwO/PZnOAjO3zivozvJUofRzieSv7Jnu+X?=
 =?us-ascii?Q?+/9NssXS27nxSEUIqXshGbIAdQGmTzBGT/6LsvMemGc2Mw3Z6Nx/jqtoFpix?=
 =?us-ascii?Q?hBU5+GzbaM3WoJ5mQ1CN2PVC8PxfvYB4B8Wa2wDOhpL5mM90pEf7o2ZKmUop?=
 =?us-ascii?Q?S41b2tzfPLLDvPyEyeKsV3LbBwleFsFb2gj7r4egmPFDy6bSyzJmQux2A5OQ?=
 =?us-ascii?Q?73R4cAvgCngiJpC2QbcptvzbJMzmkLpGfYvq1TUKbdtmawC8l+0Mu3qtYjxx?=
 =?us-ascii?Q?/eTyn82Qf5rRrzH/LywOndatGQlSfX4y82VYewq0soxYTxrdjT6bsYUatIS/?=
 =?us-ascii?Q?sMphiOejQUfy6eJ7dyHYQcBKIvlCf5Ey/N1OuuuukgUtXHyBGo1XbcJcUOR/?=
 =?us-ascii?Q?gWOkwpzhTiKFYA065fBeVval0K6wqiw/WwnTEbk54QZ/l+/CEDodmt7kgXEn?=
 =?us-ascii?Q?PTuHdU/qoK40Nq7HIA7KBJwXYl8biDH1CpMy7pRh1VcG4Ts2dW7XlAnsNKiX?=
 =?us-ascii?Q?75F/cer7Kg60p4MX5GbsVongrSYU/g9qnd03ZkzcBsckfe77XjUvVC1ohbim?=
 =?us-ascii?Q?elWP1H2QDfov0/JZADNWr7e620awsLMCmHLpRYJWCIIuC0LkQ99SL2RBNfNA?=
 =?us-ascii?Q?wI5nZZv2Imp+xfBrUYy0IWWCAsLkAR50dR0avXWaCyMzH8leVox3n3n32M0t?=
 =?us-ascii?Q?UiTEwknGHg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ba4dd0-0fd3-47d2-954c-08deb09c1469
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:02:33.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NXjSSnv1RWRZN8rlyPVY0nfuJt6pWzAbfyfkUzIH2ODWsAYeCZYxZxpN1o8nv4eLqyAoxdpMkHfNyTA6kpjJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525
X-Rspamd-Queue-Id: 84DEE52C869
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287396-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The current description indicates that the 'dsa,member' property cannot
be set for a switch that is not part of any cluster. Vladimir thinks
that this is a case where the actual technical limitation was poorly
transposed into words when this restriction was first documented, in
commit 8c5ad1d6179d ("net: dsa: Document new binding").

The true technical limitation is that many DSA tagging protocols are
topology-unaware, and always call dsa_conduit_find_user() with a
switch_id of 0. Specifying a custom "dsa,member" property with a
non-zero switch_id would break them.

Therefore, for topology-aware switches, it is fine to specify this
property for them, even if they are not part of any cluster. Our NETC
switch is a good example which is topology-aware, the switch_id is
carried in the switch tag, but the switch_id 0 is reserved for VEPA
switch and cannot be used, so we need to use this property to assign
a non-zero switch_id for it.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index 2abd036578d1..801e1411e5c2 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -28,7 +28,11 @@ properties:
       A two element list indicates which DSA cluster, and position within the
       cluster a switch takes. <0 0> is cluster 0, switch 0. <0 1> is cluster 0,
       switch 1. <1 0> is cluster 1, switch 0. A switch not part of any cluster
-      (single device hanging off a CPU port) must not specify this property
+      (single device hanging off a CPU port) does not usually need to specify
+      this property, and then it becomes cluster 0, switch 0. For a topology
+      aware switch, its switch index can be specified through this property,
+      even if it is not part of any cluster. Also, topology-unaware switches
+      must always be defined as index 0 of their cluster.
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
 additionalProperties: true
-- 
2.34.1


