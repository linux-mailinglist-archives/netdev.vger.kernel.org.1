Return-Path: <netdev+bounces-307184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y7hTKZLrVGrahAAAu9opvQ
	(envelope-from <netdev+bounces-307184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:43:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A9B74BC72
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:43:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=TeOu+C38;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307184-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307184-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F85130495CE
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDC44229A0;
	Mon, 13 Jul 2026 13:35:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145B408604;
	Mon, 13 Jul 2026 13:35:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949718; cv=fail; b=U4vgyKt7fsNmSKBvVWZVewSNFIc4jJQXrhdTZ0DSgsPv49GRPSQnqgCvTvy4n3GHEK2jSDuNQIR6F0svGgJu7ny2HOFQI8zTdc3BTJ9Yy8UUeZfpK+dCl7bI5c56VlSwoIxAfeLsfa9gatagqat271uePqVgvw6Xzb2Zn5oI3zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949718; c=relaxed/simple;
	bh=fBevJW48p5YcschKEY61s26fOf4klak8RXc4TEjunSU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lCUQMgwOpkNza7nLvQD8YHMCzY6i4Bg1k5r0zKNAgalSTI/gsIq7bbjBZHaRvArIQDFjr5uiOAERiXHWK1fiBi9eVz8meywt0LJ+6lBAM8i5fahMtAv8zMkG36l6aMLrnLqCrWJRAk8Lkgz/WKux1EETxZR71pamStEgytWk9S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeOu+C38; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783949718; x=1815485718;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fBevJW48p5YcschKEY61s26fOf4klak8RXc4TEjunSU=;
  b=TeOu+C38s9ggXZaGbYU61pLD+5PkFVWJ68m0h1LPWKHc/dWTe6f1DXg6
   OZWMYWCTybC655aftlkoyxYHqj3CFcgPGX+vOGtO9n7W4Wd5X8DdfwWVu
   jmYwgBGYc27o88w7WyImII6Atbr3BYW2Pv0O9H7n146DECjGJC81IMX4Y
   4VOcia7xM9h35uFPsBKjbyCchfijf1s4Nc++qoYAGyGKW/UKXC2Y+8+tH
   2T4AKTOzGiRBrtC6fiBFWKzBmkYLwpGvc5QgWv7VMVeN6wU9ZR+0LtwjB
   gWhUQyBcYbcgbeOACVQyQDf2Et5NVkE0LFUOirLuT6cXtuf0mXWKFO1N+
   w==;
X-CSE-ConnectionGUID: uaffw2tLRGaWlDklc8h5JA==
X-CSE-MsgGUID: vCDwkyOOSSS567dwh1Drbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="110101231"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="110101231"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 06:35:17 -0700
X-CSE-ConnectionGUID: aJSzTEuTR1OFfPQlsCBtuQ==
X-CSE-MsgGUID: sUVcVgtWTveVE1kRK+oUgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253817695"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 06:35:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 06:35:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 06:35:15 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 06:35:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLEEgZhGKU+0FkS3H1iiKUBchxpUxR6obQNmtpNMTOZKkZJttbGC8DZ9TadS8ghFwCfkBtXNM4bd96DZoreNQ0y5JlqA56A8IA95xYl0YFq/OT1+lt2Msh16lOrG81Rm90UZSyQ1/DJ+o5+P1Bj+34rsOQuchF8NO8KsXu+TltUW5Q5JQYPt8zFxlZDi0v5NvW2sFkhm6iDWCjig/HCjIds4FqEfN9l8Sm0zgs8XGKL1gyygsxTmvZJxtSmX1s2rQeg67Klq49JBKv+N5n6dWKaSaYrD82Nq2K+u6Z7dxu5piXEbvbTX1FoT4JF0fXnjEGCaeXZw68jnHMTVMJpdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgVEp3ua5vu9UBp7YrQgZFEx4ZUoHiG4WYbS5dlOq1A=;
 b=cRFIv9hT3YA9KBqX+h1YTqFyisnaoQ06BavhIGoNVcEH1Obb19d6T5It+1e3h7z4vLHXjjXLklL2Bu4IcUuPvJavqJdIC2EyGQr2VvaCE1GigByRLLX0CO14vKxBU3CwhqNyHRkwzSzqQM7B5Hi1B0CERrQb7VaW55Hwc6mqV2V089j1fcBbvNUx93GoqNIVPrZbTj7t02Wac2Q/sfUw51u16gbo42xL02gIzHluhnxJNLJ9HV0OWz50YHj0MNvTBUbEHWC4QwQBAwFCuCDZjrryKD1HAUuZl+CVFcNqf7LjtglOdLWNGP0sQ1FsMrSqLoPZ73I56W+pQXU1q7pwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by DSWPR11MB9954.namprd11.prod.outlook.com (2603:10b6:8:39d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 13:35:08 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%7]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 13:35:08 +0000
Date: Mon, 13 Jul 2026 15:34:59 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <anjali.singhai@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Bharath R
	<Bharath.r@intel.com>
Subject: Re: [PATCH net-next v4 13/15] ixd: add reset checks and initialize
 the mailbox
Message-ID: <alTpgyxqacbNHYFD@soc-5CG4396X81.clients.intel.com>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
 <20260710215313.1475803-14-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260710215313.1475803-14-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VI1P189CA0034.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::47) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|DSWPR11MB9954:EE_
X-MS-Office365-Filtering-Correlation-Id: 4166352b-003b-494e-3d42-08dee0e38e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|10070799003|376014|23010399003|18002099003|22082099003|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: e3g/3kkldrZblkyVhtP1BAT/VrLPGoa9gxbnM4QkdRxQthxuy4JDqfWbzL0JEOhElto0HZszJQgmBgdqpA/dgi6si2QbxsDNjzupYOIkgzgcamcICz/wLRjLgASM0EmhhIuC42uUTqWNooKP8i+dzG2gn/DbOlM+9HUd6yceaOA3OttcN96fUw1Zkn2ONaSskVvo8kc7CHYFlj0lFRDGpL6E5yjQrn44iKlRKl6M5Fyg2U++LMfq9J2Imot/Azdhhb7QCkIBatpr+SbA+I9uELcnOrP0skcW66M0rCaXpI11qUHm4fEr3qZ3oPdRPQaxrt8YrOA4aeTBGq6XuKlAWdbQsKMgOPoKVDnBw2H0YOn2S0e6h1fjz5ByH91ip4Iwfhp3PBvEGT0nkojcZvJy58I26uoDoaryEhkEkxUyh1UCYSaJvanqDiIPimFu7kQntzXIG1JZGnoLKQaS29Mv/ShDodJJ6fZWfgenBciS74nsJ86WL9PK6z1acsRn1Wbgnch0o0am36NhDSxF7K4+m0/R9VIjkuxku+DIGVCBNAR7OhQSREJEVCk+7Rv4cxTChDmrdsjwDFPNMGZZDXclGGxw/JSgT92Ohn18H+w74uj/8qPHv6LdmyiHem1BS1ZoVwmfP7ZRD8wJw36w7Ej1zWProCStAVDweGXY9ZvV65Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(10070799003)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W/bb25sbVD4RdZLnfHOWMxe0EQcokaCFNz8NP8ssVeSCf5ucMOtrt8r/MFXF?=
 =?us-ascii?Q?4Rby6fiyyGsHrn9S3wXMiIAbl56GKJo32XVllGFFeqmdb1iriOKx9Y4ZR8bY?=
 =?us-ascii?Q?1DtUbxcJ9oNbeqUa6Fa+QunHxE1nn8uJ6W8vXnAbbgnex0J3gOnMIv4CTt5q?=
 =?us-ascii?Q?j01/T1aeBrZWWDwA6JwwMII/nPDKO+SuX4olT7nCypL9VLqTznizahpFIYNf?=
 =?us-ascii?Q?vf1jr8XrZHKYwVZr1XRAgsmQU0B4E3s2Ix9MpDr0fZPGqgOHrOFbGy9LtY/A?=
 =?us-ascii?Q?YIRrcs+K3fVqmZ7ROPIJ97slqBpANwnMkt+tzHPkJpYeElvR1u0SpS681obD?=
 =?us-ascii?Q?Nyn7f+RV9lc28oalCutP0zFEV+OxiiVDek1aNwdt5XydfG/TkVjwlrmshbPV?=
 =?us-ascii?Q?bkMDKSQ05NHd/sq6rKhWWvVbbWu//vKwUpiOsNaMIDv+8vYJHPdwVejLZMrI?=
 =?us-ascii?Q?5AjqqkMgs5WqcgHqkKKaaccpzKThOhcu94EgIB5awoktxgtr2F+5GxRGKaao?=
 =?us-ascii?Q?EDrMWH+2g+1nYNj2bDatb5dWlMLet0UzzKfG3TQ2GgSTPEh/WN+UK/jdUUQp?=
 =?us-ascii?Q?ebiD/s34uQ4eTuMmtaL9xqzzEVBmbiE/yeF5c4OhyWmNyFARSr/8/13l0RYF?=
 =?us-ascii?Q?WnFSIn2fDhr7hE9aaXJZs3s/vZ0UfnRnWv6u+fgO7NKnRThHcS6AFQy2+X8/?=
 =?us-ascii?Q?jNFu2DdryqzBbHWEcFcsg4JudmGQnBOPOMcUkugwYJLsRGzSqCVYLZRf/k/j?=
 =?us-ascii?Q?KQ7Re6JrMEQFWaDoBAMyAcORISCyO4Rgp439h3hi/JXb86rY2KmqLy7BVhim?=
 =?us-ascii?Q?1/0OvecTE55Y4ogSFJYXJZVed5pnokvb8F1b2oob6N9B1zmIMGZrHOuVC/+w?=
 =?us-ascii?Q?2Gib7SKTCJ468Cj9+2SJ2ADuioszVKbPo2vhAE6dqktcfZxaXpvCk7rjPALu?=
 =?us-ascii?Q?uydpemcvAq4fQFU0k8Gr9S3gY8atGytd6IoO3vSkadpvnD/K1azvjzshOtwb?=
 =?us-ascii?Q?OQb4Ab7MnlYSQuXcDGji/Lw7OhLUnUTCX9PWz/LmRBcE5HYedW6vddVXEWxx?=
 =?us-ascii?Q?elrHE3iHBEvjCEclPfMHX8I/0qP8HuQOO2mez31TOBV0+8WgMxjcwurl+6z5?=
 =?us-ascii?Q?V8LYQF4Ztv4blBv4674wRIDR3Qed7o5WvJoAmxqH8rnaYwZP5QrKkiEYII85?=
 =?us-ascii?Q?IxNtRsXoR8g7l+azjMT23wEjtknYF3cuu2PrvCv7nmMEmVoItB3/Cvn56OJa?=
 =?us-ascii?Q?br6j5bC43nm/w5tHp2/ukFS9IlwNc73i3xMHzAKg0YgNoeHvMWhGNQBStojE?=
 =?us-ascii?Q?xC8/XV1rezs1VFDE4Qd3sefgPQGQ00EW1cIIgjK6k2D9DcVihh9yZA0bM2YV?=
 =?us-ascii?Q?8g/syHTEmuRv/Nn/Cjwwg4+HU6LdJe6wD4DveywuV7B0zpKFRybJNDGuRHYK?=
 =?us-ascii?Q?yHvaQDTgNe3ZuE4TR32Js2W5SUjb8/Nbm8ydvGzvm9+TnTyv8h5RU3morOpD?=
 =?us-ascii?Q?PwYP8Uy1Xbm5W0uIZu/8SVkfNNF/VRQcvkUDdvrjLulpbD2QvFVOY7WmFY/B?=
 =?us-ascii?Q?JsXGQPr7Xtc6+4e7zAvCiMV1KUju0pdL7Ipsn6k76+UgNx6xrT1qcCGJMQV8?=
 =?us-ascii?Q?cstuqRoFfYfNTzCW24xWO0Q+2A/oJND1zYCGpzZsohdBZNtNAiYLqJHEc2ia?=
 =?us-ascii?Q?GDQgv9D6d+vLiLRQ1c3lZ2pXtuWM/ikXUPKVh0iZNjEc+8BFw6iIMrJaRcvz?=
 =?us-ascii?Q?xyCaXkGPK2GMjunwaEzC5cpvYCbDYCwOusL2TvIo27oGhK1Vqz4JseDlkF8Y?=
X-MS-Exchange-AntiSpam-MessageData-1: veMZUwCE2MNng/2IXzh3QQoIKpooUCwQyKU=
X-Exchange-RoutingPolicyChecked: kHXaTlfQ7YOzOr5/DtO2rvXbJEVRXJmVokzPqu0ApM70nsjSS7naBtsG629U13vw+NnUe435D69mRhIKcl6hGhcTpXWmNfE1zrwgzgduPHAI3FVtxMs1uKHrLowX0LGeiDh222p4ZLs9LtueEXaEJ8GNyFLEVQkVDv5L2afvvJ5mi4xLTUREdQkRPFU9sE7+BQoRX0pO48A/vPLQ7t3vWIbt4hIBFhvyp9gGuCiLl98ZIVQKlXMzhSmegJMBz/D/RrVNz0YeqX3LBSYX17X0/cTJxTCWPyknQjAceXlU/ZwHkjnBl0PYXZWNHSDr3kp61GZrLoxTfWuZXuRF9m2nOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4166352b-003b-494e-3d42-08dee0e38e23
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:35:08.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQSn6GEfQAYBf9OXrK+Z842AklO/8MfxqEKf5HJ4yHL8Uz8x5F9ixFuRIDOUKxxWBaW970mJEXCZbEa0OCTP2Q1dx0aEKEjBOL9kAt7qNJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9954
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307184-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[soc-5CG4396X81.clients.intel.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:anjali.singhai@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:aleksandr.loktionov@intel.com,m:Bharath.r@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88A9B74BC72

Below is an answer to concerns from Sashiko:
> --- Patch [13]: [PATCH net-next v4 13/15] ixd: add reset checks and initialize the mailbox ---
> commit 7fa1c35636d0bae10b336e706045a6dfd122058d
> Author: Larysa Zaremba <larysa.zaremba@intel.com>
> ixd: add reset checks and initialize the mailbox
> This commit adds hardware reset triggering and mailbox initialization
> for the ixd driver, including a delayed work task to verify the reset
> completion during probe.
> [ ... ]
> > diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
> > index 75ee53152e614..35d0ff5c8d983 100644
> > --- a/drivers/net/ethernet/intel/ixd/ixd_main.c
> > +++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
> [ ... ]
> > @@ -16,7 +17,15 @@ static void ixd_remove(struct pci_dev *pdev)
> >  {
> >  	struct ixd_adapter *adapter = pci_get_drvdata(pdev);
> >  
> > -	libie_pci_unmap_all_mmio_regions(&adapter->hw);
> > +	/* Do not mix removal with (re)initialization */
> > +	cancel_delayed_work_sync(&adapter->init_task.init_work);
> > +	/* Leave the device clean on exit */
> > +	if (adapter->xnm)
> > +		libie_ctlq_xn_shutdown(adapter->xnm);
> > +	ixd_trigger_reset(adapter);
> > +	ixd_deinit_dflt_mbx(adapter);
> Could this cause memory corruption or IOMMU faults?
> In ixd_remove(), ixd_trigger_reset() issues a reset but does not wait
> for it to complete. Immediately after, ixd_deinit_dflt_mbx() is called,
> which unmaps and frees the DMA rings.
> If the hardware is still actively bus mastering before the reset fully
> takes effect, could it perform DMA into memory that has already been
> unmapped? Does this path need to wait for the reset to complete using
> ixd_check_reset_complete() before freeing the mailbox resources?
> 
No, ixd_check_reset_complete() is not needed here, triggering is enough
> 
> > +
> > +	libie_pci_unmap_all_mmio_regions(&adapter->cp_ctx.mmio_info);
> >  }
> 

