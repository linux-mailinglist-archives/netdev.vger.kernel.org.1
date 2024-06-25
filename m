Return-Path: <netdev+bounces-106367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF04915FD5
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0331F21FBA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 07:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2447A1459F1;
	Tue, 25 Jun 2024 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrzrlG4z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CDF73463
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299889; cv=fail; b=OWSV8yfx+ruJhG1sTmNnoj/1vst5xOIy2nK5HAyN+SoPqjALP3j+7PNtwjucrttfS8UTQz5APY8sndmt+zC3oYnfHO67sF5aMz/lYguPhEz+CwQltsju8W8VRfnFykH4+nYSpWVsHUkM69Ah06yl43L5BjRsoWVRwtuINIdsjgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299889; c=relaxed/simple;
	bh=uGSVBk3Upke9xvHHpv66GV0uW2uUENMn38NojLD4owY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o+Ko9uAudx12grXMWbj2+BoBHEQ00TzfbLz3fKr9ZcPE+YxSEjrWWYWwWhIGQ+L+f0aca9eCjwEcdt7q9l3Wo7HpctvCsS6F/MlVn+ZJi4HpmiS8n5Za0FKcTTob8tWLvduI4nDbNgPkbOufaBkmhh30eLbksbKTtRVqE6tOvMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrzrlG4z; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719299887; x=1750835887;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uGSVBk3Upke9xvHHpv66GV0uW2uUENMn38NojLD4owY=;
  b=VrzrlG4z4vnXPjoUoWn2AmdbSkcZuUypYCsfbNqmt3yqdtQ0enSidhpM
   O+H0XhmhHXfrvisMY1M4/VB7w94LO0cJh+iSLGlbp1EaZ6MjCzV3XFUfL
   Jh0PpV337rXhSlGZgRo1Qd5VKHu9rMiw8YvP7/qXkOFyIMz/YeLBAY6K7
   jYTXn63Yz0tDgQvGZ1RzChTXTQTTYpOerRgc6qVkpJmlEPIHT940UB9g9
   qmMTaBl4xZFuyrYwNfeYojaVxSiJr2wBTotWZwKN8MQ6avDAKZLduWbnh
   iaomQcE8+GKi8tcOSQii9encMc0z88ruGl2VtAbXp6w+S+Pa0P84egQ1k
   A==;
X-CSE-ConnectionGUID: r1gqlR3oR36gdLMABRh14w==
X-CSE-MsgGUID: aS8AJFGEQeuajMaOXnAXZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16445588"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16445588"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 00:18:07 -0700
X-CSE-ConnectionGUID: VjVe472YSx6gD6GjeQn6bw==
X-CSE-MsgGUID: xOvXgRgMTRCdbMyXbnc9Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="47929435"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 00:18:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 00:18:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 00:18:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 00:18:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/3Zz/QhrL6HtM9ep9kn0p8lkBG2jlR0MRnniMcRgKpzt5zY55K2DdGkg6nmDuaVPXf+88acj0fXKNI4uEoYcdgYn255r8k8Aehp9Y9v0ne6RG69KQxIOfRQFvAes1RMqapWvNWkdDxB8URKmBv/Nvb1nYXkUSSch4MS5czlFEZgELx+E7jDRxkjsUsiEN9zITu1gVNcg3YYxBh45Xm7nJBQqbI7lyi1AZPS/UMGI2SkIVALgXStlDs1CSDSjLmpOTQBuTJ8dbsrOH5zuhg3l4UK3tUbM4haBOlfw//Lm9AsZx4Us1lnQRahI0oo1bl1PB56zdS6mXyHRUyVOZtSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e77IQGhEwKKRnGt2cTVyy4fB9MB5xR8v0QOYqPkywDk=;
 b=lg+TUCOYBZY9uiDGA+64iuglQG1rjL2eCh77kPwEfasjv1ck+hbLU69hTVP9Ack3hOcU3O0fEcEn3RyKzN5rkkOtqNhhX6ERLTaJBDM002aps9KNZv8ATue+qXHuHNyp2+bukQciDvyokly8mte1O6vRegPBEXjcMjd0wV0wxeb9M8GQRQrjfZBEXyt0mwo4QcOnEynnw8LVuRz5UgaBUhyQccxhULf3FxLCdGMrGNLjyq6m3wVHdCI47fwhs0q7hvqvjqdpXhwDFq+7kkv1pk7eDtgLB2AT1nQvzp6Y2JqWBH8Bjf2SANQsdX6CbnyB9XnRhrxHnMp9Q8jdebXxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 07:17:58 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:17:57 +0000
Message-ID: <90e2bda8-5f5d-409f-8b4a-b2cd12747c95@intel.com>
Date: Tue, 25 Jun 2024 09:17:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 3/9] net: ethtool: record custom RSS contexts
 in the XArray
To: Edward Cree <ecree.xilinx@gmail.com>, <edward.cree@amd.com>
CC: <linux-net-drivers@amd.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
References: <cover.1718862049.git.ecree.xilinx@gmail.com>
 <e5b4739cd6b2d3324b5c639fa9006f94fc03c255.1718862050.git.ecree.xilinx@gmail.com>
 <ca867437-1533-49d6-a25b-6058e2ee0635@intel.com>
 <08a85083-8c61-8ca5-e860-2b051c043229@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <08a85083-8c61-8ca5-e860-2b051c043229@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:50::18) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8484bf-5138-4cd8-8941-08dc94e6f013
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0VZb1RTM2s2NW5mWkhON1RZeTFRUmVONTNwanhPbDdJcUc5YVRzd2dWaVll?=
 =?utf-8?B?TU9ZejhkSnV4QlMrSHFTNlM1aktIN3lKcDhxTC96NXcyMUI5bHQvUU1vYTB5?=
 =?utf-8?B?dzZRaTQrM01FZnVCSWI3NmRVK1FzbTB3VWZtZjM2akNLMFlnNlBSSk9uOUFm?=
 =?utf-8?B?T0RPUkpwOEg1dlBHQUI4Y3BBbzg4MkdlblZlek5VZW9hSGxuSE9yVHpjaXNZ?=
 =?utf-8?B?YjI1OTJCUWR5S1FreGljdk5Bc2ZlUmFRN3Y2d3g3a3pXM01POGd0Z0V4ckl6?=
 =?utf-8?B?b0NsbVNrWUY0c1VqSU1ENHdSWGlyWkhGMDE0L3paZUJsWWhiNzVFMzF1QmNq?=
 =?utf-8?B?bWlpank5eUNGWHdOLzRSaVZVdHhxY3A1U0RZME1BSC9PaCtwck9WSHVsVXFF?=
 =?utf-8?B?dm1oakpIRkpBSmJudkM0SHQwZWxGak1RU1haaUdmNXQwTlRmLzdvTW5VZUFS?=
 =?utf-8?B?ZmRtU0hWK2oxcnNQWmMwVm1BNmUzd01NYW9xTEV4OXFWL295NzB3MUZXb1Bx?=
 =?utf-8?B?UFFCWUxkaFNsVHZ5RHJQbEt4VFUxSEZFUG5icFhydTFlN3F2UXZxRTFFbmdu?=
 =?utf-8?B?amNsZXh4TDk5Tng3bm1vcVorTHJFWWM4RWI1aFJwbFY0dmF5a0M3enloclAy?=
 =?utf-8?B?SGNzTWRCWklPQlNER0g5MFVhaFlCNkZLZlhrcHVCZGNIR1lKdVJtTVFPNDZm?=
 =?utf-8?B?MUxRbmgxL25sb3pTOXZjRXd3K1I3VGVvdytsSHBickM5a2FFdDJ5cXk3ZXht?=
 =?utf-8?B?SFRwUUljWVEydkkwMHVmYndMVFExYnlzRE5TeE16UmczcS9sY0pULzNydzR6?=
 =?utf-8?B?V2VYWWxkYkNCUkJuS2dFaUxkRVRSVGtLQjNqYi9xNjJFbEMxMzNleFFQeEQ1?=
 =?utf-8?B?SE5TaGZxMzJSOU1sQW1JZHVQYXQ2OGh2Ui90dk9qT3pmV1F2cDhuRnNjWml4?=
 =?utf-8?B?OHBqTzl6SXROenNLOEZobXdtcGg4NmZYOXZQVHlWMGl0S1RpMnJIZy9sUlk5?=
 =?utf-8?B?aVg2Smh1Sjh3RXVVOGt2clJsemUrdTNHZ1pKNjh4T3FDVGJqQlF0dytDMjdy?=
 =?utf-8?B?Q0Z1aktjYzYxdGtiejF4N3A3N0lBdzc5cE8vc0wvWU9oKzByR0huN3FYd0Ev?=
 =?utf-8?B?eW1mYktZbmNodDRuYzduRmt3Q29YeGJwMWgyUzZwV0VnY2NlbEV3TkZ4bkM5?=
 =?utf-8?B?eURBYkVHQXAxL3dTTjlPbU9ObEQ5UmFTVk1pV01HZUpzNC9pUER6S3M2anAw?=
 =?utf-8?B?eHlacHNLcDl1NFVOOGlxMy82NCtNS2s4cFBwbDhIcUdWRk0zWGd6Vm5oZG1r?=
 =?utf-8?B?MENxK2Z5K0ZrRnVIL0hGZC9QUXB5ZmQ5YnQzQnU5ay9sbUhPQ0daempjREZn?=
 =?utf-8?B?NVEzZDRFRTRuRmV4Nkd4Q3RDekZpZkU5UGtGV21TUlBNWktMTi9XUGhkMHQ5?=
 =?utf-8?B?TG9lcmtJVURuMHo0VXhteUJEcDRQYmxPNW90SnlLRFQwcE1zbDBxcGE2MHFy?=
 =?utf-8?B?SzZwZGxvMk41SzQ1M3BIeFBPdUhoWDFmK0U0bSt3ZmVaZ2pPeURLTnFQaEtY?=
 =?utf-8?B?eTQ1RStSeTZFSlhPSG9hd1IySlByaHlSRTZMQjRQTWc2UDBvRzdXYjFCcCtJ?=
 =?utf-8?B?eXBxR3lwWFBTalBpZVYwdS9YNVBBNnZ3VUpZUjg4emxEQTdVV2FVOTdOSmpn?=
 =?utf-8?B?V1IwZkN6V2h3TS9CTENIcDUzWE1MMnRPdG9WbG11V3k4V2lnd25LNkdjeUxO?=
 =?utf-8?Q?S62D6N2ZTbIChyiH2bPF0RQ2gP2QgXzkIuQ6+Rv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0JabGhGRDMrN21TVXNwUXgzNzQyYVhGVmZtcTVuZEtCc1ZXZHZCbUtGNWk2?=
 =?utf-8?B?TDFNRk5kNk5ZYVpaSVJNenRzeWl4ZElzMnB1ZkJSeWhDaE9IcEEzWTUzUzZD?=
 =?utf-8?B?ZDl3VW5VWDI4bHY5WEY1U1VsNzUzZldJL3hZVkJVTTZzakVWQ1kvaDBvSTk4?=
 =?utf-8?B?dk5pbnN1VG5YU3FOV3JyeWYvaWhaa0pHaU1sNXhrTGNRZHBlNW52UU1hRXhr?=
 =?utf-8?B?ZDRIaFpPdGgwNG9QMitvYXNRcHFlYkZDRE1JM3A3SHQzNEZZWit6ajhMY1Ey?=
 =?utf-8?B?cXUxamtCVUMxbWV5MDJHZkdTejNaV3pUZHc5NDZRRGVOYmN5MXRGR25RZkNU?=
 =?utf-8?B?RWQwRFpHc1VxcURKdXJMNTUvNkJIUnJDaHRqc0MwMEdySGUvMjVqRWEwbVBG?=
 =?utf-8?B?d3FXaFlJWitxeXBMMmVwU3Nia3Z4SWYwVnJOZ0V2MHFVSUFqd1MwbjZLQWsy?=
 =?utf-8?B?a2xCZXRkeHlxVExsVzBSRGpyOTFYU2NXNHFpL3RyTUI0Sis0bnZQeU5pcWpS?=
 =?utf-8?B?MVJLakFzdDc0dVNGSW5iM0xoWjMzR21WLzY1VmxQZ2I0dzlXbzlqVnlDNFFC?=
 =?utf-8?B?dE9NcXJRek1UdlJ2cUNsM2IzQW1yRGI5cXFNZUlzTlVORXY2N0NCd3JObVJC?=
 =?utf-8?B?NGhraVhWYU9NTG5VckdiMkIxL05lMHR6cW9HMDJObytwbm1zZTBpdUE2OHll?=
 =?utf-8?B?eDMzK09wUFIrMFdjY3cvNTkvYWx0eFRpRVVqU1Y3TU9YMEZWekpaWWFiSFRL?=
 =?utf-8?B?UVBSbjRBQUhxY1FHV2FVbG9OV3VmelIrUkoxTjVibW5ZVGNZVks3T0YxSkQ0?=
 =?utf-8?B?dWdteEVVcFhHK3V5K29WSzlGUStwT2dwdUtXQVhPNk94YnpyR2FPa2o3WWI4?=
 =?utf-8?B?cjQrVlFJTGs2cjF2aXM3dklOWmF1a1lnN3FMYXo4OHdGTWhzNktLUXpFcHBm?=
 =?utf-8?B?TURITlJsZUQzcTV5OERtUEczcEVtZjArMEkraWxmcjNoNjJUelVlNEttTnh3?=
 =?utf-8?B?T3R0cjMxNW1DdXJaUXFNN0U2UG93YndjVGx5WWFMbUJlaVVQMUFSbzVzdkJG?=
 =?utf-8?B?WHdUT3ZVbFdpc21FcnZoUStSMm5yVHBOdi9FZnRyLzhsSGpUbUtzWEFEaTFK?=
 =?utf-8?B?MWVhSjdIVkdkQTl5ZVB4MTRQenlOVjg1UVhVcS8xK09XMzdGb3I1ekpXMm1k?=
 =?utf-8?B?OGdNMGlVa0xOa0pheHM3OGdkSlE0eHdCOVNBemYrREF4cS9iNzFMdGFkbGRL?=
 =?utf-8?B?bmF3SzMvaHVPUDlSWUcrN1pqeVQ0R2tXTFlOaU05S3RiT1dIQXlHbUhqSXN0?=
 =?utf-8?B?L2szSXNFUXpiKzRkTjdNaGFMK216T00yNUo2VGU4em5JMWhpY0NQUzRkREdY?=
 =?utf-8?B?R1BQZ0F1cHB2ZGk3ZVp6QXR3bEZpcEhPYUE0bkVPakIxMWI3dklubnlhZHg3?=
 =?utf-8?B?cmNHUWhOeHdEeGNwQ0RxbFVLSjZIUDUxTjNJYWdYNi96OXZkcWNGVjZjd09Z?=
 =?utf-8?B?ME1MckRYVHNCeUNFd3RHOVlTUVVwanhONlhHTkp4dzkwcERuYVhqTEczZW45?=
 =?utf-8?B?YXpsK29ZTE1ZZ1hkamVuWHBFdnFpdzEwcjJEWGZuZnhENlNYQ3Q2bzNXT2RX?=
 =?utf-8?B?UmlmRDVaenJ5WDUxRlFaMEZUZHhWQWdubXN2eW1YOXNxS0NoZGZyd0V3bHE0?=
 =?utf-8?B?TDdNK0Q4S3RpVGNnYjhudi9IWmRERC9nSmVBS1RzemJsYnlpYk9RbzVRdjdt?=
 =?utf-8?B?RWc3c29iaE10V1hmbGVCTlFSKzRGeXhjWkE4d3VhNjUwcUN5eW9YaTVaWW9T?=
 =?utf-8?B?SmlHSi9VakxCTGJFS0pqU2VJY1o3QzhkTENSM2sxY2NFeEtHMjVZbURZRG4v?=
 =?utf-8?B?SC9pQVhXeFhvMWpTR3FGU0lQdmhZTHcxSDVOdFBrWGtsS01rbWZWZnV5NVhY?=
 =?utf-8?B?Lzc2UE0zaWp5bVFBbllja25JeXNncDAvZXRVRGlnSC8yVVIrNzBJQ3FleGNB?=
 =?utf-8?B?ekF5MVYxUHBRUy94VWtmUXl6NXowZGRXUjQ0UTNZTWk1S0tHR3FmQWw3WDFP?=
 =?utf-8?B?TG5yeFJpSFdGOTkzUmtQMDc1Q04rYi84TFR4bmw3SVEwUk1zV1RVVDZGNXY3?=
 =?utf-8?B?OVFQZm1RMzdRN0lieWhuMVBoNHZXSnhEa3hmbkFIUjluakJscm1wT001K0dN?=
 =?utf-8?Q?qKpnh9TvkbuCK1tUogL1rmk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8484bf-5138-4cd8-8941-08dc94e6f013
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 07:17:57.7713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPzwX/SxuEJucykv4xQ5VNTyfdkEgsPQGM8bQ1ksK01Oosgs1zmB6mptQdCGHpI+Q8efq+6LR+78EQRMq8947RmEoqEuPi0wrcThZpvqqLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
X-OriginatorOrg: intel.com

On 6/20/24 08:37, Edward Cree wrote:
> On 20/06/2024 07:32, Przemek Kitszel wrote:
>> On 6/20/24 07:47, edward.cree@amd.com wrote:
>>> From: Edward Cree <ecree.xilinx@gmail.com>
>>>
>>> Since drivers are still choosing the context IDs, we have to force the
>>>    XArray to use the ID they've chosen rather than picking one ourselves,
>>>    and handle the case where they give us an ID that's already in use.
>>
>> Q: This is a new API, perhaps you could force adopters to convert to
>> not choosing ID and switching to allocated one?
> 
> Yes, that's exactly what the next patch (#4) does, when it introduces
>   the new API.

Thanks, I noticed it only after reading this patch.

I know that there are is v7 already, but I don't know if you just missed
my other comments to this v6 patch, or they are not relevant after you
answering the first question? (Code is not removed in subsequent patch,
so I guess you just missed).

