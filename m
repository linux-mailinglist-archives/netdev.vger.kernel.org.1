Return-Path: <netdev+bounces-136379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ED89A18A2
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 04:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D766282CFB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 02:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029FC27456;
	Thu, 17 Oct 2024 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D5b8vrRo"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C6101F2;
	Thu, 17 Oct 2024 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729132352; cv=fail; b=ExKR/RWeHCR5cPIf28HE/pz5rstzmFw0BHsJLbr11mn7R5kPzBON5t6DVm0x9GUrW/rZYxmcpMY8RCOsyzUtNWMUsN5wnS7FlAyn++eYhXHspO8/pY7kKkveFdJPd2Qgr9dQjNhaEclqdiwUORRilQ4pr9lGQ+D8N8QgfsUKjVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729132352; c=relaxed/simple;
	bh=9CjMPWp3yVaFxy5lQAh6lyU/iVCVLNyVL7iAGBDK6+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jmJLm4aNfwfPLmIW6ORiuLuTrwHzfhFbCE9HPz2Iq8sM9pywjh1ypzko+UUevjr9cm99uiHo4HYQqBjffZNUGTcBIBq/PHzxF9nS7J5PNzVmdV/cBDkRENON7iERxTKSjhvr1WBztRzbJs5Hk520ByvVjtDMKB6FsRgBS5tZM6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D5b8vrRo; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBd40ANeJNHXjEtJ2xQNCt/HqTPSyT/IyC0JKrzxKuFGb485FFrTM0AGyj0R3ZRqkSdKgsHxBa4ENIVpqHUOC/9ukMUeBihEwOwxwmcaVQndLIVMIMjIwiBdx2Hguq+G2bJ0jcMromA2Id4Ui363HjS71VazKJqdP+vl0rW4pHFr9qMUAfaRlU5q9QJ/v4ap8nbpWQs4YnPJ0t0ZwPBVM+/Cxk6GtIVgM9UVkFZrjkP8lbe97Y6e+AzR40QyaF/5NfPNuTchAmSvKoMOi83PEtv9qshge40Cp6LnA6EqxfEEl2H5R0wY37Lra3uAJjoClnpaJtVyTKIVbA1gR1ikqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYbelwST1XC0K74ve/xXajUCUrNS4rQRFvfHy4Qgj2U=;
 b=NPGOIuVnoIyJvDJ2RmBh3rKu/nPR4ZWx8TdeSyS5XDjQlE18CZiw/qltht6WlKhnExkkqpfv1OV6OOqnQEAqqP1aWwmwcOANk7wQyUqDbWUg0NiIV73l4HOaxkHFhfVeBUsKmfCbyppXq9l/9Zq03liiiVr2SUOzWIG4Gakeye430DB0Gll3CQeu54I0yt5ol4Q1/mCEBTp7HTAuGdPgrsKJBjLEE6a60tFbfUeGc95hzmhukC08BrMR55GNowDJ/RS0gIxvbVB6u9QykPD2hZBVF8IS4w54uOP9Wrhct1hMcQPbUCn0cG0TzoMJm4OqwiqfkyQY8cHAPhd9aAdYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYbelwST1XC0K74ve/xXajUCUrNS4rQRFvfHy4Qgj2U=;
 b=D5b8vrRoJGEUNm6/0NAQNC67H6rE6a2npUOR8ULy/oAUGQ6s4tegM1CfCmJqo92WwOuqK5OM3J4dUY/L0KDZHoxof8nGZ2MYMPgkawRGnb19Qr9MyLKb/RqgnplMs9iEmNpcBl0CYuFJdlX1M/tToRCG2YftTbpf9QuupK7h6B8VfzCmMdlv+9Y0b6ZpwbCR5vK3djpg0JsQjabQSMXWHGCY7Vwoa5669zqKggYmnTfQfMz65GGwd2loLe+lASYa+qjYu80YVNHm61vpiGBcgsb7aONnFjRj3M+mENRX3VKZFO1vGOZtP2C3cwM2Lzbr9YEdPjQtIBX2l1EcPz/S1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9387.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 02:32:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 02:32:27 +0000
Date: Wed, 16 Oct 2024 22:32:20 -0400
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
Subject: Re: [PATCH net-next 09/13] net: fec: fec_enet_rx_queue(): use same
 signature as fec_enet_tx_queue()
Message-ID: <ZxB3NB7qbSuPluZc@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-9-de783bd15e6a@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fec-cleanups-v1-9-de783bd15e6a@pengutronix.de>
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da3e1fc-ef83-440f-e37e-08dcee53f12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUl2aEhUSGEaGMEWq303c8rt5n/pQIfXbPKfmAah3D1BkTpT0vhhnWIqu848?=
 =?us-ascii?Q?bsV6dUkbWoDP+h3jy4itDWiR548GIbSUwYbJjV3XuuRatggaifkKmDAfWEDL?=
 =?us-ascii?Q?Uakt0xAesfsEN7tqKV0hRYosqsQI0SAuYHLke9bcWFNcKi93i0B7IcBW4G6f?=
 =?us-ascii?Q?omL4FMqYkfCJKdovgRqPJGHngs18FIfRnxOLb1cUd7sOiWUVpuPm4yebvDr2?=
 =?us-ascii?Q?KY/ou14ImIDj1FXqyMkB0a8vP4n0HbDgcTZc6ck5yRvwVHz980FSNWxAFzFX?=
 =?us-ascii?Q?1Kicy/7pYkrESVu+fSgqWUpOVwCZcqe2rhaVAFhjYWBBRx3OWlTmlk4QjdCt?=
 =?us-ascii?Q?WiLVeIQuu+aLUq2jyjXzg6Sbt5ybJoryRBujlXCS+WtA4CgtyMZvsRmMoL9P?=
 =?us-ascii?Q?Pgh0/4xOoSO/1yC2FMYJNFEKqmnX3os9m6eV56iy6a8BLmS0ImggtfaYkl2T?=
 =?us-ascii?Q?08G0KeaqtyCUKEMYlg2YySAYDhrFJ0YlWGBvQw/2Y/rUHo8k7vom7lXxJHp3?=
 =?us-ascii?Q?2dBi72gYDA8GyaxDcztJSh8UHn7kAOMsKuoW4qFM5v5OkiFPdPsDC6UZamJP?=
 =?us-ascii?Q?B/zWBxSulb9+wsYTdnQzV6eRACpOqigyUYmHI82HgjHiQSfi/5jxFSGfP8Gv?=
 =?us-ascii?Q?4UIDJ7qZK8Maa6QOH1ddwa5hvk2rbKzTTtjHwYD6Z9YHp4+fvY+b0+PpvUOb?=
 =?us-ascii?Q?W5W9GFZBWDnu8YLSiyCEKLPtivT/mN0XkbZ3kh1/xeEkBhzQ9C/tUA4u1X6d?=
 =?us-ascii?Q?p+p7IU+0PgkmQx2w60mGzEdiaa6XyhSoo5OxGDx7qfXJJ89L69nkkw4lbT9G?=
 =?us-ascii?Q?DMI9+QIl+nHJIx2tW52Hcu/L7KLb559QW3hLXov38mQMs26tFPYWMGKdNuX1?=
 =?us-ascii?Q?AhL+0eX+DfuXdWjP/T2qq4dq+YQNL8NMkAK7efODtrP9zhgpM1gja5e6HIP6?=
 =?us-ascii?Q?rpy3pGs8ihHmJIMVuwOX1TrHBlsXlSgKI0g76xsH/XeNLj+ONJOdEQbQ81Mk?=
 =?us-ascii?Q?RkV3bDuTv6GSQRD4hKaxG59OpD7Kh117kq9XqbmC463bdgbXycJ826DMwLpC?=
 =?us-ascii?Q?Vt4I6F13234og6G6WEJf/IPyM/mrmziXaisUOUjQTzH6N8RUeQ6yf3tx02q3?=
 =?us-ascii?Q?cIiyNYLTuA6nML9IBmAGCnSvEkoVEggxcqArquv7fXu1G2CphhPhsikYBt4Y?=
 =?us-ascii?Q?JSamFwh+AIWT54ESPxg+ppfPTPvtt2PIKgnGiNgahkHFhmp0nRjCjAXpksYt?=
 =?us-ascii?Q?WWU5ta4qPNCfJ4hm4rWC7jBtzX1RaXy5PjQ38sM9Sof0s2nHaptfLzEQj2cX?=
 =?us-ascii?Q?5VNPD5XV60Bb8U+tVDRV+7O76y4VGXtNCjpMLTUWxCljFf4Q8WFmdS4NvGxK?=
 =?us-ascii?Q?+Aej3WA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OZ/JqFITxnWybCX5C1owcUL+QBB0DlzANPtsrRpEIq8lQgry/uMtLhgfIKa/?=
 =?us-ascii?Q?bvLP3yrmnsTd7Hh1Vz94XK0ZuY7vDsXPx7kHovrM/1MfL5fdvNyM6FJMcVEb?=
 =?us-ascii?Q?yz1Dc1ylQqTpn5P/xEdVqzLCesMNt6ez4bhE/bTSt3yIva7yGe+W+U1DVtKv?=
 =?us-ascii?Q?6uBN4MSyZToF6NWPIy8DRriq6XcLAqc77gJIEmizpOPHgydAm1ya3lGsaNoy?=
 =?us-ascii?Q?irPzSFKquieGYW4ZhyW0FqlY0y163c1zefp0f3y0xj9V/C9eQ75993yCU3H6?=
 =?us-ascii?Q?BncusE5OgIYTAxz5UjcLArTtVDaRjwik4eQ0Hc2Yc6hrzk9EBqmR6VFDOtyY?=
 =?us-ascii?Q?AwEOnvl5Sdj96fRWXh0Z1xKPmTzAor1jk4ohiwfFVvAVxFSSAFv3nwW5H20a?=
 =?us-ascii?Q?oTgysCVpyWE6JCoTe4liU1fB3qcypIGestKQafsit0nEshTE6DtnmJ/7yNCR?=
 =?us-ascii?Q?9wG0R+5MvITXeysBSp82Idr9aJmaHKEOHe9XtOM+IDVYviqlLUh8dQMVGJho?=
 =?us-ascii?Q?bWDR3NGAKyNbYMbYX/2r9qoMnLEo4SGK+dEd7104o5fy+ubwfU4aaCam7kKQ?=
 =?us-ascii?Q?5wmd2FiRpkYPWkZ0ojSx7qUvhKj1yrh2HEAgRZuZGibc+ekPBdZfO1BXUXBh?=
 =?us-ascii?Q?CB3HW6/ZUjtRjq5iqGhM0FTQKKVsNUOGgLWnwmjkCw5qWyqSXgjfuC/WfBUU?=
 =?us-ascii?Q?Mg1z/Jl8JC1ITCNsp+9NonRMVorMGprHqOlmwkvxLHCvMgF//7ZVib71FQy3?=
 =?us-ascii?Q?zUuXHSpOK9QreW7nRG/qEWslRMRpC7rNpdwtNSTVS0ikHm9E74vjX7fOzL5Y?=
 =?us-ascii?Q?aVM0Q9nee6xzAWPwjLwkt3fBodrkAIaVhmytwE4g6E7W7UpL/8FZglY+lyiC?=
 =?us-ascii?Q?wTC9XnGuoJz4Y84+Yw3qsUE5MkGVS+gJeQqntGziwWQuBKBYOljaS0AdOmfN?=
 =?us-ascii?Q?SX06UZsGIrSjfCtnS0QnfgRg8WXQRWFK/rWPg7Y8OYnNOveafPAyWNg21k2F?=
 =?us-ascii?Q?uaIiXw1suzODmbX6DePby3H0Z04tU56UkrjZc+Fm5Bbp0StAR6elXUa4b2C3?=
 =?us-ascii?Q?1XX2Wg0jXuh6YG40YlZV8LgTyJq4NqYb8VEUxODfxZoyzq/GRvRJfMlTr+PH?=
 =?us-ascii?Q?S/hLYqHUSoN3aZ9kVJGESPKevNPROa5dtiTtAIdF5A3Fk2nCWLl7R7EzhC1l?=
 =?us-ascii?Q?3nKHCXz7QQrJ7ReXYGqEI+9yJawyARvOWTzgKAQSvvnJqtXDrv7UCyEAobgp?=
 =?us-ascii?Q?32FqQNXipuSlMggDh4zj+4wkTl9cdJWadtWwTC+GFI58RMO503oOxf5TC4Go?=
 =?us-ascii?Q?q2WVjCIkmB+kjUheE+4M7wG9pzYAe081EBW7OfL7IWZ9Lgg16UpWJSrdOGj0?=
 =?us-ascii?Q?Fht4Ln81es1otBlQmBPorIjBJ5suUp5mJNHvZ8SePLZ2ZbB2fcSXwTrD0RnJ?=
 =?us-ascii?Q?6g/wdLXajH9N/fH8eNKusFiBQBtKqQCxjhwjOOCHBuqZDY96VVhaL+TPpeNS?=
 =?us-ascii?Q?l/fu6u22lRBrAoiidrYuxPFkVTHGhiAXPdi3nXJZjCwgDSHeVoS8yPjUkxg2?=
 =?us-ascii?Q?tGg0rqRofbRx+4LWG4A5rvJCkP4O6/KHov/kqqiK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da3e1fc-ef83-440f-e37e-08dcee53f12b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 02:32:27.6694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oevwkIB/2I1t2GDBr4GYuFtI6Eq+abwKP1cEIyxD6t1zYBHbXYI9K+x3TwWJqNjlKzyjWyAJp5dew2yp+on6vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9387

On Wed, Oct 16, 2024 at 11:51:57PM +0200, Marc Kleine-Budde wrote:
> There are the functions fec_enet_rx_queue() and fec_enet_tx_queue(),
> one for handling the RX queue the other one handles the TX queue.
>
> However they don't have the same signature. To make the code more
> readable make the signature of fec_enet_rx_queue() identical to the
> signature of fec_enet_tx_queue().

'signature' is strange here.

Align fec_enet_rx_queue() argument order with fec_enet_tx_queue() to make
code more readable.

Frank

>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index c8b2170735e599cd10492169ab32d0e20b28311b..eb26e869c026225194f4df66db145494408bfe8a 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1678,7 +1678,7 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
>   * effectively tossing the packet.
>   */
>  static int
> -fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
> +fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
>  	struct fec_enet_priv_rx_q *rxq;
> @@ -1899,7 +1899,7 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
>
>  	/* Make sure that AVB queues are processed first. */
>  	for (i = fep->num_rx_queues - 1; i >= 0; i--)
> -		done += fec_enet_rx_queue(ndev, budget - done, i);
> +		done += fec_enet_rx_queue(ndev, i, budget - done);
>
>  	return done;
>  }
>
> --
> 2.45.2
>
>

