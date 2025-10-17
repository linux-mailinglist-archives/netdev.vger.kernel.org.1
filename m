Return-Path: <netdev+bounces-230483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 305AABE8C4B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7BE74F1FCD
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E821E329C4C;
	Fri, 17 Oct 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tw6rpeJk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A12367CF
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706807; cv=fail; b=YZj5ox2a5J3YtzojEr4U4koLdnmFw24tej0LDg4nrWmNEojJxzxyEdHE6zPX/FgiEFCsS+qtObE+Uso6rJOzDnxW8omAMtpXo1+5CS/Y2vYhjh6p4Nx/oGzkyxW9kdOss2pq983uPvh/BZmzH4cDcuEJuxO3gMzvOONoP+0PGCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706807; c=relaxed/simple;
	bh=GdUEpAo2URGB/igYvEA/QWSE5VwVhMnwfCdD/yObSyw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bo7wGswRApx20CZM9anb2KtNOjeYhHofiES43g33jsp2JZDd+zvHzQWi3xvFPkWqKcciHf2KI6qIvaX9VTDssT0ecu/g2mAzFUxuKEDMQhC6xWef+d2+8Tg5AxWPjzOcb9KSIMsi4XNLtE30JvvuoHyzKXWRcX7B2Z8YqRZnUiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tw6rpeJk; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760706806; x=1792242806;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GdUEpAo2URGB/igYvEA/QWSE5VwVhMnwfCdD/yObSyw=;
  b=Tw6rpeJkcTp3jM3zsWSOtdLcI806qWoEdmakgh9pDSDeVEwWcYk+yVY0
   O/PpFLwGbE+2tIcrDbT4scWg4XlgFImTTLZp5OiDL39XeqQeWGA1/oHDa
   895gcSFPYZTiWDgZ8HHPQbR6wVn3SQ1YJHuwh5R750YvJGvnx47WZgAXW
   LJ0n9ut8NLrCYNdf8P3/J5xvo1zVDOTZUnIshp3fXxTdJ7zdkB570xJ2T
   BPFjaRecJPbBlAhqDpg+g6ZzRH8fCozJUOKF3peIQR3gKzKA2Chgi7zxU
   uaaCaLTuPq27wG/muakeOu9+I4v26ut3sAKpqtkWc2QyVijs4X9dVGDCd
   g==;
X-CSE-ConnectionGUID: CgaQxqvDTMqWp2m/qbYD6w==
X-CSE-MsgGUID: GvoGakuKT2uoiOVq7CR0pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="63062784"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="63062784"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:13:25 -0700
X-CSE-ConnectionGUID: qy0R5K4KRxilu0kbeX5g6w==
X-CSE-MsgGUID: N013TlsQRVebY1Q0ePMrNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="181867195"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:13:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 06:13:24 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 06:13:24 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 06:13:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCUi1a2r8uZkkQ26HMMtxhBsdYZS0DXn7rgZNyUJWJxHM17GgjMrE7NtdutZdISjLjU3U/38mO1Q6KmmrFAnmZK1e4J5OX+mwUclJt2Y/q2aC0KXLag3NsdnyaaweiJ+GkUlnkR0rj0Y0m1RBVb5hlnr7z18rHJtY8S4908lYOWlD4mKcsIFrHYvmzG0ftpAq3uZzDn45CgakWA0LCp8+8S7RhOGSuiRkq8m+VXLaPMX1KfJgKOc6Kg5zpcGjq/FWtRXlExyy6yqvVTmtELRoooIAn+CAIwg1xrHsTXh2ZfQ5exX5hgi4mMBJOFr7buQWzil7a5KoKKg90eOD2XP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e55TY5Xw+UUw30b7hUR+ZGPfwwsDHRwG/qnCSouHMko=;
 b=wL0kDsg6UGWGNP1+y94zh/hgTLKHEYJ58Eoa0VdiHfq40zRdgwKEEPyvj5HTdFQvZrzVnnPJX2SI2DqOQx1mNbkiMOjj5KM7CfGIWPSd631nFCYYiKv3xHZyOoFIu4rCxlKpuSa0/cy7hBUNodNMqvnjcF4VHa5wY6hi7Fof7eEMryR9vsjIBalRHv4t40kT33rdpqObxII/6+NzayM4d7YHdpRMx8Z71O/4Yiw7G4+UjKKQJyia7doMO3GxUbHlY4+pgeBxrmwrrDBc0WestIJVJJij4nD9CWlH5vHQeNV9SMyVyiRv01PpdawP2dmCcLl9PNLi+Lnk3zT0y4OtnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB8496.namprd11.prod.outlook.com (2603:10b6:610:1ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 13:13:22 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 13:13:22 +0000
Message-ID: <fdf97d96-fff9-4826-88eb-4b7f56b36c7b@intel.com>
Date: Fri, 17 Oct 2025 15:13:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net: shrink napi_skb_cache_{put,get}() and
 napi_skb_cache_get_bulk()
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251016182911.1132792-1-edumazet@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251016182911.1132792-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::25) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a2d5c5-eae0-4386-cb64-08de0d7ef258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NStURkN3eGR0TklEckNWWGxjc2M3RlJ2OGJnVk5RV0hSdEl5aFI1d1dCSEUw?=
 =?utf-8?B?UGdRMlZwNTNsQVp4Z3Y3NGJsdUF1SnVMMi9SMDZqZC9kalNrM2VTNGNkTEYz?=
 =?utf-8?B?cEowcFRxZG9sU0gvZGxlM1F3Q1huM1pCb012Qm55c1BTaVpqekpSTXphd093?=
 =?utf-8?B?aDZKeUsxcWZ6NnA5eTY3MnExdzVhUWljRVJzbzFhODhxbjVBS3hmNE1zM0dv?=
 =?utf-8?B?N1Z3Z0ZlbkRlYW9oUUMzWUtZemVCUEcyc2JqZU15bkF5dDhLeHBIVjJsNThj?=
 =?utf-8?B?RWpUcEtvbkpFNkhaUkx3MllLcllELzl6RlRRTGRZNXRPVEF0MmR5Sk1pazVE?=
 =?utf-8?B?NktEcHQvMk5NYm1DdFVYc2ZWN2ZLaC9OckxtN1I1OFBTNVJLcFhwWFU1TWRC?=
 =?utf-8?B?VVFKTXNONTZkYng4bjJhQitibStSbjdFSm1JQ29nTE1nd1cwYStpdndwazNN?=
 =?utf-8?B?Sy9IN3FacVJJZE9GMEp0RmY2Q0FYOEpyYXlQcnA1MkxQQS9RNVhRWitTWldC?=
 =?utf-8?B?aCtOZjNKNlVXYkMwUHRLeUJNSlVWUXhFWWlicXRCb2d4TXJBUHhWSjFEY0xZ?=
 =?utf-8?B?Ui9HOExzeldITHFwSlh2b1JON3FIMG5nY3VyTFNTSC9vblVZdGZjdEc1ekJG?=
 =?utf-8?B?cXVDekdyUktLL016S1ppWlRjUjVPMnE4eTRyMHlSTWh4T2lySzArNHk1Z2RZ?=
 =?utf-8?B?ZE1jVHNibFJFWVcrR25sMWlFZXQzMW5oaVRkYXpSVE5ZYmJSZnZzS3JXOTlh?=
 =?utf-8?B?VFNTT1hROFBvelBJbEthWFNRV2JhUGd1OVdKYUtwM0RhU1o1ZzFOejdqVG1N?=
 =?utf-8?B?bXFsdlJtQ1pQOUNZY04zczJNU3MvS3E1eC9kakI4cHcrTVc5N3dpdm0ycThl?=
 =?utf-8?B?djk2US9ZUGdLc0sxdFpFRE13RWpDaDJEWE5iai8yeUlQeVJBMnpJeEhmNUxH?=
 =?utf-8?B?RVlPQzlqejc2ZGxQbXorZW5HNm93UW0xLzhhSjIyVVdkSVRNRllNeW9ZdE5T?=
 =?utf-8?B?R3RqZEYwTUVocGdVaHg1M3Q1cnl6RVRVeFpDYWlaWlAyTENVcytWMXd2Qkta?=
 =?utf-8?B?WHpMVVkyVTZoMnk4bXdycEhCZEw4RW1ITkJ0WDNuc3B0TEM1Y0p1TnBlTU8z?=
 =?utf-8?B?MFA4L1hkNEVHazZEMXJUSk9YSU9LTEZnMnBheXhCcXEzRU9XSU1VbUVRaFRn?=
 =?utf-8?B?bUtBeVU5S3ViV2pROTlWU0NVTGdJSkRUczV3QUVJQzFPR1dqWTREc1BHZkVt?=
 =?utf-8?B?bXp5ZkR1Vnl0eWo5NXExMjc2OVpjdjJ5d0JvVnhpdWJtRVhONytQMnJhaDQ0?=
 =?utf-8?B?MG5jYWVnUHVkQVZYTlBpTjlYWGRsRzIxZUwyQjZCN2pXNEtybE85R3FLSDha?=
 =?utf-8?B?S2l6ZFZnd2c1NjliZ1EvSzdmRURWbTNxSFZ1UVMyZkRtTVMrQWY5N3Y5MTQ4?=
 =?utf-8?B?U1E1UmdEazZqMWZzUDUzSHl6M3diTVdGVFlzbWlKd2xRaG1maytYQjRyVFBw?=
 =?utf-8?B?dms1TmFzTk40eXN6ZVZ4NFQrMTdpQUdLUkxrMEt4QllNWEVqUkUwdTJlUlNv?=
 =?utf-8?B?QzZ3VU1kYkIzL2ltamFVams4V2g5eWYycFlUYVRVWnM2OFpJbTF6RjFGMWds?=
 =?utf-8?B?ZU5ucjJmNndVZ29HM2R1YUJ6YWtkSU5xcGxMdlRWRzF0L1NiSUhyQkhGMmFs?=
 =?utf-8?B?dG9NZnkxR3FBakhqTnJnWXJkTDhHN1hrWkc2b0R5cGl6NE5MVHRaVHdRVnhw?=
 =?utf-8?B?QVp3VlB0MFM3dkRURk1QM1R6blBDd0lrbGhrK0JHVDFFNlZKSXhaRkRad0tF?=
 =?utf-8?B?WmJjWVVEa3RBeWZESU15Y0hZdWZCNjZzaGdBQVBUcU9Nb2RIb29xZWxZc3V0?=
 =?utf-8?B?cmoza2UxRXh6Vlh6U3Q5QS85T3BISXhJcGhLY2hOeVFtYkJVb2tTQmRHNllC?=
 =?utf-8?Q?Pp+WHlw4rM5FmICPQ1N7OMzT4VqCd1GB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDFhVEVKNHVNUTFETHNRUithM2QrLzFySm9YdTl0RjhPV2h2Y1ppN3dzcXpj?=
 =?utf-8?B?ZGhaVlRaTDdTQ1hReTFqRlI4WlhoS2tBUGxIblJ4WE5JT0diWWdoZXJIRk81?=
 =?utf-8?B?RmtybjZmeG5Ec21XMndrSlVsb2pJMEJYSkFmQU9vZ0lDVStPdmFJSXMzOFJ2?=
 =?utf-8?B?emI4ei9NemFya0RoWGdPdmx2YTRRbGl3Y1oxVmlMeXVLdHd4NmRncE8zUHo4?=
 =?utf-8?B?WmFsMDVxQzFFc01UbDZLbUFCZ3Vabzh3bHFPb21tZGJsOU5sYmY3aVh3ajIv?=
 =?utf-8?B?dTFWTjdiSFQ4QUd1N0pzWHd0ZjlwWjJ6M2N1MUp6RFRvL1pUckNuSE54QUhD?=
 =?utf-8?B?RkxRN0ZZYTNHN3Z1MC9uM01PT0g5TmM0RjZpV1pmcTY4NmdudmN4Z1dsOVUy?=
 =?utf-8?B?RUhZRHhCWTNtdWtnTy94MzMxNjlZZlhXSWRNVTFRZmxGRjZSN3YvRFY4NEts?=
 =?utf-8?B?dGxqOTc3L3R1MmdsYkYySU1KY1hYZ25oWTRGczBPdmlnZEErd0ZRdVZjTlg0?=
 =?utf-8?B?ZUFTRnB3THg0YllaSE5VMHErWmhQUkZqVkl1NkRnd3JsdWdSa3Z3cW9pdmsz?=
 =?utf-8?B?SFM0MEttOTBuYkZPTjBBNldCSWd2RDBrdk5EOGhSc2YvQXpZTVdRcHdFWFFj?=
 =?utf-8?B?bld1NFl5NVBHWTJDMmhIa2NkUDZtM0VCaEp3WmNDV2loWTdHcFk2bnNUNEpT?=
 =?utf-8?B?WllPMmljUnJiVGNXT1IzNHZNa3BpamV4ZE54aUhZcmgrbHJxcGxUZkZuZHZ3?=
 =?utf-8?B?LzVWbUFGN3Z1T08wODV4ZjR6dkF5dGdFQ09ORktXdk1mU2RRZ3VQcElVMDQ2?=
 =?utf-8?B?QzNnWm1BRElpT2h3QVhaYTREVzNwNWRydnVmbC95RDE4TzRVb2ljcWQ2R0dR?=
 =?utf-8?B?WmJHT3N2Mk9UTU9QTDU2aHVrcFBhUmRIT2FWTnk3QUFEcHJkWEtOaFJRZ08v?=
 =?utf-8?B?RjhVSXFDNys1Smw3c2RIOFhndmU2dDQxYmxqalVMRFJxaXJDWXA0WlV0WWE0?=
 =?utf-8?B?cVorWWFKcnFhMWhBU0wxSmNRUjNJeEROWGVuWnZlR0RKMk1kVlJsbmIwRGFs?=
 =?utf-8?B?cFkwckdNTWVVVlY5OFFOcVFlekt0NHFLTDBkS01ReGc4dUsvSlJlNnkzSzNa?=
 =?utf-8?B?aTdNMlVVc2hLSTZZQTZCY0x2NUN2MDRYWkZwVXlVVStTVkhCa0hpTmd0eGdn?=
 =?utf-8?B?WkhSTHdQT1FINGpnVkk1RXc2MndwcGtobUVhWTRrNjIvVkNyeXd0bkNQLzJk?=
 =?utf-8?B?S1UrRFhkZjRCMzZRM0tlT2hHOTF4QXNOQytIN3N4ZW9uQW1VR2FBci9MWElE?=
 =?utf-8?B?NS9kN0xZallhWFcycDJKRWRhcWY1TlEwMFBBWVdxbGN6OEk3b3JhOUwwOWZW?=
 =?utf-8?B?dEh5RjFvb3YxY0J5Rm83YXBadHN5dSt0TXluSUhiNzlmUGJsV255amF0UHo1?=
 =?utf-8?B?c0lWK3piTnpYL0taZkhHaitJNG42L2o4MS9TUE5FdXBBZ0JBb2NMVXIzdVBk?=
 =?utf-8?B?ZUgwQXZ6aVdpMDVscUNCbG5FSStrZlBSSmJjNG54SjV2OWoyM0pEME1EdHp1?=
 =?utf-8?B?cEw3T1draGZ1VWQ4YUlJenJlYjhHTXl1aVNicXdOdTRpNTJGV1dDdTBoM3V5?=
 =?utf-8?B?TUZvMUMyRVJES2JiMWVXY1hxOXk5elkxY0ZqYkk4V1Q3b0kvSGVpWWhCNjlk?=
 =?utf-8?B?aWFpZ1EvbHZMWlE0UklPYkpkbVdteUVkcWhZUjIrcXdIbW1XUUdEeFlDWHZr?=
 =?utf-8?B?dC9LTFpRdkxYMnNVQVlLalRRTFV0NDVOVGVWNkFPTlFxSllqT3Z3U2xKbVJ1?=
 =?utf-8?B?OGZQdDc2Zyt1azBwUXRuVGFoSHR5eXRERWkySDN5aGw1U2psTXZvV0UvdEtq?=
 =?utf-8?B?TDliczBEYkNFdmJqTEJqa3dqL1VvT2pEK0p4dmxNOS9Xc21SZ3hJUW5QWWZy?=
 =?utf-8?B?azhLdHpEcElXVWJod1dWVjZvdGJZaUN1TGNzbVhwbmRnVS96cDE3OXBvZWhC?=
 =?utf-8?B?Mkdsd2FKeXVMWWQ0Mnk4d3N2OGs4N0M0Rlg1SmxFeDlUSk5VbGF5ZXhPQU1W?=
 =?utf-8?B?VzdKSHh1VGFKNjRBR2IrWHU1VWYrN2QxQlNDdWp4RHF0bkNBTXJRcTdvY1hw?=
 =?utf-8?B?Q1hpTjRjekcxdUZ2ZDQvU1hHck1PZi9YTjFUSklFV3ZRQ3FtaFpNTzV6WmdJ?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a2d5c5-eae0-4386-cb64-08de0d7ef258
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:13:22.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1c/ocQN68FYyIBEL26aDH7ZF9rnIuFBaC+cMFstBflFKtPDp+KcNGxYgvuoRUjAmb8bqN2j3gFXcZ0ruRzxE4sdGfoYOSDDP44i9QDhhuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8496
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Oct 2025 18:29:11 +0000

> Following loop in napi_skb_cache_put() is unrolled by the compiler
> even if CONFIG_KASAN is not enabled:
> 
> for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
> 	kasan_mempool_unpoison_object(nc->skb_cache[i],
> 				kmem_cache_size(net_hotdata.skbuff_cache));
> 
> We have 32 times this sequence, for a total of 384 bytes.
> 
> 	48 8b 3d 00 00 00 00 	net_hotdata.skbuff_cache,%rdi
> 	e8 00 00 00 00       	call   kmem_cache_size
> 
> This is because kmem_cache_size() is not an inline and not const,
> and kasan_unpoison_object_data() is an inline function.
> 
> Cache kmem_cache_size() result in a variable, so that
> the compiler can remove dead code (and variable) when/if
> CONFIG_KASAN is unset.
> 
> After this patch, napi_skb_cache_put() is inlined in its callers,
> and we avoid one kmem_cache_size() call in napi_skb_cache_get()
> and napi_skb_cache_get_bulk().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

