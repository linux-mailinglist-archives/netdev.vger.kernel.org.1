Return-Path: <netdev+bounces-206526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C02B03575
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 07:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F233B63F3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 05:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129131E9906;
	Mon, 14 Jul 2025 05:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FgFs080a"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010004.outbound.protection.outlook.com [52.103.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C814A8E;
	Mon, 14 Jul 2025 05:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752469657; cv=fail; b=CmYIqRnA8TuWFDVMOYgDBPhqiqXFI+d3BwisCkoPYjA25QArfdxJ2UCKSCNgVEa++2Q83Zi/M1xE593jHNtKLvTsk/8AHDJZhvCTXpluXSwz0UiB/bMj1Pwm4oMjI4KyCdDxEs3vn2OMEYV7Gd3tdf/SabAdQrkNkrENJhg7tak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752469657; c=relaxed/simple;
	bh=aexHtUKYS3t5te8dZ5eEgFDxy5TeK6q+KwXX9N88X9c=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qhiv0EY1bhuPCejR4EHjIwZC4FHKzJirJcl0d+mPQIXbNzG0xVeYwkxfX+lRjKNTplMGHs0NlaOJQC6wNO9KPjCFWFWZZdLprGAUpybzaF7PIDCki6ld6EC1TKayq9Chf7Bi7v+j0+8TSaSaLXtypDUcgisE73OWyMhIyCrfGYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FgFs080a; arc=fail smtp.client-ip=52.103.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe42+HO++xUHsxrtwsZNNbNSn1s6csy+i6zDf0DORr+yc5/VUd6iWhGGMVqjFKwAMVOAIGU1YdaJUtPnDXUKozGU+/j0sssgWzlt7aIJRjnLhcyVktYaVpWtq1GI/m/yvLxRPUZrfQgWiQl2QEwcf1y1vX0RwyJIcx5219Z29Hr9dB84HRvAtEj+gLx58YDUriCBP73CfHPAO2bUlGFE8XZsaSgXcJ22+RjmWGhBpQAmnFaUa93ioWwFXYSdfWpeBWx69fOSTFhuLQA8Aog4vRHa0/I+n3i2uet73iNZrXmBTVrWbJXByNalCYGHencxt0BAu8GV9//DoYmRjfrEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aexHtUKYS3t5te8dZ5eEgFDxy5TeK6q+KwXX9N88X9c=;
 b=valbECMLq47RcZMmqKUfaKZEtSHCdEJIB6mEOLhC/YGdLng/JtniVnXmwiP0hyS7baenINmxMAOU8LSMWPwwGTOsKkluPjAL546ndbs+i9QeowOMA7mouzPlFajp1hOjlab4ZYNlr2EbGUH1cLfKd+2IXEq9Mp0mmMrTYvWrbC2VipoK7WXKJ/92thHqNjRyZjsUyUwrfnk2cR1QDMeVD8m413XeuSYSkX2QevrG0aQp0VE7+ISg8mDT9ZA09TrwyM56gwH89/kgGCMgPP7O2TdbBJrjLXY5d4oIBybZB7Mifkz5kehe/jh22lMrM3VhtNU+X12jIZSSb6bsc0r6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aexHtUKYS3t5te8dZ5eEgFDxy5TeK6q+KwXX9N88X9c=;
 b=FgFs080aC4oaI7HNX58gzrvrE7mYfs6riYQ6kadhK4OjmeSBacy4XAAcLMORWvO09YQ6fyvStBcoQLn3zstvbeaNpxTGvRrHzpjGm0dEY6SGs6zVSP2eSKlbBBSh0QUW8baNTlOlcjdV71GjQmZx9dEad8ihnjdKYpCDzgzgeIJKJz7lJMQCuqC/7ARWRv/njZUHP5/DWOkXFlvKTahxo5RmCCFOUERNy9IrI9PucKUgsMPoQvhmob7qFr88vbq+SNpiVs/IGZE/57EN9upSvPvnJM7/Vdns1eg5yDjce3PzCD02v0m1/u0MFEbfixUQR4Opz4sPbZrKwQGaLEjUCA==
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10) by TY7PR01MB16822.jpnprd01.prod.outlook.com
 (2603:1096:405:32a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 05:07:31 +0000
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::7679:e9eb:aeb2:f12f]) by TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::7679:e9eb:aeb2:f12f%3]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 05:07:31 +0000
Message-ID:
 <TY4PR01MB14432738A4EB6D4474DB85A7A9854A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Date: Mon, 14 Jul 2025 13:07:25 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: net: rfkill-gpio: document
 reset-gpios
To: Johannes Berg <johannes@sipsolutions.net>, Chukun Pan
 <amadeus@jmu.edu.cn>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20240528143009.1033247-1-amadeus@jmu.edu.cn>
 <TY4PR01MB144321BDC50DEF7A2537C24F0984BA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <21d8f6388b98ec0fe8662606a3f1c3181466917d.camel@sipsolutions.net>
Content-Language: en-US
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 xsFNBGK0ObIBEADaNUAWkFrOUODvbPHJ1LsLhn/7yDzaCNWwniDqa4ip1dpBFFazLV3FGBjT
 +9pz25rHIFfsQcNOwJdJqREk9g4LgVfiy0H5hLMg9weF4EwtcbgHbv/q4Ww/W87mQ12nMCvY
 LKOVd/NsMQ3Z7QTO0mhG8VQ1Ntqn6jKQA4o9ERu3F+PFVDJx0HJ92zTBMzMtYsL7k+8ENOF3
 Iq1kmkRqf8FOvMObwwXLrEA/vsQ4bwojSKQIud6/SJv0w2YmqZDIAvDXxK2v22hzJqXaljmO
 BF5fz070O6eoTMhIAJy9ByBipiu3tWLXVtoj6QmFIoblnv0Ou6fJY2YN8Kr21vT1MXxdma1e
 l5WW/qxqrKCSrFzVdtAc7y6QtykC6MwC/P36O876vXfWUxrhHHRlnOxnuM6hz87g1kxu9qdr
 omSrsD0gEmGcUjV7xsNxut1iV+pZDIpveJdd5KJX5QMk3YzQ7ZTyiFD61byJcCZWtpN8pqwB
 +X85sxcr4V76EX85lmuQiwrIcwbvw5YRX1mRj3YZ4tVYCEaT5x+go6+06Zon3PoAjMfS1uo/
 2MxDuvVmdUkTzPvRWERKRATxay28efrE5uNQSaSNBfLKGvvPTlIoeYpRxLk7BN0xi/KZIRpS
 lIf0REc1eg+leq2Hxv7Xk/xGwSi5gGxLa6SzwXV8RRqKnw2u6QARAQABzSFTaGVuZ3l1IFF1
 IDx3aWFnbjIzM0BvdXRsb29rLmNvbT7CwY4EEwEKADgWIQSX5PUVXUNSaGVT2H/jUgzJGSnI
 5wUCYrQ5sgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRDjUgzJGSnI57GwD/9O6kei
 9M3nbb1PsFlDE1J9H27mlnRWzVJ2S3yJ8G1oJo8NSaRO7vcTsYPBYpEL1poDQC5MEGh6FXSi
 OnyyHrg8StmGLksQE9awuTnlnQgvXDQMVtm87r1abBAavP5ru2R9x/Tk63+W/VT2hPekMfHa
 JwFi1KATSI1AhsF3CVoj0yDulz1u0uZlircKdbeEDj+raMO0LA12YxWaWtL/b9XaoAqV9vor
 aKhx+0DsZS5bWoUvs+715BArPBr4hPqKavsBwOWfzWDTKln2qv8d+glWkmk6dgvZFcV/9JEJ
 Q8B7rOUMX614dqgwi1t71TI0Fbaou3nhAnES1i1it/aomDUCLvRwjGU2oarmUISFgvZoGYdB
 9DfVfY3FWKtfDJ9KLUk9k3BFfBZgeAYoLnFZwa3rMyruCojAGTApZtaaLZH/jzQf7FpIGGhD
 YnvGKXS01nLCHuZSOEvURLnWdgYeOtwKW1IIcnWJtB12Ajz2yVu3w4tIchRT3wekMh2c3A3Z
 DeEjszezhFyXgoRpNYDBzNl6vbqhnopixq5Wh/yAj6Ey0YrIUbW9NOhIVCGkP4GyJg756SGz
 yPny0U4lA+EP7PS3O7tE0I3Q5qzDH1AEH2proNlsvjZeG4OZ9XWerI5EoIxrwZcOP9GgprB4
 TrXUR0ScTy1wTKV1Hn+w3VAv6QKtFM7BTQRitDmyARAA0QGaP4NYsHikM9yct02Z/LTMS23F
 j4LK2mKTBoEwtC2qH3HywXpZ8Ii2RG2tIApKrQFs8yGI4pKqXYq+bE1Kf1+U8IxnG8mqUgI8
 aiQQUKyZdG0wQqT1w14aawu7Wr4ZlLsudNRcMnUlmf0r5DucIvVi7z9sC2izaf/aLJrMotIp
 Hz9zu+UJa8Gi3FbFewnpfrnlqF9KRGoQjq6FKcryGb1DbbC6K8OJyMBNMyhFp6qM/pM4L0tP
 VCa2KnLQf5Q19eZ3JLMprIbqKLpkh2z0VhDU/jNheC5CbOQuOuwAlYwhagPSYDV3cVAa4Ltw
 1MkTxVtyyanAxi+za6yKSKTSGGzdCCxiPsvR9if8a7tKhVykk4q2DDi0dSC6luYDXD2+hIof
 YGk6jvTLqVDd6ioFGBE0CgrAZEoT0mK6JXF3lHjnzuyWyCfuu7fzg6oDTgx3jhMQJ2P45zwJ
 7WyIjw1vZ3JeAb+5+D+N+vPblNrF4zRQzRoxpXRdbGbzsBd5BDJ+wyUVG+K5JNJ34AZIfFoD
 IbtRm3xt2tFrl1TxsqkDbACEWeI9H36VhkI3Cm/hbfp2w2zMK3vQGrhNuHybIS/8tJzdP3Ci
 zcOmgc61pDi/B6O2IXpkQpgz+Cv/ZiecDm1terRLkAeX84u8VcI4wdCkN/Od8ZMJOZ2Ff+DB
 bUslCmkAEQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1JoZVPYf+NSDMkZKcjnBQJitDmyAhsMAAoJ
 EONSDMkZKcjnnIcP/1Px3fsgNqOEwVNH7hm0S2+x/N/t3kz50zpKhczHZ8GWbN3PPt4wkQkd
 bF+c7V4uXToN4a17bxGdUnA9qljxt8l3aEqd4jBqLn2OJriu21FSnrZOpxb1EwWwvnVUwrLx
 CuV0CFQJdBlYp2ds64aV8PcBOhQ62y1OAvYpAX1cx5UMcHsNVeqrWU0mDAOgvqB86JFduq+G
 mvbJwmh3dA8GnI2xquWaHIdkk06T55xjfFdabwEyuRmtKtqxTP/u6BzowkV2A/GLxWf1inH5
 M81QgGRI2sao6To7sUt45FS+y2zhwh62excOcSxcYqKzs/OiYEJjWMv9vYRwaqJGEVhbfGFO
 jeBOYr+ZCCeARh+z4ilo1C2wupQT8VPsFiY9DRYgkAPKlbn9OqJvoD7VhvyelJagSNuRayrr
 mnEaZMsoRdS22fneCVWM0xlGSgPCVD0n9+6unTnVbmF/BZsEg5QufQKqlFSomu1i23lRDPK/
 1aPc2IoxcQPh2fomy8spA5ROzOjLpgqL8ksEtQ75cBoF1K5mcC2Xo1GyDmdQvbIZe+8qwvQ3
 z9EDivvFtEByuZEeC5ixn4n/c9UKwlk+lQeQeN+Bk7l8G9phd4dWxnmWXQ/ONR/aLzG+Fguu
 GNZCPpu5dVQH44AXoFjoi9YVscUnWnv8sErY943hM8MUsMQ5D0P2
In-Reply-To: <21d8f6388b98ec0fe8662606a3f1c3181466917d.camel@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------OdlwKkWZSf4DYf5r0zngv20g"
X-ClientProxiedBy: SG2PR03CA0121.apcprd03.prod.outlook.com
 (2603:1096:4:91::25) To TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10)
X-Microsoft-Original-Message-ID:
 <5994be12-024a-4b6e-9b79-b99a5b5ed626@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14432:EE_|TY7PR01MB16822:EE_
X-MS-Office365-Filtering-Correlation-Id: 010b64f3-1692-43f9-6676-08ddc29455ec
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|21061999006|461199028|5072599009|6092099016|15080799012|440099028|51005399003|40105399003|3412199025|26104999006|26115399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2l1VkdDSjQ2RE5TTnl1WTh0TDlCQURGQmNUWFB6bWpSSTFPUDdxZ2srbVdE?=
 =?utf-8?B?UFZYQ09lTjdmeFltQmhSNUQwRHUyeFJFTU9aUWptc3c5L3ozSCs5d2VVN3hV?=
 =?utf-8?B?WWlmVC9NUXZQRkxEek94VHU2VXgreHM4SGR1MXdtRk9BaTNGb1lTTlo5NWtR?=
 =?utf-8?B?VkNZT3FOdWdteWM1R3pwK2M2S1M3OUVpcWhNN09teW9ocm5JY0k2RExldG5y?=
 =?utf-8?B?Zk16VDF4a0luTzRlY3J4RUJnMlZpY0tYQVZWWE1OakwwRks4Y3FWbjltbWx2?=
 =?utf-8?B?U0t0OGNRREV3MEkyS2dDNmtyWGFwQzl3QS9FT25ibFlKN29PMzZwNTBzK0s0?=
 =?utf-8?B?RGVkd1k3dWhZUE42d1J3YXZDR1k4RTRhU2tISVp1R2NSTHJWYWtQNG1aRnBD?=
 =?utf-8?B?Q2hWNkRsdkR4eG9uUWVzS3BmSExzUkpSWTRkOXE1Nkoyc0xvUE16SXRJWURt?=
 =?utf-8?B?aitnenkwSENTeC9jZjdsak1vODJYVHIvTGF6TU5XNWNYNnBaM3BHQVJpTlIw?=
 =?utf-8?B?bTg4TFMxWjBYb0xaQnMrT2dOTm5wTFh1U201b3JCRlZ2L1U3dllPbnVnSmlT?=
 =?utf-8?B?d25ZcnhhYkdyTm80b3lXd1pmRVExUG94c3A1UDc3aVRjNG8zWEdmNUpRVVVI?=
 =?utf-8?B?NXJQZGdBL0I2LzNxdW1tVS9OY2F0RU1BZmorSDAvQkg5N0lVa3NXem5DQWp6?=
 =?utf-8?B?dUhWNStXeGRzc0ZwUmdjeUNra3AwU0JTNDMyY2s2aTBFb3pPNEx6QjlrQi9v?=
 =?utf-8?B?ekpuRGhPc0U5SWJmcUVxUHlPTi9JWXN2UkNXdjhmTGZDYU9xekRVdWhaM2tp?=
 =?utf-8?B?VkFSUU1Nd2Zya1ZwU0FYOGFBNG1mRmNkSENSSzBPQWQ0V3FnRnpXNHFySmcx?=
 =?utf-8?B?Z1oxSVdTR0dzWkJLZG81em4rT3pVTlhScW1HZWdtQ0xPMWYrbGhiR01EemRX?=
 =?utf-8?B?emQ4MFo2T2hLY2tWVUlEWVpkQ2VyTFRNS1ZTMGVXSUw2bUUwcnNtSFhLNGxE?=
 =?utf-8?B?a016N205WlV2Q1RINGYyQ1Roa1I3eGdQMTR2SlZaTjFzMVY2V3AxazNvYWxQ?=
 =?utf-8?B?KzJZWkQzV3hRWTNmVU5tQWJ1NWl5azNwTi95MnU2S21NcUdXVmxvM1IxUEJ1?=
 =?utf-8?B?Q2NtNEk4SFZZajNUSFd4WGhFNTJWTmY2ZDdpQWVkMVpqWFIwbXF0WEVJeURt?=
 =?utf-8?B?Zm8rSnVrVDZtSEJYNUhrRmhXanlhcHZXajZ3cFpCeVdaN0R5ZDk2aXRiMDZZ?=
 =?utf-8?B?WERXUlh1N3AyQkNPVzkrR2JUa1g4WnNIK2wyM2p4dVFHTWxrOTQzSk1pOXRk?=
 =?utf-8?B?ajNyV1I0dUtjTWZLTXZ2U0dsc2JpcHdvNk9SOU9IOEY4eDlwcWVJT3pTbkNr?=
 =?utf-8?B?STY5TUVXNW9MMHBHU041ek4rWk5tRFlSTm1qRmoxRlVwZDBxNlZRUVZPRE9W?=
 =?utf-8?B?VVBkdE1QNDN4cGpxRlcvNjJmeEJBeHVRRVhwZlp6b1NVWjlLTWVJc1BsZWZp?=
 =?utf-8?B?RENpODk4cHI1c2N6VHFtekR6UWdNN2VqUHFJTjRYQnVpaVlLNU1FZmVWMTho?=
 =?utf-8?B?VS9QZ0tIa05KK2dYaUpvZExxT0k5eW5ab1pITm9BMlFFbUMwcXJGdG1ZUXdJ?=
 =?utf-8?B?cHM5cmJNSUNnd1ViMktHVUFOQnpGalVtUmVRSkl2OU1rSEswSzMrRGRXSlNj?=
 =?utf-8?Q?CCHsuWTyu2oyKNxVR2yY?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3k3cnRZUjIwamhGYXg0dmkrKzJTK3NjakZIL3hYWU1EWndnNmpiM0Z5cktP?=
 =?utf-8?B?L296K3NtWHZrY3pNNHBKSHJzb1lyL0R2QU5VL2VrSVhMeXFwdUpPTklTRXpR?=
 =?utf-8?B?UFp2MjRaN2w0SDVaL1k2MjkrS0d4RTBqRnM5L3FRQWFxbmRrZzRtYVFWLzRG?=
 =?utf-8?B?Yy9Tc2dwcnJuMS96R1VETmF1YWJFbTQzTHF6Z0IrcitIRTU4SVNlRkxldWtO?=
 =?utf-8?B?YmFwYjBmNFExVUJUQ3FJcGZHdFpBVkFvNDg4RWZhdTBvbHEvcVk1UGdRZW9w?=
 =?utf-8?B?SzBpZDNaSkprQlNpTVRYZTlueXVWVmtlTDc5aDJLa09pUW1LSkk5L2toY2lJ?=
 =?utf-8?B?elJnU0d4MHcvSjdtd3JtNzdLWVk5bGdvRkcxUXJQQW9nRndCN1FnT2ZCYXpW?=
 =?utf-8?B?UEIzZjFWVnZmL2VWYTlkTExxYVZHQ2F3ZmF2czFnU1lubEN4UHg5Sytxa21j?=
 =?utf-8?B?bzFsSmNYUzMzZ291THgwQmg5bW9aek5nb1FnT2cxRW92Tnd6Q3lwSTBhSGZu?=
 =?utf-8?B?T0dCak14ZDdXQW5PSUVhS2libjgvK2F2SDM1Vkh6ZTBLQmQrRnhRYkpKa0FX?=
 =?utf-8?B?eUxmYjVWai9WcmN3ejdGT3pJVXAya0EyTFZmUWE2aWRNZXdqcUVuT2JtSXp0?=
 =?utf-8?B?Zkh6NDVPd1ZqOGdWTkdiUmduQTlQWksvd2dkbzV5UjNzWERMVjAyYmhWdnhn?=
 =?utf-8?B?Q3dySjVWRlRrczlYS0REWkZEOXc5cmtwRHdGckx6Y0lZWnlSNktkYVVweFNB?=
 =?utf-8?B?c0RGbnI0d28zd3Z6U094N0dVUGt5bGcxaTA4dlRRMzY5UGFBa1prazF5V2ZM?=
 =?utf-8?B?cFcxTkx2QmNodXZ0bDZtL0ZNRk1DdDlGcjYvRXdRWGdJZVNoK2cyek9sb3cz?=
 =?utf-8?B?aFV3aHRrZEo5TUx4NDZDSlZYTVdIQ3dXcEcxMWIvbm8ybE5MNTZkMkhxSFZm?=
 =?utf-8?B?SlBycUJJZWp6bzJVczJsV0xaMFFaQXlqKzFCV0dDemNpVmVuRXJZeVg1eHNV?=
 =?utf-8?B?UWJVMDZ0eVg3eTZ3QU4ra2lzV29iN3pTVVNlb2dZM3pCNnptM3dleDZrNkUw?=
 =?utf-8?B?NHl2R0JQS0M5R2M1K1VkY1FoQWZycXg0SGFaUHdyQnoyV3l3MWhVVFNwYjdN?=
 =?utf-8?B?cklMYXY5MjRJZlVxSFExbXZMVVBJeHVwbmlFVExRSWtxSjgzZXA5QUZITXFu?=
 =?utf-8?B?aUozK2F6OEs2Y21PWncvRUl5dWd5L2Y3aUV6UUFHNlV4c2Z0K2ZXQTd1WGQy?=
 =?utf-8?B?RWpwVFBhOHdybVZ4eHlWK3ZFRjBaakRMYUpCVkRQT0VWK1R5dE00Z2tUOVNI?=
 =?utf-8?B?TDh0M2Z6UnVNMEtIZXVvUkczRnM2N1hFZkhyTjM0dm9ITFpxSGExc0NadVdr?=
 =?utf-8?B?dmtUVWthVFNxSGdMa3hLN05WakJqZnNydVRUR1hpSnF4eEpMSDZXaGNIZS9i?=
 =?utf-8?B?c3hQT25tRXZGTnJIbUZuV0c2M3g0SUFiUXludnFTbTR1TDBHM2RKS0NWbnBp?=
 =?utf-8?B?QTJscllyRVhyMC9zSEczdUdzeDFYTGtTWjJaeXI5cUJTZ2JQTHBkTlgyQzdu?=
 =?utf-8?B?akJlWDhUVGo2REFYeHh4SGJObCs1bHRJNnpxcGZ0dS9RZUxjTXc1YXB2ajlV?=
 =?utf-8?B?NS9xdDdmOW9XSWtGV0t4dldWZW5hTnpLT29HL0g5WFAya1ZFSFZIR01OSE9O?=
 =?utf-8?B?NEMwYjFxS3JWYXYzUHdTaGg5Y1lSTzhmcDdqbTV6d3NMSFBaNUplM1lYM29t?=
 =?utf-8?Q?PshG3ZCN6iK0SAzh/s=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010b64f3-1692-43f9-6676-08ddc29455ec
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14432.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 05:07:31.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16822

--------------OdlwKkWZSf4DYf5r0zngv20g
Content-Type: multipart/mixed; boundary="------------AXb9Fgh7RwK7UUNyBFwHSMDV";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Johannes Berg <johannes@sipsolutions.net>, Chukun Pan
 <amadeus@jmu.edu.cn>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: wiagn233@outlook.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <5994be12-024a-4b6e-9b79-b99a5b5ed626@outlook.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: net: rfkill-gpio: document
 reset-gpios
References: <20240528143009.1033247-1-amadeus@jmu.edu.cn>
 <TY4PR01MB144321BDC50DEF7A2537C24F0984BA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <21d8f6388b98ec0fe8662606a3f1c3181466917d.camel@sipsolutions.net>
In-Reply-To: <21d8f6388b98ec0fe8662606a3f1c3181466917d.camel@sipsolutions.net>

--------------AXb9Fgh7RwK7UUNyBFwHSMDV
Content-Type: multipart/mixed; boundary="------------3lUtE4yf3XRX44p01QLc9Pp3"

--------------3lUtE4yf3XRX44p01QLc9Pp3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSm9oYW5uZXMsDQoNClNpbmNlIHRoaXMgcGF0Y2ggaXMgYWxyZWFkeSByZXZpZXdlZCwg
bWF5YmUgeW91IGNvdWxkIGp1c3QgbWVyZ2UgdGhlIHYzIA0KaWYgbm9ib2R5IHJlcGxpZXM/
DQoNCkJlc3QgcmVnYXJkcywNClNoZW5neXUNCg0K5ZyoIDIwMjUvNy8xMSAxNToxNCwgSm9o
YW5uZXMgQmVyZyDlhpnpgZM6DQo+IE9uIEZyaSwgMjAyNS0wNy0xMSBhdCAxMjozNyArMDgw
MCwgU2hlbmd5dSBRdSB3cm90ZToNCj4+IEhlbGxvLA0KPj4NCj4+IFdoYXQgaXMgYmxvY2tp
bmcgdGhpcyBwYXRjaCB0byBnZXQgbWVyZ2VkPyBJJ20gc2VlaW5nIG1vcmUgNUcgbW9kdWxl
cw0KPj4gbmVlZCB0aGlzIHRvIHdvcmsgY29ycmVjdGx5LCBmb3IgZXhhbXBsZSwgRk0zNTAu
DQo+Pg0KPiANCj4gSSBndWVzcyBJIGhhdmUgbm8gaWRlYSwgZmVsbCB0aHJvdWdoIHRoZSBj
cmFja3MgYW5kIHNvIGZhciBub2JvZHkgY2FyZWQNCj4gZW5vdWdoPw0KPiANCj4gRFQgZm9s
a3MsIHdoYXQgdHJlZSBzaG91bGQgdGhpcyBraW5kIG9mIHBhdGNoIGdvIHRocm91Z2g/IEkg
Z3Vlc3MgSSBjYW4NCj4gdGFrZSBpdCB0aHJvdWdoIHdpcmVsZXNzLW5leHQgd2l0aCBvdGhl
ciByZmtpbGwgY2hhbmdlcz8gT3Igc2hvdWxkIGl0IGdvDQo+IHRocm91Z2ggc29tZSBEVCB0
cmVlPw0KPiANCj4gam9oYW5uZXMNCj4gDQoNCg==
--------------3lUtE4yf3XRX44p01QLc9Pp3
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBGK0ObIBEADaNUAWkFrOUODvbPHJ1LsLhn/7yDzaCNWwniDqa4ip1dpBFFaz
LV3FGBjT+9pz25rHIFfsQcNOwJdJqREk9g4LgVfiy0H5hLMg9weF4EwtcbgHbv/q
4Ww/W87mQ12nMCvYLKOVd/NsMQ3Z7QTO0mhG8VQ1Ntqn6jKQA4o9ERu3F+PFVDJx
0HJ92zTBMzMtYsL7k+8ENOF3Iq1kmkRqf8FOvMObwwXLrEA/vsQ4bwojSKQIud6/
SJv0w2YmqZDIAvDXxK2v22hzJqXaljmOBF5fz070O6eoTMhIAJy9ByBipiu3tWLX
Vtoj6QmFIoblnv0Ou6fJY2YN8Kr21vT1MXxdma1el5WW/qxqrKCSrFzVdtAc7y6Q
tykC6MwC/P36O876vXfWUxrhHHRlnOxnuM6hz87g1kxu9qdromSrsD0gEmGcUjV7
xsNxut1iV+pZDIpveJdd5KJX5QMk3YzQ7ZTyiFD61byJcCZWtpN8pqwB+X85sxcr
4V76EX85lmuQiwrIcwbvw5YRX1mRj3YZ4tVYCEaT5x+go6+06Zon3PoAjMfS1uo/
2MxDuvVmdUkTzPvRWERKRATxay28efrE5uNQSaSNBfLKGvvPTlIoeYpRxLk7BN0x
i/KZIRpSlIf0REc1eg+leq2Hxv7Xk/xGwSi5gGxLa6SzwXV8RRqKnw2u6QARAQAB
zSFTaGVuZ3l1IFF1IDx3aWFnbjIzM0BvdXRsb29rLmNvbT7CwY4EEwEKADgWIQSX
5PUVXUNSaGVT2H/jUgzJGSnI5wUCYrQ5sgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
AQIXgAAKCRDjUgzJGSnI57GwD/9O6kei9M3nbb1PsFlDE1J9H27mlnRWzVJ2S3yJ
8G1oJo8NSaRO7vcTsYPBYpEL1poDQC5MEGh6FXSiOnyyHrg8StmGLksQE9awuTnl
nQgvXDQMVtm87r1abBAavP5ru2R9x/Tk63+W/VT2hPekMfHaJwFi1KATSI1AhsF3
CVoj0yDulz1u0uZlircKdbeEDj+raMO0LA12YxWaWtL/b9XaoAqV9voraKhx+0Ds
ZS5bWoUvs+715BArPBr4hPqKavsBwOWfzWDTKln2qv8d+glWkmk6dgvZFcV/9JEJ
Q8B7rOUMX614dqgwi1t71TI0Fbaou3nhAnES1i1it/aomDUCLvRwjGU2oarmUISF
gvZoGYdB9DfVfY3FWKtfDJ9KLUk9k3BFfBZgeAYoLnFZwa3rMyruCojAGTApZtaa
LZH/jzQf7FpIGGhDYnvGKXS01nLCHuZSOEvURLnWdgYeOtwKW1IIcnWJtB12Ajz2
yVu3w4tIchRT3wekMh2c3A3ZDeEjszezhFyXgoRpNYDBzNl6vbqhnopixq5Wh/yA
j6Ey0YrIUbW9NOhIVCGkP4GyJg756SGzyPny0U4lA+EP7PS3O7tE0I3Q5qzDH1AE
H2proNlsvjZeG4OZ9XWerI5EoIxrwZcOP9GgprB4TrXUR0ScTy1wTKV1Hn+w3VAv
6QKtFM7BTQRitDnpARAAsPFINiaOAxfatzRTme/1cG+kpSqY9znQYxkz8EWY1eAO
Qs2xKl65JUyhTRPQkW8cqDVzdVF16wW+1RyoMrtK5xj6jm9K7VAAc/sDL2LkoSjj
3FpoOp/RMfVBiLGATCdNSEDFPO6nGVJn8aOXmH54sgZzhgfqW1X9Y4ToWViF5VXZ
sWGzHPsXoVvlRyPfAYi9eL11hZqQVhXPOQTuAG4ow8z7ZGYT7wfZo9oXvs/11DQ/
pxt7aO8QGCNCsWnMOecPBy9+Tbr/huxLVFl+boaTv3QwdATHFtObOi+q3m6RAADB
VQSiACVCsqb02HADfhO8n0AM75fJjbXFTLBR06+eME0h0dF8d9hu9gHe3ZHqsvB4
X5E9UP+Vf8c1M9aoJrULVoAOo50gmCEhjlzI5xYczBtw1bhOXCP0Wj5cmx3wbKq7
UKMXjDKF9ag907d078BaIzhMOChN6s9c03KM6ix0nLpBGzYZXC0VL+yqKkiHJzee
mBJ4YzLvf8rCGxbg8kKPQ2ongQVpcE4rr6uS/kCoB7BpVSaHraAHA6IwpGccOlU+
0v9rBghE1QzIlhkzcxwzxlb7rTZsedxSPQLVdPaRG9rkz3Qw3mWYYs2w7dJahgIm
p1z/v9qdTWYdHzKRyafluFlz0PoUcVuGz6PwFzDxGV5Gqqg6zHLEx68KxKwoyecA
EQEAAcLDrAQYAQoAIBYhBJfk9RVdQ1JoZVPYf+NSDMkZKcjnBQJitDnpAhsCAkAJ
EONSDMkZKcjnwXQgBBkBCgAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmK0OekA
CgkQX75KBAfJsRlTUBAAjQoMom0dfgWNNIXpvQgiGRh6slnyZ/QH4j2CGNTgfNC1
CV4SVC7U/A3lFDoDGbcsISb7uKyLnjrn1c3rguT9JXzuIbQZotgE0LvG09odGMXD
S92CmBaKnvhYlSO0cUdRtgvnw3nMgl1Kz7a8vvjYl3S1XhXQ8bpgrh2Sn36oqhaS
//Mgy52qHN2lRz09lr9Ig1NSXkjguSyj1hTc5wOWV+rsX4is0nOBNaov76/tbcF6
sIsHyHPSGzZ4jefZs318ineuBnrtVE9sH9XWc1QHLF1gzOKKwssddXlYe2Sj5plX
vZqcHHYfrOLe+v1gxW21HumUosTsCDUVJ9egr1DQcaQiiOUV5qQi4/GfqFAacken
NbHcNLpOxaOE3IwbL0F7aZHsKsl18suDXAqb3ljyAm4fEZr2ceEnE7n1x9BZizJL
YbkYB/k6gxxxbyjcoR6F1niEE+6Hs9vKGNmvNQikPpv05IDXgOr6pgWWCdZCiup3
N72xS3OCZNkkVQjaSL6/hN/IcR8+Xtp+nbYH4Agm9hBAPN045l/P9nVmSQOJ3TC+
wGgo8N16qzW061YD/faB/g/u7RcSfi5SwISIyrNXnyhBZTrFx+0KsjtdwVGJXYRS
/tio6zRaBl/bO3+e8SGqsHU3f6JH+HgTWJINfj3I/wDIBAL0XGoDAE8tqQBpsTBd
mA//WestyKDwfpZEqz9wBNX4QUS/zh+1GiweKcgqXhi4RuV/MXTPXcET1/pGnX5S
h9hdBj6lIseTtbSVDBHQm/1qUPYFAG+grdWZ7YrPIXfKTUCBlE/pKcJ6Yi1RIW3o
OQ1+OfYaPDfqOnq2Ed+HFM+KNFhWtU1TRUBikU1n88lMcRlFHFtkAuZgsDwj2b+v
c71uXNA3YkcFHGBhq7rJQu3B1l2zvM0P0ds0HAo58iJ4qqMkA07EJStaATOokDAC
4Xo+n7DHu81pQPP9BTY9u1G+m4mlpivWqIVk5Gbb+2w9yCmkEWqv5QYPtjpgxq0h
zURLeU+BDvOUKjCS5480NvxWwOthPqYls0WgoSVVMtDpeklSRxmrHJ6k+H1gV9Ja
WcfQO/l0IQrQm1+xE8xz87oHl18gIVbpXmlfss6EnPfmhdst/FqxXM0sxV+QD3oF
mf/CcRG4SSqjsKkpQviDMG5TwN52mWwoirk2MYlNGLNwknWXhRb0l7r4SyZNfOWp
0EI0EvO+CfKZL03drnmMaeOoXXtKwmWgCpYTa6dxtTTVKbeUKYy2p+jYZqUONl3y
CwuL9UIOwE+LxhtED4ZjIWxoD5/uOBGLofP/eNZpMmmC9H18rupdh6ChGYi3q6/L
6oHNPDbwJUFv9UJys+MwOV1Lzq8ULCxRfYntnhug1iZHYdTOwU0EYrQ6CAEQALWU
YW4bgH3p7jUtpD8rUoaHTJ+G3z9ZUjYvz+r0llcpurPm0DyG7kWHzbzGTCkdYTxf
dxEaUggMfWxLC7Vyd8PadoBTlJJ++7MP9eL9IzyaJEG034N3TtDym/v/PataFbjs
hi4YF1tT/2RnSK3neeotr7FX8+zZrz5EgE69Wz06HGIKanRn9fhUKfKQzetGl0NE
Se62aTkxsf+Qb4Hq2i1wm6ct4m2iRfdhw1OUDNQHgbOy6V8mxXPg2fsJLVC3inpg
BdhA5xWrkAnxouujB1xs9g4Mu+5WnUqc/jr6S0zKbm81Xohl8JDbGvxbOpb9fmq2
NnVLR4771NJC3/2qzU/pjgjA/HNmjmqYFEIToTNlNjsEYGydcujlSsjdFDe+pA6S
kqUrEHpaVf031JOCzEzgfqyH3gMBtDXyrGAs8Vdnb1/ROMIALqbK8nh2IYnRblME
J3D6nJDlYMVwsDgOhhrTFREBUdLJ7lZ+LpS4ACctKyV22Eo/L2nOFeu1+pdgivMb
4L2VIJtgvzKFfV3I6MUMzSDMkhQzQZjPq7Uzlu0cZ9ZpSO7HuUzigJZ6vnE7iwLv
i/yyjUUqHnSmLFFE4xxpnsMlDZXBxx0HIzEt48M2dmvfmD+SqSiQrE/3qgWaIjwC
+lfYggYjPtNgSntkfOsCvDqnob8b0dpqRcFT5Px/ABEBAAHCwXYEGAEKACAWIQSX
5PUVXUNSaGVT2H/jUgzJGSnI5wUCYrQ6CAIbIAAKCRDjUgzJGSnI5/3nEACdQ2vO
zmUJ2LoFq7z0Dn7HVfUX8slzja7LBl3vCw/2Oq5s2VbvgZuPRfUxdEMXPlTqyab/
VVbHzqhSYtMMpDsMhEnVZ4DawFvWVs3yL5BA0qU5Wsb82zRGO6Qab29cRaEjK6Lt
a6N9vfVyn7ZQNvUWB4sB9RyAtSTyQVrEuLZWoWfQLRqOaecFaBCsTeg/0q4ywnBY
kCZR9ciEnLGVRZt6oE7qNoNLsyTNKNWNge0/Jiv67Jt4VByZWwqz5f65GBAJYUlC
qWsCoZXUYTnqlFAnI533ZhYEx/x7UzCJREAPgpP0/DOfmaf54QqTwsdKU7g3VE0a
N7Vhy/ja4sCvgLmTUftKXr7k2Dsg+gldB54P95VPOot4DdehlcTVkI1HUNabPSJ2
kIS8bIHr0JrIMzqqOhlIh0CHcbwLXBu6V7+x0YcbGQPuvIfJYsYjHhNVt9Dx9Z8Z
+YDfxJJXY3ORfcQbtf700l/XRs3q9c2WRZ+CfJWw+kfpHjmq6BfEPUtXGJ0G4d7w
ErIZszYIviEpi7UdWuM48WNgJSjb/o5HaSLY6LeXXsMVXlOceYtbF1idw7eMTchU
rNj2bNSLj0qJZstNIVWXRYhpq/ELjJjqOmGoEnVb668sPNdpObwLJA+QDAvRBq7t
WPHvRXXbC5TEqFVd89bPHQNQyvecpEnSBbVWU87BTQRitDmyARAA0QGaP4NYsHik
M9yct02Z/LTMS23Fj4LK2mKTBoEwtC2qH3HywXpZ8Ii2RG2tIApKrQFs8yGI4pKq
XYq+bE1Kf1+U8IxnG8mqUgI8aiQQUKyZdG0wQqT1w14aawu7Wr4ZlLsudNRcMnUl
mf0r5DucIvVi7z9sC2izaf/aLJrMotIpHz9zu+UJa8Gi3FbFewnpfrnlqF9KRGoQ
jq6FKcryGb1DbbC6K8OJyMBNMyhFp6qM/pM4L0tPVCa2KnLQf5Q19eZ3JLMprIbq
KLpkh2z0VhDU/jNheC5CbOQuOuwAlYwhagPSYDV3cVAa4Ltw1MkTxVtyyanAxi+z
a6yKSKTSGGzdCCxiPsvR9if8a7tKhVykk4q2DDi0dSC6luYDXD2+hIofYGk6jvTL
qVDd6ioFGBE0CgrAZEoT0mK6JXF3lHjnzuyWyCfuu7fzg6oDTgx3jhMQJ2P45zwJ
7WyIjw1vZ3JeAb+5+D+N+vPblNrF4zRQzRoxpXRdbGbzsBd5BDJ+wyUVG+K5JNJ3
4AZIfFoDIbtRm3xt2tFrl1TxsqkDbACEWeI9H36VhkI3Cm/hbfp2w2zMK3vQGrhN
uHybIS/8tJzdP3CizcOmgc61pDi/B6O2IXpkQpgz+Cv/ZiecDm1terRLkAeX84u8
VcI4wdCkN/Od8ZMJOZ2Ff+DBbUslCmkAEQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1Jo
ZVPYf+NSDMkZKcjnBQJitDmyAhsMAAoJEONSDMkZKcjnnIcP/1Px3fsgNqOEwVNH
7hm0S2+x/N/t3kz50zpKhczHZ8GWbN3PPt4wkQkdbF+c7V4uXToN4a17bxGdUnA9
qljxt8l3aEqd4jBqLn2OJriu21FSnrZOpxb1EwWwvnVUwrLxCuV0CFQJdBlYp2ds
64aV8PcBOhQ62y1OAvYpAX1cx5UMcHsNVeqrWU0mDAOgvqB86JFduq+GmvbJwmh3
dA8GnI2xquWaHIdkk06T55xjfFdabwEyuRmtKtqxTP/u6BzowkV2A/GLxWf1inH5
M81QgGRI2sao6To7sUt45FS+y2zhwh62excOcSxcYqKzs/OiYEJjWMv9vYRwaqJG
EVhbfGFOjeBOYr+ZCCeARh+z4ilo1C2wupQT8VPsFiY9DRYgkAPKlbn9OqJvoD7V
hvyelJagSNuRayrrmnEaZMsoRdS22fneCVWM0xlGSgPCVD0n9+6unTnVbmF/BZsE
g5QufQKqlFSomu1i23lRDPK/1aPc2IoxcQPh2fomy8spA5ROzOjLpgqL8ksEtQ75
cBoF1K5mcC2Xo1GyDmdQvbIZe+8qwvQ3z9EDivvFtEByuZEeC5ixn4n/c9UKwlk+
lQeQeN+Bk7l8G9phd4dWxnmWXQ/ONR/aLzG+FguuGNZCPpu5dVQH44AXoFjoi9YV
scUnWnv8sErY943hM8MUsMQ5D0P2
=3DUrys
-----END PGP PUBLIC KEY BLOCK-----

--------------3lUtE4yf3XRX44p01QLc9Pp3--

--------------AXb9Fgh7RwK7UUNyBFwHSMDV--

--------------OdlwKkWZSf4DYf5r0zngv20g
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmh0kI0ACgkQX75KBAfJ
sRl7jg//bXhoweKWXhEAtsfnTaJLrx5ZwkqDulNWTbVlgUHCV+OFZykADUyURIMW
1JnoP+ZcmohhhUkw7KfCwSYP0SCDpLl+WNY2YcVW/55inO+Nb23sXt/K9k5lDrFT
tMMSuOvDPBMSmBCmjWM88duFv74yVnM4BNJlbbrirF4MUf894hmBDp3hbXmcKLMy
07JYxuRdvb3X1AMJwYq9NjfwvrrlbUFFS2N8LbV5vU/kFcNW4NiVYGkWGsKLU+hX
x23SodRwpLqIID0q60QZqZRbkEOGsEN7Rflg+mXUhOHNd3gYLuyABNUJN7WbLQJG
V0JVC3mDetNdYs876xQuiYm6o7G1ajVPiAaCSV70XtmPTfP+2Q4MJTdlfl6jDEEg
op9W/4UTlbDZ20RxHqD+ykh5v1epKqZjT7jBLrWv9uvDxcMrvcUGsXIfelA6sPwd
M4/aP6nzyq9xl06tpHTdC73snpMKmoEVeHn6Zw9VehkSar5RcDSEyVThn8/2FoK/
pO709U6WJp4rUfx3e6hiL8bNaX3jEKuRJVOgRJSLImmXBmoqQ2Kb6ZaHz+nuHSIh
J/KOquvB7/SZ2hC+ndN4NFzvMLVTUJFZ8zpWrUX7yOOgPopCHMYHJDo6CPv3V5KF
EAKsY3cRphAhFPmrtrMt+jjxiZvdX0Upzxvm4Mc7ojvu67OFFag=
=UDL/
-----END PGP SIGNATURE-----

--------------OdlwKkWZSf4DYf5r0zngv20g--

