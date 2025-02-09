Return-Path: <netdev+bounces-164393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D52DCA2DB86
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 08:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5FD3A66EB
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 07:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD4613213E;
	Sun,  9 Feb 2025 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JFUg9otU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E452563;
	Sun,  9 Feb 2025 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739087974; cv=fail; b=rYkfSx903JX7HpOAUMdXLzLi53IMcU2U1/b9OY/wGjucK3ZZW0gpxEUIG9CFOD7a8gyUI7p8g10i+mXiqMHBwofF6QFUZcjJBeB/PC8YjHRQ+VnRVr/0bqGfpQukVjdoFYbDgM08Bpl+kucVgfb7laq9fAqQERPQuGPUp3mtI4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739087974; c=relaxed/simple;
	bh=vA0Xgu9V5beau0NcZMY9OtyWoMi/alteD/6jZYo+Q90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V/E41TBl93WSQDI6tzQ1geLzVc253794plZKA0FuQop4Z04QjmVzqzbRl8XYNzXOMq5qHiQEKoYcIcvAZegGZXAmIAAGP92qBy2A4We79REbNn/cYVYP2IxEfN9jySsGnNLC+I/o2EG+HqCKIol5fMLoxhKj0Loga9rfYNJPrmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JFUg9otU; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQFOlU/DpUBcrrsSMYjlL7YMGp4WhwB+gTxaRufVe++/FzoHtd2w0YqldxFBXFYTuP7xK38c4UZ2LY1bY7hU8Q2UhgrSONzuNo/k/A6btLBJgAEbF52udQt+Q/vHaLN/eL2scUrpYfYYuk+vJdaXW2F8Ncyl3AoKJF+6m5hfn0eFYHvBbD0aEJwfPYj04jzVMJKmXkFcWnvJ0W/8UwoHu8Tdjqda5K2gVBGcM/NNuV3M/Vw2AM8rABi0+Nyjn1bUGkrEqAT36EpxJw7RPxF9J2qYy0Fl4tPkAQe0XCU89gyGQn/dB/eVtFEUsFdRIBNIVIUTsL/irwBi3uE2JM6jhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoRxDuAW7jiQ4dQIWjknAYC03XktxucmfOLmnq2hxnY=;
 b=hAkvUa2XyyuPplBc2uwBEzzC6ahkVUh15lYS0GHc/2VoyH83Zn/bFgbvg3RM1cJkYH/BpC1SI2u/wENigSqDNO1DNFUAwSLQ1FUN6Ep7T/MQVZ7NDOsjtlVAiumZwFUmFgNcNmIxEAaUEXhVbpIGZMnQl6+aLkWOWLQQb6c4oN+wHTFGozyf2jAOme0pAPr2mIQ28aEVNGCU9Y1zVuVb7nq/aU0e8X675GL4nIVWf89SZIimrRtS0B2FCkEG27cr5eQRis+e6ltDpurvs0k+zVqytFUBjEPGLd7eLIjBz2d3+lST+UHw84/j329NvxYE1xNu5NfJLrZnnrriiLWUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoRxDuAW7jiQ4dQIWjknAYC03XktxucmfOLmnq2hxnY=;
 b=JFUg9otUD6fk2F1DEvq+HoIZwOIJ6oufjzgGw31Lq8wZew0E258W7QX/pID/aqE6wy8YnkuW73NLZvwIamIuiGvltuSwJqTr/+vCKoSu4TZnj7A6cTm1Vdyb2bybdt6EJJrFDahS0X9ibNST1NTC/h8RwoCQDrPdPdbbUzs5oHMo1C1bhHJX/mMJJr9ite3+u1bE2L85q2H7UIaZTJduX2stuK+lWnTcXJHU5a8tbcXjosZ24lVQl6r5OayuVdwKrbTMMC6rx3faKHR8FNfaTd4W3d6FjlSIlfKQytEr4nTeKd2UYhw6U4wAB39prBClOnFpwIu6IuHytJ9f4MCj5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 07:59:30 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8422.011; Sun, 9 Feb 2025
 07:59:30 +0000
Message-ID: <191d5c1c-7a86-4309-9e74-0bc275c01e45@nvidia.com>
Date: Sun, 9 Feb 2025 09:59:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] Symmetric OR-XOR RSS hash
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 linux-doc@vger.kernel.org
References: <20250205135341.542720-1-gal@nvidia.com>
 <20250206173225.294954e2@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250206173225.294954e2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::19) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: f54e4c36-fe61-4dc6-d840-08dd48dfae9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWk3ZWIzYzJRWnlJSEQ4Q1JQWjdwb3FRVnFESlFYQWdYRzRoTmNZNlFGMzVx?=
 =?utf-8?B?bFBaZHZwbTFPZGNkdEhBTnIyQTZtL3UwWGhYazJ3Z2JBOXlNMXZQTFBmdlQ5?=
 =?utf-8?B?V0YxT0lNUDNWdlpCVUhSendYLzN5aXZPRjJpdGJ4TFNBQUpDbkxZMjlHaStJ?=
 =?utf-8?B?VWJ6Wk1zMVdIMHo1TkY1R0FwOXAyUGNPYVQ4cEhjenVNdVFNdGQzZWNPSFpN?=
 =?utf-8?B?M1RIa0d0YVQrM3dmVGpLanFjS284OUF4VG1CYUsvU3RsUEVLWk1FWDBvbEJB?=
 =?utf-8?B?ZnpaN0N3aFRmSUxnMFRjczRDVmhzUFJnOGNTS25xc3BFOWhCMlRpc3pOUUhX?=
 =?utf-8?B?TFdPYTF0UE5zb0lCb0VXa1hJWTlialBKSkphUkg5NW9xT0JTYXVsT2k0TUc0?=
 =?utf-8?B?Wno5RUdPOEhTdUlCWTJWSDNjMkdiK1dPRXl4cmN4UDZKOUxtMk8yQ2dFNjJi?=
 =?utf-8?B?WDZrVnBSN1orTkRPWTVlZEdUM3VwZzZBR0o2Z05KR2E1Qm1UMFkvc3ZUeXJ0?=
 =?utf-8?B?cDJ2b21xQUVXc2RSTEVrbUVIanhNdXd2NmtUc0FpZGFMa2x5Ky9tY2taTEcw?=
 =?utf-8?B?YmFUS3VVZzZ5MmNnYmllN3pXdGxacjJrRWxnUmsrLzZDdXRXQmlBb0VDTUg2?=
 =?utf-8?B?eGpkWjEyZk52RmhxNVg2MzAvUFgvWS9KalUwU1RpcWFxNWluN0ZvOEtHZkZL?=
 =?utf-8?B?ZXlNNnlCbTZZWTRieXNaeVhRYjZpSVhCbitlRWR6S0dmc0wzYXpLSnpTdTVB?=
 =?utf-8?B?UmhxdW5nNVRYUnNnK3A4emhIdG9LcmwzbXVLcUpRak5LTzZjbW16SjR3N3FY?=
 =?utf-8?B?MUFoKzJmcHRETzdVd0pzdWNJYWE1b2FrUVdMbk9IUzZJcW9maUVjcG1oZzVt?=
 =?utf-8?B?amdvbDllbCtNVnZCVGZTWXBVYW1uUk45WkptdHlSMWZXS21lNFg0b0dHYTYr?=
 =?utf-8?B?SE51OWt3eHZUOHk0aUNwUDM1cEdrOXBCNXpwNHJzeUhFVkxrNFRSRG5UUE11?=
 =?utf-8?B?Qk9HK29sQWt6Sk9VM2NvZ1VnK0xmSUZCL2FIMVI5ZTA4U3NLNDZxR3FnVWha?=
 =?utf-8?B?UlhaRys3cVhZTVo0QVppNHVtRS96K3JUT2dRa2gzVm11Z3pHNGxOZFgrN3hF?=
 =?utf-8?B?djBtdGdoTHpKczYxeC9Kc3hvUlJJYkRSdDNtU3hubTBjNTVHcVRVZXVpM2N0?=
 =?utf-8?B?dzcvWnR4YWZ6M2lmdHBHN0xSMUJ4VWFsenh4VE5iZEVReGkxVmRIM2x6bGth?=
 =?utf-8?B?cy96QTR3R1Q3VERjSzRaNG4vKzRVY0ZQOEkrb1ZabkpaL21WYXd5aENDdjFC?=
 =?utf-8?B?UkVZbTV0a1YyUkVDeXdIVWRrOERpS1pyRXpCdEhUZVoxcnF0emEwT3BRTzhj?=
 =?utf-8?B?VTY3SFZrd2xJS2tzcC9KWGxHRERZQ1YrQlVEU01uQ2wzOXVCcXVodHZlYjdJ?=
 =?utf-8?B?ZkxtUmVGcVRDWVdZMDJPQ00xUjVBeTdQR1BrcngyV3U3TE5pdXFvY09jTDZL?=
 =?utf-8?B?TGlXb21QYzhZZlFrSjhLeWtVdE0rZXBkMTF5aWZRUVZZWlpvK29rSlUrRHpV?=
 =?utf-8?B?ZkxIamRIRmZTcjFJWUQ2aDNuOXVkMUJWMTM3aVFUZFNuY3lQWkZ4YldhM3lm?=
 =?utf-8?B?RWhaSHgzWll1QnFUMVVnVGh5d01xTFVJWEQ2RStGRWFnOVNjZFBLd3pTLy9s?=
 =?utf-8?B?WWg0Z1N1MzJMTHYxenhhVmRsMVhBRit1KzhFZlowT3FRWTRhdkJuT3dwT05x?=
 =?utf-8?B?MzFYUTRhY3VMTWxkY1djWmgzeGJZMlNwbU4xWDZHQnJTeGxIYlN0a2huZ0JX?=
 =?utf-8?B?T3h3aFJraysyR2JMQ0xzNFgxR3kvMlFHaDZUOXR0SlFPNVRueGJZRDB3TFNB?=
 =?utf-8?Q?G3k2/KWvOXV6g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXpkcThSZW8rNFVZSUVja3E3ZHQ0WEVVemdKS0ZKcGhBZnMxY21uSHBXZlll?=
 =?utf-8?B?OS9HdkxjemlsdlpnR3JWTlNoN2RYR1lOdUxhdThBZVNON3c1RFY5UmhBUWI5?=
 =?utf-8?B?b3ZnWHJobC9McGpscXk3N1ByZE5lczJacTFHRFFiRGY2MSs2bEFYbWE5YVZD?=
 =?utf-8?B?L2d1ZFN6Z1hJbkVNczdQQlpSaFAzbXo1TUc1RTNicVdpaGtXZU41dlJ2K1Vq?=
 =?utf-8?B?QVBJOU95MmhHRFFwMVJURVhDNGduUWtNMm4vaXB1Zm9nMGVqcytjQkZTRldn?=
 =?utf-8?B?eFJMejFiMnluVmJqSTAxeVhXclNnTzBvK1AyaXZQUHBMZXBwaDh2dSttVzZq?=
 =?utf-8?B?dk9ORysvZjFHTVpnSXpxYnlXUTl4ZWN1Wlhyazluai9VclJwV1dsVTRiSit6?=
 =?utf-8?B?dWdORldnV2JLa0Rvbk5KaVU0ZHo4MEZDcENYVFAxR2R2RE9UVERwcVBBNDZX?=
 =?utf-8?B?czZOcDN2MG5lWThFT2tzNGZ5WHg0d242ZElXWWxNdFRPUUwrWmp0WGE2aUJ5?=
 =?utf-8?B?cXhaNEFSd2ZYUVpxbG9scUxaaVdhVmxyZEN0SEpoajk3MElOenhlc2NhWkJZ?=
 =?utf-8?B?elZ2Um9aNHJyQVM3WEdqZ2tvWDBlNmlRamhoVXBCYm5MaEd6Q3BsTWY4VlZD?=
 =?utf-8?B?RmNwQm94TWpOY0w4SDNQSU5tc3ZJR284TE85cHM5YUVCOHpXWDdOWTdZdTAr?=
 =?utf-8?B?U0RYc3krOG5GcGxqWEJiY0NtcUorVVdRYlREZFVuS1kvUExaUVFWRkF2UjMv?=
 =?utf-8?B?Ly80R1ppMFUrV2ZJNGI5bklxc1YzTmlReUxsMzRxOVVrbGFzWnJpbUs5dnFN?=
 =?utf-8?B?bm9UdnZOOHdhVUVhSmdFWWtXbDN1VDVoWXAwTTcxNWdWd0Q2WFN2ZVBGNTQ2?=
 =?utf-8?B?bDNzZUVlSmllcWtjLy9tSDlGNVVrS1RBdnRhaUllK0d5MTZhc2Nrb0RhaEkr?=
 =?utf-8?B?QVdSU2xDSFF6OTVObWFWcE9EbEhNV0NMWm9hODRpNC92Z0I5c3F1SVlncngx?=
 =?utf-8?B?N2VvbUNoTXA0dmJuRTM0UjhOUU9YYWNqcUlOa2F3OHA1eU5mNzdqcXVJblRk?=
 =?utf-8?B?d01mdk1Yc3VvK080RUt2L0YvMHpwWXdsZkF1UnZpTS9sY0tjRU0wQmRpMnU5?=
 =?utf-8?B?NDdhREFjdEdhdUNvL21WMFY0TDJOUTBOTzVIWkZkZTJYK3RHQnZ1cEdSaS9t?=
 =?utf-8?B?YzRkZGtqSm1mT0ROQVpoN1ZQM3I0QXNRY0RLaDRsaW04bFJlQnY3ZW1kVFVP?=
 =?utf-8?B?WUlIYThaZFVWL212OFpFZDlYaTB2ZWRHZityMVNRblBjQVRHcUtDZ3JmNHJU?=
 =?utf-8?B?K2l1VWJPY2pEV1BYQ1cvZndtNDlRaTBlRFFCR21NRmpVUVdSQzJxNG9DYllD?=
 =?utf-8?B?bFVJUHNwdHptSjlUNXFncTM3Z1hCQUpiK0QwVE5WM0xmb0E0NGJ1NlN1VjJS?=
 =?utf-8?B?WWFMbm4xdGxISzZpb2ZyeGtJbHp4WlFMOEhGNHBmZGw4b2pReTUvbUFkTnZj?=
 =?utf-8?B?VXV5ektjZ0EzcTRhYmk5aGptWEpLQStVS1R6YUZsbHd6R0txWlplL1VQeDNs?=
 =?utf-8?B?VkZvQnh3ZXdlbUhOeXZIbTdiSU5MV0M2SUQ2dEtNdUlwZ0pmZVlDSURpSU40?=
 =?utf-8?B?MkgyVzJ0NE14cXBRcHlUV2I0d1FJM1FLVlpsVks1d3gxT25rZXZaQnBZeGxm?=
 =?utf-8?B?OTJrcmVleWs4K1k3WENsYmVnU2M0WjEvSDFPRHN0aGIvWW1jdFhOZHM2R01Q?=
 =?utf-8?B?dENlSmQ5RHZkRElWQnhmblpRNEdvQnhVVzRJMUw2bjdQdEZSeFJFQkl5dE5a?=
 =?utf-8?B?ZEN0cEtITFdWWHlHQjNrZEU5Wm04SS94Mm42Y2dFSWkyTGFiK3hOaU51Q05t?=
 =?utf-8?B?VWpRRGR4NjlXK1NkNzJoaFZMRzB2NDExZjFUZ1hsKzVoRjVRNDNsT3RuaTYx?=
 =?utf-8?B?dFhhU3pJVzJoU0NwZEE1bE9YLzZQejJJbjRNV29SeFdORHFuZmgvRHZDVzZK?=
 =?utf-8?B?d0xwNElWbnZhVEk1V05sTnh0QVplYUd1eXBtTG92YldHK1JCVEZxZm9kVnB5?=
 =?utf-8?B?NkNZNzNSL2RJV0NGaEZ5V1RoWDJoMzhsRmlwaWh4eHBNRzRZNzNaZVNrL0tx?=
 =?utf-8?Q?hf9x0ocO8izTxVsjyAIPKM81C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54e4c36-fe61-4dc6-d840-08dd48dfae9b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 07:59:30.3557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/4rrcwWF2yVTwFzyZn1QKX1SQyRoZ0IWLcvXiwQBhhfkLF1AgJhnYDeP7c+itKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340

On 07/02/2025 3:32, Jakub Kicinski wrote:
> On Wed, 5 Feb 2025 15:53:39 +0200 Gal Pressman wrote:
>> Add support for a new type of input_xfrm: Symmetric OR-XOR.
>> Symmetric OR-XOR performs hash as follows:
>> (SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)
>>
>> Configuration is done through ethtool -x/X command.
>> For mlx5, the default is already symmetric hash, this patch now exposes
>> this to userspace and allows enabling/disabling of the feature.
> 
> Please add a selftest (hw-only is fine, netdevsim can't do flow
> hashing).

I don't understand the rationale, the new input_xfrm field didn't
deserve a selftest, why does a new value to the field does?

Testing this would require new userspace ethtool (which has not been
submitted yet), I don't think it's wise to implement a test before the
user interface/output is merged.

I assume you want an additional case in rss_ctx.py?

