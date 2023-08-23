Return-Path: <netdev+bounces-30119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39BB7860D0
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D461C20D6F
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78321FB4C;
	Wed, 23 Aug 2023 19:41:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD039156E6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:41:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA38910C4;
	Wed, 23 Aug 2023 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692819678; x=1724355678;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jylm4oeEqAWtLxcOEY4+ixKB/FGyhjtQzfM/ku5UXxE=;
  b=hxR0fqHpoPrFX5uCDDzT/hO+LL+4HhBVs62XJjWRPeNFTXNxK11083Md
   igqPW1knjbQ8sOSS0puK5EG3ZTdsHNq9rxZTbVRgRBx64FdiTZTWSwIwm
   7pBdz6z2td/v3RcohExSHQ0e8+DMVRbRqM3U2gOvzFIPIYtuU+dlFSPt8
   WGaPI1pYp6ObaZW5wqBR1vDf8VkJxc2Sc94LsP6PIUe/v1B5vUvpyC6A5
   6YkpIXAcBVk/izF4R3fspLmooC7eZvus+qCkqjHIaegfPWEE3N850VotR
   uFwyUwRE5ezSfj1sQ4IabKnaKPTEoMIm1GY0z6F/djhK6SjVZHq4o3wcI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405258617"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405258617"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="802259703"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="802259703"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 23 Aug 2023 12:40:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:40:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:40:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:40:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:40:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwwqygVfqUn7oujOQ8gGybZzdI7L9U8j1tWFtglcm/e1taNxYmsEJ0mrS2sdJYFyWQHCWOQkR7hQEPhB7UGtu74iCu1EvJgV3zl7wP7hLoRyZWVHpu7MH9sgbUAYjoZ25kaF07NslRpfkjJn2V1qXYpuOTk26LG3vW/CNW7kvVnjBKivIFBa+R9lhxStz3GeQuhCI5QZuzMU+om3EliaWh4K4K93RFO35ZCp5+I6ZNxMAXE4FtUTa2cMDYX38J7QgfuX6h0vYcPAy33WqtG0xFW3NH7jpKAl8miMc/+b0dMpawDXUHlfUvRnZ0RdcLP29fUwahLxXFIAwYq9EOlt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WTI3YWDsicW8dwQI+hw8Mc9quOo+TzRwGAn9XFiMC8=;
 b=VA5nWHjl8gJgxZlydlQ9N3HlwUWFfYT39tS0BVjwYHK6UKvdJSeyxSts0VAJujSRCXBkCgPDYb4lXauObmFvZ779oIBUCmHUBH8hJ8DeKUlGO1HxyRLq/uHfxKSna9vp3NI+Njt9oQ2cq1YPfmCYvJ7XUtlN1MoD4iE8FBJyEHr/tXh9C2FBLlovUFdNjMcRBSIbiMmEgibANYRsqP4n13UgULGmNp2DhMl+P8yJ85XoHW3LtkzZkf3GGqPFSS59gVbYk0olCPMJpqvWNfgORHqRU/B6mhL4792P7hrOWuAAtFEArdI9IqqZkRETxEcAnRv3NG1PUEftYFbKl7XPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB8334.namprd11.prod.outlook.com (2603:10b6:208:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 19:40:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:40:39 +0000
Message-ID: <58eaf33b-019e-4064-57f3-4598f3b3dc34@intel.com>
Date: Wed, 23 Aug 2023 12:40:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 11/12] doc/netlink: Add spec for rt link
 messages
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: <donald.hunter@redhat.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
 <20230823114202.5862-12-donald.hunter@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230823114202.5862-12-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 08567329-5ede-4865-65fa-08dba410d479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7oZhKOo0pKsqFVbiZNTL+18b54wnE545VN5fJtOBhyaaA37SRaiijN0v0DEYul70/9GQRHnJXE2nGLSVhMCZPbf6DHXRT+EVHGKP96C1ey2tMGB/z98HgG8PiTzQffDmkYfOnYZPIai5uVDGlpsMEm+lU7gsWlIjIFJpYW9prubkjyKwSLY4BAdTWaBFZ4hdcQgmyLk9MnSYTa41LOj+WPIrbf5aQcZVUyQc9TSwnBAkREzl+x+ohZI+472QFXJwRKuDX3g+m3eU3X9z6n3Wkra46okMFJ6mK2qxndAaEEvoKU0H7WveJ+eHCTaAgCmjvAAq1WwDNYFRI/VXke8Fwid+WByYQlJwRfNP9wAw7SlT67R1UtPzjA1LhL4zpMpPCL9pWdr7QSwdswKq20GT/A0Qmibob98TPDirwd2vFxTQHOvpikpIg8B9PqOgRcuZVs8ifJ+dLCDhgtrgWV5A6Eu+XYaF4A8zQ+460mBFVsi8MhM8BhiaPw+w84nlX0sDje1cQpb9vfr9Fr2X97NW/qutjAz/kJN8OQUBi0Cvl8PBPlxNwF9PNc20ACEQStG33ywa2znuXZp5+uBG5Mr2nCYpXUNJhx5ffnrc+lK+HL0E++AhBLO7ceCA58lBp4TDbDyveYvoi6e+ixOZoIQQEEvCSdF67/h5sMCYZ0bqbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(186009)(1800799009)(451199024)(66476007)(66946007)(6512007)(316002)(66556008)(82960400001)(110136005)(6636002)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(921005)(478600001)(38100700002)(6506007)(53546011)(6486002)(7416002)(4744005)(2906002)(31686004)(31696002)(86362001)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXdlK0x1bUJWcG92Tkx5V0dhQlNBLzZjMUZ4anZQMGxrNEUyR014NnFaa1Rx?=
 =?utf-8?B?MFpWTnVjN3pFRWVhMmtLSlJDVG0rRXcwWmt3VkFDd1hlVWhieXJYU0d2QlI0?=
 =?utf-8?B?QnRwUkRKL0poN2tIbEFOcXBORUJnVkxmWkIyYk5JanZTMVI2elM0Uko0UVBy?=
 =?utf-8?B?ZjkrYUlPSm1lWnl6bFdmcGpZNVlOMXM1bWREWm04V0JsdlpVOFZmN2NFT0VF?=
 =?utf-8?B?cHd5WDRiVW9VenpvQjJmN2wwNHRaZE1hY0kwWGRaNG5UVTBjcWpWejZ4V1NC?=
 =?utf-8?B?UjArQXk1ZzdHOUNIRkkwd3FjZXdXck1NKzVrZVhpZG1Wd21RUlh4Z1ZYV1Jm?=
 =?utf-8?B?NzFLY2gzdlkza3ozMDVoZ3dibFB3SFFGTkZZeGV3WTlaSEZibkhsU1M0N3JC?=
 =?utf-8?B?ZnZwNjJhNWloRit6ZHp0U0VQUk96R0JTS2JNYWdyNVRCTThzeVUxVWkvMVp3?=
 =?utf-8?B?Nmp3Z3MwRVBBQmVzcVZuV0VRM0YxelpBdlpPd1lhM1MrVFBkdVBNazdNRUFF?=
 =?utf-8?B?cUVjVVpQU3VSVEVoWnRUcDN6ZFc3V0NaU2haMTRVUTJreTJxSjFKU0ppSTZp?=
 =?utf-8?B?UDdBeFExd0orUnRNWllmVVdjMkdZQVdIWUFDWm01bE4xWkQzMG01U0pSMWZN?=
 =?utf-8?B?cnFVY054MkNYZytBRFdCWjNIRnRYT3U0TWxtRERjTGlUSWhCNk0wSEVaaWdS?=
 =?utf-8?B?a2dmb21wWUgwK1RUVms5bjR2YzFFMmJGbTJaQ0dnOFo5RFZJOTNxZDIwcDdK?=
 =?utf-8?B?ek1ld2lqa2dndzFENEYzS3dkTTVBUEJXQ1V6V3FaQWNvZk9MbWpkRjB0ZTFq?=
 =?utf-8?B?WldjaE1qclZMWnRxcHFuakZ0WUM4blFhb2lXZmdLVVZxcmVQYk8wbStFR0lB?=
 =?utf-8?B?VExsLzhNd2Q5eVZhSEs5MEJVZTc5TTR6MWwvbXlhMGVZL1RDU0IxbWFRbCs1?=
 =?utf-8?B?WWZRMUxrd1YyNysxY2pKVDlJUVQ4OHhNbnlBeFBoVGdyelVoM3F2VkU1d0Q4?=
 =?utf-8?B?QzJtdm54MEJqSHpPUWhsRlBjdjVNZ3lSazFqa2ltQk1JSTI2SjNDVUdYQTJH?=
 =?utf-8?B?aEJBTWhKMXEvRGZDeHhoRzkvVEkyamllYTFSMUEyWHJISDduaWNqR29nT1JT?=
 =?utf-8?B?aVdIUWdXenVvd0VJTWJ5bWRya0toajluNnBVYm5XMlRmUGVCelFza1dxTUJV?=
 =?utf-8?B?ZjQzNWVBKzZUazh5WFZreEl2dzN3VndHckJYRTlkd0lLalVRVE8rTWNLeGhn?=
 =?utf-8?B?WWNReVFCbVltTE54OTJQUXVhZWJ3ckFLSlg5YnA0MHBQZWVQUzlFK0tKQTc1?=
 =?utf-8?B?NG5UL1pwME9ic3BHbWtaZjRqb2Q0dmd0NTRYZEh2RGF5cXQyR2g1SHFINWNy?=
 =?utf-8?B?NW1pbmdZNFVZcW50SkdkMGdqd2g4Qmg1cGZCSENyTFJUN1dJMW1jMlBXWS9n?=
 =?utf-8?B?aHdRSE0rYTY1OVo1aWZnQVlDcDZyWHdrUlBqNzFRb2lvdTFQSk83OHh3RWZ4?=
 =?utf-8?B?RWZERmN5ejFKS1NhZm84YUhIZkxpQkVWY3NTOHVXVElPRmg1ZFJrMy9CVkM0?=
 =?utf-8?B?U3lucEVDZktTNlNZeVRSVjRRRU1hWlg5dk9pZ1pyZ1F3UE5qYUYrbWYwYUJu?=
 =?utf-8?B?eFlubW93SWc0S1I2U0tPQk8rTnZ0UnNmS2loRzh5aG1ZcjlITzNHQStmbkp5?=
 =?utf-8?B?RGE5MTdmRWtVQWZCMzVTdDU4bnVFU25hTlFWb0JUTjc5a21pWDFaQW1pY29u?=
 =?utf-8?B?MW1QT2lwcUt3UWZyekttQ0xqb2s5Mm82SUd2U3hKUWkrZkI2YndsWWxzWlFZ?=
 =?utf-8?B?TWRnOUxGZW1wcysxS3grVnNlQnluLzFVYmFNK2NoTkNWOTEwc250bnRObURs?=
 =?utf-8?B?d1NvKzUxNlpKSDdTbHpadXdqdzhqVDlnRHcrS2pWMnk1QnpRYVVpRkMyVVVB?=
 =?utf-8?B?MFQwc296amF2cm55VHYrZ0xVektDMzVtN2dZazdXemw3R0dTY0U2MVlVQU1l?=
 =?utf-8?B?VUhPMFN0c1lhSFJIRmEvOGdxdWJURWkvU3NmYTM4R293VVFZK2h4YlNXNVRl?=
 =?utf-8?B?a1dqWVNXaDJXSGtGeWdZT0RkZHVDZHlEYnpWeUJ4MVNjR1Y0bUlTM0RqQ3NC?=
 =?utf-8?B?Tzc1UmFldEZsL2dDRWo2UlI4RjFlMHA0cnljZEVQcHdSOGp3VGhFRlB1aGpM?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08567329-5ede-4865-65fa-08dba410d479
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:40:39.5512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoLwKs+qGQClZyFbEBB2wnqamk3RO3+MLPkiidiRAV2PRVvPCKHbUXxcpy5jckO/x8vAkqwOQtZBcDVvOzsCB6+gvGqASyeSdd2NNappuXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8334
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/2023 4:42 AM, Donald Hunter wrote:
> Add schema for rt link with support for newlink, dellink, getlink,
> setlink and getstats.
> 
> A dummy link can be created like this:
> 
> sudo ./tools/net/ynl/cli.py \
>     --spec Documentation/netlink/specs/rt_link.yaml \
>     --do newlink --create \
>     --json '{"ifname": "dummy0", "linkinfo": {"kind": "dummy"}}'
> 
> For example, offload stats can be fetched like this:
> 
> ./tools/net/ynl/cli.py \
>     --spec Documentation/netlink/specs/rt_link.yaml \
>     --dump getstats --json '{ "filter-mask": 8 }'
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

