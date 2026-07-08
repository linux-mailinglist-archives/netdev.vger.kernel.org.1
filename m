Return-Path: <netdev+bounces-305799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9OeWE65FTmrzJwIAu9opvQ
	(envelope-from <netdev+bounces-305799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:42:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9168726649
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:42:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=R1OGQJZ+;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305799-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305799-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DBDB3022DF2
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6414644212E;
	Wed,  8 Jul 2026 12:42:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245CA322B6D
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:42:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514524; cv=fail; b=uTGNhiJKstzzl+gNqmo3aUPx1LguO34/gzsVIF/ZPDw16loo1oufxvMWZJJfH78RPy4CRZX8DTJrquUTJceczmnb+MCF3Z83L+dW5mvrVRrOUf5RN8FLM1hEehaZTxUHo9kPecCjhachr4Ah6WN7Kblo25745no8Cc+bk12yOHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514524; c=relaxed/simple;
	bh=GqV2M5EyBIPA88uGNdsX3XDTRYwiZ63DOFiet0Ut6HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qXqrIWsWCf/g1nphfATE2ahDYCmyQTOZe50Xx0Z6wrQwzCJpUPdIVEr2KVkFMEquCrmFm5065micYDozpzV14k9Lc5dwG5WyyeToRSBDkhF9uCFtaz6+NIbbRM4zYy9JfCgOD/9tZLjpWjsk5vq0XQeqdDLbnt4rQlyZqx4pAuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R1OGQJZ+; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmroFAvizFMCvQ9L6gN5UwoQHo+DsXeyOxBkUjeqnzI2Z17oYDV77IrB8mrPZ7LrmY/oLdeUUWHZgnEWA/UXY5mmwxUG7x+F1JIVgnx7dL8+xnXg6bgN8exj/gPu9zi+HtwbAzSQTs4BwYdfL3Opfux9IT9L+knxrbjfm2iGCLQRqTCIUGPzcmAf7c14+pzZzn8rwmbccstakvE0cgHkRUY3FPDdTQBuf9kSPsxD4EY+xyld9XQHWb8KGA4Zs88mx2JYRq9QzJiX20y5+tx4iKsCRzsM5WBhDSd0NV/Oi03OlrYZVaarKiRvfku4j4sZZcj4Y6YidHqB3uHtNAlyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SER4s/fKqrHnS4YltRxg/lUA26sJlypnOTvAzyaBkJM=;
 b=MF0caDKovRwnY6KFcNmuJF6sGw5cr+JmKrDA7DeDuvdmEvUcjUnomYFnG0NkayJPfhou51oAs8hHFVaanZO+vM6q6iPQ/6VY9uNKMfC6b8I3ufC/JZoxiyq4UZd0ofoneHcCPt7DbfAwgUEMued+ZiwvhkXbArMGZDqpBBjhBSM8+mPRGHSL/U6wBstj0d2Ix0YcksVwezb+FSqrAgt3hA5cqQIKINF4pQ3GnSGVHR/uSC+91l+v4oY+PZJDgsP5VZ9MNvOhvXcA4vK7eWJ3tNcbhW+EXhRCq9pFXyAYdW0uUVpCtq/ZxeozC8dG+X7CfCQOvtiI1rViC8Lc7gjCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SER4s/fKqrHnS4YltRxg/lUA26sJlypnOTvAzyaBkJM=;
 b=R1OGQJZ+gcOqoacyuJfY8eFuG8dswSXzR5+cR2LECMT6Boty6/ZQWQcZn6vxEz9G72lZOj9BkdcPhkQTpqJikPOFcnexj38Bi/YjkCiJ2wr45AD9Ff9TFafhbTCgM2eKbE1vNmrDajG9Bz3Ia3lCH/PgPaPDEZeSqUzYru8rNM+LD/N1HdCjZ+kUrItToOeYWZLlC9qv4/XGQi/ET3dHbWvyOW6sqoHAf0Tb9YUE4q6AVaJad3XlROtOggQWxb8p5GgN7dEWJLOxf12VQArKE/Khv3F7oDwNImoG9732wuWzMB4NRHwA6+akKkbX5x+Ug/4+nTI8J9H3SkmGYi3v+w==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 12:41:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 12:41:59 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	petrm@nvidia.com,
	andrew+netdev@lunn.ch,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/3] mlxsw: Tell the core to use the netdev instance lock
Date: Wed,  8 Jul 2026 15:39:33 +0300
Message-ID: <20260708123933.1303291-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708123933.1303291-1-idosch@nvidia.com>
References: <20260708123933.1303291-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cb4e75-4345-4af7-3252-08dedcee4d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|56012099006|11063799006|5023799004|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g/lgcxtmor5ePhSpTGL1jpiB3jU1wFPxU25nyZGMqg4lp1mBLSgNQu6o99nFKSTpsPOAJZv5+ur+R7yG6lctOm7Y+ZHgRh+rd5r+/AQEYu2chvE0RZJzOvHlnafaBuZzhLdXZTk4ndrBC4sGfRNcLtXdBdOEMEVAemUDN5gLMmloOqoiCRfKmjE3n0A1S43vFMDofHmPtsE5pbGbPZ28gWsGbkEdjprqP1bNiHJSAYy1EPZ47i5UwhbamNumwzBIprJteLtIEqUgACLGas0XKE+dH64bFwcVt4Lyrsgf9sTYxlTIetkat/G0/XaXSMykLicY74om56X00r4KebbvJlRMa7EibT5gJJU5HYnySrOEBm4GVSaldDbpQn1hP8pFcXcUszfqto4feHQOJ7+ybRFVu8MgIra2SJ7CUutCGY+V9H6VDYh3GfB+c7Y478tt47vlMe9sFu1/OEPz25Pl4j2DaIdjfYBZ/HYlOHzc9e5fQW3pMdGkNt441pAxbgL1nhPs2wm0cQFQmCR8QDbzJNtykb3FFaUhTehXztV9iR6QUtdLtbM8TU9W951GTwWId+mFpeodlggmM/vBdUxtuSrLX6996rXUyU+t+5wyvqsU5o+kTP4ejQ2z2vgInwkDta8w1ppEtE4y0VT0zIBd0D2zu9lkWXPFIFIalMMvgfE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(5023799004)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sFbfrBbew//f0zr9Qw/pX5cipsr+iSAhKSSZEJjZTblxI9R22JycoWqRHcLn?=
 =?us-ascii?Q?7bmU0ZpFjjKhrALr+Yu5N/L7B6n72dV6WmgZIbcM5vlU8hk0fKdH4a973Iu9?=
 =?us-ascii?Q?P0klgdgyBozzLigG0jHT3wV/r44JsQMp5dZcPKKcCXWcHYv+JECplMywkyTy?=
 =?us-ascii?Q?wU3OxyY5dIDyVQk+OMZmF1Cb8n45wdTl6MQYusRe97Bv1FQBz4K2MQ25Ztel?=
 =?us-ascii?Q?cCBukBCC6nsRprKlv5AsqIVFs8Xalh9hZFc7x2cz0xZ4MA/CKlJeecs6dfZI?=
 =?us-ascii?Q?NfDW6cp2p0Z70YA9DPkuBTrmVUVFdIsUmRMPbWU0A6Yf3NQNbbzcZbXjc5rd?=
 =?us-ascii?Q?8OkVb+naCrJxJfdY/jN0stRgsjuGCD2ICFizasEj18tpvMtNnO90ZYK9TQ83?=
 =?us-ascii?Q?DdTiMDqj6mvSEUak55rgNJEVWVNTv/1ULlGLx001uo1pODM9Ck5VN6sfbYnI?=
 =?us-ascii?Q?ptRmSb/UmLrnfrxzzv7nhrx7oE+qJlP8qT2p+4tUDy+Wrwq2wDj4FiPMKEb8?=
 =?us-ascii?Q?x8mTNCsI8H5ZbF6Ts+AR8l+aOrKHGznlHxtkIibhOTQTKx5mVsEPDxUy9BSh?=
 =?us-ascii?Q?qV7MfCFxDrOh/yaWfwoN1oAj+wlaUEtNXbKeX2azw+a2sfoeSjhfCdrMhI5u?=
 =?us-ascii?Q?XJp9zhk3Yg+hq8yz+DELVT4XMLSd6OLPEbea8asOl+GMtsvVnyQqMUos4Dca?=
 =?us-ascii?Q?jPYhJVsNuxpTE3/05nLLLrG7UohfG3rc2IOigGthE7/bIJQl8qLNEcjAYVdn?=
 =?us-ascii?Q?3ni0vm1sx84ww0/nyJpKnffzK/lj1LuKuJPV0VjQk+4f6Yi38CZP7fxq8L3S?=
 =?us-ascii?Q?+S5joDW8Ju8COcENLka6uRgbbfB6PZ6L0pqJ+8tSX5Er7XzwEBVEk7O1MxnE?=
 =?us-ascii?Q?0+B7ZahnU0oxGOBXBJ61/QfK/vh5S12GmkIEnUUO0zGAToWS47sCESzrp8mE?=
 =?us-ascii?Q?INUXaDz7vsJJMbx8P3YSn+BbmSj+P0CJ0GsX1Q5g2XF+NQmdx8qL95gdZuzf?=
 =?us-ascii?Q?oJPgfEEu/YdZZ/0FnFm0ebnrRtkdGfiDAh39xwmUKp+lUI9MENWNr8FTEOBg?=
 =?us-ascii?Q?sOdyvqwrxWDtPi97BYoYJsv9kbPxfSoQh7yQ9JfMGY238CetTTz9eXUgFVDO?=
 =?us-ascii?Q?Sf6+V54adgA22tAJvVpjsA4+Cb497EdsRbdzQLBTBx+UaAtFtl438RjmXVhL?=
 =?us-ascii?Q?Kjodi4Vgwf4i34LYa2yW1MVBjAGcUJTkFlnYqIHxsJBFtNrWK7dTjZXkO9KV?=
 =?us-ascii?Q?NJZYc64WU+zWVhNOXmI0GkFBV2vhXrxPWfa5un6ebXOfKIfDWoO1aMKHb+OV?=
 =?us-ascii?Q?l8g8JuWwZjFeO7ptP5Yq9cCNiBc6zRnsccYg5I61572rY1sGHIXhae+RynQN?=
 =?us-ascii?Q?ndPONKVOOjgce3dnVjxseckZ6pEVv1raw3LT2qfy7Tc/cMIMmvnH7Ga9krAO?=
 =?us-ascii?Q?pRxxdoVUUjiLTL/aIasEDpTYsL3rCCwyl7katvOXDetiM5GnaUu7sGlK/cRs?=
 =?us-ascii?Q?cvly+iPhe8dEv/iwsMWRqdUNCTrsnv3XyXC7z39nZe4b0pQpYh8ACXiYBEa9?=
 =?us-ascii?Q?gOsHVVPFK9ygM4SgPjdmisvqdzlDx09lj5aeL6nKEIOdUHKNZJaguP3EzZNe?=
 =?us-ascii?Q?CO+bCIaI8hpv7N/fMv+ceI8Gx3BmCMJ+YzLEU9m7Jmqkzg1XSYAYFRLea/6J?=
 =?us-ascii?Q?iPDJW3VtyooXGLmheJv+UUig/yQXQgb3cmigB5gYYhgwBEAx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cb4e75-4345-4af7-3252-08dedcee4d6d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 12:41:59.3662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqcWiecRUXmggkRAASwoSUEsgO+eZA+9RXUQZ1nsPjB/zOINoXhp4pA0BfVeGtSEvRGTUgZaeZ4AuGXGbWatNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:petrm@nvidia.com,m:andrew+netdev@lunn.ch,m:idosch@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305799-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9168726649

After the previous changes the driver is now ready to have its net
device and ethtool operations invoked with the netdev instance lock
held.

Tell the core about it by setting request_ops_lock to true.

Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 3ee1272dcf0e..815e8d8e3185 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1552,6 +1552,7 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
 	dev->vlan_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 	dev->lltx = true;
 	dev->netns_immutable = true;
+	dev->request_ops_lock = true;
 
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = MLXSW_PORT_MAX_MTU - MLXSW_PORT_ETH_FRAME_HDR;
-- 
2.54.0


