Return-Path: <netdev+bounces-216970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BE7B36CF9
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 17:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF0FA073B6
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4913935082F;
	Tue, 26 Aug 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="QpgBaL6Q"
X-Original-To: netdev@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022115.outbound.protection.outlook.com [40.107.149.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782234DCC1;
	Tue, 26 Aug 2025 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219310; cv=fail; b=Llr11OnjBijqEz0cBmMf3pamRlhEZP746PuuIU8H+FpMHgaRdyJjy+rFsskwIHbh4hNp7TU07QeQnXy5cu/uKvTP4SjOZI10M95uw/F7D2VwMrOh0b7/+4qYYA/wUnr3d3MaDQ6qqZQTWPawT5+GLu0ppjZfdoVqTYDmSQPOeJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219310; c=relaxed/simple;
	bh=NhLENZPWwRjHzqDtN7qFh1gAqpoMArAu7BtEqXTe460=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xw1CuS6YpcTrVl5/UdVnp1XJK0cppXKbvQ4Uzn0FAmzXsPpGQsuxIUWqQKydB9L3563lHgQF2d4kohmo3wSCp6plck37vorFCNyslEOL5ZaHIiAXySiPVir0nNV89HcruyzW5/OmVtIH7bPvcJB/AJAMuSf0L7QBu6VWadQkIR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=QpgBaL6Q; arc=fail smtp.client-ip=40.107.149.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngKV4AOKfk9Uc9UGK0uXrogtmUOTYjmzhJjlXhmdHwBTLY9oeAx4cLNf44K+khUZhzcxFyLE6LYxlsWZYQNmJVHlmSH+ifNGmK7Vg/UvxypA7ELgUOecQYUEo/B73zCxURBtMc0oUhidgzoikiJqCV7dcBYSB2N17dpk+Sp+isny2fXBSINjwBkq8v5UcbH3TUOL8iMJyztJ3c2tFFVqoNuHsEPOs0NR0O73v/o4HV3XmqWWrWl04Q/lH2tCA7jwcI8m3+5gDzYvh8f+8S2nf/RZ0eiSZpNlcT2DkDlCFC2WazUl8+JccNqSO/0hRjxEEMUibjIW4AKJqlTaNSmHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhLENZPWwRjHzqDtN7qFh1gAqpoMArAu7BtEqXTe460=;
 b=eWVLCr6MINRmD563etkyBL9BVeTAXqq+1lFJLuhwT+7YGR3u11RuHWzpUVRBOAnjmChVxSnQpK5xw7boluWcMze+bYM81YQ+vwyYVAL/1X0AGeS/QL9rFCGF/tXBQsXkzn5nM8qO6r+roQJHCgN9BGgSOcvXnnnkhjLhMYz95ahDtRM/V7wZR6y8kQd8N8r2Tu9yLjJeC6Z4YSSD1+khkPjxd/qMN60MKmsox5lcGL1OICwGXLeoo2cy/kqNqD3oJZGOdb7QTI0chFv19Wru9sOHlMVaM43HCBCJE0LeGfCn3Fv2nlf48Ib83OF/fDUVXOJ0YQhWQ9LFbQrgDuZvGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhLENZPWwRjHzqDtN7qFh1gAqpoMArAu7BtEqXTe460=;
 b=QpgBaL6QCDTyhmKIm9AWd5r99EqnVpwfrRgjJ9RyJ9QjZmryaLwBRHLgbHXeBEdiyeOczXR/AGO+AF3pCzrrPSS46OP/sidKEW8+zgIP09voeT53yxIfmxaQWzxUnErXUMIwscprssHyAjMx6sxjtRdaybUUs3SRYi/hWdPSbvs=
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::126)
 by FR2PPFB1CCF8A01.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::7e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 14:41:44 +0000
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::92f0:48d2:2be9:13c6]) by FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::92f0:48d2:2be9:13c6%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 14:41:44 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v7 1/2] dt-bindings: net: pse-pd: Add bindings for
 Si3474 PSE controller
Thread-Topic: [PATCH net-next v7 1/2] dt-bindings: net: pse-pd: Add bindings
 for Si3474 PSE controller
Thread-Index: AQHcFpeLi3KodhbFgE2pI1qtgfPAxg==
Date: Tue, 26 Aug 2025 14:41:44 +0000
Message-ID: <71a67c6f-6fce-49c7-96ec-554602dbd4f1@adtran.com>
References: <6af537dc-8a52-4710-8a18-dcfbb911cf23@adtran.com>
In-Reply-To: <6af537dc-8a52-4710-8a18-dcfbb911cf23@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3PPF3200C8D6F:EE_|FR2PPFB1CCF8A01:EE_
x-ms-office365-filtering-correlation-id: 8f91042f-e6c5-41ce-1f1b-08dde4aeadc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2oxWDBxbXdjMnplR01NY0dMdTJMcE1VbmYvdnQ2RlFtaTN5TTU0Y2hnV3lk?=
 =?utf-8?B?RStFS3FtUDFQMzZpYlFvSURNRmsrVDVkY2w3eHJDZW5UWllHNi8yZ2lOVEQ0?=
 =?utf-8?B?dG1jY2VjTTdvTXlGWjEvTWZEdUxWR2pYRjJPMFNPdVhBWGs5a3dRWC9TbHpy?=
 =?utf-8?B?eWJvWGx5SnRWQUZBcnA5ekw2UXZtQVB1eTk4bkNkWVVoYUZ6aGJqZUkrRFdL?=
 =?utf-8?B?d2lhaHZMN1RiNkt4ajZkNDdWaHZOa0lFMDRMQ0J4QzBiS2NraHdMQk9oZmda?=
 =?utf-8?B?QXZlbnlHZTdpTGwxMWFvSHBYbDNWZ2xBbzlUYnBtSHdqcVhZWldhQVlwN2Vl?=
 =?utf-8?B?dUlUNmFwSFZ5aFFudjJ5enVRT1F4MHRPMlRReGlMcDd1UzFWTDdOaS8rbWZp?=
 =?utf-8?B?UlllY3NTRDFmd1JlTkRqRW1uUVcxYmVRWjJnZHRZc0Fmajc3N01GUFhQUnlU?=
 =?utf-8?B?RTJVQzZZcnZrTnpLellWTlhab0hiZmtOejczK3BWOUs4L0F5Z3pmV1l4NVox?=
 =?utf-8?B?WTRacE9HczFHMlVsZkdmVFhmdzlWZnA3eFZUSC9HampDOUZVV3hPaHpTODIz?=
 =?utf-8?B?L3BQQTR1aUNXQVVyZmt6UUlZdDVrTjVjK3Ywa1FnOFZDNUV6UVBIcktmTHRq?=
 =?utf-8?B?bXpsRXdaMVh2ekhMdjIzS1Bsd2R2SjJTZlBxNlB3LzhKVWU2MWE0b3l5UUVm?=
 =?utf-8?B?MzQ3Sm1uS0VlUVZSdTlQOWY1R1NyNldWeE1kbndRcjVQOGJGcGNFbVZ5OTFW?=
 =?utf-8?B?NHRsa3E2T0FEM2J6VGdkamFSZk84WlM3cllVdHFEMVFWUW1VWVBnT29jNlZG?=
 =?utf-8?B?V2YrNEpFS1pmQVNzV0hlL2d0WjA3VVU4SEgxYUUwTmpQTGIvbE1ZUG4rc3Z4?=
 =?utf-8?B?elBwUm56SXpjL29DZmNjS0h1eU1WRjg1WC8wd280U2lwd2NoWmh2cHJJOEhC?=
 =?utf-8?B?UUlvcUVVZG1WS0YrNUxLUXd6c2U5SnU1WWVtTmU2TFQxYWdVTFZVQjVuc3dD?=
 =?utf-8?B?K1F1dHplS1BaRmc0T0sxV2JQUXlUMWM4VlVwLytiZUlLdi9CYmswTmNTOVI1?=
 =?utf-8?B?eHVJSFIrbDFsT1R4a1NDbFBUUFo4L0dlSVU1disyNXp6OWx4U3FLWkVNek5T?=
 =?utf-8?B?WDkrS0VhL1ByNy8rbE1SRzVmN3o4NnZRWUJRWnlJeWIrSGRDeWNHRUR3QVdw?=
 =?utf-8?B?YVhTWU1ZSExWdDJzeDk5WHI1aGVEOVA1SG9QS2FNOG9nTXhFaWcrMWtNOFBw?=
 =?utf-8?B?UEN0MFFXSlQxUTd4YjUxQTA4TzJnby9TRDQwdExhVUVTVlcxNm1BVk1rMTBy?=
 =?utf-8?B?Y1RoQlFHbjU0ZnZxZWJGZGVvVzhLdjF2dG1uQzhiUUxKQ1RuQ3ZRYjhPbGgy?=
 =?utf-8?B?MGRmaTlKeVpmU3k2b1dzUG01UzhHd2laOUgvV29Qamk5N3oyK3UwTWlCVjZU?=
 =?utf-8?B?ay9kRUlOVEpORjAzMjMzQ09zcjlFRHRpbG83WE9nRFY4Sy9kWXBzMHJNZVJB?=
 =?utf-8?B?ckV1bWVXRzdNdUFKU3F2VWk3VTRBaHAzTDZXdENvOTFXcjRDR3JubXBUVUxs?=
 =?utf-8?B?Vnl0TFozcXR3RmRoTktsaUhtMWV6VU95TXM2SVFOOExJZDVMbGZITEZEZGla?=
 =?utf-8?B?VUhiOE1FZWp4TzBoSWREc3Y4QnI5N0R3VENON3prVlcxZyt4VFNFZDNhTnhk?=
 =?utf-8?B?b2lTblRVa2hBU0dndkMrbVk2eVJqeFNJOURaeE14anM0THF3Z3A3bVY0a2Vt?=
 =?utf-8?B?alJzd1l3VnJybTlkeWJ1MWM1dkxYN0VjRjNTeHhFQWxwdmpCRUhodStzaTJX?=
 =?utf-8?B?VnJkZnI0ZTQyQk1pWUhmWGdoRzRsQnhNd2xsSUQxSVhKLzlsSnVsRlgzOXJZ?=
 =?utf-8?B?QnVwajZaamRqRjJBMFBMQ2ZubDRjL0NiQmJkeGNqUXhJSExURzFoSFNyLzIr?=
 =?utf-8?Q?BHrjEInlVaNYTIDvQft0ATV6QMlGvug/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmVMOEZFaDVwY3VRVUdNVng3NnlLQjhNNTJUVlN6UG9MZjUzcGdlYUFTYU1S?=
 =?utf-8?B?VnA2N1ZpYlV1SjJtcGJnTnNNZTVRWG41bDdIOW1uQVhXS0F1dllQYkp3YytV?=
 =?utf-8?B?Wjg3WXYvUnZ6S0VRTU05cVZzbjlrTXZ1bk1XM3lNMHVkN0dlL1VQUElSWlVK?=
 =?utf-8?B?STR1U3VvZkt4Z1BKYTFOSXRZSlV5VTF0aExTc3MrUWFMUTlYMDJUbC9ua1pn?=
 =?utf-8?B?aUhKbFllZitnUFZPMXhBNjlMWURhemhjV21ZR3gzM0pMdXRNUm1GWnFPYnlm?=
 =?utf-8?B?WkNXRUdXY1JDTVZxYTUxUlJ1MjRsdjZkZE5oemtnR1dtTk5mZ1dqWmU3NlNO?=
 =?utf-8?B?K0ZrZ3hnZnF2Nmg1ZmdkNUt3UHErT0JyMU9lUmhZczNuQjdERkUycTBJamV2?=
 =?utf-8?B?UC9sK3QyK1RHSUlTNnBMa3k4SjFYT0N1Wk5WRWtxN2czQ0NIYTdMZXUxcDhV?=
 =?utf-8?B?YmZFS0syM2QwSXo1UGloenVSejh4RlcyVUd5RjFqTjdqUHArTVR5cm9hcWs2?=
 =?utf-8?B?cVNKcFZjRCtESTIwa285cGlIN1pQbTdRQ3Y0R3VJR0V0RzBTSTVrSFpTdFZP?=
 =?utf-8?B?NC9SdVJkN28wOWpoQlNodXBNQlp4RXE1YmgxS0w1WE1vV0s1TGxjTHFoejVH?=
 =?utf-8?B?U3ArZ296Y3FXWFh4TUZ3ZTBhMUlxQkx1dHFiVmpucnFQU0FiOE5MUjliRmEy?=
 =?utf-8?B?ZFJMYnpBbktURHFqZkhSL2YxU2ZZODRyalBrOU9UMUY4c1ZvOFJhZUlYbVdu?=
 =?utf-8?B?Y1ZtWVIrcFFPQVF5aXJOZVhvRU1TWkY0NW01Rm91QXRaMkt0NGxPTjJ3enA3?=
 =?utf-8?B?Nmt1MXBvK0RZRUdQL2k3Uk9WT3ROMHhJYUlLWDAwMFQrWnZOTHZrSWhOWFVs?=
 =?utf-8?B?dXlpTzhZcUs1UUxmS2gzWlYrU1lBMzEybWlnNklqMGE5MUNxNGoyR25UdkM1?=
 =?utf-8?B?NVZQUEV1VHU1T3A3U1QzK2Fra1p5N3dJNklMV3BOL2pTMnpJL0g5MnZQR3Zz?=
 =?utf-8?B?VzUwbW50V3NpenIwWXJMZkJsMlpMZXFJanFEQjI4Q0Jobm1TQTAyMTI0V2lZ?=
 =?utf-8?B?d0p6dS9oTk04cGRRRnV2MGxTaUJPdHNIcHBxTVNpb25YeUZFeGNtU0VwVk4y?=
 =?utf-8?B?cVVPMGZORU54Z3haRjVkOVBaR1hBV3BPdU92ekxpRUl6V2M4aTQxeEo5TFY0?=
 =?utf-8?B?VkxyVFBjdzh3VjZyc1YxYy9JUnFkZHljcGQyUmV4Mk1FUGordzAyZlkrZFBk?=
 =?utf-8?B?R3R5NU03QTdqNlkrWDFhYUNsdWhjNXFTVlFRaUNBV1hOdVVJVzNjb3A5dXVD?=
 =?utf-8?B?b3NUMkpCczVza1ozZ29kZ2FSYzdKWmpOejlYQVF6c1lLK1o0N3dGejJoMkxq?=
 =?utf-8?B?MjBYYkcxV3dLS2RpRVFCSEVqRVNqanoyUGY1YnlzUzNSUzExdnl3aTlyUnRh?=
 =?utf-8?B?L0lTK1phUzdTQjU0OUZrckI1Qm5vQUtiWUhIZHc3Ujg2aTJlOG1oaldqMUJP?=
 =?utf-8?B?VHcrS2Zrc3FiaFFrMTRiQUpNVVlHdjgyamQzOGcxcGhqa05oUHBnU1N2VCsw?=
 =?utf-8?B?dlkxbk94dGlRUFJiNFlXYmhSSzlnYTI1bUMweE5QR0QrRWVINFJqNVZNVlYy?=
 =?utf-8?B?ZnJHUVRySzFBL3RFbkZvMzgyNjl4RFNwNTJTankwMVRsMEI3UHVEQ0s4cmhy?=
 =?utf-8?B?V1RFK0tHcys5UTFwNDBUT0xjTmZ4WTNOQktIL3dxMGFacG5Ob1hHcVZvR0Iz?=
 =?utf-8?B?RWV5ZzQwU21Bdi9JdEhsK3ltWnh6bmlDV0x2enVPc1pTZ2FuZVV5cmVXMzUy?=
 =?utf-8?B?ZGdXdUVudVhaV1BHMFl2eHlWbzY5S1N0OGM1WkJXZmVDMHhoWkZjSlM4YlpB?=
 =?utf-8?B?SXprUXNIQldaMzRtTlZnd2hDb1ZaVStSekpzOHMyTldLT0VPV3I5YUMzSEU2?=
 =?utf-8?B?bDdQOEdCUUUxSkp6YkZoL2xwN0lLKzNWNWprRXRFMUYyRm15TjRoNVROSzhv?=
 =?utf-8?B?L3BtOEUxUVduU2FNeXFSbnJqZlkvUFFtUG9zUWY4QmxzWHpDZXZhQ2J0NjN3?=
 =?utf-8?B?ZytzVHlGb09zc1FQNHQ3U3d1RVlaaVVSRGx2WGVXNVVZZlpvRGpuRVErUS9U?=
 =?utf-8?Q?zEJ5SXvmocyL1es8bXmt2YFoZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A383E140136BA84D863BEA418E4A1345@DEUP281.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f91042f-e6c5-41ce-1f1b-08dde4aeadc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 14:41:44.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /5VoBePnaJ9dBQg8c7uh8tziyU3AHbP5Zvf1P/eGdL+/3Fes+g/1PXXitsqtF6TJ9nqj9QwOShd2mvSauV1T9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2PPFB1CCF8A01

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNCkFkZCB0aGUgU2kz
NDc0IEkyQyBQb3dlciBTb3VyY2luZyBFcXVpcG1lbnQgY29udHJvbGxlciBkZXZpY2UgdHJlZQ0K
YmluZGluZ3MgZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViaWsgPHBp
b3RyLmt1YmlrQGFkdHJhbi5jb20+DQpSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KUmV2aWV3ZWQtYnk6IEtvcnkgTWFpbmNl
bnQgPGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb20+DQotLS0NCg0KQ2hhbmdlcyBpbiB2MzoNCiAg
LSBVcGRhdGUgY2hhbm5lbCBub2RlIGRlc2NyaXB0aW9uLg0KICAtIFJlb3JkZXIgcmVnIGFuZCBy
ZWctbmFtZXMgcHJvcGVydGllcy4NCiAgLSBSZW5hbWUgYWxsICJzbGF2ZSIgcmVmZXJlbmNlcyB0
byAic2Vjb25kYXJ5Ii4NCg0KLS0tDQogLi4uL2JpbmRpbmdzL25ldC9wc2UtcGQvc2t5d29ya3Ms
c2kzNDc0LnlhbWwgIHwgMTQ0ICsrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAx
NDQgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L3BzZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbA0KDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9wc2UtcGQvc2t5d29y
a3Msc2kzNDc0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3Bz
ZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAw
MDAwMDAwMDAwMC4uZWRkMzZhNDNhMzg3DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3BzZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbA0K
QEAgLTAsMCArMSwxNDQgQEANCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1v
bmx5IE9SIEJTRC0yLUNsYXVzZSkNCislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9zY2hlbWFzL25ldC9wc2UtcGQvc2t5d29ya3Msc2kzNDc0LnlhbWwjDQorJHNj
aGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQor
dGl0bGU6IFNreXdvcmtzIFNpMzQ3NCBQb3dlciBTb3VyY2luZyBFcXVpcG1lbnQgY29udHJvbGxl
cg0KKw0KK21haW50YWluZXJzOg0KKyAgLSBQaW90ciBLdWJpayA8cGlvdHIua3ViaWtAYWR0cmFu
LmNvbT4NCisNCithbGxPZjoNCisgIC0gJHJlZjogcHNlLWNvbnRyb2xsZXIueWFtbCMNCisNCitw
cm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAgZW51bToNCisgICAgICAtIHNreXdvcmtz
LHNpMzQ3NA0KKw0KKyAgcmVnOg0KKyAgICBtYXhJdGVtczogMg0KKw0KKyAgcmVnLW5hbWVzOg0K
KyAgICBpdGVtczoNCisgICAgICAtIGNvbnN0OiBtYWluDQorICAgICAgLSBjb25zdDogc2Vjb25k
YXJ5DQorDQorICBjaGFubmVsczoNCisgICAgZGVzY3JpcHRpb246IFRoZSBTaTM0NzQgaXMgYSBz
aW5nbGUtY2hpcCBQb0UgUFNFIGNvbnRyb2xsZXIgbWFuYWdpbmcNCisgICAgICA4IHBoeXNpY2Fs
IHBvd2VyIGRlbGl2ZXJ5IGNoYW5uZWxzLiBJbnRlcm5hbGx5LCBpdCdzIHN0cnVjdHVyZWQNCisg
ICAgICBpbnRvIHR3byBsb2dpY2FsICJRdWFkcyIuDQorICAgICAgUXVhZCAwIE1hbmFnZXMgcGh5
c2ljYWwgY2hhbm5lbHMgKCdwb3J0cycgaW4gZGF0YXNoZWV0KSAwLCAxLCAyLCAzDQorICAgICAg
UXVhZCAxIE1hbmFnZXMgcGh5c2ljYWwgY2hhbm5lbHMgKCdwb3J0cycgaW4gZGF0YXNoZWV0KSA0
LCA1LCA2LCA3Lg0KKw0KKyAgICB0eXBlOiBvYmplY3QNCisgICAgYWRkaXRpb25hbFByb3BlcnRp
ZXM6IGZhbHNlDQorDQorICAgIHByb3BlcnRpZXM6DQorICAgICAgIiNhZGRyZXNzLWNlbGxzIjoN
CisgICAgICAgIGNvbnN0OiAxDQorDQorICAgICAgIiNzaXplLWNlbGxzIjoNCisgICAgICAgIGNv
bnN0OiAwDQorDQorICAgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KKyAgICAgICdeY2hhbm5lbEBbMC03
XSQnOg0KKyAgICAgICAgdHlwZTogb2JqZWN0DQorICAgICAgICBhZGRpdGlvbmFsUHJvcGVydGll
czogZmFsc2UNCisNCisgICAgICAgIHByb3BlcnRpZXM6DQorICAgICAgICAgIHJlZzoNCisgICAg
ICAgICAgICBtYXhJdGVtczogMQ0KKw0KKyAgICAgICAgcmVxdWlyZWQ6DQorICAgICAgICAgIC0g
cmVnDQorDQorICAgIHJlcXVpcmVkOg0KKyAgICAgIC0gIiNhZGRyZXNzLWNlbGxzIg0KKyAgICAg
IC0gIiNzaXplLWNlbGxzIg0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJl
Zw0KKyAgLSBwc2UtcGlzDQorDQordW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4
YW1wbGVzOg0KKyAgLSB8DQorICAgIGkyYyB7DQorICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQorICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQorDQorICAgICAgZXRoZXJuZXQtcHNlQDI2IHsN
CisgICAgICAgIGNvbXBhdGlibGUgPSAic2t5d29ya3Msc2kzNDc0IjsNCisgICAgICAgIHJlZy1u
YW1lcyA9ICJtYWluIiwgInNlY29uZGFyeSI7DQorICAgICAgICByZWcgPSA8MHgyNj4sIDwweDI3
PjsNCisNCisgICAgICAgIGNoYW5uZWxzIHsNCisgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQorICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KKyAgICAgICAgICBwaHlzMF8wOiBj
aGFubmVsQDAgew0KKyAgICAgICAgICAgIHJlZyA9IDwwPjsNCisgICAgICAgICAgfTsNCisgICAg
ICAgICAgcGh5czBfMTogY2hhbm5lbEAxIHsNCisgICAgICAgICAgICByZWcgPSA8MT47DQorICAg
ICAgICAgIH07DQorICAgICAgICAgIHBoeXMwXzI6IGNoYW5uZWxAMiB7DQorICAgICAgICAgICAg
cmVnID0gPDI+Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgICBwaHlzMF8zOiBjaGFubmVsQDMg
ew0KKyAgICAgICAgICAgIHJlZyA9IDwzPjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcGh5
czBfNDogY2hhbm5lbEA0IHsNCisgICAgICAgICAgICByZWcgPSA8ND47DQorICAgICAgICAgIH07
DQorICAgICAgICAgIHBoeXMwXzU6IGNoYW5uZWxANSB7DQorICAgICAgICAgICAgcmVnID0gPDU+
Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgICBwaHlzMF82OiBjaGFubmVsQDYgew0KKyAgICAg
ICAgICAgIHJlZyA9IDw2PjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcGh5czBfNzogY2hh
bm5lbEA3IHsNCisgICAgICAgICAgICByZWcgPSA8Nz47DQorICAgICAgICAgIH07DQorICAgICAg
ICB9Ow0KKyAgICAgICAgcHNlLXBpcyB7DQorICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+
Ow0KKyAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCisgICAgICAgICAgcHNlX3BpMDogcHNl
LXBpQDAgew0KKyAgICAgICAgICAgIHJlZyA9IDwwPjsNCisgICAgICAgICAgICAjcHNlLWNlbGxz
ID0gPDA+Ow0KKyAgICAgICAgICAgIHBhaXJzZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUtYSIsICJh
bHRlcm5hdGl2ZS1iIjsNCisgICAgICAgICAgICBwYWlyc2V0cyA9IDwmcGh5czBfMD4sIDwmcGh5
czBfMT47DQorICAgICAgICAgICAgcG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwgIlMiOw0K
KyAgICAgICAgICAgIHZwd3Itc3VwcGx5ID0gPCZyZWdfcHNlPjsNCisgICAgICAgICAgfTsNCisg
ICAgICAgICAgcHNlX3BpMTogcHNlLXBpQDEgew0KKyAgICAgICAgICAgIHJlZyA9IDwxPjsNCisg
ICAgICAgICAgICAjcHNlLWNlbGxzID0gPDA+Ow0KKyAgICAgICAgICAgIHBhaXJzZXQtbmFtZXMg
PSAiYWx0ZXJuYXRpdmUtYSIsICJhbHRlcm5hdGl2ZS1iIjsNCisgICAgICAgICAgICBwYWlyc2V0
cyA9IDwmcGh5czBfMj4sIDwmcGh5czBfMz47DQorICAgICAgICAgICAgcG9sYXJpdHktc3VwcG9y
dGVkID0gIk1ESS1YIiwgIlMiOw0KKyAgICAgICAgICAgIHZwd3Itc3VwcGx5ID0gPCZyZWdfcHNl
PjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcHNlX3BpMjogcHNlLXBpQDIgew0KKyAgICAg
ICAgICAgIHJlZyA9IDwyPjsNCisgICAgICAgICAgICAjcHNlLWNlbGxzID0gPDA+Ow0KKyAgICAg
ICAgICAgIHBhaXJzZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUtYSIsICJhbHRlcm5hdGl2ZS1iIjsN
CisgICAgICAgICAgICBwYWlyc2V0cyA9IDwmcGh5czBfND4sIDwmcGh5czBfNT47DQorICAgICAg
ICAgICAgcG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwgIlMiOw0KKyAgICAgICAgICAgIHZw
d3Itc3VwcGx5ID0gPCZyZWdfcHNlPjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcHNlX3Bp
MzogcHNlLXBpQDMgew0KKyAgICAgICAgICAgIHJlZyA9IDwzPjsNCisgICAgICAgICAgICAjcHNl
LWNlbGxzID0gPDA+Ow0KKyAgICAgICAgICAgIHBhaXJzZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUt
YSIsICJhbHRlcm5hdGl2ZS1iIjsNCisgICAgICAgICAgICBwYWlyc2V0cyA9IDwmcGh5czBfNj4s
IDwmcGh5czBfNz47DQorICAgICAgICAgICAgcG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwg
IlMiOw0KKyAgICAgICAgICAgIHZwd3Itc3VwcGx5ID0gPCZyZWdfcHNlPjsNCisgICAgICAgICAg
fTsNCisgICAgICAgIH07DQorICAgICAgfTsNCisgICAgfTsNCi0tIA0KMi40My4wDQoNCg==

