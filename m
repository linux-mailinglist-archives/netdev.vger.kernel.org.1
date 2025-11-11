Return-Path: <netdev+bounces-237756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CFCC4FF3E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 23:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C414C4E2CA0
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B133E272E45;
	Tue, 11 Nov 2025 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T5ntnPLD"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A241221DAC;
	Tue, 11 Nov 2025 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762899364; cv=fail; b=QUGy9mxC/6+YlG+n7gGqkJtB7ctEuVwDTgOs5s/RMVCS2fOaGwzCIu2kMpK+YCiwDGuLQZAl7N+RAkK0XzWsZl3yg6SMJEsrUGfp1Ov/6Sv5x8YtNlSRJpaH3QS0Sn8He6nhXhx/9pNSXXL1PbheaABnVuVh/QZovWgGVBubwVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762899364; c=relaxed/simple;
	bh=+C93tNS/tI4y9OF7F+yKrxzYJz1cJqSM/H/Tbkp+0Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TULBjumRGmfDpb+DxAYMn+yjR/lIBWDWiN+0ye+FtC3LT7kGN7RfEgvZCD/IkzU/blxLvSnDPMNKij+zAqkPGnTHl62vYckuN77jXYYehQCA5Og1o3wFM0+9NnM6fKqu2CxYj+Oc9sVbG6JkDLY8CY08jbcWgNim+PnH+eKbV+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T5ntnPLD; arc=fail smtp.client-ip=52.101.83.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxO2fmC2ykaGRQA3dXu64magzLvsay5tq0cDjxKgDoE2jHZieRKfTZNMpxRIK7dD6Y6bmz/dWfEH/qRgf6gDcXCM01c7u24B8TOiqRzFyzYjLZ25mgFq7Rmgzwch/bU9uJHqMHJRVWFxUC7+g0/urhpekHZZdriclAFGXFcQmAmqub9+YPf3Sf/Y27Hhhpo1AP3tFTo7howDA8BuWU1XKzba3LmH2B7LpsODtmNojhoEhdwmSsT1uHWxbZIfH6LB8YArBNj+TUpzyZpZJwD82HWvRflPajhybSX29/9pCnndJ+ZQo400efdXnTY49DFv5lSTEbtEzHSwIFa2lBMydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g91OxD1DwqWjujD6YI0M1+l9fQ0RG6p/pmbejQIuaxQ=;
 b=MQIzRquaNcrbirI6r2Zk354AE+mwmZ1HBmp7xTebDP698VEqphYGw2pHx7AuyT9yT3JHmLXG6/kIUkDNRzMRcHqXrbHB8xfuVcN7sWSiAAPpILF6EpRYVOA2kRvx47h4E3JbY7ZkA//pZK14Ai1A7ZPZKLPCLZUUQinFas0KJ6BUAzSSwrtaBm9wxlA5k8LiS1N3ROlkr2DfoHzOVEoAg0LPQ21VJp3nid2puafZXwBkZbrt05bl9KUlxuTj1ye6kC5gwernOQ/+bmEWDKl6TSD4OgrgmQluFJyIIEvSKZq2P8an1rOWYiQ6R12l1qSGXR6fF2wjBSqB6TfwldXpsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g91OxD1DwqWjujD6YI0M1+l9fQ0RG6p/pmbejQIuaxQ=;
 b=T5ntnPLDJCBwBEy7XVkt61ANV3IU+nv9gOCU8wud3mjDBNHCGWCxgztQtEZFRMOoykCYo+9FHNK2qCiYlhTgWouo8vu9+PULA8oIJ7LukHxgmCXc+sju5TXB2F2I1JlRQUL+JVNeqAlJN+wL8zKazqKHzMkXWK53jl56tSRlMZIYrchS1UfY20eCKXQ7Td5NiFE6T7Et43qrbEg4mqS/WOf4x3kzEzOCVrYmbhtNK3LFo3A9FMZTBSqWqBql2C409QosIwtk20cXuuYgdxsDcJ15vPiEOFHDaX07MBlg8oPWakpalTkoUYoDTsjMc15uDhN0CMEdebOPPZHyPK4dbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM8PR04MB8036.eurprd04.prod.outlook.com (2603:10a6:20b:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 11 Nov
 2025 22:15:58 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 22:15:58 +0000
Date: Tue, 11 Nov 2025 17:15:51 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eric@nelint.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: fec: remove useless conditional
 preprocessor directives
Message-ID: <aRO1l1KX+i0WL9WY@lizhi-Precision-Tower-5810>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111100057.2660101-2-wei.fang@nxp.com>
X-ClientProxiedBy: PH1PEPF00013312.namprd07.prod.outlook.com
 (2603:10b6:518:1::d) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM8PR04MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa85c4b-02c9-4062-d5a3-08de216fe3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SNhiQLIXMUd+JpOTr2a1pHsp4bMb+MW93MEPFwdkAsYFfE8r9GjPmNgnFLll?=
 =?us-ascii?Q?AwkowXd8CYpu/S+8tcq3CHcckbfoHohSQVKXxYSbWjRPsByZJ/gYDd2KLfT2?=
 =?us-ascii?Q?zpz5uvPJumFspKAXZ17IQYAPsrVYglufPy2qgmhZGHdQ+9c8kszt9soaassr?=
 =?us-ascii?Q?WquB80NRAweXsCGJZw6z5hUEHkDztCjejrnC4r8VyEPfmOKpMbpydgfZ2hGZ?=
 =?us-ascii?Q?Fspz3GLUDnd8sSHG5/GHZc2epkqpGCU0NVzZQ97jNd2IrEeqDdepXI7Uch8b?=
 =?us-ascii?Q?gpX6QufcbpURMYJ2JG2CWtg7UiRH5lk6tXfYx33RKX2t/equzTixdQXtblg1?=
 =?us-ascii?Q?9s+wW4Q7tYrcszCuxRdsuMXcP92d4mHXuO5z7BULxm4Habhvd0biBpxi2ZGR?=
 =?us-ascii?Q?7r9ApUP9TNLhK/BsQlnNhdm+u3IjCX4gbJ0oLWfNJmAozzhRXKt0TtXF5nRT?=
 =?us-ascii?Q?uTYZvXXHmvKI0ZXudurkeR8ff1NOnWVloG9TemXPFsvtUvk3/hJV41Davya9?=
 =?us-ascii?Q?wgN+hsKkJ6lcwOqR1njoD95ptFdmRz8OaeGq/MsLCiqrSMr2gCnW1I/XjEZh?=
 =?us-ascii?Q?N27WDRQtq058W7qrSs45ZJTve89+5pgfi8jwBHIBz94pyDY5CSmyPg6ZwxRP?=
 =?us-ascii?Q?qTnaAHVPjuaw6+VSyRAxRJ888YokQxiGBUeH06dh94LIeAILix2gwauOxaXQ?=
 =?us-ascii?Q?Iw2PPIawNMTq/O2dm3O/UZ51k/1Z3wDG2QbOUq2elhv5qVWAUfB8XBErfg3s?=
 =?us-ascii?Q?M8dGIqzgUy4+aHoiRTSfWof57W2fA3FyBiSwXJcOtH1WyOwzj/+0502dgoqy?=
 =?us-ascii?Q?0MIN2LOEMDSNQrVqRTVjaRm2Jjy8bZy6QJOpfjtKSiOrLBCXWlnLTjEXrIjG?=
 =?us-ascii?Q?S1EChW/+F1GBBrirsNebNxWH6duzbCNHjOfkFuFoztviB0qBPgLA1YMAmeLt?=
 =?us-ascii?Q?mR29Zxf69FJeqXz8nk3sxIZOPzqqrquRbZp12LziG0BqzF5KDDEVBObxXZDE?=
 =?us-ascii?Q?ernmy8thD1DCgrUK/EDQagJkE20qsWRMsS6dePm23y2ExOhhLqsBsUf+R0y8?=
 =?us-ascii?Q?MuF9BBksGD7Ih+v4Oexq0bh2FFj1F3/cc6nzCTvVAaZ8E0tFOZryvnxTniEm?=
 =?us-ascii?Q?qoW9gk8GnjszVIgplu5RtWD1FsrCro7QM3vyQzHvinaRP2QBnmEETAowO0pw?=
 =?us-ascii?Q?+amaFvFtiwFowE3MzTstfGh6D3DWdvLfHzGOJDlu/sukk6ASYV+OS0xwysrH?=
 =?us-ascii?Q?6xgb8IxnFT8OeRy9yxHukaF2FM8ZTwuuAqnfQrcrEAVJBbGgavMszPXmL4uc?=
 =?us-ascii?Q?YUbvK5WpjPIBA9EsxaE34J7uJTqZktfNSyns3bcz6KyrTF65VD5/dqaobQ3F?=
 =?us-ascii?Q?5gt4COGpzICyKQLQ3PlAHgQdk/LCp0xjdmPktXZf0B4Uh9fRR8ZFvOid6N2k?=
 =?us-ascii?Q?hLwpBrZhc5RFYyJU6QTClcR8zyUF8FqU4cea126fV1CuF5TYfjl74YyzDwv5?=
 =?us-ascii?Q?pjX7uSpAbdbxUoIi0Wq/1awl5hDLZk6BZkxQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nqfg2jsbU1eUTswklHxtQghfiSduGIp7sEbotFlErl1c+8qGm4ccXDdTO4lC?=
 =?us-ascii?Q?r2QtWX0zbCg678+fMWSVh+kuZ0uCV2ip8hv9deDyuSjNM+Pprn+FEsZm2VnV?=
 =?us-ascii?Q?ngF3af8HT8fNRLiQrANxD5EEBrkh4zu/BQEOxLZmJgAFWKqWBlN5F7GpQh9b?=
 =?us-ascii?Q?xq/xfsQgVilrq3BV16rQ2L73KhJUZ+PQs7PfNzNTiKiq53eBsarHOnQX7iiD?=
 =?us-ascii?Q?0jJQNt6yITa4KfhlSQ39DzfyW6Ygo/Sw99c2dXExnAXlqi5uUHQS9bM9yWPE?=
 =?us-ascii?Q?yQB/pHQI5vq3ACDgP8ruQ15eJk5VcwYXQlOS4kWk90p+ySEH4zUiUni8hUBs?=
 =?us-ascii?Q?6sWNhU0V/hdv4ZGeYJS0a7JtdutxTxNmJX1SZ2mAPr8qXaYPEwX7HiNCrx4t?=
 =?us-ascii?Q?Hu00cMaH9aGM4brxRfMdsUtzyZHndW2dkWCKWCD3ntcEZD8JD6f6np7ZVIfU?=
 =?us-ascii?Q?zzzLwqpIzpjmR5nq1iAOlyAmM0K0N01ufBAnbSFOuLx5voRqTSF/lsCoVfm6?=
 =?us-ascii?Q?Kz/Yd4aklICBiEXMNhriFPW4Y1HdGsHJlPxA2zF49294oybpfVtgi5ueaspE?=
 =?us-ascii?Q?rrdseiLbNKfBwreFR4c3GQe+ET8HeHMzdsuDXr0Z6wDdSq4fTS0p9xuMTzRX?=
 =?us-ascii?Q?bPDQWG3XAXgrrQJEBP2DvtPU7OAxVXLPjCB34du9AfnzMgRK/6FSvhQH9Thg?=
 =?us-ascii?Q?7qhVx8R19plMxwv5/bUZehlWmufPPpCIx4YbnUqqzb7zJzavmaKdbUQHj/fm?=
 =?us-ascii?Q?9MT0rDkErudyD8x9JTiJyFDLvYsAkdRfbquoPO60mDd203d2dWoOVYBA+lD5?=
 =?us-ascii?Q?FRNaG9+aoCMU7rg6D5eaZs8KJnqklYeeP2APELMMKH9zDbGXPWAEkHF4ADeh?=
 =?us-ascii?Q?2pF0YFJNLysHxuBIuy/DJoVH1rG+tjDhuSR15db8a9DQ51/2MG4lbsubXGTD?=
 =?us-ascii?Q?xFJfAxb/9D/0Ni+T3BtFLE2KraSjMcYd/fhRBKkJz5wmQGADuq1UHMNURE5x?=
 =?us-ascii?Q?arIMM1nrh9n8OgNY8GdterNnadnt/y6AcpeXpQeDRVBxYoL7WMaKtqRNP2kR?=
 =?us-ascii?Q?uj9K47KwA4/cHoOakFutArW/VOlKRH8QGxULEoTVMwrqlo/0TExEyHg1UeaI?=
 =?us-ascii?Q?mtPbQ89p9msf0d/404R9beDhKNhpLyqyX2ZwJXZKz3xs/EGePEmq4VSR1hxe?=
 =?us-ascii?Q?L+gBHAbwoiG2Z9ixXHTJUHmLjxBpfM6J/0GvzMwlBsczAJfHx1EDEjmLN9fk?=
 =?us-ascii?Q?a+FuAkQEuzyqdwoh75uIV2H+rIsZLQP5yOgDaJxwRfhYtWMNiNgtK1LRJIyR?=
 =?us-ascii?Q?wKWxbvisFBrdGgEgY31eVY7vhjh/NMG05kNf2f+iNpkBEX2lCyLEHpUH6/na?=
 =?us-ascii?Q?TLZ42qqvycmDAVPAH8N6rI+duHBSdHUpSxsvFtKLKLkLnRbAefQl0hoZEqRV?=
 =?us-ascii?Q?7hOw83Xz3mTJHMWcPgrTM8wzO1JxDJRYtPkARbqXhl82jPPqwR19rq1gcCk6?=
 =?us-ascii?Q?iAq1tHWzIxr2Ay7ayLujZJVqm6F33wFPPi5tHqibwnBR9Hb0UyGWbaTygLzc?=
 =?us-ascii?Q?gjbxuHIT2QjhXnf+xos=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa85c4b-02c9-4062-d5a3-08de216fe3f7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 22:15:58.6788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFgDi+o8t2EXs/eQjy2/lDdEARnPaxzV8Pc9MWcf7fGbiBNF3E/NbnJDlRSCksVAYj2jugXryP2OXxcCXWDopQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8036

On Tue, Nov 11, 2025 at 06:00:53PM +0800, Wei Fang wrote:
> The conditional preprocessor directive "#if !defined(CONFIG_M5272)" was
> added due to build errors on MCF5272 platform, see commit d13919301d9a
> ("net: fec: Fix build for MCF5272"). The compilation error was caused by
> some register macros not being defined on the MCF5272 platform.
> However,
> this preprocessor directive is not needed in some parts of the driver.
> First, removing it will not cause compilation errors. Second, these parts
> will check quirks, which do not exist on the MCF7527 platform. Therefore,
> we can safely delete these useless preprocessor directives.

How about

Drop conditional preprocessor directives added to fix build errors on the
MCF5272 platform (see commit d13919301d9a "net: fec: Fix build for
MCF5272"). The compilation errors were originally caused by some register
macros not being defined on that platform.

The driver now uses quirks to dynamically handle platform differences,
so these directives are no longer required and can be safely removed
without causing compilation or functional issue.

Frank

>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 742f3e81cc7c..e0e84f2979c8 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1773,7 +1773,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  	__fec32 cbd_bufaddr;
>  	u32 sub_len = 4;
>
> -#if !defined(CONFIG_M5272)
>  	/*If it has the FEC_QUIRK_HAS_RACC quirk property, the bit of
>  	 * FEC_RACC_SHIFT16 is set by default in the probe function.
>  	 */
> @@ -1781,7 +1780,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  		data_start += 2;
>  		sub_len += 2;
>  	}
> -#endif
>
>  #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
>  	/*
> @@ -2515,9 +2513,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
>  		phy_set_max_speed(phy_dev, 1000);
>  		phy_remove_link_mode(phy_dev,
>  				     ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
> -#if !defined(CONFIG_M5272)
>  		phy_support_sym_pause(phy_dev);
> -#endif
>  	}
>  	else
>  		phy_set_max_speed(phy_dev, 100);
> @@ -4400,11 +4396,9 @@ fec_probe(struct platform_device *pdev)
>  	fep->num_rx_queues = num_rx_qs;
>  	fep->num_tx_queues = num_tx_qs;
>
> -#if !defined(CONFIG_M5272)
>  	/* default enable pause frame auto negotiation */
>  	if (fep->quirks & FEC_QUIRK_HAS_GBIT)
>  		fep->pause_flag |= FEC_PAUSE_FLAG_AUTONEG;
> -#endif
>
>  	/* Select default pin state */
>  	pinctrl_pm_select_default_state(&pdev->dev);
> --
> 2.34.1
>

