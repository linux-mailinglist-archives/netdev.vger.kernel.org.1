Return-Path: <netdev+bounces-153047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D37299F6A61
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D621891689
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BF71DB363;
	Wed, 18 Dec 2024 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBG9cWeJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0778D1591EA;
	Wed, 18 Dec 2024 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536954; cv=fail; b=VgslPvszxQIapXB+kbUut1ito64gCmzMEmJXZJ7qklppUZWxiufs9mzUG+p/jbCkQCSIxSvJeU3kzXyUMGJvGfMUAtvPgV2Q1QFZBjfxWrTucWgb8Cw9sb68YtC2EQ0jJtNjZeF58U3bOLcIVXEdIRsMOtTaKiK4Osbd9tzqfNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536954; c=relaxed/simple;
	bh=FIVaFg3DRDE4xjDG9DfGNWB1J32KiNu0eraSgIx1AMU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UKu5MOakNEFqtET+fkmyAJ7VwYw35owWfmEz5anJobKOvRWRdAdyWkgoXS5iNM0Jh++13SPGyu6q36Lqzlr/FMj3SvIw49LvpIpgMDNSrU0NN41HDOAuRDTKPA18+YligAqgZkb3wrJWw19LH2/niBZJm+G+0ZRyZ+u4W3v9JfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBG9cWeJ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734536953; x=1766072953;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FIVaFg3DRDE4xjDG9DfGNWB1J32KiNu0eraSgIx1AMU=;
  b=MBG9cWeJUKAe10jOXS9XdYuTtymLug+e/C2FeePYqS8M9RUxE0lcXplc
   3bLdhMCBr78ePxpasDeJF7vit8LSi5jWhZd2kunrfrw/pWzDKyttFXMqM
   9wiI8fK2qurv2eIeft/ReF7NSk3cFxKL4AlyHFKo9ThosIFhrLVlIExXu
   jPmZL6QqyPABXp4qRM5piYvQ1ULZnIa0NyGZauQkUWlhd9NggOzg+/jeQ
   h6faAoPint6GmJIIUf9LawIk4+KQsLux4DdKg3KIGW+0BAhA90o6yUWjX
   2FbK0txUiQ3MPwsG926QcjuTC8IodoYspHwBr8cB0NMk07suHAiBfpXBq
   A==;
X-CSE-ConnectionGUID: kDbbHOj9ReiJt4zifPqwpw==
X-CSE-MsgGUID: g+3FnTvJSICSk8Vn/GGaKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34921179"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="34921179"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:49:12 -0800
X-CSE-ConnectionGUID: xB1JUMLqQIiujRiXtQvYwg==
X-CSE-MsgGUID: 771Uf97ZT5mlyacvfXj+Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="98133770"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 07:49:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 07:49:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 07:49:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 07:49:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppBuenmldFy/VqXlOHi8TAfWZ7OT1kaeYOqiXPsNawu87ebLNdHqOl6kUPcT2qjSqspB+fpx8wp5v7XpdRfQ7MdOubeHv39+GFI9iYRvKjNNTCX9Ifov8muDm9ZpEkVYN81LugxUz2NXXosHycQ7L04BmUazV6tGCMCFV9jM+iNKIaa2DFCiOebfEFUWUsXQDXrOyjZ/EsgF8x/aqe4I+3RvGyJS1zQh1aVCW/ft4qDYcNPYVuXmoF9aOHZROeiXJc7mt8P4+ZYQ8V01mzJs6IXmEVIR8Mnsww1VNZsrYvcJjS18FrjPK3FRWyWSsz4Ga7Qxp3DCBbPopNcKGwLV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/j7eDVCxfeB0+Re6tl58dgcugux7YoQB1CexfJDfm6Q=;
 b=G5cERtn4+pQnxl5waSVHM+rsBV6UkptEkWi5SQKydSbqn16yXWhSejQqdY9xdhhSEbzQvGT7NL4XjwxtuadxbjB7FRAlemWiYsmM6dTFiIrsz0hc0aK5kSLX+JdYet+rxEbfBo+pecJSro4J+EoStwrX96q/FxexwaC5WWURoFuZa7bkNUUQ3g3P8+9tp2Ezl0ksDqxiA6TYF2/eTNBI1AIoVmPS6oje/8CUxCjtCkCVkl5XYlpzlyMhJjeApL5389LeWDy0P9xElX3WBSbFhjpomHvxWgqKfGFi/a6qn6fVAAvY1TYkhsnqGEWyFo8JqAH5Dme+CkDAjGnDkQi2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:49:09 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 15:49:09 +0000
Message-ID: <b2ae6b80-83e3-4b22-8301-c91569c89494@intel.com>
Date: Wed, 18 Dec 2024 16:48:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: stmmac: Drop useless code related to
 ethtool rx-copybreak
To: Furong Xu <0x1207@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Simon Horman" <horms@kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
	<xfr@outlook.com>
References: <20241218083407.390509-1-0x1207@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241218083407.390509-1-0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0057.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW5PR11MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: a39f5dd6-b64b-4722-fd2d-08dd1f7b82bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmxRNVFtVzd3T1hhZUkxazBRZnlsVzdsRFFkWkppWXFVVEkwamRiY0tYeGhi?=
 =?utf-8?B?NjJ6UnNDSUlxeXBxejFJMGdnRHlOWDhDODFkeXoydzBnUWpWZVl3L1dnYWtD?=
 =?utf-8?B?RmJ5NkdNL05YRy9iTk1YTlhkZDlTWU1mTzhrZTN1alFQQnBhdFo0c1JQQkQ2?=
 =?utf-8?B?MGhHSFBnT3ZuSmtsYjU3TlNPWEJ1Q1F3ZVFWQUFZMDdmeS9scHpvMWwrdFZ3?=
 =?utf-8?B?OGxxZjVZcXBKVmN1ZHpXc1QxUWdZZmFvWFRyZWVwZWhGM0VZckE2bWlsYnpi?=
 =?utf-8?B?VkEwbjQ1L29qcSs4SW5LdzRKRTU5V1JwaUNLRjRBelMrbHFpN3hobURPWnJF?=
 =?utf-8?B?WkY2S2Z4NUZZM3lkQ21kQThRSnU2alFhbjdTVXlWZ0llWkR4bkNTcDN6RWNX?=
 =?utf-8?B?dVp6VFA5VjFMLzhGSWVnUFY0ZUIycWR3V1dHRFNHaUZzMkEraktxRnFvb0p6?=
 =?utf-8?B?N1pDV3czSE5ZQk5tbXBORFFKSmdpelBXOGZMbjBvUUhJTFlPZ21oRmU4U0VG?=
 =?utf-8?B?L0hGTFloemp2bXRZWkFqOURRRzdsbUdObnpLaEtNTC9Ta1VnWkluQlpkQ2dJ?=
 =?utf-8?B?Mi9aY2h5ZjhjSkdjeTEwamlsTjdQQUxjeG4yMHE5MVpCdXk5U2tmVXN5S0JF?=
 =?utf-8?B?U0JRVDQyUnZ2L0ppeUNXclliMldHSml6bENFWGZWMVYvTFdrV2VzYUs3Rlcr?=
 =?utf-8?B?dWI2WFZWa08zTU03cThyVFlrb2c0OTNoZmhvbTNjNDdXcmJoRVJTRk9KNVJa?=
 =?utf-8?B?M1I3YWVnTTV0OG04dkZyU2hhY3psU3czZzFTNHAzQTVFK05iZUhnc3owN3ZF?=
 =?utf-8?B?ZXk1NXBWdGVqb2ZkL25JRlFad3ljL1hyVmtjakR0dVZUNlJNTE14dmRlS3VW?=
 =?utf-8?B?N0tzTlZwV1FjRHAydUpsaVlFQSt2UWhpK2RqWmN2dTJGdDBJTVZsUXVBN3RU?=
 =?utf-8?B?SjY5MGZjNzRYYzM2Ui9OdzBwU0F5ZjJoV0RYSWpkWTAwSWMzaVZSUE1Gb2pw?=
 =?utf-8?B?S2JUaUJVUWhsN2psUmRuTE9IQTNpWjBFSlIxemRuMU1vZFArcFBPSkFlTkV4?=
 =?utf-8?B?K1pQYklPcC9mNnhNNVZJZnpveW04VE85ZUNYL08rcnpyaFJjc3RFaENtcHVS?=
 =?utf-8?B?N2ZiZlF0eUkrRkU0eE9jVmI4dUZpUDJrRm5xNDkvR2Q2N1B1SWNCRVYyR0Fh?=
 =?utf-8?B?djBCcTZRVEgrOTNmYlBvYmhpLytua1E4NmdJRDNKNnZ2ZGd5R3pzSDVUMFp0?=
 =?utf-8?B?OHlybHFDVHpCQXBQSTJBR3VvNWFKR3I4WnJ1bktYTER3eEYyZm1JUXczR2NY?=
 =?utf-8?B?UGJ5RmVCQWRON1lYNGttem9QTXlPYjRxSlp4VGVJMllQVHQwZmltS0dVSHBQ?=
 =?utf-8?B?aEtpUDQ0NkJ0dFl4RVF3eUJqNHF2aGtYSHk3VFhkK0cwb0ZZM1Q4ZUlveDdi?=
 =?utf-8?B?VDd2Ky9tdHYxVk16Y1Q1NW9TbXFZQ1NDQ2g4cDdPU0tDVjdQNGRwbXVndjRz?=
 =?utf-8?B?aStjUTNndDk0ekdRQ0RBaDVqd3BoUUxwMENOVFdOUXhwZTJZbmdGMVVSamZP?=
 =?utf-8?B?YXdINEFlUzdWYnJhQ3BjNGxJanM2d0ZWenh1RHpUVTBsbjIyUXJJcis0c3dG?=
 =?utf-8?B?cmVYMXcvandHR3dORGVOb2NxU0h5T1lBb080d1lZZ1p5UVFDTHp6ZHIxSTYz?=
 =?utf-8?B?OG02cmhVTnl6SWFtKzRtcXRMOHVGWFE3akp1aFUwK1Baejh5MWJNejAvT3dV?=
 =?utf-8?B?Z0ZERFVxV2c2TlI3ZWp5aXhnRVlwUm5ySHBUckxtMDFaYlVkcFRHQU10Zk1J?=
 =?utf-8?B?dUJUYnRRRUNCcVdQcGpDNEpqSFgrWnIzV3RSYnRqMkgwVG1pdUNITjVuMGIy?=
 =?utf-8?Q?OaZUxOnXvqDGq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cCtxcWFTVkJEOGI0cHVWRlRtUWRpNUNHUGxNMm8vRHpwNjA3OVJ3MFU3VTFa?=
 =?utf-8?B?anJvdlcyTmJjUm9pUDNXbFRaVWFBUzZGTGcwUFNteGIzYklzK01xcnNWWnlM?=
 =?utf-8?B?MUZYYjZYSEVLbk1vbTR3dmsrY25XWVJ0dTFEeDFxNk1WVVhvcElBdVZFZENn?=
 =?utf-8?B?djc1QkYxdVVtZW1DSXJhT3MrYnkyTDdMS1JqNmdaNERuVnNoRC9jTFdSME91?=
 =?utf-8?B?UmdNTm1BQlcxNGdPU2F4b2FWZnBZK3gzMWtJVnVtL1lJVXlqUDVSeTVZWmhI?=
 =?utf-8?B?WU5BTjNTYmFtRWRJMkx6UVdTcEZIMlZhNlRSWUJzNlJVd3NyN0Fack92OW5r?=
 =?utf-8?B?aERSZGRtN1dRRmdKZjRPT1QyakVrQlNudEM5emROVVpnTXNGV3FLL2RIWUVY?=
 =?utf-8?B?VDhlZTZ6dmxBTUdQQW5rVm84UjV1eWlXWDdsZmZ2Y0hDL3BKbDAwLzRGVzJC?=
 =?utf-8?B?Q0pBZk9OaDR1T21paHVkclV1cFdJZ2NHWjByMkZQM2JFNWRBNHlsaEFmaG5Z?=
 =?utf-8?B?SVAxemp5a0hHY0JTZU5oWEFrN21LOU9uNXF2RmZINDVWaStLOTVZSVNPZkht?=
 =?utf-8?B?bllLdlEwdENaOUx0MEtla3U4VkNyZEFNYi8vbnNOb3FLY014bFlabWs2MW15?=
 =?utf-8?B?MzZ2MzJtRTRibkY4RjBMZGwzUExlalIxOUYyYWVueHVTR2VXcXZFaGJFbHdr?=
 =?utf-8?B?TmVPMDkzSVMvNHVGaXJKNDFFK3JyMThlK2R6WjNvSThMWm9TZnlLbzNwc1lN?=
 =?utf-8?B?MXp3ay9XMVRvUUtqc2VaM1oyczBMczJiS3VYeDdxZmhpSW1yNVNUcmdoVkNS?=
 =?utf-8?B?aFhOT0xhTmpQSWpJM0NPbS9IdUhBclNnM1dnN0lnM2cyTWM1T3pPS2JEbjFD?=
 =?utf-8?B?bjd0QTR6NVVuak1KWjFNZzgrd1NJSis5a3o4a0hFeitQd0NxNUhVZEg3d1d6?=
 =?utf-8?B?QlVqWUJ1emt6U0dUMjU4bHp2RUgzQVVnUmhCb1o0cHRkZFFwSkp1eWI5TVZa?=
 =?utf-8?B?Vm1oemNocFRNazJLNGs4Nk1RcThycU9sQnRyUm40eVp6SzcyMXpFZTBhYXE0?=
 =?utf-8?B?RGl1RERvRlRFL3JsaTZxOFc5bnlEYndYUklDdm1OV3lUdkt4b0ZmbkxFSU96?=
 =?utf-8?B?MWhUSTdVbUVZY1dFYjlIYlNtRnl0TzFxVUk1YS8yQTJNdExoRHRpcyt0b0pK?=
 =?utf-8?B?MlVwdWZJdkFscERGd1pqUXF0Y3QxYk0zdWJ6YTQvUXEvVDFuRjBDQUR2bXVk?=
 =?utf-8?B?UHpaNktqYzJCamxtUnBEcDRlaE5HUzZuKzN3aGVNTWdZcTd5M0NFMlAzMG1K?=
 =?utf-8?B?MVZyZjhCaVdBSjcraVZTdmhKa2gvaE5vOExQck5NUCtSQ0FkejV2QUp6dXhT?=
 =?utf-8?B?d0lvYjhGRXU5THFDTllZc1c4cXpmWmdjWDlXSElnZ3h0Nys4VmVtNHRjTkZa?=
 =?utf-8?B?L2dxTzU1V1VVdHRoT29DVHhJNDRFTmRmNFJ5NUd4djhFSmZTc3RsNHpzUWpH?=
 =?utf-8?B?OHZodW9Lc3VIUkFGWGVmM1FLcHV5U205OVBVZzlvaGdxZUNTL1J0RkJBZ3pk?=
 =?utf-8?B?ZHE3OEhtZmMvRnBLVkplc0dOUHVzdnF1Q3VrNTN4UkF2dElzOHJ5UnF4Tzln?=
 =?utf-8?B?U1hCeFZPS2JkL1BKaTBUbWgrWUhrWWhLRVgzN1djZ2xUanRBMm5pMlR3MkRX?=
 =?utf-8?B?NFU0eU01djdmNzIzTnZXWHZJMUNBeHhSUG5tcWgvSlk5Rmd6MHN0WFlTOENk?=
 =?utf-8?B?bWVpeFFGS0VIZzBNRjhFK0V3bjVLZkZXVUY4UE1PaTgwc05GaW9Od0FmWk4r?=
 =?utf-8?B?bTN2cTZFUStvdVhLTWlmdW9Nek1lWHhmK21BeUQzOUhuQllXT1ZQYm9DMXJB?=
 =?utf-8?B?UUlMUU1ndUJITUNKejZVcUFMaGtpMzdjZEJiVEFkQThaZHdWTTd2NkR3ZERy?=
 =?utf-8?B?UUNVY3E5NnFUcmtBcitGbHZEczBxYU9JQTgvNm1MMDVYWkVxMml3RzJTMEFk?=
 =?utf-8?B?VlNNa3ZRUm8vZ0tuT0NuelRpSnZRU2l0TEM3THFDM1hIUU44UXVuSjVmemlI?=
 =?utf-8?B?SkNpVk53d29Kb3dSdW1rU1E2cHk2TEdQZ3JqLzhBOXJhR2NIN1huQmZnYTAw?=
 =?utf-8?B?RjZCUGpZVVBVVnJMSUJxbXNnTFZUQlhndG41RzFTbGtmRVc0Q0dBUUxieWg5?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a39f5dd6-b64b-4722-fd2d-08dd1f7b82bf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:49:09.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBZVOV4Nq52D6YFUP1qo4X8n2JDhHNVF0K2pbTzfvkk8pyfi4hBg5ieD6LF8XWnWcU6VGyxR2awy+Uj4zO8Ie4O7l9nNREaakB8x/hErNX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-OriginatorOrg: intel.com

From: Furong Xu <0x1207@gmail.com>
Date: Wed, 18 Dec 2024 16:34:07 +0800

> After commit 2af6106ae949 ("net: stmmac: Introducing support for Page
> Pool"), the driver always copies frames to get a better performance,
> zero-copy for RX frames is no more, then these code turned to be
> useless and users of ethtool may get confused about the unhandled
> rx-copybreak parameter.
> 
> This patch mostly reverts
> commit 22ad38381547 ("stmmac: do not perform zero-copy for rx frames")
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

The patch itself is fine, *but*

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 -
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 39 -------------------
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  5 ---
>  3 files changed, 46 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 1d86439b8a14..b8d631e559c0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -126,7 +126,6 @@ struct stmmac_rx_queue {
>  	unsigned int cur_rx;
>  	unsigned int dirty_rx;
>  	unsigned int buf_alloc_num;
> -	u32 rx_zeroc_thresh;
>  	dma_addr_t dma_rx_phy;

If sizeof(dma_addr_t) == 8, you're clearly introducing a 4-byte hole
here. Perhaps you could reshuffle the struct a bit to avoid this.

It's always good to inspect the .kos with pahole after modifying
structures to make sure there are no regressions.

>  	u32 rx_tail_addr;
>  	unsigned int state_saved;

Thanks,
Olek

