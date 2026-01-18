Return-Path: <netdev+bounces-250754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1305CD391CD
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B27C301515A
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB04E50095A;
	Sun, 18 Jan 2026 00:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="tSxpNI8v"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022104.outbound.protection.outlook.com [52.101.66.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0EC50094A;
	Sun, 18 Jan 2026 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768694578; cv=fail; b=p3x5Nnn/bstS0NEFy63A2TIpA+daJvWYqKmQRjHx85574pLhHfoGfpIoEhTlHsHOdrAxoIt864bXO+KfNSimF8VVr5UcJDFgPbh5TrRiEqLSx+ea0i/+IFw/ZCvPaMsGupWTozB/JnqEl6CPv+P6rMc6ULKL9TeWw8HaWxRsG2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768694578; c=relaxed/simple;
	bh=bq9nbTKgcShfoN++JGIlLoUPXseTvGLC1jSm8puM1Xg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PMIH41rPZA8Q/9lL9Knm2gFwxMZ8Tv6QyYeR8KTCbUADKioNarzzKTLBurHj1mGYREsbI0bmd9LW5WqcOcz8KUruFx9M1StzhdC9rxBniDhWrnN7Y96dPXDgMXZK/bDKjRxPNeyphe4D1LncOxk5vB7Pljf7VKjricAmDaRimcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=tSxpNI8v; arc=fail smtp.client-ip=52.101.66.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgLNvuLtwKBX5rRWMFar7TBx4XVGXvcm24g5dZoM7x2jBUUpXIX3HvHRAFRj9hBW3U1rAeYLPwQIHLiSZ8kgMV8WOC3Q/1a9BK/MnAEMJKWul/A5RMJ9LU9Gaj9KvBvmiwBfJW43mv1EIPHDp4RMHhc6uA6VzlBwU70NhpFDGxYJhEJoIFKbogSyBHyh19aMm9OlUydHE0XbNR/GXSAUYQwk/KVzJz+VvZNoV2DqBYnzx8CoRZUclDImEbMHlkCSJjX+W5ckn6EwFAgfQnhbiHVxBo1M5+/iOwrqpcqkxA26A8eoJYvWQILJzbE4BenKlEfff15F/WzAiwnoJvjziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BouxKwaxSb4T3MyV/f1RElwlpv2k85ijiKhtoVylmQE=;
 b=rLkiFoe57gxfAMKfaPcu7SAH5b1pyUqcouBxGGLWrAPKoTg7tzILCwPL7yWuMpw7mPvA2jmEkFu3h8LcVFYUiYmvg8xOUe5/lajXC2YvNPYkNQHoFyLjq7q4YdLIE2bw9rxFcmAsTfPhgqRp1ANuF7D6htfclBWiEWlhgXljzk5cv3BHmEgdCesLAcQfhQCaF7Cre+/+iqMl3Ha6uNlB7kQD0VTJSz6Wa7UlETpQ0nuvrqNsCdibZ4aP5AKdkEXsCHaWNMUK/98EE5rqPoXrFIgyirRK0ebrlUQpjZXzfFXDqVAIkBRBubH3nPcZPadftNlGU0SoFDdQk8tcGYYOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BouxKwaxSb4T3MyV/f1RElwlpv2k85ijiKhtoVylmQE=;
 b=tSxpNI8vB+vkmkZx59XqQchSk0kNkMLJZkucAzm+aijCEpQEcidhbH++/Ojs+HJimb+MIseLj3jnKfnRoEoaKY0jHRjpPK+vD16CB8yh9crvKISMrLs3SQ4vp8yzsP7sYmJHiHUdTaSBaTY79LBGbffXG6b0uuRJyqLZC8sgPYSbbZdPWm1njQcpn+aKpi1G7R+Tr/u2xIP3TchdLHBwLfe4PpDPH1pgxJDslrg7hdxnX0PDb0nyIZZkoYm7RasWbf1aw6u+wp6DfSaFDFsBUEEivaJdfrKptMQ3kSkCpxrxPhMmiRQ0dJXk/L/0E+CzPnAE4FejoIKGTH0IVK0rWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from VI0PR08MB11136.eurprd08.prod.outlook.com
 (2603:10a6:800:253::11) by AS2PR08MB9390.eurprd08.prod.outlook.com
 (2603:10a6:20b:596::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 00:02:54 +0000
Received: from VI0PR08MB11136.eurprd08.prod.outlook.com
 ([fe80::e3bf:c615:2af2:3093]) by VI0PR08MB11136.eurprd08.prod.outlook.com
 ([fe80::e3bf:c615:2af2:3093%5]) with mapi id 15.20.9520.005; Sun, 18 Jan 2026
 00:02:53 +0000
Message-ID: <dfc4585f-f342-4900-8d20-6b149954f0ab@genexis.eu>
Date: Sun, 18 Jan 2026 01:02:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
To: Andrew Lunn <andrew@lunn.ch>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <69677256.5d0a0220.2dc5a5.fad0@mx.google.com>
 <76bbffa8-e830-4d02-a676-b494616568a2@lunn.ch>
 <6967c46a.5d0a0220.1ba90b.393c@mx.google.com>
 <9340a82a-bae8-4ef6-9484-3d2842cf34aa@lunn.ch> <aWfdY53PQPcqTpYv@lore-desk>
 <e8b48d9e-f5ba-400b-8e4a-66ea7608c9ae@lunn.ch> <aWgaHqXylN2eyS5R@lore-desk>
 <13947d52-b50d-425e-b06d-772242c75153@lunn.ch> <aWoAnwF4JhMshN1H@lore-desk>
 <aWvMhXIy5Qpniv39@lore-desk> <30f44777-776f-49b1-b2f5-e1918e8052fd@lunn.ch>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <30f44777-776f-49b1-b2f5-e1918e8052fd@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0001A334.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::699) To VI0PR08MB11136.eurprd08.prod.outlook.com
 (2603:10a6:800:253::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB11136:EE_|AS2PR08MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c15086f-d7b5-4825-b43a-08de5624ed31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3dlY3M4bzhEUjlycEZseFo1RU1FYUpKKzlqcExmYWR0eUZKcEVWRWtmM2lE?=
 =?utf-8?B?RWVDY2pBeC92RlJYTmJsTFJUeHVlUURHem4yVDd1M0QzNFo2NitCR2E5cnBK?=
 =?utf-8?B?Qm9acmgySklxRjE0S2lvMXdDM3lGQ1FIVFpaOGp5R3R4dWtnWDNIdmlYbE0v?=
 =?utf-8?B?R0xwQjEvZ1pDK2ZxK24ycW8yZGdBeW9wYlhpRldDRHFXbHNndURaMDBaUk9V?=
 =?utf-8?B?SzBrR2lwL3lPOXUvaXNGTFBIeSs4V0ZxN0JiV1ZRVDZyNHpiQ3N5R200Q0Rn?=
 =?utf-8?B?N2xXMkNXM09IbnVsb3dodnE0bVIxczdPeDYwclFHVUc3NlFlalRTSGdVVmxJ?=
 =?utf-8?B?NVRWbXdGekxlUDZNdXgrZm10c1VIdklqZTBoMXhEUm8ydWpobG1mdDRFSlpJ?=
 =?utf-8?B?WGpTZGZUZVdvT1htNHB2eWFyWElmTmYzRXA3cnZPQmxxdXlmVUIzTEpuR2hm?=
 =?utf-8?B?M1N2d09HUzBCUmtwVWZ5UDVWT0hvZlRNYWFPNlNWcFhKNGlsckZuQXY2SS9k?=
 =?utf-8?B?TExoTHdLSGdtL2MwRDdUSXlYSDg4ak9lTlk2UTNNZER2UWVwSFdacmw0bDlY?=
 =?utf-8?B?WEZzQTMraUFYUGR5cW5ZT1JNMTFVMW1qZnlsZUd0Sm9yMzFpa0R0Q2JLQzlt?=
 =?utf-8?B?Z3c1bHFldnhUR2t5T04zWkYxTU5LUWtlMGpnMllGTUFaWEhha2xMNUxtWnBh?=
 =?utf-8?B?Qnd2eVRSaUZpTzRHTWQ0TDBYS3RZSVE5QkpNYkZVbTFWWUVKbHRqUVZVTVFB?=
 =?utf-8?B?Q2c0L1JPazVzMTIvTEpuQTFZOE9sRkYyVm5CSDNXNWFURDE4RnlIZklmNStu?=
 =?utf-8?B?L1RQcHRjcklwZlYxSEdvT2NYYWNiKzlJY2R0WG5DL1ptWHk0UkJCQWNuOFZ5?=
 =?utf-8?B?VlpUSlZKTnNyMS8yRi9xSEtTTmhyQXo5dDlpZ2JBT1VpRmlUcEtjUXdldnZ6?=
 =?utf-8?B?b1UyNGZJVHl3ejVPVlB2NWN3R1ZzdjkyZzExYktUdm50b3QwbHBNNm1ZQjJ3?=
 =?utf-8?B?M2ZheEtpQ1ZqdzRhRVhEVjdQUzlUc0hiSG1hZlltaTZzUER2K3BoRHRGYkZI?=
 =?utf-8?B?a05OY2pTTkxaRDF2WVNPSWpYWlU3SFhLZ3laMGJ6ODN5NjljYzc0Z0Q0TVBT?=
 =?utf-8?B?cVJoKzE0QWtSQTJ1WDlpdk4wbHAvQ2MxaWV3ejE0UExpa1JsVWtaYnlsSm5j?=
 =?utf-8?B?ZVJUeWdEdXRRQ0drNlZwTDZNUjQzUGtkOENEUm1XTGZtRVRlYnc3REZhdTVh?=
 =?utf-8?B?cWtzY0FaVUFZd1VUWm1zem9VWURxNFhPZnAwZE12c2gvTTVWKzNpU1hIcWZJ?=
 =?utf-8?B?dzcrQ0huTXlnZHMyVmVlUEEyVEF6WlNOU1N4QUxPVFF0REdFU1FlclR5TjIx?=
 =?utf-8?B?VFVZa3RDRFUweUc2VGp0b0pibmsydnRpSE1RVm9FR1dIRGJtUEFQSXhKbWFX?=
 =?utf-8?B?eDNzZmp0bTVOQWhDeGgvdzJ4SlJPUkltZnloZzdsNWlsaDJHbGxTTUo3elZp?=
 =?utf-8?B?dUM5WU9pZm1kVW5UTzVCNjU2ZnVSUlFkT2sxMmRpMUZPVkJDcTY1cXlYQzNh?=
 =?utf-8?B?Nm5oOWNWdHJtdEtheUlRQnR0b3dhUmVrbWdxUUpzVHdoaC9ER0NYbEEwUDd2?=
 =?utf-8?B?czZvbXlRcklzTWFyZjZtM2o1WXVEZlR6U2hKTVZqdHRLNkh1UEZNNkJNMllQ?=
 =?utf-8?B?Vi9qZkF4bHVRSlp4MFpSOURZYW1xL1c3QmhDM2FIUFd5d1ZCbFR6bXJ1Rity?=
 =?utf-8?B?VHhyVFRGV2RVM2JxN09JZ0dFdDdabkp5RVFrMUcrVFBKUlNQYjRQWUplMUZ6?=
 =?utf-8?B?dWdMc0F1K2NHenp4M0g4YnhzWVpmS3NSaURFMkpYdFdHazJZTEVLTXRCT2Ry?=
 =?utf-8?B?Vml3MXdjUkV1M2V2czVITytjVGU5YW53dTFPM0htN0RNV2htTzBTNnUvbUFN?=
 =?utf-8?B?bXE4RC9YbjUwZkRJenNlK3lDUThma1J6VHRod1EvSmlVQWRBQXhCNjBMcG5q?=
 =?utf-8?B?dEdXNWNTTERRNDM4c2dKbXVobFQycUtGYWdaOVh4b0wyeEhHYzlFeCs3VjBK?=
 =?utf-8?B?Slc0YmwxZ2wxWERLRkpTOGFNbzUzZTlUWjVKelZteTB3YjNUWTZqdFgxbkVy?=
 =?utf-8?Q?siDQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11136.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGVtdW0vaEpXZHdmbEoxckE2NmZhMDZlTDlveHZkVU5yOHJkdVlLYzlWSFRM?=
 =?utf-8?B?ZWtBaHdIRStPWXZTOVlEOUwrbXA0aVAyRlZkNGVUd0hQRG95ZWQwWGZtRHE0?=
 =?utf-8?B?RVh5STI2RUU4V0tGTFNaaiszbndxdU9iQVl2N0E3U0o5NHFTL0t5N1JUa2da?=
 =?utf-8?B?TitoK3dNVjA5bWtuQlplUjQ1eWZjbEJHY09EdWphVUtTaVNQOC80VGVMUVRp?=
 =?utf-8?B?WFBZc0pqaExmL2dvTHRQdlVxd1RiS08yU2hvYVNEY2NRTENBTGVlNy9qSjRP?=
 =?utf-8?B?eFRnMlp4UkJqYUdobjEwQmMxNEVSVzhjazl2RGhTcTQ3bHk0OTBUc3N6bzVD?=
 =?utf-8?B?aTFFem0wVlQ5aXI5UU1VRjRUVlN4UDZQV0dRajhwazFnMGVDdkZXSXZ6TmpH?=
 =?utf-8?B?RExTYnhNeVpxRkdtK0o1WTJ2TlR0eklsNzNibmRwNHBMeHY0SUhIOWFNV1Rt?=
 =?utf-8?B?WHNnRlpwTWFmcURkRFVleUJjSEZvRkZ2c2pDTXcyVXVwTFdnOXJ1REdwU0U4?=
 =?utf-8?B?Z0dublY4TFlCS0w4cHZhdzJ6T08xOWJ4eGs3OWlKd1YzSEgyeEtNa2tJRU5D?=
 =?utf-8?B?aHJkaHhjbVZDazNmcERLN2ROYVZ1TlkwNXZuTWFWYkNpckVTd2h2SFJNWW9B?=
 =?utf-8?B?dUVBOFU3YzcrLzJ1ZVdjNHBxYkFVZndDQmlPNmhkK2ZmZTZSYTBUbHpQUHBD?=
 =?utf-8?B?d0xUL0hnQkhSRkpuR016c29xWmdVSUpBVXFCWEllWVZPcTFmM1VKSHFjN1ZL?=
 =?utf-8?B?Tkw3UDlmcEVBVnd1a3F1MnhyK1h2cjZnRkZjUWJac2gzWllMVFhSanFHV3JR?=
 =?utf-8?B?R25Bd0RLaVNFc0pXNlR0U0NiUG4wQkV5UVRFNE51KzdBM1gxcU9nMU5OYzBa?=
 =?utf-8?B?a3FiYTRmT3FwNzJsa3I2WEg0SHBKNURxLzU4VkEweEdKZWZDZkJhV2tyWTlq?=
 =?utf-8?B?UkNpbzFoOHJCUDRQRmVhRHBJT1AwSndyeFZMZy93dUVMUkZSWm5Xei9jM2U5?=
 =?utf-8?B?V1JySHVwWWZJbnU3dGEzcy9BZmFOMjAzbmVJeXl2NDU1OXBZdTFUZXluTkVO?=
 =?utf-8?B?VkVCdkx5OS84WVBRSjhpV0xqazNVbFRMZFB0Mi9kSUZvdVRDd29NWkt1c25i?=
 =?utf-8?B?eVlPL24vY1VlZS9Pck03VXVrUnlNVWJ5bGloRjVQeno0QW5RbkRBNWhxMzRX?=
 =?utf-8?B?eGdXNlJDY2oyaXVGWU9BZW56N0hiUlBIaVhja2xrRkdtUmlvd3hIak8zaXI0?=
 =?utf-8?B?ZElkYjdHYzc2ZEdmSCtDYnVtRnBxeUYzNkZMN0NScGZzSWcvT1Vhb0JrVHkw?=
 =?utf-8?B?Tzd0cStvOVZTNDhnc25vbXZkaGxmZWtSWFJlSE53YjArNjdwTjQ1MURxK2F1?=
 =?utf-8?B?eUdLd3l4ZlRVUkxjNWdaWVRrUDNxQkhQV3huWHhSZU9BZ2tDK0JDZ3FhUndW?=
 =?utf-8?B?d1liR0hhNGxWWTIyR01TUjNXNURkUTVNcDlMTnlSRk5PRmhOUW8yN3hvVC9z?=
 =?utf-8?B?eEoyUk1POWR0c3JDL3ZveUoxMVYrM1o2OXBZclRELzFHdGpTYmFyOUU0YWZw?=
 =?utf-8?B?K2xwVmJVcXRSaUxDSVBhNHJveEttSUtFeGVzaEJsVEZUTFpSRlNZUnJJMkpw?=
 =?utf-8?B?WnRmanpyWm4vdk96OFBhN1JHNHp2ZnNjRzV2RVM5WThTSHo4ZExqNll6RlJT?=
 =?utf-8?B?UWt3Q3lIMDd0TXovYlh1VVJDbUNUYityWTVXbnFjdml6NUpYTWsxeHh4bUpj?=
 =?utf-8?B?QzFrNUVualhKelBiK25yZ0RUMEMxa0JTU1ArbDhLY3IyaGlmcUM3MEVYSnBB?=
 =?utf-8?B?Nnp3ZzJQNzRkRWRDS0g0K3NpSVBhZmN5NkMxVmVqUnZrU3BsREdDQTZOQnBh?=
 =?utf-8?B?R3lxL0R1UXh2NExjUStaNFNoL1lzYXlaWWg5ZkZZMUY0Y1k0NEc3a1FsSXJl?=
 =?utf-8?B?TUQyQXJrNEpyTjJyNk5CV1JMMVRoc05uMGVxNVdaTWU0YjdXNXlhbUxZQUNV?=
 =?utf-8?B?MGdVWFAwdlpCaEI3QytRZmNmS3ZvNUZLejRVVG8ydUxINHZWWkI3eFYzTFU4?=
 =?utf-8?B?YzVWQmtTeC9JbzFrTGdhWWhzNGJQcTFUMEFkdmFvcmMyZnZKVWJQS0lNWDlx?=
 =?utf-8?B?U2d1b0lWcXlnNTIrMzBtbDRPUmNYMUZlSjE3ajhoVGovT2JJcmg3dkZGYlBR?=
 =?utf-8?B?V0ViVFpqaFlKOVJwQ1RoUWJPdmdTVkpmZkgyeVV0cnhzaTZzRi9TTm9mQjFy?=
 =?utf-8?B?aldFanpDVWNrZVdMUUt6Nnlmc09iaEl0Yjk2dDRHZEtCS2EvV2xneWxkVGpB?=
 =?utf-8?B?cHNGTVlubjhVTWs1c2VDcUtCT1RlY1VVQ3d1OUQ5OGFlU2xvR204bnUzMWNo?=
 =?utf-8?Q?Bvztfxa17djh5Jv4=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c15086f-d7b5-4825-b43a-08de5624ed31
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB11136.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 00:02:53.3567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAY7r9Kt7+4EQopXjcP6qKV0Fi8ZgiIxM2JQn33VCGAmjTlB9dFR6OrPFSjISFGP5XU24jXYG+YDT6VFZfME3++HuewM1Ws3ONYj3SpO7Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9390

Hi.
On 17/01/2026 23:18, Andrew Lunn wrote:
>> Airoha folks reported the NPU hw can't provide the PCIe Vendor/Device ID info
>> of the connected WiFi chip.
>> I guess we have the following options here:
>> - Rely on the firmware-name property as proposed in v1
>> - Access the PCIe bus from the NPU driver during probe in order to enumerate
>>    the PCIe devices and verify WiFi chip PCIe Vendor/Device ID
>> - During mt76 probe trigger the NPU fw reload if required. This approach would
>>    require adding a new callback in airoha_npu ops struct (please note I have
>>    not tested this approach and I not sure this is really doable).
> What i'm wondering about is if the PCIe slots are hard coded in the
> firmware.  If somebody builds a board using different slots, they
> would then have different firmware?

You have to follow the reference design to get Airoha support. My guess 
is that everyone is following the reference designs thus there will only 
ever be one pcie configuration for each SoC to (Mediatek) Wifi-card pairing.

>   Or if they used the same slots,
> but swapped around the Ethernet and the WiFi, would it need different
> firmware?

NPU acceleration should be able to freely route packets to any port 
connected to the PSE. On the following link you can see an illustration 
of my current understanding of the AN7581 SoC: 
https://github.com/merbanan/air_tools

>
> So is the firmware name a property of the board?
>
> If the PCIe slots are actually hard coded in the NPU silicon, cannot
> be changed, then we might have a different solution, the firmware name
> might be placed into a .dtsi file, or even hard coded in the driver?
>
>> What do you think? Which one do you prefer?
> I prefer to try to extract more information for the Airoha folks. What
> actually defines the firmware? Does the slots used matter? Does it
> matter what device goes in what slots? Is it all hard coded in
> silicon? Is there only one true hardware design and if you do anything
> else your board design is FUBAR, never to be supported?
>
>       Andrew
>
The NPU is a Risc-V cpu cluster. As such it should theoretically be 
possible to support any kind of configuration but if there only ever is 
one reference design my guess is that is the only officially supported one.

MvH

Benjamin Larsson


