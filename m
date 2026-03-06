Return-Path: <netdev+bounces-264676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJquOVRoqmlOQwEAu9opvQ
	(envelope-from <netdev+bounces-264676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:38:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E9221BC2A
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A379F302F713
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 05:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C090368284;
	Fri,  6 Mar 2026 05:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YHQeD9se"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF0347FFA;
	Fri,  6 Mar 2026 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775502; cv=fail; b=ML6tTt3belJ8ckmPWOuWpJjAuHaRFkm5QJrlGBOdEZflBxba/9YtQs/3TKZPCgUEU1YijuA6iTrY9tk8ATu7bfQKalmaex8qaYu9aA0oG1/0T7yovJM+jM9Zo4lpQkiAz25ghqv5e4LmlC0w0fpNmx3IpxCRQfQjh9h4h9cRHds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775502; c=relaxed/simple;
	bh=C2sV0tADHnlwXtVNV+G4JBvuCtmH+9KjAeFbFc1ubxk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=slMirplpBpeNb6CqhbNiL8y3GgknFj6gLJBGA0aaSDXrGH7OCGFiK1r49+KG4cMzi8KTPBqQ+TfGrF9a413Ti3skC+20xbIre39zCPjmDaf3EE4g3896T8RyeS3QhGOm0FClOZpzKNWho1aLrRG1LaKf9rlt5xzWOLxKBX9UYbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YHQeD9se; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpiqDJqVxPZC5svFeiIY+87wtJVGm/EmNkqC5NTKeTZoRV+QrEtfK55NBoCJqJt7RvxR/8Tc6QwB492hvwmGfTUlIoiGjNTD+XJwpKP8uDHqF6IiXEvwRa2YorIWKxW0FirSgj8alYJvly67DVlG5Hk6m1HrWfdIorkUlMfp+XQCNbEZs6RKn50MXeS5LhQci4Wjn68ZwEjXj/EJdgn4AFBWqx+T+QV7IZUaQ3Tubl8WLdDWadW+2dyUM85CvLuJorvtBWaatVNLo5rPWgyr0+OEEFqaz4mFXiirIbVomKMlm3lpgcGv2JXAbVhxvpOLOO61kkspB1oRQ21b0KVkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEbQfkbjIWlrm8aO9mg4sMt1dphA/fYm0r8FDR25nZc=;
 b=uQElaKl9iRrgaC5YBw6id/sGznzH8Wop08E+k87V7luG6OWqD29OCwd2seqeTvHAS02/r2mMD0Nr7KIM/yINEpp6c4HXEFcoRnIJhXl1XMpABY94jxbmsg6oqBRrW6vMR7uo+lhJt47fS+odRDeEJh6BzMH8I+eksi8lhHx+qC2ws2iZ8GUWvpnUz8CWoaJN3Zm/qDhBzShGY8xLCOVrYo47VS9PdMjtoEubZxixBDY/ECOs8peBZOwx8bI/f3uQkzT3BjF49VnWQgCViaTXjf6flze2Lyf6sLgx/OP+VF7XukJ0nGUAr78I9K/YWsbNEuNZwy0RlF/8E8BznFhz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEbQfkbjIWlrm8aO9mg4sMt1dphA/fYm0r8FDR25nZc=;
 b=YHQeD9sesI68wqfYaXARxS5iVUSgEaq4kHYYXjivlNaWXM+5UlDJ+LpPX8I8+BM/nZmWN88Jsnu4ioS+1DveYVsjcOqKxQoQvxrAfihOYGnPW/Czcnln9lYCpjLbb6R/1cZr/+teOPosV9+h2/r+HbaabvzS+f5gwoBv7AoLgB+tWjVdSRqsH20sXfzhTDWan9MraX85VaqOTAtmaT9RfvCRieFeEHVmfiZ4AQiFdZM9LA9YYiDWNmoVNI/rqCy+2eYinzxJ2c0pat75jfDAnwM0/7O0GGueIUL/92FmI6m6cHOcALiYrJtOLsHUYwn/gi54FHV3TqB6Pl30Val7+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV2PR04MB11590.eurprd04.prod.outlook.com (2603:10a6:150:2c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 05:38:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 05:38:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Frank.Li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net] net: enetc: safely reinitialize TX BD ring when it has unsent frames
Date: Fri,  6 Mar 2026 13:40:02 +0800
Message-Id: <20260306054002.2208360-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV2PR04MB11590:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7f11bf-cfd2-42db-f916-08de7b429054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	T83ycZx9msjP3fP9mHqijmr00kgvnx0snOuxFQ/u/1wGDsQjfQIW3K/z2KjrJD3niFitmnZ0DlQh93SdsNNlqvZFy/8Mkr0xviy62SMTx4dYn7D68C6/J1fEh/qDp0KwbPvPEVb4jiCjt8sSlrD+jE3QcQ3MG9uHinTJuaOcUY8g4VpQJhdUM3X6Km1TbcSRL5jv6QB1u108g6OwdHZrAXwUlTFFrpoueoidpg/tgTWZePbuOEK1qa+AwIEau8SbTcYlKLnhC0cjdecW3KXJeAjjHlZsPRYS7jbt+6eQPIzNGEPGKSXy3H9KSF9Pu1G12DrYsgSQKdMzGpkpj3eSjoXKgLHy0aeYQu0jjOSttoK32MgZxq0mwbsKCSlAxlLOIWUh/o0DPqHLEuSW27fFki/Yh7b/AaUeWD5BWn6CW1fTLVP8v51bpgI5aFIewIgTxx/W/mqjdM9i57iJQN7ZSjbo/740WNW8izT4SSc2qwFx/sDCbtLMXqZ8O89RWOvEJRPPlHy4mSd8vUGcYKAmuY9DEm3BRpyEyjyt2LtkJywXs6d3DsFooCKagrezW7AzLM+4GpX0e4bOaitAVfkiCUe3EiIZOiQ/TOwlFIJK2g03ceuk2RhEHHRoGtgSwagO4vbCdpwBXnqunpOPIH1iL5uv+c7TwUDcqq3+jnYm1CZyJGtgZdEG/vPBmuJAEV1D3tW+sA63g9ALoTPfyCEFmSgOXfSBqqNf8EcqWwKFpD3b+th4zC/0LSceFJooVv1t/G0A1LBoDM4gtErDvTWEmsR5HrNrN07BDzE3ND/f8VHZ2ntqiAAr7mWhjO4uUcQN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c8LRlpTg4NLSs93IaSaxHPVHOE5UH9IHpz6v/2oKqPWwV23i8D6DSQ13sIKQ?=
 =?us-ascii?Q?BqFMg9wopwJEhzSOQCBZQ+H7x9uZIgee+G/2JWL8CrjStmnVhGIeN57yumCN?=
 =?us-ascii?Q?tNg8NDwZanKhGBM70r2Z+DGArGfYbLogXtpiXw9t8xlQeXwtpPLKi9uv1ror?=
 =?us-ascii?Q?vyDvWPn+yWhaf+ZeDN5uSbxMCV4kZB75aKNJWSrUic5kIlTbkjyk+lhlXZ/e?=
 =?us-ascii?Q?O/0RSuhOpsZB9OmXGJ/FNWL/t5qdMHHH+LeNqO3LjWMz68fhj4jk5/8Ng9WS?=
 =?us-ascii?Q?jbYwBmuTMhFmryoVlmeUuZ4NoysMJVtrmCUlGfRvLdNIjXphC/F2UXAW/pq4?=
 =?us-ascii?Q?giW+P2ON92YS82wuQ6kP2vej2AlNleijgS2o8TgMekjFjMZUmlanxRF/74rN?=
 =?us-ascii?Q?i5tZ9BXxX60S1Bfx+TWZbEIqZFH1JnVVxLx/kEpQF563XJ7N3fZeOR9MWYcm?=
 =?us-ascii?Q?Ncm43krILHC2Dd5fJAtt1gFIYEIWiaOB1j3o8+RzfuxHjU17NUhJQzat6Bew?=
 =?us-ascii?Q?kaVEHiKHvXRPTHJDL1qpBEXrSBdh1kvm24yJ02LEdJ41/v32o4NIxzyfppGr?=
 =?us-ascii?Q?XghYEEvzQhLGM2NT44GxocN2YcyIuoZN2K/fUuE3EpFrSaJC53jU8kF4AGkr?=
 =?us-ascii?Q?1OKoiYyCgjWTJiE+V7kq9id7pm9NzPdsfg8ZD8LKktVlv2Y3Hj00D5WrDZiP?=
 =?us-ascii?Q?vgaFZxY+SdMPMrvPItEiWkXMMho/9vhdiaHKL985Y22hJNIi7j6yaOEq/iuN?=
 =?us-ascii?Q?pS5zB1gdXB3Z/1YnzoDVqHwCuzXOm6egqSs8op6rPOjrPUXtuLLGOZUydIQK?=
 =?us-ascii?Q?oON6RdP+Ml+s/QAIBTvIunulqZI/WZqinJ3D4F9UVIZexJJd8py/0t0w5NLi?=
 =?us-ascii?Q?n7fmnfNVkhl2wL00isUVyITqzf5fVupl9NuFPdhdF17o+lsGMGUjxYyp6w/z?=
 =?us-ascii?Q?+g8Ie86VW53ZkGTCBsAfYuBuIdun5H/8W731gpe/k9ZqTEqBYobjAhj6G7PZ?=
 =?us-ascii?Q?Bs3nApIanucLsmHOZBY5AKg74xz5DzXYZYlJGajU4hE5B7eBLu+Jbcm29b9v?=
 =?us-ascii?Q?aoH7oyg66NZWRASXOCH/sRvEQZGMYiz+3QFfsVROOPDWSXdz63WwTIpGo0P4?=
 =?us-ascii?Q?tRIH792wsZNvPTOIplfZnAlPkkSFT3RGQvnYdNXZGpVHIo8PcuvzN5TDBwWA?=
 =?us-ascii?Q?GlfEZLelKg5ujf/ctHU9X9nw/KxuYfgD1EbwBjUCit66OvP55H4kHRqKTQLM?=
 =?us-ascii?Q?GC0mtovsI2x097Tbzz+iRGiRBw+24pCvvgYRyGjEZX4+pP/c41nQNeYz/hkb?=
 =?us-ascii?Q?PZZBobsQqsz2mMZy+c53If9h1TVEt65zKjsumeo3ZWNcmaETPdP8Ep31cdY/?=
 =?us-ascii?Q?DRRuoUVf2sM+WcJMZStf14m6jkkzLq+z5MnUYvHxfwuwG+Qxit03F/rph+RV?=
 =?us-ascii?Q?tujGf1ux59apzNDXmtZr+HyzphXbDGwy03yYBSIiqn/Z0/5JDA0yD1SLbZzd?=
 =?us-ascii?Q?0Fd9q1sIRoZbPxb7Lav0B+wc75zusjVaJacHhRNxA+bjTzeEMcee08RulqNS?=
 =?us-ascii?Q?uP6FS3YGxL4x2w1L8USMGndseV2pIQ2fs5BLusVPNGXiDmGTxnZaY8oQx9of?=
 =?us-ascii?Q?LmBuPKJtq8ZqMFKcMLefJlIIBT0L27ELQHjGGHTGlKWiBDv6gbONHZWFNuAR?=
 =?us-ascii?Q?RYPaCxYkSzXnHpSo7U2chZdYyKPg4ISlxZPxf1mztA1lj4l+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7f11bf-cfd2-42db-f916-08de7b429054
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 05:38:15.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWuZz2FaW8HRv2B4ld4tUzqgXvuuaBygpRVkVrNX/A75/P4+rjmFcBdT5UvwT1LGHMl6jBxtg3qAIvB2c7vLIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11590
X-Rspamd-Queue-Id: 39E9221BC2A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264676-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Currently the driver does not reset the producer index register (PIR) and
consumer index register (CIR) when initializing a TX BD ring. The driver
only reads the PIR and CIR and initializes the software indexes. If the
TX BD ring is reinitialized when it still contains unsent frames, its PIR
and CIR will not be equal after the reinitialization. However, the BDs
between CIR and PIR have been freed and become invalid and this can lead
to a hardware malfunction, causing the TX BD ring will not work perperly.

Since the PIR and CIR are sofeware-configurable on ENETC v4. Therefore,
the driver must reset them if they are not equal when reinitializing
the TX BD ring.

However, resetting the PIR and CIR alone is insufficient, it cannot
completely solve the problem. When a link-down event occurs while the
the TX BD ring is transmitting frames, subsequent reinitialization of
the TX BD ring may cause it to malfunction. For example, the following
steps may reproduce the problem (not 100% reproducible).

1. Unplug the cable when the TX BD ring is busy transmitting frames.
2. Disable the network interface (ifconfig eth0 down).
3. Re-enable the network interface (ifconfig eth0 up).
4. Plug in the cable, the TX BD ring may fail to transmit packets.

When the link-down event occurs, enetc4_pl_mac_link_down() only clears
PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It doesn't
set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, reinitializing
the TX BD ring at this point is unsafe. To safely reinitialize the TX BD
ring after a link-down event, we checked with the NETC IP team, a proper
Ethernet MAC graceful stop is necessary. Therefore, add the Ethernet MAC
graceful stop to the link-down event handler enetc4_pl_mac_link_down().

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  |   9 ++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 126 ++++++++++++++++--
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   2 +
 4 files changed, 134 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 70768392912c..825a5d1f2965 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2578,6 +2578,7 @@ EXPORT_SYMBOL_GPL(enetc_free_si_resources);
 
 static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 {
+	struct enetc_si *si = container_of(hw, struct enetc_si, hw);
 	int idx = tx_ring->index;
 	u32 tbmr;
 
@@ -2595,6 +2596,14 @@ static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 	tx_ring->next_to_use = enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
 	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
 
+	if (tx_ring->next_to_use != tx_ring->next_to_clean &&
+	    !is_enetc_rev1(si)) {
+		tx_ring->next_to_use = 0;
+		tx_ring->next_to_clean = 0;
+		enetc_txbdr_wr(hw, idx, ENETC_TBPIR, 0);
+		enetc_txbdr_wr(hw, idx, ENETC_TBCIR, 0);
+	}
+
 	/* enable Tx ints by setting pkt thr to 1 */
 	enetc_txbdr_wr(hw, idx, ENETC_TBICR0, ENETC_TBICR0_ICEN | 0x1);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 3ed0f7a02767..1ce6551e186c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -134,6 +134,12 @@
 
 /* Port operational register */
 #define ENETC4_POR			0x4100
+#define  POR_TXDIS			BIT(0)
+#define  POR_RXDIS			BIT(1)
+
+/* Port status register */
+#define ENETC4_PSR			0x4100
+#define  PSR_RX_BUSY			BIT(1)
 
 /* Port traffic class a transmit maximum SDU register */
 #define ENETC4_PTCTMSDUR(a)		((a) * 0x20 + 0x4208)
@@ -173,6 +179,11 @@
 /* Port internal MDIO base address, use to access PCS */
 #define ENETC4_PM_IMDIO_BASE		0x5030
 
+/* Port MAC 0/1 Interrupt Event Register */
+#define ENETC4_PM_IEVENT(mac)		(0x5040 + (mac) * 0x400)
+#define  PM_IEVENT_TX_EMPTY		BIT(5)
+#define  PM_IEVENT_RX_EMPTY		BIT(6)
+
 /* Port MAC 0/1 Pause Quanta Register */
 #define ENETC4_PM_PAUSE_QUANTA(mac)	(0x5054 + (mac) * 0x400)
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 689b9f13c5eb..b6dc4a78b42f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -444,20 +444,11 @@ static void enetc4_set_trx_frame_size(struct enetc_pf *pf)
 	enetc4_pf_reset_tc_msdu(&si->hw);
 }
 
-static void enetc4_enable_trx(struct enetc_pf *pf)
-{
-	struct enetc_hw *hw = &pf->si->hw;
-
-	/* Enable port transmit/receive */
-	enetc_port_wr(hw, ENETC4_POR, 0);
-}
-
 static void enetc4_configure_port(struct enetc_pf *pf)
 {
 	enetc4_configure_port_si(pf);
 	enetc4_set_trx_frame_size(pf);
 	enetc_set_default_rss_key(pf);
-	enetc4_enable_trx(pf);
 }
 
 static int enetc4_init_ntmp_user(struct enetc_si *si)
@@ -801,15 +792,120 @@ static void enetc4_set_tx_pause(struct enetc_pf *pf, int num_rxbdr, bool tx_paus
 	enetc_port_wr(hw, ENETC4_PPAUOFFTR, pause_off_thresh);
 }
 
-static void enetc4_enable_mac(struct enetc_pf *pf, bool en)
+static void enetc4_mac_wait_tx_empty(struct enetc_si *si, int mac)
+{
+	u32 timeout = 0;
+
+	while (!(enetc_port_rd(&si->hw, ENETC4_PM_IEVENT(mac)) &
+		 PM_IEVENT_TX_EMPTY)) {
+		if (timeout >= 100) {
+			dev_warn(&si->pdev->dev,
+				 "MAC %d TX is not empty\n", mac);
+			break;
+		}
+
+		usleep_range(100, 110);
+		timeout++;
+	}
+}
+
+static void enetc4_mac_tx_graceful_stop(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val |= POR_TXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+
+	enetc4_mac_wait_tx_empty(si, 0);
+	if (si->hw_features & ENETC_SI_F_QBU)
+		enetc4_mac_wait_tx_empty(si, 1);
+
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val &= ~PM_CMD_CFG_TX_EN;
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
+static void enetc4_mac_tx_enable(struct enetc_pf *pf)
 {
+	struct enetc_hw *hw = &pf->si->hw;
 	struct enetc_si *si = pf->si;
 	u32 val;
 
 	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
-	val &= ~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
-	val |= en ? (PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN) : 0;
+	val |= PM_CMD_CFG_TX_EN;
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val &= ~POR_TXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+}
 
+static void enetc4_mac_wait_rx_empty(struct enetc_si *si, int mac)
+{
+	u32 timeout = 0;
+
+	while (!(enetc_port_rd(&si->hw, ENETC4_PM_IEVENT(mac)) &
+		 PM_IEVENT_RX_EMPTY)) {
+		if (timeout >= 100) {
+			dev_warn(&si->pdev->dev,
+				 "MAC %d RX is not empty\n", mac);
+			break;
+		};
+
+		usleep_range(100, 110);
+		timeout++;
+	}
+}
+
+static void enetc4_mac_rx_graceful_stop(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 timeout = 0;
+	u32 val;
+
+	if (si->hw_features & ENETC_SI_F_QBU) {
+		val = enetc_port_rd(hw, ENETC4_PM_CMD_CFG(1));
+		val &= ~PM_CMD_CFG_RX_EN;
+		enetc_port_wr(hw, ENETC4_PM_CMD_CFG(1), val);
+		enetc4_mac_wait_rx_empty(si, 1);
+	}
+
+	val = enetc_port_rd(hw, ENETC4_PM_CMD_CFG(0));
+	val &= ~PM_CMD_CFG_RX_EN;
+	enetc_port_wr(hw, ENETC4_PM_CMD_CFG(0), val);
+	enetc4_mac_wait_rx_empty(si, 0);
+
+	while (enetc_port_rd(hw, ENETC4_PSR) & PSR_RX_BUSY) {
+		if (timeout >= 100) {
+			dev_warn(&si->pdev->dev, "Port RX busy\n");
+			break;
+		}
+
+		usleep_range(100, 110);
+		timeout++;
+	}
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val |= POR_RXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+}
+
+static void enetc4_mac_rx_enable(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val &= ~POR_RXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val |= PM_CMD_CFG_RX_EN;
 	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
 }
 
@@ -853,7 +949,8 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	enetc4_set_hd_flow_control(pf, hd_fc);
 	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
 	enetc4_set_rx_pause(pf, rx_pause);
-	enetc4_enable_mac(pf, true);
+	enetc4_mac_tx_enable(pf);
+	enetc4_mac_rx_enable(pf);
 }
 
 static void enetc4_pl_mac_link_down(struct phylink_config *config,
@@ -862,7 +959,8 @@ static void enetc4_pl_mac_link_down(struct phylink_config *config,
 {
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
 
-	enetc4_enable_mac(pf, false);
+	enetc4_mac_rx_graceful_stop(pf);
+	enetc4_mac_tx_graceful_stop(pf);
 }
 
 static const struct phylink_mac_ops enetc_pl_mac_ops = {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 662e4fbafb74..c0e6d894150d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -20,6 +20,8 @@
 #define ENETC_SIMR	0
 #define ENETC_SIMR_EN	BIT(31)
 #define ENETC_SIMR_RSSE	BIT(0)
+#define ENETC_SISR	4
+#define  SISR_TX_BUSY	BIT(0)
 #define ENETC_SICTR0	0x18
 #define ENETC_SICTR1	0x1c
 #define ENETC_SIPCAPR0	0x20
-- 
2.34.1


