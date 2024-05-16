Return-Path: <netdev+bounces-96775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A898C7B09
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 19:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2241F21D91
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ED21553AA;
	Thu, 16 May 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjnZTHhT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3A1E519
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880075; cv=fail; b=V/Xg3BrBkmE2qN1xFYVM/v1Ltfz3oLbuf+uOxhFkks/vn15jkHGNAY8femIiGtgw4v4hwxCDiOQ4g5bD9nESoJi6Of1ztS3UFdr58f7ZDQwl30y3x/vbXqKdh5PDtCoQ6rYAwqod3VQxMyG7IcndMYRAK7TfkuU0RIBoQRYdK2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880075; c=relaxed/simple;
	bh=mdJhj0bvpa7zWPMuSPYKzG+wj6Rc8sVGp1J4+WYe96Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tk3OaHk0tG5gOLUxTX4KHr5MdVPAPq1g1fXeDXmimvGliIGk276F7fWikWlp05QWI2tskuul2OfAJflUT0hP4fvJLuKZ5uAy0Q64s5yQ7Gbc6/a6h7Bv05v/4WjNOQFGlvVvlQzL9Q+WiWEqGP9kPoFUbjfWOD9D1ODABRxP9+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjnZTHhT; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715880073; x=1747416073;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mdJhj0bvpa7zWPMuSPYKzG+wj6Rc8sVGp1J4+WYe96Y=;
  b=MjnZTHhTXfmLb+DIk1kmlQ64rfNqVwxv8w6iXnE8vUE4HgzBOcau5HK5
   8VuEeApTF6GB4LiOJrMVKxCquQO+ErR2jmum4gfFAxSPF5BSv1fmwdFar
   WeM0TGnnDU+qcXyH6qHQap7g9QFjDyLhjtupt235MNSjeC1csJ80BrOcV
   u2SUjvOoRPjx5qHKtYtBe6kdFpplgwn3kmC+Iy1TUllCKJyA6VOb1ySux
   3B6KJDn0WQZibsFNX4E2VPGuRmMb9Syns24cyY/au/sopMVNcpCdQ4Zs0
   vkIg1Aw8EWK/A99UxkIRuAPkkLHoFvQeibMLbBYkJYSIxgt4v5cTd1Xdi
   A==;
X-CSE-ConnectionGUID: NfaGnSKeQn6g5VTno8dXRQ==
X-CSE-MsgGUID: 1s14X7ZNTXi0zId1BMOAcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="37391298"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="37391298"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 10:21:12 -0700
X-CSE-ConnectionGUID: auJu4VKnQZ+1gQLZED4LtQ==
X-CSE-MsgGUID: bFXj5tb2RAyNXKGJUUFMyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="36278258"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 10:21:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 10:21:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 10:21:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 10:21:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdh3zfsnVRj6AB9mAneTEDBLYVuqDV7M7Qt6x3v0YYpomylmfAOGYmho4OQnJ5CWAfYXGJgHxkox2lgENKL5ce70XG0thMnHwhy3DC5xpNTgTHjmv+iawixUmzXBs2dti7xwYgRtvaiTNHlMN85CqlRj4rE5gR437wiEtkq+tOZnj3QlEKKb4u8fPE4upB86tf/BoqvaPu9RrHbmimB84QDfU8vHs8B1BESrF0HmyM+IldaB6bq/UihEtps6sv1v9Lg4HJcCrDxdV6SYOS7PA2VIvHE7l3Zzzk58J9TFcLqOSTz0om/+eBrLH69DCjkHpiBND8okarJ1qKkH5TVLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mDTUjGMpA7bK6akjNQQwg3A1RMcGqj1/ls9c7lq8Lg=;
 b=fX4ENg3HxLF1T10TfeYB/pRo5Y0JT1KtOJfzGATgbz4G91EvLAXOEAQXjAswOrg5O2K5Ck/7Fqcdk0xnjeZDpDT7bNNSP10AantYweSs7UULBsh9+Wjstl/oOkyR01dDfej7zl6I7G3R34LjVn77RM0UJJrrofRexuE+/2JbguwbiccHVfOUsvllRCmc90HODSr/hGMcMpAE166peY73XuywIlfC40VVhThQbgZVlPbc90BULfZ355U5X3W8QlgXWLSMvhQQbdmSrklTuRRIDDD2T2E5wTVb2L++c8mpBLyN9BXQmitkT8Dm5DmrThAk0Oy5idOl3lf5lNiSCpI4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 17:21:09 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 17:21:09 +0000
Message-ID: <61d1e671-820d-4afd-ae90-887d302f1be2@intel.com>
Date: Thu, 16 May 2024 10:21:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] intel: Interpret .set_channels() input
 differently
To: Larysa Zaremba <larysa.zaremba@intel.com>, netdev <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Chandan Kumar Rout
	<chandanx.rout@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Igor Bagnucki <igor.bagnucki@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>, Simon Horman
	<horms@kernel.org>
References: <20240514-iwl-net-2024-05-14-set-channels-fixes-v1-0-eb18d88e30c3@intel.com>
 <ZkXHdy6bKGUhIJfO@lzaremba-mobl.ger.corp.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZkXHdy6bKGUhIJfO@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: dab67d46-86d6-410e-7f28-08dc75cc9390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWE1Ykp6cDhaYmRCblhETERaQ0VjWDRNZjFaRm9ad1ZxRDdBSi9yZy9rVVhO?=
 =?utf-8?B?WnNZVzJTb21xV2ZzT2JCZitFcnpETlhEWTZtU2xIbFdzdFdVWFlGTkh0Mkta?=
 =?utf-8?B?RnlGUis0WUhzemU0VER0aXRpVHlvcnltaTdWKzdWODg2STBrV2g1QkdnaWY3?=
 =?utf-8?B?cjl0c1d5KzVTbDNQSkZkakoxYVJ3Z3J1M0hLWGp0WjY4UlAyY0t6bmdOVUhx?=
 =?utf-8?B?em43Vm9SajdMMk9VeGZ0UXNvM3IvRFQvWnEvVDQwNXQ3NVRXUG11ZU05QjRi?=
 =?utf-8?B?bWlxaG5pK2J5aG53M0xSRE1idEYyRm1DYmVoYkt4b2RjOEg2U3EwTmRWTm96?=
 =?utf-8?B?TWs5cUJPNk9UTEwrQkE4TkpTMDV5U3FkUnZjSGNGU3RLUWFHQUVidXJXbnZy?=
 =?utf-8?B?ek1wOTlOelQycDl2WnBMR3FOT045bCtXNWd6ekxQOGViTmdJRVBYbVFqaVJ5?=
 =?utf-8?B?WkUrZjh2YkVzSXZFMFE0QmsybUFqL2tvenF0L05hdmlUV1pGdXZIcURSSFll?=
 =?utf-8?B?Tkl6aUd1WHZZcXcrZDZOZFczNzR3UjB3SXVUeVVLRGNFYk5CbHY2NnR5UzhQ?=
 =?utf-8?B?Tlp4dWtIYjNmeVIzTTM5ejZLS2ZRTlc3d3FxWEV4ODFUK21XbzZON1ZCYTli?=
 =?utf-8?B?cFFiRElReVo0OGxzNG9TSkN1SmJPQTRQWnlmQ1FpeVF1NnEzdVRtVm1mWjlG?=
 =?utf-8?B?d08zTVNpNlJkcDEybnoyNWhSRlFoM1RoLzNBS1lRL3JHcEdsRzdkSGxwVElU?=
 =?utf-8?B?d0pxUWtGREZ4clVqR1B3MFJkaEZNc21PL2R2ZmRCWUx1ZjhGMUtja25MZTdQ?=
 =?utf-8?B?cWJncDZ1a1hZZzVhVVpJeEcvSTZMZEYvOGRldkpTK2ZyeVZ0bkRaTmhIMFc3?=
 =?utf-8?B?ZGpLUk5oYXpDb3RMcTZXci93Ylp1SzVkMDlmMi9DRDczY1hVOE1XRVkxN3Ji?=
 =?utf-8?B?SHppbmNwTmxydVpCcFBCVGdTV0o2UjBpUlI3TGxuU3lpNDM3U1dwdFZaMWZY?=
 =?utf-8?B?UEs2anBlMEtiVHRvVC8wcDhXMHdaMFdTV1FzQWFHNGFnVzFWMkhPSHFCS0xw?=
 =?utf-8?B?TndzSXlGNC9IQWswdXhoN25xZG1xUk8rVk5MVTliVUdrdzBmVFp2QTU5TXBm?=
 =?utf-8?B?dkJxdGVwelM5T2xOaWF5SHg3SjVuazBySXRBaUNUZDVsQ1hTSjIyREtqS1lJ?=
 =?utf-8?B?YUNhWlpRaUVFQ25iSVhheW1VRDZYWXlJK1BLMDdHcHJwRFFWVGxzMDFuMkMx?=
 =?utf-8?B?NjNLb2Z5RFNueG8yeEJGWXNXSkVQRmM2K2tnUTlrd0toWE9PMGVLRFpDUGRh?=
 =?utf-8?B?Wi82Z1V6Rm5jU0lLalhtOFg3b1pXU2Z1R1lBeFFKQkI1RWdFUHM5WVhyVVN2?=
 =?utf-8?B?NFFEQW5tTFhHMnF3QnFBWGdQQzZSdlNjQmhBWmFMVktrMkRSK2RTMTRMbjR5?=
 =?utf-8?B?NXlUSXpPVFo0QXBLQjFqYVpGaHRLa055bVpXb2kxUGhuN1U3OCtlR1dRSjF5?=
 =?utf-8?B?VDZUcm9WUHNPcjZZMHB6UTdCTmxCM1NPOHdmSEpSc2dlNWFpZldUWUdzaUlo?=
 =?utf-8?B?WFdqY0Z6eVVxS1hwWHR0aUx3bDVoOWx0K2lHRmNMNnNzelpXZ0diR3RBMnlk?=
 =?utf-8?B?K0NyendmaUxUMzF2QTBSNm1KaUhzcnEwN2Y4T1Vudnl1Mkw1M0FNWUlPQkdW?=
 =?utf-8?B?aS9LeWVxNEo4eUFTOTcxYy90UnEvMU5mME4rWFNhNUpHRjgvRVZqcXJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkFIZ0pkTWYzT0UwbG5DYzYyOFYzZXN5TjFIMDZqTEtwQkk4S05XU2xub3lh?=
 =?utf-8?B?eHhmODQxLy9OcGk3OUlFMmdGSHhzNzVpMENkYkhkYzZVeWdFdWFqRjkrQ1Vn?=
 =?utf-8?B?dExpSFdFQTZsZ3hjcGMxWG40VVorWHU1MjZTMUJmb0RPbjRQMjM3VWFXSnFE?=
 =?utf-8?B?YXMrbmEyRUd0blAxZlJkS2lHR21lRFV3T3J0SGIvWE0zZU9vempzTHRQODZP?=
 =?utf-8?B?YWpxOHJ3d0pvcm8xajUwRS9zSCtrcFJxcEtTbkVlTWdVblN2dmEzbGQxSSti?=
 =?utf-8?B?RDFUM1pBTTZRMHV6dUNnRUgyWWh0SHdKTXpwcUVOVGNYOVhQNDlYbnhJWWZ3?=
 =?utf-8?B?UGp2aGQ5dHJMRk1KSENuRlJucUkxWHY2YmdCL2hXbFdRdFlxQlk1OHlaQk9H?=
 =?utf-8?B?Q3NVS09IRTBMa2tyRVF0blJrV0NQek8yK3RpNmhNczMxVGtqZmNqSzJyN2hk?=
 =?utf-8?B?K2tmS2dZKysvWHA3anV4Q3hWL1RsRVJyMW4vS3c1REJtZ1REYXlwWDRXM3dT?=
 =?utf-8?B?TTJhTEF0NFFkWVBDYUhIem5nMVhOY00xNy92S09Ja0VSM0kxKzZOV3RMaHVP?=
 =?utf-8?B?WTN6TnRpTUNSK0NYTTZiODJ5MXpucmlhM0I4clhXL2ZDU25qbzZpY2ZqME95?=
 =?utf-8?B?eTNOVXdiVGdkL2J3dkJrVTloVFg4WCtWQ3YzYVNvS3hDRkxKaHFNMmExWGM2?=
 =?utf-8?B?WG92cnNnejJjRHp5bldIL3E4QmZqMTVuUlYxUitmeGRBdHRSMy8zRCtrWWtx?=
 =?utf-8?B?YlNXTGQwcE9Ed293Y0VtclJubDlLT0tISENncFFMNFJybnlReU9CQ3hxZ3dk?=
 =?utf-8?B?S0hrTURjOG1hTjlNSU1mWDA3bXRobU41Mkd2eUJkZVhLNUlZcDUrOGxmQU5D?=
 =?utf-8?B?ZW1mbTlva3FiY1FUK0xSTnlQQnpCZHJ5YTExSDVnMlFMWWpEWVhRNHkvaUJZ?=
 =?utf-8?B?RTlmMi80a091MFRQaDFPcUFocWhXRjJmbSszTUhUSWtMYjltbVJ5c1BXSlFG?=
 =?utf-8?B?YVYxZW45UjlzdlZMUGM2SmdZYnQvOFNFZFpCRnMzMW81cGthdG1mNVoyL2dw?=
 =?utf-8?B?ZWdBNUNZY25UUFM4Vk9RN3lHS0dZTFc0aGw4U2xIOVdybDZLUDBSbnVZRHIw?=
 =?utf-8?B?SDFHbVZPZHU2L2hPcGRXWi9uaUNtYnhtTmxneXp2VUVlWFdOQ0dPL1kxUDBt?=
 =?utf-8?B?emlsd1J5YlJib0l4M01kbWsxY0JkM01SejMwRjhSZWp3eU5hOUVwbWo1ekFL?=
 =?utf-8?B?c0xPdVNMbFZpK2RqZCtlTWlkNWI2TlRHS1BNOGNDUkQzeHFrRmdCN2NiVDJ5?=
 =?utf-8?B?alZPaXd2TDgrNWZQL2dCMFBQamJ5UzlwZ2xITzRJbWoycjdPd1dOUEhicW90?=
 =?utf-8?B?K2JURitTMHhEd1c2RkhLaUZhd0h4WXZEa3U2MVFoZnYyWVNHR1hTLythUExk?=
 =?utf-8?B?Qi9hMEpLQzcrTm1aOHMwSWhWMDluSkNoU2V4eksySlhRTUpBRlJmei9hc1Bo?=
 =?utf-8?B?eWJDQ0NQaXVzY0RLRm93d0VKQU9oVjRnYlA0a0dLLzV4WWY3SW1ML28vc21l?=
 =?utf-8?B?bkdxYzRUbFBJaVdxN2g1ejN3QUVIL2pubWxidjhocFRVL3NwVXpsTjhMUTc3?=
 =?utf-8?B?aFNzeWNzYklwYlVRNEllVStNbUVVZm5pUzVzZ200TXFObHQwS3FyOEdIVklv?=
 =?utf-8?B?ZFIvKzlLU0xTM1NJMEoydncrVCt2TDVsVUNQWEloUzdiY3FVbHc3Q0E0aGZR?=
 =?utf-8?B?SDFJOG1FZUVWcVNQenBPK1lBaXRPU2lKUHdVRVB5ekQvWVNlSVRWTndmb20w?=
 =?utf-8?B?SXNpby96bmt2QnNaOFJKeWF2T2RBSStJb01TUWVQMTA2Y1RvU0QzMUVPOFBU?=
 =?utf-8?B?UFc1Y1ZGTjIzcU9sMTIwN3k0MnpuaGVjSlB5WDRFLzZrS0NTZzgvRjByMisv?=
 =?utf-8?B?dWZIN0JQQkZxSzlFV3B5anhZbjFqcEtBbEZ1U1FzRnhQcytCQjRNdVNxY3Vt?=
 =?utf-8?B?NG9DKy9US1BuZE84Si9RNTAzaUdqYnRZS0JITFhBbGlZUWxJVHFmTzJXUWND?=
 =?utf-8?B?clZhTmxEWEdJbmcwVUtRUlI1L3NXZjNqRUoxZGYrVHhFY3ZOMU1nNEtHQjBo?=
 =?utf-8?B?WEVCVjRjRDZNaWpQWG9LZVduTWQyTVYydFZ5MStLb1JKcVFjVmR6LzI3VnVl?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dab67d46-86d6-410e-7f28-08dc75cc9390
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 17:21:09.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/Kt4JBj54Sfoy5vopSEptprZBR17nxxEjtfYT0/V/AOJOu0FTuQtWNxa8KKf68hy0I6OpxB/KWrj9rYjoWNUmz3wcQqsafv3R2lGGLkEtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com



On 5/16/2024 1:44 AM, Larysa Zaremba wrote:
> On Tue, May 14, 2024 at 11:51:11AM -0700, Jacob Keller wrote:
>> The ice and idpf drivers can trigger a crash with AF_XDP due to incorrect
>> interpretation of the asymmetric Tx and Rx parameters in their
>> .set_channels() implementations:
>>
>> 1. ethtool -l <IFNAME> -> combined: 40
>> 2. Attach AF_XDP to queue 30
>> 3. ethtool -L <IFNAME> rx 15 tx 15
>>    combined number is not specified, so command becomes {rx_count = 15,
>>    tx_count = 15, combined_count = 40}.
>> 4. ethnl_set_channels checks, if there are any AF_XDP of queues from the
>>    new (combined_count + rx_count) to the old one, so from 55 to 40, check
>>    does not trigger.
>> 5. the driver interprets `rx 15 tx 15` as 15 combined channels and deletes
>>    the queue that AF_XDP is attached to.
>>
>> This is fundamentally a problem with interpreting a request for asymmetric
>> queues as symmetric combined queues.
>>
>> Fix the ice and idpf drivers to stop interpreting such requests as a
>> request for combined queues. Due to current driver design for both ice and
>> idpf, it is not possible to support requests of the same count of Tx and Rx
>> queues with independent interrupts, (i.e. ethtool -L <IFNAME> rx 15 tx 15)
>> so such requests are now rejected.
>>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
> 
> Please, do not merge, first patch contains a redundant check
> 
> if (!ch->combined_count)
> 
> I will send another version.

I looked at the ethnl_set_channels and was at first confused because
there is no explicit check for just !ch->combined_count. That makes
sense since it was previously possible to just set both tx and rx which
we were incorrectly interpreting as combined channels.

The core code *does* check that we have at least one Tx and one Rx
channel by checking the following conditions:

>         /* ensure there is at least one RX and one TX channel */
>         if (!channels.combined_count && !channels.rx_count)
>                 err_attr = ETHTOOL_A_CHANNELS_RX_COUNT;
>         else if (!channels.combined_count && !channels.tx_count)
>                 err_attr = ETHTOOL_A_CHANNELS_TX_COUNT;
>         else
>                 err_attr = 0;


This combined with our added check in the driver that we can't have both
ch->rx_count and ch->tx_count set, this effectively covers the same test
that ch->combined_count covers, so its unnecessary to waste time
checking it again.

Makes sense.

Thanks,
Jake

