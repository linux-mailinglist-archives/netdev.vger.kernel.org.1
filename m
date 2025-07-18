Return-Path: <netdev+bounces-208150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ACCB0A4C8
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 15:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F11537AA075
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 13:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21D62D97B4;
	Fri, 18 Jul 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbsZXXGX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68400218EA8;
	Fri, 18 Jul 2025 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752844041; cv=fail; b=kw3QnmmwxQPML/3R17dUew2heLdkXeyXkVWwiEADOLfxs1sQqFtGN9U9oINreFJtSr+xE4QOmS6ptCviJNlx5CBD0HcAPz72fhlK0fzSlgoPhAyhUNs+847p9leiw3wL7RG0Jw19bx9V+TH863xOQH+vdVa/BUCR6b9y30uFiZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752844041; c=relaxed/simple;
	bh=+gW6K0DdLvcEGGlrVnxRJOOvmrCMzpDznj+ZsffYxms=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W2pGMD++81XFcItIvJJYI6L7VOnNXStUv+LP/+6lCAV6JuqW+ecVW9Pj5GHGZHKhx5yBtTUVu/gi+JzyTWYjLcpMTtI3O+4AzkUbKTXU43Z1LDYt6wFZR3FFmzz7eBhfSgD4fZGHVBPl3FMu+XHWQsxXEr+qC7Ynhonb081IS9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbsZXXGX; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752844040; x=1784380040;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+gW6K0DdLvcEGGlrVnxRJOOvmrCMzpDznj+ZsffYxms=;
  b=UbsZXXGXZ/XWk24hEURNxJWydLXK5/WpzE9PSYnfA2oQ/Z1JddVBYmGh
   89F5MUhQsNOKFDaJqmEJvx+UI4QwkxsFhSm2GsYLTIh5kN9eQAodKkRN1
   bj8oIY7RJePzN6KhFNFSWK5F2CQ/TIZmjyzl13CSeJlmBCd7AHwWjmhP7
   yAiNF+nQRiz47RT5zyJeuUMv/od1MHwTy30dAGylZd4B3iFAM59pTZUPP
   z4NzRGWkrzbo5bXCCXQH/47GlC5squCEdve6hyXETN/VRsOV+xlh4cQNI
   kCWOwDOmypvaAW78xpH6q+hTkzYi5fEqOEw2DSFa4sCiFEjj+M5TAnuJV
   Q==;
X-CSE-ConnectionGUID: /swfN6CISjmSWztBMRfHkg==
X-CSE-MsgGUID: 3/tRLwcBTM+X7uW61Qq3uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="54850321"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="54850321"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 06:07:19 -0700
X-CSE-ConnectionGUID: vWXiJ8nQTemaDWfiTNrU+g==
X-CSE-MsgGUID: igZNpJo3RCCA9+uXZ3qC/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="181762097"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 06:07:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 06:07:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 06:07:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 06:07:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzLIB9792/qPtqdhepsawIYqblTaew6eQuRcFaUgdkNcdRikcZuWDhS2uDfyTpUWHBdlrbbwkNmk7qIbQGE+GHYsSfx79jxOjl2OiyY2Wrs47YIW/Ow2kA+jsXJJ+dpDFDgj3Vd8t8zuMDX2cdZHUX1AWnDRGKkNWCKK+r+DLRPgnnxCi2ERFSAH7vPO5tZGwiqb3QhWpTELQedJ70kvvi5Jb55TpTE3kgx96sLEbgBsjG5rZvvOw21v1WBzuPTHY0b8jI+VXH0cquK6pcVI8Kb1QwzGfGCHPTYP5Ppg8Q2OBvzwHC+JWaAS3lPeRMDBr//3I7HaRlpDnoZ2zHCnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/aUphC7GERzYL/Qx6tVIH6eK4Q0YXOkOw4DEuPZ3yA=;
 b=ZSnNJ2OtCzemC8BYxzlqjp42P3fkmmkh2P7wzYXzvsWHTjW9Dx3QkHOWOw+cShw8626zCSjucfqB134tOpJ1TUXrOluKGOzSolKL9tRrI4mIccjnCDT8OxjZ8p0suqarVGcjq7F5qdjdkFAK28UDmnrmNW3d4VJdavYR9/kJB9xDuypQgRu5grWQppmztFcRJ71rB8wExoFvN3jqTX3DtNpQg1ZNTw8FcaWqDzl8tPRtoS04lDiR7T2K7pMNcT4e9d3K6vCEx8xWdD24iYOPU7XOtKocegcoSpjTvKS0JbdQmSeHTQDa97ofsduJ9y8kvIxRge8duQPKIz6/G7FHAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Fri, 18 Jul
 2025 13:06:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 13:06:56 +0000
Message-ID: <9b1b668e-19a0-4191-a5c7-686e05a08a80@intel.com>
Date: Fri, 18 Jul 2025 15:06:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] idpf: set napi for each TX and RX queue
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Samiullah Khawaja
	<skhawaja@google.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <willemb@google.com>,
	<almasrymina@google.com>, David Decotigny <decot@google.com>, Anjali Singhai
	<anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<emil.s.tantilov@intel.com>
References: <20250716211230.3592838-1-skhawaja@google.com>
 <efbcade2-ca5a-43ad-9512-846be207eb56@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <efbcade2-ca5a-43ad-9512-846be207eb56@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR06CA0057.eurprd06.prod.outlook.com
 (2603:10a6:10:120::31) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA2PR11MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: f00c608c-7150-4fb9-85d7-08ddc5fbf8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWxXOTI4ZnJNTEtXZyt5OTAwbDVGdkQyS21yY3kvbzcxd2ErbGFSZCtWZHdC?=
 =?utf-8?B?WDNkbmlzS0p2K0l2elZ4MkVzWWk1OXlKNzVjR2lzME1TbWJ0TElCOGNFeTRl?=
 =?utf-8?B?NVVJbzh2Q1RRTndZbWtqV3dlSDhsZTVubU9rUWV5SnJZTlhEQjNDSkdmZTF1?=
 =?utf-8?B?MDRidHBReGRXQlJQVEFraklhMEM1YmZmNjltajhYaEpNTVkxaU9ERmlDRmRQ?=
 =?utf-8?B?U0FlMXh0aXBMWWs1ZlBTdStrajMwbmhvazVYODZXa2k5SzdsakZ6bzNXd1Az?=
 =?utf-8?B?UFJUNHJMWFZIWm05VlNYY2Z4SGZhK0pZdi9Yd2puUmNKWkQ1eG1CcldxUXRD?=
 =?utf-8?B?aWJGdmVZNFJkUENRTWoxb3RNNkgydGtucE42Uy9BUlJHR3BvdHBnZ3U4T2lp?=
 =?utf-8?B?Ylc5WnpjUjE2S3QwUWcvTlZqTlRRNklYdklXMm1yZ0lWbG5pS1ZjS2U5cmxh?=
 =?utf-8?B?Vzl2ZXFac1NGclgvNDhzWVNIY3BtcXZiZUFsZm5DUUkwVWhuTE5RWjNtZ1VN?=
 =?utf-8?B?cnBtR2ZUSlNQT01xQ2taQmVKZytycGdUOHRMbEFpaWNKWXRLQUFVamVsbTlP?=
 =?utf-8?B?bWdVc0k5dXBTYWZkTjJNMC9oSFBwdndwV2k3NUhxK0h6OUxmTXRxVjNFZUFi?=
 =?utf-8?B?ZzFDc3ZtQjAzcllVTWRNNTVhQ0lHZFRRQ0UzMGFoWUlJNDV1NzJCSGtOMG4y?=
 =?utf-8?B?S2hBQmVoa0VVRWFnQTJsRmdDaVFWOXVxMEZVcVJaem43Vm9xeU9LNTdwVmpJ?=
 =?utf-8?B?SlhoTVdKV0VHdnRKWGRNb1BvUStlNis4Tm5vOFFCcHRRcVNRTGhmeTI5WUV2?=
 =?utf-8?B?T3JIbzA5aXQ0ay83cnZuSG5KcnJOMU9tTm1kSFh2dm1IaDIybjNzWWp1eUNR?=
 =?utf-8?B?Tlk0SzlSQldreXVXcHFFZGZJaGtpVEpSQnpFK0szSjlNSUpLcXNWNGI5VEI0?=
 =?utf-8?B?L1BXNG5QalFDQVdSeHV3d1NPSDBRVGZHWE5MSjNha20xaHdrZFdLOUViL0R4?=
 =?utf-8?B?L3NHMHpMYlhJWUhTTkkvRWVNdjdHWlhhMko1QzVwM2JVdUtqSmsrUnZQS1RN?=
 =?utf-8?B?dzA2NExKYXdYbkEvRWh2ejZINUJaSUhmelAwc1p5MkR0UUM4aWpCZGpXRnA2?=
 =?utf-8?B?YW9icCtoN2IxZzh6bzgxeFRRYVVDTjdyRjlRS2tEQjJ4UDUzL1FDVzdwTFpV?=
 =?utf-8?B?Nm1XSFVSV3MycXhYNy90dEY5NWEyRW8xWVgzZ1hxTWE3WThkVHlEVWRkdERL?=
 =?utf-8?B?ejVaK2VqQTZ2b015Y1BYTHJxN3BHSUpwUE1FdU9GaDJCWG5UdTBVNmMzSGow?=
 =?utf-8?B?OHFUc1V6dzk5L3lBY29EODl1T1Zzb1EwYytqVDF0UXljTURqVXdWVDdpRGJh?=
 =?utf-8?B?SVcxUzB3QktHYkxkaGhuTnlYWVlhRVcrdEpaRmg5S2EyQS92cC9OaGUxYzl2?=
 =?utf-8?B?K09qZXdkcC96Z1NmYXRuRHd4QlZKMUc2ZjRnTFBBYkpmMkxJRWRFVFU0bmJo?=
 =?utf-8?B?dFY1L1FSaWxMdkZDVGxoRHhhNDRnL095cndMbWpOVWhBKzUrSlp0d1NaTExH?=
 =?utf-8?B?UDlqbmJpV29rRVlRdUlhN2k5ZlRlemZsdkd5WU9YTG80a3VlMDg1ZFlFb2x5?=
 =?utf-8?B?WkdqTG52UERGNkVOWVh0L3gwNi83Znl0ZDhRMGNwcTNxMG53WVVvZEJ3bEk0?=
 =?utf-8?B?MVhiSzE4eWxpc2hTMkwwSC91RlltRTJ5YzRuaWk4Z0c4clJSQUxCckJ0WTRj?=
 =?utf-8?B?eW12T2Q5VEV4S0JxK2xqS2NrZy9wdFBMK3hrVk43c3MvZTdJTzRlWUV2cFZH?=
 =?utf-8?B?SUp2OExnYkhxNU5qa09ENm1id1paWHdGeWRHMjZ5b2t6dDZPS2IyOFJ0c0Zx?=
 =?utf-8?B?MEo4VG5aU1RUVGZ4MHFoQlo1MEc0ZWdNN3kvNnBYY1FhakwvRHNxYitsVkdB?=
 =?utf-8?Q?aBltMPbBsgQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVB0WTZVZVQ0WVRhclZuWlRkUjVWNkE3WitXVURwVnJtZWlicW1CSTVIb0t5?=
 =?utf-8?B?QzdKTFgrK1c1NGQvTDJaTEl2bmg2cE0xUWVtbVBPYXY4bmN5aGFGclk5Y0p4?=
 =?utf-8?B?eDByRWF0cWlMazN3aHZwdEMxd2twRTVhakhrcWw2M0lXd1krK0paMkJTSDFh?=
 =?utf-8?B?RjJPWmVQdFNUanp0bC90ZGdyLzV4YzhneE5nQXZ3OFlwL1l0Z2JnVml3NzdG?=
 =?utf-8?B?SUU3bCtJVU5EMGxoajJPeUJtajV3aGhHK3BYNmpObU5yT0VwcDZmOHlvcWxy?=
 =?utf-8?B?YlVYK2dZaVo1cnBZOHNBbThCYXpzRXM0T2d1ZWNmQk1adWVSVXF6bWhxVnpY?=
 =?utf-8?B?bjhWOWhyMEIxYjhQeDUvZzl4bTgwc1RCSUIyeEhwaEdzeHpicGxReklLTXVh?=
 =?utf-8?B?Y3N2MWRIZUIvT05FQlhWblFDSmkwR3NOeUhiR3Q3Z2RwSlQwS1NmRUxHcTVx?=
 =?utf-8?B?R09oWnY4TVJpdGFDdEtIbzNhekVoNzh0UE9ONXFRSVZaWm44TzZhaTBWeXY3?=
 =?utf-8?B?RzNxUjJXNy9qU041VnJvL2FxZzkzOFAxQ01WTHF2cGt5SWhwMUxUK2RqaVRS?=
 =?utf-8?B?YVpXV3hwYzUvTjJIOWJHNDVIbktJUTNyR29Cd0xYdkpIRmlQRkZYSGhsenpZ?=
 =?utf-8?B?OFhGMngvQlNZVHBNc05oK0lna1NFdDZsU3dSb1ZFM1pvK3Q3cDBvczJKNFVr?=
 =?utf-8?B?VCtwN2tac3VZN3R4NGdGSk5mUlkyTVR5M2xSbngvUzVwaEdDclV3SVJvcVp2?=
 =?utf-8?B?SkY3Sm9lRUZVcFArMWVDK3UvdkdCR091QjBKdVZwVFVtK1NNZUN5dlB2L1FE?=
 =?utf-8?B?ZG1pamtSaDB3MW45K0RXdXRhVDljdllpSUFJOWF6OWdUWmZGNVJwNWVJSDF2?=
 =?utf-8?B?RE41Y1BtNG1KMmhxK0VqOFpFT2FQK0pBNjRYRzg2TlNZMVZqNjBsb3RqQWZj?=
 =?utf-8?B?Q0VFeGwrVDR3VVFVL0hjRnlrNnVEZjRieCt5ZWhJQVJTK2hrTXRsS3pua2hj?=
 =?utf-8?B?TG9KUnZJcHJjR2czbDRPdFgrbmh1UnJSeGJzaW5VWXNWeFdUR2xiWVM1c0ZF?=
 =?utf-8?B?dTNNdVZpVms2MHNieGk4TU8wcXV4UzBxemJVR3RoM1dkYjNMR0ZUTnNDRzhX?=
 =?utf-8?B?MWJuSS81N1JvSU14ZkxGWDdDdTgxY1NzbEJaeXhnVzRsNENSSWh3cGEwV3ZK?=
 =?utf-8?B?T2FhNmxyZ2dNcUZMUTNDeElPOTJGbzNlR1JNcUJjaEJZSzh4eGNaRUg5bmJC?=
 =?utf-8?B?YlVJQjdzOSt2N0lFTWg3OEVyNHk2YXpSN3VCNUkvSHRvcmZTVmlLeG4xZFUy?=
 =?utf-8?B?ZkUyem9SZWNyUDFLSkVkUSt2c0RjbjMzRmppSGF1R1cyNzl4ZndTSkkrWkxK?=
 =?utf-8?B?b1U5OFR2OUF4ZGZYM3NGdlM2WXc1N1Flb3BJUzNQUjR3TkVEc2NVTDViellk?=
 =?utf-8?B?N1ZKeER6NENYS2pRcWRMeXBIYTdyeUVLWEpRdVc3SExwa0JLVVdxNnhkY2tl?=
 =?utf-8?B?dWpYYzJuR1ZzT3d4N3RMYVBPNDBOR0N4a2kyRm9DSzcrZEswTWlkdmV3VDRC?=
 =?utf-8?B?N0xnT1o5OEY1UGpOK2x6cDBvcTBXZ0lzQUY0NStydlpuZUpNeDJHcithV2U3?=
 =?utf-8?B?aHlzclhMWmErOXJKTHAzZURRelprZ0V0Vk05dEFmR25ieStNSDR1dlM5TVpx?=
 =?utf-8?B?VUxSZkF4SFRJaGUrYnZkTjRHR2VSaGNmYVRwb05YR0FIQmxmR1lzSnpoM3M1?=
 =?utf-8?B?ZHpMM1lvQ0I1aWRCUkUwNWtMbFFYUm44K1JWcmxhTFhzSTJKWEgrNFI1dUhY?=
 =?utf-8?B?NUxBbGI1ZVJXNVFETG9DWldUaFhjbThodzZrTTZqU05sb1NoMnM3K2FubGVK?=
 =?utf-8?B?ajJoVDBUMENuUXE2alM3T0o5NklycnZrSUNzaHVSSGgybGdQaUVlVDlNd3Ru?=
 =?utf-8?B?RjNmVzNhUDdyemZuNnE0ellULzVsODI4a2tZeFRMLzdMU1BUN3ZwTEZITXJT?=
 =?utf-8?B?YlM3eTVNMkk5M25hcnlEMWhSK0wySzE1NW9pMHpVUXFIOTJBUDJwNk1Cdzdi?=
 =?utf-8?B?cUVFdngvSGEzWk51MXlaeDhJWjcwbE9CTUF0YkhZOTcxL2xlYWhUbk4vSFdG?=
 =?utf-8?B?S0ZNaWhsSUtPUFVvRmNjM0JzK25YQXBpcmdpeTFXbmFrd3Y1WVBtWndKQjFx?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f00c608c-7150-4fb9-85d7-08ddc5fbf8c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:06:56.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNsyq2VkJ0GKF0K6pcbhjF2ZzZdEgM80sEtB2a4v7jXGbWsiV6GttgYdp8FjqwgaQOldDZrHj7oYPi+xzeRUgauRMnqBo8P+lZmvaR0wonM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4874
X-OriginatorOrg: intel.com

From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 17 Jul 2025 13:25:05 -0700

> 
> 
> On 7/16/2025 2:12 PM, Samiullah Khawaja wrote:
>> Use netif_queue_set_napi to associate TX/RX queues to the relevant napi.
>> This allows fetching napi for a TX or RX queue using netlink queue-get
>> op.
>>
>> Tested:
>> python3 tools/net/ynl/pyynl/cli.py \
>>     --spec Documentation/netlink/specs/netdev.yaml \
>>     --do queue-get --json '{"ifindex": 3, "type": "rx", "id": 2}'
>> {'id': 2, 'ifindex': 3, 'napi-id': 515, 'type': 'rx'}
> 
> Hi Samiullah,
> 
> Thanks for the patch. We do, however, have this functionality already in
> flight [1].

Yes, and it requires handling RTNL locks differently in several reset
and reconfig paths. Just adding netif_napi_set_*() won't work properly.

> 
> Thanks,
> Tony
> 
> [1] https://lore.kernel.org/intel-wired-lan/20250624164515.2663137-4-
> aleksander.lobakin@intel.com/

Thanks,
Olek

