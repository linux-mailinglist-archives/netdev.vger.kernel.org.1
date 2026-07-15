Return-Path: <netdev+bounces-307629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b0jRNk7YVmqJBwEAu9opvQ
	(envelope-from <netdev+bounces-307629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:46:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B07759BE8
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:46:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=jS2wNzj+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307629-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307629-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF75F300B9C0
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD11DFDA6;
	Wed, 15 Jul 2026 00:46:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BDF78F2B;
	Wed, 15 Jul 2026 00:45:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784076361; cv=fail; b=D+oG6C63/L01OR20UVp+BwnMag5tV6GID5u3+DKD+UOUgEcLObzixOOaIk7nt70+NCKohgMcG1Xwp1hUcc/st6EdRC/Yo3Dj280KF5OOFZcPdU/ZfvhZd3KWp+5R2CkIncBBXL6pLFpygiLDdEUPnlj60N5MkQceZy3Dnvz8O4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784076361; c=relaxed/simple;
	bh=kNakuuaYywuMHJnx1x5POeyjMrAosi6KMCoSEkWOdtM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Re8Rhmw3Tn1cpl4vGLqmgEVJZhN55WTnfynTsU1kgvWFvt0xuwtLZX1ujaf/jWWxfqDuKr4lnS46+iNHA5JCBNhF58KlJHbqIy9oe+eGEh18hDTQNGW0jhe/T0Ujmw3rfgO5F3we8I0Y14cpcmurIhoxdiMho5K5Fc2czxgl77w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jS2wNzj+; arc=fail smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784076355; x=1815612355;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kNakuuaYywuMHJnx1x5POeyjMrAosi6KMCoSEkWOdtM=;
  b=jS2wNzj+VLYu40Xl6+j5AFVx/nTTYV5BDRjsV+qdAFWO5NiwtZF+L7og
   CJPODiM6V1svOzreCW632xjNe7GdxoT9NlAT9SQ+RIYB9jHMv6o1ALvRh
   WPVItZ8BCxC4YOw6sbopVysHnkIz/P27B3n5EAu7h81ePGA+SEnnrAbwM
   CgtRnYxhQYDVSU+xAkt/kaAnkGbOAtotolx0yhH2pp+g7m4TDujNcO8xU
   Zja95gQBDxZeYFqoZrNorivj6Ay0m21rM4OUIQLFrRvzhk0UgUpaJtKtG
   vxjNfNEHP7dwnSPFf7h7pQ5ci6Q2XZwVKVHbbnNg7Y1Zi3DzAQPHRZ0Bs
   A==;
X-CSE-ConnectionGUID: 4jr8J2S5QXi1vUmqvin42A==
X-CSE-MsgGUID: bLYltLr+RfedctnTMnWAjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="102260996"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="102260996"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:45:51 -0700
X-CSE-ConnectionGUID: USXQlLhyTQKxORIOA0yBEQ==
X-CSE-MsgGUID: DOgWjazcTzSFhdot7noFuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="255510715"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:45:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:45:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 17:45:44 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:45:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3A1BTORIaln3lsRNhZntpOz0rYd2TmoG9Nk5s3in/VFiQ1bYfyGjO0ugNCCQ3X7fREOYgaW+dY3gF/lpARJriEZko1M4u6aa7nMvHWTlfS7GrZQXqkiB80AWBNvQCR+bNTYHb+Q6VGdDDnHXjCPmR7KlGdN0d2OSSO97j0pvA5KiFo3KtMntqBxW7iqCCsoOTy2ed1ygGpNIUot9R4NDjs5jjEvgjO4pcN+4RhyNt7zX912lbJ8J1Azgx2YcEidCUEe3176koVeFJNzwIT0drV5t+tiWJAMIM+7iI9aijMB4XDBhKBo7Uj7yTAaq/XXCxptPowtcJXOalJ/EJCjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z238ez16ZLT2n+Adb3WPUAl+kwdL0uem9olI8GDUX0A=;
 b=ZSYxLtOS3EHce7jAjOIbBAkB5eCDLhWOKIlnr4a+xa1zZ9o/5ArWuWgWW7U0RcAuCVI+UWVl1DB0Z+TB/yJ4ItMHaXMIVyyFan6hQ3GmmcNFoUsQC/5lPkBgLUm3drGablufU7ps2gqzlgzbawzLnN65d+jIe3N6H5z50onraQgcR1jJ+akwEWuW4jCcFll3d+65zqgey8ezXtJ2A3MZZCB25IIjqlpfy+2x3kJpR7t9n3QMIanMUMrMPrj0HLdCArb7TZqn0OMA7jc8cQq2nLfmkB7YRJ/WoRDhpoK1WQiOLc9WarnvAmgD8v0Lsp6PcMhGr0CxJCXd0Fs2SUbydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DM4PR11MB6504.namprd11.prod.outlook.com (2603:10b6:8:8d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.19; Wed, 15 Jul 2026 00:45:38 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 00:45:38 +0000
Message-ID: <e58af0ae-ad06-4f77-8ebd-f3678d6dde66@intel.com>
Date: Tue, 14 Jul 2026 17:45:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 1/7] ptp: Add ioctls for PHC timestamps with
 quality attributes
To: Arthur Kiyanovski <akiyano@amazon.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Woodhouse
	<dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Miroslav Lichvar
	<mlichvar@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Wen Gu
	<guwen@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David
 Woodhouse" <dwmw@amazon.com>, Yonatan Sarna <ysarna@amazon.com>, "Zorik
 Machulsky" <zorik@amazon.com>, Alexander Matushevsky <matua@amazon.com>,
	"Saeed Bshara" <saeedb@amazon.com>, Matt Wilson <msw@amazon.com>, Anthony
 Liguori <aliguori@amazon.com>, Nafea Bshara <nafea@amazon.com>, Evgeny
 Schmeilin <evgenys@amazon.com>, Netanel Belgazal <netanel@amazon.com>, Ali
 Saidi <alisaidi@amazon.com>, Benjamin Herrenschmidt <benh@amazon.com>, Noam
 Dagan <ndagan@amazon.com>, David Arinzon <darinzon@amazon.com>, Evgeny
 Ostrovsky <evostrov@amazon.com>, Ofir Tabachnik <ofirt@amazon.com>, Amit
 Bernstein <amitbern@amazon.com>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <shuah@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Simon Horman
	<horms@kernel.org>, <vadim.fedorenko@linux.dev>
References: <20260714020340.25014-1-akiyano@amazon.com>
 <20260714020340.25014-2-akiyano@amazon.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260714020340.25014-2-akiyano@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DM4PR11MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4ba1a2-7fb2-4214-6ca0-08dee20a63c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 42jYLriCwXuzAv8bXq7Xd/xPc1KSkqLK7JleuWpmAH4Ygjotx4C5s8EnQeG7vodAHT4VEbZiZb8Psa44dKTyk7CkssoeihdCOpr7hWbyzQmyNBORFSis0ddWxOEQNjRzAfeQDlxg0dfpWQYVwgtP9gIq5yak0KLc93uFeu7ovxmnDHP14+DYrtFtk/9Nf+6Q8zn7TmmAz8lGpjkkGYseCiGmFU3IjhhY0sDUeQNsX/tXKFKV1KcjN7lewO+bf4ypRVlZAfyhnxN1SkE8dAqxOPMoOT2bRaRhRbmcUNdqMZnks7n3UP0tRHu5KGDgVYt5zhGuuQ4bX/+GiWNhIJDDqEgpEXoxRsa2cr3pI9QHmE9lVPLkIW+fNzMPpxQuaZee2zo5Ll3TKLWpEJj4TeBHcdNtnWUU5nJerrANeyyQCKhT4aIJWs9eyoPrFspvh0IYjhgyWImG/4vVAVOtEzrMHEdoxYJ3JadPp7AfSM6+jE4ZQIfzMO65grLnT8YT+rxO8LGQwHva98wsZMz1l3TquNnFAvS8HaemBwURumeaszCv3Dzb1yhfvETUjkifCuOhzpFED2PozyN9OAytWWjqEu+uKnh0x1lYzg9Evx5L+NQyH1kM4k1k/sxT6uBK14RaFoue+af6TrlMuLi1hGdt27j0KetTJkCBIww9n3kZG74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THI3bzNCY2lsOEx6eGZxLzNkanJ6bitMb2FFWGttRmFCVWh1bnppMzFZODBx?=
 =?utf-8?B?QzVqVm9BQ3RJZ3JSVlcwbVA3K3BwYjJZbHplaFA5cmgzbTNEaGVaTjloaXAx?=
 =?utf-8?B?SGxLRFpOaEZIQ1pyUFJkZ0ZPSDJ0VlNITWllUXJBaE42QnVoKzAwZDNsQzNq?=
 =?utf-8?B?aTkxTXF3dGpRV2JNSnIyeEx5Qi9RQTBJMnQ0aUFHYS9jc0pPVi8ycWd6VldS?=
 =?utf-8?B?ak5mTlA1aFFaSWd3ODZUb09iKzBwbk5rQlZSZ0VVYWFpQzJjcDdxWlQzNWxo?=
 =?utf-8?B?c1o5YzV5Z0k3RmtvdEtrOEtIV3hJY2c4aEorUTBBbDh4aUtsbGxDOVVEdmlG?=
 =?utf-8?B?cHVncVhBdEw3blJ2dGtSSnBSL2VpaEEwYzBnOUw4amNIRU1xSmtiQ2UyN09p?=
 =?utf-8?B?ei90ejFmMzYwdG45b1JoOGp3V3J1Qms1Wkt2bmljTWNYbWloRkxZQVRpZWgv?=
 =?utf-8?B?U2NxUklRbTk3YkxmaVlzaTd1VGowT2NxODNQc1lDdEo2RlFSZmdueU1ud08z?=
 =?utf-8?B?WVBmSXBZQmUvd0wyL0lPWVBkRUZ2aDNMY2VuTVdPT3Rja2p6QTJMcGJTb3Zs?=
 =?utf-8?B?REMvZE4rZy9kdEVna0w0bTVlVVVhWHZDdGc4ZXFoa2lEcVplaWVaYUZDOWFs?=
 =?utf-8?B?ZWx5Zm43WmFHUnNjQTZzdGIvSmVvR1VGUWhXZ1YwNzhTSXc0UGVKNVRpU29P?=
 =?utf-8?B?NklqZTJJcjdlWXRTMUJndm1td2QvRFY2UWZhcklyME5SdG02WW1QWmlYYkhm?=
 =?utf-8?B?eW56dGlpQXJaTUxad2JNUmRyRVZiZTRNdTJpUG9CRXN1MVh0QTBjdzNvUkFL?=
 =?utf-8?B?QnBXem1UWm00QTJyZ01DMkdPZEZMMU1JbldVa2wvOGVSTXFvb282ZkpoRVlr?=
 =?utf-8?B?bDdDUVJMWnZYTzBLbjFySTAwdU9zMzMxek1sa2tnQWRtM3kwNWU1VE45ZXRE?=
 =?utf-8?B?YzRZM0I3SnYyT0RLUXZNNTYyTWNkZFdOM1l2OWRUL2c0UUFwblg3Q0VkY1Rk?=
 =?utf-8?B?UVJoOXVrNVRzN2N3WkYvSUw1eHJEdTVYZ1lFSk9UTnF3MGV2bEc4K0N5Y1JD?=
 =?utf-8?B?MXd3MFE4eEFyZjVHWVN0aGkvbjJFNjh0YStLRlBISTF1enFZYUo3dUJnaXZE?=
 =?utf-8?B?RjhQSGZqVEcvRFVhclo1VU1tend6K1NYczlnNUFwVkhiYi9XYjMvUXpGaFRU?=
 =?utf-8?B?Z3BnNHIwZVh1K2F2MzhFRU5uMkY2NVJmY09VQkxQNDhQNVZackJkTWRDZU9t?=
 =?utf-8?B?S2dNMnVyUjZqUk5sQkdBSzZ3RXNZekMzNDRNN2tJQ1UrVnB3TTg5eUp2bm96?=
 =?utf-8?B?QStVMXJjQWhEbFpkKzFiTTBPU2ZyU0lSVC9WeFdyVXQ0Rk1nUW92aDEwZGxJ?=
 =?utf-8?B?OXFTYXU0SGFVLzI2clBXOFN5RE1hT1kyQUJUdjJnNmVRT2lwQVZtdlY0Umpr?=
 =?utf-8?B?TTVCejV1QmIvdjBXWjNrQ2FoM3pXT0dtRTV6OVdscE8xSmFRVXRjU2orSElL?=
 =?utf-8?B?VDBvY214eml5ZS8rKzhjMGV0Tko1eFNIU05OS20vVWs5czIzdjYyWTdiQTVI?=
 =?utf-8?B?R3ordjZ6NzRaZFRzYlpuNWdSRWtha0dnUk5BNDJXd3V0dUJKU2ZLb0thQlcx?=
 =?utf-8?B?WnRKdEFwbmlQUElvbklSVUZ6YzM3Nkl1M0NMQWljYm9pSUlkbnUzOWJXbzho?=
 =?utf-8?B?YTBlNkVyZVlqRDQvM0hRNlZ5ZmowMXBoUll0SEFxWm40YTF4S3RudlFFWHhB?=
 =?utf-8?B?WWNpYTZHeXFzTHdHaE9FUVpwdnorZ0ZPanFiVHplOFk1c3B2SHdSTFFNQndV?=
 =?utf-8?B?M05tMnZCenhSTzNSbmdJU2I2Y3NnaFM2SlNhbWZXK2lYbzV4VTAxYStSOFFp?=
 =?utf-8?B?WkptYy9MOG9wNzV4QkllRTE0MzUyS3NMSkYydU03TWxaOUJPVzN3S3VLNlp5?=
 =?utf-8?B?UytKNms2VzhxK001a1pNMy9zVVlUcjhYdXlQNXI1VlFCREFrNHJHUHBrK01D?=
 =?utf-8?B?NXNySE8vMXJTOWZFTlpONlcwQi9jOGxrMEVXN3ZqWFQ4WXBOdHp6c1BJUFkz?=
 =?utf-8?B?UnE0Z3FLN3dQamt6MHFlRnBlRFRLc3JHSlRxUVBENkZ1OUNxaXRYTW9VRE03?=
 =?utf-8?B?WUpKU1U5TU1BVTFFTjhyOWNqZmtMT2Jucm15aUpSRElaQXJQTVd2QkFkS1RD?=
 =?utf-8?B?a3ZLcjFTU0pQUWloZ2lrM1FqQnZ4eGNzcVI3cWY1MFdzNTRPSjJaclR6YzI4?=
 =?utf-8?B?Mk9GUDZSbzYzZWQ5emFKcjAwRG5xbmFYL0Z3SHB2MEhsOEU2eDFSRzYweFdk?=
 =?utf-8?B?NngyNmRmVkRlcDBMa3VENkwxNkZQeHpSMGlJMU9CM2hFYjJmd2Vldz09?=
X-Exchange-RoutingPolicyChecked: P1t+AsbRzKFAs3540lv+CAFkbJlzhdxR4XnsFnmrvqefhUqqfctxmK2CbADBLFEPtHSwuRbkJutfAWm8/vDZwmnpYx1n35HhCLaXEwGUxmXnZ/epjYh31Oh1ABSv1mDZ/tCNe1R+fgf1OfO3GtrUj4OfApJ1T/LI9mQ0DsoBjhmL44M/vMBeZsy0PMteznOkbrCnTvFV9tkOO+NfuX66WFjb5WlbSigalL2HUFyuP9EtlSKNVamw5PULnSBE0js9Fn7akN6tZAq2yycE1CUfzIj+K6J7UbuEQ1CuhULohiEGW1RZCy+Qx9+E8Yx0n3JNst/kzcjL4C1jvd+r4OC+7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4ba1a2-7fb2-4214-6ca0-08dee20a63c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 00:45:38.5245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHgOzRbWR5X7eL/ccout5nhFMbq0Bo1aQ9wntonpY0K8WKN8rUjeemJDBHUHcxhsazf8xQqQoujr56feDoZ8ihxFMHVqw/UiERbszfT+TL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6504
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307629-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:akiyano@amazon.com,m:davem@davemloft.net,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:richardcochran@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:dwmw2@infradead.org,m:tglx@linutronix.de,m:mlichvar@redhat.com,m:andrew+netdev@lunn.ch,m:guwen@linux.alibaba.com,m:xuanzhuo@linux.alibaba.com,m:dwmw@amazon.com,m:ysarna@amazon.com,m:zorik@amazon.com,m:matua@amazon.com,m:saeedb@amazon.com,m:msw@amazon.com,m:aliguori@amazon.com,m:nafea@amazon.com,m:evgenys@amazon.com,m:netanel@amazon.com,m:alisaidi@amazon.com,m:benh@amazon.com,m:ndagan@amazon.com,m:darinzon@amazon.com,m:evostrov@amazon.com,m:ofirt@amazon.com,m:amitbern@amazon.com,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:shuah@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,amazon.com,vger.kernel.org,kernel.org,lwn.net,linuxfoundation.org,linux.dev];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2B07759BE8

On 7/13/2026 7:03 PM, Arthur Kiyanovski wrote:
> Introduce two new ioctls that extend existing PTP timestamp interfaces
> with clock quality information:
> 
> - PTP_SYS_OFFSET_EXTENDED_ATTRS: Extends PTP_SYS_OFFSET_EXTENDED
> - PTP_SYS_OFFSET_PRECISE_ATTRS: Extends PTP_SYS_OFFSET_PRECISE
> 
> These ioctls provide quality attributes alongside timestamps:
> 
> 1. error_bound: Maximum deviation from true time (nanoseconds), based
>    on device's internal clock state
> 2. clock_status: Synchronization state (unknown, initializing,
>    synchronized, free-running, unreliable)
> 3. timescale: Time reference (TAI, UTC, etc.)
> 4. counter_value: Raw system counter (e.g. TSC ticks) captured by the
>    timekeeping core alongside each system timestamp
> 5. counter_id: Identifies the counter source (e.g. TSC, ARM arch counter)
> 
> This supports three use cases:
> 
> 1. Managed PHC devices (e.g., ENA, vmclock) that maintain their own
>    synchronization and can report quality metrics directly to userspace
>    without requiring ptp4l
> 
> 2. Applications that need complete time quality information in a single
>    call, regardless of how the PHC is synchronized
> 
> 3. VMMs that need raw system counter values paired
>    with PTP timestamps for feed-forward clock calibration, avoiding the
>    feedback loop inherent in NTP-style synchronization
> 

I'm also wondering if this can expose device-known error bounds on
timestamps even for devices which are operated as synchronized by ptp4l..

> Timescale definitions use a Continuity/Discipline framework to describe
> timeline properties and steering behavior consistently across all
> entries.
> 
> This implementation is based on the original RFC and the UAPI design
> discussion linked below.
> 

Not a dig against this patch set, nor a request that you work to
implement anything else, but I am beginning to wonder if/when it would
make sense to transition from ioctl-based implementation to genetlink or
something. We did something similar for ethtool ioctls a few years ago.
I know the maintainer for PTP has some distaste for netlink and prefers
the simplicity of the ioctls.. but I think we're moving past where the
ioctls are "simple". Now that we have ynl tools, it has gotten easier to
implement properly. It makes extending the API much easier for the
future vs the array of ioctls we now carry for legacy implementations.

> 
> diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
> index 46d45f902486..88c2da6bc8c6 100644
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -79,6 +79,137 @@
>   */
>  #define PTP_PEROUT_V1_VALID_FLAGS	(0)
>  
> +/*
> + * Clock status values for struct ptp_clock_attrs.status
> + */
> +enum ptp_clock_status {
> +	/* Clock synchronization status cannot be reliably determined */
> +	PTP_CLOCK_STATUS_UNKNOWN      = 0,
> +
> +	/* Clock is acquiring synchronization */
> +	PTP_CLOCK_STATUS_INITIALIZING = 1,
> +
> +	/* Clock is synchronized and maintained accurately by the device */
> +	PTP_CLOCK_STATUS_SYNCED       = 2,
> +
> +	/* Clock is drifting but remains within acceptable error bounds */
> +	PTP_CLOCK_STATUS_HOLDOVER     = 3,
> +
> +	/* Clock is drifting without adjustments or synchronization */
> +	PTP_CLOCK_STATUS_FREE_RUNNING = 4,
> +
> +	/* Clock is unreliable, the error_bound value cannot be trusted */
> +	PTP_CLOCK_STATUS_UNRELIABLE   = 5
> +};

Do you have any thought on how ptp4l synchronizing the clock should
impact the clock status here? Is this intended purely for device/drivers
which have their own synchronization and not for ones which expose a
clock that is synchronized by userspace? Would it make sense to have a
mode that is something like "this clock has been modified by userspace"
after any call to the .adjtime or .adjfreq is made?

> +
> +/*
> + * Clock timescale values for struct ptp_clock_attrs.timescale.
> + *
> + * These definitions describe the mathematical properties and reference
> + * epochs of the timescale provided by the PHC.
> + *
> + * Discipline: Describes the frequency/phase steering behavior.
> + * Continuity: Describes whether the timeline is uninterrupted.
> + */
> +enum ptp_clock_timescale {
> +	/* Unknown or unspecified timescale */
> +	PTP_TIMESCALE_UNKNOWN = 0,
> +
> +	/********************* Absolute Atomic Timescales *********************
> +	 * These timescales are continuous, monotonic standards based on atomic
> +	 * physics. They do not experience phase jumps.
> +	 **********************************************************************/
> +
> +	/**
> +	 * International Atomic Time (TAI)
> +	 * Epoch: 1958-01-01 00:00:00.
> +	 * Continuity: Strictly monotonic and continuous; no leap seconds.
> +	 * Discipline: Primary atomic reference; no phase jumps.
> +	 */
> +	PTP_TIMESCALE_TAI = 1,
> +
> +	/**
> +	 * Terrestrial Time (TT)
> +	 * Epoch: 1958-01-01 00:00:00.
> +	 * Continuity: Strictly monotonic and continuous; no leap seconds.
> +	 * Discipline: Defined as TAI + 32.184s constant offset.
> +	 */
> +	PTP_TIMESCALE_TT = 2,
> +
> +	/**
> +	 * Global Positioning System (GPS) Time
> +	 * Epoch: 1980-01-06 00:00:00.
> +	 * Continuity: Strictly monotonic and continuous; no leap seconds.
> +	 * Discipline: Defined by the GPS constellation; fixed offset from TAI.
> +	 */
> +	PTP_TIMESCALE_GPS = 3,
> +
> +	/****************** UTC-Based Timescales (Civil Time) *****************
> +	 * These timescales are derived from TAI but adjusted to align with
> +	 * the Earth's rotation, primarily through leap seconds.
> +	 **********************************************************************/
> +
> +	/**
> +	 * Coordinated Universal Time (UTC) - Wall-clock (CLOCK_REALTIME)
> +	 * Epoch: 1970-01-01 00:00:00 (Unix epoch).
> +	 * Continuity: Discontinuous; subject to 1-second leap second
> +	 *             phase jumps.
> +	 * Discipline: Frequency steered; incorporates leap second corrections.
> +	 *
> +	 * Note: Leap-smeared UTC MUST NOT be advertised as PTP_TIMESCALE_UTC.
> +	 * Smear algorithms are not standardized and the resulting timescale
> +	 * is ambiguous. Implementations using smeared UTC MUST advertise
> +	 * PTP_TIMESCALE_UNKNOWN or PTP_TIMESCALE_PROPRIETARY instead.
> +	 */
> +	PTP_TIMESCALE_UTC = 4,
> +
> +	/**
> +	 * POSIX Time (Unix Time)
> +	 * Epoch: 1970-01-01 00:00:00.
> +	 * Continuity: Discontinuous; leap seconds handled by
> +	 *             repeating/skipping values.
> +	 * Discipline: Follows UTC frequency steering and phase jumps.
> +	 */
> +	PTP_TIMESCALE_POSIX = 5,
> +
> +	/****************** System-Relative Monotonic Clocks ******************
> +	 * These timescales are relative to a system event (like boot)
> +	 * and are not synchronized to an external atomic standard.
> +	 **********************************************************************/
> +
> +	/**
> +	 * Monotonic System Clock (CLOCK_MONOTONIC)
> +	 * Epoch: Arbitrary (System boot time).
> +	 * Continuity: Strictly monotonic; no leap seconds.
> +	 * Discipline: Frequency steered to match system reference;
> +	 *             does not advance during suspend.
> +	 */
> +	PTP_TIMESCALE_MONOTONIC = 6,
> +
> +	/**
> +	 * Raw Monotonic System Clock (CLOCK_MONOTONIC_RAW)
> +	 * Epoch: Arbitrary (System boot time).
> +	 * Continuity: Strictly monotonic; no leap seconds.
> +	 * Discipline: Raw hardware oscillator; no frequency steering
> +	 *             or discipline.
> +	 */
> +	PTP_TIMESCALE_MONOTONIC_RAW = 7,
> +
> +	/**
> +	 * Boot Time System Clock (CLOCK_BOOTTIME)
> +	 * Epoch: Arbitrary (System boot time).
> +	 * Continuity: Strictly monotonic and continuous; no leap seconds.
> +	 * Discipline: Frequency steered to match system reference;
> +	 *             advances during suspend.
> +	 */
> +	PTP_TIMESCALE_BOOTTIME = 8,
> +
> +	/********************** Vendor-Specific Timescale *********************/
> +
> +	/* A proprietary or vendor-specific timescale with custom rules. */
> +	PTP_TIMESCALE_PROPRIETARY = 9,
> +};

I appreciate the detailed explanations here as it helps to disambiguate
the modes.

> @@ -106,7 +350,11 @@ struct ptp_clock_caps {
>  	/* Whether the clock supports adjust phase */
>  	int adjust_phase;
>  	int max_phase_adj; /* Maximum phase adjustment in nanoseconds. */
> -	int rsv[11];       /* Reserved for future use. */
> +	/* Whether the clock supports extended timestamps with attributes */
> +	int extended_attrs;
> +	/* Whether the clock supports precise cross-timestamps with attributes */
> +	int precise_attrs;
> +	int rsv[9];       /* Reserved for future use. */

I do kind of wish we had opted for bit flags here given the number of
ints being used as booleans.. :( A lot of wasted reserved space.

>  };
>  
>  struct ptp_extts_request {
> @@ -252,6 +500,10 @@ struct ptp_pin_desc {
>  	_IOWR(PTP_CLK_MAGIC, 21, struct ptp_sys_offset_precise)
>  #define PTP_SYS_OFFSET_EXTENDED_CYCLES \
>  	_IOWR(PTP_CLK_MAGIC, 22, struct ptp_sys_offset_extended)
> +#define PTP_SYS_OFFSET_PRECISE_ATTRS \
> +	_IOWR(PTP_CLK_MAGIC, 23, struct ptp_sys_offset_attrs)
> +#define PTP_SYS_OFFSET_EXTENDED_ATTRS \
> +	_IOWR(PTP_CLK_MAGIC, 24, struct ptp_sys_offset_attrs)
>  
>  struct ptp_extts_event {
>  	struct ptp_clock_time t; /* Time event occurred. */


