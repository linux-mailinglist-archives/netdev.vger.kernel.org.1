Return-Path: <netdev+bounces-152702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBAA9F5700
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 20:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64308188F727
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F36C1F8F10;
	Tue, 17 Dec 2024 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MI1WWu/H"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC41F76BC;
	Tue, 17 Dec 2024 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464441; cv=fail; b=HAVOwU0Bm8CWet8uq6Twnu0UiozsNuSk3R1shRiy/aCMosiGr96ARJN6AHVInj51SHaVDtWz/Qe2CWrgEl35OtDOME2we04nHaWIIKFAoDR37npOEZlptl8aYsjvL3q5MNkEfTRXrBIqBYSNUdw2VZ1yll5ZXPeeNryNOdS7apQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464441; c=relaxed/simple;
	bh=ouUrlCcQZfazy7hpaf3StTtuhK3+T3Qy2l9TxE9BuRc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M7S06x+gW86qJLNvo4mGgJEtCE2MOTouv3mtaJ5afxmhvlMo+mM5sTwHl271HqZ1HHUZ6IZHLj8KxcEzftEP4fRDNiAopB8LwqtOoQ8d+ViBtnZNIQocjhbPmJCRedocM0J7zQ2fSbsHWDL/co3VQkqbyEP2fZGf2Di/rfUt+QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MI1WWu/H; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ff6BJ+sIdzSs4nt+/M5f1BB1kjnlyXShT3BACIefm1kP9/j9eNNT+VUzcxceUl9ojwsrsg4lSW5R5D1IS28+z7r/U0GxYtcf3WnHH2n2Zwk8K5JNNrHNCYPGftpk1iUUobbhF9AqD003ugzQpsKU30XZ4kmC+EgbpWVslxg4aL7V9gDK1IQS6+mmGLuJy4RHc5iXIAmhOHVBqAK7p59vW01zf8Nme+6G8Tx9+bTr+aLsXuhauF8l/Gp1X5cBftfiJV0hz8goKR9C0YdwxRbhI2untPJyPXrp9XXCX6fckmStMQGnT7rH0UfkJl6Dfzdu3dSe+jKUgk4AL7jGmcQwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QC31vv0dTu7FMTucGa4wPXOLFg+VvbTqTtCkkC6LI9g=;
 b=kw5tC1FMoZvcho0kVjbGdHe+ipnYBYhVaioXVrbK8Vl6vYfkGFasSdbJF/fkpKuvhA9AwprSYihsmFkSlBEOgHTHjXlnjDP7SaWM4PkdSoJDJUBERX63M/961J7GY6pEgAB7Kn/4wLY03t1V5zPWjDMvPq0vX0fgi2Vuh77Xwtmq88qo9GmzGomtNgmeOXPGYxtdQ83sWv8p1Yl97OYRMYw/4mWsSNuPtX/1YpEdVxrpKFr7jUvwxa8YughgdiqgBbc+Xy6KiFUeTpgOpSnSRTdtZw3qJLWisH9yhgC3rdxcwQIxSVWhIxMRlX0RAuGXWN3w7tlNmr9NRuSrEOXBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC31vv0dTu7FMTucGa4wPXOLFg+VvbTqTtCkkC6LI9g=;
 b=MI1WWu/HIiQ345NjSx4u+0xPxuPaPWyYhZYIKIQKGMopIYR8p0tiN7v7EqAtnd8ElCeW9PVY+BXYqAPS4Sct4AWaMItxDybmUwIXXJvAYIgpTcqSfiGFp+lDE9d8kzKslC1gwNrYdz8FtkPv6rJUUu8OMHqkCM+BUSDd4ZJ4FNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Tue, 17 Dec 2024 19:40:38 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 19:40:38 +0000
Message-ID: <300df37e-7e26-4ba0-b93a-14fc8bbb974d@amd.com>
Date: Tue, 17 Dec 2024 11:40:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/5] net: Document netmem driver support
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241211212033.1684197-1-almasrymina@google.com>
 <20241211212033.1684197-6-almasrymina@google.com>
 <b706bede-3ca0-4011-8b42-a47e3d3fa418@amd.com>
 <CAHS8izMw4m7Bv5zD2eT2MwFzk0QGFx1gkPu6wig7Uk__tpjW9g@mail.gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <CAHS8izMw4m7Bv5zD2eT2MwFzk0QGFx1gkPu6wig7Uk__tpjW9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::8) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: c694c861-2be4-4cc7-b09a-08dd1ed2aeb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUVwT2ZaWlNJMGZYSU9tWmd1QUlQSi9lNVpCeGtjQzVnRXhaU1pVV3l2NmlS?=
 =?utf-8?B?ci9kcmRPNXoxRmVTb1Vha2kwWlhodHhTRXhzcURXNjNBSlpEZUo4OTBIenY1?=
 =?utf-8?B?ZmN2dXVQR0lDcE91dXVaLzMrc3lrQWR0N3B4ZGFZRkQwSlBzZVhuTjVId2c4?=
 =?utf-8?B?THh0cjBWTmdYZVVKdEdnWTlKUjUxUWlhTWNQejRzWGg2OU10dGIvc1A5SDly?=
 =?utf-8?B?Vk9pVEpDWTF1RlpRbU9GMFAvbmtqeHZuSjRObTIrSTZGM1RReWJhNE9yQVkz?=
 =?utf-8?B?ZmUrald2elpNeHRzWUNHMTMxVHRPLzJzd0xBbUhkazdORzVMVFdkTFlqSUdw?=
 =?utf-8?B?cW0yUVRjczhaQk9LL0lwZXRJTlgzMlhwVG4rbmVodVdrd1BoQldPbTlVT0dk?=
 =?utf-8?B?ei9VM09IUXZJTU45VERhamRXNnNmQy9ITUY5MG1JTG0wR0tlUU9IaGYyZ0JI?=
 =?utf-8?B?VTB5S1NRVmt4bnpJb0w2emlBdHBFV0NpRTFjZmNBU1VOYlBiNldPejVVUk8v?=
 =?utf-8?B?cnZUM2NHYlZuY3hteTVHVVREYzRJYjNRQTd2MTl0TnlNeDc0bnRnYjZaandT?=
 =?utf-8?B?MzUweG1tZTJucGZQc2d6d3czOUNtSHM2aC9ZZ3pTZFFCL1BXNTlXWHdIZHV4?=
 =?utf-8?B?R0d5UHQ5TEZJU2tYWkZQazBPTFd1NC9saWRQaGovc1lHYUV0UmVhcWJjSDRj?=
 =?utf-8?B?U1M2eEIyN3MzVWh6RlZqcDlpN0NXZ3lhMXcvS29xUnQxNTk5U1VvdVVKcklo?=
 =?utf-8?B?cS9ka0tHZUJ0dnl2K1B6cnA0YkVpT2FHVkNQTkcxSy9KeFkwY09nYWZqb1Bn?=
 =?utf-8?B?NXQ5eHdSbVVKdUhDUHJZT05Wb2tTZVdEeFV3Vk9rb05nWVVCMzNZdVRnTFE2?=
 =?utf-8?B?K1RqT3BWTkZTZlBuZlBsLytQSGhiS3VGMjljU1J0dHFHQVF6ZzZJYXNROE5S?=
 =?utf-8?B?UDFSdHVpaG5LUEVBcEc5UFNzY1JoYjdNamlnT1VtVEtTUlM3UFRhdERZK1N3?=
 =?utf-8?B?Ry9zaEhYRFYxMWxtcFY0QUM4T2gxMEg1ZnJVQ1k2ZDlkL2hpVVhET1ptUEJn?=
 =?utf-8?B?SitPQzZVWmUzbkxCNVRxZy9TMHMyV1pqMFkvTFpqMnphTGRPVWpDZ21CNzEx?=
 =?utf-8?B?Qk9JSzFBak85aWNud0NjS1FGL01xbDIzV1lualdmNGtYWTk2SHhtS0gzSjNz?=
 =?utf-8?B?bFlnNXdWeHdsU1plNTI1L1dqQWowcG9zdXUwTHBXSXI2anBtTkRtaU13T1JO?=
 =?utf-8?B?dFZyNTUyT2JqS2Z2RC94ZE5aamQ3aVpiNDRTMG9wZUxTWkNZL2ZQYW9hTFll?=
 =?utf-8?B?K0NabWdVK0FBdWpqYWMxYTgwQVBoRWlUaXhKbncrTDhoL0xJMzE5bzd0Ukoz?=
 =?utf-8?B?SWNOUURYUkRqSDdtbUZQcWhyUllXRkI1YVZqUkRsRnR2eWxYZjloZFM0QnUy?=
 =?utf-8?B?NWxVSkZIWUFMWWZCc1BMbmhQK3lpdmMxMEpycUdHR1ZEV0FmdzkzVDMvWWxh?=
 =?utf-8?B?Z2JyU1ZTcGpVUUhGMC81aEpzSFBqc3YxSVdqVW41N1o2NStzM3J4OHZhMVJu?=
 =?utf-8?B?K3NlMU0wWW1MUHJiUGVhSFZLNmdzMHo5enJHVHNwc3ZQNzlURUQrVERoTkp3?=
 =?utf-8?B?a3BWSE5McndwL2gxNkNIcmRiVHlDNFpNcDBaclE3YTFoM2Yram1vM2cwUVdD?=
 =?utf-8?B?amgra0dYVUpML0g0VUM4Y1N0U2h3S1ZQYXBZOW1mYlJPV09LUmtpczRFUVl1?=
 =?utf-8?B?SzNFWkhCdU9BU2E1SjBHRm5zZnpQMU5ldHdqTVlPbCtuY2VMc1ZKVlhDd0hz?=
 =?utf-8?B?Vk9UUVhVT0pvYXpiUTNUZjFtTzRSTGN0anp1R1pIaUFDZWNsdWdmYm1yV2Yw?=
 =?utf-8?Q?WorKPr60+uRyY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXgzU1VpcXJSUGk2UVZHeS9STGVnenMrcmh1TUw4QTh1ZzU1MXptSGtSaU5N?=
 =?utf-8?B?YVVETUx4b1VlUWo0NDZPci9iczF2ZGlEMGhyUHByVm4vYVJIWm5HNlZIYTFs?=
 =?utf-8?B?c1IxQ0tXNEJkN1UxVnJXaGR0Titwck1nOG1CRy9FbHVJbEJWY1ZGRUlMb3po?=
 =?utf-8?B?Mm1ublk1elNuRWJlbGc2Y0RXSzlxL2NVbVJ1NFpTK0Z0dC9uQ1VrTjk5Q3pB?=
 =?utf-8?B?TG5abDdmMG9mRkJYOUJkY2NyVDNTM2dKa1I3TlpkS1pHbENYOGRva2NhOTlD?=
 =?utf-8?B?bHhzZTlmOUhZM3hqYXZSNWIxRDYwZDZpVGhvT0NtZVVoVVhSM01XTnBPTHRQ?=
 =?utf-8?B?WUQvQmJYYWtlL1ZubDhPcWlDMmk1WCtObkd3L1BIUUx3WjRZdmxxQmZNR0w4?=
 =?utf-8?B?SXBQdUhWWWVPc28rbTFBYVdjVEhHUjVIYUlLSjZNRnQvbWxEbVdDM2lkRFVa?=
 =?utf-8?B?RVozVGtZN0NuaGpBcEJGc1JUeVlPa20zVE1uT2ZuaXhQM1kyRUszUkhJeHRE?=
 =?utf-8?B?V2xoT3FBTGRodVpvdEdRMGZWQnBGdnNQaWdxTFdFUjF1eFBuK3VtNEkvQTh5?=
 =?utf-8?B?b1BLeVlnaWx0RzhFNWF0Slo5TjM1bDA5d3p5bDZpbkRYMndySHJ4R3piVDRF?=
 =?utf-8?B?SXI0VXMxbjZacitCZjFQZFJCRVFkb2ltNWFRenYxa09peGRscWZid3FQcUs5?=
 =?utf-8?B?M0ZqakNkUXNWdGZKNjNsREQ5cjdsMS84MlczSHRRNTNHQ1lnV0hsNGZ1R3N0?=
 =?utf-8?B?MFN4Sm9yTTJKVENxSWNuS1ROelJyRmRNUVVBYUZSMlBkMXdIVVhtVjFDOE9I?=
 =?utf-8?B?dkJtTXhZNXdEeFpOczVtR0VrN0tyc0xhakZ0Y2o0d3J0MHk3L25TYnRKaHFs?=
 =?utf-8?B?aEQyeHE4OG54Y2M3Yi9INzJwQXBxQ2p5SE1PUjJ2cXI5OWt1cnlNY2tjZ3Iz?=
 =?utf-8?B?VXdmNkNOQVBZY2hpYi9FTTM1T2g3WkFXVGpMcHpPRmJ0b09HcDdla2ZzSXVn?=
 =?utf-8?B?UGZaUnB3YlRrMGxTL0FvSnJCbkhkbDk1MjVuQzhzbkFBSUdnTU9oQ3ZzQ2tl?=
 =?utf-8?B?cWZBa25OWDVlMWtHa0ZFYWp0dlBiMXc3NE5SREwzT01xMFhFL1ptNldncm5m?=
 =?utf-8?B?QmV2YVN6TmpHdlMxUm1FUUh4aEc3a1MwdWI3NTBmQVZybFRVRW9rU2VVczRH?=
 =?utf-8?B?em54bkdBdUFxbXhCbG44Y2dyYllzdHpYZ2x3QVo2dTVyRjNqUHREalNTY0RW?=
 =?utf-8?B?RWQ4KzZJV2hIUXdBS1JvdGhsSGhsMVFWNldOcis4Yi9PeDVpYnRsaUlVU1ZJ?=
 =?utf-8?B?bDB1cUd5VWkyVjBCVFRoTDdOS0NZd2J3NGpXS0h4dFZLWS9UY0lwZ29VUXZ4?=
 =?utf-8?B?WXdUSEtzaUY0QnFpU2FBNkpkRTRMZzZLdkt2bUh0TWhOMUhKLzUvQi9ZWUNX?=
 =?utf-8?B?Q05EeCtVTklhd3dUbHJJRU5lY3BtZElCczF3cUwxSi8rY29pd1oyVWNPWmhj?=
 =?utf-8?B?QzRyTnNRUHE5VStzMTZYUHpGaDhOb3lnYjVpSXNMTVNFL1R4Unpyb0VEUXhF?=
 =?utf-8?B?YmRYeU9ieERMeGh4MHFoUHIvYkl0L2Zab2ZYdmtRWmEza1ZLZSsxMkdObW02?=
 =?utf-8?B?Q1l6WTdmNzJhSE9WOU5nS3Z6Qm54bk9MQUF2Sy95VUFNTi9nN29JbkpudmNz?=
 =?utf-8?B?c0FxckVvWFZEeXcwVjZtWkNUYm9hZlFZQlBZQ1pocjNHTU9OR01UV0h3eTJB?=
 =?utf-8?B?Z1lVb05mYmFHWGV2VVF3b3pQbVdzaGh6QlZyR2g0MXNuWFJETHNpMEpFcTBV?=
 =?utf-8?B?S0VaU0hwZU5tT2RQYUJnL2UwaitYVk5PY0RGWk1JdjhQV2JCUlZla096cnA4?=
 =?utf-8?B?ODdEbjBYek1IcGdMc3BpQnpOUkJWQ2U4RDZNOE5iY2w2cCthN1RqUTJFQThk?=
 =?utf-8?B?N2p6eSszNnIrYTB0Z25odzZXdmpscGVXV044UlFUa3FBd2pLazM2Y01BOGpG?=
 =?utf-8?B?L3NjMW9Fek45REVuWjFRY2lidTdvK2dGSytOYkViYmlEa2xzM1pweXNtaWl5?=
 =?utf-8?B?MkVjajRzVFVORmdYc0dFd0hBM1RpMno5T3dBWmJwcWc5MDcyVk9MaE16VHpH?=
 =?utf-8?Q?rhXPDISZ87D4DFToIOlCII99I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c694c861-2be4-4cc7-b09a-08dd1ed2aeb3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 19:40:38.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHIkFHj4zWcq7uRX9SLqJ9PWSgSKkFjRcqU0qeJAF6bsonxtmNhAhqf1KDF3Kw6A6iZkRtu8Z6Wp7V2c8H5NwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201

On 12/17/2024 11:27 AM, Mina Almasry wrote:
> On Wed, Dec 11, 2024 at 2:58 PM Nelson, Shannon <shannon.nelson@amd.com> wrote:
>>> +
>>> +Driver support
>>> +==============
>>> +
>>> +1. The driver must support page_pool. The driver must not do its own recycling
>>> +   on top of page_pool.
>>> +
>>> +2. The driver must support the tcp-data-split ethtool option.
>>> +
>>> +3. The driver must use the page_pool netmem APIs. The netmem APIs are
>>> +   currently 1-to-1 correspond with page APIs. Conversion to netmem should be
>>> +   achievable by switching the page APIs to netmem APIs and tracking memory via
>>> +   netmem_refs in the driver rather than struct page * :
>>> +
>>> +   - page_pool_alloc -> page_pool_alloc_netmem
>>> +   - page_pool_get_dma_addr -> page_pool_get_dma_addr_netmem
>>> +   - page_pool_put_page -> page_pool_put_netmem
>>> +
>>> +   Not all page APIs have netmem equivalents at the moment. If your driver
>>> +   relies on a missing netmem API, feel free to add and propose to netdev@ or
>>> +   reach out to almasrymina@google.com for help adding the netmem API.
>>
>> You may want to replace your name with "the maintainers" and let the
>> MAINTAINERS file keep track of who currently takes care of netmem
>> things, rather than risk this email getting stale and forgotten.
>>
> 
> If it's OK with you, I'll change this to "the maintainers and/or
> almasrymina@google.com".
 > > Reasoning is that currently Jakub really has reviewed all the netmem
> stuff very closely, and I'm hesitant to practically point to him to
> all future netmem questions or issues, especially since I can help
> with all the low hanging fruit. I don't currently show up in the
> maintainers file, and unless called for there is no entry for netmem
> maintenance. Wording the docs like this gives me the chance to help
> with some of the low hanging fruit without going so far as to add
> myself to maintainers.
> 
> If the email does go stale we can always update it and if there
> becomes a dedicated entry in MAINTAINERS for netmem we can always
> remove this.

Fine with me, thanks for the note.

> 
> Will address all the other points, thanks!
> 
> --
> Thanks,
> Mina

Cheers,
sln


