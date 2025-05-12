Return-Path: <netdev+bounces-189620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C002AB2D27
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7749189C721
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2705B219314;
	Mon, 12 May 2025 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="xfN2LCl+";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="U5SYT+mj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDE211A3D;
	Mon, 12 May 2025 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013310; cv=fail; b=OZnGggMiiITl4YxDnOxU4TkHxFmUfJnFqPp/LEfBnOv6UA+5yp6CA1ZW5gZ1D6+TJvXCWNfpLk9nPo9fWkQlPFOlstqz9aLmuXchjEpS0qUQh4HII3t9+2rmUnogN+TVUDiozEHhQvFoNxpl1zH3LXdZhS8EI3RSafc3vLy4ODY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013310; c=relaxed/simple;
	bh=xKLxqVI75B+T0nmkriO4U748a5AiEtsRMrKWFKfl3cs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TbegBiSoo25Euhgs0KmMFzKORH+10Zz73VQ/buq5d+ZwFR5R6YgdLRaKs+CtZ2fQ1JokaJO0idPq/CxUI2JKJvvTE9aZxdJerRp7ZttTPT1nVyCD8hOCx8uT6v6If7Y9Y2btgoeW6zKqVnhB7zcqft+HTiO7fQZid0YPZqhVmtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=xfN2LCl+; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=U5SYT+mj; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C0dSZD021480;
	Sun, 11 May 2025 20:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=hiB/HACrcA1C27eSnxfZKkcUqdmXdpKawXLNSKb4KTI=; b=xfN2LCl+LaOQ
	OliQzu+hh5pCbzvJUIB6KjYs+0ldcSpJW+u4R43Pn+OkcYI8dnWEhCLpc/Uk72g5
	hHO7+gjb6qeV+pnn2vsBqymWxEC3TDwfQorxaU22o2SoeFuwKYmWSrkghJqkhGeX
	fZmPXyJYssD36IX1hz3fjMoE8IuVlpvhnJyGP/kWDkP+wC+A8khTM8891WvY69Ca
	9L2eIq4YvSB1za/nT87g7q7zVqckGfUmV0S/1fXoY0Gevc9DXN5Sx7sPpk1xyUNE
	QghzEzBBgU/3gFnF/pOjo4jgKhSJU90zH3p+UN+Yw33pgYBJbQ0QIvbV0VCU+07f
	6jhlSdCWAg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j34csvw6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZVexzX571T56N7qoppRrb9w41NnPUr6RkizKtp8GQB50G5Yld8ChF7Z5oYM6r+5p87fTq5Lt2k5Pfn2s+hG+PTRbkaoCKGCdTDaAmazpXUNLJhvBys+2IXkX9j356gbm5C0XBwlBlagUoaQtHInxbvV1tLK47QuW0kIRnh0J24Vfju1VJIlFOFmYEplV+ZOI06iKsgVwfcEhimNI8FxNB7PU9XstaM60q91q7KDqsmqG+LC196wo3i2+kcSayUmzIZcbrmvJLX8mjGxV5nNIpBeBkD50XKvrJEa7e8bRUIXtIimvgTNYTXg/c2oiJtI4mApvYpGflFQL/fFf5DBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiB/HACrcA1C27eSnxfZKkcUqdmXdpKawXLNSKb4KTI=;
 b=vgIMECRvTa4DOdbfRQ5GrHWSK/uhn8qsyLVyd0W+bBBM6kTMlcJj+RX02BewGZIIUAQrPDSX0iT5Q1cW1uqYx7iwCZqJtEuuj5LEGYFPIpD2ClcqSZb+DhNRAZTcbIxO7KpF01duJy+5o+Pl1CpOVUDjP3jgQGdJygs6zJEBXDMbriamwpbG5qKkXLLGKa6fV7j4/HviRExYi5avmkDRvTgEUzRrFJ2Xx+sxb0WVhf5bR4CodW2cQ0aRz3hqWU3kPX7V+VIFx2JTCBI0+dUSHSIyQWPLYkJomk6nUdOPOCgt6Dyv/RT3hXsriTIjsYLnw8AJH0MwyidXVFbtJrA0vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiB/HACrcA1C27eSnxfZKkcUqdmXdpKawXLNSKb4KTI=;
 b=U5SYT+mjyoyaysXu2kD6cIHcEWC3kur7L6VRuhtZhBrZxqFCxWPp+GMSf8ARO71WVyP5jfbF8w5FA7VcdjvBOnzo7rnIkMWcRh1PW9hKVr5v7e18iOem0A1uTYwsfRSJa0OrQIyjGvFMLREy8z+BGuqYhrZmfB/NlxUJHkNsPp0=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 01:28:02 +0000
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
Subject: [RFC net-next 06/15] net: cpc: implement basic receive path
Date: Sun, 11 May 2025 21:27:39 -0400
Message-ID: <20250512012748.79749-7-damien.riegel@silabs.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1cb4743f-75e7-4370-b104-08dd90f43c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjRnZ0Vsc0dJajBlUzBxaUxtZm1BUnVYNFQwbklSclZORGZJTlAyK1orQzBr?=
 =?utf-8?B?RUdOVnZFRHhjWmtORUtwSE9yMXQ0Tnk0bnpWUGE0dGo1MHZKOGpObUQ3OTJs?=
 =?utf-8?B?cDZzTXg0MFg2WWVrOVNBZ0tzTlJUSlhiOTdDQnhLenl6djRGelVNTXdxTGxQ?=
 =?utf-8?B?dUVzQkdHVzZxOXhFZW9GblZCUjdDWUFXaGxiM1pTcWJZbGdpMUwra3c3QlRG?=
 =?utf-8?B?RmNoUDRaczVsblhkeGNNZ0V0bERpNHZUOXdhUjZZWTg0d2hpZm96WmtMNTh3?=
 =?utf-8?B?TUM1aG9GQndXeGZQQWVqSEh6NXJTKzlkMW93RWJ3bGMwQmFPQXp1T1NOMVRz?=
 =?utf-8?B?UjhLYitzVCtsVURPQW5kMTFGbjlIWkhMZEw0RnoxRlYxR1dnU2hXb2I4UVo0?=
 =?utf-8?B?d1AvSklkYnRkNkZkamszOER4Z0xQTTNsSUdDZUJmb1ROK2dRQ1NOUy9XdElN?=
 =?utf-8?B?K085TmJGaCtaR2NCeVpCdHVwaldKRlFKZ1Q2d2FXSUk0L0ZBSFAyWmtCYXky?=
 =?utf-8?B?UlVkdDJWcVhKalBYMnZLNkJjSVBac1pRTVhOWExwWUJiM2trVHM0dkpQZjhI?=
 =?utf-8?B?WFlxMkhJanRHeXdrQ2FSTHE2VHlBdThsMm5GVUhSNjRtT2RCcytkRlREc2Z5?=
 =?utf-8?B?d3ZqeWJwVzhtMXpoVjYxOGZnWjJDWE5Ka01oWFNaRnFsZkc3bGNqN0pNVmRm?=
 =?utf-8?B?bk9TREszMThiZGx6VS9EOFhwOVh0QkZHNmdyM28xMWxJUDh3NjdKZUxYVDln?=
 =?utf-8?B?MTBJdXZyRytJM2R0SlZZVmVSaWdSZnViaFFWbnc3bExGNnZiUmFMWlpVeXlW?=
 =?utf-8?B?UDRudWliR0wrbUhuUHJSZ0xJbzRYN1I4Mnh2dEJQNkVmQnJNcitPQkZDL3dp?=
 =?utf-8?B?cXBmWS8xZFdPa1ZxOFFsQ21yRG5sZTRBSnk2WmMxeGtZMy9OcG1tVFp0aWV6?=
 =?utf-8?B?dWV4Z29IVXNyVW9sYWgzeXQ4Q3lLTnJ1NG5jLzhWUXNYeHVrMVkycDFrbGpn?=
 =?utf-8?B?Tm80RHhoTHYyaU13RlJvOHRwNDBFcld0UWtSWExxNkNGalJsYmFWeTV6STdY?=
 =?utf-8?B?RUQxSkJIQWRrSEhJOGI3VjhiZzNsY3pwUWJQdlQ2ZDd5NjV0MlZTSG9DTzNq?=
 =?utf-8?B?N1pOMlFyeDA5ZDB2aHlOdHN2RE5GUWNHVVVnNU9yZVFPNDRyMDJQOGVUcEVC?=
 =?utf-8?B?OGpKc1J0UDdpTWpOMTFQRW03czA5cURFZEVaWW5nbEozSjFZUFFOTENyU0Jn?=
 =?utf-8?B?OFN1VkZnczNieHR0Y3ppSXVOajY1TDhneXB5WHhSNnB1WHRmSHdVLy95ZkNS?=
 =?utf-8?B?aXVFZFNaRWRHUzF5dUtCWEpTL2J5ZnFLa1JMYWg1Zlp0SitjUi9YZHNzMEhV?=
 =?utf-8?B?M29JQnhJQlV6RHJmbmwxYXE4d1FJZGNWUm55UjlmSnRzdU5LK2VGLzFaTGhG?=
 =?utf-8?B?MHFXMTY4Qk1ZaktLMjVESjk5TU9ZbWpzYWpoMmladFp1RWlGVCtMTmE1a05x?=
 =?utf-8?B?MnFUc2cyejQzc2ZHaUttZ1gvd3JFMFRxcUlDQmkyeWRMNmo5b0lsLy84Ui9x?=
 =?utf-8?B?MFRpbUNUUkpTYkZFUGZQd1o1MGV2UEVUNXJEaGgxa0VHdEZWemJ4T2I5VWFD?=
 =?utf-8?B?VU1lN041cjJERjFqeUNIV3luSXFqcWo2Lzd2a05XbWUzdFYxQ0Rlc2pPWTBZ?=
 =?utf-8?B?UFcxRzhLUVIvdXZIK2xEZWpSMkNINXBDeUt2S0M2ZGdOSmFmUXNWYnFmVi9i?=
 =?utf-8?B?N0w5Nzh3QnVuN0xFMmFBME11eDM0UEExcis4Z0Q1dVN0L3BxekdSNjV0eXhy?=
 =?utf-8?B?SHlHNXZ5ckNaLzh3bzhkdk81RWhNWDU1Zm5iZUtzeXZZTE15M0MvRkdoRVRB?=
 =?utf-8?B?d3VXcTZTOCszblc1Nk9wcTdWb042QTM5c244b3d1S3hpZEY0SnhacHZ5WW1E?=
 =?utf-8?B?eVM5aTZzSEtGd3pESDNjYXVSN0ltVHB2RFVUM3ZDVUU5YmVNT1pxTmxxZFBw?=
 =?utf-8?Q?AsUHf6vuF7DGbTi5BJiKpOFLfitA3s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGI5OVNqVWt4WGdsQmdmTzJzSFlpSkUxSjYyUGdqY2Zidit1bTF1NkUrZHF4?=
 =?utf-8?B?bC9UdDQza2tjWUt1TnE1TWpXSTFuMUpYVzRYNXlCbGhOTVpKclpVb0lhVE1j?=
 =?utf-8?B?VFhOTmFzNDY2YnNwd1lLTWRLV0MrckNYTm5KUm5IclBQdXJOUjBiZjZQTDQw?=
 =?utf-8?B?cmgvaWEyaTczTk1QdVc2NHBDbzhEZzJxbnNMRzNoV2NKMUs3dGhWbGZlY0VR?=
 =?utf-8?B?NEZsSjc4dGxjMW5zTkF3VWVYUTVCNEE1YjRLT1BtVU1aYktVNnlrdXNsOG5v?=
 =?utf-8?B?a3NPeVN4VE9SVG05aDBiUVFrbEdmMFozN0I0eUNKSmR0UnAzOWQrM2MrN3dj?=
 =?utf-8?B?WklvMjBuTE0zaTYvYnNGVzY0dDczRmpONm5nMnhXUThRN0FtOG5BVkN4MXQ2?=
 =?utf-8?B?UVIzc1J1M3ZPKzBmdFc0anROVkFKc1ZTMTlWM3BXZmVlT2tnc3hpYkIzcHFM?=
 =?utf-8?B?c1Z3STBEVHEzYjZHRGt1dGRIVUl6S2NRWXRpWk05Q0s3WjBaWXd5aURiejNI?=
 =?utf-8?B?ZE40Zkh3NkZ5U3NGVElXd2QzQ005TXNUNElZd1dDYUMvRWRUcld2MTBkV2Mx?=
 =?utf-8?B?RnNmSEtWT21pOVFWYTB0clB6WFhMaDhDaUlFNGdYSTNmNHV0aUd4SDd0RTlS?=
 =?utf-8?B?bFRFZUl6eVpuay9BeGw5bHJWaU1hZ09pTHpBMnRBUHBpZk1FdnlWRjFoY0ZL?=
 =?utf-8?B?dUVQYUt3OU85bW5MUHlWbjBkR3A0d1BpVVpQMDVNYWMxMlozRm1iOXBidXFl?=
 =?utf-8?B?MlQ2UGg1TFFNczZFaUdzR1E0UE5QbllrTGdTWTZJTzQxMWIzREdUYkJuTUk3?=
 =?utf-8?B?K3dES09Eb3FTOFZxejBaNFRRbE0rYTVnZG5nTVE0ajlKcUNob2FEK280T3VU?=
 =?utf-8?B?Qktzb2tvUzNsUHErNm8vWHJ1UFVCcWNZSnI3RzMzUjB6VHhxNzJSdnExSnN2?=
 =?utf-8?B?cGlkak8yZVBRU0FLcjJONVp4QkJUUGQvbHMvcGdzenZ1cTk4SFVMV3d1Ymk4?=
 =?utf-8?B?RVAzNDh5ci82Q09icHhSSUFXdmUxVVkraklhNE01aTRlVVdMZm9RL3lKOGow?=
 =?utf-8?B?Wld0LzhJRVlEQkwycnB2QmVHbUsyODFNamZmSmwrK3BEaUpvbVhJSWtoQllH?=
 =?utf-8?B?d3ZMaVA3NnRsbENPWDNaQjM2MldwS2krRm9saUpnSWx5SkhGQUJ6QmZFYlox?=
 =?utf-8?B?YmxSM0FXN1c1dUZWb2ZucnBRRXJYSFdDMGdwVGMyMjFVRVltTFljQ09ZTlhD?=
 =?utf-8?B?TXFTekpvb2lTUlJRZk5GaHR3UlNBUjE2QjJkamp6UjRjYkdMN1lvR0VXTW5N?=
 =?utf-8?B?bDhJTmFML2tvd2N0Ry9HSUxPM2dnS2NWQWVGbTFLMlZlc1RPQWFQUG4vcldE?=
 =?utf-8?B?SFdEbUlHWlF1b3hKT2FvRVE0ZEszUm1EcWhpbG1jN243ck1EQXQxWXRYR1kx?=
 =?utf-8?B?THNWNHNXUDFxcE5IVVpNV1hraTNZQnVWNm54Y2hsT0Vwa09xZTlWZ0JTVXNh?=
 =?utf-8?B?VGVIY2FuOXY5OWJRT2ZqUG5OT1B3VG53S09nVFk2dm16Q3JrcHRVajFHbmkw?=
 =?utf-8?B?REdkRGJoWURzY0srdU5CS0tpWXJ3cjQwdSt0VExrelJNZU5PeWJDT01NMWdY?=
 =?utf-8?B?VXl5c0s3emI4cXVpK3hnYWVMTXV3Vld4M0VBVjJDK0ZadHplRmZKTE9vc0FC?=
 =?utf-8?B?dkYxNHBWOEVIL3FJOVVVZzI0R0dPNGlibW5OVUgyeDFSOGZVVkQ2cWVlUlN6?=
 =?utf-8?B?YitSR1h2M0dZWGFQT0ttR0VlN2FiYzhSY0hyQ1pEWDhId2QrZWM5WTJ3a3Rk?=
 =?utf-8?B?SHlZNHp6aGlqWGhMYnlscU5zVGZNRlZtRkVuZHZRQjdrVFpFbVUzNkluQUU4?=
 =?utf-8?B?b1dqSys0Yk5rcXBmOGQveW94Wlk4K253VVRVRVh5N2kzdUloeGh2MXJGa2R6?=
 =?utf-8?B?UUtoUkhsdGJyTldJdVZQNW00ZXlYNU9GeFduclZGZmFPRGlCbFE1bTdhRUxV?=
 =?utf-8?B?aTNBYm1BYzgxRUxWOERCdHk2TlRxQ2I0MVRlb0RLVjYxajQySmRWNExoOFhB?=
 =?utf-8?B?SFZHRzd6ZEtGemdGTDAyOGVTck0zcW5lTGhCelZoNEFtVXo4Y3lORzIwUUlV?=
 =?utf-8?Q?O7XzLxnRLFIcIUqscNp0WhqaN?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb4743f-75e7-4370-b104-08dd90f43c9d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:28:02.1685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GPFCejTBIuoXuFglYhDiaDY96V3np7GMuW2iz2xZTKkEKKnFUPujqpPHKkuw5zrFw+REw/YdOa3WIV/6JJuyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-Proofpoint-GUID: oCi3p5LiMFmz3gQG5IFeSSxUI7wYfMUm
X-Proofpoint-ORIG-GUID: oCi3p5LiMFmz3gQG5IFeSSxUI7wYfMUm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX4GuKO0Zy9SCD dtxt4Qn5V/33+Ag4B3Z9n0HrCAxqmUXMYsP3h3spBoHS/rRz7IoQ4l3O0E7bFUAKzQLPkw3tFaj EYy1fHF4B7nj5d2MZR8rki60UdK0/SQoSEpU2YIifKJdS3q0eVNNvzwO+tA7WByDDddBbqj/8uB
 FBZUYM4vkLdOaPkyG8aXelPd8xFVwayoY7e3rcHxdz4kKOnJwDtLIBcoOErCn7gWBAEIAg7PKzM vjmbmZwLAEI5H3bn93xvKHx3fD9Sllyi3jILKX5I/Zx95GN093cx+T4shvyTyI84u/TOe7jcRb/ wuVFjXUwL2uElhQJhZuAO9iubKSoEaza7aOXp3OHjgIyBZaSH/VZiMNK3WKcotNLdpeQqPjQJKr
 PzAYPjPlgmOVJnxnkgMtjSnmpwO+g/Ng3w8cRLZzsZJYFzWhHp6iDM1MFkFV9bZylu74vxrr
X-Authority-Analysis: v=2.4 cv=L/gdQ/T8 c=1 sm=1 tr=0 ts=68214ea6 cx=c_pps a=X8fexuRkk/LHRdmY6WyJkQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=rBU6LZDfq31Z93SBm0AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

Implement a very basic receive path. When a new frame is available,
interfaces are expected to call cpc_interface_receive_frame(). This
frame will be handled in a high-priority workqueue and dispatched to the
endpoint it targets, if available.

Endpoints should set an RX callback with cpc_endpoint_set_ops() in order
to be notified when a new frame arrives. This callback should be short,
long operations should be dispatched or the main reception task will be
blocked until that processing finishes.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 drivers/net/cpc/cpc.h       |  9 ++++++
 drivers/net/cpc/endpoint.c  | 11 +++++++
 drivers/net/cpc/interface.c | 59 +++++++++++++++++++++++++++++++++++++
 drivers/net/cpc/interface.h |  8 +++++
 drivers/net/cpc/protocol.c  | 15 ++++++++++
 drivers/net/cpc/protocol.h  |  2 ++
 6 files changed, 104 insertions(+)

diff --git a/drivers/net/cpc/cpc.h b/drivers/net/cpc/cpc.h
index 2f54e5b660e..dc05b36b6e6 100644
--- a/drivers/net/cpc/cpc.h
+++ b/drivers/net/cpc/cpc.h
@@ -18,6 +18,13 @@ struct cpc_endpoint;
 
 extern const struct bus_type cpc_bus;
 
+/** struct cpc_endpoint_ops - Endpoint's callbacks.
+ * @rx: Data availability is provided with a skb owned by the driver.
+ */
+struct cpc_endpoint_ops {
+	void (*rx)(struct cpc_endpoint *ep, struct sk_buff *skb);
+};
+
 /**
  * struct cpc_endpoint - Representation of CPC endpointl
  * @dev: Driver model representation of the device.
@@ -39,6 +46,7 @@ struct cpc_endpoint {
 
 	struct cpc_interface *intf;
 	struct list_head list_node;
+	struct cpc_endpoint_ops *ops;
 
 	struct sk_buff_head holding_queue;
 };
@@ -50,6 +58,7 @@ struct cpc_endpoint *cpc_endpoint_new(struct cpc_interface *intf, u8 id, const c
 void cpc_endpoint_unregister(struct cpc_endpoint *ep);
 
 int cpc_endpoint_write(struct cpc_endpoint *ep, struct sk_buff *skb);
+void cpc_endpoint_set_ops(struct cpc_endpoint *ep, struct cpc_endpoint_ops *ops);
 
 /**
  * cpc_endpoint_from_dev() - Upcast from a device pointer.
diff --git a/drivers/net/cpc/endpoint.c b/drivers/net/cpc/endpoint.c
index 4e98955be30..51007ba5bcc 100644
--- a/drivers/net/cpc/endpoint.c
+++ b/drivers/net/cpc/endpoint.c
@@ -172,6 +172,17 @@ void cpc_endpoint_unregister(struct cpc_endpoint *ep)
 	put_device(&ep->dev);
 }
 
+/**
+ * cpc_endpoint_set_ops() - Set callbacks for this endpoint.
+ * @ep: Endpoint
+ * @ops: New callbacks to set. If already set, override pre-existing value.
+ */
+void cpc_endpoint_set_ops(struct cpc_endpoint *ep, struct cpc_endpoint_ops *ops)
+{
+	if (ep)
+		ep->ops = ops;
+}
+
 /**
  * cpc_endpoint_write - Write a DATA frame.
  * @ep: Endpoint handle.
diff --git a/drivers/net/cpc/interface.c b/drivers/net/cpc/interface.c
index 1dd87deed59..edc6b387e50 100644
--- a/drivers/net/cpc/interface.c
+++ b/drivers/net/cpc/interface.c
@@ -6,12 +6,44 @@
 #include <linux/module.h>
 
 #include "cpc.h"
+#include "header.h"
 #include "interface.h"
+#include "protocol.h"
 
 #define to_cpc_interface(d) container_of(d, struct cpc_interface, dev)
 
 static DEFINE_IDA(cpc_ida);
 
+static void cpc_interface_rx_work(struct work_struct *work)
+{
+	struct cpc_interface *intf = container_of(work, struct cpc_interface, rx_work);
+	enum cpc_frame_type type;
+	struct cpc_endpoint *ep;
+	struct sk_buff *skb;
+	u8 ep_id;
+
+	while ((skb = skb_dequeue(&intf->rx_queue))) {
+		cpc_header_get_type(skb->data, &type);
+		ep_id = cpc_header_get_ep_id(skb->data);
+
+		ep = cpc_interface_get_endpoint(intf, ep_id);
+		if (!ep) {
+			kfree_skb(skb);
+			continue;
+		}
+
+		switch (type) {
+		case CPC_FRAME_TYPE_DATA:
+			cpc_protocol_on_data(ep, skb);
+			break;
+		default:
+			kfree_skb(skb);
+		}
+
+		cpc_endpoint_put(ep);
+	}
+}
+
 /**
  * cpc_intf_release() - Actual release of interface.
  * @dev: Device embedded in struct cpc_interface
@@ -23,6 +55,10 @@ static void cpc_intf_release(struct device *dev)
 {
 	struct cpc_interface *intf = to_cpc_interface(dev);
 
+	flush_work(&intf->rx_work);
+
+	destroy_workqueue(intf->workq);
+
 	ida_free(&cpc_ida, intf->index);
 	kfree(intf);
 }
@@ -54,10 +90,20 @@ struct cpc_interface *cpc_interface_alloc(struct device *parent,
 		return NULL;
 	}
 
+	intf->workq = alloc_workqueue(KBUILD_MODNAME "_wq", WQ_HIGHPRI, 0);
+	if (!intf->workq) {
+		ida_free(&cpc_ida, intf->index);
+		kfree(intf);
+
+		return ERR_PTR(-ENOMEM);
+	}
+
 	mutex_init(&intf->add_lock);
 	mutex_init(&intf->lock);
 	INIT_LIST_HEAD(&intf->eps);
 
+	INIT_WORK(&intf->rx_work, cpc_interface_rx_work);
+	skb_queue_head_init(&intf->rx_queue);
 	skb_queue_head_init(&intf->tx_queue);
 
 	intf->ops = ops;
@@ -157,6 +203,19 @@ struct cpc_endpoint *cpc_interface_get_endpoint(struct cpc_interface *intf, u8 e
 	return ep;
 }
 
+/**
+ * cpc_interface_receive_frame - queue a received frame for processing
+ * @intf: pointer to the CPC device
+ * @skb: received frame
+ *
+ * Context: This queues the sk_buff in a list and schedule the work task to process the list.
+ */
+void cpc_interface_receive_frame(struct cpc_interface *intf, struct sk_buff *skb)
+{
+	skb_queue_tail(&intf->rx_queue, skb);
+	queue_work(intf->workq, &intf->rx_work);
+}
+
 /**
  * cpc_interface_send_frame() - Queue a socket buffer for transmission.
  * @intf: Interface to send SKB over.
diff --git a/drivers/net/cpc/interface.h b/drivers/net/cpc/interface.h
index 1b501b1f6dc..a45227a50a7 100644
--- a/drivers/net/cpc/interface.h
+++ b/drivers/net/cpc/interface.h
@@ -22,6 +22,9 @@ struct cpc_interface_ops;
  * @index: Device index.
  * @lock: Protect access to endpoint list.
  * @eps: List of endpoints managed by this device.
+ * @workq: Interface-specific work queue.
+ * @rx_work: work struct for processing received frames
+ * @rx_queue: list of sk_buff that were received
  * @tx_queue: Transmit queue to be consumed by the interface.
  */
 struct cpc_interface {
@@ -37,6 +40,10 @@ struct cpc_interface {
 	struct mutex lock;	/* Protect eps from concurrent access. */
 	struct list_head eps;
 
+	struct workqueue_struct *workq;
+	struct work_struct rx_work;
+	struct sk_buff_head rx_queue;
+
 	struct sk_buff_head tx_queue;
 };
 
@@ -61,6 +68,7 @@ void cpc_interface_unregister(struct cpc_interface *intf);
 
 struct cpc_endpoint *cpc_interface_get_endpoint(struct cpc_interface *intf, u8 ep_id);
 
+void cpc_interface_receive_frame(struct cpc_interface *intf, struct sk_buff *skb);
 void cpc_interface_send_frame(struct cpc_interface *intf, struct sk_buff *skb);
 struct sk_buff *cpc_interface_dequeue(struct cpc_interface *intf);
 bool cpc_interface_tx_queue_empty(struct cpc_interface *intf);
diff --git a/drivers/net/cpc/protocol.c b/drivers/net/cpc/protocol.c
index 692d3e07939..91335160981 100644
--- a/drivers/net/cpc/protocol.c
+++ b/drivers/net/cpc/protocol.c
@@ -39,6 +39,21 @@ static void __cpc_protocol_process_pending_tx_frames(struct cpc_endpoint *ep)
 	}
 }
 
+void cpc_protocol_on_data(struct cpc_endpoint *ep, struct sk_buff *skb)
+{
+	if (skb->len > CPC_HEADER_SIZE) {
+		/* Strip header. */
+		skb_pull(skb, CPC_HEADER_SIZE);
+
+		if (ep->ops && ep->ops->rx)
+			ep->ops->rx(ep, skb);
+		else
+			kfree_skb(skb);
+	} else {
+		kfree_skb(skb);
+	}
+}
+
 /**
  * __cpc_protocol_write() - Write a frame.
  * @ep: Endpoint handle.
diff --git a/drivers/net/cpc/protocol.h b/drivers/net/cpc/protocol.h
index b51f0191be4..9a028e0e94b 100644
--- a/drivers/net/cpc/protocol.h
+++ b/drivers/net/cpc/protocol.h
@@ -16,4 +16,6 @@ struct cpc_header;
 
 int __cpc_protocol_write(struct cpc_endpoint *ep, struct cpc_header *hdr, struct sk_buff *skb);
 
+void cpc_protocol_on_data(struct cpc_endpoint *ep, struct sk_buff *skb);
+
 #endif
-- 
2.49.0


