Return-Path: <netdev+bounces-250554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0977ED32C96
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B365300FF8B
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232B38F225;
	Fri, 16 Jan 2026 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vs03HuqU"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3EE3375A6
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574281; cv=fail; b=cmOvCZGlpID3CKA4WvJ95MEhvu5pCGBCSWIleWcepedqMCbWlEa4ApAVxb6U61tDAoTlwDBEyASUpfFIY2XCAUFulGuH17AqxD8gMtHRL+Noj5yqnqYSVmFke/OUWJzdfwZGptaONMDNyMiUJKgeXFLA3GucBJWAuWa5vFmv+go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574281; c=relaxed/simple;
	bh=6Hm7Zst2KzhkjM72UEz1Hg45ETvLsTldWLpj68ocaMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OfbYSE7xHczWMm6Ohkxg1FVyfcoc9rlRg4VOC/LNLGJTFahCLogLV9U9s/an31CFotcs9BomCdrpHUOZsL4JGpoQnvw1JKrGQxv7IoeVopjttiYND84Su4rTn2Uu5+E4fN/kBpB1JjUBZbvV0Ex9CVSfURwRvMhA1CXAhnTgFxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vs03HuqU; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPucBRk+9opYreDqWv22Ls8xV2QmXHd86ybqpj1GTNL3NJel429NH2rcFK8NlvnnFsq0Z1pHlItaKrXoxMUOYwlqtiwYTR5uFWgrC4VmoTR0qBypRLeitbdqtcIMVwqQTg/tzCF394YZp7IdihRFZ8JKutueYrvm+PD++hpYmOKY/x2lDfCDsOJpJUo2zpIINqnYLNkiSwEEG04cJy2nuMwMDW4AwiXVSzs9/GZ1193XzMEMNk7kAtezmzt9ucbpmU5XjfOYWNl5AlxBe0WvxsNkwI2FWwCxi7Pm8Y5c/fRyFbZ0SYK0FXZfQrtEy0G0Zxpom09c0DquMqfQvl0K1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWsncymzh+5aLp5blBNO6YoESE+DBMgsdhcu+NUySoQ=;
 b=qjUTdBB4950dlEOYYq7uYNJ+IWsinLBe7oz/LLrYSl1nXpjxsvu/dYSkEqvRNvecpAnJ59TQGBOdJhoFvzs8r2+vOWb2Ri3ChJCv1t0J7jiycL6PKcXjhZsivnx9MYi/t9Cwm5oJyB7SzovHM/s75N6TaxG/+HayXArq+XH2mRht5RzWOqeTkRPdgEMEXE/A7NcY3nOObgMzUGnXsfyz/c0IA7rfGOpamM+3l2uEN++5Mr2PE9wPJy7CdPyOiKBhdjAV3adpdlm4fRcPi8JvZ5Oy/LnQ0/tU1nGl0Sr+DqIKpAlCIyCi1mIjVRXHs9YL8bstQzYmDR7kZGxavnaTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWsncymzh+5aLp5blBNO6YoESE+DBMgsdhcu+NUySoQ=;
 b=Vs03HuqUk+uoOJZ/zG7SQY2teWoUPCiQQxdzrOmWsv1wMAAU5Pz10L3Zj0VXriNavqIccp4uwwc8EHDK5ZB3rLnTXClOad5FTk5Pipx0ysuslaQfhhgMwJT5SGkWHCEbip0v76kHn+gr4niQl9HINLHktPNFO/e944a2GEHjvSm6/RLkEsi/tkEYv2E4CU324HbMHv65BNzOy9D6JTTykzXQhgoaDLNwM7In8XdmEcJ026CwAhPO1KFFub/B7V2ceR02Amx4fK89x/9KsaBZNqX4oE94h0tvnEpp/Ji3iAMD1XOUpgVIPa097qAebuLMHd/78DoXoSfto29i7qSkXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PR3PR04MB7258.eurprd04.prod.outlook.com (2603:10a6:102:80::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 14:37:57 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 14:37:57 +0000
Date: Fri, 16 Jan 2026 16:37:54 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: xscale: Check for PTP support
 properly
Message-ID: <20260116143754.6xfhqrlhgtsewifd@skbuf>
References: <20260116-ixp4xx-fix-ethernet-v1-1-9ab3b411c77e@kernel.org>
 <20260116-ixp4xx-fix-ethernet-v1-1-9ab3b411c77e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-ixp4xx-fix-ethernet-v1-1-9ab3b411c77e@kernel.org>
 <20260116-ixp4xx-fix-ethernet-v1-1-9ab3b411c77e@kernel.org>
X-ClientProxiedBy: VI1PR07CA0273.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::40) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PR3PR04MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: e3474be7-5863-443c-0611-08de550cd6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CvwhIH6S1HL/y0TMM5z4YDbIuCnDUvYYI2C1/FVZcu6ozKsW0t1sx6ti89OV?=
 =?us-ascii?Q?XYugxMGqN6LAz1GLm+G6ndDW8b7l9tbWRroQ61QHJ12YBmrP2Lbl28Cr+xlE?=
 =?us-ascii?Q?OGrw71+JO/86reVn4WbOi7wCr4TVxNAhXCxsYFGeaw3aGNGhCestLusxEBjD?=
 =?us-ascii?Q?q2sTOfGP4qimSIDOZpeZqkUMMEBExpph2AHQHd+AUVgSsS14H/8q5G47R3BS?=
 =?us-ascii?Q?rz77ikjkwaceRFXz8c02YJyqEsxlBcxa/IAwXaSv7VT61RZ+V0jKvOzlxWmR?=
 =?us-ascii?Q?dtqPJzFfhN8oswdxkJ8Wz28E6E7G7QmwHPeCb6RyLf+63UXSGiezvOmjWdmV?=
 =?us-ascii?Q?5bPJwTwknyh9X8MQtD1lpzTyzpo8PO+0kNsffJ/iP37BLBc7LxtdrQR5iAdI?=
 =?us-ascii?Q?lBvvkp6IWsrkcPHP9J7Hc82+JkMDZKJ0/hp/0W/19Rb4HUYxsJfo0BY7dzL7?=
 =?us-ascii?Q?zKuGWnKzDhfwaO226oWImeKQlSbPM9bk5QmFxxKC3EtvBxjrCJCaabzYE5QW?=
 =?us-ascii?Q?OuAVlLZim47G7FqVGWKN0MVjhBtqYYcr94EzFoPxj+l+wtrmSxIt6Y+uHeih?=
 =?us-ascii?Q?xPQPuwboO217Xde+PsvKjp1l7d6xWtsfYwjxP0u4ioV2mlox2VpF6t/j1qLi?=
 =?us-ascii?Q?6i4hp46P7Jab0ejzz/C9nUG/rIlF/zTwtxBq7Ijv6zuXMERleG2X0XC0jcjl?=
 =?us-ascii?Q?YyVJk1fgoaJoLkFo5gkDdlwx3vmbWGN3+pP1zNZbsx/Pb0CEkbE9WTflf6nc?=
 =?us-ascii?Q?VVsg6yVAaIxJdsq7krDEven2WtudttxfgALAjDbZwxDGvbi65SN9zgTbLf1N?=
 =?us-ascii?Q?QFejqLSOsWtACG+oV6uAD/OXTj5l+RqUNVs+/GqoPzj4KVRabIpiMo6aCWEX?=
 =?us-ascii?Q?N6pVwRzFgW85alvpatLK8wOu5UeHv29Tj0S7JRsCtz+gNYoIeKB4GCfjgWY7?=
 =?us-ascii?Q?9chSutYQdOS2IBrE7jPviJhVAFefJ6nfzr6Nz+4SoptBvt3pXVrdjHMcGjfK?=
 =?us-ascii?Q?wObFcrDwIkiP8j3xNaNzAavNHOlT/FzV32jpFSpBOpD8gzREK3/aLXCOuyUu?=
 =?us-ascii?Q?Vaibos/KJc8lnhqBt9j+MCPfzEbCE6f/kAZYY+wIGSueY0JVTRoE90isH+Sx?=
 =?us-ascii?Q?MsxDDCHhpvfDSOMUxh5/sCjwNB5/C4IPEsME+yyP9ZiLsE7nc8N5gX6LE5+M?=
 =?us-ascii?Q?GIuwTUZuzmuxvFx+/U+qyLvV/PvnBP5kghrOJBb34eahPGMGpIzK8TnkUL0b?=
 =?us-ascii?Q?em2ag6LGezK5psX68VJqWicmVwi0i6Te+h8IFsQZ3Fu7uuxY6ri5E/B4H0ox?=
 =?us-ascii?Q?UAYtysgJMkSoo2HdTIDChUJCPrm5gWUDjYpdIyWuYhiKEXdh5jb59WG8mhJv?=
 =?us-ascii?Q?JBEEjhSz7EwMwuEww6WlZ2lHmjFWRWeOrjuhaw6XYyDp4WrdQzEEdGZS+uc1?=
 =?us-ascii?Q?oQzBcLtyP6P21Lw/UIQkHX22pq6iDDaqTcP6dvJGGQwCdTqmHXvFiUugEXsT?=
 =?us-ascii?Q?o4DqtQCVqoIw6dqrKcyuu77ehtcEImxlF+OxDEOEm9gLj0qbHBRVe5nua4nj?=
 =?us-ascii?Q?bn2XkL6iTYu5yNnaHQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wv7iTgBR0L0TMbjQb+xUI8wQlZeNoWjEYpP2XI1/9k8s5w8zI6cBzTE9fLub?=
 =?us-ascii?Q?TPXPQXnmzqIZbRksGGDTqxwhQS4LZePMlGmWTR6KyHIUvY/sTiyAne6bkPC7?=
 =?us-ascii?Q?ETcEooEoBcNGZiihN0RxFOyDMCqzZ1AdXAXiiOY7hmVGm2yrnZnRI48n/Op5?=
 =?us-ascii?Q?6t0io0x4Guhux5Lt4ZZxxG8qHT7xr+s6NF+cOdr9JXtAhsGeJOGct4kfeUDz?=
 =?us-ascii?Q?cMA+d6LbfZNnBvJ4LJP/JdhHdAZt1a9Bt15v+Qq6HeVXG5IroClr9ipN6t0F?=
 =?us-ascii?Q?a0pXnNhBx8WdQw/Y+1+oGUyljgzhxuG0vgP6rLoSwlRyLIIW2pTTr47WnSOl?=
 =?us-ascii?Q?DA51AHW2BQKllif8VVoxXd4RaHorTJQAFQR6fK3oCeJeZLrgztu1gL9I6T6+?=
 =?us-ascii?Q?MVqCAD7OIcF+6U95o6eyXVCPjp8CAHp3LtpMU43wGwkxHeuUW95SV8IkZahO?=
 =?us-ascii?Q?s19icp4Tkaltd66Z6LxNgt0WGP52QQ1owHdvwUbFXnw8kR2E7gYpmligbxzf?=
 =?us-ascii?Q?w+MR2Zw000R1LnZIEYcI7LDkSrB4eadujwJUIIgaDnHrklnU4SSU7P7Lxrn9?=
 =?us-ascii?Q?y/KBgHa+ovnDvZLaSc4KTx5U0vL1NSot2kFi6wvSyFzcwSVH2ZNMtVqUsjNm?=
 =?us-ascii?Q?I5elx6/sEpV94BQEkYdaoYnpWxIY3dAIjOAPJPOwjeGhgsvYT0aGAXicPb0G?=
 =?us-ascii?Q?+McGKrP7m+wudASp6VyKtFpSszwBIKE3/Fk8Da3ZboCwcfeGr6nPoOjB7Fva?=
 =?us-ascii?Q?gf39cPLvzJ7XshKSTz6Hby74j3Fh7jIPGbFfEOo+Wx4aWTUVTrspulbiqY62?=
 =?us-ascii?Q?xupM6A554w82SVn1b1rXvRWczSoZh1M22apiMx9wWOVGswfYoCTXq/VvgHxI?=
 =?us-ascii?Q?6z3WI2gRLaPFadbNWV9/SRXmMJbyqJEd8pm0HZD36gYOwyVFmm6qzAc4rhq5?=
 =?us-ascii?Q?EmrgDoELi+NsabztKmee4QTZqdvuZFb/6TatBn3435s9lzJPl0LrCbZKVa24?=
 =?us-ascii?Q?Zv3abJ0lb7iHxF3fYoI5WYJfYWdsfB9i4EZWwdB6mYdL/TRrE9N2C2EKsvqZ?=
 =?us-ascii?Q?hwWJsmLCIBXCRCe7B1tueeXZw4TAAtek3AKD2mghF/CqGEu+lfPhN2tnrZzN?=
 =?us-ascii?Q?HJATQY24awR9uv8UeGt+UP+ZTcPG1HEXkgCjjyMI9oQ3IEaxlnebUlfHqsVx?=
 =?us-ascii?Q?yHFTOS1Fy0DOmFq9r92q8qGJA10cG/nh3c2BbR/phEz5sXe5FC592U9YloH7?=
 =?us-ascii?Q?gGYpSBAjAi9TNFBM3DJFrmYzO163CnmaH78QLn0RB7uZzTTYv83wU8zU9aB3?=
 =?us-ascii?Q?vKU7QHjgbmHuVy7xlNNb3JdkIeW1rHpubYx530SGN06Mx7dFw6oa2iLAmc7c?=
 =?us-ascii?Q?jtjlxaT8lEo9sDo5LLJc0qWY73ZB/q47XtAusgEpokhOLzAcUT3zEPgozv3c?=
 =?us-ascii?Q?mGh4HOm786zMZGzeDrXzXoM3raNxHvHBiXJP38drrfZjN6DEbAwE0u+Na5H9?=
 =?us-ascii?Q?JOB87k5+K+Zg3TkXsk3OxdHy/v54kUBLIj8bVU/K2JN83368EfQ/hjxEATD4?=
 =?us-ascii?Q?8QAJIfaYcPHdZkwGv2Id6hpG99hVmtM3D+DC6JfcNGB3yIkGDTy2ww7Xrsgo?=
 =?us-ascii?Q?RryLtqmy1PAGuE9wTJhM7jaxp5X4JIgeGRxuRcgpjmTUPgyTCwEiT7IOmfNr?=
 =?us-ascii?Q?+SPuyk8HRIq8T6qVc0ai1r0vKp+Ec8tzhwCH9RCjAyVAvbSwEiiU/2/afqRG?=
 =?us-ascii?Q?FPgERk5f9bQMVoO8VghN6cl9u8Mnl713uP23bbcUosGfMBR9e05LrsvXIKs0?=
X-MS-Exchange-AntiSpam-MessageData-1: 77zhTLMqliCxETwFD7ds24De3F6WZj5ZruM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3474be7-5863-443c-0611-08de550cd6f8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:37:56.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USSjJtw6AP1QXTwi2bD1lQlWFeCkch7wDhQ8RsEF4wAkNo+yLY8Mwdfxo8uD2tpQRXDfgMGegnzvo1fhMaA79w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7258

On Fri, Jan 16, 2026 at 03:27:29PM +0100, Linus Walleij wrote:
> In ixp4xx_get_ts_info() ixp46x_ptp_find() is called
> unconditionally despite this feature only existing on
> ixp46x, leading to the following splat from tcpdump:
> 
> root@OpenWrt:~# tcpdump -vv -X -i eth0
> (...)
> Unable to handle kernel NULL pointer dereference at virtual address
>   00000238 when read
> (...)
> Call trace:
>  ptp_clock_index from ixp46x_ptp_find+0x1c/0x38
>  ixp46x_ptp_find from ixp4xx_get_ts_info+0x4c/0x64
>  ixp4xx_get_ts_info from __ethtool_get_ts_info+0x90/0x108
>  __ethtool_get_ts_info from __dev_ethtool+0xa00/0x2648
>  __dev_ethtool from dev_ethtool+0x160/0x234
>  dev_ethtool from dev_ioctl+0x2cc/0x460
>  dev_ioctl from sock_ioctl+0x1ec/0x524
>  sock_ioctl from sys_ioctl+0x51c/0xa94
>  sys_ioctl from ret_fast_syscall+0x0/0x44
>  (...)
> Segmentation fault
> 
> Check for ixp46x support before calling PTP.
> 
> Fixes: c14e1ecefd9e ("net: ixp4xx_eth: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()")

I fail to see how this commit affected the ethtool_get_ts_info() code
path, and how the problem wasn't already there.

What do you think about commit 9055a2f59162 ("ixp4xx_eth: make ptp
support a platform driver")? Before it, ixp4xx_get_ts_info() had a
cpu_is_ixp46x() test. Now it lacks it, and it relies on ixp46x_ptp_find()
to not crash when the platform device driver for the PTP clock didn't
probe (something which obviously doesn't happen currently).

> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/ethernet/xscale/ixp4xx_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
> index e1e7f65553e7..fa3a7694087a 100644
> --- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
> +++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
> @@ -1014,7 +1014,7 @@ static int ixp4xx_get_ts_info(struct net_device *dev,
>  {
>  	struct port *port = netdev_priv(dev);
>  
> -	if (port->phc_index < 0)
> +	if (cpu_is_ixp46x() && (port->phc_index < 0))
>  		ixp46x_ptp_find(&port->timesync_regs, &port->phc_index);
>  
>  	info->phc_index = port->phc_index;
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20260116-ixp4xx-fix-ethernet-4fa36d900ccc
> 
> Best regards,
> -- 
> Linus Walleij <linusw@kernel.org>
>

