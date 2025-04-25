Return-Path: <netdev+bounces-186057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0D3A9CF15
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81DC67AD61B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4141DB92E;
	Fri, 25 Apr 2025 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9LMZBDX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5071A23A0
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745600652; cv=fail; b=sUP9BOos1wpYHtW2TUni+XmI+wYjJnvs+OGW7WtpYmpprSdFKXNGKfUnrPI2Xk+ShzZIGYBRBu3XyHK+U0QZctwpq1oGC9bgp+qTYGE5M8Qjc18TLGpCYA/Zt/NTxPihpdk0rk/ZnCElNGWgCMnzIkZwOTi1kGA4s2FApJ5KBQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745600652; c=relaxed/simple;
	bh=7m0pAVHh91sUGMwZOwa/mr+WC9HhAYZ9dMhKXMaiZy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LBzfUGDU1SqlbTJ5SVLNQ7zDTHiHmxr3Ldg8HFV57FupGQeAImj74PwF8tw8C4Ko2Pj1HJUql8JZQZDf5mkcYm8b4rVJeob7ZI2FF95/H0G24zdh3jN7ZQBSLJ5HyhhG3w5ngXWC+8F2EaUddTPD31v5DaC/+rljPZtVXuYhGfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9LMZBDX; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745600651; x=1777136651;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7m0pAVHh91sUGMwZOwa/mr+WC9HhAYZ9dMhKXMaiZy8=;
  b=I9LMZBDX+g5cyLjQFbuI9PJOrW1KZmJ99h6GZpHeM5HUw/6+p+03xnA+
   H17f0SUJnPEx9Zq54XmlGdQLgzmeJTHxIFN9Y1NDAV2cl/0upFONKKsuS
   /0VFrf+wabOUlfrROcLf03jSvDDtHI7wwHbyubmEfA9k7EWymwugHbP9p
   xCToH8QLmKoiKUCPAatm/W6dbVENNqsWwm1tsjyddL62fmDV4UBnmaDQz
   4z1aYZ4Tiipjbek2GOgmx7I11E0vUl4+Jc1V5NWPVPbnbhRy84KvHOM4T
   AQ8AEe+Rp+shazhxWmLPHS+x4aUIGcVTSM8BNv1pjiYmx1VxTyub58Qdh
   A==;
X-CSE-ConnectionGUID: oxWrEs9iTOu4IQsy0sIIgg==
X-CSE-MsgGUID: EH7BP3rATEuSXBxLnx537w==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="47405503"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="47405503"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 10:04:10 -0700
X-CSE-ConnectionGUID: UsXKy0GnSQOMwrOg8FMkuA==
X-CSE-MsgGUID: 3IduR98sSg66wQZhOEJIyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="137784127"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 10:04:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 25 Apr 2025 10:04:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 25 Apr 2025 10:04:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 25 Apr 2025 10:04:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=as4mgI0vY0WVV+/O+BjfqOvqF2Otx8ncwNyOCf8+FvXN/rHPASdf/VzyhRaj1XUFEQCiGzWAudS+hj9+bWZcKQj5YuMrVm7PVRhh3mBntSB+A9sHWmnTVbe/lmZ5kBK+XlnOALpOQ9w/78Xuz/rCRLZtk2Spn10r72tSXpCABa3pTAO5my4pP0mbitbQdtuo8pCxAe9zUbzZTqYL3iW3zdjqnPZXxygoZV5UixDCNmwrzJjQ1P50L8fOuyYRj2u5XxYKttxymgGy90/VfQ3uz4DyZbJTYwjEvYSDnhkqsRjIqDyJLZUbzz9gb/5oWZ4S79nV0PdFT6aL2et1Tpw6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m0pAVHh91sUGMwZOwa/mr+WC9HhAYZ9dMhKXMaiZy8=;
 b=FisWs3jIIuxXidl09+cCFZ7bdwINtz3G25sGn0Dukf5oxyrwycnpl6n2++rAQOn4CfPLS6ViEHXx6OuyLvTDN06O5plUaEhIbCTGPiVvAbrDfsN7jVCoxaqcLprN/D+MN52U3rFMlmGHD04f1TpEdBFrMgGy63S5c4A/N47n3OWSP4DmrDx8M+LZ6jn2guJpzXahthoKkUs5IDOAghMFJT+c57wizrkSKn3NuebuZwBh0vuEBxsIbs3OZJ1r+LsoOXluwpcg7HqMNPeDZpeY/PP1A7UzRyCe9mYjwHqLYzQCaoDnGlH9/+xJ4V4k6y/uV/Sd9MYaYGVQeOQOH2AIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by DM3PR11MB8713.namprd11.prod.outlook.com (2603:10b6:0:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 17:04:03 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 17:04:03 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Olech, Milena" <milena.olech@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Hay, Joshua A"
	<joshua.a.hay@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v12 iwl-next 10/11] idpf: add Tx
 timestamp flows
Thread-Topic: [Intel-wired-lan] [PATCH v12 iwl-next 10/11] idpf: add Tx
 timestamp flows
Thread-Index: AQHbrswfcRtEk1CZY0iqs5Qf9Xz7jLO0qi5A
Date: Fri, 25 Apr 2025 17:04:03 +0000
Message-ID: <SJ1PR11MB62972F3ACB76B84C78A7CC019B842@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250416122142.86176-2-milena.olech@intel.com>
 <20250416122142.86176-27-milena.olech@intel.com>
In-Reply-To: <20250416122142.86176-27-milena.olech@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|DM3PR11MB8713:EE_
x-ms-office365-filtering-correlation-id: a7c1dd09-88db-4fed-25f9-08dd841b2e76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?UbsZIdbwbwcsl/PomMpZSp8Xfqgt9e+arqevpvJUJw5fh/AJ/u53obPZedOG?=
 =?us-ascii?Q?Ix4CANFM8M1s3f0x1TxAFpnQx3AFBdtwORdCB2IhaNDML3MVYVxk1uLPuzsH?=
 =?us-ascii?Q?1pB3Ud6l3T7Db73oHmh+nrNhAjl0czr3qYbLqHPj7rLEn6wmMboEE+ukCP6O?=
 =?us-ascii?Q?gbSvx5pe6Ce73YEqC7Ws3V6VY3+aMcRsTWESZP/Sljybe1U9y8h/aCIOBffD?=
 =?us-ascii?Q?L3RC46hpng+0tHT0WnHGhfU9iyXRI+odWKQgeJaj0Ui++CGECPTOmWsQi2OJ?=
 =?us-ascii?Q?Ox+uubOVbnkgrKGk+Liok/EXqMX3DyHABsHtuGTxDB55JEyv+5qcri/96zcf?=
 =?us-ascii?Q?dPAd0AVekMnav2+jfhCzZKr7HpmELFqFCwo2x75ZB3cWKoR6KDvnzcf4jHGY?=
 =?us-ascii?Q?MLeQxmysiV9YLnf/dJDUKCwH5RAcEKlssDEkbXZAoTvV5b0Vt/HmA4ewNHTI?=
 =?us-ascii?Q?PRb6X5n37cOrHlLqc1z6YX0UzuDyfwY2Dn6+jSz2m6JfCaMYpSoN3dsmnT9I?=
 =?us-ascii?Q?uKO80oZCHwVVqWp6ZEk9VQUCKJrDRypMCqwF+uUFyS+VzA3aWX02NngeL5cO?=
 =?us-ascii?Q?ELMg25QHF5jUtTr8q2w2oOuGdrNOexfYvVvWUgxUvrcOXxrS4ckblFOvMloz?=
 =?us-ascii?Q?Jwhgjofzcat5dbnaSQ6BhMJziSkunH9w5gi/7zHwopPfAdfNhXjdoiujbnfo?=
 =?us-ascii?Q?m7FwpOPt8PBuK5uJaYxT+ZIRZc4prZBRUDVmCzC18bhqDg8z7H3svSQgvgg2?=
 =?us-ascii?Q?e+oJuodywERpMneYL+wDdQrjST2OKBuM2mIEHCQhxxP2TK1MtXMY0QvsRzPQ?=
 =?us-ascii?Q?CGl3ejoWa0Ee1cnH+j2AcDk9NR7Aq77xawCYuRKl9QbG6ZEgOxFe21C+U65Q?=
 =?us-ascii?Q?8Il2khr3AN0VA1uvNKTQz7g3Q54Bei5rnHNM8veoVOK3aMbBs/aVCUzVZsk3?=
 =?us-ascii?Q?42Y1ZG8F0Pe16HaLwp9M2dyPil7+7niRMLwPSrxFTCrM+231tQ/YkrKOpdwI?=
 =?us-ascii?Q?Nco5A7axVMJA/tv0rC8hDN9DrzsjXPkj880X06x/P7P4SYAlQoo1xqpSXfIS?=
 =?us-ascii?Q?Lao46RhAEIiNIx57MQT2v0yKNtEvD6gesuzWfsz66Z5GA/eDTIlOhlJI/pYt?=
 =?us-ascii?Q?FKBv8Hm3yjmKt6seouknufRXFyfriBA986wI9/ri0mtwl8PG1CufyF6yuH3j?=
 =?us-ascii?Q?ekBx5+lJSqlXwViiIxnMOtltbzpXxe+PfdktF7BkQNfrSXIRpR0WvWs5CeGZ?=
 =?us-ascii?Q?jvYVds785a3cNtSHJjKlWNihFkCy06u1fyWJr8B1yMEwBKOLrTKuSbzQkR5Y?=
 =?us-ascii?Q?L9mJVBuRjkC3BNvxVjti4huwODESlvRhKhVqXrsmf+TxoXwCIj+k04B+DxHw?=
 =?us-ascii?Q?Ug4HMCH/W3lRhU9hnxZasqG74cLE8V+qqOHVt3V/lDn3RSh9kuyRRQ1mv2Yx?=
 =?us-ascii?Q?WxBzNX14sYvzDWZIlnstDgZAF+pDKKskGy7eIH4/5vTpQOP69KtjDw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OZe+/4xfLV8kSWIKBePCg9PFXJBLf11F8k/w93NyiwVjjFzCNxGyOzWT0tY8?=
 =?us-ascii?Q?IMKBEeLM0Jd49IQAPfgy9JYcjwKsBLhcdLlQuOaoL0NGLVYknr83quialZfQ?=
 =?us-ascii?Q?bqcJkiVyJlxYhATYRrwhus8QqpKlBZLhUDmTRuWO2n9gS1IVAkPJo9iNSecZ?=
 =?us-ascii?Q?AIkewpkh/tGZ0xvJnSaeeddE0jDGY6176Q+F0QURe+cU//CRr4Pntfr37pbD?=
 =?us-ascii?Q?CRH34J8g+ePtOpdCzHEusuRvENZOMLd1vDOw5LJsnADbK0GZFvymSuNaoJzA?=
 =?us-ascii?Q?1xX9ob7YVzuMv5JEbjOHKHBaGsuYCfI8R0ygy34KmzO9UhEf4T29MMlW9Wbb?=
 =?us-ascii?Q?wAhhW6Up3JQe103JO99Kf4DSAfwK6yrs5ReMys8MWobUjjIRiBUIaDV2tkSP?=
 =?us-ascii?Q?scJcxXX5XDzYaJ7A70KpunRdwlfDz/L8nowyS1X8OB7C6KWG17LnSI6SDBZB?=
 =?us-ascii?Q?fACZXg/F/R0gJq+iJMQHd7U+IIgy3wIaJI0RnW+NqYZZY0hAKJRIfZ4AqylI?=
 =?us-ascii?Q?BM14fzTpLCoNtMlH8f2VSu0UH0V6+loABZV4Drt66Y+KgWXjU6XLe623/rH4?=
 =?us-ascii?Q?fKW8bS+tHKrsuPGd3S1qe80VZNiJpigZ0fJ2OR7F4bRblavgI8RO8n0uZ6Bk?=
 =?us-ascii?Q?ca+UYzaRyFg29F+uECVzcvqNi6p4Fd08/EUDyJCHLW89w1+GSieiISp26QNE?=
 =?us-ascii?Q?n0O/87M79j/J9FXN4nWf6wCHoPZ5Odi1yZYJI4NwaziHNrLo1y5Lq7dhbU26?=
 =?us-ascii?Q?gakKPm4EjaYuTnqWD9blP+8sp9PaxZ/GNRjUBp8Z8rbqMSxFSWdfnSoGQ85x?=
 =?us-ascii?Q?/YNAgaMHTUAf59SPtz+Hcsrr14DjVosXcsTq0iZdt0srDUrRA5em7g92Ybk1?=
 =?us-ascii?Q?tIyHNiJwENsLVZnfuOSQr9j8r9OUjUyGFmX5KskbrEgU+FNeiZyGcko/UhAs?=
 =?us-ascii?Q?yl8JUS1xAXoZjZwCOzaGAPuhnYqj1c4ufAC6RF/6Jl/zmZOLHL/I8jjZhbdi?=
 =?us-ascii?Q?8kWYaPwpyMLzIK3UdcKqF0JS2NeR3k/XhWm9wQEXbUbQMIHWTpiaaXA0oAj7?=
 =?us-ascii?Q?/ufDq9Cj5oyZ88mag0oJ4D0cyv3Lx6/B/bgfKY/biEt64cCM8/beuoxcmr/Z?=
 =?us-ascii?Q?ShfrXHRAXh5y1rL2ZUT3nO81DEWPNu4PfN+jPx6qfcEGjHxW9a0j5DhCXLbq?=
 =?us-ascii?Q?+rFPNCgUeVICv6w19rYv5eNkGdcEIiPrnmqd1vtsD7UKo51YVTvQTiVAjuQf?=
 =?us-ascii?Q?NDNJQFpMUquBF78QPOF62INcsZJlzGJ+IGuqWU3bHrxdBne5HcFzfBzYPTO4?=
 =?us-ascii?Q?MZ3ef0lKKaXnnaPSDPze/dyGvdzXowpMZ0OchNQ9stRal67RX1O2vjDEHPpA?=
 =?us-ascii?Q?o95Yv1eo6nX2hoVFccwy3/P+czeuE6zOUqx/+Je2jvB2idbEFn2lO1sgbIBk?=
 =?us-ascii?Q?ZDc1PcxQ0pe0uTjepMHwhqqQa9SKShpWSs4xLPel/UR7RDnCx3LvWYOYOPRD?=
 =?us-ascii?Q?C9viWouJBOYK730NyjzrVzzRdn9X0I7ATkwVpqgZgzR28nZu0aZ7zavLe3eW?=
 =?us-ascii?Q?9ywLTGz99/RCPXIJfYQr+r8SKcwXrSO9OhxMUqUf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c1dd09-88db-4fed-25f9-08dd841b2e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 17:04:03.4662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AieLRe/B00imRYwG7Kd/Di3M7KeF6eSiHX89JGP9a8IOG+J2jPEiDqJJAT3vVt3AOmk677xJ4mDom5f9H5Iw8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8713
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Milena Olech
> Sent: Wednesday, April 16, 2025 5:19 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Olech, Milena <milena.olech@intel.com>;
> Keller, Jacob E <jacob.e.keller@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>
> Subject: [Intel-wired-lan] [PATCH v12 iwl-next 10/11] idpf: add Tx timest=
amp
> flows
>=20
> Add functions to request Tx timestamp for the PTP packets, read the Tx
> timestamp when the completion tag for that packet is being received, exte=
nd
> the Tx timestamp value and set the supported timestamping modes.
>=20
> Tx timestamp is requested for the PTP packets by setting a TSYN bit and i=
ndex
> value in the Tx context descriptor. The driver assumption is that the Tx
> timestamp value is ready to be read when the completion tag is received. =
Then
> the driver schedules delayed work and the Tx timestamp value read is
> requested through virtchnl message. At the end, the Tx timestamp value is
> extended to 64-bit and provided back to the skb.
>=20
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Co-developed-by: Josh Hay <joshua.a.hay@intel.com>
> Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
> 2.43.5

Tested-by: Samuel Salin <Samuel.salin@intel.com>

