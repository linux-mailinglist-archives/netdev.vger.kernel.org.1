Return-Path: <netdev+bounces-147669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2FC9DAFE9
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 00:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB965B21614
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 23:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29861198E74;
	Wed, 27 Nov 2024 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mm8TaIst"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BDA193432
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732750873; cv=fail; b=Hd8a+5qpQQ/gSBEV0A4+o7Dx0JcOc/C8m/BYlvt90Mu+h7kUoTTv8O8+XA+RM34jm8OZJpqzKl9lOvi9oihInzpQGeltbM5d4tT2dtwSXkYJaCF0WAdAzpc4IaJro8GZ2QJW8abbM+jHf38qB+l1j+4hBMmH0hpTO2+qfZn2/9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732750873; c=relaxed/simple;
	bh=dvTsytVzWdm78E9r2iXVZBW+a8YbHznJZAdppaVZh0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nZGABJRww7VvYji1zPGMPJEbdT7ZK6v2sF5CBV1TFRIIvUsg2Iy1WQAqdyiJKYjIDwSLK39THCSWP+VhpRMcRO5rMj6xYceYM1z5zVcfVGGmRelKyvVMyuQVCfBnbxq6BxCkG7utJ6WR8HdqsDypuwu/VSLjOGJBk19QbV7EALo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mm8TaIst; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZuq2U1Vjl2Hx6EPOdfaLWO29T7ge/q2pOhUHZTUQri0dWrnuDaxRSvNLA3H9L2AkgpLgg1C7/KwyDwaXBXzWfXV67s4XBxwBkUG+jKsJgfnGpgmO2zPlGBS5Fjl7njaGuLrTZNupxLt2qwQArdTJ1BcMyG/+tGgLOaDGl2QFYhXypktHSBJamr+T1Wvd9UkkGVsTER0CDrp/co4u+nv1KeVohfAH5dYC8qt4Ztxczw9nXsqFwqosxP1TJtHr/Kx1v5uRhHysP1yEyK3/DJM76UjGOTk97K8A7z0zHpvnGBbf9ICB9ifASoIoBSIVjTLqMRp8yq8jpTj4msgT2L83g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvTsytVzWdm78E9r2iXVZBW+a8YbHznJZAdppaVZh0A=;
 b=MxF9yB+oV5yf4WCtbLXoQIr28ysjmg50cVzbR0YFPFg9vx1f9KaGJRAiI57+hK/ZAIo59zOCuOWJ/GF+HLhRNhSIzDD92gZXVWuzEw9BMqjNkBYH5/B+QEnVE2ryIsq/WetnFk35kvGlm2yDcJ5POvzIO6lUsg85PfeMRpjXVl9vaXiGIS6hKwzbpf1hDJ16KWsAjAPuVC1vLO3T4pyTKh3CR0wX0HrniiNYCoXd7fp85M2pNdHYHXrWm1RBfQzTNlvS+zpOxn02ZRy9CyIcidyYdcPNq9U5eXct2tMAObcCQEgAw8NCtIof9ABYGxxeH6wHZlmEj3WWXxq90i7j/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvTsytVzWdm78E9r2iXVZBW+a8YbHznJZAdppaVZh0A=;
 b=mm8TaIstV5WuxajSSHaFm5gQrSCd2/b96jBFqqb2FDdXI9E6rn+vHvq3JR6Rc152I9na9CnXbCGK1u51O6Ooqw7cWfDOyEZRb7SFL50a2Vu+D8KJAiXm7SX6breK6UMxy86IzpXRVNsMXLfOYZU0AYMe06sNpgJd8qWWg42zAMia0QhBCxz8oB2BP9fFc7Q+sEpRaf3FODvGT9p8bHXhrQPIhgqZL8GafbP5pu18I8WhNbjbhOx8tGSAo4Omn7A39iuu/j0Ng25w8BM0fW4m5id28NAE3RKy9SB23Gw+7NjQtcFz5MeJD7mV7SuyRd3JqrzGEQnEG/+LDcNFomIHUA==
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 23:41:07 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%6]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 23:41:07 +0000
From: Yong Wang <yongwang@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu
	<roopa@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Andy Roulin <aroulin@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Nikhil
 Dhar <ndhar@nvidia.com>
Subject: Re: [RFC net-next 2/2] net: bridge: multicast: update multicast
 contex when vlan state gets changed
Thread-Topic: [RFC net-next 2/2] net: bridge: multicast: update multicast
 contex when vlan state gets changed
Thread-Index: AQHbQErrNYck9s12VU+5icPF8fybNrLLQOuAgAAECgA=
Date: Wed, 27 Nov 2024 23:41:07 +0000
Message-ID: <546ADA5B-12D3-442A-A423-830DD9D68545@nvidia.com>
References: <20241126213401.3211801-1-yongwang@nvidia.com>
 <20241126213401.3211801-3-yongwang@nvidia.com>
 <4522c622-3e77-4191-8af6-f0ee8cd9061e@blackwall.org>
In-Reply-To: <4522c622-3e77-4191-8af6-f0ee8cd9061e@blackwall.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4858:EE_|LV8PR12MB9271:EE_
x-ms-office365-filtering-correlation-id: f7507d0b-f7d9-407f-068b-08dd0f3cf6e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzFBcGt5OXc2cUxMR0ZoSDlDeGZUbG1xSGZzaFNWQzJqK2h2Wm9NbGZOUFBC?=
 =?utf-8?B?MTd6M21WV2g2SW9TcjVkc0RHMEUxZjNMcnR4OEYrR2dQajN5c2VmcnNacVhi?=
 =?utf-8?B?Y3F0RTJlQzJTOS9OOVFxTkUwRDlZUkR4eGU5T1ZtNGpRYmRvVFBYeTdBVVQ2?=
 =?utf-8?B?TldzUTVVMndqSVpqUHc5eExmWmlCbjVKQWM0cEgyTlc0SWNwUGp5ZllLamlk?=
 =?utf-8?B?QWNBRHUrWFZ6WDkxdlV6bEJlNEg4ME1QemVKcmd0eDIwMUYrVlNyL3Y3VDlu?=
 =?utf-8?B?VmVGeEV0VE05bUF1amZiRnBaWWZZamxpNU5ic00zUTZjRVNYMDQ1U2pKUk8z?=
 =?utf-8?B?NkxkZmtMS1lTemZHVk1hYVJ5Y2l2TnhKeUUzR1dXazFrU3d1bWg4OVJzalhw?=
 =?utf-8?B?bDJ5ckJMYkF1RnRiMVc2eUlDRzA3VGpURXhFTEhhOHlJSllnMjM1WlpTNWRT?=
 =?utf-8?B?T2dDQTY3SFExSTAyMllvZXgyNUhrYWR4UjF0SlNGbnYzcU9adGlDc1U5UkhI?=
 =?utf-8?B?ZUF3ZjNJaDExUEZ4eVZHV0RLaEZiNmlCSmVqWk1iNUNSMGlKbXhvdkZuUHNu?=
 =?utf-8?B?ci9zNXcxRElZU3F5TzRCNm9ySkpRcXI1ekd5aDc1aG9tMVFCMDBNNDlRNitv?=
 =?utf-8?B?Q29ISWZISm5HbWpUTFpVdTJzb3lWY2lMdFBBZXE0NHZqTDN6Tkhxd214L0hI?=
 =?utf-8?B?a1NBYmI1Z2hmVEhIUXRMemFsN0tNTDBtSVpVVGxnRlkxZ3htOFVFNDU0dVA0?=
 =?utf-8?B?QzNmSmlYZkQ5K2N3Z3RGalFrYVA1SHJpSUtqdlAwMUdUbGlGZWN4VEpvY3Q5?=
 =?utf-8?B?c2pwaVZkeUVTT1RaMnZ0YjBiZDM5b2VMZ3QyMGN3VGk4NHByK1N4NDRKVG1X?=
 =?utf-8?B?aTRJTlk3SWlJdnJYVXBTQmIyb0ZiYnNrSFBNQURHUTNjWHd5WlJ0cTF5eVRD?=
 =?utf-8?B?akl3WHBYV3JhajcwWkNFVGNxeUdJSHVkYjEzeklwNDlubVNLVThEZ0wxTith?=
 =?utf-8?B?TXF0VjlDdXVYSjNnWUVEWEFJS1c3Y2hZbnBUUkxWWWF4bmoxeHJ5ViszOHFx?=
 =?utf-8?B?bVdTakYvUm5keElTNlNWdThGL3pCZ1o2QUVFRXpObS80T2ExVThIbWdDMUgy?=
 =?utf-8?B?ZEk2NGRVSkFITkRmZ2FYaWpNTGF5dTNnSmhOS3IxbnRFUUxOYmUrdmNwcDdU?=
 =?utf-8?B?aFlQWS9VRkFad1JtZzBtMzloK1NQSVdsU3N1NjFCS3hoT1BFNmUwaHRsRXdx?=
 =?utf-8?B?cGFxTEJyN09pNUFwWXBpSmVVcWMrRmJsdDZ3Q2hyNWY4OVZlSC9ELy9tMHFU?=
 =?utf-8?B?UDNFaTUyd1liMStCZktnSllCYkU1UDgyVStiWkFXMUdDYWJmVHlwbmYzcXU1?=
 =?utf-8?B?WDFHY1lwV0VFL0I1WUNlb1d2K2ZrQm1wWGdmYlZBazlpRXZyYXlBN2JzNjVn?=
 =?utf-8?B?cmdIT0ZqZWZxeG5CWmJiYmtDdkhnOERVdnhOZmY2MmpOMlBlYkREeGJVRVc3?=
 =?utf-8?B?WjBoUDBNVFNPOUtQRWdSbnd3eTlhRUJyT1Exd3BRQTBjS0pjY0UrZk11TDFG?=
 =?utf-8?B?Wm9LckRpMmR0dytqUWQ3RFNITzEvdzFlaUxVUmpWN2k4YWhoNkUybXgxcS9z?=
 =?utf-8?B?bGdXR0tKK1VrM2p5N1A4bXVGaU1ZaFNOdnU4T3MwQ296OTVMRWhOZ1hTUFNL?=
 =?utf-8?B?R3FxOVYrT0ZDc0FNR3JUZmlrdUhDWE51SHJvN0Z0ZkI5bGd5MlAvOWNEbmZH?=
 =?utf-8?B?WVNlNUsyUVBOckQ4dEhadkFTSnhlV3N3VExvODBIdnFYVy9qTHdDYTVXUEI5?=
 =?utf-8?B?UW1tK2ZlN2JCbGdVU2wwWHNqSTdNeEJzaXNxMER5SmZ5V1VTeEs2ZE5ycFl3?=
 =?utf-8?B?OEJpYU5Jc21JQ1BUWXZLRjhHVmJzcFpORzJaNTNBNkgvbUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGsxNXZ3b01XeUlmSi9IRythcllLNlBsalJ1MmIxRktSMjl4aHhEaTMrTE1B?=
 =?utf-8?B?enlqM1VFY0plSTdkcWs2dm5TNll1cnZLOGliSmdKNGdEY3V0ajIxbWFQUFZO?=
 =?utf-8?B?LzY1RHR0WW1hRVo1aTArMWRzYU01d2laekFCNyt3MDAxSzFjTUU2TWxJSHZX?=
 =?utf-8?B?emdVUWxjeEJOSHpKWEF2eGZBVnQzUCtnOHJScWtxYjdVWElVb1d5MjBMR1dH?=
 =?utf-8?B?R3pGd2VsUEszRUZLY1R4eWU1Um1WQkk1ZXJMRXl3bmhiSmZGOEtHSFJVMWdJ?=
 =?utf-8?B?Tkl6dHU3U0k5cytwRXdBY3VTQmpwVWF3YU9ObXZYbUlGUjYyUmtXOXdWZUho?=
 =?utf-8?B?Y1pPeXRVd2lTOHdUcFRvczFUdGp1NUx5NWdWWEczTGNYTzNPRzVyazZsMDJW?=
 =?utf-8?B?KzhFNlNCVzJ0UlA0bWpacVJnYmpmRk5ObUtkeVJwQzZpVVlyUUZhdWgwbkFI?=
 =?utf-8?B?R0pRMVNrRWJ2M2dobnRKVDZXT0YrRTdHejByQUR6RG80YjhPaFY3WHhFbFgz?=
 =?utf-8?B?Qng2Wnc3M0lVdHhzam1mNkxIMkRGaFU1OG05aExlZjFDeW1PQ1NCZGJGWEU5?=
 =?utf-8?B?N3o5TnNxUUlsektkSTJ6dlpFT1d3WU50WmZWWWJ0TU5xWk0rcTlKbkhKcTZz?=
 =?utf-8?B?b2I1WUF6S01XUmFaZzc1M3JJWTllUkN4bEM3am9ScHlMUU13YVJIYysxeWtQ?=
 =?utf-8?B?NnhpbFplS0NiNjdtY1gxVEhKUGZvR2U3NmJvRmNJSlNaNHJScVc0c3NpcC9z?=
 =?utf-8?B?UTFiT3gySm1NeGQ2cm82M1JoaEFtVmppTmUreFdsR3cvL0dpMGRPZ2hKaFZh?=
 =?utf-8?B?alBMNWV6QUYza3NrZzNOYk4xdThHb0RPaTM3TmRoWlZ6Z0FGNUVsVmd1dXVT?=
 =?utf-8?B?WkZyK0FhbGYzenR0aENmVEhSQW9zenNTVEkzSVh5cnA0Q3o1K3NwR09aMGZ3?=
 =?utf-8?B?T01FaTE1cjliMk9vbkgzNm9rY1ZJRVprbnVzdzUxU0pmZ2tEZFRWa0dlRStz?=
 =?utf-8?B?a0lHREpHaUMvWXRKMVpnYTZxSHRtYm5qTVY5T0lUT2NDajlRY05sWitJOWth?=
 =?utf-8?B?L3VKMmRIRXRJMGYyYnN2aG1YVC9vT2Vmbi84YmFCSkxaOWZBM2psUlRjWkdw?=
 =?utf-8?B?NDhNMHpxYms3TGxObER0Yk4veUhQeHZHbkdYaWs3VU92dWN3RDJZc25YS0Iz?=
 =?utf-8?B?Q2czTTVMRlpjTVpmUmhmc2R2WUVZUXNrMVFGMkxyNE9iSkZpRXg2WTRhOHdC?=
 =?utf-8?B?aFRlY3g3Wk5XS2JZbmVWUjIvSHN0T2dWMEJreG53bUUxZFBHWHg0eFZ4T00v?=
 =?utf-8?B?QXpOWmRxTXJTMlJCUkdCZy9palhxU2c5MGd5ZFZLRWdDK1I2NmphRmdPQXEz?=
 =?utf-8?B?THJtWHVSbktxY1ZFazRXa1MzaVNSZ0xBMXJjVVRKNEdxR1g1bzcwcWk1RzQr?=
 =?utf-8?B?VjVCQk5ybTVNdCszSCtGVU5tZG5IbEk0T3Zod2hSUERDcmN1VVRRVXFIYzlv?=
 =?utf-8?B?STBkZ3lBclVuSjhXVmRYZUJGZUR2T3BSdURCU09ORGlod3lFNDBQZ1BybXRl?=
 =?utf-8?B?dXdHZ2FKdW9JUWl1SFBKSTZQOXprbGFQWWVic0wyaHdsbXV2aTN5T1hZWWJ2?=
 =?utf-8?B?T28rYWxrQUVoMS9qbkxVQTVUYUJhaFE2a2ZkTUtmeGNBK3NvUFpHaEJxU21k?=
 =?utf-8?B?WnN6VkVsdkJncXhaL1QxSDdsSllQcDBtSEpueThPTTBqSEY1RG9QOXdZRmsw?=
 =?utf-8?B?K1hFVVBydlNFUFBjdDlxY2l0U1pBL1VndWVhdjJzcE8rYzNwdEVLWDFPN3Fs?=
 =?utf-8?B?eTF4MFVZdFZXNEMvd0VKVTdmT1pIaUxBTHR2ck1YVVQxcndUQXMySGxFd3NE?=
 =?utf-8?B?YnZpNkt0TEpIeUVyclJsZW1zN1VXWTZUelZiZTVKVC9pMWlpekQ4eVhud3pB?=
 =?utf-8?B?bFZKWHlEUENFVHFYdGhIRTJjV2RRVldwUi9JM2wralppZFJyeEpZSjVUemxH?=
 =?utf-8?B?U3JrWlNpWXBKVTNjZC8zUTBnYnJBemxxL0g5S2t4V3hnTDN0LzlZdVVicWda?=
 =?utf-8?B?N2RXZzdLSytqNDFLT0QzTStrcEZZbnF6SUhneUtYUDlpTDNJQ0ZSOTgrMGlL?=
 =?utf-8?B?Wk9CRUJLcXdFTTZzMTE5cFJPSEZoWHpJQml5SDdyTGZhVzBJYTRQNFFEQU05?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBCC9FB99F6CF743A7D3E011EABECF27@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7507d0b-f7d9-407f-068b-08dd0f3cf6e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 23:41:07.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAQGbAf7woLMcycQhUuyL/y0JskeQkjE/6fT6xh8lhz0nW4capRAjCQK9N52R8WLZr8T4CZYli4FNgVRn4jtxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271

DQpPbiAxMS8yNy8yNCwgNzoyNiBBTSwgIk5pa29sYXkgQWxla3NhbmRyb3YiIDxyYXpvckBibGFj
a3dhbGwub3JnPiB3cm90ZToNCg0KPk9uIDI2LzExLzIwMjQgMjM6MzQsIFlvbmcgV2FuZyB3cm90
ZToNCj4+IEFkZCBicl92bGFuX3NldF9zdGF0ZV9maW5pc2goKSBoZWxwZXIgZnVuY3Rpb24gdG8g
YmUgZXhlY3V0ZWQgcmlnaHQgYWZ0ZXINCj4+IGJyX3ZsYW5fc2V0X3N0YXRlKCkgd2hlbiB2bGFu
IHN0YXRlIGdldHMgY2hhbmdlZCwgc2ltaWxhciB0byBwb3J0IHN0YXRlLA0KPj4gdmxhbiBzdGF0
ZSBjb3VsZCBpbXBhY3QgbXVsdGljYXN0IGJlaGF2aW9ycyBhcyB3ZWxsIHN1Y2ggYXMgaWdtcCBx
dWVyeS4NCj4+IFdoZW4gYnJpZGdlIGlzIHJ1bm5pbmcgd2l0aCB1c2Vyc3BhY2UgU1RQLCB2bGFu
IHN0YXRlIGNhbiBiZSBtYW5pcHVsYXRlZCBieQ0KPj4gImJyaWRnZSB2bGFuIiBjb21tYW5kcy4g
VXBkYXRpbmcgdGhlIGNvcnJlc3BvbmRpbmcgbXVsdGljYXN0IGNvbnRleHQNCj4+IHdpbGwgZW5z
dXJlIHRoZSBwb3J0IHF1ZXJ5IHRpbWVyIHRvIGNvbnRpbnVlIHdoZW4gdmxhbiBzdGF0ZSBnZXRz
IGNoYW5nZWQNCj4+IHRvIHRob3NlICJhbGxvd2VkIiBzdGF0ZXMgbGlrZSAiZm9yd2FyZGluZyIg
ZXRjLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV2FuZyA8eW9uZ3dhbmdAbnZpZGlhLmNv
bT4NCj4+IFJldmlld2VkLWJ5OiBBbmR5IFJvdWxpbiA8YXJvdWxpbkBudmlkaWEuY29tPg0KPj4g
LS0tDQo+PiAgbmV0L2JyaWRnZS9icl9tc3QuYyAgICAgICAgICB8ICA1ICsrKy0tDQo+PiAgbmV0
L2JyaWRnZS9icl9tdWx0aWNhc3QuYyAgICB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPj4gIG5l
dC9icmlkZ2UvYnJfcHJpdmF0ZS5oICAgICAgfCAxMSArKysrKysrKysrKw0KPj4gIG5ldC9icmlk
Z2UvYnJfdmxhbl9vcHRpb25zLmMgfCAgMiArKw0KPj4gIDQgZmlsZXMgY2hhbmdlZCwgMzQgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+DQo+QSBmZXcgY29tbWVudHMgYmVsb3cs
DQoNClRoYW5rIHlvdSBzbyBtdWNoIGZvciBwcm92aWRpbmcgdGhlc2UgY29tbWVudHMuDQoNCj4N
Cj4+IGRpZmYgLS1naXQgYS9uZXQvYnJpZGdlL2JyX21zdC5jIGIvbmV0L2JyaWRnZS9icl9tc3Qu
Yw0KPj4gaW5kZXggMTgyMGYwOWZmNTljLi5iNzdjMzFhMjQyNTcgMTAwNjQ0DQo+PiAtLS0gYS9u
ZXQvYnJpZGdlL2JyX21zdC5jDQo+PiArKysgYi9uZXQvYnJpZGdlL2JyX21zdC5jDQo+PiBAQCAt
ODAsMTAgKzgwLDExIEBAIHN0YXRpYyB2b2lkIGJyX21zdF92bGFuX3NldF9zdGF0ZShzdHJ1Y3Qg
bmV0X2JyaWRnZV92bGFuX2dyb3VwICp2ZywNCj4+ICAgICAgIGlmIChicl92bGFuX2dldF9zdGF0
ZSh2KSA9PSBzdGF0ZSkNCj4+ICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4NCj4+IC0gICAgIGJy
X3ZsYW5fc2V0X3N0YXRlKHYsIHN0YXRlKTsNCj4+IC0NCj4+ICAgICAgIGlmICh2LT52aWQgPT0g
dmctPnB2aWQpDQo+PiAgICAgICAgICAgICAgIGJyX3ZsYW5fc2V0X3B2aWRfc3RhdGUodmcsIHN0
YXRlKTsNCj4+ICsNCj4+ICsgICAgIGJyX3ZsYW5fc2V0X3N0YXRlKHYsIHN0YXRlKTsNCj4+ICsg
ICAgIGJyX3ZsYW5fc2V0X3N0YXRlX2ZpbmlzaCh2LCBzdGF0ZSk7DQo+DQo+VGhpcyBzdGF0ZV9m
aW5pc2ggZnVuY3Rpb24gaXMgY2FsbGVkIGFmdGVyIGV2ZXJ5IGluc3RhbmNlIG9mIGJyX3ZsYW5f
c2V0X3N0YXRlKCksDQo+anVzdCBhZGQgdGhhdCBjYWxsIHRvIGJyX3ZsYW5fc2V0X3N0YXRlLg0K
DQpNb3ZpbmcgdGhlIGltcGxlbWVudGF0aW9uIGxvZ2ljIGludG8gYnJfdmxhbl9zZXRfc3RhdGUo
KSBzb3VuZHMgZ29vZCB0byBtZSwgd2hpbGUNCnRoZSB1c2VyIG9mIGJyX3ZsYW5fc2V0X3N0YXRl
KCkgc2hvdWxkIGJlIGF3YXJlIG9mIHRoZSBsb2NrIHVzYWdlIGluc3RlYWQgb2YgDQp0aGUgYW5u
b3RhdGVkIGxvY2stZnJlZSBhY2Nlc3MuDQoNCj4NCj4+ICB9DQo+Pg0KPj4gIGludCBicl9tc3Rf
c2V0X3N0YXRlKHN0cnVjdCBuZXRfYnJpZGdlX3BvcnQgKnAsIHUxNiBtc3RpLCB1OCBzdGF0ZSwN
Cj4+IGRpZmYgLS1naXQgYS9uZXQvYnJpZGdlL2JyX211bHRpY2FzdC5jIGIvbmV0L2JyaWRnZS9i
cl9tdWx0aWNhc3QuYw0KPj4gaW5kZXggOGIyM2IwZGM2MTI5Li4zYTNiNjNjOTdjOTIgMTAwNjQ0
DQo+PiAtLS0gYS9uZXQvYnJpZGdlL2JyX211bHRpY2FzdC5jDQo+PiArKysgYi9uZXQvYnJpZGdl
L2JyX211bHRpY2FzdC5jDQo+PiBAQCAtNDI3MCw2ICs0MjcwLDI0IEBAIHN0YXRpYyB2b2lkIF9f
YnJfbXVsdGljYXN0X3N0b3Aoc3RydWN0IG5ldF9icmlkZ2VfbWNhc3QgKmJybWN0eCkNCj4+ICAj
ZW5kaWYNCj4+ICB9DQo+Pg0KPj4gK3ZvaWQgYnJfbXVsdGljYXN0X3VwZGF0ZV92bGFuX21jYXN0
X2N0eChzdHJ1Y3QgbmV0X2JyaWRnZV92bGFuICp2LCB1OCBzdGF0ZSkNCj4+ICt7DQo+PiArICAg
ICBzdHJ1Y3QgbmV0X2JyaWRnZSAqYnI7DQo+PiArDQo+PiArICAgICBpZiAoIWJyX3ZsYW5fc2hv
dWxkX3VzZSh2KSkNCj4+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPj4gKw0KPj4gKyAgICAgaWYg
KGJyX3ZsYW5faXNfbWFzdGVyKHYpKQ0KPj4gKyAgICAgICAgICAgICByZXR1cm47DQo+PiArDQo+
PiArICAgICBiciA9IHYtPnBvcnQtPmJyOw0KPj4gKw0KPj4gKyAgICAgaWYgKGJyX3ZsYW5fc3Rh
dGVfYWxsb3dlZChzdGF0ZSwgdHJ1ZSkgJiYNCj4+ICsgICAgICAgICAodi0+cHJpdl9mbGFncyAm
IEJSX1ZMRkxBR19NQ0FTVF9FTkFCTEVEKSAmJg0KPg0KPmNoZWNraW5nIHRoaXMgZmxhZyB3aXRo
b3V0IG1jYXN0IGxvY2sgaXMgcmFjeS4NCg0KQUNLLg0KDQo+DQo+PiArICAgICAgICAgYnJfb3B0
X2dldChiciwgQlJPUFRfTUNBU1RfVkxBTl9TTk9PUElOR19FTkFCTEVEKSkNCj4NCj50aGlzIHNo
b3VsZCBiZSB0aGUgZmlyc3QgY2hlY2sNCg0KQUNLLg0KDQo+DQo+PiArICAgICAgICAgICAgIGJy
X211bHRpY2FzdF9lbmFibGVfcG9ydF9jdHgoJnYtPnBvcnRfbWNhc3RfY3R4KTsNCj4NCj5XaGF0
IGFib3V0IGRpc2FibGU/IFdoYXQgaWYgdGhlIHN0YXRlIGlzICE9IExFQVJOSU5HL0ZPUldBUkRJ
TkcgPw0KDQpJbiBjYXNlIG9mIHRoZSBzdGF0ZSBpcyBESVNBQkxFRC9CTE9DS0lORywgYnJfbXVs
dGljYXN0X3BvcnRfcXVlcnlfZXhwaXJlZCgpIHRpbWVyIGhhbmRsZXJzDQp3aWxsIGRpcy1jb250
aW51ZSBhZnRlciBjaGVja2luZyB0aGUgcG9ydCBhbmQgdmxhbiBzdGF0ZXMgdmlhIGNhbGxpbmcg
DQpicl9tdWx0aWNhc3RfcG9ydF9jdHhfc3RhdGVfc3RvcHBlZCgpLCBzdG9wIGJ5IHRoZW1zZWx2
ZXMuIA0KDQpUaGUgY29tbWVudCBpbnNpZGUgYnJfcG9ydF9zdGF0ZV9zZWxlY3Rpb24oKSByaWdo
dCBhZnRlciBjYWxsaW5nIGJyX211bHRpY2FzdF9lbmFibGVfcG9ydCgpDQpleHBsYWlucyB0aGVy
ZSdzIG5vIG5lZWQgdG8gY2FsbCBkaXNhYmxlIGZ1bmN0aW9uIHNwZWNpZmljYWxseS4NClJlZmVy
IHRvIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjEyLjEvc291cmNlL25ldC9i
cmlkZ2UvYnJfc3RwLmMjTDQ5Nw0KDQpJIHRoaW5rLCBpdCdzIGJldHRlciB0byBhZGQgc2ltaWxh
ciBjb21tZW50IGhlcmUgYXMgd2VsbC4NCg0KSW4gY2FzZSBvZiBMSVNURU5JTkcsIGtlZXAgbXVs
dGljYXN0IGN0eCB1bnRvdWNoZWQuDQoNClBsZWFzZSBjb3JyZWN0IG1lIGlmIEkgbWlzcyBhbnl0
aGluZy4NCg0KPg0KPj4gK30NCj4+ICsNCj4+ICB2b2lkIGJyX211bHRpY2FzdF90b2dnbGVfb25l
X3ZsYW4oc3RydWN0IG5ldF9icmlkZ2VfdmxhbiAqdmxhbiwgYm9vbCBvbikNCj4+ICB7DQo+PiAg
ICAgICBzdHJ1Y3QgbmV0X2JyaWRnZSAqYnI7DQo+PiBkaWZmIC0tZ2l0IGEvbmV0L2JyaWRnZS9i
cl9wcml2YXRlLmggYi9uZXQvYnJpZGdlL2JyX3ByaXZhdGUuaA0KPj4gaW5kZXggOTg1M2NmYmI5
ZDE0Li45YzcyMDcwOTU2ZTMgMTAwNjQ0DQo+PiAtLS0gYS9uZXQvYnJpZGdlL2JyX3ByaXZhdGUu
aA0KPj4gKysrIGIvbmV0L2JyaWRnZS9icl9wcml2YXRlLmgNCj4+IEBAIC0xMDUyLDYgKzEwNTIs
NyBAQCB2b2lkIGJyX211bHRpY2FzdF9wb3J0X2N0eF9pbml0KHN0cnVjdCBuZXRfYnJpZGdlX3Bv
cnQgKnBvcnQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbmV0X2Jy
aWRnZV92bGFuICp2bGFuLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IG5ldF9icmlkZ2VfbWNhc3RfcG9ydCAqcG1jdHgpOw0KPj4gIHZvaWQgYnJfbXVsdGljYXN0X3Bv
cnRfY3R4X2RlaW5pdChzdHJ1Y3QgbmV0X2JyaWRnZV9tY2FzdF9wb3J0ICpwbWN0eCk7DQo+PiAr
dm9pZCBicl9tdWx0aWNhc3RfdXBkYXRlX3ZsYW5fbWNhc3RfY3R4KHN0cnVjdCBuZXRfYnJpZGdl
X3ZsYW4gKnYsIHU4IHN0YXRlKTsNCj4+ICB2b2lkIGJyX211bHRpY2FzdF90b2dnbGVfb25lX3Zs
YW4oc3RydWN0IG5ldF9icmlkZ2VfdmxhbiAqdmxhbiwgYm9vbCBvbik7DQo+PiAgaW50IGJyX211
bHRpY2FzdF90b2dnbGVfdmxhbl9zbm9vcGluZyhzdHJ1Y3QgbmV0X2JyaWRnZSAqYnIsIGJvb2wg
b24sDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbmV0bGlu
a19leHRfYWNrICpleHRhY2spOw0KPj4gQEAgLTE1MDIsNiArMTUwMywxMCBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgYnJfbXVsdGljYXN0X3BvcnRfY3R4X2RlaW5pdChzdHJ1Y3QgbmV0X2JyaWRnZV9t
Y2FzdF9wb3J0ICpwbQ0KPj4gIHsNCj4+ICB9DQo+Pg0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBi
cl9tdWx0aWNhc3RfdXBkYXRlX3ZsYW5fbWNhc3RfY3R4KHN0cnVjdCBuZXRfYnJpZGdlX3ZsYW4g
KnYsIHU4IHN0YXRlKQ0KPj4gK3sNCj4+ICt9DQo+PiArDQo+PiAgc3RhdGljIGlubGluZSB2b2lk
IGJyX211bHRpY2FzdF90b2dnbGVfb25lX3ZsYW4oc3RydWN0IG5ldF9icmlkZ2VfdmxhbiAqdmxh
biwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29s
IG9uKQ0KPj4gIHsNCj4+IEBAIC0xODUzLDYgKzE4NTgsMTIgQEAgYm9vbCBicl92bGFuX2dsb2Jh
bF9vcHRzX2Nhbl9lbnRlcl9yYW5nZShjb25zdCBzdHJ1Y3QgbmV0X2JyaWRnZV92bGFuICp2X2N1
cnIsDQo+PiAgYm9vbCBicl92bGFuX2dsb2JhbF9vcHRzX2ZpbGwoc3RydWN0IHNrX2J1ZmYgKnNr
YiwgdTE2IHZpZCwgdTE2IHZpZF9yYW5nZSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCBzdHJ1Y3QgbmV0X2JyaWRnZV92bGFuICp2X29wdHMpOw0KPj4NCj4+ICsvKiBoZWxw
ZXIgZnVuY3Rpb24gdG8gYmUgY2FsbGVkIHJpZ2h0IGFmdGVyIGJyX3ZsYW5fc2V0X3N0YXRlKCkg
d2hlbiB2bGFuIHN0YXRlIGdldHMgY2hhbmdlZCAqLw0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBi
cl92bGFuX3NldF9zdGF0ZV9maW5pc2goc3RydWN0IG5ldF9icmlkZ2VfdmxhbiAqdiwgdTggc3Rh
dGUpDQo+PiArew0KPg0KPkEgb25lIGxpbmUgaGVscGVyIHRoYXQgZGlyZWN0bHkgY2FsbHMgYW5v
dGhlciBmdW5jdGlvbiBpcyBub3QgaGVscGluZyBhbnl0aGluZy4NCj5QbGVhc2UganVzdCBjYWxs
IHRoYXQgZnVuY3Rpb24gZGlyZWN0bHkgYW5kIHJlbW92ZSB0aGUgaGVscGVyLg0KDQpXZSBjYW4g
ZGVmaW5pdGVseSBtb3ZlIHRoaXMgZnVuY3Rpb24gaW5zaWRlIGJyX3ZsYW5fc2V0X3N0YXRlKCkg
YnkgcmVtb3ZpbmcgYnJfdmxhbl9zZXRfc3RhdGVfZmluaXNoKCkuIA0KDQo+DQo+PiArICAgICBi
cl9tdWx0aWNhc3RfdXBkYXRlX3ZsYW5fbWNhc3RfY3R4KHYsIHN0YXRlKTsNCj4+ICt9DQo+PiAr
DQo+PiAgLyogdmxhbiBzdGF0ZSBtYW5pcHVsYXRpb24gaGVscGVycyB1c2luZyAqX09OQ0UgdG8g
YW5ub3RhdGUgbG9jay1mcmVlIGFjY2VzcyAqLw0KPj4gIHN0YXRpYyBpbmxpbmUgdTggYnJfdmxh
bl9nZXRfc3RhdGUoY29uc3Qgc3RydWN0IG5ldF9icmlkZ2VfdmxhbiAqdikNCj4+ICB7DQo+PiBk
aWZmIC0tZ2l0IGEvbmV0L2JyaWRnZS9icl92bGFuX29wdGlvbnMuYyBiL25ldC9icmlkZ2UvYnJf
dmxhbl9vcHRpb25zLmMNCj4+IGluZGV4IDhmYTg5YjA0ZWU5NC4uYmFkMTg3YzRmMTZkIDEwMDY0
NA0KPj4gLS0tIGEvbmV0L2JyaWRnZS9icl92bGFuX29wdGlvbnMuYw0KPj4gKysrIGIvbmV0L2Jy
aWRnZS9icl92bGFuX29wdGlvbnMuYw0KPj4gQEAgLTEyMyw2ICsxMjMsOCBAQCBzdGF0aWMgaW50
IGJyX3ZsYW5fbW9kaWZ5X3N0YXRlKHN0cnVjdCBuZXRfYnJpZGdlX3ZsYW5fZ3JvdXAgKnZnLA0K
Pj4gICAgICAgICAgICAgICBicl92bGFuX3NldF9wdmlkX3N0YXRlKHZnLCBzdGF0ZSk7DQo+Pg0K
Pj4gICAgICAgYnJfdmxhbl9zZXRfc3RhdGUodiwgc3RhdGUpOw0KPj4gKyAgICAgYnJfdmxhbl9z
ZXRfc3RhdGVfZmluaXNoKHYsIHN0YXRlKTsNCj4+ICsNCj4+ICAgICAgICpjaGFuZ2VkID0gdHJ1
ZTsNCj4+DQo+PiAgICAgICByZXR1cm4gMDsNCg0KDQoNCg0K

