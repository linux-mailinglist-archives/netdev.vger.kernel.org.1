Return-Path: <netdev+bounces-162034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF17A25687
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42FFF7A580B
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC981FBCBD;
	Mon,  3 Feb 2025 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HNVYQNKB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5C20013E
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576712; cv=fail; b=cqRlELuBBuIH993266uNCDx3/KDNsJ49jA52m5l1XNoZ7Xu7SeynWnxY1hAR0DxxTDHB8/Fod1UV0l6QZsMC16jiVZfuXw3aIkVtuktiJIajezYqcakgk7MqD+kYU6S7B+z5wYchtDz4zcIySWDxb0WRtDLFt/rw9xxjcF5QTCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576712; c=relaxed/simple;
	bh=39RV+8Uk3byYLCI5D8Tpag2npiC/WblC2X1eytZQdsU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EntZeBHLTiNF+bVrguW4CsF4kVuIo/DjYrYIYudQpTcPKcyjcsqAvKvyXb89yTOLzHuaJDDZi/Ugg3SWN5TlyGAw2mNJkEt5fT4K5xwBjVRJ4FjCGBB7eTOlJ3aSA2s1ETd8wociQt/iFG8zAZUGvVYze68L2XBkg6K0n2LJa4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HNVYQNKB; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gulySiNSzVVxoxovaB7aZZkLznv0mwtl5QpISeE15oZKiTnxyHARrzOmTXMeiC/36A4LKJ6EiyJ5gNaj48ttdH2vPt9tgvcm1Xc7ARCd98ZrckD/zwmpzrm/bDUm/DzTGVCTYTyGLL+jwgDqx+fAMm87c8TrrnvQSnrIjcnzrALVqnO6ktZngHa0df+T8A2JfIinxNqYn4O0Qq1avH9QXZy08gBvymwLZnM1buQzpz4/crGBdeCeFoEzciVJKX2lFY5yIXQniZIIky2Dqdax/L/hPtYyudQhRcBR8GpjdSm9nMTmlNFhfZLSTVKHADpj3kN3lh3zi7GTOhfVZaaaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39RV+8Uk3byYLCI5D8Tpag2npiC/WblC2X1eytZQdsU=;
 b=SS8jORZMXiJzzxKwiwSQn0uWV5Us1fo6V25dIxeGiKwSaJxhCcnR4oKIFzp5AUhnbubc45nMtEQBmLaTE6WbVM3Y4TxOx9+wmizDNk51c8nIyL6XKoAdu9f3z9JHWwP3OEu3vZ0ESEIR0jOc2HIMMAhpSFBbCdHeP5HHXAKZqSXxM5Ll9+wvtF3UBxE6bayt9om7P+IvdBAeSL+yC2u6HZ7xA1DmX2dNEBCR2cXjosgQRDU/U6Wfo6M+MlE6K/EBxREttd4v7X+64R1bVMnR4Wl1KUX07PNuW2JwEq5c/FsO3Xxd0BAmSGQedl+7jO0L0YwaoSEaPo9n8K1t0lTuWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39RV+8Uk3byYLCI5D8Tpag2npiC/WblC2X1eytZQdsU=;
 b=HNVYQNKBdPpwsKJgfv9a9cF6tV8o2YwlB+GwjVSrIVfc+INC0ZR1K2OHrFrFZai9GCdr0/+wv9iST4Cj+8tL/Q+EIqWFrUd9iyAbmYDCgK+zTatYvODQAXPgQgOECZVXI10EEggQqqZLiEQR47CFmMd6QTH0UtjouRxR10nrZpvLG2wJxoGgF5WDeoKUvmZW0RN6gebneMYbtZGH8uTeqSJQ8Pz8UkolQ2gwKQ0EINijfxbiUVmJf2Qdv2QimI7jiR+dmI+zxT9xmaAmTBQbsjJ2m6hSm/cVBI+LjYTZ8uL/LMAx6mA997ruenY9cQf+8mxRCRSEvEFkftyBFnyRUQ==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by DS7PR12MB9527.namprd12.prod.outlook.com (2603:10b6:8:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 09:58:28 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%3]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 09:58:27 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "mkubecek@suse.cz" <mkubecek@suse.cz>,
	"matt@traverse.com.au" <matt@traverse.com.au>, "daniel.zahka@gmail.com"
	<daniel.zahka@gmail.com>, Amit Cohen <amcohen@nvidia.com>, NBU-mlxsw
	<NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Thread-Topic: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Thread-Index:
 AQHbb+l4mmigAbpb8kyWjZyRHuAtqrMrD+QAgAEebmCAAJRtgIAAlESAgAEyngCAALvScIAAQaCAgARP8PCAAJ3sgIAAv2+Q
Date: Mon, 3 Feb 2025 09:58:27 +0000
Message-ID:
 <DM6PR12MB45166DC5A99EC820E02FDF08D8F52@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
 <20250126115635.801935-9-danieller@nvidia.com>
 <20250127121258.63f79e53@kernel.org>
 <DM6PR12MB45169E557CE078AB5C7CB116D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250128140923.144412cf@kernel.org>
 <DM6PR12MB4516FF124D760E1D3A826161D8EE2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250129171728.1ad90a87@kernel.org>
 <DM6PR12MB451613256BB4FB8227F3D971D8E92@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250130082435.0a3a7922@kernel.org>
 <DM6PR12MB4516414BC58997DB247287CAD8EA2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <bb6268d7-d467-40a8-8980-c707a20d6a45@lunn.ch>
In-Reply-To: <bb6268d7-d467-40a8-8980-c707a20d6a45@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|DS7PR12MB9527:EE_
x-ms-office365-filtering-correlation-id: d289ac56-6a9e-4839-7d17-08dd44394e81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFZhU1FqNE5rU2NoS0oyYmp5K1dmVjRteDRSV1N5VUQvWHNvcHBKWm8zRlFX?=
 =?utf-8?B?bGx4VUQrUmRUM1VDRHE3ZDVBcjI5SFQvVVUrbDE3MWx1Ym40V20za1hTZldB?=
 =?utf-8?B?V0toNitVVE1HYk92eTVGR0hEdGtDMzdxSWtLVnpxbkFGTEtGMi9EOTlUeGpo?=
 =?utf-8?B?R21JemtsekI5emM2Mk1VSlN0MXg5em9iMzJzeW1KSTJJNzlWZHM4MUNzajRF?=
 =?utf-8?B?MHU5RElLa3NtN3RjbzN4bVdtb1d4dTE2bCtVTDhNL1BCWWpyWUpPakE3RmZN?=
 =?utf-8?B?LzJWY0xGbXJtdURXb01SODV2S09uYmZRMXo0MjRiM0ZpNVJRUGczSU1uOFBB?=
 =?utf-8?B?b01VYmJRTnBqRUxzNWdzd2U3QTVobWdlTExsdW5URDVxZVgyaWRvMURDT1FO?=
 =?utf-8?B?bFdVazFEbzNtZWRBclpuZ0c5QmpROXdjV1BKbTNoaWdWWjF3R1ZLMTA4VzRK?=
 =?utf-8?B?dE5BdTQvY2FrdjhEekZvTGtZclgvWGNYZFhwN3NzZEVYeUlibklMUG44enVq?=
 =?utf-8?B?czZXN1g3cmhWaUU0cUdUN05wY3UrTnR6RVMxeVM2QnRjY21kNWZub2EybXEx?=
 =?utf-8?B?SWorZkJ3ZzhrTHlNSGZqekc2WWJlbHFndDY3NTZMaTl4cnVEcVdhY0piZXFL?=
 =?utf-8?B?MzJhN0ltS3Rxd1FYSkFqMFl6L01jcVBnVUtLQlN6TXRHamNGSEg1RXVSaTFR?=
 =?utf-8?B?bjFJMTRLZkFWeW9neUlxT0crUHN0N3l6dGNLU1U4WC9ESHNVOFMrWkxTS2pS?=
 =?utf-8?B?cHNTbDI1cy9ubnR2SGNpT051SXRZam1kb0NSU2EvVjJ4TUZFME9hdXdpbEh5?=
 =?utf-8?B?MzdRU21yL24vWTQyVkdsOE9kT0VRWjhtRmM5RURjY0duM2VyaFl5alpSUitB?=
 =?utf-8?B?Q0tsMGRKRjY5SmFPZ0tqdDM1dDFLUmxlMTF4SU5qMjZ0Si9HSG54dnVPSmkr?=
 =?utf-8?B?bjUwdFcrVUpQTW9OZVg3WTNhNXU4c09yTFhHOUk1Nlk2ckV4MFJjekh5WDcy?=
 =?utf-8?B?aHQzMXBoN1NHUU8zWWhGTFVXRHg0aCs5UHF0ODNLQVZId3g3UURmZXpiSnI2?=
 =?utf-8?B?blVWdXZ2K3pyZSttbGQyeXJTdXl0SmZZUkpqN0o5c2pFdENDWlZPOWxIUFg1?=
 =?utf-8?B?MzA5NUYzY2xwWFdFUVRYTDN1L2hxR29BWlRPOWwzSEpMNGF3QVJ1T0JoVDBC?=
 =?utf-8?B?RW1aaXJXem92QWJIcmRnWlpPSHdXL0pGYlNFMi93Ynl5U1YzWk1IdWxkZjlY?=
 =?utf-8?B?L0xaaG1uaFROMVczcjZrM2lQOVh2cS9yelNJZTNJUzhETWptKzJMUTNMTmVO?=
 =?utf-8?B?RU9rNkI0Ny9GZmUycTV4azhpSXU2bEVRSU1LV3FmTkd6MlhTTnllYWlGYWdM?=
 =?utf-8?B?WXpSc3dmKys3TzJzTHJFeEVZc1NvT3R4TitsV2tROE9FOXVyMXcvQk81T0Vw?=
 =?utf-8?B?Um84dzRsUksrMmJZeVRrQVdUb2tSMzZ5NmFkWFBFWkdCdFVPeEJVOXpEd1ZH?=
 =?utf-8?B?SnphY01MRnZtYUtkY21PZnlxSnFBalRxQ0dIWUU3bFczK2M2R055OUZaalVy?=
 =?utf-8?B?OXBNNFhXV21OOUU0V3AxUnM2Y0N4N3lUam9Sak80NWFMd0ZnSVJCbmlpTVE5?=
 =?utf-8?B?U1hEbVN5dW9Beml1K094enpERWE2bWFmOGhJbWV3a1dYWnVxS2dOWHhISTNa?=
 =?utf-8?B?cGhoZ3NwVk13cUF6eWdLNzRLVlNuMkFsWHdFT0dEb21LTVc3OWUwWnpaNjZM?=
 =?utf-8?B?MmhQSjlhZW5kdmRXWnIvRGIzSnZaTmFtMmtTM3dFNEZrT1BSU1JXU0tzajF4?=
 =?utf-8?B?YTcrMVBNVHV3RFJZb05TNFp6OUpGb3BQWENkanBNcVpodUhoUDF0UXFPU0gz?=
 =?utf-8?B?UEF4S3c2Y3ppNHFmV3JSN1diU3FYcDdlR2gyZnM4NTlLbkJ2RXJZUk5GV1ZF?=
 =?utf-8?Q?+iphGWdzdPhRF2KVZlKmjNB6w9VZY0pL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnN1UndmUTcxL3FpcGNQMWo5NDEyQWJOQjRrMHdZaU8yaHBpem0yQWpYbCts?=
 =?utf-8?B?cUtMYnN3WlJyakgyalZhZ0xCenNOVlp2NC9wQWkrcUhDWWcvMzNTRXZya29H?=
 =?utf-8?B?VWE4ci9haFlTVGVsTDlQdjA0UURsY0NzSzBKaThBYWU1bEExaEU5M2ZvOW9J?=
 =?utf-8?B?UnJBT09RSmZ6L20yTnEzTlZOZGlmajF6M1ZIUGtDYjMzSHhDZ21FSjQwTXcw?=
 =?utf-8?B?b0NQOXB3M1hPSDVBUDQxVDR3SXNFM2d5WG5rMkRZZmppMlVsdlREbEROODcx?=
 =?utf-8?B?T0p3UXVpSkQ4MzFXOWVzMm1VUkNLcGNqREtoTFZsN1Z2cVMxaFZnWUk5R00z?=
 =?utf-8?B?cGdGSTlsSjZQRVZ1d3ByYTJTaGwwYmlTdlMvb2daUXRxTzA1UlRZQlBMRVhy?=
 =?utf-8?B?R0cyNzh6a1RVVlZNc3pLang1ZkZPVjE4b09CclZwdUF2VkMwVXNxQjk1SHRM?=
 =?utf-8?B?VitYci9CalJhaVZINHZpZnNuR3dqcWpLek9LLzcrSHpxUzRzUit6VzJrSmpE?=
 =?utf-8?B?SmJlTTVkc0l5b1ZBMjc1UFVXcFNoR1ZMRkNvRERnMm0waEwybU1CNWF2QnRo?=
 =?utf-8?B?bFpLSmU1d2NjL2p1QnhyZ0U4aHR4ZkxBU2NDaUdnNjBEK3I1dFRXZjVoQ0tq?=
 =?utf-8?B?MVF0ZU42S0UrRlk1NXYzQVNqUy91WW1kNGtRcXlXa0xzT0cxOE95amJNVGhI?=
 =?utf-8?B?Q1pqV0FYVnZrU0pKZXdZU1V6UjQreTRwMFRTdk0wdXl5M1VaVVMrR2xLOWtV?=
 =?utf-8?B?bGh2ODI0UDJtVEpLdTdRcTFXaGQxdmFkTE9MZ05YSDVNMm5yc2VFTGI2UStL?=
 =?utf-8?B?bGwvdEh2dEk5SmZJOHRSdGVhWWROSzVYSXRlTDQ4cHUrdnBXcFJuNVNmMGRP?=
 =?utf-8?B?YnZsMEtJeXZlc1MxcVdiZVY2UUhsMHkzeVVYWHR3UkFYUjlFV09MeXc5MEYv?=
 =?utf-8?B?cWI1VEtRL051KzhoSUZobkZxNkptait1NGowMHp0TVI3bzIzWEpzSmYvQzA0?=
 =?utf-8?B?dXVubEI3MWRYQUtTeTlHbEI4LzY4a0ZvZlZrZWwrMW41bVRkUGhDbXBLdVpl?=
 =?utf-8?B?ay9ydVVMQTh0djhyZHlZYlF2aW8xL2xpQThHTGFLaVgrbTUvQUtJYW1MQWVh?=
 =?utf-8?B?UFZYRzRBcGJLLytLODJMSndCSFA4Z2EyZmluSVhLY2c1RGhuMitFV0RjanpJ?=
 =?utf-8?B?RFRvSmd5VUl4YmtNUTV0aE9KejM1WW0vNSs0VFhKcFExSDZFTlN5b0hZbTlW?=
 =?utf-8?B?TVF3V0VGajYvcGp2SFRYaXF0ZUlCdGhCcHFrMUxLaExLdDRCZ2tOZ2pHYVpV?=
 =?utf-8?B?V1Q1QldtanlyU3J3aE01VkMzelllWGhiYTJVRVZCdXdpT2Z0US9ZYWoycURE?=
 =?utf-8?B?MVlUQ09iVWxlVkhMK0dNVndiTDRHZGp3anZNTlFKRjBpcTFNMDJWSjhzOVFz?=
 =?utf-8?B?bENDMlZXU245akd2aXVUY1VTaDhLSFcyL1o3b3ZRQ0dKTjZCUzFCblovNGV1?=
 =?utf-8?B?cTZ6UlZJcVBNQWx6STF5dWNTTVU0RnYwT2EvRmNQWHpxQkZHUFJLdFB0VHp3?=
 =?utf-8?B?L2hCV2E5RU5QK1psS2tkditNNnBPOElDaSttQW1TM1c2WjhGamRicWh5bGky?=
 =?utf-8?B?SSt2ZW01NG9jT0V1d3NJRXg4a1NLTUZlOEttdTZ1VXFCNW1yV2xVb3N0eXlF?=
 =?utf-8?B?WDlNSjRGUkluR1RueFQwM3FaWDhRMStVQTBOMnVaM0d6U1dQUGRqejNTOUVF?=
 =?utf-8?B?VHU5ek5vMzdNWWVVQ0ttWUVMUWFjK05BNDM4ZExuVUFIMFFPOXhMbzNsRFRl?=
 =?utf-8?B?VjZkbjdjVEl2dG5idUY1TzY0Z0hyazMxSXB4L0w1U2MvTU92LzlEYlZ6QXJF?=
 =?utf-8?B?RWV5bjBwY0ZDS2RRcTJUeXR1K2RLcEY2UkQ0VkMrNGxmSHhNMW9YeHBFd3BG?=
 =?utf-8?B?blg2dnJGalBZQy9WVmxocE1PRWlybHpBYko5bjFCc0IvZXhacjdTSW1ML0Zt?=
 =?utf-8?B?UndSODhCdEpFTXdUb3libVoxSEdzVklENUEvQ1ZtdGMyVmlRZzZJZW1pQjZU?=
 =?utf-8?B?bEV4TFBycVgxRXhZMm5OSWhrSmM0L0dwSjhlNmR1YTB1cHVUaDVYWUs2L2k3?=
 =?utf-8?Q?IdSnyECnwNrAAfbttpM8bTMc3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d289ac56-6a9e-4839-7d17-08dd44394e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 09:58:27.7182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1eqMzPQU+T6kzyBg3e5i54qa0I0sofJ6yhWAO3B/+5Grw2U2rCh/zTBtropnruR7t8RqAaDeUr1r+yiOD+gZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527

PiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IFNlbnQ6IFN1bmRheSwgMiBG
ZWJydWFyeSAyMDI1IDIxOjQxDQo+IFRvOiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlk
aWEuY29tPg0KPiBDYzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7DQo+IG1rdWJlY2VrQHN1c2UuY3o7IG1hdHRAdHJhdmVyc2UuY29tLmF1
OyBkYW5pZWwuemFoa2FAZ21haWwuY29tOyBBbWl0DQo+IENvaGVuIDxhbWNvaGVuQG52aWRpYS5j
b20+OyBOQlUtbWx4c3cgPE5CVS0NCj4gbWx4c3dAZXhjaGFuZ2UubnZpZGlhLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBldGh0b29sLW5leHQgMDgvMTRdIGNtaXM6IEVuYWJsZSBKU09OIG91
dHB1dCBzdXBwb3J0IGluDQo+IENNSVMgbW9kdWxlcw0KPiANCj4gPiAgICAgICAgICJtb2R1bGVf
dGVtcGVyYXR1cmUiOiAzNy4zNDc3LA0KPiA+ICAgICAgICAgIm1vZHVsZV92b2x0YWdlIjogMy4z
NDA2LA0KPiANCj4gRGV2aWNlIHRyZWUgb2Z0ZW4gcHV0cyB0aGUgdW5pdHMgaW4gdGhlIHByb3Bl
cnR5IG5hbWUuDQo+IG1vZHVsZV90ZW1wZXJhdHVyZV9DLCBtb2R1bGVfdm9sdGFnZV92LA0KPiAN
Cj4gPiAgICAgICAgICJsYXNlcl9iaWFzX2N1cnJlbnQiOiB7DQo+ID4gICAgICAgICAgICAgImhp
Z2hfYWxhcm1fdGhyZXNob2xkIjogMTMsDQo+ID4gICAgICAgICAgICAgImxvd19hbGFybV90aHJl
c2hvbGQiOiAzLA0KPiA+ICAgICAgICAgICAgICJoaWdoX3dhcm5pbmdfdGhyZXNob2xkIjogMTEs
DQo+ID4gICAgICAgICAgICAgImxvd193YXJuaW5nX3RocmVzaG9sZCI6IDUNCj4gDQo+ICAgICAg
ICAgICAgICAiaGlnaF9hbGFybV90aHJlc2hvbGRfbUEiOiAxMywNCj4gDQo+IA0KPiA+ICAgICAg
ICAgfSwNCj4gPiAgICAgICAgICJsYXNlcl9vdXRwdXRfcG93ZXIiOiB7DQo+ID4gICAgICAgICAg
ICAgImhpZ2hfYWxhcm1fdGhyZXNob2xkIjogMy4xNjIzLA0KPiA+ICAgICAgICAgICAgICJsb3df
YWxhcm1fdGhyZXNob2xkIjogMC4xLA0KPiA+ICAgICAgICAgICAgICJoaWdoX3dhcm5pbmdfdGhy
ZXNob2xkIjogMS45OTUzLA0KPiA+ICAgICAgICAgICAgICJsb3dfd2FybmluZ190aHJlc2hvbGQi
OiAwLjE1ODUNCj4gPiAgICAgICAgIH0sDQo+IA0KPiAgICAgICAgICAgICAgImhpZ2hfYWxhcm1f
dGhyZXNob2xkX1ciOiAzLjE2MjMsDQo+IA0KPiANCj4gPiAgICAgICAgICJtb2R1bGVfdGVtcGVy
YXR1cmUiOiB7DQo+ID4gICAgICAgICAgICAgImhpZ2hfYWxhcm1fdGhyZXNob2xkIjogNzUsDQo+
ID4gICAgICAgICAgICAgImxvd19hbGFybV90aHJlc2hvbGQiOiAtNSwNCj4gPiAgICAgICAgICAg
ICAiaGlnaF93YXJuaW5nX3RocmVzaG9sZCI6IDcwLA0KPiA+ICAgICAgICAgICAgICJsb3dfd2Fy
bmluZ190aHJlc2hvbGQiOiAwDQo+ID4gICAgICAgICB9LA0KPiANCj4gICAgICAgICAgICAgICJo
aWdoX2FsYXJtX3RocmVzaG9sZF9DIjogNzUsDQo+IA0KPiBldGMuIFRoaXMgbWFrZXMgaXQgbW9y
ZSBzZWxmIGNvbnRhaW5lZC4NCj4gDQo+IAlBbmRyZXcNCg0KSSBzdWdnZXN0ZWQgdG8gaGF2ZSBh
IHNlcGFyYXRlIGZpZWxkIGZvciB1bml0cyBpbiB0aGUganNvbiBvdXRwdXQuIEl0IG1ha2VzIHNl
bnNlIHNpbmNlIGl0IGNhbiBiZSBlYXNpbHkgdHJhY2tlZCBieSBhIG1hY2hpbmUgYW5kIGFsc28g
aXQgaXMgYWxpZ25lZCB3aXRoIHRoZSByZWd1bGFyIG91dHB1dC4NCkpha3ViIG9mZmVyZWQgdG8g
cmVtb3ZlIHRob3NlIGZpZWxkcyBmcm9tIHRoZSBvdXRwdXQgYXQgYWxsLiBBbmQgdXNlIGEgc2Vw
YXJhdGUgZmlsZSBmb3IgZG9jdW1lbnRpbmcgdGhvc2UgZmllbGRzLiBJbiB0aGF0IGNhc2Ugd2Ug
YXJlIHN0aWxsIGFsaWduZWQgd2l0aCByZWd1bGFyIG91dHB1dC4NCkJ1dCBpbiB5b3VyIHN1Z2dl
c3Rpb24sIHdlIHNob3VsZCB1c2UgYSBkaWZmZXJlbnQgbmFtaW5nIGNvbnZlbnRpb24gaW4gdGhl
IEpTT04gb3V0cHV0LCB3aGljaCBub3Qgb25seSBjb21wbGljYXRlcyB0aGUgY29kZSBidXQgaXMg
YWxzbyBjb25mdXNpbmcuDQoNCkkgdGhpbmsgd2Ugc2hvdWxkIHN0aWNrIHRvIHRoZSBmaXJzdCAy
IG9wdGlvbnMuDQoNClRoYW5rcy4NCiANCg==

