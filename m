Return-Path: <netdev+bounces-99673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB8D8D5CA8
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30301C2207D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF3D14290F;
	Fri, 31 May 2024 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsbPjUQ4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D310914265A
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143928; cv=fail; b=fv6BwSCcIAO1mZrlmi2WwkItuLZUC84t6bi8eMAAQx4VLNzSU1xRXRfFitFaAmbJwbSVQnQHEFdrgV00ecHVYH8WRH5vF70r4+2dowutTR4vAf9BHZmXi4fvNCqgpCaWT3QmBRX2gBHSJlW1gJM3t0DC5L09EgJIvQvnz410Yw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143928; c=relaxed/simple;
	bh=TPMRgjLR6vQznozvyW8ZBiljdGBKEwGhpM6zOlWzCaw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SAC8g6KKkGebnL257UEMC1AcSuHwrksaBfHVxS859w0sbfTL0UCaK1KBM0txsUZQKQS5oPRRyJqE+9zhvxmMHDe6U8zAVavaqkBaT/Rafggarv2fOvAOYjNGncbOFBqrBDJ4NhIf/0J/hFSajVX9Y98c7l4GpBah3OgSZawAJ/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsbPjUQ4; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717143927; x=1748679927;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TPMRgjLR6vQznozvyW8ZBiljdGBKEwGhpM6zOlWzCaw=;
  b=lsbPjUQ4DVpZZF2+PWhev+bamRFuBqfhXmIgtr5QZbDKQxfbjBpawUgV
   nBoJOBFOEbLRJ1yIQU23y2FpxZorIRRorapal1IaTNbHB4lUofZ5Jrxnw
   lJAS+JC9C1GWDMAVd8IV9QY6sfgAiqPxHETy6f+BQCD6vEZ0YZm88aSy9
   r2T65kRhUWyjMrdRmISoz32F+fcroC/AYAmxZwJ0AKFbR0NEmJcKQgu60
   eKrEyk6nYwsXaIZSlU3h2BKZ3sBOmmH1KAWu24ZmHM2YsactqsoHHzz6Z
   seDeric954kXKudShFWqQHO6X+i77I4u4UAbairAeM5OOn6OzZtyZjLbN
   g==;
X-CSE-ConnectionGUID: DxbDgYzbRqCAd98dtK4DAQ==
X-CSE-MsgGUID: ppfhudkhTHW4U7DfyoBwyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13544994"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="13544994"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:25:26 -0700
X-CSE-ConnectionGUID: EozLrjN6T4KkShUvevUvDA==
X-CSE-MsgGUID: na82R0PySC6xWtbQi5yAdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="67290927"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 01:25:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 01:25:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 01:25:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 01:25:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 01:25:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R29AEFT+uCSdbJze+uVyxnFJOm40jUFzbBbZPDdQMavL/cgVyV4FNjhkiI6KTTblNFeuX5h6r+WyOH1JE3qKcAe9s3/Gg2zgceKx+JCrpiYreI6Tnam2rAF0xSpNFcf88XkrJFZ+z20ESyCNcAZV3l7rNGxA6hltEaXXZT1NcqWX/YulOGmI8Uv2onckt2cjB0xBbH1DVdWd9QmYCpg9PAwlDeWTpR6U93gjsaJQANcvFx7dORUJmIlCDVxvrgycuzKxhXhUFRAulE64qY1dwdyLnPo3zVRLHChDzJnMmtJHrBGMhyCzwgwnfK4Dsp1Ycs8j7+n6AMuhPxPlGUJ6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndYmZcaylhJIqPlyG1MY8AfSGDwpl683yvZcYkblJtI=;
 b=nI8yl6E79WXLKX0pb3zT+wihO35Mgd0T2CiEfOHHInW24pXSa6iR+o64OW6A0YK0FaCxzM4syesTpHtiI541lJma6TBbVZXyW0j8Rjhc4WsN7I4fsDei7l5M2Itn4pGFRgOklgZL4CUwFXrdldx6xotKU3hElbY1/7jzRbhJbQ8mlN0KWdXpIXISY4QYxDNkFjVyQgny7fBbFPq/wvsqxL0H85ua3akIhOZNUVjLr9suxIwo5ixpLJxYNvYf8phc6LhvQMv0DnAzFpbBcazIISf3JSyUA/6bN9/DzDpn3Va3vid/YQkkcdeG/TelqZwTkpZmxtAdu1QelZZPgQm+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW4PR11MB6885.namprd11.prod.outlook.com (2603:10b6:303:21b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 31 May
 2024 08:25:22 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 08:25:21 +0000
Message-ID: <bab83f2c-c120-42b0-916f-44dc91d5da80@intel.com>
Date: Fri, 31 May 2024 10:25:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/8] ice: implement AQ download pkg retry
To: Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>
CC: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Brett Creeley
	<brett.creeley@amd.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
 <20240528-net-2024-05-28-intel-net-fixes-v1-6-dc8593d2bbc6@intel.com>
 <20240529185106.3809bf2e@kernel.org>
 <21903032-f845-416b-8be7-646d36c50f59@intel.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <21903032-f845-416b-8be7-646d36c50f59@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0239.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::28) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW4PR11MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 53227228-4d60-49bc-b227-08dc814b3657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sm9QVlNKa2h5U2hTT3dCZlh0ZDV5U3VFczQzQllCNXkyY1RYODhFZUtkQXFJ?=
 =?utf-8?B?alF5NEFNTk8xU2ZBMHFXYTFqczZGcGV0NVYvd1hFYnk0YXZnc1dEQnArR2x5?=
 =?utf-8?B?RllFM3p6RldhS3dpU0FBUEthTGNpUnJ3bExHdkwxSXpFdVU3RHRHSWhOSWlG?=
 =?utf-8?B?bXU3aEVZQUZWemMwRW8vNXlzQUFPTWNQUTZnUzRVTnVPU0NtTG51NW15Nlla?=
 =?utf-8?B?K1duYkxva05ObUhRZmxSWWY1a3M5OWVOaHQ1Ui9RazR3aEt3dlVNdmp1dHdj?=
 =?utf-8?B?T294NkowVTdvUkNUclpWMW1EYkxMMW52ZElSSy8rakhabWQvYlJ1cGQvVkNw?=
 =?utf-8?B?TVI0UVJhSC9GU0kyZUZ2aDZyd29SOGJHSStESXV4VEc5RCtDSXlaYUljcUtK?=
 =?utf-8?B?WXBOM0htU2VZNFE1RGM0dVJpdFdPdXNwNDNWR2thd0pkMEYwOU1HdHkwK09h?=
 =?utf-8?B?L0pqSE9yeUhrSmhGM0JpdkwxM2J5UnpmTG04WEdRTTRjQXJVa25BUGF4a0FL?=
 =?utf-8?B?MlhGcGJsMEx3ZTluU014WXZsaW9MRFVlYTdoQmV2U1ZJQXAyTXYyekE2UEwy?=
 =?utf-8?B?bVg2Zm1yM2puSm9yQTNhVzQ0Y1pWZ25IOXl1YXlsb3VBZmE3cTlFeUFoRis3?=
 =?utf-8?B?U1J0R01jVjZKcWJBazdiWXFRazc3eUIzMklGemx5ZDZyY2M1Tk83QkJXMUdP?=
 =?utf-8?B?ZWFmS3ZSQm1aMW5KMGZKN1ZId3Qza2xoNkNHc1J6VjhieDZtQXlCczBuTTJv?=
 =?utf-8?B?dDltOUl5ZXJSdDlYY1V4RjliVmhPaTA4QlplQnJVYW50TkV2VWQyMDB0ZjNr?=
 =?utf-8?B?eHVRSEZQdUZoVjVXQjJjcjdyMEs3QW92THg3SmIwVDVRWkV0OGxjZlYyWlRv?=
 =?utf-8?B?NTl0QURjRCt6c2pUTWJZUXFvYm1TTkcxKzhTY0NUUXZVYVJBU0RhMW5jSzlw?=
 =?utf-8?B?VGFWMnhiSlpnR0NmbzVxTGc2RkxHcDVkL0VBdUdpeGZuRjZZTmx2enFhczR0?=
 =?utf-8?B?M0V0dkRuditPdnBkS2FRMU5Gd3MrVy9GK2w4OHZla0hDeWc1cEQ0ZTMrNzhv?=
 =?utf-8?B?QXFRK3ZXUURYZ1lFcEoxTmdWWHA3ZkFzM3AwTzZkYzJ2QklIem9zekE0T3VQ?=
 =?utf-8?B?eEV2SGx0ZVo3d0pubHphZVphNTFEMEgzZUFEVnJ1SW9vdkY4OFVSWkhJejl6?=
 =?utf-8?B?a3VwVmpFRTJWRDRXL3Bud2ZFN2RrTVdpb1dkVDdDZ2xqOUlFdHp4RUk4S3ZG?=
 =?utf-8?B?bUs0NENCSWRnSGZ6MWN2MVZmSVhVcFRUcFB5MEZ5RXNRMTFITndLS3RlSHVM?=
 =?utf-8?B?VVVUTnY2MlVZdlJkQlhjWEhMeFBwelhmS0pubzZMU1NuU2JOMURNT2gyOGJO?=
 =?utf-8?B?TjBicXhURkl5eHRFM2lVd2oxNTJJYTRsVVFKcENQRTcyRnMxaFBuaTArbElu?=
 =?utf-8?B?ZVpyc0VZazRlZktHcjVOTkVXZjU2M2ZtZDFnUmREaWMwajFMazVMMXZ4ZFA2?=
 =?utf-8?B?RGdrTTdiL0Iyell6VDBTeE5aWmQ1ZXlwM0U0UVo3UTBFc2hWbVVZNDhXNDVY?=
 =?utf-8?B?MW13M085ai93QmxKMDZwM2ZhdW9tdzlnZzJnWGx4SU5pS01tN0p1cS8yYmtr?=
 =?utf-8?B?RXl0VXo2dTVienJOM1k4aVdpYjd3U0plL1c2cUxNaDNiRlBvVTg1M2IveUE5?=
 =?utf-8?B?R1NBbk1XWnJZV25mMWt2dzlSZ2x0bzAvY0xONVRpRVlWNEdROCsyOG9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2JIbUNoUGFXVVhxQnJ0RHM3MW53VVc0ZGtuVG5zYTR1T1JmK0poVG1pUy91?=
 =?utf-8?B?enlGSkhFQUlha2tNdGhGUEdWUHJBSkRhN0d4Vzd6VElmQkdRRlU4aFJ1K2VM?=
 =?utf-8?B?TmxIam5rTlhYSVVBd3U3MHdlUjVOR2tpVjF0THpadzQvQ3lPY3pMT0pFejdi?=
 =?utf-8?B?dFcwQzJJSjdFTDN6NFBXMmpkbm5nV0lCaHZrQi93Z09TVU5jVWF0bzllTTQ3?=
 =?utf-8?B?eEh4dEtndSsvdGVCbk9LWlNwZ2s2M09YZDVyV2FhSzhNcjZVOFl0VC94eWha?=
 =?utf-8?B?OGNEaDAvN0lNUmF3OUt6eTBON29UbzlCVnZyREhoUGx2M1drbWtaNnoydS9Y?=
 =?utf-8?B?TzZlM2N3d0tIak9icENRWTZId3hZeTg2cFQ3YmEwRGNCd3AxTlRvZWxRQzA4?=
 =?utf-8?B?RDVTSlcyblJoa1g0OHRmRGcrYTkzWGNPbHZUVzRUaTk3YXZhOTJaVXBXUnNV?=
 =?utf-8?B?aXlpNFNTVm9nUUFyOXN2eFVSWXlkaTFaRGZoeEVBSGJBcmtCUmNRUTJRRURB?=
 =?utf-8?B?M29KTVpBZkJMNjlwcThraHAveGt2MmlycVYxVzlxZ1oxMFE1dG5hQ0Vtd1lu?=
 =?utf-8?B?YVJRakl6TEpyN05JWGZXY0dsbjBSNkc0Y0FOUjR0K0hYMWoyZ3RucVZEbWNa?=
 =?utf-8?B?M2ZsSi94Qk9tVWlXa1RBUHlPdUcvbHVUQ05sSWVPZ1E2ZlEwUEVvQzh3aFBG?=
 =?utf-8?B?UVhWNVBKOU83VEIvenRwTUhoS3MyRmNqT2FQdGhkMkdSUlVHdDNNZStnWEE2?=
 =?utf-8?B?bk9JWktzUC80c3p3MWE2WlczL0FNRW9YbG9MWEFLa2pHa0FGQk5tOEd2bURx?=
 =?utf-8?B?K1dLREIreEcxRzJlaHFYRGpLMjBPK1pFTnRsS2pOc1kzTnVXS3pFTExRQkJa?=
 =?utf-8?B?VjVPV0srSEZoamdHdk9pVHJuZ3lhYVEraHZySXNmblJrNUxNbXFaS0MwM3hJ?=
 =?utf-8?B?ME9qVm9WYXZ2S1lvNEE5TVR4S2FKU0FHT0VuQmIzN0E2TDFBajNzMVNRb2xZ?=
 =?utf-8?B?alhmNDU0cDJLeGVueFV2cXkvWFF5MEVFVHd1cFVPVjdsTHdGUExPMXV3MCts?=
 =?utf-8?B?dEZyTTNiMUpFNjJLMGdKS2ZHd0QzWXl4TTdmaEx5YVhUR3Bybi81dVRRN2d2?=
 =?utf-8?B?dHJJYTdRdGRiR3FySENHeDdGbTBVdjhTTU9zNTIzMmxRZ1ViV1BZVXRiUkZk?=
 =?utf-8?B?WWJ6eE5wSXBVNHJzMTVkRlhMNks2SmtLRm5qeDk3MXZLZ1dqY214cEZPTnNv?=
 =?utf-8?B?YVRqVGlvdGhjOTdVWGd5eXRIV0J5QlByRVp4V1hvaDlmbHB1cTFRaEpyTHlS?=
 =?utf-8?B?bWx5R2NNNkswbFpVa1VkTno0d0lpdVRTTEZMbWZUbjllZ1NRenhIQXJldHJK?=
 =?utf-8?B?bTFGd2M1Z1lmREJPV1VldGEzQlJ4NzRSMStCYWVNZ0xCc2ZoVjlIRm1NTlRY?=
 =?utf-8?B?VTNiZWt6WEl6Tk15blkycjVjaysvWXJpUGNEQzluV3dqRmxOR2FJYWFjMmpu?=
 =?utf-8?B?eTZDTFZHNitCSzdJZmFRaFVrVXAvMll6U3FQaG1XT3dVcU84aHVqL2hmYll0?=
 =?utf-8?B?Nzl4UHpVZHpYMStuK2g4OG5UL0ZNT3o2N1RTWm8zbHo5NnhaUU9TRnFFMUhT?=
 =?utf-8?B?TU1lWmt0Qzd4QjBNTDQxZW9BVlNmVjJmRjU3RmRuUzM0VkE2dGFCVnBoK1Rs?=
 =?utf-8?B?OHFqMVZwOGRNYS93TnF5UmdhYVpWY0wyeTlmSTN5ZnkxTkF0QW1ma05yQ1l4?=
 =?utf-8?B?R0UxMFc0NDFuNFJYUzQ1QmlkSEZxdUtwTzR0MlB1WG1hWi9HcXhSZERsVzF2?=
 =?utf-8?B?K01GMEN6ZG1pK1JZODYrTXZ0WlVzeEdlOFdFdysxRVg5dVJxQ25Jc05tZHFa?=
 =?utf-8?B?eEVhdTJEaVhEQXhFc0p0SVhKOTdZL01CaHNoeTV6Y21DaGkzQWcrYy9WaXV6?=
 =?utf-8?B?THBqSkR6YUxNZ0dwOEdNTTNGVDMzWCttUElxWi9OQkVFdTRacXFJZzF6SGZN?=
 =?utf-8?B?aThMVUJ6UDAyVzhLOEhHTUtSYkVob3lzTXg1Um5MWjlPdlM2MGEvWGtQcFc4?=
 =?utf-8?B?U01IYzgwRzdaNEVKTHFibFVIUkdGN3l2aU91Wm5ZNnplcUtUZVBmMWxqNnJR?=
 =?utf-8?B?SDVramt3QlJsa2VrQWN6MFpFYlpKWWYyaVQ5cTl6K0dmeksvYzR5S1hDTHg0?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53227228-4d60-49bc-b227-08dc814b3657
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 08:25:21.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6d0Ov+vWONVuPwVwV41oLiCo+R1UK6nJ14NeqiwPtX/LpUF6Iu0LU5b7bFUbF1oIVz5tswY3n8DWMLrZmVtOf1w8FYRl8KsCAng6qT46dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6885
X-OriginatorOrg: intel.com



On 30.05.2024 18:50, Jacob Keller wrote:
> 
> 
> On 5/29/2024 6:51 PM, Jakub Kicinski wrote:
>> On Tue, 28 May 2024 15:06:09 -0700 Jacob Keller wrote:
>>> +		while (try_cnt < 5) {
>>> +			status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE,
>>> +						     last, &offset, &info,
>>> +						     NULL);
>>> +			if (hw->adminq.sq_last_status != ICE_AQ_RC_ENOSEC &&
>>> +			    hw->adminq.sq_last_status != ICE_AQ_RC_EBADSIG)
>>> +				break;
>>> +
>>> +			try_cnt++;
>>> +			msleep(20);
>>> +		}
>>> +
>>> +		if (try_cnt)
>>> +			dev_dbg(ice_hw_to_dev(hw),
>>> +				"ice_aq_download_pkg number of retries: %d\n",
>>> +				try_cnt);
>>>  
>>
>> That's not a great wait loop. Last iteration sleeps for 20msec and then
>> gives up without checking the condition.
> 
> Yea, that seems rather silly.
> 
> @Wojciech, would you please look into this?

Sure, I'll send next version

