Return-Path: <netdev+bounces-35764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C617AB02E
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 13:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 834FC2816D6
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2626B1DDE2;
	Fri, 22 Sep 2023 11:05:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF818B0C
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:05:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C576AC
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695380753; x=1726916753;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r081hEvSFfyisKi3PjwsiXWOnbs28j/WFV2KRAYN8M8=;
  b=VDL5NFGbEavT7B4yBa1munIEvUU6JR6qqN3cK0WnUNnEmEEGO0ssypH6
   7davgr+XvfuSSa8xKt+hINrbdPFnKrwfnlx6ouYhd2VxCss8eD/aKzae5
   LpmTwqrB1WNy7Y63HHnYy2p/e8LUNRttCvChOG7mCEnHOH9t8pgOEryng
   TCEvVeQMN5BKz3pxifYIdKQxTNFmGfBRCGgY1L7Ho6O0ZGDCIYGfOL0Lq
   xC+046zcpNbly0g4JjBamyc5mdEohCMfRz11bCxbdNxvekzuRyXAM1Yy4
   mmKkCb5F06Jiztwb2s5YytOVcuY5utfoDCfqPF3Sb6IBZ8bt+t1sibWXL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="411738935"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="411738935"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 04:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="817737810"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="817737810"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 04:05:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 04:05:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 04:05:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 04:05:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hhn9kfVE0/URFmtuC18Xio3d4Le3IA7TPT1ncB9KnF65Te9vMNon6evCgCpwZKQ9Ry0fj52IEzcPRIj8dZ2JuQTcMCW8g97CLaZip5WoOTKqtEdGNEnydXAHLEk1+nJNym/bEYIeKT19z2d5UYdBW4aZGIDoG3N+DF4GWzX2mg4la0S+ih9mkSjFfyzieOw/s3vwbejnqFIpzmNo2IiabKhPfjSkQrgNOuNGbqXZvqgpGzLO9Uk3RUODbEhgAI3IkT+Z47fOE+lcMXwG0rLNzFL1swSbqFqrK8vXnFB5kHKp5ozqMkF6d0BwctrP4Os/LC7X7exF9Cl+PNJvjhzbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/r2SZdXSqAAcIsBtaLk8QA1TXvXgdP9/5rG60xTTPZo=;
 b=Tmx8BvL7y5mAWuY2tYcmmp7mvjltE6KJtRmGs+qM4hz/hTRaBsDJRmIVM1J44EAwfiaRBsH1ur+jjYAzdCBxqx/GtGoeiSLV+6hCzd03VtY5DPW1ick9GDy5nZBck7FTgE0thyXGK0xry0simpSSYFr6IfL8KAsvhrpcvqJlBTcO13vAe6718C3MU4TJ2FGGU2y11xtmyNOd8g5W8RuOrT5npCTtv/kIevx92GAVvzaFdrCTppyxfheNu9bmFLTSVfCSypD7XDrX3rHUc3irT7H3uYYc5AAs4sPtpxkYn6whrYXYmO2A6zeAdaErWEFfZxQLLPrCi1rZUjfZkpSgxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SN7PR11MB7568.namprd11.prod.outlook.com (2603:10b6:806:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 22 Sep
 2023 11:05:50 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 11:05:50 +0000
Message-ID: <d8f4375a-b970-3902-b3c4-7da6e4965a39@intel.com>
Date: Fri, 22 Sep 2023 13:05:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 0/2] ethtool: Add link mode
 maps for forced speeds
Content-Language: en-US
To: Pawel Chmielewski <pawel.chmielewski@intel.com>, <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <aelior@marvell.com>, <manishc@marvell.com>,
	<intel-wired-lan@lists.osuosl.org>, <horms@kernel.org>
References: <20230921135140.1134153-1-pawel.chmielewski@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230921135140.1134153-1-pawel.chmielewski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SN7PR11MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ead76e0-0917-4e28-fc0f-08dbbb5be16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMx3jS6Wmdn6VPLOFMRXZnToESUCkHws9uLtmjwubzPKIK/BY5IcFf4Ep2Ehut7KGunV4SjeK5N28SePmQgTqYC7HYdlllfCshmi0m+ou4NHAH/ZOShldsNCH0S/J/Y+k+IsIkpry35qjrBffWkAEIZQTCH7m35u01Aa+NJk8q8RbEdLTt4P2W+yW9kaBTFywRuC1gVIhAdWl/Edo0d6ukossRdbe3vX8kAUmp5k4dKdoNZCXReXNhZowNjU0bNCXRsqcezZo/eYlF+pNT2zllr9bnAHYKU3IvnOmgG0d02JpVb6e6H2dCd9X11/xo3/DQwWmjRuo7snL8eY9pMk+CkaBbds0ENnwkAF655GL6LBMFDDHpRyo3IF75gRoD1KZsjx3KiczCZrz7niPDcvVuv/Q6TPUMHHIOh6X3PJPt8TD18jVDHpveur83hxeX2f434xgA72dOriIzFuX8PyibXzH9tYZ3mgkf+7D0NryXp+s+dNKdzPdhIT1O18W7MM2QQQ8118l1OwZAJrFYoD17s9y2F+oU1HZA7pRDgUZd8zeogPec/qUW89ta6J/WblsY/VB6KwoTadReSCPIZa1e31OZrb7ZDQae/A4I2Z+29fdkkINuYr4YAmj6DQPkHEbyGUSZiMK/cROdIgbT0B6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(186009)(1800799009)(451199024)(26005)(82960400001)(2616005)(8936002)(8676002)(4326008)(83380400001)(31696002)(2906002)(36756003)(53546011)(6506007)(86362001)(6486002)(478600001)(6512007)(966005)(6666004)(31686004)(5660300002)(66946007)(41300700001)(66556008)(38100700002)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFIvYTNTczc4NGZFSEc1VXJPS3dqTG5PQklnWXNtRkRHdGhQNjdPRUtzeENZ?=
 =?utf-8?B?VmxOZTVHdnlLTkxuSWFwa2xFMHFUOEFRNUFBTktUaVBJRkdLblZUWHJvbFF4?=
 =?utf-8?B?QzRuODc4dHcrYmk4aFNldW1ncVRqd2F1aEtVcEw2RzVEanY1SGljZUgxaGpW?=
 =?utf-8?B?ZGFTRE9LUjVTaTY4L21pdXZ6L1R1TXF2dDJjWmR3UGttT2kzdCsvdXN0Nm5M?=
 =?utf-8?B?Ykd0VFU4eGlWUnV1OE1TdG1LYVdMOUtLSTZvWjZPcG9RanpjUU9UMXhaMk5z?=
 =?utf-8?B?aXNJeGtBejFuQXptN2h2N1gwN2w4bFh2NGJVQ3NweHJQbWZIZ3N0cXpEMWl1?=
 =?utf-8?B?eGg0dE95QmQydGQ1a2V6SkRZbktMdXd6MFFkenNnL1RSZ25Kb0I0ZHRNNERy?=
 =?utf-8?B?eU9uaFlMZExEVXdUcE50bjg2WkczMXFiUkQxenJ4aXR5Y0wybHJ4dWcxL2xG?=
 =?utf-8?B?SDhxT1ZUU0wxTHJFRFV2QTloZVpkTWVwTDRhRkpEK1Q4QnVRbmprUmZGdlJj?=
 =?utf-8?B?RzZBb1FHY3lZRDBRRnN2S0RGWWduOUwvYlQ2bXFqV1B3dXdwOGo1ajNPang3?=
 =?utf-8?B?dFdNbkJGQmQ5cmlZSXNVRmd5b0dwQVVCQ1F0cDF1WWRBN1lCKzVnVGVRQXRh?=
 =?utf-8?B?SHZhU2lYZ2d5cWZvU3BtUGlabytxbFhYMS9KTHdaOGpZR1lQZkc2bzA0QzFO?=
 =?utf-8?B?MEcxQU5XdHA2QUwrNEJOK1hQT1dRcW05STBzZWFtVVpZVStCLzNiVUNGWVor?=
 =?utf-8?B?ejZkcmM4ZTh3U1J1VGJOTjhocUovRnFBYk9NVVNNaVhlV0NsUVgwd0Q4Vm1w?=
 =?utf-8?B?RngzZHBnazk5bTNtc2IzbE5qanBrOFFRSk1RZk5pc29qVnhvakE5aXpJM3hj?=
 =?utf-8?B?SHlHcGpHOFdNblRQNlcrT3I2R0ZKQ3J6RHdWRVlrRHBZSVBPYmNQOW5RZVhY?=
 =?utf-8?B?VUw3Yk9wdEFpV1lxbHNNUDQ3VmYrdDZRT2FxVUY3b01yMEFVM1RtNXkyUW5S?=
 =?utf-8?B?UWZiMmRFWlJXTy9lRWw2Nnc5citBcUxaKzYyL2pWWkZYRmsybE9IMll1Z3Ji?=
 =?utf-8?B?c3VvaWdQN29sMEhpMEZFeWJZcExZUVhOSlpBR1NucjUweGVaRnU2R09TNTE1?=
 =?utf-8?B?UG4xUjJNMmcyTTlGZ0dpZncyQ1JIbWlkVWVCc2ZZMEl1NGxFelBSeGtBODZ5?=
 =?utf-8?B?bUtFV1JwTDRmM3lOZnAza1RqRmxIcFZzSHhoYXpVNU5xQjUwTmRhczV0NHl2?=
 =?utf-8?B?Qnp5NXR0Znc0R2hJU1F1Y3BETjNDelVibG8xTEVnV0QxdXhUWWZHY3ZTOS8y?=
 =?utf-8?B?VjVHeENDMCtLRzRsNFlzMGF5Q2FXRGY2S256VXYwQkh3NU5UNVV2N0tEYTh3?=
 =?utf-8?B?RmxZeXM0VTFodVZ0SGdmSlljY1ZOeFRvSk5DWUR2L1RNT0FoZEFLNDhLMExT?=
 =?utf-8?B?N01aN1NINGVYSnBxSGZyNzhEK0VKZjE5NVZ2WkdscXNkL3ptZ0w3Z0MyUVQ4?=
 =?utf-8?B?WVdsdUxHc3RZaGhndGtTYzhqQ1oxRGgwWWNKOHBnanRha1cwSFVIemI2bEpJ?=
 =?utf-8?B?YVFmREtjWlJZMDNNSW9qc0FpOXhobkN2ZEVLS3hPU2VRQ1VhTGZrQUVLZTBF?=
 =?utf-8?B?bjQ5U0QrYTN5RzdEQURmdzM3a2xNWGI5NGFpeUlMSi9vU0QrTVRtRllsODA1?=
 =?utf-8?B?SitQWW1Zblc1QWVib29NbEo3eGZPbkp5OGZ5L3JlTWJCbUMraFAybkdtLzY5?=
 =?utf-8?B?ckNhZHdTYTQyVUlQaElFTmZtWE9pamF0OWFnaG5pRXlSc2FLN2dqaHhsYXBF?=
 =?utf-8?B?NHJmeGNBanAwV0xIejBocG1ubmlHaVVzZU1ZRklmZnlVZm9zdExGUHdxd1RX?=
 =?utf-8?B?Qy9SY25hODBSdCtKYis4c0JwdTc5YkJIclVIdzFJTDhJTGsxNmpKakdaMGtt?=
 =?utf-8?B?T2x2bWQxOW9kaVB4ZDlyS1luRGZPTjUwZ0IyUDhyaFhCNWRrQjlBNE5Tdnky?=
 =?utf-8?B?UTFIUFNXODBHNWtpVGxDYnlEcWQySUJyYWpLd29CNEdJNG9pUmpJM0JiMW0x?=
 =?utf-8?B?ay9DYlpHL0Q1eWExVkVpWUFPcitZTVdTUnpzWE5XTnY5WE1EYTRnUHQvdSsz?=
 =?utf-8?B?enNhaXV3cUdrUVpqYlBNZGJicnFuOHMyRTBKUXpaYWFRTG1lMEJkbkdObllZ?=
 =?utf-8?Q?+yKU5JUmvv8hloucWZSwchU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ead76e0-0917-4e28-fc0f-08dbbb5be16d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 11:05:50.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8KdtT8NJXwautP0CarWw0S5HUHcE6Pvu7vjAw3SpHzOb1HXZWM1LAJEtP1/YXCAyPcRslUgpOJGYvMGGvR2rB1Vvc5Qp9txQQGsCYYfWLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7568
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/21/23 15:51, Pawel Chmielewski wrote:
> The following patch set was initially a part of [1]. As the purpose of
> the original series was to add the support of the new hardware to the
> intel ice driver, the refactoring of advertised link modes mapping was
> extracted to a new set.
> The patch set adds a common mechanism for mapping Ethtool forced speeds
> with Ethtool supported link modes, which can be used in drivers code.
> 
> [1] https://lore.kernel.org/netdev/20230823180633.2450617-1-pawel.chmielewski@intel.com
> 
> Changelog:
> v1->v2:
> Fixed formatting, typo, moved declaration of iterator to loop line.
> 
> Paul Greenwalt (1):
>    ethtool: Add forced speed to supported link modes maps
> 
> Pawel Chmielewski (1):
>    ice: Refactor finding advertised link speed
> 
>   drivers/net/ethernet/intel/ice/ice.h          |   1 +
>   drivers/net/ethernet/intel/ice/ice_ethtool.c  | 201 ++++++++++++------
>   drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
>   .../net/ethernet/qlogic/qede/qede_ethtool.c   |  24 +--
>   include/linux/ethtool.h                       |  20 ++
>   net/ethtool/ioctl.c                           |  15 ++
>   6 files changed, 178 insertions(+), 85 deletions(-)
> 

Thanks,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

(one minor whitespace error found,
for me personally we could go with it)

