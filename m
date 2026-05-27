Return-Path: <netdev+bounces-292380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBkKODceF2pA5gcAu9opvQ
	(envelope-from <netdev+bounces-292380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:39:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E86ED5E7E29
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 761FE305C568
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441A93E639A;
	Wed, 27 May 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhqq9BSm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E92F8EBA
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899672; cv=fail; b=GmBGm8GeeDE2JuCx3gvh2iNFmBc82JqRh7M1kWB4z/LRNGVRZS+IocsWI3YvGO3iqY+8vwBurbHAu1ZQCkjHEnQUjjSkS2R4izOg1aroJw5I8Yrz4Qve326GOEPOA4p8ln+RZfsMUxipf1If9e5oKxbr4XEEYa4DNVYg/0U+Rnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899672; c=relaxed/simple;
	bh=oNgLM1OntZVj54GkGB4+kz31bB15+KTBPR3g977jZX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NhYMJWh7TxGjD6i441XeugkD3ifZQBkR6XW1X0xP4SXdXGBJn/CjTPe2ununfETpv4TWUEJZhqv8met5hntioc+7uREZNZKX45sKVLoGzwgdqtvZ7uaqAqPlLjMXmVBRDaGTjA+Yw2Bxg/KX0oE2GpM4tyM7UA7ID/5dBsPT7Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhqq9BSm; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779899669; x=1811435669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oNgLM1OntZVj54GkGB4+kz31bB15+KTBPR3g977jZX4=;
  b=dhqq9BSmrC9+HqefVzVi0iOTtWX4U53I9O9OCOYYUkDVnW8AaU4UJAY6
   kaAD7yZ4LrB2CZC2NinqhdWRR8IFsKHMBFXsmgw7Eb/705ezMKwqPU++M
   Kh1JG7YUab2pL8jBHyDv/WfclKKT7ygyVQEs+h1JHc+yMGhFbt68PF+L5
   QPR2YaFNig3SgDA+i6ZKFToh4ilYZAktBS9zxpRtZjkAJrtW61w3kjDfc
   oPhTS0uWXdud24IH230joCGqlGIrx8gBl3HiKmdQIxZOBN8q7uR6sjt2T
   2DE+QflG/RbA720I9LaZnPeWPaCFijS87CcapwIFxqWFviB2pyL1DXPHc
   A==;
X-CSE-ConnectionGUID: Y4bs/+A1SS24E8GIN9YkJQ==
X-CSE-MsgGUID: a7tzvisTSgWICVY+byF83A==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="103411598"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="103411598"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 09:34:16 -0700
X-CSE-ConnectionGUID: 28Sy3/coShurXxquKKmqaQ==
X-CSE-MsgGUID: GX8kD6GFQ3iN3blSEc4Wmg==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 09:34:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:34:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 09:34:15 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:34:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLGIU078bqZmDxTqsq0IqM1gq7FZrEMC1mGF9nINWdFnjSsik8X7JVn7Da25FP3S6FZbwbX3aUJGdH/wCsa3UivGmjDL+TAX7FFzgVBFJKqQV7eU5tA+kZ08Q3BKyhUvSdMfUbrWn6ZR6AyiKEc/vEEY2lu9mCeU8JGt0KmZkjnfVTwagBZ8N55fv6JEwEB14F9kI8KyHB8dq9gJVDfG6l5vn3oV67Cm2IuZkK/qfUg814jg/vo4BFCZB9ypTpZ7MVG5VFP5UPHuDla4jOCv7DCOYfBbg2FWGU7+ZPT00zbu4OYAG3nFUn6hZHwI29J2rHkFTQwZX4Q9Rp4nM0TIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKP9feFG/ytxoemq2pgFhCYuxZ5A2GCPQJFtH8+JRBA=;
 b=EJs0+ZLXCFuQZ1FK7JMc1UBR50bisORGOFQvSyE3PKwzq+kPOd5fb9w1vyqw/CjrZI5ZrOjKu71mdXQ5Cn9MRq6bq1nVoRQMpn6CSdf/vSGmaQEduQY18OeIyttKuNxydQmr2r6gyfO+VZ9xtVIdRCfQ5E05jS55kjGmSXxfp0AT1oQjPYFq7mQxDC6qwwJNrVBg3S85Te7ablCle6L0yioFU6kah6yQVppsAgmn72f/6Fk2+47sQfvTJ6ha2qH0vb2nxrTC3fGP757HpLUx8kHBE+JrN6DWhQyZLIjTcoBUiQO6psUCeozc+WIQyxRj03pR99Y/PNNIRh3jzd16Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SN7PR11MB6827.namprd11.prod.outlook.com (2603:10b6:806:2a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 16:34:12 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 16:34:11 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/8] ixgbe: lower
 IXGBE_ITR_ADAPTIVE_MAX_USECS to prevent RX starvation
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/8] ixgbe: lower
 IXGBE_ITR_ADAPTIVE_MAX_USECS to prevent RX starvation
Thread-Index: AQHcx1llz1IB4bnn9Eed7SqVLvrK67YiXkxA
Date: Wed, 27 May 2026 16:34:11 +0000
Message-ID: <LV1PR11MB879034C31FE0DD27BA21A15290082@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
 <20260408131216.2662245-2-aleksandr.loktionov@intel.com>
In-Reply-To: <20260408131216.2662245-2-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SN7PR11MB6827:EE_
x-ms-office365-filtering-correlation-id: 7424e2f9-38ac-4312-fe65-08debc0dc886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: +4xZA/Br7hXPlMPBjtwCxqUeJDCR8xfpTQSk+bK8rZsdhgCkCWU9dMpP019OYswCsf4BagYqH3Tdo/SPHF4PV7YVuDwUPihistaGdue3s2+FvjfprrLOwhb+jEZFFW1Fi9zE+yScHu3T5XAkSp/5j2fJOsUPNrPcbfIkmBMB4x9pgU0oH3yEfLowfKTHEjTf3FhUFtfZvGWShBs7LN8XXZ1nHqKfKIbU5eSjLJsjYrMPsJc3PzDQc3nO44HGXsAVsNLZ/U3ZwKZRYv69thwQJn0DPb6uXPaHO6OkDo/rC/NWhja6VtJcXI+AcZIPv0b435gVFijEFy1KsFuLsFgl03HV8GqB0x4OenqLCGJM/xjiwTu3g2ca95d+iqRSqk1xpv0qbN4RyfFLTfriLop+UIB7gtznpCX2qNn1866KrbIZvW2Q9pKMB9s3Ojn5lFOqQ684nYE+7qGBXhFaeLrxojT6vsMvDBtDLRcnFvV8Kq//rip6ICD8lP2YOES/yg/O67wqy06c0tMGMXgqBba2s38rDugDYtcRNEv0HoBhin0IiT1/qckSRpJT3DremYe7dgxVWCANEkwiXs4Pw7UOfM9bgmzEwhhiqdfLCe0l1ymjBn2ipaJF4lyEH5yBvPeksK7KUS9041fxA+MQLfFssK5ZYD6BtSqRwxNt2ufwHXJlEiL6XXbGYGQHanvWR3SX5Iz+ZdxYWsZQtIO3GIzsAOeLDlh3y1dmvyWGaKRWrD6zX3S2CdV/CRlsE46X7Lxl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wHKMwKsQ0wlcPd05U68NcxsSojBdZzLdd2JUVzw35cmFFYIrhVEmI9JHdsOU?=
 =?us-ascii?Q?uDc5AAZ2+tmyJ5P1v2LuBBzMMYoUAJEdNHwou6sy+FjjvozjAGyE2q1deFmU?=
 =?us-ascii?Q?DYNZ5Nz6p8rWwUvNVFS9PANl1A7y/+ZFP9ljDSEo7U0KzzyYNjqUPQ+Dk+TP?=
 =?us-ascii?Q?IxfL4F+NSkGmd16ri8xu9JsZcoTsuEKYMeRJ04/Ob8kTZIiGzVXMi43D02wB?=
 =?us-ascii?Q?1le2kjtivLW4EstL7LCRcTbkBA/ZDvdjaxRAtmY2WMZc+Mj4ABBItr+b0Y05?=
 =?us-ascii?Q?ZWLg4+e/v4QbLVLqR7Wy2520gvWnOjhMLy16Si1DYAXAgs+yTmwmZnbAzPNp?=
 =?us-ascii?Q?vU7TmDQ0/fDPWLxUEtHR5WC3NKckvW4BbnmRK11UR8Yl8d4LMeAr8/MpfBS6?=
 =?us-ascii?Q?mkK2H2s/GHLugf9PEsOmuRo8VCNVwGmK0R3e/EuiCysw2McuVKtnz0fBScwn?=
 =?us-ascii?Q?g47BDjlx2rOcJglTl71p6Wolh+VpxHysW5E3xyEYB2517+p5CgctS5sOxgmS?=
 =?us-ascii?Q?IG93sXQIVk7Bh3YemZhT3EoFsxyh0/loZzAcr0plsyRHFPl0YSCeO+7mLhdl?=
 =?us-ascii?Q?sMqMkwhOX1TqbPg5pV7OAZnBtHvPUNVp3T8PMyKeqG3XQoguVUa2D23PV6/U?=
 =?us-ascii?Q?yIpVmSy9m6SHyQOjHUSnlOQhIYTTnsekOWzDlFVNMCrY0ya09Jbr1EPPX6uo?=
 =?us-ascii?Q?xIjBj5yHPfegPaLIVcqX7Yay6E2O1XNvtmCwcXY/irPfsfZF30e8ziRS01XI?=
 =?us-ascii?Q?9+xkJNnuaFRl8o5bW/AAuwxCJs/HE1uJ+z8RjFhh9ckWRoUzbhoHJV/Y6Gj0?=
 =?us-ascii?Q?es8CV/pfvphrXcA4p6ofQtk7EoAPcbqZ5rPeLm8qUxnIYxMkZweNBz2O5bpw?=
 =?us-ascii?Q?b3fbcIhKH1j3x+tUIX/JTKKOs9McJULWtT8yNrYjPd+lBe7O+I7ATzXmX3P6?=
 =?us-ascii?Q?UwZlFbLcUStbMuB0Eer4VAon/QOFR+hcw9LuGpi3YGGRxTKSZ1kipq+o+jbQ?=
 =?us-ascii?Q?fCWhkEYugK1ZqdG4wfPDdq/IOgnVe2pP3RVhB8787H9uY0DkBBolCt4nKUVF?=
 =?us-ascii?Q?Besjk1WvJiQZv2sVpmE/dkV/+eAcGaRRQSE0Q2cmUBv1wtmAWGJo18D99tV6?=
 =?us-ascii?Q?KWqLR7LzyUUG0uhvkRJriwkaqkgKu18kbRksCCl/p+LlwbnrIKagM1irOU37?=
 =?us-ascii?Q?/T6u58jHwse+ge45CcXVDIspbqpjCEDEbxb+3PtwtPiqosOPxDOMC6NV7q8t?=
 =?us-ascii?Q?9QizxFGIEucSflzOTLaOjOUd9CFY0gHhXVxLZGm9byRg0F9PphwXZPheEtp7?=
 =?us-ascii?Q?I8obWPgysMMuVbRUGn+NG2Zng+89cqfRZaHny0XziYlFwJrW4tXa8ZfnpDgJ?=
 =?us-ascii?Q?PCbWMWpVBBUNqreQLXsAe3A/yOVQzwoubM/I5hrAE6czmfuXg7auARSEZk8d?=
 =?us-ascii?Q?k89IryG1hf+JL/KpQeN4E+wtQZYUgqeMw8R32Uma/eJtLako0vTZ0hxWB7nO?=
 =?us-ascii?Q?fOud6Bea5lbq2yTFvBJeTDAgiWRxhpYeTqw4RBZuIvWpuED43kLCNf2j0/iC?=
 =?us-ascii?Q?EapPsIaGLYcnq8p7u7tMlOgcp97MK/g+A5frupDaWMNVWU8jAyZOkL9Xoos1?=
 =?us-ascii?Q?ZFUPcYkErFnqfBwDeS2uGbiaVNzAtcq6z+eNuLWnM2SjpyfM+rx/Nbw2qRLz?=
 =?us-ascii?Q?xw1CrSkvsYWRqpvvOvbMnqbTJ4P5EJ3RHFxaxjMtknBTTwIRFn8YLRcgbtWi?=
 =?us-ascii?Q?RZGxbgP4fA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: d6Wolo5nvusycpbW6OIDV9LqxeugqoBPVNHD54daTkVN2TtK3LUbdG02IoYZRXr4/xE78uCV4gSW8b1wEU03MLbVy7YBBqYwdNSvfwcfup6SdrwaP7NmeH/Kdw/IefMlSkQERpN25A666FEPrPxc8XhgcLBpx9zffBaDXVsF+pLrjojUrX7lDDvRQ0ecWWLVgdrZLvNqV47yvb8qfT98+zJNjbAS0yLo0BwC9DvxLWzMcEVBAuSPL/ZEsZBd5PkkWi4oAZzHEjv95GeMh6i07zoyuIqLQwQNT4ichEskCO/Aw5p7oMWScp1c/8WwVEie8AQ1FDgawuLu5s93I7ywqQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7424e2f9-38ac-4312-fe65-08debc0dc886
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 16:34:11.7827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3SwHr9dtXwVwgU8xm1DzPUfdc8F6tmr+8RgIN+Q5F2aVUkhdLtChd/sdaM657DgfpVMlg+hewHHdXUyzfwJDWR01mO8agxNU5tnk27Uikw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6827
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292380-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:dkim,LV1PR11MB8790.namprd11.prod.outlook.com:mid,osuosl.org:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E86ED5E7E29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: Wednesday, April 8, 2026 6:12 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/8] ixgbe: lower IXGBE_ITR=
_ADAPTIVE_MAX_USECS to prevent RX starvation
>=20
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>=20
> At the current maximum of 126 us the minimum bulk-mode interrupt rate is =
~7936 interrupts/s.  Under sustained full-line-rate bulk RX traffic this is=
 low enough that descriptor ring starvation can occur before=20
> the next interrupt fires.
>=20
> Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 us.  This raises the mi=
nimum rate to ~11905 interrupts/s (~12K ints/s), providing enough headroom =
to drain the ring before it wraps.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2:
>  - Split from monolithic ITR cleanup patch; this patch only lowers
>    IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84.
>=20
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

