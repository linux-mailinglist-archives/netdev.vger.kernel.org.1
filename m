Return-Path: <netdev+bounces-268178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FFBJhAVuGl/YwEAu9opvQ
	(envelope-from <netdev+bounces-268178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:34:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 029F929B743
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC60E30329A8
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69339285041;
	Mon, 16 Mar 2026 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0rTE0lwz"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0FD26E173;
	Mon, 16 Mar 2026 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671649; cv=fail; b=SM23+QHCd9snxZRtPcqK8QQB2+xTvAnTeKQlnMDacqh4YHSQhb2p3fa02R/9+5upO6t6TqxrMVTOsRpVACM8gKOHZgDdjcBfKChbP71gjba/wJEyn4ripA2JTw0dhSe3JfCaG3K4GQ0qvO//YwSciv3ZHcwzlx3rn1ivqf88G90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671649; c=relaxed/simple;
	bh=DAJ5Q9RoPW5rTR+MNrFhb783lZG3fWaTSjURQ+G0GbU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mou9Ps3EUTXbxB+DhCuTShCClTj0h91cO8DxbHEetAEJYV8oOr/oI5C3kHdHod50tHppe18bh962yaHDUV/UmvDGO3pk/6CQ9242edjN777cekdEKCDHm4J3d3hFp4HZAfjdFR4cQUw6dphvmvHp8dVhxurlHWyCjkFFzVYw0YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0rTE0lwz; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIpxYBhQQWcpGFW4KoXupje9989Ya/HWAF8ixaVKbwx6Sb2UmYZ/HfQu4eZeTiGFd3OPx1OUgTEidmvLYPgZHkZmm1eKhntGs8mdKcvIarlPBq93HVMoUwsAu7yJRYDLDV5BI7leQ6XBiPYKPHUFGpRzdv+eoxA8iMMJX8efpBmvDucYuAMZQgSCj+xG4bn4kDI8y84xOVm3L+SaPWLsNkUDQzsuixbDy89D84FRggpu68VehMeQjN2P5dB+UYTLg5UHlGikzx9+ZyvjlBhJA3D/SLhZUV/1X96dOWPHIWKgLnQFOC5vfntbI4cOnmUTg/LSN+uaY7uh5q8qIM/ICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHq4xlvCySEbsEqkno4tcRoysQ5DTIpSNUBIte3EyMY=;
 b=w2Cntv/HQ04rMkf8NLRZ06nXLYd8nobHg/iOGL/KiChq8QnRjoN7IWNAMZ8+/PlWF6v2TUTnCQuKsQ21l/bpHv2PQTYPtIh9/L9UiaBH/mhaAfuHtiBmdZ0DzJTknjWCJlKQCfXsNnIRdxCAvWzYdHi61tvsuz8g03+nUl/dzUc+A0QjnUxhBfSKCAACzhM8cbGgy4yQpRkeWv7UQlXOmOYr1Q8GBrvGsOX/nWPzZd17ORXmLHzSOiitGmxwAnx1sz2ZfRnvrQW/VnfU2NHYVsEc+n4ldzl47RDPECCZbUdttdFOIFrR1DUiJDsYY9WVwNkKc+S2w8kKauj/36p2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHq4xlvCySEbsEqkno4tcRoysQ5DTIpSNUBIte3EyMY=;
 b=0rTE0lwznf8DSUFSyIkr9xsvSm/T+qa/9eggHrckMmDV2s45bThsTF9M14OqwF4avhntnaCervje+OpEkS8yrqSd0CO2xlSXvUVunKj5vWzHY9YVLo2DrXDVjDS8ZtI3eYrqw0EUCx6e3q/k/OU9nzqQxe/p7VDtOJUVy+AXJCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 14:34:04 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::2bc8:55e3:d3e4:ebe3]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::2bc8:55e3:d3e4:ebe3%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 14:34:03 +0000
Message-ID: <2c4ced68-37b1-4e46-84ce-91b63606e2c3@amd.com>
Date: Mon, 16 Mar 2026 14:33:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 08/22] cxl/hdm: Add support for getting region from
 committed decoder
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Dan Williams <dan.j.williams@intel.com>,
 PJ Waskiewicz <ppwaskie@kernel.org>,
 "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-9-alejandro.lucero-palau@amd.com>
 <03ab7820-a6e0-4655-bae7-61d2d0b7dfd6@amd.com>
 <28148dcf-3cdc-439b-900a-a3f672a28ad1@amd.com>
 <ac50b18c99f5863f456d2d486454df8eebe35719.camel@kernel.org>
 <69b37069af0f8_b2b610068@dwillia2-mobl4.notmuch>
 <5a42d88d-3825-46a3-a014-79b3936e3f6d@amd.com>
In-Reply-To: <5a42d88d-3825-46a3-a014-79b3936e3f6d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: efd6bb01-4ae6-4cdc-be9d-08de8369114a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8o0Kd7gEK+PckTO/Gf/xidTd2zFEPflFBV+Iu1lGtd5wHjjBlEMwUis6rkuwo24dURvfdzALZWZ1nITbFMtLmy4yyRj1OexhYEa8zTifkoclvsQQATeEgUVQqltVnNH57/0+2GGf1z5bXKPhAw0Wbj4FhfuJSmQ7OxWigeN3przeX2ZOu3rBf0C00yxCd1O6qdy7Me66c9duo/KBREE1anihNzSrH/epAR2kyUMqsNVBe20mY636NgDHeGk5J7EWPCafdS6YxkQMjeCLSl5xnHVZV9U9lci6vYhEG8lQCF6DxUtiu+Pgx0Ek9yplAFcStkohly/nHZOAWEvu/9Ppp+Fo6NFByiG6gUAnJztatfQMbaw16y4McKyFf71h+0MwLYNYuqHpj8/cYksBQkhHX/vkgc/rmQUdgKEYO+mI4cXWPNoDfDH93ZIzPGWjyjug+gzGDG1ceiGCzR8tK61ScfJ4/60aGTlJZy0CUpPX8IkCkKfR7/8y8Si5n+1R75vI995TBYnPrnhFWEYNIwuSxrdK0fZxe06vuUBzP5WfYiTniXeX3fXJJPiKVNB+nY8EjnUUicRw2DASMUXwZwfyRrCUTjv29wm3WtpwnwbAENp7h1/O4vmZor7nAd9nx5+YFEWt+BHbNvhEreYQS3I6RNI0Z1hwkpbuQZKJhE4inZ1eDkvn2ay8A4Qu2kt1NRczhhVROzKhXxQBHg+PYbKu7WDos/A17oyTq5i4KMDBJws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEVGQmFMakhqMUdwVHU3NjJXM2xpOEZQbWlSekhxcFJ1Sk1oV0N0VUxHY3V1?=
 =?utf-8?B?WEl0Q2dHcFdwRWdjVmQ1YlJQYUFyZzhKczdIendtNXdZV3B3SDMrdmlXTml1?=
 =?utf-8?B?ZzJpazRQRWg1ZzFYR3Q5Mnl4eHI5eXlKdGRmV3o1d0FDVDQyT2dwcVFFQ28z?=
 =?utf-8?B?ZGpndU91RjEwZXMzWkZSckR2UzI4Y2VZeThJeXhvalRSaHpySGgvc2Y2Z3NQ?=
 =?utf-8?B?bGlEREJpZVVlT3BUN3ZRbFZLdU9jVVFkbGFvdmtKTm1McFVXdDBsZzFoMm5l?=
 =?utf-8?B?VHhJME9GS0lVdXQwZ1NhOHEvVXd5OVlKRm9YQTQvbGJTNmZKSlF5R0NlbTY1?=
 =?utf-8?B?RG4vaUNYYTZRVUo0b0RNbHRCYTZha21URXJidzhtZEhSeDlnOWxCNVlEZDg4?=
 =?utf-8?B?S1VtQ3UzZUpKWVIwaUlPQnRiNWdGK2hjS3J6ZHIzVjlMTlBLTExNRXl5VkNn?=
 =?utf-8?B?RTZta09PcmZUdEFvOTcvdlVnT0djbGliQTRObGF4MmNuaENGWWRPUzA1UEpL?=
 =?utf-8?B?MzNObVZBeEpzb0lhSzd2VkFja25EZ2c0SEJNbms1RGFuVTF0WlZHRmVLbnVD?=
 =?utf-8?B?UDR6OHEyWlllc2xDRU52M0kvUS9ZbjJtWlFpRHlaaW9sL2VSWEZTUEg4VVNE?=
 =?utf-8?B?RGd2NUlTZHdDTkVrZFd4V3M0SU53M2xtS0U0RWtoS0tqVU1pM0s2VTlHRm5i?=
 =?utf-8?B?UDR0R3RYc0ZUUWdIZXpyZXpBQWVLUmlYSG0yV2dmZ2l5SVY0K0hVdEVVemVW?=
 =?utf-8?B?WndaOVlFNU53dGp6Z3NhbUkyU0tGRnpKZ1RLL2t2YmdNWEJtZUZoOXgrdlZp?=
 =?utf-8?B?M1BNOERCZ0hRc3Z1dnhDMXVUZFFwSDJBMlNJWEx1bWJwSkZLUDhEN215Misy?=
 =?utf-8?B?RnJpTUhJcTF1RzZoS2JsR2RzajBkRTkxYVRwTy9vNnIxeFR5UnEvRjNjam9T?=
 =?utf-8?B?OXV4a2tkNmJZMVVEZEpoNXJZSHJIZWtsRTVvZGFGWEZTUXZqVEhXQW1TdHlG?=
 =?utf-8?B?TUhLQk5TREdFRkc4azBJazlJMVE4YlNaa2t2eG5teUJHblc3Z1dLcmVIalFW?=
 =?utf-8?B?L1BsN2NIb2Nucm5ReDFzdG5GWm5IN3VQdE93UThJL2tFTVhmS2dRV1RiaWww?=
 =?utf-8?B?VDZoMW1MZm9XK1RZU3NpSkVoWUdic0lPUVhnaVNiVzBxcG1PY292Sy9IVzRr?=
 =?utf-8?B?bHZoNTkrNUhjVW5zczZnVi9qcXZDazZLVmRxbTk0TE9uRVZoN0c4M3J2aG85?=
 =?utf-8?B?UXI2WUxKSHZmdnNid0pZbXpSQllBUlYwby90U2doMWJMNUExbW13TUxhYWFX?=
 =?utf-8?B?SXF3VUVMTUozaVZRanJpMFRyMGZCNVhacE01ZUFSNkN1ekxFZzhLK0JDbWY4?=
 =?utf-8?B?UWE4cCtNeEk2WTZpSUN5MlI4WCtoUjV3WmVpMEZWd245cFNVVThCUjFPSGEr?=
 =?utf-8?B?blZtVTNvRUJGS2djTm5IUTdEbGR2cTV0c0UrSUJEVGY1aTRGQkdEWElWWmxo?=
 =?utf-8?B?QzBpdVJiTE42dGk0WnlSalpvSHNqUFZyZ1A1QktwcmloTmlzaDRhV0d5NWZk?=
 =?utf-8?B?UVdqWGdXSHJlcE9MOHVqR3BYdE5OSHlFbEZua09xYTBXa1RvRVh4MjFKdENB?=
 =?utf-8?B?TitMWXcxKzVsV28yaTV6MEp5Zm9PMjdFdWZ1dUF3N201VTkyNDlRMDRDUXI2?=
 =?utf-8?B?bVFWVFBGN3ZHWkZOREpFZjNNWm1aR3hqNnlYZ3hjRDZ6MTk3V05xcnpCak1B?=
 =?utf-8?B?STdvR0UyMXozQTdVTVJveUpvcGRFaE5FUUZhUDV1YW9nZG9KbzlmU2k0dlhp?=
 =?utf-8?B?VG9HT1RuVHRHVmVrN3RnSGVGblVDWEtiZE5rNkVMa0l6UUJ5MlIyVWlhR01M?=
 =?utf-8?B?NjNYcHBtb1FqSkpoQ1dlblRSNlMxVVQvRGdTUkgyU2N0NHdTUlZjTFNuemtE?=
 =?utf-8?B?YUxWWVRlUzNrRFVTYVU4MTMwc0lyeitzN0dudVVUUlN6cE1KbTBkRzNYZlV1?=
 =?utf-8?B?d1hLYThuNFk2dUdzOWpuVjQ5T2dxaSs1amFvRHE3bTJGVlRhSXNCejVMRjBh?=
 =?utf-8?B?R2pLaVZXMlRTaU4wUXZrYzVoVWkveGtkZ01Ma0Z6anVuV1B0ZVdDdURObWF1?=
 =?utf-8?B?ZE91QXAwTTJKdVlhUDNvL1dxd3F4c2g3Qit3dEs5UGxCTWNUYk44V05GREN4?=
 =?utf-8?B?cE5TanNLT3BZcUowNFZROU14bEFTbXZmZWJhWVBOMGovY0ExVTR1TUszZWJt?=
 =?utf-8?B?ZW55MWRJTjFBVzhxczFIZWNTWWpSdUZ3SVlmZ1JwdXJMZVdpOWF1ZWZicVcy?=
 =?utf-8?B?YTF0bXR4bURyYnROZHgvVEJtUmE1eDMyVGttZmRqWjRDL3g1ME1EUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd6bb01-4ae6-4cdc-be9d-08de8369114a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:34:02.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVnZCgqDYBe4dpv4XSPQjxg6BLV9o2Hmsrv/EsWg77JJEkJcn0SKZ5J5oi3C8qh/oMuvRikyANFig+r+EZpJjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268178-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]
X-Rspamd-Queue-Id: 029F929B743
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/13/26 13:10, Alejandro Lucero Palau wrote:
>
> On 3/13/26 02:03, Dan Williams wrote:
>> PJ Waskiewicz wrote:
>> [..]
>>>> Yes, I think you are right. This works in my tests and it is safe
>>>> because I check the region does exist before using it. But the error
>>>> inside sfc should then not be fatal for cxl sfc initialization and
>>>> fallback to the other cxl initialization possibility.
>>>>
>>> So I'm running into this situation I think.
>>>
>>> When you're testing, are you surviving a reload of the driver?  Right
>>> now, I can load and successfully create the region0 device. However,
>>> following the same teardown path in SFC, I cannot reload my driver
>>> afterwards and map the region.  I get:
>>>
>>> cxl_port endpoint5: failed to attach decoder5 to region0: -6 (ENXIO)
>>> <driver> 0000:c1:00.0: CXL found committed decoder without a region
>>> <driver> 0000:c1:00.0: CXL init failed
>>>
>>> I'd be surprised if SFC in its current patch state would survive this
>>> same insmod/rmmod/insmod test.
>> So over here [1] I reviewed Smita's patch to stop resetting decoders by
>> default if they were part of region auto-assembly. While that stops
>> resetting the decoders it does not allow the device to get a hint of
>> where it should place its HPAs if the decoders get reset while the
>> driver is detached.
>
>
> That is already what type2 support is about, and what was from the 
> beginning: to get an hpa from the root decoder. The HPA will be found 
> when the driver loads and the memdev is created and when the related 
> region is going to need such HPA, and based on what is free there. 
> Before v22 that was the only case contemplated, assuming the BIOS 
> would not configure the device decoders. v22 added support for getting 
> the region from autodiscovery if the decoders were committed, and v23 
> was for not resetting those decoders if that was the case when the 
> driver unloads.
>
>
> I'm pretty sure what Type2 pre-v22, v22 or v23 do in this regard is 
> not perfect  (v23 was a quick hack for PJ to test the new 
> functionality you demanded), in fact I'm changing the way hpa is 
> allocated for Type2 because after Gregory's concurrency tests and pmem 
> patchset, I really think the approach needs to change. But as I said 
> in Smita's review, you are precluding the basic stuff with your 
> never-ending "improvements". You are not in a better position than me 
> to have an opinion of what Type2 drivers need, and your comment is 
> this thread is just a lack of respect to me. Yes, it is a blunt 
> assertion, and I will repeat it as many times as necessary.
>
>

After looking at the series proposing DVSEC save/restore for supporting 
device resets, I think I misunderstood your comment here, and if so,  
you want to address such a reset and not the HDM reset triggered by 
software ...


>>
>> I am going to draft some patches to allow an accelerator to mark an
>> address range as "designated" so that it can recall the memory it was
>> assigned by boot firmware.
>
>
> If you do so, I will start seriously about passing this work to 
> another engineer, not necessarily from AMD.
>

so this rant is missing the point, and I have to apologize. Once I have 
said that, I neither understand why you are proposing something that 
reset series will avoid or would set the path to support the case you 
have in mind, nor why are you mention it in this thread. Is it because 
supporting that reset is a requirement for type2 support? I have been 
aware of having to deal with this but not as a priority or part of the 
basic support. If that is what you want, why did not you say so time ago?


>
>>
>> This also dovetails with the conversation I had with Paul Blinzer at
>> Plumbers about an ability to designate Soft Reserve memory. So a generic
>> facility to designate memory allows accelerators to recall their address
>> range if the decoders ever lose their configuration. It also tells the
>> rest of the CXL subsystem "hands off, this range was accelerator
>> designated by platform firmware".
>>
>> [1]: 
>> http://lore.kernel.org/69b1e0aacb9d0_2132100c5@dwillia2-mobl4.notmuch
>
>

