Return-Path: <netdev+bounces-204880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0C6AFC634
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2EB1AA1FE8
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AB02853E5;
	Tue,  8 Jul 2025 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sw6XI4FA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9C221D87;
	Tue,  8 Jul 2025 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964782; cv=fail; b=N4nwEyG/IQdL1/0QMz4vjRRgwLEirZuMQY7OjzdEb/+FqPzKLZDq/dUwW9aQPYHduGnIU7mvw4hLXYZq0NWpDpLE80NeZjcyLNWCbqND0sNzBHIs7+BkeTQpPunUfhK8lCs0+F7iGRw8l/fxK0iu3bReRbFV1dtko6HcKeyEqWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964782; c=relaxed/simple;
	bh=ErRtVSoyKtSBG049awnWaeDlrpqUfs6BWVIUV8RtQ6o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xrh/7BDPmw2JPr3USmVgfDFGVYy3s9JSkQ2PBSlwq/WbotM0RRTFXFWZ/P2Rdeq/y0qvn7vk3ufP9PYrACHbTDLjUj47S367SwItr7WhZgIu6PnaEkw02oXTyDc5bARDiCuVVKbfoy6Hx+9IOK7VUeAaBxe12o5qPex+KiEJxnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sw6XI4FA; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vcqvlwg6Zdg9BJ6cSWdZqj0QbfSB3AYYWJSKvWh3CypKxI4pKSgAq1fcNwEEfMkHj6Q5sbtnmWFLN9tXEepr3Er+M7jG5W4GLmA8wixEWcE56/9IAPU9k5/DcT2xE5UuiOWdsXM22g5INQ+zmnhWyT3/yPj1/co4atNqiKjCL9mA+1mz7rlzQsr0nHlNQRv+g+CCoBi4ewOk0mvRLl74Yb+hqUyVEyd2tq5i1qTmGoB9VySuIW/ghA9w01ziB4cR1v/afVmjqskWgxhs8rb6SvmA342ifldLXUiVL72UmlIJJR1cEqkqvnzIiYR4t9b8wiCY9LoI8RwRwt72Yzm0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErRtVSoyKtSBG049awnWaeDlrpqUfs6BWVIUV8RtQ6o=;
 b=K4qEdawqbcR9pVAXOfJK+p7OCptn0zKgqqG5VICemORmgb6H8hey0CH15a4dgTtJ74J6l3DvkHCUDblz+yC6tb63yrWkjH4L/j7cJwsJDROv0Y2q8/F9W6N5UDqunTrJ71rEG84o9ahBmljYWsjT9Y4/6MaSFwku0jgdlKQj/tHxxw0jQEBUvgtW8FbEgqRGhjczPw3SqI5a4GbCp0ZBmuGdi3vs6cqVg6F5MEcsq8dlUUAqSBmsIVgGe38TB5/nwaPZbd7WkOkyXbadqiS9ld1Uy/8FUcR3P2bne746odfK4rj+MOQFFwZJHjXgJqcc/jVW7Cb3zppIltcNtEm3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErRtVSoyKtSBG049awnWaeDlrpqUfs6BWVIUV8RtQ6o=;
 b=Sw6XI4FAes22rSMbsOFeoW9ndw8fcSja0T4LeI7eefVVcWM2zXsBTgbX7VlRCBH/otd7P5XiI4BaJjHgPMWdCHNn5T1aDcRxJvYkGGBbJjbc59KOwYyXk6cDVi/uIVjg3XQ1831kuqydcWrvwhZCYNUp1D0F4OA5g8TJL/aKncaVkXwMYQH+KTMj5CtNTHo6bPP61XQlq8BZ9MUxudWc0p6OVvSzUSqIH+JRSoWtWkw5c+VdnPIa9erxcLie/5j9hSJ+ode+q+L4eQywi+CAfVcirN35Izfkr3sa03gbeJKUj0DAZh9MFrI1eI6b0DBR5BDHKYwy2x0bSSNm83hkvQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CH3PR12MB9146.namprd12.prod.outlook.com (2603:10b6:610:19c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 08:52:54 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8880.029; Tue, 8 Jul 2025
 08:52:54 +0000
From: Parav Pandit <parav@nvidia.com>
To: Mina Almasry <almasrymina@google.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
CC: Jakub Kicinski <kuba@kernel.org>, "asml.silence@gmail.com"
	<asml.silence@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Thread-Topic: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Thread-Index:
 AQHb63aYJqQBPRpj30ykrq2XrPwwyrQfKE4AgAAZDgCAAA5wgIAA8qiAgAGwzICABRQegIAAL8wAgAAFiICAALedUA==
Date: Tue, 8 Jul 2025 08:52:54 +0000
Message-ID:
 <CY8PR12MB719584B0D85424AC2495CCC6DC4EA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
 <20250702172433.1738947-2-dtatulea@nvidia.com>
 <20250702113208.5adafe79@kernel.org>
 <c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
 <20250702135329.76dbd878@kernel.org>
 <CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <22kf5wtxym5x3zllar7ek3onkav6nfzclf7w2lzifhebjme4jb@h4qycdqmwern>
 <CAHS8izN-yJ1tm0uUvQxq327-bU1Vzj8JVc6bqns0CwNnWhc_XQ@mail.gmail.com>
 <sdy27zexcqivv4bfccu36koe4feswl5panavq3t2k6nndugve3@bcbbjxiciaow>
 <CAHS8izPTBY9vL-H31t26kEc4Y4UEMm+jW0K0NtbqmcsOA9s4Cw@mail.gmail.com>
In-Reply-To:
 <CAHS8izPTBY9vL-H31t26kEc4Y4UEMm+jW0K0NtbqmcsOA9s4Cw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CH3PR12MB9146:EE_
x-ms-office365-filtering-correlation-id: 9028ed31-ed51-42ed-33d4-08ddbdfcd3f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWVaOG1ZRXRSSHhybWJXaUxIRmZtd3lkS05qUzRjaVZaWFhaQUhaajJWWkpF?=
 =?utf-8?B?dGQ4VzhKajJHMTB4UTBuaUthVHJzaHJVYmJsNzZvUzM0Mm0wZXgweXFRWEFC?=
 =?utf-8?B?bEUrUDIvN2VSTi9SZWlydkI2VnBuYjY1MDU1UFdtSG0zMkdnVmJudmJvYlZ3?=
 =?utf-8?B?azdQSnI4SFk3SUM0M091UFMwaXVaZmRRcHFyUEdYMnAyYy9hWS9NYjY4d2JT?=
 =?utf-8?B?cjBiU3VxRUtGa3V5a3JtckF5RjYxb2hFM2EyS1dUZ25Gdk5KeDNtNVNLejlZ?=
 =?utf-8?B?Qk10YTduSlpYdU1CdmpOd3dkNlI0MXpVQ3lwTGIvTFdaZFZ0NEZ0U3JWTnls?=
 =?utf-8?B?Zkd2bEtsYnNQaEJ4QmNZSERCQVUrNDVBNWl5Qk11UzMzREZkR2RQTXp0MmZm?=
 =?utf-8?B?eHliRm9NalZYb1ZXeEtxVkZzY2g3RkNRSGNnNU9rb3BmdHRHS2VQaGpwajBH?=
 =?utf-8?B?NHhUUXBrbzVmVWl0MzV3eWgxa2M2ZXJmS0Rwckw0VnBocGhOaFhueDZHWjNQ?=
 =?utf-8?B?UEhhOWpUc2dvNE4vUmdJNDZhN2FESGtPVUZhVUdwcWhNajhCaHhyeThKMnlE?=
 =?utf-8?B?RS84Qm8vRlczRXJIU25xVWV5NFhwd24yVUo5SE5iaHhpVlM1K29XQjVmc2pv?=
 =?utf-8?B?SnhldGl6SDg0SDNqYVF3MkVkdnM5UWJVcUdIM2tNRWdBeE1qeDk3d0wzODJE?=
 =?utf-8?B?OG5NWVhYNmdJOHZwUjJJbE5PWmpqRXRlbVVWNEM1bWpYTUNrWW1zQkpFK3l5?=
 =?utf-8?B?T2tXQUNSMmRWeDlGUER5K0tlQkFlQ3NXeDlpbHlIWTBxY3ZUc3RyczBWbXJX?=
 =?utf-8?B?ZFBJSndaTDRpdHhQNDBuZzVueWRKODduenM2ZmFNRXlsUE1uc0dNTXBuc0R6?=
 =?utf-8?B?SFhDOU5lMlBKOWZ0WC9ra1h5WFY4WjNUNWd4M0xCa2FUaC8wWlhTeUhlTDZP?=
 =?utf-8?B?QzJ3Y0tnQmg2dkdzd3VEYkxTa3J5VEs4QTdlQVBLY1pYVDJGZnd0MUZnSXln?=
 =?utf-8?B?dmNtM0ZISm0wNVBvU0dkR3FnekJYRHNzajVjNjhGWTFGNWlXcWhGeW9xNzZ5?=
 =?utf-8?B?dkliS3k3VEhNY0h5blZra3RFQ2RPc1ljMm5FbmppWWtJbHdCU3ZmaDRBL2hI?=
 =?utf-8?B?bGRxVU8vSVpyWHduelQ1aHhaLzNsRktyV3dGNGlJTjlZcnBGVGpkMlRQalBF?=
 =?utf-8?B?YUpZc3lDR2pTakxEdmNsWVlCcTh3anBEM2ozQVpWWUpoWnl4VzMzS1FPS0NX?=
 =?utf-8?B?RHc3TGdKM0pMTkE4N2ZEc0NWU3pKTHBRY3lHVUUvOEpieGxpVW9jZ2NtR2Rw?=
 =?utf-8?B?MjEzWHpBTjFRVHJuMkt1TFEvdytQaWRXVGVHNlpoL3B1MERNMjlSeDF3QlhH?=
 =?utf-8?B?b21BZnJGcVZHem1USkM0RG9YK0p6ZDNMeWd2WDE1a3JRbG0vVTV3R2NqcGhT?=
 =?utf-8?B?QkkzRHlRNTNRbFdnZzdpSlRQdjkyL01RdmdlZlE3ZDlPRVVKVDZlVTFHaTRE?=
 =?utf-8?B?YzhLelYraDFHL2tpRU1oQzRKM0QvNTE0VFVMN3pkT1FQVlhITWxDa3NSc3lp?=
 =?utf-8?B?QWhQMXVtV2Y3bXExZFk4QU56ZUN3MWhtRERpVlBqeC9xRTNVWC9KUml6Mytx?=
 =?utf-8?B?dzJ4a1VzS3pPV3puUTJaRkIvcC82RGhxaDd4alVYd0FYTTlwaUZraDZWZ2dp?=
 =?utf-8?B?a3AvUDg4TldPcmhyWk85OWZkUFB3V1hBV055QytRUEVGRWtkcWlaSWNJcUdo?=
 =?utf-8?B?K1hlRmtXRjB4R3R4NDdING8rdm04UStYelIwQUdJakV1SWQrQU9mY3FvMG96?=
 =?utf-8?B?VmZ6TklOaEx1aUVsU1F0UGo1ZjBiVjRyQlBoeUZ2Uys0U0F4WTE5dTJjR0Ft?=
 =?utf-8?B?QWR6ZDVGRVBzTjliNi9VVEVvUHZZbW9GWlhlZCtzYjlJMWhOdTRWTWtxNm9Q?=
 =?utf-8?B?b2NEUkNiTHdQQVRoNkN3U1ZMU2I0NDRDakkyWXRPUU4zOXd2S3N6N0Z5TzRP?=
 =?utf-8?B?MHZncTdTVSt3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzVsd1JwbEJXdzBQRFFlcDByT09EV1NXclI5UnFuMkl1dEY3V1pSQ0tBd1hl?=
 =?utf-8?B?OEZISVJnRjB0UENwYi95NEJNUFRPeEVFL2hDTkhFUkxaWjgwQ3BqSmprTEM2?=
 =?utf-8?B?aWRJS01iQjR2TWhnWTlLRXhwVlJQanVUNHRjTWltdXJDUXNseWxlYkp0SHFC?=
 =?utf-8?B?VXJnYmNhSDJ4OUpLcjd3VWlOM0ZmMXAzTVlJSW5wVlZFV2xxRkFGTnBNUVEz?=
 =?utf-8?B?SXo4d0IrYmVjRXgwMlRaTkdodVZXN0Y3Wm1xb3hoYkNObDE1enJoMEFDN2N4?=
 =?utf-8?B?QkNFQllDRVU0TmxOZXdvcnZjQ0x0R0o1WVA4YWtaZHVObkcwRERLaUlSNlFh?=
 =?utf-8?B?d0E3SCsvZ2swOXd5UStaRmpyV0VhSEw5L0hJRTFsaXBNUi9nV1NUOVRHWEdh?=
 =?utf-8?B?R09YMHVTS0M4cW9NKzlmOWYwODFMa0lzTEFMY2doV3lQTnB2M2o0THNqMnUy?=
 =?utf-8?B?MVlabDBzdlMrTCtVUDB5V01DVi9MR1pybG1uZDlGQ0dVeG1VS1VPM3NzUFZw?=
 =?utf-8?B?bG1iZE9lTVVRNVgyTUpkTTlsazZydGJDU2Y0ZmlWNUJtL3E3Z1VxSExqRFc1?=
 =?utf-8?B?Z0k0VHozS0NWUnkwS29yMjNzMTljS0F4WlpydnZ1UFhKTklyRFhqUG0rb01k?=
 =?utf-8?B?RXR1RWx2RVJiSHU3cjNZZ1FmMU1kOHFhQS9wdXJKTGpYRmV5cU8yd3VNSnR3?=
 =?utf-8?B?QXZHMmNaTkJwcHJYTGlCL0pQQUFqQkVZTnRFb3BDUjFwcytOOXNIaEtaZWs1?=
 =?utf-8?B?djdYN25vSXRGdVhrdHpTdmFNaE5TRUNjZEFWVjZFanlvZmdRb2tMU1dzaENU?=
 =?utf-8?B?emt4MHhFWVFhY0tEUWNBZTdnWm5mTVFseDZtZERwWWJQMHNPSWxva04rTnRu?=
 =?utf-8?B?VU8vNTFxMThzNHB3TCtsSGtDdE9BN1dHaExZYjFGYzdrNE1DUVRYL0J4RSs4?=
 =?utf-8?B?aXlaTktJc0pwOG0yYkUrK0dOSjJ4V3Q3dkpnM1haZ3NVSVR4QnNhU0NvcXpi?=
 =?utf-8?B?NGhWT05WajZDdkc3dXAxOGJLQzdHaHYzcUU4NGV0d0RGc3RZaXFyeDlvSGI3?=
 =?utf-8?B?V1l4MXluaDRmNTI4SHkyTWdhNGNGTkhYbUx2TGltZW1rU3NaelBJbkY4MGZL?=
 =?utf-8?B?L0FzaG9yU01RWG5OUmU0emUyZXk5U1hBdzU5OG00cVl4MXd3RWJFeEQrRWMy?=
 =?utf-8?B?S3lMTEFRUmJZQk11UVNONmU3YXp6akZCaEVPZEF4MzJ6MGZkQUhHdThlWUdV?=
 =?utf-8?B?cG9kWHpzSW9uS0ZFQzdodDYzdFduejJkdzJZK3RsMkhZT0ZtNFl2N2lsV0la?=
 =?utf-8?B?VjN0eFV3NjNRQTB2d1hyMmFoRXFuMW1kdGwzUXNmUVVUZ1lRVW1SVi9ackdy?=
 =?utf-8?B?UUhQbEVUY2Yrb0I1YlRETklOMTJxSER3ZnVXMkZyTnlBdlBNOERabmc3QzFu?=
 =?utf-8?B?dWF5TDIzM2UzSU1QOUdSeGx4bHNEOXdPd0JSelo5a3NTd1pyaldnVk1Cb0RX?=
 =?utf-8?B?QTFBUDFxL3I5UWEydXRVcGVyMnFIcUJaVm9VZktSOFlPdHRyRkRUd2o1d0Ri?=
 =?utf-8?B?WklBL3AybU9tK1N3Y1BQMGdvVzVEczRxM05ONEFSUHd2a1VITXlYVjlVV2Ny?=
 =?utf-8?B?dllMKzZadUpOSjN2VXRsWjMvUGl5K1BMZkNyVVVQVitCOEtrVmNJdmIrWUE5?=
 =?utf-8?B?MmRlcWR3a3VJdTVZaFBOTmNoVWhKbDVHcXI5N2wxTTFDZ0NINTUzSVp6OGJ4?=
 =?utf-8?B?Y09TdWR4eHhNSGlkS2FFMC9SN2FienNib1paZGRaeHRXeVU1RGhPSXk1UzVm?=
 =?utf-8?B?VmwwdU92UHY1M3o1QUo5VndnR3RmTGlsbkRaSktLU1E0MHdRaWIvbW9UV1JM?=
 =?utf-8?B?RWtIeC9Ta29uU1hCb2Z3T01tMFlCLzIzT240Lzd3THlwcVM4bGNKTjVHS09z?=
 =?utf-8?B?RS9wWUpyVGNTdThta3hXYnpDYTdVc2c4VmVkZC9Ib0V3ZDZaRmdsT3M0QklK?=
 =?utf-8?B?by9KWS9CNXFLOGRFZWh0TWdoVHV3NGFteVlKUE9PbU9NejJlN3dZVHdSLzJl?=
 =?utf-8?B?bEl2ZDNRNi9GVG9LeWZtUDNGdVpTVEUrOC9naTljbndTUXFHZklhdGd4WUpx?=
 =?utf-8?Q?IseA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9028ed31-ed51-42ed-33d4-08ddbdfcd3f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 08:52:54.1518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqQAcPENYhhjKCQn+iNdPfiO/kyZo+OOFX1fERnwaFz0qjLYtqwUEd5s9ow5ROek/7RbRJApdvTUjU5sNFpSUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9146

DQo+IEZyb206IE1pbmEgQWxtYXNyeSA8YWxtYXNyeW1pbmFAZ29vZ2xlLmNvbT4NCj4gU2VudDog
MDggSnVseSAyMDI1IDAzOjI1IEFNDQo+IA0KPiBPbiBNb24sIEp1bCA3LCAyMDI1IGF0IDI6MzXi
gK9QTSBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBPbiBNb24sIEp1bCAwNywgMjAyNSBhdCAxMTo0NDoxOUFNIC0wNzAwLCBNaW5hIEFsbWFzcnkg
d3JvdGU6DQo+ID4gPiBPbiBGcmksIEp1bCA0LCAyMDI1IGF0IDY6MTHigK9BTSBEcmFnb3MgVGF0
dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IE9u
IFRodSwgSnVsIDAzLCAyMDI1IGF0IDAxOjU4OjUwUE0gKzAyMDAsIFBhcmF2IFBhbmRpdCB3cm90
ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRnJvbTogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2Vy
bmVsLm9yZz4NCj4gPiA+ID4gPiA+IFNlbnQ6IDAzIEp1bHkgMjAyNSAwMjoyMyBBTQ0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4gWy4uLl0NCj4gPiA+ID4gPiA+IE1heWJlIHNvbWVvbmUgd2l0aCBjbG9z
ZXIgdW5kZXJzdGFuZGluZyBjYW4gY2hpbWUgaW4uIElmIHRoZQ0KPiA+ID4gPiA+ID4ga2luZCBv
ZiBzdWJmdW5jdGlvbnMgeW91IGRlc2NyaWJlIGFyZSBleHBlY3RlZCwgYW5kIHRoZXJlJ3MgYQ0K
PiA+ID4gPiA+ID4gZ2VuZXJpYyB3YXkgb2YgcmVjb2duaXppbmcgdGhlbSAtLSBhdXRvbWF0aWNh
bGx5IGdvaW5nIHRvDQo+ID4gPiA+ID4gPiBwYXJlbnQgb2YgcGFyZW50IHdvdWxkIGluZGVlZCBi
ZSBjbGVhbmVyIGFuZCBsZXNzIGVycm9yIHByb25lLCBhcyB5b3UNCj4gc3VnZ2VzdC4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IEkgYW0gbm90IHN1cmUgd2hlbiB0aGUgcGFyZW50IG9mIHBhcmVudCBh
c3N1bXB0aW9uIHdvdWxkIGZhaWwsDQo+ID4gPiA+ID4gYnV0IGNhbiBiZSBhIGdvb2Qgc3RhcnQu
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJZiBuZXRkZXYgOCBieXRlcyBleHRlbnNpb24gdG8gc3Rv
cmUgZG1hX2RldiBpcyBjb25jZXJuLA0KPiA+ID4gPiA+IHByb2JhYmx5IGEgbmV0ZGV2IElGRl9E
TUFfREVWX1BBUkVOVCBjYW4gYmUgZWxlZ2FudCB0byByZWZlcg0KPiBwYXJlbnQtPnBhcmVudD8N
Cj4gPiA+ID4gPiBTbyB0aGF0IHRoZXJlIGlzIG5vIGd1ZXNzIHdvcmsgaW4gZGV2bWVtIGxheWVy
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhdCBzYWlkLCBteSB1bmRlcnN0YW5kaW5nIG9mIGRl
dm1lbSBpcyBsaW1pdGVkLCBzbyBJIGNvdWxkIGJlDQo+IG1pc3Rha2VuIGhlcmUuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBJbiB0aGUgbG9uZyB0ZXJtLCB0aGUgZGV2bWVtIGluZnJhc3RydWN0dXJl
IGxpa2VseSBuZWVkcyB0byBiZQ0KPiA+ID4gPiA+IG1vZGVybml6ZWQgdG8gc3VwcG9ydCBxdWV1
ZS1sZXZlbCBETUEgbWFwcGluZy4NCj4gPiA+ID4gPiBUaGlzIGlzIHVzZWZ1bCBiZWNhdXNlIGRy
aXZlcnMgbGlrZSBtbHg1IGFscmVhZHkgc3VwcG9ydA0KPiA+ID4gPiA+IHNvY2tldC1kaXJlY3Qg
bmV0ZGV2IHRoYXQgc3BhbiBhY3Jvc3MgdHdvIFBDSSBkZXZpY2VzLg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gQ3VycmVudGx5LCBkZXZtZW0gaXMgbGltaXRlZCB0byBhIHNpbmdsZSBQQ0kgZGV2aWNl
IHBlciBuZXRkZXYuDQo+ID4gPiA+ID4gV2hpbGUgdGhlIGJ1ZmZlciBwb29sIGNvdWxkIGJlIHBl
ciBkZXZpY2UsIHRoZSBhY3R1YWwgRE1BDQo+ID4gPiA+ID4gbWFwcGluZyBtaWdodCBuZWVkIHRv
IGJlIGRlZmVycmVkIHVudGlsIGJ1ZmZlciBwb3N0aW5nIHRpbWUgdG8NCj4gPiA+ID4gPiBzdXBw
b3J0IHN1Y2ggbXVsdGktZGV2aWNlIHNjZW5hcmlvcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IElu
IGFuIG9mZmxpbmUgZGlzY3Vzc2lvbiwgRHJhZ29zIG1lbnRpb25lZCB0aGF0IGlvX3VyaW5nIGFs
cmVhZHkNCj4gPiA+ID4gPiBvcGVyYXRlcyBhdCB0aGUgcXVldWUgbGV2ZWwsIG1heSBiZSBzb21l
IGlkZWFzIGNhbiBiZSBwaWNrZWQgdXANCj4gPiA+ID4gPiBmcm9tIGlvX3VyaW5nPw0KPiA+ID4g
PiBUaGUgcHJvYmxlbSBmb3IgZGV2bWVtIGlzIHRoYXQgdGhlIGRldmljZSBiYXNlZCBBUEkgaXMg
YWxyZWFkeSBzZXQNCj4gPiA+ID4gaW4gc3RvbmUgc28gbm90IHN1cmUgaG93IHdlIGNhbiBjaGFu
Z2UgdGhpcy4gTWF5YmUgTWluYSBjYW4gY2hpbWUgaW4uDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4g
SSB0aGluayB3aGF0J3MgYmVpbmcgZGlzY3Vzc2VkIGhlcmUgaXMgcHJldHR5IHN0cmFpZ2h0IGZv
cndhcmQgYW5kDQo+ID4gPiBkb2Vzbid0IG5lZWQgVUFQSSBjaGFuZ2VzLCByaWdodD8gT3Igd2Vy
ZSB5b3UgcmVmZXJyaW5nIHRvIGFub3RoZXINCj4gPiA+IEFQST8NCj4gPiA+DQo+ID4gSSB3YXMg
cmVmZXJyaW5nIHRvIHRoZSBmYWN0IHRoYXQgZGV2bWVtIHRha2VzIG9uZSBiaWcgYnVmZmVyLCBt
YXBzIGl0DQo+ID4gZm9yIGEgc2luZ2xlIGRldmljZSAoaW4gbmV0X2Rldm1lbV9iaW5kX2RtYWJ1
ZigpKSBhbmQgdGhlbiBhc3NpZ25zIGl0DQo+ID4gdG8gcXVldWVzIGluIG5ldF9kZXZtZW1fYmlu
ZF9kbWFidWZfdG9fcXVldWUoKS4gQXMgdGhlIHNpbmdsZSBidWZmZXINCj4gPiBpcyBwYXJ0IG9m
IHRoZSBBUEksIEkgZG9uJ3Qgc2VlIGhvdyB0aGUgbWFwcGluZyBjb3VsZCBiZSBkb25lIGluIGEg
cGVyDQo+ID4gcXVldWUgd2F5Lg0KPiA+DQo+IA0KPiBPaCwgSSBzZWUuIGRldm1lbSBkb2VzIHN1
cHBvcnQgbWFwcGluZyBhIHNpbmdsZSBidWZmZXIgdG8gbXVsdGlwbGUgcXVldWVzIGluIGENCj4g
c2luZ2xlIG5ldGxpbmsgQVBJIGNhbGwsIGJ1dCB0aGVyZSBpcyBub3RoaW5nIHN0b3BwaW5nIHRo
ZSB1c2VyIGZyb20gbWFwcGluZyBODQo+IGJ1ZmZlcnMgdG8gTiBxdWV1ZXMgaW4gTiBuZXRsaW5r
IEFQSSBjYWxscy4NCj4gDQo+ID4gPiA+IFRvIHN1bSB0aGUgY29udmVyc2F0aW9uIHVwLCB0aGVy
ZSBhcmUgMiBpbXBlcmZlY3QgYW5kIG92ZXJsYXBwaW5nDQo+ID4gPiA+IHNvbHV0aW9uczoNCj4g
PiA+ID4NCj4gPiA+ID4gMSkgRm9yIHRoZSBjb21tb24gY2FzZSBvZiBoYXZpbmcgYSBzaW5nbGUg
UENJIGRldmljZSBwZXIgbmV0ZGV2LCBnb2luZw0KPiBvbmUNCj4gPiA+ID4gICAgcGFyZW50IHVw
IGlmIHRoZSBwYXJlbnQgZGV2aWNlIGlzIG5vdCBETUEgY2FwYWJsZSB3b3VsZCBiZSBhIGdvb2QN
Cj4gPiA+ID4gICAgc3RhcnRpbmcgcG9pbnQuDQo+ID4gPiA+DQo+ID4gPiA+IDIpIEZvciBtdWx0
aS1QRiBuZXRkZXYgWzBdLCBhIHBlci1xdWV1ZSBnZXRfZG1hX2RldigpIG9wIHdvdWxkIGJlIGlk
ZWFsDQo+ID4gPiA+ICAgIGFzIGl0IHByb3ZpZGVzIHRoZSByaWdodCBQRiBkZXZpY2UgZm9yIHRo
ZSBnaXZlbiBxdWV1ZS4NCj4gPiA+DQo+ID4gPiBBZ3JlZWQgdGhlc2UgYXJlIHRoZSAyIG9wdGlv
bnMuDQo+ID4gPg0KPiA+ID4gPiBpb191cmluZw0KPiA+ID4gPiAgICBjb3VsZCB1c2UgdGhpcyBi
dXQgZGV2bWVtIGNhbid0LiBEZXZtZW0gY291bGQgdXNlIDEuIGJ1dCB0aGUNCj4gPiA+ID4gICAg
ZHJpdmVyIGhhcyB0byBkZXRlY3QgYW5kIGJsb2NrIHRoZSBtdWx0aSBQRiBjYXNlLg0KPiA+ID4g
Pg0KPiA+ID4NCj4gPiA+IFdoeT8gQUZBSUNUIGJvdGggaW9fdXJpbmcgYW5kIGRldm1lbSBhcmUg
aW4gdGhlIGV4YWN0IHNhbWUgYm9hdA0KPiA+ID4gcmlnaHQgbm93LCBhbmQgeW91ciBwYXRjaHNl
dCBzZWVtcyB0byBzaG93IHRoYXQ/IEJvdGggdXNlDQo+ID4gPiBkZXYtPmRldi5wYXJlbnQgYXMg
dGhlIG1hcHBpbmcgZGV2aWNlLCBhbmQgQUZBSVUgeW91IHdhbnQgdG8gdXNlDQo+ID4gPiBkZXYt
PmRldi5wYXJlbnQucGFyZW50IG9yIHNvbWV0aGluZyBsaWtlIHRoYXQ/DQo+ID4gPg0KPiA+IFJp
Z2h0LiBNeSBwYXRjaGVzIHNob3cgdGhhdC4gQnV0IHRoZSBpc3N1ZSByYWlzZWQgYnkgUGFyYXYg
aXMgZGlmZmVyZW50Og0KPiA+IGRpZmZlcmVudCBxdWV1ZXMgY2FuIGJlbG9uZyB0byBkaWZmZXJl
bnQgRE1BIGRldmljZXMgZnJvbSBkaWZmZXJlbnQNCj4gPiBQRnMgaW4gdGhlIGNhc2Ugb2YgTXVs
dGkgUEYgbmV0ZGV2Lg0KPiA+DQo+ID4gaW9fdXJpbmcgY2FuIGRvIGl0IGJlY2F1c2UgaXQgbWFw
cyBpbmRpdmlkdWFsIGJ1ZmZlcnMgdG8gaW5kaXZpZHVhbA0KPiA+IHF1ZXVlcy4gU28gaXQgd291
bGQgYmUgdHJpdmlhbCB0byBnZXQgdGhlIERNQSBkZXZpY2Ugb2YgZWFjaCBxdWV1ZQ0KPiA+IHRo
cm91Z2ggYSBuZXcgcXVldWUgb3AuDQo+ID4NCj4gDQo+IFJpZ2h0LCBkZXZtZW0gZG9lc24ndCBz
dG9wIHlvdSBmcm9tIG1hcHBpbmcgaW5kaXZpZHVhbCBidWZmZXJzIHRvIGluZGl2aWR1YWwNCj4g
cXVldWVzLiBJdCBqdXN0IGFsc28gc3VwcG9ydHMgbWFwcGluZyB0aGUgc2FtZSBidWZmZXIgdG8g
bXVsdGlwbGUgcXVldWVzLg0KPiBBRkFJUiwgaW9fdXJpbmcgYWxzbyBzdXBwb3J0cyBtYXBwaW5n
IGEgc2luZ2xlIGJ1ZmZlciB0byBtdWx0aXBsZSBxdWV1ZXMsIGJ1dCBJDQo+IGNvdWxkIGVhc2ls
eSBiZSB2ZXJ5IHdyb25nIGFib3V0IHRoYXQuIEl0J3MganVzdCBhIHZhZ3VlIHJlY29sbGVjdGlv
biBmcm9tDQo+IHJldmlld2luZyB0aGUgaW96Y3J4LmMgaW1wbGVtZW50YXRpb24gYSB3aGlsZSBi
YWNrLg0KPiANCj4gSW4geW91ciBjYXNlLCBJIHRoaW5rLCBpZiB0aGUgdXNlciBpcyB0cnlpbmcg
dG8gbWFwIGEgc2luZ2xlIGJ1ZmZlciB0byBtdWx0aXBsZQ0KPiBxdWV1ZXMsIGFuZCB0aG9zZSBx
dWV1ZXMgaGF2ZSBkaWZmZXJlbnQgZG1hLWRldmljZXMsIHRoZW4geW91IGhhdmUgdG8gZXJyb3IN
Cj4gb3V0LiBJIGRvbid0IHNlZSBob3cgdG8gc2FuZWx5IGhhbmRsZSB0aGF0IHdpdGhvdXQgYWRk
aW5nIGEgbG90IG9mIGNvZGUuIFRoZSB1c2VyDQo+IHdvdWxkIGhhdmUgdG8gZmFsbCBiYWNrIG9u
dG8gbWFwcGluZyBhIHNpbmdsZSBidWZmZXIgdG8gYSBzaW5nbGUgcXVldWUgKG9yDQo+IG11bHRp
cGxlIHF1ZXVlcyB0aGF0IHNoYXJlIHRoZSBzYW1lIGRtYS1kZXZpY2UpLg0KPiANCj4gPiA+IEFs
c28gQUZBSVUgdGhlIGRyaXZlciB3b24ndCBuZWVkIHRvIGJsb2NrIHRoZSBtdWx0aSBQRiBjYXNl
LCBpdCdzDQo+ID4gPiBhY3R1YWxseSBjb3JlIHRoYXQgd291bGQgbmVlZCB0byBoYW5kbGUgdGhh
dC4gRm9yIGV4YW1wbGUsIGlmIGRldm1lbQ0KPiA+ID4gd2FudHMgdG8gYmluZCBhIGRtYWJ1ZiB0
byA0IHF1ZXVlcywgYnV0IHF1ZXVlcyAwICYgMSB1c2UgMSBkbWENCj4gPiA+IGRldmljZSwgYnV0
IHF1ZXVlcyAyICYgMyB1c2UgYW5vdGhlciBkbWEtZGV2aWNlLCB0aGVuIGNvcmUgZG9lc24ndA0K
PiA+ID4ga25vdyB3aGF0IHRvIGRvLCBiZWNhdXNlIGl0IGNhbid0IG1hcCB0aGUgZG1hYnVmIHRv
IGJvdGggZGV2aWNlcyBhdA0KPiA+ID4gb25jZS4gVGhlIHJlc3RyaWN0aW9uIHdvdWxkIGJlIGF0
IGJpbmQgdGltZSB0aGF0IGFsbCB0aGUgcXVldWVzDQo+ID4gPiBiZWluZyBib3VuZCB0byBoYXZl
IHRoZSBzYW1lIGRtYSBkZXZpY2UuIENvcmUgd291bGQgbmVlZCB0byBjaGVjaw0KPiA+ID4gdGhh
dCBhbmQgcmV0dXJuIGFuIGVycm9yIGlmIHRoZSBkZXZpY2VzIGRpdmVyZ2UuIEkgaW1hZ2luZSBh
bGwgb2YNCj4gPiA+IHRoaXMgaXMgdGhlIHNhbWUgZm9yIGlvX3VyaW5nLCB1bmxlc3MgSSdtIG1p
c3Npbmcgc29tZXRoaW5nLg0KPiA+ID4NCj4gPiBBZ3JlZWQuIEN1cnJlbnRseSBJIGRpZG4ndCBz
ZWUgYW4gQVBJIGZvciBNdWx0aSBQRiBuZXRkZXYgdG8gZXhwb3NlDQo+ID4gdGhpcyBpbmZvcm1h
dGlvbiBzbyBteSB0aGlua2luZyBkZWZhdWx0ZWQgdG8gImxldCdzIGJsb2NrIGl0IGZyb20gdGhl
DQo+ID4gZHJpdmVyIHNpZGUiLg0KPiA+DQo+IA0KPiBBZ3JlZWQuDQo+IA0KPiA+ID4gPiBJIHRo
aW5rIHdlIG5lZWQgYm90aC4gRWl0aGVyIHRoYXQgb3IgYSBuZXRkZXYgb3Agd2l0aCBhbiBvcHRp
b25hbA0KPiA+ID4gPiBxdWV1ZSBwYXJhbWV0ZXIuIEFueSB0aG91Z2h0cz8NCj4gPiA+ID4NCj4g
PiA+DQo+ID4gPiBBdCB0aGUgbW9tZW50LCBmcm9tIHlvdXIgZGVzY3JpcHRpb24gb2YgdGhlIHBy
b2JsZW0sIEkgd291bGQgbGVhbiB0bw0KPiA+ID4gZ29pbmcgd2l0aCBKYWt1YidzIGFwcHJvYWNo
IGFuZCBoYW5kbGluZyB0aGUgY29tbW9uIGNhc2UgdmlhICMxLiBJZg0KPiA+ID4gbW9yZSB1c2Ug
Y2FzZXMgdGhhdCByZXF1aXJlIGEgdmVyeSBjdXN0b20gZG1hIGRldmljZSB0byBiZSBwYXNzZWQg
d2UNCj4gPiA+IGNhbiBhbHdheXMgbW92ZSB0byAjMiBsYXRlciwgYnV0IEZXSVcgSSBkb24ndCBz
ZWUgYSByZWFzb24gdG8gY29tZQ0KPiA+ID4gdXAgd2l0aCBhIHN1cGVyIGZ1dHVyZSBwcm9vZiBj
b21wbGljYXRlZCBzb2x1dGlvbiByaWdodCBub3csIGJ1dCBJJ20NCj4gPiA+IGhhcHB5IHRvIGhl
YXIgZGlzYWdyZWVtZW50cy4NCj4gPiBCdXQgd2UgYWxzbyBkb24ndCB3YW50IHRvIHN0YXJ0IG9m
ZiBvbiB0aGUgbGVmdCBmb290IHdoZW4gd2Uga25vdyBvZg0KPiA+IGJvdGggaXNzdWVzIHJpZ2h0
IG5vdy4gQW5kIEkgdGhpbmsgd2UgY2FuIHdyYXAgaXQgdXAgbmljZWx5IGluIGENCj4gPiBzaW5n
bGUgZnVuY3Rpb24gc2ltaWxhcnkgdG8gaG93IHRoZSBjdXJyZW50IHBhdGNoIGRvZXMgaXQuDQo+
ID4NCj4gDQo+IEZXSVcgSSBkb24ndCBoYXZlIGEgc3Ryb25nIHByZWZlcmVuY2UuIEknbSBmaW5l
IHdpdGggdGhlIHNpbXBsZSBzb2x1dGlvbiBmb3Igbm93DQo+IGFuZCBJJ20gZmluZSB3aXRoIHRo
ZSBzbGlnaHRseSBtb3JlIGNvbXBsaWNhdGVkIGZ1dHVyZSBwcm9vZiBzb2x1dGlvbi4NCj4gDQpM
b29rcyBnb29kIHRvIG1lIGFzIHdlbGwuDQo=

