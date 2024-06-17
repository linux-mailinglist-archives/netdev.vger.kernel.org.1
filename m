Return-Path: <netdev+bounces-104224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D32490B992
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935511C23D08
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696BD198827;
	Mon, 17 Jun 2024 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BSCpqgOA"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D9195979;
	Mon, 17 Jun 2024 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648367; cv=fail; b=e0tPRIEMOC7EvVDL5+uLRKQcEAPHsabtV1hykzRVbVcGWchTy76xYM9nQEc52GIU8NwJvE8Lgcrj4fbR5Hq9E+JYEnlzFaT8ibB+5x3uH7GsDRnJrkIZAkJkTwNWeMiThZX71m60FVdblVn1PLjPy379BxQ9ZUwYgtvR2yqGDDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648367; c=relaxed/simple;
	bh=zK6aMc00nz3Rf2wXy0KW8Hr3UpzQ0Lv3laH4CMBN95I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oX/12GCa9qRxvHNcCr//EDGfZxFXNIAtPlymxhrGL5pL95+yU3I38nCClHNC/Z/U6B6O80oo1S9jn7T7id4PNVuyxDterW8hy97MewePDpLqIVNUj7qONId45SUVA6uZTaf9KSBligyaIC7twP2GS4FGI8A0epvhYjm0/8IdKfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BSCpqgOA; arc=fail smtp.client-ip=40.107.8.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwV7WXSpnKrMd0/d9P7otylNVel0j8F4Vex0fKjtP9Iae9EsipJ4CZNOuBozffcO5XCop5rDGRZ2jPU5WDPHbV9J1GEu+lcGMjke32Ss0DMX38KjOvgm3T02Ksxl9nMtCBoEb32NF4tU2uyCjNLHblgz1XVaHfcVurpmtwdWlRMiCU9EiKQJlDS9Orz1fzYmq7t6LmZYf6g8AVOKbwdcKPKlzQ5ipYyOfrlOMrm2H1vHSAJrSoMu8KsI02bwxO/YsBIvO863+2WiqNAFVdUcEsqvsOjOFTMDtyfU6K9ArIQluccM0vhddMqEgdz59xkaEtZStLbtfh1uONfxDmiolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqPQ7eeeUzI4XKG8TkulFmkM5ke3h7/OKIs+6orcryY=;
 b=OXofzu7lOBW57Wrf6e1jDVzLiEVObV5Ei3dx2safdFn1ZZZuPnLb/8tQuK8grUfVYO3X40HwZcWYqS0AjpvHy6Bb2VFiKmtTTqVfxYX/NNJy1cQoXrAyghgaLRDLJP5cW+Rtr7olbN92+P9a2qfPtQcMoFHf/Tf6Gr4flj5+MubWKHKNKO20HSKoCoomvZLrD9ab2QS5NCcHYeVtABT00+r2hs2hlnmPjbmOh9POou0maaJi2MiIRVo/ju+lP9VCTXEpRhJavHJaL3LNsUtJ2w20hZEpUsqGbSFWFhlDns8vd5pOSDwepn1s2Ehw3LBUjDYdrUXR9/efox0EZVKlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqPQ7eeeUzI4XKG8TkulFmkM5ke3h7/OKIs+6orcryY=;
 b=BSCpqgOAjoSz6htiMYhsGtD/hpZGQn+OLsKHZ1RbTYWmYZ0n47KgP4Ib1CGvUHvf8MNYU+sf4duWC4gsHXi2k+Ux/yM/IHc7YUsgFFsfyxakSv5MGEl1SeL0LQLB0lj0H7RprR6gQqUjo6zkDbgAx4teigwdEoZCpuU8O4XC04I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11083.eurprd04.prod.outlook.com (2603:10a6:102:484::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 18:19:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 18:19:20 +0000
Date: Mon, 17 Jun 2024 14:19:10 -0400
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
Message-ID: <ZnB+HtkEh1r8EKG7@lizhi-Precision-Tower-5810>
References: <20240614-ls_fman-v1-0-cb33c96dc799@nxp.com>
 <20240614-ls_fman-v1-2-cb33c96dc799@nxp.com>
 <a71bf75f-8c2c-44cc-baeb-3feabd1757b9@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71bf75f-8c2c-44cc-baeb-3feabd1757b9@kernel.org>
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11083:EE_
X-MS-Office365-Filtering-Correlation-Id: 6585d15a-4377-4d82-f532-08dc8efa0183
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230037|7416011|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?mwyt9zDsBwmnsZIEw6gkzkHhaGde8N+FzmuxgUBe1QgfpykSOmx3+QBPITMp?=
 =?us-ascii?Q?mNqzhaK3bzWXzYu5n/Ax4RAk+4C4S9GRCodCbiLP8Mt/1v+KOdj0MOHXzbDp?=
 =?us-ascii?Q?7fS6hKiPFuUcFXTPWuJ9ga0qLtMmYpl4L6IRRveLDTSGgyWEdDN50N32H3Vt?=
 =?us-ascii?Q?fWGud2FSWrhULxJ2N0dih3Us9EVO16hOU25HWhIo3qy0PMc0MaJq65hMTzHu?=
 =?us-ascii?Q?CtYIk7x82yiy7S6dF1xq+R6vf/Ptt+rUcBvVxRdMCFrMcGw3mUkc5NrzI1ss?=
 =?us-ascii?Q?kuV00XR21dBuLqGl7yacdB7+WAPPJQ1K5hYqtSeYObyl/M/2PeYWCKCV1Zdi?=
 =?us-ascii?Q?zZ8x1UPtJ9mrD3ui6Gp7Z26j3KDYQ8GKf35pumvGSU+d39jfiKsRXc6VQoq1?=
 =?us-ascii?Q?kORUqxuzpi6OGgqWTzM37o6p+uqwhi9WqOjtG7oT7LY/GBI70rs92Nxm/ND1?=
 =?us-ascii?Q?Sm7jKn7edf7goOq3VHeXPZ8coWzQQIUjCDL6SP9CoWTl9k/eCzLXftmta8DJ?=
 =?us-ascii?Q?BG4cfDPWtl+sVSBHGX5wm4uIs7WH3391sm+uefaTlCDh8gVgfnO6FtCR9srN?=
 =?us-ascii?Q?kry+7RoBQ7Ao4I22dIo244XSLYQ5rAfpUM0Ebt+ShqFpSM+eiQgnTiAJvOBU?=
 =?us-ascii?Q?zzCMZsKrCnIZ8muWaPIENg6tXccfhTKFVwNw99t7FOk0FOrwpcGQmYOS9eAK?=
 =?us-ascii?Q?ZPEmvpZioz3+dEAI41HUwdXffnw3SFpyGC+SWk72U1JTE0b0kzjXx6+GMH9V?=
 =?us-ascii?Q?mMniplzjOqnwMiOqBipoT2jGg0EVItNnV6DmNUipisRtdNlDEV/9xx5l7mG6?=
 =?us-ascii?Q?5L/pdJ4flH51t0jEOdRLQDfCvQpw8zr+WlJV+xfNolGsaz8Y5w7K8eWH21Vd?=
 =?us-ascii?Q?OUSpm0SG1or97zBA0tUXw711NFwc8kGEDlkz368dl2Ft8LU85LDkcyh9hUP5?=
 =?us-ascii?Q?QmTsCWz6NAj/6o6P6APaqlPZIm2zNjwwTt8czqNTO133cNNX33UZW/4kTrD2?=
 =?us-ascii?Q?MPsRFXs90ZULpeAutTO8KUGcubScmNWf6Dhw9yMF6C1w6tPTvaxhG07cE5M4?=
 =?us-ascii?Q?AzE+wfOciXXposvsG0QJDOzXO+bC+BO9YuaUPbIktMfPCpjQcsQ8ZaMiM3Me?=
 =?us-ascii?Q?9Cc9GtpoYa5sWYtWBYXAWBPMOUXNIn780MIf+LyE4/qGP8/wqG/NwDKKp4LX?=
 =?us-ascii?Q?p+Dmny9leHq+98+TkhDD5nESbCBmh7q8JokvXtc8ilFX8YplsXxSLCVjWf+X?=
 =?us-ascii?Q?pAgzz33c4pZEVZe/8Z8WAq3kUWkZKWF/5gqmkz88mm9ncto/mpp4xCEOkZVu?=
 =?us-ascii?Q?4p4Fq7CYB0M1ZEXvL/bPmhDz?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?JpFyGmjqfkege4+lYEjk1gXRDbtyxQSK+G+j7rCn9wBYt90ySowmAoOCpB1H?=
 =?us-ascii?Q?q0OxwhJ1MyiaZ/T8XQYGM5zUOx6Rc1+FJISs4eoMtxOFMEK7i05b6lEAy0JL?=
 =?us-ascii?Q?7TJZ/P5hH8ETKYKlxg3s3ndWmAkMTfnFiGPsMxps65ow4/OZZzGFVgidBhDx?=
 =?us-ascii?Q?dZa3/LHcqBWrhsQKCLQF4j3m7GCldOQo5uHniWAglLZ81e7AQb5y9FDlAGgv?=
 =?us-ascii?Q?Kky6z9wobdeudwPt6PMAYoIWzMKADJ4K+bfZrQl6CnQdzKf8Ut+OG9LWYcZO?=
 =?us-ascii?Q?iFy9gmW6l/QO5a8JI/w5KURgd3mA+K0ZWrV+pEkewpAQZroG6JQBduWavxvV?=
 =?us-ascii?Q?Dj87hAhPtXsA832a2hHXeRoQJLprTVxbkFGvJMTUBD8XPa2kTh81+ZsMk+YV?=
 =?us-ascii?Q?+iegdQQWOyUUggc/eFlnYvZddk/bbeCJQeFVCEfuzamztGW/7NzvTozDUL5G?=
 =?us-ascii?Q?NFN7mUkWiQy+fSjXpmjbwCeAv8qPQEzSU6USp/WMgxisMF4jbNO6HFMmr+Je?=
 =?us-ascii?Q?kk6a857/9NitFxUi19FSAEppuy3lVrRuYoUEUa+Adz5bbWkq7c8DKGzHnysi?=
 =?us-ascii?Q?q+umHn/sGk1W/Zdq49SZmlaYgN1tN2+No3YfxmmRi8Y0JNqpqHPcFRIPt1sz?=
 =?us-ascii?Q?WeYOQv8ZF2I5VXyrY6gfimrCrDuKBp1OSKlpVmB9s5NUmZcRon4jwIkDsf1R?=
 =?us-ascii?Q?h9uUNBDc3yvaKDE0XJZCjzwQLECJwO3Mbc9A2E2GyCuA/GAkKoPn7/TtcmCZ?=
 =?us-ascii?Q?J/E5Yoa7QKlKWTo1xbpUDCdjyiou9lRWV198Hn1In5Zt6ja1qIGjh2/UkT5Y?=
 =?us-ascii?Q?gMWTm6WwfwiBywm6yAZOpFNoZ8/2U26qTukYmErh83UVLkZUZ5bHmDwWo7Zw?=
 =?us-ascii?Q?ejjPj3j4pQ/jDD9y6Kdze+fjkP6Ef7oN7uv5emQ4gOd0+amEu5Pbol2jyOxW?=
 =?us-ascii?Q?ZaHMo2Xdin5QSN0mDo7py9vZ32l50Hp8AbbaeJwUtsSnjKLS7uTqmDTu5X8c?=
 =?us-ascii?Q?2kFmzh60vr8zyp9LdrfKG/HYlkWF8Rx0HmxSBuXCUPyn74ZW+WYHS6u59lJ2?=
 =?us-ascii?Q?raoNFzeaSY3ukowtsZ81Avdqw3j802e8N0pXGzXZ10Rzrj0xxFIUgGOATW+k?=
 =?us-ascii?Q?aslPmu28E8TH22R24+B6gpIFnd31NmFcaLn5KEW+VpebDxb8Iw0wo3ZETa63?=
 =?us-ascii?Q?TAPhofIFX5fltTNcVa6Vo0bOBsnj47Zu9z58FtienZj0c4D+vqlS8BVzQ0FL?=
 =?us-ascii?Q?MaoY36QZx79l54QU9yVDwzwx3KeC0dMKycFl0akNeqc5l4kZpg//Su999lu2?=
 =?us-ascii?Q?5Q7t5ivtHIWiNckDtrDILzgtXZWKRmXtbPD1av+LuqP8qg/NMiZeAovbzGOY?=
 =?us-ascii?Q?frepaAdXXu9chyf/1+kq8dxwcgcTZUCBgRdHVlS3CKEZjxbe25hABJqDHxmd?=
 =?us-ascii?Q?YXKhyrIZzu/wSjm1/3uxw7wLfOpIjY6oPzcHzPZdaajUuikJRNrPbRh+DMIZ?=
 =?us-ascii?Q?WnZTqbMWp/lTsOfoDSSVmz344ADjWRnz4XXwY9okRwJkxl7YBSlZisQjNY7b?=
 =?us-ascii?Q?f1pKGzCWOjf2kaNAuLQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6585d15a-4377-4d82-f532-08dc8efa0183
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 18:19:19.9146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+8Fawubmjip9JbyoCooewhtbVlWhCnieakHIbmAPMNN51DJiHMLKbSD8SlemG9uWqfRhwD7grjkrkCgKG5Log==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11083

On Mon, Jun 17, 2024 at 09:14:05AM +0200, Krzysztof Kozlowski wrote:
> On 14/06/2024 22:33, Frank Li wrote:
> > Convert fsl-fman from txt to yaml format and split it fsl,fman.yam,
> > fsl,fman-port.yaml, fsl-muram.yaml, fsl-mdio.yaml.
> 
> 
> > +  clocks:
> > +    items:
> > +      - description: A reference to the input clock of the controller
> > +          from which the MDC frequency is derived.
> > +
> > +  clock-frequency:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Specifies the external MDC frequency, in Hertz, to
> > +      be used. Requires that the input clock is specified in the
> > +      "clocks" property. See also: mdio.yaml.
> 
> Drop entire property. Comes from mdio.yaml.
> 
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  fsl,fman-internal-mdio:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Fman has internal MDIO for internal PCS(Physical
> > +      Coding Sublayer) PHYs and external MDIO for external PHYs.
> > +      The settings and programming routines for internal/external
> > +      MDIO are different. Must be included for internal MDIO.
> > +
> 
> ...
> 
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description: |
> > +  FMan Internal memory - shared between all the FMan modules.
> > +  It contains data structures that are common and written to or read by
> > +  the modules.
> > +
> > +  FMan internal memory is split into the following parts:
> > +    Packet buffering (Tx/Rx FIFOs)
> > +    Frames internal context
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,fman-muram
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  ranges: true
> 
> That's odd. Why do you need ranges without children?

It think it is legacy method in driver.

	muram_node = of_find_matching_node(fm_node, fman_muram_match);                              
        if (!muram_node) {                                                                          
                err = -EINVAL;                                                                      
                dev_err(&of_dev->dev, "%s: could not find MURAM node\n",                            
                        __func__);                                                                  
                goto fman_free;                                                                     
        }                                                                                           
                                                                                                    
        err = of_address_to_resource(muram_node, 0,                                                 
                                     &fman->dts_params.muram_res);                                  
        if (err) {                                                                                  
                of_node_put(muram_node);                                                            
                dev_err(&of_dev->dev, "%s: of_address_to_resource() = %d\n",                        
                        __func__, err);                                                             
                goto fman_free;                                                                     
        }  

> 
> > +
> > +required:
> > +  - compatible
> > +  - ranges
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    muram@0 {
> > +        compatible = "fsl,fman-muram";
> > +        ranges = <0 0x000000 0x0 0x28000>;
> > +    };
> 
> 
> > diff --git a/Documentation/devicetree/bindings/net/fsl,fman-port.yaml b/Documentation/devicetree/bindings/net/fsl,fman-port.yaml
> > new file mode 100644
> > index 0000000000000..7e69cf02bd024
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/fsl,fman-port.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/fsl,fman-port.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale Frame Manager Port Device
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description: |
> > +  The Frame Manager (FMan) supports several types of hardware ports:
> > +    Ethernet receiver (RX)
> > +    Ethernet transmitter (TX)
> > +    Offline/Host command (O/H)
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,fman-v2-port-oh
> > +      - fsl,fman-v2-port-rx
> > +      - fsl,fman-v2-port-tx
> > +      - fsl,fman-v3-port-oh
> > +      - fsl,fman-v3-port-rx
> > +      - fsl,fman-v3-port-tx
> > +
> > +  cell-index:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Specifies the hardware port id.
> > +      Each hardware port on the FMan has its own hardware PortID.
> > +      Super set of all hardware Port IDs available at FMan Reference
> > +      Manual under "FMan Hardware Ports in Freescale Devices" table.
> > +
> > +      Each hardware port is assigned a 4KB, port-specific page in
> > +      the FMan hardware port memory region (which is part of the
> > +      FMan memory map). The first 4 KB in the FMan hardware ports
> > +      memory region is used for what are called common registers.
> > +      The subsequent 63 4KB pages are allocated to the hardware
> > +      ports.
> > +      The page of a specific port is determined by the cell-index.
> > +
> > +  reg:
> > +    items:
> > +      - description: There is one reg region describing the port
> > +          configuration registers.
> > +
> > +  fsl,fman-10g-port:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: The default port rate is 1G.
> > +      If this property exists, the port is s 10G port.
> > +
> > +  fsl,fman-best-effort-port:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: The default port rate is 1G.
> > +      Can be defined only if 10G-support is set.
> > +      This property marks a best-effort 10G port (10G port that
> > +      may not be capable of line rate).
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - cell-index
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    port@a8000 {
> > +        compatible = "fsl,fman-v2-port-tx";
> > +        reg = <0xa8000 0x1000>;
> > +        cell-index = <0x28>;
> > +    };
> 
> Just keep one example.
> 
> > +
> > +    port@88000 {
> > +        cell-index = <0x8>;
> > +        compatible = "fsl,fman-v2-port-rx";
> > +        reg = <0x88000 0x1000>;
> > +    };
> > +
> > +    port@81000 {
> > +        cell-index = <0x1>;
> > +        compatible = "fsl,fman-v2-port-oh";
> > +        reg = <0x81000 0x1000>;
> > +    };
> > diff --git a/Documentation/devicetree/bindings/net/fsl,fman.yaml b/Documentation/devicetree/bindings/net/fsl,fman.yaml
> > new file mode 100644
> > index 0000000000000..dfd403f9a7c9d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/fsl,fman.yaml
> > @@ -0,0 +1,335 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/fsl,fman.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale Frame Manager Device
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description:
> > +  Due to the fact that the FMan is an aggregation of sub-engines (ports, MACs,
> > +  etc.) the FMan node will have child nodes for each of them.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,fman
> > +    description:
> > +      FMan version can be determined via FM_IP_REV_1 register in the
> > +      FMan block. The offset is 0xc4 from the beginning of the
> > +      Frame Processing Manager memory map (0xc3000 from the
> > +      beginning of the FMan node).
> > +
> > +  cell-index:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Specifies the index of the FMan unit.
> > +
> > +      The cell-index value may be used by the SoC, to identify the
> > +      FMan unit in the SoC memory map. In the table below,
> > +      there's a description of the cell-index use in each SoC:
> > +
> > +      - P1023:
> > +      register[bit]      FMan unit  cell-index
> > +      ============================================================
> > +      DEVDISR[1]      1    0
> > +
> > +      - P2041, P3041, P4080 P5020, P5040:
> > +      register[bit]      FMan unit  cell-index
> > +      ============================================================
> > +      DCFG_DEVDISR2[6]    1    0
> > +      DCFG_DEVDISR2[14]    2    1
> > +        (Second FM available only in P4080 and P5040)
> > +
> > +      - B4860, T1040, T2080, T4240:
> > +      register[bit]      FMan unit  cell-index
> > +      ============================================================
> > +      DCFG_CCSR_DEVDISR2[24]    1    0
> > +      DCFG_CCSR_DEVDISR2[25]    2    1
> > +        (Second FM available only in T4240)
> > +
> > +      DEVDISR, DCFG_DEVDISR2 and DCFG_CCSR_DEVDISR2 are located in
> > +      the specific SoC "Device Configuration/Pin Control" Memory
> > +      Map.
> > +
> > +  reg:
> > +    items:
> > +      - description: BMI configuration registers.
> > +      - description: QMI configuration registers.
> > +      - description: DMA configuration registers.
> > +      - description: FPM configuration registers.
> > +      - description: FMan controller configuration registers.
> > +    minItems: 1
> > +
> > +  ranges: true
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: fmanclk
> > +
> > +  interrupts:
> > +    items:
> > +      - description: The first element is associated with the event interrupts.
> > +      - description: the second element is associated with the error interrupts.
> > +
> > +  fsl,qman-channel-range:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description:
> > +      Specifies the range of the available dedicated
> > +      channels in the FMan. The first cell specifies the beginning
> > +      of the range and the second cell specifies the number of
> > +      channels
> > +    items:
> > +      - description: The first cell specifies the beginning of the range.
> > +      - description: |
> > +          The second cell specifies the number of channels.
> > +          Further information available at:
> > +          "Work Queue (WQ) Channel Assignments in the QMan" section
> > +          in DPAA Reference Manual.
> > +
> > +  fsl,qman:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: See soc/fsl/qman.txt
> > +
> > +  fsl,bman:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: See soc/fsl/bman.txt
> > +
> > +  fsl,erratum-a050385:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: A boolean property. Indicates the presence of the
> > +      erratum A050385 which indicates that DMA transactions that are
> > +      split can result in a FMan lock.
> > +
> > +  "#address-cells": true
> > +
> > +  "#size-cells": true
> 
> Make both const.
> 
> > +
> > +patternProperties:
> > +  '^muram@[a-f0-9]+$':
> > +    $ref: fsl,fman-muram.yaml
> > +
> > +  '^port@[a-f0-9]+$':
> > +    $ref: fsl,fman-port.yaml
> > +
> > +  '^ethernet@[a-f0-9]+$':
> > +    $ref: fsl,fman-dtsec.yaml
> > +
> > +  '^mdio@[a-f0-9]+$':
> > +    $ref: fsl,fman-mdio.yaml
> > +
> > +  '^ptp\-timer@[a-f0-9]+$':
> > +    $ref: /schemas/ptp/ptp-qoriq.yaml
> > +
> > +required:
> > +  - compatible
> > +  - cell-index
> > +  - reg
> > +  - ranges
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - fsl,qman-channel-range
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    fman@400000 {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        cell-index = <1>;
> > +        compatible = "fsl,fman";
> 
> Compatible is always the first property. reg follows, third ranges.
> 
> > +        ranges = <0 0x400000 0x100000>;
> > +        reg = <0x400000 0x100000>;
> > +        clocks = <&fman_clk>;
> > +        clock-names = "fmanclk";
> > +        interrupts = <96 2>,
> > +                     <16 2>;
> 
> Use proper defines for flags.
> 
> 
> 
> Best regards,
> Krzysztof
> 

