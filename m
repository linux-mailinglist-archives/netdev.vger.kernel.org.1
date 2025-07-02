Return-Path: <netdev+bounces-203420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A377AF5E01
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785E73A89B9
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A430A27FD45;
	Wed,  2 Jul 2025 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="klWNKz8b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BCA246791;
	Wed,  2 Jul 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472269; cv=fail; b=GnW4Eom0PQGOSqdyGC9duwRAt4V+Nicw7LJVpg864kh1i3acCQ5+AtDsOfdNDjahP5YzT+iE6eWhGIicKrb0cQMNSW7xg011B/M7xu8VCAtK+iYEL3RXOSa5UkF6wJwrpaib7EnNPU4bBZ4atZGNqEHfmFF3YGVfVysU0PxDSpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472269; c=relaxed/simple;
	bh=DB8oVErbItEUWiQpKMRkutozb79NVrAnMlB9jWDk12c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tpvaZ9u/b4mChXjo+JU1jBo7Nr8PYy27SkbXP3M2Qv8GV0DtrocU94Yqu1gouHpymj4A9oujkEtHQD1K4tQVAU6D74TgRbJrne7+h9uyvd3d3s6rvwGJB3NVLaL0tnAxzHms3ahS1pTqkGuXJtVhc41CfqNgPsZKmau7dlGsXGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=klWNKz8b; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZbKcnAyL/OFMPeDv7LXTvEOqKBmONN7m6rKFEQHzrm3VPZVe0CQU9h7EQ+MmbuTcYB2/Kfkc6xFE6dG9cK0nf77aUeojKKZNNnVcGdDs/W/GorNBNo9E+kkREC7Vo07EoP7D6Sf/1U7KKzzjb5e9tXRhkCxrF50opy+tQta76zLGDsB+C0QSZP/4LVAkjeW6tk4LVQ2ATAHr2cSMZq+F+VWzOnoWa9pF/Ny3Rdj6n97CfKeTYsB6M7N8BpD8Z0DbyXKtvuwAVle4GgiC1cA8PNzS5utT3lRww3tqkuPwUDCn787Q6ZVJeNwHo3DpOA8ASXPEgn601rDgnmNoNmiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBEZNYrp7gyT3PCaR03zbL8nH9dQuagzH5B7V2oxFy8=;
 b=ZrYDTJEJj0nWYupGpo7EeDj0AwTuJFCifzVE4idkeZD68QZizzf1/pdM8UcIyvZkhOgbWjreGDtLCBPl6UQPZAKsIkW59R8EkTWddrs0VPT8BO3PXp1Xu+FBnOm5I77VovqmqaRuOU43C9TcpRDGhjvrFoCLxI0C2EP3sOVb2JspVp8tpsjmSQDX+4iVCqu/PC5U6D97O6Aazjkb4HX6zqiDUK4QVBW0AZPUejutC3tTnjZJzF17VQabLB+0O0nwFQyN7T729CXBMa1ce1RS+uEp21OrwT1HXizUS8PqYQBxedvC0fR8x0TWVrTlIl45KwzyHXMJ5pA265Pg0E4HJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBEZNYrp7gyT3PCaR03zbL8nH9dQuagzH5B7V2oxFy8=;
 b=klWNKz8bsCpwn35h10VmiJPzvhydh/2jdEaaqmg5YLPhV/UdobYfaTqcM2HXk1/lzHpHb2GY3ekAVLB9trcWDHC1iWh0DZ7p0mOG6fNMZ/xgaTwCMv4PA+jaY7WCITgRfXU1s2ASDGu//nL+uiuvcZ2+6w29+LB3v8xO1Qe7SUPpCaV6bXsc5nPDov1JKHqIEChNUiVRcU/JfpPiGNyn4OEwx5ahjFh99OgflZnRlxMCwGVJ1etz8OGvZf3bL+W62Jry6STzad1LSz80PGK51hh6dpgPx9lsc7FE2+rkh3WVwSa0IEeXvXuTm7Xf5642u1bKLXRRaWrCXQLvm1YWAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by PH8PR03MB7306.namprd03.prod.outlook.com (2603:10b6:510:252::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Wed, 2 Jul
 2025 16:04:23 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 16:04:22 +0000
Message-ID: <7dd9bca2-6c09-4067-b3f8-9bdc10dea39f@altera.com>
Date: Wed, 2 Jul 2025 09:04:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] clk: socfpga: agilex: add support for the Intel
 Agilex5
To: Stephen Boyd <sboyd@kernel.org>, dinguyen@kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 mturquette@baylibre.com, netdev@vger.kernel.org, richardcochran@gmail.com
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
 Teh Wen Ping <wen.ping.teh@intel.com>
References: <20250513234837.2859-1-matthew.gerlach@altera.com>
 <175133195554.4372.1414444579635929023@lazor>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <175133195554.4372.1414444579635929023@lazor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0014.namprd22.prod.outlook.com
 (2603:10b6:208:238::19) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|PH8PR03MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cedf852-9148-4528-4a9a-08ddb9821ba5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzZjTHRTU2xNZDRQUlQ5S002aE5sUUVJenQ5UHFRMG1LZytCMko1a0JqN1B2?=
 =?utf-8?B?THhIY0VmenovbDZOaG5ucXRFRFZOQ2I1ejlqalNaaWtyMkYyeDZyUU95N1Y4?=
 =?utf-8?B?b1lYMFNSQ2hqcGV2ZS8wR3g0bTdDVFgyNUw1NENHQU1hZGpUUEg2YjI5ZVV4?=
 =?utf-8?B?YUkxUnVVajdjaWdjREVDbTg2U280ZmtKd0k2bDhrZkpETW9mK243M3YwbTF5?=
 =?utf-8?B?RkxaOElXSU9lVFdmYUpQaUtpSkhEenl1amxkNGtwNG4yeVpuTks2UmZQZUZ5?=
 =?utf-8?B?cjM0eDA4WkdEaXBXL0RTYS82dlpZL2tKUHJKWDJXTEYvRTJjTlN1NFNobGFV?=
 =?utf-8?B?RlNtdXhWaTJJS2RmRElYOEJpYTJRQ1NOWnNXQnBSR0E5VnZlUDNvZWhKRm5G?=
 =?utf-8?B?NVFKcHhtYXlmWTFtUHBBTVJNa0o1K0FsOGRZUlptQVc1RkVnSUJqdjdmUy9R?=
 =?utf-8?B?N3l0QkF4K1JPRmFDaHZaZVJSaktFUitWd2k5dXMyUUVHZFNWMjY1K1pUektE?=
 =?utf-8?B?bGNJYm9NMDRuRkd0OGVNbExkcjBVNHM0Ynp6OVZlczZwbW12VWdkb3ArS2sv?=
 =?utf-8?B?YTQramhaT0RjQ3ZsZ2FscXNQY1d2cWthbnVJWnBnWVhDaHFHbXY1T1V0L1ls?=
 =?utf-8?B?dnp6Z1NPandVWTFGeWxLcTJXeVd3K0h3bm5VWVY1dW5tdE1jdU5FOFBsL1NN?=
 =?utf-8?B?dzZnalQrRmpkdDJ6YlpNQ1YySW9sZ1hTR0pONVFuZFRMU053SkhrSUxaNThX?=
 =?utf-8?B?dFBuTkkxeHBSVkJqVXloc3JNVlQ2TE5lbkdEMy83NkRWVnpmODhnOGJyUm9L?=
 =?utf-8?B?M1dIaDIvdC9YL3lBNFVpbjFHTFVndlQ4RS8rYk9MaERaTmZUcjJVMk9uYk1L?=
 =?utf-8?B?S2Mxb0szRURjdEM1SDQ1Vk5YdHBUM3V1WjlkMVZFTXVMQUcvazR3ejlDOHBq?=
 =?utf-8?B?V0Y0NHVHTnk1WDVTZzcwSjBlMXRQODdnREE0R1ZWTC84MzNRSFUwY0hqTk8r?=
 =?utf-8?B?MHh3OHQ3SW85ejNBQnF5SEVMeUo1SlliOEFlTDFBTXpjSlk5cWNiWjBZUlBS?=
 =?utf-8?B?OTZJWnpFWHdFMVdpQ01HQzB2bXcxb0VzV1hxLzNvM0lCTldlZVptZTBmajU3?=
 =?utf-8?B?RnRLQTVhcHhPRmNyc2l2LzRtZHg1MVRxRUNmS2JZV1N6T2RaY21jdUpjbXZT?=
 =?utf-8?B?ZUcreHoreXNmUWc5Zng5YWtOTHkyNk5kRWMvdHIrcURzcm9pY1dZZXlDdXk4?=
 =?utf-8?B?c1FzdUx6aDNXMjZBK1U4Z0NzRGhpT2hENGlSems3RTEwODNIdHBNQUltZ09F?=
 =?utf-8?B?V2Z0SUIvWGRxZWN5Vmt2OXVVWll3S2h4WllneTRHQ0M3cWdsWGdkV01RMjEz?=
 =?utf-8?B?ODlyQkx4Z0RaRmx6VnRtTDg5S1k2RXVaQy9oUnNld24vZ2I2bzhzNER4TVF5?=
 =?utf-8?B?VDFUQ3RoR05pcVp2YkFqYnVxeWJkTC9CbmhXVHl4UGFXRnE0OHllTnA1VnRD?=
 =?utf-8?B?NXBibWdCSTl6M3dBNzBsTmFFMzhvdTNlQUFmN1VqUldVeGZmWmRlMjlxaDV5?=
 =?utf-8?B?dllpaG1BQ2VWeE9PbElwc2lCUzhrV1FxMXJCOVMrRmdMWCtSYW1BeEhjV1cv?=
 =?utf-8?B?Sk9kQ00xYlpnM3pjOGZxckdLRFNPK204YklqRkgzcUh0OHdCZzh1c0kreW0y?=
 =?utf-8?B?WmpTYnZFa0JSdFNLVmZGc1Z1bVJMc0diNGZyYmhYaTllWk5WeiswcElZMWNj?=
 =?utf-8?B?QlBlRGNJM3lZVjR1MmVHbmhWaG8zbFVTdHZDSnprelhEeXRxeWJ4NDdZU1c0?=
 =?utf-8?B?MW9JNzdhWGZFVCtIZnRZZWdteTQ3QytyNHFEVzcyQythaDVEWm45dm9jUXVD?=
 =?utf-8?B?VU1KeGJCbUIwMDIvdXpPWkwrZmhQUWlrZVdWK2NqdE9WeVFoRjgwTzFYcDB6?=
 =?utf-8?Q?JosT9/FcbNI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm9tMGtvTUNPSmg0K0pvSHVzczZtaEVoU1hwcXZUTk5JRnVib2d3UU5MK05L?=
 =?utf-8?B?S05ETDdYcktCVTNjQlcweXlLSUJQWlhQYjFOYkc5MENYVnIxbzl3cGlIQm5o?=
 =?utf-8?B?eWRDNU53aFJQSWU1N1JXUThJb0ppVXA2a2QzUERnc0Y0Z0d6Q2d2OXU3SU1G?=
 =?utf-8?B?L0ZzcGZlQ1JxRFZpdU5EUU9pTDI3SmNJMmZVUFcyNFBiVUtnK2lrT3I5ZXBZ?=
 =?utf-8?B?QnREbkpUWDliZEx1TTZFL09LelNTcC9wdGpiL2JZLzdhclZJTXhyTzBybXk3?=
 =?utf-8?B?SFA3V0E4WUgwVDJ2QXVsbm52UGtuRS9JaSt4dW5OdDZqYmFFLzl1c2liNXVq?=
 =?utf-8?B?cGZZbmZRdE84ekRHcmFHSmh2dzdTMkxxS1U3SG1NbFJCeDZXU05xNlkwVVlr?=
 =?utf-8?B?SlF4THA4ZTRjY1FyMEJyRldXaUV2MCtEemkrMmtSNzJhVU91UmxIalRCcEpF?=
 =?utf-8?B?N0tESlZXUGhRblpOVG0yenREZUpTcUZKTElnMTZ1dmZBeWpCRWVEbWc0VUFj?=
 =?utf-8?B?OVhZNGxvNnlRZDF2RnRKUDB6YWM3QjAxNGRqT0krUXRIckJuZ3BNd1JOa0o1?=
 =?utf-8?B?Q281VGFUS3QzRnA4WHloQVEzMTYxdGsvbTJYV0MxdUdIbWVpR2NKRXBiNmxL?=
 =?utf-8?B?MEo3aEtUbGRmcTlyc0lsckgxM3JBZ2RDc041dGJlRlI4ekdjVVVndVNqSFQy?=
 =?utf-8?B?YlZKZHBpVzBSeE1SaVMrT25tZU5hUm5LVjV2UkJ5eFRmRllBbytDc1hGc2Yx?=
 =?utf-8?B?Zm9XdzVIL2VEazFYSVUrOVdrK2xzbFBWRURqaFZVcWZGeTJwaUJHMGpkS1FB?=
 =?utf-8?B?M1grVDMvVlJwUHBkUzl5ZW5xQTdISDlrUTdERkNrTHJ6bFp0anpySXllbDdw?=
 =?utf-8?B?NGNHS3FYVWtnazc2Z01RKzkzY2RWOWF1YjVObzdaeWwzLzFqOXI0bHNoWlVB?=
 =?utf-8?B?dXVKY2hscFNPZFhpUlNCS3MzZ2NRcGxnbTBsbHI5NjlCV21Lamk5UlFsbGkv?=
 =?utf-8?B?U2NoVjFvaUFZbVpTZ1VyUXRlY2tLMEhzdTNhdHhMQzh6WGI1V1RHbmN0aElz?=
 =?utf-8?B?RFJxOEpqTXVFVHV3UHVGdXhPM1NUdU1sNzM1cGtyeVlUdmpWb0dxS29xUlhh?=
 =?utf-8?B?R0NFZnZ1bW0yRXRtMWdRQkNtcm1sczRrV2NWdDNjNFN6WDNqektmNE1WNGFm?=
 =?utf-8?B?UjF5aFlNd3cvcWx2M2FPUFpXd282VTE0MGN5TjIzeVAwNVhiVWZBeUcyVkkw?=
 =?utf-8?B?S003T1kxSlVTWlp4SjZVRjAzOS9wYUZNQUZaa05Id1hjQ3hmZDdCUnhzU3pU?=
 =?utf-8?B?bmYvOW5FbzlvZXcwdkE1YzVGUXBPVVJveFU1cHNBMmZRODl5elVyVlpkVDZ2?=
 =?utf-8?B?VmhhaGVtcit6VWdqMWNHK2FxRTNYK3hmZWpMdWlkWjEzOENKMUtpcG8vUHo4?=
 =?utf-8?B?MFZWVjZKLzUyVktFZnJqdkdxOVN3R0I2VHJFZW1XOTFONDJJSzRXRWFaRVRn?=
 =?utf-8?B?RG5tdVBYUVplbEw2eTZ1ZDRKNFJyc1hUeHQwZUtHNnV4LzluTkFCUzdIWXJL?=
 =?utf-8?B?cW5IMUZTRG9sUGhCa0EyTWkvT2k2SHU2TFlFTXVIN2lyLzNzUDFOSzNQZjBq?=
 =?utf-8?B?QlZtc1Z0TDhlQ0JYZWdEM3RtR1NiSTY2YXZNdXQxUU1WUzFkSmZCak55NlVl?=
 =?utf-8?B?NzBYN0ZWREQzMmZYdEtVa0pEUTZlUjFjMHJ0YjRoUWc1QnExMFo1a2s0MUdC?=
 =?utf-8?B?bHZ4Z05sUHdkZmIrRDEzMHd1clBjaDZPT1N6UUEwTDhmeEVQd2x4enJaeXlS?=
 =?utf-8?B?YlhNSEJtQlZMeDM1aExsWURabUJvMkpsRCtVSWxZNzFZQXlxQ2FhMmJYQVB0?=
 =?utf-8?B?UkxqbW1DV0VXRGFYNFkwM3p3U1BTV2NCOEpjKzI3Q3VFUTYvNnlwMkxCUExj?=
 =?utf-8?B?NmM4QXl3MTdqNlBqUFI2Y0w5TGlFeDEwVFVJMjZNaTlIbTVIcnFoVVhLQi9X?=
 =?utf-8?B?Mm0wdGQ4K3FSNW0rTmkyY2N6Z3lDMENUNGVNeHlyMEhiYXR5b0JXZXJldlcx?=
 =?utf-8?B?Qit4QzBvU0JDZjJjQlZsSnBIcmxxR0hoaHh5WG04UnYyZ29PdGdOWVBQMDdo?=
 =?utf-8?B?MmhISWFVU0tDUE44cTNiLzErTmpVM2c1bXZTZGlWMjVEeERTNTVOY0QrK0g4?=
 =?utf-8?Q?h+QLk1IJSjNCaJtRluq+HjE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cedf852-9148-4528-4a9a-08ddb9821ba5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 16:04:21.9437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68QLunFM4p8Ok+tepvhE/8s572/3M3IyO5uNz7VLC6rugi9kj7fpxyCdQ4XsuBvOHo9CzWl54e25u54V0iPm4Ob6eUOb6lqyiabSVTqoXFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7306



On 6/30/25 6:05 PM, Stephen Boyd wrote:
> Quoting Matthew Gerlach (2025-05-13 16:48:37)
> > diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
> > index 8dd94f64756b..43c1e4e26cf0 100644
> > --- a/drivers/clk/socfpga/clk-agilex.c
> > +++ b/drivers/clk/socfpga/clk-agilex.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * Copyright (C) 2019, Intel Corporation
> > + * Copyright (C) 2019-2024, Intel Corporation
> > + * Copyright (C) 2025, Altera Corporation
> >   */
> >  #include <linux/slab.h>
> >  #include <linux/clk-provider.h>
> > @@ -8,6 +9,7 @@
> >  #include <linux/platform_device.h>
> >  
> >  #include <dt-bindings/clock/agilex-clock.h>
> > +#include <dt-bindings/clock/intel,agilex5-clkmgr.h>
> >  
> >  #include "stratix10-clk.h"
> >  
> > @@ -334,6 +336,375 @@ static const struct stratix10_gate_clock agilex_gate_clks[] = {
> >           10, 0, 0, 0, 0, 0, 4},
> >  };
> >  
> > +static const struct clk_parent_data agilex5_pll_mux[] = {
> > +       { .name = "osc1", },
> > +       { .name = "cb-intosc-hs-div2-clk", },
> > +       { .name = "f2s-free-clk", },
>
> Please don't use clk_parent_data with only .name set with dot
> initializers. This is actually { .index = 0, .name = "..." } which means
> the core is looking at the DT node for the first index of the 'clocks'
If the core should be looking for the first index of the 'clocks' 
property, is it better to explicitly to state ".index = 0" or just have 
the name?
> property. If you're using clk_parent_data you should have a DT node that
> has a 'clocks' property. If the clks are all internal to the device then
> use clk_hw pointers directly with clk_hws.
The clocks are not all internal to the device. The "osc1" clock is 
external to the device and connected to a pin.

Thanks for the feedback,
Matthew Gerlach


