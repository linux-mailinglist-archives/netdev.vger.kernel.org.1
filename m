Return-Path: <netdev+bounces-215075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4F7B2D0BD
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61EE627CE5
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 00:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A079372625;
	Wed, 20 Aug 2025 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="FT4XviGM"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023125.outbound.protection.outlook.com [40.107.44.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B97B3C17;
	Wed, 20 Aug 2025 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755650409; cv=fail; b=FO/pAOh+4uFLR6CjwxwOPc9iu2ME8B2YGhps0uQvWY4dhLbihmsyyg81nyza52SKRPBTZIZ6Ukrdm9x95tOY6dIVwpi16ucHugYxtlqquc4ognA5tC07kANz2Uo25gXqVn3LVjOVGh4bAhwJ0E8QG9Cst2nAIeKEQu5JFqY2jIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755650409; c=relaxed/simple;
	bh=mij/PjU9/nDnqVP8NMBR2OE4sFNq2urXCY096UlQJwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZuTYlFoRxFH9CT92lvrSeFIC7046g2IMc+IseJbw3tbEfG7J7b4jXi7Re1SaMxvqaQ1NN2XLLRSA1C8WjHOnvJGGjKDwkTZyOJyhX+vDinb2sSIx1qGg12QlchNuRHxkKcGkDnFuRgyRkCtNTP3Zb5Jo50/hwDumvnJjWoJq9Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=FT4XviGM; arc=fail smtp.client-ip=40.107.44.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f83Powfupznr/ftG6ahdhfKNmZO25YhForW1fW0HJcngTRcIc5EsRvO98F6x+4RZfSeed7e9N34Rr6rsteTT8ngIQoZRnIc+hohAv6eJI31Vf02NcVfCTE8hMAH7TG5/Q+x2tPpQQdhr4V3VpxTKpprkYRPW38qxLPHS9l/H2ky9+xL7zxlZmTnfbeAzVFXceEhtksE3BOekkdxMJIC/3omQzFdRIVcxoQdr7/6wFKAPzXW+nT4FEnQlvstonSo/DDvqrpZm3Yz+IAVdWJM3RB40MYaftVpKLz8zyHZnP4M7SNbOm3s4xf2gX9ql9mrvAoEf1WW6HiQjdhxCOcfLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mij/PjU9/nDnqVP8NMBR2OE4sFNq2urXCY096UlQJwA=;
 b=SkUgqqp+4wdHzSB5CXaaujl4w5xmvk0bUMFgbLKS3NtPEROfsb2AD+G4qKw8osPJVX4omQyZiWlve/qtIKLVYEIcfZjLXg4oEK+0twMrcI0/kzUDrAUe+hXUR4FL5U5/zDLit6300E5TzttCpCm9BWgj5iKdtIdHdWMuFwpZQA0N9SCl1Z4Qkw0dCWNbGCQ3UcitS7eEqONQV4KOUKu1sXSkqdPV2jSFeY0G3gRYDzscqEVfm6RQH3VRccYAEYNQ9k5TB1oovLps4hglxZU1vxBl1MgTzdOqhuDv55wc5RG8WId8chwBSFNI0DfO/cxeYbpvTuPOi3QFvGgYG6rirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mij/PjU9/nDnqVP8NMBR2OE4sFNq2urXCY096UlQJwA=;
 b=FT4XviGMNxtshNB0IorZvKtpqdOfREUhXSmDFJcE4cyBQwSurFAkwkZE2CSm+C6GIVnGTnQrOxy0dhrctc0fwO7nnmkTXucFW0f7Yr3ANyCihlw16ajlZ6luLcoTUEWss8gYkB1WDRmUw5ACb4jr52l2QqWaZeQwWGnvOrStBbZ+eR+i+N7QuAH1zLT+eLbUlfU5JlpMA8MO6OcAynRY0bVsMeF8UDRGI3SBS9+ejzpyJP1VvnJO9/3k1WJOV1DPXPLsEg/WkgAdklMtnH6HawBiLCLD00/Gm9b0LvjysxjaqH0poH2FSNmHYBoKUTLjv9I+uCptxtwjqDmAAlE4ow==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB4977.apcprd06.prod.outlook.com (2603:1096:400:1cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 00:40:02 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%7]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 00:40:02 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Simon Horman <horms@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, Po-Yu Chuang <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject:
 =?utf-8?B?5Zue6KaGOiBbbmV0LW5leHQgdjIgMC80XSBBZGQgQVNUMjYwMCBSR01JSSBk?=
 =?utf-8?Q?elay_into_ftgmac100?=
Thread-Topic: [net-next v2 0/4] Add AST2600 RGMII delay into ftgmac100
Thread-Index: AQHcDhRZKIdVUppPdkiWsIaFr0P96LRqtipg
Date: Wed, 20 Aug 2025 00:40:02 +0000
Message-ID:
 <SEYPR06MB513431EE31303E834E05704B9D33A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
 <a9ef3c51-fe35-4949-a041-81af59314522@lunn.ch>
In-Reply-To: <a9ef3c51-fe35-4949-a041-81af59314522@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB4977:EE_
x-ms-office365-filtering-correlation-id: c805108e-2d98-4cdc-04ab-08dddf8219b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzI1bk5BaTJEYkMrT3ptYW9FZlNxRVZ6WHlFcEpHd3BUZFFaQ1VIQ2sxcHls?=
 =?utf-8?B?WVVFQlVSSjN1eFkrb1ZtSFVPVjlTS1R3YVFqWXh2eE5aTE03MWhtSStJWEVJ?=
 =?utf-8?B?Vy8wREhCOEs5MkFFakZpd1oydk9ZQ2dicE5wZWtBdnp0VXZ2NnVuYVA3dkow?=
 =?utf-8?B?Y1htZy8waTMxUjU2a0tvSkxXVy9Sc29jMXNCeXpMRXBIeDQ5alRXbFZEUThH?=
 =?utf-8?B?Rmo2blhkbE1ReW5SeDYvb3V5Sk8vd1FKN0dOeU5wMmhtSlFSK2ZwekdpR1No?=
 =?utf-8?B?V1FESVl5dVBMWXJXamRFZTRoa2ZTMCt2MEdMcmMwS1dzdGMyVjBZaFNZOHBv?=
 =?utf-8?B?emRVTDdmcEUraFhseWZ1L2RWNkt3UnJMdC8wcHBLUHJNVWo5T2w4czJPZmhQ?=
 =?utf-8?B?NGo0Rno3YmUzR25VM2w2SzZFQzdRZlVOMTJwY1pOT000VFlvc0dkL2hJM0Rw?=
 =?utf-8?B?T3ZvQjIwRmp4TXFERjVHL2N1bDNJa1ZsMmlkRG02NnF5eVM0S3VjbEVaaUp4?=
 =?utf-8?B?aFErWHE4MEF6SDVzR3BXVldvT3Jkck1MQUl6LzBqdTh5Y2poRExEaEZIN3BE?=
 =?utf-8?B?TlZpQlJyenh2Y1BXalZVUG1ubldMaXJuVVRKL1FFTmRhaXhQUndET3pnLzBL?=
 =?utf-8?B?TTFadGtjVEtSOG5yTW9JSHRPdjRsb2M1MEtidXgvWkswem9sTmdzcTFhS1Nx?=
 =?utf-8?B?UHh6eWNHU0phQVdDUWg3OFA4WjRWell1TngxaEhyQmxMVEk3b2R4Qkdqc0lj?=
 =?utf-8?B?bGVoemtaeDc5ZjFneUJoeW1LQzN2QlFmaTJOeVVHUFhET2xDMlJMWjI4YlQz?=
 =?utf-8?B?T1FwOXVHZHZXdjRnMCtob3NiRmR6R2t2ZmViSVdRWWkraDIyY2wwTHdnRG1S?=
 =?utf-8?B?SXhqckd6QlhYVHpMQm9LS2xkcHQyUEZYa0xPUi81cnNxMFNxYXM2bVBRczIy?=
 =?utf-8?B?ajNzUTJnSmNBWGQrSmFxTlJhZUhJd3JCZGl6d3A4VXFDQmQ3UlVsNEMvOXNo?=
 =?utf-8?B?N2VJZjY1QVFpMmRHNDlvdWZCbktTR095V1FMWXpndnZIOHVvam5aalFxLzhI?=
 =?utf-8?B?Ni94Y1I1QnNBazVMV09sS2xodVQ5aUEzemhRUWxGYXJBd0xRd3ZkR0dENjk0?=
 =?utf-8?B?UENzcVpqUTh3bTRYNjFLT3djUFRrUEVnWjJPbisyWC9YT3pUdmoyUS9FMkJX?=
 =?utf-8?B?b2FrUWFNRzdQTjhjckxzbCsvWUNPZE1pQlhEN3QyMm5jUGVCdFNyZTV4bERj?=
 =?utf-8?B?STBFdDYwZ1FzWE9wN1ZzenhVcTQ2T3hKa1VhU00wUFBlZnJCaTBhUFJvTEN0?=
 =?utf-8?B?c2ZUUXVUNW5Sd0o4dkN3eHc3ajVZS0gvbzNzZjJUY0tZakhLU1JPZEhqZUlP?=
 =?utf-8?B?ZVk5R05OSHRzeEpIb21pdy9iS3N6dk9FazZ3K2xKR3FDTTJab0V1dGdNM0JZ?=
 =?utf-8?B?NDJHQ1poamtSa0Jtb1ZoNWRMeXc4U2hON2tDSVpIMHpsR0VOU3R4VjJNYTU0?=
 =?utf-8?B?cWxNOTZDWEZsQjZZVnlNUDFQKzB4eEs2eGx1TGp5VEJwS25UUEJPaHdYdjNB?=
 =?utf-8?B?YzJIdDVlUGpCMi91cXREWFkzL3R4bFNmbzJ2RDdUanllMy9wcWlqdnhUSEFB?=
 =?utf-8?B?cjZ4V241L3plTXRjb2crcHREN204cnVHd1VaSGZoTEQ2VFp3cTMzZWlhaXAy?=
 =?utf-8?B?aHk3WG00Z3N2N2x3UlJoa1N2TXQrTkNvRTZjKzNmdlRCL2xHRThFUG0yYjAr?=
 =?utf-8?B?bE9Wb3lncklMYkEvbkhBRTMwTTE4RTY4N0tCYUY1MGZZSzdVRWVneUpLTzJO?=
 =?utf-8?B?ZDRVVFVrN3pPWDJ5bGZyZnNDUWUxRkZKTWdOZ1gwdDdSaUhINUI4dVM5YkFI?=
 =?utf-8?B?T2J1Ky9FK3J6M29VU1p2UlcxNURpMG02QzVXdmlnREx4ZzBxa0dzMUtFMzcw?=
 =?utf-8?B?NFNQK1dLSm4yclRZNFRKNHJtZGc4aTBma3d5OWZNVUVndGZySVBlT2Y5R2Uz?=
 =?utf-8?B?cVh4Yk13U3NnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTRQT0srelA1dk4yUjFoVUNVVUlQZTFlWmdOMVRoVGNidEdTd2pMalFRbFQx?=
 =?utf-8?B?OGV0NWt4a1N0UFFCTlczemFlN1ZCc1BPd3drNmVLRjBIMittQWRXMVpGOXpk?=
 =?utf-8?B?UmR1cStJN2R3YnQrZUxKcEhCRXoyeWhxWHFTdnd1N1dZZWFubFlxbHJERnRz?=
 =?utf-8?B?T2JqcEtnamdIUEhLWXBxUVo1V3RNejVkYkVpNHBuMk8vS2dvWlVzWDdFcjBB?=
 =?utf-8?B?a0d6ZDJWNHdCUmx5YkMyMEpwbHNkUU5IeVFYWUtGL2s2ODVmYnZHWVJreVVE?=
 =?utf-8?B?N2VnUFhNMjlzMEk5a0ovSk1ZZUluNlJzYW1OL1NLQ3JzbWJ6dHNzQWE1eGRa?=
 =?utf-8?B?Tm0reW9qY1FHTlVxRlgzYklldGVEdDMxL0RDeW4raDNJcHpFOGNMVktyZktH?=
 =?utf-8?B?a1ExZzB4a0JtKzNSTktHRHk5YzE4Y2dUeXkzbGRTOXhTOGN5bWZPbWtKekd3?=
 =?utf-8?B?OFN6bUtNdzcvRUxNYnpIbzk2b29wQXh3TlVpWENnaVVUVFJDRWJPdVpxei9J?=
 =?utf-8?B?UWpTVjlxZi81aTkrWU9jWmY1TUcxd2VUS1g3UURLWVR5bFlmV0FnWmZXNE83?=
 =?utf-8?B?Kzl3Z3BvMmZLTS9vV1VMZlhKTWFta1IrSlk3U0ZUZENKbVd5T2VoSEpWRSty?=
 =?utf-8?B?anZrK0ppby9zSlBFUC9YQjN6UG5vdDB2Ymp3QzloNmVNNkF2dXNzN1JjRkZJ?=
 =?utf-8?B?ck1qMG5vUWtjSVZKMWxWVC9pbmc0N1ErK0NEdlovSkRlZ1lzU0Y5a0ttOEEw?=
 =?utf-8?B?STBnQVdRc2VxWFhDaWxqQkVWa0ZPVWdLT3FkVllMNi90Z2JJcElmanNZQ1Uy?=
 =?utf-8?B?QjFMcXlieng2cU95aHR5VWxvYnJIdlJ5RzhTSFRhUzFJZmpIdkZ0ZUJHdVNR?=
 =?utf-8?B?WFdTTCttcXl5ajVwbzhscjNHenAra0h0SmdUZXJyUjJJaG0xNUlPZ0Nmc0Zv?=
 =?utf-8?B?d3AzVjA5UUJKQVlzK0xtYmVTdHVYWVZYWXNLeVRPd3NNbnVSbWM1cE1YR0Vs?=
 =?utf-8?B?NlpDOVFMZnFKR1owTHYrenRTUE53dlRRRC9mRFpVNDZHV3Z4SVdlSmZ2cWkw?=
 =?utf-8?B?cGZNWUk5SXFxNy94Z3FnM01VRUt6ZEo5SFN3QjF3THlQQzFXanZucmYzMzdv?=
 =?utf-8?B?Y00yRWNoa29GODkwMjF3bkRQc3N2aEFFUU16Qng0U041eUZJckxzMkNoLzNj?=
 =?utf-8?B?Tkd4TG5OY3M1U0diOE1yZ1o1QlU4SWRtMmRYVUNSZHlCUDROVURvdnBSWmND?=
 =?utf-8?B?UmxlVTZjaGt3M0RReG40OWxiekdxc2NyTE1qTm9CcDl4MkV4blprZWJGZmdt?=
 =?utf-8?B?cVdDYUxVYmUxc0dOYzFKVnozNnJQdWl2TGpSN2ZJaU9LeUx1clZtb3NGL0wx?=
 =?utf-8?B?aGxPbE5jSks2NmRoOFBYU3NwdjBZTEEwQldkM0VDZStHQitEOHF6RWJEMXZ5?=
 =?utf-8?B?MlZZd1ZBTEU1S1JHbkw3blNza0hoUlp0bWZETHJhT3dZY09veFNqSGswaWRa?=
 =?utf-8?B?OFIzSGc2RUpKNTNUOENtNThXWXFIb21IZ3doK1hRUE05WFQvMElQZGJTTkEx?=
 =?utf-8?B?dkN1anRSdkhWQzZpNDNCcER4TkhmeEtQSzRKRFFSaDhvOE5hY1RPcVhkY3Ey?=
 =?utf-8?B?MXhsckxDazAvaDAxQUxrZVZrdU9GYTBSN000U09ocmdvSWZYVkFHOWx4MEt2?=
 =?utf-8?B?aXNwQ0FQSjZtTll2ZWZmejAzVjZQM3c3SzNTVXJYL1dMZmZCVkxuRVBaRkNa?=
 =?utf-8?B?aklmcjVRM09EZlZDYnZwQVJqUUlJQmF6QXpKWlJzb2MzNVR2Sm9MblVVYXRk?=
 =?utf-8?B?MkdTQjZ6R3d2Y3phQXNzQXVKNG9UYnpqUW53SWNibVBRVFRhWWRuQUhFS214?=
 =?utf-8?B?a01VQzU1ODE2QUxGNWwxZE5QU3lmQTVlYThwS0lvaGNHaXpZd0VuT2E0aW01?=
 =?utf-8?B?Y3RpVThhN01JdWpSMXJRNmU2SWppTlQ0MVF6M0E0U0xSejBJZWtyNGdneVRm?=
 =?utf-8?B?Q1RmK0hQV0x3RTZHaVBmVVFQTVNNQXZZeVY3YlFmeWFMcWh0VUkzVlNZMUVH?=
 =?utf-8?B?ZTBlRzU5VjlSS2s1aG80aXZycVhyU0lKSitjdzJqVTl1TnR6ZHdVM3RKSnZX?=
 =?utf-8?Q?q/QPSebH3ouw+RU/XU44jLHEA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c805108e-2d98-4cdc-04ab-08dddf8219b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 00:40:02.6431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yh/HFQPJeAX0yi7BnSGgepGGpzMK41lE+bQp86lDdrtp/yjhaLKZzjUt0KSzGYpTZjkrgB57Y5SAUAituwub5Tuo81vtpI7Hvp4M/45G9S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4977

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiBUaGlzIHBhdGNo
IHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIGNvbmZpZ3VyaW5nIFJHTUlJIGludGVybmFsIGRlbGF5
cw0KPiA+IGZvciB0aGUgQXNwZWVkIEFTVDI2MDAgRlRHTUFDMTAwIEV0aGVybmV0IE1BQ3MuDQo+
IA0KPiBTbyBpIHRoaW5rIHlvdSBhcmUgZG9pbmcgdGhpbmdzIGluIHRoZSB3cm9uZyBvcmRlci4g
WW91IGZpcnN0IG5lZWQgdG8gc29ydCBvdXQgdGhlDQo+IG1lc3Mgb2YgbW9zdCwgaWYgbm90IGFs
bCwgQVNUMjYwMCBoYXZlIHRoZSB3cm9uZyBwaHktbW9kZSwgYmVjYXVzZSB0aGUNCj4gUkdNSUkg
ZGVsYXkgY29uZmlndXJhdGlvbiBpcyBoaWRkZW4sIGFuZCBzZXQgd3JvbmdseS4NCj4gDQo+IFBs
ZWFzZSBmaXggdGhhdCBmaXJzdC4NCj4gDQoNClRoZSBSR01JSSBkZWxheSBpcyBjb25maWd1cmVk
IGluIFUtYm9vdCBzdGFnZSwgYW5kIGl0IGlzIG5vdCBjaGFuZ2VkIHdoZW4gYm9vdGluZyB0bw0K
TGludXguIEkgd2FudCB0byBrbm93IHdoZXRoZXIgdGhlIGZpcnN0IHRoaW5nIHRvIGNvcnJlY3Qg
aGVyZSBpcyB3aGV0aGVyIHRoZSBwaHktbW9kZQ0KaW4gYXNwZWVkLWFzdDI2MDAtZXZiLmR0cyBp
cyByZ21paS1pZC4gT3VyIEFTVDI2MDAgRVZCLCB0aGVyZSBpcyBubyBkZWxheSBvbiBib2FyZCwN
CnNvLCBJIG5lZWQgdG8gY2hhbmdlIHRoZSBwaHktbW9kZSB0byAicmdtaWktaWQiIHRvIG1lZXQg
dGhlIFJHTUlJIHVzYWdlIGZpcnN0Pw0KDQo+IFRoZW4gY29uc2lkZXIgaG93IHlvdSBjYW4gYWRk
IGZpbmUgdHVuaW5nIG9mIHRoZSBkZWxheXMuIE1heWJlIHRoYXQgbmVlZHMgdG8NCj4gd2FpdCBm
b3IgQVNUMjcwMC4NCg0KQ3VycmVudGx5LCBvbiBBU1QyNzAwLCB3ZSB1c2UgdGhlICJyZ21paS1p
ZCIgaW4gb3VyIFNESy9naXQgYXMgcGVyIHlvdXIgc3VnZ2VzdGlvbi4NCkFuZCB3ZSB3aWxsIGFk
ZCB0aGUgdHgvcngtaW50ZXJuYWwtZGVsYXktcHMgcHJvcGVydGllcyBpbiB0aGUgZnRnbWFjMTAw
IGRyaXZlciB0bw0Kc3VwcG9ydCBmaW5lIHR1bmluZyBvZiB0aGVzZSBkZWxheXMuDQoNClRoYW5r
cywNCkphY2t5DQoNCg==

