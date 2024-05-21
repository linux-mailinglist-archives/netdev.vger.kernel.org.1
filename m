Return-Path: <netdev+bounces-97403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 170458CB50B
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 23:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C23B20A11
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 21:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFCF146A97;
	Tue, 21 May 2024 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsSnbtqg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F750276
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325541; cv=fail; b=gYvvkS8xVmzP4G7kZ9fIfu9rdIfqI0I5WyfMPaN0e8+9oTrfCAb33G6DHJed4c1Qyh2GaM8G4WvfVAeFvshItagwgshw7CmVXyCjK4J/WUtdRy3OmvOE8DVXRpJYPWiI6lFFZnsOy2NxgVerTgTfc0pgquZtMlah5bdbwQShgdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325541; c=relaxed/simple;
	bh=BNA7XnDecPxfmpzvgkwc23IAtopmwSlCzfPhypdNucg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zm1KUDkb7v4/Y2PXLMNoJRUiSAja+AVwL1tSEFvQk0J6wIC0ZfcOlYEmrpnFY+hFjxSEmVs5qdsfCM5+Wd5VN5H1diLEa7MYgdTY+137Pci/MCyX1coAyKENlcTqgrYAMI37c5SCGa/aIXYG0C+DNwrFj60yM/XVWpZZOLQlgMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsSnbtqg; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716325539; x=1747861539;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BNA7XnDecPxfmpzvgkwc23IAtopmwSlCzfPhypdNucg=;
  b=hsSnbtqgfZVDrCx/koeLlvP/lHzC29KJHlrCyRjNMp+HWMVS8hACehVQ
   pCBWuyrqm0ptiQlsWa6KwA7q1McTudmqKQr/pjp/NWEvAXdUuFeeycPcL
   VrKkpk4mzCpWCRKy9FGbVg8wEORuMzgu9CvRB8R8LSqTcC/wbWkpmB4uu
   DhgBkSRmygLo+pj4DkCqyHQUbu2A9DHi0kXpNAFeLgRpg8YjWpQEvGIiP
   N1aWZN91ADhtICiwxvCxVyC0k2nQc86DmfH8LZ7CVLK3bawtAmvUsCFPH
   782ipvyBAurG2d7N4NIYL9fc5SI2WeSuFiWBXX98e6vMUslaBC6SXn/Fm
   g==;
X-CSE-ConnectionGUID: 6gL1KczkSi6LTZdGJFt9Ew==
X-CSE-MsgGUID: fwQh/NejT0mcWjjW+A0B2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="16386303"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="16386303"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 14:05:39 -0700
X-CSE-ConnectionGUID: 74MeksfpSr6KG25FHStkqw==
X-CSE-MsgGUID: MKwZQTfxRiWdGW/fw68kxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="38008652"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 May 2024 14:05:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 14:05:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 14:05:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 14:05:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXhQhz7GSLnha0rlaunyEIDKSy2kG6reW2VPZ965K0G+Hjqzpg9TucryPdC21lgoRMax+8mXF9+qYJZNueXMVQX1zuCqSAUzkzDDFXfTBjZ+ds/W0cHnAhPPqu2nRKpJu39l4d6rz9Pl78xgXa6a0aYF6mX8u7PmXKDmqGAdfWt6/1St7uKgcPpvv9lp7kGCiV23thX5P3DNEXs7oN2ZKTXCsaxhQ2bIJFoD0hDWJkDK3qo0IvIoKDF/DVvPHlcZD4XfzCySG6eb4NFctNDDg4QgIVyrwGwnHTJetuQQoUqXkFl0BJvfIeLSUyUDqEOtA4ULRAKksVYVMcs4NOUMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X779++5TYCgl6VqtvsURWOIKON1pBaju/cIgpa/cnu4=;
 b=U+LMBKg44bZ2+dthv5wWj4dZrY91V+KJfz4IYzCjuvYK9jCgNhbHpoOI8vG8eeWTWcI+f2dVq1zyZpR9XG8vmJLKFDrqN1RAafywAwPYnC2U7RlSf/dWMxbRrmVptBecDU0j5NY2SXIJTKm+6mO1Iy/zdjk7BEiBFQHs5fRkWUOUTIIsCw1NEFxUmJxnFtiReQV+8dIRdhCTfwEsb1omOdeU7lpaEGnSyMW2vtZtAjtrk0OVJs9qCD3kqA7gP0Z/CKdyS84C0MzrPU4PqQ2umAYsd9yaXc/QcwIerU/ziQ1KIHmFieDDVATSj36I4S9DEVXNj3FAz2s1MRNf1VBDwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW6PR11MB8337.namprd11.prod.outlook.com (2603:10b6:303:248::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 21:05:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 21:05:30 +0000
Message-ID: <c6519af5-8252-4fdb-86c2-c77cf99c292c@intel.com>
Date: Tue, 21 May 2024 14:05:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
To: <kernel.org-fo5k2w@ycharbi.fr>, Jeff Daly <jeffd@silicom-usa.com>, "Simon
 Horman" <horms@kernel.org>
CC: <netdev@vger.kernel.org>
References: <AM0PR04MB5490DFFC58A60FA38A994C5AEAEA2@AM0PR04MB5490.eurprd04.prod.outlook.com>
 <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
 <20240521164143.GC839490@kernel.org>
 <1e350a3a8de1a24c5fdd4f8df508f55df7b6ac86@ycharbi.fr>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <1e350a3a8de1a24c5fdd4f8df508f55df7b6ac86@ycharbi.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:302:1::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW6PR11MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 396e0b0c-0fa0-419f-6a57-08dc79d9bf5c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1lya1hGTm9kUVZYeXkxL3dZRGtwZ0hlczJDTmYwTFJXK1lTbCtka2djbDVa?=
 =?utf-8?B?TzMxczdGamZad3lqcU42ZzFzRE1CeVFOQmFFWHQ2VVlTOUNETXU1MGFHWFlP?=
 =?utf-8?B?U3laSEk4dFRiMjA4d1VDdzJLa0MycjhDNzRKUDM4RVlJZ2Q4KzhRb3lrcWYy?=
 =?utf-8?B?cEh6SHo5R2tRZzlYNEl5V0NPU1FCR3hYWVlVUCtyRW5heGdNUVRVck4raU5L?=
 =?utf-8?B?bVNDZHM0N1NOQU5KajRoVG0rQnVWcVUybTJKdmpEUGI0eGFOWGp0Ny9pUEl1?=
 =?utf-8?B?Z0ViWUFJMnNxK2w1Q0hnSFRlY200VGo4OHVZS0JWa3dyN0wxQ2VpdVNoR2I5?=
 =?utf-8?B?RXRSRmVPR2UvcjRqaHRCTG04c09kQTlSR3cwc1VUL0VGc0JzaVF2TTB4ZWtZ?=
 =?utf-8?B?ZSs4TFZiNm5NVjZFY29vOWRscWRTWVZYdlo2L1QwRkVDMXFvNWJSZWhWNTZs?=
 =?utf-8?B?cTEvZ3JUQU9BRUtxSkJuRVhhbW9wNk1Udk9ydGVQTFM5UXJmckNNQlY1SG4v?=
 =?utf-8?B?T3RJTUtkbjBHbDN2cE44VDZjcEJCbmdMaXNrRS9zeXNUalhXUXhoeFhBU3VO?=
 =?utf-8?B?RkZZdkYwU0NlUjdYaHNOa2Z1bFErcTd2eUQ4MGdCSFRDWWEySnpqSXUvZFNH?=
 =?utf-8?B?Wi9EMjBrTG05cU5ySm41Y2dZekZid2Nub3F6MXlNNjJSd3BEWllyMk8wWmF5?=
 =?utf-8?B?aWluNFFpMUl3RHcrZzk0RDcrL0U4MEFrclJCSnQ3Q2VmdHRwSkNOYW1KbWtD?=
 =?utf-8?B?aHJ1dzBZK004VGp3aVhJVUY3Ums2K2ZJY21iUDdrS2plSlJPMlFHQTltYStQ?=
 =?utf-8?B?ek1ZbTROK1IwNHNMYm1ieGVJT0lBc1dVTG9Wa0JVZ3JvcDczbGhJYmFhYmJZ?=
 =?utf-8?B?U1R1TTE4cGRGR1ZBVm9qTUtTQmVzTTRiNTVrQzdVUzNUUjZDQytjSE14ZEZM?=
 =?utf-8?B?WmZ5WHJyS1QyV2lVc1diQ1JsSS9ONUpvOUJ0QThtV0RZT0FGV3dIdU9TWjNR?=
 =?utf-8?B?eVFRNDVJVkJJL01BQUFQckpDZXRYR25pejVUSHZMUi8rN0lCRWxnTElLaW5h?=
 =?utf-8?B?dHpsRVBrdkR5MDFoeHh0bTVldlAxQ0hhd1V0dlJ0YmQ0WU5zQlE1ZE9JTDA3?=
 =?utf-8?B?bnlDUmVCVUhqaXkyOFNkRFpBQjN2VUFOYUdPNUlBNTEyaVY4eWRCcEhvSXpE?=
 =?utf-8?B?R1BuU3BYeVcyd3VGZm5pdzNTcW1La3VNdnQyRzNvazRCRWlMd09RSlBGYVND?=
 =?utf-8?B?eXVnMmRmRkxzQ1NhbjNnKy9samcyYWliNjZYZTdkZTNkVXFmWEE4OWp4M01j?=
 =?utf-8?B?U0lXU3VlVmFQcU5xZmhGcjcrS01YcUVTUUwySWxnTjVVY3lTbTd6V0dVMGhp?=
 =?utf-8?B?TzZ3RGxHdTdaN292RG5zbEovY2k1M2xYR2FvZTg5c202c1R5eDRGLy82YUZv?=
 =?utf-8?B?STZiMHcyeEdEcHQ4WFdEWGVyamJ1V2Y0TmFTQi9oRVMvTVZvS3U4dU5la3RN?=
 =?utf-8?B?akJpVkJ2bFlzbjhMMHNVOVdNOTJSd2QwZFFhRGtmN3h0UUI3R3pNSW51UER3?=
 =?utf-8?B?ME5xcFA5YkVJcjN3N0J1VFZKSHpKNDZqTVBiUkRtTlpDVmhKbmJ2c292Vzkx?=
 =?utf-8?Q?42Y2yAqTktSDFnyA8DbtdbdpU+wLc/msH99iXXa6Ihpo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEZnTHkrTy9xUXFEY1hLZ2hSRXUzeXhCTzNOeGRsSXRuMmpJRDBtRWV4cFcw?=
 =?utf-8?B?S3FGTWlkVGprcG1GczlwNGpvQlFqZi9UV29aRm94eG9oT1B6NjFDZ3Qrb1h4?=
 =?utf-8?B?QVFXOVZUQk9qNER5Q2lNeGJ1WVNaTnpqdERiZkE5M3paQzBFb1lJUWpqcGVu?=
 =?utf-8?B?bUZtWnRGOFlGZFlkbW4xbUlpdFNwTXp2VXdOemZteE5xdWx4T0g1VkUweVlq?=
 =?utf-8?B?N2xWbEJVM3hDdnFmYmJ5OVBZRlltbmVaVHQxc2dram0xamZOVk5Nck1aSlBE?=
 =?utf-8?B?Z3U1eWtsdDRXWEFRRi9EWWk5NEV6VXBSejlNNlZkMFUyRi9VZlBvSUE1OURp?=
 =?utf-8?B?UE9QY3VOTnRMbUpzelNYRmNrcFVndHc1Q3kzdldyNEVEeVJlcEIzZzhVdUgx?=
 =?utf-8?B?eDZtaEF4MEpvZkdhTU84SENGMmdpMVQ5RjR2Yk0xNTVKWDVCRGEyYm5GRlNx?=
 =?utf-8?B?MFkrRHZSaVZYRjNuNSs0K2hmUDc3ZFF5NGEwNjB5cWlNbWgvVklFUWtiSWo3?=
 =?utf-8?B?QXFKZUc5SnJBeUJUSzZjaDNzQXBzZW1rMmRSTnB2UzZDODRtQ0V1RkJRV05Z?=
 =?utf-8?B?aTVPWkdncC9ieWN0RnZOaFpCSm1JR1JnSE9uS1FkN2IwNEVHY205TnV4VkN0?=
 =?utf-8?B?VFFrVVVMNXF3aGpNa0ZVTjZWeFB4dTNSMFB4M1FSV2FmMUQ2d2t6YzA2cGRV?=
 =?utf-8?B?RkxqOWZ4d0cxcEFRUTBTTDlaYWtCVUV0QmtDQk9KTkc3TUZCc2kxbUhLejBj?=
 =?utf-8?B?a0NaemJRbVAzWDh2THhFVjdvWVpucHprcE1yUm1TdWhaSVZib0thMnhUYnd2?=
 =?utf-8?B?dkZURnNjZnVCTy93RVBqa2R5VSt4YVVoa01NVEF3NXFUNldiV04wcmtYc0Np?=
 =?utf-8?B?Skxqbk1lUktJck8rWU1CMmlDbDhncEI2Z0lEMUJrZVpzZjNwUHJsRDhSYzNM?=
 =?utf-8?B?VTFENThPQTlNdzJYaXZ3QkNYRkVhTyt0eUwrcnViNDRpU2tzdXY3S2h4QW42?=
 =?utf-8?B?SlpLZ0toRjN6UWNpNWNPUHkrU3FPVXI5K0tkZmhkODFuSE5FTE4xbHRUTUV6?=
 =?utf-8?B?L0xYdGt4Qy9ZcnQ5WkRPbnJrbmpLYkNIUGY3ZkQ2ZGpjckRhbmh4d2laT3dx?=
 =?utf-8?B?MFJDbzNLWWVuNlV5cG5FaVM2YnNaM1cxTlJZQTVVdVYrdkhLbGFTcVhxdlNm?=
 =?utf-8?B?TTFvY1VBS3hVVFRySUNSbjhFYWlxQ2hxQ1k0cWs1TiszbUE5eG8yNHo5b1gy?=
 =?utf-8?B?N3FzTDZpRlpwMFBUaWRqSU1RbkxKeVVEYm80b3hDNWROenVtOXl3VTd4S01V?=
 =?utf-8?B?Qi9uWkRFWFBmWXBkMFVIMVNZdE1hM05pM09qaE0zeUJTaUV6R0IyQm14b21G?=
 =?utf-8?B?UXBZbTEwZTc1Mml5b0ViMTB5Z2tlckZpTi9wSHAxZmZBeUFUOU9kaFpTQlY5?=
 =?utf-8?B?RklTTmJ0Zkl1Tlk2aU5yOHZlWWhWUmRsVEhKMkkvUnJDTmVTVXpzVXIxa09C?=
 =?utf-8?B?K2UrRFZCWEJZM3Bpc3pZNmtDNmN5b0t1RUlRaHBCVEhIOFJGTFJIcWlPTFRs?=
 =?utf-8?B?ejA3THJPdE1ZWmJ4NnRpMDl6aWkvZFlCR05ERXVmU1lleUxWS1ZMeU1ZdHFK?=
 =?utf-8?B?M0ZFY2JzTXZyUmpmdlU4VlpURU8vUCt5NVU4eGVSQnNxUktpZHg5RHdBM3hW?=
 =?utf-8?B?TmFNSmZBQjBRQ0hvQTNnbnZ5WjJlQWxCcDVpQmtxY1IvVlY4NDVqSWdPUHpa?=
 =?utf-8?B?ZmtBd0NqbU9GQU5BZFAxcm9DTTJSS2tKS1ZnWnpzQndMTFVvNjhvVEZLZ2tG?=
 =?utf-8?B?WllXZXY5Smh2bFdBK3VkZGtOS0lsL0kvWVJPVGNScjR6b1g1YisySDVqSGxp?=
 =?utf-8?B?NnpuSTdIS0FsOXMySlNqMFF4amY1V2M0ZGhWN0R4U1RkdlhwQ0xDZ1B3R0pl?=
 =?utf-8?B?dUcvK0Q0OFhRR1JOV2VGN0RxWlZTMzlxL05wVTFObFpHSjEzWWlDQW52Zlkz?=
 =?utf-8?B?NkhySC8xbzVySG5zb3dHNEtqdjNZSEg5VzU1dzNxR1B3UUkycitWU0MrcDd4?=
 =?utf-8?B?SHZWZ1NtVHhud05OdGNZTGdYeUJONWg2WGhVdzgvRlVWYnh4UDlHYW41RVEz?=
 =?utf-8?B?QTZabURDODRDc1E2RnVnQlVDaEpTRCtaaEhrQm5GOUxaUUpYaWlSK2dzc2dG?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 396e0b0c-0fa0-419f-6a57-08dc79d9bf5c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 21:05:30.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4gioo05OkeZvIZ7bMQAATxaWRDIJ+L+ylanocQ/6IiXG7ZanxZ3m0U0hrT2CwjVF3oX7NR9nwTLvuCn6UbC5mYSck//vyqbqFPYpw72TqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8337
X-OriginatorOrg: intel.com



On 5/21/2024 10:12 AM, kernel.org-fo5k2w@ycharbi.fr wrote:
> If any of you have the skills to develop a patch that tries to satisfy everyone, please know that I'm always available for testing on my hardware. If Jeff also has the possibilities, it's not impossible that we could come to a consensus. All we'd have to do would be to test the behavior of our equipment in the problematic situation.
> 

I would love a solution which fixes both cases. I don't currently have
any idea what it would be.

> Isn't there someone at Intel who can contribute their expertise on the underlying technical reasons for the problem (obviously level 1 OSI) in order to guide us towards a state-of-the-art solution?
> 
> Best regards.
> 

Unfortunately I do not know anyone still here who has the expertise to
solve this. The out-of-tree ixgbe driver does not have the fix from
Silicom, so from Intel's perspective the correct implementation matches
the need for the Cisco switch...

> On 5/21/2024 9:49 AM, Jeff Daly wrote:
>> 
>> 
>>> -----Original Message-----
>>> From: Simon Horman <horms@kernel.org>
>>> Sent: Tuesday, May 21, 2024 12:42 PM
>>> To: Jacob Keller <jacob.e.keller@intel.com>
>>> Cc: netdev@vger.kernel.org; Jeff Daly <jeffd@silicom-usa.com>; kernel.org-
>>> fo5k2w@ycharbi.fr
>>> Subject: Re: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
>>> partners for X550 SFI"
>>>
>>> One of those awkward situations where the only known (in this case to Jacob
>>> and me) resolution to a regression is itself a regression (for a different setup).
>>>
>>> I think that in these kind of situations it's best to go back to how things were.
>>>
>>> Reviewed-by: Simon Horman <horms@kernel.org>
>> 
>> In principle, I don't disagree.....  However, our customer was very sensitive to having any patches/workarounds needed for their configuration be part of the upstream.  Aside from maintaining our own patchset (or figuring out whether there's a patch that works for everyone) is there a better solution?
>> 
>> 

We're somewhat stuck between a rock and a hard place here. I don't have
full context for the problem, however I did manage to get a little more
info about this from internal bugs.

Here is the facts as i understand it:

1. The Juniper MX5 switch appears to require clause 37 auto negotiation
(AN-37) to link.
2. The Cisco 3560CX-12PD-S appears to reject AN-37 as invalid and stops
trying to link if it sees it for this case.
3. As far as I understand, AN-37 is intended for 1G links, and is not
generally supported or used in 10GB? It looks like the way this fix
applies affects all 10GB SFP links, which results in the issues with the
Cisco switch.


For context, this document was the best I found from a quick google
search: https://www.ieee802.org/3/by/public/Mar15/booth_3by_01_0315.pdf

It appears the Cisco device is linking at some form of 10GB according to
the bug report here:

> show interface status | include Te1/0/1
> Te1/0/1   --- Vers Qotom --- connected    trunk        full    10G 
> SFP-10GBase-CX1


The link is an SFP-10GBase-CX1?

@Jeff, can you provide any further details about the Juniper MX5 switch
case that the original change fixes?

The function being modified here is the ixgbe_setup_sfi_x550a, which is
called for setting up SFI, and the description says "Used to connect the
internal PHY directly to an SFP cage without auto-negotiation"

It is only called by ixgbe_setup_mac_link_sfp_n which is supposed to
configure the PHY for native SFP support for IXGBE_DEV_ID_X550EM_A_SFP_N
(0x15C4). No other device type is changed with this.

Every comment here implies that this has no auto negotiation, which
makes it extremely weird to me that we try to enable AN-37 in this flow.

Without more context, my gut instinct is that the Cisco switch is likely
following the general expectations here compared to the Juniper switch.

I also don't see a good way currently to have the driver select between
the options, if both cases are standard SFP. It can't know what its
linked against. If we try the AN-37 flow with Cisco, it essentially
bricks the link until a reboot. Even reloading to the out-of-tree driver
which doesn't do this AN-37 flow fails to recover link. This makes any
sort of "fallback" mechanism unlikely to work.

Unless we can find some obvious way to distinguish the two cases, or
there is fundamentally a different fix for the Juniper case, I don't see
how we can support both flows.

I guess there is the option of some sort of toggle via ethtool/otherwise
to allow selection... But users might try to enable this when link is
faulty and end up hitting the case where once we try the AN-37, the
remote switch refuses to try again until a cycle.

