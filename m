Return-Path: <netdev+bounces-287151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHN1MtQpA2qw1AEAu9opvQ
	(envelope-from <netdev+bounces-287151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:23:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBD521172
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF82130913F3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26325306779;
	Tue, 12 May 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QkdjUEgT"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7938F25B0AA;
	Tue, 12 May 2026 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591772; cv=fail; b=g1PaG4ghNsJn36vpVRM0MpaBFknYzupgpDfMK8pw9mCoHDvg54+Ia0h16yXE66XgtlnAdTUxLAadhlvdcHQsimT36nVvWpIpREJjGXHRYS86gCc7icEVWHbeTb/svbIXYq1+/nGLsl7UXvD2Huir3in/RR8wBUxCmkmq7Rvnm4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591772; c=relaxed/simple;
	bh=+y5hABUk+aLJRbukhJZOfoU8Zmc1qYaC68cZBwTrTKE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XsG3EdXIa94vtu8O/9U5TIrWRTCI6Yz7qNO88MCxMFvLTckc9CLHuyWbLCngIFzU4MDFDb5MFzrEvzW0g8FCMEsWBvsEZ0req4yLDCpoOGYz+C0Gf7ZkTPH6jdzwRXXia42KIyMcBZ8wpQJts2W01oUaKHYDtLM6/WSdJy3eTGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QkdjUEgT; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2r0iLdAN+W5Hmp+eoxN+BsUD6T7USyD2Hn4rS7stqep8yL+/SUtU1Cs9je1a1gdqaCNAUXm7Bt6jXHEnvZXG13CBof8tSEVwxKQ/j570Dvh7YRWQMwvDqiDHSRTYC4yFf7SjsVTLxMzeEZjbc6wh8X28nsu61PlsUutj5ZGGELVecNguWWIyTAXteI1ZhDEoM3Y8qAIfVE16O6nglEmqsPADtdjHZn4IvS2tYmaVqNNPFFJUa0PvOsX0J08rYO8wrPAYKno0IsFhAJyi+wvB7QAXvio9QHhO06rTSO9cyZgJKMP5x+hdUn3MzxyNWbUiFalSqIaQU0S0wavprNZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AENHclNlBRtDY1z3eiyTd89LoxfolAl7+8HloG6Qc5A=;
 b=jyK09apB9SIsGIl/WkHf/XOJLRaSf8Er6OWCH/CiNxiEaq5a2IvkJ9gIC+V5KG9fvgdpzhVyxCNNgBizh+Xc63bFZiF/oSwF8iwcd7AOaacjCkmbUTmILD8mRgzcJH4fzxtCyADl+2pql3bBWWMCAbZjHDGccSQAYER5FPokGl7/Rp1rNVk6d0uBztQt8oV/tgEoCwqU5v+s2xQKlZDhk1kQw8U5bOLLhibTnfKAmtAh8Ckzfi3h5kbP5vx5/JWNUvaLgG0Vztb/H2SQDNbeLHFwAtysGL9JG6UKk1ZFhMsJY2k+RepX/bo5vxKAf5Gl8coXwN/dxwGbJr/Ph+pllw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AENHclNlBRtDY1z3eiyTd89LoxfolAl7+8HloG6Qc5A=;
 b=QkdjUEgTL2XC2eNBJ3X+kNpZg4ONIKOg7u7xUMZ+cNJC/vNmvv88jiz01jnwRPAIMnGH16DLH1A5sP2NL4qQtrFjpNVEmltGfKh1mamOiyEy3xGB+YqNkccfCGsMu9O2CBEVA70Xp/t6N96KfX0pSiL9wJ+zc6QH4Sk+2YyekNZ9iSrLVn/K7MajQ7TbdC+ef1FuYHkV0GgMOQm/fT28F3EoQh9/nLKgv+ItBLaF2IswUblcPwmJVOLPnbdUT0cyEl8SIYvTJoBfJCgEbN3yhSj8Ke8K86LGIL7gG9mmpHa8tfoLPHvGO2dDfx5+eVnoekZxI4mEHGF7U2L0YXs/9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DBBPR04MB7657.eurprd04.prod.outlook.com
 (2603:10a6:10:1f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:16:07 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:16:07 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 00/13] dpaa2-switch: add support for LAG offload
Date: Tue, 12 May 2026 16:15:41 +0300
Message-Id: <20260512131554.952971-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::31) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: ab78de8f-c079-4ed7-6419-08deb028a069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|56012099003|11063799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X4HExjO9hOGK9O5FVvGa50SFBtVhLPHV30OvVG6R+f8xW2IuWSSB0NUAV3J8/tgHtBr4iKVljA0yH/s4Ov0/3WZarOwLnKTl5cHnERLuv7Ou2pufL9swrWKYSAKxH+QAYS1MDKiixPcvKTxpnGHU7AXm1aEnOjI8Ao9ZuF6ZKEP4ljoQqfMRfKnRn7TnuGKI/ZmFtV4EDe2j/80cOszZvlKowh3c8jyhP235hDa0ZoV3yOgGigGzVSsM2+wDjv+uQ41CZZw9FnetPiiLSI8mpKhQyY5vNjffNoFn0JSQ+LhtnuNtgG/QgOvsj2vrEcB5lZzg1x4Qi42lWxecDh7NlVZ3G8UyyYd38hmd4yX5WTtvIhU/YdAkA+At68aXExEEg90uNzvMBgszJSgHBHTmlPtiDuPmf7njn2xXBvryCt07zKc/utiYKB+MCescsIfsqLD0XuQQ+TYbR/j7qpZf6efZL3AFfc7dzlY0T2+QYfw3m8+dSdqhJAZpe1ekaEB2RapCw1WojE4v1HpQjhTx7Xvn+uKUbOtnqtgrfhW0bD/WLSt6KlECKOXKa8trUBtXAmXA4ac9hmMKvbtknMliF20rcXTV/TmbgHz1VQ3YG8Ayw3u0g51HvCvEYDhCWKPTKCW5iorXQGFi2CxFFe5037NJOvd0qZb1jFvVKP8cBmMMqIIc6AOhjKiPD9/saKrg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(56012099003)(11063799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Hg1+BZWtRC3adEqvDoxFgVcwBpzbyA8qJbfxV3sf3OH/ixMAQ0kdw91IDCM?=
 =?us-ascii?Q?VVb4lQ0BDbBH7PrJ06fDQEToZhmonYLl7+efwjwWGrj4jpep2nqXe1xvp4bU?=
 =?us-ascii?Q?H4fAOthBlayITDbyxVjzDBdDAYl+kwoheBg2SJ8nssO3Dd8A2fnNF9jA1beB?=
 =?us-ascii?Q?pu6hCHOAEHMnDQ1vWwtQXrIb/Jqj4WbnRI37m2bJYshE+vFt2rDIortrpig7?=
 =?us-ascii?Q?BZJ1tj3UR+X3lMhjc+ulz/3HSBE7ePuHUfoEPsO4Y7RDYsPREtmARCSDx9CL?=
 =?us-ascii?Q?7kpbabccISAErx8i5V5RtqtcLzgZY4SJmCwSGudgwYV4LdBC+qsWJA+uaPl6?=
 =?us-ascii?Q?BNvPQnrSUeG+q0sg9RCbuoc3AlwzFQQ3OlJFiyK3kVYhFV1lRqib+1qdICqN?=
 =?us-ascii?Q?DN0moQe5XYNOG/VAlNcBM1r9Tk9iyCcKmkKJ6oWTd6Qvo0C6JXrRgm9oP4ty?=
 =?us-ascii?Q?Js5m1wsFCu+tzqsu7KJS5Tswv4f6idXjGi5GvgRmFtBsE1xaG1EkgcfAIQoZ?=
 =?us-ascii?Q?QwBOWoKyqW7ue9FIrAdjD1MevwSoigOm4NX4oeGISX1krg5IAmnFoEhRRiHh?=
 =?us-ascii?Q?B2kOGVZLxZS/Ne7XtlrBy5oIK8Wu4vXWA71mA+POj4IxzLw+X2X94B4Do8kX?=
 =?us-ascii?Q?gqfL0flneoG7GcXSRUhyGAfQYtQgRhV7Ro99iVOHsccrsj1hJS2QzcI9wYI7?=
 =?us-ascii?Q?XEadJfjcVOGKHpiYf2q8EmfQfugmK89h4sFpz8DU3Ep+sg2NeElo3igpsoOC?=
 =?us-ascii?Q?ULT66aXx1znffi86iT1oSskLq/66X6OOzYjWzHrA2uUGWflfjLX6qDtICk/Z?=
 =?us-ascii?Q?YRuWXDaZeePwzKb/GzzzigTyGO51Vn0iN1m5pIH0/RHswP62LlF4KKXcTpGp?=
 =?us-ascii?Q?oPhy72gNkbiyYbAwY9Q3f8QWbatKDVooVFZyOt+s9oFDWApmXTDn/1HKEjwU?=
 =?us-ascii?Q?oP762V0gr3HQ2cryzAd47hloWb/1emA2VvdPaddTnQ9feuVT9PA1MvTle9Tj?=
 =?us-ascii?Q?ocPdA+Asv5N2dUBwIIN6HuEtsz5Ao/Rb2EUtr+EIVPMUucOxjWBtzD3ixBwd?=
 =?us-ascii?Q?XTQrJI8LBAA/71B+q5cDq+/7xaXzuS4V1DrphoeOZGuXflJU0BSDrzLW4yhy?=
 =?us-ascii?Q?SEYmuLDwHGjKXit/1t51y9WkFGm0C57vxuxiDq5wM4vw9ApxYlbigeErly8s?=
 =?us-ascii?Q?hwvUL7a+1bwORy2aoA2RYTHXuQfbv0XFOMFFLVvxMw2Si2eFS+JJRexVlUU9?=
 =?us-ascii?Q?UBr4oRvJQDSBgHJcIZrpTtQCoWu4nH/v74z8xkyhXeSLV61XV6gnx8jMBZKx?=
 =?us-ascii?Q?xw72CkT21jEoAMZAfj2gUJvy95WNLS4f6JHRcH99eqyn4vNx8BP7HWoUD68X?=
 =?us-ascii?Q?E3J5CssqRRItBOfmL2OVSYh/thR+GhRGvZVSZJ05rTVqZC8l9NMJXse1RS9n?=
 =?us-ascii?Q?zhtHBURZzbg42zqNAfclcLVqdzfj2OeNTd2cNQqHJGTrug3/HcEMRkQCNuf+?=
 =?us-ascii?Q?KBLVvU7MnIYu665+cOZqLD4y/Y3Bv4lE4Nk3RzTBMENpDgfsIlbm5ydcUfUk?=
 =?us-ascii?Q?LYnJr0njLfVJtSXj1VYGz2oaIe8zTBvsgipcFVMxFpMMkS54ElxlBDtTO5uj?=
 =?us-ascii?Q?WuboN44OgLxFcXa5Wa70jxasbPmSRDXbIbsRbK4oNBRWiAit3DCVM90ufQQH?=
 =?us-ascii?Q?p04xHF5tef2+nRa6oewUoGsOaoqMmUtjiqaZfcOg5BFOlcrcOvqYTFXZgERm?=
 =?us-ascii?Q?iekRzwWBrw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab78de8f-c079-4ed7-6419-08deb028a069
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:16:07.1555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hpIlu6mSwii2k4o2uod+Qls49s7L2Q5UEMFfcQCt0WfQYUbr67dd9TMfUuJD5H285VuNjKXjp0H+x6ynr9BnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657
X-Rspamd-Queue-Id: 6DEBD521172
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-287151-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.992];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

This patch set adds support in dpaa2-switch for offloading upper bond
devices.

The first patch adds the necessary new APIs for the LAG configuration
while the second patch uses them, both in the prechangeupper phase and
the changeupper one. Which ports can be part of the same LAG group is
configurable at boot time, thus we use the prechangeupper callback in
order to validate that a requested configuration can be offloaded or
not.

Patches 3 and 4 are updating the logic around choosing the FDB that
should be used on a switch port. This is necessary since with the
addition of the LAG offload, we need to take into account all ports
which are under the same bridge, even though not directly.

I have considered reordering the set so that patches 3, 4 and 5 are
before the support for LAG offload (patch #2) but decided against it. On
one hand, it would help the review AI bots to have a bit more context
around the FDB setup but the disadvantage is that, at that point, there
are no priv->lag structure populated which can be used.

This set also extends the handling of FDBs and port objects so that they
are handled by the driver even on an offloaded bond device.

Changes in v2:
- Extend dpaa2_switch_prechangeupper_sanity_checks() with
netdev_walk_all_lower_dev() so that checks are done on all lower devices
of a bridge, even for the lowers of a bridged bond.
- Manage better the default VLAN on bond join
- Clean-up the error path in dpaa2_switch_port_bond_join()
- Call dpaa2_switch_port_bridge_leave() in case a port is leaving a bond
which is also a bridged port
- Update dpaa2_switch_port_bond_leave() so that in case of any failure
the driver tries to cleanup the LAG offload configuration.
- Call switchdev_bridge_port_unoffload() in a switch port is leaving a
bridge bond device.
- The rollback in dpaa2_switch_port_mdb_add() uses the newly introduced
dpaa2_switch_port_fdb_del() helper instead of the _mc counterpart.
- Update dpaa2_switch_foreign_dev_check() so that we check if between
the switch port and the foreign net_device is an offloaded path. Before
this change we also checked if the foreign_dev was offloaded or not by
the switch port.
- Update the switchdev_bridge_port_unoffload() by passing it the proper
context and the notifier blocks.
- Add dev_hold() and dev_put() calls for orig_dev
- In case dev_mc_add() fails, remove the MDB address from HW with the
proper function, dpaa2_switch_lag_fdb_del() or
dpaa2_switch_port_fdb_del(), depending on the LAG offload state.
- Fix 32bit build by using BIT_ULL
- Take a reference to port_priv->lag instead of reading it multiple
times.
- Link to v1: https://lore.kernel.org/all/20260506151540.1242997-1-ioana.ciornei@nxp.com/

Ioana Ciornei (13):
  dpaa2-switch: add LAG configuration API
  dpaa2-switch: add support for LAG offload
  dpaa2-switch: change dpaa2_switch_port_set_fdb() function prototype
  dpaa2-switch: extend dpaa2_switch_port_set_fdb() to cover bond
    scenarios
  dpaa2-switch: add dpaa2_switch_port_to_bridge_port() helper
  dpaa2-switch: create a separate dpaa2_switch_port_fdb_event() function
  dpaa2-switch: check early if an FDB entry should be added
  dpaa2-switch: consolidate unicast and multicast management
  dpaa2-switch: offload FDBs added on an upper bond device
  dpaa2-switch: offload port objects on an upper bond device
  dpaa2-switch: trap all link local reserved addresses to the CPU
  dpaa2-switch: add support for imprecise source port
  dpaa2-switch: do not error out when the same VLAN is installed
    multiple times

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 952 +++++++++++++++---
 .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  39 +-
 .../net/ethernet/freescale/dpaa2/dpsw-cmd.h   |  18 +-
 drivers/net/ethernet/freescale/dpaa2/dpsw.c   |  57 ++
 drivers/net/ethernet/freescale/dpaa2/dpsw.h   |  20 +
 5 files changed, 966 insertions(+), 120 deletions(-)

-- 
2.25.1


