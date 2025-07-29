Return-Path: <netdev+bounces-210703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D9EB14631
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 04:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A081AA17F3
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 02:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6711A5BAF;
	Tue, 29 Jul 2025 02:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="S/hthUyF";
	dkim=pass (1024-bit key) header.d=amazon.onmicrosoft.com header.i=@amazon.onmicrosoft.com header.b="s8CmgvWt"
X-Original-To: netdev@vger.kernel.org
Received: from iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com [3.216.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515B14A23
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=3.216.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756173; cv=fail; b=ZuTrTvV2x4Y8DhwmAu0Ddjs2DLE0jWLUzEAujDjfVgZdJcbgmp7F4TZgT3aUd1JVx9EmmW3Hg+GnJYYtpXT/kLQE3442wnwD/Oyf0iKBqLC8HtFzEW+vquPMifnbIF15YAeLmpNfabovokh1lNkjJ8Dsb4HgsvBxX0dd7siP1z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756173; c=relaxed/simple;
	bh=unJGtImmtdpMYkZXD0jmOjUNQICq9RCFrGEmUxNK9RY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=olN/3zAGCx6eq8WZaJ8d+S8BQgEc2cN3wwUAKaFX9B5QI+m38tv4G9qyV8PZ2dXO6x081MfUasZqUC+gAEhblFOz1rS9TCKBjqw8ZSKuTBuLC+vlkJfi3YCoTupc2hooG+ElyYC7EehXzZBj/xEWjcsDl41p0B4H3iX9YlqUBUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=S/hthUyF; dkim=pass (1024-bit key) header.d=amazon.onmicrosoft.com header.i=@amazon.onmicrosoft.com header.b=s8CmgvWt; arc=fail smtp.client-ip=3.216.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1753756171; x=1785292171;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=unJGtImmtdpMYkZXD0jmOjUNQICq9RCFrGEmUxNK9RY=;
  b=S/hthUyFboWofmeJtZHIZazz4l08NY6eMZyKOW6Ls1r58MVAY8M4+PMO
   sdWmgpcS9iBe0CP2Js1NQRWihTLL8spfMqDzchF06aQtzy4Dc47FMnV2v
   Ci5XOUmLBcM52nLIjDcrBZhKiXWPR8npA0gaNkGGz+2ex615kEKSn4lmj
   tBmwz63eWL226BNPZZwmZaA9kmUjspNLsYxUvSgJxLDwwrVC6uqpm+fNJ
   nOmuiUTRpNAHTHOAV2RGeF2MhK7VPS8cIjiNXUz314mmO+0u49+4BfEky
   ZKTRc6DnuU3TGPfatVPQ+mMzzYyxgC5n554AD/tad2COt7byaRtLyS1OE
   A==;
X-CSE-ConnectionGUID: tUYnDY+KSbalU4XtpQrywg==
X-CSE-MsgGUID: znNn/YaeQa2wWACsMCOxlA==
X-IronPort-AV: E=Sophos;i="6.14,267,1736812800"; 
   d="scan'208";a="449519"
Received: from ip-10-4-7-229.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.7.229])
  by internal-iad-out-006.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 02:29:28 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.0.204:24988]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.18.247:2525] with esmtp (Farcaster)
 id 39843c21-085f-4187-8fa3-db378fdb3955; Tue, 29 Jul 2025 02:29:28 +0000 (UTC)
X-Farcaster-Flow-ID: 39843c21-085f-4187-8fa3-db378fdb3955
Received: from EX19EXOUEB001.ant.amazon.com (10.252.135.46) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 29 Jul 2025 02:29:27 +0000
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.252.135.199)
 by EX19EXOUEB001.ant.amazon.com (10.252.135.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14
 via Frontend Transport; Tue, 29 Jul 2025 02:29:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMAfv923Z/FLP998dvuWoQqR/zJ80hUIQ6JwKJuI913W90n5/WmnIEvAaE6tIUM+HBuqYOuxwIelDhP8SVH+3tYXl76FijzPQsrf+zlaGOxZ8FMHw5fmQWnGBitGCT+PHDg3qNW7M6V/ByY0KhSL6NNcwg5ZTAPpGMEdja98adL4CpwZe3d/Gn8YwetXvWrmXqQCCVBDw0KxSGRmpQWY6FTYgSdfWITjcG/TNNkI70Yl/KC6xgIRJWzTVlf2i79crUa7xkC2FkjFiAUgOMeXXB0Dom6L6Ye4yjLnabfMawerBwgDAyT7+WmgDSiS3NAbGmpuj5V/86IyPB2qdR5big==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unJGtImmtdpMYkZXD0jmOjUNQICq9RCFrGEmUxNK9RY=;
 b=mjRkhAAq+7EB6aYOjZMeWRqVBaNu1HfQxOZ/6k9hx6gmwMFSN7PN79c4CShFu/oTK2vl3+HUohGuirV9vEfInM7fUSSgOKbArvdTcpDrrND56VWfzsjppHvdsB/ErFk0h/v+6qtsn4eqWzbwGEz0pf1V7ndaAXRWaGdxrKeJRqZaOToeUeseNXV39A/gYa6bL45TF/Os9UufRVrwXaUJgbbAjYCHV8Gp80w9i4NYMUf2gELodGNtVyeLTmpQRKvKrETIW+fcXrsFTcDy92Fh2+Nk0zShMGIZKHC26xmK9R2emD2CKuxPKKsa5FyKKngBdAU98VTQA0XkQrWNIWhHpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.onmicrosoft.com; s=selector2-amazon-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unJGtImmtdpMYkZXD0jmOjUNQICq9RCFrGEmUxNK9RY=;
 b=s8CmgvWtPCjMEAfj3lkPhRqHhKwRRLuChsPSqQUaiiZU/DZ65h35V0FP74Ps/9dOcMiTHLIFNHobkJNu66Xew7ZPpZ2OgLjKPhBHMWZP6SNAGiQj2h76Y1Ryvfr2PZLem7bUTSMZrXbeXSzu3zGfmviuqdFnMVYt17YHJCBn5LA=
Received: from BN8PR18MB2562.namprd18.prod.outlook.com (2603:10b6:408:68::18)
 by CH3PR18MB5487.namprd18.prod.outlook.com (2603:10b6:610:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 02:29:26 +0000
Received: from BN8PR18MB2562.namprd18.prod.outlook.com
 ([fe80::16e4:6abb:55e1:5810]) by BN8PR18MB2562.namprd18.prod.outlook.com
 ([fe80::16e4:6abb:55e1:5810%3]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 02:29:26 +0000
From: "Ridoux, Julien" <ridouxj@amazon.com>
To: David Woodhouse <dwmw2@infradead.org>, "Arinzon, David"
	<darinzon@amazon.com>, David Miller <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David"
	<dwmw@amazon.co.uk>, Andrew Lunn <andrew@lunn.ch>, Miroslav Lichvar
	<mlichvar@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Levinson, Josh" <joshlev@amazon.com>
Subject: Re: [RFC PATCH net-next] ptp: Introduce
 PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl
Thread-Topic: [RFC PATCH net-next] ptp: Introduce
 PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl
Thread-Index: AQHcADCaVxLQTelquk2N9kb9BxLSJg==
Date: Tue, 29 Jul 2025 02:29:26 +0000
Message-ID: <613C833A-96C6-4B9C-AF45-AA81689CB644@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2025-07-29T02:19:35Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=8f870a3b-66c1-4cb2-b150-a3e6cc01d03a;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR18MB2562:EE_|CH3PR18MB5487:EE_
x-ms-office365-filtering-correlation-id: 68927738-a5fc-4f6c-a018-08ddce47bcde
x-ld-processed: 5280104a-472d-4538-9ccf-1e1d0efe8b1b,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?MEVxN3dmcVBLTkI4Qk4wSGRIOGsxcEkwWVRSNHAza0xhMllINzJZckxTOXNW?=
 =?utf-8?B?WHRoeWtkRXBCdTdrQWlhM0tRTUFFazhIY2t6U0ZTTFJkTHFJRlBJS05CZ0NW?=
 =?utf-8?B?dWtMdUtPMCs5NGZVWDg1VzV4cjVmc2daQ05YZHVqRzB1YXIyZFdjblo5Q0NW?=
 =?utf-8?B?YUhYWUNFMEgzSmJsbmVva0hZMW5RdzZhOTErenRWSlVEZDJCcCtsLzd6YW5n?=
 =?utf-8?B?OUsxS1NZSVl3R0lvcFBmL240L0hNWjFiSXEvZndXZWFSSlBHT3dlLzhaVjFK?=
 =?utf-8?B?VnZwcXNqS0FnNFgxeEM5bGZnU25FTUFkZ28zcHJyWVBOejZxNCtKbFdOTlV6?=
 =?utf-8?B?R3czL0s0SGxhcTl3cE93ZnRmdGRXUTdXVjN1MVJHNlZiUkR0aWtMakxaNW5X?=
 =?utf-8?B?SUJrbE11V1VoejBicC9RVjU5WnNpOWk1STU0cXdWdHhzQ2NCWHpBdE42RW10?=
 =?utf-8?B?QVNjOE5HMFlnT1VwdDRObVpWVTk2MUhJWDd1UnZwREFHTUpJRkU0elBWNmwv?=
 =?utf-8?B?L0FDUjRWK0RlczMvTFRlVGZwVWlzT09GdFFOSkY5ZGJ4eTlUUGdMZlE1bEJj?=
 =?utf-8?B?V2xQMFBzMFg2MmFxMnJWR0dISldzVk5uM2Z0THlKM1R5bGNRNE1xRjlSTW9z?=
 =?utf-8?B?RmdSUDZyVDlYcHdlSkE2NUt2aXF3OHRHK2tSQWE2VkFXcHFyVU1HNmZsUkZU?=
 =?utf-8?B?cWt5eXZZTXhNQ1luS2docnFqb1dYRFBuWGl0TVdGZzZrdFBkR3I5RWxyTGdo?=
 =?utf-8?B?VHdaWFZzT0l6dG02b2xxK1BMM1ltRnNWOTdjQXV5ajBpRGJwZ0N5SXNPR2pW?=
 =?utf-8?B?cnJjTkQ3VTcwcEg0d0o5cmdHaHBnYXRNRDFuaEpmcGZOajBvWmRHY0pPQmZQ?=
 =?utf-8?B?SDA3eWs0R3dveEVMNHM2U1N1Q3pKaXNIL0JJRTJVd01Ic21SaFRTL3VUUFRn?=
 =?utf-8?B?S1dVVm9RZmdkVFVYOXQ4aGo1Qzl5WFQ5MHJDYlNyUmVYWURRQ1MxUWFrelFq?=
 =?utf-8?B?SjFXeEVxUlNDcnlCNGVPMnZFdVA0QlU5ZGdvdnBzWVptRUNBR3pObFgwQm9I?=
 =?utf-8?B?OHZPdXRkRm9NNXlaZ2haaUpMazdYUjJObVBaNncyWkRMOU5NTFU1MjJ6cGVp?=
 =?utf-8?B?R3djekJTTDNrZ1Y4eXJHQkx6NGFuQy9LWUcvOVdmWXFsUk5hNmp1UjE5SmpN?=
 =?utf-8?B?aExMWkI1S2dFeFFtKzRmNlBycy9LM1JMY01idlIxbENSTTFuSzMzRTNoU1FN?=
 =?utf-8?B?eGFhVXIwRjF1cFJYb2FVcU9DYXdqckxlRnR4b2lSLzRoaXBnaDJLb1RzZDhn?=
 =?utf-8?B?REZsZjNqNUFUa2NpOE9GbkxYUFZ3WWpVL013NFBiaXFIeEZGQm11eFRzZ3hn?=
 =?utf-8?B?SnhHRmlJd3FlMHZNby9WRUJwejlySFJsSXROZS90R2RNMHhSOE1sV2tLR3Na?=
 =?utf-8?B?STJ1VU8ydDZlOVpGWU5qa2hma3BRYmtPQkxwVGxCcWRzbzdtVjk1amFpUHl3?=
 =?utf-8?B?bFVwcWh6ZHJMaE43blpLWWEwejVTWk9KR0ZtTVNUai9mYjlzNFpGSTBDeGxT?=
 =?utf-8?B?Nm9NRS9ET1NkL3kzajZHR0lQNXBqRkttZG56ZzJaUVlocDNhREMzMVhQbEZp?=
 =?utf-8?B?ajRZanB5bTVjVGh2bTdjUjBMa292YVhCY2EyMXU5NGJRSE5nU1NYbmxIT0hV?=
 =?utf-8?B?THhzNWtxZjNDUUY4d3VQYTFoOEpOZXd5TkJnaEZ2MVQzOW9yWWlTT0VEalNo?=
 =?utf-8?B?MWV5ZTNEZmNwb1prQjZaRSt0Zitsbko3SjBzcHgxS3ZXR3BvSkdKbmhsV1g3?=
 =?utf-8?B?WUFQaWFNK1o2MGp1cFdyY2xaTEFaVXNwUDRFYW8wQTQ5VnJYZEdZajJSaVRv?=
 =?utf-8?B?bWg3U2NvNmpXTElMSnBNQ3dFaFJaSmw5cXVFT1htcUxTMmwwQnc2Uy9IaFFN?=
 =?utf-8?B?Z3pQRUJmV0x5YVFhV2Z1YlVPdU8zd2JSMW1NZmc0c0JYZU55ZzdUaHI2YVdw?=
 =?utf-8?Q?qT75+WVs6foDgQuHpEva+bBZBARDJw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR18MB2562.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW9ZeEdIa0VidGNRNUcvZ2VEZENzL2ZKK1hVOGp2OSt3UGFxM2h2Qlo3Rzdy?=
 =?utf-8?B?ZkxxQXFOeGRLUTJmSjJKWGs3VmxDQ1JnSGE5U0JpUG5qTUUvdm11ZVNYbXVh?=
 =?utf-8?B?UkhJNmwzM1I2cUtyd0Y3eGQvOFJFS1cydW84UVBSaVJUdzZTaHBPUXlpZ1gr?=
 =?utf-8?B?Snp2bUNBQ0Y4MFhzQi9tSkNGM3NNRWVMYkJHLzhRK05oN2o2V3pEVWlqUXJo?=
 =?utf-8?B?NS9Ca2pSc2I5ZUJ2VnN5UVNhWGkzekp6ZHV3Mmx2TXJBNHpGVVd0K3BSdEo3?=
 =?utf-8?B?eVM2RzFVL3lhNUlsTzNpSG1YNXE1SU1LNGlPSmV0MjJGaUNTb3RhWmFkZVhE?=
 =?utf-8?B?cU1FOStjVEVOdWtGZHpjTThRNEJ3bG9vZm5oUjJvSjZ1YXFoK2lMOXk0WVdk?=
 =?utf-8?B?Q0cxNTZGS0pWSXNKU1VmeGhNMVlaZlRTOWpSbjU1OXkxajA2cXNraFZudnlo?=
 =?utf-8?B?YWhMaEV6OFc4TkFVRnl0UkhQV0JzL3VCczd3WU9lQXhXTVVjaHZOS3VCbG5O?=
 =?utf-8?B?MnIzMWYzRmxBbmQ0SWlieDVjVm1MK2N6dlVSYW16VTZmRzdQYjRsYldDQitT?=
 =?utf-8?B?MWEraWhHNC9QVUxSREVKWUQvbjRxN1pGUHFhUkYxTUcyWTJTUkg1dzhzQlk5?=
 =?utf-8?B?Vk9nS0psVFlZWFdkWmxiZmxPM1JXclVEQjdrcGJtVDFKdGJIclJ0QXNKMG5S?=
 =?utf-8?B?NjZER0dGSDhyMFVSbnNhci9SbjdabXMvZU5McVlQUi92ZitsamxGS29yVXVI?=
 =?utf-8?B?b2M1d1dZdG45dDRsVENlZFlVdUEwQkFaM29CeHZmeWxsaFIrQ1JZSnhETGJO?=
 =?utf-8?B?amtTMlVHYlpVU1pmTVN4MW5BYmdEZkhzQzRPaURZSDUyNWt6eWZ4elIxSml1?=
 =?utf-8?B?UlpSb09kWjNkelpFTk4za0RsekVwQ2g5WjkrTi9lMmk2UStKbTlFWklZZElu?=
 =?utf-8?B?TTdGa1RQd3ZFR3BJV1kzZ1VDWmtzVm4vMDJ0ajZ4Q3ZqOGVKWW84QjBXUERx?=
 =?utf-8?B?d05BVVJLVkxObTlsOHIxeks4RitwczdYTkpHOVRVdDdjSEI3Nng3TDlsc1pC?=
 =?utf-8?B?REk2ckVHbXNhU3JSZHpvSmZUejRjQmlLeWRERXJxN2N0M0FEUHNROXZvY1RE?=
 =?utf-8?B?KzQrc3VXVEt1ZVlJZElEdnJJUlVHeDlta1c0Q24vbEVvd1lmV1dxSkx0VEp5?=
 =?utf-8?B?cit0aGsvSWdXSVU4L2N5NzJuaTFha21GQjJvL0w5SzNiOFhnM01Wejg1OTVD?=
 =?utf-8?B?a3JvcWVnMkhBZ0FmNmlwTjFCUGhjaVJZQ1VlT2RTbXdBaVBDYXJmOUh5ZkRK?=
 =?utf-8?B?ZzJ1YTZId2I3cnZObFpqeEdLTUhUMndLQ3pleGpsZFFFYjRmeEdqS1RTV3Rs?=
 =?utf-8?B?MU16SU5RYVh4Y2RLYlNEQklQVzZwcmcxWkhhNGpQeWVzaEZmTFVVa0xyWnJt?=
 =?utf-8?B?U3RrQVhKWDdjVkZuSy9LekZZaGhiZ1h0aWRLaVNCMWp3MHJnS2NWd0M4VEJP?=
 =?utf-8?B?MC9VMzQ2dUpwR2R0VVo4Z0lPdVdaTXlUKzArVGZOUUlVODRHZ2RJM1F0Nm1Q?=
 =?utf-8?B?TFdYQmlGdlJCMS8xVUFSZ29kSDMwOFU2d0J6bi8wOC9JSjV6VkVsRGtManpF?=
 =?utf-8?B?bmtxRXZPazlsTU5UelhmUUd3QzdiandFZE5vUGZNRkQvNzhOVmxnUmU0U2hN?=
 =?utf-8?B?VnFqdGNZRTZtdmVTMk9Lc0ROVXVsbUJBeENqWjdwRWxUQ2lMQ2hvU1pZeUdX?=
 =?utf-8?B?N3liVU5oNGhPK095dTRuOFUwRmVTMWM0M2dKOGpTaG1XajExYk5PS0szejF4?=
 =?utf-8?B?MHFSNTFTZTYxcVMvSkdZbTBYaFRRTkNlbmdGTkxEelpNN20vRmltTHlpTmpH?=
 =?utf-8?B?RjNQTTBqVWpRMDZaR3pDNGtoU3NpQVU2Zml6QUI1UjQ2MExlczkvMUFFV21S?=
 =?utf-8?B?MStYRS9oQzZLZDFobU1TS291YXVWYTBUQ1kyTmtBeWw1NnlVK1hmaVh0NUM0?=
 =?utf-8?B?NTc0V3k0V0xTMEdrcXB3c21JVS9Fejlkb3MzcXlYV3ZMV2FjQTdqanA3OTZB?=
 =?utf-8?B?dkVnRU8vd1JReTRWMktIQzVCNStBNlhzKzFUTllXVUs4N0oycUNHMjgrRFd2?=
 =?utf-8?B?ZnA2Y040ODlPWUpiSWlVNWdhSFhFQy91VXZXVzB4T1FOT29xTGs2K2VVbkpn?=
 =?utf-8?Q?uhJz3IkOpT0UeJY8vTk93ZtrImGXrOt/MzkRLSE/AA/h?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <658CB51305CD224B8584DEB7DF88BABE@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR18MB2562.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68927738-a5fc-4f6c-a018-08ddce47bcde
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 02:29:26.2742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: At194ATFha2+mjNEt2KFbbay5/aI+ZhjD29Ae8YThDm1XCjD5chWaxz21o03EOFUVqqd7nxqVNOI6BUvW2H5RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5487
X-OriginatorOrg: amazon.com

PiBPbiA3LzI0LzI1LCA3OjA5IEFNLCAiRGF2aWQgV29vZGhvdXNlIiA8ZHdtdzJAaW5mcmFkZWFk
Lm9yZyA8bWFpbHRvOmR3bXcyQGluZnJhZGVhZC5vcmc+PiB3cm90ZToNCj4gDQo+IE9uIFRodSwg
MjAyNS0wNy0yNCBhdCAxNDo1NiArMDMwMCwgRGF2aWQgQXJpbnpvbiB3cm90ZToNCj4gPiANCj4g
PiBUaGUgcHJvcG9zZWQgUFRQX1NZU19PRkZTRVRfRVhURU5ERURfVFJVU1RFRCBpb2N0bCBmdWxm
aWxscyBib3RoDQo+ID4gb2JqZWN0aXZlcyBieSBleHRlbmRpbmcgZWFjaCBQSEMgdGltZXN0YW1w
IHdpdGggdHdvIHF1YWxpdHkNCj4gPiBpbmRpY2F0b3JzOg0KPiA+IA0KPiA+IC0gZXJyb3JfYm91
bmQ6IGEgZGV2aWNlLWNhbGN1bGF0ZWQgdmFsdWUgKGluIG5hbm9zZWNvbmRzKQ0KPiA+IHJlZmxl
Y3RpbmcgdGhlIG1heGltdW0gcG9zc2libGUgZGV2aWF0aW9uIG9mIHRoZSB0aW1lc3RhbXAgZnJv
bQ0KPiA+IHRoZSB0cnVlIHRpbWUsIGJhc2VkIG9uIGludGVybmFsIGNsb2NrIHN0YXRlLg0KPiA+
IA0KPiA+IC0gY2xvY2tfc3RhdHVzOiBhIHF1YWxpdGF0aXZlIHN0YXRlIG9mIHRoZSBjbG9jaywg
d2l0aCBkZWZpbmVkDQo+ID4gdmFsdWVzIGluY2x1ZGluZzoNCj4gPiAxLiBVbmtub3duOiB0aGUg
Y2xvY2sncyBzeW5jaHJvbml6YXRpb24gc3RhdHVzIGNhbm5vdCBiZQ0KPiA+IHJlbGlhYmx5IGRl
dGVybWluZWQuDQo+ID4gMi4gSW5pdGlhbGl6aW5nOiB0aGUgY2xvY2sgaXMgYWNxdWlyaW5nIHN5
bmNocm9uaXphdGlvbi4NCj4gPiAzLiBTeW5jaHJvbml6ZWQ6IFRoZSBjbG9jayBpcyBhY3RpdmVs
eSBiZWluZyBzeW5jaHJvbml6ZWQgYW5kDQo+ID4gbWFpbnRhaW5lZCBhY2N1cmF0ZWx5IGJ5IHRo
ZSBkZXZpY2UuDQo+ID4gNC4gRnJlZVJ1bm5pbmc6IHRoZSBjbG9jayBpcyBkcmlmdGluZyBhbmQg
bm90IGJlaW5nDQo+ID4gc3luY2hyb25pemVkIGFuZCB1cGRhdGVkIGJ5IHRoZSBkZXZpY2UuDQo+
ID4gNS4gVW5yZWxpYWJsZTogdGhlIGNsb2NrIGlzIGtub3duIHRvIGJlIHVucmVsaWFibGUsIHRo
ZQ0KPiA+IGVycm9yX2JvdW5kIHZhbHVlIGNhbm5vdCBiZSB0cnVzdGVkLg0KPiANCj4gDQo+IFNo
b3VsZCB0aGlzIGFsc28gaW5jbHVkZSBhICd0eXBlJyBmaWVsZCBtYXRjaGluZyB2bWNsb2NrICYg
dmlydGlvLXJ0Yz8NCj4gRXNwZWNpYWxseSBpZiBpdCdzIGEgc21lYXJlZCB0eXBlLCB0aGF0IGlz
IGEgKGNvbnRyYS0paW5kaWNhdGlvbiBvZiB0aGUNCj4gcXVhbGl0eSBvZiB0aGUgY2xvY2suDQoN
ClRoYXQgaXMgYSBnb29kIHN1Z2dlc3Rpb24uIExldCdzIGFkZCBpdC4NCg0KIA0KPiBKdWxpZW4s
IEkgYXNzdW1lIHlvdSdyZSBoYXBweSB0aGF0IHRoaXMgaXMgKm1heGVycm9yKiBhbmQgd2UgY29t
cGxldGVseQ0KPiBpZ25vcmUgZXN0ZXJyb3Igd2hpY2ggc2hvdWxkIG5ldmVyIGV4aXN0IGFueXdh
eT8NCg0KQWJzb2x1dGVseSwgYW5kIHlvdSBhcmUgcmlnaHQsIGhhdmluZyAqbWF4ZXJyb3IqIG9u
bHkgbWFrZXMgbWUgaGFwcHkgOi0pDQoNCg==

