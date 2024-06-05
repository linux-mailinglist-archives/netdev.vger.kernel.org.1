Return-Path: <netdev+bounces-101094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FB18FD469
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34220B2386D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0091194AED;
	Wed,  5 Jun 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R+n8pI38"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9BE194AEC
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610129; cv=fail; b=OnpX7COWhFjoBdF6LRsR27R8d7f7SpBX5Hn9UiaVafEafaEWPToH7MtqH/6VASI1z9d361HGdVDUJ670LKbbUPKdE2wnZgii1NfJo/a2wlEiXXRxbeQf4RuXXxr/nl7iBghJ++T/yNxApCKGLAONFT4Cy6LdZxRYVjpHtY2YDZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610129; c=relaxed/simple;
	bh=k8I3GcuKqwyeK24T51c+xNJeSlr60Z5xtWcXm3vQDtk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+tO4AqNWxxg9pVdtY3TuPA3SKJGp6qvOUldSJ18TfNaNqewQK0eJz9TzvGMDB4opWJLmMQAXXWi3sCmjHercpRfsyE8z9ooze/k++ZILmuMSxIImobqO0D5hzrpTUoLJPPf8xp9GgCOx3pzQpG4urvkUQkTv1BGDyEFZg6SDc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R+n8pI38; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM0cFD/yEgmgI9dmsl8jLTMUfhdwIlVQk4G5hAcXCpuF7zGY/7DYkpXIWzn+vco5HF98/jSDz0dqnfI1UxtRjSfakrX8S8ZnY04+X61PvbBVAIEMJQgimO7fmNKUDEjJuIGcT9W8HHaC/z1UAKYJzW+h+Nq518RPROka96REMZZp9x5wQgY5QM4X3/rCRd9zRMwEXqDjUWoMozAY1CJXcTolSILUlQ3RDutRqyNjK7JAMxVKyK+U4fhWdpJQ6HN1DECA8U6y1+q087iQ2axnUjbG7ks7TYql3dyn2Z3s9SYF5XjNTjiMIsGkBHfx43g0e0QenmUChHl7+hduNmpbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8I3GcuKqwyeK24T51c+xNJeSlr60Z5xtWcXm3vQDtk=;
 b=ajH/5Gb/WE1XoxN5ClE1sV17pP934gYKPVFXg207tWTWnjLWihTqtlOv+SPjRgIuxQSaqBfHMh5N8A88Nl8oJ9JgZsF4lrnnQbFAVNWbfoVeLbKTCKTnM/4B8pMulECm7P+sAQb3zcPsj4KFSeCJH/EhHaHCIydN1lreeGtjjypIkd8Cvnbp1KTEX72hLq6vsmctImvcV04A+V8uYUtyYcsuYBsjAARsGIo1jNaGp9l4AAxFh34pm0CRQavR54ja9OsYsZwE1N5qKW4xlAuaV0PgEQy/GVywad3mOOzg09H+wTU5Nze8MX10Mr8c4wm0cBOQ7JnkeCz3bxJ5T9OysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8I3GcuKqwyeK24T51c+xNJeSlr60Z5xtWcXm3vQDtk=;
 b=R+n8pI38OgzcmZGw9/JmOtXYUzS2c+mQOH9RmAC4zWH2BGQv/cqRLORNFLShtue8XZNTROuH8YhA7zerwzLXDADSfKoVdA8A+apM48dWGZTLnulbiLdLmQc2iHdfOpgEgeN6Soa0WTDKuMa3E1NRh/GU7q2HJ1+0ClaQPf8HWGximLncIkm0LAHsHwUO0KxNfJYKekrekbkjzAymcUnH0Ie5SNWn7LyvOWBh6cclJAHRNoHehaRNsSqB4Tus65xOpjenaJ+F40cwF/fWqXZoNwn6d66aMkVZ3YXPYFVmSfnuAVfD3rwNBuJC3q2wZj6HIPrB/4koWo+Vs9OhdDnyNw==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32; Wed, 5 Jun
 2024 17:55:25 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 17:55:25 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "horms@kernel.org" <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Yoray Zack
	<yorayz@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next 08/15] net/mlx5e: SHAMPO, Skipping on duplicate
 flush of the same SHAMPO SKB
Thread-Topic: [PATCH net-next 08/15] net/mlx5e: SHAMPO, Skipping on duplicate
 flush of the same SHAMPO SKB
Thread-Index: AQHasQuiNEDDrrGTU0qzbG4dZCXEg7G5O/mAgABFA4A=
Date: Wed, 5 Jun 2024 17:55:24 +0000
Message-ID: <9957a6c3740e76c61b979038c6e984f9987bbd4c.camel@nvidia.com>
References: <20240528142807.903965-1-tariqt@nvidia.com>
	 <20240528142807.903965-9-tariqt@nvidia.com>
	 <20240605134823.GK791188@kernel.org>
In-Reply-To: <20240605134823.GK791188@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.1 (3.52.1-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|DM6PR12MB4073:EE_
x-ms-office365-filtering-correlation-id: 445cf040-8eec-4d4b-27fd-08dc8588ad51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGE4MnBKWGhZeWNJcnN3b3E2REt6NFgwRGZlQjNxNW1hbkc5aGRkc3pUMjVZ?=
 =?utf-8?B?WTMwbm9PekFTSVVPbytHaC9weVZTRjQzYU9RZDNQejBSN2EwTDNCNSt5bnpv?=
 =?utf-8?B?T0dHWWEyQjNQbkJOamFLaTVqYXI0NlJ6K0I0U1Ira2ovcUo0SlFOVTF3cG5J?=
 =?utf-8?B?TDNWYTUxV1NoR1B5ZTdoZ2FxZnYwcU9KZXBlKzk2TjVaY2ZlMEZrSWNMc0Fs?=
 =?utf-8?B?S3Rmc2xNRWpwR21ta2VsODJSeDl1T3BlTE50KzkrcDdVd2I2aUtXMTFtTnRm?=
 =?utf-8?B?TmNNZk9jWk1GS3BNOXJmdlJHWmREUXNHQlJxWkpxZlRRTHRnMTY5alhzUXNP?=
 =?utf-8?B?QkhlT1l1QVh4cVVzRlkzTXpLVVQ2cEdmUmMxYWZZdnloK3ZWamhTMWpobThi?=
 =?utf-8?B?SVFjdFFLNVF1amZVNXBHTmlEVHcvWFpwNThxUmZJb1VzeXdpQ1IvOUdHU0x2?=
 =?utf-8?B?ci85SWR4WVMzSmNzcGN4eTRpaE85YTQra0dWM2ZWYWxERDUwT0pyOXVpUmRS?=
 =?utf-8?B?aXpYVllxdW9OWGRLbFBHeDVaMW9QejJjdTZadFk0SkRZblUzZEg4OVNEOTQv?=
 =?utf-8?B?ZXFwOUNvVDkydElibzljckp5aEQ4eUpXNXUzYzl1Q3VBTXhUL3NOREZ1anNO?=
 =?utf-8?B?dmx4Tjc3L0VheEc1Smh4eUFiK05TdXF2Wm1HVDlDUHBEVS9mdUtLNzRiNnor?=
 =?utf-8?B?NWNhazl1bkdVdzd4MFNyckprcUFadFRoK3R0YXFsL2k5dHFCUzJFZXJKQXk2?=
 =?utf-8?B?UWNMR0dES1J6YjV2dExQNCtSQzBsL1NoT2E4Y2hlZzB5M0YvMHZKL2lDV3BN?=
 =?utf-8?B?ZmV1SW9LUisxbjJBZHlNZzRySitsTXlpZzlYcE5vSTFUWW9lZUNKNWZwNlZU?=
 =?utf-8?B?NVVpbXRwUWF3Z1RLbW83RzdOU1NESy9kQmdqb0Mzb1VhNzNCQ1I5QVA5MHJ6?=
 =?utf-8?B?S0dwa3NCeUwzdEVYZ25yT3J3YzRSem5NY3p5OXRaWFNKVmtsOGtiQy9XVnlO?=
 =?utf-8?B?YzZSb05OenVpc0ZBL2Y5ZVAxdWFYZlNXZFgwdVNJNlI3U3Z1M1Z1djFKVGlE?=
 =?utf-8?B?WHl4MnBUSW4rTUZmbmpHSGhRZDRudjRuV3FxQ0Z5KzZPWjgvUXJTYmxKVjgx?=
 =?utf-8?B?enRBeVY3bVUzREFrczZaVmpaTkxOVnRPclJFVStTeUlJSzczV0NWWUVhOHlj?=
 =?utf-8?B?ZHlpdWxZNzJXRWJlZ3ZZTUs5SzFZaFlFckRWT3ZwNWk5ZWxtRys2STN4aEJn?=
 =?utf-8?B?VDNJRmVPbDRrRVFNVXlScnVGUHpEQkYvUkJtUlptdlZ1UEFvN2JmRTgvN0hE?=
 =?utf-8?B?R3ZVU1k5ZDRFT1ozTGY3b3IyVjY5YkFJMnBURTJxdUYxUTFBSXBMeHQyQ3Ro?=
 =?utf-8?B?UHBmTG5yM1ZLSnY5UTBHUzdiZitMdk9FTTl1eGhPMEpjbkRrSGppVDlkaVpv?=
 =?utf-8?B?c0czYkRlNThNYnowaTVEWEV2VlFhY2ZNcHVYeWdmWFYzbmh0WnlFSUFHT0Yv?=
 =?utf-8?B?UDRpN2J1a3N0NHF4OU9sb1R4Yy9KU0ZFb0UwK3cxakdib3VvS2lTMWowTzJS?=
 =?utf-8?B?cXNydGVIbXB1bkV5V2s0alo2bnA0eDlVdVVwRW01WVNNcE1sUk1xMUtkYnh5?=
 =?utf-8?B?YVZTMkJmZTFlanFZR1FHYlo4WVZzYTBIQXpwWjBTYU5PMS9qYXorcGR5UllT?=
 =?utf-8?B?a1hMNSs5U001bVBFUk1jdnNhZ2ZhOG9JMXVPOU5hcjk4cFZtTUNSUnFZN1ZX?=
 =?utf-8?B?THZLOXpjVUQ2N1RKbFNIWjA0SUgxRGFKeVR5UUkyakp0S3QzOUFRSnVtMGRD?=
 =?utf-8?Q?riS4q9iUeySTGVPCYil3DFubIzAYyuHxZZ9iw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QU5VM1cyL2NaMGlQWkR1VWZOaVNseWZ4VUFrc3JUMW5HczdHeTNxc1RIU01F?=
 =?utf-8?B?TjVKdG90am9KSWdGQ3A2TFZYNVJjekJPM1FSYjE4MHZsY0huN0laSEx6TlFS?=
 =?utf-8?B?SHRrOVFoR1p1bmgyMUVucEk4QjYxVzZGOEtXclg2U0dyaTk3VERrU1dLUVlX?=
 =?utf-8?B?ZTBRN2dMN2Vta2IrSlRZY2wya2FuN3JMaVJTYVZQcHhLaWJLZ0ZsWmNqWGhH?=
 =?utf-8?B?OWU1VG8wSjhkekloaEhRVkU3ZDBPMnRucnE0b0gyRjJ4NFl0WXhyMzhQd29T?=
 =?utf-8?B?MnNHYWR4bC9QRkdXVWxCYjVWM3RhbHZQektvVEl5SThaMGQ4WitIdWtFbmdm?=
 =?utf-8?B?Ym1kQVFkT0FoTG4ybHRnVTFoS2U3UTlGVlo4ZDByTG1xVEVob0R4WlBCZE4v?=
 =?utf-8?B?R3NvNWxOcmFuamhza1BGUWMwUXp3cnV0V0ZZWUlUazBqNTlYNUJVSmFkQlVT?=
 =?utf-8?B?V2dVL2M5NXhaL05xZFNXT09RK2lxQUNZVmtyOVF0bGw3dFRLSVd5SjhoeTBx?=
 =?utf-8?B?ejhzOEl5Q09LUmtGanhoTlBBYzhJVGxlQTdZUmZVeGt6YytWWm9KNlBaSUgr?=
 =?utf-8?B?ZkJpcStlclhwUXBUUEs4ZDdaWkdFb2o0YkVYOFplMytiU2p0Qi81VjdaK2ZT?=
 =?utf-8?B?ZVN2TGcreDJSbCtyenFGbG5xMnM4Y3VZV2cvZy9nYWUxUWVOTVBFZ3hrZUdB?=
 =?utf-8?B?S0I1a1JIVTBJeUVvZTI2TEhrb0ZxQWdyZ04zczFES2sraXB3YTkzUXNuZWth?=
 =?utf-8?B?VytuYzFJTTJManNWQjN1RzczZUQ2Nmc5MVA4NUlOTmJQeEdrOS9jUS9oNDQ4?=
 =?utf-8?B?T3VDckV3bnV1cGFGc09VOTMrZnEvYVRvSnpjbEVsWUwzUlhEeUdjZWlxeVhG?=
 =?utf-8?B?MzcycFNXT09KVThsTGxtN0dTdzhYTVU3ZkIwaDg3RGJLS3JBRU8xOTJDeEMy?=
 =?utf-8?B?dVJOYTg4Z0RKSXFISW9qc05lWDNWTnRlMTlzaUZYMUxmTHA3NkJHN3diYlds?=
 =?utf-8?B?NDNTMUs0UHFQUGFMRTVHaEFnazEvNDZiNTYyMnllKy9tcWoxdmxTV0g3T2Zu?=
 =?utf-8?B?UVRROXMvUSsyVmx1d0J1dFlWRG5VU2dxRC83bFUxTzRSNFh4eVJsWWkzbmRw?=
 =?utf-8?B?dnJxNE5BekVQQS8vbXJYZUNzNjdSYi9RR2lzNjdZdWFCemtKMGhTYXpwd0dE?=
 =?utf-8?B?ZHFPZnh4cjM3MlhZNURsK1Y4ODRKRDVRbVF4RFBlSm43a1VWVXVnTmZCQ2h3?=
 =?utf-8?B?Y1llbjBWZlk1bENodXlrdE1qVEtDTk41MmRpZlVESW9ZZnZnVHNjSmFvUGtz?=
 =?utf-8?B?T2ZabTQ0YS95dUlZdGc0elMvTzl3VHhkVVFiVjBPZTBPTkRuQkpwSU9aakNT?=
 =?utf-8?B?bkloa0NqQ3laSXAzVzhQSUVrajFTNy94d0oyWGxoMHZtbDlyMW1OZ1J6aU4v?=
 =?utf-8?B?dnRzTExibVFwNG5PZW82VFhjT2l2c1ZqVmdORHBYd2lkYy9GcjdZNE5sTmVi?=
 =?utf-8?B?OUEzRmZVa1NNLzdzb240K3ZxZEY1VlpjT2FRaEFseWg2K042WC9ZbkhxcWpB?=
 =?utf-8?B?Y0c2RUpqSFRnN0RGL3FmUWN2anRCUWQxWnNobmx3dXgvOVZ3U3V5MVJ1MUY0?=
 =?utf-8?B?YmlLc1paT3FKTVFFblNhM3ZQZUdtV3BaZkhOV3J1SVdZa0VDczhHN0pFSllw?=
 =?utf-8?B?NDhLeTVhc2VROFVLZ3dHVUdvUGdGYnZPZHBXaHlVLzFUZGlIeE8yTmF0NEI5?=
 =?utf-8?B?dU12SlV0Z28vSDB4cVE0b1dmaVlWd2p2V3dRd2ZQeVNMZ3ZsU0pOQzdLdVRI?=
 =?utf-8?B?djF0bU43U2VhRmFubzdPSVZYOUlaLzR0YVRYL0xXK0liMGZzTlpRRWs2b3k3?=
 =?utf-8?B?SVE4dWdqbDlMclEzelJaNWdJZVl6TXFPdTh2bVhCR0dZWVNqTzVVVUg3Vmxh?=
 =?utf-8?B?NVUxNVhJMWVkc1ZEU1pZZXVKZDlpZlEwUU5YQjR1SlhuZzFWdm4xVDhpTjRp?=
 =?utf-8?B?bzFxNjN3TXpSSXY0WGZoVVRxZkVsN3IvVWtIUFZDWmtUSVhVaE1IcldFVDVX?=
 =?utf-8?B?TldUQUJtUmFpTE9DY3kzOXRvelY0bVYyT25DbThrUXdTYjVwVmZUQ0F0dXlz?=
 =?utf-8?B?bFRaQVNCdUIxRzF5UHpzV3dXMnV3czcxWHIvc2N0cGNUSzJwdGVaR05VLzRh?=
 =?utf-8?B?ZUk5SFFoWXNEV25xaTlqYkVYNnhiOUxDOGlpd1JZUVo2MW1sY2tNYzFkQTQ3?=
 =?utf-8?B?U0d0WkE0bDE5d0VjTWZUaE9Mb21nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D33DB7E3B64964B8589383EDA42860A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 445cf040-8eec-4d4b-27fd-08dc8588ad51
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 17:55:24.9296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UVyoaiSpOnMUWCj95X/LdHgl2oR8v3LMIbpZGFz2RNkRwIAv56NaQ8qRQjdIgT4u0vAngpb+XEykbzJnI+Yzvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073

T24gV2VkLCAyMDI0LTA2LTA1IGF0IDE0OjQ4ICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IE9uIFR1ZSwgTWF5IDI4LCAyMDI0IGF0IDA1OjI4OjAwUE0gKzAzMDAsIFRhcmlxIFRvdWthbiB3
cm90ZToNCj4gPiBGcm9tOiBZb3JheSBaYWNrIDx5b3JheXpAbnZpZGlhLmNvbT4NCj4gPiANCj4g
PiBTSEFNUE8gU0tCIGNhbiBiZSBmbHVzaGVkIGluIG1seDVlX3NoYW1wb19jb21wbGV0ZV9yeF9j
cWUoKS4NCj4gPiBJZiB0aGUgU0tCIHdhcyBmbHVzaGVkLCBycS0+aHdfZ3JvX2RhdGEtPnNrYiB3
YXMgYWxzbyBzZXQgdG8gTlVMTC4NCj4gPiANCj4gPiBXZSBjYW4gc2tpcCBvbiBmbHVzaGluZyB0
aGUgU0tCIGluIG1seDVlX3NoYW1wb19mbHVzaF9za2INCj4gPiBpZiBycS0+aHdfZ3JvX2RhdGEt
PnNrYiA9PSBOVUxMLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvcmF5IFphY2sgPHlvcmF5
ekBudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRhcmlxIFRvdWthbiA8dGFyaXF0QG52
aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21s
eDUvY29yZS9lbl9yeC5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX3J4LmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
ZWxsYW5veC9tbHg1L2NvcmUvZW5fcnguYw0KPiA+IGluZGV4IDFlM2E1YjJhZmVhZS4uM2Y3NmMz
M2FhZGEwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21s
eDUvY29yZS9lbl9yeC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gv
bWx4NS9jb3JlL2VuX3J4LmMNCj4gPiBAQCAtMjMzNCw3ICsyMzM0LDcgQEAgc3RhdGljIHZvaWQg
bWx4NWVfaGFuZGxlX3J4X2NxZV9tcHdycV9zaGFtcG8oc3RydWN0IG1seDVlX3JxICpycSwgc3Ry
dWN0IG1seDVfY3ENCj4gPiAgCX0NCj4gPiAgDQo+ID4gIAltbHg1ZV9zaGFtcG9fY29tcGxldGVf
cnhfY3FlKHJxLCBjcWUsIGNxZV9iY250LCAqc2tiKTsNCj4gPiAtCWlmIChmbHVzaCkNCj4gPiAr
CWlmIChmbHVzaCAmJiBycS0+aHdfZ3JvX2RhdGEtPnNrYikNCj4gPiAgCQltbHg1ZV9zaGFtcG9f
Zmx1c2hfc2tiKHJxLCBjcWUsIG1hdGNoKTsNCj4gDQo+IG5pdDogSXQgc2VlbXMgYXdrd2FyZCB0
byByZWFjaCBpbnNpZGUgcnEgbGlrZSB0aGlzDQo+ICAgICAgd2hlbiBtbHg1ZV9zaGFtcG9fZmx1
c2hfc2tiIGFscmVhZHkgZGVhbHMgd2l0aCB0aGUgc2tiIGluIHF1ZXN0aW9uLg0KPiANCldlIGRv
bid0IG5lZWQgdG8gcmVhY2ggaW5zaWRlIHRoZSBycSwgd2UgY291bGQgdXNlICpza2IgaW5zdGVh
ZCAoc2tiIGlzICZycS0NCj5od19ncm9fZGF0YS0+c2tiKS4gKnNrYiBpcyB1c2VkIG9mdGVuIGlu
IHRoaXMgZnVuY3Rpb24uDQoNCj4gICAgICBXb3VsZCBpdCBtYWtlIGVzbnNlIGZvciB0aGUgTlVM
TCBza2IgY2hlY2sgdG8NCj4gICAgICBiZSBtb3ZlZCBpbnNpZGUgbWx4NWVfc2hhbXBvX2ZsdXNo
X3NrYigpID8NCj4gDQoNClRoYW5rcywNCkRyYWdvcw0K

