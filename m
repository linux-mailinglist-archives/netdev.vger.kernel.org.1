Return-Path: <netdev+bounces-270056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKAbMCynvWkAAAMAu9opvQ
	(envelope-from <netdev+bounces-270056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:59:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3782E0A89
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D895D3059ACC
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D1D358377;
	Fri, 20 Mar 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UltP4b+8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE51352C4F
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774036416; cv=fail; b=TrnZhsj/mMuxJAozSI7sgvUvDspMYgM1NyF3JO4Ii/7Lf30804h6Wv29DBFOJWvoPj85/kuy7ec46ZVp95HU12h2rvi6G0RbVfWipmruFqV7WYVlf9xoRUPwZUYKkh5W6OmJAfpTtKIEF9a1x7nJbJ0C1vgB4ZIXsAnVcxYdwx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774036416; c=relaxed/simple;
	bh=GU+GT29wG+queqxTkAiS3oBhAvCqHFcNI7Pl56tt+YQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mWPWPf1sKFo0W6v1MzeO3a2Evk3Rt868IKOK6Q7BlUumztBlieSiT/9n2Oh0x01P5eQJbrmvEx5YIqqRFaLtOplr//oS3z2QmsJxT9PjgoeZam1SQxLPJvW4ulQRJZU4yRKUND3JJ4jYD75+6oMpCa46Eof74tvG7Vt2Bx7uWN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UltP4b+8; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774036415; x=1805572415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GU+GT29wG+queqxTkAiS3oBhAvCqHFcNI7Pl56tt+YQ=;
  b=UltP4b+84IS4PaSr6JZBjr2bAD+cNNRpy8+H8wiE0fIPwo3BOQXLaBli
   8Dh54KqKpEbL04R0SFEiZayTv1SHXxRG9kX8tTSMVu18cO249CfBEzfug
   yxznMT4dtK4riK92oqVxazHxKZLaVV9e7jp5lUD6V3W4PJD1AAYZJ8QwZ
   Tr2GuoSp/aLB5qpRwMVJNK4aB+1j5Jr5tnvSk3GrezZsGYQLeOEgNUxxe
   bVehFT4BbCD3Id5/sQEEfPrfRk1E49WiBdjJ0Lszf4AEVDtgNvjPoHTUy
   CXg6Y0nUyjAGgE/jnDfl2IFH0eG70/zd+bLyfA0Vi7J9SXEGViHFx08nn
   w==;
X-CSE-ConnectionGUID: OEWsoPyXT9aQzgOx9Rdadw==
X-CSE-MsgGUID: Bg1qRXXsRD2nSn4yxxAJgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75020051"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75020051"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:53:34 -0700
X-CSE-ConnectionGUID: 7vv7k9YlTc6fpYUM9fHxBg==
X-CSE-MsgGUID: WndfEV/4R9a+DEB27KEZ2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223368341"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:53:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 12:53:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 12:53:33 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 12:53:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTbcVzYbkZ0xNoAM2d3u9IgmTuSlH9Sb45jv4lZWUOSb7hMy9ZSJ2+D0zY2bmAMi7gK8agIaH5kELXeGlmd6SqaAgsz0ZItOSxUs6YLFfEeHeQrtNxAGj9M+PoIMqsSWvhCFbdwnoVpRwgAwylyBy71uyRy6udwvweAvCC8eyd/4RZnzfKOhNVbmKIO7cVamIeeeyWfTFGEJKhUOFvlSa8VuV/1DnLCru+PIJa0x0Lh3Bmd6DpKEKwMrW0JtG5UhA3wkHeLIs0e2dj/zmn3wHmBAcM7tEqysqvZSszpFos0tmDuJ2pATjhOaDCdiWAbJqXk/XM/4dPBC1Zl7/Oidvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU+GT29wG+queqxTkAiS3oBhAvCqHFcNI7Pl56tt+YQ=;
 b=OGjGEgb04vUJYZ6D+AITRzTsidYvkZlkEW9dvcrc/IX87i0XhdTVl1NGuSpITCSpafaSNpIpRs4RawY8N1NfyG2MPIFlxFK/JFzN90SYcAsPZsp5UdYqsRJRyyQfgZmVnYj0QffGpwvY8j7MCwquyZ8xgaYEtwhqvdI86m6ZbdTtzHIxwHKB9w3h5wqgr/rJJ5T2fIb5TuV0oK+OUKuQ5vBrG++D4uAAc5PbH8Zl6B9g4f+rDoeAwHXXQ7oVvitgDeocX3gGbka+L5h9lJSbCju1nLiV/pCMTqt40zdqCEIQzL64+jFNn9uS5sDh7d8ZGuhvlZapL4VSjGxNgoX8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Fri, 20 Mar
 2026 19:53:28 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Fri, 20 Mar 2026
 19:53:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Wieczerzycka, Katarzyna"
	<katarzyna.wieczerzycka@intel.com>
Subject: RE: [PATCH] ice: add missing reset of the mac header
Thread-Topic: [PATCH] ice: add missing reset of the mac header
Thread-Index: AQHcuCcw3dXM4dpPhkahPtZ3hifVDrW3t80AgAAUa2A=
Date: Fri, 20 Mar 2026 19:53:28 +0000
Message-ID: <IA3PR11MB8986779AEBF981B6AF66F3D8E54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260320050518.422303-1-aleksandr.loktionov@intel.com>
 <20260320180410.GA151863@horms.kernel.org>
In-Reply-To: <20260320180410.GA151863@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN0PR11MB5964:EE_
x-ms-office365-filtering-correlation-id: 40a9f9c3-ec15-42c6-6db2-08de86ba5b4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: jq+eb5jFoNElsr2FbaSbdYYK576Rtut+vjoBArpMBC4Ofp2eCsu8VxvPM7Hk76qGAe8QhAVEpbYeGov2Tb5Fs/L66M7p8A83X8DOW0jXxHZpVaSdlRChzhNpzOE6woD8EFHiOX2y2zrNmO4xgfA4915GvcXeAH5gbhg2vKide/OQBjkuVql8JXbkiXjBN5aNy+mqb2k0rdBPBo00saq8MzmKUEfmnFRgA2dZ0ZNk+UA8BbW07CwHzuqR8Hu6aSlQcktMoDRCliXCDlq1HN7ddn86EyFEBD1subCBnYPZyCGmS7GhQUpAhEA3O4zK9yP6AMVlzB6AnkR81AsN//X4pKU5jm3P8TMf5JMIo9KgYZIKdBTb3V2jfgipD4u2bOHl5qgmVTAd3ZNcYNncji6zDtQeo9k6h9DiW64bfwV6yuKbiFXCxQfEAQ6jCJEVVdfZTUsGM7PLmcHLcdf3uNb5VsWa7HnyGUGZAxaBhXaPVipoZiLzvZ+YSoPqKcKQ6DxjZrDrsu3UMkT2CBJcGTSE7nVnSRlI5AOEJ29KWzeE+GQymfunzQnUD3VQLrWiMqpuX7M43QLzbKPt6Lz0Fjlmdh92xIZhDKw9OCwXvrpUW+z7EW6EfELrzEVWMBrTctnuFgxhHpVdf9CfXtNn1+s/5rlL7n9R1JU2zmsKOY5jXOKS9lnK7INKcPxKp8WQXWvbEoU2sSSMAnwpScCIb40Y2S8LrktaNJEqsMIMqpcoi/NB5Hyv8necT3aMuFDdl3wpFXRQsV0LEDuMg6/0f50LzM+NHW9avOaGuRXPnn2AZf8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8K656Eg7nwrMq2iEP1C9fZU7daFJwCctHwzuqFoesj7EwhiZBljNqkYhjA66?=
 =?us-ascii?Q?4pBp/w5+k3f0P1yv2dQNZXVEhzHbHSHk1EEgctpTBiECWkgqSaoHlTKol81H?=
 =?us-ascii?Q?HpRRNFCDJRT91uGfeur0iPm9KKb2v9/UC7RcpRL/3WVeTMcNjaeQbwvrJa8c?=
 =?us-ascii?Q?UHH0xzF4A+lE2mou6P5tz8ndRMDGpVZg4PwpgbTwnV7v5t7Zz2fAUsUn+AlG?=
 =?us-ascii?Q?GD48rtqkRNyVxhJJL+OyQTKkhr9wM66Kg8U7HjfJWZ0BDryq7BPqFcUQ7ieq?=
 =?us-ascii?Q?ttnQCzPmsx0Kr5rKca+1xq5YiyPy2d5DsHLeHsGnEVOh+4Al9oBCg8fsO0AU?=
 =?us-ascii?Q?iD5M27Dbk1o0nCIJ9j4k0qCM5ZGLnTsiQQz1t4Vja1uin2xlX0Uw/rvYyDjD?=
 =?us-ascii?Q?DQs+xQGijTjM2fKZtJ0dMIpktcbucC7GRqCBALUNso+O6bATACV3moI7rv+S?=
 =?us-ascii?Q?7WxF1OIOVlSYiL0y0vfFb7ZlkPMqpyBwIzC63w2F1XZ7dF7m0C3kJ/ld2Lp2?=
 =?us-ascii?Q?AONIQwh74ZQ5N8WO50RihKT7la0itf5aJYmS7MYulnkAYE6E1QyYZ/CUDexj?=
 =?us-ascii?Q?M7BQ85aBw+JLh4NTtyVnw/rmIbUt7eeJ7v1IjDCZ5cXrVW8a0beOKZiCaNs2?=
 =?us-ascii?Q?zj7/u0QZCyo7+VGQBn23chTPOMsWhGiVedwa89fvqN4jRzeX7W3wZoeRF1DB?=
 =?us-ascii?Q?U2Oz5zu8k67y1XDwtjAXLIaffdOmLRsfiCf/KWdvAzdPrwl4TLZpJsNayU/Q?=
 =?us-ascii?Q?A6PuJZAS+vN8o1JuO7DkUNiRJg5RDOF2cp8TivIWOJIy3EPo1Kd5z7zqV/yP?=
 =?us-ascii?Q?MwJJBaQeNADxjKGI9Fc702o/0n6V1ciebUinnsiRv9mFsO9RNwRF1AoZHEah?=
 =?us-ascii?Q?92iCXhXpr4p33MAFlHkFbal5D4pre4zrzKaoyCZVukOTu0DuQiSP1m1LCz0a?=
 =?us-ascii?Q?2e872mbGejCtxgFT8oo3kRWBAngEwueLONOLBUQkTprCvlQEFzEcPELQGr6p?=
 =?us-ascii?Q?hFwbryMXYY3w+09TsOv5ugBcYRGhfCVBhnkXYGuyDTsdCDnRMPSlUuDIepPe?=
 =?us-ascii?Q?Zlf8+hqDU3qmmnWaAm5DpUkZExQ+tByEzlWnG8HYcRk1QwKIHyDdz1hBLcD/?=
 =?us-ascii?Q?R2v7preq4VNA1xsB+scnsDX9g3ejjQeTdqz6kjTH3RVcvlGYGTkHEgcANR42?=
 =?us-ascii?Q?wwk3Qs1cNHALlXjw4nvca7H/9i97Q7mF99SRm7eXM0c2FpnAtzz2HQhU9z7S?=
 =?us-ascii?Q?lr16keN/jwLjEpQzDpNPQREIfvhr1DcG2jjgz4VIyzzi/hRYLlcerVg06M2Y?=
 =?us-ascii?Q?zNqkslVv8IIKkBxeASPJO0zbCIzj8mYPeGfvnKYN4AYy4bajUfdlwHRMRDu7?=
 =?us-ascii?Q?Rj+6HpPzvPFnzPN2rcuK0vbvAxGNCK4jiy7Kg3YkVLRAN178blLp1TZpdaZ5?=
 =?us-ascii?Q?vtmE7xYW91BUi7JCFOAi5ysODZ9a0V7QedvMDIcP4TRfhCA3U0xAiIaa/YGK?=
 =?us-ascii?Q?m6t4A9g7/n9rUUdoS8jl1RUtg0yrd449RBdAQuhOeXTta7dWe+nrSPQ95nky?=
 =?us-ascii?Q?canFmTQFb/mI7AJZ9V5lXDWdCXvj7AY9jRz4tRuQ89ut7SLy5frd51/RCviG?=
 =?us-ascii?Q?5RrBdrava7j9iJHQrdw5id2vpzgcgvDwb8abujWcyr6w+NW1GdnNg9pBmBOL?=
 =?us-ascii?Q?Ux7NUd+ml4Q23dE9L2kVH/HHuN2PrdSaejT462PhGgu5qQ1P6oOQPhqWR/Aq?=
 =?us-ascii?Q?mTenMjXMo3rc9afzE1pSu5SMtimdedc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Sz8W9223VcJ429IxjNa0IzaSZn1vn3CApV2n4wTEwCF8X2mHmg7GDEXloIsaaFEPBoyQ3RbBsBuB6/KdEX3Q88jPlVrZzchLhAX6J9aBq5QPl+W1UDX1E602Wtt88feokpm4vvlZccyEqXpV18WBXlvDU9ezUUgPnqCEiKDK3rk/rbTY/s4zmXSuSsMAq1wmo4j9BlIxh23avl/TZYMFWoqLZRLkx4cdLd65AP+bG4RkDdZmQUXtGYzAaaQHcIdpcTkZvbqYffENTsnyu1LJ+dkW/lN2PKUYct+dWJg7tLK0gx+fI7E8Aub0oZ98lSEx0ddRXyRugMtl5asGvmU7nw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a9f9c3-ec15-42c6-6db2-08de86ba5b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 19:53:28.6715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6JO5EhrpLYjPa82NqL0v7vjjcnvsOTMi28me+EDtTlVFwzuovm4cWn+LwuSNshgGXl6IgT9yddJhaZJ722tEAldGbUiOAH9dQgd1QnCHBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5964
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270056-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3A3782E0A89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, March 20, 2026 7:05 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Wieczerzycka,
> Katarzyna <katarzyna.wieczerzycka@intel.com>
> Subject: Re: [PATCH] ice: add missing reset of the mac header
>=20
> On Fri, Mar 20, 2026 at 06:05:18AM +0100, Aleksandr Loktionov wrote:
> > From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> >
> > By default skb->mac_header is not set, so reset prevents access to
> an
> > invalid pointer.
> >
> > Call skb_reset_mac_header() before accessing the mac header from
> skb.
> >
> > Signed-off-by: Katarzyna Wieczerzycka
> > <katarzyna.wieczerzycka@intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
> Hi Katarzyna and Aleksandr,
>=20
> I am curious:
>=20
> Is this a bug? If so then it should probably have a fixes tag and a
> bit more of a description around how this can happen.
>=20
> If it is not a bug, then is this defensive? And if so, is it really
> necessary?
>=20
> ...


Good day, Simon

I'm upstreaming Katarzyna's fix.

From my point of view, it's not just defensive code, but real bug even on l=
atest kernel because the gap is partially closed by packet_parse_headers(),=
 but not completely.
Sorry the patch header is malformed, I definitely need to add=20
Fixes: f9f83202b726 ("ice: Allow all LLDP packets from PF to Tx")
But not sure whether to send to net, because on modern kernels I have no re=
al call traces only theoretical conclusion.



