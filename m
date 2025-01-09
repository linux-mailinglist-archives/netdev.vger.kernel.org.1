Return-Path: <netdev+bounces-156578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F40BA0717A
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943F61886368
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1F3214A79;
	Thu,  9 Jan 2025 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkoABhZS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0825103F
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415112; cv=fail; b=eujWPEVn6BCH6SG1g2wsyWSQAC1w1AZHYMXvag/kZP+b0hA3OVnL0k50Zk1S+weVs/ytvuoNO0tdsC8uhd31kgz2GuX6mFMlKgqXd/qoSzbJ1B9E51TnX/LwxdXPOIHqORoDUMVtHMa63kGdebdPucqokGBQgPXsZdX/9r8MoS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415112; c=relaxed/simple;
	bh=yHi/mvD6+eW//9db1cooA8gJYdIqagTJTvgOc6nGyuM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ilHEflZsjOIoFPEJajkeT9ehqXKwDLLYvbO54tEqjayk20BT+fSIUcgDwpfd5x35HC0QOMW6J62qA7Hz4C0myQ7+2SKc7FnFpeJFMwtXhXt/7FMvq0zrvpT/nktscNr36WgsL8J+tfBSO6LVXb4AA0yB4PUdFor7nMzc5ztB/HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkoABhZS; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736415111; x=1767951111;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yHi/mvD6+eW//9db1cooA8gJYdIqagTJTvgOc6nGyuM=;
  b=lkoABhZS8xWli+pLAAqGG1IKG2l5wWC4HuuZ3zXUvL4w5/l6klMKeE5N
   FA1oKgX8Sgf+m5QNhxHPEk7y3KCQ5b49m4z4GgHoHZRYdTCF2p7685KEw
   +rzAqL9zWE5z8KVIHVRtuPzMJb2Ke0YipbQiaJ7BppLHsqb66AeIWr3kA
   ANV8MKaoCqRPT1ahPMta1JtHatfykJ+7YuAxZVpqCraL3IO0IL3INls7c
   5lDdRNIjNneUruhaKkyMVBPKt23BGpRMGupHcYC+2xJcd6/fLINOXuGvc
   wAi+BD93B/Awy5h7KB09KhehjwcYhFsb17f34PynqI670Tja4rAevQU/g
   Q==;
X-CSE-ConnectionGUID: UUuOemsgQNKwaafsK5d1sA==
X-CSE-MsgGUID: kcpC9kasRWmIHjRzZrhyeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36781685"
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="36781685"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 01:31:49 -0800
X-CSE-ConnectionGUID: S4AOCjrASYGJaxqaDxQrsw==
X-CSE-MsgGUID: vCEgSm+9QQ+w7uX3LJe42Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="103317790"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 01:31:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 01:31:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 01:31:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 01:31:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzPL9ug8lA4JEtnVSmB8PFqnJKYc5coh91UaEQb95ZZn6DotRspRxhMctUeOKppv8iWSUiRPQdmbPJFjmouO3Y/nTWYe93h3kaRooHZtE36RDJAPIbY7RixUqHRdyh9Y59CEBnZ/sSknQvnnxKHBInpgIGzlE85vn/3iFn5nNyQWyCHdIAqaEmR/fG1qsVnu6OxH8lhQycMYxq8QtPYdmney/FaZmBGxthl4HFByY4Gh1/akAv6PlXBXL9Cw649PraKEalo8lYbyJR/HvnCa7eXRIdgUOvmz8XydeGmIEsjtQQpfGRyj9YqboOuWgLvF7wTdKgflVJJn3Tdb57WFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3rclB9FT60nkOjk8AHCTSlQjEco92tQ03AyUZE3tM4=;
 b=ES1o2blAhpkYYedg+MKdHHvEIbE6X0yAC4QlRNL3towZkl53UdE17rdo8nZ2+sRG6wc1h0lcr/eT6vWB96fwe9y/nmbDuqsJb9ZC7ISIG8rl+5uOnRREPlOGIxBK05g462biX1x3le6y+RBIKgWtZbqAQEGDDxC1lGwQHArktbQ3FD5aZSKG73KGHivKOTUGIxGvGQuds1VI4gr/i5NXTuG4RKPKF5h3dm0GDzjOaL0rrKTLpmWCaPvTMFxmuGfuy0HPqbAXNcv9j5ah6VYg6ZDf08zEMzfgSSRWkIERzqYv94P+Ied5AX+oeJWEV1O7iSCyczCseTn/vRRdEf4J8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 09:31:40 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 09:31:40 +0000
Message-ID: <3785f913-cffe-4b12-8bed-0586fac16393@intel.com>
Date: Thu, 9 Jan 2025 10:31:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: fix unaligned access in ice_create_lag_recipe
To: Hongchen Zhang <zhanghongchen@loongson.cn>, Michal Schmidt
	<mschmidt@redhat.com>, Dave Ertman <david.m.ertman@intel.com>
CC: <netdev@vger.kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Daniel Machon
	<daniel.machon@microchip.com>, <intel-wired-lan@lists.osuosl.org>
References: <20240131115823.541317-1-mschmidt@redhat.com>
 <e6f59bda-9de8-3d30-3f37-3ab1ec047715@loongson.cn>
 <54c34e2c-82f9-4513-8429-9ea19215551a@intel.com>
 <f3f4f561-8402-d030-2ee9-38a80662168d@loongson.cn>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <f3f4f561-8402-d030-2ee9-38a80662168d@loongson.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0037.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA2PR11MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ae4984-26d9-4a5c-d814-08dd30906c25
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUMyZmM3MDZ1UlJ5VGVoeUhwM3U4WHcwRGF2RmpDcFBldTZGV2tDdTZDYUhS?=
 =?utf-8?B?MGtYZUZLTmNXNjJ1SjVON2V3c2ZpWThLTXBCWlpBbFVUZDV5N3VzY0xDSXpJ?=
 =?utf-8?B?US9xRUVhbFl0bWN4RHZKRW83RTFDWFVOejZ0bXB6RHFzVmd3YUF1NE85Vzc2?=
 =?utf-8?B?ZmR3RUdmY0g2SHdDQVNWNnVoUXZUUHh6cW9SV25tWU9wN0lTWDFwZEp4UXll?=
 =?utf-8?B?Vlo3aEV2ckRwbURXTGhkeThESnJBdUJ1Yy96SlU4R2U5eWFkQnJrNWNkZzNy?=
 =?utf-8?B?TkRqZm0xYzRCQStmejJXTWFFTXZYY2tTRFAvQi8vNmQ4MmJYUCtQM3BYYUhv?=
 =?utf-8?B?UGVxaXhiL0xHb3pKUGVTb3hhNmJxRHA2MWNkQ3FQRUEvcDdPMXJvZkJZK3JI?=
 =?utf-8?B?YWFnSk1IUmhLcUc0LzlHVE5NSDYyajBDRnlTSVp5TEVhak9qRmQ3S0tDZFZI?=
 =?utf-8?B?V3BiVzFhQk1pMFltUEd4SVM4VS8yaG0reWR4dFhodEZtVE5CcUw0T1Z3L2I1?=
 =?utf-8?B?WVR2SHVWRVlxclZmRFd4RUhFbjhxWjROT3c0TDhock5zNENuZlZtL3dHT1hH?=
 =?utf-8?B?NWFON1ovaVlJcjNQM2laUmp3MkNybWM2OHNwVHBpNW9SQ1pGUm5jdXdzU1ZO?=
 =?utf-8?B?NHdnNzBvQjdPbnBLZmZJcTkwaVY1Zy85aTcyNHQwQUdrWUYrdUoxMnkvMnRt?=
 =?utf-8?B?Z091a2dsMzVPMysvVWxndHh2U1RQSlBwWmtTVkJjOC9SU0hCbWZLYzdmU25u?=
 =?utf-8?B?OTJaM0Q2b0xRY0d1S1V4Zkt5VkRKU1VlTDZKcE9uM3FIWnJNay9oTFRyRjVS?=
 =?utf-8?B?ZG1WQjZjMUE3bjl0L05EVTNkRDA4Z2FCZGQvY2c5SzBiUVU4UTJFdlBMa3VX?=
 =?utf-8?B?dGIyM1dRSWlWYWVuTWhUb2pXTXFmWkVoR2pFajZYbXRSdW9veHBPcUMyTlhr?=
 =?utf-8?B?NGlUOVVmaHhLb1R5ejIvMWcvUjVJcFFlWS9mUnRPVWRoM2JWVzd3VTZpUXc5?=
 =?utf-8?B?OGFUMDdqYkVTZ0dtdlZMK0N3cUwvS090WHZDeEYxWlc4cEdiNFU4c3dVZmo2?=
 =?utf-8?B?a29Ec3lQa2FUbjZwM09pVDZFZ2gzc0VaaXRBYTVid3hteXJTQ29XN3RDTlhX?=
 =?utf-8?B?VU1rVXNHS3ZQT2N6Q25MM1lLV0p6RGJ2cGI3OUlZcUl0UzZ3OW9OdHNRTnBw?=
 =?utf-8?B?Z1FvVXpFS09HWGF0a2R3Ujk2ZkdiY2NudFFLZlZWU2hvQ0RIN2lFakZaMFpM?=
 =?utf-8?B?aDFmOFNtcWQ4SXhzV0dONWJ2S1Qxekp3Zmhia25NdXhyNmV4RjdOWHQzait4?=
 =?utf-8?B?b09YN3RKaGF5MmppNEhWY0NQcjFRVzJOZWJSUVJQNHZYQVVLZ25mSzZEcHgz?=
 =?utf-8?B?NWFLbzFiSHY5dVFIMnVyNXRVaHZUNEt2Q2FhR1pqZlppSUpONFlmUXl2WTAz?=
 =?utf-8?B?WGZKR29jOUtTNms0dU1jM05hb0hOOHFRdE1VSHRvUGxsQkF0TFd3L1lQWGZT?=
 =?utf-8?B?R2ZPZC9qRStZdmlsOVBXSkNaUHVCWEx5VjdVZXFPSUpJUWF0RXdSRDNibzRP?=
 =?utf-8?B?bjNERDRWS1JkUkRwenhNRjdKVFVvbXdrVUNHbi9ncGh3cXlLNGFmaUpPNlcz?=
 =?utf-8?B?SHozd3hmYnNlRXZDaXBTTys2RngyaUlNN1pkQldOWTBLU2lDMHJlOE9MNGFt?=
 =?utf-8?B?M1ZCK1pjR1R0S1pLT3RSbW1MNTNLeThFNk1oSVlEbVhVYzFXaHpyS2pLU3Bs?=
 =?utf-8?B?VGtQeXNrWjZERmJlWVptZkM3Zm13S3lpcDltdHlwak9MVFhtdHB4azJhckpw?=
 =?utf-8?B?VUlpa29WTWVnN2JLRzhSWkFKOE9zUlZ0YVkvZG1US0k3aWRsZHBndC96VGtI?=
 =?utf-8?Q?wfUx0t+2GJQ00?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUp6TjFwMlF2MGphQklZRm9xWjdEKy9XY3JFSXRIMytMd3NFcUJtYVZuY2M0?=
 =?utf-8?B?YlFNQzdZVUNjZFNrdjNnVTVaelNNR1FnWkgyNjNoOUMzNEo2VDNzSzhEbml5?=
 =?utf-8?B?d0l3RlFYWEI0RllYQWpEc2VGQVVqVlM1MFhraVRRUDJxY2xuaXpXNmpOWnNR?=
 =?utf-8?B?a3B3THZVV05LY21WdTZtSkpscVF1WkFKL05ydW5SeTdFaEdZVVBNUjNXN0ZG?=
 =?utf-8?B?NDRZSDdVZkJuUHRRbWtiZWdYajM2cXhUbTljaFBPSUZSc054bEdWUWlKNWFR?=
 =?utf-8?B?bDFBdk5wakxueFRHY3pKSUhLNXZtRmZOZVlxc3hjN0Y5dElWemNnSVVuWWY4?=
 =?utf-8?B?TE56Vi85Y2V4Nk5pZ294ZlFMd0pzZTJ2eW5QMlFDZVJFc1phV1Azb0cvQVpq?=
 =?utf-8?B?NWdpY2xEWDRCVEo3WS81aE5idFJYSVBFQ0ZiMnVZOU9vckxzK3h5N0dNSWFV?=
 =?utf-8?B?QW9KV3ZHMHdWVU0vSXNyeUZ1S1Z1OEx2ZmVtNDVaeXp5SU9nZXlRNzh1TDdK?=
 =?utf-8?B?MlVKai93MkpZcEdDazVOSHF5Q1dxaVd3S2lxakoxQTBBd1hxQ1JXRThiY3VX?=
 =?utf-8?B?cFpWblNTYnhncEhWNm5KNTJyWlRxTzFNTkx5ZmNCcG9FOC96aTVpR1NSS3BP?=
 =?utf-8?B?U3Y1RmhnSjZjTE1NK1kvdmVXVTRYK1h1TVh1aExQS2kvMlRzVW0wRGJaZGl5?=
 =?utf-8?B?allubndVUC9PZHN3NVBtLzRBczZxQ0d6Sjk0eTVGOE1MdnVGT05LUHVYcUdo?=
 =?utf-8?B?ZCtmRE9xRTNlKzUzNUtyVG1SYlM1QVBiODdKbFBoZ0JoblZwazNXOGRvRDda?=
 =?utf-8?B?L0J2bnl3QmhxcHcxTzVreks4Y25ZSU1EVVl2TzEyVmxWdVVodEorQXN3RFFN?=
 =?utf-8?B?ZVFFKzhZenZZRjRoNEk2aUpmRnVQSmcvd1d2U2svajhOU0lZNXlqUmkzcTlv?=
 =?utf-8?B?UWRJd09PZVRiY0pzUDFYdTdxWjNuTTREbkxkb21UK0lTSVpPRkxRbXFPalZK?=
 =?utf-8?B?c1Y2MVRhcFJ2SEdWZUx1OGZRdXZYNjR2TkF2elVFRWZKWFVUcDlCczNBUkdK?=
 =?utf-8?B?cEZ1WTJYd3U5VFJBRjJ1MWl0UXNQVkNyQ1RvYlpVVVZhaitRRDgwVllvVzZH?=
 =?utf-8?B?ZEVQcXJjVnl0OFJiUU9ZZUlFRDJNcmUycjZHYzZzbWZIUnB2NksyalltV21H?=
 =?utf-8?B?bTdxZHZKemYyN0UyTTNISFRrSUJzTkM0ZllQQ3JhbTU0WE8wck1pTyt4OUdX?=
 =?utf-8?B?aU9DRUNnV0ZpbkVtQ2JOaEluVnI3NE4yL2V3Z1ZQZDJvZmMwY1JjTnFROWdp?=
 =?utf-8?B?RUpjYnFRTXlhS0Z5RDZ2T05GM1g0L3g0ZXJJUWVMcFNNczZsUWpnaVU3b3lw?=
 =?utf-8?B?RmtIdVdtSnBKS0hWTDRUKzZ3SlA2SkpDZVU3QmlTaCtlVXFBZTZVelFzWHlo?=
 =?utf-8?B?QzZGWmJqcExpcEtZWC9RZ2xKOU1LbVNVVCtIbnZmWm9GQXJkcThuZDAvb2RB?=
 =?utf-8?B?KytHYWU2VjF6VHBLRUlwR0VJcENyZmVzYlRVVTdQZld2c2Q1elQwZHArcUFo?=
 =?utf-8?B?MGhsYTNvVXF3ZmNtOUFqMWFpQWxvQ0VwcjFuQjkvR0FDVDJmZVZSWHZ3WThv?=
 =?utf-8?B?TU53dXhkYTRlQnEzNFlsbmdPQnAzTGN5K2ZzYVRWNHhCMUZsdDJWb1p6akVw?=
 =?utf-8?B?cU14UjR3S1VSbExLdjc5S2FuNUY5Y2szREdPS1NVSHFFNXZyYlpvL1o3bFJL?=
 =?utf-8?B?b2hVa2VjZWVPTXdYTlBqRzAxNXI0aGVjRk92SlJ6WGJTaERmdEZZQ0dwaXM4?=
 =?utf-8?B?WDdlQmwvUFZIeW81elh2dUplTTlpVGxtU2xlZVFFMWlEcmlIMFQvQ25sNTdo?=
 =?utf-8?B?a1pqa2xBL0lreVVwKzFJUWpvZlhvZk14TFZHYkFMMXN0dWhBMFBKQTNPSmZ0?=
 =?utf-8?B?WmpoRUdBWjM1M2tvTEFMeFFhNEdJZEVob3pZUk8rUk8xY1ZGTS9UUlhQNkRP?=
 =?utf-8?B?SHZmbkNhaWxpRWFUNEpWSWozdlhKRDFYMHBCdEVGZUE0UUJRMXhTK1lGUUdR?=
 =?utf-8?B?TzFiblZRbWVPWFBlT3VkRHgxWGdEQUw4WW1sUEdaV202czFmZWtDUTFvbzRz?=
 =?utf-8?B?cWM0WjJ0cEFDaHR0VDgyUUprRHp5TWZuZkZUYzRFRHhpU3oxbDRVYVFjS2E3?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ae4984-26d9-4a5c-d814-08dd30906c25
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 09:31:40.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJVLzWa39QKRuAYfadIcIJM+okK/OXABipvvW3iaAk3L2wLZ4wk5k4tENcxgQuzkgqR7Jd00In4YBHxx1RJTOII1FofjRXmT8QRjiSdKYok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
X-OriginatorOrg: intel.com

On 1/9/25 02:54, Hongchen Zhang wrote:
> Hi Przemek,
> On 2025/1/8 下午4:59, Przemek Kitszel wrote:
>> On 1/8/25 04:09, Hongchen Zhang wrote:
> 
>>> Hi Michal,
>>> On 2024/1/31 pm 7:58, Michal Schmidt wrote:
>>>> new_rcp->recipe_bitmap was written to as if it were an aligned bitmap.
>>>> It is an 8-byte array, but aligned only to 4.
>>>> Use put_unaligned to set its value.
>>>>
>>>> Additionally, values in ice commands are typically in little-endian.
>>>> I assume the recipe bitmap should be too, so use the *_le64 conversion.
>>>> I don't have a big-endian system with ice to test this.
>>>>
>>>> I tested that the driver does not crash when probing on aarch64 
>>>> anymore,
>>>> which is good enough for me. I don't know if the LAG feature actually
>>>> works.
>>>>
>>>> This is what the crash looked like without the fix:
>>
>>>> [   17.599142] Call trace:
>>>> [   17.599143]  ice_create_lag_recipe.constprop.0+0xbc/0x11c [ice]
>>>> [   17.599172]  ice_init_lag+0xcc/0x22c [ice]
>>>> [   17.599201]  ice_init_features+0x160/0x2b4 [ice]
>>>> [   17.599230]  ice_probe+0x2d0/0x30c [ice]
>>>> [   17.599258]  local_pci_probe+0x58/0xb0
>>>> [   17.599262]  work_for_cpu_fn+0x20/0x30
>>
>>> I encountered the same problem on a LoongArch LS3C6000 machine. Can 
>>> this patch be merged now?
>>
>> What kernel base do you use?, we have merged the Steven Patches long ago
> My test is based on 6.6.61 which contains Steven's patch:
>   8ec08ba97fab 2024-05-07  ice: Refactor FW data type and fix bitmap 
> casting issue [Steven Zou]
> 
> It seems that Steven's patch can not solve the unaligned access problem 
> caused by new_rcp->recipe_bitmap, So is Michal's patch (may need some 
> change in ice_add_sw_recipe()) still needed?
> 

thank you, I see now

I agree that ice_aqc_recipe_data_elem::recipe_bitmap[8] should be
changed to __le64, together with updated accesses. Best way to do so
will be as in Steven's patch.

@Michal, will you be OK with us reimplementing this, or you want to
follow up?

