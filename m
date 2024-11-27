Return-Path: <netdev+bounces-147585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B929DA625
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 11:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DEDCB22EBD
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 10:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC895198E74;
	Wed, 27 Nov 2024 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t5hCxvie"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09D198850;
	Wed, 27 Nov 2024 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732704554; cv=fail; b=T/A/Bb6zgHVomRWXl1Roqg4wQsW3WVgImrSWxXyCiHx7tCLBuc2LS6BLitF6LCJmQxIJ11mKVUtc1e1HUcTK4K7NyuaXE2nTPdLU6ZjTqbzjECDtanf/679lUxr+osbMnGRA9z+wszLkqtRxDChvDlXcfcAYUzfaa1B39gCK9PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732704554; c=relaxed/simple;
	bh=N/PoLXnd2s+tCLEHmjDSkLHcjTClrzOVf+c4OJt3Hjw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AZFFMjKtMJqUuWICnq/YUbusNSg/zaF95dvBUnzPsR5+aSWbgEsnLP/PSYxv14pgkTpdoRa6KqNNZ2tSNQxSSDzerJldoLg1uyT+sF5uegDzV0jgoJhQLjsMmvo9N6f+WaHAONjDKLOV2ioQF7dNKbXv7bYE/luHOWeEYk7xsRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t5hCxvie; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcvJlMiJYZ011X6HYzCO/wHSsz9/5hqACxJr3wWSYQ5mXmaZHJW711kyKd1pigwd6xXVfnjqyxcYYHS4Ax4QGzHgyuRuESEr51mSc6hEkoM+CHE5pw9oE+dPi1bntgBFHSX4Y9BTvBS2eylMmTGerBPUymy4j3Rhi2rpNxR5YE9VPRPULYw793+d3vdGVia0EufrKuULHlEytSstHz2iZEdr3gLgWsz4X/ZDCuFonabsIL1pk74UzANqSI8Hu0TI8BbTItH3/dPnmcB3U2RatVRVhXIANN+nuZsx/yWSTr9RQSojXocqDJ+fuuP6aC/kBQsLpxIy/V0QxiZt2SIrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/PoLXnd2s+tCLEHmjDSkLHcjTClrzOVf+c4OJt3Hjw=;
 b=vFwZQ2QFMMlvaIV3ca1MAruI8aa+waTJqLrunbGQNJRYLuyZ4KEQ13ZW7lrBXOfQYBPiykFUyF/F2SAgihFMI/30q3nZj9fGIOvg0fG5j37A5J6T7+MMSUgPU72JX+u3x61L2ts7GrDF5mxrcXRdYTiWHZjgqRMRs1Pftp4IwYuvsFUJR2/pjd/TQaCcX8jK1JZDMCNIk8YhkdhGhW6d88QYPTrXwGE30928pJxDV73Crxvuv6EiC89C+3Lbv2WtDSkx+AmunhLw0Q9MNQzxpxx4D9qSkJZc/bZfZJW7uKTRJMUpPBNwdxQgbALVM4Y390CkqGvh9DL9VuWpTIWAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/PoLXnd2s+tCLEHmjDSkLHcjTClrzOVf+c4OJt3Hjw=;
 b=t5hCxvie75zGoFKSniG5bud9O6DEMJ2GcT6ajyhNBH2PwYFf+u3jr8cH/nWM/KV2nIVf9ohe9sUYXsQEU8zmGvfoMlJ0BcjD7jnU9L2IR0jBGEfFh1od2aPNQ77hLTIgyl/pVkCqXs/W9RZ2o8GjRQQJuwvFDkLlZFF4V4ZP8QoTp7+fvc+Ui0HFUgEfHPZNqtvmWlLaSjWXUW4R/oibNCXHFxCPXbBYzdy4/C7KM2rKElU4Kchz7xXT8UuBmqA/iSYoVU08Nk9IrySPfV8RQfrrM5OUKLFH/VvxK3ElYzVWKv98lInohWkCO/QwVj0Xwz8YCUfn1pZnIMBEm9MBJQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 10:49:10 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%3]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 10:49:10 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <jacob.e.keller@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>
Subject: Re: [PATCH net v2 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Thread-Topic: [PATCH net v2 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Thread-Index: AQHbPMhxyo9k5olCKE6AJRp1Vi8GwrLJZfuAgAGUbYA=
Date: Wed, 27 Nov 2024 10:49:10 +0000
Message-ID: <8f06872b-1c6f-47fb-a82f-7d66a6b1c49b@microchip.com>
References: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
 <20241122102135.428272-3-parthiban.veerasooran@microchip.com>
 <1d7f6fbc-bc3c-4a21-b55e-80fcd575e618@redhat.com>
In-Reply-To: <1d7f6fbc-bc3c-4a21-b55e-80fcd575e618@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SJ2PR11MB8537:EE_
x-ms-office365-filtering-correlation-id: 2ef1e9d7-177e-4d92-389b-08dd0ed11fc7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHQ0ZzFncWpNOWlpUDc3bVZtYWRzSndRell6L1p5L1ZqNGZxT3Fwc1pZODY3?=
 =?utf-8?B?Y0N6UEN0aXV6bzVDL21YelZQS2FkVnZuWVRSM3Vod2R6TWw2RWZhNXRxaVp2?=
 =?utf-8?B?ZlJNNWM1OHl2bWsxRmEyUHRkaEplTndZZ0ZJc2x6aVVkeThEaDJYQ2xaVVNr?=
 =?utf-8?B?NUo4SGJobGVmYU1RcXcwMmxpQzBtSWQzaGZrVncybVpTdkZUc29ONldJSlpo?=
 =?utf-8?B?UkE1dnkrQ1NxcURhYnZscTNJWDJYZnJLVDlOUld5bHdpb1hNN0tEWkxUM25O?=
 =?utf-8?B?MStteWZGYnZOd2dBK3ZQcmh1VVowSVJtTDRZZU9VbGgrdUdsc0dqTVVWZU1R?=
 =?utf-8?B?Y1lGQ3NOOVRIbWZmdDhFK2VVeVZwYzM2c2NDVjlWNzdOMC82ZWh4aWVYQVNO?=
 =?utf-8?B?Rmg2RnRoem1Rc0J6cTJyQkt1YXcwcmh2N0ZDRGxTS3NVVjNlSHFqUlJsMDRx?=
 =?utf-8?B?UVU5Y1k0OFp6bmtrNmgrRFF1SDB0Q1VaWStOdUhIb0Q3QmhGZnpxY0hSN2l2?=
 =?utf-8?B?V0xnd1JiL3dQL3RuT3A3VVZJdGtkaHlIK3RFdW9tWHMxTEdsenluZnUxY1pw?=
 =?utf-8?B?cGJPT2o3UmFKdW1meUw1MzBSakZhRm5OSFN6T25MR3V6aE1hWHNQNlZEdVF1?=
 =?utf-8?B?eXM1cHp0Mm80LzhtR3IzUXBWMGt4UWNlRXhQOWNNRkpQZ1lNRFFhS3NQYi9Y?=
 =?utf-8?B?Ry9uMnJYUW5aVkhQYnZERkdub0VDaHE1OGxTRkdaYkdkSVI3TWs2RkQ3VXMz?=
 =?utf-8?B?dlRDMmpNdVdZSEljbGtQYjFhZDRLaXZhUUUvaEI0NjU1aVlraENGUkY0L1Iz?=
 =?utf-8?B?VWF2SXVKaWQvN1prNU0yYnJTRWxmVWswVnNrRlVLNlMyVmZzempDWG1KL3My?=
 =?utf-8?B?SWZzQ1FqVHpxeWFqUzg2czdVSGNVQ1FHWmVLUk85Q1ZEZnFwcmJsb1lQdms4?=
 =?utf-8?B?WEhWQ0VCWUVhZ2gySWM0WXpiaHcyamRRcHBaMVhVQ0NlcWIvSXJJbWZNeEZC?=
 =?utf-8?B?VjZuNzJCeVpXQXBQbzU1LzVqL0U1azhSUDM0ZWduUFdFQmVkTm9USUFZeGlK?=
 =?utf-8?B?ckZFK2VpdFBlY3hnbzlhSWQ4dUtWYjd5OHd5SXpZSi9tcWM2L2tOU2djT2Jh?=
 =?utf-8?B?VzRDREhZVm52N09FY0xIWFo5Sm53dFAvd0k0OEZndXNuUkthc0c5dHlhc0dk?=
 =?utf-8?B?Ymppd2oyM3dyWUp5b2ZPOThTUkl4T09wcE1NR2c5Q1JyZ2cvUE9lSFAvVjVv?=
 =?utf-8?B?OVBlQ0tyYzBRcjFwMUNOZlJVKzI1VVlFd3M1aHY5d0hodDJCeDFhNDZ1bnJ1?=
 =?utf-8?B?N2I2MHZ4RlVPR2grYU1qVjdGZm5hL3hqNUFxaS81L0VWUEpMZDM2WHlxdmdU?=
 =?utf-8?B?Ykh2YzBmUWVlcHBMdEVzTHJyVnQrczNqUHcrajJQd1FnLzZpa2lXaVBtbFND?=
 =?utf-8?B?L3cwbCtVQnFZdUJodTRmOUJJZXpjVVBCYzM2TFhtNWhMd0d5c29JT2lJTXRo?=
 =?utf-8?B?Wmo0NSt3alEwdjNZeUR3djVIVVZ3VlVrU1VSWUhXRlV4MWxWdDdRUUxXL3Bw?=
 =?utf-8?B?L1pUMlVEQTZ6NG5abWZ5ZzVhbDlhcnRNKzRKMlQzMy9TdVllUFVQQzkzeHJI?=
 =?utf-8?B?bkI5WE5oVnRTYTRCRkptY2szVW9HbUxDc2xpNWkrUEpCZmhrQnlWRUhKdTlR?=
 =?utf-8?B?Yk80ZjVqMkR4dFA5T0ZIRWw0V2RSUUlqY092Z2w5NXIwTmN4UytKMzYrVEtE?=
 =?utf-8?B?S0xWQWE1eTdVYVlMOHRacGpNQmZwUXRQQlVmS1JUQ05ISVFHOWcyN0poWSsz?=
 =?utf-8?B?ckVWR3dKWVo5dHllMjVSN3U4c0Y3eFhZaDlNZEYvakxEbUJZVTl3WVUvT29G?=
 =?utf-8?B?aFN4TysyNGllczF1dWpFcE5BSjVlTlBDUHFKTlZGM3pNV3c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlh1Zkt2ZHpoNHd5bkljTFN1cUdwVEIzWEhETldzVWlWZE9vOHBiYVJsdnNj?=
 =?utf-8?B?K2lyK2hpZWUyNS9QaENyakVMSlJROVAvZFJLM0tpdkZ5bE9mWVBvZm5WZUlF?=
 =?utf-8?B?bXpRZkZPVWtxRlBzdlZ0QzlvTmswb3RHNDVpSXdHallzWVFQU09zL21DQWFk?=
 =?utf-8?B?cWpJUU9WUGJuWGpqVnB3NnI0Y0NGZ1ZiMTE4NFFwRFdidFZqa2YybEJCSGpl?=
 =?utf-8?B?OGdyaDl4UjFScFJzd21oOUJ1V1d0ZmVZeWFxay8rUXZvcFVzaTU1bG1kTTNj?=
 =?utf-8?B?NG9LcXNhWDVNWTkvbWFWVU51MEJjTG9BNlR2akNWZUpiOVppdWZ3N0NxNFk5?=
 =?utf-8?B?VWxqSWpHRUwzOFhtc3Q5TXZKdXhNK20xSWZZT09uUzQ3Y3UyTXkyQjhQSFpy?=
 =?utf-8?B?VUp5b25ENS9qSmd5WXdna3ZncnU2YmQvdW5ZaEJNSmRpa0RMK1o1Y0w0QkF3?=
 =?utf-8?B?VTA4d1l3S1NFb3B1WVpnZFVRL2kya2JqSWMzd3B2aUFkN3JsQ2FVaWlrZzg3?=
 =?utf-8?B?eGZZMFNkT3pzTE1qOWRveWpFS1U3MW5MRnNxRW1SUndqbUNteXlJbzcyRUho?=
 =?utf-8?B?bEVRWmhkb2ZyNVk1dkpKZGNXbTVzN3RPbnJBeVU4Mk5HZlJHTi9VNUdobVNi?=
 =?utf-8?B?RVppZXFSZ0JXak5COGhFeGtIOC9UN3lvcEhHemUxRTFicTJUcnFmVnFDQ2l6?=
 =?utf-8?B?K29CMlZvS0lmdWFsd3pBQU42ZFNIanI5UXluUVVZa3p2MXFhdGs5VjcrcHBD?=
 =?utf-8?B?R1pmTG0rRkRHczd1VnF3aER1K0t0KzMzdzVIdTNORnNUY203NnJVcURlWTVI?=
 =?utf-8?B?UEozRmJrL3hxVzZEeE5IRGRBM1hFWmduRGNKSk5RWTBEc2szajhVaEdIdTJs?=
 =?utf-8?B?VmpWaklCVXlZV3I1Yld4cFVoVXZabkVmb3NZc2NVblcyZG4rSFpxZXF6RkEv?=
 =?utf-8?B?aWZGTGxIVlpJdU9hcjgxa0tISlRua0NWczZnYm9ZT3hMRXd0OXVBYm9jVHUx?=
 =?utf-8?B?SEtjUFJ5YUF6TUUyREs1eXh5cFA3clZmWjhqVHBtc215bFFob2FWWHJYYU4x?=
 =?utf-8?B?Y0VqcGRUS0RGWmd6ZmJsWWRUbDI3VmpPVXRpb0RJdmsvY0NVYUVnWnBqMUR3?=
 =?utf-8?B?UGRicGpsbTN3TFFxMHhUSzZzaVRlSENremkxZWZRSFNqMVBGMVd5MnAvRUpv?=
 =?utf-8?B?aVg4c2RmZXJZVDdEUW0zeXFwZmo3M3hHdTF4dFNnR1BZZ3JFcjY4REpJa3lz?=
 =?utf-8?B?V3RjdStsQUhjeVRtdHdmK09teWFWKzhaR2MzZGkzZk1Xd2QyTlN6c0J6T3ds?=
 =?utf-8?B?bHRjQkkwUGZEZTlyTy9RYjExbDdKNE5VcC9yT1VzbWoxbVo0bWJGNlMxWmpT?=
 =?utf-8?B?VTVkbjFsTDlpM0pVZUd3WWliNTRib3BQRXdOL2dnekNIR3MzRW5PTUxHaVdh?=
 =?utf-8?B?ODgweldaNWR3REFKL2pEd29HMVV5ZEMvVEh1b0xkZkE4UVFvYW1SOTBKMTNK?=
 =?utf-8?B?cFlEM2k1cXRCZk40bGQvL0xGWitITkZTWCs4SWcyaFZOYnhta0tHMmd3bFhi?=
 =?utf-8?B?VWF0WFNFRFFKN25EZ2lkdVdBd1M2ZmY4K3J1eUhpNVptc1dmeEhyUWg4dEc2?=
 =?utf-8?B?YkJlMGJKR1R2MXozMFpXZS96cWJpeHJ5NVFPUzZHbUMrMTc5NGVFK0RMZ0VU?=
 =?utf-8?B?T0t3NmcxYWNhRDFiQVlSMnptenFpK3lkTG9wTkd6cGh3Q0ZBZ0hyc0ZnL2s0?=
 =?utf-8?B?aGthelY0MVNYcUNiUC9FMUsvSTlyRHFLR3hyNi9pUzlHYzJObXVDYzN4T3Vk?=
 =?utf-8?B?UXpoMkFJMHg5VSsxaEJwWlBVVmVyU0NOOHg0alNPdVQ5dlJxL01pUXM3Q3Zs?=
 =?utf-8?B?czIwOENOc2pvNDRJanpVTUdodHVkWkttWmFkbkdNM3hqMFlsNEhmTXdiUEo1?=
 =?utf-8?B?SVYyNXduZSt5SkNhdFMyUzBZS3NWQ3RrWnNuVkVwOXBZZEFmbmNMYmQzcXhp?=
 =?utf-8?B?N0xpQWd5V3R3NmFlMExYckhvTXhSUjhKbUFXaHFwTUlUcXJQN1JHQ2JpWXQ0?=
 =?utf-8?B?SGdSQUhqa3lMZ1J5TTcyblQ2RFVUVVpxdnp0S2xPOVlGMTdZWW12aU1RZDdD?=
 =?utf-8?B?NENTUnFZazZaMDc1NURBUTR4N3pPZHk2K2lGUUJ0QnJyRGdzcVVaT1hWcGE4?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6633541ED48CC3449A73EEA9F24FAA3D@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef1e9d7-177e-4d92-389b-08dd0ed11fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 10:49:10.0131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wnpG1qaBnXLLYpnsqSK/uaRHnv/AW6jfQJriBCJKaA/M/tDQPEo7eYKjgwSAkJnIoEcHaFPFhmloNQl9TKZvR02JXHUukXuX8pEDmlB66mpPLTVw9aUctm9ZEX7ifh0a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537

SGkgUGFvbG8sDQoNCk9uIDI2LzExLzI0IDQ6MTEgcG0sIFBhb2xvIEFiZW5pIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDExLzIyLzI0IDExOjIx
LCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+PiBUaGVyZSBhcmUgdHdvIHNrYiBwb2lu
dGVycyB0byBtYW5hZ2UgdHggc2tiJ3MgZW5xdWV1ZWQgZnJvbSBuL3cgc3RhY2suDQo+PiB3YWl0
aW5nX3R4X3NrYiBwb2ludGVyIHBvaW50cyB0byB0aGUgdHggc2tiIHdoaWNoIG5lZWRzIHRvIGJl
IHByb2Nlc3NlZA0KPj4gYW5kIG9uZ29pbmdfdHhfc2tiIHBvaW50ZXIgcG9pbnRzIHRvIHRoZSB0
eCBza2Igd2hpY2ggaXMgYmVpbmcgcHJvY2Vzc2VkLg0KPj4NCj4+IFNQSSB0aHJlYWQgcHJlcGFy
ZXMgdGhlIHR4IGRhdGEgY2h1bmtzIGZyb20gdGhlIHR4IHNrYiBwb2ludGVkIGJ5IHRoZQ0KPj4g
b25nb2luZ190eF9za2IgcG9pbnRlci4gV2hlbiB0aGUgdHggc2tiIHBvaW50ZWQgYnkgdGhlIG9u
Z29pbmdfdHhfc2tiIGlzDQo+PiBwcm9jZXNzZWQsIHRoZSB0eCBza2IgcG9pbnRlZCBieSB0aGUg
d2FpdGluZ190eF9za2IgaXMgYXNzaWduZWQgdG8NCj4+IG9uZ29pbmdfdHhfc2tiIGFuZCB0aGUg
d2FpdGluZ190eF9za2IgcG9pbnRlciBpcyBhc3NpZ25lZCB3aXRoIE5VTEwuDQo+PiBXaGVuZXZl
ciB0aGVyZSBpcyBhIG5ldyB0eCBza2IgZnJvbSBuL3cgc3RhY2ssIGl0IHdpbGwgYmUgYXNzaWdu
ZWQgdG8NCj4+IHdhaXRpbmdfdHhfc2tiIHBvaW50ZXIgaWYgaXQgaXMgTlVMTC4gRW5xdWV1aW5n
IGFuZCBwcm9jZXNzaW5nIG9mIGEgdHggc2tiDQo+PiBoYW5kbGVkIGluIHR3byBkaWZmZXJlbnQg
dGhyZWFkcy4NCj4+DQo+PiBDb25zaWRlciBhIHNjZW5hcmlvIHdoZXJlIHRoZSBTUEkgdGhyZWFk
IHByb2Nlc3NlZCBhbiBvbmdvaW5nX3R4X3NrYiBhbmQNCj4+IGl0IG1vdmVzIG5leHQgdHggc2ti
IGZyb20gd2FpdGluZ190eF9za2IgcG9pbnRlciB0byBvbmdvaW5nX3R4X3NrYiBwb2ludGVyDQo+
PiB3aXRob3V0IGRvaW5nIGFueSBOVUxMIGNoZWNrLiBBdCB0aGlzIHRpbWUsIGlmIHRoZSB3YWl0
aW5nX3R4X3NrYiBwb2ludGVyDQo+PiBpcyBOVUxMIHRoZW4gb25nb2luZ190eF9za2IgcG9pbnRl
ciBpcyBhbHNvIGFzc2lnbmVkIHdpdGggTlVMTC4gQWZ0ZXINCj4+IHRoYXQsIGlmIGEgbmV3IHR4
IHNrYiBpcyBhc3NpZ25lZCB0byB3YWl0aW5nX3R4X3NrYiBwb2ludGVyIGJ5IHRoZSBuL3cNCj4+
IHN0YWNrIGFuZCB0aGVyZSBpcyBhIGNoYW5jZSB0byBvdmVyd3JpdGUgdGhlIHR4IHNrYiBwb2lu
dGVyIHdpdGggTlVMTCBpbg0KPj4gdGhlIFNQSSB0aHJlYWQuIEZpbmFsbHkgb25lIG9mIHRoZSB0
eCBza2Igd2lsbCBiZSBsZWZ0IGFzIHVuaGFuZGxlZCwNCj4+IHJlc3VsdGluZyBwYWNrZXQgbWlz
c2luZyBhbmQgbWVtb3J5IGxlYWsuDQo+PiBUbyBvdmVyY29tZSB0aGUgYWJvdmUgaXNzdWUsIHBy
b3RlY3QgdGhlIG1vdmluZyBvZiB0eCBza2IgcmVmZXJlbmNlIGZyb20NCj4+IHdhaXRpbmdfdHhf
c2tiIHBvaW50ZXIgdG8gb25nb2luZ190eF9za2IgcG9pbnRlciBzbyB0aGF0IHRoZSBvdGhlciB0
aHJlYWQNCj4+IGNhbid0IGFjY2VzcyB0aGUgd2FpdGluZ190eF9za2IgcG9pbnRlciB1bnRpbCB0
aGUgY3VycmVudCB0aHJlYWQgY29tcGxldGVzDQo+PiBtb3ZpbmcgdGhlIHR4IHNrYiByZWZlcmVu
Y2Ugc2FmZWx5Lg0KPiANCj4gQSBtdXRleCBsb29rcyBvdmVya2lsbC4gV2h5IGRvbid0IHlvdSB1
c2UgYSBzcGlubG9jaz8gd2h5IGxvY2tpbmcgb25seQ0KPiBvbmUgc2lkZSAodGhlIHdyaXRlcikg
d291bGQgYmUgZW5vdWdoPw0KQWggbXkgYmFkLCBtaXNzZWQgdG8gcHJvdGVjdCB0YzYtPndhaXRp
bmdfdHhfc2tiID0gc2tiLiBTbyB0aGF0IGl0IHdpbGwgDQpiZWNvbWUgbGlrZSBiZWxvdywNCg0K
bXV0ZXhfbG9jaygmdGM2LT50eF9za2JfbG9jayk7DQp0YzYtPndhaXRpbmdfdHhfc2tiID0gc2ti
Ow0KbXV0ZXhfdW5sb2NrKCZ0YzYtPnR4X3NrYl9sb2NrKTsNCg0KQXMgYm90aCBhcmUgbm90IGNh
bGxlZCBmcm9tIGF0b21pYyBjb250ZXh0IGFuZCB0aGV5IGFyZSBhbGxvd2VkIHRvIA0Kc2xlZXAs
IEkgdXNlZCBtdXRleCByYXRoZXIgdGhhbiBzcGlubG9jay4NCj4gDQo+IENvdWxkIHlvdSBwbGVh
c2UgcmVwb3J0IHRoZSBleGFjdCBzZXF1ZW5jZSBvZiBldmVudHMgaW4gYSB0aW1lIGRpYWdyYW0N
Cj4gbGVhZGluZyB0byB0aGUgYnVnLCBzb21ldGhpbmcgYWxpa2UgdGhlIGZvbGxvd2luZz8NCj4g
DQo+IENQVTAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUxDQo+IG9hX3Rj
Nl9zdGFydF94bWl0DQo+ICAgLi4uDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgb2FfdGM2X3NwaV90aHJlYWRfaGFuZGxlcg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAuLi4NCkdvb2QgY2FzZToNCi0tLS0tLS0tLS0NCkNvbnNp
ZGVyIHdhaXRpbmdfdHhfc2tiIGlzIE5VTEwuDQoNClRocmVhZDEgKG9hX3RjNl9zdGFydF94bWl0
KQlUaHJlYWQyIChvYV90YzZfc3BpX3RocmVhZF9oYW5kbGVyKQ0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQotIGlmIHdhaXRp
bmdfdHhfc2tiIGlzIE5VTEwNCi0gd2FpdGluZ190eF9za2IgPSBza2INCgkJCQktIGlmIG9uZ29p
bmdfdHhfc2tiIGlzIE5VTEwNCgkJCQktIG9uZ29pbmdfdHhfc2tiID0gd2FpdGluZ190eF9za2IN
CgkJCQktIHdhaXRpbmdfdHhfc2tiID0gTlVMTA0KCQkJCS4uLg0KCQkJCS0gb25nb2luZ190eF9z
a2IgPSBOVUxMDQotIGlmIHdhaXRpbmdfdHhfc2tiIGlzIE5VTEwNCi0gd2FpdGluZ190eF9za2Ig
PSBza2INCgkJCQktIGlmIG9uZ29pbmdfdHhfc2tiIGlzIE5VTEwNCgkJCQktIG9uZ29pbmdfdHhf
c2tiID0gd2FpdGluZ190eF9za2INCgkJCQktIHdhaXRpbmdfdHhfc2tiID0gTlVMTA0KCQkJCS4u
Lg0KCQkJCS0gb25nb2luZ190eF9za2IgPSBOVUxMDQouLi4uDQoNCkJhZCBjYXNlOg0KLS0tLS0t
LS0tDQpDb25zaWRlciB3YWl0aW5nX3R4X3NrYiBpcyBOVUxMLg0KDQpUaHJlYWQxIChvYV90YzZf
c3RhcnRfeG1pdCkJVGhyZWFkMiAob2FfdGM2X3NwaV90aHJlYWRfaGFuZGxlcikNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQktLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
LSBpZiB3YWl0aW5nX3R4X3NrYiBpcyBOVUxMDQotIHdhaXRpbmdfdHhfc2tiID0gc2tiDQoJCQkJ
LSBpZiBvbmdvaW5nX3R4X3NrYiBpcyBOVUxMDQoJCQkJLSBvbmdvaW5nX3R4X3NrYiA9IHdhaXRp
bmdfdHhfc2tiDQoJCQkJLSB3YWl0aW5nX3R4X3NrYiA9IE5VTEwNCgkJCQkuLi4NCgkJCQktIG9u
Z29pbmdfdHhfc2tiID0gTlVMTA0KLSBpZiB3YWl0aW5nX3R4X3NrYiBpcyBOVUxMDQoJCQkJLSBp
ZiBvbmdvaW5nX3R4X3NrYiBpcyBOVUxMDQoJCQkJLSBvbmdvaW5nX3R4X3NrYiA9IHdhaXRpbmdf
dHhfc2tiDQotIHdhaXRpbmdfdHhfc2tiID0gc2tiDQoJCQkJLSB3YWl0aW5nX3R4X3NrYiA9IE5V
TEwNCgkJCQkuLi4NCgkJCQktIG9uZ29pbmdfdHhfc2tiID0gTlVMTA0KLSBpZiB3YWl0aW5nX3R4
X3NrYiBpcyBOVUxMDQotIHdhaXRpbmdfdHhfc2tiID0gc2tiDQoNClNvIG9uZSB0eCBza2IgaXMg
bGVmdCBhcyB1bmhhbmRsZWQgYW5kIHRoZSBwb2ludGVyIGlzIG92ZXJ3cml0dGVuIHdpdGggDQpO
VUxMLiBIb3BlIHRoaXMgY2xhcmlmaWVzIHRoZSByYWNlIGNvbmRpdGlvbi4NCg0KQmVzdCByZWdh
cmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+IFRoYW5rcywNCj4gDQo+IFBhb2xvDQo+IA0KDQo=

