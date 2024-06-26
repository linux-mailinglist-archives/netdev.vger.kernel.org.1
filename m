Return-Path: <netdev+bounces-106807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C346917B70
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B411C21D8C
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C7E167DB9;
	Wed, 26 Jun 2024 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aj5pB5gD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A916131C;
	Wed, 26 Jun 2024 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392081; cv=fail; b=OXiHU5swfT6YO+QjmWNeWpygXvlmdzbjw8nPcNCySU4nNLDeNrpUjJs2F/Bz0pKPSzRlqe1iB+tCq7TN0LoZpJWPi+gEViW8ztTfBupAK9VO35kPD/Mrk7Kt/DR7VgM1XUd18mQEroFfY1CnYmc3Jwa3B3rpSzaPaU/eunXgwOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392081; c=relaxed/simple;
	bh=A8CybGg1GoBoU2ayfNH200KiwEF1E8JOS0QlbsJnF8c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KiVB16Xr/NHhXyVchMuOkwv1DC9jVnd5UfKL8/fRd4xkCCjf8xHQbsZWq66IjGFkxv/KvQ14Gxmy/VcctKj8JJ8gYOWqPCkRA6UWq9g54+RNskUbqjvGBpkT+Y9IIuXHppNcPKvjMmapPJvJ+RM74kolQjN5vojoFEr+ss15n0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aj5pB5gD; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719392079; x=1750928079;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A8CybGg1GoBoU2ayfNH200KiwEF1E8JOS0QlbsJnF8c=;
  b=aj5pB5gD6107BD9VLir7aAP3O41knlzzy4j2pektHsGjuA0z9miUZRA+
   5Mf6gvG8J+oh1tbnnl+HWOGHfi+98OQK5cq8ymWRiE0jKU5US4bF4vwT2
   +bCys8LnSevmCpuammNxoBLnlxq5rYnSFnIZREDA5GIRLqzetaAPFD+6J
   /MIQa0zZmQfoQiqjAX0ruixnaKbRUe/MNfQl1uyz74/MakFrK6A/ebC/D
   giSmdEjAa8NQb+dvW/mOFXNwePmFIi+jKH2MRq5CXdxENghmwrBTKLGdw
   cS5pOKrL8m3lpYVAf+5yOeEQvlh4I3oeGhINmOpY8v4o0rdF3n+MO/0RX
   A==;
X-CSE-ConnectionGUID: 4+FqWF1tSbuMpg97wiV6Xg==
X-CSE-MsgGUID: w7E5TAXFR7Gz2YoPuLoLqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27138372"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="27138372"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 01:54:38 -0700
X-CSE-ConnectionGUID: 48mgBvr9QNOelDBxOKwCkA==
X-CSE-MsgGUID: DSrqmJVqR8WNNuusOI6kBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44024941"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 01:54:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 01:54:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 01:54:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 01:54:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 01:54:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDm+Sxz10WAhLrqGbXbuo6nnlXftF4SGJ/lTrfI8AkSpHbnpAXY9Auu5WGYM2+at5ipAd86G4rxN6m0+dbv4dg0jcy1bORjiEYIhIVbt3qzMTGGscLSvLa9nWqRDSQoi+AU6XW+pwoI8x8bJ3DuBy1e8SYkeQbxql8DzYi2M97PlZl4IbvaOMtAgbNXQcLQ17rfUrxXWJ0OckjODBbtS7j/CZOXZ93miD5tKg+ezd6A65p8mBnRtd28PW/hMN5DW0Jy277CtD1mIJ1QY/UR+83caRx/BHVoSFuCqmcC+0Gp/45c3IUnycNIE0mWElvFzXQ0SwdoRdFq7rPVuynuLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XYYu1W/OIyNZb6MlBTWFWItWpZjYP+7C72kkPyZYgc=;
 b=AB/j2tsKRpb9KMWY4auot4FiD7+liN3Ba6y0uv7FIz+qk98bBBTdVxw1Tf8pRhAi04XKnJ6ka/2MOOukBFq203wIIrM69f/4kFsNgMrUuknqx9uABRpYhmw4sECQclYNvWoyLn5+Gc7kfds+/vf7bYQTEbuG16VDeyVXGHxgr1Z+cfrG0bDJDZ0dvFWZaH8hJ6WcygYFsukColZ1tyWY9xMG0fBxz+5lP1xsYRR4C02EdJGwMXCUBcKbqMsx8wyZZIv5a5HLPYk1u7uoWsIoJACVokdp36W7hLn9tNzFivvUOKD6l5eGAnomdsRjqlGOV8EwXl9XVYwjn2Uug6lLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB7396.namprd11.prod.outlook.com (2603:10b6:930:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 08:54:29 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 08:54:29 +0000
Message-ID: <6613f5ae-7f2e-48ea-aa8a-f587ae6688ea@intel.com>
Date: Wed, 26 Jun 2024 10:52:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] netdev_features: convert NETIF_F_LLTX to
 dev->lltx
To: Eric Dumazet <edumazet@google.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
 <20240625114432.1398320-4-aleksander.lobakin@intel.com>
 <CANn89iK-=36NV2xmTqY3Zge1+oHnrOfTXGY0yrH=jiRWvKAzkg@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iK-=36NV2xmTqY3Zge1+oHnrOfTXGY0yrH=jiRWvKAzkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB6PR0301CA0068.eurprd03.prod.outlook.com
 (2603:10a6:6:30::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6a32dd-6cd1-4fed-700e-08dc95bd96ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzU2WTkvQ2NmZis2NkZCTXA0ODdhZU5rREIyd1Y1dldEOHk5b29xdXVwaHRZ?=
 =?utf-8?B?YWNYSlZjdWZ3WS9IbldWbUhBU2lUZG1Ya1V4RWdPMnEvcE1Gbk04U2ZkaG5o?=
 =?utf-8?B?NjNEZndpOExqU05wNXFhN2ZTZGR4SDRjZUpFNjZoWmg3SHV4K3Vmd29WVUY5?=
 =?utf-8?B?d2hzdHNiR0VCV3JiZzhyYTJyQnE1R2pkSGtPYWQrV2FiQkxzcTNVdEpka0Rs?=
 =?utf-8?B?K0FCRGdNL2t1VWcyMkRxaVVYK3poYWxKMXBnMExUMjhqK2hKZUpoUlRZSDl5?=
 =?utf-8?B?b0VKYm0vSmI1aDIzZGg4SXVJWjI1NlpTVWdieHpVWUFLdmJ4ZmV1NXAwRElD?=
 =?utf-8?B?SmFpcFI1VTNKY2JQZi9jdjlPcURaSmplWjdMY2JrbWR3bDFwZGVqUHRqWUlE?=
 =?utf-8?B?eFoxcS9YelYwK2hiZGR2NndpVTdvdTZMRERQZFU4QmVqSHBwdC9VQXEvZTY2?=
 =?utf-8?B?R3ordVY5cG1sZ2lsMVZnVjduSUd1Z200VUo2NTEwRmhSMzBkV0JoVmZHRGVT?=
 =?utf-8?B?aDJ3U2JWUlRnMlA2QlBDOXlUeUkrbDF6S28wOU1VeW02TnBvbEU3bm8wK2JF?=
 =?utf-8?B?UDV2Q1B4a2syYjhrb0pJa1BUWkRhSHhPdVA4d0MwNWIxOHlSd3BkdmdoUlZL?=
 =?utf-8?B?TVd5aFNueWJJZXZBNlE4VHZSTFNNK0thd29CcU9GZlJZVFpjMk1sbG8yb0pO?=
 =?utf-8?B?R0poL0tWWnBzYi9vVzZKdGw1V1FIanh2V1I2L2lQYzFsdlN0MEtFV1FtM0FR?=
 =?utf-8?B?R1JyQndqMnUrdXpLemkyV1VUT2lrREtDRS9LTjZmMEdmdTlXM2l3dld6WmxK?=
 =?utf-8?B?bEM1UjhvR2o4ejhxcGttaHMwbHBiaExhV1llN1FuektRa2ZYUFplYm5IVnVa?=
 =?utf-8?B?VDV6NHg3QUFCOGo1dUxaZTZNTmRSWGdPbUZHVnJKSk55ai9yajRTeDBZQ21X?=
 =?utf-8?B?RHVCb1BBK1YxYjN2ZFdsZnNvLzB3TlRVZGw3bkh5RHprUis5MWVOeHRDVTVx?=
 =?utf-8?B?Tk1pN2xmTVB2bk1TS1Z4SnFvbjFPN29sMFVqb3ZuRkhDODB2L1B4aGJrUGYv?=
 =?utf-8?B?R3VPOEp0QmpIMXlMaVVtUlNCQWtrcTFOdjRCby9yNVV1VnR2OTQ2aFVGRU1y?=
 =?utf-8?B?UjVWbXdBQk5VcnNzcUQ2UGg5dDNPUnQrNTM5V0thL0YzMHcrbDY3QURXUjRF?=
 =?utf-8?B?bFdIcUx2UUlaVFV1Qm1FNFl6OGwvbDNGaVU3RlFyUDhnTk1INEg2Y3NJeDht?=
 =?utf-8?B?VGQ4K2NoanJ5bWRFbUp0azlkTit5dG9jRGY5UWlnYmcreHhLYTdXNDgxMmFW?=
 =?utf-8?B?am1RK20veVQ4UlFkMjRrbWxrZ1NSZUk3YkJMRFptNG5teEthZU1WWVNLQmhI?=
 =?utf-8?B?Yk90QlhDcnN5akRJNjdCOHNPcVF3Z2Rqdy9xcS9GV3JHOStPVkZmTlNtQjFZ?=
 =?utf-8?B?L1hGUy9LbW4xZ0pockNRem9xdWE4ZXdEWGRRRTVmT3lvdE5kT2F5RWpxbTBl?=
 =?utf-8?B?UGlJNHVFUnpvTFlOS0sydTVJa3NLTmtaY0FvZFQyRlZEUTNmaFFPS2JvamZF?=
 =?utf-8?B?VjNFZElJMzZzY0tVeGxyMWpkWTRpNmtqdlVlNDByMlBSdE15aTNCNEhHeEpW?=
 =?utf-8?B?Y1RkbjE3U3BKSVNjVFp5RkJveVI2cldKQUxiQlBlRWdKNFZ4T3hvY2JyYmZr?=
 =?utf-8?B?LzQwak9ibmlKMDMvOEU1dUpqT3lJaTFMR3JGTnprU0V0OU1mZEJZVk13enZ5?=
 =?utf-8?B?MG5QTmpIWndhbUJkL3lBdzVza0c1aEdaWElrQXJ6UFZuN0xTd1NvRWVNMDNF?=
 =?utf-8?B?UFo3cUNQMFZka1AzdHNwQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnhQNlpCN3h3Q0U0WlQ5NmtJL0ZXMGY3UVVLTFdyaVp0ZThGay85bytEMXVQ?=
 =?utf-8?B?aGUzTER5Z2RrcXVISUJZd0lGRlBzeUttU0YvVU5scnJaSUNLVVBqb3hjL3kx?=
 =?utf-8?B?SVZUQ2RiWVRQRDBhblZKcjROSWI3N2dYTXl4dXFOWXpFTG5RV3N3MlFGc1Vx?=
 =?utf-8?B?UFlLTmJpNHZkOThiS2NCU0h5Ui9talJJSklpcXpVeG5wODZ0THV3aDFaMHhR?=
 =?utf-8?B?U3h4cURFMS9jTGxucklkV0x0blBaQnMxRE5YYTVuWjV5SFZYcWJ3R1AzUVdZ?=
 =?utf-8?B?czFEdHVoZ1NUdi9ZTnFmT3J1Tit5RERiL3JFcVFkU1EzZ2Z2dzRIaHlwVzFU?=
 =?utf-8?B?UVQyV2Y0TXpkMFpzcG9JOG5QNU1vaC9YZWc1ek9tTHhyU28wa3BFU1F1VGQ1?=
 =?utf-8?B?VFprM25aaW9kc2NQdWhxaGczbjQvT2UyTGFWUVBUMWswNE5yS2E5dTA1VENY?=
 =?utf-8?B?dWlZZ0VGMHdhQ09Fd3EzcWluQ3pyQUlYSFZUMXZBY21WaUxoQnJRMUFCelg0?=
 =?utf-8?B?RlBWKzdvczRMdTF1Q0tGb0ZmUEp2VGszb2J4M0lJaHB4YVMwZ0YxejdKckJL?=
 =?utf-8?B?NXVuZVpKZ3dXU2swK05UYzROcW9vUUY2bkY4YU9FNlJucndWR3RoTW1pbnNa?=
 =?utf-8?B?L0lMd3U2QkVZMUNEdWtPMFNMRkpPQlRUcDNvaE5EQlNtaGtWK011WWdRN1p5?=
 =?utf-8?B?U0hGRmFzRlJ4UFVxRzRaRDJaZGUyK2tXYllsMlFLL2JLVW9qYXh6R3JRWGtz?=
 =?utf-8?B?ZjlZdTk2ampUaFh3MlA3dG1aMnloZi80WEg2VzU4YXBSMHh2dG5YeGRONWJC?=
 =?utf-8?B?ajJFTmdYODluei92OCtWOXpGclI1NjR0eklpUnM5OFJzVXVmbzllTTJ3eHI4?=
 =?utf-8?B?a0RyWmozRVphcWh1Y2RHbks0dG16OFNsT2N1bGJzZk93OUhLa0tycG04WkRh?=
 =?utf-8?B?cHdOSDZmWXNmdzFqTC9BbEdyd2RiVFphWVd0NCs5NVZqMytQd0Nqc3JwQjZD?=
 =?utf-8?B?QXdTenQ0dzBGT1p1ZDd1eE1kU2MybDFHSVcydjI2b0pyY3dsREZaNmhwL3Q4?=
 =?utf-8?B?bndwdlA5bllIN2hFQmVBaEM2cVpCUThQL1Q0UW0wSlovVUVlSlM0N0RzL240?=
 =?utf-8?B?NjNGU3Z5SG9sM1BnVmxEQXRNS0VWeDhmYjdKeDY0NUJobHo4aUVCUHN3UFhl?=
 =?utf-8?B?bGU1ajJSOFFOQ1kxdjFqKzQvdzF1bjg0OERXWCtnMks3QVpMUmpGWGtYQTV3?=
 =?utf-8?B?ZDE1bElwN0hXS0FpVmlkeWVMQzJYVFdOaW1UTE1DRFdpRVF0dUkvWVhWZFB1?=
 =?utf-8?B?cytaZkZmQ2Jod1NrTmd5SzJ2TVpiQkRIVDhPcVpuWGFaaGdhVmJzL2NRUFYw?=
 =?utf-8?B?VVhCSEhuQ1VDYU5LWnFlcCtveU5SZlRoaldVWkM2QzZVWDVpSnhYT0thZlZE?=
 =?utf-8?B?cGllTStObWU1OVJuUlJOZHhua0UzbmJ0cjlqc2ZBT2MyOGhiVzVqNjgwaDl2?=
 =?utf-8?B?dVBldWx3OWt5S0ZEank1MXI1VXgxQkdWM3Y3VmdOUUwyM0Q1MGxlYlJhZ3pL?=
 =?utf-8?B?M2FzQVNLcHFxNjJyVkFBVmJtMDJKQ2JkaWkzdUhIZm4xZStKenVQRDNUV29V?=
 =?utf-8?B?UEtJejJnNUxGR2MySkx4cU8zUllQQ0NHd2p6R2VSdjVUc1ZJNk5YcWJZOVFw?=
 =?utf-8?B?NG02ME1VY3VqN3ZNckRDMkxrN2oveVN3SDIrdk1PcUFicnFUQlFaeDJ5VjRl?=
 =?utf-8?B?Uk85MWY1QkdsN1o0azRmTC9JUDhBalN1Wm1DMDFBZlJ2VTV4MEsvREJrQU4z?=
 =?utf-8?B?SFo4clpRUmhRaHFiSC9zak9rQU1JZ0gydE5Vb1B1YUtQZWhLZzFNbFptbnRH?=
 =?utf-8?B?dXpMaWV5SU1KblBJUHNNemhLL25Lcy90NU9QaHRHa0pzS28yNkRiS2tOS1Bv?=
 =?utf-8?B?K0FyL2MwWjlEc1doWUJiRElUcXh4YjczMi9UTTdSdWZwNDc3cGpRWWRoTzR2?=
 =?utf-8?B?S3UxV3NpR2lEa2laRW1IUEh2VE9jeWZKeEJoREFzZEhMT1BNYjhXWUQ4ejl3?=
 =?utf-8?B?RnpkSS83NWhTRXh3TzFQNGRmSkI5T2VlbjNpaVFsd3pDK0VlalMzNnVYMUND?=
 =?utf-8?B?WWVJdlAzKytua0pPQ2ZSa2srY3R1NFVacFJ3bE1DeTA4Q3ozZHByY2Uxclpa?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6a32dd-6cd1-4fed-700e-08dc95bd96ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 08:54:29.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r90RTORWXgpW6OCfuCm+ZNjTngaCMk1j2FRsLIZv+AJIESGxJupim2rZ4q9d8KCLpiE97VvRa4xHpQP0mtFR4jo5Cjc02oYAMZva5gatvX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7396
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Jun 2024 16:00:51 +0200

> On Tue, Jun 25, 2024 at 1:50 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> NETIF_F_LLTX can't be changed via Ethtool and is not a feature,
>> rather an attribute, very similar to IFF_NO_QUEUE (and hot).
>> Free one netdev_features_t bit and make it a private flag.
> 
>> Now the LLTX bit sits in the first ("Tx read-mostly") cacheline
>> next to netdev_ops, so that the start_xmit locking code will
>> potentially read 1 cacheline less, nice.
> 
> Are you sure ?
> 
> I certainly appreciate the data locality effort but
> dev->features is read anyway in TX fast path from netif_skb_features()

Ah, right. I though netif_skb_features() happens a bit later than locking.
Anyway, this patch is not about cachelines, but freeing 1
netdev_features_t bit. I can remove this paragraph if it may confuse people.

Thanks,
Olek

