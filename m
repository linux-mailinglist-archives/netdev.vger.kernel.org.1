Return-Path: <netdev+bounces-114167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734F594139B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D767DB28F3B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13A1A08C2;
	Tue, 30 Jul 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyerK5Kd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4E1A0AF4
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347396; cv=fail; b=WbekQKsfXi7rDl7l148T1yxhJLDZYKeCcWji7CzG/J0t98VVkGRPntqxn1siqwNLXzhVuvZJNo1zKTKtFcSu+6sYWyv47aM0Hctctm+yoWEPtwVLBfotwnUjPahedyALK+ahoK1zZajUPUJHUx0uqMrMvJzNK34MLaVNLf4Vofc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347396; c=relaxed/simple;
	bh=MHFgOCWaMSC3F2w0rbD3wiCyDQogTviTPXZ3E4iQi7s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2W+Irb9ZMOsCb52t7XEPB57zB4nwrmtoyP938P8WipvTXrPzX6X3HHZTetqiwz68saAikZbMHpnaN7WNsbn2MDGBXeHnYAy/Kxpmu6LFsamtKHvgZHPXjp0nJFBvIeg0zyWC+LNOKoBlWOBPLZdnt7TUSBd/oHUkH0l207VF3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyerK5Kd; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722347395; x=1753883395;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MHFgOCWaMSC3F2w0rbD3wiCyDQogTviTPXZ3E4iQi7s=;
  b=fyerK5KdWNUX/c0ZUYIkO3LW2jlQ4G+rhXZtH5l4mYgn1kF5RbTjw+jK
   xBAXIQrbtgtmAFbtShccJl3KtuoG8cuGqENk0u0DfaRuKiORDUXX4eTzR
   fORoBKdGLdGW2KJMKqi+fLezWfuKbppUVzDcgTYpK7vGloptWxhxgfkId
   GeMLG5rIdGvxzH51rg4FezJbbko8lOE+NXBqflwdzf3ZjzovrVVkwefr5
   IRFqu96RUsE+YA1VeeTPR6VVkALcQMETQPQ1oBGktIEB+SMr9/jOYcBFn
   zaDebMKxnTIY0E+wm1+nIEOjfF3yuAWsn0ycPZfMUXcMLEzsP3tMXo78G
   A==;
X-CSE-ConnectionGUID: 1HD+8Es4QCW13X7xuh1wiQ==
X-CSE-MsgGUID: BC/+KfheSxiQQpZKKjIsIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="37675795"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="37675795"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 06:49:54 -0700
X-CSE-ConnectionGUID: 9X6s5Op/RlmVS1PrkKTFBg==
X-CSE-MsgGUID: ZvpTHjfmTdOK0GswcS+9Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="84989235"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 06:49:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 06:49:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 06:49:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 06:49:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 06:49:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oN+6QASQHOsomBVSkDq8sOixTgXO3UBi7OWba2oPI8yIEHR0QUFadnEZaRkK4/YI0ybc5MVwB3W8pYHszY6zm3j/Pg6M9Tv4Ms3z95n3d0sAzYeSIWgoOairrufwwGy/ACHS2Sa3BDPCFOoG0hnbwdLqca6r/S1cYE3VK4zz7Xz4JJyyav22U5Kb6+tQXNQSP1Vk3sK/ASyVjlu3gflnoaoYzGVSQWMEpDP06XAMzmx619ey7ywAv+fvSB2CDkLGSASaQp+aE/xKy32s7o5QKA8XV08JF08eua3k4aqZoqt+jZbLVdt3EsSW1TuM6NdSQPdWdjfnf+bk13eMfZWAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjJbSfy+2F/fuKyTK/TVM/Csvu0esicy1jcdkJN+DDQ=;
 b=c6Y+fnNpCDNRx1YNyZvqHowGh5HxAWLOcFhdV6UdqB00nAgIi8C0k5ORZDtJIFIQYvxDW59+y/mGbEL+QHAsbr0DVVllzGOFUCIBEqmOhBB96mlhdDGIlMo4k0Pyt+IeusgjBcIYFnB1hUtX7XO8LPLPft7HlMogmLbl6YLFpKYfIpad7w0ZyNImT4yph/zMOdO91sSkUVR1vpUTs3UvMwZP7/AlZ3Rm7XQNLJPKWAhZ6MI+XJ4ojJX7UyWLVtAoF/JhqYzVaRe7a0vxefSmVjcffYvETkPnmtEvI3OZW2lXtE8l4a0qDIwW4WwsMwAowOxb1TRe+H/4ciIh6mmYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6334.namprd11.prod.outlook.com (2603:10b6:8:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 13:49:51 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 13:49:51 +0000
Message-ID: <b7143375-194d-4c75-8e60-9734a09580c7@intel.com>
Date: Tue, 30 Jul 2024 15:49:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v8 08/14] iavf: periodically
 cache PHC time
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>
References: <20240730091509.18846-1-mateusz.polchlopek@intel.com>
 <20240730091509.18846-9-mateusz.polchlopek@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240730091509.18846-9-mateusz.polchlopek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4e5c1a-aa84-4aab-7223-08dcb09e7bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzR2MDhOMVRxVTZjczRla0U1RTF3WXNOTUF6dkJ5QlQ0T0d6eXpNRjk3Z1lk?=
 =?utf-8?B?NHJ2SUE2Qm9sOVVqVlkrK0g1MEJCM1VhM21qU21WMVJaRWhBdVVSUnlmb0Er?=
 =?utf-8?B?bkdmZ0Y4aWg2YzN1NXltK2dDOXNNV0dwUUZJOWNOeS9vL3JNL1djMXBBTXRi?=
 =?utf-8?B?QVVWSW1DL1lPSWMrMDgxRTVpYUNoaitGeW53cHdnTlczZTg3U2kxYUpwUlhH?=
 =?utf-8?B?cXIyZ0tsMjFUR3ZQSFgyWkdRYlVIME9wQ0tzYjBNOGFuYVNoNXhmQWpGMHFI?=
 =?utf-8?B?cU1GeUwveGpmd0pzejM3dFFuNmVza09RcDJkTTNVb0FrbWJHVWs3ek9tQVlN?=
 =?utf-8?B?V3U0bVUvazJ2QjJHWkFjQy96c2V3Uk5OajVZb2Zna1lkN01xeElHSmFMeEVM?=
 =?utf-8?B?RnAwdjBLR0RIK3ZNOFdmVDYybXlrckhTdzRYQ2VlOW5PMURpbXU4Mnk5UjRH?=
 =?utf-8?B?SDIrSFVxRGg3Q1d5RUJWWXY0VlduQUFFdXZtd1ArbDU0K0FPYkVJTEk5TXVG?=
 =?utf-8?B?Uy9TMUFmUzhhSE9oUWkxQisyWXFDTEtqd1h5THVnT2g2WGtkcFk0T0k1VlFw?=
 =?utf-8?B?Qis2WFZUd09pOGI4SzgxNjBVSmF4bmpsSWlrVFlnaDJsd1AxZGxlM3ExakF6?=
 =?utf-8?B?WmgzRWhBc09QMjB1QjNHZlovV21XcmMxbkdQOGgvMDBkcFlOTHozek9JNzJH?=
 =?utf-8?B?dTMyY0J2VEtIcTRRNTZnSTBSOE9ybnBDZzY5dlhiNTEreFIxYkh5TkJmWWZ4?=
 =?utf-8?B?bS9GYXJTbUtDNytENE5QdUdacWZsMktoQWorLzUyWmpSRkJxQlBCQWY2VjBO?=
 =?utf-8?B?bW5QbmZEVC8xbXdMSldwa2pjTlhveU9uNTFoTXJ6NVEzU1hiM0pvQSsxd2VG?=
 =?utf-8?B?QXl6RHJJZXdtVkd0SnhhRUhaYk5iMXMyaXl5M0poQlc3VDhpaFVjSGpoZ1hG?=
 =?utf-8?B?USt3b1JzNTQwRVFYc2dBd2dOc0dSMFlXMitKbU5oQmhUaGhoVGRsTU9XbC9H?=
 =?utf-8?B?MUd2U2xwa3hYdmtzMGluRFUra2dFWDVraUNySm5ZdUJJanY5SkxjM1JIbmlv?=
 =?utf-8?B?bkNhNDJTOHZ4SkxlWjlRalQ3b003TmNGNGtTYUdEdDdQUU1nMEpkR3J3d3Zo?=
 =?utf-8?B?V29CM0lZa1lHeHY5ZExtZEZnKzJLK0VWRmtXaS8wM3FZYWV6YWl2bitnSTlw?=
 =?utf-8?B?U3dTaS85dEJlT3pDSndsaDVWVHJaSU9YbWZJYmFqcHJrbE94SGNsYjVyRkVU?=
 =?utf-8?B?cHNkZmc1bmJLV3JoZzBLVlllYUpKa0FLZVVZalR2WDBkMm9XYUVScUs4SGxn?=
 =?utf-8?B?SC9vMm9GYWZERGZqV1hidkx1K0F3ckM5RUY2cnR3czVJeGg4UlRNK2dwYTlI?=
 =?utf-8?B?R2ZwM2ZBV0pkY1h5WFRTSERYUVp2dnI4L2FONG1zNk5tQm5jTC8wcHRCQklF?=
 =?utf-8?B?ck9aWno1ekloMTkremc2SzNOeElpMlJkTFpPbGVhUmRlc0JhSUJGWVRhUTJ3?=
 =?utf-8?B?RkFCc0dLc09DNHp2ZnRSUUxaS21zK0d3SGtlZmlzSnZ1aGE3dlU1R0xZKzhX?=
 =?utf-8?B?MmxMRERRV2cvZDAzeEFEUTA5K3pTRG9ERW5oLyt5eitKWlFma3NEc1BWemtF?=
 =?utf-8?B?OFArMEs4dllHVmZLNFlzY0o3eUxkbEtielpwUWRGSjF0T0ZhNTdnV0ZkQ1Jr?=
 =?utf-8?B?VVcyRlUrSk8ra0JIT1cyRVRxZzRqZThuUkJ4Tk5xTHp5V3A3bllXaTd3aTVj?=
 =?utf-8?B?b3pxRGFXcEFnMExvcDFQSVYyTHNlRHdvR3ZnN0xueWFoV3FCdG1yOUFud1h0?=
 =?utf-8?B?UURkZndHdytuYWtIaUthdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0d0NWtFOVgvZmdIYVdUcjFGQlBFajRKR2E2ZWxkS0p0MEhWM1M0YmNlNFdx?=
 =?utf-8?B?WWFBTGZmSmZTMFJZWldoSlhYVVNhRVdWL0pFK05jWHhEWmlob09yN1FXdGlT?=
 =?utf-8?B?Q3AwVnVPenpKTWIzTEtFUVNlNXl0ekJFTmM1eVREUlFjTjYzdmZEQWdwSU5T?=
 =?utf-8?B?WEF0aENPQXRyeDJzLzQ2aUVWYm0wMDl4OGtkVXdQS21XcXpBUnN0UXhUSVZp?=
 =?utf-8?B?MmxxekFXSnVpbGpLZXhYZGJqQ3JtcXpKVjN6OVhtNXNpbU9qVXlOd0dQSmJI?=
 =?utf-8?B?UGdnQjFManV6aDEva053MCs2NFNFeklSWGNGZkczZHRFTjNscEh2Z0ZBTGNm?=
 =?utf-8?B?cFlsUDNndG1EZ0NVak02SXJ2N25hWS84bDE2bmdsZUFieEdrc2VSU2pFYzZ6?=
 =?utf-8?B?OW00MGw0NGd6SmxYRHRuTDZoMDhTVzl6ZXRGcEY3MzhYVDIwUTJ6YUJPSzdO?=
 =?utf-8?B?M3psVE4raUJtaUxmR1dCUmV2NVc2cklRWVg3aHBzSldQOCtQQk41eHMxT3Av?=
 =?utf-8?B?T1J5cFJOUW94aVZIU1NLR1c0a1ZybjNZeTJCZU5GU0cvMmdSWmNRcDA1S29I?=
 =?utf-8?B?TVk2d0VLUnRCdDNQTnlsa1FxUmxIOTBlTlFkNkVhbjRsajh2bUFqNkdPbzdq?=
 =?utf-8?B?YUhxRVFabEJNbHpzUkJLellSNUxxUkl0NWEzZFZTQWN5WEpDWGR5ZmJOWDBO?=
 =?utf-8?B?QUJOeTlWaUJNMExoa2hsanRqZnVmQXBiY1lPRitGU3Uwa3YvT2RGVHVwUXVV?=
 =?utf-8?B?STRxSkhSNUxnTUsyMnRxMTBPY2VMd1NpTW0rYUlMK1lKTDZOeUF5Ym91Y01J?=
 =?utf-8?B?VCtYbFlheFpZNnIxcWo4MUhSekcydHZhdm5pbDZ1NUpGaHlkT2FncEphaWIx?=
 =?utf-8?B?QS9hMFZNMGwxY2ljUjF3SEtXSGNPNTYwUW0zUDBoUkh2ODZ5c01TQWdXRmd5?=
 =?utf-8?B?SGlTWUJYR1pKYkpoQm5FSVc4LzVhNzRsZE44ZDBqTnM4NDFLT1gzYmNrR3Iv?=
 =?utf-8?B?RGFFdEp0dWRETzFVeDRzUUJJdjI0ay9DSU9jdngrUmZjRHRKQmI0bXZubkxV?=
 =?utf-8?B?djJsLzJwMThSTmUyMlNGQ01vZUxuMGk2RjA2QzZncDU3T2FLbWw2ZlRDcHNW?=
 =?utf-8?B?QUlwSVRjMG9pNnpmb0JWVW4vd0tqdUkzbklXa0pORXdvV0hRbW13M1lNNHYw?=
 =?utf-8?B?STJlRjFsb0lpMTRCRXpCclBSNGNXSzloR2V5NFBwRjI4ZFZXdmRNQUxtVk5Q?=
 =?utf-8?B?RFpVaW00ckJQZy9ockM3MWJ4OEJHRDFoejNvZklLZjFhZFpEYVhPMkpCKzYw?=
 =?utf-8?B?bFJzSnYvY0pTYkFCSGJCTGxTaVdCSFBEbzYrRGsvb0Q5ZTk2UE12UTNMbW9W?=
 =?utf-8?B?QjZnRTkwMElPVHM0cy9CYmYrWnZjYUx5QjhSQjV2UGljUThBanNRMTg4YUE0?=
 =?utf-8?B?ZGJkdWYxdFVsWHZYQkJkOGJnT1dNV1kzVEFyMUlHTkdMaWxsamY3eGdWSk1a?=
 =?utf-8?B?d1ZsMlVBU0kxS3ZqNkhLbTJLQS9NeDdDR3NOZk1uRWFobnUrM2x3UjI3b3JX?=
 =?utf-8?B?MTkzNGkyZ0FHOC9Tc25MQkpwY1MrR0tibEdibEx3VjhkS1VCdXpBTmxDcTZm?=
 =?utf-8?B?c040WVNxN3JsZWcvZUVFWURMclArbFBEWG0wNjloQnFjTXlwMFNDVXhBdHhV?=
 =?utf-8?B?SldJUzhzdU9kNEoxSjc1WWNtbU82aXIrTDNZaFhjTlQ2QXVmdzR1aEZZSUFS?=
 =?utf-8?B?K3FXTlVqeDFGT2lKZEVoK1hYMnVRNXRjL1ZkcExSMXVzUnI3WHhXcmNHSWJZ?=
 =?utf-8?B?VGZRMmVBakVkK2lEdXh3MHA0Z1FkNXp3UlJsVGE3UFVreW93NG13b0lYc2d3?=
 =?utf-8?B?SEQwQnM4endxeFVzN2g4UUgxQkluVGVMOVJzK0lRLytSN3FKaENSSmVHUGp4?=
 =?utf-8?B?eG9MaGsxTWpDZE9ncUdKbFk2bVdNbUNmTU16eXR4T1d0YklpRFNzdk5aeXpC?=
 =?utf-8?B?UElNU1Y1WTUwSU5WdEJaZDFhbnpPNkhxKzZFdmYvZEt3b2tCRzF1MUdjZU1R?=
 =?utf-8?B?SHh3azBOTlJndW41TktGNGl5azBuWENqdlpJMDI2TndjaUsvdWsvSnJ3R2Ji?=
 =?utf-8?B?YzBHR1hJSGxRaUdyWDFlZWZaSEE0cU1kRlZMS1FES1ZnS3I0T0hGZ0RNYXRQ?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4e5c1a-aa84-4aab-7223-08dcb09e7bc2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:49:50.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGL8PdTbLg9sFfQbgaLqWELSjhFGBk015wPuTAYgBoViha/Vvf3pFKXrH39o00BqT4PZETcCJyKdos+Lpy/MekgPKLOFOMfoZl1CIz2WpqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6334
X-OriginatorOrg: intel.com

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Date: Tue, 30 Jul 2024 05:15:03 -0400

> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The Rx timestamps reported by hardware may only have 32 bits of storage
> for nanosecond time. These timestamps cannot be directly reported to the
> Linux stack, as it expects 64bits of time.

[...]

> +static void iavf_ptp_cache_phc_time(struct iavf_adapter *adapter)
> +{
> +	if (time_is_before_jiffies(adapter->ptp.cached_phc_updated + HZ)) {
> +		/* The response from virtchnl will store the time into
> +		 * cached_phc_time

Minor, but a period at the end of the sentence is needed.

> +		 */
> +		iavf_send_phc_read(adapter);
> +	}
> +}

Thanks,
Olek

