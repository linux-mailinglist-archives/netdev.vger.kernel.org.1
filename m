Return-Path: <netdev+bounces-223195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B90DB583BB
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43952483DAE
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE9E28151E;
	Mon, 15 Sep 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="V2LQdOx/"
X-Original-To: netdev@vger.kernel.org
Received: from iad-out-004.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-004.esa.us-east-1.outbound.mail-perimeter.amazon.com [18.207.52.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC727A908
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.207.52.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957633; cv=fail; b=THMCBP6zv7bxuMlj8dctaDhez70Dojd6ieIym+yPUSpXGs+9fKPFcCkVOcBOdnU4xF1hgu5orb1l8Gui+N0cqPv3Nl1NAi8cJldapFu16d6AnHoARhwZaWVFQNyGe+aY+08rTUaX261DvOC/c5RW6K1QDzs334HZUUOL3C5Y0Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957633; c=relaxed/simple;
	bh=WUc+Ig35ODFpwlmNCZXNP0Z0f23jneAiRQJG6w0ysJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X1ro9OJqvXRniod2D/bie/ukT4uN67AEeP1Do6f4eL5rnByTJHiRRk7Jq7SJ7mDqcWrvLvvDBj5e5yk9suPOge49XEJIQ9wi9xVtuPm/m8QNaG/uob0j3BCoVy/hsipHm6oQnI9Pr6dz4wIQtQbhiewNMm1eCxnc7WSB8M11pyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=V2LQdOx/; arc=fail smtp.client-ip=18.207.52.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757957631; x=1789493631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WUc+Ig35ODFpwlmNCZXNP0Z0f23jneAiRQJG6w0ysJo=;
  b=V2LQdOx/ORhtm2T54Yj3KUQPL1SGthyEUo0OBWGh1lqcqA36qtg7zxo3
   rVA2V6Rr3fG4UYjC8Em0IwE0h7PsYJ6ROONr3reEsYLB8YQcVUxYhkABL
   lL2u1V3BsZZnFe4YVSSe1rnA6PIuivIwfk2Z1RUNCikHz7LSYZIsWDrW9
   kc5HBLHTbKe9wB5NxZlcGlN1MfjmZpQlTAkY/hFJrVlAER3QbV2fJvRQ9
   mq0nW8ZdL5fUaMTmAxwA8fOM4VKlCMnNihpsUnmP6hsiUeZKlGa3Yku7W
   srL0jZEksgRNHCJ9tc6WSMTzPh8ByN7S5YlUEKTD1rWchto8GitD55NXr
   A==;
X-CSE-ConnectionGUID: /NTk5j5DRQixzhn42MxXeg==
X-CSE-MsgGUID: /we7NwrURaSXpdZOrc3ZPg==
X-IronPort-AV: E=Sophos;i="6.18,266,1751241600"; 
   d="scan'208";a="2694107"
Received: from ip-10-4-22-235.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.22.235])
  by internal-iad-out-004.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 17:33:48 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.29.78:45739]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.62.189:2525] with esmtp (Farcaster)
 id 720652c5-3914-4249-afec-e350ad3c9b4c; Mon, 15 Sep 2025 17:33:48 +0000 (UTC)
X-Farcaster-Flow-ID: 720652c5-3914-4249-afec-e350ad3c9b4c
Received: from EX19EXOUEA001.ant.amazon.com (10.252.134.47) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 15 Sep 2025 17:33:48 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.252.135.199)
 by EX19EXOUEA001.ant.amazon.com (10.252.134.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20
 via Frontend Transport; Mon, 15 Sep 2025 17:33:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Up0iOPVoKh7+x5Ty6fq+NOmXjcVi31wLiQc1L4g2KjCNlxV+4kL3BuV47IxOU7qXDh4opHV9OxKiZzrLrSnZ3Ya2MVk80tWbAVLeOlKns+oiciBk6aX9smZe8Rasx2MzXoeabwRf359Tho8mGDMoqbbTw4xrCdCY1AByOCR9b1S3+eyWeaogXXf7+0Ia8jux3Ilj+XDO88nulZHLqAtIDrCyCFnQ/ua+aDhmjR/M3i9jX24auzt6Y+M9GR+IbluDNdeypix1rnmL4p31ygQcxJArjpFYvQIi8tQN7uJ+soMJGMTUxg7nc5rpu/yKUTvaQrA/RFLJ9azcOlx6tEwBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUc+Ig35ODFpwlmNCZXNP0Z0f23jneAiRQJG6w0ysJo=;
 b=PMdLiicDrDO3GrI8u0nzK5VOauzcRXtTo35nvnZ4bSvgnZ3ptZ6fc+5ucXcYIP10v+HuD1rp7DadRX5wouODjTAoh1WBQxq+Gv8cp02GVGjwlruHNakTHrnOwtyZrQmKHJCQK/9hjgARe8lfsMySi4CQ/0AMXeMdPvHlkrAd1hWCnWb3LHfp7Q//DRbAYskMnvEdXuYxXji0y2izXMmtkhsVp8Z7+klAmGOUHBHMqx93Z4Mt63I7CUtygSk6oL3sgRr+DCgVstOyWY772SWQ0nnUc0BIEofLyFyCMJvoZQa7zhtUDtiE4W/Td2HHUvghOYeBIrWSiqvR0In+3zrGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from BL0PR18MB2162.namprd18.prod.outlook.com (2603:10b6:207:42::13)
 by DM3PPF260D102EA.namprd18.prod.outlook.com (2603:10b6:f:fc00::694) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 17:33:46 +0000
Received: from BL0PR18MB2162.namprd18.prod.outlook.com
 ([fe80::46f8:845a:baa4:9606]) by BL0PR18MB2162.namprd18.prod.outlook.com
 ([fe80::46f8:845a:baa4:9606%5]) with mapi id 15.20.9094.021; Mon, 15 Sep 2025
 17:33:46 +0000
From: "Belgazal, Netanel" <netanel@amazon.com>
To: Andrew Lunn <andrew@lunn.ch>, Alok Tiwari <alok.a.tiwari@oracle.com>
CC: "Allen, Neil" <shayagr@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net] net: ena: fix duplicate Autoneg setting in
 get_link_ksettings
Thread-Topic: [PATCH v2 net] net: ena: fix duplicate Autoneg setting in
 get_link_ksettings
Thread-Index: AQHcJmbjtAzp7LEH4kiiOySeVz/0PA==
Date: Mon, 15 Sep 2025 17:33:46 +0000
Message-ID: <B0D2CFDF-B86E-4C27-9ADE-8A9295C60656@amazon.com>
References: <20250912202201.3957338-1-alok.a.tiwari@oracle.com>
 <96f1e320-a777-4828-a681-80f81f9a44de@lunn.ch>
In-Reply-To: <96f1e320-a777-4828-a681-80f81f9a44de@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2025-09-15T17:31:28Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=8fe9092b-3718-4432-83a0-34934aa3c359;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
user-agent: Microsoft-MacOutlook/16.100.25081015
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR18MB2162:EE_|DM3PPF260D102EA:EE_
x-ms-office365-filtering-correlation-id: ce9f078f-151c-4c82-c9d5-08ddf47e0663
x-ld-processed: 5280104a-472d-4538-9ccf-1e1d0efe8b1b,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?T05hUkJoMFZJNEtxMGxWdlRBcVM3Rjg5bnFtVi9NNlZsejZ1S3hCRU1pWFFs?=
 =?utf-8?B?TDVEY0oxQk5ybWFFa0RPVXczVTgxM0Q1NFNkQmtHa0V3bWlFODdRQWNiUW5N?=
 =?utf-8?B?TDFtdVc5OWVRc0FOUHp4bmN6bXNGdkxHNjQrRjNyTEZuZ3VZSDQ0MFpHSUZn?=
 =?utf-8?B?ZlBPbnhuWmZCbHVFRXBIMUFReUJJSUZ4RjVjSzZFNnoxYmsyelYwbGg5Z3k5?=
 =?utf-8?B?R3Ura29XMVRxZGZrRHBZenlXcXk5SG9rN1k2SlBOVWoxeWJKakFHY2Q2TGdE?=
 =?utf-8?B?aDlIWHIxZkxNdUFCYmQ3WHFuNkhTUllNeHcwU21mS2w1UWozVEJVd0dVdmQ4?=
 =?utf-8?B?bTFHYXUwaUVmLzk1clJtenduNm8rWFJMbEpEUWtCY203WTZsSkRiNXI1a3NP?=
 =?utf-8?B?WjhTUUJXT0ZOdHpIYzJhTUkxa3RJSG1qaFkzY1UvaFU4QkYrYmpGS2c5YzFK?=
 =?utf-8?B?cWswYUZsajNBNzBFMGNYQjQzYk9xS3pocmVocytYektBL3htK2lIYWNIZ00z?=
 =?utf-8?B?UGNIUktLemNrTktaUURsYnRKMTdTdmFQMzJjSkVMaVNRTjhVZTdOdnZmS2xu?=
 =?utf-8?B?S1RPdnJCZWJXYmZqYndON2h1QlpxQkZrTXV6UTB5WUcwaStoTzM2V3czOWdB?=
 =?utf-8?B?Z0dJVkFObHRTODc2eU9aSjNsSCsyRjI2ZVNwRm8vM3FBdzFZN2hJelN5ZzdO?=
 =?utf-8?B?SmlmdFZkRFNETUdvSUNmRnRrUWJyUGhOR3NpKzNTaG92OWdzbyt5MjlqcEpX?=
 =?utf-8?B?TE56VkN5ZEMxeHJNekl1Mkw4SmtxUmV4eUNQTE1QcXlIeE5uU0Q1ZU91MlNV?=
 =?utf-8?B?ZzdYR3FMMEU2OFRrN2RTSG1VdHcwMHhuV2MyOEtQUmxQRFdlSGZhVnl0Rlg1?=
 =?utf-8?B?WXV4WGVpWmdCYXdZUTFDVzQ5UERLQWd4YWt0MTNCQk5tQXV1Vlhld3ZWTzRG?=
 =?utf-8?B?aDgvb1paNDQ4bm1aR2l6OEFOeVZoc29hODN3OGRleWhqem5XMy8xNmV1SGpU?=
 =?utf-8?B?M2FscW1FdDlLTWhzd2svT0l3RnFtc2tjVEZwUm80SGZ5UmlXRkVuR2cwdi9Q?=
 =?utf-8?B?U1NqZ21ueDZGMFBxTFVCK0FpK0x1UFU0YUgvdG1Wc2J3NnNiMCtMMm5Vdy9V?=
 =?utf-8?B?MmxBbVcybStZM1k2dkU1UkRLT2YyOW5ZODBybjI3QnFsZ0NRQ3paZi84ZDRw?=
 =?utf-8?B?R1ZLZElRb0hoRlQvenhrVG02Njh2Rk0wQmNYRFlLYmxpM0pUalU2amt4d3Ez?=
 =?utf-8?B?NXpvM2UzSEFERW8zc3d6Qmk4V2xFVzRsVFVwdkNLL25KRWNoMHJETHlOaTRj?=
 =?utf-8?B?eHBEbFdNcHBveFViamtYeHpyT2FRMlBLMDV1N1dhUjJXQTVxeDJtemRSNmU3?=
 =?utf-8?B?WWpUNVd1YXJOZUdjNjkyV0V3YTRBaUM2RXhtS20xaEdvOWhhY3hQOW9RNmta?=
 =?utf-8?B?TDZkTTh2bGpEYTB6R2xsdi8wM2w0VHlScENTVDhleVp2SXpVd0U0K1pPMjd3?=
 =?utf-8?B?enA3dUx2UlNXS25FVk5GOTFKSlczRE43aHNQSUJ4UjZEY0VyamhFaFFVS3Zq?=
 =?utf-8?B?SFlGM1BhME1OUjRpSm1FT2pGREFRa21LVTFka2JzLzlEYzVpaURldUdTY1FS?=
 =?utf-8?B?c3I3ZUd1Q2VsckYrbzlRT1hZWWo4N1V5K0RCOHh2NCs4eWU3ellOOXdLbEFz?=
 =?utf-8?B?QzkreTJPdkZLQUo5Q1d0REFoQmtzMGZZMjBYYzlsQUpnS3FmalNnL2FmQ1VT?=
 =?utf-8?B?dW9kbjl0NERPSCsyYmFwdVczcXJKdEdoN0JZR2xjbzJ2OUE2TGtXN1FPMmRS?=
 =?utf-8?B?cWovUHZ5TzhQSjFpMVhSS2g5SzRqeFQ2WitVcVVPOG1iTVFYeEtkNUlTOWVz?=
 =?utf-8?B?OWRpdzM0cUFxd2tIY3lNVEdjQ0lYalVJOHZZZEtnMUR6eUViT3hQYzU4ZkMr?=
 =?utf-8?B?T05KNHVGNHJxczU3WU5EVHNkU1p6SHJLcWJyWFBncnBtK1FWdk52MUY1RU5I?=
 =?utf-8?B?WS90bUl0ZzZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR18MB2162.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MllXVFhxeGIyUkRTdnBPaUxZNFZhNytVNFRmcUVleVM5TWs5K2xvT0c5cks0?=
 =?utf-8?B?QmVvNWhWQnhUSXJjOFBZYi9adEZKRFlZa2Y0bFdPUGttWHFJcTg5Vlh2RzBV?=
 =?utf-8?B?bkZoTGhaVW80dncvcjZ5OXZBeEtlb1R5aE40OGNwNURPUXBFOUx6bnR0TFFC?=
 =?utf-8?B?OCsyL2dYZzNHWmQybm8wblg4ZzdYSDRmTk0zb3lRWmtBaXYxYXhQbXcyZlNO?=
 =?utf-8?B?N1YxM1h3UDBqVlllbGw5aitJVjlqeTdsOW80M2ZZc0ZzaE9aNDJReWt2Z1Zs?=
 =?utf-8?B?RGVMNmMxRG9FRS8zc1ZEdnA5MjZhRDNud0VGT01uY1pnNFl0dXRkVkNINExT?=
 =?utf-8?B?emZuU3NlUG1kdGZOYlJrQkpuWUNVZUMwbjYvYjdKR2NFU09jb2FSR3ZzN3FB?=
 =?utf-8?B?akdLaFlyMkhjRUQzYUxmZnNXQUFxSXcyUXpZSDUycjBwNzNBMXJpZnlEZHJI?=
 =?utf-8?B?Uy9PWXNKMXliZlFvc3JZMjBiRTgxamk3Tk9yUzBQVmJKOFhBYldtMjZCS2lD?=
 =?utf-8?B?ZHlmY0l6UHZrTFhBaDJoK3FRMFEwZXlwbEkrWThwYXJpUUthckg3cWgzV292?=
 =?utf-8?B?Q01EZytmak1JV1NsdlVZcXN0Qmx5MEZXYVl6ZjZlakRWa1kwLzR3NmZoUGV2?=
 =?utf-8?B?aTNWWGVuZzFuaWhocW93SHIydVVjTllEcUlBWmNmeUJtZWN2bDZ6aVRYR3hD?=
 =?utf-8?B?WnNyS0k0amUwcXE3YzArbFdSWTkrWWlUVi91S3BxOEtYaGd0VU5GQkpidkVk?=
 =?utf-8?B?RFFBTUxNNGFpUGRwRmVhdkRleWZGM1FET3ZSVmF1NEVIL2ViU0pBUG9GVi9T?=
 =?utf-8?B?YnRDelVkK3NNUlB3NUNRMTdjQm9iZjVVSjcva0E2TExJNWkva2tObUIrVUkw?=
 =?utf-8?B?WHVxUk1TdXdONmUyYTBId2RvNTRJREx5cmRWVXdFejQxeW1tcXllQnZTb3Bt?=
 =?utf-8?B?MkIxT01VeHgyTHpHS0pCckllMzJmN0xFR3ExTmI2SHVlcDZJbnZHcyt1RXRB?=
 =?utf-8?B?UkF0VU9VQzZvcnRkWVpaTTFDQksvMFlmZVJsT1d3VnYyN3RKZmxZcGlFTTB6?=
 =?utf-8?B?NnFORElVR2VmT0tBZkFOais1UUVydGFRb0hGUVBCcVl0ZGRWeFRjdzlURUNv?=
 =?utf-8?B?elRXd0FtNlpWM0NiM0dZV1JNQVVLcXo1bmVyeFpGVW0wNGxQTndsRWFQMXNa?=
 =?utf-8?B?YU0zV3kxYXU2UU1TMDVlOC9HTll6NHpKYUQzWDNscks0eEtaM1BSdmJJeThT?=
 =?utf-8?B?QW9nU3c2NzhuVk1id2tRaUZtOFZYQ1VXRVBEM3BITnRmaDhEYThGSG5xekxy?=
 =?utf-8?B?L1Z6aUhzQ09mOThCUVdIR25EQngwUEQwS1dCQ2ZGemdUaUoyc0hNVSs3QWFr?=
 =?utf-8?B?ZlVDTkRic24wcytGTFNJYnFlYWJCckx2d3BRTHNwRStaclRDQjkveXZEMnJp?=
 =?utf-8?B?S2tRNzYvaFVSbzZuMVp1OXdZTFJxRFcvZnpuNnNSWWc2ZnJ3VFFVMTdDZVFW?=
 =?utf-8?B?ektOa0I4bWlVRk92QkdoU0FIQ0ZzbFltc0U3MmpkYmVCajdwY0M5ZXpsVC9h?=
 =?utf-8?B?OS92WDd4dWxIYzVnemJKbVgyaWtRcUFsVzNzNmc5QSt2dUs3d3JhcWZqUjhS?=
 =?utf-8?B?VkVJNDZGbFZWZUJQa1UzWWhSdVNmc2ZkYlFxSkEwdENmS29ZOXZyMjB2T2o4?=
 =?utf-8?B?VjF1bHRldUVEVVNGdkVGZk94a2pOQW54TGdGaWZKbWt1czhBRENGM2ZtWitK?=
 =?utf-8?B?by9Vb2lnTDRuaXRqdjBlRndIZTAyNEZxMUxsemVramphNlYxSjNFSnlzaVZE?=
 =?utf-8?B?TjdmbHhvN245MkVTdmpiNjZFZWd2RXpDMnRWK0RVbGF1cDFTQXh4LzZ6ZnBM?=
 =?utf-8?B?V0UvY09RNGRiUnZTZTd6d2lWZ1UydmFETkcyMFhLWThJUWVDY0Z2eGcxcm11?=
 =?utf-8?B?ZjZpaERyK1g4OWo3bU02dWpiUzNwaVJLWEtXcUMzWVc0TUFKanJtQlBZWjE4?=
 =?utf-8?B?MnFQQldteHhuckljNU5jVk1vMjhjMWJhOW5oRWdVSHFHVm5WZ2dscW5sbmNt?=
 =?utf-8?B?RW1tcFI3RDkxTmJEOXNZeVF1eERoQ3FCRit5aE1NTGhodGhIOW8rS1hWNldz?=
 =?utf-8?Q?7URx3eGevW1HyLlpgpwb0RWtE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D43CD2F09604064A91A9E40FFFDFB84A@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR18MB2162.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9f078f-151c-4c82-c9d5-08ddf47e0663
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 17:33:46.6711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNG9LzcboflX86ohYX07KFEAw4IS/MrThZ7Egl5Ifx2/uUd5BIfFiK8nZv8ZK1sE1e7SI4c5ZINuficbJYRNiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF260D102EA
X-OriginatorOrg: amazon.com

VGhhbmtzIGZvciBoaWdobGlnaHRpbmcgdGhlIGlzc3VlIGFuZCBzaGFyaW5nIHRoZSBwYXRjaC4g
VGhlIGZlYXR1cmUgd2FzIGFkZGVkIGEgbG9uZyB0aW1lIGFnbyB3aXRoIHRoZSB0aG91Z2h0IG9m
IHBvdGVudGlhbCBzdXBwb3J0IG9mIEVOQSBsaW5rIGF1dG8gbmVnb3RpYXRpb24sIGJ1dCB0aGUg
RU5BIGRldmljZSBkb2Vzbid0IHJlcG9ydCBvciBhbGxvdyB1c2VycyB0byBjb25maWd1cmUgbGlu
ayBhdXRvIG5lZ290aWF0aW9uLg0KSSBiZWxpZXZlIHRoZSBiZXN0IGFwcHJvYWNoIGlzIHRvIHJl
bW92ZSB0aGUgZW50aXJlIGF1dG8gbmVnb3RpYXRpb24gc2VjdGlvbiBmcm9tIHRoZSBldGh0b29s
IGNhbGxiYmFja3MuDQoNCu+7v09uIDkvMTIvMjUsIDE6NDMgUE0sICJBbmRyZXcgTHVubiIgPGFu
ZHJld0BsdW5uLmNoIDxtYWlsdG86YW5kcmV3QGx1bm4uY2g+PiB3cm90ZToNCg0KDQpPbiBGcmks
IFNlcCAxMiwgMjAyNSBhdCAwMToyMTo1OVBNIC0wNzAwLCBBbG9rIFRpd2FyaSB3cm90ZToNCj4g
VGhlIEVOQSBldGh0b29sIGltcGxlbWVudGF0aW9uIGlzIHNldHRpbmcgQXV0b25lZyB0d2ljZSBp
biB0aGUNCj4gJ3N1cHBvcnRlZCcgYml0ZmllbGQsIGxlYXZpbmcgJ2FkdmVydGlzaW5nJyB1bnNl
dC4NCj4gDQo+IEVOQSBkZXZpY2VzIGFsd2F5cyBzdXBwb3J0IEF1dG9uZWcsIHNvICdzdXBwb3J0
ZWQnIHNob3VsZCBhbHdheXMgaGF2ZQ0KPiB0aGUgYml0IHNldCB1bmNvbmRpdGlvbmFsbHkuICdh
ZHZlcnRpc2luZycgc2hvdWxkIG9ubHkgYmUgc2V0IHdoZW4NCj4gRU5BX0FETUlOX0dFVF9GRUFU
VVJFX0xJTktfREVTQ19BVVRPTkVHX01BU0sgaXMgcHJlc2VudCwgc2luY2UgdGhhdA0KPiByZWZs
ZWN0cyBydW50aW1lIGVuYWJsZW1lbnQuDQo+IA0KPiBGaXggYnkgdW5jb25kaXRpb25hbGx5IHNl
dHRpbmcgQXV0b25lZyBpbiAnc3VwcG9ydGVkJyBhbmQgbW92aW5nIHRoZQ0KPiBjb25kaXRpb25h
bCBmbGFnIGNoZWNrIHRvICdhZHZlcnRpc2luZycNCj4gDQo+IEZpeGVzOiAxNzM4Y2QzZWQzNDIg
KCJuZXQ6IGVuYTogQWRkIGEgZHJpdmVyIGZvciBBbWF6b24gRWxhc3RpYyBOZXR3b3JrIEFkYXB0
ZXJzIChFTkEpIikNCj4gU2lnbmVkLW9mZi1ieTogQWxvayBUaXdhcmkgPGFsb2suYS50aXdhcmlA
b3JhY2xlLmNvbSA8bWFpbHRvOmFsb2suYS50aXdhcmlAb3JhY2xlLmNvbT4+DQoNCg0KUmV2aWV3
ZWQtYnk6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaCA8bWFpbHRvOmFuZHJld0BsdW5uLmNo
Pj4NCg0KDQpBbmRyZXcNCg0KDQoNCg==

