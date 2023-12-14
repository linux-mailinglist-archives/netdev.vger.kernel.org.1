Return-Path: <netdev+bounces-57688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BB3813E20
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 00:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE75281ED1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 23:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164FD6C6C5;
	Thu, 14 Dec 2023 23:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xx1gJggv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D3A6C6C0
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702595717; x=1734131717;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OYxHEovW5Dx9J7EgI3trbS0qFAe6ao1B47HS8YCJZF8=;
  b=Xx1gJggvg6lCowm5KOvcstDsbJ5Yg6V9iKc5+YggWoZQavlqUqGr6Z27
   38oM5yl0VyoCFTPJdneGqaD8ILR+rUyu2cChuxHAwzHhC7sDnHIGFoM5Q
   NHoWbH4bZ8gbgH9oNXSUJtywcir5WaOBTkZnEHGZt2cYDHT9Z6eGX7xWx
   BL/Db4L9fDp6Q8iwdXL5+RWftG2tSRRiCby11HeEsXXXrgS7le2wFvRUm
   auSOI8rCVm1JM0HyVqL7WYfzeiOhHKYPkpEpEBGATce+LidglSJln6ltW
   45HGDP5aihpKtHjGAFzLPWAVtGOLqOlknd4F29ztC9iUVU0rXcBPDlyvN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2041035"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="2041035"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:15:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="918223498"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="918223498"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 15:15:14 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 15:15:13 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 15:15:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 15:15:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 15:15:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3InhP60w+1NkwTcqT8MNG4aVMZg5gCLFwU5omgas2eNk2tY1oM6od5xrNVY7p0plqdJptyQxLg01U6iDh1iYnT3ysGdReTL3s0qpwe7Bx9CV72yaa2E7do9RJPOVWS2iTjgLaoqdEEqXUKt2WRYi+xfGBU25X+MX8/0AGwV8iDE5DR6CjX0+LZ3rpPZcBA89jMGrrIp7nVcwYfLp7463tsPXm/MR4l6FkzOO/kmEPPsQXUf2FUBMgxEnhIY1Ums3TsVEe9mjhLZFDlKg9Gmx2fefdclERntU1HrTtuQfgubFFqAQluCFZB3HE1lg6Jqv2OxWZuk6fgqrEBgIUvq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4cg7dY/1DSSPn1XL9JCPPnneHjZ42mnEvAsD/BaIrg=;
 b=iTly+Ifk8H8flbUS/m/LxhFvW8cAmLge/tj0qhnq0xBW9jsR110fQorg1X551WK78cZ00jrpM+tTT2Qrb4R6Wbj7vmFoUf/D1af9X0/U6oaoXz94raPaof1fN2wDcppAh9uhhQQ1jsv+vXY0PC1+PX86larVnz4tZKed40rP7Na1OdmIeX+ji388eNnPYirJZl69iecvHnElq8sfGleTdW8w1Ep7dzByn4vRw/irdMDi7T9JxJ4KLwqFpsbs1W5H//I188FFnihgCC+tvOYzGotnntyVbbRR+knDtC/KESkdbBXaqXXJs+7PXx1P4l4RoVAwHt9p0WAzsaepi9areA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 23:15:10 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7e96:f1c3:2df8:f29f]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7e96:f1c3:2df8:f29f%3]) with mapi id 15.20.7091.029; Thu, 14 Dec 2023
 23:15:10 +0000
Message-ID: <c89705a1-5f7b-439c-a8c1-fd293ad612d2@intel.com>
Date: Thu, 14 Dec 2023 15:15:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/5] ice: add ability to read and configure FW
 log data
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Tipireddy, Vaishnavi" <vaishnavi.tipireddy@intel.com>, "horms@kernel.org"
	<horms@kernel.org>, "leon@kernel.org" <leon@kernel.org>, "Pucha, HimasekharX
 Reddy" <himasekharx.reddy.pucha@intel.com>
References: <20231214194042.2141361-1-anthony.l.nguyen@intel.com>
 <20231214194042.2141361-5-anthony.l.nguyen@intel.com>
 <CO1PR11MB508924EA519BF7AEA912FCADD68CA@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <CO1PR11MB508924EA519BF7AEA912FCADD68CA@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|CO1PR11MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: a37806e3-87f2-4675-8eea-08dbfcfa84de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7yHJrtZHoXgFCTTykna7LJ5AkWOIsd9q30B6Zb55sSGjpkytQwIIFkjPNIrsgO0MPhZaRK+Sx3I1ZIQyZbyjDaTQcCbtyBHXYqhCV8FTDcDy++lF9jXyMgf8GdHMpVcRsVL1MYwrtkSsOAbLAC0X+Ano4zXY9MXhQLgA+VyP8oitcZHZBjeTV64Vxf9+LoeKLdCsZBa4GlMFA3qdzaz+cy2omm74agE65FMqMYICKIosi+F9qPQZgvlddvBJ7nAQa5wwljK+rg6KOOebX9DUe19fsOQC+4UxIlQGHxps4fshH4IWvorEcegCbGPXny8tK0VH52sSMVfdanHkbGiMQ/eOmYAhFXf/m+3du8NfYUIpI8yDBiuaRsLFqljSxVluhlgbq4p5uLU7FtPmWh6xUR0fQOARFm0TqQv22mYOj0ZKbBDKaGgqUPBN52FyCJl5XaeMaZtdAWO7hSiKK+ek46XIQdwe/6GN8OWueXnkNGiCVJsDEafSuiH2KgO5IKXQW4KUwEkccfZ3Qu/mgKq3RXaOLTTe89CgJOSbGTk8kfq68GOkaourNbnQoOvKXrBm8uqDMHlkHKUET9OcaKSSbrxDOA8757exfN/vXNz2SGFD0J925dLvUc1sPp3ES7Xd9NDzOlPiElaiM6k20Krlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(478600001)(6486002)(82960400001)(38100700002)(31686004)(26005)(83380400001)(107886003)(2616005)(6512007)(6506007)(53546011)(5660300002)(2906002)(8676002)(41300700001)(36756003)(8936002)(4326008)(86362001)(31696002)(54906003)(66556008)(316002)(66946007)(66476007)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clJ2YUEyZFpJWTRZc0wveW9VSTN5b3JSYjJoK1VmNk4rZG1jcUFsMVFFbGdR?=
 =?utf-8?B?Y0dXVEdoMHl6R1U3ajNGazRSelBhMFJtV3VOejZyTnI3Rnh0TUNYUUY3TUVZ?=
 =?utf-8?B?R09LZENnV04xMmxiMmJzeWs5YVAwNGtkM3VwTGJrRi9tcWp3Y2pubVNMbTJp?=
 =?utf-8?B?UmRidndYZjB6TVI5UllJZk1rOFJqRmhKUG1MalRDNy9uai9GeUsvVnJXVmRT?=
 =?utf-8?B?WFd1QUNqKzduMDc1UVFKb0lVRDhjVGRaUUkrZEt3akZQQngxSnowVTB0TzJa?=
 =?utf-8?B?aFVZRzJUNVN6OHJvRVFDRU45dGM3bHdLQnk4SHE4VXFMZkZqemRSSEx6WVdR?=
 =?utf-8?B?bTdMY01hcEc5UnBSeTBzbm9kbVVFYVJNaDZVcnRQV08vMEQzb1JGY1BMTnR4?=
 =?utf-8?B?Unh0QkRsdDR6NkVWeXpvRnQvU29NVUNjS1pFV20rUmVZWG1mVGJ0cWJaM000?=
 =?utf-8?B?QTlZZXpxZTFmSkdTajVpQ04xb1c3VWRKallVVWtrdlhERFRwbDhzTkNDNnFB?=
 =?utf-8?B?VTZzR0R4YXVNQXd5bXErTVNnOVByNkdScFVRQlEyeE9ZS3lsVFVhdGFlaTM1?=
 =?utf-8?B?cUNJUWNub0ZnNXRuWmkzbUdXM25vMHdQYTF1amxIVFZwd3N3cktSVjJyK1o4?=
 =?utf-8?B?Uy9kUEVheVlWTjJtcHlBUzBrbWVxRXhaSXBNRGhIeE5GMUZVY3N0UnI3M2xh?=
 =?utf-8?B?MmtBN0JsYkZJSGhyeHVUSFI1U2p6Q2JJRis4QzQ0NXFtaER1T2pVR0hrc0dD?=
 =?utf-8?B?bkFmSFhkVzFjQWoydjdPT0k2R05xRzRJUVlwaUgxTllId3pJRDVOcXhwa3dn?=
 =?utf-8?B?aVBGbGUzZkVCODhyd2JDNG5nN3QwRVJ6Tk04SmZkV1FwYmptUHpBS2VLdzdV?=
 =?utf-8?B?TFl3QUVYa1Vybi9FaUFvdFpMYjFsRXpGcE01UGZjK0RKejQ2VFRiM1ZCK2VY?=
 =?utf-8?B?SDdmRHB6WER0TVU5L2VwcmVBNDZXZ0xhbFFVYUxlUEowVUFwSzlyK2dJN1dG?=
 =?utf-8?B?dXdTQUFFQTQ4ZVBLQmJiN1kvTkw1Y211RW80bFg3QmhCcitYMWFzSE9qNkY0?=
 =?utf-8?B?aFMvUEZnMnIwSGFuN29iMHNPM0JlRHNKaUp0Y29oS1RyNCttU3dUZ2xWSEl4?=
 =?utf-8?B?T24xS0trdVdQSCtEV3YremVJaWVSSm4yQzh4YkVZR3lSVG5NeFBWOFZrVVZG?=
 =?utf-8?B?MlJHSXBhRHFLbkZoSjdDR1dlaSs2OFA1aVhyRmVLVThhT21GcnljbHZramE1?=
 =?utf-8?B?VnVFZUpEcXh6ZENJeG5YSktxMFhhcW0zbjV0UVVkWUt3YXMvZjVIRXFPb2dZ?=
 =?utf-8?B?QWFaWVVNMERTeFkrZGtpelh3UDhqdlZhK05RdjFNTlBDakhsYWtScEJ1ak5p?=
 =?utf-8?B?NjFqZUhzeEVkSE5BZWhYVzY1YVRGREg3NGJQNFVWUVNtWE5YMmF0T1MyUHdl?=
 =?utf-8?B?K2hzYVdmSlRQRDh1R3NQTVJhRTRWNDZHUTBjM0pXa2J5YVdrejIwRGdQVndk?=
 =?utf-8?B?d3p4MzlqSEh5ckdidVlkUkUyWmx0cnRRRjRVR0poMmdDc0kwMTFNcGIrRitC?=
 =?utf-8?B?ZW5nd3dtMUtlR3UyWml4UlpoYTdYNWNWVTBPVXowOEM1N2RJbUdlMVVoWEhK?=
 =?utf-8?B?cFZEYlRrTTlDT213YVA1MzBQOFVNY0RMOXRlWlFaWU9URXd2UTNRU25kL3dx?=
 =?utf-8?B?aU9pUFAxRk9wbjhHaFoxanRZbDFrWThIN3FNTnFDSHBXb3hiRWhSV1VhMytV?=
 =?utf-8?B?SzJEbFAzYzB3UUNlSlJWMFJzM2xVUmNpaGVTK1JidXBHQTBiaGtpSXpOSHFP?=
 =?utf-8?B?MGFoR290OXRFUWZrTlV4WGpLTUl0aDNlUloyZjU0ekx2VTVsekRDNkduTk9I?=
 =?utf-8?B?T2JnZm1NQzVRTW9qYVI2YjRUWTlnVkZhSk9CSlBsVVBHMlljM29IMGNqbnZ0?=
 =?utf-8?B?dnA1MTZJTUJBbEJZVVJpdW93dGpjL3lRY250Nmc5RjNiT0htRk56enp2YkNZ?=
 =?utf-8?B?cEhUdVVGb0VtWCthUTd5VWxvL1J6KzBuUUJoc3JTTFk1dE9nYnI0ZEJUS1lm?=
 =?utf-8?B?OG9BM2FTN2RnbUlOOWk1NGlwVHRLZXhYK0E0REJSU09MKzNpUmZHUUVxaDFm?=
 =?utf-8?B?dmthVGdzL1g4bUlVWHVGclhQWDdvM2l3RzRFN0pRUXVVam9ORm9mbDRwTkI1?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a37806e3-87f2-4675-8eea-08dbfcfa84de
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 23:15:10.6153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nl8ah7wyjZWQxSl5+xdAcHF3ju863qgO6nS0Jxh1FdyV/GeCwVxNISqhm6pILHRB4q/AxdR989i2mGMfZjxAwfqQ8nS/t6MPtrvJLuEIICc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4865
X-OriginatorOrg: intel.com

On 12/14/2023 2:12 PM, Keller, Jacob E wrote:
> 
> 
>> -----Original Message-----
>> From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
>> Sent: Thursday, December 14, 2023 11:41 AM
>> To: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
>> edumazet@google.com; netdev@vger.kernel.org
>> Cc: Stillwell Jr, Paul M <paul.m.stillwell.jr@intel.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
>> Tipireddy, Vaishnavi <vaishnavi.tipireddy@intel.com>; horms@kernel.org;
>> leon@kernel.org; Pucha, HimasekharX Reddy
>> <himasekharx.reddy.pucha@intel.com>
>> Subject: [PATCH net-next v6 4/5] ice: add ability to read and configure FW log data
> ...
> 
>> +/* the order in this array is important. it matches the ordering of the
>> + * values in the FW so the index is the same value as in ice_fwlog_level
>> + */
>> +static const char * const ice_fwlog_log_size[] = {
>> +	"128K",
>> +	"256K",
>> +	"512K",
>> +	"1M",
>> +	"2M",
>> +};
> 
> The comment feels like a copy paste. The size should only matter for software and shouldn't have anything to do with he firmware as this is just the size of the buffer we'll allocate to store into?
> 

Yeah, not sure how that got in there...

> Thanks,
> Jake


