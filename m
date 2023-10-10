Return-Path: <netdev+bounces-39687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470E47C40E5
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CA41C20B86
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CC329D05;
	Tue, 10 Oct 2023 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbV3idjg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C032196
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:10:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FF593;
	Tue, 10 Oct 2023 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696968618; x=1728504618;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3wpJ/tJQtoJtF/Vo6hM3OodLWE+A1V7clnaxV8dD0XQ=;
  b=QbV3idjgN+8czxZ9W/K/sxfc/tAWkWd2KGJB+N0buPAHnAkZX4DDix7Y
   KzRnqAXtOkIfHHVBmhRZDm+/7rurEIa7zL1HTBoRGBVC6BgvXgQjrk/1+
   UVFQtWh0AJF+5zuL7v+jFacp3iwggMV7BjxdLzgZUAPGKEJ+Fnd6vr/qg
   NGe328EpYa45Vgs1vfqu8VbQmHaVdT5uHlYdfrKMg4fZon783w0TF0iJz
   1G318hl1/l4ZV71b8jTMAm3xzXAER61CveHKfmMhKqDtDAa4ZrUueAYjF
   /FSPxhwqSOmhaEFpx7e/ZjhQPEShx1BD0n9N7F59UuHeSEEQdcylauFKA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388367706"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="388367706"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 13:10:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="927283409"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="927283409"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 13:10:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 13:10:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 13:10:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 13:10:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 13:10:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCZjBgn7WTRT5KJ5AEyCxSK91LOTIAKl7nbp3zpdHpKTvw3vh7ZNyQc/gm/0Yi7U3hIQppQdJYwT7/P01vqn6lnG7+eLPuCqvH8mRP7oD2srIKufUsB6kv7+kESMAcA3AhVzg/0e4WgDjtQCJ5+Xs3ZSuJatbG6+H20ebBbwhkYLp4rOe69nYIG3JflT91ue2sWpSpR9lve2K4wksEa3Hcg5OenM3U9Zuhdwrh11hdyKvT7YX+QmqQNdyERWcigdKS8kMtqaNQrrCYy6Yt/5ZZOZ1yIBTr/vzMu/eqPaARIhEZ/iQHGhyTv7xcVOr/5nU9LpiQV4P4+EUopa75hOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAFnqPzrp+ul6ZogO3PvqKOH0pDiFH+xFCc/ZRz4kys=;
 b=HRWj1m6IcTo/Z7rJ0eizSLBJwVZZaDJRDOq+elkhCT/QJBBK1pFH2pVHsGt/Q4otoLuBeZ8Wh8ntzaCTrdTVhRjvqgC4J92MQhAisT/FPANSeCBg4fv9ccrw4To2l0tHTPR1Fl9NXzryDth0ZQej0A8HxTncxO2eH2lOsYFY9YGQZTs3pJfzLYeN4JtemrCFc0V3mHomIPCO3NyoicnB7uJKr9t5/EF0/wFUtW0v3JH+YCcuFQ2QG+imUydeTyfYHwlGgoE7jNYvVjronW2R2uEuU5zf+pOSx9Hf4yGvUk2S/7vIsFXUbszMEE09HBwg0OrxQatla0BpldJC6rMkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by BL3PR11MB6314.namprd11.prod.outlook.com (2603:10b6:208:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 20:10:14 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 20:10:14 +0000
Message-ID: <fa769f39-d109-47b2-bf72-218f0ae846f4@intel.com>
Date: Tue, 10 Oct 2023 14:10:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/6] net: ethtool: allow symmetric RSS hash
 for any flow type
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-doc@vger.kernel.org>, <corbet@lwn.net>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <vladimir.oltean@nxp.com>, <andrew@lunn.ch>,
	<horms@kernel.org>, <mkubecek@suse.cz>, Wojciech Drewek
	<wojciech.drewek@intel.com>
References: <20231006224726.443836-1-ahmed.zaki@intel.com>
 <20231006224726.443836-2-ahmed.zaki@intel.com>
 <20231006172248.15c2e415@kernel.org>
 <CAF=yD-Kp8-iQtDM3+mgfJ6Ba0vkAeb09VZBa_k6RUequEyjd0w@mail.gmail.com>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <CAF=yD-Kp8-iQtDM3+mgfJ6Ba0vkAeb09VZBa_k6RUequEyjd0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::18) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|BL3PR11MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e40ab0-e71e-4465-9264-08dbc9ccea4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlDan4A1cxwCio1J9j+CGEf14tIfqHBn2eCySDa3u10uwmrDTv8bqxEqwtFSbm2nkl5JOqCT1l4DhypEVfTLciR+wxVSlWUSlvTNDvr0KW7t1HQu99mhi29lZQwsO6HcJ65otHrzfHT23BM5QU1kXQjfOSOZUlFRaTx8Njr7KfFL0eLnj6cUuA/a2OaO4v8gW+z/bzfm5+56A3hPseeY7W128cLzw1RGCnH1Z5CYpZeBnTDQ2oKf66YkLdePHTa2jIybXqi+JExww4x9lu8c04KmCz8lSyH/xCoMNBM26VIuAPrzve2nGOST7+Ic6VDzRHRCUnekc+usPaJOWBBElFoCHnUxpa5VNrsLuYaohHT2EyBkNyXaDHPPLh2Ke5N2Hmit3uEkjS79B6LhQlGKUmeVfrCkaRVEvOEVszXA3tRrZf/bbNrALJORjbgXSe6/FK/nR8duQNwNSoxZSWFzVS87Kdnb2swVEwQDpSJbIgboyJMHvq1y2nH/apJUsrsPeQdwwMeRtFnKoruwRbAakKh9OJWOoj2WK5P+z0gZy220pUVHL3WYpFMGNKa1tfPc0PLLpXQCdn/VL5B8ZCT5tp+/03kovBcqIKkbs05umfsVrU361xNQJzJ+8d3B+1tR5iX4lTF/EwKUdCqlDkFRWX684QfgglST35/PevLYC9vT8GVVa1Ir1qM7GDojiNsB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(36756003)(86362001)(31696002)(7416002)(53546011)(2906002)(44832011)(478600001)(41300700001)(5660300002)(66476007)(66946007)(110136005)(2616005)(107886003)(66556008)(316002)(6512007)(6506007)(6486002)(6666004)(26005)(8936002)(4326008)(8676002)(38100700002)(83380400001)(82960400001)(369524004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1dpaFArUUZ5emFLZytzcVRXVWZ3Y0hHZmcvSmdRMlNIS0tjRGwxNGZZYktX?=
 =?utf-8?B?VTVlSW1od040bzIzUHBaejRib3d4M0NzRW43UHQ4OFM1L0o5OUZjWUcrQ3R5?=
 =?utf-8?B?d0JSWGNDcGpaUHBVWDB1c0pwdTh2WVExbGQ0bThFZVBaclZlb3FJUTU2R3hL?=
 =?utf-8?B?QzJTZWpTVlR5cnFRT1R4eDcxb0dGeTEraEpEeWRCN01jUi9YQTFHQmFMYXQ2?=
 =?utf-8?B?eXBIVzVYUEhZTzlDTlB1eEVZb2VmOTRYODRsM0RzdEJPWllYSnRVNytyUnNU?=
 =?utf-8?B?SjBOYUlUem11RXJWNCswY3NiWWRxcDB5MXZET3M0K3FZdmxSZUNyMmtvSGJQ?=
 =?utf-8?B?aGtnQ2hNVnBoNFMwQzVrVTFKTjV6UFBDUFVRWGJORzdvVHhNSTZ5V3prQjly?=
 =?utf-8?B?SkVCMXVydklHS0I3blVOY3p2bk5MUGVpS1cyQWhjSVNYY3lFSHc3YlBsR0xB?=
 =?utf-8?B?ZWlGckdUOWs1Z09SZGlFZFV0Y2ppRGdJTFExa3QraFdHL0lVcElNNGdMY1Mv?=
 =?utf-8?B?bVhTUkE2WG9QdTRta3htMytZUTJGVnNPcFA3a3RhZmU0bjBUNG5OaHd0KzNy?=
 =?utf-8?B?c1V6c1F6a0JySWZnVHZnTUY5NlpRbmZSOUlVUlozY3NKdk5uLzNadE5ZUjN6?=
 =?utf-8?B?dlUxd01pYXViM0JEVFNkVDNVdjI4N296eWhqVXZDNU9UL2hEZjBVN0pGRGE0?=
 =?utf-8?B?aG0xS0VpOGFRZmpUT2F3SHh0N3VLS21CaWYwZTZ1MmZPbFpoT3JodFdZSW8w?=
 =?utf-8?B?WllxazR1WXRVSlU5dngyb1RlbW9FUDBiSzZtbUhNVjF5bGczM2F4djBNKzhX?=
 =?utf-8?B?dE4vRFphZXh1bmlTYlY2Z3RMRzlQUDhOcFhMZjZXTElvOFgyR2xISlJqZnZL?=
 =?utf-8?B?WEdLZTZnbU9jT0daVHZuQUVoNEhIVHdwMzR4dGNrVk9UYnZWL1IwdDhWNGwx?=
 =?utf-8?B?Qm9LakFRT2lEK1VJMWw4YmNOeEFVZThVS09WcURMeDFuVlZGZkp1dzNQZE92?=
 =?utf-8?B?UzMrK3NDUXVxNzRtSmlLZ09ZdjlZWHlIOXBELy9wOCtZTFZjMC9TMzNHQTFS?=
 =?utf-8?B?czBGZVFMcmFIRzdkTG04QSsxMUE2Vkdta1EyV1VpdmlFSlVqKytTNU9NajVs?=
 =?utf-8?B?MHA1NVkvUXNaVlF3dG5FellvUWpEUWJzS25Va1NmUG1ZV2NTQXhEY2dSVndo?=
 =?utf-8?B?ZGJObDRKRUVXOHFzMmZWM0hWR1l6dGZSWTFRZjRxUmFUR1hyQTVyWFcrazdm?=
 =?utf-8?B?SWYxTnZSa0MxYmlYV1I2Z2pTdzUycGh3dW9yUGkxRWVoczBBZmpSdzdZMVEy?=
 =?utf-8?B?OHoxMkRrZndJMUJTcXdrYXhLM3kvaCtZZXI0SUF1ZWIwTldhV2t0VTR2TExy?=
 =?utf-8?B?dG1yYThoY3ZpczYzWkF6YUg5RXBlT0sxWU1qUUEzOHpYMFNTbTRuaFlxSkRa?=
 =?utf-8?B?eEluY1V3N2thampGOUZiTkFuWFVIQzVSMmhzSmFuRm1DQWt1amVQQ2ZtZzdT?=
 =?utf-8?B?NnF6MzA4MVQwUFNWU3loM3VHZjZaMCtVRWQ1eFlxRU54RXRBTWJkT0hISUc4?=
 =?utf-8?B?SnArTVF4TzBVRk9vV1Z5V3AxVTRHUVpIOWRlamZobjdrd0FIUGpSVjZTSUVj?=
 =?utf-8?B?WVlLbmhlaU4wb3VXeG5pNWxlQUxLMFlnc0Y3cXZkeU5UVHBHVGQyeVg4ZkJh?=
 =?utf-8?B?VDFUL3MybkVvOVREYmUvczNUa1pHbHN3MFVvQjNsMG5EY3BGdjg0a1RBdHhO?=
 =?utf-8?B?VkNvSmlWbE51ZE1PR3AxcDdUZEFFQWdSRWlyMFFNRHNtY3pqd1VWQmFVOHNv?=
 =?utf-8?B?aXFsamJhaFVZK3pkZ3JUa294SDdpV2VIQW01clNUK3NaNWVLRDM2dVNKc2tB?=
 =?utf-8?B?bEw5NElxS3B4MnNpRmpxd1AvaFFNdFEreGkwSjVqU285L242VWpWalMrWThW?=
 =?utf-8?B?ZlN5dU1jb3hiZWhnbHZwMVJUajVPbllSamtsVCtoYXgyeXpNbGJkUFpQeXlk?=
 =?utf-8?B?MG0wUU8yZ1JnWnV6SVhSdkRDY2pvanFOQUZ4bUo4RkZBS3VNSlNsc0tmSzU4?=
 =?utf-8?B?Z2FmS0llNHVkTDJnaE5uMGVPbEtZUU9vQ3ZFSzhkSEFjRndUSDJNaXJrcjNP?=
 =?utf-8?B?bmRObEpkVmdTZjhVL1hGN0c5MTJqWjBpOG1Rbk9QYnMrVG0rSHJrYWVWT2lR?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e40ab0-e71e-4465-9264-08dbc9ccea4f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 20:10:14.7047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNNwDWBFaip1I1BfOpduAZ9BBqz8BQHfONBanulLX7G076sXwsJfVVkCOR5Nid1y4QoAMgNDi08D6Tsaa38gXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6314
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023-10-07 03:01, Willem de Bruijn wrote:
> On Fri, Oct 6, 2023 at 7:22 PM Jakub Kicinski <kuba@kernel.org> wrote:
>> On Fri,  6 Oct 2023 16:47:21 -0600 Ahmed Zaki wrote:
>>> Symmetric RSS hash functions are beneficial in applications that monitor
>>> both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
>>> Getting all traffic of the same flow on the same RX queue results in
>>> higher CPU cache efficiency.
>>>
>>> Only fields that has counterparts in the other direction can be
>>> accepted; IP src/dst and L4 src/dst ports.
>>>
>>> The user may request RSS hash symmetry for a specific flow type, via:
>>>
>>>      # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric
>>>
>>> or turn symmetry off (asymmetric) by:
>>>
>>>      # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
>> Thanks for the changes, code looks good!
>>
>> The question left unanswered is whether we should care about the exact
>> implementation of the symmetry (xor, xor duplicate, sort fields).
>> Toeplitz-based RSS is very precisely specified, so we may want to carry
>> that precision into the symmetric behavior. I have a weak preference
>> to do so... but no willingness to argue with you, so let me put Willem
>> on the spot and have him make a decision :)
> I do have a stronger willingness to argue, thanks ;-)
>
> Can we give a more precise name, such as symmetric-xor? In case
> another device would implement another mode, such as the symmetric
> toeplitz of __flow_hash_consistentify, it would be good to be able to
> discern the modes.

I agree that implementation matters. I changed "symmetric" to 
"symmetric-xor" in v3.

Thanks for the review.



