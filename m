Return-Path: <netdev+bounces-62116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A12825C47
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 22:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBE5285259
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CEA219E5;
	Fri,  5 Jan 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQdqkqrZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127A225CF
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704491738; x=1736027738;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DnERNzuVOhw75gvaEdUlN/hOX0gM1ZACJivKLYLBv3Y=;
  b=NQdqkqrZR26g12YiMPelzwGXU+Y4lxJ+QDintGDDCBtLldQku4kRGjOL
   nSVDAa0r/ATYtUMKq3R1fAn8kWvM6mVqtmPAffZhg6ejDzYtgqZCf2Sy/
   /jV6qK0BvxYLwB8eEcYqjsJWrdgBf7q2AtxVSX8KYU/fcCqpOdEQQuJ6F
   iz713BAxR6oBKRZF9q2bpQemmoYr2ouUuLE7QoDLHVdopD8bCIN64BGX4
   HCl+obQKVwawrgfUhG2vGfeQX+I4a5ElKVA0VDRzJvkELdHpj1favX7Ar
   fj95NYjL3pZvJl1SoarvQxGwiM0OB7MBKbc/bhxvN642H7BphLpd2Gke0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="463991249"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="463991249"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 13:49:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="924328333"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="924328333"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 13:49:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 13:49:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 13:49:49 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 13:49:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI/pLG01BvjM0fnIC000ozjOSvNFQehcns6XUrtiED2H3DUSQvrd5vS0HdwXEgprRJIiQXX1QskWvdf8NojaHg1wd+36zcJXoguentvZqLDtMvCj7sBRrC7Ebq065qUcJLPM/D2nY73P4xsGJpyY8znlPU1C5gSGNUPYG/UycekgpFhhBbR1kB7XbcBMaisUl/i5x8KViycSmsc2BR2H3sYpy9ZB3YtdmxGmpd3yCSrH6bfwHt5MTPBbo4ubROSibCvy0UijCtdxRYJ0K0n+xXhPEvTwX3UCHKLBmzGBQkxo+NcJlf1EWaotwU6o8dJcA+Ka5gyJ2CL/irFIIvOpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMHFt7IbeZfjU3nJSfwMGdR5Cw8oYLv6fzx0epSH6ZY=;
 b=YLKBRj3E/zKLA313BOPwonZaZZAXQas1EWkORW52szxeK9k9Oy6gWBoTwFPs87UPm+iTA8lARsmFt+yIq5a5pq+Xok3XiiVLsVjyUCWDHmIg2s+kYM5vqOJCnklPnvlCPTHcgqEeuPvT0npW/Zwow0f6a4vJbNw/SF5Zp/mBgBXcGBtVz4bBQ/8QvEiqn27Pbqj12jsjsI/Yv9IemQf8LFYafVSsEYO6hdGVYfVcLFbrV0THvdlSZIb7COeh3cAEc1KbItNbbgPpofVT07vQyAdfpgsFliJgr1xrxX+OMPITUF8fXgRFeU1xF8RrPsns5Yu7LvakPTsJQcWlG67xHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 21:49:46 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 21:49:46 +0000
Message-ID: <5221bfaf-31bf-630f-9036-284c83c3eb76@intel.com>
Date: Fri, 5 Jan 2024 13:49:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-next v2] ixgbe: Convert ret val type from s32 to int
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
References: <20240105103120.393911-1-jedrzej.jagielski@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240105103120.393911-1-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:907:1::16) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SJ0PR11MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: af4eff8a-d73a-47ed-4734-08dc0e383baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9+VftRFjh7gW5pVhA01x8IcwpyXVuCUtYWH4ZjzYeycQUYHCTd8FkimXe8zC80tMuQ2k/ufKUaAd5UoWQmEaIlM5uyUqnSRJMylMvN33fV8fYgbtDe/eo74wJ7ttMt0fzfhrV+mt12o/+A1MrPk0GQTBLk73HpDb7ZqWTZ9Hgil1+ySUsY4EsymfJQ9JJ7Lwvg1EUCSMfATNm2AIGMV1mfFVSMF/dmvDtzhBjsdWGe2WgjmNZAcqpZO+aczVg5XKMlJjvU9eJeisvS7lm60a6kCWpbvagB5XtkFxWfol8PU7a5a+PwlgP52rdRsVDNkjDlf5kS1tRkNebEd+UEvEswXr5et4j9gHEjHS83AuoF/25z4jWAygaVl5jD3PyKSNa3gMhCIyCW2FrfBYWeisU1y7SeqJc0Sf0SLadkxZErLwEhE+/L1I2ZXMv4Pgkn1UWXqmmGAfcUqi77UeGRwoerdpAJyDOZ61nc6YImLoK7KF9oHQIcEqZPUSSKBn7LUBtRUzLjcdHKzdFa/L1+ULFmXXDUky7qs8BRBohfD40Zf55i0+Zz6AvkIMEwmryqcOxKkJRXVZhnWOhYDgQHs3rksePGkaE1FEUQUcfzHxC8aYGGAek3nS0BJjkuVZzPzDweORmGqrBC+AXAARpJ19QIiPei5r0hVi1o/qTu7/Y7qtzNlNzcopkYwVOdwIbyU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(6666004)(6486002)(8676002)(966005)(478600001)(316002)(8936002)(66476007)(66946007)(4326008)(66556008)(2616005)(6512007)(6506007)(53546011)(26005)(2906002)(5660300002)(41300700001)(83380400001)(36756003)(107886003)(38100700002)(82960400001)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STNFSG4zQlZRb3ZDdlVQMXFhNFlvSHBqVXRNRkYzc0g5R0VoUTY4eXhXdjha?=
 =?utf-8?B?VHVTZTFNYjZncHFZdWt5NkE1TFJlR1A3R0xubkJqVkk3NXdLMGN0eFFDMlBB?=
 =?utf-8?B?SE1YV1p2YTNCNjlQczI3UlFOYVBZT3ViNUN0akkxMnJWYWRPWnZCSnVwRnZE?=
 =?utf-8?B?U2l2S291ZUdtYmgwOGZraEN5K2dXZUljRkNKaFZHemRvbU1lZC80eVBVd29k?=
 =?utf-8?B?NklQcjREcitjQW5XdWYzaUZzNmZ3andhQmJqTG1kRXlwZWZoU2pOMWpVNFRR?=
 =?utf-8?B?eHg3Z24zVTZ3ZzBhR0FrYTVCZHdvcWVLbGsrdDZWeXVjYWpHT1FMZEVNT2Ir?=
 =?utf-8?B?eVhrUjJFOHZCNkk1SmtsYlpUSDQrcGlON3FHWmZ2QUJNcE9sRzh1MmV3RDQ4?=
 =?utf-8?B?RHlpdis3SjFoYWxad29ydmlLUXkzOVhhdmRHWlh4VzU5UVROQUYxYUVNSVlX?=
 =?utf-8?B?Y3VnOEtvdmQxQTFMN1h4T0xuR3l6UERWY3BJNW5rQUsvZ0JLZFJwSjhLL20z?=
 =?utf-8?B?T0tmM2VhZmJINTY0b0VpUjZ4bUFhMjlNZzkxamNhVjhiZGdQbmp2eHJFaXRy?=
 =?utf-8?B?MzE5eUcvMWFrVUtobnEzcVA5ZWtNeXozanpLaC9YWnJUcXY0Nm9vNy9aaXlS?=
 =?utf-8?B?S3M5VGdDcmVJLzBhRFViN3kzcExvVy9RbTB0Z081ZmZhY08zK3lVSjdFb1l0?=
 =?utf-8?B?UFZaV25MMXRqaWRBeFlneHFISzBrV0NYSWtJdURtbEx0Tm56NHdpTTJ4MzMv?=
 =?utf-8?B?QU90c0tIcSs2M011YWlRQXZudk9aZWQxMDM5M0grSHQ3Mko1bTJmT3lJV3hk?=
 =?utf-8?B?dXhvQkVBc2txNkNTN0hoc0NHbXdFbXhEVVRmSDQ0NXlnUmIyTG9tODlLcC93?=
 =?utf-8?B?dFhSblBLUmhwL3lDYVdnaEx5OGhyM010azYzd1AzRFg0d01yK1FRNldhRHQx?=
 =?utf-8?B?eUgybUs1bVNuRlpBQmtZRWtOMXJ0eWNjTEsrajdsTTEzYmJFOWVFbHlSS1Iw?=
 =?utf-8?B?bUdrSGRzZkNwNW1JSXdHUXlBUXFTU2JEQ0tMRmc3Z0RGcE9GbTlxeEEyYnNJ?=
 =?utf-8?B?Q2FoYklQa0k3UlNhd29iRWhJWklkakdDSy95Z2N6RGdCU010S2FodmdDQU51?=
 =?utf-8?B?aVJ1a25TdGQyWGFIT0hDbExKVDN1K3NkWi9uOEd3ZTJUaXFKbTJXNmU4V1FO?=
 =?utf-8?B?UFcyNjhFL1B2eUE5N3M2NUYrck85MHNvTFBIWmkxQ3RDazBHWmlRMWZubjdt?=
 =?utf-8?B?ZHo1VXI1MGJlRTlQWjR4aEhydEVmbktxQXVPMmVmT2NHK1F5dEpKcTZtZkZK?=
 =?utf-8?B?M3N6RWhDUkFXb3QvUk1VdTdQanljQ0xBT3pSbmh3M1QwMU1rZk9YczFRY0R3?=
 =?utf-8?B?R1BIMmFvODBpMHFkQ2RZR2FGOVZ4cWlZS2NJRGpCWkc4eWtRV3NHc05WaDF2?=
 =?utf-8?B?dGljNnQ5Nm9hTTRxMXl6bDBqUDFWVnIydWJxSGtuREw5TVJBS212bEJsTG1J?=
 =?utf-8?B?dHRDa3JDZk9KUUpENDRXUUtSbXhKTDFUQ0gvUnN4QnN5c0p5Q2V6L1FVM2Fz?=
 =?utf-8?B?VCszUHZMK0lFbng3RDgxN2VxclN2T2RkMm5nQzhyd05OKzBEdHU0enNRc0Rm?=
 =?utf-8?B?UVZ6Tnp2aWE4ZHFUeitzTDdkb1RHWUgzcGtWVkx4WVQ5eVpuQ050UThFUTlQ?=
 =?utf-8?B?QnkyNE5OdWdLdEJ1djVzTnFnSlFoaktsNlpaUHR1SmVHVGFUMmxZeHA0Zk9Y?=
 =?utf-8?B?U1RNcm9iTm03a0d1QXVTcGpYOWh0c0FaVklCK2xSMVFjRzh0UlNPUktYMzRL?=
 =?utf-8?B?S2U5UXJLTFZOTXM0c1Npc2FBbmM3eFF1aFpkSE1NL0xtTDE3Y29UYlFoSGc0?=
 =?utf-8?B?dDBhb1ZMM2N5VTFWN2RGNTlkSnJ2dXdxNkxoRG85S3F6emI5ekdIeURkNk81?=
 =?utf-8?B?YXZ2TWl0QnBXVWk0Nm11NEl1ME5MMVdjeUt5SUlaOG00bXY5Rm40alFMQ1Mw?=
 =?utf-8?B?MS9oSXJIaGJLbGRkSUNBYUxiMVM0L0tYbzBqa2l2TlhoK1dpMUIxSExEWkhz?=
 =?utf-8?B?ZkUvcERFalhSK1NZWHhxMkNkK2JENG5ldnRJdWdZaE8zcGpsNUxmaXlYd0Z3?=
 =?utf-8?B?WXhoRmhPRWo4RFYvY3Q0c2tvN0dHdU9zT3F5QzkyVitHZkdjbHZnNCt2dTQ4?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af4eff8a-d73a-47ed-4734-08dc0e383baa
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 21:49:46.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNKxoqZAEK2fadq7nPjc6YSDep7wAkYuJrnb3sSmE+73A3RWamwbZ1CGbWLZUHDHQ4pZXCZcBr1Bzo7tGOb2viaW2QyIooiJbRelrDjhnTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
X-OriginatorOrg: intel.com



On 1/5/2024 2:31 AM, Jedrzej Jagielski wrote:
> Currently big amount of the functions returning standard error codes
> are of type s32. Convert them to regular ints as typdefs here are
> not necessary to return standard error codes.
> 
> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: fix smatch warnings,

These changes aren't mentioned in the commit message, however, it should 
probably be in it's own commit to keep the changes separate and easier 
to see/review (since they pre-existed this patch).

Also, not seeing changes/fixes to the second warning [1]

New smatch warnings:
...
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3130 
ixgbe_enter_lplu_t_x550em() warn: missing error code? 'status'

> alter the commit msg
> ---

...

> @@ -93,11 +93,11 @@ static s32 ixgbe_get_invariants_82598(struct ixgbe_hw *hw)
>    *  not known.  Perform the SFP init if necessary.
>    *
>    **/
> -static s32 ixgbe_init_phy_ops_82598(struct ixgbe_hw *hw)
> +static int ixgbe_init_phy_ops_82598(struct ixgbe_hw *hw)
>   {
>   	struct ixgbe_mac_info *mac = &hw->mac;
>   	struct ixgbe_phy_info *phy = &hw->phy;
> -	s32 ret_val;
> +	int ret_val;
>   	u16 list_offset, data_offset;

Should we RCT what we're touching? (many other instances in the patch as 
well)

...

> @@ -1866,9 +1866,9 @@ static s32 ixgbe_enable_rx_dma_82599(struct ixgbe_hw *hw, u32 regval)
>    *  Returns IXGBE_ERR_EEPROM_VERSION if the FW is not present or
>    *  if the FW version is not supported.
>    **/
> -static s32 ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
> +static int ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
>   {
> -	s32 status = IXGBE_ERR_EEPROM_VERSION;
> +	int status = IXGBE_ERR_EEPROM_VERSION;

Does IXGBE_ERR_EEPROM_VERSION exist anymore after your other patch? [2]

>   	u16 fw_offset, fw_ptp_cfg_offset;
>   	u16 offset;
>   	u16 fw_version = 0;

...

> @@ -2062,12 +2062,12 @@ static s32 ixgbe_reset_pipeline_82599(struct ixgbe_hw *hw)
>    *  Performs byte read operation to SFP module's EEPROM over I2C interface at
>    *  a specified device address.
>    **/
> -static s32 ixgbe_read_i2c_byte_82599(struct ixgbe_hw *hw, u8 byte_offset,
> +static int ixgbe_read_i2c_byte_82599(struct ixgbe_hw *hw, u8 byte_offset,
>   				     u8 dev_addr, u8 *data)
>   {
>   	u32 esdp;
> -	s32 status;
> -	s32 timeout = 200;
> +	int status;
> +	int timeout = 200;

unrelated change (at least a few others in this patch as well)

>   
>   	if (hw->phy.qsfp_shared_i2c_bus == true) {
>   		/* Acquire I2C bus ownership. */
> @@ -2116,12 +2116,12 @@ static s32 ixgbe_read_i2c_byte_82599(struct ixgbe_hw *hw, u8 byte_offset,
>    *  Performs byte write operation to SFP module's EEPROM over I2C interface at
>    *  a specified device address.
>    **/
> -static s32 ixgbe_write_i2c_byte_82599(struct ixgbe_hw *hw, u8 byte_offset,
> +static int ixgbe_write_i2c_byte_82599(struct ixgbe_hw *hw, u8 byte_offset,
>   				      u8 dev_addr, u8 data)
>   {
>   	u32 esdp;
> -	s32 status;
> -	s32 timeout = 200;
> +	int status;
> +	int timeout = 200;
>   
>   	if (hw->phy.qsfp_shared_i2c_bus == true) {
>   		/* Acquire I2C bus ownership. */

Thanks,
Tony

[1] 
https://lore.kernel.org/intel-wired-lan/08d8b75e-af80-438b-8006-9121b8444f49@moroto.mountain/
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit?id=5795f533f30a80aa0473652876296ebc9129e33a

