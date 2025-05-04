Return-Path: <netdev+bounces-187652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A73AAA88BE
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 19:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A7018927F6
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4474523DEAD;
	Sun,  4 May 2025 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X0KqicWU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8F23D29A
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746380821; cv=fail; b=vFySn5qLHFZcxL3FXU2Z5jV4V5FJW0nNs657+W5nJ9qOWcYCTbiHd/0jy6WN8kLXEYdL1joJf/tJOcUN7hVIsHYuadr+DoJJztoOQ3KvU+wy3l2ooxmtdYOY1nJwGf5lTey8BHWl9j17lkJ3h890iRkNqmetwk7wlacXKTUlIe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746380821; c=relaxed/simple;
	bh=eockNqmOtE5GF2MJCxclu2YfnS7kdg2FZvsAA++u+vU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r6fZT97jrHDhQJSXemxFXzz10a0oerVGb/ZhoKht8xSGywhDbzjTMdzN0vkeZJs30ev5hixpWnYCXbyPGFTXPL03r5S44CFIkpJ8iboffmp3cSKy6y6Dis3rnhIzZGCqQd0JJk6QdCc7Un9deaUAnUv/pqYIQzpiZ0y/mIVqhxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X0KqicWU; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXi6mDFcWF2oUztNT6Rs3UH0R01xaUhXY8Ky+RH63Lqu17BbaSUgnverSilY2qeCCr5JxTVvdXZoiZWbGHtKIzsK9UPXDfV9FHzmBKKoO5yOBDovHRE3Se0x3NyO+dWqkzbsfhZC1YyW/pKgX2s3d5X7//WGmQmR5MtRqgvqxwaAKsWnV/4v0oDJSNQw9BhuT33sjiWZ84GpAgzVeepWrKkEADX6/uUSnFeeaXbx2oR1hna58fYamafaAxltUaPqWjjbLHrwJKIlpanPwkL3/DLeKdCIPF7lYuj0x3eD+y5vb9oyFj/1G4QQMBshxrhMXeGwF//22qQMkFZeVK3kEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzqhNCfedYckLR6v9m592WxmPjN5q0UIqvbFCGKfpzs=;
 b=gkN4M6UzXgWoO9n/TJ0jtLAEHzRsxI4+FdSaElpXgz1UDGQcOBewq/VsfvN0Se5NmtzaGNud1SjoqMCBcnfJ3ruE1AWN/ByrAOf9/gBPgBWT+QiUqoFhUr5c3sa8876RNzHZXAAtxS/dYqmUTC+1QwIQBAfjCeLN/Cb+K888tj16JpsVYZvSLrVG7gNi6Nlh7orrGAScphH5bM+L9nLHhNd63zTqo9w+uaWvVJsMrfrkAcVW+1j+/60JU+uG47ECFhbym9V0N+huBtbyOKih6hpKVQqMNu97KGX2elQ5L3bQvAU35LcAXh1WqSLhmy7t0CimdG3agsRpLaD94tqnCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzqhNCfedYckLR6v9m592WxmPjN5q0UIqvbFCGKfpzs=;
 b=X0KqicWUBQR5LgnhMmsG1kbVOwBGeqj9ZEvMG6/jOF2cnMMpc+iSeUc4iC6z5l5tWmg3DqGRAreamh7reRzWchufVCn8lOwEgTZ7F3v0KcRNrLaLWhb1Mt0yQLUWkdeViUxkdQBzDULjNu0dTgn1pfxGRR00xSbF8hRMJpu3XAmycrczQZdN5a//33g3Sua8XpzQdtGKOTByXifKePrrZxn0PqIIGhwQIail/F/F21hohGPsZ5v+mEPTodx0UxQbVq+HgxXYZUvKjrgywnM251WM+wUV/8m6HE2dDfhI05fMeD3AuaAUmIVMH11sKn4MmD7OkiE3XZH7582ybnQ9ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA5PPFD8C5D7E64.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Sun, 4 May
 2025 17:46:57 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%4]) with mapi id 15.20.8699.021; Sun, 4 May 2025
 17:46:55 +0000
Message-ID: <d5241829-bd20-4c41-9dec-d805ce5b9bcc@nvidia.com>
Date: Sun, 4 May 2025 20:46:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink port
 function
To: Jakub Kicinski <kuba@kernel.org>, Moshe Shemesh <moshe@nvidia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
 <20250424162425.1c0b46d1@kernel.org>
 <95888476-26e8-425b-b6ae-c2576125f484@nvidia.com>
 <20250428111909.16dd7488@kernel.org>
 <507c9e1f-f31a-489c-8161-3e61ae425615@nvidia.com>
 <20250501173922.6d797778@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250501173922.6d797778@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|SA5PPFD8C5D7E64:EE_
X-MS-Office365-Filtering-Correlation-Id: 4650abc6-2b18-41c2-8ae9-08dd8b33a90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0YydmsyUHFidVBwc0FqUUdrZnRYTFRNNG1NeFFRZVFra3BOYmdVVVRtdUta?=
 =?utf-8?B?eTJDb2dmaHVoWi9LcWg3enpLYnhreHJTVlVENUVuRGNDOWxGb1hnOXBTNmFO?=
 =?utf-8?B?Q3FtblNVZjkzdTNUSFdTcWRnN0owTDcxSVR3bDVhQUw4ejB3WmF0V3AxTm9Q?=
 =?utf-8?B?VkRZRjNwY2o3R0JFY0ZXL0c1N3RyV3k2OFdCUWZUOFA2bml1c2xwZEIrM1lw?=
 =?utf-8?B?M3RnVDZNbUNTeG1VRTRES1NCalQwaC9IVGFwdEhnN3hnNmhXZm5OWHJHYTdx?=
 =?utf-8?B?VWZYRGlLYWdNZ2x5aDgyYVhHd3VsblBOeXlPam5WTHAvL1Nick1jODRzM3Fj?=
 =?utf-8?B?OWNrdDRnMGUwWk0wUGJiajIyR0wvYlpPY0VZT0V5ZUhHTS9VWkUxVmR1eG1M?=
 =?utf-8?B?dVVwR1E3VFo2bFBaWmlEdjZHQXdCZUxjaHAzbDh0Q3FmaHFDYWpOOW1qMVpD?=
 =?utf-8?B?SVZmazJSQjNOTjZzd2NtQ2FoTjh3SHhzRTZ3SDh3QWZsNXcrejRLOW51R1I3?=
 =?utf-8?B?bGJCckkxTVFZNUZSSjUzc3Q0VFBZT2xUbitUTGF3enZVdjFjYzJTeGRuQzAr?=
 =?utf-8?B?a1h3OS84a0M0bkR3Y1MzL1VVSmJ5aUxnT0FPRkRicTJEbHU0TVBwb0RFNXh0?=
 =?utf-8?B?S3VoUEt1Ymh6UjdTYUhGaUFMcDBtMGs1citxRVNPVklCZ1dIOW5pMm1GaVRE?=
 =?utf-8?B?Sy8rNmhNc3VGbmNnWnlsNWkreWxESE53dm4xMXdKRDc4bHBxazJmNUZqcFZ3?=
 =?utf-8?B?Q1BpK3pxVFFRSTFuSHhlOU1kN1M4aUN1a01kVit0YmlWL2ZMWm9halFaZFBp?=
 =?utf-8?B?MW4rREhUdEkwZDJRa0ZqZmRqZVZBRUUySEJxZy9VUkFBUlFkL0xEcy9KVkVX?=
 =?utf-8?B?U3BxS3VpdWkwenRCV2h5Y3FHdEowSFZHV3N3b2t6QXdXbittNFpCWG9MUS9j?=
 =?utf-8?B?Z2lSZVhCb2NyT3NIOHVkNFdHM0RjaWt1dEJYaUhNUmd2R2gwOS9VYzNCUG1T?=
 =?utf-8?B?c1V6bjZKRms0TFVRT3JEdFVaVytpY2NvY25XSlNtUlNjcEZRaEVGZFB0N1gr?=
 =?utf-8?B?SkJmZDc2cWJVZzBKWHJkL0d5c1owbmpzb2dKeFRScHNuT3diWU10TmZMRE1X?=
 =?utf-8?B?aS9XdDB0WWdiWGNwbDhBc2cyYWZmYmEyK0orN2x1WTYyVVRkcUh5UWpuRENN?=
 =?utf-8?B?MDdjVmJ6Y0xsbHB0STNrMzBqOEdEekUrQlVBc3lIdzdkL0ZZbm1aN1pPd2Jp?=
 =?utf-8?B?cll6Y2ZvelVmRjJaTWJZbUt5bWFJNkUyYVVkL0IwMHJNQUR5alB4UWxSWVZD?=
 =?utf-8?B?M1RzdXZpVEx2QzFiTXl1bGozdCtZTllmOG5IZ1RySlM4QXM4LzJIdW1OdmlT?=
 =?utf-8?B?dkxzbEJoSmRXTXJoMnlWaGpRbkhZWmIwVTdZMWNEQkdoOS80ZE5pZzJYenAr?=
 =?utf-8?B?djFkd1NicW9mcGVDcmR0YWJZRTlONlJxSXBncXdmbzU3QWN3MkNrWC9BRXEx?=
 =?utf-8?B?d0laQXdIelJCSTE3MXJYN1M0b0NxN2cyUGJZanZST2pYSlBTL3dTU0pwc285?=
 =?utf-8?B?cGEyM3lOTXZ0dGg0QUNHNGxuWFJZMzhxYVdMQ0lJYWY4d2l6bXlYQjhhVzlj?=
 =?utf-8?B?cWVaRWtrVU5uZHhSWVZoTzYzY1BJc3ZWc21rNHNIcGJzak5FNnhsQjhqVVhy?=
 =?utf-8?B?Rkh6d0t0UXBmTTZ6WmVHUHBPcmtZTWdUUlVWeEZ4TlpKL1d1Yjkrdy94aTZE?=
 =?utf-8?B?eGVzTnBrZm0wT1hkenk3alhTMDlmdmp6YzhHYnJzVFlBUGVXQ3ZxNDNHdk5F?=
 =?utf-8?B?ZVFWYkpBZUlxRm1sRlhlUi9TM3NkS3MzeXIydFNkT3Q4YmdCVUdCN3N6VGM0?=
 =?utf-8?B?STl1bnhONk1nb2lZOFMyNjhZRCtBQm5FeXJTV1czd1BHMnNZcHVsUFI4TkRt?=
 =?utf-8?Q?aMvlk3GTnCE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWVtRlR2TG9KU3UwdVFiaUFFZkQ0dm56Y05LY1hQbDBoZEpPSHFiNVoyRTJU?=
 =?utf-8?B?SUxyTzd6SmY5cUtTNzBhRFhkWVc0VDg0b1RiaDdKVG9ySzJWQWcyV2dUVzdI?=
 =?utf-8?B?cTZ3eG9Ba0JId3JySFkzVWM1TUY5YUFHcThkOW1iNEZvQWRPUWwyZk15UUUw?=
 =?utf-8?B?VjZOTUF1RlpuMDJWcTUwdDFtZ2tORGN1WW9PTVVPS1BjQ29MMzdaVUFDNW1J?=
 =?utf-8?B?ekRoNnNwZ3JGUEJLZnFsTlcxZGRvdlcvL1JBSmpJbGxjNUYrZVlTTW41TVF6?=
 =?utf-8?B?anJMK0RaVWYxV2g0SGpoYXpDV2ZaT0NMRTBWWWZQNHh3M1VrdkoyUGtWSzI1?=
 =?utf-8?B?eG91MzhsRFgxSVF3VVdBaVpGZE4yR2sxWXM5NE0zWUJjUXYrb21ncWh4Mndj?=
 =?utf-8?B?TVJ2TTBXclUyaVpLQTdFd3UzckJrU0EvRVlSUmJHenQrNkVVNjBFN2JWUFZ1?=
 =?utf-8?B?ZmJtVWJGSm9JSm1DQ25IekxSaCtub211MXlzZjltSU1Dbm1vdzVBQkJOekIx?=
 =?utf-8?B?dW01R1ZRcXlYdVdrekxjUUVYSm5DNlpWUlVqV2N6L2Yvd3NPTGlFRi80UVFR?=
 =?utf-8?B?ZTdMMVhTWnZhUmdTUjFJK2JEQmxkQ2NBU3F3bVI2bHdTeTl6WllaeWJORlRn?=
 =?utf-8?B?SThPbkFhUmYxU0NXSnVUSW8vREFhY3I1V2pML1phd2k0V3pyb1Qzc0F3dFYx?=
 =?utf-8?B?VWpZdTJ0amJjZlg4a2g2NEZnVEdlVXVwU0xEQjBrTUVKV21UUjRKYlgveW43?=
 =?utf-8?B?U3Nlc3c4NkF0WlBOWnNQUmw5RWtONDJpdDd4QldEakEveVZqTlpkVER5MThB?=
 =?utf-8?B?YnY0UmRoUnNsT3pkVUc2UkJqOVhYZWRka0NYQ2x6VFhMN0UyRG9TZ0s0VU5O?=
 =?utf-8?B?bkxnVDcxOTl5ZG9zVkJuVCt0STFlTkplMXowWjNuZDBjSS9QQmVWUEhNaW9D?=
 =?utf-8?B?NVRQUlJFa08vaFpHSjMxTDBVWVRWRFFPM3VrNHgzdHQ0S3dQUVlmTFpWY25U?=
 =?utf-8?B?d2h1d3c4Rk9lYkEzd1IvbzlOS2VLZUNqZzhldnpyQ1dSNUp2VVdxYWE1dHRJ?=
 =?utf-8?B?dWhkcEZ3OHoxMmVXK3JnZWljdjY3WEVabzcxQ3ErNlNMMWNxSjdlNi9PMmdp?=
 =?utf-8?B?SExzQkFPZGNBSHpYYkJSdVhUOXpoM04xYkJ0bDZzUW9PWjY1Z0trNmlGSGtN?=
 =?utf-8?B?NXh5KzRKbm5MNTR4VTFqbnFadHRneGpwYTFYbWgzS1JFelo1YmExYytMU3RW?=
 =?utf-8?B?Rmg3dU9jOG5rLzIvTGJnYktJaXlWOVdrQmNnZ0s2RmNPaTIvcGtZcWRWU25p?=
 =?utf-8?B?bFd2K0hxd1NRVFRVck4wN1lRWHVtN2ZURkR4MFdXVi90ciszUDB4dFZqVmIr?=
 =?utf-8?B?alZlY1liVE1LNFhsZkxrZXJqK0lnbmIybW1DMGZjQnpML2tQNG55cW0xdmZy?=
 =?utf-8?B?NHZzTk9NYWE4eFVoaEZUUzhTZmJnQzc4SjgrWnJBUnBKTXIvT0tpeVMyazF2?=
 =?utf-8?B?RlNUTEluOTJLTHVxNWFTUUJvK1JMSFJhSG83R2cvNmFBL1d1NFl1NFdWYUE3?=
 =?utf-8?B?R1o5ZGhzZ3lTT3hCRUtwWUh4eE5HL0duVmRGSitHV1JlUDNScWMxTTQ0VlVo?=
 =?utf-8?B?MVFWQ0JIbDNnTWhORmdReUpGaElyMmJkeUlRTW9TelNES2I5QTVueEZ4WVda?=
 =?utf-8?B?aEpLalBac0dwSzNhY0FuZWh3SmVrR0llYjVNRXduNFZPZFJVMEYxS214Ky81?=
 =?utf-8?B?aHdWMG00dC9mTmJRTVdJT1Z3T0NGQW1ZNm91c3diWmNhRWwxakV3UFNxaklO?=
 =?utf-8?B?c2diUm9hZitFc2pQWGhURi9IVFE0K1JzSWI3VjJkamwvQTBGOGtyY2JkUFds?=
 =?utf-8?B?YjhFbWlHZHJKQnJlMyt5L1FCMUhIMlQ1WG9UeFlVeExJQWlEb0NIeGJlaGpk?=
 =?utf-8?B?NkE5d1c2K1hiUTA4OWZWSXBvOHFPUHBkS1drR2dCUTRoMzFRSnFUbWhzUVcy?=
 =?utf-8?B?SFAzRFk2bHNTaU93dXpDWUtIN2ZucGpGaU1XYmN0dDVUMXlUWkU4RFA1Tnhh?=
 =?utf-8?B?MEpKaTYraDNrMmxzTHdNVG5tSFBhZFdSZ0gwYjM5cHhqcHR0N1V1OVBxVVpz?=
 =?utf-8?Q?OMjRUgvSqgN740Y24exM8bzJT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4650abc6-2b18-41c2-8ae9-08dd8b33a90a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 17:46:55.5448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHu9jBBt6Ei9S8d1X3bg/c0GYiLOJoHDoJu60mQkVdDhYyPH/zVnr8aYp8feNg3kDbrfuDkSFsju85xnO9gb9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD8C5D7E64



On 02/05/2025 3:39, Jakub Kicinski wrote:
> On Tue, 29 Apr 2025 11:37:51 +0300 Moshe Shemesh wrote:
>>>> UUID is limited, like it has to be 128 bits, while here it is variable
>>>> length up to the vendor.
>>>> We would like to keep it flexible per vendor. If vendor wants to use
>>>> UUID here, it will work too.  
>>>
>>> Could you please provide at least one clear user scenario for
>>> the discussion? Matching up the ports to function is presumably
>>> a means to an end for the user.  
>>
>> Sure. Multi-host system with smart-NIC, on the smart-NIC internal host 
>> we will see a representor for each PF on each of the external hosts.
>> However, we can't tell which representor belongs to which host. 
>> Actually, each host doesn't know about the others or where it is in the 
>> topology. The function uid can help the user match the host PF to the 
>> representor on the smart-NIC internal host and use the right representor 
>> to config the required host function.
> 
> Insufficient information. There are many many hosts deployed with
> multi-host NICs which do not need this sort of matching. I'm not
> saying you don't have a use case. I'm saying you haven't explained it.
> 
> We exchanged so many emails on this topic, counting the emails with
> Jiri. And you still haven't explained to me the use case. This is
> ridiculous.

Hi Jakub,

I'll try to explain the use case more clearly, I realize that some
internal context at NVIDIA may not be obvious externally, and we sometimes
take that for granted.

We're dealing with a multi-host system using a DPU (smart-NIC). In such a
system, each external (x86) host has its own PFs/VFs/SFs, but the E-Switch
manager for each PF resides on the DPU's ARM core (the internal host).

To illustrate, consider a system with two external hosts:

Host 1: PF0
        VF0 on PF0

Host 2: PF0
        VF0 on PF0

Each host is unaware that it's part of a multi-host system, internally,
each sees its PF simply as PF0, with no notion of the global topology.

On the DPU (ARM), we see representors for each BDF. For simplicity,
assume each BDF corresponds to a single devlink port. So the ARM would
expose:

PF0_HOST0_REP
UPLINK0_REP
PF0_HOST1_REP
UPLINK1_REP

In devlink terms, we're referring to the c argument in phys_port_name,
which represents the controller, effectively indicating which host
the BDF belongs to.

The problem we're addressing is matching the PF seen on a host to its
corresponding representor on the DPU. From the ARM side, we know that
this rep X belongs to pf0 on host y, but we don't which host is which.
From within each host, you can't tell which host you are, because all
see their PF as PF0.

With the proposed feature (along with Jiri's changes), this becomes
trivial, you just match the function UID and you're done.

As a side note, I believe this feature has merit even beyond this
specific use case. It makes the mapping between representors and what
they represent more explicit and straightforward. Which is always a
good thing from a usability and clarity standpoint.

Mark


