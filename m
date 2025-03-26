Return-Path: <netdev+bounces-177769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD654A71AD9
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF21891D31
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B601F4CB7;
	Wed, 26 Mar 2025 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O2Va31fI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511861F463F
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003440; cv=fail; b=qHVNUlGi3OEv8ZA1LVrduQmHXM5GL060fbtpoEPciYdZZAzLy3kBEDsB4Rnrlfs4gFo2vWDW3LedxlxdjQTZPK8fduUw7yTbvvSiEhjJpEobBKj3JQIc9jEx6ATwxGz2grUXTmOfJMZW5lR0HBBc0EcKiVsrTboFU+NHECm7r/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003440; c=relaxed/simple;
	bh=coGwprHsL/6K9e6GaVjpObdp5Q7TmQkkj0p690cYd8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gE5BDQ4YK0uX4dotwqBiLydaRpzkmNhZG+JysIJ1N+HyWovTYTxoTritA0rGDOhHEdGePpTHUVIYvFX1rkM93jE5JvsmGDyJcdTkmol6wxa30w+sKoJPE/OYfcYrmmyOhNOoyf5WllP4Epvt6pEAuBYdASr5ab+ZT6EOtTdP02U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O2Va31fI; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLrsu58bz3xRp/xPK+pciSrmr1UnUDBzgaO0fTB/kDFAS38nv9iPQUv+347GB+PNQaIVFB73SKAEeF8vnig9/xqXYT5F1E5e68oBghkrGDLV/5K3zkJjwNgN3Pyr/nvQj6w/rC3IzH9TYmuSEzNiaZtQ11u5kmyI3O7tm0uZXZU2TF/0ul2n0o6DQIngwK4mBmEaSxxVcXAMzTrTWz21ALfqMLu0ZWkyVllNCgwcBvSn70bBFxi4YRoiC4/86bVi2dBU2HpaDVKozl2y8PJmRirXfrrR2c41WlFTxq2FdDEIzN3U2yA+J42caWUc1k3yJXrO+YwdsrxbZInZVQADJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coGwprHsL/6K9e6GaVjpObdp5Q7TmQkkj0p690cYd8w=;
 b=fChnXmldRX3z7BTkkTJNt0JwqnT36TTZcP8OxVS8RuOsEYjtdwEMCkUjKju+UeGV1zQfobme4QUJ+wD9oE+j+kYYqAJC11dOlDbEpHGlnYp2MsMeYLz9QTWJu6rIChzNVJMAZizLlIEJGmXeG3UX9obAL/J8rcDgsAnz3L+0SsWB1yhoq5s+R2qVvYSP2IHnYrgIghYT07hp9A7cM3RxxMypraH75eWZzzP22/YWXHw6IM10A/QCSXpc4YCdj3UF88+QUYF4yeu7xSrE8KFv9hUVhzSq0X7IwEBbGVQntZqMND8FcKn0TuGt2adbkXBJ+9hHDn8eSeX0WjySuMVFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coGwprHsL/6K9e6GaVjpObdp5Q7TmQkkj0p690cYd8w=;
 b=O2Va31fIMA+aYA47SDKEA4jqKHUVWda8wgJQAbj7TwhFX66iY/aMAKyjGXNYipheOf+M8H32mNfUbc6o12IPjh6JXK45i/nxiivUDHTRK2fPaaGu6fLJ7N15MCQ/Uyx1abX008BP1idMihkrBVLQPqUX1/KgBvu0wbzOhqtEiGQmpYpH8nstYDtiKqs2ltkqWT3jWpgJQR6BNpmwZudUVAzDiTYqSL7XtE7W7uIg9bMbBTsrAF9NS7pWFq3T7MBpKhbV+pHzCom/4JGOM3CkknYXLNLFK/mA6uX7/E5CA2SsTftp+TQvfTec11MYZzF3H0tFRU+M/4l/IvCO0GZEUA==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 15:37:15 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 15:37:15 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Thread-Topic: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Thread-Index: AQHbnc04GLropLE/UEietC5IV/U+Q7OFhLuAgAAF24CAAAOvAA==
Date: Wed, 26 Mar 2025 15:37:14 +0000
Message-ID: <672305efd02d3d29520f49a1c18e2f4da6e90902.camel@nvidia.com>
References: <20250325213056.332902-1-sdf@fomichev.me>
	 <20250325213056.332902-3-sdf@fomichev.me>
	 <86b753c439badc25968a01d03ed59b734886ad9b.camel@nvidia.com>
	 <Z-QcD5BXD5mY3BA_@mini-arch>
In-Reply-To: <Z-QcD5BXD5mY3BA_@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|CH3PR12MB8210:EE_
x-ms-office365-filtering-correlation-id: c2a56a05-65c7-4b1f-0843-08dd6c7c1599
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dTJEVFM4cnlJMC82Qy9DWlVUZS9VTGoxc05YVFM1enJxWTFPTkZFWUM2bmRG?=
 =?utf-8?B?eXdCcDZ0NktTQ2tRcTVxbDg1V1kvUDJQZjFhTlVOdDF4S3lJUGVQYi9lNXRn?=
 =?utf-8?B?R1M4NllsVVBpWGNDckp3WnMxNlBoWjMzTGJmQU9QMURIRTVTZ2VBNzFJVDFP?=
 =?utf-8?B?eHIxZFp1aE9kNUd5aFJBVUhiWG5xR3NYdWViOCtZTmJleEEzaDlxVkhmcXpU?=
 =?utf-8?B?T1VkOUdsTklkWkMxcktwaEdiNlJWVVp3UVJZOVR5TExzSlREQVBuaDR1eGoz?=
 =?utf-8?B?MmMrTUoxZ3NpU2VmWURqZVR4UnpqdzNocTZSNU1KcVY1L0JuZmJKRHkrb1d1?=
 =?utf-8?B?SVNZWWJ2Uys4eC91aTU1cS92Z0tuRHNjQlNsWlNvcU03aHdzL2FQcW1MT05L?=
 =?utf-8?B?TFFUdmxOYlB2YkhLQ3JoRkpOYmg2ZHVRZzlRWmV5ZXlsVktOakk1ekhlbTA1?=
 =?utf-8?B?UUsrSVh5VFRBU3pvUDhlaW5lZDBzVlVoZUNybi9GYVo3VlBpTDR6Y08yZk5n?=
 =?utf-8?B?bVFSWW5YUkFiQllEZXhacW1vZVVNK1FNeHlKYStwdU1EeEw0Q2JBaXRrZEow?=
 =?utf-8?B?MlhFellnRDFtYWpSMU5GbCtLSWxEdk1abGxSU2ZHNXpiRFR2UG00RTNEYkpt?=
 =?utf-8?B?NXQ1bUluZlA0Zk5Ua05nSW5yTk1ZcUQxYkNnQXZ1QXFxa3RndEpEenYvalZ5?=
 =?utf-8?B?UENZTjB0YTFaVWtiM3FSSENDYnpoNXpZaE5UVzIxQzFxQ0d0MWtHL0l5dzF2?=
 =?utf-8?B?YklXcWFna2NjNG8zaERmNEpNLzNuWUhHaEMranVlbG9OSUcrVEVxVEo2NVBi?=
 =?utf-8?B?VmR4ckgvN2gwODdoRFpYWkYzczN0RVJ6VTROcWVRVDRseDc3cWJrZVNjaEdW?=
 =?utf-8?B?cnE1NEQ1NUZiTXBlMEJ2aDR1YU9mSlM0MzRIb2tHb00zUno0UVQ0RVhUOWpG?=
 =?utf-8?B?Q25tRisyYUFiQTVPTlJGSHRnNXdKanpYNEQvRVVwNWdFTTFIQ08yTWpjaUtx?=
 =?utf-8?B?Q2JzSS9WNWJTTDNsWXdEb0JOeHp5bGRmQmIxZ1pFakpMQnMrYWk4NDNmMURL?=
 =?utf-8?B?VUNuSXEwVFdBeTduaXE1Wmw1TXRGMmUvVmc0Sy9VWnhPUmgyQmtWaExzaXVu?=
 =?utf-8?B?TjJmOHJLYkdmem1rcGVTUTRqeHZJVGpvL1pIV2RqbUF3Mk55WTlXbEVJd2U0?=
 =?utf-8?B?dk1TcXFVcnZTYy9xZFV6cklTM1U4THRHc2xtdkh0UTA3eU1BTXFwRmlZd1Js?=
 =?utf-8?B?TkkyaVJjZ2MrMlNINm13TzI3OG9oMW1vT2JnTE8xbXArUFN1SUN2ajVNbDFE?=
 =?utf-8?B?Y2owR29yOFdLNzVqYTZpdG5kaEVmTUVYRWNwM1FuVzlmVUMvNjBhKzU5NURB?=
 =?utf-8?B?ajQ1ZWJmZzZyVk9IOXZBSXdSY2ZRSm1hWVJ6TmhDcHR0NDhNVkI1VzA5RkVB?=
 =?utf-8?B?akZuK2VRZUlwL3NWQzh1bWdsZ0ttZGl1d08zUkI1ZXhkb1BHclowL3VkdzQ5?=
 =?utf-8?B?QTQwVndZRHh6MkZiaHJpUEU0cm9SYjc0bXZpWWQ4R3QxZFh5eGFPS1NyMTdj?=
 =?utf-8?B?QkRIeUt4b0lOSVlVdndrS21GVnUxbGp5bHlmNUwxbEp2SGdpU2FOZEVlU3I4?=
 =?utf-8?B?NitrOU1PY0dGT0twZ1piR0xlSi9EWEVnQnZRb3dMRU5lcVA4MWN1Y2FJSFRy?=
 =?utf-8?B?czVxZ3pOdTdJQmZHL2RNZS83dWNXeFQxbGNJRVNHYWhlY0NoUFBTSnNGNVBv?=
 =?utf-8?B?L1k3a1NPdmxXYk9ySXJaQklpaVd2MitGYktYQlRGdU1qSnpBZzZMQ1YwSmpW?=
 =?utf-8?B?OVZTTm5ucXRDTFp5MldVQUMwRnR6djYxYXRJcEt0S1R1Z3hXdEpjWnY1ODFC?=
 =?utf-8?B?MjlNOVpnK0REZ0swMGZ2SjQzMG8rSTh1VHV4N3ZJbGZUQWE1MHZmK2NZb2dF?=
 =?utf-8?Q?bikJTd0vM3QxbUXdsBAVA2VKcdPo++oq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0Q5MXJ1a0pab1RLQ3Y2dTRzcHBTK28vR3ZaSUhJYnBRVlZ2a0tuNEZsUkhM?=
 =?utf-8?B?OUxJdGM3Ymt3aC9YTitDMjRHVUJWa2pxVVNEd0xyU1hqTGJxNWRGRkRhV3VQ?=
 =?utf-8?B?RW9XVFNUQ0FjdkhhM1MwMmdIT1RRaXJPQ3ZEc0NveUUzejJGOFJvamtnaGE1?=
 =?utf-8?B?N0tqMzRPdzhMYnlPUlMwVEREZ0x5SWp5SnZ1NXZTWVp2ZW53Q1F2K2hTTEZm?=
 =?utf-8?B?cDJRVG5pZHJoVUU4V2NLMk42MVpkZFVyejNETHdDUWJlUVVXQkp0dFlqYlpk?=
 =?utf-8?B?YjFDUkhPZ3FsVEhVVmwvUFFtQXFDSWUwWFg0MUVsVEFQTk44RlhSanJIZWxL?=
 =?utf-8?B?cDNROWJwaXFuREc2RGh4OVdSZ3d1TWpiaXpJeWNsRURKMWhFdjArRE9Vb3Ra?=
 =?utf-8?B?alp4QUgwQ2JRalRuOVZZNlRHTy90bGdMVkNJa1NvZXZuYkFweWQvNXNVbmhm?=
 =?utf-8?B?VDA5aUl0dlRxMW9FRGgzWUhDMWFybXljakFnVjBJOVc2U3UvZEFBZDBROXB5?=
 =?utf-8?B?VFl4a2NpYWxWMUFpR0Y1MjFxM1pIanFkYXRoR3NDa0F1VzViUDRybHNMSmJh?=
 =?utf-8?B?RW5za3V4SHUxVzdjZm1pdWI2cCtXN2FqSFUzdCtrWVNHanorbDZOK204ZU1N?=
 =?utf-8?B?OG92L3htM21aQXVLTUozNW4zU1N6RzlhTzJDUU03S0k0VTY4ekc1aHZxc3BT?=
 =?utf-8?B?OGN3WlkrcjJrK1Q5UlhGVm5uSEluNWg2Z2hOOVNFZzhiQ3dGZ3gyWFA3Z1d0?=
 =?utf-8?B?VnE0bHNjSk05Rzd3VEVGUVEyUVJxRFV4MUxmOTQwU3BZdDJDWEpHY1hZTXVN?=
 =?utf-8?B?VXZWQWZVOFJabHRvRGtLT1dOYUNocWRWZ09UclFwNTcrWXBVZUd1YWlBMWJl?=
 =?utf-8?B?cVVobVpXdXVWOXJnNjdoSTZMdXdRMEJ0dHA2UHBjSjJNbTBDT1NUYVpMYlhj?=
 =?utf-8?B?K1NRdzlLUWM0aGRwZHJJbitlQW9PUE5IbG0rZXcrWHJYN3VObVlWN2FUWExh?=
 =?utf-8?B?VDlEeTBEZ1lQUi9Gd3gzUWhSc1BWVjVhLzJCVHdubGZEYjJBMm13NkJZb3hW?=
 =?utf-8?B?YWRUc2RNMUtOcUR0YzUveGJCQmxZYmpORmw3TTYxSU9CUU95bXQxajN6TnNI?=
 =?utf-8?B?L0VmOUp2QkpiSHMvdXhFVG1KQ0RXN2VkSUtmbHJ4dWVWS0p5M0dCdmJkWlFT?=
 =?utf-8?B?SHNXYWdQOWM4dUl3QWNrYzlCOENiRzBnTmNxRFpEbzRGd2RNVEVtclZPN1cr?=
 =?utf-8?B?K2FlQkU5WXpFWS9kaTlOd0dtUTZMakFFUnZzU1o3ejgxbGNPYk9FRnFsYkJt?=
 =?utf-8?B?dHZKamRpWHF5c002VW5QRmtzMitrN3U3aXVPRE54TzFmS0IxYS91aWtycWlJ?=
 =?utf-8?B?QkdQMHo3YWpOaUw4dmtqWllUUGd4NWp2QytJYWpmYndSU0dVSTJHTEVRUzlP?=
 =?utf-8?B?UHBJVW9yUlVQRUxydUZ5K0NWeTJQMFhCL0VzRFRHTGZDOHhGM1c0Z0w0KzRT?=
 =?utf-8?B?ZEFEQWhJdEFnSVI2VEF5OHY5dkdIdzVaZE9CM3l0NE1vNlcxSVZ1SHgwMWtn?=
 =?utf-8?B?WUw3ZHBjMjJwc2RXQStFRkl4Y045bTlPQmpJY3pycy9yWDhiQS9wOFdnY3BM?=
 =?utf-8?B?L20vWmFSVG5CTlpYM2VseGpHNmprUUMyMjNlcnlndklrNzN5U09VWC9FT0pa?=
 =?utf-8?B?ZDh3ZndYOXhtU2xPYitVTVIvMWl5TW1KVFVSWjdDeUMzRGxUQjh0cUJtUXZM?=
 =?utf-8?B?OWdWNkFYc1F6Y1NMc3JKNGo2dUxrenJobFFaMTYzNmM2MHp1Q2VtQnlQQWVJ?=
 =?utf-8?B?Y1NDVDcyN1h1QWxsS3FHSDA5ZVErUHI2KzN3bTVDWHRzaklabTdqV3V1Wkwz?=
 =?utf-8?B?NC9EZnlzSUszNkkrVEYwSXZYWmtkTll2VTFRb1I4OGt3cU9mZmlPLytyZkJV?=
 =?utf-8?B?d2hQNkhnQ3YwQjBmK2E1UEg1NjRXOWFMTEJaTmcxVnJJV0RwWVRIK3E5NFMr?=
 =?utf-8?B?ckdNVmU1ckx4SGdrSklzYlBFeHFzYTF3S3hNbHdUWnBXbnFTNmRaeGFvUUtw?=
 =?utf-8?B?UitzRW8wOXhaQ21JclEvZUdaeHdoZmthQm5rUS9lQzFEL0kvWmNOaE5hQ29F?=
 =?utf-8?Q?SkCJZ89Lyccy2hevcxdFuByBJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D7B05849B6BD24589BCB0083189B48C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a56a05-65c7-4b1f-0843-08dd6c7c1599
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 15:37:15.0087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yewGb/VTEBhxqHj/5SRgZVdzAdSIo2zymCiWNGXOySqMho1ZZZq0qEWDXtJUhvJQ4DUAm6TAoeKliLwl1CvIHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210

T24gV2VkLCAyMDI1LTAzLTI2IGF0IDA4OjIzIC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IEBAIC0yMDI4LDcgKzIwMjgsNyBAQCBpbnQgdW5yZWdpc3Rlcl9uZXRkZXZpY2Vfbm90
aWZpZXIoc3RydWN0DQo+IG5vdGlmaWVyX2Jsb2NrICpuYikNCj4gwqANCj4gwqAJZm9yX2VhY2hf
bmV0KG5ldCkgew0KPiDCoAkJX19ydG5sX25ldF9sb2NrKG5ldCk7DQo+IC0JCWNhbGxfbmV0ZGV2
aWNlX3VucmVnaXN0ZXJfbmV0X25vdGlmaWVycyhuYiwgbmV0LA0KPiB0cnVlKTsNCj4gKwkJY2Fs
bF9uZXRkZXZpY2VfdW5yZWdpc3Rlcl9uZXRfbm90aWZpZXJzKG5iLCBuZXQsDQo+IE5VTEwpOw0K
PiDCoAkJX19ydG5sX25ldF91bmxvY2sobmV0KTsNCj4gwqAJfQ0KDQpJIHRlc3RlZC4gVGhlIGRl
YWRsb2NrIGlzIGJhY2sgbm93LCBiZWNhdXNlIGRldiAhPSBOVUxMIGFuZCBpZiB0aGUgbG9jaw0K
aXMgaGVsZCAobGlrZSBpbiB0aGUgYmVsb3cgc3RhY2spLCB0aGUgbXV0ZXhfbG9jayB3aWxsIGJl
IGF0dGVtcHRlZA0KYWdhaW46DQoNCldBUk5JTkc6IHBvc3NpYmxlIHJlY3Vyc2l2ZSBsb2NraW5n
IGRldGVjdGVkDQo2LjE0LjAtcmM2KyAjMTQ4IFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICANCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQppcC8xNzY2IGlzIHRy
eWluZyB0byBhY3F1aXJlIGxvY2s6DQpmZmZmODg4MTEwZTE4YzgwICgmZGV2LT5sb2NrKXsrLisu
fS17NDo0fSwgYXQ6DQpjYWxsX25ldGRldmljZV91bnJlZ2lzdGVyX25vdGlmaWVycysweDdkLzB4
MTQwDQoNCmJ1dCB0YXNrIGlzIGFscmVhZHkgaG9sZGluZyBsb2NrOg0KZmZmZjg4ODEzMGFlMGM4
MCAoJmRldi0+bG9jayl7Ky4rLn0tezQ6NH0sIGF0Og0KZG9fc2V0bGluay5pc3JhLjArMHg1Yi8w
eDEyMjANCg0Kb3RoZXIgaW5mbyB0aGF0IG1pZ2h0IGhlbHAgdXMgZGVidWcgdGhpczogDQogUG9z
c2libGUgdW5zYWZlIGxvY2tpbmcgc2NlbmFyaW86DQoNCiAgICAgICBDUFUwDQogICAgICAgLS0t
LQ0KICBsb2NrKCZkZXYtPmxvY2spOw0KICBsb2NrKCZkZXYtPmxvY2spOw0KDQogKioqIERFQURM
T0NLICoqKg0KDQogTWF5IGJlIGR1ZSB0byBtaXNzaW5nIGxvY2sgbmVzdGluZyBub3RhdGlvbg0K
DQoyIGxvY2tzIGhlbGQgYnkgaXAvMTc2NjoNCiAjMDogZmZmZmZmZmY4MmRmMThjOCAocnRubF9t
dXRleCl7Ky4rLn0tezQ6NH0sIGF0Og0KcnRubF9uZXdsaW5rKzB4MzVkLzB4YjUwDQogIzE6IGZm
ZmY4ODgxMzBhZTBjODAgKCZkZXYtPmxvY2speysuKy59LXs0OjR9LCBhdDoNCmRvX3NldGxpbmsu
aXNyYS4wKzB4NWIvMHgxMjIwDQoNCnN0YWNrIGJhY2t0cmFjZToNCg0KcHJpbnRfZGVhZGxvY2tf
YnVnKzB4Mjc0LzB4M2IwDQpfX2xvY2tfYWNxdWlyZSsweDEyMjkvMHgyNDcwDQpsb2NrX2FjcXVp
cmUrMHhiNy8weDJiMA0KX19tdXRleF9sb2NrKzB4YTYvMHhkMjANCmNhbGxfbmV0ZGV2aWNlX3Vu
cmVnaXN0ZXJfbm90aWZpZXJzKzB4N2QvMHgxNDANCm5ldGlmX2NoYW5nZV9uZXRfbmFtZXNwYWNl
KzB4NGJhLzB4YTkwDQpkb19zZXRsaW5rLmlzcmEuMCsweGQ1LzB4MTIyMA0KDQpDb3NtaW4uDQo=

