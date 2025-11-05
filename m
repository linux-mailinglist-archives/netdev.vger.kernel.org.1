Return-Path: <netdev+bounces-235707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74735C33F12
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 05:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBB54644DA
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 04:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7612B246781;
	Wed,  5 Nov 2025 04:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y9z+Awby"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6DF21D5B3;
	Wed,  5 Nov 2025 04:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762317591; cv=fail; b=Jszrcj2ibPG6bHjoZIAoh0MkSUGoLKnzGbgs+gV01h7VGVBCdJhfiYIE8hevUi95jeXcLqk5BOGtkE0KSNjs9RT9kdu7dReeHofOCweM0aQjqTdYp8/Sz5EGGi7oR5eV/+3EyVy7UFvnGRgXVx8x4YBRjJj0m9VaruNey0SxIGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762317591; c=relaxed/simple;
	bh=viA3ZY/S4LeRMHVYCW2yfP2ZqdLyNQddr2BF2YrDGvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cNYoo68dHf2A4rEvmq5gKv9j7SZwGKNs0AhxqwfUDH8xSyqQaVlKM8bABAJBAwwSOjwvtrC5iZiYNe2/TG9i5w4Vry3SZc07GGjgesIElSy4tm4M6YBg8tN++RBsx6qkg4f01VE9YPCYEPUS5FdcCVRM1qVgdERKeC3QeRdccLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y9z+Awby; arc=fail smtp.client-ip=52.101.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ew6pUSzHedy1Ib/L5gQrKF+VD7iFyWIOa5O2N9PnqH9hCmhOTr7Gt5GKEfx7Qi34D0Qyvkdb29F1lxln1dRW8Y1ztRAMsnhE0dPn1B3oRbKPhj//F00fZM7eN1GDtz9qUAPASg/6ZZOGFyR3UNkLrHtqEA+krIi8CblnE1eA8+nxwkjgybGJsJh/ZDCGf5Vx66FcDjpt11nieOKjZZYsqvMN55lzfU5P2isDnIMjsTfHJK0+D6tzZCP18etjqum0rXSbz0ALzLsXHC39XRgKMClFQs0P6bLqTYJ5UG9gz/R9apDZFotYET2oi/+tspy7MpDihpfyIXvknGOAcMJoAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viA3ZY/S4LeRMHVYCW2yfP2ZqdLyNQddr2BF2YrDGvs=;
 b=g6qk796z52uDk+Uj9AO97LdbjhmgG6deonpZMiIKb8uJ55OjSgRZmRt1hoWcTRB47kzLJgS6nMAPQmTk/Sy26W4gHfaMiQsHYLJajonZBDu7A8APyBr1TYCLnEMa3prkWzy8L4W/ks2QKwbjxVd0UCAiwPLl8BOuQAhYLRo/xOkoNOLA120gB6fA+5UDuXHTWVfToYH8H26mRbt5TtO5KatwjGjx7VCnbauO2AiWvKlvfgk52bLV45SIZSM658KpX6tipqj59Ge9LncVG6psLcxF2JMqLF32HRum0Ew1nCJs/tCtaYRCmudIGCwk3EWNWGvhlzDi0S9FoUHGOnxElg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viA3ZY/S4LeRMHVYCW2yfP2ZqdLyNQddr2BF2YrDGvs=;
 b=y9z+AwbyNjtta/cazAmcz3zj6OJadTSEn4grG3wPZy0nz+bmtLnZVztEnbdKcYvL1W5zZm94bWBvXgFJHNPuk8NK2/BTEdlTjBiE0LWxl9Gdk6AgTBjA+528q0vuKHDGclPKfAmE6iHp7Y70DmUePZuDt4Je6CbrV8eGbK1VvRlK7fHKVHWVUwEvZo0qmDLXoat6F4GjNQvAOPYcIqUJATeyHcTeiMyk+AX9HIrpDMZSc3oab+QCZ1rTLHuhHzpBLybW0QNUigeY1slst8QOBH0WoVf43xYLuUmgbLCGG8+x0AFa3r01cVviyb5PaDH63r8LiTLnS9CpcPwL3WhTmA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 04:39:46 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 04:39:45 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <piergiorgio.beruto@gmail.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: phy: microchip_t1s:: add cable
 diagnostic support for LAN867x Rev.D0
Thread-Topic: [PATCH net-next 2/2] net: phy: microchip_t1s:: add cable
 diagnostic support for LAN867x Rev.D0
Thread-Index: AQHcTXSyfl1jwZfKEUeyXEOignNDWbTiqgUAgADXfIA=
Date: Wed, 5 Nov 2025 04:39:45 +0000
Message-ID: <a01ed5fb-c78d-4b5a-bf0f-b95893522cf9@microchip.com>
References: <20251104102013.63967-1-parthiban.veerasooran@microchip.com>
 <20251104102013.63967-3-parthiban.veerasooran@microchip.com>
 <3344ecef-3b45-42f7-b501-475413efbafe@lunn.ch>
In-Reply-To: <3344ecef-3b45-42f7-b501-475413efbafe@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH8PR11MB6731:EE_
x-ms-office365-filtering-correlation-id: e24c05ae-de7a-4d24-efd2-08de1c255886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3pQUEdtRlEvZ0RXMzNYQWI0Zmd1c2MvaWt0Q2JsN1BBTEg2SEpJM1o0cm9t?=
 =?utf-8?B?N045WlY4N1VkYzVrVHpPT2d4ZEJWbi8raDY4Ky9oQnpOUTV6WmZ3eW9GUnpI?=
 =?utf-8?B?WmIya0kwZ1Fqb2pla3llYjdjb2FwYjZKZmxWVkc1Nk12Wm5SbC94VEtVdmRj?=
 =?utf-8?B?MWlLMDdCMWpraDZsc2FuNUhIa1FEQ0x6czhwQitMVFpzWDhEUDFiNnRKK2tB?=
 =?utf-8?B?T1ZnbHJHMUhlanlNb3ZhdGs0RFlCWnVndDQ3aTZPTDhMWkhmVTg2bjExa01I?=
 =?utf-8?B?cUVZNW1QQ2xYUUZwdEVKT0cxUS8rMHVIeFZPRDUyRDBGckNoYnhKVVhkdzlE?=
 =?utf-8?B?Yi9wVWhVZ1FZM0lkdzRjSVdxUSt1N0RkZjZlSFpwdDgvcFpUUExpOG55STlG?=
 =?utf-8?B?ZkFhUWFReFoyQjhvaDBSODBCM3ZCOW91Z1ZtTi9LMThRSEpSNjJLbDJDd2Zr?=
 =?utf-8?B?eDJEZTFkb2Mra0EwTGlRWHNuTnN2WlFBYzFsbStCeDFsR0JwWkZwZ2RCeU11?=
 =?utf-8?B?YWRCNE5Ga2hITldQL0tLMXl0MzdwQjVFems0cll0bFJ2V3lXL2MwUzBYOUEy?=
 =?utf-8?B?NlJ2TW1QYnNHQXVITVRCR2xHS2Vwa2YvZ2ZIdTNHVnZvVXorMFlyN2FKNG5k?=
 =?utf-8?B?d0NFOEZiTGFLQURaaEZLalYvZGtVQ3ZBanVKVkE4NFlrcnpCZlh2Zzlqa1gv?=
 =?utf-8?B?Z2M5elA3ODhSSlpodFdxQ3FzbDJ0Q2hWSnhPbjZJUndxb3FrSHBDWDZiUGkx?=
 =?utf-8?B?VEc1VC85RHB3U0Q3aXYwVkpVczdRT3U3azE2WjlkL0pLVTFwSVdNNDN5WmJU?=
 =?utf-8?B?cnY2bWNaYkxiY1RNZklwbVRGOWFkVklSY0MrQmhCZUV2OFgyZXBMVmJmaGc1?=
 =?utf-8?B?bnV6SXJDM085QWNMVFhWNStlTjVPL2QraUY3S3BzM2NlaDYyaitUS2NYeVRz?=
 =?utf-8?B?eWRrbFNxczlJMkxwMDhUVXc4bFFvKzBWRlZsR1hhYXpRRmJMSjkrM0lONGxk?=
 =?utf-8?B?Q3k5QmtVSEtqd1dwY1Q0SmpqS3N6dnZMQk1CYkpaU3EwSjdJRlZod2M4QUt1?=
 =?utf-8?B?OGhabldPRlE0T0Z5aW1xaUVYdXk0S3Y1bCtoNnNoUVVtUTVmV2p3bStpaHk2?=
 =?utf-8?B?MmRCZk1OVmtKbWpPeGYzWmRjTWY5QXlCOVAwdEJzNmJrZ0NrY2M4anRPZDNm?=
 =?utf-8?B?dkN6OS9vcXJ5VjBkdHIyemltU0tkZDVsSUNlbFlHSUJBYmdwS2JxRURVeVda?=
 =?utf-8?B?ZllNZi92VWhkc1RqZ0dkQmJyK3hPVEZnYWg0djFyVkIwUWp6VE1Zb0J1eUVQ?=
 =?utf-8?B?RVFxQkxYZGpzUk4yQzh3V3pJVG5KWVB0UzhXVy9kRFBLZFp3OHdaRk4xWEZM?=
 =?utf-8?B?QXh4YnRSelhUd1R5bERuZXduL0FGQzgyTEhxK2g3Zk1lQlNFSmxEeFdMU3hT?=
 =?utf-8?B?MTZaeHlQYjZZZ3o5ZXBSa1VtRDQ3REx6MEZvY1REYW44U3VKRFVybGlqbEpM?=
 =?utf-8?B?TUhaSUg5UlJFaW9kTy9NTVlSWFovT0ZxNkVtU1NnWFNMaEUyQnRHSi9IckhR?=
 =?utf-8?B?Qm5SdzVOSGlDSVArbVlJWnZHRE5zaW4xbE9sd0JaWkVVcVhVNHFQanBoY01S?=
 =?utf-8?B?cTh2WmNjWXpGMGREdVZDa3lZdTloc05QZ0FrVkxDZEUyU1dZVjhhYTBYNlBK?=
 =?utf-8?B?UlduYXptMGl0dlM2YlF1eTlqQ1pERTNOUkVaQ0Q1dFR6WjVGb2k3clM0cDNJ?=
 =?utf-8?B?WjZIeXFLQURuTTJwSHJtb1FMeExZMkJPM1lUSHJsYkxhYWFyZXVIdWpkMVhD?=
 =?utf-8?B?R05RbDJjcW56dktSd1pVM0lzMWlDcnExeXFnU0ZxWmtleHliNHpNNGtOZ3dx?=
 =?utf-8?B?TDZvRE90eGpZbzRLUXJ2YkJaRk1DZTl2WVgyK0lUUFZWYjNGd0JpMDczdEI3?=
 =?utf-8?B?blNueE5jMUxQRHJKRFBRdHNSQk9rTkswSkhnNWtnUS9Najd5UEY5Z1FKd09i?=
 =?utf-8?B?VXpOUXI5c0xMTFdiWlRqTkRBWVpILzVXcmRpOHFrc0E5cDE1dklKZ1ltTGRp?=
 =?utf-8?Q?Whj4Ej?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWt1NFV4c1dLWVJCNjcwcmtCVExFZmRxVHJDZW9FUVRlTnZCOC9DZC93WGhv?=
 =?utf-8?B?QUlhaEcrMWcra3lmb3ZCZDUzaVFtcGVWVGx6M1dPNm1yUklzQ0RuTUFMVzh6?=
 =?utf-8?B?cW43eFNVKzFLbnpLT0MzU2xvd2x3b0tRSXdwdU5CaWRPY3pZYjh4M0ozc252?=
 =?utf-8?B?cmloMTA5TExiSHlCSHZuUlFRR1UweW4vdHRBQTNwbDZEOTlOdDRyc1RFMWxj?=
 =?utf-8?B?YkdkRzZaUXZFL2Q2NmtlSzNMWFN2b3VUcWtpVEVaNXhLMmxsakc1UUd4dGcw?=
 =?utf-8?B?VFFDOGRDRTJrcnh4M1VOUkdSODlMek9LRC9hSUxRME1sejAvODZKOFcrbE9n?=
 =?utf-8?B?Zm1RVmVHSGxldkg1M1ZySzNBTkJNWFYzWUs5QUZmVk1pbi9HcDJUaEZJU3dp?=
 =?utf-8?B?R2hFTHByV0pQUGh3Y3hwOGpJZVBUUVpYYVN2RWl5MkpvSy9ndFEvNnJQUkw1?=
 =?utf-8?B?V3hZZ2RJcStoais1dXFqTkpXYXoya3FXOFFIY0NteHE4WUFRVm1CcWdZUHdQ?=
 =?utf-8?B?WkRFY2lVSGppR1hjenR3Nm5WZi92MDN1eDlvRlZsNXdneDhUNC9zSXNrc1R3?=
 =?utf-8?B?OWJNeTBRRUhpOTVIblZTbXppRXcxazZORkhBeSt2QklTR2NKVDdQUmcyKzFx?=
 =?utf-8?B?dHRaN25qWXpKc2RvODR0U05scnpSMHFzeHhkRHUxbzlvV1NxWUVmZ1ZSVS9s?=
 =?utf-8?B?L1NjNHljRVhGR3RENEswQW9CK1czTGUybVlqQW9jUnhLbU1Hbm9vVXhYUko4?=
 =?utf-8?B?ekx6WkpqeHNNeElHOEt0V2xWNzE0N1hxUmE3VUorVTNDUThoRFdqQnNlSUxn?=
 =?utf-8?B?ZVJueXFEQ01zMTdyR3pTVU1jbmhmTG8rUFVuc2VCN3FKVklpSmladDJhNmJR?=
 =?utf-8?B?ZlV6cUFnZ2NsV2RtZEtJVkJ1V1VXeHIzaENONEJwcEpGVjhheW9wbmp5a0t0?=
 =?utf-8?B?ejZ5VG5SdkdMNmcrRyt4K1ZsUEZkYlZsSHBIbFdabDBYeGtsVTlhTE0vdFVi?=
 =?utf-8?B?K3VKb0w1MDllcXpibUpWRWpUTndWbUoveG5uWllUMXorZEJPUit6SGQ0ODQ5?=
 =?utf-8?B?bXJibTdNS0trS3VFRkttR3djZVRkQmM0T0s1bkJyOG0rbGorYURTaU5yeVp0?=
 =?utf-8?B?MW4yZmp2YU85YTJ2U0ZhQmljRFZrZWtQLy9WaUorNzBiWkQxaS8rY1l3SDRW?=
 =?utf-8?B?dG9wOTlVbEFUZVRVVGJET2kzekNFRUsyTjVZam9hTGJ4WWtiYXdmSUJFYWNC?=
 =?utf-8?B?VXM5YzU2amhUOWlHWW5wdGpUMlNDdTZOZlE0amtDa09ucHF2YS93RmJmL3A5?=
 =?utf-8?B?N05pMDdPVFdVVGRqZkFVMXJ0WUw2THAySll5bmpxeGl2ZGExNkxodStEcVQw?=
 =?utf-8?B?bXI4WXBSN0ZuQUJNbDFWSWg3WWVaMXRObzlhb0lNK0p3cnQ2QStsZmlQMG9q?=
 =?utf-8?B?WTlNN1krZHFXMVlOeklzcnB2QnF3M01yYWRiSmVJeG1mMDJ4S2syWXNRRlQr?=
 =?utf-8?B?d1A4TWF2VzhieEtQOU02MFhZWEtZMk1kUlREVXdpZ0JkV3RxWFVWWkwzNmo4?=
 =?utf-8?B?NjhrYXcyL2xtUTE2ajFlcjFTa1ZvWFhPdVVXSklrNmVsbUtEMTJFM09pa0Fn?=
 =?utf-8?B?MUFnWXZRZHlyVmgrS2lTckhuQmtZYllpR2lvWnNwMkk2RjhkNHU0aEJoVnB1?=
 =?utf-8?B?Uk15ZTVOdXhBZTVwb1ZCcW9memxodVltVDFGQkdkZzliUmsrVUJGYUFsTFpi?=
 =?utf-8?B?d3IvNXd1NUM1aCtidnFBcDllZlFVVG9YTWlNOWgzWnNpZHIrVjd4N1RxSmx2?=
 =?utf-8?B?ek1HT251WFZFanNUcnF0N0VQbHZSNllIcVFib3IrSko5L1o3dzlZMlZiaVJJ?=
 =?utf-8?B?emV5cHBxN3ZmakwvTmcwNmUwNUJ1bTk3dERDajJzcXh4UlQ3TkIrVnFjbXNQ?=
 =?utf-8?B?aitPbkdMK1hGYlRJNHVGSjdkNEovVkE4Tmw3RExVZWVRZXBUZ2tpSmp1R1RY?=
 =?utf-8?B?T0VwTzM5SzNxZUY2dXBvcXR1aUxyMlJDdlVZelFXZmJzY0VpOHRzV2lxaVo5?=
 =?utf-8?B?cDZ0WXg3d0FVbHlVb3dFWEhQVjZFSml0VzVnWWdzM3FhaEVHQkhmOTNnSEZP?=
 =?utf-8?B?Zzk2SDBrQjJHcHVJSnpPNjBnTjYybThZNjV2bFBYL3ovS3RoUW52SVRNeHd4?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A76C27FE62A93B4BA2E0C68A9E6B8146@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e24c05ae-de7a-4d24-efd2-08de1c255886
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 04:39:45.7598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhK84hF9oU6F9OziE5xwCkhm41n442qIJztv7mKUel3DiRzwTYU5gVrw+FUGxfKXRKvvQVyqWBYtj56HBxzDspbRPaRFfDEF85ieD1UA91C3IYfD5aybhARtW8L7hI1t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731

T24gMDQvMTEvMjUgOToxOCBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+ICsgICAgICAgICAgICAgLmNhYmxlX3Rlc3Rfc3Rh
cnQgICA9IGdlbnBoeV9jNDVfb2F0YzE0X2NhYmxlX3Rlc3Rfc3RhcnQsDQo+PiArICAgICAgICAg
ICAgIC5jYWJsZV90ZXN0X2dldF9zdGF0dXMgPQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBnZW5waHlfYzQ1X29hdGMxNF9jYWJsZV90ZXN0X2dldF9zdGF0dXMsDQo+
IA0KPiBuZXRkZXYgcHJlZmVycyBsaW5lcyBhdCA8IDgwLCBidXQgdXAgdG8gMTAwIGFyZSBhY2Nl
cHRlZCB3aGVuIHRoZXkNCj4gbWFrZSBzZW5zZS4gUGxlYXNlIGtlZXAgdGhpcyBvbiBvbmUgbGlu
ZXMuDQpPaywgdGhhbmtzIGZvciB0aGUgaW5mby4gSSB3aWxsIGtlZXAgdGhlbSBpbiBvbmUgbGlu
ZSBpbiB0aGUgbmV4dCANCnZlcnNpb24uIEkgbWlzdGFrZW5seSBhZGRlZCB0aGUgd3JvbmcgY292
ZXIgbGV0dGVyIHN1YmplY3QgbGluZSwgc28gSeKAmXZlIA0KYWxyZWFkeSBzZW50IHYyIHRvIGNv
cnJlY3QgdGhhdC4gSeKAmWxsIGluY2x1ZGUgdGhpcyB1cGRhdGUgaW4gdjMuDQoNCkJlc3QgcmVn
YXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgICAgICBBbmRyZQ0KDQo=

