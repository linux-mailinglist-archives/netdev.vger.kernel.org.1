Return-Path: <netdev+bounces-186453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D49A9F2C4
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFC53B8184
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044182686B7;
	Mon, 28 Apr 2025 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="ihVkZSHx"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C452484A3E
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848300; cv=fail; b=WmOIVjQgCnmxGetaOzHTNkT7E0nUQO0+2TgiedEMed1OPOpRpeODUNWUz0aWN8ZH5EODv/46tLPJe8KKKMYc5xlmAj2vHsckuzYPGGSYX7YtFl9FLJPIsgxvyoP8YA5wex43TA7X21alTW6FKufDrhxR1RPZ1gkeUuO39OWc0pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848300; c=relaxed/simple;
	bh=ABWyH6UXVuGykwCTAkCfhQJplDrzJtqO1PHQAcl6TIU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MTvzuttyBenhEIYTYBP2ukw/R6LZXk+dSLCNVA+s+jY7/3wLtCNyy+itptzLq0xbXo+8XrsHGadbU5bMN8IKeqfS8k2RveTpuI76CJdp2G70k1VHv0lkkoKy38GNRZOTeK6viIwNGIOjNAoIvWcR9Gb4cJGzV5/5RjiGr5Bzl4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=ihVkZSHx; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1745848299; x=1777384299;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ABWyH6UXVuGykwCTAkCfhQJplDrzJtqO1PHQAcl6TIU=;
  b=ihVkZSHxcermVbGGcSTXtOP9UgCikybmmRYYE30WhekJN+h1tTsIt20k
   B607DQQzCa60jB5YHojBllXYWa9iaN9O70zcjHDZUUrADMTl/MO4wQcs0
   yWmI/fzqQ1bkEcb7mO7KqXBImdgnPTKQYT0d4+6XI8bhIZQgiokzFpoTO
   M=;
X-CSE-ConnectionGUID: ofCYlXvwQ7aH8WeNXsKkMg==
X-CSE-MsgGUID: huXPQ/whTOqvs6MsZsW3cw==
X-Talos-CUID: 9a23:SwwEImFyvx/KHNRdqmJg+mUlHvA7bUSCxVeAHEKeOX1KS5iaHAo=
X-Talos-MUID: 9a23:89QlVgSespoZVnb0RXTsmQFaDYB345iJEV4Wz7AdidK7bidvbmI=
Received: from mail-canadacentralazlp17012027.outbound.protection.outlook.com (HELO YT6PR01CU002.outbound.protection.outlook.com) ([40.93.18.27])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 09:50:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y34EQ76nOf5yzkoD5l8lK37IMjk7g72why4VvaUh+8yRKmlthf/j4gfwRNByLoEF16bn8CdGuDUo+tTb2krcYF4Bnjj+pVe6rTLEp1abosmGHRDQkQL1qLATar/dk4yi8ITzERtwmj4htwUJPKU1bSc8N8CJPlAxwyUrJ8p7ONhzksp6VxhlH3AaMB1HzVwwV7BvoxfGF4rxmIv9z6GhQVkHcrNQwFBcjags6UrYPQEfqPcb1P4+PqeNgXwpO0jZa7KQAINa9iP2oEAV/Ktp9fc0tuJdi11CshlSxkL1GZ+Q59fzJ0S6c6OF/hrCLlyoqLSdn6pqwA8mbAZY+C6vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU6a0uwjYTO4CkHD2pXXFeQe77/J+9i6EP+UOk9783g=;
 b=XuLJEY802VFwFtQlxFDzMZvqeZKq8hVd7KRqmsmNfE+y/xNhsfUMCpNhjG/yYGtSjQI4BArspdTJ3OdQ2yrj8buLj7wpAKnSISaq9GOwp5i/tqZ4UAPoOB3GfitiMRh9TytQQ08ZvAZxddtP41mVLpoMtauVNHEgySa85cje9iE/RyjPmaStqSLmNiteCLJtGxOCFIebhSNg+QGVN9ZmeS2mjqDiKEmgDguxMO7v7I9Mmd+CnyKxbftX32wbvRWUizZkkLyqGiXobqFJIxvIwSMIzI6XBMbq6z3NGtPd5yiLkSSy1HWenshrGsrutRK1J0IVb22YKHdkNwJommRl8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by QB1PPF051145140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c08::20a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 13:50:26 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 13:50:26 +0000
Message-ID: <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
Date: Mon, 28 Apr 2025 09:50:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/4] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com
Cc: netdev@vger.kernel.org
References: <20250424200222.2602990-1-skhawaja@google.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20250424200222.2602990-1-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::11) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|QB1PPF051145140:EE_
X-MS-Office365-Filtering-Correlation-Id: 72522499-ed91-48ef-b59b-08dd865ba0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjVvMDQzNHZQVDB2MTdHTlQvazBHRE9VQXlMS3g5YUwzVjh0WGVUVnRkWlRu?=
 =?utf-8?B?NGVuTitGWWtGMHZvbi9lQ3NEUitOaG5XRWFRZjRsVHdCS2VBc01rVDNGaC9X?=
 =?utf-8?B?S1FUN2xHSDUxbW5WdWN3bXdMdGJNWk5rSHRydWFHTzljUVN4V0dzWTd4c1Vz?=
 =?utf-8?B?cFJhL0xSelU5dmw0UlR5VmNwb0VRQnMvUG43MnZWYm96dzY0U0lvKzIwS25Q?=
 =?utf-8?B?V1hFMmhGYVJtNFNnc2VUQlhYSVdEc0oxN1JxcWlObTNsTW55QTR3YXl4VVQ2?=
 =?utf-8?B?RUpPY2xZV25pVmJOYXJHeW1SazZMMG94RGdDQ2tXdnlPNFlpd1VWU2NNY2VP?=
 =?utf-8?B?bFBkYXdwRDRualJ6OGhSRzNvNFdId1FaSnhYRUhrd3REUkNLTkxTZFU5M2pH?=
 =?utf-8?B?Q0dpWS93TzY2UVQrT25mT3B6UFNCUG9qMDRZdG41bTh4cDg3MTNydzlMdE43?=
 =?utf-8?B?K3dEaGhKN1BxQlRFVFdzVmFpaEQrRHJ4c0ZOUzh3VnFLcmhUUFk0VTVGS25L?=
 =?utf-8?B?SE5JSFlhUWVSL3doNHFIRDZOQlQrTTdoUTJhelhtbHorR2pJOFJXdXpkdDQ1?=
 =?utf-8?B?ZUU5TDNxRUgzQ1BNMG4zWWdMWGpTaE5hSFB3aGJDYTBIYjdkNjgwUllYM0kz?=
 =?utf-8?B?U0hDWEdWYklTSGpkQ1Vac1pzUElBemM1QVByN2VPL0p1d1loUHFPdXlDS2l2?=
 =?utf-8?B?K0QwSSs4cDFJVUhPbU13bXQxbVZpa1NIbFVTR3NzUHBwdXlaMVBzMzNIRFBa?=
 =?utf-8?B?WUZQUlp3OTlhTXluNXBxVFpBSW5ucUxINFhCUXJ3S3JhNlpSNDdhcitveklC?=
 =?utf-8?B?SUN6NEo3cWxqRkcvYUFlK1FtYjJRTG9wWWFqM1JDRXJqVjB0SlpUMHFKODZQ?=
 =?utf-8?B?Zmc2c1RpVVVVVzVJYmJFYThPN1FuM0Q3M081M1RndUdXdHN6eThRbVlQTGRq?=
 =?utf-8?B?bUJKWHBkUjZiUVVVdHRxM1J2em92UUg3ZmI0SDdwY1ZYV2ZEZEVaRUg5cm1t?=
 =?utf-8?B?dFBwMGtlcHdjNFlLQk0vUm16NlZoc0R2azdPT1c3amN3cmFSa1RSRXVWejlj?=
 =?utf-8?B?T3ArZnU4THkwTnRrZlBHSWNoMXkwLzN5YlliczBTR2t0YnF0QWk3UUdqd3U5?=
 =?utf-8?B?TWpibGtVQ1VGOTJKWm1VbHhOZHNmN1o3SFlTd1dBOU1KNXVwNWtlNFBxZTM2?=
 =?utf-8?B?TE1qU0UzejZMMkljZHg0TWZuS2FTYThqTkdJRFFQMXpqK2dpWHRFYlV2Tm1U?=
 =?utf-8?B?Qnl6R2lHZEp0ZUJ1Y3hMMnUrSnQzcGhTbWZ5RXhreHc5eC9kWDA2MlpyOTJy?=
 =?utf-8?B?ZldkYmZyQnc3RDZPdEVDUFdYOVRTYzBqY0xxUCtxNVlwZ0Nyalg0NjgwL0VX?=
 =?utf-8?B?aW1VVS96d0RscHZNaXcyVGhOQk5FaTBJQXNsUzMwZHFESDkyUkl6NW5VSW16?=
 =?utf-8?B?ZDJiYWxQYVRkb1Z4ZDAzbG5ta3RIbzFSTXlmSlRLV2g1U1ZaU0RyUk5zWkQv?=
 =?utf-8?B?aVdsa05pTUNRajJqeThsVGJON01YQnNEQit3U29wbHU0KzBrZkpVd0Q4NFJC?=
 =?utf-8?B?QS9mYUR4Ti9tclh0YkZSZlRKUUdXMFlHVUZhQk5xMVk1NDc0dGxlMXFmSFBL?=
 =?utf-8?B?elFjZFhzd1M3QzBzV3lXWjRBZE40SDUzYUVJK0xSTVplQ2srMW9DQnZKN1ND?=
 =?utf-8?B?cHcrelBCdEQ0aDk2amtEZHlHdGZySmg3bkVMZU1CRG5DaE5CaDRzVzJPWTZs?=
 =?utf-8?B?djhENmhwT2ViN1FITFd4VmJNZEpBTUJjWXhHSnhGYzZxRTBXUi9yRnVYUGJh?=
 =?utf-8?B?bjJ1SE51SWZ3czAvMUhkRmVFek5Edk5RdUNBVm9hcis0aCt0K1dPVXV1elY5?=
 =?utf-8?B?dUZKUDdaYjV3czZ4dmJJL2RlV2dCcEc0YVJBUUhCdHZGZkFBMkRRSm4zay9U?=
 =?utf-8?Q?Lt+hLbwml8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFVnUWJya3Ixd0wvY0RXOGJ6SXRKZSs4STh0Tkd1WlVERUMzcW9mZ3AxaVhq?=
 =?utf-8?B?cTdnVllpVGNCRkhhS3Y4cFRQK0FIQWwyR2VlaklwK2dTT29hVS9KTkNicDBN?=
 =?utf-8?B?OXBvTVgzRThCZDhxa0Z3WWNPMUlYUXhWREVLMXFlS2gybVpwMkQrRVFLRHNI?=
 =?utf-8?B?UFNieENHV1ZzWnVVMVNpY0hjL1RKaE5VMnlHUjZmNEQ0K3lKTkFuUDRvRGJQ?=
 =?utf-8?B?L1ZlZ1VNRllPMlI2Vkxjam5TSlVuRVVnZ0gyTWkwRzdwRE1ZRVpVUExCT0RF?=
 =?utf-8?B?cklobVRZalh6TXdzeStVaTAvV3RoWE5HWE9UNW9hWjhBZENKaGVBNStNaGht?=
 =?utf-8?B?YThkVWVXRmJPeHZPRkNWdm5DSlJZUzdDYWIzZjFoSDN1b0JPbzdoNTNGSFcx?=
 =?utf-8?B?d1FZVllNMmIxVXFRdXI0ekd0bjUzYWtMMHZHbVc0dnVCWHpxc0ZCVzVzbVRM?=
 =?utf-8?B?WXU4UlM4cGo5MVRibkJNYlJOKzdQL1JqVWgwZklVQURiL1lFQnBua1F2RHEx?=
 =?utf-8?B?RCtCNDhKT3FKa0lYVGFYY3F5OVNyazhkN09iV0xWS2pUaHcxbGxGZUs5VEV3?=
 =?utf-8?B?b1g5R09OcU1sSWcyK0g0S01xTXYxdnIza1BsMmNQQzdwVlJNczV4K1lSN1g2?=
 =?utf-8?B?Y1pKUDVGR2cxM1BaREFYaFhiZEFWRzcxL0VMYVRjRkltalVYODdOaERzNXlO?=
 =?utf-8?B?a0Znb3BZd0pOQTZxeVhEcnBzc1NYaG9xSmlSS3RRUkVuWlhRWmJjK0lnOTJI?=
 =?utf-8?B?RTBPcExZR0JFYmo3cEx6T2hqRk9idUNDNzZqODE5Rk9oSnJpbWl3ZXB5KzVi?=
 =?utf-8?B?STRnL0labGRJZXQ5cFA3bmU1a2Q5RWtCWXNvOXZrRFJoWFVFOHZYUitRbllJ?=
 =?utf-8?B?QzNUZEFUWjRta1Z2TXMrMU0yQmJLUXFGU21pS0FaVmdBV0w2ZkdqLzN0Snhn?=
 =?utf-8?B?c1FJK1gySk5FTENrY3BZVjhZc1ptTkp2dGNnNFplWTdiQlVuY29uREtRT1A1?=
 =?utf-8?B?M29tOGlKSzkwb3RrUzBRY3dFT3ZEYlVtKzlyeE9BYzdyUWtObWxOVVNxa3Nx?=
 =?utf-8?B?Ry9SanBRRjhBcUFLR1pldC90cEZBT0lRV2RvUFR4ZWdDMmF5SDVzQ3NIYWxW?=
 =?utf-8?B?bldiTDExK3p3RVpka1NyTXpIVGF4OHFuRHJTdnluTTljbVQyU2IxekpPMlg1?=
 =?utf-8?B?RUlreCsyZ2IwSXRMYTNtTjdPRnExZCtNbnptaHdiak5ZbFNXZVFRVm5pazVu?=
 =?utf-8?B?d2pMNGp2Vk5PdVpxREE0aUJJeG5ZQmdYYk5IallRY2hTaEd6b0JGZ0hVNzdn?=
 =?utf-8?B?TU0xMlVJS2pyRjZ0OW9FbjNzbC9yUXpHaEhBQVh3RDlrRDJoOHU3UGRXaGpY?=
 =?utf-8?B?aURjTnFJMGdWMUdEUEs3dUdVRzRFd1ZXUm1wNVRiU0RBSysrNHhIeThVMzEv?=
 =?utf-8?B?SitsbDQxazVRNXFEd1pobHBsK0JRS0JRRGVoTWt2STRHaWhXNXhuQjFWMWZG?=
 =?utf-8?B?ZWxzVHpuREkwVGk0c3FNTFN3VnRzT0oxU3JteFNnL3djYk9MY2hsU0hWdjNv?=
 =?utf-8?B?RisvTVp2Ukl0WWN4TG0vVCtyQWJiazdLNjJEd2luYU1rYWJIQVZEcEsvT2o5?=
 =?utf-8?B?QnN6RlpsSGlvRUZxdmIwWUhWeVVMUCtreWFxK1ZBVi9VTWFsWlM4eENaeExT?=
 =?utf-8?B?MGo1d2N5cmlXUkJBSHNkcUV4U05SL25DakpuMGMwVHYxWXdhcHl4dlVGT0dp?=
 =?utf-8?B?Qk9DNUhpbXlFUlJ6OHNORmMreVFiQVlsb3lWRUQyV3RuZW05bEtVWFRMMFpP?=
 =?utf-8?B?UzNyaHVmVCthMVFkMlprTzlCUzJOOThpZFRML1RkMzFPYXNGcUc2Lzk3YlU0?=
 =?utf-8?B?enF0ek9NTnJtRnhDYzJodmxqYm1qMnRyVjlYaW5Lbm1MRHpNWGxiaEFxRXp4?=
 =?utf-8?B?Nzg1MDJrdnY4NXk2Z0p3dmJFZDZMSnY1a1pweDlqRnVZZm5sY0dXaHVENFFT?=
 =?utf-8?B?Tk43V0FvVnY2T2k5dGdoa3hyOVRmVURyNzI4UzE0dkVRVzlzR293d3N1OFo2?=
 =?utf-8?B?bDcwVDVuaGZsTTBMTks5UFFrRHJ2aFBvbkRBVTJiTm15aTJxZWRMSUFQbWlK?=
 =?utf-8?Q?vd4c1rB4iGZzHEHtFDCewLWJg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tWgzS7nqAdv1dNxUwGCr2gio679vrsY9Qpsv2XR1eDDYjv5ipMMl7WNPkntfA3rLNw5x+c3WThhXpixMzuUDUHROQkQIQ0Di3cX+TL9e0vAQb2y6KBJtLwc3rh0L1nhBiSN5eYZ0Cn6ndi+T3yzIVyr0Q2SVnJCO/FIfkaIMcWquQJgLLfrtQMvaPEJgINpdTf7zuc6IsOGk82d2M3OjqdzVXL1DjJ5RLmjQokpLaFMWWkyUYBFG2VDEFwmnu3hc52Xh6IxqEQU/oohXFxzn1bU8D1+A1fbB8ed7B9YabfaQfLtOjged7vcwrJqzt3a/o9KoTBjGrnjqZ9W4LgQSx3QXObe8xndj3pluVuDrtihuBa1IpD+tOpKIBvT/7HsIyE+hqSYS40oDH3f4wFB3DoYDRPMTMNWDSNA/k0WcfwRGumuz/rwtYFe9Rubv8vKv5tlUfO3WALI6hf5KkdbWbbW2Co7YZwmK4GjqwIgdUXqtCfNCgYgBqAob6B3b6ulMH7DWwrriSYiw4FotvurCc15oRUh36abPb7n7lhmgHXu/Lrymm0iGeRk19LEQlAVxQtyfTRorW8D7FdKd/5S4Le2crRewUB36RY4kbZcKPi1q7gjtBCF7fLixjF/Hpz9p
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 72522499-ed91-48ef-b59b-08dd865ba0f5
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:50:25.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLu7xxXcTWIUlLdp0hQM8848j38TRmuAkYrkMotzN9oS3zlxb871Zan9O5WmqwHtg/Nz1xsNFCOKKY1h2m/Hpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF051145140

On 2025-04-24 16:02, Samiullah Khawaja wrote:
> Extend the already existing support of threaded napi poll to do continuous
> busy polling.
> 
> This is used for doing continuous polling of napi to fetch descriptors
> from backing RX/TX queues for low latency applications. Allow enabling
> of threaded busypoll using netlink so this can be enabled on a set of
> dedicated napis for low latency applications.
> 
> Once enabled user can fetch the PID of the kthread doing NAPI polling
> and set affinity, priority and scheduler for it depending on the
> low-latency requirements.
> 
> Currently threaded napi is only enabled at device level using sysfs. Add
> support to enable/disable threaded mode for a napi individually. This
> can be done using the netlink interface. Extend `napi-set` op in netlink
> spec that allows setting the `threaded` attribute of a napi.
> 
> Extend the threaded attribute in napi struct to add an option to enable
> continuous busy polling. Extend the netlink and sysfs interface to allow
> enabling/disabling threaded busypolling at device or individual napi
> level.
> 
> We use this for our AF_XDP based hard low-latency usecase with usecs
> level latency requirement. For our usecase we want low jitter and stable
> latency at P99.
> 
> Following is an analysis and comparison of available (and compatible)
> busy poll interfaces for a low latency usecase with stable P99. Please
> note that the throughput and cpu efficiency is a non-goal.
> 
> For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
> description of the tool and how it tries to simulate the real workload
> is following,
> 
> - It sends UDP packets between 2 machines.
> - The client machine sends packets at a fixed frequency. To maintain the
>    frequency of the packet being sent, we use open-loop sampling. That is
>    the packets are sent in a separate thread.
> - The server replies to the packet inline by reading the pkt from the
>    recv ring and replies using the tx ring.
> - To simulate the application processing time, we use a configurable
>    delay in usecs on the client side after a reply is received from the
>    server.
> 
> The xdp_rr tool is posted separately as an RFC for tools/testing/selftest.
> 
> We use this tool with following napi polling configurations,
> 
> - Interrupts only
> - SO_BUSYPOLL (inline in the same thread where the client receives the
>    packet).
> - SO_BUSYPOLL (separate thread and separate core)
> - Threaded NAPI busypoll
> 
> System is configured using following script in all 4 cases,
> 
> ```
> echo 0 | sudo tee /sys/class/net/eth0/threaded
> echo 0 | sudo tee /proc/sys/kernel/timer_migration
> echo off | sudo tee  /sys/devices/system/cpu/smt/control
> 
> sudo ethtool -L eth0 rx 1 tx 1
> sudo ethtool -G eth0 rx 1024
> 
> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
> 
>   # pin IRQs on CPU 2
> IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> 				print arr[0]}' < /proc/interrupts)"
> for irq in "${IRQS}"; \
> 	do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
> 
> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> 
> for i in /sys/devices/virtual/workqueue/*/cpumask; \
> 			do echo $i; echo 1,2,3,4,5,6 > $i; done
> 
> if [[ -z "$1" ]]; then
>    echo 400 | sudo tee /proc/sys/net/core/busy_read
>    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>    echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> fi
> 
> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-usecs 0
> 
> if [[ "$1" == "enable_threaded" ]]; then
>    echo 0 | sudo tee /proc/sys/net/core/busy_poll
>    echo 0 | sudo tee /proc/sys/net/core/busy_read
>    echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>    echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>    echo 2 | sudo tee /sys/class/net/eth0/threaded
>    NAPI_T=$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
>    sudo chrt -f  -p 50 $NAPI_T
> 
>    # pin threaded poll thread to CPU 2
>    sudo taskset -pc 2 $NAPI_T
> fi
> 
> if [[ "$1" == "enable_interrupt" ]]; then
>    echo 0 | sudo tee /proc/sys/net/core/busy_read
>    echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>    echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> fi
> ```
> 
> To enable various configurations, script can be run as following,
> 
> - Interrupt Only
>    ```
>    <script> enable_interrupt
>    ```
> 
> - SO_BUSYPOLL (no arguments to script)
>    ```
>    <script>
>    ```
> 
> - NAPI threaded busypoll
>    ```
>    <script> enable_threaded
>    ```
> 
> If using idpf, the script needs to be run again after launching the
> workload just to make sure that the configurations are not reverted. As
> idpf reverts some configurations on software reset when AF_XDP program
> is attached.
> 
> Once configured, the workload is run with various configurations using
> following commands. Set period (1/frequency) and delay in usecs to
> produce results for packet frequency and application processing delay.
> 
>   ## Interrupt Only and SO_BUSY_POLL (inline)
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -h -v
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> ```
> 
>   ## SO_BUSY_POLL(done in separate core using recvfrom)
> 
> Argument -t spawns a seprate thread and continuously calls recvfrom.
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> 	-h -v -t
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> ```
> 
>   ## NAPI Threaded Busy Poll
> 
> Argument -n skips the recvfrom call as there is no recv kick needed.
> 
> - Server
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
> 	-h -v -n
> ```
> 
> - Client
> ```
> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> 	-S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
> 	-P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> ```
> 
> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI threaded |
> |---|---|---|---|---|
> | 12 Kpkt/s + 0us delay | | | | |
> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> | 32 Kpkt/s + 30us delay | | | | |
> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> | 125 Kpkt/s + 6us delay | | | | |
> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> | 12 Kpkt/s + 78us delay | | | | |
> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> | 25 Kpkt/s + 38us delay | | | | |
> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> 
>   ## Observations
> 
> - Here without application processing all the approaches give the same
>    latency within 1usecs range and NAPI threaded gives minimum latency.
> - With application processing the latency increases by 3-4usecs when
>    doing inline polling.
> - Using a dedicated core to drive napi polling keeps the latency same
>    even with application processing. This is observed both in userspace
>    and threaded napi (in kernel).
> - Using napi threaded polling in kernel gives lower latency by
>    1-1.5usecs as compared to userspace driven polling in separate core.
> - With application processing userspace will get the packet from recv
>    ring and spend some time doing application processing and then do napi
>    polling. While application processing is happening a dedicated core
>    doing napi polling can pull the packet of the NAPI RX queue and
>    populate the AF_XDP recv ring. This means that when the application
>    thread is done with application processing it has new packets ready to
>    recv and process in recv ring.
> - Napi threaded busy polling in the kernel with a dedicated core gives
>    the consistent P5-P99 latency.
I've experimented with this some more. I can confirm latency savings of 
about 1 usec arising from busy-looping a NAPI thread on a dedicated core 
when compared to in-thread busy-polling. A few more comments:

1) I note that the experiment results above show that 'interrupts' is 
almost as fast as 'NAPI threaded' in the base case. I cannot confirm 
these results, because I currently only have (very) old hardware 
available for testing. However, these results worry me in terms of 
necessity of the threaded busy-polling mechanism - also see Item 4) below.

2) The experiments reported here are symmetric in that they use the same 
polling variant at both the client and the server. When mixing things up 
by combining different polling variants, it becomes clear that the 
latency savings are split between both ends. The total savings of 1 usec 
are thus a combination of 0.5 usec are either end. So the ultimate 
trade-off is 0.5 usec latency gain for burning 1 core.

3) I believe the savings arise from running two tight loops (separate 
NAPI and application) instead of one longer loop. The shorter loops 
likely result in better cache utilization on their respective dedicated 
cores (and L1 caches). However I am not sure right how to explicitly 
confirm this.

4) I still believe that the additional experiments with setting both 
delay and period are meaningless. They create corner cases where rate * 
delay is about 1. Nobody would run a latency-critical system at 100% 
load. I also note that the experiment program xsk_rr fails when trying 
to increase the load beyond saturation (client fails with 'xsk_rr: 
oustanding array full').

5) I worry that a mechanism like this might be misinterpreted as some 
kind of magic wand for improving performance and might end up being used 
in practice and cause substantial overhead without much gain. If 
accepted, I would hope that this will be documented very clearly and 
have appropriate warnings attached. Given that the patch cover letter is 
often used as a basis for documentation, I believe this should be 
spelled out in the cover letter.

With the above in mind, someone else will need to judge whether (at 
most) 0.5 usec for burning a core is a worthy enough trade-off to 
justify inclusion of this mechanism. Maybe someone else can take a 
closer look at the 'interrupts' variant on modern hardware.

Thanks,
Martin

