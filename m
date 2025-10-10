Return-Path: <netdev+bounces-228491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1399FBCC6A7
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93873BA2BD
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 09:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B2C28153D;
	Fri, 10 Oct 2025 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0fKizy0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16191266560
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089453; cv=fail; b=dHN4tD7a36szOSD3JjcBxywq/UHUeOpOXNCDKub0kOUnNkDCaspxgMvacGUCdDmA87iHsjm3mXE0sUuMaFrXGlAdA6NAPcg/TzUWRC7Vn4gUiHsDhvAtqYWEHKTQ155JDOW5EmHOBGcw3aNswljhIg9/EboxK6bquyjLtswr3Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089453; c=relaxed/simple;
	bh=fhYLg3vnSUavU3lPAP3oC2KdzLfmcVpTf/p/KI0A0Zg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YoNewwxHB6oyIY05ISsFbyXDJI4Z2HJhk2xPxsgecm6Bu+CzxO368nYdCRyi0zZI2dGfvkslZg4uiHi2prged4wZYlp4cAUJxitpEm32IDL1Q9XMfVlJ59YezI1EjjhUyqNJx5xpEc2EkUgoyMAQ5miQJIBqvp4q32w1vE1Mt3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0fKizy0; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760089450; x=1791625450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fhYLg3vnSUavU3lPAP3oC2KdzLfmcVpTf/p/KI0A0Zg=;
  b=C0fKizy0jqyq/yeXWUfWImn8AXlMt69FzT/PZ0OrUvkPpbTR8GR5sjIF
   gjOipIsvimvkMeLL9u8ojmCrhoD7PznzQuvdgbHeYm/vkHdanOobC1499
   KH+3dyKYXcqZVJMdNOiniAot1rfkjESVcw3WJQ3KBmEVKo7mhDh8BXbpw
   cuxE3oGwaY7XldYUd1Vau1nmR9qcbdB8EUnVDd83asVxGyNJZ3rbzIWn0
   EdwpSRLMi20J1jcxBwnui6VRn3D0abrv/o/Cqoqk0ScysibSwdK75c4ns
   KHIGfpjVbaqaIQX12B29INx9bTPWyNuMoPcYJ6rivttelY/lMp7WSpbni
   A==;
X-CSE-ConnectionGUID: XXDn8lawS5aP27wKPOQitw==
X-CSE-MsgGUID: fF4Pb8J0Qg+OHHmrWJtuGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="49869573"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="49869573"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 02:44:05 -0700
X-CSE-ConnectionGUID: ZCfyRrj1QkmHAixUxo56vA==
X-CSE-MsgGUID: qz+15SNJTrOXw3OSY+HNzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="180525485"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 02:44:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 02:44:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 02:44:04 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 02:44:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfZkGsW0Zd0w95FI2ctPplEiVBojkTwTiwR7WLI+7C0P6Gyoa//+YY7l1cCDzCarPDKU8s74RSGa9ujw9wtVTd70zHyY1AbnMS65ttMDdkweAsrgCUrQKMO2i372N+aYPlTTKqlcmAjq66tchq0nDwWEpI1xjV4JDLat6sGXPZN5tZQ/qogFxGX9xhHZfV7TMy+MGE/RwGR+K2/g2OFRWdVwCINyGQRY0Sv/1xR29NiMJJcJs9TICohSIUTMA/a4f+G0O6d8Da2ItYInSRMLk9MDC6DaiATBmYy6aiYpch9q7nOrORlCFK+QeaIrDbaGXslYk5zLgvbm8b/KEqH6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WI1946p1vnGOYvicU7XHjaM6J1PpYM0eojLAeyuxK7Q=;
 b=u3ZrmAurHGdUkfoHicfUY+/QBCV7D3laaD1rp/x0ProaUsJ35lUWEvuR2RzG5wqIB4skBO+2f2A6Wawjm+eFej8lbZJYkTq+Ix+SAFVboYq1+mhfqMvW9JY0ptoVeZrBVf2CNtlcAlWFUxvHNaZiR7h0eTB431JXNX4hSCwZjSe/uNqlfl16opAbTivVasEvwz2Q+Tyk98/yVf/YA5S25mof7SDyau6IJkpAmeWc4M79zOLPaZgSmk1IZ5r8eEaNRzFPTKMuZtbYzVwAXAaT5TdWdjUrpz96IJc562XICa7aycs8nmBSSc9UQx2SPJqIPVFM8mc45erqFs0EGgyw9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 09:43:51 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%3]) with mapi id 15.20.9137.018; Fri, 10 Oct 2025
 09:43:51 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Schmidt, Michal"
	<mschmidt@redhat.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
CC: "Nowlin, Dan" <dan.nowlin@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Simon Horman <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 1/5] ice: add flow parsing
 for GTP and new protocol field support
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 1/5] ice: add flow parsing
 for GTP and new protocol field support
Thread-Index: AQHcJkY7PxHja0FjxEOOPxO1layqeLS7SBRg
Date: Fri, 10 Oct 2025 09:43:51 +0000
Message-ID: <IA3PR11MB898536A7DB248030C70389168FEFA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250915133928.3308335-1-aleksandr.loktionov@intel.com>
 <20250915133928.3308335-2-aleksandr.loktionov@intel.com>
In-Reply-To: <20250915133928.3308335-2-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|BL1PR11MB5953:EE_
x-ms-office365-filtering-correlation-id: 62055cbd-69c6-49bb-6015-08de07e18536
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|921020|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?IPH/0I6akktYpbAnXUCMXrjZecQ/wE9dQ7cPuqt/+Pw6BA8EIoNh05MuUUWT?=
 =?us-ascii?Q?pbKw2jYlduXSwe4IODy2rfJJezKsy8f4t0v1DEZYnsERNTbUZVR/3f0YigQ5?=
 =?us-ascii?Q?UPIN3Q9ca7GUB8GPTUt8eKdJr1lwzoO9fqaJBHBRTUUWuKdga1A4Z95f4CfE?=
 =?us-ascii?Q?a1gn48+vWfcZjPOMlhhm5dH8EQ8qQY8vltAaSWxFP0VU9ZuOoKLa4JbDBKlP?=
 =?us-ascii?Q?6VgQv/Nii6h3ni4tc4UXndpqKDmgaRarG6kv2BWjLueY5TyrXHv3jO4TM1lV?=
 =?us-ascii?Q?+bto7JB6iB4F59q2bKtbkBbF7oCrmYELEWLBbJPV2z/bsd2hqiyvKGvO1Id0?=
 =?us-ascii?Q?XNtslhx9mBiiTzjR17g1g0ypKIlxG8vmipOdJ1EPPlgPCMzSjq2pbFnNNcUJ?=
 =?us-ascii?Q?0Q5PeGWYZVWWsSwYyHxraQVYFjy/E1Vp/sJiE3bFd6FWl77nV516BkMjlKJT?=
 =?us-ascii?Q?yedKWHC2NL+V37LIUX0dO2V1wTQmVifQSb7pof314tA4/Y+CDLXWqNTAFJwM?=
 =?us-ascii?Q?luqhrzG+QGmqbnJwzJcd57tj7k35nQPkJWG5mFZNMlFubg2hN0sRPGLsOnYH?=
 =?us-ascii?Q?XrLR1VOZDf9Z6IzTyt+nNZFud3g/zO3YegFaCVdIfGIFs0bXmCDSk2LL233l?=
 =?us-ascii?Q?ekW4naRnkCTumJzgZfg1UivNtoPXNX8zlXEWQ6wWny5vs8lvSnqXz2gzUoFa?=
 =?us-ascii?Q?tql057t6X67btetV7o5eQwfWVN0sjWSzd4nYpvngssQhwhjc+rVIN9UxRqtq?=
 =?us-ascii?Q?6syA87crTI1IMUDzofmlO8HCIEIpWCnHzQ6m2pBK81kb9AJNduIXtfEHAEsC?=
 =?us-ascii?Q?7gSWYeszLGLkArQQTHdv+ZUsItGf3XsT8NZnDyIQaQBpp2tnyvrJ/owy/T+n?=
 =?us-ascii?Q?hRSdlcsf0HVHPHvUB9nXQe/5RqG5/n6yLX/tIR4RUNIW7LcvyuusNfxbgJL0?=
 =?us-ascii?Q?4dZsHC+7iild/sfbxT+5hQemRSmBy7sIC2AUSaOzJ7nViCJja6SrTH5KnoBC?=
 =?us-ascii?Q?al++pc67IxiZ+yP1yl9RfGv1K0eeQBbS3KTuumXFhLYQxXyUhmSDtIdR1/RV?=
 =?us-ascii?Q?OkiSIRU5Od4OHxrYkm5c5rkPB2aJmYbwfavn2QDMOntClKhw3Jp3DzGQIiMU?=
 =?us-ascii?Q?Z4S83wWQNz/WBoD54icIfI7giemiWCIHbgsnIFOh0N6p28crcpoVY6ytadBA?=
 =?us-ascii?Q?5s4dIpywjVXYPg2LO8vQ9iNsnBjGYrZNF7kL7j/LFPMj1LmiJCa3nqnq6ZpO?=
 =?us-ascii?Q?Gj7VL7jaPRw5AiiXLaAACArU4vMoaFNwZNaOqKzuMUw0eJW0N+xVVwh89W6i?=
 =?us-ascii?Q?MWXg34NMMIvdTl8I8Fwz9+NsqZmsO27yBdqJ7J7Kgyl6Sj7aMB0skUKckwNd?=
 =?us-ascii?Q?9Yagtzh2vS5DwCW9OJjQqWGbNTQJwotYXgCHHZ3/S7RACJiXtzfgX3KTgXyB?=
 =?us-ascii?Q?CaB8c0Sy2yBgpOoBpH+4o6S9ExYoryc/laloxxOG+XwRKtbZ6BxwaBb4USc2?=
 =?us-ascii?Q?5gshWf071V07/yB/2nDqDkCOjOSSsWdYbXecIj7bzGQhMzP0DQJNZN02Zw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7AVYu/Rase4Ef/bk7j56jp/VuT5xXjoUn3DB1o6RF2R6gcc4il9QKDc1aC3P?=
 =?us-ascii?Q?kAnZrSb0umoXPc/n3yjj7o2DBUuxBDbAzyzHpfGwH5iqANOZkCDyfhwEHEAT?=
 =?us-ascii?Q?KbnlfzptJUN448yt3DaSgRgL9LwIOA5+jtQsOtVTeiDAiQHXwv/WEOVur/7I?=
 =?us-ascii?Q?uoh3YWTHU3rIOMYI/XC+iNw0Ud5gh5T8PfQhQ6pBFo7ZhjK43vJtztZrG6lk?=
 =?us-ascii?Q?rlbbS4Q6V8pv2jB6fyb94gkCygxv4vkc7czRZaPrbw/uV3FvpBa+fTW5kvjs?=
 =?us-ascii?Q?TpOp750GXVVt8pevtgIWzqlhwOPMR9MUU72AOuRGBYN/PGj2jes0dQaU7wuL?=
 =?us-ascii?Q?kmX6agIzV0BJuNGxbV3V225FqSWqH2PCGGrf1ETwe7QHqdmPZWJcHnb2Rtwq?=
 =?us-ascii?Q?+ZLPFqKQqs+FYuaG/pbS1msygKc3uYvIlteTB9bHTNc1w3AV9lxxydtMm69D?=
 =?us-ascii?Q?gKJmml/W+opoa4NtXn/kJVEdjRatAL2ULWYfibGMThstncKqncP4TBxtrVy8?=
 =?us-ascii?Q?hSPny80z+B+7fZ4U58ez8VrQA98aFrKkhHA0FRbV7IFayaUV/lEK+3VxypHA?=
 =?us-ascii?Q?jLdSaYm+gYZApWPVsXiZSrd96IUIs6h0Qy/68Ycu2HqNhhttlRkrBT0iKJzV?=
 =?us-ascii?Q?shXHJWRo583++nOZXsUC+dI5Bnbvh7KX9ucCqN+2JYHYZ4IzOhrYYfUrQwCf?=
 =?us-ascii?Q?OzXQ+iCdQPFM7ZgtsGpn2jWxnlaF4gy8Gcv8vcnRpive/16W8677MCPtBVJB?=
 =?us-ascii?Q?kHQ1sdp8BBPBcsPrKuA1c99E97X01K77sZb+wVHF4zcRmr4nRrul34IUxit9?=
 =?us-ascii?Q?W0OeZnQkJg3whqRIwvolMhHOYQxDYe5+PPew5yM4NqsY/6uMi+2dYXekmcgK?=
 =?us-ascii?Q?vOR3EDgYoCd9Tqz3lEcN079q9oDy3bdF9/rj40uwnd2sF2HyD1GdnmPaRo8V?=
 =?us-ascii?Q?dOgmPjMoQD+kE9JL5c0EcFFbS9VT4OGBgTn9ysOIGyjhpSycdZw1uxVt1kxB?=
 =?us-ascii?Q?wqExpNuIkKPHJ6X3OeNOlP8Kty50TRcsgbH5jSWTed+SjOVCV0xG5rpSk/09?=
 =?us-ascii?Q?51QH3JIftsS1VldPhGkGcM1BSAr6hnFM7bXknQBBEVFDIg9XHggm+UpjkpIA?=
 =?us-ascii?Q?8DMtAlYzekG+2BuobWSX5ImzZbDAnj2qw9kqQWlZS4X4gKCGVcRWSLtVrw2N?=
 =?us-ascii?Q?G4V1BjWrOauA2816i/EOXjvrlvR75niNj6NtJ8xkcBXc+54mFBQH18mKVIfO?=
 =?us-ascii?Q?ZdNlotLr+s4kG1/mBdI35GPtN9c3MXFWr9vi3GoWgabN9LSAE3OCtdO9rMM9?=
 =?us-ascii?Q?F8b6fG/BgtRfQmbxihFX6uZBUH5FydQSzqoV7cOFNvUYLRgjJIjpDcAV/ST4?=
 =?us-ascii?Q?NU6slh/q3Obm79KdTY1I9SqJGFnvqPjpS0xEgBDtmBMNjB5Xg+rA2VYK8WS4?=
 =?us-ascii?Q?7I0qq/YpsVTNVQpUPK1sD84rmrnB2cZ+8aKOkkjhTtqR83ycTwkaj+Y3xtv0?=
 =?us-ascii?Q?W6siKJ4JiGbeD6QiKVoJ/2S66FJbHv8CoivW9eAW5Qz78bger3q8tF6V06Yx?=
 =?us-ascii?Q?pmYM9iwf2VUzM/AeWPLUUXHHukOnYhMLYSpRVggF0sWSJZPQrx5HPLql9zTh?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62055cbd-69c6-49bb-6015-08de07e18536
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 09:43:51.6844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsI5FDOmoaHWYqD0KlXVtrUHCyUIdFd0V62cXYtb7yJ0nFfI7Btdz2z0AQwZqx5Y5K6Ob/OqTORMdRH4a1RCW6eqLAuIcruJWpy3/RoJP00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Aleksandr Loktionov
> Sent: Monday, September 15, 2025 3:39 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Schmidt, Mi=
chal
> <mschmidt@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Cc: Nowlin, Dan <dan.nowlin@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Simon Horman <horms@kernel.org>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 1/5] ice: add flow parsing =
for
> GTP and new protocol field support
>=20
> Introduce new protocol header types and field sizes to support GTPU, GTPC
> tunneling protocols.
>=20
>  - Add field size macros for GTP TEID, QFI, and other headers
>  - Extend ice_flow_field_info and enum definitions
>  - Update hash macros for new protocols
>  - Add support for IPv6 prefix matching and fragment headers
>=20
> This patch lays the groundwork for enhanced RSS and flow classification
> capabilities.
>=20
> Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Co-developed-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ting Xu <ting.xu@intel.com>
> Signed-off-by: Ting Xu <ting.xu@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 218 +++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_flow.h     |  94 +++++++-
>  .../ethernet/intel/ice/ice_protocol_type.h    |  20 ++
>  3 files changed, 323 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c
> b/drivers/net/ethernet/intel/ice/ice_flow.c
> index 6d5c939..4513f1d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



