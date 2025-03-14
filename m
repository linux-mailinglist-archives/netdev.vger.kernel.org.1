Return-Path: <netdev+bounces-174979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C6CA61C82
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 21:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92CA3BD382
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B599205506;
	Fri, 14 Mar 2025 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCst75Ne"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB645204F71
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983882; cv=fail; b=m6Xwow8EojTGbOQ4qc61aob9nsIBVnqN0pJ3RnawO9aw73K1QDGcDYxgwXabnMPrpPWnNctb8CTfPZDA4wyDSGTHybi58J+eFy6nGUuIFJvJ80mX4mJYU6FnsY4ORI0gdP7wAaX+SPyjJncDiWUMx5Y3w3lRK+oVkkutqYdDFK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983882; c=relaxed/simple;
	bh=fgLACOLFjaA2yKtmqSE0HZv0K+tm9FzUPdHsJ8vQ9Lw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dtnLX7DJSNTn5I1p+DWHZMo4SkyLTPcRXPkEIkSEfv2t2OTSUUVD2c40OM5k+ANNKZBRSocL5c+hrrur8Gct2hj8sEHYKIvQ0sG4ALOnpWSZk/ptoKLo1YUMVis7U1Sdb2v8IxuOvjJ5ORq4wc2PvQBueDx3NkgNRhhr3mkj5Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCst75Ne; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741983881; x=1773519881;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fgLACOLFjaA2yKtmqSE0HZv0K+tm9FzUPdHsJ8vQ9Lw=;
  b=RCst75NedjMMu+3734lSCI93FM8us82c/N0NCdua+LM6D7M/KdW5UJeL
   a8gJMG+WaymybpiDIPTJbo7y9LeE5d7M/akt+B8Ndu8Vg6vFBpf5A92IQ
   zNKYkqPBf7yGzyik3RIacRcMhnHKUU1Ru1k+ik5hCboUO4um8rHwU9G01
   9HBm9aHSFWUYrzIl0DhNjFqGiB0mGQjcqSAsz/JsCh6b2Wb5yjuYDLebl
   5sPliHkD/tU1BQ/g/3ep4bIj6fLb+AnVDrGipT30pSt6l4WeCipoAY+BM
   Ye1ny4f3KNDiNjxl+uviprjid00qRF4r9+jkXjRvT4T09rbeT1abpLGnB
   w==;
X-CSE-ConnectionGUID: 20oOPVtFQdCrqlNNwuDD+A==
X-CSE-MsgGUID: DEQv1J3BRLmrC2Apij9TXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43056036"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43056036"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 13:24:40 -0700
X-CSE-ConnectionGUID: z39amT2tTYe+OAD3rWJBdQ==
X-CSE-MsgGUID: Q1Rs+xiBSlCm5VAG4aWLgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152269692"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 13:24:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 13:24:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 13:24:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 13:24:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgGGeiML3wWMHC2EzuiU61kOQ/ahD+4tvIjJYw/IbE5E1DzO1n6ROWiZ5NTC+I/yOAiXsCLtcrGIBMORB0UdsLFViyx06mFGd9zbsX2QxYQjMBffY0TABl1A5DSALQQ+mNzJj2OeYS/48J1AYCgJu2XfyfJdoipbSkako4LqQQQVBDVAK+0E5VDDlTPrsRFg8n56cHPzWqJUuwb73GT+4p3W1l7muT0z5+I1JtPHloUkQoTubQ8x8DqMWfqKBHo+CepRznJ+yz6ZcGAHJVLdIeMH4EV2WF35gTiq3AOlsnl4g4P3Igq8gdngibUDYhMJ/1txNdlFyl2WiCcNVaBy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgLACOLFjaA2yKtmqSE0HZv0K+tm9FzUPdHsJ8vQ9Lw=;
 b=hGsZbMtJiJXPq/wDrRBwXS5QpZS+jgRPRvXMTTzJ2NH6auciQIqWVV0uwZwuocY8VEqAtMt6DtlvBkZl1ql6D7QQPWd5Og9syoLEOPF2olBFU5uDiJ6/w40Ttk6O+g3czRUMl8oSaeqdq6U7l3c2k/GPZSkczpl2NouOG6kfrc/Tzshi9j/7+9ivHQtLrshguJo4BynXGIUiHTbDDAYySNlKaiZZuKmJk6rWZHfvpxT5PvQaNO4sYQdvV4+twBjDrLuamB7BN5T/69e5L5B7BDsPCLjUOCq4hvzSbRdWVXDfliR9/U92/91zLxiaXZ7G0m/sm3gNeAKQLSUMDobcMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by CY8PR11MB7922.namprd11.prod.outlook.com (2603:10b6:930:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 20:24:05 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 20:24:05 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Olech, Milena" <milena.olech@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Willem de Bruijn
	<willemb@google.com>, Mina Almasry <almasrymina@google.com>
Subject: RE: [Intel-wired-lan] [PATCH v9 iwl-next 03/10] idpf: move virtchnl
 structures to the header file
Thread-Topic: [Intel-wired-lan] [PATCH v9 iwl-next 03/10] idpf: move virtchnl
 structures to the header file
Thread-Index: AQHblELxr4oh0SSrlkuEA+W4ze6xurNzCUKw
Date: Fri, 14 Mar 2025 20:24:04 +0000
Message-ID: <SJ1PR11MB62971A099BE3E6EBEC1CA42E9BD22@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250313180417.2348593-1-milena.olech@intel.com>
 <20250313180417.2348593-4-milena.olech@intel.com>
In-Reply-To: <20250313180417.2348593-4-milena.olech@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|CY8PR11MB7922:EE_
x-ms-office365-filtering-correlation-id: 72305546-30eb-4428-dfa8-08dd63362b0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?W8k/7EVB9BWukBesHbK7xOkU7iBLL8a1CMy6LJBhZJS4PQZrK4uc1LqPurCc?=
 =?us-ascii?Q?3+gZqNYqGlFdOvQuq9jKYtw7wouDehgB80E35sYW3+LZ56V1x2ar2OWVbBOt?=
 =?us-ascii?Q?YqR68Csk30osuJR3VfEXt8W2kX2dhcNty8VE/4HASzLdKPTq/mTVeXylcpPX?=
 =?us-ascii?Q?b9pO7zPuoBHDKhOA8CDQK7fYIGSrhLFfYB0GQ61P7elo9OTlABcNUy8KUKh7?=
 =?us-ascii?Q?ahD0H+wXukR3/c9Fi6H6xBfWTCj+4IWD/Rj6bPFCDFOU6fXY3UjVifjNPPz0?=
 =?us-ascii?Q?kI5Dr6rm+iabWIN7rJD0O8vbH1E1EclQ0Rha+J73yVUHbjduzt0GxgvnNo6R?=
 =?us-ascii?Q?gi0yFI/wYIfuOu9jj26bSvh8Mbh4TM63IolN2aWoOQEn9erYWwmfWWGWmK8Y?=
 =?us-ascii?Q?dcFP/fd+S42ce7yJwtuefK2CEkTqy/lSYE/X71A6d6icqXnEuSBO4kGdpf2x?=
 =?us-ascii?Q?Iey6N+G8eBppVU5ZOEvCEcjJRawMqa5X6sUzSuE+QulLWzYtGot8WbV3eoOL?=
 =?us-ascii?Q?xTE1LMKOnfFH26cIArqn1Wwliwy/XRoFW1vR+qthgaxXRLMkwv3GGZ+AKtXt?=
 =?us-ascii?Q?Lun5TwJu65Pqyq+eLgj69PadNYwB2vBYKz2R1abqxmSDvuFLQNdGSKmGHO9N?=
 =?us-ascii?Q?QdhwjhgrCWQp4qE0IMp0OwSO5uMwOL63lSXpt+v+zpNgHFpepz3p3+u9Diic?=
 =?us-ascii?Q?Lw/G8h/w8AV3p6OgRLT8HZJXMPZD/AVdsDBH7O6Vz9LS3uA8I3no3lakOXDB?=
 =?us-ascii?Q?HpuUhwJo29AqmVbDylHm7wpI7Uo1ztaxMUSaT6vj9Wqdddz31jTtA+8dimTS?=
 =?us-ascii?Q?I4DUa1i0Vl+7H/AWjg/6d9Nn1FFtyMxdbRseGt867arZzqJG7ZcJ6vFe7Nl7?=
 =?us-ascii?Q?XAsFrvGcdjoDClzssXQqN5QRGjM1capXuy2ETHl35fonRV8Q+J+OLTGKvuel?=
 =?us-ascii?Q?vAZ190v62qihqROQYLQJv0uXMTVA5g4+qUTWEUymZbmIA2no8QDyECMWGz+/?=
 =?us-ascii?Q?X7sncqNRDrHE+Hbzc1GKLA4KCEaQSmg9Lpv6P7ULlsErTDGz9fk4qoFIltcD?=
 =?us-ascii?Q?O5PEqs0OVIxXkMN5xBeEPsg+VyrJg/AZMUYeaaIRCCb5DR4CIfD6JK7ZIGCK?=
 =?us-ascii?Q?v9X/WJG4SKBEeDt5q2ppVVDpPZhl5mpWWQeuwPF5aB3Hx8zrPhAH0rYaPHpR?=
 =?us-ascii?Q?62NOWdzueh3gPSx2o93VKfTkmHpA2ilf02aTkLQaXJByzrQjMUnuUmldFMxW?=
 =?us-ascii?Q?L2XCzNf/jJVGAUwv2Ccm1HyKSBm/9qttpL3P78i5J89RJMFmeJhxclzYJ2WV?=
 =?us-ascii?Q?GwUgaN4cNFik1kEkpDtJciQoaywtHmNGIjP63bS4yo9d9oXOMN9eq3mZtMr8?=
 =?us-ascii?Q?qYDzEQ+ZHitYUkxSBcwIbTIT3lwMGnhRUZaGTbXXVzXiWDcEg/0IB8E0pL6n?=
 =?us-ascii?Q?O1EGfrjvdRDqnjvTZb9vK78jnEZyQLr0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QH04r8f7Q6PHRo/2wxw1m5b9TsFWvNl0y2rykEQkaIl17RdTn+vv7VKvHq7U?=
 =?us-ascii?Q?8786T+JeK/4UyuT6Z1Dq26dXrSa8TYVnVPshCpnvFfP81nwGVTtcyGF++7T0?=
 =?us-ascii?Q?6/OQ8hY68ATYBBYnS6cqYsHSgUejtXVlWQAQwbavziD1FwNWTS9rPbJdFbq9?=
 =?us-ascii?Q?adyRguW2XLbLDxCBI7u4YORzteAlrQ5cjMWE248vDiKedIH29R6rHdM2qXS7?=
 =?us-ascii?Q?SWA1YmxbvlhI8AZnlGw1sBA4lJ/ph5Xih665njcxszJZovjhYxRKMBbkgiK1?=
 =?us-ascii?Q?rFU7u2RLy30U3X70dKq564mbgJ/p/e55nctHtJQoUIUppDuLZcW/i0hmJsno?=
 =?us-ascii?Q?qqC+BjFSdu2ooRurKxAtlzr4J9A1YwwtQBq1DO+RkYgU8bLY0XgMZUwTvTt5?=
 =?us-ascii?Q?uNowLtzaGVfG6L+zHvtXGIRnMr8qfRAUM4jiLcwEt9x35dpWE0UG8OjcTzMQ?=
 =?us-ascii?Q?C/2P1aLlzvp6f/SNu6UNvF7Wvc7GUzLLdwogqwX1+lXxH+rwPbqx1bbtRmj/?=
 =?us-ascii?Q?QCxL65f1HHqJSc+89tMfHOjnvg6jdtZdqHUDQDinVCV283E+tcJSlKpWAOgP?=
 =?us-ascii?Q?z2mOlQ5D8QZEGUHD1eThnnCgv2d2ixyZv7GyTf4wJ8uE0Gqfl0nuc6f3DOxt?=
 =?us-ascii?Q?5BNEMmIg6hB5oxEdF1/iVMQtVrhNsplnDA61YnFY5Uti9oBtmuCsj9kj9i4U?=
 =?us-ascii?Q?tDoAdtzlqlriKkXr0kAYljsccPtSdOhmwdJ+qU7hKQ3eXSmtxS1Uq4TBmMqc?=
 =?us-ascii?Q?DXp+xEzOP9SwfixdRaSE24yQu5+3X0EU2zxX/ginw89BPWhREJAWvKVqdnfa?=
 =?us-ascii?Q?T0TO2BI8PnZ4cKpCfTJ8Og+hm9CyFuzqOQFSfVyEW9uiD1xFAEdyvR7BU0Jm?=
 =?us-ascii?Q?RM8dzQCEXoMqt1vEUTAH4UUY92tGbAK8gqXXwq0DV1SaIWTIn2XiGjuASIIL?=
 =?us-ascii?Q?MVBoJsG5LsA+HEPD7AkSFgUpQ5IVB6GgyYuViz+nCdaEOzhuQdfj3P6wrqBa?=
 =?us-ascii?Q?WvO7x/XuoPnwReCapbVnHpvHrNUgtK1psiB82K8yn9JCFH+3Zjn26kUqOOAA?=
 =?us-ascii?Q?AjQ09IaJSpJLL9jKDm3kI6GhiV1kHrsn0XesMKvVn8LWxjlg1xX2s5hXVhPx?=
 =?us-ascii?Q?LRMhPHEfp1YEK+baN6ALlVBZp0QGLAliiF/yaixc2uj12Qg+wIAuzn8UU5aS?=
 =?us-ascii?Q?BZ7T2jG217sQ3eu+IQbrkJAzx5/OVD+DaoSRdrsROzuSLdsAJvc2rbuwRHQS?=
 =?us-ascii?Q?7DlLqMrTts8/0w0PW7BIonDsvf9VUgQUgG3Y/7qgauOdKIMZ9CUuxqcC9Qbp?=
 =?us-ascii?Q?1j1m2zRmerIezb6zW2lDsHTpIKQ7ec08LoQQfuhvvTfQYKCiXkYn192lkdTp?=
 =?us-ascii?Q?qXwJRXzWAWietmuIgK4k11hCjaeJkAgOxpyAl3wpLtmLGuUHzm+90S+7nm33?=
 =?us-ascii?Q?+d9ruKO5cKzEmmnOyUGNKSt9LAKCJJZUYTCRMXUiHP6tkVpFXtpi0SyL4cP1?=
 =?us-ascii?Q?UcAD9Z8L/DLDHbjDGHPR/R6fEiGHkOHMXWdZDK13j2O9GtTNai9/xLhXIVgU?=
 =?us-ascii?Q?DyIINteAg9AX+76mPHMlhdZyvdfjmqtHzuZfJy4V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72305546-30eb-4428-dfa8-08dd63362b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 20:24:04.4192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SLCZ1c9CzzZ6sxDvgZm8oiy9Nt3QrraoIyijpkPAgjoPdgt6ep3r+u21VYg7+r1lmYmLFtBqfj1TwQtE/YZnZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7922
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Milena Olech
> Sent: Thursday, March 13, 2025 11:04 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Olech, Milena <milena.olech@intel.com>;
> Lobakin, Aleksander <aleksander.lobakin@intel.com>; Willem de Bruijn
> <willemb@google.com>; Mina Almasry <almasrymina@google.com>
> Subject: [Intel-wired-lan] [PATCH v9 iwl-next 03/10] idpf: move virtchnl
> structures to the header file
>=20
> Move virtchnl structures to the header file to expose them for the PTP vi=
rtchnl
> file.
>=20
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Tested-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
> 2.31.1

Tested-by: Samuel Salin <Samuel.salin@intel.com>


