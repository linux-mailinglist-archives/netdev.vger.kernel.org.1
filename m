Return-Path: <netdev+bounces-116515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B750E94AA10
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A151C227EC
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741A5914C;
	Wed,  7 Aug 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrCaShwF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B297A6F2F0
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040797; cv=fail; b=XQKc+NLnV0yjJlX56E1D5afF/hvC3yG0HLMM9Taz+RfqmR3mew1lfzNK51Pwbb0WxCbM7cDyrIqHaWnczunPVn4TPXo6G4A8OfSCYfSYC4i95XI7rC6wLHF79cZa7lmSPynXdYIco1gR/vhgrpIro78Hmtfdhe7sCKNEJdriCdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040797; c=relaxed/simple;
	bh=1TKp/eCpqyZXc8k2zlNk3k/TBuJvQFrfcnBOA+UzOks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CXeSMf6qVVdIfoi8sWy3e9fZZor9JlnTQIcNkzhXqK4x6HzOn5pC0iv3KF4W/w+P3qM35hCBq+t8fjYgpGoZS5hP2oA9xwLexeIvSPOToM4zeo7GlT/u76rkFCHF5DIzwIqlo8RzE6Ad3FhEdlVuc59z62Cj8PGRP+c9OmLMPmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrCaShwF; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723040796; x=1754576796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1TKp/eCpqyZXc8k2zlNk3k/TBuJvQFrfcnBOA+UzOks=;
  b=YrCaShwFYGbWKVzZyoXiO1EVWNuhu3NeWQzXgZVMP+DPP0n9A8jRkvzj
   v5Euo45XoIdgegN7pZy4U3iPDzT5KWd/I167A6/8gG1ldduvASqi0llCk
   R4LGpTSEiTnQOTqCG5Md1gnWQKMObRDRmy+XbF4NO4j8naHh9hwnOs5sT
   PIon4YnK4O2wgWs8LFFpCiS9Oeh2Q2og8DIos/3uRJBv4OzP5tfYSFAIa
   QjJ1WU3z2I3P1mUbtpmnPKAhjl/pmlgKY6tE0aKs9HRe8/3YKXoW0qoHa
   XPWOBj4GHuoGjKojpfsxoR/bMtJ2EekGriucmpeapiGAPJkpgUOf2Xzsf
   w==;
X-CSE-ConnectionGUID: XD0ZrXPQS3OjTQV4m4A0ew==
X-CSE-MsgGUID: T3/18X4KRx2iR0C8I6X8WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32257323"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="32257323"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 07:26:33 -0700
X-CSE-ConnectionGUID: cheDIHTGTOyULD+SpGIaFg==
X-CSE-MsgGUID: yvlRVXZPSSyhaEiSbGn7Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="57566085"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 07:26:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 07:26:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 07:26:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 07:26:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBUPEZwZpidX53bP+9GNhM2i8dPS7LBYI4v6L1Io7eD3+Pet052HsFlGr9uvEWCd3KXJFiSNrMCZJdZfV9abDwafI+dlK37lzQFlhgVq5IDA1cjP2ANXYG9ccXlkgCIDKSFDU80PuvFkJ4Xc8jpmP2Iml88HvQvu7dJjt3qvZw8j+ryt/KnxEjmwe3H5XRueHUFU2rzg0D5W07NlnO5sXhgNEpWfmdjStFceYkQuIBMgMAyujtvxSwCD9CisjE+ky6qPlOW+DBDx6Iny8Dg8gMCLyZ0Uf9+qQKx926oGplFdNetdCJ6S8927TrjvpazUbygL2ST+skzBBTkNWqKxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDAK7NA7gy6Gz9yDd8NieLq39wRHIlaHald3TeYCjL0=;
 b=dSxCiO6335eTjN3SIplQ4mNThH5FHXYScZopEz+YZOkOoZwGKIXnT/HPomypcsxveSopt0+EpHUEG/vcGWhAFCmjc/nT2Tb9Rlzmmi8k0uYfGYpRwnpkW89M8ETlAEfqad9SEcPNvnlLgX1VVs8HMrFBF0+nbTBeD66pzbLGCwClp04Q03P46gWc0NERgMzl3SqC6dD+X6G2DwHK7domnwdT0AmhuWCCefidWu8aS7Zu5JWF3JlPhi3nfaYggWrJEYD3Uvvwn9CIu3lvFaSliPoWDSLv2zw9tiPcwfHZPASEOLN8TybSGN/uPdj6hQ3TVgK/DU+qZyAieC2hfIUgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by DS7PR11MB7805.namprd11.prod.outlook.com (2603:10b6:8:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 14:26:29 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::8227:fa7e:8d8d:df1f]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::8227:fa7e:8d8d:df1f%7]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:26:29 +0000
From: "Kolacinski, Karol" <karol.kolacinski@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v3 iwl-next 4/4] ice: combine cross
 timestamp functions for E82x and E830
Thread-Topic: [Intel-wired-lan] [PATCH v3 iwl-next 4/4] ice: combine cross
 timestamp functions for E82x and E830
Thread-Index: AQHa3nahSqX7dPpYBUGbV0ImdnXrbbIJBQeAgA/HGUSAAxmhgIAAAUYo
Date: Wed, 7 Aug 2024 14:26:29 +0000
Message-ID: <IA0PR11MB8380B6EC30AC39EAAC1F480986B82@IA0PR11MB8380.namprd11.prod.outlook.com>
References: <20240725093932.54856-6-karol.kolacinski@intel.com>
 <20240725093932.54856-10-karol.kolacinski@intel.com>
 <ad94e165-ea7f-4216-b43d-b035c443a914@intel.com>
 <IA0PR11MB838091A67C0AE3598BFCDF8D86BE2@IA0PR11MB8380.namprd11.prod.outlook.com>
 <e54793ef-f81c-447a-8cdd-bed97df65f2e@intel.com>
In-Reply-To: <e54793ef-f81c-447a-8cdd-bed97df65f2e@intel.com>
Accept-Language: en-GB, pl-PL, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB8380:EE_|DS7PR11MB7805:EE_
x-ms-office365-filtering-correlation-id: 517ed2c1-ee03-4d72-4aab-08dcb6ecedd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ajWUUAtND7h8UvmIbasN0v/Njfv4qpdfAynEANypMPBoUfEo2BkT70ZAhM?=
 =?iso-8859-1?Q?YKkZM8p1+s5M2ITxw4Etyt0pHQfHDyUfM9hz25t7eAbPPM/kDwGd5pMae6?=
 =?iso-8859-1?Q?f7mTTvBj1zY0qVcD1VVncKsebktO9J68sRs1FQNYPhqpBjfnPrcQWleC2d?=
 =?iso-8859-1?Q?nBf/jTShCn75RRCl/d0A/APZk4LaPYddtjcvx0jUkcSYLGPdfoW6EqpvQg?=
 =?iso-8859-1?Q?L+ZNDj0ingzC0007O9D5l/sMbiljFKhTdcFC7o/j0+XQN2+mwXplZR0xej?=
 =?iso-8859-1?Q?UlxV6ZeAzgcBbXsNQQlmtkawgYXtgTPRiQzBPmwKIkB6WaZ/CfZQTgv5aQ?=
 =?iso-8859-1?Q?OOgh9yogyuHOW+e797gM1GvDpI96g6BjbNEJVGYwaH6LBPV46frjBplALZ?=
 =?iso-8859-1?Q?wRxZU5xQDY97Z3ct40JdfEogzicfvluGTO2c5X30wyCzr0elTy3MgwaOe/?=
 =?iso-8859-1?Q?7e6gEkhxH9VS1etq0eJVvf6G6NfSbmcBemfzTfS6kBB/bACM2PVX+M6lV2?=
 =?iso-8859-1?Q?IPlAOt+a1p6/RLkhP3Pifx91InOObcuWa1wadRnJxHQuxOk+EjiXeYoJCr?=
 =?iso-8859-1?Q?2lpxvrzgHUSkhdRo6pM/t30MGTruKM7tT0MC8YOGdvYYRk0W5GaAzF/CdQ?=
 =?iso-8859-1?Q?ZkiPh0pj3Ypuznwtd5Iw5nrxVBdQcQMWqeGH9KZUGB91hC6tBogeorkmcN?=
 =?iso-8859-1?Q?uhDQKwtfkNaqDQ8fmLv7APZ2r44g80NYfWprttwrJRawrkugDzVpNtklKW?=
 =?iso-8859-1?Q?nZww/PEC8bmO/oGil8u82DtOcOeknZXHsHeoGnuokpTqCkL5Ns+ffAN4Vn?=
 =?iso-8859-1?Q?L5Srm/DSCn17yhNYxLKhO1U9FZfCHxhq++9OVVziJTiDYsGJaW/ovZNQLV?=
 =?iso-8859-1?Q?1nrmy/2J6lI7X621wKBcNw9B7MxAmYEbd79bkN2Zu2oghTVru4gb9ij6+e?=
 =?iso-8859-1?Q?GeZJ36sT+eORfSCkB3ytwZV/2x3RGTQuEKl/GhJ6TzsGhJU0nrElxw2D8G?=
 =?iso-8859-1?Q?ScRCEdy7Db7bXAow5Wc0H4WQEPdi/z9TWEDR7vFHPBTMospBbzr+lDripA?=
 =?iso-8859-1?Q?yNL5gicBnuG17fuotprUq4tJCTeyEzEMp3zVgtlwvIw34sXJpFcq5yBF/I?=
 =?iso-8859-1?Q?aoM9D108zrxeBXqkiaWC+H/oyoA7xstfgRIegAyTJzGUHBfZo5o4u3Kn0L?=
 =?iso-8859-1?Q?PiCSwBRMnpsKZgZikZlIFlpQzghXvQF5MyiPhU2QjgYqCej9AMbuzIftEZ?=
 =?iso-8859-1?Q?w6ZX1FBerCyGXwSSodpvlrf2y7ofIsJdJNHnWGuTOsTst9TU5kk4rboB/6?=
 =?iso-8859-1?Q?v49OV7XHi45+rBJWojyZ3T8tZuB2cqJJzIEKy3T2ADMnQsBd8s0U2VO3xf?=
 =?iso-8859-1?Q?a+wSC5eFx8Bs4+6Zrb9U+BcrFHbvB4yxmquAizcF7cD1ULEN3zFnlDwxl5?=
 =?iso-8859-1?Q?Sq/2boDtB8m+7uLqrTCmPKiN55eU8gOB7cLXAQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LSGFTYjif4Sjr5QsgnW/jxuTGkO94/uby6LMJg9UcIHUA8kT+T+bGQWkIk?=
 =?iso-8859-1?Q?C3ZNmoWdrkjO0tSFjuRqMj96eV76p5GCmz6dZzofXP/pLOQAZy159tXZpB?=
 =?iso-8859-1?Q?deSCCIULkQeIYQZX1K0Oc7g3Pgwr5mKkhDZaVYXIZlwXWHjoFZvXdXwPtk?=
 =?iso-8859-1?Q?mhma6j3IE1drgURJAhyNiOzP7f3QJoRKnPT9KfEu4s47eRE3jJmYbrw00g?=
 =?iso-8859-1?Q?CL5DxUpP9O5uSIS92CK+/uB8H/d+jqmtEz7y7gEznhkGrWMiNzK+/a/KOq?=
 =?iso-8859-1?Q?f2FHkhYF+ZqBmpxKIV2FrGsu7srxb9Vss3003rK4UC7RHka7bORIFDcjtp?=
 =?iso-8859-1?Q?2cuk7tFrY6Jl+n933C86ncB3alEdR6fBBDskNkFXK3H3s0aXmcfk81Gmlu?=
 =?iso-8859-1?Q?ILWeRWSkYyupEqngt/vlBxG/uSkJhP4djYXFME7cyTKgPpUWPea6/ETnk/?=
 =?iso-8859-1?Q?glZ23fcQIZj2yjjnkmmmf0NEFl3m6qZu2+rRSPXm2i7g+rRTNkonMjAPhp?=
 =?iso-8859-1?Q?MOZDFr76M/QU4JkuPSD0eG1SvjVhRufFqXLfWyeivf5Sa8naxeO1sp1x1R?=
 =?iso-8859-1?Q?6kNDk9hJe9OCtR64B7gkyMvm2toC+tqoHZASDazqk2M8lxmK/hOfvEjqSj?=
 =?iso-8859-1?Q?PdJiP3HvjOFnKdVFDfwyzGo9UUTrmWB+lYxDQolIZres5Dl8L90TBARaji?=
 =?iso-8859-1?Q?J5jIg7eHAcviqZTiiLzQLILyu0OyZyC8vHFEXk5gyYVuoAEjxxqzrzexHY?=
 =?iso-8859-1?Q?p8EXUC5ZzFlGB1if2NKWE5Do4QGqTlmo2E3lv8Gr/4hdfV/4QaEs9ieUvQ?=
 =?iso-8859-1?Q?+3igp1vTiA3SFV/u9mpXUC2iPU2SLyGkasZQUSN/ZbnwlhaOIr0yJBRsGS?=
 =?iso-8859-1?Q?eg8pa2zs+W2RneeAzQD+pueshZUcaxfTnmF1SNQ3sV+6IiJDDEl+PRDrWg?=
 =?iso-8859-1?Q?nLijJibj42KTHowfVcDiXVbr2F1bblS4HxTSJdyxnsN592L4epFDc+wfV/?=
 =?iso-8859-1?Q?GDPdD6zHj53A1ptzolhvtL/4iH9kT+kNVyYZdsli/Dbw4MZQX89dsHor9x?=
 =?iso-8859-1?Q?Y0JPb5UG11Iwzms66+E8PeOscS7CLLD19Dfe386hO7WQ+I1va15cTg0SHY?=
 =?iso-8859-1?Q?UIR3vC4dLoXQg7JlxD0xccvZl2FlkNOSpgzTrD0VNud/THQTC/xmYF+j/t?=
 =?iso-8859-1?Q?QI5i7QfMzZtH3jTFcbrVPeBBZj1tJzi5lGfelQaVq41pxMUcF/R7QyY43n?=
 =?iso-8859-1?Q?dxl4aS2Qc/0GtTAbp7W19wC/PW4sF/Y3OYWf22W+B6opcfVjbN4YWiKGw7?=
 =?iso-8859-1?Q?tQyAIyy8j0T9hINAzF1wsuJC0GREJ+N3rgrzrCYw+A1WNI5YWVwNv24WM8?=
 =?iso-8859-1?Q?W8RdC9m97m+sPEfJu1NLzOtXFe8+vZwZr0aOdg25sT+oTB4MxLYKiLhAyb?=
 =?iso-8859-1?Q?OXKyEme9w/fF5RsPyva6yRPpOLyFKXWVVIfDB9nWmVLKnEO+iiJp8jmo8i?=
 =?iso-8859-1?Q?LwBmxsqN5vO2dIwsSPf8YMLlKGVPT3k8a13OBCeF8KaMjAjWH5caVv60u+?=
 =?iso-8859-1?Q?4U1CV3Urlk2jM5q7AEyxSZvX/sJ0OXKnZl1py+eFaXpsc3hYPl8krg6tVO?=
 =?iso-8859-1?Q?vKcjaD1UzIK5s2lBLrwlRAtUfhT+/kWpe/Gy6CEmAHjQuZIEImAy8UzQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517ed2c1-ee03-4d72-4aab-08dcb6ecedd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 14:26:29.7986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vt0kWJ1fzWU32acFpCUTl6ScgVluQzKiHVQEVSnoZzHE4lw1JQNXQKBxkdk8oCtDqbGSqODNTIzXvj/ibIGPxZMqU9AH0nS505oDKbCMBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7805
X-OriginatorOrg: intel.com

From: Aleksander Lobakin <aleksander.lobakin@intel.com>=0A=
Date: Wed, 07 Aug 2024 15:54 +0200=0A=
>>>> +static void ice_ptp_set_funcs_e830(struct ice_pf *pf)=0A=
>>>> +{=0A=
>>>> +#ifdef CONFIG_ICE_HWTS=0A=
>>>> +     if (pcie_ptm_enabled(pf->pdev) &&=0A=
>>>> +         boot_cpu_has(X86_FEATURE_ART) &&=0A=
>>>> +         boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))=0A=
>>>> +             pf->ptp.info.getcrosststamp =3D ice_ptp_getcrosststamp;=
=0A=
>>>> +#endif /* CONFIG_ICE_HWTS */=0A=
>>>=0A=
>>> I've seen this pattern in several drivers already. I really feel like i=
t=0A=
>>> needs a generic wrapper.=0A=
>>> I mean, there should be something like=0A=
>>>=0A=
>>> arch/x86/include/asm/ptm.h (not sure about the name)=0A=
>>>=0A=
>>> where you put let's say=0A=
>>>=0A=
>>> static inline bool arch_has_ptm(struct pci_device *pdev)=0A=
>>>=0A=
>>> Same for=0A=
>>>=0A=
>>> include/asm-generic/ptm.h=0A=
>>>=0A=
>>> there it will be `return false`.=0A=
>>>=0A=
>>> In include/asm-generic/Kbuild, you add=0A=
>>>=0A=
>>> mandatory-y +=3D ptm.h.=0A=
>>>=0A=
>>> Then, include/linux/ptm.h should include <asm/ptm.h> and in your driver=
=0A=
>>> sources, you include <linux/ptm.h> and check=0A=
>>>=0A=
>>>         if (arch_has_ptm(pdev))=0A=
>>>                 pf->ptp.info.getcrosststamp =3D ice_ptp_getcrosststamp;=
=0A=
>>>=0A=
>>> It's just a draft, adjust accordingly.=0A=
>>>=0A=
>>> Checking for x86 features in the driver doesn't look good. Especially=
=0A=
>>> when you add ARM64 or whatever support in future.=0A=
>>=0A=
>> For PTM, we check only pcie_ptm_enabled(). PTM is a PCIE feature=0A=
>> supported regardless of arch.=0A=
>>=0A=
>> The two other checks are for the x86 Always Running Timer (ART) and x86=
=0A=
>> TimeStamp Counter (TSC) features. Those are not tied to PTM, but are=0A=
>> necessary for crosstimestamping on devices supported by ice driver.=0A=
>=0A=
> Ah okay, it's not tied.=0A=
> So, instead of asm/ptm.h, it should be named somehow else :D=0A=
>=0A=
> But this X86_FEATURE_ART + X86_FEATURE_TSC_KNOWN_FREQ check really=0A=
> should be abstracted to something like arch_has_crosststamp() or=0A=
> arch_has_tstamp(), dunno. Maybe to the already existing asm/timex.h?=0A=
> Then, implementing this for ARM64 would be easier, as instead of adding=
=0A=
> more ifdefs and checks you'd just implement arch_has_tstamp() in its=0A=
> timex.h (I've seen Milena'd been playing with PTP on ARM).=0A=
> At least that's how I see it. But if it's fine for the maintainers to=0A=
> have arch-specific ifdefs and the same code pattern in several drivers,=
=0A=
> I'm fine, too :D=0A=
=0A=
Technically, neither ART nor TSC are directly related to the PTP cross=0A=
timestamp. It's just the implementation on Intel NICs, where those=0A=
NICs use x86 ART to crosstimestamp.=0A=
=0A=
For cross timestamp on ARM, it's also HW specific and depends on which=0A=
timer the HW uses for timestamping. I'm not really sure what's the HW=0A=
protocol in this case and if e.g. E830 can latch other timers than=0A=
x86 ART in its ART_TIME registers.=0A=
=0A=
get_device_system_crosststamp() supports multiple clock sources defined=0A=
in enum clocksource_ids. Maybe instead of checking ART flag, the driver=0A=
could get clocksources and if CSID_X86_ART is available, it would assign=0A=
the pointer to crosststamp function, but I'm not convinced.=0A=
=0A=
Thanks,=0A=
Karol=

