Return-Path: <netdev+bounces-100776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 108D88FBEDC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 00:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794E51F26637
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382A814B08E;
	Tue,  4 Jun 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7WYrQIJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4461442FE;
	Tue,  4 Jun 2024 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539950; cv=fail; b=NJ8j3uK44C6V3Ndnh9FuxIn4qzSWGjOzKymJe5mxhrYXX4UZ37PZ1LnZsNNdJ93lBgE8Zk8Mrr0/ebQb3jtSYzxYA9ZQZcbZHfXKLQ9/RGmPyJco1qhaELU2dZ5kLNjE2FG/VS5LNk9LMGCB8xvhxRKelXeeZmBn7z3Piv45bvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539950; c=relaxed/simple;
	bh=3xPpS1LfMma2QsveH1pdtuAz2VTT+XfRwJ4g+PWC7lc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BBrge/JUWGm2ef4dN5NNYG1UE7+MfCNGKCBb4qFkFvW1kPsDsNaMIKd6raQalRAE+HFk7ysxCO6Jw93154KCXEbPHzD8g97WgxNPNTrJ2v7h/rYaXj6Xve0O7oajxWOWWmTwMZQRY8d1Rv1v0ONaSYvr530qxj3aHD9dInw+MKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7WYrQIJ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717539948; x=1749075948;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3xPpS1LfMma2QsveH1pdtuAz2VTT+XfRwJ4g+PWC7lc=;
  b=Y7WYrQIJ+hzWunMsFGk6Ezh1JRYaZsTUFqfk9vR6YAQRct49E06Oxdtm
   fXPWLtWJzZ8WSp4rmLeiJ7LI315wdvE7uynVdjoX1JkdcijebsHRcCz+B
   kvd3SfiS8QuSdWXrgMjpz+LpWLnBxZeqLaOLDdGbc7AlgUnMcrd+d5MTL
   xMZblhpm8n2lguKGndVBb3RQSbtRz7h63i1zBmkXZu+gvZQ3ho68zSOVi
   zrSBZJQz2GT59WzBO88cmYdtd40FEwr/Mmy0Ochx9KfvJFrXLbgpnSpwe
   JX5ybqoMb3HaTRQLVADna66qsAZTJug9xMSMTRGC7VcslTyPY1ELkW8k7
   A==;
X-CSE-ConnectionGUID: xCdX2ScATzu7s3Yp5UJHig==
X-CSE-MsgGUID: IZLBRdJzRFC4rqDrm+pD4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="17961515"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="17961515"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:25:47 -0700
X-CSE-ConnectionGUID: HWow3BuKSIyeF+xdtqMXFA==
X-CSE-MsgGUID: B7AOISbASU6IexQJ7VJK3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="41806218"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 15:25:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 15:25:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 15:25:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 15:25:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciZ33m8rIS/wImRFjtE4l+TWzPDxtScgKnqLh5KOv4z1sd4z/vS3JWRAMed65C7eXCE7sDc1ukoYoGpiFQ+Ur54d3VxoTZMXoB4KpxL9CsZpjyae3lw50OHJxBr7vg7+Jcx1ncF/6wu7/RNQRC5PXk7sOYOx708MK8XtV6FWvtASelZ5hZ1Znav05YUN/Fjo6+1Xglj4mjh8rtgvthuZyyNCc/yPlNAKWZMzFMDwzCzmcY7e+Z79Wj0ootbHkTw0YOVKqdlQoCsbYOC051qZaZmRZ4UZDJzlta1evOvBP1Mlxe3zkPek4K/wc3f6cFGUiLiA8aLWUEFP4rnXl4+cLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3zAypr2SA4/rU+xfOf0YyK58rrz18711OYYQ4Z8AgE=;
 b=GkXblI8L4uTj9+OcOgCZQ2nE/FaKmWp3+Z77tmhBi/ayhifrfILerUFFR6Gq/1aQQjuPh63kAuaRVPtKmIKhK6c6p2LsdZBiRJbFWQim/J8DebxGpLXC+NO7OrN0zcp+aqxCq7w2Vh5sdsL9NckuF1g7UBwZ1BaBphhXQRk0ZC8VhwZvfRaUdBLmNrFA5wRRW42mT9gOfAFol9lw8UP+Xc6pm2k4ON1RrxR8/UzhBymj9UghwLnx0UF+pAp1V+cpc6cpgHvw/aknSiVY8vBOrBJccE86JRbngDSbnDfkTZi9k8J0Q3AJsM95yS2L/67RBkPo0wNKz0qU0E2MvwSauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5204.namprd11.prod.outlook.com (2603:10b6:303:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 22:25:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 22:25:44 +0000
Message-ID: <b2cb86f7-c16a-44d2-a7b9-eb379784ff83@intel.com>
Date: Tue, 4 Jun 2024 15:25:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net v3] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
To: Frank Wunderlich <linux@fw-web.de>, Felix Fietkau <nbd@nbd.name>, "Sean
 Wang" <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Frank Wunderlich <frank-w@public-files.de>, John Crispin
	<john@phrozen.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<bc-bocun.chen@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
References: <20240603192505.217881-1-linux@fw-web.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240603192505.217881-1-linux@fw-web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:303:83::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5204:EE_
X-MS-Office365-Filtering-Correlation-Id: 74683846-7e58-4b40-ac8d-08dc84e54621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUkyRE1qekhFWndpWVFMRGQxc2M4WlhlLzh6Y0NIQnphak1EZlN1TlNMa3dT?=
 =?utf-8?B?Wko0RTl4SUY4RHFYL0RDQ0dmQUtLOStsRGdVWXRvU2lqYkF5Q1AyVlBnZDNw?=
 =?utf-8?B?NjJ3RkdrcVNZSzk2a1g0WHY0Y3BmSlk0TGZ6UmZNZm8rUDNXK1R6QlVUVTZa?=
 =?utf-8?B?ajhYUjl2dmdHY3JZdCtkdjJqTTZDRkRlV2k4NDJCSHlMQjllL2QxMTBzbzhK?=
 =?utf-8?B?Q0JhcFMyNndIb3JtVUZTc3BaMGZ1VE84NW1XZENhRXJJd00zWnFqNm9HZzFU?=
 =?utf-8?B?OXVpOFd6ZEZEUzBZT0Mza3Q2RkJSY1RPQjlSUi83UUdhL0hNSHB2R3B3MHoy?=
 =?utf-8?B?cVordEJYbC9CcEFLaDdVc1hDYnBPUlVRN1Nsc3ErNG1VM1Zkc1BNQ3FNRTYx?=
 =?utf-8?B?Nml4L2pMWllFYU5OTjBQUzZnRnIwTTJWTDh0akcvNmhvNHlJUVpLT2FYcXBr?=
 =?utf-8?B?OUNLN045WHVOYTlRaEc4VGpteHNMQzBCU1czc01ra3FGcnNxZDBXWEExRCtj?=
 =?utf-8?B?eG1uWTh3RkhmNE9zYkswT1R5RjlTK3VibzNKMndzMXhOWGEyVWs4N2d5dDZM?=
 =?utf-8?B?Y0VpTUlqL0Nvdm9RWVQ1MjBacHROSjNHZ1lXNFdLYXNXMFJmKzBDZmw4S2J0?=
 =?utf-8?B?QjJtTmhnZUNuNEt0Q05IWnM0ck1pWmU1Zkg1ZFExbkpPbHBKQytpWUI1OGFS?=
 =?utf-8?B?YzR6ZkNnMUNzYnMxZERzbVdqaloyYWhiSWo0VWFRTDFwd0FrcmpzRUR6cno0?=
 =?utf-8?B?ZVV4YURQL0ZxZFlKRGVCUnRMNTFGa3FucllxQmQrOU1aU3M0MG5tSUVXcDdL?=
 =?utf-8?B?WUEzejZXK1ZjT1QwZVVJZGtFbkVBdXlnRnJMNk9sY1FmbHpFV0xISFhKWWp1?=
 =?utf-8?B?R1AwYUxCSCtUQVB5K3Y0SVN4SE4ya1MyeGplcnN2S2ZRb1lTZFF0WlVzaGR4?=
 =?utf-8?B?YjEvYnFXUEswSjQrV2hSMTAvZWtBZm83ZkRpL2dKOXRVcjJyaTNvQkhVYnJp?=
 =?utf-8?B?RzIxK004VDRmOG1IbWJQVmNLUTZoemNLTWxKMUorNi9XRVp0UWEwQUQ2L0Yy?=
 =?utf-8?B?YndDVDhiSlgzU1FGWEwwUSthaDJNaFlzTE9VNXl3RE9qM0tIWFdaMFFFM29a?=
 =?utf-8?B?QkxvNVFOQWVSdE50ZGQrY3pHYXpDb0hNT2pEWHROVlJ5SHgrZWpoZ2Y3eDBY?=
 =?utf-8?B?SDVxSzdGb3U1OWo2QlZ2MEJxTk1ldkNtWUVqQ3J0VlVpamY2QjJha3g2bStL?=
 =?utf-8?B?QTNuSTc1T2Y0dGZiV2RPOGNJeFBscit3aVhhMlVxdURhN2R3YzFURkU3RjhU?=
 =?utf-8?B?N0NVdTY3ZmtjWFhISWRCWjV2b3BOaThwZ0luQk5vUEhXMUdOZUpKd0xCVGdI?=
 =?utf-8?B?bUVKNjBlM3NhUXdqUTYvUEltb1R5S2tnRlQwa3loY2ZkUncycjdZWUlTMWt5?=
 =?utf-8?B?VHNMUEJBZ3MwaTZIZ05FSFhJZ0Y4dTRwOFJRdGZaUFNueHY2M2w4Wk9BWXBP?=
 =?utf-8?B?RkwwYXROSnFRWkpLSVM3Q0tGMXJVWkhKZ2M4eTZMZ3d6TFZlaEJjUzR2VEN4?=
 =?utf-8?B?M1BxKzJrdnFhRmNxTlNoSU1KK1FnbUh0UWllT1ZESDBVc3VyakRpMC8wY3RG?=
 =?utf-8?B?SWh6T3dhbHdpNUNoR2dxQnhIUThMOUxLaGZ3aHZFcVRCekIzT2kyZnh0dVJy?=
 =?utf-8?B?M3VtRVRjT2Raczl0QzNLa3JQYUMyaEtDZEdlS1UyWW5YOVdwWnkyK1JxQUNt?=
 =?utf-8?Q?ozcYlPZdFLjr054f3gAkjouqYZkClMBbPEcv0iN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JveWF3RE5rdGZLS2w0U0ZhekgxSTIvZ3MveUlhbVJIcHFsam50eGVwOWtE?=
 =?utf-8?B?ZFpkckNMeThVcFdCNEplbnpvVUo2ZVMzRGNoSElNSGhQamNkTHpkakkxL0sx?=
 =?utf-8?B?N1hRZkVHVmIwMk1CaHhHVkc2N3RUaEVINk9ZWmQySmFpUVpHVkxsUTZUZk8z?=
 =?utf-8?B?aWRqMTFicGV2QUIzRnhPS2VLQ0lpS05pRnlkL21zNUlTRmcvSktmTVEvajFR?=
 =?utf-8?B?aGxIck9OQWIwdWh2Uzg4Y1B4OFpOUWcvT0x0UXluWVQ3Y0l1dEdKczJJZHV4?=
 =?utf-8?B?M2Z1REkyM0JGL25oUUF2bU13VVVuajJveXpiazdZa0VhN0R4akYydU9pdUVj?=
 =?utf-8?B?dysvMU9xcld0QmxLQkdSSnQwTldVMXljN2ZTdzhhVXBUR2dVRkVMOHE0R213?=
 =?utf-8?B?cjZNSGhjUGJvR2g5Z3dnbUhRVW1DMytrMEppbkliNGsyL0N0Q3JRV1ZIZ3Bx?=
 =?utf-8?B?V1hpeGZRMUxjTERVaXVvUElwR2FkSVR4SFdURWZqNTg0cWJoL29Pc0QrTjZq?=
 =?utf-8?B?MGJTRUFaTUNpUXR5dDNiWGNobkFUb1NNaENNdjhxREZhZ1AyRXNXUjUzbXhm?=
 =?utf-8?B?bjVtaGFMcVh4T2E1aDgxMWFyL01ZOU1lcXpneFFEMk5na1hjM2xHSFZvMW1S?=
 =?utf-8?B?bi9taHZVM1Y2eUx1cDhseS9zK0lOWUhtMjIzakRrWG1LVUNvYUpQdXpOSGFM?=
 =?utf-8?B?bitUaUY3a2xWRmtLQmZ5Y2x4aGVQUTZVSmhVNHVWVExKaFlzUnlsS0hjcnNU?=
 =?utf-8?B?N1lXZVkwZDB2OFpvVzBjWjdrUjlhQWlEbWF5SjZPUEI0Ui91ZCtvUkVtOXBE?=
 =?utf-8?B?WTNHcnc4ZTcxcXp1MjdHVURJK1llcU1qOGdMSzhvQVlDN0pHVmw3TTRSSWZi?=
 =?utf-8?B?dXlSK3pma3JDaGVzSDl3VGJZRTZpYTZEbzlYeVlDdlN2QUUyelc4cHdPZWRw?=
 =?utf-8?B?V05ERTVqeWZCeEVtZCtxdTBwVHkrZmorTGIvN1lwd3EwMk9GK1hOK1FIb0tv?=
 =?utf-8?B?ZDZCTmVOU1pMUjJ2V2V3S2owaDA1VFBCbTlBemNkak4wL011NXAwUGpmYkhq?=
 =?utf-8?B?T2xRQXZuWE1ET2p0MTJzQU9DaHRISVM2OVBWbmtGUUNGVFJRa3NxL2JaV1Jt?=
 =?utf-8?B?azlwODVWb3NNN2xTUFZ6UUN5Y2FrWHNTNmZzNG9tRmlmanBrbUIrSnBRQThO?=
 =?utf-8?B?emNSVmkxalVwR21HZDJoenZVYkNCdEpGMi9PcFpyZHpJZVUwTkxZa2hIS2dX?=
 =?utf-8?B?My9Ydkp6cGxIZ1AycXNxUWNtVUgzMjgzc2IzNmxlcCtFNDkwS1ZZNEtWYTFk?=
 =?utf-8?B?M09Pdm41bzlNUTM3enFDWHRaREFtUmRYaVlhN0RpdXloYTF5RDVhNDBHZmd2?=
 =?utf-8?B?R2ZtbFV1ZXNCWEdyVWtvUllNajRoMjQrSW5PK3N6LzM2SXBubEo5L2tCV2pl?=
 =?utf-8?B?UGd4bHNQaDFGbE5aZnY4R2ZBU1lWU05JN1hzNVJ3WlFrR0lSSWJsd3pMckx3?=
 =?utf-8?B?RnpYUEFuVDVSMmVFNEg2b1hVanRsNWk3MGZQK2QzbTJXaW9FU3NPUEpMQ2ht?=
 =?utf-8?B?U0pTN1dJOGI1N1NwSkRaZDN2MlZNVlBrSld4dGZCLy9SWDhxUWFEU0ptZXpv?=
 =?utf-8?B?U0R0THhtbElSdldaNmFHY2xRVENMN1hYUVFoR0xsL0s5Mzl4ZXhRQnJPVk1P?=
 =?utf-8?B?bEtQOE85bi9mcjlSaFkwdWFnU3MrY29hUyt5NFUwOWJoaExpcUdHclI0MFNh?=
 =?utf-8?B?eHc0eU9ZUzdXdkZQZ28zSm9tSmo5bUpjZkNHTHh2OEhOd3ZRZERQMzNTVk94?=
 =?utf-8?B?Q21hNEFFbXllNmdORmcxYTF3eDU3ZWpTbCtZZEdkQm1XbkxoTThYMjVLbkxK?=
 =?utf-8?B?cTdYblVHeXAxY3JRN2ZtTHRhR3JGcjlFbFVTU0ZUbTJ5WHNXWVlDcW5BaGdF?=
 =?utf-8?B?RlEzdktVMzZHc2o1Z2tTbTNOQUVaaU00OGt4WnFVS0F1MnNsRGc1UGxTUGlZ?=
 =?utf-8?B?UVkzTGM2UnNlM1VWNTBuNFZaQnVINEtEdW5PUkpJZjVPcC9tL1FZb3oycEFp?=
 =?utf-8?B?S2hJTkdla01ZbE96MGxKN2FLdzhpU09Fc0V5RUQ0eG5qb0tEeDl1NkRZTTNK?=
 =?utf-8?B?bEcydHQ4WnY4bE8raUtuTm1DYjFBUVNPTEFZK1l3azZUb0lSbFhqTXNib0RZ?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74683846-7e58-4b40-ac8d-08dc84e54621
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 22:25:43.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uc/ZGsOZJSEPNEv+3pS0DvuxBhTh8IwjCfb/mNNjq9tq8ba7tmyHiTKY5b9tmqGUWtKgmwp7cgw0i86FZ4zqNjDrYyZcU4GzvoUTTyv/N3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5204
X-OriginatorOrg: intel.com



On 6/3/2024 12:25 PM, Frank Wunderlich wrote:
> @@ -1142,40 +1142,46 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
>  						       cnt * soc->tx.desc_size,
>  						       &eth->phy_scratch_ring,
>  						       GFP_KERNEL);
> +
>  	if (unlikely(!eth->scratch_ring))
>  		return -ENOMEM;
>  
> -	eth->scratch_head = kcalloc(cnt, MTK_QDMA_PAGE_SIZE, GFP_KERNEL);
> -	if (unlikely(!eth->scratch_head))
> -		return -ENOMEM;
> +	phy_ring_tail = eth->phy_scratch_ring + soc->tx.desc_size * (cnt - 1);
>  
> -	dma_addr = dma_map_single(eth->dma_dev,
> -				  eth->scratch_head, cnt * MTK_QDMA_PAGE_SIZE,
> -				  DMA_FROM_DEVICE);
> -	if (unlikely(dma_mapping_error(eth->dma_dev, dma_addr)))
> -		return -ENOMEM;
> +	for (j = 0; j < DIV_ROUND_UP(soc->tx.fq_dma_size, MTK_FQ_DMA_LENGTH); j++) {
> +		len = min_t(int, cnt - j * MTK_FQ_DMA_LENGTH, MTK_FQ_DMA_LENGTH);
> +		eth->scratch_head[j] = kcalloc(len, MTK_QDMA_PAGE_SIZE, GFP_KERNEL);
>  
> -	phy_ring_tail = eth->phy_scratch_ring + soc->tx.desc_size * (cnt - 1);
> +		if (unlikely(!eth->scratch_head[j]))
> +			return -ENOMEM;
>  
> -	for (i = 0; i < cnt; i++) {
> -		dma_addr_t addr = dma_addr + i * MTK_QDMA_PAGE_SIZE;
> -		struct mtk_tx_dma_v2 *txd;
> +		dma_addr = dma_map_single(eth->dma_dev,
> +					  eth->scratch_head[j], len * MTK_QDMA_PAGE_SIZE,
> +					  DMA_FROM_DEVICE);
>  
> -		txd = eth->scratch_ring + i * soc->tx.desc_size;
> -		txd->txd1 = addr;
> -		if (i < cnt - 1)
> -			txd->txd2 = eth->phy_scratch_ring +
> -				    (i + 1) * soc->tx.desc_size;
> +		if (unlikely(dma_mapping_error(eth->dma_dev, dma_addr)))
> +			return -ENOMEM;
>  
> -		txd->txd3 = TX_DMA_PLEN0(MTK_QDMA_PAGE_SIZE);
> -		if (MTK_HAS_CAPS(soc->caps, MTK_36BIT_DMA))
> -			txd->txd3 |= TX_DMA_PREP_ADDR64(addr);
> -		txd->txd4 = 0;
> -		if (mtk_is_netsys_v2_or_greater(eth)) {
> -			txd->txd5 = 0;
> -			txd->txd6 = 0;
> -			txd->txd7 = 0;
> -			txd->txd8 = 0;
> +		for (i = 0; i < cnt; i++) {
> +			struct mtk_tx_dma_v2 *txd;
> +
> +			txd = eth->scratch_ring + (j * MTK_FQ_DMA_LENGTH + i) * soc->tx.desc_size;
> +			txd->txd1 = dma_addr + i * MTK_QDMA_PAGE_SIZE;
> +			if (j * MTK_FQ_DMA_LENGTH + i < cnt)
> +				txd->txd2 = eth->phy_scratch_ring +
> +					    (j * MTK_FQ_DMA_LENGTH + i + 1) * soc->tx.desc_size;
> +
> +			txd->txd3 = TX_DMA_PLEN0(MTK_QDMA_PAGE_SIZE);
> +			if (MTK_HAS_CAPS(soc->caps, MTK_36BIT_DMA))
> +				txd->txd3 |= TX_DMA_PREP_ADDR64(dma_addr + i * MTK_QDMA_PAGE_SIZE);
> +
> +			txd->txd4 = 0;
> +			if (mtk_is_netsys_v2_or_greater(eth)) {
> +				txd->txd5 = 0;
> +				txd->txd6 = 0;
> +				txd->txd7 = 0;
> +				txd->txd8 = 0;
> +			}

This block of change was a bit hard to understand what was going on, but
I think I get the result is that you end up allocating different set of
scratch_head per size vs the original only having one scratch_head per
device?

Perhaps you can explain, but we're now allocating a bunch of different
scratch_head pointers.. However, in the patch, the only places that we
modify scratch_head appear to be the allocation path and the free path..
but I can't seem to understand how that would impact the users of
scratch head? I guess it changes the dma_addr which then changes the txd
values we program?

Ok.

I sort of understand whats going on here, but it was a fair bit to fully
grok this flow.

Overall, I'm no expert on the part or DMA here, but:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

