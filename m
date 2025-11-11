Return-Path: <netdev+bounces-237627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EF0C4E011
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22B6E501755
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A7C3AA18F;
	Tue, 11 Nov 2025 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="s6OwwC04"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E03AA193
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865081; cv=fail; b=WthmK+EH4/6iJQQdQC8j/2O06N5IlpRRX438rPMr1HNSZl7yDFfUEiWJHI1eq0viMsLW3OFQvOYHLEJHViaLxV0FxSDcN3PYNUgvCf9OSLm5ymrkfPK0V2XFYpTbIOC6XItTF/PmkNnr1IcTp4cyBWRaWgRL76t4c/iNvfXIX2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865081; c=relaxed/simple;
	bh=hfvCh7YATEoV+T7+S1CsLKqFWsDrXpkEuW0ER+Vw56A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PlQXz2cmUI/aB+AdabKz6Qcy/7Qwm1w5/4geodKccSF+ZMpQAeYXnKA0bW3oVbRRVLRhRZR3f4GSJFH5jH7oogl8vEWoE6vySZON3pf0JV7U2lFegT7zZ1tihncUFQEt+PowLycRbOihsLL3jid07KvukRlRAMCklt8Z3kFjPdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=s6OwwC04; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8nVS5DjJankHqzNyZn7SLQ2oVDyes/SPmeS2fd0xSR3lizuZ+i286W0OhII2L0X6l3exVHjImWhsZjChobwWJTSpSpiRwvQ3pLBAfD/2Q4JUzu5Kdy+BKeJp0bwip7R8h9lpwwze2skJhJQpq9RYc2Y2VLiGjUbMm1k5Eum5HLQAGCI9Y0Oirh6yMgdNnUKzRDYf8sEmpCoJpmzv7MCiOWy7UcuaQx8Y99KT6PyGBLD56JfKJKntaVPYxqUgtNtDM3lxwxgGlpt02zTlC2AtLkXgQXAVeJ0ZJ5VCGv8u5LjxvMyz0XpfJfCKTHCk2OcbY1SX4/cVMohPOslq73EfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfvCh7YATEoV+T7+S1CsLKqFWsDrXpkEuW0ER+Vw56A=;
 b=cbOKtn6W7ZNjuqS/cWtB1JzpMurxZZAU9+BZVsbAhOxtgpPn6dKBqHMGDeAjktsNbuw3IDZtjDCuaT9rbqRjWJd6MGI65l0MC3bMBNV+gvmNwusdVe/p591dKuonQlFWnWExO3rRL6vKPqXNxRn4kAyeEoUeuepVIFlj780z4HnZOHzIg8kXo8mshXMxPiFgxUmJWOBWXngxpk/ykS2S3BVX9zTxVU/fs26VkQT4HCR87ecq6+ZKMLoCGG8Q5mGEJmigCaKi6iRtHtk/3oMbjr0gnd0rV3jGkPcPHgn27+UpTOhc1CbklqCjJE/dTOQqybrfX0Zzw38x/cdJIP9TAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfvCh7YATEoV+T7+S1CsLKqFWsDrXpkEuW0ER+Vw56A=;
 b=s6OwwC04Gxeci8crdoVuTqFpObBEN2Jnuzot7f4TQ48lCXdGIqf66oaazfofeX/sLybq/Z/kHkreByYZ0gP2ONU/KlBkWX+fuJXGNMcJUQRmr/QUFJn2BFAEIDUzX5Kx6rlKlkERx3Bg87g66ZKo3TyMAxTkgwiD0dWTqmu4jCovv9p5oRHLzzYABRcvMp1Ik93BUl23DUhL97sP5/HAjtSzKKYzpbEXiJNal52xCjNd9M+mD+75IlIRlJdiUv8GNCEKeWVOhQ7ukKdh+h6tw8U95BZXdPdZaHlj7yfUFcZxaE95O86OsOxZcNVpZ7/o/GPteELhiErrlniTRB8veg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV2PR10MB9615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:304::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 12:44:35 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 12:44:35 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "edumazet@google.com" <edumazet@google.com>, "kuni1840@gmail.com"
	<kuni1840@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "horms@kernel.org" <horms@kernel.org>, "kuniyu@google.com"
	<kuniyu@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 07/15] ipv6: mcast: Don't hold RTNL for
 IPV6_DROP_MEMBERSHIP and MCAST_LEAVE_GROUP.
Thread-Topic: [PATCH v3 net-next 07/15] ipv6: mcast: Don't hold RTNL for
 IPV6_DROP_MEMBERSHIP and MCAST_LEAVE_GROUP.
Thread-Index: AQHcUwjvNtUtpW9H/EGDOjs11xos4A==
Date: Tue, 11 Nov 2025 12:44:35 +0000
Message-ID: <94edb069a793c63a455ef129658f2832460f104f.camel@siemens.com>
References: <20250702230210.3115355-1-kuni1840@gmail.com>
	 <20250702230210.3115355-8-kuni1840@gmail.com>
In-Reply-To: <20250702230210.3115355-8-kuni1840@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV2PR10MB9615:EE_
x-ms-office365-filtering-correlation-id: 440239d3-732c-4eb9-b19c-08de212011cd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUkvVndhT0ZxWUI0aEtTcDh3ZGdiWHJqOWl1WmxtTHhaOFlvOWRMbjg0cEtS?=
 =?utf-8?B?aXFLYkxWRW01MkpoMmZUSDMraktKSDVTVFdZUnY0eExuM2V6ejJCSEEzb3g4?=
 =?utf-8?B?a0oxR3JsTXd0VmlmaDEzRUhmbTlSaGpDNkxNRUszUlBnU3lycXBzMTIyTk0r?=
 =?utf-8?B?L1c5TXFkU2s3RnQ3R1daSGg2MXhWcldKSmNUd1NMT2VsYUt2RGFXTW9FeHFq?=
 =?utf-8?B?UVJrL3NJanc1S3FMbS9GRVZ6d1BMaUovUHM5dTgzWlhlb042QnZGbG11eG10?=
 =?utf-8?B?cC90ZzJHVkh5YUVxZlljVVF6dWpzbWh3ZzcwZ3RkY1pTTzVSYnVWVlJxU2Nm?=
 =?utf-8?B?U0ZRU1RnNHFNL2lpdDlTRFBtbGJ1aFBsLzY5Zkk5VFBYRzI5bUMxS2FCcmNv?=
 =?utf-8?B?M0dDanhZTVdJQWNoNXJ6NE9nT2RnY090NVFKakRrVFY0K0ZYaUJmRzFBSmVS?=
 =?utf-8?B?R3V1ZjJjZjhTc0FFcTM0eURJbDBQbm11WjBHZmN4ZU9MQjdvVFV2K3hEbjF2?=
 =?utf-8?B?QjRrY20rTG5tUHQwUVI2RThYcWFzZWhpSzJubWIxMGU5V0Rid0JTZ1FCdGFj?=
 =?utf-8?B?N2VFVFVOYURvb2tlc1I4TzI0RkVmdzJ6V09ZcE9ldXRMZjZkVTNLNDZEQ2ZY?=
 =?utf-8?B?MFMxWVRDeDJ3MmlMbktSWHhvT1lEaDNvQ2gwbWZhU0tIKzJuaFRhTHBXdVB4?=
 =?utf-8?B?RHRyTlVUVm1ESGhLYlJJTWV1Q082YzNIUlpZRDhxUzRVSTE4RlFUTFpmaWl3?=
 =?utf-8?B?aDZsTjJscGpET1REejliaDE5RkpNY3Vtak1wUkxqYkd6djNPWmpYaGpFUnhL?=
 =?utf-8?B?S2VxR2NWczZOR0ExenRGN1NVeS81bU1oNDdUYUs5WHRpeER1R1NWeUR3VW5s?=
 =?utf-8?B?U1pOOElnWHdxOVcvaEhla0dEVnZiNjdQYTk4Y3hqb2hNd0RVYTFIbE9xeXhV?=
 =?utf-8?B?RDF3MjFqL1Nib3Rpbkhld2N0RzhCWE1OZ3QzMWoxM2lZUTRQeUhzQ0N4TUtj?=
 =?utf-8?B?Qk1ISUV4ZHBLamZmWjc1L0ZDc1NWaHRLSUE2WmViOU9ha0NKTjJJaVpjZDZu?=
 =?utf-8?B?RXpSZkdCcENIMkozQlF6ZDlucG5jekJwbmZCUnd1V3o0RlBaOTArUVpoQnNo?=
 =?utf-8?B?Zm4weEQxMjV0K2lKMmdHZGRNam96VjREMitIR0pxWkJSa1RwUktzWGw4YU4z?=
 =?utf-8?B?VExtQ1hsZk1VaDhFZExsanF1M3NmdWFFZFF0RkorY2V6WnlnVTNQWUhYVHAy?=
 =?utf-8?B?SkI1Rk10RjAyTjF5aU5abjZKWUM0MzgwZnJHMDN0VlpBRU0rQ1hPNG91OVRY?=
 =?utf-8?B?ei9RQ2NWVy9RMDRtM04vZEdzUFA4TDQwbkwvWHgwRFVDNVVlTDlIRzBVU3N2?=
 =?utf-8?B?b1pMZnNXN05oVlNLMXYxRkNwSC9jUDRJdnhjYThxSWFMeWZBZ3N1N2ROYW9S?=
 =?utf-8?B?SGhyaDh5QlMyaWt1QUkrRHRwV3hZWG0zM3Q0UkdpRVpTeStmMm5kN1VpeTQ5?=
 =?utf-8?B?ZkFYdW1zMXNaS0YzM2E3UlZGRmpNRUhmd2ZUNW85MlJ3dWlnc0xjd29xdjJU?=
 =?utf-8?B?WUdjcWxSR2pza2lHV0hJWllaN0YrUkpkRHlMUG80QVI2aWo4dzNmNmJwMWY4?=
 =?utf-8?B?czl5TEhyb25oeEVSNjQrNU0xTWlsNUM5UTVvajBPK0JtT3Bic2Y5ZlFNVlFK?=
 =?utf-8?B?Q09QRnFEZDZkeERIYSsxRkloMGVVanhpSENQVWV3ZFBTM3FKTUVVRkk4aHE3?=
 =?utf-8?B?dTFPWVN0ejFBWmlSUlNOWCtpdDJ6V09uR1JpOUg1RHpjR2NhRFVyUG45SnFV?=
 =?utf-8?B?T3J1Q2JEMkJjaS9GbUJlOG9qbWoxSkdFL3ptQTB5VUVNa1Jyc3ZvTWZqZzdO?=
 =?utf-8?B?YUtFZWIva0RXRG1HVHQyV2lrSlZ0ME1BYUdqekJwTDJkVGhGV0N5UlpTeU53?=
 =?utf-8?B?UWh1WWQyZVp3d3VzWmxRa3hWVDhhaG1lZzE2Z043S2NaelBIWExFMGdoVFRr?=
 =?utf-8?B?Y1pQN0JhbERhRnYyRW1zZ3lDYW1sajQ5WnkxalZoSW1NNVUwNzZGVTJRbFRC?=
 =?utf-8?Q?5BsB7+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHg2ai9JYkJSZkJxOEN4c3BpZmUyQ0poWWFnL1FQYkNlaHR5WUNoaG5xT1hp?=
 =?utf-8?B?Z0FpWnVMakxDOXJQNDF4MGlIWGtTaWxDOWNKZE53V3hMaEV2ZGZNMUd4ek0w?=
 =?utf-8?B?UDA1S2o4NGFQcWJ3VDVmVlloUXhta3lFbEtyL0lveHVZYkF3T2hPWnJKUi9R?=
 =?utf-8?B?b2h6dGxBYU02cmQvbmF1RGNkbG56Q1U3RFRNY3E4bmlISjE4NVQzczBLWGZ4?=
 =?utf-8?B?MWVqR2ZxSFd4U0p6dmxkUHMzRmJJVHRsUG54TUFRWW82dkx3TjJWLzFTMWE4?=
 =?utf-8?B?TXJUT0pGNmoyNW45eGp4WHk0YllRRmJBOXVKajVnbU9IdGxldEpiRUZqVkhC?=
 =?utf-8?B?RmMyelJiaHR5NDhQSGxhSVl4ellvSi9McG9JSGhKaFd1MDFLNXlBenQ0R2or?=
 =?utf-8?B?NGRVY203dk04L25JVjB6N0JPeHNvUTVBdmJHc0p0bFI0VzBkNGQ2T2Q1VXBw?=
 =?utf-8?B?RGx3MmkyTHZldHI4bFJNMlRubzdTM21zTWd1VjAxTmpPazFJT0luOVJYRURp?=
 =?utf-8?B?aXBxNXFJVmZYM3lzelhtbGdvZE1TTW9CT0J6d2hWenlCbmJHMk54Y2szUWVC?=
 =?utf-8?B?T1kvQUhTU0t2c0VHUTBFdUpUa3RPNkJLVzVvSjYzMXkvMFBIR0RBZUc0NWpF?=
 =?utf-8?B?MWxud0dqQlNGM2JQbEN5ZFFJbXg0TDg4WFNUb3k0aWpWYzMxcjNmbDVadXda?=
 =?utf-8?B?U1NXUWJJMmlrN3ZsVlRLNDdGZ3B4ak1rNGh3TzhzQ3gxeEdiTnJRSmk5blFp?=
 =?utf-8?B?SVJVczJOUm44U201OEw1c3hFWU9lZm41a2o2Q2NwSjRBR3JWdWcrd0o4dmVF?=
 =?utf-8?B?MGwrd1RBMG43V0JxR2Fuc0xNN0hrVzJSZ2lpM1FjTHdhcjk2eWtKdnp1N0Rv?=
 =?utf-8?B?OWpuck9wZjA5cFZxOWtZTG1GSnZaeVR5cmhxWGlqSnNzNXp5eU5pMkZKeUU2?=
 =?utf-8?B?clNkK1EzRUg0QS96c1FzUWdyUlBDM1M4dnF3NDdLYTNOczd1eFBvTTdXbFhv?=
 =?utf-8?B?NGlBR2Q4d1ZvRHJGbjNDNVlDMGxaR1FIVWE0MnA5Wng5bFNiYXZrSTZJMkdq?=
 =?utf-8?B?R3kyVUVRbEhTRnpIU0xSMUwxOS9TSHRiYnVEaHlHdjRXMGJmYkJKYmZudU9n?=
 =?utf-8?B?R0VvY3oyQ2ttZzhFZkRWMlJyWjRhK1UrOHJrUmpjUmJLekdUcGJGVWIwRCtm?=
 =?utf-8?B?Q3NHQ1hjZWdzYUptRmtTQlBMWVJETlZXd0h3b0RQUVNDWlhoalRwaDlzUG1N?=
 =?utf-8?B?VlRJUDBqVjdyOGlFRjNGMmpERUNlVy9vNEpPT0JiZnFDa21QN0ZYOXo3NXlK?=
 =?utf-8?B?RVk2cU82QU9mTlJJMS9GS0Z1SStTRmtEelBtS1dkMUpoL3FwakxjZjd2MnBU?=
 =?utf-8?B?TXhnVlRkb29iTHM1OVhvclBoNGVITWhjOW9XYWl4Q05rc2dqeXpBemdFY09H?=
 =?utf-8?B?ZEdqazk1V0dvREhIczU3N1F1R3JZYnJ4bDQ5L2NNRVFmZ2xDWU9Ic2NScElI?=
 =?utf-8?B?YTRZYUphYzFZenMxcmJHWCsxRkN1Ti9wOWRsNUthV0g3MWJ0SDU3d291bTd4?=
 =?utf-8?B?NXJqMFdnYkdCK084NHJlczMzUFZrZi9KUU5hMHZYV2lGR1ROTWFkN2d3cEdz?=
 =?utf-8?B?M29ERlV1TmN6YXIxWU1QMmVSelpFc1N3RnM0aUZjMFVobjdMUXhGdlBLTTdO?=
 =?utf-8?B?MFBQKzcweDM3WGJ1NjV4ZFoyc3Jrak9HaXdqY3QraTB6U3hLeld5VnJKZHg4?=
 =?utf-8?B?Ly9IR3lQQTVQTnJYNXdrYm1zT1ptcUhhWEttbE53NFVrYzJxT1B6YXlBNWtD?=
 =?utf-8?B?cEpRWldJV1pUcHp0OEFJNkFxYzRCempVeG4vUmh3bkVxOUtPeFo1QklNNmxp?=
 =?utf-8?B?NlVGSHR6Ym9aWWRjV3RGZWdpQXVZV29wcFg3MHVLb3pTWmI5UWRDUTNieVUx?=
 =?utf-8?B?RFBqSlYwUmVkVlNiVEZSUDBWanZXQms3ZXcvbHFtYXZFTllpQ3VRMURDdjMx?=
 =?utf-8?B?ayt4TjQvMEFrQ1BqaGNqdC9GVWZLVlBNYTNwL2JpWWpGdGNYc0x4cEk0UWtt?=
 =?utf-8?B?eHZFTWJtSmVwSE9NYVlrbTMreHdpQ1Fqd01uSEZ5WEJFcEU2VmJ3b01lTEN3?=
 =?utf-8?B?cXI1VXdNTnpGY2RUYlE5TzR3VnRpWklxZmZZQXRQQktJZTR1Z0VHZStXM3Bk?=
 =?utf-8?Q?p9J+4X1h1/9QUk/+9lyY6jU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEA2210CB7684942884065D60846B470@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 440239d3-732c-4eb9-b19c-08de212011cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 12:44:35.4508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwcw61K+B83ff+eO5MjIMf7x9UpFEQbv9jC2BGbfUWzgERNroA/BjLGUgsl9c/Ixyw2km/EWNbepn80/2srlh8tC0ZD/OiR4ik71u9THAq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9615

SGVsbG8gS3VuaXl1a2ksDQoNCk9uIFdlZCwgMjAyNS0wNy0wMiBhdCAxNjowMSAtMDcwMCwgS3Vu
aXl1a2kgSXdhc2hpbWEgd3JvdGU6DQo+IEZyb206IEt1bml5dWtpIEl3YXNoaW1hIDxrdW5peXVA
Z29vZ2xlLmNvbT4NCj4gDQo+IEluIF9faXB2Nl9zb2NrX21jX2Ryb3AoKSwgcGVyLXNvY2tldCBt
bGQgZGF0YSBpcyBwcm90ZWN0ZWQgYnkgbG9ja19zb2NrKCksDQo+IGFuZCBvbmx5IF9fZGV2X2dl
dF9ieV9pbmRleCgpIGFuZCBfX2luNl9kZXZfZ2V0KCkgcmVxdWlyZSBSVE5MLg0KPiANCj4gTGV0
J3MgdXNlIGRldl9nZXRfYnlfaW5kZXgoKSBhbmQgaW42X2Rldl9nZXQoKSBhbmQgZHJvcCBSVE5M
IGZvcg0KPiBJUFY2X0FERF9NRU1CRVJTSElQIGFuZCBNQ0FTVF9KT0lOX0dST1VQLg0KPiANCj4g
Tm90ZSB0aGF0IF9faXB2Nl9zb2NrX21jX2Ryb3AoKSBpcyBmYWN0b3Jpc2VkIHRvIHJldXNlIGlu
IHRoZSBuZXh0IHBhdGNoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3VuaXl1a2kgSXdhc2hpbWEg
PGt1bml5dUBnb29nbGUuY29tPg0KPiBSZXZpZXdlZC1ieTogRXJpYyBEdW1hemV0IDxlZHVtYXpl
dEBnb29nbGUuY29tPg0KPiAtLS0NCj4gIG5ldC9pcHY2L2lwdjZfc29ja2dsdWUuYyB8ICAyIC0t
DQo+ICBuZXQvaXB2Ni9tY2FzdC5jICAgICAgICAgfCA0NyArKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyks
IDIyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9pcHY2L2lwdjZfc29ja2ds
dWUuYyBiL25ldC9pcHY2L2lwdjZfc29ja2dsdWUuYw0KPiBpbmRleCBjYjBkYzg4NWNiZTQuLmM4
ODkyZDU0ODIxZiAxMDA2NDQNCj4gLS0tIGEvbmV0L2lwdjYvaXB2Nl9zb2NrZ2x1ZS5jDQo+ICsr
KyBiL25ldC9pcHY2L2lwdjZfc29ja2dsdWUuYw0KPiBAQCAtMTIxLDEwICsxMjEsOCBAQCBzdGF0
aWMgYm9vbCBzZXRzb2Nrb3B0X25lZWRzX3J0bmwoaW50IG9wdG5hbWUpDQo+ICB7DQo+ICAJc3dp
dGNoIChvcHRuYW1lKSB7DQo+ICAJY2FzZSBJUFY2X0FERFJGT1JNOg0KPiAtCWNhc2UgSVBWNl9E
Uk9QX01FTUJFUlNISVA6DQo+ICAJY2FzZSBJUFY2X0pPSU5fQU5ZQ0FTVDoNCj4gIAljYXNlIElQ
VjZfTEVBVkVfQU5ZQ0FTVDoNCj4gLQljYXNlIE1DQVNUX0xFQVZFX0dST1VQOg0KPiAgCWNhc2Ug
TUNBU1RfSk9JTl9TT1VSQ0VfR1JPVVA6DQo+ICAJY2FzZSBNQ0FTVF9MRUFWRV9TT1VSQ0VfR1JP
VVA6DQo+ICAJY2FzZSBNQ0FTVF9CTE9DS19TT1VSQ0U6DQo+IGRpZmYgLS1naXQgYS9uZXQvaXB2
Ni9tY2FzdC5jIGIvbmV0L2lwdjYvbWNhc3QuYw0KPiBpbmRleCBkNTVjMWNiNDE4OWEuLmVkNDBm
NWIxMzJhZSAxMDA2NDQNCj4gLS0tIGEvbmV0L2lwdjYvbWNhc3QuYw0KPiArKysgYi9uZXQvaXB2
Ni9tY2FzdC5jDQo+IEBAIC0yNTMsMTQgKzI1MywzNiBAQCBpbnQgaXB2Nl9zb2NrX21jX2pvaW5f
c3NtKHN0cnVjdCBzb2NrICpzaywgaW50IGlmaW5kZXgsDQo+ICAvKg0KPiAgICoJc29ja2V0IGxl
YXZlIG9uIG11bHRpY2FzdCBncm91cA0KPiAgICovDQo+ICtzdGF0aWMgdm9pZCBfX2lwdjZfc29j
a19tY19kcm9wKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IGlwdjZfbWNfc29ja2xpc3QgKm1jX2xz
dCkNCj4gK3sNCj4gKwlzdHJ1Y3QgbmV0ICpuZXQgPSBzb2NrX25ldChzayk7DQo+ICsJc3RydWN0
IG5ldF9kZXZpY2UgKmRldjsNCj4gKw0KPiArCWRldiA9IGRldl9nZXRfYnlfaW5kZXgobmV0LCBt
Y19sc3QtPmlmaW5kZXgpOw0KPiArCWlmIChkZXYpIHsNCj4gKwkJc3RydWN0IGluZXQ2X2RldiAq
aWRldiA9IGluNl9kZXZfZ2V0KGRldik7DQo+ICsNCj4gKwkJaXA2X21jX2xlYXZlX3NyYyhzaywg
bWNfbHN0LCBpZGV2KTsNCj4gKw0KPiArCQlpZiAoaWRldikgew0KPiArCQkJX19pcHY2X2Rldl9t
Y19kZWMoaWRldiwgJm1jX2xzdC0+YWRkcik7DQo+ICsJCQlpbjZfZGV2X3B1dChpZGV2KTsNCj4g
KwkJfQ0KPiArDQo+ICsJCWRldl9wdXQoZGV2KTsNCj4gKwl9IGVsc2Ugew0KPiArCQlpcDZfbWNf
bGVhdmVfc3JjKHNrLCBtY19sc3QsIE5VTEwpOw0KPiArCX0NCj4gKw0KPiArCWF0b21pY19zdWIo
c2l6ZW9mKCptY19sc3QpLCAmc2stPnNrX29tZW1fYWxsb2MpOw0KPiArCWtmcmVlX3JjdShtY19s
c3QsIHJjdSk7DQo+ICt9DQo+ICsNCj4gIGludCBpcHY2X3NvY2tfbWNfZHJvcChzdHJ1Y3Qgc29j
ayAqc2ssIGludCBpZmluZGV4LCBjb25zdCBzdHJ1Y3QgaW42X2FkZHIgKmFkZHIpDQo+ICB7DQo+
ICAJc3RydWN0IGlwdjZfcGluZm8gKm5wID0gaW5ldDZfc2soc2spOw0KPiAtCXN0cnVjdCBpcHY2
X21jX3NvY2tsaXN0ICptY19sc3Q7DQo+ICAJc3RydWN0IGlwdjZfbWNfc29ja2xpc3QgX19yY3Ug
Kipsbms7DQo+IC0Jc3RydWN0IG5ldCAqbmV0ID0gc29ja19uZXQoc2spOw0KPiAtDQo+IC0JQVNT
RVJUX1JUTkwoKTsNCj4gKwlzdHJ1Y3QgaXB2Nl9tY19zb2NrbGlzdCAqbWNfbHN0Ow0KPiAgDQo+
ICAJaWYgKCFpcHY2X2FkZHJfaXNfbXVsdGljYXN0KGFkZHIpKQ0KPiAgCQlyZXR1cm4gLUVJTlZB
TDsNCj4gQEAgLTI3MCwyMyArMjkyLDggQEAgaW50IGlwdjZfc29ja19tY19kcm9wKHN0cnVjdCBz
b2NrICpzaywgaW50IGlmaW5kZXgsIGNvbnN0IHN0cnVjdCBpbjZfYWRkciAqYWRkcikNCj4gIAkg
ICAgICBsbmsgPSAmbWNfbHN0LT5uZXh0KSB7DQo+ICAJCWlmICgoaWZpbmRleCA9PSAwIHx8IG1j
X2xzdC0+aWZpbmRleCA9PSBpZmluZGV4KSAmJg0KPiAgCQkgICAgaXB2Nl9hZGRyX2VxdWFsKCZt
Y19sc3QtPmFkZHIsIGFkZHIpKSB7DQo+IC0JCQlzdHJ1Y3QgbmV0X2RldmljZSAqZGV2Ow0KPiAt
DQo+ICAJCQkqbG5rID0gbWNfbHN0LT5uZXh0Ow0KPiAtDQo+IC0JCQlkZXYgPSBfX2Rldl9nZXRf
YnlfaW5kZXgobmV0LCBtY19sc3QtPmlmaW5kZXgpOw0KPiAtCQkJaWYgKGRldikgew0KPiAtCQkJ
CXN0cnVjdCBpbmV0Nl9kZXYgKmlkZXYgPSBfX2luNl9kZXZfZ2V0KGRldik7DQo+IC0NCj4gLQkJ
CQlpcDZfbWNfbGVhdmVfc3JjKHNrLCBtY19sc3QsIGlkZXYpOw0KPiAtCQkJCWlmIChpZGV2KQ0K
PiAtCQkJCQlfX2lwdjZfZGV2X21jX2RlYyhpZGV2LCAmbWNfbHN0LT5hZGRyKTsNCj4gLQkJCX0g
ZWxzZSB7DQo+IC0JCQkJaXA2X21jX2xlYXZlX3NyYyhzaywgbWNfbHN0LCBOVUxMKTsNCj4gLQkJ
CX0NCj4gLQ0KPiAtCQkJYXRvbWljX3N1YihzaXplb2YoKm1jX2xzdCksICZzay0+c2tfb21lbV9h
bGxvYyk7DQo+IC0JCQlrZnJlZV9yY3UobWNfbHN0LCByY3UpOw0KPiArCQkJX19pcHY2X3NvY2tf
bWNfZHJvcChzaywgbWNfbHN0KTsNCj4gIAkJCXJldHVybiAwOw0KPiAgCQl9DQo+ICAJfQ0KDQpJ
J20gZ2V0dGluZyB0aGUgYmVsb3cgc3RhY2ssIHRob3VnaCB1bnJlbGlhYmx5LCBkdXJpbmcNCmtl
cm5lbC1zZWxmdGVzdC9kcml2ZXJzL25ldC9kc2EvbG9jYWxfdGVybWluYXRpb24uc2ggcnVucyB3
aXRoIGRpZmZlcmVudCBuZXctbmV4dA0KcmV2aXNpb25zIGJhc2VkIG9uIHY2LjE4LXJjWDoNCg0K
UlROTDogYXNzZXJ0aW9uIGZhaWxlZCBhdCBnaXQvbmV0L2NvcmUvZGV2LmMgKDk0NzcpDQpXQVJO
SU5HOiBDUFU6IDEgUElEOiA1MjcgYXQgZ2l0L25ldC9jb3JlL2Rldi5jOjk0NzcgX19kZXZfc2V0
X3Byb21pc2N1aXR5KzB4MWQwLzB4MWUwDQpwYyA6IF9fZGV2X3NldF9wcm9taXNjdWl0eSsweDFk
MC8weDFlMA0KQ2FsbCB0cmFjZToNCiBfX2Rldl9zZXRfcHJvbWlzY3VpdHkrMHgxZDAvMHgxZTAg
KFApDQogX19kZXZfc2V0X3J4X21vZGUrMHhmOC8weDExOA0KIGlnbXA2X2dyb3VwX2Ryb3BwZWQr
MHgxZTgvMHg2MTgNCiBfX2lwdjZfZGV2X21jX2RlYysweDE2NC8weDFkMA0KIGlwdjZfc29ja19t
Y19kcm9wKzB4MWFjLzB4MWUwDQogZG9faXB2Nl9zZXRzb2Nrb3B0KzB4MTk5MC8weDFlNTgNCiBp
cHY2X3NldHNvY2tvcHQrMHg3NC8weDEwMA0KIHVkcHY2X3NldHNvY2tvcHQrMHgyOC8weDU4DQog
c29ja19jb21tb25fc2V0c29ja29wdCsweDdjLzB4YTANCiBkb19zb2NrX3NldHNvY2tvcHQrMHhm
OC8weDI1MA0KIF9fc3lzX3NldHNvY2tvcHQrMHhhOC8weDEzMA0KIF9fYXJtNjRfc3lzX3NldHNv
Y2tvcHQrMHg3MC8weDk4DQogaW52b2tlX3N5c2NhbGwrMHg2OC8weDE5MA0KIGVsMF9zdmNfY29t
bW9uLmNvbnN0cHJvcC4wKzB4MTFjLzB4MTUwDQogZG9fZWwwX3N2YysweDM4LzB4NTANCiBlbDBf
c3ZjKzB4NGMvMHgxZTgNCiBlbDB0XzY0X3N5bmNfaGFuZGxlcisweGEwLzB4ZTgNCiBlbDB0XzY0
X3N5bmMrMHgxOTgvMHgxYTANCmlycSBldmVudCBzdGFtcDogMTM4NjQxDQpoYXJkaXJxcyBsYXN0
ICBlbmFibGVkIGF0ICgxMzg2NDApOiBbPGZmZmY4MDAwODAxM2RhMTQ+XSBfX3VwX2NvbnNvbGVf
c2VtKzB4NzQvMHg5MA0KaGFyZGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoMTM4NjQxKTogWzxmZmZm
ODAwMDgxODIzZWU4Pl0gZWwxX2JyazY0KzB4MjAvMHg1OA0Kc29mdGlycXMgbGFzdCAgZW5hYmxl
ZCBhdCAoMTM4NjEwKTogWzxmZmZmODAwMDgxMTQ0ODE0Pl0gbG9ja19zb2NrX25lc3RlZCsweDhj
LzB4YjgNCg0KRG8geW91IGhhdmUgYW4gaWRlYSB3aGF0IGNvdWxkIGJlIGZvcmdvdHRlbiBpbiB0
aGUgU3ViamVjdCBwYXRjaD8NCg0KRG8gd2UgbmVlZCB0byBkcm9wIEFTU0VSVF9SVE5MKCkgZnJv
bSBfX2Rldl9zZXRfcHJvbWlzY3VpdHkoKSBub3csIG9yIGFtIEkNCnRvbyBuYWl2ZT8NCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

