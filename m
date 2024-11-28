Return-Path: <netdev+bounces-147685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D3B9DB313
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 08:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA1B166945
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 07:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C4C146A62;
	Thu, 28 Nov 2024 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiHrJD7R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E3146D65
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732778121; cv=fail; b=gipGOzil7sOTnmR9vIaRDK6iGVOHLW5yUebHMm6aBa135hDl8mQB/OATnRbptfCV58ukPeQ1C9v/JyKQ60e0WIWhe/0KOTncgtXRXLSC/W0ByD7clsgdrccEhThvSRf17UFhoytkRnK3nAwSHefyvhPKWb02EVJmeQ8u0o1Z1BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732778121; c=relaxed/simple;
	bh=yc73T2fniZHAzlwrAZgYJmvz9zcJqPH/s44gw4sI5vw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GhFBcg7tL07gQPI4/pnsRqX1KIOpFxDZcfUnKTAgGKwledhigrnhrtPVvkmrPXj7vewY7WPTmGNyb5HHPAAdjrkcg5hK4ec0WvzE+tfMTRnuliHUhgRFlR/RTxLcN1oNsZR5xLmpcgcyIMDahGHQVepB5JxXhFhH+JcaYCUl3P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiHrJD7R; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732778120; x=1764314120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yc73T2fniZHAzlwrAZgYJmvz9zcJqPH/s44gw4sI5vw=;
  b=hiHrJD7RDPNq/dYONo6togxlhKKqbZ9HHm8FVNYpJc564ECuXq+CkndV
   EAFCAEeLr0YyJKHo/gPl5r/FkkUTYXb2OYE59mRgJTyRbrqXm5hYmd0ab
   Avj+G0ssdHT1qlciYouiZlSWjDSCtqhgXA4ctio4TEOBf2MTQoeowWAFg
   mgV+HPredXVZQQlFqQPOI4ahrGInKevyXfImnAaUdBUdnt3PsrtBTrjMp
   1yoTzDMu9UxXUb/sr+wJd9XK1EaJnMxqwfyXvZ9jMLWD/lOUPD/6MIQbx
   GUe0qRyiUZamSStA6sJojsV9t26Rx4a6P7D4ya5DWxY2yK7Cb3/h3kUXT
   g==;
X-CSE-ConnectionGUID: Y9oZrZYeT1Gh8Y/XEmcG8Q==
X-CSE-MsgGUID: 6o3NDG4fTWq3TaKGqvA5hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="32860388"
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="32860388"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 23:15:19 -0800
X-CSE-ConnectionGUID: 44Zag0dJSDKs0/0jjaokEA==
X-CSE-MsgGUID: cD9MSpptQ1KtLwCi+ck27A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="92550507"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2024 23:15:18 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 27 Nov 2024 23:15:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 27 Nov 2024 23:15:17 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 23:15:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ke/FImRZANAucoxbOkiVv7vWAax07F0iM+S5NAT4zg+5Ngvxvm9iCuHIdQIrFv96hyoKKd4yPYZxVapf878owbbIRyNYPOlv2ghvv8EdeCVfoNOnmJbXPTZIHkLu18u1AZOCU57G3o4Nt2HM+o5zrrCDREgw3SsaBj2OTkfxX3StomYMj/GxBg40YIWJus05pizxV7lOiKmU9oZOzLTQykx+FYGjRQrsOm/I7jzRuag6yKY3YnQ1EIMPt4nU4n1Mu3Gy9oMoZHLnO/5h/2ZwXUCw6NoNIiFfjS/snlbIUky52RDVKMtOGCwDZoO9tymG2lSCSstvPtv/gCxZY8OAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8sUMV+wRettCwr5kmJ06UJAF+xUdOACwQjN0gfhwb8=;
 b=F3cH+qL87fJwCNGZAoLLDzhaKwW3Ta5c5nzgSaNCKQ+scj/mn76DVp2Dwdeg5FHvSOPNeLDZY10H+KzlVr2OQ/TYd0lJPWLU/yoTTkRmbqMjPnXh1uHv5OgfD3ZEWc7RE8zGRnDhvhkDL2xNvr4P5gnLBazoiuLU7x7EYaevOGGbYN/QX9Z72R5LM4gW15kqI8/fiM+KOcoXJLqb9OJLF4aM+r+98o4/cd/WIRK5R9+as5p3AznP4SARwDQOJlDhY0FueuufwfOfMwDx514Cu/uCC41iD+WGHenUmbpr9vUStRcACwiXNgxIjObcXag1PnLRHSojohvnsOYWqVEK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 07:15:15 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 07:15:15 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v4 iwl-net 4/4] ice: Add correct PHY
 lane assignment
Thread-Topic: [Intel-wired-lan] [PATCH v4 iwl-net 4/4] ice: Add correct PHY
 lane assignment
Thread-Index: AQHbL37lo+qmQss2f0yIoAY20jgYErLMabuw
Date: Thu, 28 Nov 2024 07:15:15 +0000
Message-ID: <CYYPR11MB8429810875B1584896FEFED7BD292@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241105122916.1824568-1-grzegorz.nitka@intel.com>
 <20241105122916.1824568-5-grzegorz.nitka@intel.com>
In-Reply-To: <20241105122916.1824568-5-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SA2PR11MB5051:EE_
x-ms-office365-filtering-correlation-id: 8f59d1a3-88aa-4bc0-8dec-08dd0f7c6817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7xKEPaBvAEmslhM9yaYneQY//e0H7HcG/AAxITK86M97okg5K42UF9nvM05A?=
 =?us-ascii?Q?NEGYWxmd0xkV/6EzfE3ldMTm8D7hEvipXt4WgApg8TzdU/WjxAQvE3oyCxcQ?=
 =?us-ascii?Q?RbzmmJN4AWD2ILlkuZmoBPKoMqBraIkxjrqXSXtHqx8U7RoZzcYt1kPsnFGX?=
 =?us-ascii?Q?SOG3LZOZLU8FSaKOlqUjUD5tegmlvM/zUmr6vHzvWY1QyF779eUkfnlN75mq?=
 =?us-ascii?Q?mfEnsQtPJd1L0Drqc4inzvIifox/2t+a32EznjMVx7nk2hAJCOk8GMgA7PGp?=
 =?us-ascii?Q?K5o42LkjWW6+MaeMyVecD9F+6PaunDjlz928rtC4EVNFZpEuh3FJIxpe2XM2?=
 =?us-ascii?Q?5AAz0awRYG6K1v1y20tNBRBYIJtHteRofadrlqgc+aZp7Prb6GLush0WZFpM?=
 =?us-ascii?Q?Mg7R1HOQOC+CGtxYxvUs3zEssvxGsRA5X8I3kx+7a0XxVK95LzRO9TooDUve?=
 =?us-ascii?Q?We0lJ/5kFoWnYaN5Y+SeUqT6zxXZP+kBnna1tycuopf923//8cXK/5WiFwLV?=
 =?us-ascii?Q?fwrCYZkkSfGqy5a7T4PjF06Djmu6IR+fJPRA/9sVyV527KeEaTYNFhJtt6VX?=
 =?us-ascii?Q?CfNBVanfuZbYUgHKCSd41IEoYC6bHwNYGAEBOfryQtNTHh+OHQcJMDrIC6Zu?=
 =?us-ascii?Q?V1gng3DeMLUFkEJ4oEBzBQqLkl9Mxt01teyDc46UL70SmVK9tqxpnlzwDCht?=
 =?us-ascii?Q?3hacnMV6FVzAiu2PvN7+R0oXN3HdiwgAR6fCSkDa5vKkgg1YQiEudeWGvlxW?=
 =?us-ascii?Q?E2HeXentGhoK+UYLUCgWdTzmGBiu8dpJtJAeWBb/5RpU8zZ7WzpYDhivhIrL?=
 =?us-ascii?Q?tlkFqgp4jciEm1iGcWUV+Sjd25gD2cpboYoXS6O1hd/7BjjC+rkJ/1LZV7/M?=
 =?us-ascii?Q?rP+OLBSQlYbO/Vg1DAzfAzsenypTCXmOfysDPITsnZ4AXUITlnFiMoDKlGGA?=
 =?us-ascii?Q?Z0EtRMvhDNhR/YJ7KyhZCNBl5wytt4PIVT6SWH59B+JSNnKWkNzX3NEkvYbT?=
 =?us-ascii?Q?1Fuk/hCqrQgvbWpFdNP+kj7J2PJMdV2uZoJu909GvX3v7SPqoS+hZLW8OOaC?=
 =?us-ascii?Q?z9WoYEk7zjl3hG568XWclqEnEmqS6WoRXaQtzK0pWECEDQVZzAFB9nQ4sgP4?=
 =?us-ascii?Q?GWOd9QA9PZizCV3ZKhz/LdAlkK+KTqXysl9uW71I/oBQ79pvhLbdYQUTmJQZ?=
 =?us-ascii?Q?GpcRHVcXtdD3Sr5Qtnry+9gIhPfwZt7E2LZnMNYGYxI8ZDyXzy5VlYZiel0C?=
 =?us-ascii?Q?RYvQIPUTRLdTZndGLJ3RgS/gcxovXR2X6q7SXIVGmKmq4xxZsdR/955TKXGM?=
 =?us-ascii?Q?OPsx9CKmcY4ccqY3PhGTfCeLPF5GrLqXc8m0AseeQ/hbba9FZ8/ahUg2UfC/?=
 =?us-ascii?Q?T6wvo46QIVjWqAgxG+aauSrc3L568vnenXxmdAsnDfWbA986JQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AYBZ8tsIFUBjRMlo+oUZnYr/WBzMcNvrJgsCJfYYpFhx1ASAlr83DUr3SI29?=
 =?us-ascii?Q?C46mdDLKkSDIxbqmL+bDQOjKwnfAGqFI2k2iKqJi1/0vpE+ns7f2pwwDMjQ5?=
 =?us-ascii?Q?VaQpMO4QdLEht1w0tXjhvnW8taJP9c3VH2rbYzzTdWisHbMWlV93z03aW+Jh?=
 =?us-ascii?Q?9O1vL/1Fyv3DVC9zsHEiXAdUCHDgkFUkjcsqb2K83o1yoWruZrcUVjRmodmk?=
 =?us-ascii?Q?YC9GrluaR9oo8kyYGeb/7F4X5CAxcX4afip5vbJF7Yu5zEneBANuRouD/KmQ?=
 =?us-ascii?Q?bceyxR6lXnnrhuD2g5nx91f4cPgCfQ08cu3Be+jQuQLNZNsueHG1GVnsG1ca?=
 =?us-ascii?Q?xPYYE9NDIfX9X6wlkzwASW9RD4mjQjiQthM0FeZuPIO6FXLZobHib4f0gPcx?=
 =?us-ascii?Q?iuzp7MXFPpSGqfu+Ugq1Rehbg2Vm5hHMhJwTq09foOu35heg+PNZDwk8fRvN?=
 =?us-ascii?Q?L+wTZdft/fmuOBs+16/36/UdlC1oQiHboiY9XCCHmUaz1HUkFKNnmaeOPQ63?=
 =?us-ascii?Q?cagMIaCEKLmhY6OEA3/2t68pobOeeogMSsFjBRBdhupP+6koLPzGBtNlkIxu?=
 =?us-ascii?Q?K7hq/5rGIYfp+qF1tZzLOKE/6lw47NiWYMMU2fg2piKe1FgsOJWXQoSKIR0m?=
 =?us-ascii?Q?zXnsl8SxV/8/oplvfBfofLigcltrLhupjG/UgRUcsHuKOxmGhnc513YbQ+ZL?=
 =?us-ascii?Q?wUzTN9Z9UKQMaEM6Nmj9RVZgE1GTHqY8BsjIqcCKFjQObjeVCap6DHdgX5ne?=
 =?us-ascii?Q?5jmrJYE1Sb0uZIGt1BM0THAxmEO4twMmMylZsYFzAMKRXKeJOhB+wfZbrxh8?=
 =?us-ascii?Q?qJkczQa8XaiQvcnKKwH3T755ePnXJy+B5P5dov1T74CFk6RDUpGV61aTHTC9?=
 =?us-ascii?Q?3HQX1anjrTijDk7Pd4aPsjGUb5gWg1px4ACgJzlq4wzlY4fc4rnc9sdZhgmk?=
 =?us-ascii?Q?3ZUve6hqCWBBQ8NihhZZRc48LWhiiujg/MF/QpNHLdBZ6rHoxK8mUfPNd+oA?=
 =?us-ascii?Q?+hb+KVYDgqiSeYg4qg6HbD1tjhew+ZNfcyE8ri/0W4r6rT+q0ivvKX8mpTOM?=
 =?us-ascii?Q?ZBs/Nf1ZyAxxMn+zxDYs7pckSLYhBxe7eWl8+CYOwFJIDGzs+LH8AFwNd9de?=
 =?us-ascii?Q?sLADetfxDNUhp/mxcxB+6YX1lczNKYsD6xVNc1ZGn57Bcug+7ZsqcExFZaZM?=
 =?us-ascii?Q?PeEJcJOE8vpr1x+JMpoybEgt6q/7pOZm7lAxTNM15T7u/laYXBXxbsUeHZQB?=
 =?us-ascii?Q?U7Bb6BmAAySg+C2ex22VNM3QrY1R8EpdRNuvgPyGHJhhRcetU+gi3hRFX/jr?=
 =?us-ascii?Q?5i0Su5AXbHRQPbe/26lytDapb/ZcAhnSh9Dz/94HUU49JDGf31D4tGYD3t1y?=
 =?us-ascii?Q?CQ18UIec4BYNPILXNMN2M0tn2j13iWrnYbc1IDlDvTFmOw+5gFGTOI1W1YkI?=
 =?us-ascii?Q?KVotJ5xRteRg3DgbFCKg9gTgjGy8iq5E1wJuRTONXEyYKQ1M6yuLa3jZo/Un?=
 =?us-ascii?Q?BXulxJTzSakV+BmvfubNZDSWKCSNuJE4wOpVA960sL097dlmXktzmtBlmhDM?=
 =?us-ascii?Q?2djR+I18lW2gFUgWDawgsge+ZNfVMXJG6xLhXZGFbZk/1L16PaonN8Jkt2To?=
 =?us-ascii?Q?tQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f59d1a3-88aa-4bc0-8dec-08dd0f7c6817
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 07:15:15.2875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfAKm1sFSTqMcEw9yIouP3vbmGQ07d7gfrnPU7lZM4e1JSiEGKgK9oKV/7yjbc7RkS799xstaoC4uFBMw3+TDyuvm4+9iP2TmerQkPzWzlb3cUAccY7LBnoQiGX2ZtxG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
rzegorz Nitka
> Sent: 05 November 2024 17:59
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@i=
ntel.com>; Kolacinski, Karol <karol.kolacinski@intel.com>; Nguyen, Anthony =
L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>
> Subject: [Intel-wired-lan] [PATCH v4 iwl-net 4/4] ice: Add correct PHY la=
ne assignment
>
> From: Karol Kolacinski <karol.kolacinski@intel.com>
>
> Driver always naively assumes, that for PTP purposes, PHY lane to configu=
re is corresponding to PF ID.
>
> This is not true for some port configurations, e.g.:
> - 2x50G per quad, where lanes used are 0 and 2 on each quad, but PF IDs
>   are 0 and 1
> - 100G per quad on 2 quads, where lanes used are 0 and 4, but PF IDs are
>   0 and 1
>
> Use correct PHY lane assignment by getting and parsing port options.
> This is read from the NVM by the FW and provided to the driver with the i=
ndication of active port split.
>
> Remove ice_is_muxed_topo(), which is no longer needed.
>
> Fixes: 4409ea1726cb ("ice: Adjust PTP init for 2x50G E825C devices")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
> V1 -> V3: Added checker for speed value in returned AQ Get Options
>
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
>  drivers/net/ethernet/intel/ice/ice_common.c   | 45 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |  1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  6 +--
>  drivers/net/ethernet/intel/ice/ice_ptp.c      | 23 ++++------
>  drivers/net/ethernet/intel/ice/ice_ptp.h      |  4 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 26 +----------
>  drivers/net/ethernet/intel/ice/ice_type.h     |  1 -
>  8 files changed, 62 insertions(+), 45 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


