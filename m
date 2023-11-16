Return-Path: <netdev+bounces-48257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335117EDCAF
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 09:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F4C280F83
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11E110951;
	Thu, 16 Nov 2023 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+v6rgFJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA553101
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 00:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700122352; x=1731658352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y+T1xBolLa1hkwIAl3n5qLN5TVvbShwsE4c7JEb1LJM=;
  b=n+v6rgFJ5q5sv1Li3MfqKsOrM/iFZjlEHZ7uao56L/f0VbNMRiV6MnuQ
   kOf697LtVpzJ2ugLKPxbzQA2S3FljdQ3yW5js+bzPn1ydFN3MbURBIc3F
   wdsBdBVkPsmqSlovKqGK19GV4/6YnIWAXX1ILInWppldtmntJhXQhRtcp
   s6cdvKdJ/1frOX+CIXMF3UHXmeTVWwQGkb0nVvCZ+D6Uwbw8gCm5lieUs
   yy9RVsvuLHbjGjthRBd125PTSeQI+E7Y3MEur/kMBQ5CZYFrir2RRmRIk
   NKg3uehX2raAtzI8qgv4o5LW117YCTnH70WvMrpYkgQ9qXFDn+5YFX2Tt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389897493"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="389897493"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:12:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="6664060"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 00:12:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 00:12:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 00:12:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 00:12:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 00:12:07 -0800
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SA0PR11MB4589.namprd11.prod.outlook.com (2603:10b6:806:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 08:12:06 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::b9ce:466:8397:a2c2]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::b9ce:466:8397:a2c2%5]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 08:12:06 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 2/3] ice: unify logic for
 programming PFINT_TSYN_MSK
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 2/3] ice: unify logic for
 programming PFINT_TSYN_MSK
Thread-Index: AQHaDrAhmplrLoQjR0el2d4q8cIdtbB8qKKw
Date: Thu, 16 Nov 2023 08:12:05 +0000
Message-ID: <BL0PR11MB31223D1357CE8CFA91C074C4BDB0A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231103234658.511859-1-jacob.e.keller@intel.com>
 <20231103234658.511859-3-jacob.e.keller@intel.com>
In-Reply-To: <20231103234658.511859-3-jacob.e.keller@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SA0PR11MB4589:EE_
x-ms-office365-filtering-correlation-id: b734b1e9-fef8-427a-625c-08dbe67bb8df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IjZLS19r0MPDEH71dJ/yUonoJ4+2DCP8U5GyR1Ljq1imcie3qTQmYctYDAQc2FBujDj4wANYJ9xNfuBP/tcRy75+ZaGNfH+PUE+ORd/c9Z30kYmmOGTQff15DKSQAG1JIfZn12Y/+ffg4i85ZEdS7WlxG0jon1KuRDAlYWJptrEb+xXy+ryPKYTsQrWjldHVlHfytkKvw/6AXM4xUYUM/hz/xbYY1ZBJBRFt0psugc72WTq/WU3OD7qlegRx3gzsoiemx2xIxi71mgQwXiXYum/D86jlox1eT+fDPnhlI5bF7Wcww//KW4GpsQfS+jWJXZQUb8vfFQVPGYqPWLVPF5YaBVCXy8ZtILiTGq8bJSJvNhWlB6X6CPENY9GLea040mPZ7HuibBp3phWuu7TTrxGeRYLtp9KygpW8e+i5S+QNuogyWpkK/isBtY96IFLUNUZz26OBGL+TfoQHok0WYTHCjWh6bjOm7nFBvuoeiQLLjYwPG2Rd6ahiq9rEESnVRlgXktPTzafpWM7OcrOdnn0cSRj6qEPANY99bgZ7NKGARJbSFmpKvD7X72t3M1u9IFS+ofJvItpuJCzfRVLfHwI9bxsYahfghNLSmZX68ZYr2SjOzYhjnGuGa5dcKX+b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(71200400001)(76116006)(52536014)(4326008)(110136005)(9686003)(54906003)(64756008)(6636002)(316002)(66946007)(6506007)(7696005)(53546011)(66476007)(66446008)(66556008)(8936002)(8676002)(478600001)(38070700009)(2906002)(55016003)(33656002)(38100700002)(41300700001)(26005)(122000001)(107886003)(83380400001)(86362001)(82960400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2fmSrZu/epMp4fEYfhjL8MrzgkVJMafWUCx2JhRZAEUhfsZ/L27/CNBNEciT?=
 =?us-ascii?Q?mikJTsC7jtWsx1eyGtYBlily0tFtOFtTkZDPx6WZEWKmqSvblaniBJ1dAe+r?=
 =?us-ascii?Q?pnC58GLVKxYyTtgE7dRSY6TgJRSBg4vMl0LUOkAtmM7fQy8mjIwvdPZiUFe/?=
 =?us-ascii?Q?Sk3uv4+Ewq/uUySRnt+yR5VKwxeDJvidAwVweLvxG1/RW5QDj3bztSR6QC1t?=
 =?us-ascii?Q?bYKqnTn4pxhLMPj2u379sAdG20gBhJSGoswT1JAndzDmKI7bc74G1CcWDIct?=
 =?us-ascii?Q?ALC+iVxWRcNt6l/5g301AzOiz7xVQ5kHnt+rfDQOoBWoxSqkQh9uYHKQ+0uH?=
 =?us-ascii?Q?1I6sCSTSV97y39iQnPWccclqckkxS5AjYao2qbW7ITz6q23CKOnpGDYxFClb?=
 =?us-ascii?Q?4PZtBgWFE1j6JL8RHspBlPFmA8AyGRveBLlZDB7DcvG06oQY9G2ocnCU3xHX?=
 =?us-ascii?Q?mMH5/ZlQgzQumf7iUXx9iYZh1f17RHAYWFphllw7PR+n8twyGpqYPg34tzxN?=
 =?us-ascii?Q?VjLENaZcVQ4PH6L5PNkoPnTn8So5LvKJTJ6oLpbEbB6sKjyT0Q+tVjE5MV2U?=
 =?us-ascii?Q?zkP2Rc3nQB/nHOqXqbCOpWUipF9i0hSy9noTNLbOFBh+MqoxjhODarQ5B8pG?=
 =?us-ascii?Q?zRrqXFBYZLapfad1EgKfj6+STsCmtMHX1SA+7EPrw6JfzdymJxjjvHXsnYEt?=
 =?us-ascii?Q?PVRjahXBltxg77ULwWStjcth6PWaebfI90Jm+JXFxQWBpRYIZJ9k12Jg4Yp7?=
 =?us-ascii?Q?lLQFwTx65XlHhx+dZiwL12siNuGdwo71J9zUVNwhCCgq9ZnPqZFgKpY8pyHy?=
 =?us-ascii?Q?Lkf2eWdQC2AlZtkXDfKcYHeyqf3YFi8DEYQv1H7J3bgpBDXFVP8MEjzPPKSX?=
 =?us-ascii?Q?tL2vxZmJ1+8tjxrn8KsEmyn5qoufUbwlOdsnf90cnnfvwsghnlguVm2zeiEA?=
 =?us-ascii?Q?kHfratErPJimuHyCULelvNTTBQhDTHVlp12/fHOYVTqplHQvXD0ZE0SeeA+i?=
 =?us-ascii?Q?xghYDJ3tIW8wWtVhDdI23/JGZjjr89rJCIt4rrcNMH4nroWMapIzFGtqhbqJ?=
 =?us-ascii?Q?RxjoLYz2ya1yjx0Ov42Jyvb0jCD5MRpk3dI0dDZwhC81K/I/go5PTRN5fPIt?=
 =?us-ascii?Q?3Lh8ttKPsUNeo6LBj9PA0g/qNj6Kw4MjsUgaW4OZDPrz/lRWqXr5nLsc5nj+?=
 =?us-ascii?Q?qK5Aph2D59E0RyrBWhbwVySNjvrSPJhlIuBlVUkdXUVSYlIqJxap12SPkpia?=
 =?us-ascii?Q?YDqEyeleCZChQpO2qI/8X8bMPS5uV9gsqxbXam+0b1PCgPMNkPZKvnwES8+A?=
 =?us-ascii?Q?MOW7GXCqBeyQpq7vduXle6qrbRcwju1tKCI4x5ePQx1dxoj6wtStlFxAU3JZ?=
 =?us-ascii?Q?RZcIOpGInx7VLJknBdSG561qn7xoNE4JgCpQZ2HhsE8Vjt9O0IqvN8WTqpGs?=
 =?us-ascii?Q?u5jdCBQ4h1BgOmGje2ZbnWGzORS7E1LEWv78qPRXmXY6pylrYHrTC7BELEsS?=
 =?us-ascii?Q?qSzQD56/MEXuRMsitNuUBjXbIkBO+M1XiTRrgIeLJtVK5GJQJaysuUmPaiK+?=
 =?us-ascii?Q?8M6ng9jEfUMLO64LZ53PO6VAnKRfrsDKzDTtYpiCU9MyCiEqmO9E+2cxD6I5?=
 =?us-ascii?Q?Yw=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvkJsCtbD0dme4Ltgx2niTmc3qGm4AIJJXfQ/u4oz9j91oWCOOeL2mdAS3Wr+LjTXIm7mBp8iotLCUjWm7gFfp+IKe4gzOVQru7n+FE6/DH0CtLEOKuT/lUyqdM4cGE3Er6Y9KoJ1+Hfa88/XpLTu0bHvu2XbHNpEH8fntFwk6F/BSU2nv2m3dqfd6GDDgZSBTJQ99Xueyd+CNI9Tjf8NZukQrcj5Ia4BoOErz5yECC1UMAJlL1M1wNNrtJg6E0U0jOqgMcflNaUE8TCujFJabJ0l+Uy9mWRx5/KNiSMQja5wik4PFW5Lq1R56VxWNP13CQuOhzQvEqMPI1AJw1gDA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TV4/fvd5sQ/72opKOKEnD/Cf3caTI5+xUWFs3SGtA6Q=;
 b=dF2HxnmpzrTUNpPGQ3UXCGJfAEAWsZNuGxEWu5TPNuSKr5CwnuLeh2e7Q7QVaAJGZJ/+otMiqTnolJ6zjzTcTGpFuiQ+uIfE6FN7x+Uyn4xnrq59MxUURfTdP+4RrwgNFD1JznWJQBZgcA/yeYxwEme/FZJtJOtF4BS92ZZY+uMCokaFYI/3KgvayLCXmO0Poo6feVmAjA5fItIpMy7quhBfMo4T9NMWTqIyPC4KCorc+vGguyoL+mUeeNwsDpfDZyR0RCla2wjd/JrrV0G2eInTDbzj5+iDsDUQmF4YjNgQMXm/XUUTcXB8qN0Lx3wt8V0hgm5zuULvmCwJ2mpo5Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BL0PR11MB3122.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: b734b1e9-fef8-427a-625c-08dbe67bb8df
x-ms-exchange-crosstenant-originalarrivaltime: 16 Nov 2023 08:12:05.9929 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 3CPbsaCtDLEk+YmE3c7pWPqkbxhF/D+VsEk3j/iyF7tWcKUhjNcAryjnXtBx/YUKr+RnfhGFcmb0m06SLBQGCgzSKnVjbHz7dmcXrjNMaHBLoPwD+yBjd0vz+nKLOn+5
x-ms-exchange-transport-crosstenantheadersstamped: SA0PR11MB4589
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
acob Keller
> Sent: Saturday, November 4, 2023 5:17 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; netdev@vger.kernel.org; I=
ntel Wired LAN <intel-wired-lan@lists.osuosl.org>; Brandeburg, Jesse <jesse=
.brandeburg@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net 2/3] ice: unify logic for progr=
amming PFINT_TSYN_MSK
>
> Commit d938a8cca88a ("ice: Auxbus devices & driver for E822 TS") modified
> how Tx timestamps are handled for E822 devices. On these devices, only th=
e
> clock owner handles reading the Tx timestamp data from firmware. To do
> this, the PFINT_TSYN_MSK register is modified from the default value to o=
ne
> which enables reacting to a Tx timestamp on all PHY ports.
>
> The driver currently programs PFINT_TSYN_MSK in different places dependin=
g
> on whether the port is the clock owner or not. For the clock owner, the
> PFINT_TSYN_MSK value is programmed during ice_ptp_init_owner just before
> calling ice_ptp_tx_ena_intr to program the PHY ports.
>
> For the non-clock owner ports, the PFINT_TSYN_MSK is programmed during
> ice_ptp_init_port.
>
> If a large enough device reset occurs, the PFINT_TSYN_MSK register will b=
e
> reset to the default value in which only the PHY associated directly with
> the PF will cause the Tx timestamp interrupt to trigger.
>
> The driver lacks logic to reprogram the PFINT_TSYN_MSK register after a
> device reset. For the E822 device, this results in the PF no longer
> responding to interrupts for other ports. This results in failure to
> deliver Tx timestamps to user space applications.
>
> Rename ice_ptp_configure_tx_tstamp to ice_ptp_cfg_tx_interrupt, and unify
> the logic for programming PFINT_TSYN_MSK and PFINT_OICR_ENA into one plac=
e.
> This function will program both registers according to the combination of
> user configuration and device requirements.
>
> This ensures that PFINT_TSYN_MSK is always restored when we configure the
> Tx timestamp interrupt.
>
> Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 60 ++++++++++++++----------
>  1 file changed, 34 insertions(+), 26 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


