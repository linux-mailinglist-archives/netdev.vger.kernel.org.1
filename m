Return-Path: <netdev+bounces-110022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC12B92AB24
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63A01C2166E
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1820514EC62;
	Mon,  8 Jul 2024 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHpXt9qq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353EB14F9C6
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473942; cv=fail; b=hyKyrZHCVuJ0mlmRrJOVxlgVSYcqav0AOuwJ7/wtYqKZA65IVAF40mIbisdDltx7YTzZ2ptkxpaS+WI48NUcAb9POeEPItI12xGOHyeM91hpn1LPJer0sI78VgRYsRo+/66bLccSl6q+Tl8hRyDxYPawFXmIgkakQZ/2v9sUaNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473942; c=relaxed/simple;
	bh=vgmSZs2a0SyFG35wrNt6Dfnj+COoVA78c4Xq5n5ULXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kck+yU1xky6unUGNeLlDtUhv3a3psAniZekmgMUmJ5LyVGRhNNUPCKDfiMVlklQixsWb6iK50PN1s8ORhQ7YoGtv/G3hmSkC4YQFbTFYqY51xJfwagU01XR/+B/fc1IghRZBRLJseI6a3bIf1sE5wiDPVpMAXJ7oJaO6vKNf3GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHpXt9qq; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720473941; x=1752009941;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vgmSZs2a0SyFG35wrNt6Dfnj+COoVA78c4Xq5n5ULXY=;
  b=OHpXt9qq9NbcYVZxzKzoopJo0m4F5KYQrHxbtejms760xcVWD7nIz8jm
   USgdQO8YSamjJgKdSbwej6ZVUHOfxPDHclylKoSOEjgGACs1jSX1una5+
   mYfhvP+WcY9UfdjjZhfKx7o+zcqs6kj3oDgZxsGw1HHlQLVnoMLfrzcbb
   pjKZP+HGcoEUoyFP0uxYg3N2aDr0WI4eZlBtYKYXh90me0OH9DQT+mPbU
   +DtKRFbzHx4n1qxEQ4obwwpfUIO7NKXynLtX9sqQWoDZbb2tUECmFnLQ7
   osXv+pXM1fW0cNbxL6VvGqS/q/eXQgrQ9Mh0ma+43BURTo/C/Rcnpasuf
   g==;
X-CSE-ConnectionGUID: ISckttXJQe+UhPBO0ReA1A==
X-CSE-MsgGUID: emMCk4rZSe6Pimy7YOjfzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="40210441"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="40210441"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 14:25:40 -0700
X-CSE-ConnectionGUID: Mryh3f4SSiyZr+pweqtPjA==
X-CSE-MsgGUID: A1FavluARBauxI4I88CTZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="78367319"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 14:25:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 14:25:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 14:25:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 14:25:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 14:25:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1B7SzCXMb1dd0afkuJQ850DEdCLpIv0TzBEZqUa3YTtyRRYBIYroPgb6TrJDG8NfZoTMPQ2jm5h7BWdRo7rFBOSqDe9mocLpRZO609XRpvVaDLTvbFMtzdp6KDHiCXxKBekNMR5yVaTYgzgGcLRRfIA+BGbKctK2wTj2flzvwxfd6C5qCjb4cIFaPCPP+1zxQSB2QNaktYEhD/lPJT6eOVd1l9L5pQozkOHzPSzE2AW01/Uo4HennxH5J6Nqz66Af9nD3UutYntwD/+7HFwiUA1CTWRZd7Eb2uJHvzWrEJDn+/5LUv2OrySp2m80olD5+dIV2J10+beB2aCFGJVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QWrxXf2AFedzsURtjsSz70x9/X3/0CXms3lYIHPY1s=;
 b=JkleMdF15zbDDeybsv0oC2EIl8JnkVnyxOYaaI/tt+l6hKqDWVJQTWquDP97JxhJllHuGkMDoaMPpWV7sNfCyUqFrX6Z3XMIIafNe28QjG8HqtJr6w7p5ouBYyC5QXls+OLQCi8wqZ2KNG9dGMRI0jyYyJ8Z6BrK6TG+Fk3CpjesCZqXZnSHgeyZhduqvit0PFxtjiDx8fWtT8j/8tFnvJK7FNjW1Z1uMaMfQd5gCpRPsR5agQD+iYTT+R+OblacRC7TDc2h9Lsd6VOjLrR6JcCiYyZbnaFSu73BYidh6XeyjnJJvoYhE8kjM1m6MeUaL+RNpkRnczYWeBbfbe/m1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6095.namprd11.prod.outlook.com (2603:10b6:8:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 21:25:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 21:25:35 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>, "Nelson, Shannon"
	<shannon.nelson@amd.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, Simon Horman <horms@kernel.org>,
	"Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
Subject: RE: [PATCH net 2/4] ice: Don't process extts if PTP is disabled
Thread-Topic: [PATCH net 2/4] ice: Don't process extts if PTP is disabled
Thread-Index: AQHaxyGQiPXhLLMyBUap1HQ9HzP987HYxBEAgAKrJQCAEf0lMA==
Date: Mon, 8 Jul 2024 21:25:35 +0000
Message-ID: <CO1PR11MB5089D31ACBC078C12A6D18E3D6DA2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240625170248.199162-1-anthony.l.nguyen@intel.com>
 <20240625170248.199162-3-anthony.l.nguyen@intel.com>
 <b120a258-87b8-42c3-9b5e-ef604f707d0c@amd.com>
 <MW4PR11MB58008AC6DBE08115F01DB9A886D72@MW4PR11MB5800.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB58008AC6DBE08115F01DB9A886D72@MW4PR11MB5800.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DM4PR11MB6095:EE_
x-ms-office365-filtering-correlation-id: 83707ad8-dbc8-43c2-5e37-08dc9f94818f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?6tW7T91tkgPST2dHPWsQVbikof0C4O6QW9nu4aCP4Jqt6XAga9LeTDgUFH?=
 =?iso-8859-1?Q?9fPcXTHLVThugJsn3xJPueorR2z5PRQvKpfIiLtxgFYVDCb20gMokXixLD?=
 =?iso-8859-1?Q?IY0CVQ/NMiOmEqCOgBvWx+Lkqz9dqUY3MI2CtLSFff6a0rdQ3lZ7Do/4wg?=
 =?iso-8859-1?Q?YQ0KbBYEJaAuxPS6neyeEv8NWcIIvPLL60/Cqi4mmOTcnCq6DFcmCedT++?=
 =?iso-8859-1?Q?HMHMQCrKlZ5W9ggRlRgFfdtjZZWB8OuLSvYTRO82X1GSt/7xMeZmUrQ8fO?=
 =?iso-8859-1?Q?SbY8eOrC/bwaMakC+dYHS+rC9YazWHNWajjeJjm+AiHmQ5Hjo1rTWrtwbt?=
 =?iso-8859-1?Q?DYnMf6Z+tZD2DCFdcV4mOhOhapa2iX329FiWizN8jUCGkdMO2Gs0FK8SrK?=
 =?iso-8859-1?Q?QisfW4veztbZVJFDgJ4KCHFw6f4fVzE+d5naMQpAOAwX3TXzybNRrrZoEj?=
 =?iso-8859-1?Q?Rqmb7Bwpvyrlc9AjWrk5RSpOjI5pqeLOrfBbvoznoQAPHBYz3DYcXBSihc?=
 =?iso-8859-1?Q?0UjjgCjPhzPUSJKxor5R7gC1ARWZQm7PA9gLyS8Z6Cz/zAqAPzitZMpIYB?=
 =?iso-8859-1?Q?KbhBpnOV51/FOSoP3p4kvqF0JroKiAQYM+Vbfb7z9RvtSIYJPChHX4WN8e?=
 =?iso-8859-1?Q?dBo9FtUxQpH3OH8BCPIhIbgJCHUeF3EOlpbtMkEppYtkbNZB4suQ6UW+OV?=
 =?iso-8859-1?Q?KmjBM3d6Xnz3kcGOBrLU6bqPtg7kkp6t8d1Gh6rFNgZBPvRkGtdRCwvZeE?=
 =?iso-8859-1?Q?QVrHkvyC5fO8kYXpyIO7gVbZnI4evGlMf974nQqEh7J/aDFSnNuidhnazA?=
 =?iso-8859-1?Q?ZNwsFj+EaQHZXuptv0nI5idn7AQHD7dOROlmhoBL5MNZ+SxarjEoNqj2Ma?=
 =?iso-8859-1?Q?n2dm+JC+3vN2ky+khzS7EWxO/8317QGeM/Ik4kIZd5KiNFXQyCQxF4rJuC?=
 =?iso-8859-1?Q?hrT0oBEm/aC+d9iaKsXudX7T7G4g2bbPZh5nql+3XU0V47ab+MA64nDBjS?=
 =?iso-8859-1?Q?M3z98Kzxtt9HMsTmDaEIgX8eKwlyyGNfJlmHlP6/Ch5UvcjE2Eteid0lPy?=
 =?iso-8859-1?Q?Nk8xtl7ByzBDwFVring1b2mM0GrDsMrXI+mvHH4oroq8oDzy0ycxGxqeme?=
 =?iso-8859-1?Q?Bu/EqdiEUmfR/nO0YDL9Wgk2pxouQpeaqRVCrKXg+UCFlTCt8yjQYy6RN+?=
 =?iso-8859-1?Q?O6P7KEekxENrIlyxYS0QiN8f6MTKVps8lpYLEoy1SLumNXV5VzS0KjPBMg?=
 =?iso-8859-1?Q?gbHZYHIHYdVI2NUvJgkxJ36DfCNbGGcIY3hl9xHFfRC/Fjy50gyWRiGCAa?=
 =?iso-8859-1?Q?MbF5GE2GKZ7ZmbDuGu+XX6/1medgulDrn6wtaxti+3NFthDEdYWu0FVa36?=
 =?iso-8859-1?Q?+MuGVWneX8Xmw8fD9Ga9onfjHbSY8wTWKVHUykQsFfk7x1GxJdhukbveg/?=
 =?iso-8859-1?Q?5Hyp5MbaXu/5bqzkb87/OJCCJZHKjsKbfq63u4TXS4Sqyg+oFEre+MT3TG?=
 =?iso-8859-1?Q?4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?43MI71PjUdq2AW8sZN37ewgZpT2wfIr/2N5P4pzHD4501p0kwAk7Z+GWV8?=
 =?iso-8859-1?Q?Tc3w8PDifhZ5qHdbP1FA1lYaYu2AHkMJ6cNpkXqSI1iuR/1/urICJe/2RM?=
 =?iso-8859-1?Q?wVOUjOz6EN9C/fP/DThPx5iw+vMnhDAsuZISXOu6Rk9B8gPWfxZq+Eo1De?=
 =?iso-8859-1?Q?ff1UJCtWZwT6zeo6ie/LcFQsGCoFtDZDDwjIyP9/r9VhK0Fy6d4u+LXmEX?=
 =?iso-8859-1?Q?WrFwoEc7pADRNyPxg44CgiPE1tAmEWQpARHAKHjJJxF/IWxmO08No1bPK2?=
 =?iso-8859-1?Q?ruXfqtBmgETzUQ+64sorX9UPYAEL5ip+GkkrtJ+2Z7wEaoP9LhPRPOeMWb?=
 =?iso-8859-1?Q?As/dKUnGCBfF5HN+OfNnz7WlBYW9EJBe3QLQwuWaq3S06rbtKM+XYhcEP+?=
 =?iso-8859-1?Q?rz8e5BmNjdDx7rE68p+i1UUnsNkOav9oJnpdoSZ4SmqF8QZ+hpXf69lE1g?=
 =?iso-8859-1?Q?cXcsdKG+hlqHbpapm8gcZ3RqpguPRk4SDP9giFSMY1+4RbB8nlOrqWRFTE?=
 =?iso-8859-1?Q?VDu60lWcOCppBhwOJ5sOwzEJgqyRQTD86Se88cMP7u+HKKPWnY3/a/tcWr?=
 =?iso-8859-1?Q?EJmZw8ytoECL2YmNk5kYef1bTcuNV9N4gzF9j+u5vRpXdZgMEaEOP1ivHS?=
 =?iso-8859-1?Q?yO83ZeOiPT4QTXmh8eX26gvBJ3wX2x8CLL+OkTyRiycdgRmS/IUvErRUFn?=
 =?iso-8859-1?Q?A6w6zbCy4jX/Ber2+QIP6FkC94RzARBOk5VMyf2NY9grJBorYBOVYaTAEO?=
 =?iso-8859-1?Q?QgSxYvuCtDCA5la5x/PcwLAz2ujXeBBFQmXSYVW8i5fmASrTKkdvdYTTGA?=
 =?iso-8859-1?Q?8F9YAl2fqOJ8GrgzhXvVkvrodzASW4GOv8QpDRID93aXIH/YlB1Y6ClYfZ?=
 =?iso-8859-1?Q?QeJAzFaZN4p0+TeBDUnv/D6ZvacVhvLpDBRQk4r9vJiSVOMyXmDa2LtElq?=
 =?iso-8859-1?Q?mKwY/0rN+NpFm4Dum1GHQwzQVpA0Pv9kiui9htZ462urlLHfACnghDAJH2?=
 =?iso-8859-1?Q?WHZJH4L4VdDmHql47XmcmyGRa7TgpQ6K8qY5AN3qdgVZKcvuePV2/DuDuy?=
 =?iso-8859-1?Q?iJc56jARN2f/2/QcMNzfX4+x7O6YA5GLY+gObhc83w6mBCzrebffYBSHip?=
 =?iso-8859-1?Q?E48ycIIJ+AC1SQ8g1tqZ9G6zLKs5WNRgwA116dZwzuiycORndHuPD+zCX5?=
 =?iso-8859-1?Q?CX8njc2+sA3QZrX5IOJkZ07sEYz8E88TII2mnJ3bHDps6fylPOcUwbMWDX?=
 =?iso-8859-1?Q?q32WDD5sLDTqoMqdNPlHj2yg8qT/FUG0PZxAZOMcOxT6JVI9W/bpdFj+Dr?=
 =?iso-8859-1?Q?+A7a/BDKyq3fDaZh7PZ9nB7YnzfYPYe8TNcto1LPg/7lb6F0MF9ovfAvNC?=
 =?iso-8859-1?Q?Mm+qFJbue+/9MFW0gODskSscT9tcPd+64rXOEg4rQ7g+lKzcYiQDhMh/gX?=
 =?iso-8859-1?Q?aGb2VaRpRagH6yJy0gCyi8F9ylGsPyojfYbnhpyyZuBefgkZ8GEQ5caMT/?=
 =?iso-8859-1?Q?jdXDk13v41BvTjhd49+VRW9F6nfxZxlSyfZjUvthKTrDctP4tV8C7AhluZ?=
 =?iso-8859-1?Q?edY502bXlkyO8yk7DK2xGzmODJulLrBQY7+paMBn8donzUhFgexliTY4Ak?=
 =?iso-8859-1?Q?9QPq9yooWz9lEr2zgO+lWx/g1To/J8gKxc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83707ad8-dbc8-43c2-5e37-08dc9f94818f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 21:25:35.6779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIE9hzQWAI5lMPi+NeTtJPCjkweCKi4/duu+b81SlU8GosIJnrPKDVuUWAKH4ZXzJmLzb/TttxqD8ZmYOW0+kkaWZPkhUb8ipKGGbIRJZhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6095
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Kolacinski, Karol <karol.kolacinski@intel.com>
> Sent: Thursday, June 27, 2024 3:43 AM
> To: Nelson, Shannon <shannon.nelson@amd.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem@davemloft.net; kuba@kernel.org;
> pabeni@redhat.com; edumazet@google.com; netdev@vger.kernel.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; richardcochran@gmail.com;=
 Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Simon Horman
> <horms@kernel.org>; Pucha, HimasekharX Reddy
> <himasekharx.reddy.pucha@intel.com>
> Subject: Re: [PATCH net 2/4] ice: Don't process extts if PTP is disabled
>=20
>  On 6/25/2024 7:57 PM, Nelson Shannon wrote:
> > > From: Jacob Keller <jacob.e.keller@intel.com>
> > >
> > > The ice_ptp_extts_event() function can race with ice_ptp_release() an=
d
> > > result in a NULL pointer dereference which leads to a kernel panic.
> > >
> > > Panic occurs because the ice_ptp_extts_event() function calls
> > > ptp_clock_event() with a NULL pointer. The ice driver has already
> > > released the PTP clock by the time the interrupt for the next externa=
l
> > > timestamp event occurs.
> > >
> > > To fix this, modify the ice_ptp_extts_event() function to check the
> > > PTP state and bail early if PTP is not ready.
> > >
> > > Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pin=
s")
> > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > > Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> (A Contingent worker at Intel)
> > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > ---
> > >=A0=A0 drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
> > >=A0=A0 1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
> b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > > index d8ff9f26010c..0500ced1adf8 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > > @@ -1559,6 +1559,10 @@ void ice_ptp_extts_event(struct ice_pf *pf)
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0 u8 chan, tmr_idx;
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 hi, lo;
> > >
> > > +=A0=A0=A0=A0=A0=A0 /* Don't process timestamp events if PTP is not r=
eady */
> > > +=A0=A0=A0=A0=A0=A0 if (pf->ptp.state !=3D ICE_PTP_READY)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> > > +
> >
> > If this is a potential race problem, is there some sort of locking that
> > assures this stays true while running through your for-loop below here?
> >
> > sln
>=20
> Currently, we have no locking around PTP state.
> The code above happens only in the top half of the interrupt and race
> can happen when ice_ptp_release() is called and the driver starts to
> release PTP structures, but hasn't stopped EXTTS yet.
>=20
> Thanks,
> Karol

My understanding is this is serialized via synchronize_irq on the miscellan=
eous IRQ vector.

Thanks,
Jake

