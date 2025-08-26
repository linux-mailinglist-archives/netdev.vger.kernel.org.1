Return-Path: <netdev+bounces-217070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A7FB3740B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 22:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0417C64A9
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1231281508;
	Tue, 26 Aug 2025 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="IanXRkaY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2137.outbound.protection.outlook.com [40.107.236.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7F30CD99;
	Tue, 26 Aug 2025 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241476; cv=fail; b=UqkQou9fS3KQsaLPIFXzltwn8eMwbspRa2jQbLLC2xkMGMZhcJJm1LmCxj0k+7S2Ijue3RKY4UZnfPEbpqRyHV7OuHG+0Essr1SY6pK0LQrQEc2iIRUyR0O6j3EHqEXaI48ZJtvdItdPa2TpeJoutzD2C1e2EuV9BKun3Rraq5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241476; c=relaxed/simple;
	bh=HWuAHhAYMrFvxOkMishP/+66XUJ3MtYULeTX2rIXzHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fGaJ5bbFhtey7CSeTfav3tOhdgjVFq3+wcH+IZpHiM+UbOBIvns1wWuWXYtyycyl8q789yzbLwstDWcOZocdAd6PW1H8p1t3XGyTOZcGNCrCwtQvu+L0m8HWJeJ3K2UXSHApez+XgV2lZJrKptoGbSvmHuY3flqLky/VmSm3WmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=IanXRkaY reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.236.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sm1tIi5BpKcUsFM+cNU/8yukV9JXWoIButNrer/6tsjL9DZx8NHwdri0hx40qNhQMUQnawTdn8EJroKfo9Au4jew76IrQkK+hBKB9W606IAqNWpJxfrzm69oXjSbIBjSeoJtY1RS4VeZVJhfQPqkzmkBZv6riBKsh8Nc1TCC2FWGtrumTdhgOnsoXiVzVIwhVejSTquNKLVOGedOOZuJtd39rlV1Cqo+Lc202hrFvBcTpe+nFTKpxJ8ndvOCTQzko3P2wCjHaJa3Bc1clT9WzOBlABAvp2b5JntUmXr+Yus2VHKKfmMq5hKWmkmqj7KA3oYV71/0Gl5DUW8XFlW5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WBlQbxUo45ITZYPuhsxiZDBfa/Lz7qDn3iL0HvctDc=;
 b=bRItHan4YKiya0OHY9HgBgcRGmyOY2rTuII5vIBVWbG8cxeThWqMNguIrmzo7dMobjhRmLappXhl9d5VvVBxWXBl3sZceSqwr6WCjWZg9CLlw7v3+egZUrO3BOG5fezcyhOghEnSEccXgSnrjj/dZzatE3p71doVpZ6B9IcyAcORZX7lqrULEvcvBsqQGs6PJ9lAkwxcpWIj6y0x7p0nvlG/jyMGyRz1DciU1TB6SteBwsvAA+iKnScpGviI2/nJj+byKkMVD+DDdnMbsUOn8oikHSa4hLILY16RCqvcA+3yhjOagP59LxufxkhvyCdRRhaYcL9DRTOP2KrrD5cyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WBlQbxUo45ITZYPuhsxiZDBfa/Lz7qDn3iL0HvctDc=;
 b=IanXRkaYUxRvRzdSne6UcjMBpC+JHZzqZoA6v1Yia5YUvhAra9QuvEDWQFlaH68np29Bi5pklBa8mwRHGqxQ1Uv0kWfYEJ/Qu8CQL0z/NXM4yZ8aazh1AoN/nOwEvATcjLAEyZJnrAH5w2GVAKfDDT9wTEYC17CcntTZKdeIE5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA0PR01MB6185.prod.exchangelabs.com (2603:10b6:806:d9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Tue, 26 Aug 2025 20:51:11 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 20:51:11 +0000
Message-ID: <d15313f4-46d1-4096-bdf1-783afd8e439d@amperemail.onmicrosoft.com>
Date: Tue, 26 Aug 2025 16:51:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250819205159.347561-1-admiyo@os.amperecomputing.com>
 <20250819205159.347561-2-admiyo@os.amperecomputing.com>
 <88a67cc10907926204a478c58e361cb6706a939a.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <88a67cc10907926204a478c58e361cb6706a939a.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::18) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA0PR01MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: e49211ec-05bc-4118-736c-08dde4e249c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGtORHNDMk04eVdmRDJkNVBNOUUyWlJvaUNuUXdPenRueU5NNDJpMjk4dHpU?=
 =?utf-8?B?S2FvOXBwdEc2SmttTnFwMm5Zb3pHQ0k2QTVpZ3ZpVjNQWEp6UG5HdEd0WWhl?=
 =?utf-8?B?Sm5QUFB2V3pFMFlId0VQak52ZW1rMkxnQWFjdGxWZ09ERml5RjhyZlBnMTcy?=
 =?utf-8?B?VmNnbWxZcGVPc2dFcHZ6VWVQWjIrNzI2UEtTV0NvUmpGMG90ekdWS3JWNmxZ?=
 =?utf-8?B?SzVRRWFZWGU4b3d6QU9VMnRBc1hHOUNXU21WekVQZHF5NkYzVmE1NjEvb3Vj?=
 =?utf-8?B?VGlINzRMdENDU1FJRFlQTERtRVIxRDRZQkljWlk0YnJTOFh4c1lDSVNkNzBR?=
 =?utf-8?B?anhjekZtazZYU1VEaTdTRHcxQXpxbGFkME90eUlKRW5NUzRpSm41dEJ1a09B?=
 =?utf-8?B?V3R6OHo2TC9oU1BEaEplRU5HeHkyQ0d4RGJ1TUpjNE9zYUxDaFF6Y0hGY0F0?=
 =?utf-8?B?N1dwMnNsaDJzaXZrcC90b2tUdWR5MnFQVWFRd29waDBLQitaMXFsNWgramo4?=
 =?utf-8?B?U0JraVVnUGo0NzNlQ0pTaEdPS0U5TnJpVW1WNGNFUDJNZWgwWnRCdTdyUGNR?=
 =?utf-8?B?QWUvaCtTaFhZSzY5bTN1bEY1WWE1d3JZSFdwd25sWi9RVnBCOENTU2tsbXZJ?=
 =?utf-8?B?NFZYMFdON3h0Z0FYcTZQcXQyeS9TL0RudFA3Y295NEI2eGh0QmxXWUI1cTRp?=
 =?utf-8?B?a2d2Qmg2Qzlrb21BVTRaMWRVWWJiRm1ncmNBWjcwSktCdWVOaW5Ed1MwY2wv?=
 =?utf-8?B?ZDZKQWZIRzU4Y2lBRW9yZzJIS0dUNVNkYkk4NW0zUnRMREdIeDFwcEN1VG1X?=
 =?utf-8?B?eUZ4YysrVUhIRlc4SFFySmorUDJjdXhKY0psL1hMcjhJdHNlbmZsSE9aajVY?=
 =?utf-8?B?YlBGSGhMTElIWEcvVFoxd1BDUjhKMEFIbVFJcEE3WC81azYrZG9vZlJ6RE51?=
 =?utf-8?B?RzZUNXBhcDZLajNpL1M0R3BDZTV3YlVIc2RjVENOS3pzWWpoYjROVlhUcTJC?=
 =?utf-8?B?ZDR0aUFnVW5PTWR4ZzNDekpxbHhFUldjdDhBNGpSVkNhYXp2d3ZoaUFpOURU?=
 =?utf-8?B?K1FFV1hWZTh6VWl6emkxaktFY3FMVHNDNFpOaE1hTXNtS2pLVldpeHBBZGJY?=
 =?utf-8?B?WGxJT0x3UktUalJ0dWtvUFUzTWdaclMyYmNxTFJLZW5WaklHaXNMZ3hQa2E1?=
 =?utf-8?B?T1ZTNmxWeS95SGFkKzBxWlR6Z3RUcXJaMTNxVVE2NytYYmxndzB0NTVpNlEy?=
 =?utf-8?B?cDFpUEJENkt5Zy91TGdNV0V0b2RyWUtjdVZtektzQnlhaXNWK3JXSlFTNG91?=
 =?utf-8?B?SEZ3UU56TnlvYW5iQWFOaVJKOEcyWncrU1BZTkVaRHJWRThQNHc2UDhRd3VC?=
 =?utf-8?B?QWdOM29lbCtuVzRsMmVyd0hDdUFWSFZoWVhxZHZ5NDdKcTV1c3pzbjhQSFVH?=
 =?utf-8?B?cVVPMGlXZUtRRG1JT1J6bHZDMWxhd3NJOWVGT1B5akVvQm5TVXdRK1h4WTAx?=
 =?utf-8?B?czFqSmc1NFJZdFpWaXJNNlFzLysrWmV4SUJla2hNenlRN3BLa0MvVmp5QTB5?=
 =?utf-8?B?Z1ZOQzBkVndFbHBXQ3p3ek5FeFYwcU5MU0JsZzU1U3RPV3BnUVZuaitLRFRH?=
 =?utf-8?B?elU2NGh3TEtzdDJGdzJWcWhabFlROTBaNnZ4aU5rYlg1MDRNc242TGpwaGta?=
 =?utf-8?B?UmlVeWx6TXlIb1N3M1NoQmR4L3k2OUJ2dHJlNnlhSWxWSUI3eDBEcVF2ak9O?=
 =?utf-8?B?QVNqVkcweTErdWl3NVU5N05tMzdhVFhLSVZ2SzlLcDZ6bjJZbCtRckVGMjk0?=
 =?utf-8?B?SklBdUtZUncvZjEzNjJuK0V3YjczNWliU2ZBaERuc0NsNWc5dFZlNkE0UHBa?=
 =?utf-8?B?VUlQeXFwcEtaR3NtR0theENzaG84WXNyRTUzT0FCTlNvR3FxSFBocTE4Z3hv?=
 =?utf-8?Q?bqQt+cqDi/8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEUrUm54dW8rck5TQ3lMc1hPVlBUK2VOamFGU3FvRE5VQWVELytuTTZKNU9k?=
 =?utf-8?B?c0o0MTQ4MzZQNjNSVHFpWjNKc01VREdHVFJZVlRHY2VYMHdEWHFrc3ZMdE1Y?=
 =?utf-8?B?VEl6OVh2QmppRHVRdk8xaWFzL1dUMUMxK1lEdEt1UjhwelZMOGhaOUhVNWNS?=
 =?utf-8?B?ckR2MVdoVVdvTkJ2SWt6TlN3aE5rbk5pOHpTaW5EWml1ZEJiaDY5NlUwRk9o?=
 =?utf-8?B?S3ZjZTN6QjRkN1BqWnFXdlV2NlVHU0ZDVnVsY2lJRmtmd1FkRUhKMlJXVU9O?=
 =?utf-8?B?TlRoSmFYdDRQVnpKNEU4eVNuMHdtd1U5L1Jmc2lWdUk4alB5cy9GZnFZbjV6?=
 =?utf-8?B?RHBOOFYyTW1XcGFQZExCNmR4cFhaOTNkZUlqcUFtSnJrYnkyQ0hvSWJkekZy?=
 =?utf-8?B?VXl3dkVoRXpiaTc4MTlIcUY1VzJKK1AxUDVIKzBBVURGTHJoWnlDbjBNYzJM?=
 =?utf-8?B?Rmo1RkpoMTg0VlFVdHk1TzdFbGZBMGRiTCs3MEdxY0RQMDNnYW1oMTQvSlJF?=
 =?utf-8?B?ZHg5SFhXeHZiSGZKWDZXWDEwYngvcVdic0QvT1VoaXZ1UytoT1grMlZvRE0z?=
 =?utf-8?B?QjZnV2xnTW4vN21wSTM4blZ1eHV2UjAxMk1PcVMzZzc2enhsUU5VOEhaRS9Q?=
 =?utf-8?B?RG1ta0NHQU5NNkduUWlHb1BIMWJIL1RzaWg3RThJYzJTWVZ6ZW50elFDS2Z2?=
 =?utf-8?B?Q2gvZWdMU0ttWHlHeE1URU1jWFBFczl0bzB0NldYVEZwdjVGNW5UMnJkWWNj?=
 =?utf-8?B?VDhkU0EzQXdnalFIQjE2cG95Z3c3N255Z3hxSWJuV0dGMk5UMHZ2YlpaUXNq?=
 =?utf-8?B?NXhWcWZlT1Vyd1A5aFBZOUZHbEhJRVpvM0pTL291MmVFRXEvcEZtZlAxMi9M?=
 =?utf-8?B?dXg3TUU4ZnB2M3hHNXcvZXVtWGYrY3k3ZjkzTUxEVEwzd0tQTmxEMVRYWi9m?=
 =?utf-8?B?bk5ZcGtyMjgwZnNrOGIzeU55d0JFMkF3bkFzRzZPdXJXbVJBSktER0ttTlc5?=
 =?utf-8?B?U1R4c2g2WjB4U1krRTJhSE1KTHhKTWFlMm5uT1ZiQlRaaWU2K3dTaGtOSTRK?=
 =?utf-8?B?cnZuTDIwMTg2N3ZYdkFOK1hnUFQwQ2dXT1k3Y3BudWJBVFRicVNwMWdNSGlo?=
 =?utf-8?B?QzQ0bVB0bWk0UVNMRm51bmwydzlnMmFqbmo1TTIveG9XSTF0TFdDZWNiRDQy?=
 =?utf-8?B?a3FqYTFnT2JPeStub0sxY293RzFpVzllbjZHUWgvQ0hJbEZCaS9GU0ZQREw3?=
 =?utf-8?B?blhMNzVLOVE3eUdyMjhyY1F3THNZSnQ4dVExYjhDTXlhbG1YQnk1ZThCMDAx?=
 =?utf-8?B?a2kwRkdoTDJ3V2ovQUVuRU4yZ2YxOUd2YXczeXhkUnpKcXRpV25uZkMwNEJU?=
 =?utf-8?B?TUJPZmhCZWREcjZKSUtaWXNWdnpoUHZhMTVkR09sZHFzSFZ5TmVLZjVSR2dp?=
 =?utf-8?B?OTRoamxOMFVLQjIxVE9YWWFnVWZNNnY4Y0ZhYXhjUkRVOE5id2hYR0VGTUVQ?=
 =?utf-8?B?WVRQMnRTMFAvZHFxdDU1ZVB4aWdCc1ppOC83RTdhRzh0QjN4VVZFa3VmMThy?=
 =?utf-8?B?SUFWaXpOL1JLM0tEYUZ3UXNMbGR3S1RvVDJ5aUNoRDZBTVd5VGF1L2V3TTFQ?=
 =?utf-8?B?aHh3QmQ1L0xnVmxnREhDQlY5MGVVS3FxK0JwNHFyd2ZXTDRFZmFqQm9RVmFG?=
 =?utf-8?B?Z0puVGJXUzdGRUZveW1YY2NZdG9BOEd3VFQ4WlI0YkxOM3Rvd2t4akJLZGd2?=
 =?utf-8?B?NnZKVFpyU2ZYdEZEYUZ0SkNEWXN6UTEyaU5lY3lBQ091Kys3TXVWWVpWaUsw?=
 =?utf-8?B?OHJTQnhVQVF6Q290eEhmUDFzVi8vQkFxWU9lU2U5QytyYUpaMUU4Y0x5Mnln?=
 =?utf-8?B?cXZpUzI5Sk1COHRJbnNCOXF6dzNhcitpSjBYa1ZDa1Rlb0dFWHpUTEtzczJx?=
 =?utf-8?B?WnJTdVMrc095UU15cHVpeFgreHkvWFdqelFMMWhFQi81cnhxQ3dJL0lEaXhP?=
 =?utf-8?B?Q3BtL05rQllXcTNQQVRIYjVnZWdyR2lEWWhkM0hveTdVWE0xQnlLRmZvM015?=
 =?utf-8?B?elhmbHVFRGFXUk44MTRKZHJIYmZvSi9aTllUb214cEJJdFhXNDhUU2VBU1BT?=
 =?utf-8?B?bUliUzFuYmlyc3owVXJNZnJmZ01seFhXa2VYV3orNnNFV3NVWmsrcWV4YmRE?=
 =?utf-8?B?VnpveHkrRFB0UlhLR3ArRmtOSm4xYnZ0dk94cmZqaHgxUjF3elJQekZ4TnRv?=
 =?utf-8?Q?DYkRtGyv4nauCapDK0jdx1CiggtkMF++NAzPmdtTQg=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49211ec-05bc-4118-736c-08dde4e249c8
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 20:51:11.1198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYTORRg5sbjpHYAaDx6cZPR+fB9IMdCRoptq/EgoUOtTNwY3sT14thbTp5hTw4sEfG/fKfmRQ0+rIC7qfpUiV43pc4sb6KKTJQvywzNA869wWQdp24O2aIV7YPi4+Axc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6185

In addition to the below comment, I am removing the additional lock on 
the skb lists and using the internal one for all operations.  It leads 
to leaner and cleaner code.

Updated driver shortly.


On 8/22/25 04:21, Jeremy Kerr wrote:
>> +       mctp_pcc_ndev->inbox.chan->rx_alloc = mctp_pcc_rx_alloc;
>> +       mctp_pcc_ndev->outbox.chan->manage_writes = true;
>> +
>> +       /* There is no clean way to pass the MTU to the callback function
>> +        * used for registration, so set the values ahead of time.
>> +        */
> For my own clarity, what's "the callback function used for
> registration"?


Actually, this is not longer true: we can do it in ndo_open, and it is 
clean.  Removed the comment.


