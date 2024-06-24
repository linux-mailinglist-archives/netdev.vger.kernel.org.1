Return-Path: <netdev+bounces-106240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD22B91571F
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 21:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043141C22344
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810FA1A00E7;
	Mon, 24 Jun 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="GOaNprVw"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2124.outbound.protection.outlook.com [40.107.241.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8C61A01B5;
	Mon, 24 Jun 2024 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257219; cv=fail; b=Z6D41nfhlFEHisHwa+4mD3uSqnEwQgpfoOqy5o1oOCPzm2pZ9b0B/clLuvFft6mF8us3VgxnAEtQr6G/VyZI6sABYYS6JaCLT/s4+2eTB9rffZCMJPjZrdMTpTRGHqX9OEAcd2OU8I8StbL8lL+fbirvCk7bV1WtJR6FeqUQixA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257219; c=relaxed/simple;
	bh=i0gCJmDN0un4/P6HIvZP1fDzQyJ05UG19aRWXEhmBVA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nzdaneUcB3q5h2Fpaw2V+CrWSww1+HZ20PSMd8pSxL74mct1QGqzVGu1sqVIc+8jI7sJG3WtVEwKMRCj9WePB0Q9FflGK4Vnur1iIhpQw1vvPSel1iYokMV5M4Kyvt7SNAlaT7LHtiLHhltoxKCFDZ7Eu2s1wcmoropgqMNp/yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=GOaNprVw; arc=fail smtp.client-ip=40.107.241.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4RnIFR7N0dG32XzLvrNg/0crIa9eDd/kRwx9yTUlFd4ztqvIriXepcOBPG+V0lNVJrQHxkuvIyMwnshrjnrezpz87fe1LNNFY6p258TxIyoc+IT4sAkUkAoLKoWpTVeqnD+yx4PYOjX4tvDW50SI2uGUTCbyiMDNc/Kqd97Q2yjU7Rf/zHuxOH7w8S00B3B2SKGHcm/TyR+EmxSd7/Q/mNELq02B7Sw2dyZockwEBgC4Jh7hk5Y9gHxTONbBah/FEfeeEs6UNs5POluoGebqOgTBuK5rmF2xMioyCLjXeM1ntuPqjESQIcV1cQL9wRxQ4F4V9Bhls8m6vdRWgP7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9nhqZpSwyE4mHEnXQseuobdxcyxktpvgosRQX+wp6k=;
 b=OEyzSRETYopks/ABQGmMDd546jVjHfB8Td4U7ofuX3uEpr6mCitmXJpowsB9ZuPabbYmbbPg6SEzBgO2spDifY1Xv3lyraGn8VM7IE3j4d4lLqL3QFi52LV37Fb7X7o+LuYXTox5KLzV5f98SQ/Q4ZhJJR3uxpgck6y7e4aMkyOa0gFAJb0wWzxhkY577cza9A1ejFa7owZSGmsrGvIvrGnoa0DFwV4M6vmUZa3nrzs8mYLYrwSiQTkUkHzhUA297sV8Lb8Mc/ejxXAzmGWr66Wp5HVFYpGME3sLtIPgb2aFrSdRc3DVA8xk9XYD1Rd6tqEl8NcFf6yAJZIJzs+rIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9nhqZpSwyE4mHEnXQseuobdxcyxktpvgosRQX+wp6k=;
 b=GOaNprVwmb5T17C8VkoKuZgBlvJptabFmpHu/1t23QWl5wy/4ekn4pgyQc2HJxONwavqvgEPec9JuUaLzeaSHyOmpEJf16LJdmR9omNdTS55D13UlQoT1A6CoyfjDfNNbJM8QLRkc1+0cAWIhQfrvfwPNetRXGoiCzwHbn0Jeys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com (2603:10a6:20b:2db::18)
 by DB3PR08MB9033.eurprd08.prod.outlook.com (2603:10a6:10:43b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 19:26:51 +0000
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35]) by AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 19:26:51 +0000
Message-ID: <504163cf-1039-4139-b596-f7e54318f200@genexis.eu>
Date: Mon, 24 Jun 2024 21:26:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 nbd@nbd.name, lorenzo.bianconi83@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, conor@kernel.org,
 linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 upstream@airoha.com, angelogioacchino.delregno@collabora.com,
 rkannoth@marvell.com, sgoutham@marvell.com
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
 <2752c453-cabd-4ca0-833f-262b221de240@lunn.ch>
 <b023dfb3-ca8e-4045-b0b1-d6e498961e9c@genexis.eu>
 <4a39fa50-cffc-4f0c-a442-b666b024ba34@lunn.ch>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <4a39fa50-cffc-4f0c-a442-b666b024ba34@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: GV3PEPF00002E4B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::1e) To AM9PR08MB6034.eurprd08.prod.outlook.com
 (2603:10a6:20b:2db::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB6034:EE_|DB3PR08MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e924b6-426b-4aa7-a3cb-08dc94839913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckFvd1hkMjQwcitkdTlyVE9mSHNjTUdWUks4L2lVcE9SVTJ3WThuNmtVaEEy?=
 =?utf-8?B?ZitFaGFyV2Zvak9jNERudk9XMHV0d0s5bEhjanR1OFdJNk9nYXJtV0UySGJF?=
 =?utf-8?B?dFB6MVR6Wmp1a28wU25DNUZVaUZVcFVBNnE5eGM5OUJTUFRZdHJEQnhTUlYx?=
 =?utf-8?B?L2owQjJ0RWJsSExOUmpVbFVObEdHZ001MTVvaC9GM0NMY3AraVZFYVYzUXpC?=
 =?utf-8?B?cTN6aFlsSFU2SElsQnhTbjBFVVdFeHdwSlFyL1RNVmdiQllPYkZ5OGdROGxM?=
 =?utf-8?B?Vmo5Z3ZWUm5YRWdWZzM5TzU3SWtFakdld2xFZ0VKWXFFL1lxUFZ2SW5ScHRh?=
 =?utf-8?B?L2h2WVBoYjlteU5qdXNxOGd5bDRyT2FPdUJ0eEl1NVROQVphcEVVN1ZGZk1N?=
 =?utf-8?B?UXJLVmloUzBBdlJySzlvNlhJaVRaYjhaVXdBc0lzRTlSenA5S2lnclUrWUFI?=
 =?utf-8?B?NlFwb2FzNHRWQVkwSHE0ZzVYOXhrK2htcUcrYlVwUU5RSHczU0V6MFpMWkpJ?=
 =?utf-8?B?ZERtNG9ISG1CRysvSzhpRkRkVlg2d21ONEYzUWplQjVZTG80d0t0YXQ4QzBt?=
 =?utf-8?B?VDhlR1BtRkZSS3lvRHNzeFN3NG90V1dFVXJDSGp5L0JvT2F3UGZBUXUxNHBI?=
 =?utf-8?B?R0RvNGNBRnVyaEVXRTRoMWlnYzJPd0FERUhwWXFEcGlnUlRnL3gvc3FuN3lD?=
 =?utf-8?B?STBkNkdKcEt5bDJLSGhOU0xKK0hsWmcxT0diNkt4VDlQZUJwZEcwMU5zS0Nv?=
 =?utf-8?B?QUdOcklCYkpFd3Y5aXd4bDZ5allxeGFCL2x4ZzlzQTNweUtuVnZhNEhVelNX?=
 =?utf-8?B?KytVTXJCaUVwVVp4MFdxWWNocUhFc1NUZHQyV29rZzgwMFpsOFlXT0lpMlZY?=
 =?utf-8?B?M1dyM1lCVDh0N3FzU1VzbkVyYzlHbGdVTG9XdnNjejNNNW94STlEZkdJNHRD?=
 =?utf-8?B?Q3g2dHZHWEVRU3M2ZzZ2N2QrZzNPZXRtdDVxZWNndTN3a1dKUDF6c1AwdEty?=
 =?utf-8?B?Z1NNVWlHYW11cDN0NEY0ZGNreGJ1ZUZSelp1eVhJZ3FlblhRcnk0dWRCL2ZK?=
 =?utf-8?B?SjlLemlFV0VTUkNZVVNsRGR3emppYzd2ZlVjR3FnZFB2QlVwNGRMdFlYUHlh?=
 =?utf-8?B?SFRZNnB2Z3RrMDBIUFMwM0tsNDV3OVdjTXBwMm5sTXV6Z05aREVnczluNVA2?=
 =?utf-8?B?aTRaL09nYUdQTS9YdEtuRnRXMFIxMmlEMW1ZZUtwaGw3T3hPK3U2aWVDUWFU?=
 =?utf-8?B?WUphTHNBY25YN3RqWEphM05YazhGMnB3TW5NWTJpTVVHanRPVnRZb0ZrMVYr?=
 =?utf-8?B?Umh3TitrVmZPNmloamJxSW5pQy80TUFLYnpZTThMdU00bkgrQVViTVU2ZUds?=
 =?utf-8?B?c1M2Yk85aTRvTUIycWc1bXdVcjVlK1B3TW5qbldvWDMvSmhkZ1A4cUw4VHhT?=
 =?utf-8?B?SWpaUnJ6a1pCb3dtcEVuRmQ2dENJL3N6bVZJNnYvTWVjeU5Ub0ZQUVI2WkJU?=
 =?utf-8?B?N1BQQmN2ZlBXTU5SVVpIeGQvczIyNzJITTBSVnFPcVRKZ2FuOHZVSEQyOWdM?=
 =?utf-8?B?UVdkbEhEK0tQOXdaOUhqS1BOL0JGZHhXeFpZWW9COU5BVXY4WmQxa0RVSmk2?=
 =?utf-8?B?ajdyVmN0WGY4bklydlpSMzAybHhKSWtLRVJ6WUxIaXduUGVPa3duUUNkYVBn?=
 =?utf-8?Q?9RbVtGaRsvrsYR4orrq8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6034.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzJWTXMxbE5XbXd5Sm5EViswbkZhcFkxclU5SEVOeVpOMSs1WUNtb1MrSTlR?=
 =?utf-8?B?RUQrWk9mS0dQVmQxR1Z6Q1dmWms4V1NMSmEwUUUySjExZHNXZ3N5dGFUMFc2?=
 =?utf-8?B?aUdQZ1YyMnIxQ2pMVlQwWis1UVVnKzdrRlFQQlhFNFZOOStHM254ditKUlV0?=
 =?utf-8?B?NkhqQ0VpK3JhQ1Y3cUxOWmV0UU1aVEx5cHV2dUFXb1RwaW5uUURLM01IeHVG?=
 =?utf-8?B?V29vbVFudlJsUUl0ZUpIekl5ekIzeUUybFE1T2hnWHp4NkpaT3FnK3prTmNF?=
 =?utf-8?B?dEh6NU11RlNzSEUxekRTblh5YkxDNmNSMzZpQzBnWFlrdWRuSmh0N3lJdUNJ?=
 =?utf-8?B?WE82UXhuTDJUcktUcXpoRzFMaVIwMHp6WHA2emFPOE1mQWYyK0pzbEhqMmw2?=
 =?utf-8?B?YTZyZ1hVU002UHdVQVozaXRrcjJnbllUTm5oZmNpcFNmV2ZSZzhxRUlaTkNX?=
 =?utf-8?B?MGFXV2VtNUtCQk5GS0J0SjF1Wk9zQ0NCUUZ1RzQyVFV6anlBRy9UcVluV2sv?=
 =?utf-8?B?bDl3MXpyZjd3YndUMEJmOXgwemNUdDFodUVKaG5tSW5rNnZtejVFY1AwWlZi?=
 =?utf-8?B?Qjd3MStvS0xFcFdQbDNGZnFMbGRWd0VjTi85TFd5K3RGaGs0ajJ0R0VGbGN1?=
 =?utf-8?B?cFpCa0xQVjhtVE9BNE1SUzY1WkNQK3Nidm9FaE43bkFrcWJkL3ZPMTIrQk14?=
 =?utf-8?B?aWUwd0cxbjlxRnJNckVBZVhtVnNvUkoyYThwQkVCWFU0akRLU3lVN2JrdCsy?=
 =?utf-8?B?WXdGRk9OTkdEKzhBRis0ZXppL2lXQlFrQXEzTnhERlN5SHpBM0x4STBET2VR?=
 =?utf-8?B?dytjQU5CeGd0U3BESmxic1drVVZUZnlZNVFzK0J0N0RFSEFQRXRVeStpQlhE?=
 =?utf-8?B?VXBmcWk2MVlQS1ZRUkppdE9FdEZ4ZDEzdHlpSElZek1rRUZnSFFPVVhNK25E?=
 =?utf-8?B?ZXI2SkkxV29mRlRHTHVucm82N2U2YVFHQWlSazh1N2lmRzlYSWtvM085K0dK?=
 =?utf-8?B?SkNRbUdHZkdEd005a3BlRkdMK3FMNElBcllJMjlzRHBBdEx0OXlmWkJyQWZK?=
 =?utf-8?B?UU1peURxVU9hUWJLOUE4VlZQWHNoMi9XdFRmc2FCWk51NEJhZnJIanJUZTN6?=
 =?utf-8?B?RE0vbU5yQU9uWDhidG5QQmlENjhqMk0zamNZNzZvSmF5QzJ2WTdCRlRRM1hR?=
 =?utf-8?B?K1ZPT0NqcGRLNDZ4M1pxaVZwVENYWXRjZG5ZZE82SHBYMDV1NHhJMFIwSHZp?=
 =?utf-8?B?S1V3QzUxdE1DbU5GTWVMc2p1a3lkc0lxK1ROK0RBM1h5TnBnQ1VVb3NlVGZq?=
 =?utf-8?B?SUxkcDJDcjBLb2Q1WTltSjdWUVVmQ2lWRjA4UU5kbEp1d09zNnR0QWdId0wx?=
 =?utf-8?B?ZGMzS01zV1F0NmRlMEpWRW9DazQ4cEd2MU82YzNnZ1BGMVFyWlltc0ZTTm8w?=
 =?utf-8?B?NW53eXhrMVkzMTVhSnFGNEF2eGVCQS9ud3dsYXNFOG5sQi9UL0FHNWk0a3B3?=
 =?utf-8?B?blVlWkNBd2tKVGdFbzlXV1p3cDFkWmEyQURkbEZGWjlIdkNJVnhSRG95dmEv?=
 =?utf-8?B?azZLMlIrRUowWUVhMkhtMDFCVlo3VmVEQTdCL3MvcTRad1V3RmI0U0pYRWkv?=
 =?utf-8?B?MFpNcXhadWZQY2M1bUordDZkWmNJVTNUdDZiZVZXYmE4UkZkZVpTZGFBTzFq?=
 =?utf-8?B?UVNWWXZjSXlERXdoRGE3VkFrK1ZPaENHUHVjNHlPbE45VGVES0tPN0xWRGdw?=
 =?utf-8?B?bkVWWE9Hb3hOSGJGZ2hVcjNRRE8vRlVtWWhBdTREcmVNK00yZ1NZTmhQTVYx?=
 =?utf-8?B?Mmx1Vkl4M0V6dUJWMUdRNmJ1V0FVaXhnQXhJdTk0U2JleVpNbkRnNmhMQnl4?=
 =?utf-8?B?eGdtanVYZzZOc2tCYjV6a3RDT1ZvYWhKaEd5QklPRGRnVVZucU1SRlVTM05B?=
 =?utf-8?B?L2gyOWVBajhTbGhEaXpBby9ta1l2eWtaMXZ0bEQ1K1dRSWxHYnk0UXpLd0lO?=
 =?utf-8?B?MGQzaGNKd1pRR29TTk5sMk5YRTdrZk5pZjdjcXhEeHlYd2YxVlc5eEQvY2F5?=
 =?utf-8?B?Mjh4dlppcXlteXdrNmhrS3JoWkp6QTd0aVVOajI5aFF0SGZ6QlRNSk00Y1Rx?=
 =?utf-8?B?NCt6S1h6WHF1YUZIc3RhQWYvaEQzYmdDeG1OZ3dwaVltSHpSZjQwM21BQkFr?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e924b6-426b-4aa7-a3cb-08dc94839913
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6034.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 19:26:51.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJeSILlIMTBBMyzCVMRCb9Dwq0eQB9JGqxAIOoLrz8L0/aURCAIL8ZJf2W+Ti9XBTbmmy3hmk38v/vkNpmjzaKWg7WDGcu1YeBR0fLcvPrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9033

On 24/06/2024 17:45, Andrew Lunn wrote:
>> https://mirror2.openwrt.org/docs/MT7981B_Wi-Fi6_Platform_Datasheet_Open_V1.0.pdf
>>
>> page 107 (text for 9.1.1 is relevant but not a complete match). In the
>> EN7581 case there is a 5 port switch in the place of GMAC1 (one switch port
>> is connected to GDM1).
> The typical DSA architecture is that the SoC MAC is connected to a
> switch MAC port. You say here, the switch is directly connected to the
> GGM1. So there is no GMAC involved? If there is no MAC, you don't need
> a MAC driver.
>
> It seems more likely there is a GMAC, and the SGMII interface, or
> something similar is connected to the switch?
>
> 	Andrew
>
Hi, the Mediatek MT7988A SoC block diagram is similar to the EN7581 as 
it also have a built in switch (MT7531). MT7988A manual can be found here:

wiki.banana-pi.org/Banana_Pi_BPI-R4

drive.google.com/drive/folders/1XiVchy0a4syYFVlTndhVCETNJ9x7KOYi

MT7988A_Wi-Fi7_Platform_Datasheet_Open_V0.1.pdf

with page 125 containing the block diagram.


Per my understanding the MT7530 switch port connecting to the SoC in the 
EN7581 has a direct connection to the GDM1 port. There seem to not be 
any SGMII and MAC in this data path. How it actually is connected 
internally is unknown to me but packets seem to transfer automatically 
between the GDM1 port and the MT7530 switch soc port.

And as mentioned before there are high speed MACs capable of 
HSGMII/USXGMII connected to the other GDM ports.

So there will be MACs involved just not for the connection to the MT7530 
switch.


MvH

Benjamin Larsson


