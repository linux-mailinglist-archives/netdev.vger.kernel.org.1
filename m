Return-Path: <netdev+bounces-227157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9D2BA93D0
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936AA18954C9
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D4E2FFDDA;
	Mon, 29 Sep 2025 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tf2MmjVl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76AA2BCF4C
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150205; cv=fail; b=XrAT/BHBGvZlxtFVPRQN9pW2CMCvw3u66HYXD+fY0i3Cfl2Ow7iJRqoWjlPK8BhS/LHtDYDM7Vj4rBhbpTIwQygZjCV/PPioMLWSyw4gZYt1rNgQU1+h5xfcbyIeaMvo4I0ZpncA366XaGWEIA97KTI6t7pWU0DwN2KMGsqikWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150205; c=relaxed/simple;
	bh=ub1Yc6xcumWy/bVTxcFGmEu4qJil6MHjjjw8Hhl/PFQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FAUQiTupM4LXAQIUOIxeGpfRK9JB9qCDwo6ziuOApRqAynNFYPynpGo4SO9BMtVdX2w8XnIfoGiO2ebemCnzXifwMaxxgvqrAfDzM7i/d3dSZiWCIwuWg581Nu8JfFRBYB5A9hgXZpvLuBfwf4X2jEUYZRihGMRbtxkgTn1EuY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tf2MmjVl; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759150204; x=1790686204;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ub1Yc6xcumWy/bVTxcFGmEu4qJil6MHjjjw8Hhl/PFQ=;
  b=Tf2MmjVluTehSFqXgcfl1ZVFcJnfFA7FjhFDoddXkkaSvoeckq4mM5Yq
   DC3xR1ZgMoVuCwlRpevzqWA59IhuGP89g1+Y84ekZb+kPYlTDfQhFI7g2
   1rRmlsohO6UrbawgpeQ43MCoF0NwQ5a+eGc8reS3HnJIbdFLV+JpePSbX
   fqZ/7Zu3f7wvoowBbxYI9SL85UqkJpi87Bmzc5FUAkWppzxz9F/bVanVf
   TDpGZQvaHDkSqYc8lJ4JokqTh7l7YfCHkdOXGpOOURXJYQ/lCquiqitqH
   hxkURkTXNcuc4tMS4zJZl0V/TrDlPHSrx0a43aP17fP5UrDfCrQGu5bqo
   g==;
X-CSE-ConnectionGUID: 6vf7YQW0TWyguqyDjcf6QQ==
X-CSE-MsgGUID: WglgmS46S1yJHpyFgqzbJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="60422991"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="60422991"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 05:50:03 -0700
X-CSE-ConnectionGUID: yrQUEKvdRcyHCTiYrBqgbA==
X-CSE-MsgGUID: mWmv2+HxTWCr7vyH15Mxcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="182220354"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 05:50:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 05:50:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 05:50:01 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 05:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bk2nBU+ZKTdAV6awR37M5SwKEV+Vb6P6+Zqy+KDLAKjIBQpyfijjnmiLOEvzXt8N9QPExNW9rZSLr5JVrcDKGWVREHQac6rLDncnW3226XFkC34kHcGLZAQA/EqRDrDHMg2gVkDUvZbgp6X8hqVFznbfJdSXeui/FBoZYkYgCe2uy7A4KndQaWmXzoIgQZv25kOOz2GEN3P7C3//6eoJ3Frj2RbgKr8JNa4nHqAKO3pwW92+8Ipr6Sa5mw5CA4aj2yVd3HbGRtpxRMx/iiseJ2KPC6Wh7qgm+ffGiG0vbxMH9bEQ9T5hKDHy5CfFUjL5AUJUM/bDYkx6A22gYbjyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j1xoR6hy58zo7uJjIhSeotgkZS+VE5a6iRtP8/mVK8=;
 b=tGOsgKSz4BbOFOeV5yyaJ/MvygsAVQRkhE/OESOORiFvaShGXCfDmulEgJofOz9JSLAIbE5qYrjjmR6MGsJMjFM+8h6JgSGNiQJjX0R5W18LfdgmBUKCz0UuinFvF6xZ9rcVmprQlp9GBAoxRTUWjZADhPteim2ErIhQ5LsjMrRVbjBuxbHSzRF1TFKqJIBNnv79Ppq60Q1MiNgTyzWLndR3B90kPWlnI4dx0EuiuSW6nwqPPfgQao6pSURXj4Db5MTp0RVAmmWZQhWXHHi8KRg+ZqZRks2EtHRpwUSt9PWIl5OZSIihREzvDpVd6i4jeUTfAoLilCHnS5K3B+McJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 12:49:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9137.018; Mon, 29 Sep 2025
 12:49:58 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next] ixgbe: fix typos and docstring
 inconsistencies
Thread-Topic: [Intel-wired-lan] [PATCH net-next] ixgbe: fix typos and
 docstring inconsistencies
Thread-Index: AQHcMT7dQ4IFW5axN0anotcYxUxDLrSqHI/A
Date: Mon, 29 Sep 2025 12:49:58 +0000
Message-ID: <IA3PR11MB89867A09E4445E909EBAD679E51BA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250929124427.79219-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250929124427.79219-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7267:EE_
x-ms-office365-filtering-correlation-id: 1d4f23cb-1238-4b25-3ed8-08ddff56b2ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?R3QBKWdcqfyyr4MucpIu77NKPRfMFtsOJMFM1MCPq1ijsKvN0cEiV+2mctIm?=
 =?us-ascii?Q?feUooTPdINJLpOj2bCLLTEUPGfW/S00KeF1L7A0QYol3ffC8IOyCZWiq518f?=
 =?us-ascii?Q?dm9Hi3PeNcHtGT+U+HZ8YpsSop1IxxwiO/g2UCNgJ7aRVuDuMSB9MT4at2mS?=
 =?us-ascii?Q?6wJe+pg3DauqizCFMwEonU+IH7QnSWZ1k1DeV2nGtYBkC5w7lQkFKjiwwbLt?=
 =?us-ascii?Q?vtV/uNLggsFFQ9tlMIUED9vSnHcipajLi3qvHALErDyOLuSM3zSEtdKFcvZQ?=
 =?us-ascii?Q?uKromvYWuAlwPGuVjejqR/XAY3MXD6T6kjirEiBC2JfpVvtbNlfGgZsX+rGr?=
 =?us-ascii?Q?6ROegb3XPTs/WLvHgZCRsFlHYVJFNEUXI4NAaEForKLQVOmHpnguOmS973QP?=
 =?us-ascii?Q?Zpb8dhkjHJx95MAH8hC9JmDVudSmgRohtVbvUU+DHSZ35qXlr6J094Wg8GbM?=
 =?us-ascii?Q?IzTDwYDv7h2KNT54l7rKREU4EXrucWjtlfcRFsaDE57TsmWpLHaqtRY/ug3W?=
 =?us-ascii?Q?YpoHkCacZ1JhKay4rBukpgQcDC9dw+mZXOQqRSy1jqIMC+icn4gIVvR5Ivbs?=
 =?us-ascii?Q?kWHaBr9icczyHVIgZfsdEK9ILGIjWSTRmMZH4X2fUJUbWSjRx0ERNOtmfpY/?=
 =?us-ascii?Q?JkB9NqNabewX2TH/a9OHBXG69XGeih3R0RnPqPSCcb41mFc0aauMk7G6gYTA?=
 =?us-ascii?Q?U8ZAMjO2kYgklo6grGJm+VcrxV0IBiGOyKcqlvAFJNYMRhLJU2yTqT+MPUEn?=
 =?us-ascii?Q?4wSuNXMxnWrkadlx9tJ425wDi6ECxGtInbkQTgPRO3nLzM4waHO97c7JUZo4?=
 =?us-ascii?Q?yZvbo64v7zAziKM593RDVw+sxIvVmNrhw72k5U31vjIJ6yAXHBbKIla2Cxr4?=
 =?us-ascii?Q?7+N4Vbb4TSmr24UZIXxrUm9Ne78iQuK+HyMfa52SZk0gMbnH9R3bFLn5Qskz?=
 =?us-ascii?Q?SUDC5DjvWMPea20DKU/JfZpUoq1ITEfEZHTERswr61YFUufqi2CJA5vmWAse?=
 =?us-ascii?Q?hKE7j3J3Inqa8gqFwM1RWWa7zkJsVGbnAU0EJzpAxdWN9yI9zdOGXY7lEoVi?=
 =?us-ascii?Q?i7/FthiSpFw4a16Cq0qp4d9wt5UTAUqFBTIylH+PsWIxK1yfY0HbRgFj8Cev?=
 =?us-ascii?Q?3e9/6YdWlBSZJy6DgXRZLwohwFl2wC4tw9+MJBpADls7tZwAnlAq2MtVserr?=
 =?us-ascii?Q?9LoJ1ni5UEjyT7lXe8cyNVeRiDsLJspUMaRHP/GXT4+iRvHQ//1GASN0rtx2?=
 =?us-ascii?Q?2mru+LNdoJ7/AmhbPIqPo0jYgAiceR3APPunN/VwSJ0ewQvrX40eqmMy55er?=
 =?us-ascii?Q?AT+3EhdM0sZ66TU7llxlnoYNQVAsUMRKahgX2Ukj+qbn2IC75cKKXh5MKbWj?=
 =?us-ascii?Q?HoAgtTLW8WOLa6h0XwjQVy+CJMuieQ50FEw0ugl/ENjMY/cqNUxBgHdDSGCB?=
 =?us-ascii?Q?XOppQ7cojcu32rzh1q+1swKmyiQhIipBXjBs0qz4JyHSTACBIIbXsOFfxIfS?=
 =?us-ascii?Q?kQviec4M+jHEDkoggWIx8argvjcy0q1PR9KNaVq73/gFXQNzdY61igj7SA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iqw61ZROSuXMDuxvwNJ/7zfT0rYA8q5zOrP/+0U2+vrE05m0h6IZuxg28ArU?=
 =?us-ascii?Q?5LSnVvxRy4XFFQD7JTUkN475N3ut9HW/cUhBvxUgbIZUXCaDkt/BGq3bWtLi?=
 =?us-ascii?Q?g+8QexRLnCKudW19h8myVQYE09rieGf/HU/7Rz5lKRTYNAV59VbSEkMd//hO?=
 =?us-ascii?Q?+KTm8yfkNCfnzSTYPPG4fWsPpVJeoymra57CaAakMXYJLfyl6O1RHdoxcFmc?=
 =?us-ascii?Q?/o7iPPgZwLr6gIQqz21ez/GrAdKG6zyTyCqtVFHGRwb3Z15sI8H5hFAanq1I?=
 =?us-ascii?Q?qR/NGeDA8fzsSFFyQ7wine1/2QPKVyen7+KEq1XCndQIjq3gFEcxjui2rhqz?=
 =?us-ascii?Q?A27jvDermbZepw8g3myzoVgyTD33/vZ2yTZ0JCzrlbmgVvXZjmtJ+DKKpgIp?=
 =?us-ascii?Q?Ky6Gs0OPzLs9ea5j03HlisXIfZqNLKO2ZLhu/najDrRLSORdE4e6+2jGTuSi?=
 =?us-ascii?Q?M5rCJCvV+MJ+3U5MAxbZcrksiVadzs5s0c6ZWj/8OTIwRMrlBB36xajaZ70V?=
 =?us-ascii?Q?An1ERGIpgT1QSxU82wAodKfitLVL5FfV7ulldjPEUkRYZmG56KmtFGGwT7t6?=
 =?us-ascii?Q?3gAaLt/XsFqOpio2SdDO85OGXhL85YKjSSs1JohoiySsX37jq/TsVM2E23Ha?=
 =?us-ascii?Q?f/Cb4Bz+GqTZXHU0kDDl2YZgjIQ5KyvSlxK+3qDwos8i+fqJ2V9cOAaxxkdN?=
 =?us-ascii?Q?aOPEhfngFqd/GnkfIHx3ygUvIHiVYyhIy8roYEZn1k6ZgnxP/lPAAaw0GIHn?=
 =?us-ascii?Q?NF8TSI1M5AuhTrwQbGRBADsVsW4gHrEqrDesiTTlQZVtKsQCzexN1S/IPety?=
 =?us-ascii?Q?Ad88XoSkwTICnm+QoZ1uAulNqU6Udx/XJgfRJwjSdobRKeWuTCYT+wksBDVX?=
 =?us-ascii?Q?L0DmTGHFURvEehQWIp1Kbrf8k9U8yw7/XMLY4EqyIaF8nnmnMc/RyyJUJqC3?=
 =?us-ascii?Q?Y+xLzl6/defZIcVl7y2NZoaIoFoJFdhgqfmyx9oqB1TaPskTmOMuXaSvIH07?=
 =?us-ascii?Q?Fgfogj9r5mDIeYH1zXFapiMP1i2aeupZlFuoHOpkjWGVzVuhEBn3oEVqZhH6?=
 =?us-ascii?Q?XzMVNxfNPjG4vzM5rKvERwr+D33wgA8Jpmykq6Q2PZIBmLVLgoVcA6B4LEHv?=
 =?us-ascii?Q?BrtJRmS2OVZwMyB9Wr2drFw+UnfdyOFwFi/wZNx5plTxzYPeBCItwqCgBfyK?=
 =?us-ascii?Q?i15+567tNFl8I23LWlmz0g+KbaoqX6PrAgDUmnyhTDJdWJ5WcYzYjE+ndc2n?=
 =?us-ascii?Q?o3+4jpdnqkKBrApB8eHj+5EWUS8o8BD6EtmOfgJR4EvACsNOrrhnQyQcbDO/?=
 =?us-ascii?Q?8xvIynjFcYpeHoaxRkKbdWE9NR/XoPZP+ymy/FFOqZE/kEF7PHsYwVisIOVg?=
 =?us-ascii?Q?5cvdS4oaQGAmQr+sLdFNU9doCzrIt7DKedECwa/FYVNiBHljLHxAcpVwWbDT?=
 =?us-ascii?Q?9lJok093ywQWDr2DHJu9hPC1CdFDR7dcuf42cNiGy8w8mVmapO4tzEEdwM9S?=
 =?us-ascii?Q?C/2CVHZ9L589IjxzzT15QyxwNNN0gKYWZG4mYg7YQBbBO8neM+0xaOpiSvZr?=
 =?us-ascii?Q?oTkOYV5y9kihF7ZLA3lwxF+CbiIADBqNH/6hQDvpHWL9e5mWeTpve7Gj8BnP?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4f23cb-1238-4b25-3ed8-08ddff56b2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 12:49:58.5831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zniM/pGF2ZwG4avACAO1zTa9rJpx5iTih2VWOpqaLZOQtgt7ddQRszbsv1/ChQm4FRRosnM+qgNCBJirxaZKf0WzWGbaBEDo8HkzicmFcI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Alok Tiwari
> Sent: Monday, September 29, 2025 2:44 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; horms@kernel.org; intel-
> wired-lan@lists.osuosl.org
> Cc: alok.a.tiwari@oracle.com
> Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: fix typos and
> docstring inconsistencies
>=20
> Corrected function and variable name typos in comments and docstrings:
>  ixgbe_write_ee_hostif_X550 -> ixgbe_write_ee_hostif_data_X550
> ixgbe_get_lcd_x550em -> ixgbe_get_lcd_t_x550em  "Determime" ->
> "Determine"
>  "point to hardware structure" -> "pointer to hardware structure"
>  "To turn on the LED" -> "To turn off the LED"
>=20
> These changes improve readability, consistency.
>=20
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> index 650c3e522c3e..76d2fa3ef518 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> @@ -1163,7 +1163,7 @@ static int
> ixgbe_validate_eeprom_checksum_X550(struct ixgbe_hw *hw,
>  	return status;
>  }
>=20
> -/** ixgbe_write_ee_hostif_X550 - Write EEPROM word using hostif
> +/** ixgbe_write_ee_hostif_data_X550 - Write EEPROM word using hostif
>   *  @hw: pointer to hardware structure
>   *  @offset: offset of  word in the EEPROM to write
>   *  @data: word write to the EEPROM
> @@ -2318,7 +2318,7 @@ static int
> ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,  }
>=20
>  /**
> - * ixgbe_get_lasi_ext_t_x550em - Determime external Base T PHY
> interrupt cause
> + * ixgbe_get_lasi_ext_t_x550em - Determine external Base T PHY
> + interrupt cause
>   * @hw: pointer to hardware structure
>   * @lsc: pointer to boolean flag which indicates whether external
> Base T
>   *	 PHY interrupt is lsc
> @@ -2628,7 +2628,7 @@ static int
> ixgbe_ext_phy_t_x550em_get_link(struct ixgbe_hw *hw, bool *link_up)  }
>=20
>  /** ixgbe_setup_internal_phy_t_x550em - Configure KR PHY to X557 link
> - *  @hw: point to hardware structure
> + *  @hw: pointer to hardware structure
>   *
>   *  Configures the link between the integrated KR PHY and the
> external X557 PHY
>   *  The driver will call this function when it gets a link status
> change @@ -2745,7 +2745,7 @@ static int ixgbe_led_off_t_x550em(struct
> ixgbe_hw *hw, u32 led_idx)
>  	if (led_idx >=3D IXGBE_X557_MAX_LED_INDEX)
>  		return -EINVAL;
>=20
> -	/* To turn on the LED, set mode to ON. */
> +	/* To turn off the LED, set mode to OFF. */
>  	hw->phy.ops.read_reg(hw, IXGBE_X557_LED_PROVISIONING + led_idx,
>  			     MDIO_MMD_VEND1, &phy_data);
>  	phy_data &=3D ~IXGBE_X557_LED_MANUAL_SET_MASK; @@ -2812,7 +2812,7
> @@ int ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
>  	return ret_val;
>  }
>=20
> -/** ixgbe_get_lcd_x550em - Determine lowest common denominator
> +/** ixgbe_get_lcd_t_x550em - Determine lowest common denominator
>   *  @hw: pointer to hardware structure
>   *  @lcd_speed: pointer to lowest common link speed
>   *
> --
> 2.50.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


