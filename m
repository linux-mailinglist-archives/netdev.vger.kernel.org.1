Return-Path: <netdev+bounces-216969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E11B36C31
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AE6587B8E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D2335CEAC;
	Tue, 26 Aug 2025 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="TKlHQVcT"
X-Original-To: netdev@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020074.outbound.protection.outlook.com [52.101.171.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0535FC0F;
	Tue, 26 Aug 2025 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219265; cv=fail; b=ZurYPUEHyLK3jU/kQiygpJl4I6W9xJd65PQtaoMAxlGui8C/sp2NlFDHxz+2l8XKDHEWUukOkg4aDnnGwPRYr1tKRUUgu1iX8EChKWrk7kUOJdUcHv6daifajcovCxmWEOz9//STB+qi0vDW1atDQYVN4sZyWsoQPGwGIiVAlXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219265; c=relaxed/simple;
	bh=/mksvpEu71Vg92KtYgobHHg/uu5c1OmOW+a+HmayrSY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=moH57B67P0CnvW+wPsmyMsPZs82Ltq9kHykc8Yi7XYLTL+efXEVUMNM/HlTmw9N9Ib6eSwbapLclyMIq2Bz13JfZ/2a4jaHIC2UCxfFmadywm8Si5g91Y88KU3Ghg/XAol1cawHGv2UUQZh+zg9EOpofpKQl2UD6bat24t37J8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=TKlHQVcT; arc=fail smtp.client-ip=52.101.171.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lf8BCLDvc6Cq12nG46W1JToK+p5XGlSPmGLvPx11vGn9+PHxZNN6Py7H2hDoiC5eBFMtkZzI7RUcOtbudRzW/NtyN7iz9TMIMJeU00FXbd0uQzIZMjJVl0LM05Nkte9nf9Y43CRSJbK/soJJWDx96zORYUmzWKYsBGTv9Et+ukJR4qx0WJoCXfgv1IuIt71NuYN8RG/HMx6id4E62zFoD8quQSdm79oqk9Pq2fI/iBa+p9wz1xVk4HVl5Ld1gaZx9dL0pHoqTFL74CdRyMCLsEosjMfWEOOVQshXRwRVmZhG+fQgfdfj1zZHfQ7V86JLN/a2Y2IVy5HeRRvHC5Ju+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mksvpEu71Vg92KtYgobHHg/uu5c1OmOW+a+HmayrSY=;
 b=B4zmA3RgqsNQGnyf5i8QDuX11N1cAJKa/6GswCndyKhKIPINDu8DN8/D9hivBMn85WrhrIPeKxs0cKuoBa3+NANctTyJVW1kuGuV+Ut8x6vzy7omK8mzQmEtXn2TPbB6/K4qAwmIGG4/hsFjZwe1cUtDXR7gx54jZiXVHTAJhnejzLBDpLAYBMp+As7OOz6KijKP46Ynu2n3x89p/Q+/u8F0MHFeEuoXehIAnmNDYQBw4pK7NTmT7w0CGHPMyN/WATdAI11sJT+ubYBPLsitu1sI8n0oXGnWYqw0z0tsqxcz7OWPNwbW0p8FXXJUMcEP7gMHfZOxN/AY5sHFm5U1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mksvpEu71Vg92KtYgobHHg/uu5c1OmOW+a+HmayrSY=;
 b=TKlHQVcThEWLfIDAJECmbcVjXGeVf25bjJ4/v5te1Lf0tXptlSkPLEO3MzeSKQSCO5y/mRa4aBRGzcvH8yClyhKKrsxtdhvu5gQRdJfYSCsjvtFFwiBdMFkfI7MrLuZFBcrja7NE0oaLw+rVtDYq0VGBjrkbtK/8RlNAt/UXRh8=
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::126)
 by FR2PPFB1CCF8A01.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::7e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 14:40:57 +0000
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::92f0:48d2:2be9:13c6]) by FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::92f0:48d2:2be9:13c6%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 14:40:57 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v7 0/2] Add Si3474 PSE controller driver
Thread-Topic: [PATCH net-next v7 0/2] Add Si3474 PSE controller driver
Thread-Index: AQHcFpdugNKXOj20t0yWPop/WjGYDw==
Date: Tue, 26 Aug 2025 14:40:57 +0000
Message-ID: <6af537dc-8a52-4710-8a18-dcfbb911cf23@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3PPF3200C8D6F:EE_|FR2PPFB1CCF8A01:EE_
x-ms-office365-filtering-correlation-id: 568ae85f-5656-41b8-ae36-08dde4ae917e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VnJxK3lmYWJZS2pUQjZyc1BrVTJ3NXd6b0NnazErVUJPelp3ckFPMklTTTVJ?=
 =?utf-8?B?cXloUzJNZTA4Nlg1U3k2TnUydUwvWVRhNS9oYlNrejlyUnp5RUk3bHFNbGl2?=
 =?utf-8?B?cXNtTlNYc05nNGo4ZVBva0tyR1BGaUROdWhVVlRVRWtobldHa0UrUXBsQUZG?=
 =?utf-8?B?Rm96YUVGYVJabWtTWkNHSkFFaEdnOG03Q1NPYnVGcVdoNEkrWEt1alNQUk81?=
 =?utf-8?B?eEo0aU04ZW5FWXVXc0o0S3ROa09WMVJua2pQZkhzek9VemMxSzZvWmJUUlhP?=
 =?utf-8?B?MkQ4NGFFVUY3cFQ4RkJ4VFpsLzhBRitaZ1RMNHJRTThGM255L1V1OGliSjBW?=
 =?utf-8?B?RFdGdGFvVXlkNmpsTTB2dFRYQXB3RVFKTDNhMzJvL1hvVTZiTk5ydDlKSnJz?=
 =?utf-8?B?UFBUd2czbWpGTkx2aFhZdjB5WllVTno5MFoyRHU3T1Vid2RCVFlwSnp2Smsr?=
 =?utf-8?B?SjBxWUw1YnMwZ2hLK2pzS3FWV0hIbDBRSE9XNStCU1NKTDVxbVE5YlBNNEhY?=
 =?utf-8?B?anVhZGxmQlJKYThsMWZaSHVqWXNXZ1VkRWhuYlkrb083SklkVmVPOU5kQVZI?=
 =?utf-8?B?R2lmZzdJV1VTNzBnZEVVcnphZUpOaWViWW41c2E5YVpJeVFMYkZMUWxiOXdE?=
 =?utf-8?B?QlRNV2tscHpMQ0c2ancrSUx4QTQzZ2NNaWo3aHJndUI4em5IUmpOdEJ4R2JM?=
 =?utf-8?B?a3Z3YnIwT25vYUYxeFZaTlNkSWphUUtCU0oxb3VFR2FLemVkKzJRb0lHZ1FH?=
 =?utf-8?B?b0ZpWVNPWlg2MzN1cmFxWUlndHF0Uk5va0tPUnE3SjkveGJ1TlRKdHhJc09y?=
 =?utf-8?B?Z0xpcXArNEpjTW9wbXhidVJNQzAzdTRERm0xZVNnVHc2L01iRFQvU3NrSm0v?=
 =?utf-8?B?aXo2OTVpREhNbDY0OUpiSmNSd3lzaHljNkhLOWg1Um1IQWZjRFpleUFnREJM?=
 =?utf-8?B?Z0YvcnBkUkVBaUFQc09wRjdvdFpGclVuUGNZY3FxNDJlOHR1cW15ZGV6c0xy?=
 =?utf-8?B?ZS9WclV1YmhUZ1NYNkJ3Smc2djlRRzR3YnFaNllKTk9iMEVBZ2NtRjRzUUZY?=
 =?utf-8?B?UnQrMmxLaU1ERDBnNDhDM3NPWWljYTJzN1dLWnRMTytrUTAyL2NESUpvQWhq?=
 =?utf-8?B?RUpaTnNsUkQ2RkdPcnA4R3dLMnA2UHo1NUxNNy9aeHpmZHhOTjJsakRPZ3Bx?=
 =?utf-8?B?aGlSYUE3eHZaWTdoMmhXelU3bzdmemdlVkZ0enVwTEN5UGJqSnlzblBPYnJQ?=
 =?utf-8?B?WENWSk5OZ0NIU3doNnBoaEIzTEtFV1VjQ3ZvMVA2alFFMlNXc1R1TEMrRVdh?=
 =?utf-8?B?bFJha2t0VXpkcEJDTFdLQm9tRFdWTFFFVy9NUXNJM1VPTnZiNFBIWjhyQ2hq?=
 =?utf-8?B?dHN4QmZlR2dhTEJ6NEdwazVMSFgzVStCUXcxdWV4bWtTYnZ6T1FFYkhqUXRB?=
 =?utf-8?B?TFZhMmg1bkxTTmkxelMzOEhCU0wxKzJjY21ockVwU3NhMFZBeFlUdytjOGhL?=
 =?utf-8?B?a2lSRGdRN3NzL0grUjA1TklDK0VPSk5wUUlwNTNsaTJWc3VOMTRnbm1oTUhV?=
 =?utf-8?B?VnpQejdzUDBwOUNIRWFEcTV5emp2UFA4YksvMGxVb1grZVhFdHJEUG1XN3BZ?=
 =?utf-8?B?WU1WckJ6UG9ZU1NtMW1LN2dkWnBldFdlS3Nnb1JwQWQ3em9qZldqZWpqRDFF?=
 =?utf-8?B?NG9QYS9yR2l5L2RteTFTMVhvcnZ5Q1YraVdld01VWktXdnppcVRiRFdrd0JK?=
 =?utf-8?B?YmF5UTZXUG83YjhVcW9uRmVvUjd1b2dzL2F4QlM0UEFDRDlzclB5QktJWVBy?=
 =?utf-8?B?OHJYaXdJaUNCcVAxTEFQdDR2NUNubTBvbTd3WTFxeHNHdkdtanA3L08vTUxQ?=
 =?utf-8?B?K2VBTXdZZDAwRkNvTUVWTWpYMkVFK3N3c2tjdmxKWUtwdmdjVnBpcy9VSUlN?=
 =?utf-8?B?QWRENk5XM0dxanc2elNMbmsyQmtjTXJ6VVIvaU5XRERRZkxSYjNTaHpsODV4?=
 =?utf-8?B?ZEcwcHlJQkFOUnd6MkR6Zm1PUTJXTkZyNUFib24wMk5HcFZHUW10Rzk0MzI2?=
 =?utf-8?Q?q7+c7L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rm0yVWJGZDdLdGhxTG0yRmVlU24wb2N0aHhmYUZJSDZKZ3FxOVNYaTVOejRV?=
 =?utf-8?B?T1hsc2NKeUJOSUd5SFAxRld5SnF2MzV3alFLb25Ca3poRnlqdEd0eTNqL1Q2?=
 =?utf-8?B?V1VFNVg3K1NQK3M0S2wwNFIwT1BtSVAvd3RjWjNSekFsWWl3dGlmNHZlU3NV?=
 =?utf-8?B?NUp6MFhweHUrOC9KQ3VHbkhxWFdzM1NVcjV0VGRzS2VDRjhKbkgxOUUvUzNV?=
 =?utf-8?B?V2ZURDZLNjR2QW1BNCtmMU5pcjErQ0lybjV4RzZtMWhCbFl3ZDJNZjJQV2RW?=
 =?utf-8?B?eTZRdTZDY0hSSk11bVFpVDNmUm5sTzVMYTRWdnhFSFNmU3gzejNSMnBnN0FR?=
 =?utf-8?B?ampDTUkwYWFlVkJiU2JQaDhtM0FkUEZteW5zUmVvMG1LREo4QlREMjNmYnNN?=
 =?utf-8?B?U0lrZFRpN3EvV25VNkZJbjczWk1LN25hVGx0TjFuYjRNTlJabERLamJRNEhZ?=
 =?utf-8?B?N2ZoakV0TVVOZW1jTUljYkowVWpQYjZzdGZXZG5xb0dzOFJqdFdiVUFOeEhZ?=
 =?utf-8?B?dWhhenc0Tm8waksyNEVhWGVJdDVKYnNPajNyM2xyZWhBOXJxN0RCaUoya2tR?=
 =?utf-8?B?UnNjRWVGa0lYZEl2dnI2NzY1NVUreVZ1bXZJU25kaDJJclRaT00zT2t0dURu?=
 =?utf-8?B?Kzd3NXlPaFB2cXBrS0JJRng3SHA1clkrSzJIeXMwNWtpNmZ5MUMyejJhVzJF?=
 =?utf-8?B?ejc4T2JJQjZTQWVrVHRPN3V2Mm5hMmcvcVdRdXhCVlp4azNjVi9JbFpiSGtB?=
 =?utf-8?B?ai9lVkFwaXRHd0ZVc3l1ZjlkQWU5ay81YTAzdE1oOExBWHlUK2MvQUFadm15?=
 =?utf-8?B?enEvUVN5MFFyVGlDTk5lNk5aTnptQXZFVU5hUFA2cnJTTkN4OG1JOGRkZHNG?=
 =?utf-8?B?TUM0bnROZGVzWDFnWXdMSDhPL3E1cGxwMVE5K1V3Vks2WFcyT3BmQXNvektp?=
 =?utf-8?B?ckFPV1BJcU5GcnhZanJNdEdCcUZndVF6UFhadDVKcDZFN2hNdUNjRkpjMSsz?=
 =?utf-8?B?VjFmL29MalRUMUNuWEViZ3VjTXFoaStOUGRKZjVld2lLRkRqV3RqbTJKV0RG?=
 =?utf-8?B?TVdnSFVDaDNIMHBGTHVNVjRiUnh2aDBTSzVzb3VlcmFXV000d0lQYzFSeTcv?=
 =?utf-8?B?QU55dk1wM25uUWo1bHhUWmdGMXR3elJLQUJmMGovdkVzSFJPemFGLzdNanM2?=
 =?utf-8?B?b3NNQW51dHpOWVdwOU9qVHpzWFJQU01zVDZjSVJkUHN5MktOT1dKK29KdGZu?=
 =?utf-8?B?d1kxUnhUdWlHRkUxelJkKzlQSDE4SHZIZjhnNGJqNGl5QnJ3V3VYTEVXU3BW?=
 =?utf-8?B?QVZlL0RKVEtkMUUxK0VSSXFaOVdSTzlaU0Z1UW5DMmREa0Vjbm4xemNSbU9I?=
 =?utf-8?B?OGZURmpEZW9zWVFNS2gxNGc0SzRjOHo3RDZWWXNMV3phQ1czcWoxS2x3Tjl0?=
 =?utf-8?B?MXFNZzRHVXBJdjhhWktmd3BHZSt2cExUQUNRR0g4M3N3bC9zVk5uVnVZQnpE?=
 =?utf-8?B?bFNNOTIwdVR4LzlRT2NVUUlDZFM0Q1lpY0Nic3MvZkVxTk9tNmxDcjdJRVdY?=
 =?utf-8?B?S2djRzRyTm5kSW5BRDlzMVliamhlbGxuSmJnVHVlV25pRzVSM0VGVmFRSXpp?=
 =?utf-8?B?Q3JkWEhnMGRkMkI2MGFSMmZEK2dCbXFzZEh4NWNqYkJkcnZrTmhLWDRzQjZl?=
 =?utf-8?B?YUNGOFNLZ1VCeXFwVWpGbEZ6c0NiRVhYczVZNVl2RzBYK3V0LysrRk1FUkx0?=
 =?utf-8?B?UE9lcWFvUEVRTEYvNmh0Z2ptbXFrMVJIT2Z2cXphenN5amx3RjM3OVl2Mlhw?=
 =?utf-8?B?bEpSMVVuTzJqNHZCeFQ1cmlHdlV3ZHNaSnY3QU1QaFh6ODk2TGRTeldBU0lq?=
 =?utf-8?B?cmcrdlcvbGpvcHM0WEdhSzhkR1p1UTVRc1dMdDJpd3craDFNVDBRYW1UK29m?=
 =?utf-8?B?WEpSUmdjMXNaZ1FxdE56V29xaCt4clEzZUhTcU15SkFzaEtKVkpaZ2dYR1N3?=
 =?utf-8?B?dVlrRzZpOUFZZjIySmNOZ0MrYVg2TzF3SVBrM09hSnBDdjFaRndZb1NDajlN?=
 =?utf-8?B?VmdvRjhaSnZka01uY0xaMDdqUVhEcHRVWXRUZXRCNUlaRURTQ3M5WUJ5TEZw?=
 =?utf-8?Q?QeeMmCW2LaCcntDMbLJE2dqm6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <724BB0453E5C7441BC5FD601608BBE55@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 568ae85f-5656-41b8-ae36-08dde4ae917e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 14:40:57.2278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Duv2VbzLRjqI6GuZ1MD80KVAl7JZOM4FPuTYt5Qquh38Xreb4j9X7lhVrRbvAYIBhcnYiVU3aO1rVEx97iWCVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2PPFB1CCF8A01

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNClRoZXNlIHBhdGNo
IHNlcmllcyBwcm92aWRlIHN1cHBvcnQgZm9yIFNreXdvcmtzIFNpMzQ3NCBJMkMgUG93ZXINClNv
dXJjaW5nIEVxdWlwbWVudCBjb250cm9sbGVyLg0KDQpCYXNlZCBvbiB0aGUgVFBTMjM4ODEgZHJp
dmVyIGNvZGUuDQoNClN1cHBvcnRlZCBmZWF0dXJlcyBvZiBTaTM0NzQ6DQotIGdldCBwb3J0IHN0
YXR1cywNCi0gZ2V0IHBvcnQgcG93ZXIsDQotIGdldCBwb3J0IHZvbHRhZ2UsDQotIGVuYWJsZS9k
aXNhYmxlIHBvcnQgcG93ZXINCg0KU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1
YmlrQGFkdHJhbi5jb20+DQotLS0NCg0KQ2hhbmdlcyBpbiB2NzoNCiAgLSBBZGQgcmV0dXJuIHdp
dGggZXJyb3IgaWYgRFRTIGlzIG1pc3Npbmcgc2Vjb25kIFBJIHBhaXIgY29uZmlndXJhdGlvbiAo
NHAgb25seSkuDQogIC0gTGluayB0byB2NjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2
L2JhZmRmODcwLWRiYzQtNDY0MS1iOGMwLTUxNTM3NTk0M2FjY0BhZHRyYW4uY29tDQoNCkNoYW5n
ZXMgaW4gdjY6DQogIC0gUmVtb3ZlIHVubmVjZXNzYXJ5IGNoYW4gaWQgcmFuZ2UgY2hlY2tzLg0K
ICAtIEZpeCByZXR1cm4gdmFsdWUgZm9yIGluY29ycmVjdCBEVCBjaGFubmVscyBwYXJzZS4NCiAg
LSBTaW1wbGlmeSBiaXQgbG9naWMgZm9yICdpc19lbmFibGVkJyBhc3NpZ25tZW50Lg0KICAtIFJl
bW92ZSB1bm5lY2Vzc2FyeSBpbml0IHZhbHVlcyBhc3NpZ25tZW50Lg0KICAtIEZpeCBjb2RlIHN0
eWxlIGlzc3VlcyAoYXBwbHkgY29ycmVjdCByZXZlcnNlIHhtYXMgdHJlZSBub3RhdGlvbiwgcmVt
b3ZlIGV4dHJhIGJyYWNrZXRzKS4NCiAgLSBMaW5rIHRvIHY1OiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9uZXRkZXYvYmUwZmIzNjgtNzliNi00Yjk5LWFkNmItMDBkNzg5N2NhOGIwQGFkdHJhbi5j
b20NCg0KQ2hhbmdlcyBpbiB2NToNCiAgLSBSZW1vdmUgaW5saW5lIGZ1bmN0aW9uIGRlY2xhcmF0
aW9ucy4NCiAgLSBGaXggY29kZSBzdHlsZSBpc3N1ZXMgKGFwcGx5IHJldmVyc2UgeG1hcyB0cmVl
IG5vdGF0aW9uLCByZW1vdmUgZXh0cmEgYnJhY2tldHMpLg0KICAtIFJlbW92ZSB1bm5lY2Vzc2Fy
eSAiIT0gMCIgY2hlY2suDQogIC0gTGluayB0byB2NDogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bmV0ZGV2L2MwYzI4NGI4LTY0MzgtNDE2My1hNjI3LWJiZjVmNGJjYzYyNEBhZHRyYW4uY29tDQoN
CkNoYW5nZXMgaW4gdjQ6DQogIC0gUmVtb3ZlIHBhcnNpbmcgb2YgcHNlLXBpcyBub2RlOyBub3cg
cmVsaWVzIHNvbGVseSBvbiB0aGUgcGNkZXYtPnBpW3hdIHByb3ZpZGVkIGJ5IHRoZSBmcmFtZXdv
cmsuDQogIC0gU2V0IHRoZSBERVRFQ1RfQ0xBU1NfRU5BQkxFIHJlZ2lzdGVyLCBlbnN1cmluZyBy
ZWxpYWJsZSBQSSBwb3dlci11cCB3aXRob3V0IGFydGlmaWNpYWwgZGVsYXlzLg0KICAtIEludHJv
ZHVjZSBoZWxwZXIgbWFjcm9zIGZvciBiaXQgbWFuaXB1bGF0aW9uIGxvZ2ljLg0KICAtIEFkZCBz
aTM0NzRfZ2V0X2NoYW5uZWxzKCkgYW5kIHNpMzQ3NF9nZXRfY2hhbl9jbGllbnQoKSBoZWxwZXJz
IHRvIHJlZHVjZSByZWR1bmRhbnQgY29kZS4NCiAgLSBLY29uZmlnOiBDbGFyaWZ5IHRoYXQgb25s
eSA0LXBhaXIgUFNFIGNvbmZpZ3VyYXRpb25zIGFyZSBzdXBwb3J0ZWQuDQogIC0gRml4IHNlY29u
ZCBjaGFubmVsIHZvbHRhZ2UgcmVhZCBpZiB0aGUgZmlyc3Qgb25lIGlzIGluYWN0aXZlLg0KICAt
IEF2b2lkIHJlYWRpbmcgY3VycmVudHMgYW5kIGNvbXB1dGluZyBwb3dlciB3aGVuIFBJIHZvbHRh
Z2UgaXMgemVyby4NCiAgLSBMaW5rIHRvIHYzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRk
ZXYvZjk3NWYyM2UtODRhNy00OGU2LWEyYjItMThjZWI5MTQ4Njc1QGFkdHJhbi5jb20NCg0KQ2hh
bmdlcyBpbiB2MzoNCiAgLSBVc2UgX3Njb3BlZCB2ZXJzaW9uIG9mIGZvcl9lYWNoX2NoaWxkX29m
X25vZGUoKS4NCiAgLSBSZW1vdmUgcmVkdW5kYW50IHJldHVybiB2YWx1ZSBhc3NpZ25tZW50cyBp
biBzaTM0NzRfZ2V0X29mX2NoYW5uZWxzKCkuDQogIC0gQ2hhbmdlIGRldl9pbmZvKCkgdG8gZGV2
X2RiZygpIG9uIHN1Y2Nlc3NmdWwgcHJvYmUuDQogIC0gUmVuYW1lIGFsbCBpbnN0YW5jZXMgb2Yg
InNsYXZlIiB0byAic2Vjb25kYXJ5Ii4NCiAgLSBSZWdpc3RlciBkZXZtIGNsZWFudXAgYWN0aW9u
IGZvciBhbmNpbGxhcnkgaTJjLCBzaW1wbGlmeWluZyBjbGVhbnVwIGxvZ2ljIGluIHNpMzQ3NF9p
MmNfcHJvYmUoKS4NCiAgLSBBZGQgZXhwbGljaXQgcmV0dXJuIDAgb24gc3VjY2Vzc2Z1bCBwcm9i
ZS4NCiAgLSBEcm9wIHVubmVjZXNzYXJ5IC5yZW1vdmUgY2FsbGJhY2suDQogIC0gVXBkYXRlIGNo
YW5uZWwgbm9kZSBkZXNjcmlwdGlvbiBpbiBkZXZpY2UgdHJlZSBiaW5kaW5nIGRvY3VtZW50YXRp
b24uDQogIC0gUmVvcmRlciByZWcgYW5kIHJlZy1uYW1lcyBwcm9wZXJ0aWVzIGluIGRldmljZSB0
cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbi4NCiAgLSBSZW5hbWUgYWxsICJzbGF2ZSIgcmVmZXJl
bmNlcyB0byAic2Vjb25kYXJ5IiBpbiBkZXZpY2UgdHJlZSBiaW5kaW5ncyBkb2N1bWVudGF0aW9u
Lg0KICAtIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9iZjllNWM3
Ny01MTJkLTRlZmItYWQxZC1mMTQxMjBjNGUwNmJAYWR0cmFuLmNvbQ0KDQpDaGFuZ2VzIGluIHYy
Og0KICAtIEhhbmRsZSBib3RoIElDIHF1YWRzIHZpYSBzaW5nbGUgZHJpdmVyIGluc3RhbmNlDQog
IC0gQWRkIGFyY2hpdGVjdHVyZSAmIHRlcm1pbm9sb2d5IGRlc2NyaXB0aW9uIGNvbW1lbnQNCiAg
LSBDaGFuZ2UgcGlfZW5hYmxlLCBwaV9kaXNhYmxlLCBwaV9nZXRfYWRtaW5fc3RhdGUgdG8gdXNl
IFBPUlRfTU9ERSByZWdpc3Rlcg0KICAtIFJlbmFtZSBwb3dlciBwb3J0cyB0byAncGknDQogIC0g
VXNlIGkyY19zbWJ1c193cml0ZV9ieXRlX2RhdGEoKSBmb3Igc2luZ2xlIGJ5dGUgcmVnaXN0ZXJz
DQogIC0gQ29kaW5nIHN0eWxlIGltcHJvdmVtZW50cw0KICAtIExpbmsgdG8gdjE6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL25ldGRldi9hOTJiZTYwMy03YWQ0LTRkZDMtYjA4My01NDg2NThhNDQ0
OGFAYWR0cmFuLmNvbQ0KDQotLS0NClBpb3RyIEt1YmlrICgyKToNCiAgZHQtYmluZGluZ3M6IG5l
dDogcHNlLXBkOiBBZGQgYmluZGluZ3MgZm9yIFNpMzQ3NCBQU0UgY29udHJvbGxlcg0KICBuZXQ6
IHBzZS1wZDogQWRkIFNpMzQ3NCBQU0UgY29udHJvbGxlciBkcml2ZXINCg0KIC4uLi9iaW5kaW5n
cy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sICB8IDE0NCArKysrKw0KIGRyaXZlcnMv
bmV0L3BzZS1wZC9LY29uZmlnICAgICAgICAgICAgICAgICAgICB8ICAxMSArDQogZHJpdmVycy9u
ZXQvcHNlLXBkL01ha2VmaWxlICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJzL25l
dC9wc2UtcGQvc2kzNDc0LmMgICAgICAgICAgICAgICAgICAgfCA1NzggKysrKysrKysrKysrKysr
KysrDQogNCBmaWxlcyBjaGFuZ2VkLCA3MzQgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3BzZS1wZC9za3l3b3Jr
cyxzaTM0NzQueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9wc2UtcGQvc2kz
NDc0LmMNCg0KLS0gDQoyLjQzLjANCg==

