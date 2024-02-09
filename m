Return-Path: <netdev+bounces-70568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2530284F8D1
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44FD1F24B0E
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919C97317B;
	Fri,  9 Feb 2024 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHpGMa8y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03D1E504
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493657; cv=fail; b=E/onHfi939ce+8oEsH5mmRWfEqSLsiHONaf9mibMGxVa9x7tse2Ww8mt0/Xfrdb4ZIKC3P8SnQZeg7GfdUbpCpJiX4EUTPxp3BkXn24X1UckcSFda9SJKBKJ08BUNrUlEhXuas+oS8x6a1hMYU2X7FidqzVkVmnUfNryPeex8Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493657; c=relaxed/simple;
	bh=S57ERb7N0K3GX2CZ9G6nn5IHMZos0xnpWTXVy35amrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JNWet5OhhNgblpYUJ4ojKb6fCkagfM4ixp+q3YWo6PmQhb2nZGHtMStR6d+ZsfZ8joBSKxEp451bGrR9tfGe71uJbD5KwdHnrF+Vezoyl3fh3wJwhjFJkPad1PCCQgZfDHu/XBLywja7WJi8tZpimqCgErFz8KOTNdM/fB3cb9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHpGMa8y; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707493655; x=1739029655;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S57ERb7N0K3GX2CZ9G6nn5IHMZos0xnpWTXVy35amrk=;
  b=gHpGMa8ySka8JKCNPqrbHMqLuVs5iSGlAaVqm7fcddbARydK3OajXgIR
   95QBIgUuZY2GoxkjATH3OZ6kpIiWrWZt7efpOge48ok+dV94VuGcJurMA
   6auIpcZ8sR8gGObVsH2NQNgt4v+cJir1RxFjrySsNrtA/PoggrH0twJuX
   JigxyL3b4HwwrVjy0handKb8XyV3n4aaKP3aDoEKxkEdCDKh7bCwIZ8Gm
   7NW2yRCWpXJ15nFXSQmewon6MGJoFWdgSEAVkbC4QTPds1SKsa+pb84dQ
   7Ud2GBA6Ot4tY61EhiCruuA2b4XGDgeLAsDJefMuuzBq8ErTxj0oU4v+x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1341003"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1341003"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:47:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2180163"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 07:47:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 07:47:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 07:47:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 07:47:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uopb9hkGIkdVhrVSXCkDREDsapajeVFLe7pCP0Hzcx1VNGvMR8Iun7nhoR6EBtgqprbAa+qadOhZDzMBTsZBYkafATjeXilD0qNQNHa1ibLZmLVsKXbFGfIhtn/LLW8JKHdk6LY4it5K2RBoKO+21jv4F2ihRraRkNsM3Vz8OxgCCRzXgVqsUPLRImG8SRn/ucc6OuotJzJVJwBbRZHd1HGKdoCjsIO3BlZJpyzahd0UFuJeYYdS6FT0yAJsGtqA/fEv50bL9e1doyHrcufrYtBOw5VVblwUfQ1yK7jQ55yCj91iKzDBc7Q0VYg7euETH4wKcqmK0PeB35abLorHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Tm3AviHaKHZ0mCxNxzrW9zMCFLttjWEHSeCkyipQTM=;
 b=Dl9DOhB7FXhErN0a2g06kisu7utQgM4UMxRCgXfD20U1ZITce53dx8fR4tOHFSDzfTJHGd9a7u9G1GnMHAtJidK4Cmxg+6xeZ5N+G77BY7XRBDkWSkeSDuiAe1sgin1P08H+IiBbKnqsFZ4SGMgU0wPK+ISbFKQNQrKfE/+SBUZf6pfjsTD1tVfSwfJQ656avol1X3Y/UdnJBkcybDYA8AI1y7JpydmS0Opm6l6JupkUMvOa7XkrD8Z18F6nyTxBmDOAaLphsQoZPtbAPc0j3QBDRBbEmuuFKVcTMR7kY2yXeGwofa9/TsMq03kzgdUrt85OUwI3Miss+JudnirUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by PH7PR11MB7606.namprd11.prod.outlook.com (2603:10b6:510:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 15:47:31 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::42fe:dbf5:e344:f60]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::42fe:dbf5:e344:f60%6]) with mapi id 15.20.7249.038; Fri, 9 Feb 2024
 15:47:31 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Kuruvinakunnel, George"
	<george.kuruvinakunnel@intel.com>, "Nagraj, Shravan"
	<shravan.nagraj@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-net 1/2] i40e: avoid double
 calling i40e_pf_rxq_wait()
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-net 1/2] i40e: avoid double
 calling i40e_pf_rxq_wait()
Thread-Index: AQHaWPn0pAB3UxLC+EOn2tfXytwUerECLEhA
Date: Fri, 9 Feb 2024 15:47:31 +0000
Message-ID: <CH3PR11MB831321B6046890F86A0E5FD7EA4B2@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20240206124132.636342-1-maciej.fijalkowski@intel.com>
 <20240206124132.636342-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20240206124132.636342-2-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|PH7PR11MB7606:EE_
x-ms-office365-filtering-correlation-id: 71e406a3-2a9a-497a-2c79-08dc29866d5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bmJBJumCaM5Mb1injtqaE09WSbBOA5qJZhq+Z9IwkKJ5f4EEwFEzJKMRNCejkcKPtcBQk2zvJxGY2CdKwW4MEGUwjXsUjOPej/k1r7RG2v9ucIuH3A/LeNCUfgCXvXZuE2xcw6k2wgE8C+xeoTRnVKeyr8yF3/WrrkUy65Q8rQKRoJ9uXmtuhhA4i73shoc2TXhH3NV5GnF/o6lTzenlWmV5QWbHOZDUFVOL6F9Ny8Z3I0HNI1IhPG7h7kGhmt4KcPK/urZqMBml9uGuyWIH3zG1hD19P2T9QiXS7dFhqCYJqd70gZhyzKioaPeX7ekYdDpMH4dT1k+bunqBYS3YiXBoX60HQ7m9uuSHeL1/lF3wwkuzxe5oczMWd4d0YDvZzwUitW8Xn5A9OzcvnCTJt6+rH6qNjxL9JvuuFgGBRiuELftYGjQyzA7vUzROj98dQxKerf2SfgzqjPO/Xx3ilYQPwMjl1+196YXWZCEJ+ILsnLYWLFd8iwsRf4VVTgcryQDYuFs84oLaecgw6Hwew7OGgKh1lYz2qoJ7L+9a117CSD68mXLtel7KmWHyGh2lOFmrG5+U2xK1euV3OYRVqP+2otuUQLSL0WswdgrtrtrfSyP9MGDcBaIAf2X5lUog
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(55016003)(41300700001)(107886003)(26005)(478600001)(38070700009)(4326008)(71200400001)(54906003)(110136005)(52536014)(9686003)(7696005)(6506007)(8676002)(8936002)(66946007)(76116006)(66556008)(66476007)(64756008)(5660300002)(66446008)(83380400001)(33656002)(38100700002)(86362001)(316002)(122000001)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3Ns6tFObHJ4lRO0DVUZZQiif6dJAQyeIGswQc6JGvEW8ClDz/pQEBCOdKTBC?=
 =?us-ascii?Q?PzAM/eVV6ToUY0WA0buEHMPO7Be9/tmgWftj/DMOY1+Y0zGsoGeHtWI4CH/E?=
 =?us-ascii?Q?X+1nLKfPDFgA5pqIhjzIVyvDlA2UTCPhX8yoIuso78iYbdfNfXSjXbkqbF3b?=
 =?us-ascii?Q?Cv2LDDv98hCTdem9qY+u0PK+l1wfYDJZGTLAdASNSEcUL0rDUjctmox/Pai7?=
 =?us-ascii?Q?5YRvcfSNek0zV1OnLH9AIqLR8+0bCh/2YuQCDRynitYAMevtDcTM56KmhueL?=
 =?us-ascii?Q?dl4zwizzWA7R97oUWBA24C4K6NU9rN883k9Wpf3LLQC16POrB4Y2OA4ZOPjT?=
 =?us-ascii?Q?ew5FrJNbNbCIIGm/USM7q2MVJIJeaCn18L1S6fPqRaM1tsr3YJx0PGZMJR3K?=
 =?us-ascii?Q?5zlCSU90bj4cPzTazPlrnqwWJ8ZqzwJWNDkFv9eLoUGsiu0szjHMbdbh8fcR?=
 =?us-ascii?Q?CypH3AJMdnzJ/lMMMG/kXHj4ATsct3hgE4pDcfUs5eP8wPKwZpT9tV+/gszW?=
 =?us-ascii?Q?5v2lD90Cbkos/r1aatPpM1khlfJJVSFnuqs6wTHcQeEwUabfzRkLX9/sJjcr?=
 =?us-ascii?Q?abJXoItqVkhXtLyQryhOxWjSQfzb72vLrFEl1OJ1lPDxh/GY7F+IJSHQeC9S?=
 =?us-ascii?Q?NDZgYj3r/0jHe9xrm/ScCWVkjuuXALTNXbEty/bTl3XVD6kmOX17+w/GE6ow?=
 =?us-ascii?Q?tUUrEusJoa32VUEo1ICbHT95divTQ9aIVO/OhbxhZGTzh1Ss+Uqhj3R8dX/r?=
 =?us-ascii?Q?KaarZQUJaNhjWj2+n67Xr6OjUAUBrwGaq3EP9GCv+t0kCUE6tXfdNjkGNJAi?=
 =?us-ascii?Q?Uesi2MmVJXX3SjDHSTJSHBFee/CzZHofvTynEhxLcNA74KQKJa35AoNDcQmm?=
 =?us-ascii?Q?vEl4gr2cR1Zkg/TZOcCtdA73IOqkoYxSahALEZmEc33ij5cIh7OiplpWMPQC?=
 =?us-ascii?Q?TuHzlf8xBvS7sR7b9N6FXLFDeiqxK5++SyUNTDH1OoyVZ7uDtfYko0qYYY8h?=
 =?us-ascii?Q?e3tISefK4rKHx3PRvpUNTnAqa308ty62hjsnynWnmFGNo2Hxr66hkMYMIomc?=
 =?us-ascii?Q?HjCuJemyTvJwn3PDA6QJzqfQsk6op5pgA0iFm8bv2zJl0meQui2p0YbRMc3U?=
 =?us-ascii?Q?37QishROXoWMNzoYbDwItQ9MGXJLUFEzuGaKPW9FY7QWJu41SXheatduxiCE?=
 =?us-ascii?Q?OgzzB4bm9MZQdVBJR2oag8lIBWxXH+cD481WE03ZAcANMPt49abVyhfyM+zT?=
 =?us-ascii?Q?Sp7/ioWoiYsbU/LdFwVR1AW/q78mCirn5bDW9blH+zTDgd7CAD6pfH2E2tSo?=
 =?us-ascii?Q?nqxWcsFnFeS1MaCfPlb1hm/0juf/l1G1jkcSQcbEoykj+BQy9gJAow7lFOsm?=
 =?us-ascii?Q?liwuDd2YH3YIPlVG0ywSIlRNgk8Z0QKyDMtUpjNbdkx2fay1K11Y3zeDb87R?=
 =?us-ascii?Q?H86bzgUjKg4+VOmMcXRGJkcFKaaa7gfaTLdZLmZQk0rC6p/MQ8PK0nXhZcxS?=
 =?us-ascii?Q?Aa2rPLQqUK2zSTdRCVOrI+t7SoOjkzDJo7U+8OuDnDd843rVYhA8dSdXZtpb?=
 =?us-ascii?Q?LfBFP6EsF5gamEdKoFfv+NMGBD9IP0+xdvZd2yIZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8313.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e406a3-2a9a-497a-2c79-08dc29866d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 15:47:31.6424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZP0kVZlSCU5me6CeR+/MwIktMNKvLl7voDDCbdwI/9yKtgn5LlOrJLyb6HS4IDCLUWdJAige40CaVCXsejmt6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7606
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Fijalkowski, Maciej
>Sent: Tuesday, February 6, 2024 6:12 PM
>To: intel-wired-lan@lists.osuosl.org
>Cc: netdev@vger.kernel.org; Fijalkowski, Maciej
><maciej.fijalkowski@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>;
>Karlsson, Magnus <magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH v2 iwl-net 1/2] i40e: avoid double calli=
ng
>i40e_pf_rxq_wait()
>
>Currently, when interface is being brought down and
>i40e_vsi_stop_rings() is called, i40e_pf_rxq_wait() is called two times, w=
hich is
>wrong. To showcase this scenario, simplified call stack looks as follows:
>
>i40e_vsi_stop_rings()
>	i40e_control wait rx_q()
>		i40e_control_rx_q()
>		i40e_pf_rxq_wait()
>	i40e_vsi_wait_queues_disabled()
>		i40e_pf_rxq_wait()  // redundant call
>
>To fix this, let us s/i40e_control_wait_rx_q/i40e_control_rx_q within
>i40e_vsi_stop_rings().
>
>Fixes: 65662a8dcdd0 ("i40e: Fix logic of disabling queues")
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++---------
> 1 file changed, 3 insertions(+), 9 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)

