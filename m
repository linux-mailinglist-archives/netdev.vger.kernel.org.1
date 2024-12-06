Return-Path: <netdev+bounces-149817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3F49E79EB
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 21:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852A218831BC
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080DB1FFC5F;
	Fri,  6 Dec 2024 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8cWxEF0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E811C54B8
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733516109; cv=fail; b=BiMZjTpgBSuNfipKwur4Nki9IlUiCGWkNuZizLlEsBRVPqgmGm8lEyRwgG1vh+eDJY/B+jvf4IPm8rbs5bfgYOsRbf9P66Au9cPtN2TUzZ1XseASTL1IE3Sh12OBCrJkfxEdBd+IjB5LFGr/5QM3pWjs8OjWtdkTwpQW1lvEqqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733516109; c=relaxed/simple;
	bh=+ot1gkAE4eSmMxhbOpF9j7Bij++Mye+SIDKviveW0Pg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mlp3FgNHn4EURPBL4Z5e+ktOvE6X3KLqFA+ZlsurijJArdl5MuXnqHn7xsDCgLzc/I9+UIlbixUwYN8ihJjeQZRs7Hlfm4gjQ4v1vnDWDfz6k4VBaZRzaFFn6FdpKCCvgBzcnX29wIkLjDe3eLk3A1nVpgKDD+sY4SMKIoy6U4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8cWxEF0; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733516108; x=1765052108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+ot1gkAE4eSmMxhbOpF9j7Bij++Mye+SIDKviveW0Pg=;
  b=R8cWxEF0wD7bl9wWJh0ULIUZ/il+855FuKU5G46NUrr9MLDJJkXV7aEj
   lNHr79Ka/ZscgyeP4jwo68UaI9knKWmixae7oj+1jILBXbOiiu36/mpyy
   80657ixJvNnfYBiaPOZtgFzWwnaRhoriEbS9eH1AP5JYEFqVFoxia43oS
   m5C7yFHFnHu4XGebPBfzGqw4MKlEKbkLEcEu9mdiminYJp3tWnWtbxXeI
   opWrWl6AxmLd3xn8exZqwlz/ImgZSbgM3cCTH5y1Waw5tHfZWUkB3dcfo
   gumMhHfV6I/YzldSj/zWLDJREXiefiiw4RW2gQnDlC/FIa9c8Sg6eevsm
   g==;
X-CSE-ConnectionGUID: JCRQzqbsQkWkXFjXE/DQ4A==
X-CSE-MsgGUID: ldj1N4ZhQUq408JVhkaYTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="51415692"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="51415692"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 12:15:07 -0800
X-CSE-ConnectionGUID: KlYi5+l1Sbi1Zsyx54uvhg==
X-CSE-MsgGUID: BxDoT75VR1W6p71gBYm8Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="98566832"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 12:15:07 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 12:15:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 12:15:06 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 12:15:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFquJrnooHDm5ySvjHygVurjSxoxLmwaBGwLGKBXuuV7cbhTEFjSIU2bMvfRyEQibWRQHOPJ+PW4ltsjvTcQ0aTmbTakW9gsaDO5Ch0HbWZrZ2mqls0RBD8fygFItQcq+3lhMXyhv3MZb64HjhyYMWXzMtwnso6oeBNvhZ0ROPP2pwzbQpAw/5XnCR7V0+Q+qPs2wXWA0LZsK4H0YGOFKRZErP4hymnNh1QoI6pN6T9UD7kxYr79N4oHgVZ6/oPeI3i8aXVOqs3UKjM0TwfBsDONMOchkJIT3Q38Ms0dTgttcJdbW4VtuagAjcCkcoD8OJHTlSoil9lmBQNaUQqNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSlL0pCAxPSkcIJj8to8pSUghKtnbiFi6lqTccoP/lE=;
 b=VzqONZa3oOU7+16bfGFt6RewLR1rVPBuwJQkJr1K5XK0cpX6GifUHAq5Ij8R5wK6A5xoUB3G5FxWQJ8ba6iy64sd1NVkJY7SOzJ6RbsbuKO7+GeYE53MVHDszDvJmM/JubF0zg2ISlt+dicntcxChVhOHZN75cDftezs/ydhYs4FiWf0IiPlHX6XVoRBvJ0lCAigeZZ6aS9cNHJeZ741+xdPZa3k0kTGrS84A/SK+d2DUI/9HEP6P+ie26Asr+Ta5J0KTJ1qiMsrKiYICDgpO7o04k7A0JBgoAw3yYvsh/vCBYDTmmLovbXAif+7g2ZkgjRsjJR3UdEXjDSgP4GUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7652.namprd11.prod.outlook.com (2603:10b6:8:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 20:15:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 20:15:00 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Simon Horman <horms@kernel.org>, "Nadezhdin, Anton"
	<anton.nadezhdin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>
Subject: RE: [PATCH iwl-next 1/5] ice: use rd32_poll_timeout_atomic in
 ice_read_phy_tstamp_ll_e810
Thread-Topic: [PATCH iwl-next 1/5] ice: use rd32_poll_timeout_atomic in
 ice_read_phy_tstamp_ll_e810
Thread-Index: AQHbRkVbN0XbuaJbqkCKgvmuSjzOfrLZOV6AgABw6CA=
Date: Fri, 6 Dec 2024 20:15:00 +0000
Message-ID: <CO1PR11MB50898F72BE794A0187649EA3D6312@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20241204180709.307607-1-anton.nadezhdin@intel.com>
 <20241204180709.307607-2-anton.nadezhdin@intel.com>
 <20241206133003.GQ2581@kernel.org>
In-Reply-To: <20241206133003.GQ2581@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DS0PR11MB7652:EE_
x-ms-office365-filtering-correlation-id: 2cdfdd14-f1b4-4db1-1eb8-08dd1632a989
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+7lod6cRzH7dzaGXgcufxNo5j90z4tcOMx+uHoR8xzOplnX5HE71XRkPAlD0?=
 =?us-ascii?Q?EBO/yMWurvj2K6+XGr5zHKqHoF9zMX9Ugw/UbQN79gmBvU3FImLeYI78Rs5g?=
 =?us-ascii?Q?Vp29rVWKhs0gTqfUaJ39s+fk6gAHjlQYKh7OhVy8HsYubrelKn6QZw+A9KSb?=
 =?us-ascii?Q?3gB/v3Gldgb61BwFtvNzFWeppr4YmavayGTutVm4a7XK7esTbpMCdj6Ot4+r?=
 =?us-ascii?Q?RdadgS3Zi1PmpGxlCvl2HMnKiSZm+6q6PH3QTNkKj1yaTAZNzDKyANxh7+de?=
 =?us-ascii?Q?VKiq4XguOuQi3+i/pDNC0xeeg61au2fbeHWgTBHgwSmm8eDh1oQCgu0KRQ4Q?=
 =?us-ascii?Q?5gHXu9Uzt0vCE5I7nb07WiHClChM3Y0OrEqPnnGBLxpzpZeVJ7FDky5uwBmk?=
 =?us-ascii?Q?KkJRvVwDcnjJwwrgv4vKWrwwsJWQeSc38nJiduROLHvFnqCBa69XG+AMF754?=
 =?us-ascii?Q?Tl+tuT2BNt6Swl1jxSe5zX8ounRDViE0JarE4w+n1aHgTKMkFjgumg1hEXxX?=
 =?us-ascii?Q?tOYzUpZHUlzL+ULRf9ppgRp6SUg0sJw/Ktk0vaaQ1YuRSQLMfVKPY6QmMQGR?=
 =?us-ascii?Q?KwlkNvNjLNsiht/0HM3bxubpmg2WDK/qkVpuBuCNKGBaKdozzwXLBPRVEDGk?=
 =?us-ascii?Q?S8mVOH7fWgKHIhmde3svpmk0rkZTOQmeDh64A2NKWx3H5pVuAuGLrVF8ZlI4?=
 =?us-ascii?Q?OOBtWKOwCKNosqCTgi25LCxpiYztwq0Lg5QIEf56sDbkee4odU1eC5ubicrS?=
 =?us-ascii?Q?rcPnVl8JMC2UkhxZWgKqesBffTmcybWbwkqnX0tac70oeOYHe9mcKqnKUUCj?=
 =?us-ascii?Q?FF9OP/4blgzMuo2aT5COjEJ4e7ciHTmg5/USYbmZohVDeGWIRq7nRaD7iXfQ?=
 =?us-ascii?Q?yVuBRC1Kw9/K9G6TxJkOvmg1U9cf2CfnzYNZr/PGqygSFZX4CGWVsGcZ0rvg?=
 =?us-ascii?Q?Odtjs47fUfUEXrjzyqO6duE7evs7NpLRZDTJUk3JUmnNF5veMc3LW6CzeScT?=
 =?us-ascii?Q?2Pw3RkriDkIP2vOdJfgnAImeuSgJu7RB4WSsy/GiarShPKEJXtfpklKRWml9?=
 =?us-ascii?Q?jlYCQh/knlR/Gl4qt6mLouwngzL66t5tkOJNEXP2qINaqC13DB30lRGlF//I?=
 =?us-ascii?Q?Nt8Thy47OYZiFMD4PiPSpOVEV8m0sJEcwFSD8Hngc/jloBBXfnpzos4N5W1K?=
 =?us-ascii?Q?ic4YzGO2BFqHR+WiyopGSwvBNVPqOTB9FbzFCAORG/uK5UgIa+AJtChUl5Yt?=
 =?us-ascii?Q?IyPSYBJW49Hmq0SnypsUeU8pt8PDn1mGAa0NOus8einqPb4hGWWhyIdYsGVv?=
 =?us-ascii?Q?LaPp+Ps0U1IRJSRdRLiGrIGwmWw3ZGvDofR+5L1EzPUEu8K16E213JxmzGcB?=
 =?us-ascii?Q?cEZULV0I6QxhO9CvEP9FUXqDdWyJDz87dn9j/3TYA+1YLBu4Lg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bm6F+OMjFO7X1HXX6vqmvXZzknb5wgDfrJReDrCkdGxWG+U1kNC/b1gG9uV1?=
 =?us-ascii?Q?LoygCkDvCZn1+doTwNlsDKPQBHztT/G3FUNP0jvsffO3g7csE9Fd1MTfxrNr?=
 =?us-ascii?Q?gzKyibTaY/IO5+3k6r0zU06uoXWGWBu3LykStbeS1q0aYvgl6A5/iGHeVosA?=
 =?us-ascii?Q?3VT2WWxggIujsp9CY8Hgb/tLrAkfEuwpkXpEmk7cEPVW5Jrjm3ri6eKjSd1I?=
 =?us-ascii?Q?zKwxOG6EVn1/dGoFnj9LHCLLInnUit/Fk4Aw6c218tSIlDDjKhcg28ZU/BpW?=
 =?us-ascii?Q?zA67zNeYWMctEVf/4FvmTO5ryi+qRVyYQ+S/FhCcXNyLDJK6jxS8TQ9rOYlY?=
 =?us-ascii?Q?5gyodJlEJ3itrrUONW8H8Sbcf31XySd4NiNZlfmkJrldMaAeEeOr2794s2LF?=
 =?us-ascii?Q?6xCob43c1DBpxHc1gCMwsDgang3qT/YKvJm7j3qOyyjjqxnUgOfCdXEa34Jk?=
 =?us-ascii?Q?DGqflJ2xXHzkz/Nzn1JJ0K/AkVAx8Yy4EO1CJ0l42wgyBlLHcvlLZix/HvG6?=
 =?us-ascii?Q?dd5gB87SjTOo2iuybEBMrsUMK6o89t9XkoREQeMOsA3zcxd1TkbyfJAMA030?=
 =?us-ascii?Q?P0afMun2deQ3DaQ0cLDYAiGdwzY6dkdBfws3mqJ8vWTfA6tQFd5N7cXRLWKy?=
 =?us-ascii?Q?29PgzoAR3lBS4czypl3F8WrlfFhznrY7fTC/UimKe6SRR7Cr8MNuK5mkpTfx?=
 =?us-ascii?Q?8eBjRwmCbZaeFYBJLZPGQmnbgRFg9aojW/cNkfnOw2Io3PgDgwpTFm4rnsVC?=
 =?us-ascii?Q?W8sPWpf4tcECrXyZI5XX8n+5aZ2tj5NYjNtXyRRTf2MNN+4oH0nTaTRrJnhx?=
 =?us-ascii?Q?uskHixoZume7Em5ElzcQIkakYtSyBDDfGuuOTmpTIkLylNaC0evKgxLsioA4?=
 =?us-ascii?Q?d9s/JyhUWm6ZPYZiiQEKW+ZxW2aHrXTukBh/cOaMYgEaQzsnw8uFeQN8aElv?=
 =?us-ascii?Q?QDgkMQeH0QqRMusf+7lcIa3hEIutx4FM++m9TdNMbJx1a9JHo+Gqc4ZncLIk?=
 =?us-ascii?Q?xMMZWKJNanqK90m0EiCniWYdN40Lgk1PcRivyIwHJa7BbrXOfAuiPEOljbwB?=
 =?us-ascii?Q?7C0vnGE/O+KcV1vhf+Qm7y2Jci+K4ySReZ6mNBMPPDx6jU5Wc+U4qvjyRDd5?=
 =?us-ascii?Q?+QzoeLzyznFODeTyH+vJILK9wt1Fuj5EGBWuQIkATbfMf/oj868HbgwKKIUc?=
 =?us-ascii?Q?o1vWdL6QSGsNalT1RlBCfiEptL/cMvX+c6I/cv//EwDR4S+JhDBDQCGsc2AP?=
 =?us-ascii?Q?QGxwVmN3ivszLy67oEdHHkFasis+icXQZ4EWU3nrY/RhgYsCASE1ktlk0waL?=
 =?us-ascii?Q?Btis3E3YLBq5/1OVKhqjJFPuJb/YTxz6HSfsve8Ie3yj+jOPugfX6U3G3Txq?=
 =?us-ascii?Q?wt8prWa5u+K16ccFOBLIXTpoVUods+rNvs8A+VZxm71iZfQXSg+h//9yzWFG?=
 =?us-ascii?Q?ILEb2ECaiezJEG28picevzsNiF23081Ka6Ms/OjFqhHT0H+HT3tS2g+fa9QC?=
 =?us-ascii?Q?dZbd0LJ8EgHwTWuOF8Yl1Y3CMUIfYNBHnWhX+nIJb4U81WIUuL+MQ/z4ZaPZ?=
 =?us-ascii?Q?CPSF2vHm6xVx1U9pqyqvrNpMSwNadfDSA3Dmns3H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdfdd14-f1b4-4db1-1eb8-08dd1632a989
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 20:15:00.4888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKdEHDtQ59u3bY55KYP3qFpkTYq9sStBZtPf8kWw01v4N1tLVwkaBoYx1AsGbsysADwzzpLhwVxWhYeqGK/eMAdaCqa6FrD+clkatjUB0Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7652
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, December 6, 2024 5:30 AM
> To: Nadezhdin, Anton <anton.nadezhdin@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen, Ant=
hony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; richardcochran@gmail.com; Keller, Jacob E
> <jacob.e.keller@intel.com>; Kolacinski, Karol <karol.kolacinski@intel.com=
>; Olech,
> Milena <milena.olech@intel.com>
> Subject: Re: [PATCH iwl-next 1/5] ice: use rd32_poll_timeout_atomic in
> ice_read_phy_tstamp_ll_e810
>=20
> On Wed, Dec 04, 2024 at 01:03:44PM -0500, Anton Nadezhdin wrote:
> > From: Jacob Keller <jacob.e.keller@intel.com>
> >
> > The ice_read_phy_tstamp_ll_e810 function repeatedly reads the PF_SB_ATQ=
BAL
> > register until the TS_LL_READ_TS bit is cleared. This is a perfect
> > candidate for using rd32_poll_timeout. However, the default implementat=
ion
> > uses a sleep-based wait.
> >
> > Add a new rd32_poll_timeout_atomic macro which is based on the non-
> sleeping
> > read_poll_timeout_atomic implementation. Use this to replace the loop
> > reading in the ice_read_phy_tstamp_ll_e810 function.
> >
> > This will also be used in the future when low latency PHY timer updates=
 are
> > supported.
> >
> > Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > Reviewed-by: Milena Olech <milena.olech@intel.com>
> > Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_osdep.h  |  3 +++
> >  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 30 +++++++++------------
> >  drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +-
> >  3 files changed, 17 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_osdep.h
> b/drivers/net/ethernet/intel/ice/ice_osdep.h
> > index b9f383494b3f..9bb343de80a9 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_osdep.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_osdep.h
> > @@ -26,6 +26,9 @@
> >
> >  #define rd32_poll_timeout(a, addr, val, cond, delay_us, timeout_us) \
> >  	read_poll_timeout(rd32, val, cond, delay_us, timeout_us, false, a, ad=
dr)
> > +#define rd32_poll_timeout_atomic(a, addr, val, cond, delay_us, timeout=
_us) \
> > +	read_poll_timeout_atomic(rd32, val, cond, delay_us, timeout_us, false=
, \
> > +				 a, addr)
> >
> >  #define ice_flush(a)		rd32((a), GLGEN_STAT)
> >  #define ICE_M(m, s)		((m ## U) << (s))
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > index e55aeab0975c..b9cf8ce9644a 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > @@ -4868,32 +4868,28 @@ static int
> >  ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo=
)
> >  {
> >  	u32 val;
> > -	u8 i;
> > +	u8 err;
> >
> >  	/* Write TS index to read to the PF register so the FW can read it */
> >  	val =3D FIELD_PREP(TS_LL_READ_TS_IDX, idx) | TS_LL_READ_TS;
> >  	wr32(hw, PF_SB_ATQBAL, val);
> >
> >  	/* Read the register repeatedly until the FW provides us the TS */
> > -	for (i =3D TS_LL_READ_RETRIES; i > 0; i--) {
> > -		val =3D rd32(hw, PF_SB_ATQBAL);
> > -
> > -		/* When the bit is cleared, the TS is ready in the register */
> > -		if (!(FIELD_GET(TS_LL_READ_TS, val))) {
> > -			/* High 8 bit value of the TS is on the bits 16:23 */
> > -			*hi =3D FIELD_GET(TS_LL_READ_TS_HIGH, val);
> > +	err =3D rd32_poll_timeout_atomic(hw, PF_SB_ATQBAL, val,
> > +				       !FIELD_GET(TS_LL_READ_TS, val),
> > +				       10, TS_LL_READ_TIMEOUT);
>=20
> Hi Jakob and Karol,
>=20
> A minor nit from my side: rd32_poll_timeout_atomic may return a negative
> error value but err is unsigned. This doesn't seem ideal.
>=20
> Flagged by Smatch
>=20

Yep, err should just be an integer here.

Thanks,
Jake

> > +	if (err) {
> > +		ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using
> low latency read\n");
> > +		return err;
> > +	}
> >
> > -			/* Read the low 32 bit value and set the TS valid bit */
> > -			*lo =3D rd32(hw, PF_SB_ATQBAH) | TS_VALID;
> > -			return 0;
> > -		}
> > +	/* High 8 bit value of the TS is on the bits 16:23 */
> > +	*hi =3D FIELD_GET(TS_LL_READ_TS_HIGH, val);
> >
> > -		udelay(10);
> > -	}
> > +	/* Read the low 32 bit value and set the TS valid bit */
> > +	*lo =3D rd32(hw, PF_SB_ATQBAH) | TS_VALID;
> >
> > -	/* FW failed to provide the TS in time */
> > -	ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using low
> latency read\n");
> > -	return -EINVAL;
> > +	return 0;
> >  }
> >
> >  /**
>=20
> ...

