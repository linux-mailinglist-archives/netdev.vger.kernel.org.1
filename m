Return-Path: <netdev+bounces-125157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D19596C1CB
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A11F21E71
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA241DB55A;
	Wed,  4 Sep 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ejKF4mZN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96390DDCD
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462557; cv=fail; b=k4/KKO3BrvAWVUnB9DP3W+cFFAgyXBvLn08unmENKx2O8ulZo+kRW1HNaZjTgOpipq5Ra9ok+MCnXetSgMayCTc/41fPlcPLvFot/VWGAnlM4Fnd6Fw+BpKjufsO1I384onuE3/EkcmSQqWOmZdhj1Q18to3vDfmpTTjm5RIR1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462557; c=relaxed/simple;
	bh=U0t0pPjGCW1JYpJDTWB46315NC1cTjUFxfZt7FwW0Jg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F5gz9Vx68TVCq8r753XXkPXyEnVloHu5HBbLp/AUGtdPs/y5FVPfX55dmoBgO/J3VPnwIGCT7o+KGetxC1PgWLSkV52qHG3FK64FxRRNfy28GiKImzawuluzevJA7dTV0tHX7aEX1pe6UjqkefsBQZRL72m9ablChpgVjjG43BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ejKF4mZN; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUeLoe1GYDy67pT/OHAxQPgTIrHIsREsUYwCMLZeMMDoxYTMujjGCSe5MPb6noSE8ZVi6QzmM+Dji83K3byGNaoB5O3JkWk89Q9ZCkvs9HHZvj8d0WwSp/yuTIe/tUCr5W/eeTysV/zoqRabEKtrVfWromAfb25L+mhYZL6Si6sQvUMc6LATfwrzJU76S8GP4FRlLLZ2z2v1eHR7ME1pL6hJwrArIIjaH67hkIcnjeFSjFzYG6KtnMKPirYxIWZIV00wkJzCE6/dfSmUKn28esoFH2ojvTqDWRKBV24/KMxNSUcj6WufdLhGSaLBquh5KM0Mh9z6b5jZ+SuGMwvXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1lVQbIltrTFuhsDSyeRds710Ji5cJBqTspSZinUSGg=;
 b=YorSIY4JX4rMi7n9USQGCXX+OcOmGETXnb4fEakXRMD1YIEgzHXEJGXfxzd/49criWBGS6yuPzFiN4W/QeMSBUC1ewzs3O5VetxiRbvaVSQY+Dht+H+H/CAhnHeA4ivYPpUvQl3nYJlgB4phcKYqFXdf3d8rY06a2jdy7mAOkG+MVNuTgH7gZFFD9QdEWrC4K+64qGnG5qMoxjZfkz7DD4s3m6Q2U83RCIlypcbuiFZSnyuETB+z6w4kdHe3/IQivrSqvafy6TIyijPd020nRfMBKRApnK3v1/mb7bf/wjAJl0sfNi4q97lP+4Tb8WiClhz6D3v/i+k1mf/Kml7RSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1lVQbIltrTFuhsDSyeRds710Ji5cJBqTspSZinUSGg=;
 b=ejKF4mZNFyvwVv7/O2DiC8Sp21Tk5JmMcitzTMFtptGVL8qzat69SLBkoMvobDdCjRb+Jz+nisisU9W3zCO/5uGBHpky9ACfqtk+UUwmvoRLZwQwt3aOWxDZbf2E80Z/FJBxuz8bGnUQ0H9BcvC75BpVVmuK94Gt2/FJYQvCGcebU8/3zF3TNytwMIaUzpTJihSXVySNZWEfky+QSljxUMlH1JynkVYsyGyMmNkwt6QGhk8l6evbDM0ckA4vD+ezrxU4mICUQmD3jnJJs5BsSf+LI4PvBfa6JIOAxxZmlU9Y3Qj3gqRkS0gNsfPL4vQ/E2/TJ0zcmmhuSrMUJqxbKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 15:09:12 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:09:11 +0000
Message-ID: <419f614c-6185-4467-aca0-73cec1f40368@nvidia.com>
Date: Wed, 4 Sep 2024 18:09:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [mlx4] Mellanox ConnectX2 (MHQH29C aka 26428) and module
 diagnostic support (ethtool -m) issues
To: Ido Schimmel <idosch@nvidia.com>, =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?=
 <ole@ans.pl>
Cc: Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
References: <a7904c43-01c7-4f9c-a1f9-e0a7ce2db532@ans.pl>
 <ZthZ-GJkLVQZNdA3@shredder.mtl.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <ZthZ-GJkLVQZNdA3@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P193CA0022.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::27) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d451f7-6220-4f59-387f-08dcccf38835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWJDd2w5b2NpYUIzKzlFeWNCbjNlamNwWEdSb3NBdFFHS0R0a2FtSDcyTS91?=
 =?utf-8?B?aWZEQjJ6Rmo1Skd3WURiTlVHQTJXMktUT05PaU1hUkM5dEtzUzV3Qk9RWDd4?=
 =?utf-8?B?Qm9IeHNaTUJ5UDh4YUI2VVlVQnl0bnEwclRHV0ZJVmhCOThudHhIdjFGSG83?=
 =?utf-8?B?UFJZTWxSa293YWhDWCtVQjlUeDdOcU1OcUU4Z3JOZm4wbDRwUG1ydE1jbFdL?=
 =?utf-8?B?SFhMRExZSjluSkpzQy9MeVRPUkZzU0FqaHJ5NkM3Q1pNZ1hHQ2cxeVN3OFpt?=
 =?utf-8?B?Q00zWE1zeWcxVE8vVEdsTzk0M09FdHY0b0RoejVBYXdMSWdBMU5WZmUwTStQ?=
 =?utf-8?B?d2g5RDN3S0EzRGl1NWI3MnhIYVU3a3c0RSsrWVJYVStQVGtkdFRQWFAwL3dj?=
 =?utf-8?B?SXh6MEloUFJKNFpVRU5hQmE5M3h0bVdJT2h2OXRDUy9FeUpnTi8wZThTdWEr?=
 =?utf-8?B?dVEwdTJJSzdDNzFicjN0dmVyU3dPNnQ4NEt6eDlaV2IwRUJGeVRqckdqUFVh?=
 =?utf-8?B?WXhnMmdCUUNIaU15bEhrL3FxaGlZRDZ1T1pNNWFMMDVjaDd3S2dXdnlOazY4?=
 =?utf-8?B?ZlRqMFVqVjVpK0E4RFhsc2UyTitua1N0SUd6QVdhR1lOQmVEUTVaNHdYSGlW?=
 =?utf-8?B?dXN0L1pUSVdGU1ZmdE9QMXN3ZXR4R2luOWdXWGxOOXYvZ2N0Z3M1NzE4TTYw?=
 =?utf-8?B?N3ZrNVZmOGozNWdxU3ZPMnVpR2c4Qk50L1V2VW1qcTEvV0V1QjR5Y2N1RlZM?=
 =?utf-8?B?U21zQzIrZmFyNDVrVHd2TlNxWXNNL0ZMYXgrdkg3MEZFRlJoUkFWSnQzbGNM?=
 =?utf-8?B?cDgzYlhtYVZFMWdFREgzQk1QUmJVNFN5OXhMZjI3Nm1pcWpWTTFJUnhuWWlh?=
 =?utf-8?B?K00xa3hXTG8vb05keTFyS3RWUVZRc0l6NjF6UmFpcnVuMWhYS3hjMnJ5N2tS?=
 =?utf-8?B?Ry9ENDB4ZUdxTnNGOTRaa2krdGoyQTNabFM1ZkVqQ0lzakJiYTJIanR5ZXcr?=
 =?utf-8?B?dTh1SDd1ZHowQzVUSTRnSC9Da00zZUJjbDdOSUY4NmgvSUNYcDNsSEpPR1Jj?=
 =?utf-8?B?TkhjWmZBQWI2ajNkc1U0Z1psbS9xWHNDVW9zTlpwSllxSFgzWTdYajJCTXpB?=
 =?utf-8?B?SkcwLzRzRDI5ZUFBTFlBWVZPSnd1c3pGWkxBdHNVNThBYmJ2M0FzRkN3dGxk?=
 =?utf-8?B?MlMzS2tWYzY5a1BYTnJrZjVFaEEwRDNSZU5TTWJjdGZmem9ORmRJYkpKa09o?=
 =?utf-8?B?cjg3cG1pTFI0MllRZThuekFCT1FYS3F4S29mL1BpRU1meGh5OGtGUnJuSU1E?=
 =?utf-8?B?bG1LdzVUZW1jeTJnUWI3KzhTVWt2bHpkZGhHL2xhaXE4OFVKNVBuM0RzQks1?=
 =?utf-8?B?VEhYeUxINitwdW8xV29RYU0yN0tyYUZ5SEhTTFBpU2RyOXFhTXc2dFJ6ckdI?=
 =?utf-8?B?WmFxNFlDRVN1azNYWnVyS0QrL0Jva0pSSHhNV0FpYStHZnc2NHRRM2xNd3Fn?=
 =?utf-8?B?RnE0bGFxMHI4YzdlQTFLTlVoZEp1bldqV2tEYzZkL3VHcG1XVHlYcDNhNC82?=
 =?utf-8?B?THBUek5IbTRxVER0NDg2MnQraHpJU0lCNm9pVDZWWW9kV0dNU3RxU1ovYzVw?=
 =?utf-8?B?ZXdvMUZmZ0F2SHEwd0k3Yk1KdlVQVVlRWWJQMDVic1Y2VEY0UVVTc3dobjUy?=
 =?utf-8?B?WDNRSnNPcjNFQWpIMkdUSklSSHpWNEhBbk9iR1RVbzRFR0RZVWg1Um53UWlZ?=
 =?utf-8?B?QVpSRUJtTjR3bDNud1ROb0s2YnFkdFVYMEUxeEdnemV0T1hWNDE5WEY1R255?=
 =?utf-8?B?R1dtQjZhTE9pbW5SUSsydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UklEWStDOUsrakppTU9meVl6ZTN4cXZTdXpFd0VBbVJCd2tzdEdYdk9wc2Ju?=
 =?utf-8?B?TlB1U2xjeC9VNksrTUJpSXJ6Y3VMYWc2VjUxbEJMT25uRWNGbEF2YTRCZU5t?=
 =?utf-8?B?czNSWXBxZXNCRDNRSHBNOG5USU9OWFYxWHdKTTNHOWlVZjNMQXUrN21GYyt0?=
 =?utf-8?B?dGxSdU56S3pqUnlqRlRpRHBpOTdpb1hGSXZGS0JrbTR4ZGN6Y2EyTmkyeFlV?=
 =?utf-8?B?UWZtUGNuNFZ5U05kK2NRYTNteWRPb3FmdEQ4NGtwdGRjeFk0UXc3N3dhVmtu?=
 =?utf-8?B?cGtRWUU5YW1MU1E4ajVnMjhBTkNydGk2Q2M1cG9jYURRSGFlNlNLcTlaQXRU?=
 =?utf-8?B?SVVqdWdQcUNiTVpIZURQWnlHYlBBREMxRDk3UkpCUjlWdkVNWHdWM2lyNDNj?=
 =?utf-8?B?Tmc4YVlrdExvWXB2UTBiM2hZaWN1czNmcDQ4aVBUSmQyZ1dYMEJmM3lTeFgx?=
 =?utf-8?B?TjNRckVuZjNOeFo5bzRrWDNuS29VazVZT2d0RFNOYkZCa1ppVGtpMngySURz?=
 =?utf-8?B?WGh4ZG04QklINTVWSlVXRUVWMXJwYnZxRDc2VEhVL0Fyb2Q4SWltUlpFbW5m?=
 =?utf-8?B?SngvNmk5OXdndGJscXJhejdIbjVkWGFFU2I4T0hoclc2SmtEUXEyaXh6R1Bn?=
 =?utf-8?B?ZnlvUmZqaTVqendHRUl4NENTZWdJRXorRld1VmFsb1VkRHdiYmphYXlXNzJN?=
 =?utf-8?B?ekp0dUVyRWxzdUcwemY4Z0NmbUk1WmUwbUlRN3lVMnYvR1FVdERTMFQ4M3pZ?=
 =?utf-8?B?b0pza3RtcWhER1lySldGRWUwZ093cXVZQVNYd0MraEtIL29SNitMeWpHbTNE?=
 =?utf-8?B?SEZQRlRUQi9GdGZVd0RqMVRxckF4SXZQdUdiSy9wMXhCemxhSzg4YWI4cWJS?=
 =?utf-8?B?MWtoaUZIdzQ3ay93MnVpc1ZQZ0YxVDl1Ulh5enpaUkdHM1VwWUlIS0twQ3I0?=
 =?utf-8?B?T0owcVIwVFRrN2YzNTJKMHBnbGhJd09ZM290bFlOdXpiVUYyanBSVW4rVTA1?=
 =?utf-8?B?R29pd1V4b0x3M2VFVjNxbEpCKzcwT1J3NjFUaldvUWwrMUU3aDc3NWlGVHBQ?=
 =?utf-8?B?OHBrNHhWcnN0N3JYcEhEUElabnBpOEtpeGVwWm5UL2NRV2JXM1RlK0JROVRk?=
 =?utf-8?B?WmlXUCsrV21aSldsZG5GVDhMa1k5V2ZrVGtxWFgrRDZoL2drN2Z4cTVoaHdj?=
 =?utf-8?B?NCtXY3g0cGxCb2xqK0crbHlkeVBoTzJSTm1hTysxN1NkWmxzUU95VUJycDRC?=
 =?utf-8?B?M2U2WGJtUmJxWkZCb1ZsYkgwRjF2Qzl2TzR6aGovV1hrMmxYWHNOVEI3U0p2?=
 =?utf-8?B?SCtaTzU5WTVmOUhDcnZvc2VqL1JPbmxQNXdQZExtSUtlUmtPTmpTeFlEUWEw?=
 =?utf-8?B?SzdkZlhqU0hyY20xdFZxTFRFbkFDOVhLcks1cmVSSUZtei84SE1NV1NwV25r?=
 =?utf-8?B?UWx6Y21yQUZKamt1MDVLclNKSDRkQmtSd2RoOWFlM3lwdnRZMW9POXMxZis2?=
 =?utf-8?B?ZktaZTVjVUZQK2FUeUY4cE1pSDQwVFZIVjVLV1dqWWlwTWdjcDNuQVM4MVlV?=
 =?utf-8?B?UGZoL1dGQ1RUWVlWSGV4N2Zvc1FmLzVVZjNOM2Yxb2ZUR2h5VEI3eWx0ZXhj?=
 =?utf-8?B?M2MzSkFqSE1pbG41S2VUcVRHQ2ZhUExXbDJacktGdHVCWVlZdUdIdDk4NHA1?=
 =?utf-8?B?dGY3YnBuWXJzYmIvYVdsckQ0Mm1IamFnOXhUWjNHaGQ5MnY0UEc4RkFBd1ZU?=
 =?utf-8?B?S2t5TGc1NHl6L0dJUEFIYjBWVmtLRkpzNHp3Zk5SUVlkZ2Q2bGQ1bHNDeUY5?=
 =?utf-8?B?U2QySktlOFp5QThpQ1BON0FFT29oQXd6Z1E2eDZXbStDRytscFRpMVFqdmdv?=
 =?utf-8?B?aFp4U2RxUzVlN1lIbmluakZZU3RXcUhTaHQvN1RhV2I4NTFIdTNlS05meFQx?=
 =?utf-8?B?aGJVREpDVGtxSXVCMGV5ai9paDN0OWw3UG1EZWl2ZVVGL1gyTGlKZUNTV0hv?=
 =?utf-8?B?cFBpeXh2cVp2TmNoamE2Y3hwaUNOYWIwRWU0WHphbG0wVXA4ZCtaenJSSVVD?=
 =?utf-8?B?dzAreWFITk16ZzlWK1FSblhBalgxSXM2Q0dUL2dpNW9BLzN4aTJVWENhMjdt?=
 =?utf-8?Q?M0FCH2PYr2EQcYwaCeQQII1tw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d451f7-6220-4f59-387f-08dcccf38835
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:09:11.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqrfgrjHMVDSxNVSS0G0DmSXMsT96JtWp//n4uNa6vGaEmGqcpv4dVcOYt5slH77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980

On 04/09/2024 16:00, Ido Schimmel wrote:
>> 2. For a QSFP module (which works in CX3/CX3Pro), handling "ethtool -m" seems to be completely broken.
> 
> Given it works with CX3, then the problem is most likely with CX2 HW/FW.
> Gal, can you or someone from the team look into it?

ConnectX-2 is End-of-Life since 2015 and End-of-Service since 2017..

