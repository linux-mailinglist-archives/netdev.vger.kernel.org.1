Return-Path: <netdev+bounces-19067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5C17597AF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 16:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330B61C20FB0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F6614009;
	Wed, 19 Jul 2023 14:04:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F313FE0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:04:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2118.outbound.protection.outlook.com [40.107.243.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87BB8E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX3edHILTikbuuYQSbYC/k5oCkN4/uKLy2LN/iJsGhT1mRNimZopUuuWz3uWvXL3wSe1F7P0TVNiXRnpkg4BdNluXRg9/4jfDN7dDdOvKkAWJEIDcLC+JF84jWa8mjHQXTE9Xk79SQDZLP1R8matM8PXS7UNjr1YZoHq98gl8x8wkYHBfRKHaNjRpBZQoIPnC1hnbKTka+F94nHh2IIL1IMEJ1UMNmog3PARiZh4RFhXUOQCROmAFuzf4FBjB/17ZMeOrBXKRBX0ZvjwQOLNVWTl70T48GpEnrzGxYMheOYf+pCaJCsry594/7px3JKtOE9qw4zQ1Sm/nI2XCeMHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1S4Rrix0CiX5R8fU5CnwGwRvqQ1azJ2aQKhMw2o0iI=;
 b=Jii18rdlJebKoz1arFoxoXzEqme/cgucrNIxqXYJvIc1lz3thxcVl4g5VZS8sXBHoCyfPMyxgatwDepMyBMeG61SsJVMYtWzhoxJF/Msd4mNQS2FQwM6YipcCCRP40Y3rPnDGzs4uzD6jqm8OZrMA+Y+AOfcBI/Qetfk9Wm232jYy8mmX77ITUNRiKsLmdKV38XeD7JPX3Y0leD0S+yGhkIuwHLZ9gdn6EG00NQJokOVJbyYgReqJMDbTPdiFIFqeg83MKtVbWCYEFIx2G8UgJFgletNJDODfqj8nt5d7jyjEBFMYQ3rLMghb+RioqUMqOVaVTcV81KVsx5Us2ziUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1S4Rrix0CiX5R8fU5CnwGwRvqQ1azJ2aQKhMw2o0iI=;
 b=BtuKo3OAgBJaEzAmXk7WuuvSuSD8iwklhk2HAeCBqNBNjPKrELhlQPsogIos2c2CmuUDmdbgfAbg90SZsOO2b5l6yZpye2YSaQPoWkk55cFecNr4/6mP6hAX5lUJ8JCERPenVllDiy50Z3xDrEX7cKE9Y87Kqxk9wFLvbeyKAGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DS7PR13MB4590.namprd13.prod.outlook.com (2603:10b6:5:297::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 14:04:25 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 14:04:25 +0000
Date: Wed, 19 Jul 2023 15:04:20 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Plachno <lukasz.plachno@intel.com>,
	Benjamin Mikailenko <benjamin.mikailenko@intel.com>
Subject: Re: [PATCH iwl-net] ice: Reset stats on queues num change
Message-ID: <ZLftZFND6uBiHMC4@corigine.com>
References: <20230714114721.335526-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714114721.335526-1-przemyslaw.kitszel@intel.com>
X-ClientProxiedBy: LO4P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DS7PR13MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c435eb-9ca4-45b3-2774-08db88610f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JGDbZjfzUa7HCZ1KRYkTehxf+Zs0PQ3UKNHynDdW4ZZypbTDng3U77JV+FOF7oKiJHC/TIyC6d0ZqdI811IXr5tMQLEzbr8gKXGMUVzOyilqruYh6kOlOY4WLSxtxmvFA8lRdfYe+E6rkcz9/8VFnzL9ciXit50M5i+6tl2sENoTk3qxOeUfswRt6xWg0PFmU2cXU2p+BopQpckAnE7MqMAyviScoUtMHHIOStGoawzbVg24deFderwGIdfKwTVzhNdP74dflb+Y7APbr1AOZl++bRrUusKEmdBwCjzBLokxdOtomQlBX+xILoveuhPYNRk24NWdg3I8wTBNIHaoqLauoF068xaB5UQ2Gz/rjPbnye6rF8gn6qmiAbqZ+p0oBtD1Eqh7Dhhlz4dxyBZXtEk/qWMjN3XIFfI/CBho6GYFQPSLdBNHNQgHO9W9KQWh6PWeGuOvzgSHHh3atzJm4oD6bm7z1OpbqOIOkcMYVthkmyXNZTIzJ7e9xUemj2FKLgDdyRFBVLdd54MU6jf63gUVGyzVeoojr59G1YOdvCEK+yejOoNeaKEHRt4CEhsJ0VMakkdhTxdfyduDbENY/+6LSgzjeC+WtwvsRv+rmDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(39830400003)(136003)(451199021)(6486002)(478600001)(6666004)(54906003)(2616005)(36756003)(86362001)(4744005)(2906002)(26005)(6506007)(186003)(55236004)(6512007)(38100700002)(44832011)(6916009)(66946007)(66556008)(66476007)(4326008)(316002)(41300700001)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RvuB8ZK5gd3tEh4xOBhwzboKn+B+BAHpbyQpBpr6M38HiqEmtj3cSNYSmDKb?=
 =?us-ascii?Q?f20+vj6gpI7URYd9JdgaXcSiDH3Ft5NstzpBye9qnTTJkrNwnn1bjgPDcYht?=
 =?us-ascii?Q?WM/5I96NlT/f5bqAViQsJ+0LGtwPD1NsPp0z4P00bGqPHDpKkGBaTs/plq/a?=
 =?us-ascii?Q?5H/SxGuEDGipPGXs+5jBtTCiUdaXT5GSzm5Hwc4ySOWIGMTgMqIe5vKs2kB7?=
 =?us-ascii?Q?wJa/tDNl42MEXWMBK+orSrnPDQ/RGHhULMEETQJQBOtfsLvjB1M9hXDE2Xdf?=
 =?us-ascii?Q?gzEWpJER5IcwgApxjqSjou4SWLJy4w6Kvq9ribTGqDqk74g727x/cWL5jY9p?=
 =?us-ascii?Q?raVl+7HeG78jiZwyw1FqPcBPSo40h5gCWDm5trRYiOMjLu5T1bVd0vcZI6dZ?=
 =?us-ascii?Q?GbbErkhk3KIvWTEZMA6SK4LV/PI54WGzU00l8Cdxo2qG0GYOped6tD+KE8wi?=
 =?us-ascii?Q?IEK4oqUnAqpd4iffbvE3fLFksFG/XZeYUh84SAEAesXGZrGHW8RexIVLvElZ?=
 =?us-ascii?Q?fOcqb53YKgenpvno6btpYjiAW7+IpxrlxWFMjSVP29Nk2p7d4Cd+K5Fi98bE?=
 =?us-ascii?Q?gVYkhecNet7xJ5WZbUlmLBeJlXx3NISxb+sR35D50xNOQ79tPBWcGs56Qg6c?=
 =?us-ascii?Q?joxTcyEsOGCtaPgtQdhoqlT3Y4vdCsiMuABuVkmLuRSZj26cYJlutWxmzX4b?=
 =?us-ascii?Q?H1hAsxeoceqHcaBuPQcXODHMKMfh0b4uOW8y0tYIxvxZhLrr7AJVGAWhdE0x?=
 =?us-ascii?Q?Mm6MRRKoi2DNw/1DfP2qDneVCQXCi8vXhQydI57IdGkb5bzykFF0cXqX7QLW?=
 =?us-ascii?Q?EcRyq0n80U4++6s67Tt9qTdGGDQgTw24Hr1gbaPwDg2JNu72frPIxPtBM/cy?=
 =?us-ascii?Q?eAIGMfam5YLO1KOwE2+4EMzG8RvwvH9x4DZfutFCYzY8Uj38WLPez+AQWo3i?=
 =?us-ascii?Q?xR+JxfiNv0QqnL0kSwoBN8FlzfP/xyWI/dCW+J6Z3PBhVrnPmJSH9AJJVgLV?=
 =?us-ascii?Q?9YUxe+Xl4DvPzZpopQxy24hNpp2rishTj4V9VBMaz+iJZKeqTFF2MK03o08T?=
 =?us-ascii?Q?u86OM51Yfwe5HiTQ3fnYRESpBoSU/7jrFKVKVpQpw8I/JBJf0EEPc+mdnEdC?=
 =?us-ascii?Q?pie3jNCb8qLV4ePTDaizNNxgr6QRUkrBKhIECEjgLEoQV8o5shwLTO18Ek8c?=
 =?us-ascii?Q?GC708WHvzdhtJ8AoxY47TPLRjKLuG2yE1RGQFJGC6TjRKde50tZcg8lVsaTM?=
 =?us-ascii?Q?ke3EBIxXDnQbX0RBfzv5PMwHypyoophJINAY4yz+mXXNS0s3tAN/ab4khz2n?=
 =?us-ascii?Q?vLLxt/+k6jTjhAIIOYIUaDj9yKtuCHnkLJaYgf+Mt5Y2ZEoWviK7D4tfOYRz?=
 =?us-ascii?Q?b/PYM30BBSxlRHt0e5evpz/+FesBJOx46+1bInFNGOTvN1JT7DrMADQ/G8wk?=
 =?us-ascii?Q?D3oBdBeh5WXgPI9f7kLaDP6rwfnSMLEfUqH0aJafo/Grhl/OWBq/TSlsuTua?=
 =?us-ascii?Q?yYw/hzaKFfKy5zWE+/4qCH3uVOoi/pIWCwS/iktnAPiTWvii4WATB5a8FAgS?=
 =?us-ascii?Q?cS0LOmEn4sOgWzDYzPxRdoIegjpdb92K9yrmWo5lRKzY08gBLo8rnw/GgCmm?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c435eb-9ca4-45b3-2774-08db88610f41
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 14:04:25.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQYfXfQbXIiktvg+Hyz7/duzWu+gJwi1t5nMjRwnRnVrtL8JPO/Kmges/ppXoVNrj3UnXNU8+Ge+f/1emEIPykGJZZ/9QA/zkD1tncfJMS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4590
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 07:47:21AM -0400, Przemek Kitszel wrote:
> Reset VSI stats on queues number change.
> 
> Commit 288ecf491b16 ("ice: Accumulate ring statistics over reset")
> implemented functionality for interface statistics to persist over reset,
> but it left stats persisting over queue count reconfiguration.
> 
> Following scenario is fixed here:
>  # Observe statistics for Tx/Rx queues
> ethtool -S ethX
>  # change number of queues
> ethtool -L ethX combined 10
>  # Observe statistics for Tx/Rx queues (after reset)
> ethtool -S ethX
> 
> Ben has left a note where to place the VSI stats reset,
> what made this fix much easier to do.
> 
> Note that newly allocated structs (case of num_txq > prev_txq) don't
> need zeroing.
> 
> Fixes: 288ecf491b16 ("ice: Accumulate ring statistics over reset")
> Suggested-by: Benjamin Mikailenko <benjamin.mikailenko@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


