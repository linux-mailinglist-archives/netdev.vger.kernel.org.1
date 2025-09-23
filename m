Return-Path: <netdev+bounces-225667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62F2B96B0B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76C119C1A48
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A3223AB9C;
	Tue, 23 Sep 2025 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y9ZXluaR"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7740AD24;
	Tue, 23 Sep 2025 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643238; cv=fail; b=mWS7MD7sk3wjuPGt4QjCuXmP+D/NfPF+X/zPtIWujrvX08ElbniZu2Uq1u30Fl06v52sIoNfO9mDP+h2YT87WbSo6fZ2Ip0mVyaO8RXJLsPRt4ukg22i+LutKDK9UWGAMGLABiHfhcxKi981fXj/Xi0INX1A2/Tchpgg5PqRsNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643238; c=relaxed/simple;
	bh=zA/+O28SfAg8Ig0k+TozPU4yluIGuKcV7EUQsyQJ2qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lljbDcAat50E1cDhYadlTSWLRHz/K5vydJJfOzCH1uuXFdw4FBEMeeqkVIro49qrCOh9kCRkmR6HlvJjl5dpbt67FWSc1En9clIedHWQTbowtLQ9D8iqgAa1UZpSpcm9c/ZsssntrXe09vMJlXNrmjvzpvSTpcruaYE4+l0642I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y9ZXluaR; arc=fail smtp.client-ip=40.93.196.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTgUE4KNyXAM1OkgxPRoCk3hJYoyFkwtwUzu1uF9CFF4I0O9aZ9B4kQqVTQdgzQFm86Pxhrp2MSbaT64pnLuIMDMxEUX46J+lquEhGNUrJ6PA6hVVfeaQfmlsSFpoE9jyFLLdNLqzYNca3xp1K7yvfVL954GzyVtmdsP8CCYyvme5SvPkHdL60miNxQdQ/Nl9NH36Cj7quAT4rxuIkSFhAnCYXN1idnjgeQPUlkPBFBYdMSmU/0/lYKuaxxDTHfxZuxDjweMmcUbF5FUr9T4znoszNS9nF9hLxeCl8chifAyBgMn0UNN9xruBlvKyoKtTfojEyueP5hT40m8pX0eZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0Xo1tTrz2K1fd2rozV8t3vE6/iCzNUrcLXN5W33kHs=;
 b=iSBXfus9xKyApstPCQ5d+iME4Upe9z2+AgajsRX3IuGE/TvSCFTcIoiV38eaBfwWzm1i/ZwP4X5domZVECWTqe2HM6vTIgBlGX1dBKsfhxWF286a/tS4vNp5ShSm5FlQxvtEhEE7lgWdILaqO3lus5rMZJE+KO2u8olMRM9KNrBDVkynYZXs4yrAC8YTcCnUXIJcMgvWrGV2F7mWh5KfrxfGWHrKaJgq+//GwkE3MDN8qJihcBv+3kumglMOFEagJygS1G4fETw6IYwPMpz/XPfPQ+5ZiBJyOhWhIG4U2eb5E46wNaXlgREqRhiA8qr2jlLa5caEdsoQ5hYidNmXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0Xo1tTrz2K1fd2rozV8t3vE6/iCzNUrcLXN5W33kHs=;
 b=Y9ZXluaRevX/kEBvX04CZqPwI+C2iAR4nyGAptmf4hgVtRDprCvjINX1g5RDqtDcPjuJf4sF3P90ngEoIojvQuKTg8pGsiYRycvMo0QveG9lOdBcc9shpiqjh4QaPVnDbg3IzXPhtyq21uUaEvFA4DwdKJGORCTBhSzsSPaSn+WdELeK+MiURUC9k7D4EE6+m3f8zuxgBFTzZX0pw6yWwDlPrW5JI8AYbgasQCYRGT30afs7Ku+dH4jB/HAxtqAs2vT9BG36SqHXD7Bkk9qZwJKCMqkFGt1IQp+MGt6BYlY0VPUmxnRKs1B8JXhhmiX4DonG+YKL0kU/eExN6n+4kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 16:00:31 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 16:00:31 +0000
Date: Tue, 23 Sep 2025 16:00:27 +0000
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
Message-ID: <ztotepnqvbyzwtmqox5433lp6wix6jzj6tf3zkagwvfzf33trz@khcwhwwg7gxx>
References: <20250918084823.372000-1-dtatulea@nvidia.com>
 <20250919165746.5004bb8c@kernel.org>
 <muuya2c2qrnmr3wzxslgkpeufet3rlnitw5dijcaq2gpy4tnwa@5p2xnefrp5rk>
 <20250922161827.4c4aebd1@kernel.org>
 <ncerbfkwxgdwvu57kmbdvtndc6ruxhwlbsugxzx7xnyjg5f6rv@x2rqjadywnuk>
 <20250923083439.60c64f5e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923083439.60c64f5e@kernel.org>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 683c49ca-e727-4858-df49-08ddfaba525e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BlZCoPvpLjE70q1Mb4szlzb+FA0PVpZJOx+UfxIaH0Tiu/kI6Qq3bA6K7UQo?=
 =?us-ascii?Q?2aQf7DbYcX76nVu5+nWRPFQ9fl2XoCvmqoITZh9cXCIrAPStxJrmh425NYv8?=
 =?us-ascii?Q?ueS/PX6YWCMOWU/XJWvwYSPWilynTiHCrs+V3TkdMfO4IzJd3lNGKjLnLdC1?=
 =?us-ascii?Q?+GtkEulc6qtgHHN78lVZV+acDp+c3JwiWP3ZJEC9+m+1RJc2yLXzvJGxIfjQ?=
 =?us-ascii?Q?V1Jchwh7DBivWjyxFYcFyKhAuKoTwKwtXJhrdaoANJ/dN7vn6Gc2r8XYDVsa?=
 =?us-ascii?Q?tDxfO8mn1I0DM3x/1+Dct0qut5FN2/QJqDGjTEvpROMgEdKoMpfQMkxQQkBz?=
 =?us-ascii?Q?ofRqCMIK8c27wU3bE/42gSSCqbhixUnYuM5KfsG/gnXkoM9BvHjnvcIZW9eH?=
 =?us-ascii?Q?jWNkjatXUnGCdb14H+JvZceKyh2RAs7yQb6dK94Rh1cZ38akVfbcOqoOUbUc?=
 =?us-ascii?Q?p8e+vsScnz6jyWf7OMwm47Nd6628dXOrvpppnhQaWTDjDYAaj0udiMTYFWwD?=
 =?us-ascii?Q?FMGfjJjPth48N68ZLLrCAOWhUVX74AeUNlN4VUJ8zTBwduNEfjXL3ikeoBn7?=
 =?us-ascii?Q?GQ0DUtWyGm+Exe08QPwsGzmz7bHei6sgze+AyHncIJUf59vWugcSzVhxVrKW?=
 =?us-ascii?Q?vqwT6GkwQJ44qrzgEOIPnxEJBwZepWU2H4zY2Zw58aZHl8jc6R+POuzVZlYI?=
 =?us-ascii?Q?WIgOF+V01QA/DjINlTvTID73wBHXlduMJIjLOSUAKo4X83PUqhFx1RPYy0e7?=
 =?us-ascii?Q?bGbbnmR3puTp2gWGKi583x30M42twQqM4lSETx0USvZ9IASwpD2sAe836LTp?=
 =?us-ascii?Q?BC6Xgaqwai7lMrnBCwnHLS47c9SBrl/jsQda+v8Dr7BKQqqhkjSo9aOnAOPI?=
 =?us-ascii?Q?lX08LEMNXqS5d5VxEqTogMSrclfMm9qd6J6W9ddz6rDnkGPbjBzdqo8A4dp4?=
 =?us-ascii?Q?BuOkZL2JECTD8ctwGgZNVba0oH+Tbrwd6ZQ/dsjmU6dXHCNHybVJhjn7l2i+?=
 =?us-ascii?Q?UPIFD9klHbRPE8VDvTQl8AjRASmEpqqDlA6JM3ll+7GlVatzvLHtrHwDFnEZ?=
 =?us-ascii?Q?sQEUKghWfmdxELyWWcqPm92vzlDx/nUn9nyul35YBU94DzWaMwTF9Mqfdar/?=
 =?us-ascii?Q?bn6WXmUR2qGkRRQqk7LM+Kr76JodFb/FoDL95Ywfu8yl+8/w/myWNMMnGaW1?=
 =?us-ascii?Q?H0biZmS3uqb9pLNNQAIokdgecD9Kd9Ncbe3Oj4zGGYUUfKMaMzg1Ec49R5g9?=
 =?us-ascii?Q?hFwykqnnLhXqqoCA2Yn9HCq1KDhQlsnM6UDu+2fyRr+Z1U8Ny1zUXw13k0w1?=
 =?us-ascii?Q?zSwUHXoyRg/xqIE8YFuRk/SR2PBRuAvOa5/597y8iJA1vLaqzzJDDtEDeklC?=
 =?us-ascii?Q?9Sbs65LmW4Nnp6YUOlEw9EfoItXQNxB0Zap9jEwgdFSXMDkdF2177cPjPyYR?=
 =?us-ascii?Q?KEj8pWtL/U4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7fnXEdrYkWfMc179Q2vL+QIQ4p1fCU5Zm9cOyESzXazTwHhJyv355fz+WHWd?=
 =?us-ascii?Q?nVz7trGr79jeYYRVogLc4jCBePV1dS7FHc7Rfa1LbEJgMf0OpRT7a1OJ2Gcp?=
 =?us-ascii?Q?mgNl0U1ltn4WNnJnsNlL3a+5ge+qAO8iB1Kmxf5LslzoyDegkW0bGHSOcZ1N?=
 =?us-ascii?Q?+JKU9WE440f2exCbEqwW6L8YqfcdhtOgemszpxPdJd3+60yfes6EcyDgqMwl?=
 =?us-ascii?Q?+dNzvB9Y2k1PXZs4Q1CQzToy5PJEsGujECyx1/LQfxWcRJUp5rki9EURzRjm?=
 =?us-ascii?Q?5IF2IEnE0JaFGKo3JRlD41D8UbTSsWI7kIXalSxaENcZlKoLSzHxRVWX/83Z?=
 =?us-ascii?Q?lnZbpL9JpwM2sdL6u9BXnVcYBhsfmXePe7qgHMwQSRmI9F14xN6MaN72EbO3?=
 =?us-ascii?Q?zOuQ1Jr4fDkXLcCTSWc9S5tFPvr5Dztz1LVOZ7cKdYJlZX9AVdPnNpZYj/6G?=
 =?us-ascii?Q?yDoFIJQMeYqjTrbU5qT9TtHgFMWPiZxWQBi9+9sRLDe/q/xB5E6eNsWgGVbS?=
 =?us-ascii?Q?ZE8dYhMZwQW3wmiC2dZUj8DMsTx+AwPnsfP7L4UYfQ187DZjZ2jGbSAPKLlw?=
 =?us-ascii?Q?yOlCzVuSjz9TK37VSQMMH9F++CclZ5wJFsr0EHCDAVOPnr30sssiqxONOXG4?=
 =?us-ascii?Q?VVsdBwMBTeYuA23IVMu0GPRPT+j9JMC3Q3GImZz1XCoznWciWTncBMrslTUg?=
 =?us-ascii?Q?V9opyD6xpIUOidCkYx3844Tibm0+62Oim5AA8VZJSZpPqCbHnmdEuGKSfZzd?=
 =?us-ascii?Q?0qS5ofT56iQsRs3xbQCEXFhb1lg/EseHak689TVH/t1m2WRuqc611AmdDZwI?=
 =?us-ascii?Q?zJhCUr+6lcC+PF8ERHTjM1cVm6vUJoRUJoHgTJiEniqi7D1N9ChD3SvxYeu9?=
 =?us-ascii?Q?6FD8HB87MhDEQ5PXIgx8XfKLNqSDaQywODYjDNBYp2lsejKYWSl5IT+FgWGk?=
 =?us-ascii?Q?NzorZ+PYtFKZFFOdWj4KN+JYlUopUfFbSpkwuE+KUK9utKORqp8yKayu/q6G?=
 =?us-ascii?Q?30+mzrkzyqMPpg91CL0AHbUTy0hSCvqb5C1jC/7cKJHCsLasc/CGzyxjkRlr?=
 =?us-ascii?Q?EPpJdio+M/zq5JyedDS4BWNO0NXHXspVfMpgzJaCNDEK3NycT1HfZDbFhGq0?=
 =?us-ascii?Q?RrjYGWo5Cz1AI9hcYp3uXU9DrG7DPkbPsKIRF5xe9y6GzgTEUaEJjuyCNp1d?=
 =?us-ascii?Q?mAAAbBi1K3URX3P/5e9lLDED6Fybk4EBr9QOw62g2uWP5YToGH/e04uZXaC6?=
 =?us-ascii?Q?wSMprFX607PqQ6KWqg12TPocyQZCqlMfG56RMVVdwWoGu0FWBo3RreJe1H3U?=
 =?us-ascii?Q?VHAn05ZQNBPceT+EaccfSTbYhfPe8FKKixQJhIOhOBu+Ol/8XJBzqCltHOat?=
 =?us-ascii?Q?451Y6P5SNMeoxVKf+D0sVUuMHgS9cR2sr3jiufkbD25Ql3sLFJ5H8qjycFB/?=
 =?us-ascii?Q?8f6oHSx0ZBMPQyQgnU/KsTMwk1qhnQEjn7NqsmI+RlTRku51rSKCe9BNZhge?=
 =?us-ascii?Q?uVyeEQkQ1JnV4U3nc44joNwn0fjbmSqiRxZ5/yDyDf7mAmON8O2jvdIUvoNa?=
 =?us-ascii?Q?1Zgx6DDn/KoTf1qk83FXu0+aC8H0Gh+xessZBaqu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683c49ca-e727-4858-df49-08ddfaba525e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 16:00:31.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXR4Bsww1ewQLEDABtgCW4aw4Xv0ku9oNFe8jhQnuLSJJim1e6L125zMH0oxZkxn94YVg+Y6If2w4azXIurrJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434

On Tue, Sep 23, 2025 at 08:34:39AM -0700, Jakub Kicinski wrote:
> On Tue, 23 Sep 2025 15:23:02 +0000 Dragos Tatulea wrote:
> > On Mon, Sep 22, 2025 at 04:18:27PM -0700, Jakub Kicinski wrote:
> > > On Sat, 20 Sep 2025 09:25:31 +0000 Dragos Tatulea wrote:  
> > > > The point is not to chase leaks but races from doing a recycle to cache
> > > > from the wrong CPU. This is how XDP issue was caught where
> > > > xdp_set_return_frame_no_direct() was not set appropriately for cpumap [1].
> > > > 
> > > > My first approach was to __page_pool_put_page() but then I figured that
> > > > the warning should live closer to where the actual assignment happens.
> > > > 
> > > > [1] https://lore.kernel.org/all/e60404e2-4782-409f-8596-ae21ce7272c4@kernel.org/  
> > > 
> > > Ah, that thing. I wonder whether the complexity in the driver-facing 
> > > xdp_return API is really worth the gain here. IIUC we want to extract
> > > the cases where we're doing local recycling and let those cases use
> > > the lockless cache. But all those cases should be caught by automatic
> > > local recycling detection, so caller can just pass false..
> > >  
> > This patch was simply adding the debugging code to catch the potential
> > misuse from any callers.
> > 
> > I was planning to send another patch for the xdp_return() API part
> > once/if this one got accepted. If it makes more sense I can bundle them
> > together in a RFC (as merge window is coming).
> 
> Combined RFC would make sense, yes.
>
Ack.

> But you get what I'm saying right? I'm questioning whether _rx_napi()
> flavor of calls even make sense these days. If they don't I'd think
> the drivers can't be wrong and the need for the debug check is
> diminished?
I got the point for XDP. I am not sure if you are arguing the same thing
for the other users though. For example. there are many drivers
releasing netmems with direct=true.

Thanks,
Dragos

