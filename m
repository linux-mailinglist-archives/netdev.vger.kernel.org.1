Return-Path: <netdev+bounces-197113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B2AAD7858
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25441885A9F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838451DF751;
	Thu, 12 Jun 2025 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXGlcoiQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0817AE1D
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746147; cv=fail; b=bJIzaJjBhLHySaPeP8B4k2Z9znHqzY9UypWYTGlV7msudZwWFyVWW4JkXB/NYkl1wiUM2GnhvEQrdOcdhQFXTr9n6g6gMma4Y7zXbSyQmDJr6oKlrM/O3JRD0x0R4k6/Hg2qmTzRj5kja7j67SXkhnJiC4ZiEQZYCEUN2p0h21o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746147; c=relaxed/simple;
	bh=u5Q/Xxe9EDys6y0iEkZdB1S0lWNu+lYKTstWghSj9R0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cimJpxUg3AY2GvJvsyTbpDmfX+JivALtqakxHWvo9JqtzwwBuNAy1gWJewm0uRfYXKrkHQuE8s/qbDPbIVKCSpAMMK8NEA80K6cSTPw+EB7iEITJpewrpL+62X63onA3ylnuPwvPTdaCcq1llAKNtgYwwYYwDt/WpMrHEApwUbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXGlcoiQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749746146; x=1781282146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u5Q/Xxe9EDys6y0iEkZdB1S0lWNu+lYKTstWghSj9R0=;
  b=YXGlcoiQytp1HMHUv6i+N1X1wFNiss+/PRj94UoqPuOAYIQAY1u44OZE
   Jk5nJwgCPS/S07pCPOyu0Uq8lXOuQC9nw9B1DbARh0IcVEleXzWOtZWf8
   owIDOk+zk7Vx94mf/fXE13DuFBKDDs+0eLkzzecK5yWczfVATVqhLAcPa
   g6qXsTSw73iCvmvwDyFNzs/DimdwLJl/zGPl/mtUa3aGpA8eerfl+0KKx
   hfzEZEv6+RYVUgWPVTb4mYZvmXbH7o++DbUJ1sX93UsBhQMeOzEj/rKBr
   Go1SMPt8BrWD8bHrzpZM5rOcxyeEq22y2J2P9SB4dSu1NHNZl9KVAXosH
   A==;
X-CSE-ConnectionGUID: iGOhpspHStOP9QnL8fhgAg==
X-CSE-MsgGUID: T3WEaWdURkqKuV659trv2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="74470129"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="74470129"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:35:43 -0700
X-CSE-ConnectionGUID: AzrN09UuR4iWXzbRGEAHMw==
X-CSE-MsgGUID: Uzc3tRodTlmSKb8Inf7A0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="152562569"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:35:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 09:35:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 09:35:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.77) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 09:35:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7cJosZrD/evp41HRkYVNzcRojJ0JQVh+PGTX31XcLPWmFx/8hKncTnEKAzvpfRJqJDXo6GKIZPRQRO4ChH1briio7UGo6dGjATPNlbOmw4fg8vBYIqdaE/448CPBJaDvXPjoU82qiySrN85O52Fh8gFnsu+mQC+YYPi/y/J3WRbcEz4xtYxcs/i6sDRpQsmRHX3H8uecxctbABaXud1c64NbYlq6GH+WaSqnLnIAinqo1AtaiWawDSv1hD+ZAVwty5HQkYRJ1sAzOdEcPpowEMseGb7JwL0WTTyJKlmhqmF26+VAYUEY9wbBZv7MTS0ObJnA+0deUC3i1sHD+UPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1EEnRkkqEmyFSeqieuMvi/q/x+3kzkXFsPU/Sf1uTw=;
 b=go+MwbFItxDe/d9I7VdDTcOm631gTUj/2ENBGTQXus85STNxZ037XryubqlIAm4PeczKi3MEpIWDgWOuwXnJEfiO5TrAqCrtMw02dGLtPM+zYt9F7fUFCUBdULZLashB7dpZODN4d55KEnzcpeNCYNLMOZjSLdlDdC5ushJFfWm+wC9UNUuko7pgjgJYgFoTDtN9rWTIa9IColofJBUf5BKA0cjwhww11v9X+ZWR9UXxEjpLIzGnwhdOOEvGxlIu0iuQ5qnmRZ+u7xVbIrXwmvAWQNbBE9fMLgYqU9XATtxPrkf5S96JHDezPvQBPFKp+dMWm6CB0xUXqUOONyA6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS7PR11MB7805.namprd11.prod.outlook.com (2603:10b6:8:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Thu, 12 Jun
 2025 16:35:37 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%7]) with mapi id 15.20.8769.022; Thu, 12 Jun 2025
 16:35:37 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <enjuk@amazon.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kohei Enju <kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1] igbvf: remove unused
 interrupt counter fields from struct igbvf_adapter
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1] igbvf: remove unused
 interrupt counter fields from struct igbvf_adapter
Thread-Index: AQHb27Uxyz+d06kHuEeX8oTsZpFK7bP/uIEA
Date: Thu, 12 Jun 2025 16:35:37 +0000
Message-ID: <IA3PR11MB8986E1AC705BCC56FF5D6273E574A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250612161343.66065-2-enjuk@amazon.com>
In-Reply-To: <20250612161343.66065-2-enjuk@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS7PR11MB7805:EE_
x-ms-office365-filtering-correlation-id: 46dbf920-4150-4944-2a77-08dda9cf2984
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nm38gpRu9+G25m6D4NJQ0zDHWYPILrpcHeWtU7OnfQs8SzGMo/JquswMIeIp?=
 =?us-ascii?Q?tosA/UvT/dvmVJ14HqVWLNBsNAmn/kLMhLYuPa2TXscFp21u6Uza9XHODv4d?=
 =?us-ascii?Q?llyH17PBL3HrWwhJC6VykhRIcAlHRHNarchE3nC3UP7eGGHuyJmc5/SQLUb1?=
 =?us-ascii?Q?JXnsEyhBCIrAHDsNfrgzbup9c4xDWCl3hnYzLbiYDRI/yQLDnupZimVUqNXE?=
 =?us-ascii?Q?2EdNQOQe1Tuydlv9xB+qMHKtWa0upY3sqdGLNpOoz5KL2QYTUhhnRR4a2ged?=
 =?us-ascii?Q?7HJkpVB7BlD8H1uvPkn9MiJRMHzba4SyVi9/+2kldEXQbkr4BrWmbLgW6qpI?=
 =?us-ascii?Q?9amEZ86Kl3yjF/uSqxbWjoz8jICORE36bYbTc0+Ne+MFc1wGCftN6nmQ3eiv?=
 =?us-ascii?Q?ZEMFwd73pQ2B/tytcb3KTmZ7kj8UnM9wIRn6NBjLQ648qbrl3zCvGK6/CUq9?=
 =?us-ascii?Q?IDODHthJVjhNobk92jd57k7Jwhaljju2Sz2aGIiijmdTmaH1oN55UKwPZ1ua?=
 =?us-ascii?Q?y35BopTiyMO6Io+m9jRaaRGi9pXy1VThLZJLZM60qZxIvM7LhzQo2Vdm+pC8?=
 =?us-ascii?Q?fc9fHG+Ef8wBMj6fRCohZPSm/XUpjd+reaCnybC/W0SySZXjWS+GD7lwHa4Q?=
 =?us-ascii?Q?3GBmvizI6qNloxhE82vp5sxtgzU+Bqadr2cZOJbEpRQZI0uJsxDNSBD3Q+wF?=
 =?us-ascii?Q?jWTVr1M4mGu/E4rl9Xqb7tk5RoUcGSDlkBtGgC2/6cDfg1pB5HtE5bf0Ggc0?=
 =?us-ascii?Q?52ItnGXFpgFMkxNRmvKD0CNhk8C5+gt9EuWi5EnLkMbE8ckw7xqNyvS59gMn?=
 =?us-ascii?Q?XjdWUJmeUkMJPKrJPm+olmOVxcd0i1qg4i7qHTLxStzNpjZUKD3eUEWtHNxx?=
 =?us-ascii?Q?LGS+oKsiWmd94+PpCErN0h8gNWk3cIEF3KJKsrDWL/OU8koSNdOpTL/T0y0K?=
 =?us-ascii?Q?hw1Uw4sXIduhl8JNtkofd8SdRCVxCUDIVBMqCEt6FVIbUYJXDl14eAPzuRMA?=
 =?us-ascii?Q?k+DCquKIWdG++ypoODuUID54+TiClZLm0d678iCVXS/yqrTqA8ykK6toXFsE?=
 =?us-ascii?Q?tDZGi9czBna0CPin2H6WP7W3sAPvoPlvCjbKHhORkIJ85UidQ/gcIeMQfnG9?=
 =?us-ascii?Q?31YQF8SoP8amS0dQIfFLYgGlKvdI0zDA4xL7HPwmSW0RTuQc4nxMtjxUPrf7?=
 =?us-ascii?Q?5mBEimf8BHSJNXQFC58U5Zn0EU8zscatW/HFs9FVuSw5y1nvU47/mEnAUlHE?=
 =?us-ascii?Q?V2ik9YR9AB0nhjspOCDl6eQz2fE5MXU8uxk/4ihEl/Gj/P3GQSkqxyCzlyat?=
 =?us-ascii?Q?wr0THm33ClVfhon7D2zKuNXJJcts8tfiKac8gR+VnbOGchhyOnioxWEd1yhw?=
 =?us-ascii?Q?7EtgkevuRhjeso2SKNJ+c6QhUhjp3GIRWiBLAG05YZ3fHr6i2dmLfsg68ZFG?=
 =?us-ascii?Q?QnHQiSMIesi/2TcjP85ykYkNHowUCKEMeD0ZM9XuiSBXOTipkQRooA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aRu8rFTXaVLGoUmGZMeTAokXJsLuycLMtf1uB7kfClxln4Tfy8UrR+Cjco5z?=
 =?us-ascii?Q?jVYx9WJjrOqKv7ZylO2U1t2436dwmSD8gl3/+pu4u3yVxntlziE7evpyy8cy?=
 =?us-ascii?Q?C+Wewef4B7rdHJahf0SXT2ozVVOW7TFbMObCIQFgGlQm/trapAwdRrU495Rm?=
 =?us-ascii?Q?AkcS75aeJCyZcwBgfeN8ZI+nWEQob5z2oGbD8nUtBt1ZIKzxgpx9V7bMhGFF?=
 =?us-ascii?Q?lFbgF6FAfQh2FoIod/RwmWZWdHOrr3pxQuJl5Phrl8JaZ+aLeqTuMFl1Jirf?=
 =?us-ascii?Q?RGA/7zoQKhD0exuQtBCx9+7thRl1Js5J6RhhApmrqzZdS6bWnyfzSxqJeEk0?=
 =?us-ascii?Q?oPkbKqiNNjEPfOnsiEXTv8XHQeoWfaqdwUK9eJD+h0H4aRoe2HkrgP7QYawa?=
 =?us-ascii?Q?y1CvuhaZwV+pMuYycunjjThbK53y4J4aUGrtGgmxFuYGg/F1Ig3pduYbRbZz?=
 =?us-ascii?Q?hwup9l9P03GuQNiOlXTqQ7Dlld81mUq905tPic2lEfxP+nAaW7nXdQ/OpL2O?=
 =?us-ascii?Q?sh3Xgy4pympCUltMsrrVAMgT68wg9Dg0tdDx0OtbQmXTAqqowV4mREW2si39?=
 =?us-ascii?Q?5pvPJ6nTTnZm5GL+KpjZj+jBQs5MBjnIzO3S6+4G4+rRPheHlfUY/G7VI6rX?=
 =?us-ascii?Q?VdKNu5ln/gxYWiAHRZyC5rvoQeXTkKYCJ6jQ7v00mZZspH1p8seM0kxQa1b8?=
 =?us-ascii?Q?e5g+7rJDEWZdjbvMoKlGz/9kzItRE8V8cv1tifyB3iKUSl3KLKktepR4IN2E?=
 =?us-ascii?Q?R2qXMCCsKxeVb/2YMJYH3VRURRS/AB4wfSRfJIaiBV7X0we8nEoBuEjq2Sd2?=
 =?us-ascii?Q?rtX1B4IbAsNqdJv87isAMKl+SeH00qlKIthT68yW2Deaq49tAI8WPVDSXIZJ?=
 =?us-ascii?Q?jQpvdJAJ0M+GbPkeNSHUY5qlpt+J8UmFiQsj3Bcgc+oYObucC/LD/jrB4mGy?=
 =?us-ascii?Q?Tsp/9cJ5INpdTrzYM3tkpX6j28aNfdrx6li+zxUf6ez1bwjm+0fjk1mPi+BW?=
 =?us-ascii?Q?0GiRuPHEE299y2/WDbPrWcRhJg+ooOcgigKsSkfxQR6TtYXeYFqCQDbd3YCl?=
 =?us-ascii?Q?of8GRnFA1sWlfP3Vw9bE8wPAwgTVh49i0Z/pLUi5eiPxR3SburmLdPZFQ8GZ?=
 =?us-ascii?Q?Snuix1iA8CqqRkVt/KEhcj2tnVzFXFoNnhF5rs3daN+5YXa79Zum4XiD5H+5?=
 =?us-ascii?Q?tntmVBvh8DTMSNJYu8xHQOGQZXmAflKGu4arsPjwFuICoT2UbOnlLNqXbpqM?=
 =?us-ascii?Q?p5W23LdngfZzUbPBg65NHy3cLbqkPROyqwCvYt3XwXlNKsfMg6o3cMPlvLSp?=
 =?us-ascii?Q?EJdNhk5svNjGiZdP0/LYvGgBrkFsOhtRP5dUOffdyATMso7ABNdDReOzeNZb?=
 =?us-ascii?Q?jOomlOWeSQEQHX+/5S/fmbEt50NKt5cIfd1BmukrswU28AqtUTbCa8k1kAt3?=
 =?us-ascii?Q?XcS2JficIlxaUFIvjdBGxnVK2rxJt9wU4DiByGTbFnFf3uJJjygwMdZ5acN8?=
 =?us-ascii?Q?Dvcn2/M1naHZlx1kxoj4/kvbpGk6w/krHSzQv5G1cCfseVcJFRp7TeN956N4?=
 =?us-ascii?Q?5OnP7c7NgbEByx7AF4E2krhE8ba8aSFe9v7b9aSD/ByERwo+Tp0FOlonuvZg?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dbf920-4150-4944-2a77-08dda9cf2984
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 16:35:37.5711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+xEuccwYP1268WMiTCsTweNQrjG4ldgaY1vTf9XVLe4T+bNcDQ6o86uQZGwuJ4MNpVLLnNecV0HpXXcLIv6x+59F2bKck0uLoGwgQ+QDmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7805
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Kohei Enju
> Sent: Thursday, June 12, 2025 6:14 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Andrew
> Lunn <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>;
> Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>; Kohei Enju <kohei.enju@gmail.com>;
> Kohei Enju <enjuk@amazon.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1] igbvf: remove unused
> interrupt counter fields from struct igbvf_adapter
>=20
> Remove `int_counter0` and `int_counter1` from struct igbvf_adapter
> since they are only incremented in interrupt handlers
> igbvf_intr_msix_rx() and igbvf_msix_other(), but never read or used
> anywhere in the driver.
>=20
> Note that igbvf_intr_msix_tx() does not have similar counter
> increments, suggesting that these were likely overlooked during
> development.
>=20
> Eliminate the fields and their unnecessary accesses in interrupt
> handlers.
>=20
> Tested-by: Kohei Enju <enjuk@amazon.com>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
>  drivers/net/ethernet/intel/igbvf/igbvf.h  | 2 --
> drivers/net/ethernet/intel/igbvf/netdev.c | 4 ----
>  2 files changed, 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h
> b/drivers/net/ethernet/intel/igbvf/igbvf.h
> index ca6e44245a7b..ba9c3fee6da7 100644
> --- a/drivers/net/ethernet/intel/igbvf/igbvf.h
> +++ b/drivers/net/ethernet/intel/igbvf/igbvf.h
> @@ -238,8 +238,6 @@ struct igbvf_adapter {
>  	int int_mode;
>  	u32 eims_enable_mask;
>  	u32 eims_other;
> -	u32 int_counter0;
> -	u32 int_counter1;
>=20
>  	u32 eeprom_wol;
>  	u32 wol;
> diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c
> b/drivers/net/ethernet/intel/igbvf/netdev.c
> index beb01248600f..33104408007a 100644
> --- a/drivers/net/ethernet/intel/igbvf/netdev.c
> +++ b/drivers/net/ethernet/intel/igbvf/netdev.c
> @@ -855,8 +855,6 @@ static irqreturn_t igbvf_msix_other(int irq, void
> *data)
>  	struct igbvf_adapter *adapter =3D netdev_priv(netdev);
>  	struct e1000_hw *hw =3D &adapter->hw;
>=20
> -	adapter->int_counter1++;
> -
>  	hw->mac.get_link_status =3D 1;
>  	if (!test_bit(__IGBVF_DOWN, &adapter->state))
>  		mod_timer(&adapter->watchdog_timer, jiffies + 1); @@ -
> 899,8 +897,6 @@ static irqreturn_t igbvf_intr_msix_rx(int irq, void
> *data)
>  	struct net_device *netdev =3D data;
>  	struct igbvf_adapter *adapter =3D netdev_priv(netdev);
>=20
> -	adapter->int_counter0++;
> -
>  	/* Write the ITR value calculated at the end of the
>  	 * previous interrupt.
>  	 */
> --
> 2.49.0


