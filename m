Return-Path: <netdev+bounces-189610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05CAB2D0D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A37F189D1BE
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ADC20E717;
	Mon, 12 May 2025 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="R5W2Y1qP";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="KQFp/8b2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D71E491B;
	Mon, 12 May 2025 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013305; cv=fail; b=B4bQJq1bQBkV5FUKPWxbAeBbfKN8ExwqfDA/0qFAWyYk//Q70t26fwIP0xqu7IGeRThwyOFZtGrUed2RKsWo3SuaWgJqqp3nESEDiFDaWh/PEeyv6H6d5JYzX/eQpXoKXAwE+qzWsG0zkSrTQwXKgT81HRVLnlWj+TL9BPP56fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013305; c=relaxed/simple;
	bh=TfXw8Nok8mWP0sb5NMalMftyXvOQGY91umCsJmhHjsQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L/DpnQhyV+GcIwNQ+tBIGE0rGAFHyQXoX5MkcyESrgBTQy3/4ks/pHpRBe9+cIAeH+uHd2ND5oDMhtcSDFG4lJPxKcOQ4OHe1NwQylh4L1/6PgpkW5yQbPVw3RrtZ93Q1DrJz3kO3ReWgK2PZ+SYHZea8SbD+X6za5kGXwdWLx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=R5W2Y1qP; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=KQFp/8b2; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BNrm00027097;
	Sun, 11 May 2025 20:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps12202023; bh=Oq4tat0ZPyV0EDXuK5nC
	+hN3D25e5wKQ1Rw1YQYXHpg=; b=R5W2Y1qPRc14CL2mBQa4vP2nIE9q+kgV/cwC
	syxrrbS74MWSql3z5YWAL53h0BAPI5vhNeTnZjIgYMqXZs02/m/pIwwZC5h9tt+r
	VRpwEfCzpOTudLwwGKVPbnkWt7HchI7dEiyTPZzh7Vrg9CcQ/1iQWjZ8/55zc1Ou
	Wml6LFkaXn20+UpaG8+6Fyl723UjymwbaeqUW51h7umMvVVKrTvYbDRTw7stY0G9
	tFrGPqMg8qrXqCNyUO2khe/7oQAVLkl4w5/njwcPwOS7CIr9pGqtcNT9EtluweCA
	t/LeUclesrRbaAWJokpfJHaVzCASsFIutPKS9XKoNtXFkHAw/g==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j0aahxd2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pap3koIXFAymAd6Wx5adiBDbXi8CawMLVhkqI6Z7JkVAv6sC4aujJadECg2+DjlwaMO2XC+PctJAw/1IcOsEDRdNca4SMS+SVws0NmWfNvg3A9ho6ZWtP8YjxBRJR2u6XT/6DCpf5VUbSrtwp76rWCRsneX7dzGNsWx1tK18Zuc1/4X9dmOfxwggodE8VG69FTe19wYoDcK90S/vVu+FriN66mka+yT8lfpckTfvu9k2vdBNS2aM9JKLGwQPmp0wPvymPvNxyC76WM7mt2+M6ojEJwyys+31qNH2Lt4526jzIXCln2hw52KHsdSO/6nPmxFIo3SY38pI9GJHOXeKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oq4tat0ZPyV0EDXuK5nC+hN3D25e5wKQ1Rw1YQYXHpg=;
 b=f6aGmVIg4Niw5fqdBRBwRZwUztH+uPaiLNasD5pjDCBSIbRXqb0Rhc4+gLAQJG6nLsTHgt/3SIa1N6V+mUewItxqGjm/wMYIgHThjTWjN+Rtv/1WMlL6gf6WzRtWnYupdOMlCgneE1nFnJ6z5csuxR4u31qDhL3lm7ziPkYABoeSZXhppMw2qllxCu1RSxuRuiHWVN0wgt6/qhEy5bl6ce/0tY9KsnfTdsBVfSPckrby81ah5qYXXnKMfkaLHJpk5yqEQ0nDkP5KB3TaPbFr9JsUkl76O+2EG10ttyClCyuPzbM2bm598zkdrhs9QGbe6nrEl05iD6CAsyyyGNJrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oq4tat0ZPyV0EDXuK5nC+hN3D25e5wKQ1Rw1YQYXHpg=;
 b=KQFp/8b29sDOcfjnM3VPVNHOoukeS9vuWVLgEsewyA3sT72Uiy0VVz4Zabig7r/y+ws9Gs1ECq0NPlxjI2BtNUKu7HH/XXhkw4EOIsAaOsx5rWQMDbBPGPvkaqMJkizd/hSSWrJ/U+8h9cIqr3Yg6opYy9IV9UFZTkb14aJny7E=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 01:27:58 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:27:57 +0000
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
Subject: [RFC net-next 00/15] Add support for Silicon Labs CPC
Date: Sun, 11 May 2025 21:27:33 -0400
Message-ID: <20250512012748.79749-1-damien.riegel@silabs.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-Office365-Filtering-Correlation-Id: 1e922c45-33ae-44b7-dfbc-08dd90f439fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjVDRjNGLzVkVlVZam9GSk9EWXYzTHlkc09GQUpFNUsrcFB1aFBodGkvUm80?=
 =?utf-8?B?aERMYWI2ZCsvNkdvWEtBcmxkdFl4YytQb2c3SW1sbEY5Tm5qNno5RFNmMW1j?=
 =?utf-8?B?TlEwbzJyZUl2dE5iUDZjdk5CUS9vY1A5YlIxWWNCUTh4ck1ySkRBNDQ5bkh1?=
 =?utf-8?B?SVJtMnczM05ieGx6QVZvYTcyVHNYak1OVzFxREd0eExiZy9ZWE1pSEgrbUln?=
 =?utf-8?B?MVNja29xcGZsVnh1OWprNHhkb0h1b1ZxVStmRjVxOEovSVkycUxoVVVZZ0c5?=
 =?utf-8?B?SlVEZ0pBZWlqMnJxUy90R1MwVFFCV3hFMEQyZ3hPeVJScnpBOSt5c2ZTd2Fh?=
 =?utf-8?B?TWN5VXpqbHZWbTRaNUxVN2tOdnVqWUxjZEVDUnhYYmhheTBqS1dXd2swWkkr?=
 =?utf-8?B?UkFVNDdMSjRNWm5GdFJCWmNMMEV5NE00dURGMndkL1lIWFNIN3lENnZXNzh6?=
 =?utf-8?B?WDFkeGxNc0dTTDdoRTlQU3kzRnhZNytqdGVkUDVLTXRVTUQvNS9NVVdhRzAy?=
 =?utf-8?B?YjBxYnI4MGZpdjN5Q0ZNKzJSbnJ3RjB4dXM5QjhZcStWYnQrRnNidEFPZmgy?=
 =?utf-8?B?UGZ0N3psbFdsMDNzWmFEZVBEK0U1NVJseWovbmp1enE4OEtzQURsWTJxbDZZ?=
 =?utf-8?B?clk5dzJpS1FBdVlRNzRqWGZEYldFekhieFJBbzFzOWNOV1dEOHQ0NGF1Q0V4?=
 =?utf-8?B?dlBhQU9xWVl1KzNQeW9YMDFIR2lRd0FKbEFHWWN0YTFqakp2MVFJczdtQldK?=
 =?utf-8?B?MnZ5MFdrNUQ3TGdMT20xTXprNW56SlJxbjh5c3pBeExsS1JhRlZSSFo1MlhG?=
 =?utf-8?B?Wk5hNzI5bWZJWnZxVXNBYUNwZWZPOFJyeWtQVk0zUU1ua1RGYjA5RVFQVnBi?=
 =?utf-8?B?UkVmMkswVFFrNExSOXNMV0pMS3hCRFhyUThIODRzZWprQ1dnS2JsRmVNRWNM?=
 =?utf-8?B?a25wWThDTFRhaUhtQ1NObWZwOVFUZkEzVC9rR2lLREI3bVZNSExEanRKV2tm?=
 =?utf-8?B?U2ZuNDhvdlUvNGduSERmSG4vZHROUm9rNFI2M3ViTkwzMC8wM2hjNW0wT25H?=
 =?utf-8?B?NVFscFJndDdDUGUyY3hWWm10cGxCVlNuNE5XNG8yN1Z4dVF5UUtNNm9OVU00?=
 =?utf-8?B?Z3A0bmE5a3M3dlY0V3lnbm1GL1RoOVF2TFNFeDIwTFd3REtXakVRUG90ZE9Q?=
 =?utf-8?B?Zlk2bDJuWDZsc0RYaFNnSUJDSmpnRDVjclJyTHFzWkExbmdnSWkzNDR1ZkxU?=
 =?utf-8?B?aFJpZmRmNUdIMTlzMFlOVkt6VVcwMU5IZ0tZL3hkWGh1ZkhoTy91QVJ6c2VR?=
 =?utf-8?B?b3p4SU11NXA3QmpzL0tQcXFJSFJMUDhiazdqYmhDUGFRVHM2L0t3cVczeDVx?=
 =?utf-8?B?MTYyTWRwc1l6dkpGelY5anJPVmRKRHlyR0tkUFZoNkJGdWRMQ0hrVjBTYVQr?=
 =?utf-8?B?d1kvd0hZSzRYVjB0M04zSUZTNy9zQTZxeFRGY0tNcCtYSkkxRCtPcy9sd3VY?=
 =?utf-8?B?em1xTmQrM0dPRm01eklEamczS0RXbnF3bGNMM20xZnA1V0xtNEZwUC96ZUNX?=
 =?utf-8?B?N3EvWFpiN0FIUUYwQnpaSVZsMFhHQm80RlhxbllDRVZBK2o3cld2b1VjU2pu?=
 =?utf-8?B?OEpIc1pla25PMDZWWVJVR0xpL2lOYkFKcW16ZjZpeVhPV012VXpkQjdzeVNR?=
 =?utf-8?B?VEJ6T2FQdnNhaGR5UXJmVExNZjM4UU9mTGY5WUJzUFlWR0VlUHFjNHMvTEJM?=
 =?utf-8?B?d1Iramcrb2tMODEvSXNVbnhzWU9kOElvaloyRmI0NC90b0hZU3YzWmpVYXVq?=
 =?utf-8?B?WGFWZ2wxRlcrNjBPZERYc2RhNGR5bjVCeTBqL3hLOWtGbVBOT0swMXdmc202?=
 =?utf-8?B?MFJKcXo4MGlVTGt2T3RsQkZJbk5XUkxtVXltVHdlZkV6N2FZOFp5SGFRRmo1?=
 =?utf-8?B?TjYzVWlBZVVBVS9TZE54U2lRNEsrci9ONGJNMDRma3NFaEsvT2lKVDFPVkla?=
 =?utf-8?B?dTlOZ2tZaG9jUW5yVStGZm8zVk8ya1I3d0UvVU5yc0NzZzlGTC81NGt3ZW94?=
 =?utf-8?Q?NE1AWw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXdiL0E2eEk3T2V4c2ROYnVoM0QzcVlFdldrT3ZhQXk3MWtSS3NQbHAvc0py?=
 =?utf-8?B?T0EvK2RsNUlWSENNNjNnelI4Q0RON1dpRG1FU3FrNmVrbUJLekZFbnZONXlX?=
 =?utf-8?B?T0VBZ3NmTHVGcERCbTQzeU1acUt6eTBaTitBNHNjOTdCOEZnNW5HUXMyaFhz?=
 =?utf-8?B?V3lFT0RKK2k5V1N1NnkwZHY4Q05TeXd2M0hzRENzZUlmSkdDbHFhcTRVMENM?=
 =?utf-8?B?SDh6YmRDMVlFaDJlYVpWVUVuVnJpSnFUbWRrWFFsVVAyMC9LVldXZGFCWWFp?=
 =?utf-8?B?WlI3ekpSb0p6RjFDUUhHUlVFN2NRV0hka0ttSXEyMFIzakp6NkM1ZzB4WHBH?=
 =?utf-8?B?RGJmNHB2K0ttRC9VQmZ2dHJYcUdHYzZiUHAySlQ3QSt6Wnd3YlpycEpOeXFZ?=
 =?utf-8?B?dE1OWkE3bHl2dWk3VVVVNC8zV1ltYUtrckVyRGpsQWlnWnlIOVlsYVIrM3c0?=
 =?utf-8?B?TWdNSmVxbkRPQ2R0Wmlwc05keUo4Ulc4dXA1dUx1WEtVRHBlYTMwVS9wdThE?=
 =?utf-8?B?Q3cxc2k4QUVHSEVDZHZEL2JTcXg2TUZvcDQveHhVSG5oOEdETzJDNG4wV2Ez?=
 =?utf-8?B?S2dzVXQ1WTVkZURHckN3R2h3L2NFdDM1RytlVmVnWUMraW9aUGJaYXNYa1M3?=
 =?utf-8?B?R2Q2clcvRjhLb3Q3eXBRMVovZE9iUGtOR0NhdVlMaThSdWR4WVRrcHF5WERT?=
 =?utf-8?B?L1lCQml6V3IrSUdJUGtGSG1UdDBSS2pYd1RNY3g4RGZqbUV0VGZCbWNyNVBy?=
 =?utf-8?B?RXY4Mk51Ymh4a3NIc0QwNHNWUitFajZxcW1rbGt2WENpMGZ3YzdrNGI3T3k1?=
 =?utf-8?B?R3R3NE91bXJHa29mOTBPeXFlWGJ1WEFUQVJyR2RsODRBUVF3SWZEbW9JQkxB?=
 =?utf-8?B?ZEZiTkZuNkt0elZjVkhSUFFFVXVhZmV3SUtvSyt0RnlER1VwbHBlVk1yTWpJ?=
 =?utf-8?B?TVB0TjRaNVpJdzJLWVlQRnZ6R2N5R3h0cnl2UWU1c2YraXVFRDhmZ3ZnSHNG?=
 =?utf-8?B?dVlIYTQvbkJNM0pLT0pXZVRjWURzeWR6K2tDSHdTbDlxZkZjRGFYdzRqSC9t?=
 =?utf-8?B?a1pHeThHMEF1Q0NrM3N0eno2OFQ1Y2RsbTBtdVB0TWZ0alVBSkVlb3dZYTE3?=
 =?utf-8?B?cCtqVzg1anBaMU1qemxlOEhWOG9YNzJDUHIxWUZmbm1pazhMeVZ3MlVzZUo1?=
 =?utf-8?B?SUNZbkNnSXVibVZwRW1EZk9ZeHhlYkZYYXNqR1R5eUsvZFBKamhaVEdzQUJI?=
 =?utf-8?B?RmtrWlMzY1VRQnYxMnFKZ1JNTlRmb0xtNDhSYUl3aGRFSVh0TXRUVTBWVG1Q?=
 =?utf-8?B?SHIvVG8yY0p3UFdmMW5CTjZTek5Ubys4amFxeHJ2dkZmVTlocGVmc0NUUW9R?=
 =?utf-8?B?QkVpWWRKbEpiVjFZaG5lQktaZDN3ckgvZ3FVUFV5eW5abWs1K09aWGRZSkp5?=
 =?utf-8?B?VHRLQ0pRZU43UFNyVGNjc0s3czd4YUpxT3htdC8yWDFRZDRYcTR0dE5xdW03?=
 =?utf-8?B?Nm40ZkEyMTg4ejdkUXk1RUx3dXEwKytvNjZKOVlpdXBtTGh6OWgvMWI5aXhh?=
 =?utf-8?B?TDFKdjhOMXZuZTNmL2dMeGtndm5oOWVYeHJHM2ZSWGt1ajZDdkNxOGlSNEdS?=
 =?utf-8?B?ZzlXR2hmenhZaXU3WDhXdTBXRDkvYXl2bmR0cGI4TmJGZk44UTNZUlZwb0FT?=
 =?utf-8?B?eWpSQVhFZDY5Nk1RTTRnSHM2VWw4eWFjd1NicWI3bHI1UklrLytDZ1Nmai8r?=
 =?utf-8?B?a2UrRU5kUWFjMyt0NXRWcTNWVTdRQm1wRnlHVkRoaUU5QkU1R3h5ZWhWTUw2?=
 =?utf-8?B?MDRDS1RIbkQ2MU9VT1FWZVdRVFFKM2JFY3UydURVTXFTVXNHZFdSMkY3WTl0?=
 =?utf-8?B?WExENGdEYUxYekFsNGNPK1kvdTdGV25YYlVDbUdZQ3YwZy91LzVVSkR3anQ1?=
 =?utf-8?B?UmlRditwV00xLzloQzdwL0tVaERjUmxsWWZCbkdJMXJxR0I2MHl6WHFWUDkv?=
 =?utf-8?B?N2s4WnppNkp2WUFKZzhVRTJCZVU2aCtJd21ObUphaE5Ddzl0M0xOZE5sWG9K?=
 =?utf-8?B?T0RrdDNMcmZyUkM3UFNmMllXZit6Y0IvRm1QNGlJOFZEZ1FWZXF6ekNPcEFi?=
 =?utf-8?Q?s1OKVxOoayzStYEItE9DQj9i8?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e922c45-33ae-44b7-dfbc-08dd90f439fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:27:57.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8W3LBwBszZMzSWaAnXLMmnTOKb8JnxdytF2KTj+5gSv4E3qvXZPpWcA7bEzPMn5xOoDvCoVc9zHU6yuUUYIgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-Proofpoint-GUID: gsKMhESWx9sOL6DUKZIUNzsiev6eN544
X-Authority-Analysis: v=2.4 cv=TMNFS0la c=1 sm=1 tr=0 ts=68214ea2 cx=c_pps a=gIIqiywzzXYl0XjYY6oQCA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=Rk4gN3osmKOhVC5ZJK8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gsKMhESWx9sOL6DUKZIUNzsiev6eN544
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfXwKAO41F1LK3o I/jddgqxaned5sz6Pa4ePTHTmqPP9yYSGNJnJuHjFDIU5v7QoBqwGSRMMAJC9ABiomUMkTHkPyQ 6zKKY48Ei7coaZqiiexUYy9CYFKdFG6/lk+XYddX7u1v9kiKt5TWj6geYLe0ikgXaaST459ZTCm
 4Ko6e0T4L8h1wKiAG/owk2RmG3aMTMabV5CqCX3aSc+TGxhjFl5r+HZxNU9r+Yf+2uH2dugyPCC dKVAspPni0Qk43LP0juhD5YzQ1EPOMwLsEKHqmc6qwC+ojGXl17Ws+CfTTtT9+a2cXeoQKEhaH6 CoShWX/lAZR+wcBzFHtOQ6sMELP4xw1sVV69ppb5MisZQkSRtzno4o2n5KKURQxUyl79t2kQN4u
 Uq/G891nvcKou23qcTfc6UCf4CDC22k5MM19vZkrbPV5UR5XHi7xWZghHmqJ6NI963c+oB8U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

Hi,


This patchset brings initial support for Silicon Labs CPC protocol,
standing for Co-Processor Communication. This protocol is used by the
EFR32 Series [1]. These devices offer a variety for radio protocols,
such as Bluetooth, Z-Wave, Zigbee [2].

Some of the devices support several protocols in one chipset, and the
main raison d'etre for CPC is to facilicate the co-existence of these
protocols by providing each radio stack a dedicated communication
channel over a shared physical link, such as SPI or SDIO.

These separate communication channels are called endpoints and the
protocol provides:
  - reliability by retransmitting unacknowledged packets. This is not
    part of the current patchset
  - ordered delivery
  - resource management, by avoiding sending packets to the radio
    co-processor if it doesn't have the room for receiving them

The current patchset showcases a full example with Bluetooth over SPI.
In the future, other buses should be supported, as well as other radio
protocols.

For the RFC, I've bundled everything together in a big module to avoid
submitting patches to different subsystems, but I expect to get comments
about that and the final version of these series will probably be split
into two or three modules. Please let me know if it makes sense or not:
  - net/cpc for the core implementation of the protocol
  - drivers/bluetooth/ for the bluetooth endpoint
  - optionally, the SPI driver could be separated from the main module
    and moved to drivers/spi

I've tried to split the patchset in digestible atomic commits but as
we're introducing a new protocol the first 12 commits are all needed to
get it to work. The SPI and Bluetooth driver are more standalone and
illustrates how new bus or radio protocols would be added in the future.

[1] https://www.silabs.com/wireless/gecko-series-2
[2] https://www.silabs.com/wireless

Damien Riégel (15):
  net: cpc: add base skeleton driver
  net: cpc: add endpoint infrastructure
  net: cpc: introduce CPC driver and bus
  net: cpc: add protocol header structure and API
  net: cpc: implement basic transmit path
  net: cpc: implement basic receive path
  net: cpc: implement sequencing and ack
  net: cpc: add support for connecting endpoints
  net: cpc: add support for RST frames
  net: cpc: make disconnect blocking
  net: cpc: add system endpoint
  net: cpc: create system endpoint with a new interface
  dt-bindings: net: cpc: add silabs,cpc-spi.yaml
  net: cpc: add SPI interface driver
  net: cpc: add Bluetooth HCI driver

 .../bindings/net/silabs,cpc-spi.yaml          |  54 ++
 MAINTAINERS                                   |   6 +
 drivers/net/Kconfig                           |   2 +
 drivers/net/Makefile                          |   1 +
 drivers/net/cpc/Kconfig                       |  16 +
 drivers/net/cpc/Makefile                      |   5 +
 drivers/net/cpc/ble.c                         | 147 +++++
 drivers/net/cpc/ble.h                         |  14 +
 drivers/net/cpc/cpc.h                         | 204 +++++++
 drivers/net/cpc/endpoint.c                    | 333 +++++++++++
 drivers/net/cpc/header.c                      | 237 ++++++++
 drivers/net/cpc/header.h                      |  83 +++
 drivers/net/cpc/interface.c                   | 308 ++++++++++
 drivers/net/cpc/interface.h                   | 117 ++++
 drivers/net/cpc/main.c                        | 163 ++++++
 drivers/net/cpc/protocol.c                    | 309 ++++++++++
 drivers/net/cpc/protocol.h                    |  27 +
 drivers/net/cpc/spi.c                         | 550 ++++++++++++++++++
 drivers/net/cpc/spi.h                         |  12 +
 drivers/net/cpc/system.c                      | 432 ++++++++++++++
 drivers/net/cpc/system.h                      |  14 +
 21 files changed, 3034 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/silabs,cpc-spi.yaml
 create mode 100644 drivers/net/cpc/Kconfig
 create mode 100644 drivers/net/cpc/Makefile
 create mode 100644 drivers/net/cpc/ble.c
 create mode 100644 drivers/net/cpc/ble.h
 create mode 100644 drivers/net/cpc/cpc.h
 create mode 100644 drivers/net/cpc/endpoint.c
 create mode 100644 drivers/net/cpc/header.c
 create mode 100644 drivers/net/cpc/header.h
 create mode 100644 drivers/net/cpc/interface.c
 create mode 100644 drivers/net/cpc/interface.h
 create mode 100644 drivers/net/cpc/main.c
 create mode 100644 drivers/net/cpc/protocol.c
 create mode 100644 drivers/net/cpc/protocol.h
 create mode 100644 drivers/net/cpc/spi.c
 create mode 100644 drivers/net/cpc/spi.h
 create mode 100644 drivers/net/cpc/system.c
 create mode 100644 drivers/net/cpc/system.h

-- 
2.49.0


