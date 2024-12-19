Return-Path: <netdev+bounces-153486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45909F8388
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF3E188B490
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA419C54A;
	Thu, 19 Dec 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XH42sZNi"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70918633D
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634224; cv=fail; b=t+WR+9WlQZdbPd8roHhYSeCdweLzP6FCgCHdfgBWiEqEGRKZ9W9vrLChqHPi1eKjQcXZVU69UA1iAcxuSb9sf3oH6ayQOwZikByNA3ZbNBL541FW0fk/4TrFzQfvrFeQeGgRGP8pe+SrxudAos8NEKIlq/Z4059mXq+3zrYjkK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634224; c=relaxed/simple;
	bh=wmoYUAqK3+Eynt1a4VfpZpUnjhyq05LifdcxbUh1nI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b/MfX1fnVXQ6uJY3WWeWJU6NkE2Tt1Bt5D9GSXnyUmr52uPd2P1Ijow219lMGnoYXh0T9HVrojDjejmLrcmpGAqOD9E5dV0EaF0t349L140zrjsPzuIvJ8jBbTgwpCGQMSXsKsPXEI5NfM0SUgapbET6keirPIJAU+SdaJC3Stk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XH42sZNi; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxGWZCvsI/l/dKc5hmQXIKIO1Q/sB0Z+Ieqw2/9SI/R+absmDbGQLhKGimlnDstIMqGNHvANOdV7QAvIvtfR++tZM1Kev2azqrhzNTBZZklJDG6ai+eTHgF7MXenGwEtDYAtdT96lObDumkKgcI7FxnL+ShGwPgenQH6FBmoHQ5TzVUZ1746D+YsQhKgZF/FFifTb5rZHNFaiYWXffSxBxd0Jy+bXiiWGyADnCn++SHE+lXzBeL/NVthlEf0PicRyiEjf75yjaAszeJUHAYzOJkZTqYFHPDAW19nOvynieUQtEOy6v0aZvdtiFD1cpI6qTGisaDYLXA1EkhQd6gHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmoYUAqK3+Eynt1a4VfpZpUnjhyq05LifdcxbUh1nI8=;
 b=j1Ge4tJSAEv38KlhJ5rFPqeyReVx4/YpDONpAzxOLYMN08MYyLwvb8iNHFKWt7hcs662DZ9t2i/OwV/YZ/EFtohzXwlop0fYh+SsoPjvdhc67PeJAbXofqt9jK3tQfMhSDba0eJoB8xTOhJB3k9Cbaes4stkMHdttwA17Nsp0UyW2MtQWoevp56chaQbGXibUBnK5TcGN8URUbDWHdx+2G4498DXPksNERwOisDHGDOslXnbAI/gt9cdhqAZOqtHGeAXRKO+7f36Ai9kggNf86VqysanfQhlHGuaBnAP+J+vhc7UoEHiiLCNxi1da4Fu6KxYPdKQE8IPHfX3fkOFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmoYUAqK3+Eynt1a4VfpZpUnjhyq05LifdcxbUh1nI8=;
 b=XH42sZNigOf4QWlZ+502GWo+o/FmuRjAlmeQ0qLhMvDE362HefVr6Cx1c/rA7bGCgDbIR8RkyMduUQ7WIUCz6oxkwIDBAqDHV7IRpq6Pl2ywA+QiXj1VJAMf3ku5bPR+B5wY7KiKijIRSc8ponfLUPPHu7V2q4SV/uM6Y6faJ4GNdkbNlPFGS2Xm9rJR1vtlyQspMYf2b6badY9fB2AmGOTWzadFKx560Kut90+z7FdxQepjKb+icfO9ZOABCf2nx5p+J5rtmE8vuBXoBZBCu+3ahXWTVRw9B2Hasu1mzfqBnUGluBJldEPFF0vYdK3ahFxFW87o1yRvYFfZG2n2gQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS8PR10MB6271.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:560::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.7; Thu, 19 Dec
 2024 18:50:18 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8293.000; Thu, 19 Dec 2024
 18:50:18 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>, "andrew@lunn.ch" <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: honor "max-speed" for implicit PHYs on
 user ports
Thread-Topic: [PATCH net-next] net: dsa: honor "max-speed" for implicit PHYs
 on user ports
Thread-Index: AQHbUjzGyeufL+QEMUu8gO9xw6AtrLLt12AAgAAR2AA=
Date: Thu, 19 Dec 2024 18:50:18 +0000
Message-ID: <eb62f85a050e47c3d8d9114b33f94f97822df06b.camel@siemens.com>
References: <20241219173805.503900-1-alexander.sverdlin@siemens.com>
	 <20241219174626.6ga354quln36v4de@skbuf>
In-Reply-To: <20241219174626.6ga354quln36v4de@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS8PR10MB6271:EE_
x-ms-office365-filtering-correlation-id: b392594b-ac3e-4ec7-e2e1-08dd205dfbf7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnRDT2JKWGVEOU1jeWIyQlhIRW9QNVA3dUVZUlhmVnZ1eDhnOGUwamN5WlJh?=
 =?utf-8?B?bjIxeWQ2ZS92Rm9sbzNmcld6UXJrbG5veWpjeHNuRkRGRElYVkNKL0ZxS2d0?=
 =?utf-8?B?RXBQbGZJL014Y1hScXFKREtNaDRTY3k5SklEZ3pCM0lzNjFjYU9UMEdSMGdI?=
 =?utf-8?B?dmhRL09DT1ExZE1MQzkzVDc5REpVVEgxb2VEaFRpOW9vcE9weHVnRStCVDdm?=
 =?utf-8?B?QkhKaTNaVTVOL3pwbzdQQ2JIK1Jud2RYcS9RL1ZjYnJMR2RMTFVzUWd5aWx4?=
 =?utf-8?B?RnpjRFI1TkM0L0ZQSVBwakdZWVVCK3JrZW5kaG9JeXA4a09IY3lWenhLenps?=
 =?utf-8?B?OFNsS0NuUmFSaVgyVGpXbmtxTzdPTVZvNC9QcFhxY2VEZzU3bnpJc3pBb3kz?=
 =?utf-8?B?NXJnOGdnWWxPeE9iUE9kTHNrN0k3UXo1eWlmWXpKcEh2NTdkcG5ibjdSbHhW?=
 =?utf-8?B?M0tPK2U1dEZyVDMxUU1nejJoOHEyQjdyZEVuYzNOaUE0MWZJM0c0bXhTZkpm?=
 =?utf-8?B?VXNBVDgzN3R6aVpKZUE5d1IwQlM5RmMwT2JES3cxL3prbTI4aGc4YUU1S0ZI?=
 =?utf-8?B?MDFJSEtSYnptRFRha3cxSXdwNjZtZmxFeXYzVWcyeXVHWGZ4ZjlQK01vYTVC?=
 =?utf-8?B?K2VRQ3RMcWppM1pZRHhTendhN1E1VDVNVTJlVlpzNC8wa2dPK0N3Zyt0MkJW?=
 =?utf-8?B?T0RreUdBSmsrQ2d6ZHgyK1ZUSnd3QUNaT1N0VGdBVzFuZ0JpM3BPK3I3K0NH?=
 =?utf-8?B?blo3RlJ1bnZsY0JtZ2tjUGQwUlZXMW4vSklacjl1eUdvZlM5TnkwM1BEb1Ry?=
 =?utf-8?B?UzRKSEJKcHVUZUc4bEt5eGJTam1ybDg4VmV5K1J4ekNEQjVENnc3N1ZVOTMw?=
 =?utf-8?B?VEZsY1lzaTZsWDE2bTJXalZSMUREaVBrd3VTMmtmTElmYVpjb2FiakhrOURs?=
 =?utf-8?B?dnd2b3VRTmhyL1dXNEs4UG13c0hjck4zRDNBajdSTlV3MGRhTkNZeEFjRWlq?=
 =?utf-8?B?M09FK1JaY29VL0Q1amxrRmdQQnVUR3pxZTVSMmp0bGJ2NWtPNkVXanpwbWxq?=
 =?utf-8?B?cFdkamtVbC9LUnhWNWl0YlllTGNOc0RBSVd6eFpHayt0U2FHZmN2MEhMNE9l?=
 =?utf-8?B?dmE1RG1WV29JUjhUMHhYSG9FL0FKSGluOHByZTY1VnhSNjlmcWs2Q3o0VFNS?=
 =?utf-8?B?bUMxQ0wrV1lidURrcVM2QXpMa2dtWFlKOVk0eEtQNGUyVHVkNDFnb2toQ1Fn?=
 =?utf-8?B?Vk56NXlHRUROSFBna2ZxZEJHVkEwT2ZwbTM3UlQ3bElITXE5VU9XYURpS2s2?=
 =?utf-8?B?SXUySXZ6blVUS2lvWVFaR1E3ell1WVErSHBxMk9Fa1dUVDVrM2VrYW1GOEx6?=
 =?utf-8?B?Uk1FakFuMUJ0U3hxWUZOcXJpYzBaSWIwSDJqTWdsTGxTeHl4UW14Z21pSERP?=
 =?utf-8?B?MktzeW9iVm5ZcldadGl6VEp2U25HSGxaSWdnZmRmT21sWVRhK01SK1FZQ0lX?=
 =?utf-8?B?S1ZxTnloNTlUOWlXTjkxSUgrMnRVckFjbEVxcjM3TUlEVW1nZWJ5R1pOeHl2?=
 =?utf-8?B?dTM4bWZCN2VnVmdXcUFrRzNScVVvSXoyRTFJSEtRanowYXUvcEI5akZYYW9V?=
 =?utf-8?B?a05BandmZUFiak9iTFRxTDRaRmN6WGdLdjR3VmxlY3VJcjl0WjF4ZktVVGk0?=
 =?utf-8?B?bE4yM3gzY2Y3QWlqTEZvcXpYb3liN3EzRUxKWkFROFBzS0tRa1RVRytyb1pF?=
 =?utf-8?B?VExPckxnQzRnQjZxQlMydS80VUROczNMazdhb0lzOWNYVjlHN2UrQy9iQzBX?=
 =?utf-8?B?U3ErQndRM1lWRTJkeHBmRVUyWDVoY0s2SlR2K1VBelFmUGVMSSthNm1FVHg3?=
 =?utf-8?B?UE53cWgyNElqREt6cHVaNUVNeXc4TWlEa05ZZEpzU09mSnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGNYU0g4SnhKcUdrSGttbjdFZ3lJNG04dnRkSnF0MmJrcVlaT21HM0FLVDRK?=
 =?utf-8?B?a2dWd2w4NGVvL1NQaWlGUnhpZklRbjVPMUhWZkpSWnQ4cUhIK0pzY1gyNnV0?=
 =?utf-8?B?cnBEL1JORWhzb2FvQkxEU1NMcTczTkxWNGdXSnlsd0pJS2Z2L3BodklCTlZM?=
 =?utf-8?B?c2lGNTA3enhNalI4U3BsUWJ1ekh2L081TGJGb2FUUk1HUWtZUzd5Kzl5MEJM?=
 =?utf-8?B?UFJ2ODBIWGJVUXpWbENlSUlNZkwzczhGNzJkSnFvYkV4aTdDTmFhVWszYWdr?=
 =?utf-8?B?NVhXZmd2QklicFM2SnRQSy9MSkFmTi9kMXVJNmRlamt2aTB3MGgvZ2JONmw4?=
 =?utf-8?B?N2E4M1lNVkdwZlRTRUNkMWJsK3dObmE5dnExdFk4R2RDYnhYdFhHU1RiK3RS?=
 =?utf-8?B?dlB2OHd2VWhNUTgvYkxUQjZiY0FKWngrb3E0Q3ExbXJWdEFPY1JWYzFhazgx?=
 =?utf-8?B?amxqaWk5eG52V1IwMHdxSmc5TGNDSW0vUk5jK3h5ZEVMZnFXTlpyRFRJWWhv?=
 =?utf-8?B?OEdKS3hEakdXMEF2V2pmaU5hV2dON3NOendvZjFqTlRCUUNVblcvcXNlSmpQ?=
 =?utf-8?B?ZHM5UUpZYkhMZUhjL09yVW1ETFVRTDhCTFFYNlk3cTJXdk1TYzhOa2NFNVFq?=
 =?utf-8?B?eXY4Q2JPb0Nsdnp4ZklsVWZneWpaV0NTRDVTcDA2WWUxUjIxWVNyK0JjVmR3?=
 =?utf-8?B?NDl6Z1NoUzJCUzlDMFBZVFU2Wlo5dXlXU0wvRHVjSnNGaHlVR3JJSVRnb2FL?=
 =?utf-8?B?RTFMOEYxZC9hL1ZYWmdjVEFxQVVNZjRhdVVickpNNTZMT0ozY2pMZFo0TlJO?=
 =?utf-8?B?TWhHcjhMbm1tWG9KbTBoYUFTdTRhSVU1eFVJYWdydGtBQ1BmaXV3YzVZTkZY?=
 =?utf-8?B?RlJQUWpIOWtCbmVrUk5UWnNoRklzZFhwUWY3S3Q0TGRYbWR2aVlma0VscTdr?=
 =?utf-8?B?VXl5NU5sM1JlTE5KYU1PVXdDVEs3ZWdIcS9vaVhJM3ZLclBYaGU4MVBKQS9m?=
 =?utf-8?B?Mjl5ME1zcFdZbGhpbXAzbEZSUms5SXlobVpEbmpOMXZEWVdFcnE2T0t1bmJu?=
 =?utf-8?B?dks3OGlmSEVVNytQbURRNDZVdGpkUzJKcCtkb1llU2E5WWVFTzB4T2RjZUVK?=
 =?utf-8?B?Tmh2aGxGaWRIRE0rWmJDSGhFc1ZOR1ByTHQrTzlVallPdkp3Umg0UnlLT1NX?=
 =?utf-8?B?WndoY1FMU3p2V1lvRkRxSzgwaUpxbFpLeHY3ZktrUkVqR3NPTUlNcEhEa3RI?=
 =?utf-8?B?b1ZISlZwcUIrdnZVZXdyS0phS3M3bU1zSVEwdGtaa3dZNlhyb1Z6MytoNnJo?=
 =?utf-8?B?S0N6bDgvSW1IYkJRSTJzbGdEWTUrUGh0Wk54d2NlaFI0bHlGOERRQXhKc0Ja?=
 =?utf-8?B?UjJTaDQvZkJldmxLS2ZBWEpXWVNsSXlRd2I2R3E3REhJUW5KcEZKM0ZmakRq?=
 =?utf-8?B?U3loSDdXaUV3aXF4TGR4VDRKSFpyd1F2aUx4STVXQklsaDlYK3MybTBVYjNp?=
 =?utf-8?B?cVRuY2U4S0dKUVdaM2o0K1ljZ2NCVml6cnRQRHFlN1loVmJRM0FMZXZPRyty?=
 =?utf-8?B?bHhLSTBuOXN0OHkvS0IwLzJoQTJxRDA0Y2pHVHZoZ2lnMnZJN0hIeHhpUDFN?=
 =?utf-8?B?bU9mZTVmaXEvRDdYc3RRNlQwNVM4dWJvRk5La3BKbWZCWjAyTTMxNXViMks1?=
 =?utf-8?B?b0JsU3VmWWFGY05XUWJEdFVMZmZUc2FlOEZVOExqeFcyajgyanFXNzEzbWww?=
 =?utf-8?B?V25aVkVqcFZseHNpMElTYjdnaU5oNkh2UUo4U1VnL0toUnhhMDZvNnREVnFO?=
 =?utf-8?B?MHhLTGxzYkw3TE5aVVVBd2psSXAxYmZXaUlVQ1V4Tk5keUpITFZEMTg5a1BU?=
 =?utf-8?B?OUpMaGlWYXh2b3NzTHBrc1FRbW9qRkJSZE5BZmdrNXA2SHdNUE41aUM2NjBB?=
 =?utf-8?B?SWo0Z0tJZ2xMVGNubG5JWXlwc2JnTC95RFR0MmhIaUNuVFZUdGVvVHFlbWVj?=
 =?utf-8?B?Z3BNZEZCd2xnRXdqdnVYSmMrQTBSd0RJMm41RDVON0QvTVBiQTNUaVlvWnFM?=
 =?utf-8?B?dE43aGdGVk5HMmxSTnpOOXkyNlhadmNiUjU4RjJ2RzJwWVFVMHd4RWtxT3Bz?=
 =?utf-8?B?VWV4enpBS1VjMlNjM3NmcWF4YmNhWm50dlI2cE5yZTJ6bTcwbTJ3Zk1VcGIy?=
 =?utf-8?Q?6klYt29TkteODSpImfPLi80=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AB6A6F5D42038429B4290CC7F04B3BD@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b392594b-ac3e-4ec7-e2e1-08dd205dfbf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 18:50:18.7321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3L8R0uBLuQERilgZptjFEsTTkjeYbDDTlxEuwQY19sqB1cKfvAFHTJy04tWherIo87uZL0SQ6qQ1ptr4Z9TyltgsqyNPaQ8KOu+9Sj8PAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6271

SGVsbG8gVmxhZGltaXIsIEFuZHJldywNCg0KdGhhbmtzIGZvciB0aGUgcXVpY2sgZmVlZGJhY2sh
DQoNCk9uIFRodSwgMjAyNC0xMi0xOSBhdCAxOTo0NiArMDIwMCwgVmxhZGltaXIgT2x0ZWFuIHdy
b3RlOg0KPiBPbiBUaHUsIERlYyAxOSwgMjAyNCBhdCAwNjozODowMVBNICswMTAwLCBBLiBTdmVy
ZGxpbiB3cm90ZToNCj4gPiBGcm9tOiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVy
ZGxpbkBzaWVtZW5zLmNvbT4NCj4gPiANCj4gPiBJZiB0aGUgUEhZcyBvbiB1c2VyIHBvcnRzIGFy
ZSBub3Qgc3BlY2lmaWVkIGV4cGxpY2l0bHksIGJ1dCBhIGNvbW1vbg0KPiA+IHVzZXJfbWlpX2J1
cyBpcyBiZWluZyByZWdpc3RlcmVkIGFuZCBzY2FubmVkIHRoZXJlIGlzIG5vIHdheSB0byBsaW1p
dA0KPiA+IEF1dG8gTmVnb3RpYXRpb24gb3B0aW9ucyBjdXJyZW50bHkuIElmIGEgZ2lnYWJpdCBz
d2l0Y2ggaXMgZGVwbG95ZWQgaW4gYQ0KPiA+IHdheSB0aGF0IHRoZSBwb3J0cyBjYW5ub3Qgc3Vw
cG9ydCBnaWdhYml0IHJhdGVzICg0LXdpcmUgUENCL21hZ25ldGljcywNCj4gPiBmb3IgaW5zdGFu
Y2UpLCB0aGVyZSBpcyBubyB3YXkgdG8gbGltaXQgcG9ydHMnIEFOIG5vdCB0byBhZHZlcnRpc2Ug
Z2lnYWJpdA0KPiA+IG9wdGlvbnMuIFNvbWUgUEhZcyB0YWtlIGNvbnNpZGVyYWJseSBsb25nZXIg
dGltZSB0byBBdXRvTmVnb3RpYXRlIGluIHN1Y2gNCj4gPiBjYXNlcy4NCj4gPiANCj4gPiBQcm92
aWRlIGEgd2F5IHRvIGxpbWl0IEFOIGFkdmVydGlzZW1lbnQgb3B0aW9ucyBieSBleGFtaW5pbmcg
Im1heC1zcGVlZCINCj4gPiBwcm9wZXJ0eSBpbiB0aGUgRFQgbm9kZSBvZiB0aGUgY29ycmVzcG9u
ZGluZyB1c2VyIHBvcnQgYW5kIGNhbGwNCj4gPiBwaHlfc2V0X21heF9zcGVlZCgpIHJpZ2h0IGJl
Zm9yZSBhdHRhY2hpbmcgdGhlIFBIWSB0byBoZSBwb3J0IG5ldGRldmljZS4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVt
ZW5zLmNvbT4NCj4gPiAtLS0NCj4gDQo+IFRoZSB1c2VyX21paV9idXMgbWVjaGFuaXNtIGlzIHJl
ZHVuZGFudCB3aGVuIHdlIGhhdmUgZGV2aWNlIHRyZWUNCj4gYXZhaWxhYmxlIChhcyBvcHBvc2Vk
IHRvIHByb2Jpbmcgb24gcGxhdGZvcm0gZGF0YSksIGxldCdzIG5vdCBtYWtlIGl0DQo+IGV2ZW4g
bW9yZSByZWR1bmRhbnQuIFdoeSBkb24ndCB5b3UganVzdCBkZWNsYXJlIHRoZSBNRElPIGJ1cyBp
biB0aGUNCj4gZGV2aWNlIHRyZWUsIHdpdGggdGhlIFBIWXMgb24gaXQsIGFuZCBwbGFjZSBtYXgt
c3BlZWQgdGhlcmU/DQoNClRoZXJlIGFyZSBzdGlsbCBzd2l0Y2ggZHJpdmVycyBpbiB0cmVlLCB3
aGljaCBvbmx5IGltcGxlbWVudCAucGh5X3JlYWQvLnBoeV93cml0ZQ0KY2FsbGJhY2tzICh3aGlj
aCBtZWFucywgdGhleSByZWx5IG9uIC51c2VyX21paV9idXMgPyksIGV2ZW4gZ2lnYWJpdC1jYXBh
YmxlLA0Kc3VjaCBhcyB2c2M3M3h4LCBydGw4MzY1bWIsIHJ0bDgzNjZyYi4uLiBCdXQgSSdtIGFj
dHVhbGx5IGludGVyZXN0ZWQgaW4gYW4NCm91dCBvZiB0cmVlIGRyaXZlciBmb3IgYSBuZXcgZ2Vu
ZXJhdGlvbiBvZiBsYW50aXFfZ3N3IGhhcmR3YXJlLCB1bmRlcg0KTWF4bGluZWFyIGJyYW5jaCwg
d2hpY2ggaXMgcGxhbm5lZCB0byBiZSBzdWJtaXR0ZWQgdXBzdHJlYW0gYXQgc29tZSBwb2ludC4N
Cg0KVGhlIHJlbGV2YW50IHF1ZXN0aW9uIGlzIHRoZW4sIGlzIGl0IGFjY2VwdGFibGUgQVBJICgu
cGh5X3JlYWQvLnBoeV93cml0ZSksDQpvciBhbnkgbmV3IGdpZ2FiaXQtY2FwYWJsZSBkcml2ZXIg
bXVzdCB1c2Ugc29tZSBmb3JtIG9mIG1kaW9idXNfcmVnaXN0ZXINCnRvIHBvcHVsYXRlIHRoZSBN
RElPIGJ1cyBleHBsaWNpdGx5IGl0c2VsZj8NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNp
ZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

