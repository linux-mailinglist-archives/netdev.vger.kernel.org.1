Return-Path: <netdev+bounces-133747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B49996EC6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4395AB2208D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE4319D8AD;
	Wed,  9 Oct 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oG4e9gXP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8219DF5F
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485526; cv=fail; b=hK7Unmo018JcRA6SayP7317wsYvLn8kFlryD66wL4SqBVwTCooHSYiAmSeboNyc5zo41Hs3crFkJKKAkhnbdbixBNW5Hjt8esAfbEhTPkErvkpjppKd4qk7peQaJP0kr+HjybL1zAVcgr7+BwE5g0+YzqRyFbUt8gnDG3y/Sito=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485526; c=relaxed/simple;
	bh=hvYMiDfDeslmME82qWR8Zz042TT7RHiumHEk3+3eu2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p9d5LPSWLR5+2l5pamgb/tUpsmj63Rd7SWGjC3p45UU3Xo+FCVmR53595N0iRPohgYM3fZ9ed7y/ObA2NuoRE+rwVnndto5V+gBAd1x9nk410cp/Fjp1f2OLkysDIWO3m1uMUjscNL9nmym9frG6ZBpwpXa60PXAeohwElgejlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oG4e9gXP; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728485526; x=1760021526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hvYMiDfDeslmME82qWR8Zz042TT7RHiumHEk3+3eu2I=;
  b=oG4e9gXPRXfSCl7fbK1ya7LqHpf3NQD0Rg6NPvO/7cEndQ8YvMeTgcD9
   SPp1BFNhfW2SjftJX6MqlDi41Tf5pMq2ohAKNHZAQzwKRTuxpBueKPsNq
   Fbu1WY+9MNMXlbvgFQFW/ABkI2n2a/UFKMbY525W5UuvrVQfdG7RT59am
   flSgyKRxMEM8hDAu66I/8r6IrGM47DPz1R4ro1lGsiGl8Km+4NWI5guW6
   th5y6QhVdjSeH1anUHr7uNN5I9KopeohocGdwRrR1Lg0Eg5y2dTs7NsKt
   Fm0FJ46w59BY9+AwyVcvK92Z0ogTYYQncbetDEOgE63rQq42rn2GtdN36
   A==;
X-CSE-ConnectionGUID: L4wT6I1nRtS8MFTXBf4M7g==
X-CSE-MsgGUID: 9B2fqBzUSS2XAX+K5or8JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31489748"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="31489748"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 07:52:05 -0700
X-CSE-ConnectionGUID: 2F1XkwGvTHWvXVoVrIyXPQ==
X-CSE-MsgGUID: ZgyRTKvkTvmmJbrpGuRl1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="76171532"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 07:52:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 07:52:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 07:52:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 07:52:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjPmzY2hbqPYquWJko2GE+R7LnQx2i9QW6JViy+xZjeLjX2Q9NPtXPaxOBcPnphd80JlxgqeZESqnkvE0otnadxUUxei9759ofgf6/CGz/yDVwcr49I5LzHGtsBcPeJCr4ArJJFhpTRRI2k/hhTaK33gt3SyLtrpTiqlYTCPQuw5z3EKxFyYsv1MAl+89Uu9qisZ1luHdqOzXPUzAbWXZIehHFa5B7tIfDJEUU/exocN0aUWp5WSJbGfa9oCKYcC6mI0PDLaxaF3tng4H077wxJU8OJCRVLVtmKMT4bxp4TqSP97STKOReywrpxaBLnYjost3nD8x/YS43FaGhcf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdtI0BuDODkbnQLgQsOk/LW/JA9LGBhwMT6G7pnwBEM=;
 b=CXose3Ie2Hm91wXTHwp2iEr5hd4HZaaMxe9VuL1xxLORAAxHK8/4tXRquVCzIxsimyW+lDTwNIpXUpwtLXd/+MY4mqAlcKJLao1f8s1eIj2+LdeO9ViJLcB0D9D+g8eGnDdYqldrx8Yi+EkTwXbc9wah0RVXI6/xrdWveUwN7PRbl34dE2/Nez7JY6mmciQo4qEgbp4hxWgMzSQDroEIeeT14a/dvWmj159W+fZFyomTtuYNUZl/bnYgN7COUpvdSNPS0Z9UiZ6vVyqznyDiRuGagnizHKyMEajWx/MMoecKIBINujZNC3yb9ksLO3KO4ISq+nt/VySbHo6F0FvLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA0PR11MB7329.namprd11.prod.outlook.com (2603:10b6:208:437::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 14:51:54 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 14:51:54 +0000
From: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Marcin Szycik <marcin.szycik@linux.intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Brett Creeley <brett.creeley@amd.com>,
	"Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
Subject: RE: [PATCH net 1/7] ice: Fix entering Safe Mode
Thread-Topic: [PATCH net 1/7] ice: Fix entering Safe Mode
Thread-Index: AQHbGdYLr/gXHGh1/0G9eQbfTsNFyrJ+ga9A
Date: Wed, 9 Oct 2024 14:51:54 +0000
Message-ID: <DM4PR11MB61173CBB283DAD1C58775F4B827F2@DM4PR11MB6117.namprd11.prod.outlook.com>
References: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
 <20241008230050.928245-2-anthony.l.nguyen@intel.com>
In-Reply-To: <20241008230050.928245-2-anthony.l.nguyen@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6117:EE_|IA0PR11MB7329:EE_
x-ms-office365-filtering-correlation-id: 2c1dc718-ac94-4f99-aa85-08dce871ea7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3ayGUExgF1WjmZYWoiM+TGxN9zA36eICl3nptojST9Q7YoxoUMJQAW/RVIKO?=
 =?us-ascii?Q?Bu/el073SxNwYGYeVm6j3qVUKN+8JAUM+ihqtZ2u6yjjZ33bi7lN6Tf3r/rv?=
 =?us-ascii?Q?qPG+ZUph5blgGKl0qY5FDFXl9j6m5HZt7UvFrcQLLbeOF/sfX7/vydlfXwJ8?=
 =?us-ascii?Q?yaSxsdAwGU/GMOBy2x5wBJBBRWUr0eV0WyiwCYhpcrRRCrf+UdGGq8+Wta0a?=
 =?us-ascii?Q?FfP2Q91ia3tc59n8VB94P0LLs/fn51A4gnOu/DM20SdrLPErSn+jInQO0YyG?=
 =?us-ascii?Q?dYxIM+MPNFk0QjZ4fITgMLcCvBa1d5cjHZzW8+6K5ijnHiBnhdxZs0RZHqax?=
 =?us-ascii?Q?/EfUZOctCBg7fVFx8D6hlPsYxMpEvnphfZudAY/wCt23ZLBQV1dP0lqHUNbK?=
 =?us-ascii?Q?b2rsO7ZsbTYPtn/9ObVnbyvLkP3SaCwAigeormGs/yk87nFnhESv55bD7cxG?=
 =?us-ascii?Q?Epx5/FMKHZlaZl3csqdb7zx9S/rRZN0BLzvpl2ioJ8KeLWVco/jjxQ1pT0Pm?=
 =?us-ascii?Q?ctHsj1Fy+O40yaTFho+WBMZ36R4BAjE+EnRmg83b81yluAqyrZteyQAmRoIs?=
 =?us-ascii?Q?vXqxAYwmlAOHGB+a2JbccQt8/XaOdzUtOPG21bR81ADH3upY3W4SAeJV0ley?=
 =?us-ascii?Q?eJK1ckuZeQ1vFCTfghuao3xoO8nniv9t++91AR5d/Pogt9xaN3Q5oJrxEwp9?=
 =?us-ascii?Q?uagcPfvrelvDhoR3prt/aIo73SfNsHjRrXK7wfJw2OTWeWTRFcQf1nl8EjdP?=
 =?us-ascii?Q?dSo4S+s+LsZ1JGFk4eQcK/f9RoOLFUWQ3WzggKpFyuFx0deAbOJTugK07jqO?=
 =?us-ascii?Q?Vm/hB2AkDlB5M63ACLAlgx8ikBZeUVeSUNfMdJH/nTQGIVmZ6BHvAwMW4CRr?=
 =?us-ascii?Q?bqjbRiKoVynsUTaP+HOYz3iCjj32StEF8a0fTI5faNI7X4dFNC8dchwJSq7c?=
 =?us-ascii?Q?1yyUqfQEj15OogMw/TbgWuGSItdgSiMzZXoEBmceOVWP9njLcPqItldLgSyt?=
 =?us-ascii?Q?LVgFJHOxmplW3oe+/v7UIOlCU72q2sKI+seLptmCTDd88JSji8Qn+c7VFyhw?=
 =?us-ascii?Q?mka13nRiU2ZweAt19mGcOJPsSON2FEAQBQs+h23PNIDajesRHGyDDWOQFC/I?=
 =?us-ascii?Q?uHk1Aw2zbf9Pve9Ht+9otpblwJkOUyPUw8eILGIt/w9AuFRzqzRo0Yk1f8Z5?=
 =?us-ascii?Q?8vbVL8p+lQ5bL5d0fxHRxfm04YRmijoMkdS5CRzOYWPYUxwYYmCBG7YT8xRl?=
 =?us-ascii?Q?+5C4kLJ4ZqRuhotFcUKN2czQV+Rr+Phn9lg9laVIGYq1ufVcwqGE9DUn8czo?=
 =?us-ascii?Q?Uye1gCVq+HlNq3EnHT5+TOGjIfuMxZPMzML6PKildXjHCA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+tkBP96ns/KCFurco5Rsn6DGx05nOGMyZG597wN7McBJtsBfQaKFoUjHNFw6?=
 =?us-ascii?Q?l3vuZCZEU5zzUloS6GKAkB94NV4MHdYOET5seu/FL+tAh5NKOODCW7Nelgb2?=
 =?us-ascii?Q?pqCrlPEbHf++m05xbq7Uh/K5J8cBhrZVi0vQrwa7NPD60clXIetMSR+sH+TB?=
 =?us-ascii?Q?Or3LAdGtzNVFMRIGgTyj9CFEOQ7ZbAKp+p+0Sr9ngRDe45TEZf5bW+PuChMu?=
 =?us-ascii?Q?cFRZpwNENw6+4zV8Q3foWFvS0eNEzpjtU9c7qCt7sxlX8zQ+uQ9fbsIgsrrs?=
 =?us-ascii?Q?/eQWEgs5dk8l2fAhvcjMNsMbAuoFp3cHLVMdMPZjW/XNGLM+JZ0S9D2SKrlB?=
 =?us-ascii?Q?VO3/AQhLw5O2M1tXRct8nFGpoCendoZS/BbA98c/j8NJugK1q1P3DXx7K5Xc?=
 =?us-ascii?Q?y+xxUmiH99TPB/oQBF/bbN2/KyoPqCRvqk/sMr5X30SoeT4HHMffP6BSbrDK?=
 =?us-ascii?Q?k2gIUBlWCNV/Zd4AD0NqJ+lO1Xt9fJpTQCkUjsLxw6KEGujz00JkXm2ISCYN?=
 =?us-ascii?Q?U0b3zLZ8QBbVdRlppUSDKEQIHYFBpTxyzHI9KjVVFh173swzeFdcLm0i6ipq?=
 =?us-ascii?Q?EVZjs3C39+1nCnO8AjbxKM7fNR/mN+dHgfpWwlT/Kq75+jKrGuDfmU6jTEeu?=
 =?us-ascii?Q?fGBVzJ/ug11evWh/IxeAhYGT7DcQmA5iZkh5uvd3F3Lpf7sv4I1arKN05UBb?=
 =?us-ascii?Q?hm2rJ2CvnWjsdCmt3MAf19S22ojib6Q5qIsJVhGLa7qhDmroOujKfllMlpR2?=
 =?us-ascii?Q?Uu6UJTds9vLoYYbv1Dz+26Eghb/ViRraFAkX2GI1IZ6+ETjQ0D+IgPPAfGry?=
 =?us-ascii?Q?Pr915E8YHhtyoDilIexcZEZixy/yz5S81p3j+OKbFAh1ZVuehQtqP/1gitqb?=
 =?us-ascii?Q?zHRw6QE/GO2RLXQex/cRJG9g6sTvwcG/VrB3xdwUZW/AGyqFih2FDykijgcp?=
 =?us-ascii?Q?DUZpMs2xwTKYThqvSiJnDHb4hmypSeNTaZNX2mhdCRbxxbG1VONtoX+J0rfd?=
 =?us-ascii?Q?JTHNBAWbX7kzD4KIi/V2EF/38oen1XPkSLL4/mI+pjjO/lfaqctg71tud+5s?=
 =?us-ascii?Q?xBBvASLPz6ry1uldtIJw+LVoQMa8LKrGp7iN+EvRHRNUJ7DBKb1Ahiz0wio2?=
 =?us-ascii?Q?kI/3mgQBLcqhd1Fw7ool66pnp87J4bCJOv/gjWhstLcfaOOjy+d7PrpF6Mnz?=
 =?us-ascii?Q?8/bHYOzoNdY4CDfGgIMkyBpedJZ7jkvSfp3V686uBmHBSh6RSv1+wLNyqeLp?=
 =?us-ascii?Q?MunGKzNuQhvT64G+SQKFVlopPqH4DrBPb2EEwpNUqgAeO6+PpoFrxbiPhnRu?=
 =?us-ascii?Q?03XB99IPxMW8++UZjzgabmbyE93i5AFVOSNlfGXgIiGOF5DrMBQNGR8fwd7G?=
 =?us-ascii?Q?c7bcLI0Qqp/7a/Lxpj1Vfo+urnmwFoRm7gJiXb5iZVHmV1PJwrXDHzJDHf6j?=
 =?us-ascii?Q?f0sbqvI092vsBjOpslVqcV9ZjhXjLLtj9ZD8Dj2yakBIg45ZDOCnh8aAlrgS?=
 =?us-ascii?Q?Lm1g5VyiJdjnyduzJY8GnpvV+0K0eEBaWQmd5cxOMDc+gWyEluNgQ3KssP+O?=
 =?us-ascii?Q?S9WHERERx7zkwLoADxH3Dlcy83b5kB51iE1BwFrxAIv1cQlCxPbX4ftUB83Y?=
 =?us-ascii?Q?yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1dc718-ac94-4f99-aa85-08dce871ea7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 14:51:54.2354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5BBc1rcCv7/BFfRx15IZ+AGtHPZF/4Z1NfHclur5UJiamTP1Z80B+PR6OXOic4V3uXRsnHdKsLSooouGDogBP0YeEHlHM0FcxrCH9EjPDmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7329
X-OriginatorOrg: intel.com

> From: Marcin Szycik <marcin.szycik@linux.intel.com>
>=20
> If DDP package is missing or corrupted, the driver should enter Safe Mode=
.
> Instead, an error is returned and probe fails.
>=20
> To fix this, don't exit init if ice_init_ddp_config() returns an error.
>=20
> Repro:
> * Remove or rename DDP package (/lib/firmware/intel/ice/ddp/ice.pkg)
> * Load ice
>=20
> Fixes: cc5776fe1832 ("ice: Enable switching default Tx scheduler topology=
")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index fbab72fab79c..da1352dc26af 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4767,14 +4767,12 @@ int ice_init_dev(struct ice_pf *pf)
>  	ice_init_feature_support(pf);
>=20
>  	err =3D ice_init_ddp_config(hw, pf);
> -	if (err)
> -		return err;
>=20
>  	/* if ice_init_ddp_config fails, ICE_FLAG_ADV_FEATURES bit won't be
>  	 * set in pf->state, which will cause ice_is_safe_mode to return
>  	 * true
>  	 */
> -	if (ice_is_safe_mode(pf)) {
> +	if (err || ice_is_safe_mode(pf)) {
>  		/* we already got function/device capabilities but these don't
>  		 * reflect what the driver needs to do in safe mode. Instead of
>  		 * adding conditional logic everywhere to ignore these
> --
> 2.42.0
>=20


