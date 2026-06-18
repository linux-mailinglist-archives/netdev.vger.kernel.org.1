Return-Path: <netdev+bounces-300484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hv1aN9kWNGrUOAYAu9opvQ
	(envelope-from <netdev+bounces-300484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:03:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D419A6A171F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:03:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Clu5yiBy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300484-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300484-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE36E3035E94
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F43E32B128;
	Thu, 18 Jun 2026 16:02:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5513233D6F8;
	Thu, 18 Jun 2026 16:02:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798539; cv=fail; b=BF19CW9CQ00rfbXX55gLdKtgA+G6pfA08grVl4UIuvIm+u1sBB/vqJf3ew2p8wI5ZxRjpA4dT81FNESajxSr0RxO3TmPYHJOzOe7xzHGa2wtC9lc0SUJpjtGrAfs7ZtfQAlEEY427jvh82Mv3SO13JIIRW8widbJO3px9hkbzAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798539; c=relaxed/simple;
	bh=netJ8FD/7DtzfwdDHShj+uHco3Szpc8OWIkWFglb6FM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lUHSs9pCr1AiwcC6v+sBnlQlQ4JseTkzIvfIkstmWQ7NIepE7OTKJ6NAEOkccyrh28zJO+aKSDB2d96S2rQBURkOz55mZflVAQ5/k2ehleTTE6o9i66X5yHuDBs/MXI6Fyzn2/BOQrp1XQIlJQns051CxMWPWBbJotCQisrpyAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Clu5yiBy; arc=fail smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781798536; x=1813334536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=netJ8FD/7DtzfwdDHShj+uHco3Szpc8OWIkWFglb6FM=;
  b=Clu5yiByb9HDOJQh0UlffHg7qEM1rlEaXerEvuLG2CABRfaxS8uQP9wc
   ZT16d+7gDKlkEay9Xa3Vr39e3ZxhZiFjjpOFDoRkPNiQbbO5GHLRCHtiN
   iR6mzRRvVveqf6MU4crd5A3jIMDYQjxJs4RBg0fK4GmlWSWTPZKG+9j3g
   GBqMvgpxEmdU+ofvowzhSV4ISHIFIDiD/teh34LSqJ0vVRaH5/E322R0+
   j52DKyVQs+2dnYfIQmZZdbK89mFNq8aM+WxHe5fQNGyjcFKFHyWbx3dEt
   4JO4kN693tJ0RGKb22Qf+aTfLvVkL4KpIweG17/pIAVDQIdzGPL8sWCTX
   A==;
X-CSE-ConnectionGUID: S79z73B/RzeimPWCR5nLUQ==
X-CSE-MsgGUID: v3NLW1e3RoeT1a5xf56Rjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="85195223"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="85195223"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 09:02:15 -0700
X-CSE-ConnectionGUID: YJg/TY/nRgquE8Ie5bsPYw==
X-CSE-MsgGUID: XaF2RcCgR0WJIgbyU5LSmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="252298394"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 09:02:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 09:02:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 18 Jun 2026 09:02:14 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 09:02:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnnJk7uFjMrWpDZOlDvxfKH3xkZ26nhcevzWqTUZh1RDHOknzc24hqEuyN5ljIfPpjsKEqZS/2gNjxuI6qeP4AIo2jTMmNwnAP34cI6Zkcbvcw8TMOPIIoikWpon2MzCURAhxiRsiasfjXwvxso1ZVSsUS2YAXsub0iZT6NSjKNOtXe3t8f9KYqVLXxWqcY7UEoWlDsRFTfm730SH0TOUSp9FE6wJNvHPXloVwyg5TkdB5aEyzNDO4KvxL5cuAtonZnErjWEXndls2H7sOvV12j3nNEEHFexFjGiOTzzlrqaQN8zMlSejCpEkYwLhwxwo0QPpVyvj7YT877j+sq8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfGKwxKbq/e08uZO5IBGF2N/9K2M7L+2iif3isyDETI=;
 b=XLQJ2MdDa9iFG5gYPcyU4fVgpklGjROPrvXqzKtpgl/PpaWA5tm+Mk9PR5v9tekp2Eck3FCeN2dQbB7L+ILxf4D5Wn5OBzX47A0299JxGIratz5tOdEwpkMm8llkf80M5Hv1vNeoZm1qLFv59lwC2fDZZOBH7xFdJ0sdzEk1g2qTJbI578Mg5ehnUNYcV6VcHrSRVEHYD7d3cViHH2Z5ly7bTXJKWm9y85GHX1ts4RulQAy7g8Z6c1zoVkagpPWdPHUMycfg+j5RpMS/BmqFXteoXisXuf9V7akyWhtsF31lL1C+IbWFeKqMXISsNwMYnH7CtUjCGB7lmLlMyp5CAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPF6E320AF71.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::833) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 16:02:10 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 16:02:10 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, Alice Michael
	<alice.michael@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Eric Dumazet <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: preserve uplink DFLT
 Rx rule on switchdev release
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: preserve uplink DFLT
 Rx rule on switchdev release
Thread-Index: AQHc/zSG31qmz/XKRE+SauLzlh+iurZEeScg
Date: Thu, 18 Jun 2026 16:02:10 +0000
Message-ID: <IA3PR11MB8986ECFE42C616EBF28FAC61E5E32@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1781786935.git.poros@redhat.com>
 <deef5756e534ef06c12d910c5305d3fd205d30a0.1781786935.git.poros@redhat.com>
In-Reply-To: <deef5756e534ef06c12d910c5305d3fd205d30a0.1781786935.git.poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPF6E320AF71:EE_
x-ms-office365-filtering-correlation-id: 6863dd65-58e8-4575-27c5-08decd52f441
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|38070700021|22082099003|11063799006|56012099006|18002099003|6133799003|4143699003;
x-microsoft-antispam-message-info: hbbiRCHMnAZAs0jvgdJA4KDZyyteR/nFNKDmsMxt1kchUhzBE8WKGSkbpXsgZ+kSgz5HgDr6WCNU8UhiSHaOpT7rTyefKnCHUnfmXrqus4WYOudCheQ8hgE6NPs6rKhWJFbQa26IMIK6SJ9JsP0i+/VS4tVEuBImyHitQk2fmTXr2+Muki0bmgW3zE/J2Mugri6TK5I+8MgvvLqHE+arckmxTVzi6b2wa7bUPECBVvVAk89Bp6GTZUBOZKZ2rGPl51uVi8ZSjNEb7jr4kwMN6cDnW7QJ0KkU58DUsX0kt36/5kQlpGisFECTo0BpeDr49MYRE48AOs3V/2mHHqwRm1mZ+YWL9diopD2z91Fxulg7fWhJxrcFw7B/xmaKOKUuojbRrJXxZhXSCizIGXN+WiBbFYQ43ziPNgEbZffjste2wfqL9ZdIWstWMc7bj0KcdACCjZbQdDeMMR0shYeMglaRsEo5Yuz3DZkSeGwRCJqakm+IHrjl5HZc1+9xJxbB9/27eNRKJry1skPs/aTuijvsla0ta/Hql1/sG/mhcKAA7oFsEXXE44wZVO+GaG9qeM5Y1KrG6MSSmT7+1YWekS5SaU88KTX8sttKxul6tQ7IdQJEzoY5Yu50KM6HX1++Vvg+QC25qvcQjBjfq4S6yiR1okbgoR+Ssaf2Th9X5pMsN5Uw21eeyI9W9lruGgSyqajKX8iseobr9kyDt1AWzrrbtNMEIImbnYA06jTfZP09v/EWbBpCygNFYaZjctbo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(38070700021)(22082099003)(11063799006)(56012099006)(18002099003)(6133799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ed/RwO2PD/ttTtJN59b9abtLf76Jdjgbpd3ahxzjqV1ssGGhho7kaSGuHm5Z?=
 =?us-ascii?Q?rVp7fhoMjCBVx5A+UwkW6t5WDStT6hx/HQfn8+gwGnxHcGe0axqZvHfYdXtO?=
 =?us-ascii?Q?/dcCYJzXbw/oUgCZ8Z4K89chtk7phZ90MJwMSoWlEeO/rPKFZ/deutXKyen/?=
 =?us-ascii?Q?eYzRRRA6gnppJpNe8HCOBfD007rFr1TgoqabZq05P0JVf9aUYdjss7asNM49?=
 =?us-ascii?Q?HrzCEOJWfl7j9+HNR6k3ejiAYqjr3kkq3KKoBG3RvrfukuXgNBfbBRD7aiaO?=
 =?us-ascii?Q?y9TQS2DWoGoZ1Tw1yPk6zYP+MjYMH1qhKi6Re4fGaXJv/I/+u1uBowrZhQDE?=
 =?us-ascii?Q?rV9ncvbBbV6tZnMMGXk/uXvEMMB5e193MUqdS2iVmv14yRjQX7nl+W09PgIN?=
 =?us-ascii?Q?u1rEqjLr7Nlgr2qw5b4IbpvVcRHPgXHIayI4oKvwmNj9SwtM6Y+6wk/8ClKF?=
 =?us-ascii?Q?ZZrXZXQ2UmxooBZhCF22NowmDkMTp4uHyXbaJmPjTteEzTs9fu5L7WKtQEOQ?=
 =?us-ascii?Q?XNTOLrDRFBCfU/AP7/4+TAGzYOeNAbf6WIXQyaOvMSTVhYPWQ8xM9W6+RwTY?=
 =?us-ascii?Q?d3htFaE383rFtmb19cnAdroWCwN75qVjBpnuRorupXnLYd4b1nK27QAe4JFF?=
 =?us-ascii?Q?dKd0le1mVQ+QzEU1U27nyu1W/ZeH5WbZPEWRgMrB56P0m4j2Q34oCOTo8m73?=
 =?us-ascii?Q?HzaY0m/XRJtdeOD23D1ct3bysljG0d1lU+q27IIMXpRV+wXoUPzDwkk/elVh?=
 =?us-ascii?Q?j0WvIa1kz5KmQgezBM18wlkBAgszv1pD4q1qJ4rJwfvhWoY46cTXDUi8RxhU?=
 =?us-ascii?Q?GP6AhXXHTQu4hUgkvTusJtn6cb5712Zp8ftFd64hDQjaHPnAKhnKXRCGkvOa?=
 =?us-ascii?Q?KxFEDD3m9L6+0GpOS+1i2oSicKCIq3PEaDcOjw7xQ5ZCEUcBAuVHxjU/5D5Z?=
 =?us-ascii?Q?9/JLlbAOamnmDm1B5OAlqbOGxAImoAIzxaS1AG8WID0ldgEPdx/KD5JIdGdn?=
 =?us-ascii?Q?oQIRQT3mAJfRCHzp8J2srbMOFed3UW3yJTti2S3WwbV/sLYnE++UUAdLdbhz?=
 =?us-ascii?Q?BTsyP8PcAIQqdjGMXKqDa0cRbk4X8ERQ6BE1HxbQkNVCxIC3AEB4jMLsjeQI?=
 =?us-ascii?Q?pBJ7o60qFeqqEr12vBIOU51ql+w7yQfqKqqCf7r90WrIG0lSE9tT2id9RKqi?=
 =?us-ascii?Q?N5k3Ena9mjDvuiu1t1mASDHFiXoTuyH62CxaY4T12ZQtGu9Se1bR4mF4INi+?=
 =?us-ascii?Q?O+RvfUjDw3SKNkzlnbVhpYRK6VBihgz56hZwvopX/MpafSELygIiEHzDJgJm?=
 =?us-ascii?Q?/M/TCYRUEpdzZhTahN4z5q7KyZai5tB2M6HlsoJOxseiLodxCd9ivq06Ym4G?=
 =?us-ascii?Q?hdN5pvAXiKhJWbrF3UT9QzNkfQ1RCGT1NiCyV39AdLM0sNCAd9M5kjUlU3S4?=
 =?us-ascii?Q?dd8Wmp9z1D6Cn/8TBlR5Yw5Q5ziYc7E9MRQSsSFA0necFnm1txP/FkVGbUMj?=
 =?us-ascii?Q?p9pbG32bXTi7cRjcwauJUnkR8d1Ul+6C/sLBBxBlA07yJj457ix8aYiDyZkA?=
 =?us-ascii?Q?5c0GOHQnFXYvKu9JNToF8Ig0QgiYPW/8f9z5yTifZVUeekRlVl272QUPEbxR?=
 =?us-ascii?Q?h4fGfZQnuhhUEpH3Ui4S6m25CkIBv8/Axzaj5TYbgT7gwfNwS3yYlNEIUrFD?=
 =?us-ascii?Q?LykaNXHnsQEPZCUAk8fq0WobE90186AHLEVX21hi1/4yGPnOfrcqL2ijmbU1?=
 =?us-ascii?Q?UGkNzewJraYFu6yZXwTozYx+f/gsLO8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A387DQsZLuamrXn+4qYvgeTBWXrQX9m5ZJ6HxM+NrUZT9/8UvfvVWPa4DuhioibnE+pQoFXTZPPK2C8uvo/r+6Srho5UpGMbbk0/aV51cpo1X59CS0C6xkOWTAX/sOIj+f3txTWeMaEiqKqCzhu1feKNffHEXxzrWLBw7zTo8o8OUtPhOmtM/wlQcEh96W/vr13mL6C16SLLMaSL6blyzNFlTJstwbqqc9mhfnfuWPc1frUy0OEHUu77zSfPEO228eIjzzFJMhQENxFtUmagiqGeiDe+Ff+ioUDTshWctZoV4Ed+rOEEvHzLA/BTGaMAI8LvNDXvusTsZcW4ygIYsA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6863dd65-58e8-4575-27c5-08decd52f441
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 16:02:10.2050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLvLcM0jc8h9Ikz3mPQ/Fd3mT9W+IjXJd+7gfBvKdXN90z7OG9Cx483/PzuJScAMQ7OaEgH9X370o2jsjRENrhcNvgk/SRXmFewKU9toDg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6E320AF71
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300484-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:poros@redhat.com,m:netdev@vger.kernel.org,m:ivecera@redhat.com,m:alice.michael@intel.com,m:przemyslaw.kitszel@intel.com,m:edumazet@google.com,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:michal.swiatkowski@linux.intel.com,m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:intel-wired-lan@lists.osuosl.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,IA3PR11MB8986.namprd11.prod.outlook.com:mid,davemloft.net:email,osuosl.org:email,intel.com:dkim,intel.com:email,intel.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D419A6A171F



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Petr Oros
> Sent: Thursday, June 18, 2026 5:09 PM
> To: netdev@vger.kernel.org
> Cc: Vecera, Ivan <ivecera@redhat.com>; Alice Michael
> <alice.michael@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Eric Dumazet <edumazet@google.com>;
> linux-kernel@vger.kernel.org; Andrew Lunn <andrew+netdev@lunn.ch>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>;
> intel-wired-lan@lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: preserve uplink
> DFLT Rx rule on switchdev release
>=20
> ice_eswitch_setup_env() calls ice_set_dflt_vsi() to install the
> ICE_SW_LKUP_DFLT Rx rule on the uplink VSI. The helper returns 0 even
> when the rule is already in place, so the call is a no-op if
> ice_vsi_sync_fltr() had previously installed the DFLT rule in response
> to IFF_PROMISC on the uplink netdev. ice_remove_vsi_fltr() called
> earlier in ice_eswitch_setup_env() does not affect this rule because
> ice_remove_vsi_lkup_fltr() lacks a case for ICE_SW_LKUP_DFLT and falls
> into its default branch which only logs. Switchdev mode then adds an
> ICE_FLTR_TX leg via ice_cfg_dflt_vsi() on the same VSI handle.
>=20
> ice_eswitch_release_env() unconditionally removed both the Rx and Tx
> DFLT rules. When the Rx DFLT was installed by ice_vsi_sync_fltr()
> before the switchdev session started, this clobbered promisc state the
> operator had asked for: the DFLT Rx rule disappeared while IFF_PROMISC
> was still set on the netdev, and the IFF_PROMISC sync path was not
> retriggered, so the uplink ended the session without the catch-all
> rule the netdev flags requested.
>=20
> Skip the Rx DFLT removal when the uplink is still promiscuous, both in
> ice_eswitch_release_env() and in the err_def_tx unwind of
> ice_eswitch_setup_env(). The Tx leg installed by switchdev is always
> removed since switchdev owns it.
>=20
> The ena_rx_filtering() call earlier in ice_eswitch_release_env() is
> left unconditional: it calls ice_cfg_vlan_pruning(), which returns
> without enabling pruning while the netdev is in IFF_PROMISC, so it
> cannot re-enable VLAN pruning under the preserved DFLT rule and drop
> tagged traffic. Pruning is re-enabled later, when the IFF_PROMISC sync
> path runs after promisc is actually cleared.
>=20
> Use vsi->current_netdev_flags rather than the live netdev->flags for
> this test. netdev->flags is written under RTNL by dev_change_flags(),
> while ice_eswitch_release_env() runs under devl_lock, so reading it
> here would be a TOCTOU against a concurrent promisc change. The
> IFF_PROMISC bit of current_netdev_flags is written only under
> ICE_CFG_BUSY by ice_vsi_sync_fltr(), and ice_set_rx_mode() gates that
> sync off for the uplink while ice_is_switchdev_running() is true. The
> bit is therefore frozen for the whole session and stable when
> release_env reads it.
>=20
> Because the sync is gated off during the session, a promisc change the
> operator makes while switchdev runs never reaches ice_vsi_sync_fltr():
> current_netdev_flags keeps the value captured before the session while
> netdev->flags carries the new one. Once switchdev is torn down and
> pf->eswitch.is_running is cleared, schedule a filter sync from
> ice_eswitch_disable_switchdev() so the suppressed change is replayed
> and the DFLT Rx rule is reconciled with the current netdev flags. This
> also closes the window where release_env kept the rule based on the
> frozen flag but the operator had since cleared IFF_PROMISC.
>=20
> Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 32 +++++++++++++++++--
> -
>  1 file changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 2e4f0969035f77..b6073fc2375019 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -66,8 +66,10 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
>  	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
>  			 ICE_FLTR_TX);
>  err_def_tx:
> -	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
> -			 ICE_FLTR_RX);
> +	/* keep the Rx DFLT rule if still promiscuous (see release_env)
> */
> +	if (!(uplink_vsi->current_netdev_flags & IFF_PROMISC))
> +		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
> +				 false, ICE_FLTR_RX);
>  err_def_rx:
>  	ice_vsi_del_vlan_zero(uplink_vsi);
>  err_vlan_zero:
> @@ -275,11 +277,23 @@ static void ice_eswitch_release_env(struct
> ice_pf *pf)
>  	vlan_ops =3D ice_get_compat_vsi_vlan_ops(uplink_vsi);
>=20
>  	ice_vsi_update_local_lb(uplink_vsi, false);
> +	/* No-op while IFF_PROMISC is set: ice_cfg_vlan_pruning() self-
> gates on
> +	 * it, so this cannot re-enable VLAN pruning under a preserved
> DFLT rule.
> +	 */
>  	vlan_ops->ena_rx_filtering(uplink_vsi);
>  	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
>  			 ICE_FLTR_TX);
> -	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
> -			 ICE_FLTR_RX);
> +
> +	/* Keep the Rx DFLT rule if the uplink is still promiscuous; it
> must
> +	 * outlive the session. current_netdev_flags is used because
> its
> +	 * IFF_PROMISC bit only changes under ice_vsi_sync_fltr(),
> gated off
> +	 * during switchdev, so the read cannot race the RTNL netdev-
> >flags.
> +	 * Any change made during the session is replayed on teardown.
> +	 */
> +	if (!(uplink_vsi->current_netdev_flags & IFF_PROMISC))
> +		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
> +				 false, ICE_FLTR_RX);
> +
>  	ice_fltr_add_mac_and_broadcast(uplink_vsi,
>  				       uplink_vsi->port_info-
> >mac.perm_addr,
>  				       ICE_FWD_TO_VSI);
> @@ -327,10 +341,20 @@ static int ice_eswitch_enable_switchdev(struct
> ice_pf *pf)
>   */
>  static void ice_eswitch_disable_switchdev(struct ice_pf *pf)  {
> +	struct ice_vsi *uplink_vsi =3D pf->eswitch.uplink_vsi;
> +
>  	ice_eswitch_br_offloads_deinit(pf);
>  	ice_eswitch_release_env(pf);
>=20
>  	pf->eswitch.is_running =3D false;
> +
> +	/* ice_set_rx_mode() was gated off during the session; replay a
> filter
> +	 * sync so any suppressed promisc change reconciles the DFLT Rx
> rule.
> +	 */
> +	set_bit(ICE_VSI_UMAC_FLTR_CHANGED, uplink_vsi->state);
> +	set_bit(ICE_VSI_MMAC_FLTR_CHANGED, uplink_vsi->state);
> +	set_bit(ICE_FLAG_FLTR_SYNC, pf->flags);
> +	ice_service_task_schedule(pf);
>  }
>=20
>  /**
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

