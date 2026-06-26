Return-Path: <netdev+bounces-302254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sLN7BXTBPmrxLAkAu9opvQ
	(envelope-from <netdev+bounces-302254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 20:14:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB396CFA9D
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 20:14:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="Bd+T8uS/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302254-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302254-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 090923031CDD
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915EF3AFAF8;
	Fri, 26 Jun 2026 18:12:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1D37CD34
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 18:12:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497541; cv=fail; b=XU78uwSAK23NFJeOKPIp253oJuE03zus3+2Et2CSJaFvGu/RlQkuz//uGrhy1hROuTL1sZl77nKplZ+aV+hn5q4iUb1XiUPXBCNYJLTFNpAefOTlNQ2rpty1PrzZW8JnzoLWS5ighdti9SLz2/rLCI5tmEDmfd5ftBvqUip1Qwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497541; c=relaxed/simple;
	bh=G2gyNEQt5juRE4Y+3Uf1iKHY6VFVUNFfYxcgBo2/pW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EsSTaXlOoIel3exX7r1b9XrskseEIo2hidQckV9oHZUDAztEps+ldBVEtqJ/iE+S2Y6VgSwz+CHfgFfZbsNTzk2CzpoIDbN3ix2YG7o0m6IORnA5lMS7ouOwgaX/ntcrinBAJWJvOMeFc0Z3RDobChcAhjwN5WpPVpoVN3baq6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bd+T8uS/; arc=fail smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782497540; x=1814033540;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G2gyNEQt5juRE4Y+3Uf1iKHY6VFVUNFfYxcgBo2/pW8=;
  b=Bd+T8uS/sx7DFHV8JQN3d082wc8vrNv5MMUQJRb5cg2uDqJX/CDtKUjS
   6+qhUCj3UvUDOGoUqPiVFcXXpp3SEOq6ymzJCSRtVndpP3Ewz0UtICBSS
   /RFFg/EP78zma2CMg5rcsDR0pIGRN9L9U0Yln2ELtWeF+9t8GWpOQjC7Y
   wYzqgCMGnSL9IEPKTGMAde9rzO9YRtBPXgQVYD0SuqQQwcT2CPOU5fBkA
   7l3lSRrj70tYrQUX0gzFf2OQ3lpUyAO2vynHew1Cj8gTufp4yLHAFtO3k
   GdvTwKUvD3OIVH0Ucvky3XNs2gvEwZFzuGgVW9dshuxUYZJJVwlA7/WhO
   Q==;
X-CSE-ConnectionGUID: J/DN/uRkSPq+5wuwIB2ufg==
X-CSE-MsgGUID: gY1jNUk3TvOqYC5OQDt43w==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="100727424"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="100727424"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 11:12:20 -0700
X-CSE-ConnectionGUID: UAiMN7O0S9Skcuh+NdjS6w==
X-CSE-MsgGUID: NMPLrBOtTcGMZ/O7eIZfKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="251541560"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 11:12:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 11:12:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 11:12:18 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.21) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 11:12:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDV30fADrIKKYZpdQ9/f+PxPD8U+SjXjBGkSJ0SnN/PS+mXbIforOYdG9/WcomxKKJctkua18ooueoUBCcf8LloLMVhTHpWsp5FbUA1glwbTmPHH2SKhV7kWUkc2XhxAWCmR4EKWCenJ78KEMa5qbT90ffphY2yFJbVO4oQPuV11DFYgM8cwiieRjMBgdrkir0n/jX1tCY827nyxYpYXx6S5M8NepXeYHfNLDt1SA1wbAloCV7FMRLjAecI0S/ZMZuSzyZy5BTWF7YkTrgIvY9bnrHsSb7Bsl7JieYLG6Kd4Wm6BwU/WUcjopa+omY0e9hu7AIWIUXzB0vcbxtmwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlJ/9m7VsuvvGPz/U0+4w9iieRqujS47Pd4dH51wrG8=;
 b=YqpOOhYdFZoEBkK78TjK2jkm8CoKxdnqJCPpcgpwQ/DoLfgb64hRlyZjLrOaxBWVBYMrHycofO1HdtvZlKkGwGQA68kR8SrpCWJxullahqkeMbqx3YXbM2EuJCV02xfzHux98TXTvcIkXwZ7jraJe3v4QWFx2EcrHKl9ZUrqbwC3N5wTGzkug1YKgPgh0o/to6nF1gx8f47liB0JH2/xlxOqpsAqKGWJDBsyn1STX9i4DhEP5kKUUw4JcI0qk4FLynlmlHJ4XYfEjxPzP5i68QIooaRrrSAsehlXwE2h6Ls00YtbRR0nbJefKqffEESX56VIcc0j7+LdJnM7bAmZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6912.namprd11.prod.outlook.com (2603:10b6:303:22a::9)
 by PH7PR11MB7099.namprd11.prod.outlook.com (2603:10b6:510:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 18:12:15 +0000
Received: from MW4PR11MB6912.namprd11.prod.outlook.com
 ([fe80::1ee8:dc26:e7f3:3d4]) by MW4PR11MB6912.namprd11.prod.outlook.com
 ([fe80::1ee8:dc26:e7f3:3d4%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 18:12:15 +0000
From: "D H, Siddaraju" <siddaraju.dh@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Das, Shubham"
	<shubham.das@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Srinivasan, Vijay"
	<vijay.srinivasan@intel.com>
Subject: RE: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Thread-Topic: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Thread-Index: Ad0FbzNABPoQ31JxTh+QV3XDba1IJQACWbSAAAchFbA=
Date: Fri, 26 Jun 2026 18:12:15 +0000
Message-ID: <MW4PR11MB6912BE7FEDE5C509B6C5D5DF9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
References: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2994edfc-0894-49c9-abac-6daea5e12075@lunn.ch>
In-Reply-To: <2994edfc-0894-49c9-abac-6daea5e12075@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6912:EE_|PH7PR11MB7099:EE_
x-ms-office365-filtering-correlation-id: f2c98ef8-3e51-46d0-1cb5-08ded3ae73c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|23010399003|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: QdGEk+K1v5Dw6SP+jbhIlF0CTp9m/cq2eNz08Yw7DtMxOc2QkPeExY8qWfmW/uXQ1Xn6IdJUykg6gZfyXqaNBO7WGHq24ZXBPCZrAPsp1klCCL1yBUh4e9cE95Ja0qliZQsDLhwv6fTOmbNcEm4RmKzZJZ6CM+fobsHSSQgxeg51TJJhsrc5rPkmZWUF+6bsTJDF4SR+5UWUsdejLX04L+y+ZVaXnlF1uWeg6lWIGNdsjWmImC1MiUSsEKqXvgNa9OND5QHESrtBSQotSVkuCjOpkAgFRNJzxxnOqMTP6akJm5JVd9r82o06/oBmTu0ffcS5YU6QTQ9S7Iy061a9pxDm5kw8si74nx+aT58croPf+6Drw1kP/wu8uWZr0CuQSgF5mK9LY95QJJ/lgiSR/LqHlG3anLJoFz4Vui2dKJuQ2MdSnUlGM6WkWiW7mmIuu1RZnXuichQJTxI882JAix2Jkh/HUL9RJClDHYJ7QcbbTKvpfXQdMNjC4g7pqsFayhyWR27RgGSulA8SVdT+w+TZY0vyaRwPjiVQKa+BAQIMgHM+BS3TPtp8X/u0FRV9/P85tGF9DVIWdi+/5NKbXX7PFxO4tbVLw9Lx431Wga0/4rYIbdvefylIxkqID8Tm1UBUKcglVC8hRtxsho29JcDjqA0kRvfptZBXzjqmn3Xp2oE81yT/XNKml5PPBC/rvXDN56467ZqwwBVu3FN9jPBGUH8JBOTrHfiUNzeFkDs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6912.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(23010399003)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1uz/9nL1IsYOd9w1xE2y4kaSVQCCB6EKB4zRXGae4DfQdLY6U2egNd8rJ2kK?=
 =?us-ascii?Q?XbUSaiJz7aR7gGvJdjKWRj5VbqQSBEYOUt/IJ/lPVmdstG0Dg+SttnvDk+E6?=
 =?us-ascii?Q?qqgXVRc81i5p3HvCgwfW3WqKT1f3iXj4Pq7bH/YWWz8qC8U7lbOj+RNCuI+V?=
 =?us-ascii?Q?O4GeemrmIM17wbjY86tfaj6gVKAHO1JBy75QBr6MHdFc3vV5MrsP6Nti9a/O?=
 =?us-ascii?Q?Dg+JkdPKErFgiNwmwWLIktEVxXIkavrMce2+mqmDnn4PMmijOvVVfCW+TJuS?=
 =?us-ascii?Q?b4M+Mdw7pFtmIiK8qxAxdGlzfWn3CFjcW/FpkKsfbwY3k1nKkEWP/rFpCWGW?=
 =?us-ascii?Q?6GWH51oyqqwxL/eXOvKpKjtgZealofYLW+yKns1qwobIRvv3tbeO1n2IDiDp?=
 =?us-ascii?Q?wTd9UqBB2+Wvnb84L576Px4YfM6hV/Pdl1WdjHosQa/JH9aJjufxi47WhFAY?=
 =?us-ascii?Q?7cVybNgWnPSF1sUq6Gbv2HvB2fjgMl8iJHZQRLNQ/coOZIi0wawlpsCl9YMe?=
 =?us-ascii?Q?lShcJCF0q7/Hrjif+0M3cF61W2FvbF1qDgqa6GyUtSl4iksW2vJ7OBzEIPFz?=
 =?us-ascii?Q?ZFrXnXpx8Fz7AFeJhQrqJVnY5fcqa28Rzcni1QgCUo0lp4hPGtA33nlZMQNz?=
 =?us-ascii?Q?q0zQAaZdixwjY72+KLQcDzf1h1Ua+JzagpdjohIF9/3W+GjGF95iTalxLeRG?=
 =?us-ascii?Q?z4WrOEEI+caSfaKTyxQ5svxJv+vYfR0AQu9yjpXZFWaeMiJ5NKyjEN/tc5LH?=
 =?us-ascii?Q?ELno/o0bKo80N78Z9MPREhwOzjKdkuAIZRtDGq/YBydDBcYwoC+t/DZUMMLC?=
 =?us-ascii?Q?l+anCbqqjTBjyIG8ldviUMUHKIJAPjMEaZuLLFJsPzbXlw4emcj5A/EgDdBn?=
 =?us-ascii?Q?/Tx/H5LyL54WvOTXFdld5I40qYN+T9yAqWCAGFe0aUODiV99WeeMjw2cMSF2?=
 =?us-ascii?Q?eMudpU35/o6X+h18ypFJGwOdVPKydPgh2/6kzo0o0P6I6hWqBHPsdsdiUT/4?=
 =?us-ascii?Q?ZKE+5pXB1jl4RH6VS1y78+j+YrY6f1r/mh7uI5huU7NuQI+1R98Y7zNVk+BU?=
 =?us-ascii?Q?ATTO53E1LFgqZDEzTm4ey6zG4esjf2u1Yxu1tqZXQYknrBqr4pCYF5w40oKk?=
 =?us-ascii?Q?QX4LOQRZxHheQ3dX0C0+L/mjICOoTLuTBSI9MVcV3hYc5Wkg3KtXPZnSCM5N?=
 =?us-ascii?Q?MkhizSMWHObuPvgREKFR1elEnpPgYcUI/wHNmocpbNkms8IPiyJ9uOaoG1pz?=
 =?us-ascii?Q?6WPoUwmFwvE6ukeyLNtNB1UvFb20xbzy6Ni+FFUw4Eof62BPXSTISBymlCMl?=
 =?us-ascii?Q?fMr5XFUx5jRujyWP9pOyYoM/LmzSZS1NcqeAXX92xsHFOdgrXeAy54VenYD+?=
 =?us-ascii?Q?ZzNvxSkBZ5IrDs1ixHP9gFYa2RkHwwOlSyZkJW2fYWxxfgykhQyCvQgx+UvK?=
 =?us-ascii?Q?3r3Kf8wQ5jpc6mOv9ihqfX96i1YZwlmGvOTrhCSdiZBVyiLczCjdUIQy/xQg?=
 =?us-ascii?Q?ByLX75NiptvwEfIDHcNPCZFM9Fcy5m9Ta7AbqlhsQUyVuJrdeC/M4KH1vg7/?=
 =?us-ascii?Q?Vj0URA0wrJfzLaBV3EAPFewvpp0q0H6NUYkrY8XCX99jMyaNBglaMVru8ms8?=
 =?us-ascii?Q?j+yntF+yHt/wNfm7AnZ4S+G3vcBQCz0DPpG2l601SGrW1TWFgP1XIhMDvUJ0?=
 =?us-ascii?Q?qAbvJpjpb7AELzmeQjdS9hobtjx5qL5tky45wIWiCWIwb5AJoZ5hsRoA0Wzp?=
 =?us-ascii?Q?2m0GfJOPvV3SoI+IgE8txikwZgIelcg/4tJ0RDg8zv8j9xH9Ojgcw344I+0p?=
x-ms-exchange-antispam-messagedata-1: NCGuOy9AxUFdfA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gdACCneQPUBlcYXuOPFqqwPqHx7ORXejKuLH5VDZY02imEDdisyMQ/honCecFHX2Z0TtgvBDQYgExRaoJsmrqWNHn957UhIDI88zTWnI4kBlSByPBnZdzPO7yjBd9TaUonNj48g93UnYZg/zpm++xx6FKyIMmN7CzvC1bki+WUUx6xyxYI7dEyVL5SODQskvvUirh/f0l7eFYB6qrIVh/oNVgzk5JwtySWzKOzOaguWZYAhzgYpfMSnvZ1If5C4cgCNZSIJnl+UXl2Grtxfnh6iaYQlWyxQSCzpR5qoU+DP3/28PxPnUt2furuxcLwspuRjRICbY5lv7t24OzuEb2A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6912.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c98ef8-3e51-46d0-1cb5-08ded3ae73c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 18:12:15.2392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAmWyX34wZ8JHh4KApci8GlSYHM4y+DW+xRTh/rsf52J2JmWyp9lcMRK16ADVlNlQuvFqkEIz9xwfl+kh8AZhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7099
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302254-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:shubham.das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:from_mime,MW4PR11MB6912.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AB396CFA9D

Sorry Andrew, carry-forwarded IEEE's PMD naming convention of separating me=
dia "-CR" :D. Will stick to Ethtool :).
I was referring to "ETHTOOL_LINK_MODE_10000baseCR_FULL_Full_BIT" and its as=
sociated documentations Andrew.

- Thank you,
Siddaraju D H

-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>=20
Sent: Friday, June 26, 2026 8:02 PM
To: D H, Siddaraju <siddaraju.dh@intel.com>
Cc: netdev@vger.kernel.org; Das, Shubham <shubham.das@intel.com>; Chintalap=
alle, Balaji <balaji.chintalapalle@intel.com>; Srinivasan, Vijay <vijay.sri=
nivasan@intel.com>
Subject: Re: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?

On Fri, Jun 26, 2026 at 02:15:27PM +0000, D H, Siddaraju wrote:
> Hi Linux Ethernet Team,
>=20
> We explored Ethtool's "10000base_CR" PMD PHY type and we think it=20
> might be just a wrong name.

~/linux$ grep -r 10000Base_CR
~/linux$=20

~/ethtool$ grep -r 10000Base_CR
~/ethtool$=20

What exactly do you mean by 10000Base_CR?

     Andrew

