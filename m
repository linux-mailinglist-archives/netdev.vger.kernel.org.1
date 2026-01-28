Return-Path: <netdev+bounces-254145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMp1OtbFeWl0zAEAu9opvQ
	(envelope-from <netdev+bounces-254145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:16:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 105089E1D1
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B292130008A5
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FEB337BAA;
	Wed, 28 Jan 2026 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Jl6dHPf+"
X-Original-To: netdev@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010021.outbound.protection.outlook.com [52.103.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B6A27F73A;
	Wed, 28 Jan 2026 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769587680; cv=fail; b=FWxKXZabmM+b78GgZvx0Tr1ZHtyiVOsfBueYDTPjvgrxYzyebYZQweUTBzXC1LlyGPwAEtCmS0UYCip9NE68soZDgnkdd73Bqred66afRVLkRZqQbeszJZhn4Gpy3QLemua+M1B0J2W+NTBRvdOV48D5SudpbzwHSPxdnw6kobU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769587680; c=relaxed/simple;
	bh=l4GOGtl4J00uocBIwJNNwt8ds+2hUNBOEAAF9qWH/ao=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=a4IxWZKkSyfLUSzJ3tYjDZKMN47hEXdC7XaVsE0s5moev1GV+KathkJSNFfeNVLjn63R2irSr4/PmjJYQXnI1sVtxAtRu/AS4KreLM1XNikQRgJznaqg0MDY3qHLBizv2eGWN5HHo1WNNG1k4JXREF2KRDk/WXcYWLaZy/oVbhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Jl6dHPf+; arc=fail smtp.client-ip=52.103.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6gvEgb7JxIqc42uwyQtXBeJ85tda8fGc9/vXoi8+BX/wMePhEIjK0fDnhvfH90kOKmhV7bchFGaN/x0Sf59G5shpI1DWV5/KPSZ/QUKvVhTExlmRLUyeaAFidJW8Eh0Qb4nHbQAzjFmOULiuEjGY9hv1bHi4Wtz69bW6DMGU9kaXVl8k8POt9yELbUgfJXVE9E87dCbSAUYtTIcq1k7WvyUP62XL9yrnpQCF0YMxcx2WLNY3ehnYXcVNZ98MkOpLYtd6ZlD5BqfWtK0REhaTWaZtMMe2mteEoofnsMUCr/Cj8J2GY/TUssfYWVTDwIeopEYlC3QcYyHXEFhgbT0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=639racG3KC9c4QLMHGjS0zpTJwpOIenFJ+dyT7QUjwY=;
 b=tsfJUOKp/uWaD6f/W/KnLofMnt1bE8LL0hi5djScQ5gBPRyMmaHXjpbj2y3VLb02cBbNmL2tDURsREyAx//z+3j7lXBLcu1Gljk0SwZte3qAg+S2BrLooI0bS8nfLrszv4VCxYAJaFNb8d5Mz9BTmIxUJO7mbGzW/NvdIZiI3Nb8hFtFCFGy3MqQRUcSTi2YtBYTjf3vJFR210c+6EaUSGZSwO6gxYNB+qKhUz2zFJimXPmo0wY8zqA7B1LmGYf10LMfUMZw8DD1lLkMgFZlT84xt3SepM/ul8U9tBxVl5YV+5JcV3KXTA2kBixCJFVckakIOgJLxDwBaxK9Dxqq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=639racG3KC9c4QLMHGjS0zpTJwpOIenFJ+dyT7QUjwY=;
 b=Jl6dHPf+8nTtj+EjAnrQwsX0DCrzG/HJIq5pX1PAa8DB1mbLP92NKpvawCsUBvHk40K13DONuPlU9UVFApNxWTBdlPrdPo4qFI5rusYNladnI8s33a8aRortJDXJlxAz5iP1I1GV+kFe/uGya/JmUvkevjGV0E/wFxRyICQ/65W5Ljkh5QssO+4K+8Pq291hHbMD/URp89VIF36u9jq+2rHedzXOfn2vNrVPZNRmwOdD4MWDMyr+tSTmSqaMipkUnnwbxZlvnkj3zvgzzsCv/ZVVajhNiMUPJKA+7Ipr/SC+p3gzsbl7d67CGejf5RyO416z7Aw5nyGxWLAGcqv2lw==
Received: from ME3PR01MB7894.ausprd01.prod.outlook.com (2603:10c6:220:190::10)
 by SY0PR01MB10148.ausprd01.prod.outlook.com (2603:10c6:10:2fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 08:07:54 +0000
Received: from ME3PR01MB7894.ausprd01.prod.outlook.com
 ([fe80::3127:73af:9728:9a87]) by ME3PR01MB7894.ausprd01.prod.outlook.com
 ([fe80::3127:73af:9728:9a87%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 08:07:54 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Wed, 28 Jan 2026 16:07:34 +0800
Subject: [PATCH] dpaa2-switch: prevent ZERO_SIZE_PTR dereference when
 num_ifs is zero
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881BEABA8DA896947962470AF91A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyMz3bTMitRiXXOLpCQDM1ODFJO0VCWg2oKiVLAEUGl0bG0tAKAMZOh
 XAAAA
X-Change-ID: 20260126-fixes-78bb0650d4fe
To: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=l4GOGtl4J00uocBIwJNNwt8ds+2hUNBOEAAF9qWH/ao=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhszKw8f423WPqikLPFHp2CqyOER/222bLV3yOcd+bfjFY
 f3t8MfajlIWBjEuBlkxRZbjBZe+Wfhu0d3isyUZZg4rE8gQBi5OAZhI3X6GfwbT9286tJXRf57s
 pU0C61j1GmWd10+cV33k28oPJzvKaiQZGc7mf9Wt9jy/zPVbdPiiRf+zVO3KivfH7dvAXvTglaf
 9LjYA
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: PH8PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::23) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260128-fixes-v1-1-cf3283b5401c@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3PR01MB7894:EE_|SY0PR01MB10148:EE_
X-MS-Office365-Filtering-Correlation-Id: f42d54ef-d88e-4756-f9aa-08de5e445479
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|8022599003|19110799012|12121999013|8060799015|23021999003|15080799012|5062599005|461199028|5072599009|41001999006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjJnVVB4V1JQMDFNU0JSWE9KVWJLMVFyZ05uZDVWdVhwdUJoZk1XVjR6NmRy?=
 =?utf-8?B?QjIwcTN0ZHZNY0twOEZxT2FpRVdQZWtNSEtmMFJiZHM1Q1prTHQ2NE1sR1lJ?=
 =?utf-8?B?MVlkdDJ1NVY0ZGpDcEozcmNvaXdJNlFrMVpJZkNqVjV4TW52R3NDNGM0ckxG?=
 =?utf-8?B?M0xFdlJ1QXRrc3RtT3lQNFlSK05FM1ppaVN6bWtQSEpYZkFRNG5SZ00wZGNJ?=
 =?utf-8?B?dmVYZFJpUThNc2NodTl6bFBIV245dk95aGptWjBjaVcxR2ZBQzhQYVJOb3Rq?=
 =?utf-8?B?QU84VjlaUWtkWmtFQy9OUGo3emdXMXpRSUxZYnJ6S3NjZEJpQkU1Smkra25C?=
 =?utf-8?B?bUp2U29OeDl1L1QwRXd6ZFczSGdqTkNZTFhSZnJhakErZTM3ekFDdHFqUlRR?=
 =?utf-8?B?ZmRVSkJIZ1lDdW40WWFSUmVhbURZakwrTzdUL0wrbXNwaXhqTW1HUnJSWTdk?=
 =?utf-8?B?WU9hYXhCY2cyUlhER0hMbkk2RDNsNXp4WjMrcjhHd3RNSWxZdERGdXRWaWJw?=
 =?utf-8?B?SEdSMjNScndPRWlWMFZDMjlxYk5xOTFpckROZ25oTkRZTG9rYWxJVWtrZ0dw?=
 =?utf-8?B?WkFhYTI0K3kzRXZkdDB0akR0ektrSW1PMlI4UEg4eGloTzFEbWFHYzFVR1hC?=
 =?utf-8?B?c3pNTFpGc1VzMU92S2xHS2VQa0NySXZyMVlpUHR6RlphTzhTSG1EL0g4WitK?=
 =?utf-8?B?QTVZRVAyNmVYVi91U1lHZHA3OWFyS09JQWZHTk55Y3gwQS9tNUJOVHZUb3Iy?=
 =?utf-8?B?TWRFUnJNdlMwSWVuM0dPdXRyMndwWjFjdVVYR0ZubTJYcjJobHZzeHNvRmZ0?=
 =?utf-8?B?WGtvZkVPYlhxdE4rZ1hHZlM4Z29vcEJxK3JSZE1vNW1ESXF5OUltMW9qdytM?=
 =?utf-8?B?T2xNbk1XVU0yNDRwaXlpMnpUL0NRVUtZOE94MEt0UThROGpreTB6cmxFUjZM?=
 =?utf-8?B?MG9iSFZBaU9YSFhjMjZobWFTak5ONGg4R3RJS004Yi9UUkE3MXFWTlVhRm5T?=
 =?utf-8?B?dG84Wmg4eEFyQVFxeWtwSmhJaTA3ZzJlb1lDRzByWUdLVXRkWFlaV1dyVjlr?=
 =?utf-8?B?WS92dHJvUGZjQzJoWFNsS1dOUUswZk9rNzhFb3VhQnFrTzhJV0hya2YzZ2JN?=
 =?utf-8?B?WUcwazJMYkxmalNxVkpkVmxnczJqeG5WWURnakFkLzQ2WFY3N1J2ZjA0UlFD?=
 =?utf-8?B?bGhxcHcrL3BxOXkvRjNLYjlvZityMTZMNnluQjdYMlNNV3luc2hYeUxIMUkz?=
 =?utf-8?B?UUFJZU1vb01zZS9PMXdMV0xzM3VNaWI2V3ArM3cvcmFadlZVVEZhaHRDdy9V?=
 =?utf-8?B?N3grRGp6RWo4RlBnMHdKcVVQMjI2Sll4UVpWN2txakRkM2VNRjFzUTlKSWRF?=
 =?utf-8?B?OEZqbVJmOXhiMzhRbEgyMXJtZTNHRjdwcUdUc3QySU9TczI4RlppS1JRVTBC?=
 =?utf-8?B?aEZGbW1kd1d0VTN1aERpbE5yUldpWlo0eDhHaW9rZDRWWG8rOTdzazFTM2lt?=
 =?utf-8?B?dUV4dHVoSC9qMDVTK1RFQkVpa2tOdElDdEgwMmczM21nNTlIemJDWUhTT084?=
 =?utf-8?B?dzdGVDFGU2tuOXZyTDI3YU0yWGo5TmhmdXhQaWZSam1LYXpINjgzL2N1S00v?=
 =?utf-8?B?S3JFeE0vM2txaHhRUUV2a3doQnZCQ283am5lY1NvQmdlZHRDbEdsQUtEMjdq?=
 =?utf-8?B?ZmpoMmRtYTBRVXFpRjluSWREK0QzTkN2RlZvNmQ4cUE5dVNidk9LajVqbm1L?=
 =?utf-8?Q?TIY3MbV+VjH61mjzcc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjBxd0w2TTlIZjE2b3YveGlSazAzMjF6cDUvL25YOUt5V0V4N3QzUHI1OGYy?=
 =?utf-8?B?alVabVhwbU5VS0lTcGdYL25ndlNWZ0R4VmU1L2tDR250TEhyVlowcUJWRWJi?=
 =?utf-8?B?VWFTYjN1YmZFMW9ZNjBOenI2U29Tbis2SmFaMlJxTkNCWTFvUEpNT2hKNGY1?=
 =?utf-8?B?SWdDenVEaW5vUTMwM3gyNSt5dDFCUU8yb3BlZnJFejJ0WFB4ajQ3U1N2L1FB?=
 =?utf-8?B?YlRlYUFtR3NBYlg4My8rb2pBUytJNlI2YUNhRlZZb2xKWlpYWFR0WXJTUnNt?=
 =?utf-8?B?NkpiVDNvMVVvandJZUNEc2dvYkJLZGIzQm95WTh5N2s5OTRFRDFSdVRMUlNU?=
 =?utf-8?B?bS95OENwd3dJVXJXWkVaeUFDMkU1TFgvOGRGOTRQdFM2elhrRDRhdGFRVFA3?=
 =?utf-8?B?alNBQXU5L0xOZzNVR2FwV3VwUzAwYkdxaWZPclpFNDFkY2RTVXdxV2pQYjBH?=
 =?utf-8?B?Zk5rb0pWT3ZhdGVlNXVrY0puZVNhS0Z6dThFYkhqSzE5QlRVSVJONFZ5eitB?=
 =?utf-8?B?blZEbUlSWDl3STJxVjNNVmRzSHpvV1JPRGloQms3Zm9QYjFvUS9PVW85N0NC?=
 =?utf-8?B?L2RhaUNIMzZ6N2FHNnFFa0lHY0FvOW5hTEtCTlpsVGtuZVJWL0QxQUZ5K0kx?=
 =?utf-8?B?RklZampLTis0OGtnSENkWlNGQ3A0aVEva00wZm5WcjRWckNWMDRsZm0xV1Y1?=
 =?utf-8?B?L3BxZ2RMdVZaTStLOG5uZFZZMWdmb3NQTnZ5aE1FQmo2a2dVMk5ndi9LU0hm?=
 =?utf-8?B?Vjl1Y3FGZExBaWUyQ3BKZzRESkZ5YmZOR1U5Ukl2dE1RNGdoTWNhQ0luZkFB?=
 =?utf-8?B?OTAreFFBNlo2VVpieXBXRVVDNG5BaGVQcVFwUzhoSVJxWDBNK3crZU12cDlz?=
 =?utf-8?B?NjIxVFNQQzlCSFBTNm5LNzhYYmw1ejZ4dFFGYXh6c1M3dE1GNzQyOFRtdVZF?=
 =?utf-8?B?VUFSMVFpTDBqS1l5NWFkcVZRcklmazFVK0xWZlFHVXROWDgrZ0pFbzNCL3d6?=
 =?utf-8?B?QkNFd2xqNWFTUUx5UXA3QVlXUUZQTnQwZjBZRDBBRzVhR3pGc0RXT085TnF5?=
 =?utf-8?B?RnlhdUR1VHN5NjFQWThKeS96QzNUMFZmYmNMZXhKRGhibW1oZVpQN2F1TUJm?=
 =?utf-8?B?YURSVFAyejhZeWlvdDNwRThLZDdrMys2VXdQc1d6S0k3TmdZako5b29iQVpS?=
 =?utf-8?B?THRpbHNNT2pUc1k1V25yNnNsMk9UWmwzbzFsWUx1SDhtNzd4aVN5RkhtcWh0?=
 =?utf-8?B?YnBZSzdwcmtDMHpobHlZai9kTHZVRE9JVTBONWVEWGZmSm5YcnFjYXprdkpm?=
 =?utf-8?B?LzRlQkF2M1NjU1EyWDh6VVRZekFSWmtPTlFlVFpKakRDZjJHNHpJVGtHc3VB?=
 =?utf-8?B?UzQ0eUFmSmhrTUN0K21Db3FhcXlKeXNZQnAxejU0YWFpa1lNSTAvbzFBWTZp?=
 =?utf-8?B?aGRjamNZSkdrLzh3YWtla0FiODJ5TlRYc09PTVJrYk9kZk5MZTBGUTZHZVRO?=
 =?utf-8?B?elV3TWdvYWNnaklvM1VnY0xyeEljOUNQUkdqV2I5dm1yNVo0VDUwNWt5cCtn?=
 =?utf-8?B?MjU5NWlYN2d1SWJCZllvQzQ5bzBFWlFiRHMzOUVpWk5maG5YRHVOZlNDYlIv?=
 =?utf-8?B?bjd0SDZaaHNsd0dldCtRbktWdjdieFdNblpHbHVyRGlLWDNmMHVhYUZaYlE3?=
 =?utf-8?B?dnNBUUpEd3QrK2VNaVE2WHd2amN6SXM0RXRhbG5oUFV1Y2xrZkh0NU1ZcFlT?=
 =?utf-8?B?RWZISnFDV0pkSGJVODBTVi8vMXJOQ3FHZnFYQ2lDaFJOT1pXdHJEUCtSc1Nn?=
 =?utf-8?B?a0VmSFBOZkZ1N1V2b2hBQTJIRkRxQVREN3pyTEY4WmNlUDlualRrOExRTXRw?=
 =?utf-8?B?dVB4Mm92QTJoTitKbEM1dFdQN25zbFdSenJiemtiY29nVWlGakxRc0hkdENT?=
 =?utf-8?B?UXNhdDkzUkhnZkh2Rk1BbGZ1T2d6Wi8wRmNRWGEyNU41TXlCZXBVbHluWno1?=
 =?utf-8?B?Y0hWVjMyUjZBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42d54ef-d88e-4756-f9aa-08de5e445479
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:07:54.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0PR01MB10148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254145-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[outlook.com]
X-Rspamd-Queue-Id: 105089E1D1
X-Rspamd-Action: no action

The driver allocates arrays for ports, FDBs, and filter blocks using
kcalloc() with ethsw->sw_attr.num_ifs as the element count. When the
device reports zero interfaces (either due to hardware configuration
or firmware issues), kcalloc(0, ...) returns ZERO_SIZE_PTR (0x10)
instead of NULL.

Later in dpaa2_switch_probe(), the NAPI initialization unconditionally
accesses ethsw->ports[0]->netdev, which attempts to dereference
ZERO_SIZE_PTR (address 0x10), resulting in a kernel panic.

Add a check to ensure num_ifs is greater than zero after retrieving
device attributes. This prevents the zero-sized allocations and
subsequent invalid pointer dereference.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 0b1b71370458 ("staging: dpaa2-switch: handle Rx path on control interface")
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index b1e1ad9e4b48..0ff234f6a3ed 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3024,6 +3024,12 @@ static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
 		goto err_close;
 	}
 
+	if (!ethsw->sw_attr.num_ifs) {
+		dev_err(dev, "DPSW device has no interfaces\n");
+		err = -ENODEV;
+		goto err_close;
+	}
+
 	err = dpsw_get_api_version(ethsw->mc_io, 0,
 				   &ethsw->major,
 				   &ethsw->minor);

---
base-commit: 62085877ae6592be830c2267e35dc469cb706308
change-id: 20260126-fixes-78bb0650d4fe

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


