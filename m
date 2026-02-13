Return-Path: <netdev+bounces-258572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOHNImjMjmkRFAEAu9opvQ
	(envelope-from <netdev+bounces-258572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:02:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 008B01335D7
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D08A30517DA
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 07:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1B326E708;
	Fri, 13 Feb 2026 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IXwG4QdK"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2032249E5
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770966093; cv=fail; b=kKdARB76skT7sp1FmfJfxWBHafxFDCuRQpKkI6EgefMmt1i1ZTT67dsOV7Jsyda5vyJQI6k9HgOejIyfO2dcPfuX/l6kXMqdAV+bate07B1biCdm3mBLnyeBW2a2NFQq2HHO22qXi4/juohGhArgFSBhTxiJFouvb4AszcRGtUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770966093; c=relaxed/simple;
	bh=9kITOlwcx/+K1wSQwjOTOsZbvQZ1JdE9MGn/5LlgjtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Poui9ZaXNk8Y16LA2v8tgCQmblV+TYswuI24zbrPo35c8K0HgXLlOIHpGL47/mhIUCmsnxPyDjpPxYMoQ0KIaMc7N7SLJoQnr05LHbRL2S43J42/sNIdbVtznfjgbKVsAPxua3BIw/GmR8DuBA+3ZkORzVXcsmbwk+LdgG4w3cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IXwG4QdK; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFbGYTx2xBp9xdk7vSXyBoj1oCoCuTUIiXjFEYGoFWa8WLT4lJY7cDvm/gCzoUbGXz4Fpbvon/LxEORtPBKyyKI/6yxM3eQyaItVDSEbFimCNmL2TZ/KpeaWy+SpQOO4pZArqwxMylBfnsq2ARJODrLju3lrnaUyJiq28kwwN0HWQoSIMv9jweKkuLGvglqsVCYtbqyMTpa2Wn0dnLhmhj/Qt4DZSFo7H8v8r4PMoF6GIRztC5lPq1/JZCZ/ytrdhabt2h217JvtmlmScrJdfwHlUoRleKxGmdgjVcu6Q6B/ImmPMxxcdHlsBNE2gNR1CMsy/pIkH3xyUuKfwxjRBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGYTPYUu/ct4l/Ux9YUxUY0GGJ1mx1E+GR52M68RaWU=;
 b=QeFSQijmXoqHbu6ohao8QPN29lyu8yo+m4U/3c1KnNVixvAGpvhMCazowM+HYNaIiocHRvCuHuWZCdpuUEF3PfVSWcRFbpV2vrjnF4Ofh8uDHXfB3skKwIXYJEzjw8EYXLZreCdLOIHrfQLXiE5vjQfXGufC41s0r21AohGXw8rR8hLL17YPE8Gas+eku1TZbLeB4DIhkUg9IMkSbgSdSfkHHKaSFUZpwavhqt4VKlY+L5jd9SIKCOafF4iXSp3OD6c8x8g6U9TiG+OzjVBUeHrwx2QMoHmyOhh1tOWXgyLmnwh52+K2uYP4RxKW6pftf3Jt2oPcJ5B+CAqlH1mgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGYTPYUu/ct4l/Ux9YUxUY0GGJ1mx1E+GR52M68RaWU=;
 b=IXwG4QdKtdTQ6dvmSC3q/TotaelWYcYLO7e9kiRuYlRuJriQKTSvZDprYdGtFupl+ITJQPyA4G371uH3iTyZ1B5KPn+wrdy49T6yrkbCfklRh3TNk7p2ntfFOjcd5eCxf9cE3bdKUQYMAIZbuhCL6sQtnLeiWbE7UGCU7r+uoil+puQ681TbiSVo4QVecioW7PUoR3IU/Ig5cez2bNBxrhUq4RNSJKdQd+Tp/bMdZ9hXQSbMQhUs63+77bX9PPOgwJMBOI7IzsVjgIL5OmcD8McwG6rY83NY6BNmr6GN6sYF0BTZT+3Xi2e4XQOnSszs1CnPk94I2bpRct/RREBF6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 07:01:28 +0000
Received: from DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd]) by DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 07:01:27 +0000
From: Nikolay Aleksandrov <nikolay@nvidia.com>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	petrm@nvidia.com,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <nikolay@nvidia.com>,
	syzbot+d5d1b7343531d17bd3c5@syzkaller.appspotmail.com
Subject: [PATCH net v2 1/2] net: bridge: mcast: always update mdb_n_entries for vlan contexts
Date: Fri, 13 Feb 2026 09:00:30 +0200
Message-ID: <20260213070031.1400003-2-nikolay@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213070031.1400003-1-nikolay@nvidia.com>
References: <20260213070031.1400003-1-nikolay@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To DS0PR12MB7928.namprd12.prod.outlook.com
 (2603:10b6:8:14c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7928:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: b8592a00-a44a-4608-3f40-08de6acdb56b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gOGDGJYkg2DaHYIP6tL5+QLwmKFfdHB01oX/PUoMbSypXRfK6Cc1Z//33H6Z?=
 =?us-ascii?Q?pOrabnci/0Zx7L5bbioNMwVuu3u2U5vn70LPncWL8yV6yM5ApDodzKAtJCfX?=
 =?us-ascii?Q?Q0epm52tQyCD6/OFppVPkU90lzVmXIl64h6nWdX1qSL4gXlFD2iwbBRNG69H?=
 =?us-ascii?Q?YoSlp//SVf/dsTql0CDJkMBCoOgsJ8myrfOoSOJX49skby1fK6rj35/8ee21?=
 =?us-ascii?Q?vfURkoj2bdRb42ezhiIQ7XXltntrcfZ0ZGOKTJzYg7rniCOJZ/J5zXMlGaL/?=
 =?us-ascii?Q?UW+c7aK3mVvP5goBUUNBxOyP7E0qJiBpqDa5Ah4kO6CozTZtXv3ODmk4gdPf?=
 =?us-ascii?Q?6waTwAMUqMMdOhjhZKEFS7ytN6MY7/n0kwFvxlya+n6wYoX3FVfEn6Yxy5Va?=
 =?us-ascii?Q?0JNqEy9wT8JEy6SKf1Ody5FlAu9kxgttvl3bla4CqGTo89Ams5lZnHIfsjPK?=
 =?us-ascii?Q?2tGi2bz0bN2zaY2tBboOijTb3LepakhpqPGjXevYJ3S84uoH2odscGGuO+dE?=
 =?us-ascii?Q?WLXopX9OwLdUQK/SoCCIQNukZM2CwqCdCbyDkoTfoEdMM24JwmrxEHM1g01x?=
 =?us-ascii?Q?bBO9BttYNZositMLehSW2FyVlfqnxNIiF+RsglLKByysP6+DOaSpqZ9h7+un?=
 =?us-ascii?Q?Yglqgagt7icF41nhyMRIOpbvOtrbLlspI/RuJDm9xyBC+sWzMMrvjdTJB6DL?=
 =?us-ascii?Q?WCffoN4K1+yZBtgmYqjKnXFWDstQuiQao/xo8Y+4pjOn4nqhdYEsN9dZnBhG?=
 =?us-ascii?Q?mXag1HoN0fKh9l38XMzR5W/uRraplZ9S8m05QZES/jOMjlNjNzA70z96vKfh?=
 =?us-ascii?Q?SNmYDITbwKT6yLBKFqUZqHYDZ6MQ3LYvIHgYBjluWe9y7L2azuV4vTlTzkTm?=
 =?us-ascii?Q?2SrGyhb1tHrjFt5SlDGdQSCMf9S/Nbat2wFi0uHBuke1X/Za5+RqhymTl00F?=
 =?us-ascii?Q?E7JYBsNqYChdNCi9nQ5+ZPM3DhAQUWwyAV5rlMJ0i25mHorix+xJ4uERsJR2?=
 =?us-ascii?Q?hlhAoGvyo8Jg2wj8ypSUJb3SC3uKWAJ2FHmfEbvZSRf+DX0rh6Ej79yxq7Ah?=
 =?us-ascii?Q?htNsggzcgmnYMKClltNhujii3QL9fQ2uL5mZWsD3pBib9G4b3JuIoY2C3bvS?=
 =?us-ascii?Q?bvTU8T3fwlMr4f3fNfQsoTrJ7RAyv16iCOsKSdV63koW47CTBY5NH6/Dw8v/?=
 =?us-ascii?Q?QORUKShWxjsOvJ9J3O4RRIjRU1Qrhrd1SpKHgvF3fnsMKgtzuod7/mSlzxct?=
 =?us-ascii?Q?LYN8y8QGUXSVnh0kMfiGF5VgXau5sttP731sGMW5MlEZEj/oxPLj66MS4Jq0?=
 =?us-ascii?Q?LiRaWqsh5NJd4eEbgeU+rMXr5b9Ff5Ai7o4RNadctyhOkj3tE4qQXJhiVxgJ?=
 =?us-ascii?Q?bEQj1RECk7EYqV8qP8gVwmwdfnFgMaySPlMZ7P9+qS8u0gdWLmjznxHxu26V?=
 =?us-ascii?Q?orcpwf6RjQQQyZ6106RT4g7WKG8fhSJlj/9fFzabDQjPqluEWMRIC8NG8Yk1?=
 =?us-ascii?Q?qRcGhCUBO7KtVYVyCuwF0KAXLBIy4WMDYt6qLEwwPQaSWBEzOjEXbS2jP3Tt?=
 =?us-ascii?Q?WR6Sb+aZUuhxCdZaPK0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7928.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?06d3cAVbBwJkubwN/7xOLLFTOnQanuqnlXfXNxshfpBao2mni6BygtX/Oe2f?=
 =?us-ascii?Q?kpKhhCy6ZE6V+ACi/EFV+egQ3EG60C/f5ydytup3aeguB8HELhX6+BNjW8YG?=
 =?us-ascii?Q?PERFCUq6KrS41I3mJ8ZC7bQL95RCEMUWMPS9AlGC1LZHP+TKzvXXOq6COT/g?=
 =?us-ascii?Q?0G6EDz9N9pBsjz6+ZcqoGMVu5EkGkBkYauJsYQ777q0AL+lSy+5mTx/oGQBk?=
 =?us-ascii?Q?fpfH9JIiFeOVoU8PHchADWTu9spKEIwLwDSZ8zdn+r/JpbosZJuEndC96bat?=
 =?us-ascii?Q?3qKj29ehQ0k6wRAuhPBRkPsV3ospAmIeNmhhl2zg29TLlKxplCz1SQxiKWmi?=
 =?us-ascii?Q?f58iZVOWn4HKD93u+eYcVs5e0KV+l6GAigbwL108h1JFshANghoylN4ZjZXa?=
 =?us-ascii?Q?NwCNrdUAGRfYYbZhyPXSmr5E8r05JpyhaCHbtcaT9XWr8oReP0+RX2QQFvuY?=
 =?us-ascii?Q?5EyfCCbUpAHvQcGP4emhzLq/MQfYcd4DLkaHHKGLCIHdbXGlLOIeI08+vRiE?=
 =?us-ascii?Q?Kv3DRs3RDhYlnibEmijTVOa0CG5c7dWDTySeSVjm+clp3g2NErzWwceU53DS?=
 =?us-ascii?Q?uGA+2whfHqYafXs/4kqN6z/YSvx9ZW8o/+K2V6ybH8mVgDLklvSIG5YeHBjh?=
 =?us-ascii?Q?u/wLEB2Z5JDNTnLrGEOUu7ZddRtMo6fTlmRuCjgPmtzrz/r0xeA80iX3tf7h?=
 =?us-ascii?Q?3B8UC4JGSkae6kTJcAmkAn5VN7Xn/coTqmB85dOYkA1Sd2lUlQbX4+WzwDuo?=
 =?us-ascii?Q?AmWMFSwetG18GW2jmU1uWBXD4hmtExPa8j2yzMEHRc85J1Wz+0HZY8OVf35B?=
 =?us-ascii?Q?dKepg9bqVndZxMcHlT1JEVR+GBIz1L3Gls1L4LEx3LwVdjXPX85z6WXscy62?=
 =?us-ascii?Q?TJMIz3lshRo39a0Y3WQo3vuszYJU4vNePZQ2Gy/gNSsvOzgNtiCHRLK6FviA?=
 =?us-ascii?Q?2see9GlzZhKHhsgNxwc0WKwnRbjyGVyU5RQkeRqx7kFHnYo/AlhowOHpc7nN?=
 =?us-ascii?Q?IGK/bsg3pxzHM6OHfEV1DhlIhDzph/0McODAfXfdZHX2IWRfisq49wv30UgY?=
 =?us-ascii?Q?7X56SkRe8njY1yrPikFlG65ni2ehfn8Xf8z1gPMommQS7wAMlvoBxrxZKZoE?=
 =?us-ascii?Q?TM2BGAOP2oI8uRxUkGIvj03sAnBJ0YihayDv+bfV/0d+1kgoGCJM3hVRhxS0?=
 =?us-ascii?Q?+z0U5hSE266/4TIgG3HMSPZPYC2i/C9rjiMyPd0pF4px7S0VTIN4r5fT2z1Z?=
 =?us-ascii?Q?Gp4hRYzyNxSW9a6QLigFgxjUE0bd4yQ0fRvXy4elnaWskSr3bzvc9XOgKOB9?=
 =?us-ascii?Q?W5glwguGObyorjMSSksfBrHHbJno6s3GtsFl+CFFFUbpK0FukTJPMR8drADR?=
 =?us-ascii?Q?vILOy0qc7yJYYgpWm+PzkNm5wmtUIqWBAVx5osMCwLaJVi/a/z+XC7+xR55o?=
 =?us-ascii?Q?ycwABGmu9d3sf9WQ76fMw4sg+/hukSg8cW8evhUhHnsHhenGrao1skf+mvvX?=
 =?us-ascii?Q?SFUBRK9Nd9exitGPtiCKDw5KWde9HqUKJTYyDC6JQ8oxokFq9TSkyWkmRbm8?=
 =?us-ascii?Q?GxRWJveWckEez8NmgHKgzrktlXQKXqZWvyFgYKD9iwC1WZFUF3yBZt0Q0zr9?=
 =?us-ascii?Q?zurWzGuz6vDQq9rLZ0XsGEHwNUJ8UC24bsuGP162MhUaRnn7AW/9hsdgPinV?=
 =?us-ascii?Q?c90JOElwzOFVvRu+ZAxiqbyFmo2oUclLAe26DrXOefvprKMW/0QGnbroS2Qr?=
 =?us-ascii?Q?YG6ShyhaFw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8592a00-a44a-4608-3f40-08de6acdb56b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7928.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 07:01:27.8843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMypNIQUN3fbaYiS0WdCpBBkvGwjjq8P6kDNS0WqUDuiNpP2czbiwnVn3V4QFscIdFfyVQAxCw21yyIJ1Ow/rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258572-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikolay@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,d5d1b7343531d17bd3c5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 008B01335D7
X-Rspamd-Action: no action

syzbot triggered a warning[1] about the number of mdb entries in a context.
It turned out that there are multiple ways to trigger that warning today
(some got added during the years), the root cause of the problem is that
the increase is done conditionally, and over the years these different
conditions increased so there were new ways to trigger the warning, that is
to do a decrease which wasn't paired with a previous increase.

For example one way to trigger it is with flush:
 $ ip l add br0 up type bridge vlan_filtering 1 mcast_snooping 1
 $ ip l add dumdum up master br0 type dummy
 $ bridge mdb add dev br0 port dumdum grp 239.0.0.1 permanent vid 1
 $ ip link set dev br0 down
 $ ip link set dev br0 type bridge mcast_vlan_snooping 1
   ^^^^ this will enable snooping, but will not update mdb_n_entries
        because in __br_multicast_enable_port_ctx() we check !netif_running
 $ bridge mdb flush dev br0
   ^^^ this will trigger the warning because it will delete the pg which
       we added above, which will try to decrease mdb_n_entries

Fix the problem by removing the conditional increase and always keep the
count up-to-date while the vlan exists. In order to do that we have to
first initialize it on port-vlan context creation, and then always increase
or decrease the value regardless of mcast options. To keep the current
behaviour we have to enforce the mdb limit only if the context is port's or
if the port-vlan's mcast snooping is enabled.

[1]
 ------------[ cut here ]------------
 n == 0
 WARNING: net/bridge/br_multicast.c:718 at br_multicast_port_ngroups_dec_one net/bridge/br_multicast.c:718 [inline], CPU#0: syz.4.4607/22043
 WARNING: net/bridge/br_multicast.c:718 at br_multicast_port_ngroups_dec net/bridge/br_multicast.c:771 [inline], CPU#0: syz.4.4607/22043
 WARNING: net/bridge/br_multicast.c:718 at br_multicast_del_pg+0x1bbe/0x1e20 net/bridge/br_multicast.c:825, CPU#0: syz.4.4607/22043
 Modules linked in:
 CPU: 0 UID: 0 PID: 22043 Comm: syz.4.4607 Not tainted syzkaller #0 PREEMPT(full)
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
 RIP: 0010:br_multicast_port_ngroups_dec_one net/bridge/br_multicast.c:718 [inline]
 RIP: 0010:br_multicast_port_ngroups_dec net/bridge/br_multicast.c:771 [inline]
 RIP: 0010:br_multicast_del_pg+0x1bbe/0x1e20 net/bridge/br_multicast.c:825
 Code: 41 5f 5d e9 04 7a 48 f7 e8 3f 73 5c f7 90 0f 0b 90 e9 cf fd ff ff e8 31 73 5c f7 90 0f 0b 90 e9 16 fd ff ff e8 23 73 5c f7 90 <0f> 0b 90 e9 60 fd ff ff e8 15 73 5c f7 eb 05 e8 0e 73 5c f7 48 8b
 RSP: 0018:ffffc9000c207220 EFLAGS: 00010293
 RAX: ffffffff8a68042d RBX: ffff88807c6f1800 RCX: ffff888066e90000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000000 R08: ffff888066e90000 R09: 000000000000000c
 R10: 000000000000000c R11: 0000000000000000 R12: ffff8880303ef800
 R13: dffffc0000000000 R14: ffff888050eb11c4 R15: 1ffff1100a1d6238
 FS:  00007fa45921b6c0(0000) GS:ffff8881256f5000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fa4591f9ff8 CR3: 0000000081df2000 CR4: 00000000003526f0
 Call Trace:
  <TASK>
  br_mdb_flush_pgs net/bridge/br_mdb.c:1525 [inline]
  br_mdb_flush net/bridge/br_mdb.c:1544 [inline]
  br_mdb_del_bulk+0x5e2/0xb20 net/bridge/br_mdb.c:1561
  rtnl_mdb_del+0x48a/0x640 net/core/rtnetlink.c:-1
  rtnetlink_rcv_msg+0x77e/0xbe0 net/core/rtnetlink.c:6967
  netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
  netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
  netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
  netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
  sock_sendmsg_nosec net/socket.c:727 [inline]
  __sock_sendmsg net/socket.c:742 [inline]
  ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
  __sys_sendmsg net/socket.c:2678 [inline]
  __do_sys_sendmsg net/socket.c:2683 [inline]
  __se_sys_sendmsg net/socket.c:2681 [inline]
  __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x7fa45839aeb9
 Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
 RSP: 002b:00007fa45921b028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 00007fa458615fa0 RCX: 00007fa45839aeb9
 RDX: 0000000000000000 RSI: 00002000000000c0 RDI: 0000000000000004
 RBP: 00007fa458408c1f R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
 R13: 00007fa458616038 R14: 00007fa458615fa0 R15: 00007fff0b59fae8
 </TASK>

Fixes: b57e8d870d52 ("net: bridge: Maintain number of MDB entries in net_bridge_mcast_port")
Reported-by: syzbot+d5d1b7343531d17bd3c5@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/aYrWbRp83MQR1ife@debil/T/#t
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
v2: no change

 net/bridge/br_multicast.c | 45 ++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index d55a4ab87837..e9a7e6530401 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -244,14 +244,11 @@ br_multicast_port_vid_to_port_ctx(struct net_bridge_port *port, u16 vid)
 
 	lockdep_assert_held_once(&port->br->multicast_lock);
 
-	if (!br_opt_get(port->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
-		return NULL;
-
 	/* Take RCU to access the vlan. */
 	rcu_read_lock();
 
 	vlan = br_vlan_find(nbp_vlan_group_rcu(port), vid);
-	if (vlan && !br_multicast_port_ctx_vlan_disabled(&vlan->port_mcast_ctx))
+	if (vlan)
 		pmctx = &vlan->port_mcast_ctx;
 
 	rcu_read_unlock();
@@ -701,7 +698,10 @@ br_multicast_port_ngroups_inc_one(struct net_bridge_mcast_port *pmctx,
 	u32 max = READ_ONCE(pmctx->mdb_max_entries);
 	u32 n = READ_ONCE(pmctx->mdb_n_entries);
 
-	if (max && n >= max) {
+	/* enforce the max limit when it's a port pmctx or a port-vlan pmctx
+	 * with snooping enabled
+	 */
+	if (!br_multicast_port_ctx_vlan_disabled(pmctx) && max && n >= max) {
 		NL_SET_ERR_MSG_FMT_MOD(extack, "%s is already in %u groups, and mcast_max_groups=%u",
 				       what, n, max);
 		return -E2BIG;
@@ -736,9 +736,7 @@ static int br_multicast_port_ngroups_inc(struct net_bridge_port *port,
 		return err;
 	}
 
-	/* Only count on the VLAN context if VID is given, and if snooping on
-	 * that VLAN is enabled.
-	 */
+	/* Only count on the VLAN context if VID is given */
 	if (!group->vid)
 		return 0;
 
@@ -2011,6 +2009,18 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 	timer_setup(&pmctx->ip6_own_query.timer,
 		    br_ip6_multicast_port_query_expired, 0);
 #endif
+	/* initialize mdb_n_entries if a new port vlan is being created */
+	if (vlan) {
+		struct net_bridge_port_group *pg;
+		u32 n = 0;
+
+		spin_lock_bh(&port->br->multicast_lock);
+		hlist_for_each_entry(pg, &port->mglist, mglist)
+			if (pg->key.addr.vid == vlan->vid)
+				n++;
+		WRITE_ONCE(pmctx->mdb_n_entries, n);
+		spin_unlock_bh(&port->br->multicast_lock);
+	}
 }
 
 void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx)
@@ -2094,25 +2104,6 @@ static void __br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 		br_ip4_multicast_add_router(brmctx, pmctx);
 		br_ip6_multicast_add_router(brmctx, pmctx);
 	}
-
-	if (br_multicast_port_ctx_is_vlan(pmctx)) {
-		struct net_bridge_port_group *pg;
-		u32 n = 0;
-
-		/* The mcast_n_groups counter might be wrong. First,
-		 * BR_VLFLAG_MCAST_ENABLED is toggled before temporary entries
-		 * are flushed, thus mcast_n_groups after the toggle does not
-		 * reflect the true values. And second, permanent entries added
-		 * while BR_VLFLAG_MCAST_ENABLED was disabled, are not reflected
-		 * either. Thus we have to refresh the counter.
-		 */
-
-		hlist_for_each_entry(pg, &pmctx->port->mglist, mglist) {
-			if (pg->key.addr.vid == pmctx->vlan->vid)
-				n++;
-		}
-		WRITE_ONCE(pmctx->mdb_n_entries, n);
-	}
 }
 
 static void br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
-- 
2.47.3


