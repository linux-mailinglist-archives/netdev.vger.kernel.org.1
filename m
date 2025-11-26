Return-Path: <netdev+bounces-241832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6028AC88F6B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D9A29355A8E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB02D060E;
	Wed, 26 Nov 2025 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="z/DFgUWo"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF1B22B8B0;
	Wed, 26 Nov 2025 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149556; cv=fail; b=sLEVTg0VgaAaex44wTX7VfWVkW4dYgZ2SCuZzygR36j+HZW/eenZF8FkhUFPwRFXrbmML0xlMvQjCXcKksoy2KU7LsWgeivU3xyOfkLVLohJjdPjqjzQEVU5p/OYpw31aDIJMWt1uTodUItrQt8TDCst957oamEc47bbsBCgPfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149556; c=relaxed/simple;
	bh=qYHFSHbxXVO3LfG1ud4LLdpJFQ8hJlbqWMtI5fQ/1YA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PNnEAo8eThjQ8Yl85bDRWBgYB2s2TOtO1OwT0zb1cNXh4tHRC0mdE91vhuMlwLR0un7I/B/hLIMHu8ti3x/BL7K3PxNPzkX2IJNqbtClgd3EBGdNP9JipxisRufZb2qgNqiRVI2Q72qY7tHjMZF2h+UJkFRMPpblQ3a6/CJCI/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (2048-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=z/DFgUWo; arc=fail smtp.client-ip=40.107.159.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/0IbdLUEjoJ91RnXlAPhhKr2vDRlhEgFoROZclamh1GrE7iyVJI6GJY1fgKgfmcMfExHsEiQ9V3sB40o8EvgFM280+QuDSqr35s6LN0q4xqwJa0OeDFSa7cQZH5WYTFVlH++qjXpNeoyIXxVmoOlfYH0aRVllPMvMtYd/oLfdLG1RGqWSZwUtv5BCCxa3ytnzYbeHUt+JyduhzcdNcEsfgzoYELRhhTQLab+QkVl+zZzOwgem6v1/yVr4uazRpeAUjJkmYDWmKIR2iFMg3WuSutRbhyfg99KB7hj7NPK1XIqGZgwHVkTp9z9dWSUqNUgF7//FIG0gkrapsPtKxm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jhp+ji04Rlm5yjPqr+QnGGoyUS8SS2IhMdpWd+7E1HM=;
 b=WdtNPMs/kzLnmjqLmGGmymASeGI4qiEi/t169rs9ALcRjWfsT+RElq5r5xRtpSr0Tx98orMuTt5elqUsr5iXjJgffRFI2RiIxzMdsVT4ImSBSl7HBFj7h7wo+4lO/W4xxCr3/3BLlsFdG7J7kZT93fNtK9rJAt793spL60bsjERYZb7aPOegi2Pan0bgdhdil9tKrYHtWBdmBJVTFCrkD6tvqj5Z3BGtfqSWP+hEFGmA74SqGG2p/NuaIMrKhiMSx1wbN48XzHyjuz6e/MZ+FyaurA74/nS2Ofe6bMAzdwiSlYHpewKjzza0ZYmZ5kOVIhOBL6PcDIa4Uy4w9SD2rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jhp+ji04Rlm5yjPqr+QnGGoyUS8SS2IhMdpWd+7E1HM=;
 b=z/DFgUWoi0mVKp9DRcJVC++qM8B4gAxfOgx3vYA/ZY9QlZufMtNrVPf0C7Lz0F0nLs8cDlIr4NypQEwhSh4WjzpmLPLXtwzddoH9R1qfh2h3O9vRRl4+XWxrfIuoHA3s+cptAxf1b+zpAXUocrBx3E/VYiAgoA8eY8mq5A7ZnCvoOeYN0MxaZAzaoWs0/vB2GCt9mLp8vDQyCkeZVS6Lqi0Qb9SwYaGPSkxLbjGs4hJw9ruHZc6ai4nELXHjJPW7zhAKARsbPSokwdldz4ml1R/E+UgWfllVAQpcPZZ/Yh1EIczI5gp1vdZ9lCSns6gT86d7mfKxiZ/Zl5wTzdcvtg==
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com (2603:10a6:20b:6fd::9)
 by AM0PR06MB6547.eurprd06.prod.outlook.com (2603:10a6:208:196::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Wed, 26 Nov
 2025 09:32:31 +0000
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f]) by AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f%6]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 09:32:30 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
	<kishon@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Eric
 Woudstra <ericwouds@gmail.com>,
	=?iso-2022-jp?B?TWFyZWsgQmVoGyRCImUiaRsoQm4=?= <kabel@kernel.org>, Lee Jones
	<lee@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: RE: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Thread-Topic: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Thread-Index: AQHcXqYGtlM98xQGlkSgPr5ML7/KzbUEqGyw
Date: Wed, 26 Nov 2025 09:32:30 +0000
Message-ID:
 <AM0PR06MB10396D06E6F06F6B8AB3CFCBEF7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-2-vladimir.oltean@nxp.com>
 <0faccdb7-0934-4543-9b7f-a655a632fa86@lunn.ch>
 <20251125214450.qeljlyt3d27zclfr@skbuf>
 <b4597333-e485-426d-975e-3082895e09f6@lunn.ch>
 <20251126072638.wqwbhhab3afxvm7x@skbuf>
In-Reply-To: <20251126072638.wqwbhhab3afxvm7x@skbuf>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB10396:EE_|AM0PR06MB6547:EE_
x-ms-office365-filtering-correlation-id: 1b74bb21-4f2c-4e17-f675-08de2cceb890
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?MGVuNmo4WXhsem1oZ3RZK1VrTFlmTEdjNm01L1U3VXkxYmZRSGlYUnd4?=
 =?iso-2022-jp?B?ZmZGb2liUFVvWC8rOWdLWUZFWVVQczUvMEltWWsweE5ZN1B2U2taaTcv?=
 =?iso-2022-jp?B?ajNsQ2w3RjVPZXdFVU83UUR5OXZGUEUxdWpXOGl6SW9ITVpHSUk5K2VG?=
 =?iso-2022-jp?B?ckcxQVIrZ1Y4NVdwblN3L0cwQ2xaYjNvYTBWUXdOTWpzMUFqQkJlbzFl?=
 =?iso-2022-jp?B?eGR1cWdmNlpMbXJHOEY5T2pvWDVqV0xkeWdHNUZ2TmtvWFRtTDNDMzVX?=
 =?iso-2022-jp?B?b0ZidlJIOHN1K3p5aEllS2g2dGYxWk5EOUt6eHhsb1F0L0lPQWVlZmgr?=
 =?iso-2022-jp?B?QkFVVkkyZFNqeUkzTE80bG5pamlCS0d1L1d5R0M5by93S2FHWjRCNDh5?=
 =?iso-2022-jp?B?L0NtNlpXZmY5YlhFdzNzZDVvQ08yOWtCaUM1MnBqMGovaFJKeEVCQ1F4?=
 =?iso-2022-jp?B?L05PUnNvTUxxT0w2N1NKamxEUkovNTlBY1pxSWQ0ODd5VmwrOEtlKzBI?=
 =?iso-2022-jp?B?RmN2T29Md2VZdERoTUVsL0YxMHlDSUxraFYvbm9HVElmeU1uRG10Z0xP?=
 =?iso-2022-jp?B?YStqeGZJY29iY1NDUWpHcXZUUEZ3RE10MlB4UTN1OHVjZmxwMVBKMVU0?=
 =?iso-2022-jp?B?ZG4vVGNuK0RhZjEyUFlEMG00YlFSM2lyeW81VERocG1VVHZuSmh3ZkRr?=
 =?iso-2022-jp?B?dnN4MityY1BMVmlzWHd0UUt6clJpK3ZBR3g3K2ZOak1OWGcvRGtoY2tO?=
 =?iso-2022-jp?B?QUJIaFVyQWxqTlRRVGdrNDNybnNoTTRtMVJaZmw5OURnVGxEU01oajUz?=
 =?iso-2022-jp?B?ek1Ed0orZjJ5Q3VoQ1BPNitXMkVCcW52TExvU243WUdZdyt6NjdMUlJC?=
 =?iso-2022-jp?B?MDBBck54K0FSOVFuWlBwVWtaOTR6T3grUlBQc1FLVTEwOFk3Wm50UitV?=
 =?iso-2022-jp?B?Nm9VNHhxa09yZjNvQkcydktIV29uU3dFZ0Y0UEZ6TmRRb09yclJwclh4?=
 =?iso-2022-jp?B?N2dsemNjUU5kZVpWbmV1a0Jza1VoYW5rRm1GZ0ZlY2RpWlllZW5TSjJQ?=
 =?iso-2022-jp?B?RnVXcEdqT0JISDJkUmswNHRsK0ZYa1lza08zb2s5bjNnT1FOdlFCZGlw?=
 =?iso-2022-jp?B?djcwU1RVNG9oYTZVRSt6Y0hEZXI1MnNMTzRkbHRFMm9WZ0JreXo3c29h?=
 =?iso-2022-jp?B?OTVZWWx3bWJkUGE2UTZkK2IyeUtOK3ZIczN3cE4vdzRjWU1tNzRNUVpy?=
 =?iso-2022-jp?B?b0w5SzJ5eU9BUEluRGVuUUJGa0dsdmRQRSs4cExkaTZSYWs4dE52S1VZ?=
 =?iso-2022-jp?B?M04yMFdUQ1BER1JWbEc5QXRJd1g1ZmtxS3lhN25TS1VWQ1htMmVzOFlV?=
 =?iso-2022-jp?B?MDdLdlJTR2JBOTlwdW5QRXRGRjdYUWFCUVNrOE96aHRlWVpwNTEzYkpY?=
 =?iso-2022-jp?B?L2NST00wbjJsczR4Q1JLTFRxcW9KdHVTUmx4Wm1nN2pvUGtqYUhXa3BE?=
 =?iso-2022-jp?B?citQakltR3BWWnlZTS9zeHpFZVVhdkdoRk5FTG9UT3dNVHBwWVVFWEdt?=
 =?iso-2022-jp?B?MUNGMFRLWTFqNWc1Z2o4TGNFUjBqbXA1TkYrMERTYld4eEN1bHNHMHA5?=
 =?iso-2022-jp?B?MmhMVStrNEc0ajhaWnVHamo1OWxsdGg2bWMyMHlTWjd6SFVRNktxbWQ5?=
 =?iso-2022-jp?B?UVNBV1R2K1ZaOXRIVkk3NGpteS9PcU1sTzNLVmhORGVJWjBnL2xVbGxt?=
 =?iso-2022-jp?B?K0Y4QVlaMlliWDV3RXNkUWpxZGd6ZFNpdVlJOTQ5MWxSSVJCeENhYUk1?=
 =?iso-2022-jp?B?RmpNZzFDeHBWZURkcVpLdFI0ME1jNHB2eWR6eDlxUHJ4WFJrSkp1QnhU?=
 =?iso-2022-jp?B?TmpYOWhzRDRZSzNOOGJqTGYxSS8wTC9iY0Y3QXFoR3kzWkVNRjFqMk5h?=
 =?iso-2022-jp?B?QTNGRTBRZTFyMHZzQTZMODJ0SGp2dGZiS1prZW1DOTNYSkUzZWhJZ1lZ?=
 =?iso-2022-jp?B?WTZ6bWhBQnQ2MEJqckJadEFPbXMvWXhKTjhFWDNrVWIxb2lsV1huZk9v?=
 =?iso-2022-jp?B?VmVJVk1mRGN5MUZpWDFGV0JJOE9Mc1l2RE0yZ0RVdmZtSXZWb2Rha0JR?=
 =?iso-2022-jp?B?aXdFNi96dHNEYXJWeUltZmZKbm5abDA2b2RlMnVDQ3FScCtFRWg1Y0dt?=
 =?iso-2022-jp?B?blpldFByaGFNMVJtNzZvM2hsUFM4b0NB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB10396.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?c1JieUliU1pFME9mcVQ2T1BVMVZpZkxXRng2M2E4YmhKRUFSSXo4aWoy?=
 =?iso-2022-jp?B?UnoxcE50SmQ3Y21TRXZrRWZ5QTRLRERxMENYU2NEUU9Sai9ock9TbDZh?=
 =?iso-2022-jp?B?RFM5MDMwa2p4bTJESTZScGo1OU1vanl0ZTdoOFVCZUlPY2JqbG9wYXBw?=
 =?iso-2022-jp?B?U0xaaW5mWkJHVWs4ck5QczF4d3c4Qjd5d1lKd2pZMmMvdzgrMi9hOTV3?=
 =?iso-2022-jp?B?Z1IraHVITUo3MjFwVVZuYkI1R2V4ZktKVVFORUlTcjI2bUFFaHBNdDNW?=
 =?iso-2022-jp?B?cCsza0NLU1FLM0FZcXduOTEyNTEvcTRNdVhyRk1rVXFLcWtKRGFKRHRH?=
 =?iso-2022-jp?B?UHIxRDZldFJ6aVAwam44UU9vaERGSGpieXFiRCtncmFmYUFzNW5CVzlD?=
 =?iso-2022-jp?B?MmVucXB2czRXTU9XNXltbE16clZzSUo1WDk4V01PY2tCcGtsVEx2b0U4?=
 =?iso-2022-jp?B?Q0N1MHVScHVLVEo4TEdGTlltZitzUnpPTEo4Ukh3WitJNENkWk9wWXFw?=
 =?iso-2022-jp?B?YklxUXdKeTcrMTl3T3AzSXovd3pEelBkYzNIYmNvTlBtakVQaG9hUFl6?=
 =?iso-2022-jp?B?Q0Rjc1dIcUFMMXZIUCthWk9ySFYzVkRVdlNWYS8ySmp5QVE3ZzIzaGsz?=
 =?iso-2022-jp?B?VURqZHk3V0EvNzRtdTFFNG5vaGJoTTkwMHp3QVcvdmdGazRCUTVaZEdG?=
 =?iso-2022-jp?B?ZnBhUncwclB5ZHh3S3RJS3NrRGMzVE01Vk4yNFhsbm1wM3VUU3RJbDZy?=
 =?iso-2022-jp?B?eFJhVmxmSW9vOFQwYjQzeklyY3JmODBWbkp3VldpN0ZVV1F4MkhJc3JV?=
 =?iso-2022-jp?B?Qy9KWnZxL1VRR2NaT0hTNExmUkJYdEpNWU82SC8xamRPQmhQNkxaVE5h?=
 =?iso-2022-jp?B?bFBhOU53RzRBM1VOK012Uk9WM0wrTWEyOWRiOG1vMVlCMUZqdHozNTZv?=
 =?iso-2022-jp?B?UCsyQVlMb2xlUTBNTGNMS0dia3JjVTNZc3o0THA0RUgzaTlIL2ZQeVpZ?=
 =?iso-2022-jp?B?U2ZsWnVyWElZRHJ0R3RFc00xUnZrVUJIdkk0QzkxN0cwazZyZWNQRDE4?=
 =?iso-2022-jp?B?b0Q0R2lWcktnMVdRSElML1VSN0c1YSt2ZEIxbCtibkxjUDJzZmlUVnNv?=
 =?iso-2022-jp?B?RndxdUpiNUZMYjlmR1h1WTVoUzdEUHVDMDI2bVQyblpFdzVXRitiREh3?=
 =?iso-2022-jp?B?ZG0zRk95S2NyV3BHU1plK2R4T1VPNGRMNzl0TThMWVdqMHVra3JpakxM?=
 =?iso-2022-jp?B?UFoxWm1GL1RzMjdXZU1PZ1ZTMHpTbUZ2YnhmNlN6V3p2OG94aGk0Qzh1?=
 =?iso-2022-jp?B?OWorcDRSZWNPZHBMVmdrdTZTL2VhRFkyWmN0dXRSR1VSUEJYMTJ4czJp?=
 =?iso-2022-jp?B?ZXVCK01xT1JYZUJMM0cvbkorWllDZ28wUG9VUCtuY0htOERXclRJYkl5?=
 =?iso-2022-jp?B?UitjNDBWNDBESFFKOHZlZnBVNllaeU45V09vYklvRGFzaXgyWW9adlg5?=
 =?iso-2022-jp?B?Z1pWOThuNXFUUi9QSnF1RUJRT0FuSWpvMmtPc0x2cytSWCtTcFJGMDBW?=
 =?iso-2022-jp?B?cHd2NnkvZndmaGR4cUhIZnY1TFlvSjBYRmVENXZ5UHNsc3djaElVZWJX?=
 =?iso-2022-jp?B?Z0ZXdGNYaWRVZm9Pei9jTGhNUmJ4SlRkR2tTSjkxUk9pbkY2dEEvQWk0?=
 =?iso-2022-jp?B?Zkx1V0lxbWlrMTlaZU5yM2lKUFpwSEZya0p6d3NONEdqYTQ0d2EzMStX?=
 =?iso-2022-jp?B?Vzg0UUY0bkc2TFVscVk1ejVCNThSWHFQZDRZQWpvZENuajZ1UDZ1a0o1?=
 =?iso-2022-jp?B?ZUdqWVlGS09iZDl5Tm5Fd1NzTGU4aHJTVDdWZy9tSHpmS0hPMlVMYmxV?=
 =?iso-2022-jp?B?RURoenpRMVRQWmdOekdRUkJON01GcHVVc3dUdThzMVdaTWNnd1pOSjhw?=
 =?iso-2022-jp?B?VGNFbGlqZHpTenhRUWZSNkxSQ1I1NWxsUEpvTWhCbStrdHRxdFd2MEZl?=
 =?iso-2022-jp?B?SGhNTnBvaXhtVnp5Q0E0eGppWkpMY1lmN1lFNXZoNFM4S21CTTladVh0?=
 =?iso-2022-jp?B?NWs0dm1aTDA2ekFaS3RFL2Q0SSszdzNoOE9GY1BwZWpSVGJBNHdwNFFS?=
 =?iso-2022-jp?B?Qy92WXFuYWFDdHBBSEhzQjFNQzVraTRyRVI2b3U3K2U5a0NZY1VXNmJa?=
 =?iso-2022-jp?B?MGo3VjBXbDRNUG1BWWJTbmFub05INnllUHFVTk9Mc1pGNC9HRVZIRHEr?=
 =?iso-2022-jp?B?ckRISHlFU09SZUUwKzA0ZUlVby9FbHJxMEpSUlNXTEpjVUQ1UzdPV09F?=
 =?iso-2022-jp?B?NTIzMzhNUWhweCtWUkpsTTI2WlduRmVHSnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB10396.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b74bb21-4f2c-4e17-f675-08de2cceb890
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 09:32:30.4153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mbx1ine+hfUakvsiyE+yNUfXod4LhLph19F6wHbjj0cxEiZzOz5gwXZAiciFAWjvTTRTVqf8SPT4ppt4o3v2jbPHiPvwWOQIST+TCPPENRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6547

Hi Vladimir,
=20
> On Tue, Nov 25, 2025 at 11:33:09PM +0100, Andrew Lunn wrote:
> > > Yeah, although as things currently stand, I'd say that is the lesser
> > > of problems. The only user (mv88e6xxx) does something strange: it
> > > says it wants to configure the TX amplitude of SerDes ports, but
> > > instead follows the phy-handle and applies the amplitude specified in=
 that
> node.
> > >
> > > I tried to mentally follow how things would work in 2 cases:
> > > 1. PHY referenced by phy-handle is internal, then by definition it's =
not
> > >    a SerDes port.
> > > 2. PHY referenced by phy-handle is external, then the mv88e6xxx drive=
r
> > >    looks at what is essentially a device tree description of the PHY'=
s
> > >    TX, and applies that as a mirror image to the local SerDes' TX.
> > >
> > > I think the logic is used in mv88e6xxx through case #2, i.e. we
> > > externalize the mv88e6xxx SerDes electrical properties to an
> > > unrelated OF node, the connected Ethernet PHY.
> >
> > My understanding of the code is the same, #2. Although i would
> > probably not say it is an unrelated node. I expect the PHY is on the
> > other end of the SERDES link which is having the TX amplitudes set.
> > This clearly will not work if there is an SFP cage on the other end,
> > but it does for an SGMII PHY.
>=20
> It is unrelated in the sense that the SGMII PHY is a different kernel obj=
ect, and
> the mv88e6xxx is polluting its OF node with properties which it then inte=
rprets as
> its own, when the PHY driver may have wanted to configure its SGMII TX
> amplitude too, via those same generic properties.
>=20
> > I guess this code is from before the time Russell converted the
> > mv88e6xxx SERDES code into PCS drivers. The register being set is
> > within the PCS register set.  The mv88e6xxx also does not make use of
> > generic phys to represent the SERDES part of the PCS. So there is no
> > phys phandle to follow since there is no phy.
>=20
> In my view, the phy-common-props.yaml are supposed to be applicable to
> either:
> (1) a network PHY with SerDes host-side connection (I suppose the media
>     side electrical properties would be covered by Maxime's phy_port
>     work - Maxime, please confirm).
> (2) a phylink_pcs with SerDes registers within the same register set
> (3) a generic PHY
>=20
> My patch 8/9 (net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and
> "airoha,pnswap-tx") is an example of case (1) for polarities. Also, for e=
xample,
> at least Aquantia Gen3 PHYs (AQR111, AQR112) have a (not very well
> documented) "SerDes Lane 0 Amplitude" field in the PHY XS Receive (XAUI T=
X)
> Reserved Vendor Provisioning 4 register (address 4.E413).
>=20
> My patch 7/9 (net: pcs: xpcs: allow lane polarity inversion) is an exampl=
e of case
> (2).
>=20
> I haven't submitted an example of case (3) yet, but the Lynx PCS and Lynx=
 SerDes
> would fall into that category. The PCS would be free of describing electr=
ical
> properties, and those would go to the generic PHY (SerDes).
>=20
> All I'm trying to say is that we're missing an OF node to describe mv88e6=
xxx PCS
> electrical properties, because otherwise, it collides with case (1). My n=
ote
> regarding "phys" was just a guess that the "phy-handle"
> may have been mistaken for the port's SerDes PHY. Although there is a cha=
nce
> Holger knew what he was doing. In any case, I think we need to sort this =
one
> way or another, leaving the phy-handle logic a discouraged fallback path.
>=20

I was checking our use case, and it is a bit special. We have the port in q=
uestion
directly connected to a FPGA which has also have a SerDes interface. We are=
 then
configuring a fixed link to the FPGA without a phy in between so there is a=
lso no
phy handle in our case. But in general, the board in question is now in mai=
ntenance
and there will be no kernel update anymore in the future. Therefore, it is =
fine with
me if you remove or rework the code in question completely. Hope that helps=
.

Best regards
Holger





