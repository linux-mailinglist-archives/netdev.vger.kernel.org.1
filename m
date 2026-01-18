Return-Path: <netdev+bounces-250887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EEDD39717
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E45A304AE65
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 14:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A236333740;
	Sun, 18 Jan 2026 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bUAzsw20";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bUAzsw20"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023086.outbound.protection.outlook.com [52.101.72.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D73321DE;
	Sun, 18 Jan 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.86
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768745294; cv=fail; b=RXsntKgI61BY+lHopl0Np4DUNjdagCwOH+nkFB7I90b4+r/IdQSLFfNIc1zPyvYTK7AkExqWa8upQGH3w8TRvGkM34Pqkv0BrZ5ip7KD+9N55qS8WgJjfFUfIJ6cBUgW9IiyKFdmD4Sk8rHSZwKBJpYBXaeF01+YwkFqfdCX9A4=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768745294; c=relaxed/simple;
	bh=uFPGlAPcLgTZK7r3KlTnqYz5hFV1DE908JN9pSiqB50=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=RhY9i6CayhvLuT0Oxc58/elipvSNVT2XuGwk6YHYCfk+aT4dmuiEr0BzhOgXArCC7J1G5PR090ytu2ak4C5GiMjBSj3euvzHKylm2vUDZInDwplajv1q1MwF1OG38qpzfk3/9n46yrXp3qCLFnI8BOA6yh3Qhz5Iurm8TheWyOM=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bUAzsw20; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bUAzsw20; arc=fail smtp.client-ip=52.101.72.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qbqy3Yl/zk17p6vs6xMooUtgssx4rID0bDFQWKyRnL7bQfAWynjdpnMM+Hle6oydUMXhK40WOMGx5oM5n2SgFFaKjEWgI3cyM9tEF/QCLqWDqldbMagNEUApJTB5tSEnHNwHtunwYodIgzUWUHLmkt+5XNN0/g+c0wk8RaTclo3v5vm69lIdiiITSXPYv02QwP3vbTmOLc7Lf9sf9zM0W22kIpvC5dTfqBVYVgXT4p4Sets0OAnwBwp2dsnQQiOblRewJVVe9PdUkQX1L5tYAdhaa7eL8tHRWuLArdrs1ws4n4jznTPm2ngoOp2FF5SZpYU69wgcvU5ujk24R52KdQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NrCS7fK3ZVJTRdYTK+hdscweyLZOhnjVELNQaHdmXo=;
 b=yUeUicapR06qdLF8R1c4rWjluM0wSgql5uep3Rpm6ftXfV/abObSFmLDXIkGsFSfiEiwylFrC93MTomqKYMvMfTgmVVrTRlPWoGPVeqg4Q8AL6eAmVdX/lWDKVwRq4ewXf+G97zys/I5ecLCYlMiBiwjBVty+TvgwJeeAlpGkBs42WFTqfnS6y3BTUN0/BabKVnslbLEG1LZJckCe+DnGHeO1THCB9nbHt4BlbfPYdrjpmOVwyiBC+tVeIJNj2S6Em3hNRkVZC9wcpNeQdHvfv0pJiN2ryygovSFc/Dr7VaaDvxTed/nNQOLgizwdcbbHRYEvrjOUXTGIJyMEg4UDg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NrCS7fK3ZVJTRdYTK+hdscweyLZOhnjVELNQaHdmXo=;
 b=bUAzsw20DDbff5qGzDqq1F5Qd7/et8igsWvsXdXPo7jKK/gW/VE1Gz7dk2ftNJqC/xVKbaJoFzV4OyLxIRihT68MCmnGlh+AftK1An9md4CaZuZD55qR6X7vtcCoxXxdNsB/U/wqtXXMYqqeMXNHxwawkxJ75iwLX1ZPi6+bArc=
Received: from DU7P190CA0012.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::11)
 by DBBPR04MB7932.eurprd04.prod.outlook.com (2603:10a6:10:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 14:08:09 +0000
Received: from DB1PEPF000509EA.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::3e) by DU7P190CA0012.outlook.office365.com
 (2603:10a6:10:550::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Sun,
 18 Jan 2026 14:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509EA.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Sun, 18 Jan 2026 14:08:09 +0000
Received: from emails-9091723-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-103.eu-west-1.compute.internal [10.20.5.103])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 5F2837FF28;
	Sun, 18 Jan 2026 14:08:09 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768745289; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=/NrCS7fK3ZVJTRdYTK+hdscweyLZOhnjVELNQaHdmXo=;
 b=cBX2ShQwGqNTMBzu5S1/Y/eSWy98aYeEWPf3Ar2nCNLiOMxmrys0gXohc76uQj4/6v3rb
 165lmwb3/7jqltT8UGLovPkMLi/zoP3//yMcXO9YIfvMKlMRmJs2eYuKhLCWXluqj+KJRUk
 QvnqcIwXq3MlnO+2zIbmCxV6XaQfzek=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768745289;
 b=IVLJMmysJG1VPRA2k4wk4gAwkM/OrvD2++q6NoFfGP4mKFE8DxH9g7d6A9ldLrcFfFGFP
 wK3EUGiy5jr4UaEqWGXLfQuQ6NBhzeDh59M6AC6KLZ+gZbdcv7whJ/9tnk+AxG/NyM1sSm3
 2Y9R8tzKZYV2jTSq3JwylmkEw7YqEDA=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIHushtQtIUwUyyE1ZLbaCOIdh3Vj6ddCLKQ4Pz7u0EgFrhWlVjFWksSjFt9ZnUH6b7grVLecGa21nZU+FYhFoi7ORS94772QPLvg0s4OnEisiWyNraakl3YdL0FcxEB8a+sPVQv8Vnsmpfp5J/PI/fBIYy32VMIk+3Id7DW3TmulgFGH9cCP05+N6wnieW7IE6kFJye03Fk3+PzhAdd4pv6YaSDDGu+LsqK/zDewrdXeH0rrQ97DZCcO21+95mFNsbBvmuAyuNLfvV8v87q06vgsfwgTGej4dvtPBnuV8SoAwMm817Cf5+dOeULfUbvzExe7HqhwS3GX/B3HkwyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NrCS7fK3ZVJTRdYTK+hdscweyLZOhnjVELNQaHdmXo=;
 b=yQHnuyh0OXk5t8aWihdEI5lkPVTReXvqW1n39JXyQlZKECBmZV7JNwWWtcKMCHNwrFKXbq4lvL8mLh2aNDtx+bO/YkMcBuiq9GvMv2uWK3Ti7z7bAo7cTH4atpu+I9MxKJEkpgDVYcbDuANZUTiTSO+QXfw8qdgU3gEsnqCZ/EiveDVTp+jc05Wx7Nvj7rDlMKY2xOClF8QnYDLOLUzm2DJi+Z+SUMKWKbaPDp1NbX/ztBoCXJsxb8aCfWV3aTAORKvQJHzJ22hUuVklPO4FBOcs5uKSdECtrhBuAczFLZexdHMwgGhhzeW8BgNBkI3j2rb8OF8rSWXJlCGC+SK4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NrCS7fK3ZVJTRdYTK+hdscweyLZOhnjVELNQaHdmXo=;
 b=bUAzsw20DDbff5qGzDqq1F5Qd7/et8igsWvsXdXPo7jKK/gW/VE1Gz7dk2ftNJqC/xVKbaJoFzV4OyLxIRihT68MCmnGlh+AftK1An9md4CaZuZD55qR6X7vtcCoxXxdNsB/U/wqtXXMYqqeMXNHxwawkxJ75iwLX1ZPi6+bArc=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI2PR04MB10977.eurprd04.prod.outlook.com (2603:10a6:800:271::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 14:07:57 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9520.005; Sun, 18 Jan 2026
 14:07:51 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH 0/2] net: sfp: support 25G long-range modules (extended
 compliance code 0x3)
Date: Sun, 18 Jan 2026 16:07:36 +0200
Message-Id: <20260118-sfp-25g-lr-v1-0-2daf48ffae7f@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACjpbGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0ML3eK0Al0j03TdnCLdJIMki+Tk5KQkQ8tEJaCGgqLUtMwKsGHRsbW
 1AHK4R1VcAAAA
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Rabeeh Khoury <rabeeh@solid-run.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|VI2PR04MB10977:EE_|DB1PEPF000509EA:EE_|DBBPR04MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 893377c8-ec7c-4e33-bb04-08de569b027c
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QTkrcklnSzhFMDFUUW9aKzRYKzFNZUgxazd4eTlyTUNuRStKZmhmOFNRU1JK?=
 =?utf-8?B?Y2VOUHYyOVdhV2tsRXBOZU8wd2FjY1Q0MzFGSHFpN3lVTkJQdzdWVmNMVldC?=
 =?utf-8?B?WndOaG81QitYQlhiWFY2dFRVUkxSS2cxUjlsaWdpUVdFSG5NUmhxaE5XQnRC?=
 =?utf-8?B?YnRXTVZWVnN1S1lTRVlPd3VXNlpaODhLaHFENi80T2h5M1pMc1d2bXlRZCtW?=
 =?utf-8?B?RWZ3ZU9hK01wTHBYOUhkeWRheTBzWlBaVU1IL2RnVWNoNjB2TXNKMEhOZ1Jv?=
 =?utf-8?B?SEVJWFdMWitLcGsvbVdVMlFWc2Zqd3poQzhrOGF2Tmp5RXNjTlFub1JEazRv?=
 =?utf-8?B?L0ZMeGswZ3AreStvejdScWViYnNQa0ZBNFN6aGRmMWl6ME54Ym9vT29FT0RF?=
 =?utf-8?B?eXRyNVk2YkNsZlpyOWpDRUZLaWFuUTg3TC8vZ082MXkyUDdFSjZ3WWJOOE5R?=
 =?utf-8?B?WXlRODVPbzBESUhYMWg1SHhYS3dGRGF0dUdFYXoxQjlkTnpTeUpRM1l2cllO?=
 =?utf-8?B?WTMwVDRHOEs5T2kxdTlnRUxneGlRSG4xanRzTm9RaTZXaWtGV3djTFJ4dWE3?=
 =?utf-8?B?OXpiRENWcFJqZ0FkYWZHYWdjZGcyaWpEeGRFK1h2YzNvZW1rYmhKbmJMQ3Bh?=
 =?utf-8?B?OWFLdTgzUEY3ZEhrbWU2dHQvK2xjaDJpb0pWcDRobFYzOEV6eEd6S0JLMGFR?=
 =?utf-8?B?d3FycHpreG5NZmZ6Y2lMd2tEa1Z0Z0dFeURDOVJKdlJhMDMzRFFma3V6dlNR?=
 =?utf-8?B?eERBcDBsMFRod25NSjg0aTdBYSs1OUxSTGswY0ltQy9yZmhsWUcrdURXTHI2?=
 =?utf-8?B?aDVnWXRuVENpRkNiYVBrZ3lONXFrS3d6RDZ4Y3J2Z29OVERrc2NFeVJtV2xu?=
 =?utf-8?B?OU1MQUtLNXlsQlBNcU5IZFByV2ZJRnk1cVM3U1dlY2dyUkMrRmh5Zm4wNy9M?=
 =?utf-8?B?U0l0WGU2dUhQZUdzelNUaTJSSHJKQVNXbnBieUVCbndxSUNZZlQ3d1Qyd3VU?=
 =?utf-8?B?NXdzdk9SWS83VlVDQjBXS3J0ZFJGOThHclEvcWV5bjZWbHRxVDlidUpZdkRZ?=
 =?utf-8?B?ZzB2UkZ4amlELzR2d2VVVFowRnBtdm1YYlZra1AzbUdoZGlUT0hmZ0p3b3lZ?=
 =?utf-8?B?NWs1SFRUZDIxV1prRHI3RGFwTDJUbzhCRy9JSkhNNnVvNVpzTEVMN3ZGb2NC?=
 =?utf-8?B?cG5ZWUxmUFplcTNDWHJRMEppM2xweG1kRDg5dnAwRi9INytOa1hFL0RRb2xW?=
 =?utf-8?B?dlgzd0tnb1p0ZmQzK0t1SmVYMUkxYUpjVnZJOTNPV01FL2JySjJkcDhmN0s1?=
 =?utf-8?B?VG41a0hWZzVqUy8xRnB6Q21FREdXSlRaRTFnYVNZKzdKcEdFcHVTYkpkdHVy?=
 =?utf-8?B?M2Z3SGlsSTVGaU45OTBBQ01VSHpvc2dwV1FzWExXM2t1amdXREs4NVV0OFg0?=
 =?utf-8?B?ZURGUEdNc2w2V3l5cDVtUElvSFZ1cmlNaE84SkpIQnBmamhETGFSNVhWOFRZ?=
 =?utf-8?B?eGRYNjFHSFYxWU5YNzI0Z2NGczZpbkFEQkUrcS9DVDFvZUVTL3NtNlJaUzBF?=
 =?utf-8?B?UlNDMUZ6L2pxb1k5QzkwUWZhL3dvbkNuZVd1ck0weFVYL3Y0VHNIY25aSml1?=
 =?utf-8?B?Nm5RcURsbHVIeituNkRldXRRbEJsTVdwcm1TS21GMlZ0bXBLeU4vWis5YTFG?=
 =?utf-8?B?RFdoWU5ybEM4N1pEazVma3pXT2YvVFBDTDVSVDdJQS9pT3JKUEFQMjk1STgw?=
 =?utf-8?B?Si9LZWZ1dlVHa1VIZThaMFdKTFdhOUJtd1dPOTQxbXBCOTQ4WHNPOE5rbGhR?=
 =?utf-8?B?bEtOSmtuZXEyb2k5dW1yU0JzQlFxdXRyb0dvVEszSHdCUHFoSmlyWjRwSkhJ?=
 =?utf-8?B?M2kwUUhtNzJBMUJ3N2cyc3pxdmd1NHYrMVhGZGR5dmh4TGloWHdBaHU2QmxW?=
 =?utf-8?B?SldEVlVCSWMwQ1RmbE9MbjJFUFF2N25KZnNibU1QcHY0MDUxczl5NFJsbnEx?=
 =?utf-8?B?dExETnBDbXBLVHVYQnBzSXF0ODB2dllhajlUM29EQ2lOOE5JSXZLdG1OQi9l?=
 =?utf-8?B?dDhuZG1KWTJobWk3VVVaVGl0TmpCeTZXTGV3VUZKKy9yRklXUnlMYjdCVFZC?=
 =?utf-8?B?UGQycHJHak9mM1EyY05XMTZzNC9ZeGlUUGl3NnlKOE0ydXBiWTd1Ui9McmlP?=
 =?utf-8?Q?NwF+fjv4FtzpOI6bcTMpe/0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10977
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: f3ea284282c24b9bb0ecc10645b0a46f:solidrun,office365_emails,sent,inline:49edc22648e717370c50bbc2ad127be7
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d1313523-eddc-4e76-9b2e-08de569af79c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|7416014|376014|82310400026|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmY0VTBYYjFEaTBZVzRBcmdqU04wcUtnei9xRjIyVXA4YlFMRkxoejFuc2RX?=
 =?utf-8?B?dngxUHJkcGE1RFVWQUFPcXdNdUdNdjBnWS9paHRNTWdMUzUrMTVJM0gzODln?=
 =?utf-8?B?bUR2ajhqZlJTK1FTVGVOanBhUFJySDhuSVQ1M3NPUzI3QmNvYWd2Z255NHJs?=
 =?utf-8?B?eHcyNXM2VzRLdFZTTzkvQWRTMlNuY3VNRlpsdEJERlg1ZlVCQXlscm1qZ0FZ?=
 =?utf-8?B?UmhTUEdOWllmcTBOVlB0VFRvWkY2NjFhTjBEMVlpOW0xRk1oWkxOdEJiUmd2?=
 =?utf-8?B?V1JjRHE0Q2dubVZEVFBHbWJDVE9VWExjekhPZ2oyVEFyM3BFYXNBeHgwTFdM?=
 =?utf-8?B?V2xDWXhPK2NKVEdteERsTmhkeWpFdjcxNGk0dC9hZDN3SnRoRHNZUDdVNFVq?=
 =?utf-8?B?RERLYTdEZGZnTi8yR2ptTllpem5RVmUyb0lweDM3UDRQSkNqYzRaQVY0bHFH?=
 =?utf-8?B?YklmSTZsNVVZRjl6UjlOQUFoV1BSbENFSmJGR2MxOVBSaEhtWWhpQXpBaGI5?=
 =?utf-8?B?c2x6YTBCSVBrUUxETlo2UzZaaFF2UHppSmZBdzJuZ2x5Yzd2a2ViZ3Fzd2pq?=
 =?utf-8?B?QUd6b2l6VlhEQ0EreHVEWHQ5SmVWSjhzSlZxR01UVFE5enZrem45QUxBSlRv?=
 =?utf-8?B?VENBVUVpUUhYMTdoNGs1SkdhTEU3SDZZUGR1NTlvem0yckdxVndCUlNOeFFp?=
 =?utf-8?B?ejlmd3RNYWhpUG04TW1VMlVERDlPcnBXUXg0OGU4VzRaZW95eGhNaVdVbnNR?=
 =?utf-8?B?VTNmZ1FZb1E3dnBvWmM5b3ZRaVJrSU9rbHhQbWQ5Y242bk13MFhISU5DcHB5?=
 =?utf-8?B?czY3U2hsemRHa3JWdVhubWU3RnhrZzNWVGtJMWVuZ2RDTklvNVFVV3EzNTFk?=
 =?utf-8?B?bDVzREQyK05LdnlESE9HWi8rQUltYWdZSzg4SEJONTdWajBjN2VuRW5CUVFO?=
 =?utf-8?B?WEVGMFV0aU5uTGNWQjZ1YmN4VUlwVkZZOGNhU1UvZSt4QVBzV3BTRTU2blpB?=
 =?utf-8?B?QXgwckRhcWhwNWgyWitldWh1SW1SRnVST3BnOTdnVTlBZ3lDZ3pDSVNxbVRL?=
 =?utf-8?B?S3VKcjk0d2hqRnE1RncvS1Y5ang2aE5oN055d0JoTFkzcGlZSWhsODNLTnRh?=
 =?utf-8?B?ank2RndCbFZwQ2ZLVE5aN3JuL1EwQlA2M21GVTZ1OWJqREVrRnNPQW9oWHhE?=
 =?utf-8?B?SmkyUXhXWGFDV0ZWZ3kxdm1mOXFHUVlJTHBVeGNyeENWa2Q5YlEzbmpoNzlw?=
 =?utf-8?B?S1dhdDhyamliVnlBS204bDhrNkhFalNvRFRKZzNOTW5wTzlybDE0MlVBQmFv?=
 =?utf-8?B?VlBqMWN3aVBNKzdWRDZ3UHc2ZG1tRDI0ZW1walFrWEcxdS9uNVF2OXo4bzBv?=
 =?utf-8?B?ZjJNTVhCOUsxZm81WXJvOEtWaEc0VFhQMlVXa1ExRUJRamhYZkNQd2tvZ1pL?=
 =?utf-8?B?R2ovU1VRYjl3Qzl0TEdBMncvUHErTHVNNncxaWlQVitNN0xxZ1JodFYvaUIv?=
 =?utf-8?B?eXFuWDRJU2E0bE9IcEZEVjVwMitmczR0N0NVVGthWHgyYnVGbTZLakk0TWtX?=
 =?utf-8?B?TGlYYUs1WHZFYTZTOWVTN2Y5MWc1bGNqRFdvejQ3cXllRWhIeHptdW0weXRS?=
 =?utf-8?B?TDNIWVI0cGtPTnVtVHgvc1VKRW5rdFY3aHRjNEt2NXRFbXJLMGlSMkZDOUMy?=
 =?utf-8?B?R3Zsc3ZzWExJN0JheXdnTWhERTZVUytvNGovU3JCMFpuRlBtZ29mQVFaZ2Za?=
 =?utf-8?B?WU54Z1hmem9FRXdjdm1SVVhFM3lkeU1tVXFkeTJ4Y3BqL3hDL21WQm8xNFBh?=
 =?utf-8?B?Y1dwaDFQRzd3SkFrSEplZGk0ZjBDdG9VUzZmbXNwVm5IVTlpQUViT1ZydlZS?=
 =?utf-8?B?aFdvSUlhek1NUndUb2lqd2VobURUWHdUWER1Z1BOMU1QK09NSURIMWxkNVEw?=
 =?utf-8?B?bEUxcENmTnBVWXJ4U2xJaC9QREsyb0huWEFvRXEwS1IzNmxpWXZQUDhpREFR?=
 =?utf-8?B?eHJmK1ZPb2plMWYvcEs1djhvRlFOMC9KNktQUS93eVljTVY2eHpPd3N2QlFv?=
 =?utf-8?B?dTBQZ3lmQ25yK2w2YVFYelpQWE9oZHBTbWZCSFUzaFZVQ29YYk5IQUl3MFRx?=
 =?utf-8?B?dE5nbXdtSGhLZmF1RkZhTE9YT05FQjZqdXdwc2tURFF3STBQTDNIS3lNb3JH?=
 =?utf-8?B?NWhLZDZHZ2J3TFpnTjJZbkRSYXFodW9SNEVVUCtaRkFvTFJJSk9XckFPakta?=
 =?utf-8?B?QmNZRnZIRk1GZ3htT0dkK24ydlFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(7416014)(376014)(82310400026)(1800799024)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 14:08:09.4418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 893377c8-ec7c-4e33-bb04-08de569b027c
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7932

Add ethtool link-mode bit for 25Gbps long-range fiber, and enable it
when parsing sfp module eeprom for extended compliance code 0x3.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Josua Mayer (2):
      net: ethtool: Add link mode for 25Gbps long-range fiber
      net: sfp: support 25G long-range modules (extended compliance code 0x3)

 drivers/net/phy/phy-core.c   | 2 +-
 drivers/net/phy/sfp-bus.c    | 4 +++-
 include/uapi/linux/ethtool.h | 1 +
 net/ethtool/common.c         | 2 ++
 4 files changed, 7 insertions(+), 2 deletions(-)
---
base-commit: b4e486e2c46f754a515571a8ca1238fa567396dd
change-id: 20260118-sfp-25g-lr-b0b8cccbb19a

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



