Return-Path: <netdev+bounces-23265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD8876B73F
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEB61C20F3D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F44E26B01;
	Tue,  1 Aug 2023 14:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F040222EF9
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:19:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C973F125
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690899567; x=1722435567;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L+29cfNJn6mt/0AAofblQsg1VJMoIoW/pDN45mlo1yg=;
  b=OiL4gdRHokgXr+bKIhmFlHhVGd0r5FWRcAqAOTX9mj1oYO6yHDBb3cNt
   c1viMa40VwP9GSGPCmuyRGn2REGK2Bf1rE4NRiF93doIwd2JwJDE4cHnu
   5m2I9WQ4+y9bv+RwIHB4djoNW/UR59cjZgK3jcE7SMzYsyMwKP7O4WfF5
   pRHnxbA64zbuV386hwIf8H11i7AuOG+FrK/1vqz7+cqRVOcDwicio/E+G
   Q3Lmp0XZNd8khPKavC3GjWzI3PFlkKRt4DNux7EtWvhnIDkHG+heY2eYB
   Q7K9SW241KnXi0RvrRZE0tbmTYgdserlDwe01funhfie2Zy/vs9wjDz5M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="433147507"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="433147507"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 07:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="732001631"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="732001631"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2023 07:14:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 07:14:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 07:14:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 07:14:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 07:14:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZmjVZ5N23MdZeRkwLMjzTUPYwCF/E/gGKTkhywHdjJPZ5aUgWv3kwhvMC2k/pC0FEzXJxz1RCJfsCerFV/rKOKiu3jgM/PdCfFS/iEJRaE3YYqx9Ylwrg9tNVXsBitoeF7brS+tsu4DSjvaT/vpKvmPsvKlRrqVfLnPDe5VGu8v6hzxUHXD10pH00QEEutOKbDdmzQOtPU7SIII/1ho/NYmlejKsj8+IVVExmpEbrEeMGLNP+LEg5mVQuZgwgXx3re1vyH06oSAxfH9uSQdm3i0K0rKjx6PKdyauF7YykAviSuJMaFfvBh/7srGVGbscIt8hrNzwB8A0Yi9bz4nYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjSx94ji7ds/KzfWO0FxeEd+9RvEKT70e99A4joAz1c=;
 b=AA9FyNoAsJgzC1qIzOPYhiWVuhTl1tHcAlgXbfD/zNPAfm5yo9BuMA/K9JBmkOWJFECFUwPWFpZ3TsB4Z7Pnb2KwGnBUAP1jvG3sSBHWA5F6QUzrvz2JyBvQOmVid1ocjyM8YaJ2pL5Vc4VkKxuB7RYaQv2dnRnrnTnhXZge3AqvmpxIyan4JXtZHPVf1DQbNhmIc6R5lUuFKf08Qm1M9cv/NT8Lncw9kRDCVa38i6E6+jdOLKSkLu5fx4j8P6VF2yAOEnD1OWgvq0wSyJWIUHdIx6JcOExPENEyRfRTXzBokIDWsUcVXYdtm4N4kmEx0b07LDUy1iRbjhU2nWMqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MN2PR11MB4613.namprd11.prod.outlook.com (2603:10b6:208:26d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 14:14:27 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6631.026; Tue, 1 Aug 2023
 14:14:26 +0000
Date: Tue, 1 Aug 2023 16:09:37 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Atul Raut <rauji.raut@gmail.com>
CC: Larysa Zaremba <larysa.zaremba@intel.com>, Atul Raut
	<rauji.raut@gmail.com>, <avem@davemloft.net>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <rafal@milecki.pl>,
	<linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH] net/macmace: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <ZMkSIfUEnvYvHyZx@lincoln>
References: <20230730231442.15003-1-rauji.raut@gmail.com>
 <20230731073801.GA87829@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230731073801.GA87829@unreal>
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MN2PR11MB4613:EE_
X-MS-Office365-Filtering-Correlation-Id: c96d3535-1358-437a-cae1-08db92999d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkfQWwD5izbuLWNW3nZjB3eSDynRHn4ngCByHSw/qwmM4tbEOok35PS92Jbw+qt3nZGrV+pG2p9NIjilo5Co0z/rSsgE3TN6XOAUQQC2ulsp+AWYB3IjPJcWvknibXCYqbrindKU+R0NGPJl+92x09pSv/mt/LVtbxRjLi8Ma/x7QPrOcXQ1dqwSs6498ShjMbP8hXjTF5C6kIDzKuYcwJzG6I/lVtGXIIBGW2azL+uLUQDRaqTTNOK6YzVw2quL6bHcWaJSzA5lTudnc/QPE/5qXufcKjzSjOT7TOiSaBArCpZBoNzvuH7hyOblg70i5VZTqfJvQx/tzRAwWOlHbbCS5KZVDYbYD0EIuG9nxokosSsTNOKgYFrbJXc516a7qGI4gN1axG/BgUGgj+VkJnUIDJMY8uIaNYRLW7E+59U5ONd5NBdcCDBRfErAhfIKNzmHjDdTafNGkaPGt9mo35QfpGdcY/WthL5TLi0An881OIUvHJgaq0NxsLXcuoZrvH1W6uhl/Kr/Y4LY8yI7o/Q+3dAP+hFw9rLNaoKq3zc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(8936002)(8676002)(6486002)(41300700001)(33716001)(478600001)(2906002)(6666004)(26005)(44832011)(83380400001)(316002)(186003)(86362001)(6506007)(5660300002)(38100700002)(6512007)(54906003)(9686003)(4326008)(6916009)(82960400001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hMCSFJTwBlDzVvG7mWigsyptqgO3kBMWRdI7rVxfQjEHJj/hYKFTRIhNnEyM?=
 =?us-ascii?Q?zRRdFisXsY82nsLgZlzvh6YatbhxQdZPTExZwrctmwtpTvlY0ZXPTwdFHPy/?=
 =?us-ascii?Q?o3KfzhnlGPP/n/mxw7GSH9pVFs44F4kGrM8UP28blI5/4+dX58P2SOvJyjbZ?=
 =?us-ascii?Q?zg/y2b96nLzdQ3OM0DpE1EFhuhPDQf0eQch9ux41iToTdio6Qfy2xmR9Bmse?=
 =?us-ascii?Q?o0d2Uq/CPW2S7tF24XYNu/OEmm7920g4ZyFas3Wdps5yqy++hADH2VqN16yE?=
 =?us-ascii?Q?hTbkvlaA4p1dElXquCj9eIKNF7qXi8ewmgyDNWFnhejJPFT7/nUgFKUP7sZq?=
 =?us-ascii?Q?dt2ibqMn3craQlsDcfxq3b7zi4ROPuYbVs77OpjUVY6FCC3QH75ESsFuiSqN?=
 =?us-ascii?Q?U6zi2KkhoBqPe626WbFeygnYTOHJsWwJepbQs3jRwdnvk1FETc7yU+1B7k74?=
 =?us-ascii?Q?qgX8mCeBoMWIraL90FTyzNYyorvwos2TxNBs6n4yyGSGvW/6vy0Jn8FFBnhF?=
 =?us-ascii?Q?Csk+o5uhK5AnxROlPdJWpKU/nUX0+2inZUTwUUqRE8x2WZUXKV2VRYbZtggC?=
 =?us-ascii?Q?2WngMf/of0WH1eqBFxA9+V1RSaUB5icWgA8655YbuFEl58ndrA773g+C4uma?=
 =?us-ascii?Q?dQVnf4fR2UJmbmHE5IE8bzuIY5+DQ9oXN3CJgi59o+Tc59yej3saDLP6Q+1N?=
 =?us-ascii?Q?Zo83pcHgyBdlUlwUZA5T3dNJGmm6FsH8VO68Aw5ABgpYPXfyeAu2BbBoami+?=
 =?us-ascii?Q?f8kITWAQtJFWxrKNMHYE1hrSncehDuuyQ8oNM57o1X5srKH4ZwffS7+BerWJ?=
 =?us-ascii?Q?whqTQiGleEc9ooBXQSg1WR4hN7rv7833E5KSCxnd9/w2aMWwZ1v0Vf9WJimI?=
 =?us-ascii?Q?XK5N1PnhxYkhZPvh8YcY5DPCOToj4FVJzu0p7MkPTdXaG0y8JduZsyxmosSR?=
 =?us-ascii?Q?TjMMXHgP2FWPJ2Bg6qXqGtghV6aHE2YCOMQ8pcPgUCDgKSZa+OjSbcl22D54?=
 =?us-ascii?Q?SSl3JkkuviK76gDHpleBgnGW5YOS2RKhNhJKniK8/QKOIMD+XOYhD6/W8dIN?=
 =?us-ascii?Q?MCz5/GMsjmQzxMNzbdUrdbOC33ZxRffd+Dw3PoFA8EBA+PlHthupCRVmjEAS?=
 =?us-ascii?Q?b8lKHDEmR+UnlPCWZlsxYN+ZePL5CnpxW/adx2K8nRO+Kp5Sq5uAGU0EMaJc?=
 =?us-ascii?Q?JZM1a8m93Phw9v1APsAUVqrFsEcVwsXkyexSoVJcRxrDB8BqIDLdOM6vrV0a?=
 =?us-ascii?Q?79BA8ZvrmE1L0eGdQcBOPo88L3oYLNwWf8rDgTN5Q9A5/G/DsG+ppvWms+gy?=
 =?us-ascii?Q?ffTUt5tik2OkO1FQQnynNiSj7EVqoNEwzpYiKMzk5PNwZPFCTCVr5o9g9mJm?=
 =?us-ascii?Q?UL/FedctSd8j4M7nw+Bv8x4Fv3VJ3YodUKOhZjzEdqzpXBsZxCt0p60uJb+j?=
 =?us-ascii?Q?Dd2UQjD3BDwbhcmHhMumdTkjS2ZjZwmUcTw0QCKhksJWri2YI620AZ4QZYhT?=
 =?us-ascii?Q?A8347D+1ED0EcGr0vQZJbhmkbSD7jdVXmNde6EsbBir5CmdDBlxSY1n6dDT7?=
 =?us-ascii?Q?yRt/fnvyChg5soKKQnNECZC5LYyfOB2ocpDdUay6xAq+QBLrAYfqQQDHGqW2?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c96d3535-1358-437a-cae1-08db92999d01
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:14:26.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXb6RhJ9Z8aa32bhVc6/sEFiK21HAux6hjUMTzvjaYSAgtZ9toNAQLoBCHYwVVzjpnupCmg9zvm5QIT2neK6YGz+WmlqqU9KcWrzluMPXGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4613
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 10:38:01AM +0300, Leon Romanovsky wrote:
> On Sun, Jul 30, 2023 at 04:14:42PM -0700, Atul Raut wrote:
> > Since zero-length arrays are deprecated, we are replacing
> > them with C99 flexible-array members. As a result, instead
> > of declaring a zero-length array, use the new
> > DECLARE_FLEX_ARRAY() helper macro.
> > 
> > This fixes warnings such as:
> > ./drivers/net/ethernet/apple/macmace.c:80:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > 
> > Signed-off-by: Atul Raut <rauji.raut@gmail.com>
> > ---
> >  drivers/net/ethernet/apple/macmace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/apple/macmace.c b/drivers/net/ethernet/apple/macmace.c
> > index 8fcaf1639920..8775c3234e91 100644
> > --- a/drivers/net/ethernet/apple/macmace.c
> > +++ b/drivers/net/ethernet/apple/macmace.c
> > @@ -77,7 +77,7 @@ struct mace_frame {
> >  	u8	pad4;
> >  	u32	pad5;
> >  	u32	pad6;
> > -	u8	data[1];
> > +	DECLARE_FLEX_ARRAY(u8, data);
> 
> But data[1] is not zero-length array.
> 

So, please, if you are certain that data should be a flexible array,
send v2 without calling data a zero-length array. Also, with such change, I 
think driver code could be improved in many places in the same patchset.

> >  	/* And frame continues.. */
> >  };
> >  
> > -- 
> > 2.34.1
> > 
> > 
> 

