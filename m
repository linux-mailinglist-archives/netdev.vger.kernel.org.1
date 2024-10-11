Return-Path: <netdev+bounces-134702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 043DF99AE6A
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BCCB23178
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58511D12EC;
	Fri, 11 Oct 2024 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IvIGZ8yu"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2073.outbound.protection.outlook.com [40.107.103.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA957F9
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684095; cv=fail; b=L2iGj5PllPjqZv9tUNwhC9dJyaaiAbSL5sGgQKggRPSHBMPwLXm1tcludWKU/sS2S52z0bQRp2Ji2sedsFVFIA5Laj27dPUuNpmRb+5c0i6teRhKhJrTFWFpptUG7IqA6pI50+AOvbs3VXRoBjWtXuw6pcKBWdA3gtOJ8AEjAqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684095; c=relaxed/simple;
	bh=ncscqCaOHqqkaB0fuB9smQFCw0qWRIyzQ1/nDtAM3mE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P51csARjK5GRewtkVOR4h2dhWM84timNImoKE0R5iYow3pvjFPZUuml2/xWVKIvMdLgE5Ah8HgyRvpXPgp7x1o2HaQHpV75PtitYoP0dYsR3SvLxjgptEQ/TjYAAH+r4hjucq9naMX3NE5BEb8TLtUs47qWPFuZQ7RZfOgR8Q5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IvIGZ8yu; arc=fail smtp.client-ip=40.107.103.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/XJ01nP3wUbTQ2VgC7Ajzh1URlLesFOd+Wm6C9PC+/IXjoADOQEuERlY5lhwoMPpkoz0EObbyB6SdalVsfIzZi/0yPh6A02bUxBW2qFJzOZVl98kG2h/tNuxgInAS6czVDjaKgz5KPUA6wXJD/yurHCXASYmj6Jd8GzRZjmF7lIAhKctTCBxTodvPLbGvfxst8Zec/LnlW91wEuE4ECmuPSsyOa0ZYeYsO3LAxVM6Zae1QKj63Ih/5L7B7nwCdNx3VgJ1B1fzoLeQnTitU0kzYR0RgLReEdZwAlQGO0zzb0cMUDlDQaz18GC+I+4Bauf/IvCMKDGj0vRR96aIk9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncscqCaOHqqkaB0fuB9smQFCw0qWRIyzQ1/nDtAM3mE=;
 b=pz82Rw3aZhyf/2XuKBHexOQ4vdeIpTDiCMLrQJlfx/j8/A0iF5iST5NfvNe3fzuEQ1x0JSgsWAn8bd1ffWsvehkvAek2OOa04tE7OMPV8XNGHrcmRuGY6qKydSZmgGqxZNr1hIGdDvqf4p8rIgxYn30b9XhtWtGbVBICmuXQPh6j5xf+8mHtwd57XaH9z9EjEW4yGBdNMRFI4Fk5V1YBJyrQjE02LoSrOcxTOIrcWoOmeR9FBI8RWmJ4rtIIp4SSayYBQ9ONvkAvkWZUjqxbSfZb2KGiwucM/n76sFwTcJMKdMhogTcxX8NeWoy0namoWpyJjf2o7sp0EWc30c1U+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncscqCaOHqqkaB0fuB9smQFCw0qWRIyzQ1/nDtAM3mE=;
 b=IvIGZ8yuJ5BZP7giAKLpkDHmtttfn3PazSa6acd5nC5TvnMwvxc+ZGP+ifq3tQl7+ywFjw8Fy7p9P1iQwB495ElPClDZlx5nXv2S6nXM38SreEe3NMwp/OtRIm4Pts96ih2zY6ud4KSzvat7LqBHnJgJZkqz4B4FhAKgG/EH7lI90ode94NAfKCCQWUhYOUbF/L4w3Ut1bzfdQjLqFC1TLHRaJ9y7AJHxRa3rlsAG2rSo4Utx6Grf27UJQBgG0hOnM/FGui81QU+Ml9Q7ihGf3iUynIgYfffMQdU/n/39vn7GPY6LXRwerxRlz4LBWnRfSnUp7W09QZBhK/miQ7AOQ==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by DB9PR04MB9843.eurprd04.prod.outlook.com (2603:10a6:10:4c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 22:01:30 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 22:01:30 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next] net: gianfar: Use __be64 * to store pointers to
 big endian values
Thread-Topic: [PATCH net-next] net: gianfar: Use __be64 * to store pointers to
 big endian values
Thread-Index: AQHbG77J1JfsC47Yd0mkYpI1pNzWE7KCGn/w
Date: Fri, 11 Oct 2024 22:01:30 +0000
Message-ID:
 <AS8PR04MB8849ED31BB74E4FD193AB26396792@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241011-gianfar-be64-v1-1-a77ebe972176@kernel.org>
In-Reply-To: <20241011-gianfar-be64-v1-1-a77ebe972176@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|DB9PR04MB9843:EE_
x-ms-office365-filtering-correlation-id: 185239fd-3645-46ff-6ee3-08dcea4042e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?anRtN3IwVTRSTE1jeTVkSmQ1YWo1K2E0bEd2Q05pR1pSOXBVYXFld1RGcnc1?=
 =?utf-8?B?Vlc5RTN2YXBwcStPbUJxRFMybmpjdTJYMklFZ09XYnp2UFQ0ZWx4NXpnb0xE?=
 =?utf-8?B?VXIrN1hHck5sMEh1d0RvNERnRFVVaSs2RUw4S1Q2ajJCalJYS2sxN3B4QklH?=
 =?utf-8?B?R2xERkUycThITm1JdWwxMEU1YUNjb2FOQXZmbmgwTDZmalA3NHRwTHFHVmtq?=
 =?utf-8?B?d1BVU1FhbE5sMENjQ3lDQ1cwaEY0RFQ2aERqeG43QURyOEQ3elFlVDZuSEdp?=
 =?utf-8?B?VlNUa1Z5bnRqOEJzUnp5SWYwQmw5aWozL1lubWJXN0s2UGdjcWVGamdRTm1a?=
 =?utf-8?B?d2syTWZMMmRSZTZ1R1BLVEJJSHdlU0F5UnVaWE1lWWxad0lLS1RKNWZLU1di?=
 =?utf-8?B?UWZFNlVCbmhRR1lwSDhpUmNTVHRUVnU3d1dITGM2TGk5bWpRSzN4K0UvcUhp?=
 =?utf-8?B?dFNHQTJZelRYUUJoNm1XQ3VGRlBLVHZRclk0aGxqcGxOY2I4aW9EdzZrRTNY?=
 =?utf-8?B?c3d2MjZzckJTTVZpcmdIWUx6RlJQbVEyMkJ0aWlTbW9XeTlRS3dvemw2cFpy?=
 =?utf-8?B?VFI3b2JqUmw5bGdIK1VpOVhXdml0ZTY2K2c5UlNuYlRJajNzQkdmbkVpMncz?=
 =?utf-8?B?WlByNkQ5c1FMYzJ0d21GeGw4TGw0bDFpNStYZmYxeEVnNWZ1ZGhVM3hyTTh0?=
 =?utf-8?B?cWdjUGgzODhFa21sWFgwRitoeklPdDR3R0xOclVwa0lIVzdFaTRrYUswRklO?=
 =?utf-8?B?eVVIeW0rMlFDa1ZEbFIzSU80YkdTcmZmc2lpODNzY0xjdDh3SldURzdnT0hS?=
 =?utf-8?B?L254Ly9QRThWRVQxWFFGZDZDVm5PVDNsVnIxYk1kVlJQMUpqVU8waGZ1WVd0?=
 =?utf-8?B?RGYwR2V3U0hjbWdNVE05c2NaSmx1ZXZZWXBLaEVpYUdhUkx3c1dwQmZGbnlr?=
 =?utf-8?B?YXA1cDcrRTY1N3J5eFpVQjRFOXBYTkg4ekxRcXdVL0xvWDN1V3NmYUU5aUYv?=
 =?utf-8?B?a0lWOHBWTzRHWWlOK01YWjkwVzFvaXRqemNzWDZtYkVyMFBrUWVscXRGSmVN?=
 =?utf-8?B?Y3MydUtIeCtVVTZDUGd3UkhDN3E4RzlUdVdQZ3JjckRuNTYyZVdOTkJiSFI3?=
 =?utf-8?B?dms1RFVpN2lFNmZ0VVltQjZROUtVcnQraVFXejc1dU9aNlZzTDdMMVZqOFJQ?=
 =?utf-8?B?Y3FwMkdGTGdLekRWMFVwZktHdit3cXhFbTJ2NGlGZm1RckhsZDM5WUpXK3Nv?=
 =?utf-8?B?VENtdm43L2gyYnpOUm5rWGZ0ck1CTDZ2cXloQUJxbWVxbmRpSmo3TC9jQmds?=
 =?utf-8?B?eHlTWXI5T2dHKzVldUJjQlZ6MHNITjZqcFJJMXpZQ0E5Um0yMlFZanZRNGJK?=
 =?utf-8?B?ZnpmRUt0NE9wbzZJaDBCRHRPM0VXS29vanVyUmRLam01aVFGZkI0a0RJNWll?=
 =?utf-8?B?cSt6ckNBNzRJcjUwRytDbEVnRUVscFFUS211Nzk0Qm1sRVl2aGI4aWhvbS9G?=
 =?utf-8?B?MDdzeTFMd2x1SXh0WUJ1QmFyVlcvejdpV0ZGSjJIdUp1bUtBWTdwcUowNCts?=
 =?utf-8?B?cWoxU1hRWUdBeXhMNVBvdmVwVDh4NXVESGtyL2l1dWZBWm93eGNFclBOUHlE?=
 =?utf-8?B?dG1ObnJCbVBmb21HdUo1SjJhZ2JSUEEwZzV4U0hwNnBuOGZtT3cwQlJXSVdW?=
 =?utf-8?B?TndZQVVoOEhDOW9lRmU5YUx6ZkxCY2JsajdRc1NjYmI0bFViMU1tNUo5YTQ3?=
 =?utf-8?B?bjJwVk05MUhkaFFpdFpqR0xPK0puVEw4eXFuZGRNbkN5eGVJMmJRQ00vTUtx?=
 =?utf-8?B?VjZoZFpnMmx1cG5QNXZUUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bks4K0tVR1ZCVi9TOGJheXdkc21ZQnZKbytnd3hCL0EwbVlncjZ2Y3hySjJj?=
 =?utf-8?B?alBzSkdoUmwzVWh3ejUyR0Vnd0V6YUNuQkFIUmFqQjBJcStIQWdWL25rY3Jp?=
 =?utf-8?B?QmRSeHF2U2NrMHdGSTdZNnJXOTcyTnBBWnFkWEpOL0xLcStENS9yNGcwUlZJ?=
 =?utf-8?B?RG00MHc3TFFWZEY4SlVTRnJVeDZQWWZXOEpOR3p6MS80V1ZvTUQ0ck9vaXFl?=
 =?utf-8?B?WnNvdXAramZWZWduV2RuZkxZZWlNU2pQODRhTXN5cmVnT3NMbE1wcGVGd1p6?=
 =?utf-8?B?ZjZucEt0YnE4YXVIZS8vTFdyM3A0LzIyYXRoNmpCVWxGSEVuNC9tNlZvU0Yx?=
 =?utf-8?B?eGFKS0lSSGVaS1A2TGZtNFE5Mk5jQ0k4SEZWK3ZvOVBaV2lxcjFJaXlHUG5a?=
 =?utf-8?B?c1hXVEpYQm9aUkhBakEzM0JDekIralBiUHJ0S1pMdTIwMW5LQlErYXhkNnZ3?=
 =?utf-8?B?d2VlV1NhTWoySXk3Q3ByUU1HM3I4L3B0K1B1U3ZmMjgyejg4WURycEJRTjdx?=
 =?utf-8?B?MTJvY2Q0TkpuZVBiTHZGdGxBd2dUTHJUcDJCQW9JK1VkMllheHkvYm43b1lL?=
 =?utf-8?B?ZEJOVzZ1Y004cy9mNE8wdWIva0ZOdzJoN25PM2FFMmtGZnlYamluQW5STmhT?=
 =?utf-8?B?K1FHZjZ6dmIrS1FiK0VBNS9tdml2UXl3UTV0OVdPUFh2NFZqdU0wR3VHdUhS?=
 =?utf-8?B?WTVVeUlaM29xQTBVQWNXbDNmeXcyWk5ZeXJoaXZkenc5VjM0RFpseFIzS2pQ?=
 =?utf-8?B?M0oxQVFEdS92SWpHU0JNM0VGUmxzK0ZyTER4bXFiZVdHQ1N3TXRNV1U0eWdP?=
 =?utf-8?B?UjFPNDBqWU5MTHlFTElUYU1rM1A5OHBlbVh1OEpiQ1BlTm1wNGVyNGkxVU1B?=
 =?utf-8?B?MU1YSUxDRVdDRUFTK3N6UVVLYVcyckwzYnZuTHA4bTljOXJydnBmYVlEU1Yz?=
 =?utf-8?B?bUFQVmdEaUpxMWJyMHRtVy9abWlqQTBOWDlUTi8yeE8veUZiUzJ3cWkxOGd1?=
 =?utf-8?B?OUh3L21rQmJiOVB4d296V1lZdG9QTm9MS3JHOGE0YktidEFiczZxTnhxTFdG?=
 =?utf-8?B?QW5zUEFJb0pFRXQySmxvUm9URUIyb2I2aS9ZZHBYaHZHeEt6QUZoS2dNSkJB?=
 =?utf-8?B?dzNjV2VBM0pXL1pBK2lmR1VYb0ExY21FazQvODdZQ0VqbjVuWDZ1aUgya243?=
 =?utf-8?B?WDE0TUxrZ2dPTlVDUXRWcFI3QloyUk05di9QeTJlaXQwMFhUdUVuMEZ2UUo0?=
 =?utf-8?B?dlE4VE10aXlIcWFrQUZBVlp2VmRyUTZsNHhwUUppMTJzdEtiemJMbW1nS0FV?=
 =?utf-8?B?SkZmc3BXRGVGVW4waUYyOTZLU1RYR3llV1Q5TlhnRndxZW84VEU1cUJ0SVU1?=
 =?utf-8?B?b1c0MmJ6OVFIVTlWT1J6c0ROcHFDeGpzdkRVei91bXRzUzJOSHhma0lmUjl2?=
 =?utf-8?B?Z2gxTERwNHJjL0krNWExOEdpR1hQdVVDK3FkNHlFekQzaUh3dk9aOCs0ZkFp?=
 =?utf-8?B?ZnN1MWxxSm85NUp2Q3g4QU1XeHNmcGpjeG1acFhBWVcyUzFrUzc3MkpMUWRl?=
 =?utf-8?B?Yno2UHVHUEVFOXR3VUt3UCtMSkVzRW5xMjVndUdsMDBXUWdmN29qd0F0Wkx6?=
 =?utf-8?B?ZXkwVWZ5NStxc0VhUllHbVBMNERtYUJTMjA3QTVwbTBOMGxndEJoWmxYdWdP?=
 =?utf-8?B?WDI5WGUrL2FWUS92UEF6L1psVm80ampQbC9ROUhkYzNubWw5anNuSit2c2Vr?=
 =?utf-8?B?Vjg1VllIN2MyR1JrbUljejcxejlWQjdGN1FZQkpJZ2h4VXBlK20yek9UZW5j?=
 =?utf-8?B?L3hrc1FSaUY1dUtYZnljN0xvN3JGZm94OWs5UUsvRXgrQjA5NWd6OXFXYTdy?=
 =?utf-8?B?OHpuWHdLU2JpNEVXbk9SU0NBc1JkNk5KQllpdXZsYjFUa3BON1pzckVkT3c4?=
 =?utf-8?B?em8vWjFOanBkKzdBSlRvRjFabEpvRTBLamVzRHBuazdUL1ZGZ08xZy9iT2Qv?=
 =?utf-8?B?ZXVWbUFFaEZiQWJ2cWMrcUpUK1Y2L2hxS2xnRCs2b0EwRnJ0R01qRUtzWUVK?=
 =?utf-8?B?elptam9wN0s3YjNZUC9TdEFwNFRpSDA3cnRtUG42NFBDdGhFZ25jRzJDY2Jz?=
 =?utf-8?Q?/JvhadQQxmKdzyJvqKyJl+b4X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185239fd-3645-46ff-6ee3-08dcea4042e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 22:01:30.1018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LZfLctoLPLeXMzSOoIyIJ6VLIp2BbtmMybUuU+9K3sQSA1s96FW7XGyUdB3IEtrMih9ag+GjgPnNExvxA9pVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9843

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAxMSwgMjAyNCAxMjoyMCBQTQ0K
PiBUbzogQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+DQo+IENjOiBEYXZp
ZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQNCj4gPGVkdW1h
emV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8g
QWJlbmkNCj4gPHBhYmVuaUByZWRoYXQuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBbUEFUQ0ggbmV0LW5leHRdIG5ldDogZ2lhbmZhcjogVXNlIF9fYmU2NCAqIHRvIHN0
b3JlIHBvaW50ZXJzIHRvIGJpZw0KPiBlbmRpYW4gdmFsdWVzDQo+IA0KPiBUaW1lc3RhbXAgdmFs
dWVzIGFyZSByZWFkIHVzaW5nIHBvaW50ZXJzIHRvIDY0LWJpdCBiaWcgZW5kaWFuIHZhbHVlcy4N
Cj4gQnV0IHRoZSB0eXBlIG9mIHRoZXNlIHBvaW50ZXJzIGlzIHU2NCAqLCBob3N0IGJ5dGUgb3Jk
ZXIuDQo+IFVzZSBfX2JlNjQgKiBpbnN0ZWFkLg0KPiANCj4gRmxhZ2dlZCBieSBTcGFyc2U6DQo+
IA0KPiAuLi4vZ2lhbmZhci5jOjIyMTI6NjA6IHdhcm5pbmc6IGNhc3QgdG8gcmVzdHJpY3RlZCBf
X2JlNjQNCj4gLi4uL2dpYW5mYXIuYzoyNDc1OjUzOiB3YXJuaW5nOiBjYXN0IHRvIHJlc3RyaWN0
ZWQgX19iZTY0DQo+IA0KPiBJbnRyb2R1Y2VkIGJ5DQo+IGNvbW1pdCBjYzc3MmFiN2NkY2EgKCJn
aWFuZmFyOiBBZGQgaGFyZHdhcmUgUlggdGltZXN0YW1waW5nIHN1cHBvcnQiKS4NCj4gDQo+IENv
bXBpbGUgdGVzdGVkIG9ubHkuDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KDQpSZXZp
ZXdlZC1ieTogQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+DQo=

