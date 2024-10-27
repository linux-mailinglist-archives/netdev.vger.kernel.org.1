Return-Path: <netdev+bounces-139377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F39B1C4E
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 07:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC4BB21213
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 06:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590F42BAEF;
	Sun, 27 Oct 2024 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HAfmSBSG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F1E573
	for <netdev@vger.kernel.org>; Sun, 27 Oct 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730011866; cv=fail; b=q6Apom+vQvCSuJtyzwc0Pc9pMyyUSdmjs4eYtvWvyZruhzi/dCvCXCzDbpDv0SMLw5RxtHeYoh6PmEAJU2UyjxK4X2+Xvb49Ycpn0t7VA5uBUA4QFin0IxqUd3Dujls2pdT3vXw2UCnSNi4r4sMdLzanyFpxt2prhcm0zrDDRts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730011866; c=relaxed/simple;
	bh=imY8iMZGOujAC17NEYi8GcWEUJrEgSvKisV7Cn5+sxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PwbP2LBBhq7A7JvhnOuxactDaTzMYfE+g6XpV5cBiJRkW7sXvQKMOHr2U0AIB2YUkjU/LCxO0J3ofCdstLYFLlpFF6wWZjAEInLTKOvls+lxaQHw9euxDDN0J3wQo4+/I3/ZggkOKW/2G1ez+GPmBANk5Ze7+oPHzZrO9Ks2EvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HAfmSBSG; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBois8xhBNO4oRCCBAJUksFPthGR2GedOu4hvDcbvHPjhDRftVp0fVwjDvfrvVX/gWiUoKWImAUaO9v6LnRNErrZT925hA873CcnjH0Im3+50qcZhvEHT/q6ZgO3gwVysiWIj5MLx4vdLoCs6Ys8VwmfEwN2tc4RcD5OISqZOzOTLWUlHOxnSIs/A+7GcvZv4w37zr2VDonuk60t4oXzjY1JK3cBpUmv0Xr2L7XzA/GRR8e106qDel/R1Y3AtFyWNKIkpMjYchabUBQJnPe22e9wRCA5vEJRqr/QRvyzaqSNO1n+7CPqvHmkl8SXtMB/M5ol1Vxq2pV/0iSovGC7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imY8iMZGOujAC17NEYi8GcWEUJrEgSvKisV7Cn5+sxc=;
 b=wBQsn6BSa9Aw4SLHEDN8eG6IV+PLcjP58s92LJ6j2CKrEOCtN7F8FUSWjlvFDtiSlEDvbtJF8Tg8kXq03z6hRhyfLWxSyZTbZ6zGkvM1ffZ0Jac1U8PV9cKcN9US6bmX+IYf5sifNz62alTDjPKPPqQSnQbp6Nb91nrZG/7t33cEG2vhDfAUzXs73ZVdZL8pWVI5OqfYZhHVQp9dDnFUMQ05TQeDwf9nv5Z6rDyuuZeFawOfhSiLXD0rew83MT0LdMau+J3pCR9P79ubAjl1+0/W8SWKlubTB20y788zpeAaXftbuZ7nFgLrSlZ3Z/bHyufaVIvKFNnXZUMkQotC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imY8iMZGOujAC17NEYi8GcWEUJrEgSvKisV7Cn5+sxc=;
 b=HAfmSBSG+EM3c2uhQxRQ5kGwZoiwwRDTrgJUVrjdaQ+95ISlknJI1rjxQptt1JzRavem3OuhIL5ZLx/xJZPZpdHYB6HbeKUJ4iUsYwPfzydMKwpWIsaBwzNlRiENTewe7LBTtRx006s8wY4Icw9l9DsIBpDJQETglHVKYt5DZ8UY0h9RJ4YZNtjoug51nBkhIY3NtJwPfATdiePJO0wiObszH7TxFJGaOxZuF84tay89bHBCPsn23MoyGqbFNB6LuBu0aNnhE/eA+OCiS9ynmfGESapx8QTt+8v3eeMbsNPSFfyBxCfnKROZ83538pBujsHTtnxHH2aZg4hidou1Jw==
Received: from BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sun, 27 Oct
 2024 06:51:00 +0000
Received: from BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::5851:fa86:f137:1858]) by BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::5851:fa86:f137:1858%4]) with mapi id 15.20.8093.024; Sun, 27 Oct 2024
 06:51:00 +0000
From: Amit Cohen <amcohen@nvidia.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Petr Machata
	<petrm@nvidia.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Danielle Ratson
	<danieller@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, mlxsw
	<mlxsw@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
Subject: RE: [PATCH net 3/5] mlxsw: pci: Sync Rx buffers for device
Thread-Topic: [PATCH net 3/5] mlxsw: pci: Sync Rx buffers for device
Thread-Index: AQHbJuoFkXADflllJ0aYkIORbqRqVbKXkA8AgAKZ3fA=
Date: Sun, 27 Oct 2024 06:51:00 +0000
Message-ID:
 <BL1PR12MB59225E9CAE5C28E915187515CB492@BL1PR12MB5922.namprd12.prod.outlook.com>
References: <cover.1729866134.git.petrm@nvidia.com>
 <92e01f05c4f506a4f0a9b39c10175dcc01994910.1729866134.git.petrm@nvidia.com>
 <a68cedfb-cd9e-4b93-a99e-ae30b9c837eb@intel.com>
In-Reply-To: <a68cedfb-cd9e-4b93-a99e-ae30b9c837eb@intel.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5922:EE_|MN0PR12MB5811:EE_
x-ms-office365-filtering-correlation-id: 9a211971-effb-49e7-0420-08dcf653b7ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnlOZHFCTWd2aCtQQkovOThTbkxva2htMFcrRDNwWW5PcEtUeDZTMzk5Rm9J?=
 =?utf-8?B?elcvZFVPWnhva3AzUEViSVpTS3hIWnRjTW1LZHp0R2c5ZXBadEppc1VMZkRq?=
 =?utf-8?B?U1RJYWN6ZUlxTEx5YmROWUZUMW5oUG9oNUV1dlI5NUVVeVoyYlhjOENHTUU3?=
 =?utf-8?B?bVdNMGlLczZVZDM2b21tYmdjRWhwZmJYYXN1dThpL0VybFBWVytzWkR4NWxX?=
 =?utf-8?B?VDZQWm9hVEpLWDVDY2VXQVEyMFN2NVVock9rWjluY1hLVnJoaW9RdkNWMmU0?=
 =?utf-8?B?UUNMbmJvLzE0WkRrdWUycnJ5SmprT2dTNEZ5MFVRNmlOcGRJbEFEOUhRc3hT?=
 =?utf-8?B?ZVB0TGdpNVcrQnBydGJ5S1VrcXJpNGZWK3lkMFVYWjRHbkhuS0orUmJrUk90?=
 =?utf-8?B?VExtNXR2UFdJNThuVEZpcEhZSmRSWHJndWtNZGNPM0daUlNTMjRDVG5tZE9Z?=
 =?utf-8?B?MGkxdVNvdEl5YnlHNk81cFR1YlRWZVVUbnB2MUZNYW1ZdnI1VzlTWkxsSDRU?=
 =?utf-8?B?V2E3U0cwSVRBdGJvYkRLbWdvd0gyRDR2N2ppcXlZNlg2K3pKakRtcFJ1SVAy?=
 =?utf-8?B?d3U5RFA1T2xvNHVRNWVNU1ZsRWFRNmRNVldvcEhXQVpJVGFFRTZmb2dTRWJK?=
 =?utf-8?B?R0pyUFFMdjVXTVNWeWU1RWRaTURxOGg4MFNxdDlmVmNOaGFlYWpNckNKVUlm?=
 =?utf-8?B?OEEzVWwvVm5uT0p2SXZYTlpSZXhQOEpqNDYxUm0rZWlBM0NXREtJWE04VlNP?=
 =?utf-8?B?c2I4NHlMck16VU5BZ01HWm96T3daakVTQkdQNEVIc0FYamg3dWlXOXhHZWRa?=
 =?utf-8?B?eEVrSGI1TThDSmJVUjNOODVZWGtMazFtckhvU2NtWGNNRTlPMnBKTUdJVkxC?=
 =?utf-8?B?R0s2M3REYUIzSXRKSERiZGkyWEk2M0ZUVG5lUmtZc3RWYTJmak4ydjQzMmhv?=
 =?utf-8?B?QTRzK1VTYVYyNXlkQ1hsSkVpMjNLcFlrbzVUMFEvckhpZDZBenpiUXBKYWEx?=
 =?utf-8?B?aWhBL3BOLytEb1hOOXMwek44M2dKS3RjTllLMHMxd1ZMQk5jajVnVTNVUmk2?=
 =?utf-8?B?WXJiS094TDlCVUN3YXJtU2tvbnZCRWRyaC8yM0puSXRFT1NkS0JhOVRuazc4?=
 =?utf-8?B?MDVFTzNCeUhuUFcwZ0YydkRIL3h5U09td3BQRHFUSEZCcG1TWlpOMnI5NmZI?=
 =?utf-8?B?eU5HdDRWRVhKRzl5dDB2MGw1RzEySG5PUEtFb2hFSUJiR2NuUEJ4b1k0WW42?=
 =?utf-8?B?V2tKbFBtdUFkRVBYeE5yZ2NMNzJtTmlNa0s1Nk4zeitXZUhDMmJ2bUxqVTJN?=
 =?utf-8?B?YkE0MlBoQVM1bVRqaWtvZDdlZWpFeU9PWG9QNWpGb0xINnF6NkZSQnhiNWF1?=
 =?utf-8?B?MlAvc2tZRU50SHYzMjJueTdzVmVhU3c4ZUNjaVpmbEdZRFUwb0phTVYvYW1Y?=
 =?utf-8?B?R0dTL2RxcjRsMVE3Y3l2dEZkK2JvWkNIVHVodWoycXlNMmhOd1habHBEL2Nn?=
 =?utf-8?B?VFVJMDlRSkZ2K29TUnEzT005a2FVRk1VcTVSSHhjZmhFRm5nd0c5Tkppbmhh?=
 =?utf-8?B?K0F2eTR6S3ZwK1locytkMGZDc2RqK0c2VWkvUzBIYTI4aE5LKzNCRzFsNUxm?=
 =?utf-8?B?WFJ4MlBUUlh1OThLK2haTmMxVmlkS2J6OUUzZ0NTQWw1eGh5dTJKcjhFVlov?=
 =?utf-8?B?U2hJRVg1blFMT1AvSW1DcEEwdzRlMVp2QzNyMDljdnNKRWZVRWFQWEdMNEgw?=
 =?utf-8?B?Q1RZaXpPQ1I4NVVNbjd2MUE2YXczWkwvQU4rakh2eW9FbVVHYkhHWTZUUVla?=
 =?utf-8?Q?62Hr9htohQN/6r46w/u5I0+//g6fjtaCF5niU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5922.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUhiNE9EN0VRRWdoUHZ5TlN5Y09leVZzNWw0bjJKVStXRVFwM1JBWlpHZStT?=
 =?utf-8?B?d2F1dDkzK2FScFZFN0doZFRNLzMrdDIwSzRIQ0VKK1RrMjI3YUI0UlNxMnpC?=
 =?utf-8?B?dS9ZdjZlT2hNUmRkQVNlaHlDd09VYVV4Zk85TVJGbThpazIzR2M0NWRrWktm?=
 =?utf-8?B?dk4zT0RDOE5aV2k5MXl3cDhUK2ZiMXAvbVcvZUZxeHlBazk1QVNuMHk1dHNa?=
 =?utf-8?B?cHo1ZjZCczM4cXFDNDJxbDVHbTBxU1dkcWQxRDhjOTNRZDl6d3R2RUpvWGtt?=
 =?utf-8?B?TGRsc1Q3K2VGdHRRR2VHbUVqN3RjbHFoZE5kTnBZaGVYRmZqT1lMV0g0ZGlh?=
 =?utf-8?B?MWdheTM4ZGxJMjBUNXVHdHJlSDFoWHdnWWIrV0lVUzdmbS80VzVZdGNubGoy?=
 =?utf-8?B?U2VZV2pFM2I0ckpVUWhKT0k0QUZZbTVYWVdtN1o1M0NuUkdCWC9vMlRSM2Qv?=
 =?utf-8?B?WldDR3VFdjg3azZJVUQxZ0pDTjFidUZlWVE4cjdCSmpKNWNyWEpQUkZYc1g5?=
 =?utf-8?B?TnI3QVRUUnRqOS84VlhudHJtcVlBTHZQWisvcjR6NHNDdlhxYm9YVjRXRnZj?=
 =?utf-8?B?akZtU1UxVVdYWXMyaWE0NW9tR0NYU0tKOU9wKzlvcHh3Skp1bnBubStKK3NE?=
 =?utf-8?B?djlLK3dhQVozbUgrRzBTZW9NMGR1V2dha2QrUko5UDZBUFdLUXNmUUpYb1Bs?=
 =?utf-8?B?cnFNS2ppRUdNSHVlNVJJdUZtV1plN1lLaFM2Q2pIR0tEdHNGMk1IRUQ2Zzhz?=
 =?utf-8?B?T3RaQklMdThwdzNlczhyMTYzSDVZKzdRYm02bkF1eWRXeGFleUk0M29ERFEw?=
 =?utf-8?B?TjN4MWtUQUMrMElnbXdjN21SWlpwREFpcSt3VFo3UFFyc3Mza1dlU1JoNWxS?=
 =?utf-8?B?UWdHb0RNZ2hhVTRqOFNJK3JKNjJJellkckpScnU0VWx5N2hSMjQ2MG0zRUZj?=
 =?utf-8?B?NCtGS2dDM2xTY1pXNDQxZlI3ZmVYQ2tOdFZYRVcxZFpBYU12a0VGUHFrYTd5?=
 =?utf-8?B?OE1nSFhkVkpZTURpQU90Z3lGQVBNemtsS2FJZzV0eFZibktGVy9xRGJaL25n?=
 =?utf-8?B?cVViNWY2SUUyNHlqTm90UG9ZU0VwZzQwZXpNamNLWFVLQXhMaXc3MVQvQ1ZL?=
 =?utf-8?B?cVFSTmpybWJ5enFuUEtPZ0J6Z2d5ZStSSlhRTE0vUUJBUTJ4bkVicXFvS2Ni?=
 =?utf-8?B?TG5RWjY1Zy9za2lEZVMvUi9DWXVsektuL0ZNeHE5ZTZHOHJtMHBVNFhBRVZC?=
 =?utf-8?B?WXl1b0d1d1ZKMlk1VGtBNzFCK25UZklFak4zR0dQNTNkdWFGVHMrQmFjSGI0?=
 =?utf-8?B?blZYQlEzNlBaR3RDaE9McDlnNlRNTjJyVnJMZkZVendwL0g5aU00SkJuNHU4?=
 =?utf-8?B?b0VSSXZsVHlDV3pBNXVUMDdwVjh5US8vOGVQSnA1ZHUraVc1dHhzR2FPNGdO?=
 =?utf-8?B?eC9xZ3RIY3IrSVBmRCt4eFJhMlNnNmVkaVl2bE9oU3BmWXFaK3Vwa1Zycm1C?=
 =?utf-8?B?ZjlmR3B2U1gxT0VHcDZSZklsZDZORVNmcVArZHlBYUlwbmFuNTNXWURaa01v?=
 =?utf-8?B?ZExoZjQweG9LZmY5eFUyN2pqd1JXLzE1Z3NYSGgwOEtWcGhybHN3TGNHOHRy?=
 =?utf-8?B?bWV5US9EUzhnSFpGbHpyNHVkZHlGcUVDbjBLRVhEemxyVUkwd0NqZ3MzTjV6?=
 =?utf-8?B?T2tmZktKYldpZ3pnZW9qQkEvWkVIbC9SYTlPUHRDbGo1Q2dMeGxISG1IRWhy?=
 =?utf-8?B?RXVQQjcxcklEUk4ya2xCMk9iT1k0TllTL3N6L09INGFBUUQ3Y2hDbmpyVUxx?=
 =?utf-8?B?QXd5OE53Tkx6OExwS2J4bEc1QVhFZ3M4WWVwU2FwN1IxdnlOTmhLOFNqNHY2?=
 =?utf-8?B?WGlzSjlFV3Z5ODU2WlRZUm14bEhxT3dCUUg0akpIRXBjakwwUURGaDNXNm1N?=
 =?utf-8?B?aHVzVVNxZ2dTUHpaSnRvUVo4L0FqYjNzKzlydkoyL1kxWCtHZ1BZSW1qb1JF?=
 =?utf-8?B?RVVDMjhCdUFOaG1BR0ZaRkMrWi9HKytjeG8zYzQ1V1R0VzczVTlKZ1ovY2dn?=
 =?utf-8?B?VUxJZ2FpVUNrS1hmNGVCUGEvQ3JqU25DcWhJQVlXcURNcDVzYWFkSkRPK2RY?=
 =?utf-8?Q?qFAY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5922.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a211971-effb-49e7-0420-08dcf653b7ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2024 06:51:00.3624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jC6OGFqSe+KBE6eyQ3kSVePCYil6fTxJSCL8vPjIk39w1oWWenbk7l/2qfqp7DHWIvPQcohiA9k+uSGGgl6SMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVyIExvYmFr
aW4gPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgMjUgT2N0
b2JlciAyMDI0IDE4OjAzDQo+IFRvOiBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+OyBB
bWl0IENvaGVuIDxhbWNvaGVuQG52aWRpYS5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQgUy4gTWlsbGVy
IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUu
Y29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47DQo+IERhbmll
bGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+OyBJZG8gU2NoaW1tZWwgPGlkb3NjaEBu
dmlkaWEuY29tPjsgbWx4c3cgPG1seHN3QG52aWRpYS5jb20+OyBKaXJpIFBpcmtvIDxqaXJpQHJl
c251bGxpLnVzPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCAzLzVdIG1seHN3OiBwY2k6IFN5
bmMgUnggYnVmZmVycyBmb3IgZGV2aWNlDQo+IA0KPiBGcm9tOiBQZXRyIE1hY2hhdGEgPHBldHJt
QG52aWRpYS5jb20+DQo+IERhdGU6IEZyaSwgMjUgT2N0IDIwMjQgMTY6MjY6MjcgKzAyMDANCj4g
DQo+ID4gRnJvbTogQW1pdCBDb2hlbiA8YW1jb2hlbkBudmlkaWEuY29tPg0KPiA+DQo+ID4gTm9u
LWNvaGVyZW50IGFyY2hpdGVjdHVyZXMsIGxpa2UgQVJNLCBtYXkgcmVxdWlyZSBpbnZhbGlkYXRp
bmcgY2FjaGVzDQo+ID4gYmVmb3JlIHRoZSBkZXZpY2UgY2FuIHVzZSB0aGUgRE1BIG1hcHBlZCBt
ZW1vcnksIHdoaWNoIG1lYW5zIHRoYXQgYmVmb3JlDQo+ID4gcG9zdGluZyBwYWdlcyB0byBkZXZp
Y2UsIGRyaXZlcnMgc2hvdWxkIHN5bmMgdGhlIG1lbW9yeSBmb3IgZGV2aWNlLg0KPiA+DQo+ID4g
U3luYyBmb3IgZGV2aWNlIGNhbiBiZSBjb25maWd1cmVkIGFzIHBhZ2UgcG9vbCByZXNwb25zaWJp
bGl0eS4gU2V0IHRoZQ0KPiA+IHJlbGV2YW50IGZsYWcgYW5kIGRlZmluZSBtYXhfbGVuIGZvciBz
eW5jLg0KPiA+DQo+ID4gQ2M6IEppcmkgUGlya28gPGppcmlAcmVzbnVsbGkudXM+DQo+ID4gRml4
ZXM6IGI1YjYwYmI0OTFiMiAoIm1seHN3OiBwY2k6IFVzZSBwYWdlIHBvb2wgZm9yIFJ4IGJ1ZmZl
cnMgYWxsb2NhdGlvbiIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQW1pdCBDb2hlbiA8YW1jb2hlbkBu
dmlkaWEuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBJZG8gU2NoaW1tZWwgPGlkb3NjaEBudmlkaWEu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBldHIgTWFjaGF0YSA8cGV0cm1AbnZpZGlhLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4c3cvcGNpLmMg
fCAzICsrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gv
bWx4c3cvcGNpLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHhzdy9wY2kuYw0K
PiA+IGluZGV4IDIzMjBhNWYzMjNiNC4uZDZmMzc0NTZmYjMxIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seHN3L3BjaS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4c3cvcGNpLmMNCj4gPiBAQCAtOTk2LDEyICs5OTYs
MTMgQEAgc3RhdGljIGludCBtbHhzd19wY2lfY3FfcGFnZV9wb29sX2luaXQoc3RydWN0IG1seHN3
X3BjaV9xdWV1ZSAqcSwNCj4gPiAgCWlmIChjcV90eXBlICE9IE1MWFNXX1BDSV9DUV9SRFEpDQo+
ID4gIAkJcmV0dXJuIDA7DQo+ID4NCj4gPiAtCXBwX3BhcmFtcy5mbGFncyA9IFBQX0ZMQUdfRE1B
X01BUDsNCj4gPiArCXBwX3BhcmFtcy5mbGFncyA9IFBQX0ZMQUdfRE1BX01BUCB8IFBQX0ZMQUdf
RE1BX1NZTkNfREVWOw0KPiA+ICAJcHBfcGFyYW1zLnBvb2xfc2l6ZSA9IE1MWFNXX1BDSV9XUUVf
Q09VTlQgKiBtbHhzd19wY2ktPm51bV9zZ19lbnRyaWVzOw0KPiA+ICAJcHBfcGFyYW1zLm5pZCA9
IGRldl90b19ub2RlKCZtbHhzd19wY2ktPnBkZXYtPmRldik7DQo+ID4gIAlwcF9wYXJhbXMuZGV2
ID0gJm1seHN3X3BjaS0+cGRldi0+ZGV2Ow0KPiA+ICAJcHBfcGFyYW1zLm5hcGkgPSAmcS0+dS5j
cS5uYXBpOw0KPiA+ICAJcHBfcGFyYW1zLmRtYV9kaXIgPSBETUFfRlJPTV9ERVZJQ0U7DQo+ID4g
KwlwcF9wYXJhbXMubWF4X2xlbiA9IFBBR0VfU0laRTsNCj4gDQo+IG1heF9sZW4gaXMgdGhlIG1h
eGltdW0gSFctd3JpdGFibGUgYXJlYSBvZiBhIGJ1ZmZlci4gSGVhZHJvb20gYW5kDQo+IHRhaWxy
b29tIG11c3QgYmUgZXhjbHVkZWQuIEluIHlvdXIgY2FzZQ0KPiANCj4gCXBwX3BhcmFtcy5tYXhf
bGVuID0gUEFHRV9TSVpFIC0gTUxYU1dfUENJX1JYX0JVRl9TV19PVkVSSEVBRDsNCj4gDQoNCm1s
eHN3IGRyaXZlciB1c2VzIGZyYWdtZW50ZWQgYnVmZmVycyBhbmQgdGhlIHBhZ2UgcG9vbCBpcyB1
c2VkIHRvIGFsbG9jYXRlIHRoZSBidWZmZXJzIGZvciBhbGwgc2NhdHRlci9nYXRoZXIgZW50cmll
cy4NCkZvciBlYWNoIHBhY2tldCwgdGhlIEhXLXdyaXRhYmxlIGFyZWEgb2YgYSBidWZmZXIgb2Yg
dGhlICpmaXJzdCogZW50cnkgaXMgJ1BBR0VfU0laRSAtIE1MWFNXX1BDSV9SWF9CVUZfU1dfT1ZF
UkhFQUQnLCBidXQgZm9yIG90aGVyIGVudHJpZXMgd2UgbWFwIFBBR0VfU0laRSB0byBIVy4NClRo
YXQncyB3aHkgd2Ugc2V0IHBhZ2UgcG9vbCB0byBzeW5jIFBBR0VfU0laRSBhbmQgdXNlIG9mZnNl
dD0wLg0KDQo+ID4NCj4gPiAgCXBhZ2VfcG9vbCA9IHBhZ2VfcG9vbF9jcmVhdGUoJnBwX3BhcmFt
cyk7DQo+ID4gIAlpZiAoSVNfRVJSKHBhZ2VfcG9vbCkpDQo+IA0KPiBUaGFua3MsDQo+IE9sZWsN
Cg==

