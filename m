Return-Path: <netdev+bounces-106900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD1691803F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00761F27DAC
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BF417FACE;
	Wed, 26 Jun 2024 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xkpd2c4X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECCD149E06;
	Wed, 26 Jun 2024 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402751; cv=fail; b=NC7NMHz7VF9UaqxHIECzslcWUPQKQ16WIos48+cV/1SclNwkci/yquSDjv5uKxEEEpsfBsoPgtG5Rns9l3ZFstTLyGL3rxv9AZ7LqehUXBBKF7QcX1f6kgbAc6IAbGgtVJgsOO7H9oOuhZAx5wA/ClpCDEigoDMj6BeWTsvL4Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402751; c=relaxed/simple;
	bh=H1lgKvL8HR4m6lR4PQxRMxe9kCC5TBf06Ji+cNOvd6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BHS1wfhx/q7BL2wzF2lLd4Qg3peLgeIhH3NsYChapO/yzhdit78nJKT84Q0UCjpS5zg0yRpnTep145EIW8lHav18SoqvZ4T24N64K8oFXNlLtfieKOM8a3+BgV1tQwzzCpS6A32kKhSCdNH2tFWvLy8XeO3KCZ1cKvxQW4aWgEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xkpd2c4X; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+sK3ZrKidCfRtTw2Br29t2+6Aqr/PjSQx6DxbN7KTCK3+JJcTNHiiRKah2z3pOm3RqB9ra2Mf02aGd81Tc+g28jWQ7KCLIhmb3St7NNaVfZZubbkW1oXIFPnHc9KMvrUd+wzMU7yU1cOdCwy2CLKF0hmSmFSXaLhS92+nX9FpbQg1okkYLTb2CWoum+vFPtQqk1ZQIWOX83hbhb1dtEbLsNdpUQnC4Tzadt8r1WhiJe/MqAaoPzmuaSf8LoRj3CPTaxRWkaLOw7efhVa90fdMUgVctws6htphxVNCosnNR08RlQovTKUa3nd4pj2imOydJdk2GfHAgcQLSDwuyNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1lgKvL8HR4m6lR4PQxRMxe9kCC5TBf06Ji+cNOvd6w=;
 b=MRpyBPXOiaxfFOGdvN1kVGnc4HU5/NZ9y1FeXZ4pTw32TInw55apMrQiJmWpwdfKCiyvZk3f5kBL5d80QUqGxJ8ZZajBinHkJDtMotun/CdvcVbqlTxab4oXvfhIHEyMmcl/q/Z90UXUMY1vMK/aHt64GQzcQINj5ZRWO143s9hEG5jTr2d9YZIAMOcZ8Xnb40xeaqzlc8dqDPpKfPit+W7C6wBYsQ2FCvkbFs8kQjIe276W5N+ilbKllXMJnnTAolRHNJaFVOs+o8hGOc2HC+HSzzvIMhVK8MPcCHfuIv+Gekp2rwLgKJHdPoelvELskfYP+ISu88fjRZrJmjJXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1lgKvL8HR4m6lR4PQxRMxe9kCC5TBf06Ji+cNOvd6w=;
 b=Xkpd2c4XRIy8sL4AcKEBbW7Lud+QBSkjQH+JauwKeNkKVlLTY2KEM9dIrekSYF6jV7WCfkJm31jJaiCbEo3kNrwe+7l08gFgxM/q2KRI7UHkNG29g+MSVovWf3l3H7LI/YYG0DUViEqod3Mr06GHzDh4gQ4SMRZCUyTDkYWWDIjvD32kZIow7Yf3MDDos7uanixWOu1/xPoJOFnnHLUdHi/diiAnkJQQgyP/AMcnJIHXI1ev2YN4yht4fbi5qh7TmKil38E0a2qWAqqDoPVtmYVmYt13snH+O4+YfI4ROpMPV1O/xJJlHhEzzGf2lm1pY2nPa1FV+ZZB5u9C/mvkEg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 11:52:26 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 11:52:26 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>
Subject: RE: [PATCH net-next v7 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Topic: [PATCH net-next v7 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Index: AQHaxl9qSClTcs0l902JzHpAxldWxrHXUtgAgADOufCAAc1zQA==
Date: Wed, 26 Jun 2024 11:52:26 +0000
Message-ID:
 <DM6PR12MB4516907EAC007FCB05955F7CD8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-8-danieller@nvidia.com>
 <003ca0dd-ea1c-4721-8c3f-d4a578662057@lunn.ch>
 <DM6PR12MB4516DD74CA5F4D52D5290E26D8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
In-Reply-To:
 <DM6PR12MB4516DD74CA5F4D52D5290E26D8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|MN2PR12MB4063:EE_
x-ms-office365-filtering-correlation-id: effa6163-2e9d-4c54-e006-08dc95d672f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230038|366014|1800799022|7416012|376012|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?cW9NQmNvcFhwck1rTVVQK2o5bTFPZHhmaVR3YnZMSjR1ai9qRWZtNDA0cVNq?=
 =?utf-8?B?M1c1Z2YvR1E1VUdES2hIQ1ZRTFBQN3JnNFVjSTF1eEEvV0lPUVFFZ09Jc0Y2?=
 =?utf-8?B?MllMSXlMT1I0Qk5qcHF4SnlvOU95UTJYUlR0NndyNlpCVG1YYzRrdktITHJO?=
 =?utf-8?B?bjVUdUJZV2t6NFR4MVA1bFFJQWJ6RVoyazl6dHdUUFFWNlRuNXViKzFVNUdx?=
 =?utf-8?B?b2lQcDBJTHhEWjA4UFF3QWwzcXRUVUgzUjNpN2lrTjBHZHBwNGV0RDV4VWw4?=
 =?utf-8?B?M0gwaGI2YUt5VHFDejA0WUtway9yaHkyRGJoVk1LdGs1emR5dEZMT3daWHJC?=
 =?utf-8?B?ZkhmaGtvbDBzTTlkLzRuT2o3VExYbk5OWWNpaXREUGp5VmZnT0VjZzMyUS9h?=
 =?utf-8?B?R3dwYjFieU4xRFdyRTlaOVVZeXYzMThuZ0QvblkrVHFiTFplQ0YzekFWQlYr?=
 =?utf-8?B?WnJGRHpFMmtqQkNSVnovQVI4WDVSM3lMa1NDdk9jTkloalFQbnhnN3BPb29O?=
 =?utf-8?B?WlB4T1Z1bmhCQ3VCRVFTMS84Tk9WdWdmZ0VweDk4REgwcHl2cGtqZ1RNeTE2?=
 =?utf-8?B?RHF5dWtwR0NJTmp3cC9VdFRBTlpMSzN3WDN1MXR4d2lXTVB4SHNjd21RQm9G?=
 =?utf-8?B?Yk11cE8vWE1oRTN3N25heS8wTy9IaHAzQTBtcURhTFZVV1NBd3NYcTRzbmh4?=
 =?utf-8?B?VkZ3WUs3WFpiUmZpYWEyU1ZMcDA5UnZsK0FESEZOZCt6UUxzZGpqOWg5aklP?=
 =?utf-8?B?MmhSWHZMSVNXMFpIR2dzZHM4cGJtTGJReUJRdTVkOHJlbU5ZMktrS2VZSG5O?=
 =?utf-8?B?RHZFVE5URHZ6RXVQV0NUbGdIc3hEa1o4dk1mVmQ5VmE3RjdXaU0vUzU5WnZE?=
 =?utf-8?B?SmpxSFIrdnVRVmRsRHEzSVdVanNPZ21tYmxFT3duRmpvbi8zZThkdEZVRGIx?=
 =?utf-8?B?SW1rbE9vN3ppT1ZvNStLaWFScTJ5YklJekhjQWY4bGcyVzZQNnVrODRFWUFC?=
 =?utf-8?B?cHF2VUJEeEJVK1gwSER4dTVoVXlPZTZIUFF4ZlhoM2N1LzlOeldJdmdJZ0N0?=
 =?utf-8?B?bnhIc0h4R3J1SjBOUFpsYjFtZSs4eUo5MXZEZXhQNVlwQjYvMVNtT2poS20x?=
 =?utf-8?B?cjM2QmEwZ0hpV0FXRVVqSHZ0ZnJzOHIrWnpjZ3A4NHVpRkRXaHMyWk1ZbEdV?=
 =?utf-8?B?ZlNjVU8xWjJHM2RNaytBYjF2RUYrbG5BeFlYenNQTUpBRVR1VzJkKzBldUFw?=
 =?utf-8?B?TnpMVGZaRkZKeWVOSGllNHVKQnlFSzNRUnFQRE1CQkYwUmRveU5xaVRpK0pR?=
 =?utf-8?B?SElDSndQck9pZEtBL21LNlhKdTNMT2hnT0kvQXhkRGFnRjY4Yk5MUllOa0tM?=
 =?utf-8?B?bS9JS2o5alJmdGVQQnFJNlhPK2tqNS80d1VYM2JkNkJLcGNyRVlRd0hib1V2?=
 =?utf-8?B?YlNCMENLNmM2bnRUTWRxS1Q5MFRqcUwra01VSzRubUxMeFZyWlFUY083azdt?=
 =?utf-8?B?V2JYT3M1Qm9YM3U0Rm5tUGxUUFBhMFd2OGs5Mmo1Z3dROXJobVVCZUtjV3Fi?=
 =?utf-8?B?M0YzdEVLWnBZNHVGV0Vod2lRRzcrd0h1cTVhMFBkU3JVVURldld2ZGsrZDJ0?=
 =?utf-8?B?RHpqQXVHZzVZNks1MVlsditzR0srOGg2dGk1K0U4ajNMT3JHZmtBeVRPTEZQ?=
 =?utf-8?B?akNWRmxKWlQ4SWJpZnNMUHRmY3JZVWF6aXJlMm90ODExcjRwYjZ0RTNuTTVp?=
 =?utf-8?B?dzN6U0FGUk1OOGphbDhkbGJyaU4vMkZlTHh2a0VWaWhkaTl3UzdLbWc0cEl6?=
 =?utf-8?Q?O1Ld2lEMzZCmmwBLFEcCYukeEJ7LqmqvgkM3Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(7416012)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmI2RUc4VmxXRlE5aVlDVmlYMzhkblRQa3JmYXhnOHllSkdXYmZoQXpYWUlS?=
 =?utf-8?B?MjlsZFVWWVFtNDJZSFVTVXI2UkdiaTZxcWJWdEFCRjdoRlVYRmJ6UmhUVWc1?=
 =?utf-8?B?MlhpVmlUWVhWZGtZZXR2QWVsVnJqbEs1NndROGcra252QnVSYWExSkt1Vkd3?=
 =?utf-8?B?V3RCYzRES2oySXl6WGN0MmJCR1JXUmxjM2Z2OUdYOUV2WkVuTjNhVThTSHNs?=
 =?utf-8?B?RjBYdEw0Mk5WT1hpdU4rNVJ2eUJMbGlCUmVwZklJZnl6Q3RET3lIdlJpRXJm?=
 =?utf-8?B?SlR3TGNkL3dhbGNPL2t4STNURnhhUnA4WUNVWUl1SWQ1dDJCQXlJbHFCem5k?=
 =?utf-8?B?TzBFQlhLaWRmUzdTSVI0eDU5d21qK0JnU0svMDNybE1qUGh5bnlmUUFuK2FC?=
 =?utf-8?B?eWppUFR5TkhjNGo0Y3pnSVY1Q1hQc1JuNUlDeS9wZHZEYndwRk9FRC92c3Yv?=
 =?utf-8?B?TDY5U0hTRTZXdCsxcGtzNHd2SnRETGFxbDlqK0xUWisyM00vSVhZSlROYjNX?=
 =?utf-8?B?ekZNZ3AxanN3R1FpVnYyOEtGV3RTbVdyWEt5YXFGUXdueVRlV201UXdlRzZ1?=
 =?utf-8?B?SDZXaXd3YmxxLzBvaUxwR2JJVmhraTlvTjY1Z3RoOXc2a1d6bmhaUzV0ME5w?=
 =?utf-8?B?NzY0SWxhandzVWlDMC9YSDNlWmtMazJNYjZqcWcyUXNnaW8yMDBSektaNE9a?=
 =?utf-8?B?L1hjcUM5a1cvcXFxUUZhQUViR2lyOWI2UThMTTg4SHVJRXlUUjdDenJ4NCt2?=
 =?utf-8?B?NVp1S3NaVWVqSmVYZEIyNlcyTTBGQml3QXFTNjVMeUZCellTMG9VZXZzYzVQ?=
 =?utf-8?B?Ukl4WCs2eUNoY1NyWEdZYVRSTEI3aUJyKzFBTmJBZDNMNzd4YU9XYnNvdWJk?=
 =?utf-8?B?aXhWUG1qMXFJdVJ5VU5yR1lJaUkyNmVVU2NMaVEvUDQwS2NuMHhodllZVXF3?=
 =?utf-8?B?d1liSnloZWcyMHhYTVA0YTJ5Q2s0am9vSkw4QU9xcUtiSThRVVhKb0lVWW4y?=
 =?utf-8?B?VjFMWmxpNk1Yc295SkZaUlVZeG9za2kxYUoyK25IUE51dVlxUmsyeDFNM3hw?=
 =?utf-8?B?OFpjazA1aWNPeEk3RkJPbmJZSE5jU1IzVmgzYUk2eGtNZUY0cDhHaFBsR2px?=
 =?utf-8?B?QUs2dFZ1K2RvRFdKNDdsaVBaQjNtYVlZbTRXOGhlTUxmWWttQ1V6Tk9FTE5h?=
 =?utf-8?B?alY3M2JyUTBOazFaaDNaZm1aamk1Ty9EQkVWcW52RlRQeitydThzL2FZOFVj?=
 =?utf-8?B?R0s4LzV6UFprTWVPT2ZGVnc5cGJ5RmtxdkpLVUx2V09oN21EbCtHZHFHbXJK?=
 =?utf-8?B?Q0FwQXdTNW1GK1V3RTM0ZlhTdXVlU015eEdNU25XR3hSU0lNMWsyeHFENXFG?=
 =?utf-8?B?elAwT3RZRzdVcXBtWTZWTlNQQWJFMk9aenNIYjdBNGpCbVJNM3BZNUFCU3V6?=
 =?utf-8?B?UW53Z1htQWRjNDE4NWhQTEFLbmFnVHRNVDI2U2JLVnhyTlM5R0xqL1RFWW81?=
 =?utf-8?B?eVB0WEYxV09rc2FoV1dFbXAvS0VxbHdTVzRxYnJHWWRiUXBJcGpYQWdsT0JE?=
 =?utf-8?B?akNMZWZGdEsxMG9aUnBHQXFEdEE4OG05YUt3SGZjN2lUaXRpREhhZW1aV004?=
 =?utf-8?B?ZDUrN3ZGZG85ekFteklTU1dpUlV0YzBkNm42c2EzK2dpdmxTd2kvcklicUQy?=
 =?utf-8?B?N0Z0SC9rZCt6blljNzdZSEhkU1RJbzdWbXdxRm9Fdi9aZlkvL0FmME5jWjMz?=
 =?utf-8?B?SDNzWDcwbng3UFRWZCt4c3NOaVcxNUVxM3NlQ3piQzE4S04wZXUyK2RXQWtP?=
 =?utf-8?B?NFlEYTBXZ1BVbjBnWEI4UmZLcDVjbmxqZ083cDNvMTFhVFcveloveXAxbjVF?=
 =?utf-8?B?eWRKckRCVCtZbWNYTk1mcFdrZE1pd2hYQWNiTUg4bXBMNS84OEdBUXM0dXAr?=
 =?utf-8?B?Y09oWmw5QmpMUk9zYTFkQ0tWWjdwcHFpcm16OFZEZ0ZpUDRrZ3lIc21oMWk1?=
 =?utf-8?B?NmpHcjBRY3hZcURGYU84M21qRk9wdDM3NXFzaXFnTm9uTTcxRWRJZk9zWG1j?=
 =?utf-8?B?TTJxTHhiSDlyeXgzN2Ivdm42cXV4YWxwTmFnUlBMLzRTN25tcmlYSDNQTGhT?=
 =?utf-8?Q?9JqbUMH9Nt0dKTynKObhpnwQW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: effa6163-2e9d-4c54-e006-08dc95d672f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 11:52:26.3655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEvKZDOiKTPQcLd3WUtMCerw+lCCvx4MlKz01udMMpfQeTpoh3wMNWiPAZlo8Op2jKA59T5OgjkImtW8wkSszw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063

PiBGcm9tOiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlkaWEuY29tPg0KPiBTZW50OiBX
ZWRuZXNkYXksIDI2IEp1bmUgMjAyNCA5OjE0DQo+IFRvOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1
bm4uY2g+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0
OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQu
Y29tOyBjb3JiZXRAbHduLm5ldDsNCj4gbGludXhAYXJtbGludXgub3JnLnVrOyBzZGZAZ29vZ2xl
LmNvbTsga29yeS5tYWluY2VudEBib290bGluLmNvbTsNCj4gbWF4aW1lLmNoZXZhbGxpZXJAYm9v
dGxpbi5jb207IHZsYWRpbWlyLm9sdGVhbkBueHAuY29tOw0KPiBwcnplbXlzbGF3LmtpdHN6ZWxA
aW50ZWwuY29tOyBhaG1lZC56YWtpQGludGVsLmNvbTsNCj4gcmljaGFyZGNvY2hyYW5AZ21haWwu
Y29tOyBzaGF5YWdyQGFtYXpvbi5jb207DQo+IHBhdWwuZ3JlZW53YWx0QGludGVsLmNvbTsgamly
aUByZXNudWxsaS51czsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IG1seHN3IDxtbHhzd0BudmlkaWEuY29tPjsgSWRvIFNjaGltbWVs
DQo+IDxpZG9zY2hAbnZpZGlhLmNvbT47IFBldHIgTWFjaGF0YSA8cGV0cm1AbnZpZGlhLmNvbT4N
Cj4gU3ViamVjdDogUkU6IFtQQVRDSCBuZXQtbmV4dCB2NyA3LzldIGV0aHRvb2w6IGNtaXNfY2Ri
OiBBZGQgYSBsYXllciBmb3INCj4gc3VwcG9ydGluZyBDREIgY29tbWFuZHMNCj4gDQo+IEhpIEFu
ZHJldywNCj4gDQo+IFRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaGVzLg0KPiANCj4gPiBG
cm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+ID4gU2VudDogTW9uZGF5LCAyNCBK
dW5lIDIwMjQgMjI6NTENCj4gPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlh
LmNvbT4NCj4gPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj4gPiBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUBy
ZWRoYXQuY29tOyBjb3JiZXRAbHduLm5ldDsNCj4gPiBsaW51eEBhcm1saW51eC5vcmcudWs7IHNk
ZkBnb29nbGUuY29tOyBrb3J5Lm1haW5jZW50QGJvb3RsaW4uY29tOw0KPiA+IG1heGltZS5jaGV2
YWxsaWVyQGJvb3RsaW4uY29tOyB2bGFkaW1pci5vbHRlYW5AbnhwLmNvbTsNCj4gPiBwcnplbXlz
bGF3LmtpdHN6ZWxAaW50ZWwuY29tOyBhaG1lZC56YWtpQGludGVsLmNvbTsNCj4gPiByaWNoYXJk
Y29jaHJhbkBnbWFpbC5jb207IHNoYXlhZ3JAYW1hem9uLmNvbTsNCj4gPiBwYXVsLmdyZWVud2Fs
dEBpbnRlbC5jb207IGppcmlAcmVzbnVsbGkudXM7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7
DQo+ID4gbGludXgtIGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1seHN3IDxtbHhzd0BudmlkaWEu
Y29tPjsgSWRvIFNjaGltbWVsDQo+ID4gPGlkb3NjaEBudmlkaWEuY29tPjsgUGV0ciBNYWNoYXRh
IDxwZXRybUBudmlkaWEuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjcg
Ny85XSBldGh0b29sOiBjbWlzX2NkYjogQWRkIGEgbGF5ZXINCj4gPiBmb3Igc3VwcG9ydGluZyBD
REIgY29tbWFuZHMNCj4gPg0KPiA+ID4gK2ludCBldGh0b29sX2NtaXNfd2FpdF9mb3JfY29uZChz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2LCB1OCBmbGFncywgdTggZmxhZywNCj4gPiA+ICsJCQkgICAg
ICAgdTE2IG1heF9kdXJhdGlvbiwgdTMyIG9mZnNldCwNCj4gPiA+ICsJCQkgICAgICAgYm9vbCAo
KmNvbmRfc3VjY2VzcykodTgpLCBib29sICgqY29uZF9mYWlsKSh1OCksDQo+ID4gPiArCQkJICAg
ICAgIHU4ICpzdGF0ZSkNCj4gPiA+ICt7DQo+ID4gPiArCWNvbnN0IHN0cnVjdCBldGh0b29sX29w
cyAqb3BzID0gZGV2LT5ldGh0b29sX29wczsNCj4gPiA+ICsJc3RydWN0IGV0aHRvb2xfbW9kdWxl
X2VlcHJvbSBwYWdlX2RhdGEgPSB7MH07DQo+ID4gPiArCXN0cnVjdCBjbWlzX3dhaXRfZm9yX2Nv
bmRfcnBsIHJwbCA9IHt9Ow0KPiA+ID4gKwlzdHJ1Y3QgbmV0bGlua19leHRfYWNrIGV4dGFjayA9
IHt9Ow0KPiA+ID4gKwl1bnNpZ25lZCBsb25nIGVuZDsNCj4gPiA+ICsJaW50IGVycjsNCj4gPiA+
ICsNCj4gPiA+ICsJaWYgKCEoZmxhZ3MgJiBmbGFnKSkNCj4gPiA+ICsJCXJldHVybiAwOw0KPiA+
ID4gKw0KPiA+ID4gKwlpZiAobWF4X2R1cmF0aW9uID09IDApDQo+ID4gPiArCQltYXhfZHVyYXRp
b24gPSBVMTZfTUFYOw0KPiA+ID4gKw0KPiA+ID4gKwllbmQgPSBqaWZmaWVzICsgbXNlY3NfdG9f
amlmZmllcyhtYXhfZHVyYXRpb24pOw0KPiA+ID4gKwlkbyB7DQo+ID4gPiArCQlldGh0b29sX2Nt
aXNfcGFnZV9pbml0KCZwYWdlX2RhdGEsIDAsIG9mZnNldCwgc2l6ZW9mKHJwbCkpOw0KPiA+ID4g
KwkJcGFnZV9kYXRhLmRhdGEgPSAodTggKikmcnBsOw0KPiA+ID4gKw0KPiA+ID4gKwkJZXJyID0g
b3BzLT5nZXRfbW9kdWxlX2VlcHJvbV9ieV9wYWdlKGRldiwgJnBhZ2VfZGF0YSwNCj4gPiAmZXh0
YWNrKTsNCj4gPiA+ICsJCWlmIChlcnIgPCAwKSB7DQo+ID4gPiArCQkJaWYgKGV4dGFjay5fbXNn
KQ0KPiA+ID4gKwkJCQluZXRkZXZfZXJyKGRldiwgIiVzXG4iLCBleHRhY2suX21zZyk7DQo+ID4g
PiArCQkJY29udGludWU7DQo+ID4NCj4gPiBjb250aW51ZSBoZXJlIGlzIGludGVyZXN0ZWQuIFNh
eSB5b3UgZ2V0IC1FSU8gYmVjYXVzZSB0aGUgbW9kdWxlIGhhcw0KPiA+IGJlZW4gZWplY3RlZC4g
SSB3b3VsZCBzYXkgdGhhdCBpcyBmYXRhbC4gV29uJ3QgdGhpcyBzcGFtIHRoZSBsb2dzLCBhcw0K
PiA+IGZhc3QgYXMgdGhlIEkyQyBidXMgY2FuIGZhaWwsIHdpdGhvdXQgdGhlIDIwbXMgc2xlZXAs
IGZvciA2NTUzNSBqaWZmaWVzPw0KPiANCj4gSWYgdGhlIG1vZHVsZSBpcyBlamVjdGVkIGZyb20g
c29tZSByZWFzb24sIGl0IG1pZ2h0IHNwYW4gdGhlIGxvZ3MgSSBndWVzcy4NCj4gQnV0IGl0IGlz
IGxlc3MgbGlrZWx5IHRoYW4gdGhlIHNjZW5hcmlvIEkgd2FudGVkIHRvIGNvdmVyLg0KPiBBY2Nv
cmRpbmcgdG8gU1BFQyA1LjI6DQo+IA0KPiAiDQo+IDcuMi41LjEgRm9yZWdyb3VuZCBNb2RlIENE
QiBNZXNzYWdpbmcNCj4gWy4uLl0NCj4gSW4gZm9yZWdyb3VuZCBtb2RlIHRoZSBtb2R1bGUgcmVq
ZWN0cyBhbnkgcmVnaXN0ZXIgQUNDRVNTIHVudGlsIGEgY3VycmVudGx5DQo+IGV4ZWN1dGluZyBD
REIgY29tbWFuZCBleGVjdXRpb24gaGFzIGNvbXBsZXRlZC4NCj4gTm90ZTogUkVBRHMgb2YgdGhl
IENkYlN0YXR1cyByZWdpc3RlcnMgMDBoOjM3IG9yIDAwaDozOCAoc2VlIFRhYmxlIDgtMTMpIHdp
bGwNCj4gYWxzbyBiZSByZWplY3RlZCBieSB0aGUgbW9kdWxlLg0KPiAiDQo+IA0KPiBTbyBpbiB0
aGF0IGNhc2UgdGhlIG1vZHVsZSB3b24ndCBiZSBhYmxlIHRvIHJlc3BvbmQgYW5kIHdlIG5lZWQg
dG8gd2FpdCBmb3IgaXQNCj4gdG8gYmUgcmVzcG9uc2l2ZSBhbmQgdGhlIHN0YXR1cyB0byBiZSB2
YWxpZC4NCj4gDQo+ID4NCj4gPiA+ICsJCX0NCj4gPiA+ICsNCj4gPiA+ICsJCWlmICgoKmNvbmRf
c3VjY2VzcykocnBsLnN0YXRlKSkNCj4gPiA+ICsJCQlyZXR1cm4gMDsNCj4gPiA+ICsNCj4gPiA+
ICsJCWlmICgqY29uZF9mYWlsICYmICgqY29uZF9mYWlsKShycGwuc3RhdGUpKQ0KPiA+ID4gKwkJ
CWJyZWFrOw0KPiA+ID4gKw0KPiA+ID4gKwkJbXNsZWVwKDIwKTsNCj4gPiA+ICsJfSB3aGlsZSAo
dGltZV9iZWZvcmUoamlmZmllcywgZW5kKSk7DQo+ID4NCj4gPiBQbGVhc2UgY291bGQgeW91IGlt
cGxlbWVudCB0aGlzIHVzaW5nIGlvcG9sbC5oLiBUaGlzIGFwcGVhcnMgdG8gaGF2ZQ0KPiA+IHRo
ZSB1c3VhbCBwcm9ibGVtLiBTYXkgbXNsZWVwKDIwKSBhY3R1YWxseSBzbGVlcHMgYSBsb3QgbG9u
Z2VyLA0KPiA+IGJlY2F1c2UgdGhlIHN5c3RlbSBpcyBidXN5IGRvaW5nIG90aGVyIHRoaW5ncy4g
dGltZV9iZWZvcmUoamlmZmllcywNCj4gPiBlbmQpKSBpcyBmYWxzZSwgYmVjYXVzZSBvZiB0aGUg
bG9uZyBkZWxheSwgYnV0IGluIGZhY3QgdGhlIG9wZXJhdGlvbg0KPiA+IGhhcyBjb21wbGV0ZWQg
d2l0aG91dCBlcnJvci4gWWV0IHlvdSByZXR1cm4gRUJVU1kuIGlvcG9sbC5oIGdldHMgdGhpcw0K
PiA+IGNvcnJlY3QsIGl0IGRvZXMgb25lIG1vcmUgZXZhbHVhdGlvbiBvZiB0aGUgY29uZGl0aW9u
IGFmdGVyIGV4aXRpbmcNCj4gPiB0aGUgbG9vcCB0byBoYW5kbGUgdGhpcyBpc3N1ZS4NCj4gDQo+
IE9LLg0KDQpIaSBBbmRyZXcsDQoNCkkgaW1wbGVtZW50ZWQgdGhlIGFib3ZlIGFzIHlvdSBhc2tl
ZCwgYnV0IGl0IHNlZW1zIHRvIGhhdmUgYSBwcm9ibGVtLg0KVGhlIGlvcG9sbCBmdW5jdGlvbnMg
aGF2ZSBhIHNsZWVwaW5nIHBhcmFtZXRlciAic2xlZXBfdXMiIHRoYXQgc3VwcG9zZWQgdG8gYmUg
ZXF1aXZhbGVudCB0byB0aGUgbXNsZWVwKDIwKSBpZiBJIHB1dCAyMDAwMCB0aGVyZS4NCkhvd2V2
ZXIsIHRoaXMgcGFyYW1ldGVyIGlzIGRlZmluZWQgYXMgJ01heGltdW0gdGltZSB0byBzbGVlcCBi
ZXR3ZWVuIHJlYWRzIGluIHVzJywgc28gaXQgd2lsbCBub3QgYWx3YXlzIHNsZWVwIDIwbXNlYyBh
cyBpdCBzaG91bGQuDQpUaGlzIGlzIHByb2JsZW1hdGljIHNpbmNlIHRoZXJlIGFyZSBtb2R1bGVz
IHRoYXQgbmVlZHMgdGhpcyAyMG1zZWMgc2xlZXAgaW4gb3JkZXIgdG8gYmUgYWJsZSB0byBwb2xs
IGFnYWluIGZyb20gdGhlIG1vZHVsZS4NCk90aGVyd2lzZSwgdGhlc2UgbW9kdWxlcyBmYWlsIGR1
cmluZyB0aGUgd3JpdGUgRlcgY29tbWFuZCBpdGVyYXRpb25zLCB3aGlsZSBwb2xsaW5nIHRoZSBm
bGFnIG9yIHN0YXR1cy4NClRoZXJlZm9yZSwgdW5mb3J0dW5hdGVseSBpbiB0aGlzIGNhc2UgSSdk
IHJhdGhlciBzdGF5IHdpdGggdGhlIG9yaWdpbiBjb2RlLg0KDQpUaGFuayB5b3UgZm9yIGFsbCB5
b3VyIGNvbW1lbnRzLA0KRGFuaWVsbGUNCg0KPiANCj4gPg0KPiA+ID4gK3N0YXRpYyB1OCBjbWlz
X2NkYl9jYWxjX2NoZWNrc3VtKGNvbnN0IHZvaWQgKmRhdGEsIHNpemVfdCBzaXplKSB7DQo+ID4g
PiArCWNvbnN0IHU4ICpieXRlcyA9IChjb25zdCB1OCAqKWRhdGE7DQo+ID4gPiArCXU4IGNoZWNr
c3VtID0gMDsNCj4gPiA+ICsNCj4gPiA+ICsJZm9yIChzaXplX3QgaSA9IDA7IGkgPCBzaXplOyBp
KyspDQo+ID4gPiArCQljaGVja3N1bSArPSBieXRlc1tpXTsNCj4gPiA+ICsNCj4gPiA+ICsJcmV0
dXJuIH5jaGVja3N1bTsNCj4gPiA+ICt9DQo+ID4NCj4gPiBJIGV4cGVjdCB0aGVyZSBpcyBhbHJl
YWR5IGEgaGVscGVyIGRvIHRoYXQgc29tZXdoZXJlLg0KPiA+DQo+ID4gICAgIEFuZHJldw0KPiAN
Cj4gWWVzIGl0IGRvZXMsIGJ1dCBhY3R1YWxseSBpdCBpcyBhbiBoZWxwZXIgdGhhdCBvY2N1cnMg
aW4gc3BlY2lmaWMgcGxhY2VzIChmb3IgZXhhbXBsZQ0KPiBwY2lfdnBkX2NoZWNrX2NzdW0oKSks
IHRoYXQgaSBjYW4gdXNlIGZyb20gaGVyZS4NCj4gDQo+ID4NCj4gPiAtLS0NCj4gPiBwdy1ib3Q6
IGNyDQo=

