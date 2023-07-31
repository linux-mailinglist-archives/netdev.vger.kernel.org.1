Return-Path: <netdev+bounces-22671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A79768A77
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 05:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C52028157D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 03:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2148664D;
	Mon, 31 Jul 2023 03:53:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2DF62D
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 03:53:32 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D3DC
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 20:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690775611; x=1722311611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KhBqRatI1gM2OBb/hRP5qSvNYTvJ9TNGH2ZTLD4ZRp4=;
  b=b6DBF14MrLYpTiui5cY407V3ZHympcGGRbzL2Ta+xOUcDHm4PiqlbkRd
   7R3gF1Si4FP36VTGAklgqDDKINq8c/mqHHIknCxze03XmXhwHf4WiMprV
   ZsxCh2kWKxL21jF7PXxnAkwnJWW9tHALGMTm7Ckv4auGfx6bzMDOcrHiL
   jt7C2JupGP5bS1b3eFcc2kuxQ98ls/Q0U3UibQNFUkuIauZbz2iT5itFb
   UM/n/dmPmFVGKGJCythdcwykSqwGFmp/asakgV8ol5d+xXx+LxjUlpVc8
   8SOZ1P0Cvw4jtr2kZfBOlnz9S7+K8KXYHIkR4c8xRG44SYADdobZOLSWH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="435212913"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="435212913"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 20:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="974729380"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="974729380"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jul 2023 20:53:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 20:53:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 20:53:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 30 Jul 2023 20:53:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 30 Jul 2023 20:53:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXNAjq/7ZbpFYYYQBBUnA1lZxvIhLDOMVm0MEQ/ekK/pSIjzGQesGP2pz0ED4ecMFboUPeysTYGgRSvLAZMw5ZyStzwyMdAJGmweaAKAoffmcWYA3XvfCrksB4gYMe8CbOuIlKH+A70cRHCpPNtq6k1MCv0uJSv+W7ATMvAo4LAAeEvjENXEAbHPgsbGk8MCQ7XyGWubShlZs6i781PRGHMIr2kPOHq6jeQTPO3knEdjJrESB7NbTDBgG2jvarvS+FhzxRPu/E6+6F+QUHrcn7G+LyJvveiFkRTGsUNv6J8jU/8NXfHfNJ3Mr5KW75x7sLICox36IBay5ee8HqTzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlqZVA/eCO5H36FRXclEi5r8fWjgk78FXkTnf3mp7hM=;
 b=XFobha2beXOT76ezDJ4tLjtckwAL0+TZgFIxUj99G2c+0q9QtTN+IOJ4NYgdKxo2dGa+mpJWHm0jX5mGx03LIA/OIgVcJCQyfzvsPX3grz5mhhwH06DmkBMR0Mh+gz6q16TME+BTYbgSQxnAzRwdZdKZXkj2Thzvx7X+JcehWgaVk8Dmk4oGP0yIhYYx7FBTNTrp3ndIDUfrG0/hzVfZsOAhkSOwajXPukXhj2iafJucfiGhoS8XmMP3bDilnLX3VAq13cjEC+FgVHTy8E9D7UGHQ6GBbItDANXd5iwnMY/H0oK+17Wq0/J13klPBohuazERaRQibVcSHeMFCut4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14)
 by CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 03:53:26 +0000
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::a8f9:3589:7af0:bebe]) by SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::a8f9:3589:7af0:bebe%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 03:53:25 +0000
From: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To: Simon Horman <horms@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Neftin, Sasha" <sasha.neftin@intel.com>, "Naama
 Meir" <naamax.meir@linux.intel.com>
Subject: RE: [PATCH net 2/2] igc: Modify the tx-usecs coalesce setting
Thread-Topic: [PATCH net 2/2] igc: Modify the tx-usecs coalesce setting
Thread-Index: AQHZwXc9ync42E/wzUqCVB7/2wDSP6/SeTiAgADHdtA=
Date: Mon, 31 Jul 2023 03:53:25 +0000
Message-ID: <SJ1PR11MB6180850591EFDCF7593B0BA2B805A@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230728170954.2445592-1-anthony.l.nguyen@intel.com>
 <20230728170954.2445592-3-anthony.l.nguyen@intel.com>
 <ZMaHobBXLeJS0dsj@kernel.org>
In-Reply-To: <ZMaHobBXLeJS0dsj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_|CH0PR11MB5332:EE_
x-ms-office365-filtering-correlation-id: ff671309-641e-476e-0e9c-08db9179b161
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6tnbZl4Y3vIklDJ+TR76d1eBHqzZSOk+/lKgHG7Env92g0W5gtwK7jqn1rZoRhWGOwFfEnqvqKzxt17uF1IaDZX/9Sx/9RfpKl0+Biq2GkCu5s1q6ujxY/emQA7UNPsWwdZcZE1bmxlMP76WL6nA4a6gOKefLA1XWMHS8Thv+XamZKGzw5NbIpcz+XMc8ymrL05NbEAW0odt2ChJM81lcNpVcl42GFF/3Bav6+MfuzSplyNjphYZ9BR5udSRycS4AN3xJ403GkPfkhg0BsdQn68uenT6xavattk3dTDvAiBcbSFpQMjdU2KvkQG9wsdSxSap2bQLx6zX3eEq/Mbpurb1t2sK49i9FuQ1a4Q67yixrUYDVko+AD9zq07FhrSRuiC/cBvl6oNfmEW6sz418z5RoahMHy1dhgZZgOtoG2FUcI7fWmgmiqE4DRXtB2GID37+rNrbHDsTINULm0Td5B0AulSwtCXFnRpRZD4JRkGL95W31VKZsH87TEjJeZzs9T5JJM8cg/9BrtxTxnhWAE81Ss4OIkkeZ0oCSMj8TGwlR7PUwYpP8kKoSMVMY3pDBdz8NJPP6NWc/XSus50ukRzlB1j8c/dUHCwy0Zn85O95Ir4bZ13AVy4sbg/kTqFb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199021)(5660300002)(52536014)(6506007)(53546011)(8936002)(8676002)(186003)(26005)(83380400001)(478600001)(316002)(76116006)(66946007)(54906003)(110136005)(6636002)(4326008)(66446008)(66476007)(66556008)(64756008)(7696005)(71200400001)(41300700001)(9686003)(86362001)(33656002)(55016003)(38070700005)(2906002)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l9wRYeGaZ49en3KS0OERdKP2PKL0T/DBJoRwvrItLPfjgyuJsQFJU47d9h2Y?=
 =?us-ascii?Q?rXgMvNrDg53EVAKl1hMVlmynOvxE01gd9VGcImnENo2m2R8RV/s1L3IDmZKB?=
 =?us-ascii?Q?WMQ3SgoDKjxTfzz5V89zC2Aa3w1lxye6T118oqj8yCh/mVxr2Jlj+j259CCJ?=
 =?us-ascii?Q?Oji7ghhf9/q4QJ1r/Z/h/CZKOSdQPkVhbtEKOW9Oz+gfm+oV0mj9py9Al+AF?=
 =?us-ascii?Q?6jx0xG4kAcajUNSHzejpIwOgAW9M7+uOPJntrde3nNcL4itNJ7MIGr5/MCDu?=
 =?us-ascii?Q?ptUDlMSkeapg8PTnHudVY6P80fogcKQ3tApXzYngnPc52WBL3RncoJ9XK87e?=
 =?us-ascii?Q?dyUXmBFhHKBcdu/Dj7FbFUVgONopVly9dBUkaIHM46lYUeYNvjnSTd8YPcWu?=
 =?us-ascii?Q?6ds4WjNUdxcNsAXPy0I7ZmPOPGeYCwx1G0x0HmYrHsHJiWCkZtLUAqIWUTsQ?=
 =?us-ascii?Q?JbBCLwpBz0pw/UTIR3foq97smfwGK9fTFqrgBInLcfNxa164nDy/lMgQ/H/+?=
 =?us-ascii?Q?ROsPtdKrhhnB/c/n+Nx4haR1JQyhylP/DQqs0AC5nLL4R94FpwTIdIwpQr4A?=
 =?us-ascii?Q?hmQ864BR9XYVUBoy40GGwxcFRL86zUaW7tux47pjBUNTlLDgF9YwpJBSFfzN?=
 =?us-ascii?Q?PpXGN8Qbm6WXwyMU+7ap5IKP29d/WcVxoXkXiqqmXcjomr5Up9S+aaIAcXaR?=
 =?us-ascii?Q?EcCJcUVTUzDM5EFjyW5R2wfvvfYieKg04t+27i6acmjpbSG2ItebcLc57vCj?=
 =?us-ascii?Q?7dUlk4c2F1UcgjFkDnkBDDxnp6rKc1RP4lqFREOCPPMpd4vczkdISaUqyE+p?=
 =?us-ascii?Q?qD6J4J+9eV345gNxn52gFU8QTS9d+oSgFokNvyT0E2VhLtMSkeoZsQzzWWvq?=
 =?us-ascii?Q?5e/K6FmeISOwcQPrE2R2D66rzhJ1j4Y74F1Z9b1dCAqiP3oaipRWbY3YIqo1?=
 =?us-ascii?Q?oS3cuh2hVa39KyYpL4jfA5g17x7JP7tOdlwLOrm1e2QlcWmjWwp6xROJbgzI?=
 =?us-ascii?Q?4plACod54g+KXs9mSAu0w9hGSHYOg0w9dgdMSStrpHaWdNyw1h7Gm16cd1Xz?=
 =?us-ascii?Q?ZpwKCnujmWrcPOoSO9I6KFmoP4QgNexS3C5MIFmG83+flhBZ8iKI0pQjHF5M?=
 =?us-ascii?Q?vHFBJ/R+P7p+Xisy5+JJhMXEecshxjZG2IOFO43dskxGCq+6YbkFuAUp2xv6?=
 =?us-ascii?Q?HMNgbcPnDuP+9hlw5NzSkFppe/vLHakAGlctQOg/4+khrqukf0xc0oEkHt/v?=
 =?us-ascii?Q?xtsv7wnVToC/XlLATZi6fAxEK9bDBTPSSadnqwYsK3Sp9TfPt6Wj5MQVmWnO?=
 =?us-ascii?Q?yo0YVtfkQWq7L7WGotcr17s0R3ryJ/Y9ZSPR0B/YkX7NDj0zgYwXn2a/GWny?=
 =?us-ascii?Q?TLWwTF/EZUlqxzW+CQyqo47RPVTP8MW0fUll8pLim7cls+w+wa2J0zpD0Gx1?=
 =?us-ascii?Q?s1XDY1GWFSz1d9A6DSEH9JdHLxVBCI+w+ZCZk7fxxAvajptlKubTyly26mi1?=
 =?us-ascii?Q?5DeJaaBeX8yeXmgWFHrF/Bf6Q1Nfh1LcwVBVk/Wasvx/eND343w+74GGvzgw?=
 =?us-ascii?Q?2ez5YzDODm2tNbXtAav783xBvtT2SuvkS9AEYNy/1mIc/kahPynHmg3g6jaQ?=
 =?us-ascii?Q?U7OMAZyzPa9HKSZgyALETJA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff671309-641e-476e-0e9c-08db9179b161
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 03:53:25.5624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Y8z9WyUYFWFm7Rf/PFtwLGYyHnAJ2DS3mtx7sJfRMQSHImfp4JfKthK/wjCh1G4P32YP9B83q/PpxTuzFWZKmWuJ+PFT9ccjWEEDwuZttz8KXl1kv3lSiSkOOG29vpM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5332
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear Simon,

Thanks for the review.

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Sunday, 30 July, 2023 11:54 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> edumazet@google.com; netdev@vger.kernel.org; Zulkifli, Muhammad Husaini
> <muhammad.husaini.zulkifli@intel.com>; Neftin, Sasha
> <sasha.neftin@intel.com>; Naama Meir <naamax.meir@linux.intel.com>
> Subject: Re: [PATCH net 2/2] igc: Modify the tx-usecs coalesce setting
>=20
> On Fri, Jul 28, 2023 at 10:09:54AM -0700, Tony Nguyen wrote:
> > From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> >
> > This patch enables users to modify the tx-usecs parameter.
> > The rx-usecs value will adhere to the same value as tx-usecs if the
> > queue pair setting is enabled.
> >
> > How to test:
> > User can set the coalesce value using ethtool command.
> >
> > Example command:
> > Set: ethtool -C <interface>
> >
> > Previous output:
> >
> > root@P12DYHUSAINI:~# ethtool -C enp170s0 tx-usecs 10 netlink error:
> > Invalid argument
> >
> > New output:
> >
> > root@P12DYHUSAINI:~# ethtool -C enp170s0 tx-usecs 10
> > rx-usecs: 10
> > rx-frames: n/a
> > rx-usecs-irq: n/a
> > rx-frames-irq: n/a
> >
> > tx-usecs: 10
> > tx-frames: n/a
> > tx-usecs-irq: n/a
> > tx-frames-irq: n/a
> >
> > Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
> > Signed-off-by: Muhammad Husaini Zulkifli
> > <muhammad.husaini.zulkifli@intel.com>
> > Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igc/igc_ethtool.c | 33
> > ++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > index 62d925b26f2c..1cf7131a82c5 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > @@ -914,6 +914,34 @@ static int igc_ethtool_set_coalesce(struct net_dev=
ice
> *netdev,
> >  			adapter->flags &=3D ~IGC_FLAG_DMAC;
> >  	}
> >
> > +	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
> > +		u32 old_tx_itr, old_rx_itr;
> > +
> > +		/* This is to get back the original value before byte shifting */
> > +		old_tx_itr =3D (adapter->tx_itr_setting <=3D 3) ?
> > +			      adapter->tx_itr_setting : adapter->tx_itr_setting >>
> 2;
> > +
> > +		old_rx_itr =3D (adapter->rx_itr_setting <=3D 3) ?
> > +			      adapter->rx_itr_setting : adapter->rx_itr_setting >>
> 2;
> > +
> > +		if (old_tx_itr !=3D ec->tx_coalesce_usecs) {
> > +			if (ec->tx_coalesce_usecs && ec->tx_coalesce_usecs
> <=3D 3)
> > +				adapter->tx_itr_setting =3D ec-
> >tx_coalesce_usecs;
> > +			else
> > +				adapter->tx_itr_setting =3D ec-
> >tx_coalesce_usecs << 2;
> > +
> > +			adapter->rx_itr_setting =3D adapter->tx_itr_setting;
> > +		} else if (old_rx_itr !=3D ec->rx_coalesce_usecs) {
> > +			if (ec->rx_coalesce_usecs && ec->rx_coalesce_usecs
> <=3D 3)
> > +				adapter->rx_itr_setting =3D ec-
> >rx_coalesce_usecs;
> > +			else
> > +				adapter->rx_itr_setting =3D ec-
> >rx_coalesce_usecs << 2;
> > +
> > +			adapter->tx_itr_setting =3D adapter->rx_itr_setting;
> > +		}
> > +		goto program_itr;
>=20
> This goto seems fairly gratuitous to me.
> Couldn't the code be refactored to avoid it, f.e. by moving ~10 lines bel=
ow into
> an else clause?
>=20
> My main objection here is readability,
> I have no objections about correctness.

Good suggestion. I can refactor the code and remove the "goto" statement
as per suggested.

Ex:
if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
   ....
} else {
  .....
}

for (i =3D 0; i < adapter->num_q_vectors; i++) {=20
.....

Thanks,
Husaini

>=20
> > +	}
> > +
> >  	/* convert to rate of irq's per second */
> >  	if (ec->rx_coalesce_usecs && ec->rx_coalesce_usecs <=3D 3)
> >  		adapter->rx_itr_setting =3D ec->rx_coalesce_usecs; @@ -921,13
> +949,12
> > @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
> >  		adapter->rx_itr_setting =3D ec->rx_coalesce_usecs << 2;
> >
> >  	/* convert to rate of irq's per second */
> > -	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS)
> > -		adapter->tx_itr_setting =3D adapter->rx_itr_setting;
> > -	else if (ec->tx_coalesce_usecs && ec->tx_coalesce_usecs <=3D 3)
> > +	if (ec->tx_coalesce_usecs && ec->tx_coalesce_usecs <=3D 3)
> >  		adapter->tx_itr_setting =3D ec->tx_coalesce_usecs;
> >  	else
> >  		adapter->tx_itr_setting =3D ec->tx_coalesce_usecs << 2;
> >
> > +program_itr:
> >  	for (i =3D 0; i < adapter->num_q_vectors; i++) {
> >  		struct igc_q_vector *q_vector =3D adapter->q_vector[i];
> >
> > --
> > 2.38.1
> >
> >

