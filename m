Return-Path: <netdev+bounces-303433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zKHlFGBzRGr5uwoAu9opvQ
	(envelope-from <netdev+bounces-303433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 03:54:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA496E91EB
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 03:54:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b="FpT3EPM/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303433-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303433-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A6BE303CFAB
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 01:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FE6362139;
	Wed,  1 Jul 2026 01:54:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF3B3612F6;
	Wed,  1 Jul 2026 01:54:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870877; cv=fail; b=cQsWd+f+j/cFs6PIieltqLIZm6+Y8Lx8/k+HAQG5worQnPd3Qji7ZcrZkVCLuS9VLBvONQcLHu8ZsKXFl7Mv663R7ZeHE9zk0UGEB7UYmKHWZVDsSdJ1VOggKSFDwd+33lvQDCANydL/olxAvkV8oITv/y71e+7QXjx5BpRroRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870877; c=relaxed/simple;
	bh=uovCZINWu/g8P6/Il8iQACSPrUB+dJNUJxBHyVokZwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eYc05a7Vojn82YQwKHY1zrrdPyyiXiTfEgtyT7p/XpVukw+GwfpUWAu1oreoTP/1c475IBwJ6xZMiWhCsA+k/n86mSDUPBdqL1Mf9Wiambk1v3xtSSbqIqJ/UZt61Wjy0ktrMyMO/9N3lHBwqSQ0t+EfrfrjI/ZEhZtQjpvebDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=FpT3EPM/; arc=fail smtp.client-ip=40.107.200.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uceEzSUgIPNAE5lMx9fvBpiRIefL+0wyZqeTGRZNtYQD2vuRP6hSknA1RDFvNAZmLIEfFcyY4slhCENeEV59WOdIuvJjdmGqECkQesoHANxcOfxwA2rIx4dmUeqZMoxROziNPAgWMcI6NYMdzHxJgrtiJUyCRv9Er4aiswAtYNlFZIEMWRSQL3FwiaRqRiC7Wrqg0nKaj44XG78Y5EloG3cNhdQzHAXP5HudtYlOJo0n8cqpJ2FKNjU17ZKGpZH4FRCnizFsByraSW1qgaFaxcCqAjGlwb5cpmfLCmlBL5KLbbJnAA6rH/l3hrQJzYzzUNFjD+856tvmqeQwYrmwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uovCZINWu/g8P6/Il8iQACSPrUB+dJNUJxBHyVokZwM=;
 b=U4p8sLDFkoLniuU18/Zjq3rPnb/1BBS3nSPzTWPgCv1q47CunbRneTtl1AoLnFfTSJCwFgYqlosiSGY+yky5WhQaRHh/Ym5tZKGQjScWysbXVrUxDTpENpEMehvcnsO2s4AQZM2TFAhjbFQHCrTSi+2BRKCB6VX8PhFWDYIRB1eKNpQuI2/h9R4UPkFfCsOy94WRmJEXOa+nqDcI5wyseWoduXwQI5rgGZSS8oykNEEijoEPQY0h/gfwuLvh3/zkxw8rrcDcwuRYVXulcftp6NOx8Bpr1YJxxu0650k+qX/rKINzRC/C8zDN9Hr4BpiNyHvvZOzqX0Cs2EXNQQ/Mcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uovCZINWu/g8P6/Il8iQACSPrUB+dJNUJxBHyVokZwM=;
 b=FpT3EPM/5jnGv3Ftn7YfNu64OvvlsPwYERc7eamrml/clyZ43Qzc7BXeCqtnoaCAnE1FQjGd1dreZGi64/EorxXzIiSHDpI2r/yKkGocGOhL89a1fDAqUwLKZbkQjqc2JxcDS4sNqkK1yaRuhB0cIr2e+I9xqRGf/EJDFYFgbGCFd97C12/f5EGIEppb3vOG7p/qa1qGBJYYHOqrvHXazmGK6wmwAQe2khokk7I0F5ZTs7qZ7adKZolGRohi4sb9fXjkR5YrT4xAlWHRvhJuq47TsQjmvD6KMcRRviRFKyR8JcRTS/F+oVdjyaZyUGNnOOZSjb/+VOKD83G8Fdc9vQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by MW4PR03MB7010.namprd03.prod.outlook.com (2603:10b6:303:1a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 01:54:32 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 01:54:32 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "dinguyen@kernel.org" <dinguyen@kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2
 board
Thread-Topic: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2
 board
Thread-Index: AQHdCJS3eKbhTF393kOGxrO3eujj3LZXH+EAgAALkICAAAzEAIAAr76A
Date: Wed, 1 Jul 2026 01:54:32 +0000
Message-ID: <5a0c962e-1af0-4d6a-b871-d8a0b0197ff5@altera.com>
References:
 <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <edf84080-a5e0-478c-9977-af2376cb71c5@lunn.ch>
 <347c50ed-234a-4f29-b63a-1e0010c6b09d@altera.com>
 <e4cf8d95-0467-4bdc-8e19-228ced3a8bbc@lunn.ch>
In-Reply-To: <e4cf8d95-0467-4bdc-8e19-228ced3a8bbc@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|MW4PR03MB7010:EE_
x-ms-office365-filtering-correlation-id: 58143dc1-90bc-4dd2-aa3b-08ded713b1f0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|55112099003|4133799003|11063799006|56012099006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Ry823GCVcxmRaDB0l8UPjaGdOY4ksr0TcUQoZaayIH4LpWQqO8N1q01sopSVMfvi+WXgr6UrERsRyid6Ld6S2JjqGzrxuFKQIxmd67+Fb5YaFp2CwanRjLMafYeObzMDsRZQBLLgHXCjqgucHKLM8obI016FxKdRgvw9mRoNMuUkF9OEy5baU+PsrDvs8FoYis2t+pXk3AE3XKBoybWOHYx6FxltPeHTNXFJufl37DE1BnbSofwoYL1T14EBRY/mfsLiXXZiLIzK3k4LBCRlQFXonXAj0AYLQT2JnhPjLavMv8KFEhxlSUJ9MOssUz3qbMDuNCrJ67QrC8gSKbvSu8s6AnEK3lSpXz3GEE24kY4BF/NaouncifJMJI2sW/s1IGz+Kmeo7J1mTvk0N0sxR42X6vCfTzjv9ljsnq85aOIE2FwD3Bpg1KruTNBHX9bcU7o1xGqoWUVotCjoIl+ENiX9u+/oviZCKzXl8ZNM5UbwqUodh7eLCnqSZoL/uPxwIbHXiNs3JDQsDz/FoejEV9GhdWFtQwNLFTK8qQ4bpfRB7EPdoOALd46x59r+bHuu5yxZgTFyADr5U3ZUjxP8ONb+Wn98AFE5A+QrncIWMkqudyL2irjz8vwjsn9A3803M6q7V0gNveotBhUkHVEqZeFOsRD385v6DrpPKUfuzpM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(55112099003)(4133799003)(11063799006)(56012099006)(4143699003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDZkWWMyNlV0Zml4NjBFNmpCc3FWd1pBYzFBUWhpa0RHTEJpOHArUGpPU2Fw?=
 =?utf-8?B?SE0wMENDN0pDQlBRYkJSTGg4end5TXYvRzFPN0dwSXczaVMweG4vVGRlVU1a?=
 =?utf-8?B?WU9mbVZGWTJwa1ZSbzNzck5YbElmRjJZdXN3NWFxK3RKdFdhWmdNY1M1eEFq?=
 =?utf-8?B?UHoxS01nYWNyUWdyNHIvcmdFQUZ0SHZwd2RubFhrTGNKdDJSR25mK2lacUN6?=
 =?utf-8?B?WWl3eUdWMUVLUnA0cUNVSEZ2Q2dRVzE4eldvUHZxNWRDN29FZGhYZjhhc3h4?=
 =?utf-8?B?WXF6ZVJuYW9VRXorRGJUWmVKM1BmcE5LSDZUOWxMcFpxSUtVUkYxZC8va2Mz?=
 =?utf-8?B?b2JnQWE2OUJPTmVUcXdINmJlczl4ZCtmbmdTc2lOQTNqT1hJSlJUZCtsY1hC?=
 =?utf-8?B?S1VTYlI3UDBzUHpBM0pKQzFuR3ZmMG43MDBTaS9CdmhkK0UwWThJb2JjdWZ1?=
 =?utf-8?B?bW52LzJ4SDBQdjk4ckxQTU5IZGE3RWFQUHlsdVhsUEVVWHlycFloUmFJN0ts?=
 =?utf-8?B?aUxaL2pDSXFueVRONlNGb0tPbXF4cXB1TXhDb1pLOG9wVzAyc0N3NnphY2RS?=
 =?utf-8?B?UDJST3hZc3ZqZ0s2Y3ZzbmxtU1VqNEpadEZhcTUrZzg5aVVTVzdwaUo5M0Iz?=
 =?utf-8?B?QlJBUkVPK3l2Yi9UcC9WelJrN3ZZUkRkMy9IM0RrZ1B0d1NzSVF4aTZ4SVln?=
 =?utf-8?B?dEdmRUtuY1N4UGtNMFptaTZOSVAxbE1NaFRDY2huNVZNcjBNbW9FS2lBa1hs?=
 =?utf-8?B?NWJsMWNmZzlmREhHaVNic0hlOU5GeDlZRVJvd1ppNlBaOGJheEhhbE9paVdD?=
 =?utf-8?B?a2J4L3BFOTN6d3N3b3VBcU1rQlRHTGZxYktmUnZNTTU0SXBsQ2xXNG5NYVQ4?=
 =?utf-8?B?NVV4cm1FR2NESUE2UlVQdFhiUWorZjdVY004aGp0NDNWYjFKS28vSXBCM2dT?=
 =?utf-8?B?MTg3aWk4OGJCdFpWY3Y4Nlg5S2pTejdIOWxtcFN3NXdXN3B3V0dVNEh6MEx6?=
 =?utf-8?B?YU5JNXQvSDNYaGVGWXJRS0kxQUJHM3U0TWFaRmw1Y1Z0UmpqL3NVNXZKYnY3?=
 =?utf-8?B?NElWZFBqS1BZbnV0dVdVMDhZSEtHaTFZUXJxNGZHVkx3QS9IM0VlOFM5eml5?=
 =?utf-8?B?dE9BZG9SejlaYzVXZXg1M1ZiU0pDVmpLckFKQTQ3VFFqaDRwVUJjTGR6OXNB?=
 =?utf-8?B?by9ESUZoQTFCM3FrMjJ0eVBOVUV0S1AzSzcyTklXQWdZM2FtdWY2V0Jiak5L?=
 =?utf-8?B?OEFpa3BXUVI5T2dMcHJQR2Z4b3BYbGVlSGxxVmFrVDJZRTFUUEthR1hrOW41?=
 =?utf-8?B?VnZwRWZmWURhdS8vd0N3VWJpclF1ZkhpWlNjK21tSUJ3b3c1cDk4K3QwcFVF?=
 =?utf-8?B?RTdqdlFOYzdVVDZXNkV2RVNFYVlnMEZNWFlJQ2dvNWpKbVVFUjJYQkJ2ZHRn?=
 =?utf-8?B?N1doU0VmVjZodktKRTdUZVRHQnUwRFp0Z2g4RGJTQUJZSExjTnJsWFFpY3B3?=
 =?utf-8?B?ek1NSWZMOFR5d25MNzlkM1A5Ukx3YjZGbzVWSXVQcm5nVkg1YU0xWWNqZ09u?=
 =?utf-8?B?T1Nra3AzRGpWSE96ZWhFT25vWUlieVlURGVweWEvTVREMFM0RmZRdFJyc1Zk?=
 =?utf-8?B?TXlvUkNQZnBoZzIrb0czRDl4N2xTSDY0UzJYRnNBZjRmUjhJcm5XUFM1N0ZD?=
 =?utf-8?B?T2xUZ2hZREswOStKV3R2KytXWndNdC9rQkF4angzZlJJUGR1U3crYlk3VkFY?=
 =?utf-8?B?Ri95VVZtejRCWUZnclMxYkZwck4wa3RoTThqN3lnanR6SytwUjE4RVB0Uzcr?=
 =?utf-8?B?dFdKK3Z4MzVaajY5eTJBVzF6Y0FhUExvclpmS2NJWi9ZdUdzWk0vbmN1MEtj?=
 =?utf-8?B?ZnZ4Lzhjbk8rOURxaUZyaHg5Wlp2Q2hPU1BqYkQ2RWNwalBKMDZiZG1Pelh5?=
 =?utf-8?B?cE0xbUJkS3Z2YWgwdVVMWXcrcFhjc050bkRqU2lzd3YvcG5saVNiUGhick1X?=
 =?utf-8?B?K2hjQ3BETjVGU1lySjFMRG1jK2U5OUpKcEhQbGtTdHhXbDE3WWhtaDh3TFNl?=
 =?utf-8?B?V3FJSWdtU1FXY1I3eUVkeUorOWRmSEpyeXV4Y2RDMzRKREdXNHlLaWJHSHhy?=
 =?utf-8?B?S254NVlFOUp6bG03VHkwZVBwMHAyamJabUxNWnZhWHZDVk1RSlZ2VkZHSzlv?=
 =?utf-8?B?aVJMdEpYckhnc21vd2xFVG1sOUFOM1VKYndwUkFKcWFvRWM3NzZrQ1NSWDhR?=
 =?utf-8?B?L211VDFVY2dCZ01MTFg0aHI1KzFrU3RFRmsySWM5MytiZGV6dU1qM0pRMnJM?=
 =?utf-8?B?R0dLaG1GVXlsRTl0Zzk1L1F1TlY0bGFadHBUYnlUa2p5Z3J4Wlp0ZkhKTGtn?=
 =?utf-8?Q?0UcPf9kFQt2CGWX8cQrMqSq2uSr66hB3UjrH1y2CnAjfZ?=
x-ms-exchange-antispam-messagedata-1: Y6z5NjiOIEjgqi4/OwR4CrHDPlo94dInhFk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27AAD0A6C9AD9044A2441CE3877B4137@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58143dc1-90bc-4dd2-aa3b-08ded713b1f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 01:54:32.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bkeaLmxQ/skdFXOKayfAiMJdcTVeK/wUIrUuiTvQcBouEfXhbcNzlilYSBr5pCerTUXtipQjQ1cvhFuguOPP+GJ/JI1jpMdSGt2gytAYVx+ZnmQXI7sW25DRV+7Kh1khpJDn42i2/Oh4FrZvnW4/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB7010
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303433-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,altera.com:dkim,altera.com:mid,altera.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEA496E91EB

T24gMzAvNi8yMDI2IDExOjI1IHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4gT24gVHVlLCBKdW4g
MzAsIDIwMjYgYXQgMDI6Mzk6NTBQTSArMDAwMCwgTmF6bGUgQXNtYWRlLCBNdWhhbW1hZCBOYXpp
bSBBbWlydWwgd3JvdGU6DQo+PiBPbiAzMC82LzIwMjYgOTo1OCBwbSwgQW5kcmV3IEx1bm4gd3Jv
dGU6DQo+Pj4+ICsgKiBnbWFjMSBpcyB0aGUgVFNOIHBvcnQuIFRoZSBNQUMgb3BlcmF0ZXMgaW4g
R01JSSBtb2RlIGludGVybmFsbHkNCj4+Pj4gKyAqIHdoaWxlIHRoZSBQSFktc2lkZSBpbnRlcmZh
Y2UgaXMgUkdNSUksIHNvIG1hYy1tb2RlIGFuZCBwaHktbW9kZSBkaWZmZXIuDQo+Pj4+ICsgKi8N
Cj4+Pj4gKyZnbWFjMSB7DQo+Pj4+ICsgIHN0YXR1cyA9ICJva2F5IjsNCj4+Pj4gKyAgcGh5LW1v
ZGUgPSAicmdtaWkiOyAvKiBUWC9SWCBjbG9jayBkZWxheXMgcHJvdmlkZWQgYnkgQWdpbGV4NSBJ
L08gaGFyZHdhcmUgKi8NCj4+PiBDb3VsZCB5b3UgcHJvdmlkZSBtb3JlIGRldGFpbHMgYWJvdXQg
dGhpcy4gSSB3YW50IHRvIHVuZGVyc3RhbmQgdGhlDQo+Pj4gYmlnIHBpY3R1cmUuDQo+Pj4NCj4+
PiBOb3JtYWxseSB3ZSB0YWxrIGFib3V0IHRoZSBQQ0IgcHJvdmlkaW5nIHRoZSBkZWxheXMuIFRo
aXMgc291bmRzIGxpa2UNCj4+PiBpdCBpcyB0aGUgRlBHQT8gU28gaSBuZWVkIGNvbnZpbmNpbmcg
dGhpcyBpcyBjb3JyZWN0Lg0KPj4gSGkgQW5kcmV3LA0KPj4NCj4+IFRoYW5rcyBmb3IgeW91ciBx
dWljayByZXZpZXcgYW5kIHllcywgaXQgaXMgdGhlIEZQR0Eg4oCUIHNwZWNpZmljYWxseSBhDQo+
PiBzb2Z0IElQIGJsb2NrIGluIHRoZSBGUEdBIGZhYnJpYyB0aGF0IGltcGxlbWVudHMgdGhlIFJH
TUlJIGNsb2NrIGRlbGF5cw0KPj4gYW5kIGlzIGNvbmZpZ3VyZWQgYmVmb3JlIExpbnV4IGJvb3Rz
IHZpYSB0aGUgRlBHQSBiaXRzdHJlYW0uIFRoZSBkcml2ZXINCj4+IG11c3Qgbm90IGFkZCBhZGRp
dGlvbmFsIGRlbGF5cyBvbiB0b3AuDQo+DQo+IFNvIGl0IGRlcGVuZHMgb24gaG93IHRoZSBjb252
ZXJ0ZXIgYmxvY2sgaXMgZGVzY3JpYmVkLCBidXQgLi4uLg0KPg0KPiAgRnJvbSBhIGJpZyBwaWN0
dXJlLCBNQUMgYW5kIFBIWSBwYWlyLCBpdCBpcyB0aGUgTUFDIHdoaWNoDQo+IGltcGxlbWVudHMg
dGhlIGRlbGF5cy4NCj4NCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTUv
c291cmNlL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZXRoZXJuZXQtY29u
dHJvbGxlci55YW1sI0wzNDYNCj4NCj4gIyBUaGVyZSBhcmUgYSBzbWFsbCBudW1iZXIgb2YgY2Fz
ZXMgd2hlcmUgdGhlIE1BQyBoYXMgaGFyZCBjb2RlZA0KPiAjIGRlbGF5cyB3aGljaCBjYW5ub3Qg
YmUgZGlzYWJsZWQuIFRoZSAncGh5LW1vZGUnIG9ubHkgZGVzY3JpYmVzIHRoZQ0KPiAjIFBDQi4g
IFRoZSBpbmFiaWxpdHkgdG8gZGlzYWJsZSB0aGUgZGVsYXlzIGluIHRoZSBNQUMgZG9lcyBub3Qg
Y2hhbmdlDQo+ICMgdGhlIG1lYW5pbmcgb2YgJ3BoeS1tb2RlJy4gSXQgZG9lcyBob3dldmVyIG1l
YW4gdGhhdCBhICdwaHktbW9kZScgb2YNCj4gIyAncmdtaWknIGlzIG5vdyBpbnZhbGlkLCBpdCBj
YW5ub3QgYmUgc3VwcG9ydGVkLCBzaW5jZSBib3RoIHRoZSBQQ0INCj4gIyBhbmQgdGhlIE1BQyBh
bmQgUEhZIGFkZGluZyBkZWxheXMgY2Fubm90IHJlc3VsdCBpbiBhIGZ1bmN0aW9uYWwNCj4gIyBs
aW5rLiBUaHVzIHRoZSBNQUMgc2hvdWxkIHJlcG9ydCBhIGZhdGFsIGVycm9yIGZvciBhbnkgbW9k
ZXMgd2hpY2gNCj4gIyBjYW5ub3QgYmUgc3VwcG9ydGVkLiBXaGVuIHRoZSBNQUMgaW1wbGVtZW50
cyB0aGUgZGVsYXksIGl0IG11c3QNCj4gIyBlbnN1cmUgdGhhdCB0aGUgUEhZIGRvZXMgbm90IGFs
c28gaW1wbGVtZW50IHRoZSBzYW1lIGRlbGF5LiBTbyBpdA0KPiAjIG11c3QgbW9kaWZ5IHRoZSBw
aHktbW9kZSBpdCBwYXNzZXMgdG8gdGhlIFBIWSwgcmVtb3ZpbmcgdGhlIGRlbGF5IGl0DQo+ICMg
aGFzIGFkZGVkLiBGYWlsdXJlIHRvIHJlbW92ZSB0aGUgZGVsYXkgd2lsbCByZXN1bHQgaW4gYQ0K
PiAjIG5vbi1mdW5jdGlvbmluZyBsaW5rLg0KPg0KPiAgICAgIEFuZHJldw0KPg0KPiAtLS0NCj4g
cHctYm90OiBjcg0KSGkgQW5kcmV3LA0KDQpUaGUgZGVsYXlzIGFyZSBwcm92aWRlZCBieSB0aGUg
RlBHQSBHTUlJLXRvLVJHTUlJIGNvbnZlcnRlciBzb2Z0IElQLA0Kd2hpY2ggaXMgaGFyZGNvZGVk
IGluIHRoZSBGUEdBIGJpdHN0cmVhbSBhbmQgY2Fubm90IGJlIGRpc2FibGVkIG9yDQptb2RpZmll
ZCBmcm9tIHRoZSBkcml2ZXIgc2lkZS4NCg0KVXNpbmcgcGh5LW1vZGUgPSAicmdtaWkiIGlzIGlu
dGVudGlvbmFsIGhlcmUg4oCUIGl0IHByZXZlbnRzIHRoZSBQSFkgZnJvbQ0KYWRkaW5nIGl0cyBv
d24gaW50ZXJuYWwgZGVsYXlzIG9uIHRvcCwgc2luY2UgdGhlIEZQR0EgY29udmVydGVyIGFscmVh
ZHkNCnByb3ZpZGVzIHRoZSBmdWxsIHJlcXVpcmVkIGRlbGF5LiBUaGlzIGlzIGNvbnNpc3RlbnQg
d2l0aCBob3cgYWxsIG90aGVyDQpBZ2lsZXg1IFNvQ0RLIGJvYXJkIHZhcmlhbnRzIGFyZSBkZXNj
cmliZWQsIGFzIHNlZW4gaW4gY29tbWl0DQpjNTYzN2U1Y2ViNGIgKCJhcm02NDogZHRzOiBzb2Nm
cGdhOiBhZ2lsZXg1OiBGaXggcGh5LW1vZGUgdG8gcmdtaWkgYXMgSFcNCnByb3ZpZGVzIGNsb2Nr
IGRlbGF5IikgYWxyZWFkeSBpbiBEaW5oIE5ndXllbidzIHRyZWUsIHdoaWNoIGFwcGxpZXMgdGhl
DQpzYW1lIHJhdGlvbmFsZSBhY3Jvc3MgYWxsIEFnaWxleDUgYm9hcmRzLg0KDQpCUiwNCk5hemlt
IEFtaXJ1bA0K

