Return-Path: <netdev+bounces-101051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E84F8FD0F7
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171C4B21722
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 14:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2501B1BDDF;
	Wed,  5 Jun 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1gcbd2m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8548D1B5AA
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598269; cv=fail; b=NBE4ZUc16tws7YsUQ+CryjuLIu6TELPVpvRkgoKQZUss/xt7BT6NTa0bwAoO2VYVFWl+LkVLIJWUa7EP4lJvhHxaUpl67x0Fc79TfFFcv8XoOrp9POQvuuE68Doad0jJKiyI42tkN36P6oBZ7DmzFdGaAeCqvq4RmhuXnQ5gpV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598269; c=relaxed/simple;
	bh=6kYZ0Lo0/x0yb30RHYvsaawy98/D5/cXBIaR5HTNltw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H1HRBLqaVFCI5/gmpuonnzVR1skQOa7FJxYy2S0kipPQN1J2cDnM784zcyNoCnJ/Wn60TLN4KJEpPUgfDhh7ZFLbZkXSVYZANUhdFVRYv9Q80w8F3zpQ8ah4Ib60ypVJ8mpYpBIm8agKv+gSAk6IlHwRvHvGc4CgEXHJVO8OGWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1gcbd2m; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717598268; x=1749134268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6kYZ0Lo0/x0yb30RHYvsaawy98/D5/cXBIaR5HTNltw=;
  b=b1gcbd2maXX1U2mM/BW3pnZForPZntNZCOxtJ35VvOZbsJ7QXJR/MZjd
   oVqwcyhGn9zV5u47gRJWZz91eKbxRZqZ18M8/DUMZRqiYdxEVnKv5LUZQ
   kedbLZSlNhsSbuwSGQ1GtOMPNMAUqutOHK42bA6f1rcgC5T4LlyNR+KTf
   ozI/epaJ0NDugRUHvEvA4R7tOJNFeAHcAejMynKu7KwoqtTQvSBTRsiBF
   sQPrWAAY/HLnYassiwgodQTiHApML5K3RN3pPbVjM6OoozzwIyJuvL9jQ
   99iEnxPnBQIB6IzQCDC8VLQQA1+PPgf+V+JlvuR7TVV8IOWSOtEcjPHwD
   Q==;
X-CSE-ConnectionGUID: LKxldfocRKq9xHjQiQP2CA==
X-CSE-MsgGUID: quTBqnhASPmJtSNtmMg9cw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25616891"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="25616891"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 07:37:46 -0700
X-CSE-ConnectionGUID: COVRuZkSQrqxaUc0RW/HDA==
X-CSE-MsgGUID: EcWgtOcLTJGE3vodcausPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42565390"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 07:37:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 07:37:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 07:37:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 07:37:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uug7JRHG0OuruFIMfE2cSnSKt5gqOk2UTaeaMMQ3WTxmkki5ovgKphVn9Lpncw/ekaSpo5WZmf84qxD8IW8pFWd2pOINo2FXtg82SYr9eVVpzjc7z8rwf45a4c+1a1gWpzlbGLZhGVw51zNqokpF+qQ4G+0StV2GkZpEeZBNwLBKmv48XSpCSNgA6/r8b8f+ObauVKm4CN3wGVxyouycXo6AbKU+2XEGfoi9N+612EcOmjBjYXTOwYCjBwmBeF+0g5GnBn6RO8Jr5d8Oor9Kuzxut3POgK7SywF4rteQ0Yxoy5A19t6I6ab7uml6M21ZVgOk0/tBqoJvTDomIP1syQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vek9/jNTlY5+HnD+Sngjj6pmfU5TceEjfwZPTaS/DWk=;
 b=Q/azWWsFAMMXUEefRLMF0JSHw5nYMGXlZTvOVWW5HqMYlXRDaMprhKae2YgTVR15vXVAV5+AdmeW+u8b+AlDlfWsmM04PeNYlM/1Hb0WRkMRo7SUxMLiUV09XeGnbC1jVYRhFtSB+gKg3fqxwdMshmn5icDYx7sZvhhydEwmY+iCNsQOfsz4vgauBcWio+dxfnUd8iv0THcpfpGoD9uU9kq7crUgq6gtOXuvQTooKZCNjrSnaFjj2FihU7MT6r+5ZT0RBLZ9/INYFs+iXdd5vBSBO2twoo3vh7KEnzUZZo27SBOTOOkEzjYZkD3d74U19yTWGlgquvRZupI2G8HeXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 14:37:42 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 14:37:42 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v4] ice: implement AQ download
 pkg retry
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v4] ice: implement AQ download
 pkg retry
Thread-Index: AQHatn7HXibG+Zj4vEiFiO4l06vY6LG5Po9g
Date: Wed, 5 Jun 2024 14:37:41 +0000
Message-ID: <CYYPR11MB8429EFF27103D8AC0B8A38D1BDF92@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240604125514.799333-1-wojciech.drewek@intel.com>
In-Reply-To: <20240604125514.799333-1-wojciech.drewek@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|BY1PR11MB8126:EE_
x-ms-office365-filtering-correlation-id: b53ddc9d-cc5a-4f21-c948-08dc856d0e6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?vk+KoyIUF8NfoI7C95rzN/zEyWRH1ca3+oVeJQSxTXled6VMaDAUhKPTC4bt?=
 =?us-ascii?Q?qWBJ+b6LPo3qEOKIcEcKI7DmcZ5yUJ2YQJKJHYecUE0h538gLl1c9YZuw1XM?=
 =?us-ascii?Q?vBwsCAD2EXyDMhRZBvMd1Dj8tqcXndoKbNhedhCc39RgJN7hgGiAdoieADvD?=
 =?us-ascii?Q?6yQrQ6wDYaLz6MiHpADvZeabWZk+PvU9AfICyOLbl/5SfYdOY+bkz6DU7FzM?=
 =?us-ascii?Q?S9uWuA5iGfa72e9Q1QUJDNsyc1X5JNTbYCLfjYaJcEdDWt1t+wprJrwWrGhw?=
 =?us-ascii?Q?YPXkt50gn76Rr01EFjAUQ1Xl3+o8FpZzAx5j0ZuM8+i0CNqRvkPlt77tT6Ry?=
 =?us-ascii?Q?NHl5ss4Q6exBhOIA/rez8PGswb249jB3oZYW6NliG9t9A6cHePP9//0YE/B1?=
 =?us-ascii?Q?TjZfaCgeyrNkfJwfn7xi3a1MTZZYyMwqt4h8h1iWya+JenUYyuqETm2xWlck?=
 =?us-ascii?Q?8WjQH20GCnEpliRiZjoI4xnldTEwf5JbB+gO6awW94ALwD/SerFPdjfUM4Yo?=
 =?us-ascii?Q?sQuQoZehtxpC8LyvSCpHnKVlOMmtS7P2k5JC/YKhPUH2qlG0ztgBU7HLEmoJ?=
 =?us-ascii?Q?WK+GqKxWc+hEdf4JGEJ1C6iCG5NJNbVnMSpMJzzDzLEZSmhgSjA+cNOGJ147?=
 =?us-ascii?Q?YfDY1zRRNO7FFZTVZnJw+y6CNVMkPWhxcWy0P/JHL6xNy3L2B5Fq5l0GkiBi?=
 =?us-ascii?Q?T/GbxygncMvpYfSrmV5t67cTgo/UpbwMZW7REcL4CeReS4aC2VEoH4XAir3Z?=
 =?us-ascii?Q?t4TEiuSdDErNNw69XJVuXQ7B67AT53EVIEsvcKYDaIiE9LopvsjGiRG+JdYj?=
 =?us-ascii?Q?a0jWpLMYcRf4+6uYSECo8BaTJ50saHJWJuQ/xPnB44Dcm3IPJ0ZAwdy7ELgo?=
 =?us-ascii?Q?hb//ryhpaGY9EdA5mV7D0ve1ke7QO2S1rOUqK8Z8qBScAD1EL54xl1Bkkb26?=
 =?us-ascii?Q?QyyceP/kvxcC6Wg18znNZsj9Tn6/uEP2rMXquzG7TEjWyxgBhg5LIiux5Pru?=
 =?us-ascii?Q?w8HqG8unebUlGc/J1pXViHk3NZXqlfImzdXH2jXmfdpLoOlTJtPNx4iAQR+N?=
 =?us-ascii?Q?gZPNQrXoOUNRTKpFVL2lDcPMZmcmRWwwzuzse+ifwG1Vmc+nR6/8QgXQJ//S?=
 =?us-ascii?Q?C5kVZ/T8DQyH+MNgUfxKsw14MTKKQgU+u7DUi2jEH7ei2Y+Re0YJuiDaNkvv?=
 =?us-ascii?Q?koGl2/AsjNUMkg/1t1/PrBzU0Lu3cibzFBpEQxl/Gltl/3XymAp9guYa7BMs?=
 =?us-ascii?Q?UQche3/oNKLAQwEcuElWC7ka0Tj0dY1q+8nwDnfgxOHMzOyKG64x/OlmHos+?=
 =?us-ascii?Q?NsNl4peCJ6JeF7L5QUPlBHMzSCnbdc44o3yPyDs29CDBoHY5eFC7tsZSU1Pb?=
 =?us-ascii?Q?GEkvlBo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nm8Ke1z53DTdTlzwVtps5+/HM+8apZluvL25z6Kpjcj2+hbw2MPeiyLyDe97?=
 =?us-ascii?Q?3rfntqGnlLOjnM7EORk2RsI2exgLUS88kENvOrFUpHtbkIJKK7j50XtMrqxU?=
 =?us-ascii?Q?Q/Kfny8gPhBexjDv8sr+Glz5ZrZOkPMd8g3v3//KPRve4viPZF08q+jZ+lSg?=
 =?us-ascii?Q?cKkAYW91kOCtePPYzgQ1NwMkTxSN6ppnSUteaLWjAXXHc9iC1XEu3ccfgaCu?=
 =?us-ascii?Q?WP7mnfEKCnDtrY7oM8lvMW5ftnifOIKFXKw61VHbkgT3WseNHpQetLePVrcc?=
 =?us-ascii?Q?4mQ5kX4706Q7bQBHGnTmjw7nWYdCau17B+IMbhFlA5FOqkoKbvt8SR7tgpzw?=
 =?us-ascii?Q?l6gJTdctlzSVfWDtzOTE745/mJl/YunSLPLSJhHvtNSf8+N+/lAQXhr15F4x?=
 =?us-ascii?Q?NwB4JJHygcdtwMgykyNC9IkG2Qm8rAhcvYUvOcFGxXYc86iw3bC0YGbeb4S+?=
 =?us-ascii?Q?jGOU3kORspi+ozxBoq63dQ3jnQAOvFJMQkOveoG2kJl12696W1l/0jXlAHR3?=
 =?us-ascii?Q?ZDn0nFuTzDRAEGwizieuOOx9SKPnk1vteHAnSL3TzzEG0Li1BspBeN0GVmt2?=
 =?us-ascii?Q?ZU5B7pQOaPctR+a1GDsLdKGbr6Z32Bom4Mwkuh/l0rUhp/z8XsNrYu+U5g04?=
 =?us-ascii?Q?AzqvFSzjWqWgGyaDddAkm8gnNutSbr1WvUsc4gWKQmFnrslDL9SLfEpI1QQk?=
 =?us-ascii?Q?etaIC4qcL/5r8blhEGrkg0PE1Qctlz8w63jUHxHGvlbalhwdQsgh32yLGryL?=
 =?us-ascii?Q?TFA31OFGrsKC3p9pjoi+G/8L2e9WVdk1gVolOwcIbgdHmrTZJeOH63BVQ9oJ?=
 =?us-ascii?Q?wdD41oXafkkfDI+LeTjLja64pKDSGlu0zMtSDBM3N+6kF3Ds14UGyFBykKsB?=
 =?us-ascii?Q?X5W/HQxP6gzNOJLGlYAwwwYreO3ozDz3i9RBcPCL2JfReeSmQB5JCvWe4eQY?=
 =?us-ascii?Q?15ecuY4AiEuUwvVqVcYI5k/3dOtDQYI8KxkcscGxAfu6tgePvWJ9X3+0lH4e?=
 =?us-ascii?Q?bBq6nNiGcN2+dcfehIITBdjKWoKWD8cQznBU0RkwH0t5afBFY+9SEODMOyGs?=
 =?us-ascii?Q?hN4IIRgMdYMpTbTK/q117oY9x4lhRpkTz8YTzCK2EosRRc2uplfec1UaW7wd?=
 =?us-ascii?Q?cYUCLO5cSoxhtOE3nWcHrati4TuQWm+tsaWbI/wGNZLyglFlK+BmQP3NQDvb?=
 =?us-ascii?Q?BnbCQuMYRwFvtVyezRv28hNNJ7cLKzvcwwa6WI4j0g5w+rMQxbD9rQHGb/+C?=
 =?us-ascii?Q?NrxSjmIq3eo7k6zb1nQMxbqedMtkaRVtVJ9ACxat0sIKR3fgQ6RRXHEIEPb0?=
 =?us-ascii?Q?ehESliS9CVLDnFk9AcKT1XyT02h2BkSNFllTX95ZxJ2BmT7e8MPRllZHzviY?=
 =?us-ascii?Q?4IvjimYzWLhjvLtNIG1zWIR62JSB6Cd/x5R1NTec2EsKBCRhXchPBEzIZLBg?=
 =?us-ascii?Q?KOQ+WF3J/BgsDqPqAZN4sTn9L+Stzzx9DhpVUzvca7D8Z9rng+a9bmUNrcuK?=
 =?us-ascii?Q?AzRuFyJ4sZGjS1GqPwPzXkURjn+T6T02aMrZKh1IVqeFn8as0u9nIfyxLFlk?=
 =?us-ascii?Q?zdD8B5nMXIED7jHVvPP4lr6VAcoCIoc63GCwIynLAlhULaQf4db18p3jTIHb?=
 =?us-ascii?Q?v6wDsM48v0pUArwjiKvLRn0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53ddc9d-cc5a-4f21-c948-08dc856d0e6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 14:37:41.9328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQDJIoZONpuY5cp0pmovPuC5ixgAYdCiJl1STvBmAa0Ccw764SG42NuYxmnfGrZeCiQj5Dx/3KFjAP36oIbVr83tbLsTt4KW6cjrCLsbjaP9FngXgAWsRn+vtYKxoAGL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of W=
ojciech Drewek
> Sent: Tuesday, June 4, 2024 6:25 PM
> To: netdev@vger.kernel.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; kuba@kernel.org; intel-wi=
red-lan@lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v4] ice: implement AQ download =
pkg retry
>
> ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due to FW=
 issue. Fix this by retrying five times before moving to Safe Mode. Sleep f=
or 20 ms before retrying. This was tested with the
> 4.40 firmware.
>
> Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP)=
 download")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> ---
> v2: remove "failure" from log message
> v3: don't sleep in the last iteration of the wait loop
> v4: Mention the delay in the commit msg
> ---
>  drivers/net/ethernet/intel/ice/ice_ddp.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


