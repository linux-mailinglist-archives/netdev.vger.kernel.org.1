Return-Path: <netdev+bounces-258522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJUNHytbjmkjBwEAu9opvQ
	(envelope-from <netdev+bounces-258522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 23:58:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6B131A02
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 23:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4FE1300B533
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6E72E36F3;
	Thu, 12 Feb 2026 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/27AK06"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9261F4613
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770937126; cv=fail; b=kwdQKtHsY4g74WXHGFO+nmGM0buCj3L+RaXhbjzeyDtW3EC4yeSojYkJupXxv6rVYVkfjnuElkON5wxCfIFhO9JE5HBeqtNGuH/HVAR6xV9JbcWfZpjIZDSX2NN2gxgxnxmz5lUv376+sfL86XlI0sol+uUEMGA4VoWhWzmo1Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770937126; c=relaxed/simple;
	bh=QcLTzAB8kBJlyF7JB9Krj6l4GF4sAWrK5qK7JuDzaQg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RZhX8g+O/jLMozdm2Mn7ypBdmuzhDSYcUvezCKP6KsmAg3FkdEnmj7ueZEqWIPxVZWGejKUJX6y3l7QrIZWfkEB5MSSVlO1KA3CFBOSbVQI8+/LyLUHd0vT/sY3pjO/g28jjMXfZBXFYEwyvgwxeLjRq9ZHUiOGzljIQCdpB6eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/27AK06; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770937125; x=1802473125;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QcLTzAB8kBJlyF7JB9Krj6l4GF4sAWrK5qK7JuDzaQg=;
  b=O/27AK064PZe33qEFp2S3uEu4D/1gkQebK0N6mbQ/mfp94OlZgyMTOyQ
   xgrGEXVYTmUMN0XFa6J5rIcxH/kFhPulWBf0DyarScI7LqTOBwAIJKU4I
   Gw6Q6itFTCE2T9EgGemdrFDhfjPRUnyMlkKhXrHsi0u2pwVZgNx2jC8Nl
   LKzqdY5cljdOSSM0pjr1SCfEes6E73nAQLZX8iAA86PgfkoW1Zhmxep5l
   58LYD2/qIVkY7ROSazJoUXfOLjju4nyvz5ufcxfaDkM5yT7PdEbGcJiaJ
   hiO7KUTIUbu/4DyHT6GuObdvNSVp/f9qykVzSnHBjTc9XMuk+qMXMzYTc
   w==;
X-CSE-ConnectionGUID: hq0cl4c2SEOrCiF+Upej1g==
X-CSE-MsgGUID: qoTGt/URQpmn8uajgy3htQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89706571"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="89706571"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:58:44 -0800
X-CSE-ConnectionGUID: 3SgJXoLLSH+XXQ6aHJBTWw==
X-CSE-MsgGUID: IZ9wr74zQt2GGOzjAVEKPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="216931837"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:58:44 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 14:58:43 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 14:58:43 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.26)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 14:58:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEKJZFfr+8xP1O8DOvWe3B59ZDIRXs/NlqwqFSLGjYkYc84whXu4I+wCMDP2U/swbnaNzYqeh0cyfEugMyn5i7qrQNnvZQRIelrNfo5WSez/qEkmVXr6bqtzB0AbJsu4udBnIQmgC+WigDhW3OL2Yr8TsEk4ShSTIBIMlEBl+zG/xo3MESSDKfMk30LE4i7Sd5HnaZ9FdyvdDFjiZtoytXqI0g8bKmpXr07eC8T6/9E6KsuTIBQc7HaH0CvtprE3nV+HaWPzoply+u8OU/r1J2gh8m0VrS2c3QCLmzWbvHt2mKaEw/8rLPhrCjhvu14rOitYzpRDzQeorzVSoQAPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWMT5aDidlWfb1RsCagOXBws2mRsknHn/2fQvL7q6XY=;
 b=qJX5AI19uEl7MRdU1foP5Weaj0bFbtX/3cJ/tE+LyikrJmyItnAe5o+lQKuF3p24zJIrSZ0v33tOFVhparbiMIWLuU8PnfJ7nPRwQJMGzX6SL0cx1osIJ6io1BsAaY1UhVIzRZtujBXlPbFjA5EZkfcjdaaFIzAZSb2XAGVafJDW7Cyi1vxsJkrGvNxQgjHAJ4v2mS8J8s9Zeyz7iaOIlhN1d8NnPNiNJl3tpav7M/SgXOQbvVMvLk2ZLQZsoGtbvfsi+A+ybDYOavTyLLIO4PxUzQeZgZ+oqM2PNqbySQ7+8GLqXBFH/fPtPCE19c7AWjYSlkgI7OgLsUYI74klAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by CYYPR11MB8406.namprd11.prod.outlook.com (2603:10b6:930:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 22:58:41 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%5]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 22:58:41 +0000
Message-ID: <9e476352-e2b6-4a08-b5b9-88ba47bdbcbb@intel.com>
Date: Thu, 12 Feb 2026 14:58:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] myri10ge: replace comma with semicolon to fix
 regression
To: Chen Ni <nichen@iscas.ac.cn>, <kuba@kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <arnd@arndb.de>
References: <20260212055028.3248491-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260212055028.3248491-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0197.namprd04.prod.outlook.com
 (2603:10b6:303:86::22) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|CYYPR11MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 116cedeb-a2a4-4046-61d5-08de6a8a4429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjVNdmp2ekp2N1phVXR1eDd0SHhkdnIrWkovc1AyU3V1SnFYRFdnTGtsd21Z?=
 =?utf-8?B?MXBsOWFFTW8rOFV5UXJsNEVxdjNUYlp3RlNMdFV6eFR6Y2l2cCszWW9yOWVj?=
 =?utf-8?B?Wk9wN0dzNWtqMnJmZE9jTUlqb3hnNDJMUG5ReWt3bUlYME9DOEg2dWczT2tt?=
 =?utf-8?B?SUg1NGVVZWtBNTJ3NGdZVG5qUFlXQzB6MXR4UWVKb3YzTGlTeVFwdmMwKzUr?=
 =?utf-8?B?SW00cHozTUFtNzU3dGtCTjhjaTNEeGMxd05HRkxpQ0RlWmtCK0dyaWxoamln?=
 =?utf-8?B?ZnRUTlY3VVB4Y0Z4c25ldzJIcHQxMHhTL3B5VEUvSlV3UGlPK0w1dEkzWlZO?=
 =?utf-8?B?cklsQlJBSFdtNmhMTDFCZnFqdHdvcHhUY0pJV2U3RzRpODVnRXhXbllqSkJV?=
 =?utf-8?B?TDJPRVU0UlpLdlhWekw2NVdlREs3T0YwRGJLZzk0WG1iOTJyMFNvcE9Kb3Aw?=
 =?utf-8?B?eG9CZWIxMWV5Vnp2Wlc4WXFKaTQ1RytkWmltR0EzZEs1d1o5YnJGbmtUV1lM?=
 =?utf-8?B?dG5RM3I1NEJtZWpCdGFjRGNLaDJDNHpCS0VTcXdHZ2Z6TENQVEpWN0lGQjlE?=
 =?utf-8?B?VXZvaUhzTFVxTHRIbDN2aWtWc01jaEtrSFpBV0JTQm1IVUV3M3daak0zNEFi?=
 =?utf-8?B?N3pxSnU3MkFya2Y4aDVqVUEvZUR4Tll0anVMaC9ramZiV2U1N0NJUTJIMXJ4?=
 =?utf-8?B?bWFiT0NtOE04L003Y2lvcVl1eTliOEVOWHF0WFJoQTR4dTFUSVFudTdxcWs0?=
 =?utf-8?B?NXd1dlovRkdUVVNmRGR3YnhGemxkM3k1OG5xbEl0QU5Hc2xjVTVvbTBoZVdu?=
 =?utf-8?B?eG40eDJmeTE2WFVPVEF0Z2MyM2xSRTd0NXBRVG5Vc1l1UE12eUN5QTFKaGdv?=
 =?utf-8?B?UlpIa3A2VlVOcGpRSFpNUGtGMDlEYlpVWjA5NVh5ZzFnakI2akRRVXJjUEVm?=
 =?utf-8?B?MXphcEY3bzVFclJpaDIxb3l2YkxnWHNMM0RoM2UwOWo5cWh2U2VEcEQzeW1T?=
 =?utf-8?B?MHRERXZLWmtZMmRwVko4ak5uNTRFOGVDRmxnMDBQLzkwMm1WNmx6STJTcFJY?=
 =?utf-8?B?Y0JsNlRlY3dvaGNqaDZ0UVZrRDU0Z21qSnE2dWtwZDhjMjFtRjhxSExWR2Fj?=
 =?utf-8?B?bDNQSjY1ZGY5dVlxeFEyYjY2N3l2bFdlUnowNlBJREpVZTNaRW9nQThvQ3E0?=
 =?utf-8?B?cEROZ3llMWlYSWJyckpMZFAvNnFqYys0TFR4Uzkzd3NtZW9qQWJLb3dhQTRB?=
 =?utf-8?B?Yi9zYW9WSlhLS1dpOVh6QnZHV1ltSXJBT0NJTmVNaTFzdVFuK0tUeHpsMlF4?=
 =?utf-8?B?MkJLV2M3NkRQVG9jbjFXVXpXVFgzT3BOd2ZBUVQrUExOWTdkVGZ6QnNGeW9q?=
 =?utf-8?B?N29YaGg1OWQrNFhwMG5PWHExTlN2bmFLazU2Z21GSGJTcy9QNzF4aWtOYWtv?=
 =?utf-8?B?RVBYeEZIRUJtR1lrbHIxRCtiRW5SUGVIbGUveDNla01FZDhpSW9aSEhtQjF6?=
 =?utf-8?B?U1J2RDZLVDVrV0RMOGpRcTFUQ012UnhrWk9mek1xNkN2ZjFRdlp0SkhYWjgv?=
 =?utf-8?B?c3VhYkljaGtXNjNTWjdRaGJEbUpiR1l6NEx1cUwvMFJsT1d4bGNNeWhabVVo?=
 =?utf-8?B?NjZHNzRuS1lNalB1aVQ4K2Z1RU1WMWl4TmZnRTdiOS9BYTlwdXJQUGhrMkJF?=
 =?utf-8?B?SzBEdXRTSW9sN0RpMHJtdmowY3Jzd052ZDRHek5MblVnd2RnOUdTczhudDF1?=
 =?utf-8?B?NGZPT1BTSE02cDlNeWJwTE03RmRYUDFMTWpKa0NsaFVqd0psdDlkeGlQK2F5?=
 =?utf-8?B?RmlDMVBXTDJXWk0vV3J2ZzVHdlpXTzJEdm5TVEZwWDUyRkxhRWxqTkV0YmNk?=
 =?utf-8?B?bTdqNVdEMU10MVRMM2hZMlRiTTVHMThacG9XUktxUUtrYkw2U1RYR3BqM0hv?=
 =?utf-8?B?TmViSFBZamRldEsyOEdVKzNWc1BYY3BOdEdwWDNVaG9tcy96UjhnQkJEV0Jq?=
 =?utf-8?B?ZzIxSnFlT1NJMEh4bzJUelVVcWdtK1M3YTFkV2lBZzRsVXJaaVJHUk8xQUhP?=
 =?utf-8?B?T2p0MlJLYTQ0MVd5NW9sckZkMGgyby8xbG9aTU9MWm44NkFxU3Fxb1hzb0lW?=
 =?utf-8?Q?E6+0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djlrTWpLcVo3TGtCMUw2ekoyUkJVQ2FvNHB1MklQdEVDcThTMlEvRE1nRHZL?=
 =?utf-8?B?Z2diTWFHUjI4WDQ1VHRiemRibEdSblJhaDljZytid3FENW1Gakx1Z3JaZkpm?=
 =?utf-8?B?S0c4andVSHRGaUhZR3h6R25Nd1FxZU4yL0loSkVWS09FWXBSY21HbnU0UndD?=
 =?utf-8?B?akpYbS9wQTNPTTYvRVk2dlk5UjJjYXVIeVdsdm00bnZBNEttaEF0N2RWNmw5?=
 =?utf-8?B?Um53WlVBc2Jhdm5QYmdtTGRjditaSUZub1VQUTdIalVpSFZKMHFxTkh0aUtE?=
 =?utf-8?B?MzNFQS9oUWdKTzBMeC9DVWNUVDlaOHNEcCtxNERyb3BwYmRlcWtOTXMwc1Jj?=
 =?utf-8?B?YVNQTUVRalI2d0xmZU9wbC9oUXovRzhPdTFpYUtacDIzelVxU1ZFeW9CVGxa?=
 =?utf-8?B?SGR5U3B4TWxzakxZUS9tTVFxS3FOaGZsSHR4QldvbEp0YWN2OVNHdWZPN25T?=
 =?utf-8?B?dW1qanAzNDNoOFBNY3E4WUZSU0tjOWIrYUh6OUpIWC9oaFFwNlczaVhYb1dK?=
 =?utf-8?B?SDdwanlIWXFvUkdqeGVoWkhoQTRFNkRxeVV0YVpBNnIwWXhnM1VHRWV1U1ZQ?=
 =?utf-8?B?OGpicHNiclE2QmR1Q2gxdFV1MWtKbGgwNkQxdk1NWEN3T2oza0xEQldWdjRz?=
 =?utf-8?B?TVc2QVNkKzhlU0lxV0J4czRSM1cvZmkyU3hGclcvZCtocVFiRTYybm1XM1JU?=
 =?utf-8?B?WThJb2FBaDFkNU53R1pvUVdvNkVHeTZrMHNyK1BnZDJBNzZvdjVwZlFPNzFG?=
 =?utf-8?B?clU3KzBGdkU5aURDbHhCM3N2Wk53MEtzdG80MHdlVmo5QUZYaGtFUTdKNTEy?=
 =?utf-8?B?cnhxL2xTc1R3N09wV09GUFh5ZXNmalJueXNoUUVBclJtT0xQUXA4Rm1pQVg3?=
 =?utf-8?B?RzBpbkt3QXdZNTROSUdPYy9zdmN6UEx2K1VkUW51L2RRN090bk9PNVhRaFZu?=
 =?utf-8?B?eUNUNnJneDBxSUx5UmV3WEg3S1hwaTZ2V3ZYZW5aQzgwWCtMclhubVlmdU1T?=
 =?utf-8?B?R0IzR2xtcVpUR09iOGMvSkZ2czQra09YdE1GVlYwMXNqSDRpdS9pTE9xRmFE?=
 =?utf-8?B?U3ZyYmxYM0xFQjYzbWlxc0FvSVBVeXlDeVhKZGEzNUE1SVRxaFVXUHFEaFpC?=
 =?utf-8?B?SjRxVWYwaTZyRjdUVmdZeWRtSmZtQXk1VXFVdXkzWlgyVjV3ZllIbU5VWVFF?=
 =?utf-8?B?MmM1ZFpEZkgzSXdHcG9WUnBEb0VzSzNocExwd0kwU2o0b0ZNTldtOEhSaUFt?=
 =?utf-8?B?Z1hyc2VjNFlaNi8wWmthUVg4UlJpMXBtNGdUN3dPQVdwZTFscm9LWjZnQ3RX?=
 =?utf-8?B?T1BrenRtM2ZYdzBlQWJ2Y1JoYjBLWExSd1lvcGFucXREQ2E3QUZiSFRkQ2dW?=
 =?utf-8?B?akJ0bnVGQ1hCTWhUaWQxVXNTcVh6K3dZVFNNRUhNOFdmYUNsR0pZbW9qWkNE?=
 =?utf-8?B?WitwdnBTcEk5UlVLbHI4b2FQQlBYUkd3U0V5T2NENVdIZnR5MVpremlyMGtW?=
 =?utf-8?B?UE4yQmdqL3RGMWRCSnVmQ1dsV1ZkRnF4N2VFVHdPWGU0dWRuSzM1YlJNWm14?=
 =?utf-8?B?ZUFXejlHTk16eFk1am9vWisvMHhUVnJ6ZjVLd3BieWJrcyswZmx0QlFCZDI0?=
 =?utf-8?B?ZnZoeUpBd09NZ1ZVMlVLQXdHb0l3NXoxZXZDeUszVFYxK2cra3dhdHdqcFBH?=
 =?utf-8?B?K3V2V2hTd0pCSVU2UmhLZndCVGU5dFhVNGEwS1BCMlkycjFSNDBFNzMzejZR?=
 =?utf-8?B?d214RzhwM1NDSW9oajh0SldwZDZScjJZNUNjQ2VJa0grYXlOV0gxOUlPT2tx?=
 =?utf-8?B?bmR5SWUyNURBNXAyM2huYWVnRFh2Ty9yaWg0enNtY3RjUmY3V0ZkYlMrN2tX?=
 =?utf-8?B?amdwY3RYTXR0U2Z1cFRyK0pkNlBvUC9Vb1BOQ2pzaU5OVlVzdUNrUXFXck5Z?=
 =?utf-8?B?WXgyK0ZqblZvVjNjV2tXcks4clBFWmgxRFptRDhwRmY2S014UEYydStDV01y?=
 =?utf-8?B?Y0xhS2YxZUowL0UwM1BUYXVVdHFHV3JkYnQ4bkd1RzdJUk80ajNnTDBEdFJl?=
 =?utf-8?B?cGhKa1E2K2k3WDlzbUhVN0M0OWxIM0o1Z1lsdDB2NUlSNFZBS1FwTVpVOUd5?=
 =?utf-8?B?SUdDbThXNitNMmwzRmVHVG4zUVkxSXhaZktEL3kzSFIvWUttejU3cVphb3lx?=
 =?utf-8?B?TGZNS1c0UnQzR3NURU1TNVlzM2ZzWnBOc0NYN2ZoZlZna1RkMkFvSm8ydTdK?=
 =?utf-8?B?Q0lGZVFNdVVIeDhvTFFGN2Y4bVdjMngrcUh0UXR1bkJCSC9iVkZTd1V1M1I4?=
 =?utf-8?B?Q083Z2VSS2RBdEhEYlJQT25KOGw5VFNqSlI1UXNoUVBXNkI5TGJIM09hak9p?=
 =?utf-8?Q?BHC+Y65zu3jQHpJs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 116cedeb-a2a4-4046-61d5-08de6a8a4429
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 22:58:41.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVoLGL4g7ygWBsB5EYIF8ZvWZm7mgPTcNKWqxdZHKcYOGt8zIWgG7m0+pZCtN8MpUsw1fQSn5JyUOLGK/7nKRAl/gyzpJAfBgagxXdiyCJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8406
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258522-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,arndb.de:email,iscas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6ED6B131A02
X-Rspamd-Action: no action



On 2/11/2026 9:50 PM, Chen Ni wrote:
> This fixes a regression introduced by commit fd24173439c0
> ("myri10ge: avoid uninitialized variable use"), where a comma was
> mistakenly used instead of a semicolon.
> 
> Fixes: fd24173439c0 ("myri10ge: avoid uninitialized variable use")
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---

At first, I was curious how this got into tree undetected...

Because this is C, and ',' expressions are valid.. So this just looks 
like a bunch of chained assignment expressions which are all valid to 
the compiler. Since none of these are "statements" its not *technically* 
incorrect, though its definitely not how one normally writes this in C.

Strictly speaking this wouldn't be a visible regression (since at least 
GCC doesn't complain) but:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

