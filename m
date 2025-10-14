Return-Path: <netdev+bounces-229076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A490BD7FFD
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33CC18A5960
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE08305971;
	Tue, 14 Oct 2025 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+BzIBIu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94E61E3DED
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428191; cv=fail; b=dAZ0fRy1y3kMGi16gqr6G/t0z+L336Ez7jiVewfzVWvWzTe1VrhKVUvQawT0PlYSodCsoB8xXwkWUrDCGA5luOQMInmb7S6ggQDAeNZyuDxnh3nJRgbsYFE0arZt91MU1FFq+satqcMPbgGbf5+xOUH4rCHRU5OcO8rdidw89oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428191; c=relaxed/simple;
	bh=oseR10xs9knQ7b3pbM6lQxE9DnQ/YKkOm9DPxd6/xAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VJPYqEvsh00J7BCXfO0Ii95fz/4avo3GQDvB7nNd5d3Cd/VVE5f+t+73Au9CP39OzYmqhsNdWgEtbkWbgBJ8Xt6zo1W7lJxeSWAgXk1l3sbTq8fO0m5DDn4f+KgII1O6yJ44hiNV3Y2Kmqhnvy60PqtlG1wmOPj2Nmm6vV8beBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+BzIBIu; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760428190; x=1791964190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oseR10xs9knQ7b3pbM6lQxE9DnQ/YKkOm9DPxd6/xAs=;
  b=n+BzIBIuzstP4zv7P6khf5hCARZE7mckxYHH37Upns3Fof7vMXzKvyx6
   fUIuFC6ogyovb4PPPzE2V0sa3XRPXEvntd7S+Fpr9pcLHeEzsYDHzjqQP
   fyPOD73vo2oIBjqI6FN7PvWlBEV46mjkliJE3aK7Nxp519+WVYylkjR+S
   0Z3PgVzkDmRoGwMJx/txxDSYHvUarHdO+V177xJMbTX4humFlbj8d/yer
   Nvsc75gkGojijhb1ARANTGbJvb53gOcWgGynKhR7qAHNZ8/uv3/DKcmLD
   hXB5OOa3b3vRhzpGmFO5m7mAnlqDdcqWK5ZFoOfQ17vXZ2Kmu2Bs0LbSx
   Q==;
X-CSE-ConnectionGUID: FKTiPNAxRDCD51UCBU17Gw==
X-CSE-MsgGUID: VS1B5n5bSqaMUwpQeq5F1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73260200"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="73260200"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 00:49:48 -0700
X-CSE-ConnectionGUID: F8sKcgQeRsOkRS6Qgdwr4w==
X-CSE-MsgGUID: u5uwocuzRmSzDW1A8dI6yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="205510491"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 00:49:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 00:49:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 00:49:47 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 00:49:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzEzdQpdiKhuk6SDmYIHeZVLJ09qnM/FaltOt7P6Ckrqfp8UVYfIvYKrvP7pei8ZsCfSpvg75Ccx2MNYDa9REhor1Er2wvrEW+nnUP5wU8LnKqGr2Yt2mgLrYwboKn+tNsuduEZJO5ojEzI7t0sFyilPRv45bIb3nUVAT/l+8vby32qtss42lw04f+b/jWQKZdCS0FtgI3gzeUCBfqDGhfrDLkAYH9QxkJLy4Hg1NW1M3+f3XEd4LCCB/Z7g9oCRhW1w8y8gsNuAeTK4GQ4Swl6muV5xI+FwItrbHVmAsQyiafSxrRl4SDD9F1BVGabVKSMajFaJ+lXVllO9zeNgOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oseR10xs9knQ7b3pbM6lQxE9DnQ/YKkOm9DPxd6/xAs=;
 b=bVA65UCsoLLE/bx8WOx4Oxv8N8kYopYtd6Sh+NWcyaT6UGLw4JSyuIU0/7U5dehrpN/Z6J8o4OII4zneMrp397+8/riz5U6BnQ8oiGF2H9KipTmTsAUSp9Jlw087otqANd1cXfyhB8uAShP7+coZywkb/dVXjD5JUPGPJglT3+vWKwYgDqHtaACbn2mx3yfxXr+t9PEhdo99Ah2Q1OfiNRKjXqUOcs7xZl6hHwsR25gAVpNw9epcellVAOIB+DkTyfQOOK6MAtZJvulJQ0qiJ7M/0+qLfhTU2d747RonKokYmqXDmJ/qV1c8PJBArfYI6daXv737InBlTU3trOJBvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 07:49:44 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 07:49:44 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v8 6/9] idpf: remove vport
 pointer from queue sets
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v8 6/9] idpf: remove vport
 pointer from queue sets
Thread-Index: AQHcPJadH14a5onXj0S85bvNS4nsdLTBROJw
Date: Tue, 14 Oct 2025 07:49:44 +0000
Message-ID: <IA3PR11MB89864455CA000E7C69E69B66E5EBA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251013231341.1139603-1-joshua.a.hay@intel.com>
 <20251013231341.1139603-7-joshua.a.hay@intel.com>
In-Reply-To: <20251013231341.1139603-7-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB8253:EE_
x-ms-office365-filtering-correlation-id: e400fc3e-4639-4909-dd4a-08de0af63d66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?wy9buInlX9+nf0iC36he5ILT6y/wp1xUXPosCeSoUGOWMzZwHY+5/swroKqw?=
 =?us-ascii?Q?UeUVqCIdTurOfiZqTr4ifzidXcFrNtG3O518THG4Q+NN60IXsC53N8+/cp2h?=
 =?us-ascii?Q?1BdoDkERmwUQBz6xKXVMkIF4ZZQHjitBbE1GfwsRxzvsotYrdiXUoaY50QmC?=
 =?us-ascii?Q?a0bFq9K27jeeBhOwt24dCxIDCxDuU1vaxMnE1bbBUFJYWeYFdxlN5VrCYPBo?=
 =?us-ascii?Q?ylfN6cESeiLzeKKVsJDKAlK+hiUmDNzNx7HUXbtoppdxJ2x1xScF8VIfqbKt?=
 =?us-ascii?Q?SjnoBS+ZZgd9iNzslrjg6Mld6PO88L8v6RcX5xKzo9LwlmxkLEcp35mFWGGU?=
 =?us-ascii?Q?lSLtlotNaPI20yE+zvCrsnpuxhEL9z9Dp2hLnLJegC6ssrVyeTcfaK6Oot+v?=
 =?us-ascii?Q?SC0Mn95WhJ4vmED74qC4R0bKHpAE0QeDwLLc2WIK7yDgzR6t4PAEMmb2IWD7?=
 =?us-ascii?Q?rHPVSktf6911FbtFDApbuMUJfuUaGK+9WWKSR9fYQ7exdY/er5xL3QisItdd?=
 =?us-ascii?Q?utVSRmeY7PTj42ufKVk7vag4ky6cRYQqEPCXKwHkhLmZtE/JXdNJcLLaEYAT?=
 =?us-ascii?Q?jYc/bWuNku/5f3jWpPF6I4ZCXFImIbNXem8LuO91WHsrlcxUdnGZBjLxxCAC?=
 =?us-ascii?Q?KIuv2JRR4s8/x7Je3QwqEGrz4cCVDc/A+/F6+suh/zbc33xXoXF20GaTNkuo?=
 =?us-ascii?Q?vsWAGPELf2EyzDYWh4HOptZsndmf6PDdCfKaUwWs3mk8Ft3eyWei5Bsz3xvu?=
 =?us-ascii?Q?yTRdQfouSIE8wS5NfX7Nk/whCB6zgmRZUL9k9KiOs650hMPXrH3R41grfKmy?=
 =?us-ascii?Q?eApbr3tjDMGkEgL+o5aEshILJwh5lYLuCX96PUB0MziOvkf6R1MtTGAl72FQ?=
 =?us-ascii?Q?Ws4OCRrDisO+21/kPALTmgQCRFgPHJe3LqCgaUwnmm9pwFbz+9hRmav0JzRD?=
 =?us-ascii?Q?4yfAE+OLixBFV7HHbdFKJ+hyDGCOn+v3W/dUSMBTVKC1bcigaE3CHhoebrxh?=
 =?us-ascii?Q?DXYqUPPegDJSQzJPqjoL7NY2n8XafiNABnlp+P5tu08D9nxF38ojL3DtL4DD?=
 =?us-ascii?Q?D2jndbG3qp8kMT4o6HrBtnO5aW78jM/X4DBjexknz3COMxsr9ZrZ0ql6+NrG?=
 =?us-ascii?Q?3tc61d7w8Ra2lvPpBTVcxIe4aP+BzCVNsFRk4iz/K9u5T67PJe+OepTiX6VL?=
 =?us-ascii?Q?s4egNlPBWL9V84IWRrBjKhuDSn4c/ESBhY0y0NzVHwCiVNOozoffXBGJB3h6?=
 =?us-ascii?Q?KSF0Ps5iVv04N3QdJEj4DA0NwD8KJUmZ4wQi67bEP6nzXW2TQjy5wY5/ztVG?=
 =?us-ascii?Q?dVU5LnmO/Bht0HZWmnMsZSzhw9SParXnDqXP2e4zKubab50HqIyUNO7oU6xY?=
 =?us-ascii?Q?EWwvCUqUzCh64lmbDcZKTrj8eNI/gRzqnONqSk9nLtzRhxeJ/5uo6kBF6X8/?=
 =?us-ascii?Q?Fu5PbTFzTa3dRtu0OvKoDg8x28YHjah16O/TQ+/O9YFUzzwzxdol0xhgXgq4?=
 =?us-ascii?Q?daQvnUNyQs/TBmkG7RV6uJfMAQ+wLlOKTFBg?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?koJS8HOc5mP4pkRVhPW4e6jrzzCZiYxgE+8/aWCuLLmAlV3xg2M/hL8H+HOr?=
 =?us-ascii?Q?vVqOViGMfKGXf/koQ80w5hcNNSnnT/qqeIohRBskggD1Ejy2cg8s14TYF4QD?=
 =?us-ascii?Q?Ol8JmyrZNN1q8T4+txGuBXUvtnRE1rm91tKY5ykMRhc+SBAk8GmpoHLQEwWf?=
 =?us-ascii?Q?H9c/eXRpS0x4Pa1k3W7LDeHjofMssyMNaBLeCuUIZzFA6mlMaGk6Y/5kotd9?=
 =?us-ascii?Q?NZqRkLP+EF9z+y2/9F9cfoWzKTGsLIBsVqUwXeL15Tav6QOY5pZQKwybZDe8?=
 =?us-ascii?Q?HnPEmllKHBMNt9F8rgACbVXU8qrUG0B4fqktNT5Yuyv25QpxdM4xHyBkCxdD?=
 =?us-ascii?Q?S7bIQCXrDazPBoz5IWBfXOhdhPFB+YftGn6/3oM/3SwdsMIOyBVCRczc24Mi?=
 =?us-ascii?Q?w04M6QzYC0godHKt1YwCJRrCpg+aROGeDQlWjv/LUo4iokx47dEumKfGr/8T?=
 =?us-ascii?Q?y2gaNtkcre5LcjnVuUZfKp0kF066OgTrinhRWfeahn07Rsm4cWA9lgfu6MGO?=
 =?us-ascii?Q?Nv6ByUVRsiC63UQlcAPSfyHnt5wT7Wp8PgNJ/SzqIo8fGdMRJhpL/4BBTZw5?=
 =?us-ascii?Q?xE7CITx3kssxbmUPt9IdFushtLU9kxUOj/xO9kHfBXJIWEc2reLU2mVTk34z?=
 =?us-ascii?Q?/zYS2BTeIqk3zd3xmI/DMJatsU7hbitQbcyfSNdmWOyV8IvR8Q6QA7j/4Y4K?=
 =?us-ascii?Q?rnjCeIZm1APbVUwb4D7VUiUTTWbv9Xw6HfXyi+Au4TMxGS9KmMC+N19ohwxA?=
 =?us-ascii?Q?h+1LOgbgaxNj3cNwo1HgNFRkOV4n69BgcoUijo16VEbOrUxC948PPjfskHBu?=
 =?us-ascii?Q?QKigh5I1KF4SLeDX7GtGvgl7Xv8Og1K17b/18KK6UBdCWPok47BhcBjGzDR+?=
 =?us-ascii?Q?zGmtPxefsdiakmJ4gI8yWQorUcgskJuO/szIrM9dE6WHbtFtQPSOt4lVpV3j?=
 =?us-ascii?Q?f5Xp7c/l9ZuEUyy+cRqeMQvAOMMnRTsdxMGS0dR9Oxkhq2G70j2k7hG83fEK?=
 =?us-ascii?Q?qrMaVpkqKbJSxTT8NrUxutUs4bY3Ol562TAEVT7UQhj0d8MvKeGWEOG1V62h?=
 =?us-ascii?Q?yiomO7v/NbDDD+x/oo10DyaTCM8QxIJkjzoJW4/VClYn/J5B/qHjNQyhsehw?=
 =?us-ascii?Q?CF9t8pWpzStT10GI9YyVq7VCOZ/Lvwi/6ybktVDZ3YINFdYC8I/cvnn3jW+Q?=
 =?us-ascii?Q?3WAoUywVa2LqAj9pIqVdX6S+C5z4lZJ5DI8DCyCaRXWL2ZBGvcSQHV0IidG/?=
 =?us-ascii?Q?QXW7pnCymOF6bXK7tyLn7gYchWiZA5o0aZIOr6IQFqRUfln4aCKQEz0O3VOp?=
 =?us-ascii?Q?CC3VN4nR8CQjTn1G+wsymq1LMv384fksTeaRXjT0qAbMkPdEYIHnz+vtyoWu?=
 =?us-ascii?Q?MG/G9QrrvdtWS8ThoFf2dIdlyAlVnAZev8dfhIlaXSJnVZ7litOKQO15ybmp?=
 =?us-ascii?Q?mfh01KPXc7Jz+eNAOy8WQcFbvUE52dn2LyMMCH62tJL84uzF4YT/uBva0apg?=
 =?us-ascii?Q?VPBoXMdoDa5dFD/OY/mkwIHKSKonQO60eYp6In5flhet74ojSxOo3lsxZxoP?=
 =?us-ascii?Q?3H5hsPS5/9OWF8OS2iwoK0H/C9dy8dClswPdII5YmIrOG5Qt0Gfy/pqaxCRZ?=
 =?us-ascii?Q?Iw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e400fc3e-4639-4909-dd4a-08de0af63d66
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 07:49:44.1378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWsz128deoSARQkRpjVNQq+a4l7wOUXpoY+w7qKWMbZhNeLsN2jEMr3aBDfcw1eEwCc8mDBtcLK8D/BsqWBHmQi8smoJajL3ZO/QhRXItdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8253
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Joshua Hay
> Sent: Tuesday, October 14, 2025 1:14 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v8 6/9] idpf: remove vport
> pointer from queue sets
>=20
> Replace vport pointer in queue sets struct with adapter backpointer
> and vport_id as those are the primary fields necessary for virtchnl
> communication. Otherwise, pass the vport pointer as a separate
> parameter where available. Also move xdp_txq_offset to queue vector
> resource struct since we no longer have the vport pointer.
>=20
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---
...
> --
> 2.39.2


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

