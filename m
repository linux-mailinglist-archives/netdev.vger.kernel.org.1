Return-Path: <netdev+bounces-136382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21819A18C4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 04:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678DF2823C8
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 02:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CBF42040;
	Thu, 17 Oct 2024 02:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UHK+aTrq"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338D101F2;
	Thu, 17 Oct 2024 02:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133387; cv=fail; b=a8saBWV3ivNvyfcGGapMHnorDl0wttF+XTWVfkrDMmSZgPgxXeDZHMNgNsdQ4QdDY1Q0+iknLAlo1+54IPddzsrRkPGqpYGN7px6yNs0fHR05dpZo0JTquXsXifkuZLgj++3MtuoymFkvAL/3C2BJdytynQKV9Z7i6antffPfAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133387; c=relaxed/simple;
	bh=oWcNATQbg+KwMbysFvE3kcTilVpdKS74t4ZjqiMgkoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c1vjVDeHZiWhYNhzhHXWi+OP8eYEHIplkxUF8b8Vf4syiA7SCb7yF7lKtURY4FmUPNpP1Kyzjq+0VB6CBKB1Cnj9AjDuxZB5OvJVwyqxAAcDYT1vumHgkYb4NegMj23sJeT0Gd8kKPqHg/PNilEpBYC8yrm6zvTqhkaNI3A+6rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UHK+aTrq; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xN2goLOtJ0xWceHYgG9VMx4qH2LaLIKlsONXE2E8H8UNYlCuZRBDZTrt3jZW0XkoOLK5gb0/IY0nO3cnUNM8+LH1HkHQholRXeALnHfV8E4ltzn4YIsfkgA6RlHzbjgNfu8nCVpY3uZyHfDKFDhyOKyvif/7uxur6nJ65W00ihny7CuInnzNsreK+Cf/k2mQNjr9lrfBX7xYn2+nXiqhyvVSsNXlI1ctgoCnCv/YiQwUoMhDRGMocnrL3vD+Al4MpMkAM5a70OHySyXu3eeMJ8ZeZo4EqfJewvr/FCI9Kd5VA+qrZ12huZ9lUH8HU/3c+21ra+jrj+X7NCm4cepHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtvEhnvINzpZczpfyyr9mnRmdeGWwO//TixbI3BQeF4=;
 b=TcJtz49jxUs9EJaZuABaUyZnV0qD+DMoTtlRsUaDFr3qOCQbjU2D/EsCdlgiwFcyDNovqqcnd7sZCOL2tqcnFxN7V2jQCbmHgGyg+Tisvyt6OKpO5X+ra6PKJGMLiS6Mc3vWN2Ts0pjlUCr46YWLM0PuU+n/su4XG3b85BvWf4biXJ6tETsC1xEaoltaFsr3P7GZ4SwDdjkoM9WksZ7GVaOVleVTXNY2BNnSIW6t329xpGoXKpk4CjN+pnlueAmQCrayt0hn/KGMalSzUtSyPGjLPKwFfdf1Np3+uwxkWxHY38gm+4XtC17LyU9ZCSdlNIFUth5muqNU0jGR440LUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtvEhnvINzpZczpfyyr9mnRmdeGWwO//TixbI3BQeF4=;
 b=UHK+aTrqr0io0/R/mdo4rPrqgXj2hY8cvn+6WO8n277g8ner3FMpCHV3bqnvmn/WW0SfsRpMJf/kvaB+ohP6c8YDHxWIhFrEis4HrkccuEJDDO2UkqudLsGV5wHwMxDNjMSSjZ1lbXsyJ+qpN9/SKs/x0+vh5Vl+jglVaFqIfPpYXnlzPfzdXce8lSDvn7uVMgV62Tu4QTpzBGyKZiTLz/Yg4FxAG6HLaMbjQssqDyl+Ed44oIkonEVThmWlGkDJgaK+UO9D1jzVcIngsi2lJJSjyyam+A80tL0ZLTqM9/J1URX0xohQhM54Qgj3tw5S/P3nvfs7LcY5LCMus9RDNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 02:49:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 02:49:40 +0000
Date: Wed, 16 Oct 2024 22:49:33 -0400
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
Subject: Re: [PATCH net-next 11/13] net: fec: fec_enet_rx_queue(): reduce
 scope of data
Message-ID: <ZxB7PUEr48EqmOQJ@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-11-de783bd15e6a@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fec-cleanups-v1-11-de783bd15e6a@pengutronix.de>
X-ClientProxiedBy: BY5PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a86cd1-5fa6-4478-c336-08dcee5658be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qAZ1I1bzJUJXKOVtO9kCIdMNQjz77ziIwpAJV5i5QnT85zfyPmWdLUPlCLtZ?=
 =?us-ascii?Q?jpP2YUsgb54XsYBNF7mp+H/TiwP5Uwlsi8pqBxKurBzvSU8sRru3WVAVPK/i?=
 =?us-ascii?Q?pYbLJqXmILkMTneN7k+5SS73/VQwPgZsN0V4cTtj5dI8FnieoDC1NrQii+JA?=
 =?us-ascii?Q?bDbjo7XP7QLNABFZVwWsnlvpNJxa/l4UpDllX5p/QaDf82e0gv2ao1dqW3li?=
 =?us-ascii?Q?815+E2WnsgRHuThbKY3KkK9YlEbMDqdgfXSNoBq31ZJ6g3zPwPTpanvRxv4s?=
 =?us-ascii?Q?Lmp+0mUIaN0LQuYeRDSsMd9EAAV3dimf1YmVeCxmWZNaJSQMRqaql7Ty+m9N?=
 =?us-ascii?Q?u4ABUUt7JhQIVcwVh7fNDEGVsmmIo+X3fTTZg1HppwvTg0JIKytIy/KggdFK?=
 =?us-ascii?Q?Q7T2jMp1Vd1UcVoSGueztTY1ndVD7648RDVrL9ic35DAOzB01tu42OLUu5CR?=
 =?us-ascii?Q?2+8zQOgAzTt48awBLhw53i49WbXKA648SKtUzJgA9n18jMEb7kyLXPsfpDKl?=
 =?us-ascii?Q?aPyxBJQb5OSb/xcgDtMI3pbew4iveHJY1uBHM+XW7bir25T8psU7QJ1qENE7?=
 =?us-ascii?Q?OvYIscXXNu4s2edADHkWmQVIYIC0AtHTFqntIPhM3IULNz/oYtTmapJj8l0p?=
 =?us-ascii?Q?I08zM0dn09p7icveOct5AxfebJH769TLteQb84jagqgDAmmcrwNKCoalCnfM?=
 =?us-ascii?Q?MPGV7/sgy2QU0p3Lj0un5wgeYUegGZVsK6aoWnac/QMheLFie7yenTK6MdjL?=
 =?us-ascii?Q?FkzzhKHHyH2Crs0wGHa/x4nzTGWwKXPkMJldJdT9kXKQ2YVgHj7x8H0MVCSm?=
 =?us-ascii?Q?pTDO0l6j+pkzgVW/F0c84/bz8Yqq84h+89iytOsJZW0sT5y4enc2J0k8axoE?=
 =?us-ascii?Q?sDHaF8Ngg1lcmxw4AN4VN5nhnLM3U41rFo0yQ0h76NLcyCrv1Qnk7ia+h+1u?=
 =?us-ascii?Q?7KyiOs0Y1ETMxlW/W3DRfC/MxsCPYqT/1mdfqIHnlq5IJKCRLAjIukU7QSKj?=
 =?us-ascii?Q?i4Z+Gdp6Fid3olt6nC50n0ndPwALGsqufBQ0CMcsOlEkdcO3CIHgxxYd2O46?=
 =?us-ascii?Q?jkZ87znE6mtjRxx7wYuAcOszPXarDFe7b4jgvHqL3gueE98sPDTMLgRNur2I?=
 =?us-ascii?Q?NBjT3LCxCLd3yeMaCUb+tUdXtywBAdbI/KcfjiDKxIF+ozwY8of22XSmeMJl?=
 =?us-ascii?Q?0+5/O8K3KZlYL415FBO/4VRSo3NZIAYNYQ1UIc0I+xnbTf3XJ5GNVg30tudb?=
 =?us-ascii?Q?7YUCX6FHxqOZDOmglSu+jtnccF5CPAA0TdKUlY7RH7fqGX9YKGNtqT+b3MxN?=
 =?us-ascii?Q?34lTa+FPsAvHgLkENO4iDfrua63pL8a/PdqGNTq07W2zoXgXIM6nu56GCia7?=
 =?us-ascii?Q?IPcBNQU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+E0DScfD2z7jAvQsT1rO5Va6+9uqyS1zZStbML4fo+AH3zYbJJ5Lj/qnMqM?=
 =?us-ascii?Q?shWs702hbwoFAGwxR9049aLCEfXmxFBa0naNTpZwTfqgP+cNJroAwEz9cFyh?=
 =?us-ascii?Q?RmJje2FNtVbP+dFy0ExKOspVu+aLX+dPBRY9JrkjDki+NWoU3VfWmEZjupPo?=
 =?us-ascii?Q?SkoyzOFCZXtA5IH7EHOrx2HTBPftvMmXvC86SmjlbLucmcfzpaLi76sSCRaR?=
 =?us-ascii?Q?YpNzU192p0Bhkc3XMIFJfTvrrrYHO/v9wgZu45wwdATae36SuHVlKQrf/3rr?=
 =?us-ascii?Q?Mrxx3mgDmDAMjrxNlj+9HM+q0uD3sm1rqThiuu/5n9IW7uhkx2+nYZeipIeZ?=
 =?us-ascii?Q?zL4476Er/dS5A8rYCyl30mExkg+C+9Ca/5GrzZh6wRnpH+H66ytaaaF/LrAl?=
 =?us-ascii?Q?DSt/6NeFPhIi3+N137qGXbFyfZ2ouBsf6X4SAw1gWkTkGdfwbsckMqdiBrJk?=
 =?us-ascii?Q?qoK0YZqOuF80sJPQk+ntzTsIyZum9yVa9CZT5h1lkCB7ju3y7UxGLQoSPPuc?=
 =?us-ascii?Q?4+Lbyk19WzquDBjSLFzflJ9YLyGNP/MG1l8blAcDzSMkfhrs5EdpjP9424o5?=
 =?us-ascii?Q?CKL/S2hTbusijNf7RNdzPsBdrX+wQ1jo19tSUomwyvNI+bhmzxsH/unDleNl?=
 =?us-ascii?Q?IDPPYDKMoO5hpvRdUZo/2cuifc8IsLWLkDrEJPpTU58Oj48DE6tckJNPkAMy?=
 =?us-ascii?Q?6RywILSouM/330UcTKlW6GCr48f11jNpkSrT5YzQ35oiWPmPF2oDoyHSuVC9?=
 =?us-ascii?Q?/N9By83/2VAKMm0uEXQrfH/VS/qNgiaTBYnX6YGXNUOoZc/mOIEZJX+LpOPV?=
 =?us-ascii?Q?UnlHQmakgV/2iT5DKv8LiATIDqBuQbsEpphFmP5v6EKHn2QTE4bG/dNNOK2F?=
 =?us-ascii?Q?RG3CnDSWI+iQFOyc3D/XGxO+1VUBAFiabApluTiEy4JUMA1Yp3dVSiVSauyt?=
 =?us-ascii?Q?T4wGSBqARW5g4Q/I2hTzKgEPcfJWb/xJUYJSQhrzY/DDDkXmJ8jG/f7LaA8F?=
 =?us-ascii?Q?8G9YPx72OS6QO0ldgEjCbjiEqV8FXSTKKoH3pMX9L2RhNxpVnB194nrQrSbn?=
 =?us-ascii?Q?adSRiyhxxie2nAtTdaHMleHq/OLvGx4TLJT9DXMSujbqx6fR28fwUuUo8koZ?=
 =?us-ascii?Q?H/fnXgL1SoPR1cgdwPcFhhAkceMG1hvLxwLhXRBqMMwSGidNTvY3F9wVJRUQ?=
 =?us-ascii?Q?0vFNvp92i5qMQTC2Ip0CXAGPeoYyRVeUoeFzGK1GTfGG1vNYoU6vIodjI25H?=
 =?us-ascii?Q?I0AaMZG9gxEWZhTebZ1z7B/MgBJVUMDkJ+NWByXtnWo397pxzzGoZms4qSUg?=
 =?us-ascii?Q?r2GSWQiAKmL1Tb3lLyV2u8GdKN+KZBJf2YHmG2ocHPuJodmpwsKoJPD8AAeX?=
 =?us-ascii?Q?Mz0sTCtkDRhfbP66MvXpa9EMHeHWamYExODSWKCMProayQ1em/nwXEXocShP?=
 =?us-ascii?Q?HgC6bhoYpT1w2dKwwThifDxSul1/JaFjWaOQhfb+ZCh3MEf0Rlwc6AF/tg4C?=
 =?us-ascii?Q?6lyAesIn4thNWApXnAn0ZmxVIspltTn4OPw9H/lADXk/bxqBX0EkFPSy+GuU?=
 =?us-ascii?Q?bIkbvpSrEo/54iA+gPw/6VD3he9j4cN311f1a8n+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a86cd1-5fa6-4478-c336-08dcee5658be
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 02:49:40.5857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: av+tkW9yVZej+xsxbDbv1AEPtLn4ihYAFOFnn1eoIDL0GuYJxd4Fl8Btf84VxBKLny4drK9kEfgCZtamBKATNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

On Wed, Oct 16, 2024 at 11:51:59PM +0200, Marc Kleine-Budde wrote:
> In order to clean up of the VLAN handling, reduce the scope of data.
>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index fd7a78ec5fa8ac0f7d141779938a4690594dbef1..640fbde10861005e7e2eb23358bfeaac49ec1792 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1686,7 +1686,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  	unsigned short status;
>  	struct  sk_buff *skb;
>  	ushort	pkt_len;
> -	__u8 *data;
>  	int	pkt_received = 0;
>  	struct	bufdesc_ex *ebdp = NULL;
>  	bool	vlan_packet_rcvd = false;
> @@ -1803,10 +1802,11 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  		skb_mark_for_recycle(skb);
>
>  		if (unlikely(need_swap)) {
> +			u8 *data;
> +
>  			data = page_address(page) + FEC_ENET_XDP_HEADROOM;
>  			swap_buffer(data, pkt_len);
>  		}
> -		data = skb->data;
>
>  		/* Extract the enhanced buffer descriptor */
>  		ebdp = NULL;
> @@ -1824,7 +1824,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>
>  			vlan_packet_rcvd = true;
>
> -			memmove(skb->data + VLAN_HLEN, data, ETH_ALEN * 2);
> +			memmove(skb->data + VLAN_HLEN, skb->data, ETH_ALEN * 2);
>  			skb_pull(skb, VLAN_HLEN);
>  		}
>
>
> --
> 2.45.2
>
>

