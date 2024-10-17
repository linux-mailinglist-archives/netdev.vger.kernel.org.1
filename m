Return-Path: <netdev+bounces-136601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4637D9A2473
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87905B20F3B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6841DE3AF;
	Thu, 17 Oct 2024 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H5kNTpYq"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B031DDA14;
	Thu, 17 Oct 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173848; cv=fail; b=hoJbxfYFuKCg0PTPGEeX0WIHEJ2rBEj6AkQ6kNhRmDtR+cv0RvlqAP55Y6fQJ8w3iUK/w3kwc/Q7FnVdlmji+QueKlWn54oOw4u/0LEZlOtznrQkjvyju03vEcQPU54NBWWgFFGAViKluQee/kriKtXKUCxcm2WND/NGotDpi68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173848; c=relaxed/simple;
	bh=6gFPMhqLD4JSV6PAGnMDTJ39Np/1dG9pW0frRU6D+SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c6MhFTYZuTY4KstazpNnon4hrluxPbjWA4xT68DgGBOExkXeR2lyaLhMQi80SA/WikixtYgcNsQmMFqQahoHdXPkROkk+3EmuLqzEiFNv0pSbIy+lghRZweEsMDjT5gGnyiywvMDzoASrC06wbFfdHWTOAz8NTzoOc0Sa6qaiLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H5kNTpYq reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+Hr0loCpU3cOWQ1uQ6mY+hlThgHrCcBmPqstBmFkY8M7eduAqKFiEfy1UdEd/RL3436T99zKJ4ZhsHON9UkcrlvZWPLxipVi9bjayRDyt3rs5lpiR6lQSS8w7xsNrkBbONZ9I4akQk5KNB8f7XaZbP00L6QC5CG81qc9sOfbhiR2Oyu4K0Nt6sgMJkNpaJe0b+1mSxhJRqQ44xj4NZOnWKqVe5Z6GETeLjM4U5RQpJnobvAo5q6oqEpu2zdbip352TqkKpEkkKRW3FPw0iPNEAIY5li728R//l+D7v/dEgtOMDbHB/XpGCkzN17GyWeejoYoa/EOQX0AfdZhISbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WF+s45YtFd6VeKrDmwwsY5DAO70lBOWxMjLLBXHQ/qE=;
 b=LIDpl4SFHJUOq0FHK9/7G7wscnYPqpdn49TPMzgy4YZ9JOUZcbobC22Jz6T0p9g8RNqctgqlU3ML3t3Vds/Dut8kF+HATsXIPFoSiDUMLnMkNZw0iGsNopzbgsudVh6DEdjZF+TR9sY2A4gc+zXJUWxjUMR8Kg/V/CiJKX8ivsrUzsrmfDWAxvk0pV536I8m9yCXQ1IRfytKOEu5E9h9iSdWW6ga3efGQ5/gIdIJm/RPrVuDZmNNd8MNUaW+QI/QcXVw5KmWRfmLprYAcApEPMVm0sRbfBRneDvF1JFbYyc5AhMVbNuZA1TaBPolosPK6z00pvXHcRUmF9P1TVGgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WF+s45YtFd6VeKrDmwwsY5DAO70lBOWxMjLLBXHQ/qE=;
 b=H5kNTpYqAvFD4KubcnoFHrIxrI27WQmxVbloGy5pBJZKaa5bqm16TxS3ec+Z6kRi1rOTnMc7mvkBlGERkf9r4VmlJJWMmHysDB5phbBq92LGXhFCSmEg/vK/1ze+zEzw1qWMDIycDHKRb7xiGwd+8tfh3Q5xpCBfbBY6K8lAb9apVjGqVU5Hwgq1CNrgZiKeF5BMGGf1ROI29ZljfWVDRUVvW9QzrUNsoHxTHgjdTgw+08D7hWHbs6ShmeZaSVTmY1qkLeG1ocRC3nzhOQ/JGi1CMKlW5BLWkbH16rCkhHFHtRVTvPoOS0lgOhvPm89h1xH7qRAiPWS0cogf0Qv9hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10206.eurprd04.prod.outlook.com (2603:10a6:102:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 14:03:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 14:03:59 +0000
Date: Thu, 17 Oct 2024 10:03:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: RE: RE: [PATCH net-next 07/13] net: fec: fec_probe(): update
 quirk: bring IRQs in correct order
Message-ID: <ZxEZR2lmIbX6+xX2@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
 <PAXPR04MB85103D3E433F3FBE5DDFA15C88472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-affable-impartial-rhino-a422ec-mkl@pengutronix.de>
 <PAXPR04MB8510149D0E8AC39E048941F988472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-manipulative-dove-of-renovation-88d00b-mkl@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017-manipulative-dove-of-renovation-88d00b-mkl@pengutronix.de>
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10206:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ace39d-0ce2-414e-8a6d-08dceeb48c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?vEwnkcfKf0+Gvagp16K6+kHFCz7TQeQHZlsGa0EtJCNyPyQmQ2OzyJ5+4W?=
 =?iso-8859-1?Q?zHC84STHvhWmKlw0IR8iO+rp0Z4euNyloUkT7m0JDw88LGITbRoRwz2nSp?=
 =?iso-8859-1?Q?OT+I/lqhHf2Y8RN0QuDknvByu8czTb8dY4Gl0/GAeMMjH8Pla8S+TsF7kC?=
 =?iso-8859-1?Q?r3/XIIiqrod5SRptYo6oW7BgnDrn5Tzh88aj4h+OIMNwypc7ql0c3om/FC?=
 =?iso-8859-1?Q?x76hF83cDKTlrIX4TigMbO1Y67bfiKgQWUr3a40dTEu70MppMDf1rzQact?=
 =?iso-8859-1?Q?5NAPyYXMMo0kgFWiioS2n20CDd+UwZl33y5TaXvFhxtDW2sS83GW09FTHV?=
 =?iso-8859-1?Q?/Kv/vuM4SDG+rxop0WmoviIp8J9AIwWhqHMyu3wD3UZUSsyY04mwhO+7jr?=
 =?iso-8859-1?Q?P/vaWvAIKNNSdrCEB0X5H7UZzrrkgwCgnwQP2hjTQepNGq/kPVYPmFk5JT?=
 =?iso-8859-1?Q?J7e6fHnzdgs2rM5PmrxxU2ZSv2vJvphgGF1ArFQ6SfnYfS5TKhvzLsvs29?=
 =?iso-8859-1?Q?YXdjDiBIko3UkmKyPEP82g1BpiPTIzCkRRf2W3zV1il7WekVRPylKl38wW?=
 =?iso-8859-1?Q?w4s8glwfMlpgkIPPac/SSypi9RuHB2h7uhrvqa2ykgGVBn2D1R9huqL3Z7?=
 =?iso-8859-1?Q?Jn97EcOJWNrgVu7Mgp5SY4zzneu8Hjy0g0Zz8uN67dV56oNi+6wl+b3Q9u?=
 =?iso-8859-1?Q?JoVEilmPXmYtA6CkuUq1V5DSN8Iwpga2qJlYWxws6Ea+iQWyMKG9xoa76y?=
 =?iso-8859-1?Q?QmGkQAKJjUkPu24BC0625Z7KjnDRjA8AJrTeJ3+M5fWgbptHM6vYZgQJUs?=
 =?iso-8859-1?Q?4dPX2rEifweOOyL47tcPdFA4ywY+hs9iMvz3trkMUzuAZdHNd8y8e+yKQg?=
 =?iso-8859-1?Q?zWTAnKpkdqz7rVRwpM5nyXTQC3YE2JGoT2kY/EnvflHaPd2JHQObZbHYj3?=
 =?iso-8859-1?Q?yfgAdbCFK8O5Z028cV05+98kqtGOa1Mw+7CjkNnynRJNfG+PkrmKwnKq34?=
 =?iso-8859-1?Q?1CfFajijnavm+Osyqo6Ji0pfdZmpNhillnCRAf2tXVKrgD2tG9m2vvKcfB?=
 =?iso-8859-1?Q?/cMxZa+BTJu6cACbYcPm9s8OcnpyMNg2FDdyMO/+AxuAwKI7+b7YrE2Jyp?=
 =?iso-8859-1?Q?Z4l+zQ1j/Eu5ovFpK5K3cL0Nt+Yab3AqJOT5Ll/1Lp/Smv1pkXTGi9zRIk?=
 =?iso-8859-1?Q?WkjsopMXHRz373dg8IZX9tq7ScMkwfa61YMkR8wLdiyc8wuHlkqIlhYk2Q?=
 =?iso-8859-1?Q?5ma4V8S/zsVZNMcedBKGZ0oAUBfuqIPWXNCFmfkviiWh/oR+DCTZmCwrVw?=
 =?iso-8859-1?Q?DEBYvoruP+uWT4J/J/el0vIpsMtqCr+U2bDwZ/WpUExIhfs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?twjbO+otuO+0DGloWgDtHnzI1AW0F22qkTAabPlxtq9j3iYCpMiuapmvCN?=
 =?iso-8859-1?Q?TSK7nLAmz6//2vy33LL0mrzPq6bzw0pIDqEbSayXRV6zmbRcym90cHFyi1?=
 =?iso-8859-1?Q?bfSkLw+Lfz3evFrFgPPbayc7k1QflbvU2WXgpqE1AT6SEkDUJ1fdsE1N5P?=
 =?iso-8859-1?Q?iR/QVHdoVKEb+0FktvVkBVF2E1amANU9Jfoc7/ivI0t7xvnZ8/R6ghX46E?=
 =?iso-8859-1?Q?g13P+XtiJKD9G1be9qmXNBpL6r3zqhp5Fig5vbpLF5totQR4SDtrVxz9Fm?=
 =?iso-8859-1?Q?LARoOmdyObV6VApHOtYyomcOOMF0kffEJLlxNnOwLz5QB2oCfdcGXRKwmg?=
 =?iso-8859-1?Q?q7LKOqIMZJMbuG/V9g/NDVAUQqPRtYYAU1kZvKfxjp3t/sQS88g6SFg7Nw?=
 =?iso-8859-1?Q?Pj+ZlygZIIwbSClBJYvlUmmH+CbCJtmJTEA9M7VCdMmtsW8RUlKwvNN6+g?=
 =?iso-8859-1?Q?rlreC2CafM6DKSlMEybifDosSLeO5Edop/y9oOz7wWWFoY5XM/ZhRdUx/z?=
 =?iso-8859-1?Q?/6nt7hzK9AqOif9g1jUFrm3aCOjSywXQvrVpm5lP6CrDHDLAPCOStxqAQC?=
 =?iso-8859-1?Q?w/ptv1Z/03nxNDViLAJT/zZVwVdolr6f38/uYTDfIgjWmY6/wPrw+uV3s/?=
 =?iso-8859-1?Q?Kb0jiMkgxZfoeXtdGtDbbyVtJteTBXEAHxaO/XJsvr7zepz2Ut5WFsFVJ5?=
 =?iso-8859-1?Q?86k9gjn5eCrM/5iH/6Lhpma/D9zNhQt9f7EK847zAI4SyapRnP4apc8LmO?=
 =?iso-8859-1?Q?NA5pmavMSZcafPjy6vFKolhW7vSgF0B3cVF0I8lk/rqNVvwRimL2W1qTSz?=
 =?iso-8859-1?Q?v61f+irTPzV8H7mHrNhrEomen44C7RHReQCZBK9hrqgXaUwFv13cbl3jMN?=
 =?iso-8859-1?Q?zyVpYwck9vhtEahualCddfUhxNXWDr9d3vf89ozNsqIsF3EyEvsOpFgRkU?=
 =?iso-8859-1?Q?ituMQqVqKNpnd6aYKDwSUXlcscxFPgaXh+egsXRNai3hDTEwNE6IDBP5dZ?=
 =?iso-8859-1?Q?ihP1yDGMxEjpZmxZ4Jz3alyUzjF1eeFgPOTYriIlhJIbOYTdSdifMmZ52W?=
 =?iso-8859-1?Q?ck7DgIW6Fl+6yuwQsDFNxuhJZ1TxIUwo0c82YwJAsMF2KfdzG987yARdSa?=
 =?iso-8859-1?Q?1h/YPqOHV/bbyjU2tXekGzDinUe5EihP/ZiDF+o/wQsXYGHVPL5wXsdWBv?=
 =?iso-8859-1?Q?jHJPNYs5YlRiWdT46QQ89w2paw7VWnD4nRuWLAWrIIaowFlkF3K5XFxjHR?=
 =?iso-8859-1?Q?DSp0VycNggMDYPnKbq1cwxHQs4fLuoO5Sgkgw19WJOp+j3KyqjlHafzwQS?=
 =?iso-8859-1?Q?aTXr7zlJzXnvan4KJzvF84b9wqrpD+zWZ83iC23kSnZyNM0gvrTWXRRZPZ?=
 =?iso-8859-1?Q?WomER5Y8XXJ/VTR1G2pQIDYrUndND25yskXPy2hnyUGVAbcgScW/yRm7/4?=
 =?iso-8859-1?Q?WL6FavebYWs7S63AphOWBmdlqJD5ZN4seGWVuVO8IGWYFR27ZK5Zt7P4WI?=
 =?iso-8859-1?Q?CA+ClVsWWSBcn95s1jK4XvKLFH0SXVz1LsvUSuJn38ntTrdhy9waZ0/9+Y?=
 =?iso-8859-1?Q?J9Y7eI5D7Tc8iM1DTOwxDl3DWE/ytIZ+PMT+yJG4DuYifmyL6yl+27BC/I?=
 =?iso-8859-1?Q?BzVC5YpTkXkE0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ace39d-0ce2-414e-8a6d-08dceeb48c2a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:03:59.4911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuUiU/0GsMHrfGao4KT3jbG3zPSYSWau8lBKni3fBrGVg7jBAsCxa09FJyluEjVfO8ciMKbqK+FCcnbOGJhKkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10206

On Thu, Oct 17, 2024 at 12:21:10PM +0200, Marc Kleine-Budde wrote:
> On 17.10.2024 07:43:55, Wei Fang wrote:
> > > > > Subject: [PATCH net-next 07/13] net: fec: fec_probe(): update quirk: bring
> > > IRQs
> > > > > in correct order
> > > > >
> > > > > With i.MX8MQ and compatible SoCs, the order of the IRQs in the device
> > > > > tree is not optimal. The driver expects the first three IRQs to match
> > > > > their corresponding queue, while the last (fourth) IRQ is used for the
> > > > > PPS:
> > > > >
> > > > > - 1st IRQ: "int0": queue0 + other IRQs
> > > > > - 2nd IRQ: "int1": queue1
> > > > > - 3rd IRQ: "int2": queue2
> > > > > - 4th IRQ: "pps": pps
> > > > >
> > > > > However, the i.MX8MQ and compatible SoCs do not use the
> > > > > "interrupt-names" property and specify the IRQs in the wrong order:
> > > > >
> > > > > - 1st IRQ: queue1
> > > > > - 2nd IRQ: queue2
> > > > > - 3rd IRQ: queue0 + other IRQs
> > > > > - 4th IRQ: pps
> > > > >
> > > > > First rename the quirk from FEC_QUIRK_WAKEUP_FROM_INT2 to
> > > > > FEC_QUIRK_INT2_IS_MAIN_IRQ, to better reflect it's functionality.
> > > > >
> > > > > If the FEC_QUIRK_INT2_IS_MAIN_IRQ quirk is active, put the IRQs back
> > > > > in the correct order, this is done in fec_probe().
> > > > >
> > > >
> > > > I think FEC_QUIRK_INT2_IS_MAIN_IRQ or FEC_QUIRK_WAKEUP_FROM_INT2
> > > > is *NO* needed anymore. Actually, INT2 is also the main IRQ for i.MX8QM
> > > and
> > > > its compatible SoCs, but i.MX8QM uses a different solution. I don't know
> > > why
> > > > there are two different ways of doing it, as I don't know the history. But you
> > > can
> > > > refer to the solution of i.MX8QM, which I think is more suitable.
> > > >
> > > > See arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi, the IRQ 258 is
> > > > placed first.
> > >
> > > Yes, that is IMHO the correct description of the IP core, but the
> > > i.MX8M/N/Q DTS have the wrong order of IRQs. And for compatibility
> > > reasons (fixed DTS with old driver) it's IMHO not possible to change the
> > > DTS.
> > >
> >
> > I don't think it is a correct behavior for old drivers to use new DTBs or new
> > drivers to use old DTBs. Maybe you are correct, Frank also asked the same
> > question, let's see how Frank responded.
>
> DTBs should be considered stable ABI.
>

ABI defined at binding doc.
  interrupt-names:
    oneOf:
      - items:
          - const: int0
      - items:
          - const: int0
          - const: pps
      - items:
          - const: int0
          - const: int1
          - const: int2
      - items:
          - const: int0
          - const: int1
          - const: int2
          - const: pps

DTB should align binding doc. There are not 'descriptions' at 'interrupt',
which should match 'interrupt-names'. So IMX8MP dts have not match ABI,
which defined by binding doc. So it is DTS implement wrong.

Frank

> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



