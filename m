Return-Path: <netdev+bounces-160049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC6AA17F54
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9064A188AE6A
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C401C1F1523;
	Tue, 21 Jan 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nMDo3uH/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F01487F6;
	Tue, 21 Jan 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737468037; cv=fail; b=SNGjHGQ1ZrWNQ7A1959d1qoR45EiZLEUDkCNwtnB4Ss/8vDwGYqWogwRWFf3vBj9yF9/G2APdk0dv7lgWFynQxE1EyPbDOP+brRYwQHvOJsys+Ufw606N2+eKuvcGUJLhTITewTL6o0qQSHkBFl9Wtt91FoFeelVQg5A4v3qYco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737468037; c=relaxed/simple;
	bh=qZYYiTqV5ctLzb9yQq0KqB0w/GUDYztGzlPAzHr+XUo=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=spYfY3mMGe/5gyBgvYDv5pagUTK104sXyUc9yZ9JgeJSJP05Kwijb28pizu61cCKaTWW6Aa71J0y16amnQ0wA9iCH9bWL3XMdjErF8kByC+H2wnSDb3LY4AR0L/xwo0hPZL+gP0pXiB+rr5xIGPk+a+wBtZ9n56vkS9C4BEaPmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nMDo3uH/; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKJZ+efbN4AETZJ3picy60H+oz0QKvIZx41VIj0UpqGLqAeHm3FyV7D5nYfFbENCX0WfrsLGW4449eKXGa0sHG7VptCDFsMHqb+0WdrYpzMlmAr6kscLXzPVIzuy6Ru9hFxZDiewI2/iSaFd43nAq8haaykEGEa6W+BAKUaRUGTdk6Tn5T522VLFXLeE4KeE8NWZ+pdNa9gVkxDVKo32uDeZuAzlItWgtuJB4VTV/C9XbEB5ZVS6Ysk3yn/WI0YypJIrqeltxi9kVdoLZZwmHk62WmeOY2BEeg8oShIXjtkVU9cKTiaVLVJB2hRjqlL79S7iqGqau5k87AwVVygSuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrY3otKO6fASXP/iDhrONafpAZLkgTKy0Rzu0KGurIQ=;
 b=Rl0fMf6TqwtuxV3xmo4K1GRMbhcNkjIbSBbrFuu7fmt+8OA5wogX0EVF++lgZa1hzgDqHGum0Z/808p0mRMF+xMCdsSkOuK986hosiu4zqDnYAehNIVN1XKi0VM0h2r2J0Vj81Znm9J4gsf5zMsjl+coD5mD9zN/KO+wfr8XRf2M+TaBY9ZQhxqM4gbsv2WjjP3qPprGsOKOLJ/pq2gNlSumz7jgALE/+zTpjuG8IZ3FEu0CoboIFWCsIYR3Z0StfLgxzWXRGXvEhDZlZHHNj1EyyLy+AlYZAWkhGU04bSPZA9zPN27mOX4ImKDRB/Fs8wNiBmOU4YeyZcifoox0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrY3otKO6fASXP/iDhrONafpAZLkgTKy0Rzu0KGurIQ=;
 b=nMDo3uH/C/Z49y79ThVUzTBiJBw8SMRzEkPRFQFSDKmmhxgLbBz3hQKW0ryBXGcNvIwJGQXbVjRE4XHmY97jI8CLy7fqYAzgSHDqhdqcQiz0uJ0ymAL81L7uYI3Tqa83v/d8gGYbKKeTPx2ndvak06LOtA7fL6Cf5wExDIX8HBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 14:00:31 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Tue, 21 Jan 2025
 14:00:30 +0000
Message-ID: <d71fd820-5dd8-0010-226e-f8f6b224de1d@amd.com>
Date: Tue, 21 Jan 2025 14:00:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 15/27] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-16-alejandro.lucero-palau@amd.com>
 <678b19bdc3d8d_20fa2944e@dwillia2-xfh.jf.intel.com.notmuch>
 <80dca432-6308-26f5-99c3-47dd15858259@amd.com>
In-Reply-To: <80dca432-6308-26f5-99c3-47dd15858259@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 1108deb3-8cb1-4d59-054a-08dd3a23f76a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzdpd1NkZ0h2aWdjUERQMWNJbUFOSjc5VGVNV0xvRXVVLy9SQW5hTExzd1da?=
 =?utf-8?B?SXRMbThKM2EwemlmUDM0dS94TVJrQ1RLbXdEZ1NTWE5LS1NBOTcwcmlwaVhN?=
 =?utf-8?B?OFk4cnNjWFpoRjlkUXNWYUV0U1loVFFrN2tuaFJ4S0tibjJQT041MnM3VHZn?=
 =?utf-8?B?anBkMW1GYmJnbDV6TzJnMzBpZlkzSGQyZ0xIa2ZITEIwYmpoYVN6K0hPR2hC?=
 =?utf-8?B?L0FYQkt1UWNoZ2ozSE1LTGNBZitwZE9iTTBRZ2c4N2xYWDlmU2NWalFwR2Zz?=
 =?utf-8?B?TUlYa2pQT3J0VjVxUzJyQzlTQ3lKV3hSWm9jK3VpWHVFM2RVV1ZyTHpKWm9E?=
 =?utf-8?B?b2xEVGVKOGNUZUNxREM5T3pTaEZuclZraUZxU2JXSStKZFprYlN1TUp6R2hG?=
 =?utf-8?B?WGM2R2tlNXRsVUZNdzViS3AxTlEyckxVOVl6MjhWdWZvVk5CZUgrbVhaMEJj?=
 =?utf-8?B?anpSWllzQk5hY1ErYlZiNEQ1VGtTbDYvVWNJcDlsTDkzWm1BNnd0ZlpSejEx?=
 =?utf-8?B?cHhReTIwWVphU2s2MHJCWk5vdXB0WTlzd1FEbVZ4dWJ3QUZodU5ReU9FOHBy?=
 =?utf-8?B?YmVJTCtFczdyR0lXZy9ON0xWTGdWc0wxRGh0cW1iUDJnWitJTnhxUEFqeEVy?=
 =?utf-8?B?d2tJU1RmVmJ3c1ZyeUZObFVsZGZ4Zlk5TWRlTEFmOE9zLy9WK1lIaWI0eENU?=
 =?utf-8?B?WUZhSTVEUE9QQnJmb0hJTG5xc3R6S3I4NHdmV2hUeUZ3amJYdlVHczJscVpS?=
 =?utf-8?B?Y1lNRmlQdUZtbno3dUlDUHNwMkYwYTBnZk5yd0hSSjlEdVZlbVlvb0poK0hp?=
 =?utf-8?B?ak8weWdSZXAzTVl2MUJUakZqdkRYb3VSTVZVMGdIdWtNNVZRbC9DenNvU2E2?=
 =?utf-8?B?aVUzYWlKcTRLVU9hNUtIa3RiVWF4RndFeFBGbmlXZk5QaGVhL01KUW9oRDMr?=
 =?utf-8?B?TW1aR1F1VkRqZFdqS1NsMDRsdzg2bS8yMTM5Y1RqUXFRd2s1NG53TGpmcHZi?=
 =?utf-8?B?bDRaNjQyaUlhRmE3bm5kOHJray9JYlBKaGtaUEtUNHl1clJOSGt1MWFtWjgz?=
 =?utf-8?B?aDlSMHE0cXViUU5XdTFpY0VCWncxNnpPMFlIOC80SFNPa29NWGlrNkxHOWx2?=
 =?utf-8?B?Rm9kQ3F6K3daSGJVK2pYcWFLZjVlWVFBVmFsTnVEZjZFY2RzU0dudW03TjVD?=
 =?utf-8?B?eHI4RUZGbi9JMGVSY01WOEhjWHNPUUtRbUdZRVVzaS9QUmN5dkVqbDFsbEtR?=
 =?utf-8?B?Ri83U2hTUktaY0ExOUdjRVRueDZCYXhtLzJVeHN4WXBCYlVFK21aeFhRVW4x?=
 =?utf-8?B?SktiOHltYW4yRXpCc0lnalhxVkJtb2lBdm1OWVZXODdBdlBkSERNaXltNFBy?=
 =?utf-8?B?eHRTUTg3c3pPdTFIL0I4dnZ6UGdzOGpFSk5KZlUreWFkMSt0T2UycVVDTWcw?=
 =?utf-8?B?R0JTbEdlUW53RmdTZyt1T2lRTU95S0pQVktSZm9ncUQ4N1JLb09zd1FmSGFP?=
 =?utf-8?B?SW1jTWRoSkp0WEdheTFOZnl0SnMvYTNMeS9haGd1ZGJZVW1pSkY5RFB5eEl3?=
 =?utf-8?B?U1pOOXVWM0Z6QndhZVZTaGptdEozMnhiV3pMN1dYUDRyKzFZZ2VvZjU3dEFO?=
 =?utf-8?B?RnkreFhFd1Zsc0RQUjUwNStSdmhSSjBkUk1vWG1Pb05IV1R0Ky9FTEcwUnFT?=
 =?utf-8?B?Z3BtRWdTc0pQM3NicjJsNEl3RUs3V2NlZDRta3NRVVFVMS8vbFR4TU42WXZ0?=
 =?utf-8?B?M0U1N2oxT1RvMVhpNTM2aUNxV3BSK0JmQ0VtaXhETmpxYVloNWtKakExeGo5?=
 =?utf-8?B?cnlDUkRuRDcvZVI3SUppU3VROGZ2aEVoU1NhbE5UVUtPVk5iMXpwaEVaL01w?=
 =?utf-8?Q?QwpUm9C87RbWx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXRkdE1zaXFCWkdEcy9ncXdldjExWTFaVXE4d0hNdXljVVRMMDl3UDZONkJB?=
 =?utf-8?B?OEV0OHgySHI0cng1UG9sTmVPUHZYbG5Rd1cwTGRpQXloa1FEZFVqRzdsclRz?=
 =?utf-8?B?NlNVWVFydnhudmgvN25ZT3lobFFkMXRPVXU4R0FLMWQ5WE5ubkJWdjRiNjl0?=
 =?utf-8?B?QytxOCtGVjVyRUU1cVNuM09DbWFncExoUVh0UlJ1cm8vWE5nbnJSWFdscEc0?=
 =?utf-8?B?eUYrNVh3OWtEQWl6WmlwRlpyRWRubE5NajVZNWZjMnpNY2hkc2VySzcrWWNX?=
 =?utf-8?B?d2o5clpKVnlQSmdtZUt6cW5kTkVpRVYrWWEwakdidDFXeEZEOUJncmwxM1JC?=
 =?utf-8?B?VFhEUThRQ0F4Q2hVekpDcEQwQW94MVVvVFNiUHBsS2IvL0xnN1JTRE5keE9y?=
 =?utf-8?B?cWgrYTZIcjBaTm16cXQ1Qm5ZL3hXdDJSeld5L0dRS0VHTmhpMkVyd1g1V21o?=
 =?utf-8?B?bE52cTcyRmw2MGJZNlFEenZ4aGU4ekwzdk5kdXZYZ0g5SzBjeEFHeHlGUlpV?=
 =?utf-8?B?eDlrb2NrUE8vQ1A3aUxXREx2TnhyZGptakZuTkpXWGtNNUkycU5SbHZrUnRo?=
 =?utf-8?B?eUFsQlgwUndzMUlOWnVCejJvMm9Cb1ZyelJQNno4ZnZ2ZHJwSDNURVMvTlB4?=
 =?utf-8?B?SjZoT1QrRENBWVhROGxnSDRDYzVjcmhoaVYxVHZmdmVBOGdHOGFUaEw3YVZM?=
 =?utf-8?B?NXpqdjIvdjJhYWZOVjdFc2JCQWFpVDVEZzlKaHd5YzZQWDBsRU94Uk9IaS9y?=
 =?utf-8?B?M1R3a0N1SzdhUGljVTF1VFVsb25xTTJSOFptcXpqL2RjcVJtd0NhY2M1OFdD?=
 =?utf-8?B?eEVIQnF2U3BEMUhxTXVoNEgrT1NFa0VjVnFZRnNQRmovY0pZMitwd24wTmEr?=
 =?utf-8?B?RzlpMkMyQ3ZYWUg1RWZzZGRMa2haTWFOdXR3R0dGdUpkNi9YVms3bWZGR2ZW?=
 =?utf-8?B?WG43WlZ5dFZZTGdVRzAvaFoveCttaGxaRnZrbWFqOXBZRmtCTVNrMnkyZ1NH?=
 =?utf-8?B?RzNtTWowaFVuamZ1eUFzalR2cDZTZnovZHVoRTVtRTFmTTEzdFNVc3VnN25z?=
 =?utf-8?B?dWszRm4xaGthZ2VoVWpwSU9IeFkxUUNhTnAyNmI0TXR6THA2YVBaZDQxY1RO?=
 =?utf-8?B?QWNpYXB5dUF2cUpBNWpjSVhFRzhPWUwvQk4zNnRCVElYb1ZLbjhFb1huQ25o?=
 =?utf-8?B?OHdPS21uQ0wrVHJKVnllbm01d3VlSVVieG1rYTlxNDVpQkhqdUNJZ1VGK1Bx?=
 =?utf-8?B?SW15emJGUUNHaXNFZTFuKzh6VHpBeDIvM0tOM2JIVkN4RzlDUXVzWnEydmE3?=
 =?utf-8?B?NjRsdzJxejJWYmFOODRjeXJYTmpNdi82TzlVKzRoU1JtL002WUxqMG4xbWRP?=
 =?utf-8?B?TkV4VDZlS3BGZXZ4aXEyV2ZKa0NOUXp5bGJldi9nSlQzdk1MQTNIN01QT0g1?=
 =?utf-8?B?a2JnSHFGMUtZTkhBdXBTTzVQaGQrN29rc1ZtZWdXR3Brald0YVlhYlFUazlC?=
 =?utf-8?B?bFBwUVVLT1NmZ3NCYWE5bGFCVEZWNGJialV2ZUI5elhwOERjMHd1a1gvOE5J?=
 =?utf-8?B?N2NzVm03NnpOSjBaQW1oY1dIc3ptSGg4cHEzejRYUzlYU2k5dWxpbko4NlNE?=
 =?utf-8?B?ei9VUFRqbGRTNllNRExaVEMzelZKK1NwYU9FU0J3NjN6S2V2dTViOGJMb203?=
 =?utf-8?B?ekZYU3JqdVdnYWY2dzI3UXpLNDIxWnNNdytrSkdleHBaaGIxU3MrTjh6VStZ?=
 =?utf-8?B?bTJiUzZwNmsrT20xNWFGekp5TU9lZmVWNk1CWFFUeUxhcHk0elBGK0U4L21w?=
 =?utf-8?B?eGQ5ajFsai9PbFVJdmRjWlpMdzBaQWNSSHdKMVd1K2FVQ0d5ZVJRTnlRZFlE?=
 =?utf-8?B?OW83WEVzSUc2cjdZYXZFVEh1Qm5UbkRWa1JERGMxWnNrNkx2WWdlS0M3aW5U?=
 =?utf-8?B?K1lQQlkxU2RxaTUxQzY4Y1BqRDBmM3FtbDZPR2NJV0lSdVBnNTBjWjNXdUZC?=
 =?utf-8?B?NnpkZFZRa1l1Snp3TityNllaREtCVENiOE9jZER0Rnd6T0tNYTFkVzBSOCtr?=
 =?utf-8?B?K3BNNm1YOVVuc2dCUDBuQkQvR3hDQWt2NGpSSXBRV2VpSkhaU2xUeXdBNDVt?=
 =?utf-8?Q?qtuAXBx7N6L8ByMsSEqZzPTIS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1108deb3-8cb1-4d59-054a-08dd3a23f76a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 14:00:30.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BDVLszKhePLwddInMU9cBD4p8POft3VMqhfsoeYDHtKNhj8pgB8q8QDMwlmDFR7gc5DSG09Xj2yl73tttpJYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456


On 1/20/25 18:16, Alejandro Lucero Palau wrote:
>
> On 1/18/25 03:02, Dan Williams wrote:
>> alejandro.lucero-palau@ wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> CXL region creation involves allocating capacity from device DPA
>>> (device-physical-address space) and assigning it to decode a given HPA
>>> (host-physical-address space). Before determining how much DPA to
>>> allocate the amount of available HPA must be determined. Also, not all
>>> HPA is created equal, some specifically targets RAM, some target PMEM,
>>> some is prepared for device-memory flows like HDM-D and HDM-DB, and 
>>> some
>>> is host-only (HDM-H).
>>>
>>> Wrap all of those concerns into an API that retrieves a root decoder
>>> (platform CXL window) that fits the specified constraints and the
>>> capacity available for a new region.
>>>
>>> Based on 
>>> https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>> What needed changing such that you could not use the patch verbatim?
>> Then I can focus on that, although I am also critical of code I wrote
>> (like the DPA layout mess).
>
>
> One thing modified is related to that ugly double lock you found out 
> below.
>
> I do not remember what was the problem but the original code using 
> sequential locks did not work for me.
>
> More about this later.
>
>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Include Signed-off-by: whenever including Co-developed-by
>
>
> I'll do but it is weird. I think, at least in this case where the 
> co-development means different times and not close cooperation, you 
> should add it explicitly.
>
>
>>
>>> ---
>>>   drivers/cxl/core/region.c | 155 
>>> ++++++++++++++++++++++++++++++++++++++
>>>   drivers/cxl/cxl.h         |   3 +
>>>   include/cxl/cxl.h         |   8 ++
>>>   3 files changed, 166 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 967132b49832..239fe49bf6a6 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -687,6 +687,161 @@ static int free_hpa(struct cxl_region *cxlr)
>>>       return 0;
>>>   }
>>>   +struct cxlrd_max_context {
>>> +    struct device *host_bridge;
>>> +    unsigned long flags;
>>> +    resource_size_t max_hpa;
>>> +    struct cxl_root_decoder *cxlrd;
>>> +};
>>> +
>>> +static int find_max_hpa(struct device *dev, void *data)
>>> +{
>>> +    struct cxlrd_max_context *ctx = data;
>>> +    struct cxl_switch_decoder *cxlsd;
>>> +    struct cxl_root_decoder *cxlrd;
>>> +    struct resource *res, *prev;
>>> +    struct cxl_decoder *cxld;
>>> +    resource_size_t max;
>>> +
>>> +    if (!is_root_decoder(dev))
>>> +        return 0;
>>> +
>>> +    cxlrd = to_cxl_root_decoder(dev);
>>> +    cxlsd = &cxlrd->cxlsd;
>>> +    cxld = &cxlsd->cxld;
>>> +    if ((cxld->flags & ctx->flags) != ctx->flags) {
>>> +        dev_dbg(dev, "%s, flags not matching: %08lx vs %08lx\n",
>>> +            __func__, cxld->flags, ctx->flags);
>>> +        return 0;
>>> +    }
>>> +
>>> +    /*
>>> +     * The CXL specs do not forbid an accelerator being part of an
>>> +     * interleaved HPA range, but it is unlikely and because it 
>>> simplifies
>>> +     * the code, don´t allow it.
>>> +     */
>>> +    if (cxld->interleave_ways != 1) {
>>> +        dev_dbg(dev, "interleave_ways not matching\n");
>>> +        return 0;
>>> +    }
>> Why does the core need to carry this quirk? If an accelerator does not
>> want to support interleaving then just don't ask for interleaved
>> capacity?
>>
>
> I think it was suggested as a simplification for initial Type2 support.
>
>
>>> +
>>> +    guard(rwsem_read)(&cxl_region_rwsem);
>> See below...
>>
>>> +    if (ctx->host_bridge != cxlsd->target[0]->dport_dev) {
>>> +        dev_dbg(dev, "host bridge does not match\n");
>>> +        return 0;
>>> +    }
>>> +
>>> +    /*
>>> +     * Walk the root decoder resource range relying on 
>>> cxl_region_rwsem to
>>> +     * preclude sibling arrival/departure and find the largest free 
>>> space
>>> +     * gap.
>>> +     */
>>> +    lockdep_assert_held_read(&cxl_region_rwsem);
>> The lock was just acquired a few lines up, no need for extra lockdep
>> assertion paranoia. However, I think the lock belongs outside of this
>> function otherwise the iterator of region is racing region creation.
>> However2, cxl_get_hpa_freespace() is already holding the lock!
>
>
> You are right and  this is so obviously wrong ...
>
> I think the problem is the adaptation of that initial patch with the 
> seqlocks, and I ended up mixing things here.
>
> I'll try to figure out why I had to adapt it and if I mistook the lock 
> to use.
>
>

After looking at the original code, the problem was the locking you used 
had to change since the target_lock field inside cxl_switch_decoder was 
removed after your patch before the time I took it over.


I did look at where a cxl_switch_decoder could be modified and I 
realized (guessing because I have not studied this in detail now) it 
could be enough grabbing the cxl_region_rwsem lock instead.

So I ended up adding that line for the locking without realizing it was 
already taken by the caller function.

The code morphed, because it was suggested current Type2 support should 
not support interleaving, for simplicity and because the use case did 
not require it, but the lock remained as the access to the 
cxl_switch_decoder linked to the endpoint is still there, although more 
simpler, and as a sanity check.


If we keep the simpler approach by now about forgetting interleaving, 
that code can just be dropped. If interleaving is a must, what I think 
it is not at this point, I should work on this asap.


>>
>> So, I am not sure this code path has ever been tested as lockdep should
>> complain about the double acquisition.
>
>
> Oddly enough, it has been tested with two different drivers and with 
> the kernel configuring lockdep.
>
> It is worth to investigate ...
>

Confirmed the double lock is not an issue. Maybe the code hidden in 
those macros is checking if the current caller is the same one that the 
current owner of the lock. I will check that or investigate further.

Thank you


>
>>
>>> +    max = 0;
>>> +    res = cxlrd->res->child;
>>> +
>>> +    /* With no resource child the whole parent resource is 
>>> available */
>>> +    if (!res)
>>> +        max = resource_size(cxlrd->res);
>>> +    else
>>> +        max = 0;
>>> +
>>> +    for (prev = NULL; res; prev = res, res = res->sibling) {
>>> +        struct resource *next = res->sibling;
>>> +        resource_size_t free = 0;
>>> +
>>> +        /*
>>> +         * Sanity check for preventing arithmetic problems below as a
>>> +         * resource with size 0 could imply using the end field below
>>> +         * when set to unsigned zero - 1 or all f in hex.
>>> +         */
>>> +        if (prev && !resource_size(prev))
>>> +            continue;
>>> +
>>> +        if (!prev && res->start > cxlrd->res->start) {
>>> +            free = res->start - cxlrd->res->start;
>>> +            max = max(free, max);
>>> +        }
>>> +        if (prev && res->start > prev->end + 1) {
>>> +            free = res->start - prev->end + 1;
>>> +            max = max(free, max);
>>> +        }
>>> +        if (next && res->end + 1 < next->start) {
>>> +            free = next->start - res->end + 1;
>>> +            max = max(free, max);
>>> +        }
>>> +        if (!next && res->end + 1 < cxlrd->res->end + 1) {
>>> +            free = cxlrd->res->end + 1 - res->end + 1;
>>> +            max = max(free, max);
>>> +        }
>>> +    }
>>> +
>>> +    dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", 
>>> &max);
>>> +    if (max > ctx->max_hpa) {
>>> +        if (ctx->cxlrd)
>>> +            put_device(CXLRD_DEV(ctx->cxlrd));
>> What drove capitalizing "cxlrd_dev"?
>>
>>> +        get_device(CXLRD_DEV(cxlrd));
>>> +        ctx->cxlrd = cxlrd;
>>> +        ctx->max_hpa = max;
>>> +        dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n",
>>> +            &max);
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>>> + * cxl_get_hpa_freespace - find a root decoder with free capacity 
>>> per constraints
>>> + * @cxlmd: the CXL memory device with an endpoint that is mapped by 
>>> the returned
>>> + *        decoder
>>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H 
>>> vs HDM-D[B]
>>> + * @max_avail_contig: output parameter of max contiguous bytes 
>>> available in the
>>> + *              returned decoder
>>> + *
>>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes 
>>> available given
>>> + * in (@max_avail_contig))' is a point in time snapshot. If by the 
>>> time the
>>> + * caller goes to use this root decoder's capacity the capacity is 
>>> reduced then
>>> + * caller needs to loop and retry.
>>> + *
>>> + * The returned root decoder has an elevated reference count that 
>>> needs to be
>>> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
>>> + * cxl_{acquire,release}_endpoint(), that ensures removal of the 
>>> root decoder
>>> + * does not race.
>>> + */
>>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev 
>>> *cxlmd,
>>> +                           unsigned long flags,
>>> +                           resource_size_t *max_avail_contig)
>> I don't understand the rationale throwing away the ability to search
>> root decoders by additional constraints.
>
>
> Not sure I follow you here. I think the constraints, set by the 
> caller, is something to check for sure.
>
>
>>> +{
>>> +    struct cxl_port *endpoint = cxlmd->endpoint;
>>> +    struct cxlrd_max_context ctx = {
>>> +        .host_bridge = endpoint->host_bridge,
>>> +        .flags = flags,
>>> +    };
>>> +    struct cxl_port *root_port;
>>> +    struct cxl_root *root __free(put_cxl_root) = 
>>> find_cxl_root(endpoint);
>>> +
>>> +    if (!is_cxl_endpoint(endpoint)) {
>>> +        dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
>>> +        return ERR_PTR(-EINVAL);
>>> +    }
>>> +
>>> +    if (!root) {
>>> +        dev_dbg(&endpoint->dev, "endpoint can not be related to a 
>>> root port\n");
>>> +        return ERR_PTR(-ENXIO);
>>> +    }
>>> +
>>> +    root_port = &root->port;
>>> +    down_read(&cxl_region_rwsem);
>>> +    device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>>> +    up_read(&cxl_region_rwsem);
>>> +
>>> +    if (!ctx.cxlrd)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    *max_avail_contig = ctx.max_hpa;
>>> +    return ctx.cxlrd;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
>> Lets just do EXPORT_SYMBOL_GPL() for any API that an accelerator would
>> use. The symbol namespace was more for warning about potential semantic
>> shortcuts and liberties taken by drivers/cxl/ modules talking to each
>> other. Anything that is exported for outside of drivers/cxl/ usage
>> should not take those liberties.
>
>
> OK
>
>
>>
>>> +
>>>   static ssize_t size_store(struct device *dev, struct 
>>> device_attribute *attr,
>>>                 const char *buf, size_t len)
>>>   {
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index a662b1b88408..efdd4627b774 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -785,6 +785,9 @@ static inline void 
>>> cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>>   struct cxl_decoder *to_cxl_decoder(struct device *dev);
>>>   struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>>> +
>>> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
>> ...oh, it's a macro now for some reason.
>>
>>> +
>>>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device 
>>> *dev);
>>>   bool is_root_decoder(struct device *dev);
>>>   bool is_switch_decoder(struct device *dev);
>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>> index f7ce683465f0..4a8434a2b5da 100644
>>> --- a/include/cxl/cxl.h
>>> +++ b/include/cxl/cxl.h
>>> @@ -6,6 +6,10 @@
>>>     #include <linux/ioport.h>
>>>   +#define CXL_DECODER_F_RAM   BIT(0)
>>> +#define CXL_DECODER_F_PMEM  BIT(1)
>>> +#define CXL_DECODER_F_TYPE2 BIT(2)
>>> +
>>>   enum cxl_resource {
>>>       CXL_RES_DPA,
>>>       CXL_RES_RAM,
>>> @@ -50,4 +54,8 @@ int cxl_release_resource(struct cxl_dev_state 
>>> *cxlds, enum cxl_resource type);
>>>   void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>>                          struct cxl_dev_state *cxlds);
>>> +struct cxl_port;
>>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev 
>>> *cxlmd,
>>> +                           unsigned long flags,
>>> +                           resource_size_t *max);
>> The name does not track for me, because nothing is acquired in this
>> function. It just surveys for a root decoder that meets the constraints.
>> It is possible that by the time the caller turns around to use that
>> freespace something else already grabbed it.
>
>
> I'll think in a better name.
>
> Thanks!
>
>

