Return-Path: <netdev+bounces-271418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ5+LlCHw2lRrQQAu9opvQ
	(envelope-from <netdev+bounces-271418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:57:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A32E32059D
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 585013053B1F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A7B3624BC;
	Wed, 25 Mar 2026 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lG+4oKV0"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F5A35F60B;
	Wed, 25 Mar 2026 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421704; cv=fail; b=QBZBZQsRrnlxDknv1keznVNl1S3gsrxTEuFuXjBmU8217Ho2fEIHSNrRSEInUOnMhdFlu3HyzsQgA7YB0EgqrMhnmAewe0qZak0ulvwN6ZrOVeyfGkkLiKw6RzCkCD6ml8UDcl9RPVX8p9VJEVb0tZ+mmVaqXXq4NcZbl7alVIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421704; c=relaxed/simple;
	bh=3K/84AsH9G3E40N5VeFEGTHnjvGOCzwLs9oCYr8TVjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iIjZTnD0QZpgdZ59kYgXXEKPisFZcmcMUA1I1rnMdUoTX8zCWrJqGxzDd1ATPeyX8GSsJcKdsL7E0idC+geMjqzNN5A0R7kfbg3UOz5w/nVaSkklzo0yG8ETqug+4vMXCiMq/4ACLk1Bc36z7YjUihxZqq9qMfBa6oyx2Y6CNEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lG+4oKV0; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeR3fET8wo3lwUbuS6CUSnAMWEa0kBYH8JzhKXnW9kF1aLB8wBJjPSV3FbaCzxlRUm4ybuWb0LF60kfMmXHttWulwtTsFBa3dLc99mnBVrDudny1lhMzfzqLemvB56D6jrhBUhrxjCQtwFnjewDgX7hiIIKZT4qn1i+SvWXTt/gbnGvINT9B6GDmBK43aalyg7yg9AaC1yubBilpj45u9Ly6/GN8HGOEagn0USTebrFn65PiUbpTxdZUbRnhhiFnlWm7TUph452hLoT1GGX41rVS2e8mtBDFuSTWiS2uPTQX8PhNYQUDmyFMsx3hHlMt2EFSlzsJ20QlEndoMElhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfnxgQGL5ceFXyXTgFz3rOF549xSlY589oIk/zi8jw4=;
 b=T7R6pqsKbgfkjOALPcRrEFAO8ih/AskO2FKULtVTKiyKqHq/QJOTTb6/ZyCnbaGbJB/yku0PGool21FzYGyv1l2Dr5+EmyoyTSAbbb74rx/oSXZUyF8zmVMGSJWt1rZIbUvtxLLt3/tU0MbwiWo5YDh++Dzk7tDD8t1qQ8BnsNo07XM0uJoGoqPVRzOEwKsvBlDu5NdG7VtGSISIr8Nd4obxIP+/mc6qm/8CXQkbkritwjkLAXv/5RuzEyNeVOU8BhYTFVYHM3SRQuIbJ+PllKxvVr9RHMPZ8CJ5T0dIqnUvHjAtAAxIPxMV5yUWelCElpcWypdb8Xc9/MGoRdpTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfnxgQGL5ceFXyXTgFz3rOF549xSlY589oIk/zi8jw4=;
 b=lG+4oKV0tFEcfmMDyGLYw3mz34s9QEcGj2c3yieIeeNbXCix/N0gVaPXv4g6YC4FAXl65cOM0NeiXvS93JCNifHoDSv9bl7IGtYPYbjxHgkvEqyzBN7dwJUHqBTyJrvp1YO3EhOERYsAcaKtFGrNZF1xcbMPV0dupZuutbLSpAX9rcOqmS1pg2Eg/+LF9o42OAqyyvIFoUY4eNRwEt8AWGE60UA+9gzuas70gYPD5ZBSmXvpzmZLz3zW7XpYVv6m3D9yj4dtAIDGfw+vdD8/K0ma3dU3avq4WDDLZBzysjGwVSWv8J45u2VxSa62gNCqwVA0+GMdXTU4m53JCzYvcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7459.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 06:55:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 06:55:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexandru.marginean@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net 1/2] net: enetc: check whether the RSS algorithm is Toeplitz
Date: Wed, 25 Mar 2026 14:56:46 +0800
Message-Id: <20260325065647.2882997-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325065647.2882997-1-wei.fang@nxp.com>
References: <20260325065647.2882997-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::16) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: c720ac30-03c6-407f-58c4-08de8a3b6fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Yizet90ol0lvm8x77dX53Zro0rc1hrXu5kfn8Ntspiv6AmpmBnvp2whvjPRXQ3Sjua2C8JRXw7UX7XPRaCqVywVYe//RWA7cNLIIfnQ78+Ngfwln7ZFH5gI2AC0Cznfc705yBwoY3mX0U2hqpE0V3cSP/hT+7zZsLJWCEi1gOgB9C4/xBtpYSRPDtMmXsM9lAh/bGZmucksRa299G8qtFygcuP2Kkw0S6G2SHsKlXWjzvIpIwnFpaa+qDACraDCn4jN+dqQWM3r4y3T845SkuEtOPSxzQK8EJEEnfWwU4NRoCxzhuz/ozGrcwyQaQ3Mh2AaJr2X1f/CrP/UpUhPCcGAFQ1O0EhsLMBCFntXmDXnZzWD5Qt5GAP7aYR16R4fzbgdaZ0hgzqGrxP9eEtfo5k2+7u75ne9GxNQFGpSWhfxSyv/vwzd/mibLvIFUSzkYD2cASJBAmcG0n2GerWKqLoWB2xnyuG3mQJGcnvXlLY8YyaknHmp7QTjNCQVgCpXh7uJvWZ+UviOY+zCSrfyAsDossBru6SLEAl435ahic96y/Iufjwx95kznb9JDuoJA0FsrnoNyRbOrfL98hNlcKx90y2kS6bs9BtGmR7xbedFxwyVRUWbqfJF0HZ1UwLq5OAaxTUNWBGpJ+SdV7LaHmGRtlJIYDgIFV5wt38XNSGxvfgRWlB0OZXO/OmA+FsrfY9jjKfrNlNmDAqZZ6ARpg382QT24UMl3m8SoFXufQLqzfurRNXucOwvjKvOp+rDKMhn2Dmu2xmuo4B07vTGdp7ArccDt4UrXeUYLPVWckwA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kL1tI77Wn2nr8sWOCSgMv1ZfidErh1WhA9Lbks7X3SQk3ImtmhsPuawqPjDe?=
 =?us-ascii?Q?C3clC0pA9lbS7EJ22fl0nrBS4AGkenOzEG/KlEDX+X54iHdvH5iMhZh5w9UL?=
 =?us-ascii?Q?VYTIyltrXTAvIQfbODJo7pBV1qvk4uDBd3P5AXw7pQyoAKg3hBtkqXw2Rxy8?=
 =?us-ascii?Q?HbnlGqMmLxpgKpC8SjHzrVqo4LTh9Xv2R0AgJN66jhW4VX6DHFDXnguFyUEW?=
 =?us-ascii?Q?bzsWbDhjQ+MQ2KyV7dm58epCSgtqZ9ZLoR93DYxKLTcNLWRm+GmW8DtLNvh+?=
 =?us-ascii?Q?BJvbgCycvxHQmlbjzo1zb/3QAS35kGjkO9nJX5Zg5tEvDosMQXatjZ4YG2Lj?=
 =?us-ascii?Q?96iiBpcFYNyQHF9uOV25f41hPI7CgI0zS+CwC8xmz0qdIyizNTVZvHQw7Qr4?=
 =?us-ascii?Q?PXWoh51tv+j09PtQr9P6agJI3PRlTeMXSYTIPItq+LbTTJUG58RV2z19h44L?=
 =?us-ascii?Q?e2r5tptKaUT68ZLHMnII0Mojq2cVa8GqdjenneGbsCDh/8TV2V7ncmHlCnpR?=
 =?us-ascii?Q?4RRQA39/5Dwfu0CsggZtG+hy8JQdWHor5/45Zr3jjCYQfiba7+VppPJnuqhx?=
 =?us-ascii?Q?NBhjP20eLCpe+AHI1Cs7Dw187RPju8u003ZL6gxrq0E+c7H4XPb3KTkUH2k0?=
 =?us-ascii?Q?RvmbsI2f85zKdQuIbH7ni0SsSsrlwIKXDmm7JA9PkW7ThPttoxMKaBUV1NMc?=
 =?us-ascii?Q?F7JRMfolIqH5WqEYJmE8A9THz7HwYYxPNDE3uTD4T8xBXbXqF4QTfvSTlpSw?=
 =?us-ascii?Q?odH8AlOl9vPM0p78DMa0unNMgnoE7VWyJXau9jdBs14d17RCj3FcESs317eb?=
 =?us-ascii?Q?ChaIkl5aig016w/V3QmSW8xZjDvfG9ZATpv+4vMqafuA3NG++BitpAKk4176?=
 =?us-ascii?Q?QFF4fGUWwHFrmvHH+kv2hobI0nxUXzMor87et07daSBxEXIgSFTZoWtRsiNz?=
 =?us-ascii?Q?IYq7IGAU9gACw8Un0J+zsmrYcwITBeuGnrdugMkC5j3lfMkenpZ/yg4Zz+6S?=
 =?us-ascii?Q?TwkhgUpm29zHCEd/qDYkBsku1SDwkvr3kDS1gxSsNXZPduWMxmqnPqE7s0fJ?=
 =?us-ascii?Q?49jn85F03NUVHcDItUPcxv1GHKMHUG95DvBhI4wKw77q6IYhexI2SjJOTO9D?=
 =?us-ascii?Q?0S9M1rDX9G3RPpwC+ahYIEcnqkBsDPOvdlDeeVu3nV8iOUtfusIO9PgfTXG3?=
 =?us-ascii?Q?pJ6w9dO+avpIRApa2AoHyS9HaurCo1yk0VxUFP9t5MeOGKZd8wsVLz7jyd27?=
 =?us-ascii?Q?V3gRE08YNsL52u18NIhVoOK5J228wns7NrDZLpfBUCCZ9YCEFNLp01XH+Mvi?=
 =?us-ascii?Q?/SASGjCyfnZQmimZ4a/rb7/mPvJ8f5P5C2NbtrmkdWdk9BKCbtR1Kx+RwuA2?=
 =?us-ascii?Q?eyQDM8+sILNBqGIaqnP6wijkWP9Np2Qa0RhnHChOrqtViPJlWV5c67Wtna7Y?=
 =?us-ascii?Q?Z5YD68xnqLMDVJK8ECg1CjnonyD/G4UuM0toYR+5s9yffU6QDAhyRQb3hTTp?=
 =?us-ascii?Q?uo3YejUQ5HIYYgqP0lmfRgYMjlZ7C/Q808MifSr4siqywjCjnQpn75LSSnNg?=
 =?us-ascii?Q?CjRutF5c6yXOomT4LzCBLa1BL5pGA8KuAHKwYxMEclZifG3PBpfPr9paiC5o?=
 =?us-ascii?Q?JLuXHlX1dGHjnvrvPwCOa+zqvWFTx1RRfdeHa7ywYkxf673p+zcm21cg4D0N?=
 =?us-ascii?Q?dA44LX9iHyt/eWm4jj/3Rx8XW9Ega5e9N70ZGQmxM7akJGmIr6d/ZByB+e60?=
 =?us-ascii?Q?xsLsDZGxtA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c720ac30-03c6-407f-58c4-08de8a3b6fb5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 06:55:01.6331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpO3xFF+2ugmbq0wWoP9SMg4GSLBLKUVnLIsZPbTGKZTuFP+ZaqPyATi7kgXPLs0BB60AnGMlx4di1U4e5Pr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7459
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
	TAGGED_FROM(0.00)[bounces-271418-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A32E32059D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both ENETC v1 and v4 only provide Toeplitz RSS support. This patch adds
a validation check to reject attempts to configure other RSS algorithms,
avoiding misleading configuration options for users.

Fixes: d382563f541b ("enetc: Add RFS and RSS support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 2fe140ddebb2..a393647e6062 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -795,6 +795,10 @@ static int enetc_set_rxfh(struct net_device *ndev,
 	struct enetc_si *si = priv->si;
 	int err = 0;
 
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
+		return -EOPNOTSUPP;
+
 	/* set hash key, if PF */
 	if (rxfh->key && enetc_si_is_pf(si))
 		enetc_set_rss_key(si, rxfh->key);
-- 
2.34.1


