Return-Path: <netdev+bounces-286510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJL3HHuTAWrsegEAu9opvQ
	(envelope-from <netdev+bounces-286510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:29:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C747750A1C6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F1923081310
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D943BAD92;
	Mon, 11 May 2026 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTNunevS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB833B9DBA
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487741; cv=fail; b=oAx2ejwhKpeBCglqCKVISi+PsksTv5Z9KKXNsPWxVn19YM57fC1XIMF2dRWANTgdD/6188hRqXn1za0p8oBaS9NaDLJ82JU+qOAcrgzdluxdfPg2Ns5ojmISQqndrFZGmxP65xIBKDafw/5OERENoerS6vs++krrasCiYSZjooI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487741; c=relaxed/simple;
	bh=3gSleqqEjRs6+XYcw2YBvTAUSJxf7ZjPsBztIPLDQOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T6KCbfBsqsy5kIM0FtTx6L8PrtEPtLtwqHWKMsiTFP1r8gShb5Lj4c0UhRi5CGjW3fJ8UvboclG7hf1iFfzi3qPecOl6ahCbb87UAZFk3w5uCxoIXCYrAdGuXVwcsGZw2kh/ccBoNV4sG7svXiTdMYDTccPbXibSO88pNjVQjLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTNunevS; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778487733; x=1810023733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3gSleqqEjRs6+XYcw2YBvTAUSJxf7ZjPsBztIPLDQOg=;
  b=HTNunevSEfvKIoS5IlGO2V1Ca/U2yhpXdOZCV6xvOjRQnAK+59gvD/ex
   sgTp/1JhEXWov/4snXBSxbQM5faKudPLUFX5Oy4yui+Whth3StsFjgRnm
   cJ6CmapYrDOWBoqBjoziogK8pu/kk1M3FRPQI4hkeY9U2xaGxCh2YpLZ0
   Aq80XPXYvkucfAchh13GPBKDjoviwdJVKtT33RNXR1AfoNGytB+rRHUIX
   0bv1lp+u4caNf/TuCs6D3svybIXdhPOg9PjE7v5IDP42zB1eATJDrRbft
   ZSD94IfoXZc5RVzLnMqT/ayf/pjhXJUD0NVwg7Y04Ofo7s9JIFg7gT3wH
   g==;
X-CSE-ConnectionGUID: mzfPW7aDTrafbViEFaQybQ==
X-CSE-MsgGUID: IBesaFdcSS67XyrGYqB9Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="83215223"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="83215223"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:22:11 -0700
X-CSE-ConnectionGUID: de91LVXOT/eHR718wETkHw==
X-CSE-MsgGUID: tAhHYa0iSJOmfsAxcEAhYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="236531207"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:22:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:22:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 01:22:11 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:22:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIq+AYF7QhdoY7AkTF5zZTQb67sLps34V/DtGoV8sOwcw72RlAsjTDQAqdDGlkS5SwXXpeJLrvPoT2hxSm1z150M9BSNm904AbofnEFMOA+8Q+KMZM4/uAC/Nli1G4wj8TMO4KfjwEkU7k0qCX5Br9RnnE10k3u0USxhdzB+LArzXhwJ28lohx7HUzvt2a8iIq1J4SwAQZFFWZ3qQ/4Fq3EB4nxbm3G1YU5zk7CEqjR6is9XZChCk5EmYCsG+umRZY0DVUkNP5D73KIfdi+7ikk2Yp5fzt2JYjol28JnTvv/u2LaQOSldlkvvxLY9rs7GieAchFXbR+moZy2wCV52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaAvUicQQEfkVE1rw0ef5JYkA55owLIzLCI96pQ7Ve8=;
 b=KkF/o9oO61NV08rWnkrLVjC3a1vrTyL4SElaKwunqqZmsxUVeASF5JohnUa7lIDx7uFNYD9jULkP8+GgJyKWp7Zu0Oi1ZaSMKhviSjKfVkVJujtsjntGW/UZXBsqzV1HU6J6Qi9+x8RIYQYMMqjCK0EflCZHTYK0oOpwNtQ+Gyu31jIuJ98uKzatxGnah3obzPLHEynwjoxhC/HOLqD3jZJUEwsv/1er/UFcYJTYDikcKK7/GVSa2AwqiHScWhFEYDRkAs6VIlmagfO7oAXbkeHSm9XyRvIs31i2DoGWgy/3ZB2aB/vrqQw1Dv4GUPrHZ4o6BOExztWlUhIASWDqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CH2PR11MB8816.namprd11.prod.outlook.com (2603:10b6:610:285::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:22:09 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.20.9891.019; Mon, 11 May 2026
 08:22:09 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kiran.patil@intel.com" <kiran.patil@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 3/5] iavf: prevent VSI
 corruption when ring params changed during reset
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 3/5] iavf: prevent VSI
 corruption when ring params changed during reset
Thread-Index: AQHcyxeDMlghd9EP1UyUUROPI8PG77XgIXEAgCiG1+A=
Date: Mon, 11 May 2026 08:22:09 +0000
Message-ID: <IA3PR11MB8985D5FE47659060D840D3638F382@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260413073035.4082204-4-aleksandr.loktionov@intel.com>
 <20260415132858.805112-1-horms@kernel.org>
In-Reply-To: <20260415132858.805112-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CH2PR11MB8816:EE_
x-ms-office365-filtering-correlation-id: 39a41954-f2c9-4d24-a623-08deaf366518
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|38070700021|56012099003|3023799003;
x-microsoft-antispam-message-info: /in1VdeX1PEOHGhfhdTqH/f8mUwe8DD4zZpkWckb59Rzm+eSjvjhE8Ych28FDaJe7ONICyVrS2W0+4IB3PVYfLTyvNtIu+i2msi7KSecPtVnJDMphr1L0nFNXhz522u0uYIRfCno9yFYYIGSAH0owaaeErUhHmMWNSkShqNlw5LXat04SuPO9AFNWyM7pYHJJNuJJiOnCOZPszZYA3P2DTk4ev8G06gRE3PzLagQvTQS0m/tAPagedLDWgAhk4p67nOGDHKtZQxpC07kqvBpsLE04zz/05wfm7uyJDai54ZZNsBlMnG7SqGq3e5qArq/PGfVWNxbYFjruSncQBRqxJOXNKNwHqJvY8010rXNwIFifX9BofyfEJ+8hl2k0/IEcGxuas0oK7bcmdSMbjxlnMIU2hrj7EktDy11eYldSYCy87hK8MSxSuyBHVlUueaxWh21dOm/0l4Mv9z9vM8RBPmzS/YZFqjYms+XD1KWPX8QnHwwy392NjAjimt5WUy1sErCQ97rNoVp3x3hck9cSQKO/O+dIGydGoz6OLkUZMDJ15gf2lFUySfIQGBMhv5Fd8JAU7/EVDgzZusI2rtjSdRJPNrgEl3T5uIp8Q4SJUFl69t3SJR0k1N+ofNSog2Om0cqXX7WBAc+XhU5347FjzRZPj9qE8B0iTZKa5lmg+sh/byc938FffgOr+RAa/nas+Gm89OVPvCOPLA8KqzkzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FJejojPJ6qPDUqeoy+/yKBjPcPpJCCy0jdFyagI9X5hgDDbWwiKGTy3t7v/s?=
 =?us-ascii?Q?lMvVIFgcKjic3R76nmkDvNFdgYCnDlKjXJbYLIxVZH+IY6HpSczxJjNnZx+S?=
 =?us-ascii?Q?DKUzEqwKpGvTpDjSVf8ZdHv1XdYvwhob09oFSSQdNmH9UhxLHvejSkkkG9g3?=
 =?us-ascii?Q?hWUcZhgP8C8nP3iwerW13ZL7RdGe+pHeGUTA2NQ46anF7QP3EZY16sq4A54A?=
 =?us-ascii?Q?GoDvUrFUq7HZjucAWQZ+umVHE4AO4YX7Fh+DNjb+6VbbYAVgU+c/eve5JxOh?=
 =?us-ascii?Q?E85qGjMlTmXwika16PF027kmgCf8zh6Khfzp+EQu8m1OKvIsyRsYwqdIGg57?=
 =?us-ascii?Q?NQbypqRZwRb4eIAoMOIDl9YuCAQdxSD2uj4VoVAVGoVlyDcSIx9/lvMMf1Wp?=
 =?us-ascii?Q?j6InXL6L1kBBpyNcB09wYxk5qnfLq4Tb0YLhcXJ+dSBSt8cGf6RYlag+8LBr?=
 =?us-ascii?Q?8gczbyhysR4cSiWS5iFtTURZbdQQmMOOoJLNUax6LIvOu3gB+JZbVjCNrE8q?=
 =?us-ascii?Q?o6CM8pki85wqEUotPTu3ysJPdHeTxZ86MDXRR/dUBn68twT8fcnUOD14bKnI?=
 =?us-ascii?Q?ZQZJO7mC7EJx2cBbhRYVU/XQ2th0sDsRJQQNqWSTGq5rq1JHM9BymEMi9jk3?=
 =?us-ascii?Q?YFAmPIn+Ewx4KzeVfCWXcQTXZr9R69+LBL2sfDWYCNaXWA7xlT3UWMZUmcKk?=
 =?us-ascii?Q?F/Ug3IO8ytt6BGiM/oNCfDBUOUgp65Z4yw9YOya6t1GR0S7yelhVYfUkyAy3?=
 =?us-ascii?Q?/bR8T9AstsOw1YWq+xHqsfpuxD+GudFX0c6/cchIkkKa8dOioxxqAGET36/4?=
 =?us-ascii?Q?aSyv7I1UruE5uSSBY1ECrw9L/V7ShHslqqE0jPMhaQDBRhPeyDMS7zFDVkkR?=
 =?us-ascii?Q?R9wib+dML5RFaFh6ZBRWG36z6icacFMzt4oM/ykNNY/JhmQB6eRLpUE2RYs0?=
 =?us-ascii?Q?ltQ5l737hymOl1v1ZlG8KSWOAxfQkzNJotplLxWZctStBXrVP30UlQSbBu3/?=
 =?us-ascii?Q?zPAoCwAqUbsCEjpZQ198sClmKS2SmXsU+vW2OxOUN60UOAuDcJGDatKQF3CK?=
 =?us-ascii?Q?QqCZILeKgocBz9H3t9+L4GHtHBM/rmeHGk6vAWbHEv/++5J8EFpEJLnE6ljQ?=
 =?us-ascii?Q?hvlPfQoBdm1yLJPkM/WIl0Z/nBP4YlqBRpD8Y93AdB0DSBKJXbogXimsNG9L?=
 =?us-ascii?Q?Q8rz+zfnyQ3GKhDeKLraqNdx65efdHMiflXG34zZX2Q6uxF40u25IsKMgc1M?=
 =?us-ascii?Q?//LqlmKwrxr/4ro16GiuGVPTwtxgfGe7Cf7Ib1gQJpm4xe4UFJYSX2amYSaT?=
 =?us-ascii?Q?xLSnFltiU//jwwqINLmowZcjzKQAaBfzKCOIetcUHXE3GJNAAdVxGyqcLFSX?=
 =?us-ascii?Q?nGFJSKif1DXiWLUo96Hz5LyFV08EJAZRnXVEserIRukvCLXRCrN79GmLoCkr?=
 =?us-ascii?Q?w0NZHskLl+yhLbC5yZJl1/Fn8/JHu0OqZw65HuffQ8OxlbO72aADANkz8zTV?=
 =?us-ascii?Q?Mo1gOK9BVdT1p0diz7SSyhKrGcVKR9n2CYs0zq10EcqGSVdSPfhqFOVHWF0h?=
 =?us-ascii?Q?Ul/TB2pVNqX09rQojG3EsM5SBtesvCFOvDrzQc3yaZ6RkffQm7m54y+okQuz?=
 =?us-ascii?Q?Mes+Piu8G69cg5s/wEoe+wlAZoElYTWcBEQSvBRGuKvWY8pIOm8SMabgSReF?=
 =?us-ascii?Q?RbcqhXUipkm7E9mEkThb/hTNI5i3DGwH4NZNsYGtzfeV3Gq7x2fy6yQfDN3g?=
 =?us-ascii?Q?tX+yYS9qag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jyWDpbbhZpgV8ox8J4IL4LIQVhNn0fN18nf46pBdBq6Nznd+FskwVsLqwT8GuwARb/gBF68Fs5i9+DRgvN+ZC1CtTGJGiU50pdcz2fkdIR4dUNy94vzOUMHL85jfiqvakVojsN1CpZ9ENdiJLyZPt128F9oojQ+TRGIdy7A/qg8HXZOoWyHCFL3YwljdqnDXCq1Qm9vwBw+TRfkB1/A0qSCodaIJgqXybtUNAux05ExpoweiQGZSdCNLCspzxy91Esrw3wLeKAKcHBvwlpM6dmFh1rfrDIHb/0FlOKXsFSCjO610cP8rQsQY7HZf0JSblKMWeijVO/ufcoACkWMIGg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a41954-f2c9-4d24-a623-08deaf366518
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:22:09.2294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2tkS+Iyyi02bbdQwdhereEsoig9ZmVRdbj+pJ9RkRcluA+GZtCR2goFg2/HhxS2xEIIjIaQGpXrsmunHG3HqdXKKxXZyp2bBFo+Fi9osb+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8816
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: C747750A1C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286510-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,IA3PR11MB8985.namprd11.prod.outlook.com:mid,sashiko.dev:url,osuosl.org:email,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Wednesday, April 15, 2026 3:29 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: 'Simon Horman' <horms@kernel.org>; intel-wired-lan@lists.osuosl.org;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org;
> kiran.patil@intel.com
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net 3/5] iavf: prevent VSI corr=
uption
> when ring params changed during reset
>=20
> From: 'Simon Horman' <horms@kernel.org>
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l has
> considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> iavf: prevent VSI corruption when ring params changed during reset
>=20
> Changing ring parameters via ethtool triggers a VF reset and queue
> reconfiguration. If ethtool is called again before the first reset comple=
tes, the
> second reset races with uninitialised queue state and can corrupt the VSI=
 resource
> tree on the PF side. Return -EAGAIN from
> iavf_set_ringparam() when the adapter is already resetting or its queues =
are
> disabled.
>=20
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > index 1cd1f3f2930a0..390913170315f 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > @@ -495,6 +495,11 @@ static int iavf_set_ringparam(struct net_device
> *netdev,
> >  	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
> >  		return -EINVAL;
> >
> > +	if (adapter->state =3D=3D __IAVF_RESETTING ||
> > +	    (adapter->state =3D=3D __IAVF_RUNNING &&
> > +	     adapter->flags & IAVF_FLAG_QUEUES_DISABLED))
> > +		return -EAGAIN;
> > +
>=20
> Is there a lockless Time-Of-Check to Time-Of-Use race here?
>=20
> iavf_set_ringparam() is called from ethtool under rtnl_lock(), but the ba=
ckground
> iavf_reset_task() synchronizes using netdev_lock(). Because iavf does not=
 set
> netdev->request_ops_lock =3D true, the ethtool core does not acquire netd=
ev_lock()
> for iavf_set_ringparam().
>=20
> This allows adapter->state to transition to __IAVF_RESETTING immediately =
after
> this lockless check.
>=20
> Furthermore, calling iavf_reset_step() later in this function without hol=
ding
> netdev_lock() allows the hardware reset sequence to execute concurrently =
from
> both the ethtool thread and the workqueue, which could lead to VSI resour=
ce
> corruption.
>=20
> Could this open-coded state check miss pending resets?
>=20
> If a reset is scheduled (e.g., by a watchdog timeout setting
> IAVF_FLAG_RESET_NEEDED) but the worker task hasn't started yet,
> adapter->state will still be __IAVF_RUNNING. This check will pass, and
> iavf_set_ringparam() will proceed to mutate ring parameters and execute
> iavf_reset_step(), racing with the previously scheduled iavf_reset_task.
>=20
> Can this be addressed by also checking for IAVF_FLAG_RESET_NEEDED and
> IAVF_FLAG_RESET_PENDING?
>=20
> Also, the commit message notes that triggering a VF reset before the firs=
t one
> completes causes VSI resource tree corruption. Both iavf_set_channels() a=
nd
> iavf_change_mtu() also dynamically reconfigure queues and unconditionally
> trigger resets by calling iavf_reset_step(adapter).
>=20
> Should these functions be updated to include a similar state check to pre=
vent the
> same VSI resource tree corruption on the PF side?
>=20
> >  	if (ring->tx_pending > IAVF_MAX_TXD ||
> >  	    ring->tx_pending < IAVF_MIN_TXD ||
> >  	    ring->rx_pending > IAVF_MAX_RXD ||

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


