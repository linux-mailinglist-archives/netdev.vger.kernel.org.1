Return-Path: <netdev+bounces-234029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B87FC1B653
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 007FF349AA8
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D4D33B6D2;
	Wed, 29 Oct 2025 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="rcO6Q9nD"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2933A024;
	Wed, 29 Oct 2025 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748895; cv=fail; b=JFuuh2p0MXsOtmAehsWgALTKc00edkvh7NrRXwpE3OraN0b8bH/0inHccqGQZmc+NVqb2SG2XMIAj0lQnPPF/1V25H72SdYTNCdt+MRkDEEDb/GqW10ega0dAblz3w14NjXe6c5dfoxpD+hWbhALxX2kUBMWclJviCMtjT/bhbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748895; c=relaxed/simple;
	bh=m/8AKNTlDMhvIMs4hW8KGSzOvleuc9i7lLVXnSnB1N8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OHPZ7clRM5HREmlfnGpsPRxa8nBoqWj2gak/Lw6Tk7s64aiYu0gnFggW32B1wPRpZugtPAkIQCa/sq3rJpkpHmEvzmqiLJ0KfcuvNOfoiogh9funEYoYIv+pMJrgy+Esv5izJdKjCRXuZYzl64594T2KZfXvdglejEw4AvmbXt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=rcO6Q9nD; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHFuEp4XkRQSPeOuLEHSm0lBlMDbpTgIcGNh5IkP9Jr0KwLe7mWtTC4tNGee3yt4ibzPPcZ/ud4t0xlkEM4bxcrp6VvohujUs9MTQ72lczw4EdSmacIfZ1PNGaywOU65foreH26hk3utg79vAtL4W1tekX05gL54EDuJ2HC+WN57BTxyYF5Zkwzx+GI7TpaklsFfwYNXy2lSksYAw3uj8V6qYaXyCvBHidyTUU7EDycHWzh66CLJhH75f+f6gyyTRpu7c0BmDnxXXm/wAjwLwWD4+u+HYERFLfEdzRBTsUU0RaZ5ZNgWW4W7s8Km4nSeaz6KwNfwHg01981Ywzrzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW+1zlmlh8OEd4rW2Bdon6riMfa2dOqs9LnZ37sqAUQ=;
 b=e3hhqm1nTVI3YMwi/BRYx2KlFxDJvwg8oZnQ6GFXpZwnPSzN7980EoOQz5YwJXPV9LdE26H/iIzuQNMyxTNtCh2tAM5soQ8+9c6uyhZy8IuPzVA2GyaxSszdb7gR9/aG5W3G8OwmpV7UCCdoghRLdBOvq0gxQ2JfEAZ5fhmL6ngneVGRbnlCTAHi5+ZC6DgA138I05Hglz/3JhmFO37iUflHJHfxpjRoildAKzLxYGygOglKTZtsajf5sRIFNQPQ4YjUzyLADU/6KdhuRWuQOWRZpifqFx0k7WLWVJZu89k4rU0TOUOIYz5XqQdPrK4J51gHyR+ISWwbPtNBcPhFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW+1zlmlh8OEd4rW2Bdon6riMfa2dOqs9LnZ37sqAUQ=;
 b=rcO6Q9nDG7+kPqw9GbMWExo2DYYzLDSizdw3j8fkipcgEoQLKLKvDSxnd5ldHnAh4+kLzCrbHWYeqRUp8AJezzm8qEbgge4T288e6F/Ma5iBH2t2RR7Vk3jYzQ93ta6O5gPF0duJbfmebqkpzUw83iMil9PcIIcLC4yHu5i50PYzPjd5eEHXzUjOHI4PvCKdmrJL3ODyVj+wExI41nzMdVtPPiVeGmNrXgF7fTzaFDqPT5U+PuLBvVeNV/UpXzg8XrB7MT9sKiYUGN7Mu7s6biqw0+yNSMcbK0uhM2BGEb/thryoOtgmURxx1mpssxFUZKhnIoJBSkRRFHuM8TuveQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by PH0PR03MB6608.namprd03.prod.outlook.com (2603:10b6:510:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 14:41:30 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 14:41:30 +0000
Message-ID: <ed9e4ffb-3386-4a22-8d4c-38058885845a@altera.com>
Date: Wed, 29 Oct 2025 20:11:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net: stmmac: socfpga: Add hardware supported
 cross-timestamp
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
 <20251029-agilex5_ext-v1-4-1931132d77d6@altera.com>
 <07589613-8567-4e14-b17a-a8dd04f3098c@bootlin.com>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <07589613-8567-4e14-b17a-a8dd04f3098c@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::32) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|PH0PR03MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d3d2e5-54fa-493f-507a-08de16f93f16
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVVJM2xPYnh4TUNHbGhkdTZ2VVp3RHlpSXFCdWdEZGxwWHFCeUt3WnhzS1Q5?=
 =?utf-8?B?L296UzhUL2hxQWFiOFVDcnRVMTN0SXh0NHRvMi9Gc0hOODI4Z1c0Nk53VnFT?=
 =?utf-8?B?aGhOODh5N3ZNVUZsaDk3WTA3OFcxV3VIeG1tQWlBVFEwQ2s3RGd4ZEJmKzZE?=
 =?utf-8?B?T2Vybm9ldmV6TzdmN29VSDdVd2pHQjh2R1k5OWdGWDcrM2tmNFpMSEdZVDJE?=
 =?utf-8?B?T0hYUU5OckpqWmZaL050UnY1UVJkbG1sUWRaOWhZZHdkS05pV1R1SVFwT0dk?=
 =?utf-8?B?L0N5blZjL1pYKzhiZ09INEFaOUhwV1VLL1RVbVUveDRMUUVubHk5RnU1RHdC?=
 =?utf-8?B?WWc5RHdlNEUvOG8xZkNueDVOUlZ0RFBiRms2MjVqMHZWakZhMnBzN2Y1Y1E5?=
 =?utf-8?B?VXQvS3lrQnlHckswMXlCTDBEaFd6aUdqSWVhRWNnTHZOK2tWNjl3RWdhTkZB?=
 =?utf-8?B?VGNBZWx4aWlpL3NidlhzMEM5RE5qQnpKdnBpZEoxa1lRQTZjdmpaNmpGcXEr?=
 =?utf-8?B?bmd3R2Vkc3R6MDg0ODhWSnBLQk9WVXYvSzNVN1l6ZVpZZG1XMnZFVVd5cm5R?=
 =?utf-8?B?bXpMaVlYK1dEOElOb3lpa0ttZlJlQVF6NVV5cFpOdFZGU0hXdUJ3eUlRREFO?=
 =?utf-8?B?ZHI2Tkw5VUF1UEt3b3BvT0NocHd0Mm9FNWZ4d2lBdDZQOEVmRWlVaWg4SGd2?=
 =?utf-8?B?TFRVL3JxaGZzYXFYUGljNkdLOEZsdEYyOFQ3Q3ozb1hTYUFhQ1hWd1FKejJZ?=
 =?utf-8?B?cU5pSEwrTW0xV0VvTnU2ZHYxTWtDenBmcTlXVHUzMVgzYUJDQ2hYdTNGbXMy?=
 =?utf-8?B?VDByL1BtTHdJWTRvanE3NFdTaUtiOUxNeXNPSXhPZE13c3NrK3A3WGRDbGpo?=
 =?utf-8?B?ZGc1N04rYVB6dnBnYWRVYk5FVWNGUnhEeFQ2LzJlcWtVanJHWDNQYlU2K2ls?=
 =?utf-8?B?emF0cjFQRG5Dd0puZzBFYzNhbzZhK203M3BHd2lzOEIzRjdDZzFJajJ1OWx4?=
 =?utf-8?B?ZVlWQzNUbC9CMUYwVUVESTY2Y1ozSFJsTTUyZm9BUVZJWlJIWXdEMVkzT2px?=
 =?utf-8?B?SlhFNzMxcStCNXBPdFMxdDZpUGFQaXFSTUN2OFBCUVNZWVZNTFZ4aC84OTUz?=
 =?utf-8?B?QzBMMW9HNk5SYzA0ZDEvWW9nNVcrMGFTaUVhQ1JPNU9qSXRGcm55K1RWRUlQ?=
 =?utf-8?B?R0R1UjlrVDRYdXFGbDRXSUZkcEVQSHo2K0wyMS9YK2tKeUdvODVjQlRybW1L?=
 =?utf-8?B?c0k1MklyMjBXNGxzMFdpVDFCK0VtRXdFTkZtZHZoWjJBeWNZUXFiV1QwbFBu?=
 =?utf-8?B?YzQyaCtiRzBmYzlVMzhuY2tzd0NsMC9RTW53T3oybi9OMDdKc2h3MUNrWCs4?=
 =?utf-8?B?cnp5MmRTU2YzMjJ6VmphSXM4c2lEa3g3d0JKNWpGSk5nVnN1b00vOWE0TE04?=
 =?utf-8?B?blVuQm5mN29DTjcyTDYxTXFlYWFIajlXRTltUEF4cGIvamxGV2t1ZWxVRWNn?=
 =?utf-8?B?NmFpOUdocU5qbmw5TE5odWF5aWxpVTgyYTZ1U1hDTEYyYTNuQTNpeElzRVZ5?=
 =?utf-8?B?WlcvOFhJYkE4dWZxcDBoRFYvUUNYWTJDTGlRQ1lwK2dnY2RkVUlWd21FNUY4?=
 =?utf-8?B?RDVtV2hIUDJ2eTl6N3VFQUZDdjBGZG84OHJTdUpJbVFhVjRZWkk0MkpIcGxX?=
 =?utf-8?B?NUR0YldaMFZ3QlNyL0JOd3cwbjR3ckl1T0YyQk5KZW13cDNMT1kyRTZDMVZL?=
 =?utf-8?B?M1dMalZQMThKRjRHTmZtL3JJaTV1bUZCd2pPZXdHbzRmK2Uya2ZHYWpKcTVm?=
 =?utf-8?B?ZFFRcmtXbDgwWUpvazFhamt4d29menlBcjAxUHo4dnkyaHMwUWJvVDFrREJM?=
 =?utf-8?B?aGdUeS9JRmZuZGxMK3JNMVIxUnRzalNjYmxqT29vVWFHNFYxS214RkFQRGFF?=
 =?utf-8?B?UkZjMXVlUGtDWnhWOWczWXE2bzNabnVOdGFOVUlxUnE5U1F3Y091Yy9qUUQ4?=
 =?utf-8?Q?DIs0dQBNLuupAEE3I/jLrYeuylpmKY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azJPQytzQmk3MEtIaUdaMTdhclR2UmdDVVppM2V4aFJIUWdPODBlUnA1TW83?=
 =?utf-8?B?T1JUM2s4aXFMdGhiUHBYOTB2emFDUFpSYWh1blNDTEErR1pmdWI1bFJKODFu?=
 =?utf-8?B?NXpaTk1DSm8vMnBhMk41VHQ1T2hibDJuUURTeTFPU0IxSHVJSFdpRGFUVjJ1?=
 =?utf-8?B?aVBpS3krbmVOU1dHWDdVVjB4dmN3VDdNRDhhaGFOQUJON1h5NEFpcTE4d0xy?=
 =?utf-8?B?bTlkN2MxQ3NrTEhBSjlGdDJvMHVqMXVvMUxmaFIyOWNGdHU0SnlPNzNUSExr?=
 =?utf-8?B?WlUwdVg5MDcrSGZQeGZxSmt1OTVwSmFON0U3QjBNWDhFOU9MalZyNFp4d1VL?=
 =?utf-8?B?Ykg2OWNqajJtLyt4OXRZejlrb1NqbjlvaWhwcUFDbnlGMUFXSXdtaXorSjFW?=
 =?utf-8?B?VS9KM0ZMNDZoSWduZVVoajJaRnRvWEtaM2k3WmlwU0thM1RUZ09GQ2Nmb2Jr?=
 =?utf-8?B?cStGWTF5OFZDUVJsR2FlZ2p5Rk11RmlWbWJPaWNKYUdSK0dOZUtEVkhSMzda?=
 =?utf-8?B?RGhvM005S0NBMFlZQzg0US9RYmV5UXQ1YXE0TVV1UmRvckthTW1UN01JQzNX?=
 =?utf-8?B?ZnZaNmFLa1d1NWRxb3piTHBGZzROTzZjc3JFU3djY2ViVithV29WUDJSR0tE?=
 =?utf-8?B?U0IyRjlGL3dYcStQNnRiMjQ2cisxZUt5T0IxeEtpRXdrZmtmaEdSUEVDdUJV?=
 =?utf-8?B?SjBVYy82NTgybk1wSFFFby9OK2cxQy9FVnlkWWRIek5iMVZlR2U5Si9jRDVH?=
 =?utf-8?B?Vkx0MGY1SU5JQzY2YXNlWGZJWGNGUSt0ZmFtTlN1dzdQbkpDMW80WmJabDI5?=
 =?utf-8?B?MTFodEN5ZllhQklYemZyWFhqZ1phd0g3S3RVdXRjZTVYdXVaQTF6aEc0UWlt?=
 =?utf-8?B?L3FLdUwzNldNYmtuWmczKzUvUWMwRjB4LzNIZk9tQitMS0NlTjJtQlYyd0p2?=
 =?utf-8?B?bWxMbXpmYlI3Z2VmUUs5R0ViUEw3L1hVN0hPa0ovU0pSalBrTnJFeUJrWHNY?=
 =?utf-8?B?OU1WVk5ycW16SEFSdVJlNVdqMUJmQ0tTdVVrWU5wYUpwdkU5VzZtRUdDWndZ?=
 =?utf-8?B?U0IzMjNsa2JwTC9ERDBPd2VxMmc2SFFqQzVTVFBoalVXSHBwbDFJa0hldzlC?=
 =?utf-8?B?V1RJOGk3NVVDV0QxMldweE1kZ1g0KzBTaHZ0WDRsS2YyVjZYRHd0M0l2eS9h?=
 =?utf-8?B?TVllVXhBcEwwR3M0R044alJUWDA4QVVKTzJMR1JNTXc2cG9sTXlZckdmVVJE?=
 =?utf-8?B?OUhwa0pyQVJXN294RGRDWmxabzViUWlqakltb2prQjcwTStPVzdBYmE1cmZ3?=
 =?utf-8?B?Y2x2QVQyRzJZMmdXWk5DVi9CSisyNXlhbDk2N0p2dnNJN0kxeU1McTVxdzVZ?=
 =?utf-8?B?TU5jbjJQSkV3MDlxdS9CQ2ZVK2E5RUI3YXpEdVRTR1ROTUdlMjlNT1l0OWZN?=
 =?utf-8?B?T0ZoL1h2NVpYem1RU3hoTE0yOFc3eGsvNHhuMlhqZkh3ai9lRFp2UWlrajlL?=
 =?utf-8?B?RUczekZYbm5tQ1Y1U2x4LzBHOU8wbWFjV3dSZWQ4MjU3MVhDVEJpNGlHMkh4?=
 =?utf-8?B?MitBVWhSd2ZSbG5ENlB6YkJJZksvbTkyNEtISWtvQXROWmJtVlQxRDRDM3Y1?=
 =?utf-8?B?UTc3dFZtejU2MjUzVHpabVN6R0ZpVGY4UVZyZ0dwRlNtdkRYWmo3Q3lMWmp3?=
 =?utf-8?B?ZTZrSDcvLzV0dGFHakFwOVZLc2tvVW45UlFEdlF2Zjc4WnA4STFSa0d5d0Zu?=
 =?utf-8?B?Z1BDVFBNUWJyYThNbXpucjNBVTZtQWp3Um9SdVM5MnFHcit1N0hqTzJ6WkVk?=
 =?utf-8?B?eVNPQkN0bkhJcGtrZTZnNzJ3b2tZYjFhbXluSDVnNVRmalVHc1Y5bzBMVUh5?=
 =?utf-8?B?WXJDamRMczNWLzZFQnZjU1ZUUVd2d1UzMUt2S3Ezck9aY0hNeXJZaEZ5U3Fp?=
 =?utf-8?B?cGdCVWZGdGZNWFg3UWphMWVxbkZYa3F1ZDFBTzZ1UTl1OVRlZWF3YTNTZGJu?=
 =?utf-8?B?R2dkZndLNmNabXpVVkRkdWV4RURDS2NFd1JFRUdVZjJXUGw1SG5VTHc0S1ow?=
 =?utf-8?B?bUQxdmZtdDZkRldrcVh4eVAxME5vSzl5WEpaV2pvd1d4cThIWGJsOUdodzFK?=
 =?utf-8?B?VEtNc0NPR0xkNjZwK1hxYWZDY1JwNURNbGdEbkNHdkNTK2RTd2FuQVRDS1Ro?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d3d2e5-54fa-493f-507a-08de16f93f16
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 14:41:30.0176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLMxJ96OkSvJa3hcRRm70ZDKg7JwNJ+bnyNsNuBYx+PIYEiEvIiLUTRajbLf7VOAI9PVgBAKMGInKbrclD35fgDcG8Nx+7JzmEoOgvwXRXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6608

Hi Maxime,

On 10/29/2025 3:20 PM, Maxime Chevallier wrote:
> Hi Rohan,
> 
> On 29/10/2025 09:06, Rohan G Thomas via B4 Relay wrote:
>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>
>> Cross timestamping is supported on Agilex5 platform with Synchronized
>> Multidrop Timestamp Gathering(SMTG) IP. The hardware cross-timestamp
>> result is made available the applications through the ioctl call
>> PTP_SYS_OFFSET_PRECISE, which inturn calls stmmac_getcrosststamp().
>>
>> Device time is stored in the MAC Auxiliary register. The 64-bit System
>> time (ARM_ARCH_COUNTER) is stored in SMTG IP. SMTG IP is an MDIO device
>> with 0xC - 0xF MDIO register space holds 64-bit system time.
>>
>> This commit is similar to following commit for Intel platforms:
>> Commit 341f67e424e5 ("net: stmmac: Add hardware supported cross-timestamp")
>>
>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
>> ---
>>   .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 125 +++++++++++++++++++++
>>   drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   5 +
>>   2 files changed, 130 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>> index 37fcf272a46920d1d97a4b651a469767609373b4..d36c9b77003ef4ad3ac598929fee3f7a8b94b9bc 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>> @@ -5,6 +5,7 @@
>>    */
>>   
>>   #include <linux/mfd/altera-sysmgr.h>
>> +#include <linux/clocksource_ids.h>
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>>   #include <linux/of_net.h>
>> @@ -15,8 +16,10 @@
>>   #include <linux/reset.h>
>>   #include <linux/stmmac.h>
>>   
>> +#include "dwxgmac2.h"
>>   #include "stmmac.h"
>>   #include "stmmac_platform.h"
>> +#include "stmmac_ptp.h"
>>   
>>   #define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII 0x0
>>   #define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RGMII 0x1
>> @@ -41,6 +44,13 @@
>>   #define SGMII_ADAPTER_ENABLE		0x0000
>>   #define SGMII_ADAPTER_DISABLE		0x0001
>>   
>> +#define SMTG_MDIO_ADDR		0x15
>> +#define SMTG_TSC_WORD0		0xC
>> +#define SMTG_TSC_WORD1		0xD
>> +#define SMTG_TSC_WORD2		0xE
>> +#define SMTG_TSC_WORD3		0xF
>> +#define SMTG_TSC_SHIFT		16
>> +
>>   struct socfpga_dwmac;
>>   struct socfpga_dwmac_ops {
>>   	int (*set_phy_mode)(struct socfpga_dwmac *dwmac_priv);
>> @@ -269,6 +279,117 @@ static int socfpga_set_phy_mode_common(int phymode, u32 *val)
>>   	return 0;
>>   }
>>   
>> +static void get_smtgtime(struct mii_bus *mii, int smtg_addr, u64 *smtg_time)
>> +{
>> +	u64 ns;
>> +
>> +	ns = mdiobus_read(mii, smtg_addr, SMTG_TSC_WORD3);
>> +	ns <<= SMTG_TSC_SHIFT;
>> +	ns |= mdiobus_read(mii, smtg_addr, SMTG_TSC_WORD2);
>> +	ns <<= SMTG_TSC_SHIFT;
>> +	ns |= mdiobus_read(mii, smtg_addr, SMTG_TSC_WORD1);
>> +	ns <<= SMTG_TSC_SHIFT;
>> +	ns |= mdiobus_read(mii, smtg_addr, SMTG_TSC_WORD0);
>> +
>> +	*smtg_time = ns;
>> +}
>> +
>> +static int dwxgmac_cross_ts_isr(struct stmmac_priv *priv)
>> +{
>> +	return (readl(priv->ioaddr + XGMAC_INT_STATUS) & XGMAC_INT_TSIS);
>> +}
>> +
>> +static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>> +			    void *ctx)
>> +{
>> +	struct stmmac_priv *priv = (struct stmmac_priv *)ctx;
>> +	u32 num_snapshot, gpio_value, acr_value;
>> +	void __iomem *ptpaddr = priv->ptpaddr;
>> +	void __iomem *ioaddr = priv->hw->pcsr;
>> +	unsigned long flags;
>> +	u64 smtg_time = 0;
>> +	u64 ptp_time = 0;
>> +	int i, ret;
>> +
>> +	/* Both internal crosstimestamping and external triggered event
>> +	 * timestamping cannot be run concurrently.
>> +	 */
>> +	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
>> +		return -EBUSY;
>> +
>> +	mutex_lock(&priv->aux_ts_lock);
>> +	/* Enable Internal snapshot trigger */
>> +	acr_value = readl(ptpaddr + PTP_ACR);
>> +	acr_value &= ~PTP_ACR_MASK;
>> +	switch (priv->plat->int_snapshot_num) {
>> +	case AUX_SNAPSHOT0:
>> +		acr_value |= PTP_ACR_ATSEN0;
>> +		break;
>> +	case AUX_SNAPSHOT1:
>> +		acr_value |= PTP_ACR_ATSEN1;
>> +		break;
>> +	case AUX_SNAPSHOT2:
>> +		acr_value |= PTP_ACR_ATSEN2;
>> +		break;
>> +	case AUX_SNAPSHOT3:
>> +		acr_value |= PTP_ACR_ATSEN3;
>> +		break;
>> +	default:
>> +		mutex_unlock(&priv->aux_ts_lock);
>> +		return -EINVAL;
>> +	}
>> +	writel(acr_value, ptpaddr + PTP_ACR);
>> +
>> +	/* Clear FIFO */
>> +	acr_value = readl(ptpaddr + PTP_ACR);
>> +	acr_value |= PTP_ACR_ATSFC;
>> +	writel(acr_value, ptpaddr + PTP_ACR);
>> +	/* Release the mutex */
>> +	mutex_unlock(&priv->aux_ts_lock);
>> +
>> +	/* Trigger Internal snapshot signal. Create a rising edge by just toggle
>> +	 * the GPO0 to low and back to high.
>> +	 */
>> +	gpio_value = readl(ioaddr + XGMAC_GPIO_STATUS);
>> +	gpio_value &= ~XGMAC_GPIO_GPO0;
>> +	writel(gpio_value, ioaddr + XGMAC_GPIO_STATUS);
>> +	gpio_value |= XGMAC_GPIO_GPO0;
>> +	writel(gpio_value, ioaddr + XGMAC_GPIO_STATUS);
>> +
>> +	/* Time sync done Indication - Interrupt method */
>> +	if (!wait_event_interruptible_timeout(priv->tstamp_busy_wait,
>> +					      dwxgmac_cross_ts_isr(priv),
>> +					      HZ / 100)) {
>> +		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
>> +		return -ETIMEDOUT;
> 
> Don't you need to set priv->plat->flags |= STMMAC_FLAG_INT_SNAPSHOT_EN first?
> Otherwise, timestamp_interrupt() in stmmac_hwtstamp() won't call wake_up()
> on the wait_queue.
> 

Thanks for pointing this out. My intention was to use the polling
method, but I accidentally left behind some code from experimenting with
the interrupt method. While reverting those changes, I missed updating
this part of the code. Will fix this in the next revision. Sorry for the
error. Currently not seeing any timeout issues with polling method on
XGMAC IP. Also some spurios interrupts causing stall when using
the interrupt method in XGMAC.

>> +	}
>> +
>> +	*system = (struct system_counterval_t) {
>> +		.cycles = 0,
>> +		.cs_id = CSID_ARM_ARCH_COUNTER,
>> +		.use_nsecs = true,
>> +	};
>> +
>> +	num_snapshot = (readl(ioaddr + XGMAC_TIMESTAMP_STATUS) &
>> +			XGMAC_TIMESTAMP_ATSNS_MASK) >>
>> +			XGMAC_TIMESTAMP_ATSNS_SHIFT;
>> +
>> +	/* Repeat until the timestamps are from the FIFO last segment */
>> +	for (i = 0; i < num_snapshot; i++) {
>> +		read_lock_irqsave(&priv->ptp_lock, flags);
>> +		stmmac_get_ptptime(priv, ptpaddr, &ptp_time);
>> +		*device = ns_to_ktime(ptp_time);
>> +		read_unlock_irqrestore(&priv->ptp_lock, flags);
>> +	}
>> +
>> +	get_smtgtime(priv->mii, SMTG_MDIO_ADDR, &smtg_time);
>> +	system->cycles = smtg_time;
>> +
>> +	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
>> +
>> +	return ret;
>> +}
> 
> Maxime
Best Regards,
Rohan



