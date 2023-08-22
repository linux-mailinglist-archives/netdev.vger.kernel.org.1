Return-Path: <netdev+bounces-29798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD950784B98
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 22:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4DB281114
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0101E500;
	Tue, 22 Aug 2023 20:46:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720A20198
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 20:46:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE0810D
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692737209; x=1724273209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t8aIqzI1ZZmad+IV4TnM2UKZWEgNRFpZxX8Y6yIkooE=;
  b=kO1dGqvyBhYAmckuw9ahtDqBbV0gjcWPWKD0Yq3sNYQW8WWbjKj+s7lB
   Lgxxf2Dfyb1c3C2DzMZMTLbIQ5optlf6ZEpJAywZm5HT8gnuDwU9m2ZNR
   SZhIa98hEoiTzWG/mt3z6pth/jhSEkuUtF+9muaxfR2LjGVvfyUD8hpU+
   s2qSu9D7xzoEKWt9GUvboGWkn7M+q75TWR2ue2PzBhxuI+rgcj8iUrvEv
   oZehBhxeCzZfPn8ioMz2cPdAndaNGxUNKDA4gRFnS8WNSIFHD4iNf5cXd
   fnaHDQ0D1bK3Etvi190/bcAooYilary14I7P9Yoxki4RVwH+7x410zG7d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358979979"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="358979979"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 13:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="801818861"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="801818861"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 22 Aug 2023 13:46:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 13:46:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 13:46:48 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 13:46:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9+G11Fsna6gUFjfNZdrVZZ2cvHJMxBzhUucwILSKf3DTv6jsZFGwa39pdm/FlYVEgvJmWSvAWftG3QxwdTkrKmhqeDsyOBAzI2bWUxD41aV7zQfKS48IkkiLaZpEwKd8k8hggd6ST0CrwHW5dHWrYoPvZsdaJ5goskb+5cQEsGuMHP2o/zKpr86Hm9gD6MEJV90J6NFT4ZxwD15aVEg1dse8pmv+PkW46n7AjbGNnJNDA2LpV5JwrV3ujwT4KXju8wMOefqOzMXwN1Ac2263UflqAHDhc84bG6Zg1woiKdGFtZykdW84MLVWM7zUKO2ZdTrKTjzEIpjJWhOLd9tSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8aIqzI1ZZmad+IV4TnM2UKZWEgNRFpZxX8Y6yIkooE=;
 b=W7r9gKul0k8EZGtgUNbk/Zl4G/bmLn5kS4Us+sdNX1Xy4sasKhXkHuCbvAbLp+st73XyHO/5Ob43ZeZ6O7gZPbrPsS2zrZawheXG4kckxNRvNpI3wSh823a5oaQ6jkYZbP/i1y0J5lN7lbwArFqy+VAnOURV3C7sDps5Od4qCgrKN9HBzuszg83i9Fw47pSvlz8PUs1ACnLyYsOHMemFhBDxLmXGHF0/CtfZY/cA+uC/W4JDBajnuiukROwGt+q9eXOGVRlN0mnLqGs8eUtnNPMUrBzygJMsyc+3XKkYAgqgNXD4MkW+RSh2tPI7YGKRTwmfqD0ychB5IBMYnerLRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5632.namprd11.prod.outlook.com (2603:10b6:a03:3bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 20:46:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 20:46:46 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Leon Romanovsky <leon@kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>
Subject: RE: [PATCH iwl-next] ice: store VF's pci_dev ptr in ice_vf
Thread-Topic: [PATCH iwl-next] ice: store VF's pci_dev ptr in ice_vf
Thread-Index: AQHZ0B/Kr0m+SbZOXUG1BfUHaYFdEq/s/IcAgAMAE4CAAGSfgIAEOJ4AgAADqQCAAjWm0A==
Date: Tue, 22 Aug 2023 20:46:46 +0000
Message-ID: <CO1PR11MB5089F6E24C2570F710191DE7D61FA@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20230816085454.235440-1-przemyslaw.kitszel@intel.com>
 <20230816143148.GX22185@unreal>
 <c1f65aa1-3e20-9e21-1994-1190bf0086b7@intel.com>
 <20230818182059.GZ22185@unreal>
 <12025d38-a5e2-5ddd-721f-c1c083785d22@intel.com>
 <20230821110146.GA6583@unreal>
In-Reply-To: <20230821110146.GA6583@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5632:EE_
x-ms-office365-filtering-correlation-id: 25e174b1-717f-450d-67ff-08dba350e6d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bLWoDo/55ayrKC5KKlWlepSYlkyhj5sYtDOcBo61cDDvN5NVRqNQkgokNJ0M2D8eWMMAJaT8w04jZ8MIcnkB6yJeL7k7IbgPKjxdwRHNsbeRTzQ8nLfvf5pMiuOnms6AKZ3+zI494TR8GbjUsGFDZcLJxBaN6hSBC+U1/Unqmcv9UckJgNT0zX6uc52tFT2tC4gywOc0dU7X40eTUaTnhJPBzMz4oynnp2Q4ZTHiXdhdiqwfjT0Z5GUwtTN3aDl3h+MgyfULcX8qvcOpSTiCi/OJP28NBXMa2HDbFJ1dAqoXETts9WCMKt8/ZCAL3KCg33JRzrwfLrJW3gJmRWgm5aKWqu8DQvS3RTaZII14NxzLUGLv+76mnocu1PkejdbWsH0mTH1jZ1L0zWd78l/1UKn+g4D79DBgGm8OQTMPjKh6d/cCM+cl/WOuVEEdqhW6qtQTiLzJBTVIuZSA4bup3iqy8J7fwfkS/OkMFmzgbX0GZBfwouNZ4bD4ka3OEJCvE2BTR5hK45mH9tbckbqyxqpOOrqkDnCDcQMTElraGXivx3qdpqXBvMqzg/nJ0I39nIOCC2zLLkaC3CImoop/Ogzd5huAALnJzAAWtvx7Pv39X322ohQOu7WDUFoH9AmY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(1800799009)(451199024)(186009)(55016003)(107886003)(122000001)(41300700001)(7696005)(64756008)(66946007)(54906003)(66446008)(6636002)(6506007)(110136005)(66476007)(76116006)(316002)(66556008)(53546011)(4326008)(82960400001)(38100700002)(2906002)(26005)(8936002)(8676002)(52536014)(38070700005)(5660300002)(9686003)(83380400001)(33656002)(86362001)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A6c99s3bpVW7dWeuVFrh/Fx3iAiY6VPrMvIzZnoWcdstBi9Bf09SyovNUxlQ?=
 =?us-ascii?Q?kjEKVYX9dpdA9t8HTLKm+FNHpTIkkzX1Yi3/+7HkhaY0flSJMuq1SdMTx4W1?=
 =?us-ascii?Q?Xradt7uv11wQy/JVlpnmKYtBrVPi9Yx3Gluf6bup4ctKxaIgpvVh5vRIfAFS?=
 =?us-ascii?Q?kIV40LUswpM7U7y5SH6MLJiiUSBSxbMzrKH8rdiN91BTKJ6t9zc0JwKFSdcM?=
 =?us-ascii?Q?pKRGJ+8PlLwPK4PohHOloq+tYw3eBktlLmj3wmWbaVcfA8F5t+fUdsKi9+S2?=
 =?us-ascii?Q?G9u39SzQVp8cUiLmRwjvfLztOPIHJPkeWjr0sqTtebKl2MiIJSyRoEErp7fK?=
 =?us-ascii?Q?xj+W+PIFzzBQlghf6rg4qkvCp+lTjPvP8nUUNbEgtbCwp74UAoRbSGyebQd6?=
 =?us-ascii?Q?zvoS5tfSwIgHjKKIAMQrHenGrzq+UfedSfpaTOTJaNMTtzRyE+SfYZcGOdkr?=
 =?us-ascii?Q?wnkm7BvgBKM0aaB67ZhGYf6KHphpK7YBqB2vjvcEDbCc3WE9wqUeKh2iHQSw?=
 =?us-ascii?Q?TjSG5XGcOTE7qIhzpRIqZAksPz1IPgmy9s5tj4PDxDCfJK7X/3I+7TRQa24F?=
 =?us-ascii?Q?jmT2Yyie4CW39L6FoCpDV2THUTpAdT3YXTrC6kHJg9lHLdQrpbEbNixeSGbv?=
 =?us-ascii?Q?43cLVPznekgEjIiHIyC2HVYSanisjM2cJYzRv3tiSj3AlNlzE5ifkooeFKB2?=
 =?us-ascii?Q?l1FU5xmPEslcrQQv8a8Rk5NPbuvz9H9fNa9ElWpFBSwGsyd0wBHXPVBqOgbQ?=
 =?us-ascii?Q?zhNe8yvwQFOA8u8mNYJ5clyRpRg2ahNcaPWWGd5BOQo62Z8rpytCygGBlWB7?=
 =?us-ascii?Q?4BSEI4RPnuwyHBvds5XWmZyHfLoDaL8PM1c5kwv8XLXPSem5O//QH3ZJIW9H?=
 =?us-ascii?Q?UasTJMWKd0feD5EQRjLhNe9kVt+m5GTuitv7+cmYBtRQF4ttUUssPIvDazWY?=
 =?us-ascii?Q?alU25ci0Vz0epCf46LNJFb7YyUn7vK1Kqp35DIcgwi7CDcgoLR49sl4MDnLm?=
 =?us-ascii?Q?wdgtSPOARp3ziusmwQ1k9a5ixweWsjNMv34KH4fYDBaneoo4OxunxfkowCF6?=
 =?us-ascii?Q?RMJTlBm9Cxh2AqZDknvEgl9OPtFBhfof2lHXWTfGLY/credrgiQvA20ISvoS?=
 =?us-ascii?Q?qI7wxZaPytFvncSMFfx5eafYmKEjz1ehHIH7ciWeE/oE4ybe6Fm2Zmwz+tAO?=
 =?us-ascii?Q?EvaDrNE6nqJmgl4i2IFaqv5Bw8hZeTbetHmLrqtBXFxHaGJd+lsC4UouylfP?=
 =?us-ascii?Q?t884aRs2uuTykR9dJXSAAOs0AOkxc83MnI7Njj643hcnRAR1WQjnvzu0hfW5?=
 =?us-ascii?Q?tHCZtLTi+CcQClXbI5uXNGKWYOI5PpTi6EDauWYnFRd6VYsg/m8Xw61wxvNv?=
 =?us-ascii?Q?ykaZoR39tuBcfrTsjHn3E3lRpCp4Id/cNWuuSQeizeg27qFKGMczu8XZpqkL?=
 =?us-ascii?Q?U3jKRk7orQ90xExe0C5Zy1oCqvwLSC/duOa/M3bdytdReh9bvw+omwvzvrHk?=
 =?us-ascii?Q?3P6fQCH1HXsIprRIcYpxboxla2iIP6PwlFaoyJkKBnCrSOU6GQRtcxXg9sdb?=
 =?us-ascii?Q?oGUoYg2P0p/YqZYVvtc4VZwW9LR3yyAGgmjTK5yP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e174b1-717f-450d-67ff-08dba350e6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 20:46:46.8645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laV0oNRsVBr90ve91fPN5u8qu/PyRz64Y6W+px9WkMQ4fGCLrOVP6/tIQi7g9/SNMTqVoUTzR66sod5GGCvuq4Tb1Di3rDRt8xoaVEMVoNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5632
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Monday, August 21, 2023 4:02 AM
> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; Polchlopek, Mateusz <mateusz.polchlopek@intel.com=
>;
> Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: Re: [PATCH iwl-next] ice: store VF's pci_dev ptr in ice_vf
>=20
> On Mon, Aug 21, 2023 at 12:48:40PM +0200, Przemek Kitszel wrote:
> > On 8/18/23 20:20, Leon Romanovsky wrote:
> > > On Fri, Aug 18, 2023 at 02:20:51PM +0200, Przemek Kitszel wrote:
> > > > On 8/16/23 16:31, Leon Romanovsky wrote:
> > > > > On Wed, Aug 16, 2023 at 04:54:54AM -0400, Przemek Kitszel wrote:
> > > > > > Extend struct ice_vf by vfdev.
> > > > > > Calculation of vfdev falls more nicely into ice_create_vf_entri=
es().
> > > > > >
> > > > > > Caching of vfdev enables simplification of
> ice_restore_all_vfs_msi_state().
> > > > >
> > > > > I see that old code had access to pci_dev * of VF without any loc=
king
> > > > > from concurrent PCI core access. How is it protected? How do you =
make
> > > > > sure that vfdev is valid?
> > > > >
> > > > > Generally speaking, it is rarely good idea to cache VF pci_dev po=
inters
> > > > > inside driver.
> > > > >
> > > > > Thanks
> > > >
> > > > Overall, I do agree that ice driver, as a whole, has room for impro=
vement in
> > > > terms of synchronization, objects lifetime, and similar.
> > > >
> > > > In this particular case, I don't see any reason of PCI reconfigurat=
ion
> > > > during VF lifetime, but likely I'm missing something?
> > >
> > > You are caching VF pointer in PF,
> >
> > that's correct that the driver is PF/ice
> >
> > > and you are subjected to PF lifetime
> > > and not VF lifetime.
> >
> > this belongs to struct ice_vf, which should have VF lifetime,
> > otherwise it's already at risk
>=20
> I'm not so sure about it. ICE used to use devm_* API and not explicit
> kalloc/kfree calls, it is not clear anymore the lifetime scope of VF
> structure.
>=20
> Thanks
>=20

The ice_vf structure is now reference counted with a kref, and is created w=
hen VFs are added, and removed when the VF is removed.

Thanks,
Jake


