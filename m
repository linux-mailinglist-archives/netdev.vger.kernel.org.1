Return-Path: <netdev+bounces-120594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC56959EAE
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D532825F1
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D94199950;
	Wed, 21 Aug 2024 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvNoDNJX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB831D12F3
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247076; cv=fail; b=nk7NOudu66baUJqmhqRRZK01dosaChvklaDn/0dptqw9T7zeLmx3Ru0ZOK8Dszj2i6FNun8o+hoj6QlrNbY6TdXFW8V66Z3oBM00YZzEEF/3vKcTzZkvmZ02638XhSB/Zk26JI859G62awN3sMv7eOuRQAWs+jDz4/4F04Q4pEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247076; c=relaxed/simple;
	bh=Dm2YBHVdVCuqq2vignamqKO78xcfnhFuXt4s1RxKt4Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lrmE92CXI20MGL7y6/oesM2zXndH8ANqRl+vt8VSV1XpXSHY5+MFpYnpgbQYeX+aX1Z7TVEMz6q77COQz02LQoxPU+nPXq4s3tR4rCN8SRFwHAvTnyhmGf72c/nSmVw4bGyvhdc3SubO6PSq9tTieJa8teTK3vIz3Z5Fux1bnrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvNoDNJX; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724247075; x=1755783075;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dm2YBHVdVCuqq2vignamqKO78xcfnhFuXt4s1RxKt4Y=;
  b=PvNoDNJXRElqufw2eqJ1irX0BtjXaLSxyQBqGD8CQZiZwFLEVg7tqa8e
   H2NXEtoG3p4aiQOVCvpbr2NLEVzGpwQbmEINmxcQgWB3nSd8Q+mHHGVL3
   VYvMS/PtVjbHOm1bP0iTqtrM8GDKMscLEbr8eU/RFhaBqpqD0cJVlTYLb
   qOMdAHF8vkhqxtC/S2uGP//3xOmcmUjic3Q004VhJrtUQAvHr5f2iRU9l
   CvEKUQ1btW5mIqV6y8W0+DEJFphzBzXGKnR3/40JIecP4ldE4BGzzf75b
   ZCoHJdiIuGkzOv/cSRsMaq3t1iJKTnCr45HADUdYfZrkHBfjdjX0M7wE1
   A==;
X-CSE-ConnectionGUID: oC1pVbz1TUGoNYPO3968/A==
X-CSE-MsgGUID: AEPPb03xRbOOfYD+tBvgnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="34025405"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="34025405"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:31:14 -0700
X-CSE-ConnectionGUID: GIXbLQ6GTamNkkimjJ1ozQ==
X-CSE-MsgGUID: 157H25MKSJKTM8NT6owyIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="91836740"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 06:31:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 06:31:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 06:31:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 06:31:13 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 06:31:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBtZujUh8qvkXaQ7Utd8DtBB8hpe7wfMKYDeHOjXg4odNgkeSpxTf/aueds8vxWWM2jiz1zfYqPh9M6NTwGfjkEyB2iUEV5tpoCj4RPZzRIVpaYGgjOQ9/d4Yul9UV1ziWjtM7cRcEpLkaRt2agML8m85gbOS3sAu1YGqk3ssM+WrkXwORZ1lKf2JjUwSD9qKJtD0hCDQDAZiQfVVbyrHxeUGt/avTG4ZJ1pyScg+LRqVyJNbU+c3jLdRjQIzrIt17cFcN2LhFYwRfEiXoOWmzeuTYN7MVwrfcBvHL8TTbVV7i3br52Ob2zAEOqkx5HsmfUVPtWmNBCDU6LRH5crYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANoxLidi5+BexIHBuBMWC376lUpFtd5kNEB0YYJfav0=;
 b=JFjjpucTP43R0MBKxVpNgyC7s+G7xGbvHruTmpYGFAtE/BwtusMJ6OCN9FznrB7hPXWWTBWQGOW+UdNjwAPyyV2Rx57HxKjMJ5lBpsVnN0v4uCeh5KVV5jnpJyY5VG6I2J8GLXp2qEqNRIfu+uJz31gEPcht6QM86rny9rmNLQzYxNxc6aJiDUGk9HlYqFHEV3+TKBs6ozqOjYYpeQXSTAXGBGqW8a99N0l0aZGd/u6F8SU3AKSvMxvkFyaj8lwc6e6tts0VM/UP/6Q/Kdg2ZxhV9VRiSpvKTkgFbDT8OJX4txWTLDPxs6AoFlz+6ec0KenMyq90Yy1qIdRceuN62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 13:31:03 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 13:31:03 +0000
Message-ID: <920709fc-e725-4ae2-a026-784de03f2f89@intel.com>
Date: Wed, 21 Aug 2024 15:30:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v10 03/14] virtchnl: add enumeration for the
 rxdid format
To: Wojciech Drewek <wojciech.drewek@intel.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<horms@kernel.org>, <anthony.l.nguyen@intel.com>, <kuba@kernel.org>,
	<alexandr.lobakin@intel.com>
References: <20240821121539.374343-1-wojciech.drewek@intel.com>
 <20240821121539.374343-4-wojciech.drewek@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240821121539.374343-4-wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0091.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 4beda9b1-7316-42b8-58c7-08dcc1e5807e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VURDVGo2enVvTlArckJINS9QOVNTbUNNR0MzQnlwcDBSajM2WCtveFdJTWFS?=
 =?utf-8?B?d3FmaU1vRk91T2lIMCt1dEpsQ3hzME1zeHJWMXJkNm9XakI2OEdtTGwyYktz?=
 =?utf-8?B?c2pIczA2V0xlcHZpYk9RZUpEb0E5dTFvM0UvaEw3VHBoRi9CZVEzbW1ncmNn?=
 =?utf-8?B?NUxOQ3Bod1lKNENzenV1eTBwUXIyVFZCQnk0djQ1SEFacUdZbnFsR3hQTzJp?=
 =?utf-8?B?c1BJdGNKK1N5QUNpM2t1enpGSVNDTW9VY2ZlY2RiQndHY25OMjFMRXppeDdK?=
 =?utf-8?B?K21XMVgyOTh2M3pSZ3RvK215c3RGRVZYU1B1Njd3TDE5OXo2SWZsVmJKZk1H?=
 =?utf-8?B?ZFVVRmpaYjZtZmdvOVJiV0RLQUUwbjRTOGRFaFRoNkk5QWwyM2tpajR4Q0pz?=
 =?utf-8?B?QUFxM0xicjhxSkw3UzVoUjVCUEJzeWNwNnpnb2VaS0ZZbHQxOHREcERacTJG?=
 =?utf-8?B?amNXYzB4Sm5hRC94T0R2SUoxNzBrQXk4a05OaFZkL0xCemp2QXRYSmxLTjZD?=
 =?utf-8?B?Vm9mN28vY2NIVmdSUlpCMUtrS1lEczk5NzhKWWhsbTlEV3lyTkdURmF0OVBt?=
 =?utf-8?B?TTJXU2pvVXBBOTBtUVZqMk9JODFuZGY5bEtsa05SNitUWlBLSXZ5cC9KdzBu?=
 =?utf-8?B?WktBTlpWdnJXUnRGQjBGRGdnTmttaTQ5K2cxMUlKYit1RVE0ejR1MVUyc1Vo?=
 =?utf-8?B?TUFpTCtFL2VHSTNTL29KUTd5YkhqTnByYkVRYjBibmRnWmNiSjRGWU5oTUlX?=
 =?utf-8?B?a0NFVlJ2WnB6cWM1amJIZTBKVXkvUlNtTGprbWw3ck5OY1hPNjJrcVlubUFj?=
 =?utf-8?B?SlRqWFkzbFJOS1FVYVhwSmN1SFVkMW5LT2ZiaGVzbkJaa1dTQnAwWjZ0ZFll?=
 =?utf-8?B?MTVqNUV4Vkt4OFBDSGEyanBNY0g2eS9pNy9rMzhMcS9hczZtTUJqTndtTTJL?=
 =?utf-8?B?VndmWkg3RFFlUDN1VVFnckcweXh0MExPYVE5czNkQ0JFZGlTNU04OGxScy9t?=
 =?utf-8?B?MHkwQnBwTmpudkZCVGNYZlJ1UVBDQjJCOWcvOE4yb3R0STRvKzZLYllvU2Y2?=
 =?utf-8?B?N1BNREJwYVl3L0dSS2h0aE9xamF0cjdaa2ZSSWtya2FodzhHV0J2SW9JVXpO?=
 =?utf-8?B?YmEwcThVK01DOFFFdURMbVFkVURvL1Q1d0cyTjhMNFhmeDZ6clAzQVFTKzlQ?=
 =?utf-8?B?a3NGams0RjJaOUdBa2dJY0h1eTMwWlNRbjViMmpucVpLRDlnUFNnRHYwNWY5?=
 =?utf-8?B?VldSbnZpMWc4WjRQTUtlNmxsM1MwTTJXek5yOVcweHNRS0Z6TmFwZkFZTFBY?=
 =?utf-8?B?cEdiUHVSK0xvck04WlFTN2xsSW9UVCtMMVpJNlRWckJIcFNINW1Eb0pWdG96?=
 =?utf-8?B?dDd3a3Y0ZW42dEF2SGlxZHpzejlhVUQrQ2lKeUc4NURYVVFUazgvaTVIVUdF?=
 =?utf-8?B?MEwwYTNsWFZ2dDVaeTVZL0g4RzZFV0dlQ0xkUnRxR0VQOWFyczhqUGNkWDRN?=
 =?utf-8?B?ZFNURzRUM0lMNzNsTUgxMXBZbFZtQUhSYllrYUNoVitxY1FDVjNOWmQ1Q0FM?=
 =?utf-8?B?ZUc5Tm5lWm1OT1Q0SmdKeVZuWWpRQUVPaU9KeWR5TUN6TmUwUUJITGRhelRE?=
 =?utf-8?B?YUkwajJiTk5IWDJyZHVocHRnZjZpaWRqbExSRlVxRmZCQnVLa0MzQ285cUxS?=
 =?utf-8?B?bkJDTmZNeXNZRnVhVXpEanpLcFZYMUp5TkZRVTN5VHZuWDYvRlNFV2hlb3hk?=
 =?utf-8?B?MEVscW5tdWJrOHZHVS94b2cvTlNFR0JldE5IcWpwcVNiYllHM01GM1QxMTV1?=
 =?utf-8?B?ODlScHJtam91K3ZuZHYzdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L29rZDMvSkx3WU01Y1NUcU1zZC9iVEhnWGdOWlF4WFlkVTlEc3B2d2lCVUlX?=
 =?utf-8?B?QjJEM21pSDBDVHlaU1NEOUdTaEU4dkhGbHZOUy83SDdyYmhHTnNSaVBsNFFz?=
 =?utf-8?B?MXVZUDl1MTg5U0crclBEdnJmaHlLSHVGdnJGMXZnc1h2Q09HQkdRZWRHRDRD?=
 =?utf-8?B?eEllZGZxazY0UHNHMVRyMzhBU2o4N1Fsc0Q3Q3BxcndnSk9mdzlxc2VYYmJX?=
 =?utf-8?B?Z0FrS1Q4dERtR1djRElURUdpRk5SbnBXM1p5NThmcitYOFYxekExTm96WG56?=
 =?utf-8?B?MW1tYUQ3MDlZcWNhN1hHNHJNYVN6bS9jUmJjTWlxdittN1VjTEs2TGZsSjcz?=
 =?utf-8?B?ZVpLTFJZa2t3ei9zcmxiYW5Fb3lVaDBlNmh0VW85cFBuOHZXbFFrTytEekJX?=
 =?utf-8?B?K3NqVXRCZWl6bGxnRjhIUGV0Y3hxVk9XYlpHSVRnTTZYNmlXaElEOC81UUZC?=
 =?utf-8?B?aHNuZzNkenBSQi82Z014cFZ1WHREZTNmTFhReVlvNEdRek1SZjRBcDkyUERZ?=
 =?utf-8?B?L2hLUFZMZmEwL0p6N2NLYk9OMno1YzQ4R21HOHUxSzRRNGFzL3BGTDlsRTZK?=
 =?utf-8?B?Y1B5YjlhL2dVYzgwamlKeEd3dDVMNGd4VkljQ2krKzFCWnFXSnNRSkgrdi9F?=
 =?utf-8?B?MWdrMmwxclQrSXZZU1IyYmtBSnlkc0dwTDlWaVlha2w2ZmFnSmFWNlROZloy?=
 =?utf-8?B?NlNrblhuVkxVOW1CNWVMbHQ2dm5wYStwSEpnck90QVJTNXZ0YVZxd2hLTFl5?=
 =?utf-8?B?TTU3Ui8vajJzajVsR3VhV0JVRFpYekdic2p5b2JFNHdxRGplSjgxOUdsK25n?=
 =?utf-8?B?bjk5R3pnQXhxZVoySEJEWHpXSTl4WFcwZFlYTmc2aVN1b296bE9NeWRnZis1?=
 =?utf-8?B?ZWFqM0s2TFNsek83ZGthZHpSb2xzMVZwQ1RWZTlvcXRnWHJ5RHl4MnNBQnZi?=
 =?utf-8?B?bFFZMUs0OHRFdUNkTUhaRndzbzkrajBwYW4zMjZnWEtJdzZUL0Z1UGlNNVoy?=
 =?utf-8?B?bWdzS2N6TDhhOEI3dlBBWTRvcGpBSmpHNnNlYVo5UVBJbllKNnFoclFXRWZx?=
 =?utf-8?B?MVRRRHlURmZDTUlYTU5zU09zbzQ1U1VBRGc4cXJLcmtiRFVyMTZFNGRjNmpQ?=
 =?utf-8?B?RFByTnhMcDZKNWVsV1JxRXlIMUE1cHBzTGtOR2hza2ZZbk4ydlZMSUo2c0Mv?=
 =?utf-8?B?Y1JXZW9hRkhwSU9FRVh2TytIYUpCbXhuRlhmOWF5UGRTM3FqVFVxNXBiT09w?=
 =?utf-8?B?NjN0U09Ycy9UL3JDT2MwaXUzV0o2NVpob2xDTHRCdjFzM2FIZGhuTjdQTTNo?=
 =?utf-8?B?blA4MHNVVUIyQTFlTlJOek5Qd1pnQTRlNnc1SUIwVnkxMktza2ZzcnVXRUlE?=
 =?utf-8?B?OTA0a3JzMVE5OFUvdU9qL1hQNTVmSzZ2Unh4RFp2WEYycFRaYlcwcFFMMGlJ?=
 =?utf-8?B?cElWMkJMRUkrbDZDTWhkWHJhKzVvbThQakZJRS9ib1JQeXRFaTExQnZCd1dY?=
 =?utf-8?B?R3VRaFJBZU5hOFhjbU13UEZlY1RrU2NPWHUwUkprbVh0WE0yS2gzQmFsK3pi?=
 =?utf-8?B?clpKYUoxL1FvdzJ5N2VhK2ZqNFFUVlRkRFVFWm5HQVVnSFFySWlsVzQwQXhR?=
 =?utf-8?B?MzFiWjN4WENUMmE0KzFqOHpPMWl0UXJYOFZEMEZ2aUNlcTQ5bW5DRmpCbnNO?=
 =?utf-8?B?bDNBRk1ROHpDU3NaNm44Ym1XSFcxejY1NEtDZ1dscUhkYy9SSnFFVUJtVlMx?=
 =?utf-8?B?Y2JmZGNFOGdnSHBBMzNsdGkvTGt3QmRlUGo5STJqSE5lZlg4WjNueDkzVGY1?=
 =?utf-8?B?Q1hteTM5ZzQ0RlNoVG1oZ1I2Tm11L1F6SjA2RkNoQlRuUHJJWDBIZEhDMEUx?=
 =?utf-8?B?NjdickNKM2xzT3prbWpFa0pCWXRRVXFpdEJOcDZ4ZW15aTZmRWVyY2dranpz?=
 =?utf-8?B?b051cGFTT2JCVjNodThiSTF4SkkrSUcwMlJEd0d5SEJIQ3hIVElSYldiMkxP?=
 =?utf-8?B?ckgrMENkeElIMy83bjh6cEQvQ0hqbmI1akNsbXU1VWxkSmFYT25IOVdCZzJU?=
 =?utf-8?B?V2xJTVppbVF3bDNFbE1rUFl2T05mUFBjNkJsT2FWU3NkRjZSaU5KTHlYOEVa?=
 =?utf-8?B?eGpLeFhFV1p6QndCb3VsTThXTlc3aFFuYklsK0NjdXVaTUxHNjNhL1hLZCsr?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4beda9b1-7316-42b8-58c7-08dcc1e5807e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:31:02.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30GsDnGNMK5ty9ljGZ1HljqVKDSZOVmAYgrrCt9D6WuR0nEVPXlwaNdThZ8i7tu/T7vfY/8AB+7ZvPWLUmsTLpPx7z4JhPmjI/UobV+Xm5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6392
X-OriginatorOrg: intel.com

From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Wed, 21 Aug 2024 14:15:28 +0200

> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Support for allowing VF to negotiate the descriptor format requires that
> the VF specify which descriptor format to use when requesting Rx queues.
> The VF is supposed to request the set of supported formats via the new
> VIRTCHNL_OP_GET_SUPPORTED_RXDIDS, and then set one of the supported
> formats in the rxdid field of the virtchnl_rxq_info structure.
> 
> The virtchnl.h header does not provide an enumeration of the format
> values. The existing implementations in the PF directly use the values
> from the DDP package.
> 
> Make the formats explicit by defining an enumeration of the RXDIDs.
> Provide an enumeration for the values as well as the bit positions as
> returned by the supported_rxdids data from the
> VIRTCHNL_OP_GET_SUPPORTED_RXDIDS.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

Thanks,
Olek

