Return-Path: <netdev+bounces-189895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1ACAB4715
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAF18C2D9D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA225C6EB;
	Mon, 12 May 2025 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="eDgSVR3N"
X-Original-To: netdev@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020082.outbound.protection.outlook.com [52.101.171.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F13255E47;
	Mon, 12 May 2025 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087381; cv=fail; b=F6HoWdYSgkJGgSLrHc8u+XIJKOT9aNzia2qG+DMgmLpSXSsTxsqXEw8zZRE0Aae4aT8fEQ3bAtVMRAwInxMZ2nxdreDc4IJS6oJladWszPxCe/1e0STDncMack4LD+iAFQmbSpfPrPsTq1dpLra1p7rPciyQqAvRzfVHMVyOmGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087381; c=relaxed/simple;
	bh=MPjg1JTYMEHic0AiioiwoDHfWWtMh9wRN4uLgWElINw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l9jHGMdQo+v6GyD+kN6kJoGDTbtUtwQxacg/5QUr1DLXZ73M/6eZc83zGtkFSttlsaAhoUfOvSWGfYq1qclUJ3PbQT9t5C7NGaLXETEybNelkb4PlGSIeYuAYFLq/GAAgN9EQfa5qyVXDHgVfoLjFXGrmokCmaa9as7GcqlzlHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=eDgSVR3N; arc=fail smtp.client-ip=52.101.171.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYYE6B5Dn6iU5b/tbabXcMDbzNLbA+pDAvbOBs5d0kM/6bI1apoetv2cl4EwvdRR4mC0VIBuvH2Xle7LJozQH/ZW2LuFzG+5VFTZguJ5h/T38Dnm/qe/tMkDSguHUvrw7kNNBh5YJfYGNkvmGqfG3U1n72qmV4+h2eOiEGZ4jgxQpWjYjdCt2T5aESQIoWQ0t3LM2TeHEgZdPW1p5EAn+yz6AEXiLMFhcxCLW5anKXMUCuGGNnORBBKFH+uixBzbAjYxq/ImD7Pi7O/Q3ZvwEhslkQqiP8Lx+fP1K05XE6iX6GNu6AueYbUx7bNfPqfc3NtG2gJMmsn4I9oMaFr4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPjg1JTYMEHic0AiioiwoDHfWWtMh9wRN4uLgWElINw=;
 b=h3l26fh15u0nTGMv99C9DHoacrMg203Je19aiMt+3t3VC2j6/iaZRWJKWuAf45WD4cyg6Bb01/JMYhVXu6GReJXS4eBXhPGuXF7+neh6PjIM6rKn8PaHjkzzWRLOBmjaELdvXr8+wQcpVgMOkYwupHnOq9IFOkbpM7PnMKa5b4P0EjnLsC/VMTrNmu3aneoSeDnhPYtcrAo869U21ggE2jB8gp0di6/BcfeH9WdqnBE+ESpOrZD71FK0hia3ocoSor8y4Dh9aNp0QjRRIXEUqCCBuyBJXkmWjrFd89/S5kxQkuJHlqXmT06V6Sg0MidZISxSYc6kqq8R97FSNWaGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPjg1JTYMEHic0AiioiwoDHfWWtMh9wRN4uLgWElINw=;
 b=eDgSVR3NPdl8Mo8DQWTdFOBuZiASSzZy5hL6H27cXbCfq/Gj8gLSCpVlnnerDzSXo4KN0WwndqSzxTj7S6GIfHBPYi/OOAxbYtk0DrXe1tR2Gu8S9/cOFXHAOdagr4hLeLqDmNOuaEJqXVryhKVKhuDRdKep5Kloo/FJH2tx8Ag=
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:43::5) by
 BEYP281MB3892.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:b7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Mon, 12 May 2025 22:02:52 +0000
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192]) by FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 22:02:52 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/2] Add Si3474 PSE controller driver
Thread-Topic: [PATCH net-next 0/2] Add Si3474 PSE controller driver
Thread-Index: AQHbw4mbQyZIOLsNPEGDB3EuUHIC6w==
Date: Mon, 12 May 2025 22:02:52 +0000
Message-ID: <bf9e5c77-512d-4efb-ad1d-f14120c4e06b@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB2224:EE_|BEYP281MB3892:EE_
x-ms-office365-filtering-correlation-id: 07b18b2c-0e90-4557-3aca-08dd91a0bdbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d1Zwb04wY1NldU83ZFByQTFWOFZ3SlZMYkhvWlkrZC9URU1GeTdRdysySEo0?=
 =?utf-8?B?T2VqTGF6R1dMTFNUaE5qcW53Zm5tdnlBQm9ZcjZkbTMzZm12NTNnTkdTYmZ6?=
 =?utf-8?B?TVROeXh2VGtQNklwWlNkR0pTRkVMTEkxTTZ2ZG5jZ28vbnN5RUk0bFFWeTh2?=
 =?utf-8?B?MTlzcTlMZWNRV29iWDdNdmZSUTBzaTJ1SWxuSnpjd0tST3VQc3VHTTFjWVhP?=
 =?utf-8?B?YkNzdFVtR2k2QXhyaWVHUmJLK0xyMVI1SVFwYWozODhlRGlSK3N0U21IV0tY?=
 =?utf-8?B?ZFJRa0RNK0QzdVlEU3JRWHBuMUg4TFBiYWZOMTBoRVM5bVNSaU5lS1QvdUpi?=
 =?utf-8?B?NUpnQmVIbUNNVmV6Q0d0d3A3WlpQY1hRUUd4M1FmN2NiR2c5b1hrcnB2b2R2?=
 =?utf-8?B?STg2VktZNWx5Qjk4K1NDSU1aNDYxNk4yckFWbjJZVEFEcW5KL0owbC9pUXd2?=
 =?utf-8?B?Ky9xSCtNeG9Eb29HV2ttTG5JL01ocG9LNTNGK1JoMmFSMStkTGhDMFNSdnVO?=
 =?utf-8?B?MWt3UWJEUDNvUUczd0JxZnpMemwrdER1WFptV0c5MHJjV0ZpdDlROVpyamZk?=
 =?utf-8?B?Q2ZaUldXNzFubEhHWGJzbExjMk10ZkxuZHljVHEweit1SFlBYXNWTFYxZjBv?=
 =?utf-8?B?V09RNXREZ2VJKysvQVJvc2g3clNDR0gySnNLRDNHZnhYbk9lN2VaT1Q4VytF?=
 =?utf-8?B?ZFJMWWFibktPNGVvdkJLcnZJM2R1UFRNeWtDaUhRUFBwV0VCakJKanpRWEtk?=
 =?utf-8?B?MUZkOVY3dUdwSm1uaVl6Uk5YUmk5VnVKRlNpbUw1aWYrQVBUNUFsQ0xFZnFG?=
 =?utf-8?B?c3lKMmkyc0NacGoyd20xNkpqNmVtaXJoeUF3elJkdzNqOC9lYjdkV0w1UkZS?=
 =?utf-8?B?ZXlIT3JoSEtuK09xUWphdkZPZEVWbEIrMUp3bGh2c2NpRTR3TkhmY1IvQUJk?=
 =?utf-8?B?cUMzNUJ5YmR6MGhnbU03UGhCUWZucFhtM09hYUdlMyswcHB4cm5FZVRzR1RI?=
 =?utf-8?B?N2hLd0hpeTJTVWhXY25Tc2hFYXd4RFA5TmlvQjUwWTROUk00aWNSazcvOFNG?=
 =?utf-8?B?ZE1qMUxJdkdFdjlzaWVJVXVrOHJFZnBGRzVJaHRTMEszUmdtaFdTQ1p6ajc5?=
 =?utf-8?B?NGUyN2d2MzdTV0xaWFgyVXJFeE82QzF2THdKMHFVaEFWcWVQNXdzTjFLcXlY?=
 =?utf-8?B?MlRRSU5JSHErM2ZSMmRkK291SnNRQjA2ZjlMM0xvWWF1cXZHempyM3phWEN3?=
 =?utf-8?B?dDBqNzBVSFZNTE55MHpYTVB3enBwSEZDR0hLZWN5b3B2YTdDS0NDUEtDV3ha?=
 =?utf-8?B?OE9BSE9jWkc2ZTZEMUxCcW1GMlJva1pkb29VM0RGV3VOdlgzNHlDWjc4VzVC?=
 =?utf-8?B?VFpSTFBDenVtZ25KcEJDajJpV2tMNlU1NGZUVEdMTE03V1FoajVoUmF5d0Zv?=
 =?utf-8?B?RnY4enQ1L2NGN1ZOeGRSQUtwbXB5eXRFRVJ1eXhNYy9NbjBLNXhQM09lWHdv?=
 =?utf-8?B?WitTZ2JXc2xoUlF2MThSSHc4NGV1Ni9vSmdYOG8vclFQY2JHcmhmNHZxemlE?=
 =?utf-8?B?NXlteUV1Y29FVDhwdk1BRW4zSzlqRitSRnNQRW4rMlpJbEl4TVJhMWZRL2c0?=
 =?utf-8?B?ZWtYK0o1UUorcW5Xck5zQ2xvaEhlaVpTMDFCQ0tWZG5aUDRKRUN1TTZvVDZp?=
 =?utf-8?B?WHdXRmlpYkk5aVFmVFhka0xKL3NOdE9WQUlKN0ZSRS9oenBZVDJoNlRneVdG?=
 =?utf-8?B?emNCQk56cmNWSVFUdDZLbGVJb3dZV3VRSkhjMVJXdXJjc2RuT0FGREtjQm01?=
 =?utf-8?B?TmcwL0hMUCtXNksxbnJYYTdnMFozbXhOenR6UGdSRThsUm9ocTVPM1RWbkhq?=
 =?utf-8?B?ekZubHRJMWJyRVAwR3U4clBZZ2pwUVY0Q0xGa2p4Qy9yc3N0OFlqTGdBUHBR?=
 =?utf-8?Q?uHwihPsOIpvT/u+2jXdHvGVioPD8VA4/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHMvbXlBTjFxMkkyVHlpbUxyamVVaXI4U015eXYzbDJEeE5HSGV5bEtiSGNX?=
 =?utf-8?B?N1NGaFhPY2toemVIODN5RzlsR201aGdNQmx6MTRmYVcrY0cwL1ljUjg3NEx0?=
 =?utf-8?B?a25NMWMvQUpJMXJ1UUtCNkRLUjltQmlLSEx3dCtPbm9zbDNuSEJWeVlOMkVn?=
 =?utf-8?B?Y0V6bVQ4ZlIzc3YxQXBVVm05UHZtT0kvdWxmb2NPM0xMWmh5VlNUSElJRDRj?=
 =?utf-8?B?SUZWNnlOMGgyQUtjcE13T0QvNHRvSVhSZHNhTmxWV1I1dHpPQ0dUVVR5clZw?=
 =?utf-8?B?OWtEYm9QVW81TU5lVjZqenZrdVJOd1RlVjI0ZkdublY4TmRqczdNYjhjVGk1?=
 =?utf-8?B?YWZvWkppMTBBdEJRMTFQZ0VkTTVpYitlTWNRSUZMOEtJRFVYOW0vQlhGWEpH?=
 =?utf-8?B?NGJkbUFVc01haWpCVHovNytnMWF5cHdFTERSTEdmMFByK25lKzE0Umo3NUZh?=
 =?utf-8?B?QTZ5YUR6V1dVNjZDR3p4Z2tESTJ6bENpbFN4bXJHNmFOWWpzQjZDZUtySjNG?=
 =?utf-8?B?cE90SDJSWmIwRGpTOE5wZEd4RElLbWJ4R3M2cHRrc2lQV2pDM0FZTkxCSHQ2?=
 =?utf-8?B?eStMUSt4RXl4MTlmUlNmdjJMeVNhSG5rWlVDYm1Zc01FK2E1RGpaemI0WEwz?=
 =?utf-8?B?ZUhkbk5pSW4wbFJmdXhOeld2bUxXQjNSM1ZxNk42RHIzcEVzVHZtNkRyODBi?=
 =?utf-8?B?R2hnV252VVBDYXRNRE52bUs4VkE1R0JLbmV5dVEvZk5iYjJQTmE4WW4rYVdr?=
 =?utf-8?B?NktkODV2ZGgyQTNCd1drVDBiaUdXdUp6cTRYOS9ZWGFCQVJOdkViRkNrWGZw?=
 =?utf-8?B?QVFCTk5pSFpDRjlPWkJWSFMyeG0vWmtoYzNqVXl3ckMvd2VMbFhBazRqempB?=
 =?utf-8?B?d3ZBM2VJc1NIbjlGQTRxWnF2SWJXUDhmcFdqQXFUU2l2R01EblduVTRESUFW?=
 =?utf-8?B?VzllZ291TUFBR0c5QldrZWFwbk5iMy92a1Z4QXdBbVRPdXV2WkpQWUJLd09p?=
 =?utf-8?B?NjhKL2tzUU1Pb1VKUE02YjZnR2UrVDlMMkJIbXp3UlA5WnplZ2pGcDVLY2ps?=
 =?utf-8?B?cmlsZDIxMVNrZi9UK3U5UVFROTk1WlNnaG5iMGpnZjJoN1V0UXE5RmM3VTJv?=
 =?utf-8?B?M3Y3My95cXp1VnA2OUpWVCsrQzk3OThXd0JUdVBkZFkxeEVib2NDQkhySVor?=
 =?utf-8?B?MW9wUzF0NC9RTE9lUlN1NFpuWXo5MVROUkVHcG5VYnp2cnNBSGhzYkYwUlJk?=
 =?utf-8?B?TzV6UGh4TncwWWRkSVBaTW1oQzFoWTZ2c0thcmJxcWIrTVdLbDExV1l1Rkp5?=
 =?utf-8?B?dDVHTVdHUlNDZFZoRlNZd1J1RjhxMWRCek5MKzQzb0x1N2tnMG51WVZYOSth?=
 =?utf-8?B?R3psSm4xWmN4OE42ZE5kdm9TMlUzMWlRYm9VakUxdDFTY3pCMEF2UEN3SnFu?=
 =?utf-8?B?Ykh4anc2bWtNUnBEbmh0ZXhJMzVCTFNzOXZhQjM1YUd5Sk9rVFpyTGdQZE93?=
 =?utf-8?B?YVpxaDU1ODBhTTU5OFhyc3pjV1E2LzBjUE8zMG92Z0I1UUVQeTQzTElsaW4y?=
 =?utf-8?B?TmNXR2wzOTlmcVNUTjZyS04wT0c5dE8yeS9jK0x6UkVoRm5weDJENGZxakJH?=
 =?utf-8?B?SnNBMm9vZHMrZ0dGaTFJYnlURUNNdXQ2TmQyVURYazFGMFJ0Wm9oZm9aNGF2?=
 =?utf-8?B?bkxWdFFXS1lxWEN6WVErS0FiaWNMR1VFUVpXdk1ZSlFXUFRhd2VoNTdDcEpQ?=
 =?utf-8?B?ZGJuQnhqR1hSajFtdGs2QnN4Y09PRzZDK3U1bFpmcUQ4V2NZUW1kS1ZHdjRR?=
 =?utf-8?B?UG1PdXU5c3l3NVRJY3ROMGJNcUc5RHNGSnFad2wyL2NKTE40eFo4UHpHdkNI?=
 =?utf-8?B?bVhhdmJHNGROZisyM1dZeS9xOGE2T2lRMklWdTJpOTRNbyt0aW14bDNWT0xZ?=
 =?utf-8?B?dVZRbnVoL1dDcUZLSVFkbGN6M3BsRDhuMU95NFI2c3Q1WEU1L2tOcVdvc08z?=
 =?utf-8?B?Qmg3Qk0wQ2NSd3Z6bDc2VVB2WG12Lzl2dTFIRTVYbGYyWlRDRTlQU2xqQ0tO?=
 =?utf-8?B?NERLLzV6WmlXMzZjSVYvK1RsbGE1QVYzYjB2UWFWekttYlJRWFgwa0xLenZ3?=
 =?utf-8?Q?zH/6jWeS/8t3Qttux5K9LOjCN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF25F0D00FEAC64DAC8B60D2C24F057A@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b18b2c-0e90-4557-3aca-08dd91a0bdbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 22:02:52.0141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXM/n3S5t/Tj8jQ+wtJ5cbov383domB9iuCorli5Y9Kgzk8kskGf3syMolTZDlqm7rVlcKwIqApTBzA5Xk+qKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB3892

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNClRoZXNlIHBhdGNo
IHNlcmllcyBwcm92aWRlIHN1cHBvcnQgZm9yIFNreXdvcmtzIFNpMzQ3NCBJMkMNClBvd2VyIFNv
dXJjaW5nIEVxdWlwbWVudCBjb250cm9sbGVyLg0KDQpCYXNlZCBvbiB0aGUgVFBTMjM4ODEgZHJp
dmVyIGNvZGUuDQoNClN1cHBvcnRlZCBmZWF0dXJlcyBvZiBTaTM0NzQ6DQotIGdldCBwb3J0IHN0
YXR1cywNCi0gZ2V0IHBvcnQgYWRtaW4gc3RhdGUsDQotIGdldCBwb3J0IHBvd2VyLA0KLSBnZXQg
cG9ydCB2b2x0YWdlLA0KLSBlbmFibGUvZGlzYWJsZSBwb3J0IHBvd2VyDQoNClNpZ25lZC1vZmYt
Ynk6IFBpb3RyIEt1YmlrIDxwaW90ci5rdWJpa0BhZHRyYW4uY29tPg0KLS0tDQp2MjoNCiAgLSBI
YW5kbGUgYm90aCBJQyBxdWFkcyB2aWEgc2luZ2xlIGRyaXZlciBpbnN0YW5jZQ0KICAtIEFkZCBh
cmNoaXRlY3R1cmUgJiB0ZXJtaW5vbG9neSBkZXNjcmlwdGlvbiBjb21tZW50DQogIC0gQ2hhbmdl
IHBpX2VuYWJsZSwgcGlfZGlzYWJsZSwgcGlfZ2V0X2FkbWluX3N0YXRlIHRvIHVzZSBQT1JUX01P
REUgcmVnaXN0ZXINCiAgLSBSZW5hbWUgcG93ZXIgcG9ydHMgdG8gJ3BpJw0KICAtIFVzZSBpMmNf
c21idXNfd3JpdGVfYnl0ZV9kYXRhKCkgZm9yIHNpbmdsZSBieXRlIHJlZ2lzdGVycw0KICAtIENv
ZGluZyBzdHlsZSBpbXByb3ZlbWVudHMNCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRk
ZXYvYTkyYmU2MDMtN2FkNC00ZGQzLWIwODMtNTQ4NjU4YTQ0NDhhQGFkdHJhbi5jb20vDQoNClBp
b3RyIEt1YmlrICgyKToNCiAgZHQtYmluZGluZ3M6IG5ldDogcHNlLXBkOiBBZGQgYmluZGluZ3Mg
Zm9yIFNpMzQ3NCBQU0UgY29udHJvbGxlcg0KICBuZXQ6IHBzZS1wZDogQWRkIFNpMzQ3NCBQU0Ug
Y29udHJvbGxlciBkcml2ZXINCg0KIC4uLi9iaW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNp
MzQ3NC55YW1sICB8IDE0NiArKysrDQogZHJpdmVycy9uZXQvcHNlLXBkL0tjb25maWcgICAgICAg
ICAgICAgICAgICAgIHwgIDEwICsNCiBkcml2ZXJzL25ldC9wc2UtcGQvTWFrZWZpbGUgICAgICAg
ICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvbmV0L3BzZS1wZC9zaTM0NzQuYyAgICAgICAg
ICAgICAgICAgICB8IDY1NCArKysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDgx
MSBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3BzZS1wZC9zaTM0NzQuYw0KDQotLSANCjIuNDMuMA0KDQoN
ClBpb3RyIEt1YmlrDQoNCnBpb3RyLmt1YmlrQGFkdHJhbi5jb20NCnd3dy5hZHRyYW4uY29tDQoN
Cg0K

