Return-Path: <netdev+bounces-146371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A96A9D3240
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 03:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08AE2841E4
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 02:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDE82EAEA;
	Wed, 20 Nov 2024 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="qWcIUqxQ"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023077.outbound.protection.outlook.com [40.107.44.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE30193;
	Wed, 20 Nov 2024 02:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732070316; cv=fail; b=CvEXC60Rr5AoCyfp2kseOQlOK+KPD3IthoDEh3nqgEC14pwJWIeGLnQeQ81BGRUsn4ND8ikGuOYJq3JokhlCbqh+9E0IdDBZ7LtOBEPfk8Q/OlU+SKD3eRXXmFjYggqDzKnDczsEIo9FZZuJV1ibQIqd0Zf1tg4ziEKRvGyBTo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732070316; c=relaxed/simple;
	bh=fij/Nbhp4aRPoaZGp1ZLzq8EPsU2hYOZZUYPzT73NPo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dz4THXuyb391etDUmcf8Q0KEmp/HhS/znqRJyE343DAdiuGFt2poEovsRUcXGqLSMNkv6JWmkKNCmSRvqz4Jjvn2xUpQGotObzDhA+pt8PyUv8ux55wsZBzNUjWSM9dCH5OTWQS8uAwXRs1yRX2jMZkzEGUQ1DGU+bxgmWW1rJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=qWcIUqxQ; arc=fail smtp.client-ip=40.107.44.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULWVG+PZU3Z7/7rzdumCQiUjlp3e77y+8aEdcn0UTs+Y1Eefg39oXsweFXovgNzJGDQzNE/4d3a7izBewZDTEgSB6uNExeBom3iuSi7qrZmPxz3BUFXVZazAXKFkaFMYirrWUrODAl3sWK8yh5QLG5kRPj5VkAGq1hZqdEJ0fLZgmivl0qIHIK/9DPCvqdmDLRMgXg1uWsXeWgmqxltbVMF8YYybM6A6NkCipFvOuRR53RNlCQ9kOGyxeKN5NJl5HjaWXjm5fdOnbJ8oihlJT8EfShNDn4XOqxFlNbAyxMpazBEHWW9FkQi4pez6iJSla1rT/r1mj5QwODWAYgWbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fij/Nbhp4aRPoaZGp1ZLzq8EPsU2hYOZZUYPzT73NPo=;
 b=ojQEN+SRj1kJAUqEUpCcYuauA0SRfWI++JxA2xoJMTs3OCdT4K6EmrBuAEyiS8pS/6JZhKl5pyPe7PJPG7RPXtG9V+AN33obmuyCwtJatVpJup25iCfkZyA0o1z1KNI/RpdevkJQlpVo15iRpDldIl3unanITM1BDQpxDhCamlU7+tFjlWodoD37zU8Jjk+69KbO30yUhTp1WHb3CFfAbtykNRmyUHFaXzIyQMJI3/rbHoxvYUYh0ZU3O3dObZqbPwIHY3NEBUcH78F+Jpw/xZJ0lfNmDVpsEEh3YSyZ2mF7dDp+7oDWw4ISHK4wXQgiAN6Ciu9CeXm/ey9ttYIjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fij/Nbhp4aRPoaZGp1ZLzq8EPsU2hYOZZUYPzT73NPo=;
 b=qWcIUqxQKNwdVulUTTOH4S0cTKFmtB1IvoD7OuWrVQpL8Dl0i212LigEWAHCUoALucH0PesqpQhkEySu+NXCwJxkHn48IyLT7cyZfA2boTmbKiVVTGgQbFZq33pYYpio/2iD24BZJq8JStGTItyKU9W2thxQCKQaC04EYSkQejlo7S0A1w1KILCV1NXxLhGsMQ+bj1hh3lWJpmwxOiI8quGe0YNOv4N64+SNViJbItrIyPhLVd+E5vPMG2f5FMSaMaQ1rAiS/8zaT75MMUQAp74T8SS4Yn9QVCSXHOqocG4eVfoeCZ1zS3Ywvl9r7CHh/hDoBYh0FEJlVc2nNUf/HA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by JH0PR06MB6740.apcprd06.prod.outlook.com (2603:1096:990:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.11; Wed, 20 Nov
 2024 02:38:25 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8182.011; Wed, 20 Nov 2024
 02:38:25 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Rob Herring <robh@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW25ldC1uZXh0IDEvM10gZHQtYmluZGluZ3M6IG5ldDogYWRkIHN1cHBv?=
 =?big5?Q?rt_for_AST2700?=
Thread-Topic: [net-next 1/3] dt-bindings: net: add support for AST2700
Thread-Index: AQHbOadLTi3HdZRPK0muT1IFdeAEcrK+65GAgACKxLA=
Date: Wed, 20 Nov 2024 02:38:25 +0000
Message-ID:
 <SEYPR06MB5134C9B36659A0A0EDC9076E9D212@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <20241118104735.3741749-2-jacky_chou@aspeedtech.com>
 <20241119181831.GA1962443-robh@kernel.org>
In-Reply-To: <20241119181831.GA1962443-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|JH0PR06MB6740:EE_
x-ms-office365-filtering-correlation-id: e8f86c1f-fe85-453d-696f-08dd090c68a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?SkYwbTh4MnphV29qUHJvcGMxYklNd3JIb04xZlpGVVNydHo2a2dKZ045K2FIakJJ?=
 =?big5?B?NGRkbEp4VkJKYk1RRVc1c3V3REdLVGxpcEswb2E2ZGZHN0w5em10dkFDWHlIU3ZG?=
 =?big5?B?YzBqT2FTYXlzVzNqaXhHK3FzTzlzZXhMbGdWbjVMWklMUVV6NVNUS0tzWEZQUith?=
 =?big5?B?c05SM2NmVkxqdkpJNGRrSWZoTXdxSlk1Q09SOVBHdEpUWGNRUnVtTUw5OG5XZzRv?=
 =?big5?B?a0o0bUNOdkR4RVFvVzRBeVJQRlFOa3c3T0crdzB3U1dYem85eEsvZGhTWUh1ODNl?=
 =?big5?B?Q3dXWUZVNDZpbjdsNVVjalpvWXh3MEtXL3lJakR5NXgxVE1SekdEbE5ySHMzTmtn?=
 =?big5?B?U2JyNEpxRVBNRnRzbWh4OTdjZWgyUVA5YVQvQTZkMzdxU05QQVJpRXozeXdVdk9m?=
 =?big5?B?QlpkWlF2d2tVZjErbzhtU2xTR05TRktHWFdMOGg1NkRpQXdMb0VsZDFXTjA1Y3lz?=
 =?big5?B?Z2VkZXNrU0VDREhTRnV2WDNGcXMyeXREVXM5cnhFUXNHWjJOWlRTUFVjNVpncERJ?=
 =?big5?B?VHZNTTJBazZKczJ3VzFlSGpEQXAzVlFoTlNOQmxFSkFkTUI3Tk9aeWVJSkpKSk55?=
 =?big5?B?ZkNMR3M4VWlWMHYvWkU3QVhOZkR5dFJkNmhnMVlMZ0JTR0lpMjJrSm02b1pOZ3Ex?=
 =?big5?B?T3hpcEUrYWFzRWN3bzMrMFZsd0ZTdjZtcFR0azV2eE9zY1NHT29jb1MveDdVWE9k?=
 =?big5?B?eExWcHI2MlBuM3JIenh1U0lrcDREWDVRVWRuNDFXdjJycWgrTElTOXdxbW9waWdP?=
 =?big5?B?L0k5SjZSQzFsUnphN2t6ZUdFOW92RmxKdXk2WEZjT2xhU1UvNGRYNEhzL1NNTndX?=
 =?big5?B?T3hNbW90L0hFaUdBbldZM3JxU1oxOWROVG91TWdSa3daclNQWm1DdnhkK3NLUkJh?=
 =?big5?B?L1MzeEtNQjhMWVdrR2tRUHVKVDdpTjRGQjhuZ01hajJ0YWVxc013MnVKYW9yZWIw?=
 =?big5?B?eUZRL1hpOHhEekNkcXZBc09FZUZvcUJMeDdtamloZGJQOUJYTGhwYUZmNSthWDJ5?=
 =?big5?B?dmdJR2tnL05WYitjVktkVWdjaXFtYjdPY3IvemVJMWpLM013QTh3dmJTdmZzTFNt?=
 =?big5?B?YkFWTXlxeE1yZ0lwUVdHbUJ6WmI3RjlmUGxpSjdGUGNjZ0xtelFSOWJQb3ByWStS?=
 =?big5?B?U0ZQTEJZVFNLU3NMVjk4RzFsQmFzNmFTNGdoK1oxZUxOeXNIY1dlS0hqN2VxS0Iy?=
 =?big5?B?SS9BMkdVeWowWmcrbnVKQWY5RjZNTlJ0VVljRFdyMWVCazdPdjIwdkFPRGgzeGFI?=
 =?big5?B?TkJaVXhUWGhRNnh5K2dLLzR0NXlhcldrdm1hZmlyMVNiamhMdHZKTno1eEtqTXVZ?=
 =?big5?B?ZDZsL3YzRHRuWXk4Rjd5YjFJbXYweU1hOXpkZzJXdmdOWE5IOEJMZ1pBckdoRFo2?=
 =?big5?B?YUpWZElmdDlibVg4SVNnSkUvbjlaVXBwTXR1T2l1MndqbFBWZnpqTDRTVXhJcTRU?=
 =?big5?B?bEZodWxRLzlQNThYTXNjdThOR2dkNzc4S3pJZTQxNW9odEtQU2tPSmRVaTRobFRl?=
 =?big5?B?RGVOcWRRUDh0alVrd0pFc2Y5bGVnT0ZtQWZjMXJGa05VOTI2NXNkSkdMa1VSSmNr?=
 =?big5?B?Y3lueCtmRWNFcjNwVEIrNkpaRkl3UmNnWEF6UFljQ2tHRHVuTlU2Y1hWb05OdFlX?=
 =?big5?B?UDVlZ096UWNYVjNHMlpHZmdYMHh5ME8zYWs0VUVqZ1NIZ3dmYm54c1YxU2QxRFlE?=
 =?big5?Q?7z8UX/TuxEWFHHP5BWbSTWPQ004dV2JKXAzu6hXtC3g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?QkQ0UWRQRTYzc1VTcmExMENhcG1kV21sZWpBMGpUOWRlTGovMVMxbHFYQjIzUFc0?=
 =?big5?B?ZG4yMVZkL2tITXJ6ZVo3VUtpcmpDVTJUTWl1MFlobGF0NXlEazlxQjIvaUVweUQr?=
 =?big5?B?OS9iM21vME1SeDl1NEl1SllaVGh5RjNSQWpSNXd1bDRqK1Z4czJXaWR4WS9XS01S?=
 =?big5?B?ZEhWb3puREJrSzdZZ1VRWURKK3VEbUlGdEVud1cxMG1FZFR4ZE1Mc0hKV1Qwakpm?=
 =?big5?B?YVB1alFSdlkwTkhOMU9wa1VsLytNcjZGU2hROFl4NGhJUS9EZVJuMW9RYktySEJ1?=
 =?big5?B?d0JGWW81dHZMS2hvSTFML1VoaGliMXg5T3V1YkhyWjI0cW03c0VXWGlsTWV2SFNQ?=
 =?big5?B?SU9ubnFTWnpyRmF6ekgraGoxQzYzcjFkZCtLcW5HM21mVDl1MVhJblpKeHIwVkFl?=
 =?big5?B?ZXU0cERBcWZQMUhwWGVZYkpraW85Y01RWDF6L21tTU9rZDlSbGhTVXdKdm1VMVpy?=
 =?big5?B?NzhjanRKOWtlOXdSNS9PdDI0QTdyKzcveXNuSCsxMlZ0cFNyYWJpMmc4WWV6bkF4?=
 =?big5?B?cTl6NVFKK2RsTVlGVEliL2pYakxjaE03S2JMUDJPREp4SUludUFMVW5wakdxejRE?=
 =?big5?B?YVdQSE1qc0wzVVJPczNpa1VhcEhjMU44NUxFTjR0SnVYdHNjZ3cvRWVyT01palBK?=
 =?big5?B?N3B1MTRmUWhFeHJJdWd5N01KTnE5cC9sbENETDBMYVZUM0ZQZHozL3JwcWtPSXZU?=
 =?big5?B?TFZENnNZMEZMWEVwNGFmSjdudDJnTDNGYWNzcE16bzdHR0piQVdLVThoOTJ4T0xP?=
 =?big5?B?SUh2dmNSQjJtbGMvdkVvdmxiMWRqTGZZUU1mZktjN3FOaGs3Wm1GY0ZJSlVEUjc3?=
 =?big5?B?aGp2Umd3WFZESk9XbVN2VVA5clNFVE1kL3dEN0tRNkt5bFhWUHlPcmFueGhYSytL?=
 =?big5?B?K1dtZEd6MWRxeVMyRWVCbjJBSW1xL3ZLK3dhdGZCQnNZQUJPYVJOdzZwQ3hlYi9H?=
 =?big5?B?bFZTWW5zMll5cEYramZsMVYwWmFMVS8vN3VjeFE2KzJodjZVdG1SUDNpYnVkeHlB?=
 =?big5?B?M1htajNiWGhXVEhHN2RHd252ZjlyR0x3bjM4dk9vamt3OTVSbkMxS3J3WmZDUk55?=
 =?big5?B?aFNMVmx2dytoT3JONGJoRlA4OWtSd0JWTkR6dDlBckM3akxRZ044akJlZ05oY2RD?=
 =?big5?B?SlIrYkhGbEQrQlEzTFoyR1RVdy9nTFJ5UWtBZ1NiRU1mYkMxVHpvZnRwOUtrczRj?=
 =?big5?B?cVNwRmNpOTRxdXplb2dsdjZvSTdWWHlIZWNZcVgrckZUMjVPK3lmUzdaZGRUYXA2?=
 =?big5?B?QXpCMG1TYzA5eHhuTjNmeXhHeXJXN2hHRlRuYXZEWFFPcWl4cUQ1cVlwbHBKaml5?=
 =?big5?B?Q0M1bUpxUVFadE5uaTdHbldWYnN3ZGkzcFVGb3NRMXNvbjVEQm42WER0ckNGL1ZC?=
 =?big5?B?Zmtpb3FmTDFLQytIanhjb2Eva2NCd0Z1RWk2UWxaN1hNQjJ1NC9DSEZsSXFFMUxw?=
 =?big5?B?V1VDZGg4VEVlcmw1aGJteHNJS0Y2WHplbmIrWmkzZjRjMXBiTWQvVTVUYUx1NjlV?=
 =?big5?B?eEVWYk5KdGM2LzlBK0xuaGU1Q3ZuSXluRTJTRnZMZ1hyVkpDSGZLSzVVbjkwc2lQ?=
 =?big5?B?NVNqdVVWVW5XczZxbSs1SzFzTW1uTGJ4ZzZPYlpSbXpXbVhmc0h1UzdxVlQ5WjNa?=
 =?big5?B?VkJybTMybWh5TWlvVncvS0VSYTBhNzBQM3QzOGRvWldDanBuV1FDUnllVDUrb1NE?=
 =?big5?B?QlQxdDBYbVYxWnNkc0x6eG05Snc3OWdmclNzQkViWUpSQmxlWTdzR2o3UGNlUUVl?=
 =?big5?B?S25rNmkrZ05iK0E0RUJuU0NnZVlVanltTGdjdGdiZ2JBNVhjQ0g3NTVhTGJqRy9P?=
 =?big5?B?aEtseEJmaHY4RnliRWVkZ2xZZjhIMzMxMTJOTWJEUC85c3F6V2Nza2F6RTlkdUds?=
 =?big5?B?VXBCUi9qa2hqY0dMZWhubkpTdGJIRzJkWnl3aE5HcGUwN3RvelZ5RVlxVUhqYnp2?=
 =?big5?B?RHhKTnlOQzNJblZReXVuUHc1MER2THZqbWE1cE5yTTFSWGpPaEw0bXFuU01WQ2lz?=
 =?big5?B?MHRSQSsrcE95UmlxR1NzekoxMitjUkdnbTNadlBSVFBOSlJkREE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f86c1f-fe85-453d-696f-08dd090c68a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 02:38:25.6212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VwxoyYrvxity0s1Kgdtd2BRBMn3VEm2MlyoXP4XvhuRyWXD2ZuRv348Slpw5nmrBy9fa6Oz6odaq9ZopU3s9KMwBy4oGxBRWy0W27ydyh/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6740

SGkgUm9iLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbGF5Lg0KDQo+ID4gVGhlIEFTVDI3MDAg
aXMgdGhlIDd0aCBnZW5lcmF0aW9uIFNvQyBmcm9tIEFzcGVlZC4NCj4gPiBBZGQgY29tcGF0aWJs
ZSBzdXBwb3J0IGZvciBBU1QyNzAwIGluIHlhbWwuDQo+IA0KPiAiQWRkIGNvbXBhdGlibGUuLi4i
IGlzIG9idmlvdXMgZnJvbSB0aGUgZGlmZi4gQWRkIHNvbWV0aGluZyBhYm91dCB3aHkgdGhlIGRp
ZmYNCj4gaXMgaG93IGl0IGlzLiBGb3IgZXhhbXBsZSwgaXQgaXMgbm90IGNvbXBhdGlibGUgd2l0
aCBBU1QyNjAwIGJlY2F1c2UuLi4NCj4gDQoNCkkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLg0K
V2Ugd2lsbCBjb250aW51ZSB0byB1c2UgY29tcGF0aWJsZSBhc3QyNjAwIGluIDd0aCBnZW5lcmF0
aW9uLg0KDQpUaGFua3MsDQpKYWNreQ0KDQo=

