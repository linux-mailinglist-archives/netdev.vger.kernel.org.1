Return-Path: <netdev+bounces-207081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B31BB058D6
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3CA17E93D
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E819F19D09C;
	Tue, 15 Jul 2025 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bi2/dijq"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011034.outbound.protection.outlook.com [52.103.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E82D878C;
	Tue, 15 Jul 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579009; cv=fail; b=Yd3KKj8/pRynIFnGGv7qTJrzN1DZH840aXJdPX9qnDJtriHACxsuMtOCujCtNPhpjOKbaCXymlA+c2IXxKh/XtNl4nE0Jh06Ik2IN/11yT+rGYShIsmgSH7fsTmxJGN+52A2COomx01SKsT7qz3EIdlkbDAr1+f9c0iWagYXCgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579009; c=relaxed/simple;
	bh=Vc5FgYMVgFfKdvyEsuzuamaZixyFn8ipzLwE4uW4t9U=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VJvi5GlVR3AejMuLzz/6raH3laPGXNAoYsG10NLF2pO+Hulu2trFE1kxMcufuGgLg+XOfwyVLE8+7ej0E8UevdImpgOBHsYcUG4mcwiUxCtKmB8ZtWhECTJhoGtv9+mL3U3ggOnDA2L8xTjwkuP4pIMzJWD5weZdBXQdYA4bIfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bi2/dijq; arc=fail smtp.client-ip=52.103.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qc3rWLiqUXK4DdSs6AyLBcoEUq/RsrOnF07zmuW94TFDY7gBMHfuTEr6u20l/nutzUoalIBQz2CXcEQWm9bPZjZSYcZQB1Pm7bWUZW2RhRrNysM4YGBzt4pmc8GKl7F/Gc7QPxpsxaRSlPhDh3l2HbKtUQxRWUnzAoH6RmE+j2Jbkj20YDNMFGoYqULVaFeIh4fjv1cppABK38sX/c1XJ2yKXpdl5XW9AetP5E1DnqiwK9PlK9x5O22tdq0P+t/rI4rgkMRe9GTb+7mdz6xMLOUguI7C6oJ1V2QQ6yyHmySDoFyWw4SGGaHMXLNGZQHbzbKDTX68jKlkqiA9PI0Jhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vc5FgYMVgFfKdvyEsuzuamaZixyFn8ipzLwE4uW4t9U=;
 b=L4oB88pgKkakfTb5i/cHNJ2m+zzq/GUcG6Mn3SKs8QCpYvub09+OQGSSd2pHm5RbA1hOXBfYZ817FUpqKqHVBUlN2pcg3qgZsE/e2ApVJ+qOqEbfdtwZAk+GlKb2IXv98VkdNaHOztql1funDjG1R95wvLgHQCX7SNdoX8P64kC2LSpdKi6jUnGk8dN1yQxNP4zh40+996hSPYp/ciWP0GuQuaMg0zCWyyx0Ms+k55wJhdQTi9OUMauEdxNlnOqexK4UQTYBF8/KVUovzvCbilUvgxWICRhzMNbqHOL5CYgkMf9yELcS/KPlHkC1/fGzRF/IjhVw6rTqtsfvd8cQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc5FgYMVgFfKdvyEsuzuamaZixyFn8ipzLwE4uW4t9U=;
 b=bi2/dijqup8jq4EHsUJOjQ5OY+58eM+BCg0jBtqFXMXcYMjk4KPqIzbWlBGwAW/xP42yvDX1KMubVc3lAx2aMmwvEdCC/ZndGiX6LT16sDkIWshEhd4qOyF2FcRQn66d1hjPsLg0+zHonA7Iz6TpY2/dJxOmfLawY28Jgjy92GRMASJIL9fgKhypFhJbZNchPBYrHUMnojzPbyASkwIW4gkF84mG0BSz8XNCXCX8RRsgC5yJvZQNeQYCySh8SWcraNaqU3RUP0upIR7xJtiUkMNEv8q0sVQMi3/z53iygAhHEu/Mess3/Sr5ZXBgkJVeowVGt+fo0IGK5xQaMKgAmA==
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10) by TYRPR01MB13106.jpnprd01.prod.outlook.com
 (2603:1096:405:1cd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 11:30:03 +0000
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::7679:e9eb:aeb2:f12f]) by TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::7679:e9eb:aeb2:f12f%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 11:30:03 +0000
Message-ID:
 <TY4PR01MB14432A181F668B0FCAACB30139857A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Date: Tue, 15 Jul 2025 19:29:57 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: net: rfkill-gpio: document
 reset-gpios
To: Chukun Pan <amadeus@jmu.edu.cn>, Philipp Zabel <p.zabel@pengutronix.de>,
 Johannes Berg <johannes@sipsolutions.net>
References: <20240528143009.1033247-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <20240528143009.1033247-1-amadeus@jmu.edu.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lRenIGErpl2FtXcj6a66JidJ"
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10)
X-Microsoft-Original-Message-ID:
 <9aa0189b-f627-4588-8a7a-a1b42b09cd2b@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14432:EE_|TYRPR01MB13106:EE_
X-MS-Office365-Filtering-Correlation-Id: 754e74d1-7a6c-4014-4984-08ddc392f112
X-MS-Exchange-SLBlob-MailProps:
	quCBMN2EvO8r/Stb+9lj84LfGyVXhqR3pGizVAC8fHt8Y/E/dK2JV4dVjZcC5pHR2WuMhAY97KGZedC3YPOAKq05DKb/sU/SGqRPe1VyFedhCgACVbdoT9c85WJcMAx+fA75BLF6L7xnvF2WG6Ta00pGg5Q4ly624VbRamLff5QYlVjPGnkvO1eNGMRa9rafnWb6WrjKyIDf7HfQO54g8NSrQqF7+G7nSaxGwCsTk1rxguMroI4XYvJL1V2OpeR7GVzXYK53kmH4+SkMFdOiS0ofIvajxQINDOBa4xn/bOaKO/2BwnCHY32LmUR39aUrBaMowjjsfy5oLJdF1v3ptuDgZPO1SwxoaOE+xU84gVsmdoIBVPmBo6UMfaGcpbrTU2XS535o9zN1Nifz254DeZx8zIfuXqWf2FV1XltiV/Q4KIzI7rMm4GPumErCi33z/KQNUgOK1lqdkI3bnPdN7Ysr/MikiCDZy1uzrxMyiLO7cArP5Z1DI6gdQQJ96vD/a0yp8BCODGzZrf6he+430aXeTj2ldi5FlpInAK9e2T92OL+skVmKy2UX8Qy6PuXTTGU33eIFIDcPzSUUAqHpzkx/bkLpLBTFYJP8GVM/DHXwW2TpMm/KpTSqis+RcWY/w8j1zJl67l0ugqq6U+rbAMPFVtfxvnjPIwnwHUByVhyNBhryX8zz50rHCuAEHTZeaKn9C5XEH+54KFyep7FiFQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|6092099016|461199028|5072599009|21061999006|41001999006|40105399003|3412199025|440099028|51005399003|26115399003|26104999006|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmZtOVFsYXp2MStQS00zTFUxVDJqMEZWdExBTk5qdUwrTnIzVlNqcWtnSEFs?=
 =?utf-8?B?c2NuUVFRRTY5R010VzdhdS9UcjNRUXhnYUlJa1IwUXBKbnJ0QjhsZnViM0pl?=
 =?utf-8?B?cm5DM2IrUUZOakszUVU5QVBWUE5hdUxsOHhqcGx2WWk5WGdSdk5kdmMvV3Qx?=
 =?utf-8?B?cEpMVkFIczdBbGd1TXJJU3haNnJLVm5LaGJ0NVBwMENkaHM0TEpHTDBveVRB?=
 =?utf-8?B?RlMxZzN2WERzVTl4Z2loYWVPWUViaCt6eVI3Z2xZTnpaSVVzbHc1cEpWNVlP?=
 =?utf-8?B?cnBQL3hkclJaMG4rUDRBWElPZS9TeDdNVk9BV3hQam55OHJ6RmdEVkNYVUtJ?=
 =?utf-8?B?cElrWnVTbUU4V2ZPWUM0UHZDcXNzZmNnNUJRR3dpR0VlU2hnSUU3VmVJUEcz?=
 =?utf-8?B?amxzSVY2VFBoSXdCQVBEOUEvNGdJSnNtV0hnemZIYjZxVHlXRkNlMDA4MkZY?=
 =?utf-8?B?ZGxhNDV6bUpxenFoVW1EUDFOZExRb3grc1VKUjc5c0FjUzV5eU9zOUlXbEw5?=
 =?utf-8?B?MjBsaHVhR2E0b05ZR1kweDV4OWdhcHQyV0pXN2lkRC8zMmNUZnAvdVBSV05y?=
 =?utf-8?B?U3BqVk44RU9oMEpHTjJ0dENMb3lBSGc0UkxoWjB5b0ZsKytCYSs2NGxMYm91?=
 =?utf-8?B?dHdsdHhmN0hJWktrbkVVSzJLTlBUMFBTa1J6eFpwcGZVTm5vSUk1ak5wMk5q?=
 =?utf-8?B?aHU3YmdWdEZOeEJkYkgzdlRXNUtzUmszYjRneGQ0dVZEOWlObWtFbUdTTm44?=
 =?utf-8?B?SWpoMzJMcFpRa25nR2wzNnVRUS93YXB3TGtxNjh6cUpCZDR1MUZ6dHlma3Q0?=
 =?utf-8?B?bmVvU3B1V3FWaCtpcDBEbWtodjVBVElydmw3WUxZa0NzV21zaHlIYUd0eTRl?=
 =?utf-8?B?QU01ZkR3d1BJMk1BSTNjRkZsdGN4cGZoeGVSWnpaQ0hyVXozV1RTS0lnelhz?=
 =?utf-8?B?YURiRk1Pc3JtajhNTnRnQzVBS0pMdmlqSmVQQmdqZXhBOTUvZFc5TXB3MDM3?=
 =?utf-8?B?NS9ROXgwTmU4NGpQY3NORURHZ3ludVU4NTgyUVBGN3h4TE9XcE0vK0EzbnU1?=
 =?utf-8?B?T2xzbUtRa0hPWk55RzhEUFV4UFpWRkdIWjdxc1puTHNiMHVkUTBrVWhhQVF1?=
 =?utf-8?B?YXlVZC9YVHM3ZnJraFJVNEdoeWZEQ2pVYWZHU3RGa3VJVEdObmRuZG9lZ2Fw?=
 =?utf-8?B?cVlUTVUwMzk4bHY5S2ZuOEtpWTd1KzVEeTZFQWtUTlhuR0hKSkxDOEoraEJ4?=
 =?utf-8?B?V3FzOHp4amVjQ1IyR1VkOTJHZkJCNWpRMWhMSHloTWhmNllRNnBWelpRZ1R1?=
 =?utf-8?B?Kzkyd1FkNytPbzJ1ODB6cXMrZDhRd0JoNmFxcEFaTTRTcTEzV0tIZ1ZYTUtl?=
 =?utf-8?B?TmxZZHVHdFQ4N3B1c1RkSFVoOGZkcklWUm5QVXI4dm0zWkpXVWc5UkNSVkZC?=
 =?utf-8?B?OFVVd3VCMldLdG11UWlld2Z2NmtGcXdTMEhESUZkelc4eDJLaWVpdmFpZi9P?=
 =?utf-8?B?bHd2RFA1SzlpaVd3TWpjV3R4ZXNITnhEclQra1pKZ0NIbzJFandSOXNxUXBU?=
 =?utf-8?B?b0tIZWp0UVFQZTByeFVLUnFLZ2x3UWVQWnEvUkh5ZW5nRHVhSmtmSk9PbHJ0?=
 =?utf-8?B?VEpDVm11N1JORUVkNzlJOVQwOTR2ZFJNeWpXcm9Zelp6NVlLQ001RlJHUGtn?=
 =?utf-8?B?ekNWMG5rRVBFVldlbXlsQ04rNkVkbnpjWUlhRWRYZlo0TjJmNjIxSFRBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3oxN0JDTzBTSWFkMXlpNHZPb29lemJqcnhldGRPR0hQVjZFVFNiOERQcXZO?=
 =?utf-8?B?L2kxSmd5a05CQkphYldhVi8zSmE5VmgxVlJ0VmZMRmMrbkFPSkF4U0w4U0Zh?=
 =?utf-8?B?NWNPTmlOTDNNYUpsMnVKb2dlOVE5aEMrODJQYTkyUWVkM24wRHQ3RTlDM2Qw?=
 =?utf-8?B?dGg4cWI5QlBIakxha3p0RGxrM01CK3pRU3FTZ3hFdGEyT25GYzNTa0NSSnly?=
 =?utf-8?B?NjNkUzc1ckdKYlBNWFMxQ2tHWk05QVVrbGY0Skx5b2tEaGY5alV4TFdpWUsw?=
 =?utf-8?B?QmpRMXA3dTdtNklnZ0VISFBhUzBMaXNVeDVXdjhOY0pZRmN2WU5PUFY1dHFR?=
 =?utf-8?B?VUM0VURsV3B6VU5XRU0xUHVJYTVTaEVJQWFJTXF5aXlSSUtkbHFtZE5xUUZ4?=
 =?utf-8?B?aU5ZSGgvM0o0U3hSbnpoNWxSOGJybGxhL2Y4eEdIdUpjcFhqVTRjWFQrSUNM?=
 =?utf-8?B?ODJBbDZsNkFUMHovRlQ2YjRaZy9HVW44V2tYMVlPNnZDN1dDc1F6d2tCU2VP?=
 =?utf-8?B?eTZSOWpXdnhOVGZRN2FyQUF5QzdxZDVFaithUjdoTldHb0J0SXhFbXZQZFNw?=
 =?utf-8?B?NkRzUkEvU0o1d2dvS1g5ZmxrdUlKN0pkUWRKRDVzUXlIR21Rd25wMXFNWDR0?=
 =?utf-8?B?azBicitSbHdtcmNqYWFBRmxtZ0xzcEgzWDRqQkI3UUQ2QmIvZUN4YktJV2pX?=
 =?utf-8?B?cFV3cWNzSFkxbmdMZTRDZHVzcTcxbGJTWXZaY1FTckR1STZuVWtKSURidGQr?=
 =?utf-8?B?K1dmOU54dFRhdE5MUS9MajZJbTdiMmc4dC9yKy9PalJjQkNXNmVveFZqL0xu?=
 =?utf-8?B?THhycGc0UGZzbFBVRFluWit6L2owT0RXa3hzYzc1Kzk0UDBMbmZ2c2JXS013?=
 =?utf-8?B?cDRVUFUreHltb2Y4eVBLcDhjVEMwR1dVeHNWOXB3K3hFUk5UcjlqNmQwZElB?=
 =?utf-8?B?UFdaUGEvT2IyWVRUK3ZOVnZMOXAvTFpKdkhSOHUrMVdjb29GK1pKeUtzVjFj?=
 =?utf-8?B?c3UwaHNyVVdTdDRsOTdWc0NtRVN4ZnliQkVuZ2tpZDVjL04wUkIwTktOeWRM?=
 =?utf-8?B?bmxYaGo0TXB6cE5TeEJkZ0JQYWRjdUloTGpVTlg5VFNmcnhYVDhkNmtOTis4?=
 =?utf-8?B?WVdNRTl2cExHYVIzK1ltZHFoei9kQ3Y1bEtlVjB5L1YzTlRLMkVOUlFHQk96?=
 =?utf-8?B?bGM1TTZEaWVlRzFnaTgvQVFtY3hmeSs2aG1CM3hidVpsMEpmS3E2aS9JTnRs?=
 =?utf-8?B?NjhBQ1BNSTg5dlNLTTkxME9WTXJRaUw3Y0p1b0V2a1k4eC9YSTcrbytpSzRy?=
 =?utf-8?B?K2dOT3UrVlJwRS9GOTRsVDE3S1JWL1g1Z2xzVG50d0JUZ2t1UlY1RUZldkh4?=
 =?utf-8?B?TUlJUnpwM1kxRGNQMGRBT2piS0VlSXlaekd2S21mcVgxMVExcGVST0M0ZGRW?=
 =?utf-8?B?RmMwTEdmWUxiQWl1eVI3aitDWUczMm1HSVozTVpXb0VlU2NyaDZrd0hDSm9t?=
 =?utf-8?B?Q0c2S21pNThLQTJWQmVnWHY5a2J4ZXZJdmIrMHlRY2YrQWgreExHb3ZCUzB0?=
 =?utf-8?B?RDJ1akwrRllCMTN1NUd3QzI5Qmk2Ykt2RzZGMm1DQ2tpNnRYVHlOR1ZyeklE?=
 =?utf-8?Q?zmMDKIpd2vFZLlsrhVIJlHRe64jYeVTKi7TN3xIhIdho=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754e74d1-7a6c-4014-4984-08ddc392f112
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14432.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 11:30:03.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13106

--------------lRenIGErpl2FtXcj6a66JidJ
Content-Type: multipart/mixed; boundary="------------iJ3wD8aOanuWRaUHG6cFGPux";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Chukun Pan <amadeus@jmu.edu.cn>, Philipp Zabel <p.zabel@pengutronix.de>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: wiagn233@outlook.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <9aa0189b-f627-4588-8a7a-a1b42b09cd2b@outlook.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: net: rfkill-gpio: document
 reset-gpios
References: <20240528143009.1033247-1-amadeus@jmu.edu.cn>
In-Reply-To: <20240528143009.1033247-1-amadeus@jmu.edu.cn>

--------------iJ3wD8aOanuWRaUHG6cFGPux
Content-Type: multipart/mixed; boundary="------------thpt0gHxEgXkl2xhvEU7TWCW"

--------------thpt0gHxEgXkl2xhvEU7TWCW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgZXZlcnlvbmUsDQoNCkkgaGF2ZSBhbiBleHRyYSBxdWVzdGlvbiwgd2hhdCBuZWVkcyB0
byBiZSBkb25lIGlmIHdlIHdhbnQgdG8gc3VwcG9ydCANCm1vcmUgdGhhbiBvbmUgV1dBTiBt
b2R1bGU/IFRoZXJlIGFyZSBzb21lIGJvYXJkcyB0aGF0IGNhbiBwbHVnIG11bHRpcGxlIA0K
V1dBTiBtb2R1bGVzLCBmb3IgZXhhbXBsZSBCYW5hbmEgUGkgUjQvUjQgUHJvLg0KDQpCZXN0
IHJlZ2FyZHMsDQpTaGVuZ3l1DQoNCuWcqCAyMDI0LzUvMjggMjI6MzAsIENodWt1biBQYW4g
5YaZ6YGTOg0KPiBTb21lIDVHIFdXQU4gbW9kZW1zIGhhdmUgbXVsdGlwbGUgZ3BpbyBjb250
cm9scy4gV2hlbiB1c2luZyByZmtpbGwgY29tbWFuZA0KPiB0byBtYW5hZ2UgaXQsIHdlIG5l
ZWQgdG8gYXQgbGVhc3QgY2hhbmdlIHRoZSBzdGF0dXMgb2YgcmVzZXQgYW5kIHNodXRkb3du
DQo+IGdwaW9zIGF0IHRoZSBzYW1lIHRpbWUuIEFsc28sIGl0IG1pZ2h0IGJlIGluY29ycmVj
dCB0byBwdXQgdGhlIHJlc2V0IGdwaW8NCj4gYXQgdXNiIHdoZW4gdGhlIG1vZHVsZSBpcyBj
b25uZWN0ZWQgdmlhIFVTQiBNMiBzbG90LCB0aGVyZSBtYXkgYmUgb3RoZXINCj4gZGV2aWNl
cyBjb25uZWN0ZWQgdW5kZXIgc29tZSBVU0Igbm9kZSwgYnV0IHRoZSByZXNldCBncGlvIGlz
IG9ubHkgdXNlZCBmb3INCj4gdGhlIFdXQU4gbW9kdWxlLiBTbyBkb2N1bWVudCB0aGUgcmVz
ZXQtZ3Bpb3MgdG8gcmZraWxsLWdwaW8gYXMgYW4gb3B0aW9uYWwNCj4gcHJvcGVydHkgYW5k
IGFkZCBpdCB0byBhIG5ldyBleGFtcGxlLg0KPiANCj4gRm9yIGV4YW1wbGU6DQo+ICAgIC0g
cmVzZXQ6IG1vZGVtIFJlc2V0Iw0KPiAgICAtIHNodXRkb3duOiBtb2RlbSBXV0FOX0RJU0FC
TEUjIG9yIEZVTExfQ0FSRF9QT1dFUl9PRkYjDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHVr
dW4gUGFuIDxhbWFkZXVzQGptdS5lZHUuY24+DQo+IC0tLQ0KPiAgIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9yZmtpbGwtZ3Bpby55YW1sICAgICAgIHwgMTQgKysrKysrKysrKysr
KysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvcmZraWxsLWdw
aW8ueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvcmZraWxs
LWdwaW8ueWFtbA0KPiBpbmRleCA5NjMwYzg0NjZmYWMuLjdmMjk3ZWZkYzk3NiAxMDA2NDQN
Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9yZmtpbGwt
Z3Bpby55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9u
ZXQvcmZraWxsLWdwaW8ueWFtbA0KPiBAQCAtMjksNiArMjksOSBAQCBwcm9wZXJ0aWVzOg0K
PiAgICAgICAgIC0gd2xhbg0KPiAgICAgICAgIC0gd3dhbg0KPiAgIA0KPiArICByZXNldC1n
cGlvczoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICAgICBzaHV0ZG93bi1ncGlvczoN
Cj4gICAgICAgbWF4SXRlbXM6IDENCj4gICANCj4gQEAgLTQ5LDMgKzUyLDE0IEBAIGV4YW1w
bGVzOg0KPiAgICAgICAgICAgcmFkaW8tdHlwZSA9ICJ3bGFuIjsNCj4gICAgICAgICAgIHNo
dXRkb3duLWdwaW9zID0gPCZncGlvMiAyNSBHUElPX0FDVElWRV9ISUdIPjsNCj4gICAgICAg
fTsNCj4gKw0KPiArICAtIHwgIyA1RyBXV0FOIG1vZGVtDQo+ICsgICAgI2luY2x1ZGUgPGR0
LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPiArDQo+ICsgICAgcmZraWxsIHsNCj4gKyAgICAg
ICAgY29tcGF0aWJsZSA9ICJyZmtpbGwtZ3BpbyI7DQo+ICsgICAgICAgIGxhYmVsID0gInJm
a2lsbC1tb2RlbSI7DQo+ICsgICAgICAgIHJhZGlvLXR5cGUgPSAid3dhbiI7DQo+ICsgICAg
ICAgIHJlc2V0LWdwaW9zID0gPCZncGlvMCA1IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiArICAg
ICAgICBzaHV0ZG93bi1ncGlvcyA9IDwmZ3BpbzAgNiBHUElPX0FDVElWRV9ISUdIPjsNCj4g
KyAgICB9Ow0KDQo=
--------------thpt0gHxEgXkl2xhvEU7TWCW
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
scUnWnv8sErY943hM8MUsMQ5D0P2
=3DUrys
-----END PGP PUBLIC KEY BLOCK-----

--------------thpt0gHxEgXkl2xhvEU7TWCW--

--------------iJ3wD8aOanuWRaUHG6cFGPux--

--------------lRenIGErpl2FtXcj6a66JidJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmh2O7YFAwAAAAAACgkQX75KBAfJsRnW
SQ/+MJ/eDOOTVn/NP8p8sEEuE7Wl1XqRq+ufkGtj6kqK5ls8wxB1EWt0517/FRrsMkAtEw++27hf
kMKHfv6viHb073QcH19x+fBI9T5gynpMggyDVp1lixkFoRpEEVbZ4YuZR0+HurqXtgQzoyaPc+sw
eudZjaIJ4UDp+9FyexksCrVbo9gCCTJ/s02edOzLFxBC1Z1LHiOa1vJ1eMqEGciX0jPWHrW4np8G
BtuBCfqB79tlzd3OEM3j5qVeV9wOPDBz6aLjIV6jjU8VjJpKp61VTr+e4kMx7fWFMNeWtj9KwZGA
et2D+xXiOmv8n3UJ6fER46Zl8bfXamGdVhvd2gSbj0uYwj6aVQpK46p9boKPiefcn8GZhrBq+ULy
zFKPszS4xz4Kb56qKf8RK89VvfQ4Qo19/UbyJhjhU/+DEKhxQ/z5doOkKiE97G8WAGRS17o+3SVp
aEEM36jRJBptKrUwTxbM5WyUh404f4piLudOe1fEiExmbIs/I2mhSi16Ip+HqwKHFNM7cRMIYfji
9Eyx4qjOq9BaeG2+ar8SAjd5hwfFmR5nPfG15pgKD3wEeDp7EoKA/IUzgkRxc+pgrWvEhnMK4KtF
Jzm8fuYX/MkmXhr8B+yO1NuQCc/vKcvkrHX29CPnDjrk/3VI0l5pwqZ+NMP0fJkUowpba69T+FOP
dds=
=buJ3
-----END PGP SIGNATURE-----

--------------lRenIGErpl2FtXcj6a66JidJ--

