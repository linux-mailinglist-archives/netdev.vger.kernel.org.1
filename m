Return-Path: <netdev+bounces-175378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2495AA6582C
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E6B16EE9C
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CA019F48D;
	Mon, 17 Mar 2025 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C2VMg86v"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320BB165EFC;
	Mon, 17 Mar 2025 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229226; cv=fail; b=XxzrksMVDW583ehQZP7raU6Qe80vBNVi0H9e9tn0j7WBKIkVmUXpep7RgHmFjWKYSGPgIPUjj7YthSQsQhXwb9bICmbe955re901qxtJQfMnXP/SPVDlcwMLlZ3+bq5bdPlIBmF/fPHuZFl8VvNs4uMh1tfvou9CrorYlmYG5vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229226; c=relaxed/simple;
	bh=TI+K2MZ3zCEcHYRWSf1xDOKO2qL2iDBxnXSAR9+YgPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PfHPWT0esYSHMPlWS/n4AwX7/3a/nA+9W4EScrv3dnozsfTNkUUFws1+Y8mBaKmpCSQCJpYa6W0dIgRjuuQ+6LyOmq3+mVym6YvNJo4tKQOHr0uO6ApIZQsv2YxtRd5wpmCPQ4gBtKGWMLtiCXbBMRVSH7kbxUqusxZOnrixTEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C2VMg86v; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXAgb6+sLEHNDpMTkWf7q6A115FsxpqMbapXTAnG6aeOcoR6oaoyxwXuUNLu3Cbw9i1lLXB3xn/uCiOUhdkr+g10rTjqZ210XjGfKVVO4tD4Eu1UXmQRKClbs7tSdSMl57r/T1mp7+2Z5HxrtPMRuf0PxXDIBzIk9aTQImzE4gsZOpAEIxUAyACKPJ3zXg04KslTtVaFLLWItw2i/krbT2UI1348KOYsSbBWbH2DPrM1tpuB5v+kdA8I7GGuNnOfVPNubUjq255AFBlvIsF/GdkfDcoKRtMpIY7isHWDyoAFKDffUcggReQABm/rmhLoZ9OMeL/Tg4jEIW0e79aNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXBCNZvV6Yj79+oqikvoGWQzR5zHzS3ib/3b5S7kISc=;
 b=Ml0qY9jIJgVEBDKAIweYIPbyBpNrXqxxCx96LsmTGqsMAMLTSano8sqfIsEfLRe5uAUlNYVREmjZDOOWnsJMHxsu6ch4M1f+UDgGT0HmCJNs2tzmpznIJQeDsKVtNSqZqTEm9mYxQaC+t13Cg4dqFOeDIQnKaYnfwlw3BZwm05S83tPoeffSzYb5bw3V44yF5oIqOjAL0Qi0IViwPrS77KnV2nqqMPbDEmgoN8M5IXh3GEagwLZ3CCfJ78X9tEycUAjEc7HrCRvrszXDQXhGxWqpKrhcOIE+3LEKJqGJfQJMHFKis+LQPdKRSdkDl+nKbzwVCHnRori+wX5w0HWolg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXBCNZvV6Yj79+oqikvoGWQzR5zHzS3ib/3b5S7kISc=;
 b=C2VMg86vheHd67yzVOvMoApyWx0QEtPm1J7F5eCsoLSjCZzsDDqDwFMjCeM8pa9gYBxlexONfp9wdpkBrKzZub5W9/1L4UueKDs/9v0euLLk+E5ErLmOQB7m2OaKNUmUM7HK69+h6DvdZNhKNakKVmkoxKclOTHJ1ND6o0m+UxZlVM8SU9sAZQwRM17yvcB8owb2ZRsI6oy0lu1oM/hWORPDdjzTFiGDrN8Lywv16EcFLWSMweDJZvZOhxPVHxqvR1QbuptXsGWgfGPGHwa0F9s0sp04U7nyL1iskbedepBOslGvB9CBiT9uDy7bGYcdUjki6OviHAyuGT85l8/Smw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 16:33:41 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 16:33:40 +0000
Date: Mon, 17 Mar 2025 18:33:37 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 net-next 09/14] net: enetc: enable RSS feature by
 default
Message-ID: <20250317163337.4ii2bmourroiaryl@skbuf>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-10-wei.fang@nxp.com>
 <20250311053830.1516523-10-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311053830.1516523-10-wei.fang@nxp.com>
 <20250311053830.1516523-10-wei.fang@nxp.com>
X-ClientProxiedBy: VE1PR03CA0027.eurprd03.prod.outlook.com
 (2603:10a6:803:118::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 85235088-f742-4222-e8ee-08dd657179e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jByC0BOzrMMSSuDsEWa765ev9b3h9rdI9JjY8wCcs0j9VZFlbMNLfN6B+Vvf?=
 =?us-ascii?Q?hEuUlTEzB8Ozq3IttQ/kL10Uy1iKhLbP8bIdn4djGubpad2fvfNikrTJTgcn?=
 =?us-ascii?Q?GbUDO1Xi5RTMajILGEPyFyijmJAML3mxpqkYBj4iT0ie1kfIBib/2ezEh175?=
 =?us-ascii?Q?9xh7tZ3r2MmZbsN3zZ/c0R4Yon0V0MNL5p9AVbYKp4+OS6MuvQvx91Va/rrY?=
 =?us-ascii?Q?2raBVIaGksWXD/1LllE0rpdFUJ1beUjjWcaFyVYAH8w4RVQVxfSkz5KRoddq?=
 =?us-ascii?Q?25rMJxp1vUjMazz6f4at25nOKE184dBYeaRST0ExVqM0j3Pqf4vTf7by+gjK?=
 =?us-ascii?Q?58jV7115LtgTBmfh6zMuYM5Kqa1vBFHMv+Gi+qy4AluxSNNmw/dzMliSlcuV?=
 =?us-ascii?Q?tltDokFw2yFIIwKOPzMTjZReZ+NqRwmUhGc3stjY0/WkeJrpMXjZ8o4J/1xQ?=
 =?us-ascii?Q?lMP5/LdOv2/3+m1c55Nv707S79ymEwyV6xfm7b4PrCkd0FuHLo4MgoY+lfnK?=
 =?us-ascii?Q?4pkjLHq8nofOo9LN3Kf0ws6mjHhMZpx4k7jI73m7bFS0SMBfpTNru0tmz9Gv?=
 =?us-ascii?Q?BjRuTbH1XEcw8LUxSB5t13SwxzEvjqXCMbwo3HoIW9fUVAdv4GBQH+ld420R?=
 =?us-ascii?Q?togyD67VA4P3vUu5jNU+QpNkKCpHivXuCQrHInjxqbHrP2PEH31USgNuVQQw?=
 =?us-ascii?Q?bmExLb/b5rXxzmRnQurWUhHAdlDwDGfP3uvmtUugjEsPMKhwKyY9INN7hxfp?=
 =?us-ascii?Q?hj/bK10VqqTFCYNPSiXmUOP54Iv/K9MZnUW5LQ6iYrFpIh270X+QeBvCeXCe?=
 =?us-ascii?Q?R5tURQYJ4cPyinAdem2lesevqOrjED5QlEjE7C4AvFPkYwtF3EuXdRGnk6UG?=
 =?us-ascii?Q?te6aMn/1kbTaYbJvOB4s8vWXvO1+tWDsLU9sVZXPGUJ0l2s+EHSoruAzAhya?=
 =?us-ascii?Q?M6wa9gnIeGs6+kWoBj6f7tF//GDIi6w1K2rREVwb1L80dDqTHTeyGT+qEcB0?=
 =?us-ascii?Q?K7maMG3UyXEItUTxr3Srw9KgW1kExv5eeb7t92HwM8W+28WxmDoDYhwC7AzQ?=
 =?us-ascii?Q?ZaJg0qU0nMO68c9qyA1w4yqtAXhQ7/mAD1aeVgP/TkNDAweYHMFwthd9JeLn?=
 =?us-ascii?Q?Y/gMTNWRYz585HMzRuCxfPwnBh5Ga526C+X9MbWCrUXtF2hiEl651Rgo8NgY?=
 =?us-ascii?Q?L9LGNTnhwi2a+s6CmfpHaMfg0HR857JVB/Pflzuqe7ZwqV7+74n3qGxqSWl9?=
 =?us-ascii?Q?n6dcZmezborM+RY8gQY/Fn4VsYRRMVENW9Nw8poTvdCe1xlt4Md9TeIr0/Wd?=
 =?us-ascii?Q?K9uUauRdcroF37fWLu4UjmxFbe1qQL2xLXd7i5Eh/gxugRpDocWiuqFBhcdQ?=
 =?us-ascii?Q?7SbEH7YHPcI9Dm+fV/MdAsB0/M2i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ZgRLIzrPH07q8RmpSAiBzQdmLOFHDe2m/JWLMuvJC6iUYVld7mbOsIpQc+g?=
 =?us-ascii?Q?iOMG7W8ciJxUeLNLUYrc4EL97aVhsVh8NCMzesM0Sif2f7CNSCO1L/5k0EfK?=
 =?us-ascii?Q?JTEw4R+jStPsHTEUh3o1yq64+b6WqiEX19QYVhXdAOIcYSdIWPIeP0/c87eY?=
 =?us-ascii?Q?bVE3ljJ7G2qpirn2NFBQoi/+46gxrcAg/a/7kzUAgLw8O37FbsJ6QL9tiF2Q?=
 =?us-ascii?Q?k2dmCRy9MtLrpeh/XgkbyTan+LLM5fyh6rcYZaQGI5pVL5E0oIYg1qpB5FOA?=
 =?us-ascii?Q?9fzz2LIlEKzKbW/BuxTWlV1GxG+LBOZsQgfOIf73ZbFK1P8C7+IZ7qqk2vBV?=
 =?us-ascii?Q?i5xfeA6HAE/BfnG7iQOjwWyLOEHnOSmK9mXHevRdcAT4Yk8LstPXl+1oiXyy?=
 =?us-ascii?Q?4lTp04QJkhaAI5/ytTVCeAioAvN7cr89oVLk+4JeQCMkvnY+izj9gquexY24?=
 =?us-ascii?Q?PQeYBB3WvGzgSzkrNZKNGDYc/lfFKxbDEw1WMLJ5E37DC0OKmyX+VXWnP2CI?=
 =?us-ascii?Q?JBYjnkGlSdV5bwOFlqtEnMiwTHuLJ77eoFYmd42JrwIdOucgQKVGzI+6XL5Z?=
 =?us-ascii?Q?NwNDDDrM8PwtOlgqPiywHIk92IWfdnAyqHAVaAWfnoG3QAhThoib91N5MEzP?=
 =?us-ascii?Q?ZuEP48BzUvjNhj15UaWmEOVuwBlxxHtEw35sklIgdH+OFS7riHZMDqOXM9zw?=
 =?us-ascii?Q?NSUw28JS8x+Pl9lhUSlBAqNKfH9j6e4LQ8rCAQEFQyEkvtqXOfvEgOhgO3p9?=
 =?us-ascii?Q?i0ml8HY0nDMA3afM10Kg8Rso/ZtSrFh0Nbeqos6N+5zZKf5JLFTWf7W9HNx+?=
 =?us-ascii?Q?Vw/Vy00htz4iqC5DaHHyywZzvO2Gz0xoNmYMaToRuUNOdsBu2gnmPyec+A41?=
 =?us-ascii?Q?rO9k6aGWLGmToarAD+NWCT6wGzQ6LZZSH2SJyKwzJe5WjYyjKX35gCqYyr+L?=
 =?us-ascii?Q?OoYNewm8gcXfSgaDHeL5JTasck40AluC5WZ7crvJsDYYVoxoL1xxReNBuGt7?=
 =?us-ascii?Q?UL+29LTQBX26HYzpGr0yOK16qMvjtoMBBc073Dz5OtgynLgHQkhLe+lgtDcv?=
 =?us-ascii?Q?JrVX/5DttAqhpXYlwvB0l6NpWeCZ1Q7MViJA48uvfVkoUiqFNFS59c8r87jW?=
 =?us-ascii?Q?IN0tuwWdRuOu9yB6mnnDk1I8U2evCI4ZSF5emrp89hOuyKvfHQtDwlLCRKwy?=
 =?us-ascii?Q?x1hmA40WK6/gCvLj2EgB8Pp/Zliw4zwfv1hMr0vTRUjYG79iSNNMO2WA+ZgU?=
 =?us-ascii?Q?SdbKTPCec0ApCPqvmkQhdj4SjO7w6B/7i1jTA3NaDSeAmyVwAW0OzBnXHP+H?=
 =?us-ascii?Q?wutSrpmGIPQBQXiWGGV6dh+Yjvy1Qyg7a7vJhj0o4K9WerHN018qAolBgjse?=
 =?us-ascii?Q?rnkEaXAXDfnQLQTzlWVV4wJXaSRExAlElCoR+aGX2eQFQ3cmivRsgrvkFF4z?=
 =?us-ascii?Q?bnmAB7zev3/BZW+QdkmVlr5GuhQTgteewgkfUo7dxyR3zI44Mu/SJG4ZtSqb?=
 =?us-ascii?Q?Fhi1RtLzXAnLvUhD9jLTjNM/hk58v26sXMcifqOs+Bq2ndl1vnqs4kp8/y9j?=
 =?us-ascii?Q?4ehJOuyMXUaKb5xOttYZb1nUBtVFxUZKZECNq7admBwkeNqnA1SKwPQqkfHs?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85235088-f742-4222-e8ee-08dd657179e2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 16:33:40.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EICsTowrqdP1NX7H2QNM58+zziZqoVFlGgjsKZ9yDIFtu9C2Y7+EukMgsSNsrduGNSgI/JIi1OIbfnk9VFK8ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9638

On Tue, Mar 11, 2025 at 01:38:25PM +0800, Wei Fang wrote:
> Receive side scaling (RSS) is a network driver technology that enables
> the efficient distribution of network receive processing across multiple
> CPUs in multiprocessor systems. Therefore, it is better to enable RSS by
> default so that the CPU load can be balanced and network performance can
> be improved when then network is enabled.

s/then network/the network/

> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 35 ++++++++++---------
>  .../freescale/enetc/enetc_pf_common.c         |  4 ++-
>  .../net/ethernet/freescale/enetc/enetc_vf.c   |  4 ++-
>  3 files changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 5b5e65ac8fab..8583ac9f7b9e 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -2420,6 +2420,22 @@ static void enetc_set_lso_flags_mask(struct enetc_hw *hw)
>  	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
>  }
>  
> +static int enetc_set_rss(struct net_device *ndev, int en)

Can you please add a preliminary patch which converts this function's
prototype to:

static void enetc_set_rss(struct net_device *ndev, bool en)
?

After you do that please feel free to add my tag and keep it in future
patch submissions:

Acked-by: Vladimir Oltean <vladimir.oltean@nxp.com>

I don't see downsides to enabling RX hashing by default.

