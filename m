Return-Path: <netdev+bounces-203839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CFAAF76FA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061F23AC8C0
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481C1AF0B4;
	Thu,  3 Jul 2025 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mJtBA23L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96711CAA96
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552210; cv=fail; b=lBg4FKshx3tpQkxbEdQq76YIU5vKNfRMh6CHwxqlepqlXpblphANehKx1nF/acwngm7y3QbRnQCQ25Kc2xlLMR8i9eALMlBOmJdzycwOL1W/a1iHjJcEaF7TJMVG0ch0GC/UsIEK7IAJMJEhb8CzdrPoezoBkgX+g+YybI4jA5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552210; c=relaxed/simple;
	bh=oJQ32mpeXmt4UZ9oIN1p52n0WhzmC5H9AK/UilnhoOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TU38wdmvZm+DMvZ5ntdV7PwhT4PyLGbbkUnsNy4VX4s5noj/krUCrLl1930ZrMb5vdV2yjkXfKGZY7GQyDBEMx/eEsyt6NtbUIbOWA99QVLuUqUsBNa8S9D7dWSnVBfMrX0u8hU5QDh4klTApZSw47xS+nI6V+vq9zyavjkQL2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mJtBA23L; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEeKOU6Nxv9dSltDjAmNh9iLy74BTNWNJGvBTcUddR4ai73GimG0ehDsaZR4W1PCK469MmWC2/oM/LP936hMcKoIJ1MFj8za2u9C+BYbBNt2E+0BbbltoLLXEMOQ97T3x/SfjwTh8+pW6qs0HVZuYZBN7ZN5Rqth5fuweFqHI7baUaR1xOdwqi2nA785xkHDWIrmTn4tYLtNjsVqwkIfdl6uqAClYcVvEsbm3xmqMVDXiQ9ndgQ1x3RVrCywRJtL9sJ+2zht+GntwQqfuVwrId1Mil2xytSUEzL7YL+ya5NLurQVBXT4dA0pEIfWH7LsDBl3CWx2uBJsR2NxQ54pUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJQ32mpeXmt4UZ9oIN1p52n0WhzmC5H9AK/UilnhoOo=;
 b=Ed+PuGlqw3xJ1bEXr4BBMnWam1eAkDcfcFF0F5y9kKTuV5AYNoaRW7ohBgNCR71+YXe6b5k6yiDeQXfcPMvRmglMWIPTyfJPmiohPkhWJmQLXFTIK8qoEqcv7bQJXTxUWLA36uDoRsSBdIZ0XLQHGU8TAz/RmIvk/Xq+v4m6MNcq5PzAR3wYnuZIvEeTM3hjdkDJnTPBTNVTIh6Y1jaCKnDxuM8fMZaDmK1trO+2kXeURmFweTeJsnWGrf/TG/6wgzCjAJRivsViAuACOgk/Awa6DRE35XmSPTCD1pcX7jvWg9qetsXx6TSMChOauPJZbWX0XRlUQ814NgyItJwkdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJQ32mpeXmt4UZ9oIN1p52n0WhzmC5H9AK/UilnhoOo=;
 b=mJtBA23L7zkPajuPQ8lKdKqQWDx6J/7QL8EOFuNsZwURssVd9YNlqv438JAyKjB2oN0pVQXBvXpkQvxj/81IQ9qC+uX3WqfDdZ9aBsfxxnV+v/3sFU+gLaToXT16KXccqKF6iKIgCwQ4JZIvzMQC2aFGZudIloreCLfSb3T/EdwASIoKX3HqqA+KaPYHW1Zbopi+RuYN5f9hC6iueiNd7ErqVg6mcsiQhMM9BQeqMeYyvISOw8qrkciSuXsXVvd6fVR3d/kJjY3QLeURY0UxLBMwpx/UmTeHI3FSpuW74ZD2VLZJxeOG7uE1BE9fIBm5qmjQ13Implh9SlKdFdJgvA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CY8PR12MB7756.namprd12.prod.outlook.com
 (2603:10b6:930:85::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Thu, 3 Jul
 2025 14:16:43 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8835.025; Thu, 3 Jul 2025
 14:16:43 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "erwan.dufour@withings.com" <erwan.dufour@withings.com>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "leon@kernel.org"
	<leon@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mrarmonius@gmail.com"
	<mrarmonius@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH] [PATH xfrm offload] xfrm: bonding: Add xfrm packet
 offload for active-backup mode
Thread-Topic: [PATCH] [PATH xfrm offload] xfrm: bonding: Add xfrm packet
 offload for active-backup mode
Thread-Index:
 AQHb6TnEtCc8cVCBnkaQratSuN9zcrQbe70AgAA9xACAARZOgIAAuToAgADxRACAAQ2xAIAA78EA
Date: Thu, 3 Jul 2025 14:16:43 +0000
Message-ID: <2152c417f85fd77d795da7fea1d7daadb312ce41.camel@nvidia.com>
References: <20250629210623.43497-1-mramonius@gmail.com>
	 <aGJiZrvRKXm74wd2@fedora>
	 <CAJ1gy2gjapE2a28MVFmrqBxct4xeCDpH1JPLBceWZ9WZAnmokg@mail.gmail.com>
	 <aGN_q_aYSlHf_QRD@fedora>
	 <CAJ1gy2ghhzU0+_QizeFq1JTm12YPtV+24MyJC_Apw11Z4Gnb4g@mail.gmail.com>
	 <aGTlcAOa6_ItYemu@fedora>
	 <CAJ1gy2h+BtDPZ2y4umhjVMrD74Nd5dZezdZOOy-YqLvyFGKKQA@mail.gmail.com>
In-Reply-To:
 <CAJ1gy2h+BtDPZ2y4umhjVMrD74Nd5dZezdZOOy-YqLvyFGKKQA@mail.gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CY8PR12MB7756:EE_
x-ms-office365-filtering-correlation-id: 03805a1c-8831-479f-643c-08ddba3c3c7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmhqREN2WW1PSFNZYjZGalZmd01hWEhtVFpEYTMxa1YrazRGU3JRS2ZxWldB?=
 =?utf-8?B?WU93N2NMUjNsdmZlaGFxOXNHMnlMejFOWFlRZzR6TmgwcXZsYVJHZ3lNdzNl?=
 =?utf-8?B?K3lOQ3REZTZ5M21BNkhPQ1NxNjlEdUFYY0dIS2xtYzFHZ3M0T3pwbkNzYVlN?=
 =?utf-8?B?a3BWa1BZd1U0alJKSGtBdlVLdE9wNFNza0lNQUs2dFgxOE9aeW9idE1Fbk0z?=
 =?utf-8?B?UitwNWFNODQ4dEc2L3BSSFFkNEg4UWpkYno1QU8xLzZ3QzY0NU5GRUU4Vmsx?=
 =?utf-8?B?b2lrVFJXVGNseWVsSmNqSkdXNUxUbU15aXRWV2FyYWllWi9oeC9wVXYvaVFy?=
 =?utf-8?B?NnZqQkUxaGdjeFdvV0RYeWlxV09mcjEwQ1crMitIOEdpVGhiL242Q3BCcG9x?=
 =?utf-8?B?UUNOc1FNajJ1Z2VMWTVBdnhQVitZZk9mV1Z6ZktzcHZTdTMrVEJwZGhaTktm?=
 =?utf-8?B?T1BxdjNFYjZjSEFoRmd0V1NDakRrbExyU3V3TUtZVGRYekhSTlMxWGxFWGtZ?=
 =?utf-8?B?QThadGI1dzR2RHFKa2NoaVU0R05Md0JTYnViWHZQd2E1M0FmeStBYnZhTGVC?=
 =?utf-8?B?Tmg0TWFDU09IQXhUVFlJaDdqMjZWN1MzeTZ1eGFIL1dORDVwNENKczNtZWZj?=
 =?utf-8?B?WUV6SWN2aFZ6T0doT0ozK0Y0UGljVU1HYkZ2TUFjUkdHMjk0TndNbnhYVXM0?=
 =?utf-8?B?UUlzTEY4K29VekdSMzM5SFVpTEZwaERWMDZXR2tkR1p5SFN3dkJUNHdndjZm?=
 =?utf-8?B?YmlvQlcxWkw2THRieXI1NUdteVhNRW1obExzWXovSUtUZW1HWDFCV1lUV2FS?=
 =?utf-8?B?NXJrN2EydnYwNFRFMCs4em9QVEVBWXhLV1VNVUNhVnNCL0J1KzNTOENqT0Y3?=
 =?utf-8?B?M1lWajFkcm8wOTdadzAwTm9QZTdJTWFQUHArSXNreFZtdk1wY1NrS3VaeVNU?=
 =?utf-8?B?cVVkbUt4aGw5OEhJbUZYTHJIWXI3elBPT083RHlEaHlyNkZtL2IvZkJsa21M?=
 =?utf-8?B?L3U3VWVoeUQ3WUI4VWNLWUp2MGpLZVNsa2orWG9FcWUzVmpjOGhkaVR6T21x?=
 =?utf-8?B?amcvcytKeldkVENVVGlqTmFZUVNPT0dwaHpmRVJ1Y3BWRm5tM0owaUhSWnBq?=
 =?utf-8?B?eW5vME40Ry9nY1EzZlpERnljbXFTQjloVkRGUFUvQi9wTW1tZ1g1M2JDNlA1?=
 =?utf-8?B?aUJsNW4zM3I5eXZsSjgvR3pRdWRDSjJjdFN1UXp5QTZrZCtkZytZRFlYUGw3?=
 =?utf-8?B?SjJOWjBzMlpZMkhQbEFpbjB3NUlvNXA3TWUzc3FXWisvcnU3TlprSE94UzF4?=
 =?utf-8?B?OGZYcFlaMklVMFdBSkJUYkw3K0g3SUVJZ2RaZmk2eEF5Sk5iaDJ5MnQ3MEw5?=
 =?utf-8?B?V3YwUHFGZmxoeXlrTGxIemRiNjVEcUwvTVdxVDF2SU15YW4ydTMvVFYrSUV3?=
 =?utf-8?B?Qm56YVZ1VG5XY1RHYUFnZzJtY3hGejF4cUx1ZUY0SVBiaXhwbzFTS1JmUGw4?=
 =?utf-8?B?R2tYZFcrblZFSmJDeHM5Yzh5R2RFY2U5a0lzZzRGN0RpR3NORDJoSE5QWWtO?=
 =?utf-8?B?QzROWm5odTlHMmpwMlIrUktQQUdaOW96cnk0NWRmY2g2VEtIejg5TEpzbXJN?=
 =?utf-8?B?b1J1YVU2ZDR2ZkVkWVQveW8xZHE2bE05TVQxakJMYTV3OVpOMUtHdFNDdlh2?=
 =?utf-8?B?Qjk3TElWUks0RXJtVWZ6Y3BnNTZpS0hzejI4Y2JaaXN3MEUydFc3U29TZ1RB?=
 =?utf-8?B?L2NJa082K3ljR0Y4QWFuWVVlQTlkZzlTYTZodlN3MmVzUkpPRXlhYmo2d2I3?=
 =?utf-8?B?cks5QjhwS0U0N2VpTDNBa3drTUpsWHdSY0tMVmVNaGxKblVNamxaUlJkcFRa?=
 =?utf-8?B?MzhPTW5QbVRzeHpxZTdKVzFqaGtYWWsxYlZhYVFYdDg0L2FDRnErSlplcm13?=
 =?utf-8?B?WEowb0ZDNDNNTG5XM2pvU04zcWRtbTQyTzdWVmZNTjIxS2dPYTR3Z1R4cEpt?=
 =?utf-8?Q?s5K1NLoZwomM/509soZw1HUbhwb9YM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVJ6Z0tnMWdXS1FnTGlJeVZ2cGZPL0lWZDBXdTNnS1Q1RFVFT2pnaStDYW5K?=
 =?utf-8?B?MTBTRjFoa2N0TXlkN2F5dGJFZGFCSjFJNnNndlVDSXZ2ZVdBbDlLc01CSVhC?=
 =?utf-8?B?NlBZcUh6VDcyM08rb0tKZm90c1krQU1hUytPOG42T0NYT2FTNEF3b0R5RHhs?=
 =?utf-8?B?UWhHOHJIOStFVi8zRmdZUFhSWCtzWEZxdmJvRm1CWnVrOHhYT2hyWE1meU1l?=
 =?utf-8?B?OXRRQ2l4NXhzTDJOOUR3R0RNc09rTWNaV01MZnRmMnNtZjF5RXd4R0FyelhN?=
 =?utf-8?B?aUhhcTJYZk5ldTBXRGdGamZLOUs0VTl4TDgydlpNTm9TelI3ZUpjaEcwNDJn?=
 =?utf-8?B?eTVZYkpSQ1dZSUVYY2ZkamcrK2xJYUxWT1l1SVN2Sjc5Z3JtWFU4cHpMbjd0?=
 =?utf-8?B?TnZXWVFOQTFEUUZBZDdqSDI1bUljc3RQTFRFWGtDQW5FT3lHQnY5T3YwOG12?=
 =?utf-8?B?d3BuY1U0NUhkYzNrZGRTZS9FZlJXVjdseE1GN3duRDNIRlhQNmJWT0p1YTUy?=
 =?utf-8?B?cEhlclZyZ3RkMnk2RlhlNnE2RHYwM29HUmcwYXErbm8xcHdQWGdMakV4N25O?=
 =?utf-8?B?Z002U0dlQmVlamhwN2hveDQ1amFVR1dxYkZZMHhCSWZGaDlYVGVkdDRmVy9K?=
 =?utf-8?B?YmRIaEdnVG9DbVpXazNibkFTYXRkL3BlUm9VbTJQMzlBdXo4T3ZmTUx3ZEpP?=
 =?utf-8?B?eHl3Uk5SR2ZGWmZ6VlRaeEt0dHJwWDlyNHltNzkvemdVcUcxdXByRVJ3R1dN?=
 =?utf-8?B?Q1RoQnRpK3c5eVFyRDVOY2RycFYrL2puWFBDUnlEdGtNczVESStpQTBuOUto?=
 =?utf-8?B?R0pCQ1UwaWU0bWVkZndsMnNWTlZKRjlQT0R6ZkxzaWpGRGV1Z254MnFDVVBO?=
 =?utf-8?B?U0xhSjdCM2s0TFFrYmFxNkVZaXN4c1hya0tSYlR1STFFU0sxL2lZdWI4ckEr?=
 =?utf-8?B?NGRGdW8weUVlL0xLTXZ0SDk4cUMraFRIdHhSNUZKaDNGTWhLQXNVTi85b0RT?=
 =?utf-8?B?WjZYcGVHdW9DQllyRHlEbksvM1l2U2QyNytoUkZwaEdyODFlWGQ3THp3Mk8x?=
 =?utf-8?B?YzhZSkYrQTZVOTFxNGhCR21YNW1YeGFJaGJuM2ExWTR3VDVkVkZYNU1mTi9G?=
 =?utf-8?B?ZGI3b21HSkxpYW9wM2NCQkZiNmxUOEREZGJUckRTd2NsTkJMNXdxYU42MW5D?=
 =?utf-8?B?cTMrekFHYnp6OGhRSUwyUGNlbkl6bVY2TVl3TjcyaWhXejdVQzBML3pGTGVV?=
 =?utf-8?B?WXlCTnFUU2FLZDFpMDlvV1liZXBja0pwUkJlQjVJbHpUTWNHT3dVL0owQk1B?=
 =?utf-8?B?Y2xHNWNQcDBheG85WkdTd1R1V0ZwR0t3bkJmWjV1emZ2QXIwdjhGQkEyVGVO?=
 =?utf-8?B?UzBPbERRZTJaMndIblJxTkxYZzFqdTRDMHJ3ZXpFWjJiaDdoM0xJRlp6cXBx?=
 =?utf-8?B?YTZXV04reDMrZ0E5RkM5R3I2WlozNDBtSENhb0lIQ29tV1JjeHJhZlp5MFJ1?=
 =?utf-8?B?MCtqakxuTFc4alRabGtCYmdvU21wbWtNU0RtWmd6bzlac3YyTnJmckVtQm93?=
 =?utf-8?B?Ymp0RitjUDg4S1YrNTJiZHRzQjhtaWw1TzRDcklQaWsrOCtSbDBhcmxaOHhz?=
 =?utf-8?B?NTZIQ2EzWmkyKzAzOWJpQUVrelQzSHE5c09QOUNMejdMWnVEbjRvRXlxV0gx?=
 =?utf-8?B?UVl1aTlVUHkzdWxmT2tKV3RxVzBGYnhTUTZEeVNDQmxua3p2M0NDSlNWK2ZL?=
 =?utf-8?B?NFBWM1BObyswZVF6UGl1VmdhRlZMVHhuYmZXWTFJakpFVVNpMDlXVTZYcDBP?=
 =?utf-8?B?WmJka0tQT2FZUGJyM1dRWEZJSnRNdlJGekhQTWJoZ1N2bWNDUHdYUkdJNVk2?=
 =?utf-8?B?VnpzcUE2U3E2RStwYjNGYi9KWm1yWVpYekJKVGdaaysrNlRrZFNobUVvNmdj?=
 =?utf-8?B?RjgxcTJLV3o3RjRKeWpFb2FNK2RtTy9uaisxemdPZkVRWktXbU9YdWdza05M?=
 =?utf-8?B?b2pMbUprb1VXZVZFaVNaandSQXV5a2RkY0ZzNnp3Zk1GWVhRdGdkb3B0bmJS?=
 =?utf-8?B?RVRoeUMvRmxEUUIyN1BaRVc4blNnU3JEell1UnJmdkFkOWlGVXg5ajQxWE1t?=
 =?utf-8?Q?zPhBwFxqrPwj/TYTdtohXqH4K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <213A190BE720954CA99904C46DA35D4E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03805a1c-8831-479f-643c-08ddba3c3c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 14:16:43.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nq84LbGZ0gaJWbR3VIQ+cFelo0UPH/S4s+9k7eVt+N7UFlCe0J4j1QYQY40QW9tX732FW/hqQzb/aq7O+kRezw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756

K0xlb24sIGhlIGNhcmVzIGFib3V0IElQU2VjIGluIG1seDUuDQoNCk9uIFRodSwgMjAyNS0wNy0w
MyBhdCAwMTo1OCArMDIwMCwgRXJ3YW4gRHVmb3VyIHdyb3RlOg0KPiBIaSBMaXUsDQo+IA0KPiA+
IFRoYW5rcyBmb3IgeW91ciBleHBsYW5hdGlvbi4gVW5mb3J0dW5hdGVsee+8jHRoZSBhbGlnbm1l
bnQgc3RpbGwgbm90DQo+ID4gd29ya3MuDQo+ID4gDQo+IA0KPiBXaXRoIHBsZWFzdXJlLiBUaGFu
ayB5b3UgdmVyeSBtdWNoIGZvciBwcm92aWRpbmcgYW4gZXhhbXBsZSB3aXRoIGFuDQo+IGV4cGxh
bmF0aW9uLsKgDQo+IEhvcGVmdWxseSwgdGhlcmUgd2VyZSBubyBtaXN0YWtlcyBhbmQgSSBtYW5h
Z2VkIHRvIGNvcnJlY3QgYWxsIHRoZQ0KPiBlcnJvcnMgaW4gdGhlIG5ldyBwYXRjaC4NCj4gDQo+
IE5ldyBQYXRjaDoNCj4gRnJvbSAzOTYzOWNmODM3MTJiMTMyNzFmYzNkOGJiZTNmNGQ5Y2QwYjM4
ZGI2IE1vbiBTZXAgMTcgMDA6MDA6MDANCj4gMjAwMQ0KPiBGcm9tOiBFcndhbiBEdWZvdXIgPGVy
d2FuLmR1Zm91ckB3aXRoaW5ncy5jb20+DQo+IERhdGU6IFdlZCwgMiBKdWwgMjAyNSAyMjoxMjox
MCArMDAwMA0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0LW5leHRdIHhmcm06IGJvbmRpbmc6IEFkZCB4
ZnJtIHBhY2tldCBvZmZsb2FkIGZvcg0KPiDCoGFjdGl2ZS1iYWNrdXAgbW9kZQ0KPiANCj4gSW1w
bGVtZW50IFhGUk0gcG9saWN5IG9mZmxvYWQgZnVuY3Rpb25zIGZvciBib25kIGRldmljZSBpbiBh
Y3RpdmUtDQo+IGJhY2t1cCBtb2RlLg0KPiDCoC0geGRvX2Rldl9wb2xpY3lfYWRkID0gYm9uZF9p
cHNlY19hZGRfc3ANCj4gwqAtIHhkb19kZXZfcG9saWN5X2RlbGV0ZSA9IGJvbmRfaXBzZWNfZGVs
X3NwDQo+IMKgXyB4ZG9fZGViX3BvbGljeV9mcmVlID0gYm9uZF9pcHNlY19mcmVlX3NwDQpUeXBv
IGhlcmUgXi4gU2hvdWxkIGJlICJkZXYiLCBub3QgImRlYiIuDQoNCj4gDQo+IE1vZGlmaWNhdGlv
biBvZiB0aGUgZnVuY3Rpb24gc2lnbmF0dXJlIGZvciBjb3B5aW5nIG9uIFNBIG1vZGVscy4NCj4g
QWxzbyBhZGQgbmV0ZGV2aWNlIHBvaW50ZXIgdG8gYXZvaWQgdG8gdXNlIHJlYWxfZGV2IHdoaWNo
IGlzIG9ic29sZXRlDQo+IGFuZCBkZWxldGVkIGZvciBwb2xpY3kuDQo+IA0KPiBTdG9yZSB0aGUg
Ym9uZCdzIHhmcm0gcG9saWNpZXMgaW4gdGhlIHN0cnVjdCBib25kX2lwc2VjLg0KPiBBbHNvIHJl
bmFtZSB0aGVzZSBmdW5jdGlvbnM6DQo+IMKgLSBib25kX2lwc2VjX2RlbF9zYV9hbGwgLT4gYm9u
ZF9pcHNlY19kZWxfc2Ffc3BfYWxsDQo+IMKgLSBib25kX2lwc2VjX2FkZF9zYV9hbGwgLT4gYm9u
ZF9pcHNlY19hZGRfc2Ffc3BfYWxsDQo+IE5vdyBib25kX2lwc2VjX3tkZWwsYWRkfV9zYV9zcF9h
bGwgcmVtb3ZlL2FkZCBhbHNvIHRoZSBib25kJ3MNCj4gcG9saWNpZXMgc3RvcmVzIGluIHNhbWUg
c3RydWN0IGFzIFNBLg0KPiANCj4gVGVzdGVkIG9uIE1lbGxhbm94IENvbm5lY3RYLTYgRHggQ3J5
cHRvIEVuYWJsZSBDYXJkcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVyd2FuIER1Zm91ciA8ZXJ3
YW4uZHVmb3VyQHdpdGhpbmdzLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9uZXQvYm9uZGluZy9i
b25kX21haW4uYyAgICAgICAgICAgICAgIHwgMjUxICsrKysrKysrKysrKysrLS0NCj4gLS0NCj4g
wqAuLi4vbWVsbGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL2lwc2VjLmMgICAgICAgfCAgMTAgKy0N
Cj4gwqBpbmNsdWRlL2xpbnV4L25ldGRldmljZS5oICAgICAgICAgICAgICAgICAgICAgfCAgIDYg
Ky0NCj4gwqBpbmNsdWRlL25ldC9ib25kaW5nLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDEgKw0KPiDCoGluY2x1ZGUvbmV0L3hmcm0uaCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgNCArLQ0KPiDCoG5ldC94ZnJtL3hmcm1fZGV2aWNlLmMgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgMiArLQ0KPiDCoDYgZmlsZXMgY2hhbmdlZCwgMjE4IGluc2VydGlvbnMoKyksIDU2IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9t
YWluLmMNCj4gYi9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5jDQo+IGluZGV4IGM0ZDUz
ZThlN2MxNS4uYzk1MDU0NDFjODYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ib25kaW5n
L2JvbmRfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCj4g
QEAgLTUxMiw3ICs1MTIsNyBAQCBzdGF0aWMgaW50IGJvbmRfaXBzZWNfYWRkX3NhKHN0cnVjdCBu
ZXRfZGV2aWNlDQo+ICpib25kX2RldiwNCj4gwqAJcmV0dXJuIGVycjsNCj4gwqB9DQo+IMKgDQo+
IC1zdGF0aWMgdm9pZCBib25kX2lwc2VjX2FkZF9zYV9hbGwoc3RydWN0IGJvbmRpbmcgKmJvbmQp
DQo+ICtzdGF0aWMgdm9pZCBib25kX2lwc2VjX2FkZF9zYV9zcF9hbGwoc3RydWN0IGJvbmRpbmcg
KmJvbmQpDQo+IMKgew0KPiDCoAlzdHJ1Y3QgbmV0X2RldmljZSAqYm9uZF9kZXYgPSBib25kLT5k
ZXY7DQo+IMKgCXN0cnVjdCBuZXRfZGV2aWNlICpyZWFsX2RldjsNCj4gQEAgLTUzNiwyOSArNTM2
LDQ0IEBAIHN0YXRpYyB2b2lkIGJvbmRfaXBzZWNfYWRkX3NhX2FsbChzdHJ1Y3QNCj4gYm9uZGlu
ZyAqYm9uZCkNCj4gwqAJfQ0KPiDCoA0KPiDCoAlsaXN0X2Zvcl9lYWNoX2VudHJ5KGlwc2VjLCAm
Ym9uZC0+aXBzZWNfbGlzdCwgbGlzdCkgew0KPiAtCQkvKiBJZiBuZXcgc3RhdGUgaXMgYWRkZWQg
YmVmb3JlIGlwc2VjX2xvY2sgYWNxdWlyZWQNCj4gKi8NCj4gLQkJaWYgKGlwc2VjLT54cy0+eHNv
LnJlYWxfZGV2ID09IHJlYWxfZGV2KQ0KPiAtCQkJY29udGludWU7DQo+ICsJCWlmIChpcHNlYy0+
eHMpIHsNCj4gKwkJCS8qIElmIG5ldyBzdGF0ZSBpcyBhZGRlZCBiZWZvcmUgaXBzZWNfbG9jaw0K
PiBhY3F1aXJlZCAqLw0KPiArCQkJaWYgKGlwc2VjLT54cy0+eHNvLnJlYWxfZGV2ID09IHJlYWxf
ZGV2KQ0KPiArCQkJCWNvbnRpbnVlOw0KPiDCoA0KPiAtCQlpZiAocmVhbF9kZXYtPnhmcm1kZXZf
b3BzLQ0KPiA+eGRvX2Rldl9zdGF0ZV9hZGQocmVhbF9kZXYsDQo+IC0JCQkJCQkJICAgICBpcHNl
Yy0NCj4gPnhzLCBOVUxMKSkgew0KPiAtCQkJc2xhdmVfd2Fybihib25kX2RldiwgcmVhbF9kZXYs
ICIlczogZmFpbGVkDQo+IHRvIGFkZCBTQVxuIiwgX19mdW5jX18pOw0KPiAtCQkJY29udGludWU7
DQo+IC0JCX0NCj4gKwkJCWlmIChyZWFsX2Rldi0+eGZybWRldl9vcHMtDQo+ID54ZG9fZGV2X3N0
YXRlX2FkZChyZWFsX2RldiwNCj4gKwkJCQkJCQkJICAgIA0KPiBpcHNlYy0+eHMsIE5VTEwpKSB7
DQo+ICsJCQkJc2xhdmVfd2Fybihib25kX2RldiwgcmVhbF9kZXYsICIlczoNCj4gZmFpbGVkIHRv
IGFkZCBTQVxuIiwgX19mdW5jX18pOw0KTGluZXMgc2hvdWxkIGJlIG1heCA4MC1jaGFyYWN0ZXJz
LiBQbGVhc2UgdXNlIGNoZWNrcGF0Y2gucGwgdG8gdmVyaWZ5DQp0aGVzZSB0aGluZ3M6DQpzY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgLWcgLS1tYXgtbGluZS1sZW5ndGggODAgSEVBRC0xDQoNCg0KWy4u
Ll0gSSBkaWRuJ3QgcmV2aWV3IHRoZSBidWxrIG9mIHRoZSBjaGFuZ2VzIGluIGRldGFpbCwgYmVj
YXVzZToNCg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvYm9uZGluZy5oIGIvaW5jbHVkZS9u
ZXQvYm9uZGluZy5oDQo+IGluZGV4IDk1ZjY3YjMwOGMxOS4uNmFjMDc5NjczZjg3IDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL25ldC9ib25kaW5nLmgNCj4gKysrIGIvaW5jbHVkZS9uZXQvYm9uZGlu
Zy5oDQo+IEBAIC0yMDcsNiArMjA3LDcgQEAgc3RydWN0IGJvbmRfdXBfc2xhdmUgew0KPiDCoHN0
cnVjdCBib25kX2lwc2VjIHsNCj4gwqAJc3RydWN0IGxpc3RfaGVhZCBsaXN0Ow0KPiDCoAlzdHJ1
Y3QgeGZybV9zdGF0ZSAqeHM7DQo+ICsJc3RydWN0IHhmcm1fcG9saWN5ICp4cDsNCkluc3RlYWQg
b2YgY2FycnlpbmcgYSBtaXhlZCBsaXN0IG9mIHN0YXRlcyBhbmQgcG9saWNpZXMsIHdoaWNoIGZv
cmNlcw0KZXZlcnkgcGllY2Ugb2YgY29kZSBoYW5kbGluZyB0aGlzIGludG8gYSBtb2RlbCBvZiAi
aWYgKHhzKSB7fSBlbHNlIHt9IiwNCnByZWZlciB0d28gc2VwYXJhdGUgbGlzdHMsIG9uZSBmb3Ig
c3RhdGVzIGFuZCBhbm90aGVyIG9uZSBmb3IgcG9saWNpZXMuDQpUaGVuLCB0byBtYWtlIGl0IGV4
dHJhIGNsZWFyIHRoYXQgeHMgYW5kIHhwIGFyZSBtdXR1YWxseSBleGNsdXNpdmUsIGFuDQp1bm5h
bWVkIHVuaW9uIGJldHdlZW4geHMgYW5kIHhwIGNvdWxkIGJlIHVzZWQuDQoNCkFsc28sIGluIHRo
ZSBmdXR1cmUsIHBsZWFzZSBzZW5kIG5ldyB2ZXJzaW9ucyBvZiB0aGUgcGF0Y2ggYXMgc2VwYXJh
dGUNCmVtYWlscywgd2l0aCBzdWJqZWN0cyBzdWNoIGFzICJbUEFUQ0ggbmV0LW5leHQgdjJdICR0
aXRsZSIsIHRvIGludGVyYWN0DQpiZXR0ZXIgd2l0aCB0aGUga2VybmVsIHBhdGNod29yayBzeXN0
ZW0uIFJpZ2h0IG5vdywgdGhpcyBwYXRjaCBpcyBpbiBhDQp3ZWlyZCBzdGF0ZToNCmh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZXZicGYvcGF0Y2gvMjAyNTA2MjkyMTA2
MjMuNDM0OTctMS1tcmFtb25pdXNAZ21haWwuY29tLw0KDQoNCkNvc21pbi4NCg==

