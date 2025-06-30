Return-Path: <netdev+bounces-202349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5115EAED78E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C957A3BB1
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 08:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10979242928;
	Mon, 30 Jun 2025 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akhFDLzz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD641D8A10;
	Mon, 30 Jun 2025 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272760; cv=fail; b=fZFoseVWhfi3rGKEjZAcDAcFKYA85Dtjh7MZuPIv6LFTh9wV2r4hBnjF7v/2klQ8Saqc+9YMnDoIczIp2MIbf2NnPGgRYtACmTus7wwM+hugXXHNXbG74Kymh1hIrRia+C4hAnjprKbt52jFmP5TiMhSD8CpJShKdZoM1fNzxaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272760; c=relaxed/simple;
	bh=dodnpNuAwb3Ggm9ysocEv0oLmSgfqXqkGrtCJBm4qoM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BYqv5vlzuSpCvxnUU97ovgIKpY4jMSwwK+L01zN1hA/v/LeygIhzxCuy7Hs/Y0P5/893o9TIDc7aW5r3LZ7cCYlbZbnCM8REZHJfZOK7mnTV+JxrVUATXFQwwwq+6/5qiG7hF3fh3tuc/cWXn+fI6Sg0Jzuk0apE6tKGlK26Jw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akhFDLzz; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751272758; x=1782808758;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dodnpNuAwb3Ggm9ysocEv0oLmSgfqXqkGrtCJBm4qoM=;
  b=akhFDLzzw7oc3st+PtqF3L9RrDlCl0W5RiobO+Zd1NhE/hPm5hOuoHS+
   z+rfVltTk3f9WoFrbYrYu8/pM04u45H+q3iYXv7/x76ietTv7TPFLgFZo
   076xCLxw79+mKwfuvoviztbhyOXw9umXcYfUp7w+ARtwxSfOCIVx6VGan
   VVBAGEOLiRTBO8zQwPS3zbfztt6JL43D3FZg5XOgC7cP/oLyA8LlghPzW
   XuoeqRg6xJAtAhAM8EU31hBQ4psQeoOJN9UsoafdP6Dj3vjCz8hJOOHLL
   bYFOtpu46WJ1RN80Ag91OQy7ZPOcOWIVQnGNOVaEJObQTrw9R+id4IJ6A
   g==;
X-CSE-ConnectionGUID: 6fq9tXgQSYOgKeR4NrAofQ==
X-CSE-MsgGUID: aKsw5LEyRUiEmPsQnrQxJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="52607716"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="52607716"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 01:39:17 -0700
X-CSE-ConnectionGUID: l8ynQPCiSlOJkvts5bIEjg==
X-CSE-MsgGUID: heRzaIHbQ4CLpeXjAxGsdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153024523"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 01:39:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 01:39:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 01:39:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 01:39:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL5TNVm3Cg/vLIZPWFxXn/Oi0q5KiHciNuEyq0YHhXfCUW1iPw2LrsOVlXsur1JfEzQrdFnayHouVBSG+8weoodEN2eMQRRSy1+3FHmnVVLzJHD/vpi6rFpPGASw8S+JbU1RwEfY05eSICQWjEM1wukMc8SuC45UhW9NlJB0u3zxmSvTvW/6pnd5Bv/Zdu2+9iNjDfB1tr99C6QI2Fjf4pnwkCbOzR3R3QZ4TOqQq/cElbLrttzmNvj+hSWRZMeE1n4mZvtlNgiPibo15GLH4HsBJRxPfJmVYQm+YJJ38woiYdlVYK7Axgk41dRm943HASXHRFz8aWPD5B4kbxxhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Soen8FqqXY4campjt/D4OWXJZO/oZM544ddIwgkTjyU=;
 b=SBXl/x0EsfBwBBkk7ZHYouTXVukkuv7dfIEHx2IZdHJ/jIjrbayNkHagHZrSyzZNrKa0sOpR6AK+jMxi7A2wNHyQ++N46Dw+/lU7sHZFGD2zxEGtUTbZuRAjqhyFLtru2cqZlf15E954e1IE3O4cps6ga5p/dJeiyKIrAqYtoXPyy1o3Ye60ELXg8E5Sm4Z52qR15GcMyvb7osBWJR8nFecy3uaocMvx5pUaFuQ34KOyrobe6lxsq3ClbOpY0GnSBbXoRKMRjBRwHedt4VtVfWcSYRQ2cUAUOn48h5+zGQHa7m/zslqIQkFO0GZhseBRSDyG4MZX8qNPWPsLy7FuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB6474.namprd11.prod.outlook.com (2603:10b6:510:1f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 08:39:05 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 08:39:05 +0000
Date: Mon, 30 Jun 2025 10:38:54 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jijie Shao <shaojijie@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 1/3] net: hibmcge: support scenario without
 PHY
Message-ID: <aGJNHsCMwVLqbAq0@soc-5CG4396X81.clients.intel.com>
References: <20250626020613.637949-1-shaojijie@huawei.com>
 <20250626020613.637949-2-shaojijie@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250626020613.637949-2-shaojijie@huawei.com>
X-ClientProxiedBy: WA2P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::18) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: d354eccc-02a8-426f-6378-08ddb7b1929e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tAIGlOdUEbeAcrxX7TMoOpR6uh0tasIjs2CVJJci0Rozw4xG242p67sHE2aF?=
 =?us-ascii?Q?WQASKJuZlCuQ+y/N8ScwIi3xCN2ySRpPWp+0jvqCq2/m7bzEAULIXyUE6OHA?=
 =?us-ascii?Q?fcsRLvOeoNdv/cQzsmUwq2Rhyd39ijBwEkax+PIBVeSaKzm/N3AvbPCRdl0T?=
 =?us-ascii?Q?4URxtRQi672Ego6RiRLRucUYYPbgefpLrIVBrcF08HvM19awcizD0l0rHA1L?=
 =?us-ascii?Q?eJPdDeI/7Ks04zB/4eIsSMRASnH04v9ldMptR8KjE+6vlwMHjPw0yYj9cHdP?=
 =?us-ascii?Q?ApDLeJ1w0g9OvTKHOaSFnsMNHrTGxFVrVudA+VITnlyS2kPQ5EOT/mrP6Ip1?=
 =?us-ascii?Q?WZO/jkW4ECYk/61Spu1pe8UDgYT5oLU3JVw6bf0Vz2e5HNnBxF4mYPXcz8TZ?=
 =?us-ascii?Q?c5Fg+46kSO5g71rZjgmSU6yL3kfEnyA/xDK2fiA3EzRupBnZgVNaOOmVXqLr?=
 =?us-ascii?Q?eVRYz8BSqR3GDSIKtfyBOAaGDWAifpoROpidpycCVKKlHTant8iRNTvOcIKo?=
 =?us-ascii?Q?P8I2nPU7FYS+AMVW5XjAVvuIR/Kx+Dogj2N8s/B7N9+N3RItFK19urP3x8G2?=
 =?us-ascii?Q?/vvo2ISTRT0UOMZpi9nfBNFw2G+GY3WPzcfUI9cn38tcE5LNOCJ4m6j2FkOw?=
 =?us-ascii?Q?2yBT4RhkljL7UPAXK7pKRnXjv9ykiM+Vp1rr23+InqPz2BbPe6C90AqkBqDO?=
 =?us-ascii?Q?OhtENMyckHLa5VCW3x9vmMk7A0OhTQ6xsr2ZGtG0C3rF0J2x3Y8Tf2jBhwRZ?=
 =?us-ascii?Q?uobL4trCHpp2zLcFc93KuViQGnhigllEPr2pd7xNjPbq+7CxhxNzJHzM2xzD?=
 =?us-ascii?Q?lp32uqSLDUveGWJPsjBQ1f8VHkTLLcpQ1wfx1ePLihDVASYSpe/cnf6aHRUN?=
 =?us-ascii?Q?vljB6noKqI9SmiRytb49P6cDzcfD/v017FzcghIyVqzRpnYSNcGhDuAuDHEy?=
 =?us-ascii?Q?5+QJM+kn2MB3exbfENZI24sjD7PPjUajAYMTdLmSNEKzVTcmn5XdFf3vTQT0?=
 =?us-ascii?Q?aAkcyewYMIKX/UzoCesUelGZ+VDSo4k7mj0mKloa8Jx95ITmf3mK1ASl1uJs?=
 =?us-ascii?Q?FtJmePJ9ds3BeoPCI+CkX/TnXq6PVzJqgd3gDAcYbH5jeGZanpkonf5MJ7/G?=
 =?us-ascii?Q?6xBa/ojWskP7ILLg+RaL77g8ITQ9qzPRFDCkvonvaoHLhCb0khaNCPB/zDzp?=
 =?us-ascii?Q?3LWbuQDoXwGZGHFj9comuW8Kfv3Da4s1dsXsZz8fplPs5natHOKccS4e83cW?=
 =?us-ascii?Q?TaqfiGIkPPbDKUjO0du18C3IUimh9LMR80y+SCtH84uZ6BaWIisUEdeZZh7d?=
 =?us-ascii?Q?P0EpmILeposyDBN+bKd30wri1UGAQ4y4p8m42rK8y68xabL8nB+kk/+T1m21?=
 =?us-ascii?Q?X98G19iYsm4B1JlZX2dCzxYga6m1SBjHLN7ZF10CORgtb8X2PjrJXw5G++sq?=
 =?us-ascii?Q?If5SQyPFnXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3btDkdunlUkRQ60NX5I1q7tJVgnYULFCvbBy46bZe4qdZkhMbf5x4uxcloRr?=
 =?us-ascii?Q?Z07QhE7ELv3j9gEU0L7tURKhC8IyBI6cSD4WlgIgcjJRhKr6ShkoSK4yARiQ?=
 =?us-ascii?Q?trlWqAGQRRXx/7faBWAvi7rvKxR+1Fjo43MDvGVRDDiv9yZxPivIfjlGIm7O?=
 =?us-ascii?Q?vyIXyQ6ZoJVkKtnV8HWLQyRlSB/czVzf1Sda1a0JBU4LhrW0Bmon6JYw3hAM?=
 =?us-ascii?Q?nQduwoSeKlynnFHkMbrEjslGexPhol1AyyYCfASuBdcdx558nQL875vaxXhw?=
 =?us-ascii?Q?ZXO/zinSwm/WZ4UMFxTnQYKt2UwM6Z4u7AmxZNjzEqktLvV7hZaaCoCc3NU+?=
 =?us-ascii?Q?HwEKnagiKoSwSgb8ED5+wm86+iNKci5hL98jsD7N1avNyXbEE3pSW88ZQNyV?=
 =?us-ascii?Q?LjJyZzMQYFVXDYtJq09Qd1tELQALlH+jA6EtZO1imSAcAZjEZ9kLBYP5GG5Y?=
 =?us-ascii?Q?Ujh4TKNBpmZWN3K/+x3k9G7U06XDmxisKP7SsaRVUVCytX1dAAR5lzesmQBe?=
 =?us-ascii?Q?EvFFc7eivWEdvQhadjt/2gMiRwwQIwEkxv8Zf4aLOkC3mukCgLbKjlcGDH59?=
 =?us-ascii?Q?jkVXpKvwSnH93ZNnAZ8MG/vA2BDYK8A30nTOyr8iGRraN38jmox8DpG1XkXu?=
 =?us-ascii?Q?zPFLlBMKCcPP/wRWF/JUGDVMj3fgIl75rOqFajW3bu1GI117lFPLygp8cdlb?=
 =?us-ascii?Q?Cpl8NoHdcHYo47AYznsR20NvOJsiwunEwvd8IlFj2jDtEzjIDAkc8UIzEOnI?=
 =?us-ascii?Q?i7e4xULBcssp+gZCkAXWKajz9iHVN1+R2lShSVQWzmhCLkfzF6KWLhYKoG75?=
 =?us-ascii?Q?nC5bRvA3YkivRzUcrX4PlN1j5VKbxhxIcmBJA1ovvGkVmQ09T0U/FmrT0sru?=
 =?us-ascii?Q?PZvhAfNrWomwkwEa955Vkr70rcUfM3gkJZvXlZ1QxS7i6q7VayPyF9npwRRV?=
 =?us-ascii?Q?olvDUKm01jRy5UVjVniq9RXzXeBir8RXH1fv/mhQiQThFtswMto+kZYq0T7Z?=
 =?us-ascii?Q?2bpyy5KhOMhzJ84DpIyImnCiZcLTsEAr6RZ7k262TxHKQ7NdFUOqnNlv9dBS?=
 =?us-ascii?Q?C1GXU8B4/5B7mBPTTS3euGdLpggXOBn/z8GfgXGdQxMx9a/H/LKoYGTLJh3E?=
 =?us-ascii?Q?eOMTzG7SeZc+VfFGmq7u9OzBQUOa/X9pbMppPzQ940hf6Q4GiawwOkc6okD7?=
 =?us-ascii?Q?u6lLqF5KWZUYhklTvn35SBvJKko63v+AUogya9Xq54nMCGHPGTFu5wuoyKwp?=
 =?us-ascii?Q?GO5Vf9v6iNKypMeXyD196FrJtTg0lZN35IwIEUKPEGNw7+FiXDFLvS+Cb2mq?=
 =?us-ascii?Q?Y5VtYl1gbBC4fSjE1YZzYW1awn7lg7r32o1Cy96cnLYLnIG0/F3mUlHYZ5Ng?=
 =?us-ascii?Q?o417HqiMxAhNBz7Ervo1gJInlHxS9x2cjVPVz7+5qEMyD0iMkyl3UJwCRST4?=
 =?us-ascii?Q?ciSJzT8F92DFCddVusUvtn0b06KmZI2jerFWgPuX+IAz5F+w8uZBDuVVb5uq?=
 =?us-ascii?Q?FbONfbcVTWYPhn6INAR1rs5GGxja2r4uY0lJFBp/iuHFjeItENdqZCa6vaSj?=
 =?us-ascii?Q?LP8m3/GtHsorO42LP4TUE3e26PRxBnp6xe8lL00cDoxW/iR2csPyoIkvNR9b?=
 =?us-ascii?Q?xcJIlahhBeDiLvp6LCDRgBtfXjv4SCRxkg9iasVs+06ZtprpkzFw4sy4XUPp?=
 =?us-ascii?Q?0ZHQQw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d354eccc-02a8-426f-6378-08ddb7b1929e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:39:05.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfQ+607MgHnxd9XOYX8SgH6qL8h1R2xyyiyKQYsag6VZq9dbhZ/uRhDCCMNrWZkfEPuQPkK7u6JAvZwtiBC0I76kVGatqJe7WM3Shkt5Cz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6474
X-OriginatorOrg: intel.com

On Thu, Jun 26, 2025 at 10:06:11AM +0800, Jijie Shao wrote:
> Currently, the driver uses phylib to operate PHY by default.
> 
> On some boards, the PHY device is separated from the MAC device.
> As a result, the hibmcge driver cannot operate the PHY device.
> 
> In this patch, the driver determines whether a PHY is available
> based on register configuration. If no PHY is available,
> the driver use fixed_phy to register fake phydev.

uses/will use

> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Some minor cosmetic problems, but overall seems like you nicely incorporated v2 
feedback.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
> ChangeLog:
> v2 -> v3:
>   - Use fixed_phy to re-implement the no-phy scenario, suggested by Andrew Lunn
>   v2: https://lore.kernel.org/all/20250623034129.838246-1-shaojijie@huawei.com/
> ---
>  .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
> index 42b0083c9193..41558fe7770c 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
> @@ -2,6 +2,7 @@
>  // Copyright (c) 2024 Hisilicon Limited.
>  
>  #include <linux/phy.h>
> +#include <linux/phy_fixed.h>
>  #include <linux/rtnetlink.h>
>  #include "hbg_common.h"
>  #include "hbg_hw.h"
> @@ -19,6 +20,7 @@
>  #define HBG_MDIO_OP_INTERVAL_US		(5 * 1000)
>  
>  #define HBG_NP_LINK_FAIL_RETRY_TIMES	5
> +#define HBG_NO_PHY	0xFF

Number does not align with one in the previous line.

>  
>  static void hbg_mdio_set_command(struct hbg_mac *mac, u32 cmd)
>  {
> @@ -229,6 +231,39 @@ void hbg_phy_stop(struct hbg_priv *priv)
>  	phy_stop(priv->mac.phydev);
>  }
>  
> +static void hbg_fixed_phy_uninit(void *data)
> +{
> +	fixed_phy_unregister((struct phy_device *)data);
> +}
> +
> +static int hbg_fixed_phy_init(struct hbg_priv *priv)
> +{
> +	struct fixed_phy_status hbg_fixed_phy_status = {
> +		.link = 1,
> +		.speed = SPEED_1000,
> +		.duplex = DUPLEX_FULL,
> +		.pause = 1,
> +		.asym_pause = 1,
> +	};
> +	struct device *dev = &priv->pdev->dev;
> +	struct phy_device *phydev;
> +	int ret;
> +
> +	phydev = fixed_phy_register(&hbg_fixed_phy_status, NULL);
> +	if (IS_ERR(phydev)) {
> +		dev_err_probe(dev, IS_ERR(phydev),
> +			      "failed to register fixed PHY device\n");
> +		return IS_ERR(phydev);
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, hbg_fixed_phy_uninit, phydev);
> +	if (ret)
> +		return ret;
> +
> +	priv->mac.phydev = phydev;
> +	return hbg_phy_connect(priv);
> +}
> +
>  int hbg_mdio_init(struct hbg_priv *priv)
>  {
>  	struct device *dev = &priv->pdev->dev;
> @@ -238,6 +273,9 @@ int hbg_mdio_init(struct hbg_priv *priv)
>  	int ret;
>  
>  	mac->phy_addr = priv->dev_specs.phy_addr;
> +	if (mac->phy_addr == HBG_NO_PHY)
> +		return hbg_fixed_phy_init(priv);
> +
>  	mdio_bus = devm_mdiobus_alloc(dev);
>  	if (!mdio_bus)
>  		return dev_err_probe(dev, -ENOMEM,
> -- 
> 2.33.0
> 
> 

