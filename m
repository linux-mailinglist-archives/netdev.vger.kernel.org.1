Return-Path: <netdev+bounces-39571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47D47BFDA7
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B9A1C20B40
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFC59CA7E;
	Tue, 10 Oct 2023 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBp2Ex3z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283699CA68
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 13:37:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17940CC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696945030; x=1728481030;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ui6v0wILNffkUCiQ84MD2MYeJ6hWhmcOGpRy4v9sfus=;
  b=OBp2Ex3ztrzfWSWoLXOJZ1fj+MWqn4Jcn3vY4BiK94nUsWvAYzCDR3F3
   flJ0a9woBIPkrBP59zUnEIKB1dc/ZpsK/m5v9Bw7aOdgFl8k0kG4YYoAt
   KVsF/q//AYq2Av5LdjMcd9YnGwzdgcteieNuylYIlEd4iDwo81yJb6ZrO
   gqzqfb3WY6YnNIrTJp8GtBI7ldi64vKA4eiYDoqleHBTIuqMrRnRRSluC
   1gCgJ25vXFFM43Sp+o+RXmmpAgO5tGAVdv5OhENqFU6fiaSuXZkhcnn/D
   PVDeG6VoEGCIJWOWtEsuZ0k01p2qvZv1wmq34EmKmEqedBZuMirHZQ7G3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388263503"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="388263503"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788583169"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="788583169"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 06:37:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 06:37:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 06:37:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 06:37:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 06:37:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsH9WFEnA8ASb046G9cLlTIZxIoCq+gOCI0tLPiUz0YqEnpu8K82cc+gmnrE+drZJpAeY0Cqb8+mM2ooTmH0n2MFy3e0qrlezvj4XZpbHFtxOCIx13N6f8L15NHRkU28Zrn1okmNUzrpbzwgV5kUp11gVvvBDYwlGJWTUrP3CaF3MTRPuPsuPxJ5g7BaNqiOgUT+ZWw2zc4OKsFqA0cy7qCt1mJt+g92E0Z0i98nlG0+yvu0OndS6/HtnBlerIxJvRbS9ilRnvAlTuCQuVIofcMhNQ4aRYPE56kRZBObS6MX0zRvEMMxPtMX1ynNqLzTuF6lVV09ZX61PaNf2EjLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaRG0zfULg9CRiWktsmXzB5nQD08MVuLto7DLwPxO0Y=;
 b=S0n9PuenAMunuRX9CrM3dswDKLJjzWgceR/edg/IfkSEEvSzRZj93x37frQGjb/9ZYxgkDc4PEhYD4xqRP5cngwUU+mvo4v3V2L5hQwpaQwQm6Iv8950GkDnTuYSxEXiQgCuCyv6IS64f6IEXta4Ct8iwXWbyEhrPTz3KYMmanwGZbBOEFzNpLinLBKTH+ft54knPs5tzVlln/y5Lb6O6TVuKO6bxWln1/mk9zyP3tQHC7wEj3kj2r8RDRGlaFhkLrkLetjsNBlMr+8i66gSkA4bEfBN+4l6e3D6/XJPKG2ZrIk9wYDKCWSxOF7LEadNAzUHp2sDoO8efilfAnXbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH7PR11MB7477.namprd11.prod.outlook.com (2603:10b6:510:279::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 13:37:04 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6838.028; Tue, 10 Oct 2023
 13:37:03 +0000
Message-ID: <8193ea5f-7be3-6d21-3d6e-067ec2bc200a@intel.com>
Date: Tue, 10 Oct 2023 15:36:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v1 1/8] devlink: retain error in struct
 devlink_fmsg
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shannon Nelson <shannon.nelson@amd.com>, Michael Chan
	<michael.chan@broadcom.com>, Edwin Peer <edwin.peer@broadcom.com>, "Cai
 Huoqing" <cai.huoqing@linux.dev>, George Cherian
	<george.cherian@marvell.com>, Danielle Ratson <danieller@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Brett
 Creeley <brett.creeley@amd.com>, Sunil Goutham <sgoutham@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>, Aya Levin
	<ayal@mellanox.com>, Leon Romanovsky <leon@kernel.org>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>
References: <20231010104318.3571791-1-przemyslaw.kitszel@intel.com>
 <20231010104318.3571791-2-przemyslaw.kitszel@intel.com>
 <ZSU2vH/As7RIcH7W@nanopsycho>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZSU2vH/As7RIcH7W@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::10) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH7PR11MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: ed62f15c-ec3c-494a-5593-08dbc995fcc7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6Wa30iv2oBmX+2aoVuG27kFUAPgRG5Pvby0ubV+DC4PHb0WauYKVcowUkNEiI96m0rh/la0RIXNdtTtWDPVf8WSgVtnIY6xGccaapugY/AsWAtzAgUbJcQfNuhB7DEgPK10e0RaFc0kKTQCQTQR2446wu4e2wz59GD5pzSnyLhP4nJJDah46qyNXhC7ox0Ygnz1IBjmQb+7MBhHIFqRbOz3sDBlfqZoQRsjVuG9fNrxnlfmSCoEG/AX891gwgmCj+7t7XAcPmRwgGTaFU6oIlAhLdhLA8qkpmB+GPH1O1GbMZE/EJ6WMC52zjP5jneoxoLiC6UrAYtmTWhv8s3b6wGKHDQXMBjEczkAelhMr+XZlHLNCfsuj6KIvMjG4NASq7TuNme+4CSWQUU/0PPJf25H/m0KJGxZJjTDpqflM/hiios8GOkTaQ7O6ryoGAVbNlrbcz29b7rWQT4oh8qecSqVgkuduxiWcFURLm4hcqPsrXQwBqZoh8F5S2eXN6dBs4jscFcNDbiK+luLx0N9bGKdiCH27RH2rr3/xeu4QX6Yae/6lu29Eb8uA5Eqgw09bG9DiEM39InGa5Lg36IPvuWjfiQjhyPayGxslSiJrwUUQfiF58e9Bo2JdhDic7Jj2zrw7g7U+mB85ZalgIvVfyKwHPAWs+S6ImWsArQ6ySI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31696002)(86362001)(82960400001)(38100700002)(36756003)(31686004)(2906002)(6512007)(6506007)(478600001)(6486002)(5660300002)(53546011)(8936002)(8676002)(4326008)(6666004)(41300700001)(2616005)(83380400001)(107886003)(316002)(66476007)(66556008)(6916009)(7416002)(66946007)(54906003)(26005)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGNSQkFUMzk0UlhjUFM2WWVFT0l2Z1lRakdoOW0zRzNObDVMQW1YcnZsUVR2?=
 =?utf-8?B?RDc2ZTFNWkJzb0Z1aEFLK2cvUkJ5dWQwcGxrcTJ4SzVZamRPRC9mczA5YytE?=
 =?utf-8?B?cllkRXllREhGTTZiUUpiOE5rQjU5ajQxMVRIK1plOEdvZytGUExQdTVTaFpH?=
 =?utf-8?B?MUJ5S1FvVTRPVEZNd1lvaHZOWHFlSk0wS1FlazFpVWdEUTBjOTFHUDFtN1lh?=
 =?utf-8?B?dTBQbWw4Qmo3YmJ6K285UmtKRUh0R2VWZkFUNUNOU0hENEhGdUVYSjVXMkFZ?=
 =?utf-8?B?bFM1dnlWd3pWU05USjZHTmVXeU01TXkzRFJNQy9MbldaWWtJK0R1NVNraDg4?=
 =?utf-8?B?aTdjSVkzWFRFcWNlN1RLbUxzYWhGcWhjaVJKeGNUYk5JRGt3SloyZ202Zm9Q?=
 =?utf-8?B?eUpPeFJoZ0JSajB1ekYrb0pSUFBkek1NOEpqUGlmR3Q1RGxkdnBXSC9iYzJW?=
 =?utf-8?B?TWVKQi9QWVhPTDBYYytsUERIMVBMT2dFemZ5aGR5SjI4cVh5dUZjL3FvaXJx?=
 =?utf-8?B?Y0pwYU43d2xwVHhZa09iRncxMnA3STIzcmlyM2dBNmRTazRjQWNmZ2hYdXBO?=
 =?utf-8?B?bFZoZThrQkR4Q3pPTXBpVkpwRGpJbTdCZ24rOWJkL1FaNUdUa1VBeXUxbW5V?=
 =?utf-8?B?Vi84d1JBM2I1bEpkY2pKSjNNeGlBdWI2dGFYYVFtOW9sMklPU0FKRUVkZXhH?=
 =?utf-8?B?dFdFVTc2ZUVvMERXWmhKekxkUjdRMS84VCsvL3hkQWVWczRWU05nL3ZXVFZQ?=
 =?utf-8?B?ZkluN0dFL0lqK3ozQzBBSUZOTk9uY0M1aVNOcFhRaHJhZU13azhyWkNWSjRZ?=
 =?utf-8?B?aWlHUnRrU0hqMmUremIycG1tUytsMjNlMWs5aWFDYnBXbEExTVdTd1htakJF?=
 =?utf-8?B?Q3pGa3NzSDZ5Z3d0NnYycjg1clAvR1V3MThRMzRSZDFLbVo0OHJnSGU0SndG?=
 =?utf-8?B?ZGJvaWM1bFVQYjNPZTExdmx3VGNGR2lCYVlzNFJrNkpPZ2l1QmhlK2hxQWFx?=
 =?utf-8?B?dnZDdVZNMzAvM2VYWU5HblltRFcrRXJoYjZHUE9wUW5IakRzL3VoNktQZnM0?=
 =?utf-8?B?NGVibTdpWDRGK2xVd2tuZ01lTG1IWjIvbkxSYnFrOTZDZTEwY1JWc0JyYk5q?=
 =?utf-8?B?UmdsVmFKS1d4c3AweWJwVEI1Y0k1ckFPVWJIS21Rc1FGUHlpcVkweGludVVn?=
 =?utf-8?B?RkdVejM5Qjc0bEZNWGRLZW81MlF1aEM0aTV3bVM3SkpjUDBONnEvVlFuVEZL?=
 =?utf-8?B?R25uVFVvYWZkSUJ6QlZuc3hjejN0QUlaMDZxUlExVElPVVgxWENKcDhHczB5?=
 =?utf-8?B?Mi9mRTNiM24vbURydVJNenRMMzNFaythNnowWTdEMmVkQWU2UGZmVEhjdE1l?=
 =?utf-8?B?ZDQwR29yNi95MWRFSEp5dDFxa0F4ZUZLamVqaVlVZ09HS3BXeWhUVzZhaVVY?=
 =?utf-8?B?Ymd3cVJ6cHkzOUJPdExRUWp5SDR2WDcvdE9uWjFmcXgwS3J1a3c3a0pFUzdV?=
 =?utf-8?B?QXFvcFA5ZDdadzRrMHdGUmdMSWs1U2EzdXRvUnN6K0ZmVEdaUVdWaHRyMGFy?=
 =?utf-8?B?OXpHVzRwSHRhc3pza0lSWksxdWJVY2VxbUVPVXVWVnA0VDh4cW04amtZYWk1?=
 =?utf-8?B?UDF5U3B1eTdScVR5dXA0RTBGSW1hbFpDZitqVkIvbmtXYklhZ2k0WDRNT05Q?=
 =?utf-8?B?aEZIYi9CT0JwSXg0cStKT1R2RzN4eUkvRGYwcXk1bEsrTUhoNCtsblo1MzI2?=
 =?utf-8?B?b2ZXbGxjMmY3YkhaMWdQQUlndlZtV1FBYi9VZTJHM3hoTjM3aDNqUndwOTJU?=
 =?utf-8?B?RHJKUUo4WlBNaHNpZENkM1VwSDNRTEN3dDN6RklpODYweDZGZXpRSlpGbUtD?=
 =?utf-8?B?eWNQRXBDbk1EcHNsbW5vWUpuVjdLYVdJNDNXUCtUWi9ZbjRBd2JHY3ZLcTVt?=
 =?utf-8?B?VU5yanhNd2djTTJJMXc0enpKNTRNVFU0V09EWUVBL2hCdGVYdUJLVDdUVE1I?=
 =?utf-8?B?WU5PU1JSd2E0Nm5WaVJxNnFzR2VPWFp5dUJKTXlub0RLcHMvSHRXVjVZb25B?=
 =?utf-8?B?d2VYVktXTytuVUF4REV5dzQ2NVRhRy9OWmtBVkRaV3VpVUJnaG8wSWJ4dVMw?=
 =?utf-8?B?VGxxeENjdFptdEpvS3BJQ283WDVjdG1UREcyckF3bHNzTm1uV1hFRFh4bWpN?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed62f15c-ec3c-494a-5593-08dbc995fcc7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 13:37:03.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUQnjmIOolAnTpMYBWenY4sB4A5UYpJg+lF9qrdIuDy1ufA0WRKOdkqC0HcQ04pC4AQ7f/o52qVB0Nh7CEtTbOciNB8g3Kuv3cL5MmprBeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7477
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/23 13:34, Jiri Pirko wrote:
> Tue, Oct 10, 2023 at 12:43:11PM CEST, przemyslaw.kitszel@intel.com wrote:
>> Retain error value in struct devlink_fmsg, to relieve drivers from
>> checking it after each call.
>> Note that fmsg is an in-memory builder/buffer of formatted message,
>> so it's not the case that half baked message was sent somewhere.
>>
>> We could find following scheme in multiple drivers:
>>   err = devlink_fmsg_obj_nest_start(fmsg);
>>   if (err)
>>   	return err;
>>   err = devlink_fmsg_string_pair_put(fmsg, "src", src);
>>   if (err)
>>   	return err;
>>   err = devlink_fmsg_something(fmsg, foo, bar);
>>   if (err)
>> 	return err;
>>   // and so on...
>>   err = devlink_fmsg_obj_nest_end(fmsg);
>>
>> With retaining error API that translates to:
>>   devlink_fmsg_obj_nest_start(fmsg);
>>   devlink_fmsg_string_pair_put(fmsg, "src", src);
>>   devlink_fmsg_something(fmsg, foo, bar);
>>   // and so on...
>>   err = devlink_fmsg_obj_nest_end(fmsg);
> 
> I like this approach. But it looks a bit odd that you store error and
> return it as well, leaving the caller to decide what to do in his code.
> It is not desirable to leave the caller wondering.
> 
> Also, it is customary to check the return value if the function returns
> it. This approach confuses the customs.
> 
> Also, eventually, the fmsg is getting send. That is the point where the
> error could be checked and handled properly, for example by filling nice
> extack message.
> 
> What I'm saying is, please convert them all to return void, store the
> error and check that before fmsg send. That makes the approach unified
> for all callers, code nicer. Even the custom in-driver put functions
> would return void. The callbacks (e. g. dump) would also return void.

I was also thinking about that,
what about cases that you want to exit early, say inside of some loop?
add also devlink_fmsg_is_err()?

anyway, I like results more with ultimate unification :), only then all 
the drivers require conversion at the very same time

> 
> + a small nit below:
> 
> 
>>
>> What means we check error just at the end
>> (one could return it directly of course).
>>
>> Possible error scenarios are developer error (API misuse) and memory
>> exhaustion, both cases are good candidates to choose readability
>> over fastest possible exit.
>>
>> This commit itself is an illustration of benefits for the dev-user,
>> more of it will be in separate commits of the series.
>>
>> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> ---
>> add/remove: 2/4 grow/shrink: 11/9 up/down: 325/-646 (-321)
>> ---
>> net/devlink/health.c | 255 ++++++++++++++++---------------------------
>> 1 file changed, 92 insertions(+), 163 deletions(-)
>>
>> diff --git a/net/devlink/health.c b/net/devlink/health.c
>> index 638cad8d5c65..2d26479e9dbe 100644
>> --- a/net/devlink/health.c
>> +++ b/net/devlink/health.c
>> @@ -19,6 +19,7 @@ struct devlink_fmsg_item {
>>
>> struct devlink_fmsg {
>> 	struct list_head item_list;
>> +	int err; /* first error encountered on some devlink_fmsg_XXX() call */
>> 	bool putting_binary; /* This flag forces enclosing of binary data
>> 			      * in an array brackets. It forces using
>> 			      * of designated API:
>> @@ -565,10 +566,8 @@ static int devlink_health_do_dump(struct devlink_health_reporter *reporter,
>> 		return 0;
>>
>> 	reporter->dump_fmsg = devlink_fmsg_alloc();
>> -	if (!reporter->dump_fmsg) {
>> -		err = -ENOMEM;
>> -		return err;
>> -	}
>> +	if (!reporter->dump_fmsg)
>> +		return -ENOMEM;
>>
>> 	err = devlink_fmsg_obj_nest_start(reporter->dump_fmsg);
>> 	if (err)
>> @@ -673,43 +672,59 @@ int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
>> 	return devlink_health_reporter_recover(reporter, NULL, info->extack);
>> }
>>
>> -static int devlink_fmsg_nest_common(struct devlink_fmsg *fmsg,
>> -				    int attrtype)
>> +static bool _devlink_fmsg_err_or_binary(struct devlink_fmsg *fmsg)
> 
> No need for "_" here. Drop it.
> 
> 
>> +{
>> +	if (!fmsg->err && fmsg->putting_binary)
>> +		fmsg->err = -EINVAL;
>> +
>> +	return fmsg->err;
>> +}
>> +
> 
> [...]


