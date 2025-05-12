Return-Path: <netdev+bounces-189619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449C5AB2D2C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FB116C5AB
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A86B218AC8;
	Mon, 12 May 2025 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="ukiCeFdx";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="RxZXveLw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C027456;
	Mon, 12 May 2025 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013309; cv=fail; b=ArnI7QTfoHhPca4Sl8nhpYSEx3RV6n9GrU4q0pTOa0K9bu1+JfPZW0o2T+jX1OvFhfilcMHorCTtMBzpwpjN6wqsg3GD2SYmmb7XCIeiCzvXevEoto6i3VCfn83+488sFM4lZEUzBumUR3YY1MmLsIB0kB1pFAs4raI84ov4BNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013309; c=relaxed/simple;
	bh=K3cLtLRti8imrg/jZ3HeDH517zMk8EVeAopAzu6h3uQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lTGKY4zWO0NEu5WToU/K0SpS+zI4kECQTPVeCOECHXJpAUbJDpO157JVp+L7XYlFnKuMzsxAVajPV6yU0dpr8QF6RMxcqGUKHXTY01fJbBUR1IJDMMfvMw1OVzqsErlLYZPyCuWx5u9YpdPfmlWnF9AQ0T10lSqrz7PE7OSSKp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=ukiCeFdx; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=RxZXveLw; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BMe1Rr027700;
	Sun, 11 May 2025 20:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=kWQTEjPud+PElrz0qUYJfc1sEE+0Frc6NSiUBSHDnWc=; b=ukiCeFdxZzh/
	6l0VXnsCHKzs2ThbhBrd2ZlA7ichO3WAfKTFpBDEDf6wDosiHu+woyb/aXSggcPD
	5Jsm5onWZf6VbidDjAvhoeDEgBLbmc+VTVH4eY8iFvGAx9yFaEEM1WjxkLRUSGYo
	3p9xP4PUcJfG5Qm+LtxRYDfOOMnECKP6lmXl8xlYGSFceoz7BcGT068MVQmgn1fD
	UTYuA/KBuaIx7+wGa/6L665DUKlkcKHDWlMzeZheH2eUwwZnhwDhjDOfeiSwzir3
	bl1XHAqQKtFPtVqdVUoDi1D3YN/EslOtE6cpFlHLmUylwfG4U8/HsU9uYXnXAZBm
	bnFd0f56KQ==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j34csvw9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U39ba/3VgEzPGbWOG0dWVOTpOq7ludgHc5EUxQJWKxTuo+Dxa4TtEDrTkOHxzLLw48Nd58qVtu5YNlZhq6+nxUii0VZLJRUdaPoWKli+s/P9Cun8+bV7mVUTgaJOe+PUFkYVAIAtwnDlPNfiIpAK0xJ5D+7JNS2ElGTDi0QZSh5Y56Kb4OpOPs24Xltr5k+jORwENzVgjLtjKm5evSVLOKbX54oo84SoKhVEnxXGj/AWigBTXOoWNm3QclhXHIdDOA4Bb6wHjnwrlG/V3uM/cxwbUS+o46l/p29NM/aEOKd5Db+JJoOXsX06sg7YkTstydPQ0c3cpUZljKHuACUcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWQTEjPud+PElrz0qUYJfc1sEE+0Frc6NSiUBSHDnWc=;
 b=UvzUT6mH3JvTItZihQRjf+GAe/LGvLa1aLOSXEXhXnE173XL/rOH66VhJjpPIBNaoBdp9XyYaIPYyBi2RmAxMEA/gQX6PAsNSMCLrPNwI5cXbpL1VDiaz2sMcpi7iUHmJXEL/Tinud3VmJrrPc/xqWOXlFLRf8XNTT2AKgnlRne6MNo9qzMTigs1KpkMuQ2LpA7YhRW3u6nrJ5cBNCltg5O114N2toztqnDHDJ4NkW+lALCFngKs6K/g8F97Qy6Do/d1NhM8s4FTtCve+TpboO7bmzyy+5OY0e9K0VuSyi14+pgN7cqTPhqYxAALwtAJ2lUOgMKuXLFPcBgI60tNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWQTEjPud+PElrz0qUYJfc1sEE+0Frc6NSiUBSHDnWc=;
 b=RxZXveLw/evVX8GVOBivf5y6xQRf0vH0xaH2G5GhhVi6EuZFtDVYmdEW35Dm+WLN7XT+WfhiiqoAT9dYj61LQL9a35VILryew7CmgbkycXqsTGYZbxdQyyMqOAA1/nEq5ZopjHFiYcH8TkSwcFlWAC8/OnnLH6TQlBIhisjTHik=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Mon, 12 May
 2025 01:28:04 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:28:03 +0000
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
Subject: [RFC net-next 08/15] net: cpc: add support for connecting endpoints
Date: Sun, 11 May 2025 21:27:41 -0400
Message-ID: <20250512012748.79749-9-damien.riegel@silabs.com>
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|PH0PR11MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f7e573-7775-4336-b9de-08dd90f43d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFpKRVY2ajZZclZLcmRUVWVyOVVkZUhzeGhlNlJmVVZKOG9uT3NBQjhNOElZ?=
 =?utf-8?B?MkYyQ0NScTZwSDdzT2g4citXdUhyNTV2UjBRZVJwa1dzWXpINnJjTkxMWU5o?=
 =?utf-8?B?UU9mZ1NXQmJyMDVNdTQ0TStJemkxdEJZSVpzelNFbmJiSDJrWXQrcXlSc0cy?=
 =?utf-8?B?UkFEUGhTOStCNzg2OFVVM3k5cU9zbE9pbEpUUkg1aGw5VUtoaGRZenhZNHo0?=
 =?utf-8?B?di9ZVW14VGpYR0NSM2l2a2ZtWEtzVHVpSzBaU1JlL1RVRHI3cmkySGlDM3ZU?=
 =?utf-8?B?UUErTExtc3FoTCs2dnFqNmFmdy9Rb2U5bXVaMXJMYUR1WWlZc3h1VUt0NjhO?=
 =?utf-8?B?RGtHa21oK2Q0cGg0WUpLdzNCZCs4MnNCQ3RyYXdTblRYTE14ZXJrRERKRmRN?=
 =?utf-8?B?U2JFYWE2NGZpQUU4d1o2bWFnaVVRSEhOczgweGZkYndGWGhmVjQ4R1NoRCsy?=
 =?utf-8?B?QlJnRDB6VnFaUHZxaXp4bkFNVVFuYll5eGJYM1I1K1A5S1JtaVY5T3NHeGRl?=
 =?utf-8?B?RkY4dU1tYnRSTEFpQ1Jkd3NWRDRRY3ZrNytyMk4rbk85WWtvT2FSUnFNOUVL?=
 =?utf-8?B?L0hWQTlKVk5UUzlsSlQ5SCsvdG5kbXRDdGxFOWdPNEx6amZkTWpXdndORTNp?=
 =?utf-8?B?QXNaTUZMVTFPbUtUWTlaVjY1N2hKd3BpWjdmaDJDQjhWVEpOelZnV0ZYU05s?=
 =?utf-8?B?RFRQVXFyRThVcXh2b1BXN0lvOCs0dWl5VW1Tb1laSXdrNUhKNnJDSUxyL2NH?=
 =?utf-8?B?T2ZqQlA5K2FYV2pvUzNYN1BuSDl0bUgvOWowNDF6TE1LQmVFLzBlRDNpZWoz?=
 =?utf-8?B?Vytkbm5MZXkrMzNtRGp3OCsyRVEzWGtsTW9sU3hIOCtNbHVoMFpTNTFhejhV?=
 =?utf-8?B?WG5wZUgyeHJQWG1kbTRnb2p6cWtPM2hlMjUydloyMTZnOXVxNlhJVjJwRThr?=
 =?utf-8?B?eS9zeC9uUzA4bXBNcSt6c0lTY21sYno0UytaWU9KdWpaTUpaUE9DOVRyRXor?=
 =?utf-8?B?N0llNlhWV21UeTk5S3lxWThnNEN1cTAwYTQyY2p4Ym0xM09aWlNoRXY0SHkx?=
 =?utf-8?B?VTJ0Z2ErMUYzcjRaalJOZnNLaWkwbGJPem9qRVp6SFp3a0x5ZUhsUElZUUNF?=
 =?utf-8?B?c1dCcmxsSDNnUk9TZWhhSVpQOVIzaEluUWxRaXhUclhoY1JhVGNBeFhZU0Nm?=
 =?utf-8?B?Q3NZVnVXNnFleGtQNUFzUlAvdnovTXRLQitMRWRueFNvQXA4T3RLbHVqdG1Y?=
 =?utf-8?B?SjByMWczR2JaRUVnY05ocXlDM1JWeFdoMDlvRE4vbUwyc0thZDQvYTFuV0RU?=
 =?utf-8?B?RmdtMnorVDdyMC9OYVNWQVNKVzVZOTdERVpHU2VjMDlsWGY3aXVZN3U4M2RN?=
 =?utf-8?B?YVJaSXNyOEpaK04rNUVDeEg4TU1SNFpRRFdFZVVOYXBXTGhReXZTRTlwRUlF?=
 =?utf-8?B?Y3BNdXRvd0k1N2NaVktvWmRMTjFNdTVodzFaMW9xM2t1QkEwYjY5cW5qZG8v?=
 =?utf-8?B?SkZucWtRdEswNHQ1S20zQmdvcG1QRG9BRGdSOEkwWm90dEFEUTJJZTE2bjdV?=
 =?utf-8?B?YmZ5M0xtVllaRVlUVy9OR3k4ejErNzI3bitldDArakZnN0UyNHI1bkdSWkwx?=
 =?utf-8?B?aHlOR0dIK3NzSVFRck5WNWU0Tm9kWkFTamxsWElKUmFaRFEvTHVZSkNMNGd3?=
 =?utf-8?B?MVFHUW1MVk5qQ1FIUUwwTHJhV25UNDhJdVBGdjArTlplSG80S3BaNXJZR3M1?=
 =?utf-8?B?TFhqY1o0OFBDTGdEVGRMbW5paG4xTFFPRnJkQysweXVuOHdYWXN5aG8vdjdh?=
 =?utf-8?B?SjRwTW9SRUo3WXU2WURScTRCWFFYM0hDWUQrODM4d0NMU2k3R00yVEt6NVdN?=
 =?utf-8?B?b3VtR2VVc3RDSkxxN0dNbjlpTktxNGI3NjBpUk1pWnVLUG5OYldpV25wM3Ns?=
 =?utf-8?B?aGw4Z1I0UVU3cHpjSGRtcmlMUXpKMzBCU3FucTcxN0pnR0U3eXM5YUN4QVJV?=
 =?utf-8?Q?OZIQAjCqNvCE79JVSkTOh7dId9sy0Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym5KcmRXSllId1pjbU5GRHRJa050dDBBcjlpSUlxa205ODRtMnFsWk01bC9N?=
 =?utf-8?B?VzQ2QjQxN3pmZzQ5OFFvcVBpbEpaTjRmMzB6dC9JVStCMVBQVGJTNkk3VFl1?=
 =?utf-8?B?VGlzQkV6K2RYZWE2SkVQcmpVRVVMMmZiY0FzRFpZZGxMaDBoc25HLzRRK0xF?=
 =?utf-8?B?aFFHYjA5YXBqTkFLV01Yd2FWV1hXdVBTSE52bk9lSmtFUm5rUXYxVUkyNVhZ?=
 =?utf-8?B?M2ZESHlENkF2UVdRQ0NUNVVDMFVNYXhic1pVMDZGZ0tQRlBwUmVRdnFPYmFt?=
 =?utf-8?B?ZzlISlJ4ZHJXSXNXTGdTa3pGVU8wS2dybHRtR0FiL3RDV2RxZ0ZFSWV1a0xy?=
 =?utf-8?B?cy8rNGxqZUhMOWg0bEhHV2N1aklaVDBKOEF0elBoVDRNVHhLKzZKUmZlU21a?=
 =?utf-8?B?d0FYRmxwdGFMWVhjNUpueUlLUUJJZ05adHhZa3A4cnkyUXdqOWY5OUx0dVdE?=
 =?utf-8?B?M2JsNjFSd0VvZTN2T2hSWW4vZXRreGJRTHltSzNGdWNkWDllc1FSdWNiQ3c0?=
 =?utf-8?B?RWsxeHZyUlZxcWhHN1JHYnM1YWMxdDZtQjhzY1E1VW1Vc1dqMENWQ3pzZk9j?=
 =?utf-8?B?T0NHd0xuV2JCQkp6Z29DLzA5RnFVdVFwQVkwbjU4a1B1WXR0eElsRjYwK29H?=
 =?utf-8?B?MUQ3V2dxdk9zZi82N3MwcGJUamxLaU5vQnRvVWFUUUx1VllHLzdiUTBxTEdu?=
 =?utf-8?B?K0NEc2xmNFZQdkR5TVlVZXZhS0RySURnQXV3WlNrbGYzWGRaZ29CdDY4d2xi?=
 =?utf-8?B?c1U4ZkJHYkt1TVBUemh6NFBrdGVUYndyZkpMQit4TDR2UlIzWThWNFgwRWJj?=
 =?utf-8?B?VkFXT09xSjZjMmpZNUlaTW5aRVlNZlVzYkVtVjJabXVoazF6RFBwUllWQWtu?=
 =?utf-8?B?SUVBbk0vU1pHZHFQd1hzMU54QmFYejBQdkU4QWZ3UFg4MW5SNkVvRDMzZmJz?=
 =?utf-8?B?V1ZjUm5kMytkZG5CZExUNGNDTFZaZmkvYzJXMFo4RUNXYk02UjVqVnlIM21I?=
 =?utf-8?B?czZFanI2N1Y0Zk9jczN5OWU4NlB6MnZwcDdLOGtjN3JoRlJDZjloMmhyYTFB?=
 =?utf-8?B?UXVjY3ovWWNEQ2hzQUx4OHVnMDJkUlAxeW5lYlhrcUtuVnlhUk8yUjZCYjEr?=
 =?utf-8?B?RWlMeGx4dHFZNkhUVE0vcS9YR3laNnBSUG84Z0pBNVVJQ09TR0Q3VjVURlg5?=
 =?utf-8?B?Tlc0YStKM1BLUEdicVNUVGVmRjNCZ1ZQYkJmTWtXbmVyTkpyaWxYWXpoQzdP?=
 =?utf-8?B?b1pWTnJvY0hYbURvcTIxTzBpa3NYT25ycDN0RDR0MEF5bzhoODFOakRhN3Vh?=
 =?utf-8?B?bFZKbUlwOExtbjNVdy8wSzdvWWJHbkZxOVZQUm5OeFhDK3VOUmdMTVE0MTBZ?=
 =?utf-8?B?R2g5M3c3QkNuKy9Ja0l3RXIxVVRMNnJSaUQ3SHJSR2REa1NQazVtRm5PVm8w?=
 =?utf-8?B?Mk42ckd4VWxxcmc1amphWjNVZy9HNVRvOGlFRi9wWEpOUkF0Qlk4elV1QUht?=
 =?utf-8?B?NGp3SjI4bUN2SDhDU0JWbWRnUjZPY1pSTnRBMkcxWURSdW5vZjlJak1zU1Ro?=
 =?utf-8?B?cjEwdTJWWVlOWXN3OE4xSGtBOG8rZmlXOExFbENKQ3labmtIN0hObXBYNlFR?=
 =?utf-8?B?Yy9TWkNNd05JaHlCV1FPNmFtLzhZT0RwOVVGakN6VWNUZ0QrbTdicXJNdnpw?=
 =?utf-8?B?MWxZMmtjM0hjc1lZM0dud2FPeCtjT1FMczBadUFQc3U4aFk5bWhodnpFRmh2?=
 =?utf-8?B?Y2ZaRHY0NzdQQllFWFR6R2l4NnpLbVBLYldRb2NFbzdDNHZleTRCRWFWZnlm?=
 =?utf-8?B?c1Y1YmZrTnFYOEU5V2txR1NCMmhmOHJ5TDhWcktBRzU5QzIvdVFxd2NBbTdv?=
 =?utf-8?B?a28vSGs1VHI3ZjIyYThWTHJxZ3RqUDg1VWh6a080aWJwckVrbGVJeVJSSEkz?=
 =?utf-8?B?dTJZcHBDRFhkYmN4S0Y2VmJtRTNCa3NuamhQRjNLWEszc0Y3Uk1zbmR6cXNk?=
 =?utf-8?B?TXZjaEFEQ1hhQ1YwamhON2RUNjJLbWR2T1QrSWlKMGlDY09hd3l4K2duSUhk?=
 =?utf-8?B?TzVpQnlzODBuTDN6a3F6Qi9vOWZWOVh6V1MzbkxtWGZVOERML1ZpWkhKSHZK?=
 =?utf-8?Q?Wix2bjp2/7Iy/stI/7z8qkqgH?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f7e573-7775-4336-b9de-08dd90f43d80
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:28:03.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7VqzwXwCZXn/x96E16VyDORJdjKJBzxBLcNbcsNmdYmqGVFeqA1cBlUFbnOG090S8X8lwzTEB+iDGrUcR/NGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-Proofpoint-GUID: 9wwzgUiX7zGTKnj9uA-aw7tTKhH0pxKR
X-Proofpoint-ORIG-GUID: 9wwzgUiX7zGTKnj9uA-aw7tTKhH0pxKR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX6v/ZI8b4g/vt QYKyhMMDn2FBguHd7GVruFcNRre7fBk8lGBvy0WwCToyMZ0w/IWdbdef8TiVkfgzPIke7Q6jBpz IUYAjgIf2iuhdNe+Krq8LxjyWpdeOKW/u6Zm55jHuZN+MSxypdsJ30Y1STr6GlZNoRpBQPvNhVk
 X3nZpEDIsDu7wxZ/tgmWMnlfqsU8ICNx/1w08f6kIa3hFTqcO+HcpTMJq7VRD/MRAEsxUxVtxPV 7TyNdYwReWGSSFgvkkcWB9xJqjxks78LRUryVGKzKub71RyyKSNsJLU3uN4JV/uQ+8SIa/57XsZ S9WY3Xnwpf75sjHw9HyGuuXeQgy4muvdWaeCkRWr2DDWsBgfwCG/Jv9phvnnBWou3WPSG60oDNU
 TskYWI2uT69Zx812hTWgMgv2Hq4wxfmWsui4HkjuzlkWRz9Dml9siOAOVDc8DduMXY11Wqer
X-Authority-Analysis: v=2.4 cv=L/gdQ/T8 c=1 sm=1 tr=0 ts=68214ea9 cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=TjJOd7T2WYD0k9XMUkAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

Endpoints must be connected before transmitting. This is achieved using
a three-way handshake in which each peer advertises the maximum payload
size it can receive. Once again, this constraint comes from the remote
microcontroller, which can have tight limit on the payload size it can
handle.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 drivers/net/cpc/cpc.h       | 12 +++++
 drivers/net/cpc/endpoint.c  | 75 ++++++++++++++++++++++++++++
 drivers/net/cpc/interface.c | 29 +++++++++++
 drivers/net/cpc/interface.h |  3 ++
 drivers/net/cpc/protocol.c  | 97 ++++++++++++++++++++++++++++++++++++-
 drivers/net/cpc/protocol.h  |  4 ++
 6 files changed, 219 insertions(+), 1 deletion(-)

diff --git a/drivers/net/cpc/cpc.h b/drivers/net/cpc/cpc.h
index 94284e2d59d..d316fce4ad7 100644
--- a/drivers/net/cpc/cpc.h
+++ b/drivers/net/cpc/cpc.h
@@ -18,6 +18,11 @@ struct cpc_endpoint;
 
 extern const struct bus_type cpc_bus;
 
+/* CPC endpoint flags */
+enum {
+	CPC_ENDPOINT_UP,	/* Connection is established with remote counterpart. */
+};
+
 /**
  * struct cpc_endpoint_tcb - endpoint's transmission control block
  * @lock: synchronize tcb access
@@ -37,6 +42,7 @@ struct cpc_endpoint_tcb {
 	u8 send_una;
 	u8 ack;
 	u8 seq;
+	u16 mtu;
 };
 
 /** struct cpc_endpoint_ops - Endpoint's callbacks.
@@ -54,6 +60,8 @@ struct cpc_endpoint_ops {
  * @intf: Pointer to CPC device this endpoint belongs to.
  * @list_node: list_head member for linking in a CPC device.
  * @tcb: Transmission control block.
+ * @conn: Completion structure for connection.
+ * @flags: Endpoint state flags.
  * @pending_ack_queue: Contain frames pending on an acknowledge.
  * @holding_queue: Contains frames that were not pushed to the transport layer
  *                 due to having insufficient space in the transmit window.
@@ -72,6 +80,8 @@ struct cpc_endpoint {
 	struct cpc_endpoint_ops *ops;
 
 	struct cpc_endpoint_tcb tcb;
+	struct completion conn;
+	unsigned long flags;
 
 	struct sk_buff_head pending_ack_queue;
 	struct sk_buff_head holding_queue;
@@ -83,6 +93,8 @@ struct cpc_endpoint *cpc_endpoint_new(struct cpc_interface *intf, u8 id, const c
 
 void cpc_endpoint_unregister(struct cpc_endpoint *ep);
 
+int cpc_endpoint_connect(struct cpc_endpoint *ep);
+void cpc_endpoint_disconnect(struct cpc_endpoint *ep);
 int cpc_endpoint_write(struct cpc_endpoint *ep, struct sk_buff *skb);
 void cpc_endpoint_set_ops(struct cpc_endpoint *ep, struct cpc_endpoint_ops *ops);
 
diff --git a/drivers/net/cpc/endpoint.c b/drivers/net/cpc/endpoint.c
index db925cc078d..e6b2793d842 100644
--- a/drivers/net/cpc/endpoint.c
+++ b/drivers/net/cpc/endpoint.c
@@ -35,6 +35,7 @@ static void cpc_endpoint_tcb_reset(struct cpc_endpoint *ep)
 {
 	ep->tcb.seq = ep->id;
 	ep->tcb.ack = 0;
+	ep->tcb.mtu = 0;
 	ep->tcb.send_nxt = ep->id;
 	ep->tcb.send_una = ep->id;
 	ep->tcb.send_wnd = 1;
@@ -72,6 +73,7 @@ struct cpc_endpoint *cpc_endpoint_alloc(struct cpc_interface *intf, u8 id)
 	mutex_init(&ep->tcb.lock);
 	cpc_endpoint_tcb_reset(ep);
 
+	init_completion(&ep->conn);
 	skb_queue_head_init(&ep->pending_ack_queue);
 	skb_queue_head_init(&ep->holding_queue);
 
@@ -197,10 +199,77 @@ void cpc_endpoint_unregister(struct cpc_endpoint *ep)
  */
 void cpc_endpoint_set_ops(struct cpc_endpoint *ep, struct cpc_endpoint_ops *ops)
 {
+	if (test_bit(CPC_ENDPOINT_UP, &ep->flags))
+		return;
+
 	if (ep)
 		ep->ops = ops;
 }
 
+/**
+ * cpc_endpoint_connect - Connect to the remote endpoint.
+ * @ep: Endpoint handle.
+ *
+ * @return: 0 on success, otherwise a negative error code.
+ */
+int cpc_endpoint_connect(struct cpc_endpoint *ep)
+{
+	unsigned long timeout = msecs_to_jiffies(2000);
+	int err;
+
+	if (!ep->ops || !ep->ops->rx)
+		return -EINVAL;
+
+	if (test_bit(CPC_ENDPOINT_UP, &ep->flags))
+		return 0;
+
+	cpc_interface_add_rx_endpoint(ep);
+
+	mutex_lock(&ep->tcb.lock);
+	skb_queue_purge(&ep->pending_ack_queue);
+	skb_queue_purge(&ep->holding_queue);
+	cpc_endpoint_tcb_reset(ep);
+	mutex_unlock(&ep->tcb.lock);
+
+	err = cpc_protocol_send_syn(ep);
+	if (err)
+		goto remove_from_ep_list;
+
+	timeout = wait_for_completion_timeout(&ep->conn, timeout);
+	if (timeout == 0) {
+		err = -ETIMEDOUT;
+		mutex_lock(&ep->tcb.lock);
+		skb_queue_purge(&ep->pending_ack_queue);
+		mutex_unlock(&ep->tcb.lock);
+
+		goto remove_from_ep_list;
+	}
+
+	return 0;
+
+remove_from_ep_list:
+	cpc_interface_remove_rx_endpoint(ep);
+
+	return err;
+}
+
+/**
+ * cpc_endpoint_disconnect - Disconnect endpoint from remote.
+ * @ep: Endpoint handle.
+ *
+ * Close the connection with the remote device. When that function returns, no more packets will be
+ * received from the remote.
+ *
+ * Context: Must be called from process context, endpoint's interface lock is held.
+ */
+void cpc_endpoint_disconnect(struct cpc_endpoint *ep)
+{
+	if (!test_and_clear_bit(CPC_ENDPOINT_UP, &ep->flags))
+		return;
+
+	cpc_interface_remove_rx_endpoint(ep);
+}
+
 /**
  * cpc_endpoint_write - Write a DATA frame.
  * @ep: Endpoint handle.
@@ -215,6 +284,11 @@ int cpc_endpoint_write(struct cpc_endpoint *ep, struct sk_buff *skb)
 
 	mutex_lock(&ep->tcb.lock);
 
+	if (skb->len > ep->tcb.mtu) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (ep->intf->ops->csum)
 		ep->intf->ops->csum(skb);
 
@@ -227,6 +301,7 @@ int cpc_endpoint_write(struct cpc_endpoint *ep, struct sk_buff *skb)
 
 	err = __cpc_protocol_write(ep, &hdr, skb);
 
+out:
 	mutex_unlock(&ep->tcb.lock);
 
 	return err;
diff --git a/drivers/net/cpc/interface.c b/drivers/net/cpc/interface.c
index edc6b387e50..d6b04588a61 100644
--- a/drivers/net/cpc/interface.c
+++ b/drivers/net/cpc/interface.c
@@ -36,6 +36,9 @@ static void cpc_interface_rx_work(struct work_struct *work)
 		case CPC_FRAME_TYPE_DATA:
 			cpc_protocol_on_data(ep, skb);
 			break;
+		case CPC_FRAME_TYPE_SYN:
+			cpc_protocol_on_syn(ep, skb);
+			break;
 		default:
 			kfree_skb(skb);
 		}
@@ -203,6 +206,32 @@ struct cpc_endpoint *cpc_interface_get_endpoint(struct cpc_interface *intf, u8 e
 	return ep;
 }
 
+/**
+ * cpc_interface_add_rx_endpoint() - Set an endpoint as being available for receiving frames.
+ * @ep: Endpoint.
+ */
+void cpc_interface_add_rx_endpoint(struct cpc_endpoint *ep)
+{
+	struct cpc_interface *intf = ep->intf;
+
+	mutex_lock(&intf->lock);
+	list_add_tail(&ep->list_node, &intf->eps);
+	mutex_unlock(&intf->lock);
+}
+
+/**
+ * cpc_interface_remove_rx_endpoint() - Unet an endpoint as being available for receiving frames.
+ * @ep: Endpoint.
+ */
+void cpc_interface_remove_rx_endpoint(struct cpc_endpoint *ep)
+{
+	struct cpc_interface *intf = ep->intf;
+
+	mutex_lock(&intf->lock);
+	list_del(&ep->list_node);
+	mutex_unlock(&intf->lock);
+}
+
 /**
  * cpc_interface_receive_frame - queue a received frame for processing
  * @intf: pointer to the CPC device
diff --git a/drivers/net/cpc/interface.h b/drivers/net/cpc/interface.h
index a45227a50a7..f7f46053fad 100644
--- a/drivers/net/cpc/interface.h
+++ b/drivers/net/cpc/interface.h
@@ -68,6 +68,9 @@ void cpc_interface_unregister(struct cpc_interface *intf);
 
 struct cpc_endpoint *cpc_interface_get_endpoint(struct cpc_interface *intf, u8 ep_id);
 
+void cpc_interface_add_rx_endpoint(struct cpc_endpoint *ep);
+void cpc_interface_remove_rx_endpoint(struct cpc_endpoint *ep);
+
 void cpc_interface_receive_frame(struct cpc_interface *intf, struct sk_buff *skb);
 void cpc_interface_send_frame(struct cpc_interface *intf, struct sk_buff *skb);
 struct sk_buff *cpc_interface_dequeue(struct cpc_interface *intf);
diff --git a/drivers/net/cpc/protocol.c b/drivers/net/cpc/protocol.c
index 92e3b0a9cdf..db7ac0dc066 100644
--- a/drivers/net/cpc/protocol.c
+++ b/drivers/net/cpc/protocol.c
@@ -11,6 +11,36 @@
 #include "interface.h"
 #include "protocol.h"
 
+int cpc_protocol_send_syn(struct cpc_endpoint *ep)
+{
+	struct cpc_header hdr;
+	struct sk_buff *skb;
+	int err;
+
+	skb = cpc_skb_alloc(0, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	memset(&hdr, 0, sizeof(hdr));
+
+	mutex_lock(&ep->tcb.lock);
+
+	hdr.ctrl = cpc_header_get_ctrl(CPC_FRAME_TYPE_SYN, true);
+	hdr.ep_id = ep->id;
+	hdr.recv_wnd = CPC_HEADER_MAX_RX_WINDOW;
+	hdr.seq = ep->tcb.seq;
+	hdr.syn.mtu = cpu_to_le16(U16_MAX);
+
+	err = __cpc_protocol_write(ep, &hdr, skb);
+
+	mutex_unlock(&ep->tcb.lock);
+
+	if (err)
+		kfree_skb(skb);
+
+	return err;
+}
+
 static void __cpc_protocol_send_ack(struct cpc_endpoint *ep)
 {
 	struct cpc_header hdr;
@@ -116,6 +146,42 @@ static void __cpc_protocol_receive_ack(struct cpc_endpoint *ep, u8 recv_wnd, u8
 	__cpc_protocol_process_pending_tx_frames(ep);
 }
 
+static bool __cpc_protocol_is_syn_ack_valid(struct cpc_endpoint *ep, struct sk_buff *skb)
+{
+	enum cpc_frame_type type;
+	struct sk_buff *syn_skb;
+	u8 syn_seq;
+	u8 ack;
+
+	/* Fetch the previously sent frame. */
+	syn_skb = skb_peek(&ep->pending_ack_queue);
+	if (!syn_skb) {
+		dev_warn(&ep->dev, "cannot validate syn-ack, no frame was sent\n");
+		return false;
+	}
+
+	cpc_header_get_type(syn_skb->data, &type);
+
+	/* Verify if this frame is SYN. */
+	if (type != CPC_FRAME_TYPE_SYN) {
+		dev_warn(&ep->dev, "cannot validate syn-ack, no syn frame was sent (%d)\n", type);
+		return false;
+	}
+
+	syn_seq = cpc_header_get_seq(syn_skb->data);
+	ack = cpc_header_get_ack(skb->data);
+
+	/* Validate received ACK with the SEQ used in the initial SYN. */
+	if (!cpc_header_is_syn_ack_valid(syn_seq, ack)) {
+		dev_warn(&ep->dev,
+			 "syn-ack (%d) is not valid with previously sent syn-seq (%d)\n",
+			 ack, syn_seq);
+		return false;
+	}
+
+	return true;
+}
+
 void cpc_protocol_on_data(struct cpc_endpoint *ep, struct sk_buff *skb)
 {
 	bool expected_seq;
@@ -149,7 +215,7 @@ void cpc_protocol_on_data(struct cpc_endpoint *ep, struct sk_buff *skb)
 		/* Strip header. */
 		skb_pull(skb, CPC_HEADER_SIZE);
 
-		if (ep->ops && ep->ops->rx)
+		if (test_bit(CPC_ENDPOINT_UP, &ep->flags))
 			ep->ops->rx(ep, skb);
 		else
 			kfree_skb(skb);
@@ -158,6 +224,35 @@ void cpc_protocol_on_data(struct cpc_endpoint *ep, struct sk_buff *skb)
 	}
 }
 
+void cpc_protocol_on_syn(struct cpc_endpoint *ep, struct sk_buff *skb)
+{
+	mutex_lock(&ep->tcb.lock);
+
+	if (!__cpc_protocol_is_syn_ack_valid(ep, skb))
+		goto out;
+
+	__cpc_protocol_receive_ack(ep,
+				   cpc_header_get_recv_wnd(skb->data),
+				   cpc_header_get_ack(skb->data));
+
+	/* On SYN-ACK, the remote's SEQ becomes our starting ACK. */
+	ep->tcb.ack = cpc_header_get_seq(skb->data);
+	ep->tcb.mtu = cpc_header_get_mtu(skb->data);
+	ep->tcb.ack++;
+
+	complete(&ep->conn);
+
+	__cpc_protocol_send_ack(ep);
+
+	set_bit(CPC_ENDPOINT_UP, &ep->flags);
+	complete(&ep->conn);
+
+out:
+	mutex_unlock(&ep->tcb.lock);
+
+	kfree_skb(skb);
+}
+
 /**
  * __cpc_protocol_write() - Write a frame.
  * @ep: Endpoint handle.
diff --git a/drivers/net/cpc/protocol.h b/drivers/net/cpc/protocol.h
index 9a028e0e94b..e67f0f6d025 100644
--- a/drivers/net/cpc/protocol.h
+++ b/drivers/net/cpc/protocol.h
@@ -13,9 +13,13 @@
 
 struct cpc_endpoint;
 struct cpc_header;
+struct cpc_interface;
 
 int __cpc_protocol_write(struct cpc_endpoint *ep, struct cpc_header *hdr, struct sk_buff *skb);
 
 void cpc_protocol_on_data(struct cpc_endpoint *ep, struct sk_buff *skb);
+void cpc_protocol_on_syn(struct cpc_endpoint *ep, struct sk_buff *skb);
+
+int cpc_protocol_send_syn(struct cpc_endpoint *ep);
 
 #endif
-- 
2.49.0


