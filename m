Return-Path: <netdev+bounces-232183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7868C022CF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D953AE808
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA76033B968;
	Thu, 23 Oct 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFNWUukR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C382FD1DA
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233760; cv=fail; b=OT+rNrq0/zijaFnFQqH7mAosvbE3c8kvpt1nan8g9HMLwjkEM7VtpaGWvkjQcUA73zTdXp/04l0iUidApEkygnJJbN4XJ4S6JxR5BWsR9BBf9BRky7F552mtwM76VBzwshZkyPb6YKsEbPe7Wqjm5Bz6iOOdh8kM7ot3TtlJp68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233760; c=relaxed/simple;
	bh=GOTUhmrpUq74RpXdtC22EnmOwF8OEaiMFTaLTLXs72g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GiIgIS+5AorrouOMcbUiasO0pYltTwOMVpRHSZGs5ApPYM1WWYVi1TvhSwp2jp/JbpmVoFZ+HriqPIFDYz1b9tTZZ4svb5VmqIiyT4xGoO9HlNOWvUkpbJKCdUJbDRV/nvoBBVhg/FPifNLi0Xl34x2nSPMBRQL+1xSx7omK7Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFNWUukR; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761233759; x=1792769759;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GOTUhmrpUq74RpXdtC22EnmOwF8OEaiMFTaLTLXs72g=;
  b=VFNWUukRhrBY0k5r+GMW1ErDXmrcHNmSgus8AsGjlwQND2HSbe5Y5JoR
   F6ry+Byn5NJWWlrXIbxsx+ZjWD2jFL+vZVcCT01VXWv/JfAAcKhbiXUrz
   NNPOe4+G3w9F/G8ROzU408hpUKRPtbfelsT//4iRjvQAyW2HP//aXsUFc
   H2PGG9UtWjrIRgo+g9+oGKiQmmscSQgnwIT9bKdjM5UjK96KsPUNtct4d
   dNCIXiahK1vV2agc3S3yOE4ggwpD2MAtVSj8kfnJW3SU6nenRRf0SYVhe
   iV2AsAqmhrlaGnbBG6Fwlf79stgdxCQxqwrE6iEhinI4ziEK+rjSN+AhU
   g==;
X-CSE-ConnectionGUID: vAMVTUX8QYe/dPjSBVuFow==
X-CSE-MsgGUID: f/bBJEmuRqyaPzQbFicYRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88873807"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="88873807"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 08:35:58 -0700
X-CSE-ConnectionGUID: L7fHOUOUSfORK0vnvU2gWg==
X-CSE-MsgGUID: hIKMqtu5Q2eH0QuWLuQ9PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="189447376"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 08:35:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 08:35:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 08:35:57 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 08:35:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tg530XUryRpDFGxBkAl5alt8l+bMGAC7lUVP1SDt8YA5BjopCTjiG+JVJju1OwO2vMmAMRHgL9NW9xNCI40B+YJeEEZ0tg6srynXX/p/bg4VNhU9OAvlED6LJ0ONOXKcj2yQk1RoruKYpBr/RCigph+6caQ7qY1SMgECugcfeq9CWtVs/EcLceK1COhBIXIZhFQPJztE71l/HmxFsT6SC4d8YEZORyoBmDKKs2iATDYTjNJqGJ9xQw6gQJLdESTAYt6zAfGROxSPdefDPO0Q8OO92ZjaxfrIuQ+TEG3tq34aiPBsLtX4Z9V6EEN1MKiEu/7BmMHsJS8HidgYh8Cr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmMulRHe3TVGUMBoxzzUugVmtQrNHpcD0paz3nwjHbQ=;
 b=gTs3unipc4ofwk2UHw1QjpS9mtTeB81bk3yzo5qgZupHIJ85Q+hK1t6wpHF/u9SLQ6O3J4eBsC8CLt221mfVkKyYgwnpPYONwXcR4tCbiAc7MkaF41JT+R7QctMSWPfYljDl8yp7W1K6/lKhmX6MpdkB9baJ5yxyPQ744ysWaXdrekV+8GulJxdKfrnm0IGvdSotgDXvRnG8WCWaKxkIIdurlNHsW8xTcNVzK/NVQrkUwKYzYkmgzzBdTkbkJT5FzoLS7PJ6PDVSBshzsJnIpdxHLN215MMr0MjO6s7VMyUItfNt0Cw4FljIAdeIg4gzbUd1vYp8O4TNrDq1oJ82Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB8350.namprd11.prod.outlook.com (2603:10b6:806:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 15:35:49 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:35:48 +0000
Message-ID: <bdee4945-b299-4557-b83e-b62d9c387a94@intel.com>
Date: Thu, 23 Oct 2025 17:35:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 1/2] idpf: correct queue
 index in Rx allocation error messages
To: Alok Tiwari <alok.a.tiwari@oracle.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<alok.a.tiwarilinux@gmail.com>
References: <20251023132507.1102549-1-alok.a.tiwari@oracle.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251023132507.1102549-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0283.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a397de-e5d5-4d51-71c7-08de1249d727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmE0V0dPMXRGVWl3U09DSXVIQ3RVWGNJU0g5bWVYVHU5OGxORlJ5WXZWMU1V?=
 =?utf-8?B?eThTZUhZekIwNlRjeW1NelNHZHJvUWVob08rVjRPbjdHeTFGN0prOHRzVitG?=
 =?utf-8?B?VkJUUU5yZ0ZNa3o5clFaQUtSTU1zZHBOWEFVWFFqeWtVQ2o2MnF6Wk01Tisy?=
 =?utf-8?B?cGlhUXdxcjlmdDIrVDJUL1MxN3RkMlM1OUkwblZTZjVibDlwY2o3WmFjNUsy?=
 =?utf-8?B?ZG9DY1cvRE4zaXhEOEh0NzB6cUhzemNOenJnOHl0eUJEa2ZKdUV0RUZBM1BH?=
 =?utf-8?B?YUtUelB4Y09XRVN3VzRuOSthRHFDcjlGMUJFdDI3WFAwbHcySVNYUU5GRHYw?=
 =?utf-8?B?dlRldUxLS2wrRzRwV0Z5Z3V6ZFdQZlVBQm9NcEF3WWluNE1LYUJpUVViOVg2?=
 =?utf-8?B?dnRveVpLS05HeEJRM1BQaTJVSkFLeW42Uk5yU0dhcFdoamdJRTVVb0syQzhm?=
 =?utf-8?B?ZmlGaC9NQjJ0MmlibzJoSzY4UEJFbU9yVUlnZS9JVVdGb2Y0bm1OdEovbzJD?=
 =?utf-8?B?SjJ0eS94eDY3YkYyNVNQSE9PajdOV2o1V0lhanBTVXdNbVJtT0wzNFprbkth?=
 =?utf-8?B?akhPRnNYRkpLcGI4VE5OZ09Xdi91SjZmVERPTWFoQmxYN3dVdTJlRGptSHJR?=
 =?utf-8?B?MUNUeUlDV0FNL0poS0hoZy82MjBoMlVYaXN5RllpalZZdVF0TWV0UmhnUThi?=
 =?utf-8?B?WGVQc0tibFdsWGo3YkNVMmpkUWkxWUNyU1RsRmY2Tmp2QzQyTDRqSEJpL3Y2?=
 =?utf-8?B?S2ZSakMxNW8wS0cwTklmOEl2S2RuYkNJY3E1S1JPQUh2T3cweUVBL2FJMkpv?=
 =?utf-8?B?enRQRlJZVWVKVkkrOWt1T1FpM0lyTnNlbmN4b3lkV0FFS3RNYzNSZWxKQTdm?=
 =?utf-8?B?cW9aM3BQWEFUT051OUo0T0R0anE2TjhHd2tRM0JPRHFNT3NlVWxsY2MxRS9r?=
 =?utf-8?B?MG1MMmtjOTBmSXZzZWVLK0dCYlZReHF3STk2L1JRN08zSVFyNmdlZWpwS0JI?=
 =?utf-8?B?aVY0N243VGZIM1B4a0FLdUUvS1BhNUFLam5vS09vRjh0Lzd3eGloN1ZWOWsx?=
 =?utf-8?B?ZjVpR2Q2WWZUSXZaMGd0Mk5LUFZ0aDhBS1ZsYkpaSm1RemxsTHRJSDhHcjRU?=
 =?utf-8?B?NVE1V3k2WEUvY0pscGl0SzRJYlJMRVpYWnY0aE1NeXhwRnh2T1Npai9WeFh5?=
 =?utf-8?B?ZTN0VGZLajlFWTFTQUZPRkpzWXdMckVEcTdVMHM1NWQ5R2xNbTQ2TE1zOVR3?=
 =?utf-8?B?Q3FyYVZjcUdZb0tpaFdvRTB5UTk4S24xTHRZanJiSHErYWFnQnFOWlBTUGQ0?=
 =?utf-8?B?ckhwWDB0d0tVcjN3R3VqNnpIcC8wZmVCbmQ4SGRMYTJXaG84V2FwZXJxTHlY?=
 =?utf-8?B?NjVKUEVQZHdHRmxJdWhQVFA2NUlEVVgvb2JqcUhab25aVjhsWDBaRWVSSXB6?=
 =?utf-8?B?eURuem1qQXdKQSt2UGNjUk12QUd5Y1RBMDBPcHduRngvM3lUTXliTUJsb1Zu?=
 =?utf-8?B?ZzA2VEJrMDJoRHlIMDdhdXQxbUt4b2RIM1lHY3lHZmNqZnAwQ3Z0WTJUcUYz?=
 =?utf-8?B?NEtPRE5ueXVXaEcyWVZ3bDBxd3ZaSFNNaGxSblpvNmFKRWsxRHd6N3l3RzI4?=
 =?utf-8?B?dGVhZXVFSFMzMWVEdkwrSHRqM1lGbFZ4MHRXcFBZcmNEZkFIL2pGYk1JZ21T?=
 =?utf-8?B?QzJ6NzcrRHd4bGZrZ2hLOFM3MCtOUUE3WHRKRFdqQ01nZGRDT2wyYi9xYm5K?=
 =?utf-8?B?Yk1kRFNGU0xuaUFaaWsyMk5Kd2Z2OGE5UWVVRTRVejN3eTJCcVBybFpySTNp?=
 =?utf-8?B?VmhKeWpxNWJVN04yQmZudnd5WDFVZXYzaXBqdUpJRUNaL2RKV0J6V0VUWXc1?=
 =?utf-8?B?SnhUVFkyT3dhTnNaakdmNmFBSFllbkwxb1VBalJTV2RzSXRlVXNMZ2xCM3U5?=
 =?utf-8?Q?pwuTPiAmO4Y/7ExSQyspfOT9Gir8OMVl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2l3M3NUQmo5cmpGSXJaSWRoYWlpVWJxUmxYWU10bTB5TjhkOVJxTW9XdURh?=
 =?utf-8?B?MHRXM3hoTkdNZFJTUS96NVFKdGNXTm90Mk1CSWtrekFEODNCWVhTck9FNElq?=
 =?utf-8?B?SFE0cGZkRWVNSXlmMWxFVzF4MnlZN1pWYTJ3THJ6VVF3T2lOOHRPVmZzOGtt?=
 =?utf-8?B?WW5SdGFoNlBuZU1HVTZJWjhJcHhrQ3gwdmZsdmU4emZ1THFzbFRMaGNDdjJT?=
 =?utf-8?B?Y0ZCRTZFM3ZTOFlGMTMxVjAyUzdYWmV5TllycE1sUTU1TEdza3hrMlFNTEgw?=
 =?utf-8?B?YTJGMWxnMUVUaGIrOHJRa2RRdDlETkNibzhUTUNXekRNcjFWajlNbnl0ODZZ?=
 =?utf-8?B?MXFpNEg0Mk9ZYVYxNXo0VkNwVkRmU1pWVkxDK3JPdHdMN1g3ZU8yRmhuYUZS?=
 =?utf-8?B?SGxEZndXSXhSMEZDMDR1eGdmTWZ6c0w0NzllRUFLbzM5N1dib09Ucnc5ZG5Q?=
 =?utf-8?B?ckF1emgrZ05MK1dra1o5R29Ic2dvWFNNZEZEWllBSXZoOXZEdHpyQmdFZU1y?=
 =?utf-8?B?SDViQWpHdlhRN1M5RTVkandaNlZmWHhiKzJVSmpBK3B2TFhrRGIwUlFkYUhh?=
 =?utf-8?B?ajZmWUY1c09XcnV5MFQ4bkRzek5NcHljSTdqRkxzZnBKd0tOQ3RvWXJHbTRi?=
 =?utf-8?B?RTFKZUlTTllMclNXRzl4czkzN1lVcHVyM0k4U2J2cjJwdVF0TlV6dE1ieW93?=
 =?utf-8?B?RFRYWll4QW56ajJVUDg1ektBU1VwTmlDSGJuUCswZkkwVS92ZnNlSFdiN3VV?=
 =?utf-8?B?R21TZmxZRVRyRzNjTUxmU2FtZlJvcUpZTWNTUmxJZVRvd3dORWthenZJY1g0?=
 =?utf-8?B?U2hCamV0UjBUb1RRK3pPR0p1VHVHUk9BQURTTUxPaWNlTmxWazRRN1drb08w?=
 =?utf-8?B?QUx5VXBuTHlaUndMazA0YTlGOHB3dkVadEphU2xXZHB5R0p0MHoyYWo5S2k4?=
 =?utf-8?B?NTA5aXJnRjI4OUlISGV6a2loSVQ1YWt4WWxDVGFrYWxDVTBpbGR3Y3BrL0dv?=
 =?utf-8?B?VXNtNjNnWGpja1I3dTFBcDBiMG5OdWRJaFV6TEI5ejZFT0xRcGR4VnRua2Yr?=
 =?utf-8?B?V25yWEN0eWpKeEJzQzVQN2RGWG9kTStuUnY1aWgvRndEeGdaVlpqU3NJdHA5?=
 =?utf-8?B?b24xaDFMRXJTT0dMU2NOU3d0RVQwc2xrdURaZHk0VVdnbjZZTTdibHJFMW53?=
 =?utf-8?B?dTJZS0x6OEtNRHJCL3dPR1VIZmp1dWZRc0J5M2kweUxSQjltQlUrcityY3Bv?=
 =?utf-8?B?bHVkWVVmc0ZIbE1KbXZEQ2lxQjFDMHp4bWorS3BJcTVnZnVyaDBmRDdBZndw?=
 =?utf-8?B?cU5IVnk0NC90ZXJZQnZjOFA5djNXVjl4TGJoY2dad2xyNUkyTXVCbXZrN0ND?=
 =?utf-8?B?UndnMTRlSElNNmx2Z3BDcVpFMyt0bmczM2ZrMG1aWWJ4QXJvRk1Mc2paZ2Jj?=
 =?utf-8?B?U295RHB2K0dvb1R5MzNSYVNUSXNGbHdjeVdKUmUrUjVDR2QxcWZVZzlrV05w?=
 =?utf-8?B?Q0tVYVNWY1dEOUZWNFYvVDNIdkQ0S3FhYlBRWVBSdWRvcEs1M1JxZmlCTjRq?=
 =?utf-8?B?MDZ2ZW5kQ2ZURkRmVVpzUUQzbHpmelNtZmJvODd0MC9LVXB2KzBRQzdUUFNW?=
 =?utf-8?B?ckd1dG5peVhtNXRhcGxKemFLY0w3N0tiVEJ0SGliMC9OdWwwQ1VORktEZmpa?=
 =?utf-8?B?NWRzaHFrT0hhZGhsNVlTeXNQUHNmNG1PR3FOMzRkaloySDVQd2xMUEhxUUxS?=
 =?utf-8?B?RVdrenpkMWFsLzFLYk1nKyt0dW5icTZXcVcrSnk0bGpBOUdpYVV3Yjd6M0hS?=
 =?utf-8?B?UnZxOWFVNzI1K01lNE9MVEdid1BWY2YxdC9DN3pzOGk2Nit0NmZFNHN0bDNT?=
 =?utf-8?B?UmplQ2pkU1ZXbzdQTittTkNERTF6UjI2UkszcjFCZ1hQNzU3UTc0czFCYzhr?=
 =?utf-8?B?dUFYaHp2V3hyZ1FoeVJLZTlKejZXZHhiMG5SVG5naGNmQUNvT05XZVBLUzAv?=
 =?utf-8?B?cVljWjh1S0x4NklJYllZR3lIUzJDNU9EbnF6clIvVmdMYWNjRHAxZy9zc3k4?=
 =?utf-8?B?bVJWWmk1TzNkYkVIcWU5NWl4VUplMGRXNnQzbUdpLzNSMGJ5blF1TWFoTzFl?=
 =?utf-8?B?cHBmV3NXUW8xWU9QM0FFeWpNMk1XeFFpaE1udUJEeTF5VDNDZDJJcldhdmZH?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a397de-e5d5-4d51-71c7-08de1249d727
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:35:48.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8rvDnz7Posn/J2N0UlCVXHmFUVcoYZYf5VyWuBi4Ojuad0hoTSsh8dmsvIeVxlJ+OwkL5QeN8Ymhaxnwx5oK0Wsdfvi7v8+xAEpI/sfTSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8350
X-OriginatorOrg: intel.com

From: Alok Tiwari <alok.a.tiwari@oracle.com>
Date: Thu, 23 Oct 2025 06:25:02 -0700

> The error messages in idpf_rx_desc_alloc_all() used the group index i
> when reporting memory allocation failures for individual Rx and Rx buffer
> queues. The correct index to report is j, which represents the specific
> queue within the group.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v1 -> v2
> no change only added Reviewed-by:
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 828f7c444d30..e29fc5f4012f 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -923,7 +923,7 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
>  			if (err) {
>  				pci_err(vport->adapter->pdev,
>  					"Memory allocation for Rx Queue %u failed\n",
> -					i);
> +					j);
>  				goto err_out;
>  			}
>  		}
> @@ -940,7 +940,7 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
>  			if (err) {
>  				pci_err(vport->adapter->pdev,
>  					"Memory allocation for Rx Buffer Queue %u failed\n",
> -					i);
> +					j);
>  				goto err_out;

Both are not valid.

@i is the index of the queue group. @j is the index of the queue
*inside* this queue group.
Since one queue group can contain only one Rx queue and 2 buffer queues,
these pci_err() would only print "Rx queue 0" and "Rx Buffer Queue 0/1",
which is even less useful than before.

If you want to "fix" this, you can print rxq->idx for Rx queues and
`(i * vport->num_bufqs_per_qgrp) + j` for buffer queues. This would
at least print unique index for each queue.

Alternatively, expand the message to something like:

"Memory allocation for Rx queue %u from queue group %u failed\n", j, i);

(same for buffer queues)

>  			}
>  		}

Thanks,
Olek

