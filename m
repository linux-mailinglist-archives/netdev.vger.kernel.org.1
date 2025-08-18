Return-Path: <netdev+bounces-214439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AECB2989C
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 06:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE95B188926A
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 04:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A08A263F3C;
	Mon, 18 Aug 2025 04:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JSh6NnY9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D102356A4;
	Mon, 18 Aug 2025 04:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492298; cv=fail; b=uVXREiIoqSbLevogPzFiIUlqiNYli1JyZfqT0qk98HnnrNk1fBZsO1J4M1DvmsmyqiefUre0kxcuqJWQ19QuYUbtUYn7dy7OPnId8GpZH8vwPB+zNW1kY7podE4fGb6fua0VKukm83l7DfJAPEpzInz1FYZClQbPttgzrxLq/UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492298; c=relaxed/simple;
	bh=pox0oTyvJukJXqyYIZpg6RwB/S7A6znu2tFcBwfOL0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qLxYSVfNz91p94tX1pFCt5ELTCJmpDBxvwpa8ugDNpSibENfyIdh7QUtxM9ukM61JjHwPavDTtSnivveFZPJAXnYHj4cDuVw5cTzTrWaSXFxVpqjhHN3ZjzyRxPqUhKnHznt6sSeWwvQ99qmniFTMAGF7GrI42NnGExy/b/LM7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JSh6NnY9; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUPheFkzT70i4gTH8qTbnCgLxDmNPO7E3Kvy36bGWYfjSzfYIOJs8zHgaqrBsRDcJG2OWxCqqZgUyC2aO6GkJZCb32ECbjtq3sXHk5hVn7TopkVHRvLBl5mBOVkJW7AMNaCpM0l/rhiNNW1KPvzX1Ya1uo+FbicDflZWQYUrSISCX5yOcN4vjnJgcyaJvy6iZuMQ0EAx1gK4yvDjEDDZXUDZcCpFCd4ucZ461PWXafjSKlT2gXlNya1eFDxbumx8wRTH25rrEPQxPVzKF+CJDS3HjHtpFXGX5zn8jQfrhXdwL7ee2Ptw9D4j0zcFppkYQRoMFSb2wi0aas4D93G+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pox0oTyvJukJXqyYIZpg6RwB/S7A6znu2tFcBwfOL0M=;
 b=pMYu8g+CPMYoMR0FiqadnVCT/7WZNsNOD65xlI81AE0jFnU8l+MlHqKAhjB0tpN8kPQjhgQ66JKROweAfzTwwSvSxOuX0TRzZ0yIgLl4Qg+I9alCV7y4V3+9PdglxjfIuTkQa2LUsA4elb1NTrTYj4Wh/TPdkNjQwEfV2mtjZdm5hXHV53zdc1BcRtDmW6izs6T/njdsw6P07XBPqRDKbSV0iDsAZcWnjUcWk08o/wcAMqwvIPIW/zRiCGqBYhpVyIWXhQwv+IWcesn10YAEYvOud3xdyNYkmIqETwEzWeEttY350nEJLazaiezgtQCirodKs1oLa0NjzoSgfVonEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pox0oTyvJukJXqyYIZpg6RwB/S7A6znu2tFcBwfOL0M=;
 b=JSh6NnY9A2vgZSAxhytrlppkrR10lCbhHUTLc27V4lz2cRrrTP3bPmkRIizDQoClD4TWnatGPS580aApW+ZguiGmDqWOZbEnbNEfCrd9/nFiOVJMvWKGPSv+QvAbMJBir7o+F1X838TZp0GW3qj+aqlYqgScFYsXwoj6hplwKTky06pKdtmyCuBRc4/r7fzcfW6XR8SUAtLxJdTvnwZvyJGEh4Do+aZz9FXIz8WPS/faYc/qIk78j21jLbnyEZRu+D9LjeN6wevnQTAxqxndUUmHDK1RJPAdMUjGOBIylKLBaCt7qqLZ7ikeYAL4jCO9SzjMpP/l43GbAIfzctePgg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH3PPFD01EAC3BA.namprd11.prod.outlook.com (2603:10b6:518:1::d4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 04:44:53 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%7]) with mapi id 15.20.8989.011; Mon, 18 Aug 2025
 04:44:52 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] microchip: lan865x: fix missing configuration for
 Rev.B0/B1 as per AN1760
Thread-Topic: [PATCH net 2/2] microchip: lan865x: fix missing configuration
 for Rev.B0/B1 as per AN1760
Thread-Index: AQHcDD3SsskQ7z5alUqQ3+yTJESwwLRkhPaAgANYOgA=
Date: Mon, 18 Aug 2025 04:44:52 +0000
Message-ID: <d8a5c557-f76c-4bbd-a181-d35736ef4cbb@microchip.com>
References: <20250813103355.70838-1-parthiban.veerasooran@microchip.com>
 <20250813103355.70838-3-parthiban.veerasooran@microchip.com>
 <20250815184019.68116359@kernel.org>
In-Reply-To: <20250815184019.68116359@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH3PPFD01EAC3BA:EE_
x-ms-office365-filtering-correlation-id: 6d516d89-83e6-4142-8306-08ddde11f8e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0hvV2RWUVBaOTErSWxJbFNpYTJ1OUpuUEVtdXVJU2RvNFJ1S3ZNR0Y0UVV3?=
 =?utf-8?B?WW1oaDFod3ZkRFhhcUhZZ2F3cXFmVngvMGpnV3VDQ3dNMWZweE9kbUoyNHkv?=
 =?utf-8?B?VEJUbTBsZEF0Zk1MR0xCWmd6N2RBVTRjUnA5QjljYk9XQWhwNlFITy9XRCts?=
 =?utf-8?B?VEFlcCswdlQyNUxWKzd4M24xa0Zoa25XYzZxVC9Jakd6QU9FYkJQQW9jMkZh?=
 =?utf-8?B?eGJxWFk5aExJYjdrNU9KRnJrKzc1SHgxb0x2ZWJJQ1cxRWNmb3FoaXdCYmdY?=
 =?utf-8?B?NU05aHJ5K3lzKzI3RUxHcmlMSnVaNFFSOWc5SkVjb1I3QjFPUTlMckYxempM?=
 =?utf-8?B?dmROWFVCd1VhZmpMQUE0YjNvaHp2S2p0VDJMTk5hekdUTkt2TTZVMjRHTExM?=
 =?utf-8?B?VlRIaEdYaXJHREp0Q3I1aVA4OXlxdUxMbm4wbmpJUmYzRVRGYzNZRWg2NW5m?=
 =?utf-8?B?UzNYeEkrZUNLTVRVaUxtc2l6L2ZkTkVERTlxS2EwY1VWS3ozWHdOTFhIenZx?=
 =?utf-8?B?N3JRZGxPdFZMM25sbzE5TG4wa3FYSjluMlVISFlzSjhSSjNqOEY0VVlRWCsw?=
 =?utf-8?B?Ynp4clRieHJYalZ1T2tUNXpBMEZUT1hsRE02bkc3aTA2SXArTVZacVFieWJz?=
 =?utf-8?B?RXpUZmMzMzZpbi9lNnN0U0JsaVZtbFFVbkMyNG1MY0NMWE9ZSk5uNWMxY0U0?=
 =?utf-8?B?TjZrMEE5OHN2TjdYN2pGU0VQZnZUd1JGLzNzMElMaTgxd3BkajJIWFZweDZT?=
 =?utf-8?B?Zkh2b0tzQlpjMVhXWGJsSEwrM0t6KzMwS2pKTUdFOWtFV1p2NGVPV3RUS0dU?=
 =?utf-8?B?aEhjK3Yrb0VkT0hycUs4THRVZ1Y5TDNQOXBsRVJRRy9LUFY0c1ViTm9qQU5p?=
 =?utf-8?B?TzBsV0NheEYybkZXamFicUFoRklZSlQ5ZE1EQVN6ZTIwSHBYUUhPcHVqNEQx?=
 =?utf-8?B?SUpCYXczYTZnYjRuME9UdUFNUUFwcXBROCs5R0NnQjlTaHFXMW5tblg3b0RF?=
 =?utf-8?B?YVdhTzIzbEJ3d2VvaS82ZGd2c0hhRGx4azdiUGs0aFE1UmZjVVJSU0xKNVBl?=
 =?utf-8?B?cGZPQmJGKzJNQi90cXRTeVp5UTVHZStWQVlmTWdpSytTKzc5Q2k1YldEakVI?=
 =?utf-8?B?dUowL1dPeWtHdVlWUGF1czhnL3FrMlJrdld1NXVidFd0TDhUYy9VYVIwcUpv?=
 =?utf-8?B?RG5WQ1prNlZGaHFVSkhHZTJTRGxTblJvMjYwMEg4M2Q5N0dsRnh1Z1g5NWQw?=
 =?utf-8?B?WlJCV2xNSk5PMVpYMjFpNFhLNytiZisrN0lwRFk3UkJ6VFVTMXFNellCZElU?=
 =?utf-8?B?WG5xVHBlZFdPMU4zLzc2MzJGUTdiK05VWmFNeWJYSFZGVDl3TjdBbTMzTkhH?=
 =?utf-8?B?VmtlNHFRajg1blRSQTVOSjZSMFhWSGRHTDhZUENCVzlEWis0WVJBRS92cERC?=
 =?utf-8?B?N3d2eG8zMWRRMjJiTWlKd2xIZTNMSWxYVnhqd001WUd4cVhjN1pGaGFIT2tH?=
 =?utf-8?B?UTBVQyt5SHZkZkFBS0ZwNjVibWlpUzdsZUp4ZE1tWXdueDAzQUpGZ2ovdWc2?=
 =?utf-8?B?TU9MSHVFd1d2RXJQUUJFQ3BTdlhiby9CWGE3NkV2K05iUHBSdUFxdXR3dk5P?=
 =?utf-8?B?UUlIVGlicm8xNTNxWGg4bStkY2Fwa3VaNHg3bzRnM25Xc0hSMW1VRmNpQmVJ?=
 =?utf-8?B?SHBnaTBOb2c1OFArN09Lc05KejVDV1pzcS9xRVBvclhBSDlpSGpFUHpCRTIx?=
 =?utf-8?B?dEQ3MkV2U0VZa2R4SW1URFhXeVV1QVIwM1p6ZzBKM3NoMDZVWG9uZm1LeHlv?=
 =?utf-8?B?OERBck9wTVRzRWhqRkNEbSs3VkQ2aFhNTVpyeVhaOXkyVEo1MDdPbTF6di94?=
 =?utf-8?B?b3p4M3lOdjVUZzFtVmhUb3k4Unhzb3Uxa2pnamhMSUxMYlNxZHREeTVBbHlP?=
 =?utf-8?B?U2wrdlhVZHpta1FsaHF0SExBb0RmQzA5RjIwVzkyT2pNQVNSeEZtRW5Rb1A2?=
 =?utf-8?B?bC9OeTlnL1BRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDRFT0FKaDhobTA2MEpLZUx0cnZ5dHlIM0pWYzZJMzdTREhiWWNNN3NaRm9a?=
 =?utf-8?B?Nk95WjBZNy9nUEF6ODQxVDVJdGw4OUQrdkdSL0lSMVh6TmZ5T0JzamVDMXkz?=
 =?utf-8?B?Y3YwanFQNFBWTmZzdzYraWJtK1Nrakw5elJQVXU0RlhNbkwwdHRsdktUQzVs?=
 =?utf-8?B?VDEyTEdFdS9PdTlWNlV4emlnMjM0QUwxYlgwMUpFZDlya2lCbkF6bHZQdm9W?=
 =?utf-8?B?MzRGeXB0Tzk3dERnSE5rVW5Lck9mdmFKazdNZ1IvdWpzTUtTZ1V2RlFBM0ZV?=
 =?utf-8?B?VmVoSkd4bWNGWjg2cXkvbnc4c3pESVlQQXltajJGRGtrZFlqKzdiM0RUa0Rl?=
 =?utf-8?B?em8rU2E5cGRmSC93NE9aU2lYYzM5ZWRNTERJUkpSMUpycHBpaW1aMDNvOUpy?=
 =?utf-8?B?NXZCcnpKK3QyWE55cUkxa0w1NG1YclJzUlZsSjdhZUdsSDNVZEN1M1dKRCtM?=
 =?utf-8?B?cmh4R3JtQ1o0M2FMc1lxeGlSS210K284MkVDWkpYSnNjblhqd1JJa254L3hY?=
 =?utf-8?B?YjNqNFFlVXowbnlxSFlabGpybldubkxIVVFXbUQ4MWJOU1A1YkVBUHVYUDZq?=
 =?utf-8?B?Zmc2eVNxNEE4S0tORjdEMGYzRmE3Kzc3ZzRZMEVXQUIySmRKOVVQSVR4WVUx?=
 =?utf-8?B?Znh5MmZKVlNlMlRkRDVoYTVFWjY1cjNOSWYrQW5mN3RDdXUxRkZPSTlGS1pY?=
 =?utf-8?B?dU9ISU0wRXQ2RGZyb25mdllxcjgxb2t0WUtKMVZkMWF5K3FxYThLZDQyaHNs?=
 =?utf-8?B?WGVDeVRvMTk1ZC83Q0lJV0tBQ291TkYwbGhKbWVMZXZudDlueTBzREh6OG1F?=
 =?utf-8?B?L1ZRam16ZVJvMldQeWJRWlZOL0xJZUk4MG9ETldiUkoyUE1IcnVFM1VmdHdk?=
 =?utf-8?B?bVJDSHlvbW5vTzBTSzRvYXhhNTh4WmVMaDVERThBYUNGRkIwOWFRcTRGRVlq?=
 =?utf-8?B?UW1hdzJHSkVFSHBUc1YvSXl0SE1QU1I4WXo5K0lrNFNFRHlSa2RUSFZUUHlm?=
 =?utf-8?B?dFZ6NjZMR2IwU2NLZXNBV3BVMDUzQytXd004cXEzMVB3WGVXcWhsK0h6Sk00?=
 =?utf-8?B?VzdCY3VoWmhkeHl5dW44Nmw0NTBjbGtENEVpNkh1ZFJhSThra2c5S1hDa09B?=
 =?utf-8?B?dGdzQjBxVWRsd1VWMTJhL3lBMlJOWXNzdExDWGVWTHl2R0hJU0xwYktGRXEx?=
 =?utf-8?B?RVlLek51bVNzQSt0MjN4ekhlU25ITkQyc0pxT3VnV0x4SDBYdHJuSW1MKzZa?=
 =?utf-8?B?cmVOTDhGRG5meHB3NkFMc2pvd0xlTVY4NHYxYzlIOFJWQ2t4aUpYeEozU1gv?=
 =?utf-8?B?M3dWV1hDdnZYaVlCbWdGZ3RSVUNiUlhITDNxK2FnaWV6MURFWUdSelhhZ0hF?=
 =?utf-8?B?M0Z5U2R3Yzdnczl5ZFJNUFl6ZERhQVJ2NHFSTDNvaXlJU0c0dUV4Z2FqMVBL?=
 =?utf-8?B?TXN5b1g1VjVLdnFmVUJFOTFsWTNNTklUOEJKNm4wc01XWjgrOUpSeUJUUW9Z?=
 =?utf-8?B?VmJPaUptenI0YjlFT2t0TXJyaHN3VWNsdVZsTnNjK1lLU2ZnMTdWbzY5ZGtC?=
 =?utf-8?B?TUdTS20vRld5d1JEZ3E4UXkvWjg1RWt1emJ2MVM0b2twZFF4RDhVQUY5bi9T?=
 =?utf-8?B?YkJ5NHpncHNuaXlLVFBmSFZ4ekJwdlhGeUd5bFI1WlZxdnR6NXVWbGErZmZP?=
 =?utf-8?B?WUhTZ2Y3d0VLajdkK3pueTZUZG5YWlY5dkl1MU45QmxsNklMWTNubXo5QXpY?=
 =?utf-8?B?SmRVWWFwT05VeTlGdDdZd3hEYmtKL2oza3hIRCtFVzRlSmxXSGR3aWh1N1h0?=
 =?utf-8?B?cVpWcGtTazl4cDV3eHdtTGdqQlh3WlZuZTBzRGIwNEJyKzR4UFkzbktpUDJI?=
 =?utf-8?B?WFRNTU9qN0FzVndUS0UreXMydDRxSnFKQmJQY0VXTkFDQVBVQ3VhQzA0elJH?=
 =?utf-8?B?eHpGK3R3c0dFRExuMTVrSVhjVkQ0dlA5K3o0ZGJyMkVHZEdqY0pzc0VNNUw0?=
 =?utf-8?B?eUI1ZzRYUjlZbjlXYlZUTzBFN0MwaHZxNGd4Wm50WW1lMjF0U01ZcmJJc3BJ?=
 =?utf-8?B?SDNLdGJzZlZGejR5dVBhMXFaVUR3ZGszQzN4VDdGY2FMSmxWbEV5cFI4Yjg2?=
 =?utf-8?B?OGhiVzZGczB0emlyRGM4MDN6R3Q0SnM3OFY0dlRPSUlWVThlWklBRW52OE1S?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAC799EC7A7003418C81FB3CE109FFA4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d516d89-83e6-4142-8306-08ddde11f8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 04:44:52.7494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1EydeVj52jxCwWmyrOtgXisecmMl3o7FRvVwzZWbJG9XVbS34wB4NqT3qzHZxJ2jrWuB/CtP/04EJmcE95HYr3uHJ0Zy3xMeiTFaHNHzBm71f+AalwDOAJcav0W5cs6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD01EAC3BA

SGkgS2FrdWIsDQoNClRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaGVzLg0KDQpPbiAx
Ni8wOC8yNSA3OjEwIGFtLCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIDEzIEF1ZyAyMDI1IDE2OjAzOjU1ICsw
NTMwIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90ZToNCj4+ICsjZGVmaW5lIExBTjg2NVhfUkVH
X0ZJWFVQICAgICAgICAgICAgMHgwMDAxMDA3Nw0KPj4gKyNkZWZpbmUgTEFOODY1WF9GSVhVUF9W
QUxVRSAgICAgICAgICAweDAwMjgNCj4gDQo+IExvb2tzIGxpa2UgdGhlIGFwcGxpY2F0aW9uIG5v
dGUgZXhwbGFpbnMgd2hhdCB0aGlzIHJlZ2lzdGVyIGlzIGFuZCB3aGF0DQo+IGlzIHRoZSBtZWFu
aW5nIG9mIHRoZSBiaXRzIGluIGl0LiBQbGVhc2UgYnJlYWsgdGhpcyB1cCBhbmQgbmFtZQ0KPiBw
cm9wZXJseS4gIkZJWFVQX1JFR0lTVEVSIiBhbmQgIkZJWFVQX1ZBTFVFIiBpcyBhYm91dCBhcyB1
c2VmdWwNCj4gYXMgbmFtaW5nIGl0ICJSRUdTSVRFUl9BVF8xMDA3NyIgYW5kICJWQUxVRV8yOCIg
Oi8NClllcywgc3VyZS4gSSB3aWxsIHVwZGF0ZSB0aGUgY29ycmVjdCBkZXRhaWxzIGluIHRoZSBu
ZXh0IHZlcnNpb24uDQoNClNpbmNlIHRoaXMgZmFsbHMgdW5kZXIgdGhlIGluaXRpYWwgc2V0dGlu
Z3MsIEkgaW5pdGlhbGx5IGtlcHQgdGhpcyANCmNvbmZpZ3VyYXRpb24gYXMgYSAiZml4dXAsIiBz
aW1pbGFyIHRvIHdoYXQgd2UgZGlkIGluIHRoZSBQSFkgZHJpdmVyLiBJbiANCnRoYXQgY2FzZSwg
dGhlIFBIWSBpbml0aWFsIHNldHRpbmdzIGRpZG7igJl0IGhhdmUgdmFsaWQgcmVnaXN0ZXIgbmFt
ZXMgb3IgDQpkZXRhaWxzLCBzbyB0aGUgImZpeHVwIiBhcHByb2FjaCB3YXMgYXBwcm9wcmlhdGUu
DQoNCkhvd2V2ZXIsIGluIHRoaXMgY2FzZSwgd2UgZG8gaGF2ZSB0aGUgcmVnaXN0ZXIgbmFtZXMg
YW5kIGRldGFpbHMgDQphdmFpbGFibGUgaW4gdGhlIGNvbmZpZ3VyYXRpb24gYXBwbGljYXRpb24g
bm90ZS4gU28sIEkgd2lsbCB1cGRhdGUgdGhlIA0KY29uZmlndXJhdGlvbiBhY2NvcmRpbmdseS4N
Cg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gLS0NCj4gcHctYm90OiBjcg0KDQo=

