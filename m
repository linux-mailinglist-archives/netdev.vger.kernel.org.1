Return-Path: <netdev+bounces-189617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F40AB2D23
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC7C3BD546
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A313C217701;
	Mon, 12 May 2025 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="kzP9b3Zk";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="FRRJRNS4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C4211488;
	Mon, 12 May 2025 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013309; cv=fail; b=nt/QJXHMGF9cr78yAkdcdL3mrmJugeKgZL6JYTtvREglmCNSDKm62N9+9Rd8Mj1f0vqXXsL1AxWIddDbhs4aPjDNZp/Ku21qyKDUkaEFwG3yJey2B6EsvSxAa5SsKdczxJa3h7EJ/N91TZKOH+aaObmmPp19S2NAD4BKvFEYlNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013309; c=relaxed/simple;
	bh=762PqNg5mQV/ZsEEt7A4Sv7P8C3+tUoF98+osHGv0nk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=striFrDkQQWbIAg8Oo2nsnUA3IZglRdFw7IY2Tv06GVSBO7xDemsJ5sRiuUV/TWp2YxIjLEE/5rMuZFhRb44jgWcJWhsawBT+ZmZ3Abea85j3Ny9V47YQYwSQG6KJ0ZXjOrnBgzykd0P5tqBQfJNwioS9oXq3/HvimJzFsRJqXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=kzP9b3Zk; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=FRRJRNS4; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C0dSZE021480;
	Sun, 11 May 2025 20:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=X1RZOjcznezFd9unJ9Co5hH7dmX96NN4Uf02y23T+vA=; b=kzP9b3Zk3eBZ
	dbR3vsTp18mv0/AvVEcs32WvkslnZUio3GV1xI9qT5PEcyHBe3oC60My39nA815r
	JLB0QZU1nB1er8dr4k/1my//4eE73OUDV8/qcLO/mDlRiYneo1vQ97Kvlmp2Llwf
	7mgegtMQZbjG2ijhYWu/i84aUbCh6nRZpBINE/XhyuOpm9B9N5gNMgMDdawCdT1R
	Dgtdj/VF1P9VLEZIUp7NrPnooN/lvOJzP5rwjGhqIB/DEM8VuclsdtrdZGY4oXPV
	qPLv3nzppeX5LrgZd4RZP10h1TPaCYZJ9w3vl198+HUYh57U51IDa9wiPz34AKt+
	iGg//OOFOw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j34csvw6-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLybjehF85e3iDwkAoBaUEwOEDwP/wg/sxfpf6Pz7+4Iu5pv14c60Glc9zw1WaMwhz53zR4gogVSJcpc1hdijxWbnSLi8GaVu1/Kedz13zSLc7WDBQHEVcutZwEozKEKC4vngO+j7QrgYmt2qyAAclSMnlBEfJk0qShWZVPUg1JZFACwuuc+AwkEXVWM1nKaS2BLKHq8FzOqkX5iGEs76I9M/7xlniZAG0YTPqTmo4x3HQLy+7Lvwm9v5PIBGj/lmi87DPf7OMoCi2lZULNr5DRWSI1UTQwkO2Solxf761NhHZrX6XFbjfYEq7SZeqtunCLBTDfQV5to1205l8JeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1RZOjcznezFd9unJ9Co5hH7dmX96NN4Uf02y23T+vA=;
 b=ZdIxnJxVVMv+btsxobIgSzh7yFuvePL8IlY0b2LRh6qlhX0sO2fXe1OpeeX003eo0BFwedM9xIhUHmhTplGDTZEtlappFfnRw/Fk5kE0G3Ih/ScqlXx6+znwEGd+U+zbXk/sqEEDYYeJ60CMG4R0j4idS3Ob6cuQOZP4YtG01kLSliWDSi/XQ69AjIqHCtUnCVaxzMymUqvtHFlphv896nWO6VFIESwtm1cwVnMuuKYAKSE9laW5SQu5V26ybS6wtXdoC4BiQpxC0WNZsbu+ncsLzloLJRwK22drxSosLPlrmE/PKLkt7D0t9QlPGv6B80BL9pcYumD8xSEW2g+u/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1RZOjcznezFd9unJ9Co5hH7dmX96NN4Uf02y23T+vA=;
 b=FRRJRNS4pW6zvobcWq9K/FLQ/yhDVmDBNgjz/LQ4wTMOazEKPKZV2GMpgGZH+i3oY276mHKA29GTgW9FGh6oErrRa6qYVhxN6EeV6EQits/uYhUgj34UEiuzex/sT549Sg4VEV3aa2k7RL246bVc3lHICX/Y9y7/I1/gCH3/9JE=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 01:28:03 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:28:02 +0000
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
Subject: [RFC net-next 07/15] net: cpc: implement sequencing and ack
Date: Sun, 11 May 2025 21:27:40 -0400
Message-ID: <20250512012748.79749-8-damien.riegel@silabs.com>
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
X-MS-Office365-Filtering-Correlation-Id: 38039ef1-3ea1-4103-9186-08dd90f43d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0ZLVFlCbnR3MGtoME4rTFpGSm1ja0h2T21XNVovQ0I2RjZSWGVqWW5VUlZK?=
 =?utf-8?B?SFZ3MS9tUzY1YVZ4T0JmeDVrMjNDWE55bmV2K200VlpXWHU3Q1lQcGM4a0tx?=
 =?utf-8?B?aXVVSHgzOVM3amVMaHMwWDdLNk1sRHg2ZlE3Zng3TkZhMGVUb29BckJBNGo0?=
 =?utf-8?B?RFJDYlNrbUd6NmVNNDBjWURrM1JYQjdlVFV2QVhCVzJMZGFrdXp4dm9kZjZx?=
 =?utf-8?B?YlVpbm5jTGNUOEVRUlpGeFpON09Zclp0Wi9zcTNFYXdkUXZZVTZlWkRZSXlu?=
 =?utf-8?B?VVY5Yi9sQWNEVzlwdktTMnJqRVJVMEJOOWtQdjU3bWdGNnREOVl6bitpOWtk?=
 =?utf-8?B?Q2hoRTlRNFU2WmpON3psVm9JRG8ydG43NnJ4R2RpNWtCTTJGN1JGQzllZC93?=
 =?utf-8?B?TlVleXNZQW02WFhHYzgxQTlCVUp3K0N6V2RhSlRKVzhnd20zdmVyWStQOW9l?=
 =?utf-8?B?aDRFc0dNenRkR1dxdG1pK3VXYndhRnZBOWljeE43SHM4K1N1MFRjMmxRZGNY?=
 =?utf-8?B?T0RrdnZkcFN2TXR2YTdDQXk4S2NDZWwvWTVNN1NSSjBWVGVhWDRkdGpWZTlU?=
 =?utf-8?B?ZUlkNVFTSHB5VDV1K1FlL3RLR3RZbTM4QTNJOC94TDJCY1BjMnJueWNrOVd2?=
 =?utf-8?B?eERoZVBnTE1kSU5MVEpxMGpOc2tiMDh4MXFvWWRGWjJDV0xkbmFUYzF5c09L?=
 =?utf-8?B?RENMM1pqTHNaV08yV0hTUmJtTm9WdGJaYjE0aUxINWNhQzBFWVluWmRKOGtr?=
 =?utf-8?B?ZTZBR2tSZ2tiQ3c0SzJDSnI5MWZUMnpIa2dycUF3TXcrY2t5RFl3Wmo1Y0V2?=
 =?utf-8?B?MXRyTE9QdXpuT2NHbWM5cnpoRGtBVE9YNUhyWVNsV3NIMDdlYSsvb2hnWE1n?=
 =?utf-8?B?akxZbG9FUzNZeDA0eUpuSDRCVGhKZ3dsMjAvM1FvaXRBeTMwQ2ZmVXN0dmR3?=
 =?utf-8?B?eEZNMUZyeEdCWnBLVndPMnJRRFBSNGhKWGdNbGhJVnZIcVRmeXN3eVUxMjBU?=
 =?utf-8?B?Uy8xdjZSQ3Q1U25HTFVTN0FDWVhBN1pqUExjTDVJSHVhTWVqS0RhYTFzWVRO?=
 =?utf-8?B?UHFPUjFmTzRZTmozcEtUWFZ2MlJkQTY3OWQ2VXEyRC9wR1dFeTc1TnVYMVBY?=
 =?utf-8?B?WUcxaTdqaVFzUW9heFZjRFVJdWpJRk5YL0RtVGprOFFqVFZVRHFxNzdDeVJD?=
 =?utf-8?B?QlZsUU9xNHpiOU1YYUZUVkpRUng5cURXdVBsR1BWMFRIUElCcTdmbUV6RThM?=
 =?utf-8?B?ai91VVVQclcwUDMwSi84aTl4TXpTbzl5Yy8xLytlcnhkQjJDTzFpVG5hR3NI?=
 =?utf-8?B?cWJxaEl2VjZZYVExUlJmN3lLQzJlTHpDZCtqekxIMWhzakdLd0laVFZHSlI5?=
 =?utf-8?B?UGFJWEVwbWxVdEk0WXZYT2F3aWQxTHNlc2VaRTdWNWRYK3FsQnJacWo0MEwv?=
 =?utf-8?B?ZEpndlgweStvTUFFK3k1REgxdkxvNkV3WE5zVythVUluUFNGUGtMaldHU2xI?=
 =?utf-8?B?Sm1OY2o2MTVDTUdZZEVHUnZzMkRtYWZqb29wZThPMWFzQTJjbm9kWnZIWFcr?=
 =?utf-8?B?T0lpQzFIV0lhbktaVmZhWmdNYW1JK0l3aThMWFQ4TWtWTE91eFBVUWVIOUtS?=
 =?utf-8?B?bThZUEhxZ1lrSWZFTG9lT0dqclQ3Z1NhOHd0eHlzVUU2UWdqSE00VThKbkJZ?=
 =?utf-8?B?TXlsOEdxZHRzU0Z2UVpzYVorSmdIYllRNEl0TmNKMVkwd29lM01rWjVZdGMz?=
 =?utf-8?B?VTVvelI0ZVFnQW9tNFRQSGhFQWdybnFrMkJ2Z0JRS29GcjViVE50OXZ1c3JN?=
 =?utf-8?B?N1doQUZGME11Z0FrWGdDczQ4MU1RejlBUm9YRWJwblA5VSs0dkJYSGlmaUpJ?=
 =?utf-8?B?MUpMTmpnT0NnZ08xaU80bzRsaStGQkVOZmoyeHp0SzRFR1MyVFdubTAwNXFT?=
 =?utf-8?B?TVZwS0NMVHNpUlU0Qmx4VDk1SGdPUFVOSjdOS1JDUVlza1dheFMzOWEvNzZN?=
 =?utf-8?Q?JcP7XUh+4+ysJuGY/V0HEXzaFzwYRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFlacEoyWmVEZGs4cllnWndvNDExVSttUFNrR04yNzlTM2QzdExLVXl3ZHRV?=
 =?utf-8?B?TGlibm1POWRJVmZGWHVMNUxvaHFOVWkyR3QrYnNNQTBGeVIrclNkMUMwODlm?=
 =?utf-8?B?eno4T2VDcXVGR1hlUTVKTlFDUmZHVnA3WHg1L1dYa2J5MEwyWEtJQVZkaEFU?=
 =?utf-8?B?cndiMjh5SmRXUWJpbXpYR0NsRnhtbUhmNjdZVzE5aEV0SDlrUGJtR1IyZDhu?=
 =?utf-8?B?NktxRTdiZitGc1JSSHMwQWUrZVB5NFp3Rm9tVSsrT3QvLzRZK3JzMWROY2Z2?=
 =?utf-8?B?bGhOMG5TQVFseHYva1pJQ2EwaWNMWWw1eGNiZlRKNjl1c2JqSUt0TENQdndM?=
 =?utf-8?B?VTlSNXlxOGtOdzRqL1krL3FMazArNXdkNzE4dEV0YU9GSVZSeXZxbXowSFMz?=
 =?utf-8?B?S1B5NjY2Y0pxMEw4NWtjVjlCNUhaWDBTQVVFdnVUbGsxWjFBODlUSHhXOHdC?=
 =?utf-8?B?UUJYR2l4RW1mQVFFbTJER09tdmp4RGRlNVhrT0tZWkhWYVZxelRLTEpiQ3Br?=
 =?utf-8?B?aHd4Qlc2TEdJb0VmMnpveVVQZHFCbmlFS0ZTZnIxVndkbXduWVRrWWdlTXEy?=
 =?utf-8?B?TnRzT1FWZjJNMlFjQXJUekFjaHdZeFBxK3gvbnlWM2tsUXNkb2FMV1l6Znhi?=
 =?utf-8?B?T3ZkK0tUWUZKZDVIQkx4a0h0UU1zbnRSZERGOU82VWtFT0s5dGVSNHBJQmZ4?=
 =?utf-8?B?L3ZSbWMrY0FwWEVkMlNOQWl5aEFqeEFjaUR3ejB0amhKdjVnbjltNTUydG9a?=
 =?utf-8?B?OWFxeXloTjRiZGptQVBPR0t0SzZFR2pVMFlGRUNxditkSUthSFRadEZEOVpo?=
 =?utf-8?B?U1ppSUphRjdLMHhCalN4aGVIaWhvUVd3MlNkWUx4V0QrNmdvQmMrd3VHUU81?=
 =?utf-8?B?d1pka3ZvUStvd3AzdmJvZG1TS3FLSkR4Mk10dDBiRElpQ2ZVZUkvMFI3eUxK?=
 =?utf-8?B?SUxYa1o5MG9wMDhnbkVtNmNHUDFQMkhXOTVJdkxpaDdocit4aXBVRHdxdFpK?=
 =?utf-8?B?TGROaW9Udk4vc1UxYllBZFdybTFBT3grRTFtNVBENUtwODJMblNnMnNSWHpn?=
 =?utf-8?B?R2ppeFBYM3VyZ083ZlRhWVFKN2tzRmdkL1AxZThTNjJNMDE3Q1BBQXd4OTF1?=
 =?utf-8?B?OEFGazlMc0YxYStSdUc4Y2EwTHQvQ01aU3NsN0dmdjYrSDZvdnRGZHQxTlZy?=
 =?utf-8?B?QU4wVU5Bem9PSWNsYU4zUHFGQnk2UFpjeDVPSFF4Q1A5YWpwbTY5KzhjVnZB?=
 =?utf-8?B?eXYvbW1yYVI2NTRXZE1EczlzUTAvUlhDdVZyTkVMU3ZQZCs1b3NmMk85eW5D?=
 =?utf-8?B?YS92U0ExbkQzbGJJU2Z2ZXUwZ2VtZ3paVysrUytkN2JoTmdyUzhnQ0QvbGF3?=
 =?utf-8?B?dDNRKytHcmx1M1lRMTQ0QVBxOStudXBWUXdTMXdGOTQzdGxscGFzN0xRSUNu?=
 =?utf-8?B?cVVSS2d6RWZ3bDBtT1hwdzFwUmptZ2FjR00yWTQ2a2JERDkvSGJOWDVJZzNk?=
 =?utf-8?B?RUFpcXYxYjF5cUFmMWV5bUFOcDhEOVpkTE00eG1wR04xNWZpL2ZpTDFSSWNS?=
 =?utf-8?B?dCtsektMaVZZQ2tmNFhTTkdRZkR0UFhSUGNLV3FmbngrRHh2MkhFbkM3alZK?=
 =?utf-8?B?RGkzNGlRc1dOb1pMODgzTnVuMTNBR09aNG5SbER0Q2h1dzRqYWtmRGlEMmdB?=
 =?utf-8?B?bjFGM2JlSDZxZ2JvRWNuWGw2YThLQjlNYnVLTzkwVXhWYVc0Q3hkQk5rUWpF?=
 =?utf-8?B?UDB4cHZzemd5M0p3Tzh4d3U3Q2VMZ3ArVEdaWGF1RkFoRUlrQVF6c2k2UCtJ?=
 =?utf-8?B?SDRpVmYzd0pUdVN3eXVVUVBWR1l1WStoSEMxSXRkUUxuTlFuaWhwbW5TU29r?=
 =?utf-8?B?VGFESWlJd3VZSXpOeGdHSmZ4TlhmaUpnWVNaQnk4T3BQcmUwdjU4Q3lSTWNC?=
 =?utf-8?B?S2Q2TGw4SHhWdy84N2dvTXhLMVpHempCTER3amxrYTBOc2l1UldtenRqYk5Q?=
 =?utf-8?B?d2d4NzBOQTJoa1JEelcrbUxkU29kSTVRaXh6cUFtNGEyMG9QemhjeXRBbFoy?=
 =?utf-8?B?aCtWVDFzdE91a3dLZHNmck1yVFZwMktBWjZxNlJzR3hhSlVIMzMyM2UwUUNp?=
 =?utf-8?Q?Yu9GaKqmfrz2HYhudIdJvaA/i?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38039ef1-3ea1-4103-9186-08dd90f43d0f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:28:02.9139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RTFLo06W0TK5A7hWLXsrExUDkAOE8lETf6AB8EeMARLHjNBeZZK974V5dyFhuzr1ZXdusQSu2I55JsOhSV20Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-Proofpoint-GUID: 5IoJNtqibDveoP4PnvIu81KHFel8-5cE
X-Proofpoint-ORIG-GUID: 5IoJNtqibDveoP4PnvIu81KHFel8-5cE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX+SzjMKNQaGvK Crf9UZ12cptreIi2ugsDVyIrIs9nyHdx4ZZyf6J04FzOCceQfI6dbmg56aTx2a+11CXV1CoZbMS CllNIopkrFFSeBU2eNh8KNH9wMiqp419W1iNZmkfp9/Rz8twnyM6B92KTZROX7UcuMB3SSfohX9
 IrujrpWdb40mRXRz+NUq0iIQI5pEWBuou5YhwRaCkFcZPp32rPY4OOPTqUua362sygyM9C4pWZZ 8uoBsh4yN1c5/H9xpQtuuY3SrSm3VHkfv+iI5uhVqLTHuhVFf8V4Uw9AB8NcUFj/MWbrGk6nehN zwxWSsy5cCO2ho8zmlbh3uEr3PM4WJbSSjOWOGRMH4lLuMYBrhqq2TflSztAXfLI1AfkhcgPikL
 F60iAOUBMfkfDRdG5B8GyIpqSkgpclju2smQyAsPeNDVX8sJ8IqLYkz8ypdK07G9ACRBy06A
X-Authority-Analysis: v=2.4 cv=L/gdQ/T8 c=1 sm=1 tr=0 ts=68214ea6 cx=c_pps a=X8fexuRkk/LHRdmY6WyJkQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=Y9oiwHhhYaTOX2ZSGccA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

CPC frames are sequenced and must be acked by the remote. If not acked
in a timely manner, they should be retransmitted but that feature is not
part of this commit.

Another key feature is that peers advertise how many frames they can
receive. As the remote is usually a microcontroller with limited memory,
this serves as a way to throttle the host and prevent it from sending
frames that the microcontroller is not yet able to receive. This is
where endpoint's holding_queue becomes useful and serves as storage for
frames that endpoint is ready to send but that the remote is not yet
able to receive.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 drivers/net/cpc/cpc.h      |  26 +++++++++
 drivers/net/cpc/endpoint.c |  24 ++++++++-
 drivers/net/cpc/protocol.c | 108 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/drivers/net/cpc/cpc.h b/drivers/net/cpc/cpc.h
index dc05b36b6e6..94284e2d59d 100644
--- a/drivers/net/cpc/cpc.h
+++ b/drivers/net/cpc/cpc.h
@@ -18,6 +18,27 @@ struct cpc_endpoint;
 
 extern const struct bus_type cpc_bus;
 
+/**
+ * struct cpc_endpoint_tcb - endpoint's transmission control block
+ * @lock: synchronize tcb access
+ * @send_wnd: send window, maximum number of frames that the remote can accept
+ *            TX frames should have a sequence in the range
+ *            [send_una; send_una + send_wnd].
+ * @send_nxt: send next, the next sequence number that will be used for transmission
+ * @send_una: send unacknowledged, the oldest unacknowledged sequence number
+ * @ack: current acknowledge number
+ * @seq: current sequence number
+ * @mtu: maximum transmission unit
+ */
+struct cpc_endpoint_tcb {
+	struct mutex lock; /* Synchronize access to all other attributes. */
+	u8 send_wnd;
+	u8 send_nxt;
+	u8 send_una;
+	u8 ack;
+	u8 seq;
+};
+
 /** struct cpc_endpoint_ops - Endpoint's callbacks.
  * @rx: Data availability is provided with a skb owned by the driver.
  */
@@ -32,6 +53,8 @@ struct cpc_endpoint_ops {
  * @id: Endpoint id, uniquely identifies an endpoint within a CPC device.
  * @intf: Pointer to CPC device this endpoint belongs to.
  * @list_node: list_head member for linking in a CPC device.
+ * @tcb: Transmission control block.
+ * @pending_ack_queue: Contain frames pending on an acknowledge.
  * @holding_queue: Contains frames that were not pushed to the transport layer
  *                 due to having insufficient space in the transmit window.
  *
@@ -48,6 +71,9 @@ struct cpc_endpoint {
 	struct list_head list_node;
 	struct cpc_endpoint_ops *ops;
 
+	struct cpc_endpoint_tcb tcb;
+
+	struct sk_buff_head pending_ack_queue;
 	struct sk_buff_head holding_queue;
 };
 
diff --git a/drivers/net/cpc/endpoint.c b/drivers/net/cpc/endpoint.c
index 51007ba5bcc..db925cc078d 100644
--- a/drivers/net/cpc/endpoint.c
+++ b/drivers/net/cpc/endpoint.c
@@ -20,12 +20,26 @@ static void cpc_ep_release(struct device *dev)
 {
 	struct cpc_endpoint *ep = cpc_endpoint_from_dev(dev);
 
+	skb_queue_purge(&ep->pending_ack_queue);
 	skb_queue_purge(&ep->holding_queue);
 
 	cpc_interface_put(ep->intf);
 	kfree(ep);
 }
 
+/**
+ * cpc_endpoint_tcb_reset() - Reset endpoint's TCB to initial values.
+ * @ep: endpoint pointer
+ */
+static void cpc_endpoint_tcb_reset(struct cpc_endpoint *ep)
+{
+	ep->tcb.seq = ep->id;
+	ep->tcb.ack = 0;
+	ep->tcb.send_nxt = ep->id;
+	ep->tcb.send_una = ep->id;
+	ep->tcb.send_wnd = 1;
+}
+
 /**
  * cpc_endpoint_alloc() - Allocate memory for new CPC endpoint.
  * @intf: CPC interface owning this endpoint.
@@ -55,6 +69,10 @@ struct cpc_endpoint *cpc_endpoint_alloc(struct cpc_interface *intf, u8 id)
 	ep->dev.bus = &cpc_bus;
 	ep->dev.release = cpc_ep_release;
 
+	mutex_init(&ep->tcb.lock);
+	cpc_endpoint_tcb_reset(ep);
+
+	skb_queue_head_init(&ep->pending_ack_queue);
 	skb_queue_head_init(&ep->holding_queue);
 
 	device_initialize(&ep->dev);
@@ -195,6 +213,8 @@ int cpc_endpoint_write(struct cpc_endpoint *ep, struct sk_buff *skb)
 	struct cpc_header hdr;
 	int err;
 
+	mutex_lock(&ep->tcb.lock);
+
 	if (ep->intf->ops->csum)
 		ep->intf->ops->csum(skb);
 
@@ -202,10 +222,12 @@ int cpc_endpoint_write(struct cpc_endpoint *ep, struct sk_buff *skb)
 	hdr.ctrl = cpc_header_get_ctrl(CPC_FRAME_TYPE_DATA, true);
 	hdr.ep_id = ep->id;
 	hdr.recv_wnd = CPC_HEADER_MAX_RX_WINDOW;
-	hdr.seq = 0;
+	hdr.seq = ep->tcb.seq;
 	hdr.dat.payload_len = skb->len;
 
 	err = __cpc_protocol_write(ep, &hdr, skb);
 
+	mutex_unlock(&ep->tcb.lock);
+
 	return err;
 }
diff --git a/drivers/net/cpc/protocol.c b/drivers/net/cpc/protocol.c
index 91335160981..92e3b0a9cdf 100644
--- a/drivers/net/cpc/protocol.c
+++ b/drivers/net/cpc/protocol.c
@@ -11,15 +11,54 @@
 #include "interface.h"
 #include "protocol.h"
 
+static void __cpc_protocol_send_ack(struct cpc_endpoint *ep)
+{
+	struct cpc_header hdr;
+	struct sk_buff *skb;
+
+	skb = cpc_skb_alloc(0, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	memset(&hdr, 0, sizeof(hdr));
+	hdr.ctrl = cpc_header_get_ctrl(CPC_FRAME_TYPE_DATA, false);
+	hdr.ep_id = ep->id;
+	hdr.recv_wnd = CPC_HEADER_MAX_RX_WINDOW;
+	hdr.ack = ep->tcb.ack;
+	memcpy(skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
+
+	cpc_interface_send_frame(ep->intf, skb);
+}
+
+static void cpc_protocol_on_tx_complete(struct sk_buff *skb)
+{
+	struct cpc_endpoint *ep = cpc_skb_get_ctx(skb);
+
+	/*
+	 * Increase the send_nxt sequence, this is used as the upper bound of sequence number that
+	 * can be ACK'd by the remote.
+	 */
+	mutex_lock(&ep->tcb.lock);
+	ep->tcb.send_nxt++;
+	mutex_unlock(&ep->tcb.lock);
+}
+
 static int __cpc_protocol_queue_tx_frame(struct cpc_endpoint *ep, struct sk_buff *skb)
 {
+	struct cpc_header *hdr = (struct cpc_header *)skb->data;
 	struct cpc_interface *intf = ep->intf;
 	struct sk_buff *cloned_skb;
 
+	hdr->ack = ep->tcb.ack;
+
 	cloned_skb = skb_clone(skb, GFP_KERNEL);
 	if (!cloned_skb)
 		return -ENOMEM;
 
+	skb_queue_tail(&ep->pending_ack_queue, skb);
+
+	cpc_skb_set_ctx(cloned_skb, cpc_protocol_on_tx_complete, ep);
+
 	cpc_interface_send_frame(intf, cloned_skb);
 
 	return 0;
@@ -28,10 +67,19 @@ static int __cpc_protocol_queue_tx_frame(struct cpc_endpoint *ep, struct sk_buff
 static void __cpc_protocol_process_pending_tx_frames(struct cpc_endpoint *ep)
 {
 	struct sk_buff *skb;
+	u8 window;
 	int err;
 
+	window = ep->tcb.send_wnd;
+
 	while ((skb = skb_dequeue(&ep->holding_queue))) {
-		err = __cpc_protocol_queue_tx_frame(ep, skb);
+		if (!cpc_header_number_in_window(ep->tcb.send_una,
+						 window,
+						 cpc_header_get_seq(skb->data)))
+			err = -ERANGE;
+		else
+			err = __cpc_protocol_queue_tx_frame(ep, skb);
+
 		if (err < 0) {
 			skb_queue_head(&ep->holding_queue, skb);
 			return;
@@ -39,8 +87,64 @@ static void __cpc_protocol_process_pending_tx_frames(struct cpc_endpoint *ep)
 	}
 }
 
+static void __cpc_protocol_receive_ack(struct cpc_endpoint *ep, u8 recv_wnd, u8 ack)
+{
+	struct sk_buff *skb;
+	u8 acked_frames;
+
+	ep->tcb.send_wnd = recv_wnd;
+
+	skb = skb_peek(&ep->pending_ack_queue);
+	if (!skb)
+		goto out;
+
+	/* Return if no frame to ACK. */
+	if (!cpc_header_number_in_range(ep->tcb.send_una, ep->tcb.send_nxt, ack))
+		goto out;
+
+	/* Calculate how many frames will be ACK'd. */
+	acked_frames = cpc_header_get_frames_acked_count(cpc_header_get_seq(skb->data),
+							 ack,
+							 skb_queue_len(&ep->pending_ack_queue));
+
+	for (u8 i = 0; i < acked_frames; i++)
+		kfree_skb(skb_dequeue(&ep->pending_ack_queue));
+
+	ep->tcb.send_una += acked_frames;
+
+out:
+	__cpc_protocol_process_pending_tx_frames(ep);
+}
+
 void cpc_protocol_on_data(struct cpc_endpoint *ep, struct sk_buff *skb)
 {
+	bool expected_seq;
+
+	mutex_lock(&ep->tcb.lock);
+
+	__cpc_protocol_receive_ack(ep,
+				   cpc_header_get_recv_wnd(skb->data),
+				   cpc_header_get_ack(skb->data));
+
+	if (cpc_header_get_req_ack(skb->data)) {
+		expected_seq = cpc_header_get_seq(skb->data) == ep->tcb.ack;
+		if (expected_seq)
+			ep->tcb.ack++;
+
+		__cpc_protocol_send_ack(ep);
+
+		if (!expected_seq) {
+			dev_warn(&ep->dev,
+				 "unexpected seq: %u, expected seq: %u\n",
+				 cpc_header_get_seq(skb->data), ep->tcb.ack);
+			mutex_unlock(&ep->tcb.lock);
+			kfree_skb(skb);
+			return;
+		}
+	}
+
+	mutex_unlock(&ep->tcb.lock);
+
 	if (skb->len > CPC_HEADER_SIZE) {
 		/* Strip header. */
 		skb_pull(skb, CPC_HEADER_SIZE);
@@ -74,5 +178,7 @@ int __cpc_protocol_write(struct cpc_endpoint *ep,
 
 	__cpc_protocol_process_pending_tx_frames(ep);
 
+	ep->tcb.seq++;
+
 	return 0;
 }
-- 
2.49.0


