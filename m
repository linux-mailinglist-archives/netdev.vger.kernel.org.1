Return-Path: <netdev+bounces-142944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1016B9C0BAC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1806E1C20A93
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE1F200B9A;
	Thu,  7 Nov 2024 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a1E9RCNR"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F938DC8;
	Thu,  7 Nov 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996986; cv=fail; b=b/Yv/+chb7tAIKr/CqXLWeg4V/oSnji292NxtDROgZxvgKF2ucUWJI+umZfp+t9NDIvy3R+TKTLCRYd8k6v2ufCntjzhxCvc7gNU0jOunb/fWNda8A3aR3YFZykbky2xvIMhaYC2V9A9anXApc9FrirgNBp+8CvJdly1wuTasEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996986; c=relaxed/simple;
	bh=HYzf3IYZn2DKq0baWCpNmq9LbZVyhPebK8jJ4Y8gZuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S34kI+nA7BhqBD5n/EaQ53w6vN/d1Ty3iy7FYxRCtaVSipNDblazbfM8Kd4jgZGMRHjeGStOLKfPAB/rtaduUU2fZOoyrc7OnAHk3yG60C4UWHnSdLUYgRO8OR/WfRvkJ/6wQUrv3nld1IJ5TAHk64WkPZjpYFXs94Gp7qOYVuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a1E9RCNR; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXhJirbKHlqAJcnRCWfhYBHmByOy7bY81g4lj3eKLi5TI9r0i0R2Nzgcnv8giO+1ParQZFYL8ZOO9j4Hph1EbNRRE/fa4toFJZrTQFrw0h7v4lQn+EoP0+yoW8HimZ4yjTXVFBFJTWau0cRPcLFNk3grtoOq68wD0+pr3WP/c7zCJwHqEbXreAqvqeX+eGRjJWqzSEVmIvpfTBWfk+yBcqIXZncdwT5ecFVJyBtbxnM4nQFGyIULRWngugiY3dK/aNtR3zVgVTHf7jxZ3gGpAz14OklD+4UxEqeXuIyTid9zb3jNGvBfC8UG/GERLLW1UmZb/90EEO4Zv8O7mBhNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qr1oMBZS9vatPMPebN6Ka1NW/Hu89W85lD0P5xgdmMA=;
 b=CAuwNokRzxw0W76is+ViVs3f+466ROKMOo9qxUaA97tJdu30JgpXYxbhmPmxMFXNVQtN9iwhx5S7PMGN7J8RXt+ra4oRZlPyJ/qt35k7ihqh4xpp3jitEUrp8dH7qE9m/wLaZ/NXsDXQ7Rkd2+G3N53IbgMogwyFp3FdB/N6/h2NsmWFkBKmZAjSZiv55JsgM21fZ3G8J+RITMJkGL4AKYoYfXHWF7VmNdVlOeHv35dxaqxscwIfm/RQRRLlaUsg6hQeGvhI0TsJPLgOKC8iLBuj8GIyc7wDdlPQs74EMu2DfZumyzodj1U3Eu143M2vDqkOvwU1VmeENXclX/4bdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qr1oMBZS9vatPMPebN6Ka1NW/Hu89W85lD0P5xgdmMA=;
 b=a1E9RCNRw8qcT7s63roAhY5uik074oVmscS9nqOKMlRnT/KvVuZI8Ac2k6tygJzhNaJs6j4WLrd27ZUetr4WCnpjhdP5cQVaCI0i1ryLSa4KRWN1D20Pd18Kzrvww8+nTXt7rthM7ctLsZ5tSxC6vIUjLT/nn3w59KQbNLLjBAt7lPeDfikdPkqLeeRux74YxLsUOcfTlmDZV0A/Uk/AjRKD352/EkoIFpJ2h4lKBDb+Uf37w+wSoSYEw9QRANSx34ATBj0/ZIDBKvc3E5GBtan5Fz1pCigp00xOYnjRKVGaBfI58bLEqze3KE8TAUZTFIcFhONLOvimR2sPnt0CxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 16:29:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:29:37 +0000
Date: Thu, 7 Nov 2024 11:29:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Message-ID: <Zyzq6RskMsXer6PV@lizhi-Precision-Tower-5810>
References: <20241107033817.1654163-1-wei.fang@nxp.com>
 <20241107033817.1654163-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107033817.1654163-3-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b9a624-a376-4a42-c1fa-08dcff495f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I9OvxfrEZe+/xqwHIUJyBwLwyM9CLvxHFMuYpdgWwyIs7lBAVkq8ZBJ3ALF4?=
 =?us-ascii?Q?NI3rf2W5ZEaXRz0kqTGRk2wxUTAVRBywRh3t+abFPd23Y89tXfAE2TxG1GGL?=
 =?us-ascii?Q?v75237Tm0D9ffmg0Mc3iPXAgJR3S1/UYE3x/yoHyY6dpMjN9ePLWHhIQBu6g?=
 =?us-ascii?Q?nuHlk8+EZjIrWEULzE1L7R6wZczpnLLw/7D2VsvSbMh4JLpaKQKeGBT+uNam?=
 =?us-ascii?Q?ZZlG2dsqirnsHw72lO13bODkhYbhoQu7aFnLV7SLZlEaBNMEFhDgW6Eoylar?=
 =?us-ascii?Q?W+fxi1WsspBWDFVgBzToI51HbehvZIEVafxcxVg4Zk5jNRmJ+Zp/al9X2fJU?=
 =?us-ascii?Q?lB72+mPnZrNuiHOv3IBWYTeng9hgeZRenQ6bGKZV0I9MPn0R6e012BOUUnmv?=
 =?us-ascii?Q?6x3/Tun23O4YuE4JjTYb+cmHitcur0Rw6SY8xgxv97J5KMGlBwsUHTTtO0w9?=
 =?us-ascii?Q?rVOX9Uy2E+33C7IHogFCHeTgh2y18UfBnrv4Bj/+mNe6ghrO8IQebGr368NF?=
 =?us-ascii?Q?2a0HeOcFeR2m62HUEeXZdTVni3xwNp8uY79b/256SOD2LBXbiPb1xFZAnCW2?=
 =?us-ascii?Q?UmWK1TeZiMBfZsJD57idzFHKvG4ZRoqigHbgcT/Fy6j5AT1UO9QNxN5WVzMq?=
 =?us-ascii?Q?97xEqnnRzW/AlH+DcQ+ZbNgdQv8AUHTvj2Nd8EHXXyQh9aeRx2aQuJavS4Bh?=
 =?us-ascii?Q?rAJOque3wBPuZjM09qR2MfgQytGgzj6SADwShfcFj44zZCZluFxNB0THoR4I?=
 =?us-ascii?Q?7MmrtLfExqHr59GwDadi8tVp7cgR235+ZYYdtYM7CSPFQlw/prXnDMJiwbAD?=
 =?us-ascii?Q?WrGsqRk3/8Dxu8MZb+lBXM7T1tDasQaCwPSa0kJhCN14MitzkrBOL4KnGpoG?=
 =?us-ascii?Q?xJJXmg39mV7Ybmzcr+6NbnC9z+eYbx/VKIeiPMH/DCn6LdUxvUQHuf7GW/pu?=
 =?us-ascii?Q?CVN4EhgNZo06KxSqGqljrefjBg7W8VYYqPlc9Ywl/p7EGg6dQRwjjaKDYDfI?=
 =?us-ascii?Q?4C4OWVBBCfRxxco0km7XXMQXW172hMtZ5Vt9Qig/IrjW1jZZWRDKks5qA8bL?=
 =?us-ascii?Q?uL99vQLcbq+7cYuF7bkWyCTmmA5IRbdscV4hsxKPQQccrZr/TPK7CSCHmkWO?=
 =?us-ascii?Q?RGdNqOeqUYqNGZN7boqh1ByLT+32K3aR/oyK4TWEcsk9NY6cmItlm/RUfmlw?=
 =?us-ascii?Q?bmkWDA3y8n7Yn7+ErCd/YJ5NlQ9L57Zfqxz77d4UPWxZgyZa9x0GYcXL8Wcd?=
 =?us-ascii?Q?kuAebcmBG54TU6C3Xg9ugY4okRhK0XXQY36ZjB9M8g6CA9Gt2JX5CMw8s/Fl?=
 =?us-ascii?Q?y14yyVKZvqui5jMzlR73sGssb1SbP1id7k8lF6yHYdCpoNOEg1tV72iUL7LW?=
 =?us-ascii?Q?w+JBRog=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5exM8cSJaX1Yef1d99y4fSr4aqZIb/cFpbZ54RZ5Sp7HEyNAwZC40LAr7Xl8?=
 =?us-ascii?Q?8gpBuPAMA7MblY/lLnpitSk+yp+lkM7O5xK1jbC1jJd7MIlmnuEZZ141m+Gf?=
 =?us-ascii?Q?brxnuDsQer4z7pXNpKPmoNxJ8EVIKPQrkJCK0UX3DQGlXuT8r9d/j9W0wJEB?=
 =?us-ascii?Q?b4m+ehSUgfPkUJp3K9Rs4kvkxrhOQgCa2t7x5DC3PMIRjVoXzk9FGpxiLb+i?=
 =?us-ascii?Q?pm0oICQtX890xjTfoYd0dRZCLEEcN5dqLFnAhvXB8MzmGE2AWQvHUvfdBVcA?=
 =?us-ascii?Q?qvDjfr6VVuNv/BJtEHzu3Dr5lbaySoGKXl0tLciMhL+CJrvsTwxcj06ZPd7G?=
 =?us-ascii?Q?HAe/Hds3draB4H9XLS+sOl2cNNENBj/m+zYq10sOFdPGfkZkX82Ur2ufgod4?=
 =?us-ascii?Q?jXgognuM0aCRycyHL7ofksMQMg35IgmzuGOxotVvsNfqieEUN9Vz9el6GNYg?=
 =?us-ascii?Q?odHLqrghUuO84CIq8Im6eNP6AGt9WwZ9UBjG2zjYhiIl6n2cjPgpXq4TDjlG?=
 =?us-ascii?Q?MhA5BYV8HTU96O+79YgoxiDBG1dURuAGlGNkblwbLmZ6pnt8DYns3/Wzu9dp?=
 =?us-ascii?Q?5ObWeTHyPnjd63KpORj/I0UyyNHbqWq1ka02tJPQfwQ7mYa57+hvBmYWYXQX?=
 =?us-ascii?Q?cex2uxpytsJyZ3Bcqq6q47fh3+WXFaDiKCM9tXT8KlSmT5Z7WlMcFr9t2FE8?=
 =?us-ascii?Q?RgB9RO6KKEp8Kn2fyzmGaH5z9M6EI8dekrWRZUjDm5wVBvqSIdXcHHNfCfp/?=
 =?us-ascii?Q?hdFbuC6wRV7XThnP3EuVmmuwXuW/0nnCMw9lfGmsiwV251tY6h2I52Sormtk?=
 =?us-ascii?Q?qNotaPe3qFuCCVVuSuimAxKDpHQiYX1fMfRRpDJaykPbyd8FvO5TAjFmv6tV?=
 =?us-ascii?Q?kYME9ySafa0pbZMXr+zs7JEWUIL+eDnaJaUn2T74htLoZwh0xOX2x0pWXPYk?=
 =?us-ascii?Q?1M5FaJWzZAnTSBQSH10dhmQhu4frk2LSqDyDAlFUlR2C13908sNczoYB/sYU?=
 =?us-ascii?Q?I+eckP1EcLNbQwsGvV5C3QeiZTjixsjH7A8In04bomA5H59WDeXbMzBIzsnJ?=
 =?us-ascii?Q?tsz4b6TBARfUIhh8p297Jv8JjBmXeIUdshM6FC7y0EfkMps1+A1KlMsw2XQP?=
 =?us-ascii?Q?QU/wvq1rnvDe6V8MvkcrTeD0SjenGwAMa5Lscuc0my7691nftSFvXaUNNq+c?=
 =?us-ascii?Q?1sFxTlMTEymL0ITU9K6/trhrSLlZYLsuheGaQN/e+LR/z9fGjD5LjW0SjF19?=
 =?us-ascii?Q?GzKX2j6yGYUive1ieei8uJv6+mlebl/601EM6KOzP+AMCJ9rv+QIhDSRKVvk?=
 =?us-ascii?Q?8LUGmBnVawWU7wXSoeoE9+CesgkBAedjL9+X6isP4Pjfp+ksqJa0744iXHbs?=
 =?us-ascii?Q?meG68sXp0YP+0xYd1eUBn49bfNwDg4D7LYs5QjdHt0yu7Oh85/wjIcpZHIiM?=
 =?us-ascii?Q?R3tJMdTWXg6BtkeO3yPLg3bM44aMIt4unxso81P6XQfmv6Rj/0Hmm7wm0muH?=
 =?us-ascii?Q?qXRCJtF7VoCYgsORJK05kQb44tftzBjOWuT3/paMF32v9TS3sqkpL591azI0?=
 =?us-ascii?Q?N49qjJaT+N6NYdXVA5Pbl6RlI3oIQimnXMvZ7Itv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b9a624-a376-4a42-c1fa-08dcff495f18
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:29:37.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3rTfeJ35FiZkneSEXM5WU+o2+oTVBdQ8/EQjKx4zYtJ/ZixignmJ/qFkQsSImVbpDNmzR0Dsv9/GDPU6jjrnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9630

On Thu, Nov 07, 2024 at 11:38:14AM +0800, Wei Fang wrote:
> In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
> Tx checksum offload. The transmit checksum offload is implemented through
> the Tx BD. To support Tx checksum offload, software needs to fill some
> auxiliary information in Tx BD, such as IP version, IP header offset and
> size, whether L4 is UDP or TCP, etc.

Add empty line here

> Same as Rx checksum offload, Tx checksum offload capability isn't defined
> in register, so tx_csum bit is added to struct enetc_drvdata to indicate
> whether the device supports Tx checksum offload.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 52 ++++++++++++++++---
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
>  .../net/ethernet/freescale/enetc/enetc_hw.h   | 14 +++--
>  .../freescale/enetc/enetc_pf_common.c         |  3 ++
>  4 files changed, 61 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 3137b6ee62d3..f98d14841838 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -143,6 +143,26 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
>  	return 0;
>  }
>
> +static bool enetc_tx_csum_offload_check(struct sk_buff *skb)
> +{
> +	if (ip_hdr(skb)->version == 4)
> +		return ip_hdr(skb)->protocol == IPPROTO_TCP ||
> +		       ip_hdr(skb)->protocol == IPPROTO_UDP;
> +	else if (ip_hdr(skb)->version == 6)

needn't else

> +		return ipv6_hdr(skb)->nexthdr == NEXTHDR_TCP ||
> +		       ipv6_hdr(skb)->nexthdr == NEXTHDR_UDP;
> +	else

needn't else, I remember some compiler check will report warning.

> +		return false;
> +}
> +
> +static bool enetc_skb_is_tcp(struct sk_buff *skb)
> +{
> +	if (ip_hdr(skb)->version == 4)
> +		return ip_hdr(skb)->protocol == IPPROTO_TCP;
> +	else
> +		return ipv6_hdr(skb)->nexthdr == NEXTHDR_TCP;
> +}
> +
>  static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  {
>  	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
> @@ -160,6 +180,29 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	dma_addr_t dma;
>  	u8 flags = 0;
>
> +	enetc_clear_tx_bd(&temp_bd);
> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		/* Can not support TSD and checksum offload at the same time */
> +		if (priv->active_offloads & ENETC_F_TXCSUM &&
> +		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
> +			bool is_ipv6 = ip_hdr(skb)->version == 6;
> +			bool is_tcp = enetc_skb_is_tcp(skb);
> +
> +			temp_bd.l3_start = skb_network_offset(skb);
> +			temp_bd.ipcs = is_ipv6 ? 0 : 1;
> +			temp_bd.l3_hdr_size = skb_network_header_len(skb) / 4;
> +			temp_bd.l3t = is_ipv6 ? 1 : 0;
> +			temp_bd.l4t = is_tcp ? ENETC_TXBD_L4T_TCP : ENETC_TXBD_L4T_UDP;
> +			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
> +		} else {
> +			if (skb_checksum_help(skb)) {
> +				dev_err(tx_ring->dev, "skb_checksum_help() error\n");
> +
> +				return 0;
> +			}
> +		}
> +	}
> +
>  	i = tx_ring->next_to_use;
>  	txbd = ENETC_TXBD(*tx_ring, i);
>  	prefetchw(txbd);
> @@ -170,7 +213,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>
>  	temp_bd.addr = cpu_to_le64(dma);
>  	temp_bd.buf_len = cpu_to_le16(len);
> -	temp_bd.lstatus = 0;

not sure why remove clean lstatus here.

Frank
>
>  	tx_swbd = &tx_ring->tx_swbd[i];
>  	tx_swbd->dma = dma;
> @@ -591,7 +633,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>  	struct enetc_bdr *tx_ring;
> -	int count, err;
> +	int count;
>
>  	/* Queue one-step Sync packet if already locked */
>  	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> @@ -624,11 +666,6 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  			return NETDEV_TX_BUSY;
>  		}
>
> -		if (skb->ip_summed == CHECKSUM_PARTIAL) {
> -			err = skb_checksum_help(skb);
> -			if (err)
> -				goto drop_packet_err;
> -		}
>  		enetc_lock_mdio();
>  		count = enetc_map_tx_buffs(tx_ring, skb);
>  		enetc_unlock_mdio();
> @@ -3287,6 +3324,7 @@ static const struct enetc_drvdata enetc4_pf_data = {
>  	.sysclk_freq = ENETC_CLK_333M,
>  	.pmac_offset = ENETC4_PMAC_OFFSET,
>  	.rx_csum = 1,
> +	.tx_csum = 1,
>  	.eth_ops = &enetc4_pf_ethtool_ops,
>  };
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 5b65f79e05be..ee11ff97e9ed 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -235,6 +235,7 @@ enum enetc_errata {
>  struct enetc_drvdata {
>  	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
>  	u8 rx_csum:1;
> +	u8 tx_csum:1;
>  	u64 sysclk_freq;
>  	const struct ethtool_ops *eth_ops;
>  };
> @@ -343,6 +344,7 @@ enum enetc_active_offloads {
>  	ENETC_F_QCI			= BIT(10),
>  	ENETC_F_QBU			= BIT(11),
>  	ENETC_F_RXCSUM			= BIT(12),
> +	ENETC_F_TXCSUM			= BIT(13),
>  };
>
>  enum enetc_flags_bit {
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 4b8fd1879005..590b1412fadf 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -558,7 +558,12 @@ union enetc_tx_bd {
>  		__le16 frm_len;
>  		union {
>  			struct {
> -				u8 reserved[3];
> +				u8 l3_start:7;
> +				u8 ipcs:1;
> +				u8 l3_hdr_size:7;
> +				u8 l3t:1;
> +				u8 resv:5;
> +				u8 l4t:3;
>  				u8 flags;
>  			}; /* default layout */
>  			__le32 txstart;
> @@ -582,10 +587,10 @@ union enetc_tx_bd {
>  };
>
>  enum enetc_txbd_flags {
> -	ENETC_TXBD_FLAGS_RES0 = BIT(0), /* reserved */
> +	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
>  	ENETC_TXBD_FLAGS_TSE = BIT(1),
>  	ENETC_TXBD_FLAGS_W = BIT(2),
> -	ENETC_TXBD_FLAGS_RES3 = BIT(3), /* reserved */
> +	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
>  	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
>  	ENETC_TXBD_FLAGS_EX = BIT(6),
>  	ENETC_TXBD_FLAGS_F = BIT(7)
> @@ -594,6 +599,9 @@ enum enetc_txbd_flags {
>  #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
>  #define ENETC_TXBD_FLAGS_OFFSET 24
>
> +#define ENETC_TXBD_L4T_UDP	BIT(0)
> +#define ENETC_TXBD_L4T_TCP	BIT(1)
> +
>  static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
>  {
>  	u32 temp;
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index 91e79582a541..3a8a5b6d8c26 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -122,6 +122,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	if (si->drvdata->rx_csum)
>  		priv->active_offloads |= ENETC_F_RXCSUM;
>
> +	if (si->drvdata->tx_csum)
> +		priv->active_offloads |= ENETC_F_TXCSUM;
> +
>  	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
>  	if (!is_enetc_rev1(si)) {
>  		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
> --
> 2.34.1
>

