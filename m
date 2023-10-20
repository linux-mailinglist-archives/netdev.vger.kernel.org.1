Return-Path: <netdev+bounces-42943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6FE7D0B98
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44CE1F240E4
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D6E12E50;
	Fri, 20 Oct 2023 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WZTzAQjl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE22D2E3
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:24:37 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A307D57
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX67h+S+svurLAYF1ExPDgiiIisMu6hZoAaYGFtaVz0Ptch39m6KrDGX1sSMGTKEwfd1jWr7tIj2PRDZvumFJTHkXHdJ4inRUE+A51C0e1DGNxm526S0awBFbuzI3535ydZLMY5AqIaMROHnNkL8PF+fpz/RJ5eFdfz2Iu17IvBAEkBBNFBjXdMqS33pjSQJ/s/xx2tKsg0JR+NT9Qo3OEJCOJmHj3u/leg46DDH/9e+2joXWP1GHOT5mfIP0qrqJvG5Zqaf4cRxwRjEon8zUAhc6lGMhwigFY6kUfOc+GI2eyc5itoH5qy/WpDf1jcKpES2f0SbVS6P3TMROu7Czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLmHAffSepAfOy7I+ApcP430qHcNux8EEJcEGXS+03Q=;
 b=Auj/gDJbio/XFL5bhPpX9glN97ofJepS6TdTMPCntVKkZ79NoTX3pWGOu3y7rWeIip6/XjtsLzYnikw4fnSX8cArmILuOGn4n4rS1SCnuG8yMrpj2IdAe+jMQVRotiSCA3UqNYjveoMl3RiGv0/3QkO5yDZ/55WDjs+R/VEv3Zkg9x5QaKVz20239gU7HnKArU9faa4jODFMuk04ArIETdegd1bg5R2owjYx4b8lKtfv5ubfLNyaEAVymvLkU9HmOnJqmtjHVcTz2LzWzqt9qPEYWLjHIgfXpjJpwnoo8y4xCsR/tyFrucTnK1B8M9UoaOGTYnv3Fj29nTKpuOe0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLmHAffSepAfOy7I+ApcP430qHcNux8EEJcEGXS+03Q=;
 b=WZTzAQjlfENBbOMmejY8La8eeRBhZWQYWgjlY+/7aGkolL2+o+9twfhOD6W7CGhDAuK4eN3vdFnZB3BOJPEcuuzsfhoC4t/3oYf6JCKdXZoLt0b5PkPLLxwuPMWPzGkSSsqsGZ91Ah1gtHCgAtv+XilEsXEk12Y0pVKXoourYa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB7010.eurprd04.prod.outlook.com (2603:10a6:208:199::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Fri, 20 Oct
 2023 09:24:33 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 09:24:33 +0000
Date: Fri, 20 Oct 2023 12:24:29 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew@lunn.ch, paul.greenwalt@intel.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, gal@nvidia.com
Subject: Re: [PATCH net-next] ethtool: untangle the linkmode and ethtool
 headers
Message-ID: <20231020092429.3pitbl3s6x6aonss@skbuf>
References: <20231019152815.2840783-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019152815.2840783-1-kuba@kernel.org>
X-ClientProxiedBy: VI1PR10CA0089.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 46dbf179-c427-4b73-b67e-08dbd14e5e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uk7JMlXnp3FjqqdcPnTloehdFPHf61us6gWxKUuwl2idCiR/INZoha4TuTfZjaSIV6/iFkJZdVMgGBDArEPjfTNbHSD+BwI2TU/qBB7wyBmJ5mzD6LfVaaeLdhiIQsAPDNaQZE3vYnfbFbaExqxvEJr9o+QK3QGCpmsm8jbjInf62wq6NV2XmhTP0FdZNwYwsskWW+XQ6Ib7kmXkTQMBYxuO22MbRFGavoQBeY8bs5JECE2E+gJAoCE3tne9kXHWMKVhdNYvPd9ICqkHXRR7cXAjd/jOQX50ckVFlzv3qD10pmL0oTmpSXBuHsnJ2EOaYc8WofSwmqVFCiWTZlK/xCBH27k181FqruBEdDcAnocJzfthdx0b4TV06/79UlWzlklRqwg9MTQ2/ePP06AnoP/HgXB1HImrH9mtmMot/S3WioW5tdvIQipaivJns63sSz6tLXMP3/tB6NbxvW/3If68IA11gMqE8QXgDWdy5yI6+E6ATIfAY2yXT2C92iu2vUaZzmWsQfPpixaaEdDQqbdfHdsDSVldEwV3XQqpttBMdLvOu62Ht1EII/I+gtxm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(1076003)(2906002)(4744005)(7416002)(8676002)(5660300002)(4326008)(44832011)(8936002)(86362001)(33716001)(6666004)(9686003)(6506007)(6486002)(41300700001)(66556008)(66946007)(6916009)(316002)(6512007)(66476007)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7EElp1jax6UfhgLKJ2V0cE7+mtf+ubC3xio3xJplzVOBW2XFjGPti9cEE5tT?=
 =?us-ascii?Q?w88CR8G+nqrl/MoqSH7hqiMjjzCwk4Uu3/V+SMRoceWVqOTxkvx613KYdNn+?=
 =?us-ascii?Q?ZC+mLP4ib1zuAhi4SyVQLvKC8QcXMayImMN4nIKGZpTDvUFa9egPHVGFd18E?=
 =?us-ascii?Q?M9i2sRx6CqbGVemZEMzH9Decg+FKzsnbiih/Sm1LtPr9jNKVWcm0TZg7a9dV?=
 =?us-ascii?Q?Mfs0L/Uz5bKYWfPpgF0jD9URvczldSIoDWopkscxyXLq7F+YYw/2haMTWCH3?=
 =?us-ascii?Q?InkZd8rMConF+RCpuK8WDSKIBvVcZfP8sGUoSDo61EHfvm8EnRyw8DvxmAxb?=
 =?us-ascii?Q?OudXf7PcbY6NmszIT7kTIiB/Roi5EDkXrSXjKw1IktRSVJNENlR4Nb3Wg+n7?=
 =?us-ascii?Q?BpJgvY5Xs9x4Pc13qhQftNbO9uc/Uv0iuPCnbXSNHNUKeb2/VeDpD2YCp9XA?=
 =?us-ascii?Q?grmLotqv+piu25+p1JjUt8Ad9mFEsE1BS/e0kFt6YP6Jr9kk+WvGA8JJFKUH?=
 =?us-ascii?Q?grDJ6tsTe3V+mkdXbKwRmlI7YJZjmNNN0OcHGgpb7W5qkgWdjijr8tbjmh3R?=
 =?us-ascii?Q?D7VqPcanIZ5IPfkV5q3wZXxDuZiK12NM3Z16DmBVo8x6WtEGJgL5F91YnjJW?=
 =?us-ascii?Q?I/avgZmIccpC3eklL+43LMI8muM9qUmODV1GwDgb5+zG7sEEe87faebwhUE5?=
 =?us-ascii?Q?Sywn20tO80bL8zbo2UDM1Dt4c1HJiAzvdk/vAVEC1OArB0yh15zKB3+Zynch?=
 =?us-ascii?Q?a3RlCSLStOFpfr2LPMOiLzJ0rFETSmfHJvLaJKQ10B/9L1PhLYfwer35pO9t?=
 =?us-ascii?Q?iu++Co5oU4LoyYGpUZ0Zg8lCtsyI8oEf/LzaGALrz7JXgIeiZtah8W2V/ymc?=
 =?us-ascii?Q?zu9+BEDNlEw7nun99dEDkumN/J/F4p+whSCnRFEdUWbOMGfHJOdJShMAPjdv?=
 =?us-ascii?Q?IhF5oL3WkCpgcoiynSHlltFjWSAPxug9hLV5eEbD6FOYpyr6+60hE0xmDK0j?=
 =?us-ascii?Q?cvYW/Ji1/kC+gt2Nqfn9OoODgiiRDhIDQ/Srgdh9EBuDhjzmptQqUoBPKyPE?=
 =?us-ascii?Q?wuG/4wgnnab+885EU+DUiVYOKL3KiYm1+9A8IVOnfrDqbSFwRAsZXpNDAJ8I?=
 =?us-ascii?Q?V21l8zbYwMm/5ajBH9YqecvMa66GO8DtmE/aBSOI1wtbhGsYSM5L17Ej1ElY?=
 =?us-ascii?Q?8Biytqbg5ko4l361Qk+2XKTqFSvftR3EtU1iQr5+cz+fr/+MINFwSbyqhBuU?=
 =?us-ascii?Q?ZO3EcElzyJfjSIP7+agL3PBW7Majg62n6y28NhJ278yLqevttsi0be1EkNN/?=
 =?us-ascii?Q?rl2v6HjeACAYp7+AcWsVUYS3VRJHmM3edsXdVtTh8U/n4oGVp4s3vOFdrTBI?=
 =?us-ascii?Q?v3qa+g7YtcP9zYBX270o6LlEIzg3tMyk/hNT3mJm8pZ3pJEmrv6RqXXtrfv2?=
 =?us-ascii?Q?421Ce+ONFIkFXIq2i8xo/NMDnjk7DEBPSFgSohPFhZtgWpOA53aVHjtXeG7+?=
 =?us-ascii?Q?sgi7z6KWRWgG2Yra0f/1M+gngwUnsLQVxQMVGzqKtVVYypYPpLFuBUJdvw7s?=
 =?us-ascii?Q?EKl8x/Pyy0+Ivx77DBckUmSUXZneVZq0xbOL9iBIOwDgy/6ZdiSGxu0TRixn?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dbf179-c427-4b73-b67e-08dbd14e5e9f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 09:24:32.9374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4jJ4r8AY4ZpZnv9nSdCzxjMVbFXF3vj/w5qkphlFkZLjZ4Ou1Km1UFNbmhY8R6IbBtAI4N3gTez5PsKb+BKdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7010

On Thu, Oct 19, 2023 at 08:28:15AM -0700, Jakub Kicinski wrote:
> +EXPORT_SYMBOL_GPL(ethtool_forced_speed_maps_init);

Is there a rule for EXPORT_SYMBOL() vs EXPORT_SYMBOL_GPL()? My rule of
thumb was that symbols used by drivers should get EXPORT_SYMBOL() for
maximum compatibility with their respective licenses, while symbols
exported for other core kernel modules should get EXPORT_SYMBOL_GPL().

