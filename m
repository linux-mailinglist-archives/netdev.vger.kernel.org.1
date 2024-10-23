Return-Path: <netdev+bounces-138409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32AA9AD6AE
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 23:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9027D2863F5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 21:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94D31EC01E;
	Wed, 23 Oct 2024 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzSU22eK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A49619DF4B;
	Wed, 23 Oct 2024 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718817; cv=fail; b=h9xPCyxSXkchPKncGT5ZapTJUesqL8nz+9zYU6cn0JCE7gcekwWl3V3wreNEF9dU0L8fndsWb/13UxHwz6RiAjeJFBapdBsl0nUWrCI8elBlIY+HEGwQffM0jSNFS+0ZF06F2QhYs3r34XT5knV9ofPSn9J+TPfVYXfuMFKen/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718817; c=relaxed/simple;
	bh=xA+Ss3IijtBLYg3N4IrrGipKZSK1XyjqpZQ3N/adAmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PPD003BkxSoTXSvqxSTsADtDYWzP1qWRaJRA+LvlHi7qYyMyYU2RCnq670+Lg5uBK9mfUs2M6t7G9icC63SzQOjFMEzf/mIovnxc4gPOsvTUNH6HIug0wcks8TJyQviRdRFVeCaGmeLO3t9579dmviAvfwsnDL8DZLQvWW6BKyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzSU22eK; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729718815; x=1761254815;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xA+Ss3IijtBLYg3N4IrrGipKZSK1XyjqpZQ3N/adAmM=;
  b=fzSU22eKkfr5IdNL2tmuvXpSjrdI28t9vQf9SB5TXGSfoVOlRD1XFAHz
   lTK4g/7fegOT81XSAHGydM6rBluExqE8ylUx8Y93ctTKzztlf0vTTnYpb
   L0zLdN5ZDXjo+uyss1C2ihHW2AK61zj0WAW1t8XDHkJxxrFr6wDE9AOeU
   +cVjsxjYxByBZB5C6r4g0LJj2Uz/Nak9rUlvEi/0MjQ9uOb/Y20UnHHi6
   YM+loh91Hp+bve5rVYWY21qR9xQ4aX+3V4q0ZC1Bb6D6pF6eBg8xhP9e0
   FjxOfbu1hmEvJ8uQnjWbDx1JtswQ6zwBQeIQ3ex3JkrbS2by9IGxS48MJ
   g==;
X-CSE-ConnectionGUID: zOhP80tCRJmCeV+NGPyezA==
X-CSE-MsgGUID: FUBE8UP1Q6+TsiPJwPKXDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="32184315"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="32184315"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 14:26:54 -0700
X-CSE-ConnectionGUID: dQepxkr1RZGkDtNMQV4Nrg==
X-CSE-MsgGUID: Ir/g9EmVS9GF0pbP13Azuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="85174530"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 14:26:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 14:26:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 14:26:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 14:26:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOooLSGGnrtbrYpy++BCTJps50MVqUJFZdInCNocQqC116bpDTU8q2j9NO3YhP/tD/NaCYAQnYGtkensTSJluZVbLO+MCjr8cEGqeqbsdUlRSC95jppn77J7kMWIdvnJcPL5CEoai89msjZgYNw0KYy9BFh/qK8sl5PKy+qSaudU6DxNvq/ODK+Xj1tEyxKkr5Zx+66/0OaxUvM18TayjU+5RIE2POdahzAqoRKj2IJdNT6vfzeYQY6p3XbOI0VY+l5imsLcbAUfcKxoAE35VTlHtiqy6S+jfBONfwCCePpUU97z3/INSZutkMJ0jI7D7MIkOr2eu65NweEDyvzoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA+Ss3IijtBLYg3N4IrrGipKZSK1XyjqpZQ3N/adAmM=;
 b=m9Mri3DPDuOE1FRNUx3G/N4oa0i1PqilEA2CeWeLmLMhg05hpo92AR4mrBN6AsLbZoAo9NbCYfG7Af83hv9l4NU6ZxMBaQu7E8eDf3NqCikkNukY4+HPu20A36TLE2VuKWS9/wQXPQbIsfnc5gEey3mfMkWRoRnGQf4WN7/iBUeOLvGalYFad7dbyxRSzoUhE/oI+mde1ZYREhrsVVLCNOMBfY0eb2v9tzPdap1q1/GlTVZQ73Lrl2TWPdGxwcei8/2959NY+h1b0Q2ZujDoTwUpvKSWRhn6YZQ88j7/Y4C1mGiud8CyXaTg+XaDWnr8kG0Zrm9AkLIrA/OtfF2+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5233.namprd11.prod.outlook.com (2603:10b6:610:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 21:26:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 21:26:51 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Knitter, Konrad" <konrad.knitter@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: RE: [PATCH iwl-next v1 1/3] pldmfw: selected component update
Thread-Topic: [PATCH iwl-next v1 1/3] pldmfw: selected component update
Thread-Index: AQHbJTGSlyZou3o1zkGprkwML0TanbKU2g7g
Date: Wed, 23 Oct 2024 21:26:51 +0000
Message-ID: <CO1PR11MB50891A93EB70DF0DAF36A953D64D2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20241023100702.12606-1-konrad.knitter@intel.com>
 <20241023100702.12606-2-konrad.knitter@intel.com>
In-Reply-To: <20241023100702.12606-2-konrad.knitter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|CH0PR11MB5233:EE_
x-ms-office365-filtering-correlation-id: 7b000239-69b8-40ed-6853-08dcf3a968e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SbpTpTioB4+x9wDVG5bx6tCj01ZUyyYplad8nOgy7BiceU9k1Im9i/rfR9Da?=
 =?us-ascii?Q?i+O6nWrC/lYeLPx3tDrqWc2WHcqs/uHmH5Csa5EFHFG4hNeY1TryZ8YDZRre?=
 =?us-ascii?Q?t3a6iPGWK/NSi3Awf/nXvBlkKcqD8OaYrIXGbAYU1+PcG5iDC5mXkvJ41b2S?=
 =?us-ascii?Q?EgSFZqiNNavrWF4Ik2TBCh8gMIKcAeQb2dGn6JkF1s5PWX+PCLsgRVDp+YM8?=
 =?us-ascii?Q?vuWktmPUr03DjdPqfFZ8m5TqVeqj9FAz748l1mpvfUjbmkWjEVJQeFKJibxc?=
 =?us-ascii?Q?MrSPmq+XwiEp9s3OKkNx4D2ysKa0c5RwYvt5OzzXVwZ+z0VmKRgDcFsj8kUA?=
 =?us-ascii?Q?BzX5c5zWoeEDQb3HhONAUL3xBo/DvPzxPmrDn+GFXxQyhFgn6swSsUsUo97f?=
 =?us-ascii?Q?A1nfUK1ZDmv9nslo3pfPGTU41xbmc8S78R1PoPSonF3E2zkzgN5oHZWfEmcB?=
 =?us-ascii?Q?ienJBpShLz5YIEC3VgYzRpw58YJ91MiOf/gINExKamORy+S+1GVBpzxQzFwF?=
 =?us-ascii?Q?7h55auD/RmiXbKjcgXobsjE99SLKZnGfhTKJ29Er2RQnfQPFY2g6nmS0at+u?=
 =?us-ascii?Q?hdnLE6JhKWLpX33kGt+CRFtWt2e20jVG2IiCs6bvQ3dN53lYQuL1cbAQelG7?=
 =?us-ascii?Q?59uiULKddpB+rOqGDk0LwB2wFIPJE+9ZflyM2kx2zfL7BpN4gUPJHIShdYis?=
 =?us-ascii?Q?Nhj/CddnLNoMwzEgFhaVIofmQKY4E9X0GJgFYwUn+OwO6omFzHGW8jwi8Jlo?=
 =?us-ascii?Q?SsbOOinEkd+Q7ApTjSjulbsuGvzZOMLMWLNfWBQWJc65ZXUXePScp6joK3uT?=
 =?us-ascii?Q?9usL8LIxaVo9t//LFoLinRqdqcxt8rRsYgQlHPwogXvaO/sn8J6E9QyBZp53?=
 =?us-ascii?Q?pvNvoL1Rxt6iZmqhtsuehj+Li/+RDEvTBXvIGogNXBPP6sqUDJQWPAAWO72H?=
 =?us-ascii?Q?6OwMVtbbHMYeqcvvu73vcSvlXcEZ2ytrJeiGcmiXXJ15DHs3z+LCKJrK75ZA?=
 =?us-ascii?Q?UrMwP5EVa4hC1wxzgeI0Fh57GvzbbpEhCHWeic8WcLRIgFGqmIduD9SjTPBt?=
 =?us-ascii?Q?jvU0BSgypXy8gnHY/Hxb6AmWjnoLbCrEZUQwo/fDeX+8zTzxi17O1ZRgoVDg?=
 =?us-ascii?Q?AngKeQILoUari2eQhdDJ/rd42ieL2YcxTUISoOJJpvxOPOPB/baZnsNCC2F4?=
 =?us-ascii?Q?4HpIIHq8pRhrPtaSn4T4CSX6l2Aa+J7fUyEmVLZFs2x3W/IqBr5x0TAdE6Bb?=
 =?us-ascii?Q?hI4LQqWAR7wEhDp7GK78m8JB8/1PpLE9CxJ3aSUXKpjuF/vopslnfuM5yCIN?=
 =?us-ascii?Q?5ckkkk6GccvECLGZjpNi0Gtf6YC3q19YaVvuAYKJCxC+t9CHERNUu2+UqWzc?=
 =?us-ascii?Q?FoYe0Fw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8G3Da0JmDvgvYFAkwaHYpFuMs5C2r2XrutAkEfP+je2KXdw1+EdrHISJkYon?=
 =?us-ascii?Q?UVi05VzxtdxU7/oKcwT6gar+6O2BvvHSMo3I4oOFH0ZQAAtzkw05tQcUQVvr?=
 =?us-ascii?Q?euj2WiVxjdXWEEEXhyi+L6uA8mMAUoWmjsdihXZbbndgc7XI/IM57p0+pAwy?=
 =?us-ascii?Q?+LdxtGyLlrWEi6b7eNNBG9iYTOWTWHvd4IMPYbHgCOpu7NmLiNXmKPwENsbs?=
 =?us-ascii?Q?ClKxO8G4a3enQrWRYEShp092OfOl5+NVW5LcjkUE6aHLJLTe+JYD0ls8c77j?=
 =?us-ascii?Q?GKDSyBqzdFZrfR0xbvNyaahwh5UjaN9BzrkmQJGrrJ02Y6nlSc8JzlxSMqn6?=
 =?us-ascii?Q?Q3Z2jU1CkKcxlPvhGpoqRSh6+CYbjZVg1CJbJlzaERGPUJrmKzrhSKwFCT7Z?=
 =?us-ascii?Q?6uF3iaVPsT0Rm9RcTeYF3ttw/8JDIM3b/6F3yjJH9H0kdPB8GsnSxLsJcXIZ?=
 =?us-ascii?Q?HMkMAF3jG4wdI58/3r+xQyuJ49aVoM6e9YDTXnaGbgai/ut5Wpco1N05fB4r?=
 =?us-ascii?Q?Nn5LSSCbaXrI/aiQqRe5BGsd0cMihIEhlEPCdL4TZykvcRqp3zxPbzGS3VMC?=
 =?us-ascii?Q?gcVJX2E6gafdh72JjKJ0qi17J5F/4w/cyRA9/BAfvV+ydglAUOqEvvRJ6JLF?=
 =?us-ascii?Q?giBn6L1Ti+M3FrlodZQzKMixE9lJY1uQTbNFRl+UeZIo8k+QgkidznxHXAIp?=
 =?us-ascii?Q?dA2++CxWA0TcUcitFcClpGiHLn/ant6xnBMOvhgY4NcpDyG/U7GQ7zKVn/jO?=
 =?us-ascii?Q?oU32RDkPDluPFofUuMbzS8KHRswuuDKMOB5M8D73BTaGwMvlIjihCfPd1p4z?=
 =?us-ascii?Q?s2vQDwOEVPPdqsjlsjKWSfxurb2aeo715GoGvTcpIdVbrbAjavW7JRRMrfXo?=
 =?us-ascii?Q?Tbg9BDjZYEh1rtaWdCBr67qOgLjz7gPwWXVVLYpuLkpyLVKV58iWcjiblBQO?=
 =?us-ascii?Q?6xB2GdDSNfU9qsRfjaXFDFkyzjNmHM/sGGK7+V7XW7CVRtt8lZ30vKZyw6Bd?=
 =?us-ascii?Q?uiX+Ki02XMcnwsG5CmedFlyZPPBzz67iTsM18ANYYVANvMVtBkve5S56hYWy?=
 =?us-ascii?Q?JI+o52s5WnaHofE6H5GdiVGsEyd6Zb5VpqGYkEJHsGARejQwzoXTKU+JbqSh?=
 =?us-ascii?Q?D/deg1aetb7HASI2IezqujqVwXU+DyANxuHY35mx98E/kcmMsyjY7Hz6+YOQ?=
 =?us-ascii?Q?U3BneaGr27zJ5KgL+xqZj55SOoN4grVq09u9wQS5OfCGv46aal1W8dQQ98i+?=
 =?us-ascii?Q?ivzptHeX5Ezl1iqYkh7ra2SjJamFAg3lt1FzJh1Ed0byez3RRX9mzoAFyhES?=
 =?us-ascii?Q?zZSY7TYhM+jKjpvKblXKrP2OsIBQsub9m9StdS+YbnvACm2BzRqHchvcPOZU?=
 =?us-ascii?Q?shqwZTE9f7MDrZdsHYcbteh8972JTUlADoi4LBAeQRSoOStiGC6v4vubRqcL?=
 =?us-ascii?Q?pzaEo6oKY+bWCivm/3wbOujNfYWUgvygN/yS3VcHgIuAeLznFRD+W8ZfSss8?=
 =?us-ascii?Q?p1kfJM3PysAyIoVt8tssOmn1bi4hImqlInCDGxJOMi2GbzGQeAwTtd1gcEk/?=
 =?us-ascii?Q?gCOFUFGLgF13jXfcrkeCE0sgRPtl4lS00wbxHWBq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b000239-69b8-40ed-6853-08dcf3a968e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 21:26:51.4580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yS3QtVdLnKZR7ToXH3RLh7nEcviaa00dRm2OFSNT70AtqzK2b7qU9AN76HwtXTS1gjhRRRARb2h4mdWC+wnU0YToFj7erHiLdQz5R6eeRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5233
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Knitter, Konrad <konrad.knitter@intel.com>
> Sent: Wednesday, October 23, 2024 3:07 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; netdev@vger.kernel.org;
> jiri@resnulli.us; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; linux-kernel@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Knitter, Konrad <konrad.knitter@intel.com=
>;
> Marcin Szycik <marcin.szycik@linux.intel.com>
> Subject: [PATCH iwl-next v1 1/3] pldmfw: selected component update
>=20
> Enable update of a selected component.
>=20
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks for the PLDM improvement!

