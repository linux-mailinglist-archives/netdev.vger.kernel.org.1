Return-Path: <netdev+bounces-95354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DBE8C1F3C
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB001C20AB5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C3715EFCB;
	Fri, 10 May 2024 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcMslheO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3C14BF89
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715326943; cv=fail; b=fnKgNiTxHdntOabzCjaQUKV5+rB871qzKrXEXccrx+6bXniYOl1tFeFtpstDIBLBKDhI0v7ae+iPT/eRGJK20CoTRTBO9CE9Ed34lZKHudt31Mwdt+HzecS7xWrIgiZpiRA2cTXpTnYbRovtNsZRLrAd/a5TYXHEhiQYR88vKhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715326943; c=relaxed/simple;
	bh=qkxePr0/llfyS56/GoqFEHhlBxoi/+4//MZ5mLH3Bt4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XZ0bXru9lsDb735OMYqGBSDJKr1KmAm/7nj7wvtezbsuy6Jfy/zU9qXDCPeU1JbCcKevrit37Y9s132h1zjI45UVS9YTtOryzQM/L84doP825Nd4/WIQfCAzZkffgkeVgXCgNwZa+TT2wGCtChdiwcgtNT/BQNjhMJOjXX91360=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcMslheO; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715326942; x=1746862942;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qkxePr0/llfyS56/GoqFEHhlBxoi/+4//MZ5mLH3Bt4=;
  b=dcMslheO3LuVhiZTnqae8hc3xZq3/EM3yWYiSHkhcYByhjvY5bMIT9wC
   7IZvUcodnuy3j6lo7QNFHOmaZ7BYFPFIPrH/7SfEHXIJPfvhEzN+RHw8y
   w8QRJ0CbSI8bcBntQRsHeDbnTBCwO5tpHWkMznHjKkXZRphlMO5cgY9FW
   clElYWOrYK7xiUASomtkePR5ac5xvHlfqyMpYz/tDc1kilFH9Sg8r1WLt
   qZ60eU6xArZ2W+NOk695EixDVN9Uzp5pmNqplILmuQwgMg+XBr9VTL+mP
   zPwZd1s9Vm+HrXeSjLUq8KxwvSUwYRIDXxFWQr/N7oMCZdyhJGJWMUWC7
   A==;
X-CSE-ConnectionGUID: y8LoPkaMQZqJtYDtwKMI9Q==
X-CSE-MsgGUID: omo9e69HSEKcKtNMNXERew==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21891837"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21891837"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:42:21 -0700
X-CSE-ConnectionGUID: rsctzUEWSBqEd9yJfmnXOQ==
X-CSE-MsgGUID: keYeH/gPTruh7TgALljjMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="60703044"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 00:42:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 00:42:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 00:42:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 00:42:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 00:42:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8jogEmwcGgXZiipq8xtWe+SlfGNoCmgHqFZjh40qxvABBTuzuxn4Qvz7W3KKYo7u6j63J8PJ7SorT+2+GheG1f2KGoInS3+/K0p+OJ3KT8niGD1+bTyciXxkZDIqxbol/xVIDK5R+rbsPV7ZlCGtLgFcHdO6hxi2PUdPoe0y134hwOHYq4yCcqR5z/60HpSrPgxYKCyaMYhdisGYXdayz71v7FksUzKnl7IfnhlbcNmADASuSB3l8WkNNObOy7nYodUsvyI4Z8P3Zxp1dDD2HQ4eQYksy1oJ5WCO0UJxKujirA7rI46LmJ01m+A96CwpV4KPD4T3QR77X5YE3CKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLz6H4AtPbX7h53YTzrqiepq6TtveBYwCQHmyVLyWrU=;
 b=I3MVsi7TjFMWSvksz07K3x2H63gN6C1ZeIZpehg/ZAiiCe5sDjBOa8OzNzCfN5g4Q4yUO0eFWYZtK4TkhVR+8/vJmeCgqh3+jDK6a5DTKvH/mJ7TMKeD+EmkIvbrU8kfu9gWaOBB53ONfpKsAtw7hY7nah3xRTcTuLlpVfPb77hkYYJdK0K/WCAR60rZaFqGzjqiusKB4f1Hne246KnL82NTLsFViQDm6eoay2+wWq1h+RYYnNTaQs+MqY7egqmJo9kkaVVzk9Tj2XqpKfa81impFR3oTGseDM9x6h0n2CgRyFMIWgizI+fDc8MmI9LIOkh5+dCaf+PIVVdOO+1bbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ0PR11MB6719.namprd11.prod.outlook.com (2603:10b6:a03:478::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 07:42:15 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996%6]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 07:42:15 +0000
Date: Fri, 10 May 2024 09:42:07 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: <netdev@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <virtualization@lists.linux.dev>
Subject: Re: [PATCH net-next v4 3/4] virtio_net: rx remove premapped failover
 code
Message-ID: <Zj3PzyXEMfyNDKe6@lzaremba-mobl.ger.corp.intel.com>
References: <20240508063718.69806-1-xuanzhuo@linux.alibaba.com>
 <20240508063718.69806-4-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240508063718.69806-4-xuanzhuo@linux.alibaba.com>
X-ClientProxiedBy: ZR2P278CA0039.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::16) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ0PR11MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a77c18f-2e39-4ac0-3ac2-08dc70c4b5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uhM1IUPPecVlNRdQvJu2Hba3oDaLmRsqknBMm7pWWIOdZYwCgdXQpQmjyGzt?=
 =?us-ascii?Q?sPqqmTogHjM6fFQJBj/bvl3sd+6dwgwws76fQ6Lmu+yiyRC2pLIZFQQA+STk?=
 =?us-ascii?Q?8NPgDVyQrltGLGZjU43GT+MyTI5VnxRGkfhulcWJWfV8eI/J9NKxUrw4Tst3?=
 =?us-ascii?Q?LDLTr5WxLmaoYuDv/Vn0D7Nvd1he/HILS0/zqssUXKRwuAMVCegT3sT4fGOm?=
 =?us-ascii?Q?AfDZLz1EM4UOgoMPAGzCN2y2oeXPI6ov4Jj9H65UwUkF9B8YYeOzLOij6+0q?=
 =?us-ascii?Q?/fkUhTsnHy6acJE5atjF9yABChUcBdEDX3SkjlJPJL1txTvCdL7w8kzXMpwJ?=
 =?us-ascii?Q?jQXrdqT2FTl67FVI/sQ85asNU4toWMmjb7TIA++oCGoKsWIIqI6TEcLwuW9k?=
 =?us-ascii?Q?iwZjWk93OYZxcGGWbJEecCepQ1kHB55isCvhce33R8QgzNdZhEF5qL6QRf4H?=
 =?us-ascii?Q?P7HQ9W5aCxJnFNs2pOB/mIHkgmtGPzPJOOhGfwMBHB0+xCOqemke/72kmfiq?=
 =?us-ascii?Q?zdglwq31qmvUMOaeyMKvqNfEX0fs/k81yNic+L5RDjD7qiG/vI0GSPxiYmaS?=
 =?us-ascii?Q?8Z2/S91XJN2m/CgBLeuJTgkUWdtJ1i0+y4lzxJ4P67hVN//SMC3smwCatXIA?=
 =?us-ascii?Q?EdXA6sbUNS1IFA+S4ceHSI9bKcPT5oowH4c2GnZ5+qVA9/9/VzkdUYO8C9lk?=
 =?us-ascii?Q?xA9AuE97Xqntjst+I+bcbNZ7Yyxh+ITx7kBf2jKtEb4+TguP1f4Rt2VRci19?=
 =?us-ascii?Q?4E7oAFFWqqlfib1IUYU0psje0iwfTwFVA6GiO+xoTlnxqG0MLK5w3J75fJbI?=
 =?us-ascii?Q?rQPEKhRd/JA+jYgzqUHhIttXIS7I423N0+N/aRHwwhhf1sYdE54yoysKkqNf?=
 =?us-ascii?Q?aY6yDPQ5CgQ0oD1TKTIUmikTAXBBvxE5IFaHgtHzwh8HHBVDcyRevjs8wj53?=
 =?us-ascii?Q?MF0xirjp1kPgzuNIbgL1wFPBuWcu/znAmnu8aupiiPAw9efO/+HU74E99lo5?=
 =?us-ascii?Q?Gh7G6NAn7N0AwFReG2g64x9IfUlNVmj+YiOVoHKbDIHWjobT2RmbsvkQKbBU?=
 =?us-ascii?Q?C56/7mjiTd7zPKUPv2jODDzzbcUaMyoY1i2N170sBlDCFVOeFi4HmmzA4xTK?=
 =?us-ascii?Q?+SUiImp2yTFFKqZP7wuWl566RH6RRyYXQZL8nj8/exuEapsfRaQTnIq42O3d?=
 =?us-ascii?Q?3IhB31ZhzWEkk7RM8HaKwARGhjeRbp8xjK/viEgH5VUk2s7osE9Ikq4ObUK9?=
 =?us-ascii?Q?OV6BQFvijWJEx5bEehtlIon2ZdayPRvXL6eqTvJYtw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hWKb+h3Pi4HzWemf5os1wy8aQWt86qMiyd0eYBsMejcSkBg9cCml2DjU+8jM?=
 =?us-ascii?Q?07q0fZyaDXbKfPv+X1M7KEgLs06DAyyziqVtnr9fjPVK6qnNEPrwrXCdWtfm?=
 =?us-ascii?Q?q9JdHJ379YnIBWBzhf9OBQBNl3CK3zAOiFrHtz1ddwHWXxBkStEnYEPGGmKR?=
 =?us-ascii?Q?BxCclXJjw8L39V78aiXAyVK6/Q61ebeCnmciLdCcF1YiN//5D2OJqkXVLzZT?=
 =?us-ascii?Q?kNs5CSc3ADK+WFw6j5A7v/u3mOARrap5Oqli6OTVpg6semmjljfA/HIwzvl6?=
 =?us-ascii?Q?eNAUghptWN+cR0hqOjd3Sl8sPWZFtKIHMOeGhY4NNJn5PqHRrvdzDlHHEzxQ?=
 =?us-ascii?Q?L2QQBKqcjcmCvbeOcwMXWGVtZIpozrtYreU3uDam3TWyHSmvgMEPYaLKidCh?=
 =?us-ascii?Q?AZVq/0hWxiZbWWqJ/LazMm5dJru8zGkO47bXgaqDsFQbUu210cighwG6M7Fl?=
 =?us-ascii?Q?Dq1N0yp4o6Lm5fzhjYgE2aN5ivexLyt2YZWHK4BuAmJzrbwnizCNnr36LAUm?=
 =?us-ascii?Q?Y7fMdSertzuHtx0XZr5kFoDXfDTpbLHrl2FG4W+FzHzVRDrP0GFTGnWMFgja?=
 =?us-ascii?Q?y/Qgl5LkmihD9Nz/1Xoe70QtnTFf4lvCIb71hb2p4qCTJ/YlJnSfTC8bsXo6?=
 =?us-ascii?Q?tGqxc7PL41+YLjmb9JAiwYzKWHcPnMn2cs2Bze8vZ1as9iK4krrxX1E8Ddbv?=
 =?us-ascii?Q?qKEaWd6G3pmw60Kzjf8/EyZn2qydYKAc3OgQYtEIvonlNU9+KjFJBpHnmmva?=
 =?us-ascii?Q?F0vhMnUkG5P0AoXoYO9TjQVwvdtqhD6+sAis7tclLX6bRi06PanTLkQ4JXQA?=
 =?us-ascii?Q?1Z42Wwg4l5za/kfEQJmNDq9SKR/Wd5UAIKuUlQ68+bR7Wj2fdZJLYGSRW0FB?=
 =?us-ascii?Q?Fu97n66+mjzsqMwle/EMQHpngpVZ+4u7l6UdXxaap2YUcrm+bMxeVRYvsKnI?=
 =?us-ascii?Q?xSzycGADErzpJa4dbLSF3+8bHWypdxwP6MKlXKuL0wK1cLrZJTFNx5xBLReu?=
 =?us-ascii?Q?68DCoyVtTR6NBVpxALY8bNSyW7BqgiHHUC3BrGeU/3ASgdw8ESiRL1Ls5/mz?=
 =?us-ascii?Q?xlHIglU/KmiwK6Wo9mm2aHBh7jm+CCUuGpJ33mdP/kHIZt58mksB8IohO5Yp?=
 =?us-ascii?Q?jvXtVURAFRms/vHrvz5Hla3p5O0JNcfeodF85Ik62W0LpSKENuuMkKxswLiO?=
 =?us-ascii?Q?Sofb6Z4kEDnA5KAJyiIuMINF+YW4vZ15iN34LT72EteDc+cKeLWTxU9IT8wD?=
 =?us-ascii?Q?8UoAgJqPkzckS9pIJuoOCJwnbMdiIEC6GFpNk2zsX0+Ax9lx4blY4yOFJB4j?=
 =?us-ascii?Q?+AruqRlVTLa+P78IQWzqVK3CPDMUo7aIlzolzhjrH6Z7+W7TaT8ZlTAuVK1N?=
 =?us-ascii?Q?AgSawbgJlKjAdOpIA4lf544hHpaJlFFgFexQew9PPzsjVH7a/zc4JmdA1TTe?=
 =?us-ascii?Q?6BRcDz+pZzjjRoRin6iZIZ4bSacM7tXPR3OLJqEiQwWzCWTcqb19MakzmJtM?=
 =?us-ascii?Q?nnkNzKbasvBv2CdwfdGwZ+LdCq1LtUnECDlPSJM23x+BFm9HjmK4IDt9Ycna?=
 =?us-ascii?Q?wYb1HpcKUj2GrsJD69xfa4BsCEQw6GrXlqmJbBo+pwdsOQxzeCkOkrDdNmXh?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a77c18f-2e39-4ac0-3ac2-08dc70c4b5f8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 07:42:14.9626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjVwjJDrn6oNqVgIh3CijvCba7PlzMj6C9CWeMXXVeN91ghqvwQg9+CNejZp8S1vqt0gBt2eIotik9odSSVfl+XQ5kxJzGf2vn0wgAtVIXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6719
X-OriginatorOrg: intel.com

On Wed, May 08, 2024 at 02:37:17PM +0800, Xuan Zhuo wrote:
> Now, the premapped mode can be enabled unconditionally.
> 
> So we can remove the failover code for merge and small mode.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 85 +++++++++++++++++-----------------------
>  1 file changed, 35 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a2452d35bb93..070a6ed0d812 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -344,9 +344,6 @@ struct receive_queue {
>  
>  	/* Record the last dma info to free after new pages is allocated. */
>  	struct virtnet_rq_dma *last_dma;
> -
> -	/* Do dma by self */
> -	bool do_dma;
>  };
>  
>  /* This structure can contain rss message with maximum settings for indirection table and keysize
> @@ -846,7 +843,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>  	void *buf;
>  
>  	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> -	if (buf && rq->do_dma)
> +	if (buf)
>  		virtnet_rq_unmap(rq, buf, *len);
>  
>  	return buf;
> @@ -859,11 +856,6 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>  	u32 offset;
>  	void *head;
>  
> -	if (!rq->do_dma) {
> -		sg_init_one(rq->sg, buf, len);
> -		return;
> -	}
> -
>  	head = page_address(rq->alloc_frag.page);
>  
>  	offset = buf - head;
> @@ -889,44 +881,42 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>  
>  	head = page_address(alloc_frag->page);
>  
> -	if (rq->do_dma) {
> -		dma = head;
> -
> -		/* new pages */
> -		if (!alloc_frag->offset) {
> -			if (rq->last_dma) {
> -				/* Now, the new page is allocated, the last dma
> -				 * will not be used. So the dma can be unmapped
> -				 * if the ref is 0.
> -				 */
> -				virtnet_rq_unmap(rq, rq->last_dma, 0);
> -				rq->last_dma = NULL;
> -			}
> +	dma = head;
>  
> -			dma->len = alloc_frag->size - sizeof(*dma);
> +	/* new pages */
> +	if (!alloc_frag->offset) {
> +		if (rq->last_dma) {
> +			/* Now, the new page is allocated, the last dma
> +			 * will not be used. So the dma can be unmapped
> +			 * if the ref is 0.
> +			 */
> +			virtnet_rq_unmap(rq, rq->last_dma, 0);
> +			rq->last_dma = NULL;
> +		}
>  
> -			addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
> -							      dma->len, DMA_FROM_DEVICE, 0);
> -			if (virtqueue_dma_mapping_error(rq->vq, addr))
> -				return NULL;
> +		dma->len = alloc_frag->size - sizeof(*dma);
>  
> -			dma->addr = addr;
> -			dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
> +		addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
> +						      dma->len, DMA_FROM_DEVICE, 0);
> +		if (virtqueue_dma_mapping_error(rq->vq, addr))
> +			return NULL;
>  
> -			/* Add a reference to dma to prevent the entire dma from
> -			 * being released during error handling. This reference
> -			 * will be freed after the pages are no longer used.
> -			 */
> -			get_page(alloc_frag->page);
> -			dma->ref = 1;
> -			alloc_frag->offset = sizeof(*dma);
> +		dma->addr = addr;
> +		dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
>  
> -			rq->last_dma = dma;
> -		}
> +		/* Add a reference to dma to prevent the entire dma from
> +		 * being released during error handling. This reference
> +		 * will be freed after the pages are no longer used.
> +		 */
> +		get_page(alloc_frag->page);
> +		dma->ref = 1;
> +		alloc_frag->offset = sizeof(*dma);
>  
> -		++dma->ref;
> +		rq->last_dma = dma;
>  	}
>  
> +	++dma->ref;
> +
>  	buf = head + alloc_frag->offset;
>  
>  	get_page(alloc_frag->page);
> @@ -943,12 +933,9 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
>  	if (!vi->mergeable_rx_bufs && vi->big_packets)
>  		return;
>  
> -	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> -			continue;
> -
> -		vi->rq[i].do_dma = true;
> -	}
> +	for (i = 0; i < vi->max_queue_pairs; i++)
> +		/* error never happen */

/* error should never happen */

Code seems fine
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> +		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
>  }
>  
>  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> @@ -2020,8 +2007,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  
>  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>  	if (err < 0) {
> -		if (rq->do_dma)
> -			virtnet_rq_unmap(rq, buf, 0);
> +		virtnet_rq_unmap(rq, buf, 0);
>  		put_page(virt_to_head_page(buf));
>  	}
>  
> @@ -2135,8 +2121,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	ctx = mergeable_len_to_ctx(len + room, headroom);
>  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>  	if (err < 0) {
> -		if (rq->do_dma)
> -			virtnet_rq_unmap(rq, buf, 0);
> +		virtnet_rq_unmap(rq, buf, 0);
>  		put_page(virt_to_head_page(buf));
>  	}
>  
> @@ -5206,7 +5191,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
>  	int i;
>  	for (i = 0; i < vi->max_queue_pairs; i++)
>  		if (vi->rq[i].alloc_frag.page) {
> -			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
> +			if (vi->rq[i].last_dma)
>  				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
>  			put_page(vi->rq[i].alloc_frag.page);
>  		}
> -- 
> 2.32.0.3.g01195cf9f
> 
> 

