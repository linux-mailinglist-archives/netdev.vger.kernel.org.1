Return-Path: <netdev+bounces-136165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D0F9A0BBF
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 15:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965E3286978
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4C209F3C;
	Wed, 16 Oct 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="ADa6Bp5m"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCEAD520;
	Wed, 16 Oct 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085328; cv=fail; b=bZoyjVxPV3JlQjRs+lAotVBhxFm2lunzi8AifzPP2EPVr/iDWnMpY1CPCDZQl5JhPxB6Yg4dFv7gdmYQvNSx1MBdAxeWtfCnPo8GeKaXNTk26eMwooeHuRdNdZKe88euHmTbKSit/GtILrBsrugGPTxmkL8CWnItHYo9UVHh6/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085328; c=relaxed/simple;
	bh=KVmxKsdZRAM5bwH1JdVOCmWmaAODzdSBLIRWAAKYdcU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dRfmFfW5oSMVo6xW8MwTGK4qytSF66abJdFqdzdLXUliubRKc4q0jCnsoNVrC4kzZ5qzOykWYCia5kKHpnhZjbTVCelDI4k09CE/l7+dpyvZs+H//6TkYT/mRI+41th00qAMhar4n2Hr2XiTJx6jbX8NVkDiOslmvFx4+5pZc6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=ADa6Bp5m; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1L7L3TfTCYAyqOl4oZE3YXqgR6MteXKJDXqDJExb5q+oxq/8P4/vpdvw6z86iZFZ9Wgnh/Dg1qHx90YXU9stNlec3/DuLquAmqRxCrP3ovDji7t5gIjvQ841UnBHA3N0q+JJiRSB4wB+rb4eR8ZEOkCi7i9nr7oVQ7jAHPZ2of+4lUV5K4LwEVjzf4BB4nF1V0TTjGELBppDxxZheaPy3rdOtvuGgYoXEmX+jDy9Ms6ae48+G/pzniPOV8U7TANpUFsEwE63R8lb04l7B4O2k1SiKDz2Ni9lUI30fhJhniYNcgHd+AbzXI6AYwIJegRSsf9r+rTIqqBLhV7UpryzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CJ4bmZhe8u5GUomhH8IJfA4ILb53mEd5t3kQ3nqz6I=;
 b=jepBAVsBik26wK33v+h3l+TSGdif4iT8ks6CguZFH1fcQ6XkRytpYjTjx7xI4LN2mlHjhQw5InfZLCuiSVqEHOJTDCNYblF2R9lDxin7R1IEYx+dS/xIX1ZE4oIm1AiEFM7HgkpKnInwERPbAF0AcuoUbLRulUoY0tm/4axHeXLRgtcuF5YveEkogP9CWtk0uKnNwa9zLJASw5W0VXhJXz/oWBN6FBEhEPd1EXkSDDny+E5Jqp1f1RF1uYX425yj4rK+cZ6qxGqXprE4sK0Iqidc+zGSkdv/r6Ng+r5g6GOKXqqhj48x/qE8Mr78kX9ErlALKlWZLweu+jRnl4XFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CJ4bmZhe8u5GUomhH8IJfA4ILb53mEd5t3kQ3nqz6I=;
 b=ADa6Bp5mlVhpOy3drCTYjDEa33zOBK0KvpBgqjN9zfuo2R4NlnzAEFWh61ol18lkuU+kP8hcLASHaqN3zaAJenMg92iOc4QTW1qghrPQAu/hPL+WwNDeIJUrsiqKXNB3J+fGM8/1V1LNpMT/d0nLebV+v4p3DUFwLlrYlDdQHi17qfi2MzJTtDQSEjGR2m1AQIXBwFBArpmf+MqcPfcSadqstDNhMUX5+Tjhd2hDnZP3v3FeHv3exsBbbBVBDK6e1Mhoe/BqGvpN6uRjFHsynI2yGdYUDb659lZVTk7pVtWHd3/t1YL9uaULAzKVybCGqbnoNzOHeRT/CGqChVCWGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from VI1PR07MB9706.eurprd07.prod.outlook.com (2603:10a6:800:1d2::12)
 by DBAPR07MB7014.eurprd07.prod.outlook.com (2603:10a6:10:19d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 13:28:43 +0000
Received: from VI1PR07MB9706.eurprd07.prod.outlook.com
 ([fe80::1620:bf68:4eec:61c1]) by VI1PR07MB9706.eurprd07.prod.outlook.com
 ([fe80::1620:bf68:4eec:61c1%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 13:28:43 +0000
Message-ID: <7caaefb9-c1e5-48b8-b457-8b9e7e2d491e@nokia.com>
Date: Wed, 16 Oct 2024 15:28:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 08/10] ip6mr: Lock RCU before ip6mr_get_table()
 call in ip6_mroute_getsockopt()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
 <20241014151247.1902637-9-stefan.wiehler@nokia.com>
 <20241015171013.7cc3617e@kernel.org>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <20241015171013.7cc3617e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To VI1PR07MB9706.eurprd07.prod.outlook.com
 (2603:10a6:800:1d2::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9706:EE_|DBAPR07MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a39e0f1-5175-4055-6582-08dcede6746d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEw2SGI0KzZZTGY2c2VQVFRmd3QvMC9CeUJLcVFUWkdrT1pZZTI0V0ZuRVF0?=
 =?utf-8?B?Q1FFbmZQcG9id25VTTlodjJVNktPcXZGL09CWkZ6eW9wczZZSlgvYUw4eTJw?=
 =?utf-8?B?VkZXRjU3SHZaRlplN1FLNThnYnd1TTNqZ3QxQUY1eXpMRUpYeW5iYTlsMXFR?=
 =?utf-8?B?YStTWkpWSlZzWUtnZnVKL2RPZ3ZzbW0yRWpWLzRoN2JwRDlSd05yMmFPN3Rw?=
 =?utf-8?B?eEFtWHFwbm9qRW94Yy9pdnpGYTJnRWZuYTJKWHVtZjUrdWI1S1QrM1hybzFx?=
 =?utf-8?B?TXo3VjBud2p3REhEY3VHeXZBQXp1NFJqTEkzcEx4RWczbFViK0pFOGw4bk5V?=
 =?utf-8?B?bHp5aXNhNEFKRkVucWxsNEppT3BWU2lUeTJzOStmQmNLdVJWeUwxN1RwUTJE?=
 =?utf-8?B?SDkrSENMdXBYcjRpbzVneDdRazRqVnpxVitCdFQ5b3dhb2h2MjcxSEJsSmtt?=
 =?utf-8?B?M1A5cGNLazhGOTM0K0ZKVU5iS0ZCZUk4MXFuVU96RmEvZlJxMkozdldaeWcz?=
 =?utf-8?B?RTExUWo2MVdGb284Q3lwUllwQXk0YndmS2NuYlc2VmhyOHFlejBPZzFTNkxq?=
 =?utf-8?B?VU44R2w1azZnWmdabUFBaldCYU96cXZndFkzRzFCNHZQYnB3aHF0ekd6Rm9S?=
 =?utf-8?B?bkphazVjVlRrdUZwY1U0Z2tVMURKamcxNEt3K0Z4aXFLUXZzazdxU2dkaThZ?=
 =?utf-8?B?V0pnUkYxcXdVaSszRWJoV0l0d2JOU2lBSDhoZlpLNFpZS0NXTVRzWUNGeE8v?=
 =?utf-8?B?V1hTN3E1em1TbHZ5V3hKdlNpMTVjMkhHWGV6LzB5emNycW1OczU3OHhEQmg0?=
 =?utf-8?B?WjNIOEc0eWplaGgvZEdqR05ER0h0N0laTXR5NFEwbG5acW4zK1BKQzB1cTAx?=
 =?utf-8?B?WXh0enVDa1hpVVZUc0c1TXU2K09RTlJkMXMyWGdSZVRkQzRkcUpyS3pJRkNy?=
 =?utf-8?B?cE1IQW13blE0MFBwaEJMLzBSRDRkVjQvOWQ1cFhHd2x2dzdQUGUyb0ZpSTly?=
 =?utf-8?B?KzY0VlFEbDcwbVRzdTc4eXg3VWZxQ2ZUcHA4RHV4UHZZV0V0UHdTWkFwd3VN?=
 =?utf-8?B?aDF2Qk1TYUhzMkJ6YmNxWXMyaHltbnVrUmZYb1M5MTVKL1RHY1B4dXc5VytX?=
 =?utf-8?B?NXZqZ2htWXZ1NFFleCtXajlGM0RNVW02R1oxSExqckQzTUI3NEMyaW1Jd3p5?=
 =?utf-8?B?NHZRVXJSWHNjNFU4UklUTGxXWlNBbVFEWk90MkdFMFNFbHZSMUU3Z0xPUFZo?=
 =?utf-8?B?OTdFQm5MYU9INFhQZHZDeTZId1lhR0pZQTNtOWovVzBxZmxHUTgvRllHOVpy?=
 =?utf-8?B?UFpwelZXY1Izb3p3ak0rRGRqL2tac2VUUmp5ZTZKNWVOVXpoQ3Jua2ZTTUlF?=
 =?utf-8?B?VXdKRGVaVTBIN0dXNVlrNjJONHYxR1JnVTZNQmkyTFBEa0lJTGlmTDNzbHdS?=
 =?utf-8?B?NDRnWUFNRzlxL0NDa3B6OGVtSkh1K2Jwb0pld0YxaU14UlFjR1NIaFhQUFc5?=
 =?utf-8?B?VlhXbFg3aXcrdkRYQThWTk1yVE5vcDB1MUtiK0NIdGswU2lBRGJmYzZadkkz?=
 =?utf-8?B?eUNtbXY2NE5jNGMrSVk2djE1Z3EyaGlka2xNK0lPd1RDU00zaW1wdHJqYkR3?=
 =?utf-8?B?YUhhM0FIbTVubFZPOE1uU0ZBU2pINFBlS3A1UitJd2x3dE1VaG8zNXIzMGM1?=
 =?utf-8?B?TXZmZlovYjh6Wm95bXdVNjgzaDV1YmU4RDdaVktKL2liSWxadFlVZFlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR07MB9706.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm11Ukt6Z3YwZE5yVmcrdTM2OE52dnJLK1dzL1BDaEtPc3JsR1dLa3N5ZDA3?=
 =?utf-8?B?MWI1NStOaU52cXJ5Mm04UVpmMHMrb2xxemR2UHlPVWVORkVWQkJZWlRSN1dZ?=
 =?utf-8?B?R0p2NC9NNFplU3Jqb28rckZIUFd1QklvaWJRSmkxcld0WUVOU1ZJV01pY05V?=
 =?utf-8?B?NjJoeC9ZZ3FIVHN3b1NVTnRxanRtZDA5NldNU25qZGNHTi9GWVF6YzVWZUpo?=
 =?utf-8?B?SWI4NG9EZ3VlaU5aUWtOQjI0SjNsa2FGd244STQvQTdBZ1dOT2lUcFVCckpZ?=
 =?utf-8?B?Q3ZHTGd0dDZkTmYwazhRVTZoU2dtb01rb1ZIK2FnQWJnQVJGNDkyTllnUmxs?=
 =?utf-8?B?djRDVlhNMnRZd1NUYnNDNUl3NWtYT3ZlYnlsYlhOU0txNDM1NHJYM0lKaUVP?=
 =?utf-8?B?VURUMjZQcHk4cFQvMldIN2NmOC9zTEREa3hWSTlJenRwS21IUWsrcXJyTS83?=
 =?utf-8?B?OXBCdFNMUHN5M21RdEkrU2dxVjBwVnVjdG1tZDZmWE1FaEJaUFJqaGh2THJG?=
 =?utf-8?B?SExubUNxZVdjMEhuTDFwM2NMbExIRnFaVjM2RjN5S0tkTm5IaG5qUkFYWkZE?=
 =?utf-8?B?N2c3SmkwVHcwelBmbTZFcFF0b3lMamRYM0k0QjJuQ1NIS0tzYTNRTWNnV1BG?=
 =?utf-8?B?M0FsVjJ1TTlPSit0dDY5STR2dWNMUTk1WHcxVjFnMUNTTTFVWlEveUNhZ0lm?=
 =?utf-8?B?djduSzZubW1tMDZ3NEtPTzZwUTAvVlRha3QzUEJFbHpyRGFVQ01IUVhGOW5r?=
 =?utf-8?B?MW9FanRuQkV3czFsc0QwakRBekxYdW5EeU5uVzNaemJXSWNlM0w5TlJ3T1Bl?=
 =?utf-8?B?VEEvdWNTMzFwb2Qzd0JwY01mb3VzUm5yY3MzR2RSaW9XaVQrRitCdHpQSHpL?=
 =?utf-8?B?SnF4YXhFTnduai9ESFF6T2d5b1hFMWZvNUtqU210ay9nZE5oQnYwWEYvZ3hy?=
 =?utf-8?B?S2c3QUxVT1h4K3JtejEwYWpaajlqbmQ2RmlyOWhQNi8yeTcxN3J4SEZCUmVl?=
 =?utf-8?B?dUFGUXhFNUF4VFpMemEyVXVFYVgydTdhalErdnpsUndKWFM3NDVRNUdxSHE3?=
 =?utf-8?B?eC8yVk9xTjFLT0NOdEhYQ0dMU05vRStIUVo1WmxqbjFiRlZ3RFZvaytFQzll?=
 =?utf-8?B?Y2EzWUJqTWduVEd0UnBNV0tQZXRFbjFoa3pJOUhqZkNZWGdQUlpLT3ZMZzcy?=
 =?utf-8?B?dytWbEVicVI0Y0lCdHo5bDZ5SHVYK216dFFkTnBMNGxRd2lZeGpRY3orYVI3?=
 =?utf-8?B?Wnp4WS9rNHVlR2NwbmNqYTJzOWZockJsUk1VWVRjZVBLTVVRTFhlMlhvMERS?=
 =?utf-8?B?bWUzdXlTMWJMOFJDa2RsU0pSODhTU1gwT3pMRXlEUUgvN1R2cVdFTTB1VElm?=
 =?utf-8?B?QjZqQUc2eEJPNDIzZ2syalhrK2JnaFdpNi9iV3ZLbS9laUJaWWFOSVV1a0ps?=
 =?utf-8?B?ejdFZU1GNmg5enZVT2dXNHg0NVdKY2l4RmE0dlZPVk1YKzJLb3lTYngrMHBz?=
 =?utf-8?B?d1NrbjI0MGtKaGZHaHpHV1VwQVZnVVprV0lvVkhkVHBic0tsMlVFWWgrbGF5?=
 =?utf-8?B?TFZMS1ZZSVFRbHdPeUw5VG8wYlcvTnJTUlZ2ZXozcEVZYWJIT1dnV1RKWjlV?=
 =?utf-8?B?c2JRRC9PeU9zSTkyMDZ1b05SV2NKQWxTN0lOaE0xZEp6cHdINW00OFJKMDVP?=
 =?utf-8?B?OXlOSUlBN0pCRzFDN0pKc3dVVU56dEwxbCsxUVlzOStUMFN5RDBhWUR4Wnlw?=
 =?utf-8?B?UkYxazg3Z25SUXU1d3dSeFhJZDlueTFMZTdwN2JyS2p4L1NqeDRqeHNZTHJz?=
 =?utf-8?B?UUp3NHo5ektpSCtpbmhKQnRFUnJZY0dDYWdKVmI1ekNKY2ZJZGZRbTJvTHhF?=
 =?utf-8?B?ZnZsMVZ3c0FaUTFsbGxCVVEyL3hPNzlYS1IxUlJkY1hOa2lyZDNaT2ZvRFhX?=
 =?utf-8?B?UGsxTDhLN0NCV1ZZaEY0WmNYME9URW5ndHV0R2E3YzRpVDMxMDdqNjE3N3ZT?=
 =?utf-8?B?WmdHaWhYbjI0WGdqT2JrZW8wTWpzSFB4cVVzZDRiZHR3RS94Mk92WGJPY3h4?=
 =?utf-8?B?b1BWMjd3NTRHZmJrS05EV0prclVvdllYaXVpQ1dBRFpCYzE3SS9zK2dxNjN5?=
 =?utf-8?B?OFI1THdqYStxT2pBK25zNVNtTHVNNjJaL2VGbXdIM01ad3VTb042U2JGRUxH?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a39e0f1-5175-4055-6582-08dcede6746d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9706.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:28:43.3239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GmL8KLnX5+9PG6NXLhaJDg9zEr8Zoi9J50Bd2mIhFulfLAG1Ge+k2umxFytbkqGHpsYTXoVxGYGomb4F8M8Qc9scVEEf1cNFkHtBFRf2Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB7014

>> +     rcu_read_lock();
>>       mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
>> +     rcu_read_unlock();
>>       if (!mrt)
>>               return -ENOENT;
> 
> presumably you're trying to protect mrt with RCU?
> so using mrt after unlocking is not right, you gotta hold the lock
> longer

Thanks, you're right of course, I'll be fixing this everywhere and send a v6
shortly; also with more extensive reasoning for this series in the cover
letter.

Kind regards,

Stefan

