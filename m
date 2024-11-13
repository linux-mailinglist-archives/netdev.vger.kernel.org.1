Return-Path: <netdev+bounces-144495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A3F9C79B0
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFCB1F2503B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C44B200C82;
	Wed, 13 Nov 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F3a/mZYL"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8A741746;
	Wed, 13 Nov 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731518011; cv=fail; b=K3527u8bIDu9Gy0m7ViupcYf5tTwGK4O93XnlX93gG+oQ/iJF2FhpEb3RlFk0KXQbKGOlcP1rs/9C5cRz/vsVBwMgf+nN4HgwE5BYdU6unhnWmgViDy5ivE+l8ejh96xA5naAZSf65cmuBqhY3Hud8bE49/ww/WS8AU4tbV8jf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731518011; c=relaxed/simple;
	bh=8SEynUlXQlP/mB/QoJ/K6nkHbO6v6hDivuiyiLr129o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QXIMcWzcris5hkxJ4NTHbd0HOtiI17xnpKX0RRwvpzSPYVz6/HbBz82Jw/lhy85I6XuXXXCtzeG2AnLym/brggHYh1FVpCHZnjsKnz7N1R6qyo4zI6gGwmWphEkZ2wpNL2ZC0BEfZkA4qZQyA1gYAYixT2F7jaifvDUENgOaKZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F3a/mZYL; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Du2I45qslGnjk4z1saVL+vKeaAvRacHvBF4LgVnc742pzhli2AyCundEp2+m92CHlFzCJ6keI5oxEKq26EWCAjS73zqIWIl8qUo2bjb2STPBk7posqd6jL5GZxqRcz43zaTX9XqgK1mDo8S678YY0OgvXONBPpivmPhaFk6d5occZjs1dINdOYkcWfIV1P6ZLXW23T0NAZlMHlXluRusszAfFUrrTybIY62UTG0ZT5F+Nx/KLx1qBX+Kzr1LLrm9inekafD2ED5JBwmtQP0ZuRZeDwePAOqS86iueXDZwhLRzdxfpk7V8ObdVhFdWy68zLM336D28E1GhCLFP7KhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFiTqh3h+4HG6mA+sjyZc6LEwWmAXpn4vmFs77i9bnc=;
 b=cX74ZjnxdXhDMT+AZ35JjAJPH3tk2zhrORkyYMCbbvDg5LKB4B1Tx01MvdAyP5Iu3xNnTw2uENpgDXLBkFGgNFcTQ/5Z75/flPDRJCDv0oIVdrUHIkfzTQlJcDjZM2pNEu/e+i0CbevmpuiOV31k/jscQq8no4+L4NNjkRNYDH3SJKdoxOf0xDeCSPuT79sKtdI81Xos3p/aRbphjrW4xsdISODIZC88Ow9cbXXJX5C7p2kzrpk75LIfsYt/5QJ0ZHv9RoDC0aJY7BaVvUn+Xoj5XIanjTZmT6JkFykszZ+FNbLZVyVYCTdYDpxllwzDqiweGcHmT/o6fJADaGRUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFiTqh3h+4HG6mA+sjyZc6LEwWmAXpn4vmFs77i9bnc=;
 b=F3a/mZYLl12T5O6HWEP5JSUxxh5QSGuQgNM5pT+esK6EeU/0DpwaH7i+jDRq5l9C/cWA2icKnyrRT2i1uNdiIaLbm+0eCCYPWM0zYVKcfrN5IogARxqhkIX0qHiCdvn/JmVU4FIoEJtGDgCm4upnfEnFY3A4xzFLxRsduz6hSDmjjJ+fvpLnXqe41zCRMPca9Tw5fnuTa9BcUZhaq/Pk++abHAo2nv0rC6pxSNtR6LdwGmY6QEVtMQEKPcANFNZr2RCPszcymyPYlZLSVMcLgVC4E6nlSh1ZYpSQy3I7nWK31ZX/Ebfp8ICEVjCa7IS9hkj7nTXNEv2aaFKs2c0XcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7506.eurprd04.prod.outlook.com (2603:10a6:20b:281::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Wed, 13 Nov
 2024 17:13:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 17:13:25 +0000
Date: Wed, 13 Nov 2024 12:13:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 net-next 4/5] net: enetc: add LSO support for i.MX95
 ENETC PF
Message-ID: <ZzTeLA8BqGHTvUIQ@lizhi-Precision-Tower-5810>
References: <20241112091447.1850899-1-wei.fang@nxp.com>
 <20241112091447.1850899-5-wei.fang@nxp.com>
 <4vfvfzegrk774qlo5fobie5qcleqxqaogphucpzlwlcnq3llqd@aspdtwwqbobn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4vfvfzegrk774qlo5fobie5qcleqxqaogphucpzlwlcnq3llqd@aspdtwwqbobn>
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: f46835a6-798d-45ff-1f63-08dd04067c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UybU9eNGHLQRehYyBvFww8ScKUJIHffJZHOzBQZKNjin+60lxmCNbCAcZK0A?=
 =?us-ascii?Q?zWUIvrKY9stHsYVDYv0aOWmpgdWkgB8rKPChoSWihyowC4ov/eX1mp2rwke1?=
 =?us-ascii?Q?nkLnXGhjpVUOcKxmKFUehMX8LIu/E2waJFua1DSSVBzibkhvgUM8Uq2MbeQg?=
 =?us-ascii?Q?fPUaQUOSOTJDKnsAOPgxMiqco5OgUqroTm8i0NrNFWo2TCb95+TJfCksprmB?=
 =?us-ascii?Q?TWadJ4cHSRoAmqXxVKGHyryrn27hDzme4KHX6A3KhNE+3NCUj6IO40wWssrP?=
 =?us-ascii?Q?a/2B06Vv5ItT6zad6dvDSgJ1dpdqhf2zryLXglNWJ7cyxe4P2Bru52jV2r+K?=
 =?us-ascii?Q?zmIKhKb2gMDg+VmBEefUmnLHHdTPhC2NhW+BnV7D1xVWcbCp6Lm1xnogYZfj?=
 =?us-ascii?Q?lh1KTYo0uNftyhB9lRJI3uOqFpKE0pS2jKj2/CZ2CblnZlGXvOd94lg3z2O4?=
 =?us-ascii?Q?Gc6G1u8iAvGoKdU8OsdzYNBwyo1ADL3fNaynC+Tx8yqzLD53NxUwewTXCEew?=
 =?us-ascii?Q?hu0X+z7RYBqM+7OlOyNPdiinGPHzwzjTrHV+N2mCDA/hoZYNwT5AeYkBHHa3?=
 =?us-ascii?Q?9gJxWnmvK4KDhv2kdJK7Q3Z/CT4E0FpPOavxcqCVmNDYrk+/CtGdlq/KLPe+?=
 =?us-ascii?Q?Da2MplAz8eLRq0FmNFO3jfQr26YtFH+SBcD0z+fJ4IZUwcLT1SMriY1hj9Hv?=
 =?us-ascii?Q?ceQrE9m2+g3vsjfm7Ma+0vL15SjQM8tynv6cVdbYElmgnn0ia6ubSy9rurZ9?=
 =?us-ascii?Q?fRirCSu1abhNptMbZF9VZIYkBqfTa6eHb4bXU+SOtXQAF4TLoURc/1qMzeOD?=
 =?us-ascii?Q?1J+NCf6KkIvpBTeDD8duhBoFSC1D1+ynOcLh/rL7n3W5vzCe2tPJ38i09yon?=
 =?us-ascii?Q?DCrAvunwGlGPLMpE/2/4AKSz9TJk0/RSX29VQdftRr4dsQvTLDiAOb/wuly5?=
 =?us-ascii?Q?S+CfvXRsc/IpV3n6IL9jIZhR85mx61rTLZFtaQN/HIgziAS9Fe3HHM0dsrgH?=
 =?us-ascii?Q?8fZQs9q5WGevPjSlAxVRmzJIiRo8RHHHo0XSCMqAJQCcOG/qqwv//xtvvviU?=
 =?us-ascii?Q?GGKmyiHTFJnj8GhrYgLHsefMUsjplqPtSr/P5fRe297GLtPLdLjZ/ljqs6yn?=
 =?us-ascii?Q?fq8qWHpI7bhhSts07WcXuPsNKSUuPvIe7GC2T/dMSF2a4GSyAJyY/cPgM39n?=
 =?us-ascii?Q?QuaSW7UyQgN5SS5ToOoFcKS40A5iEdT8GpcUKqNkMXfc9v8ohjf6PSn/BRpS?=
 =?us-ascii?Q?EfQpxp6jW+ZgegMb7pV3cTJlZ1dwTgR9obH9R/9a+UN5tkiVzbyraNFoEAXK?=
 =?us-ascii?Q?KSV1l8H2n7+VJumMytG7wIfBcUZGRW+MMEjE/YNPNZG6xS8iRYZrAaNOdDCh?=
 =?us-ascii?Q?W4a8S3g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BOt1mqOUadi/SDMFQEZhF/eFeKkAjK+5sYXlSFrTOR2clrBq/ITaV91U1gXt?=
 =?us-ascii?Q?nOoR9y8rznVmb9LBts353LgyDfCiX1hwz+w0cezc29Ub4RZHqVLszS1upaPN?=
 =?us-ascii?Q?+Zll7uCk6HdXGj4x4UxXi57LwkE+PSPOndT35EswjaD8m5h/jdk3Al5ZXU+m?=
 =?us-ascii?Q?D1JQLTMxyKoSLBy8spKavX64vEbn35P7Z2UEpGonvve/hsPbx7nOPz1VTitw?=
 =?us-ascii?Q?+EnR49eX9R7TsE2PTP0tCDACPhUZd98KY/qLRIq5dVj/28c6hGtw4hn0Xpju?=
 =?us-ascii?Q?l1pZgKt5mHHu206RfoeNVoiq9JazmYI0OXAYzc2PDjqiqpoQQ1EdjDZykElE?=
 =?us-ascii?Q?UEOVQGJWPbkf1fyc0nxTu+5f3eD/OS+eWNSv2Av88zfSZ9wk0yua8K5XyNa6?=
 =?us-ascii?Q?mV4P7+5D0ADTDzkXd6wDYl+EzFDgAz2PCe8dp/zERxgo0jkK2TNWOeYwRwrV?=
 =?us-ascii?Q?rNdxuR6Dyzp+++QJ1VmNsGkc1uyfoUs/8351dyKrHOS+4jDjS02w7SqD35K/?=
 =?us-ascii?Q?zp+ir8SsQ612/GT2kzJ6Kpy50JeZJrKb7mBfUOTFd1lWFy182JQR7uPqGwkk?=
 =?us-ascii?Q?LrxiNjU5xiw6tENmuU8pKk/3cnszjCdyNK2vs+JC0isAZAM3pdh/BNcGHCe5?=
 =?us-ascii?Q?73OGQCautd2Mi4t4SgZV+ilOO6cuQpjyodnlDO8bEd2C27EhYrBsKkGsuljN?=
 =?us-ascii?Q?AbV07HxuzxHcBWrQY4AsEYhDFaDUHoeyiSdECmR7onV6zdVinv0TuXbgBUc9?=
 =?us-ascii?Q?i3N0h+nc+MmTV9gRa71xC8c7P0NsG+dzoqtb68AW6AQQq/OV2PnRK66n+Qji?=
 =?us-ascii?Q?zG0d2dE8bw2J6e0uVwXqK2yY1kmdxUS26nxz4rcjckDqWut4STtDPXmc4Zd3?=
 =?us-ascii?Q?jTnomJieTjz2SoQrFX9O22daxe0Uu+fXF9CTgrmqKGT3JE9B3qvMx9wUiDm1?=
 =?us-ascii?Q?usl7Q6CR0PkACadiJ44PfcBXthw4uJXRdPVT+AiceEfnVAf3S6e6D23D29sb?=
 =?us-ascii?Q?hzsUUi6+mV4XMMx7dgMtMFyXzaopGSzBB/5ce/7OTaCqHUbWiHzQubdZQN/T?=
 =?us-ascii?Q?le9mBBS1leAGIgR2bB5GjFSx2r1h09n+KmMLc5bRkeNdy+yK7TXtBpqI0h1E?=
 =?us-ascii?Q?Hb333zMCZvyPBnyEfPqSo9oPJ/9HS+SeERSQPB6YV8Gug4xfYILgr0shAvDn?=
 =?us-ascii?Q?kenk2UaktcqC0I66GACYYnY6ED0+BGp4W4ZISR0t55nj3WB6ujjWmFxMgH2p?=
 =?us-ascii?Q?2mpfH5V+g4bNYbMesrzDnsqJI8qTzmO50FvMGUHiKByBKIL3qKYCiw1tPp+A?=
 =?us-ascii?Q?HoZAHQL3xSoq+2Z0wVOPn499n6ky5IXFn51SGR00K3WD0l97zS4dlYlQwOxy?=
 =?us-ascii?Q?TD+AUT3wahkiVXp3bJ8iw/UHmaz9y1FpjfOt+81G/qIFMxqIiuUIzMJ2ZQK3?=
 =?us-ascii?Q?wE+mfXkCrRTAL7+GTmmw7bRycvPr5hc5b7CA/KB1okJ9xVzM9S2OYC+0ayBh?=
 =?us-ascii?Q?MgewIYdTyZbQlq5LEtJpCqUvtfOUXLttqHs37UL28O6YOXcAKYakoXi6+ZBM?=
 =?us-ascii?Q?ZJa2O6inx4fKVV2x0DA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46835a6-798d-45ff-1f63-08dd04067c22
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 17:13:25.7318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziL4BSObreZ803rg/dD0PlHIfQZ7RPQCqPOYhi+cZ8TPXn4/xN6NBevCIbWVhyn3o/RmdkKWPAa2EodACE6APg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7506

On Wed, Nov 13, 2024 at 04:39:11PM +0200, Ioana Ciornei wrote:
> On Tue, Nov 12, 2024 at 05:14:46PM +0800, Wei Fang wrote:
> > ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
> > and UDP transmit units into multiple Ethernet frames. To support LSO,
> > software needs to fill some auxiliary information in Tx BD, such as LSO
> > header length, frame length, LSO maximum segment size, etc.
> >
> > At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
> > CPU performance before and after applying the patch was compared through
> > the top command. It can be seen that LSO saves a significant amount of
> > CPU cycles compared to software TSO.
> >
> > Before applying the patch:
> > %Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si
> >
> > After applying the patch:
> > %Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > v2: no changes
> > v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.c  | 266 +++++++++++++++++-
> >  drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +
> >  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
> >  .../net/ethernet/freescale/enetc/enetc_hw.h   |  15 +-
> >  .../freescale/enetc/enetc_pf_common.c         |   3 +
> >  5 files changed, 311 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 7c6b844c2e96..91428bb99f6d 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -527,6 +527,233 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
> >  	}
> >  }
> >
> > +static inline int enetc_lso_count_descs(const struct sk_buff *skb)
> > +{
> > +	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
> > +	 * for linear area data but not include LSO header, namely
> > +	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
> > +	 */
> > +	return skb_shinfo(skb)->nr_frags + 4;
> > +}
>
> Why not move this static inline herper into the header?
>
> > +
> > +static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
> > +{
> > +	int hdr_len, tlen;
> > +
> > +	tlen = skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr);
> > +	hdr_len = skb_transport_offset(skb) + tlen;
> > +
> > +	return hdr_len;
> > +}
> > +
> > +static void enetc_lso_start(struct sk_buff *skb, struct enetc_lso_t *lso)
> > +{
> > +	lso->lso_seg_size = skb_shinfo(skb)->gso_size;
> > +	lso->ipv6 = enetc_skb_is_ipv6(skb);
> > +	lso->tcp = skb_is_gso_tcp(skb);
> > +	lso->l3_hdr_len = skb_network_header_len(skb);
> > +	lso->l3_start = skb_network_offset(skb);
> > +	lso->hdr_len = enetc_lso_get_hdr_len(skb);
> > +	lso->total_len = skb->len - lso->hdr_len;
> > +}
> > +
> > +static void enetc_lso_map_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
> > +			      int *i, struct enetc_lso_t *lso)
> > +{
> > +	union enetc_tx_bd txbd_tmp, *txbd;
> > +	struct enetc_tx_swbd *tx_swbd;
> > +	u16 frm_len, frm_len_ext;
> > +	u8 flags, e_flags = 0;
> > +	dma_addr_t addr;
> > +	char *hdr;
> > +
> > +	/* Get the fisrt BD of the LSO BDs chain */
>
> s/fisrt/first/

Fang wei:
 next time run

./script/checkpatch --strict --codespell

Frank

>

