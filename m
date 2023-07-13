Return-Path: <netdev+bounces-17510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3B751D4F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1D71C20ECA
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7E7100C6;
	Thu, 13 Jul 2023 09:33:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB329100C2
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:33:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2107.outbound.protection.outlook.com [40.107.243.107])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E795C212E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgjcDFw5EAVtK4i+4wkCDtnjAxnTs5IrjPZLtlP5tRR7aHU5li4Q8MS+3bqI5yZH8Q5VNDCUp/Rt8/bMaG3928ZJAzVzp29bnhBqGwk6JARQn+lWrdZ8nLw/eyBE3Hb6hZe6Udn8W3U9JKJsZm4V5CRN99VmQuyyoXNE54Vq6Tbkl49p5CMQOhoANmnOf1ytKnrrA/MUlO4ybsMMCMLBMow1QQ3pu5+uYcCGlgmRjT/BGlG1Dh5XeT/WWmcCEz6iZBFnTxdT/cwFTZczxH3CBRUaOhROXWIQIcI5bjUABEPd9/TyW1ISG2wLHDksVYZVRkv8ow9GVQLFgOxkpezOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RsbJ/jBBAaVYK3aAIsHvkXrolqLcofW8uDJ5Lbg50o=;
 b=UgiMMJWmdkXQeaU7pxsjg8zi/0EuEOiSxG4midqH2R5hOy3u5sict5NJ4wsk8LHeSNeC2B0dEqoPEzgW9hUoU99GxA1rHbOVH7xcTRdFbV4yi51VrNlkMNKKl/Pnse8j/wMwlvdPi87WWNJS5Xb5Q0UP6a4MRdLCxmMvEUGXMvlkiiYvwJsWeZYI5StG+m5Y1mui+4vlYJop7mguXt+NfSB9FUt3ETNjNhe6GiWnMnWey3f2IZLz7dha63Bojd46rMr/em30tG2KKZssHzYecMkkvOSRwFP+iODgnP+skU1ZeMQGsjVYZEtn1kmofoDOxYcrBalOxDVo/PLAPBj1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RsbJ/jBBAaVYK3aAIsHvkXrolqLcofW8uDJ5Lbg50o=;
 b=oqpFKiXf27ItQHtj3SV10hJYCZK+oS1LGkIUnxfzztP/PWuSj03O2hQm6/xfZQQTlqFKYfNjqkaqGfLEGa2BO6HV5SYPX2I+mTuwy3Q7m7DqoaBTV09XfhDlgVjqtoSh3r/UNqCvduA3a8ZNEXgwldgpJcA7+MyLVMx514JoPF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB5016.namprd13.prod.outlook.com (2603:10b6:303:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 09:33:35 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:33:35 +0000
Date: Thu, 13 Jul 2023 10:33:28 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Dmitry Kozlov <xeb@mail.ru>
Subject: Re: [PATCH net-next 4/4] pptp: Constify the po parameter of
 pptp_route_output().
Message-ID: <ZK/E6BxWE41ViHbV@corigine.com>
References: <cover.1689077819.git.gnault@redhat.com>
 <6c74dc733dbb80f7b350c7184e4dac3694922e55.1689077819.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c74dc733dbb80f7b350c7184e4dac3694922e55.1689077819.git.gnault@redhat.com>
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecf9ca3-73b0-4a82-740a-08db83843aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iq99yPG8wqM+kjfVwpRHAU2MwfRvMOX/bxp3PaxUkXW2fV94o3Q3OOaLM8wadStAydcCwdJBq5IHQMDb+gZzbcCR7QUXAVTaFxZ19Qx3jRBwBz4ZE0eAtAWEIthkggHYA3RIAMNiqTsxixK/AyI8bup5ozfRTyJLZGY/pmSN9Rau3VvStdY9nMRsELsaAD3JfsR0fwv0j1VCVVs1NRMRPiV6Thr8Z7dCA8FVqJp6Zb6F63osjXDBnNhqD7zSLLIOWFN5uUgGZ0kN8dxJvYn5KdDrpKJ4dcbCYmQ4o8/gj3WNzW6wZIJRVdjE+haEmpaosEjrrnAW/4i52OT1No1oOJo01YmZCr7mjreh+9S+O84NFucQMn+FwmsOwNpreLCvP9MM6+n9doREaQO7otkLY+8o1KSccV7G0tawOUf6+P9fo9jCi43Uj1LfWLqiE1k6MS2FCWa4S/SSX84WBGiGJUxb3H5rt74bxTL6sxSVOMMIkElfxXCQvoTBah/P7YrqJyhQJlkfIqdGlp65ZjK+sp1qfn/BYSqc09o4DP3EllcUb6+gkM/CUaJU5rgNNoT12VJhqY7wZ+CJ8NMuwAcBdB+vQm+EUlQYIPiD7psj3B0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(39840400004)(376002)(346002)(451199021)(44832011)(6916009)(66556008)(66946007)(66476007)(4326008)(316002)(41300700001)(2906002)(478600001)(5660300002)(8676002)(8936002)(54906003)(6666004)(6486002)(6512007)(6506007)(26005)(186003)(36756003)(558084003)(38100700002)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?88OA2GeUq4p96Bpr3xUdA+nhXPI6avRcCIR3Z0KbqE2795ous5/HBs1E5MB1?=
 =?us-ascii?Q?5fE8QpczArWu6qVvgp3Xew68E8pet4eQk0nQkiouEYNw8M1FCXdRrEnQ5Yvh?=
 =?us-ascii?Q?gQ4pg/tVGP5ytj2noVw6Nx3Mbc3E99HkK7BJjFFiH4g0u8nkKEUNKQG0QdWD?=
 =?us-ascii?Q?7VJbrToysnZFOl2eV8Qp831IXuJzkBHJvsWXu8TFECbKBYrzfcIFO5lXlzV5?=
 =?us-ascii?Q?vuluFe8vtg8yd0fhi01AgrVb2IQhnRfcq4w4e9YTGyhnM07dpMEuKUGUPYJp?=
 =?us-ascii?Q?bZqTczGJZECbAo8d449WZ9PsYiC4vW7u28nFZP05oLCciCBVC+hUCKXY25Eh?=
 =?us-ascii?Q?ZozajYLKbTsw609kJXIj1lZtvMLUB+yTBwyW/mULYL03GAz+jHz1bdwZ0xlj?=
 =?us-ascii?Q?31vis2IGQxXvnCoZ/2SZvAYu4BpQuiArgV2t5JZ/PiwmWAoWfXImrrCEp5qa?=
 =?us-ascii?Q?lVDZc3f4BtSb0ilRDNpGJzc2ddky6mt15z+RuHBuP/W6zPx3rI9kV3dErTA9?=
 =?us-ascii?Q?rirYR7Ry80IvfvlAeB7o2XQttCL/6k1mkTGQ4jYS4rEQaBo7p8lxBaykEF5a?=
 =?us-ascii?Q?yMV0INq1AGtVDRCLLEnc53e3t6YsGjrKK60a/sCzMKkZF3NwznemdyDWbYxx?=
 =?us-ascii?Q?sBbCi+aixKH/tZjAE3tFv1uIO0kvusXfMQCqUtyO414XOq7PEp8aeF+z1upS?=
 =?us-ascii?Q?B3HB9OR35+w9m0hKoOaJRr+Zgf5L7F6qEUq9qPawov9JsICVAyidA06TP0Sj?=
 =?us-ascii?Q?DnXswTQhLYbt0qbnso7RCgYXiHbLVsMVAJnjQ3h/900M1jNjbT5NPigc9cce?=
 =?us-ascii?Q?MON2DeOXuL9A3FqeylnU2TzPN2OOnX5QlBbdgb06zhn9//Ppp6Xw3r2rSx/x?=
 =?us-ascii?Q?NNx9GuIB7ahV+ucj/NT6s5q/3ovafChbF6mKfvJqZrZ/DrktglA5pms/xJ9H?=
 =?us-ascii?Q?8tIW7FGd+TUHvc4Bf7kq2FtHNkbv6CD/8YWRhMi7shm0MoAF60GQDzX0vO6M?=
 =?us-ascii?Q?nuHXdmFFJV8Ktvp8zzLdpb8WAbPmmjj8INknM8NKPld8S97c6i0kotddCoO1?=
 =?us-ascii?Q?C1P/cw54dCX70xbclc3+kmbP8904gSO7ndhb4x7RWMqP82MHKBDPDRaYyJ9s?=
 =?us-ascii?Q?t2kbMhhwgzGPFwvvq2a8V+qz8h9MeBm5IxLe3G7CllHmYxLx5fue6EsztR5s?=
 =?us-ascii?Q?7QUkQT03hgJQLlY8mcheyODP5KWlS0m5bLkTSkCYmoIS2bWBeRcQ+MjBILE5?=
 =?us-ascii?Q?+6BvOdwK3uCUXEqRwnEb6aEWEnolDzorMUOZPBThfD24eLSLJ2pcDZLy4Onq?=
 =?us-ascii?Q?fPDBFnnSSJniKV9FtSQs2iQbutCiRcXovPVWkin/mGEFJfUgy70bAtKy0N32?=
 =?us-ascii?Q?e9lcUSK19MKUXMZGNMfbxTIcAUEo9bMgOklNvlApkEPM9m8+T6DtBLvNjQ4p?=
 =?us-ascii?Q?Q2BLu5mWas8QPZsFmx801dPsCnLbdetYF8SmNgqkklB7brPACXsZ2EBtwTe8?=
 =?us-ascii?Q?6vJSHdAerDOT4cTVFIp31JGMiFVRfBxESJYkD0CIuu0bkofKbTq8gdfh3syp?=
 =?us-ascii?Q?JN9vsYDlUcPP5SFvDRK0zI/YqlAL7P2R29HnRpi7yjkPnanw8rcFEzLAMiPS?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecf9ca3-73b0-4a82-740a-08db83843aed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:33:35.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMrOkVVRY/k3XkNdr/rSDsbRw8dgY9lmZZR/bHZhIpHRu6xCViKgciNCOlhWahNLXh8P42FlyETZ06RLqXu185LQ2Bz224LUDiXU0yoMNjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5016
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 03:06:26PM +0200, Guillaume Nault wrote:
> Make it explicit that this function doesn't modify the socket passed as
> parameter.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


