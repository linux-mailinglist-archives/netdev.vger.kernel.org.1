Return-Path: <netdev+bounces-19601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D3E75B5A8
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993351C213DE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3313B2FA50;
	Thu, 20 Jul 2023 17:31:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B42FA4E
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 17:31:40 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDA21BB;
	Thu, 20 Jul 2023 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689874298; x=1721410298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SU5htOu18kuS7rZUThT3WqetxDJ/PMfgKkpbK5Kfn8s=;
  b=FAtRCxxDwNvwyBRX0BMJA/P2G69WtfrWoom88t9xzPAajCAIkKkKoeCG
   pwZgvkS7K6Q/DlJQctKDGCCu8/VNuQ+XIpGf9gRua/GEeWfhPhaP0399B
   iajverxRCdmtFwx5sgdlboGbHwzbEhFmV5C6BjNoy25zsDnltCWhPuX1h
   Thz/Gqg2sud8M8kxkHvIUmD/HRSsq9hEwGv30puWuruWZbrsAhx6NrmV+
   SlicZhxFVwWWN7HoSEjoR131OHzu/oIzPJZItGyAVldNlIOTHBNakF74/
   Fcf6EU/8u9chy3NOjD8O4mIe8KjxnEzSi9O7rR5Ln1v2VNA5Lnx7cScn7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="453191744"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="453191744"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 10:31:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759657374"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="759657374"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 20 Jul 2023 10:31:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 10:31:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 10:31:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 10:31:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mu6lowzmUbeI+cslWZbX8GXfOM5iS3jkaQfmkZCo0PaLFiv5edWY4uroiqvHvIJD0XzY4ySpRTRIwoABt1lpUOvCuSFTtP1vppSRW53x6gYaRuY82tXQBYxuUb5LWYf8qwL9SS9kKw2uNUDIh/fRZwi+7z6mgoE8p38+UT5neDaKv1lBHQPHlCerzADgnXJR0N6/E2ASQqaFzL9d2nsy26CdK7VYIEkMZE3gG4CWj99+kHVXK/7rG+OMRE8yuBJRAlgdGzBNuwrA9PRn2iHqIdLzfS+7NNGsgi0qcXn4cz0pLGURr5KM3i0YUExlUHtuQUYHK7H8ycI1P7Q4gAZkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCNZ1N/9GCUsjyD0j2vFlm0z8mm+gESXtIer5GQvXoo=;
 b=S1bHwz2bQ22uMarvg5AUGbqsB9k8B9wrxetAu+dKvUw+9LAiD6hwt0s/5Zwqc4asg7c7pTZmx7m6pKYsSHDDBnt1ia5pLm1D/gcrEEqfd2xZPgzSNt28xuMPOXmYjjGLhTBTeTOGo9zhD/k33tOZa8Chow23haf+G2K8LtCaQVcHWC+AbMKXngCW5xxxAmg0TVSIJVJbbx+abaDZ+CfE1bA6ls0b/XmVnPN5YMVzXpPZGaE3GOrj2MLwj+LaQntblMtfYR24NTPoLSk2+g7iyOgKKzL1V+nEsS9ubPHzCK4lqLKCnoqyllWEqSy+kVP7auAOqJyHwAbSmTGU+zplYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CY5PR11MB6343.namprd11.prod.outlook.com (2603:10b6:930:3c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23; Thu, 20 Jul 2023 17:31:14 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 17:31:14 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: Jakub Kicinski <kuba@kernel.org>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "Olech, Milena"
	<milena.olech@intel.com>, "Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: RE: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Topic: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Index: AQHZuut81WSQCKaWlUanjhbbmuUufa/CsZmAgAARQbA=
Date: Thu, 20 Jul 2023 17:31:14 +0000
Message-ID: <DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLk/9zwbBHgs+rlb@nanopsycho>
In-Reply-To: <ZLk/9zwbBHgs+rlb@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CY5PR11MB6343:EE_
x-ms-office365-filtering-correlation-id: 1ed2cfac-f997-413e-70dd-08db89471e23
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6z6Kit6BaBeMNTgWuz7kIudpjidXjNZXUJQfZWB7TlR+rref6bNQ9dzOzdgUH6pJ1MDgCPez4n8rzrBQX/1ThX3OcaELAwUt1jwFuB2GeD510Q5MVn3Z5IKpYvYr44PjfJA79tM78nQDxOqgTzdSZl49oXalRl5ktaquq7gju8JWYZfNJIXUPuhyewuL1wdwPvsamzKVivh7jP5Jbm5CS5gyjG+HgTHZXbrV4VohTAnE5uPj0cLfHPSbIu1bFA0SBlAfpapTEmbHLOXRKJhCZF6C6DeeeEKNMMBZVeSkYkWz7JODrrB1YIQBdGbUoN9VoQo6f2AvgqQ9G/cWYsgI9u6yKSp4HGX7qtcb5mrcDJPEsGN0DCItHR+tpFj2bCRP5bcBRTd+N20rUhAZhFC5Yq+Mo9UcyVWDTPCVVdPtHSGK3aVfSC3lQfJ27qY4J9s5vuFAxCgvBm18iODyQwiXO5oIDt2I0ihUtpuih3SEJcnkDTwXVMROxlZM1Ez7bwFhvpy77no0xFAWc8sxfM7mBnVKTpeNHWSMwZHAIYwsbB7THRw4+R0hh8LjPQ9ROHsN8I36WiJgx9RwWRvrMM3yAhLPTyZXSt1a+LsyxhyCJ4HoiQST20u6w+346F30wV+G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(86362001)(2906002)(38070700005)(8936002)(83380400001)(33656002)(8676002)(4326008)(41300700001)(52536014)(316002)(7416002)(5660300002)(66946007)(38100700002)(122000001)(54906003)(66446008)(76116006)(66556008)(64756008)(110136005)(66476007)(186003)(6506007)(26005)(9686003)(82960400001)(478600001)(71200400001)(55016003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vod1ZcI/88oFvG9i0UTLiAnP8CYnsd2Nsg+eT7F8HXXO7JYuxwPq2CaG2GYz?=
 =?us-ascii?Q?LSbVrZHZdnVIN/+vjwNrEpzSFPjAy1I/7nJRKqU/B5e2Lx8ecBFDcwXSMSyY?=
 =?us-ascii?Q?akpTUPKP+TswEBGAtHmRr7iHhM+ZLd9twJdzyB+lbfgHEw6wNVxgrp8ncQBF?=
 =?us-ascii?Q?m1Sru0lNIhGFpjodHWWw2nq8IFXSsbHpJ1Gy9tvCt93CmNkMnirEwt5VryBd?=
 =?us-ascii?Q?O94/sxgBQqDxM6ER5YSagxWpDlvPBS7AUp6hNbj0ON1nUIJJ5trJNt9YYPd0?=
 =?us-ascii?Q?GS+Jk5H7jO7VBwLq1BrkeNtqGD2tWRIHpvrFBNOZRqP/X6L1BGGSxCRqkslW?=
 =?us-ascii?Q?s5KKyyyWocLEbU9Q3o6/F+8mDeBbRJzd42Rh4bmNQ3t9LnWkdo6nROSxqcgb?=
 =?us-ascii?Q?TwIsxPMtSkJ9amUlAXUZAiqgHOxm+0lV/tZK3IHC8zTxUyQL4gXICu2quI6M?=
 =?us-ascii?Q?UHFdN/iG1puvmto9suTDmP6JwshKQVoxFmNvvX5tXaGuQjyLeJugbqo6CS73?=
 =?us-ascii?Q?xj9cYUgXhbVjD55du+5pqoFLYeJnP25uPm+OQ6iXZPLdVjHH/h1aKwZxXJOr?=
 =?us-ascii?Q?NyZd42mZppVqKbY8k/Wquk6HKVjxBDpDf0PQVJHrwVx5/mhm7PYVe2a+zAfs?=
 =?us-ascii?Q?ChJh2oLmRxtFhHhxHNEbcBJe5eu/77c/f6T6No5XuEo1kyjKEPI6d4Q1Yw1r?=
 =?us-ascii?Q?PMu0gYIsjE+eRB5jvNTGGYNjVx4HnlJ5tz97+iQFNTObcoNfDSvYOWCqNmDM?=
 =?us-ascii?Q?yCaqhKeLemOg3i/pmEd1GDQmNbrCXum3pTmIA063khfMMt9tZ2sIQ0nmWODY?=
 =?us-ascii?Q?0+CxKrDROpm4nV/pa2QW1+wwleMbKS07L3ZSoIiehAY87jaTwYUXIAHAZLgY?=
 =?us-ascii?Q?6DbeMfXcF4hib0yOS1Eoc6WnZQbJeXxhIzxE3NGBJ5YNNnyOQUnZ0zn/lYOA?=
 =?us-ascii?Q?p5DR87Wp51YvuDKkQoIoSSkllcgGEGpWlX35Z9lVKoA3hIs+14OyNWzua7XZ?=
 =?us-ascii?Q?O7Wg881Z7LhCIxmu6ikADxniXBBYtUXqMoitzeCwSRgwpLk7/oTErU0IApBG?=
 =?us-ascii?Q?tz1NCiowUTy+PKEMYk6NusJcV1T9IRkkV7UU8MTsAmu5VnhmVhZynvmThJcO?=
 =?us-ascii?Q?8JpnK+2ESRsJ+DveswCjj3/CMiX5HEtPQqzfn2Pbd4O3MsHBXfUunXIkOoMb?=
 =?us-ascii?Q?/cAYVXU+OlvFfAbko92jD+B6rRkJtJFNH09E1+H1Df8VQCTQboA9MNT0fSmM?=
 =?us-ascii?Q?JO9v0RQnLFRO5yEMclXe0spbO07QeNe/qNYLLn3E0CKp7mD0z1d2Bsnkg7dC?=
 =?us-ascii?Q?ywIVCBl46QbzbYPpViyP60f04slZwkdexE/V4/95T5fcmmErGZOojSOPjP6K?=
 =?us-ascii?Q?MNaRGsIakojsGGFMATFlxkN824qsxy6p93ynbdLQS2eT+hDxFxWEqytjaUUK?=
 =?us-ascii?Q?3aXrhNHTp2SeKr+KJlXashwijHIqK6951aMk3Y0mmU/vLRsURVPE+KoJibfB?=
 =?us-ascii?Q?xVRyDBs9dSMAOZvJ42+VhG/kg0AT1iJt/UsjZzQsffKk1r+5OuZwXyt/+Tz0?=
 =?us-ascii?Q?RhCnMs2dhpU1JgCl0L+VMzEMzQBVH3cCxx168n1OoCEEWXi6VUxCvxurSuUu?=
 =?us-ascii?Q?9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed2cfac-f997-413e-70dd-08db89471e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 17:31:14.4281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4ZnLbRq/ykOp1nZ1jlDPuud0B06N3z1ZbHlxPGjD322E7N9bGDTOPuETH2K5p2TunGt4L2JQI3ZfdShmR0CF9Iq5sytiY7/zqjzIq03Myo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6343
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, July 20, 2023 4:09 PM
>
>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev wrote:
>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>
>[...]
>
>
>>+/**
>>+ * ice_dpll_pin_enable - enable a pin on dplls
>>+ * @hw: board private hw structure
>>+ * @pin: pointer to a pin
>>+ * @pin_type: type of pin being enabled
>>+ * @extack: error reporting
>>+ *
>>+ * Enable a pin on both dplls. Store current state in pin->flags.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>>+ * Return:
>>+ * * 0 - OK
>>+ * * negative - error
>>+ */
>>+static int
>>+ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>>+		    enum ice_dpll_pin_type pin_type,
>>+		    struct netlink_ext_ack *extack)
>>+{
>>+	u8 flags =3D 0;
>>+	int ret;
>>+
>
>
>
>I don't follow. Howcome you don't check if the mode is freerun here or
>not? Is it valid to enable a pin when freerun mode? What happens?
>

Because you are probably still thinking the modes are somehow connected
to the state of the pin, but it is the other way around.
The dpll device mode is a state of DPLL before pins are even considered.
If the dpll is in mode FREERUN, it shall not try to synchronize or monitor
any of the pins.

>Also, I am probably slow, but I still don't see anywhere in this
>patchset any description about why we need the freerun mode. What is
>diffrerent between:
>1) freerun mode
>2) automatic mode & all pins disabled?

The difference:
Case I:
1. set dpll to FREERUN and configure the source as if it would be in
AUTOMATIC
2. switch to AUTOMATIC
3. connecting to the valid source takes ~50 seconds

Case II:
1. set dpll to AUTOMATIC, set all the source to disconnected
2. switch one valid source to SELECTABLE
3. connecting to the valid source takes ~10 seconds

Basically in AUTOMATIC mode the sources are still monitored even when they
are not in SELECTABLE state, while in FREERUN there is no such monitoring,
so in the end process of synchronizing with the source takes much longer as
dpll need to start the process from scratch.

>
>Isn't the behaviour of 1) and 2) exactly the same? If no, why? This
>needs to be documented, please.
>

Sure will add the description of FREERUN to the docs.

>
>
>Another question, I asked the last time as well, but was not heard:
>Consider example where you have 2 netdevices, eth0 and eth1, each
>connected with a single DPLL pin:
>eth0 - DPLL pin 10 (DPLL device id 2)
>eth1 - DPLL pin 11 (DPLL device id 2)
>
>You have a SyncE daemon running on top eth0 and eth1.
>
>Could you please describe following 2 flows?
>
>1) SyncE daemon selects eth0 as a source of clock
>2) SyncE daemon selects eth1 as a source of clock
>
>
>For mlx5 it goes like:
>
>DPLL device mode is MANUAL.
>1)
> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth0
>    -> pin_id: 10
> SenceE daemon will use PIN_GET with pin_id 10 to get DPLL device id
>    -> device_id: 2

Not sure if it needs to obtain the dpll id in this step, but it doesn't
relate to the dpll interface..

> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =3D
>CONNECTED
>
>2)
> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth1
>    -> pin_id: 11
> SenceE daemon will use PIN_GET with pin_id 11 to get DPLL device id
>    -> device_id: 2
> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =3D
>CONNECTED
> (that will in HW disconnect previously connected pin 10, there will be
>  notification of pin_id 10, device_id -> state DISCONNECT)
>

This flow is similar for ice, but there are some differences, although
they come from the fact, the ice is using AUTOMATIC mode and recovered
clock pins which are not directly connected to a dpll (connected through
the MUX pin).

1)=20
a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 -> pin_id:=
 13
b) SyncE daemon uses PIN_GET to find a parent MUX type pin -> pin_id: 2
   (in case of dpll_id is needed, would be find in this response also)
c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) to
   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while all t=
he
   other pins shall be lower prio i.e. pin-prio:1)
d) SyncE daemon uses PIN_SET to set state of pin_id:13 to CONNECTED with
   parent pin (pin-id:2)
=20
2) (basically the same, only eth1 would get different pin_id.)
a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 -> pin_id:=
 14
b) SyncE daemon uses PIN_GET to find parent MUX type pin -> pin_id: 2
c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) to
   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while all t=
he
   other pins shall be lower prio i.e. pin-prio:1)
d) SyncE daemon uses PIN_SET to set state of pin_id:14 to CONNECTED with
   parent pin (pin-id:2)

Where step c) is required due to AUTOMATIC mode, and step d) required due t=
o
phy recovery clock pin being connected through the MUX type pin.

Thank you!
Arkadiusz

>
>Thanks!
>
>
>[...]

