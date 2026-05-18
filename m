Return-Path: <netdev+bounces-288831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLUdLu6BCmqv2AQAu9opvQ
	(envelope-from <netdev+bounces-288831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:05:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 169B1565466
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90C72303131C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D2B37FF62;
	Mon, 18 May 2026 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RN8XJVqX"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63B37FF66;
	Mon, 18 May 2026 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073405; cv=fail; b=bsHnQyX0DnSKDSHru6XjVRDd7p5TitUNjmS1SaaCxI0UL3k7fS+j0VtrUEe/YvqQRSgrdruVExZ8u8EYtwJgtM4viZ+GjdXKj+5M7ofgivfDVXLcfq9RFHOKlV9qcXxKGwrZbEdsfUZG940PW+joePBI2/NtsgM81tSTGMUSqpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073405; c=relaxed/simple;
	bh=empFOoG0QSNeyhNcjXP/p18qDCAFJ3YDjMPDIStjXmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TgxdT/Heg2HwZLKvv5iO08m7v38XELxiThFOPFK4G02KeZlCeitr51OLIfDZ23JCyWz08y42jDiXRK8I8OXwGuhlllS6iTZh/8Vb3cH6irCQlQ7moxz5TLM/DP2A239KmfrStugBfL0HTt03E/FqSBVT6vMT/Nnk3GAeEl3i4rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RN8XJVqX; arc=fail smtp.client-ip=52.101.72.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwWYTjUpa3WJcMozQ9KaK1A5lSZ6nwj3vCjK6Tl0AXTf0T4xKvuXaBqzwK731Z6QW1aBHLDmYgB5Bp+uiT+mVw/Ba2WfHgaLL6HRtoPgBJF6EM6hFLS4xOxV21iNFmpdMLTx4VWYc+CykBhHZfTnnkr74n1uJEfh+3wwTJwUX7ss2ilJXDOOzqPY5PxVZi8lsyHQbeZPegKK65Po0x/n+5JKbxrZqZvsPeaKfpEsY0g3V32Pi0+f0ubLVezoH/TQnMfmyNA0bPacnN/70m4vPAuJQASMCqw10bvbNLTUsxCEFcP4Irrtxc4I0CtB2qNdXYWoFfaR2aRrlF5so5fKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpYheI9OJx/hBb8ZJyBzIYjONFdD9bocy3m8HBqvvnA=;
 b=cyp6wBUBL3/Uh36TiAjFiTBZ+QuuaoGpF41rXyCcK8X+2GS2gFEqgykIw9XutpFA7Q0hUspNZ7NmtcgIuMJ/0wxy02RQm5NPk8lNUhFNETHVPhF4BApzIIH6EyO4N1ASOgjt6CCSZZ1LFJSKvi4GD3r23DeMy2hlJ3QPYfxSyrfaylfyF6PzfSilWU6w6NQwBWaOQUbMUH4L6s+nADUTyuGxx8RU4LgV+B9I6OjMgmqo4wQl8o+pA5saSC4mZPqb2QWvO4/q4Kvh0QQOhTivZSsvqnUgTdcVXb86dl9uMFTCkpbVEbwtFtbwB6MHB/QYEEkgDk3S3wWR6qTWr74IcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpYheI9OJx/hBb8ZJyBzIYjONFdD9bocy3m8HBqvvnA=;
 b=RN8XJVqXXl+76et6ztL2D5V1oLuiOsAhtoIhWSCS/fGQEM5PYdGme36RQZ79Y462TUl5+g9N6V+oviJ6mRytk50b+68r9eSVG7aqRBijH+TZXXVP7QRdawjXzvqTjBdvaCQsvCrGr2/Rc8oU7CaVoKMRY87h4riOvK7tgdTga1I6R/1JV8gbg9+S6mZiePEiZRKpv7KVjCpMkNAmq/oAGEUgYH+ZwmLBzwTqD4Ibts4XsLtWsjL/VyYdnx2v9sPODz7AFQbkqtm5Lxt4OVHjwFto9igb0rHgvDvvk+h+lpplw7VQ2uoDGJbC+tOItrmefEuDKwCNNYrZGO2pnOM4xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA3PR04MB11180.eurprd04.prod.outlook.com (2603:10a6:102:4b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 03:03:16 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 03:03:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v2 net 4/9] net: enetc: fix TOCTOU race and validate VF MAC address
Date: Mon, 18 May 2026 11:05:30 +0800
Message-Id: <20260518030535.1057228-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518030535.1057228-1-wei.fang@nxp.com>
References: <20260518030535.1057228-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA3PR04MB11180:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ded3d1-9a39-4519-8507-08deb48a01b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014|22082099003|56012099003|18002099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info:
	sz3WCA7TgtsSkUJDT2MxzbRyZBMgt73kfuZYC+uJSsGN5NdsC88awKREBYnv2P5Ayzm1GqTgonba5s+iBR3vrXfR3bmy/lddOK5uc+wQ7ewaPuvT7njCrcVC5116IEUCSk4MNDgDKYbApYtCZi/Hw8EV0LD/avBEMPt0odXbF1DzrfdihXqguw6PJPLI1nwdC6/7ChGwtCj3TK2zPZLKjwlwu63CqkqaZJtvd82gKJcG23u/VY7nw8ucmC+brKNavKTnw8t4jL9LikoqXtXI9BzmoDquEgflDzIkm/eAeDChHWxqoDFGMobjaZ7U9Cd4mURcRlIMZRqsMG0emZCkGjYNu9e1tWqLKZDx/9W++rhcsa3eWq23ZybS+HeUWTmIfwNCuDfqcPeJnvW8xejrE8Il7At/6TB8lQH6dYCCpHKVnntATgRuo55vq6Md7iAYu22q12ZGMT7Enj2CElwYI1IgemZVMjK+/C1I375FLJosv1Sx7LzV2jT6s7Kvwax7gDuk1EB2Aj3znv4e3dpr9tcsz82cwPQX7bGcSHPV8DpHYAu6EUrSRZbhSPNW/2ltcYIWBEQId/0zkhoHKx+MTOlyx0Trt+bTiUh9RkPwd+vyfZ+OTUDUaXjP+XMQpovJjgSXiTquoafX+t3KV16It8zvtbtGWmpTGnrsfHnsb1fbnWDxjMLDsu1pTLnkxHVF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LmRf75fGeLIPN10ObaJDv/dzKm1YJN744D6s5MlHT4gRZsmsxFxI6GbtHIBZ?=
 =?us-ascii?Q?QDkAQ/zKykDc3j9icTiE//5O2GdVJmMYVZre82FA3BuhHi4LyMPm7w/4QKAp?=
 =?us-ascii?Q?8oc4QqoMIHUN3+V+HZzs1I7NH6zrq5FxVNRi3qq1hSDIPccZ4d8oIzUmeoL9?=
 =?us-ascii?Q?wTWsDaLYH1GHaJgZljDgIqvCYAXH2icvtO0qJMr0bEju7I+ge4fUrNtI39rD?=
 =?us-ascii?Q?lONidvvzmUogzw3vrEAUibSX4mWke9bYyLEGf74F9ma7zsGP+otl3QmSM7+l?=
 =?us-ascii?Q?fACLAP9RNTvIzNEjLkSAXZXOYPoZwPsqJPVDLVO2TvzKoAjIB3HjVl05fXiK?=
 =?us-ascii?Q?NM/zpPnV/6VJjEcsjGSEL7Coic4NJecMIHcb8Z+wrK7Da7f0WXuJ2lU9YO4D?=
 =?us-ascii?Q?46IKgRKr7HwxP5wdBXb+Qho0F9hSI64N+hByOvUrFmtSrJOiWJK3sC5ehbGX?=
 =?us-ascii?Q?GOm6FDlgsWw8Kpbvjuz0y/kPeb6pxhS7jprxUD0f2zMlqx6Tk2mRK0Ma8Nes?=
 =?us-ascii?Q?jRILVojWjM8L7RnjN0x3+n6KwZN6VE+LYaxkq2D80M3KgGUIWOM9u1Y3lnS1?=
 =?us-ascii?Q?jc419ih5AhbvNoj+FuVcmtkIv8JZybGpGf1Px/bP8n5e4cs2OfSYuquD1GB4?=
 =?us-ascii?Q?qp+ctTu88Om6IqnGleCSatpNxDt9XUzI0aTJVExGActUTUN5rohDE7u9OTUD?=
 =?us-ascii?Q?RJFc0zUcEisaLPegEYq875RrvoV157thbQLbD2Q8FyaU8nOaNpyIsXLvrUeZ?=
 =?us-ascii?Q?JeMJgNIonwyaXgDFlv68tPTsxQocpHeIhN+W2b+WaZDjsYBOD5l3nMRnEEv1?=
 =?us-ascii?Q?ZHek5RnSdrwTMVblDLmu2g/Pjb/UIm2YntXe9IfYM6iDG9xlKVdAo+lSQh8I?=
 =?us-ascii?Q?5Mkq+9vUrXJzlE+H/qfafc7Xa0OFjAS70PW3zHlOW+zuvYjmR/MTY7WpDG1t?=
 =?us-ascii?Q?hlysqGJ9C7AQDcV+ReLLelBAtcrqFKBsK9WbX2V8/s7dlAPrESDFAp5KrJR6?=
 =?us-ascii?Q?i7JKos/Q+gqF5EXY1AbebnjdU3QuxF32R1CLIiwnb+ruPvzd1Dfay83Z0crg?=
 =?us-ascii?Q?4f2RmGym+2PlHKD1C9oEZAyo6QBm50l5z9JU9HrV0hD+Kq1Ji1Yb9Qi2iJlD?=
 =?us-ascii?Q?YbuvdN55Vry4qYY9HNsn7q9Ih7yPFvqunM4ZeApzD3TU254777Pbz+B+I35F?=
 =?us-ascii?Q?HJlj/xq1PvNeQ7NK2NbPGqXibDAvfZDbsw3+zKXrL+7MNnrk4pzkpuosKw6n?=
 =?us-ascii?Q?hyKMM49pl+G9GHO0Nd+SKijRNugRm07I+o+tbXym8cydtKJcmFaj6hyjLaiD?=
 =?us-ascii?Q?vbw8Oina2I6c8AKeURNC8Nv655rJX7gcRgKEH+FBvJgu2AbbKl+qKL5Iho1r?=
 =?us-ascii?Q?3aWR9DPcqhYz9JIktjCFjAsN5Uzls/tEf13+eqCfbOBLGaVLv1gCbmqDU1VC?=
 =?us-ascii?Q?XaPK+UAUA5NauAKwOUFkQ/2+72NyLykGSpanysAxVyOTwqkcUDiQ7AuWsLNJ?=
 =?us-ascii?Q?mx0oSxEc3Raj3GQ0+NUlyFjt2+K3x7FItnoFiNkWjK/NCmXZFpozUn0cX1Yc?=
 =?us-ascii?Q?VZrIAevLCmNLgtXqdNttkB6e9qS53x4WEubNj+9GAEcrRJLy0QDZMVOBOGrY?=
 =?us-ascii?Q?yMpJAp4T9ZNNutUQH403XV7UkWNzllJParGtIX9QkXoytG6xVmztRAkRyBD7?=
 =?us-ascii?Q?TI+MG7YPkBaH4O/B6uxKZ2MrVzimsMyP2Pfy6OVrwuHamqOE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ded3d1-9a39-4519-8507-08deb48a01b9
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 03:03:16.2362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGAbUvyDuIvLwTRBaxngwCouAjGilR8tiIAoHeTt1IxhT85Jlo5jggkLOCR36njj/M/7d/S402K76Aw1p18V3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11180
X-Rspamd-Queue-Id: 169B1565466
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288831-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

Sashiko reported that the PF driver accepts arbitrary MAC address from
from VF mailbox messages without proper validation, creating a security
vulnerability [1].

In enetc_msg_pf_set_vf_primary_mac_addr(), the MAC address is extracted
directly from the message buffer (cmd->mac.sa_data) and programmed into
hardware via pf->ops->set_si_primary_mac() without any validity checks.
A malicious VF can configure a multicast, broadcast, or all-zero MAC
address. Therefore, a validation to check the MAC address provided by VF
is required.

However, simply checking the MAC address is not enough, because it also
has the potential TOCTOU race [2]: The code reads the MAC address from
the DMA buffer to validate it via is_valid_ether_addr(), if validation
passes, reads the same DMA buffer a second time when calling
enetc_pf_set_primary_mac_addr() to program the hardware. A malicious VF
can exploit this window by overwriting the MAC address in the DMA buffer
between the validation check and the hardware programming, bypassing the
validation entirely.

Therefore, allocate a local buffer in enetc_msg_handle_rxmsg() and copy
the message content from the DMA buffer via memcpy() before processing.
This ensures the PF operates on a stable snapshot that the VF cannot
modify.

Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40nxp.com #1
Link: https://sashiko.dev/#/patchset/20260513103021.2190593-1-wei.fang%40nxp.com #2
Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 39 ++++++++++++++-----
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index dea3a92c4722..09c642040892 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -478,21 +478,24 @@ static void enetc_configure_port(struct enetc_pf *pf)
 
 /* Messaging */
 static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
-						int vf_id)
+						int vf_id, void *msg)
 {
 	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
-	struct enetc_msg_swbd *msg = &pf->rxmsg[vf_id];
-	struct enetc_msg_cmd_set_primary_mac *cmd;
+	struct enetc_msg_cmd_set_primary_mac *cmd = msg;
 	struct device *dev = &pf->si->pdev->dev;
-	u16 cmd_id;
+	u16 cmd_id = cmd->header.id;
 	char *addr;
 
-	cmd = (struct enetc_msg_cmd_set_primary_mac *)msg->vaddr;
-	cmd_id = cmd->header.id;
 	if (cmd_id != ENETC_MSG_CMD_MNG_ADD)
 		return ENETC_MSG_CMD_STATUS_FAIL;
 
 	addr = cmd->mac.sa_data;
+	if (!is_valid_ether_addr(addr)) {
+		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
+				    vf_id);
+		return ENETC_MSG_CMD_STATUS_FAIL;
+	}
+
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
 		dev_err_ratelimited(dev,
 				    "VF%d attempted to override PF set MAC\n",
@@ -507,17 +510,33 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 
 void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
 {
-	struct enetc_msg_swbd *msg = &pf->rxmsg[vf_id];
+	struct enetc_msg_swbd *msg_swbd = &pf->rxmsg[vf_id];
 	struct device *dev = &pf->si->pdev->dev;
 	struct enetc_msg_cmd_header *cmd_hdr;
 	u16 cmd_type;
+	u8 *msg;
 
-	cmd_hdr = (struct enetc_msg_cmd_header *)msg->vaddr;
+	msg = kzalloc_objs(*msg, msg_swbd->size);
+	if (!msg) {
+		dev_err_ratelimited(dev,
+				    "Failed to allocate message buffer\n");
+		*status = ENETC_MSG_CMD_STATUS_FAIL;
+		return;
+	}
+
+	/* Currently, only ENETC_MSG_CMD_MNG_MAC command is supported, so
+	 * only sizeof(struct enetc_msg_cmd_set_primary_mac) bytes need to
+	 * be copied. This data already includes the cmd_type field, so it
+	 * can correctly return an error code.
+	 */
+	memcpy(msg, msg_swbd->vaddr,
+	       sizeof(struct enetc_msg_cmd_set_primary_mac));
+	cmd_hdr = (struct enetc_msg_cmd_header *)msg;
 	cmd_type = cmd_hdr->type;
 
 	switch (cmd_type) {
 	case ENETC_MSG_CMD_MNG_MAC:
-		*status = enetc_msg_pf_set_vf_primary_mac_addr(pf, vf_id);
+		*status = enetc_msg_pf_set_vf_primary_mac_addr(pf, vf_id, msg);
 		break;
 	default:
 		*status = ENETC_MSG_CMD_STATUS_FAIL;
@@ -525,6 +544,8 @@ void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
 				    "command not supported (cmd_type: 0x%x)\n",
 				    cmd_type);
 	}
+
+	kfree(msg);
 }
 
 #ifdef CONFIG_PCI_IOV
-- 
2.34.1


