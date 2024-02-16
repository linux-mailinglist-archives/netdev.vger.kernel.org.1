Return-Path: <netdev+bounces-72424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 311A685810D
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 16:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24AFB20FF7
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD5D12FF8D;
	Fri, 16 Feb 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcJnEArV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC5812F599
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096700; cv=fail; b=eqMu6Wekdg6Sa6yNopmGH5efXx96UagPQiQ3o4SK1yNzUdBQw0GCQm+M3qqkoCm5XW7Q7mod4YlAFxce6Ysoos/Ns/oiGkFKySVLwpl2q+fh+KCKuxm00WbcGueMSt1u/Ws3IZR2DM6go5AR6fT+VKIgLX1zXuby3Bg3If8nXQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096700; c=relaxed/simple;
	bh=gr+NbyBCrk5jvo+xVFoPjX8JVKTdwQf/VKbj/GEvrLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TuiJJQ4Rc8jpcYVyfZE4SxzFVWmkBT9AoH2dEoH4UEIxo59UO9JXLvunt1Mj8x4ySuZSbuUpkNTiv+F8w8l8Lzj+4ygdmIc+i9JURkNzT9KhnNZBfxBkwNuO7lHTjywP15iVzodbEp1HxboydX4foMjIBX5e4QO+1rGnNOkO2/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcJnEArV; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708096698; x=1739632698;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gr+NbyBCrk5jvo+xVFoPjX8JVKTdwQf/VKbj/GEvrLM=;
  b=YcJnEArVsPSGWwL7vBStN9EPSTyDOuKMqxRp6KElwjI59LLK/Q6p8iDR
   uy5eP6aSg06O0A1sJhOawcKt/XOxy7poL0Zus2wi6vArVduXn/kgOLkzL
   Ir28pUqYaHP/l6i8K8b1EY1svbQT9tXWmN1PJjX1WlJavLNJs4LVd/yMT
   aOroungOVDrIN4WFW6aq+0IxH9BbtLMmgnaZfslot3BZ3aSubM4sf4lKR
   yBYFcEy2nfx3LfROtZ9V4ghtAds6a0uW/4j6ahBJGA3KiLbXbvs+yRF8v
   hLQ8YgT6TdN1ARED8dJlLHHAt5qzIGCMrTUGOlXnzpE4uCaa6zbBOQCN9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2633055"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2633055"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 07:18:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="8500097"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 07:18:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 07:18:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 07:18:09 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 07:18:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+irM0r7qz7EF+Y5N3dC0mwU8YDRYnnBCnZjiCxa9rPjzUDDBygmVMdlAra9uGyh9y/3WZUiejxvL2D/5jLSaeYh9ZNZJrTLyEBXjiXj5pAZs92l9rPx8NqFvwn+uiHU55V847tC0DpYFsebQfi834cxZjltjTTy4wFekIGvYM/dynLwnuyVAlkiNJz378OITTcQapOZoaxuIhn22TPCo0OOKZHAF5Xt16JLifMsJRUOfGNkZyMz0FtrtKUwUivrD2ooWcVmaiFlKx3JG9LpZxtfeRU2uEP332AKSJkc9ufzSVvTrEGqdfLDHdL5j/GiZkMlUc6euIfn+P0tTL0v8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wvZfZz9ijwGMHjip5HWxOW2DdvpPyGoRtgeUUEciP4=;
 b=eGukkgok3hMI/TC+R9U7M4xPtKQd+uXaJ1cNiNdZuwKC39lOwGwx2SzX23iPb0bLeDGt1/PuN2V00pfH3mavWEAS02hl36n8QFMqH0zLwpsZUDSRQFktNPFtsczG+JiSZpRcm6mUzGpyyMGKKxwIzT+Mpbd2+FvqVtsxrtv2kth/G8P9moTi9OVABMpzrKACt8xKelXJZHF6HQWQOAFA1+fmE3CCkGIVUozN6ZTBN3EXaNn5pOuZSaz1nLow6aRQOmzDdO2jpKYjVafqdpqXJQCncbrYTMocSQ5pVeW0v11XbKWCPwkIHipTrOAirpQcUsTtsQ0MjCY7wpBA+AoELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5094.namprd11.prod.outlook.com (2603:10b6:510:3f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.31; Fri, 16 Feb 2024 15:18:06 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 15:18:06 +0000
Date: Fri, 16 Feb 2024 16:18:01 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Pavel Vazharov <pavel@x3me.net>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, Toke
 =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
Message-ID: <Zc98qZYQznLdVSCg@boxer>
References: <87wmrqzyc9.fsf@toke.dk>
 <CAJEV1ig2Gyqb2MPHU+qN_G7XDVNZffU5HDm5VkoGev_QOe7bXg@mail.gmail.com>
 <87r0hyzxbd.fsf@toke.dk>
 <CAJ8uoz0bZjeJKJbCOfaogJZg2o5zoWNf3XjAF-4ZubpxDoQhcg@mail.gmail.com>
 <CAJEV1ihnwDxkkeMtAkkkZpP5O-VMxVvJojLs6dMbeMYgsn7sGA@mail.gmail.com>
 <ZcPTNpzGyqQI+DXw@boxer>
 <CAJEV1ihMuP6Oq+=ubd05DReBXuLwmZLYFwO=ha2C995wBuWeLA@mail.gmail.com>
 <CAJEV1igugU1SjcWnjYgoG0x_stExm0MyxwdFN0xycSb9sadkXw@mail.gmail.com>
 <CAJEV1ijnUrJXOuGW5xnuCvMTtaC1VKhOXQ0_4iJnqR5Vco4yLg@mail.gmail.com>
 <ZcZxBK0b21uIw3k6@boxer>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcZxBK0b21uIw3k6@boxer>
X-ClientProxiedBy: FR3P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::23) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fcc5b79-17fc-448f-8c38-08dc2f027a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCVhG2Jv5qQJtcfUtoqzW4jZwq6OC5EtGe6ZJu5UTPAir6lnhV8K/KMYxHn52KDrdfMSVrguUX6BOWTLgVDV8bBo6r9eEfgAETHL+k+TCS9BipeYcBtNSuLQcqdu9DJr1lfkKUnyAUZJ/24wPo35XSgJKm2Qo0CWHHsJureJJNR3jxyYGFrKd7fD5SziEnf+Ib8ZDEmu/2RiwzSpOvmPu7HL2KW6g2roqAYnmFkH3vlxTSTWTK83es0ItY0DaTpKckzHwewHDLoW6Qz50dkBIjKASvjDoveUKfGyIjQRIAyN1EO2dnNix9HRRDyt7q8j9InjVPFNyGwah/1KGLlrZdUS71H9cFm6hmFUQ3TJjnsCjuM2YmVtMOWwEVnSBs4ueAoatqO0Bsnxx3ny8NtCkfZxCcKldpsSZMQkQez75ibBejgzNRSWKtDP+14H0l3UmhL0A3KcOulramQGS3SDp9jjJzKc9Exk6LH5X21mD44HFMZu5dSNg02XLHkB6HWgKZDOP9VU4p8mty9pZnFTqRrtqHRSeQTIt1slpA3w1o+pFBVf6bfSjuI17i6BH6Al
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(346002)(136003)(39860400002)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(53546011)(6512007)(6506007)(9686003)(6486002)(966005)(478600001)(33716001)(66899024)(2906002)(66556008)(30864003)(5660300002)(44832011)(66946007)(66476007)(8676002)(4326008)(8936002)(6916009)(54906003)(41300700001)(6666004)(316002)(19627235002)(26005)(66574015)(83380400001)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWRCaTlVRTJSdVNXOGtoakRwd1dmOUhlZ3Rvby96d0htN3NyZHRTczNhaGNh?=
 =?utf-8?B?dHVFYVFlS0xDOE9YYm90ZzErNWgvdy9WSm9TWGJMa1VpWGkvRmcyT1hjVUJx?=
 =?utf-8?B?UzdieVJMWU1JZTRBT1gvbWpmWGhNWHpPUEt6TVpOSGFqTDZFM1VnNnVwYXI2?=
 =?utf-8?B?SEZyZGNoNXNlR1p1Skl6Z1lBL2dnd0JUT2ZaamNtd2djSk9kVVgrSnNwYXla?=
 =?utf-8?B?Y0kvajQ1d2ZLTEJwRnJuRzRGdkNrMWVXcjJsVGdlQkZsaTZrc1ZvclNnOWlW?=
 =?utf-8?B?NTJJVGN2eXN2WEIyVkhFZUtxMXNGMm51bTJERDZ6dVBMWVFERWF4RmtaZzFp?=
 =?utf-8?B?RjZaZVM2RURlRWlJOTZMVmdBek4vVVhmK0NTZ3RQaHJyY1IxdHcvdmhzMEhH?=
 =?utf-8?B?QllES2NKaWUzWHM4dGkvYlU4ODRFYVFNTm5ROFZQMTFjWXRiL1QxTGZUdE5J?=
 =?utf-8?B?dllqQThnajJBaFdRSTVMVDkvVGhXcEVpOHExZFExbWpZellCWW9jckVNRlAy?=
 =?utf-8?B?bDRjVStCTm9tSVd0UmQzTFk3V3ZxZFR6NEQyT3lkVEdYSXp1dy9CYkgwaWdQ?=
 =?utf-8?B?VHJmMDFpTko0UG5jZXdyQVpDOE9vbWR6OWwxc0M3UDJmUlBNM3lLM2YrV0lN?=
 =?utf-8?B?WkJkYXBmMTVuMC9JL0hDei95NWVwa2M4N2QycUlPSFY2cHNmU253bG9oQlJC?=
 =?utf-8?B?ME9VcllIS0kxQ2w5L1BLNVhYNnVaSVlxcU1OWHNUc056SnJJeEo2eE1wZkRQ?=
 =?utf-8?B?Lzk2T0U4N2ZIY2sxRTFlVkFwYUU5U1U1ZzgrRkwySHpiQ3NMNFd3Q25vTzRt?=
 =?utf-8?B?bE9xTjJGOThDMlpsWHYwVDYrNHhkMm1tZzA5ZEFxa08yMzF4Y0htV3JjdEww?=
 =?utf-8?B?S0IrM3hxSzZDY2h4bCt5S0RVc0VHUDBqWnBqcEswYWd2aUNUZUZpVSt3VHV6?=
 =?utf-8?B?Q05VWXg2WmNDaWJFMlE5NWRHWEM0bFlFNDgzbks2WGlzUkUrRkZyVkdmbGpI?=
 =?utf-8?B?NkVBUkdHYXRlK3hFWlI2ZFFzQmd6VHVoUmhPWUxnek5PWnhmZStWVFdFUFF2?=
 =?utf-8?B?QWtiUkEzODBDdDYxQlhPeFZlWWlqeGNVRHBsdE1tT21veGZMWUllWHVGNHp4?=
 =?utf-8?B?WUVraFhoekZoZk15citXa0ZjbWROb0x2cENxaHRialhLR250ZHIwY2VITEJx?=
 =?utf-8?B?b05Xb2ZVMlFTSWx1L1VUdTlDSGRwc0k3elJlbkh6ZUlRQml4T0x2N2ZCRWx4?=
 =?utf-8?B?ZXF6OGJ2dU9JL3FLYVpEL0t2WHlHWEhhWXM4WS9NTHlMWnVvbno5QWlWMVVO?=
 =?utf-8?B?c2FEY2V1TUtYcHEySEx0MkVNVnd6YlorTkR6MEJxNTUyakdqVkl2bWtHZ2I0?=
 =?utf-8?B?Y2ptMkdMSGkwNHMxL3hyQW1GaG9wZHg3cUptTTFkZXlQVlI2TFlCTkZlUmpt?=
 =?utf-8?B?Q01uZTRuSmNZVFZDL1pVZWtXNTZaajZ4eTFYR0ZWL05hYmExMHNNdlhHY0lD?=
 =?utf-8?B?aExBcjhpLzlWSENUTHlwYktXYnRaOWZYRWt4cGQvSGt5Y3lxQi9pQllXM0NT?=
 =?utf-8?B?cDVsNWYrb2E4ajY3S3RMWjNReklKNzF1dDh2OGpQSWVmTU1EUWt4aVN4OGs3?=
 =?utf-8?B?MVd6b0dGUFdVcFBrcGc0dFZLampmRlFNY0NRMm5CV3BRY3lTRjA5MkZuWDNq?=
 =?utf-8?B?MzUrVDRqZmJFMkZjSWx2c2NnN1NNNitpL21uMk9OenQ4emswK1pWMHBBZHlF?=
 =?utf-8?B?NUt3cGRzRE01WGJkeDVaakJFSUZURGNZdTFNZGlUclQ3MERHc0cyeHFLTzBK?=
 =?utf-8?B?ZXEwNm15dTdYUWlldVphQnFuQkdieGxNbmlMU3d1cGxtVXlxMXlTaVI2Z001?=
 =?utf-8?B?a0xxZkN5V05UcG9GUTJCelRaN28wemhJbDRhL0Y5NEJRV3V6R2NmbEs5UStR?=
 =?utf-8?B?d21MQTVSdlVUa0pISkR3VnlyRDkrMDZmWlVYVWUrZnBWVjV2L2JUclVXSUph?=
 =?utf-8?B?NnhuUUFyd0M1NUxnSDFOZjI5T1dEQ0RXakFPK0pTbmVWRWROMGZCQUkzbWps?=
 =?utf-8?B?RktSanlzblFJSXJNOGFQeFY2NGlzOW45eHAxNHRFSHFUMnk5SG1rSnMxR0dQ?=
 =?utf-8?B?Qm12L1k4dGw1WUlkb2V4clZoeCtyVW9MV1RPcXJCNlVsRWUvZDBMSDIwSXlC?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcc5b79-17fc-448f-8c38-08dc2f027a11
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:18:06.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIZQu57MVO26WSaohiX8Bdw6pnHscqAprO0OP29iGe3P1Ahh7YqwD/5ooL1MQWXi2XnmQD38x1mFnNOpcTKH63Mteuo4XR2CvMUJHiDn3K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5094
X-OriginatorOrg: intel.com

On Fri, Feb 09, 2024 at 07:37:56PM +0100, Maciej Fijalkowski wrote:
> On Fri, Feb 09, 2024 at 11:03:51AM +0200, Pavel Vazharov wrote:
> > On Thu, Feb 8, 2024 at 5:47 PM Pavel Vazharov <pavel@x3me.net> wrote:
> > >
> > > On Thu, Feb 8, 2024 at 12:59 PM Pavel Vazharov <pavel@x3me.net> wrote:
> > > >
> > > > On Wed, Feb 7, 2024 at 9:00 PM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Wed, Feb 07, 2024 at 05:49:47PM +0200, Pavel Vazharov wrote:
> > > > > > On Mon, Feb 5, 2024 at 9:07 AM Magnus Karlsson
> > > > > > <magnus.karlsson@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, 30 Jan 2024 at 15:54, Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Pavel Vazharov <pavel@x3me.net> writes:
> > > > > > > >
> > > > > > > > > On Tue, Jan 30, 2024 at 4:32 PM Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> > > > > > > > >>
> > > > > > > > >> Pavel Vazharov <pavel@x3me.net> writes:
> > > > > > > > >>
> > > > > > > > >> >> On Sat, Jan 27, 2024 at 7:08 AM Pavel Vazharov <pavel@x3me.net> wrote:
> > > > > > > > >> >>>
> > > > > > > > >> >>> On Sat, Jan 27, 2024 at 6:39 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > > > > > > > >> >>> >
> > > > > > > > >> >>> > On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
> > > > > > > > >> >>> > > > Well, it will be up to your application to ensure that it is not. The
> > > > > > > > >> >>> > > > XDP program will run before the stack sees the LACP management traffic,
> > > > > > > > >> >>> > > > so you will have to take some measure to ensure that any such management
> > > > > > > > >> >>> > > > traffic gets routed to the stack instead of to the DPDK application. My
> > > > > > > > >> >>> > > > immediate guess would be that this is the cause of those warnings?
> > > > > > > > >> >>> > >
> > > > > > > > >> >>> > > Thank you for the response.
> > > > > > > > >> >>> > > I already checked the XDP program.
> > > > > > > > >> >>> > > It redirects particular pools of IPv4 (TCP or UDP) traffic to the application.
> > > > > > > > >> >>> > > Everything else is passed to the Linux kernel.
> > > > > > > > >> >>> > > However, I'll check it again. Just to be sure.
> > > > > > > > >> >>> >
> > > > > > > > >> >>> > What device driver are you using, if you don't mind sharing?
> > > > > > > > >> >>> > The pass thru code path may be much less well tested in AF_XDP
> > > > > > > > >> >>> > drivers.
> > > > > > > > >> >>> These are the kernel version and the drivers for the 3 ports in the
> > > > > > > > >> >>> above bonding.
> > > > > > > > >> >>> ~# uname -a
> > > > > > > > >> >>> Linux 6.3.2 #1 SMP Wed May 17 08:17:50 UTC 2023 x86_64 GNU/Linux
> > > > > > > > >> >>> ~# lspci -v | grep -A 16 -e 1b:00.0 -e 3b:00.0 -e 5e:00.0
> > > > > > > > >> >>> 1b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> > > > > > > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > > > > > > >> >>>        ...
> > > > > > > > >> >>>         Kernel driver in use: ixgbe
> > > > > > > > >> >>> --
> > > > > > > > >> >>> 3b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> > > > > > > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > > > > > > >> >>>         ...
> > > > > > > > >> >>>         Kernel driver in use: ixgbe
> > > > > > > > >> >>> --
> > > > > > > > >> >>> 5e:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> > > > > > > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > > > > > > >> >>>         ...
> > > > > > > > >> >>>         Kernel driver in use: ixgbe
> > > > > > > > >> >>>
> > > > > > > > >> >>> I think they should be well supported, right?
> > > > > > > > >> >>> So far, it seems that the present usage scenario should work and the
> > > > > > > > >> >>> problem is somewhere in my code.
> > > > > > > > >> >>> I'll double check it again and try to simplify everything in order to
> > > > > > > > >> >>> pinpoint the problem.
> > > > > > > > >> > I've managed to pinpoint that forcing the copying of the packets
> > > > > > > > >> > between the kernel and the user space
> > > > > > > > >> > (XDP_COPY) fixes the issue with the malformed LACPDUs and the not
> > > > > > > > >> > working bonding.
> > > > > > > > >>
> > > > > > > > >> (+Magnus)
> > > > > > > > >>
> > > > > > > > >> Right, okay, that seems to suggest a bug in the internal kernel copying
> > > > > > > > >> that happens on XDP_PASS in zero-copy mode. Which would be a driver bug;
> > > > > > > > >> any chance you could test with a different driver and see if the same
> > > > > > > > >> issue appears there?
> > > > > > > > >>
> > > > > > > > >> -Toke
> > > > > > > > > No, sorry.
> > > > > > > > > We have only servers with Intel 82599ES with ixgbe drivers.
> > > > > > > > > And one lab machine with Intel 82540EM with igb driver but we can't
> > > > > > > > > set up bonding there
> > > > > > > > > and the problem is not reproducible there.
> > > > > > > >
> > > > > > > > Right, okay. Another thing that may be of some use is to try to capture
> > > > > > > > the packets on the physical devices using tcpdump. That should (I think)
> > > > > > > > show you the LACDPU packets as they come in, before they hit the bonding
> > > > > > > > device, but after they are copied from the XDP frame. If it's a packet
> > > > > > > > corruption issue, that should be visible in the captured packet; you can
> > > > > > > > compare with an xdpdump capture to see if there are any differences...
> > > > > > >
> > > > > > > Pavel,
> > > > > > >
> > > > > > > Sounds like an issue with the driver in zero-copy mode as it works
> > > > > > > fine in copy mode. Maciej and I will take a look at it.
> > > > > > >
> > > > > > > > -Toke
> > > > > > > >
> > > > > >
> > > > > > First I want to apologize for not responding for such a long time.
> > > > > > I had different tasks the previous week and this week went back to this issue.
> > > > > > I had to modify the code of the af_xdp driver inside the DPDK so that it loads
> > > > > > the XDP program in a way which is compatible with the xdp-dispatcher.
> > > > > > Finally, I was able to run our application with the XDP sockets and the xdpdump
> > > > > > at the same time.
> > > > > >
> > > > > > Back to the issue.
> > > > > > I just want to say again that we are not binding the XDP sockets to
> > > > > > the bonding device.
> > > > > > We are binding the sockets to the queues of the physical interfaces
> > > > > > "below" the bonding device.
> > > > > > My further observation this time is that when the issue happens and
> > > > > > the remote device reports
> > > > > > the LACP error there is no incoming LACP traffic on the corresponding
> > > > > > local port,
> > > > > > as seen by the xdump.
> > > > > > The tcpdump at the same time sees only outgoing LACP packets and
> > > > > > nothing incoming.
> > > > > > For example:
> > > > > > Remote device
> > > > > >                           Local Server
> > > > > > TrunkName=Eth-Trunk20, PortName=XGigabitEthernet0/0/12 <---> eth0
> > > > > > TrunkName=Eth-Trunk20, PortName=XGigabitEthernet0/0/13 <---> eth2
> > > > > > TrunkName=Eth-Trunk20, PortName=XGigabitEthernet0/0/14 <---> eth4
> > > > > > And when the remote device reports "received an abnormal LACPDU"
> > > > > > for PortName=XGigabitEthernet0/0/14 I can see via xdpdump that there
> > > > > > is no incoming LACP traffic
> > > > >
> > > > > Hey Pavel,
> > > > >
> > > > > can you also look at /proc/interrupts at eth4 and what ethtool -S shows
> > > > > there?
> > > > I reproduced the problem but this time the interface with the weird
> > > > state was eth0.
> > > > It's different every time and sometimes even two of the interfaces are
> > > > in such a state.
> > > > Here are the requested info while being in this state:
> > > > ~# ethtool -S eth0 > /tmp/stats0.txt ; sleep 10 ; ethtool -S eth0 >
> > > > /tmp/stats1.txt ; diff /tmp/stats0.txt /tmp/stats1.txt
> > > > 6c6
> > > > <      rx_pkts_nic: 81426
> > > > ---
> > > > >      rx_pkts_nic: 81436
> > > > 8c8
> > > > <      rx_bytes_nic: 10286521
> > > > ---
> > > > >      rx_bytes_nic: 10287801
> > > > 17c17
> > > > <      multicast: 72216
> > > > ---
> > > > >      multicast: 72226
> > > > 48c48
> > > > <      rx_no_dma_resources: 1109
> > > > ---
> > > > >      rx_no_dma_resources: 1119
> > > >
> > > > ~# cat /proc/interrupts | grep eth0 > /tmp/interrupts0.txt ; sleep 10
> > > > ; cat /proc/interrupts | grep eth0 > /tmp/interrupts1.txt
> > > > interrupts0: 430 3098 64 108199 108199 108199 108199 108199 108199
> > > > 108199 108201 63 64 1865 108199  61
> > > > interrupts1: 435 3103 69 117967 117967  117967 117967 117967  117967
> > > > 117967 117969 68 69 1870  117967 66
> > > >
> > > > So, it seems that packets are coming on the interface but they don't
> > > > reach to the XDP layer and deeper.
> > > > rx_no_dma_resources - this counter seems to give clues about a possible issue?
> > > >
> > > > >
> > > > > > on eth4 but there is incoming LACP traffic on eth0 and eth2.
> > > > > > At the same time, according to the dmesg the kernel sees all of the
> > > > > > interfaces as
> > > > > > "link status definitely up, 10000 Mbps full duplex".
> > > > > > The issue goes aways if I stop the application even without removing
> > > > > > the XDP programs
> > > > > > from the interfaces - the running xdpdump starts showing the incoming
> > > > > > LACP traffic immediately.
> > > > > > The issue also goes away if I do "ip link set down eth4 && ip link set up eth4".
> > > > >
> > > > > and the setup is what when doing the link flap? XDP progs are loaded to
> > > > > each of the 3 interfaces of bond?
> > > > Yes, the same XDP program is loaded on application startup on each one
> > > > of the interfaces which are part of bond0 (eth0, eth2, eth4):
> > > > # xdp-loader status
> > > > CURRENT XDP PROGRAM STATUS:
> > > >
> > > > Interface        Prio  Program name      Mode     ID   Tag
> > > >   Chain actions
> > > > --------------------------------------------------------------------------------------
> > > > lo                     <No XDP program loaded!>
> > > > eth0                   xdp_dispatcher    native   1320 90f686eb86991928
> > > >  =>              50     x3sp_splitter_func          1329
> > > > 3b185187f1855c4c  XDP_PASS
> > > > eth1                   <No XDP program loaded!>
> > > > eth2                   xdp_dispatcher    native   1334 90f686eb86991928
> > > >  =>              50     x3sp_splitter_func          1337
> > > > 3b185187f1855c4c  XDP_PASS
> > > > eth3                   <No XDP program loaded!>
> > > > eth4                   xdp_dispatcher    native   1342 90f686eb86991928
> > > >  =>              50     x3sp_splitter_func          1345
> > > > 3b185187f1855c4c  XDP_PASS
> > > > eth5                   <No XDP program loaded!>
> > > > eth6                   <No XDP program loaded!>
> > > > eth7                   <No XDP program loaded!>
> > > > bond0                  <No XDP program loaded!>
> > > > Each of these interfaces is setup to have 16 queues i.e. the application,
> > > > through the DPDK machinery, opens 3x16 XSK sockets each bound to the
> > > > corresponding queue of the corresponding interface.
> > > > ~# ethtool -l eth0 # It's same for the other 2 devices
> > > > Channel parameters for eth0:
> > > > Pre-set maximums:
> > > > RX:             n/a
> > > > TX:             n/a
> > > > Other:          1
> > > > Combined:       48
> > > > Current hardware settings:
> > > > RX:             n/a
> > > > TX:             n/a
> > > > Other:          1
> > > > Combined:       16
> > > >
> > > > >
> > > > > > However, I'm not sure what happens with the bound XDP sockets in this case
> > > > > > because I haven't tested further.
> > > > >
> > > > > can you also try to bind xsk sockets before attaching XDP progs?
> > > > I looked into the DPDK code again.
> > > > The DPDK framework provides callback hooks like eth_rx_queue_setup
> > > > and each "driver" implements it as needed. Each Rx/Tx queue of the device is
> > > > set up separately. The af_xdp driver currently does this for each Rx
> > > > queue separately:
> > > > 1. configures the umem for the queue
> > > > 2. loads the XDP program on the corresponding interface, if not already loaded
> > > >    (i.e. this happens only once per interface when its first queue is set up).
> > > > 3. does xsk_socket__create which as far as I looked also internally binds the
> > > > socket to the given queue
> > > > 4. places the socket in the XSKS map of the XDP program via bpf_map_update_elem
> > > >
> > > > So, it seems to me that the change needed will be a bit more involved.
> > > > I'm not sure if it'll be possible to hardcode, just for the test, the
> > > > program loading and
> > > > the placing of all XSK sockets in the map to happen when the setup of the last
> > > > "queue" for the given interface is done. I need to think a bit more about this.
> > > Changed the code of the DPDK af_xdp "driver" to create and bind all of
> > > the XSK sockets
> > > to the queues of the corresponding interface and after that, after the
> > > initialization of the
> > > last XSK socket, I added the logic for the attachment of the XDP
> > > program to the interface
> > > and the population of the XSK map with the created sockets.
> > > The issue was still there but it was kind of harder to reproduce - it
> > > happened once for 5
> > > starts of the application.
> > >
> > > >
> > > > >
> > > > > >
> > > > > > It seems to me that something racy happens when the interfaces go down
> > > > > > and back up
> > > > > > (visible in the dmesg) when the XDP sockets are bound to their queues.
> > > > > > I mean, I'm not sure why the interfaces go down and up but setting
> > > > > > only the XDP programs
> > > > > > on the interfaces doesn't cause this behavior. So, I assume it's
> > > > > > caused by the binding of the XDP sockets.
> > > > >
> > > > > hmm i'm lost here, above you said you got no incoming traffic on eth4 even
> > > > > without xsk sockets being bound?
> > > > Probably I've phrased something in a wrong way.
> > > > The issue is not observed if I load the XDP program on all interfaces
> > > > (eth0, eth2, eth4)
> > > > with the xdp-loader:
> > > > xdp-loader load --mode native <iface> <path-to-the-xdp-program>
> > > > It's not observed probably because there are no interface down/up actions.
> > > > I also modified the DPDK "driver" to not remove the XDP program on exit and thus
> > > > when the application stops only the XSK sockets are closed but the
> > > > program remains
> > > > loaded at the interfaces. When I stop this version of the application
> > > > while running the
> > > > xdpdump at the same time I see that the traffic immediately appears in
> > > > the xdpdump.
> > > > Also, note that I basically trimmed the XDP program to simply contain
> > > > the XSK map
> > > > (BPF_MAP_TYPE_XSKMAP) and the function just does "return XDP_PASS;".
> > > > I wanted to exclude every possibility for the XDP program to do something wrong.
> > > > So, from the above it seems to me that the issue is triggered somehow by the XSK
> > > > sockets usage.
> > > >
> > > > >
> > > > > > It could be that the issue is not related to the XDP sockets but just
> > > > > > to the down/up actions of the interfaces.
> > > > > > On the other hand, I'm not sure why the issue is easily reproducible
> > > > > > when the zero copy mode is enabled
> > > > > > (4 out of 5 tests reproduced the issue).
> > > > > > However, when the zero copy is disabled this issue doesn't happen
> > > > > > (I tried 10 times in a row and it doesn't happen).
> > > > >
> > > > > any chances that you could rule out the bond of the picture of this issue?
> > > > I'll need to talk to the network support guys because they manage the network
> > > > devices and they'll need to change the LACP/Trunk setup of the above
> > > > "remote device".
> > > > I can't promise that they'll agree though.
> > We changed the setup and I did the tests with a single port, no
> > bonding involved.
> > The port was configured with 16 queues (and 16 XSK sockets bound to them).
> > I tested with about 100 Mbps of traffic to not break lots of users.
> > During the tests I observed the traffic on the real time graph on the
> > remote device port
> > connected to the server machine where the application was running in
> > L3 forward mode:
> > - with zero copy enabled the traffic to the server was about 100 Mbps
> > but the traffic
> > coming out of the server was about 50 Mbps (i.e. half of it).
> > - with no zero copy the traffic in both directions was the same - the
> > two graphs matched perfectly
> > Nothing else was changed during the both tests, only the ZC option.
> > Can I check some stats or something else for this testing scenario
> > which could be
> > used to reveal more info about the issue?
> 
> Hard to say, that might be yet another issue. Ixgbe needs some care in ZC
> support, I even spotted some other issue where device got into endless
> reset loop when I was working on 3 XSK sockets and I issued link flap.
> 
> I'll be looking into those problems next week and I'll keep you informed.

Can you try patch included below on your side and see if this helps with
your dead interface issue? I was experiencing something similar and on my
side it was enough to play with several xdpsock apps on very same netdev.
I'll be looking now at performance issue that you reported.


From ee409ba38c7e60e25e079acdaf2c00a6694ab4e5 Mon Sep 17 00:00:00 2001
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Wed, 14 Feb 2024 13:55:36 +0100
Subject: [PATCH iwl-net 1/2] ixgbe: {dis,en}able irqs in
 ixgbe_txrx_ring_{dis,en}able

Currently routines that are supposed to toggle state of ring pair do not
take care of associated interrupt with queue vector that these rings
belong to. This causes funky issues such as dead interface due to irq
misconfiguration, as per Pavel's report from Closes: tag.

Add a function responsible for disabling single IRQ in EIMC register and
call this as a very first thing when disabling ring pair during xsk_pool
setup. For enable let's reuse ixgbe_irq_enable_queues(). Besides this,
disable/enable NAPI as first/last thing when dealing with closing or
opening ring pair that xsk_pool is being configured on.

Reported-by: Pavel Vazharov <pavel@x3me.net>
Closes: https://lore.kernel.org/netdev/CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com/
Fixes: 024aa5800f32 ("ixgbe: added Rx/Tx ring disable/enable functions")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 56 ++++++++++++++++---
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index bd541527c8c7..99876b765b08 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2939,8 +2939,8 @@ static void ixgbe_check_lsc(struct ixgbe_adapter *adapter)
 static inline void ixgbe_irq_enable_queues(struct ixgbe_adapter *adapter,
 					   u64 qmask)
 {
-	u32 mask;
 	struct ixgbe_hw *hw = &adapter->hw;
+	u32 mask;
 
 	switch (hw->mac.type) {
 	case ixgbe_mac_82598EB:
@@ -10524,6 +10524,44 @@ static void ixgbe_reset_rxr_stats(struct ixgbe_ring *rx_ring)
 	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
 }
 
+/**
+ * ixgbe_irq_disable_single - Disable single IRQ vector
+ * @adapter: adapter structure
+ * @ring: ring index
+ **/
+static void ixgbe_irq_disable_single(struct ixgbe_adapter *adapter, u32 ring)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u64 qmask = BIT_ULL(ring);
+	u32 mask;
+
+	switch (adapter->hw.mac.type) {
+	case ixgbe_mac_82598EB:
+		mask = qmask & IXGBE_EIMC_RTX_QUEUE;
+		IXGBE_WRITE_REG(&adapter->hw, IXGBE_EIMC, mask);
+		break;
+	case ixgbe_mac_82599EB:
+	case ixgbe_mac_X540:
+	case ixgbe_mac_X550:
+	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
+		mask = (qmask & 0xFFFFFFFF);
+		if (mask)
+			IXGBE_WRITE_REG(hw, IXGBE_EIMS_EX(0), mask);
+		mask = (qmask >> 32);
+		if (mask)
+			IXGBE_WRITE_REG(hw, IXGBE_EIMS_EX(1), mask);
+		break;
+	default:
+		break;
+	}
+	IXGBE_WRITE_FLUSH(&adapter->hw);
+	if (adapter->flags & IXGBE_FLAG_MSIX_ENABLED)
+		synchronize_irq(adapter->msix_entries[ring].vector);
+	else
+		synchronize_irq(adapter->pdev->irq);
+}
+
 /**
  * ixgbe_txrx_ring_disable - Disable Rx/Tx/XDP Tx rings
  * @adapter: adapter structure
@@ -10540,6 +10578,11 @@ void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
 	tx_ring = adapter->tx_ring[ring];
 	xdp_ring = adapter->xdp_ring[ring];
 
+	ixgbe_irq_disable_single(adapter, ring);
+
+	/* Rx/Tx/XDP Tx share the same napi context. */
+	napi_disable(&rx_ring->q_vector->napi);
+
 	ixgbe_disable_txr(adapter, tx_ring);
 	if (xdp_ring)
 		ixgbe_disable_txr(adapter, xdp_ring);
@@ -10548,9 +10591,6 @@ void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
 	if (xdp_ring)
 		synchronize_rcu();
 
-	/* Rx/Tx/XDP Tx share the same napi context. */
-	napi_disable(&rx_ring->q_vector->napi);
-
 	ixgbe_clean_tx_ring(tx_ring);
 	if (xdp_ring)
 		ixgbe_clean_tx_ring(xdp_ring);
@@ -10578,9 +10618,6 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
 	tx_ring = adapter->tx_ring[ring];
 	xdp_ring = adapter->xdp_ring[ring];
 
-	/* Rx/Tx/XDP Tx share the same napi context. */
-	napi_enable(&rx_ring->q_vector->napi);
-
 	ixgbe_configure_tx_ring(adapter, tx_ring);
 	if (xdp_ring)
 		ixgbe_configure_tx_ring(adapter, xdp_ring);
@@ -10589,6 +10626,11 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
 	clear_bit(__IXGBE_TX_DISABLED, &tx_ring->state);
 	if (xdp_ring)
 		clear_bit(__IXGBE_TX_DISABLED, &xdp_ring->state);
+
+	/* Rx/Tx/XDP Tx share the same napi context. */
+	napi_enable(&rx_ring->q_vector->napi);
+	ixgbe_irq_enable_queues(adapter, BIT_ULL(ring));
+	IXGBE_WRITE_FLUSH(&adapter->hw);
 }
 
 /**
-- 
2.34.1


> 
> > 
> > > >
> > > > > on my side i'll try to play with multiple xsk sockets within same netdev
> > > > > served by ixgbe and see if i observe something broken. I recently fixed
> > > > > i40e Tx disable timeout issue, so maybe ixgbe has something off in down/up
> > > > > actions as you state as well.

