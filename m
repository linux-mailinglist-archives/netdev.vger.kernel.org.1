Return-Path: <netdev+bounces-230647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E24BEC501
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 04:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1B06E0F6B
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DDB1D61A3;
	Sat, 18 Oct 2025 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="pY5WQLq8"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8641E521A;
	Sat, 18 Oct 2025 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760753201; cv=fail; b=egcSGFPtbw3QTxCeVd31JGIL082TaEXqRAZxW6Nkb76yKEJqq8ovWmZBb5E0VZ5/ax8fcCTLfmO4hVw1v9I03I/yRfS28B2Jy77mShlvR2bhTGB61ncIi3cNiBQtfI0K4VSfruttDGYJSYTrODPDZXToyHDS1/s+P58HiCSPVeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760753201; c=relaxed/simple;
	bh=PDuwJ7wbp8xrmPf25oVP8HQ5mgN5RFY3Qb6A1wmhVsg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WSoC8/8jGfXD1ehDxZi1YQsMC+qvt/ZXWBcOHfzfV6+FDF/Rz5Tilzg7IuuxhTo5DSNa/c78Kder2OssBLwl/sXqES7WQY1MgsXWigZb1Uq/cGsiTJTNZGLIOuJw6fOyW+YCwVOZhLQ/iLK5FfaShPqeym7cHnECm6yRwFVYzrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pY5WQLq8; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Axd8+1MCwSZHc9Ypkhq8pnSl4z4qhbiOJbWIbQcuRNlIrm15c06X+hQ07XEdGdqSyyhRH54AEz4mco0GhYjXUMqWfZlUWkIaIGm4zdechOFoADBiRaS5IUXbu4tkJjZQDa35osvzOdn8BcMX2r5y/OwOqWDWAcwZWPqhT3TzGkpOtEmZyTn2ROpBmflWFYrxzSAAA9tkHmcA0cdBdKzw55bYFNt3AUDWlS0uV5ttZZMR3y+lOwIzoQlnCRxIOPtA6vVGzx4q8v35dtTG38YOLh+Eyl457SoH0IO/O1ojzBrLxROwMgI2k7GOrJVcYPcLaW4VEYM6Az1N4PloQDCW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EZKYZayK3Cka8MXHsK6Ec+v03K4IglaV8vPI9vwoTM=;
 b=Qf+OJJOdOOJ3al8XLHwH8XB7VX+HtuYpKTJXhZiFLweiikRAqErPtLQEKa/VuSBcsU7Gvf3YZjgdv6Q0EhSsqgMseJsuaUIGjrAxRf4+ThBcV2WnmYWiqaNKOAMdiPqLKXVW7h/YVz7b4vv5TtvPXOjdJAGBOHDDaVjgkA1DqME7wojRgsU87ndU/uSN7jRc7+V4w00k6PftcmwWXaTw6ui8FGYkOriHT9CJ2cElX4KM3Tixxdb5KRgg5nKKggnYBVv8/COXLDDkLUgKQFgfDGqJx6vlhj96hyEDtYTN3rvBKMQa8UPUG6P+BoIU3jtiPDrfZ5TUQMC3jaJbHV2VHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EZKYZayK3Cka8MXHsK6Ec+v03K4IglaV8vPI9vwoTM=;
 b=pY5WQLq82/5jkaLrTGcs2JccpA9EXNlwk46cXMJJTcNaOWNKV2PSXSajcxggMULL5rKhRmQ/1eyMMozlswN4PAKA5PsYMqkF9nSbfBmB99ajIEXJYpo/S4N8aQUELqTwqOweqBmsPj9k/E7XBIWbXeoaY0CEBJl4t8nrjZ9tOiZ8YcunpshQXWfJChdkhJmh5uQZMfXFMWpsMORqOGzBfdvJ5uWxOVKuprbScrSqnSw0nG9qW+ZC8Zy2dB1iLUzT30q9ax4dGAZ+UX7A0704OnFVPiYTXOoOb1izv9AsHwi+RYPY1wfycJBpCbPH9J2oREKdlGynRv3JL7dMlzj0CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by SA1PR03MB6513.namprd03.prod.outlook.com (2603:10b6:806:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Sat, 18 Oct
 2025 02:06:36 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9228.009; Sat, 18 Oct 2025
 02:06:36 +0000
Message-ID: <ac0a8cd8-b1bc-4cdb-a199-cc92c748b84b@altera.com>
Date: Sat, 18 Oct 2025 07:36:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>
 <aPI6MEVp9WBR3nRo@shell.armlinux.org.uk>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <aPI6MEVp9WBR3nRo@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::16) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|SA1PR03MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c6ca0a-d843-4e2a-2c09-08de0deaf7c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDdFR1FsTjZmaWJnOXJiUlIzOHNUeE9UMC9OYnpZOXRFKzhTdU9RcnVMb1py?=
 =?utf-8?B?djNHbVN2WDVQUjliMVRTRmEvaVp2T1Z4Y1QyYTVZNjB4SEdkcUlONmxnNWc5?=
 =?utf-8?B?SHZrSUZUTTJ1RXlwZVRMS1FmWjhHSkZvTkZqLy9FdnRNVEM0aGlmV3d5aW13?=
 =?utf-8?B?U2tDZVFsc1BXZTQ5cEt2RHZuRzJFak5rQXBqR2h3VDl3SkJtcEtUTHk5QTBU?=
 =?utf-8?B?ampETFdtRHorcllNN0c5R1REbVdiRnRXdGZpaWNmcW0yRnJieUYwZ1h6Sm1y?=
 =?utf-8?B?UWZ1ZVY0WUg1ckRKNEhGT0dzdzJqZmVkazJMWmNQak9WSWJqNEF5NWcydTVv?=
 =?utf-8?B?aXNjeGdKVy9wNHFFRFBHYXBuK1V4cnpWeExZMU9Waml2eTFFUmo3dGR0Szhj?=
 =?utf-8?B?NUtpRXFBV1A2ekJvMFFidCtZMmk4aHE2WmxwMDhMZmNEMU1BMU5WKzUxenNG?=
 =?utf-8?B?RGZVOERzYzNXYTBKbVMyVHVOZVE0a1NOVUhlV0JDSzd5Zll6bUlMMWhKb3BH?=
 =?utf-8?B?ZU9VSlZJakFNeEN4bFFKbU1QM2dOOEFhcTdTRWZxdGxwdDRqaVNWYWMrYldu?=
 =?utf-8?B?dTFVN1NuMWhza2RTUk9ldjVKWE1mUms0RlNPUlBrYU9ldjJMaTZBaHEzTWMy?=
 =?utf-8?B?V1NGL3Rub0FOU1dWemkwdU84TC9sZTZnbS9aM0Z1WkR1cEdTYW5sODQrNEsx?=
 =?utf-8?B?REdnZGw3UTVNejZTcGl4QzdscHA5dWsrc2kxR0Y0TFBsODlZNTdpTzRlbG5Y?=
 =?utf-8?B?d3k0d1BYTlM1N2hES0ErbGMwUWdtKzFYbW5pL0VUNERLRDJiREtzVHUxR3hQ?=
 =?utf-8?B?UkM1djEwVCtmT0R1OUxpckYzaEhBS1doR3RrWXVac1lMRGF0TWZ6Q0diaGR4?=
 =?utf-8?B?c2ZzLzhQemY5VEp3TlE2NVJoRXEwZWJ3QlFPcmZFS2pXQkJudW1HWjZnQVlv?=
 =?utf-8?B?TFlibWkwdS9ITkg1MGxSSFVVQlpmSGNvWWxvb3F1M1Y0emZ3eU4xTlp4ZWcz?=
 =?utf-8?B?OE1DeEZrNDdWYUNFUGd4V2t2VjJVbk56SHdWWkloTnp3eVVlZ0Y0eXQ2QnRn?=
 =?utf-8?B?ZTlrT0s3NWVON2JxeGZxMHR4ajdaR1BlNWcvWUdUL1d4QjZxUTk0SmRlMWlx?=
 =?utf-8?B?M3laVFpPcndRcVlsV0hiU2FGZHJBb1JuenJwaVFpUVFBOS9UMGl4TDV1UkpZ?=
 =?utf-8?B?Z2RwcEtSUmNVYktoNlJrT01JMDZ4VEt0ZGVPaUI1eGptd0NTeWpielhzWCt2?=
 =?utf-8?B?a1Z2VnRaeStJQTF3b3h1dHgyTEpSVU55QWRyczNzdS81UzlzaXdScEdVZVUy?=
 =?utf-8?B?MWNRQmYwVXRiUFlUNUJpekh2RUQ5R3o5THNXMlpnNHpjS2tiVGNQMlpDZTlu?=
 =?utf-8?B?RDRrVmorV1doMzZ1alRtRFNvQ1k5UDFHSC83Ym1YRHlJcm9ZTW9wOXd6RWhl?=
 =?utf-8?B?dElkaXZJbXRGcS9qUkZoK25uNW1NWktyd0l1NzNrdnA0SnpKVUZvTXFraHZw?=
 =?utf-8?B?SWhQRk9kaGJCamtVS1lEdEJYSDAyQ09QcStsUG5zNlVLbnp4REloSDdxdEp0?=
 =?utf-8?B?SVh5TmRkVjQ1Qi95YnNYQkxGd0pXR0h5Q3ZQTHk1bkJUY214OUNEUjJ2djEz?=
 =?utf-8?B?QnZQOVhDdzdxeGxKNWt5RTFSSm9yQTM4UEgrK1RTYkpuamticWlBRHpLdUx2?=
 =?utf-8?B?cjdIYTNRV0UrdUpoZzhyL05sUjdKY29UWTVXemVEOHo0ZjhiYWFhVUtSSlIw?=
 =?utf-8?B?YmdzN2RpNktOVGpkSFZQazJnSEtkU3dPaXBJL1pLalA5M0p0NlhTOHZhZ0Vj?=
 =?utf-8?B?Vk1STy9uV3JYSHJpWjJWZ0hXQVJleXVmZXZSbmZ3OGhYd0ZtZVdFOFNhdHFT?=
 =?utf-8?B?czNIYWYrUzZQK25uZkhDZjRCT3dQYlpGN3NxVEwxZmp0N0llREg0TFRoTldV?=
 =?utf-8?Q?i0b1Ypw/2bc2RArzAdLW4yTEdummRv7S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkxsdUVmZTQzVjNHYmsyNnQ1Ukw4OExwSVMxOERPSVQ0bnhJMEZFeUNkZm1K?=
 =?utf-8?B?Vlcxc2NUOVVENzhNMHhIWCtsQ0J3UHFoWXFRaEN3ZGlxVEVIcCtjdjJlWG5p?=
 =?utf-8?B?Ym10M2J0UG4rZng1WkliQmJOZ0tSOGkvUWU3cml5VVpsejY2TCtQSGg4aHRD?=
 =?utf-8?B?WDdlaG1ZQWFNcjNRU0lzZ3NLY1M1ejNQSFJ2YzJsZktjZ09iTHR1RTJITmds?=
 =?utf-8?B?TUNMV1dQYTZyWkdEMHhLRnlWcXhzWVVzd0dWT2N2dUw0SWVod2p3T2p3RWxk?=
 =?utf-8?B?c1orZm9aYk9NeGlpSmM4cGVWeGxqa1FPQ1d3WGpiSkZIc3V3bFBXMTBMRTZJ?=
 =?utf-8?B?YUZCYkI1OEpjR21XaDRXZElvRCtRSjVtMDU3eWtoZ3RnZTJsSU8xUWpON1h5?=
 =?utf-8?B?bVMzZ2R5NU9lb0RRazF6VmhrNnZRZW5vb3NkWnR3NzFHNURlYTlKeWI4THJD?=
 =?utf-8?B?d3NtSGk0SG5JUVZ5eFlwZUh6VkFQZ3VSRXdzOVpmYVJ6alArdG1YcElzdHl3?=
 =?utf-8?B?dC9DRU1kK1FrbjlMRG9NTVVrbjhhS0k1dmNUTFl6eVNpK1hUVFg5QXYyS1pS?=
 =?utf-8?B?WVZLcWsxc1V5SUwrOGI0WElGUW1UNUR6M0htVVAvQmR4aytMTjlyc2YrT0xM?=
 =?utf-8?B?K0xiUEpmRWJrMTNDWUQrZXk2VGd0SFJSZUNhS3R1YmhtU01COWZPaTRmZytF?=
 =?utf-8?B?YVBlTkdjNjU2bzFkWVBDanlUTEZrOUwweU9xN0wwM1dCMWozMURac3c4bnFl?=
 =?utf-8?B?MXI4S0xQZ0R2U2F1ZEpSSVkzWDJQTnBEbGp3d0gvakh3TkE0bmVXb2RpZ3Ex?=
 =?utf-8?B?NW04MjZ0cjk4ck1zVlFZTkxtaklNZWpKdmpWQW81d1htV2hOR25sVUFMR0pV?=
 =?utf-8?B?N2Y3VEtGSEhZUHZuQjhQdVZQZFplUlVTVXdNZVFzTHNlTkxub2h2TGQ4L0R4?=
 =?utf-8?B?MG5hTUIycDZjaUIwT3pJU3lYYUJ2dlNaYlNqMjRPVzIrcnVTUGMxSytidkth?=
 =?utf-8?B?QjdhTHk2czlXOFhUb2JoTHBYQzZGVG5Id0hhV3RpVEZUVG4wa0JkcDZNOHFj?=
 =?utf-8?B?SVJ6eWwwY3Y5Z2ZBWTlRYjUzQ2drbGxEMjZKNnFkSUY2M1A1M21UbUFGYUlj?=
 =?utf-8?B?aUNpaXMvK3JZMWM1MzNMWmhocEFhVHREcDY3OFZjaE1TRDhXamY4ajcyb0o1?=
 =?utf-8?B?OVJmMGZiTWJaSEZoRnZUZVBlaEh5b1JuU3R0SUFCTU11TnBiWElPMjJucFF5?=
 =?utf-8?B?cnBjODYrVWZRMVR5bG8vdnlJNzV2QVVJMDNMZHNOeE9pckIrdzNJNFN4YmVF?=
 =?utf-8?B?YVdtTzlKWm9Wd3V2a1RPdUhQQmRuM05wWWUvWXdRbUh2c3diNyt3YlRVZUFL?=
 =?utf-8?B?Ym5GR1hUbEIyOTg5Y2J6VU4xN21QMXR6WUM1NFhQRkhNdnFBOWF6RkF2OXJK?=
 =?utf-8?B?b2UxSU5rdXBaNTVkdGdwbDg1VE5VOTBCUWdscVROS2dHNUFMN0FUUG10bmtV?=
 =?utf-8?B?citmVVZvZ2FqeG54TkN1WUZUNTZ0QWJjQXpNREVmUy9yNkZmb3hkSzlYOFFa?=
 =?utf-8?B?eUJqdExkYU1LTzBaRWtLMGRWY0pIbXZOTGJKMHpGdy9JTDBiaHdVbDJTWmc1?=
 =?utf-8?B?MVZ5OWRydXR2WnAvTFpmeE92dTUwWXJuN0ZzclRNZnZBUmNoOHhBZkJpVTMz?=
 =?utf-8?B?V0dDdVBOZFVGRTI3S1BBT0xLYkRIREV1UEdGNUhnUExvdWpzem0yaElRckFk?=
 =?utf-8?B?NVk1TXJZYTMvcmFvTC9Ba0RnKzJFZGJmYUg0TUM4ek9UUWt1YTNzMlBOM1Fs?=
 =?utf-8?B?K0w1QkVpdXU0YkwySmxiSU1TcUswR05zRjF4NlJ3NEhYdG1ucEVBWmpTZDhZ?=
 =?utf-8?B?YzJma2p4OW45bzRBUENCckZReUdVcEFac0ZrVTVLMDVOWjJXc0F1bGhpc0lH?=
 =?utf-8?B?OFVIQ1BFWGozUkNmWkpxcXdhQXJ0bkJ5VUdjdnFQeS80dDdtQmFkUWQ1RG1v?=
 =?utf-8?B?UDBvOTNKd2hyTFd4R2RsbEtqcktRNCtuMUNWd2lCOEtqY0JaNU43WEdwRmw0?=
 =?utf-8?B?V2hkMm5JcThTRHMxdEFHMzlDSDV6aDd6U0IzWFlmbldDb1p5Qk1zZW9pLy9I?=
 =?utf-8?B?U01WM2dnSmhjUCt4dFJhbUNETjl6OUV6bjdybi9KUElCejh0L0lxRHJMb1lE?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c6ca0a-d843-4e2a-2c09-08de0deaf7c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 02:06:36.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpFNb26TZKmnPbdMNmavzgTVDPRF8TPILPJQoWS5mN+4P+Tqrhl+2WlF55tCi/Ctn80CkdBfXPwmKMTJ6SP7Fv56x4TcGGgnb7Xz9Oy1hhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6513

Hi Russell,

Thanks, I'll update the commit message.

On 10/17/2025 6:14 PM, Russell King (Oracle) wrote:
> On Fri, Oct 17, 2025 at 02:11:20PM +0800, Rohan G Thomas via B4 Relay wrote:
>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>
>> On hardware with Tx VLAN offload enabled, add the VLAN tag length to
>> the skb length before checking the Qbv maxSDU if Tx VLAN offload is
>> requested for the packet. Add 4 bytes for 802.1Q tag.
> 
> This needs to say _why_. Please describe the problem that the current
> code suffers from. (e.g. the packet becomes too long for the queue to
> handle, which causes it to be dropped - which is my guess.)
> 
> We shouldn't be guessing the reasons behind changes.
> 

Queue maxSDU requirement of 802.1 Qbv standard requires mac to drop
packets that exceeds maxSDU length and maxSDU doesn't include preamble,
destination and source address, or FCS but includes ethernet type and 
VLAN header.

On hardware with Tx VLAN offload enabled, VLAN header length is not
included in the skb->len, when Tx VLAN offload is requested. This leads
to incorrect length checks and allows transmission of oversized packets.
Add the VLAN_HLEN to the skb->len before checking the Qbv maxSDU if Tx
VLAN offload is requested for the packet.

This patch ensures that the VLAN header length (`VLAN_HLEN`) is
accounted for in the SDU length check when VLAN offload is requested.

Best Regards,
Rohan

