Return-Path: <netdev+bounces-190760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC92FAB8A27
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD17188A4B8
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9950B20E70A;
	Thu, 15 May 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="TTiwy4by";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="GZthegSX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CC4B1E55;
	Thu, 15 May 2025 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321301; cv=fail; b=Vvh6Wm67vrHa1l2t1lOY5Mk8PGX4lcSWj/iiS23xEvKxUkLd62hJl8PBHPGFN9cXgdzbVSWykUbbzchVSwTumwMaRN5F+h1JYff++yQ6KnvXZ28po4pKt55+KFYDElzVmPQus8C3AS3yFr/hMibLl+vv0JBTQBGhFrz7GbMJfXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321301; c=relaxed/simple;
	bh=Z+Ws2CzsNIk4JUgWBBMeeYiwWVealLzJWl3NwzLdfQE=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=lF+Elt4EmKE9nqbJmRCWzMfeVcm/3M1171NIv2e5EJ+5ivWBk+0zVc36E6QagD2xkNugrexzOHt88W1KAsHsu8Qolni+B8GlG5R3/QlRQfqez2exq+zh6qBV7HyG1YzchuJMPwW2ZIN0mNsUA31iPosT4DVdZ0fSj8uwPR90TY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=TTiwy4by; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=GZthegSX; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDsLOd023391;
	Thu, 15 May 2025 10:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=+FWZVRoZQrAz3znCmwbvBV7IEPBowASYZLiDOgikHQY=; b=TTiwy4bydJlo
	r4+9tq7szQbCc6SRccO8IK+iPY38VCxEUmr/WNWwkAWQmeLS9XLHmruWNxxnpU8y
	OX2XfCbqWzfRfHYUrcpHanYHVWS5+fBNkz0zT9GpgZGOo2gaYSEXE22NFOvyZGc+
	HmH688EnXj3IcpAO0FC2tlKcTjtbWHTjigreLHhR7rq3UZ6pbgkoFwCAQ0jUZPeZ
	QSPgcxYF4szxiF3TsUIP8yyxPodOtCH5lBJxyv/jMjWfxRSYcll9rs8z3S00BI8m
	//kyjjXyIGymAojurihQSRpnZK31W/Kwn/8m7bn71gmH55oh+U1BS/1e02JmT4DR
	MVZVljCTNA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46mbcjdxr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 10:01:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvXT9vyW/MeikjYt1o0qPHBYXgq/0OeQExyAOYcATCnjxGmD/TXrHMAUCgD3Q8mtetqijVNchNnkI5k1+X4KVC3rKvdnbJ4uOU+Xx9Px5KGX5kOD4XqXeIHRlMduKhlgLKolwCYtzEhT2qR+F3qKHzbZejqAOEegTIKaWCEPhVm9zdJR1+5zq5czxyCULANzOyV8j10vJ6H9vEr8AoC3XzB9ewJXlLj+LtPN/ENi/Y6tdCsOXsolw6q1ROtkLJxc0wUHFl2PavP4kRQV1h6s/CQz+4ls275ZcCouyeg0zAfg9Tjsx8dFPfacamQb9P9AwB+TG5HxIpL8G5OfvKDDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FWZVRoZQrAz3znCmwbvBV7IEPBowASYZLiDOgikHQY=;
 b=th9Za8fI+Nu0HbRxy0uv/IYhHu0xInN7Cjbo2DFjiFnKMjWHgSpfpDPam7klzBWIJV7/lw56SnWZHzwvKUahT531I4DpkyBtc6xFyRNwEJZ9367cvrbiTKthLfy0BxMdKFmHQQ98IRfcqZi1jSs64hVnID0nePgl/qvpVABkZaUgRzd+aJ/Ud3SbulUUhLnwpXSJVyrFMfo4i2mGXEPAUpaQMKwVes6NL9XuOEa5qU8ZAGw6fE4JLk/Ts9NcXd5u+wlEEKmhRSb5Kmc214HySMU3iKjqGpHOHDZKAzjd6muZnf6LonuYM+g8dXoZREB2Mpb+dmUaFQ7I27YDIumlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FWZVRoZQrAz3znCmwbvBV7IEPBowASYZLiDOgikHQY=;
 b=GZthegSXKCJVqeFz2QHtPqG96aFiu4eDOYQSOw9ZG1yBGumKGht4bl4Ju7q+kPUeRXj7hOL55m9aaKBSPSBghEodHWA7qEaQ2QnoxkUwi3VTPg79Wwp/qf8kejw2cET+YnOCBS8wwAqCVdg0E1MDwOgzfletuHErakWaxZlUa40=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by SA1PR11MB8254.namprd11.prod.outlook.com (2603:10b6:806:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 15:00:42 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Thu, 15 May 2025
 15:00:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 May 2025 11:00:39 -0400
Message-Id: <D9WTONSVOPJS.1DNQ703ATXIN1@silabs.com>
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
From: =?utf-8?q?Damien_Ri=C3=A9gel?= <damien.riegel@silabs.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet"
 <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>,
        "Rob Herring" <robh@kernel.org>,
        "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Silicon Labs
 Kernel Team" <linux-devel@silabs.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Johan
 Hovold" <johan@kernel.org>,
        "Alex Elder" <elder@kernel.org>, <greybus-dev@lists.linaro.org>
X-Mailer: aerc 0.20.1
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
 <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>
 <f1a4ab5a-f2ce-4c94-91eb-ab81aea5b413@lunn.ch>
 <D9W93CSVNNM0.F14YDBPZP64O@silabs.com>
 <2025051551-rinsing-accurate-1852@gregkh>
In-Reply-To: <2025051551-rinsing-accurate-1852@gregkh>
X-ClientProxiedBy: YQBPR0101CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::24) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|SA1PR11MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ace0014-0252-46b9-25f1-08dd93c142b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekswWnN1eEUwWW1FM1drZForeGtmaTdhVlBGTC81QmpDTll0N3NzMTBxS1R1?=
 =?utf-8?B?VThmSGIwQWsxQ2E5Vi9jUkFISGVJVGFlRFEzRkRNeXRXNWdNa09hUFNpaTVL?=
 =?utf-8?B?L2lnTVM1Kys3OThacXQyMjFiY0dIT2pDc20xekxxbTliZFZIWE1ZblZ6dGFQ?=
 =?utf-8?B?SFJCeldDWk1PL1BKclBLbndmQUNCalF5STgxK3J6WThuUGNFVGhvK1pxMkxl?=
 =?utf-8?B?SWZyTXhRd0hWbjJWRDZ5ekNROUc1Um5Ic3J0cDIwMklPL1JWK3I2ajN6cTg4?=
 =?utf-8?B?a1VPUVhYUVVvRmhtNjl2SUNQbkRNbzFFVTRNTFhod0lia29ISWJZQzF5V05o?=
 =?utf-8?B?b2xhKzI2cFNEdFN1L2lPKzFyZmNaaGRwNVNDaERvd25qSXlSdjlHMzk0bGtv?=
 =?utf-8?B?bWtyQkhJa2hMQ1pYLzdFOHdYRm10SVJ6V2QzRTluendrNUNJQllITWZzQmto?=
 =?utf-8?B?YUtMYXY3TlR5S1dyc1hlWi9jMGs0SUxkdUtOU3F0THJWL1pENWtoSm5NZjhY?=
 =?utf-8?B?TC9oeHArQnc5SGEwYnYyL2h2TlI1bzhaYTJ5OVZXVFA1MU53ZHZJWXdEYkhl?=
 =?utf-8?B?dHNXSVhTMHZoYXd4VTc2Tm1yMG9RZ2wvRUljOGxCUk9meUkwd3hObjB5bEpk?=
 =?utf-8?B?NGQ4WTNKYTVtQ3c4dUs2ek9KRHd5SjREVEtURG5IdkpMVFkxcTd2WHlvaERk?=
 =?utf-8?B?VDBaZXlMRmNrRStuanNkSWwxWTN0ellVc0FJdmtQejY2YjZhRW5TNWFjRVhl?=
 =?utf-8?B?OWlWTldTTXVCanYwWndNOEJWWnRTME96bVlCSEgvRWNJVHhzUUlMZVdGOU96?=
 =?utf-8?B?QXhKcFpOekZsQ3VlZzlhUEJXaWhpeEhkZEtFRXBwNlRaNVZlUFZxemNUVlh6?=
 =?utf-8?B?K0Z2NlVqMXJwSXYyV094bzhIOWd1ZERSSmh6Zjl0Qm1JTG5RMTFwRTEwL2pF?=
 =?utf-8?B?cWpvM2IydG5DdFJaLzdwMEI5TERLcDNUdHFuK3FDb1dxazYzQlVtVzBtZjZP?=
 =?utf-8?B?RkI0L3hsYkwyUStSZzA4RlR4MDRsa00xZzFnSVlKc2F5b1FxM3Y5U1ZYNm82?=
 =?utf-8?B?RFdkWmNFWnBBSkhDRE43Wmlhbitjdk54cW5DaUtVK1Jpekh4MC9reGNzTHFV?=
 =?utf-8?B?R0laN3hkUWExSzBleWYweU12SkszeUErRnp0Tmk2VXc2WjV5VG5Ic0lFU2Q1?=
 =?utf-8?B?V0FYN3ZWSFEwYUs4U0dGSWlnV1IrOE5janFvMXcyd3o5cUxBTHViUHNHcHVY?=
 =?utf-8?B?bWVMVHo0QkRUS3ArVFNuV3M0NERPa1pia0pWWjBrcm03L09FYkFKaE1NbFJY?=
 =?utf-8?B?ZEcxSWZwaW5FRk9sUGc2OTd1dXgyVTh2VUVwQWZNenJNUk1QMGZtTGFDZlZ6?=
 =?utf-8?B?VjVNbkw4Y0hxb0NWVWw5dUZZVFRHaHYvQ0p3YWNib1BHWGkvQkhZMWVSZ2tp?=
 =?utf-8?B?YUdnZ1AzVHV2SHlvQ0xocy9iQVhJNUtUajdFaUhhL1FYT0RjYXlyeXVVaGFt?=
 =?utf-8?B?aWtldjRkRHlCZVlLVjRGSUZLYVhnMkUvbkNUU1ZETUZkOTRsa3A3aThyaDdm?=
 =?utf-8?B?QzNPdVExaEoyRzNxeGVXdjNpbkdnRjBmZmRaQy9yNmJQbU04MTVlR3daQzdH?=
 =?utf-8?B?WE14RUtzVlMybk1YVHlrNGltZ25rckdpL1lZalMwUW5UWG9vaXhqc1NUTi8x?=
 =?utf-8?B?TnRzMEN5Uys3V0RIdmRtcHA2dFh3SXNENFFhN2ZQQ2hueDM5MVhJQTZVRDhk?=
 =?utf-8?B?NWoyV0pibi81QnE1ZWdtZHNCNUlpS09iRElLcmFwNnliSnEwVE1rTUlscWVw?=
 =?utf-8?Q?ljbuY2+v0xxLvujmmnjA3jYiF6MPkQumhAlKs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWxJKysvc2xzOGZ4WU9ZSGV5d3oxRWxsblNyTjVDeDhUUkRab042dmFEcDY5?=
 =?utf-8?B?aFJ1WkF5YTlFZFF6WTJIZ2VJV2R4eUpMUG5mbEYwd1NWdUQ3cVFIVU1wV3dR?=
 =?utf-8?B?UnByVndjOUhSdDFsRGtqQ1JGb28xazZDV3BlenA0dFY4Y0JmczhqNDZRRTcw?=
 =?utf-8?B?bEFuSTh0eVpBN3ZEZk9YN3BHWkNCNFFxMGxPcHcwVXV4VTZOdEtXNTZxdmp4?=
 =?utf-8?B?RFB3QTExSHRWSjhMSXA5N1pSZUZGSU1CQkcyTkk5UE5MaEFsZE4zSmlhTmg4?=
 =?utf-8?B?bkVHaWkxaDdkdGtxQS9nOHQ1dEwvTHg4ZlRpdGJSamJaZ3JEZHRVUkJlUlBt?=
 =?utf-8?B?VFZyTzNBejFoUGJrRHdYVnhwTHNvMm1HaTJKUjNiQ2JEVXhJRHlqK2RjRXFR?=
 =?utf-8?B?dVVPMDNtb1BhQXp0MSthTWw1c3FWand4bmdQSC9ONG1ta1pWTTJZczFQdjln?=
 =?utf-8?B?K2pHSnNoWHZTajVGSitKSTVVV01PUmJEajZQQUNqWmZMZ3RGcSt1dEwzYSty?=
 =?utf-8?B?WmtMQVRnQ2lQTlhHdGpneVZyd21sZWdhWm52NzFnZWhlWkRjdTl5VHFjcGdZ?=
 =?utf-8?B?S0s0TVJjNXFzTktZa2E2R1lQK2pmdkU0SGpydnZXVWxUNTNJYTgzRmxjNjhy?=
 =?utf-8?B?QUdLTnVZNFVqUWo1TmFUTHBhbDhYNklGaStzZUh6RkZ4Y2J6M0UxK1BkVHZh?=
 =?utf-8?B?SlREZGI5Q1JrNnNra2dvRUtDenRGT0dueW1nd1gwcXkxWGpocFdqZVpOVFd1?=
 =?utf-8?B?a0V2L1htbDBGZXJtd1VOL0ZMQ25VblZBeE5aR08yYVUvZ3NNYTB1amZLNjBz?=
 =?utf-8?B?N0IrcnEyRDdwQlI3OFowcmx6dXB6d2N0V0tuY1YvRThRaDVLWUQ3YlFQNEE4?=
 =?utf-8?B?TmR2MCtnMXhLbFg5VnoyMnVDVWVtVlZrSEcwNTJ1TWUzZzB3UjkwRTdXZXVI?=
 =?utf-8?B?a2kxczNFZ1lXeiswVkwrZGd6ZE1jY081TktTUXoyK1FUMm5BK3dzU1cwNUh2?=
 =?utf-8?B?d1lqckRQYzlYVVA0ZGhydkowL3c0TGFyYTBrNGNSb0Q2YVVxUk1XMVROcmFo?=
 =?utf-8?B?SFJMa1ExcUI5QTBpT3ZmR1NlbnhKbEZWQ0ExMkwyQmNZV1B4MWorNEpOZlo4?=
 =?utf-8?B?NGp0UzJIZzd2TWE5SjhRL2FkVEI1bFN0N3lLZ3V0bWJWNS9qdnd0Unl6aUFX?=
 =?utf-8?B?c2xTU1dteEdYM3VKZVNjcThOb1JmREVjaUFKWmV1ZHZ0LzRWZmdDZjhrWWhv?=
 =?utf-8?B?cW44dkNpOExlc3FrdUpmdGFpUlBCUjBjYms3RVg4V01vWFF0YjZrNDZqM25Z?=
 =?utf-8?B?MUQvTk8rZTN6a1oxYk9UNTR4SkowMFJZR0RoNUVSVHBkQ054NVY3ZUVaSlJj?=
 =?utf-8?B?a0hWTGVJV0JJMklOZlJMNDR2VjVjeEJDVDhVejRLaHFVNHpSTFcycUVCbk9Q?=
 =?utf-8?B?bE4yeG9Ic3ZWNlUvcVR4dzdlVEcxbTFaZGdhOEMzRDZSRXMxZUJSemtUZFF2?=
 =?utf-8?B?eUtJbGx3d1VTQWpNMDJYNk03T05PRVRDWExsR1NUNHN6a0dqckdtY2dwekUy?=
 =?utf-8?B?VElSUFBRSjYvb0E0RmdnaVphWjk2M05kU0NKTjF0VkJmc1hIcFRhY3lueE55?=
 =?utf-8?B?cks1eWNQNzNSaGtwM0lEbWFKTUJNS3REQ0hIRmRLNkpIWDlsS2tHUzh6ZVVV?=
 =?utf-8?B?Wnk5Y1hSakRZMzRNeFgveUp0ZDV1NDlqaDlEaTFaYVdjQkpTek43VU8xaGxu?=
 =?utf-8?B?dlZUWVhMWUcxT05RMlVRQ0VKTUtENHZ1UWh3c1NMTGJwU1plRDZDSnNZYU1T?=
 =?utf-8?B?VWF6VWdlNGpjaTIwTWtrSWticDdYT1cvVFdxVWhoSjA0dTBuQWV2SU1sUmg4?=
 =?utf-8?B?amt5bVUwZTI2Z3doUXltVEk0RFlidGhPMTV4Vnp1d0ZnYlVkSW9mVHl1a1Nm?=
 =?utf-8?B?cmFpRVVMeTdQQUphUitYOVNlcnF5QWdBV1Q3Nk1mTHEwVU1OOTNGVTNIWTl0?=
 =?utf-8?B?UXRHcng5WjFDQ0owMlh6NlExeFFFTENTLzZ1L3phbUQ5cnJoNllvK2tHV1dS?=
 =?utf-8?B?QVZNTkVaS3J3UGRjd29UTnVPaWppQ0JPR0QwQStoc2RSUFNyZDBGQmFpbDlz?=
 =?utf-8?Q?Q9lid0H+jbBh1nCxqhqTsDg8h?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ace0014-0252-46b9-25f1-08dd93c142b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:00:41.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4NGQY7eYHM+ejNs7Y9WFpo2s0jcPM0EI3fdLpRSECv6UNLt6A024Nav16XUwI2D1c4RKM4xmavM35FpsdkocA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8254
X-Authority-Analysis: v=2.4 cv=ItQecK/g c=1 sm=1 tr=0 ts=682601b7 cx=c_pps a=+tN8zt48bv3aY6W8EltW8A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2Fbpa9VpAAAA:8 a=XYAwZIGsAAAA:8 a=sozttTNsAAAA:8 a=m7XD2D8YMnL-FmNz2MwA:9 a=QEXdDO2ut3YA:10 a=AsRvB5IyE59LPD4syVNT:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE0OCBTYWx0ZWRfX00UxSzP3KEx2 8qR8/YKm32AaOdQWTHIVQKQM2l9fTyMsa47UaEF6qbjPI22MNM2qlyzdOq6xKkPWU+vvJ39qjK3 e7zIzB2t9+VgxB4LCu64GqgbW5BznvZz5HpLG81Jlvw18PvU9g6hVXeshd5L73fCBzhVpjD8gLT
 AVew2/fKN/sJk/QK76PCqkSjPqFzk+lRk4Ot0VolRVZ6rIOCCYi+aEB2aupD4iBoQVcJUtJkVdk XyDagXKklrms5r6oafic+CK8V2pXuiaR3XubaIs8aEWd3asiNzqucpZg0QbwTfOXMr0v55k/uBB MWaL//ebKSw/rI4uFDZSf+mbJAowQWH/IKzP4kJvMebA+f4WDWS3dP1ie2pI9stvu/HZB3tZpiE
 /EpCb7SgUW+ugKKf4A5o2mEv+zcNnCkFeJ2BUsu02hp7SQTYPmKU/L6JXl09JOEfUm90ZZoI
X-Proofpoint-ORIG-GUID: v9gSJuG8AyuMEPcKRXpPN9mgpXiXXFXc
X-Proofpoint-GUID: v9gSJuG8AyuMEPcKRXpPN9mgpXiXXFXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505150148

On Thu May 15, 2025 at 3:49 AM EDT, Greg Kroah-Hartman wrote:
> On Wed, May 14, 2025 at 06:52:27PM -0400, Damien Ri=C3=A9gel wrote:
>> On Tue May 13, 2025 at 5:53 PM EDT, Andrew Lunn wrote:
>> > On Tue, May 13, 2025 at 05:15:20PM -0400, Damien Ri=C3=A9gel wrote:
>> >> On Mon May 12, 2025 at 1:07 PM EDT, Andrew Lunn wrote:
>> >> > On Sun, May 11, 2025 at 09:27:33PM -0400, Damien Ri=C3=A9gel wrote:
>> >> >> Hi,
>> >> >>
>> >> >>
>> >> >> This patchset brings initial support for Silicon Labs CPC protocol=
,
>> >> >> standing for Co-Processor Communication. This protocol is used by =
the
>> >> >> EFR32 Series [1]. These devices offer a variety for radio protocol=
s,
>> >> >> such as Bluetooth, Z-Wave, Zigbee [2].
>> >> >
>> >> > Before we get too deep into the details of the patches, please coul=
d
>> >> > you do a compare/contrast to Greybus.
>> >>
>> >> Thank you for the prompt feedback on the RFC. We took a look at Greyb=
us
>> >> in the past and it didn't seem to fit our needs. One of the main use
>> >> case that drove the development of CPC was to support WiFi (in
>> >> coexistence with other radio stacks) over SDIO, and get the maximum
>> >> throughput possible. We concluded that to achieve this we would need
>> >> packet aggregation, as sending one frame at a time over SDIO is
>> >> wasteful, and managing Radio Co-Processor available buffers, as sendi=
ng
>> >> frames that the RCP is not able to process would degrade performance.
>> >>
>> >> Greybus don't seem to offer these capabilities. It seems to be more
>> >> geared towards implementing RPC, where the host would send a command,
>> >> and then wait for the device to execute it and to respond. For Greybu=
s'
>> >> protocols that implement some "streaming" features like audio or vide=
o
>> >> capture, the data streams go to an I2S or CSI interface, but it doesn=
't
>> >> seem to go through a CPort. So it seems to act as a backbone to conne=
ct
>> >> CPorts together, but high-throughput transfers happen on other types =
of
>> >> links. CPC is more about moving data over a physical link, guaranteei=
ng
>> >> ordered delivery and avoiding unnecessary transmissions if remote
>> >> doesn't have the resources, it's much lower level than Greybus.
>> >
>> > As is said, i don't know Greybus too well. I hope its Maintainers can
>> > comment on this.
>> >
>> >> > Also, this patch adds Bluetooth, you talk about Z-Wave and Zigbee. =
But
>> >> > the EFR32 is a general purpose SoC, with I2C, SPI, PWM, UART. Greyb=
us
>> >> > has support for these, although the code is current in staging. But
>> >> > for staging code, it is actually pretty good.
>> >>
>> >> I agree with you that the EFR32 is a general purpose SoC and exposing
>> >> all available peripherals would be great, but most customers buy it a=
s
>> >> an RCP module with one or more radio stacks enabled, and that's the
>> >> situation we're trying to address. Maybe I introduced a framework wit=
h
>> >> custom bus, drivers and endpoints where it was unnecessary, the goal =
is
>> >> not to be super generic but only to support coexistence of our radio
>> >> stacks.
>> >
>> > This leads to my next problem.
>> >
>> > https://www.nordicsemi.com/-/media/Software-and-other-downloads/Produc=
t-Briefs/nRF5340-SoC-PB.pdf
>> > Nordic Semiconductor has what appears to be a similar device.
>> >
>> > https://www.microchip.com/en-us/products/wireless-connectivity/bluetoo=
th-low-energy/microcontrollers
>> > Microchip has a similar device as well.
>> >
>> > https://www.ti.com/product/CC2674R10
>> > TI has a similar device.
>> >
>> > And maybe there are others?
>> >
>> > Are we going to get a Silabs CPC, a Nordic CPC, a Microchip CPC, a TI
>> > CPC, and an ACME CPC?
>> >
>> > How do we end up with one implementation?
>> >
>> > Maybe Greybus does not currently support your streaming use case too
>> > well, but it is at least vendor neutral. Can it be extended for
>> > streaming?
>>
>> I get the sentiment that we don't want every single vendor to push their
>> own protocols that are ever so slightly different. To be honest, I don't
>> know if Greybus can be extended for that use case, or if it's something
>> they are interested in supporting. I've subscribed to greybus-dev so
>> hopefully my email will get through this time (previous one is pending
>> approval).
>>
>> Unfortunately, we're deep down the CPC road, especially on the firmware
>> side. Blame on me for not sending the RFC sooner and getting feedback
>> earlier, but if we have to massively change our course of action we need
>> some degree of confidence that this is a viable alternative for
>> achieving high-throughput for WiFi over SDIO. I would really value any
>> input from the Greybus folks on this.
>
> So what you are looking for is a standard way to "tunnel" SDIO over some
> other physical transport, right?  If so, then yes, please use Greybus as
> that is exactly what it was designed for.

No, we want to use SDIO as physical transport. To use the Greybus
terminology, our MCUs would act as modules with a single interface, and
that interface would have "radio" bundles for each of the supported
stack.

So we want to expose our radio stacks in Linux and Greybus doesn't
define protocols for that, so that's kind of uncharted territories and
we were wondering if Greybus would be the right tool for that. I hope
the situation is a bit clearer now.

