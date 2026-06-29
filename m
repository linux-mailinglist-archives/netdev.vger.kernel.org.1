Return-Path: <netdev+bounces-302500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xtfwHBUlQmrJ0wkAu9opvQ
	(envelope-from <netdev+bounces-302500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:56:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA086D7382
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:56:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=k8fOapqC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302500-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302500-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96BF7300BCB9
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5FF3E0081;
	Mon, 29 Jun 2026 07:55:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17FF38D40A;
	Mon, 29 Jun 2026 07:55:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719730; cv=fail; b=g2vM4KG9sedYSGg5gRn7nmK2chB3CbSi6cd9zlcHEeK3FjzmBOepXzp09SEacmiHTeUe96zfHvowknOjB+/X5AqhyyUTKQRzi5VvSSUXR9KjpoNPyyyzZhPDflMMa17OtceIlxbxwKVmu6Yf5f/BTn8JfgwrIZyOARGLLc6oVZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719730; c=relaxed/simple;
	bh=GMg0eQbCTa0yuaU74s4AsT7AGWIDXY8MFFkG6f3fVPk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U6n2juwrTwGlhW6ltpzfFXNzn2JvDyjv8xnQWouAr4KaMK/ME38cpkvvF6PqPyeyQNTNf1wertfesnKRC1RYuCpZzNoCc0NSOquf/025nSTllghlfBItqhVGXnFVVRakzGaqSnb+1KQlPT3ePjxKG+wJxhbHyR/B+B+woAcCHSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8fOapqC; arc=fail smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782719728; x=1814255728;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=GMg0eQbCTa0yuaU74s4AsT7AGWIDXY8MFFkG6f3fVPk=;
  b=k8fOapqCcxUfgAlz7Ml/UBOXx9N94TybO4FeBKwAsgZWTRpZhvgNBIoo
   Ffd+X7wrQqx9Ipn1yZzrdK46DG/0Ny5Zx9Go2+0ft76HchSisOiELTZKU
   RMD/zU9B/UiAkPzFHl6GSd6uK3rHIovC6iCApq6TWQf+UAskDSiZNQ1Hq
   H3F9U+NNJShRt49NZ6G9HE0G3a7Ymwdl6twaCibeINLKcQmvwoFiP9t9l
   a26pfxelKcnMmxziWYwHIbwTzcTLWCVEV1C3mpoihQJKqbD2UY1P8h1pt
   Bf3aBOF2NhDnsCHqjmB/T8rXpkf4SqjR6wJgl4sa/QMWOgYoD91utpdYq
   w==;
X-CSE-ConnectionGUID: +OSQPZhySyC1/uNQ/FiTSg==
X-CSE-MsgGUID: niVeNiDyTPeTXEePdv/96g==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="94788422"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="94788422"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 00:55:28 -0700
X-CSE-ConnectionGUID: 0y2Q6JkvTOGjsLhb8sbXxQ==
X-CSE-MsgGUID: yRQysBtLQ9qISp85Y27xOA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 00:55:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 00:55:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 00:55:27 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 29 Jun 2026 00:55:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIquPT+k8cORJbUT1/TEmZ1D/5vGfnfXCduMTj8vYKpJpgKfiUYHnMLOXAGo/17RGFCwsGHSWlMFqCG9JW7VZYT1ai7Fb7JxfmZNLHS9KUlJl4Cl3npebwulCSEBJMT3VGTtGz+QwMZo9Lu+Eru327TRlCtM1Wpn++kZuVKXKshlv6YJ/x4cfUgBwb1sV3bhV5GCZAFn0w9PTtmg6EqxuhehIhEfKHTqMRMkyw48fmmSpyVHKcChwhl/yFEhcKXWAby2VvvjEWx3mUB7e78jfZVorboGLBizm5npdjf0MLz12Mo5EJFFO9rjffLooP24soKiVysKnyYuP9gqCBLbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMg0eQbCTa0yuaU74s4AsT7AGWIDXY8MFFkG6f3fVPk=;
 b=d665Lde7zzA+LFXfSYvmZ2gWViuBHSlqWmC97IyccXw4B6OAVFi4M409WzTxvrbkuZ/e9dC51nLwHw2F0FE75A0qOMKf4li7HpWqYRpSu8mlp9GumX4TvzQ5Q9XMDsbddnBy7/5dt1IH6P6Dndy9Ef06PI6g5N7+lZz0WT5+Fh9PkHLYGnajejMg0BOVa5oSMqxLhvgvSARwLpFibp7YnGjgwbkqIdXe/R8HXVt5mRKpLREA3gCqBLMpWNn/bF8s+VjV3zJJ09L77AmTnxFcKpSEqsKdQOzwPPdz+DbmcJd7TKnv/ArwZEFCxVUkqn0wLXmwWMnegnLgqTsyeq+Bvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by IA1PR11MB8150.namprd11.prod.outlook.com (2603:10b6:208:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:55:19 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0159.015; Mon, 29 Jun 2026
 07:55:19 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Manuel Ebner <manuelebner@mailbox.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [PATCH] dt-bindings: Fix bracket
Thread-Topic: [PATCH] dt-bindings: Fix bracket
Thread-Index: AQHdBhY1XwAZzeUmNkC9kWWcdMc1krZVLIrw
Date: Mon, 29 Jun 2026 07:55:19 +0000
Message-ID: <PH0PR11MB5902009AB9C7EA1DBF191CB0F0E82@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260627091936.29809-1-manuelebner@mailbox.org>
In-Reply-To: <20260627091936.29809-1-manuelebner@mailbox.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|IA1PR11MB8150:EE_
x-ms-office365-filtering-correlation-id: f1e42ed0-b0d5-4c35-6c8c-08ded5b3c408
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|38070700021|56012099006|11063799006|18002099003|22082099003|921020;
x-microsoft-antispam-message-info: HRFCv9c0RUuc4poLxP3G6bSUax9vjezGTdfA8vtdlWVgk+1giIHxFu1Qji9LC32woO7S+aMwfHOVrAMCc289jDJ5+iRgxiFgZ36gKzAPmPM5dEQ4oVkOqG9rGNEnK4Jt6IdCeViK1DlwWiDJxSr9f59Wkhf+4AleS5jDRtuPVAC8i6yxLoC1Xbkb3NBj1UwcmkxW9CqSb3qyarTFuiJbcMqvc7FtaxYj4F26MLo7tPhlOSuYcCNcYmu4K8TLlLpSyPmHY8EBoLlk7H6MIEEBNGDZA0hVkJMtY9AaSfSOOer8cwNw+0HzWNjWEpS+781e9AyTzG4gn8UeG0QmktuFOJ0UgBb71X4maCm5PZbz68AmGi+YiHH6uJADKSNqEtnx7+4NJN8traROHKl197Zo9y69wGIvwf1IeZZ7q1CyyTCulLSY55zhY0cA1FWZbiOlqjjfwPYnmR19cB9ywtDnkxTq61vF+/r8Gt12jfRWlXnzaBMXl7c+bTWo5vbOgWUOBxk7DYvHA1m6vPsssCMdsHgXJz9sMdETSh0tgxSh1ka0XaKf+RUln/XM58CGjoMLqAWnZT5X5OgiPQDVQQdYMFmBDCngC6qQ3dTL+Tb8q9K5kNNz+t9rM5AaimXSctROZyaCyGxaP5gjTV5V838lGC1LzshObutnhPvponXOSYB09hWfETCpp+r5qpXr2UNAuBZkD7nyCCgIWoKwAcymAPVWNetaXor3TtY3xELIrfVdvupBWrpwdh1JGcKlX3GJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p9d6b8CjjZVflWwMlkG61AZwg3JBjeWLXJlGQVP7VmlZogFdWJHB5mLs7YAL?=
 =?us-ascii?Q?O3qs14xWrS6mE6cA1juLXJXf6KMw6+OtxGAmhUhtLZeNXnpB4v6p0OZ8+mli?=
 =?us-ascii?Q?uvqHsO5yusKuaiBe+YLB8zTwLeRTfeL7oJRzR5hbq8biKRKb4Lvys/oRo74C?=
 =?us-ascii?Q?gEfiBEKQOblSHL7H9c7D9qGgHVPNbCWOS1GtZLrlF2angiKT2/rCHPnU1FE6?=
 =?us-ascii?Q?xhuZfSczBk5okXQl1SYSEqQTHPImmmIPqzQps4e6wQ4BLfcdBxGrXjr+Lqxk?=
 =?us-ascii?Q?AUMXgrMKbhAlKUpDBDqkNpvme0XPqGrfmCQg2nWkmaADiJmx00UAYEQ7IftA?=
 =?us-ascii?Q?0+QFBcfO8HDDgFMVJzMsYK9Y4fOZKwJKqnoQlAuaL72bqmkIkTnj4oBJJ6Z9?=
 =?us-ascii?Q?iEOlXoLjMe/HtOWfcSWp+tIJ6PgZMnz6yKfjx/kAFKaLL/CXU7RU06SQjcgn?=
 =?us-ascii?Q?IZpVmSlSoIu3TLqpn6Qz1qbup/hCFizZR2pOu667Rg2aucOmb9ZZN7ntwhnH?=
 =?us-ascii?Q?vK0jnFBwp/E3CvpTCK9wkbwEIYEmm97vOrBlGbxr3HMqu7QKOhLEw7qkP0Gx?=
 =?us-ascii?Q?K7kPFzPqDL4oWyHD7QonAMkPF4I1pK0Vvb8wJpVz2B3bD2DA5yMeg5QUlJQ4?=
 =?us-ascii?Q?4hTN5HlkU41LSg8LjbHCmtP0ZqxHALHhTMigTpSqxRtkjRmRjOLywi9MN0S2?=
 =?us-ascii?Q?rwmjopRtBKOC9/J85dfwQgdKQ3OKXAP5BDePB8J2kTpqfhqv72OmrwiaFLnc?=
 =?us-ascii?Q?Baf/HFw8emcORdT1Sj749yXSxAn+MtQ+6i99q1ElYUYxO7PQKUIzHs6npyCm?=
 =?us-ascii?Q?Ie0F8C0NrgP2rl0GcMGvfmVurlp0HBWAADl/YSA32eXg++jEcfqxnHOwFaPH?=
 =?us-ascii?Q?XlHkQr8tx/GSJ63LJbn1/1EOgZC80gVn+JysVj6it5A6xnL+ZxwUE04xR90J?=
 =?us-ascii?Q?s5k5/Cs+tCzb82CdC6kergv+GZrAvZa99dREdjgor42fHj/3QKNkImLDAFXh?=
 =?us-ascii?Q?S6z32Fghkhd1DmOZUi7LoM+QFzU7zAO3gxH+4UpVJU4M1vKQpc4ZELOEFGc9?=
 =?us-ascii?Q?Uejtvrx+HBPxstkWs9ucd71LHCheYNol01W8ywgiwFAdGNDdBzCh4YvZlY1w?=
 =?us-ascii?Q?e5BH9xuztlgUf0aFMe8aatFe0yp9rLoHJNVuuXUArtfWqX0dJAOIBsz+A7DU?=
 =?us-ascii?Q?u6z61+X98zSKD5xaiHabC73jFCAGaPaw0NMrfeYXpYPF7SJXcXWuYZRCwQuN?=
 =?us-ascii?Q?s91Cn72E6Eb3Nbthr1oIo/z3PKHEvz1V0NKhRLAnd9xNiE1hI4ZOvxtJEkkf?=
 =?us-ascii?Q?e+OfvSxHSZx5utxRhSVX95RcM7w9tEbcMOvU3TT9DEZ2e7f8UEbBc6ZygELY?=
 =?us-ascii?Q?zPiP8zvvfxCcMuS5tuTRgtkd09dTtHTTby+TXQugipc7hqF9Yc5ijHml339r?=
 =?us-ascii?Q?H+pQSSBS3KrTOerAxifDTS3zV+G3YerXsla0y8rCvdC5T0x3ceQ8GB+85aWG?=
 =?us-ascii?Q?ie47oax/GJZXrztyIfaJH0IK9CLPxWgyXLAeKajcniqVD8aCVqlIlX1Wf7DK?=
 =?us-ascii?Q?k427ujZHDwvZPCGhhCiSbwPpuyjTvCmgXODyTEuZYYfPrtS6PcO/ypWOa5gD?=
 =?us-ascii?Q?fYYambM8d7vhCQnHJF6+WX5+wWusYqTifxfkBDnixKcQdpSWIWSciNf1weLI?=
 =?us-ascii?Q?fMjTM1vPshnpXhD2QW8xf9YCI8BKSmmzcMlo1ixe9L6VLTOMJGmePpYQqV5c?=
 =?us-ascii?Q?BP0RrdsQXg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U+4BvnUW0cHf/wlhFKFhY5GEJRAJ3LAfp8QwEo2/zj8dJNbKyv3ubMA/zLA+AYd1C0p3nOe/cg1aKXpToJC/Q9uVThrLJxMUp15lgQg8esrk4gPqfVG0L05XUmC2ZYnawDuBowJPPkAcwXtal7xt8mR/EVW0Avwit0T2nydk7ekP/ySHquPHXyoUEuI51KmPUrzMQDMFUaUacMLU01BBSBkIndDmmlCqgVd9H/8ZAMcmAUP0jMBsZuwh09cA8c6pRVfN8g9FFLl2sxb0R8qS65Z18Mzo3GqyU9tg1FZlzAMXuAA8MxLMpPr2XD47wJvjhx6m0RyxMAPN15vvmmj9Wg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e42ed0-b0d5-4c35-6c8c-08ded5b3c408
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 07:55:19.7597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oP6y97yOf/8IHFIS0u9WfZ3FJhjYJRRYK7jqHet2mwHJJoHre5X5WZaVDpEpU/D0bBPTAv76Rw26BRZ6oPz+wjkLV+r/I0+hsASND4APH00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8150
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:manuelebner@mailbox.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:o.rempel@pengutronix.de,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rdunlap@infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302500-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mailbox.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AA086D7382

From: Manuel Ebner <manuelebner@mailbox.org>=20
Sent: Saturday, June 27, 2026 11:20 AM

>Add "(Alternate" to "ID)"
>
>Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>

Hi
as the title states that's fix path we also need a fixes tag
here in the commit msg pointing out which patch is being fixed

