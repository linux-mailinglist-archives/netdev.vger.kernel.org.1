Return-Path: <netdev+bounces-287866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEH/LPuQBWrfYgIAu9opvQ
	(envelope-from <netdev+bounces-287866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:08:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1960753F985
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4CEC300DF48
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008B63D9DA4;
	Thu, 14 May 2026 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3rX8qBO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E58030BF4E;
	Thu, 14 May 2026 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778749622; cv=fail; b=iejljoqb+M5jrMtEzabhWbo3ZeevXNOuXEQCx2N3Cv2lyQwUFDaSzA56aVCi/PyfESc2vsAjmRKKrhSvofo6haJD7QCVoGIzwTonHqH8FvWLqZvBLp+10HNjja1WbGPmHYAJPRje3enzn+f6fUe71E+gkGXwDcVcjt4j+u8RFqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778749622; c=relaxed/simple;
	bh=jTkiuH0ehEQf9LOMJaiRm9IezdX9KIV2CDFbiCKKkIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rmn/ZGTMIpAmQciHM9ND2dxd5wotppj8Seu3jR5sUH8U9YnMY+YIwqRt9Uc1/pvcywzymQkCWG+2Xu1x0pTMQzLSRxRssYPM006Wig6yPnAmqMjxv0z/PZXEvJ63a9Au43SwV5/L994dC7wiw53Y0xdCbYtVI5X0II3CK5TH78A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3rX8qBO; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778749622; x=1810285622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jTkiuH0ehEQf9LOMJaiRm9IezdX9KIV2CDFbiCKKkIc=;
  b=b3rX8qBOR/rpMXn5I9Y7ouD//jKvoAxQmEEjjOLm4mEDIXGRTfqhk5eZ
   1KJs0ANagMziW//Mos6LGlP5YYgcprQOEZekkuM8693SySky6K0foyx57
   BOUkWVLgFk8pZHOxOqBLtUmk3Q3ssoVDV0FwpCENmXjkV0DiRXeXVvxYP
   ZUP0d09yYljr7oXmQkeRMRT+5TsFzPEEKZcWwNJ78F/Ei/VNVtd1V54kg
   LLG4vrRUr6IlxUtyy/nl9pKTszCDa4qX5VoU6VvXAZhKdSJASi2uiuKjM
   H14fG0JDVx/z6pbXX+by0L+z6OcIh1BX8p5jm+aC3ebbRk3GeyLcatzBz
   w==;
X-CSE-ConnectionGUID: r/IWU9AQQZWo+geM25cvMw==
X-CSE-MsgGUID: 2cqEsJM/RCibVXAH1XIupA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="102357867"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="102357867"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 02:07:01 -0700
X-CSE-ConnectionGUID: C846Cb6fR8qp9LP6U1np1g==
X-CSE-MsgGUID: UOfABOx5Q0iNFh7P5WOptg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="235276361"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 02:07:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 02:07:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 02:07:00 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 02:06:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ml+8A/vx/DVir5ddqb7QqYx/3wYNI5DWhDMYSkgpSWUKsIUI/VQDJyQT32kHG/3noaVYuUxVczleYYVgAiLJEvi4BFQRZARDqVN1XBXUzOccCJEEi+qW0RcU+ReVz2yQgKIThJNeS58wxTE4vWusvektcUiylCX4LKTAcbSp7mHoSs5PmTX1WX20BMr34hg10RDVuyHYeM4HPmW2RlQvkKYM6opJKKaiCnIBTkyN4GOJGWsrcU7hWqoQXWisZeQ/g/WXjmrauOuCDV1josa66+DGjYjE8+7V9ucD+s4+usPBLl8uLwx5siy9cP1bwRR/+AkdBqIladLW7+6oJ+PCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReqOA1/fHPeggUGdNs2BhDstOmQLAsRScrdU9vIYMTM=;
 b=lkKJE0r8HQwfR4hdiZON/k5VP9aLym2qnY75A6CVrPZtpUku4VrKhDMLz53vtkxCrJ07tkYpqhW+mlMb28W8FTVSNZMDOYCIbrb3vl+GW3W0vKiMw9J0bFe/cxVPbRs3dQtg4GrhzdlFTEK4KP9s2CR6PWyIZHdrgtqRbZgTRkayxLudObfjuOlb9JXLBzAYjBZPEDOzCKNga+oYdoEXm2zTe/JQR/eITMOqQAzS/U7pC/x//hjduTiAiuhv8sZoE0zKdztsNAYvSCA/+W0abPMQHGhMhYx/Jq8We/mzLX1vN1T4pcXl/6sy8rAHWmgM72BpzCcEN4OyKwqqzhvKew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB4790.namprd11.prod.outlook.com (2603:10b6:510:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:06:52 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:06:52 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Blair Steven
	<blair.steven@alliedtelesis.co.nz>, Carl Smith
	<carl.smith@alliedtelesis.co.nz>
Subject: RE: [Intel-wired-lan] [PATCH net-next] i40e: Avoid repeating RX
 filter warning
Thread-Topic: [Intel-wired-lan] [PATCH net-next] i40e: Avoid repeating RX
 filter warning
Thread-Index: AQHc4znxAws3ky155UeDKINfRFUwBrYNO3pw
Date: Thu, 14 May 2026 09:06:52 +0000
Message-ID: <IA3PR11MB898611EDA9A5CB80EEAC743CE5072@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260514003733.1718771-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20260514003733.1718771-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB4790:EE_
x-ms-office365-filtering-correlation-id: 02c8cca2-f733-410e-f46d-08deb198238e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003|11063799003|921020|38070700021;
x-microsoft-antispam-message-info: fQovX8ZQHYFtpelM8pOu6dKI1JOSFCiI031ilgjuxXimgX60jivH07rYqVoikjVGV/9VVLQ5JCGf0r73R8p92YDE1ImmAsNveQ5Yc5STlkPfnedEE2Xl7TaqXFxRj1bFg6qprzGJTji6PVAIB2VY+AOJzhRC83BNTRUqyZlWgreZwYZbnAGyDppl0GS0io3idys+y9wfGG/u+pIBZEiKo5xShcG5ELfU2aTkN1PitskzoAmTRnr0ke+I3nEbN5SmM8kKymOpOP1ny5fHwdocTt3YEcVMtc7mqO2RTP7bbSXPWlDgsPPtZpIkZT8vn+27Zky5uG3PMhoVykoGaS39oKc3f3QV+zRPQ0j9o7kES/MxCPrlkP3aCzGO6VCrm96tG3Ji6Ziwm51uDEAFxbaO1T6Bx6w1pkYzntmWuXW/ZINYPpoum92NAlXgLTsF2imsLGRHSFvt1l2m9GQDFCrWgQxfLqwCy21h1DPSfCkW5Ns7KUY+99Zzs19kdCb1itzFHYC+nPukO2hNgu/j3ZqTGEFWAZK1qI5qfobY/G8u5h1c1uj26xbCrb3uhYReWzTrbyS0MqtJMIgVKVYk038I9UREEcZcH38aHxlHWdmySyWoRGwgCecG36jo8kdKiI/N4aPI6a7kXGYdVFkJQuUFc/D9xZ3jJ49laWVB3DRnqA1fKy7d8oNoU7hpH6i6szrNm7WndqhOOea+NOIcOEoY322cmCQrPYQKCwfkaZFHwznGOxzZZFlLF6JdFsc2D+MwXt6hqnnwnyeHus2JxwG9ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(11063799003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WaqCQ8wJve7RTi57+HuNyqX9G7ZvRKC/y+n9AE4X4DFrCcrBC09ekQOhSvrT?=
 =?us-ascii?Q?2toZkwm7ZIzuD/jhPbGf+3SE19/Fx7DdUJu9/ZZAciEl1FtcQTrTWuzMRYJ/?=
 =?us-ascii?Q?5by+gnTUuKRUEpELwFCDvdfwutElQK8b9JZ5oZ9KUkTgjJsj2eTEI8CFL17R?=
 =?us-ascii?Q?UEyvIrXC4+qShDz+CTXjgyiqGn6eJwxERcw60oIwc0wQNLSX3VccBuM5+8X5?=
 =?us-ascii?Q?PVq7WMwGCuYtU/4AFxH9jMKZsA1ijxBxtfSZAFz3AhvXa1LVYLW3AOJDnzEz?=
 =?us-ascii?Q?4v0pGd7uypVLgvWCHdi238Ee2dBM+AOsmUnIb53xhBilwrO1kICnEt/yMTkS?=
 =?us-ascii?Q?i7XmOMnVBN3LVEnPR++967G8YLn4C6/hd2Wx1GuU38w/qSXIRXZRRG77huaV?=
 =?us-ascii?Q?pyJKfZiadnTaLY5SS4sm7YIkeys3jpxAv5dK5XelssJDwEE4JhlUTNFbhNRb?=
 =?us-ascii?Q?lyKfdGx5hXFq6yrpuzU+FzgOT09F7gAyV4183R0bFfWQ3wUetTGZQQMC+C4g?=
 =?us-ascii?Q?9zWBQffeWZSa61YSsnTGOpSTGsLc/KBaiABpF80fNCbIcA1fjiY9GsAR3m49?=
 =?us-ascii?Q?lvA8+DtMkwkvn9uhgFuDbhhT6s7TkWmm2HrIZzGcBQ4Rj9rPwbA7xb7tZqWw?=
 =?us-ascii?Q?RGhc5av0ewfg2o0mZ8akRxAP2JoFfyGzGW7HjoLRmrim8FjKQKXRpVWw3fz1?=
 =?us-ascii?Q?fZrgHZR9lxHUXm1Fqgg99bp6UE7SnmCdeP4Fi0FC7S/q2EotoeIm6x+G6xSp?=
 =?us-ascii?Q?Uq1quz5tbsjQ49AydyFKuD9L1e8e+l7Tj1E/B3Ku+iSVuF7tlZR6lrlaEbGz?=
 =?us-ascii?Q?PfiXT10BroB4OTxO9QIL4uB2NXMMNYEFGw4KbGBjSmqk3wk0BYgmq3KZ3vbp?=
 =?us-ascii?Q?7ve5Xzncm9fYEYh8U/90fhRkVJ5f5xKHOIKbKLJtyl2rUHejVM206rfYAdgU?=
 =?us-ascii?Q?r/FJXvk+iVmZt/n08sLYa68zWk0eKEvjomP6B7r3o5da08KoYQQfYchGUU1l?=
 =?us-ascii?Q?+MUVMQdWIAj/NGlBhEd18MVUxOd03GmeJaCfXm7FTA3LPiG99ACBoI/DVlWG?=
 =?us-ascii?Q?tlEzumfzwwXzYj0I5t+t/8YO2cRFt5CNQVc0V4K055Frrx7DnVIJqd3FrhCw?=
 =?us-ascii?Q?d/gOkaX/X+xUvXyfsX8qzf30h29Mxnh99yK6V8Dk5UN1mLa0ohs8z9MC5UNY?=
 =?us-ascii?Q?asN33BAC/jlby5nu4f9JA/VeSehul7oMq0FLUfo5T/VvdSFMwXFVPDm/BVZj?=
 =?us-ascii?Q?ZoRapS9OsZ38GGabfZN0hKDbAl4Vzh/Xgn53uWHwUlZhlr63cKE7j3nXLgxP?=
 =?us-ascii?Q?gSF6RtvNdu8yIs1nvV99KedvEJ1FzbiQh6LE/f03K7Ccp97+55/ok+snwXcD?=
 =?us-ascii?Q?bILmbWzZdPS3D99mtjUAk80euFnjIB5Z2V56cyNP6hOCFQ2d93v0nrkiH06C?=
 =?us-ascii?Q?LGL4K5vJ5c+WD0SjaTpQefHdHOyZN2gOjjt43Tk1gyDpwj7KinbAOaRLyCQA?=
 =?us-ascii?Q?p9PO1n9Qq9uj5a97B0OhnF/feUdbx3Dsvzkj8e4jY4SYjEzGIUTQbVQTVVK+?=
 =?us-ascii?Q?7AcpvG4kkSG+FyB3uiNFu0iFjgOomZLCJ2KTOtu1LWvF06qQFPVLOJuP9v4m?=
 =?us-ascii?Q?S7VL2MEsyHjfw2syhjT7+/KmJ7ESjMnbf8uZL0VP7pyBt5FKM/lYN5qSdqcE?=
 =?us-ascii?Q?z93UNLFvbASk/PdDBkXeKSRqh/dfyQTeFqcXOfKtJfCTzwCtmKrenZlS6gkD?=
 =?us-ascii?Q?juQBbzNvDvBnjt8a7qk9giaS6P9AHSM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DTQj60kUmyUfTp839YcJ41+ayNrxrtwcIpaKnoroZKVKe0S2cuAOB5e41ZKLjUDsl1p+N5hdYyCyPO2Bo370/KL5EihvDuQlZsg+gNIKyTo2lZ8zsLDCsIoZD9cscgWgiu3V75/zDnDUwzQcdNFwc7gscBGpkA78T6/gNEfv3MZ5v+wKvqsn1QMvVudzpJbuY8AcSr6/odRsmdMHHp5jQ9sLvxWZnKuJTC/azaOKwzJDDk41kz7xfWjiJuSlDmhUqUFj6OQH86a+ze/vN37piWIuW2EebeD7oLjPFt2FJJcAgIvCbwGB8YW+QoTyym17hja1Ri3zmsQLtYQCynKLfg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c8cca2-f733-410e-f46d-08deb198238e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 09:06:52.2312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKs61DcAcRmMycPmYkPmr033t33Xq/QHXwikKERtoTN0MeZwbGxxA+VBuurcKH0e4PyEQecGMlEx20d5m8wSwmbl8Q8xOZnqv//g6+mwyMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4790
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 1960753F985
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287866-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Chris Packham
> Sent: Thursday, May 14, 2026 2:38 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Lobakin, Aleksander <aleksander.lobakin@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Blair Steven
> <blair.steven@alliedtelesis.co.nz>; Carl Smith
> <carl.smith@alliedtelesis.co.nz>; Chris Packham
> <chris.packham@alliedtelesis.co.nz>
> Subject: [Intel-wired-lan] [PATCH net-next] i40e: Avoid repeating RX
> filter warning
>=20
> When the i40e runs out of space for RX filters the driver switches to
> promiscuous mode and warns that it has done so. In scenarios with a
> large number of these filters this can generate a lot of warnings. For
> example:
>=20
>   $ dmesg -c > /dev/null
>   $ ip link add dev br0 type bridge vlan_filtering 1 vlan_default_pvid
> 1
>   $ ip link set dev eth7 master br0
>   $ bridge vlan add vid 1 dev eth7 pvid untagged self
>   $ bridge vlan add vid 2-4094 dev eth7 tagged
>   $ dmesg
>   [   25.601705] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing
> overflow promiscuous on PF
>   [   25.601833] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing
> overflow promiscuous on PF
>   [   25.601961] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing
> overflow promiscuous on PF
>   [   25.602088] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing
> overflow promiscuous on PF
>   [   25.602216] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing
> overflow promiscuous on PF
>   [   25.602344] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing
> overflow promiscuous on PF
>   ...
>=20
> Use test_and_set_bit() so that the warning is only issued when the
> driver enables promiscuous mode and not on the addition of subsequent
> RX filters.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>=20
> Resend with net-next tag
>=20
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 926d001b2150..8741990b5a5e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -2408,10 +2408,11 @@ void i40e_aqc_add_filters(struct i40e_vsi
> *vsi, const char *vsi_name,
>=20
>  	if (fcnt !=3D num_add) {
>  		if (vsi->type =3D=3D I40E_VSI_MAIN) {
> -			set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
> -			dev_warn(&vsi->back->pdev->dev,
> -				 "Error %s adding RX filters on %s,
> promiscuous mode forced on\n",
> -				 libie_aq_str(aq_status), vsi_name);
> +			if
> (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state)) {
> +				dev_warn(&vsi->back->pdev->dev,
> +					 "Error %s adding RX filters on %s,
> promiscuous mode forced on\n",
> +					 libie_aq_str(aq_status), vsi_name);
> +			}
>  		} else if (vsi->type =3D=3D I40E_VSI_SRIOV ||
>  			   vsi->type =3D=3D I40E_VSI_VMDQ1 ||
>  			   vsi->type =3D=3D I40E_VSI_VMDQ2) {
> @@ -2461,10 +2462,11 @@ i40e_aqc_broadcast_filter(struct i40e_vsi
> *vsi, const char *vsi_name,
>  	}
>=20
>  	if (aq_ret) {
> -		set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
> -		dev_warn(&vsi->back->pdev->dev,
> -			 "Error %s, forcing overflow promiscuous on
> %s\n",
> -			 libie_aq_str(hw->aq.asq_last_status), vsi_name);
> +		if (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi-
> >state)) {
> +			dev_warn(&vsi->back->pdev->dev,
> +				 "Error %s, forcing overflow promiscuous on
> %s\n",
> +				 libie_aq_str(hw->aq.asq_last_status),
> vsi_name);
> +		}
>  	}
>=20
>  	return aq_ret;
> --
> 2.54.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


