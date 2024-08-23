Return-Path: <netdev+bounces-121478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD4E95D4E9
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851021C20B14
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFC2186601;
	Fri, 23 Aug 2024 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="novWmeTl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F233186E3B;
	Fri, 23 Aug 2024 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436661; cv=fail; b=UJJCqWYtvadTXfMRIwQ9qSaAHawPk5B4qqnQ8+zq/42VNW7rS59f6PCMqVvPInTSYZFGpjsCwoQ0BxNkShnqUlXYlwZFP1hMysTG/62wMLOTsLnMwArSBZKt2+b3eybLXn8vpvDhZeJEcQVY5Xb2L/zMV+77yWHkuzwZ8N0d7c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436661; c=relaxed/simple;
	bh=Cd5N39PiHx4hiXPTR6BjODHHkNIQaZ7y79h+rO6qUMU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=djynlF6HXlAKOoAKzrltdchRJuW+wWWTaleXZ6dY1Jz4nB5o7vem/5caVqdqqeh83S7xPDszNq3oZPDF8BI2MhiRzAUd56eVH+xZbbNSZUSLLzzwX53xFHSiZc6EDB08AmC2CfPENe/AYo5nJFNTr8Z3TdA5mzlOd0ijmZC2nac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=novWmeTl; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724436659; x=1755972659;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Cd5N39PiHx4hiXPTR6BjODHHkNIQaZ7y79h+rO6qUMU=;
  b=novWmeTlRyd3RA8NOUJ+gHMTMz6AmM6fZq68z6tTExY1n6kGsKBNSUbB
   r+6ZYeavhjDuHiDBBv01bGQE7b7V/JZtNv1YjPgslKQqZ4xOKzvSzRenK
   p1FNJNcSEAzLNuaAk5a0NKNxbVCtL4W1ud7soh0Jp5JZEF5nvFfEAaAY4
   4MmQyrSiTQAt5Z7IbUu0Fd7aCBZmhb9DZA1hPK/l98nXXKf1SgbsB4ZYq
   zHd6fG7pcimU5r9FkJdgyHXK2edWd7sAWZPZrNKyKv6RKQFrxWBEASF4k
   5CLV61kQe0ZVpZJCn4a7fQ7uzfS/dy6hbf26R6CrJIBumYKu5K7vps+8d
   Q==;
X-CSE-ConnectionGUID: 1gKOkT0USpSFNNIQryRhRA==
X-CSE-MsgGUID: U7I9OJ/USIGkFe3LjMyHYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="48313707"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="48313707"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 11:10:57 -0700
X-CSE-ConnectionGUID: bkNP4eNtTJKQLPKPqvcWAw==
X-CSE-MsgGUID: ufRY3yJ0TPGbJA1beEIO3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="62589116"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 11:10:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 11:10:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 11:10:56 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 11:10:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnMF7UsFzxyzHf9bNvRJZGT7F0HqULOYlFGzsow3ZZKgOrgaL0QxfcJ1hTieZ7ynsz4CMb+ZlsVYfzXUcOSY7Vf0j51yb+9x4goz/7IkgD9k8h8Tqe5DUAHvbLFeYIlkPIYA58V5J7escL9AZ8XOT0sGFiCcOyPlgxV9YMoxE5r2CYJRp2OOd6L3N17MS4yZl5AakZ95E/YF1zFhl0P/Fp30FvTuwI0xp4A9raLdceGLXfEyTKrNr3qgOMZ0SJf04270eGt2auwGKrsRQgKwY4+hzq6vd/zEqgrKR8FnewNynDNKw/npJ407BQnrMsmmqaZBFyAWEnybvcpMED4n1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if8kYcZhhWF+r5D1H47rSjf+xBgBSoZn8a8OTy0m+2g=;
 b=lWcxWBXSyrkZrgl87OIiMSXT4V4JE+SA/vPZf87FvFOYFWQyjBRMbGP8A350KIs6GQ1Mak7iqwQBn3KmwzIoQ6SmXjY8C+yr/0YOeeO/ewSncJOX8MMLG4uDuDZQ9pkKbZpRFEK84YbnaaUrclo4TBSxoNLrY3yIHCxhXEi2/Llq4TLtdQL805qkyzKAZzoeP8nau4OjvJ97cJHyD1+mDuzw7tGK8OzhyZhr8voCR57uEQdL2wc3FWuA/q7xpaVUJq+sHcSG+Yg6OdfEdduvS7/IrbGDBPbVtA/F+2r/zwGdSfSr6GZmuKEdXFjR8q7642Vi6qAXHTC8nNdbXV69yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB8345.namprd11.prod.outlook.com (2603:10b6:a03:53c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 18:10:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 18:10:53 +0000
Date: Fri, 23 Aug 2024 13:10:47 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Ira Weiny <ira.weiny@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Takashi
 Sakamoto" <o-takashi@sakamocchi.jp>, Timur Tabi <timur@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux1394-devel@lists.sourceforge.net>, <netdev@vger.kernel.org>, Zijun Hu
	<quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 2/4] cxl/region: Prevent device_find_child() from
 modifying caller's match data
Message-ID: <66c8d0a7eddc5_a87cd294e1@iweiny-mobl.notmuch>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-2-8316b87b8ff9@quicinc.com>
 <66c4a136d9764_2ddc2429435@iweiny-mobl.notmuch>
 <dec374a6-073d-4b7f-9e83-adcfcf672852@icloud.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dec374a6-073d-4b7f-9e83-adcfcf672852@icloud.com>
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: ef23a2d1-e3f2-42b5-2768-08dcc39eed85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gZy0LQHquOFLaTxX3MkI+hqQ8gNzu1Zn7jYiE5EfHkc7SP/4KAbr+IUJ5ICO?=
 =?us-ascii?Q?9xNvsoc4mdtH7ZtgMN3SJP8wl+g+cUoo5z8HbImWchJ/lvx14GdKNkhViV1g?=
 =?us-ascii?Q?VNYW8vH7Jqxg66zUe/9l8f/SdA9YVPKRJLNfQpF98rcw85b1OubzP0+I2jru?=
 =?us-ascii?Q?Lhk6J8u+F9n0e7WkVMi3OsBapa56Doczhku7mq24aFHJtuPSYUqrImVBLQvR?=
 =?us-ascii?Q?fwAUPhSQc5nbVvBkkZSyJnS/BbFGqmoIRtaUffnNbjB734Rd29zhJu1Mw+j3?=
 =?us-ascii?Q?uGURDstmct+2kmH4xucy4fO9wY+kaC+EaxNJh+Sn9arA+zZKlxKlMiBOyb72?=
 =?us-ascii?Q?bjXe0U+oz261Xk5c74S+6wha46sRCU6rkR7mygMBi3FsdpRwLBNeQnTqqQZz?=
 =?us-ascii?Q?um6h33CxsTaZvaAnijaZ62loHnw/uHXa4eqlQ4YeDURitNM3IR+ALKQQzF79?=
 =?us-ascii?Q?+FYx/j0H9NxKxHud8XgaWrve6t1GoRpNSaSxiQOANr2pLYXqwgCnbYWXAK0m?=
 =?us-ascii?Q?SdMbwweWXMbejdb2ZY4ZR1KX5Ukcs+1mvROX5r2OP6rlHeU4CmYUVGISTeYd?=
 =?us-ascii?Q?2F3NO0Az9OivwVrnIZQS3HpsoD1/JNf9oB9EdmNuUycSnsvQdjxkJOWeykNR?=
 =?us-ascii?Q?5goprMqniCzhSGUeo4z5AoRibWkzGJxTEkTKHawqoUDXdWdu/q469DIPbxka?=
 =?us-ascii?Q?kL2Q2gmAUjCoUC6j0kkQDZ87uXMbhTQoImY3soaJt3lxMGu9Xk8gFq41anoL?=
 =?us-ascii?Q?kqbUMbeNmf9ZXTIDBZBEAJQecb7tyRFFlm4JO5KBMCKz4tu/JuYxj52vVy8j?=
 =?us-ascii?Q?HSEMl9ecr5zBGMkjJxd+9/+f9iSCb0vKG91VqrVXVutSiTgFdqnxqsgtVQWl?=
 =?us-ascii?Q?7gaRqxL4GkRmWMzGr3h9rVzURZ0rqnVSPOPi8uXZwHyU41B6P0BAOrjEl/Eu?=
 =?us-ascii?Q?JU6Hq4eqSbD3zxZaNCymDM9yWVZhgqp7uIY9sKBzhXhwZ5kH9GeVQOO5XxHf?=
 =?us-ascii?Q?zYL8JcbOEC7EGA5EjhZWyhgtzG1Lr19nBBKoU0tDdxHQwBOp+pMtpk8Cqmsn?=
 =?us-ascii?Q?UjiM33NEZwVPpXCP3ZI7lMCIc8DT3Fbe2oen9BE3fzDaWzxxgXy5vDl8g2jz?=
 =?us-ascii?Q?UchdTvlLPcHOxCVQ/hvuyuZByFL12qRDP2l6ng6Njlp6sJvyt+yFAwO2HV2L?=
 =?us-ascii?Q?LHDmVRUyBqUveLBfZxFUsnutqvsH6Gbv2YGfyoB2nL0TQWJ5k3+8wepEda4o?=
 =?us-ascii?Q?MOvwKfQL9Y2zDNs+gCGo2P06bDUIESTofUZsmLErC3GGEaWNr1i9mkwPcz81?=
 =?us-ascii?Q?V9w6j3pFBAOMpQ5vz2j8b0N+nQN/Scg4iDVlDzNuhwaiEFJBdxOc7xGXLFoh?=
 =?us-ascii?Q?hST5NwUEd4O31ErfyA5dvdIH+v87?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PTrSlOXl+tLs37AvmxSB7idOnDLXB4DfsFM+jbW55azu/WbW6FFJCWrbkKrv?=
 =?us-ascii?Q?uLJWo2+fsMt49sU/UmHztS2Af4BhumfeNe6sPwWN+3WlOZXl8MXHNiEbmA4X?=
 =?us-ascii?Q?wjgJNaGFhzMXcMe/iZIxj+VAuWHCLwtRwuVD0xfxZPB3WHc5vNrabzdzevs7?=
 =?us-ascii?Q?r/o++l4Ig13KmUxOvr3lCHzgT6C9Afns+HRMqn3u4rBKtQgLYJceJgsUQ/Tu?=
 =?us-ascii?Q?OaDZp98VfRBnC9CHiNudIvb8xtXojqGqxNw+6nUNmXpWmZ1RtSJqJu65SqAz?=
 =?us-ascii?Q?9Ksvpx0f2tIdIojZxkOs2xWNLiV038HFm5umei7SqtAnmseTrla8M9xMXUyY?=
 =?us-ascii?Q?hZj8MV6dkWY6jOwzaEB6OeKip2J9cWIsWR0Pkh0XgjwNjbyS6rkwf3gkOGIE?=
 =?us-ascii?Q?6nKdjUBkG6b94nzMv6AxoRVaFEpj7peUQdXSZXVv4aSnDsgSX6Emly1DDi6O?=
 =?us-ascii?Q?GCOEcGfJFFuMB4Nc09RJvfucyReQMFWmvftN+E+CKrdIChAd/IV90VDQ+1Nq?=
 =?us-ascii?Q?1SyPSKIKD/UbTp6pxyT7jpsRrjzl23CzORjGzbdcOioq7sd8f+06JCXmUg9E?=
 =?us-ascii?Q?/EF5OTq9OtEAE7fxfoXyKXUC3WK2agm5JDGgjKpN/7pHdveqBSIR84Gf7nlL?=
 =?us-ascii?Q?N9A+2XeZfOSeiFx5GFv5/DpJPz3nV7jPvW7dZxBfLhuJfv40HpbFtVD044tv?=
 =?us-ascii?Q?IvBINobnyV22dS39aYdTZTgghJrAYg1UPUrGsYqCba7EFs2hcJtB2A7cZKPB?=
 =?us-ascii?Q?5PTocMREM33i58c6RdUdL5PJjCJgqt2Kq2WNEzbbMoqxUHxoM2DSlx1L4e9q?=
 =?us-ascii?Q?rm5pJQ8EDbWU0QzaMeT6M5DjKvynVnEjdwFaB38c9x8aLNq2a9y0K3NbmEwM?=
 =?us-ascii?Q?L2czmtsaGiCXUzGwxLJkFqDg/nrn/GVKfjnC9FtvR8pHmhMFbt0kNwRk25NW?=
 =?us-ascii?Q?8Lk2cSUL4GZh1gcUKLQfIXRXD7+DjwluG3BiyO6nNq+TWsa+8qjxa1reH5G7?=
 =?us-ascii?Q?dWXKSxakVF0+N6GQ/eda7phYYiTdT5z50DYq0du1Se9oJVRC4Y/HBJhzjMeQ?=
 =?us-ascii?Q?Za3WoXP4D05l8w6/vKkgV+BGpo0YVH8yr9qNlwQHyPvc0wmotKGOqTc1s2X4?=
 =?us-ascii?Q?+VeiN0z06Zhk4YOU3rkY0ReMf/FYqR6y5J/QZ2fKJxsipcs7OXcCusO3fjy+?=
 =?us-ascii?Q?vuWVX9G3hGGUgvu2DSNgE3OnXxie4yklK4UWFAjL+sQwxgeIxN5h9jay8qvk?=
 =?us-ascii?Q?Q9RkxrFvPJOgqgj+yVlCu6enRNJq+IyX00h6u6XMgnZsyJ0ACLIFfPhFrzNH?=
 =?us-ascii?Q?zHkbwjy3AeSzl/W+yWhYUx811YO+gh08j4FEFwb1RhCcap6REdgidzjMnB1R?=
 =?us-ascii?Q?i4ZJyBcw7K/OTrKUMKwj5eGjKDSj/2sRHtarvHyJOn2ty/N3PPvXTbg5JNCJ?=
 =?us-ascii?Q?U15WOOhusZDl5H2/2P7z5LAfe60131rqGJ5Sf79JZgu1sx0j1VpIyPuShVl+?=
 =?us-ascii?Q?O/pev1JgLKKW+jtqSvXFM5ko79lIOl9uWztnGmMc6D/RxswlIgLJuLaKypCY?=
 =?us-ascii?Q?Tw8hGIfr2+/zAW7i91D9Q7jUO0PwJwrHWiPQP5j7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef23a2d1-e3f2-42b5-2768-08dcc39eed85
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 18:10:53.8897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbBGEQfBPiutDYKbPqUT6CCtCDJj5L24NmsRx0zJimdg9Le1iZCayi+D2Pk6Mzo5y+f8QkdhioFJmyh3uoK+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8345
X-OriginatorOrg: intel.com

Zijun Hu wrote:
> On 2024/8/20 21:59, Ira Weiny wrote:
> > Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> To prepare for constifying the following old driver core API:
> >>
> >> struct device *device_find_child(struct device *dev, void *data,
> >> 		int (*match)(struct device *dev, void *data));
> >> to new:
> >> struct device *device_find_child(struct device *dev, const void *data,
> >> 		int (*match)(struct device *dev, const void *data));
> >>
> >> The new API does not allow its match function (*match)() to modify
> >> caller's match data @*data, but match_free_decoder() as the old API's
> >> match function indeed modifies relevant match data, so it is not
> >> suitable for the new API any more, fixed by implementing a equivalent
> >> cxl_device_find_child() instead of the old API usage.
> > 
> > Generally it seems ok but I think some name changes will make this more
> > clear.  See below.
> > 
> 
> okay.
> 
> > Also for those working on CXL I'm questioning the use of ID here and the
> > dependence on the id's being added to the parent in order.  Is that a
> > guarantee?
> > 
> >>
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >>  drivers/cxl/core/region.c | 36 +++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 35 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index 21ad5f242875..8d8f0637f7ac 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> @@ -134,6 +134,39 @@ static const struct attribute_group *get_cxl_region_access1_group(void)
> >>  	return &cxl_region_access1_coordinate_group;
> >>  }
> >>  
> >> +struct cxl_dfc_data {
> > 
> > struct cxld_match_data
> > 
> > 'cxld' == cxl decoder in our world.
> > 
> 
> make sense.
> 
> >> +	int (*match)(struct device *dev, void *data);
> >> +	void *data;
> >> +	struct device *target_device;
> >> +};
> >> +
> >> +static int cxl_dfc_match_modify(struct device *dev, void *data)
> > 
> > Why not just put this logic into match_free_decoder?
> > 
> 
> Actually, i ever considered solution B as you suggested in the end.
> 
> For this change, namely, solution A:
> 1) this change is clearer and easier to understand.
> 2) this change does not touch any existing cxld logic
> 
> For solution B:
> it is more reasonable
> 
> i finally select A since it can express my concern and relevant solution
> clearly.

Understood.

> 
> >> +{
> >> +	struct cxl_dfc_data *dfc_data = data;
> >> +	int res;
> >> +
> >> +	res = dfc_data->match(dev, dfc_data->data);
> >> +	if (res && get_device(dev)) {
> >> +		dfc_data->target_device = dev;
> >> +		return res;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +/*
> >> + * I have the same function as device_find_child() but allow to modify
> >> + * caller's match data @*data.
> >> + */
> > 
> > No need for this comment after the new API is established.
> > 
> 
> i have given up the idea within v1 to introduce a new API which *should
> ONLY* be used by this patch series, so it is not worthy of a new API
> even if it can bring convenient for this patch series.

I'm not clear on this.  Are you still proposing to change the parameter to
const?

> 
> >> +static struct device *cxl_device_find_child(struct device *parent, void *data,
> >> +					    int (*match)(struct device *dev, void *data))
> >> +{
> >> +	struct cxl_dfc_data dfc_data = {match, data, NULL};
> >> +
> >> +	device_for_each_child(parent, &dfc_data, cxl_dfc_match_modify);
> >> +	return dfc_data.target_device;
> >> +}
> >> +
> >>  static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
> >>  			 char *buf)
> >>  {
> >> @@ -849,7 +882,8 @@ cxl_region_find_decoder(struct cxl_port *port,
> >>  		dev = device_find_child(&port->dev, &cxlr->params,
> >>  					match_auto_decoder);
> >>  	else
> >> -		dev = device_find_child(&port->dev, &id, match_free_decoder);
> >> +		dev = cxl_device_find_child(&port->dev, &id,
> >> +					    match_free_decoder);
> > 
> > This is too literal.  How about the following (passes basic cxl-tests).
> > 
> 
> it is reasonable.
> 
> do you need me to submit that you suggest in the end and add you as
> co-developer ?

You can submit it with Suggested-by:

> 
> OR
> 
> you submit it by yourself ?
> 
> either is okay for me.
> 
> > Ira
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c              
> > index 21ad5f242875..c1e46254efb8 100644                                         
> > --- a/drivers/cxl/core/region.c                                                 
> > +++ b/drivers/cxl/core/region.c                                                 
> > @@ -794,10 +794,15 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
> >         return rc;                                                              
> >  }                                                                              
> >                                                                                 
> > +struct cxld_match_data {                                                       
> > +       int id;                                                                 
> > +       struct device *target_device;                                           
> > +};                                                                             
> > +                                                                               
> >  static int match_free_decoder(struct device *dev, void *data)                  
> >  {                                                                              
> > +       struct cxld_match_data *match_data = data;                              
> >         struct cxl_decoder *cxld;                                               
> > -       int *id = data;                                                         
> >                                                                                 
> >         if (!is_switch_decoder(dev))                                            
> >                 return 0;                                                       
> > @@ -805,17 +810,30 @@ static int match_free_decoder(struct device *dev, void *data)
> >         cxld = to_cxl_decoder(dev);                                             
> >                                                                                 
> >         /* enforce ordered allocation */                                        
> > -       if (cxld->id != *id)                                                    
> > +       if (cxld->id != match_data->id)                                         
> >                 return 0;                                                       
> >                                                                                 
> > -       if (!cxld->region)                                                      
> > +       if (!cxld->region && get_device(dev)) {                                 
> 
> get_device(dev) failure may cause different logic against existing
> but i think it should be impossible to happen normally.

Indeed this is slightly different.  :-/

Move the get_device() to find_free_decoder()?

Ira

> 
> > +               match_data->target_device = dev;                                
> >                 return 1;                                                       
> > +       }                                                                       
> >                                                                                 
> > -       (*id)++;                                                                
> > +       match_data->id++;                                                       
> >                                                                                 
> >         return 0;                                                               
> >  }                                                                              
> >                                                                                 
> > +static struct device *find_free_decoder(struct device *parent)                 
> > +{                                                                              
> > +       struct cxld_match_data match_data = {                                   
> > +               .id = 0,                                                        
> > +               .target_device = NULL,                                          
> > +       };                                                                      
> > +                                                                               
> > +       device_for_each_child(parent, &match_data, match_free_decoder);         
> > +       return match_data.target_device;                                        
> > +}                                                                              
> > +                                                                               

[snip]

