Return-Path: <netdev+bounces-30117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75A7860CC
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0C7281359
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71581FB38;
	Wed, 23 Aug 2023 19:40:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D32156E6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:40:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAE8E6E;
	Wed, 23 Aug 2023 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692819656; x=1724355656;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CRZ1SUXZCT0w/s3CU9+w5K12UDdUAevXoFUIEC3trGE=;
  b=VjCVfJ6UlMtv5MdR4CClOl8JuW2D7zHdytJlK17jKehjR+JfecTyyMUA
   7WjCo/txY/Y16h/U8TOFLV6xejIk6lJQL5H1/WC7kMEsHzpnDsHJlzPVn
   0DdIOTE+1sgIJ3GQZCD1xER023EvSRmPNhno/ZaPp0KS9XCmb2sZeMmJZ
   7uC9hBLAmERoyDfvql6a2upC+E1WkCtP88D8jxu7uzv3Q1bK8hab5RpYX
   S3UyhKi+lKaFaoPvfmLOnuMzB2Ipfgweu8yGV1ZrUZKU+JPy+c0pwuRYc
   nOIAQ4BCzE2ltpauzFHz6GV6DhykdVGAlwVttN4+BaJSNRF1w6gKHXqw1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405258398"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405258398"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:39:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="851166398"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="851166398"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2023 12:39:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:39:54 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:39:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:39:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoRDIKDdU99OnCqfMbEFgfNGa/2HcFuREVUTcBjpygQ6dUGXnx+fRmL5DgX8tPvl9UkTCmsdJpDEtm7Mxx5XGttBAHLXUdCxXjYV2EiQq/r0486KOj9m/ek3Jde437aFzkI+q8rZPc1MYO86R3KKhGD/pl3T4shd1dx7MEhPSLoxMy0QICMDle9BIN7ncA4KvqPIJCvl+HtiJaZMnVgrl1VFD5DCn2WG53LhQStmkxtEse2hcuBgVbCGLog0GHL/qR00xoOoKGIAvSkX56xhncUndWSjEMGycp/g5/mcPLbZSzzRM9+4eOSJbkSkLnn0ZvJWxx8At3bdvdd/2Dc48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OksTyNu+tHaM11RjSPNwdNUMm32XOXTO8SDl/DPxmGY=;
 b=BXMv73yCB9obgV6fokJOl/jZoSIXaMVUnTvMjIIh9HJohzDHMEtHwdmZA24m7LrS8QJVe99yxLfLtB5jKMsVjxeRYLVd00Rl0LB/p6sd8rKDlG738S3aOMRW7pNBc8qzaMvQtlvFjd2uz4Kt+F/PIBXQ+W4ZAjEyHD0spJVAgygMfcHTUSDHwEGVaBYSJHArDLqdIJWPpEOAkNPjW/CQafxSm3EvZXOPHsVvTLVXDOz/LMEK0YAPcyd7Edi/BqhA+Jh8gKp7mlbkVyBevmNnPJmupGIwEwES3zWXrRn4Yo/Y6wvQ6qv9wtuI8DmAWPEjz1EzCx+Cv9rgV9qF9BZ6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB8334.namprd11.prod.outlook.com (2603:10b6:208:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 19:39:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:39:52 +0000
Message-ID: <db817f88-8c92-26ec-9d2f-591d6415a4b5@intel.com>
Date: Wed, 23 Aug 2023 12:39:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 10/12] doc/netlink: Add spec for rt addr
 messages
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: <donald.hunter@redhat.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
 <20230823114202.5862-11-donald.hunter@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230823114202.5862-11-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:303:8c::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c95ec5-9f87-406c-232d-08dba410b858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cRVwSZjasC9OS8780GSvdjafKKHv3oxLtTrxrue2kvdDv/OBmf6kKoh2cMUGQK5dGKSGbch7DWYKldv8NscwSR4hJqlk6laWxqOBLi2iu0cULE6Z9EFSbghT770OKJbOTUwDaAFUOTeYOXeCFSwrbcobVyEiQKXqZipggXMMlgpAK4l8KisAqTY31oFEehm7vENvy0FugPSs8onLoowMdnCxzjGbs3LRP8Yhrpg+b4EYw67AfDn55B6E5MshCv5m9dsZd45CG6J0anwKg9LCI+ZUpXUy7CQ0mZyZi2rU7r6wFCg3okGaOldgaFz4dTBXush9UyXBTMrzeR8GIbLio/+AAoTu0P+ikPZ7nPzzClayfi8ySjGf0y14/+9hNttRCr8kWPMJJ3OtIUvGAvcbF5Ylm+sc2gSHJAKyG0SQNeWrv7dvaM6TiswiFfbi9WnWtRyREyH3B8clq3E3IiEu1WUz/xkvZRetDb76c33x8wj8ftB1lMkoUdxjTN4Bl4yMBxx93z0t0644hxKNZYebzUaXty9SEYgV7xf+qV8EorOP39CPcp/qdztHpUr7W5z0n8Zh7xyeyExYG4HNQsLNEqYR954ZWZWQJD6No04mswCoRpFJSF5WCmQ2DkCaUPfWt7EzAlE1faNHQ3VOjzt7DnBDWvoM5Nf9yQaTO2C2BU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(186009)(1800799009)(451199024)(66476007)(66946007)(6512007)(316002)(66556008)(82960400001)(110136005)(6636002)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(921005)(478600001)(38100700002)(6506007)(53546011)(6486002)(558084003)(7416002)(2906002)(31686004)(31696002)(86362001)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmY1cTFucEdkSmE4RERKelBackpxTXY4R3RyaXF6T1BmODNJT1JqWTVRYmF6?=
 =?utf-8?B?N2Jib3psSFlVZW85OEtQVE9WRGhkL3dzenNCZmhMT3N5R1h6WEQ1Q044Q3Rk?=
 =?utf-8?B?V3piN3hLK1E0N00rdFNhQ1RDRFNrdGlIbXpyTE91Y1FnV2c4L2YrZTJETHdt?=
 =?utf-8?B?WW9MSGtxRUdYNUpxOVdLQ3pRVzJ3ODZ2a2NIaTRZa05PV0x3TUxGbVE1UDhD?=
 =?utf-8?B?b09WRyt5WnNmWUo0cjdVZGhnV2V4RjhUaDIwQm02b2RxcmoydmpxRGRmZTAz?=
 =?utf-8?B?bHREeGxMbC9MRVZoUXc0WGZudmFzRWhrYURvcko1akhCNTBoQjRzOC8ybGlW?=
 =?utf-8?B?UXYzazM4R2hZeTk5TXpVUlcwN0gvakQ4MTNZU2pxZlJtMFBuOWF2K0tDU2RO?=
 =?utf-8?B?WDRTTUR0aEswUkFQWGpmSmdtcC82aExuaVcyNEZQYjc1c0Fsbnp0RW4zVXZ5?=
 =?utf-8?B?YTEyWmJ3dkxxNlJDSnVHVzgraEpjNHBtWmQ0Umd1N0d2Qk1QM3ZrOFlSMnJt?=
 =?utf-8?B?aUhBa1FQYjA2R0pYcTZqMG43YmIzV1Y3M0NrQytKR0lmZlczc2tHUCtNd05J?=
 =?utf-8?B?dmcxWXFxWmRvODg5Rk84Y0J4aFVBblYwZlVqcDA5TXhaYmpuczBBZ2JoaDgv?=
 =?utf-8?B?MVpyYXBhMnpPK2JLdDY0RkRQSEsxNFAzYUVQSkMvRkxIYWpFU20vZzB6S1N5?=
 =?utf-8?B?SkdKWWdIRW1MKzh5UVBjd09WUlE2c2w0U0VUaEN4TVhDRHFWdDlyVG9tYXNW?=
 =?utf-8?B?VHFPQ3Q5dHdMb0JDNVpndzQ4Y0o3UHBrelV0dlphVXQvWmU2WkVIeEdqYlhM?=
 =?utf-8?B?MDg1WStCMUN5MEVXOVpwY1ZzSDJaWEozWW50Q0RJNjcvUUM0dDFYVXZYdy9v?=
 =?utf-8?B?S0pQOWhURWpjR1Mxc2Jrd3NhQ2N4c29hanR5bUhUOG93aS9XcWpvR2dJait5?=
 =?utf-8?B?bHltK2ovVEhaMVVnVnhjMCtzN3JoQ2Z6TVo5R2VFVGtwcUVXbHM3bHRYRVl6?=
 =?utf-8?B?UTJIUjlFMlNEVFlWdjZzZFcrTkk1R3MwSUoxQ0pXeTJza1lMOWJOZEtXaTVm?=
 =?utf-8?B?Tjd5QVNJN0RuL0xmZE9WVHdDSnBpYnpkUXhuMDhtVjN4Tkt4dkpreGpCSkVM?=
 =?utf-8?B?bGlzczBSK0F2czNucGlQUllUNGhka1RFbkhiMjlxZkdyNnRsTHF5eWY0TWRO?=
 =?utf-8?B?OW5KYkhFSTczbVRHUHRhOWhab0hLZ0ZwZlZmYStnMGhGMUw5ZXhndGMvSjI3?=
 =?utf-8?B?Wk0wRTdIUkFlRmhMeDBGR3dlWkJFZ3pxSXRJUm1FTGh4bWp4V0tnT2xMbkp1?=
 =?utf-8?B?MGJCdkNiNk05c3B1VFIxdnEwNDVUWW5JSTI3cmxDcGt1d2Q0VTZlQjBOdFlV?=
 =?utf-8?B?N01RdFU2TkhENXdqd1A5TDFJcEQ2S2FNdTBGNGNCVVNFbk9NZFNscEVTWlpI?=
 =?utf-8?B?NnZKNzZPcDRmZDlhMG9tL0d3YmZSM1RPNVZYZTZ3WE0wM0tMQlN0bE9uemh6?=
 =?utf-8?B?ZFNrdHVCVHFxMzJvMU5CNlp2Si9GbkJ2eXh1aXcwSjlGREJTa1IzS1hGVWZS?=
 =?utf-8?B?ajlHcXN6enJKWWNVSWN1QXQwYVJ2eGRSU3UyUDVVWngvYmlEZzRpUU96UHph?=
 =?utf-8?B?THFKdnc3UHk3b1ZZUm9XQUE0UE9odnByNnB4TGd4bkNUa1hnbVZVSUc4MEM3?=
 =?utf-8?B?bW1xcWJJdjFobUFYWmtWZVVlWUJIRzNrWHlrZkpNbjh2Ynd4UGhZb09iY1ZM?=
 =?utf-8?B?dUEvNjl6enprM0JKSHR2MzE1UWdYcWhrdXdVbUpZcko2bEhEbkhtTG11TjBT?=
 =?utf-8?B?Qm9BQUt1VEVQME1LOXppcDViWmVCQ0poOGM4QmJKdlBHTlhyc3hzdU40WFk5?=
 =?utf-8?B?VkdLUzRhWm9XeHBjYkp6YnFabkNZRXVpaG9jZzJySjQ5VE9NWWJEUkV0OVFW?=
 =?utf-8?B?MGlhMkVUN1UxK3RDdHYvQjJ0WUFJV3JOdlQrbzFNNDJ4WXkxd0lYL0ZvWEdj?=
 =?utf-8?B?S0dqbFZmaTNCZktwWG5EWGF5ek1OaXFzaldSOWE3bkFjNFNMdEpzeENhQ3Qx?=
 =?utf-8?B?YTBTUk5Qb1R1VWgvRDRLeUF3SVE2b0dubHYwTkorNXBSd1BKS1NRTUdMTWlr?=
 =?utf-8?B?K0lPNVoxMHQ4NXNMSFFNTjByYklyT3B4YzVGcm9Lb1gwbXZnRENVUHg1MUFi?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c95ec5-9f87-406c-232d-08dba410b858
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:39:52.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDYuajE/W0HK/6KndfvKBsL8OcOf6B62NCCy9uNTcBlVGqi0Jp2xA+RkvcJodd5odCqXTgePjQXIoxhCkDe0wS6mVeUR0tZafN4ltRWqfjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8334
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/2023 4:41 AM, Donald Hunter wrote:
> Add schema for rt addr with support for:
>      - newaddr, deladdr, getaddr (dump)
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

