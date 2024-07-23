Return-Path: <netdev+bounces-112519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7475E939BEE
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 09:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66D71F22101
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 07:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2814AD3E;
	Tue, 23 Jul 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YS80zzbx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F536130;
	Tue, 23 Jul 2024 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721720992; cv=fail; b=Ww3GBad9mXzwYnX47otTSNvfgued0nwbaCIIvFbYuP7y6Z8PUl4Tn1R7PdHdf4q0lBTzPbdq9LlfNQy8qWNQJwfoX9XSEENkEyOzXy9EVh+cUP2HN4+9V4xCfEHd9XaPxJxGsDtg2J/ZWQzqCPEBt3IqcSWWQFX3lsGwhEAKgrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721720992; c=relaxed/simple;
	bh=WNFgekNCgm4UEWBipfRc0BqU7ZqmM7onRZx5NW+ra0g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sjAWkFeF97Pp3qxEdyFcsEVtzL0+ewg4y2zz+UO8Xm1wDLecNxb9n5xQW9kg1G6RBne8IrxHoluMwaK9d0XDk0dkyKSBskKysrsXbLr90wcr2uPhvmXY4V7a0dn0Fbpl9doNwoggPm/0uniL6QdHMUgRp9lQdXRcEKg3Ldq5YmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YS80zzbx; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wyh2BiyCSOcY6KGD7jFXLeqhEjsf5RvmXwt4tY6GjX2lNwsKUug4tsBG0DHo1j+0eZY2ALIeMMMqDs50OurCUlZMHHwRg0+j0CbyWqLEp+u0wEwYXTozkLR6b8F6ksTLTqVM9iXtr4rxAWp6/40j/Z3VXVGOUci9oiQwuFgplStuSRIceyrNiio4EmE17NxPjBrHnf0R5kMNQ3IxQQXOeRb9XmfU9ZjR32n1XUMeDe3lYjCcdYo1BL7oPy8TOgL1JJtBFtWW9mzymnhPcsmqNxztzatLFTPKacfExQIgdpfNP7myi8a9uk9QLDROodOfaMfWbsga2XFUOy9Lt+XJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNFgekNCgm4UEWBipfRc0BqU7ZqmM7onRZx5NW+ra0g=;
 b=ojmXczOPSqzAGY5XFEiQSs7e7ZuiNvC3XH391k9fRQ9KpfSMGtGQr57lTZl1EdNa0/zf6eehLjmsbrcl22BUpqRA/Tzd9VNA1OOrAO1Zz3D0a+vZDgOL0mdEemAyJmiARcX8wGOJ+LN/j3kTFhFf4uxu8awRw6bVPMpAxoqC34raA2UiKgEzhfygn5nIkr/u7iXsfN6Sa80rOp216SzMSgCVOgEFVtN9Cby02SVdWL/gvc10DOL1Y+T7hGRuWhZdMJD4wucGVATfTvuuwWl3s6aWEK30aAYASFpKIBno154G/5GTVFCGpkVo19UcaiRHGad8obr+MDFuNGiKFILg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNFgekNCgm4UEWBipfRc0BqU7ZqmM7onRZx5NW+ra0g=;
 b=YS80zzbxqqe5oeasHDESoqq5ASLytuZOZXHL8Z+jFvNwrsItEhjFUfqiSGDZir9+H3n6jZ2W+OWxun6yGrhwZHnjWtPbBPtzEBTsb3ehYkoLJ1MVm1QWueWVlR2FiHxpybzIMzk2C6tf3+qyTAxvm88BotEPTD1y/q69yHexi1Lbvk3berJpdS2dgSKkUMl5ZQQ9ixH5mT569PuK/xq4jWOLl7S7DiXSGvLSTPhx39RkjFwokWvvrMib/aqyfMLqn5D5mkHG9IymB4CLs4YUYVIqhCnSLIT9dod2D8OqCgaTbdE/tkmWsoP0CHorF11kWR89D8lqahXkfmK3yZ157g==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 07:49:44 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%3]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 07:49:44 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lulu@redhat.com" <lulu@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATH v5 3/3] vdpa/mlx5: Add the support of set mac address
Thread-Topic: [PATH v5 3/3] vdpa/mlx5: Add the support of set mac address
Thread-Index: AQHa3MLxYDFDU1uqukChj1IJMYy3M7ID8DyA
Date: Tue, 23 Jul 2024 07:49:44 +0000
Message-ID: <d8031e518cf47c57c31b903cb9613692bbff7d0d.camel@nvidia.com>
References: <20240723054047.1059994-1-lulu@redhat.com>
	 <20240723054047.1059994-4-lulu@redhat.com>
In-Reply-To: <20240723054047.1059994-4-lulu@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|CH3PR12MB8972:EE_
x-ms-office365-filtering-correlation-id: fb2e2428-4cc7-4875-93ab-08dcaaec0463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkgwVzVyNWpSeGcxNkR2cEdaclNBSXFYMVFnLzE4V2puK09tU21wbkZuYlBD?=
 =?utf-8?B?QnBLOGVrNEQvRWpEcm9iQTVQYnVDcG15VlJLN2NGdmRmbzJPU1FTbW1GMk14?=
 =?utf-8?B?Yjh3MmxBc3crUCszWnlhQUlHbEZhS0F0TTFBWEZpQmFZWXdqK0MvU3lkNTRy?=
 =?utf-8?B?WFB5VUFmTit3eEpTV2FHeUNUL1ZjZ2NVcnAwQ01Zb0tWVy9tVjRiOEJFcUtH?=
 =?utf-8?B?OTJGdTkzdHN4Wkx1bXUvVm9rZGVOYzhmSE9HNkpRd21HL1hMWmtPcFdZNlJR?=
 =?utf-8?B?SXRQTUZiblRpNSs1WE9UKzdTelFCejJaQ2IwQyt1cmNmaUpxcVpaSDZWK2xR?=
 =?utf-8?B?Y1Nyc3pVTnZUUk0yeHFyOXRJZ1lpZTF3WnhCaGxLV1hTczU2ZktjNFEvdWpF?=
 =?utf-8?B?N1JRVDVqY25vbm84MFYvQ2wrU3JQeDJxVXdKeHc3YjhBWU5MYkZJbmkvWHB1?=
 =?utf-8?B?R2t2RlZWS1NsdEVTNzA2YWlzK2o4T3hBaG5sR204TE9BaVhSaWNSTTVScVFZ?=
 =?utf-8?B?MHZGOGNYaDc1MnZOcVZKUG1ibXdGSytXNHJwMmx3Y2t6UVRvallYZjN3dnlo?=
 =?utf-8?B?alNqZ25SOXNsMndPWnNEOUxLcVlyOEx5dmhnRk5iR2NWcUhLUUVxQlBFZjZN?=
 =?utf-8?B?OTd3ZkFabWVPc0Z6dkZXcUt4SDF1T1J6TFA4WStnZnBRRnlXakdrbytGTGt1?=
 =?utf-8?B?amRQMGFmY2F6ZEt6dm1QeHl6Vno3N2E0MkxJUklwQ0hMVEl4RHRqc2d1YTJj?=
 =?utf-8?B?TmxoQTBnNndpZUExckhCaXVvWlB1QlQvcWRXaEJiVUZSRHAwSlJpa2Jxd1pi?=
 =?utf-8?B?QU54THhORWNjaWp4VW5BWkNtYzRmYjhzSGh6NGd1YklRQjhUWjNSN0hzYWt6?=
 =?utf-8?B?bzRDOG5ZZWE3MzFIZElzZi9jMVNIUUdWTGFrVlU5R3BFTlNMMlgrNjNvL1Ns?=
 =?utf-8?B?Z25UWjVTUmhFYzdWTUE3c1RwcjhndHRqZzJlc1pGUmtpNytrd2NPWHBaSmtr?=
 =?utf-8?B?a0ZVWHU1MVAxQ0dwZVkzQ0YvOVJoUjhXb0Y5RjIxSzRpKzNkM1NsQWVKcDV1?=
 =?utf-8?B?UFVyU0Y5Q2ZkZUtwa0NPakRSRkNFNWZYK0RsZUdNUFBxYVkxbFFjWkNpd2Zo?=
 =?utf-8?B?L2xoQ2xlTVR0cDJtUlBNOGMzUU94WWZGaTAxNU92akxCRUFDOVVPL3c0UUZ1?=
 =?utf-8?B?ZkRBMWo0SndEOFFuS2J2ZVJuYkZnRTlndFNOMU9LSUh0SEt0YStyL041bVBt?=
 =?utf-8?B?RE11OUVFV0twVERkN2ExbENxVDFJT0sydGdPM3F3RzlCNG5NdG5scFRWL2V4?=
 =?utf-8?B?ODVZYXZoUWkyZENwc292Q05EUFNMLytma3l3dkJwRmt2UmFkWGdYY3dpZnhS?=
 =?utf-8?B?VEFCSnNDMHRnK1dSVk0rTkMxR1dyUlFZNzZIK2Z4MVlvWDhZVVUrd3JzeHgz?=
 =?utf-8?B?SkFIQWJiVDA3czVTS3Urbm5IQVhKbEFHUjhJdUtOUGJ1VTgxMGxKdnZhaERt?=
 =?utf-8?B?bmdvTDNDRDVyMHlWVGZwVVA0d3RwSjhreEtMOGZzSG9LK1BPV0xSbFJDN2U0?=
 =?utf-8?B?RW1IaFFTOFNVSDhrL1RJbEZLSXBrdkRnNUI0M0JKaFlBeTVXTldOZ3BEcXVV?=
 =?utf-8?B?R0FmYXJISGMyZ21EcGNiZWkvK2l0MjErZVg4bG51aUU4RmcveWZ0TXEvMklG?=
 =?utf-8?B?L3lLemhHcTJlMjdtV2JTbjFuRUFpUmJOVlVTMGI3aG41QkxhWllrNS80dFJr?=
 =?utf-8?B?UFlLZ05LL1p1UWhLVmhFcGpKTGZEVTFuWXhVcHN3U3FRb3NOYkgyZkt1VkFa?=
 =?utf-8?B?bFBMQzFlYUU0dzBUaXR5bHlhNXArTEFGRnNvQ0laYWNqb0hPWU9BODRxN2pC?=
 =?utf-8?B?bVNpWjduRTFuWkNYWTBhbEZoaWg2cTFhUHFyV1dTaWpUR3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0ZnUC80ai8rM25mUWdtb0k3dkQ1blVzQmhJTUJ3VG8vNG53MW1uQk9tdDRN?=
 =?utf-8?B?Skh2RXlzMHJiQzNiek5GRlQwRm03SndGMlB0Q0g0ODYySmxNbzY5bDJ0V0Rz?=
 =?utf-8?B?b2xHaW92QklNVVJHbnlET2RKK3BmdWNjbktEU0JCVHhKYWp5TFRsWmdPQ3hG?=
 =?utf-8?B?MnlsWlZCcmVaMnZhL2YwMnlzU0p1R2JZa2Fta3E3NWpiQTRFVlVLSlJ6eVg2?=
 =?utf-8?B?Z1NGdE1jREptYjVPUytGWStyVE9JdmdtamlBTCtuNzAxdmw2ekN4c0tsY3Vl?=
 =?utf-8?B?QjlRT0JGTlNSR3g0ck1zUGZaWkpLNDhLZytRbzFaNHJmek11VFZGbXpzV01o?=
 =?utf-8?B?SzRiVUR2Z0RBV0hHN1JEelg4aWJma2djS01ESHBYWjh6ZFB0Q05PS3M1dG5P?=
 =?utf-8?B?Ym1GSlhIdUIzcDNndDM4Z2dCVHBVcHdEUW1UM0RoMXVoaEk1ai9kUEx4NWRu?=
 =?utf-8?B?N3NSbVNmRVA5Ri9TNTB1aE5qeEVlYTdTRG9sVkVxdVpUcGN2T1VRVU14RUdJ?=
 =?utf-8?B?R2ZDRW1PeVAzWC8zM2xwNWFKUlBGNW5uMFdrTWY2MkhqNUlIUXc2QTgxbUdY?=
 =?utf-8?B?ZGgwVEJFQXJhcDRKbnc2eEZyQzU3WFVtcGw3Q0Z5L2l2SURkb0xlMVpzQ3hm?=
 =?utf-8?B?elB2Nk8xaVRFaGl3NUp2R0FGbzBtUlVDMzAvQkk0ZW1OaG9XZDZFTDd6eXB1?=
 =?utf-8?B?OHJweU0rWG1DNXE0ZnhGYU8yeVNMLzlWWm1sZUUrT2p4UlByem1rQldNSFlH?=
 =?utf-8?B?a2NjaThPaVR3WVJnK212cklQRTJmM0FnMEFyQ0VITXhsUVEva1RMVlVlWGhw?=
 =?utf-8?B?MTAzMHdDQTg2L1RlYW51K3FqeHB4T1dMaFExSVRrZTduQVFObHk2eFFRNXBM?=
 =?utf-8?B?SWhyUEo2Vmc1alRKZ3pYSnV0UitwTXF3VFA1Z0U2clhaaU9ja0VsQnQzMUc0?=
 =?utf-8?B?OTVIUWpMNVJiOHdUM0NSaDdlY3ZsYXgxWFc0ZWxYQzhqOTZyL2FweTZnTGJP?=
 =?utf-8?B?K2RScGdjZk8wRFEzREJsOGJOcGJ0aHZkTExVb1FVZytlenVBTHBDcXl4bnlv?=
 =?utf-8?B?ckJ6OGhNdHlWNGhBU1FIQ1NZVmFlQi80K0tkc1BQSTRBeW1uZVF2YmdFTi9w?=
 =?utf-8?B?Mnh2NlkrbFU3SUVpYVM5anE1d0JkZ3VUaGMwTTQ2ajdOak53UjdPOGpJRWsw?=
 =?utf-8?B?MWR3VEhTckpLd3pOL2Vvem5kdHFuUlJSNWRnUllrZ1htcG55aW91cEJPNlZO?=
 =?utf-8?B?SkxMaHNyaHh6YWEwd0RndVRaNzQ0b1VGb21uVXY2ZEE1ZW5xYUNreGczWWNq?=
 =?utf-8?B?bVNCRzZjWXlqRXhDNTNIMlRldkxKWjc2SkxuTGI2clE2dkFyN2pJbWppNndh?=
 =?utf-8?B?QjhBQjBoUDIyMExsS1JWUUE0ckRpSjRTK3QramdDZ3VzRGJ0SkRkQXFlR0dv?=
 =?utf-8?B?bjFMTmc0bkFQTWphZFY4WjdoOEhJWGhqbkNHN3FTQ3paSFJvSlUxZnJ6ZXow?=
 =?utf-8?B?eTlCMVUycGZmb3hYNWFtdDhhbkhRTmRGRG9FSE80MGJXbE5jeVoweDhmeUlH?=
 =?utf-8?B?amdSM1phV0J3bWxLVU5kOFAxM3FvT0dvZnpMTEZDZXJSeHY1cGN3cE5mQjg1?=
 =?utf-8?B?ejNLSlBmYnMrZ2krMUVhVmRrTDBuVkhvWWNYaUVUZjZrRjNUNzVqU1dSdmNp?=
 =?utf-8?B?WVdMRGlqMVhiR1NmWEpVQWhGTDEwcFpJSk0rdnNHRUVsZklsM1B6dk5lZE9F?=
 =?utf-8?B?aG5oVTNrNzlTOUVrM2JYOVFhMW1hYU9YT1RKVXNJY3UwWXhBczdWRVZjcE1C?=
 =?utf-8?B?UERuc2I4WmMxSnR5T2U0RHVZNTZwMVhWb2h1bEtsZkdrQmtqbG9JNkt5TUlZ?=
 =?utf-8?B?NVd2S2ZEUFdhaDd0OXl4M3ZabXAvbjdnbWFaY0ttVXJIeEFKSENSRFAyTUI0?=
 =?utf-8?B?cTF1bmpadHhkMXhNY09IVk5rOTNTZWdkSUZWOUt3b3lKeWtIb09LRlVqRW9H?=
 =?utf-8?B?aFZreERDQkI0UVRUS0o5NEhINVUxcnVPamliQm5kNUVPamV3TE1DcDgwcXRw?=
 =?utf-8?B?RG95UkE5SHRacTNTQWxRVE1EMy9vVEZGaUFKQkNNUmEwQkIzZkRYcFNMY1JU?=
 =?utf-8?B?dERFYlp4Tk4wSUxMVVpKV1NCb2ZTbm0xUlg2Z2t3SWxhZzZoam9qUmtDcU5H?=
 =?utf-8?Q?veHiIZeIWj1qy7CTK3fwp1U3wjofW6p6k+sOgUlcUgrY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3ED16BD79EF2949A4B918E6DB464A95@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2e2428-4cc7-4875-93ab-08dcaaec0463
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 07:49:44.2049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptie1WS66UxVg4a1mRAJLwPPnYyvA0iPSF7DkUN9KqsSDKLQ08HvM3q3q6VrPvBQYqmXTtErSH6I9Ka188eXxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972

T24gVHVlLCAyMDI0LTA3LTIzIGF0IDEzOjM5ICswODAwLCBDaW5keSBMdSB3cm90ZToNCj4gQWRk
IHRoZSBmdW5jdGlvbiB0byBzdXBwb3J0IHNldHRpbmcgdGhlIE1BQyBhZGRyZXNzLg0KPiBGb3Ig
dmRwYS9tbHg1LCB0aGUgZnVuY3Rpb24gd2lsbCB1c2UgbWx4NV9tcGZzX2FkZF9tYWMNCj4gdG8g
c2V0IHRoZSBtYWMgYWRkcmVzcw0KPiANCj4gVGVzdGVkIGluIENvbm5lY3RYLTYgRHggZGV2aWNl
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDI4ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jDQo+IGluZGV4IGVjZmMxNjE1MWQ2MS4uN2ZjZTk1
MmQ2NTBmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMN
Cj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jDQo+IEBAIC0zNzg1LDEw
ICszNzg1LDM4IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9kZXZfZGVsKHN0cnVjdCB2ZHBhX21n
bXRfZGV2ICp2X21kZXYsIHN0cnVjdCB2ZHBhX2RldmljZSAqDQo+ICAJZGVzdHJveV93b3JrcXVl
dWUod3EpOw0KPiAgCW1ndGRldi0+bmRldiA9IE5VTEw7DQo+ICB9DQo+ICtzdGF0aWMgaW50IG1s
eDVfdmRwYV9zZXRfYXR0cihzdHJ1Y3QgdmRwYV9tZ210X2RldiAqdl9tZGV2LA0KPiArCQkJICAg
ICAgc3RydWN0IHZkcGFfZGV2aWNlICpkZXYsDQo+ICsJCQkgICAgICBjb25zdCBzdHJ1Y3QgdmRw
YV9kZXZfc2V0X2NvbmZpZyAqYWRkX2NvbmZpZykNCj4gK3sNCj4gKwlzdHJ1Y3QgdmlydGlvX25l
dF9jb25maWcgKmNvbmZpZzsNCj4gKwlzdHJ1Y3QgbWx4NV9jb3JlX2RldiAqcGZtZGV2Ow0KPiAr
CXN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldjsNCj4gKwlzdHJ1Y3QgbWx4NV92ZHBhX25ldCAq
bmRldjsNCj4gKwlzdHJ1Y3QgbWx4NV9jb3JlX2RldiAqbWRldjsNCj4gKwlpbnQgZXJyID0gLUVJ
TlZBTDsNCj4gKw0KPiArCW12ZGV2ID0gdG9fbXZkZXYoZGV2KTsNCj4gKwluZGV2ID0gdG9fbWx4
NV92ZHBhX25kZXYobXZkZXYpOw0KPiArCW1kZXYgPSBtdmRldi0+bWRldjsNCj4gKwljb25maWcg
PSAmbmRldi0+Y29uZmlnOw0KPiArDQo+ICsJZG93bl93cml0ZSgmbmRldi0+cmVzbG9jayk7DQo+
ICsJaWYgKGFkZF9jb25maWctPm1hc2sgJiAoMSA8PCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFD
QUREUikpIHsNCj4gKwkJcGZtZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBjaV9waHlzZm4obWRldi0+
cGRldikpOw0KPiArCQllcnIgPSBtbHg1X21wZnNfYWRkX21hYyhwZm1kZXYsIGNvbmZpZy0+bWFj
KTsNCj4gKwkJaWYgKDAgPT0gZXJyKQ0KaWYgKCFlcnIpIHdvdWxkIGJlIG5pY2VyLiBOb3QgYSBk
ZWFsIGJyZWFrZXIgdGhvdWdoLg0KDQpSZXZpZXdlZC1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1
bGVhQG52aWRpYS5jb20+DQoNCj4gKwkJCW1lbWNweShjb25maWctPm1hYywgYWRkX2NvbmZpZy0+
bmV0Lm1hYywgRVRIX0FMRU4pOw0KPiArCX0NCj4gKw0KPiArCXVwX3dyaXRlKCZuZGV2LT5yZXNs
b2NrKTsNCj4gKwlyZXR1cm4gZXJyOw0KPiArfQ0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IHZkcGFfbWdtdGRldl9vcHMgbWRldl9vcHMgPSB7DQo+ICAJLmRldl9hZGQgPSBtbHg1X3ZkcGFf
ZGV2X2FkZCwNCj4gIAkuZGV2X2RlbCA9IG1seDVfdmRwYV9kZXZfZGVsLA0KPiArCS5kZXZfc2V0
X2F0dHIgPSBtbHg1X3ZkcGFfc2V0X2F0dHIsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgc3RydWN0
IHZpcnRpb19kZXZpY2VfaWQgaWRfdGFibGVbXSA9IHsNCg0K

