Return-Path: <netdev+bounces-162895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E2A2850D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 08:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709457A30BE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 07:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42742135B9;
	Wed,  5 Feb 2025 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zz19l46O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57648204C2D
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738741552; cv=fail; b=c5PozhuW98LUVFRMS2PuOaOoQuA0rAy2iGGUZvvSMztVq99fNjTY34WD0kwP62jaNHkYKvGIOG0G9o1PdpRBJ4K/Kqt/SAHzRhyFSUOkQdfwknQThb1Ik2xzJX2jEgOK7hoyJW1fLEpoP3AxIam8+g+f5Hjj81BdsknJnFHRMsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738741552; c=relaxed/simple;
	bh=Y1362h/F8Aq3ozKIegg815Y7Aw0qQ0hlSPrinr5kRjM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l7fHq5rTsvBkNP6knYwum5aIM0NW6KBpVAgVmtyj0iTSY8gMTHiZKHbABQ3r6Egfp2CXYLES1c+MerIWDHOlklUoKPjQxymbFQyTlOYZ6PwHTg14OXPuRG8ijSZR5zaDbHLp8sk/2budCJ7zBrxcckiInavVlgkNrAUEsEOD3rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zz19l46O; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qipOq+Md2NnvQy9mY8Hvzz9+Pln9Q9kTmPu/AwsYTfVPCYzHMQkYajM+zwG/lF2DQXzgsIhVkWk/BcKiwRAXPFnVVsqgJadzXlAsDDjMD0mIQ8ZjatHmfzloXgcc9igFC9s9H8Uf/8E3XALoGnortx38HukFAxozJwR0qIzGgjuKGfpymzydr/fkx8dCz38Os8kcL8E4EA9nOMl9KC4y3cCBACkl+lP26nVoG8sCZJN49Sc9yc4gigry2orfzPAHFO31yY5J0xK43Onek+0FqgHIqzdamgw7xJeVNNhh65o8Q+Fd/ocHzXorT+UwSP7jsFHNBQNgEf2rpGFaP3icyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1362h/F8Aq3ozKIegg815Y7Aw0qQ0hlSPrinr5kRjM=;
 b=IXi0VIR7GetH0E2iGUE6dEdcXgbC7yZDK6MPiwFdHEIyw18ehM9r6KGb8Eowa3Fozjy7Dg7GtoFaxfBZm/zfnfIgGhHc4gHaE0OQ0EQRv5hakcFzD3h0wXsNsbOX4WsVE75uiCE83kRK3waP/tvI6iVFQLzIc8sJzcJlKnHGExTRSKewORnA3ANh5OBg4KFDcvSbmvIe8Ynns45sv/fYGMRa/sYsbHWhNXUnH8XgVFqBm/bEvJItxmz19HgPNIjDhKfXhT7wpgIZ5GOqmnQjU6DvEqC+DFsS/WtzHUHxjAGhigj3TcpsMmJOS92+mzUDi5fNJOhFNEt7lZfAO4meog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1362h/F8Aq3ozKIegg815Y7Aw0qQ0hlSPrinr5kRjM=;
 b=Zz19l46OhzokPXxunz5LiguqcFiC2/Dce0gY2Av/yfaPqRDRYFY3QrNp3NyHWFUZiFZ/mJ8u+DKYrURvCgOdlSfyE8FrxA6ISbUCHH90ly5vnCGtOsG/K90AewKy3q+Qtxh8LkZOTtkhGgrQf1UYi5xWUx3+B6ieCXRR5/0wdyyIVIVr1IBjV5Y3J+1lxGxOgmb8OOmIFRjdVM9nujLx0moi3jg3HZjcI1LcadIonwiMplOQrxtvbuwr8FjAcxwCHkI0Djy2QOVYhSb7i4z0m0RGpgmq133+LogrWs/Ft7llvrGu84yEZaPuouBKg+3TM1kd//mf5rfjmxIjON6lvg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by PH0PR12MB7905.namprd12.prod.outlook.com (2603:10b6:510:28b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:45:45 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%3]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 07:45:45 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
	<amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Topic: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Thread-Index: AQHbdwpytanztMFZ5kSa6adxP+Q0lLM3/t6AgABWxXA=
Date: Wed, 5 Feb 2025 07:45:45 +0000
Message-ID:
 <DM6PR12MB4516A1AD2B1953FF7D48839AD8F72@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250204133957.1140677-1-danieller@nvidia.com>
	<20250204133957.1140677-11-danieller@nvidia.com>
 <20250204183427.1b261882@kernel.org>
In-Reply-To: <20250204183427.1b261882@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|PH0PR12MB7905:EE_
x-ms-office365-filtering-correlation-id: 930051f5-6101-456f-dc57-08dd45b91958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFhDWUlMWlhyRWhmOXBpdG9zbUdYRjVaM3VzS2EreFJyT1hLeFBIRHY1VmFN?=
 =?utf-8?B?bjF1RTB5MGs4cURFRE5pQUFaaXZ0YWdMb1JDY3BqSU5VOFZwM29QL2xmSkIz?=
 =?utf-8?B?RHBwQmNiQVYyWnVBb2JJNE4yd1MwTFhVbkZBOUtLUTd2Y25JVG5vTkRHVXJa?=
 =?utf-8?B?OHIydFRHSmVGYXUvUml1RlV6RWFDVWU4SE9EcW1wNklGdnpQRktPd1BXMDNO?=
 =?utf-8?B?Sk8raTcxejdXSld1U1hYUFJYYXNVS1QydTdwNFg1ZDV5dVJ3QjYrT2xSRHZU?=
 =?utf-8?B?TDhCSXkyRjVUZzF0TFdONlFqc0NZME5jQlA0R3N0MHFnZkFTU0VlY251NmZV?=
 =?utf-8?B?eWdmbVpqbUNveEg5R3VSUUdhYUdDbWR1QkVLdUxNeldPdm5zaW9hemdUYmda?=
 =?utf-8?B?dnFpaGNvbyt4b0hFU1ptanlrZTlqNTRuNkpGUUloSFlyWVhTMEZDL094YTZ6?=
 =?utf-8?B?OVl1bU5uNkN6V1dlbmNENzNtWU1jOVlDYmk2RUdpNXVGemlXS1AvekF0bTha?=
 =?utf-8?B?dW9zWVVFeThBZEh3T2dOWGxOcUlTOFZtMFJkcTdsVW1heDRsKythUjB1UHl1?=
 =?utf-8?B?L1Fmd1UwbHF3N3dxSjVOREkxNEFZb2pQWnZ4b1ZVLytZdkFKUVF0eWRKcWJC?=
 =?utf-8?B?cUpybVRZM0VWUVU2RTVnTitjU0R6UGZOZk5sK3Fuc3R1cGoyR3ZtL01CaWIv?=
 =?utf-8?B?VzZ6aXhqUlZ1Mko4RVQvTzhHTUhrNUtTVWd6UmtrdWJESTVpd2ZVd05yOGZO?=
 =?utf-8?B?dWlQbWl5My82V080VEhvbWxSOEs4ajAvOVB3eVBBVG9OK3hiaDc3MnBoSjFq?=
 =?utf-8?B?Ri9VczFrc1pVSFZXRG9SSzFuYXpzM0ZiMm13ZHJVMUVwWm1PT3BHdWd2VGwr?=
 =?utf-8?B?UFVvanJJUFpqUjZVN2VkNURuUGViTnFlM3dQcmQ3R3FGZFBjRG1YSzBsYTJC?=
 =?utf-8?B?MCtEdWhYMS8yajFNc3Z1bzZVc0pCK0YzbVBRc2piL3VtTElyQk51Vm1jaHQw?=
 =?utf-8?B?amNqYTdodm8xWWh4K1ROa29KMVBMOThiVXV1ZjdqYWVKeG5ZZlAzelVFUWZk?=
 =?utf-8?B?ekl5OWQzSWQ3aFp4dE42Y0R2ZkhYLzBHbUV3YmRDZlRkQTMyVW1pdGFHbGRt?=
 =?utf-8?B?WkVzUGE4MEVtNUlPRkhoOUxOQTFkQWI5NjR2ZzV1aFBkSkdLTTBwaU13MzFL?=
 =?utf-8?B?NzZJYlQ5Z1hxaEcwSnBNaUpmWGNpcDgxRHR5T055Z0Urd2VaUXBscVMxNEE0?=
 =?utf-8?B?SDRnRVpnaDBWYXNncmoxWUZEL3FUM1BNTkNFUGoxRlNkZnpQQ3pqeWlqU3h1?=
 =?utf-8?B?a3RmR2dNS3VaSmREWURjajVIRG5mMEZzeTJndStVS1lyOFNDTjgwQllncTB4?=
 =?utf-8?B?dVMwY0I0OWtWYThyRGdnNTV6NnA5MUhQY0huMklseFFzRm5nYVp0ZnFpZXJh?=
 =?utf-8?B?YWNwei9qUEllb0x5SkZ3RFpta3ZMSXllSnk5TU5BZGVVbmZaNk91V3puejk3?=
 =?utf-8?B?a0c3UWRybCtZaVZ4T1VMQUg2b29jUEZXS1hDWGJBLzJXMUdHaW1USFZ1R0J3?=
 =?utf-8?B?dThvSElqemQ0RHp0cjQ5VFlJM2srYTR2MjJaZDh0Uk42bW1udFR3eHdZVTYw?=
 =?utf-8?B?TFh3cWFuWFJEcmdvdTdtS3FHMGJrQ3NYaENUazNJTzNHa3I0T2U2S2RtdURl?=
 =?utf-8?B?bFVmTmEzMjNnRzNNWVdOTlVQSzBjSG1LTkRYK050UG02bU1xVVZYVDhSZ3pM?=
 =?utf-8?B?aFpsUVJ0MjZzYjdTbWQxQTlRTEFaZXh6Ny9QdXM2YmIzcmtnOTF3ZVg2OWpu?=
 =?utf-8?B?Y3dSVkdPQWlySjNvZHFBWmx5Uzc4WHhZTjFkWWU5WnJrc3N0R2hBZ0ZvNTBN?=
 =?utf-8?B?cjdEOEdZMWVCN2d2WWpMdElQTkQzZUR1WXFUeXgySzlyT2luK04zUzMwWUU3?=
 =?utf-8?Q?oNhZfIf13Exp+1ZePTqbGfM5E4IN4+ZN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjZYWHFZd21BWGdNRkd1cFlNZWVBUnNMZlRNZm12akF3Q3E0ZFpTcHBYcmIz?=
 =?utf-8?B?d1JESkRlOStGMEpvZkhvbDAvcFRjWTRzZktYUUJ1UE5xSVNucTFxcmExNVN5?=
 =?utf-8?B?WUIzcGZ3NktJUWZJNGgrWERCUmIvYk00bE1PbG8wclBzV21MZGlzdWx4dERm?=
 =?utf-8?B?Z21DMkhHdzlsK3QzOGRhSGdtMUI3eG1JbUJpTkVpeGdxSVA2MVB1K2FFeFRX?=
 =?utf-8?B?N3FsSXhwTTVGSERaWEFYOWtsN1IrWGtEVXFKNnNmenBOTTNReTR3KzUrVUky?=
 =?utf-8?B?YzFNUTh0RFM3VFg5aWJ0OC9WMHJYNEl1U09MVmhDVkpXN2UwRlFZN3F5TENv?=
 =?utf-8?B?azVIZW5jNVMwV1VnY2RPTlRSek90RXZ2RDk0Um10KzNaUWVYVlRDQWI5TWhy?=
 =?utf-8?B?SlFneitnYzA4Q2JFSURFN01MQjQvQ2V4bDNvRTRsRVplVmFMeThiRlBRN0Zn?=
 =?utf-8?B?R21STXBabk80K2Z5M1Y2V3NFU3FIRUpaOUlsUHRnakRIZEh2bW1oWGxOQWUy?=
 =?utf-8?B?aTErRDdkTXlkQVc1ZUNFcTh2RTdYdkgwWVRQUXZsYTBIVTJ4ckFmQkxTSGdB?=
 =?utf-8?B?dVRLTEpnRXZMMXZZYnI5cVZzenM5dFdpNStsYk53WEdaWGJ1VFZncUpWampU?=
 =?utf-8?B?MzJkcGhZa1dEUXJsVm81cm5RU0IrWGxNSG5UMFBiNEtCd1BnRU1seUxHTjBw?=
 =?utf-8?B?VnNpaXJTL1BxZDNCeHVNQkJwVEJkSDgyenAyaVQrSFRVS2tvYnJNc0E0Z0tv?=
 =?utf-8?B?VytBaVR4a1lJVXVRSUJpSURSMWNkVFFSbWhGRDdHOVROQ1lBS214bmIzaEtK?=
 =?utf-8?B?MHVqSmJaa2ZQYUdlR0ZsZXhPeUVPVzU3OVkrR3FidG1RblVDcHlJenduMUQ0?=
 =?utf-8?B?YUI5K2pGR1dYNUFzTW1FckRKL0tIQ1hlTmJkdC8zOUYzVVpvVlVrbkhHRFk4?=
 =?utf-8?B?MzlrcFJoMzY4VENVa2tQZU5XdC9kbWF0cHl1RFhSMC8zcFEyNXJIT1pxaG0y?=
 =?utf-8?B?U1pyVmNtVXZBUStIT2xHVEdPVFQ3YmRpL0tiTmkxVFNndDJIYURZak8rdDRH?=
 =?utf-8?B?RS8xTlR4eDBtM2J2VERQNEJuclpKWE5wa1Y1Q1NzUzVuNjVoemtXSVdrTFZv?=
 =?utf-8?B?aXFXMldQNWZzYml4QnNLTnk1T1o2cDFkcVFaMDFFUEk1WmNmMzJhOC9xQlVG?=
 =?utf-8?B?ZTgxUjE3bWVHQ1U4Z2NqMXY1d3EyWU41SDVFU0lxbTNuUW9IUnNrWGdhUm1E?=
 =?utf-8?B?UnFwaE5tcUJVREt1UjdSaERtdFRRRzBsMzhDVm9GV29JQ3IvMEtQNGtMREVs?=
 =?utf-8?B?dXE2ZGRJSllHVFBtZ3RuR1FMQjB4TE90U3ZJWmZNQmZNeGthamU0eXhVQW9C?=
 =?utf-8?B?d1BxZjdlTUJPczlwQm5jK3RhcHZ2cEs1OFl4dXE2cXRDY2NONHp0SmxqNlRl?=
 =?utf-8?B?czIwN1BkeUVWUkU0Mkl1U2xIODN6UmlDOVlLOFBXYUpadWZ1cTRqejhjSldU?=
 =?utf-8?B?blZtRDRIRkpxNU14VlhCaWFkRThwVW5UbXliTmI0WUtkUWYvWmIwYnJINjZH?=
 =?utf-8?B?Q0VxM3NsamczN3J3ejdjUEx1K2M1ekJtRUNqbldSbW5kZjkzRjBtWWQ1QkJh?=
 =?utf-8?B?ZXF2bCt2VTBwOGdHamcxaHN2cG1qdTAwRjZDRjhSeGhBM2tNUW5mL09RcHlJ?=
 =?utf-8?B?a242UzdWbkdySnBxbDV3eTV6N3ZCNUJPQ3J5TUNZRGpkSmhMaFNJUGZGUDQ1?=
 =?utf-8?B?U2Z0TXl1anFHVkFRWmNCYUVzTXF5MFJhc1BqZGlHTEtmc3Q1dGllRmFrV2RK?=
 =?utf-8?B?VkM1M2JYQkVGS2IyZlJqMWxTa21HUEc0UzhCeDVwWWdTcmgrVU01c1ZrSXkv?=
 =?utf-8?B?TFJoVStjVDh5ZmR1ZkQrWnZTeHJOeFdqVHBpNFordFJrNm5jNldMd2xyd0I2?=
 =?utf-8?B?R21BYm9xSVNYQmFoSGxPZ2ZMTFhoQTRwZldSRENPeVpMWUhIcDhiMFlPTHpF?=
 =?utf-8?B?bXh6eThRR3VxcXNKWEd3bEV6allPdG5LdW1uTXMvcnZZTnJvYlllU1N0RUtz?=
 =?utf-8?B?QnM4eFNhTzhrY2FJZlhCRE4zWURlRG9kblN3NFlpN0pzcVJ1M3VEeW1TZE01?=
 =?utf-8?Q?yMX0RJKNDDPVJCUH06N8UaNQ1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930051f5-6101-456f-dc57-08dd45b91958
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 07:45:45.2860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qQSyZ2965NitYa82YklUtm9qKCvu29IGPRE8IAqyAKBTRwyfN/EQy9BsyfC1WgzTpp/IebsEzH/NZxd75NP7ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905

PiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNk
YXksIDUgRmVicnVhcnkgMjAyNSA0OjM0DQo+IFRvOiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxl
ckBudmlkaWEuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbWt1YmVjZWtAc3Vz
ZS5jejsgbWF0dEB0cmF2ZXJzZS5jb20uYXU7DQo+IGRhbmllbC56YWhrYUBnbWFpbC5jb207IEFt
aXQgQ29oZW4gPGFtY29oZW5AbnZpZGlhLmNvbT47IE5CVS1tbHhzdw0KPiA8bmJ1LW1seHN3QGV4
Y2hhbmdlLm52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggZXRodG9vbC1uZXh0IHYz
IDEwLzE2XSBxc2ZwOiBBZGQgSlNPTiBvdXRwdXQgaGFuZGxpbmcNCj4gdG8gLS1tb2R1bGUtaW5m
byBpbiBTRkY4NjM2IG1vZHVsZXMNCj4gDQo+IE9uIFR1ZSwgNCBGZWIgMjAyNSAxNTozOTo1MSAr
MDIwMCBEYW5pZWxsZSBSYXRzb24gd3JvdGU6DQo+ID4gKyNkZWZpbmUgWUVTTk8oeCkgKCgoeCkg
IT0gMCkgPyAiWWVzIiA6ICJObyIpICNkZWZpbmUgT05PRkYoeCkgKCgoeCkNCj4gPiArIT0gMCkg
PyAiT24iIDogIk9mZiIpDQo+IA0KPiBBcmUgdGhlc2UgbmVlZGVkID8gSXQgYXBwZWFycyB3ZSBo
YXZlIHRoZW0gZGVmaW5lZCB0d2ljZSBhZnRlciB0aGlzDQo+IHNlcmllczoNCj4gDQo+ICQgZ2l0
IGdyZXAgJ2RlZmluZSBZRVMnDQo+IGNtaXMuaDojZGVmaW5lIFlFU05PKHgpICgoKHgpICE9IDAp
ID8gIlllcyIgOiAiTm8iKSBtb2R1bGUtY29tbW9uLmg6I2RlZmluZQ0KPiBZRVNOTyh4KSAoKCh4
KSAhPSAwKSA/ICJZZXMiIDogIk5vIikNCg0KTm8gSSBndWVzcyBpdCBpcyBhIGxlZnRvdmVyLCB3
aWxsIHJlbW92ZSwgdGhhbmtzIQ0K

