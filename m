Return-Path: <netdev+bounces-266971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDulOeqMsmkQNgAAu9opvQ
	(envelope-from <netdev+bounces-266971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:52:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E26E26FE54
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA5F93010B7A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318DD37D111;
	Thu, 12 Mar 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m4ofPOI6"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288723EAB0;
	Thu, 12 Mar 2026 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309159; cv=fail; b=bncVBvBGqwXa8doiImv1O7crot1k5gc2lMdaqSCeauCSwrrIEWN32Zdg3m0rEgzBdP5Zw83y98LJ0vd8YMZhTTPiWmgwdc8KiEgzGCJVVRGQcrikmneG1RXfP2E5TEl51LXrG+qNUzPO6CJS0dSFGe2TMx3IA7cfEe0V04P63bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309159; c=relaxed/simple;
	bh=DfhV8ck8NvEaoCYf7KT/AMaYLj5cCnjwGlBtkJ182oo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Klo5fK+R0RK0r3jk8bVHFwfFaPCG9LREg4FYvQe+AbIhfMBQPdgbR0KOxavOPBwDZiGSlH46U7xhrolfh9ay7dj+rSX/aaazDMyMsZK+8xRdhKT73nBOHRIgtwxiUkRCXNUBvSOAVwFd5pvXWjldCL7fAZd6sgMcgqcugZ9q++o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m4ofPOI6; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+MwMhWc2pslkN4rzDCsBxx8WKbI5FZb8BJgsfp05lvElzt9z1SjRmof0ILavsvxhvrxn/byJErlDPEAS+nDHfe4onztyotLcp2Q3IEXth1cu+noidPWTW8MZ7/qPSmYWjihEr1RICfN82NyXUD/5FkzZy00idVdkBTtoBXH6vF7INgHV30IgeECHSiKylIyxSliXTCwgRYcJnpiKtmx0N1BNOqlj1xFzxGIigsdSaW9/+Z7mHjvSSWu7EcBoJGhS/3EoFn8745GUtBVcufpyLAngeU6h53tZo+7fSIy0QTXPKUODqz6zSWqeOcnuI6U9jaG8j5fXzcsvS5UQgTfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4XaoBsl5AXesCc/VSmNPknOCyasTUonJ8IA0TAkEEQ=;
 b=JkGk7lbp/xaPqfPxgBT8/K8NPq0TxqI5pQm834A0DXHaVLqjzRSVLS/LQFwDf8qVn8D3x2xzhP2q16h9IdLmP2xivkYxqsgOcOq+5Fw+meh7y5dwEHzpUSSu4/qZZvJSlVkDqPg1n+ZJhr4QpNELdkWpPDe90Y1o/wSe5vVHi2OQH2/QnvfO9EDGyDL/zH2CNmCB3w4kQEeUhyqHxwqSu8+W8dj0LYmr4XDRgkGRQY30YQlrSpqhFUtRBeYwDHSz7UBqXz+ZuV5vzDMf8scOO4LFlrUhoh9YSfTxXaMVPPMzVQx9zeSIPPpgxpneLdcsFv2P8RdX3zEhFk4SZaO2XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4XaoBsl5AXesCc/VSmNPknOCyasTUonJ8IA0TAkEEQ=;
 b=m4ofPOI6M+3YRanSQ3mC3jjNroXqrI8bXLgTyS99bitOY/2o0R4TKxOKffePUe3750GBBCcPFSnBdu9mMQQkgXgrM7f1AUPo+oLwOyQnW+iNZCUlWr3xcYY3+Pj5xetmLQTtlFlNlB95PZnJ2HEY8m5yWm6Q++ytFW3iQ7st3Pmjxvu7sle+LAXvSynCuQvNLXc5MPia7dQONbLxg5trePTOn8b+vcA87UiWU3UMRIm/Lfws/qxOxjqL4v1pAxkvFOMJU9LHC76F70Vk/tsCWUDnSl7NJACfLLgnM7ATvIQlUNyFd75ZBdFmAHfNSyvswgTFHli7jTNIHbN9r/QqmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by AM9PR04MB9014.eurprd04.prod.outlook.com (2603:10a6:20b:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 09:52:25 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 09:52:33 +0000
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
	Frank.Li@nxp.com,
	horms@kernel.org,
	saikrishnag@marvell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 net 0/2] net: enetc: safely reinitialize TX BD ring when it has unsent frames
Date: Thu, 12 Mar 2026 17:54:13 +0800
Message-Id: <20260312095415.669128-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|AM9PR04MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: f7eacf1d-3dbe-4644-962f-08de801d13d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|38350700014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4uoJD/RPclIhhpH7uB2FJeY73tHAyz+tx+umtxP+DFJq/llS0DZHKkBS/V1/zWRtQQTmdcEIe1LXxUTj1mwFjwSqewWjvA3VWarFU+Eh0xqPrBQgSY9JCKBYebSMzrbpN/QIWmI7cB/cxUnGLN0+x3qoeNVCPi72Y2hR43XEXEdeBtzVbFzVGv3JXWlvjiwI3wsBpufOyFoIi//GwXN+0IjY68zt3+CzOZiPedJzHq0cIOpitHl54CIw5iiR8r+QUZS9HY81S22L95ry7CumIni7eu6lVGM421CPUSEWIYM1QibCd1RasMN6IymSH4LCewCwTfUgsf++mQvIocYUqKirGw2/SHUiusmJj9UAB/3GtVuIVH4Z2nuFIRLqYjkT2ert5AttVeN2djM3UKYL9ypi8TkuhbE2PQISFDZiGHXl3MOLaS386MXdAJCMTFgw8/l+KZzNxcoSYV3HokF6cgeAu+iGN0+oiCJbaZ4NnS0AooSBOClgbWvEICUEMgamnIM6q4bGBB1+AVPn7UrBKa1G2zgoW7/09cmbVhr5wkEu+uDPOPji0CaS0T/Rc9w35EYTvOqN0/0FjAQsyBeQlOSqIlB6So482QFCs4nwv0rV6gwcFkU8mM8WS3pmT3oX1imz3x1WqPdDvvGJe0QhvQIJS87SuaUOT0ndpEhSpElDTZZ5FZ77VYFHEauiBrkLexkM1L0J9S8ZBQuDagffqmVxVIZ+rWgDxUQN/0r/2TXu4i6K3JkQAHUJgT6qh9MNuHChN+5UtXQJdlguEE2BEK7ReiR1Mk7sSH/AOe070Q9PMCMTzKIDaRA6MwYPFeGs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jKHEO+6DfVcDzA0tq/G35TyWZejJjsZrW3QBubZe+h+oOR40PAUy0AfE3qyV?=
 =?us-ascii?Q?iAGta+SIC+TFW+wnCYhqkl8qAAmwGmCNfMyJGorhmGNFRQHEcjZv19evF1wC?=
 =?us-ascii?Q?OFSjmfPNomKAM3gkJcLyCYcgCjEQR7/YPiWBfeBY/RmiPbnWIc9ULyBJJU51?=
 =?us-ascii?Q?1TXJtPzBfR1ZmTCXs0APY/DrFalzNrTfPPkGJJ4R+8CLYhqJQArftK0EjD5+?=
 =?us-ascii?Q?njp6NIywpEiXIdlJQY08p/nhbvBmsnvDFmSs2FZp5sLCEYFHf5S9/2KHnh1F?=
 =?us-ascii?Q?XriKiOLAZ0on1ZH2SKGm+L8eKa9BImQqbfjZLCxLLWPRqh2oi1fVyq8zrCgW?=
 =?us-ascii?Q?rvtqcjCzJ3En41k1Vz46hM158mQcmFQxnELYWDWheiK2MHGkM71X1rXmm3n8?=
 =?us-ascii?Q?+REuagh8Sycqf/8KxLGwA2YAVTrWMYYZuB990sGSUdAww+sNWv0oBDZUhAkP?=
 =?us-ascii?Q?XUnjkXScOxMzMPIoxCqNwgPUwkfSECWXh0I3xdRnoLUnsVCH0ioh0HAjoR7D?=
 =?us-ascii?Q?sSI9RSk2W6JwZ1IxllWo37f/EdEbXGc8lOIrPgE+DJV6fIHqlOdJfrKBycec?=
 =?us-ascii?Q?h9IqiDapbZBcoJoHZN263Sp9UR27KBuMUFFXw6+H/MbuIr0LAN6y9I0L+to9?=
 =?us-ascii?Q?h9RGM0qsaZvtB4MHJ8lbTywO97/e9LqUWXAUWk12V03M8ENB3DnlAv1c6kSN?=
 =?us-ascii?Q?O9xX4nze8sjP3I8dldM0B5ZyN1f5lUvg8PjhZUbpKJy5+QuE10TkBKzf1Vut?=
 =?us-ascii?Q?aY6H+78fDuOtkuvMaO4KmLwIaL6A92aPk5719gZoj2u8v84Hby4jZG2xz6ns?=
 =?us-ascii?Q?6NMtGLpzv49sx08xYNC4LwhkhOFL0ik85TT6ml7RuXK5WB1nXcJ0zgxLZpXL?=
 =?us-ascii?Q?Sz1YVVw4VPdj/ZcW3Y+WXvKMGdNhNidG2sgPyCQvALEx0nqW672fGkAgtrF/?=
 =?us-ascii?Q?s4Enqvv/WhA/F5jfZsXXJ+SZidC5UgnmAxmbYeTY11ZA7Tl0K6+aTyrddUFM?=
 =?us-ascii?Q?O+AhBe+qzj6qOU5Ms1OEwe2blGTywjcqqjEzcfiDHujIBUvSwhjeM5eRN8oQ?=
 =?us-ascii?Q?b4qM5p5x3+Pq8BR46IaOcWgnYOeDTAWFnljtwZ198OmKn2mYzY7+NXiRvGIT?=
 =?us-ascii?Q?YeAisz+YtodOHAQBYexsbdsgUfyzyVdaAoXY+YS5qVzYIl5JtIHMwBdTEZBo?=
 =?us-ascii?Q?tPzvCPrQESazv9v887RSEZqIRe7bfDfdw0J4K2/Ra444Q0vAZ2T7GKoxeiF5?=
 =?us-ascii?Q?LW/BpgTJXVmV4+pyPMJ6cI/L6LMFuVU2QHV4lfJ0TODV1O5MdvYQVEKqW1tt?=
 =?us-ascii?Q?NY6yuuLtvg8/PH4xrRmmweAPXczpgIXwu2xI1LHlzMlSdEGpEbkmJgtmfMXz?=
 =?us-ascii?Q?1a/c8O/+YcejPJ187HQAHKSUVZKAMc34rnc73s5q5NcJ7ja0bpZzdfJiw30D?=
 =?us-ascii?Q?C1Pk+75AkDzb6n7sUNbQ1HCpBBZ3vW3bDktFZhyRDc28uw0joGEE5f07uQqX?=
 =?us-ascii?Q?FADrEvHQupQa06ObF+avINJXlqKwinlb9Sra/kVmkQhc77+E5wuGcv7JatM1?=
 =?us-ascii?Q?PugILIoy1AZH8CLFfKeB709sIkbVV68QVN7F4VtemBRHerpFaUaSD7qrAb3m?=
 =?us-ascii?Q?C5HYzXjZ3GmZlbWyoMIiYqO5lRKAnDeKkvcQWXnu4o0HGthoG888ysqnTs7O?=
 =?us-ascii?Q?fSMPeKCfElACq1Odj/3iULi49NrkeWggUyOWquMw/jKKZ75Wrs3eokzy3BGj?=
 =?us-ascii?Q?lGEzYlbZEA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7eacf1d-3dbe-4644-962f-08de801d13d0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:52:32.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjUM8S3RZJiwY9tG93qCshzl2wMUEX4DrRJ9XRLLFGZ/raQD/PeJ9Sy9UrY4pdOn9irRRfRNT1cE2iPRp3TxCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9014
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266971-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E26E26FE54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
completely solve the problem. When a link-down event occurs while the TX
BD ring is transmitting frames, subsequent reinitialization of the TX BD
ring may cause it to malfunction. Because enetc4_pl_mac_link_down() only
clears PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It
doesn't set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, it is
not safe to reinitialize the TX BD ring at this point.

To safely reinitialize the TX BD ring after a link-down event, we checked
with the NETC IP team, a proper Ethernet MAC graceful stop is necessary.
Therefore, add the Ethernet MAC graceful stop to the link-down event
handler enetc4_pl_mac_link_down(). Note that this patch set is not
applicable to ENETC v1 (LS1028A).

---
v4:
Correct the offset of ENETC4_PSR
v3 link: https://lore.kernel.org/imx/20260311084105.3982037-1-wei.fang@nxp.com/
v3:
1. Split the v2 patch into two parts
2. Update the comments regarding PIR and CIR in enetc_setup_txbdr()
3. Use read_poll_timeout() instead of the while loop
v2 link: https://lore.kernel.org/imx/20260309030412.2716984-1-wei.fang@nxp.com/
v2:
1. Remove unused register macros (ENETC_SISR and SISR_TX_BUSY)
2. Remove spurious semicolon from enetc4_mac_wait_rx_empty()
---

Wei Fang (2):
  net: enetc: reset PIR and CIR if they are not equal when initializing
    TX ring
  net: enetc: add graceful stop to safely reinitialize the TX Ring

 drivers/net/ethernet/freescale/enetc/enetc.c  |  13 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 111 +++++++++++++++---
 3 files changed, 120 insertions(+), 15 deletions(-)

-- 
2.34.1


