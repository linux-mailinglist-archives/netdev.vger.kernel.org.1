Return-Path: <netdev+bounces-99325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3FE8D4810
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C7528132F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201DA13B290;
	Thu, 30 May 2024 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ea/jBuff"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA976F310
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059897; cv=fail; b=ZCtc3N9978OEeSmHZ3wTOr+BumRw824QkDWQDXDlfQm08zmKEP7NO54H0Qh/LcpCQm+ejAl+DAmlmkExqE8HWvWImotfml+73Mm1M5XCEutvnWCEYiU0z1N2xV6VmOXztz8azCjgNaKTMUu6EYmpqUgEMx+oIiBsxviTPHH/WHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059897; c=relaxed/simple;
	bh=RfdiF/IhhaFn2ah+kburvdq3tFU9yiA2kwFMpPocYRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YXKfm4zVOoC8xYO/P7hYbQBxh2No6CS2fOnbXXB+61zckiqUTJRdaKE2Qvdxlk9yxqQyW2B+o1JVFvNcootXxa7GKyV1eb+pMWgghWKHhHuxe4qGXxeU4XP2jNuPN5Gu9/ItYgCqTTmXeM1LmfV6JpZUgaPBtoWu6ejn1DuIiuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ea/jBuff; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBiIX0ELH86nxwLfOpTyDLvwHNVr02b7Rq5eTqwLq/A3ZOw7FaHkOJtmL28H0N9qzhPoZyTRRXOYzTodAe0gN0lBmjXmna5oUwFcp5qYsnnAjr3G0fL0wqNGr0ZKO10DJbM1iqZpd6/l7UlaWmd2cw9lGkDBKMbZNd8WZV5JXKY7DpvDGiu+K/2iQXpT++FUAPC4Uz2jOLaCdab1I1hkeb8EmRa7jvPO77JdGicUO3qQvo9Y+ghseEyGN0Py19eA+TAWmWY3JNKKWzevEAYuSV9byh3oYNn+zPOJrzMq+ZhkWSlSNVePxGmYMuHlOlWInbAWqWECcCzWqsC3Cvr9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfdiF/IhhaFn2ah+kburvdq3tFU9yiA2kwFMpPocYRE=;
 b=j1Sc8SzHCsEuZpC31aUxu1aAeMG+7kmisvIgcSgqfWcAuy/KqV8igwPm/OJQznZuv+MRXINAQUtxhUscDEDTRyRL4a/TdV7tMvRNLdQwsbleL5b+aX+yRz1s1qNtDwm2SdupFlaOy4sXKpcAHa3xmjJfbLxh+8/8TsSgdwU3t+DI66wK+bILO2Ida266CzIsBl+lDBHqj+2h4exK8lnw9j5Jx7qAQ50hS/p4UxFj9jEVInnuVr3bMXfM2G45Gx+LBZcEiy8CHf8mvjWEjUsAjUuV8p30RylX+8OIefEe1uQQGmxArHeZHR6HijYKltspR6l2Eui4G8+/QSO2k0hLQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfdiF/IhhaFn2ah+kburvdq3tFU9yiA2kwFMpPocYRE=;
 b=ea/jBuffd5hK3dPT3PwJNjYJ6pFIgj9pEmWiSGBXBqJee8834t/07BlZ7uTnHe7FUfPPEpIA0DT98R6ishmfnC3zWrPAXbQ5CkjMMLBiPamovOSnk20/FTxz86xuyS9m6aQVjyEMxQsqkT0vCAgNwhKveX0FKlEK6c/X5DevnOt3dTkvUhxcWhd2luBSgCTti3CoPhniynBP5G1yMSxiMvbAzl4PGhYu3rF0yct1ucvNCLT+B6LDnGxCWCDEBA5PkxxayBumqdyl2vx00ui0i1MHern3EwPAgdBmCL2vkZVbI6tvQQGTLijC560+OjYQ3nEVvT560q9SQ/E76hvdQg==
Received: from PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 09:04:52 +0000
Received: from PH8PR12MB6843.namprd12.prod.outlook.com
 ([fe80::5958:e64b:fe79:d386]) by PH8PR12MB6843.namprd12.prod.outlook.com
 ([fe80::5958:e64b:fe79:d386%3]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 09:04:52 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Raed Salem <raeds@nvidia.com>
CC: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, Tariq
 Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Boris Pismenny
	<borisp@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [RFC net-next 14/15] net/mlx5e: Add Rx data path offload
Thread-Topic: [RFC net-next 14/15] net/mlx5e: Add Rx data path offload
Thread-Index: AQHaoobYgMT0acg6TUev/hvvsALS17GUa/gAgBo95ACAAPHygA==
Date: Thu, 30 May 2024 09:04:52 +0000
Message-ID: <75e8b441ace12b028f779163a0980b310ad68504.camel@nvidia.com>
References: <20240510030435.120935-1-kuba@kernel.org>
	 <20240510030435.120935-15-kuba@kernel.org>
	 <664172ded406f_1d6c6729412@willemb.c.googlers.com.notmuch>
	 <20240529113854.14fd929e@kernel.org>
In-Reply-To: <20240529113854.14fd929e@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6843:EE_|MN2PR12MB4253:EE_
x-ms-office365-filtering-correlation-id: 997a3b78-13c0-45e2-a5a9-08dc8087911e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVF2TG4wNFZBRGF6Sk1rWndJL3Z0OXFkUnhsRDdieUdTUERmeGw2UWFJWHNX?=
 =?utf-8?B?dVJMZUxqczE2RDFBSWxXYVcvKzYrNkZHVVFnaXNrU0lyVzVwVlJtNXRySGRl?=
 =?utf-8?B?UVNCL2NySERYWENVaTVPQmg1Vzh2NlRVRUQrTi8xeXJyZWZudU81Z0FwNVAw?=
 =?utf-8?B?NzhJejJGcmI1K0Yrdno2RjFEaGVBOTFLZ1g2c013N2piRm4zNjZSK3hMWnFt?=
 =?utf-8?B?NjZuTnJmS1hjWGhxS3ZPSy8vd0IzeC8zRXlHeVFhU1E3SkcxL1RaZ1Q1Yk1H?=
 =?utf-8?B?WUJuSnZaa1lMTldHTlIrZjdKNE84QnhOMXIrZFRBTmxmQTdFeFFiWkRuZ3ZX?=
 =?utf-8?B?bnFFUWlvaUhlRjIzMzFkQmFvYk8rUFJuK0lyVE5BMysxZkFDQTRPRHlBTGlL?=
 =?utf-8?B?Y1VQUi92NDdNOWJhUTIrWUNjdUxNMVBKQXhTd0tiRG5QYlBEdTFLd1ovdU01?=
 =?utf-8?B?WTFuSytSVFV4NmswY3dybzN6aXF5dHc0am9wUlg2UjY2QlpiNkJiTVFyTUZm?=
 =?utf-8?B?ZnNTTEtLUkdmMEYvODZKWThyNWhXcmJURWtXS1hvVUVUOFNkNEl3dTFtaGtu?=
 =?utf-8?B?Zk5lV3pkcXVVWkw5ZE4vK0FQdnJlSmE5UU5nbHhCTk5heXVMWHRLNDdGZnBR?=
 =?utf-8?B?UzJxUXFjWG1jMVlhbVNrS2M4aTZETHh1UTVFR3RXdGhQcGNtUUlkMFRzRnFW?=
 =?utf-8?B?UmY1cTJkY1IzWmI4WDNUWFhSbTRYQkZZOThzUDNBZ2VyYlZob2NQZ2RHODFu?=
 =?utf-8?B?TVVkY0YvdGRUbHJyeUZEQ2VOSDZZY2x3RW9tSVdPR2UzMkRUbWlJWjEvOVZ4?=
 =?utf-8?B?aURwbjJQbEdOaVgrLy9DLzBPa0NYUkZDc1VMd1dUTnBkSkFWRHZaT1BFOWY3?=
 =?utf-8?B?cHFHWk5CU09yNGpOM2Q5NnhhTDRKeHRYRi9JazFjUWVRSFlIZ2RIa3NycTM3?=
 =?utf-8?B?SkE5OHJaYm9ORzRHU2lSUlJWdVRJakVSNG1NdVcrRUNZamN0M1dZU0ZubENh?=
 =?utf-8?B?Sk1IUWFlSnBvOXc0emVVelN2MHpSRm4vTmwwRjdqQlBYbXEwRzBlWHVCSytt?=
 =?utf-8?B?c1J3SEdaL1RVL3NXTFV4S2Evd0wyY1U3LzViY0NvWkFVWGVWd2NpUDRRenlR?=
 =?utf-8?B?bmhybGdMMDUvaXlyN0t6aWN1dHVRR0F0cE4ydUw1SUhmQ1p6ZEFlRC9SMjdO?=
 =?utf-8?B?VXo5a3RRSEZlK2JMR0MxTXZpb3E0NTVGV0ZMY05UT3o2Zmp3VDMxQzRMd2cy?=
 =?utf-8?B?QzNXckFxVkY2STUxRlFXdGxBZldZQ3BGbExjdVBzSHA3N25Yalh3VTNNTGpD?=
 =?utf-8?B?cjcrOURqU2U5ZklsRDg4bmRrMkpVVTI4VC95R3I5NVBEOFc0RlFPNGU1YW4r?=
 =?utf-8?B?b3R1TlNzSFB1QjAwWXlza1NvSGp0eEpsZGY4NXV1OVA0U1BWb29BbFNXeWRs?=
 =?utf-8?B?UDdoOC94ME55RTJ3SUk0aUREaDN6eHloeTBpUzBVUzZSVmhxalE2MWtTOVlq?=
 =?utf-8?B?cWx2WjJ1cnhuZFdJQUNrUTRoTWltaUU4RnE5OWdlRmh0K3dDaWljNXlNaUJR?=
 =?utf-8?B?U0hrQ3pucjVwTW5SSkFVQ1RqN1k1Rmg5MENTZzRBMlkrQ0N0NitwMHo1S2Ix?=
 =?utf-8?B?UG56ODk3UWU3SmxRU0EzUXhsM2lIK1AwWFVDV2xBT0N3Z0VGbDBQWFNHTy9N?=
 =?utf-8?B?d1hOSGliZG1hZDNQazFESFVYOStHZExBTVpkYkJ2ekpHT1NvM3pBWEpoT0dC?=
 =?utf-8?B?akx6NHRrdHdUUEUvaUdQQnlXenp5STFXa0k3blkrU21paXlzTWdOc0p3TnBw?=
 =?utf-8?B?VS9Ba282Ums0alhmbDBPdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVZSTTlYb1Q0TG9iNDFJODZqNHlIRktjRGp6TVhtbnhMa0lGWEFMZjg5bWhm?=
 =?utf-8?B?b001VG5UM3RRUFZrOXpsWTRwMkJNSzl0WXNFNWY2RUNnYTg0Q1FIZUxZVTBN?=
 =?utf-8?B?d3FUZm9vNmpyYzljTC9SUG1oTWlRUFY0S21zbUdsbTVNQm9Ua1E5MDNPaWRX?=
 =?utf-8?B?a2dyYldsL2VURTN4VXV5THJNaG01WjBjNDVWS3c4S29FMFNRUmU5cFA5aU9r?=
 =?utf-8?B?bDVJVGhVTlNITm8rY01DdFB6RzBoQ0xPU0N4MmhPSFZpaXZtNUFvdHhXYm1j?=
 =?utf-8?B?dVVtUEE0RStvY3hqclJTRkNUM2FzNE5Edm5mMnhJajZNall3QWE4enloN2NW?=
 =?utf-8?B?b0Z3c1dJa3RwaGFFOFg5UnRGcEdNSjBSZUpveWMvcmZOZThnRktVSW02NnEv?=
 =?utf-8?B?eU1QNzNjcGl0dGdhODhFcUUxQTRGdCttekFWRFFVa050bTQyR3JBSFVsck5I?=
 =?utf-8?B?T0RZV09QZUNQcE1IUU9nbjBjVi9WeFNqZS83YjQyUXdDd1NLZHhrODJqVmll?=
 =?utf-8?B?VVhOdk4xRjZScG10TndmS1VRTWYvVm45L2hLaG1Nd09jYjBuTkNuMXpYelpz?=
 =?utf-8?B?WG5EUWE2RG1LWndndFJsUWlqamNyV1hNSHNrQkhtdHFvejZXSXI1U2VKNHlq?=
 =?utf-8?B?VTA5YXcxU1FacEFLU1Rma2RHSDVNQ0VVd05KcTFqSFBqa2hMUVA1RHBEcEhk?=
 =?utf-8?B?cHVHTzcxTTc4ckYrNmRMYTFGb0FreVNXVHFtYmhkYm9RUGhmcStoTXlycE5u?=
 =?utf-8?B?VS9ZMTQ4NnZJUHI3MXNpTlBwcnVUbnZPRGFKSW4xU20zUSs5bW5BVmRmcDh1?=
 =?utf-8?B?YzNVZ3BvY3dVVlJPblBGRlF0ZjlBUEFkUFFIQmYxbjNLKzdUTXJ1YkFoSG1t?=
 =?utf-8?B?ejJqanQrS2FHWjc4ZC9TeC9iczF6UHM5VXQ4RGRkQnlxTU10QnlENndIYWtV?=
 =?utf-8?B?UmRxVDF3S09ha3M4c1BVeFd4RmIya04yOS9hVTNsaTduR2FkYjIwSkR2MVdD?=
 =?utf-8?B?SUVKL3oyZ21EOGhmeWFwUllSVHBjSUVwV0EyNW84U2FtSWFRRGNjSGp2ak9B?=
 =?utf-8?B?M004RFJiY245ekczN2hJaEI5K2J2Ylg0bG9KUjZWRDQ5Z2hVTkV2ZmFaSWVh?=
 =?utf-8?B?Y2lvYWZ1ZlAzQlN0SGgxM1poY3V0R2txQ2VBLy9BeE1sYVVuZW5WU21EUGls?=
 =?utf-8?B?andpc1RtMy9vQmxXalptNVFDNndNNkpnNzREamdYT0xxbngybG1VMXF3dG9S?=
 =?utf-8?B?Z2pyekJ5Z3k4QzdXR0Y5OVNLbU8rV2QzcXpvLzlNTHdEc0VtdXFsZnY5TFJq?=
 =?utf-8?B?Y280U2trOTJpM3dObFRtTk51ekxmei94S0pjTitjVHhITlE0aFZJN2lkMmpS?=
 =?utf-8?B?TGlWOUdTbHg4aU51YUt2UXJoWEZUYWRCQStLVkdxRHpoak96YkNTSHVGWE1I?=
 =?utf-8?B?eDl2cEd0bzlGRlYzTjI2c1gxNENGNGkzN09qdm1kM3h3Z2xwZlV2NFRldHZz?=
 =?utf-8?B?S3RIYjhyWGhkNkNvdlZpRU40Z1lvMjFtVHpxYkZkeE9YWXNqdzc3aVJYc3RK?=
 =?utf-8?B?SGxtVlFTL3ZTdHM5bjBQT3BoUUJMU25FYjJRVmNvbTQvSHpISUd0eW00Undh?=
 =?utf-8?B?cy91aEVoeUsvbmZHWGVlaDNTbERRdTAzaUFSWG5ZaktVWGxZTXZDUVlkSGo0?=
 =?utf-8?B?citrUkRTOWpkRFNQQ3RIaVd6L2Y2R2lCdWN6NEJoNVpVMGQ0ZmNyNG8wbkZ3?=
 =?utf-8?B?RHR5bWxMQUMyblJ5cVllL2RtQy8rQ0Q3a3RsQXloYUFNcVpoZjVYSy9jQTIz?=
 =?utf-8?B?eVgwVEwwYnpvbGNMWmthbksxSHdadS9zM0tWOE1QNCttUGl5Vjh5aUNIMjdH?=
 =?utf-8?B?TkFvdmRHaEJ5bXZuVG1SSnNCZ1BOa21FSUc0am1oYnhld2czQXJEeWpQaUxE?=
 =?utf-8?B?eDRETFptTlQzTjBWRlJNRXE5cDVDRjhjYkllbzM5QnduaWhEV1VicWtyMFJi?=
 =?utf-8?B?SGxwMkwzZ21Ib0ZuYzdtMVQxa1VzdEJ5Ukg3NEZOV29JSGhjcXZFMk16MUtk?=
 =?utf-8?B?ME5sb1NRMmp3OFBkeWFVSUVQNXQ5Vk11UGUzZTVLQ2NEMlBqUnJrZGJBS2Rk?=
 =?utf-8?Q?u6ZG0+ut/ePIwC7Dpg6ZFqXyD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD9B9DBE1BA3F14DA34E7D54620EAC85@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997a3b78-13c0-45e2-a5a9-08dc8087911e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 09:04:52.3243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNZYrzD1MOdtgqA5HlZBUQe0kObKvH7upRP2xVjqrpFmdN3wQjFv4ff8cxfSS9DCo5ACSGgTfDOdjq/V+NEmZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253

T24gV2VkLCAyMDI0LTA1LTI5IGF0IDExOjM4IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gU3VuLCAxMiBNYXkgMjAyNCAyMTo1NDozOCAtMDQwMCBXaWxsZW0gZGUgQnJ1aWpuIHdy
b3RlOg0KPiA+ID4gKwkvKiBUQkQ6IHJlcG9ydCBlcnJvcnMgYXMgU1cgY291bnRlcnMgdG8gZXRo
dG9vbCwgYW55IGZ1cnRoZXIgaGFuZGxpbmcgPyAqLw0KPiA+ID4gKwlzd2l0Y2ggKE1MWDVfTklT
UF9NRVRBREFUQV9TWU5EUk9NKG5pc3BfbWV0YV9kYXRhKSkgew0KPiA+ID4gKwljYXNlIE1MWDVF
X05JU1BfT0ZGTE9BRF9SWF9TWU5EUk9NRV9ERUNSWVBURUQ6DQo+ID4gPiArCQlpZiAocHNwX3Jj
dihza2IpKQ0KPiA+ID4gKwkJCW5ldGRldl93YXJuX29uY2UobmV0ZGV2LCAiUFNQIGhhbmRsaW5n
IGZhaWxlZCIpOw0KPiA+ID4gKwkJc2tiLT5kZWNyeXB0ZWQgPSAxOyAgDQo+ID4gDQo+ID4gRG8g
bm90IHNldCBza2ItPmRlY3J5cHRlZCBpZiBwc3BfcmN2IGZhaWxlZD8gQnV0IGRyb3AgdGhlIHBh
Y2tldCBhbmQNCj4gPiBhY2NvdW50IHRoZSBkcm9wLCBsaWtlbHkuDQo+IA0KPiBuVmlkaWEgZm9s
a3MgZG9lcyB0aGlzIHNlZW0gcmVhc29uYWJsZT8NCg0KVGhpcyBzZWVtcyByZWFzb25hYmxlLiBJ
dCdzIGFsc28gd2hhdCB0aGUgY29tbWVudCBhYm92ZSB0aGUgc3dpdGNoDQpzdWdnZXN0cyBzaG91
bGQgYmUgZG9uZS4NCnBzcF9yY3YgdW5yZWZzIHRoZSBza2Igb24gZXJyb3JzIChkb2Vzbid0IGV2
ZW4gcmV0dXJuIGVycm9yIGluIGFsbA0KY2FzZXMpIGFuZCBJIHRoaW5rIGl0J3Mgbm8gbG9uZ2Vy
IHNhZmUgdG8gdG91Y2ggaXQsIHVubGVzcyB0aGVyZSdzDQphbm90aGVyIHJlZiBoZWxkIHNvbWV3
aGVyZS4NCg0KSSd2ZSB0cmllZCBpbXBsZW1lbnRpbmcgdGhpcyB0d2VhayBpbiB0aGUgc2hhcmVk
IHJlcG8gd2UgaGF2ZSwgYnV0IGl0DQpzZWVtcyBpdCBkb2Vzbid0IGhhdmUgdGhlIHZlcnNpb25z
IG9mIHRoaXMgcGF0Y2ggdGhhdCB5b3Ugc2VudC4NCg0KQ29zbWluLg0KDQo=

