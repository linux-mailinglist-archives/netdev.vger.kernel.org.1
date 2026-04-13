Return-Path: <netdev+bounces-277984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB9zK0un3GkEUgkAu9opvQ
	(envelope-from <netdev+bounces-277984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:20:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B233E902B
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20EB13005AEC
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AED3A7844;
	Mon, 13 Apr 2026 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S75xIaNs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4B3A6EF9;
	Mon, 13 Apr 2026 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068383; cv=fail; b=N/Wq3e+JSnkGYKNkOimn/HEA3HmXlghqKUvR4FslnqCEONQtTu6BPK9fGJJUn4BfYXEqF7orBLg+ISNdysN+nL7h6iovmN14CCsKpBDkFhiqG1QVoFh4lfwbrWdmlGiRN63xHjat9D8FJ4HE4vmX9jbrvSFjTfjmNeyVLP/vvBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068383; c=relaxed/simple;
	bh=LqbXnN6wjRunbiEIWGL9KTgFbj5v8rxLe71CFBm/SmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G0nSVK6T0+ApuCqnwTPLYP+l3m14+CnRKESN93bh30O+xzo+aa3Cj7xA9POXedRhHYCAZneaEGMaHAOUQY9f2Qe+nQG2lW6y5VWLGf4twWGA50n5J67M4wMjzbKq/Wgocv4DQoCONXy39GqwliPnZV/Gkk1g4+NMYV2zeaV/W+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S75xIaNs; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776068381; x=1807604381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LqbXnN6wjRunbiEIWGL9KTgFbj5v8rxLe71CFBm/SmU=;
  b=S75xIaNsRrL96ptkF07f1tL94P1HMFjOrn7uv0P6UI4Xe4bgORmutrph
   y7cYdJT4jqG2olqmDDhXpulgpUYh+qxH2J1nsC5oaBMx785d1mE9mKM6+
   TzlDOWVRuih3hPB9XLPUFAikiFZg6p0tRuv62oQ+XRXq/msuVubkJhA1l
   407I/8UZCnr4o76tLs5vpPkNrh4YaFTnPV2XwZlx9sfW9ssqXNZ7+AHHk
   Vr2PiA1wL5Qds38mHcLOOE0HP2OEf7hEQbuCRZ3w9iom2xileVKf77+rL
   T2dJTWfaURyU18aTj9UdFaeg1FgeNvS0hDjq8i/4H6Gix+1hOkkHmw7UA
   A==;
X-CSE-ConnectionGUID: +5giQ1zsQiSIl/+iHzLHSw==
X-CSE-MsgGUID: iNUHu/CeT66dSVXZaAFwtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80858454"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="80858454"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 01:19:41 -0700
X-CSE-ConnectionGUID: 3ch00ozUQMOZaw/c9FoKOA==
X-CSE-MsgGUID: RgOKeqS0Qh6E3WA/xsPzZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="233752409"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 01:19:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 01:19:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 01:19:40 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 01:19:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCxOGd2Ok4P3a/LfH3WIGx6gRwb04sRgsRc67nDkuXv8uAyl9AXQlW0eqDEI7PBlMiGJp2DOLVuu08xVLwSpFuBe0L+OPQuaaZ80975aTRxDtL+dvVNsCeMWMbxEs7n/i5e0XUbWHsjkzhR9LCQui2vslWsNjWK5BlJkn+m0GldC9h9XVeA1IjPNPdxy31+PoEO+ecsGmxihJ24cm4aT6JzOMbVjioQEop93ifZFLhQIycRKFNWHWCS3kzWW2BPutaMURQtXzpiVIMFxA7BK3TOq/RzAVqRvsdb4Koi4fWTZlnmfVqelrTvQlSxsOF4Ed+Y6W8GmOfOy13RWFvbseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DBbLOTFwx87D9+RrTSWlHONAER96CkRI4mgGQOJ+mM=;
 b=ob0Nzsv1Pvsj8Gf+qMZUY5MHr6SuGVwYjDXTBkDej/bfuzbhN1I1nE0ZK3CA5l42NL8wtFJTbMfOB12tmqz1wq7zbA77e6r2H9HfiAsVZ5SCG0Mop/e9umCxMIdP40urc9/Z++TuMNU3CyPCh9j5MeVD6ILyI1AHb3rV/khWTQDNK6g764oksl/r0CCCdVpMer/WNra2cl03EvWItmFdXovANwLeaT5raM2z6AFm7a1TkKDa9yuxXzm025feriF1gELdmY4lWXLTBF8wShfnPDuFsM5Y04BQjyGx+kYXD9h17z05zZwvkKKx5IAES3AuferBeabDDdk9x60Z3uNIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by CYXPR11MB8691.namprd11.prod.outlook.com (2603:10b6:930:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.15; Mon, 13 Apr
 2026 08:19:31 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::7b0c:7df:21b8:dbbf]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::7b0c:7df:21b8:dbbf%3]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 08:19:31 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Nitka, Grzegorz"
	<grzegorz.nitka@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Oros,
 Petr" <poros@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX
 reference clock control for E825
Thread-Topic: [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX
 reference clock control for E825
Thread-Index: AQHcwvXix3hjxSFB2EyUhfJETBJtn7XS5QsAgAO7FYCAAOemgIAA3aQAgABojwCAA9gqAA==
Date: Mon, 13 Apr 2026 08:19:30 +0000
Message-ID: <IA0PR11MB737882B384AE7279EBCD05C79B242@IA0PR11MB7378.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
	<20260406192312.0f7a2760@kernel.org>
	<IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260409181041.395a0c37@kernel.org>
	<IA1PR11MB62194BF52262FCEB7FD5E76D92592@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20260410133812.4cf9b090@kernel.org>
In-Reply-To: <20260410133812.4cf9b090@kernel.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7378:EE_|CYXPR11MB8691:EE_
x-ms-office365-filtering-correlation-id: 4945b39c-6de1-4e3d-0044-08de9935632a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: jz98MQWXEPVTk6EHNDF/DI9XIpzlFSlWZ+tODLIB5nyP+jNQqwq5NMBcdH1SlQmoNWDcOG/hCsQ7vCh/t2WWsc9THV4gsMDiDLP2PxuWJmSLQaPRVBZCvWdnH0ec6hhnqPfOpPvueIJfLOw+zUS0tNE5BkORJmJ6obtpC/0njcSjlFLdnWKoIlPYtu+jJC6Lv9TMfAMAjN9BVNbJGTMlTtV996Zz5UxabmJGs0fLQku5YScWL5SHFhyRaSiwAhy9QbNkPV1674TrMKkxyUDZsuJ2q35CkqTDTBh/z/g77/IGTUqkfkUuSM586dVCQulGM8J3iub3iX4OyClWzlWq6D/PRi19kC6xpj20mhhlMVy1XXNsu6x3BUthZITmAl2O82isp/oke0grmLbEWlKtp6yVC465OGToZ6PiJpcHw5F4piHMfITfQNFIMbz2bM/YzGeVUwCm8glRROeMKXLQ+kPzNH8pmF+c/qflESXyOfSd7arh0pn3o90/LwIK2gy8xkCeWKxbl2veRmp2MXkoagYtNjFuGeH7NCFqJXaVC7p6qAdBd7DJHkP638643UD50RsyIW/7u+occkfGbenFNMn6rP8VpszIUcCbedVXbODHX+NwhXhhxOTZvgHH8BM3LZ636n06f/Tn6hmL5YINQSyzKt5YErkXFGFv4Z8jHf3st2CAon0puKoyV8p938HLpf+PlzgG1B/qg08HZ0MfrVo+BwnWFHBltRHJVkDQD7KIjADyzDT428LF+bJ/0g5l10NiKoi5P/j9caTEukWHpbegqHDVaGmAHQ68gvLjlC4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7gjpkbDKT7KwrtTkwQhNyMuzvtVw48YlUrFLSIjmEf37gdy2SMXI8CL8ewWJ?=
 =?us-ascii?Q?M9EJpp8WaDB54uwq1LiiNfu+YKwxfons5CrB5bniBA0y0GhKEGA9v6y28tyi?=
 =?us-ascii?Q?chgaFkKvqL1102T0X2NKIcmWSHSO5D5mqFH1nPcHQQxAydBjX3Frk56eSi0L?=
 =?us-ascii?Q?5Dty3wzyL8DSw6K4iUEdLno3+aRw9rZkduBlz0z946pxEHf4/Ww0vZ+2bBda?=
 =?us-ascii?Q?yg2Uwyo5rowqLMAOh1jPvBXbzHKGi0aShSxbb9KG92BEaJ6ybY+EpnD4MTdv?=
 =?us-ascii?Q?UccRvHwVAOzn01dgSJb7NXSd0J/dACXUcJFe4f0CI4GGg/N1++eO5cztHBBc?=
 =?us-ascii?Q?U6CZ9IkZ9VTN4p6jUrbu97u3l0yAxTNS/n76bsU0gx24cHve/s6Eh+VywY72?=
 =?us-ascii?Q?78k87jRatfuB+1ieXU5xKonyKzk1YWlNMo7fUru5oxNRDRtL8KKMRpT27C72?=
 =?us-ascii?Q?Wfii967xiJv8WHQ5a0TgToptIaO3CzOIDQnDsHCoEbDdNWiNN6DCWUKwZfA7?=
 =?us-ascii?Q?WlCjzjTwcbIBjZb4xCs35HapDN813dtsrJBs9gEhoTXJBw0jnvCTUxdoeDVW?=
 =?us-ascii?Q?S7CJ1KnYSBQMlv/QatT2238FH0rSHvpuNjB5XkycUqqsrfPTDki8pVKRj1fG?=
 =?us-ascii?Q?7h6O582hp9Nhys6yqsQr6cozzpFiA3bs1tFKtfZulVvwmsGMoWCvxs/6cjWO?=
 =?us-ascii?Q?CESvUZ4fkVry9uiRd9QB9NelkiHPO/hk0V3eiz7ymn/4QekynuQkYpHiSdSr?=
 =?us-ascii?Q?g9/6YevvihsIgW9qx9aLMCAJUlk58zlf2yQaucdRaMFDQjQSi542Q1AJWQD9?=
 =?us-ascii?Q?0EnjJiuLx9b0Hrezm1NUR8fHbqWiU+BCsar7DvhEfrfWLfgLp8NAYlAUEzys?=
 =?us-ascii?Q?ol3sCWWZrAh9vv5GrXY+KKpvRpqM5isfXr0R4NnUdmxzw/vB6fg0+Hd7anRG?=
 =?us-ascii?Q?UmQyQYtTckHOT/NWWKDaBeRWqFqR/P2oaHHM1kO/DUEa5xvVCjjoGh2kcgKv?=
 =?us-ascii?Q?pXTKl0SocQhR43mRJol5W2tPrT88IBXfEKfth5p6rvWKzIp/NQOxvbHHJv6R?=
 =?us-ascii?Q?+97ZIrVLMBUt5HHHUbha1DkG05AROe6XYZFBoaxsGl/jJiOHC21W/aXawOAE?=
 =?us-ascii?Q?RBaV12TWTn6NX7eeb1LEXxUJOiKAZrcdDd+QpFWPIO/EfsWd9LU0pDYrEO8b?=
 =?us-ascii?Q?oAkLvgEewdquWmNHg5ajqWsZZm47q9jFRTl4RfioC6ZxDIhfftCRTPr/8Gqf?=
 =?us-ascii?Q?x9Agus+KcAphTRLhFsSYCbdYLxnCXrKGPjyd5fdn+fQRU3Q4WGSN7EHnBB+T?=
 =?us-ascii?Q?VjohiChqDvLGu5bBlvUNWuqaljJfWhf2cQiN+kMawwCEt+mRFjiYCsD52fT7?=
 =?us-ascii?Q?XwX5PA0boYbG7vZqAwV/NSr2C1bNT4B4McRhVowq/L6Lc5U1J2c5uEw2Rlhj?=
 =?us-ascii?Q?1h430e4+MwFk02McF6xhq+axRiL9H1TKfwU+CB8xy1ZeBHqSnAUkon2l03/k?=
 =?us-ascii?Q?ssrv+RphNSdQzit+yhESC3HDpUejf026SX/EVBlFKBNBsMxLvHFDCb4/0gUL?=
 =?us-ascii?Q?9iXXaKGYbUSMhyXMgU5A3h6CeAu7km3Z5wtQh3jA4u/MVCwZ235nIzELxVv0?=
 =?us-ascii?Q?6mIdHn1hNDXiKKprPTD3MwttBeiV4qBN0AkDCbDSgE6e2Wc4Ajx4GK5uno2M?=
 =?us-ascii?Q?8DWqk5P4i5T3agIBXdLlWmP8I0K2QNyPtV03Xy197JmZdRhJqljmN591cV/b?=
 =?us-ascii?Q?6q1V6i4Sfym390YitB3uNVyVTnZQ0eA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PfDQEwW39TT2VU7mgVnZ2Kjcf/FWHqo1ep0q26dpfypOCANrewJYsaHAu14l0jGcVPgP+a2bRKxRofoM3JGTa+QfZAwSPes4jtFH4M7Py9iLoNO7dvVSqFd+wpDSM5/ySOYXvUbSKYb8NA+SllpsXEwzUdPB1mLoOpnx04fBUvanQUQLZ6DQzitVsf7nBM0XWRmVJcp9XVjMCkXmhUvj4c0i3qQsmQ7i9BW8dUjIv3ZIm4e5mF2v5o5YnguavW+CGgZDyKaRdiCTTz9vGpVRsWqrSzMKLg4SurgK11JVQppoE573TNYFJMgn8/dzlHNIVBUIN8XP2mvLx0/Ca87XvA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4945b39c-6de1-4e3d-0044-08de9935632a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 08:19:30.8658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ss/xdPlZPLa669ObH+vA+alkPQkkzBUNMhRwD2q6jaa90iDbFsPBxTTcN6GAVFohbbeM1TDB0S0Up0jbs5cgWHxlAdvOFOseo5UFtFcqCl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8691
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
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277984-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,IA0PR11MB7378.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 39B233E902B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Friday, April 10, 2026 10:38 PM
>
>On Fri, 10 Apr 2026 14:23:58 +0000 Nitka, Grzegorz wrote:
>> Here is the high-level connection diagram for E825 device. I hope you
>>find it helpful:
>> [..]
>
>It does thanks a lot.
>
>> Before this series, we tried different approaches.
>> One of them was to create MUX pin associated with netdev interface.
>> EXT_REF and SYNCE pins were registered with this MUX pin.
>> However I recall there were at least two issues with this solution:
>> - when using DPLL subsystem not all the connections/relations were
>>visible
>>   from DPLL pin-get perspective. RT netlink was required
>> - due to mixing pins from different modules (like fwnode based pin from
>>zl driver
>>   and the pins from ice), we were not able to safely clean the
>>references between
>>   pins and dpll (basicaly .. we observed crashes)
>>
>> Proposed solution just seems to be clean and fully reflects current
>> connection topology.
>
>Do you have the link to the old proposal that was adding stuff to
>rtnetlink? I remember some discussion long-ish ago, maybe I was wrong.
>
>> What's actually your biggest concern?
>> The fact we introduce a new DPLL type? Or multiply DPLL instances? Or
>>both?
>> Do you prefer to see "one big" DPLL with 16 pins in our case (8 ports x
>>2 tx-clk pins)?
>> Each pin with the name like, for example, PF0-SyncE/PF0-eRef etc.?
>
>My concern is that I think this is a pretty run of the mill SyncE
>design. If we need to pretend we have two DPLLs here if we really
>only have one and a mux - then our APIs are mis-designed :(

Well, the true is that we did not anticipated per-port control of the
TX clock source, as a single DPLL device could drive multiple of such.

This is not true, that we pretend there is a second PLL - there is a
PLL on each TX clock, maybe not a full DPLL, but still the loop with
a control over it's sources is there and it has the same 2 external
sources + default XO.

A mentioned try of adding per port MUX-type pin, just to give some control
to the user, is where we wanted to simplify things, but in the end the API
would have to be modified in significant way, various paths related to pin
registration and keeping correct references, just to make working case
for the pin_on_pin_register and it's internals. We decided that the burden
and impact for existing design was to high.

And that is why the TXC approach emerged, the change of DPLL is minimal,
The model is still correct from user perspective, SyncE SW controller shall
anticipate possibility that per-port TXC dpll is there=20

This particular device and driver doesn't implement any EEC-type DPLL
device, the one could think that we can just change the type here and use
EEC type instead of new one TXC - since we share pins from external dpll
driver, which is EEC type, and our DPLL device would have different clock_i=
d
and module. But, further designs, where a single NIC is having control over
both a EEC DPLL and ability to control each source per-port this would be
problematic. At least one NIC Port driver would have to have 2 EEC-type DPL=
Ls
leaving user with extra confusion.

Thanks,
Arkadiusz



