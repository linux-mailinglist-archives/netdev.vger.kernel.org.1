Return-Path: <netdev+bounces-178513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D26A77694
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92ADD3A35BE
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 08:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D653F1EB197;
	Tue,  1 Apr 2025 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VF/l8VHH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3B1A83E4
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496569; cv=fail; b=AgzdFeUrdUL82KyW+IwuL+4nUmWfiNqz9MCfsvdEjm/RII0vmMZNaL0fSPsI57VZVNbDpjfOFkPOJdXcBiqSzT8mspTOQWoErpba5oqulMxMPDuNjipCyhKlvCRAcJiB8RD4NljjZdFdHKfOq75Vn5p5VhvxXR/BZZI0EmcnNcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496569; c=relaxed/simple;
	bh=QbcvHDRBbtvEbfnKIcjBYXbjqtjhV/VRmWLB4nuODbs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VpuWqTtfdD9sq3i4A2Qi8ZOoejVDQBgbzU/qcgVQOWW3S0tIXrxPSsrmXJbVK8IBpFQr6qRquNsBnJVkluOx5ZnnNpxFNJ1GzSbaFE4hXXOaeGcKVftRqY3KtpOCi0EZFe6JYWIcFJ4C4F7rYCFSYR67SdLdJT3Eje/3eR7O27c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VF/l8VHH; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0uN8vKKwqcRyLRtdz1LsrFTZ/CvX6WSZM/bgTY2Fs/OLja1JVaUbTv3vsu2a6zBY8MirKH1sKXJJ540UPDzvEtLUVyg4qTs4HrNvYpvSnCu+6zR8thWfKFBhQ9R2gnybS77Ca6RosH+KB6LYPHyAKBeT1+mW3ppiMdjdKleAyeZU1OTAKon3h0qo+EkeSlmYqSNk5QQdDTrfXQl935QlUF357MGIQ7J4Cn9uPZ587bzqREatOlBLAgezKSPSdh0Dh2wt0zXi0nK0wHA5B1RuA6yHJttx1eyF0X8IKCvJfz38i0hGS4LJPfWStXnNGPvq+wsg65L0rm9U4X+vyNpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nB45oLIXHOIqmzXyrfuKaNUaAdG6FLzXSlYkGB4KAc=;
 b=Tq1jaKjpPpMIJlkFVTn4OAK7gTtrN4U3bIdlfQqaXC591arXwjhZ9ioTAaKxdpfSXJjJ85eRKaRC/F8FnNPT1afnBurLACRXTgylbiU98rr/PzNSUVwEmsoKcEKg1FsqPqoYKfrh5kNQ4LV01P98chXdYfPPHvMmgYLQFDBeSsDoqiaPYTvZh6fEVYUklqha8ijlkox/ITykGdj5kt1v7+KsEAqIUpF3Q0fUZ5TNwXJIQ4qEK3DccbZXBVHwxVwZLleytAzBSYTg5Eo5RJcSEoiRIkt7xZFeyUU/1o6scixKY+M26CYwjduuXrXQQqSY3WDCEXboDQJUFuKZCms02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nB45oLIXHOIqmzXyrfuKaNUaAdG6FLzXSlYkGB4KAc=;
 b=VF/l8VHHRHv4UdFgv6GLkB0dHU+ukwM8DLSz/yY43pQcGcwxrzMmijbARqnrU5J7y6Ytaw0FeuT+kbuQrDYG4CfnCy2aXUC4s9x84PLGNYrOoplzxuZ91I7h7cjQIY6tAcyoBNW+tEp6ifnZW7JrHolYvSicW26pA9/SSuJpbsCSGDpfb8tvnI0v69vgac0OXEhbXFjhzRsYeLCsm4+eyID9F4B35KHjhAsWK0QAoX9HInwWYALYzi4nhTyMRSBiOJ0GCsJ6ONrNQPS45I0nnuMfcSCMqqxj8HUb2Wq8LRLJBQap9lc00v8/xVz3nMSpcQcFK76PAM2jMx9L4NE5Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.53; Tue, 1 Apr
 2025 08:36:04 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 08:36:04 +0000
Message-ID: <a3e8c008-384f-413e-bfa0-6e4568770213@nvidia.com>
Date: Tue, 1 Apr 2025 11:35:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: net-shapers plan
To: Jakub Kicinski <kuba@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "horms@kernel.org" <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, Leon Romanovsky <leonro@nvidia.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
 <20250328051350.5055efe9@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250328051350.5055efe9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0136.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::15) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 872e40ee-724a-4455-8b44-08dd70f83d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZktjZkZmcFdOV2lFYk1SRkdYbkVqSHdEY0s3ekg3enowS2dxMWdkZE44VXNj?=
 =?utf-8?B?a2ozQ2tpaWlSQlpDTkNteHE5NG9ZOTNUWTIyZXNMWUVNWU1KSHRWazdtajNQ?=
 =?utf-8?B?RDJRaVYvT1Nyc3pRby9Wb0l6UjRGWlhPV0E5ZmZmWFNHanI3YXBjdk12TUw3?=
 =?utf-8?B?Q2FPbXhmdVBNUzh3dHlGUTlqYU9QdVprNS9UT1h0M3E3aVQ5RXp2ckdlNUZZ?=
 =?utf-8?B?cXRhMWNEYVJaWXBTTXRvZW9ZMXRRNHN6UFlEQlJCTHdFWEVJdW45VGdSNFh1?=
 =?utf-8?B?WkY4cS93OUhHcWZWOFdOcGlLUE5TUUNjSGdMU2o1aGxXREdTVExZdDVYb0RO?=
 =?utf-8?B?ZWF3ekFJQ2cxQXh2clFHdXVXWGUyQm42Njc5RmR3SzRIcjdiZGlORHZITkRF?=
 =?utf-8?B?NGhyNG53TXovbGlSMmFFTXNJWHVWQThHcU5PUWVGU01mNmdDQ1hYTFE1S202?=
 =?utf-8?B?NzBQOTBRK01JUC91YUliWGp3aDd1amVVQStiaGQvUFgrRmNsVlY2bWpvRWhE?=
 =?utf-8?B?TExnUHlOTmVHY0hNZCtuSXR1eHE0U1JRZ1pUNkRLR3puZ3BXc0VlckowelBo?=
 =?utf-8?B?U3plUFRheXEwWUdJOEZUeVJpNU1ORGo2MWJUTEtMczdmT2tlVi82L0hER1lS?=
 =?utf-8?B?SThvRmhweTJBaURrZXRMWDBLYVFMdmp6SmhGekxoV1lMaWxBK1IrRXVFaU4x?=
 =?utf-8?B?V1FjdzBXWUpDVWd2T1hvQW5uNUZCVVJYbDJuOSttNEprZHlXSHR5ZE9BckhC?=
 =?utf-8?B?S1VQbTgrNzJwaFhPQUFzYS9SeXF6UGsySkI4NE9XNkpES0NFdlNETXNySUNl?=
 =?utf-8?B?SzVYYXdKaU10NE9odnE3ZkVDdlg0MTRWRFVzeFlTWjN0QzlTTHlaZnRsUnB5?=
 =?utf-8?B?VTFpZ202MXNiMTNEUHNQVFFaQ25ydGlBa2NRN3NqOVFvcTVXaURjZjh0bEJI?=
 =?utf-8?B?QUI5Q1hUdC94ZEtiRDM0bVJLdTM0eERqY2hTZU55cGo2UWloOHB1QU1GTEpB?=
 =?utf-8?B?M2dpbEU5a05kRElYWU5rR3QvY1g3aThxQVIxWU1FSXlkMmRCYXRqcVRjQXJO?=
 =?utf-8?B?bnVzeStVaVMzckhrUDJhcVJiYTdkZXpEdzJRTUp0VWp4N3VxdWU0eEtsUTdH?=
 =?utf-8?B?eFYvM25Pb1hjUkRKU3FHdmJqUlpZcWVkYTN3L0N4ejZiY1d0R0hxSDBINU92?=
 =?utf-8?B?c1RZaWtJcjhMdUhFeGkwRmNLOHIrT1BPRXlyeHZiL2dhQWNNZWdpcURZRlNC?=
 =?utf-8?B?c3Uwb21NR1huVGUvRGpxZ1FMNEZmSlhzRExjZ2xKSXl5SzVxRzJ0c3krZW5m?=
 =?utf-8?B?ZUJ0eW12SEF3dytsUkZXaHY2Z1NjZEFEQkpCR0UvSG9mWVlYdWdTbkhMVk9i?=
 =?utf-8?B?YWxvWDRuM0xLamhwNGRuVTJEaG9KYUl5YlkwK0xFaHlQNzlWNVR2YkYxK3Zu?=
 =?utf-8?B?MTdMNzk1aXlpR0VwYW4zSS9zK2haUkhkOHRUQ2FkdUoyK216Rmd1eUVDekJN?=
 =?utf-8?B?dFRWZDdQZVRTRWMzc3FtTjNGMHFWLzdKcXhNQXhTN2o1WS85SzlaZmFyeWI3?=
 =?utf-8?B?SzJmd0pONTcrSkw3aDFNU3NLdzJZU3NTR2R2UGdZMXIraGtRMzlIS1hQcE8v?=
 =?utf-8?B?ZzdvRWNSdHc2RmY4dnkzOGJrdEdYVk9XVnNuRmZnNjFXQlNRcDFQM1c5cGow?=
 =?utf-8?B?MTYzVTZJcGNvZlVsV0JJaVVMM05QQmt0ZHVhUk1zbXFWb2diM0MrbEZwQU5P?=
 =?utf-8?B?MktPc3UwWDVkV216emhYQ2wwYlExY1U3bXlqNDZWREhENFcwR0lydmxpdTVX?=
 =?utf-8?B?K0NTTnZ6TTFaNWJzbDVXODY4Z1lzcFp5Q0p3SnM1MG1MMTBqcEhNc3JWaWxp?=
 =?utf-8?Q?dzTqrF4bnvus7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDZOVkc1M1AycDJPa2ZueTRJYnpNTkRyaTFMRFhNNitkU2RacGJQUm94Q3Rh?=
 =?utf-8?B?ajF3Q1l6eGppNTY2d1ZXZjZYSzNiMmtWWnl5UVBUNGxzTmVySTNTZEcxSktB?=
 =?utf-8?B?dUJjWHdMNjdwdDlOakdWbktSYUxwck9pcXRKbjlMZUtMQ0Z1NHNNMFpXd09G?=
 =?utf-8?B?Y2hGZTE1THp5UlFPZCtZM1pwdmMrZk81ZzJtdjlBaXQrd2ZIMUtkeWQ1YUM4?=
 =?utf-8?B?cG4xVkJ3cWZDQWYya1RLSGR0bWtvVmJuV1R1U1BTSEZYMCswcUF3TGpFd0xo?=
 =?utf-8?B?TkgxeFpENy8yMVc5T20xNFZEWFQ1Rk1oUlJkRnM3UktyUXl5M1ZXTjBKaVRa?=
 =?utf-8?B?OVZJRUJlVVd0N3lvVzlxLzIwaXpsdG44WkVCSnB2NE9ZQ0U3Ukd3S2FPeHQr?=
 =?utf-8?B?L2E3SGQ0OFFIeXUwa054TGRnVXZkdUFpek10NWl1SDVFbE5BSkJmbjF4Q2tj?=
 =?utf-8?B?eWFnblROS2w3ZWZLNEpMdi9oVDhsc2xtQ0YvY2tIdEZibmlzdjRaZGNiRlBm?=
 =?utf-8?B?dk1TeDFTNHFNUm8rMFNqV3grYlhwWGNINnhkaWUzbDEzTXBXWkJGZVhRb052?=
 =?utf-8?B?U0g2Nm9MR0JtSWllMlNsd3FKbWw0RDJ6V0dTblZ3Q2hUQVFmVzZmM3Vmc3Vl?=
 =?utf-8?B?bFRJMHBOTzBEc3hjeEJhN3lyQnJaZUZlR1NMT2hoTndjT0NNaDkyT3J6SC94?=
 =?utf-8?B?bXR3U2pxaDFiQjF6b3VwTjUzbmJ6QmpzVWd6b3NQa25iVGU4U2FUSGhyUkJ3?=
 =?utf-8?B?NTRMbityRzZtSXNOVnBVYTVBQ3Q3VmtwRmNpd3NsdENhaUZKeXBVbWFlSnEr?=
 =?utf-8?B?RWN4cm5qdWh2b21vYmpvMm0zOWM0cGZNa3RuZ1BBM2VSaGFnaXE5TGxncGdX?=
 =?utf-8?B?WHZ1RGNnWWdzMGFMand5TUZVVHh6VlUzREJNOXZUaFRRcHVyWG1ST20ybFY1?=
 =?utf-8?B?Zm5zY2Rza2x1YUxFcWMwRjIxK1F6bXpCRGc0VW96WHRrNFVac1gza3hFc2pN?=
 =?utf-8?B?ZVdHcjZTaHI5U3I5dWZlUGFYUlErdkQrSHo0T3dLT3c3YzhIV3RFMFZYeGJk?=
 =?utf-8?B?OWVWbjRDdERacHRCUklEbTRKUlNDZEY3UFcvWDZBTitxUEtTWllscW5kenJt?=
 =?utf-8?B?cFJuNVJSV2hZanZKU2IrRUpZL1k4cTBreFVndXpoMy9BTXczQ2pDNjVSS0Qr?=
 =?utf-8?B?b2haTlZuOW9LcmhOQ1lid1plYklERjhvRXJYNG1Zc2tyVHlNU2xhNndhdDA3?=
 =?utf-8?B?bnp6TlM0V2VoaEx6aUo4bXg3N2lDRkNyZVR2a0NUZFVSYy9PVjNONjQwNlRn?=
 =?utf-8?B?YUY3L3FuaVpQdFFhc25UOVAzaFd5OU45STdEcnhudUFxeEdXK1Azd3dZSnBZ?=
 =?utf-8?B?aiszZ1FWZ1NHY2l4VlBHMXRnZ2Nwd0lMdEpJcE1uVE9QSU5QZzhxRCtVd3NN?=
 =?utf-8?B?WWgwSVdWRWgvMmN6L0pxOXhnUDFUVGhoNWNTbHNmMXpVSnpFanZFSURIdzB6?=
 =?utf-8?B?NjdweTBTZFR2TjZ4dVRJRklaZ3RMeHpmZ2w2ZTljSmJwMTEwaDhweUdDNVhR?=
 =?utf-8?B?ZVIrTjVpZ3dXY1o3b2dQRVNwNFA4OXBOa3phdGZOVjZXQUpiQ01SSTZjMXkr?=
 =?utf-8?B?OFh1NTIrTVBiSVd0U2tKK0ZmdFhmMXBrTVdSS2h2K3huTG9Rb2k1S083ekRM?=
 =?utf-8?B?bWY4Y01zcmJXSzd5aHd5dEtWQjVLeEdjV0VWQmk1cWJJMmFGd1QzSmRWc3Nn?=
 =?utf-8?B?N3FqTzF0d3gvWG5pQnhqZXNtcGhGUVFwaUw2NHdLZ1lJMGdyNkFiTjJQREZD?=
 =?utf-8?B?TW9JdDZLVE4xZ2hpOGVDM0svZFVYMUdVMjB0ZnlHWFV1Y0hXc1ZkWjRBS09l?=
 =?utf-8?B?WGFWRlhIZkdHdisxZkgwZXlaTll1S0daL3c5L3NwSWNBQ0xuVXk5bFJLc3lU?=
 =?utf-8?B?Rm1BbWd5OEl1cFMzN3BNVlIvZSs5WkxzNkNlNHVYUHlUMFZMOFRvUkxURVRV?=
 =?utf-8?B?ZFIzUm1GSWQ2SDRYQWxqOC9Xc0pSeWx2UlA1UGxKdG9BclJVM05VOVdMMlBN?=
 =?utf-8?B?NWcyWDRmRXNvUzJlTjEvd0RCU3c1c2dIcUtYcmYrZ3ZROWtQZkVZRVZNU0Vm?=
 =?utf-8?Q?2yH2uY3+OzJ35Vq34vCX1XmJu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872e40ee-724a-4455-8b44-08dd70f83d4b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 08:36:04.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4Jz3eYx08PlFHwNh+yya/1jDs5Z8oy8SCioZIrrLK9SzgUc2pKS+UEi37NISN644vNMvsfO9wfNtos0ts+xyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360



On 28/03/2025 15:13, Jakub Kicinski wrote:
> On Thu, 6 Mar 2025 14:03:54 +0000 Cosmin Ratiu wrote:
>> It is not important which entity (kernel or hw) classifies packets as
>> long as the condition that a given txq only sends traffic for a single
>> traffic class holds.
> 
>> Furthermore, this cannot be done by simply grouping txqs for a given TC
>> with NET_SHAPER_SCOPE_NODE, because the TC for a txq is not always
>> known to the kernel and might only be known to the driver or the NIC.
>> With the new roots, net-shapers can relay the intent to shape traffic
>> for a particular TC to the driver without having knowledge of which
>> txqs service a TC. The association between txqs and TCs they service
>> doesn't need to be known to the kernel.
> 
> As mentioned in Zagreb the part of HW reclassifying traffic does not
> make sense to me. Is this a real user scenario you have or more of
> an attempt to "maximize flexibility"?

I don't believe there's a specific real-world scenario. It's really 
about maximizing flexibility. Essentially, if a user sets things up in a 
less-than-optimal way, the hardware can ensure that traffic is 
classified and managed properly.

Carolina

