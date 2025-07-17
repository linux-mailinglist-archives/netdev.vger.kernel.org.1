Return-Path: <netdev+bounces-208021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFD3B0966A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E6AA41511
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 21:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D098C2264D2;
	Thu, 17 Jul 2025 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="ch5e+0vV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2128.outbound.protection.outlook.com [40.107.236.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2F17E0;
	Thu, 17 Jul 2025 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752788412; cv=fail; b=eUUHEBxmLObUWXsf8M3f/E8yFtgjajmCw8PXfZgMP7BTxVizgqFI7WUoN+es0B1TfrHPQRvJwaURRuFRaSflg2dxZUdhZJMS++HA3e9x5ZmwmFW5UOhWi8BkAdjCsknzIkbb2CPkemfr9QCHyjW6DmxKBlHzBhrRdo0XUM6r54s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752788412; c=relaxed/simple;
	bh=VWRTVLorH8TlK9XqAEwkM1tsqhcApkk7Cdyj5bmJgi8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eVUvNPUYLQ1pWyNJgUPPWjZH99tbkCX+uNUw7kK2YAe+cto3QeE9jfR2fiKTB4D1koxNDXt2ukLFiQNiG/JA0/q6MdZjcIciu+uWNMcsfqp5EkWfM1+T+Ymx+AXZPLBuxmlthW776nqMS8agaX/bPsYC/g38JGk5OCCzrmMJrbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=ch5e+0vV reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.236.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPdTP4xZzGImwplt7VyjbCKDhfY35MEZ8149Hjt2zZ/khnhtDNreThkYenM9Q7NmS+o+Ogxn4d1wDFiD7SiqAWzr4TZhC4h/y7cZUqLzm0pRFzDYhVskqySEWP4ZTWF04B79CB8UtvZdVHK7/EhVkBkJRN0sz+ovK3IuGGjtE3UVXn3PjwvtTopg/8ac95fiK1Y/b+gA7s9FWmPzqq28Kwyr14kyCPaOjZMMeLcbLrYPtwJttNpHGKTgtAPB9eHG7llDAHFhYWFBdoBBkYANUyFDZCnB5E36jG2ae99hy9d7LSkelegWbnWSnkcFCD4pcIG/B3b9ow9e1XdqvLNTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpnbzJVE96omeoq1WDqGFhO80tx2bKnhH+kT3RIPpEQ=;
 b=djVysFd3mZfGS4zes9OCrmFYAUvrsU260W2YQMb0mFbhxKhCp6+Il3D7E5yiG0K/dtqPrY9fPPMfCdv3lYZA7+IN/a3V3AVik2C45qio3l7du4aL3YDjmzD4EEO7rD8rF9m8p4myV9h9UEj9whJA8GxJKFOjPUH0QqDQGzAU6f0aH6VyhrOgifkgRC8GT8Ibf6ZS2rc6HruICJsiKwYr/S/VTCXtfhCK9MUTnLgoNpqewffAEjgNjw75loE6GiJnQsbl6yzX2LQiuxQcOV52nLL9GcP0wweR51oNSL30KkAWbO+q5j3lDTrxqyakLtLyGm8wWWeknUQ47zt2yH9WiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpnbzJVE96omeoq1WDqGFhO80tx2bKnhH+kT3RIPpEQ=;
 b=ch5e+0vVNngTeVkhzo9B9dCgwcabf57F6vc/gnUvaimRD+4fFmJeKLSwNL4XYtb9Ug9QtlKbjTWDJQsoPdNI/C33Tgz6nb7kVUVe+/qd33/8xh7NI6Q2nRNsJRwu9lh17xOD5h+oJjaG9M06CGlb6SWGW/yGsm3keZ2EbDAeGsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA6PR01MB8928.prod.exchangelabs.com (2603:10b6:806:42a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 21:40:06 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 21:40:06 +0000
Message-ID: <19846931-4b99-4502-9e6f-e992f7959508@amperemail.onmicrosoft.com>
Date: Thu, 17 Jul 2025 17:40:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
To: YH Chung <yh_chung@aspeedtech.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>,
 "matt@codeconstruct.com.au" <matt@codeconstruct.com.au>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 BMC-SW <BMC-SW@aspeedtech.com>
Cc: Khang D Nguyen <khangng@amperemail.onmicrosoft.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
 <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
 <27c18b26e7de5e184245e610b456a497e717365d.camel@codeconstruct.com.au>
 <SEZPR06MB5763AD0FC90DD6AF334555DA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
 <7e8f741b24b1426ae71171dff253921315668bf1.camel@codeconstruct.com.au>
 <SEZPR06MB5763125EBCAAA4F0C14C939E9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
 <2fbeb73a21dc9d9f7cffdb956c712ad28ecf1a7f.camel@codeconstruct.com.au>
 <SEZPR06MB57634C3876BF0DF92174CDFA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <SEZPR06MB57634C3876BF0DF92174CDFA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA6PR01MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e9a8ff-f910-46f8-cb1b-08ddc57a7f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3BMQ0lhQzhjSGlYQW5xWXVqMmZETHNwdFBJWm1lT0VqME5jUTNZK2tLMEQz?=
 =?utf-8?B?anpsdlhCQTQrYUo3ZEhQc2svdTJGS1B1ZDZrcWlFUElKWjhwZzlRWGduZDdQ?=
 =?utf-8?B?VHJHcFFtRUJDdWJWS3ZsbHJNaGlIWExPcStVcHN0N2hsNzFrc0hlZEFjWTdk?=
 =?utf-8?B?YW5TOWFkRmhzb2QvbTA2T2RaRXVEKytBQXdDWXpONDl0QTE5VG9SZGVVbEJY?=
 =?utf-8?B?c1ppUzdkdFdXanoyek9kSHJOUm1nTTFUR1llY3NIREJZQm00aTl1S0VPWmhn?=
 =?utf-8?B?NnQ0a0ZrTGxkUFR1cUw1RndrN2xIWVoyL1d4QXNQUTkyVXVydDF0OTJUcHNp?=
 =?utf-8?B?cW42MG9SbTVwbDluQ1lxVnFvZ011WHVvREx5WUlzMTFQb0s4ejFZd0k5Z2k3?=
 =?utf-8?B?ZGpZMUpXWjdPa0FJbWNTSEtlOENjTzZnRkE1ckR4Ly91UjVNYTkyN25McG4v?=
 =?utf-8?B?Vm53ZnpzdVY5OGdHUVNTeUtQS3k4Zk44NlBXSlhwU2gwdWlZWlZDazBqdDV4?=
 =?utf-8?B?R1R1dTNuVTVqcGgwUFRZNTF4bmd3M3REVFJueG1wbERrQ0dRdGx3NWpJVVZV?=
 =?utf-8?B?MjNCUWdSYmFKWTJFTUkwVS9aRnMvVWJoc2xBUkpsYXl2M0tkdGJCN2lUQkJr?=
 =?utf-8?B?V2xFZEZYS3NLK0tra3lSeEphbHdvQ0ZYSEhVcGxqWEZyRlFXZVp3L0k4WjhP?=
 =?utf-8?B?WXBvbHBWZFhkdUF3R29wc3gwSFNzWkpKMG5EbGp5SG1ESjMxM3NmWGFaaFpq?=
 =?utf-8?B?Vy96QldRTGtxQ2Z0N0pWODR3VytrWHNYcmR2ZWZzUE5hY0NacEdiSGlhVFN4?=
 =?utf-8?B?YkdaczFvYStxTDdSeVVoeDlxTFc4L1E3c2gxeFVJcjB5RFVJM3kzTDJ3Wlk2?=
 =?utf-8?B?eVRZNEVINkJkU0wxQVVyVkErNDRZbW0vdmtVSE9XdityTGxqak5EMnliTkFV?=
 =?utf-8?B?MEpCREpqUkY2K1d3anhZY1hqbng2cTJxcno2aXhnK0tPZUl5ck5DYk10OUh4?=
 =?utf-8?B?N01EbFF6SURPRm8xSTMrdmRGNG5teXpkeVVSTUZCd1VXSHNNWG5nalF6Uy9J?=
 =?utf-8?B?TDdvSWVkZ3JiWmhTSDkzdVRNZ1c4VWhqWGVUcGhtVVdLTHpyZ2ZBY3dlTDFK?=
 =?utf-8?B?aUQrdHV2a2taNE40b1pkaTg0cGxOTE1HSytweFpESTVrUDAwanBLV2k0UTUw?=
 =?utf-8?B?OG85b1ZFSmFvd3BPSkFjeUI5bldPTnZpdXRybTJnRmJibUt6YThGUUc2Mlh4?=
 =?utf-8?B?LzRwWm9SL0dGaWFZb0JvbFlzdGR3dHR1WGtjdFJqOTZPeGxheVlJdEl3ZlpE?=
 =?utf-8?B?N0VjZm5zMThLMWkzOEZwUVVrYk00VkYxM0JZZUtKRndiWWYyME1IZjV5Y0Zt?=
 =?utf-8?B?QkFLdU1nclczQ1h1cUVPeDJVSXM3OWtYWTdPcmMyVFJiK2c3ZnpYakdMS2N1?=
 =?utf-8?B?cXUraXR3aWo2dGhlMlhGalhNYkk2MkRnRlFoWm11Tis0QVhENXpOUkpWU2p5?=
 =?utf-8?B?SDBvVmdubWJqRmhXYnpQZW0zdHd6T05pM0VwdGF3QUkvNjZYRUZkQTFxbjlQ?=
 =?utf-8?B?YnkveVZKdGFoaXNLWTR1czJaa0dEWXlPMFlFUHA2ZU5EdkRSTTR5QlB0Z0V6?=
 =?utf-8?B?WTZ4VEJleXpWaWJRd1crM2R4SjZaM0tmQTdWUUszdWxuNnVCWEZ1Q1IyVFRB?=
 =?utf-8?B?SSt6UUtVWXI3bHhmUHdrYVF3UHQvM3ZWWFVNeVFWSmJTQWx5VmFZdEVzeHJH?=
 =?utf-8?B?SGc0RnREZ21SVmdjKzB5bXZqRkR5cWFxUm5qTThqRlIzVE1LZWZxMy9paW5D?=
 =?utf-8?B?VmEzRENXSVJBM3RkNS9ZbzZ6Y2JWZVAwbmlYemI2cUJGMG9hMFMxeld5L1lj?=
 =?utf-8?B?bmZ4bGpYWnhxY2hma2VjWEQwYi8wNThacnZBQmhwVGlnRkY2YklQbGE4L3I4?=
 =?utf-8?B?THV2bXRMWjVUbUhWUy9UR0o4KzBSS3dSakVtc3BaU2p5UjRnVk9uMElLL3JC?=
 =?utf-8?B?cGttWmozZDF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDV3VjArRjdNY0RWNmZIaUFCVFh1SDZIcW9hYmoyQ09tSWRSVGxQUENIS1VY?=
 =?utf-8?B?YklHM0lndWhLWGdmK1lRVTZTamh3TFZVdHFUbS82NzVkeUVDTlkzbTNjQ1dC?=
 =?utf-8?B?OHlCSDIyRGVKY05xTWRrMjFneExTa2IzbVZoYkhZbmEzN0swOEVhUTM2Ylor?=
 =?utf-8?B?VTdDRVdobWJlUE1odm5aNFNQa0hsZFB5MFFtZTVGdTUxN0ZhNHlGZWlFRWg5?=
 =?utf-8?B?WTZENUR3eE1RZTY4TUlvcWUyOGowVldSeEZ5dHdwL09lQTNjWWZsaVd1Mmdy?=
 =?utf-8?B?NFY1VXg0RmlFM0tZaWV0VUpRaDVzdlVQS0xFNmphUkYzQ3QvQTJnUFZ4dFA5?=
 =?utf-8?B?ODZpSkpaVUhwY2ZLK0MwTnV3VEZVSklYSzJuL2puUURWUzN0b1IrLzdvbXg4?=
 =?utf-8?B?M09nR0I5LzU4Rm1DQ3dTeVNYWXpSaExBZ3ZGUkwxVVBuL3RjWFRHRnRVUDNj?=
 =?utf-8?B?aFArSWtrM0dJVkRLZWFCRktVUW90WERlN1RncFg2SXZMaktETFB1SWVLd0N5?=
 =?utf-8?B?Y3oxRzdZSHVBMkZsanZKMEtyRW8wMlVOc1VRZnl3ZnV4dmcvbGVaV3lRUjNh?=
 =?utf-8?B?T2RIVUUxaFJ1R0I1UTZxb040UmZBaFFvR3pBWFdJVjBUbFpmdHc3dVlieTJX?=
 =?utf-8?B?cEhDNXVKRW9HRGxhQjhDVTFKK1NQVi9pY0dPZytpeWUxdnU2blRYQWg4U2Jv?=
 =?utf-8?B?T1N0ODNBbFZqQzhIeERFRC9WU0sxQ2VhZVVFWUxjUkljME9ZK3JUQis0eUVl?=
 =?utf-8?B?U1p2OVBYVlBpRjMwTXN5c2ZyTkRxMHFpWjQrcU1JUEVTOVRhck9VVS9IM0xY?=
 =?utf-8?B?S0lXZWJJVkVDcGc0Y2dRczkvUXc4bnRBSDZiclU2ZU1tOGFNQUxRaFFyVitR?=
 =?utf-8?B?NkxDMVpTQlIwekw0dWxzbkFsZHE0eFNJdERFR1FLcERubzROOCtHOVEyQWIw?=
 =?utf-8?B?Mk8wT3JGZjRkRjdCSDZ2WTIzL0hsaG5CcnhoOHFEUnJsUzNrbS9xRlhJQ1o1?=
 =?utf-8?B?QWp2N1VXZ2ZMcFd1dmRZczV4VWVFVGg3dlQ3M3dqVFMxQWZCVnlEOHpFVXZx?=
 =?utf-8?B?L2VSbXlINHlpUnkrUHd4ZVhTYnhDcTc5V3JzSlRBVzdndUFqR2dxK0dGR09w?=
 =?utf-8?B?R2s0aTA5V2Fsc0FwZ2tLVlVKRXpCTUQxNGdLckNxbzMwTXRrVG12OGNKc3hp?=
 =?utf-8?B?N0I2WHpRWEU1VncxeXVPY2VBS0VXVDgrMWFpNHlDcWVBdGZGUXIxK1ZzN25J?=
 =?utf-8?B?a2JCbUY3WHFSSXNxYTdRY2t3OWNmY2tpYmpoVklWMkhKWWZwWXRHa2VYZ3pV?=
 =?utf-8?B?b3RiN2VwYTIvZVJ4aDR1emJFdXRUcTM2Q2JKWFNpYzduNTFUb3ZXZnRIcEJa?=
 =?utf-8?B?WEMxNXE4Wjl2M0xhQXVESkZMQURzNUVOMGtMK1RqSnpNbkczcmlDZGsrcjhL?=
 =?utf-8?B?aG1TRVZkSUl1b3g3RnVEY2Q3TDlNNkhnTkNKYkU1c3ZtQUNkUGM1bnYxMjFY?=
 =?utf-8?B?V3lxTTJOUHhkRVNQVnVIYU9SdG8yV0I3MEVUWVlhczRzSzNmVzU0d0xMejJ1?=
 =?utf-8?B?V1crb01Pa2RMZ0hmaGdEOUZXYmZoeFlVSnd1d1BYdUo4aVM5M1NwVm5MdDd0?=
 =?utf-8?B?Sk1VQmNqeGlLSEtXY2xLVHV5ZVRsL3JQS29yRVVpd1ZaekMyYW1TanBJYmlX?=
 =?utf-8?B?dkpoaDdSU0Z3ZnV3MEU3RWg5SEFkNTZpNE1FQ3VBS2xQUEM3VHlMUzRGTEVF?=
 =?utf-8?B?QVpHUnhNTTBFUzhtYXhFQmFKNG15ODdWVkRRNXhld2IvU1lFNWUrek5QVlYr?=
 =?utf-8?B?U0V6ZUpsSzVLWE9JalJXT3hLRFVSYjhBRmo4REg5Yi9oU0pYWTZIdy9aSnJ0?=
 =?utf-8?B?c29FNUVtQklGL1VubmN4cDgrUUZNL21TWnh2VDhoT0MyVVYwK0t2MENWQysy?=
 =?utf-8?B?NmtLUEgxWDJlN2xJUXZvOWk1MjVHeHd2cjJtNldiTFFvS3EwN0dPNFQ3aGxv?=
 =?utf-8?B?ODdVLzhnVDN5S0huK1VFMWZraGd2OWFmV0dkQzFIRUN4MHlFakh3SVdnN3VP?=
 =?utf-8?B?R1pxbE1wYTdKbnJHYUVlOXRBeDAzTW05Zm15VzFwTVFyY3F4UDBKWExVMkh3?=
 =?utf-8?B?RUJZRGRJWVVyWDJWSytJVXlWMXcrbnBrQXYrWDMydjhROUVyVkJNZEtsUzFL?=
 =?utf-8?B?U3dXcUovaUpXYStZRXZac2Yydkw2Z09uZ2NiS2pxejJHS0FmZjZMK3FZRDFp?=
 =?utf-8?Q?EkSpTrwkaLHRkPNrDr3U4s8nm4ksesjPmmJwvkMld0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e9a8ff-f910-46f8-cb1b-08ddc57a7f04
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 21:40:06.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOSr56fMxn6zmTkZUHgjeZk1niw5PPgfj4IxiiGpjh1rHTN3e3Aexeql0Qes4F4J7vYTHNBFENZHXTNx/aHh/ye2nafYjCviHSSVtejkvD1ZjezTxTcf6p6I2uVDgish
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8928


On 7/17/25 04:21, YH Chung wrote:
> Would it be preferable to create a directory such as net/mctp/aspeed/ to host the abstraction layer alongside the hardware-specific drivers?
> We're considering this structure to help encapsulate the shared logic and keep the MCTP PCIe VDM-related components organized.

My suggestiong  is: Keep it simple.  There are only a handful of mctp 
device drivers thus far, and there seems to be little justification for 
a deeper hierarchy.

Just focus on the cleanest implementation.  Having two drivers plus a 
single common source code for each in drivers/net/mctp seems to be 
easier to manage for now.




