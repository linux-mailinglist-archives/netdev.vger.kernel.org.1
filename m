Return-Path: <netdev+bounces-292602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAryEVYDGGqdZggAu9opvQ
	(envelope-from <netdev+bounces-292602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:56:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E58175EF0DA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D5E930DBF86
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2814238AC64;
	Thu, 28 May 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0USjkmF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4052389E05
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958365; cv=fail; b=ezL4hTSovKMYR0hN6osMtKEy31KaSDmdf6O1QNWqdkctOJePEuZgWMOscTIIUdpTtK0GNWE2NVoQTPdPtIOncFP0W7jAT8jtgfXc7NLULE7ByxykvB6LFeh7lBYI/mmOb3JHI83HVWBZFCwsq4ocCc61uf3nWxitXMde0VRFvNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958365; c=relaxed/simple;
	bh=ejKZBvmqtENkFCN0dgBc1w/duPsvCPKR7ZNt8UqqKL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGxgxyx+xdPlr4HJRBdRD6T9sQhmoXaL09IIslRBhbyAEg72U6UQupNSp6lQPk8sVc5NxsDRmCHgs58VBdSuBltVdcVuCx9Roq6WDnzM2HB200ZdXak7oOaDL6+sjodaaes7ikwZd/b7bK6TLrorZX0pAeWHy7dl30hTSsZhM4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0USjkmF; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958363; x=1811494363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ejKZBvmqtENkFCN0dgBc1w/duPsvCPKR7ZNt8UqqKL4=;
  b=k0USjkmFVGWbbL7Ndchszr2kPlAN4UvGxya31xfXzTIhwqYVvgae+NOq
   CTsVXZeAta1NXR5rPxUy4i+AX+pacmVYsfDMbo8Nu0q5uS/t1xPaUOMGK
   XWmURVgRCWaQILaTmzfhcCfTMM4JhtHXD1Kxzcm/lm95ffi9EVhj+lB+7
   lac/jKrWnqjbaKLGgoB++x81Qst5weF73ZEd+/+M2DjCwoaSY5JTPY/Oy
   J6VoN3grZHb97OkbxO1vME+Avyzr5Pvc0jOV8VeAHaUXEzYULg5QaY2YB
   aAiYcw5zq5T74EP6DdcHhmCqzXxU+9ndHcP1vhnf/4dM0dBnCTZ/5MEd7
   g==;
X-CSE-ConnectionGUID: O/3oD+pFTBqKHbfFuXsYlA==
X-CSE-MsgGUID: achoy2WXQsyufw9n+cOXBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80825051"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80825051"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:52:42 -0700
X-CSE-ConnectionGUID: KuTDq5TjRaCnPOs3gn2ZwA==
X-CSE-MsgGUID: 35hUmKw0Sy+KPNSpdHVmbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="242650959"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:52:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 01:52:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 01:52:41 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 01:52:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ8tsG34qLqeCFAmn9MyQRF9KeA+PvDf1G0tEFzcbKUSwdgbHdv1Q2YLzX6H9WRxTzacfXNK1lnP0qQHDH62WPUbml7GG4+0TNAQPqbkoT7V40vfonUuQh1d5ykjvMhc0ObaAFy0Ow4JvCf1WdfJ8Zyoig9TgwjI2bc5zwY6OpEebLu8OMr4Y1hexYPLahAvEZI6qni9HHK5Hb9TyWlfSCwXSujRcOggV5LgDbrLM3bWU6xbJufcKyUbixN4y8pEhc8pdqgKEqRS6EQLXbb9pGfGVykxlFi6Z2p0qZpOYRrdKz05fHd9ZXj4PARpCN1rIJMrvrRSqPRQ3KeCHrKVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQRmkJluU3LmWJhpcApsrtMGzZ6tT5eDNsYJ/44c44I=;
 b=VVFOJYW5vL/2yYZBzETSadsa8oDKHwJdMQuwYK9kqEVW59xlZE9GkoBP4fJmmApJAbx7hlRk9TgBhvvnN+jelfGWRSl0VbF7Z+CgKjoWqrD8AHMelPETJj0vNNHMfF9kTjwDgU68WXJkQBBO0C6HDnY7YjwNlK2iJ6sDiqqMm+NqG3oydb0eXAyv3GGRowURETqjP3j/7JJFCLbUObHEXprv0o+iuqi3wQCZJGhr91T8GThAuo07J/WidzPnzvs+UZwfi6YRD03YM1fFQ5g4SoeusQeFIe7SvhXoKfFHXwMjtoYmRkTfOGTM3afLlmV7yIfg04zmi+gTrrsy05Jj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB7104.namprd11.prod.outlook.com (2603:10b6:303:22e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:52:28 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:52:27 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jramaseu@redhat.com"
	<jramaseu@redhat.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-net v1 2/2] ice: use NETIF_F_HW_CSUM instead of
 IP/IPV6
Thread-Topic: [PATCH iwl-net v1 2/2] ice: use NETIF_F_HW_CSUM instead of
 IP/IPV6
Thread-Index: AQHc1uN1hU7Zw/f0VUOSnLwRTMNKvrYjUMmg
Date: Thu, 28 May 2026 08:52:27 +0000
Message-ID: <IA3PR11MB89860F7A86A47D742BB2A806E5092@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260428070647.777141-1-michal.swiatkowski@linux.intel.com>
 <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB7104:EE_
x-ms-office365-filtering-correlation-id: 41a10a79-4390-477a-bfc3-08debc96721f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|4143699003|5023799004|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: NAZoB18UghKmacCb5/zZc3ZQraYS76SVhdVkqrfQSGT1ev2operf8xwMt7R6UsNV+w8Uf5X0Je2PNNQFrtgo2ANKE1J5qKZagRdRj+Jnv0PSNC+VImcj0xHtk/hYQuGFSjVAXQAEHR2161Iy4UlD3mGuP8tne422wtOd8u3SRf0cRwg2k2x5STQvObY71YQkvUt4gK17F4duMEwZWeqlLbzC00y+MHiQR3Y6oULIWqwcUNlPmJoP9PLweFdm5J57xcENAEQQXS13C6m6ww5DFaf5fYotk21T12O5fchx2PSxqrODjJA/BePFsivQ87j2nLFuVKqjIWAWwZQRUfv8VQtaEuNt+xbpqM/3TGEd3TIrWD/Libw7aoA8BzDVn745NEIRCN7YnFbCfrpuaJ5XkUb5lMpCndeyjOw2NtAA2wDBMgijMGu8v58rB9YA40suMotDM1DKIoBtK+LhLei3e5XQn0I2nCMKEb+FbnhAbNTg9J9LjMlilBXULVFYuvUcQ/6I13Ft9Ey2jlm1M040b51JTta0VKHe9xR0+ibDdtMCUtBZO0wEmWlXHjxYVI+J29MnBjKeJbH2LvGltSFj7VfIult79MyjEBITd0pUztvOvp04dqnQmoe0eGxaIJBEEgfGMQFtO2hfiIkxgJpBGAxSPDyefjyusnnp7YUOQ685nsIrQ+rqkh7U621R2iSgoORYeC7iiUULbAmlRkMWgfPjG2O2mS8/Yuu5zMjMJYbE17684OV7mJxYg8n7D/xC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(4143699003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Sxpz6WzDvbnQtWtU+VOTnYM4vmNiheIoRZ0e3jKfzvo8BX04n09PFerLiQi?=
 =?us-ascii?Q?1SrtgrFwIViGwlDP2Ao+y47D4OJZ+SoRQvpe/2PdNi1DllNTtTxtsD8KlUrX?=
 =?us-ascii?Q?xSIEcOFBz7k+l9Tv8JlrUyHFpEzjZp1j8ywVMLepV1QtA+9UhwjBAhJRa08k?=
 =?us-ascii?Q?ialREtI6sdmkNIiDmSoQANkhP8J6KMhEHldHJhLuRU/OhuleKw/G8L9Rz/oG?=
 =?us-ascii?Q?nr1E8akA/Jya2U92GNHK8dlNiFrhJTloKyRPNsxvacrn/vB3GLSNVNKxObg8?=
 =?us-ascii?Q?C0hrX22md0w+Iuq7ligBqnNprmwB6t1k5pwEm1QOX7IYLqHlg7DuqFtIFrvO?=
 =?us-ascii?Q?WRVc3ItXDMi8ot96kBW+H2am/lRWY4HRMKXY+8yPg59vLikXd1+FcfQxUOMT?=
 =?us-ascii?Q?GB4kApvUHH4It2cvW1p9hxTiWrWCk3f7gMFxtSYwwob4k7KRnMapQMRu1iPY?=
 =?us-ascii?Q?X313uPnJ1qi6PwNSClbyKWUsj+rlBs8N3yj1t0Rr0bJJMDTCbbhJypwXRZo/?=
 =?us-ascii?Q?pGc6GpBLtEnQybcxBlCR07nwh0OCrIlzt6E5QaHiC6/O6dFdfLOrbsELZifE?=
 =?us-ascii?Q?XZmfgWnGAbm+bT72gUvZBD/AdXYic3zVGmmG3YskjaDLRICX+p8J0MRG2JHb?=
 =?us-ascii?Q?PD4LBRUTiCsyRFwPTIJ5iWSX8nUK4fxN6e2vtKLJBynqRbbBlBWJEjV0RIqT?=
 =?us-ascii?Q?O1qmjfB44PL/vH4cGr/FCXa1XYryM1e13FTjlPVnKpfDn/+WHM3tjSnNk+xh?=
 =?us-ascii?Q?AzAWEFXli3+5Se4P1Jr5Q1cwNh6QxNkbAvm95XbX5keNn5MmINT2ZMJAZ+Ve?=
 =?us-ascii?Q?aZMUuElz637VehbzCv9w0sLd+qgobHWXb0NVPdHPsap57LEzVzflLzn/71E9?=
 =?us-ascii?Q?QQw81SxOdj8/DqgBUHtPn6QiROM+t7169TVfVJHilO+unpQBn2sF6+Re8CPx?=
 =?us-ascii?Q?SlAG/wTyQZvzplxlb0GBXvWw1aX7gVA0pLaLbF+HDmuVkBqaVz69tMFFBN9u?=
 =?us-ascii?Q?Rh3WiK6CQa1SuECF153qAyMvExOskwe6SdbQ053bDTetTzzT32F3pEsqJSyD?=
 =?us-ascii?Q?lWYkJzhe1avn8Rxk8gXFCeCNJneDALOiTY42qNiESMSRXfhZ/q3Gpei7kGkO?=
 =?us-ascii?Q?mavthon7m/4oI+i/2cm5kuaBvk3vUpCYPCn9/B6h+eSRAPjcu+JXv5TCTQIy?=
 =?us-ascii?Q?M8TQ6+fdLSLkMLhfxEQ2fvEdY7T4lSzCA0flLNUdq4H7IBCF/xw1Uj/wIcon?=
 =?us-ascii?Q?27AG9m4GzV5mAav+kfKpSD54mLin+mkh9nVnoVqq79kLFfGHRk10si6gFMZV?=
 =?us-ascii?Q?W9tCZOSrbenUCc/NOLxNqTwT087w31y2nITtCl0Rdiu5/fm39fHWQF4uD7pQ?=
 =?us-ascii?Q?ygn7YoSRDE8uHV6sjef1yxv5ITrSY7+TZi3jKBJA2KDCRvFpkDEmxUQ1XxmW?=
 =?us-ascii?Q?f14VDuEYC1muPiMdWryETmX2AQ3T3njTSX9y/B3qApkng1MhbacXS+MVWqtd?=
 =?us-ascii?Q?42E77aGbCUgcqJTW2DMcj91KHiwXYOLAHbqwQgJxS/UL8oS6x7QRNy5LJfdl?=
 =?us-ascii?Q?QOqVVEsfc1yYAQtmi0b47h8z4LBkzTnWEdCyJI3Iusan4ZS+EA1snKSwKub1?=
 =?us-ascii?Q?Sgj+GDD2JVeaVDdj0bmcK9f9N3VClXkcc9staYEmx/kqSHlnZa5+jva8lxWi?=
 =?us-ascii?Q?FP/k1E48opmkoAmhZwSQSaYKlY42Fyt4RstHzOjxl7RTr7PCMA66M1f3lpO2?=
 =?us-ascii?Q?wHD4FiFUuhPXwhi0U1a9+kOYj4JoqVM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c0HmASZk9TCRAcmlNfZdv1kBu/zfmDt71XfL8Twwy//ibDSzzJbqA9mguKed94EHqiZmy9ollSwbpzxx8WX80gDCuVqmutlnH2x9b24ppHKw2cTVI0/5Twa9b/SlboA0MtONMNGgHKphM4/NtsX+NT+AHvY5usmC4mltrIZM/OXb6rRuN7z9dK8FZ7tGo8QB/H0Hry7lPpaB2mjcnjYxF3MJImoOhDVOdTJgK6GWQc8a/0iQhe3E+FclD8uDGEy5kxIF1JIHdrP9GNbcJeZ/gN6gqGlblXH5Fi9CcUwLYZ+L35xaaF6+gEwoZ1lowQNurD/60Rr3yJK4lnbxW42+XA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a10a79-4390-477a-bfc3-08debc96721f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 08:52:27.8967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxjizohtNMZxu/CV3MW+Xpu32GfRMXGcBMP7JdtdMJqV4QeIWzOQb5MMBKWWGrKS3n5FyRY2a9DYN1SfdWSFyk7myUZZPrzfvPmcU7Zj1EY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7104
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [8.34 / 15.00];
	URIBL_BLACK(7.50)[osuosl.org:email];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[intel.com:s=Intel];
	TAGGED_FROM(0.00)[bounces-292602-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,osuosl.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E58175EF0DA
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes



> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Tuesday, April 28, 2026 9:07 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; jramaseu@redhat.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>
> Subject: [PATCH iwl-net v1 2/2] ice: use NETIF_F_HW_CSUM instead of
> IP/IPV6
>=20
> The hardware is capable of calculating checksum for IPV6 packets with
> extension header. To not drop such packets switch from IP/IPV6
> checksum to HW_CSUM.
>=20
> HW_CSUM is also used in previous generation (i40e).
>=20
> Previously HW_CSUM was used to indicate that hardware supports general
> checksum. Drop it assuming that if the hardware supports it, it is
> used.
>=20
> Disabling offload for E830 in case of TSO isn't needed anymore as the
> check for TSO is done in Tx path just before preparation of the
> special GCS descriptor.
>=20
> The commit from Fixes didn't introduce a bug, it just shown that the
> driver is doing sth wrong with the checksum features.
>=20
> Suggested-by: Jakub Ramaseuski <jramaseu@redhat.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Fixes: 04c20a9356f2 ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6
> header contains extension")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 15550216fbf0..0f2f949af536 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3500,9 +3500,8 @@ void ice_set_netdev_features(struct net_device
> *netdev)
>  			NETIF_F_RXHASH;
>=20
>  	csumo_features =3D NETIF_F_RXCSUM	  |
> -			 NETIF_F_IP_CSUM  |
>  			 NETIF_F_SCTP_CRC |
> -			 NETIF_F_IPV6_CSUM;
> +			 NETIF_F_HW_CSUM;
>=20
>  	vlano_features =3D NETIF_F_HW_VLAN_CTAG_FILTER |
>  			 NETIF_F_HW_VLAN_CTAG_TX     |
> @@ -3564,12 +3563,6 @@ void ice_set_netdev_features(struct net_device
> *netdev)
>  	/* Allow core to manage IRQs affinity */
>  	netif_set_affinity_auto(netdev);
>=20
> -	/* Mutual exclusivity for TSO and GCS is enforced by the set
> features
> -	 * ndo callback.
> -	 */
> -	if (ice_is_feature_supported(pf, ICE_F_GCS))
> -		netdev->hw_features |=3D NETIF_F_HW_CSUM;
> -
>  	netif_set_tso_max_size(netdev, ICE_MAX_TSO_SIZE);  }
>=20
> @@ -6489,18 +6482,6 @@ ice_set_features(struct net_device *netdev,
> netdev_features_t features)
>  	if (changed & NETIF_F_LOOPBACK)
>  		ret =3D ice_set_loopback(vsi, !!(features &
> NETIF_F_LOOPBACK));
>=20
> -	/* Due to E830 hardware limitations, TSO (NETIF_F_ALL_TSO) with
> GCS
> -	 * (NETIF_F_HW_CSUM) is not supported.
> -	 */
> -	if (ice_is_feature_supported(pf, ICE_F_GCS) &&
> -	    ((features & NETIF_F_HW_CSUM) && (features &
> NETIF_F_ALL_TSO))) {
> -		if (netdev->features & NETIF_F_HW_CSUM)
> -			dev_err(ice_pf_to_dev(pf), "To enable TSO, you
> must first disable HW checksum.\n");
> -		else
> -			dev_err(ice_pf_to_dev(pf), "To enable HW
> checksum, you must first disable TSO.\n");
> -		return -EIO;
> -	}
> -
>  	return ret;
>  }
>=20
> --
> 2.49.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

