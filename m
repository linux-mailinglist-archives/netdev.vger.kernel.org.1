Return-Path: <netdev+bounces-169673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31492A45368
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30CA19C25CE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CB621C9F4;
	Wed, 26 Feb 2025 02:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jwfVNlJK"
X-Original-To: netdev@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011028.outbound.protection.outlook.com [52.103.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749A42070;
	Wed, 26 Feb 2025 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537972; cv=fail; b=Z5o+LfPMGQV74oA/W6Ife3hcnfNX54PQ+i3IVse329T0AW1++8ukIr5rRRxcHIvsV+s0iS1NJ3BhltvCEG9ORDA6wd8PMCw/rj8q9AI6jd51HDfSMc2ZBIPG+HZKpL0mZRWj0YQDTic3nssX9PfQmGQDlpIKVzi+86LAbNYgBeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537972; c=relaxed/simple;
	bh=t5Iza2KClF2G+kvCiwnSz3KuNR+MeM/XV2K0/8WgQGw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=piIo/82Iad9r+mu+wgpuFobKXiFCQ1pZPpGfhgBrmQM7UQlOia02nL+gwYVQtI12NuFogXeUeGG1dAFiTMJ7NFz/qK2OUVoYCNlwLvJ06BK2Qw8fD4fxfeVLDHn+ds8T4CRkeg5scDdTMuVwmQaBLR1OcFOwUamJCcpHkatQ1XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jwfVNlJK; arc=fail smtp.client-ip=52.103.67.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvRGX7xlx+5OngxfYVzt9+lpjMJadSpZt5HlzNfRj4P1E7wQmVoq3DfRY5iF5d4g1r5Oa+J84L3K0QwRM9sIQzF30iRXYQE209ZmCGItU04wZgCOlPkIQrvO7zm3lKJEJhztfBsX0tSHIyMxT1QCd4uBcI1fDAUIMsHwQYVVTVDNTENxUVZlK/NF8IJUoXH52Dg2/BSSJI+okLn4ETkjYqgR8xfDW1V7X9HCAAukobpxM5gtAYV3Ibc8wue5ld2nVTYGVrIcUd0AAqpdLZ/TsRT9wI0YeXN84/hKDjIGDgeZ4uYvjcIHrRmJDxWlrwliy+LtV850TOQk6tryOFxobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAQYD4FWf+tiWph/r25VXtl+6d4X61yhYUPXaTxbufA=;
 b=NBLixw+y6YLUj1pdSg6Aq2uNtoGZ2OxH5QdDH8E+U/0QY2N8SWP2QkbzyJJdK3N+JltfsL3x+hDuiFIqQBwriVuL5qmp/OSV2R9t0koJt5r2SvtFuisYDTtqkRJ1Ad1CpcFAAlh1oW0zR0ZFv0PMio2G9m3gcmr51FyovFVBJ3NVscKdwk4BrLZeSX8SZuCn2NNZhAnv6w4aYzBV65aJ2WSPQeXeTgRdXVQW/ZJeMAEZomAm7Fog28wsY3wpUZ8fiAus2W5YOz2jmqUaCTXH507vEs+TBKFye9QWoVQ2j0S1AzpIg6Ad9Gxw4MSeXec+kSfhwoI1rA7cArimznuB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAQYD4FWf+tiWph/r25VXtl+6d4X61yhYUPXaTxbufA=;
 b=jwfVNlJKg/DRIfSuJEN36jQWlZW6yge9JTCndaqVx48+/Cmiz+9EFULS7YWi0KlGNIMf8u+mN5rUGQRLXCpZ0uvyIx6D8w5SkCW7DLo0QpREcpkkOJcCgbXg5rODR7y14GRmrB22k9KYB8cwCI3n5pN29y+g17o712ki9rhoIFD8txFWzzOnzLpvcNiKOO+oz7EWmUacu9DvqA882WFSNU5svA3/ZN0gvhscNTZ1rjoCgv2y7E3/lrr2tnOITq20CrV6Qe0V2By0flWuUnJXRgqng0L3tCKkOZAx7IbeKxz8lHeph7BggsyojC/y9xB15DMMwzha9Ntw4VYLupsEbA==
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:165::9)
 by PN2PR01MB9361.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Wed, 26 Feb
 2025 02:45:59 +0000
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e]) by PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 02:45:59 +0000
Message-ID:
 <PN0PR01MB9166785CF0D9CE00437BEB0CFEC22@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 26 Feb 2025 10:45:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: sophgo: add clock controller
 for SG2044
To: Inochi Amaoto <inochiama@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250204084439.1602440-1-inochiama@gmail.com>
 <20250204084439.1602440-2-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250204084439.1602440-2-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:165::9)
X-Microsoft-Original-Message-ID:
 <c7c744bd-07aa-451a-b60b-8143c76e974a@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9166:EE_|PN2PR01MB9361:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db781f3-a56d-482a-4dd1-08dd560fb337
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|15080799006|7092599003|19110799003|8060799006|461199028|1602099012|10035399004|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlMwM0xLTXNYdk9ZbUdlcU1nVUpNcC9RcFY1bkFMdU1IZVlNZ1UvT2l2aHg1?=
 =?utf-8?B?eTkxMTlzUUxWUEx2VFVoTWMwWmpvUWdMVFdaUG9NZUhFWm16TERrbEl5UzEv?=
 =?utf-8?B?TG1GY1B3MjNMUHg2dkllY1ZQWXdoMTRtOGx2WUZmMWxYbnVGa3pBN2JtWGtO?=
 =?utf-8?B?L3ltdGV2THRtRlp1enY3aTlVbVIyQnBtR1hWSVBwVmlFNFRpN080cmt0SHpS?=
 =?utf-8?B?UG9vMm9JaTh0ZWg0RlNyYUxjcVlTTkFBbFBINlN3VlV4d0NvQVlQTURCdWRD?=
 =?utf-8?B?eVFRaHkzcDcwVzlPU1BKbmxuM1RtSHpxTmxTYXR4YnNoenA1SkNrRjJmVXlY?=
 =?utf-8?B?N0cvWmNCV3NhMytxckx5VGt0Zjc3cXZwUm1uUUxZd1BJSHlkSiszV25zaU5D?=
 =?utf-8?B?azAzb0w3MXdCUm50VStrV0k4ZXovbFR2RElLUTRzWmcrcnNsU3VyclRBZDZY?=
 =?utf-8?B?RHhQcng4Q0xGenN2OTViTVRNR0twZ2grWmtzSmcyWlgzTW1nbitIOUpPd2Js?=
 =?utf-8?B?SFB0d3RBVXpNNmxvQy8rVFNFRm9obUlCVmVEMHduVmJqYVdJdGhxODZLSm9M?=
 =?utf-8?B?eGRRV1I1d1lSQTk4UXdtcUNPY1A3RXpHSFYwd3BOdGh4WURPQzgrNWNWTmdh?=
 =?utf-8?B?Ykc3UnNHMTRiM1QxdWtHdWxiYWdlOWFqSmFUOE90L0FnS3o3dlJyUWUyRUhB?=
 =?utf-8?B?a3YvWStnQXRqU3pwN09OemNEdm9xZFhpVEppK3l0R0o5Ylp6akt5bzQwUDNM?=
 =?utf-8?B?a2xFNEFwZzZlMDB4Uk5nNEdFbVQxZkFndUNBREZEUEdLTUl4OU9GazRYcnUv?=
 =?utf-8?B?WC81eS82Um8vQjd6ZURibThZamVaMmNQSnk0K2dUK2VLaDZHbTMyS3RxNENY?=
 =?utf-8?B?VWNGb05xREpRRG1NVG9MYXJSNjY1dUJlSUZKM1gzY1pUV3ZmYm1sVVRqM01r?=
 =?utf-8?B?aXgwZTduZGs4Rmc0WElJYXdiSXZYemMzYUNlR3NQSXdSZmFjT1NrYm5kV0xj?=
 =?utf-8?B?MmUvSm9leEVEcHBHNVVpWnhFamNrd3ZYVWF4aDJqOU9qaUwwT2oyODVDVm5a?=
 =?utf-8?B?VFBlbGU0UFpjUmlnYWpRSHJzdVZyYWtCNWozQlZ6cUpWNGJJMSt4SUpnTUVp?=
 =?utf-8?B?emJHb2UzY3p0UlE0bEVkUFdUQnl1Y0oxTmtGVE04T3huZnhJd09oaHFtbjRy?=
 =?utf-8?B?Wm1OU0pKRlZiaU1UdllZVmMwQ3dBMWlORkRYVHRBd3dkSnhPN2MxNjl4eVpQ?=
 =?utf-8?B?YjNORXRMdHUxaGpJZjVXd2VFL3liMGM5NFdSTDR6d1ZlTXB4cjR5QnpEZ1FO?=
 =?utf-8?B?aWg2U2E3VWt6NVVYbWZmM01MdTluRXB6YThuMUkxNWY5RmxwK1lxSjloVmtR?=
 =?utf-8?B?Z0dKWmc4TjNLRkRmaHQreGI1ekNUUWFRbVpZbG1keXFsVU9EcjBlNHQvblQ1?=
 =?utf-8?B?VDhiMVMvdUZtL1J6NlM5cUo3eTVJdGR0TS9NZWR4c05YaWpYNC91ZUx5YkdX?=
 =?utf-8?B?U0VmYWtIbXptVnNmYkVBbkZUeVc4dXo2Q0oxK2NYN1BwS1F2Z2hmZHVKd2F2?=
 =?utf-8?B?cUQ0ZGR3NlJITEJqUnhDcnFaWUg5dXlLUXNVYWg1ZkpaQStVR3FUenZwTXRB?=
 =?utf-8?Q?28HvfpDUGGqcVpmTrNFG2jzgj2OSP5s79wsTmgrn0Xsk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDN2cGFacTVNMkljU3lxM2RxOGNDalVvNzFRa0xLMjgrWjVFMUkwR0JDR1ZP?=
 =?utf-8?B?S1VpL3lSQ3VZVVNMU0FJQ1hwTFQyRnM2QnVtRFNkZm9DcHNSb1lEYW5CYjVu?=
 =?utf-8?B?MS9kR1p6ZGc1N3FOQzUrSFF1bjk1cVZzeU5KR3VoeG00T2ZIejMxRXIrN2RL?=
 =?utf-8?B?QjNCRzVWaWNYTkpDQ0FRWG53V2dJWDhPLy9scXNKbmlqTE53cFhtS1hOZGt2?=
 =?utf-8?B?SDRiK2VaczB0aDB2c0xrVDdCS3RtZUt1NTlEVk1jMFl2RzFlQ0NJM1hBNEtH?=
 =?utf-8?B?amc0b0JkYU5acURoTHNnWFY5S1dhbDBWc3MxR3IzUDdhb3ZUYUMwRndYVWdJ?=
 =?utf-8?B?QmJHOUdaUXB3STBZdmJEcnYrQ2xVQ1kvV3VyTXlyZ3lXSmkrNXVkRGlqeWht?=
 =?utf-8?B?SGdtaXFmK2h6bXJXQ0pyQjlNL3ZzeWh3RVRLL3ZwS2xvREVrTjBwTGwvNlhG?=
 =?utf-8?B?QURscTBtT0swamlFVllLMGcxZkpxVmRWd3B1bDlyTTlQdjBnU0c5NFRMQ3I4?=
 =?utf-8?B?M1phSjN1ZXZRNmhxVW1mL29FSDZVdGlJZzU5WnZqcEFvYXpLcjQrSXFjWWRv?=
 =?utf-8?B?V2FIenhyT2xIclFxTUNXdlA5Uy85YUtGbXJBaHVqVTdQZXJqeHdDalV6Ty84?=
 =?utf-8?B?VDlMUjhjb3RkMTVIektnSzZCVnJSd20rcEN3eXVleFJSSkFJTytmNis0OCtH?=
 =?utf-8?B?a2ZYdnhOR0RWbmNHV082RjJKdmtPdk43elZQYWRoMFhoTHhiN2x3Ny9NNXd3?=
 =?utf-8?B?bmRyZWZjWDdMTEdaN0NINEZTeGZiOHhRYXJ2ZERXNWd0SmlaRWt2QkUrUFEv?=
 =?utf-8?B?ZC9rU0V5a3FuVGdlSkJUaVR2RDhJMERTRGR2akxxckg3WEEzZk5ObjZaaTZr?=
 =?utf-8?B?SFpoWEV3M2dBM2hUb3c1RnFkdTh6cHpEcDY4ZE5CRWhoZ2Q0RSs2TU9uWmUy?=
 =?utf-8?B?ZTd0azExQWs1T0FNK1VkOUx5RGdiNk43VUtPaGJEZ3M0Q2RTeGJiWmF4aTJM?=
 =?utf-8?B?RGg5Mkd2aUlRbE5mWGx4QlBHNDgxZEhyL1JEMnVCOU5GMCt5eE1UUnlMbmZp?=
 =?utf-8?B?SGtRNG93b1MxanZRb3gxc2IyZWVNVU16cjZNMW9Xbm5Vd3RhZ3RIT2F2cjQx?=
 =?utf-8?B?eGw4Z2dZNnh6NUQ1bnZ0YkJXWW9HR3lYeUR6dENubEJ1aWRlanZlTnllanJF?=
 =?utf-8?B?alE5SmY3NlJqVTV2YXM5SHh3VndNdDYzTmlVZDgwS3UxZkJyYUdhWlhSRWNX?=
 =?utf-8?B?RWx0QndpNjRqaStPTk5meEJVK1B3eUxxVlIrQ0ZXUUxkeFJtcUM3ZDBIcFlv?=
 =?utf-8?B?ZHpVTkF0TzhLQ08rbzl3MFJiRlI4aEZkcXZKeTFtNUNPcVFmZ2xSNG1mWEhj?=
 =?utf-8?B?Ukh5bTZSWC84Q2ZKcURWN0t6eXgwSy8yMDRodUJEdVRyV0dmRWFNbWRlS3E2?=
 =?utf-8?B?RzRKMUNBU3l4aXBQampyM05tcFVPL1UxM2dPQUxhMUc1WkVkRWNkVnp1Z3VP?=
 =?utf-8?B?Ympna3ppTXRuc3IwY09tTEFrbUE1emNTNjROMHRlV1JaRDA4Yk01dm9mM0ZS?=
 =?utf-8?B?dzhuTXJlMGZ1V2gvbkQrT0pMQVpMdWtFQ0tnZEN3UEhsbkk2em9BT0lKT2h3?=
 =?utf-8?B?MEp2c0x0aDR3YzZrY2NkZyt2RFU5U1dwOHhsTjh0VEpUTm5QK2liekFEa3pJ?=
 =?utf-8?B?QStlT1gwVVVtUmxvUTZ4c0VwWXZ0N3RzZENJQ2w5RFBhYnRZLzRDdE1SMDdQ?=
 =?utf-8?Q?LR+wrRtAkrTd/ExOXJurgiekfHj90d8DnbRztB1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db781f3-a56d-482a-4dd1-08dd560fb337
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 02:45:59.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9361


On 2025/2/4 16:44, Inochi Amaoto wrote:
> The clock controller on the SG2044 provides common clock function
> for all IPs on the SoC. This device requires PLL clock to function
> normally.
>
> Add definition for the clock controller of the SG2044 SoC.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   .../bindings/clock/sophgo,sg2044-clk.yaml     |  40 +++++
>   include/dt-bindings/clock/sophgo,sg2044-clk.h | 170 ++++++++++++++++++
>   2 files changed, 210 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
>   create mode 100644 include/dt-bindings/clock/sophgo,sg2044-clk.h
>
> diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
> new file mode 100644
> index 000000000000..d55c5d32e206
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/sophgo,sg2044-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2044 Clock Controller
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2044-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@50002000 {
> +      compatible = "sophgo,sg2044-clk";
> +      reg = <0x50002000 0x1000>;
> +      #clock-cells = <1>;
> +      clocks = <&osc>;
> +    };
> diff --git a/include/dt-bindings/clock/sophgo,sg2044-clk.h b/include/dt-bindings/clock/sophgo,sg2044-clk.h
> new file mode 100644
> index 000000000000..1da54354e5c3
> --- /dev/null
> +++ b/include/dt-bindings/clock/sophgo,sg2044-clk.h
> @@ -0,0 +1,170 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> +/*
> + * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
> + */
> +
> +#ifndef __DT_BINDINGS_SOPHGO_SG2044_CLK_H__
> +#define __DT_BINDINGS_SOPHGO_SG2044_CLK_H__
> +
> +#define CLK_FPLL0			0
> +#define CLK_FPLL1			1
> +#define CLK_FPLL2			2
> +#define CLK_DPLL0			3
> +#define CLK_DPLL1			4
> +#define CLK_DPLL2			5
> +#define CLK_DPLL3			6
> +#define CLK_DPLL4			7
> +#define CLK_DPLL5			8
> +#define CLK_DPLL6			9
> +#define CLK_DPLL7			10
> +#define CLK_MPLL0			11
> +#define CLK_MPLL1			12
> +#define CLK_MPLL2			13
> +#define CLK_MPLL3			14
> +#define CLK_MPLL4			15
> +#define CLK_MPLL5			16
> +#define CLK_DIV_AP_SYS_FIXED		17
> +#define CLK_DIV_AP_SYS_MAIN		18
> +#define CLK_DIV_RP_SYS_FIXED		19
> +#define CLK_DIV_RP_SYS_MAIN		20
> +#define CLK_DIV_TPU_SYS_FIXED		21
> +#define CLK_DIV_TPU_SYS_MAIN		22
> +#define CLK_DIV_NOC_SYS_FIXED		23
> +#define CLK_DIV_NOC_SYS_MAIN		24
> +#define CLK_DIV_VC_SRC0_FIXED		25
> +#define CLK_DIV_VC_SRC0_MAIN		26
> +#define CLK_DIV_VC_SRC1_FIXED		27
> +#define CLK_DIV_VC_SRC1_MAIN		28
> +#define CLK_DIV_CXP_MAC_FIXED		29
> +#define CLK_DIV_CXP_MAC_MAIN		30
> +#define CLK_DIV_DDR0_FIXED		31
> +#define CLK_DIV_DDR0_MAIN		32
> +#define CLK_DIV_DDR1_FIXED		33
> +#define CLK_DIV_DDR1_MAIN		34
> +#define CLK_DIV_DDR2_FIXED		35
> +#define CLK_DIV_DDR2_MAIN		36
> +#define CLK_DIV_DDR3_FIXED		37
> +#define CLK_DIV_DDR3_MAIN		38
> +#define CLK_DIV_DDR4_FIXED		39
> +#define CLK_DIV_DDR4_MAIN		40
> +#define CLK_DIV_DDR5_FIXED		41
> +#define CLK_DIV_DDR5_MAIN		42
> +#define CLK_DIV_DDR6_FIXED		43
> +#define CLK_DIV_DDR6_MAIN		44
> +#define CLK_DIV_DDR7_FIXED		45
> +#define CLK_DIV_DDR7_MAIN		46
> +#define CLK_DIV_TOP_50M			47
> +#define CLK_DIV_TOP_AXI0		48
> +#define CLK_DIV_TOP_AXI_HSPERI		49
> +#define CLK_DIV_TIMER0			50
> +#define CLK_DIV_TIMER1			51
> +#define CLK_DIV_TIMER2			52
> +#define CLK_DIV_TIMER3			53
> +#define CLK_DIV_TIMER4			54
> +#define CLK_DIV_TIMER5			55
> +#define CLK_DIV_TIMER6			56
> +#define CLK_DIV_TIMER7			57
> +#define CLK_DIV_CXP_TEST_PHY		58
> +#define CLK_DIV_CXP_TEST_ETH_PHY	59
> +#define CLK_DIV_C2C0_TEST_PHY		60
> +#define CLK_DIV_C2C1_TEST_PHY		61
> +#define CLK_DIV_PCIE_1G			62
> +#define CLK_DIV_UART_500M		63
> +#define CLK_DIV_GPIO_DB			64
> +#define CLK_DIV_SD			65
> +#define CLK_DIV_SD_100K			66
> +#define CLK_DIV_EMMC			67
> +#define CLK_DIV_EMMC_100K		68
> +#define CLK_DIV_EFUSE			69
> +#define CLK_DIV_TX_ETH0			70
> +#define CLK_DIV_PTP_REF_I_ETH0		71
> +#define CLK_DIV_REF_ETH0		72
> +#define CLK_DIV_PKA			73
> +#define CLK_MUX_DDR0			74
> +#define CLK_MUX_DDR1			75
> +#define CLK_MUX_DDR2			76
> +#define CLK_MUX_DDR3			77
> +#define CLK_MUX_DDR4			78
> +#define CLK_MUX_DDR5			79
> +#define CLK_MUX_DDR6			80
> +#define CLK_MUX_DDR7			81
> +#define CLK_MUX_NOC_SYS			82
> +#define CLK_MUX_TPU_SYS			83
> +#define CLK_MUX_RP_SYS			84
> +#define CLK_MUX_AP_SYS			85
> +#define CLK_MUX_VC_SRC0			86
> +#define CLK_MUX_VC_SRC1			87
> +#define CLK_MUX_CXP_MAC			88
> +#define CLK_GATE_AP_SYS			89
> +#define CLK_GATE_RP_SYS			90
> +#define CLK_GATE_TPU_SYS		91
> +#define CLK_GATE_NOC_SYS		92
> +#define CLK_GATE_VC_SRC0		93
> +#define CLK_GATE_VC_SRC1		94
> +#define CLK_GATE_DDR0			95
> +#define CLK_GATE_DDR1			96
> +#define CLK_GATE_DDR2			97
> +#define CLK_GATE_DDR3			98
> +#define CLK_GATE_DDR4			99
> +#define CLK_GATE_DDR5			100
> +#define CLK_GATE_DDR6			101
> +#define CLK_GATE_DDR7			102
> +#define CLK_GATE_TOP_50M		103
> +#define CLK_GATE_SC_RX			104
> +#define CLK_GATE_SC_RX_X0Y1		105
> +#define CLK_GATE_TOP_AXI0		106
> +#define CLK_GATE_INTC0			107
> +#define CLK_GATE_INTC1			108
> +#define CLK_GATE_INTC2			109
> +#define CLK_GATE_INTC3			110
> +#define CLK_GATE_MAILBOX0		111
> +#define CLK_GATE_MAILBOX1		112
> +#define CLK_GATE_MAILBOX2		113
> +#define CLK_GATE_MAILBOX3		114
> +#define CLK_GATE_TOP_AXI_HSPERI		115
> +#define CLK_GATE_APB_TIMER		116
> +#define CLK_GATE_TIMER0			117
> +#define CLK_GATE_TIMER1			118
> +#define CLK_GATE_TIMER2			119
> +#define CLK_GATE_TIMER3			120
> +#define CLK_GATE_TIMER4			121
> +#define CLK_GATE_TIMER5			122
> +#define CLK_GATE_TIMER6			123
> +#define CLK_GATE_TIMER7			124
> +#define CLK_GATE_CXP_CFG		125
> +#define CLK_GATE_CXP_MAC		126
> +#define CLK_GATE_CXP_TEST_PHY		127
> +#define CLK_GATE_CXP_TEST_ETH_PHY	128
> +#define CLK_GATE_PCIE_1G		129
> +#define CLK_GATE_C2C0_TEST_PHY		130
> +#define CLK_GATE_C2C1_TEST_PHY		131
> +#define CLK_GATE_UART_500M		132
> +#define CLK_GATE_APB_UART		133
> +#define CLK_GATE_APB_SPI		134
> +#define CLK_GATE_AHB_SPIFMC		135
> +#define CLK_GATE_APB_I2C		136
> +#define CLK_GATE_AXI_DBG_I2C		137
> +#define CLK_GATE_GPIO_DB		138
> +#define CLK_GATE_APB_GPIO_INTR		139
> +#define CLK_GATE_APB_GPIO		140
> +#define CLK_GATE_SD			141
> +#define CLK_GATE_AXI_SD			142
> +#define CLK_GATE_SD_100K		143
> +#define CLK_GATE_EMMC			144
> +#define CLK_GATE_AXI_EMMC		145
> +#define CLK_GATE_EMMC_100K		146
> +#define CLK_GATE_EFUSE			147
> +#define CLK_GATE_APB_EFUSE		148
> +#define CLK_GATE_SYSDMA_AXI		149
> +#define CLK_GATE_TX_ETH0		150
> +#define CLK_GATE_AXI_ETH0		151
> +#define CLK_GATE_PTP_REF_I_ETH0		152
> +#define CLK_GATE_REF_ETH0		153
> +#define CLK_GATE_APB_RTC		154
> +#define CLK_GATE_APB_PWM		155
> +#define CLK_GATE_APB_WDT		156
> +#define CLK_GATE_AXI_SRAM		157
> +#define CLK_GATE_AHB_ROM		158
> +#define CLK_GATE_PKA			159
> +
> +#endif /* __DT_BINDINGS_SOPHGO_SG2044_CLK_H__ */

