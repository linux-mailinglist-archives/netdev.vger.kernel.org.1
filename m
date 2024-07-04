Return-Path: <netdev+bounces-109262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDE6927988
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC449B26123
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873D1B29D9;
	Thu,  4 Jul 2024 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aQ/LGZYZ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2102.outbound.protection.outlook.com [40.107.20.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEF51B29AE;
	Thu,  4 Jul 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105440; cv=fail; b=EKvj1gOsq/14kN4FqmTuHlJWLypLJcUCP438jDU5Pq97BppMg7ZdlWCoy4DFUNm2JdW05w5waBkw0x03JzW1ai042h7gPAXtr/QRHsRgAmvYB/URk3yTSPhQ6LZk9rGK5CGMqpI9iunPWm1IE8yD/2oyx4SIPU6sGI2BI33XKiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105440; c=relaxed/simple;
	bh=97GeDKeK+xEHoScDnbbTVgW8llwgFM39N/QRBVPmqq4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XtZx84BqdPBoL0f+Sd5eMzlKtIpRwE1NvgEstRtCxceYKErSEX4aSm3Rtq0M7s0HCRSe9OehzFO8MfIIvREfLoLX3cx0xuv/m9s/vbaZLFb1ffrKx5UGNhO/JU3ykf/W0Omxzqecb28fJBC2mwyTQdv/IJE6Dg021RtrC6yvMhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=aQ/LGZYZ; arc=fail smtp.client-ip=40.107.20.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCHmIaSQwt6yWYrWDXet7W8qUNKzmxNLJ70TmtGJdpDkWo6h0D9tQAaC/dw7QaAilopcY8DMHUAyUMfTYrASYWbGqSpHeWMeX8N5cVkDgey5xVw9VYMcfMroTCTCsbtmtc20093UQ86N16pVeZizcYYNHJqITvOOhDJy6e3iRI3I0fLVNU1JO8ugBxbNlYaKghHaN+78OVVJWSH4O67StClkWKTRrbPCoaiq3CdrlCaaVu30VVASu+RD9iK4TOplFkvtWUuMa0g/KO1ccTXrUBIzn9gnlhhZK59y+wqHh7VBmIN0oYRdDmlzkAosI7Vzk49ZRjBOFknkAdvzB7Of3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVfG+wQyRamdJoCgBA74E+TfSzjOFox9bjlnskKXf0I=;
 b=hh6OOU0ExvH5zYi66d0UFLdgY/DzUVInpNgluGS+a4uov6SPeYLm7Mq/TCpslppCToup0zRaiY8NbTq1XbaKl1wxsbKQfAZxpFqe/BvNzRkggk88YPgS0gNEhYe81lan+ua8UBKr1iuFuGEXgS/TqQQaJG1gM4ze+1lOcWPAT3BS3s2c8dLqIK2TixrjQqn564HZsQ6rIMCf7oKIPG7EUkMqu9vvCCUmdVF6Mf6kZJ2oGjUSzsf5xRhb2S1JcxtsGSM4zSg632/vefisf2ziXPbcKkw0+GAfC2OlohB/gg4iv3RZWyG84LhaJgQ38n0x+ZVU3G2n/pKfHscM1fhxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVfG+wQyRamdJoCgBA74E+TfSzjOFox9bjlnskKXf0I=;
 b=aQ/LGZYZKgw+homNgmAEyzfbACZwEWt2DES6kzBadiEyJVcl+gWPfVAqt5qFyYtxzWtD2SP4wPpMdt2+HIMZdvQq7W8R1dQNOjZdR85vkCNanrj4SkcTWIBfBuXMxN5OdtuZIGW8WjfwDHs/RKLM+d8Jc7RJyG5mudqOyzH8dGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI2PR04MB10714.eurprd04.prod.outlook.com (2603:10a6:800:26d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 15:03:47 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%5]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 15:03:47 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jul 2024 17:03:23 +0200
Subject: [PATCH v7 5/5] arm64: dts: add description for solidrun cn9132
 cex7 module and clearfog board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-cn9130-som-v7-5-eea606ba5faa@solid-run.com>
References: <20240704-cn9130-som-v7-0-eea606ba5faa@solid-run.com>
In-Reply-To: <20240704-cn9130-som-v7-0-eea606ba5faa@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI2PR04MB10714:EE_
X-MS-Office365-Filtering-Correlation-Id: ddad2cd7-e4eb-4787-a58d-08dc9c3a8143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2I4QWhIWi9NOTcycDQ0RGZ1bzU0QkV4dkVQR3BETHJkVGdKeEFwd1h4U0g4?=
 =?utf-8?B?Vy9xSzNnd2hpRE1SQVZmVWRMUU5jMGJUb1UrUUFJSU9zTXhXVXB5OTNGOEpO?=
 =?utf-8?B?ZEhHN2ZzN3RTREZIeXZBR1BWckJMTjJEc2lqM09DZEtVWUFPeHlhMW5zU3lQ?=
 =?utf-8?B?cFZDYXhSeDhnTmVnc1RmR3JWTThTTmFraklOQzVtb3VmdHZ4ZUlvZ1pzMHhx?=
 =?utf-8?B?ZHg5UE1mWUpJZXVVTW9FQ2hsWVFUTGFCV2R1M3RycjROU1dldnJIa2lqVVg2?=
 =?utf-8?B?RkVhRUNXOGhTU1ZGamtDbzdJdmlsUGFPYThuSXE2Q0hOOTNEU2hQRmVTTnhi?=
 =?utf-8?B?UjZ0SHdxd2kxM2ZUY01ubThXVUsvUWJILzNSVkoxb20yeXpKRzRZRmtKNDRw?=
 =?utf-8?B?azl1R1V1dTdvUlFnUnk0L3NxZWEwTkgyVC9kbFlvWmJCUXhET0ZnRHVRcHJ3?=
 =?utf-8?B?MHBEbFF1bllNNXdsd0hjU3VIVnR3bnQwSUxXSHVFL1c5YkNITlBJaWdIQU4v?=
 =?utf-8?B?eUNSNWdCVG96N0F4ejM2cVo5M0MwdkhoK2VWd0FMZWJjZEYzaU9rR3hHc0ZT?=
 =?utf-8?B?Zlh0a2xqZzZkcXlkcU03YisxbkgzTzVXWHhPNWhiRnNISVRXejZvN2p5S0dK?=
 =?utf-8?B?Vm9hbjBtL2hxanJtK2ZFNkNFLzVyNTNYNFJwaUluR0RSR21ocGd6Z09IR2RS?=
 =?utf-8?B?dFpBaWNVUDVsMnQrV0c1RldBS0xnVGVYWTRBOHpndTVZQVlyY3pLZXlvQ3A5?=
 =?utf-8?B?WG5la2Z4NnpQQkdBUFNoT1daRXdTOVB6bzJuUlNKeFVMUmJYaERFK3N0aG5Z?=
 =?utf-8?B?OEFPZG80Q2tnbzBlM3diNXk5SCtFTG50cHA4VWttNEFjTkdaNHBzQWxEcTh4?=
 =?utf-8?B?TWZwSVJDL2JIUEdseWIvMFdjRkUrVkQxdEY1MnVVUzltcWJ4Y1V5clpBdXJB?=
 =?utf-8?B?UmpVVWNtRFJZWHBhRnZ0cCtXS3o0TWI3OWVPdGp5SUhRczRFTkFqaHVnZERi?=
 =?utf-8?B?dEh2Q0NKNU12OVl0bWV0V1Q5MzRGaVdIT3AxbDhaSlI2TUk3cmJoSlVvUTVC?=
 =?utf-8?B?T1JIcEh2U0FDRWJOTTVYQmNuM3gxV0ZBdjVEdmdyd1pyU1pxQUJ3eFhLcHc1?=
 =?utf-8?B?Z1hYZzBZNGg0ZjZGc2M3bzdPNmx4U3FkMVdGcVc0VGg1em9YdFR6M2M4eGQv?=
 =?utf-8?B?WDlQSDFIWWxaT0FJSHZib1BNWWNUamh0Z1BidGdGbXNlTVMzNXBDNDF0cEp6?=
 =?utf-8?B?UHhZZlhid1U2V09udGpDRjJmM1FQTzdNcG9melB1NStyeW9LT0kzQ1dwSEtk?=
 =?utf-8?B?bmFmSi9QVTMxb3k5U0pCTTdOZWlFaU1ncVhmZ3Bra043UTlKZHJPcTlsYjFi?=
 =?utf-8?B?QkNCZlVsNndVNkFuMk1JQTRkVFN4UGpoek1mL05HN0YrZGxWWmYvbmF3N0Vx?=
 =?utf-8?B?MGVuOTNwWUdtUlczUXJJT293Vy9lNTNoTE1xZVRPNWpzUy9aMEd3ZjdXMjBm?=
 =?utf-8?B?ZzN2WmJCbUJCNW1KMnJGL1pTa2RqeDQzYW9MUHRWQkR0Z0h0TDY1aXkxTUpr?=
 =?utf-8?B?TUhZTzU5Z2l3NFBxTXNDOUpXOHc4cnI3NmQzTjV5b2RrMmlHM0QzcmhNdWpN?=
 =?utf-8?B?aWxNME9xM2NSYlY4UkYycG1GVDBQcDlFSGZlb1prNThoRmhXTlFkTkluYjR1?=
 =?utf-8?B?eDBiYmM2TTk0NUdyR0NzZWdZTnhWS3dlSmxCQzI2NHBuaGNJakxSOWJPWFJw?=
 =?utf-8?B?SnFFKzB1R3FvZjBjc2N4N3lKVjlyazZncFBsc0hVY1EyeTh3N2RyTWFNb2Jp?=
 =?utf-8?B?MHpZeHdMc1JUVjVHcmtKc2ZnOTFSMXJYWXZtd3F2c2JMbENwL0VEV2dLWXY4?=
 =?utf-8?B?clROMkx3VVVvbG5oLzBmZjJOd1UxNTN4ak0zc1V1WWFrTkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjdMWFpOUUlsNkZ1YlMyRTBsbkNmT1dtWWZ3OGxUdjdneGtHVGZVQWN2Nks0?=
 =?utf-8?B?Mi95VFJyWi9FRVlKZWRJZUQ4bUNNeituTHAyUHVxbmNYbkFtdzZaSGhvZFVj?=
 =?utf-8?B?VUVnWEpKNE1LMUFlZklVSXkwQldmR3hFaHVtMEpRN2hoWDc2ZFh4U3BGZHl5?=
 =?utf-8?B?VHRXNktYYTlIb0dLQXBWV2RjcFlBcUdnWFo2MDRDWHJ0bHNpOHQ4aXlmMEVs?=
 =?utf-8?B?ZlNJWEloK1Y5bHovZjN3TjRDNGRLQ296ek1nYTh4UytTNkVPSENwTmdrSElj?=
 =?utf-8?B?aDU1YTROU0VDNmJmSkxaOUFZSy8wcEt3aVNpSmtNdFJrWGhKbW5kUHZWZXZx?=
 =?utf-8?B?T1l0bGdpdk1MS2RxU1BEcE5PZzBrUm9TMGFpdVFnMS9SN0t0NzRndklzSTFw?=
 =?utf-8?B?TDhaNVBHRTZDSE5iNHpJV1JCaDAvOTIvejJ3a1o4SlowWHNsdzRSRkxXMkJU?=
 =?utf-8?B?OFlsNEE0YzRrNDBiVzZpenZpaDJZWGJqZ1RDN0R2TTNzaFJFS2RkSHp5K3ZZ?=
 =?utf-8?B?N2VVMExRemdwRUQ4QkExbDM5aXk5WWFVYSs3YzBPak8xOHpYL251UFcrNEw3?=
 =?utf-8?B?OXcrQ29TMG9tOGN4OTZWNkxCeUxLNTI4K2M1RWVaNGl2cVZQV0pVOFpQbWg3?=
 =?utf-8?B?TkJFS2ZxZ25UYUd6cXFQKzRuSm1vWkhnb2E1RWg2c0UvZFpQSnhUWkFSbmI2?=
 =?utf-8?B?a1lzQ1JzbHVqZlNJWCtQMGZOamViejlVbVEvSlNVWng2cndLYzk1SER5bUp2?=
 =?utf-8?B?aEJxWlA1OHFwKzdhSkJ3azMwZ01PelhzQXZpREJReXlJcjg2dVYvZzMvQ0Q5?=
 =?utf-8?B?WHhrOG5KR0VCQ1JGZEV4UHphMmZCWlBaRGRlSjBmbW0va3NPVmNZa2UxdHJL?=
 =?utf-8?B?K08vRjhnTzB0S2F0U1JZd1FubUpPNWQ1dWJ4QzhCdWgvTWRCTDl5R2c5V0FW?=
 =?utf-8?B?b1B0c29laUNRekhkaXVmeS9yS2lsOGZmZFdjcDJna2wvWmhwUUQ0bFZETXVF?=
 =?utf-8?B?OTJmd0tHSCs3S0s5R1BNKy9tQ0EyZFM5bHpDdEw3R28zdVVDZnpWdDJER2pT?=
 =?utf-8?B?eUdBekRxSXVtVk9hR1NDd0pvQUE5WXUxUksrVUY5VDY3TFN1TExFbXZ3Y3ZJ?=
 =?utf-8?B?VFIxU1hMdVpBcWpZTXZ1VW5EcGJQbStIOEdnNG02NjA4V2dBeVMvQkxDdU5v?=
 =?utf-8?B?L2wreitMNVpCbTBwUklGS2J5Z0dvajVJYWljM1VkaWlwZ1RvdEIxMHgwKzFB?=
 =?utf-8?B?anZJRVd2REE2R0FZdnhxNi9IUEN2QWozcWg0ZG5BeWp2TDg3cFlGR1U5c0xY?=
 =?utf-8?B?ODZHWmNPRWhkWmJIWHZ0YUovVGRadXRBblFhWmFPOURhZENjNXRVaS81cE0x?=
 =?utf-8?B?T2dpY09EcE1QTGV5TVFEUW0wRXBGMWxiNEtaUnlVSG10b0NBRUxsVmxzd1Ux?=
 =?utf-8?B?QTVYRzRYbngwL05YQlFmTkxaTlVkdnJmdkNJMTNPZGxVMkoxY1J5c0N3WHlh?=
 =?utf-8?B?SEZPMXBXSE1hNlpkbHd2ZXVJakRpSlgyalROMGhpQndTckVmUStqQnRkM1Vs?=
 =?utf-8?B?eDhIVDdLb01heGhEUFNGOGZaNmV2TDE2cXZnK3VIZW5GcFVjZmNuT2FpbXVG?=
 =?utf-8?B?NjFMTGc5ODkrQ0RHME1qYTJPb09lQXFrNFB0ZThldUlEeUtlaG1md0lpODUy?=
 =?utf-8?B?c1YvRVBOQzdSSHU5Z2Racmc1bDQrYnRlNUpmUTJmZUEwWVE0VnBhdWZ6b3ZS?=
 =?utf-8?B?WHpzeHdhUmRDSGdzczhnOWw3Yys4bDRLWUFLeGF6c3NJTnFTUGlPVWZHT2lw?=
 =?utf-8?B?OFMycnlhTzVHMlJ4ZFYzYkV5MkdiSUFUYW8wRjJDMVRaRGZ5dUJ2TERWU2Ny?=
 =?utf-8?B?QTUydkplUnBqYU81em5mWnN3QmpqTGhSRHE2L24xdFpVUnNTUjNKSUtaTEti?=
 =?utf-8?B?WGhqYmNtSjY3RlprOHRkK3Q5Y1ZQSi9CdlByNlh3Tk82Y1VMamkya3dJaWNr?=
 =?utf-8?B?a2RiZElBamNtUzF4Ukc2RDNGOEU0d2MzV05rYkFqN3FMK2tLZ1BmVzhIZ3NY?=
 =?utf-8?B?anNpTWxsTXF1ZzlvZzFDWjNGQ0h3MkZYWWVOR3FuM05GanJvSzZBVTFOdHlp?=
 =?utf-8?Q?gbiOU/oh3w5vhj/9nimKPIACu?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddad2cd7-e4eb-4787-a58d-08dc9c3a8143
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 15:03:47.1319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rp+JBM8dMdiZNf7AU2aNJexgjoc+/pD/y41eDe+hn4k2oVzlbb5UDdl22FkratUK8z4pQrNhdZ6u3ODEF6N2WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10714

Add description for the SolidRun CN9132 COM-Express Type 7 module, and
the Clearfog evaluation board.

The COM-Express module includes:
- CN9130 SoC
- 2x 88F8215 Southbridges
- eMMC
- SPI Flash
- DDR-4 SODIMM connector
- 1GBase-T Ethernet PHY

The Clearfog Evaluation board provides:
- 1x 10Gbps SFP+
- 2x 5GBase-T RJ45
- 4x 1GBase-T RJ45 on DSA switch with 2.5Gbps cpu link
- 1x full-size PCI-E x4
- 2x M.2 with PCI-E x1
- 1x M.2 with PCI-E x2
- 2x M.2 with PCI-E x1 and USB-2.0
- 1x M.2 with USB-2.0, USB-3.0 and 2x SIM slots
- 1x mini-PCI-E x1
- 2x SATA (Laptop-Style connector with data and power)
- 3x USB-3.0 Type-A
- microSD slot

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/Makefile            |   1 +
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts | 673 ++++++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi | 712 ++++++++++++++++++++++++
 3 files changed, 1386 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 16f9d7156d9f..ce751b5028e2 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -31,3 +31,4 @@ dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-base.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-pro.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9131-cf-solidwan.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9132-clearfog.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
new file mode 100644
index 000000000000..0f53745a6fa0
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
@@ -0,0 +1,673 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun CN9132 Clearfog.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "cn9130.dtsi"
+#include "cn9132-sr-cex7.dtsi"
+
+/ {
+	model = "SolidRun CN9132 Clearfog";
+	compatible = "solidrun,cn9132-clearfog",
+		     "solidrun,cn9132-sr-cex7", "marvell,cn9130";
+
+	aliases {
+		ethernet1 = &cp0_eth2;
+		ethernet2 = &cp0_eth0;
+		ethernet3 = &cp2_eth0;
+		ethernet4 = &cp1_eth0;
+		i2c7 = &carrier_mpcie_i2c;
+		i2c8 = &carrier_ptp_i2c;
+		mmc1 = &cp0_sdhci0;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_wake0_pins>;
+
+		button-0 {
+			label = "SW2";
+			gpios = <&cp1_gpio2 8 GPIO_ACTIVE_LOW>;
+			linux,can-disable;
+			linux,code = <BTN_2>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_batlow_pins &cp2_rsvd4_pins>;
+
+		/* LED11 */
+		led-io-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DISK;
+			function-enumerator = <0>;
+			default-state = "off";
+			gpios = <&cp1_gpio1 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* LED12 */
+		led-io-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DISK;
+			function-enumerator = <1>;
+			default-state = "off";
+			gpios = <&cp2_gpio1 4 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	/* CON4 W_DISABLE1/W_DISABLE2 */
+	rfkill-m2-wlan {
+		compatible = "rfkill-gpio";
+		label = "m.2 wlan (CON4)";
+		radio-type = "wlan";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_10g_phy_rst_01_pins>;
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&cp1_gpio2 11 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* CON5 W_DISABLE1/W_DISABLE2 */
+	rfkill-m2-wlan {
+		compatible = "rfkill-gpio";
+		label = "m.2 wlan (CON5)";
+		radio-type = "wlan";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_10g_phy_rst_23_pins>;
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&cp1_gpio2 10 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* J21 W_DISABLE1 */
+	rfkill-m2-wwan {
+		compatible = "rfkill-gpio";
+		label = "m.2 wwan (J21)";
+		radio-type = "wwan";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp2_rsvd3_pins>;
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&cp2_gpio1 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* J21 W_DISABLE1 */
+	rfkill-m2-gnss {
+		compatible = "rfkill-gpio";
+		label = "m.2 gnss (J21)";
+		radio-type = "gps";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp2_rsvd8_pins>;
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&cp2_gpio1 8 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* J14 W_DISABLE */
+	rfkill-mpcie-wlan {
+		compatible = "rfkill-gpio";
+		label = "mpcie wlan (J14)";
+		radio-type = "wlan";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp2_rsvd2_pins>;
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&cp2_gpio1 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	sfp: sfp {
+		compatible = "sff,sfp";
+		i2c-bus = <&com_10g_sfp_i2c0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&com_10g_int0_pins>;
+		mod-def0-gpios = <&cp0_gpio1 24 GPIO_ACTIVE_LOW>;
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+&com_smbus {
+	/* This bus is also routed to STM32 BMC Microcontroller (U2) */
+
+	power-sensor@40 {
+		compatible = "ti,ina220";
+		reg = <0x40>;
+		#io-channel-cells = <1>;
+		label = "vdd_12v0";
+		shunt-resistor = <2000>;
+	};
+
+	adc@48 {
+		compatible = "ti,tla2021";
+		reg = <0x48>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* supplied by chaoskey hardware noise generator circuit */
+		channel@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&cp0_eth_phy0 {
+	/*
+	 * Configure LEDs default behaviour:
+	 * - LED[0]: link is 1000Mbps: On (yellow): 0111
+	 * - LED[1]: link/activity: On/Blink (green): 0001
+	 * - LED[2]: Off (green): 1000
+	 */
+	marvell,reg-init = <3 16 0xf000 0x0817>;
+
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			/* link */
+			reg = <0>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+
+		led@1 {
+			/* act */
+			reg = <1>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+
+		led@2 {
+			/* 1000 */
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+	};
+};
+
+/* SRDS #4 - 10GE */
+&cp0_eth0 {
+	phys = <&cp0_comphy4 0>;
+	phy-mode = "10gbase-r";
+	managed = "in-band-status";
+	sfp = <&sfp>;
+	status = "okay";
+};
+
+&cp0_eth2 {
+	phy-mode = "2500base-x";
+	phys = <&cp0_comphy5 2>;
+	status = "okay";
+
+	fixed-link {
+		speed = <2500>;
+		full-duplex;
+		pause;
+	};
+};
+
+&cp0_i2c1 {
+	/*
+	 * Both COM and Carrier Board have a PCA9547 i2c mux at 0x77.
+	 * Describe them as a single device merging each child bus.
+	 */
+
+	i2c-mux@77 {
+		i2c@0 {
+			/* Routed to Full PCIe (J4) */
+		};
+
+		i2c@1 {
+			/* Routed to USB Hub (U29) */
+		};
+
+		i2c@2 {
+			/* Routed to M.2 (CON4) */
+		};
+
+		i2c@3 {
+			/* Routed to M.2 (CON5) */
+		};
+
+		i2c@4 {
+			/* Routed to M.2 (J21) */
+		};
+
+		carrier_mpcie_i2c: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			/* Routed to mini-PCIe (J14) */
+		};
+
+		carrier_ptp_i2c: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+
+			/* Routed to various optional PTP related components */
+		};
+	};
+};
+
+&cp0_mdio {
+	ethernet-switch@4 {
+		compatible = "marvell,mv88e6085";
+		reg = <4>;
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sw_phy1: ethernet-phy@1 {
+				reg = <0x11>;
+			};
+
+			sw_phy2: ethernet-phy@2 {
+				reg = <0x12>;
+			};
+
+			sw_phy3: ethernet-phy@3 {
+				reg = <0x13>;
+			};
+
+			sw_phy4: ethernet-phy@4 {
+				reg = <0x14>;
+			};
+		};
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethernet-port@1 {
+				reg = <1>;
+				label = "lan1";
+				phy-handle = <&sw_phy1>;
+				phy-mode = "internal";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_YELLOW>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@2 {
+				reg = <2>;
+				label = "lan2";
+				phy-handle = <&sw_phy2>;
+				phy-mode = "internal";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_YELLOW>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@3 {
+				reg = <3>;
+				label = "lan3";
+				phy-handle = <&sw_phy3>;
+				phy-mode = "internal";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_YELLOW>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@4 {
+				reg = <4>;
+				label = "lan4";
+				phy-handle = <&sw_phy4>;
+				phy-mode = "internal";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_YELLOW>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@5 {
+				reg = <5>;
+				label = "cpu";
+				ethernet = <&cp0_eth2>;
+				phy-mode = "2500base-x";
+
+				fixed-link {
+					speed = <2500>;
+					full-duplex;
+					pause;
+				};
+			};
+		};
+	};
+};
+
+/* SRDS #0,#1,#2,#3 - PCIe */
+&cp0_pcie0 {
+	num-lanes = <4>;
+	phys = <&cp0_comphy0 0>, <&cp0_comphy1 0>, <&cp0_comphy2 0>, <&cp0_comphy3 0>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	/*
+	 * configure unused gpios exposed via pin headers:
+	 * - J7-10: PWRBTN
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_pwrbtn_pins>;
+};
+
+/* microSD */
+&cp0_sdhci0 {
+	pinctrl-0 = <&cp0_mmc0_pins>, <&cp0_mmc0_cd_pins>;
+	pinctrl-names = "default";
+	bus-width = <4>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&cp0_spi1 {
+	/* add CS1 */
+	pinctrl-0 = <&cp0_spi1_pins>, <&cp0_spi1_cs1_pins>;
+
+	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
+		/* read command supports max. 50MHz */
+		spi-max-frequency = <50000000>;
+	};
+};
+
+/* J38 */
+&cp0_uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_uart2_pins>;
+	status = "okay";
+};
+
+&cp0_utmi {
+	/* M.2 "CON5" swaps D+/D- */
+	swap-dx-lanes = <1>;
+};
+
+&cp1_ethernet {
+	status = "okay";
+};
+
+/* SRDS #2 - 5GE */
+&cp1_eth0 {
+	phys = <&cp1_comphy2 0>;
+	phy-mode = "5gbase-r";
+	phy = <&cp1_eth_phy0>;
+	managed = "in-band-status";
+	status = "okay";
+};
+
+/* SRDS #0,#1 - PCIe */
+&cp1_pcie0 {
+	num-lanes = <2>;
+	phys = <&cp1_comphy0 0>, <&cp1_comphy1 0>;
+	status = "okay";
+};
+
+/* SRDS #4 - PCIe */
+&cp1_pcie1 {
+	num-lanes = <1>;
+	phys = <&cp1_comphy4 1>;
+	status = "okay";
+};
+
+/* SRDS #5 - PCIe */
+&cp1_pcie2 {
+	num-lanes = <1>;
+	phys = <&cp1_comphy5 2>;
+	status = "okay";
+};
+
+&cp1_pinctrl {
+	/*
+	 * configure unused gpios exposed via pin headers:
+	 * - J7-8: RSVD16
+	 * - J7-10: THRM
+	 * - J10-1: WAKE1
+	 * - J10-2: SATA_ACT
+	 * - J10-8: THERMTRIP
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_rsvd16_pins &cp1_sata_act_pins &cp1_thrm_irq_pins>,
+		    <&cp1_thrm_trip_pins &cp1_wake1_pins>;
+};
+
+/* SRDS #3 - SATA */
+&cp1_sata0 {
+	status = "okay";
+
+	/* only port 1 is available */
+	/delete-node/ sata-port@0;
+
+	sata-port@1 {
+		phys = <&cp1_comphy3 1>;
+	};
+};
+
+&cp1_utmi {
+	/* M.2 "CON4" swaps D+/D- */
+	swap-dx-lanes = <0>;
+};
+
+&cp1_xmdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_xmdio_pins>;
+	status = "okay";
+
+	cp1_eth_phy0: ethernet-phy@8 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&com_10g_int1_pins>;
+		interrupt-parent = <&cp1_gpio2>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+&cp2_ethernet {
+	status =  "okay";
+};
+
+/* SRDS #2 - 5GE */
+&cp2_eth0 {
+	phys = <&cp2_comphy2 0>;
+	phy-mode = "5gbase-r";
+	phy = <&cp2_eth_phy0>;
+	managed = "in-band-status";
+	status = "okay";
+};
+
+&cp2_gpio1 {
+	pinctrl-names= "default";
+	pinctrl-0 = <&cp2_rsvd9_pins>;
+
+	/* J21 */
+	m2-wwan-reset-hog {
+		gpio-hog;
+		gpios = <9 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+		output-low;
+		line-name = "m2-wwan-reset";
+	};
+};
+
+/* SRDS #0 - PCIe */
+&cp2_pcie0 {
+	num-lanes = <1>;
+	phys = <&cp2_comphy0 0>;
+	status = "okay";
+};
+
+/* SRDS #4 - PCIe */
+&cp2_pcie1 {
+	num-lanes = <1>;
+	phys = <&cp2_comphy4 1>;
+	status = "okay";
+};
+
+/* SRDS #5 - PCIe */
+&cp2_pcie2 {
+	num-lanes = <1>;
+	phys = <&cp2_comphy5 2>;
+	status = "okay";
+};
+
+&cp2_pinctrl {
+	/*
+	 * configure unused gpios exposed via pin headers:
+	 * - J7-1: RSVD10
+	 * - J7-3: RSVD11
+	 * - J7-5: RSVD56
+	 * - J7-6: RSVD7
+	 * - J7-7: RSVD27
+	 * - J10-3: RSVD31
+	 * - J10-5: RSVD5
+	 * - J10-6: RSVD32
+	 * - J10-7: RSVD0
+	 * - J10-9: RSVD1
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp2_rsvd0_pins &cp2_rsvd1_pins &cp2_rsvd5_pins>,
+		    <&cp2_rsvd7_pins &cp2_rsvd10_pins &cp2_rsvd11_pins>,
+		    <&cp2_rsvd27_pins &cp2_rsvd31_pins &cp2_rsvd32_pins>,
+		    <&cp2_rsvd56_pins>;
+};
+
+/* SRDS #3 - SATA */
+&cp2_sata0 {
+	status = "okay";
+
+	/* only port 1 is available */
+	/delete-node/ sata-port@0;
+
+	sata-port@1 {
+		phys = <&cp2_comphy3 1>;
+	};
+};
+
+&cp2_xmdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp2_xmdio_pins>;
+	status = "okay";
+
+	cp2_eth_phy0: ethernet-phy@8 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&com_10g_int2_pins>;
+		interrupt-parent = <&cp2_gpio2>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi b/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
new file mode 100644
index 000000000000..afc041c1c448
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
@@ -0,0 +1,712 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/*
+ * Instantiate the first external CP115
+ */
+
+#define CP11X_NAME		cp1
+#define CP11X_BASE		f4000000
+#define CP11X_PCIEx_MEM_BASE(iface) (0xe2000000 + (iface * 0x1000000))
+#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
+#define CP11X_PCIE0_BASE	f4600000
+#define CP11X_PCIE1_BASE	f4620000
+#define CP11X_PCIE2_BASE	f4640000
+
+#include "armada-cp115.dtsi"
+
+#undef CP11X_NAME
+#undef CP11X_BASE
+#undef CP11X_PCIEx_MEM_BASE
+#undef CP11X_PCIEx_MEM_SIZE
+#undef CP11X_PCIE0_BASE
+#undef CP11X_PCIE1_BASE
+#undef CP11X_PCIE2_BASE
+
+/*
+ * Instantiate the second external CP115
+ */
+
+#define CP11X_NAME		cp2
+#define CP11X_BASE		f6000000
+#define CP11X_PCIEx_MEM_BASE(iface) (0xe5000000 + (iface * 0x1000000))
+#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
+#define CP11X_PCIE0_BASE	f6600000
+#define CP11X_PCIE1_BASE	f6620000
+#define CP11X_PCIE2_BASE	f6640000
+
+#include "armada-cp115.dtsi"
+
+#undef CP11X_NAME
+#undef CP11X_BASE
+#undef CP11X_PCIEx_MEM_BASE
+#undef CP11X_PCIEx_MEM_SIZE
+#undef CP11X_PCIE0_BASE
+#undef CP11X_PCIE1_BASE
+#undef CP11X_PCIE2_BASE
+
+/ {
+	model = "SolidRun CN9132 COM Express Type 7 Module";
+	compatible = "solidrun,cn9132-sr-cex7", "marvell,cn9130";
+
+	aliases {
+		ethernet0 = &cp0_eth1;
+		gpio3 = &cp1_gpio1;
+		gpio4 = &cp1_gpio2;
+		gpio5 = &cp2_gpio1;
+		gpio6 = &cp2_gpio2;
+		i2c0 = &cp0_i2c0;
+		i2c1 = &cp0_i2c1;
+		i2c2 = &com_clkgen_i2c;
+		i2c3 = &com_10g_led_i2c;
+		i2c4 = &com_10g_sfp_i2c0;
+		i2c5 = &com_smbus;
+		i2c6 = &com_fanctrl_i2c;
+		mmc0 = &ap_sdhci0;
+		rtc0 = &cp0_rtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 51 102 153 204 255>;
+		#cooling-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp0_fan_pwm_pins &cp0_fan_tacho_pins>;
+		pwms = <&cp0_gpio2 7 40000>;
+		interrupt-parent = <&cp0_gpio1>;
+		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	v_1_8: regulator-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	ap_vhv: regulator-ap-vhv-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "ap-vhv-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		pinctrl-0 = <&cp0_reg_ap_vhv_pins>;
+		pinctrl-names = "default";
+		gpios = <&cp0_gpio2 21 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	cp_vhv: regulator-cp-vhv-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "cp-vhv-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		pinctrl-0 = <&cp0_reg_cp_vhv_pins>;
+		pinctrl-names = "default";
+		gpios = <&cp0_gpio2 17 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&ap_pinctrl {
+	ap_mmc0_pins: ap-mmc0-pins {
+		marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3", "mpp4", "mpp5",
+					   "mpp6", "mpp7", "mpp8", "mpp9", "mpp10", "mpp12";
+		marvell,function = "sdio";
+		/*
+		 * mpp12 is emmc reset, function should be sdio (hw_rst),
+		 * but pinctrl-mvebu does not support this.
+		 *
+		 * From pinctrl-mvebu.h:
+		 * "The name will be used to switch to this setting in DT description, e.g.
+		 * marvell,function = "uart2". subname is only for debugging purposes."
+		 */
+	};
+};
+
+&ap_sdhci0 {
+	bus-width = <8>;
+	pinctrl-0 = <&ap_mmc0_pins>;
+	pinctrl-names = "default";
+	vqmmc-supply = <&v_1_8>;
+	status = "okay";
+};
+
+&ap_thermal_ic {
+	polling-delay = <1000>;
+
+	trips {
+		ap_active: trip-active {
+			temperature = <40000>;
+			hysteresis = <4000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&ap_active>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 4>;
+		};
+
+		map1 {
+			trip = <&ap_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+&cp0_eth1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_eth1_pins>;
+	phy-mode = "rgmii-id";
+	phy = <&cp0_eth_phy0>;
+	status = "okay";
+};
+
+&cp0_gpio1 {
+	status = "okay";
+
+	/*
+	 * Tacho signal used as interrupt source by pwm-fan driver.
+	 * Hog IO as input to ensure mvebu-gpio irq driver`s
+	 * irq_set_type can succeed.
+	 */
+	pwm-tacho-irq-hog {
+		gpio-hog;
+		gpios = <26 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+		input;
+		line-name = "fan-tacho";
+	};
+};
+
+&cp0_gpio2 {
+	status = "okay";
+};
+
+&cp0_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c0_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	com_eeprom: eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+
+	eeprom@53 {
+		compatible = "atmel,spd";
+		reg = <0x53>;
+	};
+};
+
+&cp0_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9547";
+		reg = <0x77>;
+		i2c-mux-idle-disconnect;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		com_clkgen_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			/* clock-controller@6b */
+		};
+
+		com_10g_led_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			/* Routed to B2B Connector as I2C_10G_LED_SCL/SDA */
+		};
+
+		com_10g_sfp_i2c0: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			/* Routed to B2B Connector as I2C_SFP0_CP0_SCL/SDA */
+		};
+
+		com_smbus: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			/* Routed to B2B Connector as SBM_CLK/DAT */
+		};
+
+		com_fanctrl_i2c: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			/* fan-controller@2f (assembly option) */
+		};
+	};
+};
+
+&cp0_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_mdio_pins>;
+	status = "okay";
+
+	cp0_eth_phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&cp0_spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_spi1_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		/* read command supports max. 50MHz */
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&cp0_syscon0 {
+	cp0_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		com_10g_int0_pins: cp0-10g-int-pins {
+			marvell,pins = "mpp24";
+			marvell,function = "gpio";
+		};
+
+		cp0_eth1_pins: cp0-eth1-pins {
+			marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
+				       "mpp4", "mpp5", "mpp6", "mpp7",
+				       "mpp8", "mpp9", "mpp10", "mpp11";
+			/* docs call it "ge1", but cp110-pinctrl "ge0" */
+			marvell,function = "ge0";
+		};
+
+		cp0_fan_pwm_pins: cp0-fan-pwm-pins {
+			marvell,pins = "mpp39";
+			marvell,function = "gpio";
+		};
+
+		cp0_fan_tacho_pins: cp0-fan-tacho-pins {
+			marvell,pins = "mpp26";
+			marvell,function = "gpio";
+		};
+
+		cp0_i2c0_pins: cp0-i2c0-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "i2c0";
+		};
+
+		cp0_i2c1_pins: cp0-i2c1-pins {
+			marvell,pins = "mpp35", "mpp36";
+			marvell,function = "i2c1";
+		};
+
+		cp0_mdio_pins: cp0-mdio-pins {
+			marvell,pins = "mpp40", "mpp41";
+			marvell,function = "ge";
+		};
+
+		cp0_mmc0_pins: cp0-mmc0-pins {
+			marvell,pins = "mpp56", "mpp57", "mpp58", "mpp59",
+				       "mpp60", "mpp61";
+			marvell,function = "sdio";
+		};
+
+		cp0_mmc0_cd_pins: cp0-mmc0-cd-pins {
+			marvell,pins = "mpp55";
+			marvell,function = "sdio_cd";
+		};
+
+		cp0_pwrbtn_pins:  cp0-pwrbtn-pins {
+			marvell,pins = "mpp31";
+			marvell,function = "gpio";
+		};
+
+		cp0_reg_ap_vhv_pins: cp0-reg-ap-vhv-pins {
+			marvell,pins = "mpp53";
+			marvell,function = "gpio";
+		};
+
+		cp0_reg_cp_vhv_pins: cp0-reg-cp-vhv-pins {
+			marvell,pins = "mpp49";
+			marvell,function = "gpio";
+		};
+
+		cp0_spi1_pins: cp0-spi1-pins {
+			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
+			marvell,function = "spi1";
+		};
+
+		cp0_spi1_cs1_pins: cp0-spi1-cs1-pins {
+			marvell,pins = "mpp12";
+			marvell,function = "spi1";
+		};
+
+		cp0_uart2_pins: cp0-uart2-pins  {
+			marvell,pins = "mpp50", "mpp51";
+			marvell,function = "uart2";
+		};
+	};
+};
+
+&cp0_thermal_ic {
+	polling-delay = <1000>;
+
+	trips {
+		cp0_active: trip-active {
+			temperature = <40000>;
+			hysteresis = <4000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cp0_active>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 4>;
+		};
+
+		map1 {
+			trip = <&cp0_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
+/* USB-2.0 Host */
+&cp0_usb3_0 {
+	phys = <&cp0_utmi0>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* USB-2.0 Host */
+&cp0_usb3_1 {
+	phys = <&cp0_utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+&cp1_gpio1 {
+	status = "okay";
+};
+
+&cp1_gpio2 {
+	status = "okay";
+};
+
+&cp1_rtc {
+	status = "disabled";
+};
+
+&cp1_spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_spi1_pins>;
+	status = "okay";
+
+	tpm@0 {
+		reg = <0>;
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		spi-max-frequency = <10000000>;
+		pinctrl-names  = "default";
+		pinctrl-0 = <&cp1_tpm_irq_pins>;
+		interrupt-parent = <&cp1_gpio1>;
+		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&cp1_syscon0 {
+	cp1_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		com_10g_int1_pins: cp1-10g-int-pins {
+			marvell,pins = "mpp50";
+			marvell,function = "gpio";
+		};
+
+		cp1_10g_phy_rst_01_pins: cp1-10g-phy-rst-01-pins {
+			marvell,pins = "mpp43";
+			marvell,function = "gpio";
+		};
+
+		cp1_10g_phy_rst_23_pins: cp1-10g-phy-rst-23-pins {
+			marvell,pins = "mpp42";
+			marvell,function = "gpio";
+		};
+
+		cp1_batlow_pins: cp1-batlow-pins {
+			marvell,pins = "mpp11";
+			marvell,function = "gpio";
+		};
+
+		cp1_rsvd16_pins: cp1-rsvd16-pins {
+			marvell,pins = "mpp29";
+			marvell,function = "gpio";
+		};
+
+		cp1_sata_act_pins: cp1-sata-act-pins {
+			marvell,pins = "mpp39";
+			marvell,function = "gpio";
+		};
+
+		cp1_spi1_pins: cp1-spi1-pins {
+			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
+			marvell,function = "spi1";
+		};
+
+		cp1_thrm_irq_pins: cp1-thrm-irq-pins {
+			marvell,pins = "mpp34";
+			marvell,function = "gpio";
+		};
+
+		cp1_thrm_trip_pins: cp1-thrm-trip-pins {
+			marvell,pins = "mpp33";
+			marvell,function = "gpio";
+		};
+
+		cp1_tpm_irq_pins: cp1-tpm-irq-pins {
+			marvell,pins = "mpp17";
+			marvell,function = "gpio";
+		};
+
+		cp1_wake0_pins: cp1-wake0-pins {
+			marvell,pins = "mpp40";
+			marvell,function = "gpio";
+		};
+
+		cp1_wake1_pins: cp1-wake1-pins {
+			marvell,pins = "mpp51";
+			marvell,function = "gpio";
+		};
+
+		cp1_xmdio_pins: cp1-xmdio-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "xg";
+		};
+	};
+};
+
+&cp1_thermal_ic {
+	polling-delay = <1000>;
+
+	trips {
+		cp1_active: trip-active {
+			temperature = <40000>;
+			hysteresis = <4000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cp1_active>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 4>;
+		};
+
+		map1 {
+			trip = <&cp1_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
+/* USB-2.0 Host */
+&cp1_usb3_0 {
+	phys = <&cp1_utmi0>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp1_utmi {
+	status = "okay";
+};
+
+&cp2_ethernet {
+	status = "okay";
+};
+
+&cp2_gpio1 {
+	status = "okay";
+};
+
+&cp2_gpio2 {
+	status = "okay";
+};
+
+&cp2_rtc {
+	status = "disabled";
+};
+
+&cp2_syscon0 {
+	cp2_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		com_10g_int2_pins: cp2-10g-int-pins {
+			marvell,pins = "mpp50";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd0_pins: cp2-rsvd0-pins {
+			marvell,pins = "mpp0";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd1_pins: cp2-rsvd1-pins {
+			marvell,pins = "mpp1";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd2_pins: cp2-rsvd2-pins {
+			marvell,pins = "mpp2";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd3_pins: cp2-rsvd3-pins {
+			marvell,pins = "mpp3";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd4_pins: cp2-rsvd4-pins {
+			marvell,pins = "mpp4";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd5_pins: cp2-rsvd5-pins {
+			marvell,pins = "mpp54";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd7_pins: cp2-rsvd7-pins {
+			marvell,pins = "mpp7";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd8_pins: cp2-rsvd8-pins {
+			marvell,pins = "mpp8";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd9_pins: cp2-rsvd9-pins {
+			marvell,pins = "mpp9";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd10_pins: cp2-rsvd10-pins {
+			marvell,pins = "mpp10";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd11_pins: cp2-rsvd11-pins {
+			marvell,pins = "mpp11";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd27_pins: cp2-rsvd27-pins {
+			marvell,pins = "mpp11";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd31_pins: cp2-rsvd31-pins {
+			marvell,pins = "mpp31";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd32_pins: cp2-rsvd32-pins {
+			marvell,pins = "mpp32";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd55_pins: cp2-rsvd55-pins {
+			marvell,pins = "mpp55";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd56_pins: cp2-rsvd56-pins {
+			marvell,pins = "mpp56";
+			marvell,function = "gpio";
+		};
+
+		cp2_xmdio_pins: cp2-xmdio-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "xg";
+		};
+	};
+};
+
+&cp2_thermal_ic {
+	polling-delay = <1000>;
+
+	trips {
+		cp2_active: trip-active {
+			temperature = <40000>;
+			hysteresis = <4000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cp2_active>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 4>;
+		};
+
+		map1 {
+			trip = <&cp2_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
+/* USB-2.0/3.0 Host */
+&cp2_usb3_0 {
+	phys = <&cp2_utmi0>, <&cp2_comphy1 0>;
+	phy-names = "utmi", "comphy";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp2_utmi {
+	status = "okay";
+};
+
+/* AP default console */
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};

-- 
2.35.3


