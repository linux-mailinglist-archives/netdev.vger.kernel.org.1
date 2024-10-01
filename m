Return-Path: <netdev+bounces-130831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0483998BB12
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689ED283BFA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8833A1C0DFD;
	Tue,  1 Oct 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aAWHNKyD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351311BFE0F
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782230; cv=fail; b=I1vsHeOZysTe7GxB8dYTH1vtoXFqGxSMvxMO7+h3XUnLPL9e/6kKB8GR21CG3ZIYTRfSSZoLV/LXW93gKj4CzMerbgPRq+VpOYICx6wgR2Fr0tS1kD0gEqhF56jth3qcQAweQJE9diI2uIZpfdov7+vWMlOYua/FGWLohJDaSQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782230; c=relaxed/simple;
	bh=4Oms7zAYMLUT+MTAd30LQSl+yQ8ITgVVPF6c7JqWlLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M4n0TESIIRLi762n0dABdZwNjplvb0myLh+JPmEUVmCkdXXz4bbu21WSO5ThwhKYtSFe0b2d4xXFTiieYWhXop5uy3rLIxh96aJxxBeLbSGuoOx8fSmttUVBS++NaJXPLLTwVY1JwwgqTqWBTut8CmgVX6Z9ipeFcDrA5tT3APM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aAWHNKyD; arc=fail smtp.client-ip=40.107.102.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmPYdyFtoH2ayR4HMfA+2sf3Wt/nkVGIQnwYDNqTn/Qn8VzKA059mFgds2466z34gUXrN6aQ1WVIOe2ymVePUqWyp5cpPTJEdiL/0MBRBwXyLh2gdBm4S8nRTGbbk7E2lsvgEaK1oIdgBR1eLSEg5bv91K0N9srFDEXPKfvnjLcwAyD3LnWBT1gQmr4VMZNwhA7Q+hT6hvMZkUs1tRcbQt1t2AWWPsMKBtnWtf3Suu77g/eqVtCb+0gC1D66myVfnWO3IujSex+jWkj3VbNz2AUsLik7/VFRwte7xH6HFmF3NACN7JtmmkYslqyx7ykvBgbh1TSoSbruOtXUzxPOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Oms7zAYMLUT+MTAd30LQSl+yQ8ITgVVPF6c7JqWlLI=;
 b=llONsHhqFiZ5o4CPEy28n7Y3rVzuLagqftk8ijAiG64o1rAh97X0/VVtcU8A5jb6Fjmu0OV+A7itcGY+pHfeUj5AESD9Da5L8uZK2F+/WRIMM7IyOADG74QAT/EXpDFLhK3wnR3tUOPo5mkW7RL5w5CV4tW4lb085rhiCwNyj9xwsy3edZaDRoxuaLSzwHn5YgWJWyUTyZ46IxVeY7AILqZtJilY07DT5sAyrEMqoYqM3WJZrrnBWRO+wGWHeNXBTi+eRzjx3oEICZHY/Rz7YM8nnfd8Ty7h0bun388UveahOvKeu5FepgYqChG/eJN/aXoQ2RZkLoaCbyLy+E+VGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Oms7zAYMLUT+MTAd30LQSl+yQ8ITgVVPF6c7JqWlLI=;
 b=aAWHNKyDv/Z9AXwN2l8pO+VU30wi61BRHLTILIwn+ycnJIEkqTGFhTLWmB/hInENoNQkZq5H33FVworwWVYr7vbow5yU48knP2s6HzlMouyMpfS8gcCxTj945qyrNhpdq0NN/X9LymPrEj+HM5OxChLyRQMX+6liDlysutWqk4YtGPqupZvRwoj6WtoJbdNGDcdgnW4nkusppd0xfe1OB5QJOOQtKcXrO6+0m7MBHXjTKMpmwCaKAmhaIG8ypbZDj4Pr9T11wKXnT9xqmtaKDrm/pjf5VBkdaeF4cS1swzRGtBf+NHtP6k/u7X7Oe11NSbQpjQVWf5zkPIA8yaRM/g==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SN7PR11MB8026.namprd11.prod.outlook.com (2603:10b6:806:2dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 11:30:24 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 11:30:24 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <alexander.sverdlin@siemens.com>, <netdev@vger.kernel.org>
CC: <agust@denx.de>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>
Subject: Re: [PATCH net-next] net: dsa: lan9303: ensure chip reset and wait
 for READY status
Thread-Topic: [PATCH net-next] net: dsa: lan9303: ensure chip reset and wait
 for READY status
Thread-Index: AQHbE+6wsAOYmn77hESnYe4KVx9MTbJxwr6A
Date: Tue, 1 Oct 2024 11:30:24 +0000
Message-ID: <aafbddb5-c9d4-46b4-a5f2-0f56c58fc5df@microchip.com>
References: <20241001090151.876200-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20241001090151.876200-1-alexander.sverdlin@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SN7PR11MB8026:EE_
x-ms-office365-filtering-correlation-id: 02fae19d-c2f3-499d-8b78-08dce20c7103
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aC9QdzVVQm85amxTeTdyWGtrd3lvYVMybXpDOFJ2VmhpK0l1YkRwV1RwKzho?=
 =?utf-8?B?YXQvWHBvb1AzWDNveEx4clRoYTBKT2FzQmo0N3RYcVpTY0xSYzFyQUtBWUhz?=
 =?utf-8?B?QXJhL3BGNGpvOUdXcXpnelRGN0JVeHgzNjdBUC9QV2hpNk40WnRuMTgzTTI3?=
 =?utf-8?B?eHBUVE5LNFdDNEhoMjR4aVlSbGFreXdRZW9lM2g0Nzg4TWdvSUJtWWQ2MmJY?=
 =?utf-8?B?VzVyZjNWZFNPQ3BrSldhQ1ZQTmdpT3cvb0lmdnF1OEptWVJrdVg3c3V0UXhS?=
 =?utf-8?B?a0xldmZVWXJVMXE2V3l2eXRvREJPOUsvYk1RckJWK3hGOFhRRU1KblM0clVz?=
 =?utf-8?B?SmpLQTZqYS9MYlRRRFlVTXRXSzJlS3pZRzBpS3NObGhMZENQVEVpTC9xRmdT?=
 =?utf-8?B?ZFVBRXFHVWZDSzVMN3ptQmRzL0prSS85bnNKWjBzL3NwWnJsUFl4a2RwWjg1?=
 =?utf-8?B?VEZjV3BTcE4xYk5VSzQyVG5nZ3p5Ykk3bkVRaFFmSDRyOURRcmo5RStGM3RX?=
 =?utf-8?B?Y1lBdTNDd0hUT1NGMFVpNFkydGpsM09xcndOYlFkYi8yamtSN1NrTjZaNXBV?=
 =?utf-8?B?QlNwN1ZtaWpoR1RPa1ZYSGJyNDZRQW1zRnBPVjlBUDFZc2ZXb0JSNFlHdEIx?=
 =?utf-8?B?cFhFNWdVMEs5L1JWYnd4cEdmZkVvcmZBL2s0Tm9KSkJNN2JRMWJadmdSbDdY?=
 =?utf-8?B?OHFRUk1QdlJOd0htUm5LWlYvejZ2ZEIvRkJvM0hKaFhoLzh2WXd4NTd2eWpM?=
 =?utf-8?B?S2h1d3ZrbjUwbGhkL1czdnJzQkxLSTZhMC8wQ0Fnd3ljb0Zuc3F6di9MRGRl?=
 =?utf-8?B?c2VBdUcrd2RicVk0bnprQVF1enFZUHJTVlprV3NOSTRDazRXN2NJV3FMaDcz?=
 =?utf-8?B?aWtSYWVNcFQ0bjQ5eTgvMkRLcDR0aDFob3ZpUlNSaDZ6Tmp6ZWZGYzV2N3Fi?=
 =?utf-8?B?NE02L2F5cTR0S0s5SFlJeW5rcWs1b0FFOTdRTVU1M0FkWVUrOEhncVRVVGM5?=
 =?utf-8?B?VHBDL01YSEdmMFcwOE9kS3RabVdldVo3Q2t4S0tWV3J2clNIa2NTeWZpTE5G?=
 =?utf-8?B?SDBibzM4a1MzR25nS2d5MTVNQkpZWnVrRzd4dDkwYzdTbU5wQXVaWjN6eTRY?=
 =?utf-8?B?TXJKNHFHNkd5OG50cTgxR08vZ1Uxcm9WUkxZaXJMZ0ZucTNYRHVWSHJnaDAw?=
 =?utf-8?B?eW9BVFlCSmtGbnovRC8yTExBZnlsc0RqbVlSNXVyNjArU2MvTzNxdkZPOGEr?=
 =?utf-8?B?ZzlYWmV4VzdleEZpSVp4MnQ5TWlaNDEweWNjWFJyaFZ3eUZJWGxPNW92MXhs?=
 =?utf-8?B?WWltZHVLN2IycGsxMVhIaW90RVlHaGExM0ZFKy9XalFSTUNxQWQvUDh1NkUv?=
 =?utf-8?B?ZkNETWVZTWNXUHVFM09MOTlXdi81cGZhUEI0VldSUVhvM095SHpOaTlHMWxE?=
 =?utf-8?B?N0dUVmp6aTZ0YkUzZ2FqOXd2K3dyM0lOa0lNeTBnVmlISW1mTFlINkdFTjVM?=
 =?utf-8?B?UXJSbVhhRUhuSkNoZ1FZOHV6T05QdXNkQlJqWW5qY0plUjMxeHFNOXVzUmh0?=
 =?utf-8?B?dlN0MmVrQkhjTWFxVTFFRmU5UHAxNGNnODdZRm0rWFRLZ1phd01yNk50bXdR?=
 =?utf-8?B?R2xucXM4STFsVmtMN1I5YmRTRjU2TEFhTEJpZ1gxSEdjMzlPVDQ1WlFKM0ZK?=
 =?utf-8?B?ZEdoTTFpQjNaeGM5bUpmVWtWMWQ3ME1MamFXN21rMGM4bXlIekhIb3U4VE5t?=
 =?utf-8?B?ZVcwbkpzR2RMdHpEeXR5Z1BHNVJQTmRTR3hueG9GbmpNZXZRaWx4TENuK1Q2?=
 =?utf-8?B?NmJ3Z0NWeDZyb1hNUkI2Zz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzVjZ3E5dlV3NUM1Ly9CSGIwSUtqcFNGTTVWY0FpUW1UcFBtN1JQNWNCQUc1?=
 =?utf-8?B?UVZJTjhEOWhVZXdFclZpNzNxTTE0RjV5V240MVFWKzFMZlJiVEFiekxheUtK?=
 =?utf-8?B?VVJOaGVZbW5hVlFHOFc0dEtjcnljbVp6cldTdFNlblQ4YThwSFdJQ2Fia1Bh?=
 =?utf-8?B?QTJpS2o4ejVTem9wVkFoMTZSUkV1VXh0ZkNPY3d2ZDVQZVJVa3BObUVpenA5?=
 =?utf-8?B?WXBFTUd1U0F4c0ZyaW9UNDlvcmJuMkNEVkRrZWFBcGR2aDc4Ty9HeDZteHEx?=
 =?utf-8?B?S0FSN0IxN3kvTmtnc0o1ZzFRclhzWHg3ZXBrNDVMVE1WREdvWFA1OXZOOUtC?=
 =?utf-8?B?ZVhLWStESTNRbFo0SWpjYnNwUjQ4SWZXd0M5Qk40QVRLSEJhMHJzd2pySVFI?=
 =?utf-8?B?VWxyOUxwNGpoanlrRklDOHVLMUY3ZVFNOXk0NDVyWVB5ckl4SVV1ZkRDUWRZ?=
 =?utf-8?B?ditqMzlDQlpBdG5rUDNWb0ZJWVhrVFdKaFI0K1VSeUNDMWZUTTVwZis0Ty93?=
 =?utf-8?B?VGkycUZaRkdqQ0RnTGVtV3hMWVMwTTNWVWhJZG16b0thaStyYUMxNUVGa3l6?=
 =?utf-8?B?TkJyRTlxNzQ0UzBnTlVOQ041TWg5eURCRlljcHQ2M0wwKzNBTEMrOHRCZnJm?=
 =?utf-8?B?dkpKQXU4SzhoMVVadDhOVGhWMlFGRXBVT3ZQQ3BEa0F0dzF1MlZCakNPUEN1?=
 =?utf-8?B?UVMycVNmaXE2YjVMK0ZQenlSYjRhc0NDSytIWTZTRWN1Rkk2bWpVN0poSXRP?=
 =?utf-8?B?NUxtWldDU0IwVjdCRUovUHlsOFN6SklncURncGU1a2w0dWtLUDFqWHdhdjF5?=
 =?utf-8?B?dW1tTjNjSWRPSXNFOVhVN2ZiK0ZVMHRFbjJEMmJDQzhjak4wYU5ScVlkSWZq?=
 =?utf-8?B?UjkzRXJhSmJpdERVZytkWTRTYTNUeERKSVJDNWhZYzBMLzJXR2g4bnZpSGdE?=
 =?utf-8?B?ZU8wSTgzbm9Va1pmS3c3ZXlSdkgweTUvR2JNTnhqT0lDSkNkNlMwb0VvRGRL?=
 =?utf-8?B?OFRzblN1dkJEMmhUTlc2ZUJnKzRaajNjZkQ4WExPY0o0bVNZcVczRXJvSnNp?=
 =?utf-8?B?ZXhYR0lBakdGYVdkSmUvNG1OZ3ZvcWhRb3ZpZUFSWXdvSUxWMHdycVJEQW1r?=
 =?utf-8?B?V3lwdW96WS9ySW4yYWRFYmZ6VjBiVTI5YVV5Tzl3NDBZcW5ILzg1Wkt1dks0?=
 =?utf-8?B?bjBsZjZaS093cnpCcEdZazZQWE04WWo4d0ZTN0xIV0pBdmdKdmxqbmhBL2hV?=
 =?utf-8?B?SmRZZ3JGWVRMWlB4dFlVNkpwU1JtZGJaek95MlNIczNiUUI1bFZNcGl6dFJ4?=
 =?utf-8?B?QTJudWFYNnpGdFNJRE1mYzVnSUt2SWUzVm5YUE1tRVdHczFBeTRzUlVrbFFo?=
 =?utf-8?B?ck1Ic0VHb21YM3FPYklIeDB0WVVYVVI5b3l6QlhCekt0ekVISjJXeVY0VTd6?=
 =?utf-8?B?eE5neS80ak9taXQ1dStWTHV6cFBFeTJXbndrMzZlNTB1ZzRQRzdab0N5amdZ?=
 =?utf-8?B?QzNqMU1uQ25FQzcyanZ2NXVBQzBYQUd0eUtaOVF0aW5MQ2VXZWpyaW85YlRy?=
 =?utf-8?B?WGxhYU5CZGpFNUZHZ0tOazJDMnE1Sm9tRU5kUk9VbHFveU43bGlIMDJOQWRY?=
 =?utf-8?B?SitFaFBxWDdRZjF1bi9mT2IxcGNuaS9heEpGU1I1UU01U2lxNldYNi9STmFZ?=
 =?utf-8?B?QWVTTS9GMThUckR1Skp3amxJdjdBUjN0YzBHZ2JiZWMvUlVuTnFKSG9PaXNM?=
 =?utf-8?B?UUN1N2lEc0tCcFgyQlNDYnExWklYSmpwMjVQUzBIeGMzWWJuZzlnNzJZYTdz?=
 =?utf-8?B?eSs1SGk2emw5R1VsMXIzUXRweDBtcDZnUVdWUXhJa0dKcTEyVm1nVnFTK0wx?=
 =?utf-8?B?YmJleDhLSnZvM2xBbWZXU1R3V0xuNGJBTk9XeUxJVkNwVmhqVVRYK25BaGFt?=
 =?utf-8?B?RkJLSmNMQU5yMXZJdHdvODJBc1dvcGZHcXFEdWJ0dlBkSGFOY3JKUHpCWEpj?=
 =?utf-8?B?SDZuOHIrVDNrRnJxZEVwYUNrWTBsZEs2K2dqNUl2RklhcE53Q3FvWDIrMHA1?=
 =?utf-8?B?c2djVklmM1JZRHpNUkhGRGZPcE5mcTFkZkQ1SkUzY2JyT0NrK2EyNUVjQThJ?=
 =?utf-8?B?K0RJSnpuN0FSTzNBemRENTQ4L29HL0xKLzBYclV0SS82Q25BaUhta1hkSkJo?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29D1428DE18B904181F42AA2B5648489@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fae19d-c2f3-499d-8b78-08dce20c7103
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 11:30:24.3228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzbOMWvKdVtjP+UToB0Moxi6/UD3pi1sZmYfAdeyylV1Yco6mCj4x1qhxQKbzTHq3XpqQubqacIoxrQuSyTAomTMcha6pXSZnmQm/0MTeiCm17+Xr9qs/MI0ye+3LIDX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8026

SGksDQoNCkkgdGhpbmsgdGhlIHN1YmplY3QgbGluZSBzaG91bGQgaGF2ZSAibmV0IiB0YWcgaW5z
dGVhZCBvZiAibmV0LW5leHQiIGFzIA0KaXQgaXMgYW4gdXBkYXRlIG9uIHRoZSBleGlzdGluZyBk
cml2ZXIgaW4gdGhlIG5ldGRldiBzb3VyY2UgdHJlZS4NCg0KaHR0cHM6Ly93d3cua2VybmVsLm9y
Zy9kb2MvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL25ldGRldi1GQVEudHh0DQoNCkJlc3QgcmVn
YXJkcywNClBhcnRoaWJhbiBWDQoNCk9uIDAxLzEwLzI0IDI6MzEgcG0sIEEuIFN2ZXJkbGluIHdy
b3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZyb206IEFu
YXRvbGlqIEd1c3RzY2hpbiA8YWd1c3RAZGVueC5kZT4NCj4gDQo+IEFjY2Vzc2luZyBkZXZpY2Ug
cmVnaXN0ZXJzIHNlZW1zIHRvIGJlIG5vdCByZWxpYWJsZSwgdGhlIGNoaXANCj4gcmV2aXNpb24g
aXMgc29tZXRpbWVzIGRldGVjdGVkIHdyb25nbHkgKDAgaW5zdGVhZCBvZiBleHBlY3RlZCAxKS4N
Cj4gDQo+IEVuc3VyZSB0aGF0IHRoZSBjaGlwIHJlc2V0IGlzIHBlcmZvcm1lZCB2aWEgcmVzZXQg
R1BJTyBhbmQgdGhlbg0KPiB3YWl0IGZvciAnRGV2aWNlIFJlYWR5JyBzdGF0dXMgaW4gSFdfQ0ZH
IHJlZ2lzdGVyIGJlZm9yZSBkb2luZw0KPiBhbnkgcmVnaXN0ZXIgaW5pdGlhbGl6YXRpb25zLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQW5hdG9saWogR3VzdHNjaGluIDxhZ3VzdEBkZW54LmRlPg0K
PiBbYWxleDogYWRkZWQgbXNsZWVwKCkgKyBqdXN0aWZpY2F0aW9uIGZvciB0b3V0XQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5z
LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9uZXQvZHNhL2xhbjkzMDMtY29yZS5jIHwgMzggKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzOCBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL2xhbjkzMDMt
Y29yZS5jIGIvZHJpdmVycy9uZXQvZHNhL2xhbjkzMDMtY29yZS5jDQo+IGluZGV4IDI2ODk0OTkz
OTYzNmEuLjU3NDRlN2FjNDM2ZmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9sYW45
MzAzLWNvcmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvbGFuOTMwMy1jb3JlLmMNCj4gQEAg
LTgzOSw2ICs4MzksOCBAQCBzdGF0aWMgdm9pZCBsYW45MzAzX2hhbmRsZV9yZXNldChzdHJ1Y3Qg
bGFuOTMwMyAqY2hpcCkNCj4gICAgICAgICAgaWYgKCFjaGlwLT5yZXNldF9ncGlvKQ0KPiAgICAg
ICAgICAgICAgICAgIHJldHVybjsNCj4gDQo+ICsgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNs
ZWVwKGNoaXAtPnJlc2V0X2dwaW8sIDEpOw0KPiArDQo+ICAgICAgICAgIGlmIChjaGlwLT5yZXNl
dF9kdXJhdGlvbiAhPSAwKQ0KPiAgICAgICAgICAgICAgICAgIG1zbGVlcChjaGlwLT5yZXNldF9k
dXJhdGlvbik7DQo+IA0KPiBAQCAtODYzLDkgKzg2NSw0NSBAQCBzdGF0aWMgaW50IGxhbjkzMDNf
ZGlzYWJsZV9wcm9jZXNzaW5nKHN0cnVjdCBsYW45MzAzICpjaGlwKQ0KPiANCj4gICBzdGF0aWMg
aW50IGxhbjkzMDNfY2hlY2tfZGV2aWNlKHN0cnVjdCBsYW45MzAzICpjaGlwKQ0KPiAgIHsNCj4g
KyAgICAgICAvKg0KPiArICAgICAgICAqIExvYWRpbmcgb2YgdGhlIGxhcmdlc3Qgc3VwcG9ydGVk
IEVFUFJPTSBpcyBleHBlY3RlZCB0byB0YWtlIGF0IGxlYXN0DQo+ICsgICAgICAgICogNS45cw0K
PiArICAgICAgICAqLw0KPiArICAgICAgIGludCB0b3V0ID0gNjAwMCAvIDMwOw0KPiAgICAgICAg
ICBpbnQgcmV0Ow0KPiAgICAgICAgICB1MzIgcmVnOw0KPiANCj4gKyAgICAgICBkbyB7DQo+ICsg
ICAgICAgICAgICAgICByZXQgPSBsYW45MzAzX3JlYWQoY2hpcC0+cmVnbWFwLCBMQU45MzAzX0hX
X0NGRywgJnJlZyk7DQo+ICsgICAgICAgICAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGRldl9lcnIoY2hpcC0+ZGV2LCAiZmFpbGVkIHRvIHJlYWQgSFdfQ0ZHIHJl
ZzogJWRcbiIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0KTsNCj4gKyAg
ICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgIHRvdXQtLTsNCj4gKw0KPiArICAgICAg
ICAgICAgICAgZGV2X2RiZyhjaGlwLT5kZXYsICIlczogSFdfQ0ZHOiAweCUwOHhcbiIsIF9fZnVu
Y19fLCByZWcpOw0KPiArICAgICAgICAgICAgICAgaWYgKChyZWcgJiBMQU45MzAzX0hXX0NGR19S
RUFEWSkgfHwgIXRvdXQpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiArDQo+
ICsgICAgICAgICAgICAgICAvKg0KPiArICAgICAgICAgICAgICAgICogSW4gSTJDLW1hbmFnZWQg
Y29uZmlndXJhdGlvbnMgdGhpcyBwb2xsaW5nIGxvb3Agd2lsbCBjbGFzaA0KPiArICAgICAgICAg
ICAgICAgICogd2l0aCBzd2l0Y2gncyByZWFkaW5nIG9mIEVFUFJPTSByaWdodCBhZnRlciByZXNl
dCBhbmQgdGhpcw0KPiArICAgICAgICAgICAgICAgICogYmVoYXZpb3VyIGlzIG5vdCBjb25maWd1
cmFibGUuIFdoaWxlIGxhbjkzMDNfcmVhZCgpIGFscmVhZHkNCj4gKyAgICAgICAgICAgICAgICAq
IGhhcyBxdWl0ZSBsb25nIHJldHJ5IHRpbWVvdXQsIHNlZW1zIG5vdCBhbGwgY2FzZXMgYXJlIGJl
aW5nDQo+ICsgICAgICAgICAgICAgICAgKiBkZXRlY3RlZCBhcyBhcmJpdHJhdGlvbiBlcnJvci4N
Cj4gKyAgICAgICAgICAgICAgICAqDQo+ICsgICAgICAgICAgICAgICAgKiBBY2NvcmRpbmcgdG8g
ZGF0YXNoZWV0LCBFRVBST00gbG9hZGVyIGhhcyAzMG1zIHRpbWVvdXQNCj4gKyAgICAgICAgICAg
ICAgICAqIChpbiBjYXNlIG9mIG1pc3NpbmcgRUVQUk9NKS4NCj4gKyAgICAgICAgICAgICAgICAq
Lw0KPiArICAgICAgICAgICAgICAgbXNsZWVwKDMwKTsNCj4gKyAgICAgICB9IHdoaWxlICh0cnVl
KTsNCj4gKw0KPiArICAgICAgIGlmICghdG91dCkgew0KPiArICAgICAgICAgICAgICAgZGV2X2Vy
cihjaGlwLT5kZXYsICIlczogSFdfQ0ZHIG5vdCByZWFkeTogMHglMDh4XG4iLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgcmVnKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVy
biAtRU5PREVWOw0KPiArICAgICAgIH0NCj4gKw0KPiAgICAgICAgICByZXQgPSBsYW45MzAzX3Jl
YWQoY2hpcC0+cmVnbWFwLCBMQU45MzAzX0NISVBfUkVWLCAmcmVnKTsNCj4gICAgICAgICAgaWYg
KHJldCkgew0KPiAgICAgICAgICAgICAgICAgIGRldl9lcnIoY2hpcC0+ZGV2LCAiZmFpbGVkIHRv
IHJlYWQgY2hpcCByZXZpc2lvbiByZWdpc3RlcjogJWRcbiIsDQo+IC0tDQo+IDIuNDYuMA0KPiAN
Cj4gDQoNCg==

