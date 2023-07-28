Return-Path: <netdev+bounces-22453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB27678CA
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 01:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBFB1C20A61
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 23:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79EC1FB4A;
	Fri, 28 Jul 2023 23:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D176F525C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 23:04:08 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432142680;
	Fri, 28 Jul 2023 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690585445; x=1722121445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fmOphAdHQIdYGKM9TDi3EBNOQ31HJMECOw498Smq31I=;
  b=GmzykCJxfhuZV69oQborTEY+8QZWI3hiuzHSMB3TnQW+/STth9iL/2fB
   /49yWm/kGm3Y6ilHpLlF4+AtBNn0Jh8QGOrTPqwxStofA+J27FpIu0jnc
   Lb9GatcJS0XT08MPtOvdAR+WMuI4QwsEtiphiqID67Uwu3bgO8Vd8igpa
   QJIz/nPgcfvRX0CUtXHFTfE1QuAfD37Sjgfe/AQiuuSEjz4TZfqdvt3vF
   dxN3xWK2UxgdK4nk8afco35Kq9IFIFAvyI7HUsff4eDJPZ/7Tci3FlV2F
   +eivAWfe1ISAye+uEkJkV4v260OaJlqm9XARPi27i1jLTnKco/RQdVTl6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="434990431"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="434990431"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 16:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="721417854"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="721417854"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 28 Jul 2023 16:04:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 16:04:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 16:04:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 16:04:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ji5KefSH0OYCEWNefpWRcPi7CHAaRYjBJhCl8GgYzXa6pL15bbBkXRZVrU9H8ccPABER6VhIfNs/OwqHaifi96F2/ZUCl1B6D8OAneabXsrAomHDsbGkWGc5kYJpJQe2dTR+6O61ME2Y6cVkgsTLXzfNXsFtXd7yPfXlRTdJ49+dStniWDdkI2xFAjpKxU4Mc1VTAJDRRmatu4fGId1LFxIfFnEvezqMbKWpBIbdWTjZJ5ext20zcDI9Fl9Bvie5v6ClmIzYPq+jLu5r8ZCyD14AYryv/kvcL8ChhDJ780F84jASFYsdTwMfDJBRLn6Gribftu1ga/Y3tgOcuQWmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZXeXK97CD7bRRCmVnjL68e9HcNnjiiwK11wsp+CFGM=;
 b=mkRDrAQ9qiIoVL0A8dWJ95/SHqOGNBSixrIH07n5vgiw9QjzqHg4oCFsijjGK8wCu+LF2cvYdX7Tvi6Nuyrf8Ennr/eo5vI3HVsLd1vpMKKNGmMat1BbBE5y8q5hZn41nvUnWvWDBt5DMXZccj5zFLWCFeprhwZ7pg9fOb8/ESjry6+4eo0x4/nxIwB13kXw/f15S+gV6kBVj8MYnkRuPQ7/waYvJvsbRtPi2WEcWJ/+9uPhArBmGpG5OAwgf6bnU465AUyeBxahR0uiTGz/jMWo+suxjzbs2OA5TEmzx8CckQoRm9dAEWk7unruKxxPVzmMiDDcbgsrfiLUCxIA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SJ0PR11MB5677.namprd11.prod.outlook.com (2603:10b6:a03:37e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 23:04:00 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 23:03:59 +0000
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
Thread-Index: AQHZuut81WSQCKaWlUanjhbbmuUufa/EGiaAgAu/VDA=
Date: Fri, 28 Jul 2023 23:03:59 +0000
Message-ID: <DM6PR11MB46571657F0DF87765DAB32FE9B06A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLpuaxMJ+8rWAPwi@nanopsycho>
In-Reply-To: <ZLpuaxMJ+8rWAPwi@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SJ0PR11MB5677:EE_
x-ms-office365-filtering-correlation-id: 8c75b4f6-ad63-4046-6e6b-08db8fbeed8a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8hWS+JUKswZjbfry+zdyanFvE4rUu9TzDLyAKkdOe6Qjd09mwsKtqc3wA/h7F22FOovNLp5qMkpakUcThhbAcLl+ZQoF7MUJ4DOEbOq2z2earv3dM4GHuPUe+PgPGA6K0ebMWRJeDFDcKOs6CnuFe7cS686xH9rfF6llqX9dJ1fJwmqXdVXg+XsfuU+ZPJvnSv2C+761o6iPwYKZRz31RG64iysGQUH/JAZPy3nzoQFBIRTAVPte5lFnaD2cO8mTj8XQz6M6x5GAUyVdzGF4iA6SW+WG9jYb7IClaWhmi/UzfqmThImmtd8Ul3ckwRPn6hDR3A0Ssufi3HbelqolbWfH1hmdqPYycnu8TkyZqG8D6+CD+FvNe9Tu/K3KyqL8rzDDTgqq7u4ynEb6jQI7QBIT9ub25T80qHCbpKY//difSgsxiNKG8fVvKGBJLNDPIFgMX53TcO93xViWthMYezDEnC4+DyZBxWrrNM6AKK+PEtLLdYzEGK9jDjPaC0NSCZgJmYiCcX8Yqn2SC820fTQXIyKJgFiYaosATZewBizKP2Xy5QJD1kgSedwVoSpwL4rIQOsGgXDvhBnDCl7VDeNTd1et+Ehn4fzmHq+HpCC/N3JdiSfZLPDqZ6A9q56l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(2906002)(316002)(8936002)(8676002)(7416002)(52536014)(5660300002)(38070700005)(30864003)(41300700001)(33656002)(55016003)(86362001)(7696005)(71200400001)(122000001)(54906003)(478600001)(82960400001)(6506007)(186003)(110136005)(9686003)(83380400001)(66946007)(76116006)(38100700002)(66556008)(4326008)(66446008)(64756008)(66476007)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fRys6moq/6q/SzwO9y/8OcVwQTPKi8JyPl2A6B1X58FVS1yLRoRrBLpq2ZWz?=
 =?us-ascii?Q?/NHlzkQpJtmbAfaV4Ok/h8Ddz4+1RNV2rh9j5doO+l6zHN5oslQfmH9Ee9uh?=
 =?us-ascii?Q?bSC5Tq/tWRBarVlCmu5JEhJSxgADTW6Ll2lS3pLgvWppF9cvnzzrlo1WAeik?=
 =?us-ascii?Q?JoR4D1I8GqqAzfUyiGumzSYNONMV8rbwPMvjdmUtZKAd1gT7QuK7lZ39ZKpa?=
 =?us-ascii?Q?3t58jK8LIJBd/BG7oCfXCml806Xz3eAaLBLiOjiDOt4KPk5WZiUriI4QMtXg?=
 =?us-ascii?Q?NpbLZANu3YNo7qNq8Fb4LARPmKB0B4tDHTscxZ8l+Dl2VdwnpD5pb3OHqFf2?=
 =?us-ascii?Q?hXwXepHpurqAKhW80IFS9jv1uA+fZXuOpTh8nv767Bk7vcZFYWpZKhTGBj6D?=
 =?us-ascii?Q?BKln6UmU5RNJUifekJzw9V0Yg4io0uxEOF7L7N6ENJcSMDQTIjrrz6H4t3+Y?=
 =?us-ascii?Q?7QD/iEcoTn7lbQ1kHhRce31UFD9RXhQn6Qt8Odvbphs900WBne56SSSLGX5P?=
 =?us-ascii?Q?MfTKcdVEo206SN+vE95fgvpaBHFcJ1h2Xxx3OzN+rajjwegpQxytqnOWFTy7?=
 =?us-ascii?Q?JfzIuN4aMF0fpOT9Vsadf9notSPBHQ8n//tQwv5+ohrY0wDJS1SL7oiZgA36?=
 =?us-ascii?Q?mll3YtVO0VXxiGxpCNxp51FS+zSRpXXPgoYz1mIXI21Ptc7ZrCZw0cziKAC6?=
 =?us-ascii?Q?WPu6ZXYPdxYgRNBxUXpwi1n5NRr/JI//udQO2FgqDPnT41loFnaDscEcyIUQ?=
 =?us-ascii?Q?55IfEvA4+QDDHKOH6h2oHFA3Eu/aSWKJbGfbywLICu9ZkDzNDjtkdvCZkhjw?=
 =?us-ascii?Q?li9pz4P8/hTPGFzQ/WPAGtHyDivNwcFWGxhH8hnFoHN1aRASA0rSoX+3hu9b?=
 =?us-ascii?Q?eXdCcxYvHMQde+PHxz6dXr5wf0VkjTzJmUmGUGnvVgJQEWibeLwCfOS2UQDM?=
 =?us-ascii?Q?5T30W6n0qg4OU1FTSHTpQT5etVgaKzhR8Jzod4HsaNHcTsDFnP0hDerOS3Id?=
 =?us-ascii?Q?HnV78SeIKMkWQE6gSBci74KL0yzm2/EW2fqG9UIAyXdTXEaYINp0rNTJWdE4?=
 =?us-ascii?Q?6RMwMgRT4t1fQJjYXi4zVM7HcDLrgnxIlLNCRPzthPglJprr0C7AaviuXu98?=
 =?us-ascii?Q?RTeiLXIq/0+VHBT3c4+lpZIH/P/TArZ2yE1wNtqt/S6fkre2pva6iF/3Bs9+?=
 =?us-ascii?Q?lOkuKm0Iwx9EsVWWQaTTC1io/+ij6f3GYgkBt2/WvCVLOtz+O37gks9P//pl?=
 =?us-ascii?Q?ZWQG6RWSCd87epY3ll/7RhRcs7GUhZ/RTINZ9pSnXg2NtNQqPGFBhsPiCvpP?=
 =?us-ascii?Q?ksT/DaapsD1shs/rJfhwLcGV5yntSZ3UQ2PN8XwsElwIVKncrcXND/Ebey3X?=
 =?us-ascii?Q?BR+f3/Gxb4w47oKfjWXblsDqduwzT8kpcAEhkSfGw1NW+bMDbvnSDPDWFkj+?=
 =?us-ascii?Q?8Ci4qKPZ2w1919xhpQBzarnVDkRkItcNJX0uTVbRXNKSUt6Pi+LX5MU3Opsz?=
 =?us-ascii?Q?2nWXWu2bg+eSla+6Vebk1SbpscQVLoAaHsfRcUm7kSeX5Zzv1Yhwe579TiSp?=
 =?us-ascii?Q?8HIeOl0C7pt25SfwC20BXaFlwV3oBrrwp4ZZUSOEO/bLVhEEcL4Rmu++J+ic?=
 =?us-ascii?Q?Z9SmkuX0EnSw0fcqSJYOTyeUdj6EUxmrwrlU2ewPkYBGdTd6CxdtufjuGu64?=
 =?us-ascii?Q?5ZqSZg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c75b4f6-ad63-4046-6e6b-08db8fbeed8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 23:03:59.4361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvAylXW2aGkcyDl4modpEZ/s25+sa7CpsGJF+qMYCsJF/7dVgHauE9+zAWFqwx97bEcNsgABfJpW2gl0EN3sHzKRdYaA3OnsNo93NP5mu7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5677
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, July 21, 2023 1:39 PM
>
>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev wrote:
>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

[...]

>>+
>>+/**
>>+ * ice_dpll_cb_lock - lock dplls mutex in callback context
>>+ * @pf: private board structure
>>+ * @extack: error reporting
>>+ *
>>+ * Lock the mutex from the callback operations invoked by dpll subsystem=
.
>>+ * Prevent dead lock caused by `rmmod ice` when dpll callbacks are under
>stress
>>+ * tests.
>
>I don't know, I will probably need to beg you here. Why exactly are you
>ignoring my comments? It's not nice, I thought we are way past it...
>
>There is no "dead lock". Could you please describe how exactly
>the case you mention can happen? It can't.
>Could you please remove the trylock iteration below?
>It's completely pointless.
>

Yep, dead lock cannot happen now, will fix docs.
Will remove trylock.

>
>
>>+ *
>>+ * Return:
>>+ * 0 - if lock acquired
>>+ * negative - lock not acquired or dpll is not initialized
>>+ */
>>+static int ice_dpll_cb_lock(struct ice_pf *pf, struct netlink_ext_ack
>>*extack)
>>+{
>>+	int i;
>>+
>>+	for (i =3D 0; i < ICE_DPLL_LOCK_TRIES; i++) {
>>+		if (!test_bit(ICE_FLAG_DPLL, pf->flags)) {
>
>And again, as I already told you, this flag checking is totally
>pointless. See below my comment to ice_dpll_init()/ice_dpll_deinit().
>

This is not pointless, will explain below.

>
>

[...]

>>+/**
>>+ * ice_dpll_release_pins - release pins resources from dpll subsystem
>>+ * @pins: pointer to pins array
>>+ * @count: number of pins
>>+ *
>>+ * Release resources of given pins array in the dpll subsystem.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ */
>>+static void ice_dpll_release_pins(struct ice_dpll_pin *pins, int count)
>>+{
>>+	int i;
>>+
>>+	for (i =3D 0; i < count; i++)
>>+		dpll_pin_put(pins[i].pin);
>>+}
>>+
>>+/**
>>+ * ice_dpll_get_pins - get pins from dpll subsystem
>>+ * @pf: board private structure
>>+ * @pins: pointer to pins array
>>+ * @start_idx: get starts from this pin idx value
>>+ * @count: number of pins
>>+ * @clock_id: clock_id of dpll device
>>+ *
>>+ * Get pins - allocate - in dpll subsystem, store them in pin field of
>>given
>>+ * pins array.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ * Return:
>>+ * * 0 - success
>>+ * * negative - allocation failure reason
>>+ */
>>+static int
>>+ice_dpll_get_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
>>+		  int start_idx, int count, u64 clock_id)
>>+{
>>+	int i, ret;
>>+
>>+	for (i =3D 0; i < count; i++) {
>>+		pins[i].pin =3D dpll_pin_get(clock_id, i + start_idx,
>>THIS_MODULE,
>>+					   &pins[i].prop);
>>+		if (IS_ERR(pins[i].pin)) {
>>+			ret =3D PTR_ERR(pins[i].pin);
>>+			goto release_pins;
>>+		}
>>+	}
>>+
>>+	return 0;
>>+
>>+release_pins:
>>+	while (--i >=3D 0)
>>+		dpll_pin_put(pins[i].pin);
>>+	return ret;
>>+}
>>+
>>+/**
>>+ * ice_dpll_unregister_pins - unregister pins from a dpll
>>+ * @dpll: dpll device pointer
>>+ * @pins: pointer to pins array
>>+ * @ops: callback ops registered with the pins
>>+ * @count: number of pins
>>+ *
>>+ * Unregister pins of a given array of pins from given dpll device
>>registered in
>>+ * dpll subsystem.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ */
>>+static void
>>+ice_dpll_unregister_pins(struct dpll_device *dpll, struct ice_dpll_pin
>>*pins,
>>+			 const struct dpll_pin_ops *ops, int count)
>>+{
>>+	int i;
>>+
>>+	for (i =3D 0; i < count; i++)
>>+		dpll_pin_unregister(dpll, pins[i].pin, ops, &pins[i]);
>>+}
>>+
>>+/**
>>+ * ice_dpll_register_pins - register pins with a dpll
>>+ * @dpll: dpll pointer to register pins with
>>+ * @pins: pointer to pins array
>>+ * @ops: callback ops registered with the pins
>>+ * @count: number of pins
>>+ *
>>+ * Register pins of a given array with given dpll in dpll subsystem.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ * Return:
>>+ * * 0 - success
>>+ * * negative - registration failure reason
>>+ */
>>+static int
>>+ice_dpll_register_pins(struct dpll_device *dpll, struct ice_dpll_pin
>>*pins,
>>+		       const struct dpll_pin_ops *ops, int count)
>>+{
>>+	int ret, i;
>>+
>>+	for (i =3D 0; i < count; i++) {
>>+		ret =3D dpll_pin_register(dpll, pins[i].pin, ops, &pins[i]);
>>+		if (ret)
>>+			goto unregister_pins;
>>+	}
>>+
>>+	return 0;
>>+
>>+unregister_pins:
>>+	while (--i >=3D 0)
>>+		dpll_pin_unregister(dpll, pins[i].pin, ops, &pins[i]);
>>+	return ret;
>>+}
>>+
>>+/**
>>+ * ice_dpll_deinit_direct_pins - deinitialize direct pins
>>+ * @cgu: if cgu is present and controlled by this NIC
>>+ * @pins: pointer to pins array
>>+ * @count: number of pins
>>+ * @ops: callback ops registered with the pins
>>+ * @first: dpll device pointer
>>+ * @second: dpll device pointer
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ * If cgu is owned unregister pins from given dplls.
>>+ * Release pins resources to the dpll subsystem.
>>+ */
>>+static void
>>+ice_dpll_deinit_direct_pins(bool cgu, struct ice_dpll_pin *pins, int
>>count,
>>+			    const struct dpll_pin_ops *ops,
>>+			    struct dpll_device *first,
>>+			    struct dpll_device *second)
>>+{
>>+	if (cgu) {
>>+		ice_dpll_unregister_pins(first, pins, ops, count);
>>+		ice_dpll_unregister_pins(second, pins, ops, count);
>>+	}
>>+	ice_dpll_release_pins(pins, count);
>>+}
>>+
>>+/**
>>+ * ice_dpll_init_direct_pins - initialize direct pins
>>+ * @pf: board private structure
>>+ * @cgu: if cgu is present and controlled by this NIC
>>+ * @pins: pointer to pins array
>>+ * @start_idx: on which index shall allocation start in dpll subsystem
>>+ * @count: number of pins
>>+ * @ops: callback ops registered with the pins
>>+ * @first: dpll device pointer
>>+ * @second: dpll device pointer
>>+ *
>>+ * Allocate directly connected pins of a given array in dpll subsystem.
>>+ * If cgu is owned register allocated pins with given dplls.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ * Return:
>>+ * * 0 - success
>>+ * * negative - registration failure reason
>>+ */
>>+static int
>>+ice_dpll_init_direct_pins(struct ice_pf *pf, bool cgu,
>>+			  struct ice_dpll_pin *pins, int start_idx, int count,
>>+			  const struct dpll_pin_ops *ops,
>>+			  struct dpll_device *first, struct dpll_device *second)
>>+{
>>+	int ret;
>>+
>>+	ret =3D ice_dpll_get_pins(pf, pins, start_idx, count, pf-
>>dplls.clock_id);
>>+	if (ret)
>>+		return ret;
>>+	if (cgu) {
>>+		ret =3D ice_dpll_register_pins(first, pins, ops, count);
>>+		if (ret)
>>+			goto release_pins;
>>+		ret =3D ice_dpll_register_pins(second, pins, ops, count);
>>+		if (ret)
>>+			goto unregister_first;
>>+	}
>>+
>>+	return 0;
>>+
>>+unregister_first:
>>+	ice_dpll_unregister_pins(first, pins, ops, count);
>>+release_pins:
>>+	ice_dpll_release_pins(pins, count);
>>+	return ret;
>>+}
>>+
>>+/**
>>+ * ice_dpll_deinit_rclk_pin - release rclk pin resources
>>+ * @pf: board private structure
>>+ *
>>+ * Deregister rclk pin from parent pins and release resources in dpll
>>subsystem.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ */
>>+static void ice_dpll_deinit_rclk_pin(struct ice_pf *pf)
>>+{
>>+	struct ice_dpll_pin *rclk =3D &pf->dplls.rclk;
>>+	struct ice_vsi *vsi =3D ice_get_main_vsi(pf);
>>+	struct dpll_pin *parent;
>>+	int i;
>>+
>>+	for (i =3D 0; i < rclk->num_parents; i++) {
>>+		parent =3D pf->dplls.inputs[rclk->parent_idx[i]].pin;
>>+		if (!parent)
>>+			continue;
>>+		dpll_pin_on_pin_unregister(parent, rclk->pin,
>>+					   &ice_dpll_rclk_ops, rclk);
>>+	}
>>+	if (WARN_ON_ONCE(!vsi || !vsi->netdev))
>>+		return;
>>+	netdev_dpll_pin_clear(vsi->netdev);
>>+	dpll_pin_put(rclk->pin);
>>+}
>>+
>>+/**
>>+ * ice_dpll_init_rclk_pins - initialize recovered clock pin
>>+ * @pf: board private structure
>>+ * @pin: pin to register
>>+ * @start_idx: on which index shall allocation start in dpll subsystem
>>+ * @ops: callback ops registered with the pins
>>+ *
>>+ * Allocate resource for recovered clock pin in dpll subsystem. Register
>>the
>>+ * pin with the parents it has in the info. Register pin with the pf's
>>main vsi
>>+ * netdev.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ * Return:
>>+ * * 0 - success
>>+ * * negative - registration failure reason
>>+ */
>>+static int
>>+ice_dpll_init_rclk_pins(struct ice_pf *pf, struct ice_dpll_pin *pin,
>>+			int start_idx, const struct dpll_pin_ops *ops)
>>+{
>>+	struct ice_vsi *vsi =3D ice_get_main_vsi(pf);
>>+	struct dpll_pin *parent;
>>+	int ret, i;
>>+
>>+	ret =3D ice_dpll_get_pins(pf, pin, start_idx, ICE_DPLL_RCLK_NUM_PER_PF,
>>+				pf->dplls.clock_id);
>>+	if (ret)
>>+		return ret;
>>+	for (i =3D 0; i < pf->dplls.rclk.num_parents; i++) {
>>+		parent =3D pf->dplls.inputs[pf->dplls.rclk.parent_idx[i]].pin;
>>+		if (!parent) {
>>+			ret =3D -ENODEV;
>>+			goto unregister_pins;
>>+		}
>>+		ret =3D dpll_pin_on_pin_register(parent, pf->dplls.rclk.pin,
>>+					       ops, &pf->dplls.rclk);
>>+		if (ret)
>>+			goto unregister_pins;
>>+	}
>>+	if (WARN_ON((!vsi || !vsi->netdev)))
>>+		return -EINVAL;
>>+	netdev_dpll_pin_set(vsi->netdev, pf->dplls.rclk.pin);
>>+
>>+	return 0;
>>+
>>+unregister_pins:
>>+	while (i) {
>>+		parent =3D pf->dplls.inputs[pf->dplls.rclk.parent_idx[--i]].pin;
>>+		dpll_pin_on_pin_unregister(parent, pf->dplls.rclk.pin,
>>+					   &ice_dpll_rclk_ops, &pf->dplls.rclk);
>>+	}
>>+	ice_dpll_release_pins(pin, ICE_DPLL_RCLK_NUM_PER_PF);
>>+	return ret;
>>+}
>>+
>>+/**
>>+ * ice_dpll_deinit_pins - deinitialize direct pins
>>+ * @pf: board private structure
>>+ * @cgu: if cgu is controlled by this pf
>>+ *
>>+ * If cgu is owned unregister directly connected pins from the dplls.
>>+ * Release resources of directly connected pins from the dpll subsystem.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ */
>>+static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
>>+{
>>+	struct ice_dpll_pin *outputs =3D pf->dplls.outputs;
>>+	struct ice_dpll_pin *inputs =3D pf->dplls.inputs;
>>+	int num_outputs =3D pf->dplls.num_outputs;
>>+	int num_inputs =3D pf->dplls.num_inputs;
>>+	struct ice_dplls *d =3D &pf->dplls;
>>+	struct ice_dpll *de =3D &d->eec;
>>+	struct ice_dpll *dp =3D &d->pps;
>>+
>>+	ice_dpll_deinit_rclk_pin(pf);
>>+	if (cgu) {
>>+		ice_dpll_unregister_pins(dp->dpll, inputs, &ice_dpll_input_ops,
>>+					 num_inputs);
>>+		ice_dpll_unregister_pins(de->dpll, inputs, &ice_dpll_input_ops,
>>+					 num_inputs);
>>+	}
>>+	ice_dpll_release_pins(inputs, num_inputs);
>>+	if (cgu) {
>>+		ice_dpll_unregister_pins(dp->dpll, outputs,
>>+					 &ice_dpll_output_ops, num_outputs);
>>+		ice_dpll_unregister_pins(de->dpll, outputs,
>>+					 &ice_dpll_output_ops, num_outputs);
>>+		ice_dpll_release_pins(outputs, num_outputs);
>>+	}
>>+}
>>+
>>+/**
>>+ * ice_dpll_init_pins - init pins and register pins with a dplls
>>+ * @pf: board private structure
>>+ * @cgu: if cgu is present and controlled by this NIC
>>+ *
>>+ * Initialize directly connected pf's pins within pf's dplls in a Linux
>>dpll
>>+ * subsystem.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ * Return:
>>+ * * 0 - success
>>+ * * negative - initialization failure reason
>>+ */
>>+static int ice_dpll_init_pins(struct ice_pf *pf, bool cgu)
>>+{
>>+	u32 rclk_idx;
>>+	int ret;
>>+
>>+	ret =3D ice_dpll_init_direct_pins(pf, cgu, pf->dplls.inputs, 0,
>>+					pf->dplls.num_inputs,
>>+					&ice_dpll_input_ops,
>>+					pf->dplls.eec.dpll, pf->dplls.pps.dpll);
>>+	if (ret)
>>+		return ret;
>>+	if (cgu) {
>>+		ret =3D ice_dpll_init_direct_pins(pf, cgu, pf->dplls.outputs,
>>+						pf->dplls.num_inputs,
>>+						pf->dplls.num_outputs,
>>+						&ice_dpll_output_ops,
>>+						pf->dplls.eec.dpll,
>>+						pf->dplls.pps.dpll);
>>+		if (ret)
>>+			goto deinit_inputs;
>>+	}
>>+	rclk_idx =3D pf->dplls.num_inputs + pf->dplls.num_outputs + pf-
>>hw.pf_id;
>>+	ret =3D ice_dpll_init_rclk_pins(pf, &pf->dplls.rclk, rclk_idx,
>>+				      &ice_dpll_rclk_ops);
>>+	if (ret)
>>+		goto deinit_outputs;
>>+
>>+	return 0;
>>+deinit_outputs:
>>+	ice_dpll_deinit_direct_pins(cgu, pf->dplls.outputs,
>>+				    pf->dplls.num_outputs,
>>+				    &ice_dpll_output_ops, pf->dplls.pps.dpll,
>>+				    pf->dplls.eec.dpll);
>>+deinit_inputs:
>>+	ice_dpll_deinit_direct_pins(cgu, pf->dplls.inputs, pf-
>>dplls.num_inputs,
>>+				    &ice_dpll_input_ops, pf->dplls.pps.dpll,
>>+				    pf->dplls.eec.dpll);
>>+	return ret;
>>+}
>>+
>>+/**
>>+ * ice_dpll_deinit_dpll - deinitialize dpll device
>>+ * @pf: board private structure
>>+ * @d: pointer to ice_dpll
>>+ * @cgu: if cgu is present and controlled by this NIC
>>+ *
>>+ * If cgu is owned unregister the dpll from dpll subsystem.
>>+ * Release resources of dpll device from dpll subsystem.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ */
>>+static void
>>+ice_dpll_deinit_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
>>+{
>>+	if (cgu)
>>+		dpll_device_unregister(d->dpll, &ice_dpll_ops, d);
>>+	dpll_device_put(d->dpll);
>>+}
>>+
>>+/**
>>+ * ice_dpll_init_dpll - initialize dpll device in dpll subsystem
>>+ * @pf: board private structure
>>+ * @d: dpll to be initialized
>>+ * @cgu: if cgu is present and controlled by this NIC
>>+ * @type: type of dpll being initialized
>>+ *
>>+ * Allocate dpll instance for this board in dpll subsystem, if cgu is
>>controlled
>>+ * by this NIC, register dpll with the callback ops.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ * Return:
>>+ * * 0 - success
>>+ * * negative - initialization failure reason
>>+ */
>>+static int
>>+ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
>>+		   enum dpll_type type)
>>+{
>>+	u64 clock_id =3D pf->dplls.clock_id;
>>+	int ret;
>>+
>>+	d->dpll =3D dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE);
>>+	if (IS_ERR(d->dpll)) {
>>+		ret =3D PTR_ERR(d->dpll);
>>+		dev_err(ice_pf_to_dev(pf),
>>+			"dpll_device_get failed (%p) err=3D%d\n", d, ret);
>>+		return ret;
>>+	}
>>+	d->pf =3D pf;
>>+	if (cgu) {
>>+		ret =3D dpll_device_register(d->dpll, type, &ice_dpll_ops, d);
>>+		if (ret) {
>>+			dpll_device_put(d->dpll);
>>+			return ret;
>>+		}
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+/**
>>+ * ice_dpll_deinit_worker - deinitialize dpll kworker
>>+ * @pf: board private structure
>>+ *
>>+ * Stop dpll's kworker, release it's resources.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ */
>>+static void ice_dpll_deinit_worker(struct ice_pf *pf)
>>+{
>>+	struct ice_dplls *d =3D &pf->dplls;
>>+
>>+	kthread_cancel_delayed_work_sync(&d->work);
>>+	kthread_destroy_worker(d->kworker);
>>+}
>>+
>>+/**
>>+ * ice_dpll_init_worker - Initialize DPLLs periodic worker
>>+ * @pf: board private structure
>>+ *
>>+ * Create and start DPLLs periodic worker.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ * Return:
>>+ * * 0 - success
>>+ * * negative - create worker failure
>>+ */
>>+static int ice_dpll_init_worker(struct ice_pf *pf)
>>+{
>>+	struct ice_dplls *d =3D &pf->dplls;
>>+	struct kthread_worker *kworker;
>>+
>>+	ice_dpll_update_state(pf, &d->eec, true);
>>+	ice_dpll_update_state(pf, &d->pps, true);
>>+	kthread_init_delayed_work(&d->work, ice_dpll_periodic_work);
>>+	kworker =3D kthread_create_worker(0, "ice-dplls-%s",
>>+					dev_name(ice_pf_to_dev(pf)));
>>+	if (IS_ERR(kworker))
>>+		return PTR_ERR(kworker);
>>+	d->kworker =3D kworker;
>>+	d->cgu_state_acq_err_num =3D 0;
>>+	kthread_queue_delayed_work(d->kworker, &d->work, 0);
>>+
>>+	return 0;
>>+}
>>+
>>+/**
>>+ * ice_dpll_init_info_direct_pins - initializes direct pins info
>>+ * @pf: board private structure
>>+ * @pin_type: type of pins being initialized
>>+ *
>>+ * Init information for directly connected pins, cache them in pf's pins
>>+ * structures.
>>+ *
>>+ * Context: Called under pf->dplls.lock.
>
>No, it is not.
>

Yes, will fix.

>
>>+ * Return:
>>+ * * 0 - success
>>+ * * negative - init failure reason
>>+ */
>>+static int
>>+ice_dpll_init_info_direct_pins(struct ice_pf *pf,
>>+			       enum ice_dpll_pin_type pin_type)
>>+{
>>+	struct ice_dpll *de =3D &pf->dplls.eec, *dp =3D &pf->dplls.pps;
>>+	struct ice_hw *hw =3D &pf->hw;
>>+	struct ice_dpll_pin *pins;
>>+	int num_pins, i, ret;
>>+	u8 freq_supp_num;
>>+	bool input;
>>+
>>+	switch (pin_type) {
>>+	case ICE_DPLL_PIN_TYPE_INPUT:
>>+		pins =3D pf->dplls.inputs;
>>+		num_pins =3D pf->dplls.num_inputs;
>>+		input =3D true;
>>+		break;
>>+	case ICE_DPLL_PIN_TYPE_OUTPUT:
>>+		pins =3D pf->dplls.outputs;
>>+		num_pins =3D pf->dplls.num_outputs;
>>+		input =3D false;
>>+		break;
>>+	default:
>>+		return -EINVAL;
>>+	}
>>+
>>+	for (i =3D 0; i < num_pins; i++) {
>>+		pins[i].idx =3D i;
>>+		pins[i].prop.board_label =3D ice_cgu_get_pin_name(hw, i, input);
>>+		pins[i].prop.type =3D ice_cgu_get_pin_type(hw, i, input);
>>+		if (input) {
>>+			ret =3D ice_aq_get_cgu_ref_prio(hw, de->dpll_idx, i,
>>+						      &de->input_prio[i]);
>>+			if (ret)
>>+				return ret;
>>+			ret =3D ice_aq_get_cgu_ref_prio(hw, dp->dpll_idx, i,
>>+						      &dp->input_prio[i]);
>>+			if (ret)
>>+				return ret;
>>+			pins[i].prop.capabilities |=3D
>>+				DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE;
>>+		}
>>+		pins[i].prop.capabilities |=3D DPLL_PIN_CAPS_STATE_CAN_CHANGE;
>>+		ret =3D ice_dpll_pin_state_update(pf, &pins[i], pin_type, NULL);
>>+		if (ret)
>>+			return ret;
>>+		pins[i].prop.freq_supported =3D
>>+			ice_cgu_get_pin_freq_supp(hw, i, input, &freq_supp_num);
>>+		pins[i].prop.freq_supported_num =3D freq_supp_num;
>>+		pins[i].pf =3D pf;
>>+	}
>>+
>>+	return ret;
>>+}
>>+
>>+/**
>>+ * ice_dpll_init_info_rclk_pin - initializes rclk pin information
>>+ * @pf: board private structure
>>+ *
>>+ * Init information for rclk pin, cache them in pf->dplls.rclk.
>>+ *
>>+ * Return:
>>+ * * 0 - success
>>+ * * negative - init failure reason
>>+ */
>>+static int ice_dpll_init_info_rclk_pin(struct ice_pf *pf)
>>+{
>>+	struct ice_dpll_pin *pin =3D &pf->dplls.rclk;
>>+
>>+	pin->prop.type =3D DPLL_PIN_TYPE_SYNCE_ETH_PORT;
>>+	pin->prop.capabilities |=3D DPLL_PIN_CAPS_STATE_CAN_CHANGE;
>>+	pin->pf =3D pf;
>>+
>>+	return ice_dpll_pin_state_update(pf, pin,
>>+					 ICE_DPLL_PIN_TYPE_RCLK_INPUT, NULL);
>>+}
>>+
>>+/**
>>+ * ice_dpll_init_pins_info - init pins info wrapper
>>+ * @pf: board private structure
>>+ * @pin_type: type of pins being initialized
>>+ *
>>+ * Wraps functions for pin initialization.
>>+ *
>>+ * Return:
>>+ * * 0 - success
>>+ * * negative - init failure reason
>>+ */
>>+static int
>>+ice_dpll_init_pins_info(struct ice_pf *pf, enum ice_dpll_pin_type
>>pin_type)
>>+{
>>+	switch (pin_type) {
>>+	case ICE_DPLL_PIN_TYPE_INPUT:
>>+	case ICE_DPLL_PIN_TYPE_OUTPUT:
>>+		return ice_dpll_init_info_direct_pins(pf, pin_type);
>>+	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
>>+		return ice_dpll_init_info_rclk_pin(pf);
>>+	default:
>>+		return -EINVAL;
>>+	}
>>+}
>>+
>>+/**
>>+ * ice_dpll_deinit_info - release memory allocated for pins info
>>+ * @pf: board private structure
>>+ *
>>+ * Release memory allocated for pins by ice_dpll_init_info function.
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ */
>>+static void ice_dpll_deinit_info(struct ice_pf *pf)
>>+{
>>+	kfree(pf->dplls.inputs);
>>+	kfree(pf->dplls.outputs);
>>+	kfree(pf->dplls.eec.input_prio);
>>+	kfree(pf->dplls.pps.input_prio);
>>+}
>>+
>>+/**
>>+ * ice_dpll_init_info - prepare pf's dpll information structure
>>+ * @pf: board private structure
>>+ * @cgu: if cgu is present and controlled by this NIC
>>+ *
>>+ * Acquire (from HW) and set basic dpll information (on pf->dplls
>struct).
>>+ *
>>+ * Context: Called under pf->dplls.lock
>
>No, it is not.
>

Yes, will fix.

>
>>+ * Return:
>>+ * * 0 - success
>>+ * * negative - init failure reason
>>+ */
>>+static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
>>+{
>>+	struct ice_aqc_get_cgu_abilities abilities;
>>+	struct ice_dpll *de =3D &pf->dplls.eec;
>>+	struct ice_dpll *dp =3D &pf->dplls.pps;
>>+	struct ice_dplls *d =3D &pf->dplls;
>>+	struct ice_hw *hw =3D &pf->hw;
>>+	int ret, alloc_size, i;
>>+
>>+	d->clock_id =3D ice_generate_clock_id(pf);
>>+	ret =3D ice_aq_get_cgu_abilities(hw, &abilities);
>>+	if (ret) {
>>+		dev_err(ice_pf_to_dev(pf),
>>+			"err:%d %s failed to read cgu abilities\n",
>>+			ret, ice_aq_str(hw->adminq.sq_last_status));
>>+		return ret;
>>+	}
>>+
>>+	de->dpll_idx =3D abilities.eec_dpll_idx;
>>+	dp->dpll_idx =3D abilities.pps_dpll_idx;
>>+	d->num_inputs =3D abilities.num_inputs;
>>+	d->num_outputs =3D abilities.num_outputs;
>>+	d->input_phase_adj_max =3D le32_to_cpu(abilities.max_in_phase_adj);
>>+	d->output_phase_adj_max =3D le32_to_cpu(abilities.max_out_phase_adj);
>>+
>>+	alloc_size =3D sizeof(*d->inputs) * d->num_inputs;
>>+	d->inputs =3D kzalloc(alloc_size, GFP_KERNEL);
>>+	if (!d->inputs)
>>+		return -ENOMEM;
>>+
>>+	alloc_size =3D sizeof(*de->input_prio) * d->num_inputs;
>>+	de->input_prio =3D kzalloc(alloc_size, GFP_KERNEL);
>>+	if (!de->input_prio)
>>+		return -ENOMEM;
>>+
>>+	dp->input_prio =3D kzalloc(alloc_size, GFP_KERNEL);
>>+	if (!dp->input_prio)
>>+		return -ENOMEM;
>>+
>>+	ret =3D ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_INPUT);
>>+	if (ret)
>>+		goto deinit_info;
>>+
>>+	if (cgu) {
>>+		alloc_size =3D sizeof(*d->outputs) * d->num_outputs;
>>+		d->outputs =3D kzalloc(alloc_size, GFP_KERNEL);
>>+		if (!d->outputs)
>>+			goto deinit_info;
>>+
>>+		ret =3D ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_OUTPUT);
>>+		if (ret)
>>+			goto deinit_info;
>>+	}
>>+
>>+	ret =3D ice_get_cgu_rclk_pin_info(&pf->hw, &d->base_rclk_idx,
>>+					&pf->dplls.rclk.num_parents);
>>+	if (ret)
>>+		return ret;
>>+	for (i =3D 0; i < pf->dplls.rclk.num_parents; i++)
>>+		pf->dplls.rclk.parent_idx[i] =3D d->base_rclk_idx + i;
>>+	ret =3D ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_RCLK_INPUT);
>>+	if (ret)
>>+		return ret;
>>+	de->mode =3D DPLL_MODE_AUTOMATIC;
>>+	dp->mode =3D DPLL_MODE_AUTOMATIC;
>>+
>>+	dev_dbg(ice_pf_to_dev(pf),
>>+		"%s - success, inputs:%u, outputs:%u rclk-parents:%u\n",
>>+		__func__, d->num_inputs, d->num_outputs, d->rclk.num_parents);
>>+
>>+	return 0;
>>+
>>+deinit_info:
>>+	dev_err(ice_pf_to_dev(pf),
>>+		"%s - fail: d->inputs:%p, de->input_prio:%p, dp->input_prio:%p,
>>d->outputs:%p\n",
>>+		__func__, d->inputs, de->input_prio,
>>+		dp->input_prio, d->outputs);
>>+	ice_dpll_deinit_info(pf);
>>+	return ret;
>>+}
>>+
>>+/**
>>+ * ice_dpll_deinit - Disable the driver/HW support for dpll subsystem
>>+ * the dpll device.
>>+ * @pf: board private structure
>>+ *
>>+ * Handles the cleanup work required after dpll initialization,freeing
>>resources
>>+ * and unregistering the dpll, pin and all resources used for handling
>>them.
>>+ *
>>+ * Context: Function holds pf->dplls.lock mutex.
>
>No it does not. Update your comments. Or better, remove them,
>they are totally useless anyway :/
>

Yes, will fix.

>
>>+ */
>>+void ice_dpll_deinit(struct ice_pf *pf)
>>+{
>>+	bool cgu =3D ice_is_feature_supported(pf, ICE_F_CGU);
>>+
>>+	if (!test_bit(ICE_FLAG_DPLL, pf->flags))
>>+		return;
>>+	clear_bit(ICE_FLAG_DPLL, pf->flags);
>>+
>>+	ice_dpll_deinit_pins(pf, cgu);
>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
>>+	ice_dpll_deinit_info(pf);
>>+	if (cgu)
>>+		ice_dpll_deinit_worker(pf);
>
>Could you please order the ice_dpll_deinit() to be symmetrical to
>ice_dpll_init()? Then, you can drop ICE_FLAG_DPLL flag entirely, as the
>ice_dpll_periodic_work() function is the only reason why you need it
>currently.
>

Not true.
The feature flag is common approach in ice. If the feature was successfully
initialized the flag is set. It allows to determine if deinit of the featur=
e
is required on driver unload.

Right now the check for the flag is not only in kworker but also in each
callback, if the flag were cleared the data shall be not accessed by callba=
cks.
I know this is not required, but it helps on loading and unloading the driv=
er,
thanks to that, spam of pin-get dump is not slowing the driver load/unload.

>
>>+	mutex_destroy(&pf->dplls.lock);
>>+}
>>+
>>+/**
>>+ * ice_dpll_init - initialize support for dpll subsystem
>>+ * @pf: board private structure
>>+ *
>>+ * Set up the device dplls, register them and pins connected within Linu=
x
>>dpll
>>+ * subsystem. Allow userpsace to obtain state of DPLL and handling of
>>DPLL
>>+ * configuration requests.
>>+ *
>>+ * Context: Function initializes and holds pf->dplls.lock mutex.
>
>No, it does not hold it.
>

Yes, will fix.

>
>>+ */
>>+void ice_dpll_init(struct ice_pf *pf)
>>+{
>>+	bool cgu =3D ice_is_feature_supported(pf, ICE_F_CGU);
>>+	struct ice_dplls *d =3D &pf->dplls;
>>+	int err =3D 0;
>>+
>>+	err =3D ice_dpll_init_info(pf, cgu);
>>+	if (err)
>>+		goto err_exit;
>>+	err =3D ice_dpll_init_dpll(pf, &pf->dplls.eec, cgu, DPLL_TYPE_EEC);
>>+	if (err)
>>+		goto deinit_info;
>>+	err =3D ice_dpll_init_dpll(pf, &pf->dplls.pps, cgu, DPLL_TYPE_PPS);
>>+	if (err)
>>+		goto deinit_eec;
>>+	err =3D ice_dpll_init_pins(pf, cgu);
>>+	if (err)
>>+		goto deinit_pps;
>>+	set_bit(ICE_FLAG_DPLL, pf->flags);
>>+	if (cgu) {
>>+		err =3D ice_dpll_init_worker(pf);
>>+		if (err)
>>+			goto deinit_pins;
>>+	}
>>+
>>+	return;
>>+
>>+deinit_pins:
>>+	ice_dpll_deinit_pins(pf, cgu);
>>+deinit_pps:
>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
>>+deinit_eec:
>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
>>+deinit_info:
>>+	ice_dpll_deinit_info(pf);
>>+err_exit:
>>+	clear_bit(ICE_FLAG_DPLL, pf->flags);
>>+	mutex_unlock(&d->lock);
>
>Leftover, please remove.
>

Yes, will fix.

>
>>+	mutex_destroy(&d->lock);
>>+	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
>>+}
>>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h
>b/drivers/net/ethernet/intel/ice/ice_dpll.h
>>new file mode 100644
>>index 000000000000..975066b71c5e
>>--- /dev/null
>>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
>>@@ -0,0 +1,104 @@
>>+/* SPDX-License-Identifier: GPL-2.0 */
>>+/* Copyright (C) 2022, Intel Corporation. */
>>+
>>+#ifndef _ICE_DPLL_H_
>>+#define _ICE_DPLL_H_
>>+
>>+#include "ice.h"
>>+
>>+#define ICE_DPLL_PRIO_MAX	0xF
>>+#define ICE_DPLL_RCLK_NUM_MAX	4
>>+
>>+/** ice_dpll_pin - store info about pins
>>+ * @pin: dpll pin structure
>>+ * @pf: pointer to pf, which has registered the dpll_pin
>>+ * @idx: ice pin private idx
>>+ * @num_parents: hols number of parent pins
>>+ * @parent_idx: hold indexes of parent pins
>>+ * @flags: pin flags returned from HW
>>+ * @state: state of a pin
>>+ * @prop: pin properities
>>+ * @freq: current frequency of a pin
>>+ */
>>+struct ice_dpll_pin {
>>+	struct dpll_pin *pin;
>>+	struct ice_pf *pf;
>>+	u8 idx;
>>+	u8 num_parents;
>>+	u8 parent_idx[ICE_DPLL_RCLK_NUM_MAX];
>>+	u8 flags[ICE_DPLL_RCLK_NUM_MAX];
>>+	u8 state[ICE_DPLL_RCLK_NUM_MAX];
>>+	struct dpll_pin_properties prop;
>>+	u32 freq;
>>+};
>>+
>>+/** ice_dpll - store info required for DPLL control
>>+ * @dpll: pointer to dpll dev
>>+ * @pf: pointer to pf, which has registered the dpll_device
>>+ * @dpll_idx: index of dpll on the NIC
>>+ * @input_idx: currently selected input index
>>+ * @prev_input_idx: previously selected input index
>>+ * @ref_state: state of dpll reference signals
>>+ * @eec_mode: eec_mode dpll is configured for
>>+ * @phase_shift: phase shift delay of a dpll
>>+ * @input_prio: priorities of each input
>>+ * @dpll_state: current dpll sync state
>>+ * @prev_dpll_state: last dpll sync state
>>+ * @active_input: pointer to active input pin
>>+ * @prev_input: pointer to previous active input pin
>>+ */
>>+struct ice_dpll {
>>+	struct dpll_device *dpll;
>>+	struct ice_pf *pf;
>>+	u8 dpll_idx;
>>+	u8 input_idx;
>>+	u8 prev_input_idx;
>>+	u8 ref_state;
>>+	u8 eec_mode;
>>+	s64 phase_shift;
>>+	u8 *input_prio;
>>+	enum dpll_lock_status dpll_state;
>>+	enum dpll_lock_status prev_dpll_state;
>>+	enum dpll_mode mode;
>>+	struct dpll_pin *active_input;
>>+	struct dpll_pin *prev_input;
>>+};
>>+
>>+/** ice_dplls - store info required for CCU (clock controlling unit)
>>+ * @kworker: periodic worker
>>+ * @work: periodic work
>>+ * @lock: locks access to configuration of a dpll
>>+ * @eec: pointer to EEC dpll dev
>>+ * @pps: pointer to PPS dpll dev
>>+ * @inputs: input pins pointer
>>+ * @outputs: output pins pointer
>>+ * @rclk: recovered pins pointer
>>+ * @num_inputs: number of input pins available on dpll
>>+ * @num_outputs: number of output pins available on dpll
>>+ * @cgu_state_acq_err_num: number of errors returned during periodic wor=
k
>>+ * @base_rclk_idx: idx of first pin used for clock revocery pins
>>+ * @clock_id: clock_id of dplls
>>+ */
>>+struct ice_dplls {
>>+	struct kthread_worker *kworker;
>>+	struct kthread_delayed_work work;
>>+	struct mutex lock;
>>+	struct ice_dpll eec;
>>+	struct ice_dpll pps;
>>+	struct ice_dpll_pin *inputs;
>>+	struct ice_dpll_pin *outputs;
>>+	struct ice_dpll_pin rclk;
>>+	u8 num_inputs;
>>+	u8 num_outputs;
>>+	int cgu_state_acq_err_num;
>>+	u8 base_rclk_idx;
>>+	u64 clock_id;
>>+	s32 input_phase_adj_max;
>>+	s32 output_phase_adj_max;
>>+};
>>+
>>+void ice_dpll_init(struct ice_pf *pf);
>>+
>>+void ice_dpll_deinit(struct ice_pf *pf);
>>+
>>+#endif
>>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
>>b/drivers/net/ethernet/intel/ice/ice_main.c
>>index 19a5e7f3a075..0a94daaf3d20 100644
>>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>>@@ -4613,6 +4613,10 @@ static void ice_init_features(struct ice_pf *pf)
>> 	if (ice_is_feature_supported(pf, ICE_F_GNSS))
>> 		ice_gnss_init(pf);
>>
>>+	if (ice_is_feature_supported(pf, ICE_F_CGU) ||
>>+	    ice_is_feature_supported(pf, ICE_F_PHY_RCLK))
>>+		ice_dpll_init(pf);
>>+
>> 	/* Note: Flow director init failure is non-fatal to load */
>> 	if (ice_init_fdir(pf))
>> 		dev_err(dev, "could not initialize flow director\n");
>>@@ -4639,6 +4643,9 @@ static void ice_deinit_features(struct ice_pf *pf)
>> 		ice_gnss_exit(pf);
>> 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
>> 		ice_ptp_release(pf);
>>+	if (ice_is_feature_supported(pf, ICE_F_PHY_RCLK) ||
>>+	    ice_is_feature_supported(pf, ICE_F_CGU))
>>+		ice_dpll_deinit(pf);
>> }
>>
>> static void ice_init_wakeup(struct ice_pf *pf)
>>--
>>2.27.0
>>

