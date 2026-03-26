Return-Path: <netdev+bounces-271860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGvROlTSxGmw4AQAu9opvQ
	(envelope-from <netdev+bounces-271860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:29:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 730D432FD60
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48F79307A3B3
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29933B47C8;
	Thu, 26 Mar 2026 06:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d1Hwgg0c"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890ED3B27C8;
	Thu, 26 Mar 2026 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506462; cv=fail; b=MoUYaZj3m3jAeBr4n/Z6m548DcWozDouRybhoRekZ6GRphCv6EYFdVCcofls+FMoSs+lLoOjzTnOoP4zrdMH51SSIUtmR+vV9kAtDS+FIL4jFKeAspaA1WDXnzWFcgTq21NvyOwieGunhZE/hGXmjjmduKnr/8/7FwmoivXsqVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506462; c=relaxed/simple;
	bh=4dY/RIsND5H6IxeGiQKH9BqStNzCQGpeHGkddPgFjts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fTN6BBw7tvyO440qOvv4IkalRAxAGR7PHLWKg6bgd4m+DljaMjK59/XTSION8Ox9d3iUdYNiJb21ZZwnuFnlzjoV65XVkfJh76rwnCVCFb0XhpidvBlzyHJ+wURgM9bJkMnekxuaCF8tSjcUZv1XXwVXjtgj4lKf8ZdM4acM/EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d1Hwgg0c; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyZWvP2OJuhF6sc6XK9QQhpVuhGdoQTpD2C9rd7VPw5UFM7dp83b+rJJKv8C1uF4LDQ+0TUPgVl38q+SERxy/wJXkSrrvRJ7+HIuT/hY24Y5BEVrPdxS5og7guSZnfH5u/qc52zIX0TswyNiqcTSr+r2Oo8IvCETzlwHu+uj5TjmkzD8nPESWgWY2sjnexBzaGOrXUnegdfoEJ5knAvj5WP3VbHgN74eP8ZijL13LtGv7lZSb3Fs9o32LFReEtLBQRINHonSi8ecxj1u1VOT18jhjYlo598hJCKOfccXTzdyGKDhEbGSjr4xJ4ywPRpalUuvKzbmpOd5NekhpviegA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6mgr59tJm3s4tFqq9+ULHPFlVA8bF0hNcDnwHdNygc=;
 b=ob3G+i2fOA3QRkNihhY4V5SjFdXJio0zyQKvTyw7fWEut+znwe42EwjOZ3GEQqzuRv30k+AMHE+UQuLAGsa3+Lv4VAVRp1scpIwk6VfYXMpuSkWBP4e4ENUUmxSdnZD4p8KrTKPBCi8C/eHKRU9PRmKYLIDjbJIlUhlpSQFwBWqcrvAwAYkQt+trmPTCZlHPM7jf44FypKS+PHWb6Fhs5K73yJaSq+JNwTrmQYo//lVfNtZXTSm5JzvAPbjZomz6/nYvvPi/HoxZOH6fAX24+VuxCWWuRIX+9zYFqyh9KR1G6hRF7InqbmGGJQhPgK2eZyptVNFmRK/TZe+qeumdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6mgr59tJm3s4tFqq9+ULHPFlVA8bF0hNcDnwHdNygc=;
 b=d1Hwgg0c8XUOzkZ92tphhjqRTeJFqrxturPuU93zj0kWNZMuf9TOdn2CVMrk4GOtqtF6+eY44b+AbL+A3Y6ErH4hfcozP3tFNd2gOdkWgjn10BQacfaWSPhEgvvyTfkdrkvXHqUnt6LD+EP4UGtpULbVsypgmGnr21kmnEIdA8zxWWtGW4CFE1XNTAOxC1epz+1eo/duUs7bjipQ4bDc2X3QrrXoPMJ/rrnhLVtKryaIG94iMftSSEYgcfch4GdgfWWShfWpVjwE1llc3pkjEkS6903dQQA3goZDfFEL2BB/KaQ4isuyf6xulaMFMTYl+1zy+uLHb8fvuO4oCeG0dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10309.eurprd04.prod.outlook.com (2603:10a6:102:41f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 06:27:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:27:35 +0000
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
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 02/14] dt-bindings: net: dsa: add NETC switch
Date: Thu, 26 Mar 2026 14:29:05 +0800
Message-Id: <20260326062917.3552334-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326062917.3552334-1-wei.fang@nxp.com>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10309:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e89bec-8411-47cb-43db-08de8b00c4dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|52116014|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5yFYd2yeSde11ZHI40caph61q3O01V2y5rHwcfBvLFaGiLgO3q2ezBlqBt7Ipvd8o+X8aAZH/vDVsfN84v+Os7VWf3gJ1fXcLonNk/Li+7N/0Nvoov+cVWxK6albdJCiQzQJdtay3V1zPRDnth+BxFCPDoDgV4E+WnuEduvM3j18pdX2LYogX+LUQZtiVJgIzpU1aRC30jBPJPcQK0oGf5qaME7+lmM7QJIPgpHLqQl15Exo3gdHq7afXjfRpVXVuTq8aU1CRb4sxwJ6mJqYpWKM1bK4Nr92Qjfj1cNDtHY+edX/AsytI5baok0DyL7KscznY6VX8wzGAZ18Nu6FFA+OQmRpuW+kPzYAf40XHBVoXDT93tj9EqhZZjtgzWDgvQ1+inM9IkyvUeI1I1z7zrQLTZ2tFJ4C7FC7t8rwbLaHtQ8qrUHVW+0YxJWQk/AgR630ZXPN4F8YyTAGG5EDv+li50jcO1SOHAmY0Zqqdo+Vf4hgaXfIIlPE4oArzlCNASfGkou726sfK2P8wkgSeIhnlUb63rQnFQvr2aO5gcHiyyGFigOAzkuVKrr96aZpCPSj76vDRvAeP9fYY/DTY3zc9WrrXUknfhHu+0/2dcinmc94cPwa5EHMkj+224jDsfdFPy5+AwFyudy7NUSkVNMsjq0ZJ54YDZ6l7mbKZgziDRZGxPL+ySnO5P4wotz/XfU5ts72AmyKvWmJNRu5XX2TiWfriHwPW02yUrTcKKdKt2hQsoJ05kKMRgZ0tIxWT8IC/TaKWP/nxfvUWVYuCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(52116014)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xkC9RKtTdrueOu/2A53DJqdG75eOwFDUTOeSYhbwxY1bzULgE8QBEHv301am?=
 =?us-ascii?Q?PODY5MF9GVr0LPsstKAmQQx7o35UP8WfkzAaXxxchMS4Ykyar03Lt4RlS57H?=
 =?us-ascii?Q?D507uaIe3K6sP7dg41NNamQVcKnif77JOrATWTnOaAwA278kuNn9CLyeGzMn?=
 =?us-ascii?Q?fbw1cPIJ0pQnh423MZ4yycSLBnU+64QFryUqtVeXi7AP+B7h9gcTybtW2vwE?=
 =?us-ascii?Q?HnwN2Phe6UoAEjhI9EWIjcIl2/dw0Fpl6xOJ6qduwykFBO+hrFyRhVHWuNOA?=
 =?us-ascii?Q?Zu0jJ97CTjf6Y0oGKANqvUMstLorQ4jq6JXq3JgyKcQJYM6lXMLO1OdlxnPv?=
 =?us-ascii?Q?RguxdSq4TPLkbS3XJIQP0U9bDgAPkWl7Oh2I3eUqSIHcBtUWGot7RK3RLRIG?=
 =?us-ascii?Q?ZHB+Bj62q7lNoiGbIky4H4WeVMf/5zjs8EA5iehXDhGmo23MBof1LNZPlbZL?=
 =?us-ascii?Q?90rCsX7gDQxmtutLZjxxxhljtHSRgFMPQuApskva2yIfgYhfQ1cXglDayOkR?=
 =?us-ascii?Q?0zrGbIWbcfrYg3S8N0mQexZtAQez0odnp7lS+hiPovQng+wPWCmJMA9OU1fL?=
 =?us-ascii?Q?8iOm8pQ4yxOkj+WJtUiNfQkLKZkY0pfirRKTmJWkyB91xJjlRZd3W28WgEaY?=
 =?us-ascii?Q?uegWb+eOd/VC4roUwCgFJFM2YsHrmwNLD3SXZlUspMTW8eG9r/xewGPfoXAU?=
 =?us-ascii?Q?r2CpILfQFBRecDUTOO+o1r9Xogb/7FcHKi/+FNH3YnBvIHl3XzKtXh3o1eiM?=
 =?us-ascii?Q?pxKYfyIqC3TqXuQoJSPYmKFYcSiDGrRxolrFH0tLNlO6OBg+3ooJM4O33ms6?=
 =?us-ascii?Q?11Gk2BY8CyrvzPi50mUkNAqQj2coiGXRkWXc+8H4XRxBUv6D4oG184uw49e3?=
 =?us-ascii?Q?himrlv0MYvtbJ2PsPQBxsm8zEUfF7DmTWMoi1HbDihQKOl4Yj6gW1+xrgl+L?=
 =?us-ascii?Q?WOPg8iV9clYCRj410Kpx5z2HpK52ZlYA8FEw20gr9I9uev3kxTTFIuPegr8d?=
 =?us-ascii?Q?jiM85ErWJ8HAjtHTufsq6ZauzCMfziMzC35gpFe2DxA2VvwAvekxitH5bQ4p?=
 =?us-ascii?Q?jS7byqYf1sHUT2V7pDZBScMm4eVgk59MojX2CSE3A+EUvARt5t1IhQpNDsNw?=
 =?us-ascii?Q?E07ZKBAo1TY432lFtX3z+lT4Bd6xG5JEns858dU2R349WUTCF0DDV9qgslyl?=
 =?us-ascii?Q?pnYnbb6qt8OG1peu/honU+gb0aHESw7VFO0/h56pF29RXDGHMOUz0l/Mwc9d?=
 =?us-ascii?Q?bm8c3e3B6Cc/dQkttj4Smc/v0yFuhH4KOJAp6CoMr1j4oZzJ9tZQm64zLYxf?=
 =?us-ascii?Q?BaqGt7nX0iKP9JgEKsUpp04kNu6bzYgcTffocVMBeJFf4bhaAvKPcV+4uh/a?=
 =?us-ascii?Q?lw+ZHi4PCHo8vUT5gfH7U3yloM0lFPfkkHFSV+j/Zdwp8Q3lvao6YVpu5HHA?=
 =?us-ascii?Q?V52D8R65aSBTQB7dmDz2REezmEx4Q7Pjzj2C1I4X2f1Xb2G9SSgj/OK+ibcv?=
 =?us-ascii?Q?dOe4tyNQrmZ+wLvyd/CD7nkvnKwO86CZMv3ZqnjEEUStjFE3TpJxXYNSanGK?=
 =?us-ascii?Q?cq3Zkt+UU63qozEbBrECvSsXgcOjWA8oeVPmpySzNiZlRwzcCIf5ZptKh9DB?=
 =?us-ascii?Q?Mv7iFNnV2mSRRG803Bp3pUDNR+tjTuHpsvHxX/mHI2wmCEPRWfRr7xl5LTA/?=
 =?us-ascii?Q?OzQ157u9KC1r89wnFAaHL/9pXHe/KpeE4Ph55oqIRDBdZewM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e89bec-8411-47cb-43db-08de8b00c4dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:27:35.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9ht5g7/9PJeuAUv5bjDnNGDefHEDfEtHxmnef+SDbr0I6yI91BjZSPQvr+TJuEGgwy8IW+OVb9qmHKKP22tdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10309
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271860-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,devicetree.org:url,0.0.0.3:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.1:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,0.0.0.2:email]
X-Rspamd-Queue-Id: 730D432FD60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings for NETC switch. This switch is a PCIe function of NETC IP,
it supports advanced QoS with 8 traffic classes and 4 drop resilience
levels, and a full range of  TSN standards capabilities. The switch CPU
port connects to an internal ENETC port, which is also a PCIe function
of NETC IP. So these two ports use a light-weight "pseudo MAC" instead
of a back-to-back MAC, because the "pseudo MAC" provides the delineation
between switch and ENETC, this translates to lower power (less logic and
memory) and lower delay (as there is no serialization delay across this
link).

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../bindings/net/dsa/nxp,netc-switch.yaml     | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
new file mode 100644
index 000000000000..e34a4e3504c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/nxp,netc-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NETC Switch family
+
+description:
+  The NETC presents itself as a multi-function PCIe Root Complex Integrated
+  Endpoint (RCiEP) and provides full 802.1Q Ethernet switch functionality,
+  advanced QoS with 8 traffic classes and 4 drop resilience levels, and a
+  full range of TSN standards capabilities.
+
+  The CPU port of the switch connects to an internal ENETC. The switch and
+  the internal ENETC are fully integrated into the NETC IP, a back-to-back
+  MAC is not required. Instead, a light-weight "pseudo MAC" provides the
+  delineation between the switch and ENETC. This translates to lower power
+  (less logic and memory) and lower delay (as there is no serialization
+  delay across this link).
+
+maintainers:
+  - Wei Fang <wei.fang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - pci1131,eef2
+
+  reg:
+    maxItems: 1
+
+  dsa,member:
+    description:
+      The property indicates DSA cluster and switch index. For NETC switch,
+      the valid range of the switch index is 1 ~ 7, the index is reflected
+      in the switch tag as an indication of the switch ID where the frame
+      originated. The value 0 is reserved for ENETC VEPA switch, whose ID
+      is hardwired to zero.
+
+$ref: dsa.yaml#
+
+patternProperties:
+  "^(ethernet-)?ports$":
+    type: object
+    additionalProperties: true
+    patternProperties:
+      "^(ethernet-)?port@[0-9a-f]$":
+        type: object
+
+        $ref: dsa-port.yaml#
+
+        properties:
+          clocks:
+            items:
+              - description: MAC transmit/receive reference clock.
+
+          clock-names:
+            items:
+              - const: ref
+
+          mdio:
+            $ref: /schemas/net/mdio.yaml#
+            unevaluatedProperties: false
+            description:
+              Optional child node for switch port, otherwise use NETC EMDIO.
+
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - dsa,member
+
+allOf:
+  - $ref: /schemas/pci/pci-device.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        ethernet-switch@0,2 {
+            compatible = "pci1131,eef2";
+            reg = <0x200 0 0 0 0>;
+            dsa,member = <0 1>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_switch>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    phy-handle = <&ethphy0>;
+                    phy-mode = "mii";
+                };
+
+                port@1 {
+                    reg = <1>;
+                    phy-handle = <&ethphy1>;
+                    phy-mode = "mii";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    clocks = <&scmi_clk 103>;
+                    clock-names = "ref";
+                    phy-handle = <&ethphy2>;
+                    phy-mode = "rgmii-id";
+                };
+
+                port@3 {
+                    reg = <3>;
+                    ethernet = <&enetc3>;
+                    phy-mode = "internal";
+
+                    fixed-link {
+                        speed = <2500>;
+                        full-duplex;
+                        pause;
+                    };
+                };
+            };
+        };
+    };
-- 
2.34.1


