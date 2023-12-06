Return-Path: <netdev+bounces-54410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965E7806FFA
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88D11C20BED
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD962D7AD;
	Wed,  6 Dec 2023 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VxRomwY8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3065611F
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:39:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoBKrppEOr2gWgcUahz117Tv0C0Hf/b7RXtc0OfVTerqfLIk7dyIG9ScXIe1wUYMNtPOnFr571q3QC0YENS1x+utD4G1bop4ly/BfUUflRPpDHdcleE3ErvNU/PgAIAt4PnHnHYEQD3Tiu5Pd05jrEotSl/gyZ1XDFvX17GCBYUBX/IBtA9am2nulDvmR864AK6d5qEwtSZ1QUAH7H4Jb3G1ceSD41060xjFnBTGkVFhrL4QGajaIDk3e9WZA6xqfWhaIFnzP8BsCJbYD/iO2ku+D83DPQkaUeuQYXqtvsBbG3RNKi8erVkQcC52K6m4cT98y8g1Bc0QFstEuQjngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiIQGPO1OK9ONCUH44UBuPNd80+7hZ2bzSeSxKWcmjA=;
 b=IFG9beyb+lwE/zayRhrWZFtD2LrU1bT0d+Z+7uZsDdv42+/Ohk27v+Ejf2Qdgm8roKKQGlatdurd1Ap0QPTmlzGLW72k+oF193APItTXGoV/TUcPFL3Im1JKtVyzkZ1R5QkmVhZ87C0Cq3PW4U1FgoyVaI9YRMG1ToLxsHfk0afaHbz5xBsq8rw49/KKE9w4xc8Ek/32ix6oPq5ZATaTEP1GeBSD/6rqJtF51Ts69P8+Eo4F1xL8M8h9zqJ+WAAlnuehmfuQcQgEQzv9P9emxFcPMstLQi8VvLVC3w21SiMDlkKkojqhTbUtYqnTLWqmGXqK5qnjSGL9sS5ymOy4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiIQGPO1OK9ONCUH44UBuPNd80+7hZ2bzSeSxKWcmjA=;
 b=VxRomwY8s0ix/zbx7O7KZprtNZ44jahQbHKo+iEshylA9kIZ33DmcyCMELREM1cVMbVaIEOBgALhtjxrBJsAUKz3TrA3ekPdSHj/YLG4S1CmYfKrAmRIVtDbE1UDsa7vorUQtprEHO3b1FUYb6oY+lPSUprnZAajD7NqAP5+KNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM9PR04MB8649.eurprd04.prod.outlook.com (2603:10a6:20b:43c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 12:39:35 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 12:39:34 +0000
Date: Wed, 6 Dec 2023 14:39:32 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net] dpaa2-switch: fix size of the dma_unmap
Message-ID: <fqvqnvzkzzwsqjyofhhaf3t3252v6bxtgk5ypunii2fannyp27@tfy2aydldudo>
References: <20231204142156.1631060-1-ioana.ciornei@nxp.com>
 <b33f982180788cd6b68fa1cd4af40ad6f65cb905.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b33f982180788cd6b68fa1cd4af40ad6f65cb905.camel@redhat.com>
X-ClientProxiedBy: AS4P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::15) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM9PR04MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ac32f6-53b0-47b9-3fb4-08dbf65866f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eWcnUZNK4c6NNdcfmITo7GjyYXHdDO9yvmJ44xGIJCULMvuo0lk5LO5C4oXl0tCLAGLnOfP0VXZVm5okYkuarOsobnn6db5+DJ5gyJyylXAwGsN2KUNiL08ovECsghf0Nil+jpDh+ueIz2NK6cf8Bc0GjdvVNiw/vSPPRvBeIfRj0wU5xMPwIvaoHB6iGOmQSW362rU6RyzdX8Kso0/FxWYoIdfWEPE4YfhnWva2XxFODdt0tECQ7MlWZKaKA+ewxYTe3aASRJ+NNBftN3VZA4LAsNuTAbGIOuc7+6euQUj4ORq2pklC6pILasOSdyoPheRGBVL4qGjyEgijoZmthc974IwYH6S+7dEPOf5nTwf0r5NUxrvWSF4ONcryCb9zBKxPhMOiLpyAF5SV1hf0pFThwDaBb1k74Cj5xO4ex2rAwnDNh18JzaR1hxW2A0zP4vIluxHioBYvQXTRV4P1h4uDPga4bXtg1gseWUWkQjhvWNy1spMnBEyTe5ELBziRb9Vdtze5UmH61/lnfst3RD/VKVlh8Kxc4xff4p8HxZRooYjUJvSPs5j3hlzBjSyz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6916009)(5660300002)(66556008)(66476007)(66946007)(478600001)(44832011)(2906002)(6486002)(8676002)(4326008)(8936002)(316002)(6506007)(6512007)(9686003)(26005)(41300700001)(83380400001)(33716001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SnXEjknWVBAt4O2TDcym4NmmRVLqedQ3kAEk/K/MhsrsxU6Z6ARoJv5D3bBe?=
 =?us-ascii?Q?jZppH7qvfO8yjA+ko0X84qgUFnNod/gXUCR/X/eBHSzAgVFycW6HU+fd3vmI?=
 =?us-ascii?Q?OWHimv/6RfzsqcOkW5SjHfKGd1FaAF2bJPQElxPdjngWUj/pi6xuYRrSrwPh?=
 =?us-ascii?Q?wCnV39EXKm8JEApUvt30kfvd0wPGiub7Y75lvkfoWy/j61suTCZJlJ4y9KIH?=
 =?us-ascii?Q?Rnas3vU6LM2EnLllDonWtnqcQVuGcDnqEG4gqy3OaZtlml1xZFESvqCI+edh?=
 =?us-ascii?Q?OEFGyRR+VyL5KguUrYm4Lu44eGdxnoL5pyEihO2GBCDb99IixxITcDWegtYN?=
 =?us-ascii?Q?y/mcmUiwcRHcfptSc5q/nRZxvKXTtFMGon9HMgtUf0GdD3w+eyC8Nc8ADLtt?=
 =?us-ascii?Q?KfqdfDCaVovSbkV8U2YWLaMuHAojbqf/Ay8yPznypPlOuBIyhRxj3nrVm+BA?=
 =?us-ascii?Q?mdzkDxErpNG0qapH1FUnGpZlo7RhRVYxqfsM5Cqvrwo5BaTv0g2p/GHh67g5?=
 =?us-ascii?Q?6adcQJWyGVAUOjw4bUD+oCn+Znq8P5bD3hP+e/U3aUcBxC1Ylo6fT8uWPMw/?=
 =?us-ascii?Q?e6RE67iKWq/pmWUIoi02OCKJKBRp972sk7Rd/PIKD9zcuaI+WhWxjC05D+JN?=
 =?us-ascii?Q?oy8Kw1K5kjwiIbB2QEG2ADtwhOw40WU1W9N4Vl5o/9huQlQf7LHTqd6EH0bA?=
 =?us-ascii?Q?QuOuMH+iTQ+TCJkhed8jowklScS4LIJce5J5RTt6CUiqTJqKbGCxsx41Wyde?=
 =?us-ascii?Q?jmL6lQ8pAag27YVGu0ToDcznh+KYicyIzGbfD3X2iD3jXvYAUZluQWfjrikT?=
 =?us-ascii?Q?38Ds7vOZECa3BJYp0Ygzc2RMrVYouX7n8d8bZtMLxxNaRJJOTiXCWZlq14su?=
 =?us-ascii?Q?m6oVrSOGAsTIrTejeHQ/w9OCRx8X7QLknvlPWTOm7IrbqyW0ZLu1j1rSIJmd?=
 =?us-ascii?Q?RErG98Ymxdv1Kj0mTlgb0FCYkNxPU7Cl4aPMlkiYAjFE4WS7MDI1qC3aSDHh?=
 =?us-ascii?Q?VQ/MKl1TR5MWNd3s88RTYZ7PqRnfb5AqD0gem3zg7oKNv3eSH3gcAbDGPt4O?=
 =?us-ascii?Q?MrRUpHytu0NYfeLnalJgoM+ml2+cd6hr5qNGSE/nLRR9qMaCkZcYwmw2vNAt?=
 =?us-ascii?Q?/0gxSellPh2HYMsD69n1F7YW/L3jJIxtvfABG6asCOETQCe4kaUQLs4u15E5?=
 =?us-ascii?Q?xmpuTHQa0T5eRlnRgxLaaJjnrec4W5mCexgy12lbP35ktUt5CG6mpCHH9hML?=
 =?us-ascii?Q?3KE8FGvtssiI/zAeTScmKpE0tbHHhPo8xk0sYLnY8TdorhfwxeZYKepB3AQr?=
 =?us-ascii?Q?yYmUJ7M/It8k50ytx0ODdXzi3SsZY8F8VrT7nNcV3zLLrl6BpL0pavxXQTy5?=
 =?us-ascii?Q?jnIsSa0EftDwWfAtAqHisctfgDb+NaeMHaNe3bbn8tXkqiOo91qR9KsG8cVB?=
 =?us-ascii?Q?4tL6vji7CwfcSKxXKYBCHU/N+oYIFqgeWMz8zkz2BX+BCdDdbhi1b5td7Mzr?=
 =?us-ascii?Q?pG0oOzM6Qzrdz28LLKQkwSupLF1AWFDXiKw1OVmg+05aGh7zZzTRRerYt+B5?=
 =?us-ascii?Q?MlOWkZl4IBdUhhCSAyhMHMAv6RuR36+a523MJpNz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ac32f6-53b0-47b9-3fb4-08dbf65866f1
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 12:39:34.9511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMEGdPEG6g839UW9KixSac098q2ezfGXCq2gAza2hClC+KEFtmuwNvH+G90zvs+1njLjT1uyFL8KafTkfiedtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8649

On Wed, Dec 06, 2023 at 12:04:17PM +0100, Paolo Abeni wrote:
> Hi,
> On Mon, 2023-12-04 at 16:21 +0200, Ioana Ciornei wrote:
> > The size of the DMA unmap was wrongly put as a sizeof of a pointer.
> > Change the value of the DMA unmap to be the actual macro used for the
> > allocation and the DMA map.
> > 
> > Fixes: 1110318d83e8 ("dpaa2-switch: add tc flower hardware offload on ingress traffic")
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
> > index 4798fb7fe35d..609dfde0a64a 100644
> > --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
> > +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
> > @@ -139,7 +139,8 @@ int dpaa2_switch_acl_entry_add(struct dpaa2_switch_filter_block *filter_block,
> >  	err = dpsw_acl_add_entry(ethsw->mc_io, 0, ethsw->dpsw_handle,
> >  				 filter_block->acl_id, acl_entry_cfg);
> >  
> > -	dma_unmap_single(dev, acl_entry_cfg->key_iova, sizeof(cmd_buff),
> > +	dma_unmap_single(dev, acl_entry_cfg->key_iova,
> > +			 DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE,
> >  			 DMA_TO_DEVICE);
> 
> I see a similar unmap in dpaa2_switch_acl_entry_remove() that looks
> like being affect by the same issue. Why a similar change is not needed
> there?
> 

My bad, it's needed there also.

Thanks!
Ioana

