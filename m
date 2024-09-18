Return-Path: <netdev+bounces-128835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E113197BDF5
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 16:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D591F214C1
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B019CC34;
	Wed, 18 Sep 2024 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BN7C7Gqr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F1B19B3DD
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726669559; cv=fail; b=Vfousuh35qcn+ueHbpoEdlEIUPmSnWq7KIqDqh7NxW1S3g6pnNSLEaq3XV97ng52ce33Er0Z3z4NBckPI2efNh9K1+pGw7wKbwvfo2LJWjYVKBBXl9pMciLccFXWtzcKSyXbOGgqcqWKZGOj9dossUqVFwJ9WMb5VY6kwRpm/Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726669559; c=relaxed/simple;
	bh=Lhnto6TlP4+SMKLiuLsQE5ZDWAsIuJt8bhHNVWd15Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JFFsCvegxYTO6h6DxB/MqLQwKFHNu4s6LZ8DPyhlfV2CbZAgslPu76MpMyGENRphPMq4cyAtNojWVRYcQPppqaLY+9tmt+w42mhJ/uVarJC4ThoiBSErGbuUSSekQoKTNEnxuYmSBokZ8SsRz8Ob4d2zX9ZO+HJtclpXkSe4g3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BN7C7Gqr; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUfTztpHzbFbWVCIikhu2lKpBoGA0DMB66zl5Cvc7gsGXnrYFFngRneLbUUrkBjH3PhQzM3jYPqOyxrbcJetocbeG+lCUc3CfMOpAXTkxbPGvVceQ4SflB354XU2G6dY0oFdsw7oyC/ZKuni8gUHtKyPYWJ/VQ3xSK5T/vglvSqAqQ1t2s0MXvJTZYo1DCk3RBaXlxe//Nkm9frADm4tW/g72RHzCHL02LvQ52t9Qg7KqlSE6Rc4f1ig8fR/u5mCfGr6Kus1T8C0URWAJhgaFLqjlsx6vAI4dkYLoVw/av3Rg/dIWUvDQbRcQS10e4YiHGEqr1FRRSFQhdFg93V4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FL7cgH2uy9F33UGq+tTlv2e9SZ2vrZQNcFse6Nkp8I=;
 b=Eyg1R7jHTB3ixLGBoDDVCJDZEAm1Otzvkw+08+n42HHl0aual1CwgTBFWfn2XI3RONHQIOw4Y8h62mIyLs+F5zc4qAL2ZwTq7FFduvU20HBqSyxPNtQCDtjr4bIVcWqvMsahOPvRw3lKshQ/pfHXtiueBAL00XqQGUFTy1LAEbbhvRvlyh/NxkNsGojpGMVmdXWYVAgrr2Tq7ITRyO55cut4DTql3hv82q8eHKC9TXJfuRlOxj+hDgBW9ZuIjR79CMrgSKYTLtc0tfeWmLuvbaUfhX3pAw3x1XoDEpwr54B2sWPU3IMc6vK2f4jHDZIDTwKnXib+7KVIQLxmq3ZdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FL7cgH2uy9F33UGq+tTlv2e9SZ2vrZQNcFse6Nkp8I=;
 b=BN7C7GqrVrLLo3vjsxe85LLyfn/jT+37RRiK1GWrO23IKgmZYa6TKy83p3vtIYGfEWbLLgLvPqqyvl/vmh8LwD41fJUkSbkEJJGVnT9iUxM2ENOuFBDTywh3ZEwNbMzPWh2EsxFKeUgGVBN5qOe9X4ae0ODqVaeyQMNrnOhq6mZNsuVW81GkmBoPH67qe32P6k4+5NkrnQFhGpjKNhwJHDVXvZTDu63jS5HIQTF1rBqbauE7Q0+MQ2kqKbmFuEMpbt3WMNB8US/EfOZBmtZDi4aAqWKc3HLpBxtP0vdQnJ6E85QlzbTs+YNyF1zxs4L/YPvSsKTvQgem4yPufZ2bLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM0PR04MB7172.eurprd04.prod.outlook.com (2603:10a6:208:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 14:25:53 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 14:25:53 +0000
Date: Wed, 18 Sep 2024 17:25:51 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Saravana Kannan <saravanak@google.com>, netdev@vger.kernel.org
Subject: Re: Component API not right for DSA?
Message-ID: <20240918142551.nelssrithsyqgg6p@skbuf>
References: <20240918111008.uzvzkcjg7wfj5foa@skbuf>
 <ZurZ8sj4N9b0yUtx@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZurZ8sj4N9b0yUtx@shell.armlinux.org.uk>
X-ClientProxiedBy: BE1P281CA0336.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM0PR04MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ea8a11-1e77-4c48-e2e2-08dcd7edcd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vw+AUc1+LJUW0VnV6gvh55K3b+yZ3lUdbaH4ncF/am/53CLG9uStIdDXn8MI?=
 =?us-ascii?Q?JDENRohy/2B0sPICgRnFTltQbiEkk4Du7OE04gZGA9jnNhGS0HVWEBkojcFZ?=
 =?us-ascii?Q?ytzvjHuE0Kq3TTiFKhLxBz9/oJV3FGet0xi/e12gQGD6j0PbKCKztIBRvXNz?=
 =?us-ascii?Q?hwK7A81j3fwLq0SHIQxSvxLOcrDl46xNs9JEs0Jdmhj1ilqHpKG4hS1DdMCh?=
 =?us-ascii?Q?kszmcxJEJW9VQp8wQV+1y8a0hCu3IwQm1S02EF+vzdEMl8XANAnV524DNfX/?=
 =?us-ascii?Q?scpLH8cripvr3ccRKb1xjX4f2XF4VjAmxk0H/yZgBF35ntZYvKp3lGMq5C/t?=
 =?us-ascii?Q?VDlRJHKj4qLIbFekpmjxIrx0Ly15kxr2vf67NwcUfsCQVhpRFn01SQs7sLYW?=
 =?us-ascii?Q?DR+HOQTvMS6YQCUiPiYZFk48xmbrAs+6htzVwiJnMbw9CVFLbTw0MEDd/F9B?=
 =?us-ascii?Q?9NAP8N/uuoG53e97fg2UwuYOCAHZyQcdXUUhBqB+nKpA7CBFwq0b2gRtad/G?=
 =?us-ascii?Q?/2EeEmdRP9FGkGrxt/BeTyC7Td7wIXC1WUCAZ6hQjfhhqTzmQi3mfNvvJ74T?=
 =?us-ascii?Q?Hh+QgRiD2urJHuXMjkXCUKYp5lmw6HkcwJMzpGvNn6OBBDHMgnwifxmiWu9z?=
 =?us-ascii?Q?2iD3RyeNStXjOuCBoV7pvUMXp7oT7T++cjKE3hVMh+DfMt3Ay3gNtu/SAora?=
 =?us-ascii?Q?dYVrL1pMi6YySD+COoknCr4bSPMPXXTRIkr8rntob+XCf5aHdnNheANXObq/?=
 =?us-ascii?Q?nnkNn+rWZLE4QaIOx4ZnAwzvjcn22EJN/hL2NjbxXpqiOVfYvTaGt4RMH/0H?=
 =?us-ascii?Q?oDaQv0QpXcyYQa+g1dg3t9706a7JBKNQOmsGer/9nb5z806b89LwybGXz2Hl?=
 =?us-ascii?Q?raIn1R6FoEH7IYSQTBO6myHTv0toq/K/IJxFJxa6IV6I8HQjv9OjuhIJT+cT?=
 =?us-ascii?Q?8GFwf+ZJkvL2gvxcjb/fYUXsPzptEkOxWDWC1dDY8WowrA1MN2NjsE/kjd0y?=
 =?us-ascii?Q?UsNn1oO31dAWBgQkbHvR7Z0ZeVaRgcIRXYCOfd8WYQVa97QRCWHpBE/rLiGa?=
 =?us-ascii?Q?11xDGu3+/NEPch3vhK4R4h1qdXv/5BJPRm5+BJj4C8VP2dkX3zQdjRFIisJh?=
 =?us-ascii?Q?YIF2zFgfqBQVKm9NyVdCF9Un08EpUKxtsuJo81GRLAlL0LNKS31r+mRwGbHJ?=
 =?us-ascii?Q?hKu9pMHLlaFd0Yipmvc6d3tPuDaqkzxvuq0OjV7avNOgM1moNdDdmuyQn5is?=
 =?us-ascii?Q?gprg4wUw80Ex6Lt2BBCdiOaXZHRTe+KFI2nOfEaqCI7L9fLu6eoov/WK7srn?=
 =?us-ascii?Q?En95iGY/khU6McT3fUJPPtUXFWFtB3XVZ6ddinTih942iQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9uiebMzRu28qgwTznneeOFI064XDuaJUL2flSFk+lBngEaiQ9FgjG3Y4821A?=
 =?us-ascii?Q?R1b8y+bQvjbOTwiddEOWIPCkK4KxGyCgtOKZAUd9PjgR4fqfXApO8INaoBRJ?=
 =?us-ascii?Q?FTgbBa6SDX/vTBxBHeQdHbLvHUR1cSlmEpxs4fx+ZE+kE/FqYKAB5g2N2JRo?=
 =?us-ascii?Q?Hj949Qqkz7speYyHFOY6cIlRJr2VNyLlJoF1tA+ND/dJ6Pd7SlT0E/SdOz/F?=
 =?us-ascii?Q?Wmm/PQh0kMIkVfGryfuymZpgh2uQujY9OlJc5Rn6i9bK2O2QKJbEQXIsEMzv?=
 =?us-ascii?Q?M7TTna5gS+y0PfCxPjG4hQLyU8s0HzRU8ji0qSGZNFW30k1Hlh1a2RiVYnA/?=
 =?us-ascii?Q?SSFJ1ehoOkUxVXxIRh3RHONrjhRYqF40Q1284ZRMGhvQ4sttIDXCoD9xhkAq?=
 =?us-ascii?Q?J9LUagkR4GY+wwYlR2lJCItCDgmp3vrZuVfOJ45jSZzcGohc9/Kr5yEwwz4M?=
 =?us-ascii?Q?QQSLaz6bp2frxQkdh4x+SX3aTufePaC5O1hz+2gBbqKRIgrvGk0Yi8TM2c08?=
 =?us-ascii?Q?pEceZyjshnD5wGrGf8b+JhtYi/HX3UQ9s8FMVq5SAuxmuWXtvFR2HpVJoxZn?=
 =?us-ascii?Q?9FCpk+eevbbN1uIQqVe/23qMhV+f5xu0l+wIJfykZRr+bwz7CtrbamhMC/1e?=
 =?us-ascii?Q?P/IYQR3A+2ajzzQ8iqIaHP6cNObGL96ZXbx+Kw6Ip/l9mTbPR9IgOBmxwYIi?=
 =?us-ascii?Q?bcaTTBAMZoYCwBcN8eTnv2Wp7zr8cUG+GC9vghtL/Ab6GkB1PV58z4PL8VXb?=
 =?us-ascii?Q?Eousr0aOMQVj8bYGuPvhb6GgD+jKQSRw9IjO/il8g4gF7kIl9pV3jtdRhMx8?=
 =?us-ascii?Q?8G6FgCUQs1n20Ln04SGsUhmz3FNDsA1FMA8tU8DNvBK4P1XhgO2i2DddPI4J?=
 =?us-ascii?Q?nQnXxZX9LzCO5HL6M9G7xhCUEsp2A7v6hmiVIQUQu0Jjzzhl2Nf+dgoflj7J?=
 =?us-ascii?Q?w2rCtrQwik/AO32E4ZBRVJPAyJxUAGX5ooIi28Ei4pADlzEUDMy5V1yXEr5u?=
 =?us-ascii?Q?2ykt7T5NeoA9GSH2ZCmTv8s5BmzfD6Qw5YOLP2JbopmOwp0G9DhIBeNQNCoR?=
 =?us-ascii?Q?CEMPbjzgL4wPW75iJq2Yz3rUIruBECK04RAWQdflI6tQH3L7sU+YFv53Yyq6?=
 =?us-ascii?Q?71XEaW7v7RT43z+/6YVNbbBU9JhNkhHwymt5zdXdyuroufmBhlR427Z2uUlB?=
 =?us-ascii?Q?Tvl1+CYfq/wGDh7K+VjiHu//aUZXFYqJYQk63Xcn6NylF1XnI3q0AhG6eKhw?=
 =?us-ascii?Q?xgANspYrNGPJF0wIKNMzkQ2RTi2NUsduwYgK55CDKDw9HjIvbb4iefTZLtvo?=
 =?us-ascii?Q?wvvE/npumh8ZU2lgqsSUagyWKpYR9gSG7Iw5etChd3AjNuukz7dhqpnEVXbw?=
 =?us-ascii?Q?/evp5SMXxN9nJbM1owAHtHTWD/bAWeZcpULLbHzt+Uy/0SGA/HDcgjIweMxx?=
 =?us-ascii?Q?qj7hFGTKJbstnIfouj1xBhLuNwpZNqoyTF7DrdJ28oZ5JWOhRH2MLkt1JKCA?=
 =?us-ascii?Q?ZkttWgrUozfBznbfj6akBrLr8pu56IwZinQ+sBoG3GF7sjR3Q9AICA31vXHV?=
 =?us-ascii?Q?bV9ausoHVeTdDnyfeBdCvKsIrl+iTuOHdRj0eLlRsOYISpSNQ0uxcK+ucA0P?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ea8a11-1e77-4c48-e2e2-08dcd7edcd93
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 14:25:53.7647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJoCKy2WE+OhSveq0Z7T2bQCJdSO9cHXcnHPhIhYUedJtOutLfpTNYkcIJ3+2J8TflkLliK2V4iCkdsrEwsyrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7172

On Wed, Sep 18, 2024 at 02:47:30PM +0100, Russell King (Oracle) wrote:
> On Wed, Sep 18, 2024 at 02:10:08PM +0300, Vladimir Oltean wrote:
> > This is all great, but then I realized that, for addressing issue #2,
> > it is no better than what we currently have. Namely, by default the tree
> > looks like this:
> > 
> ...
> > 
> > but after this operation:
> > 
> > $ echo d0032004.mdio-mii:11 > /sys/bus/mdio_bus/devices/d0032004.mdio-mii\:11/driver/unbind
> > $ cat /sys/kernel/debug/device_component/dsa_tree.0.auto
> > aggregate_device name                                  status
> > -------------------------------------------------------------
> > dsa_tree.0.auto                                     not bound
> > 
> > device name                                            status
> > -------------------------------------------------------------
> > (unknown)                                      not registered
> > d0032004.mdio-mii:10                                not bound
> > d0032004.mdio-mii:12                                not bound
> > 
> > the tree (component master) is unbound, its unbind() method calls
> > component_unbind_all(), and this also unbinds the other switches.
> 
> Correct. As author of the component helper... The component helper was
> designed for an overall device that is made up of multiple component
> devices that are themselves drivers, and _all_ need to be present in
> order for the overall device to be functional. It is not intended to
> address cases where an overall device has optional components.
> 
> The helper was originally written to address that problem for the
> Freescale i.MX IPU, which had been sitting in staging for considerable
> time, and was blocked from being moved out because of issues with this
> that weren't solvable at the time (we didn't have device links back
> then, which probably could've been used instead.)

Thanks for confirming. Although I could use the component helper in DSA
as it is now, it would ossify a limitation which I would like to remove.
The logic I would need is "aggregate device is bound as long as one
component is added, and gets notified of the addition/removal of all
other components". I guess it would be better suited to open-code this
logic in DSA.

As for the actual device_component debugfs folder that the component API
creates by default, I like the introspection into the switch tree state
that it offers when applied to DSA (it is useful especially if some
switches will go missing). Maybe I will keep the idea of having a
platform_device per dsa_switch_tree, and also create a debugfs with
similar information for it. If I also open-code this, I could also look
into adding a column with the last error code returned by each switch's
setup() function (I've lost count of how many times I had to debug
cross-chip probe issues). I will have to see.

