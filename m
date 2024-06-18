Return-Path: <netdev+bounces-104661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9416190DDF5
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9707A1C232FE
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 21:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AEE1741D4;
	Tue, 18 Jun 2024 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iFrF2teZ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8AB15E5CA;
	Tue, 18 Jun 2024 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744652; cv=fail; b=SfiTfgP6TwNh6vThg+lC4q2daU72HwxEFtR7iBqwApAenRNpHux/VDBS0Rpuy5Mj3kfotpHV0qyJzPS+RG02pnjIAhRE6NcnjAXF6gdxP3/03VYID63gQ8P+6wDudKx2hmfje38YZ3XPijVteFvqrun8GpwP129EnL5Po5J7/sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744652; c=relaxed/simple;
	bh=X3k+Bcx2Qiv3m9VE1mgJ+juGvTsWezAwZNMNsZUMg8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y7OS3zWtl91ARuLIunMfx0qVewZxbMws5+3uc07coPV1Xl/n42GjH67Ab2i+HDJHM0Idnls3HzhuvnUAuOjQ9KRXgE3hN8jSG30+epyISVYf93u0khLpGftjPs5hxusnd1sKEtUdWV3wZTKOj2aLCXcL/Jucqz/gaIzjTVHkKDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iFrF2teZ; arc=fail smtp.client-ip=40.107.8.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eotl44RLzHvWngibECOi00/BNQMeq8xpulazhxhoczXaCZ+TLXxwYSbDoGJHARWs+sWYaMQcstIL6cLgHQL1jcaJ8c4/fw0jYDQ4Lx3vpZxYU5GYjF952kU7/tmx2AQf8j+FHDKrjGwdrGp8X5gu3M+XnPhAxFrzH3DTXUDH/YCpHiLtPNRMJ9Q4TkiUq2KhUTeb1cBBWFrLirdWGYoaUJHe2f8blooD7jQgEI31yoRJgPmpGlsiRHcAfE49R5410t/H+lQR2ZCmdqyr/Lp+Bwn4Gw2waC+f180R7FEnnZmWmwFgOwYpBFovSuskASxpjHoOTxrWm/ifkv2bCCqGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y3UpnrgcHGEvUv59R1HEym5JNAO3Ci3LA1JjkK/hHw=;
 b=f7+FD9YMpFcjri48q03a82adPKD0IMTFB18niOYSKRhm3lTU29a3mXmrFALFh4agNIZuiNfDhruIFwz8b3AiqeFq/F/g2+7nn2LMgr/kpMJxMgQoGfxYDM7LL4ZGYD2v3M0Rd/d5DzT+3mkEEKlyH/Jo396lzn02a3w5lRDiy5xdYC6W3tldmqA8I1PT85SIs9UZpeaPK0z/Ced+5/fTZZypmmN4Hi5q/VJiLMW3lQrSNViwqwfaSvuTeX+MCihzFPBwG7eJZtMh43HtbiAwX2mTE+pfLSSQ+itd28hN3xClVmndhtwPEprxzHMud6BEHDO8ZhM2IZK7YIhUau4csA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y3UpnrgcHGEvUv59R1HEym5JNAO3Ci3LA1JjkK/hHw=;
 b=iFrF2teZObxeEmTlNyHgV5EYN+IMrMen1L7wA15zGMB7rPF1k289RapoxiUTEzHgpLv/QC0wbsUCntClcQlOaBGKoSgnXZkeyXzhRGEtuAyhd4AHSKWYOiQ50TVlEkAwBpLA7kwSkQWyBWIeLRbTtLF20WLmxCGJ2Qej4JzApB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7479.eurprd04.prod.outlook.com (2603:10a6:10:1ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 21:04:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 21:04:06 +0000
Date: Tue, 18 Jun 2024 17:03:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yangbo Lu <yangbo.lu@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 2/2] dt-bindings: net: Convert fsl-fman to yaml
Message-ID: <ZnH2PDXn4l062NPK@lizhi-Precision-Tower-5810>
References: <20240614-ls_fman-v1-0-cb33c96dc799@nxp.com>
 <20240614-ls_fman-v1-2-cb33c96dc799@nxp.com>
 <a71bf75f-8c2c-44cc-baeb-3feabd1757b9@kernel.org>
 <ZnB+HtkEh1r8EKG7@lizhi-Precision-Tower-5810>
 <fc8a117d-9723-44fe-afa3-f1a5af37a1a6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc8a117d-9723-44fe-afa3-f1a5af37a1a6@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4a3561-d87e-4348-30a0-08dc8fda30f0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230037|7416011|52116011|376011|366013|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?9ZgCDk2Amw98BW8RsbpqLpYtnSVxg+KrhEEzRL7XFoPI5S1eVsOU+0UMO09I?=
 =?us-ascii?Q?VUf0GsUKbDC+UifP3v1lC9F9kNDWaFjjSFdlBlLqz/OB6gH1yjEH9Na9R+Bz?=
 =?us-ascii?Q?11E68uFrtn77es0T9r0asqGjBGg1YqGNfPEmRLejjyVFOMwnQdNSNa+S8nPY?=
 =?us-ascii?Q?p1CzrU8uaKBG7W3lJWszyxB1kJqimhPlEZV6NegVBnBnN2ve73sY2XY8B7iI?=
 =?us-ascii?Q?bVUn1C6YXy5y7y8MR07x/gqCYv/gNrvCfOW+yUmvk4CeGaj+2MR2mm3nYmVe?=
 =?us-ascii?Q?+VLSIMkdkG8ITHcriiB3zIIb4Z60xxWPiDPqXkTtiOQNHvAs6of78lxLSeeu?=
 =?us-ascii?Q?vPqH27G3VsNdfJBBY4mZX7179pIRtYZ++XDHIcIXGX0FD+qgaXHBkqeAz5iV?=
 =?us-ascii?Q?jhPtjNOzNK9fEu4qJpj1A9hjByb35Rw9gWx/7wbbGNCyA7XqNNBGtQ0yvHG5?=
 =?us-ascii?Q?DqDHff5TFjwFpkIftYTuuhb5ZOnHgdT+SpB+MYbi3u5x9rvHrfTQ8KQkkU2a?=
 =?us-ascii?Q?M8OcmFL977MnxuZE20toEE7ZW4EFiJXCFyF/6fsBSW0RLU3yd8IlC+yLmtPZ?=
 =?us-ascii?Q?rzhGe+W73nyCKEgNRNH1VIF0IO9Ea7QB2b0UHRteMcE2xr9wOXyuGBL7evHt?=
 =?us-ascii?Q?ZgWCS6NHV2UiYtRwLRY787hM1Bl6kxJFu1h7leFdRndhPQZZcsh+w5XFp/yv?=
 =?us-ascii?Q?Aov70jgxuhMtWHqt/0wj1OXNmEVK/nUsClMijWZNNIwX0kcMf2u+uT42hBdg?=
 =?us-ascii?Q?XKpjdFp8tjaRRP+ZXwZ/xvQ/myqledFhG0KbZSiAF19XpagOkzgGsfqf2aTF?=
 =?us-ascii?Q?EjF1PG5XUhD5d7gyGCDma+9an/VQ1Fj9KgccQ6RuuP2L0tdYJ923x2InK3bk?=
 =?us-ascii?Q?3uIrg1Up6RjMmz3RyjU0ndggW2tOxytKVy4sPJsFre13v8h3fd3GMM0GHPHJ?=
 =?us-ascii?Q?HRTAwswGJ/LdZmgmduQrB5IbR64za3/QRV81wKTWzVTJIcIQMzJKZeh36lkI?=
 =?us-ascii?Q?YQXSKWYnJKj/PEO+GURpgkL8fGScAykY1Pu7a+yza+aa47BMhS13/6qjc7A7?=
 =?us-ascii?Q?flo10IxPunyeGzz/f+9w/1Dy4lU+NGljS+n2tNQLBZpibHTJAQPzLRu+QitG?=
 =?us-ascii?Q?R0ic9UW9570+OY3RQ5gH3AbBrjyCsht+2QfGpPWZtiVxkUo8WQ0wEXdD6Tsy?=
 =?us-ascii?Q?oYkdBQNjtFbX9nlEe1Rpxq76Ypt9FHd2on5m+HtpHvoPXcmT4Cdn7Z3zDJys?=
 =?us-ascii?Q?BPxxb2ctAAYeDydbcnKlhx5WUqY4VzKNJmy2q0/26z+zsQKI+6SG8t2xVXze?=
 =?us-ascii?Q?fBZmq11YCO7+dhorpd6GfBY25o3Dpu3SPjZsWZIkR5lAkzarujGFiX7s4i+f?=
 =?us-ascii?Q?fLvJnk8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(52116011)(376011)(366013)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?yQfsS/4s8dU2m99NyCikHL0a2ld7sgr5bom5jdDJsZr70u7tFVgojDchgIhI?=
 =?us-ascii?Q?Vrr/5obQxUh+qzP10OVR8gSFfIzGUfCl1Tw0Z05dLYJHIsRyBaQw07TOaJKW?=
 =?us-ascii?Q?BVpjP+4/0dXuJnTtcNpY/ucnH9T6xRSRg+Ero9WV9npraxewOB06K/9hXB0o?=
 =?us-ascii?Q?76kPAd+nKZfgY75OuT105ETvGFEfnnN+BAvt0IVCjfxciXd189X8y6GARiWH?=
 =?us-ascii?Q?ISysKgfm+pG2YTQtSkweQsQklIL5EtsYIKJYYEbKzFWHvOF+BrC/JZkmwzC4?=
 =?us-ascii?Q?VhBQ0pSsLpH/Wl2AuBpNsUP2PHAxs+l6vbSPESLS/iSXYvNXhYts7PoTe2HL?=
 =?us-ascii?Q?RpvugmMYbR5xsIpeJvVaBFk0S04obrhoDzcIQjkSyG2a3FxRMxTNaEtNWP5g?=
 =?us-ascii?Q?o1okrzNtloKNSqTEgFmAaXTTngvtCaZVJEHXKLc4rc0SVLOWC7zaO0cTL/ay?=
 =?us-ascii?Q?+516x6keRxXzOx8oeAEciSIskKS9ldMkSEpFXfF/xOGZ85DmRCKt/SXhrn/6?=
 =?us-ascii?Q?c0poMAA97XMOpPbUvJaL96ZOWFVgrKgH1d2Brn7pMogcUASaNI2hBbJM1euP?=
 =?us-ascii?Q?as/W5wGbl9L4g4L5UYBM2nA2zI0Ew+e21tURFmbB630+lAxjXCpldnOEF0oL?=
 =?us-ascii?Q?phsG1Lu872sVMk6J2iMww8ApjTG8HNUtxxFhZorW6ML5w50U7Vo/IXs16exA?=
 =?us-ascii?Q?L4yXYu7zay/di2YYyqGGQFA91w3KlSoMF5phmHZpQ85DLYsqDpnFKPdFR66f?=
 =?us-ascii?Q?/DWxobevvaYx+61B4DBTOvjRTSqPhvMf0IjCsvBXdkMVqxFQKBW45tqYsp8z?=
 =?us-ascii?Q?+qc1+j7xuLf6p2bPYNQkf82MBYDDP/WUQSrAAxr4TTQicP5Oub2pCEtCCtCe?=
 =?us-ascii?Q?leuIJqRzq+F2p8uhBczpDUUOUXeuzax+nygOKmsfHrXFN2XxAXnVcSK/hc+D?=
 =?us-ascii?Q?VBEcvF+UdMz2od4T2bob1WtPrNqSkptF3FTFECivgIr5D0L74YrUSAkRmxe4?=
 =?us-ascii?Q?I0r+6S7sSsuzMcAXcDNyTnblenl0MLUG79k0MU4SA0Rnfwg46r3PwitIS0qS?=
 =?us-ascii?Q?6xw//aqd0cMLi+kMqw5pMHipCaiWoEEG43YRMBz7i78s/kuJlCAuekuOHlkJ?=
 =?us-ascii?Q?G9N0KuYgvWWimACyNwTfN8EgW6eO+Gmu+vGMKThyNorbWbFdVxiyg/1fYghT?=
 =?us-ascii?Q?+59AKx2sMHTZEj+1v1PnhQDWbXtBDhdHlSkEC0lnnf3ebq1+n33LraO3rZ6v?=
 =?us-ascii?Q?UmiE+ZWu0Ioy4QUAlPFQErTmhHAOn3zYwv/p1xSziP52zdPxeUoh9x5o6iio?=
 =?us-ascii?Q?2gSb4vFNzzu5804Te90UCUqCSvQvhxqdY5C0/LQt7Lr+RsxfHbLg2rYs9ADq?=
 =?us-ascii?Q?qUzEcpdLVS5/bDdafHdR0CzHWBKmemr6GspevAuIvMAtpRFFuijb9oJEpUXR?=
 =?us-ascii?Q?TiDUn2Snw+H8tcnvja7NvzBOKalq+kQfJDubja9IG3FUFLQzbX4TfRhFDWoD?=
 =?us-ascii?Q?8CTWVLZKt94ixcjCgbnx9gKrHKTghhO7EdXb1E6M9ZhxR6yk9WIlaPtyIdcw?=
 =?us-ascii?Q?7hp/3+aD4PqvtodGoRo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4a3561-d87e-4348-30a0-08dc8fda30f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:04:06.7700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hq1rthJIH5l2iDfR5RQhM9Zt9D5UB6jUOxiayxY5Gy9CRSfTFgfxxgTVY9jFTzL4X9u9t6WV/T6yBtERVohPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7479

On Tue, Jun 18, 2024 at 08:18:41AM +0200, Krzysztof Kozlowski wrote:
> On 17/06/2024 20:19, Frank Li wrote:
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  ranges: true
> >>
> >> That's odd. Why do you need ranges without children?
> > 
> > It think it is legacy method in driver.
> > 
> > 	muram_node = of_find_matching_node(fm_node, fman_muram_match);                              
> >         if (!muram_node) {                                                                          
> >                 err = -EINVAL;                                                                      
> >                 dev_err(&of_dev->dev, "%s: could not find MURAM node\n",                            
> >                         __func__);                                                                  
> >                 goto fman_free;                                                                     
> >         }                                                                                           
> >                                                                                                     
> >         err = of_address_to_resource(muram_node, 0,                                                 
> >                                      &fman->dts_params.muram_res);                                  
> >         if (err) {                                                                                  
> >                 of_node_put(muram_node);                                                            
> >                 dev_err(&of_dev->dev, "%s: of_address_to_resource() = %d\n",                        
> >                         __func__, err);                                                             
> >                 goto fman_free;                                                                     
> >         }  
> 
> And how is this related to ranges?

You are right. Old document is wrong. Thanks.

Frank

> 
> >>
> 
> Best regards,
> Krzysztof
> 

