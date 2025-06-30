Return-Path: <netdev+bounces-202518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF593AEE1BA
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678BF3BCA09
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B11528D8C4;
	Mon, 30 Jun 2025 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="d8kwsGKf"
X-Original-To: netdev@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022143.outbound.protection.outlook.com [40.107.149.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C54F28C2D0;
	Mon, 30 Jun 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295426; cv=fail; b=JCvAZbORZkqnIzwaKetaDAUdLiQMth1IPuSZIBKxOd/HhU1fbb0JGVZ/X6lN1uKYBB0DxICug+fOtL5WUcX58mc84RDzpKLQYGBvHUIXCRQUHA96wzs20KPr7ArlBEWfhVlRpVl+Bmvl/FIg/RLj4lO5qVa2Lpi1k7VKHxYjqNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295426; c=relaxed/simple;
	bh=njpRyF/RzsfTuKBG8zqU9ocxCCR6ivmIyppzR7FHXFI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V3rKCYb8xGG5V7N0YNKZjPPmxVZuJbigo39yoBz99o9ySWiWCuLjdE6Kihnljydvu+f6ffk+U9WLKSdhoACn/JPhkmfcWVM0szbj7FDsEdpEFUtGljr0E5MROWzRKS1HlNomM6sruMoARVqAsIIGp6UZgieEggkcNNbm3lXJqEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=d8kwsGKf; arc=fail smtp.client-ip=40.107.149.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0+reUC1uRZRjj5RwS4Ln9ZBVc+nCyfkO3fL9PCX933ZuO8TUeWkA0oiYZ0mO+CYTScUUr99QaOWcgWizAk8XvW8HvR1k4b4CMbTCCHBED3fdaP/3VhlR6Z2MMpGhTsyYSTgr5vUzPNSNz0DkJQ4jLa0FV8kaV4Nz/EkaUGS/y8tYQChojC47iaOoxMiRLC4aV82AYSZNO9bUrFyB/0XRtrdfxD08PnUOZoxpYYAUTf4m1XMatXUAE/vSa733YIzz88LqK65fuNgdKzEQzDP4ao/uBNMHFns//nT2ku5d0sDH1gtcv8ci34NSnbX5Z8xbAkw/FQ0h4wvcY08/leQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njpRyF/RzsfTuKBG8zqU9ocxCCR6ivmIyppzR7FHXFI=;
 b=PDnJETSI7GA3g8qJz9EubfqLlH2gPnphtxnHdoBwjFDdDhm/BaW9vuHUCh1AuzP3ucrHm+QO754K9DwqAVrdAG8Z5cKbjdTJNb55R7RD2wr6c341bisxluJB+3Cddu75uW+O2T3MzzbnUGmOI8o0+8/hFW1kRKz6gAp3aNgE4aUMauXkCeOcneRn8rnms1cSRym0PUUfdtMduF/va2nYLl+GKJDPdhml3BiqCtWMfdVauHq3mIxjtj18R37tBVDToF80ewUwpaqadTkH4oay4UHVLK5zZQvVIic1PUmrzWw4Qj4w75N+vPIAIEeWLi8iE976DVI8k2EUMUd9czHhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njpRyF/RzsfTuKBG8zqU9ocxCCR6ivmIyppzR7FHXFI=;
 b=d8kwsGKf+CAB8QnHsqoXlG/YfRnu5Ivk0UUuSDTMWAQpOIm65qCGEL9E/6t+oczR7lUf2MlzJcfOZAHdhLCKMuX6Es+ciIs8VwjTl3/GsCPMpzHCdt2r2bqBkJEnVschoNxDVOKMlbZcpueFyTHGb/UaXVvSLQBLnSk6AOB1H6o=
Received: from FR2PPF3DF8BD4D5.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::26)
 by FR6P281MB3553.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Mon, 30 Jun
 2025 14:57:01 +0000
Received: from FR2PPF3DF8BD4D5.DEUP281.PROD.OUTLOOK.COM
 ([fe80::84a9:2a79:4c0d:e41a]) by FR2PPF3DF8BD4D5.DEUP281.PROD.OUTLOOK.COM
 ([fe80::84a9:2a79:4c0d:e41a%3]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 14:57:01 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 1/2] dt-bindings: net: pse-pd: Add bindings for
 Si3474 PSE controller
Thread-Topic: [PATCH net-next v4 1/2] dt-bindings: net: pse-pd: Add bindings
 for Si3474 PSE controller
Thread-Index: AQHb6c88QGUnSQPOskKw69/rjkon+Q==
Date: Mon, 30 Jun 2025 14:57:01 +0000
Message-ID: <7bffd0d0-e19d-4349-b9d8-10f6358a7db2@adtran.com>
References: <c0c284b8-6438-4163-a627-bbf5f4bcc624@adtran.com>
In-Reply-To: <c0c284b8-6438-4163-a627-bbf5f4bcc624@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF3DF8BD4D5:EE_|FR6P281MB3553:EE_
x-ms-office365-filtering-correlation-id: 8ae33fd8-b194-4cf9-a1c9-08ddb7e65edd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTNzZ3M2V3ludnFyWkJvcmV0VTFtdXN5cEgvWWFEbTJkNGVKYVphQlJPMFNw?=
 =?utf-8?B?VWVFc1BjK3I0Zkg4aU1SbjNaT0RUM2ZBQ000dGt6U1JHZmhwcjNtUGplaUNm?=
 =?utf-8?B?UmlkZWF1RjM5R25HYUI1bjhQR0pMMkZsdkxTS044dW5YUCsvZDRVWlQxMkE5?=
 =?utf-8?B?UGpJOWNFSWlwbjU5dnQ2OXRLZUtwR255UlNBOGV4Q1lLYncrUmoxMlhGNEor?=
 =?utf-8?B?Qkw3VWE5Snk1YUM0Q0RIZjA0eXIveWdGeXUvZUQrRkpOK243Nm13VzkxODJT?=
 =?utf-8?B?Nmh6QzI5QnRPRysvOE51T1g4VE8zNXV6bXJTZGQyTzBFMVFodlZMYzA2KytY?=
 =?utf-8?B?K3BiSGh6YnlyNzhGUkVtQVE0QktWTlR5RXRHV3VRTDUzc1k0NlkxRjNJNUNh?=
 =?utf-8?B?dklEQjM1dDdNbVYwOWxjSEx6amdvejBWekRnRlE5Z2JzOC9XZW9kU3JQNU92?=
 =?utf-8?B?S3VudFRUN0g0b1JYeGdZbDNxOHV3dnRPbWhxaXl0NURUWEpqL1MvQlU4OXBl?=
 =?utf-8?B?YTk1YTQwSGtGb3hKUDhUWFp6OHlkY21CbUhnZXBCdWxvS3hGR0M5Z1lvZW5H?=
 =?utf-8?B?VElDWi90TURSOEFheFJxdHJpWGR2NWpwUjhOUDZJK0U2ODMyOXlTU3EwNVI2?=
 =?utf-8?B?UExVbWM0aU9vZEhJSUJYcHpEQmlCNkY2OFVZbk5HeHNWRWpmb0cvUUhPMGVE?=
 =?utf-8?B?RThLNlFtUHNxTHp1TEUyVFJmZmVTK29hdityZUJKK2U5VGJSNzlISUc3UWhi?=
 =?utf-8?B?bmN2MEhrakluaGtXaUUwcnUxVDhqcVl6ajBIdFFOTHFrTW1lQk5FaE93b0Qz?=
 =?utf-8?B?MGp0ZDhEcTB4cm81V2hXRVMyaWJ1THc4UGJMcHdkclRmb0lFU2poYjZDdEhk?=
 =?utf-8?B?ak00QVViTng3TFVjeFlScml5N2VzTlRqSStvQUw5L2U0YkpVYnNmbWhTUUto?=
 =?utf-8?B?VHdyWUFVZ1JtN3VMQjUvL1gxWjRBdDRadmNWKzg2L1FuT3U1YkNtc3k1Umtr?=
 =?utf-8?B?ZFVxTlVkLy9tUUhZY3E2d2pGVXBqdVRYU0FZeEF2bW90ZUhIUTVNQ0lUWW5O?=
 =?utf-8?B?TXQvTXhIYUtGMGJWQmJKeGRIUjU0elA0VFJFMzg4Q1dSUDlBN3gwTDQyUU1P?=
 =?utf-8?B?Q0N5NldjY3JBakdBd21aYjUrN21DSkhJRm55VmRUTDNOVzBQcGhEaUhla0l3?=
 =?utf-8?B?ME9tWWZzOUxVNVRkNWp1d01KZ2J6V0lsbXh0bldrVC9rRjZoVjdVYXJQbHQz?=
 =?utf-8?B?ZmdKRUlwSU1ZWkQwNlZWR1BnTUhEcEV2dVlhckRmVmpEeTRnSFp5cFBHb3Bw?=
 =?utf-8?B?cmQwYkZNQnFHMUwzdWJaZUYxSy9FVmJUMVk5VmNiaGNhaDM3SDVyN1NsR0g4?=
 =?utf-8?B?ZE1Qc1FUN1dLeFcwL2lZZVg5L0k0SkNralFSaDBUQ0ZZU3JhNGVXS2taZU5v?=
 =?utf-8?B?NDFMdzh1aEFNRGZPQTlWZEttejQreDZZenphbGxZVGxxVFMzQkpnY2E1eFNx?=
 =?utf-8?B?WWhLS0kzOUZaWi9SMEVYa2ZNM0RzUXJnVTVPN3hjcE14QjA1WUpSWnRmMUlz?=
 =?utf-8?B?b2NVdDh1eU4yV09vNFZ0ei8veEpBZGgvZ1RTWThzTUJvQ3ZzSkZHUkczc29l?=
 =?utf-8?B?alg3WHFmQ3gzRGVUUE9ITUlVOGRVYkhzS29PMmE4TXlRWk01cW1MN09ac2h5?=
 =?utf-8?B?SmFmUUQxUFhTMExQRVlQYXpMR0lsb3RoLzdrbUxocWwrczlHREtKejE1YXdu?=
 =?utf-8?B?QWRvTnpLUytzOWdYN0tzYmxDNTFJTHcwcTI1WE9rOCtlZnYwN0lDa0xiRVZT?=
 =?utf-8?B?VkdJZDY3dVZZejJKanY2Uy9ybkR1TU16OWpDSVl5VkNJWTY1YUxsTjRIQlRR?=
 =?utf-8?B?ZVA4Tk9OY3NjaG0rZFBtZEZwT2JySms3NklRNE1LTmpoNUZHK2RFZU11d0ZM?=
 =?utf-8?Q?rMoeVhbDtUXk+qTKs813rzzLYffAGO/o?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF3DF8BD4D5.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFFZZzhXcHZZYWoxbkh4bG8vUWY4Zm9TUndKZVErTENSSDQ2QWVYUlhlbVJo?=
 =?utf-8?B?S2hKTHduV1dKaFFvK2ZWYjJ0SzZMbjdRTVo1ajMxbTdCdnRVWW4rK0NkNFhK?=
 =?utf-8?B?Yzh4ekc4dlRqOG5mcjJwRE1Sa3BVNUhCZWhUMUE5Q0ZEdmdWZGhhMXB6N2t2?=
 =?utf-8?B?K1pPOVdwcGplUGFjcEhXZ3Q1TE5pZk15WEVoVmVZdG5HbjVUTnBVVjJCR0c0?=
 =?utf-8?B?MDBEYWxLQytXWXdWSEY3V1lxdlp5RlJ4SXhpUi9qS3VhQzl1cTE0WENMT0xr?=
 =?utf-8?B?eUFEVGMxUko3WnFxUkRGK3dCRTZQNXB5Wldtc0p0RDJ6SUFXekZDN2lKanZN?=
 =?utf-8?B?bjBMeFM4c2x4T3VWRXRiN3FoRkkvKzNIK0p4ZjdBbmVpMC8vVGQ2R0xiN3RO?=
 =?utf-8?B?aWF6MHBGcEtyeWpuVHIxRlhLcERxZ2tDZmpqcmxJdjhQR25RNG5aa0FYOUFV?=
 =?utf-8?B?Um41a0t3VU83dm5jN0FQdjAxT3U2aE0zU2pUcWNPMWk0OGVMMVI4ZGV4RzdB?=
 =?utf-8?B?NDB2ekYxdEFVRmVxN2x0QVpUZjhXd0k2NXZpU2RkdHZLdHJlbWdwUHJNbk85?=
 =?utf-8?B?TGpFWjB2aldLZ0ROSE9vbmY2OUlhamFSTnRRZjRiRXRSSTI2bWgrc3h1REow?=
 =?utf-8?B?SjJSWERzMkQ2S0x6Y3QzOWJ4d1huQlBYenNFTXlSZDJEUjh0dHIxM29mMmNF?=
 =?utf-8?B?VzhNMzZnNmZTMGF4dktDS2JicVdKZDVOdUlQclkwOUZlenBGZ1MxWlYyQmt3?=
 =?utf-8?B?MytMeHJ6S0F6c0k5V0lrU3hBVCt3a0thRkZHM2lmckVZb1NPazMzMnlKN1ZO?=
 =?utf-8?B?bjcrOHl1NGhzMGUwRnNVMGJjVVA2ekVCN0lrcE1DTWd0bUo3SjRkWUFrb0xB?=
 =?utf-8?B?aEdoK3ZzemRPbDVzN1BRRUltT3laR1U3SjNLZExaejNPS3RwUDQvZC96SDFP?=
 =?utf-8?B?Z0ZpUUlxV0QreEJtVlRGcU82N2FXRDFNRFZRRlJrUGZHejF5Z0wvMHk0Y2J4?=
 =?utf-8?B?VWNGSEE4U1RaRXo0WmNIdWdvNkluQjh4RkhmWU1oRTY2UkFOOVV2S01pb28x?=
 =?utf-8?B?bFZOR3BVQzlOV3RnTnA2NmRlSm9rbFdLRWY4bFFLRUk3WUllOHJiTEdIZzd0?=
 =?utf-8?B?MnU2QURPWnl2Y0Y4djNFbjFPYnlBZlJobWxHOHpKTVR3TDFXb0F5TFBlK1hS?=
 =?utf-8?B?ejBLWTM3Ny9Oa3ZHczdLYVRTTDBLaFJHY2VuQnQ5ZWdiSlJjYlVFai9oNWhk?=
 =?utf-8?B?RnRTbEljSUVzWFlYNDAxdGtDaThyajFqRVYvWjdDYlpqWlp1ai9jQ3BGbW4x?=
 =?utf-8?B?VW41RThsTTRtTHFNQjlMYk9ZdmdDNlJpNytRVW5neU5rSG5yU2hDZjdsMzk3?=
 =?utf-8?B?cGk1dnlyNVFjNytKT3pva3UzS0RDUVpOT1ZwOVlNc3VWN1Nkem56MTJpdTN5?=
 =?utf-8?B?c2l2UlQwMDhuZWJ1bVl0MDhwVzlWNVhQVVFPdUNvZTFwN3FGbUZZUTJITksx?=
 =?utf-8?B?TU1IYi9EUVZGREdLNnVLOHpPNXQxZVBCblN1OHowYXVvZitZK1RjNE92d3Zv?=
 =?utf-8?B?Wms1UDl3ZUZWeXNlcDJPZ2tJZi81OUNvcGJ0bHE5d3Bya0QzZlRqMHpIVUlh?=
 =?utf-8?B?OWFtOEx2eWxTVUtyMTBNQTdwSlRXZVlmeDluVnRTY3ZCSWoyYko0R1ZDR3Uz?=
 =?utf-8?B?VDdPeFdvdkRtdmR1blh1MU5zd3Nia05paEZpVEs1TXVNelpQWVQydmVMUXBS?=
 =?utf-8?B?WFdEN0Y2Y2NoUS8rbklOanRUcjUxblpPN1JWTjlBNGtLZkRKdWZ1TE9MUFRh?=
 =?utf-8?B?MlloVWFFcDA5WWVEejlOaS9Oa2FFZ3ZwbG8xN3lpQ0NPaXMxTmlzRDZkVlli?=
 =?utf-8?B?T2VCL0Uzdm9LK2paaFZRME1DMm5XM2dpNnBibGpMZFZNVVVBTzJ6c2FGRmdi?=
 =?utf-8?B?OUh5M2ErWVZPdTZsWENHeFJDc1ZlU25aNWx1UnQ1c0R4Snd4VjMyQ3Y0ampK?=
 =?utf-8?B?UVpCQzAzTnVncCs4RzBiejA0Z2s2WEd0TnJkYWNvSVZBdDljN1dEOXloZGJr?=
 =?utf-8?B?VW52MTVSZldhSkRtL3o1cXE2K0FCcEtXakR6TW1Bb2U3ellxeDdSK0lvekhL?=
 =?utf-8?Q?lMbW6CrQEKdRNBw3GSQVGDuRN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <166CC09E87489A4DA62B442DBE5917B4@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF3DF8BD4D5.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae33fd8-b194-4cf9-a1c9-08ddb7e65edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 14:57:01.8148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFoPCeXBc/S95eoEmT4UTrH+Kvwlm9b6g7Gt2VFnhqTU3yZE+hN+TPYK8xYF84KeaBtwWrfkHstIoABZWx7Rsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3553

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNCkFkZCB0aGUgU2kz
NDc0IEkyQyBQb3dlciBTb3VyY2luZyBFcXVpcG1lbnQgY29udHJvbGxlciBkZXZpY2UgdHJlZQ0K
YmluZGluZ3MgZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViaWsgPHBp
b3RyLmt1YmlrQGFkdHJhbi5jb20+DQpSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KUmV2aWV3ZWQtYnk6IEtvcnkgTWFpbmNl
bnQgPGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb20+DQoNCi0tLQ0KIC4uLi9iaW5kaW5ncy9uZXQv
cHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sICB8IDE0NCArKysrKysrKysrKysrKysrKysNCiAx
IGZpbGUgY2hhbmdlZCwgMTQ0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9wc2UtcGQvc2t5d29ya3Msc2kzNDc0
LnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9u
ZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9wc2UtcGQvc2t5d29ya3Msc2kzNDc0LnlhbWwNCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLmVkZDM2YTQzYTM4Nw0KLS0tIC9kZXYvbnVsbA0K
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9wc2UtcGQvc2t5d29y
a3Msc2kzNDc0LnlhbWwNCkBAIC0wLDAgKzEsMTQ0IEBADQorIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQorJVlBTUwgMS4yDQorLS0tDQor
JGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9uZXQvcHNlLXBkL3NreXdvcmtzLHNp
MzQ3NC55YW1sIw0KKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMv
Y29yZS55YW1sIw0KKw0KK3RpdGxlOiBTa3l3b3JrcyBTaTM0NzQgUG93ZXIgU291cmNpbmcgRXF1
aXBtZW50IGNvbnRyb2xsZXINCisNCittYWludGFpbmVyczoNCisgIC0gUGlvdHIgS3ViaWsgPHBp
b3RyLmt1YmlrQGFkdHJhbi5jb20+DQorDQorYWxsT2Y6DQorICAtICRyZWY6IHBzZS1jb250cm9s
bGVyLnlhbWwjDQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGVudW06DQor
ICAgICAgLSBza3l3b3JrcyxzaTM0NzQNCisNCisgIHJlZzoNCisgICAgbWF4SXRlbXM6IDINCisN
CisgIHJlZy1uYW1lczoNCisgICAgaXRlbXM6DQorICAgICAgLSBjb25zdDogbWFpbg0KKyAgICAg
IC0gY29uc3Q6IHNlY29uZGFyeQ0KKw0KKyAgY2hhbm5lbHM6DQorICAgIGRlc2NyaXB0aW9uOiBU
aGUgU2kzNDc0IGlzIGEgc2luZ2xlLWNoaXAgUG9FIFBTRSBjb250cm9sbGVyIG1hbmFnaW5nDQor
ICAgICAgOCBwaHlzaWNhbCBwb3dlciBkZWxpdmVyeSBjaGFubmVscy4gSW50ZXJuYWxseSwgaXQn
cyBzdHJ1Y3R1cmVkDQorICAgICAgaW50byB0d28gbG9naWNhbCAiUXVhZHMiLg0KKyAgICAgIFF1
YWQgMCBNYW5hZ2VzIHBoeXNpY2FsIGNoYW5uZWxzICgncG9ydHMnIGluIGRhdGFzaGVldCkgMCwg
MSwgMiwgMw0KKyAgICAgIFF1YWQgMSBNYW5hZ2VzIHBoeXNpY2FsIGNoYW5uZWxzICgncG9ydHMn
IGluIGRhdGFzaGVldCkgNCwgNSwgNiwgNy4NCisNCisgICAgdHlwZTogb2JqZWN0DQorICAgIGFk
ZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KKyAgICBwcm9wZXJ0aWVzOg0KKyAgICAgICIj
YWRkcmVzcy1jZWxscyI6DQorICAgICAgICBjb25zdDogMQ0KKw0KKyAgICAgICIjc2l6ZS1jZWxs
cyI6DQorICAgICAgICBjb25zdDogMA0KKw0KKyAgICBwYXR0ZXJuUHJvcGVydGllczoNCisgICAg
ICAnXmNoYW5uZWxAWzAtN10kJzoNCisgICAgICAgIHR5cGU6IG9iamVjdA0KKyAgICAgICAgYWRk
aXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQorDQorICAgICAgICBwcm9wZXJ0aWVzOg0KKyAgICAg
ICAgICByZWc6DQorICAgICAgICAgICAgbWF4SXRlbXM6IDENCisNCisgICAgICAgIHJlcXVpcmVk
Og0KKyAgICAgICAgICAtIHJlZw0KKw0KKyAgICByZXF1aXJlZDoNCisgICAgICAtICIjYWRkcmVz
cy1jZWxscyINCisgICAgICAtICIjc2l6ZS1jZWxscyINCisNCityZXF1aXJlZDoNCisgIC0gY29t
cGF0aWJsZQ0KKyAgLSByZWcNCisgIC0gcHNlLXBpcw0KKw0KK3VuZXZhbHVhdGVkUHJvcGVydGll
czogZmFsc2UNCisNCitleGFtcGxlczoNCisgIC0gfA0KKyAgICBpMmMgew0KKyAgICAgICNhZGRy
ZXNzLWNlbGxzID0gPDE+Ow0KKyAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KKw0KKyAgICAgIGV0
aGVybmV0LXBzZUAyNiB7DQorICAgICAgICBjb21wYXRpYmxlID0gInNreXdvcmtzLHNpMzQ3NCI7
DQorICAgICAgICByZWctbmFtZXMgPSAibWFpbiIsICJzZWNvbmRhcnkiOw0KKyAgICAgICAgcmVn
ID0gPDB4MjY+LCA8MHgyNz47DQorDQorICAgICAgICBjaGFubmVscyB7DQorICAgICAgICAgICNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KKyAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCisgICAg
ICAgICAgcGh5czBfMDogY2hhbm5lbEAwIHsNCisgICAgICAgICAgICByZWcgPSA8MD47DQorICAg
ICAgICAgIH07DQorICAgICAgICAgIHBoeXMwXzE6IGNoYW5uZWxAMSB7DQorICAgICAgICAgICAg
cmVnID0gPDE+Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgICBwaHlzMF8yOiBjaGFubmVsQDIg
ew0KKyAgICAgICAgICAgIHJlZyA9IDwyPjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcGh5
czBfMzogY2hhbm5lbEAzIHsNCisgICAgICAgICAgICByZWcgPSA8Mz47DQorICAgICAgICAgIH07
DQorICAgICAgICAgIHBoeXMwXzQ6IGNoYW5uZWxANCB7DQorICAgICAgICAgICAgcmVnID0gPDQ+
Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgICBwaHlzMF81OiBjaGFubmVsQDUgew0KKyAgICAg
ICAgICAgIHJlZyA9IDw1PjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcGh5czBfNjogY2hh
bm5lbEA2IHsNCisgICAgICAgICAgICByZWcgPSA8Nj47DQorICAgICAgICAgIH07DQorICAgICAg
ICAgIHBoeXMwXzc6IGNoYW5uZWxANyB7DQorICAgICAgICAgICAgcmVnID0gPDc+Ow0KKyAgICAg
ICAgICB9Ow0KKyAgICAgICAgfTsNCisgICAgICAgIHBzZS1waXMgew0KKyAgICAgICAgICAjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCisgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQorICAgICAg
ICAgIHBzZV9waTA6IHBzZS1waUAwIHsNCisgICAgICAgICAgICByZWcgPSA8MD47DQorICAgICAg
ICAgICAgI3BzZS1jZWxscyA9IDwwPjsNCisgICAgICAgICAgICBwYWlyc2V0LW5hbWVzID0gImFs
dGVybmF0aXZlLWEiLCAiYWx0ZXJuYXRpdmUtYiI7DQorICAgICAgICAgICAgcGFpcnNldHMgPSA8
JnBoeXMwXzA+LCA8JnBoeXMwXzE+Ow0KKyAgICAgICAgICAgIHBvbGFyaXR5LXN1cHBvcnRlZCA9
ICJNREktWCIsICJTIjsNCisgICAgICAgICAgICB2cHdyLXN1cHBseSA9IDwmcmVnX3BzZT47DQor
ICAgICAgICAgIH07DQorICAgICAgICAgIHBzZV9waTE6IHBzZS1waUAxIHsNCisgICAgICAgICAg
ICByZWcgPSA8MT47DQorICAgICAgICAgICAgI3BzZS1jZWxscyA9IDwwPjsNCisgICAgICAgICAg
ICBwYWlyc2V0LW5hbWVzID0gImFsdGVybmF0aXZlLWEiLCAiYWx0ZXJuYXRpdmUtYiI7DQorICAg
ICAgICAgICAgcGFpcnNldHMgPSA8JnBoeXMwXzI+LCA8JnBoeXMwXzM+Ow0KKyAgICAgICAgICAg
IHBvbGFyaXR5LXN1cHBvcnRlZCA9ICJNREktWCIsICJTIjsNCisgICAgICAgICAgICB2cHdyLXN1
cHBseSA9IDwmcmVnX3BzZT47DQorICAgICAgICAgIH07DQorICAgICAgICAgIHBzZV9waTI6IHBz
ZS1waUAyIHsNCisgICAgICAgICAgICByZWcgPSA8Mj47DQorICAgICAgICAgICAgI3BzZS1jZWxs
cyA9IDwwPjsNCisgICAgICAgICAgICBwYWlyc2V0LW5hbWVzID0gImFsdGVybmF0aXZlLWEiLCAi
YWx0ZXJuYXRpdmUtYiI7DQorICAgICAgICAgICAgcGFpcnNldHMgPSA8JnBoeXMwXzQ+LCA8JnBo
eXMwXzU+Ow0KKyAgICAgICAgICAgIHBvbGFyaXR5LXN1cHBvcnRlZCA9ICJNREktWCIsICJTIjsN
CisgICAgICAgICAgICB2cHdyLXN1cHBseSA9IDwmcmVnX3BzZT47DQorICAgICAgICAgIH07DQor
ICAgICAgICAgIHBzZV9waTM6IHBzZS1waUAzIHsNCisgICAgICAgICAgICByZWcgPSA8Mz47DQor
ICAgICAgICAgICAgI3BzZS1jZWxscyA9IDwwPjsNCisgICAgICAgICAgICBwYWlyc2V0LW5hbWVz
ID0gImFsdGVybmF0aXZlLWEiLCAiYWx0ZXJuYXRpdmUtYiI7DQorICAgICAgICAgICAgcGFpcnNl
dHMgPSA8JnBoeXMwXzY+LCA8JnBoeXMwXzc+Ow0KKyAgICAgICAgICAgIHBvbGFyaXR5LXN1cHBv
cnRlZCA9ICJNREktWCIsICJTIjsNCisgICAgICAgICAgICB2cHdyLXN1cHBseSA9IDwmcmVnX3Bz
ZT47DQorICAgICAgICAgIH07DQorICAgICAgICB9Ow0KKyAgICAgIH07DQorICAgIH07DQotLSAN
CjIuNDMuMA0KDQo=

