Return-Path: <netdev+bounces-45082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B8C7DAD56
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 17:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282B5B20CD4
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 16:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79CD295;
	Sun, 29 Oct 2023 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqxIi2M7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3BCA43;
	Sun, 29 Oct 2023 16:59:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B100AF;
	Sun, 29 Oct 2023 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698598784; x=1730134784;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tr83Zf5u4O0/o6ohsRWevyWDM7iOrZ8wjyUoF0JpGAw=;
  b=AqxIi2M72vbqhSDBYoq9KyEaaZTQKXNUYCc0Ao1xhf++/Cwm30dbk9M0
   sgwE5O9UGLUhT4Q6MM2e/s9GmkAQCVfVWE/xEHk76RF1urEtzL5LNa8VP
   +CGeUyzrALctwimKd4DQwbo7qeUkWCq/mDg+6lm5GEY58uz13SjoBemfW
   83lM+4YVRDrT3tHPlEDZXPcu2RhsPCCaxFVOIzWrpi1fuTs4e9cO6uoNY
   nQmFnk4hyJ1aoXv6pn5Iia3TTzLD0a0nxy3hTQWO6F37w4ZduSJluYU8b
   IYPh4KgZX8ITAxDSsqzx1m3WyNRE8JrFuVF9OxJ0MkXNyZg7ZfKQ/hrBj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="386858628"
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="386858628"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 09:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="1308491"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2023 09:59:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 29 Oct 2023 09:59:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 29 Oct 2023 09:59:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 29 Oct 2023 09:59:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qjd1XQn8724DQ2PruyPpTiGvKHHVEMMhF9ZLaw+N+rZHZsa+xDLA/qRcNMwjdFWuCR5BI1TxIQ/P7jsIZE6wNMbC0RY6sh3y93oF/LE/R2uzTBemyHyiG7MRg3Cam12N0JamltteuhpohawV2tTzwxeR/2xEnIV2GoB7KvYWrd2J0cF+wOIIToghhdAi9UP3k5Clh77Fe+WW//8n0BhffkRsezmpncEQQb5ZsFgByqTJ2kSgxwP8oH5ZsVj95z/g4vfXdb16b83cGiaxx8P4lKwdbEm8LlYn27u2lJxoDrCV0sBhxKh0VqdyvV6bxCTpRC8CJAotFpTvcHbIhH6aug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZjQgFlIHcxcEMxE3d0K/5iiNgdClF/Igr8L8VXe3X8=;
 b=DgocZ8pVYILtE0/ITygaRZPbJJ3UCXJ0PqGPaK1oyNNmxoAX2CE/ku5hGJacXKHoGBgPdbfq4pwXz6u1iVkR6UZ+CkajKi09lTzoB2fe0x9dUQm62mww+HWcfaiWMua/pbw0CHrwe/1WDbbVcdIZLDshLKZjq1CKgobgpBMqJVLPmXrOuMYY0JEFXMVPlCqEhXFDotz+UzNJn4+XCcDer/53Do+KpYcZz2wQtior7ETFHgimNiwOnMIsXY3hj1ShkYHGtjjkZo/X/TvsZpv28CqaqxMBNlSZa72HFPjOM9YgJTOm8RKyrGHS9gj13aNsnMkVuWj4efF6jIqKUJbqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by BL1PR11MB5432.namprd11.prod.outlook.com (2603:10b6:208:319::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Sun, 29 Oct
 2023 16:59:39 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8%7]) with mapi id 15.20.6933.024; Sun, 29 Oct 2023
 16:59:39 +0000
Message-ID: <a2a1164f-1492-43d1-9667-5917d0ececcb@intel.com>
Date: Sun, 29 Oct 2023 10:59:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/6] net: ethtool: allow
 symmetric-xor RSS hash for any flow type
Content-Language: en-US
To: Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	"Alexander H Duyck" <alexander.duyck@gmail.com>
CC: <mkubecek@suse.cz>, <andrew@lunn.ch>, <willemdebruijn.kernel@gmail.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, <corbet@lwn.net>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<jesse.brandeburg@intel.com>, <edumazet@google.com>,
	<anthony.l.nguyen@intel.com>, <horms@kernel.org>, <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<pabeni@redhat.com>, <davem@davemloft.net>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
 <CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
 <14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
 <CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
 <20231016163059.23799429@kernel.org>
 <CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
 <20231017131727.78e96449@kernel.org>
 <CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
 <20231017173448.3f1c35aa@kernel.org>
 <CAKgT0Udz+YdkmtO2Gbhr7CccHtBbTpKich4er3qQXY-b2inUoA@mail.gmail.com>
 <20231018165020.55cc4a79@kernel.org>
 <45c6ab9f-50f6-4e9e-a035-060a4491bded@intel.com>
 <20231020153316.1c152c80@kernel.org>
 <c2c0dbe8-eee5-4e87-a115-7424ba06d21b@intel.com>
 <20231020164917.69d5cd44@kernel.org>
 <f6ab0dc1-b5d5-4fff-9ee2-69d21388d4ca@intel.com>
 <89e63967-46c4-49fe-87bc-331c7c2f6aab@nvidia.com>
 <e644840d-7f3d-4e3c-9e0f-6d958ec865e0@intel.com>
 <e471519b-b253-4121-9eec-f7f05948c258@nvidia.com>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <e471519b-b253-4121-9eec-f7f05948c258@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|BL1PR11MB5432:EE_
X-MS-Office365-Filtering-Correlation-Id: 4deaad86-eade-4448-14ff-08dbd8a07052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yySTuCheCvZHMn83Fsn9B80uwmGMLJa3yvSrPYVBWkaegJwkR3O1xNW/YXz/cI+jWZDIfnNJgoNHc3nJ/OwYeHkJt4x9/Xamw0pjxNQRsKbX4MC9Km0fXe+rWL7yjLEF3Mw9Ug8LpW4NjWdRGALDObN8ys2Pf+N2QS6jiJb7bc1ou1G1z+GEgwhRWLX4mOxQt32sO57p0MHEQhW8jCwdMRc6qYSzt7UT7UzPgUEbQSV9+4Tx58a82C/DnTxqqYrLVNSWnlVdibYJNk55NQF0GlAUD71DzVtvCcSrRK8UDHrS8gVZnR6PC8Kn10KN3T6w+XL5efWwyA3YsWpGTV1JpJ6BZEzSeDI1K7SLpy1/OHyhF1HR4COb93KOHS6+QtdTlYTrFC+nIlG/gie8hW1v/tcA6RFx9GfP98B6eAUTZg6Q/3t7tJ1RIfGeg7fWgjH0c3IqoCl58/jgwleXuG/siAZ7VMmtAUK21sT+7dU6eFzFhSTQt66lI4BydY7cdTr31/U8FQRuJQQUTUKSowGmeE2gKavHd9XkfW8H6wRAbn38TryuptaAVRX1JKavTj8AGb5bIDfXTUpjQt13x4FRBc0loEYnSrsQxF5vhE5aNMYwTFcs+A4PJuXddMSlIk6ZpM6D9nraoU0X+/cpXPgO3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6512007)(26005)(2616005)(53546011)(478600001)(6666004)(6506007)(6486002)(7416002)(2906002)(83380400001)(41300700001)(966005)(110136005)(66556008)(66946007)(44832011)(5660300002)(66476007)(8936002)(4326008)(8676002)(316002)(54906003)(38100700002)(82960400001)(31696002)(86362001)(36756003)(4001150100001)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3h5WmZ4OFZzeHRONmlTZnJmNGV6L2I0QTdNc2JVWTBvUmtHQ0tHc0dVVlVk?=
 =?utf-8?B?Zm8vOG9aNy96Sy9EWHU2c0sxM0FGZUJWQi83VzBCaEZKU09lWU8xRTE4SUVH?=
 =?utf-8?B?MnhXWUlYNXA4OG1RWWI5U0pWQkdmcU82SmZsTkpIMWRiWitsY2ZtYjNremNL?=
 =?utf-8?B?T1YzWnhtWTllZTgycWVDN052SThRcnFhaHVoV1RZSE1qTTY0dTdQZHV0QTlo?=
 =?utf-8?B?a25zNDc0V0o1Y29LaHAvV3VOVXFPN3QxR3VOYXdVb1VlQmF4TmVtNURzSHI2?=
 =?utf-8?B?RWRGQTdNWmVMbUR3UEI4MVk0S01hNG1MS2tqcElvVVJmQTR2VlpjRlRiQld3?=
 =?utf-8?B?ZnhNSm1GVWlEbmg2d0tXeFI5ejNsYkdXVWdrKzE0UVlZaDJrbVNLQ3V3R1Ji?=
 =?utf-8?B?dFNPMDdybG9DUGpoQk9tM2U1OGNZLzBlb1h0Ym1VTXJBTDdWL1Jkenk5N1J1?=
 =?utf-8?B?OWJoNTRyN2Y2VjNuWUFGTWwxNDlmcUxDTmVxMTRXYURPUStCZjBGdHlyLzZH?=
 =?utf-8?B?eXpaVWlMVzlJTU84S2MrZFMyaVFNSHdpV1IrNFFOYmFHQUI1TlJTM2YzK0FF?=
 =?utf-8?B?cXBLY2E3MVVNbTVPUEg4VGFLRFBLOFFGUXk2dWtIMEx1T2hFSUxuMHJpVXNN?=
 =?utf-8?B?aE9jNWpOcUFwUDdNOVZjUkJuVkpLbWN2M3o1ODkvSUIwNHB0cTVhdnpnVGc2?=
 =?utf-8?B?L1JjbDIvblE0dE5TaGVucXdLdGp1VmhCQWNMRFFtbEVJNGhwQU1hMkY2Mnpi?=
 =?utf-8?B?c1lxMzNzL1B6NndIQUZrTE1land1UDhISTR6bWxQZC80eGZDSnFLZDNEbEgv?=
 =?utf-8?B?d1E5WkowMWNOU1FOcG43OTM3SGRpRzVaa2FONmE4ZzNmVGsrUTFRWkNvQWIy?=
 =?utf-8?B?MlpRVGp0akc3dzVENjhwZXR5SGdJNUpnWURvREkrYU1pRGZWSHptWkd4M2Rl?=
 =?utf-8?B?VjRVTmtmSmlEWUt2bE5Xd205NkozVndGZE9ZSEJXS0h2RjR3dGE4cVVtYXF5?=
 =?utf-8?B?b2pvT05MMFdBTjFCTzg3OW9QcUpPMEl3VWsxSnRrSC9xQ1h6MVJOdmpST3V5?=
 =?utf-8?B?VkpTYXhCb3Vlek4rVjVEUjFnQkNCd3ZyZXNhSE9VTEhwMlphYzI3QnpRcmhM?=
 =?utf-8?B?MGo0L0ZYUVhHQml5OUlVaFRETkZvWDhaaE5Cd2dlc3A3VnJkMllqc2QwbE5z?=
 =?utf-8?B?RFF5Qm83MklqUzhDamE4YUtkWFNZVXRqaUJxQlJrakIybVdNOWd1dWhrTDRy?=
 =?utf-8?B?dnRYOG14SjhWYkF3R2k4SkZENzZoZ3JpMkJHdUJ0UVJvbG5BRGZHOFJEUW5Q?=
 =?utf-8?B?c3BZQkwvWVV6aSt4ZFRhbzJwY04xWDQwbkFGaUpJWldQdlRsYllRZzJjamNr?=
 =?utf-8?B?eUtYaW82bTFpdUkwSCs4WXFPeHRWeEtnNkhSbElYUEZOMm8rbHFwckFiY0Vj?=
 =?utf-8?B?TlJVaS9WZ3l3aDhsZlpkRDR4TGsxNDMrWXR6enZOdU5GTExyaEhKWU8yekJy?=
 =?utf-8?B?RGk2KzJuWG0vKytVUUxIcmZLVGFYbjRXMzZkTnhUOGpHTEI2S3g0Z2pTajVV?=
 =?utf-8?B?Ni9tdkxETnBYSGUxa0N1VUJ3eTVGb2lVVi9iaSt4VW42SVlWam03N1NCSFd6?=
 =?utf-8?B?WUxIQ2xud1ZwWnpKUDVtS3J6QzZReGxscElhTnY1blNKalNnaTc4K2Zsd0x3?=
 =?utf-8?B?QkxtVFN4Y2NxaFU1U28wU2JQQ3c1aEVGZjV5SG53QmpwdVVGOC9iNGFCSTNU?=
 =?utf-8?B?RWJZWkVCUFIvNWUvYWQyUjhOdkh1bTlja2lBWDlkNmVxaDYvcTFxY2tBSXVM?=
 =?utf-8?B?RTJxcW1FYlBsV1Z5T3htYjJsN1ZDOThsQUErQURYRmduRWJXRGxOUGczamY4?=
 =?utf-8?B?aWNndXg1UXZPNVo5TWlMR3lZaWEvUVBtN0lxY0dwbklGRnF0Z0FBTm5BSGRm?=
 =?utf-8?B?OWgrNUJUanVwVTRhTVZSV3FjcDkza3lFMWxreUxaTWdxNVNhZUV0bDlTdGlt?=
 =?utf-8?B?T0d3UVpMNGhYa3lkU2VxOUMwRENQOWlIa09hakk0YkJ3NkRmZElGK2QzaUt0?=
 =?utf-8?B?WFQraldNUHJnSWpkQ3Rkb29LeTVrVlYwRVgxamIxODJyODZpWnhFSmVVaWlR?=
 =?utf-8?Q?p51YpOMnyj7N3RQReYfWiA9nT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deaad86-eade-4448-14ff-08dbd8a07052
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2023 16:59:39.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEmz6fMdCbiZ4A/mLAnZMkCAeaeg82qsmqirKgJOUP+cMSLRrUC41TgHnhyROXloHXkWjJB2w0TRak7ka+Kzag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5432
X-OriginatorOrg: intel.com



On 2023-10-29 06:48, Gal Pressman wrote:
> On 29/10/2023 14:42, Ahmed Zaki wrote:
>>
>>
>> On 2023-10-29 06:25, Gal Pressman wrote:
>>> On 21/10/2023 3:00, Ahmed Zaki wrote:
>>>>
>>>>
>>>> On 2023-10-20 17:49, Jakub Kicinski wrote:
>>>>> On Fri, 20 Oct 2023 17:14:11 -0600 Ahmed Zaki wrote:
>>>>>> I replied to that here:
>>>>>>
>>>>>> https://lore.kernel.org/all/afb4a06f-cfba-47ba-adb3-09bea7cb5f00@intel.com/
>>>>>>
>>>>>> I am kind of confused now so please bear with me. ethtool either sends
>>>>>> "ethtool_rxfh" or "ethtool_rxnfc". AFAIK "ethtool_rxfh" is the
>>>>>> interface
>>>>>> for "ethtool -X" which is used to set the RSS algorithm. But we
>>>>>> kind of
>>>>>> agreed to go with "ethtool -U|-N" for symmetric-xor, and that uses
>>>>>> "ethtool_rxnfc" (as implemented in this series).
>>>>>
>>>>> I have no strong preference. Sounds like Alex prefers to keep it closer
>>>>> to algo, which is "ethtool_rxfh".
>>>>>
>>>>>> Do you mean use "ethtool_rxfh" instead of "ethtool_rxnfc"? how would
>>>>>> that work on the ethtool user interface?
>>>>>
>>>>> I don't know what you're asking of us. If you find the code to
>>>>> confusing
>>>>> maybe someone at Intel can help you :|
>>>>
>>>> The code is straightforward. I am confused by the requirements: don't
>>>> add a new algorithm but use "ethtool_rxfh".
>>>>
>>>> I'll see if I can get more help, may be I am missing something.
>>>>
>>>
>>> What was the decision here?
>>> Is this going to be exposed through ethtool -N or -X?
>>
>> I am working on a new version that uses "ethtool_rxfh" to set the
>> symmetric-xor. The user will set per-device via:
>>
>> ethtool -X eth0 hfunc toeplitz symmetric-xor
>>
>> then specify the per-flow type RSS fields as usual:
>>
>> ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
>>
>> The downside is that all flow-types will have to be either symmetric or
>> asymmetric.
> 
> Why are we making the interface less flexible than it can be with -N?

Alexander Duyck prefers to implement the "symmetric-xor" interface as an 
algorithm or extension (please refer to previous messages), but ethtool 
does not provide flowtype/RSS fields setting via "-X". The above was the 
best solution that we (at Intel) could think of.


Another solution would be to add a similar flowtype interface to "-X":

ethtool -X eth0 hfunc toeplitz [symmetric-xor rx-flow-hash <flow_type>]

which will allow the user to set "symmetric-xor" per flow-type. IMHO 
such approach is confusing; consider if the user sets:

ethtool -X eth0 ALG-1 symmetric-xor rx-flow-hash tcp4

and then:

ethtool -X eth0 ALG-2

should we switch tcp4 to ALG-2? Also, just the idea of replicating 
"rx-flow-hash" did not sound good overall to me.


Anyway, we thought that, if we are using "-X", then limiting all 
flow-types to whatever is set with "-X" is cleaner and works best with 
the current ethtool design. Any other suggestions are welcome of course.



