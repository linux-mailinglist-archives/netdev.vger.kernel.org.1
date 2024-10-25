Return-Path: <netdev+bounces-139094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F269B029B
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DA02837A3
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1121F7550;
	Fri, 25 Oct 2024 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="foLMax9h"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CADA1F754B;
	Fri, 25 Oct 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860047; cv=fail; b=n/wMPQAnx1/MMwaHZ+dd9tatzB5NEomCU/qTiscsF8OfFWE1Gho5KcFE0AkaUDgZEjp4g9Jrk/HuYA/TS3Jfe1pK+9sMkRfq3ZiKKHHxEzUTvYWTP3lPKIBLAUVgWNmN7Ed0CyhpjpCsv59l3P1Ai9hCxB2Ey5kq8vt+cruUyRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860047; c=relaxed/simple;
	bh=CW/76IIUD5p6K6RfZMdTDbRCa2MtKjCfdk1upTzBYMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RR+HDEV7RyBxWFmTyC2GFtzMDgiIXnrwY+1HyVc6L/5SAtQh7Kd9I+N8OnjsrC+RRVF9XEC7y9jDheZHshkewgsrP7E+J6r0pNzSeg3WejID0sdTr2FCUqnE4mu6ZF8pTLGwM1iG/rkHGCai7jF/rcFhqnRgVbHdNZTR64vJ2L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=foLMax9h; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MflG4tM3xs5htY9Enxuzljy3rV6SpYzyWYDObK5E5W/hLNijd8i40RUei0VpsBr4ZQ5pXt4CiwbCF2FTYkX9+EW6zobsDYia5dey1jqdODfWCeDs8bf1Wh82vQf2XuwbeEn03sTGmKID7hd8hQW/nsVmjQE+Joigv3Auyt8MEtzD5SQG641gvP/3HciUvFE3LD/+5PwRLUlaq07jO4TTgg3hksO5yyA3ZmjDGpTsMPUjuLbHD1X4VaT5ubLhVTETmUog8BSeO2uQQMy7+yAaSioXaCkEcpau2qWkfxuma8HPVKV+7OHxO7K0WKZtNhdTQh60eT1P1/3ee+UUwnrHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAWlMPKmPSuIqQpOEMtzS3i6GIbJSgaEqQEDgLfd7X8=;
 b=UWQFD46Ew5q5mWq4mUByA6rpJKt0duCKyRsuWZ7Qqx/MhywuZ0b0vXOV/5ty5BAp3QavR0bxQuw2vz8xBdHvV88ngjJ1R1VXDXxytO/ph+B1xgp4XaU4r9J2f67l1+ttIdbHYyMeHpbuzxuC0P5SPIz/oYFC80MtvyOblgxIUiy9J3/TEB3gj5+n+mdTjYtv7yGX3iInQCIIKWRFW76+oyW+PSsB1Y9dASL8/KwnRtznx/gUQOwMYYt6UMsWYu7SZDIHCDxdtCtnEXmOX/NufeS12sBSFBZZh7oUY+Mz9bY6F/tWOz4oqG1Sbg0sCtX9vEN8PmFRzY31FmQGKNjYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAWlMPKmPSuIqQpOEMtzS3i6GIbJSgaEqQEDgLfd7X8=;
 b=foLMax9h+kWThbEv103OaMbMP4+xdonhDH1fA3d0M26dAqwzTX/hHs/FPdQsVpe2I8gv1TuZPFYOgW82im/lJBJZdqbyFBk/T7a5gMxMUYK0YkTbouZe/5Y0WubdGssEezhp9UjJ/xYxVpngvDY1uJqfSMmLN5SD9MT7PDFym4qxCTFDgbs8LLuPpIZ5oUQrcOofkEtSGOrWjdftZPwyht7bozNFjw/M/9/dUdH0u+ZPTJ2CW+5o0hrwU0wzX3VLCrmYqQ3risxwi+D9qz/j11t8MqQfma2SwxjtMNLwnSjaZitbjloAMns0zaFfm2kuRHlY0peYCZaMhjNiGVCzHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10689.eurprd04.prod.outlook.com (2603:10a6:800:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 12:40:26 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 12:40:26 +0000
Date: Fri, 25 Oct 2024 15:40:23 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: sch_api: fix xa_insert() error path in
 tcf_block_get_ext()
Message-ID: <20241025124023.qp5y67slaac7iqll@skbuf>
References: <20241023100541.974362-1-vladimir.oltean@nxp.com>
 <CAM0EoMnV3-o_4L3Vv=TuEqC=iNKhNnW0c4HQiRqrJD5NtjKeOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnV3-o_4L3Vv=TuEqC=iNKhNnW0c4HQiRqrJD5NtjKeOQ@mail.gmail.com>
X-ClientProxiedBy: VE1PR08CA0014.eurprd08.prod.outlook.com
 (2603:10a6:803:104::27) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10689:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad588c4-313c-45f5-f2f2-08dcf4f23370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVFXUjFTM0pSSmpERTFlVUlpemRGZTJLVzVVZWs1c2RGOEVyMHhPMDlaa2FU?=
 =?utf-8?B?R0YzMFBYYVhIWmZRVS82bStPZzNvdVhlNVJrc1V2eVhNUlFpK05zbVVOaTJM?=
 =?utf-8?B?Kzl5Z1NlM3pqSXJ4bjJGYU5SdlhObHZJMFJybkVpVmdpNUI5UStlL0xGa0pN?=
 =?utf-8?B?S3M4MmRtbzkxMHltK1BjWllGNnZ5V1E5WUE3djVPQVZSUVRtYVYvMEpQMmRU?=
 =?utf-8?B?ajV4TG1wRU5vellab3Fhc1NUYVNvaEpmRWJ6dWlYanczLytnZjlhM3hUdVU2?=
 =?utf-8?B?eVU4OUVzbHY0SFplYmJleXhIK3UvMmkyWThkcnlLZ0ZLWnVFT0lzWHJ3dERI?=
 =?utf-8?B?d2ZOemt6aFc4UndaOGQrWjgrNnpCRnlIb1dNWXAzNnVXMzFWajdvOTNUbXVY?=
 =?utf-8?B?NG9uTnN6eGZDUXUrZEVvUE4wanIrRFo4MUhnQWlQby85YXNzNDJQNnZFbk1k?=
 =?utf-8?B?SjNWa2ZpNndScXJyZG42UXdaVGYxZWkvVklhZU5LL3FhRVNCblZqOUsvY2g1?=
 =?utf-8?B?Tk1ZeDYzR0VLQXZJeEI5WnhlK3VwcExuRnZieGNyMkFRWjVZZzk0ZTd0Yk9V?=
 =?utf-8?B?SFFwNHRQMEQ1ZUVJOTFnQzZlUVhLTWc0WDJVQlQzeTdOUW10NjJqVUNhcUR0?=
 =?utf-8?B?SHFUTFd4RjUwdDVpNExFaGhoVEhGRUdkbnlGZlB6dU95K3lEeHRsTFFrNFVi?=
 =?utf-8?B?TXVua0N2SU9PaDFycUs4cVNacXZ3ZlgrUUF6aWpBdnN5RHZ6a1hMeVlaVDZx?=
 =?utf-8?B?U0JMR2dDckpzMWt2R0Y0RU10QmZxZVk2Tm1MUDgrQjN3bGVVTk1LY1VKZFN6?=
 =?utf-8?B?a3JRK3dlR0FXcUE3R2wwY0c3c25Sb21lYmlSUzNhYTZadmFVOUJENENoRTlT?=
 =?utf-8?B?blgvMjA4QUFrZUFUSFNkeFJEQ2EzL2hiaU5pWFRWOFRrT1JwV3FCTlBRM2gw?=
 =?utf-8?B?ZjI3NkVIWm0yRGZVbFpNeFFHNWkydENQWkdJMHZuV1hqaGxLUmJValI5K1Vq?=
 =?utf-8?B?Q0Z5Y25QV1RZUXlJT1BFR0xCT045NTA0SC9mTlZpRGpwbFRxZUR0SmEydVBs?=
 =?utf-8?B?SjF5TWhIUlIvMmczdGh6THBRakpzaElBbkJPYjRaeVdscTBpSmkzTjVZWi8y?=
 =?utf-8?B?aEdnZ05mWjdJRUM3RWtEdkF2V0ZRUk9Rdmh3L0pBQWsyeG91U3RRUWh4QndF?=
 =?utf-8?B?U0JRWSsydm1OS01PbFdpMFZXN3Z4OVdGVjRLdDg1U1RTVjY5eHZwNDVqZGxC?=
 =?utf-8?B?NTBrZ2xzcWR0QWFxeFhIVkFFOW13a2NJdHVRMHhLblRNclNpRkc2TWRxY1R1?=
 =?utf-8?B?RldYRm5xTUlQZ0I1T1IwZWgrWUV5OEZVUDB4Z2IrcDg2WUdTK0F3N0JheDAx?=
 =?utf-8?B?NVVySFlDUytXS1lvcmtnQVFSYU1PZ3Q2K3VNRzJUY2dwRFFYNmhXNUQ5ajFU?=
 =?utf-8?B?bzY1RENMdHF6ajF1ekVaeGtEQUJHZ2paOEQwdjQvUkQzYVRqYnN2WGRwVGJT?=
 =?utf-8?B?SDRNb1IxMTJzb2RDWHlXWXZOL1g5d1ZvdldWMlh1L0toSko1UUlSaFFTWStr?=
 =?utf-8?B?RmdoaEdNL0lDYXg1am5ocWYwdDNsMXhwU1hUbXRFZHNuY0E2bVE0TG92R0FQ?=
 =?utf-8?B?NE1ldFNoVjJWR0FCUmQySVQrb0ZqeEYrNFMySXVTVnN6MGNGUzhNVWdycnU2?=
 =?utf-8?B?aEl0RVlZRzV0akpWUjMvUmI2UWhYNVdvMmw4WGlvZnNmQVNYSkk3dlNXUTJv?=
 =?utf-8?Q?TK2us8F6X6DMMPRDc2pBlFqUrtW4ZHRm33+G0Yb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akozNlFnMkRwTEc4ZkJ1OXJrWDJZTWJzNkdWTkZIZDA4dGdNa29hL3pWWkc5?=
 =?utf-8?B?MzZMd1hvUnR1TlJrKzlYYnpUT3BpT28wR0hNSmFCcG9FSFVrYVUwYnhEdW14?=
 =?utf-8?B?K0FVQWJxaTNCSEhrM3NWYms0NWdncUZTWk5ISDl0UU8rZVpVeXR0TXU1TFhx?=
 =?utf-8?B?dURoR2Z0dFZSZXFSK1YzdFFITWloWWZNTE95M2FoSnZNVFZvNDhWNk5xQWxF?=
 =?utf-8?B?ekFVMm5haEYvV0hxSkU0NVZOUm0wWnYrNEpCeHlQaFNkTWhEMzc2OVdIZit2?=
 =?utf-8?B?d2NmUkNlc3ZCcVJkZWZHT3M3TFA0WldBNGZQUTBDQWk4dm94bGJhNDVJUnp6?=
 =?utf-8?B?c0wxNktaaEh0eXJNZ3ZGblQ5eGo3MDJMd0hTOUw5aUdlN2k0TGhuV2RINjhm?=
 =?utf-8?B?R1l3TmczWk5UejJBNDhFY0paQ1p5NnM2Z21abW5ubUlxeHlYcE9SSHZxOUYy?=
 =?utf-8?B?ekdBRlBDVUpCTXdtMmZ0OXdqOHR5cktVRHB4MEZ4ZlRrSFFmWElLY2dZbFZn?=
 =?utf-8?B?dy85OVpSSG1RbWZyaTAzdVBMclE1RktpR1k3aXF3dTlkL096VFYyY25MaGZw?=
 =?utf-8?B?d2s1UU9EckhoZCtjSnZOQy9IWE1peFV6dmJmV28xcm1iQjBmMnF6MmJWM2Nn?=
 =?utf-8?B?QU0xb3k2bWNpU3BuSHdJQVdBNGFVUnRKeWRveEtTSjdveENXdmdROEExRlFw?=
 =?utf-8?B?V1J3L2I2YmxjRFJvZkZYaU9ybUJ4enpkTnN0bko4WXp4VWdmVWg5cnJ4Z0Fa?=
 =?utf-8?B?U0E3SkFHdHNWMGVQRGpVaEt6amhLbGhLcGs5L3kyNVpUS001RWhXTzF5SW51?=
 =?utf-8?B?N2grR0hkUnptVVhTSGJ5S1JLTlFRenc4cVFXeFQ5bU52bnlEK2p4MUMxTkhw?=
 =?utf-8?B?L093Vkdac2xIdVlxbjlKRE5NT0grbXhCclZhaE40Y0VJRkg4TTN0US8zRUx4?=
 =?utf-8?B?Mk92NC9sSGNyUSt2SFErL1I4a3B5NG4rSTFEQW52WlJqcHZyaUNqY2NkL2pD?=
 =?utf-8?B?djJxeDNlTDZqU2dOTWQvRUpWSi83dXpVeUtPRTJiUEpSSlQvc0d1dG9lb3dY?=
 =?utf-8?B?TGxZMFJNbXpmcVVXYW8wSElES1NCU3hobXJ1eDBaM2hjME1LMHlMbGMzbS9Z?=
 =?utf-8?B?MEdXY1F6aU53RWxESGh1SVpNYVhYVHdHenprMk1scW0zZU9yaXhIUXZ2aER4?=
 =?utf-8?B?NmNybElJejBvTlhPbEVBMk95WFlOc2puVW9YT1o4Z0o3SmhqSHNqWFRIOWxy?=
 =?utf-8?B?NENzanZBejhFR0tqbHg4eWJMU0VZRU9pSFFEUXovSzY5M0t4aHUyY3V5MnFD?=
 =?utf-8?B?clRNK3U4QVJySFZBVytWT2l0M1VQQm1TODlxZUxOU0g5U3FyUCtNckxqZHls?=
 =?utf-8?B?NnRQWnZCN05lMDIrWjQ2QVdiZWlGSjloTmF5SFJZL1ZuOExXU0xaNENMMm1q?=
 =?utf-8?B?MTRHYXBXS3BPVEZOaUVzQ2hTeHM4OWpxeE00Q0VGakFDY1o2ejhjNFp3bkdF?=
 =?utf-8?B?L0hoaXo1VmF4ZHhoUW1SZ1hrbmhORmxWVU1MUGc5VEsvdkdMR0ZZY3BwZnJM?=
 =?utf-8?B?SndQSFlwTVFuSCtGbU5BSW9DRXJlMnE1ZHRmV1Y0K3h4YTdZenlWNm9YaS9Z?=
 =?utf-8?B?bi9nejI4ZzA1TTZXSUNMaDRsN1ZUaWovd0NEbzFSeU5nVVk3YUszbzhXOTJj?=
 =?utf-8?B?QnlpWlZRTXozU0IySEF4bUZqOHQ4VU1EOTcraUx5MEpCVWw3YytmaTQ1WWN5?=
 =?utf-8?B?SUFUaUhqWkdWYVNZWCtjcTN2Ym9MRVZrMmEraFhqNmZCODlTYnZFRlJMOURk?=
 =?utf-8?B?azhQQXpMK1h1Q2tJdG9LM0hwcGhlR0lZYlNrNDlWNjVncXY4QmdtOURpRlpo?=
 =?utf-8?B?Sjg5b1JRTWFmMnhidGJQYlFTVC9BMEtYSTAzbTR4MDUrU082Yk14N3dNanJo?=
 =?utf-8?B?SzhBK3V2RDVkVlNvUTlremMzRU9GWTNWekxsOHdodnRrcW41N0lWdG03bVJI?=
 =?utf-8?B?WFFUaVJHYkI3dTQ1bnJuaUxnL3JlRTgzM1V3ZUVwRXYzc3pqemJQbU1lQXgv?=
 =?utf-8?B?YTFvalY5dE54dFB6NHRSbnJIem1sRUF5T25mN3NudVVEZnZlSXVJTkxvdGlt?=
 =?utf-8?B?RWNscUJQQ2lBaFQxKzBZN3Z1Tng0VDI2TDFWckVHTzNvNDNTTDdpenk5Q2NP?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad588c4-313c-45f5-f2f2-08dcf4f23370
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:40:26.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +x7Jt6nR7EY15XpHwGcrMdD8hDu+6E/29unwyjJwYgrx4A6exJs0cBM6Mx3LiZMb1H3vzlYq6cuIzB+SUmEMYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10689

On Thu, Oct 24, 2024 at 11:39:51AM -0400, Jamal Hadi Salim wrote:
> On Wed, Oct 23, 2024 at 6:05â€¯AM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >
> > This command:
> >
> > $ tc qdisc replace dev eth0 ingress_block 1 egress_block 1 clsact
> > Error: block dev insert failed: -EBUSY.
> >
> > fails because user space requests the same block index to be set for
> > both ingress and egress.
> >
> > [ side note, I don't think it even failed prior to commit 913b47d3424e
> >   ("net/sched: Introduce tc block netdev tracking infra"), because this
> >   is a command from an old set of notes of mine which used to work, but
> >   alas, I did not scientifically bisect this ]
> >
> 
> What would be the use case for having both share the same index?
> Mirror action for example could be used to target a group of ports
> grouped by blockid in which case a unique blockid simplifies.
> 
> > The problem is not that it fails

As mentioned, I don't have a use case for sharing block indices between
ingress and egress. I did have old commands which used to not fail
(incorrectly, one might say), but they stopped working without notice,
and the kernel was not being very obvious about it. Had the kernel
behavior in this case been more clear/consistent, and not failed any
subsequent command I would type in, even if valid, it would have taken
me less time to find out. Hence this patch, and also another one I have
prepared for net-next which improves the error message.

> Fix makes  sense.
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

Thanks.

> I am also hoping you did run the tdc tests (despite this not looking
> like it breaks any existing feature)

To be honest, I had not, because I had doubts that this error path would
be exercised in any of the tests (and I still don't think it is).

But I did run them now, they seem to pass, except for the last 11 of
them which seem to be skipped, and I really do not have the patience
right now to debug and see why.

~/selftests/tc-testing# ./tdc.py
 -- scapy/SubPlugin.__init__
 -- ns/SubPlugin.__init__
Test 319a: Add pedit action that mangles IP TTL
Test 7e67: Replace pedit action with invalid goto chain
Test 377e: Add pedit action with RAW_OP offset u32
Test a0ca: Add pedit action with RAW_OP offset u32 (INVALID)
Test dd8a: Add pedit action with RAW_OP offset u16 u16
Test 53db: Add pedit action with RAW_OP offset u16 (INVALID)
Test 5c7e: Add pedit action with RAW_OP offset u8 add value
Test 2893: Add pedit action with RAW_OP offset u8 quad
Test 3a07: Add pedit action with RAW_OP offset u8-u16-u8
Test ab0f: Add pedit action with RAW_OP offset u16-u8-u8
Test 9d12: Add pedit action with RAW_OP offset u32 set u16 clear u8 invert
Test ebfa: Add pedit action with RAW_OP offset overflow u32 (INVALID)
Test f512: Add pedit action with RAW_OP offset u16 at offmask shift set
Test c2cb: Add pedit action with RAW_OP offset u32 retain value
Test 1762: Add pedit action with RAW_OP offset u8 clear value
Test bcee: Add pedit action with RAW_OP offset u8 retain value
Test e89f: Add pedit action with RAW_OP offset u16 retain value
Test c282: Add pedit action with RAW_OP offset u32 clear value
Test c422: Add pedit action with RAW_OP offset u16 invert value
Test d3d3: Add pedit action with RAW_OP offset u32 invert value
Test 57e5: Add pedit action with RAW_OP offset u8 preserve value
Test 99e0: Add pedit action with RAW_OP offset u16 preserve value
Test 1892: Add pedit action with RAW_OP offset u32 preserve value
Test 4b60: Add pedit action with RAW_OP negative offset u16/u32 set value
Test a5a7: Add pedit action with LAYERED_OP eth set src
Test 86d4: Add pedit action with LAYERED_OP eth set src & dst
Test f8a9: Add pedit action with LAYERED_OP eth set dst
Test c715: Add pedit action with LAYERED_OP eth set src (INVALID)
Test 8131: Add pedit action with LAYERED_OP eth set dst (INVALID)
Test ba22: Add pedit action with LAYERED_OP eth type set/clear sequence
Test dec4: Add pedit action with LAYERED_OP eth set type (INVALID)
Test ab06: Add pedit action with LAYERED_OP eth add type
Test 918d: Add pedit action with LAYERED_OP eth invert src
Test a8d4: Add pedit action with LAYERED_OP eth invert dst
Test ee13: Add pedit action with LAYERED_OP eth invert type
Test 7588: Add pedit action with LAYERED_OP ip set src
Test 0fa7: Add pedit action with LAYERED_OP ip set dst
Test 5810: Add pedit action with LAYERED_OP ip set src & dst
Test 1092: Add pedit action with LAYERED_OP ip set ihl & dsfield
Test 02d8: Add pedit action with LAYERED_OP ip set ttl & protocol
Test 3e2d: Add pedit action with LAYERED_OP ip set ttl (INVALID)
Test 31ae: Add pedit action with LAYERED_OP ip ttl clear/set
Test 486f: Add pedit action with LAYERED_OP ip set duplicate fields
Test e790: Add pedit action with LAYERED_OP ip set ce, df, mf, firstfrag, nofrag fields
Test cc8a: Add pedit action with LAYERED_OP ip set tos
Test 7a17: Add pedit action with LAYERED_OP ip set precedence
Test c3b6: Add pedit action with LAYERED_OP ip add tos
Test 43d3: Add pedit action with LAYERED_OP ip add precedence
Test 438e: Add pedit action with LAYERED_OP ip clear tos
Test 6b1b: Add pedit action with LAYERED_OP ip clear precedence
Test 824a: Add pedit action with LAYERED_OP ip invert tos
Test 106f: Add pedit action with LAYERED_OP ip invert precedence
Test 6829: Add pedit action with LAYERED_OP beyond ip set dport & sport
Test afd8: Add pedit action with LAYERED_OP beyond ip set icmp_type & icmp_code
Test 3143: Add pedit action with LAYERED_OP beyond ip set dport (INVALID)
Test 815c: Add pedit action with LAYERED_OP ip6 set src
Test 4dae: Add pedit action with LAYERED_OP ip6 set dst
Test fc1f: Add pedit action with LAYERED_OP ip6 set src & dst
Test 6d34: Add pedit action with LAYERED_OP ip6 dst retain value (INVALID)
Test 94bb: Add pedit action with LAYERED_OP ip6 traffic_class
Test 6f5e: Add pedit action with LAYERED_OP ip6 flow_lbl
Test 6795: Add pedit action with LAYERED_OP ip6 set payload_len, nexthdr, hoplimit
Test 1442: Add pedit action with LAYERED_OP tcp set dport & sport
Test b7ac: Add pedit action with LAYERED_OP tcp sport set (INVALID)
Test cfcc: Add pedit action with LAYERED_OP tcp flags set
Test 3bc4: Add pedit action with LAYERED_OP tcp set dport, sport & flags fields
Test f1c8: Add pedit action with LAYERED_OP udp set dport & sport
Test d784: Add pedit action with mixed RAW/LAYERED_OP #1
Test 70ca: Add pedit action with mixed RAW/LAYERED_OP #2
Test 2b11: Add tunnel_key set action with mandatory parameters
Test dc6b: Add tunnel_key set action with missing mandatory src_ip parameter
Test 7f25: Add tunnel_key set action with missing mandatory dst_ip parameter
Test a5e0: Add tunnel_key set action with invalid src_ip parameter
Test eaa8: Add tunnel_key set action with invalid dst_ip parameter
Test 3b09: Add tunnel_key set action with invalid id parameter
Test 9625: Add tunnel_key set action with invalid dst_port parameter
Test 05af: Add tunnel_key set action with optional dst_port parameter
Test da80: Add tunnel_key set action with index at 32-bit maximum
Test d407: Add tunnel_key set action with index exceeding 32-bit maximum
Test 5cba: Add tunnel_key set action with id value at 32-bit maximum
Test e84a: Add tunnel_key set action with id value exceeding 32-bit maximum
Test 9c19: Add tunnel_key set action with dst_port value at 16-bit maximum
Test 3bd9: Add tunnel_key set action with dst_port value exceeding 16-bit maximum
Test 68e2: Add tunnel_key unset action
Test 6192: Add tunnel_key unset continue action
Test 061d: Add tunnel_key set continue action with cookie
Test 8acb: Add tunnel_key set continue action with invalid cookie
Test a07e: Add tunnel_key action with no set/unset command specified
Test b227: Add tunnel_key action with csum option
Test 58a7: Add tunnel_key action with nocsum option
Test 2575: Add tunnel_key action with not-supported parameter
Test 7a88: Add tunnel_key action with cookie parameter
Test 4f20: Add tunnel_key action with a single geneve option parameter
Test e33d: Add tunnel_key action with multiple geneve options parameter
Test 0778: Add tunnel_key action with invalid class geneve option parameter
Test 4ae8: Add tunnel_key action with invalid type geneve option parameter
Test 4039: Add tunnel_key action with short data length geneve option parameter
Test 26a6: Add tunnel_key action with non-multiple of 4 data length geneve option parameter
Test f44d: Add tunnel_key action with incomplete geneve options parameter
Test 7afc: Replace tunnel_key set action with all parameters
Test 364d: Replace tunnel_key set action with all parameters and cookie
Test 937c: Fetch all existing tunnel_key actions
Test 6783: Flush all existing tunnel_key actions
Test 8242: Replace tunnel_key set action with invalid goto chain
Test 0cd2: Add tunnel_key set action with no_percpu flag
Test 3671: Delete tunnel_key set action with valid index
Test 8597: Delete tunnel_key set action with invalid index
Test 6bda: Add tunnel_key action with nofrag option
Test 7682: Create valid ife encode action with mark and pass control
Test ef47: Create valid ife encode action with mark and pipe control
Test df43: Create valid ife encode action with mark and continue control
Test e4cf: Create valid ife encode action with mark and drop control
Test ccba: Create valid ife encode action with mark and reclassify control
Test a1cf: Create valid ife encode action with mark and jump control
Test cb3d: Create valid ife encode action with mark value at 32-bit maximum
Test 1efb: Create ife encode action with mark value exceeding 32-bit maximum
Test 95ed: Create valid ife encode action with prio and pass control
Test aa17: Create valid ife encode action with prio and pipe control
Test 74c7: Create valid ife encode action with prio and continue control
Test 7a97: Create valid ife encode action with prio and drop control
Test f66b: Create valid ife encode action with prio and reclassify control
Test 3056: Create valid ife encode action with prio and jump control
Test 7dd3: Create valid ife encode action with prio value at 32-bit maximum
Test 2ca1: Create ife encode action with prio value exceeding 32-bit maximum
Test 05bb: Create valid ife encode action with tcindex and pass control
Test ce65: Create valid ife encode action with tcindex and pipe control
Test 09cd: Create valid ife encode action with tcindex and continue control
Test 8eb5: Create valid ife encode action with tcindex and continue control
Test 451a: Create valid ife encode action with tcindex and drop control
Test d76c: Create valid ife encode action with tcindex and reclassify control
Test e731: Create valid ife encode action with tcindex and jump control
Test b7b8: Create valid ife encode action with tcindex value at 16-bit maximum
Test d0d8: Create ife encode action with tcindex value exceeding 16-bit maximum
Test 2a9c: Create valid ife encode action with mac src parameter
Test cf5c: Create valid ife encode action with mac dst parameter
Test 2353: Create valid ife encode action with mac src and mac dst parameters
Test 552c: Create valid ife encode action with mark and type parameters
Test 0421: Create valid ife encode action with prio and type parameters
Test 4017: Create valid ife encode action with tcindex and type parameters
Test fac3: Create valid ife encode action with index at 32-bit maximum
Test 7c25: Create valid ife decode action with pass control
Test dccb: Create valid ife decode action with pipe control
Test 7bb9: Create valid ife decode action with continue control
Test d9ad: Create valid ife decode action with drop control
Test 219f: Create valid ife decode action with reclassify control
Test 8f44: Create valid ife decode action with jump control
Test 56cf: Create ife encode action with index exceeding 32-bit maximum
Test ee94: Create ife encode action with invalid control
Test b330: Create ife encode action with cookie
Test bbc0: Create ife encode action with invalid argument
Test d54a: Create ife encode action with invalid type argument
Test 7ee0: Create ife encode action with invalid mac src argument
Test 0a7d: Create ife encode action with invalid mac dst argument
Test a0e2: Replace ife encode action with invalid goto chain control
Test a972: Delete ife encode action with valid index
Test 1272: Delete ife encode action with invalid index
Test 6236: Add skbedit action with valid mark
Test c8cf: Add skbedit action with 32-bit maximum mark
Test 407b: Add skbedit action with mark exceeding 32-bit maximum
Test d4cd: Add skbedit action with valid mark and mask
Test baa7: Add skbedit action with valid mark and 32-bit maximum mask
Test 62a5: Add skbedit action with valid mark and mask exceeding 32-bit maximum
Test bc15: Add skbedit action with valid mark and mask with invalid format
Test 57c2: Replace skbedit action with new mask
Test 081d: Add skbedit action with priority
Test cc37: Add skbedit action with invalid priority
Test 3c95: Add skbedit action with queue_mapping
Test 985c: Add skbedit action with queue_mapping exceeding 16-bit maximum
Test 224f: Add skbedit action with ptype host
Test d1a3: Add skbedit action with ptype otherhost
Test b9c6: Add skbedit action with invalid ptype
Test 464a: Add skbedit action with control pipe
Test 212f: Add skbedit action with control reclassify
Test 0651: Add skbedit action with control pass
Test cc53: Add skbedit action with control drop
Test ec16: Add skbedit action with control jump
Test db54: Add skbedit action with control continue
Test 1055: Add skbedit action with cookie
Test 5172: List skbedit actions
Test a6d6: Add skbedit action with index at 32-bit maximum
Test f0f4: Add skbedit action with index exceeding 32-bit maximum
Test 38f3: Delete skbedit action
Test ce97: Flush skbedit actions
Test 1b2b: Replace skbedit action with invalid goto_chain control
Test 630c: Add batch of 32 skbedit actions with all parameters and cookie
Test 706d: Delete batch of 32 skbedit actions with all parameters
Test e89a: Add valid pass action
Test a02c: Add valid pipe action
Test feef: Add valid reclassify action
Test 8a7a: Add valid drop action
Test 9a52: Add valid continue action
Test d700: Add invalid action
Test 9215: Add action with duplicate index
Test 798e: Add action with index exceeding 32-bit maximum
Test 22be: Add action with index at 32-bit maximum
Test ac2a: List actions
Test 3edf: Flush gact actions
Test 63ec: Delete pass action
Test 46be: Delete pipe action
Test 2e08: Delete reclassify action
Test 99c4: Delete drop action
Test fb6b: Delete continue action
Test 0eb3: Delete non-existent action
Test f02c: Replace gact action
Test 525f: Get gact action by index
Test 1021: Add batch of 32 gact pass actions
Test da7a: Add batch of 32 gact continue actions with cookie
Test 8aa3: Delete batch of 32 gact continue actions
Test 8e47: Add gact action with random determ goto chain control action
Test ca89: Replace gact action with invalid goto chain control
Test 95ad: Add gact pass action with no_percpu flag
Test 7f52: Try to flush action which is referenced by filter
Test ae1e: Try to flush actions when last one is referenced by filter
Test d959: Add cBPF action with valid bytecode
Test f84a: Add cBPF action with invalid bytecode
Test e939: Add eBPF action with valid object-file
Test 282d: Add eBPF action with invalid object-file
Test d819: Replace cBPF bytecode and action control
Test 6ae3: Delete cBPF action
Test 3e0d: List cBPF actions
Test 55ce: Flush BPF actions
Test ccc3: Add cBPF action with duplicate index
Test 89c7: Add cBPF action with invalid index
Test 7ab9: Add cBPF action with cookie
Test b8a1: Replace bpf action with invalid goto_chain control
Test 2002: Add valid connmark action with defaults
Test 56a5: Add valid connmark action with control pass
Test 7c66: Add valid connmark action with control drop
Test a913: Add valid connmark action with control pipe
Test bdd8: Add valid connmark action with control reclassify
Test b8be: Add valid connmark action with control continue
Test d8a6: Add valid connmark action with control jump
Test aae8: Add valid connmark action with zone argument
Test 2f0b: Add valid connmark action with invalid zone argument
Test 9305: Add connmark action with unsupported argument
Test 71ca: Add valid connmark action and replace it
Test 5f8f: Add valid connmark action with cookie
Test c506: Replace connmark with invalid goto chain control
Test 6571: Delete connmark action with valid index
Test 3426: Delete connmark action with invalid index
Test 7d50: Add skbmod action to set destination mac
Test 9b29: Add skbmod action to set source mac
Test 1724: Add skbmod action with invalid mac
Test 3cf1: Add skbmod action with valid etype
Test a749: Add skbmod action with invalid etype
Test bfe6: Add skbmod action to swap mac
Test 839b: Add skbmod action with control pipe
Test c167: Add skbmod action with control reclassify
Test 0c2f: Add skbmod action with control drop
Test d113: Add skbmod action with control continue
Test 7242: Add skbmod action with control pass
Test 6046: Add skbmod action with control reclassify and cookie
Test 58cb: List skbmod actions
Test 9aa8: Get a single skbmod action from a list
Test e93a: Delete an skbmod action
Test 40c2: Flush skbmod actions
Test b651: Replace skbmod action with invalid goto_chain control
Test fe09: Add skbmod action to mark ECN bits
Test 6d84: Add csum iph action
Test 1862: Add csum ip4h action
Test 15c6: Add csum ipv4h action
Test bf47: Add csum icmp action
Test cc1d: Add csum igmp action
Test bccc: Add csum foobar action
Test 3bb4: Add csum tcp action
Test 759c: Add csum udp action
Test bdb6: Add csum udp xor iph action
Test c220: Add csum udplite action
Test 8993: Add csum sctp action
Test b138: Add csum ip & icmp action
Test eeda: Add csum ip & sctp action
Test 0017: Add csum udp or tcp action
Test b10b: Add all 7 csum actions
Test ce92: Add csum udp action with cookie
Test 912f: Add csum icmp action with large cookie
Test 879b: Add batch of 32 csum tcp actions
Test b4e9: Delete batch of 32 csum actions
Test 0015: Add batch of 32 csum tcp actions with large cookies
Test 989e: Delete batch of 32 csum actions with large cookies
Test d128: Replace csum action with invalid goto chain control
Test eaf0: Add csum iph action with no_percpu flag
Test c826: Add ctinfo action with default setting
Test 0286: Add ctinfo action with dscp
Test 4938: Add ctinfo action with valid cpmark and zone
Test 7593: Add ctinfo action with drop control
Test 2961: Replace ctinfo action zone and action control
Test e567: Delete ctinfo action with valid index
Test 6a91: Delete ctinfo action with invalid index
Test 5232: List ctinfo actions
Test 7702: Flush ctinfo actions
Test 3201: Add ctinfo action with duplicate index
Test 8295: Add ctinfo action with invalid index
Test 3964: Replace ctinfo action with invalid goto_chain control
Test 696a: Add simple ct action
Test e38c: Add simple ct action with cookie
Test 9f20: Add ct clear action
Test 0bc1: Add ct clear action with cookie of max length
Test 5bea: Try ct with zone
Test d5d6: Try ct with zone, commit
Test 029f: Try ct with zone, commit, mark
Test a58d: Try ct with zone, commit, mark, nat
Test 901b: Try ct with full nat ipv4 range syntax
Test 072b: Try ct with full nat ipv6 syntax
Test 3420: Try ct with full nat ipv6 range syntax
Test 4470: Try ct with full nat ipv6 range syntax + force
Test 5d88: Try ct with label
Test 04d4: Try ct with label with mask
Test 9751: Try ct with mark + mask
Test 2faa: Try ct with mark + mask and cookie
Test 3991: Add simple ct action with no_percpu flag
Test 3992: Add ct action triggering DNAT tuple conflict
[  515.492083] v0p0id3992: entered promiscuous mode
WARNING: No route found (no default route?)
WARNING: No route found (no default[  515.596668] v0p0id3992: left promiscuous mode
 route?)
.
Sent 1 packets.
[  515.629639] v0p0id3992: entered promiscuous mode
WARNING: more No route found (no default route?)
.
Sent 1 packets.[  515.682169] v0p0id3992: left promiscuous mode

Test 6f5a: Add vlan pop action with pipe opcode
Test df35: Add vlan pop action with pass opcode
Test b0d4: Add vlan pop action with drop opcode
Test 95ee: Add vlan pop action with reclassify opcode
Test 0283: Add vlan pop action with continue opcode
Test b6b9: Add vlan pop action with jump opcode
Test 87c3: Add vlan pop action with trap opcode
Test a178: Add vlan pop action with invalid opcode
Test ee6f: Add vlan pop action with index at 32-bit maximum
Test 0dfa: Add vlan pop action with index exceeding 32-bit maximum
Test 2b91: Add vlan invalid action
Test 57fc: Add vlan push action with invalid protocol type
Test 3989: Add vlan push action with default protocol and priority
Test 79dc: Add vlan push action with protocol 802.1Q and priority 3
Test 4d73: Add vlan push action with protocol 802.1AD
Test 1f4b: Add vlan push action with maximum 12-bit vlan ID
Test 1f7b: Add vlan push action with invalid vlan ID
Test fe40: Add vlan push action with maximum 3-bit IEEE 802.1p priority
Test 5d02: Add vlan push action with invalid IEEE 802.1p priority
Test ba5b: Add vlan modify action for protocol 802.1Q setting priority 0
Test 6812: Add vlan modify action for protocol 802.1Q
Test 5a31: Add vlan modify action for protocol 802.1AD
Test 3deb: Replace existing vlan push action with new ID
Test 9e76: Replace existing vlan push action with new protocol
Test ede4: Replace existing vlan push action with new priority
Test d413: Replace existing vlan pop action with new cookie
Test 83a4: Delete vlan pop action
Test ed1e: Delete vlan push action for protocol 802.1Q
Test a2a3: Flush vlan actions
Test 1d78: Add vlan push action with cookie
Test e394: Replace vlan push action with invalid goto chain control
Test 294e: Add batch of 32 vlan push actions with cookie
Test 56f7: Delete batch of 32 vlan push actions
Test 759f: Add batch of 32 vlan pop actions with cookie
Test c84a: Delete batch of 32 vlan pop actions
Test 1a3d: Add vlan pop action with no_percpu flag
Test 7565: Add nat action on ingress with default control action
Test fd79: Add nat action on ingress with pipe control action
Test eab9: Add nat action on ingress with continue control action
Test c53a: Add nat action on ingress with reclassify control action
Test 76c9: Add nat action on ingress with jump control action
Test 24c6: Add nat action on ingress with drop control action
Test 2120: Add nat action on ingress with maximum index value
Test 3e9d: Add nat action on ingress with invalid index value
Test f6c9: Add nat action on ingress with invalid IP address
Test be25: Add nat action on ingress with invalid argument
Test a7bd: Add nat action on ingress with DEFAULT IP address
Test ee1e: Add nat action on ingress with ANY IP address
Test 1de8: Add nat action on ingress with ALL IP address
Test 8dba: Add nat action on egress with default control action
Test 19a7: Add nat action on egress with pipe control action
Test f1d9: Add nat action on egress with continue control action
Test 6d4a: Add nat action on egress with reclassify control action
Test b313: Add nat action on egress with jump control action
Test d9fc: Add nat action on egress with drop control action
Test a895: Add nat action on egress with DEFAULT IP address
Test 2572: Add nat action on egress with ANY IP address
Test 37f3: Add nat action on egress with ALL IP address
Test 6054: Add nat action on egress with cookie
Test 79d6: Add nat action on ingress with cookie
Test 4b12: Replace nat action with invalid goto chain control
Test b811: Delete nat action with valid index
Test a521: Delete nat action with invalid index
Test 9784: Add valid sample action with mandatory arguments
Test 5c91: Add valid sample action with mandatory arguments and continue control action
Test 334b: Add valid sample action with mandatory arguments and drop control action
Test da69: Add valid sample action with mandatory arguments and reclassify control action
Test 13ce: Add valid sample action with mandatory arguments and pipe control action
Test 1886: Add valid sample action with mandatory arguments and jump control action
Test 7571: Add sample action with invalid rate
Test b6d4: Add sample action with mandatory arguments and invalid control action
Test a874: Add invalid sample action without mandatory arguments
Test ac01: Add invalid sample action without mandatory argument rate
Test 4203: Add invalid sample action without mandatory argument group
Test 14a7: Add invalid sample action without mandatory argument group
Test 8f2e: Add valid sample action with trunc argument
Test 45f8: Add sample action with maximum rate argument
Test ad0c: Add sample action with maximum trunc argument
Test 83a9: Add sample action with maximum group argument
Test ed27: Add sample action with invalid rate argument
Test 2eae: Add sample action with invalid group argument
Test 6ff3: Add sample action with invalid trunc size
Test 2b2a: Add sample action with invalid index
Test dee2: Add sample action with maximum allowed index
Test 560e: Add sample action with cookie
Test 704a: Replace existing sample action with new rate argument
Test 60eb: Replace existing sample action with new group argument
Test 2cce: Replace existing sample action with new trunc argument
Test 59d1: Replace existing sample action with new control argument
Test 0a6e: Replace sample action with invalid goto chain control
Test 3872: Delete sample action with valid index
Test a394: Delete sample action with invalid index
Test 49aa: Add valid basic police action
Test 3abe: Add police action with duplicate index
Test 49fa: Add valid police action with mtu
Test 7943: Add valid police action with peakrate
Test 055e: Add police action with peakrate and no mtu
Test f057: Add police action with valid overhead
Test 7ffb: Add police action with ethernet linklayer type
Test 3dda: Add police action with atm linklayer type
Test 551b: Add police actions with conform-exceed control continue/drop
Test 0c70: Add police actions with conform-exceed control pass/reclassify
Test d946: Add police actions with conform-exceed control pass/pipe
Test ddd6: Add police action with invalid rate value
Test f61c: Add police action with invalid burst value
Test 6aaf: Add police actions with conform-exceed control pass/pipe [with numeric values]
Test 29b1: Add police actions with conform-exceed control <invalid>/drop
Test c26f: Add police action with invalid peakrate value
Test db04: Add police action with invalid mtu value
Test f3c9: Add police action with cookie
Test d190: Add police action with maximum index
Test 336e: Delete police action
Test 77fa: Get single police action from many actions
Test aa43: Get single police action without specifying index
Test 858b: List police actions
Test 1c3a: Flush police actions
Test 7326: Add police action with control continue
Test 34fa: Add police action with control drop
Test 8dd5: Add police action with control ok
Test b9d1: Add police action with control reclassify
Test c534: Add police action with control pipe
Test b48b: Add police action with exceed goto chain control action
Test 689e: Replace police action with invalid goto chain control
Test cdd7: Add valid police action with packets per second rate limit
Test f5bc: Add invalid police action with both bps and pps
Test 7d64: Add police action with skip_hw option
Test b078: Add simple action
Test 4297: Add simple action with change command
Test 6d4c: Add simple action with duplicate index
Test 2542: List simple actions
Test ea67: Delete simple action
Test 8ff1: Flush simple actions
Test b776: Replace simple action with invalid goto chain control
Test 8d07: Verify cleanup of failed actions batch add
Test a68a: Verify cleanup of failed actions batch change
Test a933: Add MPLS dec_ttl action with pipe opcode
Test 08d1: Add mpls dec_ttl action with pass opcode
Test d786: Add mpls dec_ttl action with drop opcode
Test f334: Add mpls dec_ttl action with reclassify opcode
Test 29bd: Add mpls dec_ttl action with continue opcode
Test 48df: Add mpls dec_ttl action with jump opcode
Test 62eb: Add mpls dec_ttl action with trap opcode
Test 09d2: Add mpls dec_ttl action with opcode and cookie
Test c170: Add mpls dec_ttl action with opcode and cookie of max length
Test 9118: Add mpls dec_ttl action with invalid opcode
Test 6ce1: Add mpls dec_ttl action with label (invalid)
Test 352f: Add mpls dec_ttl action with tc (invalid)
Test fa1c: Add mpls dec_ttl action with ttl (invalid)
Test 6b79: Add mpls dec_ttl action with bos (invalid)
Test d4c4: Add mpls pop action with ip proto
Test 91fb: Add mpls pop action with ip proto and cookie
Test 92fe: Add mpls pop action with mpls proto
Test 7e23: Add mpls pop action with no protocol (invalid)
Test 6182: Add mpls pop action with label (invalid)
Test 6475: Add mpls pop action with tc (invalid)
Test 067b: Add mpls pop action with ttl (invalid)
Test 7316: Add mpls pop action with bos (invalid)
Test 38cc: Add mpls push action with label
Test c281: Add mpls push action with mpls_mc protocol
Test 5db4: Add mpls push action with label, tc and ttl
Test 7c34: Add mpls push action with label, tc ttl and cookie of max length
Test 16eb: Add mpls push action with label and bos
Test d69d: Add mpls push action with no label (invalid)
Test e8e4: Add mpls push action with ipv4 protocol (invalid)
Test ecd0: Add mpls push action with out of range label (invalid)
Test d303: Add mpls push action with out of range tc (invalid)
Test fd6e: Add mpls push action with ttl of 0 (invalid)
Test 19e9: Add mpls mod action with mpls label
Test 1fde: Add mpls mod action with max mpls label
Test 0c50: Add mpls mod action with mpls label exceeding max (invalid)
Test 10b6: Add mpls mod action with mpls label of MPLS_LABEL_IMPLNULL (invalid)
Test 57c9: Add mpls mod action with mpls min tc
Test 6872: Add mpls mod action with mpls max tc
Test a70a: Add mpls mod action with mpls tc exceeding max (invalid)
Test 6ed5: Add mpls mod action with mpls ttl
Test 77c1: Add mpls mod action with mpls ttl and cookie
Test b80f: Add mpls mod action with mpls max ttl
Test 8864: Add mpls mod action with mpls min ttl
Test 6c06: Add mpls mod action with mpls ttl of 0 (invalid)
Test b5d8: Add mpls mod action with mpls ttl exceeding max (invalid)
Test 451f: Add mpls mod action with mpls max bos
Test a1ed: Add mpls mod action with mpls min bos
Test 3dcf: Add mpls mod action with mpls bos exceeding max (invalid)
Test db7c: Add mpls mod action with protocol (invalid)
Test b070: Replace existing mpls push action with new ID
Test 95a9: Replace existing mpls push action with new label, tc, ttl and cookie
Test 6cce: Delete mpls pop action
Test d138: Flush mpls actions
Test 5153: Add gate action with priority and sched-entry
Test 7189: Add gate action with base-time
Test a721: Add gate action with cycle-time
Test c029: Add gate action with cycle-time-ext
Test 3719: Replace gate base-time action
Test d821: Delete gate action with valid index
Test 3128: Delete gate action with invalid index
Test 7837: List gate actions
Test 9273: Flush gate actions
Test c829: Add gate action with duplicate index
Test 3043: Add gate action with invalid index
Test 2930: Add gate action with cookie
Test 5124: Add mirred mirror to egress action
Test 6fb4: Add mirred redirect to egress action
Test ba38: Get mirred actions
Test d7c0: Add invalid mirred direction
Test e213: Add invalid mirred action
Test 2d89: Add mirred action with invalid device
Test 300b: Add mirred action with duplicate index
Test 8917: Add mirred mirror action with control pass
Test 1054: Add mirred mirror action with control pipe
Test 9887: Add mirred mirror action with control continue
Test e4aa: Add mirred mirror action with control reclassify
Test ece9: Add mirred mirror action with control drop
Test 0031: Add mirred mirror action with control jump
Test 407c: Add mirred mirror action with cookie
Test 8b69: Add mirred mirror action with index at 32-bit maximum
Test 3f66: Add mirred mirror action with index exceeding 32-bit maximum
Test a70e: Delete mirred mirror action
Test 3fb3: Delete mirred redirect action
Test 2a9a: Replace mirred action with invalid goto chain control
Test 4749: Add batch of 32 mirred redirect egress actions with cookie
Test 5c69: Delete batch of 32 mirred redirect egress actions
Test d3c0: Add batch of 32 mirred mirror ingress actions with cookie
Test e684: Delete batch of 32 mirred mirror ingress actions
Test 31e3: Add mirred mirror to egress action with no_percpu flag
Test 456d: Add mirred mirror to egress block action
Test 2358: Add mirred mirror to ingress block action
Test fdb1: Add mirred redirect to egress block action
Test 20cc: Add mirred redirect to ingress block action
Test e739: Try to add mirred action with both dev and block
Test 2f47: Try to add mirred action without specifying neither dev nor block
Test 3188: Replace mirred redirect to dev action with redirect to block
Test 83cc: Replace mirred redirect to block action with mirror to dev
Test c2b4: Soft lockup alarm will be not generated after delete the prio 0 filter of the chain
Test abdc: Reference pedit action object in filter
Test 7a70: Reference mpls action object in filter
Test d241: Reference bpf action object in filter
Test 383a: Reference connmark action object in filter
Test c619: Reference csum action object in filter
Test a93d: Reference ct action object in filter
Test 8bb5: Reference ctinfo action object in filter
Test 2241: Reference gact action object in filter
Test 35e9: Reference gate action object in filter
Test b22e: Reference ife action object in filter
Test ef74: Reference mirred action object in filter
Test 2c81: Reference nat action object in filter
Test ac9d: Reference police action object in filter
Test 68be: Reference sample action object in filter
Test cf01: Reference skbedit action object in filter
Test c109: Reference skbmod action object in filter
Test 4abc: Reference tunnel_key action object in filter
Test dadd: Reference vlan action object in filter
Test 0582: Create QFQ with default setting
Test c9a3: Create QFQ with class weight setting
Test d364: Test QFQ with max class weight setting
Test 8452: Create QFQ with class maxpkt setting
Test 22df: Test QFQ class maxpkt setting lower bound
Test 92ee: Test QFQ class maxpkt setting upper bound
Test d920: Create QFQ with multiple class setting
Test 0548: Delete QFQ with handle
Test 5901: Show QFQ class
Test 85ee: QFQ with big MTU
Test ddfa: QFQ with small MTU
Test 5993: QFQ with stab overhead greater than max packet len
[  638.656129] v0p0id5993: entered promiscuous mode
WARNING: No route found (no default route?)
WARNING: No route f[  638.701968] v0p0id5993: left promiscuous mode
ound (no default route?)
.
Sent 1 packets.
[  638.736981] v0p0id5993: entered promiscuous mode
WARNING: more No route found (no default route?)
.
Sent 1 packets[  638.777954] v0p0id5993: left promiscuous mode
.
[  638.812953] v0p0id5993: entered promiscuous mode
.
Sent 1 packets.[  638.849813] v0p0id5993: left promiscuous mode

[  638.884963] v0p0id5993: entered promiscuous mode
.
Sent 1 packets.[  638.925612] v0p0id5993: left promiscuous mode

[  638.953133] v0p0id5993: entered promiscuous mode
.
[  638.985367] v0p0id5993: left promiscuous mode

[  639.020353] v0p0id5993: entered promiscuous mode
.
Sent 1 packets[  639.060436] v0p0id5993: left promiscuous mode
.
[  639.089161] v0p0id5993: entered promiscuous mode
.
[  639.129532] v0p0id5993: left promiscuous mode

[  639.156947] v0p0id5993: entered promiscuous mode
.
[  639.197584] v0p0id5993: left promiscuous mode

[  639.233167] v0p0id5993: entered promiscuous mode
.
[  639.273817] v0p0id5993: left promiscuous mode

[  639.305446] v0p0id5993: entered promiscuous mode
.
Sent 1 packets[  639.341676] v0p0id5993: left promiscuous mode
.
[  639.376899] v0p0id5993: entered promiscuous mode
.
Sent 1 packets[  639.417500] v0p0id5993: left promiscuous mode
.
[  639.452899] v0p0id5993: entered promiscuous mode
.
Sent 1 packets[  639.493230] v0p0id5993: left promiscuous mode
.
[  639.521279] v0p0id5993: entered promiscuous mode
.
Sent 1 packets[  639.557434] v0p0id5993: left promiscuous mode
.
[  639.589209] v0p0id5993: entered promiscuous mode
.
[  639.632315] v0p0id5993: left promiscuous mode

[  639.664945] v0p0id5993: entered promiscuous mode
.
Sent 1 packets.[  639.705542] v0p0id5993: left promiscuous mode

[  639.740942] v0p0id5993: entered promiscuous mode
.
Sent 1 packets.[  639.781674] v0p0id5993: left promiscuous mode

[  639.816944] v0p0id5993: entered promiscuous mode
.
Sent 1 packets[  639.860440] v0p0id5993: left promiscuous mode
.
[  639.888903] v0p0id5993: entered promiscuous mode
.
Sent 1 packets[  639.930304] v0p0id5993: left promiscuous mode
.
[  639.965205] v0p0id5993: entered promiscuous mode
.
Sent 1 packets[  640.004225] v0p0id5993: left promiscuous mode
.
[  640.033184] v0p0id5993: entered promiscuous mode
.
[  640.072225] v0p0id5993: left promiscuous mode

[  640.097321] v0p0id5993: entered promiscuous mode
.
Sent 1 packets[  640.144250] v0p0id5993: left promiscuous mode
.
[  640.176907] v0p0id5993: entered promiscuous mode
.
Sent 1 packets[  640.217326] v0p0id5993: left promiscuous mode
.
Test 0385: Create DRR with default setting
Test 2375: Delete DRR with handle
Test 3092: Show DRR class
Test 9903: Add mqprio Qdisc to multi-queue device (8 queues)
Test 453a: Delete nonexistent mqprio Qdisc
Test 5292: Delete mqprio Qdisc twice
Test 45a9: Add mqprio Qdisc to single-queue device
Test 2ba9: Show mqprio class
Test 4812: Create HHF with default setting
Test 8a92: Create HHF with limit setting
Test 3491: Create HHF with quantum setting
Test ba04: Create HHF with reset_timeout setting
Test 4238: Create HHF with admit_bytes setting
Test 839f: Create HHF with evict_timeout setting
Test a044: Create HHF with non_hh_weight setting
Test 32f9: Change HHF with limit setting
Test 385e: Show HHF class
Test 7482: Create SFQ with default setting
Test c186: Create SFQ with limit setting
Test ae23: Create SFQ with perturb setting
Test a430: Create SFQ with quantum setting
Test 4539: Create SFQ with divisor setting
Test b089: Create SFQ with flows setting
Test 99a0: Create SFQ with depth setting
Test 7389: Create SFQ with headdrop setting
Test 6472: Create SFQ with redflowlimit setting
Test 8929: Show SFQ class
Test 0904: Create HTB with default setting
Test 3906: Create HTB with default-N setting
Test 8492: Create HTB with r2q setting
Test 9502: Create HTB with direct_qlen setting
Test b924: Create HTB with class rate and burst setting
Test 4359: Create HTB with class mpu setting
Test 9048: Create HTB with class prio setting
Test 4994: Create HTB with class ceil setting
Test 9523: Create HTB with class cburst setting
Test 5353: Create HTB with class mtu setting
Test 346a: Create HTB with class quantum setting
Test 303a: Delete HTB with handle
Test e90e: Add ETS qdisc using bands
Test b059: Add ETS qdisc using quanta
Test e8e7: Add ETS qdisc using strict
Test 233c: Add ETS qdisc using bands + quanta
Test 3d35: Add ETS qdisc using bands + strict
Test 7f3b: Add ETS qdisc using strict + quanta
Test 4593: Add ETS qdisc using strict 0 + quanta
Test 8938: Add ETS qdisc using bands + strict + quanta
Test 0782: Add ETS qdisc with more bands than quanta
Test 501b: Add ETS qdisc with more bands than strict
Test 671a: Add ETS qdisc with more bands than strict + quanta
Test 2a23: Add ETS qdisc with 16 bands
Test 8daf: Add ETS qdisc with 17 bands
Test 7f95: Add ETS qdisc with 17 strict
Test 837a: Add ETS qdisc with 16 quanta
Test 65b6: Add ETS qdisc with 17 quanta
Test b9e9: Add ETS qdisc with 16 strict + quanta
Test 9877: Add ETS qdisc with 17 strict + quanta
Test c696: Add ETS qdisc with priomap
Test 30c4: Add ETS qdisc with quanta + priomap
Test e8ac: Add ETS qdisc with strict + priomap
Test 5a7e: Add ETS qdisc with quanta + strict + priomap
Test cb8b: Show ETS class :1
Test 1b4e: Show ETS class :2
Test f642: Show ETS class :3
Test 0a5f: Show ETS strict class
Test f7c8: Add ETS qdisc with too many quanta
Test 2389: Add ETS qdisc with too many strict
Test fe3c: Add ETS qdisc with too many strict + quanta
Test cb04: Add ETS qdisc with excess priomap elements
Test c32e: Add ETS qdisc with priomap above bands
Test 744c: Add ETS qdisc with priomap above quanta
Test 7b33: Add ETS qdisc with priomap above strict
Test dbe6: Add ETS qdisc with priomap above strict + quanta
Test bdb2: Add ETS qdisc with priomap within bands with strict + quanta
Test 39a3: Add ETS qdisc with priomap above bands with strict + quanta
Test 557c: Unset priorities default to the last band
Test a347: Unset priorities default to the last band -- no priomap
Test 39c4: Add ETS qdisc with too few bands
Test 930b: Add ETS qdisc with too many bands
Test 406a: Add ETS qdisc without parameters
Test e51a: Zero element in quanta
Test e7f2: Sole zero element in quanta
Test d6e6: No values after the quanta keyword
Test 28c6: Change ETS band quantum
Test 4714: Change ETS band without quantum
Test 6979: Change quantum of a strict ETS band
Test 9a7d: Change ETS strict band without quantum
Test 34ba: Create ETF with default setting
Test 438f: Create ETF with delta nanos setting
Test 9041: Create ETF with deadline_mode setting
Test 9a0c: Create ETF with skip_sock_check setting
Test 2093: Delete ETF with valid handle
Test 84a0: Create TEQL with default setting
Test 7734: Create TEQL with multiple device
Test 34a9: Delete TEQL with valid handle
Test 6289: Show TEQL stats
Test 6430: Create TBF with default setting
[  688.320698] sch_tbf: burst 1500 is lower than device dummy1id6430 mtu (1514) !
Test 0518: Create TBF with mtu setting
[  688.834123] sch_tbf: burst 1500 is lower than device dummy1id0518 mtu (1514) !
Test 320a: Create TBF with peakrate setting
[  689.356657] sch_tbf: burst 1500 is lower than device dummy1id320a mtu (1514) !
Test 239b: Create TBF with latency setting
[  689.867874] sch_tbf: burst 1500 is lower than device dummy1id239b mtu (1514) !
Test c975: Create TBF with overhead setting
[  690.409268] sch_tbf: burst 1500 is lower than device dummy1idc975 mtu (1514) !
Test 948c: Create TBF with linklayer setting
[  690.932722] sch_tbf: burst 1500 is lower than device dummy1id948c mtu (1514) !
Test 3549: Replace TBF with mtu
[  691.406220] sch_tbf: burst 1500 is lower than device dummy1id3549 mtu (1514) !
[  691.480321] sch_tbf: burst 1500 is lower than device dummy1id3549 mtu (1514) !
Test f948: Change TBF with latency time
[  691.961038] sch_tbf: burst 1500 is lower than device dummy1idf948 mtu (1514) !
[  692.036525] sch_tbf: burst 1500 is lower than device dummy1idf948 mtu (1514) !
Test 2348: Show TBF class
Test 8b6e: Create RED with no flags
Test 342e: Create RED with adaptive flag
Test 2d4b: Create RED with ECN flag
Test 650f: Create RED with flags ECN, adaptive
Test 5f15: Create RED with flags ECN, harddrop
Test 53e8: Create RED with flags ECN, nodrop
Test d091: Fail to create RED with only nodrop flag
Test af8e: Create RED with flags ECN, nodrop, harddrop
Test 290a: Show RED class
Test 1212: Create CAKE with default setting
Test 3281: Create CAKE with bandwidth limit
Test c940: Create CAKE with autorate-ingress flag
Test 2310: Create CAKE with rtt time
Test 2385: Create CAKE with besteffort flag
Test a032: Create CAKE with diffserv8 flag
Test 2349: Create CAKE with diffserv4 flag
Test 8472: Create CAKE with flowblind flag
Test 2341: Create CAKE with dsthost and nat flag
Test 5134: Create CAKE with wash flag
Test 2302: Create CAKE with flowblind and no-split-gso flag
Test 0768: Create CAKE with dual-srchost and ack-filter flag
Test 0238: Create CAKE with dual-dsthost and ack-filter-aggressive flag
Test 6572: Create CAKE with memlimit and ptm flag
Test 2436: Create CAKE with fwmark and atm flag
Test 3984: Create CAKE with overhead and mpu
Test 5421: Create CAKE with conservative and ingress flag
Test 6854: Delete CAKE with conservative and ingress flag
Test 2342: Replace CAKE with mpu
Test 2313: Change CAKE with mpu
Test 4365: Show CAKE class
Test ddd9: Add prio qdisc on egress
Test aa71: Add prio qdisc on egress with handle of maximum value
Test db37: Add prio qdisc on egress with invalid handle exceeding maximum value
Test 39d8: Add prio qdisc on egress with unsupported argument
Test 5769: Add prio qdisc on egress with 4 bands and new priomap
Test fe0f: Add prio qdisc on egress with 4 bands and priomap exceeding TC_PRIO_MAX entries
Test 1f91: Add prio qdisc on egress with 4 bands and priomap's values exceeding bands number
Test d248: Add prio qdisc on egress with invalid bands value (< 2)
Test 1d0e: Add prio qdisc on egress with invalid bands value exceeding TCQ_PRIO_BANDS
Test 1971: Replace default prio qdisc on egress with 8 bands and new priomap
Test d88a: Add duplicate prio qdisc on egress
Test 5948: Delete nonexistent prio qdisc
Test 6c0a: Add prio qdisc on egress with invalid format for handles
Test 0175: Delete prio qdisc twice
Test 2410: Show prio class
Test 8942: Create GRED with default setting
Test 5783: Create GRED with grio setting
Test 8a09: Create GRED with limit setting
Test 48ca: Create GRED with ecn setting
Test 48cb: Create GRED with harddrop setting
Test 763a: Change GRED setting
Test 8309: Show GRED class
Test 3254: Create HFSC with default setting
Test 0289: Create HFSC with class sc and ul rate setting
Test 846a: Create HFSC with class sc umax and dmax setting
Test 5413: Create HFSC with class rt and ls rate setting
Test 9312: Create HFSC with class rt umax and dmax setting
Test 6931: Delete HFSC with handle
Test 8436: Show HFSC class
Test bef4: HFSC rt inner class upgrade to sc
Test 983a: Create CODEL with default setting
Test 38aa: Create CODEL with limit packet setting
Test 9178: Create CODEL with target setting
Test 78d1: Create CODEL with interval setting
Test 238a: Create CODEL with ecn setting
Test 939c: Create CODEL with ce_threshold setting
Test 8380: Delete CODEL with valid handle
Test 289c: Replace CODEL with limit setting
Test 0648: Change CODEL with limit setting
Test 83be: Create FQ-PIE with invalid number of flows
Test 3289: Create PLUG with default setting
Test 0917: Create PLUG with block setting
Test 483b: Create PLUG with release setting
Test 4995: Create PLUG with release_indefinite setting
Test 389c: Create PLUG with limit setting
Test 384a: Delete PLUG with valid handle
Test 439a: Replace PLUG with limit setting
Test 9831: Change PLUG with limit setting
Test 8937: Create CHOKE with default setting
Test 48c0: Create CHOKE with min packet setting
Test 38c1: Create CHOKE with max packet setting
Test 234a: Create CHOKE with ecn setting
Test 4380: Create CHOKE with burst setting
Test 48c7: Delete CHOKE with valid handle
Test 4398: Replace CHOKE with min setting
Test 0301: Change CHOKE with limit setting
Test 3294: Create SFB with default setting
Test 430a: Create SFB with rehash setting
Test 3410: Create SFB with db setting
Test 49a0: Create SFB with limit setting
Test 1241: Create SFB with max setting
Test 3249: Create SFB with target setting
Test 30a9: Create SFB with increment setting
Test 239a: Create SFB with decrement setting
Test 9301: Create SFB with penalty_rate setting
Test 2a01: Create SFB with penalty_burst setting
Test 3209: Change SFB with rehash setting
Test 5447: Show SFB class
Test 900c: Create pfifo_fast with default setting
Test 7470: Dump pfifo_fast stats
Test b974: Replace pfifo_fast with different handle
Test 3240: Delete pfifo_fast with valid handle
Test 4385: Delete pfifo_fast with invalid handle
Test ba39: Add taprio Qdisc to multi-queue device (8 queues)
Test 9462: Add taprio Qdisc with multiple sched-entry
Test 8d92: Add taprio Qdisc with txtime-delay
Test d092: Delete taprio Qdisc with valid handle
Test 8471: Show taprio class
Test 0a85: Add taprio Qdisc to single-queue device
Test 6f62: Add taprio Qdisc with too short interval
Test 831f: Add taprio Qdisc with too short cycle-time
Test 3e1e: Add taprio Qdisc with an invalid cycle-time
Test 39b4: Reject grafting taprio as child qdisc of software taprio
Test e8a1: Reject grafting taprio as child qdisc of offloaded taprio
Test a7bf: Graft cbs as child of software taprio
Test 6a83: Graft cbs as child of offloaded taprio
Test ce7d: Add mq Qdisc to multi-queue device (4 queues)
Test 2f82: Add mq Qdisc to multi-queue device (256 queues)
Test c525: Add duplicate mq Qdisc
Test 128a: Delete nonexistent mq Qdisc
Test 03a9: Delete mq Qdisc twice
Test be0f: Add mq Qdisc to single-queue device
Test 1023: Show mq class
Test 0531: Replace mq with invalid parent ID
Test 20ba: Add multiq Qdisc to multi-queue device (8 queues)
Test 4301: List multiq Class
Test 7832: Delete nonexistent multiq Qdisc
Test 2891: Delete multiq Qdisc twice
Test 1329: Add multiq Qdisc to single-queue device
Test 1820: Create CBS with default setting
Test 1532: Create CBS with hicredit setting
Test 2078: Create CBS with locredit setting
Test 9271: Create CBS with sendslope setting
Test 0482: Create CBS with idleslope setting
Test e8f3: Create CBS with multiple setting
Test 23c9: Replace CBS with sendslope setting
Test a07a: Change CBS with idleslope setting
Test 43b3: Delete CBS with handle
Test 9472: Show CBS class
Test a519: Add bfifo qdisc with system default parameters on egress
Test 585c: Add pfifo qdisc with system default parameters on egress
Test a86e: Add bfifo qdisc with system default parameters on egress with handle of maximum value
Test 9ac8: Add bfifo qdisc on egress with queue size of 3000 bytes
Test f4e6: Add pfifo qdisc on egress with queue size of 3000 packets
Test b1b1: Add bfifo qdisc with system default parameters on egress with invalid handle exceeding maximum value
Test 8d5e: Add bfifo qdisc on egress with unsupported argument
Test 7787: Add pfifo qdisc on egress with unsupported argument
Test c4b6: Replace bfifo qdisc on egress with new queue size
Test 3df6: Replace pfifo qdisc on egress with new queue size
Test 7a67: Add bfifo qdisc on egress with queue size in invalid format
Test 1298: Add duplicate bfifo qdisc on egress
Test 45a0: Delete nonexistent bfifo qdisc
Test 972b: Add prio qdisc on egress with invalid format for handles
Test 4d39: Delete bfifo qdisc twice
Test cb28: Create NETEM with default setting
Test a089: Create NETEM with limit flag
Test 3449: Create NETEM with delay time
Test 3782: Create NETEM with distribution and corrupt flag
Test 2b82: Create NETEM with distribution and duplicate flag
Test a932: Create NETEM with distribution and loss flag
Test e01a: Create NETEM with distribution and loss state flag
Test ba29: Create NETEM with loss gemodel flag
Test 0492: Create NETEM with reorder flag
Test 7862: Create NETEM with rate limit
Test 7235: Create NETEM with multiple slot rate
Test 5439: Create NETEM with multiple slot setting
Test 5029: Change NETEM with loss state
Test 3785: Replace NETEM with delay time
Test 4502: Delete NETEM with handle
Test 0785: Show NETEM class
Test 983b: Create FQ with default setting
Test 38a1: Create FQ with limit packet setting
Test 0a18: Create FQ with flow_limit setting
Test 2390: Create FQ with quantum setting
Test 845b: Create FQ with initial_quantum setting
Test 10f7: Create FQ with invalid initial_quantum setting
Test 9398: Create FQ with maxrate setting
Test 342c: Create FQ with nopacing setting
Test 6391: Create FQ with refill_delay setting
Test 238b: Create FQ with low_rate_threshold setting
Test 7582: Create FQ with orphan_mask setting
Test 4894: Create FQ with timer_slack setting
Test 324c: Create FQ with ce_threshold setting
Test 424a: Create FQ with horizon time setting
Test 89e1: Create FQ with horizon_cap setting
Test 32e1: Delete FQ with valid handle
Test 49b0: Replace FQ with limit setting
Test 9478: Change FQ with limit setting
Test 4957: Create FQ_CODEL with default setting
Test 7621: Create FQ_CODEL with limit setting
Test 6871: Create FQ_CODEL with memory_limit setting
Test 5636: Create FQ_CODEL with target setting
Test 630a: Create FQ_CODEL with interval setting
Test 4324: Create FQ_CODEL with quantum setting
Test b190: Create FQ_CODEL with noecn flag
Test 5381: Create FQ_CODEL with ce_threshold setting
Test c9d2: Create FQ_CODEL with drop_batch setting
Test 523b: Create FQ_CODEL with multiple setting
Test 9283: Replace FQ_CODEL with noecn setting
Test 3459: Change FQ_CODEL with limit setting
Test 0128: Delete FQ_CODEL with handle
Test 0435: Show FQ_CODEL class
Test 283e: Create skbprio with default setting
Test c086: Create skbprio with limit setting
Test 6733: Change skbprio with limit setting
Test 2958: Show skbprio class
Test 9872: Add ingress qdisc
Test 5c5e: Add ingress qdisc with unsupported argument
Test 74f6: Add duplicate ingress qdisc
Test f769: Delete nonexistent ingress qdisc
Test 3b88: Delete ingress qdisc twice
Test 0521: Show ingress class
Test afa9: Add u32 with source match
Test 6aa7: Add/Replace u32 with source match and invalid indev
Test bc4d: Replace valid u32 with source match and invalid indev
Test 648b: Add u32 with custom hash table
Test 6658: Add/Replace u32 with custom hash table and invalid handle
Test 9d0a: Replace valid u32 with custom hash table and invalid handle
Test 1644: Add u32 filter that links to a custom hash table
Test 74c2: Add/Replace u32 filter with invalid hash table id
Test 1fe6: Replace valid u32 filter with invalid hash table id
Test 0692: Test u32 sample option, divisor 256
Test 2478: Test u32 sample option, divisor 16
Test 0c37: Try to delete class referenced by u32 after a replace
Test bd32: Try to delete hashtable referenced by another u32 filter
Test 4585: Delete small tree of u32 hashtables and filters
Test 7a92: Add basic filter with cmp ematch u8/link layer and default action
Test 2e8a: Add basic filter with cmp ematch u8/link layer with trans flag and default action
Test 4d9f: Add basic filter with cmp ematch u16/link layer and a single action
Test 4943: Add basic filter with cmp ematch u32/link layer and miltiple actions
Test 7559: Add basic filter with cmp ematch u8/network layer and default action
Test aff4: Add basic filter with cmp ematch u8/network layer with trans flag and default action
Test c732: Add basic filter with cmp ematch u16/network layer and a single action
Test 32d8: Add basic filter with cmp ematch u32/network layer and miltiple actions
Test b99c: Add basic filter with cmp ematch u8/transport layer and default action
Test 0752: Add basic filter with cmp ematch u8/transport layer with trans flag and default action
Test 7e07: Add basic filter with cmp ematch u16/transport layer and a single action
Test 62d7: Add basic filter with cmp ematch u32/transport layer and miltiple actions
Test 304b: Add basic filter with NOT cmp ematch rule and default action
Test 8ecb: Add basic filter with two ANDed cmp ematch rules and single action
Test b1ad: Add basic filter with two ORed cmp ematch rules and single action
Test 4600: Add basic filter with two ANDed cmp ematch rules and one ORed ematch rule and single action
Test bc59: Add basic filter with two ANDed cmp ematch rules and one NOT ORed ematch rule and single action
Test bae4: Add basic filter with u32 ematch u8/zero offset and default action
Test e6cb: Add basic filter with u32 ematch u8/zero offset and invalid value >0xFF
Test 7727: Add basic filter with u32 ematch u8/positive offset and default action
Test a429: Add basic filter with u32 ematch u8/invalid mask >0xFF
Test 8373: Add basic filter with u32 ematch u8/missing offset
Test ab8e: Add basic filter with u32 ematch u8/missing AT keyword
Test 712d: Add basic filter with u32 ematch u8/missing value
Test 350f: Add basic filter with u32 ematch u8/non-numeric value
Test e28f: Add basic filter with u32 ematch u8/non-numeric mask
Test 6d5f: Add basic filter with u32 ematch u8/negative offset and default action
Test 12dc: Add basic filter with u32 ematch u8/nexthdr+ offset and default action
Test 1d85: Add basic filter with u32 ematch u16/zero offset and default action
Test 3672: Add basic filter with u32 ematch u16/zero offset and invalid value >0xFFFF
Test 7fb0: Add basic filter with u32 ematch u16/positive offset and default action
Test 19af: Add basic filter with u32 ematch u16/invalid mask >0xFFFF
Test 446d: Add basic filter with u32 ematch u16/missing offset
Test 151b: Add basic filter with u32 ematch u16/missing AT keyword
Test bb23: Add basic filter with u32 ematch u16/missing value
Test decc: Add basic filter with u32 ematch u16/non-numeric value
Test e988: Add basic filter with u32 ematch u16/non-numeric mask
Test 07d8: Add basic filter with u32 ematch u16/negative offset and default action
Test f474: Add basic filter with u32 ematch u16/nexthdr+ offset and default action
Test 47a0: Add basic filter with u32 ematch u32/zero offset and default action
Test 849f: Add basic filter with u32 ematch u32/positive offset and default action
Test d288: Add basic filter with u32 ematch u32/missing offset
Test 4998: Add basic filter with u32 ematch u32/missing AT keyword
Test 1f0a: Add basic filter with u32 ematch u32/missing value
Test 848e: Add basic filter with u32 ematch u32/non-numeric value
Test f748: Add basic filter with u32 ematch u32/non-numeric mask
Test 55a6: Add basic filter with u32 ematch u32/negative offset and default action
Test 7282: Add basic filter with u32 ematch u32/nexthdr+ offset and default action
Test b2b6: Add basic filter with canid ematch and single SFF
Test f67f: Add basic filter with canid ematch and single SFF with mask
Test bd5c: Add basic filter with canid ematch and multiple SFF
Test 83c7: Add basic filter with canid ematch and multiple SFF with masks
Test a8f5: Add basic filter with canid ematch and single EFF
Test 98ae: Add basic filter with canid ematch and single EFF with mask
Test 6056: Add basic filter with canid ematch and multiple EFF
Test d188: Add basic filter with canid ematch and multiple EFF with masks
Test 25d1: Add basic filter with canid ematch and a combination of SFF/EFF
Test b438: Add basic filter with canid ematch and a combination of SFF/EFF with masks
Test 0811: Add multiple basic filter with cmp ematch u8/link layer and default action and dump them
Test 5129: List basic filters
Test 901f: Add fw filter with prio at 32-bit maxixum
Test 51e2: Add fw filter with prio exceeding 32-bit maxixum
Test d987: Add fw filter with action ok
Test c591: Add fw filter with action ok by reference
Test affe: Add fw filter with action continue
Test 38b3: Add fw filter with action continue by reference
Test 28bc: Add fw filter with action pipe
Test 6753: Add fw filter with action pipe by reference
Test 8da2: Add fw filter with action drop
Test 6dc6: Add fw filter with action drop by reference
Test 9436: Add fw filter with action reclassify
Test 3bc2: Add fw filter with action reclassify by reference
Test 95bb: Add fw filter with action jump 10
Test 36f7: Add fw filter with action jump 10 by reference
Test 3d74: Add fw filter with action goto chain 5
Test eb8f: Add fw filter with invalid action
Test 6a79: Add fw filter with missing mandatory action
Test 8298: Add fw filter with cookie
Test a88c: Add fw filter with invalid cookie
Test 10f6: Add fw filter with handle in hex
Test 9d51: Add fw filter with handle at 32-bit maximum
Test d939: Add fw filter with handle exceeding 32-bit maximum
Test 658c: Add fw filter with mask in hex
Test 86be: Add fw filter with mask at 32-bit maximum
Test e635: Add fw filter with mask exceeding 32-bit maximum
Test 6cab: Add fw filter with handle/mask in hex
Test 8700: Add fw filter with handle/mask at 32-bit maximum
Test 7d62: Add fw filter with handle/mask exceeding 32-bit maximum
Test 7b69: Add fw filter with missing mandatory handle
Test d68b: Add fw filter with invalid parent
Test 66e0: Add fw filter with missing mandatory parent id
Test 0ff3: Add fw filter with classid
Test 9849: Add fw filter with classid at root
Test b7ff: Add fw filter with classid - keeps last 8 (hex) digits
Test 2b18: Add fw filter with invalid classid
Test fade: Add fw filter with flowid
Test 33af: Add fw filter with flowid then classid (same arg, takes second)
Test 8a8c: Add fw filter with classid then flowid (same arg, takes second)
Test b50d: Add fw filter with handle val/mask and flowid 10:1000
Test 7207: Add fw filter with protocol ip
Test 306d: Add fw filter with protocol ipv6
Test 9a78: Add fw filter with protocol arp
Test 1821: Add fw filter with protocol 802_3
Test 2260: Add fw filter with invalid protocol
Test 09d7: Add fw filters protocol 802_3 and ip with conflicting priorities
Test 6973: Add fw filters with same index, same action
Test fc06: Add fw filters with action police
Test aac7: Add fw filters with action police linklayer atm
Test 5339: Del entire fw filter
Test 0e99: Del single fw filter x1
Test f54c: Del single fw filter x2
Test ba94: Del fw filter by prio
Test 4acb: Del fw filter by chain
Test 3424: Del fw filter by action (invalid)
Test da89: Del fw filter by handle (invalid)
Test 4d95: Del fw filter by protocol (invalid)
Test 4736: Del fw filter by flowid (invalid)
Test 3dcb: Replace fw filter action
Test eb4d: Replace fw filter classid
Test 67ec: Replace fw filter index
Test e470: Try to delete class referenced by fw after a replace
Test ec1a: Replace fw classid with nil
Test 5294: Add flow filter with map key and ops
Test 3514: Add flow filter with map key or ops
Test 7534: Add flow filter with map key xor ops
Test 4524: Add flow filter with map key rshift ops
Test 0230: Add flow filter with map key addend ops
Test 2344: Add flow filter with src map key
Test 9304: Add flow filter with proto map key
Test 9038: Add flow filter with proto-src map key
Test 2a03: Add flow filter with proto-dst map key
Test a073: Add flow filter with iif map key
Test 3b20: Add flow filter with priority map key
Test 8945: Add flow filter with mark map key
Test c034: Add flow filter with nfct map key
Test 0205: Add flow filter with nfct-src map key
Test 5315: Add flow filter with nfct-src map key
Test 7849: Add flow filter with nfct-proto-src map key
Test 9902: Add flow filter with nfct-proto-dst map key
Test 6742: Add flow filter with rt-classid map key
Test 5432: Add flow filter with sk-uid map key
Test 4134: Add flow filter with sk-gid map key
Test 4522: Add flow filter with vlan-tag map key
Test 4253: Add flow filter with rxhash map key
Test 4452: Add flow filter with hash key list
Test 4341: Add flow filter with muliple ops
Test 4392: List flow filters
Test 4322: Change flow filter with map key num
Test 2320: Replace flow filter with map key num
Test 3213: Delete flow filter with map key num
Test 23c3: Add cBPF filter with valid bytecode
Test 1563: Add cBPF filter with invalid bytecode
Test 2334: Add eBPF filter with valid object-file
Test 2373: Add eBPF filter with invalid object-file
Test 4423: Replace cBPF bytecode
Test 5122: Delete cBPF filter
Test e0a9: List cBPF filters
Test e122: Add route filter with from and to tag
Test 6573: Add route filter with fromif and to tag
Test 1362: Add route filter with to flag and reclassify action
Test 4720: Add route filter with from flag and continue actions
Test 2812: Add route filter with form tag and pipe action
Test 7994: Add route filter with miltiple actions
Test 4312: List route filters
Test 2634: Delete route filter with pipe action
Test b042: Try to delete class referenced by route after a replace
Test f62b: Add ingress matchall filter for protocol ipv4 and action PASS
Test 7f09: Add egress matchall filter for protocol ipv4 and action PASS
Test 0596: Add ingress matchall filter for protocol ipv6 and action DROP
Test 41df: Add egress matchall filter for protocol ipv6 and action DROP
Test e1da: Add ingress matchall filter for protocol ipv4 and action PASS with priority at 16-bit maximum
Test 3de5: Add egress matchall filter for protocol ipv4 and action PASS with priority at 16-bit maximum
Test 72d7: Add ingress matchall filter for protocol ipv4 and action PASS with priority exceeding 16-bit maximum
Test 41d3: Add egress matchall filter for protocol ipv4 and action PASS with priority exceeding 16-bit maximum
Test f755: Add ingress matchall filter for all protocols and action CONTINUE with handle at 32-bit maximum
Test 2c33: Add egress matchall filter for all protocols and action CONTINUE with handle at 32-bit maximum
Test 0e4a: Add ingress matchall filter for all protocols and action RECLASSIFY with skip_hw flag
Test 7f60: Add egress matchall filter for all protocols and action RECLASSIFY with skip_hw flag
Test 8bd2: Add ingress matchall filter for protocol ipv6 and action PASS with classid
Test 2a4a: Add ingress matchall filter for protocol ipv6 and action PASS with invalid classid
Test eaf8: Delete single ingress matchall filter
Test 76ad: Delete all ingress matchall filters
Test 1eb9: Delete single ingress matchall filter out of multiple
Test 6d63: Delete ingress matchall filter by chain ID
Test 3329: Validate flags of the matchall filter with skip_sw and police action with skip_hw
Test 0eeb: Validate flags of the matchall filter with skip_hw and police action
Test eee4: Validate flags of the matchall filter with skip_sw and police action
Test 2638: Add matchall and try to get it
Test 6273: Add cgroup filter with cmp ematch u8/link layer and drop action
Test 4721: Add cgroup filter with cmp ematch u8/link layer with trans flag and pass action
Test d392: Add cgroup filter with cmp ematch u16/link layer and pipe action
Test 0234: Add cgroup filter with cmp ematch u32/link layer and miltiple actions
Test 8499: Add cgroup filter with cmp ematch u8/network layer and pass action
Test b273: Add cgroup filter with cmp ematch u8/network layer with trans flag and drop action
Test 1934: Add cgroup filter with cmp ematch u16/network layer and pipe action
Test 2733: Add cgroup filter with cmp ematch u32/network layer and miltiple actions
Test 3271: Add cgroup filter with NOT cmp ematch rule and pass action
Test 2362: Add cgroup filter with two ANDed cmp ematch rules and single action
Test 9993: Add cgroup filter with two ORed cmp ematch rules and single action
Test 2331: Add cgroup filter with two ANDed cmp ematch rules and one ORed ematch rule and single action
Test 3645: Add cgroup filter with two ANDed cmp ematch rules and one NOT ORed ematch rule and single action
Test b124: Add cgroup filter with u32 ematch u8/zero offset and drop action
Test 7381: Add cgroup filter with u32 ematch u8/zero offset and invalid value >0xFF
Test 2231: Add cgroup filter with u32 ematch u8/positive offset and drop action
Test 1882: Add cgroup filter with u32 ematch u8/invalid mask >0xFF
Test 1237: Add cgroup filter with u32 ematch u8/missing offset
Test 3812: Add cgroup filter with u32 ematch u8/missing AT keyword
Test 1112: Add cgroup filter with u32 ematch u8/missing value
Test 3241: Add cgroup filter with u32 ematch u8/non-numeric value
Test e231: Add cgroup filter with u32 ematch u8/non-numeric mask
Test 4652: Add cgroup filter with u32 ematch u8/negative offset and pass action
Test 7566: Add cgroup filter with u32 ematch u8/nexthdr+ offset and drop action
Test 1331: Add cgroup filter with u32 ematch u16/zero offset and pipe action
Test e354: Add cgroup filter with u32 ematch u16/zero offset and invalid value >0xFFFF
Test 3538: Add cgroup filter with u32 ematch u16/positive offset and drop action
Test 4576: Add cgroup filter with u32 ematch u16/invalid mask >0xFFFF
Test b842: Add cgroup filter with u32 ematch u16/missing offset
Test c924: Add cgroup filter with u32 ematch u16/missing AT keyword
Test cc93: Add cgroup filter with u32 ematch u16/missing value
Test 123c: Add cgroup filter with u32 ematch u16/non-numeric value
Test 3675: Add cgroup filter with u32 ematch u16/non-numeric mask
Test 1123: Add cgroup filter with u32 ematch u16/negative offset and drop action
Test 4234: Add cgroup filter with u32 ematch u16/nexthdr+ offset and pass action
Test e912: Add cgroup filter with u32 ematch u32/zero offset and pipe action
Test 1435: Add cgroup filter with u32 ematch u32/positive offset and drop action
Test 1282: Add cgroup filter with u32 ematch u32/missing offset
Test 6456: Add cgroup filter with u32 ematch u32/missing AT keyword
Test 4231: Add cgroup filter with u32 ematch u32/missing value
Test 2131: Add cgroup filter with u32 ematch u32/non-numeric value
Test f125: Add cgroup filter with u32 ematch u32/non-numeric mask
Test 4316: Add cgroup filter with u32 ematch u32/negative offset and drop action
Test 23ae: Add cgroup filter with u32 ematch u32/nexthdr+ offset and pipe action
Test 23a1: Add cgroup filter with canid ematch and single SFF
Test 324f: Add cgroup filter with canid ematch and single SFF with mask
Test 2576: Add cgroup filter with canid ematch and multiple SFF
Test 4839: Add cgroup filter with canid ematch and multiple SFF with masks
Test 6713: Add cgroup filter with canid ematch and single EFF
Test 4572: Add cgroup filter with canid ematch and single EFF with mask
Test 8031: Add cgroup filter with canid ematch and multiple EFF
Test ab9d: Add cgroup filter with canid ematch and multiple EFF with masks
Test 5349: Add cgroup filter with canid ematch and a combination of SFF/EFF
Test c934: Add cgroup filter with canid ematch and a combination of SFF/EFF with masks
Test 4319: Replace cgroup filter with diffferent match
Test 4636: Delete cgroup filter

All test results:

1..1161
ok 1 319a - Add pedit action that mangles IP TTL
ok 2 7e67 - Replace pedit action with invalid goto chain
ok 3 377e - Add pedit action with RAW_OP offset u32
ok 4 a0ca - Add pedit action with RAW_OP offset u32 (INVALID)
ok 5 dd8a - Add pedit action with RAW_OP offset u16 u16
ok 6 53db - Add pedit action with RAW_OP offset u16 (INVALID)
ok 7 5c7e - Add pedit action with RAW_OP offset u8 add value
ok 8 2893 - Add pedit action with RAW_OP offset u8 quad
ok 9 3a07 - Add pedit action with RAW_OP offset u8-u16-u8
ok 10 ab0f - Add pedit action with RAW_OP offset u16-u8-u8
ok 11 9d12 - Add pedit action with RAW_OP offset u32 set u16 clear u8 invert
ok 12 ebfa - Add pedit action with RAW_OP offset overflow u32 (INVALID)
ok 13 f512 - Add pedit action with RAW_OP offset u16 at offmask shift set
ok 14 c2cb - Add pedit action with RAW_OP offset u32 retain value
ok 15 1762 - Add pedit action with RAW_OP offset u8 clear value
ok 16 bcee - Add pedit action with RAW_OP offset u8 retain value
ok 17 e89f - Add pedit action with RAW_OP offset u16 retain value
ok 18 c282 - Add pedit action with RAW_OP offset u32 clear value
ok 19 c422 - Add pedit action with RAW_OP offset u16 invert value
ok 20 d3d3 - Add pedit action with RAW_OP offset u32 invert value
ok 21 57e5 - Add pedit action with RAW_OP offset u8 preserve value
ok 22 99e0 - Add pedit action with RAW_OP offset u16 preserve value
ok 23 1892 - Add pedit action with RAW_OP offset u32 preserve value
ok 24 4b60 - Add pedit action with RAW_OP negative offset u16/u32 set value
ok 25 a5a7 - Add pedit action with LAYERED_OP eth set src
ok 26 86d4 - Add pedit action with LAYERED_OP eth set src & dst
ok 27 f8a9 - Add pedit action with LAYERED_OP eth set dst
ok 28 c715 - Add pedit action with LAYERED_OP eth set src (INVALID)
ok 29 8131 - Add pedit action with LAYERED_OP eth set dst (INVALID)
ok 30 ba22 - Add pedit action with LAYERED_OP eth type set/clear sequence
ok 31 dec4 - Add pedit action with LAYERED_OP eth set type (INVALID)
ok 32 ab06 - Add pedit action with LAYERED_OP eth add type
ok 33 918d - Add pedit action with LAYERED_OP eth invert src
ok 34 a8d4 - Add pedit action with LAYERED_OP eth invert dst
ok 35 ee13 - Add pedit action with LAYERED_OP eth invert type
ok 36 7588 - Add pedit action with LAYERED_OP ip set src
ok 37 0fa7 - Add pedit action with LAYERED_OP ip set dst
ok 38 5810 - Add pedit action with LAYERED_OP ip set src & dst
ok 39 1092 - Add pedit action with LAYERED_OP ip set ihl & dsfield
ok 40 02d8 - Add pedit action with LAYERED_OP ip set ttl & protocol
ok 41 3e2d - Add pedit action with LAYERED_OP ip set ttl (INVALID)
ok 42 31ae - Add pedit action with LAYERED_OP ip ttl clear/set
ok 43 486f - Add pedit action with LAYERED_OP ip set duplicate fields
ok 44 e790 - Add pedit action with LAYERED_OP ip set ce, df, mf, firstfrag, nofrag fields
ok 45 cc8a - Add pedit action with LAYERED_OP ip set tos
ok 46 7a17 - Add pedit action with LAYERED_OP ip set precedence
ok 47 c3b6 - Add pedit action with LAYERED_OP ip add tos
ok 48 43d3 - Add pedit action with LAYERED_OP ip add precedence
ok 49 438e - Add pedit action with LAYERED_OP ip clear tos
ok 50 6b1b - Add pedit action with LAYERED_OP ip clear precedence
ok 51 824a - Add pedit action with LAYERED_OP ip invert tos
ok 52 106f - Add pedit action with LAYERED_OP ip invert precedence
ok 53 6829 - Add pedit action with LAYERED_OP beyond ip set dport & sport
ok 54 afd8 - Add pedit action with LAYERED_OP beyond ip set icmp_type & icmp_code
ok 55 3143 - Add pedit action with LAYERED_OP beyond ip set dport (INVALID)
ok 56 815c - Add pedit action with LAYERED_OP ip6 set src
ok 57 4dae - Add pedit action with LAYERED_OP ip6 set dst
ok 58 fc1f - Add pedit action with LAYERED_OP ip6 set src & dst
ok 59 6d34 - Add pedit action with LAYERED_OP ip6 dst retain value (INVALID)
ok 60 94bb - Add pedit action with LAYERED_OP ip6 traffic_class
ok 61 6f5e - Add pedit action with LAYERED_OP ip6 flow_lbl
ok 62 6795 - Add pedit action with LAYERED_OP ip6 set payload_len, nexthdr, hoplimit
ok 63 1442 - Add pedit action with LAYERED_OP tcp set dport & sport
ok 64 b7ac - Add pedit action with LAYERED_OP tcp sport set (INVALID)
ok 65 cfcc - Add pedit action with LAYERED_OP tcp flags set
ok 66 3bc4 - Add pedit action with LAYERED_OP tcp set dport, sport & flags fields
ok 67 f1c8 - Add pedit action with LAYERED_OP udp set dport & sport
ok 68 d784 - Add pedit action with mixed RAW/LAYERED_OP #1
ok 69 70ca - Add pedit action with mixed RAW/LAYERED_OP #2
ok 70 2b11 - Add tunnel_key set action with mandatory parameters
ok 71 dc6b - Add tunnel_key set action with missing mandatory src_ip parameter
ok 72 7f25 - Add tunnel_key set action with missing mandatory dst_ip parameter
ok 73 a5e0 - Add tunnel_key set action with invalid src_ip parameter
ok 74 eaa8 - Add tunnel_key set action with invalid dst_ip parameter
ok 75 3b09 - Add tunnel_key set action with invalid id parameter
ok 76 9625 - Add tunnel_key set action with invalid dst_port parameter
ok 77 05af - Add tunnel_key set action with optional dst_port parameter
ok 78 da80 - Add tunnel_key set action with index at 32-bit maximum
ok 79 d407 - Add tunnel_key set action with index exceeding 32-bit maximum
ok 80 5cba - Add tunnel_key set action with id value at 32-bit maximum
ok 81 e84a - Add tunnel_key set action with id value exceeding 32-bit maximum
ok 82 9c19 - Add tunnel_key set action with dst_port value at 16-bit maximum
ok 83 3bd9 - Add tunnel_key set action with dst_port value exceeding 16-bit maximum
ok 84 68e2 - Add tunnel_key unset action
ok 85 6192 - Add tunnel_key unset continue action
ok 86 061d - Add tunnel_key set continue action with cookie
ok 87 8acb - Add tunnel_key set continue action with invalid cookie
ok 88 a07e - Add tunnel_key action with no set/unset command specified
ok 89 b227 - Add tunnel_key action with csum option
ok 90 58a7 - Add tunnel_key action with nocsum option
ok 91 2575 - Add tunnel_key action with not-supported parameter
ok 92 7a88 - Add tunnel_key action with cookie parameter
ok 93 4f20 - Add tunnel_key action with a single geneve option parameter
ok 94 e33d - Add tunnel_key action with multiple geneve options parameter
ok 95 0778 - Add tunnel_key action with invalid class geneve option parameter
ok 96 4ae8 - Add tunnel_key action with invalid type geneve option parameter
ok 97 4039 - Add tunnel_key action with short data length geneve option parameter
ok 98 26a6 - Add tunnel_key action with non-multiple of 4 data length geneve option parameter
ok 99 f44d - Add tunnel_key action with incomplete geneve options parameter
ok 100 7afc - Replace tunnel_key set action with all parameters
ok 101 364d - Replace tunnel_key set action with all parameters and cookie
ok 102 937c - Fetch all existing tunnel_key actions
ok 103 6783 - Flush all existing tunnel_key actions
ok 104 8242 - Replace tunnel_key set action with invalid goto chain
ok 105 0cd2 - Add tunnel_key set action with no_percpu flag
ok 106 3671 - Delete tunnel_key set action with valid index
ok 107 8597 - Delete tunnel_key set action with invalid index
ok 108 6bda - Add tunnel_key action with nofrag option # skipped - probe command: test skipped.

ok 109 7682 - Create valid ife encode action with mark and pass control
ok 110 ef47 - Create valid ife encode action with mark and pipe control
ok 111 df43 - Create valid ife encode action with mark and continue control
ok 112 e4cf - Create valid ife encode action with mark and drop control
ok 113 ccba - Create valid ife encode action with mark and reclassify control
ok 114 a1cf - Create valid ife encode action with mark and jump control
ok 115 cb3d - Create valid ife encode action with mark value at 32-bit maximum
ok 116 1efb - Create ife encode action with mark value exceeding 32-bit maximum
ok 117 95ed - Create valid ife encode action with prio and pass control
ok 118 aa17 - Create valid ife encode action with prio and pipe control
ok 119 74c7 - Create valid ife encode action with prio and continue control
ok 120 7a97 - Create valid ife encode action with prio and drop control
ok 121 f66b - Create valid ife encode action with prio and reclassify control
ok 122 3056 - Create valid ife encode action with prio and jump control
ok 123 7dd3 - Create valid ife encode action with prio value at 32-bit maximum
ok 124 2ca1 - Create ife encode action with prio value exceeding 32-bit maximum
ok 125 05bb - Create valid ife encode action with tcindex and pass control
ok 126 ce65 - Create valid ife encode action with tcindex and pipe control
ok 127 09cd - Create valid ife encode action with tcindex and continue control
ok 128 8eb5 - Create valid ife encode action with tcindex and continue control
ok 129 451a - Create valid ife encode action with tcindex and drop control
ok 130 d76c - Create valid ife encode action with tcindex and reclassify control
ok 131 e731 - Create valid ife encode action with tcindex and jump control
ok 132 b7b8 - Create valid ife encode action with tcindex value at 16-bit maximum
ok 133 d0d8 - Create ife encode action with tcindex value exceeding 16-bit maximum
ok 134 2a9c - Create valid ife encode action with mac src parameter
ok 135 cf5c - Create valid ife encode action with mac dst parameter
ok 136 2353 - Create valid ife encode action with mac src and mac dst parameters
ok 137 552c - Create valid ife encode action with mark and type parameters
ok 138 0421 - Create valid ife encode action with prio and type parameters
ok 139 4017 - Create valid ife encode action with tcindex and type parameters
ok 140 fac3 - Create valid ife encode action with index at 32-bit maximum
ok 141 7c25 - Create valid ife decode action with pass control
ok 142 dccb - Create valid ife decode action with pipe control
ok 143 7bb9 - Create valid ife decode action with continue control
ok 144 d9ad - Create valid ife decode action with drop control
ok 145 219f - Create valid ife decode action with reclassify control
ok 146 8f44 - Create valid ife decode action with jump control
ok 147 56cf - Create ife encode action with index exceeding 32-bit maximum
ok 148 ee94 - Create ife encode action with invalid control
ok 149 b330 - Create ife encode action with cookie
ok 150 bbc0 - Create ife encode action with invalid argument
ok 151 d54a - Create ife encode action with invalid type argument
ok 152 7ee0 - Create ife encode action with invalid mac src argument
ok 153 0a7d - Create ife encode action with invalid mac dst argument
ok 154 a0e2 - Replace ife encode action with invalid goto chain control
ok 155 a972 - Delete ife encode action with valid index
ok 156 1272 - Delete ife encode action with invalid index
ok 157 6236 - Add skbedit action with valid mark
ok 158 c8cf - Add skbedit action with 32-bit maximum mark
ok 159 407b - Add skbedit action with mark exceeding 32-bit maximum
ok 160 d4cd - Add skbedit action with valid mark and mask
ok 161 baa7 - Add skbedit action with valid mark and 32-bit maximum mask
ok 162 62a5 - Add skbedit action with valid mark and mask exceeding 32-bit maximum
ok 163 bc15 - Add skbedit action with valid mark and mask with invalid format
ok 164 57c2 - Replace skbedit action with new mask
ok 165 081d - Add skbedit action with priority
ok 166 cc37 - Add skbedit action with invalid priority
ok 167 3c95 - Add skbedit action with queue_mapping
ok 168 985c - Add skbedit action with queue_mapping exceeding 16-bit maximum
ok 169 224f - Add skbedit action with ptype host
ok 170 d1a3 - Add skbedit action with ptype otherhost
ok 171 b9c6 - Add skbedit action with invalid ptype
ok 172 464a - Add skbedit action with control pipe
ok 173 212f - Add skbedit action with control reclassify
ok 174 0651 - Add skbedit action with control pass
ok 175 cc53 - Add skbedit action with control drop
ok 176 ec16 - Add skbedit action with control jump
ok 177 db54 - Add skbedit action with control continue
ok 178 1055 - Add skbedit action with cookie
ok 179 5172 - List skbedit actions
ok 180 a6d6 - Add skbedit action with index at 32-bit maximum
ok 181 f0f4 - Add skbedit action with index exceeding 32-bit maximum
ok 182 38f3 - Delete skbedit action
ok 183 ce97 - Flush skbedit actions
ok 184 1b2b - Replace skbedit action with invalid goto_chain control
ok 185 630c - Add batch of 32 skbedit actions with all parameters and cookie
ok 186 706d - Delete batch of 32 skbedit actions with all parameters
ok 187 e89a - Add valid pass action
ok 188 a02c - Add valid pipe action
ok 189 feef - Add valid reclassify action
ok 190 8a7a - Add valid drop action
ok 191 9a52 - Add valid continue action
ok 192 d700 - Add invalid action
ok 193 9215 - Add action with duplicate index
ok 194 798e - Add action with index exceeding 32-bit maximum
ok 195 22be - Add action with index at 32-bit maximum
ok 196 ac2a - List actions
ok 197 3edf - Flush gact actions
ok 198 63ec - Delete pass action
ok 199 46be - Delete pipe action
ok 200 2e08 - Delete reclassify action
ok 201 99c4 - Delete drop action
ok 202 fb6b - Delete continue action
ok 203 0eb3 - Delete non-existent action
ok 204 f02c - Replace gact action
ok 205 525f - Get gact action by index
ok 206 1021 - Add batch of 32 gact pass actions
ok 207 da7a - Add batch of 32 gact continue actions with cookie
ok 208 8aa3 - Delete batch of 32 gact continue actions
ok 209 8e47 - Add gact action with random determ goto chain control action
ok 210 ca89 - Replace gact action with invalid goto chain control
ok 211 95ad - Add gact pass action with no_percpu flag
ok 212 7f52 - Try to flush action which is referenced by filter
ok 213 ae1e - Try to flush actions when last one is referenced by filter
ok 214 d959 - Add cBPF action with valid bytecode
ok 215 f84a - Add cBPF action with invalid bytecode
ok 216 e939 - Add eBPF action with valid object-file
ok 217 282d - Add eBPF action with invalid object-file
ok 218 d819 - Replace cBPF bytecode and action control
ok 219 6ae3 - Delete cBPF action
ok 220 3e0d - List cBPF actions
ok 221 55ce - Flush BPF actions
ok 222 ccc3 - Add cBPF action with duplicate index
ok 223 89c7 - Add cBPF action with invalid index
ok 224 7ab9 - Add cBPF action with cookie
ok 225 b8a1 - Replace bpf action with invalid goto_chain control
ok 226 2002 - Add valid connmark action with defaults
ok 227 56a5 - Add valid connmark action with control pass
ok 228 7c66 - Add valid connmark action with control drop
ok 229 a913 - Add valid connmark action with control pipe
ok 230 bdd8 - Add valid connmark action with control reclassify
ok 231 b8be - Add valid connmark action with control continue
ok 232 d8a6 - Add valid connmark action with control jump
ok 233 aae8 - Add valid connmark action with zone argument
ok 234 2f0b - Add valid connmark action with invalid zone argument
ok 235 9305 - Add connmark action with unsupported argument
ok 236 71ca - Add valid connmark action and replace it
ok 237 5f8f - Add valid connmark action with cookie
ok 238 c506 - Replace connmark with invalid goto chain control
ok 239 6571 - Delete connmark action with valid index
ok 240 3426 - Delete connmark action with invalid index
ok 241 7d50 - Add skbmod action to set destination mac
ok 242 9b29 - Add skbmod action to set source mac
ok 243 1724 - Add skbmod action with invalid mac
ok 244 3cf1 - Add skbmod action with valid etype
ok 245 a749 - Add skbmod action with invalid etype
ok 246 bfe6 - Add skbmod action to swap mac
ok 247 839b - Add skbmod action with control pipe
ok 248 c167 - Add skbmod action with control reclassify
ok 249 0c2f - Add skbmod action with control drop
ok 250 d113 - Add skbmod action with control continue
ok 251 7242 - Add skbmod action with control pass
ok 252 6046 - Add skbmod action with control reclassify and cookie
ok 253 58cb - List skbmod actions
ok 254 9aa8 - Get a single skbmod action from a list
ok 255 e93a - Delete an skbmod action
ok 256 40c2 - Flush skbmod actions
ok 257 b651 - Replace skbmod action with invalid goto_chain control
ok 258 fe09 - Add skbmod action to mark ECN bits
ok 259 6d84 - Add csum iph action
ok 260 1862 - Add csum ip4h action
ok 261 15c6 - Add csum ipv4h action
ok 262 bf47 - Add csum icmp action
ok 263 cc1d - Add csum igmp action
ok 264 bccc - Add csum foobar action
ok 265 3bb4 - Add csum tcp action
ok 266 759c - Add csum udp action
ok 267 bdb6 - Add csum udp xor iph action
ok 268 c220 - Add csum udplite action
ok 269 8993 - Add csum sctp action
ok 270 b138 - Add csum ip & icmp action
ok 271 eeda - Add csum ip & sctp action
ok 272 0017 - Add csum udp or tcp action
ok 273 b10b - Add all 7 csum actions
ok 274 ce92 - Add csum udp action with cookie
ok 275 912f - Add csum icmp action with large cookie
ok 276 879b - Add batch of 32 csum tcp actions
ok 277 b4e9 - Delete batch of 32 csum actions
ok 278 0015 - Add batch of 32 csum tcp actions with large cookies
ok 279 989e - Delete batch of 32 csum actions with large cookies
ok 280 d128 - Replace csum action with invalid goto chain control
ok 281 eaf0 - Add csum iph action with no_percpu flag
ok 282 c826 - Add ctinfo action with default setting
ok 283 0286 - Add ctinfo action with dscp
ok 284 4938 - Add ctinfo action with valid cpmark and zone
ok 285 7593 - Add ctinfo action with drop control
ok 286 2961 - Replace ctinfo action zone and action control
ok 287 e567 - Delete ctinfo action with valid index
ok 288 6a91 - Delete ctinfo action with invalid index
ok 289 5232 - List ctinfo actions
ok 290 7702 - Flush ctinfo actions
ok 291 3201 - Add ctinfo action with duplicate index
ok 292 8295 - Add ctinfo action with invalid index
ok 293 3964 - Replace ctinfo action with invalid goto_chain control
ok 294 696a - Add simple ct action
ok 295 e38c - Add simple ct action with cookie
ok 296 9f20 - Add ct clear action
ok 297 0bc1 - Add ct clear action with cookie of max length
ok 298 5bea - Try ct with zone
ok 299 d5d6 - Try ct with zone, commit
ok 300 029f - Try ct with zone, commit, mark
ok 301 a58d - Try ct with zone, commit, mark, nat
ok 302 901b - Try ct with full nat ipv4 range syntax
ok 303 072b - Try ct with full nat ipv6 syntax
ok 304 3420 - Try ct with full nat ipv6 range syntax
ok 305 4470 - Try ct with full nat ipv6 range syntax + force
ok 306 5d88 - Try ct with label
ok 307 04d4 - Try ct with label with mask
ok 308 9751 - Try ct with mark + mask
ok 309 2faa - Try ct with mark + mask and cookie
ok 310 3991 - Add simple ct action with no_percpu flag
ok 311 3992 - Add ct action triggering DNAT tuple conflict
ok 312 6f5a - Add vlan pop action with pipe opcode
ok 313 df35 - Add vlan pop action with pass opcode
ok 314 b0d4 - Add vlan pop action with drop opcode
ok 315 95ee - Add vlan pop action with reclassify opcode
ok 316 0283 - Add vlan pop action with continue opcode
ok 317 b6b9 - Add vlan pop action with jump opcode
ok 318 87c3 - Add vlan pop action with trap opcode
ok 319 a178 - Add vlan pop action with invalid opcode
ok 320 ee6f - Add vlan pop action with index at 32-bit maximum
ok 321 0dfa - Add vlan pop action with index exceeding 32-bit maximum
ok 322 2b91 - Add vlan invalid action
ok 323 57fc - Add vlan push action with invalid protocol type
ok 324 3989 - Add vlan push action with default protocol and priority
ok 325 79dc - Add vlan push action with protocol 802.1Q and priority 3
ok 326 4d73 - Add vlan push action with protocol 802.1AD
ok 327 1f4b - Add vlan push action with maximum 12-bit vlan ID
ok 328 1f7b - Add vlan push action with invalid vlan ID
ok 329 fe40 - Add vlan push action with maximum 3-bit IEEE 802.1p priority
ok 330 5d02 - Add vlan push action with invalid IEEE 802.1p priority
ok 331 ba5b - Add vlan modify action for protocol 802.1Q setting priority 0
ok 332 6812 - Add vlan modify action for protocol 802.1Q
ok 333 5a31 - Add vlan modify action for protocol 802.1AD
ok 334 3deb - Replace existing vlan push action with new ID
ok 335 9e76 - Replace existing vlan push action with new protocol
ok 336 ede4 - Replace existing vlan push action with new priority
ok 337 d413 - Replace existing vlan pop action with new cookie
ok 338 83a4 - Delete vlan pop action
ok 339 ed1e - Delete vlan push action for protocol 802.1Q
ok 340 a2a3 - Flush vlan actions
ok 341 1d78 - Add vlan push action with cookie
ok 342 e394 - Replace vlan push action with invalid goto chain control
ok 343 294e - Add batch of 32 vlan push actions with cookie
ok 344 56f7 - Delete batch of 32 vlan push actions
ok 345 759f - Add batch of 32 vlan pop actions with cookie
ok 346 c84a - Delete batch of 32 vlan pop actions
ok 347 1a3d - Add vlan pop action with no_percpu flag
ok 348 7565 - Add nat action on ingress with default control action
ok 349 fd79 - Add nat action on ingress with pipe control action
ok 350 eab9 - Add nat action on ingress with continue control action
ok 351 c53a - Add nat action on ingress with reclassify control action
ok 352 76c9 - Add nat action on ingress with jump control action
ok 353 24c6 - Add nat action on ingress with drop control action
ok 354 2120 - Add nat action on ingress with maximum index value
ok 355 3e9d - Add nat action on ingress with invalid index value
ok 356 f6c9 - Add nat action on ingress with invalid IP address
ok 357 be25 - Add nat action on ingress with invalid argument
ok 358 a7bd - Add nat action on ingress with DEFAULT IP address
ok 359 ee1e - Add nat action on ingress with ANY IP address
ok 360 1de8 - Add nat action on ingress with ALL IP address
ok 361 8dba - Add nat action on egress with default control action
ok 362 19a7 - Add nat action on egress with pipe control action
ok 363 f1d9 - Add nat action on egress with continue control action
ok 364 6d4a - Add nat action on egress with reclassify control action
ok 365 b313 - Add nat action on egress with jump control action
ok 366 d9fc - Add nat action on egress with drop control action
ok 367 a895 - Add nat action on egress with DEFAULT IP address
ok 368 2572 - Add nat action on egress with ANY IP address
ok 369 37f3 - Add nat action on egress with ALL IP address
ok 370 6054 - Add nat action on egress with cookie
ok 371 79d6 - Add nat action on ingress with cookie
ok 372 4b12 - Replace nat action with invalid goto chain control
ok 373 b811 - Delete nat action with valid index
ok 374 a521 - Delete nat action with invalid index
ok 375 9784 - Add valid sample action with mandatory arguments
ok 376 5c91 - Add valid sample action with mandatory arguments and continue control action
ok 377 334b - Add valid sample action with mandatory arguments and drop control action
ok 378 da69 - Add valid sample action with mandatory arguments and reclassify control action
ok 379 13ce - Add valid sample action with mandatory arguments and pipe control action
ok 380 1886 - Add valid sample action with mandatory arguments and jump control action
ok 381 7571 - Add sample action with invalid rate
ok 382 b6d4 - Add sample action with mandatory arguments and invalid control action
ok 383 a874 - Add invalid sample action without mandatory arguments
ok 384 ac01 - Add invalid sample action without mandatory argument rate
ok 385 4203 - Add invalid sample action without mandatory argument group
ok 386 14a7 - Add invalid sample action without mandatory argument group
ok 387 8f2e - Add valid sample action with trunc argument
ok 388 45f8 - Add sample action with maximum rate argument
ok 389 ad0c - Add sample action with maximum trunc argument
ok 390 83a9 - Add sample action with maximum group argument
ok 391 ed27 - Add sample action with invalid rate argument
ok 392 2eae - Add sample action with invalid group argument
ok 393 6ff3 - Add sample action with invalid trunc size
ok 394 2b2a - Add sample action with invalid index
ok 395 dee2 - Add sample action with maximum allowed index
ok 396 560e - Add sample action with cookie
ok 397 704a - Replace existing sample action with new rate argument
ok 398 60eb - Replace existing sample action with new group argument
ok 399 2cce - Replace existing sample action with new trunc argument
ok 400 59d1 - Replace existing sample action with new control argument
ok 401 0a6e - Replace sample action with invalid goto chain control
ok 402 3872 - Delete sample action with valid index
ok 403 a394 - Delete sample action with invalid index
ok 404 49aa - Add valid basic police action
ok 405 3abe - Add police action with duplicate index
ok 406 49fa - Add valid police action with mtu
ok 407 7943 - Add valid police action with peakrate
ok 408 055e - Add police action with peakrate and no mtu
ok 409 f057 - Add police action with valid overhead
ok 410 7ffb - Add police action with ethernet linklayer type
ok 411 3dda - Add police action with atm linklayer type
ok 412 551b - Add police actions with conform-exceed control continue/drop
ok 413 0c70 - Add police actions with conform-exceed control pass/reclassify
ok 414 d946 - Add police actions with conform-exceed control pass/pipe
ok 415 ddd6 - Add police action with invalid rate value
ok 416 f61c - Add police action with invalid burst value
ok 417 6aaf - Add police actions with conform-exceed control pass/pipe [with numeric values]
ok 418 29b1 - Add police actions with conform-exceed control <invalid>/drop
ok 419 c26f - Add police action with invalid peakrate value
ok 420 db04 - Add police action with invalid mtu value
ok 421 f3c9 - Add police action with cookie
ok 422 d190 - Add police action with maximum index
ok 423 336e - Delete police action
ok 424 77fa - Get single police action from many actions
ok 425 aa43 - Get single police action without specifying index
ok 426 858b - List police actions
ok 427 1c3a - Flush police actions
ok 428 7326 - Add police action with control continue
ok 429 34fa - Add police action with control drop
ok 430 8dd5 - Add police action with control ok
ok 431 b9d1 - Add police action with control reclassify
ok 432 c534 - Add police action with control pipe
ok 433 b48b - Add police action with exceed goto chain control action
ok 434 689e - Replace police action with invalid goto chain control
ok 435 cdd7 - Add valid police action with packets per second rate limit
ok 436 f5bc - Add invalid police action with both bps and pps
ok 437 7d64 - Add police action with skip_hw option
ok 438 b078 - Add simple action
ok 439 4297 - Add simple action with change command
ok 440 6d4c - Add simple action with duplicate index
ok 441 2542 - List simple actions
ok 442 ea67 - Delete simple action
ok 443 8ff1 - Flush simple actions
ok 444 b776 - Replace simple action with invalid goto chain control
ok 445 8d07 - Verify cleanup of failed actions batch add
ok 446 a68a - Verify cleanup of failed actions batch change
ok 447 a933 - Add MPLS dec_ttl action with pipe opcode
ok 448 08d1 - Add mpls dec_ttl action with pass opcode
ok 449 d786 - Add mpls dec_ttl action with drop opcode
ok 450 f334 - Add mpls dec_ttl action with reclassify opcode
ok 451 29bd - Add mpls dec_ttl action with continue opcode
ok 452 48df - Add mpls dec_ttl action with jump opcode
ok 453 62eb - Add mpls dec_ttl action with trap opcode
ok 454 09d2 - Add mpls dec_ttl action with opcode and cookie
ok 455 c170 - Add mpls dec_ttl action with opcode and cookie of max length
ok 456 9118 - Add mpls dec_ttl action with invalid opcode
ok 457 6ce1 - Add mpls dec_ttl action with label (invalid)
ok 458 352f - Add mpls dec_ttl action with tc (invalid)
ok 459 fa1c - Add mpls dec_ttl action with ttl (invalid)
ok 460 6b79 - Add mpls dec_ttl action with bos (invalid)
ok 461 d4c4 - Add mpls pop action with ip proto
ok 462 91fb - Add mpls pop action with ip proto and cookie
ok 463 92fe - Add mpls pop action with mpls proto
ok 464 7e23 - Add mpls pop action with no protocol (invalid)
ok 465 6182 - Add mpls pop action with label (invalid)
ok 466 6475 - Add mpls pop action with tc (invalid)
ok 467 067b - Add mpls pop action with ttl (invalid)
ok 468 7316 - Add mpls pop action with bos (invalid)
ok 469 38cc - Add mpls push action with label
ok 470 c281 - Add mpls push action with mpls_mc protocol
ok 471 5db4 - Add mpls push action with label, tc and ttl
ok 472 7c34 - Add mpls push action with label, tc ttl and cookie of max length
ok 473 16eb - Add mpls push action with label and bos
ok 474 d69d - Add mpls push action with no label (invalid)
ok 475 e8e4 - Add mpls push action with ipv4 protocol (invalid)
ok 476 ecd0 - Add mpls push action with out of range label (invalid)
ok 477 d303 - Add mpls push action with out of range tc (invalid)
ok 478 fd6e - Add mpls push action with ttl of 0 (invalid)
ok 479 19e9 - Add mpls mod action with mpls label
ok 480 1fde - Add mpls mod action with max mpls label
ok 481 0c50 - Add mpls mod action with mpls label exceeding max (invalid)
ok 482 10b6 - Add mpls mod action with mpls label of MPLS_LABEL_IMPLNULL (invalid)
ok 483 57c9 - Add mpls mod action with mpls min tc
ok 484 6872 - Add mpls mod action with mpls max tc
ok 485 a70a - Add mpls mod action with mpls tc exceeding max (invalid)
ok 486 6ed5 - Add mpls mod action with mpls ttl
ok 487 77c1 - Add mpls mod action with mpls ttl and cookie
ok 488 b80f - Add mpls mod action with mpls max ttl
ok 489 8864 - Add mpls mod action with mpls min ttl
ok 490 6c06 - Add mpls mod action with mpls ttl of 0 (invalid)
ok 491 b5d8 - Add mpls mod action with mpls ttl exceeding max (invalid)
ok 492 451f - Add mpls mod action with mpls max bos
ok 493 a1ed - Add mpls mod action with mpls min bos
ok 494 3dcf - Add mpls mod action with mpls bos exceeding max (invalid)
ok 495 db7c - Add mpls mod action with protocol (invalid)
ok 496 b070 - Replace existing mpls push action with new ID
ok 497 95a9 - Replace existing mpls push action with new label, tc, ttl and cookie
ok 498 6cce - Delete mpls pop action
ok 499 d138 - Flush mpls actions
ok 500 5153 - Add gate action with priority and sched-entry
ok 501 7189 - Add gate action with base-time
ok 502 a721 - Add gate action with cycle-time
ok 503 c029 - Add gate action with cycle-time-ext
ok 504 3719 - Replace gate base-time action
ok 505 d821 - Delete gate action with valid index
ok 506 3128 - Delete gate action with invalid index
ok 507 7837 - List gate actions
ok 508 9273 - Flush gate actions
ok 509 c829 - Add gate action with duplicate index
ok 510 3043 - Add gate action with invalid index
ok 511 2930 - Add gate action with cookie
ok 512 5124 - Add mirred mirror to egress action
ok 513 6fb4 - Add mirred redirect to egress action
ok 514 ba38 - Get mirred actions
ok 515 d7c0 - Add invalid mirred direction
ok 516 e213 - Add invalid mirred action
ok 517 2d89 - Add mirred action with invalid device
ok 518 300b - Add mirred action with duplicate index
ok 519 8917 - Add mirred mirror action with control pass
ok 520 1054 - Add mirred mirror action with control pipe
ok 521 9887 - Add mirred mirror action with control continue
ok 522 e4aa - Add mirred mirror action with control reclassify
ok 523 ece9 - Add mirred mirror action with control drop
ok 524 0031 - Add mirred mirror action with control jump
ok 525 407c - Add mirred mirror action with cookie
ok 526 8b69 - Add mirred mirror action with index at 32-bit maximum
ok 527 3f66 - Add mirred mirror action with index exceeding 32-bit maximum
ok 528 a70e - Delete mirred mirror action
ok 529 3fb3 - Delete mirred redirect action
ok 530 2a9a - Replace mirred action with invalid goto chain control
ok 531 4749 - Add batch of 32 mirred redirect egress actions with cookie
ok 532 5c69 - Delete batch of 32 mirred redirect egress actions
ok 533 d3c0 - Add batch of 32 mirred mirror ingress actions with cookie
ok 534 e684 - Delete batch of 32 mirred mirror ingress actions
ok 535 31e3 - Add mirred mirror to egress action with no_percpu flag
ok 536 456d - Add mirred mirror to egress block action # skipped - probe command: test skipped.

ok 537 2358 - Add mirred mirror to ingress block action # skipped - probe command: test skipped.

ok 538 fdb1 - Add mirred redirect to egress block action # skipped - probe command: test skipped.

ok 539 20cc - Add mirred redirect to ingress block action # skipped - probe command: test skipped.

ok 540 e739 - Try to add mirred action with both dev and block # skipped - probe command: test skipped.

ok 541 2f47 - Try to add mirred action without specifying neither dev nor block
ok 542 3188 - Replace mirred redirect to dev action with redirect to block # skipped - probe command: test skipped.

ok 543 83cc - Replace mirred redirect to block action with mirror to dev # skipped - probe command: test skipped.

ok 544 c2b4 - Soft lockup alarm will be not generated after delete the prio 0 filter of the chain
ok 545 abdc - Reference pedit action object in filter
ok 546 7a70 - Reference mpls action object in filter
ok 547 d241 - Reference bpf action object in filter
ok 548 383a - Reference connmark action object in filter
ok 549 c619 - Reference csum action object in filter
ok 550 a93d - Reference ct action object in filter
ok 551 8bb5 - Reference ctinfo action object in filter
ok 552 2241 - Reference gact action object in filter
ok 553 35e9 - Reference gate action object in filter
ok 554 b22e - Reference ife action object in filter
ok 555 ef74 - Reference mirred action object in filter
ok 556 2c81 - Reference nat action object in filter
ok 557 ac9d - Reference police action object in filter
ok 558 68be - Reference sample action object in filter
ok 559 cf01 - Reference skbedit action object in filter
ok 560 c109 - Reference skbmod action object in filter
ok 561 4abc - Reference tunnel_key action object in filter
ok 562 dadd - Reference vlan action object in filter
ok 563 0582 - Create QFQ with default setting
ok 564 c9a3 - Create QFQ with class weight setting
ok 565 d364 - Test QFQ with max class weight setting
ok 566 8452 - Create QFQ with class maxpkt setting
ok 567 22df - Test QFQ class maxpkt setting lower bound
ok 568 92ee - Test QFQ class maxpkt setting upper bound
ok 569 d920 - Create QFQ with multiple class setting
ok 570 0548 - Delete QFQ with handle
ok 571 5901 - Show QFQ class
ok 572 85ee - QFQ with big MTU
ok 573 ddfa - QFQ with small MTU
ok 574 5993 - QFQ with stab overhead greater than max packet len
ok 575 0385 - Create DRR with default setting
ok 576 2375 - Delete DRR with handle
ok 577 3092 - Show DRR class
ok 578 9903 - Add mqprio Qdisc to multi-queue device (8 queues)
ok 579 453a - Delete nonexistent mqprio Qdisc
ok 580 5292 - Delete mqprio Qdisc twice
ok 581 45a9 - Add mqprio Qdisc to single-queue device
ok 582 2ba9 - Show mqprio class
ok 583 4812 - Create HHF with default setting
ok 584 8a92 - Create HHF with limit setting
ok 585 3491 - Create HHF with quantum setting
ok 586 ba04 - Create HHF with reset_timeout setting
ok 587 4238 - Create HHF with admit_bytes setting
ok 588 839f - Create HHF with evict_timeout setting
ok 589 a044 - Create HHF with non_hh_weight setting
ok 590 32f9 - Change HHF with limit setting
ok 591 385e - Show HHF class
ok 592 7482 - Create SFQ with default setting
ok 593 c186 - Create SFQ with limit setting
ok 594 ae23 - Create SFQ with perturb setting
ok 595 a430 - Create SFQ with quantum setting
ok 596 4539 - Create SFQ with divisor setting
ok 597 b089 - Create SFQ with flows setting
ok 598 99a0 - Create SFQ with depth setting
ok 599 7389 - Create SFQ with headdrop setting
ok 600 6472 - Create SFQ with redflowlimit setting
ok 601 8929 - Show SFQ class
ok 602 0904 - Create HTB with default setting
ok 603 3906 - Create HTB with default-N setting
ok 604 8492 - Create HTB with r2q setting
ok 605 9502 - Create HTB with direct_qlen setting
ok 606 b924 - Create HTB with class rate and burst setting
ok 607 4359 - Create HTB with class mpu setting
ok 608 9048 - Create HTB with class prio setting
ok 609 4994 - Create HTB with class ceil setting
ok 610 9523 - Create HTB with class cburst setting
ok 611 5353 - Create HTB with class mtu setting
ok 612 346a - Create HTB with class quantum setting
ok 613 303a - Delete HTB with handle
ok 614 e90e - Add ETS qdisc using bands
ok 615 b059 - Add ETS qdisc using quanta
ok 616 e8e7 - Add ETS qdisc using strict
ok 617 233c - Add ETS qdisc using bands + quanta
ok 618 3d35 - Add ETS qdisc using bands + strict
ok 619 7f3b - Add ETS qdisc using strict + quanta
ok 620 4593 - Add ETS qdisc using strict 0 + quanta
ok 621 8938 - Add ETS qdisc using bands + strict + quanta
ok 622 0782 - Add ETS qdisc with more bands than quanta
ok 623 501b - Add ETS qdisc with more bands than strict
ok 624 671a - Add ETS qdisc with more bands than strict + quanta
ok 625 2a23 - Add ETS qdisc with 16 bands
ok 626 8daf - Add ETS qdisc with 17 bands
ok 627 7f95 - Add ETS qdisc with 17 strict
ok 628 837a - Add ETS qdisc with 16 quanta
ok 629 65b6 - Add ETS qdisc with 17 quanta
ok 630 b9e9 - Add ETS qdisc with 16 strict + quanta
ok 631 9877 - Add ETS qdisc with 17 strict + quanta
ok 632 c696 - Add ETS qdisc with priomap
ok 633 30c4 - Add ETS qdisc with quanta + priomap
ok 634 e8ac - Add ETS qdisc with strict + priomap
ok 635 5a7e - Add ETS qdisc with quanta + strict + priomap
ok 636 cb8b - Show ETS class :1
ok 637 1b4e - Show ETS class :2
ok 638 f642 - Show ETS class :3
ok 639 0a5f - Show ETS strict class
ok 640 f7c8 - Add ETS qdisc with too many quanta
ok 641 2389 - Add ETS qdisc with too many strict
ok 642 fe3c - Add ETS qdisc with too many strict + quanta
ok 643 cb04 - Add ETS qdisc with excess priomap elements
ok 644 c32e - Add ETS qdisc with priomap above bands
ok 645 744c - Add ETS qdisc with priomap above quanta
ok 646 7b33 - Add ETS qdisc with priomap above strict
ok 647 dbe6 - Add ETS qdisc with priomap above strict + quanta
ok 648 bdb2 - Add ETS qdisc with priomap within bands with strict + quanta
ok 649 39a3 - Add ETS qdisc with priomap above bands with strict + quanta
ok 650 557c - Unset priorities default to the last band
ok 651 a347 - Unset priorities default to the last band -- no priomap
ok 652 39c4 - Add ETS qdisc with too few bands
ok 653 930b - Add ETS qdisc with too many bands
ok 654 406a - Add ETS qdisc without parameters
ok 655 e51a - Zero element in quanta
ok 656 e7f2 - Sole zero element in quanta
ok 657 d6e6 - No values after the quanta keyword
ok 658 28c6 - Change ETS band quantum
ok 659 4714 - Change ETS band without quantum
ok 660 6979 - Change quantum of a strict ETS band
ok 661 9a7d - Change ETS strict band without quantum
ok 662 34ba - Create ETF with default setting
ok 663 438f - Create ETF with delta nanos setting
ok 664 9041 - Create ETF with deadline_mode setting
ok 665 9a0c - Create ETF with skip_sock_check setting
ok 666 2093 - Delete ETF with valid handle
ok 667 84a0 - Create TEQL with default setting
ok 668 7734 - Create TEQL with multiple device
ok 669 34a9 - Delete TEQL with valid handle
ok 670 6289 - Show TEQL stats
ok 671 6430 - Create TBF with default setting
ok 672 0518 - Create TBF with mtu setting
ok 673 320a - Create TBF with peakrate setting
ok 674 239b - Create TBF with latency setting
ok 675 c975 - Create TBF with overhead setting
ok 676 948c - Create TBF with linklayer setting
ok 677 3549 - Replace TBF with mtu
ok 678 f948 - Change TBF with latency time
ok 679 2348 - Show TBF class
ok 680 8b6e - Create RED with no flags
ok 681 342e - Create RED with adaptive flag
ok 682 2d4b - Create RED with ECN flag
ok 683 650f - Create RED with flags ECN, adaptive
ok 684 5f15 - Create RED with flags ECN, harddrop
ok 685 53e8 - Create RED with flags ECN, nodrop
ok 686 d091 - Fail to create RED with only nodrop flag
ok 687 af8e - Create RED with flags ECN, nodrop, harddrop
ok 688 290a - Show RED class
ok 689 1212 - Create CAKE with default setting
ok 690 3281 - Create CAKE with bandwidth limit
ok 691 c940 - Create CAKE with autorate-ingress flag
ok 692 2310 - Create CAKE with rtt time
ok 693 2385 - Create CAKE with besteffort flag
ok 694 a032 - Create CAKE with diffserv8 flag
ok 695 2349 - Create CAKE with diffserv4 flag
ok 696 8472 - Create CAKE with flowblind flag
ok 697 2341 - Create CAKE with dsthost and nat flag
ok 698 5134 - Create CAKE with wash flag
ok 699 2302 - Create CAKE with flowblind and no-split-gso flag
ok 700 0768 - Create CAKE with dual-srchost and ack-filter flag
ok 701 0238 - Create CAKE with dual-dsthost and ack-filter-aggressive flag
ok 702 6572 - Create CAKE with memlimit and ptm flag
ok 703 2436 - Create CAKE with fwmark and atm flag
ok 704 3984 - Create CAKE with overhead and mpu
ok 705 5421 - Create CAKE with conservative and ingress flag
ok 706 6854 - Delete CAKE with conservative and ingress flag
ok 707 2342 - Replace CAKE with mpu
ok 708 2313 - Change CAKE with mpu
ok 709 4365 - Show CAKE class
ok 710 ddd9 - Add prio qdisc on egress
ok 711 aa71 - Add prio qdisc on egress with handle of maximum value
ok 712 db37 - Add prio qdisc on egress with invalid handle exceeding maximum value
ok 713 39d8 - Add prio qdisc on egress with unsupported argument
ok 714 5769 - Add prio qdisc on egress with 4 bands and new priomap
ok 715 fe0f - Add prio qdisc on egress with 4 bands and priomap exceeding TC_PRIO_MAX entries
ok 716 1f91 - Add prio qdisc on egress with 4 bands and priomap's values exceeding bands number
ok 717 d248 - Add prio qdisc on egress with invalid bands value (< 2)
ok 718 1d0e - Add prio qdisc on egress with invalid bands value exceeding TCQ_PRIO_BANDS
ok 719 1971 - Replace default prio qdisc on egress with 8 bands and new priomap
ok 720 d88a - Add duplicate prio qdisc on egress
ok 721 5948 - Delete nonexistent prio qdisc
ok 722 6c0a - Add prio qdisc on egress with invalid format for handles
ok 723 0175 - Delete prio qdisc twice
ok 724 2410 - Show prio class
ok 725 8942 - Create GRED with default setting
ok 726 5783 - Create GRED with grio setting
ok 727 8a09 - Create GRED with limit setting
ok 728 48ca - Create GRED with ecn setting
ok 729 48cb - Create GRED with harddrop setting
ok 730 763a - Change GRED setting
ok 731 8309 - Show GRED class
ok 732 3254 - Create HFSC with default setting
ok 733 0289 - Create HFSC with class sc and ul rate setting
ok 734 846a - Create HFSC with class sc umax and dmax setting
ok 735 5413 - Create HFSC with class rt and ls rate setting
ok 736 9312 - Create HFSC with class rt umax and dmax setting
ok 737 6931 - Delete HFSC with handle
ok 738 8436 - Show HFSC class
ok 739 bef4 - HFSC rt inner class upgrade to sc
ok 740 983a - Create CODEL with default setting
ok 741 38aa - Create CODEL with limit packet setting
ok 742 9178 - Create CODEL with target setting
ok 743 78d1 - Create CODEL with interval setting
ok 744 238a - Create CODEL with ecn setting
ok 745 939c - Create CODEL with ce_threshold setting
ok 746 8380 - Delete CODEL with valid handle
ok 747 289c - Replace CODEL with limit setting
ok 748 0648 - Change CODEL with limit setting
ok 749 83be - Create FQ-PIE with invalid number of flows
ok 750 3289 - Create PLUG with default setting
ok 751 0917 - Create PLUG with block setting
ok 752 483b - Create PLUG with release setting
ok 753 4995 - Create PLUG with release_indefinite setting
ok 754 389c - Create PLUG with limit setting
ok 755 384a - Delete PLUG with valid handle
ok 756 439a - Replace PLUG with limit setting
ok 757 9831 - Change PLUG with limit setting
ok 758 8937 - Create CHOKE with default setting
ok 759 48c0 - Create CHOKE with min packet setting
ok 760 38c1 - Create CHOKE with max packet setting
ok 761 234a - Create CHOKE with ecn setting
ok 762 4380 - Create CHOKE with burst setting
ok 763 48c7 - Delete CHOKE with valid handle
ok 764 4398 - Replace CHOKE with min setting
ok 765 0301 - Change CHOKE with limit setting
ok 766 3294 - Create SFB with default setting
ok 767 430a - Create SFB with rehash setting
ok 768 3410 - Create SFB with db setting
ok 769 49a0 - Create SFB with limit setting
ok 770 1241 - Create SFB with max setting
ok 771 3249 - Create SFB with target setting
ok 772 30a9 - Create SFB with increment setting
ok 773 239a - Create SFB with decrement setting
ok 774 9301 - Create SFB with penalty_rate setting
ok 775 2a01 - Create SFB with penalty_burst setting
ok 776 3209 - Change SFB with rehash setting
ok 777 5447 - Show SFB class
ok 778 900c - Create pfifo_fast with default setting
ok 779 7470 - Dump pfifo_fast stats
ok 780 b974 - Replace pfifo_fast with different handle
ok 781 3240 - Delete pfifo_fast with valid handle
ok 782 4385 - Delete pfifo_fast with invalid handle
ok 783 ba39 - Add taprio Qdisc to multi-queue device (8 queues)
ok 784 9462 - Add taprio Qdisc with multiple sched-entry
ok 785 8d92 - Add taprio Qdisc with txtime-delay
ok 786 d092 - Delete taprio Qdisc with valid handle
ok 787 8471 - Show taprio class
ok 788 0a85 - Add taprio Qdisc to single-queue device
ok 789 6f62 - Add taprio Qdisc with too short interval
ok 790 831f - Add taprio Qdisc with too short cycle-time
ok 791 3e1e - Add taprio Qdisc with an invalid cycle-time
ok 792 39b4 - Reject grafting taprio as child qdisc of software taprio
ok 793 e8a1 - Reject grafting taprio as child qdisc of offloaded taprio
ok 794 a7bf - Graft cbs as child of software taprio
ok 795 6a83 - Graft cbs as child of offloaded taprio
ok 796 ce7d - Add mq Qdisc to multi-queue device (4 queues)
ok 797 2f82 - Add mq Qdisc to multi-queue device (256 queues)
ok 798 c525 - Add duplicate mq Qdisc
ok 799 128a - Delete nonexistent mq Qdisc
ok 800 03a9 - Delete mq Qdisc twice
ok 801 be0f - Add mq Qdisc to single-queue device
ok 802 1023 - Show mq class
ok 803 0531 - Replace mq with invalid parent ID
ok 804 20ba - Add multiq Qdisc to multi-queue device (8 queues)
ok 805 4301 - List multiq Class
ok 806 7832 - Delete nonexistent multiq Qdisc
ok 807 2891 - Delete multiq Qdisc twice
ok 808 1329 - Add multiq Qdisc to single-queue device
ok 809 1820 - Create CBS with default setting
ok 810 1532 - Create CBS with hicredit setting
ok 811 2078 - Create CBS with locredit setting
ok 812 9271 - Create CBS with sendslope setting
ok 813 0482 - Create CBS with idleslope setting
ok 814 e8f3 - Create CBS with multiple setting
ok 815 23c9 - Replace CBS with sendslope setting
ok 816 a07a - Change CBS with idleslope setting
ok 817 43b3 - Delete CBS with handle
ok 818 9472 - Show CBS class
ok 819 a519 - Add bfifo qdisc with system default parameters on egress
ok 820 585c - Add pfifo qdisc with system default parameters on egress
ok 821 a86e - Add bfifo qdisc with system default parameters on egress with handle of maximum value
ok 822 9ac8 - Add bfifo qdisc on egress with queue size of 3000 bytes
ok 823 f4e6 - Add pfifo qdisc on egress with queue size of 3000 packets
ok 824 b1b1 - Add bfifo qdisc with system default parameters on egress with invalid handle exceeding maximum value
ok 825 8d5e - Add bfifo qdisc on egress with unsupported argument
ok 826 7787 - Add pfifo qdisc on egress with unsupported argument
ok 827 c4b6 - Replace bfifo qdisc on egress with new queue size
ok 828 3df6 - Replace pfifo qdisc on egress with new queue size
ok 829 7a67 - Add bfifo qdisc on egress with queue size in invalid format
ok 830 1298 - Add duplicate bfifo qdisc on egress
ok 831 45a0 - Delete nonexistent bfifo qdisc
ok 832 972b - Add prio qdisc on egress with invalid format for handles
ok 833 4d39 - Delete bfifo qdisc twice
ok 834 cb28 - Create NETEM with default setting
ok 835 a089 - Create NETEM with limit flag
ok 836 3449 - Create NETEM with delay time
ok 837 3782 - Create NETEM with distribution and corrupt flag
ok 838 2b82 - Create NETEM with distribution and duplicate flag
ok 839 a932 - Create NETEM with distribution and loss flag
ok 840 e01a - Create NETEM with distribution and loss state flag
ok 841 ba29 - Create NETEM with loss gemodel flag
ok 842 0492 - Create NETEM with reorder flag
ok 843 7862 - Create NETEM with rate limit
ok 844 7235 - Create NETEM with multiple slot rate
ok 845 5439 - Create NETEM with multiple slot setting
ok 846 5029 - Change NETEM with loss state
ok 847 3785 - Replace NETEM with delay time
ok 848 4502 - Delete NETEM with handle
ok 849 0785 - Show NETEM class
ok 850 983b - Create FQ with default setting
ok 851 38a1 - Create FQ with limit packet setting
ok 852 0a18 - Create FQ with flow_limit setting
ok 853 2390 - Create FQ with quantum setting
ok 854 845b - Create FQ with initial_quantum setting
ok 855 10f7 - Create FQ with invalid initial_quantum setting
ok 856 9398 - Create FQ with maxrate setting
ok 857 342c - Create FQ with nopacing setting
ok 858 6391 - Create FQ with refill_delay setting
ok 859 238b - Create FQ with low_rate_threshold setting
ok 860 7582 - Create FQ with orphan_mask setting
ok 861 4894 - Create FQ with timer_slack setting
ok 862 324c - Create FQ with ce_threshold setting
ok 863 424a - Create FQ with horizon time setting
ok 864 89e1 - Create FQ with horizon_cap setting
ok 865 32e1 - Delete FQ with valid handle
ok 866 49b0 - Replace FQ with limit setting
ok 867 9478 - Change FQ with limit setting
ok 868 4957 - Create FQ_CODEL with default setting
ok 869 7621 - Create FQ_CODEL with limit setting
ok 870 6871 - Create FQ_CODEL with memory_limit setting
ok 871 5636 - Create FQ_CODEL with target setting
ok 872 630a - Create FQ_CODEL with interval setting
ok 873 4324 - Create FQ_CODEL with quantum setting
ok 874 b190 - Create FQ_CODEL with noecn flag
ok 875 5381 - Create FQ_CODEL with ce_threshold setting
ok 876 c9d2 - Create FQ_CODEL with drop_batch setting
ok 877 523b - Create FQ_CODEL with multiple setting
ok 878 9283 - Replace FQ_CODEL with noecn setting
ok 879 3459 - Change FQ_CODEL with limit setting
ok 880 0128 - Delete FQ_CODEL with handle
ok 881 0435 - Show FQ_CODEL class
ok 882 283e - Create skbprio with default setting
ok 883 c086 - Create skbprio with limit setting
ok 884 6733 - Change skbprio with limit setting
ok 885 2958 - Show skbprio class
ok 886 9872 - Add ingress qdisc
ok 887 5c5e - Add ingress qdisc with unsupported argument
ok 888 74f6 - Add duplicate ingress qdisc
ok 889 f769 - Delete nonexistent ingress qdisc
ok 890 3b88 - Delete ingress qdisc twice
ok 891 0521 - Show ingress class
ok 892 afa9 - Add u32 with source match
ok 893 6aa7 - Add/Replace u32 with source match and invalid indev
ok 894 bc4d - Replace valid u32 with source match and invalid indev
ok 895 648b - Add u32 with custom hash table
ok 896 6658 - Add/Replace u32 with custom hash table and invalid handle
ok 897 9d0a - Replace valid u32 with custom hash table and invalid handle
ok 898 1644 - Add u32 filter that links to a custom hash table
ok 899 74c2 - Add/Replace u32 filter with invalid hash table id
ok 900 1fe6 - Replace valid u32 filter with invalid hash table id
ok 901 0692 - Test u32 sample option, divisor 256
ok 902 2478 - Test u32 sample option, divisor 16
ok 903 0c37 - Try to delete class referenced by u32 after a replace
ok 904 bd32 - Try to delete hashtable referenced by another u32 filter
ok 905 4585 - Delete small tree of u32 hashtables and filters
ok 906 7a92 - Add basic filter with cmp ematch u8/link layer and default action
ok 907 2e8a - Add basic filter with cmp ematch u8/link layer with trans flag and default action
ok 908 4d9f - Add basic filter with cmp ematch u16/link layer and a single action
ok 909 4943 - Add basic filter with cmp ematch u32/link layer and miltiple actions
ok 910 7559 - Add basic filter with cmp ematch u8/network layer and default action
ok 911 aff4 - Add basic filter with cmp ematch u8/network layer with trans flag and default action
ok 912 c732 - Add basic filter with cmp ematch u16/network layer and a single action
ok 913 32d8 - Add basic filter with cmp ematch u32/network layer and miltiple actions
ok 914 b99c - Add basic filter with cmp ematch u8/transport layer and default action
ok 915 0752 - Add basic filter with cmp ematch u8/transport layer with trans flag and default action
ok 916 7e07 - Add basic filter with cmp ematch u16/transport layer and a single action
ok 917 62d7 - Add basic filter with cmp ematch u32/transport layer and miltiple actions
ok 918 304b - Add basic filter with NOT cmp ematch rule and default action
ok 919 8ecb - Add basic filter with two ANDed cmp ematch rules and single action
ok 920 b1ad - Add basic filter with two ORed cmp ematch rules and single action
ok 921 4600 - Add basic filter with two ANDed cmp ematch rules and one ORed ematch rule and single action
ok 922 bc59 - Add basic filter with two ANDed cmp ematch rules and one NOT ORed ematch rule and single action
ok 923 bae4 - Add basic filter with u32 ematch u8/zero offset and default action
ok 924 e6cb - Add basic filter with u32 ematch u8/zero offset and invalid value >0xFF
ok 925 7727 - Add basic filter with u32 ematch u8/positive offset and default action
ok 926 a429 - Add basic filter with u32 ematch u8/invalid mask >0xFF
ok 927 8373 - Add basic filter with u32 ematch u8/missing offset
ok 928 ab8e - Add basic filter with u32 ematch u8/missing AT keyword
ok 929 712d - Add basic filter with u32 ematch u8/missing value
ok 930 350f - Add basic filter with u32 ematch u8/non-numeric value
ok 931 e28f - Add basic filter with u32 ematch u8/non-numeric mask
ok 932 6d5f - Add basic filter with u32 ematch u8/negative offset and default action
ok 933 12dc - Add basic filter with u32 ematch u8/nexthdr+ offset and default action
ok 934 1d85 - Add basic filter with u32 ematch u16/zero offset and default action
ok 935 3672 - Add basic filter with u32 ematch u16/zero offset and invalid value >0xFFFF
ok 936 7fb0 - Add basic filter with u32 ematch u16/positive offset and default action
ok 937 19af - Add basic filter with u32 ematch u16/invalid mask >0xFFFF
ok 938 446d - Add basic filter with u32 ematch u16/missing offset
ok 939 151b - Add basic filter with u32 ematch u16/missing AT keyword
ok 940 bb23 - Add basic filter with u32 ematch u16/missing value
ok 941 decc - Add basic filter with u32 ematch u16/non-numeric value
ok 942 e988 - Add basic filter with u32 ematch u16/non-numeric mask
ok 943 07d8 - Add basic filter with u32 ematch u16/negative offset and default action
ok 944 f474 - Add basic filter with u32 ematch u16/nexthdr+ offset and default action
ok 945 47a0 - Add basic filter with u32 ematch u32/zero offset and default action
ok 946 849f - Add basic filter with u32 ematch u32/positive offset and default action
ok 947 d288 - Add basic filter with u32 ematch u32/missing offset
ok 948 4998 - Add basic filter with u32 ematch u32/missing AT keyword
ok 949 1f0a - Add basic filter with u32 ematch u32/missing value
ok 950 848e - Add basic filter with u32 ematch u32/non-numeric value
ok 951 f748 - Add basic filter with u32 ematch u32/non-numeric mask
ok 952 55a6 - Add basic filter with u32 ematch u32/negative offset and default action
ok 953 7282 - Add basic filter with u32 ematch u32/nexthdr+ offset and default action
ok 954 b2b6 - Add basic filter with canid ematch and single SFF
ok 955 f67f - Add basic filter with canid ematch and single SFF with mask
ok 956 bd5c - Add basic filter with canid ematch and multiple SFF
ok 957 83c7 - Add basic filter with canid ematch and multiple SFF with masks
ok 958 a8f5 - Add basic filter with canid ematch and single EFF
ok 959 98ae - Add basic filter with canid ematch and single EFF with mask
ok 960 6056 - Add basic filter with canid ematch and multiple EFF
ok 961 d188 - Add basic filter with canid ematch and multiple EFF with masks
ok 962 25d1 - Add basic filter with canid ematch and a combination of SFF/EFF
ok 963 b438 - Add basic filter with canid ematch and a combination of SFF/EFF with masks
ok 964 0811 - Add multiple basic filter with cmp ematch u8/link layer and default action and dump them
ok 965 5129 - List basic filters
ok 966 901f - Add fw filter with prio at 32-bit maxixum
ok 967 51e2 - Add fw filter with prio exceeding 32-bit maxixum
ok 968 d987 - Add fw filter with action ok
ok 969 c591 - Add fw filter with action ok by reference
ok 970 affe - Add fw filter with action continue
ok 971 38b3 - Add fw filter with action continue by reference
ok 972 28bc - Add fw filter with action pipe
ok 973 6753 - Add fw filter with action pipe by reference
ok 974 8da2 - Add fw filter with action drop
ok 975 6dc6 - Add fw filter with action drop by reference
ok 976 9436 - Add fw filter with action reclassify
ok 977 3bc2 - Add fw filter with action reclassify by reference
ok 978 95bb - Add fw filter with action jump 10
ok 979 36f7 - Add fw filter with action jump 10 by reference
ok 980 3d74 - Add fw filter with action goto chain 5
ok 981 eb8f - Add fw filter with invalid action
ok 982 6a79 - Add fw filter with missing mandatory action
ok 983 8298 - Add fw filter with cookie
ok 984 a88c - Add fw filter with invalid cookie
ok 985 10f6 - Add fw filter with handle in hex
ok 986 9d51 - Add fw filter with handle at 32-bit maximum
ok 987 d939 - Add fw filter with handle exceeding 32-bit maximum
ok 988 658c - Add fw filter with mask in hex
ok 989 86be - Add fw filter with mask at 32-bit maximum
ok 990 e635 - Add fw filter with mask exceeding 32-bit maximum
ok 991 6cab - Add fw filter with handle/mask in hex
ok 992 8700 - Add fw filter with handle/mask at 32-bit maximum
ok 993 7d62 - Add fw filter with handle/mask exceeding 32-bit maximum
ok 994 7b69 - Add fw filter with missing mandatory handle
ok 995 d68b - Add fw filter with invalid parent
ok 996 66e0 - Add fw filter with missing mandatory parent id
ok 997 0ff3 - Add fw filter with classid
ok 998 9849 - Add fw filter with classid at root
ok 999 b7ff - Add fw filter with classid - keeps last 8 (hex) digits
ok 1000 2b18 - Add fw filter with invalid classid
ok 1001 fade - Add fw filter with flowid
ok 1002 33af - Add fw filter with flowid then classid (same arg, takes second)
ok 1003 8a8c - Add fw filter with classid then flowid (same arg, takes second)
ok 1004 b50d - Add fw filter with handle val/mask and flowid 10:1000
ok 1005 7207 - Add fw filter with protocol ip
ok 1006 306d - Add fw filter with protocol ipv6
ok 1007 9a78 - Add fw filter with protocol arp
ok 1008 1821 - Add fw filter with protocol 802_3
ok 1009 2260 - Add fw filter with invalid protocol
ok 1010 09d7 - Add fw filters protocol 802_3 and ip with conflicting priorities
ok 1011 6973 - Add fw filters with same index, same action
ok 1012 fc06 - Add fw filters with action police
ok 1013 aac7 - Add fw filters with action police linklayer atm
ok 1014 5339 - Del entire fw filter
ok 1015 0e99 - Del single fw filter x1
ok 1016 f54c - Del single fw filter x2
ok 1017 ba94 - Del fw filter by prio
ok 1018 4acb - Del fw filter by chain
ok 1019 3424 - Del fw filter by action (invalid)
ok 1020 da89 - Del fw filter by handle (invalid)
ok 1021 4d95 - Del fw filter by protocol (invalid)
ok 1022 4736 - Del fw filter by flowid (invalid)
ok 1023 3dcb - Replace fw filter action
ok 1024 eb4d - Replace fw filter classid
ok 1025 67ec - Replace fw filter index
ok 1026 e470 - Try to delete class referenced by fw after a replace
ok 1027 ec1a - Replace fw classid with nil
ok 1028 5294 - Add flow filter with map key and ops
ok 1029 3514 - Add flow filter with map key or ops
ok 1030 7534 - Add flow filter with map key xor ops
ok 1031 4524 - Add flow filter with map key rshift ops
ok 1032 0230 - Add flow filter with map key addend ops
ok 1033 2344 - Add flow filter with src map key
ok 1034 9304 - Add flow filter with proto map key
ok 1035 9038 - Add flow filter with proto-src map key
ok 1036 2a03 - Add flow filter with proto-dst map key
ok 1037 a073 - Add flow filter with iif map key
ok 1038 3b20 - Add flow filter with priority map key
ok 1039 8945 - Add flow filter with mark map key
ok 1040 c034 - Add flow filter with nfct map key
ok 1041 0205 - Add flow filter with nfct-src map key
ok 1042 5315 - Add flow filter with nfct-src map key
ok 1043 7849 - Add flow filter with nfct-proto-src map key
ok 1044 9902 - Add flow filter with nfct-proto-dst map key
ok 1045 6742 - Add flow filter with rt-classid map key
ok 1046 5432 - Add flow filter with sk-uid map key
ok 1047 4134 - Add flow filter with sk-gid map key
ok 1048 4522 - Add flow filter with vlan-tag map key
ok 1049 4253 - Add flow filter with rxhash map key
ok 1050 4452 - Add flow filter with hash key list
ok 1051 4341 - Add flow filter with muliple ops
ok 1052 4392 - List flow filters
ok 1053 4322 - Change flow filter with map key num
ok 1054 2320 - Replace flow filter with map key num
ok 1055 3213 - Delete flow filter with map key num
ok 1056 23c3 - Add cBPF filter with valid bytecode
ok 1057 1563 - Add cBPF filter with invalid bytecode
ok 1058 2334 - Add eBPF filter with valid object-file
ok 1059 2373 - Add eBPF filter with invalid object-file
ok 1060 4423 - Replace cBPF bytecode
ok 1061 5122 - Delete cBPF filter
ok 1062 e0a9 - List cBPF filters
ok 1063 e122 - Add route filter with from and to tag
ok 1064 6573 - Add route filter with fromif and to tag
ok 1065 1362 - Add route filter with to flag and reclassify action
ok 1066 4720 - Add route filter with from flag and continue actions
ok 1067 2812 - Add route filter with form tag and pipe action
ok 1068 7994 - Add route filter with miltiple actions
ok 1069 4312 - List route filters
ok 1070 2634 - Delete route filter with pipe action
ok 1071 b042 - Try to delete class referenced by route after a replace
ok 1072 f62b - Add ingress matchall filter for protocol ipv4 and action PASS
ok 1073 7f09 - Add egress matchall filter for protocol ipv4 and action PASS
ok 1074 0596 - Add ingress matchall filter for protocol ipv6 and action DROP
ok 1075 41df - Add egress matchall filter for protocol ipv6 and action DROP
ok 1076 e1da - Add ingress matchall filter for protocol ipv4 and action PASS with priority at 16-bit maximum
ok 1077 3de5 - Add egress matchall filter for protocol ipv4 and action PASS with priority at 16-bit maximum
ok 1078 72d7 - Add ingress matchall filter for protocol ipv4 and action PASS with priority exceeding 16-bit maximum
ok 1079 41d3 - Add egress matchall filter for protocol ipv4 and action PASS with priority exceeding 16-bit maximum
ok 1080 f755 - Add ingress matchall filter for all protocols and action CONTINUE with handle at 32-bit maximum
ok 1081 2c33 - Add egress matchall filter for all protocols and action CONTINUE with handle at 32-bit maximum
ok 1082 0e4a - Add ingress matchall filter for all protocols and action RECLASSIFY with skip_hw flag
ok 1083 7f60 - Add egress matchall filter for all protocols and action RECLASSIFY with skip_hw flag
ok 1084 8bd2 - Add ingress matchall filter for protocol ipv6 and action PASS with classid
ok 1085 2a4a - Add ingress matchall filter for protocol ipv6 and action PASS with invalid classid
ok 1086 eaf8 - Delete single ingress matchall filter
ok 1087 76ad - Delete all ingress matchall filters
ok 1088 1eb9 - Delete single ingress matchall filter out of multiple
ok 1089 6d63 - Delete ingress matchall filter by chain ID
ok 1090 3329 - Validate flags of the matchall filter with skip_sw and police action with skip_hw
ok 1091 0eeb - Validate flags of the matchall filter with skip_hw and police action
ok 1092 eee4 - Validate flags of the matchall filter with skip_sw and police action
ok 1093 2638 - Add matchall and try to get it
ok 1094 6273 - Add cgroup filter with cmp ematch u8/link layer and drop action
ok 1095 4721 - Add cgroup filter with cmp ematch u8/link layer with trans flag and pass action
ok 1096 d392 - Add cgroup filter with cmp ematch u16/link layer and pipe action
ok 1097 0234 - Add cgroup filter with cmp ematch u32/link layer and miltiple actions
ok 1098 8499 - Add cgroup filter with cmp ematch u8/network layer and pass action
ok 1099 b273 - Add cgroup filter with cmp ematch u8/network layer with trans flag and drop action
ok 1100 1934 - Add cgroup filter with cmp ematch u16/network layer and pipe action
ok 1101 2733 - Add cgroup filter with cmp ematch u32/network layer and miltiple actions
ok 1102 3271 - Add cgroup filter with NOT cmp ematch rule and pass action
ok 1103 2362 - Add cgroup filter with two ANDed cmp ematch rules and single action
ok 1104 9993 - Add cgroup filter with two ORed cmp ematch rules and single action
ok 1105 2331 - Add cgroup filter with two ANDed cmp ematch rules and one ORed ematch rule and single action
ok 1106 3645 - Add cgroup filter with two ANDed cmp ematch rules and one NOT ORed ematch rule and single action
ok 1107 b124 - Add cgroup filter with u32 ematch u8/zero offset and drop action
ok 1108 7381 - Add cgroup filter with u32 ematch u8/zero offset and invalid value >0xFF
ok 1109 2231 - Add cgroup filter with u32 ematch u8/positive offset and drop action
ok 1110 1882 - Add cgroup filter with u32 ematch u8/invalid mask >0xFF
ok 1111 1237 - Add cgroup filter with u32 ematch u8/missing offset
ok 1112 3812 - Add cgroup filter with u32 ematch u8/missing AT keyword
ok 1113 1112 - Add cgroup filter with u32 ematch u8/missing value
ok 1114 3241 - Add cgroup filter with u32 ematch u8/non-numeric value
ok 1115 e231 - Add cgroup filter with u32 ematch u8/non-numeric mask
ok 1116 4652 - Add cgroup filter with u32 ematch u8/negative offset and pass action
ok 1117 7566 - Add cgroup filter with u32 ematch u8/nexthdr+ offset and drop action
ok 1118 1331 - Add cgroup filter with u32 ematch u16/zero offset and pipe action
ok 1119 e354 - Add cgroup filter with u32 ematch u16/zero offset and invalid value >0xFFFF
ok 1120 3538 - Add cgroup filter with u32 ematch u16/positive offset and drop action
ok 1121 4576 - Add cgroup filter with u32 ematch u16/invalid mask >0xFFFF
ok 1122 b842 - Add cgroup filter with u32 ematch u16/missing offset
ok 1123 c924 - Add cgroup filter with u32 ematch u16/missing AT keyword
ok 1124 cc93 - Add cgroup filter with u32 ematch u16/missing value
ok 1125 123c - Add cgroup filter with u32 ematch u16/non-numeric value
ok 1126 3675 - Add cgroup filter with u32 ematch u16/non-numeric mask
ok 1127 1123 - Add cgroup filter with u32 ematch u16/negative offset and drop action
ok 1128 4234 - Add cgroup filter with u32 ematch u16/nexthdr+ offset and pass action
ok 1129 e912 - Add cgroup filter with u32 ematch u32/zero offset and pipe action
ok 1130 1435 - Add cgroup filter with u32 ematch u32/positive offset and drop action
ok 1131 1282 - Add cgroup filter with u32 ematch u32/missing offset
ok 1132 6456 - Add cgroup filter with u32 ematch u32/missing AT keyword
ok 1133 4231 - Add cgroup filter with u32 ematch u32/missing value
ok 1134 2131 - Add cgroup filter with u32 ematch u32/non-numeric value
ok 1135 f125 - Add cgroup filter with u32 ematch u32/non-numeric mask
ok 1136 4316 - Add cgroup filter with u32 ematch u32/negative offset and drop action
ok 1137 23ae - Add cgroup filter with u32 ematch u32/nexthdr+ offset and pipe action
ok 1138 23a1 - Add cgroup filter with canid ematch and single SFF
ok 1139 324f - Add cgroup filter with canid ematch and single SFF with mask
ok 1140 2576 - Add cgroup filter with canid ematch and multiple SFF
ok 1141 4839 - Add cgroup filter with canid ematch and multiple SFF with masks
ok 1142 6713 - Add cgroup filter with canid ematch and single EFF
ok 1143 4572 - Add cgroup filter with canid ematch and single EFF with mask
ok 1144 8031 - Add cgroup filter with canid ematch and multiple EFF
ok 1145 ab9d - Add cgroup filter with canid ematch and multiple EFF with masks
ok 1146 5349 - Add cgroup filter with canid ematch and a combination of SFF/EFF
ok 1147 c934 - Add cgroup filter with canid ematch and a combination of SFF/EFF with masks
ok 1148 4319 - Replace cgroup filter with diffferent match
ok 1149 4636 - Delete cgroup filter
ok 1150 e41d - Add 1M flower filters with 10 parallel tc instances # skipped - Tests using the DEV2 variable must define the name of a physical NIC with the -d option when running tdc.
Test has been skipped.

ok 1151 6f52 - Delete 1M flower filters with 10 parallel tc instances # skipped - Tests using the DEV2 variable must define the name of a physical NIC with the -d option when running tdc.
Test has been skipped.

ok 1152 c9da - Replace 1M flower filters with 10 parallel tc instances # skipped - Tests using the DEV2 variable must define the name of a physical NIC with the -d option when running tdc.
Test has been skipped.

ok 1153 14be - Concurrently replace same range of 100k flower filters from 10 tc instances # skipped - Tests using the DEV2 variable must define the name of a physical NIC with the -d option
when running tdc.
Test has been skipped.

ok 1154 0c44 - Concurrently delete same range of 100k flower filters from 10 tc instances # skipped - Tests using the DEV2 variable must define the name of a physical NIC with the -d option w
hen running tdc.
Test has been skipped.

ok 1155 ab62 - Add and delete from same tp with 10 tc instances # skipped - Tests using the DEV2 variable must define the name of a physical NIC with the -d option when running tdc.
Test has been skipped.

ok 1156 6e8f - Replace and delete from same tp with 10 tc instances # skipped - Tests using the DEV2 variable must define the name of a physical NIC with the -d option when running tdc.
Test has been skipped.

ok 1157 2ff3 - Add flower with max handle and then dump it # skipped - Tests using the DEV2 variable must define the name of a physical NIC with the -d option when running tdc.
Test has been skipped.

ok 1158 d052 - Add 1M filters with the same action # skipped - Tests using the DEV2 variable must define the name of a physical NIC with the -d option when running tdc.
Test has been skipped.

ok 1159 4cbd - Try to add filter with duplicate key # skipped - Tests using the DEV2 variable must define the name of a physical NIC with the -d option when running tdc.
Test has been skipped.

ok 1160 7c65 - Add flower filter and then terse dump it # skipped - Tests using the DEV2 variable must define the name of a physical NIC with the -d option when running tdc.
Test has been skipped.

ok 1161 d45e - Add flower filter and verify that terse dump doesn't output filter key # skipped - Tests using the DEV2 variable must define the name of a physical NIC with the -d option when
running tdc.
Test has been skipped.

