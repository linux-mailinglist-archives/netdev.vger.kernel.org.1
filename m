Return-Path: <netdev+bounces-14852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B51EC744179
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 19:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC48A1C20BD7
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA066174D0;
	Fri, 30 Jun 2023 17:42:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A913C174C8
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 17:42:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2103.outbound.protection.outlook.com [40.107.220.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52DF1FE7;
	Fri, 30 Jun 2023 10:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVjPKP2vYli7LUkkhhvWsureI2GiVv1Ybw42gKZCvqcitfw1dlSv7wKOzIeAcVoXjyZ6Vjp3UjbKw5WQEi8FN+UVxWcmdShHtYFBk0lKE/2yc7u8jNu2XUa/0Mp+7WxznYc5hrBLIm5bHOuHPGtdGooWqu/mCZh41CkOVKo/KLk+ngCU7Jrt67bEQzp/UIipSFxiZoQWO0Hdt9uiFpIydir/hNAzobhK6nhiMMh6xtbPKhQfWf1Uye490Fj1s2+K5CmsdhUuVRQ5CMLKcvMFL9H3KjwVQ94RzjCQIq/FOSCPEkYcpOOfGb/9ngAZoqZNudTxTIf3V4ixaOiw5DuRNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=el2kV2pwJiyuThrjNCWslm6xbUOLQnUJLFcQs1XlJ0c=;
 b=TpvKKZmSU1PTuNmOPsg8Pa3hjj/EBpBRf8Qd63SKACOYbiQNJAMELqbOoApg3yOMEbwUzmCRFR6AyA78hmnBayeUAuMOnx2920u3ViOOPxPxCcYsNAbGSWRHdVv8ljBy8Go4yPAnwEkSmhW/LWrU5o4G5YdClUoAg+DyEAC1VIS+TBdEfHgGmwwYWj7Z4GSNscLNNa7Dzl2syKISG2SlYhj5nsyxji00D/ljjLBufq6u0KiuT2fncfBJUUORMqK3Qk0IxVmgisxIvJJzYRvYLM+NtNnmgSDLoPKpvljXQiDrCwgz/klv5Iabmv3t9SmDgex2AHgkF20vWrVrsu2SjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=el2kV2pwJiyuThrjNCWslm6xbUOLQnUJLFcQs1XlJ0c=;
 b=RT2nMYOBQFTMeFC/YmxxFgby13b/ywuL2DrtNYkMD7HDMxefaoyn7CSnpRR8rb+u+5LWa2cz2YXII7oCMRt8spNAWRt4WqJCuz0pjFX+0YoHRAPihxXYYEb72dhrL3aS/TOpBN6dlG3XwhOZgg8GTeTBC/DWS8z/LBf5uIZD888=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB3625.namprd13.prod.outlook.com (2603:10b6:5:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 17:42:02 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 17:42:02 +0000
Date: Fri, 30 Jun 2023 19:41:55 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH net] docs: netdev: broaden mailbot to all MAINTAINERS
Message-ID: <ZJ8T4/u70nlS9Oq3@corigine.com>
References: <20230630160025.114692-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630160025.114692-1-kuba@kernel.org>
X-ClientProxiedBy: AS4PR10CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::8) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB3625:EE_
X-MS-Office365-Filtering-Correlation-Id: 6699252c-bed8-4e46-b145-08db79914fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u/lro6ltc6fJT7fsXGQiJrDzGzcJvzhJci1R1pIg7g75GaytZ8F9O2bUubWe8kp3wzwva8/CV25WulezLySHq/kVHnp/uswRJIx+hxTIppNXlsexIVPeje96m8nwt7UtKeItgGe2cnfz+u5xezRqrce8MOJZ6RWGpYKT6/50agf+MvaXmi7YUpMBjklyTN5nzsf4i7R7Lu0sK0uhlXVhqe3AxRsIbLcZ0IAyQqhpBfyzP5ryVd6EJ63pK/CAQ/A8WF5YCAdekL21aG1Njd98WvgpUNfKQ8HtNg5RVniEu4IqvPvGQ7pdb1Y037vkyChaHmxrWumlJHt7twcYejrZqcRXPZIHof2IYyBEUFicH277TqxFGYj2QqR8HaO+hNlZYUA5sYVaZp7J7n0LrTQ7ZY+cyx7wJhC+sUthI1JD2CLC3o3tKR3rtdG/LTi/Wm2ayohdF+eRb/CvDbLjXlfzFQl3GQBT3MJ3Y7NtZRKsPzTlMdlc95+3xmVyTi/u3LBLT6CCVzK7udo3hRliO2rCQhGZY4EOxVd1ZZZEQ1WzdkxSJOwgvkT8zg3imxwi8bwJTgG4pSX635ORAp8VLnego4Obf4tLmNg8naL9y7U7EuU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39840400004)(376002)(136003)(451199021)(6486002)(478600001)(6666004)(6512007)(186003)(558084003)(6506007)(83380400001)(36756003)(2616005)(38100700002)(86362001)(6916009)(4326008)(66946007)(66556008)(66476007)(2906002)(316002)(5660300002)(44832011)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BeedZL390kBwgRnKE5SY+co+4FUS6b+58uVvIyrbbVCig4ssJaojXUostfMD?=
 =?us-ascii?Q?hWe65nrGdOz5IgBkZr3uNrV2otcJaXdDaXX+f7PnhD8+5QH4BhEwxHcen86L?=
 =?us-ascii?Q?A6rCAyeP6lTRgSUhrnv0rXQVnmCLVo0Su4zkp37CtDxFQr14cooFY2kBYXHl?=
 =?us-ascii?Q?0Q/YXC/G4kelW2FoZII5/YEugtOJdhf6Tw5840YSXpDNxgPj1p9ctjNhBy5T?=
 =?us-ascii?Q?7saqoDQRGYdsnh5tmF09uc3d/grawhx8PqUPGusL7XeT/B/3q+/9duFfoUkn?=
 =?us-ascii?Q?OBPmggJJt4axYtLPXIhf4ZviY2Dzs3bVQtI596S7WziqDZI3Z9us+3C4Crp+?=
 =?us-ascii?Q?3ZiRD1V6Tdyvu2JrwKpimhUTlaPmR/popD3NETruK/cHgoNr88jEYLKBqfiC?=
 =?us-ascii?Q?TidlRitNZpWqa7fRB6e0G7Jcu4HHpHJ8Z73z/zBnV/rt1CEhcOXzr45KCc3c?=
 =?us-ascii?Q?QFQAYa0vXfmlubvscUvtoOcSG9zeez0VfHy/he9fOKJMoy+JRlG+PrgQ70fF?=
 =?us-ascii?Q?4fUtGGL5zfQasxO1YdwsDDG20Qbd0LGgkEvgF+3RzIooihg08lSMoHOdDRIx?=
 =?us-ascii?Q?GQDs+QI17Bq5Ka0gTQvspvnBEh4Q6glCJPGYDVitSQEts/sMm2mM/mjk2MCZ?=
 =?us-ascii?Q?UizgmgiApxgidggPlJAOg1tS5aMONe/yg/ZO06XTL+m/6t5oOZcGzTZBxwXQ?=
 =?us-ascii?Q?xi9k53XwttNZz52LSww1agpMm8LI09YlcayK5qfZpIrZerKrcgxlrilxqjMb?=
 =?us-ascii?Q?F2SyxXjpvOvF1Cn6uHMkSfaVZN+mvwQxgVszPxd2Lne9x2G2Hs6crpgug9Rv?=
 =?us-ascii?Q?I5SfK+BjNFf0EeoJpgR+S3Qcfp2fMIP361Zbpo1Y497ZrBGC9wjYKz+UiYKh?=
 =?us-ascii?Q?H6uKIZ/7T2Xko7HjDuxODDmVBVyO/FQwEPRX0g+yHQkxWR/2HlmZE9BdH6At?=
 =?us-ascii?Q?4b+8hEYJslX+4OGODUjHsIo3htZCZojl72t88SriEF9+m8cjjYD8+A123cnY?=
 =?us-ascii?Q?y3swEw7rjO34XLZ8acNyVQAXKYRHb6Jbeu0rharEUJAkvh0zLmOu6eokboKE?=
 =?us-ascii?Q?3ks+OjWxM2wHu+BwTuDz8uFmVzc9NSHBoFisGvb5Qf4aYdud5qoCwTWcLJPa?=
 =?us-ascii?Q?1Mecdb15J7GlCDeZTxYkIWFg/PK+gc1mF1GXlqmpzBbicn8D0EVeKMZQM2gY?=
 =?us-ascii?Q?Q62yzZwZfwFR/vtb3zBeD7l91pSUm2cn2NY+K62RVQHXkhyaxPYvBhlmSlr7?=
 =?us-ascii?Q?naOeGdJ/FyBb9Soa+zLuKXEvK3+I3HSuahmJGlOIB2EHnr5ZARZ0LMpHOJH5?=
 =?us-ascii?Q?5BswJuncXty0PvR/3bVRBrLoqPv7e5wsg0/35FS7yehm+eT2FxzJ1cLeZ7+Q?=
 =?us-ascii?Q?j1JnRp37l48YHQ3Cwkd3X/dcWXfwpK6o8Oj847wPS92Lrkn1v+OKcmHPLZW8?=
 =?us-ascii?Q?VMR6Y3Rt/3rusHGJ7Ajgru+wKQjUzOw+GlfuhDmid1DwT5AwmhOGZoDoKNM9?=
 =?us-ascii?Q?OGPO8/eYGuTHN9CDne6lJE08j0JqY+weyvklkaGD3Zbi0ieVb3ZSCgXYs4UK?=
 =?us-ascii?Q?/itxLNOztEV6cCzQ1POMzMujM76HAEOzEFM1sFIzv4jrJ7m56zhzJ2H4ChHh?=
 =?us-ascii?Q?1mjSSihDg+8vhfRwEaonPqvJfAu9rFCgYzqaezUVVullLXQ/uE25nVKHchtH?=
 =?us-ascii?Q?4WIqEg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6699252c-bed8-4e46-b145-08db79914fc5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:42:02.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4US3xqc39poYYzyuxZfYEbPe+VSrD7q6CM+epkCRZTe8ISwHcISYWJibvAZ3O2U36IK29D8n0zgLvKF/jJzf+7DVYm99ujSYckly/DkVows=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3625
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 09:00:25AM -0700, Jakub Kicinski wrote:
> Reword slightly now that all MAINTAINERS have access to the commands.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


