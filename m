Return-Path: <netdev+bounces-145329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0C69CF112
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6AA293257
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B84F1D54E1;
	Fri, 15 Nov 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="wEd54haO"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052C54769;
	Fri, 15 Nov 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686860; cv=fail; b=syRSd4YFh8XLQvjEWML+uesq2ylvCvyRh861+a7PgbqOcMfsVNS7CChQFCOF37G29H7rwUl8pfBhlKhwD0FrjhD0Kn19Qvb+L/bN3yKsqrHHjMT7jQ6JtAhMIS71aFXst1MJ8vhiBSWMIK6urbV5dsVCrqkIDkv2g1Bm6G/ZsUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686860; c=relaxed/simple;
	bh=THjRJHknxp0KW+cydqd2KRNg/Zkn9Eq3+UoUwCFd4pA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bv/lPXMP7pHCASpkqJ8+7enKYiyPvHe4DiegzJTdPDNaNIUFWQVzSX4RBqcYUYZHnhnRBs8/ae26Vyoxi8pMEu8VFD8blwRHA0qeftSOfZ2bQ0aPIET2Uf+kqaC7j/egq8HjVRWgitzRk0o5YD/e3zptjZQt1YBCgkWvbpM7Eyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=wEd54haO; arc=fail smtp.client-ip=40.107.105.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9HQGeZibnFb0M/zjqmfkVrqDFTPZu/7G+aHla0k/QHZVPBdRNMDVZejXCwFhzMDZhaJSfAacnO1oQ2sppGP4mfg2VA4hAyN8dOiYjNKg1oaMW4XrpGJH9wOyTIzw5u0GLMmDI1r14tIPrFoEskGUPTgrQULjOtVYtQNJToPyo/Ul6lfACYa1n3WMuQKzd1+1yF+gPopfM0mndHAO7swrKNA47dSucbVBl8Yyl4FJHvbtONfLIIbApH1c6tsKPuVcXkyf5mK3/E5xGoBssMXmiUo1ts4NCz5wawUDXNC3M+xK3COMsu63ATNjuwuCmpSxWqCGGrq86QsvXC3prknhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii2uTW54SiPvp9zXjeRpjICI8qFTOLiOGddzqLdvSRI=;
 b=nS2GLicNSaGAw44lwEJidghYt3kDLUSl4229YhSY5RVpdwARkEIw+BQOnzfBafH67Tzv4FIqGtsYRWMW3KDXul9J5oJS9CyY/viNzvjXrd4Pn6lYLj47ddVxjIiY7XII/wF2pm6i0idVdZGCFiwJcmIin7zO6qQQQTo1gbAWNcpiya4YR/LqhERufQO97aULbZb+W7VvPOyjwS3BR++HxI14I8cmHjMSMRmRZ9MbeWPIAOyyp8yoW+V14ng3HL75Rz7R+VITjwXE6AvGLB63oJfnx+tTYT8+CoMTqiO0OkfPd1Iiu1OmhEGkMkKzq/VNlHCGf1vSV7pzx1SCKOsrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii2uTW54SiPvp9zXjeRpjICI8qFTOLiOGddzqLdvSRI=;
 b=wEd54haOz65WueXHJ0ZGXZIdSf9VpPNi0treYheF2Vhuk/HtpL0TWwBTUu6/2m/tSd8vriabpE7t9MH1F/Ydrxs/SjfK+po8Fuo6Ps+oveolscDCJ8SJ8vRyLXjgGkXtMnDi7Snao0kSrYhcWpS22ICCb8mO3OyDM7CdODZT3oU+22uwDS0j4R/T7kIh9CUrQvyhhT7/vFXUl+br3aldR3Bg3foPEuLb7IC4i7iMlxpGpMcuZYCPFgWxxGJlWVsm//rirdoU/KRRgYOhSRimlacezaE/MCIiGAZ2CquxqK2a7i/nCXKSaplBDBDv5c14ieAbJBLSUV7+pd8D8CfUMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by AS8PR07MB7064.eurprd07.prod.outlook.com (2603:10a6:20b:23a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 16:07:35 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 16:07:35 +0000
Message-ID: <9cdf4969-8422-4cda-b1d0-35a57a1fe233@nokia.com>
Date: Fri, 15 Nov 2024 17:07:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipmr: Fix access to mfc_cache_list without lock
 held
To: Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
 <20241113191023.401fad6b@kernel.org>
 <20241114-ancient-piquant-ibex-28a70b@leitao>
 <20241114070308.79021413@kernel.org>
 <20241115-frisky-mahogany-mouflon-19fc5b@leitao>
 <20241115080031.6e6e15ff@kernel.org>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <20241115080031.6e6e15ff@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|AS8PR07MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe7f1e4-6306-4712-736d-08dd058f9e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QThMOVNUSVJnSlNBRzF6REV0NWdUN1dpUU5jWC9RWTVNdFVZY0hUY2ZCNm5p?=
 =?utf-8?B?Vm44TkZqeEV4SkhTanNPQnF6amtoYkI3SkNPZDlIakJxdUNRMWdxOGNKYm1a?=
 =?utf-8?B?U3FSL2l5d2dFazB2R1FBZHk4bTVmQitXZU9uZ0tFT3UvdGhVdGJMT25HRXEx?=
 =?utf-8?B?Z2ZMQkRHVXcvZGt3NjhRbHRlSHhkaUkzZUhVWnFYYmF4V09DWkM0Zmo5YkJ4?=
 =?utf-8?B?QkYzQzNqL0pkelNIaWZFakpWa2h0Qy94ZnFiR3VsQkJFRHVwNTFaNE9QUkdL?=
 =?utf-8?B?NGNYaWU4cThDWHZQSFVZZWJZdVZuM3J1ZEJQL1hYZWJCMmRwVFlXT1RrVGQr?=
 =?utf-8?B?aVZxVVJhc2Z6NUpFNm42MjV1MUNRS1hvcEE4K29sK00rV0ZJdTVIVGZYdFRv?=
 =?utf-8?B?Ky9uN0R3S3VjMC92TDJzKzIxNUQ4dkZ2bEM5N0dtZDJOdmRKT0Nuc3RRRE56?=
 =?utf-8?B?aXBJcTh4RWpzNlgzZTJucGZzWFcwaFl5ZlEzd3V5U0xkZmM1RTZpRU1oeTVR?=
 =?utf-8?B?aGpLSzlNVGJ3VklSa0tPWUllNjRzUytjeVh6SmFSemFybkFvTGZ3bHFLZTM5?=
 =?utf-8?B?bHYzamRyUmtzS1JySjJ1R2NPM1UxZEY1SWdjQlNVVVdFR1J0d081bWFTUEpJ?=
 =?utf-8?B?emJnNXpMdkJmQXpHTU02dVJrSWZaRVl4czhQN3UzZzhvKzI1VmxZL2F6OGJL?=
 =?utf-8?B?NXQ2ZTJ6RUNITWcrWTBRVmhGZ0hzclBFWXZjVTAxQU80ekF3Q2N4c1FyTzRk?=
 =?utf-8?B?NEQwaHdMVXd4U1F5SFl1Q0ZzQndjNkZRN0pUUHBhcDBVMklSZXdaaWlMOFFs?=
 =?utf-8?B?YVBqT0JlWlhiTjV3c3JFRStINXNhRVZuSXhXRDM1eTNkWGtMVkZEN01TNHhE?=
 =?utf-8?B?ZXRFUFJURTE2dTFRVHlRaStnWDRmUC95dXRkS1ptbXpza29mR1duOFhxLzI5?=
 =?utf-8?B?QU9DMC9uMlhZZnZxUDVERWQ5NDJTbXY3a01NckhJUVVkeHhjOWNaZnBGOENB?=
 =?utf-8?B?d2NJM005cm5ZZ0FYdjh0eW5ZTSs4MnhtcTArUmphYkY3Slh0ZlBPZGlKTlpH?=
 =?utf-8?B?VU1ac0JtNU1JMXZFNWpGS1RBWGpsZDNJVXRMVkt5SDZBRGlGVWRQME1JclhI?=
 =?utf-8?B?NWRHNCtNbEVpZFRkemg3SkMzemRvd1NpQ2pTUGw5RzBSY01LQkcrUThpTHNR?=
 =?utf-8?B?NnlNZ1RjQTVvZlBZYS9tbWQ4ZktHdnREaEtLbThIOHFaTXRDS0t1MDVnNHpr?=
 =?utf-8?B?akszRzBOQ1VYRVQzUmJvb3lEcHZad0dyYnc2WVJQeHFHUzVteFNTOFBmQVE3?=
 =?utf-8?B?SHZZVExtV014S0FLMWx1ejlsNTlLOE8xSjdxSnpoRVpKTDA1MmJEcXRMencr?=
 =?utf-8?B?TGVqRmZjVUsxWmdPaG9UY2QvOTZIcXZPRzRwZmdCSnNCcUtweFhqemthOVRZ?=
 =?utf-8?B?NHFlRU5mME1XRWJnREJtZUQxWHZyeDRTSlpPSEIrSi9mcUlFRk16SktuUGds?=
 =?utf-8?B?Q042M003N1lkbU5jcng0SUU2TnpwR2ZxS2hzRkRnTTN0QXowMnlCbitRZ2NX?=
 =?utf-8?B?Y1JIcWM5WEwraUFYbHpOcVhZcmtZNlBPQmFuUC9Ea2V1Zk9xTW9uQWhNV3do?=
 =?utf-8?B?STl4aHBNRVhmVE4xOVUxd2ZiT2pOU0xjQkR1NHhQT3ppTVVnWEJzRHdvR1Rv?=
 =?utf-8?B?ZW54SmcvdXpsRVVFMlgxc3kxN2xzWGc4SXNxR2RjbkdXd3FYeWthSDFWYkUv?=
 =?utf-8?Q?LcgGF9h+rmsrMziJBjLxzcqgwrCZRwoFEo8jH8H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3lockxZZkQvRGVBaXdTd1pjR0VCMnNzZUlkRlNleTNzK09PQ2xOOW9UQ0xT?=
 =?utf-8?B?UWJSd1JtdE4vcW5Ybk5JUEJ1R3dtWVBNV3VyZ1NJZUxsWEJpNHBSdEhNZkdy?=
 =?utf-8?B?Zkt1TTc2L2tmRjhOcXNhL0JnVE1kbTUyM3RqdWNmV3lxWGNzYSs4UWY4bG5y?=
 =?utf-8?B?emVKTWVJZ3Zyb3ZtUDcybC85eHBMbEpTRXZVeGlFdldEVFZZcXZ4ME1IWjhw?=
 =?utf-8?B?WkR3QnRSRUlBcm0rak1UU2YwRHlZVWI0MlkvOW9hM2VGYyttTksvZlhjdHIr?=
 =?utf-8?B?dk12QzlHRnFja3dFVVFHci9sYTYySFBxY0V4VVVEaDBmM2hka1VTZDR5NmpN?=
 =?utf-8?B?NmR4MUlMVkU0VUdyM1VOSTRKZUJjRkpxS2VERUJlVHFJNW5PK1FvUUtldW9E?=
 =?utf-8?B?K29BRWRhTXZ3YjlZK1NCZkE4eWdoaW92YitJZDZ2T1RYSjdmMGxIVlpwSU1o?=
 =?utf-8?B?WjZ4N09tN05wazRnazFYV0pUUHgwZXpTOFNKampXeDRpVUZ1NERwUXBXbVpF?=
 =?utf-8?B?bi9vRFYxaDVEQXVBbFFqTGVPM2RtWjhNNnE0KzRYOXhjaTh0ZERlNVFjK25u?=
 =?utf-8?B?TzltMEtIVTVWSmtuRzI5K2pmclp4em5kajk4Vm13V0sza2cyZ2ZDWERJUFVY?=
 =?utf-8?B?d05iUk5HYzNiaTgvQTFqRTdiclNoL2JxR3hiQ3EyKzZ3MHJRSVRzZTBDdStr?=
 =?utf-8?B?WjRWOVBVQ1lERGNkQVJBSUhnS2VwcXBnRnFjTHlkSTFkcWc1QlZ0WGZmNisy?=
 =?utf-8?B?TmEvVWsvOGt0NWJIZ2lMdXZNUmFMMUxVU1htQkZFSTUwWmxocFNsT210RFB2?=
 =?utf-8?B?cWp4TjJJajhwOXYyUzVzcFY1QWE1ODNocFhmVFYvMkl1cytSZ09yOHp6d3NW?=
 =?utf-8?B?NTlrcTdDVTFsNnlhWGo0R0xUdnlFcU1sZUFGTXhRZC9vMXhUcnRZVm10enFJ?=
 =?utf-8?B?ZWcyTCtZbUxJMlZDNkxkSitLOEhOUkNZWHduRzE1a1B0R3lsM3Y4TXIrb3Nx?=
 =?utf-8?B?KzNacmdlekh6dTdZVXJHR0Q4OVExdnc2UFdPNkswZVdhdUpUc3ZWbGQ5WCtG?=
 =?utf-8?B?YWIrZnlMSUw4SUlITVNkOVB1RkxvT0kzdkdZa2d5MnlVV2F6bzdBNWxvbHRU?=
 =?utf-8?B?WXZiWTFpTmVrOEYwUm5pby8xNXB3RUhsQlVvUEx0N2JaanJsK1lCSkJjQUxk?=
 =?utf-8?B?YVZWSWx1eVR1c0VhTWtJZmhWRzRuSGlUelI3MDUxa0xPcVlqdzdaaElQenFi?=
 =?utf-8?B?UGpUUnh0aWJPZFNTWXVVSC9EVENBSmVBZERMYjd1WC84SmtOUGdlTUo0NkNR?=
 =?utf-8?B?MUxpV3RoZndhZDlYM05qbmRGb2hCRFUzV1cwbzVkN2dubUErZnZKRWQ3b2hU?=
 =?utf-8?B?bVlESFp4L1VSc29OZ2dpUEFRekovSFBTdkxKVFFvVjdvd2FvTnNNdHlXOEM1?=
 =?utf-8?B?VjI2MUxOUGhjY0Y1MjhjRGV6UUFsZTBjd2NmUStJVElHN1dMRmNVQVE2RzU5?=
 =?utf-8?B?anVmek5iWVAwWUk0UFpFbUNIdmJKSFE5TVZLVmxsQkgvRFBCWExQQ2ZHUXZM?=
 =?utf-8?B?SmI4MUl0Qjh6cDQxTVR5akM4bHpVc0dlaFdSTnAvMlVPbWpEL0JQdHVKWnRt?=
 =?utf-8?B?bUFKbGVYVGM5MjlScDYvS2VUWEVWUkVFeGVjNGhVZmsxTytnVEFXOXlYTFYv?=
 =?utf-8?B?SG56ZkJxRUpKZnFqd3E4Ynd4bjdNMDU0VHRQRThSMks2RXQ1MFVWVFoxeGNr?=
 =?utf-8?B?cFMxMkY5NXV1Smc3SU5Qalk5dEQ1Z3lMbG92WHI4bm96ajFJWGVjY0FEYWY4?=
 =?utf-8?B?V1RLbGVBNzM4UTVJdGx6eFUwU3ljMUpOeTZlcDh2S0VpOENSU3oySHpTQTVR?=
 =?utf-8?B?QkdGVmF1eklEd3NucjJGbHk5R2JDanhEeGY1cSswSUo1SWt5Q3M5OElGR2dJ?=
 =?utf-8?B?amNVMXozSHU0ZmxuRW9TSUtoL2lLaGRScFZuLzNwQTlCV2VKTEt1TnowODNp?=
 =?utf-8?B?MGNuSGtHeU1uZ3BBbmJzMWR1blRRYkMxMkRTdG92UGdvbmw5MmJQQ0NQYld6?=
 =?utf-8?B?SG9iVjNoUkNzdGVzbGM5S2xSWElCeWNMcFVnMGQ3OHFpeEpEVmtiUFk2eXRr?=
 =?utf-8?B?K05FWjQrRTFzOEptNHJ5WU92NTlUWHFMVS9EbDE3UlZTWndmVjE5MXpCSGJB?=
 =?utf-8?B?WlBlUmRReUsvUDBqQzRDTlQzMXRBbHk3UGVsa0xjNks1YlloV2dlWFc5bkxl?=
 =?utf-8?B?Zk1DUGxQTEU2Z0kyenZmVXB0Sy9nPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe7f1e4-6306-4712-736d-08dd058f9e5a
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 16:07:35.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyUYm4DIwCAKJ1BFZK/Bgvmo2rfVFM6W3rH3Bkq0+blHjNsMj2JI8KGVxUwZU1BJBXhl4JwsevOvkIhPRa762LJL/1VgtK7r1i3lnaO0ZY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7064

> On Fri, 15 Nov 2024 01:16:27 -0800 Breno Leitao wrote:
>> This one seems to be discussed in the following thread already.
>>
>> https://lore.kernel.org/all/20241017174109.85717-1-stefan.wiehler@nokia.com/
> 
> That's why it rung a bell..
> Stefan, are you planning to continue with the series?

Yes, sorry for the delay, went on vacation and was busy with other tasks, but
next week I plan to continue (i.e. refactor using refcount_t).

Kind regards,

Stefan

