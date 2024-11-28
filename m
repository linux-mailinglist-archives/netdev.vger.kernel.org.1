Return-Path: <netdev+bounces-147680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 915089DB293
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 06:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06856B213B4
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 05:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF3713BC18;
	Thu, 28 Nov 2024 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R3SKSVbM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFFD12C7FD;
	Thu, 28 Nov 2024 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772610; cv=fail; b=mHv47Ghh9iYUnTY96LQkQzUUp4h5EDM/KQmmUvwFGjIYjLdxXyGCrXpLFPd6KM6PzkHPDVqMYKg0PTBG+8h00fWWIkryMRTunkcxYNrHAmfAGeKjtjpKVmppyCXGBWOc7bL+pw9Co8FygTPIZbhrH6gSsw7cQt1c7l5IdwpJn3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772610; c=relaxed/simple;
	bh=+fqOEGULT7KWLNEj1cF2zHw+icsxvhfdck+ls39m9U4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WrXa/uKWqT6mzI7bHCBMwvAka73//O7L5D1iU56+yRkLZo9Pq+Lm6DcFrrCzI6xhlAbYq6Fw9wmFRjrBaXkvezdYIdwvqByRIA4aUVImNNv90IytYOJ0IxEHFf9AcWmRLLAx2JTEPR6ArVAPuCiy1xP3+ZA47iR2s9CSh5e6czA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=R3SKSVbM; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M099SHpqiHU6R1q6wA27+W26nnIhgKWe3PMFyGRZf23OPlKm65ux+etgSwOyM+QGPkct1wCCLbo1v3Q+LuRzfBiD1TvO1IGh7VwVVN6zfM2dg1uriDndEXMCyutfZvNdB3cZO4L/i6TBwJKvD02E3BfShAKfZuWntBU82gixrXU+NFWq2yBwHGBF9P87jIeMzApHMmRsMgohaNgA2urpfSDy6tP/t9UXPs/VGjSBssL7im0gjjVF5S800yl0p2Mt0973f/sWJNI8DRLPIqZQM6INGHGVJ5Eqpa3u5MZxhitY9KeUhM6CthTU3QN+tNpbThWpLmlsbHJa9FEEvi39dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fqOEGULT7KWLNEj1cF2zHw+icsxvhfdck+ls39m9U4=;
 b=rvuSwN1/JV1skubWYLDMOqyE4iWCgFvucMdhAm0o0tqf27I+nI+A9HKSewRvQva7FhhYuLS8y1AvbU+Q1DY59jH9iK0irHBDeSD/Rncjv8uRaPtnVbx0I9nR/ph75npSa4FUya3W+08ri/Pq1vs5h3OqpyXdCDs98KblsCwrBQlNUJV5KyxKqllgodln8xCg3K/i2KCe3fBCzEoUbjC5SZRfuKGqYQdIFFFD6BHrTlFropEwBsb8RRQGIEUBG56J1v3NU+yIwyx3djj3mvBs/m/BXkLTGf91f7In+RjMy3thmKBd973r2HNEpuNYXhMpj02G3v62JGZjT1D3kfPKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fqOEGULT7KWLNEj1cF2zHw+icsxvhfdck+ls39m9U4=;
 b=R3SKSVbMtAYdA9dyK3mQ/fv4Zpw9Dsom5gNr3xWTgmMS0egtInVeqGf3peqhY1rnI2uWiGT6df8Fal75/S0/iCga2pp1FhQu9X25IpWruLnf7zCD/kHJ9VmzJOvkyjkZ/YXGZz4iA/NvKkQzh5RwmYrpkvDahyIiuiOw/Nq6G6zo6S4GVwqwWUgTOmh0r3HO1554ECy5fvFgWJUz0xxbzDce8HyRDpP9swISyqd3kc0ZwslAzfB97rhbdxy1pYc9LGZX7ZlzBSKhAEj0LOa80I8rCV7+hCCMMZWop9M79zSpXuQceUHQcOsBxy2lid/SH+O+yi5QxFqaeoE/sboNZg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CH0PR11MB5315.namprd11.prod.outlook.com (2603:10b6:610:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 05:43:22 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%3]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 05:43:22 +0000
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
Thread-Index: AQHbPMhxyo9k5olCKE6AJRp1Vi8GwrLJZfuAgAGUbYCAABbkgIABJgCA
Date: Thu, 28 Nov 2024 05:43:22 +0000
Message-ID: <b3e23d57-3b3b-474c-ae45-cbbf4eaaef3a@microchip.com>
References: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
 <20241122102135.428272-3-parthiban.veerasooran@microchip.com>
 <1d7f6fbc-bc3c-4a21-b55e-80fcd575e618@redhat.com>
 <8f06872b-1c6f-47fb-a82f-7d66a6b1c49b@microchip.com>
 <7f5fd10d-aaf9-4259-9505-3fbabc3ba102@redhat.com>
In-Reply-To: <7f5fd10d-aaf9-4259-9505-3fbabc3ba102@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CH0PR11MB5315:EE_
x-ms-office365-filtering-correlation-id: a3775716-eefa-47d2-13bc-08dd0f6f91fb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUxaSlhxVUdVVG9FckxtaFdDY3JvTmU4L2MycUhEVDJpeGtUUFVHZjBnR1R3?=
 =?utf-8?B?cWo4aVhHQzNvMUFLWlFrbEZpZ1ZlNzUwTy9rcVpGTS92ZEV1RFBnZlhtSmFz?=
 =?utf-8?B?NVBLbUcrdW91MGN5V25NbFlPR3pGYXNUQmU4elRNS1h1WU9FZ05vOS9tZkJy?=
 =?utf-8?B?aWZxRjFUcXBPdE5kWlJnYmZma0IxSnhUaDAwSTRSanV3M0JGZGFxdXlWb3o0?=
 =?utf-8?B?dGRvSnBVSEYrTmphb1lUdVZPTm9BYlVZbDRvVjZZTUk5bko1YWxqWVpJV1lu?=
 =?utf-8?B?TUtwQ2I0bXNIVzNkREdvVTROWFZheTQwazd0WmtFbmtHdGNCTC9MSlBvSUla?=
 =?utf-8?B?dW9YU3duZVRyWGZyLzJJT1c3NXhEdzRsbVJqNnNnOXdoeTZIVEJCWGg5NDhx?=
 =?utf-8?B?S29aV2haTVN2ZXVEOGtVZ1psY1AxVUZjbDUxVTVxMGNNNlNkY1ZSNVMzNjU2?=
 =?utf-8?B?QlNtQ2dINXZ4dks0RXY4bTFiZWNmQm8wdmxHRWpJNWVOYnVKS2tGUmtUWS94?=
 =?utf-8?B?QzErT1FodEh1cFR2bVFVQmZucU03T2VycWovaUlrRmtmd25WMzVDQUdpZy9Z?=
 =?utf-8?B?UWxQc3dDYVN6TTJoaXQySEdRa1JNdUFoQUY0THYzdEdHT3dKd2tWNUpjVXYw?=
 =?utf-8?B?azd1ZkY2aGZ3WHZyR0FGUUQ3d0NyaytWZnk1bDZDemtxVVRFVGw0VkVyL1Iv?=
 =?utf-8?B?UXBOYm9aaGVQTXB3T2ZpNHhRYm8vbklNNm1rZWFrb0RoM1lubjdnUXZId1J6?=
 =?utf-8?B?eS8ySHNNa2VZRVZyUGF4TVFZbWVoM0cwbXY1dlZNWjlyU2dsR2tjSkUvQmlU?=
 =?utf-8?B?TlRER2pXYkx5Z2JnWEs4UVFHdklxUVZXTm5tSTRTYjU2Zy9nL0ZqNk0wN3Qv?=
 =?utf-8?B?TUNjRTJ1aEhlbFRFN2pnYklXRUZXUFp3bE9lQmxkTHFERjhOOFBBNGRCeFBs?=
 =?utf-8?B?TlpZcWxyZENvb01PK3dLakNzNVFXemVxenBPTndoSVZUZHBPQjQ0aU9ZKzIy?=
 =?utf-8?B?TVAwN1d6NzI2bDk4bktwY01VSDdWY1hiV0J5RGhveE4yYjlBQUhFaFFVWlhu?=
 =?utf-8?B?UitVM3JBNEY5MUtFdzcvZXVUUjgzRUZpbU1LSURPS25qaUdrZFVHMW5VQVd2?=
 =?utf-8?B?aW1Bc2hmTm5Tem5lWVA2WXJ4Z1JZcHIySTJ1dlFKWjRjYWEzWHl4aXd6Z1Zr?=
 =?utf-8?B?aHNtSXZGazJMeEsyamNzRFd4UkNYTzlOVnoxQVlnaHFIcEg1aXZ0NVE3WGVU?=
 =?utf-8?B?akxrWlNxYlY5TzRjRW5wUGp4UkYvMWczR1JyUENPSlkwV1IrbWxCRDNoV3NL?=
 =?utf-8?B?Y20wTkZNRGF5aFpXL09MUUh4SzV4bG4vcnVueDQvWWcvdDkwNWtZWVppMVlZ?=
 =?utf-8?B?cU85enZ2bmp2OWljNDVvaEkwaFRScUVXZFlqdDNyd1AzbmpGeU9kZTdiRGVO?=
 =?utf-8?B?bytXSDZCT3VNNWxpL1ZadnNiTUwwbjdZd0lwYXV1cHlUZVdwQnFXd3BTcGZx?=
 =?utf-8?B?NzJCNmMwa050dnNuZFFjSnZWRkVuNk9mcHpYNm5Cc1QyQzVoakUvQ3Nwd016?=
 =?utf-8?B?VGhaRERFblU3RXRZY095dlFtT0dzempGMEcrMWdYY205RTNJTGNWWTBGTFBm?=
 =?utf-8?B?eUVrUm1OR05BWWtGRGZaOW9IaFk5cnhkWXF1WEtMN3IvKzBQd0FlbUZPZU9S?=
 =?utf-8?B?YVpBL2h1V2MwaUNpL2lET00weTE1ZDR6ZXJaRFR2eUI2KzRvZFMzSTREVVRX?=
 =?utf-8?B?VzNNUkdtTVQxbUZoZWZYMFBzYU9EQ1ZTQ3Y0TmZnRXYzVWZ1cnRoa1ZzSm9v?=
 =?utf-8?Q?MCfhKFBz3p9CSM701+Dt4zPiVfETT6ZWoPohI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDVobFM3OEJFTlNsRWZyNUFGSGxZTWFESlppZkttY1BPSGlLTTAwSy95TXRv?=
 =?utf-8?B?S1Naak53TEVFVDBKUlZ4NEdDZzJ5NW1tOFFFc1N0Rk5PTHYrSVBBc2hVZWcy?=
 =?utf-8?B?VG5rKzd6T1U3c2svbkRIQzduTWZYajNObHlMUXl6NUdIMlpsZU5GQzZZbHJV?=
 =?utf-8?B?UFRCRHYxNDR3cmsyUHJkYnJ1d3BFYzJtaGE1dnUxQ0k3bXVxRHpSQ1Fmck9o?=
 =?utf-8?B?T25WaHNtakdjelVILzJtcGE4SW9KOXBWeDArL1Fmb1B3dzZlR2lzNFpLZ3I0?=
 =?utf-8?B?ejEwR1BvQ1QvRUtzalZEODhVbjJ5Y2dweG1CZ2JBOFNYYUVBcnJ0dlZpKzE2?=
 =?utf-8?B?WkVCc2RmOWNCTkQySjZ4M0s4Rk9TMG1FdXBiaE5icDhNM1ZzTlViR1luS3JP?=
 =?utf-8?B?cGowWUIxaTN2L3hYK1AvNk5pUE9aN1BXU2tWU2huMXNlWDNIZDBNSSthcUJB?=
 =?utf-8?B?eU5GaXBjYTc1Zzd6SXRkd0pwOWZIUU4xOExqZElOblBXeWlsdTZVa2pHVmJU?=
 =?utf-8?B?Z1lqNVArenNFR2VTUGU0MW9EV0E3WDZwbnVYZG1vZzZiUXFrYlJaMXIvMkJO?=
 =?utf-8?B?bUJ6RDJpWlVTaHNYYW9nS0pYU0xPYXUyaCt1anlJVDAxS1FHZVBmY0dwSTJC?=
 =?utf-8?B?UDB5b3dPMFBZeUE2NWhzQ2FXR1BGcGRuUUtIdGNmNFJYd2hpd1lSM0M3c2M5?=
 =?utf-8?B?OUJ1bUlvY2dGL0VpSW5jdUxUem0xYzFnTUxaSHdWeTJseGluaHRZY2s3bUZK?=
 =?utf-8?B?NDdybWhPT2pEd282NDlFL3hNQ1RhV3hBMFRxaDlMZTBBV3d4N3hVK3VWeXBB?=
 =?utf-8?B?S0JJZ25mOUh5UVVnek92amZXemlhbjRhS0p6YUh6VFJBazlUQ0c4N0p1NnhR?=
 =?utf-8?B?Y3lwUVZSMTZlR3cwVkRTc2R6RG9PM2Z2UXhkQ2RGbFoyOXQySkZUQzNxakZG?=
 =?utf-8?B?YUVLZlVXM1RLYmNOSHZnd3ZRUDdlVlRETVZlbVEvQ2l4bUsxSk52N3EvOU1O?=
 =?utf-8?B?UU9TQ1l3MUF1cCtQU3RUSkdUQ25FYmsrZVFOMjFIMEMweGxwck5YSVExNFNk?=
 =?utf-8?B?OFZuc0dSOFdaZWhuRGIyWGVxV2ZnRmRmRkR2RmtGaDhUdDFDMkp2eWNoZGFX?=
 =?utf-8?B?YjliczlvTXJxVHRJNWkwRmVmNFVUZFE2SmNJNy9lYm9xMnNtNlRhUmloWHo4?=
 =?utf-8?B?THZPNEJPMUgvY01WbHZxaWJNY0JkbGk5eFJYc2ZabkV3Y21zODNsc0poa0lm?=
 =?utf-8?B?Z0o3d1UwZlNOMkNFN3B3UXphSzVRYXpJNElreWFnR055UHNEL1RvYlVmYmRE?=
 =?utf-8?B?clJwMm5xR05DMEFRcUd5bU1CTWI2cmJTZ3pDb1ZhSGN0ZTFRQTExU3U4MnBz?=
 =?utf-8?B?UHRNMEMxcWFXVVBSUFVZbkhESWlDNnM2OUhFUzF3LzFiYmMwRnlBQ2tCRFAx?=
 =?utf-8?B?djI4a0hHbEZsSmZieEFFdERzVVBLb1JWOFZtc21aTmxsQyswT3hRNkZmcFVI?=
 =?utf-8?B?M0JZK1dYWE0wWXNYMnZhRktrdzM4UGpYVVJLaDROSVdjRkZRaG1LU0x4T0hw?=
 =?utf-8?B?NlpXQWswcHppUVpNanVJb0ZRYWgxUE00eTJUb1kvblM3R1NFckIxRk1XTzFr?=
 =?utf-8?B?VGN1YWJJWGtPcWs2KzBHR0MzRjFyS2hTWFV6dlA1OHRQQ2tFVEdvSnFpT0Qz?=
 =?utf-8?B?S0dsVkZpYUQwcWY0a2x0Z3QzTU1Qa284OEpSQ3pESlBpeEpRejRUc0pzL3BQ?=
 =?utf-8?B?alFMVCtVM2x6ektxV0RvTURmUzJuM0lKZlFFbkFlZVVQaUxNZGdOS3k5bmcy?=
 =?utf-8?B?QWg0dWd4NWduQjJqUFlrTlFmcFRCczVqdTJxMnNnS0tpWm1CcHNmTWpGcHUr?=
 =?utf-8?B?K3lzOWRtOURwS0g0YWIxUk8xQ2dKKzFXOGg5dXhmYm9yZ2xKZmVqU09xenll?=
 =?utf-8?B?RnNUUjN2WVZYRm9JQTRBb1Z0MjV4eHBtR1lLZXVGQ0NzN3NoczU1RS9YTktB?=
 =?utf-8?B?anRwSUZITGZjR2RCV2c5NTVFRGZhSFFQRER2V0xRUjI4eDV2Y1FaN25xT2xR?=
 =?utf-8?B?aGxWa1VHSmFCY2VINVRIYkxURWlpN1RPS0huMFozdU9CRm1XZjZPRW9sN0Va?=
 =?utf-8?B?VFA3Tk1GWEp6ZXo3RjVub0RjdHUydktYUWJmYk9acm5jdlNON2pOQjl5U0Fv?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <398F2DF443C6A447AB3356A4EB1ACE32@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3775716-eefa-47d2-13bc-08dd0f6f91fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 05:43:22.0884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YNimRmVoQGoqcjZ1tuxoPneYLXNFjONEd30QEkz9G3fJUslcKojcRPkLPN7nEjXKap0qPR27n8iNXK+JCeiWabrTbpB8r5RGNKFxsjPNJRs0YH8HnkJQbrsMlf9R17U1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5315

SGkgUGFvbG8sDQoNCk9uIDI3LzExLzI0IDU6NDEgcG0sIFBhb2xvIEFiZW5pIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDExLzI3LzI0IDExOjQ5
LCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDI2LzEx
LzI0IDQ6MTEgcG0sIFBhb2xvIEFiZW5pIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNv
bnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gMTEvMjIvMjQgMTE6MjEsIFBhcnRoaWJhbiBWZWVy
YXNvb3JhbiB3cm90ZToNCj4+Pj4gVGhlcmUgYXJlIHR3byBza2IgcG9pbnRlcnMgdG8gbWFuYWdl
IHR4IHNrYidzIGVucXVldWVkIGZyb20gbi93IHN0YWNrLg0KPj4+PiB3YWl0aW5nX3R4X3NrYiBw
b2ludGVyIHBvaW50cyB0byB0aGUgdHggc2tiIHdoaWNoIG5lZWRzIHRvIGJlIHByb2Nlc3NlZA0K
Pj4+PiBhbmQgb25nb2luZ190eF9za2IgcG9pbnRlciBwb2ludHMgdG8gdGhlIHR4IHNrYiB3aGlj
aCBpcyBiZWluZyBwcm9jZXNzZWQuDQo+Pj4+DQo+Pj4+IFNQSSB0aHJlYWQgcHJlcGFyZXMgdGhl
IHR4IGRhdGEgY2h1bmtzIGZyb20gdGhlIHR4IHNrYiBwb2ludGVkIGJ5IHRoZQ0KPj4+PiBvbmdv
aW5nX3R4X3NrYiBwb2ludGVyLiBXaGVuIHRoZSB0eCBza2IgcG9pbnRlZCBieSB0aGUgb25nb2lu
Z190eF9za2IgaXMNCj4+Pj4gcHJvY2Vzc2VkLCB0aGUgdHggc2tiIHBvaW50ZWQgYnkgdGhlIHdh
aXRpbmdfdHhfc2tiIGlzIGFzc2lnbmVkIHRvDQo+Pj4+IG9uZ29pbmdfdHhfc2tiIGFuZCB0aGUg
d2FpdGluZ190eF9za2IgcG9pbnRlciBpcyBhc3NpZ25lZCB3aXRoIE5VTEwuDQo+Pj4+IFdoZW5l
dmVyIHRoZXJlIGlzIGEgbmV3IHR4IHNrYiBmcm9tIG4vdyBzdGFjaywgaXQgd2lsbCBiZSBhc3Np
Z25lZCB0bw0KPj4+PiB3YWl0aW5nX3R4X3NrYiBwb2ludGVyIGlmIGl0IGlzIE5VTEwuIEVucXVl
dWluZyBhbmQgcHJvY2Vzc2luZyBvZiBhIHR4IHNrYg0KPj4+PiBoYW5kbGVkIGluIHR3byBkaWZm
ZXJlbnQgdGhyZWFkcy4NCj4+Pj4NCj4+Pj4gQ29uc2lkZXIgYSBzY2VuYXJpbyB3aGVyZSB0aGUg
U1BJIHRocmVhZCBwcm9jZXNzZWQgYW4gb25nb2luZ190eF9za2IgYW5kDQo+Pj4+IGl0IG1vdmVz
IG5leHQgdHggc2tiIGZyb20gd2FpdGluZ190eF9za2IgcG9pbnRlciB0byBvbmdvaW5nX3R4X3Nr
YiBwb2ludGVyDQo+Pj4+IHdpdGhvdXQgZG9pbmcgYW55IE5VTEwgY2hlY2suIEF0IHRoaXMgdGlt
ZSwgaWYgdGhlIHdhaXRpbmdfdHhfc2tiIHBvaW50ZXINCj4+Pj4gaXMgTlVMTCB0aGVuIG9uZ29p
bmdfdHhfc2tiIHBvaW50ZXIgaXMgYWxzbyBhc3NpZ25lZCB3aXRoIE5VTEwuIEFmdGVyDQo+Pj4+
IHRoYXQsIGlmIGEgbmV3IHR4IHNrYiBpcyBhc3NpZ25lZCB0byB3YWl0aW5nX3R4X3NrYiBwb2lu
dGVyIGJ5IHRoZSBuL3cNCj4+Pj4gc3RhY2sgYW5kIHRoZXJlIGlzIGEgY2hhbmNlIHRvIG92ZXJ3
cml0ZSB0aGUgdHggc2tiIHBvaW50ZXIgd2l0aCBOVUxMIGluDQo+Pj4+IHRoZSBTUEkgdGhyZWFk
LiBGaW5hbGx5IG9uZSBvZiB0aGUgdHggc2tiIHdpbGwgYmUgbGVmdCBhcyB1bmhhbmRsZWQsDQo+
Pj4+IHJlc3VsdGluZyBwYWNrZXQgbWlzc2luZyBhbmQgbWVtb3J5IGxlYWsuDQo+Pj4+IFRvIG92
ZXJjb21lIHRoZSBhYm92ZSBpc3N1ZSwgcHJvdGVjdCB0aGUgbW92aW5nIG9mIHR4IHNrYiByZWZl
cmVuY2UgZnJvbQ0KPj4+PiB3YWl0aW5nX3R4X3NrYiBwb2ludGVyIHRvIG9uZ29pbmdfdHhfc2ti
IHBvaW50ZXIgc28gdGhhdCB0aGUgb3RoZXIgdGhyZWFkDQo+Pj4+IGNhbid0IGFjY2VzcyB0aGUg
d2FpdGluZ190eF9za2IgcG9pbnRlciB1bnRpbCB0aGUgY3VycmVudCB0aHJlYWQgY29tcGxldGVz
DQo+Pj4+IG1vdmluZyB0aGUgdHggc2tiIHJlZmVyZW5jZSBzYWZlbHkuDQo+Pj4NCj4+PiBBIG11
dGV4IGxvb2tzIG92ZXJraWxsLiBXaHkgZG9uJ3QgeW91IHVzZSBhIHNwaW5sb2NrPyB3aHkgbG9j
a2luZyBvbmx5DQo+Pj4gb25lIHNpZGUgKHRoZSB3cml0ZXIpIHdvdWxkIGJlIGVub3VnaD8NCj4+
IEFoIG15IGJhZCwgbWlzc2VkIHRvIHByb3RlY3QgdGM2LT53YWl0aW5nX3R4X3NrYiA9IHNrYi4g
U28gdGhhdCBpdCB3aWxsDQo+PiBiZWNvbWUgbGlrZSBiZWxvdywNCj4+DQo+PiBtdXRleF9sb2Nr
KCZ0YzYtPnR4X3NrYl9sb2NrKTsNCj4+IHRjNi0+d2FpdGluZ190eF9za2IgPSBza2I7DQo+PiBt
dXRleF91bmxvY2soJnRjNi0+dHhfc2tiX2xvY2spOw0KPj4NCj4+IEFzIGJvdGggYXJlIG5vdCBj
YWxsZWQgZnJvbSBhdG9taWMgY29udGV4dCBhbmQgdGhleSBhcmUgYWxsb3dlZCB0bw0KPj4gc2xl
ZXAsIEkgdXNlZCBtdXRleCByYXRoZXIgdGhhbiBzcGlubG9jay4NCj4+Pg0KPj4+IENvdWxkIHlv
dSBwbGVhc2UgcmVwb3J0IHRoZSBleGFjdCBzZXF1ZW5jZSBvZiBldmVudHMgaW4gYSB0aW1lIGRp
YWdyYW0NCj4+PiBsZWFkaW5nIHRvIHRoZSBidWcsIHNvbWV0aGluZyBhbGlrZSB0aGUgZm9sbG93
aW5nPw0KPj4+DQo+Pj4gQ1BVMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQ
VTENCj4+PiBvYV90YzZfc3RhcnRfeG1pdA0KPj4+ICAgIC4uLg0KPj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9hX3RjNl9zcGlfdGhyZWFkX2hhbmRsZXINCj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uDQo+PiBHb29k
IGNhc2U6DQo+PiAtLS0tLS0tLS0tDQo+PiBDb25zaWRlciB3YWl0aW5nX3R4X3NrYiBpcyBOVUxM
Lg0KPj4NCj4+IFRocmVhZDEgKG9hX3RjNl9zdGFydF94bWl0KSAgIFRocmVhZDIgKG9hX3RjNl9z
cGlfdGhyZWFkX2hhbmRsZXIpDQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gICAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gLSBpZiB3YWl0aW5nX3R4X3NrYiBp
cyBOVUxMDQo+PiAtIHdhaXRpbmdfdHhfc2tiID0gc2tiDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLSBpZiBvbmdvaW5nX3R4X3NrYiBpcyBOVUxMDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLSBvbmdvaW5nX3R4X3NrYiA9IHdhaXRpbmdfdHhfc2tiDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLSB3YWl0aW5nX3R4X3NrYiA9IE5VTEwNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4NCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtIG9uZ29pbmdfdHhfc2tiID0gTlVMTA0KPj4gLSBpZiB3YWl0aW5nX3R4
X3NrYiBpcyBOVUxMDQo+PiAtIHdhaXRpbmdfdHhfc2tiID0gc2tiDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLSBpZiBvbmdvaW5nX3R4X3NrYiBpcyBOVUxMDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLSBvbmdvaW5nX3R4X3NrYiA9IHdhaXRpbmdfdHhfc2ti
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLSB3YWl0aW5nX3R4X3NrYiA9IE5V
TEwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4NCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtIG9uZ29pbmdfdHhfc2tiID0gTlVMTA0KPj4gLi4uLg0KPj4N
Cj4+IEJhZCBjYXNlOg0KPj4gLS0tLS0tLS0tDQo+PiBDb25zaWRlciB3YWl0aW5nX3R4X3NrYiBp
cyBOVUxMLg0KPj4NCj4+IFRocmVhZDEgKG9hX3RjNl9zdGFydF94bWl0KSAgIFRocmVhZDIgKG9h
X3RjNl9zcGlfdGhyZWFkX2hhbmRsZXIpDQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0g
ICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gLSBpZiB3YWl0aW5nX3R4
X3NrYiBpcyBOVUxMDQo+PiAtIHdhaXRpbmdfdHhfc2tiID0gc2tiDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLSBpZiBvbmdvaW5nX3R4X3NrYiBpcyBOVUxMDQo+IA0KPiBBRkFJ
Q1MsIGlmICd3YWl0aW5nX3R4X3NrYiA9PSBOVUxMIGFuZCBUaHJlYWQyIGlzIGluDQo+IG9hX3Rj
Nl9zcGlfdGhyZWFkX2hhbmRsZXIoKS9vYV90YzZfcHJlcGFyZV9zcGlfdHhfYnVmX2Zvcl90eF9z
a2JzKCkNCj4gdGhlbiBvbmdvaW5nX3R4X3NrYiBjYW4gbm90IGJlIE5VTEwsIGR1ZSB0byB0aGUg
cHJldmlvdXMgY2hlY2sgaW46DQo+IA0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51
eC92Ni4xMi9zb3VyY2UvZHJpdmVycy9uZXQvZXRoZXJuZXQvb2FfdGM2LmMjTDEwNjQNCj4gDQo+
IFRoaXMgbG9va3MgbGlrZSBhIHNpbmdsZSByZWFkZXIvc2luZ2xlIHdyaXRlIHNjZW5hcmlvcyB0
aGF0IGRvZXMgbm90DQo+IG5lZWQgYW55IGxvY2sgdG8gZW5zdXJlIGNvbnNpc3RlbmN5Lg0KPiAN
Cj4gRG8geW91IG9ic2VydmUgYW55IG1lbW9yeSBsZWFrIGluIHJlYWwgbGlmZSBzY2VuYXJpb3M/
DQo+IA0KPiBCVFcgaXQgbG9va3MgbGlrZSBib3RoIG9hX3RjNl9zdGFydF94bWl0IGFuZCBvYV90
YzZfc3BpX3RocmVhZF9oYW5kbGVyDQo+IGFyZSBwb3NzaWJseSBsYWNraW5nIG1lbW9yeSBiYXJy
aWVycyB0byBhdm9pZCBtaXNzaW5nIHdha2UtdXBzLg0KQWN0dWFsbHkgdGhlIHRyYW5zbWl0IGZs
b3cgY29udHJvbCBpcyBkb25lIHVzaW5nIHRoZSBUWEMgcmVwb3J0ZWQgZnJvbSANCk1BQy1QSFkg
YW5kIGl0IGlzIGRvbmUgaW4gdGhlIGJlbG93IGZvciBsb29wLiBUWEMgaXMgVHJhbnNtaXQgQ3Jl
ZGl0IA0KQ291bnQgcmVwcmVzZW50cyB0aGUgcm9vbXMgYXZhaWxhYmxlIHRvIHBsYWNlIHRoZSB0
eCBjaHVua3MgaW4gdGhlIE1BQy1QSFkuDQoNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xp
bnV4L3Y2LjEyL3NvdXJjZS9kcml2ZXJzL25ldC9ldGhlcm5ldC9vYV90YzYuYyNMMTAwNA0KDQot
IENvbnNpZGVyIGEgc2NlbmFyaW8gd2hlcmUgdGhlIFRYQyByZXBvcnRlZCBmcm9tIHRoZSBwcmV2
aW91cyB0cmFuc2ZlciANCmlzIDEwIGFuZCBvbmdvaW5nX3R4X3NrYiBob2xkcyBhbiB0eCBldGhl
cm5ldCBmcmFtZSB3aGljaCBjYW4gYmUgDQp0cmFuc3BvcnRlZCBpbiAyMCBUWENzIGFuZCB3YWl0
aW5nX3R4X3NrYiBpcyBzdGlsbCBOVUxMLg0KCXR4X2NyZWRpdHMgPSAxMDsgLyogMjEgYXJlIGZp
bGxlZCBpbiB0aGUgcHJldmlvdXMgdHJhbnNmZXIgKi8NCglvbmdvaW5nX3R4X3NrYiA9IDIwOw0K
CXdhaXRpbmdfdHhfc2tiID0gTlVMTDsgLyogU3RpbGwgTlVMTCAqLw0KLSBTbywgKHRjNi0+b25n
b2luZ190eF9za2IgfHwgdGM2LT53YWl0aW5nX3R4X3NrYikgYmVjb21lcyB0cnVlLg0KLSBBZnRl
ciBvYV90YzZfcHJlcGFyZV9zcGlfdHhfYnVmX2Zvcl90eF9za2JzKCkNCglvbmdvaW5nX3R4X3Nr
YiA9IDEwOw0KCXdhaXRpbmdfdHhfc2tiID0gTlVMTDsgLyogU3RpbGwgTlVMTCAqLw0KLSBQZXJm
b3JtIFNQSSB0cmFuc2Zlci4NCi0gUHJvY2VzcyBTUEkgcnggYnVmZmVyIHRvIGdldCB0aGUgVFhD
IGZyb20gZm9vdGVycy4NCi0gTm93IGxldCdzIGFzc3VtZSBwcmV2aW91c2x5IGZpbGxlZCAyMSBU
WENzIGFyZSBmcmVlZCBzbyB3ZSBhcmUgZ29vZCB0byANCnRyYW5zcG9ydCB0aGUgbmV4dCByZW1h
aW5pbmcgMTAgdHggY2h1bmtzIGZyb20gb25nb2luZ190eF9za2IuDQoJdHhfY3JlZGl0cyA9IDIx
Ow0KCW9uZ29pbmdfdHhfc2tiID0gMTA7DQoJd2FpdGluZ190eF9za2IgPSBOVUxMOw0KLSBTbywg
KHRjNi0+b25nb2luZ190eF9za2IgfHwgdGM2LT53YWl0aW5nX3R4X3NrYikgYmVjb21lcyB0cnVl
IGFnYWluLg0KLSBJbiB0aGUgb2FfdGM2X3ByZXBhcmVfc3BpX3R4X2J1Zl9mb3JfdHhfc2ticygp
DQoJb25nb2luZ190eF9za2IgPSBOVUxMOw0KCXdhaXRpbmdfdHhfc2tiID0gTlVMTDsNCg0KTm93
IHRoZSBiZWxvdyBiYWQgY2FzZSBtaWdodCBoYXBwZW4sDQoNClRocmVhZDEgKG9hX3RjNl9zdGFy
dF94bWl0KQlUaHJlYWQyIChvYV90YzZfc3BpX3RocmVhZF9oYW5kbGVyKQ0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQotIGlm
IHdhaXRpbmdfdHhfc2tiIGlzIE5VTEwNCgkJCQktIGlmIG9uZ29pbmdfdHhfc2tiIGlzIE5VTEwN
CgkJCQktIG9uZ29pbmdfdHhfc2tiID0gd2FpdGluZ190eF9za2INCi0gd2FpdGluZ190eF9za2Ig
PSBza2INCgkJCQktIHdhaXRpbmdfdHhfc2tiID0gTlVMTA0KCQkJCS4uLg0KCQkJCS0gb25nb2lu
Z190eF9za2IgPSBOVUxMDQotIGlmIHdhaXRpbmdfdHhfc2tiIGlzIE5VTEwNCi0gd2FpdGluZ190
eF9za2IgPSBza2INCg0KSG9wZSB0aGlzIGNsYXJpZmllcy4NCg0KQmVzdCByZWdhcmRzLA0KUGFy
dGhpYmFuIFYNCj4gDQo+IENoZWVycywNCj4gDQo+IFBhb2xvDQo+IA0KDQo=

