Return-Path: <netdev+bounces-231359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E1BBF7E1F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46285807B6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 17:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8370D3451C8;
	Tue, 21 Oct 2025 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="JsDUwwOP"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020136.outbound.protection.outlook.com [40.93.198.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624834B672;
	Tue, 21 Oct 2025 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067262; cv=fail; b=p6iCO0eus1R/hh+/LMvlcP3vOvqJ3wFQlCtx+Bu7J9Yb41U/wvIHF/EEt72Fx+pY7/pi3CeSkmajmE1dCKNc4uEPNfuDTNKW2Xkx+G6Ju+pr1M4Kg4SELU1OVgRhXNXdAc8KoVtto3dJbhUW03usbQwIAYs6nsmefvJtkZKLg5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067262; c=relaxed/simple;
	bh=Vtf5rRBJtH38MPhLFiPj3tAH1ybzVjqTA7A07XkGo1Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PsEGH/HUtrdrhcwRNcVgF3ySklHyNz5wcv4zevIxpA7bxqO+TjBYxxK+286xTKM0LnO8IXZAbSlkL0l+1g5swhfRuX1QUGMPVH0JTTUCYUu4i0JHbMV3nIYPDYZ9O0uqYNy91a5hmYYLyUuIjtX5JSCGEGev3CMkihzY3VbfgDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=JsDUwwOP reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.198.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jALjHFhVGFgMDNZjNdSf1ongB81hmfezukHb1lq3k9xxC/9omHXJEz8TcO+trjPpQQy8mjKLSHITWw59BJD4LA4pfiXvBgBM6vpMnlbMoUuDN2D3kLpMsXxQ3L1aamb88wQkFcBuT3lla6rs4uziCTxqwiTPZxaaXCpN6YMyjlxnfX/4bBwqOvfaScyMmtAnIVCfKGjy1aDCNHrCCwbArpmA7AbTJytZzKM/uudYERpCFV7ywBxUsn/vmCjEFtNp23yMh9s26SPwRZXb/DztHiL/xYFyKEDj7XNYKujmXW+8Qo+2mBrRutIHl/rZQnTnDI54uC6BUQjRkYFXBcE2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3Lexre5eJfhnJUX2gkd82F20WUFCKJyEbK8y/VsonI=;
 b=XZzb8zJfVNGiSv/XK0F2MZd8wRroQklCFyh4TuYJ7nPvRFE02lj6eAUCgrm9flASfD53yssShv/gQeOSr9ePkUOe3Tcvw2q2+yGlLcDzeeciiVqx2QDHMLNsHIrO19nDY+ov9TmcYeMakxF8hzo4JmPTEFUta/0N5IV0H2xaizgB0W/qPpUccUMBpWMFQYVdV4k1cYn6PbIcltIvEtbf0GUjDd7gjxSC3fBj/w8eomgBgFDcOmNnnPT60OynkK74xIF0buusI5HuypfKrmijnhBTdBSSQ858Ei1W+w9aRiNAQQS+JEz7VAYeKUhjsE5mLjZA3PDuA3wyp1RJL9fI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3Lexre5eJfhnJUX2gkd82F20WUFCKJyEbK8y/VsonI=;
 b=JsDUwwOP6dVwxllv/DJ6G1NhYTAxpFkMTcSlEDGEQzHA9oPZ4rs1kkCaORP/ka8SUled6OROZxuJNXt1FkRwH2DNjIZpmB+lRDlDIN34jZU+TSlWOK9GCXN4bADBVgaM/4WWUMiGc5mdAEZANvtWe//LAAnljLQiusGXw8pvCug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BN5PR01MB9125.prod.exchangelabs.com (2603:10b6:408:2a8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Tue, 21 Oct 2025 17:20:56 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 17:20:55 +0000
Message-ID: <3ae91e09-2f52-4ca4-b459-3b765a3cad0c@amperemail.onmicrosoft.com>
Date: Tue, 21 Oct 2025 13:20:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 2/3] mailbox: pcc: functions for reading and writing
 PCC extended data
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
 <20251016210225.612639-3-admiyo@os.amperecomputing.com>
 <20251020-honored-cat-of-elevation-59b6c4@sudeepholla>
 <78c30517-4b16-4929-b10b-917da68ff01c@amperemail.onmicrosoft.com>
 <aPeSfQ_Vd0bjW-iS@bogus>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <aPeSfQ_Vd0bjW-iS@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR14CA0025.namprd14.prod.outlook.com
 (2603:10b6:930:2::6) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BN5PR01MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbc84f9-7bca-44f2-f4f1-08de10c631a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUtTUlpvd0pmeUNUdGhyVWw4N1dYZEFSdy9kU1dpbVp0ZHZUOUNQbGVJUzho?=
 =?utf-8?B?aU1Pc1NiMnpjaDMzYUdGVUw2REkwNVM4TW9STjY2NXZuUWVQbVdjNzU5QzdB?=
 =?utf-8?B?L1JCeUdMZjZ3c0kxUkFjMG5BU0xnWTZxd2plMU1OdlFMamtiSU1BczlPN1ky?=
 =?utf-8?B?anhLUU4rTGdYVkcyM0xWZkxPeWRyOFB0ZjVNWDVld1B1ckZ4Q0hnand1NEJt?=
 =?utf-8?B?Qmh5Tzg0ejJ4VFlSRWhpK2ZkaVgvRHNRNUtBdzV5dGZtb2RWMjU1Sk1QWkVE?=
 =?utf-8?B?dHpEQi9pQTZSUWNGS29TY2ZoWEx5SUo0aHJSZVdvOG9QM1hPS2hqNjlrcmRv?=
 =?utf-8?B?TG9pYWtFS3R1dDJXaTRiZHFlSDNwak1OSEU1U1Y4VXB1clMxb1NDa0dQaUtX?=
 =?utf-8?B?UFYyVWkvZ0tpbHZxSk5GMXkwTEltclEzQWlPZWhpb21oQlcwK3JtM1ZyUmtL?=
 =?utf-8?B?NkZMYlNBcnZmeXBkdnFJSVpOMCs3Z0NSVmcrNmhoUFhLU25Dc2hqbEhPSTlX?=
 =?utf-8?B?N3lXMGdUckUyZDdwSTE1WkNTU1JhdEUvaFJDWVYrVWY4TEVjRi8yUEJSREkz?=
 =?utf-8?B?b2dDdG9aMkpwQWh6aTZvUnpkOGI5bU1Vd0I4OTYxekVTYlhlMnhiNVp4UzZj?=
 =?utf-8?B?bWlScmM0eHZZZkN2N0UrVHRsM0FqSjFCRlJna0haYWJWcnZGQnRRNjdobDhr?=
 =?utf-8?B?M2xEd3lmdERLWklYUTBjQlRCdEZHbHVwZUlzUG4wQnRRRHpsbm85Z2JQYmN5?=
 =?utf-8?B?Z1ZBdTZqOVZNaExxa2J3WlFVUkxLbzNwVklJbWFTSVVOcUpBTmVNQmtzMnZO?=
 =?utf-8?B?bGtTajA4TUpQakJUTXR2T1cvMURjSkRJSENEOHh1aHB1VFdJNzBNSFozUHZS?=
 =?utf-8?B?NTZ1VjUwS011TzZWd3BDVmVzSHRreU9Gc0I0STNrT3h2TUpFekdlUk9Nb2xC?=
 =?utf-8?B?RHlUQkZBbFhnOGpkcHh1enIvNVgzYk9vT0d4RFRRSWlxWVlFaUZNMkJXUUpn?=
 =?utf-8?B?dHR4b0RqdVhGNDIyaEtYaVlSaFhKUUcwb2VyamFHM1ZvNGNJcUxYYXN0d1Ux?=
 =?utf-8?B?SFZHOWpQRVZRM2RIb1lvcE5JMVYrRzQ3dDFxZGZialNTWENDWHBUSWtvclpT?=
 =?utf-8?B?ZWQ4NHhsamx3RitoazB5dnlBM2JvaVBKclZRbVZZQ2xwUkZ3TnJJWEJpVHYw?=
 =?utf-8?B?ZmZEZUIxWVY1YnRuR3FqVWNzV2RESUV1REMxRGVya0dGK2s0RFVBYVQwVHBE?=
 =?utf-8?B?a09hWUpIbHBsQ0JUL2QxSGFFTnlwb040UHdQaHErTmlxTk45NHNTald6NjZp?=
 =?utf-8?B?RlpiRU1CT2xOQWMzVXpjRzFGTVRNNE02SUV2S3pmWGswT1Q2cHFrUE1TM2JV?=
 =?utf-8?B?V2VFbG54WUlqZlFUOWhzcVdtbzF4cXZTTXJzQlNyVEdZWTBlcmxxd3BzeVlt?=
 =?utf-8?B?dGpQTXR6UXNvWlRyei8vb3NHZUtoU29EZ0IyT291cGZTTXBYNjJZa0thSUdZ?=
 =?utf-8?B?UVlKN2VvMUZIVFBTSDZqSTZnMjhXb1ZSbE8yN3F3MHRoaXBNQWVaWGUxaCti?=
 =?utf-8?B?VjhYSDZxYXIwWTNUbERFemFiOEtWU2hxa3ZCNlo5RlNxc2J0UkY2YWQzb0sx?=
 =?utf-8?B?Qm92LzExZmRXdDVpako4OE9nZzZmd2FOUFpKT2YrVlRqT3pjc2FIc2xnZkVF?=
 =?utf-8?B?Vy9xM1lLQi9XZnUrWXNoUkw1bFdQM3dFa2lxVEZCODJQL1cwVi9Nc3BabG43?=
 =?utf-8?B?R1FDeXMxOXR5MFdUaXZBWERKSE83bU85SG5ITnBqWVdXazZsaFhoR3F1RlBj?=
 =?utf-8?B?OE41RzdwVFNOa2pyUXJGSEZBblNiMlJYcnIwYmYyeE9GOTk5ZWsySEdXYWhP?=
 =?utf-8?B?NXpjVUtwNHd5QkJza2lBcU04UU9PWVNXWVJqV1hJSWo0SlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEZ5QmNKU1FySTdZbEJLOEY4OEpQNUZXcE0vYmQ2UXFuQnNDUTNvVTlkMktQ?=
 =?utf-8?B?bFBRWWlVMDNEbUthSDdwQnd4REQ0azZxT0QrbWhkd3VFdm5GemlGa0M5UVpS?=
 =?utf-8?B?QWRlRWtrVzdKbDRGbnJXOHhncm1iSHAzdllTTXc5eERhN1FlNmZZSXM1SE1U?=
 =?utf-8?B?L3NQc2tTYVMyTXVGYlVLeEpSQTNMYTAxb05EVm9QYS9Ga1kwcG5TTmtOV3lm?=
 =?utf-8?B?bDUrZVpJdVk0RGJmUFoxRG0zcHU4OTJrWG9PL09HS3hPZnZQQzlqMmRUdkw4?=
 =?utf-8?B?MGJVNUUvdzZtRGdPWmNKOHlGTFhwek5zb3V4c0cydldscllKR0VabkJIVVEx?=
 =?utf-8?B?NUUrM3ZWMDFSekNSQkZ4UGhCWFlHQUF1K1ZpcS9yN1pSWlYyOFlBRWgwUjhN?=
 =?utf-8?B?bHlVVk1MVlAybVhKaE5wSU1aMTFGeXBuTVVPRFBBbVE4YlNOSmp0aXB2SlpF?=
 =?utf-8?B?TlAvUVFtVzJiTERKdkI0T2h4U29Fb3JpY3ZSK200SGZqZHQyWStrUWZPQzN4?=
 =?utf-8?B?RUd5UW42RjFvUHF1WFN5N1Q1S0NLYlhTV2FhNkRNb2ZqVVcwYTNPT0N3bVk5?=
 =?utf-8?B?Q2FNN0ZMY1QzZlRrTndqaUpZUEIrZG1RM0hWWFB6WC9HNHQwWjAyd3FmN1Bk?=
 =?utf-8?B?cEM0SDdXT3o1TllEK3JSVjh4RnRHaTlJNTJHMkxqaFhERHM1QXFwOEtweXlx?=
 =?utf-8?B?L0Q0bUdxb1hScDZGVTRlMFVCSktsUkM4MStLQ3dydXNRZmtER2J1bHpZUFVB?=
 =?utf-8?B?N200L0ZRY1FLZFhoTUN0R1ErU1RHTUFlSmJWRDdEcXRlVm5raXg0aVJXdkFh?=
 =?utf-8?B?Qnk3TlB3TW1XUk5jbkV0bkI3WXRWT3ZWNlArQ2YrSStvTXgwaDZBemozQkRl?=
 =?utf-8?B?VU1FaEhrbmVrN3IxVFZrVjNQK3ZBa0U5TjUwVlBIbHZaUjNRQ3JRa3p2amY5?=
 =?utf-8?B?OHJNTk8xYmJIWkZZMVI0Tk04MXNzcE9KMHU1QmtXcTBmOERkNklaNlhRV2NG?=
 =?utf-8?B?TklEeDdDczNGMGtibGZvb2FCYUZMZEFvS3BCeU9FQVJHVHB6TTJsRDBtWlRs?=
 =?utf-8?B?OXhnU0JURXdUS1RQbk5rOEtVT2laZlJKMUVlYnRmdWp5SzhDVkJ5d1hxREJr?=
 =?utf-8?B?UVlsQmp0TzkxM2ZvcDIvMFpLc3E1V1hjVDFiYUEwelZEU2RsSmtBTWlHNnQy?=
 =?utf-8?B?UWlyL2ZyWjFkWitnL2kxMHd3c09teGk5OEVqTmUzNWEwN3UrRFN2ekRZdW5P?=
 =?utf-8?B?TmVtd3RWTENPc2VwYlRrTW1hZ3JxUVZNd1BXaExST0U4LzJ4b01IZzcwbTha?=
 =?utf-8?B?Wmc1YjNoUHkydzlnR1VPUmhCaHF6VXo2VE92ZldFWmQ1YkJ1WnpYamRSd3JU?=
 =?utf-8?B?U05BVzFqUXlGQWZzUklqUXg5L3FjMW5NelZOaEZ2T0xhSnZjcGhIMmt0QTh2?=
 =?utf-8?B?cVJkTHkvbzJIdnQ4dGhhTDZ0ZlNjOTNHeGxpYnJMYnVwQ00yK3A1VW1hKytH?=
 =?utf-8?B?NndHbE4zMzZaaXlKMVhIa3VGaE5EY2lUb0s3ZW5zc3duQi9LVG16Z1k2aDR1?=
 =?utf-8?B?enpteGtxQ2dYY0d3NnVKWWM5a01UUTV0ejRlVFNteVNUTGNxeWc4Sy9UeU5O?=
 =?utf-8?B?QnJYQTJKMzNHbVY3bHYyMjBEdkNqMFhVMXJxTDAwa0dtSURWazZ0byt2Mjl2?=
 =?utf-8?B?QUxCRmE1SFI5Z21ub1RxdERCVW1BaFNaa08rbHJNTnNYN0dlWUJSeTRuSFFa?=
 =?utf-8?B?aDNTWm45RnF3d205dTVPT2YreGpCU0l0am1xMUZKY1FENDRrQlpRTHNHWllK?=
 =?utf-8?B?SUpkbmZZcU1vTDJ5aFVqcUlqRVBodTNZVGJiMCtvclkxZkwwZW5nUnZIN0FJ?=
 =?utf-8?B?WVNWeGhTZkpQYVIwSUp0WEIxRmZlenROa3RQeDZ0T3dONWxVNVBIdUw2ajl5?=
 =?utf-8?B?SGNOTi9yWGxlb0hrdGhvT1ZVNVdaUW1oNHA5d0hkaWQ5a25EMGFNcWJYWjZQ?=
 =?utf-8?B?SUxINGNlZTl1b0JkbWYxSis0VW5yS3dVQWhSbWdJejA1b2IyY2Vkd2ZnZ0JB?=
 =?utf-8?B?cnZ5REYzQ2Y4Qk1nVmllVmVqdExKZUxoTXFBZnV2RDRRSHhsMldvMlErRDVM?=
 =?utf-8?B?YXZHL0Q3VzdWMUZhTjhiQzNuM0c0T240ZTJsaEszcFg2MUFsYlF1U1IyYjNo?=
 =?utf-8?B?MkQ3akROdHo1bGdUTXNDaGlDM2JRZ2E1ajQxOHFtblNFYXdMeU12bkpadXdK?=
 =?utf-8?Q?VAefXqJJ5oYROXLcTcF6bm1NhToNtV7RRCArcrfiDI=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbc84f9-7bca-44f2-f4f1-08de10c631a6
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 17:20:55.7982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzcqRwxPZLOgjuF+mTZf8dQ94WgG1xkEmhuI5F3wbAl/efcIIgCyjp7O/DbZpf0rcz3hxpWvgF/Dnnm0TJ24siqyWv2vn7fgRIIg+97e1jmzq0f9Xo/Q2XKmlBunMavH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR01MB9125


On 10/21/25 10:02, Sudeep Holla wrote:
> On Mon, Oct 20, 2025 at 01:22:23PM -0400, Adam Young wrote:
>> Answers inline.  Thanks for the review.
>>
>> On 10/20/25 08:52, Sudeep Holla wrote:
>>> On Thu, Oct 16, 2025 at 05:02:20PM -0400, Adam Young wrote:
>>>> Adds functions that aid in compliance with the PCC protocol by
>>>> checking the command complete flag status.
>>>>
>>>> Adds a function that exposes the size of the shared buffer without
>>>> activating the channel.
>>>>
>>>> Adds a function that allows a client to query the number of bytes
>>>> avaialbel to read in order to preallocate buffers for reading.
>>>>
>>>> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
>>>> ---
>>>>    drivers/mailbox/pcc.c | 129 ++++++++++++++++++++++++++++++++++++++++++
>>>>    include/acpi/pcc.h    |  38 +++++++++++++
>>>>    2 files changed, 167 insertions(+)
>>>>
>>>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>>>> index 978a7b674946..653897d61db5 100644
>>>> --- a/drivers/mailbox/pcc.c
>>>> +++ b/drivers/mailbox/pcc.c
>>>> @@ -367,6 +367,46 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>>>    	return IRQ_HANDLED;
>>>>    }
>>>> +static
>>>> +struct pcc_chan_info *lookup_channel_info(int subspace_id)
>>>> +{
>>>> +	struct pcc_chan_info *pchan;
>>>> +	struct mbox_chan *chan;
>>>> +
>>>> +	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
>>>> +		return ERR_PTR(-ENOENT);
>>>> +
>>>> +	pchan = chan_info + subspace_id;
>>>> +	chan = pchan->chan.mchan;
>>>> +	if (IS_ERR(chan) || chan->cl) {
>>>> +		pr_err("Channel not found for idx: %d\n", subspace_id);
>>>> +		return ERR_PTR(-EBUSY);
>>>> +	}
>>>> +	return pchan;
>>>> +}
>>>> +
>>>> +/**
>>>> + * pcc_mbox_buffer_size - PCC clients call this function to
>>>> + *		request the size of the shared buffer in cases
>>>> + *              where requesting the channel would prematurely
>>>> + *              trigger channel activation and message delivery.
>>>> + * @subspace_id: The PCC Subspace index as parsed in the PCC client
>>>> + *		ACPI package. This is used to lookup the array of PCC
>>>> + *		subspaces as parsed by the PCC Mailbox controller.
>>>> + *
>>>> + * Return: The size of the shared buffer.
>>>> + */
>>>> +int pcc_mbox_buffer_size(int index)
>>>> +{
>>>> +	struct pcc_chan_info *pchan = lookup_channel_info(index);
>>>> +
>>>> +	if (IS_ERR(pchan))
>>>> +		return -1;
>>>> +	return pchan->chan.shmem_size;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pcc_mbox_buffer_size);
>>>> +
>>> Why do you need to export this when you can grab this from
>>> struct pcc_mbox_chan which is returned from pcc_mbox_request_channel().
>>>
>>> Please drop the above 2 functions completely.\
>> This is required by the Network driver. Specifically, the network driver
>> needs to tell the OS what the Max MTU size  is before the network is
>> active.  If I have to call pcc_mbox_request_channel I then activate the
>> channel for message delivery, and we have a race condition.
>>
> No you just need to establish the channel by calling pcc_mbox_request_channel()
> from probe or init routines. After that the shmem size should be available.
> No need to send any message or activating anything.

I guess I can get away with that if I only do it for the type 3...that 
should not immediately send an interrupt.  I was thinking that the type 
4 could have messages queued up already, and when I request the channel, 
I get a flood that I am not ready for.

Ok, I think I can remove the function.



>
>> One alternative I did consider was to return all of the data that you get
>> from  request channel is a non-active format.  For the type 2 drivers, this
>> information is available outside of  the mailbox interface.  The key effect
>> is that the size of the shared message buffer be available without
>> activating the channel.
>>
> Not sure if that is needed.

Not needed.


>
>>>> +
>>>>    /**
>>>>     * pcc_mbox_request_channel - PCC clients call this function to
>>>>     *		request a pointer to their PCC subspace, from which they
>>>> @@ -437,6 +477,95 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>>>> +/**
>>>> + * pcc_mbox_query_bytes_available
>>>> + *
>>>> + * @pchan pointer to channel associated with buffer
>>>> + * Return: the number of bytes available to read from the shared buffer
>>>> + */
>>>> +int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan)
>>>> +{
>>>> +	struct pcc_extended_header pcc_header;
>>>> +	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
>>>> +	int data_len;
>>>> +	u64 val;
>>>> +
>>>> +	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
>>>> +	if (val) {
>>>> +		pr_info("%s Buffer not enabled for reading", __func__);
>>>> +		return -1;
>>>> +	}
>>> Why would you call pcc_mbox_query_bytes_available() if the transfer is
>>> not complete ?
>> Because I need to  allocate a buffer to read the bytes in to.  In the
>> driver, it is called this way.
>>
> Yes I thought so, I think we must be able to manage this with helper as well.
> I will try out some things and share.
>
>> +       size = pcc_mbox_query_bytes_available(inbox->chan);
>> +       if (size == 0)
>> +               return;
>> +       skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
>> +       if (!skb) {
>> +               dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +               return;
>> +       }
>> +       skb_put(skb, size);
>> +       skb->protocol = htons(ETH_P_MCTP);
>> +       pcc_mbox_read_from_buffer(inbox->chan, size, skb->data);
>>
>> While we could pre-allocate a sk_buff that is MTU size, that is likely to be
>> wasteful for many messages.
>>
> Fair enough.
>
>>>> +	memcpy_fromio(&pcc_header, pchan->shmem,
>>>> +		      sizeof(pcc_header));
>>>> +	data_len = pcc_header.length - sizeof(u32) + sizeof(pcc_header);
>>> Why are you adding the header size to the length above ?
>> Because the PCC spec is wonky.
>> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html#extended-pcc-subspace-shared-memory-region
>>
>> "Length of payload being transmitted including command field."  Thus in
>> order to copy all of the data, including  the PCC header, I need to drop the
>> length (- sizeof(u32) ) and then add the entire header. Having all the PCC
>> data in the buffer allows us to see it in networking tools. It is also
>> parallel with how the messages are sent, where the PCC header is written by
>> the driver and then the whole message is mem-copies in one io/read or write.
>>
> No you have misread this part.
> Communication subspace(only part and last entry in shared memory at offset of
> 16 bytes) - "Memory region for reading/writing PCC data. The maximum size of
> this region is 16 bytes smaller than the size of the shared memory region
> (specified in the Master slave Communications Subspace structure). When a
> command is sent to or received from the platform, the size of the data in
> this space will be Length (expressed above) minus the 4 bytes taken up by
> the command."
>
> The keyword is "this space/region" which refers to only the communication
> subspace which is at offset 16 bytes in the shmem.
>
> It should be just length - sizeof(command) i.e. length - 4


I just want to make sure I have this correct.  I want to copy the entire 
PCC buffer, not just the payload, into the sk_buff.  If I wanted the 
payload, I would use the length field.  However, I want the PCC header 
as well, which is the length field, plus sizeof (header).  But that 
double counts the command field, which is part of the header, and thus I 
subtract this out.  I think my math is correct. What you wrote would be 
for the case where I want only the PCC payload.

The giveaway above is the "offset 16 bytes." As this is the size of the 
header.



>
>>>> +	return data_len;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pcc_mbox_query_bytes_available);
>>>> +
>>>> +/**
>>>> + * pcc_mbox_read_from_buffer - Copy bytes from shared buffer into data
>>>> + *
>>>> + * @pchan - channel associated with the shared buffer
>>>> + * @len - number of bytes to read
>>>> + * @data - pointer to memory in which to write the data from the
>>>> + *         shared buffer
>>>> + *
>>>> + * Return: number of bytes read and written into daa
>>>> + */
>>>> +int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
>>>> +{
>>>> +	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
>>>> +	int data_len;
>>>> +	u64 val;
>>>> +
>>>> +	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
>>>> +	if (val) {
>>>> +		pr_info("%s buffer not enabled for reading", __func__);
>>>> +		return -1;
>>>> +	}
>>> Ditto as above, why is this check necessary ?
>> Possibly just paranoia. I think this is vestige of older code that did
>> polling instead of getting an interrupt.  But it seems correct in keeping
>> with the letter of the PCC protocol.
> Not needed IMO, lets add when we find the need for it, not for paranoia
> reasons please.

Will remove.  I think it is safely checked  by the pcc mailbox.


>>>> +	data_len  = pcc_mbox_query_bytes_available(pchan);
>>>> +	if (len < data_len)
>>>> +		data_len = len;
>>>> +	memcpy_fromio(data, pchan->shmem, len);
>>>> +	return len;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pcc_mbox_read_from_buffer);
>>>> +
>>>> +/**
>>>> + * pcc_mbox_write_to_buffer, copy the contents of the data
>>>> + * pointer to the shared buffer.  Confirms that the command
>>>> + * flag has been set prior to writing.  Data should be a
>>>> + * properly formatted extended data buffer.
>>>> + * pcc_mbox_write_to_buffer
>>>> + * @pchan: channel
>>>> + * @len: Length of the overall buffer passed in, including the
>>>> + *       Entire header. The length value in the shared buffer header
>>>> + *       Will be calculated from len.
>>>> + * @data: Client specific data to be written to the shared buffer.
>>>> + * Return: number of bytes written to the buffer.
>>>> + */
>>>> +int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
>>>> +{
>>>> +	struct pcc_extended_header *pcc_header = data;
>>>> +	struct mbox_chan *mbox_chan = pchan->mchan;
>>>> +
>>>> +	/*
>>>> +	 * The PCC header length includes the command field
>>>> +	 * but not the other values from the header.
>>>> +	 */
>>>> +	pcc_header->length = len - sizeof(struct pcc_extended_header) + sizeof(u32);
>>>> +
>>>> +	if (!pcc_last_tx_done(mbox_chan)) {
>>>> +		pr_info("%s pchan->cmd_complete not set.", __func__);
>>>> +		return 0;
>>>> +	}
>>> The mailbox moves to next message only if the last tx is done. Why is
>>> this check necessary ?
>> I think you are  right, and  these three checks are redundant now.
>>
> Thanks for confirming my understanding, was just worried if there is
> anything that I am not considering.
>
>>>> +	memcpy_toio(pchan->shmem,  data, len);
>>>> +
>>>> +	return len;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pcc_mbox_write_to_buffer);
>>>> +
>>>>
>>> I am thinking if reading and writing to shmem can be made inline helper.
>>> Let me try to hack up something add see how that would look like.
>> That would be a good optimization.
>>
> Thanks, I did try to write to buffer part but I am still not decided on
> the exact formating yet to share it. I will try to share something in
> next couple of days if possible.


Much appreciated.  I will hold off on resubmitting until you do.


