Return-Path: <netdev+bounces-292444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHgzG9ZVF2oPBQgAu9opvQ
	(envelope-from <netdev+bounces-292444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:36:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BBD5EA1E0
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8171D3005AD4
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FD536C9C2;
	Wed, 27 May 2026 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H63fVach"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ED23BB127;
	Wed, 27 May 2026 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913955; cv=fail; b=lk1/KlhW/E6Hg7ov4bkpOHMWLC7ftFf4lqK3rH6cqBZw0N3qylvwmFX7BLq40sSJdIelO4M9EXsxADLKkK7mpzEVkTQa0qPpmIGjxbH0t7V3lQvYQY5nkj9KA1pATJ/moyHCi8wv5RhI0wqnImKITlDqjO+5uNEZa72WHjaxdBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913955; c=relaxed/simple;
	bh=ekh6jwArf/WncPaYA9N4+b93LDqm7YiDoxTHmoKtAes=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dn0s4iluQjQIZJ1WHq5ZkPB6fAfTcqjCMF1ZKxe3gGnLFy1SeQpiov9wsxGK69n0yH++Ny1SoJzU3nwv7EFArY/jrfHc754iQoK7SKq1veTcs85TDuU6ZPdfI1yizF/ewjBLyYipdMv2FKuccgIP+iq5+UWDu77Ifz1IBbI1aeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H63fVach; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779913955; x=1811449955;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ekh6jwArf/WncPaYA9N4+b93LDqm7YiDoxTHmoKtAes=;
  b=H63fVachslVbWXtYcSG60I7YGrN8ql0jDri/Nbo5edpMP0VKQHCYWGK+
   gd7b4Ltf/hUQKk1ONlGacZU+m2psYrAH0vA5HKkWUksdzke+rqDGcm2L+
   nGX7XKSutm+7hhad9qryv0DsqXH6eflgKEm9MYOSxSdzGU8CUh98A1bVt
   je42NwTyQNVy+iPjdS2O0TssUPr859HwdHT/EqXgpJF9koFNEFfP7oxqs
   dk98K9oqYSf/QQ+OTPWKGAdjlN80bCvh8YOsG80J0U6IVQxPm48vIX/yh
   izaNjc9q3+XfnulR8JHni2iK1X9Cdq95thI4xD5VphOJiVjc95BWuOHKx
   w==;
X-CSE-ConnectionGUID: R620ZpEHRCGD4VDmStvViA==
X-CSE-MsgGUID: 3RZh5pTFSBGKT0zcQy699g==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="91063483"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="91063483"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:32:34 -0700
X-CSE-ConnectionGUID: nBEg6C4pQW2svN+KSvDq2w==
X-CSE-MsgGUID: 4PJ9UrXnTgigDesyNH4Dtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="242196145"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:32:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 13:32:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 13:32:32 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 13:32:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUTx/6FZH2y98W0uUhSGquOL2HaBPHdEUbYBBnqsebrJkGJoarFM1UohhwwTI5hCAjA7DiH0QkiaJNSeHBsv4H8UqhytlX/fH2e49m5cF0Hm4gG//FZbWQZTw3KqS2DLXhkqh7Ma1E+vM1DJjlh2AHBVMwmD+DXnIReZHUlera7LDEJf4hnThPCHn6ek8cXNB9jJjS6HbuiYMfJbvyQGjPPHTrVc9Nb7JNiENJwf3Z8SrYKfYDRlpMwYNGDjpioPBwkl4QIJXupR/no9ckuPc/n8ocS5ysOsdhVNtUaGHk032wjH9OFS9bFa8D2M96AJ4HOxWyAr14vKgzNdlpCZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KAzfP4KxKKs4+qAyOsDd3vEaOoggcp8atVxt1ht1M4=;
 b=OVylKoUH0qiT+ASG9FrBCe7lgo9KNhsFZIzgJDbFgyLbGWq/48gIJfc2vmFqiGvUCPQuKCG8pxHLad17xs5uWmioG5n5HwGTpqnHf/76hg0d7ZAK0DPjVX2nFzwyFen06fodetj06SyYepEGHRFkwQl938ELW4nrvMBp55ppEiKZH9lR+MqL/cUi8PZyP8o4SZX2x+AyfloZMZX8yQvjUpRzdkWXKdb7lQGPY6MtKnLm+eoSWYHyltEwQ61WqxQRJcdI9bgXAa0BM7xbGx1WY3kxQh6g2faWmqnC1yca6Kpb4M63OL8BHj2q5HKMb8oNKUS6tTtNXMXqMJuwJUCKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CH0PR11MB8141.namprd11.prod.outlook.com (2603:10b6:610:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 20:32:27 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 20:32:27 +0000
Message-ID: <a0bc4a6b-612a-426f-aced-205c6db6602c@intel.com>
Date: Wed, 27 May 2026 13:32:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: lan743x: avoid netdev-based logging
 before netdev registration
To: David Thompson <davthompson@nvidia.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1779903597.git.davthompson@nvidia.com>
 <8909217245395f6418cdc2699147511c443085e4.1779903597.git.davthompson@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <8909217245395f6418cdc2699147511c443085e4.1779903597.git.davthompson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:303:8c::11) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CH0PR11MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec06cbe-80dd-49f6-ec28-08debc2f114b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|6133799003|4143699003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: mFz6qBUr2lyT4WwRmME8b2bnEoi/qRGeR0UkS5ZkMKH2F+hxyexNqd2J5PWgb44DFYakM1WO3nGbo0JIapBganrzYyGcMABOGj22V6bhx87tzUKcRKLoa/uo7ZRQ8AeQil1AVb6tn/7O/o7mueDNHLqHx0FeuBzSAKtOjkmxKIsxlgGRwit5ViiZuKQxQCDrhI268MyXr7+PwlDbr0n9DIYWsTVUTodGO5HJ4RKIYO2HziuH0+Z5q38MZ8gJC81h6To1CViIgoIHn+TDA7AtPHLmLyR9axPSWI2Bc8fuJ8cAS6z1iM+JGtavr80Y0HmhLNIm9tlyq/fqmkCbPeA+WwMnjRZBQo9oa/D4GNZA0SkyAAZtOKaJ5L3Wm2oA6Yk2fNogQ0iG7YEvyNPgLv6yOHuKeEWftPKceqiNSyaJDImj7cJ6mOXsgbUpQ2frjZGy2T519ktawGB3fYRUEvD56u1j03k1WpPw4xopBSdJYvDQNS7SqqzaQ+CxOxhj4KM5CUn60VxoaHNpATcjbPMrnm9xzLwAKRX203yUiDbKSBZubcxsyx8WUTkl85FOyEltiP00SXdqzhBEmgMB284YWlTblzkzQNdMChB6yf/lts5R2Oy7ame5nni/h0ski5mMmDJBSlTPzrjFNuyoK791yz5Pt9oZeop6WpcfYaFIMzwZU9YkwADo0a0SEJkWJicx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(6133799003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3dleHBjZHYvamwrcENKa21IVEZUNmRJY01UeDlnQ1RNMkhOaWxmZVFvS1pZ?=
 =?utf-8?B?Q0lwWVdqclFBZXd5V2c5MXNLS0VudFh1a0Y0MndWQjNMUzN6cnRXMTloY0hT?=
 =?utf-8?B?VGRKMVdtalc2VGtNb0t5OWNKb0g0YW9nSm9nWTMvbkR2aXplMEpPQ3FadTZ6?=
 =?utf-8?B?a3dKRjU5VjF6azkxRGxnSHd4aFNuZ2kvTXZWaDU4bUNSTExKb3RLY1RLc2N2?=
 =?utf-8?B?VUJEOGU3OWQxcXZNOTBHeE5ZMXp6RXlCV0F6T0pTeVRrRWV3WmtOYitwR0l3?=
 =?utf-8?B?MkdHQzRoN0doWEs4QzdDSkI5ekJVV3BhN3dqQUJwaDl3VXFnc2xzaDk4a0c4?=
 =?utf-8?B?Z0YrOGZjQSttaW5tTFhpT2VPTDJ0WUc3Q2JNZXArd1pGZndtbmZBRW9aZW1n?=
 =?utf-8?B?OVFnZldxVlQvd2xlZHVXb1ZtZXpIREdOSytSbXdjemxvOGxwd3NOWTQ3U3FP?=
 =?utf-8?B?aFpJMktWbjE2Y2Zud21yaHBCb2RoNmpLNWtFYUxYRDhBc1BVV25DMTdRWGNa?=
 =?utf-8?B?MG1sQzhWbkxwQTV5Zmwvay9qNm8zOE52TXhSMmRlVUVDUnRnM21jZjNldTMy?=
 =?utf-8?B?M0ZCbkZuRHhoL0lxYXUzdzJNVmhsK2NNSTc2MTlEdzBsM25ITUtaTDFvZnJB?=
 =?utf-8?B?eEl4NFNtYjF6TGRPR2w3WWdvYkhnU0FiTkNTM2Rmd3NrMmQ5RHdLbjJrcUR0?=
 =?utf-8?B?Z2JwY0xsVi85TDJNTEF6dTIwTFkxbjFjdnBCWDQ5RUpBSGhuWmQ0N1dwZXFM?=
 =?utf-8?B?T3VMZlZuS1Y0dFlaZHdaZGJtSXpzMjNMNjhHM20yTXdIVi8zUnE0dTYzRWNt?=
 =?utf-8?B?dFF3M0drbml3QktaUG9CMzFkZlAzenRoME9PUXc1RUdKVEFiME5qNWdoQ0w0?=
 =?utf-8?B?K0FwdGZoc3lubHFmRVphNVRUNU5RRTM3bWw0UlluYnVPT25pQ3EwSXRLV1hm?=
 =?utf-8?B?MVRWdGN1SHk4T3BGR09HTGh4b0QzUllxQTJ1MlZQTnBVNHo1UncrcWlVMGl0?=
 =?utf-8?B?Skw3QmJub2JibXU2akhwc1RkWTVPWGdQZkYwSUlXRTd4QnFzczRKMTNqai84?=
 =?utf-8?B?SzF1NTJqZEpkWXl5UzdDak9KVkxxKzR5VTJWZllPOVJYVUZ1TUwzb3o4bW5k?=
 =?utf-8?B?cU1ZcWEvdHFHeFc2dVBpa2Z0UC9LSzA2M3J2ZDBRcXNqRm1IYlM1dFJqKy9h?=
 =?utf-8?B?c3UyN3JSa3d5OFZoejlxY0s2bWovM0ZNNCtTRnhIdzdXSkExQjZYOFhmaEVt?=
 =?utf-8?B?RWJXQzBTRkx0aXV1SFc3amljcTE0YkxKUk1xU3JEb3pRZlFMaVNVTU1lNEhk?=
 =?utf-8?B?V1hkak9SVVNUUE5INnV5OCtKcFhwSmRWd3JqbFFVRW9vemlSWmgwQzBEb0V1?=
 =?utf-8?B?UVpJNDk2RTBmdDJIaTNZemNoZGRza055V3BGTkE5anhmY2pDcTg4NEtaRENJ?=
 =?utf-8?B?ejkwbkttZW9lRHdnVzJQN2pwNG9jMzhaZGdqOU1sNUd3OFlraUh4dXpRYW5H?=
 =?utf-8?B?RUpPMnRobEx4MUZpdzVSL1MwVGFocEhWWmlGdVhWd0VoRk5wUStBbjBEcitQ?=
 =?utf-8?B?YW1ETFAwR1VxcTBUYkhvZ3JyTTNSa2grR1YwZEF3b2xxUGY1bXRLYS9oaFhC?=
 =?utf-8?B?ZlpDWjVhRDlPV0tHOFJHL2g2dVRwc1ZNcFdnZUw0ejl0WURqQjlmbGlvWnhE?=
 =?utf-8?B?L0Vua0ZlNnhJbTJza0sxa0dxRnpobDZMSVJIZ05TWkRVWnhSUnpzNHhwTzNZ?=
 =?utf-8?B?Sld5a21NREtkVC9ySjlWaThDTFg1SFJrdGRBN3l6Q3Rja2drMmhkRHZwclJs?=
 =?utf-8?B?R1VGYW5GMEdJemFrYndRZ2YxOVU4YlI3eFU4L0NNMFc0aTdndjgvUEhVUEFr?=
 =?utf-8?B?VE9mRDMyN0t3RjNiblArOEljQkhSK3M2MlVPV2d5R2g2S3JIL2ZnZGo1RWhk?=
 =?utf-8?B?U0tjVWxzRFRlWERDWXp5S1pnWnp6WE1BRFV5LzlHUyt5WVo0NFVCZm9tWU1x?=
 =?utf-8?B?STBOeFdmZnI0elFFL24rSzdzRkFxWFg3c1dqcE5EKzdKeER1VExwLzVmS2xV?=
 =?utf-8?B?T2R2V1kzQlhvTk13UWNWeUNlbEV4NGZwcTVpYTZabm54RFQzbWZ4Ujh4M0Jy?=
 =?utf-8?B?blc2YUdPcDBOWGlwK3lQY0VZVnBSandRNTA3am5VSElJazNrdCt5cUpCWUZi?=
 =?utf-8?B?eDNIYk41aHZJZ2ppS1ZXMzNOd1NzUk15WGczazJEamRweUxvQVR1N2JBWW5E?=
 =?utf-8?B?UWVhY2xsbXplUUhMSWVKVmlJUVJ4WFN3d2YrekdMNTVQTG5ORllIZUZKMjhl?=
 =?utf-8?B?UGVTWVNtcStGN21QSUdVN2EvRFdhdjJsbVZZSExjSnhydHNuak5hdz09?=
X-Exchange-RoutingPolicyChecked: IouejSQ//cid0PA+mQPDPml5cj44SduhrKo8ordum6ShyRzK2waOd5cf6lV6lvGsoYPQOrwsSlRhz7gkN4hO+Yc9+5qYRrW2i63WITpEzekEzxk0aRMxe0LLZxxzrypEOY32Our34c1qtXE7nhPvaCPFEhWbKDM0syej7xs3DU/RDZwR8X0We6mXrqHgqGhKyJI0nKMMnLfheKsV3gktCapdgmOm+SmKj1qc0xD5Dyd0fDv9H+6x55lJoD/0fzWnprVoAEqgehTFPHsvwRD1CO7J9gy4xy65eP45rdz3n59Z+j6v2FZ0EjIUAXowdJRdEa5YoDhDWzFJMH5VMVvNOg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec06cbe-80dd-49f6-ec28-08debc2f114b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 20:32:27.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCdfY/L51Tj4VDvl0pZhhSq75kY+2xcfrUGQwUpmMzcoUIMHF7833JvqhHLdVLlaV5LsK6or/4YBj0e56GUI+S1R5T0+zfOBLqIMfYHP95w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8141
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292444-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B9BBD5EA1E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/2026 11:18 AM, David Thompson wrote:
> This patch updates the lan743x driver to prevent the use of netdev-based
> logging APIs (such as netdev_dbg) before the network device has been
> successfully registered. Using netdev-based logging prior to registration
> results in log messages referencing "(unnamed net_device) (uninitialized)",
> which can be confusing and less informative.
> 
> The driver must use netif_msg_ APIs and device-based logging (e.g. dev_dbg)
> until netdev registration is complete. This ensures log entries are
> associated with the correct device context and improves log clarity. After
> registration, netdev-based logging APIs can be used safely.
> 
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---
> v2:
> - Changed target repo from "net" to "net-next"
> - Removed "Fixes" tag
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 72 ++++++++++++-------
>  1 file changed, 45 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 793633cced19..bca2f3d1ad41 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -119,9 +119,10 @@ static int lan743x_pci_init(struct lan743x_adapter *adapter,
>  	if (ret)
>  		goto return_error;
>  
> -	netif_info(adapter, probe, adapter->netdev,
> -		   "PCI: Vendor ID = 0x%04X, Device ID = 0x%04X\n",
> -		   pdev->vendor, pdev->device);
> +	if (netif_msg_probe(adapter))
> +		pci_info(pdev,
> +			 "PCI: Vendor ID = 0x%04X, Device ID = 0x%04X\n",
> +			 pdev->vendor, pdev->device);

Do you really need to check netif_msg here? I guess it keeps the log
from being cluttered based on the message levels enabled. I would
probably just do dev_dbg() for all of these and let users use dynamic
debugging to enable/disable precisely which messages they want instead
of the message_enable bits.

Also, sometimes you use pci_info and other times you use dev_info. Why
not be consistent?

