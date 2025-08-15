Return-Path: <netdev+bounces-214211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A667AB2885A
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 00:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A3DAC14C9
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C86246766;
	Fri, 15 Aug 2025 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="GX/6op3i"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2100.outbound.protection.outlook.com [40.107.220.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202803176E9;
	Fri, 15 Aug 2025 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755296833; cv=fail; b=qUmsILkgUQVbPc7Cad7Op1ska2gve8G1auma8QBz7aMxv1w+DJwiknlzgHdH60ua7ePAkChcSNcIH6cKb96q1FYMWqDY3ALsMAazaPoPbmHqbzjDq4ZJ32ZkVYsbzUCYMCIt4QEZ18Ao4KQ/LLtuD7GTMN9ggQiS8CdXhiqBEzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755296833; c=relaxed/simple;
	bh=nRxatMm/QkD5vJS4V/ULAIAlIUJ8GlZHxtTixyYe7pw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KPtS5aa7ojpVTVoGCvTYSnixlJ653z1VqsYpg7L0zzhJLYQ834K43RP31GmJheYJ/hfPyNWtEnxJtfdjGgoBi3MXCYhw6FcVbNvltWrTeWWVVLXy4l1OAd3eWfmGy3k/ogHFQqDjWujGYgzfFyOGjBxk8ixWisJy/UqfnDWIW4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=GX/6op3i reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.220.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBX23Nzx7H8Vu1RlsMPyhvbW8D7ROKjtG8rbPUn9gXVILZv0xfXLfjJ3MOSMlsitcYX63eKSIZxrbYwDMPsgVX8LGdNoeee9pnQiuZa50vTqOSR3JSDdlNWvTeTyprX00pDqzsLdTIA0kq7u0UkCmrjaNHqyqokUUEvHFhuOSAur1QKcINQ+CpMqd0fUXKVE+RDosPQkVaP9EkjrrjIqdbIzkswhbmj4rHL3g4324eu41ZONVYoUGIy4OLjVh1Tzu9kl+Go4vvofojDTcFvHIsJ5v1jddJ4H3DihdxEmJiSLOoDPmpfv73PRUJVlLk+m3RH7bLNMTVpydQxA1NOrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIn/+mLzfNosEd8MvLeSbYSHlG3Pk3NGj8KAVX4z8Lg=;
 b=PY3z81vL97+DPumEVuxdqJr1TuAdrBKOxIKj2ZGykKmG+KlrU8VwfjYauiFaa1pprQnT+sTRzvLUHLRIt8EHnFTIgoJ2JNbURh7Far8ZS8OO1Sves7R84x+RvZuzf/SU37d8vX/Eg9GBPiAHSYdM69yz18L/zp6/IMAwOfbc8+q9csTkdc70vlm0IJluX8piirNs1b579UJmrxbZ+4YwShBcbA/PKpLh3VzlM7L8jSbAB2kdf7tdwU/9aHoRFdX8vZEqAfAAMHXyZ1+zgV/VAGLfT83j64w78MkRCa8d469Ln2lvbI1NH7plaxUvZ7L2GFAXqe73G3GohgVZnBvGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIn/+mLzfNosEd8MvLeSbYSHlG3Pk3NGj8KAVX4z8Lg=;
 b=GX/6op3ihvBnkLGBGGB3OajyEuiUBOKvvYYY1yFU7Fv93jsPzDujYGMp7dNxMo+8NoRTPamjT/GewpvWsWsQhEPcD7Dd3Vjtk5n5WYQkSMlx6hU8Waadq9LbHQWK5o1B9rJTy/pbCHYLysvPp1Yy3huSUpG1iZMqu3c1KoijI1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CO1PR01MB6614.prod.exchangelabs.com (2603:10b6:303:d9::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Fri, 15 Aug 2025 22:27:09 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 22:27:09 +0000
Message-ID: <d7b692a6-e4d6-450b-9cb1-31f95d7ab0b9@amperemail.onmicrosoft.com>
Date: Fri, 15 Aug 2025 18:27:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 1/1] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250811153804.96850-1-admiyo@os.amperecomputing.com>
 <20250811153804.96850-2-admiyo@os.amperecomputing.com>
 <42643918b686206c97076cf9fd2f02718e85b108.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <42643918b686206c97076cf9fd2f02718e85b108.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CO1PR01MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 965222f9-dbf0-461a-f446-08dddc4adf91
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1pmZnNGNWQvYkRhYS9KU2hRd0gxd3I0dnMxb3FEeFBUL0xRMzlSNDJRaFJ4?=
 =?utf-8?B?Y0IvTVB0bDJLM1lpV08yMWE2K2dsYkhVNUViTU1EQ2FGc2Q4Z0oybkNyUlN5?=
 =?utf-8?B?cVFmZkhyTXI0QUlZREJ0ZGZuMEFQeHhLbENNQmdNTm91eFIyRDFuK2xBTjht?=
 =?utf-8?B?Y0J6dGRIZ3FKclA5Wnc4SzhhTFN3UFQxRjd1VEhPeVlZUWpQNG91VlFoRGxK?=
 =?utf-8?B?dWZON2QyNkxkV01oaWgrd200bTNlNkhJNkx6cldlVk13aTA4MEM0VnRrenpP?=
 =?utf-8?B?QVhtTU51d2oxZnpxQTdWc04ybHVLbVlveVFjUEdteFV4L0NTUVlMd0dwTFdD?=
 =?utf-8?B?eWE4c0x3SXVlOEUwcFlKZWVvRm5wZjY3RTRxMnJVaXR0aGlDeXFZRkZQRlNo?=
 =?utf-8?B?dk5TYW1LL3lFa1dlK2xUK0ozVlFlNXk2TE9qSk9DRDV6akJZaGVEYkE0YWxP?=
 =?utf-8?B?dEY1V1ZpWlhyWG9uRzFSUnllSmRiRG5NZ1I3TkF3dUFRcE5tNWxvbW1TTUNL?=
 =?utf-8?B?MDlZUzQ4cC9vUzBtTDJURW1TcUFwTjNoNDUvVFM4Vys0SDNvRnlwR3ZsRXNz?=
 =?utf-8?B?Uk1lVUFtaElwYmZQdlJUWHhNNVhYMm5mU1BDdmdJYnFDd2RyODVWRzc5TFI4?=
 =?utf-8?B?emZkaW5WcVNMaWN1ZnJtR2lobjdRM1V3TkQ4RXFXR1JkNUdqWE1FZ2JaUW1q?=
 =?utf-8?B?NWptUFJ5MGdscnJ3RkE2UDdDaklVSXc5MjhwcEd2VmlXMXVLcktxeHgzZkh4?=
 =?utf-8?B?dGZZck40akcyWjRVTE5CUVhmMXE4L1FNZktLZXRaK2ZKSHRQWFFIWENHTUZC?=
 =?utf-8?B?VEh5WkJsVjliQzdTbzRzM0hNQ2h0RUYrMVd5QjJDUzhEZEtReUZqRnlLMUJk?=
 =?utf-8?B?bmsrR1cxcWEvOXF3ZndBRUlHUVNiOUt3blRWcHpPSjBVdUU3NlBvdFVlWFNG?=
 =?utf-8?B?WDFGeU9xVWNoZ0kzQWhxckdHUnZRVEhOMEJTZzF1WmZtL3FRUWVUSFUzVHJx?=
 =?utf-8?B?dWJxSTFySEswdlFiVVlESHp0RVpxY28wb3NzZ1p5RnpLNm5YT3BGU0ErVzZu?=
 =?utf-8?B?dm92U0h6N0dZbXh3TmFVZVZtMTdvOXNMSmkzaHBMVDRJS0R4bnZPbUFuMHdZ?=
 =?utf-8?B?WU1jQkkvRm1aQXYwYVVsbDVYUlBickxRYlFTVjB2RnJPY2c0ejA1bHJuYjhk?=
 =?utf-8?B?alZhRW5IZ3RxSlNuQzE4cnhUSTRsaUhGQ2Y4MjdGWWZkVXI2RGUzbHlOUDZq?=
 =?utf-8?B?SEI3SEpwKzVRYy9kcElqeWloZG04dkx2dS95azF4c2x1RG1VaWIrY3BTUlRF?=
 =?utf-8?B?Z2JFM0g0TnhleVlvcDJxczFNejJFaHRYbTlJenpiU3Q4ZFl6Rmp1YVpndGF6?=
 =?utf-8?B?WGVxSmd1MG1XakxXc1NHYWFNL0ZMWWpNRHk5TGZkdGRZVzNVL0crU2xXNHNY?=
 =?utf-8?B?Z2I2cTJqeXJtUjhIYUZkZWxlQVBDOERydUJQd3NYWVhvSzVRMm5GWXBMUHUr?=
 =?utf-8?B?N21wY2pONnRyN0VlK25lTWNpSmlGeWRMUVVFTGxkdWQ4eEQxUjYyS0hESnlq?=
 =?utf-8?B?alpwNStVY2wzQXZxVUtuSzdWZnNKMXBRekRHWmhQZGNjSEZpOUFUMXBObGlT?=
 =?utf-8?B?UmV5K1NWckZYTXJNVk95Zzgramc3ejlZdUlMQzNwbXF4ZzJCbDUvSTlwK2wy?=
 =?utf-8?B?a0lhOVRzTEc1YmNYQldoSWJSZlBkWGdsTWcwK1NrVUI4NFlVbzZVVDVJV24z?=
 =?utf-8?B?WXU0OVhYdmVlK20yTXlBZnZJZCtCbW8xUGl1UmZjQTVFZkNVU3BJQlFrcW1S?=
 =?utf-8?B?TDUxNUZUNm5WWi9sMTV2TDN2MlFrN29vem55M1gvK1BXeEtwWSt6dno2alV4?=
 =?utf-8?B?cmh0UUMxUXZ4NHZsb0pKaXoxVjFzT0hrejZUU2Y0bTZVdXl4anhBenVKNUs0?=
 =?utf-8?Q?FiIsrMFloMY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzZucUdmQ0pMd2dqdTgrN1N4bktwYjNDMm5HeHoreFJTazZGVS93MzdoMUZv?=
 =?utf-8?B?ODRMZHVIV2I0VHhLR2pqYm0vQVFBdnBvQVZJbTI0bXhDVFh4YlFFeGpvb2s5?=
 =?utf-8?B?V0VTQXhIdXZvcEtIMmI5NUlKR3J4allpa1p5UEJ3Z2FZK2VOVytLL2I5Q21W?=
 =?utf-8?B?NS9zZFF0MDNmYWJKdy9vbTg1L0hRZmt1ZkZYWmJWMWxkWUFDZmxKRkRRNnNR?=
 =?utf-8?B?WmRBaUVBRTNobVhwdVFsdXZjc0ViSzRPRDRLZHdxcDZhNTBuTXQ2cFI5Nkpr?=
 =?utf-8?B?a1RQTUFvVDdjQ1ZDREVDbXlnMGc3OUpSQWlFOXJndUMwS0p5dG43N2hyOG1l?=
 =?utf-8?B?YlNxZERaRVlCd2dvSUxDV2ZmS1cwUHJsMHZIeDA5YlJIMnhYdit4NjFYWHh0?=
 =?utf-8?B?WHA0V2x3OENFME5ud01nVTN6S0U1aWJDbExNMDJCMkd3dGJ1UUNFS3NoMml1?=
 =?utf-8?B?cWF2a1NGR2ZkRnV1WWZHbDdONE1mcUk3MGMzVUx0VVp2Y00zZGRFcjVVZEhq?=
 =?utf-8?B?YnFRWGdIeEExUE5QSmVLaWFCSENidGRyc2swYVNkSysxa2c1cEZoMU84c3BR?=
 =?utf-8?B?cHF5US9iSU91YmVUUm1KdVRBRHQrb0RCTEM0bkZjVHBPTVRaOCt4YW5mZzBF?=
 =?utf-8?B?TGpxM3Z6SkJUdDdkaUZsTFhZV2xwTDdFSUZEQnl5OHVBSGZzbXpNbG55Ry9E?=
 =?utf-8?B?ZkVSV25QM3hTUVJuTm93ZXFQREVkRE0xRUFDNlhwNUE5RWVOdEI2Z3ZnLzFa?=
 =?utf-8?B?NDF6MU9KdUI3Y0R0cnBCVFE5SzlLQVdDYTZwNXZVNisvcTlObDBqVnMrcWV0?=
 =?utf-8?B?Z3hvSlRQdXdqeEFreXFtLy9LanFiWTAyekhNWHpwSVkvaWE1VDNURG10am9t?=
 =?utf-8?B?Sk14V0VNWVVFOXhRaURucjBpOGFpdVZNcG13UUhtbzhGNlZJSG9TRWVRWmFv?=
 =?utf-8?B?bnAvdkVkTE04MlNvUWszYnRLYzUyVWplUlNoUS9tUUlIOTNsdjRZSWloTSt6?=
 =?utf-8?B?dzZOTGpWSER0bWxQQnJQRmw2RjNPdHdtMngvRUpiVVpvb0c0bUNMNTErcEFV?=
 =?utf-8?B?NEJIM01zdHNvZmRpUW1YNGVnZ3orNFlTdFVYWFMrU3AwWHEzb2RIU1p5ZjFW?=
 =?utf-8?B?RTEzM2dIdThOWVpkamowd2JQNVcvT2VpSXExU1hjd0k4bGNvd0IyeE0vbHlT?=
 =?utf-8?B?c2xlRFlicmN6ajl3SVI4WmYyb0ppK1Jobm5XSUtKYng0d2lSVnF2cDRscXZ1?=
 =?utf-8?B?L1RqcFhnVEdVTXgwRURITnk5MllBbEpaMEJlUHpWbmRCZDZCalBDYXVORXpR?=
 =?utf-8?B?Wml0UTZDMEhub1E5ekFIRHpCSnZxVCs0eVZDNGVTM285WWlZWTBzdHVUMTFO?=
 =?utf-8?B?dFFIeXRzUE5wOEJuQTBNK0dCTWRRSUJiOWNEV0xxYWdRMlNwNDk5MGRuRERk?=
 =?utf-8?B?NWNiRHhrV2NwOW5qYzRzU2w5TkZ5c2UxQ3l4RmUxcEp2UWpaeHNoWXhidWha?=
 =?utf-8?B?K084cjBVR1ZSdmd5SlE3dndxL0RQcW42bnhwdzhIMHZoOGVVcXFEQUJPTWtQ?=
 =?utf-8?B?V1pERHE1WmtxdWFBbW1GTXIxQUhsOEpORm1aS1BxcWt6NW1lRGpVZkVNNGZa?=
 =?utf-8?B?NjJpQWN4cnVDV1FrNGdXSWQ1dytwS2d4ZitPakU5dURSN2IxZUNmdjlON1Fh?=
 =?utf-8?B?R0pORzBlSU5Da1JlUlFuRDQraUprdnRzMm1LYlQ3Vm9jZW80K3g3VkViMXZN?=
 =?utf-8?B?NHVEaEUzV1BOdmFESmFvSU5HZTAxOUNiOUxrZzJrSUYvaUU3VzhtVVFsY2l1?=
 =?utf-8?B?cVUwV2ljT0NyT0V2QVdwbDNmNzZHeFMrbUMxdlVUSFl2d3lKb1N0eTFNUDRL?=
 =?utf-8?B?a3diT2lwbjZtaUVYdEkwdkpZRkRCVC8xc002STNyME1Venc0NnpBRWh5ZUtP?=
 =?utf-8?B?UENEc0JWdnFnTjN5bEF3OTlTNlZGWFFHcjZTcGJBUFg0SmZSaER3TCs1cGV3?=
 =?utf-8?B?ekN4bjYzRVM5dGUyS21US1JabDRhais4bEZxVTMxbXhidEZlZ3lVQWVPQ211?=
 =?utf-8?B?bkM5SUt5YkFHdFU1eU00L09ReUNDbktLNEdtT3Y4cXhqV0MzcTBUdnhKQ2F4?=
 =?utf-8?B?WUV5bkZXWnMweDNvbXpNVUZvZzlrRDM0MkhINWczaGV4ZXNrcno1YVdsZ2JC?=
 =?utf-8?B?Y2N6M0JBdlFGZkMvWWxOdzFzNnVBMjFSaVBRek12VWc4Um5pYndRa2JaMVdW?=
 =?utf-8?Q?ZURu9tghW9kNOkbGaWqBRYX70pip2ptCtu65MKYUOc=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965222f9-dbf0-461a-f446-08dddc4adf91
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 22:27:09.5943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIa49Ag1zo8NJjJfEh7x5eykdX/yMDrEHBqIKNO9sBp5d7XqnANlqirtlnMjcocbiwifM+sd6vE15F+Xhx2L9mU9bKaqPotC1nKU9ZqpWMJnkffopX7NIwvaBdVR46Ly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6614


On 8/13/25 00:46, Jeremy Kerr wrote:
> I see that this is failing to build on net-next, as the mailbox changes
> are not present there. You may need to coordinate for the merge.


Does Net-next get resynced when 6.17 advances?  I can keep posting the 
mailbox patch if that makes things progress.


