Return-Path: <netdev+bounces-175696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D68A672EA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771551896E30
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE09E20B207;
	Tue, 18 Mar 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="TTu0RKhL"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C1B202C2B;
	Tue, 18 Mar 2025 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298256; cv=fail; b=VfsYXBHt/qf3oQM6a6UXJnErUe+JU/RjM9FzT/+4sE3uP0z4uUmfQPNRZKz879ubsxADe14eDJWG0kSG/sjDRbRj3bom1YfjkW8plSW2GRtidUtONWdw1ab0iYb4+vwYvefrSPbidFnggqur1hRP8kgD/R2EiV/cRUs25mxZalY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298256; c=relaxed/simple;
	bh=1d03eeerRn3or3enUtH7gO1zH5MtKPsiZ1SZ0WF/qTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=looXnBNDZsxocK+UXWcN5BobTez+Kb7o2AtyZaUIqClBIAyQIJqRuAwoQiHLTHZaWnGMOhxQJc8KCtv0S5cqSe2IHN1MkPQgipx1aRmp4ZUJzfx/QXqGZl6ususrJIiuELQygXDuJgyreBE28nIqK3vRly5kSJ3NrXPlA/s2B/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=TTu0RKhL; arc=fail smtp.client-ip=40.107.255.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b80STNfjK/csB+aPkyzw8NUuMQfImJdOl4BPdxncF7YfcC7bIpvYNo7VJkoHtQtMhu9IYimJjSYzdTsSrQmN3AUYcPhJAlJkxv/JgTRTX6Ga/tvbqTF2WJMkKcYyU/JBUEnsxSJDAVA42Pc8Tvg6rsKU7LSj9wyQ3J2xLc4r5QLRP/4Zbv1gw+Ej8oeKo0m+JQllLtAylrFghF7Ce39YMArwWbgWVfIb3mwDZcVm1i+99rgWwACwlzMXb55F9PySmdkQ5QVj9XHKzx9o/mzWf1YxOkMS+F8Q0hNPT18usVTsC5bJIfpg5Z/J5ZJ6oCWlnv9o9flaHe5+VYpKUUGsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d03eeerRn3or3enUtH7gO1zH5MtKPsiZ1SZ0WF/qTQ=;
 b=Q5es5JX9uucxPm5qNQ3QsWxh8NBOzM4/ld4WSjLJ2WKT7ixBmGDz9/lF4smktCvGmuDfBGsOkhBPx9MXFL3BQYSxag4wqO/5StzqkigOF6e44dbqOCldyhCSzJf4V5SHuGLvY9g9hhELiWEExLTV9wEwaGd2no6v3FXrxPzCu891NxfyrxeunIerFzESp+BSMwrELjriCrXMERnd/0DFJUHvKYZhnDUHw8rxHFzKMVhYG9IEqDDXYZzid5LjMm/Smc+hGmdtLSAJKyqlRPqZ6OwwIeY0G2q870ZefUfaAzQwSqk0cEjhgNIjR/L6Le1HnrizGzsPv0XCtETEtZi+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d03eeerRn3or3enUtH7gO1zH5MtKPsiZ1SZ0WF/qTQ=;
 b=TTu0RKhLWANu2SbxxEa/EX4gfOJPJnyAidUxtdayMaj6WKAs/oMSWc9i86nRppH/YIg3v6wMU/9m8s/arSgbeQDnByaVBZqa45uOg0UWKsB/y22W5mYxm6rbEAzUKu5ZdX1NLtFgHzFMSMbI6MqBfwrQi02W7yg1kgI1ETjuKNaX02qB4qsHW65oRGiSL2QeIFlSbBM+R5opzgY9WmnZDYY6o3I6NecjJUFAVOB56brOJCEFtkucCp2ogYMTVs92iwBjJaHnyD6vmCpzIrZN6/AYKkh/ig9t///4VwrRpuCvvbKXuCM19wkBMbxN7BG4aTYAlq4Hf+lpYMsTJXXgSA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SI2PR06MB5194.apcprd06.prod.outlook.com (2603:1096:4:1be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:44:10 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8511.028; Tue, 18 Mar 2025
 11:44:10 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "ratbert@faraday-tech.com"
	<ratbert@faraday-tech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject:
 =?big5?B?pl7C0DogW25ldC1uZXh0IDEvNF0gQVJNOiBkdHM6IGFzcGVlZC1nNjphZGQgc2N1?=
 =?big5?Q?_to_mac_for_RGMII_delay?=
Thread-Topic: [net-next 1/4] ARM: dts: aspeed-g6:add scu to mac for RGMII
 delay
Thread-Index: AQHbluiZmf/WF2xcsEerMXafre3mkbN3R5sAgAGASgA=
Date: Tue, 18 Mar 2025 11:44:10 +0000
Message-ID:
 <SEYPR06MB51343ECB2770BB50F19890019DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-2-jacky_chou@aspeedtech.com>
 <be284777-978d-470a-b38c-2f79a1d76134@lunn.ch>
In-Reply-To: <be284777-978d-470a-b38c-2f79a1d76134@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SI2PR06MB5194:EE_
x-ms-office365-filtering-correlation-id: b382bbe1-2276-42f4-70a0-08dd661232b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?ZlA1cWYwcStBcWx1d29PNnlxNEZ0WGs4WEUvOStEbDBKeFcvTG55UStEMTFDS2RP?=
 =?big5?B?eUZNMzhkeFYvcktyQjE0SGhiNkp2MG51OW5od0xScDFGdWVKdVNpVDJmMHBFOFBE?=
 =?big5?B?eS9QcVVPMWhlcGJYQnhTSlRtalZRb0FYUUVIN2xjcjU4ekpmbTdHb3ZJNWVhSjZB?=
 =?big5?B?SlU3amdtZVpRTkgrTjAraUx1WnkvQTRLeDU1N3NFM09reFlFTGxXVTRKVWFHcWlO?=
 =?big5?B?cVM1VGRQSitsSmR1RDU0TVFERU5WenpWL1lYV2pmNEtXMDdhOW5YTTBwQzN3b0x0?=
 =?big5?B?NUZoYWpEbFRtWDNTYTBsNFNCdEhQeXMxTTlJUlZmUGFubUtvcHBQVmJmR0MrKzE0?=
 =?big5?B?aHYrVmg1ZDZuSU8wZUR4STE0azYzclhZTFNCZmtZYXpMVXgyVVNSWVFWYVZQNk5K?=
 =?big5?B?bUNyQmRkdGFONFc4eXVPQW1tdmhrNlZHRzMwYVpQVzEyQnMxbXV5c3p4S1pOZEEw?=
 =?big5?B?QXZqUTV5VjBPUHhmNWRlWWs2M0U0QlRwQ3FFSUJLVENkd3pVcTJnTFd4TzhtWmp5?=
 =?big5?B?Ylh1clEyL282Y0RBY3lMdVFvVG11by9KeVNxelBRNU5xd1VmbEpKK2Q3SzZlK1Nn?=
 =?big5?B?SUhCam8wbEh5b3I3TDdZV0FRUTBFQndrNzhOTmM2UCsra255QVU1QytHclZxdFFp?=
 =?big5?B?YVZZK0ZrOTdROUVKb3ZXZnN1dlhmNmk1OUhBdUVFSGFXdTNJSmhma1ZuL29iZE9h?=
 =?big5?B?M2tmU1oxR0RQeU9TeTJtTXhoVGlVOFc4ZHo2NTJVMFo1eFpFQTB0R0JFWm11WWor?=
 =?big5?B?NktPdGg2aW52MXlhU1kwNVMvbFZyZlpvTXR4TGdPQWYyS2I1QUxFbkd5ZXY4eDZx?=
 =?big5?B?aWFPaEN1TVR4bThyNzRRWWxpdjdNNzlwUHpDeVl3UDJGWkxSc3NHVnZNTXR3dHl4?=
 =?big5?B?YUUrcnhKb3g4dHhkTlJkVUwyRG5Uc21JTUt6MDJpZ09MQmJPL0x6UmVpYVBBZlhw?=
 =?big5?B?dXdGN3FJNFZSRWdBcmVnY015d21lV1ErU0dTYW44bGZmS2lRR2VPZm4yMENQNk9I?=
 =?big5?B?cnZ2dktsOWlNLzdwMHhvQmczNmZiMmtKV3p2NnpaVDVWdmt1dkJxM01tWDFoOE41?=
 =?big5?B?cGJicG9KaHFwcDNVcDZCcTRVWFZEMkZyRTFTWWF1T3FIb25Gd1lyVHI0UFlLd2Qx?=
 =?big5?B?aGppeFFIMC9YaGlOVnJRRUx6QkVRc2c4aHp1SkRwTzUvTmxNNjlidHVzL0k2Yzda?=
 =?big5?B?WFJrL0lkeEdkL1cxeFBLVU1IRGlWUkV2UEN0UitGSGEvZmt1WStnN0lRZlVtWm8y?=
 =?big5?B?elduTStPcXBYbmYrbllEajYrODg3M2ZzS3JjRWdoVThVYWxNMS9nY0xUSTFMN3FY?=
 =?big5?B?L2c5akVWN2o0UWZVZDUxQ1BLL283RStCb1hucHN4WGZYSkJHYmRxY2hHTHc2czY1?=
 =?big5?B?QjRwQXNpc0RHaUcyU0EwZkRwZlY5cUd4UHVBaXNyeGw3TkcvMnladmEzc21UNnhs?=
 =?big5?B?SXZHZU5Bdy9Qb2VEcjBLZ00wbGR6RFFxOW0zTEhPU21ySGhRV2NuNkU3WGdXckpq?=
 =?big5?B?MTh1V1JjOVVVRXFNc2pzSVMyOVpaWDBQQzhvTk92WlJYVTVScEY5RjRPd25xNnNs?=
 =?big5?B?eVZ2SXE5YVNXS0RKaTFDOXpxRlNQb01uRFZYRmxQWE84SnZxYmEzNXJNeGpoajNU?=
 =?big5?B?endtSHZxem5SNzVKNU9LMllwOGhoZkZCNWoxKzQvWGVpUDl5ejkwN1hsNnRwTVdB?=
 =?big5?B?L0JneTc0c0k3SUxhb1Z5czJGYk5LSlRsTlRKQUhzZVhxVnMxdGVkWlZnS0tMZzZl?=
 =?big5?B?Ui9LWlJwTTFOU1AvNHNERXB6VGk3SDRPNy9zd3dob2hTUzlpa016aG5mQWZscGFn?=
 =?big5?Q?GXYt4gGywwY2s/xjBHFh4cLVVjVRIu0v?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?REdJNEJxM3ZsMGIzNTN3Z1A2clBhRmNXbFYrYVBUcTFmMjVINUhWbkk2aVVDR3l4?=
 =?big5?B?aUwwcVVEc1VoaEtrakhiOElROGdUNmxhdERIZUluY1BTMUVueWlqQnA2VG9TQlNr?=
 =?big5?B?SkZwK3h6Zzd0YTBKL2ppVmlpRkhzUkpicTRZYnJaV1drMVRkMUZxbGVwV0VHamc5?=
 =?big5?B?L2JsUDlSQUZ3R3p0K0liWmhVQmJkeGR2RGhrTFFPVzNhMkVmSVFWellBa2d5WXNk?=
 =?big5?B?UG1xSy96OTRDa0xFSDZoYmtFYVY4SzNFOVkyL1BubGhTMHVuUEtXejAzbGZZRTFt?=
 =?big5?B?SWZlVVNKb2RCMlp2RVE3bEduV0dia3grY0s3dVovd0piTGE0NVNWakszUUErVGIv?=
 =?big5?B?bWtVNTZpdDhZNzlReXRlZHdDalozOHFBOG9lekJHZWR5L01iWEUrSDNSOEJaVGsz?=
 =?big5?B?OVh0RkZ6aTZ2NGNMdmxCcGt6R01QclA4QSs2YkVCeFA1djIzRkhXc3BYK0FQYmxu?=
 =?big5?B?K0k3WUdZZXhPN1BWNGtUODc3Z3dsTFVra3R6YnBXR3J4TzZhVzAxUTB5UlVtRVR3?=
 =?big5?B?N1E5Y0NZREVFaUNWVFhqekIyVGhqY1NrM3ZUdHRqL0tLTnZaVGJwRnZxRjhIbTdu?=
 =?big5?B?ekRwSWQ4UlZoQVRFYTBKSmdld3hLWHJlK2dWWEZUYUp3ZTJPQVBUV1Q1NkZySHNF?=
 =?big5?B?WjNSTlAzRFo3OFFOcGZWR3RQWGdLUTdSVWhwNFVpeEZUY0xpTU8wRlVLV0Q4LzVF?=
 =?big5?B?SUpSeDI0cTZubE45Nzl6Z3gxaHlhWEljOWxneHlGVEV1UjVQL3BkY3VUaWovR0x3?=
 =?big5?B?Y1YvaHloQ1Q0aWR1WVpOMmJENVpnN2JXZ0RmU3RIamUyL0swQWRLalFscHk5R1la?=
 =?big5?B?VUdTOVJQb1NtQzkrQkRycFpCMmo1cW1sQUk4SWprUmhFM0pyWTg5QzJ2VXMxY0Zh?=
 =?big5?B?YkFISS9OVnVYTnB3YkVRWjVldXk0RDJDTUJnYkpsNUVVeEdQT0tkekZVamxBWXpl?=
 =?big5?B?Q3Y3eXUrMmxlMjgyU3pPRlA2N0I4ZHFyMmkvSmI3enJ3eFcxUVFJak5mcFR2T2py?=
 =?big5?B?S1d5dHdiUExsdmx1VmVZcUx4Q3dQME9VNS8xTHNwOXpqdC9BUjJqSEhtdm10V25T?=
 =?big5?B?N2h0WTIxVzBtdjBCYVlvbTRJWnhpV2VXTTNxaXhmUk5uLzNvNkgvdkdnNFBGazdq?=
 =?big5?B?b0pvRTFGR0xCVEdlZDBoUWxPdUpVQmlzbFRhYU9GYk5QUkhDRWhCZDkxNjlTZ2pQ?=
 =?big5?B?SW94Z1ZvbXY1WXYybzdMVEYvbnFBbjFLK1dhcnhHeENMeGNQcUNoN2RtWjhleldH?=
 =?big5?B?ck82M0tQQmk3V2ZaZGJVWmVmejd5RGVLRGh1OEtiT0NDanN4SnBGdDAxV2FHVkFB?=
 =?big5?B?YUJWSmtTRDgyWjlrbGwvOC9WRy9SS3FmellwVUtkTTVHeTVtWFhqMWM5NFRQekMv?=
 =?big5?B?a0F6b1ZxbUJWdkpPZTNPeUx4RW1VNGw4UUZRS21XejJvaStjTGYzbVp0bGFNN2dN?=
 =?big5?B?QWJXdDdGWEFGcDNMTVZCWUJ1MzNoVmxiOW1vSXNTRW9QQXZQRmRoU3RaMlZqTWFB?=
 =?big5?B?MXA4RDRPcURlNHdnR1k0MWhwU25ucUhaZ3JWSXQ5N0dtdlpaTHdCUmgvSWlieXJw?=
 =?big5?B?VHd0eHpGa0Y1L0pTV3dtZlk1YjRFQ0tOclJkRFdQK0RyMnRRMWZZUEx4R05MUG5V?=
 =?big5?B?SEYxZnNnUzA1VEdnV3Q4bFhHVUlXT2ZmV1RqcUVMTXNPb2J0dGx6eElva1djdGh0?=
 =?big5?B?T2pVTTlPRGZFc2V5dHo4QXlUb0pCQW5LREJKRERxbFZpbHNsWllkakJCUFZ4a1Nv?=
 =?big5?B?Z3lQUVdmdUNZM2F6SGNXcUR6RG5ibXExVHhFU1gyUzQrbUgyQ0Jac0Z1RlNyWFVC?=
 =?big5?B?cC9rWXNoR2pkcXJnRW8rUllJKzQ2QnZ4TzJEU041SzVUS1VRUXg0c0N5L2l0VW5X?=
 =?big5?B?QW1keXcrVlM3cExuNjMrU1dsQ0pvK05PbkRxZjFkeUJjbmhmNlZxMFZjTUJOaGdn?=
 =?big5?B?R2tmcmVJc01kazZONGNoaEV3Vjl5ZlZDTG5FRWdLbHJqa1djbDZxYklPa1RYSHZF?=
 =?big5?Q?A1HQLf8ZoJS9GKcT?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b382bbe1-2276-42f4-70a0-08dd661232b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 11:44:10.2590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jR567gfcGLQI1ZVtksHuHSlfcluXDy4oyrQrU4NPlTpFmNsD6p+/h6EQ+eXFYhxYuoeqQomARfxQHNAirKXeQZgy7KUaV3T9kiG1LdWnsbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5194

SGkgQW5kcmV3DQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+IFRoZSBSR01JSSBk
ZWxheSBvZiBBU1QyNjAwIE1BQyBpcyBjb25maWd1cmVkIGluIFNDVSByZWdpc3Rlciwgc28gYWRk
DQo+ID4gc2N1IHJlZ21hcCBpbnRvIG1hYyBub2RlLg0KPiANCj4gRG9uJ3QgeW91IG5lZWQgdG8g
YWRkIHRoZSBzY3UgdG8gdGhlIGJpbmRpbmc/DQoNCkFncmVlZC4NCkkgd2lsbCBhZGQgdGhpcyAn
c2N1JyBwcm9wZXJ0eSBpbnRvIGR0LWJpbmRpbmcgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3Ms
DQpKYWNreQ0KDQo=

