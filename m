Return-Path: <netdev+bounces-303695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5hFLDkYjRWqo7goAu9opvQ
	(envelope-from <netdev+bounces-303695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:25:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DCD6EEB1F
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:25:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=G3SLaMJV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303695-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303695-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FF9730ED983
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AE534752D;
	Wed,  1 Jul 2026 14:18:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F84E341062;
	Wed,  1 Jul 2026 14:18:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915501; cv=fail; b=nVbtvnpn/yJKLqQqZGCuwyb2eRGOYqfaRcgMaN36i8aROmdXBZbx/QSRZVre1J73E887g5m3H7ygSb4lZdhPJ7hzcHNSD/EdxsQ3lErEE1Xlwech9kOwqDK7wmUu0knhtj48o69yzfZE2smJ6lHM+BIluPIPm5tDh1YDY/wOTFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915501; c=relaxed/simple;
	bh=z0xyBTdMy+lckoQGkfuB6wC7BqVjL2rhwPZF3Z61UM4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fgs33SrkQsvelkf/pyIOba23jmmNBnq6MCcqvdsRoP6xLECDymlQpGpSoEVxuHlKH7w0KrPBQ8N9oZ+8ovTnY4NplAwHXiY3q1wEsvg8v3MSZDlWMgIJRP9sxP5RZOABVU4zSy8e2aR0IbWi20/DH03Jfs2NZH13eRbYvvMo2aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3SLaMJV; arc=fail smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782915499; x=1814451499;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=z0xyBTdMy+lckoQGkfuB6wC7BqVjL2rhwPZF3Z61UM4=;
  b=G3SLaMJVwiCtP8EqkXj2XsHpuJHwJ4YOFPfbLGpavdjr+PANXCcLhYoO
   RjS16qiYQ9lVMGeBkAPqlbqZyImY+tpomzDGgqaVWsVJnKKJzMm9nOtrA
   wur91kKH3ezTN5PIHr8dtj1yU1ZfmPTRd9gXhAOSdySqHDBV/UgiCI84z
   ik2Jk+vsL3O2iHVp/RI+71c28o0C/wxrzq/olb4InNS/RdOdh5ZZ9iclU
   jqoR86IC8vv8pYJLbDXgo6BUW4oYPck3Tc0WnzVcVWLPma8R9Y9lV9lZ8
   hJxPvzaCvO0Q45OX2OpeQxJY6yhr6/RF1mcw45F4blkKrJQjCqoakwLw6
   g==;
X-CSE-ConnectionGUID: het93BtbStGu1Y7OHRBPWA==
X-CSE-MsgGUID: iN1F6GdpQQ+Ampq4GYwsmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="101191888"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="101191888"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 07:17:29 -0700
X-CSE-ConnectionGUID: Zv/vTEkmRmyqSrufnhnvnQ==
X-CSE-MsgGUID: uZOhigjaQX+WN3XyPS+hIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="290700193"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 07:17:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 07:17:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 07:17:29 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 07:17:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZ0pTUu3svYy38ilLbAVCWfS8EZVQwgObfw8YjbzbFXxoh0ryV9N9nCjvLcmCAIjYGu51eFFGQwC9O3TGyt0lvGapNdSw8RSNV8eByp3W8waRJ6pcySPyLVjNKk4c6gJJV89mQyFpMdDsgOVTPfwbN6rQpziiaXYL7o7D5ehUHhNr04FOYhqut2f+pj3DNBBFSPopJH49qZ7XlhlBlQfavXANzadP7bWqAe/EVGTuZyXkn6yP1uPaES7iRAH6YBivyMEBtgs9SYgr/zvuZVPRHSnr9S85YogtROEFjqd9bcoQjhPGxMAyGov6R7irULFlZ5gDDCqHfFvIlGjDlQUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VK6dNLfWsd4ka9Jdml9K5f2IFFzEMacXZGdMZzB6nYA=;
 b=ZbFv0d19/7KoKpCWf/FfFlWtVTDpn1+Be2SKCz1GXT2KxnaJTzrsDX3TdOZ2em06N+LXFY97pbPhEiZQoaCQcQIlFhrDM8TvBihtDIBUqYpTTHxxraEGLVUpYaU/eY55Ilu7Aupvi7l8iXabndkHkHPMRqYcUq20EbFiSu38x+2futhyocPKkDDwqnpkVJnwm/Xt43OKRzJl3flJryf52jcpi5Hkl0v+EKY3HyLJ3LjNdiHfP1v5DD67WueO5b92Qse9l5fDpH+yvuj81nNC3ndnUkHNQtjtNZ+e95MCdgkHfYPhcu5snCki/EpqAY8gZmAadCAFZs3ML75ootcWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 BY1PR11MB8054.namprd11.prod.outlook.com (2603:10b6:a03:52f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 14:17:24 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 14:17:24 +0000
Date: Wed, 1 Jul 2026 16:17:13 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
CC: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
	<sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] octeon_ep_vf: fix skb frags overflow in the RX
 path
Message-ID: <akUhaRbe6UjFArFS@boxer>
References: <20260701112825.1653044-1-maoyixie.tju@gmail.com>
 <20260701112825.1653044-3-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260701112825.1653044-3-maoyixie.tju@gmail.com>
X-ClientProxiedBy: WA1P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::20) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|BY1PR11MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 4057f9b6-dc71-458e-3c62-08ded77b78e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: v7RSsx79z6Yk9F7dSuGSitHMwxhFiDITqux3otIeO4wjh07ekBtozUIWDJyr4xrQOH89orzwb95DWqS5ax8mqOw6hn9Z2pyhMbt5bWlG83G3W7G+VN1F6CTV7VGJPn3buDS6PD/9F+vw2B0u2ewC5VaDqWah31peNuSiOC0lWdDLgPHpFLYZK8yMSBy2RL6mKyTJZuDRhuvZOdqB+hdUO4SEfk+qddZRT2oDa7YYfd0lazRZf71a5fbJvMUZmH4c7EK0J9T0FEIUBGr9Qqi0cgMdIwcjKiKjWQTlEBvuZRkFq2+SFtCK7rgEbyt35cD2iIqpPo2oHA56OkinLEe1iREnDFr/Uw1v5655o4YWlwE/Id0qiizcd0nPT7miu6GTOebJ6bG+0153lmLa0wfuPGEJD2+UVELPykT0f5Pd2AakM3vTq6MVtH5Xj9O//hmh/CHS7U3SFrGQAxeZR+mfCGOvr7tS33KsXovVhB902oUJrtLuxSMbZQjEvl84i7HOZY3SCf1DnnyIZ804qrIOxBtXZtkxV7sdbBDRpMlj8iv4XCxIrAHtY2qnql2Iie+TBOREOwASMfy5emLejPNWm1rKhlHSID3VIYOXnMdP235TSHa4/0T3r2MRVdxV30Pkh3sX0/FjAdXKh+w+ACgxCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oLZ48kIH785JEZwozWnxXUp1+yLv2P0nV0AwoERG5Ebe3YgXSWsNe7VsdMR5?=
 =?us-ascii?Q?8IdzLI/MeVtJsvnEZIfaszApK+hIlrQU7ZcO3d23jyHNJR6a7JK6QlE51Oys?=
 =?us-ascii?Q?6EucIqoNGe+zcNgAXCAOxsh2347Is0Umirp9I9noQQFnZ3zyIe3QzhS6zh9O?=
 =?us-ascii?Q?cufSCqmUU8kojnAs98fXAbUKTRhWf5m62Z2DXyCBqHLv6tze+HmKIn5higXR?=
 =?us-ascii?Q?Gk3+6pIuWggfDKR2+7wWrDCCo8ZT3+YECQfJ9eMzu53/AuljUzvrmr6asYvN?=
 =?us-ascii?Q?vdmBTuda1ctyfzTHtvQ2ILRIv/3OO4wHV/XV/s3x+E2K83OBO69zfy5Rybw7?=
 =?us-ascii?Q?+mgRdPhSrJxl7vUBRkFOhJZzCmb1yR2/9ByApMQ0Py/DF7PV+nhqvEmnz53e?=
 =?us-ascii?Q?cytT3v+T/33+uljU/YURUd6hBACw+qewKW1r5miesPhkcPiGlmcDhvvl2vM0?=
 =?us-ascii?Q?FKEWxSCi5N+sTRatZeTdqVsqs/ZL6Q9ZPypPGDn8Nle+8rv85nmi6X/f8Yfh?=
 =?us-ascii?Q?uAzZcJ0cSZo55TMl1s2TXD7NOVtYFoVpXiCJwRvMLCvxR8wnDl5HYeVxLWQY?=
 =?us-ascii?Q?k87qpGJbVyYbRH8Oa7ekodKuQypoii1Xal3pQa4rNI7iBnqvMvWGWl43MTEa?=
 =?us-ascii?Q?bWSiiIYkKkzNxdmJBIqEPMh4/BxR/6khUV3LCD5jqgW5A4cMJQw0ugL5VTrs?=
 =?us-ascii?Q?Z+9nRp0eKeO4K2onwZSkztkOWBMaqr9hbDN4YNhe1rU8DLlTyFBqpUYWB9jy?=
 =?us-ascii?Q?UDtaklhETuFlDVoyF1fQL0wz1ecoMGRTIcxwXvF9rUaqFyDafIzTJ5OuZgUO?=
 =?us-ascii?Q?DhO3O2HZw94VCNPKp+tjXikDOOXmL7fIihN29N8J8F6REYwq3wm5ORhFVoXp?=
 =?us-ascii?Q?L6536r8m+GGnkJRtD8D+1XGFAaF+qQ17VO0u87Fg8uMfEucxGIEHo9M1eKmk?=
 =?us-ascii?Q?zckC+BCsh43aHc8MTY7nhPo+S3NlCSQQc6OLS/gN07fqA5l0TUhhmlyYfqfl?=
 =?us-ascii?Q?s63/lI7VAO4Xh4dzGz98rn4Zp+ncyNF+NGrnw1Zk5dX+4Bt30Pv6xrcsX5Zn?=
 =?us-ascii?Q?DGRS5k0/HroWwjBACBwRqbrFF43VaPyZ+S2246lh9Xr9oc7sxWHakGHxILdj?=
 =?us-ascii?Q?XbzWLN08KAV8X2eYlVyVP4xPJA1ad+YkvYzUctbmnTBZsqBxdaYpSpTw6ZR0?=
 =?us-ascii?Q?YDn1XQXGsLxQMq4EpJNL0z+XfOs0lSfvcp+7YWt6q+VDFx9yUYJi7657O/sT?=
 =?us-ascii?Q?ipBG+HYFyqqJRef9dRtNxuB1GMDbSlcoWz4efOvm8QZHeHsuK7ZuPK93FFQc?=
 =?us-ascii?Q?AE0vipWb1IrJjSc6/0drYm16uCDqa3USqbeMtXc1JD3W3BQsR3g07IVAhaBf?=
 =?us-ascii?Q?yD439rXDbWQk2nBL0HiDeMdQ3C1D++b40l/Z1yIcWbU5fEyIBAdFyGa+454I?=
 =?us-ascii?Q?7V2O4GC9d4Xw491rIeLmW+YYK07RKxwpP5ZKoZt5oD+l02y9Ej605HkV01wN?=
 =?us-ascii?Q?gXhOYubNLmGfO+5tbvl5To8RFbjJD4f2RxHjQJwtAsrdLXd0UVQYA9IuXPpi?=
 =?us-ascii?Q?kYU+CJc1IjuJdqpg6PkxxPg8ExogUfGByp4zAJ/uJgL0tyck6m4XZjtnyjeB?=
 =?us-ascii?Q?J6ZqzEkkwSRhbgmr/8KESW5DJZqbF+D3XfLPyw9uJ8QxNgYkrQY5J8Ldhtl+?=
 =?us-ascii?Q?VUxOWGQMzpGt3Njm/m9qOhQZ6KnWBEUs1Uow2SYOI7IlITKcTz4ob8v46Ixr?=
 =?us-ascii?Q?sdSDiK25fAR889i7CzvCI4TsSspnVHY=3D?=
X-Exchange-RoutingPolicyChecked: JCw45F4WaTHBr1dXNB23C8mM0SgkKl8uUHOZH1gkeODXwr5xLO+Sr2ke7CrRu9Z1Amx4TWseqvkait1yM3IIJ59eJlSA6hfhApUutdi8dtMpAbMMUnD1mPWdipvYb3zVu8Rkjjm/Vb4rVq2K5rZrkISBomifG/tKtbS4mviDmz+EndVwRJxecvjTZH4ycxKFjuN3bD+sgcHCxgFTPAmA/KjtuKPyk5194pbxJ4p9I+hBX8D7LPmurub1cI86zhmWjqM5vd9uuGpf0DJjg7gQWrCmn2RkP2HloiCauQqz80HuCVc+hm7YXxNKIDP+NBH41SEDZVabf8/01PCUJ7OiuQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4057f9b6-dc71-458e-3c62-08ded77b78e3
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 14:17:24.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OQrgU+8aqHEounQRXt+NbNTb2vJifpCtxwPkIiR9yprTRWhLqMxhOlN0/hxi7TcV3Lf+I3p3feNZfBMZ4yfCOFNBIEdgCeL8vvYO+PNdI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8054
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303695-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:vburru@marvell.com,m:sedara@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,boxer:mid,vger.kernel.org:from_smtp,ntu.edu.sg:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11DCD6EEB1F

On Wed, Jul 01, 2026 at 07:28:25PM +0800, Maoyi Xie wrote:
> __octep_vf_oq_process_rx() has the same unbounded fragment loop as the PF
> driver. buff_info->len comes from the device response header, and one
> fragment is added per buffer_size chunk with no check against
> MAX_SKB_FRAGS. A long packet yields about 18 fragments, one past the
> default MAX_SKB_FRAGS of 17, so skb_add_rx_frag() writes past
> shinfo->frags[].
> 
> The driver now drops a packet that would need more fragments than the skb
> can hold. It drains the descriptors the same way the build_skb failure
> path does.
> 
> Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  .../ethernet/marvell/octeon_ep_vf/octep_vf_rx.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> index d982474082423..2e666df26b4c3 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> @@ -463,6 +463,23 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
>  
>  			shinfo = skb_shinfo(skb);
>  			data_len = buff_info->len - oq->max_single_buffer_size;
> +			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
> +				dev_kfree_skb_any(skb);
> +				while (data_len) {
> +					dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
> +						       PAGE_SIZE, DMA_FROM_DEVICE);
> +					buff_info = (struct octep_vf_rx_buffer *)
> +						    &oq->buff_info[read_idx];
> +					buff_info->page = NULL;
> +					if (data_len < oq->buffer_size)
> +						data_len = 0;
> +					else
> +						data_len -= oq->buffer_size;
> +					desc_used++;
> +					read_idx = octep_vf_oq_next_idx(oq, read_idx);
> +				}
> +				continue;
> +			}

same suggestion/question here pluse there seems to be a bunch of repeated
code between linear and non-linear skb processing paths...

>  			while (data_len) {
>  				dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
>  					       PAGE_SIZE, DMA_FROM_DEVICE);
> -- 
> 2.34.1
> 
> 

