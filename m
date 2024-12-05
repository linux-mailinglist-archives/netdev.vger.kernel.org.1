Return-Path: <netdev+bounces-149359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BE19E53DE
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E9B167C57
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564671F03F6;
	Thu,  5 Dec 2024 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cfKrYgWc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C872D1DC182;
	Thu,  5 Dec 2024 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397972; cv=fail; b=fi2odHZv0tLzN3YeK3F6qhOWs3oEpugYPzLpJocKr7SXNuJPRloh9ogjXUUB6HrmOvkA1uZjPvCOQbr/lD/X5kXukPrBtySKrfDxXwdAcEzFk+mwTEZcT+blPYkahUhPhPnOCSY1ZNsHRK50maRx9pYSDQFNMHkLxhEW33PRGTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397972; c=relaxed/simple;
	bh=pWgNPEF2Jhb7lSw9kOCtwxckxSp60BlZYGTGkOf7Cv4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NYHDG3TotQYdqWhg7t7Tpe363paE6c6ygKoS4aT5aHUDXOqTyrLDjLnY4HffGQZNpGMbVAUr9OQgfoiPw0tv5Ur4EzESkiXTN8E0lqaarcgHZb0lTX8f6QH2jpFc+b2yMgUSNyAT/H8z0Ceo2zAoJa7JEJFXadgfhPlFEgArsS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cfKrYgWc; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3w+tEw+YJi4keUfGP5wdoMfBaTRD5XxrVoj5m1gtEXsLO19O1NjxjvXejeLVDL1Ts0/lCZTevis76yVDNWBZvnekouKVnHuuFwe1muOv6WLBFyhZu6touCRxgYuYUqbbIJrOMoW2MIbqjBHQ0Pu60gLVsbggaOzOkAdwAxPXUEPIkkXJ7BVZBY7+HCH0dCBVOyFK57nf+kUvINILnyYqmowgQfOEfzCe7qGxgV+KXSrrllmlC3yGzURmPpJ4B1gIg4Gku16UCeJozOm3HKc42Hi3fXIDp9RGzlG59YNRJizqjHaTsQjme7wrp5DSiAdLhCHV2bqTF7AOZiOERFf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWgNPEF2Jhb7lSw9kOCtwxckxSp60BlZYGTGkOf7Cv4=;
 b=HRaazBxLPUIsYok3175fmejOrzmaihlJJQ75oBJwN7LwXum9yUszvj0z1PXgKlh1jMxtyUQYE0R3dDcxrf7BhPn7Pna3A2rvlu1hHDFY9HGVXO0WE82WknUb8AnPDbUsRl5zj2uOhhxN0rWBFNfGcDmLFWJ7Mbu7l2F4KR6Sg+N6izzoUyTvHOzNeQALElsq/Yz4Iq66VE7SslLsQ49N4aMzoVoYGW+E41Pj6N3ioKzzSiEA2RlkYtTd6HmIWP/UfykaIl7qeZt832PEf0Thymc+P3U0hifpftvHi9LuEo1ae9H6YkIddNkJnq6URHsiFDmniXg0fdR5EvZjllsJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWgNPEF2Jhb7lSw9kOCtwxckxSp60BlZYGTGkOf7Cv4=;
 b=cfKrYgWcN2Dx+oG3ygzNc7lpzw3O9BxYjEiXJ3cZl3tcu73y7qOlibkhgX1ViROmZKxFsXosZrAjj5TB5uZYNLtYJGDazO3HA61F15f3lIkYUGP3optbZ6jqu8AIpk/JskGJGZ05uAvdLgja427p7nfeM0VPheRmbwv1gsc4BJiPeIuBmi10rbxJCex+MaDPY5QPc3K+D9qCZqvwXf750KcEvi5sSQoTR9/ucsql8kT4YDhxZGtth0LKZRKVWrfO6KcYQSeoT+ZTqZjsAsUb3aa5bE/FO87/lN16Y3h6fWItVi58SDQ9sViGC/qBYLhQSYRi1aABHHphOlJGTqRVPg==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by IA1PR11MB6441.namprd11.prod.outlook.com (2603:10b6:208:3aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 11:26:06 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 11:26:04 +0000
From: <Divya.Koppera@microchip.com>
To: <pabeni@redhat.com>, <andrew@lunn.ch>, <Arun.Ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<richardcochran@gmail.com>, <vadim.fedorenko@linux.dev>
Subject: RE: [PATCH net-next v5 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
Thread-Topic: [PATCH net-next v5 2/5] net: phy: microchip_ptp : Add ptp
 library for Microchip phys
Thread-Index: AQHbRWDeoKQTJpwn0UGXX3zNeIOo77LXapmAgAASttCAAAPPgIAAAfZQ
Date: Thu, 5 Dec 2024 11:26:04 +0000
Message-ID:
 <CO1PR11MB4771822A51BEBDEFF9F51B11E2302@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241203085248.14575-1-divya.koppera@microchip.com>
 <20241203085248.14575-3-divya.koppera@microchip.com>
 <ec73fe36-978b-4e3a-a5de-5aafb54af9a8@redhat.com>
 <CO1PR11MB477140866E76B0FCEFA05735E2302@CO1PR11MB4771.namprd11.prod.outlook.com>
 <946b59e0-18f9-4e4f-a3c9-3de432db4340@redhat.com>
In-Reply-To: <946b59e0-18f9-4e4f-a3c9-3de432db4340@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|IA1PR11MB6441:EE_
x-ms-office365-filtering-correlation-id: f9fb9df2-e19a-436f-127e-08dd151f9b2d
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUZGTVkyQitMejIvaWFneTRkcEh6c21IcDB4NVNwL0kwTC9BRXk3WUpDb3BT?=
 =?utf-8?B?aUpxK2VLdDVseVh3blJ0cERXOVk4d1dYN2lFWkE3SDJqYmlLZS9TWENLb1JV?=
 =?utf-8?B?d3VNKzQzbU4wb2dseDJCWjgzODdNc2Z2WkpHVnRSQ1ozV0tMR0NvV2V3TmYw?=
 =?utf-8?B?MlVTenczNXNiQVhUZnlHMWwxK3BsUFhQYUN6cysrMlNlTE0xKzQyV1VCd2Fl?=
 =?utf-8?B?M3hZWDhTdlFMd2k1Z1dCREsyWmwwbVg1QlBVMno5NjgxaXpDL2g0YW04cnBI?=
 =?utf-8?B?b0lFaTlyMnRIL2hlZDNFTEFrbUllc0UwaWM1ZytDZFlGMS8weXF0MVFXa2RD?=
 =?utf-8?B?MTFEZ21yRjlobjI1ZVJPNmp5R3B1VzRBVkZ6amRGbWpCaU9yVWY0VWRObzg2?=
 =?utf-8?B?U2NhZWRpQW1uUXQ2MFFRZVRnM1lKL2RGdWNqQldVcUtxTUN1R0o0UnBCNFNp?=
 =?utf-8?B?c0ZJVGlaTmlNVEhoRy9ScEJ6dFRjNDEwZzJ2TFRVanBpYjdFREl3ZlkvcVNE?=
 =?utf-8?B?RTZiNTFQU3FiRUFmb3VxT0Q4elVNdThXZDdBVkhXQUpPQzlzUU50SGpWM0h5?=
 =?utf-8?B?QVVMUzhWSDJvcGkvb2E1SXpjZzhlbUQ2UXdwcFBFczAvemVvY1V3REV1Ylgv?=
 =?utf-8?B?bk1zc2czb25nRzNFVC9PWW02NG9uZGxVYk9ROGY0Y2RFc2Q0ZTVkNlZkZm9V?=
 =?utf-8?B?d0JNbnRjaFBmWTlQUS9sbjY2QXo0cVlrUXNYYnN0WllZckxqZXM5YXZlQnNK?=
 =?utf-8?B?RDNDcy9GdjA3Y0RhTTJmLzhBazFJM2dxZHd5cG4wcEozOTFpV21Ib2VPQTNl?=
 =?utf-8?B?dS9sY25SODNWdjFmRHptemlISWZKQUQxd3B6NzBLdGJacmQ3WVljd3JlNnly?=
 =?utf-8?B?aVljaDFpeWZmZ0NQdHNlaFgzUlpBbjRpRk44Z3VqaHFZcW02b044OEt6S0ZC?=
 =?utf-8?B?ckQvcy9ocitSMVJmTXFqZlBIUjNnUDRnbEdMaG8rQTJ5QXcxekRBRmt2bXI2?=
 =?utf-8?B?dTBXZ2lWdWlZZk9yRjZsR3Fyd2d1My8rb3VvMHNCRUIvVHBYTDQzZ3NmNVJV?=
 =?utf-8?B?Wmd1WVBnM0RCcXBtaUtObXBxeU8zbTl4dGZWZHVEVWFmeXlIZC9DcFY3azZo?=
 =?utf-8?B?WTN5WVVWMER3MEZOSDFJTDVlTThqSHN0QW1sakR1citDOStRcTc5UHl0clJE?=
 =?utf-8?B?YzN2bXBkVjByNEdodHNKc2lxMkNiMGxBQVF6eityaGhNWU9mSmtHUnM5VjhE?=
 =?utf-8?B?eE5RQXRZNW9PcnNEalE2KzQzb2U2eWJNZHl3RmVIT1ZWaDFVK1BIR2lKc2Va?=
 =?utf-8?B?T2RJT2lvckhpSzBWT0o5aGFISWtrVjZxd3NONHBlS1FoTTFBWHJvQ2NQWnR5?=
 =?utf-8?B?a1lxMUw3Nk81SkxCUGZpcUdyblZTekExNURTbTM3QjNhMTF3RFFEeEFlN29i?=
 =?utf-8?B?WnVBU2ZvOHRRMEFoa2ljSk9sWXU3YTBOZkp5NHQ4dTgveG1tWm9lbkM5aE5Z?=
 =?utf-8?B?SG5mRSsyVUpPVUJqd3ErNWM2UVcxYnJnZEFvcFFtYTA4NEhKT3o4Qnh1V090?=
 =?utf-8?B?L3VlVkxmRzRUM0RxMmJUVkRoWnphdzYxSVlubFd2c2lIWXBkQ1VvdnRPQ043?=
 =?utf-8?B?ZHhWRjdyYnhkVW5MT0VqRnkxcy93YlZ6dm9GdEZaaDFXSGZMUXZwdmJhNUZm?=
 =?utf-8?B?eDhnR1dFbUhyRWZEU3FlbWN1Q0gxQnJ6OUZEMnVSWWdraUFmYWtEZVk5STlO?=
 =?utf-8?B?ZVF5UU5OS3A1TEU1Wi9UWlltd3lRUjVRUlJCM1M0eWN5Zm1qU1Vxa29LRGwy?=
 =?utf-8?B?N25xY1BIZnNoQ3NRWUdSdTdsaUdaVlBPZXhUT1E1V0xuT0lhTlgvMGVYeTRW?=
 =?utf-8?B?KzFzQmJqdlRYT1ZZa2ZoU1gzVVdtVXZtZDVSL250dXc2S1FGMXFMNXp1OW05?=
 =?utf-8?Q?4tUxPPFs7+I=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEIyQyt6YU4xU3pMTS8xRXgvMThzUlhnaGZFOG4zOWZtc2N5OXl0N1pycXRw?=
 =?utf-8?B?Y0ZaZ0EyckJBeCs4VlI3NkZJajgvdjdyNFJmcWdmaWFITEpORU80dTZJL2ND?=
 =?utf-8?B?SW14a0h1UENYSFJPZmtmTjN1NG45S05tdDErc0lvdDkyaVZtcE1pZUNxWkMz?=
 =?utf-8?B?QUtuMkZJTWs0dlowTGhvK0E5R3luZjBlcXhNOE5DWmozTlBlM0ovUUNvVlYx?=
 =?utf-8?B?blpHdWtkRGlmVE90UmJpRUhrbnB3bTBCMVAySHFMZTk5eGUxSVMzNStvRTQ3?=
 =?utf-8?B?WFArYnFKeE9lRGtLZnExQWw5dVpJczVVMUkzUGE4UDV0bjhZbklyMnNRbXpK?=
 =?utf-8?B?OEg1bk91YThhOFgyTmNPU1BjdzJUbG9xSy9hK2JGcnZEYTNZTVdKUWlnMU9F?=
 =?utf-8?B?RzluL2xjYnFvRVZmZ3lySDEwejQ4NnRnZnJ2ZFIxTUpzNVlFdEtMZmZ5ZlQ3?=
 =?utf-8?B?eWJmQ3dUajJEZjZiZWZ6R2JyS014L0pGQlpkbDB4UTQxa1NzbDRZRCs5SjFC?=
 =?utf-8?B?WGZmblBiU29jbUdHTnVJbXVYSUk4R3UvNThMZXg4dGxGdHJMQy8zVHlWZnNP?=
 =?utf-8?B?TmN2WE9rUE5EdXA3MG9laUJhMWNoK2tYUHdWR1YyTnN4MGhwNko0b0NpQitK?=
 =?utf-8?B?bnFlL1Q2QmwreGJ0UjE2eDNoeXlJenhKQVZXMzY3UTJ0eUM0a1JadHZVNCtY?=
 =?utf-8?B?bnQwMmdmbHpoSWp1M1NKYStkMFBUNmMyazVLTGVrNlQwNEpPdEpFdVZkTjFI?=
 =?utf-8?B?bUdIczRUZnJCdjF6VnJqUnJDbzNtRlVIaTJCWEJlaUkrNmdWUG0xT0VJVHIw?=
 =?utf-8?B?bFg3c21YekVEVW9MUU9JRDlQd0UraEVFaUU1RXpERXpFM1RFOUt1V2UvVmJr?=
 =?utf-8?B?OU1YU28yOEdtcXRDaHplNTdCNGVjTXFlYnhON2JkRThyZ0Fwa0dMdW5Zc2V6?=
 =?utf-8?B?OG44ZnM0MVdJWk5qcnFKUy9qOXJ5SEtyNFloTHVHRmtmMENueWo0ZER1QVd5?=
 =?utf-8?B?TVB1dDdraFlBZjAxc21PWlJmTHgrdzUxMW5OM2pTdHJnM2dLLzZiTkYwQlZ4?=
 =?utf-8?B?S24zK3JnSkRzWm82ZFdJQXU2aDdQOE9Wak9JT1Nmd3dTZVhDd0FIMndoalNz?=
 =?utf-8?B?U04xbWpEekwvU0ptVGIwWkpsVzNPVzRLSmYrMkU5ZkVxVUw5MzVncGxmcUQ3?=
 =?utf-8?B?c3l0ekozaGpETTYzSEU1STRIa2M2TTdKWGp0SHdQM1FhVXJ0Z2R3cjJBbEth?=
 =?utf-8?B?eUljaVU4R2wxOXI2RnlYSTh2T2FFZ1NRMURVWGs2dkphUnltRjRQUVZFcDFz?=
 =?utf-8?B?RXdWL3R0SmRFMGJtUEdkU240ZEpUV2VEbzBhMnkrcjBIWlZUUU9nMTZPNE95?=
 =?utf-8?B?RWhWajgxNjdPWVVBd3R2WWxXMVpUZGJTZnBZYkdnWjRuTGJPaGY4anhVN3Bq?=
 =?utf-8?B?RkFJZi93cnhkNGkwNXdBMk1sTEtrSmxya3ZuUXA0Qm1Dc0dDdlpicjQrNkMy?=
 =?utf-8?B?T2xLREhObms5MjBZQUQyaytaMFd0dUptelV6bkxhNDRGTVI4dDBHK1NQclpN?=
 =?utf-8?B?aU01SGdVSWR4cmUxNVpNT1I2c2hYZzc5ODhvbVlNSlZYaVpNSDh4WU55VUpF?=
 =?utf-8?B?M1NQRW0zdlhrOXFRSURVMmN6WTFrc3RMcXFhcS9SRklsUVBydlJoZlFIV1pM?=
 =?utf-8?B?WndORlJ2dnNQV0E2Z3YrOHBCUG5aME5Jbld6SlBwNjk1eWZzVU9DN3ZWdkZu?=
 =?utf-8?B?Rlo0TDRWcHZoNk91ODRlRDkxYXhyZ0hYUnlGOGI1QWJjMG8rbWphTzdIZWhC?=
 =?utf-8?B?Rm5zN1Q0dTJUVGxVT1JvazhaU1ZjL05reW9DTEszTTNYbmtrdmN3alV3K2tx?=
 =?utf-8?B?ZjQ2SXdMZTRjYkg5enRvSEFrcGo2dU10MytGazI0S0xseVd6VDJabEpyTFJR?=
 =?utf-8?B?NlAxWXp0VVQ3NXdEeGc4K3pZK1hLdHR5dUc5ZjVqSkJlQTMyZzlCeUI2MGFN?=
 =?utf-8?B?dk9JbjNtc3hXdmw0eEZrSmtqazZmSnp4d3Erakc5RE10OXhYQndsb3Z2eUgx?=
 =?utf-8?B?ZVFLZHBORS9BSlFHcVZoK3dVT1ZlNElBejYzZmk0TGtuU3JjVUNibG1VcFMr?=
 =?utf-8?B?eGc4NG9URUVVL08zODRZaEl4UDVhdUdicS9BdmZ1SlpLdnVoNWlFenF0bGl5?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fb9df2-e19a-436f-127e-08dd151f9b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 11:26:04.7907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ZFPV+6SxdTy4JmCWWfggPfnMue6AfgRWO5BzFo2FLF5ETk62SgTl08oOww/WlcOEq39MbTD5rIhJvtLsRWpAy9dBD2slSuWNE9VwKI8c3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6441

SGkgUGFvbG8gQWJlbmksDQoNClRoYW5rcyBmb3IgeW91ciBxdWljayByZXNwb25zZS4NCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciA1LCAyMDI0IDQ6MzggUE0NCj4g
VG86IERpdnlhIEtvcHBlcmEgLSBJMzA0ODEgPERpdnlhLktvcHBlcmFAbWljcm9jaGlwLmNvbT47
DQo+IGFuZHJld0BsdW5uLmNoOyBBcnVuIFJhbWFkb3NzIC0gSTE3NzY5DQo+IDxBcnVuLlJhbWFk
b3NzQG1pY3JvY2hpcC5jb20+OyBVTkdMaW51eERyaXZlcg0KPiA8VU5HTGludXhEcml2ZXJAbWlj
cm9jaGlwLmNvbT47IGhrYWxsd2VpdDFAZ21haWwuY29tOw0KPiBsaW51eEBhcm1saW51eC5vcmcu
dWs7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207DQo+IGt1YmFAa2Vy
bmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gcmljaGFyZGNvY2hyYW5AZ21haWwuY29tOyB2YWRpbS5mZWRvcmVua29AbGludXgu
ZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjUgMi81XSBuZXQ6IHBoeTogbWlj
cm9jaGlwX3B0cCA6IEFkZCBwdHAgbGlicmFyeQ0KPiBmb3IgTWljcm9jaGlwIHBoeXMNCj4gDQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlDQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMTIvNS8yNCAx
MjowMCwgRGl2eWEuS29wcGVyYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiA+IEZyb206IFBhb2xv
IEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4gVGh1cnNkYXksIERlY2VtYmVyIDUsIDIwMjQgMzox
Nw0KPiA+IFBNDQo+ID4+IFRvOiBEaXZ5YSBLb3BwZXJhIC0gSTMwNDgxIDxEaXZ5YS5Lb3BwZXJh
QG1pY3JvY2hpcC5jb20+Ow0KPiA+PiBhbmRyZXdAbHVubi5jaDsgQXJ1biBSYW1hZG9zcyAtIEkx
Nzc2OQ0KPiA8QXJ1bi5SYW1hZG9zc0BtaWNyb2NoaXAuY29tPjsNCj4gPj4gVU5HTGludXhEcml2
ZXIgPFVOR0xpbnV4RHJpdmVyQG1pY3JvY2hpcC5jb20+Ow0KPiBoa2FsbHdlaXQxQGdtYWlsLmNv
bTsNCj4gPj4gbGludXhAYXJtbGludXgub3JnLnVrOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVt
YXpldEBnb29nbGUuY29tOw0KPiA+PiBrdWJhQGtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJpY2hhcmRjb2NocmFu
QGdtYWlsLmNvbTsNCj4gPj4gdmFkaW0uZmVkb3JlbmtvQGxpbnV4LmRldg0KPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIIG5ldC1uZXh0IHY1IDIvNV0gbmV0OiBwaHk6IG1pY3JvY2hpcF9wdHAgOiBB
ZGQNCj4gPj4gcHRwIGxpYnJhcnkgZm9yIE1pY3JvY2hpcCBwaHlzDQo+ID4+DQo+ID4+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91DQo+ID4+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiA+Pg0KPiA+PiBPbiAxMi8zLzI0
IDA5OjUyLCBEaXZ5YSBLb3BwZXJhIHdyb3RlOg0KPiA+Pj4gK3N0cnVjdCBtY2hwX3B0cF9jbG9j
ayAqbWNocF9wdHBfcHJvYmUoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldiwNCj4gdTgNCj4gPj4g
bW1kLA0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTE2IGNsa19i
YXNlX2FkZHIsIHUxNg0KPiA+Pj4gK3BvcnRfYmFzZV9hZGRyKSB7DQo+ID4+PiArICAgICBzdHJ1
Y3QgbWNocF9wdHBfY2xvY2sgKmNsb2NrOw0KPiA+Pj4gKyAgICAgaW50IHJjOw0KPiA+Pj4gKw0K
PiA+Pj4gKyAgICAgY2xvY2sgPSBkZXZtX2t6YWxsb2MoJnBoeWRldi0+bWRpby5kZXYsIHNpemVv
ZigqY2xvY2spLA0KPiBHRlBfS0VSTkVMKTsNCj4gPj4+ICsgICAgIGlmICghY2xvY2spDQo+ID4+
PiArICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiA+Pj4gKw0KPiA+Pj4g
KyAgICAgY2xvY2stPnBvcnRfYmFzZV9hZGRyICAgPSBwb3J0X2Jhc2VfYWRkcjsNCj4gPj4+ICsg
ICAgIGNsb2NrLT5jbGtfYmFzZV9hZGRyICAgID0gY2xrX2Jhc2VfYWRkcjsNCj4gPj4+ICsgICAg
IGNsb2NrLT5tbWQgICAgICAgICAgICAgID0gbW1kOw0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAgLyog
UmVnaXN0ZXIgUFRQIGNsb2NrICovDQo+ID4+PiArICAgICBjbG9jay0+Y2Fwcy5vd25lciAgICAg
ICAgICA9IFRISVNfTU9EVUxFOw0KPiA+Pj4gKyAgICAgc25wcmludGYoY2xvY2stPmNhcHMubmFt
ZSwgMzAsICIlcyIsIHBoeWRldi0+ZHJ2LT5uYW1lKTsNCj4gPj4+ICsgICAgIGNsb2NrLT5jYXBz
Lm1heF9hZGogICAgICAgID0gTUNIUF9QVFBfTUFYX0FESjsNCj4gPj4+ICsgICAgIGNsb2NrLT5j
YXBzLm5fZXh0X3RzICAgICAgID0gMDsNCj4gPj4+ICsgICAgIGNsb2NrLT5jYXBzLnBwcyAgICAg
ICAgICAgID0gMDsNCj4gPj4+ICsgICAgIGNsb2NrLT5jYXBzLmFkamZpbmUgICAgICAgID0gbWNo
cF9wdHBfbHRjX2FkamZpbmU7DQo+ID4+PiArICAgICBjbG9jay0+Y2Fwcy5hZGp0aW1lICAgICAg
ICA9IG1jaHBfcHRwX2x0Y19hZGp0aW1lOw0KPiA+Pj4gKyAgICAgY2xvY2stPmNhcHMuZ2V0dGlt
ZTY0ICAgICAgPSBtY2hwX3B0cF9sdGNfZ2V0dGltZTY0Ow0KPiA+Pj4gKyAgICAgY2xvY2stPmNh
cHMuc2V0dGltZTY0ICAgICAgPSBtY2hwX3B0cF9sdGNfc2V0dGltZTY0Ow0KPiA+Pj4gKyAgICAg
Y2xvY2stPnB0cF9jbG9jayA9IHB0cF9jbG9ja19yZWdpc3RlcigmY2xvY2stPmNhcHMsDQo+ID4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZwaHlkZXYtPm1k
aW8uZGV2KTsNCj4gPj4+ICsgICAgIGlmIChJU19FUlIoY2xvY2stPnB0cF9jbG9jaykpDQo+ID4+
PiArICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiA+Pj4gKw0KPiA+Pj4g
KyAgICAgLyogSW5pdGlhbGl6ZSB0aGUgU1cgKi8NCj4gPj4+ICsgICAgIHNrYl9xdWV1ZV9oZWFk
X2luaXQoJmNsb2NrLT50eF9xdWV1ZSk7DQo+ID4+PiArICAgICBza2JfcXVldWVfaGVhZF9pbml0
KCZjbG9jay0+cnhfcXVldWUpOw0KPiA+Pj4gKyAgICAgSU5JVF9MSVNUX0hFQUQoJmNsb2NrLT5y
eF90c19saXN0KTsNCj4gPj4+ICsgICAgIHNwaW5fbG9ja19pbml0KCZjbG9jay0+cnhfdHNfbG9j
ayk7DQo+ID4+PiArICAgICBtdXRleF9pbml0KCZjbG9jay0+cHRwX2xvY2spOw0KPiA+Pg0KPiA+
PiBUaGUgcy93IGluaXRpYWxpemF0aW9uIGlzIGNvbXBsZXRlZCBhZnRlciBzdWNjZXNzZnVsbHkg
cmVnaXN0ZXJpbmcNCj4gPj4gdGhlIG5ldyBwdHAgY2xvY2ssIGlzIHRoYXQgc2FmZT8gSXQgbG9v
a3MgbGlrZSBpdCBtYXkgcmFjZSB3aXRoIHB0cCBjYWxsYmFja3MuDQo+ID4NCj4gPiBJZiBJIHVu
ZGVyc3RhbmQgeW91ciBjb21tZW50IGNvcnJlY3RseSBwdHBfbG9jayBpbiB0aGUgY2xvY2sgaW5z
dGFuY2UgaXMgbm90DQo+IGluaXRpYWxpemVkIGJlZm9yZSByZWdpc3RlcmluZyB0aGUgY2xvY2su
DQo+ID4gUmVzdCBvZiB0aGUgaW5pdGlhbGl6YXRpb25zIGFyZSByZWxhdGVkIHRvIHBhY2tldCBw
cm9jZXNzaW5nIGFuZCBhbHNvIGRlcGVuZHMNCj4gb24gcGh5ZGV2LT5kZWZhdWx0X3RpbWVzdGFt
cCBhbmQgbWlpX3RzIGluc3RhbmNlIG9ubHkgYWZ0ZXIgd2hpY2ggcGFja2V0cw0KPiB3aWxsIGJl
IGZvcndhcmRlZCB0byBwaHkuDQo+ID4gQXMgd2UgYXJlIGFsc28gcmUtaW5pdGlhbGl6aW5nIHRo
ZSBjbG9jayBwdHA0bC9hcHBsaWNhdGlvbiBuZWVkIHRvIHJlc3RhcnQuDQo+ID4NCj4gPiBJbml0
aWFsaXppbmcgcHRwX2xvY2sgYmVmb3JlIHJlZ2lzdGVyaW5nIHRoZSBjbG9jayBzaG91bGQgYmUg
c2FmZSBmcm9tIHB0cCBwb2ludA0KPiBvZiB2aWV3Lg0KPiA+DQo+ID4gTGV0IG1lIGtub3cgeW91
ciBvcGluaW9uPw0KPiANCj4gSSBndWVzcyBtb3ZpbmcgdGhlIGxvY2sgaW5pdGlhbGl6YXRpb24g
YmVmb3JlIHRoZSByZWdpc3RyYXRpb24gc2hvdWxkIGJlIHNhZmUuDQo+IA0KDQpPa2F5LiBXaWxs
IGZpeCBpdCBpbiBuZXh0IHZlcnNpb24uDQoNCj4gUGxlYXNlIG5vdCB0aGF0IHRoZSBtYWluIGlz
c3VlIG9wZW4gaXMgV1JUIGNvZGUgcmV1c2U6IEkgc2Vjb25kIEFuZHJldw0KPiBvcGluaW9uIGFi
b3V0IHRoZSBuZWVkIG9mIGNvbnNvbGlkYXRpbmcgdGhlIG1pY3JvY2hpcCBwdHAgZHJpdmVycw0K
PiBpbXBsZW1lbnRhdGlvbi4gQSBsaWJyYXJ5IHNob3VsZCBiZSBhYmxlIHRvIGFic3RyYWN0IGFi
b3ZlIGluZGl2aWR1YWwgZGV2aWNlDQo+IGRpZmZlcmVuY2VzLg0KPiANCg0KVGhpcyBjdXJyZW50
IGxpYnJhcnkgaW1wbGVtZW50YXRpb24gaXMgZm9yIGFsbCB0aGUgZnV0dXJlIE1pY3JvY2hpcCBQ
SFlzIHdoaWNoIHdpbGwgYmUgdXNpbmcgdGhlIHNhbWUgSVAuDQoNCj4gVGhhbmtzLA0KPiANCj4g
UGFvbG8NCg0KVGhhbmtzLA0KRGl2eWENCg==

