Return-Path: <netdev+bounces-203718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC45AF6E1B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276BF168582
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E11D2D3EE0;
	Thu,  3 Jul 2025 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="GLcVjK03"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A212D0292;
	Thu,  3 Jul 2025 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533407; cv=fail; b=d4L6a8xsy5E0U8Talovvq+1Q6rim8Ix4KFek73kGMV7OzCLHp95ytMmA9T28PSkSmZzbYrJ7U3ozbs5Lv/kUNZo+C+jQUahewB0l9hN1E4pNsepFntyHxblx4FxyANk5y30lagOt8CaOTjzZP77DL4KTzy0PUfW7liBv8UgKvTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533407; c=relaxed/simple;
	bh=2Lvgq3Z1JfjU7OvFaBr/LvJmQym7bSI9R5ChhpCTUI0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UATPwr59A8gweG54MqXQ6xnp8U2Jh39diangUoujFpK12OlWpmlCflnO+UDHK3Y6gxQaTKJppu5reG6PZhk8fGt7FejGqxmDfYIifjBxSWvl2+wIYxOgrrDhjDEt2SiGepWFQ8rCisstZYwFGolQod91IU8rAoRB82J7WFrs4Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=GLcVjK03; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlndMz+XxT81PB+5/ytjnsMN7aOFxvtfidRTyiKuvkUc5/t1PDUyxarkaWjSlg+66Wc3oGRwe24bz3Gsc4bvxe5+s1ug6FHtOxDD0ugYRe0yktX3wAFE4ytYfFrh6eLLBbf+CrwFglTVN6Lr/ARxIT5oEqwVb1qjGksnNanapzWMzJeihXxmsSbo3Vs+vt4+VThyf9QiR7CiYHxU1r+umL8GH7CUJESA7dYRdDn9m/2gcnkSlBIIgbkvvFeF1XR8Vn6lX0be0M+rtH1WoLfnHn5Fo0ld/Ca6bigC0gunChyW/Y4XEEWyN5EiQxG/xGkzKRIaXDQDQ5+3pabhyFSa+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTc6dYZfv5bOCKq2J8g+JD6WDTyrCZ3ifvXCDz7GIQY=;
 b=UdFnKL+zR/hgQcJOtSx2uGrANdl9OrvXvMQiudYrC/Vb774PuO9ShgGFHkVaCJ/pd3mzAQU/RzQ6kKahkeu3Hq/7BjVc4EcqmOjYOrxDqGaF2K7IBNAQ5xZNF+SnngBPdQTfMzWfRZbhg2e9UXqYR50NPX8wuEEBIluUSnHXFmJD//Q6VPZWnLARWhqUWa7f2RizwXpsINSxxxI7tYerd8EHkrSY1cQXiOpjSK7ZKmrVhOuQbwuH6ECJmnBt9udKyUTaFABN6qkDdAi/3OeCx49D9pm8Vpkxro7KiFUOdVfHUfWyzG6+fywaryLbDwTPPuVJk7yyPXOKjkFLw4qH3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTc6dYZfv5bOCKq2J8g+JD6WDTyrCZ3ifvXCDz7GIQY=;
 b=GLcVjK03ZiyHHqMqgT9pETNNvC7WvhjvzK7TJ86z6YQ1yEFRcOkD76tuM2oWhdg3TquZ00eafstLH6iCZ3StOF0pE9w1EUYqU0U96mzrfVkFPk3eTsTeFJ/UcJi+vUqOkqw1KeHKcxUXNgSx9CTXp9F0LzfbPKxGR6GCQedKY6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by AS8PR02MB9718.eurprd02.prod.outlook.com (2603:10a6:20b:5ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 09:03:21 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%4]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 09:03:21 +0000
Message-ID: <b89e3a66-3c98-45b3-9f16-8247ac1dc1f4@axis.com>
Date: Thu, 3 Jul 2025 11:03:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 0/4] net: phy: bcm54811: Fix the PHY initialization
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, andrew+netdev@lunn.ch,
 horms@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
References: <20250701075015.2601518-1-kamilh@axis.com>
 <20250702150216.2a5410b3@kernel.org>
 <da323894-7256-493d-a601-fe0b0e623b00@broadcom.com>
Content-Language: en-US
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
In-Reply-To: <da323894-7256-493d-a601-fe0b0e623b00@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|AS8PR02MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: d48e6132-d838-4a99-1398-08ddba107570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWNPVkVhZTlwZ1lXNE9TcmRVb2lRNHRaMU45RGZLRUZXWUUyNnZ6T25sVHRP?=
 =?utf-8?B?R3c1azQ2ZFk0bjloNktyM3dEY2I0bmpZODJ6ZWI4Y1RQTEZ5UkEyeWNPV2hX?=
 =?utf-8?B?RTVRa0RPdXhGb29DWXhTeDFsSkxxeEM2OXVqWFZIQzRzWnRIRE1GekZhVTFx?=
 =?utf-8?B?UjcxbFNpUnVBRGNrQy9qUnByZC9iYjZCckcrSnpOMkFWWnF5dkN1Tm9zc3Ba?=
 =?utf-8?B?NE5ObDB2RmZCR3JnTGlDTUo0R1BPWnVXRGI4bXp0R3F1Umw5S29EWThMM2tQ?=
 =?utf-8?B?T0xTL3gwY3NOOUJIRy9lODBWblNueWpQV3JjenlLZXE1K2UzSFJrZSthNng0?=
 =?utf-8?B?NkpKbHRzR1BVU3BOcHhHSzhyUmI0d3ZtUTJxaDlXZXk5ek9nQW1OR25WalFm?=
 =?utf-8?B?Vk5EMTh2aGwwc0l0eXNpYnQyWC9FWGJ0clZUaVB2dGlEdTFGQlpuRTZWRHFH?=
 =?utf-8?B?RnR1WkJIWkdtR3hUZFJocVh5b1p0Ujc1RDFoZW9rZWdURGcvZUpZcnBDSWZx?=
 =?utf-8?B?WGQ0dGU4T2twNTQ5Z0pnRjQzeXVmTS9VT0F0VEphOTltV3hWeDNhdkZRc3h3?=
 =?utf-8?B?SlpjSFJsVU9aemVqTWN3M0lPRHg2cVlDa2pMYmNsYythbWNmYzViSy9YZk13?=
 =?utf-8?B?eE0rRW4vdjZocENRUmd4SVd6clJpTys0UTIyZTI4blhENnBMSDlDZm1zNmNl?=
 =?utf-8?B?TU5SYkFwTGZoMDZRNnZFb2E3SFJHNEQ5YkhRK0Z3QW9WVGhDUGpTd1FONmk5?=
 =?utf-8?B?YkZZS2ZraGdkWGdnUVE0Ny9wNlBuYnFWSzRNQVpWdnAwaVJCb0pVSzdMN2dD?=
 =?utf-8?B?UWxteUF0R0xXTXBlR0VKYlJncmJuWit2bTFuM01YNjRMVGQ1QlhCWU95U3cz?=
 =?utf-8?B?YmgxMzJoMC9iTXJPb09paUVPY2s1UCsxOTBmcXRYdVNUbGZlZTkwV0tmdFBM?=
 =?utf-8?B?RnNaR0R1MXZhNWRVN0dac3Mwa3BzV29ZRDFzaG5vRnBkdEJSbVNWcDY0d2kz?=
 =?utf-8?B?TXdyc2NlWW1OQThScjNIUnBJOXpMbkYxTVdxZlRaTmhVMTZXdGc2Wk11eXJN?=
 =?utf-8?B?bFo2eEJCOXlLSlZIbXV3RnpQZEFuTnJacHh2TFZKcW9nVTlSY2ZRZG95Sy9K?=
 =?utf-8?B?NW1BWHh0VldheDdWb1Y2RDBxOFhyaXVFL2ZkT2xtK2grdFo3bGxCQUJwNW1s?=
 =?utf-8?B?SmF3VkFVc21PQW4yaTRydjQzNWJoN3YrWGJkZTVNWmoraDVKR29kNmhGT2Ri?=
 =?utf-8?B?cHRFYkUrTVVmZEhOdTdkK2pDNzRqSzBqV2pkR1I1NEtKbktsUjdkcUFtZUND?=
 =?utf-8?B?TnVVS0U0Q1doWFlxMGJmL0pVczRHNUNQdHVaOXJXQk10U3JaTUNUMHRjTWs2?=
 =?utf-8?B?QUx2YzdkOEtsSndQOHJLMi9BVUxyL28zaHQ1eWRMcUR5SHpJdnF5N2V2WXZS?=
 =?utf-8?B?MTZERW5URkpGaDlOVndsTi83cWgxM0FzWGY0SlRueHJXUTRMVTNFMmJpZUJ4?=
 =?utf-8?B?M3lLdnFNTTRKQTFQZHZmam11U051Sk1oM3pzK1VyU0ROT0UrS084MkhSc3gx?=
 =?utf-8?B?YnQ5eXAwV0dQL2N3M0VkS0RMdVZheWxleXlSQXJUc1ZSQU1kSU4yengrVHVI?=
 =?utf-8?B?SkxRMVR5b1NCcGlZcXlna2Mzb1lESGM4N0xQeDMvYWNMZFpEUXMreHFobVFD?=
 =?utf-8?B?TmkrdW5TSlV0YjkvajRoQjc0eVVwQmFJS045OWY1US9kWnBWL2pzbEhhRUwy?=
 =?utf-8?B?ZmFDc3lSNFZVTFRjM3FSUnhrSlNDQVJ4ZTlZTnIzOXNQNDNNQi9JQjRzTGZC?=
 =?utf-8?B?eHRtSVdjSjM0WDNsY0UxVWp1TFZ5WCtwQWJCZUhPaU9lbU8vOEVCbU1INFpS?=
 =?utf-8?B?cEIySjBtZnRBSG43VUgzbG84WVRjWTVFdFJRRUlHSDNObUxwVmxOU21qLzIy?=
 =?utf-8?Q?k/6Iim6gSGg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2F5L1luaVV3ME44V3kwWktwSkN4VzZ3S2hYM0lMU3c1RkJqSXIxbzY1V0Yx?=
 =?utf-8?B?bGw0R3V0dFV1NHBvMS9ESWlJVi9RZnhxNjlwVUkxTVUxbVRWTElUcGxoQis2?=
 =?utf-8?B?aDJjVGFaR254TlRxUTMzNVhmZjhyaHR1dXJmb3RMTXFRN01GZ1QvbVkrS05H?=
 =?utf-8?B?cEplNFNJY2tPdnBxZDdmNkJJSlBYazJ2bXpCUHRYdFRqdWgzSXl0K3NnL0tp?=
 =?utf-8?B?QnJIcitKR1BTREtndExtQStoaXZWajV0NlBtaUQyWWlVRXFmdWg2YjlYQ1Nz?=
 =?utf-8?B?emFIN21NUG9jbkpycEQ0RTI1TEtPSUJaV1BnQmhPb1oySFppWkkzVGZtQVVr?=
 =?utf-8?B?OWNUN3NteEdpUEMwaE9MNUo1dDdWd1NHWkc5THl0b1lLYU40UElYRm5Qekw5?=
 =?utf-8?B?Um9tZDEwUFQ4N1h5TzZINXVRdmJ1VEtjWERsUmNnS2luYkRlNUVRYWlHTWtE?=
 =?utf-8?B?QjhLY1ZUR2dOOHcxTkpWU0FjWFdSZWtkckYvWjZqbDBqbUhUWUZWYlE2czNQ?=
 =?utf-8?B?ZTU0UFcvcWN5QllqTzBiNVZYYVo2SVdBc2pKTk9USDdQNFZ2VFQzcWdoWUdi?=
 =?utf-8?B?bko1Y1lTNjlEVFZXanJiL1JwUG96KzVNOVd2N0g0L3FUQ0VBekZ0dWFVL3Jm?=
 =?utf-8?B?SzU5aUo0NWMyZks1RGVKRHMzUjVMOUhQMklpbzdnM0UxMzNlVm56Nm8zK2tx?=
 =?utf-8?B?dHhhLytuTnlVUVEyTE53RjFORHkrT3BJcE42YXN0RGUrV2ZKN3lycDREVVlP?=
 =?utf-8?B?MWVwNmZVR1ZGN0VrdFZhb01xTmtMdmV2bUp3WmwyL200UytzNS9lUlFGR3RD?=
 =?utf-8?B?ZEM5dWV6OTlpeGlQZWhTMzlMYnBLVi8ySGM2cDZ6N2swTE1MRmpSNThTM2d3?=
 =?utf-8?B?aTJwb2lndEtjam12TWFMQ2haSTgvWmQ5WTlKeDEvUHVjZGRFeXpqb21qcFF5?=
 =?utf-8?B?c0ZveDV0OUd2WVZvc1J1Q0haQU5aTk91VTc3alhNV1BqeStYVWQrWWtDb2Ru?=
 =?utf-8?B?T1IxODFkT3IrQTdKbEUvZXdWOVEwcjRFTlBoV21qK0hXYytjd1J4bjUwNEp2?=
 =?utf-8?B?WExra2s4SVpMcGJLd3BMcnJVYWU4Ny9SdS9ZV1ozM1l4Q3g4ZDBqWDVuY3Q2?=
 =?utf-8?B?QkJmRHZEYUpZVlhNK1YzeFdJTTh0RGNCNzRsR0tmWFN2MnVTRU1nSDFTSkNn?=
 =?utf-8?B?alVPekZOQzBrdXBuY0VkanlXejhBNUZFYkhkMFVNNmNZRElzLzcwMWoxNmNk?=
 =?utf-8?B?QVlaUzA2c3V6dTB4dkFXN1lJRUpqelpLLzNLYStVOFl3RXNxRDByS2FTeWt6?=
 =?utf-8?B?RlJlWStKWFhhdC9oTUNlaC9RdVZMYjJTT244VmpZaEdWZE84VkR1eUtpaFQz?=
 =?utf-8?B?S0NoTU9hZlkxWmVMZ3E5SGpBSGhoWmN3V0lkai9HYVBCc2l5SmF5VFQ1TkNQ?=
 =?utf-8?B?cyt1UGZXakVIbW5MQUVaUSs0T0hNdUhFNmVrTUJNRmFZRWtZbmpmTmU1b2tU?=
 =?utf-8?B?SUVjc1p4VmNwSld5ZnFKZHZCR3pMa1NMQXBCRGZBU3BvQkpWV01Hdy9UUzY0?=
 =?utf-8?B?RnJuVnUvQ05JSUxtZHhodFhWVXZzeVYyUWlLS0lFVWhoTjZRTERpVzdSUTEv?=
 =?utf-8?B?U0QzN20zMi9HbGkwZjdrRHVaaVNYb1VrSXZrUTRJbm5oajhtQURua29PdmhV?=
 =?utf-8?B?YmhJYjZ0SEczc2NlUDdpNndpNmt1V3FRZjh2ZTV3QXhwWFZLMm16c2NIUkxF?=
 =?utf-8?B?eHQyM29sWjBBci9KVmQwZy9xZ2ZPUTI3emVnVk0wWHpyc1BzRjFIMTF2UkdU?=
 =?utf-8?B?N1FyWlhCR3V0bnN2UEtsa3grRGFEWHJid2t2WTJLOTF0OEkvbzREMWRXYy9x?=
 =?utf-8?B?SlZuNFpEYWlzVFhocjVhZzJVaWNDUnVDVm9iUEt6N1c3TUN6cm9WRVVPdlI3?=
 =?utf-8?B?M0N4T09BbnlUeXI5THJRaWNKck5JUXpOVE9za3RGQVplMThaWEt1NFpiNFJv?=
 =?utf-8?B?YWxuZzV2cmxsM00wazljNGk0bjNEdGhrWnI2cHJEb0tPTnMrVXoza0xVcE44?=
 =?utf-8?B?ME1ibVVFSUhVSXBRVjBFcFQwN1J2c2NsWlNSZkdhcFZtclJKcTFVc0ZyMDlC?=
 =?utf-8?Q?Bc/ACUD2r7jFV3OOsncxc36cp?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48e6132-d838-4a99-1398-08ddba107570
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 09:03:21.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riy108vEewAMDR2YrvV25GyOwnPMUkCfF/8q1aX1ylElcDI2vVY6pEWjnmBItA7V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9718



On 7/3/25 01:46, Florian Fainelli wrote:
> On 7/2/25 15:02, Jakub Kicinski wrote:
>> On Tue, 1 Jul 2025 09:50:11 +0200 Kamil Horák - 2N wrote:
>>> PATCH 1 - Add MII-Lite PHY interface mode as defined by Broadcom for
>>>     their two-wire PHYs. It can be used with most Ethernet controllers
>>>     under certain limitations (no half-duplex link modes etc.).
>>>
>>> PATCH 2 - Add MII-Lite PHY interface type
>>>
>>> PATCH 3 - Activation of MII-Lite interface mode on Broadcom bcm5481x
>>>     PHYs
>>>
>>> PATCH 4 - Fix the BCM54811 PHY initialization so that it conforms
>>>     to the datasheet regarding a reserved bit in the LRE Control
>>>     register, which must be written to zero after every device reset.
>>>     Also fix the LRE Status register reading, there is another bit to
>>>     be ignored on bcm54811.
>>
>> I'm a bit lost why the first 3 patches are included in a series for net.
>> My naive reading is we didn't support this extra mode, now we do,
>> which sounds like a new feature.. Patch 4, sure, but the dependency
>> is not obvious.
> 
> I don't see the dependency either, at least not in an explicit way. 
> Kamil, could patch #4 stand on its own and routed through "net" while 
> patches 1-3 are routed through "net-next"?
It can be done this way, however, even the patch #3 is effectively a 
fix, not new feature, because the bcm54811 PHY in MLP package only has 
MII-Lite interface available externally. As far I know, there is no BGA 
casing available for bcm54811 (unlike bcm54810, that one having both MLP 
and BGA). Thus, it cannot function without being switched to MII-Lite 
mode. The introduction of MII-Lite itself is clearly a new feature and 
it is even (theoretically) available for any MII-capable PHY. So if 
putting it all to net it is really impossible or contrary to the 
net-next vs. net selection rules, let's divide it....
To get fully functional, bcm54811-based networking, all patches are 
necessary so any other user out there must wait for both branches to join.

> 
> Thanks


Kamil

