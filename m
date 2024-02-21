Return-Path: <netdev+bounces-73807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2A85E873
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 20:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924491C20EC3
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F1686141;
	Wed, 21 Feb 2024 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClrmfkV7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8AB8613C
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544643; cv=fail; b=ejpFBSNeUz8+oUVydiA7DLCND8o2e12u/x7+G6ihSvf/4uajNHy55VWKShOylMTcKZEgySaudUkhcU731iSJe3sxoW9pcY3G7McNOGfXPEDtGccprTJo4abldWbt47jXY9FY9m8++31pSti7tnPjIz8JBigEN6PrU7eVsPzu9G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544643; c=relaxed/simple;
	bh=3s6KkXYzwXTyBuIKuVbML7CmVsAMCNPMZJdZYRlyFe8=;
	h=Message-ID:Date:To:CC:From:Subject:Content-Type:MIME-Version; b=Rpe5Ta1BMGXF1PupF/zMzdfr8pQBRK5yNAEApcH2ifxbJ7X06F5ViAwkLBejUqxtnZlpu0nhriLh7yoPzz1yIKZBeHiTKUOkC8o1cjY7EvqQUhXZgKijyOloonQNNwjrDWDOuM0ymdjwgWBpQuu7/Jhx8PfDhZRaPTirvCCv64g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClrmfkV7; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708544641; x=1740080641;
  h=message-id:date:to:cc:from:subject:
   content-transfer-encoding:mime-version;
  bh=3s6KkXYzwXTyBuIKuVbML7CmVsAMCNPMZJdZYRlyFe8=;
  b=ClrmfkV7W9r1Jk9lBRGbOBhPdKJ1y2dkodbjGhrW8Du0ofmtCW3by/Av
   h4vmQfQfRioEMdd/7ohB2cwp+qBnMtN2T5YF1PFSiCU2HH/9qfl8kY1ps
   snnOaPYmatOcB6Vgj1bDJQUrXlBzaWDFrlH/moqbDsxWJ6zCMjxNp1AIt
   lqA6BAY6kLtl56jfzs8VhTk4Mnwi4SKrgdofK0xGZw+dgMDFB6RweZGip
   aHakaXt1C0CHRCWrjMXzEfzXaP6K4gtPZ+T+be5bUvd+B6rUTMtaQK7Q0
   oUACHk+BVUVEANOLRIgFEhJ7iiPzykTdNbgM1leLxyLv94FJAZhOPnQga
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6558313"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="6558313"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 11:44:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5142190"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 11:44:00 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 11:43:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 11:43:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 11:43:59 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 11:43:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K26I6BPhka5pJD9Q6JwSQgVmi38sAaVB6xfAUDrVootl33DFzzIL8B+/yG4BpA1+axECCXOrWTTaB8Bbo+wZP4l+Z+Kxf1XQKxtT8kelA+lbWvLoNGQfd3cfUWkHvGf2cqvMMhvILpt1MI8JWEQwDbMuN7OSfcurGHuivMqvHkS99JaeyEWQafA8gsG8OGsHuUps24eqm+ae2cALzbFmyp80yUcHlmc3JpOpPv1HijtW0F16C1nUiFu1gZKhYxC39CKCQlKThZKg//1hQ1h/CcJ2Pgr27PVki6/9okCdKhzms0I9PvtMWpyZ4/ZnEBKL3mRxwFKsGKMiFldJ7Rsp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NFh8ro24UYe3LU6Ix6B/3RhelVcj+gFJaLV9toFKs4=;
 b=JfEisJSevEZ3jnS8KMSxDYaxqEBRy6VFjO05Nf/mCx4azNRW/UMeydOErTLcDIB+ysTG7MV8CQJU41FTMDOYpriG2m/HI8Wn/5z1gPZ92bGRD/gHNGe0ZlrpSTV9ydtq78ROLpdNER9RcQEQVhZp9bS0uVdmPSMp+2SwbWRpnTsnyNLlgneIA6j0BylE2gt/WX1DxmQhABlu5aX5nxaHtHU1sZnLLci19IzOsPL3Mnp3tkO2GzCUrKmPs+ApDHFq7+HL9rJRa0+Oye5GwVI8btsxgNtpjjaDDR3i5iU6UmWpdsnbJ1zLCdHuQLJYhfZ3l4PQNRA8vwFijtod9aygUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by DS0PR11MB6520.namprd11.prod.outlook.com (2603:10b6:8:d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 19:43:55 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::13c8:bbc8:40bd:128b]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::13c8:bbc8:40bd:128b%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 19:43:55 +0000
Message-ID: <5be479fb-8fc6-4fa1-8a18-25be4c7b06f6@intel.com>
Date: Wed, 21 Feb 2024 12:43:47 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <stephen@networkplumber.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	<corbet@lwn.net>, <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>,
	<jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	<amritha.nambiar@intel.com>, Jan Sokolowski <jan.sokolowski@intel.com>
From: Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [RFC]: raw packet filtering via tc-flower
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::19) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|DS0PR11MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a68ce58-02f0-422a-7ab8-08dc3315701f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmGTuX8cNjv1sn0RsnaMOqyl01wccVi2gryNHI/tZqNzrHxKjOyMEQmPOJsDx/leETFDIvYdfGXuqI2fIacG+tXlRag8+1VqQODVi9ulX3kQo3VKPcxJXXmh3ZYKDJrC5EEKWYbiy6+PUYODDIoXd7Rgiqb+Myop5LBj2VClusRFiWtSi8UgdhHtfEtJHV4hoIRlSsSz5jZ//IcbRfCsyr3+mujxZAzNNjqritj7McA4FvEXkplfIqsfJDZlyUMtdwgNyOi8Pol09C5TwmzWTOvFpgUpVYNkenJATuoJrD9SJ3KDiKvQQCZJunPCNvCW56THFxWpcIvbFO4814B4mHpjRk18s0VgKGXsiTv/VQ37uISE0I+7eNF0Bu/aprtJCa2gAMDGkUow50J6lZdENabKvHpDohHk2XbjMfiTy2Acz8voiZ+TCUCHq95WqnPnfVfpCLfiYrmG9bo1ztQ5hhR32SFaSeY3c8B+10qUOdHP8eeEgsjUPcliJC6hi3Ecfieh+uO5yS7B/MUq6dLe7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUhNYWRnRHBPM3gwNWV3d2NHeml6OE43RzVXRjVzN0hXWjdMOHdMdG00ZEZQ?=
 =?utf-8?B?cVdjSUlWbFhjTkh3dmF3d0VpUnJrSzhjMmdTaGpvSU94MHQ4S2ZmZ29zOG82?=
 =?utf-8?B?ZCtrVmdQWVNOUlZoS1h0RFVEWnYyVWYxYzFmeTFkY2FTdWdBanNvWmZPWVdi?=
 =?utf-8?B?YXVGY2xyeDlFa0VUREd4RUxTaDUvN1pTVkQvc0xHWkFGTGgrSlVKRU5lMHkz?=
 =?utf-8?B?K3hSNUtHUkpDRFFpdzd3SmtqNUdSTDBWWlJqN09QYy9ENnZ4K3VLS3p4UlFj?=
 =?utf-8?B?UTBLcmZYcElINWMwWUVRa3pZM28vbnRMTnBDeWo2a0ZSQkgzYmQvaEp0VUg2?=
 =?utf-8?B?SDFubHNpRzdMNW9oZUpHajVkeWNoNzh4N1NQSTQzR0Jhc1NPbHE4L3RtdW9a?=
 =?utf-8?B?aHFBdHF5M1VBaWtqV3VRMllBbUhodElkUTh5RUFwMFFvbjF5UEJYZHc4MjBy?=
 =?utf-8?B?aTEzZkZXa281dDlnUzg0clV5YWNKY2psZ0dKL0dZZTNlMzBZVm03ZEJUbCtn?=
 =?utf-8?B?eWtjSkpWNC9td25VdFNoVGg0KzRsaDRMNTBrYTJrWlRoM0kyeVk2QmQxRlFQ?=
 =?utf-8?B?RUdZYWxZZDF6MWIwcmZOOGtWTmtsZTNKcDZRNTBxNnd0SkZOZTViWkRpc2VG?=
 =?utf-8?B?aTh0Y3dIb0QvVkRaUGJUei9BajZ6SFVndFV4OTVSeWxMamNsSmR1b0U0QmNl?=
 =?utf-8?B?VHROQ1lzSUtINVBLNjdvVE1GR082aENLQm9JV3haNUNSL1dWNll1OHpkeEFo?=
 =?utf-8?B?N0lYbHBCVWVUZlRockRyR0NFdDN1TU1HWlYxcVM2UTNtRUNtQ0dOMjU5SEhy?=
 =?utf-8?B?dFV1UzY2MHJYRFc1b1VQOUhhM0RnbkExREZncVpuYUhwbWQ0cTViMThWZ1Rn?=
 =?utf-8?B?V0FudFNoYWpjSUNXMmozMEJITThIZ2VjUnY0RXVHMktCeVBmM2ZCdFZjMGJM?=
 =?utf-8?B?YmtYY2xmMk5aNlYveVdtM2dtUTBWYllCQjR0cWRQTDdyRnFoT0ZEMFI3a2xT?=
 =?utf-8?B?S2JPZmpsc08vN2xWa2VRdUoyejE2NmlGREU3YWg2ZDVzell1dlozQ3A4V3Fa?=
 =?utf-8?B?Sk9XbkFqMWF2U1cyam1WazZxZS9LQk8yYVFLMkpoTnlCOEdUdEpEYWpYU3BC?=
 =?utf-8?B?TTVWeWp5SkJBSXlDelBPNW0va1VKeEZoN1ZHeHNvWFMwNnR3U0EwbkdKalJu?=
 =?utf-8?B?MTI5bDBtM0RUbWlRSml5SHcxU29qYkx3NUNDb3NMdzZ3a2dkYU1oaWZmTGZN?=
 =?utf-8?B?UTNpQzN5R2RDR1BtWHZFZlpSZnZaSksxNWRxem41VnJjbjhaaDF5bVYxVmtz?=
 =?utf-8?B?WHRiSng2cWQ4SFJzRHQ2NXVwQWlQRVl2SzNDL3liRVBRNjNGS2M2Y012eFJj?=
 =?utf-8?B?dUxsd0Y1NVE0RW5DYXBVdlRVSE5xUUU3cVhFOE5oNXJuQXVRbUpFcDdxRkR3?=
 =?utf-8?B?dDZ4MEpOVVBVODlkNU43dVh0MDd4ZzlQMStuTzB0VnQwdjBkNmNMblN1bEtH?=
 =?utf-8?B?YkFYT2JEcW1BbmhYWDFaSnZTOURiQm9hZWhCTUpQNUkzN2IxNUpLcDJVVDRZ?=
 =?utf-8?B?VHlTVUxrWWVidWRNSjdOdE5hS1JkUkZweS84Y3JOYlRLaGVzUnNpUkl2a3Zv?=
 =?utf-8?B?YUFXSzdtMzVtWjNJUzZ5c05CenZWaVpQeTA5T01oZW5GMEx2aFZuSk83YnZ4?=
 =?utf-8?B?UUoxb0djWWdSUVJyL0c2TkpMU216bzhUU252V0NMcHBnTUlDR0t2TXcwNHFw?=
 =?utf-8?B?WndVZE9ua3JqendsYWF1QzhraVhVRCtlQStLSkhmdzhUTzNVYy9pbzhXSmlU?=
 =?utf-8?B?Rmc0aHY1bU5JQlkyREdiYnZNZDZQZU8xbWh1Z2NTWC9JWVVFZFBGTytDcFRG?=
 =?utf-8?B?UFZ6UEZ6a2k5aXZ6eW1rNUMwNWQ0VkRFYVpJNjNzc2lvc0l6N0VpVWUrazd3?=
 =?utf-8?B?Q25oeDJha05TTlF6RWtjcVNNOW01MktJa01OZk9qaWJqRGJmbTNEUnFIMVJZ?=
 =?utf-8?B?N3l2dXlReHZzZ3BTTDUwVzdZaXd3Y2d6cWdMSCs4SXg2UmRUQ3Nub1k2Mmc5?=
 =?utf-8?B?bk93dzBjajBrSFcyaE5sSnlYOHpVQVNnUU10b1pJQTB4OE1qZ2dvRUE5dnJN?=
 =?utf-8?Q?gJofj5I2CUUHL5MCb8MNwfVmB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a68ce58-02f0-422a-7ab8-08dc3315701f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:43:55.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qq7y4k+Lrv+74ZQOS12J2BufIFJwnFcizYQqXgTsz/wDXZCI+hxdQlvsa0pGlbmdwbGiwqYdvsMBTSPdjd8Pug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6520
X-OriginatorOrg: intel.com

Hello,

Following on the discussion in [1] regarding raw packet filtering via 
ethtool and ntuple. To recap, we wanted to enable the user to offload 
filtering and flow direction using binary patterns of extended lengths 
and masks (e.g. 512 bytes). The conclusion was that ethtool and ntuple 
are deemed legacy and are not the best approach.

After some internal discussions, tc-flower seems to be another 
possibility. In [2], the skbedit and queue-mapping is now supported on 
the rx and the user can offload flow direction to a specific rx queue.

Can we extend tc-flower to support raw packet filtering, for example:

# tc filter add dev $IFACE ingress protocol 802_3 flower \
    offset $OFF pattern $BYTES mask $MASK \
    action skbedit queue_mapping $RXQ_ID skip_sw

where offset, pattern and mask are new the flower args, $BYTES and $MASK 
could be up to 512 bytes.

Any feedback is welcome.

Thank you,
Ahmed


1: 
https://lore.kernel.org/netdev/459ef75b-69dc-4baa-b7e4-6393b0b358ce@intel.com/ 


2: 
https://lore.kernel.org/netdev/166633911976.52141.3907831602027668289.stgit@anambiarhost.jf.intel.com/

