Return-Path: <netdev+bounces-116326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B771949FBD
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11061F249C9
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4291B32CF;
	Wed,  7 Aug 2024 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pYYFU2wb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A35B1B32A9
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723011788; cv=fail; b=jFi7pW7OqdZhWcC+dPWT3Few2GR6tzRlUQPzevx0WSPLyocq36ixkXT3uyoHJVYgBtcTKGFfWmtUS/amJHBwp2IbMKl0H19fZbGulwlZTRidXLcq5hXsnJ2je1VjdaosSIDdgEFSUx0DSbwr+PJ0u2bMWMmbm4U97mGjlsNjGpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723011788; c=relaxed/simple;
	bh=+jbYmTCobR/T/O1Fi2xjtF8KHt8Nzau3gPnhHpD9ik8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PIyOw53rhicUDeAkl7EDhOIQpMjImPKa3PdcjW6elcfXwZWnQBH0mq+qy+7QbdIa1sfnnnzVPrk9Wkn+bU31x2XThUCiff/CDNT+6V/QTGxJ2I1Yv94crVYESpmb3DjY9UGJv57BuKF7af4ba/H/G1F6RXbjKkw/Ntvg5ULDcVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pYYFU2wb; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYcIFMDTl2+6Q5Xrbe6ydGXzhI7nxsPecKKHqnaB8Y3cWE1Y6JIE59sqT8zSpYrK8YA2Owx29SI/B/3A1MGzdvCBS1EEgnv570Jv2MjdWYOhHH0EoZ6/iQEF42CU0gPJwBHioHdZcAvXJT1PfcjLtZHQZIKwARlC6U0hgP/EHtpYJO6RjFwlM1SCaeIIEa6g+S91qfBivNC1SRCShOd38CGOEXLCqQ/KkBtZKiQnplbqKiE3ZCyE5R5oc8v30+KQYodbJrQ332yDJrLSYcVfqj727wPFbyiUo54bOpLuPWC0KpOO5yaPts+wPPWOtaBVptltpJO0fjOyzf4tGfvBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+EXjQIysTTJwQNQCRovhS2pCr18Uy9neNhT0hXHaF0=;
 b=ULT8t8epY548HVIp98arIRdyx84p2vC39kOUchmv8CMl5+JiPKupOIdKMvwKxTN4R3rqIl6k1s4+Yg+Apzia8OoEE6YQabm7uSsMjjDTw6xXIOsJx0tMeF+WsxNiBO+/sWS5obVN8VEU8ckxB5DYxuDPKcYIa3hbAVVrhuELXv6uFnPUvLeJGKXlHS+6stMfH1ZCeFPvS03xPpY+3Ap0dby9SgpU9GXMfQte+SjY6RWoiQA399EJXRx/IVMH3Z2Rp4xblD4pCu+2CeZCVWMI55tEDQAYjzWn34hH9NPhUgzfwKu3TmX8XSqonIheRqkUbjsjxrG379YV0J29hTvMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+EXjQIysTTJwQNQCRovhS2pCr18Uy9neNhT0hXHaF0=;
 b=pYYFU2wbD0KQ8BPEsdYF6fp4M6vQoT00+69mmhZNIJONc3hSWSiDc1f6Bc+ps3yXWfcLMDvNddluXw6UBHIkGFECRKLllqiSg+UQZoEYejkxVRoMjwPXIAY+5g2l3cPYymWiebrFAvoaeTeh4JKxJ9nzUQ4cbAwiu3fpzum0dr3ptixt0kojq900qAhUQ/HL3RpBPi4gmAYMJpexKKRV+cTR97yQQXzm3sBn7nXriiRwfhKSOTL9u/yFvS0tndb4vU3BYpTim/JJdJE+tX4dmvqKfP3e8ajwGhkHUsQoKHEQJ4y1EO0XScdV356C2sm4M/8HkHWpUA/qVwYHgEtZeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 06:23:03 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%7]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 06:23:03 +0000
Message-ID: <3719e2e9-8254-4be6-9b19-0907860ff550@nvidia.com>
Date: Wed, 7 Aug 2024 09:22:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/11] net/mlx5e: Use extack in set ringparams
 callback
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>
References: <20240806125804.2048753-1-tariqt@nvidia.com>
 <20240806125804.2048753-7-tariqt@nvidia.com>
 <20240806181656.2c908cfd@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240806181656.2c908cfd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5a71c0-edf3-41c5-57a9-08dcb6a96439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmYzYTlZY0FrMmxVQzl0cG1VYUwxSERLM1pDSUVnR1htVGlpbEZLOWxGNVJX?=
 =?utf-8?B?ejQ2R0lienhzVFJlSyswdEFDQjRKQlFLeXFZU09tT2l4amJObFlXaGNHc0xt?=
 =?utf-8?B?OWhLZ0x1UFI3SXlkVlpHcHJELzBseHFxVUNJV0tSbXB6ZUh1NXI0SzB3NnFE?=
 =?utf-8?B?azg2YThqSlExM05ISGZhUkYzbkJlOTlaMXdQZnRiekFESldpZHR6clJ6ZnM4?=
 =?utf-8?B?VU1uOURNb0JLRjBKL01wNkpiSG9DUFNDMzlCdW5FeCtBSnhjV0ZjK2YvUUI5?=
 =?utf-8?B?VStiK1IyeTR0Q3N0UXdNb1ArUDhJcTFQQ0ZmV1dQNmVZMlFHQnZCMjZMRzdU?=
 =?utf-8?B?eXVib2JBTGRjajNKNDQ0TzFWYkM1Q0N3Mmdic1MxM1JRWWtUSkxyb0ZQelhE?=
 =?utf-8?B?ZjJXT1ZSbkpoVmRTNFN1RUdvUnYwa09zRUxydHgvaC9wVzIwNWE5cWtrNHlM?=
 =?utf-8?B?OHpnUXBIYXhISUZpa2NQeHdWZENBcDNldVRiK2Qwdk5YTFlvbUJva2p2bVl3?=
 =?utf-8?B?MVBUd25jRGV2WmNGcTZqZkd6Z2ZyU0pXVlJLcEU2eDBaSzRHSTdQSDQ1bVN3?=
 =?utf-8?B?U2JlczNmL0tRUnJuUXdkeUJLcURvVGhzVXZ1K0xCWk96aTl2MXJ6MFArSE5O?=
 =?utf-8?B?dTU2WDdlZ1B0TEdFTFJrcEtyakdkZmlQeVIzU09pMy9WVitiQTFlamJlY3do?=
 =?utf-8?B?WTVQZzhaRUVpNkNNZWo4SndoaWZxQnNsdjRvVnFEeVVSWDc3UEhwTC9scThT?=
 =?utf-8?B?aEg4Q2pYeTJNWnQ4UTVXRmN3dHdlSjlNTE9ydmo1WHE5QjFGWkxnQm5tek12?=
 =?utf-8?B?aDh5SWV2VjgxQ1VKN2VxWFg1RUZ1UVhMYmt5dUxVdW5tSW1QRVU5U0I2anNS?=
 =?utf-8?B?QjZWOUE0RlRWQVBEd2daOWN2OCtiazNucDdpSlRkbFZHN29JTGxhQUtYNUN4?=
 =?utf-8?B?VkpYemQreDEwSExzNFJjZ3ZpemhHODB2RnZWVWExNGVXZjZZS3h4bXRUdE5I?=
 =?utf-8?B?VXZWV0o3eUpUK2owZXRZRDVGYThXNEZQQWRqM3ZIR3Uyd3gwZ3NWdCtOMkRI?=
 =?utf-8?B?WmNzaTdHdXFGWW5zMkFBRnJmcXo2b2F2ZGxSTWtacHdrRGVGa3JBUEFvVndn?=
 =?utf-8?B?MkJqZHNZV0U2MnlzTUoyYThobHppclZzaFhwaFoxZTdENWVtaWtaR0k4QzZJ?=
 =?utf-8?B?bzRRVjVyUG56UW05UFdheUNtNkYrY1hkSTZkbU9JOHVyanRyVktIL1BSNks4?=
 =?utf-8?B?c0xKcitOQ1U4amFYWUthQVB6aDlvMC92cjMyblRtb253TXhEMnRVRWEyRElV?=
 =?utf-8?B?Q0JPU2I2Y2d1TkV3THJGaXdwM0ErSURibEEyZmZ6c0JhY3g4cEZaZlROUWRW?=
 =?utf-8?B?Z3YwY0pqTDdtRDUrZXJsaHdPakxnamJreFNvQ2VVVzJyOE9pOCs0V3JVa0Fa?=
 =?utf-8?B?RzNjTFN2S1p4eUNLUmF5V0paOFZxYWtzT1NITnJ3UDlpN295N1BmZTRxVnZT?=
 =?utf-8?B?Y1ZjbzAyNlRZeE4vWWdCQ0IvSDlwMi9ES3c0Y0dybHJBMk9DK0tNMjBlVjRq?=
 =?utf-8?B?eUNTT2c2TkZNU0xwRDBWeHMzUDJhS2xsOVUyYzdCeVFSZGlhZnZ3VkJ4d01S?=
 =?utf-8?B?TEVmQ1hDS09mQ2hudmVHekxYNGZRYkJoVnhBdmhYWjdHL0hPVEVCM00rWVpE?=
 =?utf-8?B?c2FzU3FsTG9rWnRMS1F6WjkycGxRREgwNUlBWUMvazJSQnFqcjJIeGt6MFd5?=
 =?utf-8?B?R3BXV1hKV3FQVGRJMC9UREJRc1JOMnF5b1hVaDZqSjlabUpVV3VBY1R5b2xT?=
 =?utf-8?B?NnVLU2JlbWtvbllDWTl6dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTBMOE5QcTU3QzhZNzdUbHhnT1BlL2hsZHBNazVid0s3Zm1WYUx6UzJNeUhk?=
 =?utf-8?B?YVdaa1h0bGN3MFlvSkwrbXVWa1NDTWNLKzhtWm05bi84NHpEUzRUbHdWcllx?=
 =?utf-8?B?Rm01RkFSV25BVGJGK2FoeGgrMTdlc2NIQlpVc094MlJwTS9XcUM5YWJiOUxo?=
 =?utf-8?B?NGtkYTJJWjNuak1CUzVzbmtVc0VtcUVVQ0ZrNndwb1h5THdjU2RFemgrdTMy?=
 =?utf-8?B?ZmRpUDNoK1V4bUQxZWVXQ0dydHdZNEVPbjUzVXVVM1RPWFpYbEcySGhQSHBl?=
 =?utf-8?B?Z1NodFJ1bEN4MjlnY2EycnFCekExUENTMUVxMkpHSXpPOWdtMkI4b2Zra29R?=
 =?utf-8?B?Y2lDYkJOakF6ck11VWdvcnkxRE40NzBPMFE5NWd0dmMwd1VTUjZvbVBRWS9M?=
 =?utf-8?B?RW9WSFZSclFpSHh2blVGbSt0VVNXUU9Wemg4SGxpZ2FKbjJ6cmRIYUxRVWtq?=
 =?utf-8?B?bUpCa1J5R1hiM1lmT0hqK1gwV3I4QXhDNndNb3Y1dWVvenhWTVpyS0ZVYU5X?=
 =?utf-8?B?Sy8zRXJmZEd5VCtIV3ZYZkJlMUpuTk1NR3hQazZZQjFXb0lHRXZnRVpqSU5I?=
 =?utf-8?B?QnJackRtZ3FsOTRxRlZkazdQMFEyQlY3WDc4VHIzR25BR0dHWUkyOUdRcTcz?=
 =?utf-8?B?SkFPZUFwa3ZQclhJcnNDWWJmdEdSTnl2TUsxa05VdHovaXlMKzU5YkkxS3l0?=
 =?utf-8?B?c1gvVXRobEJPZXRTMlZJM05oNUQzZkRlUzZhMVRLMUV5QWsvM3ZGd2lqWndn?=
 =?utf-8?B?aHdiSU1kUHowQ1hqdkN1U005R3g3N3V2S0JhOGEyOWZ1MTY3V0pYdXhVRVhO?=
 =?utf-8?B?K3p1NmY2aEg5SGs2cUxrVjNBWnNVRTRsL0g3MFoyT2Z5MHg5ZjZMN09yMnJQ?=
 =?utf-8?B?NU9abSszUFJwWWNya1daMU5YMHVPSWdTb3Awb0JSc0N1S2svSENJQXdPT01V?=
 =?utf-8?B?SjJsZ05pamtEVW85TXVFWG9MeTM1TjFKM1ZiZ1RxWUxoZE4reHNlVW51Y1I4?=
 =?utf-8?B?ZFVLNGdLVFdqVk1hM1I3ek1YcVE5Q1ZsT3ZzWDdBMkFOZkljaTBDZlhtQ29m?=
 =?utf-8?B?ZnJYSXpmcUl4U1VOM2owWnFnZzNEaVF6TUdxRzNKR3VaOUxTckdTdUdvamth?=
 =?utf-8?B?YVdHaHJPRnpwR1ROM09adFlXdHVuQ3I4cWdIL0w3MDNRdGYwSUJjYTNuTkU5?=
 =?utf-8?B?M0NaamhDTnFsU29KZ1FXZFFuWkVLQ2JhWXZpS1JyTXBObkFVRGFHeUR5MVZV?=
 =?utf-8?B?dEVsUnJmL29LMXNLRjFwY1p6UmpqZFFkSTZNNVh1aExSU21Ed3ZwS2lhUTJD?=
 =?utf-8?B?ams4ZSsxaCt6cEFFb0dpMmxrWWdSeWJJd3JpRk9sZUszMjZhdll2bTJMVUFv?=
 =?utf-8?B?cm53VFJ6SjREVDhIL3A4b2dqam9Pbkh2Q1VFRjhvUzJWcWcvUHJlYWNldnA2?=
 =?utf-8?B?NnFSYXBJM2VydzJKUkNzbEY5d0hQZ2NOZklrVGJUdmxxOWpCKzd1WUg5QmQ3?=
 =?utf-8?B?eTRrL1J5K21RZDJZRzc0dGtaQXFIZ3U4cTJmcTJ2ckthMnRWd1lUcnZqWHlW?=
 =?utf-8?B?dU1HUktDd0FLUjNzWG1OVXY0YnBCcWFuUFhCSkQyRjQvbzV4T2QvV1FTbklG?=
 =?utf-8?B?eFU0ek0vQkNyc1VlWk5UZGl6REpUK3dZVzZ0QzY4Rjk0SHRIOU1QNFZDYjJm?=
 =?utf-8?B?VVBLbllUS0Z5NHRVYktHTC96SzcvNHVkL0NFZ2FKWGUwRFFWNTFXQ3p3WEFy?=
 =?utf-8?B?SWE2V0crWlYyMklIMkNnbk5IMVQ5QWJRNVVpNEdaMmV6d01QcHk1Z1RKNE5T?=
 =?utf-8?B?RUt2dk0yMXNzTkZCa3pNeGRlRnIrZWdwaC9PMzdyWjV2WHVwS1lUUVUrcTZJ?=
 =?utf-8?B?V2sxVFZiMVkwbi94QlBMUGFYSEZJMFVCNzNHWE0zaCtNYjd1VDFsbUkwM2hE?=
 =?utf-8?B?YWROUVNCSmRDOVBKODVKWXordEZ1bVVXWjY4V1htdkpCRUVGTlF3UzduWnNW?=
 =?utf-8?B?bnhpTnBSVWFqTHorTVNrWGFkZEpVdndjZkF4cnNwanlKekczcWJjWFB5MHdk?=
 =?utf-8?B?ZmdWbmxzS2E5NUszdTcxa3kyRmxuS1BUSTl5dTBVRmRPRVJkSnh5bDYwdjh5?=
 =?utf-8?Q?66RE4Uoczf8HIj+O7oT5QjRgk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5a71c0-edf3-41c5-57a9-08dcb6a96439
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 06:23:03.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUTm026Gg6u4A1XUxkrdp6zjlAru+UD0nMq8I1FIc5MBmyqmIjyht3se64cilsPc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412

On 07/08/2024 4:16, Jakub Kicinski wrote:
> On Tue, 6 Aug 2024 15:57:59 +0300 Tariq Toukan wrote:
>>  	if (param->rx_jumbo_pending) {
>> -		netdev_info(priv->netdev, "%s: rx_jumbo_pending not supported\n",
>> -			    __func__);
>> +		NL_SET_ERR_MSG_MOD(extack, "rx-jumbo not supported");
>>  		return -EINVAL;
>>  	}
>>  	if (param->rx_mini_pending) {
>> -		netdev_info(priv->netdev, "%s: rx_mini_pending not supported\n",
>> -			    __func__);
>> +		NL_SET_ERR_MSG_MOD(extack, "rx-mini not supported");
>>  		return -EINVAL;
>>  	}
> 
> This is dead code in the first place, mlx5 doesn't set associated max
> values so:
> 
> 	if (ringparam.rx_pending > max.rx_max_pending ||
> 	    ringparam.rx_mini_pending > max.rx_mini_max_pending ||
> 	    ringparam.rx_jumbo_pending > max.rx_jumbo_max_pending ||
> 	    ringparam.tx_pending > max.tx_max_pending)
> 		return -EINVAL;
> 
> in the core will reject any attempts at using these.

Good catch, thanks!

