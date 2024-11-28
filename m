Return-Path: <netdev+bounces-147686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D59DB314
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 08:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722A0281483
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 07:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB5F1465BE;
	Thu, 28 Nov 2024 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHsqKTRe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB611442F6
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732778129; cv=fail; b=VZjMggyGU/SL+IHoSl5UekIFSC2vunHNeNfO9rhs8nBUmpO3XWRBJ0fnlWl+ePCDCdIt0bMw238JeHDVKyQm4HOlKaiJ3H0tTzvEs1w0O/E+8O/D+mX+aTpEOAlTfH2uBRYyLh70yZ5RDNRKU6exoJtzpR5U07yWTAooI7Q2iw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732778129; c=relaxed/simple;
	bh=L2EyhesWcsEFZPniDxEsN+Tv42BkydC3WszNDGK19zg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ImdqZE+QZgMvtinWsNjz85q8bUqAMZqFysF3pz8jgUyLziu772E05dYLejX+iF+v/PvkzI95C2iD1yQ7/VRiITOoSxn/IF6r/kPOtgp+A4eb+IWl8gBzkJkbir10U8l1vsuMjvXH0e/IXdJtsIiMFMCOOe6j09tdyFoMEZ1xcEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHsqKTRe; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732778128; x=1764314128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L2EyhesWcsEFZPniDxEsN+Tv42BkydC3WszNDGK19zg=;
  b=iHsqKTReCgLH/fu3hp5o/sSwbBQfUYGxIvkFttK+y1nXou0D8SjXo3b9
   k/uArtlZVFr1h9EKbHC3cwIBuiktl9UlEFGj8/qcTHUbDoFKa2s+yDggT
   b/r6EVZtSi6u2PHCZ/KAK9TXQs+zGBxh7KBy7hDmyW48Fo1+qRQNblnHn
   DFdZv7vZtq06pY8y3oIYSWGaVVmw9FgR0SgrWLfL3vS5ezRm6cVPuHYY3
   4wr+WX+BK8nNYZfWUT1aQ4qFV9miOxRoxXOPZ48JGWePbdwe9zvmcfgJD
   4TseRppIy5eq87zWSnTmpZt1hRe6n0I1fahPzZM86fLrUw3WAsfXJhBqh
   w==;
X-CSE-ConnectionGUID: a03AkGJaTxaKSVadzolNUA==
X-CSE-MsgGUID: o9ocTQAsQYKpuYEaVYFKkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="32860425"
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="32860425"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 23:15:27 -0800
X-CSE-ConnectionGUID: BYEdngsaRbOvcMCmvxOk4g==
X-CSE-MsgGUID: y6hPlMrBTIqcQQeOQ/zxgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="97216586"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2024 23:15:27 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 27 Nov 2024 23:15:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 27 Nov 2024 23:15:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 23:15:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QogosItAp1gtw4gJx4LEhj8XLlNpAdNfKZtNY0Wpmnk6Ri7HxKiWEEJMvRb++oJuljsNd2lEO/xUPAAkElQIQ99pR7/N3I+kypNyGG0fyvW1veY6PzbZGdS9p+ToRHJeBeKvYmZIplTrPdoI4HonQDWwFG+mTrqHfvF2DWbQNiHLLnxfCWxxGQTBxe94IAhvSuhL4/e2cu0nbDTiL9DHDEGdk0WhJwTu9RvRar7TT+E1RWShnJrOBDmHYvk+GvMoDT+AH3wzcGOfVzYsPBdUX0AwZdc4kAX/2VWtIcwiruhIBuSPOtv482TDHMdlkrqeDrbElaAM+G77bcLQkedBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxFUruKXuXNJII+H1S9/lvYawONUUc76C9q6YlAxlhM=;
 b=tIbLoFbQgKVkp/ADVf/9Gkcg8q8PNbW5auB41pvwcDNBBvMtF4mL46EwE5s0TfO0BCN4Hdq4mwo4lDjLiendQ6lZAnPuEr6skEnRrtKkL5f7GjdrSdMteKDBOUk8Ohe9VcjQv+24JSC84L81DcM4jPJuXFvZSToKWxR+IqlzEcf4OvwXukB1vbzOICe2qMzIncSWiTs1qrV1473fAEx6/9Nw1RJ/LYBYcSLqYrZxgtIi1LgU0sJfCekt/XCuOQxRMrt+30O5XH2eLLJSH2u5PEOvVFWZKEpkGN7Mo3b1BVera31vdFHzAu6k6cKmnlSIbf4GlXGHNSM5TCFknoXxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 07:15:21 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 07:15:20 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v4 iwl-net 2/4] ice: Fix quad registers
 read on E825
Thread-Topic: [Intel-wired-lan] [PATCH v4 iwl-net 2/4] ice: Fix quad registers
 read on E825
Thread-Index: AQHbL37gtpR0UrVx2Umq5xvLbPW2OLLMatRw
Date: Thu, 28 Nov 2024 07:15:20 +0000
Message-ID: <CYYPR11MB8429B836D194E423539858ECBD292@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241105122916.1824568-1-grzegorz.nitka@intel.com>
 <20241105122916.1824568-3-grzegorz.nitka@intel.com>
In-Reply-To: <20241105122916.1824568-3-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SA2PR11MB5051:EE_
x-ms-office365-filtering-correlation-id: 31c7aaaf-86f9-462a-7942-08dd0f7c6b6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QkWBx7nrqXYVKZZvSpnHDcGjJ9RnjxOwrTS4MGvAAiw3VtzQ30hMknsPgOW2?=
 =?us-ascii?Q?BIb+F+StLzo1fiLM3oNrv4efISu5MCd3SBdSrmqZ0FoFH1UzN+5ydo/KW7aP?=
 =?us-ascii?Q?ENaSWxCESvHd+JYJpoYNaPgbyuXjnBfS0qPRDVE15snwIOURilSAuNx5Nciv?=
 =?us-ascii?Q?jq7tcLnJslt1bz+Q8Qyimb1BLhKdMcffilW/3XQpHqH0byBQrwvs3X62Ex1C?=
 =?us-ascii?Q?CUPyr4jjoGE0+3Dz0e4+wrptY+voJ8erOHhxqlHWFJtF8pyP/1HzltfGmZrf?=
 =?us-ascii?Q?ospC9oVkBONZAQ9nuF6+OG0vkOKQuqUZJq5LmXmeTIH9uxfD8eqaVqUar01O?=
 =?us-ascii?Q?PWgWWTMCtcWoGnOIauvf1WZyB9DS4aMOy6v9aYK8HXPGifpah7I0T1r9NRU5?=
 =?us-ascii?Q?a/SswchWfv5FYdy8M4UEusCxIb/GIVvss55eZeWRF/VYFzhUElzGG4PB5Mo5?=
 =?us-ascii?Q?jLpU/ZiD/SabG9EHNas70I2PaAXWRoap1cbVXutltSQy8iSj08Sa2Ex95d37?=
 =?us-ascii?Q?qlckgjLgYuumMv1Rg5GLpB09iMpKPnxCt/vaIhrIVsnnmC/88oGHENLzXbVy?=
 =?us-ascii?Q?X4j61hQ1y5N/08onmsP9gnA3TxbcGQEJ7uIqyKpvbluTaZGPK/nWIkSu6gND?=
 =?us-ascii?Q?OBBB9GI6UIQq0cbLnjXseV8Bh57XV/TFUCDCKgGGabzUFdHGG3SP8EMzyx61?=
 =?us-ascii?Q?5kdSayy4aV//yflU17VzVxoWFZLNP8J4ftnEs2X482K4bkx3o28tgwBjfrzz?=
 =?us-ascii?Q?UhrkA3ONZVPxCeHHTt7fOQne1jF/AF5Q8TK1/SPv/dmRMdWp8gbLPCJP+nGt?=
 =?us-ascii?Q?PwnftQIg3QMOCztYmMlzGvITRi2ZAGHmGAbirW/F/iXfFQZXWOXsKnojEhxE?=
 =?us-ascii?Q?tyy+gf4mkYe0en/pvG6LaVbXbyrOUlScVRGXdFQpVKmfPv7tlZ3LoRby30OP?=
 =?us-ascii?Q?bwHXOjl8XgymjKjHtA5UIXyM7w/3B+yvmPUhZmyiL7+BdY6F6hBjWGDSdyoQ?=
 =?us-ascii?Q?m7Ma1u64rOwOFVAeo6oT3k6QR/STpsrQh//4MrsKa0JuQ3mKPQ7AoYRRca3H?=
 =?us-ascii?Q?HuuxuMVLoGN5ZBkkOhCMFZ4t2sADKx8HaqH2bck+Vv3qEcvfUfKXkpWVSDZ9?=
 =?us-ascii?Q?18YiEM+RfWeyJXHz6s3n2r5OWKmGvKTZEc/eDR3gPaKiFvcHN5ePEqdRJIef?=
 =?us-ascii?Q?v8cBTpZeKJbUjhkUwIMRcVGJNsLZDBfpCnReT8ukUUoFCgdKgfbVcdgXCcZW?=
 =?us-ascii?Q?xaZPYcoMoS2D8nVArH+bYT6FVrbk22bbrB8L747YkmmKl1FMsnMYiImNNCar?=
 =?us-ascii?Q?MsL3aSPjCMiAhM0iCFED9Z8F6PumDCtpXORy3uvPW1gy760DLtolsiMhsZC5?=
 =?us-ascii?Q?EI7V9JU4Q2A7WxDUqig5+Mhqnj9SDRGLEAWnoefOehQ+G6SknQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?irkURdpb2kHnioWWenBGCCgt21jV+oGUrf8FyXXXq7WvM5mxm3FteeZjbSIT?=
 =?us-ascii?Q?l4Ms5b/0ZfHvXxJXZedRDPde/w7BNvG4wtOeeNzHlDWcl/BO5gj9SncZrLqP?=
 =?us-ascii?Q?kaZd/kO6WbdDtSCBqjpS2UwT3hMv6/Mzzc86O0agAANEN3JpAbdHlJFVMz8J?=
 =?us-ascii?Q?A9okIQbDrxoaYeGT3rafOii1TWp1IsfQqB4BDWiR7VK7GptofJEb4CpmhlWH?=
 =?us-ascii?Q?mCCSOyiS0FDY5rEIvBDeJZBauiS5c6DSfygt2G9GZPpdpA6vqGygywP4Nbuo?=
 =?us-ascii?Q?t2buQ9K7vubB9IqopCxZC8B6HmK1tS964Fp7S4KWjQaZqf7Xp4GOFhfmJvCq?=
 =?us-ascii?Q?/+QfgtL9CgyOgSnsUyBqnABQHbc0hIuT5lllwm8XiELDTe85J17/J34q8X1G?=
 =?us-ascii?Q?wVhN7YePmScAaiQhXJV9VsK3Mdv2zS1EaX4vzlK9kmhblRs9Tjfz0WcMkagp?=
 =?us-ascii?Q?5QZlyEi//NV8xFi05P3iYgDADQ8u1fin8KsRVkuJvFCB58b5KYx5X9l3T49N?=
 =?us-ascii?Q?uDxkjXweybIdBijjZHqCHCpBZlKz7vE9B1JfK9qg8oVoAkkJoq+XXreLmlvQ?=
 =?us-ascii?Q?R4RcSPBv11qbm6pyTEY5+ilkAzqYyYoL9CRhO++oyM2uF5tOgcMaTzyf//41?=
 =?us-ascii?Q?irrMw0ZkpZ4KxYmk1Pkh+LYdstVBVlgTDq/OyclU3RXgBIrIyRPqwZZKyD+2?=
 =?us-ascii?Q?CciHdQsOhvnDPpEIKJL5kUxqXo45fO/6svS+4ic9rb6nppugLvK8UlS4zXO8?=
 =?us-ascii?Q?do2fDD0TLwsLmsElqIqXmLNcIXP+FBN8qNsDrs5XNnAI+8NX6ZjgOPw5IxgC?=
 =?us-ascii?Q?CK3qAzfoa9DBW6q5fu+dHn/pCxMq1tIzwK8A6Osb6rt7wko86GVQtWykK0sU?=
 =?us-ascii?Q?ieMTkeo77zFLlHS+F3rU0MknvwXMp1oHQhh7Yfl50I/fbJrTbpIG2H0ZSBpp?=
 =?us-ascii?Q?pRqhgHsFk30bcvYO2d/5O1d/yDvfQATnt4L25NbDQuOohXmk/8rd9hiEJ/H/?=
 =?us-ascii?Q?C0ncvnaZtdrV3eFp18OmBpWkE3AY1qVVM3CSga2MMJYy+OGoc3Al5Zz+nrdb?=
 =?us-ascii?Q?V0UgO6ZNVLvxc7PM8oq8TmjKY06vKV89H9Zh/OhppClKTcFPcrBWRsI1GcbA?=
 =?us-ascii?Q?ixsxdf6OU6H+uxlXVnMbNXjwC9oL2/I/3eWujC1U0OPkmhfSMbtUlUQ3EBBZ?=
 =?us-ascii?Q?+0byBscklvlYB2Jce1AjKfCZjA4/7hFlyju99GeIAq4Scufbx4ZlHna+9fL5?=
 =?us-ascii?Q?nfBRZHjMMgCwNOiC0+DQ8PkIoZBjfbxHIMohTNgzxyeypRkU6Gg8QfRoz7WZ?=
 =?us-ascii?Q?NCFoQpirN60O9vUwVk2i+cm3sAx3UozqPr+Qo+ZTCg2zd8ASs9YQbXtoeEca?=
 =?us-ascii?Q?ywkqFe/Q2hZqerV3wGN0Ayc8wqS7B/W/IWMV4pF/kfHADXhRHrsKOB/dfl11?=
 =?us-ascii?Q?N73F7X5/BaSb48vTdCfcnBZ7e6TxNDIFFA6g7IQANJVb+/GDrS/L44hD4cuL?=
 =?us-ascii?Q?DHV0+37vHyDcGUm8lbmM2uSUyfu5hRc84Iwni8e8Ot/4nob7nYTNgsLp7BQy?=
 =?us-ascii?Q?eZlUGxmJ0LLyTNGZYjiHqjNgIbr9N1nJaJKkcnY987izFylexz7LmGVnCiFD?=
 =?us-ascii?Q?Fg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c7aaaf-86f9-462a-7942-08dd0f7c6b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 07:15:20.8994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVqgmIjbaliz1qxwCNbcPczrdvT1VDUtQfACei/ZkcSLCrNzioRwHyo+k58dVYRxb3GuLmIALU+HanDkpyEd9qraekpyuJ+bs//bBUr4bi18+8GV9AGG0Sks3QFEVrux
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
> Subject: [Intel-wired-lan] [PATCH v4 iwl-net 2/4] ice: Fix quad registers=
 read on E825
>
> From: Karol Kolacinski <karol.kolacinski@intel.com>
>
> Quad registers are read/written incorrectly. E825 devices always use quad=
 0 address and differentiate between the PHYs by changing SBQ destination d=
evice (phy_0 or phy_0_peer).
>
> Add helpers for reading/writing PTP registers shared per quad and use cor=
rect quad address and SBQ destination device based on port.
>
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products"=
)
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
> V3 -> V4: Removed unrelated refactor/cleanup code
> V2 -> V3: Replaced lower/upper_32_bits calls with lower/upper_16_bits
> V1 -> V2: Fixed kdoc issues
>
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 226 ++++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_type.h   |   1 -
>  2 files changed, 137 insertions(+), 90 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


