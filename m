Return-Path: <netdev+bounces-29498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DEE783826
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 04:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076E9280F86
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 02:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB571118;
	Tue, 22 Aug 2023 02:47:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7D7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:47:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8795184
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 19:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692672477; x=1724208477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BtDQu689l5EsRTfVCd1DT55IiUDXdOoyDxkv3hfhiQ0=;
  b=WJWIAbag3LBYVm5acO0+ziOFcZZdM7f0J8K2CnZ/V94mVipgyjeOd0hk
   9ey1Q9tZCgZqssEdUmon5DL5/i5C+6yEBTydLRYekeLO1xH23TTpLHr2S
   c6yjnJbrlhPafJJiCQC3DD8JViWhR0uBHWzKcDBS8QYREIQyTrNqJ1Q38
   QoOeNI7r6uLCh7r6ALI9At3BXPPnfGMoOT79Chlvy4elD/zBK8qbZqP9e
   9CQDlBfrxb8e4oyWFXDqItYlLhdsClCAv0QPbmPMsMVksZhdnb+0uk3FQ
   NFMB8wjX+XYHDW3BpqMcSUC4iKc9H3TTTBIZkLWzSf7v+fVN4gvcWghtu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="377513709"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="377513709"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 19:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="736049545"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="736049545"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 21 Aug 2023 19:47:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 19:47:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 19:47:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 19:47:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 19:47:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqXoWsNJDUhjE3x1AefPN7oQ8E7XeEG+GHKOCpR6D78krIhDNYUsU27oKSzsY4Jt9kKNVv4/qpOdgBVB8N8SlmLNnDtJP8/xF3sKArNs1f3UcMtQbUwPr2+xtSzo6FyBAyQ6qYm/Tl/D0FewMDpSJ1ZfxiqQlc2ucpuDDCyyf+pZRD9Pe7XVc+TsMqp7VbWoO7uTefrGb2JaPSEzUgi3ojovdNHR500/cKIrsMzWB6sffUm22M/fm4Syz7XU9Qo/qZBbOU8RFvCkGOgqqHY/djSi3q87Mf6suGtR79yfsFmfCP1PfSjHkginRWXXDYdXftHFuVsCgjROmoSJ5SpJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qt7n0gnz58LY599y47JDFeBhCBEbGlaOLn/0IqC6ANI=;
 b=LL50pMtaS8ayO2SrqYvQDruk9I09H3a58e51257WnVt74ZMgVu7RcQORDKnI6shitmnBdlD1UhsqW0aGTwr5eKQra3yWVTwpPFvaob/MrxY5Uw1N6jWifjeGYS35sUcdcmFMKxHkAhZ3LL2xN0Rl080xa02WeiNYJZ35plEFKO3Lja2nhz0yMoZ0B4g8kE+Xzyg7/wc7WjL5kMSFiuwZ0RjyiqS/ki/UIs2G21hqXaCniivQqHOEC41QtE4iSshoWkNhPxKwyuhdBhzruYk+9DQ7+sTRklEHMuOyqGzLUpoqbGfxzr0xp4/87FgM6Ei3ELG7RkGjwS5ehUFEa3kFgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3723.namprd11.prod.outlook.com (2603:10b6:5:13f::25)
 by DS0PR11MB8072.namprd11.prod.outlook.com (2603:10b6:8:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 02:47:53 +0000
Received: from DM6PR11MB3723.namprd11.prod.outlook.com
 ([fe80::ce6:bce1:eaf8:ad80]) by DM6PR11MB3723.namprd11.prod.outlook.com
 ([fe80::ce6:bce1:eaf8:ad80%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 02:47:53 +0000
From: "Guo, Junfeng" <junfeng.guo@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Zhang, Qi Z" <qi.z.zhang@intel.com>, ivecera
	<ivecera@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: RE: [PATCH iwl-next v5 01/15] ice: add parser create and destroy
 skeleton
Thread-Topic: [PATCH iwl-next v5 01/15] ice: add parser create and destroy
 skeleton
Thread-Index: AQHZ09ijYFelMPzDika6yBhxTGMJEq/0WEWAgAACnwCAAAB9oIAAeckAgADI0oA=
Date: Tue, 22 Aug 2023 02:47:53 +0000
Message-ID: <DM6PR11MB372326A9056D496FF937B927E71FA@DM6PR11MB3723.namprd11.prod.outlook.com>
References: <20230605054641.2865142-1-junfeng.guo@intel.com>
 <20230821023833.2700902-1-junfeng.guo@intel.com>
 <20230821023833.2700902-2-junfeng.guo@intel.com>
 <20230821072037.GB2711035@kernel.org> <20230821073000.GC2711035@kernel.org>
 <DM6PR11MB3723437003B055BB7C74AF63E71EA@DM6PR11MB3723.namprd11.prod.outlook.com>
 <20230821144738.GD2711035@kernel.org>
In-Reply-To: <20230821144738.GD2711035@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3723:EE_|DS0PR11MB8072:EE_
x-ms-office365-filtering-correlation-id: 734a23e1-3aa2-46fe-d24a-08dba2ba2ea6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 93uZyrQLsqUJQW9+0Pmho9hTfJEWdKfaOYBNv9Ng1i5ojVI8L/I2fSyXBQ+raQ/zmWaXnod3TmkoLo6L92zNAHMDeLg/Ek4otKPWY9vWSB5ge6mpVgTi0O8UThTPXmq5IKAxuLvaYwRXAoLsNbUGt9HRywdbO0My1c+WAAM0ahH2yqQbbHSthyVCRSJMNiMDtriNUtpWAFT5hU9QO7FnSQTgsPOxKAjE+2aVUxdES3ROC9wNjKpon0NGxuIvQmSRjCww8FCbF4CSzwsVpoJxSLppvP7IKLOBbFncTQ32cBZpV1j7jXz1ETp8/jQxRHuIZMTUHIJNNhBPimy9wriuwiZ/n5u7vjA5+XT7DFP1KJctMHnsxCfm895xb/kOZOG7vsP6ZHxjQATuHdbVd1nDpBZJacXc20OJ/rn0jP5VjCHSFFoTkllMf6a8EhRcTeQtP0PamLQYgblmiF2dJkN/NKJKSE+9/FhXTUwvgEMF0cOBCs+oBhRzX4REZMkwQD5j7NtwV0qsEc4Knyex3+d5LcauVnh/oG22oVIBE1pi2hlaV9JIQa7nLznEm3n1UEC2O7mWNJUKjcOZWm65ttzkWQxv3fZUuvsDjdygyGuBQduCXqI/qhnVz26U9fdROOoX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3723.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(6916009)(66446008)(76116006)(66476007)(66556008)(64756008)(316002)(66946007)(9686003)(82960400001)(8676002)(8936002)(107886003)(4326008)(41300700001)(122000001)(478600001)(55016003)(71200400001)(38100700002)(38070700005)(53546011)(6506007)(83380400001)(2906002)(86362001)(7696005)(5660300002)(33656002)(26005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Poeu92bYwjQa1jiWTF0/TjLS/1sNs5mWd9o0yUwOiG1sXcOdW9WfRqDziR1P?=
 =?us-ascii?Q?3zzxn7ctFqbf4KodwQo4+09uaPNlIj4UJNIoUvOqPy5Y47PZ7V1Dc/Bn864P?=
 =?us-ascii?Q?6OSMns6y655yYv4XgMsaR3AdDeqHDfyol1GqIbVRL5CXSo1ngmrSFnXv9A91?=
 =?us-ascii?Q?JzntY8BzE7xpbe02pD60ieFNeR1jY49d/oXab3Ntuq7ieubTygCh2NIbLVbT?=
 =?us-ascii?Q?NcoTnTE4qQuYk8LoMwzhTxhRQ2WiYdorIJ+gWumjiNbGefSfhV7+Gvvi89AS?=
 =?us-ascii?Q?lg/EWMeRgXPjLcaIV5DZ5R460ij9Fh3AHc160YXZCNCTWj29NY/dYrJTOjIV?=
 =?us-ascii?Q?Wdbr3n1b4dJwCpy+TrqLzBZqgjFqn9E6fo6DCrk7s3VZulmT+fKIoU3DLCCG?=
 =?us-ascii?Q?9g03Jdv8HkIJhABCgZ9EZpeEjqqixLTNcc/SmKTwZSnDz/Dqh2AOIL1UFwer?=
 =?us-ascii?Q?morFGkqsBb376nmjGS3CVF97YYiEE4XjocTzrKqC4LUEywmAt1TGNoDc91WG?=
 =?us-ascii?Q?00TdU2kasKdCWia7TbTU27Ln5WqntFIn0onA+EXoYz8vBVEieR/QWJgTktYM?=
 =?us-ascii?Q?pGyjbSpr163IBmlqBzrjq5yApTOWF4HB5e9S87bWfmaBNwsVKN4/2mIqbhkJ?=
 =?us-ascii?Q?vQ/vIu98YPTSxYf4I+7oQk5vz6Xorrh8k5I/sgQZ0qSmQVfq4QP+q1Leq9nq?=
 =?us-ascii?Q?yCW+BAyxITRrFPmkAPLHsw31WvdohyH9jtEHMy+5uF6uIUqo4zbqdAtVKfDv?=
 =?us-ascii?Q?m/bpyScGBuOFwUy8T9jk7pI+473xdTSSdAYpLphPAKEY54v67Z0BqP4VtdSs?=
 =?us-ascii?Q?NULXx66sEcqoOqgbvqy2u/7OPSNVfr6CEdakm3wf6vhtGH8T9hE3FJQPBvwQ?=
 =?us-ascii?Q?o0Db5GawtXZnH4CfjzLRdCCpdsCaDK2QP5wHt4FyApMVMsNrYyCF9wbwcxwt?=
 =?us-ascii?Q?BSLR0PNAIPIr3Ts33QO1F6qxyXQ5N7kFkxIDynZl/xx4PUXFaWsLJtf3Qc70?=
 =?us-ascii?Q?7MJgVj/cRCRSv/BY2jddLVhQijFfVT6AJB48eslwM2aSEuhFpDW0diz+rkGX?=
 =?us-ascii?Q?UzoUp/CjlkbvqbT0tVmGExbCnrnQVrK+uTBhFjwcToKVqBSAULb5HXXiyViP?=
 =?us-ascii?Q?SL7ooIGsgFgZ+4ZsVygzZEBYQ3anYDVQSEY7aAC4McjHAi71mnLdDzMy6m+a?=
 =?us-ascii?Q?IFkYJKiapDDji6hPhZ4FC2Zxn4d8krKtwzRmg2yAlLQcB5TGcwjqmdKYgoDo?=
 =?us-ascii?Q?xl6/2Kxoajty3O9BPuSxwGgHNKmgeo6vylfEB5Wfknu7bVhYw6oC0PVdtFrs?=
 =?us-ascii?Q?ZTCYPR/S3Ew3z8B/3DAPT06fNLkP+x6rLbD57HDe82PtMZIGQhDJWiS/FuBT?=
 =?us-ascii?Q?e/1BnaWt97r0K5XLfNJAw+ZKdCGJmVvC/zR2f1E757h6cDsSMslmultJXNo1?=
 =?us-ascii?Q?SU/01I+ur+b8lPmuJobiQFG6VwYgk+FmqnsIV7yQUFkPrIUzB3PK1UV8AiTa?=
 =?us-ascii?Q?iovlwcLueclfw3mBtOhOpha9MghEnnjACZrq3d2ZIwup7+Q4KFG++eyHT+Um?=
 =?us-ascii?Q?xv6j7C1t3HawRXSlveYDOY0qLW1J9ltd/nwMRtUb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3723.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734a23e1-3aa2-46fe-d24a-08dba2ba2ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 02:47:53.2942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxbMubA1dy86MqEDGsKND/J/KgWAypBDQVQxb7kP4f0Prtdhgosl3/N+pfpeWKmnxxDbrX2JvZIi90QThq3GzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8072
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Monday, August 21, 2023 22:48
> To: Guo, Junfeng <junfeng.guo@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Zhang, Qi Z <qi.z.zhang@intel.com>;
> ivecera <ivecera@redhat.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>
> Subject: Re: [PATCH iwl-next v5 01/15] ice: add parser create and
> destroy skeleton
>=20
> On Mon, Aug 21, 2023 at 07:34:38AM +0000, Guo, Junfeng wrote:
> >
> >
> > > -----Original Message-----
> > > From: Simon Horman <horms@kernel.org>
> > > Sent: Monday, August 21, 2023 15:30
> > > To: Guo, Junfeng <junfeng.guo@intel.com>
> > > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org;
> Nguyen,
> > > Anthony L <anthony.l.nguyen@intel.com>; Brandeburg, Jesse
> > > <jesse.brandeburg@intel.com>; Zhang, Qi Z
> <qi.z.zhang@intel.com>;
> > > ivecera <ivecera@redhat.com>; Samudrala, Sridhar
> > > <sridhar.samudrala@intel.com>
> > > Subject: Re: [PATCH iwl-next v5 01/15] ice: add parser create and
> > > destroy skeleton
> > >
> > > On Mon, Aug 21, 2023 at 09:20:37AM +0200, Simon Horman wrote:
> > > > On Mon, Aug 21, 2023 at 10:38:19AM +0800, Junfeng Guo wrote:
> > > > > Add new parser module which can parse a packet in binary
> > > > > and generate information like ptype, protocol/offset pairs
> > > > > and flags which can be used to feed the FXP profile creation
> > > > > directly.
> > > > >
> > > > > The patch added skeleton of the create and destroy APIs:
> > > > > ice_parser_create
> > > > > ice_parser_destroy
> > > > >
> > > > > Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> > > >
> > > > Hi Junfeng Guo,
> > > >
> > > > some minor feedback from my side.
> > > >
> > > > > ---
> > > > >  drivers/net/ethernet/intel/ice/ice_common.h |  4 +++
> > > > >  drivers/net/ethernet/intel/ice/ice_ddp.c    | 10 +++---
> > > > >  drivers/net/ethernet/intel/ice/ice_ddp.h    | 13 ++++++++
> > > > >  drivers/net/ethernet/intel/ice/ice_parser.c | 34
> > > +++++++++++++++++++++
> > > >
> > > > Perhaps I am missing something, but it seems that although
> > > > ice_parser.c is added by this patch-set, it is not added to
> > > > the build by this patch-set. This seems a little odd to me.
> > >
> > > Sorry, somehow I wasn't looking at the entire series.
> > > I now see that ice_parser.c is compiled as of patch 12/15 of this
> series.
> >
> > Yes, thanks for the carefully review!
> >
> > >
> > > >
> > > > >  drivers/net/ethernet/intel/ice/ice_parser.h | 13 ++++++++
> > > > >  5 files changed, 69 insertions(+), 5 deletions(-)
> > > > >  create mode 100644
> drivers/net/ethernet/intel/ice/ice_parser.c
> > > > >  create mode 100644
> drivers/net/ethernet/intel/ice/ice_parser.h
> > > >
> > > > ...
> > > >
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c
> > > b/drivers/net/ethernet/intel/ice/ice_parser.c
> > > > > new file mode 100644
> > > > > index 000000000000..42602cac7e45
> > > > > --- /dev/null
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> > > > > @@ -0,0 +1,34 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/* Copyright (C) 2023 Intel Corporation */
> > > > > +
> > > > > +#include "ice_common.h"
> > > > > +
> > > > > +/**
> > > > > + * ice_parser_create - create a parser instance
> > > > > + * @hw: pointer to the hardware structure
> > > > > + * @psr: output parameter for a new parser instance be
> created
> > > > > + */
> > > > > +int ice_parser_create(struct ice_hw *hw, struct ice_parser
> **psr)
> > > > > +{
> > > > > +	struct ice_parser *p;
> > > > > +
> > > > > +	p =3D devm_kzalloc(ice_hw_to_dev(hw), sizeof(struct
> ice_parser),
> > > > > +			 GFP_KERNEL);
> > > > > +	if (!p)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	p->hw =3D hw;
> > > > > +	p->rt.psr =3D p;
> > > >
> > > > It is, perhaps academic if this file isn't compiled, but the rt fie=
ld
> of
> > > > struct ice_parser doesn't exist at this point of the patch-set: it =
is
> > > added
> > > > by the last patch of the patch-set.
> > >
> > > And I see this field is added in patch 10/15, rather than the last
> patch
> > > (15/15) as I previously stated.
> >
> > Thanks for the comments!
> > Yes, the setting for rt field should be moved to patch 10/15.
> > Will update in the new version patch set. Thanks!
>=20
> Likewise, thanks.
>=20
> If you are going to address this you may also
> want to look at what seems to be similar problem with
> both ICE_PARSER_FLG_NUM and ICE_ERR_NOT_IMPL appearing
> in code before they are defined.

Oh, thanks for pointing out this!

Will also check the rest code for similar problem.
Thanks for the carefully review!

>=20
> ...

