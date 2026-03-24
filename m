Return-Path: <netdev+bounces-270916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FGPCxVJwmnvbAQAu9opvQ
	(envelope-from <netdev+bounces-270916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:19:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D48BF304789
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F17330FA035
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15363B389F;
	Tue, 24 Mar 2026 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZ6tpYIc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71663322533;
	Tue, 24 Mar 2026 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338989; cv=fail; b=otjIDsRpX8BEVaIysWqwqQNzPRVD8K3djOEgtqmlfl01EapvokmCH1IgHFdpbWdPH4YkD8MA2KcOQcpvj+tX1osfLxDBLHMFUHWrZtKbNM2MjT+9P9a6Vw8q97t/1/6fqyUZT9J3CzkipX9QE5Khbz3Arwrw4lcPXplztQCDc84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338989; c=relaxed/simple;
	bh=LqjbEjfcV45GnE9F1mwgR20OqsSpwzRhieB+MGQezlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eh8mWtvWCt9Zb4eC6WnmF/7qQepZq1GVfW2+gZXD0EJNU776eU2kA5iLdX8Osu/bMLgMtIk/enQDZ55mKw/NQ0ib6Z1nJ2vWGrbFrU+l8+jMd1BVBxCB5poMyP0p7fQzsUwXvTm1fiaHhXTFb90rI6vLqhb2WZ0TepwwkvtrCqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZ6tpYIc; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774338980; x=1805874980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LqjbEjfcV45GnE9F1mwgR20OqsSpwzRhieB+MGQezlA=;
  b=RZ6tpYIc6iIjkP38ZCAIpd/cTDUa9Y4l2kx9k+7WXuFIq7CObVlq15xU
   60Spji1FlYY4n7cHNbTIlEcav0HfIgdsD/KpzYx1L2SRRwqI1gbWTh1nR
   2bl17zCUuw0NiChKV8aOEjIGyoTwJoXyiV16EATVYs1q8C4n2uDEp1bKc
   iCIsdXZIw4plJpny9tu3ISuQoRWmDTTRQjQBzgWCT2flDbVINp2oX7g01
   Xdk6YY3JlTrCLemmaVJVyrS8OGv4HfO+4O7OwXxs7pWKsIgbd2ar61wR9
   XpV6SsYwLOtUoZgHFcGrTCXbQypeTXe9K6W+Sye5MfCEArLc7y0hpk5P2
   g==;
X-CSE-ConnectionGUID: WPLLujMmSIiEa7cEEBCnLA==
X-CSE-MsgGUID: EaB015BpRZibBl0QacrA6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75320231"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75320231"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 00:56:19 -0700
X-CSE-ConnectionGUID: kkTsn2KqRN2Q06LiUHwRiw==
X-CSE-MsgGUID: AmJM9FUpS22ArJg4IFLgng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224507658"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 00:56:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 00:56:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 00:56:17 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 00:56:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1ITTxH6wrvcLZGX7CAXoBgJn5B+VD7AVWK621Yd20eY7CdLodqPXUmlaDcHmqvie/w90/g3Tc8rVuHuadeky5SaXTPs3N1K30L7q+brK7FnQBVGN8KXOEP+m5N9zaSoLRosqqQRzAzdVeHNHgPoe+VkAVGyAFoRbAPY2sEByRjlvKNc8KCHTBfyr5KQ89zA4pfExJyM/od+k2y/oszLv+8YFSB0wXB1kO0kPJIlVbT2ds+uQPz8QQAK/lw4f6aPG9c+fYQnyJMsUBAvYY912lR7vJivKojd0Ct9zQ3OOsytvlJOLXwOArhbzaPys/byJbC2b/H6EbFhwl5k2qQldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5vCj2PLEES2pzv3b3RtZVhuzgQl9Dbu/YfBN0357aI=;
 b=MrYM10+oSPyPBfndgRKR4J0LStf47RCHaxryFHIpxQSN52hGlPXKJ/htOcIavp59aAdYY6MFbVNA414BQJpp3ICMXk7HK5c4fkMu4URRIEQhiyCimZZ73GtmVyIJa3JCQ0YDzoHVJf2W1hkmDayZoo8/oKdLsmkA+2Hv24TfaUVn4RHQGlgSr5aINBnLmsVduT7A6cNyUqUarLbVtvtPASUXrj3FAWtqvOsNKlssX+mnT68B3psnop3jHgNpxs/gEssMhJdgrJdUoq/qhatF412NZtNnZV5x6bsLL25m4OgGX5V7OVzqiAapDqU0F+3WT7pQwx4zwyiIF6FOYcAXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS4PPF2AD6B04BA.namprd11.prod.outlook.com (2603:10b6:f:fc02::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 07:56:14 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Tue, 24 Mar 2026
 07:56:14 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 07/14] idpf: refactor idpf
 to use libie_pci APIs
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 07/14] idpf: refactor idpf
 to use libie_pci APIs
Thread-Index: AQHcuuxZ3rJNOFJZPUKT1CBUScSmd7W9UW1g
Date: Tue, 24 Mar 2026 07:56:14 +0000
Message-ID: <IA3PR11MB8986CFDF333C0562B2AAE11FE548A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260323174052.5355-1-larysa.zaremba@intel.com>
 <20260323174052.5355-8-larysa.zaremba@intel.com>
In-Reply-To: <20260323174052.5355-8-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS4PPF2AD6B04BA:EE_
x-ms-office365-filtering-correlation-id: 47260874-e0b7-4ea4-e5f6-08de897ad2c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021|18002099003|7053199007|56012099003|22082099003;
x-microsoft-antispam-message-info: ujOEBbBkWouQaq4mlIGya+X0AtZNHakBZjD3D9ZAOFqdf7vQJUFrRZ9+cacL0OxZHir+91YyS+fA0CAYDuZuehu4Z7tRR2OEivzmtkZE9fDkBggsEsZSwAcHry1oTHMR5RsaUUaOEM/elMjos5BZhBMKWzp9dgoZRwFt/8U6ke8iwMYKnKD0lxP6uzq2gWT2mv0BJN+zDKmz+mqI8Dy67Bh0l8VKuXXgp/H/fq//qX1Rd5U48qyLZdmSkrROqfskk0OHnYLVtMmAj6ORB6Ccop/nLGqSSOkrfzgJrk4pPQ38VmYNaBAy5Te0S9LBzirMj9iC5qXxAy36yoJcVFZXhiHFk7gnp4FCjutUu+YIm4d1JWuWYSr4ITXyZ0oZlmD90zhqEAgolhXKJaJGNTvv3V9Q5sV6C+6PKDG0zFlNzty6np4HlgJJBxe9/88GLPH4uL3tN92y3om5XqB4cOZN1zJv2Hd3mycKI138d0SHG702Y3saDI8nKJEsUPdLe/fo+s+gEMfDKfVzMMYGjB9BJrLpF0AShISy+J+FsBZ2ECVU8XRp53M8IRITkeWw/BteuUHj38Yi4hZLCKXyhnA315ymFoIGKezY2gRaMybpnIF0tV43KQjuk+69PT56xnI7ykSvP/Z/IChbobIZGCHYYZFROQKG9pjfUY3v2suB0VUDpDKASpsyxfhC5mJcSnuyvdgbaN9D0/NjFSWXpoDRB9hlpOdBSJNhS3ehdoMhewqzUFZFzrm3fYZCXtH5x61EI3FWn+ZSznxz3p8R4hp+bVLL4K5PUjqXcs4fs4LwTfc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021)(18002099003)(7053199007)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iKBRe9YkZ+axr/nofTTJTyv6PzzWg4SFYw4T5fm3eMsWSR35527AJKTX5xuB?=
 =?us-ascii?Q?nkDTO0JH9Cn9qudV2AEUSERhDtzm0P4+dDpcafTpL7sAsaPtJ98i+jB6tmBL?=
 =?us-ascii?Q?+fjxD5yGkVyNbr6Uq3ByslxW0khp9nLws8+uq4XTOI931DDcXH9rojy8FWbT?=
 =?us-ascii?Q?0/i4w8TqF7CzZOn1g5YiFG8iNkc3Arhx3Z/1rQSS/nkvqgw4iHNRzL7IZjZ+?=
 =?us-ascii?Q?XmUstLh9qhwaXS5bbVElz6eW7TAo2GwZa8l0pk9H00P6U31JNo/6gg6U85Vg?=
 =?us-ascii?Q?TBRWsWtNAg/5BbXB8mkNxA4qcJWYGjk/AUaeK/+/TLId1GkmC5k0cmX/8qNB?=
 =?us-ascii?Q?M3zPy6DPyMW2k/8WgXCe+GNfkgoPAy7iRwyr+HeLz0o9IGnaH4cuJdLLxHBZ?=
 =?us-ascii?Q?cNU/cXBTU0TI+NMBp5Qcy4gEtLtchS9aR0BE8+ZrzKkF3qHH7Bh/1xzIfmET?=
 =?us-ascii?Q?nx1sMd0OMs3pd4jxUewvU5FtYTElv0yCrq19o/+8GGpdZ/YNXQS5pZbRwSVN?=
 =?us-ascii?Q?ckHEJUGGiBb/m9nPewhRRg8Bpvw22zlDXaxElFP/zeJZbHDIM718Wp7zlidE?=
 =?us-ascii?Q?nQOHS89n857NPVBHCzJ1wkKnR54iAVINy3TpzMoLiQdJXm/tesxvZALu1i3U?=
 =?us-ascii?Q?z7JR0FgCe4JlrwAB1XmIjzuRJZg/w9viAviUpN9ZbwwdZtdzwkCDqIHBr8Aj?=
 =?us-ascii?Q?UK1ZB543AVGopxE7vrQ67efNAZVABarpV75gHD+DDuNRKpWKwljC023gwdr8?=
 =?us-ascii?Q?ej29m3/7vGGCDbCOuyqg/XNDD9YGc7zK9vvm+E3VGDVPfb4E1X/l3/qZe53k?=
 =?us-ascii?Q?30w60pU/utluUQjY21fRQczwExny/2sVQjcKPWxs69FxJq+tZdfkUzJKs3YK?=
 =?us-ascii?Q?xw3oaLx9gH/9OwhEzjzfNEQ40N11pyG3U9jBMfYC2EHvUfIoZLnXkdPVqXJD?=
 =?us-ascii?Q?jSlBVKa6luy/jlkMOizEU2EgqLFX31ne2OwaETa93G+KErTQ2yyIyNxt0p8L?=
 =?us-ascii?Q?WjSDdZ/R+ATDau1ssyPP6RHY//AhOFBGp/yd2RTcGLy+CY8dpiy8rh/Gx2Xy?=
 =?us-ascii?Q?IywrV0qAaQkUO+cdo2aM1z5XCM+ssXbnWTPgPu2WNUOTKEJcnrXUKG0PJZGS?=
 =?us-ascii?Q?NrEhGPsFHQLRwFj7eJ/fG0SI/Z9MQ4Q53s0jSDLEII5TYZDqaWu5oNlmVElu?=
 =?us-ascii?Q?9atUl3pjsX2SE4Lv5RCguj9+8EYetPFQIt56xwp9z8Sm6uEo9QlvDZkGo6hd?=
 =?us-ascii?Q?/gsz9KWmvfG/1kTicJ6AcRyr7uHbk6b2cRqXJAaTseLeSwDKyQZ8e5Yy00Oj?=
 =?us-ascii?Q?VCWIxGw5ONXwlS5u1u1RZrmcaJ1xEQKk4MZQ3MJ3TNjbZvfQGw6XKeyW11GN?=
 =?us-ascii?Q?ciL1VPr8pQeE6wlt3ERl3EuSC3Z32MSi8m1lKroRW6zhR2QVGu5GpPYXKX87?=
 =?us-ascii?Q?jND5sX1JWfTWZYAuxZD7GUm4oQS6wMu5ZrtoBiyLnB84w+FF1lf9yYa0IzRv?=
 =?us-ascii?Q?QfGvZ8na+ZcBe3EGTyecjNkAMYZSu8orpwKRDghMqX6QVqLNTVJAJxCj7Nzw?=
 =?us-ascii?Q?2gDVH8etfbPv7YhEwWnitOuQQaVZ9kl5TVcbceaYEtG8eYKVv3OGNdWLITJZ?=
 =?us-ascii?Q?7Y1wob4E66tOVVBG34gRjlciLgLkeUabTSAeHfaxpYO8RUnB/ZOoNR8ayKH0?=
 =?us-ascii?Q?2fncFtlJarV2TMX/XPUCxExSI9X2NpUHbWkLzKJBGnh84xeYJrpGUlyLt1/o?=
 =?us-ascii?Q?xdeCgLyBOcg5xojq1dBh7BWsLxiUgNY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IMoWkDcEFHLmBAQwZBjxfFvxf2Xwyyg9MJZguSHw116U+d0htUPypSPTqKL4kMzM/irvUSYD8i8sTxl+y1aikwiLsyFnNluzk2f036qO68JGin0AmnrlTb5FVaXkXaBgQ/6YasERrHe5GeeDPz9Cyx1BulequmCXC1MXjQZFuVX1Gc8TUay8RR1KQlmMumy0F2OiSk1MH1Otowy9uThYqfRGlmZI7b5g6VjBRJfk2bePD5Slii/x1rLM9rS6j0Pml2fp+9VV9E28WEq1W1pE64UK5++vGMN48koPzQkT/F6YjxYy760T6wKUCIME91AjjsmGGvx2qBv78hBxC5y/jw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47260874-e0b7-4ea4-e5f6-08de897ad2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 07:56:14.7571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MJV8POcOLiON4Ht8QytRFXOzXLRFjL0x7hbotBJ1DQkwtRe8LpwRa5T/t+O9CUg8+USCJkvox+buL3UvWYWZGibAMPzYkQPQzWh098+sSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2AD6B04BA
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270916-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D48BF304789
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Larysa Zaremba
> Sent: Monday, March 23, 2026 6:41 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> Sridhar <sridhar.samudrala@intel.com>; Singhai, Anjali
> <anjali.singhai@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> <jayaprakash.shanmugam@intel.com>; Jiri Pirko <jiri@resnulli.us>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 07/14] idpf: refactor
> idpf to use libie_pci APIs
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> Use libie_pci init and MMIO APIs where possible, struct idpf_hw cannot
> be deleted for now as it also houses control queues that will be
> refactored later. Use libie_cp header for libie_ctlq_ctx that contains
> mmio info from the start in order to not increase the diff later.
>=20
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
>  drivers/net/ethernet/intel/idpf/idpf.h        |  70 +-------
>  .../net/ethernet/intel/idpf/idpf_controlq.c   |  26 ++-
>  .../net/ethernet/intel/idpf/idpf_controlq.h   |   2 -
>  drivers/net/ethernet/intel/idpf/idpf_dev.c    |  61 ++++---
>  drivers/net/ethernet/intel/idpf/idpf_idc.c    |  38 +++--
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   7 +-
>  drivers/net/ethernet/intel/idpf/idpf_main.c   | 114 ++++++-------
>  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  32 ++--
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 161 +++++++++--------
> -
>  .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  58 ++++---
>  11 files changed, 271 insertions(+), 299 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/Kconfig
> b/drivers/net/ethernet/intel/idpf/Kconfig
> index adab2154125b..586df3a4afe9 100644
> --- a/drivers/net/ethernet/intel/idpf/Kconfig
> +++ b/drivers/net/ethernet/intel/idpf/Kconfig
> @@ -6,6 +6,7 @@ config IDPF
>  	depends on PCI_MSI
>  	depends on PTP_1588_CLOCK_OPTIONAL
>  	select DIMLIB
> +	select LIBIE_CP
>  	select LIBETH_XDP
>  	help
>  	  This driver supports Intel(R) Infrastructure Data Path
> Function diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index e717f8097d23..7866b8beb6fd 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -23,6 +23,7 @@ struct idpf_rss_data;
>=20
>  #include <linux/intel/iidc_rdma.h>
>  #include <linux/intel/iidc_rdma_idpf.h>
> +#include <linux/intel/libie/controlq.h>
>  #include <linux/intel/virtchnl2.h>
>=20
>  #include "idpf_txrx.h"
> @@ -625,6 +626,7 @@ struct idpf_vc_xn_manager;
>   * @flags: See enum idpf_flags
>   * @reset_reg: See struct idpf_reset_reg
>   * @hw: Device access data

...

>=20
>  	return 0;
>  }
> --
> 2.47.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

