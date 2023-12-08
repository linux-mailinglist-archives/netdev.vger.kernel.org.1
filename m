Return-Path: <netdev+bounces-55115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD66809734
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 01:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F2DFB20DE2
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 00:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B588D371;
	Fri,  8 Dec 2023 00:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHaeTove"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A9F10DA
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 16:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701995313; x=1733531313;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uQYqQmjx4YVTcA6z0np96qClgbKfihkgZ+0C5xEjn1s=;
  b=aHaeTove8GZPNXjJT1yLQnUal/c/TnOB/nl1haWWaAM4K3ZuGgAbC6Zl
   7N+lJtQBeNdx3OdcoQYcJgYIZp14v6eIHT1QfLHBS8bjQ7vvJhhSKnKQL
   kFenqtBOeKrlsCxXwrS0nW/lCXgIysgIFKFsQRxD/5a9ELkin781ypFWm
   lDffYby8A9G0hb2+i3ZKwFIG/XTnma9Uz7obF69HKZCdtR6VkGYt2yQ4U
   IQid1HENaCisKF02+TPcF4H0KaBYRs10dzf0yj1h4Zb2/IxVmbM5tUdyx
   MpvuGdpuJTEBqIR/o0RW04oyd3ScMZ/c3QbS1T/u0fQaOjjt9Dso0lA74
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1214577"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1214577"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 16:28:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="837948234"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="837948234"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 16:28:31 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 16:28:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 16:28:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 16:28:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nkz3YLDWAzSUJGcNW9qQM78cCXpogJRss7/L7EU2Y5VKVIieotnZOoz4hT/75YiDS+rEaqroIAITees8m5tz9myVuqdpkNfrr/8UdBq0JyuSOKVp5OVTlFIO6vWCudWo+HhWFs1qTto/a2ptwfusW2rx64vfJ8vZdAWQSAestHCMiB7xzX7Ocrq1gv8aJZdyH63wxG5nV60g5NqR6290Jn6Jg+EB6gokQ1azArQk3Y+SiLJAd89twOijfKrhxPqJtvUC1GNTc7sj8I2YxsuRz+m76N/E8RN68+OG+anDUwWkRPwU37+rh4gaMZEI29fJXJ1KsoL4JwuhKUi1oq9wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bgyzwDk6+J6N9EPbFBaUSwQts+9JmhuU3Csvilzg0c=;
 b=ggEqX19c9Obcvx/kTysNXSwPlxg8ii6U+xovGvbl3Z9/f7sMHer3U2381wv2iU+sSj8aXPccr2Aq2zR7xEnrVpqwoc8RY/psk69QQKizr/eCNrrVJ8Kxs9RR8PvNpwMc/f5gr2aNboWiMndG7jphFgGpzpA3MDD3iqJNSrbZXIq4pFoRgatWHeeTnRyS8UPcK2QNMod0tL57raBUOXX925UbSunMS1K4JDjoqQwsko6hzUyyqdLaw4P6AvzaRSpMIyVFG1tNdmsSRjugwo1ckt0+0j16aUyisNayCyEGKUykCFOoxKtJ2zFYJyKEBI5wP1YVoK5Myp1PVFFK2vH5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5647.namprd11.prod.outlook.com (2603:10b6:a03:3af::6)
 by PH0PR11MB7496.namprd11.prod.outlook.com (2603:10b6:510:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Fri, 8 Dec
 2023 00:28:29 +0000
Received: from SJ0PR11MB5647.namprd11.prod.outlook.com
 ([fe80::4d73:9ea:9ca0:ab53]) by SJ0PR11MB5647.namprd11.prod.outlook.com
 ([fe80::4d73:9ea:9ca0:ab53%4]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 00:28:29 +0000
Message-ID: <75bc978a-8184-ffa3-911e-cceacf8adcd0@intel.com>
Date: Thu, 7 Dec 2023 16:28:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v5 2/5] ice: configure FW logging
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <jacob.e.keller@intel.com>,
	<vaishnavi.tipireddy@intel.com>, <horms@kernel.org>, <leon@kernel.org>,
	"Pucha Himasekhar Reddy" <himasekharx.reddy.pucha@intel.com>
References: <20231205211251.2122874-1-anthony.l.nguyen@intel.com>
 <20231205211251.2122874-3-anthony.l.nguyen@intel.com>
 <20231206195304.6226771d@kernel.org>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20231206195304.6226771d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:a03:117::32) To SJ0PR11MB5647.namprd11.prod.outlook.com
 (2603:10b6:a03:3af::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5647:EE_|PH0PR11MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b2408f-1223-4305-f8dd-08dbf78499d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1ZFlfy83CExV+UGuP/dRYsxvR4GqB3Pv7s/Q8S989KBqe1f/DplKrMSdU/Tv3kvbVRv8e7EYHkrXfSh2ghuR0622QQjPi2YD2EVZRy+155i+hFdoUrDQXK3kiqyu/xps5B7pn/CDUQU3IleXh0JTr/cVo/0r8/iND0izHw8sxdkkFTf7HAZ3bJYxzHka0IvMqPM4MLTmOgtWoD2royP+wiA7WU1omZi/KZSeiq4U4GRmK1WVky7e41m/gJ0ZupzuP4cr/90Lxzzq/v68gvgC/4Rf2fDKjroEl/K8KDA+uEQb79m61rCTuGCCzBz61SIBNo6K9NWjvxiiKcvI+am1g+3Fu0NXIceck0ts3FgwotiuJSgs69tIdIdD2hXsk2CK2GRnLFyDaqUPxwAsft6C14Uzrc6bPjcnh+rnXfjiktoIACmPKSPJMu6nQxvLZMQ3GK/Oyi+uX2Ik/AkxcWUA1mBQsKYsp86Zidc8JFg6AAf/7GOuf8+qSrdvoR41CWIwcJbKeuso6OsZ1vFcKy/BMRzJmmDtPGA61XUjuQ/IQNAB7CGpyBTsNcRK9bKj5vam5SrydE/nkbUddd5skKETDTHnd5mC+Nb+D2yFHCn3onnBSshnK3JI6W5SAvyzP8GIbfbgo+RvZzD1TYRo2mn5qoMWvn7DaqYHIVMTPjo358078PpN6gGa98ppfRMddlw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5647.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31696002)(86362001)(8676002)(4326008)(36756003)(66556008)(8936002)(5660300002)(110136005)(31686004)(316002)(82960400001)(6636002)(38100700002)(6486002)(478600001)(2906002)(6506007)(66476007)(53546011)(41300700001)(107886003)(6512007)(26005)(2616005)(66899024)(83380400001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUUwcGJYZnN5US81REpoUDQyZk0xUmxiQm9iamcrQW9MWFVYTmpod2M0THlL?=
 =?utf-8?B?NWQvNVN0UWlRZWZjOUZ1M2JLOGhBQm8wU2FEalNQVENJZVNhLzJsYmtOdURE?=
 =?utf-8?B?ODJ2aEpuQldIU2YvMmtNeTFkVDROUGk5SlIwWDB5RXgzZ2t4aEdFZ2JNVkZU?=
 =?utf-8?B?WTdMSS9lOWNFN0xjenZsQm9paFhUejI3aENsV2tnZ3g3VGY4aXdvcmhqOEVu?=
 =?utf-8?B?NVVwTUp0VnVJaWIvMzBmSk94STFwVXYwT3dpZFNvOE12MkJoNnQ3TndCSXZu?=
 =?utf-8?B?SnZlMnB3UW5LUTRZMmlaV05Ed3N5SU1wdWpFUXFHeWtwQ3lJZ2d0WGdUd2xu?=
 =?utf-8?B?eWJLWmp0Z2liSmdubnZYWStVQldMNm9DTy9ZakhURnVEcERDNkwwWnVmOUFT?=
 =?utf-8?B?RVRIeTk5NUlsN2NxbGJJZXpJc1lqa285b1p1RFV2cDJkZlFXTUFaMFJ1ZDBS?=
 =?utf-8?B?ODRKV3hjdlVlMDZ0R3oxUHlFQXZ2Q21wajlid2lWRkxnWjFLSSt1ZlcyNitQ?=
 =?utf-8?B?WHlWb0FudlN0MDJUakgyZTRsSU1ER2piWDlFSVFPbkNpQzU1OW1sRlRjYkVj?=
 =?utf-8?B?TllRb3ZJTlErSGJmT2IwaTBKektSN0Zma1dkdjNBRCtDMHlJMWQ3S2JkODVr?=
 =?utf-8?B?OE5IWW9PME9mNEhKYUd0TXRPNjF4dGlFZ2EyK0NwZkJ6Q2VHWmRRSldvN1BS?=
 =?utf-8?B?ZFB3ek1jd2llb0JucU1HTWdxL2V6UWNPNENMSFdtMUU3bCtzaXc5MTNwVStL?=
 =?utf-8?B?K2daSklpV0djSldnZTBNS2NDV0R6dVpNMXpDUE1wUEt3QTRJYXZhQk5mam4w?=
 =?utf-8?B?aGIxaEh3clZqajhQRHREWHpuaGFVWWFBR0lNQ2w0c2krVXh3bnFvNG1sZG1Z?=
 =?utf-8?B?Ukc3WDVDL1o4YjAxV2lEVW45QmVpNXBOYVY3a2JZRURhc1ljdWRQcEkyT2Fa?=
 =?utf-8?B?UVRvSk5sV2RFQVI3MnJYbXo5d3gyRHRUUkh5ajJwSHA0RHBqZGNqZlRleEgy?=
 =?utf-8?B?UHZPMkF0WUhpcFpLU0RHTTJDdy9RWDFacW96anZTMjdVdmVFMk1PdkM0RFc4?=
 =?utf-8?B?N2tpQ2Z6Q0VYelN2cDIvZjQ2TnRBU3Q3a0k3VWt1UmJzaWRSc3dyOW9KaXFw?=
 =?utf-8?B?OEp1SE5DaDVDamFCa0RZZUFXRnNNWmlEdmRDUm1MRC8zeWt4aUcxUHpzNDMx?=
 =?utf-8?B?VUNNNWlzUEx4YkhmT0MrMkY2dHA3KzVMdStZTm84ZytFQ0JlOFJOZVkvcXU0?=
 =?utf-8?B?Zzd4TjEzbU85Q2FNSDUrNDNNZy9MeW1jWWhnaDl6QXZoVGhiMWpWencwOU1T?=
 =?utf-8?B?RUh4NTkwb25wcGJOQWRhNy9ubnRnaGtVRm1tbDlUZzVEQzFwaHFSNTNTMGkx?=
 =?utf-8?B?blczQW9ieUtEVFVWbTF2eDZqOElEY0dpMjNXRWJoemwveWNhZ3N2aUMvUkdU?=
 =?utf-8?B?Y3dZS0I2dWIvS2ZPVk5jc0E5QTR5eU1GdjJsTUpKMDJSWDJVK0V3aFRLMVdk?=
 =?utf-8?B?SnJuSjlZVFlMY0c1cTBtZjFSN1FYUTBYQkhYUFY5WjFtVkhmbUFDWTJteGZH?=
 =?utf-8?B?K2drWVhEZ0piTXRSM0pKYmxSODlOYURBNkRrWEFjWjdNSnNQUUZ6UmpwNGtJ?=
 =?utf-8?B?S3I4WUptYnVqbXlkZFptKzl1M01XUnRtUHJqKzJKeTFtdDdWOUdNVGlybWNa?=
 =?utf-8?B?dUZBRTc3dVYrZi9NOXVCaE9EWWUxQWFTeWhuVXVWS2g3RVN6eG9yQ25jNWJo?=
 =?utf-8?B?TnJWamNDVUJLM2h5ZC9JRlB6ZXJ6eW5NeVR6Uk5odGNyTVAvYUFGZWJwTVF1?=
 =?utf-8?B?OFJmUVpTMnJ1eVNTb1BaMGl2c2JlNGt3dlpaWm1mcjFPMEJWSXd6cTltczNI?=
 =?utf-8?B?em5CTTBtY3dBbE9rcE1TZnVleEZVZWwyaExrV2oyZXhmVlJncGxUakJlR1Ix?=
 =?utf-8?B?L2hiUHpCdlo0NXR1aFc0RUtWeE81ZEt1cmFEYW10d1NCWmRpV3RrT0RqVGxh?=
 =?utf-8?B?aE01VjF1L1pTYkFuc2J1VFhPMzg3RzBLRWtQRGlEVnJPd1dtOFl2b0cvOG5H?=
 =?utf-8?B?MktGeDZtWWZobmdDSWx4aFZ6RHhJSG5reWdibTEyaGJVMVlXbU5KM1dMcGpo?=
 =?utf-8?B?RFBoRGY2T2tkcHA3S1lqS1Y4SW1KaldjK3UvOGpORlBuYzhmUGRtWDZidnFJ?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b2408f-1223-4305-f8dd-08dbf78499d9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5647.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 00:28:29.4380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3iFAgkyrhG2vIhlgxaNpzkbv++TEIVEEttuOkDyXOrKV1ooo7UfZFncx0WYeylHUjA7JYCTBSPLFqgSJpavV13p5Jc4GXC1ZJ36FA7zeg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7496
X-OriginatorOrg: intel.com

On 12/6/2023 7:53 PM, Jakub Kicinski wrote:
> On Tue,  5 Dec 2023 13:12:45 -0800 Tony Nguyen wrote:
>> +/**
>> + * ice_debugfs_parse_cmd_line - Parse the command line that was passed in
>> + * @src: pointer to a buffer holding the command line
>> + * @len: size of the buffer in bytes
>> + * @argv: pointer to store the command line items
>> + * @argc: pointer to store the number of command line items
>> + */
>> +static ssize_t ice_debugfs_parse_cmd_line(const char __user *src, size_t len,
>> +					  char ***argv, int *argc)
>> +{
>> +	char *cmd_buf, *cmd_buf_tmp;
>> +
>> +	cmd_buf = memdup_user(src, len);
>> +	if (IS_ERR(cmd_buf))
>> +		return PTR_ERR(cmd_buf);
>> +	cmd_buf[len] = '\0';
>> +
>> +	/* the cmd_buf has a newline at the end of the command so
>> +	 * remove it
>> +	 */
>> +	cmd_buf_tmp = strchr(cmd_buf, '\n');
>> +	if (cmd_buf_tmp) {
>> +		*cmd_buf_tmp = '\0';
>> +		len = (size_t)cmd_buf_tmp - (size_t)cmd_buf;
>> +	}
>> +
>> +	*argv = argv_split(GFP_KERNEL, cmd_buf, argc);
>> +	kfree(cmd_buf);
>> +	if (!*argv)
>> +		return -ENOMEM;
> 
> I haven't spotted a single caller wanting this full argc/argv parsing.
> Can we please not add this complexity until its really needed?
> 

I can remove it, but I use it in all the _write functions. I use the 
argc to make sure I'm only getting one value to a write and I use 
argv[0] to deal with the value.

Honestly I'm not sure how valuable it is to check for a single argument, 
but I'm fairly certain our validation team will file a bug if they pass 
more than one argument and something happens :)

Examples of using argv are on lines 358 and 466 of ice_debugfs.c

I'm open to changing it, just not sure to what

>> +/**
>> + * ice_debugfs_module_read - read from 'module' file
>> + * @filp: the opened file
>> + * @buffer: where to write the data for the user to read
>> + * @count: the size of the user's buffer
>> + * @ppos: file position offset
>> + */
>> +static ssize_t ice_debugfs_module_read(struct file *filp, char __user *buffer,
>> +				       size_t count, loff_t *ppos)
>> +{
>> +	struct dentry *dentry = filp->f_path.dentry;
>> +	struct ice_pf *pf = filp->private_data;
>> +	int status, module;
>> +	char *data = NULL;
>> +
>> +	/* don't allow commands if the FW doesn't support it */
>> +	if (!ice_fwlog_supported(&pf->hw))
>> +		return -EOPNOTSUPP;
>> +
>> +	module = ice_find_module_by_dentry(pf, dentry);
>> +	if (module < 0) {
>> +		dev_info(ice_pf_to_dev(pf), "unknown module\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	data = vzalloc(ICE_AQ_MAX_BUF_LEN);
>> +	if (!data) {
>> +		dev_warn(ice_pf_to_dev(pf), "Unable to allocate memory for FW configuration!\n");
>> +		return -ENOMEM;
> 
> Can we use seq_print() here? It should simplify the reading quite a bit,
> not sure how well it works with files that can also be written, tho.
> 

I'm probably missing something here, but how do we get more simple than 
snprintf? I have a function (ice_fwlog_print_module_cfg) that handles 
whether the user has passed a single module ID or they want data on all 
the modules, but it all boils down to snprintf.

I could get rid of ice_fwlog_print_module_cfg() and replace it inline 
with the if/else code if that would be clearer, but I'm not sure 
seq_printf() is helpful because each file is a single quantum of 
information (with the exception of the file that represents all the 
modules). I created a special file to represent all the modules, but 
maybe it's more confusing and I should get rid of it and just make the 
users specify all of the modules in a script.

Would that be easier? Then there is no if/else it's just a single snprintf.

>> +/**
>> + * ice_debugfs_fwlog_init - setup the debugfs directory
>> + * @pf: the ice that is starting up
>> + */
>> +void ice_debugfs_fwlog_init(struct ice_pf *pf)
>> +{
>> +	const char *name = pci_name(pf->pdev);
>> +	struct dentry *fw_modules_dir;
>> +	struct dentry **fw_modules;
>> +	int i;
>> +
>> +	/* only support fw log commands on PF 0 */
>> +	if (pf->hw.bus.func)
>> +		return;
>> +
>> +	/* allocate space for this first because if it fails then we don't
>> +	 * need to unwind
>> +	 */
>> +	fw_modules = kcalloc(ICE_NR_FW_LOG_MODULES, sizeof(*fw_modules),
>> +			     GFP_KERNEL);
>> +
> 
> nit: no new line between call and error check
> 

Will fix

>> +	if (!fw_modules) {
>> +		pr_info("Unable to allocate space for modules\n");
> 
> no warnings on allocation failures, there will be a splat for GFP_KERNEL
> (checkpatch should catch this)
> 

OK

>> +		return;
>> +	}
>> +
>> +	pf->ice_debugfs_pf = debugfs_create_dir(name, ice_debugfs_root);
>> +	if (IS_ERR(pf->ice_debugfs_pf)) {
>> +		pr_info("init of debugfs PCI dir failed\n");
>> +		kfree(fw_modules);
>> +		return;
>> +	}
>> +
>> +	pf->ice_debugfs_pf_fwlog = debugfs_create_dir("fwlog",
>> +						      pf->ice_debugfs_pf);
>> +	if (IS_ERR(pf->ice_debugfs_pf)) {
>> +		pr_info("init of debugfs fwlog dir failed\n");
> 
> If GregKH sees all the info message on debugfs failures he may
> complain, DebugFS is supposed to be completely optional.
> 

I'll remove them

> Also - free fw_modules ?
> 

This will get fixed by using goto in error paths as you suggested below

> You probably want to use goto on all error paths here
>> +/**
>> + * ice_fwlog_get - Get the firmware logging settings
>> + * @hw: pointer to the HW structure
>> + * @cfg: config to populate based on current firmware logging settings
>> + */
>> +int ice_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
>> +{
>> +	if (!ice_fwlog_supported(hw))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!cfg)
>> +		return -EINVAL;
> 
> can't be, let's avoid defensive programming
> 

OK

>> +	return ice_aq_fwlog_get(hw, cfg);
> 
> 
>> +void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module)
>> +{
>> +	struct ice_fwlog_module_entry *entries;
>> +	struct ice_hw *hw = &pf->hw;
>> +
>> +	entries = (struct ice_fwlog_module_entry *)hw->fwlog_cfg.module_entries;
>> +
>> +	entries[module].log_level = log_level;
>> +}
> 
> Isn't this just
> 
> 	hw->fwlog_cfg.module_entries[module].log_level = log_level;
> 
> ? The cast specifically look alarming but unnecessary.

Will change

