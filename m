Return-Path: <netdev+bounces-106903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 714A1918085
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1F9B25238
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3C5180A7B;
	Wed, 26 Jun 2024 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIgJ4TxI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511D180A80
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403529; cv=fail; b=Y7ZkBuSa0ovMHKTU++F/SYrBejvpue/+z0BdQW82emxcE25Pbs4eMexxu2H+oS+FSlvznUCo0W7QuHamBpyV8eHn55AjHmgWwSk52pqGb+n5Zqkipb5Gvy9oKvQfnk61BDOW8519bJ6PQ/YU6Rd+y7SuMqW/oCH+mdpYKBu16cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403529; c=relaxed/simple;
	bh=MMqh7A4Jx3fZkZAyuBSFP21LHTZpvZ9TXC4qsAyerVU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OcrqeVaU1ISJUW4wznirSlYDKLaT6nwU4ufs/kbFBEkqRqAlTO1JotGXg0cuIZN5TxuIsqiK2mOUs5pNSjyY3urnn8cKxWpWXaO5zUlA/A/MAvY2Cv5I6mDRr2K8rpOjq0irqr1B7xWfTLnfEJ2qEYfiDPsLuqepCuu1DHOJ0qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIgJ4TxI; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719403527; x=1750939527;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MMqh7A4Jx3fZkZAyuBSFP21LHTZpvZ9TXC4qsAyerVU=;
  b=jIgJ4TxI8NfHDTFVCQsHU+9/BOEqN/NlXACihTyUJ2nfiGOZay9QGk3t
   rvPp+4YGjrBs+mXJrg0C64q0TTa1IpleBg5+5uCIiCs0z5zrzybPgk6Ay
   ohX3OJTkD4hA6Kg8q0h1RQsoI8rdOwzwCb3t1Nz1+38lYCXKFtNqm5WTS
   HeXw1uxj8RZZBl1Mj8F32xwGTAbLpQzN9uAzsQdmzx+cgYvTW+g/LrEdT
   cMs4V1CfFJpbGnN9kgfig1L6JODcWkiLiegPr2yIGN7p7Hn+apLI2DbIp
   lBq/lv5Pes0f1VZMRWrX+n+xfQ3NYjkzryFCA0D+x68FO1yG19o58GjeJ
   g==;
X-CSE-ConnectionGUID: KtTkJK3sQ1qt8WW4OIQlfg==
X-CSE-MsgGUID: AZphDDrdRfShzoY+pH/TXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20285643"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="20285643"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 05:05:18 -0700
X-CSE-ConnectionGUID: JmE8mGhEQQyvRNn8WLm/Rg==
X-CSE-MsgGUID: +k9GLtleQxmlnqUl+Mzhmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44632651"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 05:05:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 05:05:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 05:05:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 05:05:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 05:05:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaZsbYx7VXieJVTMWMqx4CsMlHvYkiot+Z81/4Yj/jFB78+JQpTZ28wbvAlQsKfiR621HQ7A//05CO29E4dGHSyyqBFgD+YWqIPBuwQ2QhUTS1J4eIt4p4dXlcm0H7UmlGTSefN4XMoC9k2LaZQHcKHewD1R/BH3/GdyXvcf6Asm04WwKvxSIGLfY4q/p/lVX3UsD9ePHCF6viDDeyJjPyqsjeKRI/0lq1eSMqFuQxCMYcp2nG23hkM0c4U7XEcvx2ECK2OMUwDM1NeIxrcDDB1COVXT5nm03GVLjJcuIs4kYiYmLk0OjgFpjWT/Z92sO2qLjqx7HutjyAIhKgf2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe8+YMAjoAP1OGbvg4cKrLZLH0SRFG7mXJvawpeIq+Q=;
 b=l7DqI0O/jYDIxR/f5kMspMTXEgrlQavPGN0ODdts1+N39E0OUfgK3pNTwa9cp60q3qK+H6yXxOOU92FS4oqOpdeZR63PCefY2xPdoQJ12S02FZenE4A2j3Fepb7sUXpibhTEAtIIT0n2y0/rQramzV8aKg4/dy8eEr7URd47Ujs+rsCZoc8u2kHvXc8w2v0gII1MjPgP6/96iWw1U6NudNZiYkDTYgj3udecrynYC0jARNPMZlnQQZBgAKxRUZyKkbyOA+xh0WO1sX0Fz6awZxKvbdOW4bI4anxQk/U1FiXSKS3CyH3UpDP3Zct+8jmzXraf7+u9w9SeupBwA9Fufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA1PR11MB7855.namprd11.prod.outlook.com (2603:10b6:208:3f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 12:05:06 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 12:05:06 +0000
Message-ID: <beb21f5d-1999-471a-be63-b469f0dde96d@intel.com>
Date: Wed, 26 Jun 2024 14:05:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v1 2/4] ice: Add ice_get_ctrl_ptp() wrapper to
 simplify the code
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>, "Michal
 Schmidt" <mschmidt@redhat.com>
References: <20240626100307.64365-1-sergey.temerkhanov@intel.com>
 <20240626100307.64365-3-sergey.temerkhanov@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240626100307.64365-3-sergey.temerkhanov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA1PR11MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 937e6903-ec47-40fd-4b0b-08dc95d837e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXA3Y0Vmb0l3RTk5WkswMW54VjJmdXFkMXdvMkx1Sjhvd2JYRGdXYS9vdTlV?=
 =?utf-8?B?UTBpWGxaaENOYXo2OUxudGcvYkR5emdKdmVmSklJZkIvSnVDRkNZV1hwVnFp?=
 =?utf-8?B?dCtHanQxeVZXV1JuSkkxUXUwYVQ1UGNyTkR6eG8zWGNvb2FvYldHQlRrUWZD?=
 =?utf-8?B?VEkzMVorU0w3cENsc1BYa3c2MFZEc2FnRThqc0FlR3dOOGpxdVFuMDdBbnpC?=
 =?utf-8?B?NlNEVDZEWE1Wdnd6Szh3K2Q5Q2pMa2llendnZGo5RUtjS0gxSmFWU3N4SjM2?=
 =?utf-8?B?OU1aTzhvT1Nod3poSmhLSUVnaHRRTU5aZWhiUlpLNXdYVWxhM0tVaXVnR2Y1?=
 =?utf-8?B?UnhjNHRhL2pBRStkbmJKU2l6RjN1ZkdKY0thV2crWXUxRVJBTGN5WE80MWwr?=
 =?utf-8?B?VkF2REJ5UHl3NjJITW9nSEJMUUlLL21SeFlHQ3ZJMTNKNTVpU053SkdSZnIv?=
 =?utf-8?B?RiszK1ZURHczSDM2eG5JRTVUUmw1dXdSODBIa3R6a05DQ0h5OUhnRVhCMXp4?=
 =?utf-8?B?S1p1VFhxOXErYWZmRE5MdFpZcU52TXorRzhMVlFLd2piM1EzcGNIWFg4c3hw?=
 =?utf-8?B?ek9FbWFHcExZbmZuaUJIajVDbDFXeUFlK0NPUFVNV0MvMmZUdngxdFMrdkxj?=
 =?utf-8?B?UHZZNFc0a2oyNGRmRnBBZWhGTkwzVmVpV29TTWhIeFd6MUZqQ2FDQjdKeTAw?=
 =?utf-8?B?NnlNZ2lXdVN5dmJyMDBSNmE1akRsK3k5OC9PSzExOHRSVUlTbCtESWFxajVn?=
 =?utf-8?B?TE51djlRWGVoWUhkZUMvZmozK0xDVlRMV1VwT2k5UnRzTTBlZEpsdmR0MUJh?=
 =?utf-8?B?dkdNZzZXTzVSenJYamkzdU5tOFowbDhmNEhuTFZaejBTaW1JWENSZTFqVGdI?=
 =?utf-8?B?ajFXeTZLaXoyYWRyRjhuaGZhYzhtSnNjbXlyQ0FxczJ3STU4VzNFV2dQUnFR?=
 =?utf-8?B?QUNTMjAwZHcvNTZNV0FvT2F1MlY3UGxoclFtMlQ3bnBSU2xVNHF0WWlrQTBw?=
 =?utf-8?B?cEtkWk93WXI2Y0FBenVBQ3J1azMxNFQ2RnAwWnBiSG1GTWZySXBrTzRqVHo3?=
 =?utf-8?B?SUZYSnhONjJKR2RCUUpYOExKQXNRTGxFcW04UFljSHE5cWJyWVJUVGF0U0RU?=
 =?utf-8?B?VmM2NVNZSXlLNU1CeUVKT2tQVXgxdjUvWnpnSnA5ODVRRkVtUHowa1I4SERB?=
 =?utf-8?B?WmM1Y0VjNzBRcDhMS25SRWJPbE5STi9Vc1hzVllUWE5iQ0hiL3lQOFJIUkEx?=
 =?utf-8?B?QmFBa2V6bEQveWYyUnk3eERqc2NVa1NLbU9XT1pRVDRLSFVEV01WbE1aYVVS?=
 =?utf-8?B?amVVTWVuOW8yVWs3QW1WMkZ3alhlb1VRR1NMNGdHMjBKV1pRS0c5NVRKU1Z5?=
 =?utf-8?B?ZGR1RWliSEh1R2prT3RablZjSWt2ZTBaNWZ3TlZJbDc2aDd0THRRMGJVcWdq?=
 =?utf-8?B?NVhKS1ExTWdxZDlxSDB0QWtnOVB1c2lVYUdpTFk0VTJLaHlldnJCSjg1VEM2?=
 =?utf-8?B?eENFakE3UGhCc2VwZXNpVzEvS1ZoUE1RL0NBZWVLNm1qT3FXZjF1aWpjY2o3?=
 =?utf-8?B?UDFSTnBiaVFtb3N3cnI4cXlpcUhOUXhrdU1FQ0UvcytFWE1KaFd5QTZTRWo3?=
 =?utf-8?B?UldYWE90L2ZkcmdFa2tQK2l4a1lLTDRobzdzamI1Q09va3BVYkwvaklBdmxu?=
 =?utf-8?B?S2grVFRxMU1oWDJCaTIyWUhZKzdnNk5QLzlRbWsyaE5jZEVCSGpqbWF0VFNl?=
 =?utf-8?Q?igvcloOxO4c8+HgEVE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVlJN1ZBd3BrK3lLQWY3eGdWZnJ4bTVlVjc5eTZuYTl2RG4yQlhwVDhHMjZS?=
 =?utf-8?B?OGRQZFlHOER4ekZmdEcrQm85VGV6dzFTaGlxYzhXTk1XZlVUWmV6UytTdHFx?=
 =?utf-8?B?Y3h3UXZmbldaeGM1Mkp5a0dETEFoYklCM0dTYVl5RVJkcWwwS1RKbVZoVFor?=
 =?utf-8?B?N3ljeHRLeEY5N0lUT2JCYTB0S05kNVFDVGc4TGdHbGVrRURwWkREMGYzS3JZ?=
 =?utf-8?B?a2IxNjZ2azdzdnBRUXNxT2hvUUdMM0VKUlRmeDZHQitSaFlWZnRCMDJUTEZ2?=
 =?utf-8?B?ME9xdno0OXA5bkU2Q3YraWlydk1TeUFjb25DcURLQkF2NUpVa1BMMnYweWpp?=
 =?utf-8?B?OU5YeW5aVk9zSHpOMFRsTFdVYWNYa0RIL1RRT0kzMTJ6YXMzcnNQT25tRXVQ?=
 =?utf-8?B?TFg1ZmQ3OHVPRng3Smp6M1VBUlhuMGNuM3FWRGM5T1ArMnpoclljVnZjM3NW?=
 =?utf-8?B?R3l2bnJzTWJCcnNFS21sQWlMb0JJZCtYZVFXb3BwSEVxd1hEL3BYN292aTdX?=
 =?utf-8?B?QUt6VEZlOG1qY3ExSkFDRmh6bFFNSkY5RkFndTFPNzZmRlR0M3JObklicVQv?=
 =?utf-8?B?TVl6ei9mdFNCeUc0aEptUmR5ckMxRnVZNXc0d1NrN1FtVlpha0FGTDVtKzN5?=
 =?utf-8?B?SUc2VkEyamNIVzRhZzRoWHJzODRQeEhNVW4wai9RVXphNzlxdjZpYjIwVEpq?=
 =?utf-8?B?anVyWVZDOXNCNGlmY2FocWF0dzdTY2xBTzBLZWFSV0szOUZ3SWo4elpva0RF?=
 =?utf-8?B?alUyWjJxZ1A2Rjg1dzZXUXIzUG12Rm42M2pEenNZVWQ4RVUzME5tY21YNzB4?=
 =?utf-8?B?YUwzV2UvdGRia1RMQ2ZheXRYNmhlOHNDanJlQ2ZQNW84YThyT3poZzdRdFl1?=
 =?utf-8?B?cnc3Q3ZaZmtpQ3F4KytMS2pLcnhIbUMzTXUxVjRjZVh4cnNXV0V0ajR5ZUFH?=
 =?utf-8?B?aEFvSFgwWXdrVThjS0tESmdIZlNIdmQyZVJmSWdnZG1oeGVUOHF3cnNqRXQz?=
 =?utf-8?B?L0pZanIzS3NvN1JaY2FQY2dWcVZrM0N0RzJRbFltRCtsSWxCQ3VSaTdLcmMy?=
 =?utf-8?B?RVoyVHVPUTJVVndVWDhQbysrL01jenBsdG40SEs5WGxxR2daUWRjbVcyK0FB?=
 =?utf-8?B?RVl5Y253cVpITGNQWEJGVVF6ZlRaRWNXMEh6VTBsaU5xNk5ON0x4b3M3Mi95?=
 =?utf-8?B?NldBT3Z5OVJnWXFnTVB3YWZwYW92U3NZcVJrVzB6OFJaVDNBYlNwRTIrNFJ2?=
 =?utf-8?B?T25RbjZkNkhON0JBMS8zTEppL3pSQkV4Zll1bktaNFVBeXhWMUc3ZGJFWk9H?=
 =?utf-8?B?MVcyRFlJSDVQb25MSTBMMVd6Q01tYnpaYkN0OWgzYmVLZi9FeHhUTEplU05O?=
 =?utf-8?B?QXJaNjg5dlZhSWQzcEwrOGZyNXpoaTlxL3hsVnd1ZHBqQUpXZ2tJc2d0VTlu?=
 =?utf-8?B?UFBrWmtndUNnajdHUXJDeEJLQUJ0ai9HSFVublByYUZrRVRac0h0YXU2WldW?=
 =?utf-8?B?QVgxdzRkSEFCWjB6NTg2Y1BROW5HL0RNUE9YZGdNWVllS2pSa2ptekdnbkpO?=
 =?utf-8?B?aXJmTHJxZndpZVVsZW9OVkpKQ3l4OWZXclNvbW9uaHdjby82SkwrUkgvb3gw?=
 =?utf-8?B?UnFRSXdleTRFL1U4akU3RmhJYXVBVVZjMWlxRnFMdzFpMzg5L2h6RHpoQlo5?=
 =?utf-8?B?dWwwbk5JM2YwMEJxYXZxUTdmYndvZmxGZ2dpbEUxWDJ5Z1k2blNiQnVNMzAv?=
 =?utf-8?B?NW1MVFVIUG55Q0FXZ0JsRGYrUTBiVStxcXNaWVdjMzNFRm8vc1ZjNTVCcTI0?=
 =?utf-8?B?VEcvOXhpL2JaRW96bTBsRTVBdms5YWpBeUpXWlM5RncvTERGejNBUm9vZlBh?=
 =?utf-8?B?bmV5M0VSSG01VVpqK1N1VmdmRk12cjluSUVvUWhJa2FnYmxkUzVMUkpNdks0?=
 =?utf-8?B?akJleVd6cjVFRTFyZnFSbXg0cDZsemxPZVpoaVd0S0tUa0RrR2N0TGFvaWwr?=
 =?utf-8?B?bmVzT1BUYU8xUjVOMVJmRG5QNHFUbWpIZ0FKSUxTa2NhcG5lRktuTWV5bWpD?=
 =?utf-8?B?S3B4V0RZeDlPUVcyY2U5UkZscHlpd1I0ZVhKL2gxV1pYL2s2L3diY0owTXpv?=
 =?utf-8?B?NzdqeC8wR0Fxa3VtTStOYlk5L3l5RFF0eklPV2RwV1E1MXNHNDRuMC9HYitL?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 937e6903-ec47-40fd-4b0b-08dc95d837e4
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 12:05:06.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6M5mcHt9NUMe6QGPlJGreiDVWcpETR2A1B1MfULqlZsJgjzA1THRE98jo6QLRZf1haftLLR27IfZlSPqFEjgTjjLkOOJRcvHGvwBAh8g+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7855
X-OriginatorOrg: intel.com

On 6/26/24 12:03, Sergey Temerkhanov wrote:
> Add ice_get_ctrl_ptp() wrapper to simplify the PTP support code
> in the functions that do not use ctrl_pf directly
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 2f32dcd42581..8f9a449a851c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -16,6 +16,18 @@ static const struct ptp_pin_desc ice_pin_desc_e810t[] = {
>   	{ "U.FL2", UFL2, PTP_PF_NONE, 2, { 0, } },
>   };
>   
> +static struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
> +{
> +	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;

As Michal has pointed out, this field is not yet added by you at this
(patch2/4) point.
Please fix and send next version as "v2".

> +}
> +
> +static struct ice_ptp *ice_get_ctrl_ptp(struct ice_pf *pf)
> +{
> +	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
> +
> +	return !ctrl_pf ? NULL : &ctrl_pf->ptp;
> +}
> +
>   /**
>    * ice_get_sma_config_e810t
>    * @hw: pointer to the hw struct


