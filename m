Return-Path: <netdev+bounces-22585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0823A7683B4
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 06:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B611C20A2E
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 04:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73C7656;
	Sun, 30 Jul 2023 04:52:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9809C64B
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 04:52:08 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2115.outbound.protection.outlook.com [40.107.95.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE9118B
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 21:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMVukbPdJ4ZI8WYf0XMu0y8oRn8jUpOQib5y+e/Y54CAQyGrQPEJVJHoL22qgVT4Gv/ZB7SkYUMKfTTRlsMir3f/lLJ/Ee2OYJGHb2hqI357bpQXxwKjO8fRpOCNrteCS2gSHVFJEdY4qEXF8bD5rGOLlHibRolg1BExXv4j9UxKRxWcOte+P83Y08KAlPSevWHaBQEEfOfTxGWSSwTB9/eevmPbODKeh18wfPCXBdfmpR/zGfSevtfeBH39v7g/XL66YMoYwlHATJlaOziN8gHmXGXJWD6DgGrjtCYjKZ+WCCaIQpteYtmmIh42rEdQzuQQ2DPrFAvVUZ3NQLSwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yomurFFaMAwmd61hHwdsG1MGOFAY+j9LUjGyqc7M1U=;
 b=gSFK7bbJPeEniOdpahxijFDlIpqQ5DNrgWRdiYk3uo8M/jOm8ExF8X+xoM8PMzUpxhG7KVeaQEf/AODB+5iegMRdHtP4Cbs4TVZpfZo5L2mXDGVzR6uabgciAJ59VRznTUIou2OOtbjoYE9EwEFGCW1h5SFiVd8xU/1yGf8eoSxj008XRlDsuJJuXKSy3xz/d5zdX5HfHMuYZq+0QBrm9zC02fZnjxY43GalXY2equCigXRxu2K5o+pkHkfyc/IRlldhoKeW8DYzn2GRzHjMQ9lOISjuNtrZYZyvPqda+0mIB1BTCAa33XDVBZmFwIIF8PRnGaacGwjCfrMh5UYn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yomurFFaMAwmd61hHwdsG1MGOFAY+j9LUjGyqc7M1U=;
 b=s7fIb28kfMo8QJFYIA+V/YlNeRY/keavpNhAVnnpWQjBP0ZcDyYw77z1NbJprljTuaWVyfCiVfJpeUW4FCZi8Bzhckhzrt+3xyPCkHBdT4is856HLXiIg7ZzktC9nhLaHd6V3XSAeM0RriMt4DXhkMc2bOYb9/BSzsXcWogkkI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by LV3PR13MB6407.namprd13.prod.outlook.com (2603:10b6:408:196::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Sun, 30 Jul
 2023 04:52:04 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::38ff:ef02:e756:bf23]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::38ff:ef02:e756:bf23%7]) with mapi id 15.20.6631.042; Sun, 30 Jul 2023
 04:52:04 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: lkp@intel.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	louis.peens@corigine.com,
	netdev@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	oss-drivers@corigine.com,
	pabeni@redhat.com,
	simon.horman@corigine.com,
	tianyu.yuan@corigine.com,
	yinjun.zhang@corigine.com
Subject: Re: [PATCH net-next 05/12] nfp: introduce keepalive mechanism for multi-PF setup
Date: Sun, 30 Jul 2023 12:51:58 +0800
Message-Id: <20230730045158.1443547-1-yinjun.zhang@corigine.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <202307300422.oPy5E1hB-lkp@intel.com>
References: <202307300422.oPy5E1hB-lkp@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:180::17) To DM6PR13MB3705.namprd13.prod.outlook.com
 (2603:10b6:5:24c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB3705:EE_|LV3PR13MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: fca5e04a-70dd-404e-a328-08db90b8b7d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XFzB3+c421r1YsLBn3tnL/waWfpCrJQN4bgPF2SeMbhNv5QTybFO0yYqrVwkSrLgGkkfUHUIX1m4IVri9cpdzZPPvmv/OPf4us5iOAQYJnSPEJlGNdOeO5Wwt16sjSAxjghK1C4oJTohmBvuVnXikx511KOgaQcvE4pl19TAZ9BtyRv4xMk62mzwfK2RIOcJrN07sQU+LFMPZjVf6t04Zx2OYMlQ/OWeNyJyU3UmEjg/MbuABdYtCKN38xr0zNvS9BJ5EaF4u4+IMmx7tppn2YgyU0b+Vo5OU3QaITo5DbGXJF+/iyFLd/7TQVewQeIklt/04tfOlkbgcJpIl50X27cu+o/axCjdXd7QA+Dv3runDgVs3O+UwHRwFELMKslnjQnpowxj3AP3R3xQ9MySqqakk85sm9xeeN5LjaJaO/UGwTFzaryTyzY8IJSbeCgSP/TFuQwsP+dB1z6iFWxjMfYTF5kS/bXV2vbHS+tH3A94HhOC/5HFZez8HS7OTZPwpWn/Ljfy93nLwONuEi4iuYqnujHfqenZH6CrDG1fP8w3Y85bKTm6LvV5Cbp/REW6USqLzy/f8dbgmN7OUhTWqkbpTwFtu6DZw5ncta4RHQQ2Dh0/cr+UHILNK9/eEBGOYZ+eEPsJxQPlOp2tZw2CtmHl17nwj/PGR0Q44IDWPfXpGWvQRdcITXBAaJusQ0id
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39830400003)(136003)(396003)(451199021)(6486002)(6666004)(6512007)(966005)(52116002)(478600001)(186003)(2616005)(6506007)(1076003)(26005)(107886003)(2906002)(44832011)(316002)(66946007)(66556008)(66476007)(4326008)(6916009)(41300700001)(5660300002)(8676002)(8936002)(38100700002)(38350700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9FM2cad1MWIM2ag0PLmQwWbIiDUxq5vgj/Hd7fzKM2/R2N/Xht4ymdTh3EmM?=
 =?us-ascii?Q?db4PP1m9FpIjGfkl6TIIZmtpN33F66wDnQ2Oci/miPBXPb2IpftSLBJ+clz9?=
 =?us-ascii?Q?PYhJf7+BNNUqmZSo6uYMzsZpUn4e4RhNn/3jylXjeaRqnmgKVLJY5R462296?=
 =?us-ascii?Q?qi6PcBbSO3vutwiuwrsSgkWmjgN7QTuqp8x+7upCUM/dWAfKS086zvJVcYUA?=
 =?us-ascii?Q?lzGy1aPzih9xspN7FN+XYDEZSIbOEZSGfdOE6momavZ6lQnEm5YL/JdnIJtS?=
 =?us-ascii?Q?RWFqHHznbc1eGkhU3zdAQq9GL4X2QXPO3u9eoxdrhM+IvYRab/Tw+/QeQIVl?=
 =?us-ascii?Q?YGnObu6vpd6BH/1i4DfaWhxaVcSUSOqqHG+HRNE2vQinsCW2WmvwzVAtDHvr?=
 =?us-ascii?Q?BW/deZq4nvCspj4tfKliEsgIhvqa7NQckgP/7UQrimNgMQhsoPyYK+V9VXBd?=
 =?us-ascii?Q?vkRBznK+E5GVJOaGwt9PuzkSMa0eZznoRQWM2hzLlg/8gdvN3UuJRxhyO4be?=
 =?us-ascii?Q?kWUd4ssM0Ct+T6K10CoHPUU1xq9M0TubpbTrmrYyQEC6fBY5GodzbE8//7/U?=
 =?us-ascii?Q?U5xSmWYGjR0tRjUxetqjlMPh6Ok93lvntvqD8812gpUa+dfCKxI1KTiM+von?=
 =?us-ascii?Q?ZEVoPYaV7s7VIuwCKhSbqFvmyuUda865bWrZgSaGMvD4NqTwqkxYGyOIG7F0?=
 =?us-ascii?Q?/QNPAwwu3gIJaObaTwK8+RfanNLySfrcZJADA5dsyJ34m4cbCH0pP7Y3amJ8?=
 =?us-ascii?Q?Mlp3gGD8sg4nIZl0UPANSh/AmnUQB4205Zrq01iFyz1/qigRunxdneYSIVUW?=
 =?us-ascii?Q?nkIzFI341IVsFe0iolaOmG1XH31aqRILNzCuQlI0KNyuKjLvbqKJwe9q89ol?=
 =?us-ascii?Q?6l2Ljcg0oXP/tcTVHeggJ8qHKuhtNkKUztDItIJ/hetIgRVZGoGgDbADJ/E7?=
 =?us-ascii?Q?yMW5Dh2oQDJDu5eFeligB1+clS1EG44R+7qhfmY3fQlv0LhNdKpz/xNTG8Qo?=
 =?us-ascii?Q?YzJCRaj3dE8wY4NfDLIAUVOEoXcOUZMSlRyHF4qb1jSGvxS5bhFjneU9Hpb3?=
 =?us-ascii?Q?fh7T7IT6CZYaloDmGVkqNUKGSM0aqIa2g1Xtw/hnamnK0YGTPpCyquSierJB?=
 =?us-ascii?Q?RVr/KTV1D9ARjzKuhimHozYOJ+3yizS4SsSN5wyUAZg5hJvvzPGAMgnyjF6e?=
 =?us-ascii?Q?KUZCNsyXD20JCnDaKH9mmP02X482jVRjpuyWngvaX8xgbFFtPzPoftOoaHZ2?=
 =?us-ascii?Q?DA62jueYS7poVTMLL6QAtQHgtv07oGmOAFkczn8QoJXIndS+Swt0sZ58fLCT?=
 =?us-ascii?Q?ofaXu49wI2E8FMYOJbOm9PmcbcRMiqQQoytQpmD64JY0fXMrjldLDRxebP3m?=
 =?us-ascii?Q?TK9Le/iumKvz+Zm89SbCwrKMFqpKjNJHhKA1wDkihEg/2I6Tmxn2FmwAy8Nw?=
 =?us-ascii?Q?aa/Dp5914FV7aomVQtnptBpYRg1lIOBefCMfD3zjnk7jyEEqlRtuErPts8By?=
 =?us-ascii?Q?2PdMjkNXJ72l48BVEcdAIQc62fwYogkorMh2pORv3sPHNCOY+BnfcJ8jK+ws?=
 =?us-ascii?Q?smAXX470rVIQpdRvE+IhIOrlLVvwbkxpSDkkffHOy+lenT6NS3zcXu50iviH?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca5e04a-70dd-404e-a328-08db90b8b7d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3705.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 04:52:03.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Qi31ZvE/ZhEeA3OP/ZLrX/yFTKQehGkyXVx4R1z7fjZzomwz/4zp1ACxxv/YRmAV9B4auBikvk81MhKdzVmxJ/aF6xsgQM5cBTy8KwurQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6407
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 30 Jul 2023 04:20:57 +0800, kernel test robot wrote:
> Hi Louis,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Louis-Peens/nsp-generate-nsp-command-with-variable-nsp-major-version/20230724-180015
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20230724094821.14295-6-louis.peens%40corigine.com
> patch subject: [PATCH net-next 05/12] nfp: introduce keepalive mechanism for multi-PF setup
> config: openrisc-randconfig-r081-20230730 (https://download.01.org/0day-ci/archive/20230730/202307300422.oPy5E1hB-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230730/202307300422.oPy5E1hB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307300422.oPy5E1hB-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    drivers/net/ethernet/netronome/nfp/nfp_main.c: note: in included file (through drivers/net/ethernet/netronome/nfp/nfp_net.h):
> >> include/linux/io-64-nonatomic-hi-lo.h:22:16: sparse: sparse: cast truncates bits from constant value (6e66702e62656174 becomes 62656174)

I think it's more like a callee's problem instead of the caller's.
`writeq` is supposed to be able to be fed with a constant. WDYT?

> 
> vim +22 include/linux/io-64-nonatomic-hi-lo.h
> 
> 797a796a13df6b include/asm-generic/io-64-nonatomic-hi-lo.h Hitoshi Mitake 2012-02-07  18  
> 3a044178cccfeb include/asm-generic/io-64-nonatomic-hi-lo.h Jason Baron    2014-07-04  19  static inline void hi_lo_writeq(__u64 val, volatile void __iomem *addr)
> 797a796a13df6b include/asm-generic/io-64-nonatomic-hi-lo.h Hitoshi Mitake 2012-02-07  20  {
> 797a796a13df6b include/asm-generic/io-64-nonatomic-hi-lo.h Hitoshi Mitake 2012-02-07  21  	writel(val >> 32, addr + 4);
> 797a796a13df6b include/asm-generic/io-64-nonatomic-hi-lo.h Hitoshi Mitake 2012-02-07 @22  	writel(val, addr);
> 797a796a13df6b include/asm-generic/io-64-nonatomic-hi-lo.h Hitoshi Mitake 2012-02-07  23  }
> 3a044178cccfeb include/asm-generic/io-64-nonatomic-hi-lo.h Jason Baron    2014-07-04  24  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

