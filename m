Return-Path: <netdev+bounces-286526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN5ABFKVAWoefAEAu9opvQ
	(envelope-from <netdev+bounces-286526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:37:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B367B50A318
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8ACF03010608
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B6D3BD62F;
	Mon, 11 May 2026 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WUiK0PCL"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304A3BAD91;
	Mon, 11 May 2026 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488544; cv=fail; b=OkGESLLsp0xJ2j1AleZrK8Om+JrXu+2wybb8edz/g8q31P2LG7GSq3T2bAeuzN/HDDayy44AllVT0Jo+4PVTrSdBJ3HP//1Nd5KdQG00EjLkICqvMpN7+pewKHUtIsclPPnt6zqYhW0YCogL7a2vrUj7Qc97BaMnZQH29uDIoJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488544; c=relaxed/simple;
	bh=Zd2M7o1+YhL/w+aoSisedbSdsWgIpqf5q9BIcBjaGec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FZA+eU0NCRFSFmz/3ByxaEPzi6Za8AWqRH5YZu15vfQZlaeMfbuBu7065uSEp69aRCRLS1hcUADE5G1cX+tV/VF8U5QwaLZvDxDn9F0CZGjl9dXOfo4qIxV6sw3YhgBbitji6Sj8pkvSaEDYFkQyi4fb6fvTm/xHFgcuCLmTuDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WUiK0PCL; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKVl1bLQ5yPehyNuy3jKj2ftDWX1UKXcQ8GD6DkhOchurI9gfWTdImGgRHmzfYzU/izc308UPylnvFUUaCXtJCfzsqrTsTwor+MEAnXT9Pz5Qc7FDZ66ts6TJI0YYtLx6Hv9xc+SWNBEoYyzPPAse9AHlCLUWhM82p3alK8AYuoTKhK43/iOBJZetqdYxY97C5shChHgTBjrT2yZ+dhcP+MnvBhHf6TXSo2iQfuAAzXdTjm7XST298wKuwUIv/hRx5nOM/4/xy2DkXxqj8nOIJXRlB4kOEkuIS2NBoU9s2bpNCNUC69wNcqhUWc/3FgAfzlCqVK2rfimn/O0stvx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEgnk9xKoIDHaddYFYnHoUGUyrfu2g7kOQ8mkMaKhr0=;
 b=wruFCPk8qdJn69sLFC6Jg4GmaZwmA1pQxHp3x1xDzcHW7Pzg/SzhR8fu0P2wscEEedZ7Sfl91b0r2tdshXbwf0073JWW/1B5fL/v93hqsTXOpnj/ovduNOyQGnNxfLuOraU687lGxTFy4v8L63ZSaPVKARAd9WeIhYMMr5RTFgDC3U9ctMGc/bjtPR9dGq/2EMVThKkFzvFD413mPfcgXSOYaP/+Hv3crAyFYbdO9yBhI0TnDynRSVXzOGYMXIbSqpJCiPoFTPhgmXPgnM6cqeb0u8mA+XFrS06KnJYHZfUfrO1b9UfxTvtbOvGfmwlJk7GlMBJ28g4GKrlMUlnJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEgnk9xKoIDHaddYFYnHoUGUyrfu2g7kOQ8mkMaKhr0=;
 b=WUiK0PCLfTMKqkPF2XSCuLqCOjVT/mqTih2X3V4IzSnt7HAgLj/GGy9WKTH2IFGVGuEH1mQ/Fs1X1KfqozX4TDzcwGwz7S/wd2f89SGkI8KlUuNo31lxRPlTfdabH+Qex+rkxWMjtG/eAVpvud+HM5V5qZuLCTeqqA5NXS60ee4ySxajLXnpO4BJ3fm/199KeB9I6JE9lEjKKc/V6FlDEUUJGTJwiI3S8ZyZYJKwxdTW+NBnN9QMdJ/Aqs/ZCqzgK5S9SxqV0NnCshmk+baBvJHcZdcjjGhmN5vsellKzC3MtGr6XR5b6CALXxVp+/k1YZDDZ20KCNIrMat7bEs0DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:35:06 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:35:06 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 08/15] net: enetc: add VF-PF messaging support for IP minor revision query
Date: Mon, 11 May 2026 16:07:58 +0800
Message-Id: <20260511080805.2052495-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511080805.2052495-1-wei.fang@nxp.com>
References: <20260511080805.2052495-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To PA4PR04MB7502.eurprd04.prod.outlook.com
 (2603:10a6:102:ef::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|PAWPR04MB10055:EE_
X-MS-Office365-Filtering-Correlation-Id: c83c4037-c046-486d-7b9c-08deaf38340f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|56012099003|21046099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XDlI7VLClZGGVB03+bkcJydlZXiLRo+8nUNWRTXCuBFIUOZFqXgC+O5GXP5buFKegbxYMYeFkLdQg2k3GnrRmDuGGoFBfGG/mlerU84ZJb1mK5BnryIBzu9GAN+TtzDL2eJW5csSLKL4RzcGB6suoWTgHKs23sZXVqkqQpgoGwxoCNzIa/fgsvW72nEVD2Q9zYlqAvI5TaZ7r/qnh0BlIQ+Boy1QNIUqyI0Wi7NfePXbSD5vIJ6Hk4cgxEU75ijPRVnt01A/ca5KuO0eoeOrpBpY4hO3aGinFXBQlR66lqHFlrz16YlEt5PCF3xZez6XOI6rf+nbLXgooiuz15MeR2H2wABfTCBWC1WVxXSw/lQLMCJbG5ZNaTpOGUPsy8V7Eth3wN4Q49t/jFgtkYtPfUl7f9hHdFXI42Ut7rzLGsa02m99bRtcO940KrQ5bSNAqO30GUOpxCvdu1A+vKLnlO9ZW2zMuKv0ie6Wb19WjcfBUDd3YR+vwEfQdjYOJ6EGWYBOIbFO/m3T1xXvArHcm+hOn16dvdWkVt2T7TH5O/N/uIg4lTBDu/C9KpG1AIRg3XRbNiItolXY3Nm6z0ibTPSIc42mJyoLiQeWmvR8FY3SAQBnw+v6ov0w4LcRlzQ3AtYuI9eQhtyeY9ykm3l25V6Ylm0boysZC7+zh6Q0jnBPofQzr4ww8PaJRYcmScjPyautajI6nHCebyvBsdtZGuc/jT3VVXy9o1+qWBNG+QcGA/p8K1wUGlp3p88qvSz2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(56012099003)(21046099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3XrJlu32eAMQTZ7pAPrA5UGJDYdagni9Bddeao5k1JgTKoTabu4Q97fsxCzR?=
 =?us-ascii?Q?3mZcmH87h0E++blvDBS6xga/6dKqhuxYjCpiSRF4/hd8qrTtZG47ENC7k+zu?=
 =?us-ascii?Q?PQ+lLgwducGB1pIc4HhwfJowoBYxJgG1WTWc5+kkUBSe3pJBU6Q7spvLM9FV?=
 =?us-ascii?Q?kRLwn0uMeaskeqfGDfCMVmEPLyQX3qFTcMIviRXSfvAmLMtxtS91gHPvAYHa?=
 =?us-ascii?Q?H7EKc8oEkWae8lH0zyyofoGnBw+uHSFQqBWHvxyQC6/kuTcfOyK6gx9c1Mgd?=
 =?us-ascii?Q?BtI24vDyjf2sIet0lnjDmhyc/RDcAsPV/PuRbBp+0hYDikU/3+1fyMAtQEzx?=
 =?us-ascii?Q?BjC2fOmNqnJXwRWqyDKWDJqU6JpybtvNafU5rq3K9GCGWpvca6EQ4zlhY22Z?=
 =?us-ascii?Q?EO4cG9Sc87RR4o/ba1tOwnu7t03YyHjkMhM6pMXeFt4Dm2qEv/9z/p60IuKx?=
 =?us-ascii?Q?brpEgGQUfbb+KWqyA9dDwMdtqa9sNO3w6Y6S1eBx1zf/S8p7cl4JK9V6ZLsw?=
 =?us-ascii?Q?lImY94iGF/6MRG32BD5JceZPB04DS6IQlp5yFuowBMONiipQHFGdyOZbt+Vt?=
 =?us-ascii?Q?vYSIesikAu0pWUPKbq2jNucaAKzrZ36tieEddeO5cpsdR4Y1Ot884v6Kd43p?=
 =?us-ascii?Q?/PLvVSjjqUvJ4W3QZwKbX2CQ2LRvmvIRUkt36LweBF4c7wi4VWy9S5SzDE5W?=
 =?us-ascii?Q?VVlcq2kPb2NrxZbYIVw5mSiW91Wo01VBSztkh/z6q+qfSl2Ey64hiqk/ZKgF?=
 =?us-ascii?Q?NPgaKJ9lJpst+1gCWxpTl3b3VD4SCNMd/oFLt5i33tjBhE/ZCD88UsO89FgT?=
 =?us-ascii?Q?QaiHaDVJ9Rv3NNaMOgK0B3DSkvxjUj9Ah+XsTSrgguq12fYqFLeJIp2vTvgM?=
 =?us-ascii?Q?FingJnx7wgz6WCVxgzrMnkcAcWd+o65spV/+LWz0ZdZYJEv48pf2yi4Up6Wg?=
 =?us-ascii?Q?HJ9ogCG8cj0vMVOEWmhgN8K18mWb79lfVJdhlrsjnVBGPALnh4i3n+x47QYn?=
 =?us-ascii?Q?nj93DK4vn/Hg9yNDJryueIODNZUSFSmJxp9uVcPcNKBwt6cx+d6zFTapbheh?=
 =?us-ascii?Q?8CkdpuqgXH5/RVobIICqZSaw/UZUsHw7n/1+7YcyK7xJGyNdljNP3eGQuX1x?=
 =?us-ascii?Q?1FaeQEBdqErVJQfvI7a/XouDiNOJFGR7/kkIDzb476QFuKCMNRSFNiXARvO0?=
 =?us-ascii?Q?AatlDHi3s5v1Poue/CPRC6YtCNb0LtccIpXlwpU+Tx4jiGKHiKPBc5wljEFq?=
 =?us-ascii?Q?8S/Ekbq7qYbGWdRduujdLZLxOJdlveXEuZztuX2pIqwwgJs9RjjZ4pYTw6Ny?=
 =?us-ascii?Q?5ho+erGQ3WTyDxZI3C4nTnY/9kSviA1WYWRW18a8OUTzGKTgOocaVT4nz00J?=
 =?us-ascii?Q?Yb5k5YpK5oLLhAzDufMkNImOsCczqncRt2n/Xw7NcgzXLhLLNOgLE8Sf4n/X?=
 =?us-ascii?Q?M07MXKplxI8Wt2ABOP+KlAf0FFozTHou7lWF0m737R5fUtFabYZGVU0pDprD?=
 =?us-ascii?Q?kLQgYielNt727rrCs4QyRTpcFDbl/775PhsiOujExoCDtCeazp8dafh12WU/?=
 =?us-ascii?Q?Ggkcl2XaXYHRCt8DNHJhmCXFVlo4IwcJMGqw2E2KCyqkSn+g72NrcHveT8y3?=
 =?us-ascii?Q?wd3G4OvGnLCV+DJrnkJNjOfmDYTWE7dsCNUVAvfXE0qXF7lViwMGcttrEssU?=
 =?us-ascii?Q?eCvjONytK9+dv0vzLOQba0bMFUjvE9AUAYKV4ZqMLk+vK7CpRbFwhPF6fHaD?=
 =?us-ascii?Q?79Rn6MIjIg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83c4037-c046-486d-7b9c-08deaf38340f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:35:06.1367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PowadZgA7nmITbNaOzkHTWbxqYpI39stih8fKakrguBW44uZToQ1Qe3eTmEmO6pAp8Y5CbmZSEt8LJ+6asoWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055
X-Rspamd-Queue-Id: B367B50A318
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-286526-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

For ENETC v4, different SoCs use different minor revisions, such as
i.MX95 v4.1, i.MX94 v4.3, and i.MX952 v4.6. Unlike the PF, the VF does
not have access to a global register that exposes the IP minor revision.
In the current driver model, the VF must select the appropriate driver
data based on this revision information.

To support this requirement, the VF now sends a minor revision query
message to the PF through the VSI-to-PSI mailbox mechanism. The PF
responds with the IP minor revision so that the VF can match the correct
driver data.

This patch adds PF-side support for replying to the minor revision
message and VF-side support for sending the query.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc_mailbox.h  | 28 ++++++++++-
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 29 ++++++++++++
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 47 ++++++++++++++++++-
 3 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index 260c7333d93a..294185b54147 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
@@ -65,6 +65,9 @@
  * (blocking requests), and
  * 2) PSI_TX_control: PSIMSGSR[MC] - for PSI to VSI notification messages
  * (async mode)
+ *
+ * Note that for some GET messages, there is no COOKIE field, and the CLASS
+ * CODE field is expanded to 8 bits.
  */
 
 #ifndef __ENETC_MAILBOX_H
@@ -93,12 +96,17 @@ enum enetc_msg_class_id {
 
 	/* Common Class ID for PSI-to-VSI and VSI-to-PSI messages */
 	ENETC_MSG_CLASS_ID_MAC_FILTER		= 0x20,
+	ENETC_MSG_CLASS_ID_IP_REVISION		= 0xf0,
 };
 
 enum enetc_msg_mac_filter_cmd_id {
 	ENETC_MSG_SET_PRIMARY_MAC,
 };
 
+enum enetc_msg_ip_revision_cmd_id {
+	ENETC_MSG_GET_IP_MN			= 1,
+};
+
 /* Class-specific error return codes of MAC filter */
 enum enetc_mac_filter_class_code {
 	ENETC_MF_CLASS_CODE_INVALID_MAC,
@@ -108,13 +116,20 @@ struct enetc_msg_swbd {
 	void *vaddr;
 	dma_addr_t dma;
 	int size;
+	u8 class_code; /* save return code from PSI for 'get' messages */
 };
 
 /* The PSI-tO-VSI message format, only a 16-bits code */
 union enetc_pf_msg {
 	struct {
-		u8 cookie:4;
-		u8 class_code:4;
+		union {
+			struct {
+				u8 cookie:4;
+				u8 class_code:4;
+			};
+			/* some messages class_code is 8-bit without cookie */
+			u8 class_code_u8;
+		};
 		u8 class_id;
 	};
 	u16 code;
@@ -150,4 +165,13 @@ struct enetc_msg_mac_exact_filter {
 	struct enetc_mac_addr mac[];
 };
 
+/* The generic message format applies to the following messages:
+ * Get IP revision message, class_id 0xf0.
+ * cmd_id 1: get IP minor revision
+ */
+struct enetc_msg_generic {
+	struct enetc_msg_header hdr;
+	u8 resv[16];
+};
+
 #endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 1384752efa7b..f3e78865617e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -87,6 +87,20 @@ static void enetc_msg_handle_mac_filter(struct enetc_msg_header *msg_hdr,
 	}
 }
 
+static void enetc_msg_handle_ip_revision(struct enetc_msg_header *msg_hdr,
+					 struct enetc_pf *pf,
+					 union enetc_pf_msg *pf_msg)
+{
+	switch (msg_hdr->cmd_id) {
+	case ENETC_MSG_GET_IP_MN:
+		pf_msg->class_id = ENETC_MSG_CLASS_ID_IP_REVISION;
+		pf_msg->class_code_u8 = pf->si->revision & 0xff;
+		break;
+	default:
+		pf_msg->class_id = ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT;
+	}
+}
+
 static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 				   union enetc_pf_msg *pf_msg)
 {
@@ -121,10 +135,25 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 		return;
 	}
 
+	/* The new messages are currently only supported on ENETC v4. If v1
+	 * requires them, the current restriction can be lifted.
+	 */
+	if (is_enetc_rev1(pf->si) &&
+	    !(msg_hdr->class_id == ENETC_MSG_CLASS_ID_MAC_FILTER &&
+	      msg_hdr->cmd_id == ENETC_MSG_SET_PRIMARY_MAC)) {
+		dev_err(dev, "Unsupported messages for ENETC v1\n");
+		pf_msg->class_id = ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT;
+
+		return;
+	}
+
 	switch (msg_hdr->class_id) {
 	case ENETC_MSG_CLASS_ID_MAC_FILTER:
 		enetc_msg_handle_mac_filter(msg_hdr, pf, vf_id, pf_msg);
 		break;
+	case ENETC_MSG_CLASS_ID_IP_REVISION:
+		enetc_msg_handle_ip_revision(msg_hdr, pf, pf_msg);
+		break;
 	default:
 		pf_msg->class_id = ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT;
 	}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 31ca08e679b8..d17ab5b2306d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -106,6 +106,9 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 		case ENETC_MSG_CLASS_ID_MAC_FILTER:
 			err = -EINVAL;
 			break;
+		case ENETC_MSG_CLASS_ID_IP_REVISION:
+			msg->class_code = pf_msg.class_code_u8;
+			break;
 		default:
 			err = -EIO;
 		}
@@ -141,6 +144,27 @@ static int enetc_msg_vsi_set_primary_mac_addr(struct enetc_ndev_priv *priv,
 	return enetc_msg_vsi_send(priv->si, &msg_swbd);
 }
 
+static int enetc_vf_get_ip_minor_revision(struct enetc_si *si)
+{
+	struct device *dev = &si->pdev->dev;
+	struct enetc_msg_swbd msg_swbd;
+	int err;
+
+	msg_swbd.size = ALIGN(sizeof(struct enetc_msg_generic),
+			      ENETC_MSG_ALIGN);
+	msg_swbd.vaddr = dma_alloc_coherent(dev, msg_swbd.size,
+					    &msg_swbd.dma, GFP_KERNEL);
+	if (!msg_swbd.vaddr)
+		return -ENOMEM;
+
+	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_IP_REVISION,
+				  ENETC_MSG_GET_IP_MN, 0, 0);
+
+	err = enetc_msg_vsi_send(si, &msg_swbd);
+
+	return err ? err : msg_swbd.class_code;
+}
+
 static int enetc_vf_set_mac_addr(struct net_device *ndev, void *addr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -192,6 +216,27 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
+static void enetc_vf_get_revision(struct enetc_si *si)
+{
+	int ip_mn;
+
+	if (is_enetc_rev1(si)) {
+		si->revision = ENETC_REV_1_0;
+		return;
+	}
+
+	ip_mn = enetc_vf_get_ip_minor_revision(si);
+	if (ip_mn >= 0) {
+		si->revision = (si->pdev->revision << 8) | ip_mn;
+		return;
+	}
+
+	si->revision = ENETC_REV_4_1;
+	dev_info(&si->pdev->dev,
+		 "Failed to get revision, use compatible revision: 0x%04x\n",
+		 si->revision);
+}
+
 static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 				  const struct net_device_ops *ndev_ops)
 {
@@ -251,7 +296,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 		return dev_err_probe(&pdev->dev, err, "PCI probing failed\n");
 
 	si = pci_get_drvdata(pdev);
-	si->revision = ENETC_REV_1_0;
+	enetc_vf_get_revision(si);
 	si->ops = &enetc_vsi_ops;
 	err = enetc_get_driver_data(si);
 	if (err) {
-- 
2.34.1


