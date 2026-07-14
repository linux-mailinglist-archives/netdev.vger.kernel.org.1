Return-Path: <netdev+bounces-307334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LGBuCLObVWqWqwAAu9opvQ
	(envelope-from <netdev+bounces-307334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:15:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B882D75051C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:15:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=ckJGfbqF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307334-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307334-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B04830C3931
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76C737B003;
	Tue, 14 Jul 2026 02:13:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF483563E8;
	Tue, 14 Jul 2026 02:13:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995198; cv=fail; b=hr4hjQH+76ohiiGlkMTWy+qjho+dfWDtrkG1hEYhFlWaXEq05nlquz0FUS6bqNC1FNuiVmTf+dXwGQ5ArP2FmZXnL5pHtWcR6w3aKWTaQASVWVfZACAoKLrf6EUm3bJ+GxpGBnRHW/JtbRlSmSF/E+KTamTJlC0EJVYL3Efw/Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995198; c=relaxed/simple;
	bh=CeKuF5/YhnzPGQyKT3PSn/KINveZ8TtSLSDWAkjk8ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I48ze2C0Q9diOpSFoiq1Zj+LXVjMwA5CvKbXmpUt1sPXG2m/AaK/whDZVvtf+/cd1914oWzttJWxRANFPcoBW+7JeW30gkvzOy8btj+36oOtyDeeU6mEEytWtbmR07GpuyBAuk0q0r43k3VY6fBL8uWRhtZ/dkWQ9iiXyRzTSNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ckJGfbqF; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRzGlI9uXdlOQTRaDCfPmhWrZ0odclhwcbYIUCvmM8QkJ3b0Bu7d7jokMkvu/sISRV8at8pYaKOm6iWb+bRFt61iNPUU2i1S6GdjXn+u4JMd091K8O8Y0PIYwoypKh61odSjRPOL+N3lnCScwkAe4IO/6ohmJtdm4NIi/Cj/jiv9IyJ6OHUBfrD8tAubOFYADJPjnXvJaU6i1zMZmTsWZGgBeZLwm7xsihZIz3DDkJpFpZ11GQxz++aMHOdDgfdO1ihCztEXOE+h9YF8xPiD1GDvsehJTO4XynQ5ARGsbtZk2qNqe/6dzres/TevN0YFZFh0Y2So0vFoEGxSdorA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9t2HPChHipCsmtNUuLY9/6uScBqb8Kc1dp2iF7vEBc=;
 b=mAGO5d18vJ7ADFf5Ufp/j8dMAVfz45g2I+qguqG5XPsfC3u6hZY3b1bri8CoMboTC3sq+CvVtvwfFOLBdksZ8PRvHfwiqv1Pj9D+skHLmp+n1SCJOSQ9K8OeS7m368TUplUBeENAWQGQBZvuJc9AilYulw2Mv3BosGYI+omQIFJHXTBMwkal7D+pQrA3jp1WK+4iQ301CTRYztpzh3qrulq0+o3LFDUpEAhzMN830mwWiG96H5hQyFmdRFfwLHV8mXW8RK0BhPH7D4QB8Kk+Cwhj3d+5HDzx7xAchc47IoBMMAJhw0FTJ3cBjALxv8gZoq/RUlIQBGw9ybgMm2zK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9t2HPChHipCsmtNUuLY9/6uScBqb8Kc1dp2iF7vEBc=;
 b=ckJGfbqF0Si88JinnLVv66nJBcymdZKRRta9Of/sPs/QMazcqFnsQBQOeQY9ZLyovmXSMRfnZA923IUkJJJcq/R3tLCvOtQU5tMii/7AcatwNhCR3OQIL2k9mtq98JHkeavkJK9EDR/1AlIk7nUee0AmdoWl4YIwNSFcO6ELCzNWNynu49pjxjFA8KYAjw6fjkVSG5mO5VCkBTgd9UWNbg8zQe8c8lWTImOVJ5iD0i2t8Gqch1gxnCIlYiNksme65GXxT0cLnGY7tSP24VMPxnok7hunUCdZna9Noe4HhFYQfKYzJ9Ef3FHCe7RpqBCSZS/83cq7Pm3xrvV6cZUV2A==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BLAPR03MB5410.namprd03.prod.outlook.com (2603:10b6:208:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 02:13:06 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 02:13:06 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: rmk+kernel@armlinux.org.uk,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] dt-bindings: net: altr,socfpga-stmmac: Add altr,socfpga-stmmac-agilex5-tsn compatible
Date: Mon, 13 Jul 2026 19:13:02 -0700
Message-ID: <20260714021303.30042-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260714021303.30042-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260714021303.30042-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|BLAPR03MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f9a02d-672e-4877-f9c2-08dee14d7163
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UU4TTb2Q8WfoQA10E+5iZmBX68UQZ7vAaVtYBxCmKN6lgtfZJYg037ujRbKyhFnLN1+YtBjRIeiKZt1dHQM85mGdQgG0/MzVn3Be5lVkA69nzRJVJGb/p+dlr6iS3KYSORw0YdWaaJK+H6lb9bt3/u3wEXet3vEriPFXtyvXKH5TWdAhpnm+Yj9tz3aW0L2Z6uMyKMKSpwhv/mRE2GsNy4sCApFxE1rYoJkj/YAG2WXeY/o3Oj5F89H7P6mVvgy8fmDd0XblKfMWxxPSViFnn8bL591Tp1PKTBRFwrkWk7u2ZhALKFhcJ6bBwKIVCaYRRIrnXrnGegCJyOaZxxozMiUmdxgbl1yolmtG1e95dlwfrx4PFjEKGzge8LpQp6GESh4e6iNF3Z5zExqYnWcBbFZ4+WpOZoJ5vWczwHpJdcitlqm8IKtQTCluomNBgUmpyJwv54LLT6Rz1ibaJcJGxUbVE3Tx064pR3GMmU1cnGq235SiK7sUc2sCEoQul17mysikoZz1v0dug+CjEIoqAkaaPWNxSmiuR/XcP3gSGK41uRXrDgM3iOUB+BGVBcydQw6RN0MdPaM9GQ4+xLcsP+K5R2ngaVLnGTd+y3fe1EN/NFewJrdUAY0198DgWEzlcfmj5qHr+wXQw51mxqBRv12NJW7dGU07GufuecnScSo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6mRRbySrP3Ur8zKH30k/QF4aMKm9K7zVTOnuvmdsGMmJnPovMsA5mmRzyYoI?=
 =?us-ascii?Q?k+EuLoRR2d2xNaGfNKBo7aTNsmUTB5zw3XagzUEr2nXOXSI6u10Mt/IVs84m?=
 =?us-ascii?Q?CFSIDoRdy20CfIT7nDHGZQKDgduSJ0jP4EMGLyOMGvlGv1yBP9b2a4jQE9No?=
 =?us-ascii?Q?uJPYULsuzhfO5fTzMCC9OjjqcH6Qh7YUBYLRwXHmRy9C3orrybGaV4cYu3YP?=
 =?us-ascii?Q?fdCzygzMjtp9IEZUBHfcgLBIabOMbSfAI+zGoGqcImaLeoEVCB3gpJW9fWBN?=
 =?us-ascii?Q?TP7SwvqJH6qHLe7RPYx5RJor7wiWlcm4WRmK7v56Gx4f+LWmM2YBZy0K7qJc?=
 =?us-ascii?Q?l3b0oyKxTK79jYq54+sJzPTnpWtsxwNKx7l/sj+dHQmAPz/Wk1tl4Rpq0SGU?=
 =?us-ascii?Q?r9oFaMpT6PW66HbABPY4mviHJVpb/KdW7sckIdl4AFlBKyzLnw5CjrWEGvN5?=
 =?us-ascii?Q?FE1e+co2movqW/sMqINZETczf2QvQWNXDx1IjoDDgUWKaXGQF2A/jq9+inLR?=
 =?us-ascii?Q?adrAqpyoQ6JR8gTSMf/HQatV35usyLUC7XqmLoIO6OVSHBzxtAbHvMzvhtC+?=
 =?us-ascii?Q?5PJbh21Ril0WU7odXBttlYjfAeUlHKqWn9AcfUb54dVWPv9At/UqP232pEl7?=
 =?us-ascii?Q?KJArUBtIR0IdmAhVVzVDUj6oHSuHJGFbXmVK58ECWWC4VWNATlyur5lvOadI?=
 =?us-ascii?Q?Xe2iiomxTPjtAz0r33uGcKTr55nBfyOL4AbOcEo8hSWwYr1FwQgDNf7jFbDE?=
 =?us-ascii?Q?811NRFV0cXF+SUZGXvB6L8qMLUWyx9OaGfWi17iL/AYKAreSvyG8kpDbSEMX?=
 =?us-ascii?Q?IjFw/eXXEn3ZnohHh8zgwdId6MIBIKVx7Yz/GRL/G5atzmH/2Pk74jstgnoI?=
 =?us-ascii?Q?aJJtosrY0SuFa0xeuEPOf2IWCyT+TGaQxlm74ztQMm87r1flFuEeHbPSeV2+?=
 =?us-ascii?Q?V+zMC6jub2t1y/ca/ptuuLXW/+E99MmAyROL19Vshu8ML/zGdbiEmGXfmzjb?=
 =?us-ascii?Q?ThRj8+UyDHAdsDb76ymcJ4Oic/DsvOuW2bI49jXHkeK6S14V6uZHD9UJqu9O?=
 =?us-ascii?Q?rLSNMUM7pw62e3U98NgaC9FFfWt/zhE5M2u/URm5lBLshuxBjyYl++KGnbq1?=
 =?us-ascii?Q?lV0iaEVT7CcyHBMSnWuarVauSkVz7E0nHAHNi/LPpAdrBzEldP/zx9cdiMsC?=
 =?us-ascii?Q?e6it0T7MYnOQoMn8oWnfDs6bLEemDdEtU/hZANVTXR7AY5BIjupLVZDvrUQw?=
 =?us-ascii?Q?Pre+qczJnuazMNDjWDQcIgOjdU9FV6TmEXhoOKvP82WA1gaSSkmYzWkthzpH?=
 =?us-ascii?Q?cZSYwE8qmv6DSb8+mdG9dxYUmqhE+Jgz9D2VQ9oa1S1ZPin18Smszp8L6EEj?=
 =?us-ascii?Q?rBhvYHPPMSuRhqD2gRwLfJUKSGJmHJ3fTB5J7BoBz3dk7JXaaOSVLKMwBnlA?=
 =?us-ascii?Q?tC+/f99bUGuCdsCRm978SlmZxQ8+46iH3nXlYhFiHeTCnlPaRT3R05C5X6VQ?=
 =?us-ascii?Q?153KgnwCcuR2RY3VA35yA8SYPPt8Rr++YmDfWDltFEr+n242z58G3aQmM/+y?=
 =?us-ascii?Q?xdH/m2jMSaiVn58fPvo8R0EIb6VSOrBgnr+O2OW7u8m9a61hs2OXU5+W2SRU?=
 =?us-ascii?Q?7BfgJpAxDadJoW+eYmPWxIXpxj6AWLOTHrU5f7viUw+09WA/+T+S9JFLdogI?=
 =?us-ascii?Q?KqS5mdi6HsFupguEnecLxtzziv7pFUfYmf3zXaYGLvdBGylh6Bff1PN27CPU?=
 =?us-ascii?Q?aWq0SKqpOjyVvK09j/CfEsQfKl2J8oMYcZyThoEcAaZA7q1/B4gHtMarsmOV?=
X-MS-Exchange-AntiSpam-MessageData-1: 9x/fWry1rhF5HA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f9a02d-672e-4877-f9c2-08dee14d7163
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:13:06.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5EIL/qzoqLm50Womtg1dyhBpyrCjK+FA6y5b3hKMvJMucgC3QebgY2tp25oU8ouFiPow5VZSA3ZOTzYZd0gJm3y/OEjUlon5oB/UCZRSuhXVhMMA50WY7Mtcys+l/LcynT+p+v+E7f0TwjIhG9G8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5410
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307334-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:from_mime,altera.com:mid,altera.com:email,altera.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B882D75051C

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Agilex5 SoCDK TSN Config2 board uses a GMII-to-RGMII converter
implemented as FPGA soft IP between gmac1 and its PHY. This converter
provides the RGMII TX/RX clock delays. Document a new compatible string
for this MAC variant so the driver can detect it and configure the
interface accordingly.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
v3: No changes from v2.

 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index 63084f762373..81f030986fa3 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -24,6 +24,7 @@ select:
           - altr,socfpga-stmmac
           - altr,socfpga-stmmac-a10-s10
           - altr,socfpga-stmmac-agilex5
+          - altr,socfpga-stmmac-agilex5-tsn
 
   required:
     - compatible
@@ -46,6 +47,10 @@ properties:
       - items:
           - const: altr,socfpga-stmmac-agilex5
           - const: snps,dwxgmac-2.10
+      - items:
+          - const: altr,socfpga-stmmac-agilex5-tsn
+          - const: altr,socfpga-stmmac-agilex5
+          - const: snps,dwxgmac-2.10
 
   clocks:
     minItems: 1
-- 
2.43.7


