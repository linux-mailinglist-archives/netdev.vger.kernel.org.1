Return-Path: <netdev+bounces-191047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EF8AB9E3F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5087A9573
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 14:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF3E13B590;
	Fri, 16 May 2025 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="NSXkFm/1"
X-Original-To: netdev@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020134.outbound.protection.outlook.com [52.101.169.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB38145B3F;
	Fri, 16 May 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404575; cv=fail; b=QMsdUteqYT/tf4ECwuyqzifPIVLiSaprYCZuN3TQVnvstKrxtEzCn3sxVED7B44B37I87Zd0F/diN+7ENCToxlCWNSXN6CdfWj9V6tEeaauUKs+GulvYLfZAP4LHmsLMLf32S06cvZWQR0w0OlzaMdCp9KjC2c9X16TQ0yW0JcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404575; c=relaxed/simple;
	bh=7asNbf0qDnSUW1oP1bbBITjc+QThZ79+wmrx465dnIA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q4B8WPTxWHT2qt/CDGkdyjbKhWnDP193sIJOSC3KoOiiYBDs0P6gYrZkTTgVOf6Vv1jzD1oaqsNK6A8mlZqcXIkcBfCoW3/Ws4bY+dHhF9KCGptrJZTFpyH5w+blTcThsm3P/IYkYqx0Ek2V0nYSqHl3IFDqjvtZ5skIP9Ngkws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=NSXkFm/1; arc=fail smtp.client-ip=52.101.169.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvvXGGOict2x7BcJGaUn68gmjRrvsVUUnEvH4Wwpr3kr1QgHtj7OXxcnDo133b4qj9vlKjib54rX03ZEEEOKPs42wArVgf+F/YKENU4Fzl08doWWLMqHSTDHLGThdJZJk3e3635rgYNK4tDsWGerSLEABo0bxyY1ZObJj9C9LrI7H++QcWrfexerWY1mW7EWTz7qjTIQqxzgS6xCZLcg9t5D+saH79rVtc72eCH2/Xh062rrKzFrYuTeeCS40sMhg4bIl4Y9tsW/AAbtVlcU5OngdGCdrZyPiK9QgR4wTgWYLEr3ZznO0IVvfjEVIMzUcM3GOdezfhGwOKUVKXWczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7asNbf0qDnSUW1oP1bbBITjc+QThZ79+wmrx465dnIA=;
 b=hlrXzYXQN2XCJz1VYY+c2O1kXj/0iwb5vIB8NlA43ZpgKHo30N+akV+8oFJXBBCXFy3iPnQAwwSTQ7GJ+5NUK1W1wRnJpX6HSV92vG6Al32W1+cVZlu/nSCHzHVeZiFIzSyU9+F+fmSFPMrzXGyJTa2vFXiJiorhTkeO4qxQ8R1lBe93NKXTWNPddfULnVGPKBOtzZTlYRmhZ/naLOtVtaQLaVtr/E3uIGmoU+3ODpJa9NHTZWTzA1tHZoZkLaerUvsxmRWPs3yr6HaxNVVBLm2q3wJeeDr1ufKVFJ+UDtBdl5ylo+n8y1Sq9VTWQnmp/DcMsM7ogphVMl3C0xczKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7asNbf0qDnSUW1oP1bbBITjc+QThZ79+wmrx465dnIA=;
 b=NSXkFm/17YTrFXnjpfdDl6Zt+QQ3kXfi4Z2ySZ5o2VHW04SUIiwxAOkPejxzE9gTBrtHemZOrVj0kEg8G2c0CVOW653d65PQspFOncXtIaBG3XP912Bfb7e6U58xWxF+e8Lyu5WOWQGKu0QSCHTLEgdYHY0xLoXzRvdPiHhWlfI=
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:43::5) by
 FR3PPF99537C539.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::16c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 14:09:25 +0000
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192]) by FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192%5]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 14:09:25 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Oleksij Rempel
	<o.rempel@pengutronix.de>, Kory Maincent <kory.maincent@bootlin.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: pse-pd: Add bindings for
 Si3474 PSE controller
Thread-Topic: [PATCH net-next 1/2] dt-bindings: net: pse-pd: Add bindings for
 Si3474 PSE controller
Thread-Index: AQHbxmwhTcbMQZNDv0C/N02Kzc55pw==
Date: Fri, 16 May 2025 14:09:25 +0000
Message-ID: <0b7afab0-0283-4a52-82bc-0d492f752034@adtran.com>
References: <bf9e5c77-512d-4efb-ad1d-f14120c4e06b@adtran.com>
 <259ad93b-9cc2-4b5d-8323-b427417af747@adtran.com>
 <f8eb7131-5a5d-47ec-8f3b-d30cdb1364b5@kernel.org>
 <dccd0e78-81c6-422c-9f8e-11d3e5d55715@adtran.com>
 <b3db09da-72f0-465f-b177-ff14fd53608b@kernel.org>
In-Reply-To: <b3db09da-72f0-465f-b177-ff14fd53608b@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB2224:EE_|FR3PPF99537C539:EE_
x-ms-office365-filtering-correlation-id: 9f61d54f-be46-42c8-a0ee-08dd948343c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUxKWDQ0RFRkemtoM0ZzNnhwMExnaFdZZUJBeGQxRDZ1b2dBWWpWOWdzcWJN?=
 =?utf-8?B?bEJVZ3U2aXpRY0E3WVlVaElpczc3RlZyUnc1Qnd6eFZvN2MyMTBBUEdSK1VI?=
 =?utf-8?B?azdyQ09JTmxueWZ3VExlNU9JVk5iNDN5MjZ0d2NzUnUrczJhc0JqSnBxVmcy?=
 =?utf-8?B?Q3NDY20xRGV3UDdmWGVubjhqbmdyM2FHemdjdDkwN2p2OFp1WHZZazRXWE1M?=
 =?utf-8?B?OFA2cGVHclRaU0QrelJ4VU5sYXJiRHhHT0pwK3FTUm15Sk8yQnB5QWhKZDJv?=
 =?utf-8?B?SkJhUUc0ekpNOW1uSjROV29hMzJvanRqTnJRQk5LZ2NaKzBwM0V1SGdKMDI0?=
 =?utf-8?B?dk54YTcwdG1NaFFkVGtmRmhvYUNaR2hYVFptNlZtMUZxUlRlemRDVjBXM3c2?=
 =?utf-8?B?UmRKdlZyR2doc2s3eW9yYk5VeXNGVGppT0t5V1FoZ0pWa3J5WUdEaHB5NEhU?=
 =?utf-8?B?d1R4SVk5YTVLZWowVWw1ZDl6NjZoSXNmb2ZPRGpqQ2t3ODRZU1pFMHBMdE5D?=
 =?utf-8?B?TEdFZytBTUxvWEtTRjEzQklEMUFvWnBRUkFSdGV0NENWSjltaUVYcVk4eXo3?=
 =?utf-8?B?T3hEeWM3N1dGcE5xbGVoU2pkbkxrUlhsRWlpVG0zREZVMk1QR0wxZnJJY29h?=
 =?utf-8?B?UUppRXl0WUoyVVJ2L0VOdUswZDlqcU55UnAvQnZpcitpUDJSV2QybExMc2M0?=
 =?utf-8?B?bS9WU1pOd0VVSml3UlBPM2p3T3krUXYvK3dxSktnTm9SeW9iRFBnaHJpakxy?=
 =?utf-8?B?WkdkRW82Uk9MVTZHQVZ4Y2g0Z3RxeVFGVThNRi83UXllMFByeVZpekliZzBs?=
 =?utf-8?B?S1JuQVRmUTFkdmN3RjI0Rk8zQmk0dG9KaFlRKzdpN055OFJNZHJkU2RrMS9D?=
 =?utf-8?B?eWlDSExSMm0yNm1xQTVWRnhwMzB5ZW14a1ovUjlhUHRPbFVhb2laVUhjK1V3?=
 =?utf-8?B?ZGphWVRFNGxaRGxhY2JGZkdmYXBwM2FQRlZPWTZpelFkbUNCVDhSdGZTTmtE?=
 =?utf-8?B?WThuNk53YS9xSEVsZUFIcTV3ZjZDdUNVYmk3TE5Mc0hDck1FZkczYWdoVjU4?=
 =?utf-8?B?R3hNcE8vL0pGVlI1dVdzUnZKRTBHekZUdklWVThZNnNibWJRMUV0dkh6ayta?=
 =?utf-8?B?Z2I1bnpYZG5MK0F3d3M3Um1FZjhPbnFYSlpvNktTd0ZLbGorYThWZjl2alJ1?=
 =?utf-8?B?WGNlRXVhNzBWeXFkU041YnY5Qit4ZDhZMXc4Vmp1ZHFGZUJOVFJHQnJXRzVI?=
 =?utf-8?B?STdWTGV1eDNMbHJNZEVlQnlXSUp4elcrWTVxOE1RMVZ3R01scnErbnpjbXZl?=
 =?utf-8?B?NVVqY2RMZnJVK1ZWTnNQbFcwTmluOFNjN1RvUUQ5N2orMDJEZTA0UFF3aHNy?=
 =?utf-8?B?TEY0L2FQN2JSYzdEWk1Ub2U4ZlM2VTRjdmYzR0dTZ0RTK0kyUFVRaUl6OUlU?=
 =?utf-8?B?cUtjMm5qWlBNZTFJNmdxZFlnYXlUV0d1UlJaWmFPRWJiR3ZkMTNYYUl6cDBT?=
 =?utf-8?B?d0E2RUp0a2pyNnAwaUVQTzNEL2tuemVrVWNUKzJIWjJoNmdHL0IvRnJuVFJO?=
 =?utf-8?B?Wk82aHgrREVyZkhneFRKMWdZVk9XWmJSeEpXb2NlSnhTWENSeXpnb0owVG5y?=
 =?utf-8?B?NFBBTGZTTnl4TVI4ZDFlMGgyYmJuUklxSmV2Q25sYzVmQjFsdE9MOW9sWWNV?=
 =?utf-8?B?OENKeVdhMDNwa3dUVHBDNzFsb3FQS0lIYjZGZ25RNkdQRjc1SjU1Rjk5WkFo?=
 =?utf-8?B?RUlZKzU3ZEdicytoVGpWMHBwNFBGS0duZ21IeC9tTGxtcGw2cStIdHRBT05O?=
 =?utf-8?B?WHJoVTZabSs2MFVhaUE2VzF4T2xUODVnSDhjY28zTFEzWm00bnEyTU95em40?=
 =?utf-8?B?VWZMR3pNUSswa1JuVW5VR0l6c2ppRXdCM3NVVlJCNytLdk9SaTUxQVJ1cE8y?=
 =?utf-8?B?eTNFcVFGdjRKelB5eVJ3amZscEkxQytQY0tldmdJeWdxV1l0T2IrUmRnekJF?=
 =?utf-8?Q?P3AWhkpbR2KNA/2YIp1gm0yX5DcE7Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVN6U0tPUSsrOTJhVC9OODNoOXNsVTgvUkxNWE5OVytodlQxbWkwUXdMbVFp?=
 =?utf-8?B?Rmx0OE02Y3poMkhSRGNFdlBvWVZXWS9UcGRiZkZVZ3F1Z2NaekJ4Z0htT2I3?=
 =?utf-8?B?dmpOY2s5VEtQdEp0OUV3WU9aS2JESzd2MEpXdXdVaUswQVFremVoNFlWRWp3?=
 =?utf-8?B?V3YwdmoxVUtnWDdJeUxxcytBS2krK1pTdnhkbzVja2tVQlluM3dtKzd4enJr?=
 =?utf-8?B?SXhzRHptMGY2elo2dTlKSm5HK2VWZFVuSDhNa2VvT0Q2VkQ5aFdqK1NPYWpN?=
 =?utf-8?B?TUZabEJmbVdkUG1BU05hZWpob3VqVU1SNUtvYi9vMzZGaGthOGgxM05NRi84?=
 =?utf-8?B?bEh1THhrY2ZKMjlXMHVxV1Z6Sk1oTVdrZjJZRkVmTFVyK2Vualg4NTAxd29y?=
 =?utf-8?B?NGpkRm5YUHZZN3dTV3phaTA0K1dvdlR4Zi9qYklsRFBVNWtLazBESlhnYnB2?=
 =?utf-8?B?LzA5VUpkdFNtYjZRVmNVcFhPNFVhRkR6RkRoZjdoSm1EbncwUnl6WDR4Smh0?=
 =?utf-8?B?WEwrQkpVVmlYVFN1MUZlVTU2clliNFFtMDdzVU13Zlh3OXEzM2djTk91R3E4?=
 =?utf-8?B?WHJrQ0pIekYrc3diTkJZbGE2VXZMdFdSWjVQdStMdCtldWZiLzI0WHVSNEo3?=
 =?utf-8?B?Zkk2cTRaaE9qMDI3amJkZzdGa2dBb2p1WUNUc2RVczA3cHdaQ2J0Si9WK1JY?=
 =?utf-8?B?TVlMSXp3ZlMwS21vUy9SL2FQeW9iOWF0TmFldS9zRTh0TUdGcTVpaVU5RHVr?=
 =?utf-8?B?SGpOL0trTkNtVTBhdFpQMFNCMVg4QllMT0FKMlpDbVFMSEZFc1lja0ZLUk4v?=
 =?utf-8?B?cnVkTTBqRWV6NjA4RE0vakZQbXQybmxOM0ZVNlZsR0tyelVjeVd0ZFFWcG9q?=
 =?utf-8?B?WkZMSjN2a3V5UjN4cmNKdnppZE9EcnJPQWRwcllodkJkSE03aFJsNCtsL0FP?=
 =?utf-8?B?ZWFzTVRLcWtwd1FTYUt0d3hZTldjZnpGRjRtejRZV1c4L2FBOFkrUGczdFJH?=
 =?utf-8?B?SStqOVNxRTBWVzBBSHdxTThCUXJxWkdrWXNJaEppdXoxSDgrVlNlall3RUpt?=
 =?utf-8?B?bm85WVUyVWp6QXB1VkNkVG5rR2t4MHJZNWYvRmE3bnVCbXBvVHFibWxZS1Y0?=
 =?utf-8?B?cktNcWJod0Z4OHRUK2NOQXYyZVRadDF4aUtCa05wWVBxWWlDdW5rRjdvKzRK?=
 =?utf-8?B?RjdCQngyai9NRXZWL0UvUEtNS09EYWVqdFJCOHJKOXk5N2o1eStQbUFuR3Q0?=
 =?utf-8?B?NTJjMHlORWVaL2MyZis2cUg3QS9ub3JvSE8rUWs1QjJDREFLak53bTUyTnhB?=
 =?utf-8?B?Q0lIcXdJN3dWQjhlaThvY3VoTWlSb2I5WDBsK3dnalVJZXBWdnJ4R2NNTHNH?=
 =?utf-8?B?US9aUXZLT1psSzVSOGp0RWQ1TUdxVGdaQ2k1RFRSYm9PQzF3MXkrSXNpZDVZ?=
 =?utf-8?B?WVVyZ2hoSHZrWUdSL1lEL3dWNXdvb0s4YkZZRkxhM21MTzkvVzh1QmdoMmRX?=
 =?utf-8?B?amR4TkJaU3V4YUt3c3pwYzVSQWorZGEzY3Y2aW1NcytlY1hWYXArKzNsVWRF?=
 =?utf-8?B?T0pSamxTWDBHM0U5WUVxUjBuZlJicVhUeTVBWFdmTE1yT05nWHRYU3Q1YlQ0?=
 =?utf-8?B?UFFWQWZNb1E5QWV3Mjd6Vi9jQTg5ZmJzbGZTOWhCWlArK1NDdnZvUCtIakdD?=
 =?utf-8?B?TTNGZEplM1BobGdaS0U0Y2hoTmN1OWdsZVFjdXZLM1hrUGphYWtIblNNVGZN?=
 =?utf-8?B?cmdtcmR6SkZOckFMdXBQd0dlN0tQMTR0VmQxSWs2TVc0SUZmTDBWdkNjTm5O?=
 =?utf-8?B?MHRiMWRYOSs4ZzBqV1dBSlB6ajI2d1VReUV5ZVU0RzRQQkN3MldzMkMrejJn?=
 =?utf-8?B?TkZqcmtTSzJ1cG1yL25RQ2VIWFN6NTRzU3B1UjA2MGpJbEFLYVRxR0FlWnBI?=
 =?utf-8?B?YUFuUlNLdXBVTWxtcGxXUU1qSXpUYlA1VEJVc0FDVVNVc25vcWpENW1yR3BP?=
 =?utf-8?B?b29sS2RJM21PUFpVVE5hU29Rank5VlNYM2krNElQQ1o4K2s4eWtHbGkzN1hI?=
 =?utf-8?B?cCszRFpVSEJadXlVWDEvZ0lDK2V0L1ByUmVkZmYwOFpzdjVTZHA0ejUzYjNZ?=
 =?utf-8?Q?SlXd3iOVafjzIocoh++jJXc4D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B0434CC2258FE4BB6BAC0FEFB8B5BFF@DEUP281.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f61d54f-be46-42c8-a0ee-08dd948343c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 14:09:25.4911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUaLWRyMhubQGNggUImgxmb6zl1Cu2Yl+Z4GBibJV0nV647yy1fb9Z4Ph1WhDaWFvkD5pDEhqALY9bO8QkQAWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPF99537C539

T24gNS8xNi8yNSAxNTozNywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTUvMDUv
MjAyNSAxNzoyMCwgUGlvdHIgS3ViaWsgd3JvdGU6DQo+PiBPbiA1LzEzLzI1IDEwOjI0LCBLcnp5
c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4+IE9uIDEzLzA1LzIwMjUgMDA6MDUsIFBpb3RyIEt1
YmlrIHdyb3RlOg0KPj4+PiArDQo+Pj4+ICttYWludGFpbmVyczoNCj4+Pj4gKyAgLSBQaW90ciBL
dWJpayA8cGlvdHIua3ViaWtAYWR0cmFuLmNvbT4NCj4+Pj4gKw0KPj4+PiArYWxsT2Y6DQo+Pj4+
ICsgIC0gJHJlZjogcHNlLWNvbnRyb2xsZXIueWFtbCMNCj4+Pj4gKw0KPj4+PiArcHJvcGVydGll
czoNCj4+Pj4gKyAgY29tcGF0aWJsZToNCj4+Pj4gKyAgICBlbnVtOg0KPj4+PiArICAgICAgLSBz
a3l3b3JrcyxzaTM0NzQNCj4+Pj4gKw0KPj4+PiArICByZWctbmFtZXM6DQo+Pj4+ICsgICAgaXRl
bXM6DQo+Pj4+ICsgICAgICAtIGNvbnN0OiBtYWluDQo+Pj4+ICsgICAgICAtIGNvbnN0OiBzbGF2
ZQ0KPj4+DQo+Pj4gcy9zbGF2ZS9zZWNvbmRhcnkvIChvciB3aGF0ZXZlciBpcyB0aGVyZSBpbiBy
ZWNvbW1lbmRlZCBuYW1lcyBpbiBjb2RpbmcNCj4+PiBzdHlsZSkNCj4+Pg0KPj4NCj4+IFdlbGwg
SSB3YXMgdGhpbmtpbmcgYWJvdXQgaXQgYW5kIGRlY2lkZWQgdG8gdXNlICdzbGF2ZScgZm9yIGF0
IGxlYXN0IHR3byByZWFzb25zOg0KPj4gLSBzaTM0NzQgZGF0YXNoZWV0IGNhbGxzIHRoZSBzZWNv
bmQgcGFydCBvZiBJQyAod2UgY29uZmlndXJlIGl0IGhlcmUpIHRoaXMgd2F5DQo+IA0KPiANCj4g
VGhpcyBjb3VsZCBiZSBhIHJlYXNvbiwgYnV0IHNwZWNzIGFyZSBjaGFuZ2luZyBvdmVyIHRpbWUg
KHNlZSBJMkMsIEkzQykNCj4gdG8gaW5jbHVkZSBkaWZmZXJlbnQgbmFtaW5ncy4gSWYgdGhpcyBh
bm5veXMgY2VydGFpbiBnb3Zlcm5tZW50IHNlbmRpbmcNCj4gdGhlaXIgZXhlY3V0aXZlIGRpcmVj
dGl2ZXMsIHRoZW4gZXZlbiBiZXR0ZXIuDQo+IA0KDQpPSywgSSd2ZSByZWFkIHNvbWUgZGlzY3Vz
c2lvbnMgcmVnYXJkaW5nIHRoaXMgaXNzdWUgYW5kIGRlY2lkZWQgdG8gcmVuYW1lIGhlcmUgYW5k
IGluIHNpMzQ3NCBjb2RlLg0KDQo+IA0KPj4gLSBkZXNjcmlwdGlvbiBvZiBpMmNfbmV3X2FuY2ls
bGFyeV9kZXZpY2UoKSBjYWxscyB0aGlzIGRldmljZSBleHBsaWNpdGx5IHNsYXZlIG11bHRpcGxl
IHRpbWVzDQo+IA0KPiBPbGQgZHJpdmVyIGNvZGUgc2hvdWxkIG5vdCBiZSBhbiBhcmd1bWVudC4g
SWYgY29kZSBjaGFuZ2VzLCB3aGljaCBpdCBjYW4NCj4gYW55dGltZSwgYXJlIHlvdSBnb2luZyB0
byBjaGFuZ2UgYmluZGluZz8gTm8sIGJlY2F1c2Ugc3VjaCBjaGFuZ2UgaW4gdGhlDQo+IGJpbmRp
bmcgd291bGQgbm90IGJlIGFsbG93ZWQuDQo+IA0KDQoNCg0KPj4NCj4+Pj4gKw0KPj4+PiArICBy
ZWc6DQo+Pj4NCj4+PiBGaXJzdCByZWcsIHRoZW4gcmVnLW5hbWVzLiBQbGVhc2UgZm9sbG93IG90
aGVyIGJpbmRpbmdzL2V4YW1wbGVzLg0KPj4+DQo+Pj4+ICsgICAgbWF4SXRlbXM6IDINCj4+Pj4g
Kw0KPj4+PiArICBjaGFubmVsczoNCj4+Pj4gKyAgICBkZXNjcmlwdGlvbjogVGhlIFNpMzQ3NCBp
cyBhIHNpbmdsZS1jaGlwIFBvRSBQU0UgY29udHJvbGxlciBtYW5hZ2luZw0KPj4+PiArICAgICAg
OCBwaHlzaWNhbCBwb3dlciBkZWxpdmVyeSBjaGFubmVscy4gSW50ZXJuYWxseSwgaXQncyBzdHJ1
Y3R1cmVkDQo+Pj4+ICsgICAgICBpbnRvIHR3byBsb2dpY2FsICJRdWFkcyIuDQo+Pj4+ICsgICAg
ICBRdWFkIDAgTWFuYWdlcyBwaHlzaWNhbCBjaGFubmVscyAoJ3BvcnRzJyBpbiBkYXRhc2hlZXQp
IDAsIDEsIDIsIDMNCj4+Pj4gKyAgICAgIFF1YWQgMSBNYW5hZ2VzIHBoeXNpY2FsIGNoYW5uZWxz
ICgncG9ydHMnIGluIGRhdGFzaGVldCkgNCwgNSwgNiwgNy4NCj4+Pj4gKyAgICAgIFRoaXMgcGFy
YW1ldGVyIGRlc2NyaWJlcyB0aGUgcmVsYXRpb25zaGlwIGJldHdlZW4gdGhlIGxvZ2ljYWwgYW5k
DQo+Pj4+ICsgICAgICB0aGUgcGh5c2ljYWwgcG93ZXIgY2hhbm5lbHMuDQo+Pj4NCj4+PiBIb3cg
ZXhhY3RseSB0aGlzIG1hcHMgaGVyZSBsb2dpY2FsIGFuZCBwaHlzaWNhbCBjaGFubmVscz8gWW91
IGp1c3QNCj4+PiBsaXN0ZWQgY2hhbm5lbHMgb25lIGFmdGVyIGFub3RoZXIuLi4NCj4+DQo+PiB5
ZXMsIGhlcmUgaW4gdGhpcyBleGFtcGxlIGl0IGlzIDEgdG8gMSBzaW1wbGUgbWFwcGluZywgYnV0
IGluIGEgcmVhbCB3b3JsZCwNCj4+IGRlcGVuZGluZyBvbiBodyBjb25uZWN0aW9ucywgdGhlcmUg
aXMgYSBwb3NzaWJpbGl0eSB0aGF0IA0KPj4gZS5nLiAicHNlX3BpMCIgd2lsbCB1c2UgIjwmcGh5
czBfND4sIDwmcGh5czBfNT4iIHBhaXJzZXQgZm9yIGxhbiBwb3J0IDMuDQo+Pg0KPiANCj4gQWNr
LCBJIHNlZSB0aGF0J3MgYWN0dWFsbHkgY29tbW9uIGZvciBwc2UtcGQuIEl0J3MgZmluZS4NCj4g
DQpBY3R1YWxseSwgYWZ0ZXIgc29tZSBjb25zaWRlcmF0aW9uIEkgYWdyZWVkIHdpdGggeW91IGFu
ZCBkZWNpZGVkIHRvIHJlbW92ZSB0aGlzIHBhcnQgDQppbiB2MyBhcyB0aGlzICdjaGFubmVscycg
bm9kZSBkb2VzIG5vdCByZWFsbHkgIGRlc2NyaWJlIEhXIG1hcHBpbmcsIHRoZSBwc2UtcGlzIHBh
cnQgZG9lcy4NCnYzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvZWJlOWE5ZjUtZGI5
Yy00YjgyLWE1ZTktM2IxMDhhMGM2MzM4QGFkdHJhbi5jb20vDQoNCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gS3J6eXN6dG9mDQoNClRoYW5rcw0KL1Bpb3RyDQo=

