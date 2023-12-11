Return-Path: <netdev+bounces-56146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9FF80DF90
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526E628251D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ED055C00;
	Mon, 11 Dec 2023 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kU5223SS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB593CB
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 15:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702337792; x=1733873792;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dq+hWOeKwSIJVLwI1CWb+jrYUn7c9OTsaxB3AfZ7BdE=;
  b=kU5223SSbOxTTZB8XpInE52mJm1k0wnNw0DHpK35+XXURSu/2MQFlxmp
   5ATpflv/feC/CIvQ4UYVGcfk0v42rMXjk1Xh9bVdUP1s7jQeR7sqWTTRv
   Dk6CjG+tt9iIrGrD/Zlx1AA8c5WaXOttC+Cozv/ysDPMAyAV0ZEh5kUtW
   GaOAHnf25vYopvuVwPWQB04YcI9g/GX3ntBVQysRO75HxrP7JqcJodrXu
   DPkqvHS6+/Jj4oPE2sO+I9YBLCVZ6Hyr7Zqbr7KlxN7fdxTQrW4clR1aT
   UwdMkmtbVlmPLy4dBBcslU9pH0EYYOppoh0mz2AzdKdvs/MHmUcy8jYxi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1801537"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1801537"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 15:34:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="843682229"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="843682229"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 15:34:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 15:34:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 15:34:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 15:34:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 15:34:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I54/2wGn6Es0V1TurMME3oExZ26jwDa8aoMu88oTifcmA4/r8dmNJ3whfFg2t0PCnPgsYYfScgUPio/x1fAor3Mir/yD0adQ1qZlUDfayaFFuTWAfW0DtbKC/1N2wGw7APQxWtIpD6yi7fpHY96OC5+xtEsktKzsAExnbvj/rgyZ3ZQIf/2BGI9w5n7G680jH2l8odzGvhKym/cdDoItQEKO8X+ITvihXoMOLfBTLySvKR4XWMkRkomBFh/6qdctlAntqxLCeABlcrC0vtYvWRq/aDGXIgj66wtbOARVkdoZs6NnevF+lh1f+OORzN9xo3bNegKwLO40iNqqNonWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i8aTZM/xgNTDdngnadigkhPV6SU+AxXmFLFx+dX4SM=;
 b=IUGrmU5PO/6X70rukE7c743gJ2dohSeEnfv5pzUxsDcei16AlJ+IkcXU+Hfns0Y5WleyO4fJwqYMXXUbqAs4rWrSV30O2PmozfysdOGh2yxMNjPVDN/Q9O7iw8Yd2w1AAV+ITBhVxOGXKVCfbGq5Z6WlusWIJBdrsy89UeR8060nQLeFVs1a4nrT+cuoqZh7SQcSx/xZ63VndlWuNNr84nNy0pj0dEUfWThLLfJJyVHhYtrkt4BmCRfnkjM2Ngh8wmnTQmr+8k/SvmbCy25AkMAwXLsjDv+Ozmzm9NprOtoWJjobdE2X4CjtVFwp+mR+ivhAwnwbmuwa8hLQ72JiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by SJ2PR11MB8565.namprd11.prod.outlook.com (2603:10b6:a03:56b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 23:34:47 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b73b:45a5:d8d8:65d8]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b73b:45a5:d8d8:65d8%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 23:34:47 +0000
Message-ID: <bc2cad6a-a456-4aa2-aeaa-157b3cd48b57@intel.com>
Date: Mon, 11 Dec 2023 16:34:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] ethtool: raw packet filtering
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <mkubecek@suse.cz>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
References: <459ef75b-69dc-4baa-b7e4-6393b0b358ce@intel.com>
 <20231206081605.0fad0f58@kernel.org>
 <bef1ce9b-25f0-4466-9669-5ea0397f2582@intel.com>
 <20231206182524.0dc8b680@kernel.org>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20231206182524.0dc8b680@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0338.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::8) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|SJ2PR11MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc4936b-c790-4def-e173-08dbfaa1c345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eahnoGaX4BtdRyl0QWJWg2aVQp2s4bRnTm35V3q6CRA6w2fdizYkvrMQYuZHC3JLh79XcIO0pFIl3Pw7n+HtE994I9TqoIaahtUFI0r3kxMJdfTZv3GkRe8SX+9lwn4J/Yz2jDjmNwee8kdZt+4x3NZrRTBkgDc8tmhjhTruS8g0tMTg5WkOyomEzUV5+b0Tkb74Td+WQI03UxapAhqFh8LBtW0fpLSCD4WNVoSWjj+DDffDi3SyMSm6bstCeVYVS1Nc0CDv6wQh5h/ol2fZiq5gJseU72vAa1fpXwsjV6yGS+25Hl00jH25Im1k2GXKKFsvoJHAUcsKAJLTQ1McLF973uEtcL3qFh2u+1xKl+gzJX0K4sh2O4En6XeNqSgu4LuFmuxnL7eSsvUgUQ1E4hVx923JD9x6J0Pj8srKhF+FQD24EQGJjzqRnvUS/sZ2GIuEJsnJEgcaaTla89iOQdAK4SYludfWRE/tSI3YT/bICY24J07S1hJTvx4t7s8Byfstkr+GL24xHfei6L/qIViHsy9PYv49JjMTeXzePUp6tg4zcH3qAJJBgeFQSu7IS9j/GLFoe69DLXU8ISo2KlWErxagIygKwW2lM9UQt4uuuIAWGsxOPccLJj5XR8aHS5gITxFsGSZT+oWxYlYjBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(26005)(107886003)(2616005)(82960400001)(36756003)(38100700002)(86362001)(6916009)(31696002)(83380400001)(44832011)(5660300002)(53546011)(6506007)(6666004)(6512007)(316002)(66556008)(41300700001)(66946007)(8936002)(8676002)(54906003)(6486002)(66476007)(2906002)(4326008)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M28rQVFONXRSdVhlczlZUm1xWklGNE0yUWZWaVhHek5YclFrR0dzWW16VjNt?=
 =?utf-8?B?SWNCS0JoUm5XVlNHazU4YWp2SVpqNXVlRjFjLzE4amZPTzZ1VkdoT1NHRGZM?=
 =?utf-8?B?YW1jZGRPbklCVnJzN2crdW1LbDdBKy9NRVJWTHdGZmpmNTFtTDFTY0xETVM4?=
 =?utf-8?B?RjliTUpsTUdDRzlhbDllVjNtZEN3R3RaMkhYNUt6RFA2SVJDenM5MWpIMXhp?=
 =?utf-8?B?T25oTllFTGF1a0cvdDNwMmt4RStGY3ljcVIrR0czckJEL0dkWWl0Ukg1SGxL?=
 =?utf-8?B?Si9Vdkh4TkNPcWpjWHB6TmFxT1VOK2NSQ0ozR1pKOXF0b2gweEprSlJheEhw?=
 =?utf-8?B?MkRzOEJNUDBCTlBzTWR2a2VVTkI4eVMzRyt6SUxROTR3K0xvMUprY01Dc0Nu?=
 =?utf-8?B?eFVzRG00YnVxMCs2cU14cFZWNjNjVExvSGorYWV2akcySTljQXE5ejZlQUlN?=
 =?utf-8?B?ZWMrODJPVzhOamUyNmtkYWYzS1o1RUhXN05jU01vbS9zbE50aHhPSXFzMElI?=
 =?utf-8?B?Y0xjMTBwNzhIcm93NVZGY2N4UWV0K3BxQ1QxaUJQY3FtVHMrU1YzbHliVlJM?=
 =?utf-8?B?V01Yc1E3OTFCZkZmbWQyWjJ3RjNLTCtjc3pzdTVFWkhvNTg2MlYxNmVWT042?=
 =?utf-8?B?N01EclZ0cXRqcXVNQnpuZk5QdytRMk1nV2g0cDF2d3hkcmNwQlZ4Zk1nNVEy?=
 =?utf-8?B?djRtN1BoVHlxUmk0YVRvSE5wcGcvZEg4TG1veFlvV2ppUjBIQ1pEdEtKLzF6?=
 =?utf-8?B?NEg0YTFDVUkzZklwU1R5aU8wWmhXYW1Bcmh0UWRBMzZpdURCbGJCelNiMFpO?=
 =?utf-8?B?SnpHYTBpS3N1T3U5S2VmazFQTzBIZlg0N0RTMzlYOWtjZU5RWjhYc0VUcjcv?=
 =?utf-8?B?b1V3Nm1aS1U4KysrMXJrc3NkYkJ5QnJhbUExeFVpVEJXUGRQaThPWStUMFhh?=
 =?utf-8?B?NFFDRFdBNENOZmdlZ0FXVUx1YXl3Mk1iTzR3V0RhOXV1WHEvNGI2NXJFaHIw?=
 =?utf-8?B?c0JCNzdnMVIxWVlhdytvbTMrQnJjMVFwS2xha0Q3aGJzaG03SEpPNHRhYURa?=
 =?utf-8?B?anBnN3N3bEt0eEhwVFdRYXY3Q2lvZ08xOUVDRnkrcUp6VlVuODJ2bTIyNE43?=
 =?utf-8?B?WHN3UHBQQUJjejNFajR3MkpMcWJTQ1VPdHpkb1c1RW9ZTnI5Z2J3aU8xSkdm?=
 =?utf-8?B?UEpyN1NqNmdiTGYvYTJtZEZ4TnBQcHRPTk5sbW1va3RMVEt3OXQ4cWhqRGlm?=
 =?utf-8?B?SXNDM2JlQUI5a1BEV3l3eG5tbkh4UUVZanYweS9JTWJzcTlVTXU0NXdnWmc3?=
 =?utf-8?B?anp0S296eVgvWXF6Q1EzZ0xjblV6WDhtWU1NYUxPcGNZWVZMRVZWVDlsRER3?=
 =?utf-8?B?U1FaZHcwQlBSdGVrb3g2b3NqTXZ0TUk4R0M5cWtsTDJERWFMdFBYemFDMGEy?=
 =?utf-8?B?ekVoSEg0b3NKZXJlVEFOZk8vMmg4RzRpQUl0SStTTENpNTBRcmZyZDNDUXNI?=
 =?utf-8?B?OWMzSURDL1h5RDdVR1Jud1ZoOU1OVnM0S1hUL29tNGtuWW1Wc1V5N3VzV1Uw?=
 =?utf-8?B?VmkrSGJCcGtjbEp0TlM1M0ZYTlJiMzI1UUEzWXhVaG04WEw2WWgzMDQvbDB3?=
 =?utf-8?B?R2lXL1RIOTZXdUhnSTVoUUw3NXJRY3htV0tKSW84UWRLYjNkWElpa1BZaWZN?=
 =?utf-8?B?TGRjNkFOZ3h0ck15Z1pwajJOQVZhTjJyZk1jMHpYeERZeURZbVQzajVkRlVS?=
 =?utf-8?B?cno1blJCQUpVV2VWVnk3UXdwL2I2VkE1Ykg4Q21GbXVlQVptRGl2ZGNHWm80?=
 =?utf-8?B?cXJMYmduVHpmYUMyYWNic0pxNkVhRnJWMTdvcHBhMVR4MUlRMHk1SUZ2UW5U?=
 =?utf-8?B?YTl1TEF4TVVpZXlES083SWZZcWxvTTZGQVFuQjdhZkd5bWpwY3pHZ08vWjZ1?=
 =?utf-8?B?bUpBOVNjRnQ4Ujk2ZkpEMUFkNWwxejhmQzdmTWNDR2VpbGRnNlZPWHAwclY4?=
 =?utf-8?B?ZzQ5QmdMUGtxYTV2T3VHSUxKWmtXQkhWOVUvNWpaamVPWDNBNnA4QVNQM2lz?=
 =?utf-8?B?TFJRSWpWNkRzNnVUL2FjMTFtMWR4RlZuMnhQUXg1dGFYeERoSkdxVDFqSzM0?=
 =?utf-8?Q?vvsRBkniBehmaD3ijSAJ5dPCO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc4936b-c790-4def-e173-08dbfaa1c345
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 23:34:47.8009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgksSwcgEPTl9fDY8UdbjdZlfoA13o/2AGFca0Xeq8wU8PKZi4+9+JEWXZRJ4uix6EqHqedR6tyUXjSrcugB3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8565
X-OriginatorOrg: intel.com



On 2023-12-06 19:25, Jakub Kicinski wrote:
> On Wed, 6 Dec 2023 15:47:18 -0700 Ahmed Zaki wrote:
>> Sure. The main use case is to be able to filter on any standard or
>> proprietary protocol headers, tunneled or not, using the ntuple API.
>> ethtool allows this only for the basic TCP/UDP/SCTP/ah/esp and IPv4/6.
>> Filtering on any other protocol or stack of protocols will require
>> ethtool and core changes. Raw filtering on the first 512 bytes of the
>> packet will allow anyone to do such filtering without these changes.
>>
>> To be clear, I am not advocating for bypassing Kernel parsing, but there
>> are so many combinations of protocols and tunneling methods that it is
>> very hard to add them all in ethtool.
>>
>> As an example, if we want to direct flows carrying GTPU traffic
>> originating from <Inner IP> and tunneled on a given VxLan at a given
>> <Outer IP>:
>>
>> <Outer IP> : <Outer UDP> : <VXLAN VID> : <ETH> : <Inner IP> : <GTPU>
>>
>> to a specific RSS queue.
> 
> Dunno. I think it's a longer conversation. In principle - I personally
> don't mind someone extending raw matching support, others who care about
> protocol ossification and sensible parsing API might. But if you want
> 512B you would have to redo the uAPI, and adding stuff to ethtool ioctl
> has very high bar as this is a legacy interface. Moving ntuple filters
> to netlink OTOH is a different can of warms - it duplicates parts of TC
> and nft while having a _lot_ less capabilities. And performance
> (everything under rtnl). Which begs the question whether we should
> leave n-tuple filters behind completely and focus on tc / nft APIs.
> 
> So I'll be completely honest - feels like this is going to be really
> high effort / benefit ratio for the maintainers. It will be challenging
> to get it merged.

I agree on the n-tuple hurdles, but is there a tc/nft API that you have 
in mind? Not sure where are the overlaps/duplication.

I couldn't find anything that can be extended to offload RX packet 
filtering/matching. Or did you mean __create__ new APIs?

