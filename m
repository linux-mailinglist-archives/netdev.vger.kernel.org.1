Return-Path: <netdev+bounces-195453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B19D6AD03B7
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF0F188717D
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083CF20298E;
	Fri,  6 Jun 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LXilTn2T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44503748D;
	Fri,  6 Jun 2025 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749218615; cv=fail; b=nZUu5Omtrz5gWqP1yoicWrM2H3aTR5qeg+P9PeVOWnmciYYhtyvaFyDSz6QYIqE5vpCTDRG/8SRgKr3Fp5vKZgv9zYlu2gdc+wXnqEvTFWQ+mx2dOf2Nxh/A7gRqlZStTrSsTiQAaEevAMx9c77b4Zw7HCLFWwjpC3IE8YJr3yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749218615; c=relaxed/simple;
	bh=oYIP9Mfh9vOsG6d1ywrXjEoGICc6NvJxYTCEduxtC7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eqE4TWJAwBwrcvISwSjKT5eBHFV0DAwTFelf8QMnnu9IBeb0AyeWkHzk7iSIHeteNmCI/bWDlr7OEL7m3qC4WsmkCBLBV+ciAL1AlhbpftmAnFOHXxJKSvipFB+cq998AX4yRE0IJCWw0ecwfSWYXRoLiZT6e4zGjT2hyVroyFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LXilTn2T; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpbv2SfETQlIF1EnuMKtTQ2YV4KM2dm0z5QmVN6cuEyslfgqwf68m21YFXL0ubuX8cKkrPLDE9vrqT1MkxHn+6Y4Mngfy2Nptn+O6+VsDNIECScqnpgvrORYqwZzqWPawMo4Sm9jf8TUDclArNET8pI1cFil6OdtX2vXV6hJiit0wEW0rI8BZknAsMyu+Xj1xa/YTyU9uvHUQTnObZiux+DWCzgncUJZdXAE1QfP1x+KJYKIX00k16KIdZyifgMgXiOJKL3Aa65qfR0EdfnUhdm3o+prLB9+m2WipRfZFxiutGBxlJeN3zTHiiGTzNl5U0zOQhZJtpRolUS9h2k5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PAnS+2ijhuiDx0U6XkeqkItp0TlgLvy+Tq/LkXm394=;
 b=wdRhyAirwujF8Ft1oo7RWk2ruh62O/1UenGorJheyhs9ExGAEKeXB3iKWZ9FnaLbz4g+pb9gVv4difhvNXJIkeeu5JbjHhSF69JD53miBUcH/c/63ZluLR/2lOoa8ByLuHOVP3ATzd+ZQZl2V+y8sFas/k43pd3lbMY45csWnMXHZt9P8aqJAgs1TKi6Qqvno74o65HVVX3oEHwPP1DIDK/Gl7cDMGM7XdBruVTzQDLZsA7pd4NZ9qiJ6D4Kn6Td/qywxXe6bMyaG5XWJeL9LNBJUqcCV94V4DOMmRKKm6bAYtiY5BLzVxrBEzUEc6qcAXuPoiRGFKMfVwvtkbGSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PAnS+2ijhuiDx0U6XkeqkItp0TlgLvy+Tq/LkXm394=;
 b=LXilTn2TXji4afJv1Fcqq5x1sgPfT2bgVH4kdaA0GQoTRK762gQkb0tjIEymUpSXzfQDIF7pkhojLH9gtAc1X4pC+odGeb1jvHfevwgaj9hcJPiRGdfG8yJPQTogG8Ie8vsQaZEn1/IsJEVoVKjQ1URn3zVQSfUnp1v3Pd5m/6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 14:03:32 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8792.036; Fri, 6 Jun 2025
 14:03:32 +0000
Message-ID: <e9810a8b-b1c4-4f84-926f-3b8c05b2099a@amd.com>
Date: Fri, 6 Jun 2025 15:03:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 21/22] cxl: Add function for obtaining region range
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Zhi Wang <zhiw@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-22-alejandro.lucero-palau@amd.com>
 <682e462ecbd8c_1626e100e3@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682e462ecbd8c_1626e100e3@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 558fb3b5-9bf8-4b49-8d72-08dda502eba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTI4N2d6M0NZTXJjSnlKcW4yd3dpTmZJdk5PejRWd3ROTWhkVUZJaHNqSGM4?=
 =?utf-8?B?Z0dTMkFZT2xpbCtYMnVocmx5K21pb2ZxVnJTSjRaQmJUc1pvNjU5TWoyb0tZ?=
 =?utf-8?B?UmRFUE9lY054VDJkd0xOOXU0SkYweXMxd1hZWnV0OFNzcjdHeXBEVDFGNUMw?=
 =?utf-8?B?RzdVQkIzQ1U3eU53OHVDNzZraDBMd0xGc0s5eW9vVit6OXBvNDIyb2RXblNI?=
 =?utf-8?B?cC84bEtieStFM3RGdEUyZ09nR0pJT1ByUjB5OW1XVUIwYmN0Zkx4QkY5YUtD?=
 =?utf-8?B?dStEdDJuckN1REhIZnF5eFozMGN5bko3Q2x2VlRkVHJBNWZlcnhVSCttVjdL?=
 =?utf-8?B?T2xoMHhIOE1TeFA2UDJ0MDEzWDBWb25JbXdFZnRaalA2d2tUbklWY3RMZEhh?=
 =?utf-8?B?S2xJSkF5N3UxMmpMdkFJWEJvd3hEQ0VGTHpudTRrZEZlTjJHTzYzbjlwRVdC?=
 =?utf-8?B?eDdldjhvQU1kL0ZYdnpaUDV1RlRORFRtTVR3bnVqN0ZJUkxJbzhicFRLTzZs?=
 =?utf-8?B?cUlKTHFka0VxNUlDeGVzdmhhajdCNlFXVUowV0pjM01CaEUxVHN2bERLcksx?=
 =?utf-8?B?TFdSOWNIVGpQdDRuUlBESzNxL1ZyZ0kwajZHZXJnWXhwd0JOY0xjc2lyQmhO?=
 =?utf-8?B?a3BQbCt5c2s5d1c4bGZJemhjUm1qNjJxOUdrRHNBU0Y1TjRlazRTSGcxTG1M?=
 =?utf-8?B?eDI5S3IvS0FnTURkazNtd3puK1IyUTJnS0E1RXgxVkRqK2ZNai9oWk12bXRV?=
 =?utf-8?B?cGdibzBNSDAyZU8yNkRWbUFISXAyYWVlOTJJREZvZlZoSHNUQ2FMRllvVHRO?=
 =?utf-8?B?T1RwNVRhRWlmdGllTk9yWGhuaGNWY0IxcWdSODE3VHJ4UHczREh1YjA5bnBj?=
 =?utf-8?B?cDNTRVFoaktEc2JDaGRoUmNYN3RESEorbCszcit3T21hZ3dDSnJFZDVEck9T?=
 =?utf-8?B?eGJ3b2RqR3FFWlBmSjFYTGdVTFRXemkyeXlFcTZnS2t1RWE1bzNKdll5Lys4?=
 =?utf-8?B?RWY5YVZVL1QwS2dMc1BXWWFtbXhBLzlUYzMvOWl1enV0eHNNQUN0ZE9VNk5l?=
 =?utf-8?B?QnBBUWZ6NGhCb3pRQnZVeWdaNTlRbW56Vy9HcXpCQmQ5M2x5UDlZTjMzTnVO?=
 =?utf-8?B?VEVoeHdqb1g0OVJZUnZtMUpkd1JoK3psWDlMdHZyN01BWWRiRmZwK3dmSmMv?=
 =?utf-8?B?Z2p2aVJNMUZvbzl6YURNKzBUZmVCcndndTg1Qko3UWh6RUpCUysvTi9ySVQ0?=
 =?utf-8?B?Yk1OeHpGbWFhdFFlTklIeE5SRkgrTnFocndzN093a1lMMllVcEVmRm1LRElC?=
 =?utf-8?B?RXRDM1llL2ZxbHdkM3BsNUFwVEhreXNEUjNoWVl3WDZrWlA1MGEydTVXUThP?=
 =?utf-8?B?SkJUTnI4VWFPWm5uRmZuN0lVWktheUhlOWJNcWdEbTZKRXZkcWlkSlpOV0tP?=
 =?utf-8?B?WE5oVlhXQ0hjdWhHNjJiZ2QzTVRsNEhyVWVjdHBHdHhuVW9yMGhjQjVMRzZk?=
 =?utf-8?B?U2tNVzh4bTdTZ3BiZnhUYURJU0U4bVFWckdZSHhsM3VkNHhBSGZBWFVuZndI?=
 =?utf-8?B?L1FoamloSi9rUW1hb0hSNWR3MFh0WFBscENZWVFGa2FtYjRTUlVYUlpwb3BT?=
 =?utf-8?B?a1hxcEhTZWdKNkl4Qlg2OVFSZVlib25FcjgyZHFtK3FQNVJiVUpha0RaakxZ?=
 =?utf-8?B?MVhHcDcrcVpPYjZ2aGpZWHIyVVBIcDJsaU5HRkpGK3dWRW85d2RzamVSL3BG?=
 =?utf-8?B?c0lEaXBNVzg4SXN5N0RPRzNSbFN1bFVqV0U2aDdwRFBDUk5VOCtnN3ZHU0ZW?=
 =?utf-8?B?bGE1WDhmTDY1VmVoblYxYWsvNkEwT1NPbDl1TDdWTmIvMkltenU1bko5NVlu?=
 =?utf-8?B?c1RadmxBVlpNQm5nMWNZQmV3dmNHYW9xSWorU2NQS1BmSXg2VWpialEzNkgv?=
 =?utf-8?B?bHNIODBnekdSOVRrMExjcEMzRGNqRkdCbWVMUUg4NjFFMk5IeEFYTUNsMFRZ?=
 =?utf-8?B?Ni81TDEwNzN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVEzVWRpcHY2VEwxZ0lkSVp0L0Q0Z0lLWE41cUlrSis2Q0xxN1VzYWhmcGN5?=
 =?utf-8?B?bGVPQm5VbDQ2TDJpZWlJaEIyQlVjVzVrUnlucEdJM2JuQnliM0d3TXpJaHZM?=
 =?utf-8?B?dmRzV2ZYREdHRzFWT1VhTDgwdDRrVitJcGNqUzZHZ2UrMEZ5bG16cUVWbmdR?=
 =?utf-8?B?TE1FK1dGZjM5aFpueHE2RU5iV2xVaHRPTyt4UnFUMzRTZUhXeGtmRG1vUlpn?=
 =?utf-8?B?SHNsdFJQSUFkTVg1V0N4ZXJJUFZqNWZ1cTRWNlAyVWRUUk1oTG5xVkMyVkg2?=
 =?utf-8?B?VXVwWjFleTBLQnlhUGI2RUVDL0pVM0ZSSENEajBNZXJBVmpncU52bUt5SGU3?=
 =?utf-8?B?cS9ZYnF0cDJpMmJGU1BPYkF3dGYvN1FmeHBselAwbjd5aFV5T3VOVjJtV2E0?=
 =?utf-8?B?d0daa1JuOGhqTyt2Vkp3Q3dKLy9BM2kzcEtmbGNFOFBBU2FsT0lkVHdqWk9H?=
 =?utf-8?B?SmJ1K24yWjVSRmNON2w1WUEvVDBZR241VnFBWjArTkQ3cXhTUWFDajhrdjRa?=
 =?utf-8?B?dU1uRjlvQ0x6ZkFzVG9vSUxURmM4eDY5L00zQkVUM0lqeXN2UFgvR29JUlhD?=
 =?utf-8?B?cjlNUi84VHZNdEwwYWh1aGpFYW1EQ3M3MmJIUSs2Z05vdE5XNkZkVWd5VGNW?=
 =?utf-8?B?SzN5Tm9OZWcrV28rUGNNYzk2Zlc1d1dTeDZXMnQrYnJnVVRwYjEyU29TUW9p?=
 =?utf-8?B?by9VVG53UzZuN2tJUVYvbWoyZ3dFTmZOZ0JHZHdZdVArQVBvbXBwMEhrVmxE?=
 =?utf-8?B?QXJ6bktNU2E1a1hXQ0lCKzBHU1Zndi9WcFM2a29JYy9TdzNWeVVybmE0b1lX?=
 =?utf-8?B?dStEZXltb3FwYmNwMEZwSDhWTVdWcUVUUkp5RzJLNElXdEtsQ0lZRzNZMEVp?=
 =?utf-8?B?OWQzRTJJRm9YVzRmdllHc2dyOGQrU3l4RWhMdE1ObmpjaGk5UDRlcjIvZVZr?=
 =?utf-8?B?T0o0c0NuMks1TUVBcERDdS81NUg5Nm45N1FxZENJdUh5REZXUjJYUEZXS3pX?=
 =?utf-8?B?R2M0QkJZWUFGL2hWeVFCT0FmR2FTZVQzZm9GSXA3aWEzWTYwaHdsWlpORXhO?=
 =?utf-8?B?VzJVNWxUaGE1dE9yWXpHR3NldXFMd2o2VlNvenBJcTJFQjVxcExweFQyaVVR?=
 =?utf-8?B?dnhhWkNhYWk1V2JhY0pZaWFSL2xpNUlpQ2FIMkZ5L3FaRlFYY0J5cVIzdlpp?=
 =?utf-8?B?UUl5aG9FejFHNklGditxQkY0N1dzampvbnl5SDQya3FOMTRoUkwxVGVEV3Rx?=
 =?utf-8?B?M2REaHJQeEtNNU1DMGpEYk5SQkVuV0xFN3pvWG1waTNNWFV6anNqZFRrOHlj?=
 =?utf-8?B?MUhhckdPWE0zSHp2QU5TblloNk00Tk1QcGdOQWZTd3E4NmdPWVllY0M2Nm9k?=
 =?utf-8?B?T0pOL0JLV0NPRElQY1FYaVV4bmU0TVpzUXVSVmFqZDFzamczVFFnNUpkaXZm?=
 =?utf-8?B?dks0NTM1Z0Z4SlZUZm5nTkVvakpLSnZlN1BNZ1JzY1VuYTM4VDBUckdPcWVH?=
 =?utf-8?B?Um0zOFFjQ3RreVBSaFIyemZBTzFlUzhqclVJcTFVOEQzWHl0L0tQRnBuY2pR?=
 =?utf-8?B?Y2JHeWdxK25nUm9lNlkzQmFnM3NDYlFxcXhIcTZ6Q0NIWmJmb0Z1Uk9LUGkz?=
 =?utf-8?B?L0dWdG5YSVhaSHgyOWV1Z1N2SjZtYTk4Tlcrc05rK1BZNExIaDZiaXNzaHlh?=
 =?utf-8?B?ZHoxSG90NFZXZkwwSUxLM3RoUlRzTk1WMWpxUUNhTlc1NVJWRkNhREpQZ3c5?=
 =?utf-8?B?MDd0MWtuc1RtLzVNOHFIRHpuWjUvUW9jNXJHdmo4bVpiOElZUmtnZ2dnQ25K?=
 =?utf-8?B?TTlkdmlHYTNpV1hxRWVDUGRHbElHeFNBa1F4RFdBS0tHSHRwZldGa3RaNS95?=
 =?utf-8?B?Q0M1anUzYXRQYUhXWlZKQ0Y3WE1od1NpelBoSXY3bVpUMVY0VXZBdGhuQldC?=
 =?utf-8?B?SmIyejFBcVVZNkhmUWcwSjlxMHM3azNSRUJWYVg0ZTgvV2ZCSkNkcXpOV0lz?=
 =?utf-8?B?aFdrYlFxbSs1SkZ6M29FRm95bXcyZEs4aENwcDBaN0kxQU5kS1FqT1FCMTZ1?=
 =?utf-8?B?eTNFbEpzWkVMekMweW1SbDBZa0dCSFNtdE5raEtVM2I4VUQvT0tWanpSTXdS?=
 =?utf-8?Q?6e79jQYIrrA1jHEuVGY3npda9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558fb3b5-9bf8-4b49-8d72-08dda502eba0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 14:03:32.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXnTYk1OP9++2NTLMDt7uinLL72K3MMS3QnlbVR494h275wAV7FRsVk0IPaKyHwv6V0o8TQgrQV9Vq72+fkN2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689


On 5/21/25 22:31, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A CXL region struct contains the physical address to work with.
>>
>> Type2 drivers can create a CXL region but have not access to the
>> related struct as it is defined as private by the kernel CXL core.
>> Add a function for getting the cxl region range to be used for mapping
>> such memory range by a Type2 driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/region.c | 23 +++++++++++++++++++++++
>>   include/cxl/cxl.h         |  2 ++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 06647bae210f..9b7c6b8304d6 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2726,6 +2726,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>>   	return ERR_PTR(rc);
>>   }
>>   
>> +/**
>> + * cxl_get_region_range - obtain range linked to a CXL region
>> + *
>> + * @region: a pointer to struct cxl_region
>> + * @range: a pointer to a struct range to be set
>> + *
>> + * Returns 0 or error.
>> + */
>> +int cxl_get_region_range(struct cxl_region *region, struct range *range)
>> +{
>> +	if (WARN_ON_ONCE(!region))
>> +		return -ENODEV;
>> +
>> +	if (!region->params.res)
>> +		return -ENOSPC;
>> +
>> +	range->start = region->params.res->start;
>> +	range->end = region->params.res->end;
> Region params are only consistent under cxl_region_rwsem. Whatever is
> consuming this will want to have that consistent snapshot and some
> coordination with the region shutdown / de-commit flow.


I assumed the owner of the region could be confident the region would be 
there ...


This is more of the same problem discussed in previous patches ... where 
having cxl_acquire_endpoint makes sense. But it makes me wonder if we 
should allow cxl_acpi or cxl_mem to be removed at all while clients 
depend on them. Is there a case for this apart from the fact that 
current implementation with kernel modules allow it?


>
> This again raises the question, what do you expect to happen after the
> ->remove(&cxlmd->dev) event?
>
> For Type-3 the expectation is leave all the decoders in place and
> reassemble the region from past hardware settings (as if the decode
> range had been established by platform firmware).


Not sure I follow this logic. So Type3 devices can still be accessed 
after cxl_acpi or cxl_mem are removed? How does it work when those 
modules are loaded again?


>
> Another model could be "never trust an existing decoder and always reset
> the configuration when the driver loads. That would also involve walking
> the topology to reset any upstream switch decoders that were decoding
> the old configuration.
>
> The current model in these patches is "unwind nothing at cxl_mem detach
> time, hope that probe_data->cxl->cxlmd is attached immediately upon
> return from devm_add_cxl_memdev(), hope that it remains attached until
> efx_cxl_exit() runs, and always assume a fresh "from scratch" HDM decode
> configuration at efx_cxl_init() time".


Part of that expected model is fine as long as the sfc driver does exit 
doing the cxl unwinding like cxl_accel_region_detach. That should leave 
the SFC CXL HDM decoder as in a fresh start ... . Anyway, I got what you 
are warning about here and in previous patches, so I will try to address 
them or at least identify most of the potential situations using your 
reviews as the starting point. Maybe it is a good moment for going back 
to my statement about the patchset being about "basic" support ...


>
> I do often cringe at the complexity of the CXL subsystem, but it is all
> complexity that the CXL programming model mandates. Specifically, CXL
> window capacity being a dynamically assigned limited resource that needs
> runtime re-configuration across multiple devices/switches, and resources
> that can interleave host-bridges and endpoints. Compare that to PCIe
> that mostly statically assigns MMIO resources throughout the topology,
> rarely needs to reassign that, and never interleaves.
>
> Yes, there is some self-inflicted complexity in the CXL subsystem
> introduced by allowing drivers like cxl_mem and cxl_acpi to logically
> detach at runtime. However given cxl_mem needs to be prepared for
> physical detachment there is no simple escape from handling the "dynamic
> CXL HDM decode teardown" problem.

