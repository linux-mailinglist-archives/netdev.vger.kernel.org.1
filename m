Return-Path: <netdev+bounces-187786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C01BAA9A23
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7DD16DDBC
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B19126B2C3;
	Mon,  5 May 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IriF0w/8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556D26B090
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464899; cv=fail; b=uM/SnDuZ2i9bMgpHR6RND7tggIkzcucjBRmhnI98CQjbULwWC9ZzwYXUbA6cjT/qE/qkG088lteiZtf4k4i5XIf6QNY8KmBTbd+c/TV7o7nhSWSMV4JkllMhCLnAZOCifriJIQOtaziAvjb4Cd0iwcD2eldfkJO2FnGoeqhF0v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464899; c=relaxed/simple;
	bh=q0d5yFZCz1F67oIuZJgS4JNzEMi8pVTiAYhlaMk90p4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HSXkSi+H0ySES5aSS4Aip3nw68Xkb1eg3vIfYf9QTD7Z8p+9KYIe0YMkANw1yXUzFcquXoeqNV2VqdkJj+gON7WhwyQvdzI4+y19I4vdMC6U0RNuMsqTvcg2v+ldvJP4NrBNCTse83Q9JlKU33DWpLNol++qvW396l0XPWIqABg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IriF0w/8; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746464898; x=1778000898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q0d5yFZCz1F67oIuZJgS4JNzEMi8pVTiAYhlaMk90p4=;
  b=IriF0w/84rJFAlC/grpUZAAwKVNYnYQ38MsGUvQ9qSC6CHdAPtz9zxXn
   Q6xaOrVWM8xoWCs0Uop3WSArzngD8GsJTDdQ52gwGwiKYxzt7aDSsPmQc
   eq9vuTxExN1uSFJYJqi10fGvSIBeE2AsrfyZ5YTXVy8un7q4jOYswZXBh
   JvdAAvG5GzMZmiXgwvTqu1BCzayfFIUtgZFZcMlJEGpC+mYkEIoKmeYKX
   krad2C3n1oqiTcwhhRTPd/fV9MVhTGzfhznt8lpaJ6ItI1VQDkx7OEy5a
   u9YkfbIDggeS33ZMshkEHh3wBl6wMihrjREE+/42krAiUZR1gDraKh0/b
   A==;
X-CSE-ConnectionGUID: JMJsbpbRQN+20Ywq01KA8A==
X-CSE-MsgGUID: nY2AzfQyRoePLbCqd6c7VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="48098837"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="48098837"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:08:17 -0700
X-CSE-ConnectionGUID: om25RlznT62DowcdeDfaWA==
X-CSE-MsgGUID: AUgIivK+SKORP4e7mZt4Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="158534055"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:08:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 10:08:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 5 May 2025 10:08:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 5 May 2025 10:08:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckztIKFrx6nZEIFVcMwphhZXpk/YJurst6OTZBWSVqMWfus2P3+ciD4KKdd0GYEELMoW4MI3yyfitraGt03EjT9PhGeqTUHMiHjD+RarEJQEnMhHAhLFaX49sV7uSh8DUVvpSebqMQCVeCZZ4lvUvfnrOkiK7fq0uClZ9N+QcTeFe4gY0b6CItnx3bgjF+RqWw5HEbLMCWDBpV+42KhKthshfTSRAq1LgCJ81mvf5uGQmObRrJkiVpNjyyx71clL8U0tN9CE+F7SUqpBY0F8yb6P+ia9osKtVPQzzOpWCfdcP/oEbdEvynJD/V55cHh097iIxImLIKrRshQfpadxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW0YN+drcbckE4YL/4FpaxSaBKRQZj6HJiJoMX7m4TA=;
 b=Qy6bbOPblDUqEjFFkgvnX4i9egDSk0Wi4E/jSFFx4xcZ+gGWGkxiMdmb32N/ANCtJU6X7bS2zqJPEfXu+oW3Gb/J2SrPupLxRt9m5TIyhqV1o5pKZfKLvYuwiGjCY/cfu7H2uCFZ2fYV1LExyAt6WkOcXf0iHPmdsYX2jT82OFeWVbPrhT2xds3x8dZjU2R0aZeDLCIuHktSPu7GK0SCcTp7gftXZnT7GuNtjTmLYQ5t09JDHpa4i1NNAnnTfheF41ucvwCK1ANox8SlZ8egrRZIYQfe/Pd2YkZTJcujmFRRj9P9d0QgSRk4mbyQgATzYzbD/1gwsHnApJoEJ6Bysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10)
 by SA2PR11MB5083.namprd11.prod.outlook.com (2603:10b6:806:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Mon, 5 May
 2025 17:08:12 +0000
Received: from MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073]) by MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073%4]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 17:08:12 +0000
From: "Olech, Milena" <milena.olech@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "Hay, Joshua A"
	<joshua.a.hay@intel.com>, "Salin, Samuel" <samuel.salin@intel.com>
Subject: RE: [PATCH net-next v2 10/11] idpf: add Tx timestamp flows
Thread-Topic: [PATCH net-next v2 10/11] idpf: add Tx timestamp flows
Thread-Index: AQHbtixhwuG9UDECekKsTf1pW6jrCbO50NSAgAqDAuA=
Date: Mon, 5 May 2025 17:08:12 +0000
Message-ID: <MW4PR11MB5889D9FF1A6F7D10091C6ADB8E8E2@MW4PR11MB5889.namprd11.prod.outlook.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
	<20250425215227.3170837-11-anthony.l.nguyen@intel.com>
 <20250428173521.1af2cc52@kernel.org>
In-Reply-To: <20250428173521.1af2cc52@kernel.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5889:EE_|SA2PR11MB5083:EE_
x-ms-office365-filtering-correlation-id: 1c62caaf-d6bc-4995-3229-08dd8bf76ad9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TyB/60Vum6mRG2PeBCACjlRtrIqsgaNKDFHUIkU2YCSdhDyhFi+bO//hUUrt?=
 =?us-ascii?Q?qdRu7whyiakthZKvX/HuxeYkh83KcNPqn1tgltfZUZjt4mQIfxF1fD7DHnbJ?=
 =?us-ascii?Q?CvXhOPcPPe7iDAIWdSe4mdzBOXrHilsarDikyMPwKwt6hfTjeJ9aV+GzU90V?=
 =?us-ascii?Q?q+31qfhuHbmzvyv0StAUsG0CyxRRnQGjTedG787cmrWvsPvEiurqDZt/60gv?=
 =?us-ascii?Q?dc/WyiFKRykT5lLEr+df/oxrONWXT4Qntmupjj0TRdeGfOn9zADwXvx5MMOS?=
 =?us-ascii?Q?IZd103NUjc0r/QF/pMwG+3xjm+NzqCo0I61rlQptM94kLFT7PYIXx2BZT2HI?=
 =?us-ascii?Q?HiUsqvb0D4B+JCa7xPaPiLmfRd2yagtYZPCeo+xu+mRH+87ih+OezUO9z4Nu?=
 =?us-ascii?Q?gxoaWJ1JF7saanXvWLjZvXpfHC9nEfKMoZRaOC+fwvJCLDg1TzFMBzpRDjdf?=
 =?us-ascii?Q?7I1kj1+zLBH98NqTV7wcj5wRx2u7M+KsF/aJxDvIs5R7SPgUgeWhQFSyW0/q?=
 =?us-ascii?Q?MzTqyvO/NHoQrh6N3MhXeM4cCKhvW7kh8uueMnEW3WpiNxmucKto/q0Fvq68?=
 =?us-ascii?Q?of5NjZelK9oydK0Lj5rnzZXKqPFQ8a4nGymbO/PsZ4o7jdI/I0xbKg3KsYUu?=
 =?us-ascii?Q?89nYSBU8zcEVNBOS7NBvuBIAgZtHuiROMAvIHub1XgUQ4BnnfDHPwzi931TU?=
 =?us-ascii?Q?isMlTHUvIWj+jhhIeutqlOfZOuuzMMt4zuAhpjWa46hqXQa15s6NxVoBx7IP?=
 =?us-ascii?Q?upbDlwJRGYrZIi/DrtHdZ/ze1VgcdX/UuIr2jFU4nMTaEKi9uJ/6BRi0m/zl?=
 =?us-ascii?Q?sEboG+YQu84JgYkpSSwVFoibLS/GMWLGQ4FQNopmEdCnlZ4/DRDlpXZ2nvtP?=
 =?us-ascii?Q?T40DTLn3X+Od5oP2z7nX2t6eVRaz4NIRGK5GPgMoluOiDxj3V/jHCqzzb0Lf?=
 =?us-ascii?Q?O4v8n49dobtMJo/MYXV/U/PXoV3jFw8z4cpTPrBmKRC2HO1ItsUW5p2EEWxe?=
 =?us-ascii?Q?PW3YExxY54HosM6rdhMGoY2FaQ2RN9CG9jyxUBm42bgNB7bofVIuyJzAIPFz?=
 =?us-ascii?Q?qPHK6iutGmgXd0J1rD1WxokHjKlZW5QiAiDBm6LlhI/6SF2vaGQULk7kiV/j?=
 =?us-ascii?Q?f6LrByJdAB38vY2oSX5wpwLnS1GQckINjH0Nx8FFnpwg+zQi+FMNLa8LulSW?=
 =?us-ascii?Q?7wGDBnAT7RGcCSicRthwL6jFDPbqdUL1W3rtthKg9jRQCfwK6eoi+o8FWvdB?=
 =?us-ascii?Q?KjAKUvC31t+yJgAm/UoD1JSFCM6tajwcnf2xLdaV700Xefnh5PZ3QS7Cd3H1?=
 =?us-ascii?Q?69ttNuHeib6YULyLJ9Q0R/QFvA7Lo49ywt6HAfSVYuo8IYh5Zl32kuocPTgz?=
 =?us-ascii?Q?w3RXLb82RZU7bvNfbBt3jFL/bVcRkembDlldJZCB/QmQQDmJ9H+ynQoURPPD?=
 =?us-ascii?Q?K6+n0DxMx/bzfsz+OCgXr9pZnwSbIYrhacv0kIjCVlVtu3GqFMqrBw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5889.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BaChu+j+KqFq7xBibB47ul/2TKZhLjMp6SyiH8K3qHkzA47hz/SiQ61kvosU?=
 =?us-ascii?Q?BeOIuZpaVlp6Q4vORRVZWZd8XBpSOla1wsaEeEdJGH6I2LO2BHxLQ4Q1GIr4?=
 =?us-ascii?Q?DfkFrCab7QuPzVUoKr9K6e/JtiGYoW6ruB6pT+GH33gVCDe5mAiN73KiRsHA?=
 =?us-ascii?Q?UgIaBUmlRBCErhCsET+2FEDI9Rdr6Tj/Ww/P8RfsbnykcaUWgS+Tt5P4Y3iU?=
 =?us-ascii?Q?cjoJxGlfaoRKU4hYRZzmteEcuHpyMAOvGxEw6lIEAqaeFRKxj1DcA4HFPh6b?=
 =?us-ascii?Q?er6qWtI5cu2cvOBh6FAVFuPCZtB/DgspcVVD4OGuIUvJrvpQnhByr6Bu115w?=
 =?us-ascii?Q?KxPrpFcEJ5l8oMng6o2X8AehDDGn0V5BjbNk/yQoGEH4wS7P5aqN3DBgS/Wb?=
 =?us-ascii?Q?E/josJAtUA0hb+S9SaXX+m6oNfoyM8ejhLkMD/cwuIjVcFku+VGdmYUS0q48?=
 =?us-ascii?Q?dSHyLJrwv1V9jV25YBivy41ZnWu73Tmfdy9tCjd6W3YBaQpBD5MVYlevqVV5?=
 =?us-ascii?Q?A3Bf+WKt2jOXeM+35oFKvrDdNDVOVeN0VYRWevoDzFg3FZSftDAgLGqNOH6e?=
 =?us-ascii?Q?+u61ZlU01Lw6OSbAqcA1t91Tc/L9IFSnP+Zd/r0mmiaJYRqBNt84KvJhqLlM?=
 =?us-ascii?Q?N7xxdy47vGCtWGUasFy5Qa/BxSpD4RA0pFeWk1GFjhtbf8ZYWWybfAiTECm9?=
 =?us-ascii?Q?otFglIRH4HH/t+WNNSg6XqhHBHnkr9b9HTMLkT2Luzh0o9N+nZ0/sLQSyEkH?=
 =?us-ascii?Q?juU6Ito2ceHJWx+xm6CVHgHqKheBFnXTYeJej+am/E7f+BULFQz+vB9uBDvH?=
 =?us-ascii?Q?5uEAIV6AFOyTCDqjewb4l4QAkvyUCVsTw2bNabn7bGjUr90FX7pm9ZDyH7vL?=
 =?us-ascii?Q?3gRKpdFpOpWcQtkMV/zZSywX38vxF/0OOU/DKak7uLtANsJMxpddUyJ2mJfP?=
 =?us-ascii?Q?cpaaobe7wK91PIADwiV2Uw2akbOqvSjN4sCz9CVm/r0cBTGQIUxM6gWwfylG?=
 =?us-ascii?Q?PTQec5O1N5cs4Hyf6ARSeJt5lkmcCKuEUpY+TTUN0TLHq31KC4q8Q4Vxz2ns?=
 =?us-ascii?Q?4SVAaLWVLQPeoNWng0Zs+wypROy/IZ+wva0Q0+l9H1MLvojCq8M60Coj7PNb?=
 =?us-ascii?Q?feOssw4zjG9CN+YiWWtkg+j1KMESgUyEOYN2x4pPf/u0Nw+JP7H1vSX6Gk6u?=
 =?us-ascii?Q?CFuiiMXIUkncuwcPwy0YkNCybxYEAlL527T9medLarg/cz2ksnyOK3xsZk+v?=
 =?us-ascii?Q?7p+eH8IQGGdv5ldIBPWJXaf78g/qZncK063GhItchRbM+bJn2prjFlcs91W9?=
 =?us-ascii?Q?MKGflfvVGt1CRtVPvI3rFfKRmA3RqVVOeEHjymSIjhaue2KsjR6jtFhmr/mh?=
 =?us-ascii?Q?fbvB88AHHdHt8eif7d4A/9EUaQrLP+00LX9tFG/5Iw0zMuJzc0Emghc8PB8t?=
 =?us-ascii?Q?jfpI0tmc5jP2EZ4J6f8LUfn4tgQ9wBAJdKSHGrpmAkz4qDmNGv+psKxVca+7?=
 =?us-ascii?Q?lVBKt4nHLoZwZmOUpXvZtaeEmAyMQbFm2jRj7nIvBAtvJQrB2kVprkQQu1Ub?=
 =?us-ascii?Q?9W8jCyWOvkUpOb/guiz+f6TT0eZAJZoPgCA2TeGc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5889.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c62caaf-d6bc-4995-3229-08dd8bf76ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 17:08:12.1928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PejJVwPaZP7T975VlrCpoqTnjLW+3jyaNEck9/a3ndvY3Aug4ixqgbeNdzDxmrAqKVEo8Lgt92aWW1FWYP1rfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5083
X-OriginatorOrg: intel.com

On 04/29/2025 2:35 AM, Jakub Kicinski wrote:

>On Fri, 25 Apr 2025 14:52:24 -0700 Tony Nguyen wrote:
>> +int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport)
>> +{
>> +	struct virtchnl2_ptp_get_vport_tx_tstamp_latches *send_tx_tstamp_msg;
>> +	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
>> +	struct idpf_vc_xn_params xn_params =3D {
>> +		.vc_op =3D VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP,
>> +		.timeout_ms =3D IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
>> +		.async =3D true,
>> +		.async_handler =3D idpf_ptp_get_tx_tstamp_async_handler,
>> +	};
>> +	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp;
>> +	int reply_sz, size, msg_size;
>> +	struct list_head *head;
>> +	bool state_upd;
>> +	u16 id =3D 0;
>> +
>> +	tx_tstamp_caps =3D vport->tx_tstamp_caps;
>> +	head =3D &tx_tstamp_caps->latches_in_use;
>> +
>> +	size =3D struct_size(send_tx_tstamp_msg, tstamp_latches,
>> +			   tx_tstamp_caps->num_entries);
>> +	send_tx_tstamp_msg =3D kzalloc(size, GFP_KERNEL);
>> +	if (!send_tx_tstamp_msg)
>> +		return -ENOMEM;
>> +
>> +	spin_lock(&tx_tstamp_caps->latches_lock);
>
>Looks like this function is called from a work but it takes=20
>the latches_lock in non-BH mode? Elsewhere the lock is taken
>in BH mode. Not sure what the context for the async handler is.

First of all, sorry for delayed response - national holiday in
Poland :)

Actually, lock is taken in BH mode in idpf_ptp_request_ts function,
non-BH mode in virtchnl commands - get_tx_tstamp and async handler.

I see your point, and I've had a long discussion with Olek Lobakin -
we tried to prevent all possible deadlocks, and the conclusion was
that adding lock_bh in BH may be considered as overhead.

BUT maybe I'm missing something - do you see any scenario where
the flow may break?

Thanks,
Milena

