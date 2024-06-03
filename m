Return-Path: <netdev+bounces-100214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C698D82AD
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D5C1F24B69
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C412CDB2;
	Mon,  3 Jun 2024 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XGzIu/AW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65112CD96
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418800; cv=fail; b=sr4/2Ku1tTK7bKsdaB4w5CWKy896XMWzGKq/a6r3WcdRYfEShjlgMzumDYvECt8reRsJOjUhqo4cWL8h///YMtWcT7BGeO0ghELBWLivX45qIHimledYZ7yJ0Ndc133KUSKj8SrQD/mqbEKKQs452zebr+8ADgQJRsv2MMwM5vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418800; c=relaxed/simple;
	bh=VJbuYDBxK6SvbU8XcKsn3sMnsHaQ+eta4YCJwjeSzwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nJSWdeBPgt9D7bX9Uu7XgnRaQNA7e2GfSNtlTFEQNbOttIFEU/uufFOfZ0ppJSGRWM3w0h+DlXPL3wNUhwxxcORvBwB9U1/VH8sK3NwZIVaSFN7feDn3i01ffatZx8FfYNfhMC8/dUf+nGPbiRDH6x3hG+GQXtaBGzGeEQAkB1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XGzIu/AW; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyXuyyD4trs5ECvmGdT37NIpVxMXDITOzoQqvifCH8FTB35rpAVJx7hu6E5VtOr6OpQ7eccSXUTTdX0+zAjMixtzJCH6zeKH2+BMahGbG5KlXVKrlmZOz1+lckIQJYhQcrYQczvLZr8lsEHGYFL5tdYBlYF5eDGi24OYrrQKUZ+wRjOEk+rSTp64hXNPGWO64raZkAG0wR1QkzVDhEJPWScJdaizVMF4wpaQu/74enzhNXKMH4GhGhkpadoZf0FwrnOm4S7rP1vfMut//w/RGOJYwJ31hsWVRYPId+iAxfT7UVXgPVPsJHmRmudMriwBCZuyI3avdlby2VkbpDwTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJbuYDBxK6SvbU8XcKsn3sMnsHaQ+eta4YCJwjeSzwc=;
 b=ZcYt02g2FGu7yH3dCh1LfiRUTCog1wXn9dQY83P9/XgIOJvvniybaxy+mjY4Horn21E7W5ES9TrKpFgZsMdJQjrwY1VOPQgfsSL/gl0V+8aWiWmw2rl3ezMVOtYSIVx096AiQMJeQAkFeRwhGynv5zYZuxCPbwueJzb3f2V1IC1X3VEvo//uC7rxh+XwH/DUmes7ClkpubQkaT9Xdd080h/VUcku4hbvZYhOHty0UEJ2FiZwiHHfvDj4U/uAKeHdCAXyexkzklWwJDR5Ca3CSG9GNzsvGb8RBIeMexxpf+F+1l1H3Q/xxBLFYd5mRbzk7HcvRkhHIb57rHWHJztn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJbuYDBxK6SvbU8XcKsn3sMnsHaQ+eta4YCJwjeSzwc=;
 b=XGzIu/AW0R1V7VPDTLObJBTcPz9JI5qp0nw2Qfci0aReZji+CGW5ZzWKYk1Y7SMUsua2LI1rKBeRF37/FquPK+AV2ZX5EIN9McCy7rpqDSerWFbx+1SRkEJaRpks6GgSW4aC0WxcD5FTuoKRyQxDDM9EZqcCtv+PEXnyEDfodOK6JsJAZuylwETaBWSzMly/l5eFX468xlkFUUq6+9vR1DDbvcmGWQUoiYI459TNUtAXBUVtjZvqwHg3R8koVIuAJ8LrwztLQcKpZN8oveWPclgYD8Rcaadt7cV9rYIpLwJp8cYdoH4dbwdnxFWFzaQ0nwXjP/+KBDe0EXMlxAv0BQ==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Mon, 3 Jun
 2024 12:46:35 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 12:46:35 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "saeed@kernel.org" <saeed@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 11/15] net/mlx5e: SHAMPO, Add no-split ethtool
 counters for header/data split
Thread-Topic: [PATCH net-next 11/15] net/mlx5e: SHAMPO, Add no-split ethtool
 counters for header/data split
Thread-Index: AQHasQuJtQRfypWAYUSL0SwFzOvAUrGu/XwAgAAkZICAAMkNAIAGGx0A
Date: Mon, 3 Jun 2024 12:46:35 +0000
Message-ID: <04c66e37bc3c69df9fdce950223de6885b845056.camel@nvidia.com>
References: <20240528142807.903965-1-tariqt@nvidia.com>
	 <20240528142807.903965-12-tariqt@nvidia.com>
	 <20240529182208.401b1ecf@kernel.org> <ZlfzR_UV9CcCjR99@x130.lan>
	 <20240530083158.02ecfa5c@kernel.org>
In-Reply-To: <20240530083158.02ecfa5c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.1 (3.52.1-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|CY8PR12MB7706:EE_
x-ms-office365-filtering-correlation-id: f9f93a51-df33-4513-b25b-08dc83cb33e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?UENOVXgwWVFyWm1xSlVrYk9jQ3JRSTZ6L0hVZmc5RnZPV1RKY2hhUEdHTGVH?=
 =?utf-8?B?YjhsTW5JZEROMGFqOHVSMk9nNmNXU0YyZVlGQ09YUEV2OU1RL3I3S0d3Ujdo?=
 =?utf-8?B?c0ZvVjJzbDVTKzExQzg1ZFpHdlFzbE1GMUJwY3VTZURmQ3RyS0F1b2hMb0RX?=
 =?utf-8?B?b2JSU2dQUDBsallURi9VdkZwalhxMW9VeUdoSTZZWHNWZnoxSGpDYnljTGVP?=
 =?utf-8?B?MWRTS3NjbHZrRzFBWmRkeXpKdXFVek1TZ3FGT2ExR243YjlTWDV3UEZmN2Vn?=
 =?utf-8?B?VEpaRTlRMW1OT3dTdXVQSlBuOGlkUHM0RTRGWkNicTV3R0FJaG1TenBkNk43?=
 =?utf-8?B?QUlmN3daUDc1THJrNVBlYW5tMEIyOGJoY3pQVE11MFJqZXFRSklpRXZPOEs3?=
 =?utf-8?B?RE9yR0U1SjdtRUcreG1HcEViTEFRU2l0c2ZIQnJjSWhYLzY0T2s0RWdrWm9z?=
 =?utf-8?B?eHdseitFM3laVjY3Y3dsU0JLNkQ0MlpKZXhLYnlJRHJnL0xmR3J6OXVWcjRD?=
 =?utf-8?B?VGZ5RU5YczVabENpM21OUU5lRHlxenkzSDZEMGhGNWN2UGJjVmxYTWxPT1hB?=
 =?utf-8?B?WW5aRWh2dHduS25hcHpKZnBUYnlzc3FxMFNMMXhNZTduQ2tlTk95Z1RMK1lw?=
 =?utf-8?B?N3JiSW5helBQeGtLaXNxeXdKTHI2M1p4ekMvVS92aitoL3dvem1zdTk2bkJv?=
 =?utf-8?B?cXc5Y3NCMXBtVEtDVFFVN0RiTWU3aWM3VlBtR1NGNS9tTDQ2MUVjK0lqcm5O?=
 =?utf-8?B?OUpZV2phaURqZWhCVCtjSTczK1ZtVzhlOERDSEM2RS9pSnRKYXd3bTdQcURv?=
 =?utf-8?B?N3R6KzQ3WFByWDJqSmpaUFZFbTgrNUYrN0hEZTVhZTJrd2N0NThTT2FTNVIy?=
 =?utf-8?B?ei9DWWpiUHRjbytaa3BPWVNxQVhsNGlHNGRlMVRsZFR4V2VUcER2OUVETjFB?=
 =?utf-8?B?UnhZcldQWkxZRnAvRDRROWpqU25OblFaUDVnenljc0xldzY3bjhBMXQzZVZx?=
 =?utf-8?B?Vjcwb1cxL2h1UDBCd1lKeldDMXlmR3BsVm5pVDBDd3NMS0QzaSsyL0RPNjdz?=
 =?utf-8?B?R1ZWZGozdnQ1VEFVTGdMU01tdmVnV00ySSs1bWdubS90Ni81RlZIYXF5Z1VX?=
 =?utf-8?B?M0w5TlkyMzl5ZGIzOWZ2TCtVbnZVUUlXQVovZDlubzJKR04xdkI3TTJZdldQ?=
 =?utf-8?B?RjVmZzVINkU2R2RWbDN6Vks0eG1LWHpMWjg2OHlrUmVuMy9BK2VpUDZnNnJU?=
 =?utf-8?B?WXQvL25jTnhBZmc2RVRCVzlGbzVUOUNpcVcyWCt5T081SVZzOFdTbzNJKzlW?=
 =?utf-8?B?M1FWOUE0c3dTNkpBenhjVWx3d1Q1UENIdW0vR3RxRUttc0hpUHVkY3RnbDhu?=
 =?utf-8?B?SHhGUDQ5VzBUWFdKajBlV0tqTE16RnpONDBBc3dsT3NEWU84ZGIraldvWjZ3?=
 =?utf-8?B?dHVhODcvTWNtK2ZwZnppeDFsK1p1cWRvRjZWR2ZYTWd3bVpmMmIzRG1kdUlW?=
 =?utf-8?B?b0l2SGhjMGNabmxnZVRML040WC9CTGNvR3QzQUNjRXJhRXpDOS80eWhwbWk5?=
 =?utf-8?B?ekNqcC9hcXJKUmpPS1dPTlBWZmcrK1BVMGJqeS9pNXhTekd2dzlvRzAvU2Nh?=
 =?utf-8?B?TmFZekNvNDNYWUQvU0xGeGx5TmxVMXFYLzF2cGU0dFIvWDNWQklFU2s4SHlL?=
 =?utf-8?B?VjFPS3ZSUTVxSWlQRnVsMytNcTFQaysrT0Z6ZUExM2lSbThBRVFZYlI0Zm5E?=
 =?utf-8?B?Q3h4dlo2ZVM1bjZ1ekZRTjh1ZTZMam1XUUVnV1IvelBaZ3NjbEFuRXFOQURR?=
 =?utf-8?B?b1I5YnB4dVlySVJlUkJsdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUF6QkdCQUg0T1dNd1J0eC9Qc3pkeWhmRG5IRStHTko4cksxaUlDYXdGeEpW?=
 =?utf-8?B?NFByY2ZTNDJobVhOckRJUnJlNm53eHFuZXdWR1dyYjhQZVlkWW9NWEMyaEYw?=
 =?utf-8?B?NURwQUtzZVNlWWVRRGtoTHFFUG53TUFocWFVN2xYdFFmZXpyaVF6REY3YXNV?=
 =?utf-8?B?b1BwMmprMTlSYWFFNytxYnl3ZUJEUjErbUhXZUNndzlvamVORWxLT3B6cHRC?=
 =?utf-8?B?ZzU4R2oxVG45bVR6dGhWZmxFU0RobnVmV21nN2ZNSEovMXhxY3o4dVNZbmp2?=
 =?utf-8?B?T3h4T2VQRDFHSWgvdzFsY2Y4aGdpaEt3Slo2SVFoZzVwMmZYUDMrMjIyMmk5?=
 =?utf-8?B?eVh6QjA2MGNZQVNjSTZmZ0ljVlI2MlhDMlYzYU1KaEV3aTBjenUrcC9hcFJX?=
 =?utf-8?B?UTJTQXdRcW8rMzhSUHFCQm9ybWNFMHhkak1hSHFsdHhaYzlQOUh4Mkw0b2Ir?=
 =?utf-8?B?dGpTV0NoYTR1UGZXdDJVQVFXb2Y4cXFoajdrSlFITVJaYlZFZ0FiV3g0a0NX?=
 =?utf-8?B?YW5rQ0JzZVFpMVBDSyt3eFp1bDZTTUx2V1o0eGJlYU9JVEY0T0d4bkZlQ3Np?=
 =?utf-8?B?bmV1bjFRbUEzeklqUFZYUGtJanVDS1FvSHh5QzVlZEZmdVdEU0dlYmR6Z0tT?=
 =?utf-8?B?SkVFRlY3T1hXVE04bzEvYzUzZk5ubWwwT0VyN2N4Q2ZzTHBlY1NhMDNJNEkr?=
 =?utf-8?B?b3NlT3VNNGlFNXVXcVBXU290eUVKeXNESVpmTWVaVStWZUY3TlNxWE03bkQz?=
 =?utf-8?B?dExnNHdjS1FoSW5sOUtXODd1MkFwUUo5NFpqMlVvZjRzSUtQSW90b25ETjJP?=
 =?utf-8?B?bW1hMURZaExqbURGM3FnNWYxdFlhTGg4b3BnV0ZXVmc3ZytUVDBmVkpMQ3J2?=
 =?utf-8?B?YW1ycFZMVmpkajJSSElEMVcvQm0rY0RVSVZyK0w1emN6R01VbDcyb1htTlpN?=
 =?utf-8?B?V2o0dFVVT3h1QllnYTNpcmpjZCs3dW9WUkdDdHVURDdOd2htNVc1ZGFvYkNU?=
 =?utf-8?B?MDNQLzJ3aWlkL1JuTTBnTC9xZXJ3NzM2M3hlMVk3SjhXUG85NDJUYkc2ZTE1?=
 =?utf-8?B?YUxqWS8wY2I3eHBSbEV6OU5ILzJBRENpOUZmOU9XNjdZU0o5alBsYWQ5V1Zl?=
 =?utf-8?B?NDVHTlY5N0kycmk5RlVldnJobThDVWQ4ZXI4dGlHcitHQ3NGM3BJbVpRUXN0?=
 =?utf-8?B?bjloanZpWWxId29GVFhJSks4bldjMHcrVHh5bWhBTDZWY1had1RKSkluWlNW?=
 =?utf-8?B?K3B6d0FFVDBaUVpjd2hDa3ZMYnJyZlEzU04wNHoxWkhUOFIrMGI1MmRsRVp0?=
 =?utf-8?B?RTJrWHpYMnZEMCtRNkFqdS93c3psMFpsaGtPSmJqTWpLU0VkQTlPNUhrR09P?=
 =?utf-8?B?d1FyaWVaRk12VEtJMlppNFkyT2UwYUx0aEdOS3Y1dzh2c2NkQkxaMTZsUFFF?=
 =?utf-8?B?NDRpTXdXN0Q0ZUVwcGVzbS8zMU0vY0tVRFlRWGM1d0tsOERscnU1K2Y4czVQ?=
 =?utf-8?B?eFU5SDF4VEE4MUZMUitsckk3UllqVGNUalpuSElyWmwyQ1hkV3k0bUsydXRL?=
 =?utf-8?B?eks3c1A1cVRpVUVpK2FGSmJFRVMxQncrN2ExK3dNVVlnU1BrbExNYlB6aXUv?=
 =?utf-8?B?S09aSlNxbXVCWHJBdGlLOUNWKy9rOHlpc2hyNVV0d3NLcjhjRnV3dHVSaE5o?=
 =?utf-8?B?MFoyUXBFajE3NFJRRG03dHAzcjVkWTZuODVxeUlCbHdvbFMxYlJDWVJPQkNV?=
 =?utf-8?B?bGtXVEsyMU1JdU1neFl2aVA2T3RiQmQ1cUV5aW5JRTZKeFptRDV4eUQ0c28z?=
 =?utf-8?B?TXpyWVp0c1gwNkNFRm0vVHpBL1JzSE0zUzAxamplS2tDd2RsWURtNFVqUGJp?=
 =?utf-8?B?Z2FOU1J6b24yYzVCZjcyRFlueTZra1Z3N1Z3K3lXa21DeVRyTnBMTkJLWkt6?=
 =?utf-8?B?NUw1TmhEaENqQ25zV3Npc2NDcjlRMzJiY1NBbEVRSit4RFRxL2hBeCtwdW8v?=
 =?utf-8?B?c3dlUUNnTG8reHZGT3JXWWZ2azFGTTVNOEFlMmJxSWd3aDg3V0xHZTVRMS9L?=
 =?utf-8?B?WXlBVWtQVWJYTEpDYlBqTmtpdi9hamxZLzZibTFnay9TR2pxWE8zWXg4MWdH?=
 =?utf-8?B?L1JudUJwYStXUWxCUlYremRSd3lmVVNwU2lKUkVCYlc1Y3U2Y2QvdzNqQjh3?=
 =?utf-8?Q?oMijfcpeOTNu8E9vy6jqBCSmTAy9PAeETP6L/9aLyEMb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F1454EF7EEFFA4198AF0CD477D118EE@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f93a51-df33-4513-b25b-08dc83cb33e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 12:46:35.1454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O0+OaH+6v/qbfUItBaqq+IMFjCI01zPpu7m6j8TY/KoGoPW7H8L8/PRlnJvbvViHMOPpYMfsBIsH3PnpnlbfLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706

T24gVGh1LCAyMDI0LTA1LTMwIGF0IDA4OjMxIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCAyOSBNYXkgMjAyNCAyMDozMjoyMyAtMDcwMCBTYWVlZCBNYWhhbWVlZCB3cm90
ZToNCj4gPiBPbiAyOSBNYXkgMTg6MjIsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiA+ID4gT24g
VHVlLCAyOCBNYXkgMjAyNCAxNzoyODowMyArMDMwMCBUYXJpcSBUb3VrYW4gd3JvdGU6ICANCj4g
PiA+ID4gKyAgICogLSBgcnhbaV1faGRzX25vc3BsaXRfcGFja2V0c2ANCj4gPiA+ID4gKyAgICAg
LSBOdW1iZXIgb2YgcGFja2V0cyB0aGF0IHdlcmUgbm90IHNwbGl0IGluIG1vZGVzIHRoYXQgZG8g
aGVhZGVyL2RhdGEgc3BsaXQNCj4gPiA+ID4gKyAgICAgICBbI2FjY2VsXV8uDQo+ID4gPiA+ICsg
ICAgIC0gSW5mb3JtYXRpdmUNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgKiAtIGByeFtpXV9oZHNf
bm9zcGxpdF9ieXRlc2ANCj4gPiA+ID4gKyAgICAgLSBOdW1iZXIgb2YgYnl0ZXMgdGhhdCB3ZXJl
IG5vdCBzcGxpdCBpbiBtb2RlcyB0aGF0IGRvIGhlYWRlci9kYXRhIHNwbGl0DQo+ID4gPiA+ICsg
ICAgICAgWyNhY2NlbF1fLg0KPiA+ID4gPiArICAgICAtIEluZm9ybWF0aXZlICANCj4gPiA+IA0K
PiA+ID4gVGhpcyBpcyB0b28gdmFndWUuIFRoZSBldGh0b29sIEhEUyBmZWF0dXJlIGlzIGZvciBU
Q1Agb25seS4NCj4gPiA+IFdoYXQgZG9lcyB0aGlzIGNvdW50PyBOb24tVENQIHBhY2tldHMgYmFz
aWNhbGx5Pw0KPiA+IA0KPiA+IEJ1dCB0aGlzIGlzIG5vdCB0aGUgZXRodG9vbCBIRFMsIHRoaXMg
aXMgdGhlIG1seDUgSFcgR1JPIGhkcy4NCj4gDQo+IE9rYXksIGJ1dCB5b3UgbmVlZCB0byBwdXQg
bW9yZSBkZXRhaWwgaW50byB0aGUgZGVzY3JpcHRpb24uDQo+ICJub3Qgc3BsaXQgaW4gbW9kZXMg
d2hpY2ggZG8gc3BsaXQiIGlzIGdvaW5nIHRvIGltbWVkaWF0ZWx5IA0KPiBtYWtlIHRoZSByZWFk
ZXIgYXNrIHRoZW1zZWx2ZXMgImJ1dCB3aHk/Ii4NCj4gDQpXZSBkaXNjdXNzZWQgaW50ZXJuYWxs
eSBhbmQgZGVjaWRlZCB0byBkcm9wIHRoaXMgY291bnRlciBhbmQgcGF0Y2ggZm9yIG5vdy4gVGhp
cw0Kd2lsbCBiZSBhZGRlZCBiYWNrIGluIHRoZSBIRFMgc2VyaWVzIHNvIHRoYXQgd2UgaGF2ZSBt
b3JlIHRpbWUgdG8gY29udmVyZ2Ugb24gYQ0KdGhlIGRvY3VtZW50YXRpb24gcGFydC4NCg0KPiA+
IE9uIHRoZSBzYW5lIG5vdGUsIGFyZSB3ZSBwbGFubmluZyB0byBoYXZlIGRpZmZlcmVudCBjb250
cm9sIGtub2JzL3N0YXRzIGZvcg0KPiA+IHRjcC91ZHAvaXAgSERTPyBDb25uZWN0WCBzdXBwb3J0
cyBib3RoIFRDUCBhbmQgVURQIG9uIHRoZSBzYW1lIHF1ZXVlLCANCj4gPiB0aGUgZHJpdmVyIGhh
cyBubyBjb250cm9sIG9uIHdoaWNoIHByb3RvY29sIGdldHMgSERTIGFuZCB3aGljaCBkb2Vzbid0
Lg0KPiANCj4gTm8gcGxhbnMgYXQgdGhpcyBzdGFnZS4gVGhlIGV0aHRvb2wgSERTIGlzIHNwZWNp
ZmljYWxseSB0aGVyZQ0KPiB0byB0ZWxsIHVzZXIgc3BhY2Ugd2hldGhlciBpdCBzaG91bGQgYm90
aGVyIHRyeWluZyB0byB1c2UgVENQIG1tYXAuDQo+IA0KPiA+ID4gR2l2ZW4gdGhpcyBpcyBhIEhX
LUdSTyBzZXJpZXMsIGFyZSBIRFMgcGFja2V0cyA9PSBIVy1HUk8gZWxpZ2libGUNCj4gPiA+IHBh
Y2tldHM/DQo+ID4gDQo+ID4gTm8sIFVEUCB3aWxsIGFsc28gZ2V0IGhlYWRlciBkYXRhIHNwbGl0
IG9yIG90aGVyIFRDUCBwYWNrZXRzIHRoYXQgZG9uJ3QNCj4gPiBiZWxvbmcgdG8gYW55IGFnZ3Jl
Z2F0aW9uIGNvbnRleHQgaW4gdGhlIEhXLg0KPiANCj4gSSBzZWUuDQoNClRoYW5rcywNCkRyYWdv
cw0K

