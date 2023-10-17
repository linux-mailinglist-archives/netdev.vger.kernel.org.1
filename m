Return-Path: <netdev+bounces-42062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A767CCFE2
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 00:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845ABB21198
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E8D2F51B;
	Tue, 17 Oct 2023 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jue7ZkS1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A68430F9;
	Tue, 17 Oct 2023 22:12:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CC395;
	Tue, 17 Oct 2023 15:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697580748; x=1729116748;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l43wPKHJjFkM3t6IoQ1P2Nw8I5zM9NMmf1NqWvOfr2g=;
  b=Jue7ZkS1txKe0/Ms8vaLouVSUr9JWUKLESJqtqoh671ddSdav8d+QLIa
   /MD2482jlfMrK3Tz7O2jMI4RzGmhw+bq7XsdMCZRB0ovDgUkZ0JmaT4g4
   2WAcV+aF/RNNOKAfC2sSoj+O7/QKPrA7nW6pRwpCCpwPzx5EvJZheuUwg
   thpoRF3rEO7vTdBYcUkbfylTL4H9LpWF5cWJYzsCgROOdQEgt60DiPFrb
   1XHolNLbcWrsz/UZrrFTn05M6TKazYxq/Ba2eDAbbf7vYMFTFvLkLINNT
   PHMUiv9V8X3de6z4DHOhknLIbzaeykHqgBz+M29FVkKzdBAvxQqlXhz/L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="370952835"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="370952835"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 15:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="756316018"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="756316018"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 15:12:25 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 15:12:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 15:12:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 15:12:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le1OB91QEzQSA8/n5y4cxC7RwzUbf+aD/TThDEJWW4u65jrO/xK+8wSFeZYXAqpM0VjEHDGOjC48Tcf9l7lmzGtJAO4N4/lK3UFkc7RRj4cJlqj/sbV0PLZr7n2yNkwh+0StViCQGq83DydPaGTSdNmy5uxC4YnD/5Ne2PDgLetqLP4jGdN1fniOfrsN31VLLN/OAoPOdNFcDUuJgIK1BKg2MuzW46PvmhOoGB0IskBtAM6gTDXshHfTw/YnB4eOr+5/SUyLJPfEpuEXeXz0QIJikcM/9eAwqD0K5rw1FDTOV3EAUVqqxIMDsF1i/pA1QTZPw0sWdu7Wm/X5xFlQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McB66+KYgUdosNciaTkFrzTi9ZeSfGvuqymTTRjyOAM=;
 b=BHgxJouFpthwEJeKz473iQp4E+1MmyH245SLmSAPAx84frNctIjdur0+qjOmMr8FH4U3y0kD2O0lojnIDgs9E6kxa24G/dYeDomqPRIpeiTco/RLd4KnYgQDGNh0gb0HHbrIDpc29bldkZPobjnobKhYyNGAs4CEdFtM6RariijbNCQwaETH0gKFTuUU4rbqpcu/1pLldVoCagav9L/w3GGy3u9ZPoKbrbBJqdgR/ywVaSukebpT481bIEa6eK4CkfJoPGU/y130MVXyLJXeW9cfjXm/Wg3pOM5DGzugxIrH1jjWBAU+7kCH2Mw121vuwdgUKAXJKsu+DQ7p9iw2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by DM8PR11MB5672.namprd11.prod.outlook.com (2603:10b6:8:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 22:12:23 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 22:12:23 +0000
Message-ID: <ef588877-0ec9-43fd-a532-e3605139593b@intel.com>
Date: Tue, 17 Oct 2023 16:12:11 -0600
User-Agent: Mozilla Thunderbird
From: Ahmed Zaki <ahmed.zaki@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/6] net: ethtool: allow
 symmetric-xor RSS hash for any flow type
To: Alexander Duyck <alexander.duyck@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: <mkubecek@suse.cz>, <andrew@lunn.ch>, <willemdebruijn.kernel@gmail.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, <corbet@lwn.net>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<jesse.brandeburg@intel.com>, <edumazet@google.com>,
	<anthony.l.nguyen@intel.com>, <horms@kernel.org>, <vladimir.oltean@nxp.com>,
	<intel-wired-lan@lists.osuosl.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
 <20231016154937.41224-2-ahmed.zaki@intel.com>
 <8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
 <26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
 <CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
 <14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
 <CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
 <20231016163059.23799429@kernel.org>
 <CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
 <20231017131727.78e96449@kernel.org>
 <CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0600.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::20) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|DM8PR11MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: ade7e1cd-6fd0-4b68-e66e-08dbcf5e22ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3wIkahEnGL0Vr6MOH1k0+uSulc+EfZDZVfAIv2abYxCgyEI+2DO66XwReGQC42P1/xYcYrCquT++NI/2HSh+ZT1NMoBgJFCyDG8rxUjqK9jLUGRYWHCrdKoxZZTWZVE7/ETXNk0HoHYyUrZXYNL69LgEXO3uP54MqwVKjzgnAKm+2cvw1+utGpsYpJqAi1HLhatHC46vKyghD7YHjoXYvf6cE/2Qd9srhNbzoWyosBm/Wsf3a241Q7jyufnwTNGUCAgXD1s2sQelL/pfpokUaI8F+D8KGJf+/9f9Oe3beVg5vbFHg5wyo/t/uuNlEs/XPVioq8tn6Q3jia2M9i8qjpShRwgZkQ8ha/TkiDUTlZruVoMOJzTWAM6MJ1cjkFOAlqhmvhLndYk5DMEA8TFsUhkAuhkLzncoBStz6bMWJXTXax2Vhl2zsxRaYB2jDSXFBNyYQIbEEFyWuJeLuHc60DlCjVu/EXBTC3i1dqc7lrct0t6OsIlMpB9jhdy7kngCdFGvNllTQNvTR9tS4YU7ptz4A1OSl/IN/Qndsfs0vKsVewjocIiEf01jvh/FiMihNltsTyQpGHXCbGd4y0+SlTH9u4swHLcAcz3KGxq5619l25QahIUoz1PiOUi1ZyvaZZ2fPHoxESJgxfwHM1DYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31696002)(38100700002)(86362001)(83380400001)(31686004)(478600001)(82960400001)(66946007)(966005)(316002)(110136005)(6512007)(66476007)(6666004)(2616005)(6486002)(36756003)(5660300002)(41300700001)(7416002)(44832011)(2906002)(4001150100001)(53546011)(4326008)(8936002)(8676002)(6506007)(66556008)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDhsM0ZRVUFtaDAvOWhzdUNGRVNGOGQzOHdSOFh4SXcrWm5leHFFOFp1MWdr?=
 =?utf-8?B?bnFBRzl2b09oa0Z6Ty9lem5vRThjMCtZdkNkYTlKVU9iV1d0eTFJSnR4clJY?=
 =?utf-8?B?QnRucUZya2p3Y2dRUlpEVDhkTlhxKy85V3p2YjkxNEllRG5wOHdaOEdVMkJk?=
 =?utf-8?B?NGFPUk93dkp4R0J3MW5HazduQmVzZDgyVGh5aFBCTFVqeUdBZGo4alA5akdo?=
 =?utf-8?B?b1FPSDBZZVlSY21pNHVPZENDeTBrancrYlZRYjRWY3VnSko4N3RwdzNqUGJj?=
 =?utf-8?B?Ukk4M0E3NzBOWXVnQ3MzaUMyL2xTSmRteTN1cUlGR0xDSTl0cUlSY2RMM3Q5?=
 =?utf-8?B?RjllbjV3YjhlRXRDMDJlN0JXb0FDTk03M3h0WkNrV2pnVGMraXpNVGZPUTR1?=
 =?utf-8?B?K2JKSzFUK3RmVGJnRk5vRXg4cGFRK2FtclZNV3VJa3JqN2txNFBCZnh3Rnox?=
 =?utf-8?B?eC9KOHdUZ0RLUTZIbzdvS1ZOb0t3VEJxK094czc2d001TTJhY2FmaEVCZmRz?=
 =?utf-8?B?ZndkVHB0dFgvQjJZZG5UZG1KK3dMM0VCOHhxQWlIOFhZeWtkdFg0U3JxcmVI?=
 =?utf-8?B?MjVKaUUwemRLcWo1eHZockgvSThSeDlzU1BJY1RrMVloNm5JRUthcDE2V1Fy?=
 =?utf-8?B?MVFSU1NKdVd2MTlzMU4xWEU3dHFrNGdVNFhhUnpEUmNWWEVJVmNaV0tHSXFo?=
 =?utf-8?B?ZWM4U2RJV3pxdEVQbVVtZWd3S1Myc25JaTZDNXVXYkRzMmNVcG9FZ2x1L3M1?=
 =?utf-8?B?Rm45Zk41WkJobjlEaURYZUhsQ2h1cVcyOXd2dENVdUdYS3B2RXVkVSsvZEU5?=
 =?utf-8?B?bDMvR3lSbUYzeDQwNGtzY1lDdGN3VnlGWEtqMlhJZVlleXFwYnlvK0pBY3cw?=
 =?utf-8?B?L01zRXpPb2o1WHNoNDRRVVUzNUVRUkxkY2dUQUo3NmpjVW51eExLM0xzRHgz?=
 =?utf-8?B?TUlxR09NcHl3MkY3NCtZN2oxelgrR283NmtDaGJFd0U3OUxtSU1qeU0vSGNF?=
 =?utf-8?B?VS9teXFtVWVTZER2ekY4UWx6ODBXVVZBdFZzTUdPL3Q4SWhIS3VjN2lzb2lx?=
 =?utf-8?B?b0tYb2hsMEtkdnFQbzdxb1JheUtHYU1LdDdYMndGVGlzQzZkOG90TFZpVkRC?=
 =?utf-8?B?aXM4SHhFYzZPWUdGanQzQTBLejZ2eWZaU2V3KzlKZnk3Nk9udktzUG9IUFox?=
 =?utf-8?B?dC8xSTBFemxiNkFZNDFvQ3ZKWERoYjB4S2VERWdSNzhNZzZ6ME54VmtLRFVS?=
 =?utf-8?B?OFVoeW95MnhjamhaaGlrT1ZwUDA5MkQxYllaeUNaVlZUa2ZIdzNBMHBFZWI3?=
 =?utf-8?B?U1QrdktaWjBMeEZwYmh6SDVxWHRhSFBRNWFPbUNxRG9GUUM3OStkQnFJMStK?=
 =?utf-8?B?azZBY0pXTVpCT2RhU0daUGJTVnBtZmptMkR0ZFMrc0FiMVEvMGhid0NSYmU1?=
 =?utf-8?B?Ri9EbDQydEFrUzNNZ216b2VwUi8rTGFOTWhpN1VkMGtKRUNHSlJtRVNiTlBM?=
 =?utf-8?B?eUlQM3VFcll4bVBnQkhJYVVBWEJmNDJXcVpiRlJkaHZPUTloUUduYTJidkNJ?=
 =?utf-8?B?amNuajJWNU9DTGV6UmhlNkdlZGJ4V1NXajhBS1ZUbmRDUUVOTTJvbFZUYThl?=
 =?utf-8?B?Y0N6YWd6VWFSQmtnZmM4SFNGYm5IWk9Eb08wSndIdlV4d2NQY0FsLzM1ZWMz?=
 =?utf-8?B?eWFhNmJPemQzK0JBdzVYTExoTmozTTFUWHg5aDBUZWpkenRLdm93Lzh2NGk4?=
 =?utf-8?B?YXl1ZmVTRDNQcHV3MXQrSFR6Uzc0azZQRWt2OTk4S3RqamwwczVEUGNNV2Uy?=
 =?utf-8?B?SGR4YzJtMFBXMUZnSWVSaFdJVTRkaGQzVXdIUGR2b1FXZ3FiOGQxRmhqbDlO?=
 =?utf-8?B?UHNOU3VBVXRBV3F0dEhEcmZrdUZVSERYSjVsQ2FWYzU4VUtlWjViZVpocC9J?=
 =?utf-8?B?SVlBRStJVS94ZzlGbGpMaGVwYm9pbE1IZmNkSStENDYvcnJwY2JRc1ZYeFYy?=
 =?utf-8?B?ZlZ6cTZpL1JHUUZFeC8yTjBhVXM0UmVnampzUGFBbFZSdkNHMWc2aGpINWhM?=
 =?utf-8?B?SWxLdVhiTElaWENsRGhoNXpZN2s4MHVuU05MczRMbXR3VGhXM0VFdmF0dHk5?=
 =?utf-8?Q?8je0iyK/metIsZUhuI8GBW8FT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ade7e1cd-6fd0-4b68-e66e-08dbcf5e22ec
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 22:12:22.5323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EiQ3G/Dv7t41hX7MnkJVaPjFG41M9DWG3UJAmoJ+3MPVDorT6lWoruZq6/oSh6GLopxhzw+nxZy7rS3k4GLdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5672
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023-10-17 14:41, Alexander Duyck wrote:
> On Tue, Oct 17, 2023 at 1:17 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Tue, 17 Oct 2023 11:37:52 -0700 Alexander Duyck wrote:
>>>> Algo is also a bit confusing, it's more like key pre-processing?
>>>> There's nothing toeplitz about xoring input fields. Works as well
>>>> for CRC32.. or XOR.
>>>
>>> I agree that the change to the algorithm doesn't necessarily have
>>> anything to do with toeplitz, however it is still a change to the
>>> algorithm by performing the extra XOR on the inputs prior to
>>> processing. That is why I figured it might make sense to just add a
>>> new hfunc value that would mean toeplitz w/ symmetric XOR.
>>
>> XOR is just one form of achieving symmetric hashing, sorting is another.
> 
> Right, but there are huge algorithmic differences between the two.
> With sorting you don't lose any entropy, whereas with XOR you do. For
> example one side effect of XOR is that for every two hosts on the same
> IP subnet the IP subnets will cancel out. As such with the same key
> 192.168.0.1->192.168.0.2 will hash out essentially the same as
> fc::1->fc::2.

I agree of course that we lose entropy by XORing, but don't we also lose 
entropy, for example, if we hash only the L4 dst_port vs (ip_src, 
ip_dst, l4_src, l4_dst,..etc)? we still say we are using the same alg.


>>>> We can use one of the reserved fields of struct ethtool_rxfh to carry
>>>> this extension. I think I asked for this at some point, but there's
>>>> only so much repeated feedback one can send in a day :(
>>>
>>> Why add an extra reserved field when this is just a variant on a hash
>>> function? I view it as not being dissimilar to how we handle TSO or
>>> tx-checksumming. It would make sense to me to just set something like
>>> toeplitz-symmetric-xor to on in order to turn this on.
>>
>> It's entirely orthogonal. {sym-XOR, sym-sort} x {toep, crc, xor} -
>> all combinations can work.
>>
>> Forget the "is it algo or not algo" question, just purely from data
>> normalization perspective, in terms of the API, if combinations make
>> sense they should be controllable independently.
>>
>> https://en.wikipedia.org/wiki/First_normal_form
> 
> I am thinking of this from a software engineering perspective. This
> symmetric-xor aka simplified-toeplitz is actually much cheaper to
> implement in software than the original. As such I would want it to be
> considered a separate algorithm as I could make use of something like
> that when having to implement RSS in QEMU for instance. Based on
> earlier comments it doesn't change the inputs, it just changes how I
> have to handle the data and the key. It starts reducing things down to
> something like the Intel implementation of Flow Director in terms of
> how the key gets generated and hashed.

The key is independent of all of this discussion. It is set by the user 
and whatever that key is, the hardware (after properly configuring what 
fields are XOR'd) will generate the symmetric hash from the input data. 
The "alg" does not handle or manipulate the key.


