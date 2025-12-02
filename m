Return-Path: <netdev+bounces-243333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EC8C9D3D1
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 23:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 895D234A746
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 22:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515DA198A17;
	Tue,  2 Dec 2025 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dvxkHfIl"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5691F16B
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764715552; cv=fail; b=LXy/74OT03shr5ekStCxzHC1NqLN+AB90TJEYe+Y+6F4tHIw2+IQgVx52vqtSwdnOuvw4Doo0oFewbvPQ+PqAMcezwIFM26LcPqgvhwPkMSeGkxzwyrXsFxEyJaS2KreoIXGDJKfGELTHuq7VWZpOEHQaI/x2ORlXfC8vC1iCZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764715552; c=relaxed/simple;
	bh=8ok+VE4fnGod1omr2r2VPKo5rf6v8CZdFGcNtP3df9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mugWMyR0UTxCl1njKqdtl5HVD9wd4aFShC+Tasc0g5gLvzuEnFBhYPtKWvi+kXMuoSfxhpC3Ymuuh4dlzWow2WJtGph7d+rHdB20ebbgmPQbLqh4BQkUsbnLiGADZ2nKYyCkYMwX/tRnp8dJAu7L7jhnbyaNCJxKw3wCDmM9+qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dvxkHfIl; arc=fail smtp.client-ip=52.101.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cM6DSsXBA4SWsfaPFawQ3yULfLZguxel1dXD4WUs2YfwFg0jPe5xKfDUPRpp1X3ReTrXIZ+YTzy09pHM1u9O1P/diZNeRkB521Toz+/OuqpXIs+MsLqo4oeZoz4EM8MWo1tCcNUKF6VgzFIQ6gb/YzG8agnmsEs5Ic+u9j5hpkk0dupoQnxBWSPrKOQ2aeQekh58gWdJyoxTYgUYVb9ZvhVtNgErjki8fIojQyCPyDqaseoFssT+OKhweiY6NjF265RkyQChtvlEyudD78WPW6d7ioMaHDRPyzqU2HeJoO+2D6ksuyJ+AHxOT6dfpxaCEa36SJAKXxCEHSvY4/PzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1swO9TqKc//q2iG+kCxXpsLqNFnOzuqnamp9p5UT+E=;
 b=FJAdR+V4vK0VGg8WFGKibUF3Vc6EzRQyX9dcgj93lp9K0RrK7O6TkIU1riTrLwfZ5ImGnUPpLxZki58mtHYlIpmV3L9meOaqz0s60P7sXWy7MLR/Jw+wLSPgqmR7TfqaKTLoTad/HJyN9RehqfDKaYHxN8Bq/rxPJ08/mZp5DAIpTuDzbmzYIjVuEukKk2K7K2C8vPX2gJUSYCmKpqrc4UTB9bh8f8OaiXb/pnjr0qAU/PGV2QJ8/bIGDkfAtz671MhPoyZTqUxdxZLsjqwc1j/DSh1n+ZvLBJjDhLKKXn/YUAa63FFQLBewm51NHYNAhIhKGo9Zu71bh6BuayhJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1swO9TqKc//q2iG+kCxXpsLqNFnOzuqnamp9p5UT+E=;
 b=dvxkHfIlsHeGKjDcgFrLF+Pel96LggmvMBoRty1qxzlG+Rr/Ws3nYxgSGpp3FNZ3eT0Bj6Z05T0sC/cme55K6ZsqlRvO9V1xJ/3qu97BX0bNBX9/Bj+Pk8w17d10MTF3lxo6sMbi5kx+cZo3NAjhsUdWieJQ+CgGsSyf1317yfLzISNRtJRCy+/lAXaRwbS3vzORdy2LqMAkTOAtM+lG1Cj0AwPm3KmhXdXYZTRZziA9kwXXvTu7AH22givNJYqDgUHRzpM1Bh8cBqcKDttqdIUz0n59SLHlcIz4VIjJPbSXq8HN8RFnL7KosptUsIXS/u4INIbDGzR6Dykk64pN7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 22:45:47 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 22:45:47 +0000
Message-ID: <3dfbe544-f5e9-4bf2-9d76-4f00dd887ced@nvidia.com>
Date: Tue, 2 Dec 2025 16:45:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, edumazet@google.com
References: <20251126193539.7791-1-danielj@nvidia.com>
 <20251126193539.7791-12-danielj@nvidia.com>
 <aS8L--z0ezhkywT_@horms.kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <aS8L--z0ezhkywT_@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:5:334::29) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: f928cef7-d935-4bf6-0225-08de31f488eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGNMVnkwczJFVkJxdE9NSFRGSWh0QWgvWUROSGNPVkI1SEFReklzQnhxZWpv?=
 =?utf-8?B?ekZvVG5NZ0w0Q21vNmliTHc4T0R0ZUZMNC9mOVcwTHlFMlU1MC8rZ1EvMlI3?=
 =?utf-8?B?MElwZXZkUldLUHE2UlNPcGRIRDRnbW5hQlpsZi9nVDNMVGRiTFpxeUkwbVdq?=
 =?utf-8?B?SlNQT01qRkswNi9hMUFiZUg1N05mWlVvZzBxdjF0dTVoTWtKOHl0ZzlneGNs?=
 =?utf-8?B?UWMwVm1aL3RqOHdkaHd5WURLeHM1UGgya2lDUVh4WGcvUDNicHU1RjQ5VTRp?=
 =?utf-8?B?TDJxQkZxbkRaSDljZTl3eS94NEhUanphWkdLUzBwZGU4eVdsL3g4NytocWVI?=
 =?utf-8?B?QlNXNG9rS01qeXNGNmo1aFF5QmFndFRyT0s4d01wYjhEYXRFa1dhL0lJb1Ay?=
 =?utf-8?B?Y0lISkw4UWZSWmtWVjNWaGM1bm8yTVpQRkpOZG1EZ0k1WFdGanMwekVUTTNo?=
 =?utf-8?B?QURtWEd6NUpBWmVET2N0MzRvVXhYa0FYcEFMVEVzVnZMR1dSeWVQRmVvL3k2?=
 =?utf-8?B?Vk9oZ2x0NnEwVWtWSkhKV0tEWHc5Z2RhbDRwcUdYZHFzamRaa05zcS9rbVBu?=
 =?utf-8?B?SVdPTnZTMWEzekc0ekZaYzRKVU9pOVBtVDZHZHF3ZGt2cEVyV2UrZVdOT2FL?=
 =?utf-8?B?NCtJbnNzTWJsZFNnMEVTcTJSS3hNQ0JORHV0RzhlTkFIZGl5SGRsTnhWb09t?=
 =?utf-8?B?TUU3aTY1MXl2eGNoYkZVNEtnU0FVR1FYUDhUREVjQWh0OFJHb3JoQ29TTTcz?=
 =?utf-8?B?SWV6QmwzcjlHMDdCM0lXaEs2NURKa3FwaVpoM0FRLytrNzA0QWpLSkFtc3ZS?=
 =?utf-8?B?MkFqL21mWDBsQ0NZbGt6SlVqMjg2c2NaNEIzYXQ0Qk9QMDNLMkJrY1AxejhK?=
 =?utf-8?B?UW56TXNOTFBPWG5tM1dRUElPTXRLK25DYm9FYjFOOThVaVVzams3OEhNUlVv?=
 =?utf-8?B?K0MzazM2OEdlZm9QUm1hc3dvU3VJOE1FSnZzaGZEZWxyaUFyRkpuRkRFQ0dX?=
 =?utf-8?B?UWlTWHRzNFBwZzllUVc0Z1ZBeEE3cFAwdlBIczZEcFRsUVE3Wk8zalZ2N0c4?=
 =?utf-8?B?aG5zOXg2NmJkQ0VQb3BhMVN4ZW52Y2huUjE3ZDdUZTM4MmFOYnJYdWZLRHhC?=
 =?utf-8?B?czhjNDBLTnV5RDcyUjVTZXo3cmlHcVJpQkFKdFlKQW00TzJYcWJvUVpSQ0VO?=
 =?utf-8?B?bU5LRWJuMlpmOWtnV2FacUMwZVJHNCsrOEQybnptVkN5TlhicDFDRkFoQyty?=
 =?utf-8?B?TFR4MmdOa1hyNU1oeUloWXNPeC9reFhvN1dIeWhBdFVQYkcxMkJVTS9CK3Ra?=
 =?utf-8?B?WkJmemx6bUhWc0Flc1J0QVo1SGw4RTduVTdyZnFiTEE2TGRHYjZDNHpnRDVv?=
 =?utf-8?B?aEo5YTFiWEtuVGEwcnJXa096Y3g2aVplWUxEeUR4SUZoaVdwN1JST04veVRK?=
 =?utf-8?B?VEVDbDNoMjFuMTJCcDlkenB4U1haTFJqQnpSQ2JtVWFjMjVYUGNxTWZTZkJY?=
 =?utf-8?B?TklrdW9nU0x3Tzh2NG5aQ1VrL1pYRHQwNEJ0cXFLMy9FMTYzSEdvazZaUGQr?=
 =?utf-8?B?TnZUSUltMUN5c3Y4M1dSUDViUmVQR2tEOGNPZjl3Y0NNajV5TjUrMnNEK0RE?=
 =?utf-8?B?aTVVcG16VnViZThqRnNEbWdtT05OSWZyRHdHYXV6V2x2UW5CTHVqMkFjZEtN?=
 =?utf-8?B?NEFidU9sVFBYNFhDM0RQM1pDV2xvZkNxYiswaGNvVExIbUlUd0ZHZld4SGpy?=
 =?utf-8?B?QlczNjdQS3lHMFRhQ0hqdXFjZks0Q05XdDFXKytEbjMwM3VwVUZnbURpaisx?=
 =?utf-8?B?RHlNZFVYdkJlUU81TTVDcmFDWGZ4SWRFMk9QYzBlM1V6djNScHJOQk1wZjJs?=
 =?utf-8?B?Z2x4M0FpU1NUMm1nMXJtUVphRXB2R3JBQWg0Skt6UkY1Y0ZBY01JUldsWWZF?=
 =?utf-8?Q?+6RsI1Nwn32BnSZ0njHEhh3fgaejbODc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3d3NEZDcTFvaThvcDR5WVREWWpSMGE2OUczd3B1QXFoeUxjZHZMbEo2UEp0?=
 =?utf-8?B?RE1sQUJUV1NWRHJ5WHkwOGI1TzY5RXVjZWE2ZDdEaXo2UmNhNU9PaExMTEMr?=
 =?utf-8?B?KzVNRjk2aHNtNnpsdG04QUl2NnpWSXhtY3dhekIxQVlNZldTVk1aNmxoZ2Zo?=
 =?utf-8?B?V2pMMXRIcmFlN0ljUVpxVUxVMFVzQlRpWHFlTnFCLzZhWkVXM1NtaU5BeU9h?=
 =?utf-8?B?L0cxQjF2cFNIajFVaUJ1NGlJU1I0amEvVnZFZlNOV3lmc3o4WGc0aXJKTEx2?=
 =?utf-8?B?RVRpcWpvbDI4SThWTlRTUXMwYm5ZT1R5ME9jSDdtNUk4d2NwMEFtSERaWmwy?=
 =?utf-8?B?aUFwV1JJcCtXYjhUNGQ0SERvTjBYSC85MkJwS0VsR1NDeDZlempucnBHM3BW?=
 =?utf-8?B?WWtlUU9ycjRUdzNvS3VtMVRNck1ydjdjdWdoY0JaUUhkR2N1ZThQd3F2cVNj?=
 =?utf-8?B?azd4TWJHWDlCSVNQdDNKVnhPS0dxQ003SkV0TUxsNWpDanBCVjFlUmZ1R0da?=
 =?utf-8?B?bnJ3YXdzNVlnY0R3TFU1Qkk0Tzc5QjUweC95SVlrbVhjTFpQQnp6L0t3cUVp?=
 =?utf-8?B?RkpjbXVud3ZHd3UxdExHQjJrTlVSdXFFVjNTNE1zdkFneWh0dnZmejVPdGUw?=
 =?utf-8?B?akxpdEk2QW1IZFJKek9ZdjdEM1FOQ2VIeEtFRE1tRTVFTnIzczBTVVUyaCta?=
 =?utf-8?B?cE5Fb1dEODNmbTFiWnVRajAwTlNNOVFkVVRjdVR2bXlwYzlnWVpPWml3cTJu?=
 =?utf-8?B?SFNDc1Z6SDc5U2Rza2ppeTVRYmZqaDVvNDA2SXFvVjd6Z0hORHkrbi92eWVR?=
 =?utf-8?B?cTAxUVkrclI1Sk40Si9NYTdHRE1NTGp5cXV6cDNLZTM4ejZlY2dqMTFtYVFX?=
 =?utf-8?B?bUF4OVhYTFdpSElPK3U0VTlIYXZ2RnJQbmlhS1hxNWxIU2tITTcwK3JaOFBv?=
 =?utf-8?B?NUxsOHVwUm94ampQcmszOHYyejZEK2FTYS9ocGF4NjdRaTNYbEVxMFdCNm1K?=
 =?utf-8?B?QWtXSkpLSGVlaytOYXZyWnlGanlZK2RLamtaY2JHdGNPSmVsN05meEFJNHBQ?=
 =?utf-8?B?K0dBYVZyMnhDcjNCbWNJZEtvM1ZLOGlmNnNhY05lbDFsN3ZkNFgwT20vSm1K?=
 =?utf-8?B?UCtacTNpWXpDU2RvUGVCZlpZWHkzOU83K1ZaNEoxLzFaN01vMlFGNTVYbmFS?=
 =?utf-8?B?b3hCSHFJODhQQUZSN3JKQjd1cXQ5bFhQRzhOY29YSHAzVzhDb0U3aFUxK2dS?=
 =?utf-8?B?cVZZRHp4Tno1bEpZWURLT1M0aWFhNktPdHV0VGZHWGFYb2o0MjY2aXVja3Nz?=
 =?utf-8?B?QWhNS09mR2p3bnlVZ3JUc3NmQVV0YllYRE9neTZyaWtWRHk2VmZjY2x6MjJi?=
 =?utf-8?B?czRMRFZyMTBHVFhvMFlneWZSZTVUS3BjUk9rY3hEWjU4c2JkYmk5OTR5bkds?=
 =?utf-8?B?SEJWMmU5cVBxTFB2SDdWa3ZqUnhGOFgyQ21Hb0x5ckRSNERwcjVpSTF1Uk5a?=
 =?utf-8?B?dGEzYzFtN29iTzRodkhCMVpOeGNybExrUEUwSVNmQk1lRWdaWnRENWRJQTM5?=
 =?utf-8?B?d203d0RoN2luN1phcHg0SUcwbkc5TGkrMVMybFlxWlk0QlpvdVI0U21MZGdI?=
 =?utf-8?B?TnZIOG5rTFBQcXpzQ1VIcm1mbzZCWmdSVC94SVZ1bkxCWThFZEdZREpWT25l?=
 =?utf-8?B?eC9jb3Z2S3FKeW1qY3pGbFI5R1k5RWh5WGl1VmRIZC8xaHdhRmQxWUpkaU82?=
 =?utf-8?B?bHJLTHBBSjBUQUw0KzlWV1dWVlZQNlFNdGZ4ZHQ4KysvZ3V3UDhFbXZ1Ykcr?=
 =?utf-8?B?Q2ZDTm9SbGtvbHIyMTBkb0lhTjkwVndLTE9hWTQydFZVR0pTdmRXWnpuVC92?=
 =?utf-8?B?WnJ5ZUlXV1BHbVgrRVFYRXd0aUdGa0tlR1JMK0RaYTV6Ym1WL2xJUlNqejZu?=
 =?utf-8?B?THdpUWd1cGFyTXpWTGlUZmMzbWhHTjBid1RRTXNFNnhVS0tyZHFBQnBRWUNu?=
 =?utf-8?B?eHZPL0pUWnpaeGFHb3hGaGZBUjg2RnV6N042eEJDckU1SmZwQ2NGMlhKV0JP?=
 =?utf-8?B?YzkvbFNnTjJxcC94NW96UzZQMWtrQVV3MmZDR0g2aUxjRXBUWUFnVjkzQzds?=
 =?utf-8?Q?HqsUeLuu4oIwDIYcqaderVfkj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f928cef7-d935-4bf6-0225-08de31f488eb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 22:45:47.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5wlv87eVrBXp8+vy/7GElTGFvTi13K+GEs24qx5dc27VBg0icDA7Due2HNxI/CSvhNp/Vfsy7wNvoWt4lmLrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068

On 12/2/25 9:55 AM, Simon Horman wrote:
> On Wed, Nov 26, 2025 at 01:35:38PM -0600, Daniel Jurgens wrote:
> 
> ...
> 
>> @@ -6005,6 +6085,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>>  		mask->tos = l3_mask->tos;
>>  		key->tos = l3_val->tos;
>>  	}
>> +
>> +	if (l3_mask->proto) {
>> +		mask->protocol = l3_mask->proto;
>> +		key->protocol = l3_val->proto;
>> +	}
>>  }
> 
> Hi Daniel,
> 
> Claude Code with review-prompts flags an issue here,
> which I can't convince myself is not the case.
> 
> If parse_ip4() is called for a IP_USER_FLOW, which use ethtool_usrip4_spec,
> as does this function, then all is well.
> 
> However, it seems that it may also be called for TCP_V4_FLOW and UDP_V4_FLOW
> flows, in which case accessing .proto will overrun the mask and key which
> are actually struct ethtool_tcpip4_spec.
> 
> https://netdev-ai.bots.linux.dev/ai-review.html?id=51d97b85-5ca3-4cb8-a96a-0d6eab5e7196#patch-10

Yes, you're right. Since I'm setting those fields explicitly based on
numhdrs I can just remove this.

> 
>>  
>>  static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
>> @@ -6022,16 +6107,35 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
>>  		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
>>  		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
>>  	}
>> +
>> +	if (l3_mask->l4_proto) {
>> +		mask->nexthdr = l3_mask->l4_proto;
>> +		key->nexthdr = l3_val->l4_proto;
>> +	}
> 
> Likewise here.
> 
>>  }
> 
> ...


