Return-Path: <netdev+bounces-30041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AEB785B58
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8971C20CD8
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDD1C2D8;
	Wed, 23 Aug 2023 15:01:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D9BA45
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 15:01:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F206EFB
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 08:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYm1gZqKLU5ReLZVJHbtjrTMeKSKPyiYTxgGyjO/Yll6unr8J0+fPHrEtJGita5UQ8Fzj+MZPvLy0pxp6an/sY5b5N5BzhkDUJaTmRE66oiOherSoPAveNt6482qMGcJcrmz/WVtTi/u7RnTMHzwX0PBPGsMN3/IhNXpgCkv8Wek6leYSAFFJXfgr1tvFcfrAnOxa8GoSDUX9TbNTwoX4z0rJWKVQxAT17W+nOXntr6OuAcVTKd0+eyU0Le85VNtZ4aoULb12mmihSTfKxOHGeL3tbfH2gz32HLc7hRnMHdDEwpIlNPC//gbzyp2pM9IBnbV8pZXp4ZjpzUp/wGksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHM96VtGP/VnBm/wHXb7yZp3mWOafMkBZfdPM45cxRo=;
 b=buKqpRKpg5FoQy7gbYe8c3kprT8ugw0p774N4a2jI7KZ+Gc7yDtvVlJTmsAKXRCdhEn4QFS1ojEO8vt/uKrvwkrqFfF17uajZKP6e5FXph5oPx6RxgJu0Osk4LOsjiXRB6KzOx2FfCnF4A/cqNFuY/CwOrLOL8QAk5IKanuHtrPum0ET/BIWWn4vVFMuQ8aH++w2Hf3VC1LflEWM5zbQy7V8g0KOnouRZYbtLleSqdaEB4KyU5aWjn1WHgNKWoiD4Z8E7sgpFx2X8E2JPM3gRAdGU5x1oTSL8MaxLcs27ks79qGvPStY2VoYHgKdW4EPbHM2OXT97JeNlM0NvOO8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHM96VtGP/VnBm/wHXb7yZp3mWOafMkBZfdPM45cxRo=;
 b=zsPw6D4EMI4/foAH2B6EFaQHPoz4/MwWtwCKzWuDA2KzKDnOlc4e2ZX6o9dd49XM9c5aHzV9pnKHa7SrMNqIzkDCFZ/u8ZJgFEO45bbGTIxVhfOQY958GiHr0e3+kfrc/09nRUPij/C1Ya5ymHWEzROgV6oTzIP3p2Dvnc1k+N4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) by
 SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.25; Wed, 23 Aug 2023 15:01:42 +0000
Received: from DM8PR12MB5398.namprd12.prod.outlook.com
 ([fe80::cd16:f185:acb7:e047]) by DM8PR12MB5398.namprd12.prod.outlook.com
 ([fe80::cd16:f185:acb7:e047%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 15:01:42 +0000
Message-ID: <68884b04-8019-37e9-5907-beb8ee7f91c7@amd.com>
Date: Wed, 23 Aug 2023 16:01:35 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 5/6] sfc: introduce pedit add actions on the ipv4
 ttl field
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org,
 linux-net-drivers@amd.com
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, ecree.xilinx@gmail.com,
 habetsm.xilinx@gmail.com
References: <20230823111725.28090-6-pieter.jansen-van-vuuren@amd.com>
 <202308232244.jYYwKnlV-lkp@intel.com>
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
In-Reply-To: <202308232244.jYYwKnlV-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To DM8PR12MB5398.namprd12.prod.outlook.com
 (2603:10b6:8:3f::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5398:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eab8534-e3d7-49a3-9133-08dba3e9dc1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jD10voMp7LpdRnPkKdrAYAmafu01gmg9wGYx2cn+Aq3YlojkPDQToIFfv/kEBSd7loXqGkeOSPWme3oBwMrwjwNTKrD97KFCnuJ5k3ok0tqR38YzGSHdYPy7N01F+nTQ7E0csP6/GAbIAFpxMWNzn763jYtphfxA0xH9YQewGhLHmliRTHaKu8U9+tbpxadWUEjriP2U9UD6jNNl1OyN6j9PmTpdPyPp89ZmSRZ39GBXGLgt89PfhjHsMnEQHVr3Q05T5RfNUxIlbnjEVR2GJGP6QyxU4bpVT8lcbcbnVSxpMYq1XBpGeaTZmJfvzmgrRwx0mbZgGL63u7kIiDYwnxBi//7OuBgW6inDbgW5JsGAsKl79yMxFne4VJOVETZ+18HH9MLGUXnk+oYnMaLwcKNPuu7899UO1Lui4BR8lpXrmURP1AEYWR+Q08/GqkXcAiJkAm8rO1cg5k7CBZCIan2Y3Lbbju0MfSmNAzDa6AsxqOevhAEY7sXXJX6qnieMFbETXpUoNhrNvJRoSZGkLL0Vl8ILzW50/guZXJjlbBNAXNye7e0QIe5uN+NfhbWgDdLzsQ0cJX5/i66afojRISWlUkNwIfMjfjy4obnPA/2Z29stuBbkUr12nUHZNgmJ1QLjz7G5iYtwXfWf8qmpP8pGD8H6u///cOSD8LM9Wb8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5398.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199024)(186009)(1800799009)(31686004)(966005)(478600001)(6666004)(6486002)(83380400001)(38100700002)(2906002)(26005)(6506007)(2616005)(6512007)(41300700001)(8936002)(36756003)(66556008)(66476007)(31696002)(316002)(53546011)(86362001)(4326008)(66946007)(5660300002)(8676002)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVoyY3Z0RGIrcHU4TGRxUXpiTWdGcXhTYXB4b2Q0NGlHenhGNkQrL0w4by9y?=
 =?utf-8?B?R0gydWF5QUhiN3p6d05DQm9mbVRnZTFEVUpZdFhqdmIrRHh3RGMrdXRRbDhm?=
 =?utf-8?B?MEgxeWlXM0FvSllTOUF2VnRSckMyR1dwYU1BOTFMY0F6SktpcDdQdnVRaC9H?=
 =?utf-8?B?SWlqNXVLMjhacTRyTzlZV2hHa3BWWHhUY2hTcXpEdmkzWUdmYU4yUjBsUURy?=
 =?utf-8?B?Z1dWT0U2RjNJY1R2QnBvQkh1ODRwbVFEcTMxZ3BsWjJJWlRqY2FpTjVpSWJi?=
 =?utf-8?B?aGFObFl2YThNYnhNOE5TcWNDbExVN1NFZlZoM3lhRnZyOXhienpLZFptd2N1?=
 =?utf-8?B?Mkt5UWdNaWtxNzB4bVFFSVdrTDNhczlaMnl6VUJud2daMXhWdkJJTlEyK1Vp?=
 =?utf-8?B?ODBPYVYzSUhZQlZBUVZpNFN6Z3R0VWhpTVZvRVpjRWRJNDNIdTRqb0lxeHcz?=
 =?utf-8?B?amwyTVNOTDVSZ2VWQlIrcHY3c0RoZjdSdEU0REdwRGJneWNPUlZ1cVBpOUVm?=
 =?utf-8?B?ZjJPK1BRQWFvQ2J6RDB6eUlPWTdjZVpWaXdKU2lDYWVXWE5yRHlGc2FDa2M5?=
 =?utf-8?B?MS9uV0JDMHlibWVORS9zWWwxdFhhSW96T1ZtVE54MEZ5d1NsOEZiVVpOWGl3?=
 =?utf-8?B?MnMyZ1B0aGY3UkM3dVJmSVhXZHpsRmdoZlp2RjluT1lYb1hkV3kyMUFrcDhO?=
 =?utf-8?B?NENjY0ljNWhWUC9ZRmxkeHhBdWdHNnc5QXhTQ1V6VVFmN2dWcWxyVG1NaUd5?=
 =?utf-8?B?aU5NOC9iK3dUZDZFYzA0MnUxNEVCa2JVamJQM01hYW5PVERXTG1xYjNzam0x?=
 =?utf-8?B?cWR1eEMyQ1JJcHlxQy92T0R1NlhGMmZiRjVGdjk2QnpKNFYxN1YwSVNqTk8v?=
 =?utf-8?B?R3M0dmJZelVWa0lHSC82WkJRZ21Mdm5MTjFoN0ZTT0htQjNiNkZ6RlV6cTM1?=
 =?utf-8?B?NFBkczR3T2tFZkpDcEo5NW54QXZWeHZsTmdjcEVqTVo3Y2JkWS8zeTBKaXkv?=
 =?utf-8?B?TjNENm5vbC9TZ2dwRjdGbHRnV0RLd1VCbk5Ob0QxQzdEaTVDcHdvMmZuclcr?=
 =?utf-8?B?VWs3YjRWdTBrZHZsQlFsbW9KYTlKa20rU3JJakVkSExWc1lOZjRzZVNxSnd2?=
 =?utf-8?B?UkpaZzMzL3QxVUZBTWJneFFkL0VTaG1DMVdPM2IrWHFVMjVHRWE0WloyU1RB?=
 =?utf-8?B?Z3N1bkZFd1FpYWR1ZVQralJpZDByNkUxZXdKL0lCZkVlaThhZ2twSjR4b3pw?=
 =?utf-8?B?R0lESk5rYXFjNXFXN1VzWm9qb2I3UnhUOExMRDc3N3VrWUNDOVJDekFMU2NM?=
 =?utf-8?B?SDFlYU5wVVVwaE13QTZBZ2NJVUw5MU5wcVpWNGY0alVpS3V0SnVnUjZjVGtk?=
 =?utf-8?B?N3FrOHVNajFJWUxIdXZVQWh4Sy9DM2J3aFQzVnpPNXNibkJTZ1kxeDZnNEpp?=
 =?utf-8?B?NDBVcDlLYVVqa3lmdVZrR09BZWpaL1NKK2dTNjNsWnVUT2I1UmJNRHRZQ0Zt?=
 =?utf-8?B?emRrQ0pyODZDUzlxYjdLZlh0dTVlemp2TjdiSmRlNkRodHZCdWx5T3Q4b3ov?=
 =?utf-8?B?czByYUp1KzYrV2RUdVNZeUprT0JqRGpzQXBpRFR4RjltbXZrWlNTQUhEUFNp?=
 =?utf-8?B?VkRpdDdqSllqenlTYlErMEcvYWwwQjgxUU9Jb1BkMFhrMU01WU5JSERqcStD?=
 =?utf-8?B?SFdRMFU0QXd2L2xxSzFoL2RZbXpBTXJFeW5nTldRNXFmUDM0bC9uNk5QTkpp?=
 =?utf-8?B?NGRXK09LQUpYR3g0cGxieWtneTYrbEltL3Z1WVliSjh6MW5uMzB1dmVwQnNC?=
 =?utf-8?B?TVhKS1BYRUJ2eTlrU1dIempFUnU0VWdud1ZHbUF3SHpHS2FBYVlDbllPdFRr?=
 =?utf-8?B?RWxsSkdvdHdSa1MrUTNDd3R6NW41WEJ5MFc2c2UwV1h5VHcxZXREdHhZWU85?=
 =?utf-8?B?MDRpckZ6TFRkajJvelVyc3hiSkk1QjlsY2NyejdqTE56RUV4Y0ZEWUlralpO?=
 =?utf-8?B?YjZEQ2pPTXFiWFFydXNUSmFaRkF5RTBiUU5WKzBINXJxeGlBSXd4VDMzRFVm?=
 =?utf-8?B?Z1FCc0UyRTM2aGhDcWFLRE1rVlVobmhEcERaUjdWMEc1dFp1L2lESTcvZyt6?=
 =?utf-8?Q?8Kx9nZj61GJ8P7F8RlJy4+mu4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eab8534-e3d7-49a3-9133-08dba3e9dc1d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5398.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:01:42.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZxFxj7yk4VRSZwbZwwojG9gsosK6V0NRZRaBleZ3wNSrcmmR25OEjBzhy2PqMkw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 23/08/2023 15:25, kernel test robot wrote:
> Hi Pieter,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Pieter-Jansen-van-Vuuren/sfc-introduce-ethernet-pedit-set-action-infrastructure/20230823-192051
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20230823111725.28090-6-pieter.jansen-van-vuuren%40amd.com
> patch subject: [PATCH net-next 5/6] sfc: introduce pedit add actions on the ipv4 ttl field
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230823/202308232244.jYYwKnlV-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230823/202308232244.jYYwKnlV-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308232244.jYYwKnlV-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/net/ethernet/sfc/tc.c:1073: warning: expecting prototype for efx_tc_mangle(). Prototype was for efx_tc_pedit_add() instead

Sorry, I messed up the kdoc while rebasing here. I will get this fixed in v2.

