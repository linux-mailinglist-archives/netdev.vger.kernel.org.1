Return-Path: <netdev+bounces-180375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8DEA8124A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94D516AF93
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2904F22FDE7;
	Tue,  8 Apr 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WUMhjWdM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1022D7A4;
	Tue,  8 Apr 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129453; cv=fail; b=BWHizhbJzZmdds+pL0c7mLaLGs93aGUoi6OfV5As20tfxT0LiE3D/5JIKGgiKfOLZxNZrtQIzB0RFLKe7AzXAQ34oyqfQJz34IxIm13H+PSKql5zX1dV10czEnXe+xmtzSqTogGU2isoSrxAsl3c4Ftm5dIOMGkF6Dk90K9oN64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129453; c=relaxed/simple;
	bh=3zgguvk7BtCsQXUK0zWyc4aw+0VRMwyysmb6tgPQRTQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d2W3fChrnfEY9pIStPXLiPP69qSWTiAiOlk3stv/ttUBZ+VXSAsnPzEcoJSZMdyQHyaFDDhiM/7hYvGxuQjzJMWaSqOZ4e2wujfAnSshuCT5fFVPPMLlD7fK2uV8YCiHNhFvEMr4ajvqjq3AvCT3hiVg5d5AWpqyrOUQNm3vyAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WUMhjWdM; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHpvbrUDRFnHeBUJmxmLa67jnaktwC+sY2NIQXv0VJoUX+coPT6ECQCgOIItb99SPnVPiNOeILsxLvDQPy9NPsC5mmWKBSlg7Mzkp8UolkxDUEFGpAsGb/is1yCzo+Ze2qC7AhVDPgsDY7RSOQlYNXtCk5vIKV+LbvSmlc1Boe5SAI7smzA5oZN7pIYctvCZ82Xv00J+vU6Cigz9u9xe8s/U2GFs2ye7EPfPPk50iqly/GFSDlCkPo1BtLxd33w1wf0C2keWKON8nJs2yqQMNiCqGAZcbKBKVxLzMNwQo1dFJdjTtJVCaP0daVAA3HOD57KCRrf8KRa2Z+tAwSOQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkuIVgZD7XV29DAqtGsrCtrmtLzHHKnsriEMoKrr6ag=;
 b=LKCFAkqa92ANa4rYZprt6hxe04aklbByv3QnXD71c3fBkwPchc57zjPpir1/QXKURbE2QbYq3eZM5MADGT3neHLpLYKpLQIaLLNhyGLI0fSeRCX09LA243hKmXkFussq4Kk7Ma7ClfTl/5vWJ2GIMv39tIpJKICEcllLm3sj0ZIHn33tdFSU/VM4GKG4mdxl8AN4JkIxLmMxqXVRRQ87Urm5xCsXjVRSOdXECd7lJ6AuOI/ysBXPA83LjHLu6ZcrUkgS50E5W3+LB+2S2/danUhuw+ZgnR92nJM/P1A7m8UjNWHd1TO5Bb3iTnZcIv6SLjzK7MiY/bLx4EdF62pBuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkuIVgZD7XV29DAqtGsrCtrmtLzHHKnsriEMoKrr6ag=;
 b=WUMhjWdMx0qvNL5yWRZ8pVoBH5k7wAbdwtj+xDDebz99MKsq7jvohK03hm0kkTqZ1BzrnuYaQEFMbreo5eSax0clwqBlrEGPgs1Prr4MhUcJ+KbV0G0yjXDDOMlucEI2ObzxmU2avxuj21tJwYzFIU/R50aAPkphpJ0+oa86/Ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS5PPF78FC67EBA.namprd12.prod.outlook.com (2603:10b6:f:fc00::655) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 16:24:09 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 16:24:09 +0000
Message-ID: <7e5aecb4-cb28-4f55-9970-406ec35a5ae7@amd.com>
Date: Tue, 8 Apr 2025 09:24:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] devlink: add value check to
 devlink_info_version_put()
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "Dumazet, Eric" <edumazet@google.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "horms@kernel.org"
 <horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 "R, Bharath" <bharath.r@intel.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
 <20250407215122.609521-2-anthony.l.nguyen@intel.com>
 <d9638476-1778-4e34-96ac-448d12877702@amd.com>
 <DS0PR11MB7785C2BC22AE770A31D7427AF0B52@DS0PR11MB7785.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <DS0PR11MB7785C2BC22AE770A31D7427AF0B52@DS0PR11MB7785.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:510:2da::11) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS5PPF78FC67EBA:EE_
X-MS-Office365-Filtering-Correlation-Id: f7998156-9779-40a1-091f-08dd76b9ca13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUptNit2S2RldWVPWjhHVHpzZElXY3RRNTg5ei95NFdqY1J0eEtIR01KcXlt?=
 =?utf-8?B?S2JQMUhFL1BxQWpSTm5nOFlNVFRFZ1NnVUZxYlYwRHBXQTNVcVJxZU14ZHpy?=
 =?utf-8?B?aWYyUkV1L3dZbnVDNHZGRkxBWUwrZGdXK1Bpay8yVkdrSEMvdjMzV252Vnp3?=
 =?utf-8?B?MGdrQVhpV2wxd0JFbzVUSkU0d3JmV1g2aGlDU1J0VEpucWx3M21HV1ZDQlUz?=
 =?utf-8?B?OU1TS0pwTzRncFNGeHJnTkxIZ284bktLdDMzU1pCWnI1eVhPRlJDdjAvbGRB?=
 =?utf-8?B?UFRKbGVpNzRWeVZtSVVENHcyTGxNNFJrWFBhbW93Q3FOb2hUa01CWWgzNUZM?=
 =?utf-8?B?YmVjaGlTZjA0ZzdJNUl3K00rNlk2ZzJEai92bW10dzR6Yk1OK1pEK1RGMkZM?=
 =?utf-8?B?ejBuQjdiRnhTMGh0czUwU0dkUmlsRTk1YnBINVNIeDlMeU15bk13dmJ2aU9k?=
 =?utf-8?B?dTd3a3hTUXQ4KzRKZXM5R0JnZkEvTlE0QXdwK3hrcmNQQWF2TXlTdnJ4YmFO?=
 =?utf-8?B?N2R2bEtwamJqNXFITHpRemxIbHlZSENpeDNsN3ZTbTJJa2NFVmR2SG91RmdP?=
 =?utf-8?B?TFRaYkdEVjUzakFiZldib3FZT2tuaWl0Q1Y0ZmdqWnEyQWxseHl6NHZpYkh0?=
 =?utf-8?B?ajljcFUxUVlsWlVyVWR2aXgxYWNLN3RkczcyNXY5OGcyRGNwY1dEVkEvY2Vr?=
 =?utf-8?B?YXgyY3c0aDAxYlRCTjNieTAzNHlLMlBpU0xBTlVHNURydTFoZkpuVW02S1Y2?=
 =?utf-8?B?NEJRekZPZWVGZzZqclFvOVArVHAvcmk3V3UzaUJ3Wm9xaFZBVDU5aVVjTzEr?=
 =?utf-8?B?VklMWXdyWFlONHp0aXl3blA4WXRkY3I2WmVtZUZCMXFJZ0VxL3Q0T3UydWFl?=
 =?utf-8?B?bVByRXVWaVBUTG5wVXVMeStBMmVNZ05xbDZHWS8vRVdnU2RvMDFNRGk2Wmpp?=
 =?utf-8?B?c1d4OUJoL2Iwbk9NTEZrcE5tZWc0OXpuaWhQSTFEV0wxa3pQc1VESmJwdWpT?=
 =?utf-8?B?bENVUTY2T1AxOFRibVdoNGJoTTA3NXphM1dTUUNQWEJubEdhUG5VVHFmRkFH?=
 =?utf-8?B?NS9IVENNTEZLbGNSajRlRFAxWk1iYXNNWHdHdGpBMUplT2YrMGZydHpzcFBI?=
 =?utf-8?B?K2oyMDAyT1BVVE96anlDdUNTc2RUMURhenhtbmY4RVR4QVpXVWpvR3ZXQUU1?=
 =?utf-8?B?UzFXR0xFWVk4eUZabU56L3lTY1JPKzFIdGxTOXYyNUdDdWREcG9mSCswc3do?=
 =?utf-8?B?UGw4eTJyb05CYjRDK2d2bG81Ti9MamJ6NEQvb21ncmVTRXJ2NUJwakF3LzJD?=
 =?utf-8?B?aVljUnlqaStZa3lxeUxmZUEvTGNLY2t1L2tzK0xEYldnRW1wVVNKMXYwZCti?=
 =?utf-8?B?cHBZVmZIQ2hYRkxoQUZON0NCZnlmdmxDYTU0THdrcEJkU2VZdlNaSFZYK1Bw?=
 =?utf-8?B?VGx6STR3MHZ6cmZMdklyTG1CVithYW10SHlOdTVEdDV3aUgxbEQ2N3dnTys3?=
 =?utf-8?B?SEpYRXMvOGhwTWFtYnBKNUp6aEJ4T2hiNDl6aC81S25NeGs4ZjM5dVBhT2xF?=
 =?utf-8?B?am0rZGUzMlBRaExoWnFuNlRsZmNjbWVhWFFHNDNjSFNLMmJWa2Nkemc2cHFx?=
 =?utf-8?B?RVh1Vm9sZFo2OXkwVVUyc3IyU3ZIR0cvTGxVc253TEpwR0dZNU1NT3RkTVo4?=
 =?utf-8?B?MFZMSkJTS2pWdUhua0pDSXVXcEgwRFkrM1A0NHhFbFE4ZVJvR0ZGT0hPd2V3?=
 =?utf-8?B?cVBsOFNLSHhDc21tdDViZTZIMFZ2aWVuTHUrK2lOckN4eDN2cGhZQXMzTE1m?=
 =?utf-8?B?TmNCUnp4VEwrSFZFanNONGpEdEMwYWpvRWJDcXZ5ZWM3UHVmMXRUd1FWWEZz?=
 =?utf-8?B?S0h2dFNmWGpJTlB4TUhFTGJXZTFWT3cyM0wzZW1BcTdJYWJuWnZqSmFBc283?=
 =?utf-8?Q?yFxiMDsCn/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnV6cURVRlU1NmlWWWg5SU85c3c5U3NlSjBhQmhuMjM3NTUvOGk2Zmx3dmsv?=
 =?utf-8?B?MzVOSEdIQ1J6TWlDekJYMS9ROFI1UmhIaEx5TGlwMHJSMFZhL1NOZFRteGZM?=
 =?utf-8?B?bnoyWm9wTmZmZzdLVXBlMWxZTUJ1cVB1N2ZTWURFKzNCY1Z2WXhhak8rZDlJ?=
 =?utf-8?B?RlBqVm82N1pweWRMQ3B5QWRFaVp6ZkQrNHZOQnNvOC8zczV5R2U4eG5YaVUz?=
 =?utf-8?B?US9nbzNZR0Q3MDV1WTlpb0U2MUEzVEw5MWZxcXNPVElmejBHS0pLcjJiN1M3?=
 =?utf-8?B?eHhFQW9SVjV6YkgzTm5rMkY4WXZtZWNyYzRzZ0ZjL2JCRUw0NUw5a3luWkEx?=
 =?utf-8?B?cFVCZy85dy90VjBpOVB3YUNZdS9JSmtiQWhwMlJaSUIrQ2ZnM25FZldSU3dw?=
 =?utf-8?B?QnltZTFmeURmWDZHT2dJMVVicjlTNWZPeG5uSS9jOTVzUDlxT25lRXNoWWt3?=
 =?utf-8?B?WjhPZ1h0emMzMTVxV0dzTThYQzhNeGNQOWRYVEJ1anhrSXBUc09oQy94dVdG?=
 =?utf-8?B?S0lrTWhaMEphazFQMVpmSlp5T2R6U1FUQmtqbWY3eGY0QzNkYUx3b2Fnak9n?=
 =?utf-8?B?Y3FsY2FBSVZucFdKNWpWSUZPNVo0SkFLYnFhNHVWSXVMaUZtUHhZS05GSldn?=
 =?utf-8?B?cWlGQVJsSTdVZEYvL2kxbFNrL2l6UExWclBXSjZjdnZqdEZOYng0RWVXRlN6?=
 =?utf-8?B?UzM1UnpoT3Yvc1VER0FndDliREZnV0gvdi9QSGYyOE41YkZMSkpPNkU2bGRJ?=
 =?utf-8?B?TVpUL3NKR0NLOTJaemx1d2xSTkFQQWVqL2dVNURoeW1yWUJFcGJjWEVuNER2?=
 =?utf-8?B?cjlrMHdXdW5STWErd1BTUktxcEFEUEY2WXZ5NjBUelVpeWRPYUlVUWhXOGJV?=
 =?utf-8?B?cWlXa3BqQjRFMEpBd1BaU3R3VUtXV2o1Kzc5djNtbFBjNStKRmRQUThOVTdH?=
 =?utf-8?B?c0paS0loeUw1VDBzRDNkbFg5aTB4SFZCblZyQzBCbXVmam9mVlRRZko1NXdG?=
 =?utf-8?B?MEZZK2hlYjV6SGVtczBvV3g0V1c2VG5RK3VTTWV6aFphMEUyOEU0cGlNeXBI?=
 =?utf-8?B?allubngvb2x0Wm11VlF5amdmaEd3SjhKWTl6REZ4RE1pR2xjbEZTNWNxZ3NW?=
 =?utf-8?B?eUJxMDRkWXVMdjg0MGVOOW12aGo3VmVUWnFRTGVoZm9OQnhSbHJwV21ON25K?=
 =?utf-8?B?SUtWb09Hb3pvVDdsZFcrTXJHd3ZhUWhURzRSKzE5NEZlSjVoelNzSlZIdVFt?=
 =?utf-8?B?TkgvNXlBT1VlL28zemRaZTFBK21qcGk1RkxrVzZQSUlreGNJclpQWlJ1REFT?=
 =?utf-8?B?Z2RkRTNpTXd5Y091S3NWTmZ6SHdHN0xOQU1yOEw2VUZUL0h4VVpvaTA0RlV4?=
 =?utf-8?B?WDlxUHhIbGduRjBndWhMT3dRSUZKams5YjU3K3FCYWdUbjlXUkJoUERHWTVh?=
 =?utf-8?B?MkdKMWUvVjVvNldxTVJTeHpVKzc0dU5ya1h4aWljN0dxd1VpNVdXSTdjQWJC?=
 =?utf-8?B?bnZOY1p4YUFqcGNVQUZnSmJVWmVkRE1LM0hiTktlaTJlWXE1NWZrOUdQWjVR?=
 =?utf-8?B?eVZGRGUrRXYzZzY0OWRISHhYQjk5ejRPNUdqWWtCS2w3UjJJK3ZtMzBSMGlE?=
 =?utf-8?B?a0V6eFFxRGlBdmRLYkYwaWs5VndQZTlUNFB5bHU0TWt5TmZzWHJIK0NmaElG?=
 =?utf-8?B?RyszUlNMdFcyTWVlK0tIY1NOdGMvbzVTRWlSS09CVWp4eW1oU1lKZEczNFRn?=
 =?utf-8?B?MkkyYzhOam9yZ0NuajM0MVFaeUh2REN4Mk9ZMU0yMnNtQTJQblN4ZER0eTdl?=
 =?utf-8?B?TW5rWSt5MU9ITlJxa0k5eFlnVytINGxDMFBpS3Q3SlhLc051dTZqeEpWdW85?=
 =?utf-8?B?WDB0NE9NZHdlS0tMT1VjMlNXWEFzRnd4Qy80UENnL3AzUUR5QmJYMisyRXdh?=
 =?utf-8?B?WFVnVkExZ2UyT0x2UHVuTkhHQ1JWRVlJd1ZJMUFLSjFyR2I5NEVVUFlzT2k2?=
 =?utf-8?B?MWdLaHZqYXI3b1JaNjhOUTNLczM0djFRcnU0NzQvSDNJamtBU01wRjl4UHRG?=
 =?utf-8?B?ZllNaWpjSkZTQlZsUUtvTE1KSXhoUlpCb2ZBYXVhdE8yR2kvOHdSdzVVRU1K?=
 =?utf-8?Q?UQ1gLpYhHW2GaSERtwW8umpZ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7998156-9779-40a1-091f-08dd76b9ca13
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:24:09.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gi5+303Ygr2h6QtPZRl6QR+BLJomV4e8cSSYzBLO0kKKU1S1ifCzNU6oo4lYvAYtt3YnRNazUydqUanMi7fMTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF78FC67EBA

On 4/8/2025 4:00 AM, Jagielski, Jedrzej wrote:
> 
> From: Nelson, Shannon <shannon.nelson@amd.com>
> Sent: Tuesday, April 8, 2025 2:31 AM
> 
>> On 4/7/2025 2:51 PM, Tony Nguyen wrote:
>>> From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>>>
>>> Prevent from proceeding if there's nothing to print.
>>>
>>> Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>>> Tested-by: Bharath R <bharath.r@intel.com>
>>> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>> ---
>>>    net/devlink/dev.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/devlink/dev.c b/net/devlink/dev.c
>>> index d6e3db300acb..02602704bdea 100644
>>> --- a/net/devlink/dev.c
>>> +++ b/net/devlink/dev.c
>>> @@ -775,7 +775,7 @@ static int devlink_info_version_put(struct devlink_info_req *req, int attr,
>>>                   req->version_cb(version_name, version_type,
>>>                                   req->version_cb_priv);
>>>
>>> -       if (!req->msg)
>>> +       if (!req->msg || !*version_value)
>>
>> Personally, I'd like to know that the value was blank if there was
>> normally a value to be printed.  This is removing a useful indicator of
>> something that might be wrong.
>>
>> sln
> 
> 
> Actually this still works the same - when there is no entry that means
> that the input was blank, so it still gives you some message.
>  From my standpoint that's some sort of nice-to-have preventing from printing
> the data which has not been inited which most likely is not intentional and
> doesn't look good imho.

A label with no accompanying value gives different message than no label 
at all.  If the label doesn't appear at all, the user isn't given the 
obvious clue that data is missing, and may not even notice there is a 
line missing.  Printing the label without the value clearly shows that 
there was an expectation of data to be printed.

If the particular driver wants to use the blank value as a decision 
point for printing the line, then the driver itself should decide to not 
call on this routine, rather than this routine trying to make that data 
filtering decision for all other drivers.

If there is a call into devlink routine to print a label and a value, 
I'd prefer devlink to print that label as it was asked to, whether there 
is a value or not.

sln


> 
>>
>>>                   return 0;
>>>
>>>           nest = nla_nest_start_noflag(req->msg, attr);
>>> --
>>> 2.47.1
>>>
>>>
> 


