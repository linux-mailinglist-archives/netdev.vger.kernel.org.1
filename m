Return-Path: <netdev+bounces-59118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99736819617
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 02:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866CA1C25144
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 01:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A2217D8;
	Wed, 20 Dec 2023 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jfizFCKP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223E353B6
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duOJl4F5H9whZVDSTmLhrSC4SNhV2mWUCpqW093TV6sjXObWIXWRmPk94haZzhGIGU2gFXop9/JKZmOdlBGWtaT5c8GS+MGLRFMSuDLu4KqUJiF4CtQ9XxtNqM4ZDbEDIidoJh1aBM3epuV2N8slMlB8UYenPJC0CkHHHoLNOKEycx4uXybun07d2JfNVKEiXaw5sExe8Hc37glUUKN1EzMtNrw3o6hUc09+Vrf4YNZB+qCsThZCj+p+j9/phIEDyJOiZJiQNb0891Q8nxURUoolPWiBDhovnYvNh/Bf9UI30D7ALWk+9kX73nQ1AffTXV4ptN3WGncyF0dy4Z0eeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpAa88YriMOaczWJYGQSgN8AHt3yG+zH//HrjSGimHY=;
 b=b+q+wwK5L+RuqmNI19QSIsfuhjnoFTyjoYr08GCzCBPGR1/46lalHu7W665c8sVMrkA4sNXAoHhd8p8QCxe4gAT0viUBEt8ZjA/fBWOTuFm2Dbd++YTmV1VYM9Dtn70GmFyCcP0YEBzYXKebpzA6HnKWfiGDlZiGEi1Th+644FUz+mJvOn/FK5i+wZioMLvqKs+XcFz+wCWS6VAgn6cTNTexdXPhYGA2UQN9ZQMAwz6mcDR34dt1FlIbpo3tzMlD9hN9aO2U65N11uQ7/9Ok7ng6Lx4G4xTb1ftc66jbXqf/TcJYz9um1CwU2MtJJ7W3eWf1z6/t2GL65tcN756dGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpAa88YriMOaczWJYGQSgN8AHt3yG+zH//HrjSGimHY=;
 b=jfizFCKPP8Acib1bcQv5xqeBIBe2nFXQxEI0GLCvC34QAt2sKR6OGuxvnWqylqeu3+o0QGjbX8cFRel49yNQ6i1dMD4l+3dT1OY20UsGMSwvVDd7KrFJoq1fA0L2Uc+PtfHOuY+S2cNO7lTKQ6mqJC6MxVb2TmCbwoQDCHRlMG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 01:10:55 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.7091.028; Wed, 20 Dec 2023
 01:10:55 +0000
Message-ID: <e45bb504-df59-4f6b-af0f-da7d27ba9ed0@amd.com>
Date: Tue, 19 Dec 2023 17:10:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15][pull request] intel: use bitfield
 operations
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Cc: jesse.brandeburg@intel.com
References: <20231218194833.3397815-1-anthony.l.nguyen@intel.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20231218194833.3397815-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:510:23c::27) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 7456dfb6-282e-40dd-6fdd-08dc00f8848a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	saxOWgcEtI/tbCFjYOuUUP+3y0A7ehDw33+aXQ26DR5qDSNBYnpYIv7hIS5ZgzHkorm0G7Ev2W/Ots0WmNDNJm1CJZcesZuvqAS0awTe+te3AOsX+KZSc7V5kVU4sRPETPAVHIFCs4n1IjBosurlJPb0W6NlS3WpSX/AAKDROvpLEQIVTwKgw04cFn/esdDKI+zEs2ZT4OPHIoSwn6z8Aurx2x9liOBbVeauk+aVixmfi5dz/L9YNRzESG9bjRX8vdg8y8IZPDt+fUK75jkYm5sfxHERGf2rB/whmWrGdEgdQ3sbzvI5biE3VdFyPDwwImFQBUPJhJV6dZMwSJyhv6MeQf5fTM/LnulBJkC3bvH02FwnqoZ35fNFm4m1k3eUlVKML2ckPN+ET0Rjxl2b+hteQpqFJWYmhhbwV/VTefJdxxhWGBQbdchKq8GvCuGrNUa7OOiLIKBu8US46HIdrs3D6pSQMWcLH9lMtnC27Kf25Ps0UqCzxoLPbjMoZ9acp6T4V7P2taFZ4SXWYxbxRmJ5ECiwoqPMkZg/V/AlrMTprVJRRD7ur4WtMArjIWghhZfNltUE1R8jPUeMtHpo/sD6+gm64XFbyJGCcI9fAuF3TB/14gPegR1omK83hucobxsISP0gf3nN3Emix4IQJgeXP13P40SGWOkMz2zHq1U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(31686004)(6512007)(66476007)(31696002)(4326008)(66946007)(66556008)(316002)(53546011)(6486002)(83380400001)(86362001)(2906002)(8936002)(8676002)(6506007)(478600001)(2616005)(26005)(5660300002)(36756003)(41300700001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGRIUlJSWjNxWWlsVTQ0cjYrVUR4RzdHR1ozQ1hJSmZjUDI2ZUhCVmtCODdC?=
 =?utf-8?B?dFB0WVFjMWJhRGUwclF6d2dOUGhaQURNLzJDMmg3aDlPTkl6QUlyQXpTQjdP?=
 =?utf-8?B?WjJGZUxxZkFTU3g4RFhTWUF6bUdOWGVraHZNTE9RaXJFc2g2dXdYKy9WRmlP?=
 =?utf-8?B?V0ZyQ210RkcwZnhZbnp2Skx5OFkvN3VlTlY2K3BGWi92dzZsdjZzMmkxaTJ6?=
 =?utf-8?B?NUo0dXEwS25qb2taZ3czcVFOZ1paK3lVUkt3S09jTXJTSXVhZjR0ZEpEenpu?=
 =?utf-8?B?ZUdnN0tOOWpxZEM4aHo1RGNkQkMyaXEwWitGaVBsOGdGMExlMHd5QnF3MXd0?=
 =?utf-8?B?NGg4UnBVa2pWbEtCMWR3S29Ob0RVUS94TjJXZDJFcFVTdkZEQzhJdHB3ZDlS?=
 =?utf-8?B?bWNlakxieHhaTjNudUtJNjJnaFlsQnJmcmJNUThKbG9seUJIRWhPVCtyTWFL?=
 =?utf-8?B?MlVEZkxOMGRIRWRqZU5uaEdjOVp6V1B1VEpLMlNBMDFjUUQyRnJUbTdSMEto?=
 =?utf-8?B?and1akFkR3JyMDRFNkRFWUZzT0Q2QXBFTVI5NG5rSnhpeWpkeFp3cHlMOGY4?=
 =?utf-8?B?VlhQeUNhNTEzRXBvQVpzQXF6SnNaTFhCc2NvSmszdkJVc3h5Y3hteGdHVGg1?=
 =?utf-8?B?R2QvTUQvMEx3emVvRFN1ZHlmQmtuVTRmckFYYTVuTHRDMlV5d1FlTWFUaTJD?=
 =?utf-8?B?cjN3dmZGdHErOEtOQlArTXk1RG1yaXJFN2U2MzdDQS9kOUp4OG5BcHMxY0Rq?=
 =?utf-8?B?QkhyVHdFeklQUldRbjR3V1pkUTJiQWgvSjVOYTl4QVBWWDh4WHJJVU5SbUhz?=
 =?utf-8?B?ZHNSbHpvVmRGeW9JeGs4YlFyNG1JbDNSSTJzTlUxQVBTenA0L0xjS3Q5OThB?=
 =?utf-8?B?Wk9TS2tnKzJRNDFrTUFZdzN2UUtjTGFLaGpjMDFRTkt5L3BmTXNyQmdwLzNU?=
 =?utf-8?B?ZVRmQU83aWIzYkRRcXM3Nk5tVG5BbFdDYjZPbFlhdVJ1VzVscjEwc28yOGVE?=
 =?utf-8?B?NysxQnVjSWV0WjViNUxOL3hrY3haVXJQTnVpQkdXV2xMRW1UWEI0bjZFa1Vp?=
 =?utf-8?B?UnR6Vzg2YkFlZUU4bVNCYkRhM0V1UVk2QW9oT1A4VGVIMXdzNzRENy9qQjhh?=
 =?utf-8?B?ZEptbUdSR0ZIKzdac1FPSUNaME1iam01Mmc0QndiRWV2bWFVMFUvSGFqVTkw?=
 =?utf-8?B?Z3UrMkhMdThhaUdPWFZ6UlBLYnh5ZTF1RHVoQ0pxN0FackQ2Zk1Ob1BtMDdN?=
 =?utf-8?B?eGNMbHkzbExPci9HVkQ5OXlwZWVDVmNrSE1KRklhb1dUY1FYbXFLSUJmL0FO?=
 =?utf-8?B?RkhHY3NJMjFGZjFNRncwWHR6QitFdE94QXFLcWZOVGRWYlMycCtWR2p0d2xt?=
 =?utf-8?B?UGVyQzgvOGVwMkp4NENHWjdnS0hqdmpoeGJPRjcyUHg0Qllxc3drT0lqeHk0?=
 =?utf-8?B?VFY1dEhPek1VeHdaUmZ5bmlnWGc5d2pRQ3RwTU5PVlpQL0djaTg3aEwwQTJB?=
 =?utf-8?B?cENnNFBuaEx2aWFHa3crV25CdlFBT1VhSnZQTmVRMjNvaHc5VWNRbzBBZVNk?=
 =?utf-8?B?bVB5VS9sYzlITVhvV1Vpd1VibHN6RVlkMVcxaWhRVnhPUHJYWEFwblIvTm5Y?=
 =?utf-8?B?MXJXck1TaG9zalZCUzRKdC82ZEhZeWpPQkFwU1dsaXpOR1VBUVQyTG9EZTY2?=
 =?utf-8?B?NENwZEErRkhTdFJGd1ByZ1NETk9JMDBTT2k0bmtyMmh6emNyZ1hKK2ZNdGN0?=
 =?utf-8?B?MEpqKzNhWkdPVjNNbXJlQ1kzNWhjQ3pNaUYvZTc2SjFlSXlOZ3ZWWlAyTTVm?=
 =?utf-8?B?bHl1bGg3Wmx6SG91b0lIQUhKS0ZxaCs5QTRLd1RIWFFqRy9tMld4T1VDZFFV?=
 =?utf-8?B?VmM0ZkprWnUzQjFlR2RYTDM2R0FodnZEZ3oyOGpWZWJSSDd4TFNndHI1azFI?=
 =?utf-8?B?bHlNT01leTE4OGVqbDNoaGtoMGVkdEtIU01mK3VYUmlqWU1WZDBWcGtkQTFP?=
 =?utf-8?B?WnpWOU5YYnAzL296TnF4MTU0Q3NHWWZBSTF3RDZvcU1FTkhpcml4YmZrYmd0?=
 =?utf-8?B?QlhjT3FmbmgvSW12MDNYT0NkS0lvcFdieFhraUhCNVBOVEdmN1BUTkFhakJ6?=
 =?utf-8?Q?sRoK/TrSEyvEGQ/Sxfo61i8To?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7456dfb6-282e-40dd-6fdd-08dc00f8848a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 01:10:55.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3Gaup1m7rDNZ+21q54IoxUXtb1waoU+pZJjYP5pQ14JKk0IaG44nFVv1exicqsxSIVH8gpMFR+1z5l3gi5MhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013

On 12/18/2023 11:48 AM, Tony Nguyen wrote:
> 
> Jesse Brandeburg says:
> 
> After repeatedly getting review comments on new patches, and sporadic
> patches to fix parts of our drivers, we should just convert the Intel code
> to use FIELD_PREP() and FIELD_GET().  It's then "common" in the code and
> hopefully future change-sets will see the context and do-the-right-thing.
> 
> This conversion was done with a coccinelle script which is mentioned in the
> commit messages. Generally there were only a couple conversions that were
> "undone" after the automatic changes because they tried to convert a
> non-contiguous mask.
> 
> Patch 1 is required at the beginning of this series to fix a "forever"
> issue in the e1000e driver that fails the compilation test after conversion
> because the shift / mask was out of range.
> 
> The second patch just adds all the new #includes in one go.
> 
> The patch titled: "ice: fix pre-shifted bit usage" is needed to allow the
> use of the FIELD_* macros and fix up the unexpected "shifts included"
> defines found while creating this series.
> 
> The rest are the conversion to use FIELD_PREP()/FIELD_GET(), and the
> occasional leXX_{get,set,encode}_bits() call, as suggested by Alex.
> 
> The following are changes since commit 610a689d2a57af3e21993cb6d8c3e5f839a8c89e:
>    Merge branch 'rtnl-rcu'
> and are available in the git repository at:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE


Thanks for doing these - this certainly makes it significantly less mind 
numbing to read all those bitfield things.

Is there any plan to remove all those xxx_S and xxx_SHIFT defines now? 
I expect not, but I thought I'd ask.

A couple little things I saw, not really worth messing with at this point:
  - 04/15: unnecessary {} {} on an if block in i40e_mdio_if_number_selection
  - 09/15: unnecessary line removal in 09/15
  - 13/15: ice_get_dcbx_status you could have put the rd32() in the new 
FIELD_GET() and dropped the ‘reg’ variable, as was done in some other 
instances earlier

Otherwise, for the series:

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>



> 
> Jesse Brandeburg (15):
>    e1000e: make lost bits explicit
>    intel: add bit macro includes where needed
>    intel: legacy: field prep conversion
>    i40e: field prep conversion
>    iavf: field prep conversion
>    ice: field prep conversion
>    ice: fix pre-shifted bit usage
>    igc: field prep conversion
>    intel: legacy: field get conversion
>    igc: field get conversion
>    i40e: field get conversion
>    iavf: field get conversion
>    ice: field get conversion
>    ice: cleanup inconsistent code
>    idpf: refactor some missing field get/prep conversions
> 
>   drivers/net/ethernet/intel/e1000/e1000_hw.c   |  46 ++-
>   .../net/ethernet/intel/e1000e/80003es2lan.c   |  23 +-
>   drivers/net/ethernet/intel/e1000e/82571.c     |   3 +-
>   drivers/net/ethernet/intel/e1000e/ethtool.c   |   7 +-
>   drivers/net/ethernet/intel/e1000e/ich8lan.c   |  18 +-
>   drivers/net/ethernet/intel/e1000e/mac.c       |   2 +-
>   drivers/net/ethernet/intel/e1000e/netdev.c    |  11 +-
>   drivers/net/ethernet/intel/e1000e/phy.c       |  24 +-
>   drivers/net/ethernet/intel/fm10k/fm10k_pf.c   |   7 +-
>   drivers/net/ethernet/intel/fm10k/fm10k_vf.c   |  10 +-
>   drivers/net/ethernet/intel/i40e/i40e_common.c | 140 ++++-----
>   drivers/net/ethernet/intel/i40e/i40e_dcb.c    | 276 +++++++-----------
>   drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |   3 +-
>   drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   4 +-
>   .../net/ethernet/intel/i40e/i40e_ethtool.c    |   7 +-
>   drivers/net/ethernet/intel/i40e/i40e_main.c   |  85 +++---
>   drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  14 +-
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   4 +-
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  70 ++---
>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  29 +-
>   drivers/net/ethernet/intel/i40e/i40e_xsk.c    |   3 +-
>   drivers/net/ethernet/intel/iavf/iavf_common.c |  34 +--
>   .../net/ethernet/intel/iavf/iavf_ethtool.c    |   8 +-
>   drivers/net/ethernet/intel/iavf/iavf_fdir.c   |   3 +-
>   drivers/net/ethernet/intel/iavf/iavf_txrx.c   |  21 +-
>   .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  10 +-
>   drivers/net/ethernet/intel/ice/ice_base.c     |  32 +-
>   drivers/net/ethernet/intel/ice/ice_common.c   |  54 ++--
>   drivers/net/ethernet/intel/ice/ice_dcb.c      |  79 ++---
>   drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
>   drivers/net/ethernet/intel/ice/ice_dcb_nl.c   |   2 +-
>   drivers/net/ethernet/intel/ice/ice_eswitch.c  |   4 +-
>   .../net/ethernet/intel/ice/ice_ethtool_fdir.c |   3 +-
>   drivers/net/ethernet/intel/ice/ice_fdir.c     |  69 ++---
>   .../net/ethernet/intel/ice/ice_flex_pipe.c    |   8 +-
>   drivers/net/ethernet/intel/ice/ice_lag.c      |   7 +-
>   drivers/net/ethernet/intel/ice/ice_lib.c      |  54 ++--
>   drivers/net/ethernet/intel/ice/ice_main.c     |  48 ++-
>   drivers/net/ethernet/intel/ice/ice_nvm.c      |  15 +-
>   drivers/net/ethernet/intel/ice/ice_ptp.c      |  13 +-
>   drivers/net/ethernet/intel/ice/ice_sched.c    |   3 +-
>   drivers/net/ethernet/intel/ice/ice_sriov.c    |  41 +--
>   drivers/net/ethernet/intel/ice/ice_switch.c   |  75 +++--
>   drivers/net/ethernet/intel/ice/ice_txrx.c     |   6 +-
>   drivers/net/ethernet/intel/ice/ice_virtchnl.c |   2 +-
>   .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  13 +-
>   .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c |  41 +--
>   .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   7 +-
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  58 ++--
>   drivers/net/ethernet/intel/igb/e1000_82575.c  |  29 +-
>   drivers/net/ethernet/intel/igb/e1000_i210.c   |  19 +-
>   drivers/net/ethernet/intel/igb/e1000_mac.c    |   2 +-
>   drivers/net/ethernet/intel/igb/e1000_nvm.c    |  18 +-
>   drivers/net/ethernet/intel/igb/e1000_phy.c    |  17 +-
>   drivers/net/ethernet/intel/igb/igb_ethtool.c  |  11 +-
>   drivers/net/ethernet/intel/igb/igb_main.c     |  13 +-
>   drivers/net/ethernet/intel/igbvf/mbx.c        |   1 +
>   drivers/net/ethernet/intel/igbvf/netdev.c     |  33 +--
>   drivers/net/ethernet/intel/igc/igc_base.c     |   6 +-
>   drivers/net/ethernet/intel/igc/igc_i225.c     |   6 +-
>   drivers/net/ethernet/intel/igc/igc_main.c     |  10 +-
>   drivers/net/ethernet/intel/igc/igc_phy.c      |   5 +-
>   .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |   2 +-
>   .../net/ethernet/intel/ixgbe/ixgbe_common.c   |  30 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |   4 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |   8 +-
>   .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   8 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   8 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |  19 +-
>   include/linux/avf/virtchnl.h                  |   1 +
>   71 files changed, 734 insertions(+), 1016 deletions(-)
> 
> --
> 2.41.0
> 
> 

