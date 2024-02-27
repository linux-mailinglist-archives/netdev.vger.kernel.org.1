Return-Path: <netdev+bounces-75287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 241A9868FA4
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F99DB26930
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC5513A86F;
	Tue, 27 Feb 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMyxs0rx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40B13A24E
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035497; cv=fail; b=ubiZO+9gDQlhOKZbiu4LtOWNj/uCrMUCWxHS3cHl7W8VUIMj/kNlVVIRWkn+svPIE79sNSQUUYDsj+YKf6NssXLnTNqvfnrEoxqZUEfeXWHJnCLqyCmIuwOA695hQ1Xo7cZUXSR/fATw6bL8odPIqvIKzOA52ybliz7Cd4URsXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035497; c=relaxed/simple;
	bh=VsICZEZ6j4ujaZM2ST4XZi3nOnMQT8NfynUBjzAlr5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aOzelBF1TugYZuQNDmKsNo+eLamrL2VXTnzZaz/gKKR7CWiPVozWFH9T/KHIAqIdq5DMif3PI3+jmt98xGs51+n4CSo1ix5rBFyKNC3nHUVo4dCSLzDzVCwbzMrPE/mN3HT09TUYriDiVbiUgClCxysVy9nWO6dLVb0kDf3AfbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMyxs0rx; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709035496; x=1740571496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VsICZEZ6j4ujaZM2ST4XZi3nOnMQT8NfynUBjzAlr5Y=;
  b=LMyxs0rxqasublh/EivTHETlAPzIYCLgD42/YFtg46Ww8TKF/rLbIwk9
   HTuc1b5Fz56RMTyDh4/fhVcnFSXJf/F2qieH8gBr4lqzOjjY+0BkO9pma
   CBO4Cq1MepxpRa2F1+6kfop4nXeIVVOrjga9A6ItBxq1rqAK8tZDfJ3wS
   Tk2s3uYzPRPWDd2v0qSI2r1LvnoXoCkqRT82tX+B31IK3CBz7c6gjESH6
   5m864kQFc+0vaehD5XW3/YabJ2Wqn0wAF7Bpp1yjGuLWxJGCGg8DPYtQV
   vLjEdjtGv/d5QgQui5lMeJvmWvVPxbIIRndwGNj6T0O4B6uI7QRYldJlP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20914271"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="20914271"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 04:04:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7572011"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 04:04:51 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 04:04:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 04:04:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 04:04:48 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 04:04:45 -0800
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by BL1PR11MB5304.namprd11.prod.outlook.com (2603:10b6:208:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 12:04:42 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7339.022; Tue, 27 Feb 2024
 12:04:42 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Neftin, Sasha" <sasha.neftin@intel.com>, "Gomes, Vinicius"
	<vinicius.gomes@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "kurt@linutronix.de" <kurt@linutronix.de>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, Jeff
 Kirsher <jeffrey.t.kirsher@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [iwl-net v2 2/2] igb: Fix missing time sync
 events
Thread-Topic: [Intel-wired-lan] [iwl-net v2 2/2] igb: Fix missing time sync
 events
Thread-Index: AQHaZFicYiO+YWPXJ0KsPZBJcKpe8LEeISfg
Date: Tue, 27 Feb 2024 12:04:42 +0000
Message-ID: <CYYPR11MB84294B0232543C809F7B060FBD592@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240220235712.241552-1-vinicius.gomes@intel.com>
 <20240220235712.241552-3-vinicius.gomes@intel.com>
In-Reply-To: <20240220235712.241552-3-vinicius.gomes@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|BL1PR11MB5304:EE_
x-ms-office365-filtering-correlation-id: 2d142c34-480f-4d50-720c-08dc378c4829
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JLPjFruzPyQr3KQL4TZBE1E3kaK1upS0/XCSKqDWG7EY4pBx16hFY1g62ufQA5ZlYQdoTb2f9S+39tDqYHeXV8u6CZEBH9YdwOLCS/JRKHv36YOtrVzQ6bKKxnHTjbzrMtWZmsZ6X+4sbAWCDATygtIDXFJk0LLLc2HKuhy2duu66obJT3wobBYkaPpOt0utdO9BrEzjGBuni2LtfI321hI+AMDGRs9ZxXSvE9MtuaYBDDhBP2sgFz8HVhm+jT2CPPf7zK71caHf1TevbqG8HORejtduU2T3j9XYts3yWsxPytB4RznK9PH509mTMehE2PtDuN5ih+Spzi1XWvesA0SXO9fsx5nWNnHdJSGIk+JR/FWzDyEr3bN2MUUx7DMwD/9vw2KgmdlkK2k0PMuwJibQ0Ef3Wp/V+cC0Tnd5cMHIi8Qjl1pEYXm2KmvhjGyNn9DrFpg3jfeHeqnl0jAJo2n33l7WBocXDZrZDcRJr6QbcrdApYmhpyTSIsGM6l3tjcQFCK88j986A5+BWhR0yZK1Fwufp/w2gGbh6vZVdSquHGLJqyTWNddy/Rdz+Z8zOBPYQsLRQBJgdUGB2oNtAzbMcT2IV1DVtZasTmBNgJmdQ7qCXGZA6YLikyXvFLwtuZl4KTsbRs+04psk++L+/NdZNxkai8I6sXx4qbA0c5RKwSKr9zaOfcIbef+uXSIHl699J6FYi/Ay3LjK1Qt0CA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R8639r3p4zMkUT/kKTtUPi43jl8aWRnJpzE9ucccPgWlLQszIalnjkDeqdF4?=
 =?us-ascii?Q?w7Qr/CtBEhP4QiMRPok5xvZxR4f4nWUq8CQ+pPnxF4LkClsO9uWjyTdFHDkQ?=
 =?us-ascii?Q?M42Mi6O5zXvzctSWTWafJXnQPJlsJdnMhlvnD6rtSTU8GT7W38uT7LSD+pjz?=
 =?us-ascii?Q?tetD9nO9+cmiWUYNzk1NJsa9N2iJWHZ6rKvUv16dgl+ALayI2LmSqppn0v2N?=
 =?us-ascii?Q?ubAt9ZlLUI3q9ClER6wVoPM207P1EGQ5SdA/imtAztijF0tYpsf2Ytj9pUTt?=
 =?us-ascii?Q?li2lXvHGCV/t6xB9M9qxJyfqAS/5ftqQJxe00gqstrbTxnkcJlLqSCnuDJfB?=
 =?us-ascii?Q?YRjmnlrO+uqpfIXfHhCQNm+rKEzjfBUjiuesARjorY+XS6gRqB2BRnjNd0b/?=
 =?us-ascii?Q?WUFshprocSq1Dt5dJsy2a/Si+doiT5dUanaC9rr+m4MN01aCgbFrYufbF5dB?=
 =?us-ascii?Q?qIgNVeV39yMLwciLR51kZ57qtJOEK5IA/q6AEsmU1D4UQSnFCDGY2QXZDWCE?=
 =?us-ascii?Q?mznNM99ACDK82AicDDw2JvMKFAmOECr9sR0V7IDR9rT9JIdylgTqMTo8bNYA?=
 =?us-ascii?Q?vt6a8gRxQdElWUKT9BHqCE3GjQX5LVYbyo8smDE4mCVIRNzRdqJoXc1We453?=
 =?us-ascii?Q?A9772Z9GWjfi4nOomBglK5mmPP+/N9+ApTBSncerskRPBbj0AkjfjPYUxArA?=
 =?us-ascii?Q?2ZbScWtM5Gp3Irea6ehFyivw0UdFuPInwUXEs2bBYHTFsXc6866ql7zdBtJ3?=
 =?us-ascii?Q?ZWUDzShmm8pWqwGT/n/Rba8m0HAar7Q+QvbOHvFt2M6fwAMNw4VOJqx0oZgj?=
 =?us-ascii?Q?XMH0zGj5F7D4YX12LA4wm0MYwezsmbuBGkWHjJzK069gMm8WgZMkjLFf02mX?=
 =?us-ascii?Q?zlBYoRFCNfQm8I6cmn12YDDjqacS0WwpxD8uVGjv7AD3TH8R2pHjsxAfapoy?=
 =?us-ascii?Q?+qG4RhpOuevPi9ZUFCRc4XNrir6qibcyPuH5EglgT/aRCUeqO18mwtWoNda/?=
 =?us-ascii?Q?makwEhv2Uj1YZU4SQyiODJQlXGhSM6S1nB5xfvLSHv0fFiLo+07UXiqTM89l?=
 =?us-ascii?Q?2FQy6ZmVsQI4LYrT23N7cCX6+ss6IO5VTXkbJEM89ef3Bg3OcWLMrYP+z2Qm?=
 =?us-ascii?Q?cRsapIKg/l6WHdOpd9YyHFnRhqHGi16jjqWwwxUch7IwPDwBLh8W4Vrsc4TI?=
 =?us-ascii?Q?Ml4Td9F0LGI2mKdxd90iBoH6nCdHCb/UcOGeH3mA1YxhSmoNfrNQBiAP/Cgo?=
 =?us-ascii?Q?yb/UujoBPDssVdeB6oKAR+885Dv7G0tXbTUIVTUhI5g8E+QsYG4hE86D2uvX?=
 =?us-ascii?Q?8BABrHL8R7gWAM/LmaZGpQUhetg1e6pTOanBCbHx5n81lGcXAjd7fvx/HiDq?=
 =?us-ascii?Q?hXFDOXReOXlxWzHZp4/HZ5S3oppaOoOsLDs0NB7vFJOKxhjdIy8gvHBXMLIu?=
 =?us-ascii?Q?lrGzKiz0gSpmDpuWeDQuNKcUOMzwXlok6xZEuQ/yWe7azNYfqhgo35FSBJAu?=
 =?us-ascii?Q?jngCpPlFysiyHsuim0Uv5BHw3tbuS8IzPK+nWw6X5zQDH7/8DI0S+hlPdZmE?=
 =?us-ascii?Q?Gf/iZegwP0FJX9B1w0HrfjU3pM2MsIuKv3wvzJQJ7oUaJnmgntZsESZExTjE?=
 =?us-ascii?Q?UA=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YK+1TtxpbU/nRtd+xim3QVgCtJMRHiTtM3Z6iEj+hy1803IWx7QW4y1ji/ynHTPvDuxTw3bgCyw66YQ24LGI/2/TWfg+yAXLOPHW00S2Qe3XUBb0MFQL+fQ/QFp5qK/yZrd3jH2CBDX1U+apj+VrjfvDvW7gr/ARlp4Xuhh1i5wcOZ1pcI5GdO1uk8OUAFXlOympDoYvSykruQt8Ts/CJoojs12SmKEQy+Ga1Ghl1sgfveSuQnQWPWu0Kb6MgiECwf2f8JWFgqvanNSTA/FhQDpNdGJPOgnoV3YybJeilhzdfYScb1DXuct5H5E+XyyTxFODMDOnH9zReUMO5QIzgQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDvkJ3r5dprhbwGyI7T5J5LpRw1E4Z7mPaaMutfwAwY=;
 b=XvSQgp8uzrBT33a3j3emu7L1naZLpJC0fqLiSDrRoD13Y9n4MathWD5h3M8GfeJNw+mqGrvMJeMWbcC7zqo4g7QjMfbtmPNl3YfxZaT2ZEBaRRKPed9CgnMOAXmglSJn6Bh4k2IXK4WzcHPqBB28seJE6bMR/uMkIMTseEssC5D5LQTvCq5ewvQtI7ZN7pEKm6spYN70wtFvO8LtL/a2+9XFWbp26RP+1z94mIEj5XtOmCu6AxAE/KS1g6pHCA71+CjtqIP6RRYd8P7ddchDWG6pqh4KaELFA41xWU2bOhIRtjXwjvmpXwHYzQ3m2/lZgzBT0NF8YnAQgUeXYqcT8Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CYYPR11MB8429.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 2d142c34-480f-4d50-720c-08dc378c4829
x-ms-exchange-crosstenant-originalarrivaltime: 27 Feb 2024 12:04:42.4937 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: AsR/tFEIxvw0B4kYc00/EKG86uZTFUCSNSOna2CHy6ijMPcon8CcqptNp8/SA1RnXNRfQlS7Q2UNYxf5wGInPMZmxL56W8f6U8+wlO81cgddaN3mqCR3bxU3aHtqLquy
x-ms-exchange-transport-crosstenantheadersstamped: BL1PR11MB5304
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of V=
inicius Costa Gomes
> Sent: Wednesday, February 21, 2024 5:27 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Neftin, Sasha <sasha.neftin@intel.com>; Gomes, Vinicius <vinicius.gom=
es@intel.com>; netdev@vger.kernel.org; richardcochran@gmail.com; kurt@linut=
ronix.de; Brandeburg, Jesse <jesse.brandeburg@intel.com>; linux-kernel@vger=
.kernel.org; Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L <anthony=
.l.nguyen@intel.com>; Jeff Kirsher <jeffrey.t.kirsher@intel.com>; Jakub Kic=
inski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller <=
davem@davemloft.net>
> Subject: [Intel-wired-lan] [iwl-net v2 2/2] igb: Fix missing time sync ev=
ents
>
> Fix "double" clearing of interrupts, which can cause external events
> or timestamps to be missed.
>
> The E1000_TSIRC Time Sync Interrupt Cause register can be cleared in two
> ways, by either reading it or by writing '1' into the specific cause
> bit. This is documented in section 8.16.1.
>
> The following flow was used:
>     1. read E1000_TSIRC into 'tsicr';
>     2. handle the interrupts present into 'tsirc' and mark them in 'ack';
>     3. write 'ack' into E1000_TSICR;
>
> As both (1) and (3) will clear the interrupt cause, if the same
> interrupt happens again between (1) and (3) it will be ignored,
> causing events to be missed.
>
> Remove the extra clear in (3).
>
> Fixes: 00c65578b47b ("igb: enable internal PPS for the i210")
> Acked-by: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


