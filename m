Return-Path: <netdev+bounces-44257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED2A7D765B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86BE1C20AB7
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795B9328A5;
	Wed, 25 Oct 2023 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLnBEE70"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32E28680
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:07:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E0C198
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698268036; x=1729804036;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DkEsuQcKGLiRLPfmuUA9kohcwFt59Yavbr2jKkP+tls=;
  b=PLnBEE70GEzsoT2Nu0/4FmeeV/Fi8Lz90/u4U1/7atU5DRrgJv8X6U2T
   Np648Dsj5opiW3JMXk6vtCY36XRT3XgbR04nH5xS3b6oxEcA0uixCviP4
   T43N3rrRYt5g1Fs4qdziJAmDsPneaIxphQgray7/tS6SwXyIx5XxrR9/r
   pBlTef9oZ/rg2bvvGkhYpURf/8msdjpPjxlc4Jj72g1m+m+izxhCR4W4R
   sIwQHQviCh8ThyUA8zStWBgivxhtg91CUwsiTqAVRSsKp0LrQR2oNDZif
   hf4DUfYzwoFOy+JAxMRinaGXNrEZXnq39kCm3v2f08F7zcDyEELtHAMiM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="418523250"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="418523250"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 14:07:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="932502715"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="932502715"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 14:07:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 14:07:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 14:07:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 14:07:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 14:07:12 -0700
Received: from DM6PR11MB4218.namprd11.prod.outlook.com (2603:10b6:5:201::15)
 by BL1PR11MB5256.namprd11.prod.outlook.com (2603:10b6:208:30a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 21:07:09 +0000
Received: from DM6PR11MB4218.namprd11.prod.outlook.com
 ([fe80::1c69:1b8b:5fd7:2e93]) by DM6PR11MB4218.namprd11.prod.outlook.com
 ([fe80::1c69:1b8b:5fd7:2e93%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 21:07:09 +0000
From: "Brelinski, Tony" <tony.brelinski@intel.com>
To: "Greenwalt, Paul" <paul.greenwalt@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"Chmielewski, Pawel" <pawel.chmielewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v5 5/6] ice: Remove redundant
 zeroing of the fields.
Thread-Topic: [Intel-wired-lan] [PATCH net-next v5 5/6] ice: Remove redundant
 zeroing of the fields.
Thread-Index: AQHaAhpqxajGCJUWak6z3N4spGgWBLBbCgRg
Date: Wed, 25 Oct 2023 21:07:09 +0000
Message-ID: <DM6PR11MB42181D85661E95AD51136CB482DEA@DM6PR11MB4218.namprd11.prod.outlook.com>
References: <20231018231643.2356-1-paul.greenwalt@intel.com>
 <20231018231643.2356-6-paul.greenwalt@intel.com>
In-Reply-To: <20231018231643.2356-6-paul.greenwalt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4218:EE_|BL1PR11MB5256:EE_
x-ms-office365-filtering-correlation-id: 5460341c-a99e-49a1-829f-08dbd59e5a3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NLnRMeRNKil3XqmywEXxFsf2AYpNIbQZIaxLvRQ9Oq41/TPYzvt7VgaZvOTnJ3PqYk62nnkpuww70gwYYcPv5pfgIqLtsXeN9fIXZ06nV5POBhhd0/xtkMWh2UNPkP17g+XmlCTw6NtuUX5XvVTHAXSToemT80E5GlfGNLxI9EJAjepiuS06vgJ0s6RTc9u2A6l1s+M+iPNBr4PO50GbvcMlTJ88Esri8SysJgykg2ihxxtXJCxFhH9J9KhtT3XIDaqzTIA7ZMMuoUPsqxg+WphKvvSoT/QwQ4i985s+h/gdUKrlxcSSL1Bd8QJIlr5dciWMs5t8ETgVuu4RbEGm2Wl0wdGskjMoNTGSIW7yYPiixK0S0mRR4RAZCyTLnSVui6j8ysut6qKmynE3kTpnxle+qb5TqiJDQzrNcHWJpsBUTj91z3rRS4d37KXYzNZHnQNoJuBfyLcQkCH1wU3Hb+gkhkeX3NnfsAOGp7T8VYNLET+p0dfPLD9z8PBFJHYBTRqELrHGl5EiyRTYXIcPvyFVqd8QIFPNVRVwZ/ltUdDP1dmCJviUdLinp3lDcJjjt5mIbn5+wdx21aHbkD13XTiz+3ypjUINJstkdBogZDY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4218.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38070700009)(4744005)(2906002)(53546011)(55016003)(478600001)(5660300002)(38100700002)(4326008)(8936002)(8676002)(41300700001)(66446008)(52536014)(66476007)(33656002)(66946007)(6506007)(86362001)(54906003)(71200400001)(110136005)(26005)(7696005)(9686003)(66556008)(76116006)(82960400001)(122000001)(64756008)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lY6mWVZDj4VlBh7Jfx90+hxjO9JBfmaUFarD4TkQHPk8sVcrb8DuHBlsLlR3?=
 =?us-ascii?Q?/H4i2RNELlktzGJv64jWQAV+dOX9VMl+wPD/zSbm9XQU8xTnwtiqiqQ5y1v1?=
 =?us-ascii?Q?+ismVVip5YJ0XeRfIkxW2DaUBPoMjfNfCnrO3CRdxClzD60MBl71kwbDYr/7?=
 =?us-ascii?Q?xqriHJ4kYnOkNfIOExwxJv+LXOjFca382OauXOMKuKNYpAn20IBqgaSQxua4?=
 =?us-ascii?Q?PTN80ZFcsxqB1kpSOIEqHX0sG4UAHDdJDvM8vK9fBi+ypqTHNf7lBzCHdfaV?=
 =?us-ascii?Q?F4JBNLn0EWFseipfbXubWe7rnn/O4rL252JvLgcJeMFbNcaGEnzDYAA28FAW?=
 =?us-ascii?Q?n6qqdvu23q5MSABqaVBjgs0yVG1vByr9Z+E6Ndgvep3GWhnUiNX1abYD43ib?=
 =?us-ascii?Q?w5N3cjRCMI+A8M8j6Y4THwDH+qHsKQgl40v8YqHFERHW46Ok6WXT5FkuxMTa?=
 =?us-ascii?Q?EDv5/xcGXLoCCvQfmrTsRqzEzVhVWCccoIdFHbAZggijuDXozyaYKTGnpPZ8?=
 =?us-ascii?Q?UAUxPKO2mZD9+Fw2xP8Gupsk+6B39FhzZYmiIqi2/H3P1AOE1an8Qnj403BS?=
 =?us-ascii?Q?l6NzCcVFtc+u+UrhkrWwbu7rF5fT6zkxV6ceu1au6XRhjutCnLhgGFnb9CRO?=
 =?us-ascii?Q?tGdfKhWqo8kiOXxtaAcrNpJK69ZzpFpPFc7vgDT/gPIM7L2PXP4EP4q8WmrL?=
 =?us-ascii?Q?cfBbJnntao9tlJUIgqG6jUKpCJDrK22r6zL8gTlfsqBxuWBB90rcmWzOCcXT?=
 =?us-ascii?Q?LaiYXEjvYUJk9bMFE7k9KSILJRTKlJCPjVcEUzNzfj3sq15VnU4ySIOItMFz?=
 =?us-ascii?Q?dE1OxCxFNAlF4uDoPE4784s2Tzun2fGd9D8voevMnbtBWtVYIDH3YRzPZPUr?=
 =?us-ascii?Q?hZSL8loEV4rIKWxZtmZHyGH/A7J4LUbWbut7O7NyfrOgB5x61Jr+Xq0G3m/M?=
 =?us-ascii?Q?367rDETUxHZ5N8DlJ6VLDBbHiaJakY68ODT973f0ib17vLKFJxkhSgisFk8v?=
 =?us-ascii?Q?1AqRKp8Rc4IFrpMl0r6aWKLAkWBPxjGMjj1pNATUTU87Cx8ZCcu5FjJrZZBw?=
 =?us-ascii?Q?eNd+mf8BoGdWcoHyCdMMukzq6gqN9P6vdmjS4rbLMiySXXFKQ8ac2OLygwmt?=
 =?us-ascii?Q?NOOKE2NK1ruoT4C6DrebDYVdY7lCtHxAMLseeS9fXcoH1tPuH37V26b0N9Ue?=
 =?us-ascii?Q?74DIx+Zuk72uUOoL9bSaQWufaPlQ602nqAvsSsyXvYq/UR8g+wAbgJOtjRaI?=
 =?us-ascii?Q?BqRfqeTPaJA1JgTSA/H2orRT81+vziJwr85aEEdxefhPRxpK7/992Luhk1Az?=
 =?us-ascii?Q?v4zsiuvND6rp9KUO49fn0KDLHHdR0HbJFRjGuNlgpPMm7K+Am7zwwLeQDT7L?=
 =?us-ascii?Q?IQaShAeIB5VxWY0FG4Uscumx6DuuQBEqz7YFT4o1Hzl8cC85QaEpExwisnyV?=
 =?us-ascii?Q?ltp9WD/FPA3KAD9X4S0L4ciPL5toNYlMR2+b+7Mpo1db4Oc4oBiZJD/X7Zv8?=
 =?us-ascii?Q?2n7Eo9VrraPnML4SLxnArU96odM8BQo8LlIaEhPpGXI2TrsuAEBQexb3YJ29?=
 =?us-ascii?Q?smwXk0p7umUx1vDIZi6A+bpaXitFieBD+f96IvR/?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaNJPbmevVaJP40V6X82ruqm9k0f46TN1bBB/RV9EgkovwzH/lENiYKoXz1bEA43Qjhr1GldhXaXXjKjgUX+4WbKOQXAGF16GHCdEqnW3Fj7eQj+6+hMeba7DwCJfCIJcoAYXk4dBIl2Vy25HQh9lpqt3uw3GIUSogI71mHBQhDPUoN8VQ6MrdL46UZi9D3Xg4S/fd/NGO6nPO0hyOcxyXuNbyRO6U+WpWl476UF4c4vR+WA4uIE9aJIsmJ1gj3QxC9Sxu0rS+8ZyUGzIkupw+6VHVM62BMYJ9RkJFtNpIxxmL9nE2AktgYR0x3I4BI13FTRid0KPQqRn6lJXo15xA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yq4rgQ1dgKZDnutu6R5VdRknX/ljAU0HHsgExXYp9vQ=;
 b=M1kIgMZfrPh+r5Cu4/XFalZbY+jCMcgjIknRBxrn6AnNJTifwJMw+yv2Mv27FYd9cTM+LER3X1H23BO1xdNFiZVYOhBOvQLHVE/+a1I3CCV+d6FGtJDnAJeBFUvPj+SQjN0lB5u74t+di5YbwWZKTfsTf6Ya4WV3UW1IC03QHLrX7dsj6f1wz9+b6eagDVolEwrr8IS2VkvVYMzTuIuTfyNrZbNWasPOn4auNXbpvxdVCr1gDgO3WU0HVs0U+s4D9xNYA+9cQJdTIBZYUHlMESnkiDKnddupXcoWfjJngZmx96WQSYocpvAdqNfa6ixHBUwkXubmMK4T+cPcEkpaPw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DM6PR11MB4218.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 5460341c-a99e-49a1-829f-08dbd59e5a3c
x-ms-exchange-crosstenant-originalarrivaltime: 25 Oct 2023 21:07:09.7949 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: Ovc7N/HfjGmiU2nHTl0yHMUK2TPHemTw4AO/XwHShXCLWyELZPfnfwLRBh/EzBvRINXDbuW+DlZFAlTVqZPI2wX1ywbJFukpAiqhNtgKtyM=
x-ms-exchange-transport-crosstenantheadersstamped: BL1PR11MB5256
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
aul
> Greenwalt
> Sent: Wednesday, October 18, 2023 4:17 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: andrew@lunn.ch; Greenwalt, Paul <paul.greenwalt@intel.com>;
> netdev@vger.kernel.org; Brandeburg, Jesse <jesse.brandeburg@intel.com>;
> Chmielewski, Pawel <pawel.chmielewski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; horms@kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v5 5/6] ice: Remove redundant =
zeroing
> of the fields.
>
> From: Pawel Chmielewski <pawel.chmielewski@intel.com>
>
> Remove zeroing of the fields, as all the fields are in fact initialized w=
ith zeros
> automatically
>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 54 +++++++++++------------
>  1 file changed, 27 insertions(+), 27 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


