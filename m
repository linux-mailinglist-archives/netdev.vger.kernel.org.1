Return-Path: <netdev+bounces-246402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1131CEB56B
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 07:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8591B300A34B
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 06:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D4630FF3A;
	Wed, 31 Dec 2025 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PiJ/MLGf"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230AB30FC3D
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=34.218.115.239
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767162417; cv=fail; b=EqxB49CNv+5mU4MsdxfN9EUaZBHyzMvNF8tBs9vk2SafG/9aEDQ1F1Se17H93J56xBpfxXJjXYMaDVd6yF+KqT7AvNL94+8itf/c6ifEg5Wfe0fwo53d/zVWovNPypZV2SWIfEYCTBmrzS046NdKFp+coqTc+4aGjoLhgjnwQWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767162417; c=relaxed/simple;
	bh=W27YFT6MJ5e3kBm2BxzQ+U/GjHonLehz7TnlVpuypkg=;
	h=Subject:From:To:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RsA0vYUdPBfH7t9AFfM0BQhicv1CDLJ2g9Xj6RP9AJfW/fbqWNrS90X4qfLoxpfl98TWd3oRK7/UvxUdxxP4CYMqcluQYOiiGgBhgdmQCQrpA5jPb3kFLVbt7o+rZOncqXhbqQXAhM65BwXqeIiVVm3kA6pjPr5hAFjD+Yk/f4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PiJ/MLGf; arc=fail smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1767162416; x=1798698416;
  h=from:to:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=W27YFT6MJ5e3kBm2BxzQ+U/GjHonLehz7TnlVpuypkg=;
  b=PiJ/MLGfOXuzlp/f7PpEeiVPWTsgSi4DNK1SwYfQLXXBM6JrZf7mg/mj
   VdwLwKlkSpINW+W3u2ZQDx0PHLJ8mCnduVZirBE94aqI399WnBNhE5hYe
   XQ3UOx3v8BrGdBZ0Fdl09fq7Jqo3kaqXR4J4XDh+YuFoWNiFBkPMxI1g0
   uYcKg0HjKrcupx2B6wvJmNB9BzlP94c7192v/jqab2OjyXdIiBV/s9eCU
   hkXNhNQDs2gJifrIMvOJeFnyJzwwvYruFjzTge5ARxqrQ6mkB3or4MQrk
   IMY8AAEN4RuK04qKeTlpL4ZJuI0Yv5kgixg6cfJ3jRKD3zKJ87x8JeLdm
   w==;
X-CSE-ConnectionGUID: nrNbmKSeSeKPhuvJGF5EYg==
X-CSE-MsgGUID: agZkn1q6Sxevo0Hw7vrR1g==
X-IronPort-AV: E=Sophos;i="6.21,191,1763424000"; 
   d="scan'208";a="9806592"
Subject: Re: [PATCH v2] net/ena: fix missing lock when update devlink params
Thread-Topic: [PATCH v2] net/ena: fix missing lock when update devlink params
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 06:26:53 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:17894]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.60:2525] with esmtp (Farcaster)
 id 68d624e5-313b-49c3-badf-c0ae93af0e4d; Wed, 31 Dec 2025 06:26:53 +0000 (UTC)
X-Farcaster-Flow-ID: 68d624e5-313b-49c3-badf-c0ae93af0e4d
Received: from EX19EXOUWC001.ant.amazon.com (10.250.64.135) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 31 Dec 2025 06:26:53 +0000
Received: from PH0PR07CU006.outbound.protection.outlook.com (10.250.64.206) by
 EX19EXOUWC001.ant.amazon.com (10.250.64.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35
 via Frontend Transport; Wed, 31 Dec 2025 06:26:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8pSpi1Af4cORK4B10udSJNZoxuoRvw/oiO1/+ri4b3WrxpGVvq2xbrrFTMIt5Ln4Er7Jtn0l4u+BLwJTLssyfwJiD3vV9yEEMtOc3DjOJ789CD4dm+sg6FNYh4x3U5uSvf6oKn2okxY9ZYbHZjEL/gm1E5K7jHLuBX6TJlfh0HCWO+3MtAGmYG0z5Cl8tztzEHxgXHznSgkDoVsmqdwtDeHLsSuYghy+PT8rSUbxoRWsANFSnVigDknPgSPASePDws9DMWM1ih6b9BKenzs9SC/erWmujgPefqcchmPkC6lpl1lLOJCH8T7sGufR1zg4Nchpg8oSW5m6gcxh3OeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W27YFT6MJ5e3kBm2BxzQ+U/GjHonLehz7TnlVpuypkg=;
 b=mDTMvPKILZbdkntubLjL4dbpQEfZSAhIEI/SxEck1N0EvWjGQ9wix/gWyU84MeZh4n8pxA5Txlmlj0tQCwI/neRMYPxsC5JwB6SHcUDt5rjU8Ff7wAZ2eHMR72VTiP4GLWp60Xz5yuqdrW092wnsSBiRIbxyIx07aJgx71Z1DWb/fRkBp1XrNig9+Cb162V3V6UhoiONwdCLYtG0wqiMa2NgFW2WQSIgyYDrUlg5IXPDcqNnZVyqIAPWyXdrIIZPhgOSBniunU5HqAMXyaDZYonu9uQaGjmAYkmWHGYiqLktgnKDY41jgxDFxgAUZWLk0W5SEmJvU19eHEqR4XrADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from MW3PR18MB3692.namprd18.prod.outlook.com (2603:10b6:303:5c::7)
 by SA0PR18MB3502.namprd18.prod.outlook.com (2603:10b6:806:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 06:26:50 +0000
Received: from MW3PR18MB3692.namprd18.prod.outlook.com
 ([fe80::8b33:29d:1fd3:8c6]) by MW3PR18MB3692.namprd18.prod.outlook.com
 ([fe80::8b33:29d:1fd3:8c6%6]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 06:26:49 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Xiao Liang <xiliang@redhat.com>, "Allen, Neil" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Thread-Index: AQHcefPWTdhOrToJtkyol2xtMfTivbU7aoKA
Date: Wed, 31 Dec 2025 06:26:49 +0000
Message-ID: <7AA68864-8556-41E1-8690-A1F08978ECF9@amazon.com>
References: <20251229145708.16603-1-xiliang@redhat.com>
 <20251231012030.6184-1-xiliang@redhat.com>
In-Reply-To: <20251231012030.6184-1-xiliang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2025-12-31T06:26:21Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=80604754-3cb5-4a8a-b401-a66566876c4c;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR18MB3692:EE_|SA0PR18MB3502:EE_
x-ms-office365-filtering-correlation-id: 0ce90df3-3a29-49f8-b076-08de483594c5
x-ld-processed: 5280104a-472d-4538-9ccf-1e1d0efe8b1b,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?THVXTU8yZ0ExMHpxaWJ5ckhOKzEwOWVFb0hiaVhGVFZBdDU5MG42ODNTeitT?=
 =?utf-8?B?dEk4SGJiR1FoM1JhV1RRWFBzU3ZaMnF5dUM1bHRRSFVjTXoybFZySzZEMTkr?=
 =?utf-8?B?U1hLNW02S2JiQmJZaWNxc2x5M1hYa1graE9iZzRocWVCUFpHRjRhU1dWamxE?=
 =?utf-8?B?ZU52WTN0R0NmbWx4UVRFK1Rwc1JxV20raklTYTZPcnN6YVFNSStXSGhIYUVi?=
 =?utf-8?B?dWtkMnE3TFhWR1JCbUZ3N1FnRW9pem9GU3F0ODFUQ1pxaHZva2FKLy9ZV1Ft?=
 =?utf-8?B?a2NLVVpYb1FPeEhLSVY4WmZIV1kwcXlyM1l0bVNzd2hXaWVuWXRHcWhHaFNS?=
 =?utf-8?B?U3dMTVgrNndPUGxhN2tHVmdzZjA3d2FnZm91TS9aZS9HRU5GeFZLa0RHcmxN?=
 =?utf-8?B?NkNlUWNiTFE5ZDZRb0hDK1ZQeVRHcmZ4b3JYVDVhNnQyK3gzWlZDVVovQ3Y2?=
 =?utf-8?B?LzgwcERPWjRLeElPOUp1U3lBNEFQZGJDZktJaEt1QnR1blZVd3A0U0RoVVN1?=
 =?utf-8?B?eHZoZzFrQ1NyNFlrM3JnUWU1amg2clp1c2xJcCtRNUVIS21xcDBEQ2MwWWpz?=
 =?utf-8?B?TG9Ka2thcTBxL1V4N01IT3hDQXBITUM5VmZPOXhOSGhMZjJxdkhVSGNWUk9Z?=
 =?utf-8?B?WktLOUQ3eUxwc2JlQUI5UWE5NFN0RjBUR0MvMEtZNWlrY2pQSUt2R3pNMlZx?=
 =?utf-8?B?eXM2YU9sVlZmeWh4UjdSeWhmQklTN1ROT3k5V3lwdDNPZmswMWk1NHhhSzg1?=
 =?utf-8?B?ZHFTcVh0OVRoRzlyejJiZEpPMkRZRjNzeElVWmhiY2FBWlp4RTVEVFVWdmpI?=
 =?utf-8?B?T2ZCenhodXdKZlhMRG5rV0JQK3dZeHlIUHluTDhrNEtSYkZ3M3h2SkZ0aTVr?=
 =?utf-8?B?STdJaVowWDRzUnBlamF2ZUZrbmo1SEREWmhRLzZaUlljT3NtQWlteXJaS29G?=
 =?utf-8?B?a0F6eFpwS1ZFOVJFR1E1MGljQUtBU0FUelRKdU55M1VWRXBNd1U1NXBoOFpl?=
 =?utf-8?B?WjJLaUJsSnlDbEdVNnZHOGlUY1hIejBHR1JXbUxqSklOTG12OUJvb1JyNWQy?=
 =?utf-8?B?RTVpZXNwWktwV00zNW5nZGlkLytIMCtRRmd6MmNFMmtRcndLek52QXpaL3F3?=
 =?utf-8?B?bTVPUUFtRUtLUEZaL3dJQXVYZXY0VVVYYjN5VjIvTnpONG85UlhBNFVwckkv?=
 =?utf-8?B?OWsxejAxQ3FEZ1NKWTJGcmhaWTV5bVIxWFQvOEVJMlJCT3RNRzZYeG1SUlVS?=
 =?utf-8?B?blBHRE9mTVUzbGdEY1VrYkVTTDZ5Nml1VkovYmJrZFJJclkwbnAzZ3VmNWNo?=
 =?utf-8?B?Mi9aQzROaXVkd21zK05RZFNja21LSWZkWEgveXdBd1F1dW1CTFVmU3paWlR4?=
 =?utf-8?B?NnV0WXZFczJNTU5uV3RwUC80VUpoeWFqTVBYUkxHOS9JNDBJWGdxYUM4N3VB?=
 =?utf-8?B?Vno0LzNjR2Y3ZURTc3NIZW5CZ3ZpNmU0RlR3UHZWM1NpSHhrbFB0K01kRi9p?=
 =?utf-8?B?RlMwNjJheFAwL09QY3pOTFJibklCUHoycUlKVytrMmlTZGVDWW00bFBSREpS?=
 =?utf-8?B?QmlySkhhWFRzSVhFekkzc0dnOWI1aTlTU0JCNVRBOUFDZk9wZ052TUF3NGto?=
 =?utf-8?B?NXI5S3ZFb3VTSW5nSW05V3J6bjZFdnZkV3ZwN3VlUEZrR0F5TGtCUS8vVnUv?=
 =?utf-8?B?Z25jOHM3azkzbU11V1dUTWZaU0dMeEs0R29yZnhUMUNyd1p5aVFWZ3pObUM1?=
 =?utf-8?B?VlovQTBlRkFVUk9mRUxTVktoMW9FRmpkYVAvK3YyQ2d4cllyZmk3RSs5RFVY?=
 =?utf-8?B?ZVdBUEs0aHpaUy9ZVExSMVhWUTI0a25lUnVVNEEzd2xWcDJMNVJpRjhlb0hP?=
 =?utf-8?B?djMvUzlhZ0JOM2ZES1FLRGd1N0pqTm1SZzViR0FlZERLdXdDM3V6RlBGWnRD?=
 =?utf-8?B?UWRrbURDKytlcnR1L2FST0taYUt1S1pDL0IzY0QvTk90Q3FxbFNoYVRDY1NL?=
 =?utf-8?B?WDNyeHlpdkF5TGM2TnhWMU1HSGJKRU5YWjdzeEl0T3N1OGZuZ0hKME5QUXBs?=
 =?utf-8?Q?1q9U19?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR18MB3692.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0dZM1BEOFNXK2ZlMXhwQ3lmTnA5aG5PclhjLzdjd3BNaituekdpaCtrZVVm?=
 =?utf-8?B?d3FKL3pxY2lwTVpOTlM0SUU2UFJ5dHFJYVVvVTB6Rk82TEt5WC9ZOXc2cTlJ?=
 =?utf-8?B?b3huQVRPbjlZcVhiVmlSSWR5cmc4aFdyeGhIRW9tN0NCdG9iVllyTjhWLzdT?=
 =?utf-8?B?bEFIWW1kSXFhd1NSNWgvVEZTRWZyTytxSEt4dGc0bHU0Vm96WjZISUxoVVds?=
 =?utf-8?B?bGNQNTZBUlg1TEw4S1pZYnNRSkpLQk1vYUtWMFh5RGVvQVNJcThCOWhtVkpm?=
 =?utf-8?B?MlgvcmkzKzNHVy8xakpNZHNqRmZBM3JLb0RUaDRUYnFvdmNqa2p3WVpMajkz?=
 =?utf-8?B?T1ZhZUcxMEkzRjk4VHNOSzdGTXdSMGcxVVl2b3psL1o5SldidFhtdXdHMDZM?=
 =?utf-8?B?eVZTR3htSklJQjZsS2ZwU3NUc1lQY2ExWEZvbTlqU0tPTUJwdmdiU0Mxa2Fy?=
 =?utf-8?B?M0hQSE1KZitXazNMN25QNUR1QkRtR2dhM0VnVGFZRTVCSDhtV0E2VVdQNzFu?=
 =?utf-8?B?YTZIOWlUa0syZHcrczNQRG8wYVN1ck9yano4ZzM2YlByZ2NEVGd0QUNYUXZ5?=
 =?utf-8?B?ZEdHamxVUnZQUFd4eG11cFliOXprWUVMNFJKZUlIaFB4OWtJaU13dEUrQ0Q5?=
 =?utf-8?B?Vk9mQ0Y5b1JuRHRTMEdZM1hkZFByRHZRSEZ4RnZnZ2k3NzByclJZd05EdW5u?=
 =?utf-8?B?b3NJb0ptSXUvdlAxeXlNM2Y1NWV2UW1pTXNnOVJCellod1ZTd2hLZ1RWZEVT?=
 =?utf-8?B?aWJrcWdiV1pLbytvVFlPT2dpRlpmOWU3WlFZQUY2WVJCb0pldDZsRWoxbWlJ?=
 =?utf-8?B?K0NYTUhTbWtoK2p3M3RPNjdVd2tvQUIyRTh1T3hJMkZJcTUwYys0bFYzQmpY?=
 =?utf-8?B?L2YxQ1hYRHFXOGpiU25DdHc5SUQ1NWdBaXJpcXRWNzcvSjR1MU1ZNzZNWUpK?=
 =?utf-8?B?RmJNTDFEQ1JsWmhsVktVc2dtVzlwNDdzNThUdmZrRzlyelZhcU5LZ2xQTTlC?=
 =?utf-8?B?Z04zOEJodFl0aUt3cFNpQytVWER2VnZUOGVzV1ZFUzI4NFUwVmdPelZPbXRG?=
 =?utf-8?B?Q3JYR2VlVGZWN3FCUW9pWEREVFgzbUcycEtmOHRvT2RreHcrMnV5UFFoRCtp?=
 =?utf-8?B?SFh3VFFtWDdNZnRXM3ZRejhSS2gyV3QwekJUek5XTVlKZDZSdnYvM1drNVF1?=
 =?utf-8?B?S0Y4WGkreXlHV01RZ3l6Vk1iSW9hc0VrK0xhQ2VRUTQvblNBMCt5VXAzTnpa?=
 =?utf-8?B?V1FyM3JISjVPL2U2N2pGVzRpMkhtUmdtRlRzdzA4WEViTWllQWtCTW11QjJO?=
 =?utf-8?B?TzdvVGNKcXBRTTdMMUNkR3ViUkN2eEEvR1cvUlpLaHk0cVdzVGFBcVB6M0E5?=
 =?utf-8?B?aFZBOEdsOFJFRXhOS0pkRWd1OFIzMEpvdkJJeW16Szl3bklqUXN5Z1ZTRG1I?=
 =?utf-8?B?ZXdmRklQOXdqNEVzNSs0bEdOdy96QVNMMlM3MU8xZ1ZjdGNxLzFtN2Z6ODZI?=
 =?utf-8?B?ZERJZVpmSW1xdjRySlVyUWhyQlphclpEWW42b0hzeXRjRWZhOGFNQmRsbTN2?=
 =?utf-8?B?RkRLUXczd01OMkVKcGt1K3AvSzR6ekRVYjlqSWlvQVEyS0ErcnNma093ZDVz?=
 =?utf-8?B?NDV6bGlwUVl3TktzVTMrUXlTejJkeVhTWVJzS3hPVVFGbG5rblZWem9yL1NY?=
 =?utf-8?B?Z2l6OEJGcFpXeXdSQVNqZDVoaFV5UmgvMzBEK1poaDdCZ1JpbWVkTkdOLzFU?=
 =?utf-8?B?UVdBTTVweTkzYXhkOGQrZ3NaT0F5cmQ1L1k3U1ZOWEo5VzV5ZXVqK1VzZ054?=
 =?utf-8?B?ZjlwNGFrKzkyc0lKY0h4dVNSKy8wMVlHWEt5UG9OZGI3V3Fjd1hpWlNibGJi?=
 =?utf-8?B?YnhoNGEwaEFVSDNNdmVDSytJK3dlYm1SclJkTFpvRngrSkgzUmxkRkhzNkRh?=
 =?utf-8?B?MTJ4cVYxd1VTZmtad2tWUTRueXJReUpCVmxsZVIrQyt0OEh0SnVTNDMzb1NV?=
 =?utf-8?B?ODMxSzE2YnRpVk8wWlo1bjArUWEvVnJHWFNiQlM3S3dwV3Zqdjg5OEpLTFpv?=
 =?utf-8?B?MjczYVorN042bi9LSWZHYjEyMHBnZXlFclJtQXU2QktXRkxPWHhKdjlnV3g5?=
 =?utf-8?B?T1hKRWFhSVVXczFEZWcyb1FRUW1FWFhLUU5lRit0Mkk5QlQ2bFpoQjMydHRM?=
 =?utf-8?B?aDJaSU80VGZmQmxBQzBxbXlqSnhwMzFBbE85MW1GMkc2OFN6L2ovZGFOa0xH?=
 =?utf-8?B?Um1ibEtWeHBoUXNVUXhydDFFVFZHY2ppYXNZNU1QSHRhbUZUT01LSXovWEpD?=
 =?utf-8?B?UDNqVVV3QWt3QUZodnliNS94RC93OWRjZ0R6cjhERUJ4dEx5RHdiUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBFBA0C584BD2741B41A8F7FEEE5B1A4@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR18MB3692.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce90df3-3a29-49f8-b076-08de483594c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2025 06:26:49.9478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYTFl9wLhVy/zCQeP9yUNXmNtFl2kevja9jVuUNZcjXzEE2iTVzX7inFimeoFuz39N/JgQbmFL5oeNR6ycurNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3502
X-OriginatorOrg: amazon.com

PiBGcm9tOiBGcmFuayBMaWFuZyA8eGlsaWFuZ0ByZWRoYXQuY29tPg0KPiANCj4gRml4IGFzc2Vy
dCBsb2NrIHdhcm5pbmcgd2hpbGUgY2FsbGluZyBkZXZsX3BhcmFtX2RyaXZlcmluaXRfdmFsdWVf
c2V0KCkNCj4gaW4gZW5hLg0KPiANCj4gV0FSTklORzogbmV0L2RldmxpbmsvY29yZS5jOjI2MSBh
dCBkZXZsX2Fzc2VydF9sb2NrZWQrMHg2Mi8weDkwLCBDUFUjMDoga3dvcmtlci8wOjAvOQ0KPiBD
UFU6IDAgVUlEOiAwIFBJRDogOSBDb21tOiBrd29ya2VyLzA6MCBOb3QgdGFpbnRlZCA2LjE5LjAt
cmMyKyAjMSBQUkVFTVBUKGxhenkpDQo+IEhhcmR3YXJlIG5hbWU6IEFtYXpvbiBFQzIgbThpLWZs
ZXguNHhsYXJnZS8sIEJJT1MgMS4wIDEwLzE2LzIwMTcNCj4gV29ya3F1ZXVlOiBldmVudHMgd29y
a19mb3JfY3B1X2ZuDQo+IFJJUDogMDAxMDpkZXZsX2Fzc2VydF9sb2NrZWQrMHg2Mi8weDkwDQo+
IA0KPiBDYWxsIFRyYWNlOg0KPiA8VEFTSz4NCj4gZGV2bF9wYXJhbV9kcml2ZXJpbml0X3ZhbHVl
X3NldCsweDE1LzB4MWMwDQo+IGVuYV9kZXZsaW5rX2FsbG9jKzB4MThjLzB4MjIwIFtlbmFdDQo+
ID8gX19wZnhfZW5hX2RldmxpbmtfYWxsb2MrMHgxMC8weDEwIFtlbmFdDQo+ID8gdHJhY2VfaGFy
ZGlycXNfb24rMHgxOC8weDE0MA0KPiA/IGxvY2tkZXBfaGFyZGlycXNfb24rMHg4Yy8weDEzMA0K
PiA/IF9fcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUrMHg1ZC8weDgwDQo+ID8gX19yYXdfc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSsweDQ2LzB4ODANCj4gPyBkZXZtX2lvcmVtYXBfd2MrMHg5YS8w
eGQwDQo+IGVuYV9wcm9iZSsweDRkMi8weDFiMjAgW2VuYV0NCj4gPyBfX2xvY2tfYWNxdWlyZSsw
eDU2YS8weGJkMA0KPiA/IF9fcGZ4X2VuYV9wcm9iZSsweDEwLzB4MTAgW2VuYV0NCj4gPyBsb2Nh
bF9jbG9jaysweDE1LzB4MzANCj4gPyBfX2xvY2tfcmVsZWFzZS5pc3JhLjArMHgxYzkvMHgzNDAN
Cj4gPyBtYXJrX2hlbGRfbG9ja3MrMHg0MC8weDcwDQo+ID8gbG9ja2RlcF9oYXJkaXJxc19vbl9w
cmVwYXJlLnBhcnQuMCsweDkyLzB4MTcwDQo+ID8gdHJhY2VfaGFyZGlycXNfb24rMHgxOC8weDE0
MA0KPiA/IGxvY2tkZXBfaGFyZGlycXNfb24rMHg4Yy8weDEzMA0KPiA/IF9fcmF3X3NwaW5fdW5s
b2NrX2lycXJlc3RvcmUrMHg1ZC8weDgwDQo+ID8gX19yYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSsweDQ2LzB4ODANCj4gPyBfX3BmeF9lbmFfcHJvYmUrMHgxMC8weDEwIFtlbmFdDQo+IC4uLi4u
Lg0KPiA8L1RBU0s+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBMaWFuZyA8eGlsaWFuZ0By
ZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1ieTogRGF2aWQgQXJpbnpvbiA8ZGFyaW56b25AYW1hem9u
LmNvbT4NCj4gLS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2FtYXpvbi9lbmEvZW5hX2Rldmxp
bmsuYyB8IDQgKysrKw0KPiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfZGV2bGluay5j
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfZGV2bGluay5jDQo+IGluZGV4
IGFjODFjMjQwMTZkZC4uNDc3MjE4NWU2NjlkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9hbWF6b24vZW5hL2VuYV9kZXZsaW5rLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvYW1hem9uL2VuYS9lbmFfZGV2bGluay5jDQo+IEBAIC01MywxMCArNTMsMTIgQEAgdm9p
ZCBlbmFfZGV2bGlua19kaXNhYmxlX3BoY19wYXJhbShzdHJ1Y3QgZGV2bGluayAqZGV2bGluaykN
Cj4gew0KPiAgICAgICAgIHVuaW9uIGRldmxpbmtfcGFyYW1fdmFsdWUgdmFsdWU7DQo+IA0KPiAr
ICAgICAgIGRldmxfbG9jayhkZXZsaW5rKTsNCj4gICAgICAgICB2YWx1ZS52Ym9vbCA9IGZhbHNl
Ow0KPiAgICAgICAgIGRldmxfcGFyYW1fZHJpdmVyaW5pdF92YWx1ZV9zZXQoZGV2bGluaywNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERFVkxJTktfUEFSQU1fR0VO
RVJJQ19JRF9FTkFCTEVfUEhDLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdmFsdWUpOw0KPiArICAgICAgIGRldmxfdW5sb2NrKGRldmxpbmspOw0KPiB9DQo+IA0K
PiBzdGF0aWMgdm9pZCBlbmFfZGV2bGlua19wb3J0X3JlZ2lzdGVyKHN0cnVjdCBkZXZsaW5rICpk
ZXZsaW5rKQ0KPiBAQCAtMTQ1LDEwICsxNDcsMTIgQEAgc3RhdGljIGludCBlbmFfZGV2bGlua19j
b25maWd1cmVfcGFyYW1zKHN0cnVjdCBkZXZsaW5rICpkZXZsaW5rKQ0KPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIHJjOw0KPiAgICAgICAgIH0NCj4gDQo+ICsgICAgICAgZGV2bF9sb2NrKGRldmxp
bmspOw0KPiAgICAgICAgIHZhbHVlLnZib29sID0gZW5hX3BoY19pc19lbmFibGVkKGFkYXB0ZXIp
Ow0KPiAgICAgICAgIGRldmxfcGFyYW1fZHJpdmVyaW5pdF92YWx1ZV9zZXQoZGV2bGluaywNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERFVkxJTktfUEFSQU1fR0VO
RVJJQ19JRF9FTkFCTEVfUEhDLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdmFsdWUpOw0KPiArICAgICAgIGRldmxfdW5sb2NrKGRldmxpbmspOw0KPiANCj4gICAg
ICAgICByZXR1cm4gMDsNCj4gfQ0KPiAtLQ0KPiAyLjUyLjANCg0KTEdUTS4gVGhhbmtzIGZvciBt
YWtpbmcgdGhlIGNoYW5nZS4NCg0KUmV2aWV3ZWQtYnk6IERhdmlkIEFyaW56b24gPGRhcmluem9u
QGFtYXpvbi5jb20+DQoNCg==

