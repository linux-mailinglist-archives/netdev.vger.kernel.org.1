Return-Path: <netdev+bounces-192633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59234AC0979
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3033B6D4D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EFC221F37;
	Thu, 22 May 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NkmJ6jsq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047E13C918;
	Thu, 22 May 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747908472; cv=fail; b=lAqP32oxm0ZfP8vVzUfAzTkWd1kCwrqIatmXEr8LfXP+gpx+6KhaWtzrFP+rMtIHC67/7C4ezmC9hSfIRPSOMt7PIsi9PZASgvdEIatKQe3qez0R3NPV30pEa5c/dhSo1tr/KLVCErkK+1TnTSMQYuJOXDlHs4zFi/FqgkRqzlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747908472; c=relaxed/simple;
	bh=zRw4uYRUDlOqPMDMj9xgW87DetIc/RaOyEazV5yVpjo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MtYoZW9ppKePK7RguWULXq+erF1H0GIXlnqMOxJKLhY9Z1lGWGfkUSRUzp/+VC2h/T7jj17BfMZd0D1dm6wMQslPEklglI/L8uBlnt3BrMGbQxFbM591x9LmXkOpR+KhasbD1N0ROicbicp6U0Es9Xa5hPlOksqbgvmPnaEP/+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NkmJ6jsq; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuWs/U1xfq3HOlxR5iIVgoFuzoakyZHpRpxkYnhnarVAiB8oEqw9ZpNFIJcb48V5zj1rQv74w74AjryIGeP7s5eeEEs1B0TcnOZ+WHrSpFxP/XvyK66e5uPGR81l2i/1PiOpAwtCMsyUQW822n3lWQI5EYCvulIg5qhFJSBR/nEqhbSRwVrDo0ZnsV28nS1BU4NBbkEL9/GdoEHeal/WkYBEnLTRg5kLRT95Kyts86VueR38SPQ166GQZTa5rAejjvSec94DrvOqNZiWUeJhbX9nVa+YgaqiXV5MTCAfp5TDweVJkzqsLGL8nvfBa7CywIG8EuIfBSMaJDafnPABDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aWQbjRTXe/0HkIgSDDI7jWRT6sUCQ0DEQYIoYoOAKU=;
 b=RPCfk2F0sCSH888or6i3w9g8usAHt93NfnuyWGq0yCy2kSLY9cEZCShGO60NUDAmITlJVTMQBmJpxaI+gUt9/XJurPzm7FrMG3FvWiTYjd7Wx2AmMhwERUu39sexK71EeDzqW84fepP6F9Mi4ihdATC0kt7RxRFopMCBfqSDnxTFntOoSc/v7zb33BzuzCSN+iS+vcq7NS+9C928Bn8Yw4dkB61mg9Y/o7vcDMVkDy3GLyGxP/RNxfmDrzj1PUflGhMeLNFn69alSSJchi9aHYpCu7Cz3NAMcEXy75Rtjjs4URikQpZ8LJ7Hk/uGHeWUzD/BRskeaFSaYjU08jzpaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aWQbjRTXe/0HkIgSDDI7jWRT6sUCQ0DEQYIoYoOAKU=;
 b=NkmJ6jsq9UQi7Razl3QG21V0mc+nF9ZZet7nOQ+WnKl/mVABg0KU1rjyNoQCN5RG5Pn3WsAWOZYuID/GO45Y7Fqi1QbS3RlmkTSEmGtm45/AbMB4RTT2ZVxfHPsoLZ41xb43Y8w/QtSct7WIMOYqWkKz5Op/wF2oXHdj1ZgoeVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV8PR12MB9642.namprd12.prod.outlook.com (2603:10b6:408:295::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 10:07:44 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 10:07:44 +0000
Message-ID: <5b20031c-ed46-4470-b65c-016410adf5c0@amd.com>
Date: Thu, 22 May 2025 11:07:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 06/22] sfc: make regs setup with checking and set
 media ready
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-7-alejandro.lucero-palau@amd.com>
 <682e1ccec6ebf_1626e1009a@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682e1ccec6ebf_1626e1009a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::35) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV8PR12MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: 712318ff-3c66-4122-2c1c-08dd99187ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1dHVXBKcE9uTUd0S2h2T2NCakFaVkgrakxsREl3dzBtRWFxc3BDM2RMeHRD?=
 =?utf-8?B?d2dzWXhZWHhLMEhXMVBKdzAyaEFNdno0ZlVYYzc2Q3NmSUc3WHU5ZEIyeDNX?=
 =?utf-8?B?VSs4WVJnbHpmOXgzTG1HMC9JTnc2REdsQWhGMzRKdS9wV3V0SHU5NGRlZ1VR?=
 =?utf-8?B?bG0zblF3SVFqcWVraW1EUzNySFkvYXBJY25Xd1ppb3dpUXBnb0gvZDhEUVJz?=
 =?utf-8?B?enJlbzZFUXZaTVZuQk1qN2srUzBMNXl6blVUR1N4cW1qaE4rUnlrKzdSTUgx?=
 =?utf-8?B?Umk4OWcrY0loK1BObGg3OGNzQzZNNFd5NDBRUTZuNWtydmVOSDdRbElzdmxq?=
 =?utf-8?B?TklCREg4dnBNL2ZhZnNaQXRMMjdRV2ZHeXBlQXlpZG5nZUdJV09CNHNzNnhO?=
 =?utf-8?B?TDhqVTV0dnVSUmhEQWEzNlFPQWQ4ak8yMHBCRkdjRmhudTd2bFBUd01IdkVL?=
 =?utf-8?B?NklKMmtXZG1BUTZheFVjMytuYysrLzJ6UXdLV3lWdXlZbGNjalk0NDNyQk0z?=
 =?utf-8?B?YUFPUXhGOXR3VzFiYmI5WU44QVZ3YkZ1RFFQWmxmM0Q4Z0ZyZjBPSUF5aWJ0?=
 =?utf-8?B?bVZHaWtrMFRkTWdqMVdwYmlROGJoYVczSGRnNDJ4dzdVUmo0QmdXN3lpQTZI?=
 =?utf-8?B?eHFXUWYvN1ErREZNUDZSU05mZXdOWXVwQ0c4ZHc5R0NnOVJVV3dmdVRoNmVp?=
 =?utf-8?B?eEdtOEl6UXYxeW9yUk8rRUd5bjBpZ09meTlBenNRSEtoT1F3Y0FaME13MUdm?=
 =?utf-8?B?eS83ZEFoR3BIaEJoTTZGbHdiUlJRZUIzSmtOcUVzUStIcFZ0NnM4SllmWEY5?=
 =?utf-8?B?NVBvZFFXeFlGUGRLaVpWNlJPT1pIaFpBRExxNzV0VUJtc2NUajdPMVhKTWU1?=
 =?utf-8?B?ZGMxMUZoSG54YUxUcWVrWFlYMHczazI0cm53K0FOVVNqcFZDUjZhUWNDQ1Bq?=
 =?utf-8?B?UGl3dUJSeFVxMnhMNFVacEVEYWV1RFMrMUJXMzRLVkhmUm5ERDAzdkhneDd3?=
 =?utf-8?B?VWp5UGIwZDZTaEVudkpZR2ZtRmhSU1JOZ2xqUXZvQ2Y2bThFblFpMWZydDFm?=
 =?utf-8?B?Z1d1TW1YNk9XV0lnM0ZzcW1nK0UxOU9wbjBYMjZEZ3pLVDR6WnBGWGV6UVd0?=
 =?utf-8?B?SElVdS9zVldUV1NNL0Y3aDNKQXhDc25sZEQ3Q0dKVUMwK2pRaXNYMkkzb0wr?=
 =?utf-8?B?SUs2cmJBOWJGeCt2bkx6YlRoRzgrTENwT3BJRWhVZjJONGVnRngrN0xwS2I2?=
 =?utf-8?B?bEoxYkNXRTYzODlpcUE5NktiVWRjOWxDVnJJbVlSYnArbkhKZkpGMEp0bi9p?=
 =?utf-8?B?ZGprU3ZXNXZRak82aDV0cmdkZ05zb21UTW15QnVKRERpVks3bi9YRm9wTUFp?=
 =?utf-8?B?WnVib3VGWE9SMmczZktiUFBRNXZkOXAxaFkvc0VPUGNrMWcrdndBYW9lSlBv?=
 =?utf-8?B?amxHUFhZWm5zQ0h4U0o5QkFubEhnUVNGb0dWa0RMdkR0dW5aNmIrV0pyTUVm?=
 =?utf-8?B?cDZyTFh3Z3RKdzVUMFNYY2xBYnBNejQ2VUtlb1lEaVBQSmxvTk14RklGRWtp?=
 =?utf-8?B?eGdnSkJnOHRlaThIUVhEWXZsbU9VVGxsMW9zSmdMaEV2eXpvWGZMTmNPam04?=
 =?utf-8?B?ZjdZUHRQQS9LdU8vSUJ5dm1aQjVjTlI0NHZ6ck51Sk5Vc3h4N1kxTUFtT1Rt?=
 =?utf-8?B?bU16MGV5L3d2VSsvbnRnNFdXdXplRUJNcEtjc1hCZ3lNYlRVT3lhWEg5T013?=
 =?utf-8?B?TlZjSTlXWDZWd1IzM2pFT2tYVGRmeEU0UEt4TElqcW9qWmNrMk52ZXIyOXVo?=
 =?utf-8?B?NmFHTHc4eURxK0pObmorWUI3VFJKeFBObmZPWklvN1R2ZlNQeiswOHdJdWs2?=
 =?utf-8?B?TExqd2Q1KzlZWnd0WkZzeVY4cFN3N3VXZnJRSDB2d01OK1U4N2JjcnJ3SStH?=
 =?utf-8?B?NmozbFpDczduOXhYK3BQc3NpY2NncjJOdUgwU1dhd3NJUTNQZW1SL0pQNS9u?=
 =?utf-8?B?YTZTamtQOFRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDZKV2I1ZWJEZFUyR25rYTRCNDFzZUYzNXJvVzJNVVl2TEwzOWl6QWp6cFRO?=
 =?utf-8?B?WDdvVGVhQUIyK0hoZnhFWU9kOGE0Q0VNaUd2TWo2UURlcUNZZTdDSEtjWGEv?=
 =?utf-8?B?Nk1ucHRIcU80cWFzT3ZIZjh5NEwvUmhBcW9zeFhYUVR6c0NUUjBkdkU2Y2NL?=
 =?utf-8?B?emhhSVBza2NMYXRldUlHTHNsT1dxSnVYWWx1NSszdU9ZSE1rTlowZDlQRFhF?=
 =?utf-8?B?WUl0TWVhR1dxRFM1MExhQnlIQUFteVRHcGltUnNlRTdZSElTdGs4eW1pWCs2?=
 =?utf-8?B?dkRKaUxqd0x5MWt6MVpZOHlIeWZZNFZhRWwxaThndXlUU1pERnNlVmtNV0xT?=
 =?utf-8?B?SDM1UGxHR0lVa0c5VEhvTW10czVPU3c1YmlQWlZGRkRnMnRBOTh3T1JYOEpX?=
 =?utf-8?B?bmplWHpUNFJkd0txa3RkTm1paTdjRVBxTFRxeXNJWWd5YzJqenEvZ2xvNzlL?=
 =?utf-8?B?RjErZjVvODdxbUZPbEw5TFNkZlFmajBaOWFybnZQTkl6bmltMDZBTkloTzNp?=
 =?utf-8?B?WUJFb21jRFpEa1NtS1RiRHdFT21GWlNUanJOWDFlWHg2b2M1Zm1BVXBLd2do?=
 =?utf-8?B?RFFwOEhJT1pkRDVzUnlVZmNuTjMvMzRMaXhELzdlcnFvWnY5WDYvQWNGZlFH?=
 =?utf-8?B?YytycU1qbCtVeGszZWlEeXJYSXFZZnFMTlpCczBuanlCRlBkNm9Vd3VBOVhJ?=
 =?utf-8?B?MURiOTZvb1I0cFUzNXhqNUI2Nk8vZUx1a0pZa2ZDcHdUaXJvYTR5U3ZQM3dT?=
 =?utf-8?B?bytkOU5yUVlUanJvYjc1UFZ0NnRrVUYyVUlMSlY4bUJLQ09wWTIveW5MaG5i?=
 =?utf-8?B?aW96VWQ3ZFZRUVdDRGwrWVFUYW40RytSVDBRRXJIUW5KYU92T09nNUtOTWJw?=
 =?utf-8?B?RzFEQ1FEaUFiK2t2VWx1eUpsMTNzemExV1RyWkhnZVROcG1Ec09tekx4Z2tK?=
 =?utf-8?B?QS9lOVhzZkFObitZVTZrbWY3WC8yaTFwVXlSRjJKWk1obi9LRXFwT0hZTE1K?=
 =?utf-8?B?dkpyWjNYa1dtN2dLN2k3ck9DM2RxRkhSYWR6RlpmcUlGK3hlOU9OVkhqWllz?=
 =?utf-8?B?cWxFaDdPNFFXOERWR3JJNTRDT3ZzTXlxdW9QNElZeFNEVkRWRS9Jc0FBZzBi?=
 =?utf-8?B?OEFrUldkWG9XeVc5QS9TN1A4c1Z6VlZMOU9vSzJ5NjBpdHl0eDlYeDl6QU1k?=
 =?utf-8?B?RWVSZ09yWFdqNCtKQUFxSGwvUXZiRUFuTEUzell5RDVUT1dvbCt5aW9KTjgw?=
 =?utf-8?B?RU9pRk5NMldIU3FFSkNMNEIrQzRYSWp3VjJ4N2ZrYVdrUHQxZHB2andRckRu?=
 =?utf-8?B?Q0R3ZTRFZlBycDAvZldJZEhKYlB0a0UvcnBwS1R0ZDZpNWMzOFY3dHRzaUda?=
 =?utf-8?B?Nkl5cE1VQ1FQZUlOSURIUzlwVjlNalBLRGZkOTRPVEJtRzJPdGhnRTFjd0pm?=
 =?utf-8?B?M24zRnIzaHlRUjlkQ1FiY3JGNllYUExPMG5uWFhrT0ZFTlBBZERBUDhtRU4x?=
 =?utf-8?B?UkQ1cHVLWnFiTERwbWg4VGgwek1SWEJNRWlBYXA4Y25CM2tINXUrRW5HZmR6?=
 =?utf-8?B?RkFWbG4rWVRKL0NoQWd5VVM1Y0FiWTdZQzdWOXdldjRSM25VSmc5T1hEbEQw?=
 =?utf-8?B?cEl5czRyanExZ3I1bEdyWjJIeUppZ2RSNEplQVlzMTFCVUZUWHNkZnJJYUNo?=
 =?utf-8?B?MU40bWdpRS9mREdDTW9Sd0dvckd2eUlMQ2ttTW1JcUkyejBDS2RIOWV4bWxv?=
 =?utf-8?B?UkRuLzVvZ3ROTG0rQ1dicGlHMTdpdlU0aW1OdGZzVC9vOHhPWnBxVi9ITE1h?=
 =?utf-8?B?OVBtTTFyY0ZGdDJYdVFDZ2hDZFlLQzdKa3BCRytPOTVKNjFPcG15dHRnMHdE?=
 =?utf-8?B?Qk9RdVFjYUx3T3hUdjlva1EzUWJ6OS9LSkM2T05TNVRXdGJmOGYveXl5M2xM?=
 =?utf-8?B?TjNoNlVSeU5uTmcyQ0RUVVJzVktuWHl2bEZ2MUNRVHlMVWJuMmxySGR1ZVRO?=
 =?utf-8?B?dER1RHJWMVpEeDVBdFZVZnhkcXF5WkZZenNMRXYxR1RXNFdLR2dHQk9yRWRR?=
 =?utf-8?B?dGJTUHYybUlyMC9IUC9kKzFUTy8vT2N1V3hTV2p3RDA3WGhsaUNyb3djeFNM?=
 =?utf-8?Q?Q5KrMQNfA/KnJRzKJuSQgydGH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712318ff-3c66-4122-2c1c-08dd99187ebf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 10:07:44.3626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rs6DX5ey21SEIbZji4iTRwdeh0ev68iff3sNUUi2lUWSGNCMbDCqa8bn1Ga69QH1TDaBZlLBYQ65Nv/xl9f3Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9642


On 5/21/25 19:34, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl code for registers discovery and mapping.
>>
>> Validate capabilities found based on those registers against expected
>> capabilities.
>>
>> Set media ready explicitly as there is no means for doing so without
>> a mailbox and without the related cxl register, not mandatory for type2.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Reviewed-by: Zhi Wang <zhi@nvidia.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 753d5b7d49b6..e94af8bf3a79 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -19,10 +19,13 @@
>>   
>>   int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
>> +	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>> +	int rc;
>>   
>>   	probe_data->cxl_pio_initialised = false;
>>   
>> @@ -43,6 +46,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	if (!cxl)
>>   		return -ENOMEM;
>>   
>> +	set_bit(CXL_DEV_CAP_HDM, expected);
>> +	set_bit(CXL_DEV_CAP_RAS, expected);
>> +
>> +	rc = cxl_pci_accel_setup_regs(pci_dev, &cxl->cxlds, found);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL accel setup regs failed");
>> +		return rc;
>> +	}
>> +
>> +	/*
>> +	 * Checking mandatory caps are there as, at least, a subset of those
>> +	 * found.
>> +	 */
>> +	if (cxl_check_caps(pci_dev, expected, found))
>> +		return -ENXIO;
> This all looks like an obfuscated way of writing:
>
>      cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>      if (!map.component_map.ras.valid || !map.component_map.hdm_decoder.valid)
>           /* sfc cxl expectations not met */


That is an unfair comment.


Map is not available here and I do not think it should. The CXL API 
should hide all this. Adding that new accel function avoids repeating 
something all the drivers will go through:


cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);

Maybe cxl_map_device_regs(&map, &cxlds->regs.device_regs);

cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &cxlds->reg_map, caps);

And maybe cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component, BIT(CXL_CM_CAP_CAP_ID_RAS));



