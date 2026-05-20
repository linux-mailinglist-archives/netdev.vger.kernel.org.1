Return-Path: <netdev+bounces-289938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE93IEOsDWqP1QUAu9opvQ
	(envelope-from <netdev+bounces-289938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:42:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EECDD58E008
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8146B30E8676
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF3C3E558C;
	Wed, 20 May 2026 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cpXmgtqR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140D03E316F;
	Wed, 20 May 2026 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280671; cv=fail; b=GystCzJ0AWxcSsdxnyKFlcvdhTYeCa0N1JSB8nasJxVhXHKhc19yWUxdDSKtsHAJgeebAf3RXHJ0WyhrJKV5Jnhc7yr9lKCKg8FazavfCbmpWvw5t9sudrUgXf36wsBMGLDsf6eSqmFvjvqieiTGqIi+yMYdO9SgInBbvQS6Gb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280671; c=relaxed/simple;
	bh=EVvRAIrxVMW+sFAUBDAXXlOe1/oMIkQ3QevdJHlpEO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o5G7iCt8v7a0onxnLs8Lw/fkt/AyltYnkEsO+H/YyCA/lnmGgHm16sonaKG8Rtvy0/jMJaC4c0Fq5xC4da4t04KiUcPdMYrnWwdQ7k5u0rtk1YPYXnq/eHZ5n1lbNpwvkx0HzVMmuBla8rd+pKcOEsgXxXtJN8FD1uDWpzuq/qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cpXmgtqR; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779280669; x=1810816669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EVvRAIrxVMW+sFAUBDAXXlOe1/oMIkQ3QevdJHlpEO8=;
  b=cpXmgtqRj0ObeXr8zRH7fjjy3LaUehugLNuVLi17+m2EmkAD88klNgca
   UicqcJLiyaivCtwEwBIvW3M1pmCbXFspdlTVKhgf1/QjDij8hWXgbNUjB
   p/3tS+Q0mKg1r/MTL/AlFEM4TlW/ztCKYHU1IiT31wJvfZ/sD0Vm4uDEV
   x3vXeWxO1hae99G4Xrovz1DC2YEXk1UoM9ig4E31X0Au7fihC0y1+ZJ4l
   k2tzdLX8nJcrQMbWMlv7nMCR8Y5Y6AbFwgximkyWuiVOPeV9ZPsaOM9dI
   3PBp8Gpgmb0rH1Dis9RxyMCwPypV5BGRiupBmWrkt0NzUAG8kv5W7jMGm
   w==;
X-CSE-ConnectionGUID: vJPjwZ4aRzq1GPjE9BcgcA==
X-CSE-MsgGUID: bXQDZhpyTum4oMRWpfaVoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="84058259"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="84058259"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 05:37:47 -0700
X-CSE-ConnectionGUID: l7qYfaeJQOWKBR4bVxe1zA==
X-CSE-MsgGUID: KKdpskE2RliySEcL1UVCtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="239320776"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 05:37:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:37:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 05:37:46 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 05:37:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI7Xr1NyOoT2E7dubZyJ9yD624SFMI55uhl2s0IE1OnO1kamnBU0XtUKaxBIyhrw6xqZeU4u1S1fjiMyRljQiqN1SM49H1INXjhRCf0Q+5Cg3vu15Q+Ri6POUsZKEsy7q/LVUHeBXuUscyZ/KKkV8HKORnrqBbrOuqLUlmV45wPj+tlXJkp+0XFi03YbTSc6BepM75q8nrQmUIprULGd/ZQ96E5JBvm5Y9rvgwnVGJOfRDooR2gBLIxidnk4vIhaB/VKvE+yaHy3TreVw8CXHNBLdGjVUdDcz6LgPQkzCcSbRu/vvdrqLFm1ZCXfA2WwJ1qQPOx8OrEYPnONC87q+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irm90f0OccW+sC2OJPVLj51nYD9Rl9cK0VKDGuclwUI=;
 b=X+6IomyaGry5W44Y1RnNRnQ8foUd/6FlTdVDwtjWtOb0IdMeZTx1M+vCOPoqWrbJGq5CwmjGVbCruV6Ny6er/kkfhw+I6DKiGw+grggITSGyPm8wr8D0zqdOa0EkWzD3sQW+zrSzF9m7TF3re0+hpU67MftkjnFi9NbdLsiXauNfUOr9Nu7D0CrR7qQTeaYDdTEJqxrsHR5Qt51mMVWaD1r3vRBZC53+SfSlaEibLJTZpF9xLR4RguuYDiTWoJ4yDyZUsUXb0/w+yZ5SAb2BrKmAzO3PnaH13w0B02Ij4dcK5cPd6iGOFdC3ZBvB6xVPX0nBml2ccUDID08nxNJ4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB8415.namprd11.prod.outlook.com (2603:10b6:610:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 12:37:37 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 12:37:37 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "kuba@kernel.org" <kuba@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "edumazet@google.com"
	<edumazet@google.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "horms@kernel.org" <horms@kernel.org>,
	"Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v10 net-next 6/8] ice: implement CPI
 support for E825C
Thread-Topic: [Intel-wired-lan] [PATCH v10 net-next 6/8] ice: implement CPI
 support for E825C
Thread-Index: AQHc6Dz0P7R6Nh5vm0K7IGNCMPx7ZLYW2hvw
Date: Wed, 20 May 2026 12:37:37 +0000
Message-ID: <IA3PR11MB89869D3D47DE538225AD222BE5012@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260520093628.3930705-1-grzegorz.nitka@intel.com>
 <20260520093628.3930705-7-grzegorz.nitka@intel.com>
In-Reply-To: <20260520093628.3930705-7-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB8415:EE_
x-ms-office365-filtering-correlation-id: a7ac6971-962f-4359-d9e2-08deb66c92fd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|3023799007|11063799006|38070700021|56012099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: 1fcS0rKH9AY30S3lNq03jFPESvOVmIZeQxr9bfQXjnWBaNSbOH2rEuJTZLWVrGmyW2hU6ZKYglJUj9k/HLkG8XhMc6HeUFAWGn1s3Xa6C2ZvQyGTLbFSxFV45b3oINayNaLi2VnXi/WTHTj/BRnULuansKQlt5ZmukTDiKiR/0rDdhKnyfrDgMwPCYkAiLeQNqqB0XxIAnSpw0DX1idF3+M8OVIYC/lVQop6bJFgD6zfhaVOe2WodkApAs9pYANhxqklTg2igBeLuPKPLKmZGT+GWMHW5dUxoHGl2ii5LU0hH4OkUahEKhe1qVauisa/bD0hyX65DF8JzbXVZl9mzK7+wFF1KNyGSLNYWFB2ayeVSmSHNQ3LEy9yOrkAufblpG0w6xNT9f8K5A5Zi9MFBBS0W1Iqf2DQrBxTmwhEoSdrwt+O7mJrYxvfQyjpn8X2v7ndauC5PIhMAPNhIS8EldWvLQKq3IhZEeuV6WN6MKGHkTBb0VsiV0mPDlOvCFoTbBOcu12U4wmTga4HjniAYf8q71L6pZvFvzXBGVzXtowL9X6TGCNRAV+RsWmXT0gUSovI74Ne5j3BfaaPVvYye39RePGXrSgMTynGKqVR/E4+fXt/f6lI8ZaIKnRjC8Hla6w+j2TO1lSdC/YkfaYzfb0va4TGBVB+hPJHVzQnqmNeHr0u447drfV5pKP9BjCXENfC3defpEcz0tN2eEItkLf8DnbQ2Qkj9JHNB1j90B6RLipC3P8CYPM49ggtJSSz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(3023799007)(11063799006)(38070700021)(56012099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zIngki658ITkR3eaoVqxQw/eYwf8OooB1WnwovW5oNF4G2kf7pRzROm/Lm/R?=
 =?us-ascii?Q?70OlRwMo5JI2+udMYA442fqJliSo2axW3yZG3opKccgdoYLpOB6deB21Lo7e?=
 =?us-ascii?Q?S/r6hPO+UN44VGzsmJ4i3+3tFDfWHF2wuVX5iTIgmb6tbCfXrTDdWz3JOHAd?=
 =?us-ascii?Q?AuuY4/Fqc46l+Ko6SlShp+FJ6bOc8Mw17rlqv1caXWMZCThe0RBgX7/yWZVG?=
 =?us-ascii?Q?L1F+iQw+L19XUm+cFIQ+veIGG1gnJ8Zb3feWJn2IRtP0v88UeE5YQeiJohq7?=
 =?us-ascii?Q?c+rEmr4Oi84wkU4Y04akffCqvGbZIxU6Ed/GaPxotsQC3hRt8yoXxiybPULi?=
 =?us-ascii?Q?ccu4NiwFATSRqy+j2Q6EboMfrK7tB6wkX7s8pUosjSK9qQay7plPkIXAwtPC?=
 =?us-ascii?Q?4Ymes/uF2uw5+f/sV48IeThepP78nyTp50xWuqPrHgfY4W014E2MC2bccbW9?=
 =?us-ascii?Q?aDFeJ1Ab5wk7tRwkxzfY/8F9mjs59bMRf12TU88p/oX58Y0ZKFHWMOvARh3L?=
 =?us-ascii?Q?FQQOCEgNR7sv+nJeOiyIrM45fK9vJaxnzv6YmlkRgmnAmzfb/eSQtm7F3ZDB?=
 =?us-ascii?Q?PN+PmXIjGIO5V8IYJbWkXALaPtScN75MKLTa1njk3BUTNkwomwCjpSGcmJ3i?=
 =?us-ascii?Q?AEJPToX+v96lbGiHRzU1Q3VhHwW+aD+nH/joSnP4TP1N/O1icFCv7KY4y7bn?=
 =?us-ascii?Q?X+mDgNb3Q2VFm1HdfhJxW7iNVy290mA1z4I3KH3UiSNax/Ri+G3+nYHoyRVc?=
 =?us-ascii?Q?7feyaPxMLqaZWmkphMjsZiynGHZz1V6hydhuMKS04BquRvNYAVA2sOsTVCpv?=
 =?us-ascii?Q?6jRX1HJAvRS7F08rTih70LA6UmtTElwkJX9ZxdODQCEOFNjiyGJqmlsWP/jJ?=
 =?us-ascii?Q?t5gctg7Kl4G90XNVc14H206yGo6zG/YenBNHOrjn1EewUC0y6LWlPkfQZSZt?=
 =?us-ascii?Q?9eoI/BNUMCygDnahSmaj2EJp4vHYPUixueBte6jo2pWgC9PdrSbObBl9TcHl?=
 =?us-ascii?Q?5eA+AjxZ/suFxvIOgkMNVIq1xs7pJpZkhBNcvELAdmhis2PwsohwbJMqhtyS?=
 =?us-ascii?Q?zguewjLzsPnSihuyNk+RtgWZ51YgqrVblVJcqLkILFfb9jhLQOXqUIA/5kM9?=
 =?us-ascii?Q?ST2fQ4KoRFMvhqNCIGEYH3SBmtE85X0AJ76mch1fro7QKhNvChR314l072DL?=
 =?us-ascii?Q?cPNbKPvIpSKBVCwak5Vs1LDISo5n/GBvEuhwF9OSG7G1XwCxgI1wKRd6ya7n?=
 =?us-ascii?Q?dGaqLFg7E6V2Dd6liWyBBkx9o4xXNZKuGOWfxJKjCRC8Gi99brxwlGZ54xer?=
 =?us-ascii?Q?9GD3vkAgcZKEjtUZ04vJapDwd5AUUv6yUvasBhcdT6u6mAaMFID1VdgzaKk5?=
 =?us-ascii?Q?sZI8nfOvivqwkyBr+l/+znmGnl1/iaS4lRW0ItZ3zzYsd5VPuU0yodDfOBhq?=
 =?us-ascii?Q?lI2w/soxVxN/2Oz5QEpu2cjlrphReEOLAtCKmp6QVghOgu3a0fAqiHlGOn9g?=
 =?us-ascii?Q?hGkJDmxLV/r8Q3h765QgcOl7fyMcYCY8qIBnoAUeOHtuVouFmaHMPr62GAiY?=
 =?us-ascii?Q?/yOJggmhhZdr279bYDYB0mgXUDzVNnXDix69dlry0JGtNMbPfLh4J5f5hKcu?=
 =?us-ascii?Q?YLNyuAZGtkwRdwp6dQpcz5ghZ8hMvmTERT33S37UZ8XyTAH5Odv/a16oiA+D?=
 =?us-ascii?Q?gAiXlZCoeIRbxua9Oia25lsyC10Iqn55HSNJjae0NJW5qkMUaaB1Z0lJAGD0?=
 =?us-ascii?Q?fHtIA/jOYZXvCQ5UL0RQ44Og4kihtBc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mX8HYv0t0YSc3PSvQbYHE8l8DXxXgUKJ/qcTgox0d98MK+Pqzzwq7UVl9RAzRHpl2o5odxH/cXdenYj5rvpxqPrS6HCcdYqorZRha6XROLMUUNREkDCXw0WsZ/l2P5JqgSsmy1MBormfMJrVKXF8KVCuVIryirNfk35SWZuSrn9Z5VECpUODe1E+Fm8mBfZoiYrMX9nlE1HV++QTrxV1sf1psZKR3PKQbtK9aY2MMaEP8xaOVoZ4GsN+psVWUWBZSRp2C4NqVvxLux2kzHfJtmt67A7aaw1NCz5ycsSf3AUv6eOG/HnWR24T2CruoDWR5M5W25oFX7Fm5Q1J5fZHRA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ac6971-962f-4359-d9e2-08deb66c92fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 12:37:37.1685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTQpSTcr7Wq2GzS7o4hfN4vKx6x8Acq6OOc9Hh8xkv3vSNMih4/K3tbN74gb2HnOM2Rp548+vDUXF/bu0jTR7qAvTFjNsiu1mTIbhKmxVJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8415
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289938-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,kernel.org,resnulli.us,google.com,intel.com,gmail.com,vger.kernel.org,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EECDD58E008
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Grzegorz Nitka
> Sent: Wednesday, May 20, 2026 11:36 AM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; vadim.fedorenko@linux.dev;
> kuba@kernel.org; jiri@resnulli.us; edumazet@google.com; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com;
> donald.hunter@gmail.com; linux-kernel@vger.kernel.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; andrew+netdev@lunn.ch;
> intel-wired-lan@lists.osuosl.org; horms@kernel.org;
> Prathosh.Satish@microchip.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH v10 net-next 6/8] ice: implement CPI
> support for E825C
>=20
> Add full CPI (Converged PHY Interface) command handling required for
> E825C devices. The CPI interface allows the driver to interact with
> PHY-side control logic through the LM/PHY command registers, including
> enabling/disabling/selection of PHY reference clock.
>=20
> This patch introduces:
>  - a new CPI subsystem (ice_cpi.c / ice_cpi.h) implementing the CPI
>    request/acknowledge state machine, including REQ/ACK protocol,
>    command execution, and response handling
>  - helper functions for reading/writing PHY registers over Sideband
>    Queue
>  - CPI command execution API (ice_cpi_exec) and a helper for enabling
> or
>    disabling Tx reference clocks (CPI 0xF1 opcode 'Config PHY
> clocking')
>  - assurance of CPI transaction serialization into the CPI core.
>    CPI REQ/ACK is a multi-step handshake    and must be executed
>    atomically per PHY. Centralize the lock in ice_cpi_exec() and
>    use adapter-scoped per-PHY mutexes, which match the hardware
> sharing
>    model across PFs.
>  - addition of the non-posted write opcode (wr_np) to SBQ
>  - Makefile integration to build CPI support together with the PTP
> stack
>=20
> This provides the infrastructure necessary to support PHY-side
> configuration flows on E825C and is required for advanced link control
> and Tx reference clock management.
>=20
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile      |   2 +-
>  drivers/net/ethernet/intel/ice/ice_adapter.c |   4 +
>  drivers/net/ethernet/intel/ice/ice_adapter.h |   7 +
>  drivers/net/ethernet/intel/ice/ice_cpi.c     | 362
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_cpi.h     |  58 +++
>  drivers/net/ethernet/intel/ice/ice_sbq_cmd.h |   5 +-
>  drivers/net/ethernet/intel/ice/ice_type.h    |   2 +
>  7 files changed, 437 insertions(+), 3 deletions(-)  create mode
> 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
>=20
> diff --git a/drivers/net/ethernet/intel/ice/Makefile
> b/drivers/net/ethernet/intel/ice/Makefile
> index 5b2c666496e7..38db476ab2ec 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -54,7 +54,7 @@ ice-$(CONFIG_PCI_IOV) +=3D	\
>  	ice_vf_mbx.o		\
>  	ice_vf_vsi_vlan_ops.o	\
>  	ice_vf_lib.o
> -ice-$(CONFIG_PTP_1588_CLOCK) +=3D ice_ptp.o ice_ptp_hw.o ice_dpll.o
> ice_tspll.o
> +ice-$(CONFIG_PTP_1588_CLOCK) +=3D ice_ptp.o ice_ptp_hw.o ice_dpll.o
> +ice_tspll.o ice_cpi.o
>  ice-$(CONFIG_DCB) +=3D ice_dcb.o ice_dcb_nl.o ice_dcb_lib.o
>  ice-$(CONFIG_RFS_ACCEL) +=3D ice_arfs.o
>  ice-$(CONFIG_XDP_SOCKETS) +=3D ice_xsk.o
> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c
> b/drivers/net/ethernet/intel/ice/ice_adapter.c
> index cbb57060bd56..2dc3629d6d0f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> @@ -62,6 +62,8 @@ static struct ice_adapter *ice_adapter_new(struct
> pci_dev *pdev)
>  	adapter->index =3D ice_adapter_index(pdev);
>  	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
>  	spin_lock_init(&adapter->txq_ctx_lock);

...


> +/* CPI PHY CMD DATA register (CPI0_PHY1_CMD_DATA) */
> +#define CPI_PHY_CMD_DATA_M	GENMASK(15, 0)
> +#define CPI_PHY_CMD_OPCODE_M	GENMASK(23, 16)
> +#define CPI_PHY_CMD_PORTLANE_M	GENMASK(26, 24)
> +#define CPI_PHY_CMD_RSVD_M	GENMASK(29, 27)
> +#define CPI_PHY_CMD_ERROR_M	BIT(30)
> +#define CPI_PHY_CMD_ACK_M	BIT(31)
> +
> +/* CPI LM CMD DATA register (CPI0_LM1_CMD_DATA) */
> +#define CPI_LM_CMD_DATA_M	GENMASK(15, 0)
> +#define CPI_LM_CMD_OPCODE_M	GENMASK(23, 16)
> +#define CPI_LM_CMD_PORTLANE_M	GENMASK(26, 24)
> +#define CPI_LM_CMD_RSVD_M	GENMASK(28, 27)
> +#define CPI_LM_CMD_GET_SET_M	BIT(29)
> +#define CPI_LM_CMD_REQ_M        BIT(31)
Indent inconsistency spaces instead of TAB

> +
> +#define CPI_OPCODE_PHY_CLK			0xF1
> +#define CPI_OPCODE_PHY_CLK_PHY_SEL_M		GENMASK(9, 6)
> +#define CPI_OPCODE_PHY_CLK_REF_CTRL_M		GENMASK(5, 4)
> +#define CPI_OPCODE_PHY_CLK_DISABLE		1
> +#define CPI_OPCODE_PHY_CLK_ENABLE		2
> +#define CPI_OPCODE_PHY_CLK_REF_SEL_M		GENMASK(3, 0)

...

>  /* Port hardware description */
>  struct ice_hw {
>  	u8 __iomem *hw_addr;
> --
> 2.39.3


