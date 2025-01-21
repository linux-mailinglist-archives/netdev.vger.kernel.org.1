Return-Path: <netdev+bounces-160083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECEFA180E8
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D021888F82
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A89C1F4E5A;
	Tue, 21 Jan 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="jMrpCw+L";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="Jl+ahBTR"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay40-hz1.antispameurope.com (mx-relay40-hz1.antispameurope.com [94.100.133.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9791F470D
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.133.216
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472569; cv=fail; b=k2EDuAnGHfEcH5g6/fGYPzn9Z0vXRxsDrJvnRwuk+bpXOoKFhA9eYMpituPT7feHNXLBdyR1GzsleZW1xiitaqyGuXmmKzfh2VQ3JY2aszFQ6vxlzjr3uYNsvmtwUNY2iyztcqzqSbpXB+fck2mP8MkSn2oZnS3kVdzpv/PlSPU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472569; c=relaxed/simple;
	bh=JSx5zRxv4XGG3Z+0JhIMP54loDVeJpYGBopI15Ojxi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oT9WAT71kJArdxOuWV77LO5J5U57eAjB86XZD+gxIsxxpHNWdiKrG3Zj0qwbtmSW3HAfdz3h+ICto1u6Zz5tM+YHLPPMriHnMiguxkaU6CaOj5qqmVrpXvd5QNt/pGKnJ9MpIWA1cjed7zWFcwLScH6Ct1Pci0OgRU+PYVmG8e4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=jMrpCw+L reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=Jl+ahBTR; arc=fail smtp.client-ip=94.100.133.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate40-hz1.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=104.47.11.108, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=eur02-db5-obe.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=I0v45D5zL1SVuLiMFL1gwBGw18lDt7blbVUTnwBb6/0=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1737472493;
 b=jwz8PYWTmjWivX9Szc2xWxs7hGKn8MaCPsSEqObrrQeYHEJPBkyGgLWV7ChtMEhqrmmWlcfO
 iYwTnBmywpYowBEnpoT2dcFv0X8dmvdrPt2NT4+yhq3Bp1nn2JeJvZTksppUlTElA/Z4RVl0g5O
 zLluvG+uaHhfZ6OOFnDydmGaoidqSiRk9bd54CHQL3Soj8u37tHE9vQyVgVg9jmNL3Us5iU6dvJ
 QbMrU1RVI9FTPjwJcufiVfjObPjxVNcQhjPnvtqjsx3arnqGfRGLBhR3zvBS/kEsLWF8xlM2xIk
 S7y3VAlNrzezxdwxk8mGC2X9pg9U4GNVtz3exCBsRQySQ==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1737472493;
 b=E7KCNepvQ9GakQHQkR5eir8Yh1vS5XeZ15x30/LYwArH0dxGLJYVw+J0iIwgZlwcrhKlLu45
 1ZSAUZv1T0mG+SCZZdo91UYKYea6dCU1B/ba/7nJaMKg6c2vLntMHeGfTabzTtwQDmzy5XS7xwD
 A4Ip6xYhmprLMFZ2VsoLgXHtT9oOSc5EH1jiFSww8Vhw2UozQp05ommY3uVcIucz3Cp+8DUg99E
 xQiSIECu/WV7yBa0qre9TpzyZzSHTv7KqiFmEVkboCzrql2g15jUeLCetI5BpOa1MNZrCry+J8O
 TP271SMhcK2HEeYkAccy/UJ48brxxiaQ1ycr0Z5T7aCWg==
Received: from mail-db5eur02lp2108.outbound.protection.outlook.com ([104.47.11.108]) by mx-relay40-hz1.antispameurope.com;
 Tue, 21 Jan 2025 16:14:53 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5iZr1nmimZpFko2IqeHy2mD7KlU/dqpwbpl9fF3467yTalu1Ksv/nZSTribyefzomO6PT8S3DFoadByOLFNpViOjqLJOI0f+CoopQEGugE/qfvwslcywFRl3v/Ami3A0oZXOeS6hz9eyrq9hB4D68SOiwEZXqQ1mTxxkv5SCgtKSVtFfd50VBzTJ83L24m2IjYRSOOygrkdGiNbE8FEWzOJdLV7N9qGYAyU9EZkZ8A8A2kndYqYZ2HMWXwW5dxoGxe+3yIVPdQvuATF86tZ5THv7S+y8Hj0NHK08Cxoc4wtTNhEzLPukqn3kZofqE4McvczniT6quffJmU4ShADvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0v45D5zL1SVuLiMFL1gwBGw18lDt7blbVUTnwBb6/0=;
 b=WSC2j2/GRES5j4BHJgP1W/vhdRhcNxpbsxMoQyZWBRLXQ3QJljtBHBgl/4C2UM79Jus35Aou/9qB17v4hYbYUSsqOlplqJjJ/5p5Fr0uLXmqdAH2y4b67RDTinr4d3U6RG5M7qM0hS/uOQjSfxzahmVJeJVj0mXU8IgmfIL48yp1ShLSVfJ+W8JI7BWqwlB6EeipJekw26vFDp1YssRm5cRI02+7cK5EBGhOERw6brfn1sRoWaw7Xa2YtdvFcIBf4OUiFH55lQfrDiNfbAXG4Fi9fHWjUKH702kCP9aLG7CbP41v09AgGUeDGy3x0cyR3mumGyEnNd1HSSUKjeE30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0v45D5zL1SVuLiMFL1gwBGw18lDt7blbVUTnwBb6/0=;
 b=jMrpCw+LOtp9rmejizr+avHlIukGwUbieLP3e0zp0tj0XjTzLtPqPIjygaLkpeybaLtuJrXu+9BCh1uA+WROf7cft+XYuP2eRAolFpgRo/igYsWfCBGYcibElMiMGbGHClDll7+qDjFGvuBqiIzVjps/dLQEdjeNsD7ap57z1pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:204::16)
 by PR3PR10MB4094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 15:14:25 +0000
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9]) by PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9%6]) with mapi id 15.20.8377.009; Tue, 21 Jan 2025
 15:14:24 +0000
Date: Tue, 21 Jan 2025 16:14:22 +0100
From: Stephan Wurm <stephan.wurm@a-eberle.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+671e2853f9851d039551@syzkaller.appspotmail.com,
	WingMan Kwok <w-kwok2@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	MD Danish Anwar <danishanwar@ti.com>, Jiri Pirko <jiri@nvidia.com>,
	George McCollister <george.mccollister@gmail.com>
Subject: Re: [PATCH net] net: hsr: avoid potential out-of-bound access in
 fill_frame_info()
Message-ID: <Z4-5zhRXZbjQ6XxE@PC-LX-SteWu>
References: <20241126144344.4177332-1-edumazet@google.com>
 <Z4o_UC0HweBHJ_cw@PC-LX-SteWu>
 <CANn89iLSPdPvotnGhPb3Rq2gkmpn3kLGJO8=3PDFrhSjUQSAkg@mail.gmail.com>
 <Z4pmD3l0XUApJhtD@PC-LX-SteWu>
 <CANn89i+e-V4hkUmUALsJe3ZQYtTkxduN5Sv+OiV+vzEmOdU1+Q@mail.gmail.com>
 <CANn89iJghv1JSwO7AVh97mU1Laj11SooiioZOHJ+UbUVeAcKUQ@mail.gmail.com>
 <Z4370QW5kLDptEEQ@PC-LX-SteWu>
 <CANn89iLMeMRtxBiOa7uZpG-8A0YNH=8NkhXmjfd2Qw4EZSZsNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLMeMRtxBiOa7uZpG-8A0YNH=8NkhXmjfd2Qw4EZSZsNQ@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0429.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::10) To PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:204::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4948:EE_|PR3PR10MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: e88908fa-fea7-4ae4-df76-08dd3a2e4a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkxhRklOZ3QzZHNUZzhUQ3hNWW9BUkxINzBib3lhaGUvL2cyQ2FGazZqTk9h?=
 =?utf-8?B?UnhoQ29hb3RoSHdTUWVOTVdSVlhTdGJmUEJKKzgvakRDMitkRHVqS0xoWHVp?=
 =?utf-8?B?U1A2cUFPWDdzKzRQVEMyZFB2MkY5MGRJT2RwaHhBOTQ5ekdyYldWeVIrMTFZ?=
 =?utf-8?B?Vm9SMGxDMm9nbG5nSllwb0plU0xISk9RenFjaFRaSU92NDQxc0dYVi9uWW1Q?=
 =?utf-8?B?NnJHd1JFeVlOUW9kTTVqaVhHQVJxSVBMQTRTdEpjaXBkakdwelczRkl1NWJM?=
 =?utf-8?B?MFVhYnNJUzJ6SXE0MDhWZ3hJTldzSVB5bDRaWTVZaDVUT3FjQkJVMWFOdDla?=
 =?utf-8?B?bGdOZkJkQjJhS1JFcExwSzlQeHdtUitIdk1NblNWRUFUbWtiRExOLysrVzFL?=
 =?utf-8?B?NFNoVXNxZlhyenFHbldQTUZCVTNRQUFuOEV1Z1ltOTN4b1dCZWdvazNPTGJn?=
 =?utf-8?B?Uk8xNlpxTVIycWVQbXhhaHE1UUMreStrSDBWcFRXMDdpWXdwZjRUZ0dNbDVx?=
 =?utf-8?B?TS9SRnNkRnZuUHF5cE9BcHVvNGNVMG1Mb1ZkcnhwOUZrQmRZVERpVVhxZkNs?=
 =?utf-8?B?aDYwdExrTzFsRnoxWnE1YUZMdmpWMmJxbWM2R29DSlJSQUM0UVhobzRzMllo?=
 =?utf-8?B?c1ozaGlzSmdqZGI4aVlkVm52R2E5VHBiTm9VVWNNMlZXM0lSYmRZTTF6dm1r?=
 =?utf-8?B?KzV3ODh1U3crUXR5UklpWDU0ZDZ5N3VVS0lTakpLNUppOTJtaEJBVWVrOUVv?=
 =?utf-8?B?WUlKcFpkTEhWMlJWUTNhOXpMNEtENytaYzFuclM2SzR3TlRZWkZ4U3hjdGVH?=
 =?utf-8?B?MUx0OXk2SGptRFpZZWZ1SnpXRzcrc3pPUVNKQXJHaEovMmpDcEQvVG9PVkhu?=
 =?utf-8?B?RkVrSUd1U1MyclNzOEVhaXNBZ29acjZrb2hkdVQ1Yy9wL1k2UC90VHBaOUo0?=
 =?utf-8?B?VzdqQVpEa0xmMEhVeWNFM2s0TXRLWEtJL1BhTkV1OHV1Y2RWSUMxWktuTzlZ?=
 =?utf-8?B?UTYzOGd5S2VtY0pJMC9mOUlEcUcycGhmRXlIdEI3aHpTQnMxUCtTVlRZT3ZH?=
 =?utf-8?B?b2ZuWVptWkF2dG5WTnlFNDN1T0xVYXBqMmUvdGlrZXR2Qy9pbWlwdnpDZWRs?=
 =?utf-8?B?WDV6Z0FMdWExY0VXOEp6OXJvMzNOTHB6NmxDcXl6N252Vmo4U0Vxc2dBNURM?=
 =?utf-8?B?a0tsb2NrS2JINEVhZGs4b0p4KzFpSVNpRGt0dXRzUzlUUzVGSTJ6RzJLTDZ0?=
 =?utf-8?B?cm8rcmI0SzVRTmJXK0NFVEZ6VnFCSkVLekxCcFBJZFpKMkpuakhVVHVCUm5q?=
 =?utf-8?B?RVUyeEF6S3EvdVQ5ZlU2ODVETjlVaGUxQ2FITURYODJ3U2FuRjZxVE1wSmZq?=
 =?utf-8?B?a2I4OHd1Z1hkS1BtOCtYbHgwTGlCQ3YzVGZJcXhrQUpzUFN5aURIOE1BYjgv?=
 =?utf-8?B?MnhMR29YZ292OVB0a0xERG0wWWNrakdyT3VxVWxYamZyRmVSTEpOWXc0NCto?=
 =?utf-8?B?ejBoejhNU3lSOURmdzhNSmFuUUVLUnpIZmhPWVI0eGpuRzNXZ2FqNDJnSlVM?=
 =?utf-8?B?dEl4Ym9hVTIwYjVZTUFJZUNlMi9ObzBjWUUvS3pscjh5d2NsN0NHaUFzTS9M?=
 =?utf-8?B?YktHWndpa0xpMVNSWFY0WlRDa0FoejRmNm04VjIzdWJ1Z0E2TmNsQ3VNUjB5?=
 =?utf-8?B?bmZHWm9UanBUdkIrQ0lkRXJJL29WU2d0U1B1SmJRSzlJUE0xc240V1ZPSXJ4?=
 =?utf-8?B?UXB5OFVXdWlIaEprQ0R0eXdCZzdMRWIxRFFLUGVTblJoSS9GVXQreXJGY2hG?=
 =?utf-8?B?MkFBNGR2UWNJSUk4VGxWelhZWE5laVFOODdteFh2VWVSVnB0WW1sbEc0TU5P?=
 =?utf-8?Q?8uFDfsfnMYBnG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0N5b0l2WDlyRHhtbFFhaTBOTlVDbElvTzJQVmJXbFNXTHQvMzdQNkhsdHFx?=
 =?utf-8?B?b1krbHhyZHY3STJSV1I3S1ZRUjFuTHhIclNEV25sRG1GQUFyMm9hWmlJb2N1?=
 =?utf-8?B?VEMvcGZXa1ZkTitRYTBrRUIzUmh6c05HYW1PT2lqa3MvdkFNanlFaXN2UlFY?=
 =?utf-8?B?Nit1U0tXcHlnZkpmaUZKVVZmMUVIOS9lRzhJaFlHRlBMc0d5QXNlcjV5TGp0?=
 =?utf-8?B?K0o4WmhjL3VxcDMrc1BEYmdsYm1DSkc2aGExRXg2cDFnZWVoQWN4dFVOV2xX?=
 =?utf-8?B?UHNwTS9tcHpLdzVzQXUrb0RLaTcyNU5nZFZtaUhIdU44cktWUUtmSUxTVnNR?=
 =?utf-8?B?UHdhbllIWS8ySytnWENCeEJKUi9tN2VNc1Fqby9DRVhxU015d2E1akFKQW5k?=
 =?utf-8?B?TWRPTUJLYk5kVkNxR1NvQzZvc3RoaFRBOWNDdDJjaVVUQUF4MFRLejhZQVNW?=
 =?utf-8?B?QjNiMFJ3dUZxcFRLMEdJQ0NkWHpLYVdrbzlsZzF0c3pRS1JOcUl5dEh0RzRs?=
 =?utf-8?B?ZE5uUUdFNzFuam1oZFNKR1V6SVlCc3I5SDJIMStjcE8wQk1nNzgxdC9tTUJo?=
 =?utf-8?B?VkNTUXJDV1I0bEMzdjVlNldzMy9CK1V0SWE1UmxXbS9NUlpZS2wwa2I2dUpQ?=
 =?utf-8?B?ZlVhY0xjWlBMVDlNLy9hVlp4S1hFNHRRVGdLV1JiQStUbjloSXNCWHBPTnpo?=
 =?utf-8?B?TmFhLzlKV1RBVktRekwwcGV0QlptM3A4LzJiZDI0aVNGRCtONUo5SytnYnJB?=
 =?utf-8?B?b3FtUTYybjZtdDNvVSt1SHQraXJ1VDZpbk84dFNQTWFsRlQxdnNBcU9sQjRj?=
 =?utf-8?B?U2NJTW1mTlBpbjlhb2h2VGJ1ODJaV1FLdjVicTlZYm56TXQ0QkN6NHpDYVFl?=
 =?utf-8?B?cFRmSklLenJFRGFRNm5tQ3dsaXZFOXExaWpFeHFtRWRzRFFZVXBCU05heSt5?=
 =?utf-8?B?dkVONkE2OXgzRHRzUHU1cjNYaU1saEo1S0h4c2ltT3RLU0ZuZk81RXIxN2R2?=
 =?utf-8?B?MHk1bjl4bTZzalc4ei80b3F2eHp2U2NQcDZLbWY3am9qbGxuWS9qY05ycFBr?=
 =?utf-8?B?M2hBazNVT2RlcEFMUDBlanl6YWt4T2NhVHRDM21TTXRvZTBoallvZ2VQc3dT?=
 =?utf-8?B?ekJzZDM5VG9TV0dLT3FvWnRIRmpqSGw3bXNjUkRUYm82UHBKTlJiVHgvU2dB?=
 =?utf-8?B?dkVNRVZqblM5cktZSGM3ais3azVteHQydEFlVEtxcE5VdkFEZ2g5MDF2U01X?=
 =?utf-8?B?T3lveGNsZlNnVHc4UW9yOEJ3TGRhOUg2eEZxMjdBOG5hamp6TmlGTWxwZ0tZ?=
 =?utf-8?B?eGNmN0hVOUFzVnJpWHFabGw1bk1jTksyTkFFdTN2Ym91cmU1ZWdNa1ZuZUlQ?=
 =?utf-8?B?alJXMi96Ync5OTF2OUFmY2VjRHUwcCtpNlNLME82YkJQaWJ0ZG9oM0JjcEt6?=
 =?utf-8?B?TkI3N1BnMlV2VTMzbmZaaUw5M3lTbXY2dW02dUpxcUdoalI3U0h5bTNiME1P?=
 =?utf-8?B?SDJ6bTBGVkZJVmZmZUtNM0E3UHhHNnZJMEkxcDB4U3lHZW1WVXg1M3orYk5P?=
 =?utf-8?B?a2RLNXdkZnhHYW12M0JKL1ZzUG9vRUxBVmtjMGx2MUNKWVpVMGNLR1lIRUgx?=
 =?utf-8?B?OFdnU3M0M2o5d05yU2ljeXBtQXZqcXB5TXJkMGpJMVlIWEUra09NbVh2aVFx?=
 =?utf-8?B?S2hGSm5NYTVxbkVONExBeDJHUmpFM041d2NYN1ZoY3R2cTFtNzg3VHA0aDVk?=
 =?utf-8?B?ZG9aSDZzRG9takh2cThHSFRkaTE0SjFZTFZiV2NhbndFb0pIT1lXTkVuV3BK?=
 =?utf-8?B?Q2I1akZiYm1nWHNlbkNLWDhjdmI4MlRlSU5IZnVRSUxmTW43eW5QRDJMSTEv?=
 =?utf-8?B?YzJ4Njl2b21FemxnVUdISU42U2E2VWgweXlIM1dwSWYwSmZORmsycHJveHhl?=
 =?utf-8?B?MXRiUGZHenREWFlZVndlNTl2a2ZKbnhZSlNQL1pKUEJkbVU4WHhKdEdDcmtO?=
 =?utf-8?B?WS9haEpndlJtaDJIR0REWXpnV3BXb1JkdjBLVG5vS3EyRnBUODdNZ3pFRk9T?=
 =?utf-8?B?aXRwazlNZFEzcDJmaVFoL1h4OTBBRFNrTGVMWGd4SjYvQnMwOEs4Q09NemZo?=
 =?utf-8?B?UVVoZDlleldGR0IySG1XREVUMUhFbm44ckd0WElrMSs3UEgwU3hKb0N2dXk1?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e88908fa-fea7-4ae4-df76-08dd3a2e4a16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 15:14:24.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Niaq/wPQeSOSw5ZQX44IVOe91Xa1jtXT2zPEDnTO1xS9ygwt4o0CJdiOikizaKgIld7/hRJdudl3SQ6xbovYyq5/Xx5FBgobcgXNRpqUS5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4094
X-cloud-security-sender:stephan.wurm@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: stephan.wurm@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay40-hz1.antispameurope.com with 4YcrN30bNMzFvkC
X-cloud-security-connect: mail-db5eur02lp2108.outbound.protection.outlook.com[104.47.11.108], TLS=1, IP=104.47.11.108
X-cloud-security-Digest:d84e669f455913a57b9fdbaab511b8db
X-cloud-security:scantime:2.529
DKIM-Signature: a=rsa-sha256;
 bh=I0v45D5zL1SVuLiMFL1gwBGw18lDt7blbVUTnwBb6/0=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1737472492; v=1;
 b=Jl+ahBTRkKjo7HG6S+GxRA9lymnlJUbsCQEnvmILZ4FsTnWbka6yTUq6nMnRTyeWRE22SZUe
 3GxvwLpasBs23EtJRydqenYEj4z9FVA6+d4LYtiqLNlR9OjUcchkDYquJZKXu51Ij3o4oSl472k
 rg8SI/p9sY93gFDjN/pOuT6Zhv4AR1NQfwCamihyuYE0NlPg+2A2Yi2oskIVh4cNNl2M9ZMkvnk
 NWnJ2qdMTh6mhd3eX4wl9nODMg3BfogGROr6ujuDR6q53GiClZZZnfCnS38HW/W2Qv68tJr1aVe
 K/VQN1LIMFhcrl6RBeXY6j4kGRwit6vFAdN40VlXyRKrQ==

Am 20. Jan 13:24 hat Eric Dumazet geschrieben:
> On Mon, Jan 20, 2025 at 8:32 AM Stephan Wurm <stephan.wurm@a-eberle.de> wrote:
> >
> > Applying the new instrumentation gives me the following stack trace:
> >
> > kernel: skb len=170 headroom=2 headlen=170 tailroom=20
> >         mac=(2,14) mac_len=14 net=(16,-1) trans=-1
> >         shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
> >         csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
> >         hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
> >         priority=0x0 mark=0x0 alloc_cpu=0 vlan_all=0x0
> >         encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
> > kernel: dev name=prp0 feat=0x0000000000007000
> > kernel: sk family=17 type=3 proto=0
> > kernel: skb headroom: 00000000: 74 00
> > kernel: skb linear:   00000000: 01 0c cd 01 00 01 00 d0 93 53 9c cb 81 00 80 00
> > kernel: skb linear:   00000010: 88 b8 00 01 00 98 00 00 00 00 61 81 8d 80 16 52
> > kernel: skb linear:   00000020: 45 47 44 4e 43 54 52 4c 2f 4c 4c 4e 30 24 47 4f
> > kernel: skb linear:   00000030: 24 47 6f 43 62 81 01 14 82 16 52 45 47 44 4e 43
> > kernel: skb linear:   00000040: 54 52 4c 2f 4c 4c 4e 30 24 44 73 47 6f 6f 73 65
> > kernel: skb linear:   00000050: 83 07 47 6f 49 64 65 6e 74 84 08 67 8d f5 93 7e
> > kernel: skb linear:   00000060: 76 c8 00 85 01 01 86 01 00 87 01 00 88 01 01 89
> > kernel: skb linear:   00000070: 01 00 8a 01 02 ab 33 a2 15 83 01 00 84 03 03 00
> > kernel: skb linear:   00000080: 00 91 08 67 8d f5 92 77 4b c6 1f 83 01 00 a2 1a
> > kernel: skb linear:   00000090: a2 06 85 01 00 83 01 00 84 03 03 00 00 91 08 67
> > kernel: skb linear:   000000a0: 8d f5 92 77 4b c6 1f 83 01 00
> > kernel: skb tailroom: 00000000: 80 18 02 00 fe 4e 00 00 01 01 08 0a 4f fd 5e d1
> > kernel: skb tailroom: 00000010: 4f fd 5e cd
> > kernel: ------------[ cut here ]------------
> > kernel: WARNING: CPU: 0 PID: 751 at /net/hsr/hsr_forward.c:605 fill_frame_info+0x180/0x19c
> > kernel: Modules linked in:
> > kernel: CPU: 0 PID: 751 Comm: reg61850 Not tainted 6.6.69-ga7a5cc0c39f0 #1
> > kernel: Hardware name: Freescale LS1021A
> > kernel:  unwind_backtrace from show_stack+0x10/0x14
> > kernel:  show_stack from dump_stack_lvl+0x40/0x4c
> > kernel:  dump_stack_lvl from __warn+0x94/0xc0
> > kernel:  __warn from warn_slowpath_fmt+0x1b4/0x1bc
> > kernel:  warn_slowpath_fmt from fill_frame_info+0x180/0x19c
> > kernel:  fill_frame_info from hsr_forward_skb+0x54/0x118
> > kernel:  hsr_forward_skb from hsr_dev_xmit+0x60/0xc4
> > kernel:  hsr_dev_xmit from dev_hard_start_xmit+0xa0/0xe4
> > kernel:  dev_hard_start_xmit from __dev_queue_xmit+0x144/0x5e8
> > kernel:  __dev_queue_xmit from packet_snd+0x5c0/0x784
> > kernel:  packet_snd from sock_write_iter+0xa0/0x10c
> > kernel:  sock_write_iter from vfs_write+0x3ac/0x41c
> > kernel:  vfs_write from ksys_write+0xbc/0xf0
> > kernel:  ksys_write from ret_fast_syscall+0x0/0x4c
> > kernel: Exception stack(0xc0d8dfa8 to 0xc0d8dff0)
> > kernel: dfa0:                   000000aa 73058e53 00000012 73058e53 000000aa 00000000
> > kernel: dfc0: 000000aa 73058e53 00000012 00000004 6ebf9940 0000000a 00000000 00000000
> > kernel: dfe0: 00000004 6ebf90f8 766a17ad 7661e5e6
> > kernel: ---[ end trace 0000000000000000 ]---
>
> Thanks.
>
> So hsr_forward() can be used in tx path, not forwarding as its name
> would imply... what a mess.
>
> It looks like it might be an af_packet issue, or an application bug.
>
> packet_parse_headers() should really for this vlan packet set the
> network header correctly.
>
> Otherwise, I do not see how hsr could use mac_len at all.
>
> I am afraid commit 48b491a5cc74333c ("net: hsr: fix mac_len checks")
> was not good enough.

I did some additional experiments.

First, I was able to get v6.13 running on the system, although it did
not fix my issue.

Then I played around with VLAN interfaces.

I created an explicit VLAN interface on top of the prp interface. In that
case the VLAN header gets transparently attached to the tx frames and
forwarding through the interface layers works as expected.

It was even possible to get my application working on top of the vlan
interface, but it resulted in two VLAN headers - the inner from the
application, the outer from the vlan interface.

So when sending vlan tagged frames directly from an application through
a prp interface the mac_len field does not get updated, even though the
VLAN protocol header is properly detected; when sending frames through
an explicit vlan interface, the mac_len seems to be properly parsed
into the skb.

Now I am running out of ideas how to proceed.

For the time being I would locally revert this fix, to make my
application working again.
But I can support in testing proposed solutions.

