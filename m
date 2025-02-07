Return-Path: <netdev+bounces-163779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E82AA2B886
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5655F3A1967
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727661422A8;
	Fri,  7 Feb 2025 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IK1pPt2W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C194C6E;
	Fri,  7 Feb 2025 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893485; cv=fail; b=E8wpS+RLZPDeUhi+Eigzj4qG2jAQ+Wg4kuAUDowAbC8XoSy4853mTmALhbPRXXzT1z9j+lBuhAmF0rzFdQpjSn5ujaY1xOBvYKTOcbV/wMIo0KtmVjIWU2mgviulJFRWJFLKToVIsHz7p6U/yc9KGkZNpYeJnw5xuxoFtqlX84o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893485; c=relaxed/simple;
	bh=aCdxCPO6511IkKVxWoz+aqAFzQ9HaEHKhVAa+RGj1zw=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PFHNtnJlDFbTUnMOEbeJEg7rQAcbgjOlEhjM0+QvZzYMRzbk6dpF01oITKUETSyWzOB56oiweLyXp9RWxCd315ugRCNwCknVrRpoD4MdmrRvrwax4alCVnxjbGuauy7j8hvj4J94RceR5aizg1dqwgB6GJlUUHF5C7IodHiaecA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IK1pPt2W; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738893484; x=1770429484;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=aCdxCPO6511IkKVxWoz+aqAFzQ9HaEHKhVAa+RGj1zw=;
  b=IK1pPt2WBE8uhGNzF5etHBBvq9PvMbI/dyjZrtFLWG3AOxA8q2XUvsBE
   6JahJpyaziZNqdYmE84zfLFdCHKg89XmGV1UNOb9cv5G/Wechx7YQZhGq
   +xQ8nCWFdG/mY8NkkvfKrG0A9ccdGW5MDKkCJUMPPas3yW92o9dlYee6f
   jzXth6mpq+PKXN+288rVL+jNn0SjHf6VAvTu3RtrZho/eENWcVRQLFq/+
   RE4n7Hy4G8p7hbbNXD7CasnP60gBq/Vrwr1gfy6UiaNZUzW17OXz21lvc
   1yiR5WCcRbvjzSh/4kxTBT7VOvowgwQMxeD1h/QikhivwoS6Z/VkUXuVo
   g==;
X-CSE-ConnectionGUID: SvskkecRSHWBCDwpPP+x3w==
X-CSE-MsgGUID: HmfxNnfaQtqgzGgzCM1fEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39678704"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="39678704"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 17:58:01 -0800
X-CSE-ConnectionGUID: mUWCK+wtSa2G2J+WxUzeWQ==
X-CSE-MsgGUID: /vlUt1m7TaqbBJDLEyBFBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="111225783"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 17:58:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 17:57:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 17:57:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 17:57:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2ljKtGmsmVtuBy+UlLotkvYMzjtu3ARi6TynqMM68dsI5H0Z5N0QPFHrx4w86PDX49+yhqjA8e+hU6vORmshupW1yJc6Gbr8CBSCNxX9n1qLzbbNlOaAn/DOtGxI/QUkulQhQhHihVXr4C73SBiiN7q/o9b7969hzuuGYOEz8kClHkn7ePXeEaq4CcKUVXH/z8jcE22z0GteO7Gn6cA1rCBE6Amd7S9kC/cj3pqQ057k/hb7otfCzP0Ol3kiMpsulrQ8bS2JtBvVIWuksPVikw5xBEluVqcghFLfGQU9ac23lLp2qB1stJdApeFjc4r3pzVgkTPZDYkFtkDDmhnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Q/6dCjmv2tsou9RuDvKQsFiTqqbiTmMkPDJMzILjcM=;
 b=mbkPOd3bpLM3gm19HreR3PwXB0hJtzS49q8g0jvoYbBhbNmW1s94rmU7xhXt0dpg/k6f8FNDvMc7lycbJ0mh/Rvs+T8DD2XvKkcHf3HbisPBQgF/6Wv/8vwca0+S03kEllEfi3lyEz6RdBNhtFikhLi50gGMDMXuAO4BSMyhofKEFguyTkRrcBLJH/bUxzn41/fud++AgP1qFPlAEMI8WepgfelpzfBnS5rC8KlrJRYf7Cak/30GfBYn5bYHlD5Egazji4LbvugKHaL0T2qIKl7wA52ejpVac/bAkbfiNES5K2uaJYhe6Tbkik6Kz3gIukcLS33JjMJ7CCjeb7VYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 01:57:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 01:57:56 +0000
Date: Thu, 6 Feb 2025 17:57:53 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Message-ID: <67a568a18a432_2d2c294b5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
 <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
 <c3812ef0-dd17-a6f5-432a-93d98aff70b7@amd.com>
 <92e3b256-b660-5074-f3aa-c8ab158fcb8b@amd.com>
 <6786eab3a124c_20f3294f4@dwillia2-xfh.jf.intel.com.notmuch>
 <67a3c49e1a6ef_2d2c29487@dwillia2-xfh.jf.intel.com.notmuch>
 <5cd8ee3d-c764-403d-9b9b-bca268b33383@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5cd8ee3d-c764-403d-9b9b-bca268b33383@amd.com>
X-ClientProxiedBy: MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 36143281-c5a9-45e7-b1e2-08dd471ad73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x9dCTlS/6q737Z3B6OYJviXJi7lGrCwCfrgAs3t7WYuUxLp7QpzfDXQBFk7I?=
 =?us-ascii?Q?eZqSe1cCmFxGDYXl8KK8UxRE5GRs1XPuSis/jgFBvLQ8yg/Xgwhx3lg8MKbT?=
 =?us-ascii?Q?yZPBBys6iARKe15+35xC7udR04HV7YCQgQHUok5Clgteb0TR2FzDk5NGEvBE?=
 =?us-ascii?Q?YjzOu1lDnV9fmhK7isY8mB+o52VLOFRP1XGK39MG0VEGpa3EotyCEmGQA2Ik?=
 =?us-ascii?Q?L+jwH2IW1E+MOR2wo8DPxCGFYfAKQU4oFA1NHcX9xn5CGkrog//RToFMSxfL?=
 =?us-ascii?Q?+uSv721seneBth9wOBGeGGO4cr/oe/k/w+3eh7ubI7AZqDYrTLRWrL3VN6dS?=
 =?us-ascii?Q?RXmtguamHH0acBt3CmBLnevGTnQ+QRMCk8nIKnGs33de8hnLZ5FbqMofFBvL?=
 =?us-ascii?Q?DgsbWNC2+d7AiIrJn4LmAH5umII33r7G4RSSMvrmpAXCakqCIdrWuOUZjFB/?=
 =?us-ascii?Q?g3a3lBbkSWxoXGXBbX0R3d54xvESCHc1fVXUeDHwbDhX+i2tv6e0J0nWvuFc?=
 =?us-ascii?Q?lYkhRl6PWV7O3oZ/bOPZ9ZD37xaXQUFNTN9+KJDq+dnOmEvsZtlq9MKIih6T?=
 =?us-ascii?Q?rDuIvqoMr2nMfDUu7SkdsmZjtOkSttUFMqtpHEx7/qlZpcYo4REKYdNt4I7O?=
 =?us-ascii?Q?AC6++wAPI70UucJmBer/SwkEiugoqtg7V/T9+mbNgaHQlCRBJvRZB6nr2jCw?=
 =?us-ascii?Q?epO1QQdz6tjTbQAZGhAz2mjDGlbWpluuQ40tjUjXi7iMsVohZDaG7/Y+kB58?=
 =?us-ascii?Q?pwBK5d1N5qKT+d/REL3Cy6GwkckOqrPj7LLT9RiGnnNq9BZzoICQMoCP0jwg?=
 =?us-ascii?Q?qayj0c0v2V7z3P85NKAgq2yBh+OYWHLd2xNLBXSb1nsyM+PHc0HmC4gKZ30n?=
 =?us-ascii?Q?w1362oK+XjOpZjUu4emXQxXUgS91d32KpAzi1l7oTUDfbzaqkPFal0E5hPpi?=
 =?us-ascii?Q?6xeakl/dpDKAMwZrcChDNAhR6TK+ECLdxOJa0rrx5VlV2ptpCqYiRJ0alqxf?=
 =?us-ascii?Q?xTPyrTD5RFPEXKoSZ3uIj2nMH4yNDgq87508ok4p3kcvwPXGq+3i/qoUu0La?=
 =?us-ascii?Q?QxNezlWI7ytAzkSNtjOPjMq21hwD+M+xUnwk4G7JKTw8jYGwzx950tdOj7yX?=
 =?us-ascii?Q?mBHTbpI7ZRrt5afqPXpT+n4XbXhSsWzxj2HBVAe416f6xErhkQFdytyrHQAj?=
 =?us-ascii?Q?bjTR+xrllynvssxrVSQXLHOkJAAYedV1ON+4C6PTHsbRcPNF6/WRjRqPRFZh?=
 =?us-ascii?Q?WtjqYM3HlwiB7SzJgb89KCrxL7HMiekxD49GVqFFibGiMFebZm2I68THQN7z?=
 =?us-ascii?Q?xrnIZTkHvVba6f+KYhB9Mx7Pnutw7SlkmkGhAJmvOyWDNEWdxkLN8gjRABtf?=
 =?us-ascii?Q?s4SgVCEcrY+hJVSnYsG0Wok9TGdIbBIFOqBV5GuIbTntCrA1dYhv3ysDmGEt?=
 =?us-ascii?Q?nBVrfQAPwyc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LGhw1u/ki6Gng87u+CxrxGsvz3djqk7LsUlUd6zbwqOLL+FAmJjSFyUft+2b?=
 =?us-ascii?Q?o8bOhAfAeTfMbNEHH0JtCJjZSWMPJTq6ifjmOdZ0HVpAq/r1PLNxaABAWWLB?=
 =?us-ascii?Q?uaGyGhRy8m9atd8gwikRsCYJ/Zc2lpddSiJE7obl8uTRVjZkbqYY3prZ2H9R?=
 =?us-ascii?Q?NaviXWDI1gKflfB6XE/HnxfU+IL2WxYBfGGR5667+jpzyHp+n5OIY74KiBGK?=
 =?us-ascii?Q?LXm9RHMFr8Ai9henEzPQ4/tknRtPfjHxQJtvpMzG/UkUfo79PB8Uo8tVZvzp?=
 =?us-ascii?Q?y2bAB+jFwcp0OT2I2ZYl13oYboWMYlqWJvTVO50lHvG3gd8kP28IF2/TuwW6?=
 =?us-ascii?Q?2F33cqp6XdL4cRIkO6PG4iOvn1z4OeZb5CCpbUzAaivgj8yMLbkpzLZOtslt?=
 =?us-ascii?Q?CpkUTSO1Za7IFzF3a4PLOw6wJTxBi/SmNaiBGyWXHirKC2rP305DEeKoMN80?=
 =?us-ascii?Q?X2D4EEeMZeCE2J97F5NI8zDgTuJD6vvm4qixI3QEvl9wQFW00EHT/M2HXZZS?=
 =?us-ascii?Q?KHObUMh3Z+4GWP/63FgY4Boplud2PRc+eAquD06KIC4nsim9w/JrsRgp5Iyl?=
 =?us-ascii?Q?r0mkyRyg5VfCYI6XYTBxMqhu9Zeng2+BIcuzAT0XFRnyYCyKlnAHHxZX48R0?=
 =?us-ascii?Q?zB6XnQA9Rd81KBPhqjzZhKw4bWWwrhPOXLsAtBcNpz/GMrTIQ4SvPBM96LNd?=
 =?us-ascii?Q?8jpVu+fB6s5lK5q+3ywbsamP+wlGZcPqnZP4V/xto2adhcJEN1Xa4F3PvBr1?=
 =?us-ascii?Q?IFazxljfg5+ZD51nIWjrRSvsOG5eQx46enf/NZdIZm9+rwkqbqIaxWRdAeXF?=
 =?us-ascii?Q?QDFOsSGuOdFIxB429EMaUpQd1+PdZs4r0p9fnGDVukLlvaNJhcZvzLSnYN2G?=
 =?us-ascii?Q?ILLR6qd4IAnP8H346y3JYwOp3y7Xqh3bFII3AECW1nZbvsZjowHqX4GYL4HF?=
 =?us-ascii?Q?8H6u+5KyNZUH7oys2VK7Q9M3usULPMcGqKRoRR8/qoegrmmMmq7R2+Ohywyw?=
 =?us-ascii?Q?j8SdB+buvd4NTzQ7NjgRSluSL745xFn/zxHKCo9JZoNOqDxMIIIg7gWEvJvo?=
 =?us-ascii?Q?0hSbmuMQ0zd7XJqKtzQW6D+IcP6qiar81HjgiCBfFq2XUuHZqdgREWGlRcOW?=
 =?us-ascii?Q?qIzGXGxtBfONMqwnG693p0kcrMGHea6J9k8BYOy5RjjyW+76/MncaAbcHg55?=
 =?us-ascii?Q?D+GJbmpHh/OApFJ+S6S0J7OCm4DnQTzlSYa2Dkfjwxf1R2z9v2k97z5STNTA?=
 =?us-ascii?Q?2sjf/Rm0P1a0LAYA3+k3XBZo8y/sHpT7rI92mGdu+cSaz79b4Gjliqbbi5+w?=
 =?us-ascii?Q?o7xHuc/EJgCMf1uFCCiumJJ2Upr1coWsikPDMWSLmCS/qeeY5J+ba7fa6Jwj?=
 =?us-ascii?Q?l8EwPSW8TGFIcZJytSzSxtf+puFgkkWBKyrq/uvKjRtVF1k5QBIJzU0uSqJi?=
 =?us-ascii?Q?vbg50eDrUhdXfJy0rb2Hr8NWL4ADycJcDbOxtJLd0lUupXXjomI9YbPw6uj8?=
 =?us-ascii?Q?k0YGbsjGR1Bbg+RakN79A5q+UJFkM1ks61hwUsfb/e53Bfcmdd9Q38u0WeA2?=
 =?us-ascii?Q?gNWRnSgAtg5oIasjwtxeDroH7nMXir4bOhCTsk0o4BFSjYBFKCdq907tE6hW?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36143281-c5a9-45e7-b1e2-08dd471ad73f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 01:57:56.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngqf3p7MBaEni2X4uqvUbz5PjbOdKaj++Dw5+q5TevAS9WvzOu7Wr76LRBYMGaDDeFIKRhdZ1pmH6pnRtsIwPpGkGEqi3krXMTkU7u1TL8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> Anyway, if you have look at v10, I have modified the accel driver 
> allocation for state using the memdev state instead which makes more 
> sense to me. I did use that from your original patch, but it makes 
> things complicated and a Type2 is a memdev after all. The code is 
> cleaner and simpler now.

Let's pick up this conversation on patch1. Note that
to_cxl_memdev_state() returns NULL when the type is CXL_DEVTYPE_DEVMEM,
so I am confused why cxl_memdev_state is relevant to accelerators,
especially ones without memory device mailboxes.

