Return-Path: <netdev+bounces-76394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9235786D9A6
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 03:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0A31C22B4F
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3803B289;
	Fri,  1 Mar 2024 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcJ00/mO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F223A8C3
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259707; cv=fail; b=jWaxXBfy87AXDUlUeWxTFB5rxdjjlBKy9RjwzUmF9eMD7z4R9rCfBEJln5sAEzglPanz2/7IVve3/JcC3cUEL2lGOjjPwhz46S7RJT5kFYwPTiK2wCu9vGWeileFX41Gungl8BWVopWYb6kcqSfLIujp1VZzq6zwDg0arYgPdHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259707; c=relaxed/simple;
	bh=UH46i4sz4sBL0rQZ5psiRBPISI698bDWYAMRFarjRMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CIibKbpjej3AKnlyoO3NfT4E5IQKWbPihqr4vkkXUb7ILRHuKQk5DFr4IMdRpI0wXIOByUoe76+sXjf87JTqYuDCXlQBW1bIJQmuXP/sTu4PL1OTx/3WQuowa6PkxNmW2afr7kEJkp5MEJu9uDN/3mupzs3GYVNzFZJMUgdjcNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcJ00/mO; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709259706; x=1740795706;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UH46i4sz4sBL0rQZ5psiRBPISI698bDWYAMRFarjRMc=;
  b=FcJ00/mOrQnfF38GTSCgrW08/cFfJ/0TyCs+8nSdqiOtEl1xNZ+r0mc7
   J8nu6Wzdp8gMquoL/8RqWNqIpY+kOXb4+RL5fp1jEblsYFLtXAXhvVbW9
   TXRzp9LQjq5gq9UxS2ztFzKvKnsCrXD/Za6PLLq/VYfZEMhMvIBISR630
   vQmxxX6l8engGurnp/FoNFcppX8/SZg97eA3jS5vbUGfQIRZCV7o6Ifva
   dfsH6gjL4go3ZHO6tToIaniojJkt8ZctJl8fUJE3xdQV2KZ0162o6Guwr
   msICTmpyQdrAncflGNeHmBmDrQ6mGEZ9dd9noutlOvYziPRIhgQGitZhs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="14349100"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14349100"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 18:21:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="12725160"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 18:21:45 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 18:21:44 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 18:21:43 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 18:21:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Db20lk6HpVSrC57xs8C6US0GNlvnxv3n67z8x82Jr8Z16dPdZD6tuEai8K7GoqmkdQyEPX+hSIKf2+ZIIZbejp6ZsrqGuBnhTEaLdPUVJOuYUnET4Okys7iXP6sJyqNE+vJF7dBurjHNHpvdsCmMeBZqillpv27TAIUqm86dDCPEX/VL4oHS+8qUDICOf6KCpNQKZbEdgwwn3nAsgzkFzXaJIlHtPAx6c3Z1/To8nli1M5NS2zVIYcnIwQHg3+BO3lT9RMd+QFrOd6h0eADFOmZQnJzwPBZsg9cH6RMEAGGGwaQSVVelrcGbPwfvt/kbVIGnBhGJ/s2Pmr1IQKpkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH46i4sz4sBL0rQZ5psiRBPISI698bDWYAMRFarjRMc=;
 b=NUuXiVYsTNSvpHg/k2GTrEBTLMVykhrQpGog+N+PaVEAGlSL4MXROS83ErLJ/cHPZB8S4paoGv92h2kzC/1SUU/mpIuhF1urmGKCRnfE9CPIx/rTQEbRjbCvpfz8YI5hR6BSwEjrh2FFXBb3Nv/Ik15rJ3wSBTvHMeYyUvpheanxnwvRht7wTPQiSMBxNy2rR28NUAGosbp5tofAjxJwes8h7R+jrqvJdj1BaLLHZMQ1cscOArSEZ4oZX1xnzigAKDDwq0iiabn7mSZ45D/t55aQnurVXdzEXdvqcsZkW2sR8yjzROWfGbpFXFKJdSp3a/5fESakuJeoN1iqM+36Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by MW6PR11MB8439.namprd11.prod.outlook.com (2603:10b6:303:23e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Fri, 1 Mar
 2024 02:21:41 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::d738:fa64:675d:8dbb]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::d738:fa64:675d:8dbb%7]) with mapi id 15.20.7316.037; Fri, 1 Mar 2024
 02:21:41 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
	"Kuruvinakunnel, George" <george.kuruvinakunnel@intel.com>, "Nagraj, Shravan"
	<shravan.nagraj@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 3/3] ice: reorder disabling IRQ
 and NAPI in ice_qp_dis
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 3/3] ice: reorder disabling IRQ
 and NAPI in ice_qp_dis
Thread-Index: AQHaZEZgAa6mktnj+UioGUyDXlKP4rEiNYUQ
Date: Fri, 1 Mar 2024 02:21:41 +0000
Message-ID: <CH3PR11MB831321F6571E5F3BE7A7EB94EA5E2@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20240220214553.714243-1-maciej.fijalkowski@intel.com>
 <20240220214553.714243-4-maciej.fijalkowski@intel.com>
In-Reply-To: <20240220214553.714243-4-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|MW6PR11MB8439:EE_
x-ms-office365-filtering-correlation-id: 7122ff33-8669-459f-7c65-08dc39965528
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PUeuIXL9oJ92G040Vpi0yEefqo4S38l7voTZZ3zLIIu60OrOC3uFEFJPQAacSsKwM2GzQMhnyqqIk3w5Wyr3jLWBvU1v2pnt9L1PAFaOdXdq7CUCMvwWXig7FQ0Bv6D6KsEATYRn8PzgEDva+rb2NR6QROHWl6FEpwk9n3//DSEKu9kKCny7iNw6x9rtzkCj5z5HQaOnLDWKPxPZij3S7dAG9nQUnhkrqkjFBXcBYEFowLcLobqf4wQQ11bTbJez6vS2KI01g5ym/5OgKnmlL7NQN5kVulsDEIxflzcjVfueNjACAeMQmSiDInQf5ZoMTOAP/HJ02zZCRhEL11DbbJDGDKmyeovWCoTbiFT89er6F78bQ2tN5YCazoPeBZjTpbArG+4Dqdcnzc2IKTN4TgHgNKcRmZmn2l8lXziNfgWMkeroC7lyNghRmtmwd5fFEdFwaMMSHRqzuCwFr+BqhTMDgPC6HgHJnqrCbmBPOzLOGjIrdnfvl5itiKTPBQ8BqzLvGsGE7N4UGlOTMmphzZlTkbpaK9R1eZN2v6nKyH1XI2s7k+eWRkKcIvorNBEx6mdre/tQxxXoWt5zbrN7LszmpTwL8Ixhjkl4+45ZbuNvVg8NNZvoZY7OiUgxx7nOPwBIWeEURkPFw8oTZUOPXtOdUn1RFFWZeBwHeBM8FDS1FwjqVWbCzwcxrS3lmz4S2ZwzxL1wJhKtYW1e63e2qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DBoNYYc2VR+PCA2UMhFfG+vZZHRkYtFeBhM/2AVOkwPuz0pvnl48fwQ9mroX?=
 =?us-ascii?Q?ixLP8W6CtsSk8d4ri5NS0o/lnOFjyS6ecPmC+di0sGDJDM9fS7A2jSK619aq?=
 =?us-ascii?Q?bQxz0igCsf1jxj6vSXSV/5iQH80kTuqqVCEWoFqz0AXOerJPI7kFhHCjthPM?=
 =?us-ascii?Q?/KvBSZp0VNjl2nh7gVrSDDxGZ2BwEjk5X2ABKvSeh3XY+37aJOStkk9LCDrt?=
 =?us-ascii?Q?dT7fOEZCQGzpIf52hc1OGUADlWVIT0D5uR2HtPrk1R5XRXZlHUahmpVzaS2d?=
 =?us-ascii?Q?HohIgyboqafZ4tjMs7zTx332prwU39pOeeQ5wJD+sR7Ryfsc7Ggc4OAHg+m4?=
 =?us-ascii?Q?kHsIHAct+jxTcidpKR/aYfE/qwwtXHbIKlUNFHWU4z1Khbn+DgmmtLyuNCge?=
 =?us-ascii?Q?8N5/5AyOTGylTHGxBKnGiFfTmJc5z4+AcdyHLd2UqW02nmwOi1RhCUVSNvdX?=
 =?us-ascii?Q?nWeT339xN4zkPiwaj9geGVdVX1oa2HvvF2tD5bQUWjtoS1D0KgLIx2hd3aEB?=
 =?us-ascii?Q?Fvx07mCSeKfoRilmLDFOGmFcWshA9RerPiyXkBeXe+uuE+StBh+cAG51E+af?=
 =?us-ascii?Q?nNSH/Rv6xuUf3GZsMDwGelTZ8/ly3JUUao1OIv39Ym4ulNq9FOAX1CZKhN6Q?=
 =?us-ascii?Q?g67Wos780GhB9xNZhN7W32vi3mpdDVKIP51OSnHG0IRwptDw9o9hAjcDflwK?=
 =?us-ascii?Q?PS102V4ZQufjXG4sIT/X498GrduMEe5G+N47Cmt8Rj9L5LEcyYmCEJ8Hu8eu?=
 =?us-ascii?Q?iAg+HRQ38Tpr3E49diB154TC8NM044dFj+WGBY3qZZyOjZ/VeDedvtMWby3r?=
 =?us-ascii?Q?Fw10QA3EqMbFZPu0LnZ5VvSiMM4/9YoyhKU4C8WIQv2KBubQJ/8ccXc2Q3Pb?=
 =?us-ascii?Q?89Nq9s1Wn41PYm20QvzTeAalM86rnqWUhdU2oS1CtqJaAzljNjAowIF4q6bh?=
 =?us-ascii?Q?n6V7FdiK0dSGNB4uTA+N+xb5/9dgF125nH9DCsXuLkjhvNPOcQXiu3paytBK?=
 =?us-ascii?Q?l8P2N4V/oL2v2e8++oNPZovYd7KgNku8B2jOGRE1OKwCdGkzJ6kW/CW7fusR?=
 =?us-ascii?Q?6Lqd3vXHEIBv4mnoUORVK/OJQNv9lFneshSWV4apiR8oWLlr6NZ1H2xGDH/M?=
 =?us-ascii?Q?oED1GUyD6L7Auv+N0Nn+Cr8kUz+K6jjnHgajaXpeur+4qxwEjbdnQkXX5NP8?=
 =?us-ascii?Q?azEZ4eZZHnHUebvswAjIzav6dkf9BDe9TcRokJFlUG8dh1F1MEyj+OqsPyA2?=
 =?us-ascii?Q?mYjxNuqxCcULV1goCjGdxX4Tqs3Al0AT2Am4FBgx20B/AQLh4C3keFNHXSdX?=
 =?us-ascii?Q?DRUExXe5I5Gp+hRF1VleldwY/sdAAJbIGSwzSQasICTt5Qjw3X9G+hjum/GJ?=
 =?us-ascii?Q?G9jIBVGdoYnahMOt7BgbduIRMj6EWbw3+wAHY0Sqyuo3xGTmEZ8dQ+ToN6IM?=
 =?us-ascii?Q?TDPYwM1bzm7ptWyLHmXMm9QVOeOmUSXhCT0ilzd4Uzo6ELudJmVkLs6FaDG/?=
 =?us-ascii?Q?Rt3RbXilZrDIWrMzZNCuMFcRnjkNAIvGsI7fgW4v65qQa9SpneQyD8q3cSPa?=
 =?us-ascii?Q?WhkvbpmMHc/meAFOYqe3x/iOB+TohcAyvORU9ZC3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7122ff33-8669-459f-7c65-08dc39965528
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 02:21:41.6247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YbA7yaNVRc2doc0r1jH/hn16x52H3Hm8dIj8rw7sD5/HTeiDYODMg9cvuTzfx9l7HEaMwsMq1I+Adfg1FyllcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8439
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Fijalkowski, Maciej
>Sent: Wednesday, February 21, 2024 3:16 AM
>To: intel-wired-lan@lists.osuosl.org
>Cc: netdev@vger.kernel.org; Fijalkowski, Maciej
><maciej.fijalkowski@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; Karlsson, Magnus
><magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH iwl-net 3/3] ice: reorder disabling IRQ =
and
>NAPI in ice_qp_dis
>
>ice_qp_dis() currently does things in very mixed way. Tx is stopped before
>disabling IRQ on related queue vector, then it takes care of disabling Rx =
and
>finally NAPI is disabled.
>
>Let us start with disabling IRQs in the first place followed by turning of=
f NAPI.
>Then it is safe to handle queues.
>
>One subtle change on top of that is that even though ice_qp_ena() looks mo=
re
>sane, clear ICE_CFG_BUSY as the last thing there.
>
>Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
>Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_xsk.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)

