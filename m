Return-Path: <netdev+bounces-123723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C2C96646D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E80B20B9E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C64918FC81;
	Fri, 30 Aug 2024 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtNQuvVt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88C25569;
	Fri, 30 Aug 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029275; cv=fail; b=AW6Y/4X6KD4n0W8dUot6bn5yHspzxDuqDuyNJ6gSWcPc/Ea8YpxRbyJUXqNdH5uNdLI30aJwYqdT7DXviTba1SvG0j9+4WoTayCxPCx6P6tfVqrQk1UH1j1PI4IXIMRryVL3yrfE+qBIJRCAFIG6F118E+K+lLirmQ0C6GgZ5AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029275; c=relaxed/simple;
	bh=1pxFRStcfjxlrrmdbQiLiUfNn/2PfAgR433BsTYpLEk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=svV1oE9HxPOXZ9wmRfwhemz6WjTphWYXheymQ6eiu37rY7EdkuB/mXUPrmdTGGGOJxj2RyjwZ9jjSuxDKilM5QMu75OWJhPMcAYEj6QFgDHTvkua+OuUl+Ej1iu7n/er2l4SWRtBP9Mi8fo8GxFfeEgbiMWbxpmyjY6hz2rMl1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtNQuvVt; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725029275; x=1756565275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1pxFRStcfjxlrrmdbQiLiUfNn/2PfAgR433BsTYpLEk=;
  b=mtNQuvVtAek9+9tCxZo0u3xYK5aNUPEhBLI8ejaoKXpCAYSJxJtbw7Tf
   a3UINS2dDwLVNgOMxg6P5e2YzOMcRFpSCa5dYlUWrfDvhrKL45v1x6rOg
   14ip3yyYofRAfbP/krpknuMZziY6fmgazq2e76uEm29ibxX7CPUPK4m41
   H0Bu5LtYcTOU80aoaNMg4JWJW6ta/wUVyOt0iyFLma+UwLsTryLbbAEbx
   R+mUki7xymgi/RJ1lg0MD0QVxO74v7uKznU5SSD/mNx/WSThGbMYTJbgV
   ozJptPUV2AuIZHN+HIjU13VhO6mXvbhecYN3oH+9U+h4ky+k2yhZ4hH4x
   g==;
X-CSE-ConnectionGUID: 9XzQlbhMSu6dh0gdrLzJ8w==
X-CSE-MsgGUID: ta3tYnoTQI6fe0DmkEJgDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="49058172"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="49058172"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 07:47:53 -0700
X-CSE-ConnectionGUID: Psax2cXiTcacNKzskxKHag==
X-CSE-MsgGUID: IvnPoouNTaGNMrAHL+B91A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="87155940"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 07:47:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 07:47:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 07:47:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 07:47:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re5ua1ao+bTQmooUXZh5ZIzqVRwdegThNG/jOQI37G97/WDa+7WhaFqHyZrAR+1kc/8GU0QPokjdkj9zpzwRNqAobJDgqQ49HPpHs/wvyIEo2YC3GFT7ERpDWGmPT2YW0ZFsAK8kRm1cSKx2xpUxek8ys/j6EAop+F+2rJj+Da1aUqZhHTYv+SUA2mi8356dNXHU3naEyu4zIfV86PVjRPFm16O74fRxniWulCx3U0og/g4JWjY8/W2UuSk8dgia34o15pzp4LQFlIddzShHVr61YB0BnEQID4mYU35LUAr8wyTO+OzwLGsMugm3sCikl5jvUuCP3POlIwOqrK2BZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucaob8iyfQsXQ47Q/gPqTC/4zmuFz0C+EjEkhxArRGk=;
 b=qnuYKPoBTIMdgrMDAdY8QPuQzLzswsjS4sVEZNKNVkfnqPl/EUdmEDZO1dAYB1KObRuk3lO0kgL7z+qLpTx6Rx9b01ZBeaz3RheMx/6J9jt4t/fx2+KIrBHTBUEjMh/7DcvQyi7HayZHvMyjx5AxHrRPVEkB24oyLz590kxq7vfdg/dNXMkGdDIZuXLsyAlGkKYUnKBos3FCLZOyonF6/oNnK+3dOSMkNi5lXmo3HN+eKnsr1mNHlbZzboeS5PLJ9r1uMPn3kk3D9OzSeySz4zktkLuyO3O51W6NXTv2tulsi67t6PWkJIlZOCbbRhWywLXNScJz6dhvwHi29bwP2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Fri, 30 Aug
 2024 14:47:47 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 14:47:46 +0000
Message-ID: <9410cc52-129c-4bc3-a0f3-9472364f158c@intel.com>
Date: Fri, 30 Aug 2024 16:47:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/12] net: tunnel: add
 skb_vlan_inet_prepare_reason() helper
To: Menglong Dong <menglong8.dong@gmail.com>
CC: <idosch@nvidia.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <dsahern@kernel.org>,
	<dongml2@chinatelecom.cn>, <amcohen@nvidia.com>, <gnault@redhat.com>,
	<bpoirier@nvidia.com>, <b.galvani@gmail.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-5-dongml2@chinatelecom.cn>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240830020001.79377-5-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0042.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN0PR11MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9c5a58-98f2-4314-9584-08dcc902b652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0VvWnJMZ1NsamJ4K2RIM3RIUFpUaVBBQ1FOVE1xNGhSeFVLSGxOaXVZcWtG?=
 =?utf-8?B?TTdIL2xNaFZQeHFpWXE3RDBiVzZXRkd2dm1WYzJ0ZzVpOUVvTmNwZGNQS3p2?=
 =?utf-8?B?VUNsQXNYVERIOVN6ZUpvNUR0bUk0eXJXSWRLamZnOXoyYVFCOElqN3NRQWlW?=
 =?utf-8?B?Y0kvai9wSFBiUnZiZ1NLOXhLQUpXcDk2NU01NmNsVlJ4MEhiUUtOYlE0OTRl?=
 =?utf-8?B?ejlJNHlaVlU5TzQremlncUNwcmxsaTJ0c05lenVMVFozdWZNZHJ4SEVlbEgx?=
 =?utf-8?B?ZEYzODFjeHBFcXdSSnV1YzRBTFhUMFE3RWlZSWd5NlJ2T1JPYmp4WGt6UTJU?=
 =?utf-8?B?Wm1QclI3T2YxRGdyNmlEOGExU0dkYVBpNWFaMkt1Snl4RVRYbmlrR3BFalZ2?=
 =?utf-8?B?Q003aWJKMEpTaVlFU2ZjNktTU0JCSTVzU1p5TTV3UVJzVWNaTm1YQXd3K0VK?=
 =?utf-8?B?UmRDbWwzam1halNpQmx3bUpUSXZBMkZXRnBTb0RWN1BZcWFOS1JURGZMNHRo?=
 =?utf-8?B?andpbE5lejhwNlMrclo5V1I5a0J1QzdlMko4ZElmZXp0dnl3Mm4wVWhFS3F2?=
 =?utf-8?B?cjVBOFFKaVQ4V1RHazJYWm13cjh1cmtVcHl6c01BZWszNGVha092V3daWSs0?=
 =?utf-8?B?dGRldWJuUnFEWVVjeUkzUXVjdnh6VG04TUZpTlBoMy9sN2IwL00zU3g0U1lD?=
 =?utf-8?B?YjdHbmVCRjh1Szk2RFlocTROa1RIZzhNTW5idkxQTnhTMEVEUXFvQTBOTHVo?=
 =?utf-8?B?VHFDaXZhc1RPaGYxQzFHVTRMY3lzalR2RSs5QUFxRlV1Y3lrNVhySE1wU294?=
 =?utf-8?B?aWsrdUkwYmtrbG5aSkhYaHRXZUdZQVR6b3ZNS3FBNUtnOHMzS052czlOa20y?=
 =?utf-8?B?SWwxK1FJYndOZlM0Rzl3MFdJYThJa2c2ZXBiR2NhSnc0L1E1Tm84OUwvOVI5?=
 =?utf-8?B?VUdwTHQ4a1l1bGcyeE45a00wRytpWFdMa3pqV3BXRXk4Yzc5R1NmWmRFY0lx?=
 =?utf-8?B?WHNBb1FvNkpmVThlVEhIWUlTRXZ2S3lxc25IV0picjJqaFVaWVVqOUVuOGto?=
 =?utf-8?B?OEpSOUpFTGQyMTFWWWorM3NNWGszZ1cxWjFJNWlvVGxvOFJlRkdjM09UR0FC?=
 =?utf-8?B?RlBLMXBsczBMNjk5RHlEdTJjMnhrcDFNcWxoSFVlSVlFa2xzSzE3WUxhMFNp?=
 =?utf-8?B?THgxbG9rZWw1d3JDVk1XV2p1dTlGZS9tQmJKLy9wc0t5U1lLNnVOa2ZDbng3?=
 =?utf-8?B?ei9Oc20zYXFYNXR1MTZNYWJBY3VMNmtRWXRHVjJDcDRhTEtzTE5SbHNsNVgz?=
 =?utf-8?B?RjliYVVKcm9XaEU0clBldGZBNXBoU1J1bTJxRU11dUhkT1A4bHZzOGh4WHNY?=
 =?utf-8?B?K2VFbTFyRGVFSEtiYnU1KzZzMENWVzlqbWRpZlk3NXlGaGNlckN0ZU0rdWRT?=
 =?utf-8?B?bzBOQmhoaCtUNXI2QVNYalRrWkpsV1c1eEpqdWlabWVzaUhZelJjMU1TYmRz?=
 =?utf-8?B?MEQ5bHBIazREUXpJZjV2VTdNOTV5Zlp6ZzhPWEMvSTNubzZOYlFJN1hEM0ZQ?=
 =?utf-8?B?VjMvYThnRFlheXIwaEp2UGZmWE1ybWJYY3NFQ2pTZnVoQnpiV3pwTGx1bC9Y?=
 =?utf-8?B?ZzZFcmpsQ0NwNHZRL2p4NTFvVlI0RHlJTjVTbFE3d3lVT2RaWWQwdlFzYXRK?=
 =?utf-8?B?bUtkMUlnMllSTnZyUU9pMUduUmlvL0hNTFNiWU1UOWR0WjN0TXE3c0FmRUFa?=
 =?utf-8?B?ZldhaThKaWtOL00zcG1QQWdObFBjOUJuR1JMTnNnMUgwQk9sOVFkc2Z3M1g3?=
 =?utf-8?B?WE5VTGUvOVBIZWdmblBLQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGphV0oxdzJ3c3F3TTRLUVRxNXFYdzM1REppQlp1VkE5UWpkdDNUaEVrY2Jm?=
 =?utf-8?B?WlE3R2kvbUpINzhia2NpV1V2c3JhaExJT01QNTk5cmVTRGVZWVNnbDdaM2JN?=
 =?utf-8?B?ZkQ4czlBdHcrQVZJT0g2dHkzdUFCRmxoOE1WSm9KVXpSSUFMeCtDM01qRU40?=
 =?utf-8?B?MFRQMVdOUkRXeW1hN3VHVUZDdFBSNmVWTml3aDl4Y3FlME90bzNqZzQ2eGZo?=
 =?utf-8?B?Q2lWZVhjODJ6QU5JWlRodlpyZmwvbG5WL3htcjhGblluU2J4eUlCcFk2NkIz?=
 =?utf-8?B?bE9NN2RwREs3a2pFS2NoYTJRa0Nkd2ZwYisrUUlmTm9lRkVkQ1dsTmJpM1hm?=
 =?utf-8?B?c0lWN0JhUDdwN2w4Y1RmTkxiOWl2NDlhRTErbW11RFR3YnNIT0NDcHB1VEJJ?=
 =?utf-8?B?aTlVNkZwNFdRTkR1Zmk5UXRHV3RrS0xwQ0NDbGtrbVVwT2RBSHduc3RaRGQr?=
 =?utf-8?B?RHNsbnBXZTVNY1ZMVGxRL2M2R1NPRWQyMWJaY2NkUkFHNTZEaVhuZVRuZks3?=
 =?utf-8?B?aXh6L1pYN281ZXNybGh3NDR4QXhEbkhuOXJ6K1kycFdINTZhOElhdlUrNm9D?=
 =?utf-8?B?ei9GcmNhdHRibmF5WENOa0FaS251K1pHaWpCYVM2Ylk0T3ZSMy96UTRCQno5?=
 =?utf-8?B?ajYvUmRLRXJCK3EvVU9yS3NzN0RiSWJMZ2RYcTlJUEZxcm9udU41RklZVlF6?=
 =?utf-8?B?RmhMcnExblMra29jdE1pWnRWTW8zUEMwRDF6MWQ1eWhBeE5tZTR0OCtGcEp6?=
 =?utf-8?B?SmtBWGpscERtNFVCOUFiVFlEUHdlKy9ZUHZtN2xIMnNiWFpFNHUrY2wyVHE4?=
 =?utf-8?B?VFBNdmRpaHV0Nm1GRjFvYXpTRmc5enU2d1BMSEtTanFTcDV1UE1qL0taY3ZR?=
 =?utf-8?B?NDBHM3R5OFBtMVFKdGRrZHlZZnlZN2JtMWNTNEdtc041TVA0RGxlQTI2K1Q2?=
 =?utf-8?B?VEQ4a1ZXWTVwdVJtcnI1cW1vTnBtTGczZVk2eWNla2ZDKzR6N2hmL2tMUXVz?=
 =?utf-8?B?anZ3aStzYzVEREJ6L3ljTkl1N29OMlJodXcyN2VHWjRnV2ZET1VucUxSM2g1?=
 =?utf-8?B?TWZHUmVWUGg4M1FXaEY1VWZyVFptWHRWbHFQb2xYd1BtZGRyMjI1NnRFNVY2?=
 =?utf-8?B?d3lrNEVoYUFyYTFZd2JtcFVmaHNMejJFdTVoZkRkazJadWdQUzFxdzg3YW5z?=
 =?utf-8?B?akVCKzlZMXY0dVdsdmp0bnZYYmtZWGxhVzQrMFJuRjhoallIbmJPL2lrVm44?=
 =?utf-8?B?eWo4V3dxVHBCMDRHV1lDdGg2WGExQ3g3eTZPY0dmWHdQL1h5V3hWUUdHcmtk?=
 =?utf-8?B?SzduOFVFdSs5Mk5aRnpJWDFCRzRzaFR1WmFmcmw5LzJ1dEkzaWU0V282WU44?=
 =?utf-8?B?Q1Q4WWxhOW5LaDBHV0dTNGI5SitFSDNiYnFTOWxodmVnM2ZodVdiRENaZnNL?=
 =?utf-8?B?azNWL1pqNjlZTDRkanVjajQzMnNIU0dCRldHZ2NlTnNHaW81UDlHaUJCcHFB?=
 =?utf-8?B?dUZCbWZ5V2syb3E3UmRTaCtFSVZMei85K2pvTitJeWlFQXhkUEs2T0VER2Zx?=
 =?utf-8?B?VG1wVlFLeGxhQXE2YXE0LzBkSEN1TTdneWc0QmpUMGtOYWNpOXFQcDI4bEY1?=
 =?utf-8?B?akhBV2I1NnoxWFJkWXNnNlFnTVVhdE1tTnExTktsL3FjL3A2NGJPOEErU0FV?=
 =?utf-8?B?UTNlY3dhdUJPT3YzNFVZaHg5QTdNREhnYTU1NWk3Z3RnWkhQRUF3YmFOQ1Ev?=
 =?utf-8?B?U2JwcnlnQ3hDZVJJTml1bTJWcTJ4aU95TGRUdUxvTDQ2V29VWkc0QWora3BO?=
 =?utf-8?B?QUVleW1BS2lUWXJpWk0xRVdEQzdNV0EvVnpGNWE4VU5OUlVETGVNT21KWFdG?=
 =?utf-8?B?QmppaitoSzBtNGJRRGVheFhFMUtEMlJxY0oyeDk5SkhLRkowL2k1VHExdXZZ?=
 =?utf-8?B?emdxUmhLaU5uS3pSMWpCWndmYlJBSUhmY0NKMlU0TVd5YUdzTWpIc1NxZm41?=
 =?utf-8?B?QzFaN0FEUFdmbk1zL1JtL2xvYi8vRWxCcG0yNHB4WmIzRjI0WlU1RUsxSG9u?=
 =?utf-8?B?SzV2MUxSNFN1Syt5YW56eFpqL1k1bno0akduVjh6RHNkRDRHejgydlVHNEpT?=
 =?utf-8?B?T1BCQmYvVmNmVFVQbFZMYllENTA5WTJEKzZ5WEVlQVBFRk5tU2N5U3NVTm94?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9c5a58-98f2-4314-9584-08dcc902b652
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 14:47:46.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1C22CswRNrsifa17mPaxHmD+dAW8VqcbklGb8Nslo4wGCrzUSmKbOE9Ujf670zqRXZlMRCTNGk85g8y+YvH+b/eOoafK3adGLzn5yzILEa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6231
X-OriginatorOrg: intel.com

From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 30 Aug 2024 09:59:53 +0800

> Introduce the function skb_vlan_inet_prepare_reason() and make
> skb_vlan_inet_prepare an inline call to it. The drop reasons of it just
> come from pskb_may_pull_reason.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  include/net/ip_tunnels.h | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 7fc2f7bf837a..90f8d1510a76 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -465,13 +465,14 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
>  	return pskb_inet_may_pull_reason(skb) == SKB_NOT_DROPPED_YET;
>  }
>  
> -/* Variant of pskb_inet_may_pull().
> +/* Variant of pskb_inet_may_pull_reason().
>   */
> -static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
> -					 bool inner_proto_inherit)
> +static inline enum skb_drop_reason
> +skb_vlan_inet_prepare_reason(struct sk_buff *skb, bool inner_proto_inherit)
>  {
>  	int nhlen = 0, maclen = inner_proto_inherit ? 0 : ETH_HLEN;
>  	__be16 type = skb->protocol;
> +	enum skb_drop_reason reason;
>  
>  	/* Essentially this is skb_protocol(skb, true)
>  	 * And we get MAC len.
> @@ -492,11 +493,19 @@ static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
>  	/* For ETH_P_IPV6/ETH_P_IP we make sure to pull
>  	 * a base network header in skb->head.
>  	 */
> -	if (!pskb_may_pull(skb, maclen + nhlen))
> -		return false;
> +	reason = pskb_may_pull_reason(skb, maclen + nhlen);
> +	if (reason)
> +		return reason;
>  
>  	skb_set_network_header(skb, maclen);
> -	return true;
> +	return SKB_NOT_DROPPED_YET;

An empty newline before the return as we usually do?

> +}
> +
> +static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
> +					 bool inner_proto_inherit)
> +{
> +	return skb_vlan_inet_prepare_reason(skb, inner_proto_inherit) ==
> +		SKB_NOT_DROPPED_YET;

This line must be aligned to skb_vlan_blah, IOW you need 7 spaces, not 1
tab here.

>  }
>  
>  static inline int ip_encap_hlen(struct ip_tunnel_encap *e)

Thanks,
Olek

