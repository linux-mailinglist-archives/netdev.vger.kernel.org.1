Return-Path: <netdev+bounces-164147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ADEA2CBE6
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C6A7A6FFA
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1D81A5BBC;
	Fri,  7 Feb 2025 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gQyEM637"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B521917D4
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953946; cv=fail; b=AXk5zegRZYFQHL9IXUHgpCCXhLBFO7IMAmkzryZ15DL/7XmWqpDZe2YotE1w74yb/IvLIVayjY6eyjB8lF052QotQ29GiS4R/hX5B8zXpyMPqsExLcvSfRLZXs9xbUojK1nBnZsQHzMxkM3NThxrA8qjbPQiZHCYNHpji1rNEHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953946; c=relaxed/simple;
	bh=PIlMQ4rgHHXlfgA3ExX64xpi0CPeJlCXQkngw9gJLnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jh9gCzWggGyly+a5V7loC+gPCsxdTtlHArTgBRH/EjRmskBO3BLk+DDHjVJd8W+LBGi7hACpnPc8gFTIeh0JFIHDb+nC4OW2rbgvoOSr/QIRPzTSqXOVl17oFgWWxGye05edwUH89AJUqnJAoA0icCxKyMfVV2sOuaMzG7IfZTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gQyEM637; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/3rhNYpSa5aj1/X7D+4VA3QOe/2Lks8xpovzN+Db4cOBHcNGmI4uLaKhLh+vLUrtDU+4Z+G9I3I8BcOsB2T9IoI5/0WH/OcwrPDlGTwDYVZ9m9oNylJROZI/Y/jgsAphYWqEHn2Be1pjyoI506b8iYliZFR9RH1nV7Tf9B7JPNHZ25DClRXtSyeJ2YRHtrn80ivnmXvGB0J0YKE4w7UGg9Z6tVl9HmyzOO21a+O6+5vEQTkzoP743pGv/uG01NeIlCtBG3G6oxH7NbxbIJoSoruZuOZcQzz9qWOZatBNaSCtng3fUWSQaf/WagNZwY1snL2hoq0PUuPlkioXLQ8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIlMQ4rgHHXlfgA3ExX64xpi0CPeJlCXQkngw9gJLnM=;
 b=CyUdrUVx5MelF1VeAZVNJZOQIQ9JqYYBx5CrZDcfnmlgj3sMadlk3q4Ky91JeA2WpzpSes5kFeqCV3TJ4iLjrDFLEDCC99CLc7/Q0HVSD0y6E9oecYQOqx/G3Uea2yiD8fUzHQ3JDVkm9OJdUwMJYRkKUG4EpY+ANDmZFDDH6PgMRckW6jFQL4gJxKhz6lI8oril6CIP6y7UkpfgUd2l8S/u5jEEPBJ+3UgOUJdrUbUtWLNyvGgpohqjW7O9rAQsMJsCJYKuVzQIecVgR2S5Fgm3xOQlK+XU9PvkVUdwhOGOupQ6eTrzwL6rlLHHjMcexrOWVxsmVppiq7y5y/T/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIlMQ4rgHHXlfgA3ExX64xpi0CPeJlCXQkngw9gJLnM=;
 b=gQyEM637pmPbQ33afJOi8LvJZlvvxlFyThpdbDYrFG25iUuQVylB80SzKsasG/7gFDTepWLrLvjFHlkj+juHeMu1j7zrtYMawrMk1stMV26BS7RwNWN6slPslFQNGULYe7uN397lyY0VVGoNcUjcPZCaUvvhcOya9A7SyKITpDRVqKaO9VGaa/TMofG2ZBDpfRqGQ4xGHZd7r/cZg2Q0nBksc/gHuUIzPiLYOJN2CLzehkdnbkET0A5BZFpfpQsfPDzI3TmmyWDRLuXja9rJnXYVPvx0fJppa4YZyImbXdMK96f0iCM+3ssR9l0Aw7+GA9tqhvY427sqTJ0GumfJlg==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Fri, 7 Feb 2025 18:45:40 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 18:45:40 +0000
From: <Tristram.Ha@microchip.com>
To: <rmk+kernel@armlinux.org.uk>
CC: <olteanv@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: RE: [PATCH RFC net-next 1/4] net: xpcs: add support for configuring
 width of 10/100M MII connection
Thread-Topic: [PATCH RFC net-next 1/4] net: xpcs: add support for configuring
 width of 10/100M MII connection
Thread-Index: AQHbd9HIW9ViSow9oUa42qXJUaZUXbM8MJbg
Date: Fri, 7 Feb 2025 18:45:40 +0000
Message-ID:
 <DM3PR11MB87368121188C48DD17B3AAE2ECF12@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <E1tffRE-003Z5c-0L@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tffRE-003Z5c-0L@rmk-PC.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|CY8PR11MB7339:EE_
x-ms-office365-filtering-correlation-id: ca941d3e-94a4-4346-2c5a-08dd47a79e9b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGp6UGZPWmczT1ZrWEZpUnd1b3N3djhUWFo3WWRhOHozK082dDdQdVRPdzNI?=
 =?utf-8?B?bTVpL2c3NHU1TE1yL3pUMzJZMlJHN0Y1dzVrUVdoWHJzY2Z2N2pWSVdEOGx5?=
 =?utf-8?B?RTg3dGl6QnpIeVFwZ3VtT0hNYzdWVTdjZlc0VTMyMit0M0N1QXZjVlBLNVdN?=
 =?utf-8?B?bFhXL1RIQnVjS1NJZkZDL1hDektHUG9HcjFCSVV5eDlybHdkbURYNDIrMDZo?=
 =?utf-8?B?ZmUwTVFFajNERDl1K3JhL0pURGJ6bHJlZUNvUDMzREpCbmlTWjErdUpsdDRT?=
 =?utf-8?B?Q2VDY01nZnpYS3dBNHU0TFRlS2dnYUhOWG5hVm1PbDErNjR0SW9waC9DZSti?=
 =?utf-8?B?VWdSS3MrN00yRFFWZk9Nd2NZMkZ6dWI4Rk4rR1JwUTRxOHRuNER5RlVMNFp0?=
 =?utf-8?B?WUhkUFpHV21BN3FKUjhDY241N3YvbUowa1E2UkJhN2xKbXoxQTdUWm14akJT?=
 =?utf-8?B?R3pKM2xCTVA0dHZQZTVoUFBTd2pxbHJ4TVkza1FMbllLZXBFcHdZV1h2NUNT?=
 =?utf-8?B?bWhyRjZHbFlvaldKenR5RCtWVmpXeVhBNzV6U1pLMXJuM3lJMFczc1cvYlNl?=
 =?utf-8?B?Q2pvbnFpYlo4bS9CZVRYYzlwOXlwYTBzM3hTZ3dsUDVkRmtGb25Oc3hUSEVv?=
 =?utf-8?B?ZThrcDdMaXY4dS85dTB5SlJLMlQyRUt4NTBZQThHblNiK2NNVkhwTFJ6anp2?=
 =?utf-8?B?clRPOGh5SjNqdWJRMTlodS9MN3Y2WENYTmtWUFNMcWdISkV5c1pRa3B1ckFz?=
 =?utf-8?B?UGMwdjVOS1JFRmdvcjJydTZqdUN3amM5L25IRWN5c1FOV2l6NXFjWWZCRTBZ?=
 =?utf-8?B?UUE1amhlQk8vR09pVkNXNi9NNEc3QzJrWllRUnBoek1acFVPS1l5WkgyR3dL?=
 =?utf-8?B?bzk5Q09ud25KbGNjanNVT3RzVzJiMG1XcnN3K1hKZFZSbE1LSUswU2UzSmJL?=
 =?utf-8?B?UDcvVDIyVkxlbVVab2s3ZitIcm1UOUpoa0l6NkppWEtyWVpzQXZBSS9FWFZD?=
 =?utf-8?B?aUMvUktLeTdIcnpqRVZrdU0vN2U0QnphRU9lREFlVmU2c0F1a1RCZG1YSUhD?=
 =?utf-8?B?dm9KZ0puYXhNd0NKWXd5UHFoM2FGanU4aDZPY3BTUWlzenFKZDRaRm9tbk54?=
 =?utf-8?B?QXV5M1JNVDVPVVAzUDhDSlBpejIreUs2dk9JVHI0ZytZa244Q1QvbElwWE5R?=
 =?utf-8?B?dmZMaVlJOVZuZTRtTFFLLzlqd3NYd1p0S2Z4YUJqUE9RNkErYitORUN5NXFt?=
 =?utf-8?B?aWp0OFNRY2sxWVdwYzFNbk9icWFLV01TMDVnRUhZbG4zeEQ3ajVhdUlZak51?=
 =?utf-8?B?YmxxV01iS1lzSjhVWGkzU0MycFFVazlrQUJPckZLcG0vV3RQNlpJYkd0YzF6?=
 =?utf-8?B?VlNKeEU0a2pNQkJUWVk2aU01bkVKY3o1aFZUTHorRXRId0psVUVOYTZKZXc3?=
 =?utf-8?B?OFAvQ1hMdDFCU21IbzdHdXZPT0hUVWhwdGVuR0U1VjFrWjBBdEx4NWFFeU9x?=
 =?utf-8?B?bkE4dW9ReGsxaFlNQVhFUjRnbitpQU9aZGRzc29JNTk0MTFEZ3E1WFBzZEtO?=
 =?utf-8?B?WTl4VU9YQnZLbHVpM2hyNXFoZ0Exdk9mYmprTGVUdGJDayt3Mi9aakRhK2xT?=
 =?utf-8?B?bSs0VlNMQXRGSm5rOUVRZ0ZQTHBYcnM3aUJhODdlTGl2VjRwRVJxMEl2c0lY?=
 =?utf-8?B?eTl5TlpjcGZ6bzUrdFdTNzZXQ3JGZWxjODhRNUVHYThuYkFTQU5PL2pnSUJw?=
 =?utf-8?B?NkVyYXVEZldpSklEdm5zUHhncThBMUhySm83Y0FEUGk4UWl5NWdHWUIxa0tu?=
 =?utf-8?B?dVBXZ3lTU2tzaHpHMFNUMHBSYlAyOTBZWVNtc3I2c21IN1VCQW50bStvejhs?=
 =?utf-8?B?SXhIMzFIV0k5dXBaNVBqTDdWUy9JK2k0R0kra05ldHN5THR1Z2dOaUFndTNY?=
 =?utf-8?Q?BuuLQwH9mtTdXb2XXwew9/hkl3V0M9No?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZksweGM3Y01qSUNmcTlVZ3pJK3lkcXJuNzEyTDJsZlpJZGNGZ2ZrNXZ6cEZy?=
 =?utf-8?B?em5CYk0xc3hCTUl6bmh0cmNyeWNYY09VM3N0Kzl4ZFBic0FxRUxTc0dhdlFX?=
 =?utf-8?B?MEM1N0R4MFNGaDVXak5Zd3N0YmJRakR4MXF0K3J0ZjNPRWVtaWROUU1iZklV?=
 =?utf-8?B?R0JOdllsWlAxZXd3YVZKMGQzMHhFUTNFRUdQbGd3RU5PQzF0cVJycTVJUXAr?=
 =?utf-8?B?cUxCdkVBK2hwVHkxVHdFM3BCMUdnSytDMUlKQlRNbnF6alU5MnBXZVd2bmFv?=
 =?utf-8?B?Vm53RG1vc0hlQnhyblNGVWZpbmEwak1yM1dDNjREK1hudVV1TGFYT2dZdTYy?=
 =?utf-8?B?eDl5TnhheERkZElPZ3AyY1NWaStjU3JLZmZpNkNGYjRQRUJzSmJIQ1k3WXJ6?=
 =?utf-8?B?RDY2RVpDV3JxOGd3QzJmOVRITkVSbWpzOWNYL280d0t3d1NiN1h2MFRsaDQ0?=
 =?utf-8?B?NDNQK3RZMkllUXNZUFI4ZERJb3MwSmlsS0Y4YnRSdklWRXlkQlNBVWZzV2FW?=
 =?utf-8?B?K2E3TElzbE1qZHF4TkVRak1mUHRNdXdrWGsxU0IvTmt4VXg1R2g3M1FWZTkr?=
 =?utf-8?B?OVpocDZmYzlacE1VOWdwaTJnZTJ3MnJTVTZ3cWVPM2o5T0lEdmdXMzNLYm1N?=
 =?utf-8?B?aFpyREp5c2NWVkRzd0NOYmpVclRzR29UQm1qenVSZlVNT0tkMndmTzJmQWtN?=
 =?utf-8?B?aDFuMk50MXdndjQxSjdJRHp2bS8wSzVONG9nemhFbGxHdHNVMWlPL3ZRZE8r?=
 =?utf-8?B?dnd6OWRMaTJ2cDN6MkpxbWk5T1FmS2FEb0dxZlZXRWFQTHpzaE94S3kwUDh6?=
 =?utf-8?B?ZkI2cU90QXBUK08yR1hGR3VyNW5xR1dNaldjYjViWjJqUDkxNlRHM0x1RGRP?=
 =?utf-8?B?S0tuUzVhVk13RmZiblhMZGJwOE9kMWJ1ZHlXMVA5RXd3Z1dYdkx1NmF0Mkdj?=
 =?utf-8?B?bldQUVNwQnNkamU5L0RsaXJXTnZubGxiZFNON3lKK0lZVi92U2d3SkxYbGJj?=
 =?utf-8?B?ZDVhUXZ1V2VFSFVDU21PWThYWmJsVDZueDVnSXZGUjFVZCswUzRTU2xuQ0NS?=
 =?utf-8?B?c24vQWdOb1lNYkJMckdRbjFCcTB4aDUwanlwOUl5Y3Z2dS9IVjhTV2QvTzhZ?=
 =?utf-8?B?RWtPQnI5ME1obDFwRnlNbG9uQm9uRXZuRjV1Z043ZFdlKzEzc0R0bnNRdmpy?=
 =?utf-8?B?QUZlUWFORDU2UjR6VmJHWjU3NkJ2QUgwenZuLzU2ZEl5eU1PdlUvSDZoLzB3?=
 =?utf-8?B?aVVma1FEcVB6YkhoclNDa2VDa0UxKzl6Yk9vTDYwZDZVbHpmMFhDeFA1WnhE?=
 =?utf-8?B?bzZBM1lvb0RnMktEcjZMcHRjcWk4eUZ2T3RZL0tISXcwRWoyWVBUdzRoRWZp?=
 =?utf-8?B?bEFNRXdmckFIanV3UTVWZ1RYS2RpMU5WNDFOZkwyVk5WZE1ESlBkK2VYb2p0?=
 =?utf-8?B?QlN4TkJXM2JBMWpZSzJlVEhKcGtFRktKYWR6UWMxaEVUTzBZS1JDOHZuMUhi?=
 =?utf-8?B?Qnp2ZG83d21pUmorYkMvZUNuSkhlVHhFcUpwSStNZFdxN0xCc2ZDUTZMTWFV?=
 =?utf-8?B?dzhRVHhBREhWUlQ3RWJWQVMwZ2xBcG9Wbi9VQmtNOC9SSmM4ZnBsVDNoVVJr?=
 =?utf-8?B?YkdjTkQzamszaDFjOGFyNk1uNTIyOGowOVJKNzQ2ZERJWXJWWis3K0VSMjFh?=
 =?utf-8?B?SjkxblVENjdjQ1dFVjZPR2lYY0NGems5aHFGeFZvRGk3NjBKd1ViSkI0cExs?=
 =?utf-8?B?S3ptbG9Pdzg2aUJEMlZrK0U3WDZoem9FVlg5WVFWZ0lqSy8vQW0wamZHVFlX?=
 =?utf-8?B?MmVXcTM1M0NUMWR6MTFRSGZ2bFhNb2MzZlU5UkdzUzJQOHBFWHp6b3g2K0lC?=
 =?utf-8?B?VXpjOUpWR1pycWNCa3NkQjFjNFk0U0RNeU1QellyZUFTWlZ5RnV6a0FmVW10?=
 =?utf-8?B?OWdFQWNXMlNwUzU2SEo5UkNuaGV6VDFWTEUwelpCRTJTUDB4Zmh2WjVzRWp5?=
 =?utf-8?B?Z3BFU1VxQUwzL3NOQm5DU0xSTkJBZjRXK29LSnVpZ0RZQ0xEblJVdC90NXZp?=
 =?utf-8?B?MUpFTGpiNDBuYXhFci9ZY1ZrZ3ZtNitXWldaYXZaL3drOFl0a0R2VWJRV3Fv?=
 =?utf-8?Q?ljgn8Xo0zp9XbDHQ8z9CWiYqN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca941d3e-94a4-4346-2c5a-08dd47a79e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 18:45:40.1913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGMRXoOXIeJSsOwI4rRBnhnBVXSb5Kq6yCdxZ0Kxy4R2WZ4V9htwiwQ8B2QKtvgKTOi6ccHDKJ5BwijW01W+VJDwsVu15+iPuUw7pTIeEmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdXNzZWxsIEtpbmcgPHJta0Bh
cm1saW51eC5vcmcudWs+IE9uIEJlaGFsZiBPZiBSdXNzZWxsIEtpbmcgKE9yYWNsZSkNCj4gU2Vu
dDogV2VkbmVzZGF5LCBGZWJydWFyeSA1LCAyMDI1IDU6MjggQU0NCj4gVG86IFRyaXN0cmFtIEhh
IC0gQzI0MjY4IDxUcmlzdHJhbS5IYUBtaWNyb2NoaXAuY29tPg0KPiBDYzogVmxhZGltaXIgT2x0
ZWFuIDxvbHRlYW52QGdtYWlsLmNvbT47IFVOR0xpbnV4RHJpdmVyDQo+IDxVTkdMaW51eERyaXZl
ckBtaWNyb2NoaXAuY29tPjsgV29vanVuZyBIdWggLSBDMjE2OTkNCj4gPFdvb2p1bmcuSHVoQG1p
Y3JvY2hpcC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+OyBIZWluZXIgS2FsbHdl
aXQNCj4gPGhrYWxsd2VpdDFAZ21haWwuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZl
bWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0
LmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIFJGQyBuZXQt
bmV4dCAxLzRdIG5ldDogeHBjczogYWRkIHN1cHBvcnQgZm9yIGNvbmZpZ3VyaW5nIHdpZHRoIG9m
DQo+IDEwLzEwME0gTUlJIGNvbm5lY3Rpb24NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRl
bnQNCj4gaXMgc2FmZQ0KPiANCj4gV2hlbiBpbiBTR01JSSBtb2RlLCB0aGUgaGFyZHdhcmUgY2Fu
IGJlIGNvbmZpZ3VyZWQgdG8gdXNlIGVpdGhlciA0LWJpdA0KPiBvciA4LWJpdCBNSUkgY29ubmVj
dGlvbi4gQ3VycmVudGx5LCB3ZSBkb24ndCBjaGFuZ2UgdGhpcyBiaXQgZm9yIG1vc3QNCj4gaW1w
bGVtZW50YXRpb25zIHdpdGggdGhlIGV4Y2VwdGlvbiBvZiBUWEdCRSByZXF1aXJpbmcgOC1iaXQu
IE1vdmUgdGhpcw0KPiBkZWNpc2lvbiB0byB0aGUgY3JlYXRpb24gY29kZSBhbmQgYWN0IG9uIGl0
IHdoZW4gY29uZmlndXJpbmcgU0dNSUkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSdXNzZWxsIEtp
bmcgKE9yYWNsZSkgPHJtaytrZXJuZWxAYXJtbGludXgub3JnLnVrPg0KPiAtLS0NCj4gIGRyaXZl
cnMvbmV0L3Bjcy9wY3MteHBjcy5jIHwgMTkgKysrKysrKysrKysrKysrLS0tLQ0KPiAgZHJpdmVy
cy9uZXQvcGNzL3Bjcy14cGNzLmggfCAgOCArKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAy
MyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3Bjcy9wY3MteHBjcy5jIGIvZHJpdmVycy9uZXQvcGNzL3Bjcy14cGNzLmMNCj4gaW5k
ZXggMWZhYTM3ZjBlN2I5Li4xMmEzZDVhODBiNDUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L3Bjcy9wY3MteHBjcy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3Bjcy9wY3MteHBjcy5jDQo+IEBA
IC02OTUsOSArNjk1LDE4IEBAIHN0YXRpYyBpbnQgeHBjc19jb25maWdfYW5lZ19jMzdfc2dtaWko
c3RydWN0IGR3X3hwY3MNCj4gKnhwY3MsDQo+ICAgICAgICAgdmFsID0gRklFTERfUFJFUChEV19W
Ul9NSUlfUENTX01PREVfTUFTSywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIERXX1ZSX01J
SV9QQ1NfTU9ERV9DMzdfU0dNSUkpOw0KPiANCj4gLSAgICAgICBpZiAoeHBjcy0+aW5mby5wbWEg
PT0gV1hfVFhHQkVfWFBDU19QTUFfMTBHX0lEKSB7DQo+IC0gICAgICAgICAgICAgICBtYXNrIHw9
IERXX1ZSX01JSV9BTl9DVFJMXzhCSVQ7DQo+ICsgICAgICAgc3dpdGNoICh4cGNzLT5zZ21paV8x
MF8xMDBfOGJpdCkgew0KPiArICAgICAgIGNhc2UgRFdfWFBDU19TR01JSV8xMF8xMDBfOEJJVDoN
Cj4gICAgICAgICAgICAgICAgIHZhbCB8PSBEV19WUl9NSUlfQU5fQ1RSTF84QklUOw0KPiArICAg
ICAgICAgICAgICAgZmFsbHRocm91Z2g7DQo+ICsgICAgICAgY2FzZSBEV19YUENTX1NHTUlJXzEw
XzEwMF80QklUOg0KPiArICAgICAgICAgICAgICAgbWFzayB8PSBEV19WUl9NSUlfQU5fQ1RSTF84
QklUOw0KPiArICAgICAgICAgICAgICAgZmFsbHRocm91Z2g7DQo+ICsgICAgICAgY2FzZSBEV19Y
UENTX1NHTUlJXzEwXzEwMF9VTkNIQU5HRUQ6DQo+ICsgICAgICAgICAgICAgICBicmVhazsNCj4g
KyAgICAgICB9DQo+ICsNCj4gKyAgICAgICBpZiAoeHBjcy0+aW5mby5wbWEgPT0gV1hfVFhHQkVf
WFBDU19QTUFfMTBHX0lEKSB7DQo+ICAgICAgICAgICAgICAgICAvKiBIYXJkd2FyZSByZXF1aXJl
cyBpdCB0byBiZSBQSFkgc2lkZSBTR01JSSAqLw0KPiAgICAgICAgICAgICAgICAgdHhfY29uZiA9
IERXX1ZSX01JSV9UWF9DT05GSUdfUEhZX1NJREVfU0dNSUk7DQo+ICAgICAgICAgfSBlbHNlIHsN
Cj4gQEAgLTE0NTAsMTAgKzE0NTksMTIgQEAgc3RhdGljIHN0cnVjdCBkd194cGNzICp4cGNzX2Ny
ZWF0ZShzdHJ1Y3QgbWRpb19kZXZpY2UNCj4gKm1kaW9kZXYpDQo+IA0KPiAgICAgICAgIHhwY3Nf
Z2V0X2ludGVyZmFjZXMoeHBjcywgeHBjcy0+cGNzLnN1cHBvcnRlZF9pbnRlcmZhY2VzKTsNCj4g
DQo+IC0gICAgICAgaWYgKHhwY3MtPmluZm8ucG1hID09IFdYX1RYR0JFX1hQQ1NfUE1BXzEwR19J
RCkNCj4gKyAgICAgICBpZiAoeHBjcy0+aW5mby5wbWEgPT0gV1hfVFhHQkVfWFBDU19QTUFfMTBH
X0lEKSB7DQo+ICAgICAgICAgICAgICAgICB4cGNzLT5wY3MucG9sbCA9IGZhbHNlOw0KPiAtICAg
ICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgIHhwY3MtPnNnbWlpXzEwXzEwMF84Yml0ID0gRFdf
WFBDU19TR01JSV8xMF8xMDBfOEJJVDsNCj4gKyAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAg
ICAgICAgeHBjcy0+bmVlZF9yZXNldCA9IHRydWU7DQo+ICsgICAgICAgfQ0KPiANCj4gICAgICAg
ICByZXR1cm4geHBjczsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9wY3MvcGNzLXhw
Y3MuaCBiL2RyaXZlcnMvbmV0L3Bjcy9wY3MteHBjcy5oDQo+IGluZGV4IGFkYzVhMGIzYzg4My4u
NGQ1M2NjZjkxN2YzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9wY3MvcGNzLXhwY3MuaA0K
PiArKysgYi9kcml2ZXJzL25ldC9wY3MvcGNzLXhwY3MuaA0KPiBAQCAtMTE0LDYgKzExNCwxMiBA
QCBlbnVtIGR3X3hwY3NfY2xvY2sgew0KPiAgICAgICAgIERXX1hQQ1NfTlVNX0NMS1MsDQo+ICB9
Ow0KPiANCj4gK2VudW0gZHdfeHBjc19zZ21paV8xMF8xMDAgew0KPiArICAgICAgIERXX1hQQ1Nf
U0dNSUlfMTBfMTAwX1VOQ0hBTkdFRCwNCj4gKyAgICAgICBEV19YUENTX1NHTUlJXzEwXzEwMF80
QklULA0KPiArICAgICAgIERXX1hQQ1NfU0dNSUlfMTBfMTAwXzhCSVQNCj4gK307DQo+ICsNCj4g
IHN0cnVjdCBkd194cGNzIHsNCj4gICAgICAgICBzdHJ1Y3QgZHdfeHBjc19pbmZvIGluZm87DQo+
ICAgICAgICAgY29uc3Qgc3RydWN0IGR3X3hwY3NfZGVzYyAqZGVzYzsNCj4gQEAgLTEyMiw2ICsx
MjgsOCBAQCBzdHJ1Y3QgZHdfeHBjcyB7DQo+ICAgICAgICAgc3RydWN0IHBoeWxpbmtfcGNzIHBj
czsNCj4gICAgICAgICBwaHlfaW50ZXJmYWNlX3QgaW50ZXJmYWNlOw0KPiAgICAgICAgIGJvb2wg
bmVlZF9yZXNldDsNCj4gKyAgICAgICAvKiBXaWR0aCBvZiB0aGUgTUlJIE1BQy9YUENTIGludGVy
ZmFjZSBpbiAxMDBNIGFuZCAxME0gbW9kZXMgKi8NCj4gKyAgICAgICBlbnVtIGR3X3hwY3Nfc2dt
aWlfMTBfMTAwIHNnbWlpXzEwXzEwMF84Yml0Ow0KPiAgfTsNCj4gDQo+ICBpbnQgeHBjc19yZWFk
KHN0cnVjdCBkd194cGNzICp4cGNzLCBpbnQgZGV2LCB1MzIgcmVnKTsNCj4gLS0NCg0KVGVzdGVk
LWJ5OiBUcmlzdHJhbSBIYSA8dHJpc3RyYW0uaGFAbWljcm9jaGlwLmNvbT4NCg0K

