Return-Path: <netdev+bounces-218112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D84B3B275
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70884983D7B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E865A2367C0;
	Fri, 29 Aug 2025 05:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JdmMIb20"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F82356C7;
	Fri, 29 Aug 2025 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445264; cv=fail; b=qF7KDhdL97WnCjVZdxQsE5ON9ul16RWxwOjj3jHjfyc7ipxQhuJYxX1doT2nf7BnAyxozxBnQlgARqPzVzY5Fkxs0/xSuIRnkbwT6iQztEOZPRPJTRZq42gsaD7jjMvCVktC9swd4ZkT/Alm8SI5gwqhAQguVZWRLCsYO7z+I/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445264; c=relaxed/simple;
	bh=AZc+VngCYcy1izgEZNU9Lin0RXTrZl7/O0f9HwdghFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Utmq5DFZe+Lu/c1xT3mVvY4mX5m5DGO1kx2IiCfhOY9eiz1g2oJBGtqIXZoXZbmmQflff5mzUOotNKmssGeXOlch66ujjy9H/90jGzKTNNESuRNTgKlE73iJDKTSweO6qPUc+rS4NpmkyUX2d7rSUJNWNN4bxbD2aHwkfCBro0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JdmMIb20; arc=fail smtp.client-ip=52.101.84.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWGs6Eia3mi4EIArQ8tn5asPFIFEC5Urm2i8J8g1n0XQNthIfKnES5tetFisu4YBX9FZensyRzI9/15OEjKqEcIGT+xxsHt7gjEucFB2KBued1DZHRa09OjSihafDV1U0+y0vmr+gjedwT0eMynuGEjEdHzW2MzFvlw1Na/EBeeFSyQ2aJNROr2FleafCtXYrJgHI3+qXEtnrdq/AFXskiTvdbKiXR91k9u4y9uTVvSDNAXj5hZVnfjvo2aXI84YXiT59Q+2PWacqXl5ABD4AGHtURZa0jqzvNsYCQF0gsgbLsmkUTCOX+2Pcg+wRFJZKxaSwD2oeR/0LltaxjuQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeSsHmuq2IHktoqDbjTMq59XsJMi2k0Qi4V+MXRjfJE=;
 b=ATPBbe+z14tc+mmxB3Kq3GM5A+VoZbLj8hvwvLwqqVZD1zjEf2/FnnY2FggE3zYVNj0Lfn5VOcxYeJM1Uh5W+FvQBy8x2PvUgZbNzfS/g3C/qklEyWBqtXnTuLSYrbPvnZbSBp59rc8iDIKglCfsEQ02RKoEJKyedAQBNxqSv4oAG3VCTRmQ01no5nBvnPx1DlVJ/GGHcKhwpmUx2SWum6m2P2qfb55rgNy2sZMXol47sPPXi4VsYxS6Hr38SUxXUniISYY0GOcNP20OT3TCs73zJZbba4qs7sdgVrk+uAvQ6mYgGFo0aEbb+LEIUnlCwkOJrmEvcROtamJGwp5KBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeSsHmuq2IHktoqDbjTMq59XsJMi2k0Qi4V+MXRjfJE=;
 b=JdmMIb20JyLqE2hPEFx9VsmrlsrKhkYJ09jVOvc8r/MumtTQNUVImmGF/UI3Zct0U6Nb7LzPK9k9y+MQvQon/JJvBdVwGiNavnv6Qv004u6Pw4zP/7uu1Iiu83Dq+vbSEU75rVtKAocMuMixl9goKJ3DM1QZDZiQQRyRFpC8NME4oChqOb3BLLLuVlGfQ/FQ/w2IebPCO7rAXW3ldJ8vYXNqsO0PiGgnJKiMrU6wZD85MPC5nzVnnGd4wkyJxzhDndyh4+0/3GgGzDEV2tp/Kaf72Zqv0wT9gERbc6GN+yRpduvEtTY+AQ1uXRxLjVuj46ZfBNQmFlJzH2itpmU92Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:27:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:27:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 05/14] ptp: netc: add PTP_CLK_REQ_PPS support
Date: Fri, 29 Aug 2025 13:06:06 +0800
Message-Id: <20250829050615.1247468-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829050615.1247468-1-wei.fang@nxp.com>
References: <20250829050615.1247468-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 27733745-7ef3-4dca-6f73-08dde6bcc55c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FzyrbV+PB2WZ2NUeFXb/ISSj05Xc/Hm45kPwtChcRI+sxOCgYKB4MqY+5CI7?=
 =?us-ascii?Q?/JKejRHHRFHR52o+PBO+MWBXhTKGrX14wiP8UEQhWVxaOLx6np254kpw+J5h?=
 =?us-ascii?Q?ZsRpOhBkwK+Azd1Sugo1PLJ0deOcq/4indDC40z9a6NoLHV2X0pcbpMl/3tV?=
 =?us-ascii?Q?zYj34D+nHhUHvdw+KdK49vIZT+gtoc4+K8Y/cO0f9JxLm98HfyFtccfo+BrJ?=
 =?us-ascii?Q?QKBE02dUyL3ChOTMuhMk22X3COicVSRQmR1zWsRq8mRQNgN7ImJzP2/Aunxp?=
 =?us-ascii?Q?THN6LxmpfV4te5ax8D+F0pQqISB2VYEV5sffrVJ0H3qF+zn0uAC+Lnj1mccp?=
 =?us-ascii?Q?vxBqICeLPBK/BNZUPsC/iuakVcMgqNJuUY/r6Tg2UJQotMPyns2qXV6vQyMR?=
 =?us-ascii?Q?lAJvEYNhxcYRU8qTgrQIhlyAWpI5Y4mvtLdwy/Y2YoLpoyzYa2sPfuxVS8DI?=
 =?us-ascii?Q?G6zMHNuF2SlomlRv4XkWjo4aj8gp1orMs//cJj5qfTf2Mnsdc6VlbpSRGXsW?=
 =?us-ascii?Q?AQRxaqzge801dCK1sC64t01NLmRfxn1PorTkB1BPZzDAyXmML0Zlpq3XRQG0?=
 =?us-ascii?Q?Zkj8o3XQtLIubXtz3dozajRcGUGqabvlmxFxgmrGl7sqpw2fE+XIWARuxej7?=
 =?us-ascii?Q?xpn5zb/bVtgCBtbQ4hrbk5+OhzeXeLQsb8AvPV6b12guPxlUqYzivZSDEHl8?=
 =?us-ascii?Q?LVxhyW2iTy57lSPgg/rfYw9AkrROCp9WjWEJ299HOTlqY4xY85t37WsEuZlg?=
 =?us-ascii?Q?ZCxGVtblHsibHyKnc2GaIr83cu51vAMnA3Bpn+XDb2TpkejhmWBnpljBg8Fy?=
 =?us-ascii?Q?Lq4OOB5hPQ+cFMkB4Ifzf19awdsGPDEDI4e/jhz4jb0b2DlVycMDsKIqTxOG?=
 =?us-ascii?Q?Wg8jENhNdPN10jMQz35JNLEhngN55l4snJtB53Cxu5sT6Azt1+QESd3aOSGO?=
 =?us-ascii?Q?V9GxuEdGyuFlcu5Kg7JvxV5P55/CIVO6HWsZSOBU7DgbAWQhp4C9Uts81fiU?=
 =?us-ascii?Q?t7oJWaw1z9R1X5fiFYADvAGhH3V4kV4jk9AJfhZvgrw0MByOkDCOwaF+/HXQ?=
 =?us-ascii?Q?+mUu2kHFeO+XtCe6kSf/opiH0MVpxz826ybGuc6Ewdp++sSqFCMO0vUym2ea?=
 =?us-ascii?Q?UHHDi1CElRcq4SUfb5d7dyDQMKrfc8feuEYrlOAGNIYpiZBXMFbz2NCW+amk?=
 =?us-ascii?Q?ZXCxuJHayPk01aFyy97my8tVNYyRqUFwWU1Qe0MMyvizIkDa73GQd/odGm0U?=
 =?us-ascii?Q?PIyrCmuznVd4gQwFbGCz6Z7wyj85tre05s3S2mFCfGjHfG/15znySfuuezgA?=
 =?us-ascii?Q?8vkF8BhoC6UCYSzCP2KYq1k5FBvF6PTpKy9v/lhxE0W2EHrEyCNCAFfItHLW?=
 =?us-ascii?Q?WFaHTDeNWO08gax25xLRl1qOqVR5MK0R5+0nv3gaOIfdlHM0N7ICZvxBwIaO?=
 =?us-ascii?Q?ZalA51v9qSi80FqfAsYjrhNZx8Ey+8W51VN0GQJOI0De4EuygkyRWTv63PvB?=
 =?us-ascii?Q?65Zvrl/68E4POnR5FeGyt+Ju4ng5QBTyBhxy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C9fEHEkuSVfhGP4L799nBIBJ1AejUA9JjU7iAvWgQfGNh0mMDcvWfu5TGXta?=
 =?us-ascii?Q?dHVb0UXrufs82Vuerj0Lzg86T7PClyy8oqPtM2mRVRPIk5RiyLhFfgJM8o1I?=
 =?us-ascii?Q?AI9Do9elOP43SnMnD0fv0wcezB8sHr2Clhz6CdqcimkEBmjqjZXs/mJtPPIr?=
 =?us-ascii?Q?ef41I440FxE+y0SS62Bz7E5PLagkVRc4ijdZr4DOW+i4LKdxsdGb530qT56S?=
 =?us-ascii?Q?ESzaOAdfd7DCgnZ71FBPOFp0bpTO0StHpEFm7CfjE0mSFq/7mM3B2JHlSWnH?=
 =?us-ascii?Q?Ey1Mn2yF5aDMGmS/MX6a0JtvfgxQMEF9tmsjBBc0gxF98ygI7P3ZkRZsTe4I?=
 =?us-ascii?Q?D3CiR5eSYVBP/xelBIkFemuLFJG6m4WbEOs2tJWQgwzTzSS9eqMdEc/DIln8?=
 =?us-ascii?Q?dJdRnuDb5zLcjt3j5X/v1WMPSBaxAe+3pkXq8Y9/XDjy+FkaWBhyq0FhBDC7?=
 =?us-ascii?Q?rHUplrW3dKwAvQKCahv3MIjqep9dBtepYoHnEtsORZgHFGwX4icfmRlq2Rkm?=
 =?us-ascii?Q?+QHIZWQgF70xXhw9QaQBVobUsoq/l0kIlSmewbdPPhbmAGncaLdsuOx9cks2?=
 =?us-ascii?Q?JriKZ8i/bzqnLes7N6o1iiz3d7woOmsbVbrWpaG2K7ZyGJPnxaYjsmFv/IiD?=
 =?us-ascii?Q?+BeH1+GKbDvTc7QvvrNaKsD/YtO1172EyYsZCjfz07nOvAXm72PePGTz/AON?=
 =?us-ascii?Q?PLTbQEyag7FuyiOjxJgqtkFq0fjqTsjkE/UlJsM0U/kDUMwtGK3bICUIQ4N/?=
 =?us-ascii?Q?7WMpeJi0OELXX7MPHwzrr91aW2EX6TDdK9/N5Ej//ExZ4qyFSZYp4yaHKaEU?=
 =?us-ascii?Q?Sa5xQBfTAYChuEKf0vq6ZBgg/weTozFzkdbD0bBmBDN3i3bA9i8+EzSu8QJf?=
 =?us-ascii?Q?wRzeHZxeiChcYLDw1hcYjauIiP1nvbAZATZ2VYvOpsM3YHcrfgCdSBMpD390?=
 =?us-ascii?Q?ePfCBQtgUbuEjHVjcvVS1rjJ3KU7VMbJ2rqvEivVNi9OKclItGeSdWRdDYtY?=
 =?us-ascii?Q?2Mc+xYBPP8xwyUaRVnPG7QOy32XERsL1jYM4I3HMmQHLGlL80BR20uLDLB7U?=
 =?us-ascii?Q?Q+w7IaZ4AFpFaWIqJW8JbgmUAQLg9vnGGVilmAirMVVymTdl+HddNA7aflaP?=
 =?us-ascii?Q?9v/NLK/93ds2sYtIH92JTKIJpZKxI8V2/MYVQmUz+XaH08Xwn4IRUg61gusr?=
 =?us-ascii?Q?2gylCT6dJsgey6NVWNGCUp8/wvev0cce8j5wNRxDZ8VLgWaQi4QkxL2Ow5xD?=
 =?us-ascii?Q?zHlxM2IoWNAcpuE+UKB0IhUhAn7p2VtgXNxYpljwhnP1zj5uQVSIk1OIpw/V?=
 =?us-ascii?Q?7PQcgMecN9UJ7nYUr5z6lfTPWtHMtfZysYy/pAQpYDRH/THVGAnqmG9Rg49r?=
 =?us-ascii?Q?FXd4JNxAbnAR1X93XqbiE9EieolaqwQMFV9bSdFdjynQ3XT1kkzOruywPjgl?=
 =?us-ascii?Q?3+bOHDZuvEv11ILM67xUlOOaSsedFSUpVxMP7QbXfJdM4uMsydyXpKO5L3wp?=
 =?us-ascii?Q?zM8Bt/iw+kLM9MLRhFqCodNM1CqEcO9GFJdzA5KInrnyCTdO0E2TmTM4SyWs?=
 =?us-ascii?Q?/V3gGI7EugPfNAGNlQmPFVmJYHlUHr7lhRIkrdtz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27733745-7ef3-4dca-6f73-08dde6bcc55c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:27:39.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvtb+jCxBsAVjnm6aRjKyc+rahvbPtyouGMcCltZMRcGJy0os59CdxjIQ0taAsXUmZFaZmVGQte3ho+W6txISQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

The NETC Timer is capable of generating a PPS interrupt to the host. To
support this feature, a 64-bit alarm time (which is a integral second
of PHC in the future) is set to TMR_ALARM, and the period is set to
TMR_FIPER. The alarm time is compared to the current time on each update,
then the alarm trigger is used as an indication to the TMR_FIPER starts
down counting. After the period has passed, the PPS event is generated.

According to the NETC block guide, the Timer has three FIPERs, any of
which can be used to generate the PPS events, but in the current
implementation, we only need one of them to implement the PPS feature,
so FIPER 0 is used as the default PPS generator. Also, the Timer has
2 ALARMs, currently, ALARM 0 is used as the default time comparator.

However, if the time is adjusted or the integer of period is changed when
PPS is enabled, the PPS event will not be generated at an integral second
of PHC. The suggested steps from IP team if time drift happens:

1. Disable FIPER before adjusting the hardware time
2. Rearm ALARM after the time adjustment to make the next PPS event be
generated at an integral second of PHC.
3. Re-enable FIPER.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v5 changes:
1. Fix irq name issue, since request_irq() does not copy the name from
   irq_name.
v4 changes:
1. Improve the commit message, the PPS generation time will be inaccurate
   if the time is adjusted or the integer of period is changed.
v3 changes:
1. Use "2 * NSEC_PER_SEC" to instead of "2000000000U"
2. Improve the commit message
3. Add alarm related logic and the irq handler
4. Add tmr_emask to struct netc_timer to save the irq masks instead of
   reading TMR_EMASK register
5. Remove pps_channel from struct netc_timer and remove
   NETC_TMR_DEFAULT_PPS_CHANNEL
v2 changes:
1. Refine the subject and the commit message
2. Add a comment to netc_timer_enable_pps()
3. Remove the "nxp,pps-channel" logic from the driver
---
 drivers/ptp/ptp_netc.c | 263 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 260 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index defde56cae7e..2107fa8ee32c 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -20,7 +20,14 @@
 #define  TMR_CTRL_TE			BIT(2)
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+#define  TMR_CTRL_FS			BIT(28)
 
+#define NETC_TMR_TEVENT			0x0084
+#define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
+#define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
+#define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
+
+#define NETC_TMR_TEMASK			0x0088
 #define NETC_TMR_CNT_L			0x0098
 #define NETC_TMR_CNT_H			0x009c
 #define NETC_TMR_ADD			0x00a0
@@ -28,9 +35,19 @@
 #define NETC_TMR_OFF_L			0x00b0
 #define NETC_TMR_OFF_H			0x00b4
 
+/* i = 0, 1, i indicates the index of TMR_ALARM */
+#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
+#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
+
+/* i = 0, 1, 2. i indicates the index of TMR_FIPER. */
+#define NETC_TMR_FIPER(i)		(0x00d0 + (i) * 4)
+
 #define NETC_TMR_FIPER_CTRL		0x00dc
 #define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
 #define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
+#define  FIPER_CTRL_FS_ALARM(i)		(BIT(5) << (i) * 8)
+#define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
+#define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
 
 #define NETC_TMR_CUR_TIME_L		0x00f0
 #define NETC_TMR_CUR_TIME_H		0x00f4
@@ -39,6 +56,9 @@
 
 #define NETC_TMR_FIPER_NUM		3
 #define NETC_TMR_DEFAULT_PRSC		2
+#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
+#define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
+#define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -59,6 +79,11 @@ struct netc_timer {
 	u32 oclk_prsc;
 	/* High 32-bit is integer part, low 32-bit is fractional part */
 	u64 period;
+
+	int irq;
+	char irq_name[24];
+	u32 tmr_emask;
+	bool pps_enabled;
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -124,6 +149,155 @@ static u64 netc_timer_cur_time_read(struct netc_timer *priv)
 	return ns;
 }
 
+static void netc_timer_alarm_write(struct netc_timer *priv,
+				   u64 alarm, int index)
+{
+	u32 alarm_h = upper_32_bits(alarm);
+	u32 alarm_l = lower_32_bits(alarm);
+
+	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
+	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
+}
+
+static u32 netc_timer_get_integral_period(struct netc_timer *priv)
+{
+	u32 tmr_ctrl, integral_period;
+
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	integral_period = FIELD_GET(TMR_CTRL_TCLK_PERIOD, tmr_ctrl);
+
+	return integral_period;
+}
+
+static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
+					 u32 fiper)
+{
+	u64 divisor, pulse_width;
+
+	/* Set the FIPER pulse width to half FIPER interval by default.
+	 * pulse_width = (fiper / 2) / TMR_GCLK_period,
+	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq,
+	 * TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz,
+	 * so pulse_width = fiper * clk_freq / (2 * NSEC_PER_SEC * oclk_prsc).
+	 */
+	divisor = mul_u32_u32(2 * NSEC_PER_SEC, priv->oclk_prsc);
+	pulse_width = div64_u64(mul_u32_u32(fiper, priv->clk_freq), divisor);
+
+	/* The FIPER_PW field only has 5 bits, need to update oclk_prsc */
+	if (pulse_width > NETC_TMR_FIPER_MAX_PW)
+		pulse_width = NETC_TMR_FIPER_MAX_PW;
+
+	return pulse_width;
+}
+
+static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
+				     u32 integral_period)
+{
+	u64 alarm;
+
+	/* Get the alarm value */
+	alarm = netc_timer_cur_time_read(priv) +  NSEC_PER_MSEC;
+	alarm = roundup_u64(alarm, NSEC_PER_SEC);
+	alarm = roundup_u64(alarm, integral_period);
+
+	netc_timer_alarm_write(priv, alarm, 0);
+}
+
+/* Note that users should not use this API to output PPS signal on
+ * external pins, because PTP_CLK_REQ_PPS trigger internal PPS event
+ * for input into kernel PPS subsystem. See:
+ * https://lore.kernel.org/r/20201117213826.18235-1-a.fatoum@pengutronix.de
+ */
+static int netc_timer_enable_pps(struct netc_timer *priv,
+				 struct ptp_clock_request *rq, int on)
+{
+	u32 fiper, fiper_ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+
+	if (on) {
+		u32 integral_period, fiper_pw;
+
+		if (priv->pps_enabled)
+			goto unlock_spinlock;
+
+		integral_period = netc_timer_get_integral_period(priv);
+		fiper = NSEC_PER_SEC - integral_period;
+		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
+		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
+				FIPER_CTRL_FS_ALARM(0));
+		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
+		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
+		priv->pps_enabled = true;
+		netc_timer_set_pps_alarm(priv, 0, integral_period);
+	} else {
+		if (!priv->pps_enabled)
+			goto unlock_spinlock;
+
+		fiper = NETC_TMR_DEFAULT_FIPER;
+		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
+				     TMR_TEVENT_ALMEN(0));
+		fiper_ctrl |= FIPER_CTRL_DIS(0);
+		priv->pps_enabled = false;
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+unlock_spinlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
+{
+	u32 fiper_ctrl;
+
+	if (!priv->pps_enabled)
+		return;
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl |= FIPER_CTRL_DIS(0);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+{
+	u32 fiper_ctrl, integral_period, fiper;
+
+	if (!priv->pps_enabled)
+		return;
+
+	integral_period = netc_timer_get_integral_period(priv);
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
+	fiper = NSEC_PER_SEC - integral_period;
+
+	netc_timer_set_pps_alarm(priv, 0, integral_period);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static int netc_timer_enable(struct ptp_clock_info *ptp,
+			     struct ptp_clock_request *rq, int on)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+
+	switch (rq->type) {
+	case PTP_CLK_REQ_PPS:
+		return netc_timer_enable_pps(priv, rq, on);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 {
 	u32 fractional_period = lower_32_bits(period);
@@ -136,8 +310,11 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
 	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
 				    TMR_CTRL_TCLK_PERIOD);
-	if (tmr_ctrl != old_tmr_ctrl)
+	if (tmr_ctrl != old_tmr_ctrl) {
+		netc_timer_disable_pps_fiper(priv);
 		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+		netc_timer_enable_pps_fiper(priv);
+	}
 
 	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
 
@@ -163,6 +340,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
+	netc_timer_disable_pps_fiper(priv);
+
 	/* Adjusting TMROFF instead of TMR_CNT is that the timer
 	 * counter keeps increasing during reading and writing
 	 * TMR_CNT, which will cause latency.
@@ -171,6 +350,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	tmr_off += delta;
 	netc_timer_offset_write(priv, tmr_off);
 
+	netc_timer_enable_pps_fiper(priv);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -205,8 +386,12 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->lock, flags);
+
+	netc_timer_disable_pps_fiper(priv);
 	netc_timer_offset_write(priv, 0);
 	netc_timer_cnt_write(priv, ns);
+	netc_timer_enable_pps_fiper(priv);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -217,10 +402,13 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.name		= "NETC Timer PTP clock",
 	.max_adj	= 500000000,
 	.n_pins		= 0,
+	.n_alarm	= 2,
+	.pps		= 1,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
 	.settime64	= netc_timer_settime64,
+	.enable		= netc_timer_enable,
 };
 
 static void netc_timer_init(struct netc_timer *priv)
@@ -237,7 +425,7 @@ static void netc_timer_init(struct netc_timer *priv)
 	 * domain are not accessible.
 	 */
 	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
-		   TMR_CTRL_TE;
+		   TMR_CTRL_TE | TMR_CTRL_FS;
 	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
 	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
 
@@ -357,6 +545,65 @@ static int netc_timer_parse_dt(struct netc_timer *priv)
 	return netc_timer_get_reference_clk_source(priv);
 }
 
+static irqreturn_t netc_timer_isr(int irq, void *data)
+{
+	struct netc_timer *priv = data;
+	struct ptp_clock_event event;
+	u32 tmr_event;
+
+	spin_lock(&priv->lock);
+
+	tmr_event = netc_timer_rd(priv, NETC_TMR_TEVENT);
+	tmr_event &= priv->tmr_emask;
+	/* Clear interrupts status */
+	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
+
+	if (tmr_event & TMR_TEVENT_ALMEN(0))
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+
+	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
+		event.type = PTP_CLOCK_PPS;
+		ptp_clock_event(priv->clock, &event);
+	}
+
+	spin_unlock(&priv->lock);
+
+	return IRQ_HANDLED;
+}
+
+static int netc_timer_init_msix_irq(struct netc_timer *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+	int err, n;
+
+	n = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+	if (n != 1) {
+		err = (n < 0) ? n : -EPERM;
+		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed\n");
+		return err;
+	}
+
+	priv->irq = pci_irq_vector(pdev, 0);
+	err = request_irq(priv->irq, netc_timer_isr, 0, priv->irq_name, priv);
+	if (err) {
+		dev_err(&pdev->dev, "request_irq() failed\n");
+		pci_free_irq_vectors(pdev);
+
+		return err;
+	}
+
+	return 0;
+}
+
+static void netc_timer_free_msix_irq(struct netc_timer *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+
+	disable_irq(priv->irq);
+	free_irq(priv->irq, priv);
+	pci_free_irq_vectors(pdev);
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -376,16 +623,24 @@ static int netc_timer_probe(struct pci_dev *pdev,
 	priv->caps = netc_timer_ptp_caps;
 	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
 	spin_lock_init(&priv->lock);
+	snprintf(priv->irq_name, sizeof(priv->irq_name), "ptp-netc %s",
+		 pci_name(pdev));
+
+	err = netc_timer_init_msix_irq(priv);
+	if (err)
+		goto timer_pci_remove;
 
 	netc_timer_init(priv);
 	priv->clock = ptp_clock_register(&priv->caps, dev);
 	if (IS_ERR(priv->clock)) {
 		err = PTR_ERR(priv->clock);
-		goto timer_pci_remove;
+		goto free_msix_irq;
 	}
 
 	return 0;
 
+free_msix_irq:
+	netc_timer_free_msix_irq(priv);
 timer_pci_remove:
 	netc_timer_pci_remove(pdev);
 
@@ -396,8 +651,10 @@ static void netc_timer_remove(struct pci_dev *pdev)
 {
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
+	netc_timer_wr(priv, NETC_TMR_TEMASK, 0);
 	netc_timer_wr(priv, NETC_TMR_CTRL, 0);
 	ptp_clock_unregister(priv->clock);
+	netc_timer_free_msix_irq(priv);
 	netc_timer_pci_remove(pdev);
 }
 
-- 
2.34.1


