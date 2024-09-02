Return-Path: <netdev+bounces-124214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8F1968972
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE8B1F22874
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F186221018A;
	Mon,  2 Sep 2024 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qi/to5S3"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D883919C57E;
	Mon,  2 Sep 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286080; cv=fail; b=aGKV/DhT42cA1vPeJp58AUnayOgzZbXspawyW+JD8CUko+G7NfKX71H1+PAUi7XDcTsGFGd0DIgxrGIN61+CgVddVK/8BjgYk5rdqAxlFoGTaxeDGZsh26+EX8yx4NcihyWrG+JnMXuYxEIQ0hlqF5sNJzrEz+3nN+mT68DXZoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286080; c=relaxed/simple;
	bh=TagrDQktELMan44WZUcuPcTYECJW9XitiPMOsbzvjJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cqSGTxFEyyYR0ISKfJX+pODUDRbQ+F6UTFzAsJPnSRUWg5JTEm4NpRXuv2sDlmTU2Ew+0WpFAf6EgzK+GpVRaIml+2rlBc6nzb1aX5lM27AetXDl7P8s+XVfQsmvEn6AOi4WvQWWJt5fod2l9833NfLYN6/Lmao1XgE04B6vFBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qi/to5S3; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPzrzZjfLs7KQyH+Mq4fHWEagImi25k2J0agM7rkFkR/N0cO8vkcVBLuKi9pxobeVAK1Vsx+k/yz1ofG5N2Pi93CRVFj6RjkaRjqG1o7N2CgNlfIn2Nu9rAH2eJIWmKX1OjTeSgSlIvp1kjOBluGJ5ecvivIstfX8JbA9++r+U0qYheH+woTsAf++O/knKqDWFNEznRDeZA+cdFJdX5Yqw2VfxRwjbrRREvAHNf7PTH3yqVEAOtPnzz3lmm1T6sKy5V8aLQtzOrwFeYwvZxZm9BaPK+QnTbyvqySDQAfHW19+DLedjzdiHhbiR1o91bjhVBO3bmL3nCpU3g96o7hgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9n69yslCEJkb45DLOcZtWBrcFaoeQLU+NP0VrrLNVM=;
 b=HypO/dUo3pq5w/Huq3BP3Xh8wwKMYPm5fSxJrx95V4AYwarIkS/BrypPbBo0QdUhdUCYuMWX9LXPmH8/YT+zzlV5H1u6hzNNnmmH8jjM0qv+dAdIiGB3gUw/CVGa22VeVWhRw0eXwHsYZvFoBulvU3tNAUkR0pa/j679fWZ2AF9Xoa8gzOXh8q50SNlbjAVmTjhK+LaBC/1uUUL6jeJMAVfozDn5l56bndLwscXJEqPkQE1uz26dYSek3uqEPJ66gqBpXMfJMSLeZpuxN88jP+EWJIG2gIqNXxARCtlW/cqb46ypwQNw8gZCpqwMVUe1hdQuJHOjZ16mMFgMpYvElg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9n69yslCEJkb45DLOcZtWBrcFaoeQLU+NP0VrrLNVM=;
 b=Qi/to5S3gXHsj3IV53+Aqfg2t2wtgqpjf9I2qwnFFx0KWiWzBkHpF5DXCyOEy+xQc8e+JlEBrmtG2lT+vZWBgA5xQtyO5NLH++umxBdxhCUff9ljfo1Ae5ZUeWXMqsSiU5YtV6bnWBXSaat+HwWGt3IdEmMI/ZSy7oyFrRq0mbk61gBvs9pK7umFaXb+kgre3oVKwrYkKoTa4G/M/gk1D5XTOw9X87v1O9K9tmHZqrrUGW5MKGakNHtZ0Bh1qMg4ktXQY9emQBDjc3h/LHprNvTUEpKnGkjhtsTJDXkskWFerXh1VgrJzud3k6rQk/a04T3bq3r7OGTw46lqKpnkfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by VI1PR04MB6991.eurprd04.prod.outlook.com (2603:10a6:803:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 14:07:55 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 14:07:55 +0000
Date: Mon, 2 Sep 2024 17:07:52 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Wan Junjie <junjie.wan@inceptio.ai>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dpaa2-switch: fix flooding domain among multiple vlans
Message-ID: <763llokm23gv7anjvwv3y7mvxdnqnxnaeid22yit2mdpqzy3bw@oxep7dlayphk>
References: <20240902015051.11159-1-junjie.wan@inceptio.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902015051.11159-1-junjie.wan@inceptio.ai>
X-ClientProxiedBy: AM9P193CA0020.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::25) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|VI1PR04MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb7acc8-0076-4495-73f6-08dccb58a456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xGXxioWO8vpZ+wUGU1IkpH3O1IGblcukumOKWPPW5PrBXSTiGIC7bXgMR06h?=
 =?us-ascii?Q?/IZFMwp8du7tW6rLo0N67rrAhFGdLZJG0xo4YY0b/Mmrr2OD2kYHwy1LiGcp?=
 =?us-ascii?Q?eqUHp7U3gsy6gn+M+EN+iDV9NaVIcLJqipDKaskXkbOlRkkgG4BF4f/fQ2He?=
 =?us-ascii?Q?wYutAlv1ixIu/q6Re9UDIGOQ/RH/pTxrKHalzSfobcLsHOIQWjJ38PhU8G8G?=
 =?us-ascii?Q?Dpl/2cpJwQwQzycyR/IsHGz5/FLEHmxX4FjE+hbLgENG708O6WDurHsQE7mg?=
 =?us-ascii?Q?IRV317+DIZktYVlRUp9Wvpxi2bCG5/GiJpmeJu+dBCXCewk5asPCuxv5bYSE?=
 =?us-ascii?Q?t38cYktyOd5C1YMcNh8yYtNin4Mo0GMQ29vEVMBnoQrq13WqZVN7y+CjqL5J?=
 =?us-ascii?Q?SAiynYGks7YGniHvWhUyQPxZg8Ihh/UV6wByTzHhsgOLXVGHxOh3nDX8kxb6?=
 =?us-ascii?Q?70C7I+cSeN5v4nERx4vWV902gA+B5lbM8kFeZ0ai2eqPx1kYmrrUstDt1U80?=
 =?us-ascii?Q?4PhHJiWIFMx8whtUj6LSqoA3OwtE/js9iR4RmfCIECC8DptWlQbUggfPXsQd?=
 =?us-ascii?Q?6Z34lSC+LsgLlZrA/p0oT1XOk8tBfu4DoZkYWmoXjsfyr5r+o5ZKrPf8VP9g?=
 =?us-ascii?Q?YGXcbdMrM2Viij4TYr5HuDcCyf0VNiMfiRDVLeR4d9aGC2ryoWd0yTBRdVLC?=
 =?us-ascii?Q?TypSdWYk0MFvo3LEVNlY7h21LFD1HztrEw5irwn2Zbp4Sm9mPLExqiLnYTqS?=
 =?us-ascii?Q?tF1PHjFvJ/R4hFD9ADU/dOR1q+c8RsVJB7LJnMGucWsU2v9yAJx38EbrkN5W?=
 =?us-ascii?Q?7lWmFMiO/f1Mnx1j4hKgkXPX9BrdFT5WqFqSs1EtS7PgFVVRRRADn5NZ+XaO?=
 =?us-ascii?Q?qvKn8/+lfBBh/iliyWo7F1/9aP6GpSnQRjMcI6If8U5T+X3dMh761CQLlN6F?=
 =?us-ascii?Q?S8SvFnR5y107xHtZ32YY4NGcqkRyT61FL88toqjxMboESe1zVUuoq/1X6mUE?=
 =?us-ascii?Q?5XVu8ygAWjcDEOBrvIN0O5f84nh7hG0j1fZ6cQMEKylTqUZpC4HKK3Pxi62h?=
 =?us-ascii?Q?PJYmSfAo/DVlm5KFR2LOjPd9Bhp5qA4GSJs8JcKTAo1QdXnrwqoB8APlxHt5?=
 =?us-ascii?Q?rkoQS3BN3y2QNRR0/iiQgykDONNhmyx3G3LazfvaRf1ms74ga+SPCr/S1bPP?=
 =?us-ascii?Q?aRRhlf7RkuBcdHJIAmH2AcIBfJuTmJnEw7sDC8aPUVOPWYFFqFw40eFd3dNT?=
 =?us-ascii?Q?wUyAdn8NzBYu1wk7oHYlFD2LEHDvIwoc6ZP6vAlZmSkO+uK1LGpduCRseSwh?=
 =?us-ascii?Q?6sv1P/wXdXJWh2b5zM+jbnlUCF8VtxDojtjuKXmX3XsDrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+PD1dx6iM7QFdJkFUd2nqhsy6tjX+bzBahk16+F/IY/VI+n4amd70MeCM5FN?=
 =?us-ascii?Q?W65kiJJ07aKuU8Tj4c+0zDgTS7Z+eOEkH1Af1fXEHNEm4zoR26c5sM28xh7I?=
 =?us-ascii?Q?FZlDRxKfpShoFpMNhUGdutOLhY68h17atvYfitDCeW15AhxLajkrm1DKOS0B?=
 =?us-ascii?Q?DhY6/vJplX+LVUOZ+QjNSRPoVulqk3eDl68MH5Xte50MRvPET5K2xzcAWQch?=
 =?us-ascii?Q?+56jhT7vQMr+XXH/vBv5VV/pKBB5EPubNDwSxTedszyQq6JsF47QKmEE5hlT?=
 =?us-ascii?Q?SbU32WTgS1vK8MpyK7Pj4UqvHBApDw0PbYq7nn1SR3zfxptG90Kq4r8zpFvf?=
 =?us-ascii?Q?IVjvYR2lGeFc6/wy6lx4/c2S0iLeoytnJZvmGsB7lzN/x6/b6sbA3sFho7of?=
 =?us-ascii?Q?fa95vd5YAUzlZNuiw57LlSaZ3xHs9FSKM5si+r8S90W6bNENLLnbvns5xw09?=
 =?us-ascii?Q?ybiKoqvrW0OfyKG9CiQNYc0k2PcIWFoVo3zZnT1NDDIpXFRKrtxaeo9FCcYt?=
 =?us-ascii?Q?Ofu/Kd+GwtXWfYnl4x/2It4lYCzVYKJURMXiSBhQmXK4ikhJC25rZ0kqpK9F?=
 =?us-ascii?Q?1FhkUYmggpkvF/CgPS1PQ3FFdvmCu24AkiMOiwP3X7ITcNd1QbcqZNAF8QVw?=
 =?us-ascii?Q?EKLEkYjx1aS8MqffbfAyNK2m9GcGVGn4q+GCJA6oE8910QDPAX8FTbf1j9VA?=
 =?us-ascii?Q?nriYTNnQjh6A8NMwzxUCgPDK3Zi7xMziYk00eiqnz7LMaK9M7yWpnkIopONL?=
 =?us-ascii?Q?VQa2la3YCLBg/hczJ0mTJon53iL6AUkhG5JQ0n1fkcyBQBpcV8zJpv3n5sKM?=
 =?us-ascii?Q?9vtH6UEj7hQg+sury71/JobcRN2+dTlPAcX2qytJWnE9hkb00UdzNZAz14M2?=
 =?us-ascii?Q?P4j75kj7LcBrJFtnVwRml/Khk1e6plo83DKjJGg2UsD79Ok7eUXngfNZOQ4V?=
 =?us-ascii?Q?846GMWQRNSv2fCmrzvJABPDpFfQzrbk9SWYGDQ8iG1dJxsj7zrq1+vIrhf2r?=
 =?us-ascii?Q?rE8kLoCDAId1/laij1mrmej93I3F7pnAiyAjeqZz1pbDNzpX1uNGr0D8BwQO?=
 =?us-ascii?Q?5F6bSH+ZyV6nrLyze7CBoitWQKmyXd5gQHi4B7tdsbk/mxjvZ6WcQ3Bhorgm?=
 =?us-ascii?Q?UoEbkqmyzxvLyLqylmfqbTdqdA4blynatk4UOFiKGohtPlJWxGKZqB00Ry06?=
 =?us-ascii?Q?CFRXTyuyFSpVIhsgRlGmKkk98s5uXmpZt8SajiWo6xaBhwDlapQoCFxLHTAT?=
 =?us-ascii?Q?Y+inNuc8UAz8uIF01g2FS1ljrxuq7tA6s/VT5reyEs+ok7VdQJVYouUucs3G?=
 =?us-ascii?Q?2sdzMu/LSjwnfA8BivxcabciCDPkaZq0AUMak4oUvs3zfztCYGtkSNzKaCQ1?=
 =?us-ascii?Q?OcanJkzkEoHIjgokwYNBodpSxgAWD27V57L//k+14Rfz3u0ofiIzqS35j0iL?=
 =?us-ascii?Q?MqDwnD6N8JHPWwASpWpXfohIbOvZevKE0SsenObbAT2Q+LJkiM7CPrPvKUYg?=
 =?us-ascii?Q?twCuW99M6jqabtBck8LnamFdRXH3f0PnlXeAPeRJIKqnZ0EJRIFzn0153mUW?=
 =?us-ascii?Q?AALdreMglo6Q1fPOEk1rEUFjKsp/u5XhKiWgVNOZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb7acc8-0076-4495-73f6-08dccb58a456
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 14:07:55.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA4KIAy1waMZms5SYaXs67/58Nqn8MEhPFsPDi0AvVBy7F3pnyDZS8w9GeFcckcXOlEeRAuVcnJEzPzmDiEhUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6991

On Mon, Sep 02, 2024 at 09:50:51AM +0800, Wan Junjie wrote:
> Currently, dpaa2 switch only cares dst mac and egress interface
> in FDB. And all ports with different vlans share the same FDB.
> 
> This will make things messed up when one device connected to
> dpaa2 switch via two interfaces. Ports get two different vlans
> assigned. These two ports will race for a same dst mac entry
> since multiple vlans share one FDB.
> 
> FDB below may not show up at the same time.
> 02:00:77:88:99:aa dev swp0 self
> 02:00:77:88:99:aa dev swp1 self
> But in fact, for rules on the bridge, they should be:
> 02:00:77:88:99:aa dev swp0 vlan 10 master br0
> 02:00:77:88:99:aa dev swp1 vlan 20 master br0
> 
> This patch address this by borrowing unused form ports' FDB
> when ports join bridge. And append offload flag to hardware
> offloaded rules so we can tell them from those on bridges.
> 

Hi,

Thanks a lot for looking into adding support for this.

Could you please allow me one more day (I just got back from vacation)
before you send a v3 so that I can have a look and maybe test your
patch?

Thanks,
Ioana

