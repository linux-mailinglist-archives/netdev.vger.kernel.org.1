Return-Path: <netdev+bounces-152070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 627529F2942
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 05:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6AA188902B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 04:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CBB1C0DF0;
	Mon, 16 Dec 2024 04:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="7Czk0ZLP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF2153BD7;
	Mon, 16 Dec 2024 04:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322584; cv=fail; b=ME0Y9bOqphKlauOuGcHGjeNpw/mcqjUK5UhmUp0cB2CipTdii4ooeuNLYjvRA/ya+xIBjyLS0qGgbdGVSf/EfTw3BGMV+q+Hcz3F1m0MzvrIaGY0rT3ftOYq1zCZI/4eU6bHHz59hk8Fe5k+HURLshJGMATtHNnqTah7bcZzi8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322584; c=relaxed/simple;
	bh=Gl07q7/cjO/UVLmlYIJYBi/nS/og79m/IFXBKSj2lu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Or4kpDwPk0SVb0OIOMAebEzIlwpyhjEYMIgHhC9xofYkoy+acEoV+CAdAeGp3mgSi/MSvT+yRBdwCFaS1L6a73emJRKlh9xmxMrSihLFcxs0gyaK3nNfvMwB8rv8wa2ZaERQHghPcUTlK6gHItkB+w0QFRr5FHQ+8hepNClgNSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=7Czk0ZLP; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+pEdo/l8IwZD/3MW803UTnTEY+NRWG7FDW4zfW1qadeN3U4wqTd/MhprdTvpP6YP4teux3y1GbcU+2y/x3cCk/I21pQkenHN1/4cGKRRmgC7GFSmJaUET5CAS7OQmTKXN5Yh1e3UYfQUM22+y5b+oxXySmie8R7EFLXHcyCeZDty0QMO85BlSoc9QiwZrYr6IkvEVCTQC3nqDkmR7/50453T0s9V+Jb75Eu7gYTa2ADYwdxfBVdRNnzBKAQEyzq+G2sjEjqEpN/MIoi0Qs9wIocUReHqcJz4XxJn5URcEM5oTOHhXqnTIoucvw1bA2V8STnh7+Q+LDJYDfVDqz5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gl07q7/cjO/UVLmlYIJYBi/nS/og79m/IFXBKSj2lu8=;
 b=TzWdOk6VMZ/A4UrPTQk+/ZtUGz9BCt+2+ftLSWpDSrsyLVKucr7uy6Tbz8vZRj6ydEIdreCoyPOZhPa30L3MPS2PPer4mERQ2IPOFDTH/MynSDNpjrE+Z8OJ1Xkf+ZNwuN2QsS5YoxD6Aw7eTqXfyLWAEScpg+vS9CuXBWteVaGySudrhaxiqp/ftk01oN6l0gYorAkw3aF6EaCOKQPu8Yky4CKbftZV6TPFziEwPYWzymEYJZwYhOfI7SGlMICNwxzQMlt8RgaNXHURJggD1tbZwcsmfS6WfpH56nTN/NG43XA5JzBoYnlY1cDwllBxZMs6QsOyNl3k5I1autEIkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl07q7/cjO/UVLmlYIJYBi/nS/og79m/IFXBKSj2lu8=;
 b=7Czk0ZLPea2WZzi60iXu6gZlubHlesjVdeUc9lcRbM1I5BclDSmSPBuchClG8jgjHPQlN0JNeLkwnF5l0ht82K0scm50kU0OsTLTR0wAoEHV+cbmXIKf9y7twRVrNWexaBkP3Mq5rqFllSKNjRLtkmlNP1rHuuNxXj7SHFv4rpvRkPFIISkyEZFc03KgRxQLe357bSh+JgkUXfa0IMgK+gEIDBftiV+vjbBZqSpa4YwEJ7dVcfi7RMEJjPCAQjXNzYVGOxpZO5k2ZLiOsIbQ8yRuAeg4/OdEVbL3HpXKRaAnm122YnmldTQ6ZciKGlRMseepWEl4Fh+72crXS30vFw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CO1PR11MB5204.namprd11.prod.outlook.com (2603:10b6:303:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 04:16:19 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 04:16:18 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>
Subject: Re: [PATCH net v3 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Thread-Topic: [PATCH net v3 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Thread-Index: AQHbRlFobveu+PlKfkaa7qgOKnJVrLLeo4gAgAP0CwCAAXEfAIABDmqAgAM+wwA=
Date: Mon, 16 Dec 2024 04:16:18 +0000
Message-ID: <26aaf32b-7085-4ada-8bd0-a930b8bb51a8@microchip.com>
References: <20241204133518.581207-1-parthiban.veerasooran@microchip.com>
 <20241204133518.581207-3-parthiban.veerasooran@microchip.com>
 <20241209161140.3b8b5c7b@kernel.org>
 <5670b4c0-9345-4b11-be7d-1c6426d8db86@microchip.com>
 <b7a48bbf-d783-4636-8f75-35c9904ffe05@microchip.com>
 <20241213184253.7c8203ce@kernel.org>
In-Reply-To: <20241213184253.7c8203ce@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CO1PR11MB5204:EE_
x-ms-office365-filtering-correlation-id: 01665bde-a344-4ab7-acba-08dd1d886422
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YkYyWVRObS9BWnRpYUs3Ti9iM0wxZ2pUTWVlcnlyUFk1WjBRa2szdVVKVmVU?=
 =?utf-8?B?QXdoNU5rdDNEd20reWJyNEoxUUNmeXFVb3dlSkZXY2k2REZsYmRVb1dXUCtv?=
 =?utf-8?B?VXdKck9NUFNDcmpNZjIxcktMMnkxanVmYnQ3bmxVdExQU0REMXNQdXJ1akdy?=
 =?utf-8?B?NDFOaFJ6RkVxZVAwSmI5UDZaS1NuVXRpUGxFOFNjZFQ5ZHdrSXoxeU1BUGpK?=
 =?utf-8?B?Ym1vQXZmRHNhMEplQlAwRUxLWGhWdzVGcnZxenhza1RaS1hHdjFaWUtzTjBG?=
 =?utf-8?B?aURNQ2QvR2FTRStHaWVUcGtXRFMzeCtvV3pRM2U3M21hQnZSNnRIQjJlU0pm?=
 =?utf-8?B?UitncHlGbjJDOVIxUGZKV2lDeXdKUXdSdDlud0pPK1JDdW1hVnM5aUR5NWpv?=
 =?utf-8?B?ZHNoSHQzZDN0N294K0hpcjJsQ2x1d3o0bEFKSDMzeGJrd2YzNEtzejhBeUJS?=
 =?utf-8?B?Y0R2MURwb0JEbGhGMGxGQnlkcnBKb0hnTElSTHcvV3pYYmMvYVlWNGRmOXdV?=
 =?utf-8?B?aFhsdXNXNUFZTnpTRGIvZDVrWkpTU3ZCQnR2YjhaNDVyVUd6ZTY5UjdueVNh?=
 =?utf-8?B?QURTaGFVdzRJb040ejNWeE54VjFNcHNVSitNUjJXNERCbEUwc3RkZkxTbnJJ?=
 =?utf-8?B?Q0V4OTBMVXowdW9wRmVVNWxKbnRhcDZjODhpNEFYd3RQMmZibFNQdEYvakRy?=
 =?utf-8?B?Sm0wUkVLT2NXMVZXb2hKamRDSVZXeE1IbDB3NHpwRjRUbjJDL3RnN0NSYUtv?=
 =?utf-8?B?WWZrRG5xazFoZE0wbmx2ZnRzMTl5Y2dIaGcvZ0xPSW5EWTRwQ1N1d1VONy8y?=
 =?utf-8?B?TmxGWXBtbU1VVzZad2cyU25OZ3BlTVhnWGs0VzR0TlRsQW9RbThsNGlzOC9G?=
 =?utf-8?B?eDdQNmlhLzduUU1iWEtGQ3pzeDkxanNWb0dUWml0WVlSdlZOSDEvZEllU2ND?=
 =?utf-8?B?elVSYTJ0YStUYzUvNkpHWjJXZDhzSGNQL1hhakRaQmRtNkRvVS9mRERsNGc2?=
 =?utf-8?B?dU04YVBnbjNhL3ZPaWphSFJ4bnFDSVpOMlJmenFZRDlFcnRsUllodFNkSzRj?=
 =?utf-8?B?Nzk5VjlUa3RJUDNLbDJORDBGcTYxYWVDUTRZS2tQaXFPWkhlc3dWRkJQWDgv?=
 =?utf-8?B?YWp4Y0hTdDRmc1d1dS9icmdRVFVLbHNKT1hRUGExald6UVlSTzh1ZE9Wbmhm?=
 =?utf-8?B?aUFZUVlqclpHQXFUNithWktwc1ZpRHkrQnR1QnNLb3lUN3VPeTZHTGJTV3BM?=
 =?utf-8?B?R0JERUY2QTJzd2xlZ0JWeEVqLzgvc0d0Qmd4eXdYejRiTFpTSks4dEgvckdI?=
 =?utf-8?B?K2swdGRSQTg0UzM4WGk5Nkp5VlptcVo4SE5zL1dhY0dVeDJhR1BtUGoyN0F0?=
 =?utf-8?B?VHpZZExCTXgyZUg5R0RRUFduRTNYbkFsZGFLdllsSEp5M2pmQ0N3SUFHS0RH?=
 =?utf-8?B?TWwzMkFqM0RmTys0VnQxNFhJRHBrZ3U4ODdJNC9tRm1oTEZVWVFHUGJMWktS?=
 =?utf-8?B?N2RuZ3ArTndVZk5NY0x6YTVBYU9YNE42RXBDVTlQL3U5dnpMNzFSZ2kzZW4z?=
 =?utf-8?B?N2liL0JjaHJYN0grMzY0UVFvMzlhNklES1djMnFSbGkySitFcTVjMGRGRHpa?=
 =?utf-8?B?dHVBWVhPVkRSNjVlRUFJUldoaU5CQ2NjNG9KSm04MlJPWWtTVS9QT1QycVhP?=
 =?utf-8?B?bXNEcExHTTJYY21rMHlndkFiVHNIMFYyNEI3VlpPakpNWnRhM3hxcXlOUWJu?=
 =?utf-8?B?LzNIV1pTeWlxVXcrNnpvV3c1cGNRM25yRjdHREZTS3ptSnk2eDBVcW9RL0hm?=
 =?utf-8?B?U29VbndQV0NENzVMdWpwbXVBYThPdnJXd2pnZmo2bDRFUGRxQzc5bCs1eTZL?=
 =?utf-8?B?OTRDYlFKRHlUYmVldFBEVkxDSVh4QzkydEFHMjQ0SUVOV3ZUZVBiMGpGR2s0?=
 =?utf-8?Q?VAkd5/YwRFAXcmJESnS8VaTnNk5s9vfv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDlCZmRYMmJUb3FOSW8rVmp2eVJJUkIvQm1UcDluYmxSR3BNUlQzYXpkUXkx?=
 =?utf-8?B?L0RXYk01QXlqOUtjeHFVbnI0NXZVMzNYNVJwUHhsZ0JEelpvcjQwVk9XQ0VI?=
 =?utf-8?B?ZC9RUmpBSi83V3dmZWpRYkpzZjM0M3FLNG5IZjR1ZGZnWWY0TGYwQzhVUkYv?=
 =?utf-8?B?QWtJT3FMaVFac0tZZDlsZVJxZFozZlBXd0JnTmlBbnRZeG1oYnRYZDF2Rk52?=
 =?utf-8?B?TWFrZ0ZJa21GbFFTTkF3ZEpwVUZMc2tJR0ZuZXFvMXZheDJ1OVF3RDZCdWFu?=
 =?utf-8?B?WDM5QTBLOGwxUnNhU041R09TZ0hkUFlsNGN6VzVKTkc0OHFqcDc2SzhOY2VD?=
 =?utf-8?B?TDRMZVFuYkhKS0VDK1lTcVdTNDVnVHF1b3NmY2cxelo1SHArUGVyMGtiSThS?=
 =?utf-8?B?dlBoZFg2MGtyY25icS9hRytyUkVtMWIxRGs2amt6QWJxVHRPR0tUU1FxaTBK?=
 =?utf-8?B?d3hKckVpK3BOWmlVKy9WSDFnUUFHRW1lb29jYmVkbEY4M21aVVFDZDNIZGVk?=
 =?utf-8?B?SGxveWF5WE9LQnBhUU9TOENTa1lycnAvbEgrWTY5UFVaMzlzcTVvYjAyeU5s?=
 =?utf-8?B?MWs0bDVSalN6MklPTmNQWnhtWUVtakdCcmVVaVZTcmhMYmJucGloT0ozZlB6?=
 =?utf-8?B?UnRxaGU5SEFaREk3emRFekVFeGJjWHZQKzhCdDRLK2JFYVVESnBsdjJkTHp5?=
 =?utf-8?B?M0M1emQ1TTBmVFAzQmgxVEUvUFBRSDAzMDVudTBnNmxHNHYvOHA3ZVdBTHFo?=
 =?utf-8?B?YU5iamhqSmViem5NbzQ0b2pVYUtXSjh3eUhxNFNDQXh1TGtsRzRnZm9KUzk1?=
 =?utf-8?B?eXVDQ0lRWkhEWVN0T3RHaFJvTVE1RnBROCt0ek5aWUhMeGU5aHpqaVFJR2dy?=
 =?utf-8?B?QWNYZ1pScDhXWXA2ejlPTWxWNFJTWjRoUXlRNSs0dy8xdUJ5TmZhUkUrNDd2?=
 =?utf-8?B?eDdZVU1yczcrTitFWkREbVkrc2FuQ0R3SXpkbVczM0ZOTDVUdEM2UDNrS1ZX?=
 =?utf-8?B?YlE2L1RwUG8vUFcyUC94WGk0alNIUVIxK2t3ZEQyY0pxektVT1BITUxwT0hK?=
 =?utf-8?B?RlJaakJMQ3NhcDJKclhPYUNOR05UeGRrMmhWUysvVDgzN2w1MkdCei9UbW1P?=
 =?utf-8?B?d2psOUVrSXViVWFYbmFRckdldWxDRGc0YThCYVZ1clZKY2pWajVzcUFpK2s3?=
 =?utf-8?B?UTZBUkg4NHVoTXRIN0F3MDVjNUhOWUxpR1NqVk1BUU1zS0JvR1JGdmlUMnU2?=
 =?utf-8?B?eCtWV0IrMjdwc1dHRE9xSlJnQzlUaXkyUnZsS0k3dFVndTRoOW5vMWREOW0x?=
 =?utf-8?B?SmtJOHZSeGlCWWcrNlpWUlg3U3MrU2xzV0QrOVRsSTRJbllmKy9IU2loQjlD?=
 =?utf-8?B?MHRKNThielZGMUJKT0h6NE1xUmZ1Q25Xd1RVSTVDZlAxeXlUck9SdU5HRTV0?=
 =?utf-8?B?V2dDS1Bvc2lsQTZJMlRDR3hPbGVXb2ZXZFFKM1U1Sy80UnJVUTNETERyUGd2?=
 =?utf-8?B?VEcwUzRqMEN2LzRSK0NPUTRDUmxRRzBtUkJHNU96UjIyd2ZDakl6Uk55VDdn?=
 =?utf-8?B?dSt5WnJxRmdTSFNHckQ1YmFBdTBWeGlhZDlNRHNGbHRDRGFZbmtVYjJjVjNN?=
 =?utf-8?B?Rkozam4wcmljLy9zRXk1dU9uL3A2aWhCRFZKUzVkb2lya1ZHUVMvZ2crdkdi?=
 =?utf-8?B?SzIySVZtWGl4UTNzLzQ0a3h1V0g3Wkkyb2k5a2ZxRURsdkkrVlZNclY1eEYx?=
 =?utf-8?B?Zm1RU041cUMzOXhCL29IWWxyQ1FHaHkxVGEvRXhFL0ZjM1ZJY3J1VmlxNjJ2?=
 =?utf-8?B?N2dzZ3ZrbnFuWkpocGFrZ0VGeXZyNkJ2a2dnUlVXdngvbU5uVFJJdEhHTnhp?=
 =?utf-8?B?UkpUalV3SHlVQkkrSUJ6VW5sQ1l0RXpOWk5Ba2RUZW91aE1SQ2VLbWNQd0Fv?=
 =?utf-8?B?YWtlNkZ3V3RuWFQwRzhDRTJyb055MDZEakxGVnhJWkNESGIrczdIWEJYUUJI?=
 =?utf-8?B?Zno1UTduei9mNlpoK0dBT3E3NU0xNHFVSi9SY0RHRmxjRmVOWm4xOXdvbG4r?=
 =?utf-8?B?TmdmcUtsZ0hPNUxiZ0JqMGRIT3hBa2JZQ1dZNjdVQWk2WEpGeUtidzc1TmFB?=
 =?utf-8?B?cVpIbitBeUZJSWloWUJraVJVbVZocWwrc3BFVXgveVljREg5RmZoTHAzOFc3?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5B9FA53221C3540925A2FFE72CB8263@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01665bde-a344-4ab7-acba-08dd1d886422
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 04:16:18.9207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3CaNxIQKadhr99WX+/4Z4bbz11PjMOCOWBuaq7qzQYODgEWESlBSRt6McMdjnuHoru04/J3PaNP9UzGD0XrUAyP3hCsZE5lplOAOJJGBYxEIBWz3g5PjWS/cDskSurB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5204

SGkgSmFrdWIsDQoNCk9uIDE0LzEyLzI0IDg6MTIgYW0sIEpha3ViIEtpY2luc2tpIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIEZyaSwgMTMgRGVj
IDIwMjQgMTA6MzU6MDMgKzAwMDAgUGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20N
Cj4gd3JvdGU6DQo+Pj4+IHN0YXJ0X3htaXQgcnVucyBpbiBCSCAvIHNvZnRpcnEgY29udGV4dC4g
WW91IGNhbid0IHRha2Ugc2xlZXBpbmcgbG9ja3MuDQo+Pj4+IFRoZSBsb2NrIGhhcyB0byBiZSBh
IHNwaW4gbG9jay4gWW91IGNvdWxkIHBvc3NpYmx5IHRyeSB0byB1c2UgdGhlDQo+Pj4+IGV4aXN0
aW5nIHNwaW4gbG9jayBvZiB0aGUgdHggcXVldWUgKF9fbmV0aWZfdHhfbG9jaygpKSBidXQgdGhh
dCBtYXkgYmUNCj4+Pj4gbW9yZSBjaGFsbGVuZ2luZyB0byBkbyBjbGVhbmx5IGZyb20gd2l0aGlu
IGEgbGlicmFyeS4uDQo+Pj4gVGhhbmtzIGZvciB0aGUgaW5wdXQuIFllcywgaXQgbG9va3MgbGlr
ZSBpbXBsZW1lbnRpbmcgYSBzcGluIGxvY2sgd291bGQNCj4+PiBiZSBhIHJpZ2h0IGNob2ljZS4g
SSB3aWxsIGltcGxlbWVudCBpdCBhbmQgZG8gdGhlIHRlc3RpbmcgYXMgeW91DQo+Pj4gc3VnZ2Vz
dGVkIGJlbG93IGFuZCBzaGFyZSB0aGUgZmVlZGJhY2suDQo+PiBJIHRyaWVkIHVzaW5nIHNwaW5f
bG9ja19iaCgpIHZhcmlhbnRzIChhcyB0aGUgc29mdGlycSBpbnZvbHZlZCkgb24gYm90aA0KPj4g
c3RhcnRfeG1pdCgpIGFuZCBzcGlfdGhyZWFkKCkgd2hlcmUgdGhlIGNyaXRpY2FsIHJlZ2lvbnMg
bmVlZCB0byBiZQ0KPj4gcHJvdGVjdGVkIGFuZCB0ZXN0ZWQgYnkgZW5hYmxpbmcgdGhlIEtjb25m
aWdzIGluIHRoZQ0KPj4ga2VybmVsL2NvbmZpZ3MvZGVidWcuY29uZmlnLiBEaWRuJ3Qgbm90aWNl
IGFueSB3YXJuaW5ncyBpbiB0aGUgZG1lc2cgbG9nLg0KPj4NCj4+IE5vdGU6IFByaW9yIHRvIHRo
ZSBhYm92ZSB0ZXN0LCBwdXJwb3NlZnVsbHkgSSB0cmllZCB3aXRoIHNwaW5fbG9jaygpDQo+PiB2
YXJpYW50cyBvbiBib3RoIHRoZSBzaWRlcyB0byBjaGVjay9zaW11bGF0ZSBmb3IgdGhlIHdhcm5p
bmdzIHVzaW5nDQo+PiBLY29uZmlncyBrZXJuZWwvY29uZmlncy9kZWJ1Zy5jb25maWcuIEdvdCBz
b21lIHdhcm5pbmdzIGluIHRoZSBkbWVzZw0KPj4gcmVnYXJkaW5nIGRlYWRsb2NrIHdoaWNoIGNs
YXJpZmllZCB0aGUgZXhwZWN0ZWQgYmVoYXZpb3IuIEFuZCB0aGVuIEkNCj4+IHByb2NlZWRlZCB3
aXRoIHRoZSBhYm92ZSBmaXggYW5kIGl0IHdvcmtlZCBhcyBleHBlY3RlZC4NCj4+DQo+PiBJZiB5
b3UgYWdyZWUsIEkgd2lsbCBwcmVwYXJlIHRoZSBuZXh0IHZlcnNpb24gd2l0aCB0aGlzIGZpeCBh
bmQgcG9zdC4NCj4gDQo+IEdvIGFoZWFkLg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuIEl0IGlz
IGFscmVhZHkgcG9zdGVkIGZvciByZXZpZXcuDQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9uZXRkZXZicGYvcGF0Y2gvMjAyNDEyMTMxMjMxNTkuNDM5NzM5LTMtcGFydGhp
YmFuLnZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20vDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJh
biBWDQoNCg==

