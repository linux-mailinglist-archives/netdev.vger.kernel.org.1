Return-Path: <netdev+bounces-145883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99C99D13CF
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74143B22F73
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D781A9B3D;
	Mon, 18 Nov 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="dnhri4EU"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2096.outbound.protection.outlook.com [40.107.21.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39613D518;
	Mon, 18 Nov 2024 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941871; cv=fail; b=UbslPrPZxc9EiskxKmCFuaWUpz09r/qFOALcMRxGco926pr+l9tLQIRVFlLypv/Oy8dTcM/Tz4yT2o2F4cZ4e6vYT3p0fOPNpWBno6Cx28dEdoZeCe/2l5pubkjTduesAR2H45UHZyGmz0kgSYo9kveP/Y0vtC6jZxZ1z+CQBXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941871; c=relaxed/simple;
	bh=UOMhThwr27TYOlrYlLvS659ilNgEYt6wg/V4A0BA56w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rFTvpLuj5ba1n87e13HKVcMHJFVCwLGz5suKflGeXcIe28Irw/ME/k4wiBtEI6ou3PF5nhp7OBjT7DiDBkohBymdgbnBzVAWkSadAaPTxI1jcgFxQHJ4qMS+ctfCJqU96OioAlpEt988cJFpyUsAOLHqOusr6jpsbuQIsPjwOGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=dnhri4EU; arc=fail smtp.client-ip=40.107.21.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6vwEgnJI+zTO0dWpuAkBSLsdcU0+ycGFgEmgUrf3ypZZJ5zIRou7WSFMQLtxczbm5xI9LyjOZkPYGL4k91bSn2JSXIX4olNq3dvH9267mUYnw44wL8dmi0korN8ZlnqMePz8frgFHlyQ/5/1roGXNkgG9E9P17/+kGbWWzYBXM0imMrZA8nNafKjxyl7LzpHfD4zflCQOpwLPCSm6lbyM3WL6UBf3XHfGBD54HhaS5cPHl98cEa898ukrg4Vz2QLiHTL5FzelWRFjuxbHv8HvcLqInVnTYmX0icpjFilKUBA+h5NhjELkb7ci3a2mGbyjHDPYQxkZ77hCwwBHwjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOMhThwr27TYOlrYlLvS659ilNgEYt6wg/V4A0BA56w=;
 b=KbBWlUwmwL76FPFqhHKj1B4sJXwKfQFhIxIX66Xf53ASKaKgKjt2aZzsPkmSdWJjvIgEhPawyUHtYfXdARy5ccTrW3IP2asS81QUTFHYEgonwXOovSkTF3VDAzwFs9++vT9vAUwrlXyCW+ApDM/LcFlhcPCFcwtH9E+UHRovNvPoevpIEBI0f2+Kb6lrfKpP350+MlWIiyW0q6Mkxykcls8NdxUiB/K8fz8gYQqrY9tFKK0OY8hYGTyHYQCpEsBpFgZxo3QRyvnGSLjIG4dFRl1rEUGSpiwqGnDnnO9U8M2mG6ALIl3Hw6ndX1lwRFjHuM2dBcfLttRMwbp86FUtgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOMhThwr27TYOlrYlLvS659ilNgEYt6wg/V4A0BA56w=;
 b=dnhri4EUIyInjhh9ufIVsVfahAtscx3W+I+ZbKfTDh6uoOyWFrcmjRKzY1lrLCmq+8r1zVck5TczS/bEsx7K/60M74K8NUQfrBcVgmbjduglskl8dp0jHRr6U6zrb8EL77PWdQwZb50hKRXugWXHDLFZetVLeEk4/S0G8ee0JZc=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI0PR04MB10093.eurprd04.prod.outlook.com (2603:10a6:800:248::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 14:57:45 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 14:57:45 +0000
From: Josua Mayer <josua@solid-run.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mor Nagli
	<mor.nagli@solid-run.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: control mdio bus-id
 truncation for long paths
Thread-Topic: [PATCH net-next v3] net: dsa: mv88e6xxx: control mdio bus-id
 truncation for long paths
Thread-Index: AQHantH8wZxLbGkA70ONa4AkREvmfLGJAo6AgAKs9YCACahbgIEo/vAA
Date: Mon, 18 Nov 2024 14:57:45 +0000
Message-ID: <14256ba3-b0d5-44e3-9486-1f35233b594c@solid-run.com>
References:
 <20240505-mv88e6xxx-truncate-busid-v3-1-e70d6ec2f3db@solid-run.com>
 <A40C71BD-A733-43D2-A563-FEB1322ECB5C@gmail.com>
 <c30a0242-9c68-4930-a752-80fb4ad499d9@solid-run.com>
 <20240513083225.1043f59e@kernel.org>
In-Reply-To: <20240513083225.1043f59e@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|VI0PR04MB10093:EE_
x-ms-office365-filtering-correlation-id: 88086b55-be9e-4857-b53b-08dd07e15c2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zlpqa1haakVJYzdzZmtYR0JscTlvdHNtNkFkRlFqTjE5VmF6QnVxUzgxSS9N?=
 =?utf-8?B?a0crZHM1dmNFZ0VWUG45V0RwZGV2VnR3MmEvdituLzdwQnM2RDdaVFd6MVo0?=
 =?utf-8?B?aDl3bTVmREFqR2oxZXVKRk9OSHplQWVFTHk3ODFmRXNUQWRTKzI3bXdNZnZS?=
 =?utf-8?B?RzlONnhVWXo4MmdXV3hvUmV3a2RYRDFOUElLbzYvMDZHSVpnaFRMeVdVLzhI?=
 =?utf-8?B?ZXNmbjkrQ0hNT2VmTEdPRXlRM25YNFdVaTcyRjc2bkZndlVWaFY0bUpZYWRV?=
 =?utf-8?B?ZmZVUXJzRUxvZ3RGZkQvLzRpU3BteTJVb0hBQ2xvdGZDR2RicHlyK2hSOHdj?=
 =?utf-8?B?cEppOHVBR2VEZisvcnZEMThlOXZQWkhNem5zUElvOVBqdlNWN3g0anQ2VW95?=
 =?utf-8?B?akh3cTN4UnBGd2ZpUDhMSTNpb3NpT1QydlJkMlZ6Y0NGNFIxNi9aQ1d1WU5M?=
 =?utf-8?B?SXlEVkF3VlUwSFd3RzdSK3JITkp1T0RnS01MTHRtalBWeUxzT2pIUlhoL2hz?=
 =?utf-8?B?aEd6ZWRiVFBvK0ltekZ3UXVZT1RUTHk0QlQ3VWpkS3RubUxMekg0RzR5SitB?=
 =?utf-8?B?TWJrQmZFTTRlVjQ4L2gzNDZuSDhNbjkvTldsMVR4anJOUHBTdE5qaFhqWFVW?=
 =?utf-8?B?RmtwREJsaGx3MTBLUjhWc3hoeGVMYnFVTjBWeDYzdkJoTWU5U1VHTHZNbGVY?=
 =?utf-8?B?Q0ROUStXVzJ4aUhxRzF0b0ZJbnVZNXdDZjBNTG1LMnU3N0dkT2RFc3BBWnJY?=
 =?utf-8?B?OUNFdzAwMjJnQXpDenhQRDVWZHdZZ2pzZlluRG5RV3hZUk1WaUtSYTdvaFZj?=
 =?utf-8?B?NXdBSkErOEVsMXozWU4wNlpwU3FINks4TUFiQjE5SWZxQUtseVg4Rndha0pN?=
 =?utf-8?B?VENjbW5yZERyRUpUTHo2MGJOcEtaV1hTcFVRNVhHQWREUXlQTWVoc3hzdWln?=
 =?utf-8?B?RlFMSmkzaHlvdHlEMktQTzFQRXpTblpWWC9FT1N3eEliMm4xSDBlNGNkNG1m?=
 =?utf-8?B?U0VqSVRLYVNtcFZPQit3SnQ5ZVFZMENKeHJJYjlIMFJmVW5jWWNUcFU3VSsv?=
 =?utf-8?B?ZkZ2cU9GKy9rQVB2Z0tQQ3M2MWJ1NVE5RVlkQlZCTmE2ZWRqZlYxZ3hFWGVV?=
 =?utf-8?B?Q3FMM1hTeWE0ZDVoOXdoL0RKZzlrNDE5dHBuMVg0dldReEtBSTZHV00rWm1T?=
 =?utf-8?B?OUllcUwzeVhJQTJUVzEwcXA0T1R6SmdPblVYbTZLWTh6REFYNTlpczVOcGJE?=
 =?utf-8?B?cVltVGlOZWVtd1R4NGtUU1pUbnJSc3plWFoyY1VmZTJvN1FLRDlqRGtsVDZV?=
 =?utf-8?B?aFhmQjUrTnU1TU92R2RWdGU5Tk9vSjlINGlzeHFXTFhUNWxLRm1seHIrZzVV?=
 =?utf-8?B?am55U09EWkVzS3ltdkYxL3l6TXBxVGJnVk52ZnQ3SXk0TElaYTdUbG5Oc3A2?=
 =?utf-8?B?eTZxZlZERmdTajhxUHp2RXNVWHMvTU0zMERWMVVNRnM2RjB1TWlJTndsbzZM?=
 =?utf-8?B?eDVtclh6N2FhVmxITnNhMW1YNWExOFpNei9KeTVnVTBPOWlJaWZPWWhGVFA5?=
 =?utf-8?B?cWZ3YjBaNG5jbDMyRWJsUUczbFRBNDZvS244aExtaEVaWVBXQVJHekgyc2xt?=
 =?utf-8?B?cjFRYXcyTm44SXZVbWJzbWl6REFNTlc0N2FrcTgzSTlGcWlHM2wraFZlQnBi?=
 =?utf-8?B?ZnVLS2VjdzVpZVplVWFaQ2VxYVRUWGErK2FnYmpoVlY5TllGTnBGTjFXc01Q?=
 =?utf-8?B?MjViZGZsL1BLRWFCSG5GM0thVHUvMi9Hc00wSG1XWmxwK0ViS1pkT3BEcStM?=
 =?utf-8?Q?eH1uOHNi/Ff836UxzZfEv8N4yERxdR7W+9Tu0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUh2N205dkU1MFNqL09ZQVpMbURnMjdYSk5kV1JOR1JGMk43ZGo0Z0Fnb3JM?=
 =?utf-8?B?SjNvRjFWSEpCc3VCNjhtekFrcDVGaHRFSG96Q0s2bHlEWG5JaVpFdERqRE1x?=
 =?utf-8?B?anZNU05TbnV3SGJKTmhhbEFUK3VvZkhxdWhPLzdMcEFmSDRJRkxNeXJMa0dL?=
 =?utf-8?B?TGNyUnVib1ovdDlHOXNvM2pRWEZybmUrWktmRG8rOHd2UlUrek5CRnkrckNy?=
 =?utf-8?B?Z0J4cUdUbDgxdGsydWprZmwvclBsVTNWaUJEVTljUnBOUlkrQ0JDRDFvamVI?=
 =?utf-8?B?ZTFTV05JbHJObUliRnBVK1NRTGNQbk1WazZMM0puajVYMStrM29jUnZPbDJQ?=
 =?utf-8?B?Zk5rRmNkNTVmVkJnYXE3aHdZRm1TQTZXZ0szNG1LT0RiSEVVRG8wdnBvdWtX?=
 =?utf-8?B?QWE5WExiWEFyb01HRURQL3MwcUdIYjVLUlNnYmNpRTA1YTlwdE5tZnh4Y0pJ?=
 =?utf-8?B?ci95YXp3bmNiZG9ZVmV3VUtNSlBlTXdCV0tlazVaWFFZV295V3hSYmtnSmhw?=
 =?utf-8?B?OXlRV0huNUlBRHZZOFkyanBKV283d2g4NnlnMVBGcjJGMlNsTTBlNkd5YTNp?=
 =?utf-8?B?YUNQUEhxTVJaUW1jUENXV0hKRXJwSmZPZ2tWaTV3aTVUVWd3dFlvWG9zYnBt?=
 =?utf-8?B?N2tQZU5yOEVFUXA0ZlUxOVpBWFpvYm5FZnJZaFpwbTNYcUtPalZLMVp3QzJ4?=
 =?utf-8?B?VVNnUFdkN2ViSzR6SmZFY0JqNWVEN3d2T0tCOWwyL3VEcmlUdlB6c29KYWgr?=
 =?utf-8?B?cDg4RlZvRWcvZGl1OEFDdlZMdnV0bVAyTEV1UDlaTnlINERRWG1hRlAyU3NI?=
 =?utf-8?B?WDV4N1gxbVdTNzIyVTgrb21EbzdjRUVUWEtZUldlTmN4dGY1RGRnZWV4QWp6?=
 =?utf-8?B?YnJXcEZEcHYzYzZnUU5COFVlR2R0SFhQOEhsVGlEbVIyanczeU1tSUU0SllW?=
 =?utf-8?B?czlPa2xIcHVSZUdPeGVndlk4WUUwaHB0VDFFVnJXZENYZy82QWlMejVXMUxD?=
 =?utf-8?B?aitHQlFnSU5YZ2U2TUNYTUJKNkREMEdWOTN1RVp2VmpHRDhHQjRGa2lKS1Nj?=
 =?utf-8?B?U3k3TGMzUFpTOWR4MzdoMGpxSzRpK0hJSEpRcmZTWm9STVZCYldXSTAyVVBz?=
 =?utf-8?B?aEFGcEF2azRySlk1MEwxY2ZzMDJacDVWSlZoZXBQalowTE54eXgrZjkwei9x?=
 =?utf-8?B?WkxGTUFacmhoUjArK1NVMGdqbWJRQk9yTDJrTzhRTUtZQUtVUE9FOWR1MDNz?=
 =?utf-8?B?d09XTTJvWTdpV0ZQOHFjMnRJRGdLMnBaaFNNcEthY1llU2d4RWEyZjJXT3Rw?=
 =?utf-8?B?NFovTkZHa3dSWGhUNmJnUXJuV2ZybHA2b2IwZmtoWWhBTzdDUTBuZ3BtdXNL?=
 =?utf-8?B?UkhLTjlqWExpS0JOa0NyenpQSU5WMHN3QWhGNjBWcUczVlQ1WFRnMTM0d3dC?=
 =?utf-8?B?QWNMUjJiWDFsYkZzcGs2MEhCMTZjb1luRG5qN0pxK1N0L0Q0VFE0bTVMNnpX?=
 =?utf-8?B?VW04VFVRQ0N6ZWhOWUV6RjYrRjBRRVZPRUc0UWlwanZyYXhNVjdrNDFYMUU5?=
 =?utf-8?B?cm1xSHBDVlkrQlIzcS9WamFxT1FsV096R09wVUsxdU00aldSUlRJbzc1NUJ4?=
 =?utf-8?B?OEVDK2o0L3BBcXVoRlI5S1pHemViYXBEVjNEUnhWZlJtb09rdDlsa3NKaW9s?=
 =?utf-8?B?QjRNMW1pWnlBVnBtaVRzdDgvamwrZXVFWWYyNW5mMG1uMmo4ejRZbGVtMytp?=
 =?utf-8?B?Wjg4Rmk1K3UrQ3B0K281Z0tnK29EZE9ieGRyWlJYMjdUWjJ0UUVUV2pwQTVQ?=
 =?utf-8?B?VWlGK2k4WHBOUEhXQVRJc1Q4d0s5eHIxaWdMNVorVVZybEJxQzhhc2lQbFQ4?=
 =?utf-8?B?bGlKMWJPMCtvdEJ2UlVXdnZyNWQrNDJ5ejJGc0ttYXViTm9hOWorblEySElO?=
 =?utf-8?B?TElJalRPTXJ1QXhGK01EbU9oSUJJejN0QXlWT1U3WTQ0MEdVNHRsZ0plUG9X?=
 =?utf-8?B?NFh1Y1FTS3NHNGdBcnZBQVUvMkxFSjBFa25vSHlhZmV2WDRGVk5UdG0xQUxW?=
 =?utf-8?B?WS83VjlBWXVRWnR4c0FCMnduMFRuRnU4WVVGaDgyb1M3MXBraDdGOUhUcWtt?=
 =?utf-8?Q?A0oBT/c+GpJaD5tT+nJPfh403?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <192005030956B8418354642F007D1A05@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88086b55-be9e-4857-b53b-08dd07e15c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 14:57:45.1930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzXRUSbA5cjMPll1xmCzs6WNqdJVsN8L/bGas/fFb+ptN2Fqq0/3NBEccBgO8m1fsDICk+rI+DHSUzuGu4ma1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10093

QW0gMTMuMDUuMjQgdW0gMTc6MzIgc2NocmllYiBKYWt1YiBLaWNpbnNraToNCj4gT24gVHVlLCA3
IE1heSAyMDI0IDEyOjAzOjMxICswMDAwIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4+IFRoZSBpZGVh
IGFuZCBpbXBsZW1lbnRhdGlvbiBpcyByZWFzb25hYmxlIGJ1dCB0aGlzIGNvdWxkIGFmZmVjdCBv
dGhlciBkcml2ZXJzIHRoYW4gbXY4OGU2eHh4LCB3aHkgbm90IG1vdmUgdGhhdCBsb2dpYyB0byBt
ZGlvYnVzX3JlZ2lzdGVyKCkgYW5kIHRyYWNraW5nIHRoZSB0cnVuY2F0aW9uIGluZGV4IGdsb2Jh
bGx5IHdpdGhpbiB0aGUgTURJTyBidXMgbGF5ZXI/ICANCj4+IENvbmNlcHR1YWxseSBJIGFncmVl
LCBpdCB3b3VsZCBiZSBuaWNlIHRvIGhhdmUgYSBjZW50cmFsaXplZA0KPj4gc29sdXRpb24gdG8g
dGhpcyBwcm9ibGVtLCBpdCBwcm9iYWJseSBjYW4gb2NjdXIgaW4gbXVsdGlwbGUgcGxhY2VzLg0K
Pj4NCj4+IE15IHJlYXNvbmluZyBpcyB0aGF0IHNvbHZpbmcgdGhlIHByb2JsZW0gd2l0aGluIGEg
c2luZ2xlIGRyaXZlcg0KPj4gaXMgYSBtdWNoIHNtYWxsZXIgdGFzaywgZXNwZWNpYWxseSBmb3Ig
c3BvcmFkaWMgY29udHJpYnV0b3JzDQo+PiB3aG8gbGFjayBhIGRlZXAgdW5kZXJzdGFuZGluZyBm
b3IgaG93IGFsbCBsYXllcnMgaW50ZXJhY3QuDQo+Pg0KPj4gUGVyaGFwcyBhZ3JlZWluZyBvbiBh
IGdvb2Qgc29sdXRpb24gd2l0aGluIHRoaXMgZHJpdmVyDQo+PiBjYW4gaW5mb3JtIGEgbW9yZSBn
ZW5lcmFsIHNvbHV0aW9uIHRvIGJlIGFkZGVkIGxhdGVyLg0KPiBJIGFncmVlIHdpdGggRmxvcmlh
biwgRldJVy4gVGhlIGNob2ljZSBvZiBob3cgdG8gdHJ1bmNhdGUgaXMgYSBiaXQNCj4gYXJiaXRy
YXJ5LCBpZiBjb3JlIGRvZXMgaXQgYXQgbGVhc3QgaXQgd2lsbCBiZSBjb25zaXN0ZW50Lg0KDQpW
ZXJ5IHRydWUuDQoNCkhvd2V2ZXIgdGhlIG5hbWVzIHRoZW1zZWx2ZXMgYXJlIHNvIGZhciBnZW5l
cmF0ZWQgYnkgZWFjaCBkcml2ZXIsDQppZiBtZGlvYnVzX3JlZ2lzdGVyIHNob3VsZCBkZWZpbmUg
dHJ1bmNhdGlvbiBiZWhhdmlvdXIsDQp0aGVuIHRoZSBuYW1lIGZvcm1hdCBtdXN0IGJlIHBhc3Nl
ZCBhcyBhbiBhcmd1bWVudCwgdG9vLg0KDQpIb3cgYWJvdXQgYWRkaW5nIG5ldyBwcm9wZXJ0aWVz
IHRvIG1paV9idXM/DQpCdXQgdGhlbiBob3cgdG8gcGFzcyB0aGUgdmFyaWFibGUgYXJndW1lbnRz
IC4uLi4NCg0KSXMgaXQgYWNjZXB0YWJsZSB0byBoYXZlIHZhcmlhZGljIGZ1bmN0aW9uPzoNCg0K
aW50IF9fbWRpb2J1c19yZWdpc3RlcihzdHJ1Y3QgbWlpX2J1cyAqYnVzLCBzdHJ1Y3QgbW9kdWxl
ICpvd25lciwgY29uc3QgY2hhciAqbmFtZV9mb3JtYXQsIC4uLik7DQoNCkFsdGVybmF0aXZlbHkg
dGhlIGNvcmUgY291bGQgaGF2ZSBhIGhlbHBlciBmdW5jdGlvbjoNCm1kaW9idXNfYWxsb2NhdGVf
bmFtZSgpDQpCdXQgaWYgaXQgaXMgc3RhdGVmdWwgdGhhdCB3aWxsIGxlYWQgdG8gaXNzdWVzIHdo
ZW4gcHJvYmUgZmFpbHMgYWZ0ZXJ3YXJkcy4NCg0KQW55IGlkZWFzIG9yIG9waW5pb25zPw0K

