Return-Path: <netdev+bounces-267464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMSADjUYtGlkgwAAu9opvQ
	(envelope-from <netdev+bounces-267464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:59:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6B62845F0
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 049E23046F0D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8595F38CFF5;
	Fri, 13 Mar 2026 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgMTamIC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0330ACF0
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409644; cv=fail; b=f27UMRleWWksZxfA4bysthXgQ7auK0jfdsajkyzsAianlEJO4qyES6RohhyU7BL6rp+3jD/FPLCMv5yPQaKOQG974uXRc5U6nEli+y9ZFpcMF51fFau5PEpqtWzovsyScujG3RhqxPCWLj9StzT6vpGgvI4gKJ48YrIcVPTmvFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409644; c=relaxed/simple;
	bh=RI8vEJdX/646F0aBTTWmopCm/5Ktdvvevj+l4JOKLxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oMoWeHu6KFcPQnHq/oaJI9TQ31fFZ+kiRH9cc8EQmPtNR5jw10yEfJ9AALd5O6M55d35CTKLWG9nstqhGL5MJHX2Jj9ABuOwi3MnQxBhlKPjp1dL8VoxUuXMsJe9CHLMJf6TIiY8GxZmRWIjZNZvm3df/AKS+i88uto1+1sEgbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgMTamIC; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773409643; x=1804945643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RI8vEJdX/646F0aBTTWmopCm/5Ktdvvevj+l4JOKLxk=;
  b=dgMTamIClX4FZjonSp3GXWI6qMk7+pvl1ALdQS0MqU50MuBJra6TikL5
   8fV33/sJTXAJ1uBphAxFnHgE4nxzGWWshUFN52HewoUuusvRdWP9pKgtE
   GoPZb/2km4KZtHuTI6iI1dckk4x8BVTvaRjAjuAYkcQ3DI6ju7/kqlW1V
   O1Fh+Z2wwIdw4p/CqpJiVRC4w8QrLZ7c7us0ldUYPd7bO6bcMRJffgqD1
   0JJs1fr0v3MyM6dEmD+mVF8BaglVIRHtk97pWnAanJU/32DaRB4NbOIXO
   7Tx0bc1nzn+1/TLJVvbZ0x2fM9UHBxSZBWz7bAwKYYQQBZyNpY1LTgqE5
   g==;
X-CSE-ConnectionGUID: g7ELiTDLQeGKAXeEDDPLgA==
X-CSE-MsgGUID: wML9JrcFSd+wFLdmflhYrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74629675"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74629675"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 06:47:22 -0700
X-CSE-ConnectionGUID: ZPIpdo94RJOEJO3xY6RiZg==
X-CSE-MsgGUID: nLugAu/kQoWS+9OC1BPCvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225621322"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 06:47:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:47:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 06:47:20 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+uaMBIco7XsTGOdc9J2rJE7PJRtRBps+0uneBFaRulaX0Zd3cTTVxrQ0IAFlRwqzJl6qnhal+s1PXvUoy/NxAdzTHNaXGisFHtv5y4EbIOvWLRLKeLGVjeccMUJw+qxeLwUL8XdqN+2oX+hnIj9WY56wtZjBjfUS/eJUdMTdgSAyFZ2FNwvPc/Br7NFa2+pB0S8eUeerRnUX7ouo9mH+toH7ekFhx/g8EQeH9u7A+ZQCkCP5ttjmY/5kUvjTLPqzp7c41PEiM9rKVrMp7id86ThxpJf2FJteUN99bNpGLk3hKHLrZHzpp6R7AbZ0aNkqSI4UUom2GNxNBv/AqqOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsw9eW0Cui14qsuCUKFdvaMkYdANPRlyVtEWO/uSSl8=;
 b=dH75S1pRX5uTthuwyNHvnS0j4Et4EOu/lvVKATqnFUv/iXnmm9uydDs3sPliewr5rpcjw6SmLfFhV3py8ahOr+XkzNqzZgSa6hXI+3EkpJEMJIncK4IhMFslNhqCpVJszJ+v6EqZn/jOAOPbEMRyQh7Jf94+ORhBuhHjyN9bfutudsf9EpeR7HgrrVOwf/mBSU+1NHg5zqvWZzbdEXZ9veO1Y724uBK5MqmqCD+lV1fJVjcv+TbsWftzdlmYWX4RGeWYkOdSTr2ijMhedcL+hXodqACJ16WBCya0bz+F6Qb4B4hfouxN7fVPdgPuI6nXco6t2igcR8iPaLKzLA8u7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by SA1PR11MB7132.namprd11.prod.outlook.com (2603:10b6:806:29e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 13:47:17 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305%5]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 13:47:17 +0000
From: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [PATCH iwl-next] i40e: PTP: set supported flags in ptp_clock_info
Thread-Topic: [PATCH iwl-next] i40e: PTP: set supported flags in
 ptp_clock_info
Thread-Index: AQHcr86Xy2U0MgoCgUGFZQFkE41emrWoFskAgAExmsCAAzRWgIAAAwjA
Date: Fri, 13 Mar 2026 13:47:17 +0000
Message-ID: <PH0PR11MB490443FB49C3F762297A992E9445A@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20260309141220.343224-1-przemyslaw.korba@intel.com>
 <20260310182458.GQ461701@kernel.org>
 <PH0PR11MB49044CA89B5D8780D477561D9447A@PH0PR11MB4904.namprd11.prod.outlook.com>
 <20260313133451.GZ461701@kernel.org>
In-Reply-To: <20260313133451.GZ461701@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|SA1PR11MB7132:EE_
x-ms-office365-filtering-correlation-id: b1318115-4b59-44b9-1269-08de81070a69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 78198fDxYJ8n9QHUMWeWPAgYtDiX3lwXZ1zd+uQ4NOnRiZJAVa6kRS6D82rzIV5TcdJEgJmh3z8n88UFt91h+KTWmDZshoKOBlTAHFfdjTQ2crrwj3bK9QZlD6eOkap4xDtQIAsnsQeQaRkGmWe3sXnO6viRD/P3QAODsU1aDRiHcX47syjxJzruWEXnaARh8NJIFhBcV7QwgtWY+Ap+MLdv78UC8YJPJLp4JNLTXasD+7GUCtc2qY9krAvoj9Hc3Aowbz8hvBMTfSqN5xlwqKUyTrGEmfAnyUMLgubbQeoW2zBRG8Cm/JuiQ+kyF0dVVxnb6Url5cnBMi9ZJAUfBt7UyeTEXw9WQJOpdpMwPgNZEZAH7l+HGT/4MkZZePd0jMfeDnyXf7uSGHdGFzRme7f2oNgjNtYXRgDLRXoQ2zIqstX3nhfStJKLwYXmaM8RXHd/LVRUa/nARkD9n8uEU6XzuQ34sKD5Y8raEAgh1qnPFto4MeSiWtZXkxIPMPexBY4iLZ0VJsMxUTV7xx4puP78zZmjRO3eLt2VQf/BgIQq4LBn1pABLshi14FP+FLMrXYS4wqWhGvdH+uJ3PDXnRqxDe06t4TvvlcUgjZtLLJlKhuchmrZaprm3fujDIzDuzrdKRhldE3Vu7XGmPEQ4AYjQKk2wwY+QiE4KfQrmZysjBkZMjXcEEIr9/PLia1J+6Ru/d71wZTyEQuox/Sn+S7aoeg+djREVnGubvZXBRqYbMPvSeKB16D7CCb0bLaM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yCjzMgGVe8p2EIv0hANlt6UPCGf3o9wlLaZwBJaTi3DSix0zLL+zNWdeeh6K?=
 =?us-ascii?Q?LkNwHqUg7ffkvsNdeWYJNcU7wI/85t4q8+K70gnnLD2AwweQblw3ve4mmhlf?=
 =?us-ascii?Q?jjGXk3KSUCn3p2ILlkk7X41BwaPM0kYGRGdvnngffEg4s6ZR+OXB2HQdue4K?=
 =?us-ascii?Q?vCDpl0f4guAibAlp6P7CUZOat04yXMZ+llEaOGvkDOK4BfaiuFqKIUwyaU2Y?=
 =?us-ascii?Q?ijxAi7YKVBu/bVMt0JMjKvcSINFrv8SrD6RqHYrPdqDJ60gAReL0ejvE+WcD?=
 =?us-ascii?Q?YwMd7R02RnXlO7YsKz8q9AcKZnsjIXrF5vk5jiHNUlG49MA3PQ6HLUPBx3rf?=
 =?us-ascii?Q?8OnOeiVouxhScAeOayL6osVnLtcjaSG1s88sBEse6kMxS9PRxvD6tY0tWVaY?=
 =?us-ascii?Q?Acs11SY1+s90uWx0dgTQG54ne6zqARYDV9IA9wQhT1is/ZsGz0xJW1BoMq03?=
 =?us-ascii?Q?77kUw5f4UIBnkF1psEfzcOI+7satU3XCMtKhB0XIVAdpxzDUJps2/sBVHjm5?=
 =?us-ascii?Q?r1NZQ7LZNjSZZmc3XEHAtqXWrH5yYD5EZkirPlY5CqaZAmE1FcVZMojaPLkI?=
 =?us-ascii?Q?4aVicVKXt4Ik3JfNhncFvdAsW6WJWFPCBPd5aJ3yxyLaoIPHBdunAUh86ZA1?=
 =?us-ascii?Q?cbOPY6UIRGkjPHV+CFAz0nmEKzQJ9zKx46OGiKAiBppX5wL/kacsn8cW9iTE?=
 =?us-ascii?Q?cgZdmxd2gp5jbbg95G7qaqqFeJheSQfmJZjBC/20ilMF9bETiS6KkVOpfmkp?=
 =?us-ascii?Q?IdY2qeTnkLBrxoCrSRnp1ooz8ZFTaHpqG4XVSNyNz+sC30lA8tOFb7PdPK+D?=
 =?us-ascii?Q?r9GMQ76RcAbTTKlGBwjT9eke5NyNrFsmV/IfZulZvWPWYj+BR4VOBcNzsFB0?=
 =?us-ascii?Q?su7XTf9scD2hndq8l7PFQ0g+iRdpmXU4w42wIgeDKtOqXaPSZ681ubpLRSkW?=
 =?us-ascii?Q?dsmzGHOLn/sH6NGSjPxMdEioviWhHgx64EeKdE3ziv5B4J3Q9M/PpRc/Wsem?=
 =?us-ascii?Q?GizLW5316Kp9SEIZ8y8GKi6VKIbrl4o8n4NUwMZEeE/geh2V4t9c2UK8I5Ah?=
 =?us-ascii?Q?nYzPURd2crqY+Rhu9zSOEYfXa6oPJgl55iQKtNORZGmnf6ZGH51pN8E3V4hh?=
 =?us-ascii?Q?8ghPIU6+g7SlFkRpBYidW3tFUfbeCy34t+XjVuGdzP6HdL1MPPe4VRC5v9xc?=
 =?us-ascii?Q?TGQ/HxNU8qTVuIB0xj32utNZc+O7G8FBFLd6Z9mCl2ATQqRXBLMOJBmoi4cg?=
 =?us-ascii?Q?mcIDKfPcxQnCAAAM6yc6PUqsERRGoSG5O+4MHwk59jitCyXbk/JIu2URvIM5?=
 =?us-ascii?Q?a+WsRuJTfbhjfBtJOnNp/u1PcywhkeSQFWrTqTxoF5ID2vciQRcixbEjkFH9?=
 =?us-ascii?Q?9DUL+I8udUXZQk2npW8p/4ne7qibeSjzNl4C/wod/jN3GVWBUaAigLJB3JmN?=
 =?us-ascii?Q?MqN6Pe0XQs6UzF8qlpJAepP2R18iSqySiZ+9wCDnkSvsTxLYQjjKpHiJk4pR?=
 =?us-ascii?Q?XEVwXQ4q/GUVFQdnFfjGuWYysFIEn3NpO8SzHCGerxG+yH/KpWUCakspfamx?=
 =?us-ascii?Q?JAJ4RDiKeIf7TCiXZ9CPVRvDwGLHO5eCMvRi+KngVH5ujC7U661m0ch9kTwq?=
 =?us-ascii?Q?ZgRusOSyhVJA64BgFZiqbCvPhfJD2Mwwcz3WOovxmbgZBqn3mh+b9FiL8m9N?=
 =?us-ascii?Q?HyqRmuMoFtg1GvwzCh97MdFHQqDlG4Gxsh307nx00RFVZQCVEcwTFRevGFIi?=
 =?us-ascii?Q?wkmvTwNwzQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y4yPzuRSKaoBAu6egVafunK1ftC3R5AHoMQ3qdQ/Ix4cpIZdVsf88wIN2Ouwdoupp7hdyuFGGhrRmAsqSh70gNWwTSDz1RVudUH4eT+yNHat9K5rupc/ERdFFexa8dzQvfP48QSYCzl8UixxA9hfHLa797YImx/KU9ymNpkNwTtNW5JT34OIRldutQQx/oHQ5WDbawxVliSDmR48rMmvt1qrinePt9s/+CgClVybSdTcFVHHfhJPfIz64EiisP02EvtT3ml+v7OmiQgxg6sjLZ4E04DNhhTPDOXdGwdCt0CC/PJvSFPUr+AFoSF0ch7oP6WJ2Itqxx3UMwcunMXbiQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1318115-4b59-44b9-1269-08de81070a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 13:47:17.2126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HgmBwb6aQFWiMOH14TUK2CpcyqsS00lciPTKLWmgJ/pyWSGjmXdzp7Qe7KbX16an8ceKrHmEvXkIONQuJlY8RXDdObmBYmNjwMe41ctXOrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7132
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267464-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,osuosl.org:email,PH0PR11MB4904.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BB6B62845F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, March 13, 2026 2:35 PM
> To: Korba, Przemyslaw <przemyslaw.korba@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen, Ant=
hony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com=
>
> Subject: Re: [PATCH iwl-next] i40e: PTP: set supported flags in ptp_clock=
_info
>=20
> On Wed, Mar 11, 2026 at 12:42:10PM +0000, Korba, Przemyslaw wrote:
> > > -----Original Message-----
> > > From: Simon Horman <horms@kernel.org>
> > > Sent: Tuesday, March 10, 2026 7:25 PM
> > > To: Korba, Przemyslaw <przemyslaw.korba@intel.com>
> > > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen,=
 Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > > <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel=
.com>
> > > Subject: Re: [PATCH iwl-next] i40e: PTP: set supported flags in ptp_c=
lock_info
> > >
> > > + Jacob
> > >
> > > On Mon, Mar 09, 2026 at 03:11:51PM +0100, Przemyslaw Korba wrote:
> > > > Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
> > > > .supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d=
 ("net:
> > > > ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel c=
ore
> > > > now requires that the driver set the .supported_perout_flags and
> > > > .supported_extts_flags fields in PTP clock info. Otherwise, the
> > > > additional flags will be rejected by the kernel automatically.
> > > >
> > > > i40e does not support perout flags, so reject any request with pero=
ut
> > > > flags.
> > > >
> > > > Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> > > > ---
> > > >  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 12 +++++++++++-
> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > > > b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > > > index 7bcea7d9720f..8d7958692235 100644
> > > > --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > > > +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > > > @@ -601,10 +601,18 @@ static int i40e_ptp_feature_enable(struct ptp=
_clock_info *ptp,
> > > >  	/* TODO: Implement flags handling for EXTTS and PEROUT */
> > > >  	switch (rq->type) {
> > > >  	case PTP_CLK_REQ_EXTTS:
> > > > +		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
> > > > +					PTP_RISING_EDGE |
> > > > +					PTP_FALLING_EDGE |
> > > > +					PTP_STRICT_FLAGS))
> > > > +			return -EOPNOTSUPP;
> > > > +
> > > >  		func =3D PTP_PF_EXTTS;
> > > >  		chan =3D rq->extts.index;
> > > >  		break;
> > > >  	case PTP_CLK_REQ_PEROUT:
> > > > +		if (rq->perout.flags)
> > > > +			return -EOPNOTSUPP;
> > > >  		func =3D PTP_PF_PEROUT;
> > > >  		chan =3D rq->perout.index;
> > > >  		break;
> > >
> > > I am a little confused.
> > >
> > > My understanding of the cited patches is that they add checking of fl=
ags to the code. So code like the above isn't needed in drivers.
> >
> > Hi Simon, thank you very much for the review. My understanding is that =
the driver needs to set the supported flags field, otherwise requests
> won't go through kernel. The test I've been doing confirm my theory. Here=
's also example patch, that adds supported flags to drivers:
> https://lore.kernel.org/intel-wired-lan/20250414-jk-supported-perout-flag=
s-v2-1-f6b17d15475c@intel.com/
>=20
> Sorry for the slow response.
>=20
> My understanding is that the hunk above is not required.
> But the hunk below is.
>=20

Well, you are very correct. Thank you so much for thorough review and let m=
e send a new version!

> >
> > > > @@ -1340,7 +1348,9 @@ static int i40e_init_pin_config(struct i40e_p=
f *pf)
> > > >  	pf->ptp_caps.n_ext_ts =3D 2;
> > > >  	pf->ptp_caps.pps =3D 1;
> > > >  	pf->ptp_caps.n_per_out =3D 2;
> > > > -
> > > > +	pf->ptp_caps.supported_extts_flags =3D PTP_RISING_EDGE |
> > > > +					     PTP_FALLING_EDGE |
> > > > +					     PTP_STRICT_FLAGS;
> > > >  	pf->ptp_caps.pin_config =3D kzalloc_objs(*pf->ptp_caps.pin_config=
,
> > > >  					       pf->ptp_caps.n_pins);
> > > >  	if (!pf->ptp_caps.pin_config)
> > > >
> > > > base-commit: d5fbc991435eac7a1ead7cd2ddb5a743528718bb
> > > > --
> > > > 2.43.0
> > > >

