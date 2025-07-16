Return-Path: <netdev+bounces-207431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 089E4B07349
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 12:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422E11C218E5
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7BC2F2C7E;
	Wed, 16 Jul 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOF9NlIa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DA2EE985
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661560; cv=fail; b=nl/2cajv299mTQW0q6yaCp7Gyu/tJGFvg4IYUgji7ypJwgiXhdMbN3NaEozKCEuZmnnvbweYt17RllXFWvtucidk9MlEAw5HBw0QQ2ktyKp7OQyknmdlrwhkpvUf8wrQiqEBcCD36uUQ2QGz+CwSeXjWSkdFYovgM2VKvQqFAKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661560; c=relaxed/simple;
	bh=2tq4Ts47kCuSA6y1FFbgVuZeaCYYHKc4Em3wXDzsx/8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pvOJCWvk42z03GHJUvBQXE5WNs8Qsf/d7JdQNDGqiIiR7MHW1cpygTeOOlNmPrUG/mr8y2Jv+Vlol6F8qH93dB2QhL3rHK11bwsuKERAZsh4W6xcpVGKF0sRU3hlwEKqQDuzCkqR2lCQu/wo62EK3jhcws7OLcG0oc3kuSc4frM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOF9NlIa; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752661558; x=1784197558;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2tq4Ts47kCuSA6y1FFbgVuZeaCYYHKc4Em3wXDzsx/8=;
  b=UOF9NlIaFaMbjjzFTnQbOyYIwPtbGZSCpj5HMdUHKrY6GxS/37Sa6gxj
   57HcSaKoR0Lxuk5Sq+zFwkDwP8uU18etukj81akmP0UvrvB+YO008pqwD
   pCk97o0dljLpGe7S1vBQ9HERiLUpNF3cv06vdrzgQzs0b9VUGv9hPabXf
   ZYJY7B6ezB9Cuv2vKz0D6CRM8EgL4zzm0mk3OxPzlrDCLuCfHTiD76wDB
   bds5XNhBhclwhC00PlAMFZI5dbU7arqX8owOvckJw418NnanubKf6W0+o
   hF2k4WHmqLewODe41Votq2rll00fIIeB6RljEfxPVWlksqvImDgHDY4zo
   A==;
X-CSE-ConnectionGUID: OQGPk5cxTgWWtxTtvw0iKA==
X-CSE-MsgGUID: T6ItDqvwR++gcSpC4c/ufQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58715016"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58715016"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:25:57 -0700
X-CSE-ConnectionGUID: OUX/lL18SuaRYTe3kqrhsA==
X-CSE-MsgGUID: uNdrbCqZTjKP8mOC43EfUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157955719"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:25:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 03:25:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 03:25:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 03:25:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNt3aG4wP+XGA9MrxRQ2ltKhNb8MEtlm5oQUx8xQo2kNOWbQdkD1BV7B8XivkgGvCoygNeLHOxAEtKq4/EZ2tI8TVfjguLwf4EESv/XbdGUlvtE0hd+zJMUwT+PG0WVtTRetAcgd4WWU1wkx5GyA0fJWOKNtbeF2Z0gYj1pwc+eY9tKuySeMBCa12H/WNc0XCDVgl7aC6mFCNCVEFWFV3JNsUAZ6Ky+DBkjQ7XWJ0m47cc1fHEtJYj17xtk1lJsNFm9bLVOfsLOFi0/BM637GoRjJ4DXkVnhErIw3M9j4fseeueviR/qEC1P+K/7YPicLYVFPtz/HJUGmwAagRikLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saIXZ6u3DTP7+119UZcHZIdkA7LL776vHPQIyqGs0Fg=;
 b=COhUnGzNNZwGdJqAeAe9nwmSbEXkmOjrSljadkegS6r35MRRjzAWM3EtnBxPyqm6vzKqh56/e8/cyqk8CfAg2FIjxTwwsZ5nnyRXwwImjgqrSQUktLwt3jJ3DIEIbqNJZEM2jVjXWxSHuHRzF/NhTCb9tDKAZyzSv3vw0siljiVNUgtXVOQ0nLpfwnv46yBrp0HUW8C7wgzMtxwp1cUSAgQA7vvV2c3GxIdRmSO639ucqUOnk1TLAi75qe3JkKTTIEQoUNBm7kXQAQPlmcyCwoEA+HHCJ6Nd/s6w4G3gztfYGzEubcCQMdsXrlWf8ps2RaCc8AnLVKo3D6VaysfxgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB8894.namprd11.prod.outlook.com (2603:10b6:208:574::9)
 by CH8PR11MB9459.namprd11.prod.outlook.com (2603:10b6:610:2bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 10:25:50 +0000
Received: from IA3PR11MB8894.namprd11.prod.outlook.com
 ([fe80::817d:526d:9031:d5ba]) by IA3PR11MB8894.namprd11.prod.outlook.com
 ([fe80::817d:526d:9031:d5ba%4]) with mapi id 15.20.8769.022; Wed, 16 Jul 2025
 10:25:50 +0000
Message-ID: <b7265975-d28c-4081-811c-bf7316954192@intel.com>
Date: Wed, 16 Jul 2025 13:25:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Simon Horman
	<horms@kernel.org>, "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
 <20250714165505.GR721198@horms.kernel.org>
 <CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To IA3PR11MB8894.namprd11.prod.outlook.com
 (2603:10b6:208:574::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB8894:EE_|CH8PR11MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 647966dc-b39e-45f6-d3fa-08ddc45322e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2VIaWNiam1aYXdidnhxS2tFUk5WWHlqRXloU28yYnFwTHJuY3J2c0hVQW40?=
 =?utf-8?B?SGV2Y29kNVhJOFJmZ2tGRmVqTVVKTGJPcTVXQkI4VkhrT1ljV3huQ0ljakdE?=
 =?utf-8?B?VEk4NDZuditMR1pkVTF5Tm92bFFzS0ZTK0NLSy9keElQejgwQ1dWS0hEdXZz?=
 =?utf-8?B?U05oeXhwd0FGUHRrWUdHemRGSlRMSWZQSUZYWDNWcm9QblNwU1RFTDM3Qm5n?=
 =?utf-8?B?b1pUL1MyamEvTXJkMmVrUkljelRTNWtXVWo2dzEzSkxEa1V6RGZucDFzSFNq?=
 =?utf-8?B?ME1ydjVpbVkyYmthaXRRQlNIQUZNRUtlYU4xdTNndGpRTXdBT1FFZG1EL2tB?=
 =?utf-8?B?QUNOOHpYay96akEvNXB1NEprdHFkcGsvQWxQSGtkUUMzRUNnNk1tc3ZFTE0z?=
 =?utf-8?B?dEJuNVJyM2x5L3I3aHZqMVgvZEF6MVEyeGdydTE5MkVpblY2SVZXYlpYZXlo?=
 =?utf-8?B?MCtMaUsvUzdOVmdWNWN6Y3R5UjBFMHpSaEFySXpqUnFQc3ZRYWttV0ZMdC95?=
 =?utf-8?B?dDBablJvV0owMW5tMkpoYjkxc04xOVpFTVV5RGd1N3NBK2UzVUFqdVE5ZDlP?=
 =?utf-8?B?M1VSRERqUFAxYS83ZFlvbWlLQytqM2JhS2VNYVcwRXRZU3ROYWpTcG5GejBj?=
 =?utf-8?B?QzhPMng4cXZscms1QzU5a3N5ZldWUU15WnJqWlpxdVpoZVl5OWVMWW16MHZk?=
 =?utf-8?B?Mzl0aGptMUFyb3NBOGV0emxZTjByMU5GKzc1M3llWXJ0SHhOMW9UU1BqYTFN?=
 =?utf-8?B?empzU2tzUFRxOTFZbVVtdUN5K2tyZGsveTFOZXo0YW9DaHZOQXdpTXJxWXlx?=
 =?utf-8?B?cjZVWUpUNkJaSFpFSEViejNoNHA2TTJCd3hHZ0t3QXdrUjJhaHNOVlhqdjJF?=
 =?utf-8?B?Ly95U00vQnNSeVV6T0FaNDJ0TjhJTTl6dlQ4YzBHNEZEU1k1eUtrKzBQemNh?=
 =?utf-8?B?RnlHUWJpQUorU2lNbU92c1h6N2NFVERmWEFuYXBSc1BsWUNlZExjaG5uOWNV?=
 =?utf-8?B?TE5sWUUwYnl6Wm42dWM0aCtZZStSK3l6eUFKUk5WTklVaDlXaERxeUI5MU5F?=
 =?utf-8?B?RjZHenJuZFJYM01hLzZtaWQxVkRTNloxK28xTG5McG14ZUxnUnZyTFlac1JW?=
 =?utf-8?B?NE5yL0ZnYXpUK0pCNGZyVHROVFc5TlVZNmhaY0RSUHh3YUtjUXd5Unh4ei9k?=
 =?utf-8?B?Y25FUG1ON1F3YStYQjM5OG9Va1VBTHl1cTRtSXR2ZS9vSFNFTnJicVovaEdz?=
 =?utf-8?B?d09MeGZkenlvb25ZUFR2dkQxSjdjWEVhbDVQSkJNdWdMakNaT2pLZmxsUWlj?=
 =?utf-8?B?bVRYWmxUSlp0dU5pQjRyRmx4ZE0wMEJJYklKSWhRYnMzNmIvMlJiVjlzM2J0?=
 =?utf-8?B?VjNxQTdkMW9XOHBQSzhYR2VCdlVqYkU0VVRmR2J3UFZFb3VYY0xQc24wTG54?=
 =?utf-8?B?ZENXNWNWQTE3eHpCYldOMzEwbHl0cXJSUE1xWHJ6eHJBMWwzOUE0TzBjSzlR?=
 =?utf-8?B?VUZ0MkN6bzBoSjNtMWI2OG9zSFFNSkRIRVV2RVc4TFFVbDhNUjA3NkhJeHhz?=
 =?utf-8?B?T21yd3JYbFd4MTBFR1hqbitzeWZkU0xZLytLcEl5SjNVTm53UC9WL3VkSFI5?=
 =?utf-8?B?RHNUNXdvOW0ram9hSnE4Tk8rNHd0ZHkvaDVhTTcyVVJ1dnRtbkZDME0zcnY0?=
 =?utf-8?B?TmlZTXFLemNybW1CcjRRdWVxZ2FjazRIL1oxRjI5V010VGszU2tKWTFCK0lQ?=
 =?utf-8?B?V1N1Qml1ZXBCQ05UMTlMblVyQTVoN0QrTGIwaTdaalBROVBpMnZFUHo3NzAr?=
 =?utf-8?B?VkFxTk90cTF4MkRkVnVjZHAyN0lMZmUrb3BIb3F6ZGR2b2dwZSs5TUprTW1t?=
 =?utf-8?B?WmdrL3RlZTBES1JQdE5kRkM1Zmt2Uk9hUytIVFoyUm9JMiszVHY2aWRxT1NC?=
 =?utf-8?Q?ZVgsfjum7zU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8894.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlkrbVhlbVRzZERSaUdwamlxdWVMZVBPbUc5Si9waUY0Qm9GR0lvaE9UdEZI?=
 =?utf-8?B?ZWd6L0FEdm1LaUFvSnFlYUl0NGlUY1RvQkdxdHdCS3Nib0dYLzNBRW9BSVZh?=
 =?utf-8?B?Z0liK3A0VEgzVHV1NDQ4eVY3dlpSYi92L2VtS25TRlBOZVI1VERLRXNzZGlO?=
 =?utf-8?B?WkJ5MDdoR21YelJoU1NZTnlTcHVFZU5jcnhGK3JXZlB6S3pRWHJwcEpzcmFa?=
 =?utf-8?B?WG4rWFVsemV3TXp6T21CVlhZWTYxZDZ1QzBxdVh2dCs3VmZwV2xkNEZoTmZ2?=
 =?utf-8?B?VWFSejE3QnFXUitYeDhGa2x4ZVFvaTZ2a1crSUhzZ1JObXEzcmVqZS9iZ1NH?=
 =?utf-8?B?TFVLSVEzSlFjV0JkN24wMXlSVmNxUE5LZVQ1YUN1cUhnWklvU2FaRG5iVE81?=
 =?utf-8?B?czJ4cXZ5Yzc0ZEFhWTBLTDdEWmd6WTYrdmFSQVd3UG82eGJaY0RXQVQra3ZF?=
 =?utf-8?B?RTgzMUhmekZWc2hqMXdOTW1zR2Z2bjVoOU9zcmlvQUFIdzhuTzhubjZpaU03?=
 =?utf-8?B?RHIxc1NQcERmaFFHSWZva0c0cmFiMmYzSU44c3FlS2kwaHNFdDNaek96RTV3?=
 =?utf-8?B?MEk3RnNxZXRSVUV5NlBIWHZkOThIeSszak14UUFFSnhtUzh2UHR4SHR3Mzk3?=
 =?utf-8?B?SzBTODhjaEtkdTQ1OThMYWx0RUp6WTB4aUdyTzBQeG1KWlozdWdHY2hTUG1G?=
 =?utf-8?B?NkVCVHR6TXdNUWw4Q0xlN0lKK1FpbThIb1ZFcUVFS0NnNFpkREdmQVBlQXND?=
 =?utf-8?B?Sy9rUUVHZUtUTjFqbmo4YldxS2lwNEsybjZCbk5hTXZldTNNT3hUZ2hySWdl?=
 =?utf-8?B?bUQ5UUF5OVZzaGo0UXRGdWFrazcvUjVtR0VFcHA1bGZFbEtFei84eU1VMGRi?=
 =?utf-8?B?ZmorZWZ0RjUycVloZ0s3RzlSY3oyTG40U0VvUk0rN25EbzJ3QjZZdmJqbFhj?=
 =?utf-8?B?R0F4ZGg3NnVNQ3VsY09WdEJBNEFrSXA2MUlFRWdvdGFBMXlTUnRNK0tIUnZx?=
 =?utf-8?B?ZVN5eE5Wc0RxS3kwNERpUHp0SS80cVpnbkgwby9POHlYd3IxUjIzaS9FNnMv?=
 =?utf-8?B?OHRCZm5RZEI3aS9KZnorMVpkckVtNjNlczB6VGpiK3hNL1lOaEhMTTIvSFB5?=
 =?utf-8?B?SE9mTTUycG9UKzhDUUhna3E0bXBkTVdBRHJWZHBmRE5vQk9pSlRXWEJBWk5I?=
 =?utf-8?B?WlptUlRPR1FXd09BbzdOL09pRFhZN0RBblRFWHJDb0VKZjhwM2l6V1c0KzFB?=
 =?utf-8?B?NVFkdVNzQS9ydGJCYVlxTk84Q01oVVBiSWtCck0xMmlXZEQ4Q0UraWJFRkYx?=
 =?utf-8?B?WE9CeS9nd1k1cFk4T2NHbjRzRE53NTllYTA3V2Q0M0RXYVlZampyaXRKekNS?=
 =?utf-8?B?akpCZGJlL1JUUEpCMEpzNmlVUE1YQk5CU2gxemRwS2xlVEJKNDRVNnpnU3ZC?=
 =?utf-8?B?ZVArR242aGdYNHhncENDd3BHWmVobjZWRUN6VWtxbTEraHpQaWJWSjE5S2lH?=
 =?utf-8?B?ZWFVdmZnVUFnVkJvVkFMK1g4OCt6TTBzM2F2NTdQekZNM3ZQUTdNSXRFbXRx?=
 =?utf-8?B?ZWg1b0tpaFVOaXFRNUNvaGx0ejhXR1l3R1NvTDN0bXFDM2ErQVRSTUVaOWs0?=
 =?utf-8?B?eXBYUE1lN1JDSGtja3VqYVpnb211cEVYdHFyeCtvaDNoNXNUU3FUMGo5M0sy?=
 =?utf-8?B?RUJSc1JaM2pwV2ZGN1MxK1REdnFMc21BUVMybERWMCtGbGVhTUhwOHFYUXV4?=
 =?utf-8?B?Zk1ydVdnQUN0M0ZqRTMyRUdEM0hBb25FR0F1K2Q0aXR0c1Jvek5jUlFudzRV?=
 =?utf-8?B?TWlVMGQxamtQTGhaUnNwL0lyc0FscFNjTFhhK0J4QkJZZ1RJUFBoVmtRb2s3?=
 =?utf-8?B?N0sxbEV1THViMGplcGx4QjZDQ2FlSkhMbEdwOG4rSjQ1NGlnT0I0MFJ1RHdv?=
 =?utf-8?B?OVVKTElFY2U2RVpoVHhGNXJ0TGpVYVloYlc3bVhyU1pWczl1N2dDZnB6OUZT?=
 =?utf-8?B?eG10RlRSRDdIQkx4Y1hIT2w3TXdhalRTZk5wYlNFandIQzQ4M1AvS2M5MXRm?=
 =?utf-8?B?ek5CbzNqaUpqY0lXOExUZW5qYmE3dU9JSjBQOGNDN3VIUlFiOGwraDdKTnNp?=
 =?utf-8?B?VDNtUFIwaS9yR1Flbjd0ZTJ5ZGVrTTB5aDBEQ2YrOWFlTVpRMUtwQ3BpdzNG?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 647966dc-b39e-45f6-d3fa-08ddc45322e7
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8894.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 10:25:50.4871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUyrxvrAPECyQiK11rCRnIZahwmcOLLciJVAGf+d+89Vv50nqobA5hN6lneGEyr1IZPMARcRupJlhULbQt2zSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9459
X-OriginatorOrg: intel.com

On 15/07/2025 0:30, Keller, Jacob E wrote:
> 
> 
>> -----Original Message-----
>> From: Simon Horman <horms@kernel.org>
>> Sent: Monday, July 14, 2025 9:55 AM
>> To: Lifshits, Vitaly <vitaly.lifshits@intel.com>
>> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
>> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; Ruinskiy, Dima
>> <dima.ruinskiy@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
>> Keller, Jacob E <jacob.e.keller@intel.com>
>> Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
>> param to disable K1
>>
>> On Thu, Jul 10, 2025 at 12:24:55PM +0300, Vitaly Lifshits wrote:
>>> The K1 state reduces power consumption on ICH family network controllers
>>> during idle periods, similarly to L1 state on PCI Express NICs. Therefore,
>>> it is recommended and enabled by default.
>>> However, on some systems it has been observed to have adverse side
>>> effects, such as packet loss. It has been established through debug that
>>> the problem may be due to firmware misconfiguration of specific systems,
>>> interoperability with certain link partners, or marginal electrical
>>> conditions of specific units.
>>>
>>> These problems typically cannot be fixed in the field, and generic
>>> workarounds to resolve the side effects on all systems, while keeping K1
>>> enabled, were found infeasible.
>>> Therefore, add the option for system administrators to globally disable
>>> K1 idle state on the adapter.
>>>
>>> Link: https://lore.kernel.org/intel-wired-
>> lan/CAMqyJG3LVqfgqMcTxeaPur_Jq0oQH7GgdxRuVtRX_6TTH2mX5Q@mail.gmail.
>> com/
>>> Link: https://lore.kernel.org/intel-wired-
>> lan/20250626153544.1853d106@onyx.my.domain/
>>> Link: https://lore.kernel.org/intel-wired-lan/Z_z9EjcKtwHCQcZR@mail-itl/
>>>
>>> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>>
>> Hi Vitaly,
>>
>> If I understand things correctly, this patch adds a new module parameter
>> to the e1000 driver. As adding new module parameters to networking driver
>> is discouraged I'd like to ask if another mechanism can be found.
>> E.g. devlink.
> 
> One motivation for the module parameter is that it is simple to set it "permanently" by setting the module parameter to be loaded by default. I don't think any distro has something equivalent for devlink or ethtool flags. Of course that’s not really the kernel's fault.
> 
> I agree that new module parameters are generally discouraged from being added. A devlink parameter could work, but it does require administrator to script setting the parameter at boot on affected systems. This also will require a bit more work to implement because the e1000e driver does not expose devlink.
> 
> Would an ethtool private flag on its own be sufficient/accepted..? I know those are also generally discouraged because of past attempts to avoid implementing generic interfaces.. However I don't think there is a "generic" interface for this, at least based on my understanding. It appears to be a low power state for the embedded device on a platform, which is quite specific to this device and hardware design ☹

Basically what we are looking for here is, as Jake mentioned, a way for 
a system administrator / "power-user" to "permanently" set the driver 
option in order to mask the issue on specific systems suffering from it.

As it can sometimes manifest during early hardware initialization 
stages, I'm concerned that just an ethtool private flag is insufficient, 
as it may be 'too late' to set it after 'probe'.

Not being familiar enough with devlink, I do not understand if it can be 
active already as early as 'probe', but given the fact that e1000e 
currently does not implement any devlink stuff, this would require a 
bigger (and riskier?) change to the code. The module parameter is fairly 
trivial, since e1000e already supports a number of these.

I do not know the history and why module parameters are discouraged, but 
it seems that there has to be some standardized way to pass user 
configuration to kernel modules, which takes effect as soon as the 
module is loaded. I always thought module parameters were that 
interface; if things have evolved, I would be happy to learn. :)

--Dima

