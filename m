Return-Path: <netdev+bounces-144648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3464C9C8070
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8318CB22F48
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C501E3DF2;
	Thu, 14 Nov 2024 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="APmcjjnI"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2102.outbound.protection.outlook.com [40.107.215.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E12F5A;
	Thu, 14 Nov 2024 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550793; cv=fail; b=gWFEjpMbgZOC4cor9tL59IJv07FkzykcVIOfJZyyttCYmTagEzj3sCXl53p5BZcfJQexR3b1He91siDDH0+mOP67frjQqkC7OGFCoOhkcOLhw48+OvTwgfmkjGEQLG+G9e7kA6Zj5qU0QZgXAW1w2uFlrVYSXbAmCMmEmDFOg7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550793; c=relaxed/simple;
	bh=T+fHsJnXLAOyajqMg727RLrKSexSqJ9453ACFaPVZHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hBV2/wjwFDkK+muLuhfnbvs6einyVVShLJ3ZxnwRMOM4Z2u1O3dgqPjH+5rsfgI46KVzOj2et1EoKfBLx7pdCTP8Wh810MTjsWXVu5oa9wSn/Yh/BUKtganvaQon8pppY+jTsUu+qJza/WBUTuxSwXATaTQGgPyrxquWcCvk4KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=APmcjjnI; arc=fail smtp.client-ip=40.107.215.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEix+h1p0fNVLnKMYArl1bJtPor0jq5kxoi8eYx57Uu8Jq6lTpEf7fZIAqk8fUUpDq+khutstQyP5eB1XufomQMCBhV57OpH0M3HQXQRLxyogChYnZXpYe5JyyOqoERuKfhqtXedzIBzmxLrZQ4c9acOHPSKYhDE4oecmmGmZxDGi7f0F3+wgSG6JglyihZIRrZlw+ZLbWVMZVi0SusYlqajP2m1RXpi6IZMHI3V+i1PFOQp3Tu0gQJFFaLj9NYd7YFP+ng4VjxWIrILSqPH68IcPZGaIc5d8qJSYBknIb2hjAxvkX54Qie/HGqJyucRt/rcz+br2a8z046X9JiRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+fHsJnXLAOyajqMg727RLrKSexSqJ9453ACFaPVZHY=;
 b=rRJGLUMod6QK01swBWmykBSl6/XTWkmOr9QAQ0moVTYfG6JfzqO30wOPtcx2ExoH5FdZ0Nm8nnLppdWmGOA5TV3yxnixmeQ+84usXVFcNIf+uXYJR+2jixldYvnw93Dd6xkW6e0DcjGHxgUJLMzRcrSGmFikHgIzmiAiAs0J+oN6r6QKhDFhknvadjSGzf0iu3K/Kjs7MoMBZ88iRousE2CvFQekbngV28iDr2qM8CsfsMv7LCrcFIe6TWteXQCRPVFadmNzUy0qqRdjoWB1RoK3rFBQ8n/sjVPYpCDqfSuOZKoX9MFs1G7YhsZ168A2Sx8Pu6WBRJUShapOO7WdlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+fHsJnXLAOyajqMg727RLrKSexSqJ9453ACFaPVZHY=;
 b=APmcjjnIZEqCH7yCK4+GcjmiZ6shj9R5SvOGA0s+OXb80VHTUER59U/unWcgs+ySMpFDYqu5ENHYnHYa633vlsFSsBg5AP1kq03+CcfHoDYREgMrImBiAOcsTa8p8tubotKXml42lmuu6lpEwH2i9Ld8odYNyaRWQX7QR9KLARPDtbbG/v+z/voVl+p8BihFqkdcB009L6wa04dWBKMo/GFCMoUsDDekS6iAJ0XFRdAWvFSo1p4erZ9b3tTdhAk1bbkJZtHbzcnKrNRfjv7ONCzKkrDk/VIWQhGb+UstxLdZdrj+gyXr4n0j/LOGm9yGOBJoN/P2DAr/6K+uY8NkdQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by PUZPR06MB5904.apcprd06.prod.outlook.com (2603:1096:301:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 14 Nov
 2024 02:19:45 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8137.011; Thu, 14 Nov 2024
 02:19:44 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "ratbert@faraday-tech.com"
	<ratbert@faraday-tech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW25ldC1uZXh0IDMvM10gbmV0OiBmdGdtYWMxMDA6IFN1cHBvcnQgZm9y?=
 =?big5?Q?_AST2700?=
Thread-Topic: [net-next 3/3] net: ftgmac100: Support for AST2700
Thread-Index: AQHbMQZSanPeA3sdNU6SnHF6uEd5/rKsdfaAgAmV9iA=
Date: Thu, 14 Nov 2024 02:19:44 +0000
Message-ID:
 <SEYPR06MB5134FCCB102F13EA968F81869D5B2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241107111500.4066517-1-jacky_chou@aspeedtech.com>
 <20241107111500.4066517-4-jacky_chou@aspeedtech.com>
 <1f8b0258-0d09-4a65-8e1c-46d9569765bf@lunn.ch>
In-Reply-To: <1f8b0258-0d09-4a65-8e1c-46d9569765bf@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|PUZPR06MB5904:EE_
x-ms-office365-filtering-correlation-id: 07066a77-7139-48d2-af30-08dd0452ce16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?SjM4RURSaEJpQTcvbFFNdmNVeHI1bU1zeUJGN29ZQ0o0NEdzdlZ3bHl5QlQ5OHlM?=
 =?big5?B?cmJjR1o2TDVuWGd5d2tMam92VitMU3l3MDJ5Z1IvRzZDZmRwcjN4bGVGNVBSQ1NY?=
 =?big5?B?aTZvN3M2VTk1UFY4MVgxOVRvV2V4QUpQM2JUR1RNUHJCYjZ3WnR1aEtoMVFhaDk2?=
 =?big5?B?QTQ1bTNHYjlnN0Uwc3B1R3VXZC8xL0htTnFzUnBZZ1BLN1NXTUpSeGk5NXhTenRQ?=
 =?big5?B?RHdrK0EyUlE3YWlneWI0YzZZQVhLUG5ZYzNiVlRURUx4SzliejdTM3ZQekFzUU5P?=
 =?big5?B?WXBBcVFiYVNXQ05JZ1J4RUpteHRWQnVnMlBmVHc4eTJnOGFidHZlWFhnbmVRTWVN?=
 =?big5?B?cCtoak9ZZWU2ODhQVFE1cnNXcDdSdlBtZU5rdHh1V3paUGdqYnlsSjhuanZVYmJP?=
 =?big5?B?K0xrbHR5alNtdXJUWGVnOWo1RllqZ1ZFNHgwZmhMRHFkNzRpdlp0N0s2QW1BZjhu?=
 =?big5?B?TlBrUzlKb2NhWldnWXpGRWxXV20yTlBJS0thNy9NOXRlQlpZNDV0dXFNc29DWlR0?=
 =?big5?B?UGFEa0lMSkY1OFl5Nmd1aGhmVklJTmtiV0x0eEFiT3lzM2dqdFZBcXkyMkEyRzc5?=
 =?big5?B?a01ncjdtMWNON2lBR0EramhBNjAyYVVqRUtTMytiYWxZb1AyOVJYUzBXNzJsSzBs?=
 =?big5?B?SW9MSmtSOHE1K2pPb3pSQXRhbVh2ZlQ3WlJqTkNFQmErRVM4TSszZkZuZFh0OG1G?=
 =?big5?B?T2RjL1cyYnc2SHNRQW8wV0NhYSsyZHZXMmhXMHVYU0JWTHdyeDJhMVBGQjUwNjhy?=
 =?big5?B?czFma1VINytqb1drRUVQblgrZFVKVGd3bU45YTlGRlRSR2p6NFloQVpIYlRXQk92?=
 =?big5?B?bTF2SjZVbDFaR3lYZFRTM2VtRktJUVpDQ1NONElwYWZNK2JQQmxaeEozSU90TFJP?=
 =?big5?B?TzdCekhzeXVUNWRxWHplSFZxS216QWtuSmdvbFJVRW1lV0tXck1kYlgybGlTSnBv?=
 =?big5?B?bHQ3UStKbmVaWUp0ejQyUU91VlUzYUorNXpWVEtCRW1vdXR6Q0QvZUY2WmlBaHpX?=
 =?big5?B?SWtIdmJNdlcwVkhuRVZTV05KQ3U1aGJMdDl6dGgvWmEzVk1pWDNRZDBuNHJ3WHJs?=
 =?big5?B?NU1EYUhiTGNUSXJPK3VITndnYjNjd0pMVVlySTFRWmhWWXV5ZHBTelErbzhIQ2Rv?=
 =?big5?B?Y1o2MURBdlBObFZYSUs1RXFzM2NuYTFKRXhCeVdYTjBkLzU4QXBLSkNXdWswTXhv?=
 =?big5?B?NXk2MDlBSzZZZm5vNVJPWkFjTGlzVFFjdTRPRHh5aTB1MktrZk4xY0gvb1J3TnZY?=
 =?big5?B?UWJiVGwrMGZFbmlsSGlmWTBQVURoTURwNlJ4eWthNGxEcjA4RWNiWXQ0UFNoMWEw?=
 =?big5?B?S3hIUGFoUWVkaXBHUEhQN1B5RUlUVWM1YjFWWWtPanpRc3pJQm5aNHh3WUhTVEJY?=
 =?big5?B?dlJMcG8yb1Jwb3ZaS1lXNFk3eVZIRE5SNzk2Ni9aOW5tVkRBNzd0T015c2tKSU40?=
 =?big5?B?QXZqK2lyZjdpeHdON3VvRm56UXB2VlJTUklld202cFQzdHN3OXQxdG5pZm9uajZk?=
 =?big5?B?cXJVWDJOUVMvUEwxNTNVLytiTUp4S29TU2FSNEZ0VHhIYUNXQjJaYkYwb0JIOHZ1?=
 =?big5?B?dytpVHlJMzFISTgwQXkzUjhjK0kyNlJadHlsVU9adGxuK3UrYlA2NG9icWhkSEhj?=
 =?big5?B?eHNudERGUHUvd3I4dTBOSXFWMDBQNjhLc2NITk1lcEUxQWZ0UU5CcVlZRDhXNWsy?=
 =?big5?Q?lW04bGxxpNYJ3dpnYvmt3aOFTi2WrutI+uQq3xZ4MFY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?ZWFiT3dBZzAwS1NZbWtOSjVQTTV3Q243elAvYzc1RDNuSXhSa0VVS2lwZmYwazgv?=
 =?big5?B?Z0pMYkUyeGsyUmR1V2hPTzlZNGk4bkNxc29rV3ZsZ3hlc05sTC9SR3YzRUw5ZWwz?=
 =?big5?B?MU9XVFpySUwzSER2QUpLTStVQ3FOcDBGb2o5MjVkc281dE5PMk9nY3dNZzZIUEJn?=
 =?big5?B?RmpBQzdmVjRuMjJKRzl6Y3kranRTZzZzWkFDYUN3a3hzOEc4UmwwaUlRSm8wVE56?=
 =?big5?B?L29TcHVpb3I5bWNyaXZMdjJ0ZGN4d3JSd0ttVkNpOTVOZXV4TzRYQUNtSnVHNVlO?=
 =?big5?B?dkxjbmswWUZGRlhsNXhTbHJEemd1a0M1b3BhVzlvM25wUUNTU1draHpvREZJTjBU?=
 =?big5?B?aDVuZHdTMHYvUmoyTFdaNW12YlhKSld1akRIQU81azc5Q3ZPemExY0RuSkNselhR?=
 =?big5?B?WlI3VlRmWUs1SnNPNEJJTXU2Y2c1WHpnWjRMNm5GOUlTK1J0VkZnamkzWHFCMEZx?=
 =?big5?B?eEpab3JaWUZwVFpWa0FXOWNPNEtqdUJuZ09Ya1BPQ3Rud1pEOHpKaFRldDRZVy9l?=
 =?big5?B?Z2ErV3hDNXhCckVQT2wxM21zTk9Ba0pHK2psbWN0Z0xYSFlhL2kybC9qV2xsM204?=
 =?big5?B?ME5oaWdEY1BTVTNGYjhMWlZiRXpaU2RiZGwzNTY3MCthODlMVndSL2FYWmpEUGRo?=
 =?big5?B?MkZOaGEzVDRxZmlqL3JoUFIxU1FVM1BGb0JnYkJoZWEyd3Zzc2Nzckw0bGU0YUdV?=
 =?big5?B?Vm9RVzFMU0xDVWxVa2dPdS90SEluanRQYU9QTGlWc2wzdkU4UVhKcXlLTTdVeEli?=
 =?big5?B?VEFuVHB6SHJ5elIwaG05VmZzRVZPcjEydTdRUW9jNGdKcjllMWNEYlUydlFaYWlu?=
 =?big5?B?OUJaa2ZGSkd3c0pKbVZ0eloySTg5Y3VTbGNtdm16eWhWakZYVGpaVElUS1ovM0cy?=
 =?big5?B?c2ZBK3BsaFlLQnpzVWQrSXcwR2VsK0ZBYmpsZ0puQUY3TGxHeVVtT1ZLZncwcC9L?=
 =?big5?B?Z2F5V2FFUi9tZXZyM0FHTHBhSmg2cFRjNTFmamhOU3VyUjdIeHBRSXA5aFJlQ3pF?=
 =?big5?B?ZW42ZnF1TkhaazBpNFhFTkJpWGJJS0lTdkY0Z1BXNFpzdTdSamJJVGlkbm1EOGRO?=
 =?big5?B?NjVuUEJ3TnZ0Z29wR2xmeFpzMzJPQmR6bFhFRW8xcU5iUGRoalhpYkVoZm0wamk2?=
 =?big5?B?Z0xqTnJ3NUtzUHlNVFpLUTNzYXBLbHJZVFh1VE0wWERJTTBPdjEyZDZnKzZOMjlE?=
 =?big5?B?T1dDK2IrL2g3QUczUjF5MjhtOGNpaHVUSFhpcVYrWlJvUjVTdWJkK1Mvd2hNQnV4?=
 =?big5?B?bDA2bmJ4dnRyZjRZYXNkMWs2bjhWTkpkZGtkS051Rk1Ga0U2Mll6V1lQVWJnMDEw?=
 =?big5?B?dHZZK0dPV0tIOXpPQnNrVW1QMHg4SE1iWVhMdUorb3ovMkVZNnRtT2g0a2hSUys0?=
 =?big5?B?KzJmMTNpRW1FbUZlSVpuN2M3amNCeVowQ0NCYndWOGdtbDQ1NFZ2NXovSWt4bno2?=
 =?big5?B?TFVpK3lFTjUvOHhobDBkbm9VL3RmY204NVlqME5sRlZ6cmVEaXJpZmZOQ0FLTElF?=
 =?big5?B?TEh3dnhGU2k1Uyt6S0RmUVFxaVEvKzFjK0ljS1hYdk9xeDZCcTE2bVEvTmwwamo2?=
 =?big5?B?aW1qdFQrMHdLaVp5UEpKSStiNTJ6bUlHQUIvbWpFNkJRSzk5L015NHhXRktIR1I4?=
 =?big5?B?eGJkYW05NDlnNVBRZElRd1dDNUo1T0QrOVByb3k4SElYK0N0U1ZWRXhkTlNnbGdL?=
 =?big5?B?M3Z5RmZQTTh4dU5KSHNQSSt0dGhFUVNvUkdFWEkvN1lpd3gvd0RFSzIydUN4RFBz?=
 =?big5?B?RnNqRUlGVUNISlNudkpZWCtxem90NWlVOTNpMlU0eU5LUFBPQWFpS3RWK2ZRWm5p?=
 =?big5?B?djF0a0pQSHBGTlFLRmNIVy8xOG8vVjVOR3BpUEU4R3N0c1Q3TUdFc1R6QmozUzEy?=
 =?big5?B?TlFJSGZCOGRxUk5QdE52a3dVenhkNERpblZMK05GTTVRR3d0WjdYVHYwbzRFaHI2?=
 =?big5?B?c0J3UitpQXdHakJUUWZCRURpQ0J1bC9Fb0VMNVVZYnorcFd1SVJ4WEYrSS9LZmk3?=
 =?big5?Q?l+o3yrGkroUX7n/Q?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07066a77-7139-48d2-af30-08dd0452ce16
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 02:19:44.7658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6VAad8mkY7r/Og0WDkaJEhV5mksOt7pQkaYpJt9GDr+DO1Gv+UK+qCuaN/8cHFBfkxrZre07+TICTRvU/DQlyByv3JwEY1yvkgwVrIPv2z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5904

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiAgCS8qIFNldHVw
IFJYIHJpbmcgYnVmZmVyIGJhc2UgKi8NCj4gPiAtCWlvd3JpdGUzMihwcml2LT5yeGRlc19kbWEs
IHByaXYtPmJhc2UgKw0KPiBGVEdNQUMxMDBfT0ZGU0VUX1JYUl9CQURSKTsNCj4gPiArCWlvd3Jp
dGUzMihsb3dlcl8zMl9iaXRzKHByaXYtPnJ4ZGVzX2RtYSksIHByaXYtPmJhc2UgKw0KPiBGVEdN
QUMxMDBfT0ZGU0VUX1JYUl9CQURSKTsNCj4gPiArCWlvd3JpdGUzMih1cHBlcl8zMl9iaXRzKHBy
aXYtPnJ4ZGVzX2RtYSksIHByaXYtPmJhc2UgKw0KPiA+ICtGVEdNQUMxMDBfT0ZGU0VUX1JYUl9C
QUREUl9ISUdIKTsNCj4gDQo+IFRoaXMgYXBwZWFycyB0byB3cml0ZSB0byByZWdpc3RlcnMgd2hp
Y2ggb2xkZXIgZ2VuZXJhdGlvbnMgZG8gbm90IGhhdmUuIElzIHRoaXMNCj4gc2FmZT8gSXMgaXQg
ZGVmaW5lZCBpbiB0aGUgZGF0YXNoZWV0IHdoYXQgaGFwcGVucyB3aGVuIHlvdSB3cml0ZSB0byBy
ZXNlcnZlZA0KPiByZWdpc3RlcnM/DQoNClRoZXNlIHJlZ2lzdGVycyB0aGF0IGFkZCBpbiBBU1Qy
NzAwIGRvIG5vdCBleGlzdCBpbiBvbGRlciBnZW5lcmF0aW9ucy4NCkkgaGF2ZSB2ZXJpZmllZCB0
aGF0IHRoZXNlIGFkZHJlc3NlcyBjYW4gYmUgYWNjZXNzZWQgb24gb2xkZXIgZ2VuZXJhdGlvbnMs
IA0KbGlrZSBBU1QyNjAwLCBldGMuIFRoZXkgYXJlIG5vIGltcGFjdC4NCg0KPiANCj4gPiAgCS8q
IFN0b3JlIERNQSBhZGRyZXNzIGludG8gUlggZGVzYyAqLw0KPiA+IC0JcnhkZXMtPnJ4ZGVzMyA9
IGNwdV90b19sZTMyKG1hcCk7DQo+ID4gKwlyeGRlcy0+cnhkZXMyID0gRklFTERfUFJFUChGVEdN
QUMxMDBfUlhERVMyX1JYQlVGX0JBRFJfSEksDQo+IHVwcGVyXzMyX2JpdHMobWFwKSk7DQo+ID4g
KwlyeGRlcy0+cnhkZXMzID0gbG93ZXJfMzJfYml0cyhtYXApOw0KPiANCj4gTWF5YmUgdXBkYXRl
IHRoZSBjb21tZW50Og0KPiAgICAgICAgIHVuc2lnbmVkIGludCAgICByeGRlczM7IC8qIG5vdCB1
c2VkIGJ5IEhXICovDQoNClRoZSByeGRlczMgZmlsbHMgaW4gdGhlIHBhY2tldCBidWZmZXIgYWRk
cmVzcy4gSFcgd2lsbCB1c2UgaXQgdG8gZG8gRE1BIHRvIHB1dCANCnBhY2tldCBjb250ZW50IGZy
b20gcmVjZWl2aW5nIHNpZGUuDQoNCj4gDQo+IEFsc28sIHNob3VsZCBpdHMgdHlwZSBiZSBjaGFu
Z2VkIHRvIF9fbGUzMiA/DQoNCkFncmVlLiBJIHdpbGwgYWRkIHRoaXMgb24gbmV4dCB2ZXJzaW9u
Lg0KDQo+IA0KPiA+IC0JbWFwID0gbGUzMl90b19jcHUocnhkZXMtPnJ4ZGVzMyk7DQo+ID4gKwlt
YXAgPSBsZTMyX3RvX2NwdShyeGRlcy0+cnhkZXMzKSB8ICgocnhkZXMtPnJ4ZGVzMiAmDQo+ID4g
K0ZUR01BQzEwMF9SWERFUzJfUlhCVUZfQkFEUl9ISSkgPDwgMTYpOw0KPiANCj4gSXMgdGhpcyBz
YWZlPyBZb3UgaGF2ZSB0byBhc3N1bWUgb2xkZXIgZ2VuZXJhdGlvbiBvZiBkZXZpY2VzIHdpbGwg
cmV0dXJuIDQyIGluDQo+IHJ4ZGVzMywgc2luY2UgaXQgaXMgbm90IHVzZWQgYnkgdGhlIGhhcmR3
YXJlLg0KDQpXaHkgZG9lcyBpdCBuZWVkIHRvIHJldHVybiA0MiBpbiByeGRlczM/DQpUaGUgcGFj
a2V0IGJ1ZmZlciBhZGRyZXNzIG9mIHRoZSBSWCBkZXNjcmlwdG9yIGlzIHVzZWQgaW4gYm90aCBz
b2Z0d2FyZSBhbmQgaGFyZHdhcmUuDQoNCj4gDQo+ID4gIAkvKiBNYXJrIHRoZSBlbmQgb2YgdGhl
IHJpbmcgKi8NCj4gPiAgCXJ4ZGVzLT5yeGRlczAgfD0gY3B1X3RvX2xlMzIocHJpdi0+cnhkZXMw
X2Vkb3JyX21hc2spOw0KPiA+IEBAIC0xMjQ5LDcgKzEyNjYsNiBAQCBzdGF0aWMgaW50IGZ0Z21h
YzEwMF9wb2xsKHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwNCj4gaW50IGJ1ZGdldCkNCj4gPiAg
CQltb3JlID0gZnRnbWFjMTAwX3J4X3BhY2tldChwcml2LCAmd29ya19kb25lKTsNCj4gPiAgCX0g
d2hpbGUgKG1vcmUgJiYgd29ya19kb25lIDwgYnVkZ2V0KTsNCj4gPg0KPiA+IC0NCj4gPiAgCS8q
IFRoZSBpbnRlcnJ1cHQgaXMgdGVsbGluZyB1cyB0byBraWNrIHRoZSBNQUMgYmFjayB0byBsaWZl
DQo+ID4gIAkgKiBhZnRlciBhbiBSWCBvdmVyZmxvdw0KPiA+ICAJICovDQo+ID4gQEAgLTEzMzks
NyArMTM1NSw2IEBAIHN0YXRpYyB2b2lkIGZ0Z21hYzEwMF9yZXNldChzdHJ1Y3QgZnRnbWFjMTAw
DQo+ICpwcml2KQ0KPiA+ICAJaWYgKHByaXYtPm1paV9idXMpDQo+ID4gIAkJbXV0ZXhfbG9jaygm
cHJpdi0+bWlpX2J1cy0+bWRpb19sb2NrKTsNCj4gPg0KPiA+IC0NCj4gPiAgCS8qIENoZWNrIGlm
IHRoZSBpbnRlcmZhY2UgaXMgc3RpbGwgdXAgKi8NCj4gPiAgCWlmICghbmV0aWZfcnVubmluZyhu
ZXRkZXYpKQ0KPiA+ICAJCWdvdG8gYmFpbDsNCj4gPiBAQCAtMTQzOCw3ICsxNDUzLDYgQEAgc3Rh
dGljIHZvaWQgZnRnbWFjMTAwX2FkanVzdF9saW5rKHN0cnVjdA0KPiA+IG5ldF9kZXZpY2UgKm5l
dGRldikNCj4gPg0KPiA+ICAJaWYgKG5ldGRldi0+cGh5ZGV2KQ0KPiA+ICAJCW11dGV4X2xvY2so
Jm5ldGRldi0+cGh5ZGV2LT5sb2NrKTsNCj4gPiAtDQo+ID4gIH0NCj4gDQo+IFRoZXJlIGFyZSBx
dWl0ZSBhIGZldyB3aGl0ZXNwYWNlIGNoYW5nZXMgbGlrZSB0aGlzIGluIHRoaXMgcGF0Y2guIFBs
ZWFzZSByZW1vdmUNCj4gdGhlbS4gSWYgdGhleSBhcmUgaW1wb3J0YW50LCBwdXQgdGhlbSBpbnRv
IGEgcGF0Y2ggb2YgdGhlcmUgb3duLg0KDQpBZ3JlZSwgSSB3aWxsIGFkanVzdCB0aGlzIHBhcnQg
b24gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiA+ICsJZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgm
cGRldi0+ZGV2LCBETUFfQklUX01BU0soNjQpKTsNCj4gDQo+IFRoaXMgY2FuIGZhaWwsIHlvdSBz
aG91bGQgY2hlY2sgdGhlIHJldHVybiB2YWx1ZS4NCg0KQWdyZWUuIEkgd2lsbCBhZGQgdG8gY2hl
Y2sgdGhlIHJldHVybiB2YWx1ZSBvbiBuZXh0IHZlcnNpb24uDQoNClRoYW5rcywNCkphY2t5DQoN
Cg0K

