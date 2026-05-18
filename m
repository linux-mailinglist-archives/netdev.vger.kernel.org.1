Return-Path: <netdev+bounces-288828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHJhH3yBCmoo2AQAu9opvQ
	(envelope-from <netdev+bounces-288828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:03:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FFD56540F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF4293001845
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9484437BE84;
	Mon, 18 May 2026 03:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DdCCiXQo"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7AB371CE2;
	Mon, 18 May 2026 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073391; cv=fail; b=Tm2JEIYiVv5zqcvFve3bQTvq47h5ST3oa/HM0hAovjifEPv6+YOfadMFDwzbYCjqH1kOMyfKH1UpkrDvp2fWmlz6pfpNSTEulKEovEowFQCIuhWNE4P1ZJq1Aley/SIisq5jqkqMgtG/3srJ2V26FVOjjkN7NsjVGl48DFZOMzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073391; c=relaxed/simple;
	bh=kQiEtPCeww3K5g0dcUTvQ1I8pXfAQKsncyjvkQo0MAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h9GCtybl8W+EPY7xZ/GYjtbqbqIYWDYqZ6Qu/BSBnx+iCGhvgrNSKl1xjMgCRzFS3WtJZmNEjUhSqWX6tL2rKM9kFBjGX4jtfcgqN+SeAtzI6FDBHK8KUAZmrHqy22ziT/o3kGZJsWdkm+hMfwhUR0w5ibfYKGoDRQa6TEI0408=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DdCCiXQo; arc=fail smtp.client-ip=52.101.72.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTYbq2UsvIQYtPfLgxrNU4/rBh+rlblHWUrKz1tq9CPUyjeg8kfVfSPxXNznlGKRfI80m6WKjSGSPEM3Ht83i0aY4sHhlpjaD/A49jZRKzCMVCYEZcyKZkw2j+oAAn2rodKXCrDbfPPxAahc8PP+mPX0T9TQsL4t9wrOtU3hEmJAcPSDy69PECyYYt+lDHkTXHC32k26orSNZSyinG9546SbYmJn8vH6TwN9ekBpmL4T8F6KVRJkd85uCzTAt5iOBSq0wM68PkvmgXjt7SmlN6QmvJweCOxalaa1uVDDHgjnLhyT83jXHJl5eYo0R/S8AmbPdnwWoGam+D/Js6hjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBS7zaJm4TfeW89NBHCAsnZch3rOYetmUAJ3mUd3eBQ=;
 b=bnrQ19cFRAAeDYxAXb5zNmlVC3NX2D1Z2efpGiBuAAv17VNpcUwajqcRuCLFC3tVqUaigTrBiAGptKIQxldQGUSCys6ZSMmgAVBTrE/S5IfLteiKMvW2Xhhw9Qd5STfaUaTGNRwpatN4a76QLDTezaXBHlmQeLvfulHLqdv4t2bN67ypuaeTJ0AU7iIBNFip7yJuqI5BL9eaaBOLbmXpcQXAw8SHSFn4PunvACgX4nlhhBIFI0IvRPTNla1XGJCh0sktNum2Ivn9PFJZOFssXjbStPXg/7hySS/TZXpFZtByG3xEZfOfpqjR/iJPaT9tjbTyDrsc/+W+RbbSJb+E3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBS7zaJm4TfeW89NBHCAsnZch3rOYetmUAJ3mUd3eBQ=;
 b=DdCCiXQoB6kyIgpe5aaMxVAGsQ/IqrPoWyTJ5wYJo3zUp9dyD+ArlSxBvIYzPk5urJ10WuqcWKlMAVqGuEuIhpnPCAhZxSmriQ3fz4zMJC8DxYcATtDCp+BERd2ScptOG3zZZ7pXGs0zBSg8gYkktc5BSEX44G2KM3A3EWa07WGxjgWZxJwIUVRUQ5aR1vhqw+xGvtw0uHdIeoBLJ6lYCZjTZUQVIvQrVkKn1rjPClDHV8nIPz4el2oRseA3qBhl8rKV7SoxGChc7bxg+1hGfwpc2GWGa9fM/yk8NDK3oE4OBtMf7oxSko+NarxAKmOrigtHVVOkhLiaSa+Z867Y5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA3PR04MB11180.eurprd04.prod.outlook.com (2603:10a6:102:4b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 03:03:04 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 03:03:04 +0000
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
Subject: [PATCH v2 net 1/9] net: enetc: fix incorrect mailbox message status returned to VFs
Date: Mon, 18 May 2026 11:05:27 +0800
Message-Id: <20260518030535.1057228-2-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: be3e01fc-b5f6-4020-ba1c-08deb489faaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014|22082099003|56012099003|18002099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info:
	tA6LQcLtKbl3Q2cfhDI56ZyCTkpccD7ch8zSUD0khMI3x5lGzyvg6VhQAN4VHxwBdwB5TU8H2R+PIsTwZdbBE9TUP/wzu7S2ZvJCRN3U0eT3+KAgplMM1uOm9p1HE6df2joMQE6qqUicCxxbdLEsMa0ac6Ge0q3gyG9B2MaU1S0FN7tl6wLZFQqpDQNu39WEqT9d1N6QoiInm65YCvcKWxI0cvrR8i0cUOYOvVlcKTuanNWjhZuGJwUcQgMBbtHxdwYso/Y2ehJITe9qB9LCZCieKORaPF+y9Lv+kmkYqffEkESW6pSG8Jl7QNaQBMn0vRu2mK0d53HJ83o6SW8OVINSNlJHXRMo6vGrzFln3hhciEyjg36t6uLBuSq0MkOOq+9kGVPFELAOSlqUvn7EYW9DuNWXAInTUOdR/y1bZoDr1f9ehOVJxH9vO81dvstgzpBN3EYDphSS5OaMgcWqIKQ7InUlVJQoUzxJ6sgDnkcA5QqNWeWmJTqREHnPKpNvQijTkUi6IEuWsucs/gHOdi6IPFaz3i3XTvFT0G+rQ5/Hp/MqBbPcjFTUi+4Jg0/LDgEAtj24w0p6zziEI7rbNR9FC14fQmtMSg/j04R6aF2I50dNYd26w//Zee7daSiUfsXQ3s7504vH7bGE1SaOt9D778hA38TxNyXXjdysZsW5d3y390YHxMCACZfruAt8Us+ysrXxNEGD1t7S1hhBZQcGfPnN0LL3BQCsmPT7RFOUGOHQ+Dp45TJkNMsKdj11
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DHvxMjmEVYtcDOvVaIISGGNl9EV6jK8aueYG7DUXEm1/NmFCA2L+8iEu4VbY?=
 =?us-ascii?Q?3urDA79ED7x+tX8Qvm6z6qPHO++ZVaM488tr6k5zB9iXeXgnPX0Ma43zGxEE?=
 =?us-ascii?Q?mPd5fBvdlphHevIcVBIS2IdQWOP4iM4hd0tpXmripi+YmyPg17ICW83DO+h7?=
 =?us-ascii?Q?lu+mD+1N1PiBVXLwfFFlU42o7s1om11a48rLhEyWPYsOEhvwSEHthtcQFRmW?=
 =?us-ascii?Q?L+1becRuLb3NHnIrdsv+RlXZgSshakJ/v77ER8uHLDmPOfMx1/w7LDswZU65?=
 =?us-ascii?Q?pIFQC1oXDl3M++fPBI9ockxOq7BGka2T1H3cUWyWGG/MGG7u93W7xG5hPQgU?=
 =?us-ascii?Q?lOY5YdtRjYG2grYy5ufNj4VFaiyeIhiBQKZILFEXvFyAjEADTC14OrQvtKPC?=
 =?us-ascii?Q?aIgkC4zBi3MVDKXJTa7a9YkA8esSYOYFxWEbv3ORzaMwpim7UJQeA0EYBlNS?=
 =?us-ascii?Q?FZ9W+XN7mrQ5ZOpUzx4XF7fsy7EXKWUon0SjLbk5hvnUDPnh1AeCRty6OoGV?=
 =?us-ascii?Q?hiytWhAgEna6jVrmaqsI/ov8+gCDWcue1FUH+vLbl3VjgOofxpZ4A1dH26zo?=
 =?us-ascii?Q?9C9QccD5ObxoaZ97U1nym90/WcR1tfVOLORGtr3WK1sGxJAcJIIsQ7WE6iGL?=
 =?us-ascii?Q?bQvW5yn2y47N0zugse1VKUnOjXOGjse9G8EszpL1BRDpbsJRs9ZlM4qzZP+S?=
 =?us-ascii?Q?o2e2TkWPryi8XCeJc76h4/0CT3MctmsjSj8qnJVGkg9HlNUiwOZKUMNuYnYh?=
 =?us-ascii?Q?INOM+P4jAnnSyxaFwDpn7liKCpDctQvengD1D8RNiDjybnVFvLWX1HKDGllJ?=
 =?us-ascii?Q?TKLMA+wZ6wpnMTh6fGyDuniXalGVT/vQA2VDEQHoyri/5hZmVdz3ucNjpGht?=
 =?us-ascii?Q?G1nsxnslwNZjN1/aNdIotVoOvnRvZuek6f/Ckc/iEQMmCysiabwfECc/HLPD?=
 =?us-ascii?Q?VCeJQTfcLGwOMQy35pTmKW78oGrVSDuEfZC1iRZANEbHr65oSGD70US+Y1Wr?=
 =?us-ascii?Q?uyRgBrR/Ai1VA9o4LbvbDR2hEgL97uLPsWMfu12gs7PdhE3JePEEiGGnltfH?=
 =?us-ascii?Q?6niE63jzSzDFkoeGmt2CHQQbcW3G4P2Ud+0zC9tbO8Ddwm5cN1j0/jySjr8E?=
 =?us-ascii?Q?uQ4uv98ZD0A30RvwnaajNxULQI+h+TCcKlhL2k3MFFlF3dz9P8sltFeu7ESL?=
 =?us-ascii?Q?yNHAriljFoxgaPs1GdaOrD4lKL3H697GcYnPoQCjKUpIYEVs4x9sbA/r0vaS?=
 =?us-ascii?Q?E33DjwseByGtJ3NPkPVsf2JWsRE8A8DhghJuSpE37tjp3dTU9gXvZ/pDarp6?=
 =?us-ascii?Q?xLdonJg2+fmiqZmhBF52S2vme7fxrVGt6oF3kdwzL6wDdbBpimAvPwr2WBK5?=
 =?us-ascii?Q?ZcefFqgpTRBDsuVLTpd6NnE7vAGsgrITq6YBDIMULvrD0od3bVSYTl46KwP4?=
 =?us-ascii?Q?5OwMPUox8X5PsGm1YsGnqY5ly7mDZUdBIYv6KTncQALHOZWYH4nwKh694ZYb?=
 =?us-ascii?Q?FSGlVldyAiD+PIx3bnUFBMiAVIugZfyesnQvcw5AXfckFLU2CybHnCd/D9np?=
 =?us-ascii?Q?6k+M0b/FeM7Bt9louftBzjGzSQlAqxmt7EWAmSqvATunK5vGyfcQAc0b0dMu?=
 =?us-ascii?Q?RVvp2JHlHhP0HnTB3btt89vIIYR3UZjRCWlDdRKxMzO+tzjRivH+VbpyRZdC?=
 =?us-ascii?Q?5LIZG8qcVURgrGT9Dv0TxomFCm7BXd1M13mrJJIRi5yKCd5vUT5HQ5ztv7u7?=
 =?us-ascii?Q?/2CnwjagqA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3e01fc-b5f6-4020-ba1c-08deb489faaa
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 03:03:04.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRNwabxwk/KK/+vT+QrUcXsF8q3R7jEuXaUVVkH+TApFsAiJMiQgTFgMwihp93rkVqnAj6pVnjg4bR1wPyuD3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11180
X-Rspamd-Queue-Id: A0FFD56540F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288828-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

There are two cases where VFs receive an incorrect success status from
the PF mailbox message handler, misleading them into believing their
requests have been fulfilled:

In enetc_msg_handle_rxmsg(), *status is pre-initialized to
ENETC_MSG_CMD_STATUS_OK. When an unsupported command type is received,
the default case only logs an error without updating *status, so it
remains as ENETC_MSG_CMD_STATUS_OK.

In enetc_msg_pf_set_vf_primary_mac_addr(), when the PF has already
assigned a MAC address for the VF (ENETC_VF_FLAG_PF_SET_MAC is set),
the function rejects the request but returns ENETC_MSG_CMD_STATUS_OK
instead of ENETC_MSG_CMD_STATUS_FAIL.

Therefore, correct the status value for the two cases mentioned above.

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index a12fd54a475f..27d4bb65e017 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -493,11 +493,13 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 		return ENETC_MSG_CMD_STATUS_FAIL;
 
 	addr = cmd->mac.sa_data;
-	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC)
+	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
 		dev_warn(dev, "Attempt to override PF set mac addr for VF%d\n",
 			 vf_id);
-	else
-		enetc_pf_set_primary_mac_addr(&pf->si->hw, vf_id + 1, addr);
+		return ENETC_MSG_CMD_STATUS_FAIL;
+	}
+
+	enetc_pf_set_primary_mac_addr(&pf->si->hw, vf_id + 1, addr);
 
 	return ENETC_MSG_CMD_STATUS_OK;
 }
@@ -509,7 +511,6 @@ void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
 	struct enetc_msg_cmd_header *cmd_hdr;
 	u16 cmd_type;
 
-	*status = ENETC_MSG_CMD_STATUS_OK;
 	cmd_hdr = (struct enetc_msg_cmd_header *)msg->vaddr;
 	cmd_type = cmd_hdr->type;
 
@@ -518,6 +519,7 @@ void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
 		*status = enetc_msg_pf_set_vf_primary_mac_addr(pf, vf_id);
 		break;
 	default:
+		*status = ENETC_MSG_CMD_STATUS_FAIL;
 		dev_err(dev, "command not supported (cmd_type: 0x%x)\n",
 			cmd_type);
 	}
-- 
2.34.1


