Return-Path: <netdev+bounces-224305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21532B83AAA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A527A1680F4
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D0F2EE5F4;
	Thu, 18 Sep 2025 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWhTEVcQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF383221F13
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186190; cv=fail; b=NJ9pMYZnhmmXv+/PZ72ls8BKPkXTwUt9lL+0qEi0a58/92fH0Q+WPWJ//mz0JecTHv5wyj8Ri+wZq5EljbIl0Ca2utroFdiu6UgDUlQRwCz0zjJnXO9+spCNgV578gjfbdRn11ryrdv/XzI7Hsq0z0XOdky6OLgdfu6Xqe2FBa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186190; c=relaxed/simple;
	bh=s6MC2mqf+ez2Vm736ofUobLTa3keEa9jTqk1xdG3TPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iqldxD0k/Sp7veGAB3gQmW9CqCm4P62wGL9dsPJxTP0uJL7JCxP2uKTXTIkxMWji8gMicwx7xneZTTA+iqVCnDEnY8OD74HDLl0YX4V/DmIsVGX5aK81IRgoXNq7T3JdPDcEgPgX7zje3oFHZkcFo2lLQH3eOk6oZvSXTQOFm/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWhTEVcQ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758186189; x=1789722189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s6MC2mqf+ez2Vm736ofUobLTa3keEa9jTqk1xdG3TPQ=;
  b=mWhTEVcQrfg/nxYrhps400y/XAR7yM+OQTjE66Tea9DoR+O1ckrUYKe/
   I4D+rFTHYeq32AnWkIFtm9FQKUPxvwLnrI0qowrhNyvSX1BdGEelru5dj
   BrfWy6vq2nc94Kd5YT/WLQczL2yN7/Dhl0qJuxcLiymF3seQSojkLyEWi
   t1jWzeba2sks/vi9SsOLK1gC6/XwSKHH4TjCgchDIRqnY20D88WL5qM69
   kWsygJ5sV9q9JEDZ66ZmThZggpPkLZcsovmWtoqLjfTqBaFHq9MtVCHW4
   fmYzE95lnhGa17jbslrUXH4wYy4+pT3a5f00r26FjvbJm0JoeKRtgtPsc
   g==;
X-CSE-ConnectionGUID: +HPZaQ+rRVaWIoppg0AgXw==
X-CSE-MsgGUID: 1KPndncpTkWhrRg+bqtENA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60429540"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60429540"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 02:03:09 -0700
X-CSE-ConnectionGUID: 1ijyNA2yTt6jGYgbOfYMmA==
X-CSE-MsgGUID: 51NNFSJsQPCyOcDYNcravQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175293665"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 02:03:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 02:03:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:03:06 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 02:02:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZG34MxcIwYLFiusJKveDZpsX+HFvnvjQIdbIoTmdlwdg8H1S89QdsnqSOIE2P5+4baMlc91cQHe8CDsk0b2lTFiyZg5qlzJk16MBi1dUpNRk4PKMNw5boCISCQdoW5xUZrzgLBJohfQN62cWshaENl78tDWrHb9+H3CalQoKpnxeOg2EjEmh+odTEH4sdthgFz4ypTbFrM8XDC302yCbN9w45Ivwi/7SQ+OjOH12SkE1Id1Os95xVHZIsukTMA2H957fFWJUB2BSKwUmHRwy4CPJZy5gS/MYU8IU7ehUZ4lF3ovvBxxwUkUobjGDA2lkgseqDUQEJx0Xz6NmUbKvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6MC2mqf+ez2Vm736ofUobLTa3keEa9jTqk1xdG3TPQ=;
 b=LwHwIWN6VnFkVFcgvC1FPjAoUlPJR4SlNKZKIqUyY33s5VJ8KYhxxMST7mDmZMA5I5I0gaoL2TpU/TUQhg79uRRaBw7FpCcOJ6rrllipFuhFXfAZqc+mjZXLhwo844KnfW37Q1yIMf2YJzfSwzhxNCaaWuKJ5MJCjBB0hyxBAfaSzjLr5ta5Rg3D+DcSDKo0CW2Qba1t6vQSOrwhahPNA+4elCWZVus4vXEfoD4GZJLdMHo6ESDO0/OQ0yFMeRhw8pFBJYyIuoWbdvOuK3P8di29t8DLacTv3y7UciNuJ/J+X2UqcEOYOfPIdSmd/+E8a3V89BfiQZR3zBTjYOhSlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 09:02:31 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%3]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 09:02:31 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Kyle,
 Jeremiah" <jeremiah.kyle@intel.com>, "Pepiak, Leszek"
	<leszek.pepiak@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 1/8] i40e: add validation for
 ring_len param
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 1/8] i40e: add validation for
 ring_len param
Thread-Index: AQHcDD+MzoI0deN98kCEbQEiitEX77R1Nj2AgCOnI+A=
Date: Thu, 18 Sep 2025 09:02:30 +0000
Message-ID: <IA3PR11MB898522694BCED623B846187B8F16A@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-2-przemyslaw.kitszel@intel.com>
 <20250826163501.GF5892@horms.kernel.org>
In-Reply-To: <20250826163501.GF5892@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|SJ0PR11MB5183:EE_
x-ms-office365-filtering-correlation-id: 128209d6-b220-4538-d258-08ddf6921980
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?ps9geMiiiTr8T8wdgWkM2LFo3HhZnaCFvtJehgM6IZJGs8zeiLg6v3cLnH+E?=
 =?us-ascii?Q?fNWUdY+GNnC9agb5RsGUhGb3xIPRvOVdEXrOZqrXUHS8KDWgCiDOXeoGf0r0?=
 =?us-ascii?Q?cJbVBa5R5gMnhETnGfo+aodY2Bmmj5bBfJD0KIVCaxc1o5/GvpZp1p9YzrKM?=
 =?us-ascii?Q?LN/Xs7+hcE3DcX5armK8WTdOoainM/2UwQnWxDGkJzlbXnhPKGb3VfggpCgD?=
 =?us-ascii?Q?AjaxdYZdhfl8C+U2z96uBCQgk3a/64jHhHt5egarJ03GB5VMNM/iqWvpGErE?=
 =?us-ascii?Q?ijdY3V1S9SP2+f4g6p38rFO0lGhWcxG/qvleEVdI7W1ffcJeS9PsKa3xcCGf?=
 =?us-ascii?Q?TmhcpYsNpETvRwPL+1Fb5PaFem3ppQ7wstKsvvl0syIiT7NufY3b9Eg91Bx8?=
 =?us-ascii?Q?0Gp2v2vPEOIEMBdYsZ7ihOLITu3JeJsels1+1x5yUPmxfafkl6P2xMzYqIon?=
 =?us-ascii?Q?cScrjbYG9ONu+WRGr5FRCGmPmC0Km71y7+Vw0rXIRooWhil3j0CtIMaVSG24?=
 =?us-ascii?Q?jD++LyIKeXk1ploGRvGAhN8+8NGS0GVw80Z08XJ0Gz85Z6610qpPx/8B2RYt?=
 =?us-ascii?Q?/4I516J+A3sYzwarkZcgI4B2FYMdKhcC/KfdV53GR6EwNy5zWTYYToSJc5DQ?=
 =?us-ascii?Q?xx4BGuJWmDWUT91MdQVTtiuhFiFnEOVMDoNruZJm36QhtSMaeBCdgnMNYoRZ?=
 =?us-ascii?Q?TWChoqBx8y9Z5198BqWt6cIwpnxA/iBxPYdGxcvCMa+Adk11jBs2taUNupAr?=
 =?us-ascii?Q?uRno1MIcQNtyrmk86+tIZhaOTAQVTdeWjey7fP9rP4tEGekQIoNaNdc4+yqz?=
 =?us-ascii?Q?CIS6K2lwdLtxzPBQf3TwFLM5POSc1dTBwi77WSNdRKm4Ql9a7FCjqg/5Cifu?=
 =?us-ascii?Q?2BORxUqdti+K2gzV8BiVwWC1KN4wZf+2TOGcU0mg2ovYEbpcDuQV5Zc9ntqv?=
 =?us-ascii?Q?USmHPbY6aztriUpqGreiT6rpaJzqksIk6S7E86Tcv2778xwep8AjHAWn3rUB?=
 =?us-ascii?Q?Ji7vNe5Ml+uT5/7vGVsbG/OYZrSHERpCXTjkH0ms+AEpwjLuL6R7EeoeT0wy?=
 =?us-ascii?Q?kBI3D8s7ZSjF+sK1z1Sx4Fb60Ma/6NPEbywwE+YFe4M6omfvT4a90OMZtyX3?=
 =?us-ascii?Q?Aib+YHZh6QJAqGKTNn+VBlKrJdXihfZ9/xbP+nFAh7TIKURlEIHJ+2buGVwQ?=
 =?us-ascii?Q?yZ5T1nrIYhNkNR6MBwA+S0PfQ0oN+dmijEf46m67iV+a1qWFe4Bdld2KOVIT?=
 =?us-ascii?Q?nqZJ4jbE7fowx2PIYAzw/6OGjBDjEpbxCOOfcpOqVDN42pLHW1HwjmnfI9pX?=
 =?us-ascii?Q?FTF/lDi79Po7f3QkHnKM/3/MReuEFM0dcOZnJxfyQwJGLZ6mHV7/2jkLQv2/?=
 =?us-ascii?Q?bxXwchEV7iEZ2disfmjDV9yvjN34XftzFTFiMyvw72TW5loyRiiLxJ6tKbiW?=
 =?us-ascii?Q?pYbONcOkbSIzk3jH3NhkDD6xz3s0YCCgIOkVuAHYrH9btZ1GvpsWlg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ahz+ZT7cqx6EE+4ngQjgtvhOoNcuS56itgxdlforWiUiPZ+/CK094UT8PlMa?=
 =?us-ascii?Q?JmGkVxRFPyv/1DjDRzeEgbFNBqnAtOgBqfOmFBxJJTKf+OnQaLFkgv2ZZ8DI?=
 =?us-ascii?Q?iGVMttsgYrRsCPSKUorsx6SSU6mlux2tNiErT+MamBnLqRQzhiLHiNwv0mV5?=
 =?us-ascii?Q?C5h3n/4a1/cMt7vtQ14Q2Ssx89gd3VHS/cGzl8hDyIAOcfYKzknnET5HHH/6?=
 =?us-ascii?Q?qdZS4oKMQjmwlIv3PwL9fJdLviik2LboAS3x6sypGMJjHM56JsSw8QPcozFh?=
 =?us-ascii?Q?emryDfjx0q9NqCSkTVt+M/x/FtSjG2cn/ibq9iikHI4ERL4TFLiAElQEvTf4?=
 =?us-ascii?Q?uODerwnulFdCZ1AsLwT265j2Q2TejWOnr0Oqe2EDZhG4APSNd8qvr16yhulW?=
 =?us-ascii?Q?vJpTeBXkqD6tJPlVgHIs5F4BbeBmJPZTw4mtD5azx2uRbsQg004Ln7DNO5nX?=
 =?us-ascii?Q?NkbbqfNp5ZRVY4OeW6i136SGaFkM4f2ES73evauIGpKzl6fdxXeOIZ4BGi+N?=
 =?us-ascii?Q?NeulphFA3wWaMKpQuRTR1EDXfurSDgaNpiPJqMj1zAM50txpUiTdnR4JHQq7?=
 =?us-ascii?Q?JwZ25KAXRXA0Z5O6ukWr/WOGvbapcqzsqx7jdLwn6eLvGhwhO6Itp2Nizzcy?=
 =?us-ascii?Q?s456olEMfLqJMk74PYvZp2ddjpYPFAyca8KAywLMZD1wK7yOuQZkpKA4vcDZ?=
 =?us-ascii?Q?Gkmf5HYzut16R1uFcheoZF9wvMb868awthaTfYjHGv4zxpMawhC1FxpVyhSs?=
 =?us-ascii?Q?5nnZa5MbdUSsU7vU82TJ4FrUPAvSOCQYwqBJCfbYkhWZXabgLXzdyt4Bo+HR?=
 =?us-ascii?Q?ppBkK8kspnmfHy+3eGvEHHyjoUBv22byEd4PpCZV9355at6kCFSxAiDIJF8I?=
 =?us-ascii?Q?Ajj/GbmocCmowauo7viYw8jw3mqMdedYs9j5dRSu/kJvWz5BBP30CtG9rmVK?=
 =?us-ascii?Q?yLAcwa659rzPp/i0LPpBMwUT9PYhFOTrz/RkqpYsO/K6577BjvqVgRD81tGZ?=
 =?us-ascii?Q?k+0B2k6l75LQ7SFs2Ty2LLM10jXt64H4Tz/rc99mW7qPceGGVIyt6F0zMRz9?=
 =?us-ascii?Q?TvRgdHsByb97nbR+68+xvEL4GgXH+6bD/xfko5VJHUmChGTn/9Mc6XycX0H3?=
 =?us-ascii?Q?arLQuJbcfI7bZbq3jLOJz5bqeuWUXuwqrDcyrThaCI6vjwslDW8byew7zVNN?=
 =?us-ascii?Q?R+INhK65rXlHg6dK2RuuopU70bInYV/KxEsxPaNjjo2aGfvGmQyyYbtViouv?=
 =?us-ascii?Q?HK4C4iEQwMDTAp//mXnB5zjuJDV/+W4Rr509Lw42f62xmMQnFbFkeY98YkkT?=
 =?us-ascii?Q?hS2+7pvnGBxHgf6uUhdBYmSkrME25ObCnjBtSRVrl2fW1qyR3M9hWni1/cb2?=
 =?us-ascii?Q?Dh7olWeZgWxyaJh4s+HtgnOYPibrUlfwTJr1UQQa+5obpoZOqR5Zya52CnUh?=
 =?us-ascii?Q?RYHe+/JhgH1+5Qmcw3oyTLlCP0F7gB2NZsqG9wcorFRNB4QKp2Dk3proTjF3?=
 =?us-ascii?Q?f5OTv32bGlMJEN8h/+s63fg/jDW3JUc6a1IUhWFq6CPlOQqbOzuYz1Lo9br+?=
 =?us-ascii?Q?kAHBkhJORScKz884mx0r6VwmhD9ApVSA6juZW3ob8BCG8kyweLMrfdRKGOmo?=
 =?us-ascii?Q?CQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128209d6-b220-4538-d258-08ddf6921980
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 09:02:30.9789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhGA0ZpD2ezqMGuX9DXtWVYkBuvmUS2EyPysf4e5aAooRBFY36ACYkxmHvJQypOQK3w2jukUwp1hNpPdnaFYrYqQ0T1HsecNxzb6jV3qaso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Tuesday, August 26, 2025 6:35 PM
> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Greg KH
> <gregkh@linuxfoundation.org>; Kyle, Jeremiah <jeremiah.kyle@intel.com>;
> Pepiak, Leszek <leszek.pepiak@intel.com>; Czapnik, Lukasz
> <lukasz.czapnik@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net 1/8] i40e: add validation f=
or
> ring_len param
>=20
> On Wed, Aug 13, 2025 at 12:45:11PM +0200, Przemek Kitszel wrote:
> > From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> >
> > The `ring_len` parameter provided by the virtual function (VF) is
> > assigned directly to the hardware memory context (HMC) without any
> > validation.
> >
> > To address this, introduce an upper boundary check for both Tx and Rx
> > queue lengths. The maximum number of descriptors supported by the
> > hardware is 8k-32.
> > Additionally, enforce alignment constraints: Tx rings must be a
> > multiple of 8, and Rx rings must be a multiple of 32.
> >
> > Fixes: 5c3c48ac6bf5 ("i40e: implement virtual device interface")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



