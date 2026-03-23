Return-Path: <netdev+bounces-270364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DO+Kb7YwGl0NQQAu9opvQ
	(envelope-from <netdev+bounces-270364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:07:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E8D2ECD24
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44FC73031E84
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 06:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782952BEC2C;
	Mon, 23 Mar 2026 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SQJWgJEW"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD02C21D8;
	Mon, 23 Mar 2026 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245976; cv=fail; b=LnqClr/KxaX5emWtjzav1830Zj0xPl2HmwJuJhKRrqV4iAf1Y+YSGmn18ZSptEIbYdPkgLC/lg6bAbzxQaUe/bXmplNiwNh56IyU+R7Ud8+sicSt6jwcRrdUNuN+SS+nbEb7318GzVij9Hz3eAzuPrb9qVQvsYP+ieFuBywRzkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245976; c=relaxed/simple;
	bh=7HSB2dE6vpsK0/UwCaQG69LI3UUEHuXUT6qrDbuRL0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dLAU5FWlcC4G7aZb+1as27cW9QhFaJGT9ofckSO0zOQXwBuwd1SPY1J0uYmx2eg7Cw5+3UAPyngt9UiOusPDrVIVGoZmO+w4/j+IKqA+w6UItGG/113i2vkcB+McZLOiChk+qMUpZnzBOa/KfaS5quIMbRj9A0bEqek4nuLo33U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SQJWgJEW; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bh0/Dlk2BbmMJaMrJfeD7qD18n1ol42fGVPLJoCoIcjLUa/Mo2zZ6ur4vQC3lx6XqZ76ecNltDzGtI7TxiInukuNv8higiz1mPav60MU0u0dXHY4gef/qw3GSIsLegMioXGSMZIJGwkXEtGCZyQGg5xvk0i+eM2+mhcn6jTaXj0v7WwG//VgasSD+cIeLLnTezfkdYBOzhPQAa+Au2N+bXwhNFe/B9UZbi2mr7xNRbkKlRWF0ilDQbrsfLMOBWAMk+czuWsgzrtoRYDcv6VXeG4iSWIEwrpq07q1VYMxqBaZRuAGatoRh+NVrnOQZih9GLrTmdSa0zFV599eDCRx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/XZWFlsxzM+0lZxykfSK1STJKtwotZ7hmQM6Y2ONMU=;
 b=y2q3PZlQXilHQ4bRqm5spUtnYVk4ZDdsvYnAALcnA0yfAu8/VzW5TebFyPrL+FLQrYzUeUZOacSQ1CiY+JaNveuEMyzEDNDAWGVi4f7/ZGAA1OP4+wGfZTSHIUc5C/Ny0LHwGiW8M+lFVdE1rpTAdm5zhAuEIOafoN+25fAFYHEIRw0dfkpoRMRkj2oKJjckubQKKXvXUOXC7jzSrNr7YT3VMkX+XdCMYb3VpQBTkg6yLcpaSpH5QokNqNNbUy7+Q0CKdmoYApLIut3vb3jKAzdv9ts76uTNX6uZgRQryEURhueE66VjG2NvV8hGsW70X+BMaDgQ3/kqvBNjsIJWPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/XZWFlsxzM+0lZxykfSK1STJKtwotZ7hmQM6Y2ONMU=;
 b=SQJWgJEWIFeNtlqZv1e6lJVicYBPo3191O0m14OrwqM+dRHsQGAnG8geoZd1z19Pza2oIBcH81LiNQO04q5R2PfN4IIf9/jD4jG3LzWFH0iZQgjJcAjYjryIwqyL2WhSLk6UGyFPgkS9CHI+io6+PUQ75qQ98mneht5GXWoot24GY+X52gbBG0xW8CmkSswLx0Zm3uAD+A95dkTeivkK+uJhOkORxPJXZahx1CIodOGorTmKklZtJJ9jh0u6Ae+91CTd3XyXmMWCd+OaXRs5koKra1oMOqqPfHXjL7ubkC47/PD5NRi0NbmFA4z7xgrOHjXAc1DUXtA4O8d05YrleA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:05:43 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:06:07 +0000
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
Subject: [PATCH v2 net-next 01/14] dt-bindings: net: dsa: update the description of 'dsa,member' property
Date: Mon, 23 Mar 2026 14:07:39 +0800
Message-Id: <20260323060752.1157031-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323060752.1157031-1-wei.fang@nxp.com>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|PAXPR04MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5eb4be-9971-4907-a97f-08de88a245ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	55lKk53sTyOnh8ttq4uaxwD4KzQknE6oYdUtCSlAwlBEzoCeqh+Gn+26qKzvT6thI/unZin/glFx7ZkO4ASRpWOG1td3XNsfXUc4ghMPWXjCSL9UWbN9cIenZGRXtJY59ttKGUHkAtxvOhRculdNLWygga9EAzFEk1bBb/xFY3EubRoOc/OhTnR/qpjeKJUgO5lCJsNM6qX0TUfbXt7X9WeDXVWpzasoXW7QjEFRTzu876TrHx8cZFlPHNIDsnx3iDlldcU69aaV3OGXJUFSjoYapgiTcPp63futTKt0XqPFnGsyFw8QIOUi2Y9yXOuKQsJ9XZyGt/ni5dW9JPBsryeppJaWTopb+QP+oUwDh3jwp4rSNZbRjz/PH8sUnHyepxe4wYKNsKBzoOkus6TsRjPW+KkYF10lqB93Xr0bzVCmJlaEjcf9wEZqXqkGuNn1NWTrVHNEqn9cY9chLQjPakFdL00Kwj8VAlw29EZIZ7R4C4THJ+vZU7/CY7M11P4+EGT+ddbLxWORZcactx3VUHOHsYUaQZcB78EGMhkceJofH3ymQojAFS5+6ZGnB6YEUkxLo/LSozHeYPAFT9F5yYZEqx0Mqhs2WAU6TzvuEf0vjO6vOD8YF34+pIj3iVo5usMc+YODrlbIsgmHYdSCk2PdwL8ABETXku068rb2bUntoshoysTMJR6+4e58/UoDElTKeFHUwaQ5mMeNpRRLmEh17mfw5Eus1bN7vtetIvbxmvQP32dr32Vg4Ev2sGuizCAg9R1r7g7QV9Ry3R6ESfnFlAI8DZsyXVBkDwmJmYgaNLIG7OcyOU6imfrhv9f2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r4FI6X5ZPF4SYTL/9PKjwHYLhN0h/wKyllch/v08bkNGduYG3fpuuQEZmvMc?=
 =?us-ascii?Q?x5vKOEnLCcmvbEVolyMt0PyZKJFiFAZfeX+QiXtLGDQS6gHn6+ewTcLawLM9?=
 =?us-ascii?Q?vdzqR4wHsjCsXNFP+QjexaVxJ/phhcFqwacPYXEkKSRUmvhb0Jr3DRVuzoPr?=
 =?us-ascii?Q?avREESM8Ft7MHQZ9+k3EFDm+cFdi0MPlPoXlkf45F/5Ni0Wq0uIRZZtnVtGK?=
 =?us-ascii?Q?5KzfD/dzUGJBb+yTiLRYF8KLOglb8P2YVqn/f6mlg0KyOGB6iwVVrwg/awqc?=
 =?us-ascii?Q?Aj6/UKhoSukQDeiN+ZUBRm4IXH4uFrxgkno0FVzkkSJpodtFfx8a6YU11s2G?=
 =?us-ascii?Q?w/aZG0BN2AG2J9vUAc0bhcLPKVrY9PUfoQBfogtxMJK9+JuitQLH8g5ugaeY?=
 =?us-ascii?Q?louYLPT/V21wifvouWG8ZcwHpKY81zo0BnSUWT9nd/vFVQdj9z+nV5NTYyai?=
 =?us-ascii?Q?KHTZN5yg/+aIwxLd8r2OvE/ssmtN1+MKzMffUgGfFF2V2MI5cq7TxdAloHoQ?=
 =?us-ascii?Q?F9nEuJM5w2xlrNrzIbOrrc2bKrPmg/HD899o3XNVYr/sLPFT2jkZbdR+uE3R?=
 =?us-ascii?Q?j16kNxmgD2LHgZwyg0TjgSYIukkXNhrLSlFAfA1nycmi8bKWo6q+KYD0fm6v?=
 =?us-ascii?Q?yoWKp9PUwuS0nb0fY5RSOdRkKm1LdeBalkS1tYOdWJOWku9bR43K+N7Z4RM7?=
 =?us-ascii?Q?cWPzmoM8/06+bAQ3qagWSsGZZHOvJCrj5d7Q62XUgp50CMDSog2lUfXGJlx5?=
 =?us-ascii?Q?U4BUAGOBaivSk0BwkNOkkDnPPSE2+0vZMkksOu5bxlK5BFHI2AycPTC0hy3e?=
 =?us-ascii?Q?iz/Y/KBuxtWIm3Qwg8vR4HLR3EoK0V0v4wUYxqmTDoelu1u0laWkfJasdzt2?=
 =?us-ascii?Q?RXWT1HmkOc166iUcybwm/i5QSvfN7omvqbFutImLPOvpuluuumpR7P7h+TRg?=
 =?us-ascii?Q?GHZJR4Zp+hbLRV0wtuWizcY4P7azKlkDmzqg4FvoYSsEmlir2UxHgWMeElXq?=
 =?us-ascii?Q?uyqyX30bIrWGKMvKcojT7+KuMOY65A8TXvExPXEoGQq5nXeyr2SqNL33QouO?=
 =?us-ascii?Q?wDcH78JJvuI4YcfIk2uCT8Kpm/rXaeuy/zVG8M27mBPiu20RT/nTfEWpGSOC?=
 =?us-ascii?Q?09wc9kWM5/zGz+Q9aTzKt/p33RDpKATryJqBc5nNCInVIrdp3VvxQMi7JA3q?=
 =?us-ascii?Q?Ipy3gU539ki6iLnz0WFjxPdCxDOqB9gr/yB0BPym4Qysx3IEevobvoWwXzZX?=
 =?us-ascii?Q?+CNrl4S5XPBUa5/iXEIdCrb3YjPkXAZ0DvS18FOPxDo2wmzTLTNossSh7c8d?=
 =?us-ascii?Q?KofaglLx+HdTHtIXte1nm9UcINHTfxbqekip4F1uY8deT5aiZ0Xu0VC5buWV?=
 =?us-ascii?Q?emnN2t2oF1LPW6+UFG4CQXCCFHTFWXGHl7U4xvXOlu0Qv26mK9B0yYvx5d8O?=
 =?us-ascii?Q?7mcHe57d1su74L+r7V+MhNEejYnfGj82mXXhBMdZ1xD2xc5uzzu8ez2JVdQv?=
 =?us-ascii?Q?KbftG4EjjsVpE1UbqVnhSxy1gBztuQCcb1z3RZe/tcJvDEtwlpsuDVSO5Vac?=
 =?us-ascii?Q?o1HziawrN+Vq/PYXIfa+00+5iLiwP4K++CD9DMXR+Vs9RXKvqRTLnSPnmf+y?=
 =?us-ascii?Q?uWN4eIowmUun300oFM+eJKizEFambVmQmeVS3URCa0wy9aw0FTt//EP8BjVh?=
 =?us-ascii?Q?TFdZGSFOi4Y6chxAEpSGFt9jaeAMHs6hKX35F5vh0LhLziVJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5eb4be-9971-4907-a97f-08de88a245ca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:06:07.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpyDyHKEqiHTraQ/I0TQoOuD1CyhKShYCrmgbs+nwiqvTs2vUtk5h2Tg1nK7T5HrXI1ig5s+AR1IxPRj+wQeCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270364-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10E8D2ECD24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current description indicates that the 'dsa,member' property cannot
be set for a switch that is not part of any cluster. Vladimir thinks
that this is a case where the actual technical limitation was poorly
transposed into words when this restriction was first documented, in
commit 8c5ad1d6179d ("net: dsa: Document new binding").

The true technical limitation is that many DSA tagging protocols are
topology-unaware, and always call dsa_conduit_find_user() with a
switch_id of 0. Specifying a custom "dsa,member" property with a
non-zero switch_id would break them.

Therefore, for topology-aware switches, it is fine to specify this
property for them, even if they are not part of any cluster. Our NETC
switch is a good example which is topology-aware, the switch_id is
carried in the switch tag, but the switch_id 0 is reserved for VEPA
switch and cannot be used, so we need to use this property to assign
a non-zero switch_id for it.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index 2abd036578d1..801e1411e5c2 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -28,7 +28,11 @@ properties:
       A two element list indicates which DSA cluster, and position within the
       cluster a switch takes. <0 0> is cluster 0, switch 0. <0 1> is cluster 0,
       switch 1. <1 0> is cluster 1, switch 0. A switch not part of any cluster
-      (single device hanging off a CPU port) must not specify this property
+      (single device hanging off a CPU port) does not usually need to specify
+      this property, and then it becomes cluster 0, switch 0. For a topology
+      aware switch, its switch index can be specified through this property,
+      even if it is not part of any cluster. Also, topology-unaware switches
+      must always be defined as index 0 of their cluster.
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
 additionalProperties: true
-- 
2.34.1


