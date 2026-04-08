Return-Path: <netdev+bounces-276730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W45PJyra1mn0JAgAu9opvQ
	(envelope-from <netdev+bounces-276730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 00:43:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E593C48CE
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 00:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2181A300752F
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 22:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87F9381AE1;
	Wed,  8 Apr 2026 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxssWXUU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F2F3537DE;
	Wed,  8 Apr 2026 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775688231; cv=fail; b=Vlh9V0TZ9lHXXEmsMbxinbRD1KUInr65cQGMW/qRpg7lhFaE6yvb5r0bYOKiLhgcma3yydSVXkdIVRV85/fDyOTvxdtSyg8h0cMyvRU+whcKZQmAQ/v4n3Wdo2o6z1+JS5vMLDHwNoG9Mx/kSQ5ar29eib5qQ7bJO+GEupkD6UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775688231; c=relaxed/simple;
	bh=0GmJXTKeKTyxe+twb4bnRm7Avb5TM+aitCpGeHp539k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j9XczeIbqazisbCnXGoPGhJUb1bt3wWvsrIGSDW/aODC8g49ZdYUoNCzngJGbDB19aKibsJHZwshyQezxktTusDkLJe1iXZZbXKM7hacDFkvoqjt8oHAFkJnNXG+XiJT/+vmvPwHkmHnn4tRspz2WzooYTP8hLYzLi3Kg+xhEws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxssWXUU; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775688230; x=1807224230;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0GmJXTKeKTyxe+twb4bnRm7Avb5TM+aitCpGeHp539k=;
  b=hxssWXUUBpiq6XFJwFYX9QqugkHzlWkmze8/F5V86hIX+CUDlkWXdZB7
   bgezjZnjcwF7h63yCaMTchNssbZEkQZgPaOwksTXzazmHatysyG1C7Gxk
   c1UyVyd5zwUeYv1grR64XeWjqEeFudw+yfkJLKVW3UQfyEHtdY6Ndio7w
   NwzwlagTHM0R1i9bD4Epm8DdOT8QNIhpW9fFy7oDvTYBWoLPuO2LrxMbg
   Jf8KuqdHEc4IvoqKFbvTIL4o2wEhMPoub2YVFnhxOwooEbZheZavJ+4Vv
   GewglIk6PI7AbTu4xzdnL7RxnQOXWaLMK4TOaozVP8UuK4zFoge+vvuDR
   w==;
X-CSE-ConnectionGUID: kf/alyvkTca+cvv4KZzXjg==
X-CSE-MsgGUID: zj6eoPyQRFCshGoCTn09kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88070452"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="88070452"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 15:43:49 -0700
X-CSE-ConnectionGUID: HUHdGTaGSVyPAqeYx+JiJw==
X-CSE-MsgGUID: bqEZnFhsSXmjRhKeGuo9zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="228827005"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 15:43:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 15:43:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 15:43:48 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 15:43:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfLeL45e0YHCL83G1yxEEu8bJtrXxqo6tNC3bJbbgzuG44Z1BwN4jZSkXE5pS44CEe7SGiYVaoTZ+ziuKHrdo+ngUKCmMo2VbEOXTdc5RgV+26LXYwlqk/ETBQxdelWZnzbKM7VIj+WELSO3Z1gdcBGB2DjoJLj/vXW78wKYFFp4bVjfaBaudff5s2Mht7UchPe22+/fzpcrxAIDfjQYRO8KlaAyZBKLnTesricPKziezj2/X9k2E3n0HmzTJCzAr87ZtuaujBZWpsHt6vPojPsf6K3FgN/65Zm4N/rMsNiqULtByx2OpXSzuCsi8FM7Cxvrzb63ixIIKBOYRsxpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=604lpA0EbqCrWLJ0OfhSuSTig2S/QeMJiCH/+bjOfds=;
 b=JTnirGtftpDWAaVngoReauvww1Zt93SYNT4Q4Q24NSXVWh/ZkQV10QkMlmx6PDFa6Djt2LkOm2bT9rsmzcUmbhYtTAY2JMKxWXZyk8VYklN3e5zAEABGeEi6742nKs0lttUSOp0zW9DhSKU17HXmKTDx42ni8CeiPsp6bvRnm8+WjmktHzKCupBHi5Spn5GnwWw6ZivCZynLfPRr3Deh9QvvWqn0969FoXlbXHRz9NJQ53BuS7JHAv3UKTXj8T6ewTUkQyo5Zy9wvYS2u+RujOxuI3UqJ3EJsXK/Io3rTai0kwad6WTGPB2DUJfvbw+LrsMTiQyTxXQU4xtKtSgD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH3PPF76AA2D882.namprd11.prod.outlook.com (2603:10b6:518:1::d30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.38; Wed, 8 Apr
 2026 22:43:43 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9769.020; Wed, 8 Apr 2026
 22:43:43 +0000
Message-ID: <093a5c92-f94c-49d6-96ea-0c76ff18f9e1@intel.com>
Date: Wed, 8 Apr 2026 15:43:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] gve: implement PTP gettimex64
To: Jordan Rhee <jordanrhee@google.com>, Jakub Kicinski <kuba@kernel.org>
CC: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>,
	<joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <willemb@google.com>, <nktgrg@google.com>,
	<jfraker@google.com>, <ziweixiao@google.com>, <maolson@google.com>,
	<thostet@google.com>, <jefrogers@google.com>, <alok.a.tiwari@oracle.com>,
	<yyd@google.com>, <linux-kernel@vger.kernel.org>, Naman Gulati
	<namangulati@google.com>
References: <20260403194427.1830609-1-hramamurthy@google.com>
 <20260403194427.1830609-4-hramamurthy@google.com>
 <d02145e3-8ac4-4057-a888-3ce074a295ea@intel.com>
 <CA+mzVtscZ9Dkcx8vq6MpCjNHqep3PoeuZff=o_V9usRo6eLBrw@mail.gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <CA+mzVtscZ9Dkcx8vq6MpCjNHqep3PoeuZff=o_V9usRo6eLBrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:303:b7::6) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH3PPF76AA2D882:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d54eee-d85d-49e8-6863-08de95c0499a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OsbiTfO6K2Uonix+H0jRPBJRvwYWPZJ2yI02YzBzwKPdWauxcPoawrXlQlvny7TUyVnuZtCA1Agee4JDk9mmwQtRMS6IJRmAIBoAbe5zDt1EvBmzEoKh5G+oNKYYmatRvE2U83jT0B5rVw85SCIbtrEcj8nuOc3Cnt3wMcjNTjVMztzMJ3N/Wokgg1FPF0X+yGf9OYl6VfCdT9TVW/VubJ+uLW+tGxPiGdlwofQCif+5SeXUsp/Hi5ldJmFgguWTXXCkGmFuGUOJ0qqLOSWrtG9sTdqy0oddm8XWImhRvmmqZjU1dcjbeJfYIqGLpB5cB1ZrGO/G/Gw+2FafcSY+pqQEcyIjtGz3vtpRUb/9RHDtS8u0JvG2DrVxe8HeDG1N3Z6ZXPu0V44/aFhcjDTbOMbOkDhvfCfhnfho+H01X29Vsz20p62VbHGEjuLX8BAvFurZSDUxdY/gB4Dk0jjdU5t8Q+TFPcK934gNtxpJ5i5XudhoX2YFGwsaV2Np/5gWz5BrRi/Ge37SigCJrWeAex+XEN35sNS1jiTNRP4TS9L/zxKJwHeGP4trrQklx6FUWwLJc1vDlusirQM10VVwhXBuWV3+E3BQlcMssD9dyEqAxumJNojqnaDaARblX/ER0W9zS1nvZgEXYcso+W3cvi8N2r6wrmrsS7ohGNvaT8SPpJ+oB1JJvNEA6oRcqckwDbYSRugH2qL+/N//GDUa7jj39Pww2EvTv9tCYoJOSQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVd0elFuNWJKT3lQaW1ZOG9hUzRtSVpQSnpQOFBMYjlhUDlQU3ZoN01FZ3Vs?=
 =?utf-8?B?OGdZRXBTNWhsby8rMXJIelNOSFV4SjFpM21TRGtlRDdIanh6SnRXQWEwK05N?=
 =?utf-8?B?cXEwbWk3Nmx2REZvcERqV0x5bGU0VjBJV0lMYkVFQ1dwVGpNdFJxcklTWWpn?=
 =?utf-8?B?blJuT2M5dGtoL3NMc28rLzVrWVV6TkI0RjdHYTg0YmJIampOaVlKcW9VSGI4?=
 =?utf-8?B?VTBFK0VMUWF6RFlyM2pLcUpHL2hlMlJuSHZScFptZ211c1ZIQjV0UWFMTVFH?=
 =?utf-8?B?MDhKdXJhanRHMXZ4QmZ1VStEWTU4bER2c05yMDR3S0RMQm54Y2NvNzJib2xj?=
 =?utf-8?B?UXFFbE5HUkh4QnBCbzZONnlqOS9menNlUmE5RXRzNGlxejJCWHBzYUdzbUty?=
 =?utf-8?B?bTRKWHpsVjVWQlBRQVRGK0EyS09OR1FMSGtlUy9ScjE2UUFGU05nVXBjZHhp?=
 =?utf-8?B?SE9ZZisvZDZiNGV3Wkg0OTNpM1B1SnpRMnFFZ09wUWNhUzdPZEtLNEEwNW14?=
 =?utf-8?B?d2VyTXdOWk5LY08zOWhSTXVkQVJxSnhneDVQOWdKRklTQW9qanFRREtDNEx0?=
 =?utf-8?B?SVRSQ0tuaVl0UHBFRm5kdUY1SnRJV0ZFa29vanAxV2dyUzkwN2pJMlZkVlM5?=
 =?utf-8?B?bWtTV1FUTDNhY3BRMEpvMG5UWXkyb3oyaWtRV21ndTRzUWR1MFpMR1RJd0Ft?=
 =?utf-8?B?NlI1SHU3bDZhYlVSSzloeVFyNlFDbnA4cnp1Q2laaGpGejRZUXltT3dCOEE1?=
 =?utf-8?B?VlUrUzVxVm4vS09PempaeFF6dXlzQkl1cnEyZWNjdHNJSm1LdzM0R2YxbzZE?=
 =?utf-8?B?Q2wzMi9XWHhNZmFCUS94Mk4yT2xBU2dWYzlBczNQSDMwQ0pJbENCcklNUE9E?=
 =?utf-8?B?UytVdEhlbHUrdVlRZHdzMFZCUGRJbHpHOXl2UUJBV0pGVnVqeWN4OEJuYThY?=
 =?utf-8?B?c2E5cGJDWGgrdjRDeU5OelRDRGtXYXk4TGkvRmJmaFllOXlHUFBZeVl1Qm5Q?=
 =?utf-8?B?aXpySUxDNEx4N28weWlKS3BHQ2p6bzcveWIwUHAybS9kYlJ3VGsydnlHdHV3?=
 =?utf-8?B?UVJqSk9sbUU2OW44UnlqZEl0bTJRVkgxRDg0TW5HbXBBN2UweFB3UXJUejJ0?=
 =?utf-8?B?ckkwNTNaN2VRbmFyV2RlVkxsa3ZEa0d1WkVaT0craTFPOGk4Nk54OUhrdDFS?=
 =?utf-8?B?RmUrTERhQXIyekYzd1ludElKdW9TbUQzS1JLMVhBQUZIenRJTnpydXRyaE83?=
 =?utf-8?B?K1M5aWt4VGhPdUF0RHMwMEJPZlU5eFlHVm9yN0pVNzhERzBMV1RUZllSZzJw?=
 =?utf-8?B?YWdvcTZaN2NOK1pIVjBiSEZweVFxMmNSc09Yd0lnV1BLaVZ3ZEZ1d3RXNkVr?=
 =?utf-8?B?ZGZ0S05pK3Y4OTRJNXZaOGRlZ05rVWpHYXRsaG9oWmszb1VJWjFFSDcvY0tO?=
 =?utf-8?B?Nis1TEVMWDREWDZXY3dWYjFQT2Q3U3h3MkxvWjFCaGZqWHNGQ210Z2k0SEEr?=
 =?utf-8?B?bXFEcVl4c1JnZFI5NStWU0E1Y1VtTHFmQXc2dG5PMy9QakpqVFdtWEtpaCtO?=
 =?utf-8?B?ZWdGT2NsSFR4WVQ2TEYzNWkrZk5wMEk4Q3Iva0huekowKzh2OHhhU2t4TnhS?=
 =?utf-8?B?bExPZFAxemhTZzBody9nTThPUUIxYy9PWWtXeWt5TU5nRTFTakFyd0ZzaitO?=
 =?utf-8?B?dCtVN21IMHRHc1dQSWRWaFh1dUY0QVVSU0pWTmVpaktBc2hUdHJHN0hJeWZ2?=
 =?utf-8?B?T09neVpzVXZNc2FNSGE3ek1hR1E3aTM4dU4xYU8rOGRUZ3FGSUFwcktneG81?=
 =?utf-8?B?TlVjUkRsTDQraVE1bUtnc202MmZrVWEzUWVoSFBXY2RSalN5eHdXNDBjdFVp?=
 =?utf-8?B?VkhNeEs5QzN4Q04zNzNHOUQyVm55emV3WWlvL1hvYU1CM3c3MTJRbzh1SkQ5?=
 =?utf-8?B?d1Z1K2FOSjJTcllLdHhmRkdCMWt4R3pYVEY2N2lmZ2twUEJpUm5SSVZ6b215?=
 =?utf-8?B?aXlpU0o2VHRWcmloakZXZ2NhVld1bzI3WS9ldjN6TzU3QzBDL1BIejNhblY0?=
 =?utf-8?B?Q3JRbkcrdWZ2TzVjZGRrTml1VkI0Q1JlWENqTFZ0c2ZFMXpaVUJQNE9vQk5O?=
 =?utf-8?B?NkFvRVMxYW9ySXFSdmcxY2EremJFQllYUGhNU2FlYTJYMDQxK1RiQVZ4Z3Z0?=
 =?utf-8?B?bE1GOHNOdkJWNnZRTTFEajVwNW4yUnhwempxY2E4VUU2OHZNcWI3MThPQkZD?=
 =?utf-8?B?eGlkTW5OYzdiMk1MZHE1VXE3TlBCSTg0Y09qZjdSZHNldEJsalRqKzNKZ211?=
 =?utf-8?B?RHcyQms0a0Y3QUI4Y3JyK2VhbjcxcEpRMmVyWHFwaldrWDdsU0lIMzBHNGc3?=
 =?utf-8?Q?3j9vAWPkWkWSTtGo=3D?=
X-Exchange-RoutingPolicyChecked: g8ynxo1sb0PbBpqm99vcbyDx08ZmoEOcMoJ7QN/WUgGUyek58sHu9q+9iHlyeOkZ4VJTBAmcTR9xTL4Of9jWoUMT4tpMjQBW3p29g0k9a1+O2KKE5ZijRDOElURMHLkCCU32c/NuXUFOiTOIfBYBAVKVrfSA+NDy3anns7twBBoQgLjRSp5d/6e2L5B0hT4iUd0e2StfywcjEOlz82oQYVHD8XrKOvNwvm25OnzbWpGW1oOXH6RslFD018h4XU64tFKu+HhndbjF9ZTYQqtSBr+5yCZRLbTG7p22QU0ijCZ5Ht94XgIzCudqNrlICPZlWSUmahoPg6iE8tg1zBYVrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d54eee-d85d-49e8-6863-08de95c0499a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 22:43:43.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4L/Hxpjf8IcnLxmMc3nzr4gbg/nHJfwQSdbnliavWYw+Z3xWmoN35pLHDI+ZZPbSLO2MUpRpIlHrGbq2mb5WjvyXYqrvygX7vYULgLvycY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF76AA2D882
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276730-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 39E593C48CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/2026 1:41 PM, Jordan Rhee wrote:
> On Fri, Apr 3, 2026 at 2:18 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>>
>> On 4/3/2026 12:44 PM, Harshitha Ramamurthy wrote:
>>> From: Jordan Rhee <jordanrhee@google.com>
>>>
>>> Enable chrony and phc2sys to synchronize system clock to NIC clock.
>>>
>>> The system cycle counters are sampled by the device to minimize the
>>> uncertainty window. If the system times are sampled in the host, the
>>> delta between pre and post readings is 100us or more due to AQ command
>>> latency. The system times returned by the device have a delta of ~1us,
>>> which enables significantly more accurate clock synchronization.
>>>
>>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>>> Reviewed-by: Kevin Yang <yyd@google.com>
>>> Reviewed-by: Naman Gulati <namangulati@google.com>
>>> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
>>> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
>>> ---
>>
>>> +/*
>>> + * Convert a raw cycle count (e.g. from get_cycles()) to the system clock
>>> + * type specified by clockid. The system_time_snapshot must be taken before
>>> + * the cycle counter is sampled.
>>> + */
>>> +static int gve_cycles_to_timespec64(struct gve_priv *priv, clockid_t clockid,
>>> +                                 struct system_time_snapshot *snap,
>>> +                                 u64 cycles, struct timespec64 *ts)
>>> +{
>>> +     struct gve_cycles_to_clock_callback_ctx ctx = {0};
>>> +     struct system_device_crosststamp xtstamp;
>>> +     int err;
>>> +
>>> +     ctx.cycles = cycles;
>>> +     err = get_device_system_crosststamp(gve_cycles_to_clock_fn, &ctx, snap,
>>> +                                         &xtstamp);
>>> +     if (err) {
>>> +             dev_err_ratelimited(&priv->pdev->dev,
>>> +                                 "get_device_system_crosststamp() failed to convert %lld cycles to system time: %d\n",
>>> +                                 cycles,
>>> +                                 err);
>>> +             return err;
>>> +     }
>>> +
>>
>> This looks a lot like a cross timestamp (i.e. something like PCIe PTM)
>> Why not just implement the .crosstimestamp and PTP_SYS_OFF_PRECISE? Does
>> that not work properly? Or is this not really a cross timestamp despite
>> use of the get_device_system_crosststamp handler? :D
> 
> .crosstimestamp is for devices that support simultaneous NIC and
> system timestamps. Devices that don't support simultaneous timestamps
> have to take a system time sandwich by calling
> ptp_read_system_prets()/ptp_read_system_postts() on either side of the
> NIC timestamp. Upper layers (e.g. chrony) use the sandwich delta in
> nontrivial ways when estimating the system clock / NIC clock offset.
> This is information that must be preserved, and it would be incorrect
> to implement .crosstimestamp by returning the midpoint of the
> sandwich, as tempting as that implementation might be.
> 

True.

> Gvnic does not support simultaneous NIC and system timestamps, so it
> must use the sandwich technique. Since the NIC timestamp is obtained
> using a firmware (hypervisor) call, the uncertainty window would be
> too large if it were taken inside the VM. Gvnic takes the sandwich in
> the hypervisor and returns the raw TSC values to the VM.
> get_device_system_crosststamp() is used to convert the TSCs to system
> times, which I believe is the only correct way to do this conversion.
> Jordan
> 

Hmm. The function says:

"Synchronously capture system/device timestamp". That is what confuses
me. Your implementation uses gve_cycles_to_clock_fn() which just sets
some values in the system_counterval struct and exits. It doesn't
"capture a system/device timestamp" tuple.

This does feel a bit weird. No other caller appears to exist outside of
the cross timestamp implementations.

It sounds like what you want is a function that takes a cycles count
value and does the conversion from TSC to the appropriate clock, along
with all of the interopolation etc. What you've done is sort of a cludge
around get_device_system_crosststamp() to force it to do that for you
without actually using it as intended.

I'd argue it would be better to have a cycles_to_ktime() or something
which takes the TSC cycles value and the appropriate clock and does the
exact same flow as get_device_system_crosststamp() for converting the
cycles into proper ktime values without the mess of the callback
function etc.

I guess in principle what you've implemented is "correct" and
functional, but it definitely feels a bit weird to use the API in this
way. It smells like a neat hack instead of a proper interface for this
purpose.

That said, I won't object strongly if the maintainers are fine with
using it for this purpose.

Thanks,
Jake

