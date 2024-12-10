Return-Path: <netdev+bounces-150876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006249EBE04
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C181687A5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCCB1AA786;
	Tue, 10 Dec 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWWC+qdf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928B2451D5
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870782; cv=fail; b=Inf/Ff4X6NH8rWlOFRosXOG/Q5hTfq0gl+w7fgjK1IL73WiPM+ZfdzJUMpwqWncNbzQYMZOB+RbWr9HrTqmaONNmJ9QwU8Y7iie9F472BeSiX5Mvfddlp9BfVytNml9pXg25Qwx7o2CpljDOXwROiZkpcauWCAJ/NZYPfEYUVUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870782; c=relaxed/simple;
	bh=JSqfElxxUWceJlgKWaZmnqI+E7B2G/g3olQhn90eu60=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ugJbl12gjUj4A6W7UyJ6W/j1uw5m/hgG6vW0G67Z9EjXl1QSAi1val9VM7MwsZLsct4lzvLarAbvMzTt1IrQhSB/BWLUQbqMB9cNY9L+eSic5ueALK778v3qzLNhn8Nrvkxe/izv63O9IgRkJcpOMMTBXgs1MEfOeWrT3ksJ2LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWWC+qdf; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733870781; x=1765406781;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JSqfElxxUWceJlgKWaZmnqI+E7B2G/g3olQhn90eu60=;
  b=HWWC+qdf/XEsQCV23s3W6QVeMBAbb4470X4btWWkRfSSLpm7tvuZv60v
   PjPz2HU29GyaToMI7LNg8S+7leDPctkIF8XTZI1TsEc4NsLm4PobfP9cz
   8K4EY04mnPIDDG61OE2M7ABi4aeH1emFS9ciptUfGTvJJdBAEPcXcIKdY
   z3PbAmf2BqieZWZPRcQ1DJSvTeqQPFGakBi5j5CqdT1qA4b/tXrnFerLH
   /EjTNjx8EZ/hvdX44OIjepriKpXwoklNX+ZwkBd/XUT6SVDbk5xnXjXWd
   di5al+g/PUuJOW4uhjJHnqqZeZaFFnYodceq66eWojn2XSO7p3qjHkBYC
   w==;
X-CSE-ConnectionGUID: r9+oAOT0SFOHn5Gj/cZ+wg==
X-CSE-MsgGUID: B7yK6dR2RYae882UlMKdfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="56715362"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="56715362"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 14:46:19 -0800
X-CSE-ConnectionGUID: qtryc9cVStWEARI8h5mgHg==
X-CSE-MsgGUID: PZePBV8fQ12zjJC7Ylxzzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126380653"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 14:46:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 14:46:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 14:46:18 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 14:46:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPmmqaZrKisoVAHky78G8EKOjCK+RriWoeuFLOZStNDt3SnV3lraSGMnCtsjmHSama5HSFcaCEt35NSWudxs4Smy6SqFZnfSi6Pu+8a9rOO3D5GpRx84tODPRDGMcF9gWOHTCLxefQSm4hOdK2DOswk2TcnhOF3tLqnBfc09mltmCuIHErzuZ+O3WwWokuRnk6+hfL4qLEDZwns4rxo92tzUtiZ6YzwJSoHjHwx4CYLfDmBxVZkw4/jyTt30BNE1RSYVl92aRgga5+ACbC1y4CxSDB08D5oYKU86/Dok94vM8hFRgUXfdZHpYnifps5cONukSOq/5XPXtYofc1FmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoStRU9feSIAapa2SYJRYX6B4Su3/8gH24gF6M08jek=;
 b=t89Q2lahet99gtodEwsxQtXXwUhjEwvDFYBoW2rsWdZf1Y04RYDxkCV8YsZ8+boOT/YElwVK7hk//5QiuvsnzB4yeUXLOZN/iYPrDJCOeARnZIAUouzdJua/86QqXMGjFYHSyEtfdhOU1O7z/vH0OUcHp0mBwfv3VUKOGyYdHTvXIlkjiLl2WtCa7espJ+1DgRSq7eg92kTocI0+0syCb/UKfD687DVWp+H5qcNJs365BqNxA+TBzVOzIGPJ+ircecmzZ7lbcRL7vvzsGu1P39PbfXXDEVbSBvCxqddG1wPK68/O0FaoGubL0T4qRyscmS7dLgVv7dIHaCX/KkSK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8342.namprd11.prod.outlook.com (2603:10b6:610:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:45:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 22:45:55 +0000
Message-ID: <9f2df5cf-5e70-45ac-b1a1-a13af4ec5167@intel.com>
Date: Tue, 10 Dec 2024 14:45:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] ionic: Translate IONIC_RC_ENOSUPP to
 EOPNOTSUPP
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <brett.creeley@amd.com>
References: <20241210183045.67878-1-shannon.nelson@amd.com>
 <20241210183045.67878-4-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241210183045.67878-4-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:303:b4::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: ab245dcf-280f-46bd-807e-08dd196c6872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1BRZ01JV0hNekZjOU9wSVRMUUxDdXZnb21NRG9ZbENwMlF6VWVUR1RjSnlG?=
 =?utf-8?B?SXhhc1N1S2c3b3RVc1JVeG1sQTZ1MHNrb3lWN3hlMnVSNnUrYmhtb0NxZGpr?=
 =?utf-8?B?QitSNUZpUnA1bnJ1czVsdUhQR1NjMzhGcE1wTzExaldkbVlsMmF6eU9BUTdX?=
 =?utf-8?B?K0JHU3BKbjZnR2JpWjZVczBQa3VWQkVHL0hjT3dzYlM0aXgyL1pYZ1FPSzRB?=
 =?utf-8?B?MklBYVVGWGxVUEFJZUxUYUNTTDE5cEFDWE5VZ0RoS0JLVjVhZ2diUVFRRTRw?=
 =?utf-8?B?VkE0eXNpYVEzSlZ4T0pBNUYvUjQ5eFdZSk5VZ3JHYWpnQVpjbm5ZZ1RpYm9r?=
 =?utf-8?B?ZWJnR1ZQMlpOS0g1RmlIekcyM3EvY2hKdmJwbmpRVzgvSGwwL1JhNVg1ejJI?=
 =?utf-8?B?RzQ2RHVhK3ZxbDc4R2duZmJ5cXVGRXZrM1kxM3MxakFIR00wa3ZaQkNNNmtw?=
 =?utf-8?B?Q1UxeWpyelk1UjBsVFNzVzhtWTB5YitTNVl0RmovTWpyamdoMlJxdG91Mm8v?=
 =?utf-8?B?Y0l4R2w1YWEzS0NmSWhlQnJ6QjNoYXBZMkxHQU9PM2dyWGk1c21vZmROSlVR?=
 =?utf-8?B?TW01RTB1S3JnZ2xDaW5ITjRQUFlGa3RWM3dyNWJrYzhlRUdDaHFqOE1tNmxR?=
 =?utf-8?B?OXF0SkJNWTlMaG8wZ3RWZndOalJGbzNYOW1IY2pYWWN5YTNGcHpmTEVYS0ty?=
 =?utf-8?B?MFdNK2VsWDFDQzZXbG9KNEc5QWNYQmZaZ2ZSdzRUWkZLTzdaUlQ2dm5sNm16?=
 =?utf-8?B?WXdueDJrNFl1OVd4eGRSdnNiYkNqUjdNT2ZnZ1F0WnFJRSs2bFBtOVZwRzNH?=
 =?utf-8?B?YjNnb3hlQStza1NyQjc3U3ZPcGR5SlRCMGJ0d3RjcHpkOFVXWHZnWDhHZkpM?=
 =?utf-8?B?N1BGYzc0THdVanloQzNSSmZmRDUrV2l6UGxuay94dGRTRy9HSUdJdHR2a0pR?=
 =?utf-8?B?Nm9LWGc0T245YVNCYlVhRVYzWC8wZ1B5b0V4djZHcFk5eGpqajluZURKQURv?=
 =?utf-8?B?VVVoaWRxdUNRc0dGUE9WaVJZQnp4L2ZBZDBnVm5jY0VrTFZjK1U2QVlxaDFr?=
 =?utf-8?B?Z05idy9TZ3BtRW9BWExwSkY1cUVtUmp5YzkyM3VFVXFDMXdZTGFVVld6QUNm?=
 =?utf-8?B?dnBnS1hydTNTK1V4U2FTc2NzcHNYVkhRaEowUWdaaDMvOUc2YjNNM2xIOXdu?=
 =?utf-8?B?RndVMlhNY1lMbmVMZUZvVWYxL3NXeVpoQk5adHdueG5jdlRINXJqR0s3STB2?=
 =?utf-8?B?a3NYbjFBU1dzS3B3dGNlVkI2d0o3d3ZvZHdlcVg1ZGlHZktER0NtRFN0UVVO?=
 =?utf-8?B?dUF4MkNScUFHNFhOL2RzWER2clNnN2N5b3dSQ2lhbituRllBRjZvZXYwVkJ2?=
 =?utf-8?B?QjBJWnJHSythYWxGRDI0ZXYzSzBMM1NpZG9TbHNFamNrcHlMcVZTL2dHQVAw?=
 =?utf-8?B?Y3ZEdTlMUTRIWUk0cU9TZTJ0cXJJTFBuYkFodEtGVjdkRDFPWU1YdWg5bXhD?=
 =?utf-8?B?ZEhLYXE4cGF2TFZXcFNvQU1UTnU5cG1QRyttRmNVRUc4ZjZYMDdlWWYwcGpr?=
 =?utf-8?B?Vm85ditTKzZOeEpleXhUckMrY2pqdy9WRnFkbkdMNHJtLy93RUg4eExuVy94?=
 =?utf-8?B?T0RyV2lYL1RCZ0diRHhlK3ZzdVdFMFVic2FnZWMrVGx5ZnpYdGV0OENaUTRv?=
 =?utf-8?B?Y2JtUjEwd3dSYmwzNGFSdmwxRGdjMytScFhIdUFYVGFjeS9meXVuSVBhcWU3?=
 =?utf-8?B?RGE3R2JjckVRdEtveXZ2bkZEeXd2bFQwbWplZ0w4QkV3SkwzQ0dNamtxWW5r?=
 =?utf-8?B?b2p1RjAreVNJOGhoUHBidz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUpLYW53bkduZE0rNUp0WXNleVpOcmhWRWc4Zituc3VPOUVWelFORXAwbUw3?=
 =?utf-8?B?cFZjcWczUEUvY1Y1QnVJalVLak9rRHoxOVVYVmFVMnZNREFQTEYzOXpLYjVH?=
 =?utf-8?B?cE5DSzlmb0RvMGo1bXZoTXhuYTY1bk9MemdUUk5PYmxPOG5YMFpCK1FUWTgy?=
 =?utf-8?B?WVVpSWNTeHRyd3p4U05xclR6MGxFQTVJOVZBaUwwTitKNXJoM1lGOExnaUow?=
 =?utf-8?B?Vi95V3p6SVVSanlEZlRsayt1RERZcXh0Q1lVc2N6WmU3OFZtaDJGblBTM2Nj?=
 =?utf-8?B?TUVBR3ZmQmN6YU9icEVxUFE4ek92WGVrM29pNUo1a3hPeWZUN1pvQnRRWWpQ?=
 =?utf-8?B?SDVBUnFqaUFieE5pT2N5WUF2ZWtNeGl6cjhuUWN3amVvNDVBNFlXaVlPb1Jx?=
 =?utf-8?B?TVhMaVY3b2hrNHBPelV4Uy96aWxlWW9GZ01sQjJFTmw0TU1zUXRVb3o5cjN1?=
 =?utf-8?B?T3diK0hiSENxcktEYU1pZDJiVEhCWGI5d0psQ01kZHNMR2pVQ0JUcXlBRDh0?=
 =?utf-8?B?WWZpZXBZSHl4RE9aQjhtMnR5Y2ZVMkd4YzcrcUFzalBmNll0OGhrd240K1RQ?=
 =?utf-8?B?aDBNT0JIeFFWMzJhMnhBZ25wM1R5cU5ZY0JyeTR3ZnBuVVhYMmxLVkZQVmJn?=
 =?utf-8?B?M1MzMEwrSjgvVkpOdjhLWm5JT2pDRFZhTmFobk4vU1d4K0lLMDVUZzFNeW1m?=
 =?utf-8?B?enE3SHF4K0psc3FJODZxdUhtb3ZDSVd3VGdyczVTTzVtalBDa1FzdHlBZCtt?=
 =?utf-8?B?c1V0d2JydExvTjZKTmdZeTN4SmZ4di8vRHYrcUp4aEM5aG8vcmFNZ25qcEcy?=
 =?utf-8?B?cWM4UVJGazFCa2VneXhYYUU5T0E4WnZBbU1MMmV6ZEJUVVlDdFRwRkw4WnNR?=
 =?utf-8?B?RTdNVStmUGZBYk5KN3ViYlZ6NUg2YlIrSXI4eUtWWkF6TjU5Z3p3WTdSdUY4?=
 =?utf-8?B?NDlCbHdsZC9obW5zSEIwYllsamZWYUxlWXlpQndCVkQwakxkSUMwT1B1N2FL?=
 =?utf-8?B?d3FybVNZVXpTbk8wdER3OWJFdEkzU1NNNmluUW5DZmh5dVdlVEFNdVJ0eVVI?=
 =?utf-8?B?dGVGaFNqMFJJZEdXcTlHcEVyWlRlQXB3clg1VlRodEtPbkgvcVZ0bERlVVEz?=
 =?utf-8?B?eWROTEpPSU1yZUhlSno0NTR6RTBueWNXSXpwSUxTYktvMVN4alZ4ZE5wSjBq?=
 =?utf-8?B?VkltZXpJV01HdGhXSldBSm5XSldTOUFQK0VPOW9lK0wvS1lWd0N0QzNjakpC?=
 =?utf-8?B?NmNabnpVUFFoY3JKQWpvUlhNM0ZZeTB6bE9Sa1UzVHJ5QUdWdkhLbDl4SGwx?=
 =?utf-8?B?TjBWdlVacnBGRFBUMkhnMDBYbVJ6QU9TT3FtSTQyajg1dTBOc0FxSVlkTGRV?=
 =?utf-8?B?TnpzSHRwYzJKSkdUZ3JxZ0ZHR1cvcXhpc1NMS0tvUys2UnhUZHdBZktSenR1?=
 =?utf-8?B?emJhWWJxRGFBZlp4L1BOdG5MVFkvSmV0NlBrUjByQnpjZ05xMEdpVWxBT1Zz?=
 =?utf-8?B?Z0JKbHcwR2VPSFJXRDBPa3BDS3FnWXpkWXN5ZWVVU3BMNWd0UFlFU0RmUWlX?=
 =?utf-8?B?MnNHcDJHMjhsZ01mcTlZZFNYL2JKY0ZFUStJc1hnT29VSUQ0b1Y3dm55RXRz?=
 =?utf-8?B?Z1Z0czNySU9YNDFaeGorOVRnUXFtSDY2eldWMXNQVlphdGw3dm1jbGpGWG9z?=
 =?utf-8?B?NG02ZXdZWGZpbzNBVnlEVVNjWHBLSDdKcVUrRnRFRmIwaUxCdndRTHVXZXg2?=
 =?utf-8?B?UnJ3VE80bGFhN28rVUV4UXhmMGowRUhoUXpKOVR3RS9MMlB6SDh6djcwM1VD?=
 =?utf-8?B?d3dZbmZIRE9BTysrK0tkM3cxb1hIRVhUSGVZNll0K08vOGNYZmVvSElFL1J6?=
 =?utf-8?B?QVZVN0JpTmtnbjE5Y2JxT1Vhc3h4N0dwa0tNMUxrYkFsZHRONGFCUW9mcXRQ?=
 =?utf-8?B?SVFlQVVUSG1hWXpTcWRWVmVLc0k3RGVIZTJTMUZ1MVRDVVV6b1Bob2NkVXI3?=
 =?utf-8?B?bEdWeDdoZzNPMldITkpoOGdkVnVxTW9IeFk5dERJTHU2T0h5VDkwQ3RoZEhy?=
 =?utf-8?B?aG96dGtleHEvMUQ5SEJmd2IwWXdSZDI1cHhaM3lHbnhLRDJhazhGZ0VuQUNr?=
 =?utf-8?B?WG9zNVNMU3ZGcnBzbFBSVFExUWViZ1MyQ25nczNXbzNNcWZLSzYzdmRxNHJG?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab245dcf-280f-46bd-807e-08dd196c6872
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:45:55.7164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUn1KAyB3cKPRBZFDxNAxfii2rMxG0MaW0vCEN1dGJKh7nRV7TeYZLQmF+vCYnN0tFUlqAAlhPbDsPyTkXIaDNzqQbzhcMJFkXPZOvAfW5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8342
X-OriginatorOrg: intel.com



On 12/10/2024 10:30 AM, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> Instead of reporting -EINVAL when IONIC_RC_ENOSUPP is returned use
> the -EOPNOTSUPP value. This aligns better since the FW only returns
> IONIC_RC_ENOSUPP when operations aren't supported not when invalid
> values are used.
> 
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/pensando/ionic/ionic_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> index 0f817c3f92d8..daf1e82cb76b 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> @@ -81,8 +81,9 @@ static int ionic_error_to_errno(enum ionic_status_code code)
>  	case IONIC_RC_EQTYPE:
>  	case IONIC_RC_EQID:
>  	case IONIC_RC_EINVAL:
> -	case IONIC_RC_ENOSUPP:
>  		return -EINVAL;
> +	case IONIC_RC_ENOSUPP:
> +		return -EOPNOTSUPP;
>  	case IONIC_RC_EPERM:
>  		return -EPERM;
>  	case IONIC_RC_ENOENT:


