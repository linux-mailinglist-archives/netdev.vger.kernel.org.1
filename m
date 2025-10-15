Return-Path: <netdev+bounces-229753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AECFBE089B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B060A4FC9B5
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D399629D279;
	Wed, 15 Oct 2025 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="As81nSfD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DA1C8629
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557751; cv=fail; b=heWkJTvfKEUwKngrUh3aq0JM/JqweD+bZp8E+o6WTTZuqYYhzH5GwK+eoEYsW555kpZWs2FczTPzBLqVTKcxmeCBAQ9z8ZSIk8RJw9+x3JfX2ZHgegejI1ZfLJRt0VkfP/68HU6vwDFk4kbaoH3yv1BMFXrEPzBIvvYbpHBF8C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557751; c=relaxed/simple;
	bh=kBnLSWxMIoZGaaLt1TTtgqGlUu6WNmvJ8qnbRgvftdY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oTxzdvuobzl5ZAIwM9tLkkrOqJLBZ0SOha+PPH8xSmmrREXHexxeoR01CzC3eswDBdS2xrjUPvkqGRO1MUJvAEuKy64vcwkOvWs4Deu7VoLleZQlrI98uIx+Q+fheNM5NChUq8ql/Bx0MjToeL5akG4QlMzLFh/UtHMoecB3yPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=As81nSfD; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760557750; x=1792093750;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=kBnLSWxMIoZGaaLt1TTtgqGlUu6WNmvJ8qnbRgvftdY=;
  b=As81nSfDOwq3y8D5UXrVoJMSy9OF91BO0bb7Yl5kVNqbvRFw2yqITtve
   zFsRGHV5EgdcBeHZeah2UdLIbCVaa06JQrX/iQO26JYNw/Wipv1J+aDSo
   USe1NbYRkG0n/bYMhnGuW5hN4MRlF4+oT2YaXvL8tv1PfT0EJbCayYvY8
   RbZZldyEV7ia/DdqXj1Oa3EKMIZPCRuJ6+I/Eiocv7F0VYm9v3XBxWxjc
   Uc1q1nhRY08GlzkAIzdpJ3FGAsc51cuiUF8PY2tsGeI8XZI3b1Ni1H10P
   Kv7gcR1etTnyYWNq7v2ZtGNXQWnkWMUovQip6hllRyEooCtWm+WYx9rQO
   A==;
X-CSE-ConnectionGUID: nmXqbgGjR+uKuMDU+yIRLQ==
X-CSE-MsgGUID: NcYbXqy9TyWZajYa7iXQAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="61774085"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="61774085"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:49:09 -0700
X-CSE-ConnectionGUID: O5SB6D0zQZyO4SKI8Y5+Vw==
X-CSE-MsgGUID: ZmXxZ/ebTPyw/RmG19uX2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="asc'?scan'208";a="187353151"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:49:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 12:49:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 12:49:08 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 12:49:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDamlrNX2ADwsLCMiF5rKbH4zgvPOYpyeUyaPyFbEiCzUW3kGSZqARIBXHOTz54S2KGdstqjdXKntRBK/kXds7RuOu4PePGULhv/VSLHOdeq6dkIhvVNtrmavbRQ4UDO/RehTVbcaSBwDCOuzJYE/DDU1Ba/gbpI8ELINqABC4p+Se7eymL4Jeudp1LNOWouYW9abe74pnaNpV8CcHVvNKLptRBdjR2lkbZYtG4ZyQEQ64/lpz6EdqCiH2dYbf+q1hZUO3h5PSTSSvN3dJxMAywekqqT6UhNFzQcKpRuEkQnOhEebYZ3YQfvnzKsev7pi0od+8FwECYntp1RADOCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBnLSWxMIoZGaaLt1TTtgqGlUu6WNmvJ8qnbRgvftdY=;
 b=TmYQXtT0z2+x1QRToD/PpvwXHBtRxIlMrF2dPzGtqayHjMeumsYQ9FWDKGKCdA60nGsTp/aWwbf9EiJ0t6+aDOiIEnRlT9KwdWULI4olWgvsaiRxfLybM7TjX7fH0EnTJsPBziRt+CjEWVtDZ7BfRf66XP9W8qPvg2mr8voOVOdvjeG4/cCcKqeZGp9o4GkbB+T/U86lXiawf5DjjXgJan8BZDPhyOXl/PUlwc/neVj3cty8AO3g/OWOPUM4aSO9JMYoFrPLBJlHw95/UrKbV5yGymN3zXLzroo0hz2lUSGhXHvWsGflACws/rVcQs/NJ3AwTsKlR09VkXYw659NSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN0PR11MB6135.namprd11.prod.outlook.com (2603:10b6:208:3c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 19:49:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 19:49:03 +0000
Message-ID: <fd04bc00-7ef1-4788-9313-2fbf27e480e6@intel.com>
Date: Wed, 15 Oct 2025 12:49:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/7] net: atlantic: convert to ndo_hwtstamp
 API
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Shyam Sundar S K
	<Shyam-sundar.S-k@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Egor Pomozov
	<epomozov@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Dimitris
 Michailidis" <dmichail@fungible.com>, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Simon
 Horman" <horms@kernel.org>, <netdev@vger.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-5-vadim.fedorenko@linux.dev>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251014224216.8163-5-vadim.fedorenko@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------6dUmScZrwq4c2XVfLieEMWto"
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN0PR11MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ec3e8b-4b55-477c-4a58-08de0c23e48b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REp4bFZLSXlkVUQwK29wR2pZeVpCa2QwYjFpelI5TzY3cGlRTUNiR1E3L25R?=
 =?utf-8?B?QWZQOHNoUGxPZVY2RFhkMXZYclpwdTFvRW5UakJjS3pCY2w5TG9EeS9NZWc0?=
 =?utf-8?B?UUZaVllxOGhuUlB6T2hHVWhKT0s0NFRsWGs0eElZcTNvREFKYUJXa1FLeUFG?=
 =?utf-8?B?L1I5WnRrSjBIVnNITGMzdFhJZi9teUlsSUtRTW9RU2o3ZmxtdjNhM2NIeXgy?=
 =?utf-8?B?SWluSUc0bTY1WVlMcXIwc3d5L01Za0RnYVJqTkdFYXhwdDhHb2s4d1MwRVNV?=
 =?utf-8?B?RzRQVHRGMHdJZ1BQY3JrMGtGRGdvTnFBaGEzL2NlQnhzV3ozMzBRdU5Da2lL?=
 =?utf-8?B?bnBPUHltM0crRkl0RzRWWE0ycHRUYUx3SCsxbHJKOFU0dkJRUGg3WWdZckUx?=
 =?utf-8?B?aTFIUkIvWHZmQ2JYd1ZCNHB5T0c4NjRkeEVtRFB5VGx6ejRTTFVzUEt5ZTBJ?=
 =?utf-8?B?UjJpOUFQVzljam9sVnVZUUxWYWQyektTZFBZNlE5dkxpVHRiTFM5ZkdHU2ZV?=
 =?utf-8?B?ckQxdEFwT2NpKzM0ancrRUFYMnRRekxkYzRCNWFCcG1aRFlteWNQQWx4R1Mw?=
 =?utf-8?B?T0N4MWZzVHFqaWJTK1VGNG9hNjkwK1lqaGptQm9lRlhhREhxNldMR1ptZXc1?=
 =?utf-8?B?eTJDeGNJb0gvdCtobTlzR2MvSVhPUjRJUEllTWhxU2dKWVFrSGsrNDA1QXVG?=
 =?utf-8?B?cEgxUGtjd0lOTk9DV3IvOG5GMG5hU0lZSDNKOHUzbGNSL3hOa3U0YnQ1WE1P?=
 =?utf-8?B?SWZwdzgrMEhVUEk0bDFlZXJNZFh0RmhwVDRZWHI3SUhVSXdvdUZuRE13Y3lY?=
 =?utf-8?B?ZjVybW5CRElMYW5iOGRySk9SQU1jQnhhS3M4bDdrTStFSFdqTFMxRVpiazFm?=
 =?utf-8?B?NG5vL2FnWVVzd05iVGhPNUhpQU55TE5EeGV4blQxZ0dManQ3dThXeU9qM3Zo?=
 =?utf-8?B?emVHeWdQUTF2MERrWENGdGtJZldpZExwb0FTQWpLd0Y3V3h5aDZJTmM4Wm9J?=
 =?utf-8?B?WjVPcndDS2tjc0NVNjRXN3Ywbit1Snhvb2pDaXA0cXRybkRRTXlqZmdibHFN?=
 =?utf-8?B?dk1tRW9YemdTb3RRcHVrV3Nab0l0b3JENGt1ZFU3ZDJGVWlVMVRFd29NMy9X?=
 =?utf-8?B?V05ITlZmcVBQcGJFYUxmMG5BYUJKN01VLzFqNzhLYmtTSUxMYmZCVDdBTjJv?=
 =?utf-8?B?SnRva2w2bjdiVFo3NzBXQmRXaEE4Ly9xMWQrS21NV1lvY0dLNGlyQmZEY1VJ?=
 =?utf-8?B?QU1GUEpzRTNKYk4vdTM4a1VNSFUwV2UzcnZnZlNKSzdTRVcxRis3SW5aZW5E?=
 =?utf-8?B?dXpoQkZ2QUFtK0JFaCtMS0VVRU9xRkF0ZFhrT2tRckRhT2taaTQ0bEJmbmpr?=
 =?utf-8?B?cXVQMlNodHkyWWlwZTd4Nk5FZStzWnpYdVF4aTB0WUkyQW56TWtSN2R0akhC?=
 =?utf-8?B?VFpUQ2tSYmhzalVsZkl2NmtpYVl2RklnR0VWdUtYYTZTOGNGaE9LS2J2UW9w?=
 =?utf-8?B?a3MxS2hzNXlLRDBWVlMrK3owT3paVkJwdXJmK0Erc0ZvdWhPM1Yyb1ZLZFdP?=
 =?utf-8?B?dko2Q3BnVkJ3WkY1Q0gwcG44OW9pRUhNWHp5bE9nWkt1VTBrTGx5SVdNSDRj?=
 =?utf-8?B?SWdHRXB3c2dlWVpHUGM5TWtCQlhhZFhiSnY3YVNQWFBXd2tyWExZdkpCaXoy?=
 =?utf-8?B?ZE9UdTdKSmJacll5cmRNWUdRbXh3a1lFMHZXNSt1M1VnZm5veFFabG9nL21w?=
 =?utf-8?B?MmVzNWRQRWNmWlZlbktZcEZ4SUpDbVdGWnM2dFAyZjVvWnZvT0F2bmVuRXBG?=
 =?utf-8?B?SkxqMCtuL1Vkd2REUTZMS1lLd1JRb3l0QjlTM05TcWQ5MW1LVGFBTDFueWpO?=
 =?utf-8?B?dFlpQVhLTExsMVF0UDZONzNicXZpVVhTZEEyeGczd0ljMjFQWmdhcm9WQWU1?=
 =?utf-8?B?UjdCdTZIYXppL0tiZm90VTg2QXNDQ3BJOER3eW4xdEZiWk03SzFvSkJkU2tI?=
 =?utf-8?B?clhuanQra2hHL2J5TlBKNDQ4a3NicTJOZVExcnNYbklXbTQvZTh1Uk52Qlhm?=
 =?utf-8?Q?VVnVvF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGdxZlFUYVFOTEVpVkVNaHVUcUdlaG5IVDJGNnNmU2lDcTBpZmgxYVk3Smxk?=
 =?utf-8?B?RTF2N29tUG9tU2NvMmNyOHJHd1paRlgyQ0lkSXp3a1hlZjFkMFc3Qk0zUkNT?=
 =?utf-8?B?bWc2MEV5MFpjMUV4L0pFY25jN3Z6cEMzOTViMjJDeVNtcnZtRXhhbFE3SFdm?=
 =?utf-8?B?azg5VEtJZ0t4b2tFazV5WVJmT05CaUcrNjBhazNWcWhaRmFiRVdtWmtoZDQ4?=
 =?utf-8?B?R0xTUkVMVXk2NjdnQXIwTjhjYXhBQndPZ3JRNjJMN09vOFdzZzdrYXNnV1h2?=
 =?utf-8?B?OXJ6UVBaYUg0T21qZUJUaEVJMXNBYmo1RkFSSXZXV3NNZ21VNjZxdWRuUXhB?=
 =?utf-8?B?Y21SK085OS95UWxIcEE5Q1dDQXg3SWMyd2hIRFlnVVZTUmp2REl4eFdGT3hM?=
 =?utf-8?B?SGpoakNJTEx6QnAzVjZzbmVKb3F5RndNZ3FBUDM1c0JXeGRyZXVGa1FiSjF4?=
 =?utf-8?B?WG1CejdubTRZQXhwaCt5R21XdUZaWmVJY2dqZzloSnMrL2ROcFg2UGg3OG9l?=
 =?utf-8?B?WEcybEJUMU93cGgwL2xMNXROc0ZjckgrdC9JQXpRNG9Scjh2YkJKUVpBdDJF?=
 =?utf-8?B?RnBPblRuQzVMOWRDdDA0dXFnNVd3MVlrV1dqbGl0bjc0ZXpMbUhRTDhQWUUv?=
 =?utf-8?B?MFlGbDJHR3B6N3c3aWVsT245VWlUVFZRNm1rbjdUdDVJYS9SajB0N2g3ckZy?=
 =?utf-8?B?Tm9BbkxFQnEzR2tKOHlaRnQ0NVB1SnZTYjZXaUxxVDlENFlTbEI4Qy9vTkZQ?=
 =?utf-8?B?SHZSSmNxVHk1RUw4eFJ1S2Y0VmpMWitUNUtXSmtPMWsyK2pBZHdzZ0Q4VzZn?=
 =?utf-8?B?NmRVYWVnTVAwdno2Rjl1bHhJZ1RjTEFTR1RFNFo4bUVPakphRHBIa2NjTWEr?=
 =?utf-8?B?M3ZwYzBuOWZJRmtvaDl1aXhaa3hKYkFKRXVoTURuYm80L00vbnBvNHZ2RDZJ?=
 =?utf-8?B?R2NkRFVqa01HMzBZQ1MxbXVKM1h0d3dySnpRNXlWdHNEK20wdjdBbHAxKzBT?=
 =?utf-8?B?eEhSVzI5d0RwY2F6MXJ2Q1RQeFY0V2xZUFBndVNPQ21yT3pQT2hDMzZtdXU0?=
 =?utf-8?B?UlJFOUl4MjlTMmsxUmt2MktHOUdLZWEyazZYOC9jMXFrZlF1QzFRWm9Ma2VR?=
 =?utf-8?B?a2phNnlSeldGaHdVNEp0dFhEckNGMURYZjhTMGpBTG5sc1ZLMlJVNGFQMkVE?=
 =?utf-8?B?T2ZsMlYrcmQ0OTdtSis1VVFhSk5aR3JyVE9Cc2J4c0NDdDJ1NnBIZmJTS1k0?=
 =?utf-8?B?VG5jZzFSZW5SdGZZTzVjaURwc2MvRFd6SHhBb1MrZmNXQ2hxdVlFOGlUT0Q0?=
 =?utf-8?B?STZTUnFlZko5ZnNxbXZCNW1RSmttZ0Z5S1NxcDhEVDhVcy9kMW1aZnphb21K?=
 =?utf-8?B?S2hLT0t5TzZmYXppNHpoQmFXeUhpNlE4bklFYmNGdDlqeUgweTVHeVpsWndx?=
 =?utf-8?B?VGErZFdlcGFBMFYwcVQwRWNiOEZsQzdwbmJNUmZ4ell3cnNZbG5MZTAvL2wr?=
 =?utf-8?B?aUVPckpZSkc2bG8xSXVsdEM4Q3J1MDZCQk95WUhjVDFGNjlmSjByUEdqVy84?=
 =?utf-8?B?TkYrbGs2MXY2c3QzUmw0NzVaa0crTXc2ZDluTnBXNEJNK2NQM0FSOStLelRR?=
 =?utf-8?B?dzAyT3NJV0xMcnNLS2xJQThYVzJMQm1DMklLM3pjN2RzNE16RHN3ODRJNWpt?=
 =?utf-8?B?MnhTN0NWTFA2Q0JIZW9VcFRJUXhwZWV4anFYZFBnMjd0ck00TVIyZTV1UFFo?=
 =?utf-8?B?ZW9OTGRhdjlDY3I3Z3ZlcEpCKzdSSUd2cHFiTWxzSlBMS1ZzejBUaTNQek5m?=
 =?utf-8?B?dVNUd2JLZkVNTGZUQS9vYlJzNzNoZTNJZk5nZ0VvV1k3dGlzTEdPZ3BhU3VQ?=
 =?utf-8?B?K1hXUHdZTXlqQUJieElseTgwQ2VBbXEySzdPcVFSZFdQQStGU01YcWNiUzJO?=
 =?utf-8?B?eHNKRHNTTlIwWnNzSlVOUW1UZzI3aWhqMU8xTCtteGpvQTZia01ycU1id0pk?=
 =?utf-8?B?MlQ3V3piTmVydFJUMnRGV3A3amVvb0JhdGduMlFZNlk0aUR0cUU5M0M2c0Uy?=
 =?utf-8?B?Nzc5QmhtOUtjREpWb29EVmc2eGh5S3E5eVp6dkVhejR0Wk14SGJ5Mmw2Vkh6?=
 =?utf-8?B?UmlhSnk1WitMd3dLU1NZQkdvWUh5OVVtYk8xOG01eFp6a3UrUFpXWVJhblBh?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ec3e8b-4b55-477c-4a58-08de0c23e48b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 19:49:03.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBBH0WjFRm0mIYp5vUeEq2XyFNJ35tS8mBzYbsISJ8vgZAbSHg40xaasEI0xoUxyqb2RxiAM5yNLO1qjZ47QHGmzFFnnUDn2CxSiCZy95MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6135
X-OriginatorOrg: intel.com

--------------6dUmScZrwq4c2XVfLieEMWto
Content-Type: multipart/mixed; boundary="------------bHBHkOwjKTHxx31U7zgPMKas";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Message-ID: <fd04bc00-7ef1-4788-9313-2fbf27e480e6@intel.com>
Subject: Re: [PATCH net-next v2 4/7] net: atlantic: convert to ndo_hwtstamp
 API
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-5-vadim.fedorenko@linux.dev>
In-Reply-To: <20251014224216.8163-5-vadim.fedorenko@linux.dev>

--------------bHBHkOwjKTHxx31U7zgPMKas
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/14/2025 3:42 PM, Vadim Fedorenko wrote:
> Convert driver to .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
> .ndo_eth_ioctl() becomes empty so remove it. Also simplify code with no=

> functional changes.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------bHBHkOwjKTHxx31U7zgPMKas--

--------------6dUmScZrwq4c2XVfLieEMWto
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaO/6rQUDAAAAAAAKCRBqll0+bw8o6CpZ
AQDybdczt4OTBaByy/Do3jaDYjjsOvRxHuGC9YTOtZ0bKgD/Q9ue3ujxAlQDIBwRh5UmkLqxUKmS
PJAZ8k0jaPF3nAM=
=tIhf
-----END PGP SIGNATURE-----

--------------6dUmScZrwq4c2XVfLieEMWto--

