Return-Path: <netdev+bounces-189614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD02AB2D1A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8F7189AC7C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C622144AE;
	Mon, 12 May 2025 01:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="r+3W9cEY";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="Gkt+VHjr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B785420E32D;
	Mon, 12 May 2025 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013308; cv=fail; b=dvpfyYqRMWUHelTTNBpVGGAhj5SNwYLshIIPabLd7fZkCEQDVq2HiV2RRjdgNkJs+hN4DxMdI5kclt4CIywWlJeZn4Jys58gFFrzTqr7Q5EvaS+zkRdhLETayC5PpF4pJaiErR8fxfHyazi9/4nJtMOMgnJRWYmFKXZChOAw8QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013308; c=relaxed/simple;
	bh=6FKqElMS+HZQzdDDRI7HZwcaMXpEINbksPlcmoyODgg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s1Gw8yKaM1J3cN+OgW4Z+xt4f8ndIwYg0hvCqSg6M469xj2NYEWyHCzpMeowRMr4NLQwg3Gkx0WimexGMQ1/OgnGwVYDbxwcEjpwDFPGQSONyt2VGa5IffsZ8b54NkOUNrzUvydAwaIrbVKJ+yil7xu86YqZs6m/R/Bs3Hgr/eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=r+3W9cEY; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=Gkt+VHjr; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C0dSZC021480;
	Sun, 11 May 2025 20:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=mW7vmEdxebJd3ADXDxa0qONobo7bNXedsL+eHxaxpHA=; b=r+3W9cEYxhdZ
	5AUp/EoE7kaCaHIysXfibKvo4xWByadTV1ylU2ffjD3IRdmODX9s7YxjczWCt6hR
	NWLqJ/7KPVumYp+P/NcPPn1SuUm9MOFNA8ybYxyfezTfhDs1QgrjzmEjXwbx1JEG
	i0NgusgnHglxyT/3gD7kHS4PdYnDaZKo4loSi2HMfv2OLRZZ4eFI56Ym3Vj3vnki
	sQM2rm8MwYkiJyPjlYE2nuxw6PLfwjAkP/HSnhmCdb9hj7SsMMkdchcrUXHvVjoO
	x9g3hTl2vbjJWCYtkVSynWPBL54JU0Us93SYsRHaZHqS3jRk6D7WZqWyMajMXe+C
	2Y1QrwqO4g==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j34csvw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTFpLBU+0mD7cBjW2HCjwgetwEFW70wriws4dqqduvovXlN2CQmgp0KgwUlZynVk6KamFNYeBsC3NZioi6qJUQwGT+nKO03xW8GB9S8EGr/cbkkA+jxOIGfARL0W7YKMsmwgzgmBQ+kqlJQb/Ef/CkSt3v+NEvOh+BxgMlowuV56lpmg6dlGJ5CIldIpwL0KqXhOVWKJxaleZ06qkYx4fkMWOV6uDvGipMBb+rv20cF3ECq8sJwj08VriFM8nFZJVjkKDjUNiB+3YIBBPSCknnDMHUIDbQBd7+ppQi2tGqj0sDaAzTZ2q0T7Q/6PZz65zXR22lmGLdRXnTsjtwkCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW7vmEdxebJd3ADXDxa0qONobo7bNXedsL+eHxaxpHA=;
 b=dqgrKRR6RO5dRfr1zipt/mnwoRsBKfj7fFr8IlXaLbe3+H4rlR8PT3JYzg1q9LJ9bjJCqrWZy+yzNLADT1cImC9x8fAHBrYwBqfztthi5DLxP7clqY02z6756n3litR1hnWGvfm3PwRVkHe5A4JfuKBxlBEEeOMBndWbYTcUe+zx8JtkLfn/MDMoxmAS4F3z/oE/SF7tJjqCdhcj1fOtWCbrl81snXDy5UdB3GyKLQdaVxqgErLgfQhX0fCDWXiol2WfH6va5K822jqzI/sC7+bLHmI3Iy0lr7WcEiIkb8VK30PWLRBgenaS1JBDosj72SzkpfHL6f2cRUWT2qkGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW7vmEdxebJd3ADXDxa0qONobo7bNXedsL+eHxaxpHA=;
 b=Gkt+VHjrvbwroF17oB92P9Qj/Ko4efWVb+zJr9jlMiT7o2fGmVOdzX5l7qw7+eOGbSc2tJ+K/KcAXlMRkcxeqVVcq0FvXI2eXO3n+cYsNH4WVdUrdRwCReyF8RhWQ3KN0VexJbusZkJMZP/XGBxBjQQJDHJRYWrE0GobJJOZiYs=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 01:28:01 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:28:01 +0000
From: =?UTF-8?q?Damien=20Ri=C3=A9gel?= <damien.riegel@silabs.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Silicon Labs Kernel Team <linux-devel@silabs.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC net-next 05/15] net: cpc: implement basic transmit path
Date: Sun, 11 May 2025 21:27:38 -0400
Message-ID: <20250512012748.79749-6-damien.riegel@silabs.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512012748.79749-1-damien.riegel@silabs.com>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::17) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|IA0PR11MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df0926f-113c-4be6-26c5-08dd90f43c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFg3ZHNodjMzTjZMOXVoSkRrR2dyWWFrcUYwRnEvdDFxeUIwMUZ5TmduTEdl?=
 =?utf-8?B?blRJTGE4TjIyS2Mwd0g5WlMyS1lhOVZvOHNMSnZ4MTVDTkN0enBETFRHbitG?=
 =?utf-8?B?L1l4T2VVM0Z1Wm5oSnA2WkZsMzJrRUE0YVliVTBBMWl2OWNjUUo3S1NscDF6?=
 =?utf-8?B?NWVpVWZmeS9ZSlBLTzFSZ3N3MUJaZWEyRWh0NzlPeWluS1dQMXNMK21lMlRp?=
 =?utf-8?B?dmFDNHFSckN0SDN2QWxEbHFUM3J5c3MzN2UxNXo0NTROcWlNSGR1bEVnSlVI?=
 =?utf-8?B?R2Y5dVplOXZHRW1kbHBWenF1RjhQYzg2d2tCZlNIa2I3TmpGWnRoYTJFUG80?=
 =?utf-8?B?OWdrZHVyVzU5dlBFa3VTMStIMDdLZnl5d1F4eXdKMGhTc0N1bXBTbDJnRith?=
 =?utf-8?B?SEtlQjhISCsySTBwanpwOHpGQVl6N3RSY1ptazhFWlVRRldoR3ZJSnNMbE5s?=
 =?utf-8?B?TU5TV2g4dmFIUFBZZTNvOEZkeW5rdTVaaU02N0VYWEYrRGxaclVqSWVLakF1?=
 =?utf-8?B?amI0bGxDVnFHK0JHQy82V3M4dUt1c3haL01aNEplWkt5azc1eUFSb2JhbUJV?=
 =?utf-8?B?U2lhSndLRmJsUG9YZXdMTHBoU3Z5b3UyUGNXVWtUalNjUWRRNXF3Y21yLy9B?=
 =?utf-8?B?dFQ1YUc3Zm9lbjA1S2FvTzBKd09RU1Rhalc5eUNBUVErc0xmN0UzMGtJSHZO?=
 =?utf-8?B?Nko5L2NrOWdTQS9QajBxZllDdDlwSndvYk4yVXBxME9SM2J1WldtdHVTaGx3?=
 =?utf-8?B?TGpSWUZyMUQxRytYcWZYV1BldnFmV1BZa0JCQVRJQk9RYVhRVWFXTXVvWkpT?=
 =?utf-8?B?dGNzTVlzZ0wvNXgxRHJoZUhyeFU1VUlHMjJPYStjeUZUYTZlaXpsSTd6WkZh?=
 =?utf-8?B?ZGJZMjA4d1FZN3V1SE1CYzBOYUdPRjFoM3hBWlhLdnMzNEU5NDFJRWhmUERn?=
 =?utf-8?B?OStzN2JnU2dFZU15SWlycUNBT2ZVblpKT0pnaW56SllwdzlRM1d4MHJMTGk4?=
 =?utf-8?B?SUtwOXczWlBCRytwcitsVVlyV01jWm1QakNsblhFYnBtT3BnR0xtOE5VR0VZ?=
 =?utf-8?B?ZWtMRTNmcThNN2N2UzQvb3dmMkp5VWhCdzNJYmpVWFFFdy9TODB1Nyt1VHBj?=
 =?utf-8?B?YUQ0dzR6QmNEU3VBMW1oZVVMbWM3disrTEQvOWNxekZodzFxNlFxK2RXa3p2?=
 =?utf-8?B?T3RvNy9rb1JUY2h3OUdlcWYveHVjZ0FoaVdldlRncUIyQUhuakRTNnlra2F2?=
 =?utf-8?B?RnBuMlZtUHdlWlVmT2tmV2hSUWJVVENRZVVDTVl5em41bTc0Y1JXQnZuMkI3?=
 =?utf-8?B?QklSWnRNdURGMlV4TnZDL28zdjdUdHFkRStEcG1VdmtUZmtDUDNsWFkwandh?=
 =?utf-8?B?Nkp4Um5UblI4MkFTaXpzeTJCdDY0SHVpc0hkMmlDd0EvUVROYkpOLytFZDBD?=
 =?utf-8?B?NWl1NmNxb1IzY05uQ2UyMlJhMUxscENrRS9wMWlaNkNlNGVsWkV6K1N6T2Za?=
 =?utf-8?B?a2l4bUlPa3JzWm1FS1dlTGJSbHhhZHlDUHpoc0tUTTVPVEZWamhXM21HZFdj?=
 =?utf-8?B?dkZFbC9mTE41bkloM2tGOEd1eENYaXR1aExFQ3hiTFdObGRqR205YjlGTVY1?=
 =?utf-8?B?STRXUGxWYjFTczR6YkM0bE5zU1FyTFdUYzRDRHIxUmJmZUprSmMyYmt6TlF2?=
 =?utf-8?B?MUNCUXllUUg0MkRMbGRjT3pud1FrSTBkMUo1dVZSRTg3ajl3WGk5OVY5MTMx?=
 =?utf-8?B?WlcvOENHT09HOUxyaXRiTHdZTkVobVIwRUJvMlVTRU9FNHplcFpaQ01RdnRw?=
 =?utf-8?B?M0tjVkxUWWMxclNQeWdKRmIxclNnYmF6YmphZjVVZnRJc0J3K0lQY01KVHZY?=
 =?utf-8?B?R1QrdXVWRkt3RDdPMC8wWndsMUxnL08ydjFIbm42VXkyVnpsV3ZFTVB3SE95?=
 =?utf-8?B?enVWaUd1ZFQxa0JYSzYxOEVLTDR1enFmUUVVN0RrS21jQzNrUUJZRlg0d016?=
 =?utf-8?Q?l2RQQcJoCur/fQ+79uADaz0KTmDqAc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk40Vk9iY1U1SlpuampiS0xZWjZzMEl3a1gzQ0F3THZ5dEFURm9VUStlWFJr?=
 =?utf-8?B?Zlh0SzcxKzBkV085MHF6aElyL3dmRDVDSmp1Q2FFVG4xUklDc1BXOTRuSUZK?=
 =?utf-8?B?eCtGcjVSTVFtOTEzbEszWURhWEhkYS83YlZZdEkwMDB0azRzS2xpaTFhaFVo?=
 =?utf-8?B?bWxNS2kzQUJ0Z2UvTXRyaDNDOHhrdGNLVEhWRmo1RnNtQTBsQTI5TFltZEFI?=
 =?utf-8?B?YTRYRi95MUJ6UjNOU2lGc2N5eTBuY3dPYWlzb0ptc1IxUExHUnlKNE0yZ0kx?=
 =?utf-8?B?YmFpR0hqNVJEZkh5TERmaHlzaTZLMEJZZVpQUnRJeEl1K3R0TkpSRmU4dDlN?=
 =?utf-8?B?b2NDcFlRZDNwQTdhZjZnbjhzam1odjBDQjhxQWI1L0xLRXhQSFgxbG5tOGt2?=
 =?utf-8?B?dkRVcEFiNHhvQkRjTk1lS09EOVRGTnlHNS9TSHNNbmF6TWVXcWFFUGIxYnZI?=
 =?utf-8?B?b3FGSG9sRjJwVHdtOTluZU1wNnlEajVCQ1daZ1gvVEl2dU1uV01XdFVnMGdY?=
 =?utf-8?B?WGozSG4yOWNheWJxTGVXanAvRG9TTXROUk41TUxuaFJNb3RKWlNsUk1WZHpj?=
 =?utf-8?B?aVlhb04xSllBK3dhQ0wyckJpTWx4cG9iem9wSFlBYzlHOWxYejNkYjRPckJX?=
 =?utf-8?B?azZuejJNWkltYmY2Nm16R3F2VFFHdHVRTExXSjBHNkFNalBib2Jpd1dxbmxt?=
 =?utf-8?B?UTBWeDk1SDJLeG9hWHltYmJmUVRraWJ0ZGZscHd2QmJQTmtweERLb1dpY3VL?=
 =?utf-8?B?Mis1QnJiVTZEVi9WODNqalp2WktYK1FuV3NTVjJGRkVkT25LcERjVjkva3Vn?=
 =?utf-8?B?QUtyMkRHdlgyNlIrQjl6K0Fydkp1ZVFiMThlNXczWFZWNCs2UUtMbjdIYTAv?=
 =?utf-8?B?L2Z3U1hvelFKL0tqRm5vdFpKVnBNNFRmblBWMkp6Y1FicEVyZDlZTHhYY3Zm?=
 =?utf-8?B?TTRJUzd1TldTTWM5UlA5Q21JWTZmV0tuc3dNcytpNWg0L1Q3Nmt5S0plamEv?=
 =?utf-8?B?NU5vRTRkYmNVbDBlTG1BekIzbmY3WTR6TmhUaW9ZMUx6cEYyQXNsckNGWiti?=
 =?utf-8?B?Y0V1RFJGZUdjZFhpN21welIzUVJwQ0VwODViR2tHMHhYSlh5aXJwamc3Y1Uz?=
 =?utf-8?B?eCsvaEorMmVUc054Qm5qWUtMdkN5amlSWDNObkZISVFSbHRjZnlhM0ZTbGxY?=
 =?utf-8?B?S3JTQVlJckxwS2FkcnNIa2JFRVEwWWo5ZDlUS2x2dFI5NHFpZlE3VHVlNXAz?=
 =?utf-8?B?TjFQZ0FSWjFPakMwa3MyTkFKRmxoc3hoSEUzSk1TaW94dzZFSGxleEtFWm0z?=
 =?utf-8?B?Y0t3R3VFSmhvM2Y2c3EvUHhFVWJwTER0VTFlOHZtMXV1Vzc1Zzh4U203cHN5?=
 =?utf-8?B?ZzF0enZQSU8vNDJMSXZJejNuVnk4eUxEcmJuWHNJK1VsSjBhZEhzTmtuMGlF?=
 =?utf-8?B?MTM2M0NsRDEyNFJ2SWoxNVJGQ21GeXdiSTVOcDR3TGZlanBvRk96VWhIanF0?=
 =?utf-8?B?T1NlQjRRSXNIYmY5SzBCb3RtdEw4d3FNdlVQUlQ1emdCZlNFZFNpbitWVE9s?=
 =?utf-8?B?QU9Xa29GR2d0TlRuamF4QjEzQm02b2JBY1hHaXpXYU5jRXhFNXh6VzRhUjkx?=
 =?utf-8?B?S2xNQ01VMHNsRnNZMUVRdWU1TjN5NzdhOFQwTG9admJOQ0N2T1ZXcnlEUDV3?=
 =?utf-8?B?RkRwcmFIOWhrbngxUmxWSitNVEZVMSthOHN2dTlGVWpnQTRiL0o1UmZrK2Vm?=
 =?utf-8?B?R2lsY0pKbE12aHZmSENCNFBYKzk0UmxSdzQwV0g1Yi9qTERvb1hCU05SS1RJ?=
 =?utf-8?B?eEhtR1YreUxtZ3hUamxINGtWNFZOT05mZjA5TXZOa0h6R0VkM3NHd1hXbVNx?=
 =?utf-8?B?VmtvZ1RCNURzZzJpTE4wdkw0RURFb1Jtc2I2TVovbFFHZzBYVVMzVjBXY3JM?=
 =?utf-8?B?Qlk4a2JCU3lkTFU4UnpvbkY2ZTFNUjNMUlZ5TEJ4c1RxNGxyVG5GeDhNeHRt?=
 =?utf-8?B?c21uaENMQnBCWmJvUzQrZFNDRndCVmJOQ2pJY3lEY2RlK1IxVEVoaElSanFn?=
 =?utf-8?B?emY0cEJhMzE0WHgvWDQySUo5ZzM0V3dwUVlIVCt1amhGQlZjaDNYSHpZdVFk?=
 =?utf-8?Q?YmfsVwrtrLSHnvMmnSJh9NWQi?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df0926f-113c-4be6-26c5-08dd90f43c1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:28:01.3461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URNveDJlyOue6Qhbpi0UnEYcAvqM4FSJoG+tGQe2R7HV2OTlVjDG32O4cgWIxpursnrmdQX22Wwns+Ti16KzUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-Proofpoint-GUID: eDv24CPFnK76PzMtQoXB1OPliLvczo4f
X-Proofpoint-ORIG-GUID: eDv24CPFnK76PzMtQoXB1OPliLvczo4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX0Qx115e6vAwE JjXI4IjDRXtQOcTP9GPnTy/WAKrVWb8vkFLvKxTDFlyJcFQe25MMc+Ir6CFPTtl5a815PAyq8UU Oxpic+D2aaq8MRwCC7iieUL42LT4uPK1ana2YwajLsx+TbEuLIYciLaxd4M/z30piqLORIfN2it
 yERj1O8WHj/S35zMEeRXvNLKfm6WJDlEjhnwdN0nITDFbaqAfPZCCtjAx4P6bpaxOQqch3Qf2AZ P2/pKjfR9/WOzLdxiwwFtPZyS/pCLAMRta4YwEnbqzUzxrNqhERAFLiKhNlW75yBvbAV2RGMlR2 wCIVIvrx1YikBlxrnn6PPjxUrxYJ4WJLifXTXb+E3LomtdAi42L+r25VK7e28mFmtagGNX2cnAw
 UbiBMuGQIxYMhh/KB8mvZXzvPftPyoq4PgLoeolhzIYfphkNr+BihD9BSX9GJBlXTcQJX7YS
X-Authority-Analysis: v=2.4 cv=L/gdQ/T8 c=1 sm=1 tr=0 ts=68214ea5 cx=c_pps a=X8fexuRkk/LHRdmY6WyJkQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=rdBUWvkrBW2bLS41O5wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

Implement a very basic transmission path for endpoints. Transmitting
involves the following flow:
  - user call cpc_endpoint_write() with the SKB they wish to send
  - a CPC header is prepared and prepended to the frame
  - SKB is pushed to endpoint's holding queue (*)
  - SKB is dequeued from endpoint's holding queue and moved to
    interface's transmit queue (*)
  - interface is woken up by invoking its wake_tx() callback
  - interface work task is now responsible for dequeueing and
    transmitting that SKB when it's convenient for it to do so.

(*) Endpoint's holding queue currently serves no purpose but it will
    when other protocol features are implemented.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 drivers/net/cpc/Makefile    |  2 +-
 drivers/net/cpc/cpc.h       | 15 +++++++++
 drivers/net/cpc/endpoint.c  | 33 +++++++++++++++++++
 drivers/net/cpc/interface.c | 40 +++++++++++++++++++++++
 drivers/net/cpc/interface.h |  7 +++++
 drivers/net/cpc/main.c      | 50 +++++++++++++++++++++++++++++
 drivers/net/cpc/protocol.c  | 63 +++++++++++++++++++++++++++++++++++++
 drivers/net/cpc/protocol.h  | 19 +++++++++++
 8 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/cpc/protocol.c
 create mode 100644 drivers/net/cpc/protocol.h

diff --git a/drivers/net/cpc/Makefile b/drivers/net/cpc/Makefile
index 81c470012c1..0e9c3f775dc 100644
--- a/drivers/net/cpc/Makefile
+++ b/drivers/net/cpc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-cpc-y := endpoint.o header.o interface.o main.o
+cpc-y := endpoint.o header.o interface.o main.o protocol.o
 
 obj-$(CONFIG_CPC)	+= cpc.o
diff --git a/drivers/net/cpc/cpc.h b/drivers/net/cpc/cpc.h
index cbd1b3d6a03..2f54e5b660e 100644
--- a/drivers/net/cpc/cpc.h
+++ b/drivers/net/cpc/cpc.h
@@ -7,6 +7,7 @@
 #define __CPC_H
 
 #include <linux/device.h>
+#include <linux/skbuff.h>
 #include <linux/types.h>
 
 #define CPC_ENDPOINT_NAME_MAX_LEN 128
@@ -24,6 +25,8 @@ extern const struct bus_type cpc_bus;
  * @id: Endpoint id, uniquely identifies an endpoint within a CPC device.
  * @intf: Pointer to CPC device this endpoint belongs to.
  * @list_node: list_head member for linking in a CPC device.
+ * @holding_queue: Contains frames that were not pushed to the transport layer
+ *                 due to having insufficient space in the transmit window.
  *
  * Each endpoint can send and receive data without consideration of the other endpoints sharing the
  * same physical link.
@@ -36,6 +39,8 @@ struct cpc_endpoint {
 
 	struct cpc_interface *intf;
 	struct list_head list_node;
+
+	struct sk_buff_head holding_queue;
 };
 
 struct cpc_endpoint *cpc_endpoint_alloc(struct cpc_interface *intf, u8 id);
@@ -44,6 +49,8 @@ struct cpc_endpoint *cpc_endpoint_new(struct cpc_interface *intf, u8 id, const c
 
 void cpc_endpoint_unregister(struct cpc_endpoint *ep);
 
+int cpc_endpoint_write(struct cpc_endpoint *ep, struct sk_buff *skb);
+
 /**
  * cpc_endpoint_from_dev() - Upcast from a device pointer.
  * @dev: Reference to a device.
@@ -137,4 +144,12 @@ static inline struct cpc_driver *cpc_driver_from_drv(const struct device_driver
 	return container_of(drv, struct cpc_driver, driver);
 }
 
+/*---------------------------------------------------------------------------*/
+
+struct sk_buff *cpc_skb_alloc(size_t payload_len, gfp_t priority);
+void cpc_skb_set_ctx(struct sk_buff *skb,
+		     void (*destructor)(struct sk_buff *skb),
+		     void *ctx);
+void *cpc_skb_get_ctx(struct sk_buff *skb);
+
 #endif
diff --git a/drivers/net/cpc/endpoint.c b/drivers/net/cpc/endpoint.c
index 98e49614320..4e98955be30 100644
--- a/drivers/net/cpc/endpoint.c
+++ b/drivers/net/cpc/endpoint.c
@@ -6,7 +6,9 @@
 #include <linux/string.h>
 
 #include "cpc.h"
+#include "header.h"
 #include "interface.h"
+#include "protocol.h"
 
 /**
  * cpc_ep_release() - Actual release of the CPC endpoint.
@@ -18,6 +20,8 @@ static void cpc_ep_release(struct device *dev)
 {
 	struct cpc_endpoint *ep = cpc_endpoint_from_dev(dev);
 
+	skb_queue_purge(&ep->holding_queue);
+
 	cpc_interface_put(ep->intf);
 	kfree(ep);
 }
@@ -51,6 +55,8 @@ struct cpc_endpoint *cpc_endpoint_alloc(struct cpc_interface *intf, u8 id)
 	ep->dev.bus = &cpc_bus;
 	ep->dev.release = cpc_ep_release;
 
+	skb_queue_head_init(&ep->holding_queue);
+
 	device_initialize(&ep->dev);
 
 	return ep;
@@ -165,3 +171,30 @@ void cpc_endpoint_unregister(struct cpc_endpoint *ep)
 	device_del(&ep->dev);
 	put_device(&ep->dev);
 }
+
+/**
+ * cpc_endpoint_write - Write a DATA frame.
+ * @ep: Endpoint handle.
+ * @skb: Frame to send.
+ *
+ * @return: 0 on success, otherwise a negative error code.
+ */
+int cpc_endpoint_write(struct cpc_endpoint *ep, struct sk_buff *skb)
+{
+	struct cpc_header hdr;
+	int err;
+
+	if (ep->intf->ops->csum)
+		ep->intf->ops->csum(skb);
+
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.ctrl = cpc_header_get_ctrl(CPC_FRAME_TYPE_DATA, true);
+	hdr.ep_id = ep->id;
+	hdr.recv_wnd = CPC_HEADER_MAX_RX_WINDOW;
+	hdr.seq = 0;
+	hdr.dat.payload_len = skb->len;
+
+	err = __cpc_protocol_write(ep, &hdr, skb);
+
+	return err;
+}
diff --git a/drivers/net/cpc/interface.c b/drivers/net/cpc/interface.c
index 6b3fc16f212..1dd87deed59 100644
--- a/drivers/net/cpc/interface.c
+++ b/drivers/net/cpc/interface.c
@@ -58,6 +58,8 @@ struct cpc_interface *cpc_interface_alloc(struct device *parent,
 	mutex_init(&intf->lock);
 	INIT_LIST_HEAD(&intf->eps);
 
+	skb_queue_head_init(&intf->tx_queue);
+
 	intf->ops = ops;
 
 	intf->dev.parent = parent;
@@ -154,3 +156,41 @@ struct cpc_endpoint *cpc_interface_get_endpoint(struct cpc_interface *intf, u8 e
 
 	return ep;
 }
+
+/**
+ * cpc_interface_send_frame() - Queue a socket buffer for transmission.
+ * @intf: Interface to send SKB over.
+ * @ops: SKB to send.
+ *
+ * Queue SKB in interface's transmit queue and signal the interface. Interface is expected to use
+ * cpc_interface_dequeue() to get the next SKB to transmit.
+ */
+void cpc_interface_send_frame(struct cpc_interface *intf, struct sk_buff *skb)
+{
+	skb_queue_tail(&intf->tx_queue, skb);
+	intf->ops->wake_tx(intf);
+}
+
+/**
+ * cpc_interface_dequeue() - Get the next SKB that was queued for transmission.
+ * @intf: Interface.
+ *
+ * Get an SKB that was previously queued by cpc_interface_send_frame().
+ *
+ * Return: An SKB, or %NULL if queue was empty.
+ */
+struct sk_buff *cpc_interface_dequeue(struct cpc_interface *intf)
+{
+	return skb_dequeue(&intf->tx_queue);
+}
+
+/**
+ * cpc_interface_tx_queue_empty() - Check if transmit queue is empty.
+ * @intf: Interface.
+ *
+ * Return: True if transmit queue is empty, false otherwise.
+ */
+bool cpc_interface_tx_queue_empty(struct cpc_interface *intf)
+{
+	return skb_queue_empty_lockless(&intf->tx_queue);
+}
diff --git a/drivers/net/cpc/interface.h b/drivers/net/cpc/interface.h
index d6b6d9ce5de..1b501b1f6dc 100644
--- a/drivers/net/cpc/interface.h
+++ b/drivers/net/cpc/interface.h
@@ -22,6 +22,7 @@ struct cpc_interface_ops;
  * @index: Device index.
  * @lock: Protect access to endpoint list.
  * @eps: List of endpoints managed by this device.
+ * @tx_queue: Transmit queue to be consumed by the interface.
  */
 struct cpc_interface {
 	struct device dev;
@@ -35,6 +36,8 @@ struct cpc_interface {
 
 	struct mutex lock;	/* Protect eps from concurrent access. */
 	struct list_head eps;
+
+	struct sk_buff_head tx_queue;
 };
 
 /**
@@ -58,6 +61,10 @@ void cpc_interface_unregister(struct cpc_interface *intf);
 
 struct cpc_endpoint *cpc_interface_get_endpoint(struct cpc_interface *intf, u8 ep_id);
 
+void cpc_interface_send_frame(struct cpc_interface *intf, struct sk_buff *skb);
+struct sk_buff *cpc_interface_dequeue(struct cpc_interface *intf);
+bool cpc_interface_tx_queue_empty(struct cpc_interface *intf);
+
 /**
  * cpc_interface_get() - Get a reference to interface and return its pointer.
  * @intf: Interface to get.
diff --git a/drivers/net/cpc/main.c b/drivers/net/cpc/main.c
index dcbe6dcb651..8feb0613252 100644
--- a/drivers/net/cpc/main.c
+++ b/drivers/net/cpc/main.c
@@ -7,6 +7,56 @@
 #include <linux/module.h>
 
 #include "cpc.h"
+#include "header.h"
+
+/**
+ * cpc_skb_alloc() - Allocate an skb with a specific headroom for CPC headers.
+ * @payload_len: Length of the payload.
+ * @priority: GFP priority to use for memory allocation.
+ *
+ * Return: Pointer to the skb on success, otherwise NULL.
+ */
+struct sk_buff *cpc_skb_alloc(size_t payload_len, gfp_t priority)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_skb(payload_len + CPC_HEADER_SIZE, priority);
+	if (skb)
+		skb_reserve(skb, CPC_HEADER_SIZE);
+
+	return skb;
+}
+
+/**
+ * cpc_skb_set_ctx() - Set the skb context.
+ * @skb: Frame.
+ * @destructor: Destructor callback.
+ * @ctx: Context pointer, might be NULL.
+ */
+void cpc_skb_set_ctx(struct sk_buff *skb,
+		     void (*destructor)(struct sk_buff *skb),
+		     void *ctx)
+{
+	skb->destructor = destructor;
+
+	if (ctx)
+		memcpy(&skb->cb[0], &ctx, sizeof(void *));
+}
+
+/**
+ * cpc_skb_get_ctx() - Get the skb context.
+ * @skb: Frame.
+ *
+ * Return: Context pointer.
+ */
+void *cpc_skb_get_ctx(struct sk_buff *skb)
+{
+	void *ctx;
+
+	memcpy(&ctx, &skb->cb[0], sizeof(void *));
+
+	return ctx;
+}
 
 static int cpc_bus_match(struct device *dev, const struct device_driver *driver)
 {
diff --git a/drivers/net/cpc/protocol.c b/drivers/net/cpc/protocol.c
new file mode 100644
index 00000000000..692d3e07939
--- /dev/null
+++ b/drivers/net/cpc/protocol.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#include <linux/mutex.h>
+#include <linux/skbuff.h>
+
+#include "cpc.h"
+#include "header.h"
+#include "interface.h"
+#include "protocol.h"
+
+static int __cpc_protocol_queue_tx_frame(struct cpc_endpoint *ep, struct sk_buff *skb)
+{
+	struct cpc_interface *intf = ep->intf;
+	struct sk_buff *cloned_skb;
+
+	cloned_skb = skb_clone(skb, GFP_KERNEL);
+	if (!cloned_skb)
+		return -ENOMEM;
+
+	cpc_interface_send_frame(intf, cloned_skb);
+
+	return 0;
+}
+
+static void __cpc_protocol_process_pending_tx_frames(struct cpc_endpoint *ep)
+{
+	struct sk_buff *skb;
+	int err;
+
+	while ((skb = skb_dequeue(&ep->holding_queue))) {
+		err = __cpc_protocol_queue_tx_frame(ep, skb);
+		if (err < 0) {
+			skb_queue_head(&ep->holding_queue, skb);
+			return;
+		}
+	}
+}
+
+/**
+ * __cpc_protocol_write() - Write a frame.
+ * @ep: Endpoint handle.
+ * @hdr: Header to write.
+ * @skb: Payload to write.
+ *
+ * Context: Expect endpoint's lock to be held.
+ *
+ * Return: 0 on success, otherwise a negative error code.
+ */
+int __cpc_protocol_write(struct cpc_endpoint *ep,
+			 struct cpc_header *hdr,
+			 struct sk_buff *skb)
+{
+	memcpy(skb_push(skb, sizeof(*hdr)), hdr, sizeof(*hdr));
+
+	skb_queue_tail(&ep->holding_queue, skb);
+
+	__cpc_protocol_process_pending_tx_frames(ep);
+
+	return 0;
+}
diff --git a/drivers/net/cpc/protocol.h b/drivers/net/cpc/protocol.h
new file mode 100644
index 00000000000..b51f0191be4
--- /dev/null
+++ b/drivers/net/cpc/protocol.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#ifndef CPC_PROTOCOL_H
+#define CPC_PROTOCOL_H
+
+#include <linux/skbuff.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+struct cpc_endpoint;
+struct cpc_header;
+
+int __cpc_protocol_write(struct cpc_endpoint *ep, struct cpc_header *hdr, struct sk_buff *skb);
+
+#endif
-- 
2.49.0


