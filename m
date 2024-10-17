Return-Path: <netdev+bounces-136361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3755A9A1804
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD551F26C4B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 01:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2391D1CAA4;
	Thu, 17 Oct 2024 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fS8szq0b"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56C26ADD;
	Thu, 17 Oct 2024 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729129675; cv=fail; b=c2Aq1xPPKelTpxIxSWCHTxEPw7NXwr4x6eXI/ID/ump7PEuoymuRINO2bYVIRTO84mc3g86F5pz3nmmjzfob2yrpSgjimXtK7oOPGyLoJmzS9zRtL3uVyvnOikEqLkMm7pk/TAkC+eFrD/Mk4QUSRMDQif9bIclfl0ZHJGrq3Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729129675; c=relaxed/simple;
	bh=+aHpUzQp0uYg4QcXAJac0lncOMPKOfiX0F2y3RbMqZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o61zOD8tQBMCRREBZ5wOa96pZ3VZP5U/YqixS8qvbgGC3otrUJ29dDkNBgAZEOrqNsTvuGEyx9JHH1p4oDcDqIeTDko8qI+jKn2V/iFyp/NDQLRvkqFmm5zWBkbP8TuuOExJTqOMG1DVsekg6wtxcA3sdDckdc2oKggAPmg2MbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fS8szq0b; arc=fail smtp.client-ip=40.107.241.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7mSujk+VJ0nidEMufdTHOV+d/j6A/BvyYOOpD449zu1YALD6A+T1HCNlCBV0cR3ENauVeUhA0Uiupnv/rIhf/inQZoAleIvgjVdiIb1tqARIxV68LHGHUk9T/+Lw/5zRRXXjTvBldsKA5QhF64NECaWCEDDicR1frUKMEJic9f8uIN/sk/rjTuILATeygyHtC02LLPkkMePGbkia6hjsxZYka8Q5tRBQATX95xU8sWWBX45mY4b7UnzwzHfvLE+U2jiBtDk2lnxP1tYeIFWncX7HFPvXtuC8t9nmpBGn3JIaFjY+kHD/toTTdfGjNiJIa0VZuXqOza6wdeMxbUx/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aHpUzQp0uYg4QcXAJac0lncOMPKOfiX0F2y3RbMqZ0=;
 b=JJ8CcY/Og2Zg/bHDEHzkr/jbZKCLp2qlOJub4BodylwX1LuvMfw/Wo+r7pNDUR7U3tAUJS+aKQWcJSlz+kuZqpPK7tyOzL2rSkPCZH1Tg8Wl+o6h2YyupG3psG1D0kqHj6DAJ6C6zzEk+imrcJLv/Nyqrn88u/NxgTD1TUS/TdUz67xmxyakcgrKTHuruytmDae+zDZ0hsdY2cbP47uxhLhsKHHp3zBXRLltj20TQNQoZ0ONIaRVMzlMKY1aUiL6blZc5ydBt0yMS1zjzOqHeNPD3yYOWhEq/h6+d+cFX/hIh4ZYdSnkvhTPLTWYU5TLcb711dnl1uzdXFSZAWTDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aHpUzQp0uYg4QcXAJac0lncOMPKOfiX0F2y3RbMqZ0=;
 b=fS8szq0bWCCL3kMVL2PG0Qq/Jmyb86x3Uu2QJsA2Fiqs+BdiN9hkHCY9G5uttiFky2g1wpPazyC8sCXq6Za0UzneEtpzmRjguNnpn7nJKNIbrcBPNWz+YRK15ZwwX/dEQ27MqiZqQYesBknmFnSRF0FXvHWryTcP/B/T87pzHtThzUD9JJOdVV1ydxiZroKz4vlQz3Nzn2eecsQA03rxdo515FXOTlIuPTjRmtKLhjvCcdD/alWvh0KCiZgzz8c9kHupXbGTnAy4RyeujRtsO02/TL07he8ASBf0SnrY+rwQPkpd2tJYnD82pdtS8ECZBx5+peM0ZbYkQVEc6iqW3A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 01:47:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 01:47:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH net-next 05/13] net: fec: fec_restart(): introduce a
 define for FEC_ECR_SPEED
Thread-Topic: [PATCH net-next 05/13] net: fec: fec_restart(): introduce a
 define for FEC_ECR_SPEED
Thread-Index: AQHbIBW0hfu6mcqr1UyeqzmlefLX9LKKLMUg
Date: Thu, 17 Oct 2024 01:47:46 +0000
Message-ID:
 <PAXPR04MB8510B10367BC7D076FD5E2C888472@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-5-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-5-de783bd15e6a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB8346:EE_
x-ms-office365-filtering-correlation-id: 4cfb37f9-3376-46fe-7c48-08dcee4db376
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFhvVGhwSEQ5dkMwT1U5cTFmVGtpd2NURVQxTzFpWm81NU5SOW9hdytqOVJp?=
 =?utf-8?B?ZjBYdldGOWpRd1ZZa0xBMm92NGlmMTdmWmoyVUdNcFpNZDcyYU5VdmUyNHB3?=
 =?utf-8?B?WWhPWVFyNlUwdXpQcG5xM1hZd2FFN3ZGVlZXMyt1WEM2czdRYXA5Qmdkc1RB?=
 =?utf-8?B?UEI3Q1FuamthOG40aTVWdElrWHd5cDg0bnJnNWdmU2hBRjNNSWhMZEVYNDRv?=
 =?utf-8?B?Q3FNMnJyOTVtOEVmbU5DbFo1SW4yeTg0cFFaR1RnYUdTY0V6YXFVTkVnMngv?=
 =?utf-8?B?NjlObEtaWDBIbjNsczJwN2RCZXczaERpUEVmVmFPY1NTa2N6MVdCNEVoczBI?=
 =?utf-8?B?M3NWcHc3cXF6VnBhS3NpQ1A2bDVtaVlqTjdpWERDMnM3d252enAra0wvZGUy?=
 =?utf-8?B?UWpkRlVhemMzSW5VMUg2SnJrR014UG85OWtUNWJHeVRSWnQ2T0V6L3B6REl6?=
 =?utf-8?B?emxKd0lmSHFvTkRBZU9QQkVFcHI0UEczMmU5VXRxRlIvYXAzdWJ2TmJZYjVO?=
 =?utf-8?B?cmhOdHpPUG4xT2JZbzEzTmdJMDdmRWp4THJuRnlnOHJUTyt5SFRjanVMQXky?=
 =?utf-8?B?VDhnRDVQSnFJVmZWRmNLa0R5TzlqQjRxSGh4cjU5a1dxYzArVGFOQWJRYTFD?=
 =?utf-8?B?VmswM3hIVzNqYnRLOU1JYkt0YnUzOEtFK3hRNEFRcFduQmh4RElQV1hjWE5F?=
 =?utf-8?B?Qy9EZGZNWFpVdE5jNzl3MEJXb29laVpEMnFidnA5M0lTSmIrTktKZktXVjhx?=
 =?utf-8?B?aytaWEJWYmhoeTV2UEFEaGpzNEhMcmlyR0NtMENaVWlQaXRKa2VJRy9lQTRM?=
 =?utf-8?B?eEVMazd0Vkt3cVNvMG5JYjNnZEMrWHlaMW5DeDBSdTdyeE9IQU1RdHZ1M0cz?=
 =?utf-8?B?eWVwb3RDNWZrT3N5ekVUNU9NR0c1Z3U3ZEdvbmYzV2cxSnVtQTlDQ3BlZmY4?=
 =?utf-8?B?byttdUMybWFFVTBmRktCeEVGZUp5N0NNTjFkb0lQU1BRYk54OC85Qzd1dUxG?=
 =?utf-8?B?K0Z5OUQ3NUdpdEFJY0YxTmNVMWVFLzFVeDBxN0dNdUFZQWxYN0ZOTlFuN1VB?=
 =?utf-8?B?azUxNlFUUWlvM2hRNEQ0RkZFbkc4cUYvRis0UXQwaXRyOEFSUW5VeWdQcUxv?=
 =?utf-8?B?QzYyQmkrSkNwTlQrZFlGSml5aGFKUm4rWG1KSDh4M0hwSmlUR2hnUjNSNnN4?=
 =?utf-8?B?Tk9OZWpkVjB0aDZlbDZFK2Q4RXgyM0dobGFFbVhKYWFNWXFkaEJBNEYvczE1?=
 =?utf-8?B?KzNjUGtRaHA2TTNxS2tIWVB6dEtvQ0xUNkh1R3piRzAwUTFUNVpYK2JhQmNN?=
 =?utf-8?B?WHoxVys3T1g3QWF1dzZWMlRGTEJDS2wxRTh1T1JRYkNqbGREU0RaRm15TExO?=
 =?utf-8?B?RW1CZFY4U0txejR1S3FxemtUaDNTSFF6cWI3NEVXTmppNGt5RXB3S2lXM3dm?=
 =?utf-8?B?d1RuQWloemxJMFVYdFZ3OW1CT251OGdSYnZLQTFrWER5NVVQNVVsQXV6dlJY?=
 =?utf-8?B?RzVPR0t6bG9GcjRTNTRiQ0lIQy84QXNZMllIcFhmeU1rNjNQdFByeXZRQWhJ?=
 =?utf-8?B?N0xLZkhWRzYvaUZzT2ZxSzhUWFJJMlI0QkVNN0FkNDkvKzk4UEdYNm1MUFBD?=
 =?utf-8?B?NHdvek9iaU1naVllMjdtcVF5YU5YbHNVMmhWQmVsTGpvRklrdkhlN0J4b2xy?=
 =?utf-8?B?ekJOZjNjK0t1K283elVwOFYzM3RTbDYwMVBjUERZb1ZRTFR3K01wVGlyMmdI?=
 =?utf-8?B?V2RzYjl4aFFJOEFtNncwdUNCRVBmS3RxYVVQRmhjYmJYTXdSRitVS1l4WVl6?=
 =?utf-8?Q?JkrcwBSwsRGn4r6egqESiIvY383uMNjpSMO/M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEVjNnp4dnRvNXkrQjQ0YkxtcGQyRERna3RLeFJZQjk5RTBmRkNiaVBCWG1T?=
 =?utf-8?B?bHdGT2J3V3VXT3YzVDlPenZFQ1ZLUXhVektlWVM4dzVBai9JT2lhaWx2V09W?=
 =?utf-8?B?QlBjWmowYkQ2SkMrMDVnN2cvZ1N0TnNBUTlaZ0tnQS9xOExnVm1JeGtuR25q?=
 =?utf-8?B?MXg3b2lBZFF2bS9obHdDS0JvT1hlWDc5czBTejlzOW9Pc1c1ZG5lWExQSHBo?=
 =?utf-8?B?OGNXcVpDVjVDL0h1VW5Nc2F0Tlk2dWVOU3ZEYW9NRXVucHN4bTBMTVkrbDB2?=
 =?utf-8?B?RXpNNmdDR0JHOHlLSGwyL1ppMlF0NTA1U1FYOG9sQUVlN2tkZHZ5aHVUcVRn?=
 =?utf-8?B?MCthKzdmSzcrclhnOFVZWlJGb0dvZGtYcFdxWFpwSzNveXVTcm12SUd0R1hF?=
 =?utf-8?B?cERkeEY4UnI0VWpwSXhVM2tUR2NSQklJR1lJR0ZJa0tFZnV6UU1CNnEzc01t?=
 =?utf-8?B?bmxHNVZVMjMrS056UHF3T0R2ZkdTQkI3N2MzdGY3aEhkVmpINjZyTm9yeWpT?=
 =?utf-8?B?NCs1MU9nNVpHOU5qUVlDNHc5aEJBbFpxK3p0aTZDNkVxR0lXNjB1M3A0NmZh?=
 =?utf-8?B?RW54eld6Tk96OERsb0VxZEVvV2FEOEdwL25zaDIzOFY0UEQxeGhQbCtWSWpF?=
 =?utf-8?B?MGRoYy9mSkh1TGxLQlZEVGViL3U5QzUyaEczTThoR2t1ZTNLQmpPY0tOQ3hL?=
 =?utf-8?B?QktKZVgzMHRrMklpbjQwUlVHMDl3d2VMTmhqRTNsZmNZY2EwbmdlZGRkVHdM?=
 =?utf-8?B?YzZ6NHdxL0dLcytxQ2t1cW9UZFRrTi9CMjdHNk1adnB0WjU1cGJoZEgzU3Rm?=
 =?utf-8?B?UVNqSFJZWGlQQ0tMTmtuQm9GK25CeGpEZUROMzQxaEI5eTdPNEYwdW1OQlov?=
 =?utf-8?B?UWxLMUFYZ0V3Ujh2QWJtNUlUZU1lWmE0ejdjUmFnaWlYZXFMcDNtMFFqMTg2?=
 =?utf-8?B?NWhjM1lzWlRaWUZWMnF0Qy9SUU1Kcm91OUc2SW1BVlJxL1NiSWR3amJmb2l3?=
 =?utf-8?B?aDloYnlRNitkTjhiVWVEQXpDaTh3OUd5V2RKU21sS3Fhcmhhb3V3bnBxY0F1?=
 =?utf-8?B?ZnZLSm5nd3p6aHlrWFNYamwyOVIvTDhmZlNWKzd5SUJjRWI3d0ZhTEJmM3pN?=
 =?utf-8?B?NzF4Z3FhTUdjcU5LenN0YjFJeHgrbE9RQUZ6bS9lbUQ0b1VPd2dHWjA3a2ZO?=
 =?utf-8?B?TUdIQW9nMjlwRmQ4MmlLdERMdUlEMDlQSytVWGk4MW1iWC9YTFpNUmppeGEw?=
 =?utf-8?B?eGprTmFkbVhHemdPYUZhcy95YkxFY3FzNGQ2VVFETHA4MzJubTdUWjZMdUNK?=
 =?utf-8?B?NGZHRTRYWThUajJzRjIva21GaEIxQ2o3aEtTcitiV25ITEkzT0ZHWUc3aWxp?=
 =?utf-8?B?TXBNN2VYcWJrZXhSeHdTMDd4NEV4TS8wL2c3ZHR3VXVSd2F6Z0wyRWtMNkdN?=
 =?utf-8?B?TW9VVTAwMnh2L05EdTkwTVdrV09HY3paSHpYWUw0azQzQU11T2ZIelN5cWFP?=
 =?utf-8?B?S1lDKzNwVDVLbkE2VUJqZDIvcVBKdWFXWENBaXJGa3FjL0ppVXFBRVVua1Iv?=
 =?utf-8?B?WnVPUUhuK1VWTFlhUkFKVmZRVjlyVmZ0aCs3SG1tRGdLTVZ2NUs5akcrdVEy?=
 =?utf-8?B?ZEpDOEFvc3VTeW9rY0wwbFFneTJpbVlUZGNXQ0N5L0kvRVlqVERpNi8wNTVs?=
 =?utf-8?B?YUU5a3Q2NWJwOW93dEFlbmhBZitEVTZzU0NHbG5vRmZLTVJPa1Nzd3ozR2gz?=
 =?utf-8?B?MDRMWklmRVNjL3NMcEFYUmtFUHZBRVdBbHdzVmJqbWJ3WUxLREZydTRIa1B4?=
 =?utf-8?B?ejQxUVdPNWtRNitzaHFLZG0rRFVkam05R3orUERQVmp4a3F0ZFhpbVgySHlh?=
 =?utf-8?B?YjlyK2JndmRTcGExL0tUOUFScWhZRFBwVFdDdUpBMkprbVlYRm94QzdzeDJY?=
 =?utf-8?B?RFdsSzUwMXU0bnRyRm81aEIzYmR6YXE3bDVBRG02cjFLNDgrS0I5MXVpM1p6?=
 =?utf-8?B?K2F3QS9YQnFIUUNxWS9saVBzWUJMYndpZm9hZVJJVTVjMVZUdkVYdFZLb3BZ?=
 =?utf-8?B?OGN6WGR6U1VHb3l3b2NMUFp6ME56T3RZZjAxSFdER2lDNlgrQXdKQjRPSmZS?=
 =?utf-8?Q?mNJk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfb37f9-3376-46fe-7c48-08dcee4db376
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 01:47:46.9917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHdgf5d/4UNGHgGhpRkOl2BPni/Cd8MUNh+IiHk8NxDkEtf7ysV4+f5dku4V0x/0ltm+SV0cpHDuVoym8mH8qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDI05bm0MTDmnIgxN+aXpSA1OjUyDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5n
QG54cC5jb20+Ow0KPiBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBEYXZpZCBT
LiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8g
QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgUmljaGFyZA0KPiBDb2NocmFuIDxyaWNoYXJkY29j
aHJhbkBnbWFpbC5jb20+DQo+IENjOiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCBuZXQtbmV4dCAwNS8xM10gbmV0OiBmZWM6IGZlY19yZXN0YXJ0KCk6IGludHJv
ZHVjZSBhIGRlZmluZSBmb3INCj4gRkVDX0VDUl9TUEVFRA0KPiANCj4gSW5zdGVhZCBvZiBvcGVu
IGNvZGluZyB0aGUgYml0IG1hc2sgdG8gY29uZmlndXJlIGZvciAxMDAwIE1CaXQvcyBhZGQgYSBk
ZWZpbmUNCj4gZm9yIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyYyBLbGVpbmUtQnVkZGUg
PG1rbEBwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVl
c2NhbGUvZmVjX21haW4uYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2Nh
bGUvZmVjX21haW4uYw0KPiBpbmRleA0KPiBjNTcwMzljYzgzMjI4ZGNkOTgwYThmZGJjMThjZDNl
YWIyZGZlMWE1Li4yZWU3ZTQ3NjViYTMxNjNmYjBkMTU4ZQ0KPiA2MGI1MzRiMTcxZGEyNmMyMiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMN
Cj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gQEAg
LTI3Niw2ICsyNzYsNyBAQCBNT0RVTEVfUEFSTV9ERVNDKG1hY2FkZHIsICJGRUMgRXRoZXJuZXQg
TUFDDQo+IGFkZHJlc3MiKTsNCj4gICNkZWZpbmUgRkVDX0VDUl9NQUdJQ0VOICAgICAgICAgQklU
KDIpDQo+ICAjZGVmaW5lIEZFQ19FQ1JfU0xFRVAgICAgICAgICAgIEJJVCgzKQ0KPiAgI2RlZmlu
ZSBGRUNfRUNSX0VOMTU4OCAgICAgICAgICBCSVQoNCkNCj4gKyNkZWZpbmUgRkVDX0VDUl9TUEVF
RCAgICAgICAgICAgQklUKDUpDQo+ICAjZGVmaW5lIEZFQ19FQ1JfQllURVNXUCAgICAgICAgIEJJ
VCg4KQ0KPiAgLyogRkVDIFJDUiBiaXRzIGRlZmluaXRpb24gKi8NCj4gICNkZWZpbmUgRkVDX1JD
Ul9MT09QICAgICAgICAgICAgQklUKDApDQo+IEBAIC0xMTYwLDcgKzExNjEsNyBAQCBmZWNfcmVz
dGFydChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldikNCj4gIAkJLyogMUcsIDEwME0gb3IgMTBNICov
DQo+ICAJCWlmIChuZGV2LT5waHlkZXYpIHsNCj4gIAkJCWlmIChuZGV2LT5waHlkZXYtPnNwZWVk
ID09IFNQRUVEXzEwMDApDQo+IC0JCQkJZWNudGwgfD0gKDEgPDwgNSk7DQo+ICsJCQkJZWNudGwg
fD0gRkVDX0VDUl9TUEVFRDsNCj4gIAkJCWVsc2UgaWYgKG5kZXYtPnBoeWRldi0+c3BlZWQgPT0g
U1BFRURfMTAwKQ0KPiAgCQkJCXJjbnRsICY9IH5GRUNfUkNSXzEwQkFTRVQ7DQo+ICAJCQllbHNl
DQo+IA0KPiAtLQ0KPiAyLjQ1LjINCj4gDQoNClRoYW5rcw0KDQpSZXZpZXdlZC1ieTogV2VpIEZh
bmcgPHdlaS5mYW5nQG54cC5jb20+DQoNCg==

