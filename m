Return-Path: <netdev+bounces-106758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE409178B4
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CBF1C22DBB
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 06:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204A14A61B;
	Wed, 26 Jun 2024 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qpwo/++X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84B38D;
	Wed, 26 Jun 2024 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382472; cv=fail; b=m+9RR8q1XOvX9+W3PQ2W5geIjFW4orHpZZ4Qj7kA6SNbr2ArSvcIpXNPS7uEJrotYeIKSGQpyk2IIi7OohPZN2H37g8TEymawJuX+ISsA6E+vkqaPN65IxGKjgdobsl3KkVXDpIr2M7kJ1Kyv5WAWhk/gp5pzyyvTftnwOMGhzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382472; c=relaxed/simple;
	bh=v9JONqeDCoC+CcGEf6jN4Yl+e4GVUPW0p6SCXBifJK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JgC5ct57yXOEpBVPhnGA6TWW5WOD6WVBrk2bUSM9CpSJSgt3WfggF4JGM3qxoLm/G7dkdW19kRyc2s830Ww8tKnKAQ7xqkCc1tr4JwFMtazGir8pPuOJtU0bedRtEUlr1zBRWmyGYA4m1Wy8CJ9j/4Knn9DzY0UMwEV8TriZOQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qpwo/++X; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0PLAm6F2ypWRu4n5yBlnzeMtSDsCrxCX77pEe/9Wqrw1VhbsiAoEcILtSDpAIH6LBfy5ILnJIdOyeOsXJUQ/cz0J1vtRbqrvE+Xs0ehqYlhvRi+P7U9bZ17U/pVPKRpEpVzwimPUdOn8dV+oikbiQ809o6jubM4RdmgjWVH8M/qOSLWXLPGWsCdYYFLBq8hDtE4dOL7AHPQeREvzDoWVFlq8Fap/gNvzBpMNo8WANBthMohKXbjQCPHW4sqE4IRw+G0WyaK11uollahNNQBWHVF1LSZlTtyA6z/As1650LaDYKRD/6iewR9YEnydrhWJDir8EJ39pxGeVBZQfp9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9JONqeDCoC+CcGEf6jN4Yl+e4GVUPW0p6SCXBifJK0=;
 b=MJbnbKmqiKsz8lUerumYMR3O9Irzw9/HCTw5+FevY7OoQ01IWTMrerDeXxrtFp0KkzX6BKSVzsSYFyCkfqLpxbYYWXWbuE+rMYUsQunORkXYUi8zuwJCUeyniEkpK7B5oqUaIuywtZai0RS2WSpwgGr+5S3nycS6fhSsKdu0cH5paZJElJwnJxK4ng2bf7ghoW1kz5ItG2oPUPbk2RZBEPhrXsFPg7eqmzkgCi9SuqiEzk8l9lnXejKY/q00NhzNSKZmVJJyOcGMMaQ4zMgwtqPswimp9zvTsA7H7y9MFaH6EWN/wYp24mou6Lcp6EnC4REbZgm5I1VRLyMfachDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9JONqeDCoC+CcGEf6jN4Yl+e4GVUPW0p6SCXBifJK0=;
 b=Qpwo/++X793NEl7xC5Q8hsHi1Ittm3ZaulGidaXCPq9fpQ43E2YBNRy6Se4FtHgun/SViR1xQ7+nu79hWTBN2A4hfgzXL+ujS0azPxPZ/izKFjGAdnFwpaRzj9HDBukPqu/2ua5VgP7HwYeY9+1paGqboEWPcfCED/tmsEA60te9U262+DZ9aWp6UbLYDm1NZbBBx13pDU9asp1h1b3NEZPAr6z3iqckdcDkFTmmhi2dwVQEnGY4bqvbFBNszj23AIlzIRcIY8e7AsoF+j7RVebGndrlbYyPhGzFCGC5qzGIg41bxIvuKg53iQWWjaO4L9oQ53MitHi9+0c+hHWD0w==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 06:14:22 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 06:14:22 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>
Subject: RE: [PATCH net-next v7 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Topic: [PATCH net-next v7 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Index: AQHaxl9qSClTcs0l902JzHpAxldWxrHXUtgAgADOufA=
Date: Wed, 26 Jun 2024 06:14:22 +0000
Message-ID:
 <DM6PR12MB4516DD74CA5F4D52D5290E26D8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-8-danieller@nvidia.com>
 <003ca0dd-ea1c-4721-8c3f-d4a578662057@lunn.ch>
In-Reply-To: <003ca0dd-ea1c-4721-8c3f-d4a578662057@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CH3PR12MB9342:EE_
x-ms-office365-filtering-correlation-id: 4aa37719-5880-45a8-9e5b-08dc95a738b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230038|366014|376012|7416012|1800799022|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGtJeXpINTVKNkR0U2FVTGp2WW5YN1dkODNLUjBMUjM0SGk2dTZlKzFEWW1C?=
 =?utf-8?B?YlUwajZENC9IaEl2WU8zQnZMWjRPS3JrWjVMdDNYd080UDNwZEZoc0xyd0JU?=
 =?utf-8?B?cldEMWFVVldTNHRIWDhNWXhsMk5uc0F1V2ZzSldrZ3FKdlk5MzVqOGM1Vnhn?=
 =?utf-8?B?SElEak1oeWRRVU5yaERRNEJtdmNvcHFkVE5USHdvUnJPekl1KzRrM2xLNGxm?=
 =?utf-8?B?Y1U5WmNLUXVCVVptR3cxbUJFL2E0WTF6VDJVQ1NBeFJMWDJOdjN1UkJqQ1M5?=
 =?utf-8?B?RHovRWVjbWxYRnBRMWZkQlBtNDhGd285NTVJYkhYTEM3ZG9BSDJ4V1l6VFZo?=
 =?utf-8?B?eGx3b0k1MnZWNVhjaFlueE1iTEcyUmdqZ0NIRXpuOHI4L2ZTMTNZWm1CdDg4?=
 =?utf-8?B?NGI0YVJDdkhONTBmWDRQdDVWUDREWjNPdDg5MXROTmU3T2Vha2djZ09RbVYx?=
 =?utf-8?B?SXNsMGtSaHdLRWc0MWNQaFRFcUo1aE1YYUJYdi9aSUp0V2gxM3JUN3BLS1Bh?=
 =?utf-8?B?N1I0NVBQdWlrSjBYOVhCaSt2SUMvN3puM3J5YUJCVWwvZlpzMXo3VEUzLzR0?=
 =?utf-8?B?WXhUWExab1Z6UGtRNDM4ZmFVeHhKM3dhYXVENm1mWWpqcS8zTTV3d2o5WVFT?=
 =?utf-8?B?R05yTWZDVDNFZHY4WVpRUGRmL05PZlU3YmU5SjJRRGtKMHdiYUVmVWd2S0FI?=
 =?utf-8?B?Y2NWQld2Qm02bFVTdU9ac2Y5bkxQd1BRTUdKOSsvczJuYlk2dko1Z3V6U1cw?=
 =?utf-8?B?eEFFWlQ2dDk3bFNTaWpueFB4T1lhQlZ1elMwUytUdElaempTcUc3VHF4SVBs?=
 =?utf-8?B?Wnl4Z216UnZHV2tSTnkxaVVNNWRkKzRPZHUxNmpzeEpNd3ZVUWlBYkcxVVRO?=
 =?utf-8?B?OUJiT3o5N29iSkozOTUyU29SYXpvcnVkYkcrL2RTNDRydzZjb0JXQXJGUmFK?=
 =?utf-8?B?c2ZJZTI4aHFEVFA1Z1ZVTWUvTUhUVFpIZXRSRW5aMzA2SGUzS2pJOEtZbURP?=
 =?utf-8?B?VTZ1U0xKTHFBK0VDUjFsUzV5bmV0U2NtNG9haDc3L0FRSCtpZmYxdkRZUm1S?=
 =?utf-8?B?RTBkcTBpbE9mNkp3VC9ncUNaU1VyS09PUjM3UDVKamdQZjhPaVlma29rU2RP?=
 =?utf-8?B?MkRVZHZTallVNXRnQS9jTElJVVFqMkFvVjJFZm8zYjhBQXQ0YS84VXBoOENJ?=
 =?utf-8?B?R3Q4dXdyOUFCaFlhbTl0c0JhY3liajBnZnF2aHJrOVBOeXRlbTJDK0Z3ZEZV?=
 =?utf-8?B?M2JiNXVvdVVZajcxbzVWYmlueE55Tml6bU1pekJaVnhkVkhmOWF4dnpXWXpq?=
 =?utf-8?B?a1VET1ZGUFFGSVhhRDNnVWVtQXNTdnVTWllyK1hRQ3lKdENmSktpRmF0QUpX?=
 =?utf-8?B?VncyUG1rOGNXV0hPWkZ1ZmNaM2xVNHBOcmNTMDdvZlBMVldYNlJSTDBFRUZq?=
 =?utf-8?B?OHEvYmRRcXFBbk1LUzZJS2N3WlZZbkwrTzF0dmlhTTRtUEpLT0VPTnRIek4z?=
 =?utf-8?B?Y09YWTJybGVaZkUweFhCU1VHRUtjY3ZONk5lTzFNUzBrS3YzUjFIZDZiSXI4?=
 =?utf-8?B?VzVVWlJuZTJtcXZhUnZka0taTnM1VEU1Yk1DZWVwUEgveGhGQ0M4R0I4aEF0?=
 =?utf-8?B?RnlVRFd0RHp0OFo5aGgybFROMHdLNWJpd0ZraTJSN25Uc2t2OFZPbG40QU80?=
 =?utf-8?B?RWQ2UlRxdjRzaEVHc1pmYzZLdXpUdUxKWSszN0srenh5WEszZHloSnFCNkdv?=
 =?utf-8?B?TENNVG94K0FUd2lXbEVrTnVuSmR5Rmk2bGNRL2VyYlVleXJGSUR0bVVUQm5O?=
 =?utf-8?Q?u3Ti1sKY7EQd/sNdhCzx3HPRbsRtqApNa/B4E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zzk4ZUFxV21hdjJwbG9pejI1bTZMVmE5MmRqeFVYaWNOWEVaSzNTZGFUbTFK?=
 =?utf-8?B?cUZGYUdkTzdVL2xXcjUyakl0azhZeTBDYUhlT2hQa2lrOW9wVE1YMnRzMnZR?=
 =?utf-8?B?cDZNemtoZ1hieXRieGlhUEQ4REcvU2VySjc5SjdUK204cGtlMS9nQml0cW41?=
 =?utf-8?B?cElxckwrczhkQmlKRnZwV2VFd1pYNTRMc2FVWitYYW1GSW9uQzlaOTRXMDdw?=
 =?utf-8?B?VHBRTkxaaUU1U1R4ejNZcWZOdTRaR2cwVEZBU0FQd2NrOHVmQXR2cW9KaXl6?=
 =?utf-8?B?TDE0MEdIYWRSVngvRWcwYzZwbHY4ZEFnZzhXY2l0WGtNTzJOcXNGZ0wwd0tv?=
 =?utf-8?B?RG1yN1UrS3lDQjlJOFNUMzU5azJkUkFSYi95MFRma2FleEgyQ3dBa1p5NG5n?=
 =?utf-8?B?M2c5L0lYUkpoKy9pZ1FtNFlvZmszYmh3M0k4RjBlcUd0Qm1KVmVWQzNUajBQ?=
 =?utf-8?B?YjcvTXVXa2V3dXZoRTNpbUNpeFdiOTV2VlVPZnpRRUZ1bWVBZ1RRZHFLSzVu?=
 =?utf-8?B?cllIcDU2R1ZPM1E5MlFZQ2FzTk00dnQ4OHVtSWRGenZ0RzV1RnB3aHFlUFdE?=
 =?utf-8?B?TTNoTmFKNnA0OUVJanlBdlV0emhacElSb2dHZnBpMU9xMWRiRkU0b25VNTdE?=
 =?utf-8?B?bGlRK0ZsRndoOWtsSzJrNElUZE9QV1NicXQ1Z3hNclJLWDdWMWtLWENkWkpN?=
 =?utf-8?B?MHFheFMzb2tsQTJrSzMrQ2kvbzBoWlE0U2V2MzRuNUxZTE9PRlZ4RXRLdVAv?=
 =?utf-8?B?WVVIdFF6REx6ZWxOQmw3eEdBNnMxZFo4a09rUVR3dUkxK3Z2V1Roc2Z5dUJJ?=
 =?utf-8?B?d1hWMlVTMFlLRG5SaTE5TzZDOVVOV1FSVHpUbVJSS2F4S3hTUjcyeHBVdC8w?=
 =?utf-8?B?QWFESXlybU1VL052ajQ0dW96NFNSdlBUZzBtcWtyY3lZQnFwS3JuVmxXeDBW?=
 =?utf-8?B?K0toZkJvbmhwTjl2VlNaWmhPOFpqYzhxK2xIWmR2dWs4TTU3WU1hTURscmxR?=
 =?utf-8?B?RjhLRjBrajZXV3F6RUx5cjJyQkJmY3gwbW9FbE4zeWEySE93Z0lDbHBQdHJp?=
 =?utf-8?B?TlJESExRNGd0RGZ6dHpSMGFYeE5jYUJPdHRtTGdzdGNsbWowenNrdFZGdDE3?=
 =?utf-8?B?a1F4bkJBNXhlZ0xkSFpyYUNMTlVtckhXdkd1UzF5c1A0UFNER0x1eUhoUHJU?=
 =?utf-8?B?Z2hPR3J5R0JWejIyODlURVVTd1BObFN3ZGVuUXEvV20vSks2NnBIQ282UjE4?=
 =?utf-8?B?QksxWXRDdVFwL0ovS0ZFMFZLSGpQSDBDcU5BTE11M1VMTEJMeElqcW51TG9p?=
 =?utf-8?B?d09RSkVob0UyaUxSTksxQVp4OWxnRHdrN3k2MGpLMjdDQU5NbTlHQWJwZWdt?=
 =?utf-8?B?VHZuRXRnTGQ0RHkzY2JmRy8rS2d1dUYvY3VvT0tCb1g0eURXU21lYU5hVGkz?=
 =?utf-8?B?YmFTTW1JcFFQR3ptQ3FHTGlqWS94ZDlrT21ucm1ZQ3pMemlGWTJzR2tDWTlS?=
 =?utf-8?B?d1k0VkovbW1DeDVzck9abURVdEJMcFZwc1RTTXc4ZGxjS01aWThqWnJzRkRU?=
 =?utf-8?B?eE9hNHNONWRhY2UzejdDVXdYd25wK1JHYk5mc2pyczNsODBTeEhjTGFJV1ZI?=
 =?utf-8?B?dlNHMTEzcFluTDhxUStvUGdSRHIvZlRYZTAzMlpCMFM3eFM3ZVVQVy8wNFJZ?=
 =?utf-8?B?UnEvcm9idkR1TDNXWXJSYkdDckxkdWNXbEV2c1FxL3JDOGpzelVSbStYdGhF?=
 =?utf-8?B?Rm1MNUtGS2paQlhDS1hnTURXenRnYXJJYTUwNzltUFRFYk9pbVFVZTBDemVq?=
 =?utf-8?B?UkFFZzBxTEdpUGo3RDU2UENHYnRnWVN4VThZbzFQRXlHaVdCYUNuNEtGLzZ3?=
 =?utf-8?B?WEhaa0RBYTM4YWZqUVpTcm9uWjgxYWI2a2xhMzl3RHhBdVdacHp0SGlqVG1a?=
 =?utf-8?B?Sk9uSUV6bzEwK0ZDaTd6WG8vWitDczM5c0xIM0lNZDl6ZXhqR2RxdktNSERH?=
 =?utf-8?B?byt5bGVjeWl5dFBEZEZHZWx5UWdPSGNhWjFLV1ZPdUNPa3FHZmk5eGk5RzdP?=
 =?utf-8?B?YWFyVmpQZUdFcjF6TEp3YWJhK04vUlNicDdvSlorb3UvNUlZdkRCajBsUjJF?=
 =?utf-8?Q?vbC/mzkIYgLl0WhK0ev852pJJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa37719-5880-45a8-9e5b-08dc95a738b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 06:14:22.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cqaduWgTGc/yH7n7FAdP+ke01yu7tnt248cE6B58pQFdNiHDkt6NbHiiDbFW7d4BzZYxY3+79mccxUi2qFKhpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342

SGkgQW5kcmV3LA0KDQpUaGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0Y2hlcy4NCg0KPiBGcm9t
OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IFNlbnQ6IE1vbmRheSwgMjQgSnVuZSAy
MDI0IDIyOjUxDQo+IFRvOiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlkaWEuY29tPg0K
PiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgY29y
YmV0QGx3bi5uZXQ7DQo+IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgc2RmQGdvb2dsZS5jb207IGtv
cnkubWFpbmNlbnRAYm9vdGxpbi5jb207DQo+IG1heGltZS5jaGV2YWxsaWVyQGJvb3RsaW4uY29t
OyB2bGFkaW1pci5vbHRlYW5AbnhwLmNvbTsNCj4gcHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNv
bTsgYWhtZWQuemFraUBpbnRlbC5jb207DQo+IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbTsgc2hh
eWFnckBhbWF6b24uY29tOw0KPiBwYXVsLmdyZWVud2FsdEBpbnRlbC5jb207IGppcmlAcmVzbnVs
bGkudXM7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBtbHhzdyA8bWx4c3dAbnZpZGlhLmNvbT47IElkbyBTY2hpbW1lbA0KPiA8aWRv
c2NoQG52aWRpYS5jb20+OyBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjcgNy85XSBldGh0b29sOiBjbWlzX2NkYjogQWRkIGEg
bGF5ZXIgZm9yDQo+IHN1cHBvcnRpbmcgQ0RCIGNvbW1hbmRzDQo+IA0KPiA+ICtpbnQgZXRodG9v
bF9jbWlzX3dhaXRfZm9yX2NvbmQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgdTggZmxhZ3MsIHU4
IGZsYWcsDQo+ID4gKwkJCSAgICAgICB1MTYgbWF4X2R1cmF0aW9uLCB1MzIgb2Zmc2V0LA0KPiA+
ICsJCQkgICAgICAgYm9vbCAoKmNvbmRfc3VjY2VzcykodTgpLCBib29sICgqY29uZF9mYWlsKSh1
OCksDQo+ID4gKwkJCSAgICAgICB1OCAqc3RhdGUpDQo+ID4gK3sNCj4gPiArCWNvbnN0IHN0cnVj
dCBldGh0b29sX29wcyAqb3BzID0gZGV2LT5ldGh0b29sX29wczsNCj4gPiArCXN0cnVjdCBldGh0
b29sX21vZHVsZV9lZXByb20gcGFnZV9kYXRhID0gezB9Ow0KPiA+ICsJc3RydWN0IGNtaXNfd2Fp
dF9mb3JfY29uZF9ycGwgcnBsID0ge307DQo+ID4gKwlzdHJ1Y3QgbmV0bGlua19leHRfYWNrIGV4
dGFjayA9IHt9Ow0KPiA+ICsJdW5zaWduZWQgbG9uZyBlbmQ7DQo+ID4gKwlpbnQgZXJyOw0KPiA+
ICsNCj4gPiArCWlmICghKGZsYWdzICYgZmxhZykpDQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0K
PiA+ICsJaWYgKG1heF9kdXJhdGlvbiA9PSAwKQ0KPiA+ICsJCW1heF9kdXJhdGlvbiA9IFUxNl9N
QVg7DQo+ID4gKw0KPiA+ICsJZW5kID0gamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMobWF4X2R1
cmF0aW9uKTsNCj4gPiArCWRvIHsNCj4gPiArCQlldGh0b29sX2NtaXNfcGFnZV9pbml0KCZwYWdl
X2RhdGEsIDAsIG9mZnNldCwgc2l6ZW9mKHJwbCkpOw0KPiA+ICsJCXBhZ2VfZGF0YS5kYXRhID0g
KHU4ICopJnJwbDsNCj4gPiArDQo+ID4gKwkJZXJyID0gb3BzLT5nZXRfbW9kdWxlX2VlcHJvbV9i
eV9wYWdlKGRldiwgJnBhZ2VfZGF0YSwNCj4gJmV4dGFjayk7DQo+ID4gKwkJaWYgKGVyciA8IDAp
IHsNCj4gPiArCQkJaWYgKGV4dGFjay5fbXNnKQ0KPiA+ICsJCQkJbmV0ZGV2X2VycihkZXYsICIl
c1xuIiwgZXh0YWNrLl9tc2cpOw0KPiA+ICsJCQljb250aW51ZTsNCj4gDQo+IGNvbnRpbnVlIGhl
cmUgaXMgaW50ZXJlc3RlZC4gU2F5IHlvdSBnZXQgLUVJTyBiZWNhdXNlIHRoZSBtb2R1bGUgaGFz
IGJlZW4NCj4gZWplY3RlZC4gSSB3b3VsZCBzYXkgdGhhdCBpcyBmYXRhbC4gV29uJ3QgdGhpcyBz
cGFtIHRoZSBsb2dzLCBhcyBmYXN0IGFzIHRoZSBJMkMNCj4gYnVzIGNhbiBmYWlsLCB3aXRob3V0
IHRoZSAyMG1zIHNsZWVwLCBmb3IgNjU1MzUgamlmZmllcz8NCg0KSWYgdGhlIG1vZHVsZSBpcyBl
amVjdGVkIGZyb20gc29tZSByZWFzb24sIGl0IG1pZ2h0IHNwYW4gdGhlIGxvZ3MgSSBndWVzcy4N
CkJ1dCBpdCBpcyBsZXNzIGxpa2VseSB0aGFuIHRoZSBzY2VuYXJpbyBJIHdhbnRlZCB0byBjb3Zl
ci4NCkFjY29yZGluZyB0byBTUEVDIDUuMjoNCg0KIg0KNy4yLjUuMSBGb3JlZ3JvdW5kIE1vZGUg
Q0RCIE1lc3NhZ2luZw0KWy4uLl0NCkluIGZvcmVncm91bmQgbW9kZSB0aGUgbW9kdWxlIHJlamVj
dHMgYW55IHJlZ2lzdGVyIEFDQ0VTUyB1bnRpbCBhIGN1cnJlbnRseSBleGVjdXRpbmcgQ0RCIGNv
bW1hbmQgZXhlY3V0aW9uIGhhcyBjb21wbGV0ZWQuDQpOb3RlOiBSRUFEcyBvZiB0aGUgQ2RiU3Rh
dHVzIHJlZ2lzdGVycyAwMGg6Mzcgb3IgMDBoOjM4IChzZWUgVGFibGUgOC0xMykgd2lsbCBhbHNv
IGJlIHJlamVjdGVkIGJ5IHRoZSBtb2R1bGUuDQoiDQoNClNvIGluIHRoYXQgY2FzZSB0aGUgbW9k
dWxlIHdvbid0IGJlIGFibGUgdG8gcmVzcG9uZCBhbmQgd2UgbmVlZCB0byB3YWl0IGZvciBpdCB0
byBiZSByZXNwb25zaXZlIGFuZCB0aGUgc3RhdHVzIHRvIGJlIHZhbGlkLiANCg0KPiANCj4gPiAr
CQl9DQo+ID4gKw0KPiA+ICsJCWlmICgoKmNvbmRfc3VjY2VzcykocnBsLnN0YXRlKSkNCj4gPiAr
CQkJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsJCWlmICgqY29uZF9mYWlsICYmICgqY29uZF9mYWls
KShycGwuc3RhdGUpKQ0KPiA+ICsJCQlicmVhazsNCj4gPiArDQo+ID4gKwkJbXNsZWVwKDIwKTsN
Cj4gPiArCX0gd2hpbGUgKHRpbWVfYmVmb3JlKGppZmZpZXMsIGVuZCkpOw0KPiANCj4gUGxlYXNl
IGNvdWxkIHlvdSBpbXBsZW1lbnQgdGhpcyB1c2luZyBpb3BvbGwuaC4gVGhpcyBhcHBlYXJzIHRv
IGhhdmUgdGhlIHVzdWFsDQo+IHByb2JsZW0uIFNheSBtc2xlZXAoMjApIGFjdHVhbGx5IHNsZWVw
cyBhIGxvdCBsb25nZXIsIGJlY2F1c2UgdGhlIHN5c3RlbSBpcw0KPiBidXN5IGRvaW5nIG90aGVy
IHRoaW5ncy4gdGltZV9iZWZvcmUoamlmZmllcywNCj4gZW5kKSkgaXMgZmFsc2UsIGJlY2F1c2Ug
b2YgdGhlIGxvbmcgZGVsYXksIGJ1dCBpbiBmYWN0IHRoZSBvcGVyYXRpb24gaGFzDQo+IGNvbXBs
ZXRlZCB3aXRob3V0IGVycm9yLiBZZXQgeW91IHJldHVybiBFQlVTWS4gaW9wb2xsLmggZ2V0cyB0
aGlzIGNvcnJlY3QsIGl0DQo+IGRvZXMgb25lIG1vcmUgZXZhbHVhdGlvbiBvZiB0aGUgY29uZGl0
aW9uIGFmdGVyIGV4aXRpbmcgdGhlIGxvb3AgdG8gaGFuZGxlIHRoaXMNCj4gaXNzdWUuDQoNCk9L
Lg0KDQo+IA0KPiA+ICtzdGF0aWMgdTggY21pc19jZGJfY2FsY19jaGVja3N1bShjb25zdCB2b2lk
ICpkYXRhLCBzaXplX3Qgc2l6ZSkgew0KPiA+ICsJY29uc3QgdTggKmJ5dGVzID0gKGNvbnN0IHU4
ICopZGF0YTsNCj4gPiArCXU4IGNoZWNrc3VtID0gMDsNCj4gPiArDQo+ID4gKwlmb3IgKHNpemVf
dCBpID0gMDsgaSA8IHNpemU7IGkrKykNCj4gPiArCQljaGVja3N1bSArPSBieXRlc1tpXTsNCj4g
PiArDQo+ID4gKwlyZXR1cm4gfmNoZWNrc3VtOw0KPiA+ICt9DQo+IA0KPiBJIGV4cGVjdCB0aGVy
ZSBpcyBhbHJlYWR5IGEgaGVscGVyIGRvIHRoYXQgc29tZXdoZXJlLg0KPiANCj4gICAgIEFuZHJl
dw0KDQpZZXMgaXQgZG9lcywgYnV0IGFjdHVhbGx5IGl0IGlzIGFuIGhlbHBlciB0aGF0IG9jY3Vy
cyBpbiBzcGVjaWZpYyBwbGFjZXMgKGZvciBleGFtcGxlIHBjaV92cGRfY2hlY2tfY3N1bSgpKSwg
dGhhdCBpIGNhbiB1c2UgZnJvbSBoZXJlLg0KDQo+IA0KPiAtLS0NCj4gcHctYm90OiBjcg0K

