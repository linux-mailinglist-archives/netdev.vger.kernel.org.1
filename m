Return-Path: <netdev+bounces-238683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 658C5C5D863
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19E074E9B78
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C80320CA9;
	Fri, 14 Nov 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="ejrrJVBX"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022092.outbound.protection.outlook.com [52.101.66.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6859315D4D;
	Fri, 14 Nov 2025 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129447; cv=fail; b=AUMWjnzGe3boN0oVQT7rPse9B5KHqlCgZJ5A06xIKGMZ7QumrHZHIlkeqWBZFuO7AwCZA2J5YNCJMsRwnA2KCOR1Hu+HDi0CHH8YApjTdc2C+h8XuadYzuU1rRj4GW09oICU0P3Kd6lUyAH+PB5Thuu5jJTHHdJdc9P1hyQ60kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129447; c=relaxed/simple;
	bh=LnHoa3gobXTHe90joj0bahQlwhW8rk8x9pBaAOqIU3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ijJ7xzoAsJt4xEGQDbcjt9r/DpQawR5cnLO9r+W0fhAWAFnYr58Fkp7HpO4T8uNpG1a7rN35sxJEZQsQtAyGmqYB05CmsonGWWObSNLvFSeAr9uMGE6Yr+OAhf2Ol1dA9h3YpT4Wlv5TCmkXmdE24utqV3ydGx78EPErzCUut/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=ejrrJVBX; arc=fail smtp.client-ip=52.101.66.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkGe4fUSRgDc0n7zo94G9ZT1DzPaYw+OoYY6WfmO3ybdy89z4ciibovKJnkZk4WI8rl9rA8i9sYoKr8LkkTUSiXFMtuszGJzF2CQkivXyiSrTRKzTPw81CYKPWIWvDWWIn1K71U8bBUCl5Nnzh+xFzKCw97DzQ/oFRpyle1/Vb/CYeWCtCiisWAJPrKhOE9Buy6IvatLJZReTOp6CsNF4err9rCXA0yCUgbD6QLGlju2AwpPCvlcIag3Zm6j26smAhQljsNorAKD6Axva5ibnmkwldHOCHUjfVUmVrFCau3BJtlzZjBQshto4lxdJWfVNrptxe6ZHYXFy+o4x1Xodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sALWSiJ10gvRoC2VR5z2sG38NJ8bHhSz0UXHRAnYu0=;
 b=WuoqNe5eseMp9hfD73blJ/mxN9e3h6wInbGrs+htBQ4zwqTQOMQvm+OYV2/3NON/U+3KSLIQYe8gUAUuhyc7BP6jURER6pAAoYIGnFHGPBf8Gyi1eWvXOoTKwl3hE21hD3CkaB9cyPC9PGQFidvBmJxmyD9hx+9wf4Y8PvaFyI8DUeMfguaqm/UrL3UyA8njvjdJCI+pQs+ZCYpsygZRWQfTLeXie6IVA05eRCu2/XqBznl/N3cupYGhW4YwIWvOsB0/Zs+rhBFjFkmmzXQl4U5X6XFiy/mjrdD5nyIHJ3jSauEtlHupoYpjRpBk/MerAr9/NxqIGakon++qYrrQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sALWSiJ10gvRoC2VR5z2sG38NJ8bHhSz0UXHRAnYu0=;
 b=ejrrJVBXNg59rJ1vcq/gWkcszRAZubVqXpwFqLOqNuo7K3EL1WN03NZwY9B/Kikzl2W8MYJnv2ezGFLi6/dE455bwy5w8WBhXLpqKidQTw5GDoc+fDLLgixsV0YeZmDbA3JLU6ygKJj9Kl/QMa3jOocvyFodJ3Ozeae8QUvG8ProSiMF+KThESkbwTBmH8QlpXJtjo0fH7V70SC7a3tg2W+kJHlAvIw68UxUwLdXv3U9K4rUvVQ0TDgYCfNztV06WRd5r1y64ZB0kyAICiBJh8fQLGyBBx6YLKxI6Ea7ObHpMsJgQ7vGS6YtFiM7zzbxk8dtXayWt4vWp0XbdiTyEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from AMBPR04MB11741.eurprd04.prod.outlook.com (2603:10a6:20b:6f3::7)
 by AM0PR04MB11968.eurprd04.prod.outlook.com (2603:10a6:20b:6fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 14:10:36 +0000
Received: from AMBPR04MB11741.eurprd04.prod.outlook.com
 ([fe80::c39b:dab3:ae88:c5ba]) by AMBPR04MB11741.eurprd04.prod.outlook.com
 ([fe80::c39b:dab3:ae88:c5ba%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 14:10:36 +0000
Message-ID: <7ecd1c96-a039-4b4a-887e-10f01d5fbc68@gocontroll.com>
Date: Fri, 14 Nov 2025 15:10:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: fix doc for rgii_clock()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251114-rgmii_clock-v1-1-e5c12d6cafa6@gocontroll.com>
 <aRclKDeHzfJSzpQ3@shell.armlinux.org.uk>
Content-Language: en-US
From: Maud Spierings <maudspierings@gocontroll.com>
In-Reply-To: <aRclKDeHzfJSzpQ3@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:208:55::41) To AMBPR04MB11741.eurprd04.prod.outlook.com
 (2603:10a6:20b:6f3::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR04MB11741:EE_|AM0PR04MB11968:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb229c8-6be0-4575-c43b-08de2387952e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVlVV1YwMDU3TTA2ZUl3dUI1TEtWbitScDBTTzBJeElZbW80WXBCRUdJK3g2?=
 =?utf-8?B?RWRNWlhiblFjQzRoMXFTdktTcktkeHREUVVER0pNTytmSkpabU1NTURqR1JD?=
 =?utf-8?B?bnNJOVlxZkFzYUlKSFIvTlQ4Z3BZVWNaaG1yNGdidkRkZlNPbGcrSlViSGlM?=
 =?utf-8?B?U2o5UWdCUVFYc2Q1TS9ONEFlaEg4VGZ0c0toR0F5RXZkOWkxMVJjWUZsMWpP?=
 =?utf-8?B?SDlSNWV3eWYyWk1ydnc1UDh4dWRpUjN1ZW1XbGkrQlg4OVBaVXF3OTRJMm9O?=
 =?utf-8?B?M0FESHVSUEhmVzkwQ1QxUUhtOTVwWHlaTld3c1dEN2VSY2hjQmhMVWREZERB?=
 =?utf-8?B?bVIzdzlMRHF0R0hrSVNZbkhSRTg1VVBlcFJBbC9YUFhlVEhsaTNQTEkveUpq?=
 =?utf-8?B?OTVTVFdQS1R3M1lUNksvUE9hZFR3RjhTTjdNclkwUlJvempYL1BwYmJNQ1pG?=
 =?utf-8?B?RTBBaEpaVk5DZmJCNjViekNOVkNFSGZGSEN0b0tIYURuSTZWVGtHQS90Tldn?=
 =?utf-8?B?QVpvVFlhbGRwSGtWMkJha1V5dG1odHZUblArL29MLys5QWI2WDlVZDErZ2xX?=
 =?utf-8?B?bi85ZnRLUU1MMjFWWm1qRHNISlJjaFJTc2tPTi84VVRteU9mTU0vZ3VJWkpS?=
 =?utf-8?B?TTU3VHU2UzZtL2tnQXVnTWJjazNvd0tjTGhCbmJGRWhFU1B4Rko3UU0wU1Na?=
 =?utf-8?B?eTBvMlExT2lhU3hqeDVZc2pqcDBHeFVkWVVDQ0lkZTRFa3Y2Y1JTWXdPMENT?=
 =?utf-8?B?K3VZOGNxamNHbXB3Y0RMQVZ0cmRKWjdScExHQ2xhdTVoSHozU1A3RFlMdVRR?=
 =?utf-8?B?eUU5VVJxZDllbnFMK0VkL0ZtVWRUUjVTSUNaSnZSdnV0cHJoUG9Vem9BTmJG?=
 =?utf-8?B?d0JWM2UrSHd1dEwvTWpROEdpQjAzWDhNcC9Pd2RTbC9hU3N6QXl1NjdKYXF2?=
 =?utf-8?B?UW5XZVlxK0twR0VBV0xxTXhwZ2ZIRFpWUXdjMmxJeXFSbFNpNTZTTm1vUmp4?=
 =?utf-8?B?SmQyYm1QempLVEJaSjEwamdsdXJyL3ZjWjhrZk1POUJER1hYL0diUk5Qbjdt?=
 =?utf-8?B?QnhxRFROcHY3ejY4OXZvTUpnV3F2eC9nN3RDWWoybjRlbEorK285dnUrRllV?=
 =?utf-8?B?TjVpZTBwbEpPK1NtMS9XTExQaTd0S08wVUcvSFlTOThRdElCck00ZG9adjN6?=
 =?utf-8?B?bjl2cUxrbU9VNUNodm92MU9aekt2ejV6RnlQUDNlWDBwdDBoMUN4TXVlZlUv?=
 =?utf-8?B?REFLdVpwWjZIVlA2dVhWZE9OU0ZZdllOd3pvVzUvT1lBSmpDb2psSzBMeTc1?=
 =?utf-8?B?endZeG1GQUtrYmRrUUE4R3dSQ25YT2tVcVVuV0JlUGpJNk1DcXNhOUZqUjZI?=
 =?utf-8?B?SXk0RndCTDNlRC9UTTFReGJXanhSbDNSZkR6UHcrRFJva01aRHpHdnlzSkpk?=
 =?utf-8?B?WDRaSkMzQ3VnVlM3ZzJhcm9ieUtuVW1vaUozWkhYYXBRcWFZVytFTzdscDFH?=
 =?utf-8?B?alovSmtEcndXL3BwakRwRWVHWW5FUjZ1SVFHcUVHcEdwbWlBNVhYeU41TVRL?=
 =?utf-8?B?bUY3Z2Q0cDVsVldwaUk4NDNkMjZrbEVJNFQzK29aVFdZYnBzK1hxSzl1RjFn?=
 =?utf-8?B?SzFueDltUHlQdWtXRjdkM3ZqNE1XSmdQWm0rcjJ4cWpOdU9aU1ZkUkl3T1R0?=
 =?utf-8?B?R1hjRnlMaU5qQlRLL285a1JhTGpJWkNXaHBTSFg3M3hKcGo2QysvaU9iVnRN?=
 =?utf-8?B?WWZYNmFOVmYzcjE1S0hadE5yVzNieDhBdm9nSWRERHhJY3V6MndBb3JtUTcv?=
 =?utf-8?B?dkwzZXRYS0d0UFluWndFZk96dHIxcWtPeWRpOGtLOVNZZk55YWlYVUxOUlFO?=
 =?utf-8?B?aTgzZit1aDBaelVtRTdLSGViVGdaNDA4RzRJeUg1ODZ6d0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB11741.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmJtdnBSVDFUNXJUVnc3dkdFaDJvSktJWkcxcVl5aEkvRWpGd09YY1VmZ3Jw?=
 =?utf-8?B?SlYwTWw3Q2pHUWRpYUx2eTYydDZZdnR4MlV5b2VwMGtNNm5naXVxWDhEMXla?=
 =?utf-8?B?dU0rUzNMb0l6cHQrTW1vV2pmRUZLeVlMMEZlY0c4bUlTZ2ZDcVpwOVlXRlZO?=
 =?utf-8?B?Slh1MXQrZEh6ZE9YdkpoaGZFNE5JQ2lLMzg1ckJjbisyNXZTZHdBQ3JtWG9S?=
 =?utf-8?B?N0Z4dzVFeHF1YkZtS0ZSbmFCbnN4OHo3V2pWbUNFcytBdENMNUpFRitzMzVK?=
 =?utf-8?B?bDJocFQyb3NMNDZEQTBnM0R2aUZBMVZrNVNUTUpkNTd1a1NaZExUak9yRmI3?=
 =?utf-8?B?OHN4MUx4b3BzSC9jZC9xV3B2azVtRFh4cDlLcVhIQkFsdUhtM2R6V1p2eXU2?=
 =?utf-8?B?SjRoR3dqT29ReUdiM3pRODhwTnFFc00rM2t6b21xTkM1UjVhVzRtTUUyNVh4?=
 =?utf-8?B?aHVFSmFmY2dGeHJRdFdYRHh5d2RWZ1V4Wk1TWDhQdVBUUDVtMHRmd1BKVVp0?=
 =?utf-8?B?dDBoUlZTRTlhUkJtYWRmaXJ5Qzl6aUVjNll1MkxIUHlCcmkrK2ltTG1peGFF?=
 =?utf-8?B?RUVRbUJQWjZKMWphZ1MxVi8va00wREdGL0dyemgrS21MeHNORDhrZEFuYmdk?=
 =?utf-8?B?ZnQ5QlptTXpuelg5R1RXYkhmRWxZb3IyUW1rOVo2ZVBZYWEvdnoyaEw5WmEr?=
 =?utf-8?B?dU9lQ3FEdlp3NzUyUTBIWStkbmVMZXRFczkzL3MxdUlsUEtMTERJYmdONGdS?=
 =?utf-8?B?cFJkdTRhT2pPUURuN3RqaU9vYnVZbWFpVFR2M2wvRTU5TlZxdVlTb2YzVmhY?=
 =?utf-8?B?TUM5SUJKWVVKbGN1MU0xRW1ieHk1bXplelNFUFlSQzA0UTJHM1dJdEtaRjlX?=
 =?utf-8?B?eVBWbTBPR3pId0JLUzZoSEc5MzhmdzF5amZ5R2k2N0VXdnNvNnU0cDZOQVJ3?=
 =?utf-8?B?alU0U2ZUeXBPZWNZbmF5aFJRaDV6aVI0V0tCLzNoN2JMaHlOeW8zWng3WlNX?=
 =?utf-8?B?akdwU1ZPWWhFbzY2RG9OWml0dlo5dzZuQ09wZDl6UW9rUEV1dEprUlZqYW1z?=
 =?utf-8?B?UFdoMG5hS0U0RDNpL2kyRUxsMzVFYmw2UzdRWFZrOW5SYlNhbjJza0d5a0Rr?=
 =?utf-8?B?dTdVanpmRnhsN2M1Sy9kbnN6OFhZY3RidmFISE1pM2ZIS29jTXgrWmJRZFVL?=
 =?utf-8?B?dHFWTHhtN0thSFg0T0lka09vbnJQVGZMSTZSc0ZHNml3eVQ2KzVXN0I3Rjl1?=
 =?utf-8?B?NWExc0svcWhrb0pybG9WRVhlVzJpSUROUmRSL0gxd2VEZTNxVTNNd2hSb1U1?=
 =?utf-8?B?Y0dBbFhSUWQrZHZwbEFPdXNXYzFlNEZKSEFKY2xSc1dWcEplTGlGVGNZbGhN?=
 =?utf-8?B?NW5YaENxRlhpM3lobE5Xb2R3eVNuK2k4ODFnWTNON05JQURNbk1CRmlZZ050?=
 =?utf-8?B?eWNONC9yTFplTHpMc0Jlb2hCd3BXb3FhKzVsSmh1WGZHb2tub0VqVkJaNW5F?=
 =?utf-8?B?a01EUjNMeE1xWnptcEJ2am1wUmVZQ2pTRHJWK2M3SGhvQUd2N1dVZ0FmM21E?=
 =?utf-8?B?RktUTDU1U1lFZGtZbWxjZjNXVnZ5aS8rbmNWOExGOWlNZkROaW52d3JEZ1NP?=
 =?utf-8?B?RkE2cFRKMmFiMjhMQWlERnpQczhCMk1DSzZlZGZHdlUvdkZXVkdiUnFONVVM?=
 =?utf-8?B?Qnh2bklleFB4cGVEZmlyZ0VlU3pUVDZ4NDBDYVZEZGNwdU5idmQzQnQ4WE1K?=
 =?utf-8?B?Z2xKU3V3VE5vVFYrQS9ncE1GMFRldnNVL0prRndWdFVNWllvQWdlSjNCTk1V?=
 =?utf-8?B?ZnFUdHQwUDR3YUhwYVl5emxuVjBPaFlnaGFhS0N6YmhVZUwwV1pRT2E3amhw?=
 =?utf-8?B?RkQwUUQ5SFFTWkluYUJDYzNXTFRmQ3JMQjUrdjZmNnZJZWVqRWcvOVUrQy9n?=
 =?utf-8?B?T1BKb1R4R0RZMmRUVUhSVVpYUG9mUC9JM1JhVE0ram9DYzF3bVhibFlmdml1?=
 =?utf-8?B?SlhpUGRwZkZnK2doZXduRzBDNHlXVDZORmdUOFB0NkM4TXgzaW0yL0NlNXdK?=
 =?utf-8?B?c29sVlR0S013b3lPTG8ycjAzdlBPeHJUV1RJNDNlSDIrRkEzTnBub0xxRzRq?=
 =?utf-8?B?YTZUVmQ1STZwTE5MYnh4RVhadEI0Qk1vWFhjZjduWWZmdy9nTkpjZzVoMmRW?=
 =?utf-8?B?RHJMY1BRb2FWK2k4aVZTc0dEMnFSQTk5QXFZdnFHUHd1anFiWHcveTFDRmlH?=
 =?utf-8?B?SUl0b3ZHbHMwVGg5K1VQYWFPSXpBPT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb229c8-6be0-4575-c43b-08de2387952e
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB11741.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 14:10:36.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2juVQo+ZBstHczgwEoH0uEXFhrCNqMMu5ovcJe4XyLEy4uVADX9ke1smQ4mSIkAbgroHAVxNMHfsbtOD/KgPA+wjwxf6KNI1QC3y/t8tBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11968

Hi Russel,

Thanks for the response!

On 11/14/25 13:48, Russell King (Oracle) wrote:
> On Fri, Nov 14, 2025 at 12:39:32PM +0100, Maud Spierings via B4 Relay wrote:
>> From: Maud Spierings <maudspierings@gocontroll.com>
>>
>> The doc states that the clock values also apply to the rmii mode,
>> "as the clock rates are identical". But as far as I can find the
>> clock rate for rmii is 50M at both 10 and 100 mbits/s [1].
> 
> RGMII uses 2.5MHz, 25MHz and 125MHz (ddr) for its RXC and TXC.
> 
> RMII uses 50MHz for the reference clock. The stmmac RMII block requires
> a 50MHz clock for clk_rmii_i. However, the transmit (clk_tx_i) and
> receive (clk_rx_i) clocks are required to be /2 or /20 depending on the
> speed, making the 2.5MHz or 25MHz, as these clocks control data paths
> that have four lanes whereas the external RMII interface is two lanes.
> 
> MII uses a 4 lanes, has TX_CLK and RX_CLK which are required to be
> 2.5MHz for 10M and 25MHz for 100M.
> 
> So yes, for RMII the comment is a little misleading. Maybe it should
> state that it can be used for 4-lane data paths for 10M, 100M and 1G.
> 
>> Link: https://en.wikipedia.org/wiki/Media-independent_interface [1]
>>
>> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
>> ---
>> This patch is also part question, I am working on an imx8mp based device
>> with the dwmac-imx driver. In imx_dwmac_set_clk_tx_rate() and
>> imx_dwmac_fix_speed() both rmii and mii are excluded from setting the
>> clock rate with this function.
>>
>> But from what I can read only rmii should be excluded, I am not very
>> knowledgable with regards to networkinging stuff so my info is
>> coming from wikipedia.
> 
> It depends how iMX8MP wires up the clocks. From what I see in DT:
> 
>                                  clocks = <&clk IMX8MP_CLK_ENET_QOS_ROOT>,
>                                           <&clk IMX8MP_CLK_QOS_ENET_ROOT>,
>                                           <&clk IMX8MP_CLK_ENET_QOS_TIMER>,
>                                           <&clk IMX8MP_CLK_ENET_QOS>;
>                                  clock-names = "stmmaceth", "pclk", "ptp_ref", "tx";
> 
>  From include/dt-bindings/clock/imx8mp-clock.h:
> #define IMX8MP_CLK_ENET_QOS           129
> #define IMX8MP_CLK_ENET_QOS_TIMER     130
> #define IMX8MP_CLK_QOS_ENET_ROOT      225
> #define IMX8MP_CLK_ENET_QOS_ROOT      237
> 
>  From drivers/clk/imx/clk-imx8mp.c:
> IMX8MP_CLK_ENET_QOS is controlled by ccm_base + 0xa880
> IMX8MP_CLK_ENET_QOS_TIMER ... ccm_base + 0xa900
> IMX8MP_CLK_ENET_QOS_ROOT ... ccm_base + 0x43b0
> IMX8MP_CLK_QOS_ENET_ROOT ... ccm_base + 0x42e0
> 
> Referring to the iMX8MP documentation:
> IMX8MP_CLK_ENET_QOS is root clock slice 81, and is known as
> ENET_QOS_CLK_ROOT in the documentation.
> IMX8MP_CLK_ENET_QOS_TIMER is root clock slice 82, and is known as
> ENET_QOS_TIMER_CLK_ROOT in the documentation.
> IMX8MP_CLK_ENET_QOS_ROOT is CCM_CCGR59 and is known as ENET_QoS in the
> documentation.
> IMX8MP_CLK_QOS_ENET_ROOT is CCM_CCGR46 and is known as QoS_ENET in the
> documentation.
> 
> So, we end up with this mapping:
> 
> driver:			iMX8MP:
> stmmaceth		ENET_QoS
> pclk			QoS_ENET
> ptp_ref			ENET_QOS_TIMER_CLK_ROOT
> tx			ENET_QOS_CLK_ROOT
> 
> Now, looking at table 5-2, CCM_CCGR59 affects five clocks provided to
> the QOS:
> 
> enet_qos.aclk_i - derived from ENET_AXI_CLK_ROOT, this is the dwmac
> application clock for AXI buses.
> enet_qos.clk_csr_i - derived from ENET_AXI_CLK_ROOT, this is the dwmac
> CSR (for registers).
> enet_qos.clk_ptp_ref_i - derived from ENET_QOS_TIMER_CLK_ROOT, this
> clocks the PTP section of dwmac.
> enet_qos_mem.mem_clk and enet_qos_mem.clk_ptp_ref_i - I'm guessing
> are to do with the memory that's provided to dwmac.
> 
> For CCM_CCGR46, no useful information is given in the iMX8MP
> documentation in terms of what it corresponds to with the dwmac.
> 
> Looking at AN14149, this also doesn't give much information on the
> RGMII clock setup, and claims that RGMII requires a 125MHz clock.
> While true for 1G, it isn't true for slower speeds, so I'm not sure
> what's going on there.
> 
> For RMII, we get a bit more information, and figure 1 in this
> document suggests that the 50MHz RMII clock comes from slice 81, aka
> IMX8MP_CLK_ENET_QOS, and "tx" in DT. This uses the ENET_TD2 for the
> clock, which states ENET_QOS_INPUT=ENET_QOS_TX_CLK,
> OUTPUT=CCM_ENET_QOS_REF_CLK_ROOT.
> 
> This doesn't make sense - as I state, dwmac requires a 2.5MHz or 25MHz
> clock for clk_tx_i in RMII mode, but if ENET_TD2 is RMII refclk, it
> can't be fed back to clk_tx_i without going through a /2 or /20
> divider, controlled by signals output from the dwmac depending on the
> speed.
> 
> So... not sure what should be going on in the iMX glue driver for
> this clock, how it corresponds with clk_tx_i for the various
> interface modes.
> 
> However, I think calling the slice 81 clock "tx" in DT is very
> misleading.
> 
> Maybe someone can shed some light.
> 

maybe for some extra info, the device is the imx8mp-tx8p-ml81.dtsi som:

&eqos {
	assigned-clocks = <&clk IMX8MP_CLK_ENET_AXI>,
			  <&clk IMX8MP_CLK_ENET_QOS_TIMER>,
			  <&clk IMX8MP_CLK_ENET_QOS>;
	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>,
				 <&clk IMX8MP_SYS_PLL2_100M>,
				 <&clk IMX8MP_SYS_PLL2_50M>;
	assigned-clock-rates = <266000000>, <100000000>, <50000000>;
	phy-handle = <&ethphy0>; //smsc-lan8710a
	phy-mode = "rmii";
	pinctrl-0 = <&pinctrl_eqos>;
	pinctrl-1 = <&pinctrl_eqos_sleep>;
	pinctrl-names = "default", "sleep";
	status = "okay";
};

pinctrl_eqos: eqosgrp {
	fsl,pins = <
		MX8MP_IOMUXC_ENET_TD2__CCM_ENET_QOS_CLOCK_GENERATE_REF_CLK
			(MX8MP_DSE_X4 | MX8MP_PULL_UP | MX8MP_PULL_ENABLE | MX8MP_SION)
		MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC
			(MX8MP_DSE_X4 | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
		MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO
			(MX8MP_DSE_X4 | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
		MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0
			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST)
		MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1
			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST)
		MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0
			(MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
		MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1
			(MX8MP_FSEL_FAST | MX8MP_PULL_UP | MX8MP_PULL_ENABLE)
		MX8MP_IOMUXC_ENET_RXC__ENET_QOS_RX_ER
			(MX8MP_FSEL_FAST | MX8MP_PULL_ENABLE)
		MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL
			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST | MX8MP_PULL_ENABLE)
		MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL
			(MX8MP_DSE_X6 | MX8MP_FSEL_FAST)
	>;
};

Kind regards,
Maud

