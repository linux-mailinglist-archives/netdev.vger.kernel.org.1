Return-Path: <netdev+bounces-136383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67C49A191A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 05:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA321F226F7
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEB6139D13;
	Thu, 17 Oct 2024 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iNw2b4xD"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161C139587;
	Thu, 17 Oct 2024 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134342; cv=fail; b=U0vTr56w9Vwo1ExoMgyjA26FxYzHh8eCGE2WXWpfLqdHr3gCGV2FOBTMF5dKx7c0GF/eGoamzABuKlKajc7S8zR+OpOSYXXntajxSGd93nZ01i2nVYiJrPLgvCsIFMFFPzqREA5apAAPWR0ApXzZXGqF03fnHHNAGfs9vERMBqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134342; c=relaxed/simple;
	bh=uQTsjZpGa9wX2TQQ9rBX1c3BVMGp/XrNpD4Z9jYIcBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HkK9CTWe+EqlR2DJlV/n1f1sE1Qu1vltuSLhzTc2Q/2zWSuvSk87GJkqLyERo02qVoRQ388Fd/lxPQSt/QjbBFPUlJ1b45cQ5biAXbrpyS9+V/tL91X5vnd96L3dKQxnuykDC49M/bKvXC4cnG4hOxDL1sg+c4yirUpT18O2AO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iNw2b4xD; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZedDJFLlBChDBQlGxBzSEkyMc8drXeheTckSmWpAFurWZo8PM+ig6b50x7dOYqi5Ohdx+wH5EIAEmUV1pcnFA3G/yV6VY1MnVgRUIaj3Ml9zHAfov5GjyQCgp/P1iWrWl4dmEingObUonZPApucE+6QbhTobwwo9B6NM50yQwev1FMNBvKg873T5VIPRcmOquyZ+YyloW4hCTjefo+FYIWGACkJRyD3Vybpsf8xz/7qAwBkYDmeFO5IRtcbpvQknJpwoWsQZPCt9aZvpxvswrmFqWt3Q53hfkx77bko+2RigIDpwEw9XFSqLCW3AvNJg0hoPPm5x+3Klk7UxBiF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJoKEN2ABDI9wMUjabBCOX2//QXqT1up5hjeGjSwGyA=;
 b=MCRlisH5cI2oGNKJBY3E8wvilwrC4UzDQ28OzhOwwO6vxJ68WO60jdQk/Gp8dRRsqH5mMBckKdtZ8ioNamE5WbDho2sdZpdZmTr7mXnmX5ia7Z7DGrYGR8OjwEQ5nabiop8XGn5y4et6Cp55oVzctKcfZ7nJ9jA2/S8JwebSKWyBgpkVdvtxWhPR+TXqV42Qfjk1HHOWV9h8/DdkVu0NGp7QCI1uxZOdpXFjgakgOVdj+Agjfaz6MiKBj/UafhQE8zacPYHq8zPdc42DWCvZefDiraYed2csnn0Va3YbphtrExHEnuSXRynVLmJrnPtmM0OizJi/iSRQyE144xGZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJoKEN2ABDI9wMUjabBCOX2//QXqT1up5hjeGjSwGyA=;
 b=iNw2b4xDweCEoi0Dugl5JEz133VEPIpiyEFi7tOeWcJGq5ceGj/G4n1kzjg/eMFXCOc/otx//QCUrS2mQIdnB41AK2IZ00CtaiZVnJoabazQpidoXKT3UE742gwrra2FSX83ZgA2RvmShWDjh0tNIQ9CRt4q3R798eCFMbB0hpf1U2aoevHlRPQQVUcn472sDM6MyEGs8lw32twTl14bTOWB7FzQgff8C9CyygA4+h2KsTbMYm12zWCLxIaHGCkjBpb91gv1A/NeVFqoUEILkDWVs+lXdgjh9rwK3obLHDxetm75pUvh7dIdyny6Ou9sz6tm6KNdYfYRRjqjQHgjag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 03:05:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 03:05:35 +0000
Date: Wed, 16 Oct 2024 23:05:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 12/13] net: fec: fec_enet_rx_queue(): move_call
 to _vlan_hwaccel_put_tag()
Message-ID: <ZxB+91w802LBgp9Q@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-12-de783bd15e6a@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fec-cleanups-v1-12-de783bd15e6a@pengutronix.de>
X-ClientProxiedBy: BY3PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 709d4db8-e503-493c-f6c2-08dcee5891c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rQA+cuqIb0yb7O9bWIfIRLlFTuSG513IwhY4KAopDbDl7fLclnY0iOgQ2Ivo?=
 =?us-ascii?Q?W2yVDgAJpaRDQgeS2AwmkrPuvS76zNnCI2BlsUXzXLe6u34aJEhVs6w22Jom?=
 =?us-ascii?Q?ADFTn9GlnOkyGAhlq6H4MXUZ9lhfue2tSLthrIuk85DATgD64qQWh+LEUBex?=
 =?us-ascii?Q?6D46aNMzZorPGyPSstsY3wwqEW4BtdP8P0L+r8djpDhg5rRlDlvTJxFYpllT?=
 =?us-ascii?Q?HuAKWGyhyyQNFYAm2l8Rf4DZr2A2GsRH6GSSpeb43gqSg7WitGCdsXcMkEXG?=
 =?us-ascii?Q?AtzxaAId5hnYVeyxt8EiOVKSBS/KoT/XeE5ARA1Eh6xcotVhlCnbXw+FiQgc?=
 =?us-ascii?Q?5s7aUiEfkKe7MVSd3RZ1Mo3VYUGQh6OpShXyzzYiq+Hihp9eg2eRfvCYVbkh?=
 =?us-ascii?Q?Cpc24XRMzWgKUpEf2/N/ElJQwKhMwUT/8Xj3CDz/0lhY4VS4rygBaIwr7fJP?=
 =?us-ascii?Q?LW8pQFrjlCufPL/Ltft5USGF0uLruUT2ChRQpKKF35VKNH2Sj+7G8GLBoagF?=
 =?us-ascii?Q?2TP/n+DdMJrc4fkk4rpY4sEykviPAPlKFTihnbp+lmyEhLiqZz/97SeEaO+w?=
 =?us-ascii?Q?EhtK9mCzkT9csM5zyC6kmcPNNmv/icRBUVCp+nqYtQHNG/HxS6ha1o9Yt4HJ?=
 =?us-ascii?Q?Y2aVmRk+BWZRE//nhN7LacEg7jeKI8A4QSnPVobazmbhe4O4KxyiJcigihWB?=
 =?us-ascii?Q?bKotnzijdADWY0mN3uvjYJ7y6jgnJIGoScFSu+GLOtqVy/efTysy9daBsrss?=
 =?us-ascii?Q?S/r+KV21sYkQQhe/7LVJkEyZyyu8ZqSxT7mQWM2JZTFwjna6Z98r9+9yDV2F?=
 =?us-ascii?Q?ZEOwOdktH8J9UEOL85qjt5Mc26v0Xzz0ZqoPZ6AShUcUg3AMoXrH5sfV3ODX?=
 =?us-ascii?Q?Ui/ZZc45JdRvF+8rOO7YY9Uigs+Ac7U+Stf+sVCEachCxBpFssHp8Skz83JA?=
 =?us-ascii?Q?lpuZCzbFXDGTE4fmb3X0/WPZpMySvk3XB2tVCAJ8aaw63CdKnSV4dZdPkj61?=
 =?us-ascii?Q?SYlF/ONGa81SwPyn/5pF32MnHt96pfVjtkeL9B0pECguSbGAs6CWlG1V6jLq?=
 =?us-ascii?Q?W6B7/sPRXmC10Jx83O7e+CZV6WSvFaV+ppSaY2ixVPsr02eKPuhHE1NK+GTH?=
 =?us-ascii?Q?YFjdPGy+ApgVXmlcE2nlxzD1qOe0ym7Pk6Av6lpKZ4Lo0RGRUhvE/trHAMLa?=
 =?us-ascii?Q?rFNsA3wnHaOwxdHtbRV/pEf0oKdDzG7EW3tN1w6ZyIfQ110jKPmVQkfMbiuL?=
 =?us-ascii?Q?q8aXfe7wYi0S7cm/1D3lXhnyFJa6bb1Qd8YZcTXtmy8mz3OPKKuDOm3eWkzk?=
 =?us-ascii?Q?GE+yqeW2+98HiLFEsibLnM+Gnn40iXASEv7QvYrMaUf5ubO9p/nm28s08m8U?=
 =?us-ascii?Q?O/4myi4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?60QzPRZ+l4JK5enIJUGPf2Y0YetFrhYtfXPaSYr8smRaWij7ONcqnF+NLoiw?=
 =?us-ascii?Q?t0OrmI9rFue/MOMhap/4FwbOK/mm8QO9Xh1tQAAMybnvMyFJ+kv9qE4zMJgR?=
 =?us-ascii?Q?1anvTZ1vKmBfxhvqVVoXFghdZq88ewUn+npGmi+QXawhpkiw/kEchxKl6/gZ?=
 =?us-ascii?Q?x3CURN+YETUTtPOLyq0KVrgQI2Fx3L8TQOwjAPl9JHjJfFl7vmWilTe20juW?=
 =?us-ascii?Q?l2BrwOxCL4FXiMM0e7fxKhTLaPwzRBjLPQHSD4VcUOrtMbYY3pC1pjqpm0o1?=
 =?us-ascii?Q?rHF5QqVtqorWKzZhKe23N8igA8QXU2eHExIfBQlLr/7/nq1qc8x2tzbbP/cR?=
 =?us-ascii?Q?220PxwC650pJCtIzrAtrN0AQpS0QrMq4F0HaLgDVvevG71+noeQrtBK/9CV+?=
 =?us-ascii?Q?4LjCIxMOY9SrLMXDypwl2V+0cz8mDUeWtabkDeGVYbCuhwXqPBAGIPFvB6q3?=
 =?us-ascii?Q?qSQhIgECdHhSGA0qzVM08Yr3HyZrTXpiohESY454UcQFw0BvIZIyM5APwrgm?=
 =?us-ascii?Q?prpUVKJb1acPeDvKTBk6Msq/JUaXmgPI/16rmE4kEqDjH51x03oAmbI+UjYW?=
 =?us-ascii?Q?COCDSSrBmFPw5cp1JvTYLxv8Bp+H0fa9IyDKqRf8I2b8LHSlHVemHHBFsdvi?=
 =?us-ascii?Q?6zn7CZlDI6s/KAjL4XhDK5YKHlL1LL2b7qXqz6I6tr08pllZRi7m6ktw7JbO?=
 =?us-ascii?Q?ACA0MkcOkRctNTBH8jEl1BEXf1aFKRp1tq0oeE61NoqG7t8KoeAw8N6t5reb?=
 =?us-ascii?Q?GXWwT6C+KP3BgptNmzwI7mWUb95/WOdj+dVaA8gcaiBDBSMYz6r1c721LQO5?=
 =?us-ascii?Q?9ooHQBR1HKhW4aV6r7oG1vv+Mkrnx4AgFaKvda46sy7Ff2fcdTduH1wKpLPE?=
 =?us-ascii?Q?y1MhBpuUOokwm7e4zTG6Jx6hVwykyoTrGFmwVs1HsQCZaQ+JVCfc3nRqU//v?=
 =?us-ascii?Q?4JEX/B7IZuxozEn082HzTzsSRVjuqW+V79cTN3p9fWz39u0R1yO6fBd2Mfno?=
 =?us-ascii?Q?B5dy1ue5dPFxvZ0uLdkjy0RGodQFu1HIyb/QJqAjlhmMk6UNvMwJlrxZVnLM?=
 =?us-ascii?Q?4UvgWqDROzifpqNLRt4N51KTc0YfpD9GcdODbGpfdWVnv0xqNmD/fZbWPlxv?=
 =?us-ascii?Q?dYi3Ey3GsLod/DU1fW/G8MaZMFaMyGDq7heFI5u9nvmmkMA8cciOvY6wxVoO?=
 =?us-ascii?Q?SfOJefxOBd66G9++e8pPHfq33PPEiY9EiJ7+lrtCEpau7yuS8ZQwGLqA9jGY?=
 =?us-ascii?Q?xkxMiDRR+dlJXw7NVkhJbiDqAfVZfUcuvA9de0f+BjHqB4bDNaZa02cuNQkW?=
 =?us-ascii?Q?MHD2BgpA1IqW2uZGQ8nAvygQCXPVPpdoJ3iBhH04vZ6pk/oblBAkqmLikUVJ?=
 =?us-ascii?Q?Obzg9VF2vZVmQJzm7BP2pDeyDpv/1SXwa5m80mCeWh9kcGxiowvryoOFUUOY?=
 =?us-ascii?Q?7qyxNCRhPqsvMeOpMEo6pe97s6UMo4xX7nJRZihWrXQ8E4UqA32wJG1Rkuhi?=
 =?us-ascii?Q?ZLO6NcxB74V4jdC0uHG/3gYG1IRxgeohV6UJhG1YaTTnwr6F8QoJSAY/vYFE?=
 =?us-ascii?Q?VPQ5B1Dk1pIygTANxPvmhln3bo4NQ3T6FyJyqtH4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709d4db8-e503-493c-f6c2-08dcee5891c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 03:05:35.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGXHQ/KIJil6LXoiu0Oa6gg621ypOFeunQtLzsVGCktCeaeSKeq4O0kzh4nyShFXegDQ/N2XTNxdzqlvox2RTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898

On Wed, Oct 16, 2024 at 11:52:00PM +0200, Marc Kleine-Budde wrote:
> To clean up the VLAN handling, move the call to
> __vlan_hwaccel_put_tag() into the body of the if statement, which
> checks for VLAN handling in the first place.
>
> This allows to remove vlan_packet_rcvd and reduce the scope of
> vlan_tag.

Move __vlan_hwaccel_put_tag() into the if statement that sets
vlan_packet_rcvd=true. This change eliminates the unnecessary
vlan_packet_rcvd variable, simplifying the code and improving clarity.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 640fbde10861005e7e2eb23358bfeaac49ec1792..d9415c7c16cea3fc3d91e198c21af9fe9e21747e 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1688,8 +1688,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  	ushort	pkt_len;
>  	int	pkt_received = 0;
>  	struct	bufdesc_ex *ebdp = NULL;
> -	bool	vlan_packet_rcvd = false;
> -	u16	vlan_tag;
>  	int	index = 0;
>  	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
>  	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
> @@ -1814,18 +1812,18 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  			ebdp = (struct bufdesc_ex *)bdp;
>
>  		/* If this is a VLAN packet remove the VLAN Tag */
> -		vlan_packet_rcvd = false;
>  		if ((ndev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
>  		    fep->bufdesc_ex &&
>  		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))) {
>  			/* Push and remove the vlan tag */
>  			struct vlan_ethhdr *vlan_header = skb_vlan_eth_hdr(skb);
> -			vlan_tag = ntohs(vlan_header->h_vlan_TCI);
> -
> -			vlan_packet_rcvd = true;
> +			u16 vlan_tag = ntohs(vlan_header->h_vlan_TCI);
>
>  			memmove(skb->data + VLAN_HLEN, skb->data, ETH_ALEN * 2);
>  			skb_pull(skb, VLAN_HLEN);
> +			__vlan_hwaccel_put_tag(skb,
> +					       htons(ETH_P_8021Q),
> +					       vlan_tag);
>  		}
>
>  		skb->protocol = eth_type_trans(skb, ndev);
> @@ -1845,12 +1843,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  			}
>  		}
>
> -		/* Handle received VLAN packets */
> -		if (vlan_packet_rcvd)
> -			__vlan_hwaccel_put_tag(skb,
> -					       htons(ETH_P_8021Q),
> -					       vlan_tag);
> -
>  		skb_record_rx_queue(skb, queue_id);
>  		napi_gro_receive(&fep->napi, skb);
>
>
> --
> 2.45.2
>
>

