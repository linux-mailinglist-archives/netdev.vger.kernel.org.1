Return-Path: <netdev+bounces-225656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D70B968D4
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF92716825D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC92243371;
	Tue, 23 Sep 2025 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EzNy9O4n"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013007.outbound.protection.outlook.com [40.107.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57871EFF80;
	Tue, 23 Sep 2025 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640991; cv=fail; b=C1k+bM7YJdVAdA0MbrAaSzK8VB73GNxjSutF6ZVBMjy9IbOsdk5HS47CVKhjFthj9657mp1AmGV/tGbTwyb357aK+E31LmQ2wA/OCWdRA8Xx3njaTDmzQKrt8cVN510gw9tmX3CjCfOs7jxlzNSECxYh5aiTkV8ouw6C761/miE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640991; c=relaxed/simple;
	bh=w9g8RiOlrQhlC6YIcTrhJ4etB4VRKZLcv05sQz/yQ3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E+zdmVk+OzZkhP1/szn8/OsjU+ttXyMocQx1fNV5J/MbhgovNIL/AsRiYAoOgeuGDrRC/GbEgaWmxqrK/sjVd891pIHSX1XD2qwWgPsBFTZXZqfdZ49QklgOEaVzFxA46q5o/9S751UpKSar3Rwh5GUrzY7AfK71DNnkTw+3OSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EzNy9O4n; arc=fail smtp.client-ip=40.107.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RniWp8yuJw6tseKX7aY+dPQmrZI6C3Q4GKA1YNDMCFXI4IozQUEZonFA5Ezy0JvOaroupd1O+BCi+a4JyK62aZymznPO9CZN/nJLTeDdbw5tDp9NbTOLyb+ihZ+J6EoxTzqTu0+a5bWXygCBOBXAHwDhaoEC6IalY/YrdvnDQu/vizV2asksshL7kVdQMc1CWgbzLtKjk2Sq54u/aO7eqe3W1Xrj5vKkDTUnVEExpzEN+srHvFKVHErTOwJmnv9FKX/AMxSp0wUxNiUMAQbPlAClwvY4nHx+PMDWzh9zv1FcEQLm9M7JxaAvyTMOlWwOkYwBQXUaXmHQfJY+h7XHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=631vCJcPvCT6h981L9L9xioaO9kGAML4/oMgRhRXQU0=;
 b=ffBTCgeALSZM8SCPfup6e5nTfrhPuxEIAp48rdx4dwVM+/uZEMcFD4nGgi4fcR0+LoAzGVv2A0lJOsN6Ynt6rhfieqJDfgG4RvBgn7bIh/AdE3/IvLRgJjgXSt4uKsis1GX/fO6LlNr1fT6PTdjLk3i6/oqsSOVAlVWVZ62ASoknlqWqLDPUsyNUkEBvJPIDYARpHgLa1X3NBDa4VSSzQWxRQ0y49ZV1Z/ZSIBhK6g9A/IfIhuKGzLIC2wO7jJ8Kgosje7DC1DekzvRhFWXJE+w5p/1HDrx6ErlIuvooMLYIfL7DKbNjYDcliytU/LlWtcWk4PZf/bQ8PsLxUT7YoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=631vCJcPvCT6h981L9L9xioaO9kGAML4/oMgRhRXQU0=;
 b=EzNy9O4njJ6X1cYs1vsNGQoMsbpzxtA4GSC0C0OyZBuyeb1GjAioHEPcDZQmxTARmiDaLFLN/me/0cec8/SB8FBy978+jRTuwerGaPBPzlQ4egdD+XYbf947FG6nX776JmJV/SuMu45gDGOGuIu93WeNUzbiqluLYotaTpVET9FauOb7ZV9bfwV5X4qc/gRws2XmKgRcKI0U6lsNsKnN/ZtFNdYrwhpNFlSMljbpipG0Q4vPjqTkAsjBojUoQMH2j9SgfLH8vjheUpKaZ+vxgHh9XNBBtJ5rSeLyPe2Oz6/P6YWOCuhCOJR3/MfAqfgW7VSlQnBnJqLsCU5Zecy4TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 15:23:06 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 15:23:06 +0000
Date: Tue, 23 Sep 2025 15:23:02 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next] page_pool: add debug for release to cache from
 wrong CPU
Message-ID: <ncerbfkwxgdwvu57kmbdvtndc6ruxhwlbsugxzx7xnyjg5f6rv@x2rqjadywnuk>
References: <20250918084823.372000-1-dtatulea@nvidia.com>
 <20250919165746.5004bb8c@kernel.org>
 <muuya2c2qrnmr3wzxslgkpeufet3rlnitw5dijcaq2gpy4tnwa@5p2xnefrp5rk>
 <20250922161827.4c4aebd1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922161827.4c4aebd1@kernel.org>
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 90dc9b9a-37e4-4f23-3714-08ddfab5186d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7wSCcKkCKLXWCNr/Zn/PHZg2Rudqqtp9FvhM4L5BTpJFc4CK4F2D5GLbgo9M?=
 =?us-ascii?Q?xGC6V9jdwH5MTuNZEoLOOUPRP046ONEQGZDttky8N5exAW7R+upenEHajYoY?=
 =?us-ascii?Q?Q6G6iRpPy+gNp1nuPGDNmqQ0MO65cllX98CvFVG47Fpixq31Fw0Ukkpetqk3?=
 =?us-ascii?Q?il7QoCsEjO+l0Nd96LO6z5wkAu4Zbn56TeiYGfeSvUx0+Yrb+4WEcjja/t0b?=
 =?us-ascii?Q?sYOu82oFA2dwsgmXyzuiSma9yPCpNIZ/LJfJ7BzNqFdSAjKkDDWn0dbr9jL8?=
 =?us-ascii?Q?1X0ytXMIOS9TFu1QB+3fD8XR5PNJ8ZS0gM0SFvG3Y2l/SF+PJzlQP8LcJtyX?=
 =?us-ascii?Q?gJ9zw030lURRnKp2/cZaR4HIehJj3nfcScPsheq3fWjyVFs/Udny6kQgSvGn?=
 =?us-ascii?Q?Tf7+FAeLHwd/u5Y41JSqDFRXBhhvpU6WECu9Zs8fTzwdKRE5iU46Bws87TWw?=
 =?us-ascii?Q?TAmH2Jvu5Nmfz8wyuoj71sK8jU+hhF4OviMQlsJ5lwMG43dHNlsLGVcadwnj?=
 =?us-ascii?Q?CSUABoiV9ovteqa4CcDXESkX1FMU5v51iKNv/iZclF2TsqA3ngV5//yoI98j?=
 =?us-ascii?Q?UPUMzVe5uy5dBUe9oQTvwLC1isSYv0YVO33ziK2JZhW/gf2xlKKOr+TX+1TQ?=
 =?us-ascii?Q?zLthVRimGiW1/KZ9bvEdf0p+BZnXXE7SfZwqhC8yILxQViLw89EQoM+sBYfO?=
 =?us-ascii?Q?T/r0miD1x43LyqnqPjcx0L8OPb2jw3FyBrHMcHcWstW5/QVd0V/MF786d00q?=
 =?us-ascii?Q?SKQylSOiNt7a3FxSdTslzSUlWfnqua6BVCVw5GjDL9Vr7vDm2Gu2xcoxLmUE?=
 =?us-ascii?Q?gzfBE/P31N7loTqLhbn4HeKL+gs0Km4ngTX67jJZdoYB0WBC6NRunOwzr9RS?=
 =?us-ascii?Q?elV04IylExFeI8YWsDy+wlBRDd9bU6nbOuqA3ItpkmAOifTFNdBBwqgjRtPn?=
 =?us-ascii?Q?h3hoiDhS2A5wrOjkyTVCBfCEJd/0c5dc3o1Fx+Jge2GG3GijkEQBbuzIapkd?=
 =?us-ascii?Q?/Ma4afb4ZuVS0PzejBRodTvi7BAL5bd4BonIrUJ17l1nKg8+BbxmvFFfmma8?=
 =?us-ascii?Q?Z9nk/ryLr0jwzWvHPO/FWg0olvmHr2yFF6VJTrY7z3y7l3aeGqw53or/b9+N?=
 =?us-ascii?Q?RVdmsrvfyFNqqCOZbQc/GNTKRemgScYsBZLT5pY7VDrIF4bsw2BQd0TmdGJE?=
 =?us-ascii?Q?8F75faXMvjfM7X6aD9SA6Q+yvD9QRW9wY4G+W4K+TxUOj2TTaX82IhPWRSED?=
 =?us-ascii?Q?TB3iMTow1xu4fpJT2peOK/373EPLkB1b2mKYRSOJRQdRy+pVi1o2H3zXfzEu?=
 =?us-ascii?Q?0MBYxuSCBiprsIxpna1xII9CxYUNfsHisey/OX3PCBSOsqL50MB8XrueWxOW?=
 =?us-ascii?Q?n4Fu5vq5WvbuumazhEiMYL4VI7BSugRLE84+Cg5jIfm7P2Vp+HExd8cW3zcM?=
 =?us-ascii?Q?tp4AGMRfwKU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/1W0i64qgkeSCYWA1oDlZfKIVKJra5OZknRErGdmqw0fJgh+0+xPIZ8tLcu2?=
 =?us-ascii?Q?02BZF8LrknRKCFz2hS4zdrTl8ZxiijMXoawM45K37N3InT+cfWxrrmd9E/rQ?=
 =?us-ascii?Q?gRVSukOfmb0bw91SePmzYf+5nLQsqVtkb1XPpOSEdg9KBYETXfN/F6cSm7ob?=
 =?us-ascii?Q?L/kQnuwyhsWYJsr7fnwljGRgYj8U4igiy4wDCCdiANpFxpwesHBSwgG+bax1?=
 =?us-ascii?Q?i/4Lgh6fYbigE4qJlk0oQEW5CC7xQITIHcpVuxxQ28GDjc0WBus5y4CYTqA5?=
 =?us-ascii?Q?lEJ+BzBjvID93wM9TJ6hx+9xKrWyndIrI1gBcJK8Fo2+a15pGI8GW7dgg5XW?=
 =?us-ascii?Q?ByVGIFGH/tm1snrywHFl1fi3dOUeoiZ6hKRDyU4rMHJ6BmG+8JHF4xMSjf7D?=
 =?us-ascii?Q?1NsfhhYw6GOIrvklVLkx+sIcAeEiJV2VOCk2Me2bxgASxULu+4tXtEM1LtxA?=
 =?us-ascii?Q?n9rqiWqbYf4Akr91Axbtx3Be4xg1ua8acBEuV3KfPAMsO3G43sCR0w2uHDCv?=
 =?us-ascii?Q?oFfoew/KeuhUJ+uXlmW4K7xCMazO1YA1fwH8i871pYiUIQ/Qc2TwfDIxwTRg?=
 =?us-ascii?Q?TyQyl3MwAbhbuJnAR2jl7w4+KFpfGSBgn3tKcIRsh2QJO+LW84uDZgJgHG7m?=
 =?us-ascii?Q?ce+MrHwuOR5V1VMdnEnWqw4U+s2O8lVd+chWpr7onc/yp5os6Orsts5qOKC/?=
 =?us-ascii?Q?GziV7GyyHkhlK02jQh2BDFb10Diqmp2HdMZ8ziHYT2j+Op5MxPrncVspZ3xU?=
 =?us-ascii?Q?htJX0WU79LmiEOYc7EA3vZeKy7dJUi2h72L0hY3TNy7I/e9NSRVqaWV0HefL?=
 =?us-ascii?Q?blu0ZDph3l7rZco9cljkdZQ8Gpz4/r7Nx5GSHZp8Ysq3Pm0iXo/lXt5pFQ2u?=
 =?us-ascii?Q?OfyH+qbrbyquADFmjTbFkUatUJvqUxHE564CzgYIs/3i/wz6Ff+Tb715CV8C?=
 =?us-ascii?Q?46Xp1dcIQCXzWLfZuqvnXzlFLnr0aG/y3TXZB8vblSvHOgDfSKcksnndcDym?=
 =?us-ascii?Q?RlxAFOv33UB8wnHAWdhMN7tSv6Oh4oe4hZoX+oSthzj6BkdR5ISCk8+ZSRDa?=
 =?us-ascii?Q?fLlDrKp2XF5yo1spKLyj6IfaDFhEncKdKEHDffodSm6L5VObNCb5QBmCJ6JH?=
 =?us-ascii?Q?mOOAPKv10QNG8kIVKAxkk5qIvIfYJi9XRpOvFRaOG0nSFq4BCIOMUZUttzG9?=
 =?us-ascii?Q?GxRZkIQtMM/UgEU8AOp3dN7yLGAAPx40SzN314EEEHXMr1SvpazLdUj+Hom4?=
 =?us-ascii?Q?xUb8N255iGWgPOPbVvsaNcYYtaTzcWPZW595XgYXBs5fC2FtU4KL2RG53b1/?=
 =?us-ascii?Q?WPaDBXCdoKaRTi9ASxTJ+B/sMoWVbZ7ml0M+dI608TJcnWvdjwgztzOjvZ2x?=
 =?us-ascii?Q?wTgDMjrnkhQgJ5NJvpEz9JFnj3sdrFgXMa2FkJFRnSj6j65LPxjtlB1NeqQd?=
 =?us-ascii?Q?3wgArLYUNNSd8R4nNueMl92OEFk6L/oPY0woGycZFDN2uX6CUsJKbMtBE/3k?=
 =?us-ascii?Q?aE7w8VRFhga8x3JcwrT5Vk1L/VYzYoOQC3UhC73BeyYOqcpcH26+kLOzJleO?=
 =?us-ascii?Q?ZGst9CNeSvxQFF+hqKoqJfkmRdZa/KuWJEyA4Om6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dc9b9a-37e4-4f23-3714-08ddfab5186d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 15:23:06.5189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKA0g/Nv2xPsTWGWRKPGVD3/GjupyIvqU81ts7Q7ClVraTZ7gYKf+zDD6Hgar8Mu2LSqsB64h3j4PGKdkgizzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

On Mon, Sep 22, 2025 at 04:18:27PM -0700, Jakub Kicinski wrote:
> On Sat, 20 Sep 2025 09:25:31 +0000 Dragos Tatulea wrote:
> > > The patch seems half-baked. If the NAPI local recycling is incorrect
> > > the pp will leak a reference and live forever. Which hopefully people
> > > would notice. Are you adding this check just to double confirm that
> > > any leaks you're chasing are in the driver, and not in the core?  
> >
> > The point is not to chase leaks but races from doing a recycle to cache
> > from the wrong CPU. This is how XDP issue was caught where
> > xdp_set_return_frame_no_direct() was not set appropriately for cpumap [1].
> > 
> > My first approach was to __page_pool_put_page() but then I figured that
> > the warning should live closer to where the actual assignment happens.
> > 
> > [1] https://lore.kernel.org/all/e60404e2-4782-409f-8596-ae21ce7272c4@kernel.org/
> 
> Ah, that thing. I wonder whether the complexity in the driver-facing 
> xdp_return API is really worth the gain here. IIUC we want to extract
> the cases where we're doing local recycling and let those cases use
> the lockless cache. But all those cases should be caught by automatic
> local recycling detection, so caller can just pass false..
>
This patch was simply adding the debugging code to catch the potential
misuse from any callers.

I was planning to send another patch for the xdp_return() API part
once/if this one got accepted. If it makes more sense I can bundle them
together in a RFC (as merge window is coming).

Thanks,
Dragos

