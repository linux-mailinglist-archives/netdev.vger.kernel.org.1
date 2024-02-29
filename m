Return-Path: <netdev+bounces-76029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BB486C031
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 06:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA4B20F89
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 05:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A6139AEB;
	Thu, 29 Feb 2024 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nvnklbVX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91AC39ACD
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 05:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709184413; cv=fail; b=DnRfFQ4zssLSsmYcjUaiKI6QMmamaiFZDCHatCp7B3t78dJFY+jU0PdQquIj+j753K0B5RumvyIKiSvDcfF+PwSgCAgFSA/lP8PfQl9PxcecAa94z9LHbjwfdMBWkZs7vOF8CX59cTyXcBnbGcr4la+nfly7D/dco6hR++2Zvnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709184413; c=relaxed/simple;
	bh=IEQD1xErvrpzah9Td0O4P0VtNJi/x5oQockOPZRIy1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DQ5thUSpXOgm/74ulsMJ25Uozz5Zch8kERU/7hd5AWNDKQd+yx2zw8GJ6+UTO5uI0iSmFeRFFMYPC818S++31olWrFp1EqQpBiANTFX5Wa+8RN+N5t0ekwsdgrKb/degHHO71yLYD+yKCcwmRgVIlIKioEhP6IXnG9itAFf7PoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nvnklbVX; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lahCKW5td6crxZ/MDIcY/dHMsp58iAz1nN4HBdA5Fy36gyln9zefTUZzYTLjVTnycwGIizg4ZWmJyp1w1SbEPYYvOSKGwsLMVfoWF3o9rRkbsKVYFqMiUCizxNT3llaiTB0WBfS3hkini9X+qz0Tfe6ta38Ohj6GxaxHFzQpCMVOqAip+I/gNWz2IaiT1f9zNv7Rm5/GO5Ba3enfI+Db53TKFAP4DPusSV6KAjFuzUV8SrOtTaWBXyZCDb+ZmO4oRjbmhEut6S22rNhzjwUCqGrh5iLKJbSrUdngfcgTIb51F92IwzTECbSzWcHrwmY2hhKVevq0XbdEvJnYCpmJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUWsunxtgDtPKdrgTdR5gUoQ7CDFDlKFjMtF1n8v4Gs=;
 b=jV8zHLnf8bnX1LtpUeHSyIW4PraxiDrK3+Ag2g+bCFyFduS920ImY20vxVvVsiOw0cV2qmeYh61RAYs0ne+1D7i7N6VhjB2SwmRZO4ksvnqTvnjx3PEm7PJtuYsVMAkTn7L9f0rJ/O7sZvTI5UXecpBpAZ6qTt8nzIogXp+lYefXwb3+msxOOT2YAckPG/wyGWwCJv2MFF+EueUJyNpPyYRYQxSggQF5vMSoVg7mRll5kqOrDwBBHV9FRSg0MNE4sCbp9HUgx85aOj1C4BwMuY7u1KGs5yJW28AwuSvMU9r+s7Mq2C3LQNn1Btzs6BSYIMzjqdKs39SR51bU0gpSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUWsunxtgDtPKdrgTdR5gUoQ7CDFDlKFjMtF1n8v4Gs=;
 b=nvnklbVXkVLefYcbcowRHXcR34vVWgpUSMxUsa1Pf5Dde1AvkvMtmFGuMABHnNGKy8Wj+dJht6sSy4NptB+ZLyMvs94l3UOLPwpH1+zJgYmRAP3CVa7lzvNcMOnFVD7tMS0hXm+Zxtfg3edxRlvQKuFOA/WcsOLYXrpAo63ZxvdYajLC27GIha5PU98iTEtQrW6AhCfmY6tNOy2pLH6BNLqyr3LjAPKbG0Gc7laWUTjZJ8P3UTeKCIxAS9n0d/7bRVZ3GMMezqxFWFEpAsB6n2yAUsZFtaOrPRfNZ4mYlA/mn14AklYvD2W3SdZ7fv3CartzaTaZUdHrIbZcM0ZVkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 05:26:49 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c%4]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 05:26:48 +0000
Message-ID: <438e8df7-3deb-485a-8872-3e3b6974005f@nvidia.com>
Date: Wed, 28 Feb 2024 21:26:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC iproute2] devlink: Add eswitch attr option for shared
 descriptors
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
 tariqt@nvidia.com, yossiku@nvidia.com, kuba@kernel.org
References: <20240228152548.16690-1-witu@nvidia.com>
 <20240228083337.18bfc306@hermes.local>
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240228083337.18bfc306@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: a7eee901-ab75-40d5-03b4-08dc38e7071a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WQE0q5MSgh28SiYio/apqxz7UrMaNXt2IvKKeijKac1hn0xNLyjChaFCc1XqYubnnGYpJitewubXvESHfZmkL7LOT2HCipqLJ8FTPbCOXNmlgrexVLoxnlQXzvBgwF+8QXG5TaGTe5qJ/y8UzaHkQe+5uh7hEWALExi9tabqjkIsIYoRc3ufuf66QHEa/4iXTNy59ErVaqP2GXcyqpJGv+lJ9qcWGwP+ku03ni2JDI5Emfncf3bGJsBXgVDVUkMKqta7n1/pphcF4xNFtKBzZ91SO8ba36fh9h6RdspYnRYnQ3urFhlhBv028H0QpGUDQpjRG6bAFoVnjCSRkjiJKZoSEjVUV/rMt8WlbIknbbZO7cedjeYm/NwLpImSWHI7v2tvvMMw914x8k+ERXfiEUHTsRJbFp8H0rgS7tYXoib12MP8sRc28Bw30pxBnFlPnnhAGPJzQtuC7ZZqfMizCUk+vd1oZ/2bcdtcYk60kBkV651U7487lT5DpmtBJvWD10Z7ygsvxFKA/oiy5mr/HgovT7aUxVt8sLy7pPbSM6Du5iGdmJ4tgd5neFHUnE3qLIfTesErSVhRZKS5lYyHv/gVUjMzTa7zha9Ptwhf3U3aEcvULH7zgS1yQI/uqCJx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0tQYm5HaHNuNnBwemxUbThhN1p3UlE1bDloZi9nMDNOSlRmSTA5QWlaQ3pi?=
 =?utf-8?B?b2R3UjFtK2F5aVk3TENPcldsdkltaG9vSmNXR1hwbmxySVB6OTNLUFR5bDFM?=
 =?utf-8?B?VFVPOFdyMmJlNGZ5KzZya2lnenF5L3FHRzU2ZStTcjhFd0RucmhsMExrZERS?=
 =?utf-8?B?R292T2pzbkp4YWtKM3RwMDBEZ2RzdktmLzM1c2FoV2lSVXJobnd1SG9zNlor?=
 =?utf-8?B?MEM3dlhEQy9Fd3dvNEJZWXRiQjVIMHVZZUxGSUFuUGJ5U1JEZDd5TzRDMk9P?=
 =?utf-8?B?YWtEdkF0aWZxT1Q3bXdmU0xRbm9BOVcyenIzbUdHZkJKUHZzN09DemNMTVpX?=
 =?utf-8?B?ekRyODRlejlYY2J6ZURzNWYwQlhWem9xZmJwTmFtQ3FUSWZlSTYvK2RYcjZ1?=
 =?utf-8?B?RER4Rkc1V00vaC9vK2RmcFgrdUp3VlZkc2RCVnpQNCtPZWV1dXFIU21oNnJy?=
 =?utf-8?B?WnRKcE9ITnJLSWdjbkdtZkEzb21QZWptUVF2QVFwamVBN1h3bXd5dXU0ZlMw?=
 =?utf-8?B?Z0dTQjB4bmJBbXhjY21IZjVoUTZhNzd1ZUNQWmEvRVNPSSsxR3FJdU9KN0FQ?=
 =?utf-8?B?ejgxRjJGdXZvbUlxbk4rTVJsOUFuNHFDNnZ0c243cHVST0ZxcDlHVytINlB6?=
 =?utf-8?B?Q0hSZm0zakkwTUdXRlkrMFJvYk5EZW9BNVpYQStOL3RCSWNkVk5WLzdGdU1Y?=
 =?utf-8?B?aDFkREZHQ3JhbzVUN2ZUVFZNUnpsQlRpeFdrME1KelQrdkdkSHR2cGgrVlk5?=
 =?utf-8?B?SXc4ZytiQkZHbEVmRVFmMU52TkJuVmpHd2lyUkh1cUZIbVRIUWx1ajEvNFlD?=
 =?utf-8?B?V2ovczZhZVMvOU9hVUMzNVpGZnNQY1VFeXlIL2t6aE5BeVZLdTZVNGM5VjAw?=
 =?utf-8?B?OGRmRHZGYTV0V3Q2RjhmOXF0dHNHSzJIZnJyUERBaXNaTDVBd2xpYUZ2U1d0?=
 =?utf-8?B?Wk5OWjQ3dldqam0weGhCNzRCS3JFcyt4eURiRGQ3UVRqQ25pZCtub2VPc1lH?=
 =?utf-8?B?WFZsNWdSRUdOQmlqME13eVBqL1J2Vlp5Vi9IdTQ2N0gyZjBjdzdHdGxoU1N1?=
 =?utf-8?B?bk1GK3hPWmJMR2Q1RGFJdmcwZWxETDEwd2MyVTI4QTA3aGJudFJONTFGbTRL?=
 =?utf-8?B?SjA0Q0U1dVc2L1RuMlVhY3Byd3FnZFVaWnRSL3RDWWtLemNESTZWV0N1WU9Z?=
 =?utf-8?B?TWFOczhLZ3IybDRKRzVLd09JQzdzMUY4UFZtclBCTGVjYS9aci9oZFNqeE1I?=
 =?utf-8?B?VlQzTjl3Mmx1cy92K01hUEJaMnNwS1hDRnlSMTZ2UVN3cUxTdUNFTzl6dVlz?=
 =?utf-8?B?eGQva1Iwbnc2SjRYa0t0Z1pFZnZKTThKYXlzZmlSSVJHUkZScHUxUTF2K2tt?=
 =?utf-8?B?SUxVVlFlV2JXSzRSVkkyTzBSdHJHV1ZLZk56ZnUxZDZKbVJuYy8zRWdjVVJv?=
 =?utf-8?B?cjQzUXk5TGZVZjhmWFRNOEFRZk11SndXU0tEcjhxQk0wMWpjKytFcTJXVjRZ?=
 =?utf-8?B?ZVpPZmpLUTQzbENtQkdwMzJlS3hqT2R3RGdqUERGZzd5QVg3TkFZZWQxbUxI?=
 =?utf-8?B?dXRGbkt3bnQrWjUyN3NhWGRNWWF4STFwTGhOb3VnZ3BSU1diVEk4UnZDMUsx?=
 =?utf-8?B?T2NEZ1RnZFlNMTZZSnhNeG9zWENnZ1RPdHBGeVM3VGZCRjlkME85a0o4aUkr?=
 =?utf-8?B?eUwzbFQyMXoyaEE5QWFIcWRCbTRWbEpPcFdoTUh4ZkJENVJnUDJGb1J0cThI?=
 =?utf-8?B?V3JRTDUzUUR5eGhmYnVreXFzeTBwR2dWdkRiUjl1Wjl3ZDZiR2lpVndKMmVR?=
 =?utf-8?B?Z1lVMURSeTNqcnMxOXBJTlRiRjRTUlVUYXBvWk9vTEsyZzNmZGpYSVRmdG1K?=
 =?utf-8?B?eEV4OUJUcHZnLzVPTXh6bjFMNDBoMTVrYmJPNG00M2VYblREeEpXaHhZcWV6?=
 =?utf-8?B?RW5rTWVSRG5tMXFFTjM4UVJDcGpOaldVK2ZSRVJxT0NKaXhQZTJHY3ViU1Zt?=
 =?utf-8?B?OGM0T1Y4WndaZ3lYYTI5cGhiazI4dnpJQXluSjhmNFJJR1oyS3JuVk81OUlm?=
 =?utf-8?B?L21wbnoyZHVHajNoWFZDVjQ1c29XdGw4Rk1nRTVVc3ZvS2wrTUZaYjhSZlR6?=
 =?utf-8?Q?g1ze2JhA8RiBSRzn9r2j7AA6c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7eee901-ab75-40d5-03b4-08dc38e7071a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 05:26:48.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsdEMjp/fI5nzQpUGdNvdiAkP/q6w2nIB7Nnb2fgVeg/aGl5QkG5Ns5ZgnoEJHj/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250



On 2/28/24 8:33 AM, Stephen Hemminger wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 28 Feb 2024 17:25:48 +0200
> William Tu <witu@nvidia.com> wrote:
>
>> Add two eswitch attrs: shrdesc_mode and shrdesc_count.
>> shrdesc_mode: to enable a sharing memory buffer for
>> representor's rx buffer, and shrdesc_count: to control the
>> number of buffers in this shared memory pool.
>>
>> An example use case:
>>    $ devlink dev eswitch show pci/0000:08:00.0
>>      pci/0000:08:00.0: mode legacy inline-mode none encap-mode basic \
>>      shrdesc-mode none shrdesc-count 0
>>    $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
>>      shrdesc-mode basic shrdesc-count 1024
>>    $ devlink dev eswitch show pci/0000:08:00.0
>>      pci/0000:08:00.0: mode switchdev inline-mode none encap-mode basic \
>>      shrdesc-mode basic shrdesc-count 1024
>>
>> Signed-off-by: William Tu <witu@nvidia.com>
> This needs to target iproute2-next.
>
> Please update man page for devlink as well.
Hi Stephen,
Will fix it, thanks!
William

