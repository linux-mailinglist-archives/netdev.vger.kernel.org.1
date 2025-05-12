Return-Path: <netdev+bounces-189878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B61AB446E
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2CE3BE6AF
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8F12980CE;
	Mon, 12 May 2025 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AheW87aY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470A4297A4D;
	Mon, 12 May 2025 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076943; cv=fail; b=ivQ7CS4PvNl57izp1MbwzQ1AUwM2fA0fSt7C9sk0bZITX46LH4iqnJBjgt1Yrg92cNODwsxvZ8baCly9S0ZcYWCgA/XZFgfidqSeozyZXewR8yLRjYAzmqMgz74hEXtE6xQwFFveQ70DKl5UUg6rFPQnj2CHw73rjjpZsv8rVPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076943; c=relaxed/simple;
	bh=YyGAJ3fsj9wnKGkRvUVO+XQW334Zs/wvKIFL6VPydE4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e/TrucRC5m8mHV5Ngzv3l7P+YuwckQ4hG6blnoNgyUhPe72SS+e+i+aJGI2O3WZUeYvqwe9hvY2GpxZyv9E3EKqLxlmlgjFBHAJVeCtetAdzkKe4ZUZGkVxUK5xJy66Vuq8ebrlZBB5cThTZy8lDMTLo9GUNwnPDwpkbxbE5afE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AheW87aY; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747076942; x=1778612942;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YyGAJ3fsj9wnKGkRvUVO+XQW334Zs/wvKIFL6VPydE4=;
  b=AheW87aYnFRt3a9XZfXid6BM2ju85rtM0DLstJlwtHUQv7YEML34npRl
   DePk5oyzJkoghXY2uJe5O/ZzWLILnjkHNK97gtHX3GwDdIDLJyMUTwOxd
   cQz6JFeACNj6KU8Y8Z0racOSkcT9yLWlD6M9ygIf+9bjlKerGHdg5g9wD
   U7/UA6L19Xuuaorh4mHhnVshl4afO4cwYBPk8nAEB+FlZuCHwRoIYKZ+/
   F6pgfo8XcN5P0sTG0i5/uLMGa+moTWpsUXAO2Evs/6JYmopoSSzowcLAv
   fnohyq26MwWTcyVdZN/tZ1jtkAZsQIaUifzWdMuXhyVdb3YavfQPgwKiy
   Q==;
X-CSE-ConnectionGUID: DyVgkJH5Qmm84/D0/A5sIw==
X-CSE-MsgGUID: 0UTaMYstRtaU75Aap/8fQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="66433391"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="66433391"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 12:08:52 -0700
X-CSE-ConnectionGUID: oHLCvCGUTGqpEhSm9YKdzQ==
X-CSE-MsgGUID: TlL9HUR7Rd+tVj/Mm0VByA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="142580997"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 12:08:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 12:08:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 12:08:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 12:08:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/FtS3z8dPNK2hJ1bQNiPoI2S5rMTbL/oX+9yNTRIjwhooVynlI5e0mpcOiIUrBV2XQUArPIJxog0OXADFFSSa45V+uxzOQB2yVxzwqMxx7QKBQUgqvb2g0r5b3PErhTEUw1pQGw14lyXWGOWQOZNlzLCIPpHU5q8dI6A/FEEXd/HBvN27YG8hDIxdcYL2OtzN/wUSjuEd9nsr+EkA61HhlvuGzYIptnE8Oop+XFsyomMdmsjXw0PbeV0b0AUK78pi+h85N1YK7gKpVDEjnuBer2ue1MLyGiNt0+m+EAsZWWkTmEQwvYIs4GT5v87i9XcBENDsBlEFDk6mLyX5n1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bJLydP9azQhe/hSLxjjbxHUAv/Pg3QBKUGBw3zNj0M=;
 b=o+6MRODnv4aoAKeiNUMkpSJ7rXuHU88JOiRpwad5qvZqmolpkwc/K+uH76UaO27jFb3lxGiqJMunn9reilh2vo/CL3Wi0CYEqi9LJIYB0UvTzqAHaYi2jONck5baqtuCnRJCj+qNldo9CjHSytJbV/sqpd0kCb/grFZejVzBsdCNUitQEazMImbG6xGn6ThEqwBcjGz52oVM07CKIcwLgBAL3u4/YriuV/hii2nVdlJUx7BahRJlIf72AM8UhPUye0gT6vxRVX9XHW4QM7D4lN3zpYH361NheLEYSHpyKbaJtYb2VQCjN5sIDgoHjKepW32LXu6HdhNHf3xt8bewxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB8271.namprd11.prod.outlook.com (2603:10b6:a03:47a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 19:08:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 19:08:33 +0000
Message-ID: <58755bce-e4f0-474b-8799-22258fdd320c@intel.com>
Date: Mon, 12 May 2025 12:08:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] eth: fbnic: Add support for multiple
 concurrent completion messages
To: Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>,
	"Jakub Kicinski" <kuba@kernel.org>, <kernel-team@meta.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, Sanman Pradhan <sanman.p211993@gmail.com>, Su Hui
	<suhui@nfschina.com>, Al Viro <viro@zeniv.linux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250512190109.2475614-1-lee@trager.us>
 <20250512190109.2475614-4-lee@trager.us>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250512190109.2475614-4-lee@trager.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 770485b2-3d05-4fc6-4f28-08dd918863c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHRUdytyRWs1Wnp3bkd0eE9PMXJhK3RhTjVGQWE0cDlYY255VFhYTHVXRG1y?=
 =?utf-8?B?UEI4Z1Z4Sk1NWDNBUUVOa1poMWoyM3k2TERkTms5akh0NnBMWENIanIxc3c5?=
 =?utf-8?B?ZVRpcnBjV0FDbUc1SVNhY3BldGlIWDZOa1JsVkEwNjUzeGFEKy8yZlRvZ0dO?=
 =?utf-8?B?M3pwNThMYzdabEozMWlTaTdpRmg5NHlxYzJvN2IvU0hBdnBtMVJabTlUUWE3?=
 =?utf-8?B?QUVHbjVGdW8rcEJ3R1JBZUtiYnE4NmJ6NFFDdUJzNkNyeDUvbHZZS3hJUVpJ?=
 =?utf-8?B?d2Zwc2kzTWNkU0JDNGw2ZzEvc1FZTVIwMTVhZm00bVIyczByVUJQK2FpQmQr?=
 =?utf-8?B?ajRES2hhL09rWi9xODd4djBqZGp2T2tLeXZZYi9NcGZDSkh6L2p6UkIvTFgy?=
 =?utf-8?B?YUU1SVdsU3RHL3hUQ1RDOUpYRjlNVm1GVjd6bU14Z284U2VQMjBVQzQzVURm?=
 =?utf-8?B?TlFKRURUWWdsOGtQWDk4VGZ2Z2NyczJ4NVBTWEJsSGxVQndRaHExT205ajVL?=
 =?utf-8?B?Y0VIK2pwNitPeXk5cEZIM1haZWc5SHZpL3IvamViYU5ndkhFdWJBWmY5MlZx?=
 =?utf-8?B?Z2dYc3R5dnArVTBNQ3RCRjB6RlBXWDNnaWdYdldPMFVsTFZyTU1NSG9CNUJF?=
 =?utf-8?B?WExTdG5LNFFZYWZnbXRRb1JhWlNaVndIam56TzRBbm1uR0xmVE9NaXQ1R282?=
 =?utf-8?B?N2dYbk5SbHVlM2xrR0RKZzZqdzU2bVNzVXh2YTlQaFM4QmZKdHlsT0FkOUYx?=
 =?utf-8?B?L0J4K0czK1JmenM4dlV5dGFPSm42VTFBR25yc2Jra09lY2hKazNBYjA0V0lT?=
 =?utf-8?B?cGJKbWNGQ0JSZjdKUjEwZUJUWldlSDkyR1BNY0E3RVE3MUFyaUsrMHg1MitO?=
 =?utf-8?B?UHVIdjR0ZEZERGJFRnNPOGpaSDdBNzZPT2JKOGJYdURJWXZMb3JhRjlPWHlT?=
 =?utf-8?B?eDRFMXl2KzVKVkhocFZyOUhEUTJoei8zTFEyUVRGdXErdGNsOHVRV2dONm52?=
 =?utf-8?B?dlFTNmI5TkJnREoxcWJHcy9UNW9FOXp5MjFTUHJDSi92cW81L3NvUG9USFdK?=
 =?utf-8?B?QlAwUHNwNDVYbEl0MGZqVUs4ZjBCYU5oZlR0YkNTWXBvaXhPaFJnQUtZUzMy?=
 =?utf-8?B?bnRIaVhKRGlsOGhEcWpCZXNlZlBxdTN1eDhMbCtTZHhndW1UWnNmVWVsbG5E?=
 =?utf-8?B?QW9aWElOZStIb1hoREJ5UFcvcFlnK3V5TnQxcHZZUElWQ3ZCaXYweDFma0xu?=
 =?utf-8?B?ejV3RXRYUmhDUWFFeUVrTzBFWUdzcHpmSFhzVDY3T0hNMmtvb0NWSHduL2dV?=
 =?utf-8?B?RDZ3aUxEQXk0TWIvNG54eDJ2K0t3SFlIM0t2ZGF6R1ZXS3cramVDWjIxemhC?=
 =?utf-8?B?Rm9CWUd3RWdQRXNrbXBKcWdURjA3OFZPV01VZVcvNTJNNlhOaEM4WHJhVEp4?=
 =?utf-8?B?TU0rcFUxUEZOajk2QStINU1xNWtLQVlyUE5BQytNejQrbDhUbXFvMjB5d3Jy?=
 =?utf-8?B?SkJKV1VlenBYUldId0ZCckVBcnNUWTl1RUN5Nm1vc1R3akdmL3lPdmQySUNS?=
 =?utf-8?B?LzlwckJPeUpHVW51TmVCSTg1NHQwb2x5MTRxSUlrbTA5UmpMdUZ4WGRrZVpt?=
 =?utf-8?B?WENtcjEwenBYTTkzd2FobTVMa24yeld6N0p4emRROHE0bUZuK2xHREtuU0c3?=
 =?utf-8?B?WWc2N0diYWkrVm5IVWVYZ2UwR2liVXExRUl1cVladjlQL0Y3eG9XdWNqblhk?=
 =?utf-8?B?VjFPVTFMa0xuaHBhR1JWVXlzaUtFVjhHWkloNzR0RGhIcWp4TTJoSXdyamFV?=
 =?utf-8?B?R0JtaFNrN1JkK3Z1MHhHSWlDM3dxRnZkRXJ6QUdrMS9waHY4MU90bW81WmxT?=
 =?utf-8?B?T1JvQ09wTzUvSXJIb1RPcEJzdUYwUm5id0lqNmo0bnhKdklVeDZqdTUrcTFO?=
 =?utf-8?Q?UzQblke4eKUvkRg8Gmnw9NwRDaA62eJl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTNkdEY3dVFIRlNtMGl5Y0FnZnpYeTRrRWlVL2pNRmsvbjVlaVFaOWNYSFRQ?=
 =?utf-8?B?c0xXMmVnSlFML28vODV1ZkRHUjd0anFPR3lLeVBRczlJS2dNVFhJb2xYNHVh?=
 =?utf-8?B?VGxGaDBVSnI1N0lidUo4RzU1djhmaU1pc1ZiUGhTZFdMb2k5enEzUGgraVRj?=
 =?utf-8?B?WnFrTlE5dTN2SDhLWDdrZDdjWEdNcXBNejlSMW40enpMYlAzMzBJMXkzS2kz?=
 =?utf-8?B?YXB2Q2EvL3ByN3lKRWpRRUI3U2NjWlQ4d2dCbUwxZmVZYmljUHRjMk9PTXVt?=
 =?utf-8?B?ZGoveG90clh5NXM1RGEydzdmb1FPTVozcTJyaFR2NlNHL0FmUFpVU0JGU0Nk?=
 =?utf-8?B?cjhiSENtTXp3ZFRnWVcwWU12R3JiZmduYW9mbzQwN0lPYUgycThIY1dTSE9p?=
 =?utf-8?B?UWp6enh0UUdxS1RMMHpuY0FhTE1hMlpCelZKamZTbS8xRk5oZ1paYjdjekVr?=
 =?utf-8?B?d1lkbVlhckJNMmh4UEx4dUs0Y2JWOGR3Z0pMa0Y1eHpvNFV4b0ZPWFJ6TTVl?=
 =?utf-8?B?NkNIMW0xMTgzRi9xeDdDWnlYNXdqak5EQU8yeWRic0k3NkM2YzVUbVlyUjlz?=
 =?utf-8?B?MTV6ZnZBK01BdXcrQ0g4dTVkN0U5UHRIc3RTQTJ6WUFVOURSVEhUQ0RhWm81?=
 =?utf-8?B?YnI2bCtFV3RDbVNEOHp5anhmZ2VYVmM1M2VMTndaQmtJL0ZmSVBCT1VHa2NU?=
 =?utf-8?B?OVNoL09aR1ZOcENQWVd3ODJ3YjFqY0hHN2I4d2czVUZZQWx6bzJNNDlPVjMw?=
 =?utf-8?B?WWJlS0wvdzBGR1RkSE9xVEhCTTQyTEFWM0xBZGwrak5vQldHVUM2RjRxV2xJ?=
 =?utf-8?B?Vy9QckRQTW83aTVsaElCVzRKUVlNUS9KcW96S2VvMHRiMHhTamJ0K0lkNWgx?=
 =?utf-8?B?aWsramlLTGtHK29IWkVoaG1UemEwM3hoVlltdjdVOGdUSmwyRUY1aG5LNDJP?=
 =?utf-8?B?QTVibmNQQlNSalpFdkN0M0g0NUNiZlZ2YW0yc1dxa1VObXZTV2hLaWY1VzM3?=
 =?utf-8?B?cnZUclR4cFhtYlR1MW42ZDc1Vk93OTFTeldONGVEMHJoQ0txUWI0cGR3aDJD?=
 =?utf-8?B?b3F3NVhjSVZCeDhRZzlsVU1odXh0RFhJVGErWHovbkpMQzZaZk80V0o3MEtD?=
 =?utf-8?B?eGgzWjVlb3RzY09lRjNSc2R3M2E1YnFQWEJFTUpSNVB4ODA5TVJQT1ZBell1?=
 =?utf-8?B?MThOYnFjd055WmhZeDFWZFREUFpva3lkd0I0T2lHaUtiVTJjbDlZdzk0QzRQ?=
 =?utf-8?B?T0dDeDJOc3h3MVJ2d3EvanVpUzZwMEwwQnRqNmVHQjRDSXJscnR2cDZJSFo4?=
 =?utf-8?B?OWY5aHV2MHZzOVcwRldnVlcwRjNYR04rQXN3T2pkQnQ5aVNheWp3SnZ4eFNR?=
 =?utf-8?B?V1doOHRQdGQySER3dmhBbm9yaHpzSENvRUk1RFBEMVpUN2ZwVjhvOFJGdC92?=
 =?utf-8?B?aEkxUnJiUUluTmRwVHdtQUkzeFMyczNyZmo2YzVBaGc3ZXpLVTNUUVRxTENj?=
 =?utf-8?B?QVc2eUdaeXFQODRpRDh2VHFwUUdWVUlZa0x4dGVUWlA5T0gvU0VZQzg0Z1VP?=
 =?utf-8?B?SmFsbURBdjdxZCtXVEpPaU4xRXBub1YvUzh3Z0JaelJZR0JxZXlaR1c4aHgz?=
 =?utf-8?B?YlFpK293RmN5NlhDb0dnczIvM0d1dElGL24zSG8xQmNxRnNHb01EdElrTDBV?=
 =?utf-8?B?Y1p1NmNWcWdwUkQxeW1xVysyQ1ZpSXhqMlQvaVlmNGR6SVEvVzZsTnNkbUhN?=
 =?utf-8?B?dy9xYjJKbFBTWFdTZmY2cDZUUkVoV2xhdThaM3dLZ3lrZno0UnNDSkloVlhs?=
 =?utf-8?B?NTNHYklEWkQyNit2ZTVRZlp0QWhnRWJ3cDFzZXhWdXoyL3haWmUzc1lLMnBr?=
 =?utf-8?B?N1hWSVIvK08rVys1OHl0UDJxTCt4bHZ4dVpvTCtPTFRxakNjUVNOdnFOYUtR?=
 =?utf-8?B?aEhjVHd1am1nb051RXlzeXEzQzRGSzJqelJFVzJVTzR4NFVKQlN6eTlSeWRF?=
 =?utf-8?B?Z2dRWTNXSERzOW1xem1nMnR4bHNJcEFaSW9NSGhnQkFwa3l0aE5oMU8yeS9Y?=
 =?utf-8?B?MitxSmdNcXNtdTh5TVBDSlhxS2ZjUXI4S0JkUVpld0FHc1hXUzdnbGxPOG5O?=
 =?utf-8?B?eHU0cG0yR25kOUhZVkQxSkFEN0RoQUxQeUZpZmdzU2cvcUNqQTNWYnZHWVNi?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 770485b2-3d05-4fc6-4f28-08dd918863c1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 19:08:33.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IglpvNdbLWnM2GL8PfpjFDBB1hkf4/yfjZ2Duko/Z1Xznx07CnSCwp+TztQzSpQum18yxJxQCxl04Ri2hbUEKR/r+D7IPhBE4LHRNybDMwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8271
X-OriginatorOrg: intel.com



On 5/12/2025 11:53 AM, Lee Trager wrote:
> Extend fbnic mailbox to support multiple concurrent completion messages at
> once. This enables fbnic to support running multiple operations at once
> which depend on a response from firmware via the mailbox.
> 
> Signed-off-by: Lee Trager <lee@trager.us>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

