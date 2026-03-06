Return-Path: <netdev+bounces-264832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEmNFTLsqmmOYAEAu9opvQ
	(envelope-from <netdev+bounces-264832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:01:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA09223485
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 902E73135351
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8233A784F;
	Fri,  6 Mar 2026 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGNrVGhO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418D32E1F02;
	Fri,  6 Mar 2026 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808734; cv=fail; b=IOIXUri7x70eFER1hxoy3+5HkdzQ/2zA7XZQTwplV3ck6iexznaFcXd9xgq2OHIGfyvTFaQNcQ5qHP0Wu0+F2mD82CyxXMmCFDHDudidL16bLv/uIn2Zs3kGIPa8aGqz2MJxcdML8glQ3Ld+flEJA/dykCBv+I0BA9kKc2SPnEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808734; c=relaxed/simple;
	bh=CD4dY9dRCDYB9CFE+upjF4AA008rulJ1dobgtGPbAmI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dU1LVCqQt2iOunz4BH6SWz/Ugo9cUJSKi1sILQ1rW2pdNQt31Lnra3cc7ZjSiER2Laj+v1ggrqVWpgtL5d3d7NFzVnt92ROSdZTRn7aSOZ6wBVOUcXKfRIDNeshjZEA/+rWXlZVc5M8VsHVqXa3stzkY8bHCcOUNwL0pr/U1hso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGNrVGhO; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772808733; x=1804344733;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CD4dY9dRCDYB9CFE+upjF4AA008rulJ1dobgtGPbAmI=;
  b=lGNrVGhOlDgoebNQpcaL663QVcmGdGSbT8Dn/kT1cL/n6TaibLXbEqHr
   vfYX5rWC9F/6m1so+Shm4DY3cOGVlxALpKVifx7lZUZvj6Y8Y4x6cb2V9
   Uuw43pEiEl3h7DXFPX6lFWoIjlQ1lieJ6qQ4wXuvsyv1wwd8eW92v6zy6
   Jnz4YjjZk4fcUKzfWhiPnRMquJ9r1NZmkf4KChCxkiutZ1LYmfsac8tGk
   /Y3IZhA3CLMVofiox7DVTDkNwGlvzGlSZWUKtwM9ISRld4kKq6w/6wdhL
   YzH05pA63qc2ea+AeV+3bS7pzanB+16Z8vV5iKwgiX23U1zzANIxbXC++
   g==;
X-CSE-ConnectionGUID: fTF5rnLISFOUa+u+s76Bow==
X-CSE-MsgGUID: AsQnBfTcQYKjyS5owRlppg==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="84628898"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="84628898"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:52:11 -0800
X-CSE-ConnectionGUID: Pw7HsdlCR4yDnPmLIDWSKg==
X-CSE-MsgGUID: pjVPJkzVSTeuaoz7FAywzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="217218491"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:52:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 06:52:09 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 6 Mar 2026 06:52:09 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 6 Mar 2026 06:52:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euEK/iiBK1ciW7JAb7Rs7aB5pG+ytujnmlxTGwh9nXGiKAbTKoCRGYWngIkwsThqMJffswl4s4d2FfqIBcScPkCxY9XU3RHj6gNCaSCU34PdSOPqPSLlXizgEMVCsxZqtgarVjZLNXBTO+3a/rfNrw2PCaMbUvaPqo7vnP7Jsuetlwy8Hq+dwU0Xho8UMK5pfhWNxbu0UQl9uc6bXXGLRQWKMfXvJYIRSv5xqNeI+hiEhrmOimNfnwqJkRWa3Wm+3Q15gXzw/D8dx7bEjAYRR7qvxJ/KeAM0Da/4eDZ/hOAgsQdxU78/3baPPxgtOVAtg+OOJkFrQK925SuS9Acw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74cv3X0/TmDQht3y7+vWpDhB1RH5etQUqvUAHkfHg14=;
 b=cK9JYhaB2/vF0lRF9TZWRSHkEIEpUVF8vrX4FIZXIV0uHkT62N0Ck3mqNCKJogU60XxMkAFqp07+PnJ5VgGOLp+jDBZYiJ6dYKWD717cA8G9/XoLVD/wSY4P1S6LK/WGiJL6/JBwVjST8B1Tr86+Fvz4rn+ctvhMrMKzsL3A6/Jb7vUuYS5BuFBBMHI12Vt1ErudWzhQmeFLPziNud20pQOnN4VEa1r+/7prKi/CpK2xbcE2zw/y7m41kqHp178MTDaWy8F055NOcP8mrOUOg6VjZ/8UaXnMmzMwUVS8tF2KKY7Y/Wz/TMIbPn32EQ6SW0nZ0P0XUZVA10ZUum5hOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5136.namprd11.prod.outlook.com (2603:10b6:a03:2d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 14:52:02 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 14:52:02 +0000
Message-ID: <7c8ed118-d3c3-4bdc-913a-14f5537c44d3@intel.com>
Date: Fri, 6 Mar 2026 15:50:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 1/1] idpf: Fix header clobber in IDPF with SWIOTLB
 enabled
To: Steve Rutherford <srutherford@google.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Decotigny <decot@google.com>, "Anjali
 Singhai" <anjali.singhai@intel.com>, Sridhar Samudrala
	<sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, Li Li
	<boolli@google.com>, <emil.s.tantilov@intel.com>
References: <20260227203457.558196-1-srutherford@google.com>
 <20260227203457.558196-2-srutherford@google.com>
 <6a7fbafa-cdcd-4bfa-ac00-204e68602f61@intel.com>
 <CABayD+eF30_OHRrGYiG-7qKbJjvs5=7U8H7SH9Hj=ou6aZJBbw@mail.gmail.com>
 <8b43d234-867a-481f-90e6-e155132100a5@intel.com>
 <CABayD+crjO3S2cC3=9HqSH+kngE1=yKp_MnKZmAdW-YwJH1idA@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CABayD+crjO3S2cC3=9HqSH+kngE1=yKp_MnKZmAdW-YwJH1idA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB7PR05CA0004.eurprd05.prod.outlook.com
 (2603:10a6:10:36::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 40704ee1-3ed5-4c8f-121f-08de7b8fed1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: B1LG0egOhANDLcH75dLdnVj4gLEy8APnwkZ0Y5rRTazUGr8p4hmryuHgh9+CoZXF8YQxAe3flizov/bpy0uwQhDm4vPcndShKtNEUcgwvCHb+2EupR1Oj3KJuM9ZstR2hxZd8+h56WFlDVTrVFxxz4ExCs8bdRCZZV6NYU4X4O1tPt3HbLWSPinyyqq68gsud1IP1XKW4cFaVKNxdRyjbzNisC1UwGji9BuA+9ysUbBzHB1z6NA2SPG1hB6vHYMUH3uuX7J3D4erlADRZ2FLZuSElOCAA/nAKt0t+nLJBn7hsPLh0wsxHIM/wdhaZCMRH5ruSoTYa8876Pl62VC3a20A7TLtmSPMpVoXWpClvs30lOcQu2M6m7ecos30xv7fhIGQGpgObn0vX417spoTGqrcCF4vgwwd2T5Q3K4ZX5KXqHTAgmBd/z1tOyz9gYF1VzGs0yg1tw8mT7BX01Y6uDju2aLGl/2B1lbIcUVW/GGUURq2ACYhMOzPgr8LnqcQIzbRldD//Cajh0yd++yAGOSdK+z7J0PDllODvR5qleRnddx0kGHB17OFJDtpZRbuJ8tK+LBwleb/aUlQnzvPwpgUR15TXd8T7Jowk15i8btjLEmwXcPPNwYgqp3xhaOExI4rto2b5Uf6g7HtmO6uUc4A0GwTu/gUc+cDd1OnhEYwmSSONoKzsxR3mqmYMENgzvV1ErpwZ7dbIyLxWwXUPlKwusil/5+DkRx4r2PHUpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEFyWHVUWXR4UFdwR2JIUjc5L1pBR3VJbEI0UitaVzdVL1NJUG9yRkoxR0Zi?=
 =?utf-8?B?OHh5YU1kbWt0UnE4b2FrZ3lVZEVjZzJKdC96VmpMYWFaUEl4cGdUUmt5dFZi?=
 =?utf-8?B?M1NSdEZpS3Jwc2lhRHdHMnh1OEl6aWJ1Mk9rZVM4RXpiRVJEWVRPZkJ4c25O?=
 =?utf-8?B?b0VOWDhnL2JVRjN4WWFPSklRc1V4dkh2KzFzSWtYbmZTZ0xpa0FOOVA3b1Zu?=
 =?utf-8?B?ZWZpZ3lmbWJjbjZmL1hEalpTOTNsSm5LOWNTdnRnek5RZU5GTkEvN1BXOUpj?=
 =?utf-8?B?eFZ5QWpjK29tWVpBM0V3ZTA4UnJhV09yVEc5TkR2MjBnZG1MTFpHU0FlVVk3?=
 =?utf-8?B?bG5UdXlaVy9kR1R0TVVlOEVHLzFObHVoSE13SzZqRnJ2V3FickpFc09JY25u?=
 =?utf-8?B?OTUvMHA2a2xwSk5UcVJ3Q2MxRDhqZlZINGtjVzJDU2VGZWpNS0lHK2JsRkY3?=
 =?utf-8?B?b0FZUGlQZnlUaWRNK2gyQTMyZ0draDBtbFo4cDRrWjNsNXF0dTlJcTFueVhE?=
 =?utf-8?B?Qi9WZWE1YVc2UktEeUJtUy9UQTdKTkZmcTN3U00vVlJweXByV1YwNnY0UzFa?=
 =?utf-8?B?RWFXVHJlZUFGa1k4TXZmbnUyUlcwa0JXT3lONmJWUjVTaDVqbEFtWlJ1UktQ?=
 =?utf-8?B?NmRXWG9vM0NVWEhXWG5WN2hGRDhSZGYwb3Q1QURhNnhrYW1mYXhWQjlWMmo2?=
 =?utf-8?B?UkdJKzlGazdCazhCU2RnR3cyd2IvTTlMNUpFVUVHNjVNN0hTTmtPT0lQNDh6?=
 =?utf-8?B?TVRqS1VmK25BNlNKakkvMjhiZzRJaWtJNHZ0aXlRak9zcm5tbzRjQmhNbmxJ?=
 =?utf-8?B?QldMWkJ2UUJNbjFldzdYQTNtRUlMVmdWMnh0c2MvNFFWY2lDcEhFcUNNYUlI?=
 =?utf-8?B?NzVreGYzRlZkenhsZWxyVElBdnN2R1JqZGJDbkhrWjVjSm8zRlcwTjdJc0lD?=
 =?utf-8?B?cThlZkUzV3F2MTRCakJFQ1QyMGdFajFrMktnYWJ0MU5QZk9tY05waUdPM0dj?=
 =?utf-8?B?VDhHTVZTMzUxcG9QRXI1Z2ErbitrUC9mK0cwcHVQaTlQMHZMSStpWkZLVFJN?=
 =?utf-8?B?QWxOelU5SGFnUk5GTGRham5qQzBhekRUS051S1l1WTNtMGZGWDdobktuZVNG?=
 =?utf-8?B?VXVJMWNyMFpmTVpiNTRHZWo2MVRETjQ2WEF0Ujd3VjlqUkdBTDRhU202MjRw?=
 =?utf-8?B?WEtCcFBESVFnMTdCbkFKdVhXZ1JGc1dtSExCbHRjY2FEM2J0eTRZajNJc2JK?=
 =?utf-8?B?bDlndG0wdVZ5b0FaVnpvTlVRbVQ1SlQwWlllbStMMEZFalNLdFRRVlFxUlpz?=
 =?utf-8?B?KzdGcnU4Tjd3VGgvZVgzRE5kYnlqMjRlblBxcDUvQndGRkJaNHlBMUpoZUZM?=
 =?utf-8?B?ZmhWRXlzTXZ0ZndSMjErdnoyVGJ6b0JuRnFGNWJBWks5Nlo2NjA5am1DdkJU?=
 =?utf-8?B?QzFKaERZMUpiZW8xUDhMTlpIMGFTTE5KZEtvYXdjOG1UK1lnV0E5TjByeFZz?=
 =?utf-8?B?SXBSbnEzeElCVVNwYkxKOTVhNG9lV1RNaVpBMEszVlE2dGk1VFd6a2dvVDJq?=
 =?utf-8?B?M3oybFg3YU1nS2JqcVdRVzhTNlV3L0NrTWpHRTh2SUdmZWNOMUJQZ2lPQ2Zi?=
 =?utf-8?B?cG5LZFZNOTNVZUkrczBJTXI0V2tpaUlzV0xhMU1LcWpKUlJFdGt4L1IvaURV?=
 =?utf-8?B?UndSYXdmalplWGN3QXhzT2RkOTBFSzBMWlZlcjVCWmhZUXdhUTZZUzZhTWZG?=
 =?utf-8?B?VFpBL2NuSDNCVG9wS3JYejBVTkRtZlhjd21zNm5DQTB0TDM4VUxCeDcvWFNp?=
 =?utf-8?B?NTBDaVpoVlJBSzM2K0U1QnI5aEtLa3RodStIS0lvUnNVa2dOekt3S1BsYVMy?=
 =?utf-8?B?cGZmVzNkVzdFb2RHNG9YbFpIU2tpcE9OL2tmM1RaNVhaQ0hDUHE5SmNwU0N2?=
 =?utf-8?B?TFZBOXVrMTd5TnlDY2pHeVdYTnE5NFk5SnBhWlZ2RXAxdDdSOUEzVnFyaUxu?=
 =?utf-8?B?KzNkUGhjb2RnOTEvMFBhSnphd1lWeHhraVlNTGk0LzFOSENubUtwdUdRMDVo?=
 =?utf-8?B?WDVxK2dyNHJZNGMvVS9nMnBGWWU0TE41MDB5UzJObHQxWm5VSC9vVk82eHFW?=
 =?utf-8?B?MGJjMDBLUGI5SS9aL1J3azlvT0V4U1ZFMjFkUjNNVW91b1oyUkVlQ3UxdGVT?=
 =?utf-8?B?aVZhWTJEbFNNUnY5YkZFaStyY0syeS9xOFd0VHN3Y3RvRGdiWjhQWXF5TEJr?=
 =?utf-8?B?NzU5cFdBME5FcnkwdXRDR1ljeEVXdVE5RVB4elhnalgzTlJJODV2OWdiOS9G?=
 =?utf-8?B?N2pIaVNGRTROSGVMOVIrSmJsbDJodVU3NFNmN3dPVG0xWk9hWTJrNmRRMUl6?=
 =?utf-8?Q?lkBIpBZM8w3w9SAI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40704ee1-3ed5-4c8f-121f-08de7b8fed1a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 14:52:02.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7lzelpKNuNhQTkog9bPFk6KRiP16cfd+wJoN4GmbIaT2eW+/YGXr3Lxp+f9Stz4J82+c8UIzSnmzrZ18wf9YydlXKt0YICnbW8XsPZPQvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5136
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: ACA09223485
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264832-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

From: Steve Rutherford <srutherford@google.com>
Date: Wed, 4 Mar 2026 14:01:46 -0800

> I believe syncing twice isn't inherently wrong - it's more that you
> can't synthesize the header via the workaround and then sync, since it
> will pull the uninitialized header buffer from the SWIOTLB. Outside of
> SWIOTLB, dma syncs are more or less no-ops, while (with SWIOTLB) they
> are copies from/to the bounce buffers.

Ah I see.

What if I add sync_for_device after copying the header? This should
synchronize the bounce buffer with the copied data I guess? A bit of
overhead, but this W/A triggers mostly on stuff like ARP/ICMP, "hotpath"
L4 protos are fortunately not affected.

> 
> On Wed, Mar 4, 2026 at 7:13 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Steve Rutherford <srutherford@google.com>
>> Date: Tue, 3 Mar 2026 11:44:19 -0800
>>
>>> On Tue, Mar 3, 2026 at 7:34 AM Alexander Lobakin
>>> <aleksander.lobakin@intel.com> wrote:
>>>>
>>>> From: Steve Rutherford <srutherford@google.com>
>>>> Date: Fri, 27 Feb 2026 20:34:57 +0000
>>>>
>>>>> When SWIOTLB and header split are enabled, IDPF sees empty packets in the
>>>>> rx queue.
>>>>>
>>>>> This is caused by libeth_rx_sync_for_cpu clobbering the synthesized header
>>>>> in the workaround (i.e. overflow) path. After the header is synthesized by
>>>>> idpf_rx_hsplit_wa, the sync call pulls from the empty SWIOTLB buffer,
>>>>> effectively zeroing out the buffer.
>>>>>
>>>>> This skips the extra sync in the workaround path in most cases. The one
>>>>> exception is that it calls sync to trigger a recycle the header buffer when
>>>>> it fails to find a header in the payload.
>>>>>
>>>>> Fixes: 90912f9f4f2d1 ("idpf: convert header split mode to libeth + napi_build_skb()")
>>>>> Signed-off-by: Steve Rutherford <srutherford@google.com>
Thanks,
Olek

