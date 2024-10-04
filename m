Return-Path: <netdev+bounces-131936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8046598FFCC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FB61F21355
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292F146D6E;
	Fri,  4 Oct 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XhuOG+eP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048C146D6A
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034338; cv=fail; b=NwRUrNhmLQwhLdYHrlbRbJpENsLmqk7Te1NmLBgAF4lX2WKU48Ncc2BNba4TpOUxlf84/hUeEEKghV3inXi4G8H0lgP6hp/d76IL7UiFilGPW3YkOcvad5mlLW2sJ96WWhEGRibTrVGgPIsuxU4XAqSBatV4EPe3axlcc610Si0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034338; c=relaxed/simple;
	bh=68OW0VSDwPzQ3veZui13FJphxrk9sV2KVTG2TXIM1cs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C5UyAEVzAIxTU36KIucHorQ6vH6Q4fD8TBDCoPQwQCUBDEwvuB0jZIzJJ5KRtapv1aHxOc7iNOOWGu6UAzqDqmoBAV4yOv9T5091/c58W0VDpwBdZGtbE9Ic4y21GBLoCrW+AHtzzWpk+FV1G17QXdiWfQB4zOzLavlWxOpI190=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XhuOG+eP; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjHaTrFzW7jErKJoZ90SrdFrDZOJlvVoafblXxk3D1rh/BRbZBbLyOp0DNUef81pVbjpeE9NrMAHBzJM3+l6qtYf3JUb8x0T+b4iAKsGidwxPAjy7lT1H8PxUSaIAgFqrXWf+Lqm2iiHgmt0godlm1DSlCBJJ+mCbyZ/Tzvfz8Ap+ejAXIoFYqIHreX7DUzNSTt3tmmgjxFR9tjZ+x/CzV+Nf4WAjVJJaykV89yd/UMfCeuiQbmsB/kvgQ8sTQ7KFDk9wTjNz7nslDFrEqRKF7WbyxAAXeud72+FKoIrla4inXHbtZ6bPrUxEkjIyZFL6CBB9FJXQceFVIW+XuUd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68OW0VSDwPzQ3veZui13FJphxrk9sV2KVTG2TXIM1cs=;
 b=gd6haOeGF2BFMocv56ljmDxx9raGSEJlYvpNTM2vN8yYgMWL6hpMM3p+ETln4PrKXJLTXznpI7Oht6Ofp8M9L4mWEuW+g9zLoQ1P2oH5A7dHcfojTyZEC7imhhfW3EfmM+j2Ion/cH2Y3NMjFZvQpBmAu6TJbZ8OlQjpZbDlDMxfMhScXxHsj11CxDKXyj+122EJZmJ7UXMb65Sxw5/ZN16hzXiEjs9UuBgwGg2t2CKDIcYAv8iRsSMjMEtKD1xeg4bH/GKyfuULv8vMp4e3Dp3ui6sVv9l1U+BDIxB/NFJJXBu48D00Pb5iSa7OfeRuId82BBv7EpBPGYXnqfvPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68OW0VSDwPzQ3veZui13FJphxrk9sV2KVTG2TXIM1cs=;
 b=XhuOG+ePwiQznlLP0p05QTBSz7KuzbPN4s1nnSg4x65mS3HebxquOJRXcDCPBVYWiC1Zoz0LtOulrgDrk5jnHAnflO7iYE7IsIW/7fS6MwMWzOYIvKDARtiUbqQoiVnVdT5qLi168upof2A5UET3BClpCyZ8qzMlYNYLS5bClttA14j7/rI5oZd3DjZiKcFe7kBITPfd7ld5cHgX8SNQ7lF4s7z3Ac6x+Vm57+d3PxI/RVuyex3CtD2lpk5AJExLaAVMSxz9TgitqrO7xi5o2sj8/LgvmNny6deDzmVzQPhZAt4p8uf2T/QvfbVL6Xw2Lsub0YZGHqZFYUO/fwGt7A==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:32:11 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 09:32:11 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "horms@kernel.org" <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next V2 3/6] net/mlx5: hw counters: Replace IDR+lists
 with xarray
Thread-Topic: [PATCH net-next V2 3/6] net/mlx5: hw counters: Replace IDR+lists
 with xarray
Thread-Index: AQHbE+39wucmnWTfpkmpSUPZZxADILJ2T18AgAAJUgA=
Date: Fri, 4 Oct 2024 09:32:11 +0000
Message-ID: <66ccbb841794c98b91d9e8aba48b90c63caa45e7.camel@nvidia.com>
References: <20241001103709.58127-1-tariqt@nvidia.com>
	 <20241001103709.58127-4-tariqt@nvidia.com>
	 <20241004085844.GA1310185@kernel.org>
In-Reply-To: <20241004085844.GA1310185@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|MN6PR12MB8513:EE_
x-ms-office365-filtering-correlation-id: 422c2d9c-4548-4a17-4ee7-08dce4576c65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjBYd1l1R1lRcEJYb1JWUTJQd2tWSTdrZ1ZHU3pHeGdzSjUvREJyOHQwbDhR?=
 =?utf-8?B?SEFmZEpzZDlueVgvVzYzak1DU0NIOHBkOTl0TTIvTHJURjIxVzNQd1YvdlFU?=
 =?utf-8?B?dmRlREs1VDIvYmtmajJ2a2FOU3NFNEt1Z0dUVTl4c2Y2Z1RsemkzRmpyOUxo?=
 =?utf-8?B?MXZpYlBGUXN2QUNjUFgyN1c5dFZxWG11aTVqREY5cUw0T2RUaWIxOEdycGU4?=
 =?utf-8?B?ZXdCUXBhbkxoQXFxL2hSeGN5OHBJNzNMOXM4a0Qxb2MyTE1sM2tjZXNFRmNQ?=
 =?utf-8?B?MkVDZmo4R2V2QmRNSW50QlowOUJMdzRydHhlNnM0L2ptbStFQW5vcElQelpo?=
 =?utf-8?B?WUphR3hlTFNVdHo5dXFCVkZrSlVkdnRnQmhTd1BaQnJESVZwWjFCM0V5Q3Rx?=
 =?utf-8?B?aUpyM2s0UnVGaHY0L1ZRWVQxM2JuOERxdHFhTjRJNzVXYzBRa1BQSlA5a3lr?=
 =?utf-8?B?dEJJU09ZMW1TWFl2TzFyanpSdXFxdkVXZzVGTXhjeTN0bjJTRitYc2pxdzc3?=
 =?utf-8?B?SDU4OVAwMTd2M2VQSmFNWjBLeDJSWkZ0T1kvMGtvZ2NtT0pmSUJ1SktrdGlv?=
 =?utf-8?B?KzZaVGlYTXJOOHpvQXZFVkRKRlY0cE9mcmFydm1LWU0vS1BLTm9sektONFBm?=
 =?utf-8?B?NXloVVpVQWY0NTFyaVVuNXU2c3pwYUJQUXp6TlUwZlhkODFQUWptYmZVWUI2?=
 =?utf-8?B?WUZsemxoN0VLN011VGIybVVlcnJldjZrQUdjUjFoYXM3SnBIbW0zVXFKTWRz?=
 =?utf-8?B?OEZhS1lPZUNTYnA4NzZ6WkRrbFhHeWVzcE53b1drMDQ0L1pQN2pER1I1eGZM?=
 =?utf-8?B?dlZualF4UHNvR3BMMlhWRGVJaHgzS2FMS1lRSDNudHRZeFRFeTl3RG5yTUdj?=
 =?utf-8?B?Ukl3L25LVmhLbWRsR3Y0UVhUZVZUSVRRQjdEYlRjVmJvTzVLMEczZUlIc2l4?=
 =?utf-8?B?bGo4emFxalFvd0VKWmJ5dE5BcEdNTm90aUtxN2tSVE0rakNmYVAxUElKN0Vh?=
 =?utf-8?B?RmxIZU0vVjhNY3MramhEbDZjcHRueWUrQ0JuRmhmVnppdHlYdko3allFdnBu?=
 =?utf-8?B?akVRNk1JU2tCV3NPd2pFenBrc28vL3JWWnRoR3ZZV0NiNDAyMFlvd01ZcnZo?=
 =?utf-8?B?emFhTXBEanUxcDBJR1hLV3JFOHBVNjFwL2lpYmpRZERydzVTZC9SK05NRHJP?=
 =?utf-8?B?ek5rMExXWHAvTEx5MGF4QVlYK3hPbnVEa0VaZUdBRG9yVlpLYVByMXA0YWNW?=
 =?utf-8?B?WVY0OU8zUGRyTm9LV0twcHRsM25aTTgvc0NVTk0rTHF6WHNxa2ZCYmhNYytW?=
 =?utf-8?B?Nkd0ZklNVU5WWHdwV1JiVVdSNDlvaVZIc3lsNUltSlE3KzNBOGk4aU1URUNk?=
 =?utf-8?B?dlBPYWlNdlk2TFFleEFCdHdSU2ZGYkJoSml3UnY4aUgvbDZLTjBPbkh0TWVO?=
 =?utf-8?B?SVBlWUxVMXNWMEhqdkp2MkdvTk9QcDBNR1ZrU0UwQ0xsK2lBUzB6VjR5QVNv?=
 =?utf-8?B?c2Qxd2k0VUZSQkhxMkxwTlFwSG8yVFhiTlJFeXFPRUJ5RCtyQ2FIOGROZ3p2?=
 =?utf-8?B?S3gwb1BDUHB5K0RSckpVRlQ4QTMyZE05ZGRhOEFJb0d6d09QdHNTKzZnM21G?=
 =?utf-8?B?ZURJditDMW9uem9hZEVaY2h5OTRLT2UwaHBSOXA2VHdSUUVtNHFiQ2hDd2l0?=
 =?utf-8?B?VStkMHA5ZFlsRDJ2NzliRk12dnlWV29KU2YzOFZWd0xYSlA0WVdScW5TNkFI?=
 =?utf-8?B?V1B3b0FONzFTNXhwNVpkT0Iwd1RnMndOYTB1TzRzMHlyeUxPMlF0dzNCSDdZ?=
 =?utf-8?B?NlZ0K08yMmg4MWVYbjYvQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aW5KS1A3Ym9wTzlFL3lQOUpvck1IOVhacmtqYXRZTzVrc09VeERHanl2ZFFN?=
 =?utf-8?B?eS9Kb0hJbGttWm9icjczVjV5bDczTXJKY0QwZzl2emVwVFRWR0RWWVF4bGZy?=
 =?utf-8?B?M3o1bUlaczE3REtyRVdYNTROd0p6eGpXOUQwYmlaTWF2THZOdWdGZHNFMUZO?=
 =?utf-8?B?N0NTZ2RIeEwwb0xHdDV0Q1BnR2k2N0pRSEh4UG9yMmV1MFZWaW1nU0JZMWdB?=
 =?utf-8?B?YVp3S2c2U01DcE1mOHNBRVdUdEVvR3R4blJqellrWmk5NVd4b2UvZ01zSXRm?=
 =?utf-8?B?SDY4c3lTQnM0d1ZZQlBQeHF3bGhVd1o1Tnh5NXUyRkxWMkc5TDlONHBlZjdN?=
 =?utf-8?B?ald0NzFkbEN0cDZmZDUzcFNOWkVYY3dId2VVRFB6WmZ6OUZIYlJ1RmxNOUYv?=
 =?utf-8?B?cnl2WVJzMU1hQWFGQzVQM1JMdHViYk93c3ZBQ2xtTFVFbVQzWkMzT2NPLzRh?=
 =?utf-8?B?bXFYc3c1VXhKRHlzdmFXMURXWFhIUzhmVS9zd1FyLzRySmd3SEJGR2xOa1d1?=
 =?utf-8?B?NWxLeStEWTFkRjAvSnpUZW1ldkIwem1jTjhYWk1MVEZaeGxocWNaYThOdmls?=
 =?utf-8?B?b3BqY3diNU10akxGMW9hMkxNZWhFMkZXUkNxQ0ppcVVuNVBmK3paN0dCWGcw?=
 =?utf-8?B?RXdRR2theC83ek83a25NdENnT1FYb2pwamVUSU9BUkowMVo0RDkyQzBhTExy?=
 =?utf-8?B?dytrdmhNd0M2dkUrRzhwbTFITjBSTGhYT3g4ckZRZ2dtR2dIcW5oZm9XeklS?=
 =?utf-8?B?U0o5TWpmVEFTTkVWVVVvQmZMdGJQcWg4SXdMc0NWZHY3NVhFU1hFUjd6S1h5?=
 =?utf-8?B?b0Fsdi9nbmFEWEdCY2QzMGx6UlRwWUtWSk5GN1pVZVBCL2ZnY3ZxSk9WYUdV?=
 =?utf-8?B?eFpGcmRoVU5KVUxJYUJ1RU43SlMyQmFSTGprZlFnb3BkaHVBeE1FeU5KazVS?=
 =?utf-8?B?Qkw2Z0NITUIrT3hlY1FNQ0ViT3JqS1VVOVlhT1RqcVV4Yk5pT1BhNTJoK01V?=
 =?utf-8?B?eUtlVUdmMTRpMlk4SEhIb1c5RGFoT29NSzlRazczeWsrSUpZS01MZWdyZGhN?=
 =?utf-8?B?Mk5HajRWdlFqcVM1bUdKbGw3UVN4QXR6QTFZRFc2S1JLMUVwU2IrYStQNk9I?=
 =?utf-8?B?ZG5Lc2F6Yk5RQlNsZ3NTaDlIUU1FMk9paXN3NlJURWh0SVNFWHNVS2M4WTdj?=
 =?utf-8?B?dXY0bytOODJHOGVQdkVkR0dxZ05VMWF4NHJuTmx4SlZXT05pT2lVS2JNTDV0?=
 =?utf-8?B?UEJ5aE9iaDdnb0FScE93U1FaU051L01MbmNJcndYeUtCaThPUHppaCt1U0ZK?=
 =?utf-8?B?RnJkSVB2ZzdTN3NUaVk5SFpzdFd6RHM0L1hIRWNWejBZSUZybU5xdGk2aVIz?=
 =?utf-8?B?dHNNNWN6K3lodkZTOERZSklZa1l6K3hnd2dOMXhBRW1mc0ZtMEI0NnVjeE5p?=
 =?utf-8?B?NmRFRUJ5dFB0OVBraEFoc2ZJN0JiUkRua2UvN21aaTNVNExqQkdldi9lb2Jq?=
 =?utf-8?B?M2JQZTErd1E2L3R5VFRJQjE3bTcvQTRZeG9VMm11SUVDOWRKUHRFMllVVmlT?=
 =?utf-8?B?N3RNcVloQ0dxeElFM2dHK1pacVE1Qkl6UThNQTE2U0QvdjFvb0ZCV1RUQURH?=
 =?utf-8?B?YlVZMDgwZ1lZUWQwVm9WTVF6bFl3djZBRlRqZXNEa3hOVFBSV3JRYjY0TDls?=
 =?utf-8?B?VWs1SXJndUw0NGxocnNvbGtZTWZabjVOR1QwaUxOdGVEZXdNeTlFY2F4ano0?=
 =?utf-8?B?U2N6enV0VHoraWk3R0t3d1hCTjlYQWl1dC93d1oxQ21oUG1Kdkw3VUN4US9R?=
 =?utf-8?B?alhpTDh3ZThVYjN1QTJQRjc2U1RDdkN3Yzh0ckhJQ3VTZC9aR2dqWHI2STZt?=
 =?utf-8?B?ZldBUzBPejhUVzBsVWVjOFpXajhjaDMwTm1jVy9QdjVRZFFXL0hmdHU3anJV?=
 =?utf-8?B?MWg3YkN2UlZQRmI4TE5NL2RPUXBlcm5zQTQyRitKYThmWWZ5Vi9wRFlDRVNE?=
 =?utf-8?B?MG5BQ2MyZ1luRXZCZWoxRy81NnFqN1k2MUFuT0Z3NnJDR3dvVHdRa25DS2l0?=
 =?utf-8?B?RmFhWDdDNjNTZnpDbUJMVHAwR1ArazJ3L1E4bWZLRDBRVTVuOUZGdDhnbG1J?=
 =?utf-8?Q?Hpyh7lxZ9PxQtNC0NOU6gGP5A?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DB63425E8BE3F46810C60A0E0ECE550@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 422c2d9c-4548-4a17-4ee7-08dce4576c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 09:32:11.1051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KY45iPSeSk2uaCZ7mqPWdi/iiQNpkgE+a7abkZKUMd2z+7uloDb/W9gotqIFwWIvaPGYluxCiV/syZ73zRKfqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513

T24gRnJpLCAyMDI0LTEwLTA0IGF0IDA5OjU4ICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IE9uIFR1ZSwgT2N0IDAxLCAyMDI0IGF0IDAxOjM3OjA2UE0gKzAzMDAsIFRhcmlxIFRvdWthbiB3
cm90ZToNCj4gPiBGcm9tOiBDb3NtaW4gUmF0aXUgPGNyYXRpdUBudmlkaWEuY29tPg0KPiANCj4g
Li4uDQo+IA0KPiA+ICsvKiBTeW5jaHJvbml6YXRpb24gbm90ZXMNCj4gPiArICoNCj4gPiArICog
QWNjZXNzIHRvIGNvdW50ZXIgYXJyYXk6DQo+ID4gKyAqIC0gY3JlYXRlIC0gbWx4NV9mY19jcmVh
dGUoKSAodXNlciBjb250ZXh0KQ0KPiA+ICsgKiAgIC0gaW5zZXJ0cyB0aGUgY291bnRlciBpbnRv
IHRoZSB4YXJyYXkuDQo+ID4gKyAqDQo+ID4gKyAqIC0gZGVzdHJveSAtIG1seDVfZmNfZGVzdHJv
eSgpICh1c2VyIGNvbnRleHQpDQo+ID4gKyAqICAgLSBlcmFzZXMgdGhlIGNvdW50ZXIgZnJvbSB0
aGUgeGFycmF5IGFuZCByZWxlYXNlcyBpdC4NCj4gPiArICoNCj4gPiArICogLSBxdWVyeSBtbHg1
X2ZjX3F1ZXJ5KCksIG1seDVfZmNfcXVlcnlfY2FjaGVkeyxfcmF3fSgpICh1c2VyIGNvbnRleHQp
DQo+ID4gKyAqICAgLSB1c2VyIHNob3VsZCBub3QgYWNjZXNzIGEgY291bnRlciBhZnRlciBkZXN0
cm95Lg0KPiA+ICsgKg0KPiA+ICsgKiAtIGJ1bGsgcXVlcnkgKHNpbmdsZSB0aHJlYWQgd29ya3F1
ZXVlIGNvbnRleHQpDQo+ID4gKyAqICAgLSBjcmVhdGU6IHF1ZXJ5IHJlbGllcyBvbiAnbGFzdHVz
ZScgdG8gYXZvaWQgdXBkYXRpbmcgY291bnRlcnMgYWRkZWQNCj4gPiArICogICAgICAgICAgICAg
YXJvdW5kIHRoZSBzYW1lIHRpbWUgYXMgdGhlIGN1cnJlbnQgYnVsayBjbWQuDQo+ID4gKyAqICAg
LSBkZXN0cm95OiBkZXN0cm95ZWQgY291bnRlcnMgd2lsbCBub3QgYmUgYWNjZXNzZWQsIGV2ZW4g
aWYgdGhleSBhcmUNCj4gPiArICogICAgICAgICAgICAgIGRlc3Ryb3llZCBkdXJpbmcgYSBidWxr
IHF1ZXJ5IGNvbW1hbmQuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgdm9pZCBtbHg1X2ZjX3N0YXRz
X3F1ZXJ5X2FsbF9jb3VudGVycyhzdHJ1Y3QgbWx4NV9jb3JlX2RldiAqZGV2KQ0KPiA+ICB7DQo+
ID4gIAlzdHJ1Y3QgbWx4NV9mY19zdGF0cyAqZmNfc3RhdHMgPSBkZXYtPnByaXYuZmNfc3RhdHM7
DQo+ID4gLQlib29sIHF1ZXJ5X21vcmVfY291bnRlcnMgPSAoZmlyc3QtPmlkIDw9IGxhc3RfaWQp
Ow0KPiA+IC0JaW50IGN1cl9idWxrX2xlbiA9IGZjX3N0YXRzLT5idWxrX3F1ZXJ5X2xlbjsNCj4g
PiArCXUzMiBidWxrX2xlbiA9IGZjX3N0YXRzLT5idWxrX3F1ZXJ5X2xlbjsNCj4gPiArCVhBX1NU
QVRFKHhhcywgJmZjX3N0YXRzLT5jb3VudGVycywgMCk7DQo+ID4gIAl1MzIgKmRhdGEgPSBmY19z
dGF0cy0+YnVsa19xdWVyeV9vdXQ7DQo+ID4gLQlzdHJ1Y3QgbWx4NV9mYyAqY291bnRlciA9IGZp
cnN0Ow0KPiA+ICsJc3RydWN0IG1seDVfZmMgKmNvdW50ZXI7DQo+ID4gKwl1MzIgbGFzdF9idWxr
X2lkID0gMDsNCj4gPiArCXU2NCBidWxrX3F1ZXJ5X3RpbWU7DQo+ID4gIAl1MzIgYnVsa19iYXNl
X2lkOw0KPiA+IC0JaW50IGJ1bGtfbGVuOw0KPiA+ICAJaW50IGVycjsNCj4gPiAgDQo+ID4gLQl3
aGlsZSAocXVlcnlfbW9yZV9jb3VudGVycykgew0KPiA+IC0JCS8qIGZpcnN0IGlkIG11c3QgYmUg
YWxpZ25lZCB0byA0IHdoZW4gdXNpbmcgYnVsayBxdWVyeSAqLw0KPiA+IC0JCWJ1bGtfYmFzZV9p
ZCA9IGNvdW50ZXItPmlkICYgfjB4MzsNCj4gPiAtDQo+ID4gLQkJLyogbnVtYmVyIG9mIGNvdW50
ZXJzIHRvIHF1ZXJ5IGluYy4gdGhlIGxhc3QgY291bnRlciAqLw0KPiA+IC0JCWJ1bGtfbGVuID0g
bWluX3QoaW50LCBjdXJfYnVsa19sZW4sDQo+ID4gLQkJCQkgQUxJR04obGFzdF9pZCAtIGJ1bGtf
YmFzZV9pZCArIDEsIDQpKTsNCj4gPiAtDQo+ID4gLQkJZXJyID0gbWx4NV9jbWRfZmNfYnVsa19x
dWVyeShkZXYsIGJ1bGtfYmFzZV9pZCwgYnVsa19sZW4sDQo+ID4gLQkJCQkJICAgICBkYXRhKTsN
Cj4gPiAtCQlpZiAoZXJyKSB7DQo+ID4gLQkJCW1seDVfY29yZV9lcnIoZGV2LCAiRXJyb3IgZG9p
bmcgYnVsayBxdWVyeTogJWRcbiIsIGVycik7DQo+ID4gLQkJCXJldHVybjsNCj4gPiAtCQl9DQo+
ID4gLQkJcXVlcnlfbW9yZV9jb3VudGVycyA9IGZhbHNlOw0KPiA+IC0NCj4gPiAtCQlsaXN0X2Zv
cl9lYWNoX2VudHJ5X2Zyb20oY291bnRlciwgJmZjX3N0YXRzLT5jb3VudGVycywgbGlzdCkgew0K
PiA+IC0JCQlpbnQgY291bnRlcl9pbmRleCA9IGNvdW50ZXItPmlkIC0gYnVsa19iYXNlX2lkOw0K
PiA+IC0JCQlzdHJ1Y3QgbWx4NV9mY19jYWNoZSAqY2FjaGUgPSAmY291bnRlci0+Y2FjaGU7DQo+
ID4gLQ0KPiA+IC0JCQlpZiAoY291bnRlci0+aWQgPj0gYnVsa19iYXNlX2lkICsgYnVsa19sZW4p
IHsNCj4gPiAtCQkJCXF1ZXJ5X21vcmVfY291bnRlcnMgPSB0cnVlOw0KPiA+IC0JCQkJYnJlYWs7
DQo+ID4gKwl4YXNfbG9jaygmeGFzKTsNCj4gPiArCXhhc19mb3JfZWFjaCgmeGFzLCBjb3VudGVy
LCBVMzJfTUFYKSB7DQo+ID4gKwkJaWYgKHhhc19yZXRyeSgmeGFzLCBjb3VudGVyKSkNCj4gPiAr
CQkJY29udGludWU7DQo+ID4gKwkJaWYgKHVubGlrZWx5KGNvdW50ZXItPmlkID49IGxhc3RfYnVs
a19pZCkpIHsNCj4gPiArCQkJLyogU3RhcnQgbmV3IGJ1bGsgcXVlcnkuICovDQo+ID4gKwkJCS8q
IEZpcnN0IGlkIG11c3QgYmUgYWxpZ25lZCB0byA0IHdoZW4gdXNpbmcgYnVsayBxdWVyeS4gKi8N
Cj4gPiArCQkJYnVsa19iYXNlX2lkID0gY291bnRlci0+aWQgJiB+MHgzOw0KPiA+ICsJCQlsYXN0
X2J1bGtfaWQgPSBidWxrX2Jhc2VfaWQgKyBidWxrX2xlbjsNCj4gPiArCQkJLyogVGhlIGxvY2sg
aXMgcmVsZWFzZWQgd2hpbGUgcXVlcnlpbmcgdGhlIGh3IGFuZCByZWFjcXVpcmVkIGFmdGVyLiAq
Lw0KPiA+ICsJCQl4YXNfdW5sb2NrKCZ4YXMpOw0KPiA+ICsJCQkvKiBUaGUgc2FtZSBpZCBuZWVk
cyB0byBiZSBwcm9jZXNzZWQgYWdhaW4gaW4gdGhlIG5leHQgbG9vcCBpdGVyYXRpb24uICovDQo+
ID4gKwkJCXhhc19yZXNldCgmeGFzKTsNCj4gPiArCQkJYnVsa19xdWVyeV90aW1lID0gamlmZmll
czsNCj4gPiArCQkJZXJyID0gbWx4NV9jbWRfZmNfYnVsa19xdWVyeShkZXYsIGJ1bGtfYmFzZV9p
ZCwgYnVsa19sZW4sIGRhdGEpOw0KPiA+ICsJCQlpZiAoZXJyKSB7DQo+ID4gKwkJCQltbHg1X2Nv
cmVfZXJyKGRldiwgIkVycm9yIGRvaW5nIGJ1bGsgcXVlcnk6ICVkXG4iLCBlcnIpOw0KPiA+ICsJ
CQkJcmV0dXJuOw0KPiA+ICAJCQl9DQo+ID4gLQ0KPiA+IC0JCQl1cGRhdGVfY291bnRlcl9jYWNo
ZShjb3VudGVyX2luZGV4LCBkYXRhLCBjYWNoZSk7DQo+ID4gKwkJCXhhc19sb2NrKCZ4YXMpOw0K
PiA+ICsJCQljb250aW51ZTsNCj4gPiAgCQl9DQo+ID4gKwkJLyogRG8gbm90IHVwZGF0ZSBjb3Vu
dGVycyBhZGRlZCBhZnRlciBidWxrIHF1ZXJ5IHdhcyBzdGFydGVkLiAqLw0KPiANCj4gSGkgQ29z
bWluIGFuZCBUYXJpcSwNCj4gDQo+IEknbSBzb3JyeSBpZiBpdCBpcyBvYnZpb3VzLCBidXQgSSdt
IHdvbmRlcmluZyBpZiB5b3UgY291bGQgZXhwbGFpbiBmdXJ0aGVyDQo+IHRoZSByZWxhdGlvbnNo
aXAgYmV0d2VlbiB0aGUgaWYgYmxvY2sgYWJvdmUsIHdoZXJlIGJ1bGtfcXVlcnlfdGltZSAoYW5k
DQo+IGJ1bGtfYmFzZV9pZCkgaXMgaW5pdGlhbGlzZWQgYW5kIGlmIGJsb2NrIGJlbG93LCB3aGlj
aCBpcyBjb25kaXRpb25hbCBvbg0KPiBidWxrX3F1ZXJ5X3RpbWUuDQo+IA0KPiA+ICsJCWlmICh0
aW1lX2FmdGVyNjQoYnVsa19xdWVyeV90aW1lLCBjb3VudGVyLT5jYWNoZS5sYXN0dXNlKSkNCj4g
PiArCQkJdXBkYXRlX2NvdW50ZXJfY2FjaGUoY291bnRlci0+aWQgLSBidWxrX2Jhc2VfaWQsIGRh
dGEsDQo+ID4gKwkJCQkJICAgICAmY291bnRlci0+Y2FjaGUpOw0KPiA+ICAJfQ0KPiA+ICsJeGFz
X3VubG9jaygmeGFzKTsNCj4gPiAgfQ0KPiANCj4gLi4uDQoNCkhpIFNpbW9uLiBPZiBjb3Vyc2Uu
DQoNClRoZSBmaXJzdCBpZiAod2l0aCAndW5saWtlbHknKSBpcyB0aGUgb25lIHRoYXQgc3RhcnRz
IGEgYnVsayBxdWVyeS4NClRoZSBzZWNvbmQgaWYgaXMgdGhlIG9uZSB0aGF0IHVwZGF0ZXMgYSBj
b3VudGVyJ3MgY2FjaGVkIHZhbHVlIHdpdGggdGhlDQpvdXRwdXQgZnJvbSB0aGUgYnVsayBxdWVy
eS4gQnVsa3MgYXJlIHVzdWFsbHkgfjMySyBjb3VudGVycywgaWYgSQ0KcmVtZW1iZXIgY29ycmVj
dGx5LiBJbiBhbnkgY2FzZSwgYSBsYXJnZSBudW1iZXIuDQoNClRoZSBmaXJzdCBpZiBzZXRzIHVw
IHRoZSBidWxrIHF1ZXJ5IHBhcmFtcyBhbmQgZXhlY3V0ZXMgaXQgd2l0aG91dCB0aGUNCmxvY2sg
aGVsZC4gRHVyaW5nIHRoYXQgdGltZSwgY291bnRlcnMgY291bGQgYmUgYWRkZWQvcmVtb3ZlZC4g
V2UgZG9uJ3QNCndhbnQgdG8gdXBkYXRlIGNvdW50ZXIgdmFsdWVzIGZvciBjb3VudGVycyBhZGRl
ZCBiZXR3ZWVuIHdoZW4gdGhlIGJ1bGsNCnF1ZXJ5IHdhcyBleGVjdXRlZCBhbmQgd2hlbiB0aGUg
bG9jayB3YXMgcmVhY3F1aXJlZC4gYnVsa19xdWVyeV90aW1lDQp3aXRoIGppZmZ5IGdyYW51bGFy
aXR5IGlzIHVzZWQgZm9yIHRoYXQgcHVycG9zZS4gV2hlbiBhIGNvdW50ZXIgaXMNCmFkZGVkLCBp
dHMgJ2NhY2hlLmxhc3R1c2UnIGlzIGluaXRpYWxpemVkIHRvIGppZmZpZXMuIE9ubHkgY291bnRl
cnMNCndpdGggaWRzIGJldHdlZW4gW2J1bGtfYmFzZV9pZCwgbGFzdF9idWxrX2lkKSBhZGRlZCBz
dHJpY3RseSBiZWZvcmUgdGhlDQpqaWZmeSB3aGVuIGJ1bGtfcXVlcnlfdGltZSB3YXMgc2V0IHdp
bGwgYmUgdXBkYXRlZCBiZWNhdXNlIHRoZSBodyBtaWdodA0Kbm90IGhhdmUgc2V0IG5ld2VyIGNv
dW50ZXIgdmFsdWVzIGluIHRoZSBidWxrIHJlc3VsdCBhbmQgdmFsdWVzIG1pZ2h0DQpiZSBnYXJi
YWdlLg0KDQpJIGFsc28gaGF2ZSB0aGlzIGJsdXJiIGluIHRoZSBjb21taXQgZGVzY3JpcHRpb24s
IGJ1dCBpdCBpcyBwcm9iYWJseQ0KbG9zdCBpbiB0aGUgd2FsbCBvZiB0ZXh0Og0KIg0KQ291bnRl
cnMgY291bGQgYmUgYWRkZWQvZGVsZXRlZCB3aGlsZSB0aGUgSFcgaXMgcXVlcmllZC4gVGhpcyBp
cyBzYWZlLA0KYXMgdGhlIEhXIEFQSSBzaW1wbHkgcmV0dXJucyB1bmtub3duIHZhbHVlcyBmb3Ig
Y291bnRlcnMgbm90IGluIEhXLCBidXQNCnRob3NlIHZhbHVlcyB3b24ndCBiZSBhY2Nlc3NlZC4g
T25seSBjb3VudGVycyBwcmVzZW50IGluIHhhcnJheSBiZWZvcmUNCmJ1bGsgcXVlcnkgd2lsbCBh
Y3R1YWxseSByZWFkIHF1ZXJpZWQgY2FjaGUgdmFsdWVzLg0KIg0KDQpUaGVyZSdzIGFsc28gYSBj
b21tZW50IGJpdCBpbiB0aGUgIlN5bmNocm9uaXphdGlvbiBub3RlcyIgc2VjdGlvbjoNCiAqIC0g
YnVsayBxdWVyeSAoc2luZ2xlIHRocmVhZCB3b3JrcXVldWUgY29udGV4dCkNCiAqICAgLSBjcmVh
dGU6IHF1ZXJ5IHJlbGllcyBvbiAnbGFzdHVzZScgdG8gYXZvaWQgdXBkYXRpbmcgY291bnRlcnMN
CmFkZGVkDQogKiAgICAgICAgICAgICBhcm91bmQgdGhlIHNhbWUgdGltZSBhcyB0aGUgY3VycmVu
dCBidWxrIGNtZC4NCg0KSG9wZSB0aGlzIGNsZWFycyB0aGluZ3Mgb3V0LCBsZXQgdXMga25vdyBp
ZiB5b3UnZCBsaWtlIHNvbWV0aGluZw0KaW1wcm92ZWQuDQoNCkNvc21pbi4NCg==

