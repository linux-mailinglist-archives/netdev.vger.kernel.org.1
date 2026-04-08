Return-Path: <netdev+bounces-276290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEF9HZr01Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:24:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E84FA3B788A
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97A2E301905C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 06:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E123612F6;
	Wed,  8 Apr 2026 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IpC8llHd"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221E280325;
	Wed,  8 Apr 2026 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629460; cv=fail; b=j4d0Bqn7Fok+mMpnVRz9gP6HdJPWwjnzgwJu2DfhNFXXXC7U5Jjm/4LHW091DgzC5K4qOc0Ulh9ck2yGbDv7DIbRsZP1oPf9/bozGFk+lVFcICleeFA2N9f4MFVdeSokEH+cCExPYlvyEEar97ZN6oKFj9itymw7B0tXDuodwUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629460; c=relaxed/simple;
	bh=4tu+zspHUorFBhfAQiPbpxZT7fi1HWWxL2hoBGRvltQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qf0bT7mIIcGkvxLc5Rwz7Pm09KPrNkJHzWa8LrmB1iBr1gMU1Eta+PcX3I88hNDOszoMT0I86Zslkn8fE/H3hx3wD/qlSuoZRKx8X45H7emB/yHTOySMYm9AutMViBbjiLts0ht7OIai8JzzGgdhqzIH3zoY1o3uTUqoGGs9Ap0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IpC8llHd; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ky16GchRlY02+bp2yQnKOt6p/Sd3W9ZZoUjXB6MKY0ue/RFnsOv1F+2mAKpCs4iwYXJcCtIcnywxsczGpFgnTt+Yrtc/9zw/C2SFCjQvFr/JiqYiKI4ACPaHgkZR/ljVLaD+79Sv02IIeZSNQZECkJNOdpdRkSdgCIzPJX2GzTtI8XyLyTJvNvna5ZZYwKCF+rC7H/rotmILnJEEka8HVnsaICx4XkBMkLy72DCffF6e8NyLSGk2MR6P/1W4ioIjxjMhmSYMpD164chE3eVb2iUdktj2SHAC8YEJ80rSA6zrZswWOfNdOkReDdl8ikKUBk+HBCnANCBG1k86Upgf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHLss7oP9vGbcopo6Oa9TakV0TywdfkE6fOJKZw604g=;
 b=pH21fLaTWSpfPxR/OsDbtn9qmZxnerAIYLPdAOLYIU+G3/N6HwZEbk/y1TWnE1aKVnmaqavkRdY0ox1pIxpLIJCGY2jhymm0KJsWZCSzBbdrrVgWwt04hGRbVOqUA7Z5ZimsAaLDKiiYegCajonDRN2epM2TaNXImPXN/vJq38IrlNOB1abf1fRI4HNBhmCqK/nci7Eo8KMTreDFHgkJE2+e1wfIkJ8SfEdIInVJ9nwaC3LDB+XOp0b+DqSC90AlBeGAJhHoxrih6raPNJc11qvQi++HdD4X3b24hXCqXAVw5hyjN2X1+UGSppdhWRP5zd2M4XJXDfedXIC7DlbGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHLss7oP9vGbcopo6Oa9TakV0TywdfkE6fOJKZw604g=;
 b=IpC8llHd+vnuQb2tAndpyPs+mBhdm6McdwxqZmcpiqUxVMDy9qPq0fJ4mKarC2g1NKY96m8fi0eYMLWHtA2RnB5FB30nZUptEFU6zH6DZUs2CFD8C/rbN5HhZz+oL1RHKI8XGVKOuakoxK15UzSxA9vDUc8NrL3VkK9xmo5DepDMmH/rbZRHU4irzqztEbMwkwHqx0GR4ZvOjwXuI74EUeK0UxE6rTMq6GsgJlU1j6rkyghOPB67t99uLAetmfcMeadc1tccDk+1/c66l9gyMUzMqUH65lh0u1GvCHorr0VoxBTTAavPAOFO5CyL6/KLlTG6WFQJguglxI7vT8daUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PAXPR04MB9024.eurprd04.prod.outlook.com (2603:10a6:102:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 06:24:15 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 06:24:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 0/5] net: enetc: improve statistics for v1 and add statistics for v4
Date: Wed,  8 Apr 2026 13:58:44 +0800
Message-Id: <20260408055849.1314033-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0043.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::6) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|PAXPR04MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: b202ffff-5bc9-472c-e407-08de95377513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KotTH59s8kaNSIfKpdZtY+d1BuEl5jWanm/Pyy/haWIdFDH5RUTdR3OBxCNLOk7PzKF2ZlgCOKttCU1hj7uduYKxT2AtuxGUGfE0bkbp0W9oCofOXy8+SRcE7TRUXEDFIPZnWRuDWkzIK38nCW7tfJyFo3mCgr43bU/+mUIiJUo1VQPpLmTfEvw9zJli0Uij3A+YBsSgzSpvM6eGdMvePnHY0ziJRK+UDG/IAleZD03hxld7WNvoKjqMpzA1yUaBMvfEG4zOsAlgb+d7XKCIB223ZFePUqPwcnMjd+FDxWMG004WPtyN7RjD9BLp279Km0es/I4fcku0TiVmewk12yQWQ3khUZgpnMNjg84+1nNNzbL9T6wRFYB5XVcQor93r1Z5ablRs3C2wEyujJ7n0Ly2q9wf0Wuh/ttdXNu9vMXd3zeEVxb7jEkdQHyaRSsplKp6JfiKdSwVzhrGM8VIlH8oLgKWhCrSQZJfx8DXOX/CE6WD+2SlYTV4Khn9zDUPlGvAkVGMMwLLOpE1LAddf20sJEW0B/vNlJoQdN915FweBt4oTa7g8eEivz/E8Cs2PlXMwPDKUUb4it+M2KsFXAVZCAb7rNRQh8pPXVbN+4M303P2Aq2WlRHIhaU/16Zpxaj/ETc6EWvyBgSsGgLikWLL38XyKJL4aocZglLeMai03gnlLVKba4VRD1+NxH5tzpY6kp7f9ir1iT4RGqahWcQbO78KbUo0kJFFMpPMm8p6kAHT24SoaKdr8TMaFpClOW8w+wQHgiHBDeaVSeQIYsMRZ0nN3dRfuB/DgVEgZc0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u7EDAfeZBDjZEifEYTCSAvJHN7gHqEuC+X9EWe/8MsE22wtIExuUxk3b9mgV?=
 =?us-ascii?Q?I+M1zZ/F02PJSwKG6N7jgVCuqEUd0iJjzMA2jFu4qdKZwvYes+P44tGPLvPM?=
 =?us-ascii?Q?KWdYjxaHGKfCfZr6Chnbzv06YXsh5eLpoPoLSu5fMHBnRnbJ+NUSOnuXkygi?=
 =?us-ascii?Q?bizsYTjdlfUbT4JWHTJiB6Y9v7va6wJF9cC52ZeHvVdfMlWNmyDkvG4iiEHK?=
 =?us-ascii?Q?vVoj1dF4ShSu3EWofaMpRykXKLhplKqh2PqnKUHH29iEARrb3OKVqJb0+0uk?=
 =?us-ascii?Q?gvZt6AGsKvi0ynwZAF086AMOOmwTSwcf3YP+0Aud4+Hzts+Qz8D8tJlckF7Q?=
 =?us-ascii?Q?LynXEiZtnmdBPGceEYM/LNHJidYBL8KO/4yye3yM657RfTUymOHoVP+hAbVU?=
 =?us-ascii?Q?IjKFE71EAodtnS1f62+zRnU8c35GZguueXM+mP5IvfZ1uuptVlV+0sZB8vFH?=
 =?us-ascii?Q?5nIvuXqe8S9IPpG96drIrfVfQ0orUEYZT/TCZpiCsBTHDo0LTazD/zMOgMAm?=
 =?us-ascii?Q?cPC68yCSSqYl1Vizm23T7EY4sPlcY/KGnR6gswkLgQIzqlm8UQzhL1oH/+0k?=
 =?us-ascii?Q?5+xf7gt3OOfjkA1OuAD/b2sWhjmVDAmcLRiVkiizYLp8TH0CQ1VUgSZj1rIX?=
 =?us-ascii?Q?TSxCBYIo/tdJoOSbaq6owo2o4QwHwnM4usGI+uNbv1sQ+sQrEe+rvL1MBNJd?=
 =?us-ascii?Q?NiS590xWAKfnqb+SCMzOvkJnrh+IP+5JpCucZ/0sY/dr1zQkSkJOy5RQZiSE?=
 =?us-ascii?Q?4uBCH7qQy1zXwutkXLsATkzr3PsexieXNjiNq/S05PdH1muR0ZrFJclI0QEw?=
 =?us-ascii?Q?/RmeEYSNFaMU8MYs5snTzDU9l36uhgYtz29x3UERylY7ZQgaDnWlO+A7Z0Ai?=
 =?us-ascii?Q?75Zo3Gm/lSQEO7hPzGcyKhc+b4h7EJRVP85pQpYFb8eeFPXb/bNcgcdb2hhe?=
 =?us-ascii?Q?IO34QhWS7xtPNDQoGKWmiu8PHktnApwdNCr5In6wNz84pgc+PplluC4AjD0E?=
 =?us-ascii?Q?8HSCWgQ/AQT8LwpQEN5Y1wDEXh58utqLdSOoQ4Hc7SJfW5Dit+Rk68U/7fdo?=
 =?us-ascii?Q?gwEJtwQO29Tlaw4pYS3NXcDlobd9uAMSnxBRYbZx4nDADfNo6FbInWoJ9RF0?=
 =?us-ascii?Q?gTXZrCZAt6+QECw+lG/i6CzZdXFPv+w29/twOc0vXPq7jDU32CLvcyPvbTmA?=
 =?us-ascii?Q?eFJidjI6yL4EvfDCAeW5GDnbVTXaJer5tw5IccA5z9tCrNBljYxnazmz+JLb?=
 =?us-ascii?Q?GlP9qDL8f5SCKL/vxE5dtA8ql+DVy2M7lzdG21aaK2SEtvTY1ZdsgwCbsZys?=
 =?us-ascii?Q?4cVlGEa1i0KwfZkaWWzknkUi8DYyNTZOCLBtKPlt3TE5IfloWeLNm2qwttiK?=
 =?us-ascii?Q?4AIsditval0SkCXKpUpNCiK62Y+AHrtYVGRd8FAH8xOGkvp6jZGBZVgSpkgD?=
 =?us-ascii?Q?iMc26JhQtrLXzVjf+YCUchdikNTCwN1RHSj/Umrzlw/8Y/2vWn1RO3bOOTIx?=
 =?us-ascii?Q?nRh3Tr9VVtb9VqvLYyu/H8KdJ95vfnLDKH87TOJ3uqmdS4fUVo+TRkuxAcsK?=
 =?us-ascii?Q?D+zz1o8tNfco8MC7Wo/PTA2VzfWkcrOLszeCJZqdbYdmC1S0DYE/3CQZoQCY?=
 =?us-ascii?Q?hqAJpCn4fhrrDgjCDXBZ/SBuSEmvvl0/ZsIK5ns//vA/ojcRm9ag2/xpWTlE?=
 =?us-ascii?Q?7EVzzaQwyJVZRxuIN1B3ZURETgYRrllts+KOXdDRjR5f3jXK3jwEbjdE3CjK?=
 =?us-ascii?Q?wqUUzldwrQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b202ffff-5bc9-472c-e407-08de95377513
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 06:24:15.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47WJ4k93M0sjBoXYxTROFUEqX72oMH2dPJBa8GX9JnsACJP/4sNJIik5Tnzjptgd/vsQEeJahMkUuCe4xpuFIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9024
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-276290-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: E84FA3B788A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For ENETC v1, some standardized statistics were redundantly included in
the unstructured statistics, so remove these duplicated entries.
Previously, the unstructured statistics only contained eMAC data and
did not include pMAC data; add pMAC statistics to ensure completeness.

For ENETC v4, the driver previously reported MAC statistics only for the
internal ENETC (Pseudo MAC). Extend the implementation to provide
additional statistics for both the internal ENETC and the standalone
ENETC.

Wei Fang (5):
  net: enetc: add support for the standardized counters
  net: enetc: show RX drop counters only for assigned RX rings
  net: enetc: remove standardized counters from enetc_pm_counters
  net: enetc: add unstructured pMAC counters for ENETC v1
  net: enetc: add unstructured counters for ENETC v4

 drivers/net/ethernet/freescale/enetc/enetc.h  |   2 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  | 192 ++++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 427 +++++++++++++-----
 3 files changed, 519 insertions(+), 102 deletions(-)

-- 
2.34.1


