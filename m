Return-Path: <netdev+bounces-182493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71F2A88DCE
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5301899659
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713231D63E4;
	Mon, 14 Apr 2025 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W+sd9bWm"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426F517555
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666167; cv=fail; b=Y+r9SGzWq4q/m111xsP60/NCsJgNRs2PcLSIjm70zVkMBMhMxmE5uB1NZznCXQHk8s56sdlO7hTDWgbaK6bMbdlYsuRlmRu8xNS1ugXr6w4WYR18z0WoB4ro7/uZIq0rIKJXbPPJVp9agKQvb68OOhGgIUVhhWoEdmlIodhbePA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666167; c=relaxed/simple;
	bh=Ci6FtpM4IjO1r+LRn4FiSIiH99QXb4g4dz8FCK+YEEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PjCf3PgqkcF9TfLYNX19rUmx/OXLQagBMtalAfEFyTAfBlqNNXpXXsV4tzB90skGWhIP7yPV9D5NLBu2j5JDFMlm8EMG6fMBxzSLE4eeU9pqou07g8U2+SvZyh7ShSJkEqdWe5lZv97peKv1NPVGT4oz2G3LEQiyfm9aW6T8V30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W+sd9bWm; arc=fail smtp.client-ip=52.101.66.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJF2XaKh5Sj8SRd5xWoURonVili9DoIeh/CUcb1SMblIzgpMnDqL/IEZvvszVVnDDP+X0no0K7O3CWRx/DImaswWj7LOmYoL7Pyyu+N7ESQhNzZnTDvjHtibjNxyU7DBFYkqS/2Uq+NVItdBAy1NlwzMTNTERkqNLQ2GeP4rb99qOT3hjIZSNEC80T3LehHSnGJ+DBPk3mAVJS3PvDQO5NLQImVpQPyvybpNRhLQ8zgTX+Bt/BTz+Xjg2xUa7GSZXvXjhsexBZ1q95YRNdsCH4uIWewbleoHu+wyl9aYauAyvsib4wzOqcdWINEQf9prjm+iSfd33x2zx/qgF4j+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8MQVRCn8Un0/z08lpKpNB2JWgwZBnluL4+dZ2xFk2w=;
 b=kxZy1uaUaYjZGGCkKuISWhVAOUFTSGXwG/SwdWOc72iXfGh9iudkjqoXe1m6ODcLeeynRIHCQ09DYKSXIHwzodXxcCESXSQPfD11K51OvU16EkK/Ipz+I6KPmJJdW0ul87aNw4OMDgu1GVafTAmqU2QpM8r30OI+fzMU3T/iDs94NJkJ7BkZ88Ydr8bMCNWTY2ISuIFhD+SAske+3Ed80NutwEdxDh34URDOCYeAYu+NOPWzo3XQP2EH54FxEN354D7Htr5OP0PUF8hV4nuh8nwFDg6VwmbEFxaerIJRCyS2mPVZsrKj4D9FRfIb1NP18icPt9KLvabMOdA4/mj9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8MQVRCn8Un0/z08lpKpNB2JWgwZBnluL4+dZ2xFk2w=;
 b=W+sd9bWmgeCbtrfpEWNnewADNve0Em0od3QaPdB9z073SPJ4DcKVaf/DZazZ9u6cne+G2/hLbXWolhPK+DSYNO3vQQIwUAEl3YfnFVV/ZLioIRc4n1waf3XsWQaNQvx9EHcW9pyJt5kYYm9bADavakoStII5u9AkJY8zQt/8iHaNmu8GdRFERqvBhW8ZAd+RttSBOp3Hto2J36qp3CZ3+KUeF6kfrF3ApNtRqjHRi1tUQk5deOFvdE/Q6p0Sxzotf2MByTuDoudkeV78fFvezojypOQfSgAWn2X3qoUi1UbRJSQL3Fj8khCLukhs5i5vHV3aJ7fJUoumyzr41JLkHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9506.eurprd04.prod.outlook.com (2603:10a6:20b:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 21:29:23 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 21:29:22 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 2/5] net: dsa: mv88e6xxx: fix -ENOENT when deleting VLANs and MST is unsupported
Date: Tue, 15 Apr 2025 00:29:13 +0300
Message-ID: <20250414212913.2955253-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414212708.2948164-1-vladimir.oltean@nxp.com>
References: <20250414212708.2948164-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0177.eurprd09.prod.outlook.com
 (2603:10a6:800:120::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: f85b5d0c-cf3d-49de-9c8d-08dd7b9b6c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SnWC9QYPvw316GEVRZhENvvfMOSksqNTHnEalNY5JBg4aLopGwvk9qSqBYM1?=
 =?us-ascii?Q?r6laBUXfC/gnrsZ6aSKis0hQ1XhirsCjn1WihmcmguZUHvrrh9idfAhGw1Ze?=
 =?us-ascii?Q?gXRNafzZ4LMU6Cj7M/vJCoHEm0ysR7crus/zWGEG2KJpPjmAtfde6fwp3aXE?=
 =?us-ascii?Q?1kVj9qeMIzAXdJ4smntrlazBII3qgBB0t7D+PkQCXGCu5fHhmOl+yVWDHkBI?=
 =?us-ascii?Q?pbT/MXZPyGPGgdn7gNRiwXEk/UOG9ZglW5QfcrqcCCoE99FmaVX/8JtF1YHG?=
 =?us-ascii?Q?8A6S9v7YYAvaQMfeqLncIbULa/gbl3C7dP64Ky3/n69WZGNmpRGELi/xFKoA?=
 =?us-ascii?Q?L1vGXe0LoXF3C8qOKz+MA6FU0aoPsayICVF8Hj+UHT/7ESKJ/jQhxTOqXGhV?=
 =?us-ascii?Q?GRm3+ZUecUozapnL8kNQdi1AchNVpIv45lAAgtGFCeef8bmL2P8uoM8U8duH?=
 =?us-ascii?Q?fQSlqLRq+LNuaxmmHljUEWhNDTEsjr3ArMH1N3MWmBIDoGVmWQLriGxqmy+V?=
 =?us-ascii?Q?K5ip9VLjaIpTdc7Quk170bHB6f4DwqK9KtLfFBBv7y2EjIodwy9isZ4jIqf8?=
 =?us-ascii?Q?2bRefQ9SD9stJyPPBEthW0ZStoL86Jbt0OjIV9eS9CrDoYS7zYC8gtgPayQ5?=
 =?us-ascii?Q?jEVHKfnU1vO2QVo7rN20zM6yA5XqbgZjR/eI5khiGg1qOMTrpu3EXmdUN2HA?=
 =?us-ascii?Q?eIwtHDoSk6RiEZ77etjxTgQ91T4ytEaOo+bQEAIu9i0SV7UoZN3lRj2e7D85?=
 =?us-ascii?Q?H410Vsg5dty/yE/KvMKPfGLArcGFS1vJD84ExkyHKYS7nVnCKS/7akHSXnjk?=
 =?us-ascii?Q?b5i+Mh8vBMtolLlJ/qz+tV4mdsd4pPnYiGv7ClA0mPTH/5jPI64c8dq04EBY?=
 =?us-ascii?Q?wGpoxdLIIxiVcDK5lNtWOyRdYMIOFwGDXgphH8T6Qz1ZASMHtUeA91EAKA+K?=
 =?us-ascii?Q?lR/NUEn3x2Q0x241dPUJBnci79tWTkRUOPshX9OKzctiln+FX+ChtMeGAMiz?=
 =?us-ascii?Q?lzsZ9fsVj3RygBmjwCkWDf0yCqWLMsSTZ1lHN/m9r4IlhPFZoWXvwOSBWWEA?=
 =?us-ascii?Q?Hy6uw8UU9556mCY2/YqdjOI/etGr3XsNj5uWHcm1DlKUMWKmCqAtmMaebYfg?=
 =?us-ascii?Q?EnHzYvQ2I1/fDj1mxyJ/Dy/a2Fz+28Mz6n10HvP8a/aczQHg7n6GUrPYhEkU?=
 =?us-ascii?Q?gd8pINxfS2nQ8xgVmmIrFGaY/18ZiDThWwNDGTAJt4dSwKeXFa1ikvjfOK2R?=
 =?us-ascii?Q?gjksMpSFJUIXD/Plz8HEu7XI+diKEoUCz8rctRhSkgPo7Q0LrjdHxukFO0Uu?=
 =?us-ascii?Q?ssHAZdIzvODHa85DVRFgUUVDxPobJnSCBYNdCQnQxj8X1u/2xPbCAw6l5fv1?=
 =?us-ascii?Q?HojSmLk/lIDZe88ica6eri7w482BECB96wcr7k27j8uk3RnpFoLt2VII0kDs?=
 =?us-ascii?Q?JOvycqx0kp/XLsF0VHOGq1cBbDzl1KJGGOk8PAekuuSWsoS/xCwePJ4oQt85?=
 =?us-ascii?Q?7cGlXalES4Z4BpU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WXW7j3vDt1akLksf/NYMWQwaV+JF+0O4a84F2716UEa1wlQ95E1IwxDxdJTB?=
 =?us-ascii?Q?SD5MEUN+7KaNj6xbRQbjc5WjEc/1NkKkGEVSGMEfyMeTGdp3Idabp1b7C/dY?=
 =?us-ascii?Q?u98hHn3i1fScCpRdtSi0X2Lrp/dJdHm68MAWelZx8V322OygPd6kN7U9UfRq?=
 =?us-ascii?Q?Rs1xL4PPAQVbghtsXM8cnEg1IkI7I/0P66uCzQtGYGroesYH1GwlQcSkBTht?=
 =?us-ascii?Q?mTBDe5V8WJFS5HSsmY01CoA8cZ5f+fJk/YJEtOf8NzOF+3XAYHKYZTyjJIWM?=
 =?us-ascii?Q?ran+9aODb5capdbtWEx09fC6xMQhwWRZjfu8Advp3smg5EPbJ2c+6/uxPZZ6?=
 =?us-ascii?Q?3fjOGiuTXLm6N+0BgiH74vxy5/aXVX21RAgr2J7Y9a5TlHZo2VwXqqq9tgvU?=
 =?us-ascii?Q?hE7gRKFGxaRY30tpFyBeUY23wLab6BO6Pw2PHmMU7lq9+9VTnBLBJjqK5UNn?=
 =?us-ascii?Q?yEGiqKPIxvvm6ZoQ7Jvoynm3FpzOeDksDYL416YuRlgzEPfGWiNeTIxljxq1?=
 =?us-ascii?Q?Z6aTHzGH1487Q72r5RUfV6VUHw4Lvd7aeMV8cvRSpENmbknW8iccsbzraKns?=
 =?us-ascii?Q?mlTYsQ2y6hQ6gdqO2MiNOtkUVENp0HsuU39OXddoWcMy41FfqY2L77yqZyCv?=
 =?us-ascii?Q?esr3dWlGIThWmKQhuZeFeSGxdU24OQygC0fNWGsKDTYxYDCfoRVKGA++oGsY?=
 =?us-ascii?Q?iky39fWmgo0s3z7IVSANOlfXUPgKZRpMBoM4mGQeCsvxxX5ujQIeH6T+uiEn?=
 =?us-ascii?Q?L7wE63sdI0u3ARwSTI+CYawUHpabelqbI/XbR/AmaDyAWupJ3OXvU/pt4RkY?=
 =?us-ascii?Q?HvEaL8QArze0kMB7WHX0Ge0VHWUUyZ6cNnMEzAV2fitGhWS5FQxNZKNPZeJK?=
 =?us-ascii?Q?b3Dab292BW2eOu53/iSRw6y9naUQa72cPR50zXP2lE1blVt6ujm59DrBC+AZ?=
 =?us-ascii?Q?h5gonLISw/dKJ33Ec4GvfiRp4aweII2i8E+BdunUfBUAlEi3xbG2zFmQpuaS?=
 =?us-ascii?Q?/34S4Ioh1q4rY5wPjIwfLG51NgHxkBnpLLl8HFZ97SLhi7GYEPfsxBbIMZxz?=
 =?us-ascii?Q?tmuMIhuelZcZrk9r9qE3Xo+UNtE25UEiyuCgtAXoKpIX5B9kn8Wp7C2K/WmC?=
 =?us-ascii?Q?3Mu4+90vcOftVagsKLIn4F+7NZlLV6zRGvRURkceJX76RaTibsIQgObeiHaH?=
 =?us-ascii?Q?a57pE6P3WZ+3LOdogfTFDDE9FZ6MMrSjY/XeIsCPS6kjRCa/ulsIS9K7KMmb?=
 =?us-ascii?Q?gspZH8rMOG2jTuNYKu2USCF5mZyWl6GYZmD8LCfZKKpqHuJnoKRbnwGKqesi?=
 =?us-ascii?Q?aLEa1NzAdhe5GoXDUqbu1oK+DG4aHhp4dhyItvjmCMSKiJlDoedRab995JPR?=
 =?us-ascii?Q?X19PKflPFk6a+k5Oky10FDiE/PimmnSkOFu9aDJ85VTrdH6M5hIJl7kw3+7G?=
 =?us-ascii?Q?7DwTx9HzcqkhZ6f3GRegJ3OZM5Xv4RMwP+OXuFBI0bAUrKIXitTCgkhU0V+K?=
 =?us-ascii?Q?MdmdE/hDMpFbJaGEhnSUNKf2YqILtlg5vxTdKMo5WhAy040irLUB4HBKrFBh?=
 =?us-ascii?Q?rEq8db5ueq/rKaC57i0FDWIWx0+NkofFGSOPwmcEUSJ+CWMBmrNLoMghOxFS?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85b5d0c-cf3d-49de-9c8d-08dd7b9b6c82
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 21:29:22.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDXBvPM5/K7hkPzVlU3iRpTwrW0NaC2xzd6fWTfLpqdm8r8lpetxF1/TyFsAQL2mkzDBrxX1cUhCIaHy4t6J5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9506

Russell King reports that on the ZII dev rev B, deleting a bridge VLAN
from a user port fails with -ENOENT:
https://lore.kernel.org/netdev/Z_lQXNP0s5-IiJzd@shell.armlinux.org.uk/

This comes from mv88e6xxx_port_vlan_leave() -> mv88e6xxx_mst_put(),
which tries to find an MST entry in &chip->msts associated with the SID,
but fails and returns -ENOENT as such.

But we know that this chip does not support MST at all, so that is not
surprising. The question is why does the guard in mv88e6xxx_mst_put()
not exit early:

	if (!sid)
		return 0;

And the answer seems to be simple: the sid comes from vlan.sid which
supposedly was previously populated by mv88e6xxx_vtu_get().
But some chip->info->ops->vtu_getnext() implementations do not populate
vlan.sid, for example see mv88e6185_g1_vtu_getnext(). In that case,
later in mv88e6xxx_port_vlan_leave() we are using a garbage sid which is
just residual stack memory.

Testing for sid == 0 covers all cases of a non-bridge VLAN or a bridge
VLAN mapped to the default MSTI. For some chips, SID 0 is valid and
installed by mv88e6xxx_stu_setup(). A chip which does not support the
STU would implicitly only support mapping all VLANs to the default MSTI,
so although SID 0 is not valid, it would be sufficient, if we were to
zero-initialize the vlan structure, to fix the bug, due to the
coincidence that a test for vlan.sid == 0 already exists and leads to
the same (correct) behavior.

Another option which would be sufficient would be to add a test for
mv88e6xxx_has_stu() inside mv88e6xxx_mst_put(), symmetric to the one
which already exists in mv88e6xxx_mst_get(). But that placement means
the caller will have to dereference vlan.sid, which means it will access
uninitialized memory, which is not nice even if it ignores it later.

So we end up making both modifications, in order to not rely just on the
sid == 0 coincidence, but also to avoid having uninitialized structure
fields which might get temporarily accessed.

Fixes: acaf4d2e36b3 ("net: dsa: mv88e6xxx: MST Offloading")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 29a89ab4b789..08db846cda8d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1852,6 +1852,8 @@ static int mv88e6xxx_vtu_get(struct mv88e6xxx_chip *chip, u16 vid,
 	if (!chip->info->ops->vtu_getnext)
 		return -EOPNOTSUPP;
 
+	memset(entry, 0, sizeof(*entry));
+
 	entry->vid = vid ? vid - 1 : mv88e6xxx_max_vid(chip);
 	entry->valid = false;
 
@@ -1960,7 +1962,16 @@ static int mv88e6xxx_mst_put(struct mv88e6xxx_chip *chip, u8 sid)
 	struct mv88e6xxx_mst *mst, *tmp;
 	int err;
 
-	if (!sid)
+	/* If the SID is zero, it is for a VLAN mapped to the default MSTI,
+	 * and mv88e6xxx_stu_setup() made sure it is always present, and thus,
+	 * should not be removed here.
+	 *
+	 * If the chip lacks STU support, numerically the "sid" variable will
+	 * happen to also be zero, but we don't want to rely on that fact, so
+	 * we explicitly test that first. In that case, there is also nothing
+	 * to do here.
+	 */
+	if (!mv88e6xxx_has_stu(chip) || !sid)
 		return 0;
 
 	list_for_each_entry_safe(mst, tmp, &chip->msts, node) {
-- 
2.43.0


